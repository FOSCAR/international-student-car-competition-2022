#ifndef _SQUARE_SCANNER_H_
#define _SQUARE_SCANNER_H_
#define MAX_DETECT_COUNT 100
#define MAX_AVAILABLE_ANGLE 20

// detectRangeInfo로 이름바꾸기?
typedef struct {
    bool isInRange;
    double maxRadian;
    double minRadian;
    double distance;
}detectAngleType;

typedef struct {
    double minAngle[MAX_DETECT_COUNT];
    double maxAngle[MAX_DETECT_COUNT];
    int total;
}detectAngleArray;

typedef struct
{
    double minAngle[MAX_AVAILABLE_ANGLE];
    double maxAngle[MAX_AVAILABLE_ANGLE];
    int total;
}availableAngleArray;



class squareScanner {
    // attribute
    double minX, minY, maxX, maxY;
    double pivotX, pivotY;
    double minAngle, maxAngle;

    public:
        detectAngleArray detectAngles;
        availableAngleArray availableAngles;
        
        // constructor
        squareScanner(double minX = 0, double minY = 0, double maxX = 0, double maxY = 0, double pivotX = 0, double pivotY = 0);

        // method
        void sortDetectedAngle();
        void initAngles();
        bool isInRange(double oX, double oY, double oR);
        detectAngleType calcObjectPosition(double oX, double oY, double oR);
        void pushDetectAngle(detectAngleType object);
        void calcAvailableAngle(int maxObjectAmount);
        void print();


        // getter setter
        double getMinX();
        double getMinY();
        double getMaxX();
        double getMaxY();
        double getPivotX();
        double getPivotY();
        void setMinX(double minX);
        void setMinY(double minY);
        void setMaxX(double maxX);
        void setMaxY(double maxY);
        void setPivotX(double pivotX);
        void setPivotY(double pivotY);
};

#endif