#include "../include/jinho/square_scanner.h"
#include <cmath>
#include <iostream>
#define SWAP(x, y, t) ((t) = (x), (x) = (y), (y) = (t))

int partition(double list[], int left, int right) {
    double pivot = list[left];
    int low = left;
    int high = right + 1;
    int temp;

    do {
        do {
            low++;
        } while (list[low] < pivot);
        do {
            high--;
        } while (list[high] > pivot);

        if (low < high) {
            SWAP(list[low], list[high], temp);
        }

    } while (low < high);

    SWAP(list[left], list[high], temp);

    return high;
}

void quickSort(double list[], int left, int right) {
    if (left < right) {
        int p = partition(list, left, right);
        quickSort(list, left, p - 1);
        quickSort(list, p + 1, right);
    }
}

squareScanner::squareScanner(double minX, double minY, double maxX, double maxY, double pivotX, double pivotY) {
    this->minX = minX;
    this->minY = minY;
    this->maxX = maxX;
    this->maxY = maxY;
    this->pivotX = pivotX;
    this->pivotY = pivotY;
    this->detectAngles.total = 0;
    this->availableAngles.total = 0;
    this->minAngle = 20;
    this->maxAngle = 160;
    this->availableAngles.minAngle[this->availableAngles.total++] = this->minAngle;
    this->availableAngles.maxAngle[this->availableAngles.total++] = this->maxAngle;
}

void squareScanner::initAngles() {
    this->detectAngles.total = 0;
    this->availableAngles.total = 0;
    // std::cout << "init scanner\n";
    // std::cout << "(" << this->detectAngles.total << ", " << this->availableAngles.total << ")\n";
}

bool squareScanner::isInRange(double oX = 0, double oY = 0, double oR = 0) {
    bool result = false;

    if (minX <= oX && oX <= maxX && minY <= oY && oY <= maxY)
        result = true;

    return result;
}

detectAngleType squareScanner::calcObjectPosition(double oX = 0, double oY = 0, double oR = 0) {
    // init detectAngleType
    detectAngleType oP;
    oP.distance = 999;
    oP.isInRange = false;
    oP.maxRadian = 0;
    oP.minRadian = 0;

    oP.isInRange = isInRange(oX, oY, oR);
    // 객체가 범위 안에 있으면 물체 정보계산 없으면 init값 반환
    if (oP.isInRange) {
        oP.distance = sqrt((pivotX - oX) * (pivotX - oX) + (pivotY - oY) * (pivotY - oY)); // 거리계산(pivot <-> 객체)
        double centerRad = acos(oY / oP.distance) * 180.0 / M_PI; 
        double roundRad = asin((oR/2) / oP.distance) * 180.0 / M_PI;
        oP.minRadian = (centerRad - roundRad);
        oP.maxRadian = (centerRad + roundRad);
        // std::cout << "calc Angle\n";
        std::cout << "\ndis: " << oP.distance << "\ncenterRad: " << centerRad << "\nroundRad: " << roundRad << "\nround: " << oR << "\n";
    }

    return oP;
}

void squareScanner::pushDetectAngle(detectAngleType object) {
    this->detectAngles.minAngle[this->detectAngles.total] = object.minRadian;
    this->detectAngles.maxAngle[this->detectAngles.total] = object.maxRadian;
    this->detectAngles.total++;
}

void squareScanner::sortDetectedAngle() {
    quickSort(this->detectAngles.minAngle, 0, detectAngles.total-1);
    quickSort(this->detectAngles.maxAngle, 0, detectAngles.total-1);

    // std::cout << "detect MinAngle\n";
    for (int i = 0; i < this->detectAngles.total; i++) {
        std::cout << this->detectAngles.minAngle[i] << "\n";
    }
    // std::cout << "END\n";
    // std::cout << "detect MaxAngle\n";
    for (int i = 0; i < this->detectAngles.total; i++) {
        std::cout << this->detectAngles.maxAngle[i] << "\n";
    }
    // std::cout << "END\n";
}

void squareScanner::calcAvailableAngle(int maxObjectAmount) {
    double detectMinAngle, detectMaxAngle;
    double tmpMinAngle = this->minAngle;
    sortDetectedAngle();
    int maxAmount = (maxObjectAmount > detectAngles.total) ? detectAngles.total : maxObjectAmount;
    for (int i = 0; i < maxAmount; i++) {
        detectMinAngle = detectAngles.minAngle[i];
        detectMaxAngle = detectAngles.maxAngle[i];

        if (tmpMinAngle < detectMinAngle) {
            availableAngles.minAngle[availableAngles.total] = tmpMinAngle;
            availableAngles.maxAngle[availableAngles.total] = detectMinAngle;
            availableAngles.total++;
            tmpMinAngle = detectMaxAngle;
        } else {
            tmpMinAngle = (detectMaxAngle > tmpMinAngle) ? detectMaxAngle : tmpMinAngle;
        }
        
        if (detectMaxAngle > this->maxAngle) {
            break;
        }
    }
    if (tmpMinAngle < this->maxAngle) {
        availableAngles.minAngle[availableAngles.total] = tmpMinAngle;
        availableAngles.maxAngle[availableAngles.total] = this->maxAngle;
        availableAngles.total++;
    }
}

void squareScanner::print() {
    std::cout << "calc Angles\n";
    for (int i = 0; i < availableAngles.total; i++) {
        
        std::cout << "(" << availableAngles.minAngle[i] << ", " << availableAngles.maxAngle[i] << ")\n";
    }
    
}



double squareScanner::getMaxX() {
    return this->maxX;
}
double squareScanner::getMaxY() {
    return this->maxY;
}
double squareScanner::getMinX() {
    return this->minX;
}
double squareScanner::getMinY() {
    return this->minY;
}
double squareScanner::getPivotX() {
    return this->pivotX;
}
double squareScanner::getPivotY() {
    return this->pivotY;
}
void squareScanner::setMaxX(double maxX) {
    this->maxX = maxX;
}
void squareScanner::setMaxY(double maxY) {
    this->maxY = maxY;
}
void squareScanner::setMinX(double minX) {
    this->minX = minX;
}
void squareScanner::setMinY(double minY) {
    this->minY = minY;
}
void squareScanner::setPivotX(double pivotX) {
    this->pivotX = pivotX;
}
void squareScanner::setPivotY(double pivotY) {
    this->pivotY = pivotY;
}