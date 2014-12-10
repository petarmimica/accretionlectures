import graph;
import palette;
import fontsize;


defaultpen(Helvetica()+fontsize(48));

real u=2cm;

size(12u, 12u, IgnoreAspect);

// draw the axes
draw((-3u, 0u)--(10u, 0u), linewidth(0.06u)+blue, Arrow);
label("$r$", (5u, -0.6u), blue);

draw((-3u, 0u)--(-3u, 10u), linewidth(0.06u)+blue, Arrow);
label("$z$", (-3.6u, 5u), blue);

// draw the isobare
path isobare=(0, 0);
int numPoints=1000;
real maxr = 9, dr = maxr / (real)numPoints;
for (int i = 1; i <=numPoints; ++i) {
    real r = dr * (real)i;
    real z = 3 * sqrt(r);
    isobare=isobare--(r * u, z * u);
}
draw(isobare, linewidth(0.05u)+red);
label("{ $P(r, z) = const.$}", (4.5u, 3u), red);


// draw the gradient vector
real r0 = 4.0, z0 = 3 * sqrt(r0);
pair egrad = (sqrt(3) / sqrt(3.0 + r0), -sqrt(r0) / sqrt(3.0 + r0));

path vecgrad=(r0 * u, z0 * u)--((r0 * u, z0 * u)-egrad * 3u);
draw(vecgrad, linewidth(0.04u), Arrow);
label("{$-\nabla P/\rho$}", ((r0 * u + 2u, z0 * u)-egrad * 3u));

// draw the effective gravity
path effgrav=(r0 * u, z0 * u)--((r0 * u, z0 * u)+egrad * 3u);
draw(effgrav, linewidth(0.04u), Arrow);
label("{$\vec{g}_{eff}$}", ((r0 * u, z0 * u + 1.2u)+egrad * 3u));

// draw the centrifugal acceleration
path centracc=(r0 * u, z0 * u)--((r0 * u, z0 * u) + 1.3 * (egrad.x, 0) * 3u);
draw(centracc, linewidth(0.03u), Arrow);
label("{\LARGE $\Omega^2 \vec{r}$}", ((r0 * u, z0 * u + 0.4u) + 1.3 * (egrad.x / 2, 0) * 3u)); 

// draw the gravity
path grav=(r0 * u, z0 * u)--((r0 *u, z0 * u) + (-0.3 * egrad.x, egrad.y) * 3u);
draw(grav, linewidth(0.03u), Arrow);
label("{\LARGE $-\nabla\Phi$}", (r0 *u - 0.5u, z0 * u) + (-0.3 * egrad.x, egrad.y) * 1.5u);

