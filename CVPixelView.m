#import "CVPixelView.h"
#import "CVPath.h"

@implementation CVPixelView


- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        rows = 10;
		columns = 10;
		polygon = nil;
    }
    return self;
}

- (void)drawRect:(NSRect)rect {
	NSRect bounds = [self bounds];
	
	[[NSColor blackColor] setFill];
	
	int h = (bounds.size.height - (rows + 1)) / rows;
	int w = (bounds.size.width - (columns + 1)) / columns;
	NSRect r;
	
	for (int row = 0 ; row < rows ; row++) {
		for (int column = 0 ; column < columns ; column++) {
			r = NSMakeRect(column * (w + 1), row * (h + 1), w + 2, h + 2);
			NSFrameRectWithWidth(r, 1);
		}
	}
}

- (void)drawRecty:(NSRect)rect {
	NSRect bounds = [self bounds];
	
	int h = (bounds.size.height - (rows + 1)) / rows;
	int w = (bounds.size.width - (columns + 1)) / columns;
	
	[NSBezierPath setDefaultLineWidth:0];
	
	for (int row = 0 ; row < rows ; row++) {
		for (int column = 0 ; column < columns ; column++) {
			[NSBezierPath strokeRect:NSMakeRect(column * (w + 1), row * (h + 1), w + 2, h + 2)];
		}
	}
}

- (void)drawRectx:(NSRect)rect {
	NSRect bounds = [self bounds];
	
	CGFloat h = (bounds.size.height - (rows + 1)) / rows;
	CGFloat w = (bounds.size.width - (columns + 1)) / columns;
	
	for (CGFloat row = 0 ; row <= rows ; row++) {
		[NSBezierPath strokeLineFromPoint:NSMakePoint(0, row * (h + 1)) toPoint:NSMakePoint(bounds.size.width, row * (h + 1))];
	}
	
	for (CGFloat column = 0 ; column <= columns ; column++) {
		[NSBezierPath strokeLineFromPoint:NSMakePoint(column * (w + 1), 0) toPoint:NSMakePoint(column * (w + 1), bounds.size.height)];
	}
}

@end
