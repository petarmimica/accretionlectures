import graph;
import palette;
import fontsize;

defaultpen(Helvetica()+fontsize(48));

real u=5cm;

size(10u, IgnoreAspect);

// parameters of the system
real r_1 = -2u; // center of the primary star
real q = 0.8; // mass ratio M_2 / M_1
real R_1 = 0.15u; // radius of the primary star
real R_2 = 0.7u; // radius of the secondary star

real r_2 = -r_1 / q;

// draw star center lines
path pl=(r_1, -1.1 * R_2)--(r_1, 1.1 * R_2);
draw(pl, linewidth(0.02u)+dashed);
path sl=(r_2, -1.1 * R_2)--(r_2, 1.1 * R_2);
draw(sl, linewidth(0.02u)+dashed);


// draw the primary star
path PrimStar=(r_1 - R_1, 0)..(r_1, R_1)..(r_1 + R_1, 0)..(r_1, -R_1)..cycle;
filldraw(PrimStar, linewidth(0.05u)+white, black);
label(minipage("\centering P"), (r_1, 0), black);
label(minipage("\centering $M_1$"), (r_1 + R_1 + 0.15u, 0));

// draw the secondary star
path SecStar=(r_2 - R_2, 0)..(r_2, R_2)..(r_2 + R_2, 0)..(r_2, -R_2)..cycle;
filldraw(SecStar, linewidth(0.05u)+white, black);
label(minipage("\centering S"), (r_2, 0), black);
label(minipage("\centering $M_2$"), (r_2 - R_2 - 0.3u, 0));

// draw the center of mass
path CM=(-0.05u, 0)..(0, -0.05u)..(0.05u, 0)..(0, 0.05u)..cycle;
filldraw(CM);
label(minipage("\centering CM"), (0, 0.15u));

// draw the lines
path a1=(0u, -1.1 * R_2)--(r_1, -1.1 * R_2);
draw(a1, linewidth(0.03u)+blue, Arrow);
label(minipage("\centering $a_1$"), (r_1/2, -1.1 * R_2 - 0.3u), blue);

path a2=(0u, -1.1 * R_2)--(r_2, -1.1 * R_2);
draw(a2, linewidth(0.03u)+red, Arrow);
label(minipage("\centering $a_2$"), (r_2/2, -1.1 * R_2 - 0.3u), red);

path cml = (0u, 0u)--(0u, -1.1 * R_2);
draw(cml, linewidth(0.02u)+dashed);

path aa1=(0u, 1.1 * R_2)--(r_1, 1.1 * R_2);
draw(aa1, linewidth(0.03u), Arrow);
path aa2=(0u, 1.1 * R_2)--(r_2, 1.1 * R_2);
draw(aa2, linewidth(0.03u), Arrow);
label(minipage("\centering $a = a_1 + a_2$", width=5u), (0u, 1.1 * R_2 + 0.15u));

// draw two arcs representing rotation
real ar_1 = (abs(r_1) + R_1) * 1.2, ar_2 = (abs(r_2) + R_2) * 1.2;

path arc_1 = (-ar_1, 0)..(-ar_1 * cos(0.2), -ar_1 * sin(0.2))..(-ar_1 * cos(0.4), -ar_1 * sin(0.4));;
draw(arc_1, linewidth(0.02u), Arrow);

path arc_2 = (ar_2, 0)..(ar_2 * cos(0.2), ar_2 * sin(0.2))..(ar_2 * cos(0.4), ar_2 * sin(0.4));;
draw(arc_2, linewidth(0.02u), Arrow);

// draw omega
