//
//  CPPConverter.h
//  ScalePointsTestSwift
//
//  Created by Alexander Kormanovsky on 15.07.2021.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

NS_ASSUME_NONNULL_BEGIN

@interface CPPConverter : NSObject

- (instancetype)initWithPointsString:(NSString *)pointsString;

- (NSArray *)originalPoints;

- (NSArray *)scaledPointsWithScaleFactor:(CGFloat)scaleFactor;

+ (NSArray *)boundingPointsWithPoints:(NSArray *)points;

+ (CGPoint)pointsCenterWithPoints:(NSArray *)points;

@end

NS_ASSUME_NONNULL_END
