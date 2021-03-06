#import "CVPatternDelta.h"
#import "CVPath.h"

#ifndef DIM
#define DIM(x) (sizeof(x)/sizeof(x[0]))
#endif

// Extracted from a training session using only my own handwriting.  A better implementation
// would have multiple of these to start from but would learn, over time, from the user's
// corrections, and remove poor matches and instead use better ones from their own
// hand writing.

NSPoint digitPoints[10][31] = {
/* 0 */
{
	{32.835819, 97.014923},{14.925373, 91.744217},{9.311152, 83.582085},{4.486391, 74.635651},{1.492537, 64.722313},{0.000000, 55.061428},{0.000000, 43.908005},{1.549974, 34.270920},{4.477612, 25.204468},{6.226235, 14.925373},{13.158132, 8.955223},{19.833942, 4.477612},{29.132671, 0.000000},{40.286095, 0.000000},{50.746265, 0.693250},{57.497097, 5.970149},{64.179100, 11.315872},{70.149254, 16.499146},{73.134323, 24.667494},{76.119400, 34.584454},{77.611938, 45.119644},{77.611938, 56.273067},{79.104477, 66.808258},{77.611938, 77.343452},{76.119400, 87.004333},{69.624634, 92.537308},{62.686565, 96.752655},{52.413631, 98.507462},{41.878441, 100.000000},{32.835819, 97.014923}
},
/* 1 */
{
	{1.666667, 98.333328},{1.666667, 91.555557},{0.000000, 89.833321},{0.000000, 86.444443},{0.000000, 83.055542},{0.000000, 79.666672},{0.000000, 76.277771},{0.000000, 72.888893},{0.000000, 69.499992},{0.000000, 66.111115},{0.000000, 62.722218},{0.000000, 59.333344},{0.000000, 55.944443},{0.000000, 52.555565},{0.000000, 49.166664},{0.000000, 45.777790},{0.000000, 42.388889},{0.000000, 38.999989},{0.000000, 35.611115},{0.000000, 32.222214},{0.000000, 28.833338},{0.000000, 25.444437},{0.000000, 22.055561},{0.000000, 18.666660},{0.000000, 15.277786},{1.444448, 13.333333},{1.666667, 10.166677},{1.666667, 6.777776},{1.666667, 3.388901},{1.666667, 0.000000},{1.666667, 0.000000}
},

/* 2 */
{
	{0.000000, 74.603172},{7.936508, 86.855644},{13.251532, 91.029312},{20.634920, 95.276047},{27.592747, 98.412697},{36.099945, 100.000000},{44.094570, 97.175262},{52.380955, 95.162216},{58.730160, 91.416931},{62.765491, 84.853569},{63.492065, 75.989838},{59.114586, 68.638397},{55.528526, 61.904762},{50.835915, 55.597820},{45.012993, 49.774899},{39.190083, 43.951973},{32.123966, 38.284206},{26.679424, 33.028641},{21.321421, 26.083326},{14.841013, 19.602919},{9.738450, 14.285714},{6.349206, 7.580470},{7.933420, 3.174603},{15.510790, 1.587302},{24.675461, 1.587302},{33.840130, 1.587302},{42.347317, 0.000000},{51.511990, 0.000000},{60.676659, 0.000000},{68.253967, 1.587302}
},

/* 3 */
{
	{0.000000, 82.191780},{12.526567, 93.348488},{18.879313, 98.331360},{27.407305, 100.000000},{36.382439, 100.000000},{43.987713, 98.630142},{51.828014, 95.890411},{56.704754, 89.870590},{59.577808, 82.887962},{61.643837, 75.571037},{61.672150, 68.521454},{57.263050, 61.372627},{52.051502, 56.161083},{45.579697, 52.054794},{38.737907, 50.684933},{46.578205, 47.945206},{52.246201, 43.835617},{56.164383, 38.778667},{57.534248, 31.173393},{57.534248, 22.198257},{57.198021, 13.362393},{53.356327, 6.780985},{46.857590, 2.739726},{39.819733, 0.000000},{31.506849, 0.662252},{23.806753, 2.739726},{16.438356, 4.346477},{10.256865, 7.551366},{5.479452, 12.140290},{1.369863, 17.808220}
},

/* 4 */
{
	{0.000000, 98.214287},{0.000000, 85.867279},{0.000000, 79.693794},{0.000000, 73.520279},{0.360877, 67.496269},{1.785714, 61.912945},{1.785714, 55.739456},{2.778421, 49.800301},{3.571429, 43.814003},{3.571429, 37.640518},{3.571429, 31.467001},{3.571429, 25.293514},{1.785714, 19.859669},{1.785714, 13.686180},{1.785714, 7.512692},{1.785714, 1.339177},{6.620032, 0.000000},{12.793528, 0.000000},{18.967030, 0.000000},{25.140530, 0.000000},{31.314032, 0.000000},{37.487518, 0.000000},{43.661022, 0.000000},{49.834522, 0.000000},{55.939304, 0.291089},{61.759975, 1.785714},{67.933479, 1.785714},{74.106964, 1.785714},{79.540794, 3.571429},{85.714287, 3.571429}
},

/* 5 */
{
	{73.170731, 98.780487},{51.623535, 97.762993},{41.282665, 96.341469},{30.388958, 96.341469},{19.495262, 96.341469},{9.106697, 95.121956},{0.000000, 92.620575},{0.000000, 81.726875},{0.000000, 70.833183},{1.748601, 60.446522},{3.658537, 50.343937},{6.386083, 53.658539},{12.846356, 59.187820},{21.780014, 62.195122},{32.168579, 63.414635},{42.774387, 62.195122},{52.875072, 59.756100},{61.016792, 54.836868},{69.076988, 47.996185},{74.390244, 40.514820},{73.777397, 29.874960},{69.512199, 21.462343},{64.198433, 14.198434},{56.643379, 7.862891},{49.425060, 2.439024},{39.324383, 0.000000},{28.430679, 0.000000},{19.187071, 3.983660},{10.975610, 8.618573},{6.097561, 14.634147}
},

/* 6 */
{
{1.724138, 98.275864},{0.000000, 90.285088},{0.000000, 81.580147},{0.724421, 72.964386},{2.082969, 64.440750},{3.448276, 55.957371},{3.448276, 47.252430},{4.888997, 38.781288},{6.896552, 30.529352},{9.968793, 22.789829},{14.496307, 15.834975},{18.839174, 8.747035},{25.499483, 3.810863},{32.625916, 0.000000},{41.330853, 0.000000},{50.025307, 0.025307},{56.896553, 2.854153},{63.136757, 7.964340},{68.072929, 14.624651},{70.570808, 22.294937},{70.689659, 30.950647},{68.251068, 38.645485},{63.314896, 45.305798},{57.159576, 51.461121},{50.000004, 54.170540},{42.296940, 55.172417},{34.357887, 53.323406},{27.235065, 48.733528},{20.284094, 43.762737},{14.566784, 38.704716},{10.344828, 32.758621}
},

/* 7 */
{
	{0.000000, 98.682777},{12.433887, 97.312187},{18.249397, 97.997482},{24.588421, 98.682777},{31.089228, 98.682777},{37.590027, 98.682777},{43.929050, 99.368073},{50.133404, 100.000008},{56.400661, 98.682777},{62.901459, 98.682777},{69.240486, 97.997482},{69.814285, 95.084267},{65.676994, 90.347694},{61.080238, 85.750931},{57.258308, 80.558411},{53.749020, 75.289078},{50.848988, 69.626022},{47.624477, 64.064262},{44.036312, 58.715076},{40.197239, 53.678181},{36.499016, 48.458836},{32.735435, 43.190384},{29.727657, 37.785690},{26.670662, 32.111095},{23.498617, 26.438324},{20.073904, 20.959492},{16.913185, 15.432966},{13.027206, 10.292574},{10.044887, 4.797080},{7.538268, 0.000021},{7.538268, 0.000000}
},

/* 8 */
{
	{40.279957, 98.888893},{16.460657, 98.888893},{8.057734, 93.945625},{0.688731, 86.666672},{0.000000, 75.835510},{6.754210, 67.777779},{14.732243, 61.103264},{25.129633, 55.555557},{35.333134, 51.111115},{45.925209, 45.555557},{56.503071, 40.443558},{64.724403, 32.455360},{68.057739, 21.791620},{64.736275, 11.122979},{56.759899, 4.444445},{45.707584, 0.000000},{33.012257, 0.000000},{20.316935, 0.000000},{8.713193, 3.788995},{2.502179, 11.308137},{4.724401, 23.082989},{11.391068, 31.715139},{19.168846, 39.434120},{28.074631, 47.786224},{37.978848, 55.476669},{45.665150, 63.333336},{50.279961, 74.017357},{52.502182, 85.141319},{49.963570, 96.983055},{39.168846, 100.000008},
},
/* 9 */

{
	{45.454544, 96.969696},{28.968840, 100.000000},{20.479254, 99.462402},{12.633624, 96.847115},{5.869761, 92.042549},{1.201063, 85.735458},{0.000000, 77.491196},{0.518709, 69.178261},{3.979851, 61.545296},{9.652062, 55.499451},{17.045918, 51.893478},{24.851088, 51.366238},{31.864138, 55.348980},{37.266598, 60.751446},{41.249344, 67.764488},{43.747608, 75.747993},{45.454544, 83.759537},{46.969696, 91.215965},{46.969696, 91.165337},{48.484848, 83.265144},{48.484848, 74.737343},{48.484848, 66.209549},{49.242424, 57.995560},{49.618774, 49.623650},{50.757576, 41.567566},{51.515152, 33.353573},{51.515152, 24.825771},{51.515152, 16.297981},{51.515152, 7.770192},{52.272728, 0.000000}
}
};

