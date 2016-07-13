#import "CVPatternEngine.h"
#import "CVPath.h"
#import "CVPatternDelta.h"
#import "CVPathNormalizer.h"

@implementation CVPatternEngine

+ (char)bestMatchFromPath:(CVPath *)path {
	path = [path mutableCopy];
	[path normalize];
	CVPatternDelta *p = [CVPatternDelta deltaWithPath:[CVPathNormalizer smooth:path withSegments:30]];
	[path release];
	return [p bestMatch];
}

@end
