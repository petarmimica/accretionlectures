//import graph;
import graph3;
import palette;
import fontsize;

// square
real sqr(real x) { return x*x;}

// Roche potential
triple phi_R(real x, real y, real z, real q) {


  real dist1 = sqrt(sqr(x + q / (1.0 + q)) + sqr(y) + sqr(z));
  real dist2 = sqrt(sqr(x - 1.0 / (1.0 + q)) + sqr(y) + sqr(z));
  
  real pot = - 1.0 / dist1 - q / dist2 - (1.0 + q) * (sqr(x) + sqr(y)) / 2.0;
  
  if (pot < -6.0) pot = -6.0;

  return(x, y, pot);

}

defaultpen(Helvetica()+fontsize(48));

real u=2cm;

size(10u);

currentprojection=orthographic(-1u, 3u, 4u);

real q = 0.3;

triple f(pair z) {return phi_R(z.x / u, z.y /u, 0, q);}

surface rpot = surface(f, (-1.5u, -1.5u), (1.5u, 1.5u), 200,200,Spline);

//draw((-3u, -3u, 0)--(-3u, 3u, 0)--(3u, 3u, 0)--(3u, -3u, 0)--cycle);

draw(rpot, lightgray, render(merge=true));

//xaxis3(Label("$x$"), blue, Arrow3);
//yaxis3(Label("$y$"), blue, Arrow3);
//zaxis3(XYZero(extend=true),blue, Arrow3);

