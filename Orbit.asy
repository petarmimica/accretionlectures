import graph3;
import palette;
import fontsize;

defaultpen(Helvetica()+fontsize(48));
real u=2cm;
size(20u);

triple curx, curv;

real Power(real x, real a) {
  return x^a;
}

// Compute L1
real ComputeL1(real q) {

  real x, oldx, eps;

  eps = 0.000001;
  oldx = 1.0;
  x = 0.01;



  for (int i = 1; i< 1000; ++i) {

    oldx = x;
    
    real f = Power(1 + q,-2) - Power(q,3)/Power(1 + q,2) + 
   (((-1 - q)*Power(q,2))/Power(1 + q,4) - 2/(1 + q) - (2*Power(q,2))/(1 + q))*x + 
   (1 - q + (2*(-1 - q)*q)/Power(1 + q,3) - (2*(-1 - q)*Power(q,2))/Power(1 + q,3))*
    Power(x,2) + ((-1 - q)/Power(1 + q,2) - (4*(-1 - q)*q)/Power(1 + q,2) + 
      ((-1 - q)*Power(q,2))/Power(1 + q,2))*Power(x,3) + 
      ((-2*(-1 - q))/(1 + q) + (2*(-1 - q)*q)/(1 + q))*Power(x,4) + (-1 - q)*Power(x,5);
    
    real df = ((-1 - q)*Power(q,2))/Power(1 + q,4) - 2/(1 + q) - (2*Power(q,2))/(1 + q) + 
   (2 - 2*q + (2*(-1 - q)*q)/Power(1 + q,3) - (2*(-1 - q)*Power(q,2))/Power(1 + q,3) - 
      (2*q)/Power(1 + q,2) + (2*Power(q,2))/Power(1 + q,2))*x + 
   ((-1 - q)/Power(1 + q,2) - (4*(-1 - q)*q)/Power(1 + q,2) + 
      ((-1 - q)*Power(q,2))/Power(1 + q,2) - 2/(1 + q) + (8*q)/(1 + q) - 
      (2*Power(q,2))/(1 + q))*Power(x,2) + 
   (6 - 6*q - (2*(-1 - q))/(1 + q) + (2*(-1 - q)*q)/(1 + q))*Power(x,3) + 
      (-1 - q - 4*(1 + q))*Power(x,4);

    x = x - f/df;

  }

  return x;
  

}

// acceleration for the orbit integration
triple ComputeAcc(triple x, triple v, real q) {

  triple vec1 = x - (-q / (1.0 + q), 0, 0);
  triple vec2 = x - (1 / (1.0 + q), 0, 0);

  triple acc =  -vec1 / length(vec1)^3 - q * vec2 / length(vec2)^3 + (1.0 + q) * sqrt(x.x^2 + x.y^2) * (1, 1, 0) - 2 * (-v.y, v.x, 0) * sqrt(1.0 + q);

  return acc;
  
}

// orbit integration
path3 VelocityVerlet(triple x0, triple v0, real tmax, real dt, real q) {

  path3 pos=(x0.x * u, x0.y * u, x0.z * u);

  real curt = 0.0, curdt = dt;

  triple x, v;
  
  x = x0;
  v = v0;
  
  while (curt < tmax) {
    if (curt + curdt > tmax) {curdt = tmax - curt;}
    
    triple vhalf = v + 0.5 * ComputeAcc(x, v, q) * curdt;
    x = x + vhalf * curdt;
    v = vhalf + 0.5 * ComputeAcc(x, vhalf, q) * curdt;

    pos=pos--(x.x * u, x.y * u, x.z * u);
    
    curt = curt + curdt;
  }

  curx = x;
  curv = v;

  return pos;

}


// parameters of the system
real q = 0.3;
real tmax = 1.5e0;
real dt = 5e-3;

// compute L1
real xL1 = ComputeL1(q);

// initial data
triple x0 = (xL1 - 0.1, 0, 0);
triple v0 = (0, 0, 0);

triple x = x0, v = v0;

// projection
currentprojection=orthographic(0, 0, 2u);

// plot the stars
real prim=-q * u /(1.0 + q), sec=u / (1.0 + q);
real rad=0.01 u;

draw((prim - rad, 0, 0)..(prim, - rad, 0)..(prim + rad, 0, 0)..(prim,  + rad, 0)..cycle, linewidth(0.1u)+blue);

draw((sec - rad, 0, 0)..(sec, - rad, 0)..(sec + rad, 0, 0)..(sec,  + rad, 0)..cycle, linewidth(0.1u)+red);

// join the stars and mark L1
draw((prim, 0, 0)--(sec, 0, 0));
draw((xL1 * u, -0.01u, 0)--(xL1 * u, 0.01u, 0));
label("$L1$", O, (xL1 * u - 0.05u, 0.04u, 0));

// draw the center of mass
draw((0, -0.01u, 0)--(0, 0.01u, 0), linewidth(0.03u)+green);
label("$CM$", O, ( 0.01u, -0.03u, 0), green);

// circulatization radius
real rcirc = (1.0 + q) * (xL1 - prim/u)^4 * u;
draw((prim - rcirc, 0, 0)..(prim, rcirc, 0)..(prim + rcirc, 0, 0)..(prim, -rcirc, 0)..cycle, linewidth(0.03u)+red);
draw((prim, 0, 0)--(prim, rcirc, 0), linewidth(0.08u)+red, Arrow3);
label("$R_{\rm circ}$", O, (prim, rcirc +0.04u, 0), red);

// trajectory
for (int i = 0; i <= tmax / 1e0; ++i) {

  path3 traj = VelocityVerlet(x, v, 1e0, dt, q);
  draw(traj, linewidth(0.02 * (i+1) * u));


  x = curx;
  v = curv;
 }



//xaxis3(Label("$x$"), blue, Arrow3);
//yaxis3(Label("$y$"), blue, Arrow3);
