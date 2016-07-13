#import "AppController.h"
#import "CVPath.h"
#import "CVGestureView.h"
#import "CVPixelView.h"
#import "CVPatternDelta.h"
#import "CVPolyView.h"
#import "CVPathNormalizer.h"
#import "CVPatternEngine.h"

@implementation AppController

- (IBAction)gesture:(id)sender {
	CVPath *path = [gestureView path];
	CVPath *smooth;
	
	path = [path mutableCopy];
	[path normalize];
	smooth = [CVPathNormalizer smooth:path withSegments:30];
	CVPatternDelta *p = [CVPatternDelta deltaWithPath:smooth];
	NSString *text;
	text = [NSString stringWithFormat:@"Results\r\n%@\r\nLength = %f\r\nPath Points\r\n%@\r\nPath Deltas\r\n%@", 
			[p resultString],
			[smooth pathLength], 
			[p pointString], 
			[p deltaString]];
	[pointLog setStringValue:text];
	
	NSTimeInterval start = [NSDate timeIntervalSinceReferenceDate];
	char bestMatch = [CVPatternEngine bestMatchFromPath:[gestureView path]];
	NSTimeInterval duration = [NSDate timeIntervalSinceReferenceDate] - start;
	
	[match setStringValue:[NSString stringWithFormat:@"%c", bestMatch]];
	[time setStringValue:[NSString stringWithFormat:@"%f ms", 1000*duration]];
	
	[normalizedView setPath:path];
	[normalizedView setFitToView:YES];
	[normalizedView setNeedsDisplay:YES];

	[smoothedView setPath:smooth];
	[smoothedView setFitToView:YES];
	[smoothedView setNeedsDisplay:YES];

	[path release];
}


- (void)awakeFromBin {
}


@end
