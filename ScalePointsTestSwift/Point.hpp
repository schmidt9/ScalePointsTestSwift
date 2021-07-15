//
//  Point.hpp
//  ScalePointsTestSwift
//
//  Created by Alexander Kormanovsky on 15.07.2021.
//

#ifndef Point_hpp
#define Point_hpp

#include <math.h>

namespace math_utils {
    
    struct Point {
        
        double x = DBL_MAX;
        double y = DBL_MAX;
        
        Point() {};
        Point(double x, double y) : x{x}, y{y} {}
        Point(const std::pair<double, double> &p) : x{p.first}, y{p.second} {};
        
        inline bool isSet()
        {
            return fabs(x - DBL_MAX) > DBL_EPSILON && fabs(y - DBL_MAX) > DBL_EPSILON;
        }
        
        inline Point operator * (double value)
        {
            return {this->x * value, this->y * value};
        }
        
        inline Point operator / (double value)
        {
            return {this->x / value, this->y / value};
        }
        
        inline Point operator + (const Point &other)
        {
            return {this->x + other.x, this->y + other.y};
        }
        
        template<
        typename T,
        typename = typename std::enable_if<std::is_arithmetic<T>::value, T>::type
        >
        inline Point operator + (T value) const
        {
            return {this->x + value, this->y + value};
        }
        
        inline Point operator - (const Point &other)
        {
            return {this->x - other.x, this->y - other.y};
        }
        
        inline Point operator - (const Point &other) const
        {
            return {this->x - other.x, this->y - other.y};
        }
        
        inline bool operator == (const Point &other)
        {
            return this->x == other.x && this->y == other.y;
        };
    };
    
}

#endif /* Point_hpp */
