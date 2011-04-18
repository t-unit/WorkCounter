//
//  TOWorkCounterDocument.m
//  WorkCounter
//
//  Created by Tobias Ottenweller on 4/17/11.
//  Copyright 2011. All rights reserved.
//

#import "TOWorkCounterDocument.h"
#import "TOWorkIntervall.h"

@implementation TOWorkCounterDocument

- (id)init
{
    self = [super init];
    if (self) {
        intervalls = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSString *)windowNibName
{
    return @"TOWorkCounterDocument";
}

- (void)windowControllerDidLoadNib:(NSWindowController *)aController
{
    [super windowControllerDidLoadNib:aController];
    [tableView reloadData];
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError 
{
    if (currentIntervall)
        [self beginEndIntervall:nil];
    
    return [NSKeyedArchiver archivedDataWithRootObject:intervalls];
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError 
{
    NSMutableArray *newArray = nil;
    
    @try {
        newArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    @catch (NSException *exception) {
        if (outError) {
            NSDictionary *dic = [NSDictionary dictionaryWithObject:@"The data is corrupted." forKey:NSLocalizedFailureReasonErrorKey];
            *outError = [NSError errorWithDomain:NSOSStatusErrorDomain code:unimpErr userInfo:dic];
        }
        return NO;
    }

    intervalls = [newArray retain];
    
    return YES;
}

- (NSString *)totalTime
{
    unsigned long totalTime = 0;
    
    for (TOWorkIntervall *i in intervalls)
        totalTime += i.timeWorked;
    
    if (currentIntervall)
        totalTime += currentIntervall.timeWorked;
    
    return [self secondsToString:totalTime];
}

- (NSString *)currentTime 
{
    unsigned long totalTime = 0;
    if (currentIntervall)
        totalTime = currentIntervall.timeWorked;
    
    return [self secondsToString:totalTime];
}

- (NSString *)secondsToString:(unsigned long)seconds
{
    unsigned long hours = 0, minutes = 0;
    
    while (seconds > 59) {
        minutes++;
        seconds -= 60;
    }
    while (minutes > 59) {
        hours++;
        minutes -= 60;
    }
    
    return [NSString stringWithFormat:@"%02d:%02d:%02d", hours, minutes, seconds];
}


- (IBAction)beginEndIntervall:(id)sender 
{
    [self updateChangeCount:NSChangeDone];
    
    if (currentIntervall) 
    {
        [currentIntervall end];
        [intervalls addObject:currentIntervall];
        [currentIntervall release];
        currentIntervall = nil;
        
        [tableView reloadData];
        
    } 
    else 
    {
        currentIntervall = [[[TOWorkIntervall alloc] init] retain];
        [currentIntervall start];
        
        [self performSelectorInBackground:@selector(syncUI) withObject:nil];
    }
}

- (void)syncUI
{
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    [self willChangeValueForKey:@"currentTime"];
    [self didChangeValueForKey:@"currentTime"];
    
    [self willChangeValueForKey:@"totalTime"];
    [self didChangeValueForKey:@"totalTime"];
    
    [pool drain];
    if (currentIntervall) {
        sleep(1);
        [self syncUI];
    }
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView
{
    return [intervalls count];
}

- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex
{
    NSString *identifier = [aTableColumn identifier];
    
    if ([identifier isEqual:@"dateColumn"] || [identifier isEqual:@"startColumn"])
    {
        return [[intervalls objectAtIndex:rowIndex] startDate];
    }
    else if ([identifier isEqual:@"endColumn"])
    {
        return [[intervalls objectAtIndex:rowIndex] endDate];
    }
    else if ([identifier isEqual:@"timeColumn"])
    {
        unsigned long totalTime = [[intervalls objectAtIndex:rowIndex] timeWorked];
        
        return [self secondsToString:totalTime];
    }
    
    return @"";
}
@end
