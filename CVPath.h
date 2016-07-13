/**
 * Precomputed path segments with length.
 */
typedef struct {
	CGFloat length;
	CGFloat width;
	CGFloat height;
	NSPoint begin;
	NSPoint end;
} Segment;


@interface CVPath : NSObject {
	NSMutableArray *points;
	NSRect  bounds;
}

- (NSArray *) points;
@property (readonly) NSRect bounds;

- (id)initFromPoints:(NSPoint *)rawPoints withCount:(int)count;
- (void)addPoint:(NSPoint)point;
- (void)addXYPoint:(CGFloat)x y:(CGFloat)y;
- (void)normalize;
- (void)fitToSize:(NSSize)size withStretch:(BOOL)stretch;
- (CGFloat)pathLength;
- (NSMutableArray *)segments;

- (id)copy;
- (id)mutableCopy;

@end


/**
 * Category extension to NSValue for Segment.
 */
@interface NSValue (SegmentExtension)
+ (NSValue *)valueWithSegment:(Segment)segment;
- (Segment)segmentValue;
@end