@implementation CVPatternDelta

@synthesize segments;

CVPatternDelta * digitPatterns[10] = { nil };

+ (void)loadPatterns {
	if (digitPatterns[0] != nil) return;
	
	// create pattern deltas from points
	for (int i = 0 ; i < DIM(digitPoints) ; i++) {
		CVPath * path = [[CVPath alloc] initFromPoints:digitPoints[i] withCount:DIM(digitPoints[i])];
		digitPatterns[i] = [[CVPatternDelta deltaWithPath:path] retain];
		[path release];
	}
}

- (id)init {
	if (self = [super init]) {
		segments = nil;
	}
	return self;
}

- (id)initWithSegments:(NSMutableArray *)theSegments {
	if (self = [super init]) {
		segments = theSegments;
		[segments retain];
	}
	return self;
}

- (void)dealloc {
	[segments release];
	[super dealloc];
}

+ (CVPatternDelta *)deltaWithPath:(CVPath *)path {
	path = [path mutableCopy];
	
	[path normalize];
	[path fitToSize:NSMakeSize(100, 100) withStretch:NO];
	
	CVPatternDelta * result = [[[CVPatternDelta alloc] initWithSegments:[path segments]] autorelease];
	[path release];
	return result;
}


- (NSString *)pointString {
	NSString *text = @"";
	//NSString *tmp;
	
	if (segments == nil) return text;
	
	for (int i = 0 ; i < [segments count] ; i++) {
		NSValue *pv = [segments objectAtIndex:i];
		Segment s = [pv segmentValue];
		
		if (i == 0) {
			// Start with being point.
			//tmp = [NSString stringWithFormat:@"{%f, %f}", s.begin.x, s.begin.y];
			text = [text stringByAppendingFormat:@"{%f, %f}", s.begin.x, s.begin.y];
		}
		
		

		//tmp = [NSString stringWithFormat:@",{%f, %f}", s.end.x, s.end.y];
		text = [text stringByAppendingFormat:@",{%f, %f}", s.end.x, s.end.y];
	}
	
	return text;
}

