#ifndef _OBJECT_INFO_H_
#define _OBJECT_INFO_H_
#define MAX_OBJECT_COUNT 100

typedef struct {
    double minX, minY, minZ;
    double maxX, maxY, maxZ;
    double centerX, centerY, centerZ;
    double radiusXY, radiusXYZ;
}objectPositionType;

typedef struct {
    objectPositionType objects[MAX_OBJECT_COUNT];
    int total;
} objectArray;


#endif