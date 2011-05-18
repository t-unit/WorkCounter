//
//  TOWorkIntervall.m
//  WorkCounter
//
//  Created by Tobias Ottenweller on 4/17/11.
//
//

#import "TOWorkIntervall.h"


@implementation TOWorkIntervall


@synthesize startDate = start, endDate = end;


#pragma mark class methods
+ (NSString *)intervallsToCSV:(NSArray *)intervalls
{
    NSMutableString *csv = [[NSMutableString alloc] init ];
    
    [csv appendString:@"start,end,time_worked\n"];
    
    for (TOWorkIntervall *wi in intervalls)        
        [csv appendFormat:[NSString stringWithFormat:@"%@,%@,%@\n", [wi startDate], 
                                                                    [wi endDate], 
                                                                    [TOWorkIntervall secondsToString:[wi timeWorked]]]];
    
    return [csv autorelease];
}

+ (NSString *)secondsToString:(unsigned long)seconds
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


#pragma mark instance methods
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
    return start && !end;
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
