//
//  CPPConverter.m
//  ScalePointsTestSwift
//
//  Created by Alexander Kormanovsky on 15.07.2021.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CPPConverter.h"
#import "MathUtils.hpp"
#import "Point.hpp"

@implementation CPPConverter
{
    NSArray *_points;
}

- (instancetype)initWithPointsString:(NSString *)pointsString
{
    self = [super init];
    if (self) {
        _points = [self pointsWithPointsString:pointsString];
    }
    return self;
}

- (NSArray *)pointsWithPointsString:(NSString *)pointsString
{
    NSMutableArray *points = [NSMutableArray new];
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(\\((\\d{4}),(\\d{4})\\))" options:0 error:nil];
    [regex enumerateMatchesInString:pointsString options:0 range:NSMakeRange(0, pointsString.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
        
        CGFloat x = [pointsString substringWithRange:[result rangeAtIndex:2]].doubleValue;
        CGFloat y = [pointsString substringWithRange:[result rangeAtIndex:3]].doubleValue;
        
        [points addObject:[NSValue valueWithCGPoint:CGPointMake(x - 1000, y - 1000)]];
    }];
    
    return points;
}

- (NSArray *)originalPoints
{
    return _points;
}

- (NSArray *)scaledPointsWithScaleFactor:(CGFloat)scaleFactor
{
    NSArray *originalPoints = [self originalPoints];
    std::vector<math_utils::Point> cppPoints;
    
    for (NSValue *value in originalPoints) {
        CGPoint point = value.CGPointValue;
        auto mingliPoint = math_utils::Point(point.x, point.y);
        cppPoints.push_back(mingliPoint);
    }
    
    CGPoint center = [self.class pointsCenterWithPoints:originalPoints];
    
    auto cppScaledPoints = math_utils::MathUtils::scalePoints(cppPoints, math_utils::Point(center.x, center.y), scaleFactor);
    NSMutableArray *scaledPoints = [NSMutableArray new];
    
    for (auto &mingliPoint : cppScaledPoints) {
        CGPoint point = CGPointMake(mingliPoint.x, mingliPoint.y);
        [scaledPoints addObject:[NSValue valueWithCGPoint:point]];
    }
    
    return scaledPoints;
}

+ (NSArray *)boundingPointsWithPoints:(NSArray *)points
{
    NSMutableArray *boundingPoints = [NSMutableArray new];
    
    std::vector<math_utils::Point> cppPoints;
    
    for (NSValue *value in points) {
        CGPoint point = value.CGPointValue;
        auto cppPoint = math_utils::Point(point.x, point.y);
        cppPoints.push_back(cppPoint);
    }
    
    cppPoints = math_utils::MathUtils::monotoneChainConvexHull(cppPoints);
    
    for (auto &cppPoint : cppPoints) {
        CGPoint point = CGPointMake(cppPoint.x, cppPoint.y);
        [boundingPoints addObject:[NSValue valueWithCGPoint:point]];
    }
    
    return boundingPoints;
}

+ (CGPoint)pointsCenterWithPoints:(NSArray *)points
{
    std::vector<math_utils::Point> cppPoints;
    
    for (NSValue *value in points) {
        CGPoint point = value.CGPointValue;
        auto cppPoint = math_utils::Point(point.x, point.y);
        cppPoints.push_back(cppPoint);
    }
    
    auto cppCenter = math_utils::MathUtils::compute2DPolygonCentroid(cppPoints);
    
    return CGPointMake(cppCenter.x, cppCenter.y);
}

@end
