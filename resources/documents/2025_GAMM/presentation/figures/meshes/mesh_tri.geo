//// Options
Mesh.Algorithm = 5;

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

//// Lines
Line(1) = {11, 12};
Line(2) = {12, 13};
Line(3) = {13, 14};
Line(4) = {14, 24};
Line(5) = {24, 23};
Line(6) = {23, 22};
Line(7) = {22, 21};
Line(8) = {21, 11};

//// Surfaces
Curve Loop(1) = {1, 2, 3, 4, 5, 6, 7, 8};
Plane Surface(1) = {1};

//// Physical groups
Physical Surface("domain", 1) = {1};
Physical Curve("bot", 2) = {1};
Physical Curve("top", 3) = {3};
Physical Curve("left", 4) = {4, 8};
Physical Curve("right", 5) = {2};
Physical Curve("crack", 6) = {5, 6, 7};
