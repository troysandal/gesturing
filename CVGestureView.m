#import "CVGestureView.h"
#import "CVPath.h"

@implementation CVGestureView

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
	
    if (self) {
    }
    return self;
}



- (void)mouseDown:(NSEvent *)event {
	[path release];
	path = [[CVPath alloc] init];

	NSPoint p = [event locationInWindow];
	NSPoint curPoint = [self convertPoint:p fromView:nil];
	[path addPoint:curPoint];

	NSLog(@"Drawing Started at %@", NSStringFromPoint(curPoint));
	[self setNeedsDisplay:YES];
}

- (void)mouseUp:(NSEvent *)event {
	NSPoint p = [event locationInWindow];
	NSPoint curPoint = [self convertPoint:p fromView:nil];
	[path addPoint:curPoint];

	[self setNeedsDisplay:YES];
	[self sendAction:[self action] to:[self target]];
}

- (void)mouseDragged:(NSEvent *)event {
	NSPoint p = [event locationInWindow];
	NSPoint curPoint = [self convertPoint:p fromView:nil];
	[path addPoint:curPoint];
	
	[self setNeedsDisplay:YES];
}

@end