- (NSString *)deltaString {
	NSString *text = @"";
	
	if (segments == nil) return text;
	
	for (int i = 0 ; i < [segments count] ; i++) {
		NSValue *pv = [segments objectAtIndex:i];
		Segment s = [pv segmentValue];
		//NSString *tmp = [NSString stringWithFormat:(i ? @",{%f, %f}" : @"{%f, %f}"), s.width, s.height];
		text = [text stringByAppendingFormat:(i ? @",{%f, %f}" : @"{%f, %f}"), s.width, s.height];
	}
	
	return text;
}

NSInteger patternCompareSort(id num1, id num2, void *context)
{
    PatternComparison v1 = [(NSValue *)num1 patternComparisonValue];
    PatternComparison v2 = [(NSValue *)num2 patternComparisonValue];
	
    if (v1.rank < v2.rank)
        return NSOrderedAscending;
    else if (v1.rank > v2.rank)
        return NSOrderedDescending;
    else
        return NSOrderedSame;
}

- (NSString *)resultString {
	NSArray *patternResults = [self compareToPatterns];
	
	NSString *text = @"";
	PatternComparison p;
	PatternComparison best = [[patternResults objectAtIndex:0] patternComparisonValue];
	
	for (int i = 0 ; i < [patternResults count] ; i++) {
		p = [[patternResults objectAtIndex:i] patternComparisonValue];
		text = [text stringByAppendingFormat:@"Digit %c Rank = %f\r\n", p.c, p.rank];
	}
	
	return [NSString stringWithFormat:@"Best Match is %c\r\n\r\n%@", best.c, text];
}

