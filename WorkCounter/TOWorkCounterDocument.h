//
//  TOWorkCounterDocument.h
//  WorkCounter
//
//  Created by Tobias Ottenweller on 4/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class  TOWorkIntervall;

@interface TOWorkCounterDocument : NSDocument <NSTableViewDataSource> {
  @private
    NSMutableArray *intervalls;
    TOWorkIntervall *currentIntervall;
    
    IBOutlet NSTextField *currentTimeWorked;
    IBOutlet NSTextField *totalTimeWorked;
    IBOutlet NSTableView *tableView;
    IBOutlet NSButton *startStopButton;
    
}
@property(readonly) NSString *totalTime;
@property(readonly) NSString *currentTime;


- (IBAction)beginEndIntervall:(id)sender;

- (NSString *)secondsToString:(unsigned long)seconds;
- (void)syncUI;

@end
