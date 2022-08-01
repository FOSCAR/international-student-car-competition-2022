##########################################################################
#
# 1280x720 해상도로 촬영한 NEW bag file 필요 
# translation_matrix(t1, t2, t3) 직접 측정할 수 있는지 확인 필요
#
##########################################################################

import numpy as np
import sympy

r11, r12, r13, r21, r22, r23, r31, r32, r33 = sympy.symbols("r11 r12 r13 r21 r22 r23 r31 r32 r33") 
t1, t2, t3 = sympy.symbols("t1 t2 t3") 
a11, a12, a13, a14, a21, a22, a23, a24, a31, a32, a33, a34 = sympy.symbols("a11 a12 a13 a14 a21 a22 a23 a24 a31 a32 a33 a34") 

# intrinsic parameter -> /home/.ros/camera_info/head_camera.yaml -> camera_matrix: data: [fx, skew_cfx, cx, 0, fy, cy, 0, 0, 1] 
A = np.array( [ [977.9070075677453,                 0, 673.9735232467891],     # [fx, skew_cfx, cx]
                [                0, 981.3428225140341, 370.0286390428545],     # [ 0,       fy, cy]
                [                0,                 0,                 1] ] )  # [ 0,        0,  1]


# T = np.array( [t1], 
#               [t2],
#               [t3] )


# 카메라 프레임에 표시된 라바콘 픽셀 좌표 (X, Y, 1)
XY = np.array( [ [  164, 474,  78.5, 563.5],     # [X1, X2, X3, X4]
                 [208.5, 210, 317.5, 316.5],     # [Y1, Y2, Y3, Y4]
                 [    1,   1,     1,     1] ] )  # [ 1,  1,  1,  1]


# 라이다 프레임에 표시된 라바콘 World Frame 좌표 (X, Y, Z, 1)
XYZ = np.array( [ [  4.76814174652,    4.8125629425,   3.01290988922,   3.03058195114],     # [X1, X2, X3, X4]
                  [  1.22493457794,    -1.171407938,    1.2699432373,  -1.26390790939],     # [Y1, Y2, Y3, Y4]
                  [-0.608247041702, -0.612546801567, -0.640378475189, -0.641561388969],     # [Z1, Z2, Z3, Z4]
                  [              1,               1,               1,               1] ] )  # [ 1,  1,  1,  1]


a11 = A[0,0]*r11 + A[0,1]*r21 + A[0,2]*r31
a12 = A[0,0]*r12 + A[0,1]*r22 + A[0,2]*r32
a13 = A[0,0]*r13 + A[0,1]*r23 + A[0,2]*r33
a14 = A[0,0]* t1 + A[0,1]* t2 + A[0,2]* t3  # t1, t2, t3 측정값 있을 경우 값 대입

a21 = A[1,0]*r11 + A[1,1]*r21 + A[1,2]*r31
a22 = A[1,0]*r12 + A[1,1]*r22 + A[1,2]*r32
a23 = A[1,0]*r13 + A[1,1]*r23 + A[1,2]*r33
a24 = A[1,0]* t1 + A[1,1]* t2 + A[1,2]* t3  # t1, t2, t3 측정값 있을 경우 값 대입

a31 = A[2,0]*r11 + A[2,1]*r21 + A[2,2]*r31
a32 = A[2,0]*r12 + A[2,1]*r22 + A[2,2]*r32
a33 = A[2,0]*r13 + A[2,1]*r23 + A[2,2]*r33
a34 = A[2,0]* t1 + A[2,1]* t2 + A[2,2]* t3  # t1, t2, t3 측정값 있을 경우 값 대입

ARt = np.array( [ [a11, a12, a13, a14],
                  [a21, a22, a23, a24],
                  [a31, a32, a33, a34] ] )

equation1 = a11*XYZ[0,0] + a12*XYZ[1,0] + a13*XYZ[2,0] + a14*XYZ[3,0] - XY[0,0]
equation2 = a21*XYZ[0,0] + a22*XYZ[1,0] + a23*XYZ[2,0] + a24*XYZ[3,0] - XY[1,0]
equation3 = a31*XYZ[0,0] + a32*XYZ[1,0] + a33*XYZ[2,0] + a34*XYZ[3,0] - XY[2,0]

equation4 = a11*XYZ[0,1] + a12*XYZ[1,1] + a13*XYZ[2,1] + a14*XYZ[3,1] - XY[0,1]
equation5 = a21*XYZ[0,1] + a22*XYZ[1,1] + a23*XYZ[2,1] + a24*XYZ[3,1] - XY[1,1]
equation6 = a31*XYZ[0,1] + a32*XYZ[1,1] + a33*XYZ[2,1] + a34*XYZ[3,1] - XY[2,1]

equation7 = a11*XYZ[0,2] + a12*XYZ[1,2] + a13*XYZ[2,2] + a14*XYZ[3,2] - XY[0,2]
equation8 = a21*XYZ[0,2] + a22*XYZ[1,2] + a23*XYZ[2,2] + a24*XYZ[3,2] - XY[1,2]
equation9 = a31*XYZ[0,2] + a32*XYZ[1,2] + a33*XYZ[2,2] + a34*XYZ[3,2] - XY[2,2]

equation10 = a11*XYZ[0,3] + a12*XYZ[1,3] + a13*XYZ[2,3] + a14*XYZ[3,3] - XY[0,3]
equation11 = a21*XYZ[0,3] + a22*XYZ[1,3] + a23*XYZ[2,3] + a24*XYZ[3,3] - XY[1,3]
equation12 = a31*XYZ[0,3] + a32*XYZ[1,3] + a33*XYZ[2,3] + a34*XYZ[3,3] - XY[2,3]

rt = sympy.solve( ( equation1, equation2, equation3, 
                    equation4, equation5, equation6, 
                    equation7, equation8, equation9, 
                    equation10, equation11, equation12 ) )

rotation_matrix = np.array( [ [ rt[r11], rt[r12], rt[r13], rt[t1] ], 
                              [ rt[r21], rt[r22], rt[r23], rt[t2] ],
                              [ rt[r31], rt[r32], rt[r33], rt[t3] ] ] )


print("-----------------------------------------ROTATION MATRIX-----------------------------------------")
for i in range(3):
    print('[', end='')
    for j in range(4):
        print(rotation_matrix[i][j], end='')
        print('\t', end='')
    print(']\n', end='')  





########################## 검증식 ##########################
XYZ_test = np.array( [ [4.76814174652],   # [X_TEST]
                       [1.22493457794],   # [Y_TEST]
                       [-0.608247041702], # [Z_TEST]
                       [1] ] )            # [1]

ARt_test = np.matmul(A, rotation_matrix)
test_result = np.matmul(ARt_test, XYZ_test)

print('\n--------------TEST--------------')
print(test_result) # 해당 라바콘이 대응되는 카메라 프레임 라바콘의 픽셀 좌표가 나오면 OK
        



