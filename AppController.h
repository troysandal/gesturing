#import <Cocoa/Cocoa.h>

@class CVGestureView;
@class CVPixelView;
@class CVPolyView;

@interface AppController : NSObject {
    IBOutlet NSTextField *match;
    IBOutlet CVGestureView *gestureView;
    IBOutlet CVPixelView *pixelView;
    IBOutlet NSTextField *pointLog;
    IBOutlet CVPolyView *smoothedView;
    IBOutlet CVPolyView *normalizedView;
    IBOutlet NSTextField *time;
}
- (IBAction)gesture:(id)sender;
@end
