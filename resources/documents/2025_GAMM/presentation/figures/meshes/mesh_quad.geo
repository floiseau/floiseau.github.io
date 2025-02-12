
//// Parameters
// Geometry
H = 1.0; 		// Plate height
W = 8*H;		// Plate width
a = H / 2;		// Initial crack length
e = H / 4;		// Eccentricity
// Numerical
dx = H / 12;

//// Points
// Border
Point(11) = {0, 0, 0, dx};
Point(12) = {W, 0, 0, dx};
Point(13) = {W, H, 0, dx};
Point(14) = {0, H, 0, dx};
// Initial crack
Point(21) = {0, H/2 + e - dx/2, 0, dx};
Point(22) = {a, H/2 + e - dx/2, 0, dx};
Point(23) = {a, H/2 + e + dx/2, 0, dx};
Point(24) = {0, H/2 + e + dx/2, 0, dx};
// Auxiliary points (for regular grid)
Point(31) = {a, 0, 0, dx};
Point(32) = {W, H/2 + e - dx/2, 0, dx};
Point(33) = {W, H/2 + e + dx/2, 0, dx};
Point(34) = {a, H, 0, dx};

//// Lines
Line(1) = {11, 31};
Line(2) = {31, 12};
Line(3) = {11, 21};
Line(4) = {31, 22};
Line(5) = {12, 32};
Line(6) = {21, 22};
Line(7) = {22, 32};
Line(8) = {22, 23};
Line(9) = {32, 33};
Line(10) = {24, 23};
Line(11) = {23, 33};
Line(12) = {24, 14};
Line(13) = {23, 34};
Line(14) = {33, 13};
Line(15) = {14, 34};
Line(16) = {34, 13};

//// Transfinite curves
// Note: Ensure that the surface in front of crack is one element wide
Transfinite Curve {8, 9} = 2;

//// Surfaces
Curve Loop(1) = {1, 4, -6, -3};
Plane Surface(1) = {1};
Curve Loop(2) = {2, 5, -7, -4};
Plane Surface(2) = {2};
Curve Loop(3) = {7, 9, -11, -8};
Plane Surface(3) = {3};
Curve Loop(4) = {10, 13, -15, -12};
Plane Surface(4) = {4};
Curve Loop(5) = {11, 14, -16, -13};
Plane Surface(5) = {5};

//// Define transfinite surfaces
Transfinite Surface {1};
Transfinite Surface {2};
Transfinite Surface {3};
Transfinite Surface {4};
Transfinite Surface {5};

//// Recombine into quad elements
Recombine Surface {1, 2, 3, 4, 5};

//// Physical groups
Physical Surface("domain", 1) = {1, 2, 3, 4, 5};
Physical Curve("bot", 2) = {1, 2};
Physical Curve("top", 3) = {16, 15};
Physical Curve("left", 4) = {3, 12};
Physical Curve("right", 5) = {5, 9, 14};
Physical Curve("crack", 6) = {6, 8, 10};
