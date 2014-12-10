import graph;
import palette;
import fontsize;

real diskh(real r, real Rstar) {return r^(9.0/8.0) * (1 - sqrt(Rstar / r))^(3.0/20.0);}

defaultpen(Helvetica()+fontsize(48));

real u=2cm;

size(41u, 10u);


// label the accreting object
label("compact star", (-0.35u, 3u), black);

// draw the disk edges
int Npoint = 1000;
real Rstar = 2;
real Rout = 20 * Rstar;

path disk = (Rstar * u, diskh(Rstar, Rstar) * u);
for (int i = 1; i <= Npoint; ++i) {
    real r = Rstar + (Rout - Rstar) * (real)i / (real)Npoint;
    disk = disk--(r * u, 0.1 * diskh(r, Rstar) * u);
 }   
for (int i = Npoint; i>=1; --i) {
    real r = Rstar + (Rout - Rstar) * (real)i / (real)Npoint;
    disk = disk--(r * u, -0.1 * diskh(r, Rstar) * u);
}  
for (int i = 1; i <= Npoint; ++i) {
    real r = Rstar + (Rout - Rstar) * (real)i / (real)Npoint;
    disk = disk--(-r * u, -0.1 * diskh(r, Rstar) * u);
 }   
for (int i = Npoint; i>=1; --i) {
    real r = Rstar + (Rout - Rstar) * (real)i / (real)Npoint;
    disk = disk--(-r * u, 0.1 * diskh(r, Rstar) * u);
}   
disk=disk--cycle;

filldraw(disk, gray);

// draw the accreting object
path AccretingObject=(Rstar * u, 0u)..(0u, Rstar * u)..(-Rstar * u, 0u)..(0u, -Rstar * u)..cycle;
filldraw(AccretingObject, black, black);
