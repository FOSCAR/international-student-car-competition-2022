#include <cmath>
#include <iostream>

using namespace std;


int main(){
    double x = 0.5;
    double y = sqrt(3) / 2;

    double v = acos(x) * 180.0 / M_PI;
    cout << v;
    v = acos(-y) * 180.0 / M_PI;
    cout << v;
}