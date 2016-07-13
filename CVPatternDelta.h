@class CVPath;

typedef struct {
	char c;
	CGFloat rank;
} PatternComparison;


@interface CVPatternDelta : NSObject {
	NSMutableArray *segments;
}

@property (readonly) NSMutableArray *segments;

+ (CVPatternDelta *)deltaWithPath:(CVPath *)path;
+ (void)loadPatterns;

- (NSString *)pointString;
- (NSString *)deltaString;
- (NSString *)resultString;
- (char)bestMatch;
- (NSArray *)compareToPatterns;
- (CGFloat)compareTo:(CVPatternDelta *)other;

@end


@interface NSValue (PatternExtensions)

+ (NSValue *)valueWithPatternComparison:(PatternComparison)v;
- (PatternComparison)patternComparisonValue;

@end
