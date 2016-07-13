@class CVPath;

@interface CVPathWalker : NSObject {
	int segmentIndex;
	NSMutableArray *segments;
	CGFloat intoSegment;
}

- (id)initWithPath:(CVPath *)path;
- (void)segmentsFromPath:(CVPath *)path;
- (NSPoint)beginPoint;
- (NSPoint)walk:(CGFloat)distance;
- (BOOL)end;

@end
