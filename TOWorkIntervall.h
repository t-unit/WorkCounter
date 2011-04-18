//
//  TOWorkIntervall.h
//  WorkCounter
//
//  Created by Tobias Ottenweller on 4/17/11.
//  Copyright 2011. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TOWorkIntervall : NSObject <NSCoding> {
@private
    NSDate *start;
    NSDate *end;
}
@property(readonly) NSDate *startDate;
@property(readonly) NSDate *endDate;
@property(readonly) unsigned long timeWorked;
@property(readonly) BOOL isRunning;

- (void)start;
- (void)end;

@end
