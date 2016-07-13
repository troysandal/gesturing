#import "CVPathWalker.h"
#import "CVPath.h"


@implementation CVPathWalker

- (id)initWithPath:(CVPath *)path {
	if (self = [super init]) {
		segmentIndex = 0;
		intoSegment = 0;
		[self segmentsFromPath:path];
	}
	return self;
}

- (void)dealloc {
	[segments release];
	[super dealloc];
}

- (void)segmentsFromPath:(CVPath *)path {
	segments = [path segments];
	[segments retain];
}

- (NSPoint)beginPoint {
	if ([segments count])
		return [[segments objectAtIndex:0] segmentValue].begin;
	return NSZeroPoint;
}

- (NSPoint)walk:(CGFloat)distance {
	// If at end just return zero point
	if ([self end])
		return NSZeroPoint;

	Segment segment;
	
	while (segmentIndex < [segments count]) {
		segment = [[segments objectAtIndex:segmentIndex] segmentValue];
		
		// if space left in current segment use it
		if (distance < (segment.length - intoSegment)) {
			intoSegment += distance;
			CGFloat d = intoSegment / segment.length;
			return NSMakePoint(
				segment.begin.x + d * segment.width,
				segment.begin.y + d * segment.height);
		}
		else if (distance == (segment.length - intoSegment)) {
			segmentIndex++;
			intoSegment = 0;
			return segment.end;
		}
		else {
			// Move to next segment
			distance -= (segment.length - intoSegment);
			segmentIndex++;
			intoSegment = 0;
		}
	}
	
	// If we get here we walked off the end of the path so just give back the end point.
	intoSegment = 0;
	return segment.end;
}

- (BOOL)end {
	return segmentIndex == [segments count];
}


@end
