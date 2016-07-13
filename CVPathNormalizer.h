@class CVPath;

@interface CVPathNormalizer : NSObject {

}

+ (CVPath *)smooth:(CVPath *)path withSegments:(int)segments;

@end
