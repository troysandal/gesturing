#import <Cocoa/Cocoa.h>

@class CVPath;

@interface CVPolyView : NSControl {
	CVPath *path;
	BOOL fitToView;
	id target;
	SEL action;
}

@property (readwrite, retain) CVPath *path;
@property (readwrite) BOOL fitToView;
@property (readwrite, assign) id target;
@property (readwrite) SEL action;

@end
