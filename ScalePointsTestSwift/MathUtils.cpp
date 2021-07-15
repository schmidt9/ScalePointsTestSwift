//
//  MathUtils.cpp
//  ScalePointsTestSwift
//
//  Created by Alexander Kormanovsky on 15.07.2021.
//

#include <float.h>
#include "MathUtils.hpp"

namespace math_utils {
    
    /**
     * Cross the specified o, a and b.
     * Zero if collinear
     * Positive if counter-clockwise
     * Negative if clockwise
     * @param o 0
     * @param a The alpha component
     * @param b The blue component
     */
    double
    MathUtils::cross(const Point &o, const Point &a, const Point &b)
    {
        return (a.x - o.x) * (b.y - o.y) - (a.y - o.y) * (b.x - o.x);
    }
    
    bool
    MathUtils::isDoubleEqual(double v1, double v2)
    {
        return std::abs(v1 - v2) < DBL_EPSILON;
    }
    
    std::vector<Point>
    MathUtils::monotoneChainConvexHull(const std::vector<Point> &points)
    {
        // break if only one point as input
        if (points.size() <= 1) {
            return points;
        }
        
        auto sortedPoints = points;
        
        // sort vectors
        std::sort(sortedPoints.begin(), sortedPoints.end(), [&](const Point &p1, const Point &p2) -> bool {
            // https://github.com/cansik/LongLiveTheSquare/blob/master/U4LongLiveTheSquare/Geometry/Vector2d.cs
            if (isDoubleEqual(p1.x, p2.x)) {
                if (isDoubleEqual(p1.y, p2.y)) {
                    return false;
                }
                
                return (p1.y < p2.y);
            }
            
            return (p1.x < p2.x);
        });
        
        auto hullPoints = std::vector<Point>(sortedPoints.size() * 2);
        
        auto pointLength = sortedPoints.size();
        auto counter = 0;
        
        // iterate for lowerHull
        
        for (int i = 0; i < pointLength; ++i) {
            while (counter >= 2 && cross(hullPoints[counter - 2], hullPoints[counter - 1], sortedPoints[i]) <= 0) {
                counter--;
            }
            
            hullPoints[counter++] = sortedPoints[i];
        }
        
        // iterate for upperHull
        
        for (int i = (int) pointLength - 2, j = counter + 1; i >= 0; i--) {
            while (counter >= j && cross(hullPoints[counter - 2], hullPoints[counter - 1], sortedPoints[i]) <= 0) {
                counter--;
            }
            
            hullPoints[counter++] = sortedPoints[i];
        }
        
        // remove duplicate start points
        
        hullPoints.erase(hullPoints.begin() + counter, hullPoints.end());
        
        return hullPoints;
    }
    
    /**
     * @see https://stackoverflow.com/a/29848387/3004003
     * @param points Points to scale
     * @param anchorPoint Scaling occurs relative to this point
     * @param scaleFactor Scale factor
     */
    std::vector<Point>
    MathUtils::scalePoints(const std::vector<Point> &points, const Point &anchorPoint, double scaleFactor)
    {
        std::vector<Point> result;
        
        for (int i = 0; i < points.size(); i++) {
            Point point = points[i];
            //this is a vector that leads from mass center to current vertex
            Point vec = {point.x - anchorPoint.x, point.y - anchorPoint.y};
            point.x = anchorPoint.x + scaleFactor * vec.x;
            point.y = anchorPoint.y + scaleFactor * vec.y;
            result.push_back(point);
        }
        
        return result;
    }
    
    /**
     https://stackoverflow.com/a/2792459/3004003
     */
    Point
    MathUtils::compute2DPolygonCentroid(const std::vector<Point> &vertices)
    {
        Point centroid = {0, 0};
        double signedArea = 0.0;
        double x0 = 0.0; // Current vertex X
        double y0 = 0.0; // Current vertex Y
        double x1 = 0.0; // Next vertex X
        double y1 = 0.0; // Next vertex Y
        double a = 0.0;  // Partial signed area
        
        auto vertexCount = vertices.size();
        
        for (int i=0; i < vertexCount; ++i) {
            x0 = vertices[i].x;
            y0 = vertices[i].y;
            x1 = vertices[(i+1) % vertexCount].x;
            y1 = vertices[(i+1) % vertexCount].y;
            a = x0*y1 - x1*y0;
            signedArea += a;
            centroid.x += (x0 + x1)*a;
            centroid.y += (y0 + y1)*a;
        }
        
        signedArea *= 0.5;
        centroid.x /= (6.0*signedArea);
        centroid.y /= (6.0*signedArea);
        
        return centroid;
    }
    
}
