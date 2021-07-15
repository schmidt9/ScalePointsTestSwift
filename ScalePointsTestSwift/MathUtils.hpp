//
//  MathUtils.hpp
//  ScalePointsTestSwift
//
//  Created by Alexander Kormanovsky on 15.07.2021.
//

#ifndef MathUtils_hpp
#define MathUtils_hpp

#include <vector>
#include "Point.hpp"

namespace math_utils {
    
    struct MathUtils {
        
        static double cross(const Point &o, const Point &a, const Point &b);
        
        static bool isDoubleEqual(double v1, double v2);
        
        static std::vector<Point> monotoneChainConvexHull(const std::vector<Point> &points);
        
        static std::vector<Point> scalePoints(const std::vector<Point> &points, const Point &anchorPoint, double scaleFactor);
        
        static Point compute2DPolygonCentroid(const std::vector<Point> &vertices);
        
    };
    
}

#endif /* MathUtils_hpp */
