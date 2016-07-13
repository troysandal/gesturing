#import "CVPath.h"


@implementation CVPath

@synthesize bounds;

- (id)init {
	if (self = [super init]) {
		points = [[NSMutableArray alloc] init];
		bounds = NSZeroRect;
	}
	return self;
}

- (id)initFromOther:(CVPath *)other {
	if (self = [super init]) {
		points = [[other points] mutableCopy];
		bounds = [other bounds];
	}
	return self;
}

- (id)initFromPoints:(NSPoint *)rawPoints withCount:(int)count {
	if (self = [self init]) {
		for (int i = 0 ; i < count ; i++)
			[self addPoint:rawPoints[i]];
	}
	return self;
}

- (void)dealloc {
	[points release];
	[super dealloc];
}

- (NSArray *) points {
	return points;
}

- (void) addPoint:(NSPoint)point {
	// Add this point to the array.
	NSValue *value = [NSValue valueWithPoint:point];
	[points addObject:value];
	
	// Update the bounds for the point.
	
	if ([points count] == 1) {
		// First point in path, treat as a single point in space.
		bounds.origin = point;
		bounds.size.width = 1;
		bounds.size.height = 1;
		return;
	}
	
	if (NSPointInRect(point, bounds))
		return;
	
	if (point.x < bounds.origin.x) {
		CGFloat delta = bounds.origin.x - point.x;
		bounds.origin.x = point.x;
		bounds.size.width += delta;
	}
	else if (point.x > NSMaxX(bounds)) {
		bounds.size.width += (point.x - NSMaxX(bounds));
	}
	
	if (point.y < bounds.origin.y) {
		CGFloat delta = bounds.origin.y - point.y;
		bounds.origin.y = point.y;
		bounds.size.height += delta;
	}
	else if (point.y > NSMaxY(bounds)) {
		bounds.size.height += (point.y - NSMaxY(bounds));
	}
}


- (void) addXYPoint:(CGFloat)x y:(CGFloat)y {
	[self addPoint:NSMakePoint(x, y)];
}


/**
 * Moves the origin of the path to (0,0)
 */
- (void)normalize {
	// No points?  Nothing to do.
	if ([points count] == 0) return;
	
	// Offset is - of current origin
	NSPoint offset = NSMakePoint(-bounds.origin.x, -bounds.origin.y);
	
	// No offsets, we are done.
	if (!offset.x && !offset.y) return;
	
	// Add offset to each point.
	for (int i = 0 ; i < [points count] ; i++) {
		NSPoint p = [[points objectAtIndex:i] pointValue];
		p.x += offset.x;
		p.y += offset.y;
		[points replaceObjectAtIndex:i withObject:[NSValue valueWithPoint:p]];
	}
	
	// Move origin to 0,0
	bounds.origin = NSMakePoint(0, 0);
}

- (void)fitToSize:(NSSize)size withStretch:(BOOL)stretch {
	// Need at least a segment to resize.
	if ([points count] < 2) return;

	CGFloat mx = size.width  / bounds.size.width;
	CGFloat my = size.height / bounds.size.height;
	CGFloat minX = bounds.origin.x;
	CGFloat maxX = minX;
	CGFloat minY = bounds.origin.y;
	CGFloat maxY = minY;
	
	if (!stretch)
		mx = my = MIN(mx, my);

	// Add offset to each point.
	// TBD - to expand from the origin versus (what, center?) subtract the origin before multiplying
	for (int i = 0 ; i < [points count] ; i++) {
		NSPoint p = [[points objectAtIndex:i] pointValue];
		
		p.x = mx * p.x;
		p.y = my * p.y;
		
		minX = MIN(minX, p.x);
		maxX = MAX(maxX, p.x);
		minY = MIN(minY, p.y);
		maxY = MAX(maxY, p.y);
		
		[points replaceObjectAtIndex:i withObject:[NSValue valueWithPoint:p]];
	}

	// Fix new width/height
	bounds.origin = NSMakePoint(minX, minY);
	bounds.size   = NSMakeSize(maxX - minX, maxY - minY);
}



- (CGFloat)pathLength {
	// We want at least 2 points.
	if ([points count] < 2) return 0;
	
	CGFloat length = 0;
	
	for (int i = 0 ; i < [points count] - 1 ; i++) {
		NSPoint p1 = [[points objectAtIndex:i] pointValue];
		NSPoint p2 = [[points objectAtIndex:i + 1] pointValue];
		CGFloat dx = p2.x - p1.x;
		CGFloat dy = p2.y - p1.y;
		CGFloat segmentLength = sqrt(dx*dx + dy*dy);
		length += segmentLength;
	}
	
	return length;
}

- (NSMutableArray *)segments {
	NSMutableArray *segments = [[[NSMutableArray alloc] init] autorelease];
	
	// We want at least 2 points.
	if ([points count] < 2) return segments;
	
	CGFloat dx, dy;
	Segment segment;
	
	for (int i = 0 ; i < [points count] - 1 ; i++) {
		segment.begin = [[points objectAtIndex:i] pointValue];
		segment.end = [[points objectAtIndex:i + 1] pointValue];
		dx = segment.end.x - segment.begin.x;
		dy = segment.end.y - segment.begin.y;
		segment.length = sqrt(dx*dx + dy*dy); 
		segment.width = segment.end.x - segment.begin.x;
		segment.height = segment.end.y - segment.begin.y;

		[segments addObject:[NSValue valueWithSegment:segment]];
	}
	
	return segments;
}

- (id)copy {
	return [self mutableCopy];
}

- (id)mutableCopy {
	return [[CVPath alloc] initFromOther:self];
}

@end


@implementation NSValue (SegmentExtension)
+ (NSValue *)valueWithSegment:(Segment)segment {
	return [NSValue valueWithBytes:&segment objCType:@encode(Segment)];
}

- (Segment)segmentValue {
	Segment segment;
	[self getValue:&segment];
	return segment;
}
@end