- (char)bestMatch {
	NSArray *patternResults = [self compareToPatterns];
	return [[patternResults objectAtIndex:0] patternComparisonValue].c;
}

- (NSArray *)compareToPatterns {
	[CVPatternDelta loadPatterns];

	NSMutableArray * result = [[[NSMutableArray alloc] init] autorelease];
	PatternComparison pc;
	
	for (int i = 0 ; i < DIM(digitPatterns) ; i++) {
		pc.c = '0' + i;
		pc.rank = [self compareTo:digitPatterns[i]];
		[result addObject:[NSValue valueWithPatternComparison:pc]];
	}
	
	return [result sortedArrayUsingFunction:patternCompareSort context:NULL];
}


- (CGFloat)compareTo:(CVPatternDelta *)other {
	// Assume : length of each segment is the same
	// Thus you are comparing two vectors of the same length and only a different angle,
	// it's delta from the reference determining the accuracy of the match.
	NSMutableArray *otherSegments = [other segments];
	Segment s1, s2;
	CGFloat result = 0;
	CGFloat a1, a2, c;
	
	for (int i = 0 ; i < MIN([segments count], [otherSegments count]) ; i++) {
		s1 = [[segments objectAtIndex:i] segmentValue];
		s2 = [[otherSegments objectAtIndex:i] segmentValue];
		
		a1 = atan2(s1.height, s1.width);
		a2 = atan2(s2.height, s2.width);
		
		c = fabs(a1 - a2);
		
		if (c > M_PI)
			c = 2 * M_PI - c;
		
		result += c / M_PI;
	}

	return result;
}

@end


@implementation NSValue (PatternExtensions)

+ (NSValue *)valueWithPatternComparison:(PatternComparison)v {
	return [NSValue valueWithBytes:&v objCType:@encode(PatternComparison)];
}

- (PatternComparison)patternComparisonValue {
	PatternComparison v;
	[self getValue:&v];
	return v;
}
@end
