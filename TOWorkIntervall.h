//
//  TOWorkIntervall.h
//  WorkCounter
//
//  Created by Tobias Ottenweller on 4/17/11.
//  
//

#import <Foundation/Foundation.h>


@interface TOWorkIntervall : NSObject <NSCoding> {
  @private
    NSDate *start;
    NSDate *end;
    
    NSMutableArray *comments;
}
@property(readonly) NSDate *startDate;
@property(readonly) NSDate *endDate;
@property(readonly) unsigned long timeWorked;
@property(readonly) BOOL isRunning;


+ (NSString *)intervallsToCSV:(NSArray *)intervalls;
+ (NSString *)secondsToString:(unsigned long)seconds;

- (void)start;
- (void)end;


@end
