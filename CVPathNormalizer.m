#import "CVPathNormalizer.h"
#import "CVPath.h"
#import "CVPathWalker.h"

@implementation CVPathNormalizer

+ (CVPath *)smooth:(CVPath *)path withSegments:(int)segments {
	// Check Parameters
	if (path == nil)
		return nil;
	
	if (segments <= 0)
		return nil;
	
	// Compute walking distance for new poly
	CVPath *result = [[[CVPath alloc] init] autorelease];
	CGFloat distance = [path pathLength] / segments;
	
	// Walk the path and compute the new points at each distance.
	CVPathWalker * walker = [[CVPathWalker alloc] initWithPath:path];
	[result addPoint:[walker beginPoint]];

	while (![walker end]) {
		[result addPoint:[walker walk:distance]];
	}
	
	[walker release];
	return result;
}

@end
