//
//  TOWorkCounterDocument.h
//  WorkCounter
//
//  Created by Tobias Ottenweller on 4/17/11.
//
//

#import <Cocoa/Cocoa.h>
@class  TOWorkIntervall;

@interface TOWorkCounterDocument : NSDocument <NSTableViewDataSource> {
  @private
    NSMutableArray *intervalls;
    TOWorkIntervall *currentIntervall;
    NSTimer *timer;
    
    IBOutlet NSTextField *currentTimeWorked;
    IBOutlet NSTextField *totalTimeWorked;
    IBOutlet NSTableView *tableView;
    IBOutlet NSButton *startStopButton;
    
}
@property(readonly) NSString *totalTime;
@property(readonly) NSString *currentTime;


- (IBAction)beginEndIntervall:(id)sender;
- (IBAction)safeAsCSV:(id)sender;
- (void)syncUI;

@end
