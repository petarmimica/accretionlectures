import graph3;
import palette;
import fontsize;
import solids;

// square
real sqr(real x) { return x*x;}

defaultpen(Helvetica()+fontsize(48));

real u=2cm;

size(10u);

currentprojection=orthographic(-5u, 3u, 2u);

real diskR = 7u;
real diskh = 1u;

path3 ocirc = ((-diskR, 0, 0)..(0, -diskR, 0)..(diskR, 0, 0)..(0, diskR, 0)..cycle);

draw(ocirc, linewidth(0.04u));

draw((0, 0, 0)--(0, 0, 5u), linewidth(0.05u), Arrow3);
label("$z$", (0, 0, 5.5u));

draw((0, 0, 0)--(0, -diskR, 0), linewidth(0.05u), Arrow3);
label("$r$", (0u, -diskR - 1u, 0));

draw((diskR * cos(270 * pi / 180), diskR * sin(270 * pi / 180), 0)..(diskR * cos(290 * pi / 180), diskR * sin(290 * pi / 180), 0)..(diskR * cos(310 * pi / 180), diskR * sin(310 * pi / 180), 0), red+linewidth(0.05u), Arrow3);

label("$\phi$", (diskR * cos(290 * pi / 180) * 1.2, diskR * sin(290 * pi / 180) * 1.2, 0), red);


real R = 4u, deltaR = 1u;

path3 Rcirc = ((-R, 0, 0)..(0, -R, 0)..(R, 0, 0)..(0, R, 0)..cycle);
draw(Rcirc, blue+linewidth(0.05u)+dashed);

path3 dRcirc = ((-(R+deltaR), 0, 0)..(0, -(R+deltaR), 0)..((R+deltaR), 0, 0)..(0, (R+deltaR), 0)..cycle);
draw(dRcirc, blue+linewidth(0.05u)+dashed);

draw((0, 0, 0)--(0, R, 0), blue + linewidth(0.03u));
label("\LARGE $R$", (-0.6u, R/2, 0), blue);

draw((0, 0, 0)--(R + deltaR, 0, 0), blue + linewidth(0.03u));
label("\LARGE $R + \Delta R$", (R/2, 1u, 0), blue);
