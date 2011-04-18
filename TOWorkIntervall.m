//
//  TOWorkIntervall.m
//  WorkCounter
//
//  Created by Tobias Ottenweller on 4/17/11.
//  Copyright 2011. All rights reserved.
//

#import "TOWorkIntervall.h"


@implementation TOWorkIntervall


@synthesize startDate = start, endDate = end;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder
{
    [super init];
    
    start = [[decoder decodeObjectForKey:@"startDate"] retain];
    end = [[decoder decodeObjectForKey:@"endDate"] retain];
    
    return self;
}

- (void)dealloc
{
    [start release];
    [end release];
    
    [super dealloc];
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:start forKey:@"startDate"];
    [encoder encodeObject:end forKey:@"endDate"];
}

- (unsigned long)timeWorked 
{    
    if (!start)
        return 0;
    
    if (!end)
        return (unsigned long)[[NSDate date] timeIntervalSinceDate:start];
    
    return (unsigned long)[end timeIntervalSinceDate:start];
}

- (BOOL)isRunning
{
    if (start && !end)
        return YES;
    
    return NO;
}

- (void)start
{
    start = [[NSDate date] retain];
}

- (void)end
{
    if (!end)
        end = [[NSDate date] retain];
}



@end
