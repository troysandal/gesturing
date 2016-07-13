#import <Cocoa/Cocoa.h>

@class CVPath;

@interface CVPixelView : NSView {
	int rows;
	int columns;
	CVPath *polygon;
}

@end
