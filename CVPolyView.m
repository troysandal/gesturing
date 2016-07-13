#import "CVPolyView.h"
#import "CVPath.h"


@implementation CVPolyView

@synthesize path;
@synthesize fitToView;
@synthesize target;
@synthesize action;

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
	
    if (self) {
        path = nil;
		target = nil;
		action = nil;
		fitToView = false;
    }
    return self;
}


- (void) dealloc {
	[path release];
	[super dealloc];
}

- (void)drawRect:(NSRect)rect {
	NSRect bounds = [self bounds];
	[[NSColor blackColor] setFill];
	NSFrameRectWithWidth(bounds, 1);
	
	if (fitToView) {
		NSAffineTransform* xform = [NSAffineTransform transform];
		CGFloat mx = bounds.size.width  / [path bounds].size.width;
		CGFloat my = bounds.size.height / [path bounds].size.height;
		[xform scaleXBy:MIN(mx, my) yBy:MIN(mx, my)];
		[xform concat];
	}
	
	
	NSArray *pts = [path points];
	if ([pts count] < 2) return;
	
	for (int i = 0 ; i < [pts count] - 1; i++) {
		NSPoint p1 = [[pts objectAtIndex:i] pointValue];
		NSPoint p2 = [[pts objectAtIndex:i + 1] pointValue];
		
		[NSBezierPath strokeLineFromPoint:p1 toPoint:p2];
	}
}


@end
