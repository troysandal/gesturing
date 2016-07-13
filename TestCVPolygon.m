#import "TestCVPolygon.h"
#import "CVPath.h"


@implementation TestCVPolygon

- (void)testEmpty {
	CVPath *poly;
	
	poly = [[CVPath alloc] init];
	NSArray *points = [poly points];
	STAssertNotNil(points, @"Points are null");
	STAssertTrue([points count] == 0, @"Should be zero points");
	[poly release];
}

@end
