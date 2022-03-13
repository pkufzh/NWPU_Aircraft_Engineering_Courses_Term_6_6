function [x, error, iter] = mybicgstab(A,b,x0,epsilon,nb_it)
% MYBICGSTAB Solving the linear system Ax=b using the Unpreconditioned
% BiConjugate Gradient Stabilized Method .
% 如果没有输入则自动设置求解精确解为1的200阶希尔伯特方程组
% input   
%         A         matrix
%         x          initial guess vector
%         b          result vector
%         nb_it      maximum number of iterations 
%         epsilon   the error tolerance used to converge
% output
%         x          solution vector
%         error    error norm
%         iter       number of iterations performed
if nargin==0
    nnn=200;
    A=hilb(nnn); b=A*ones(nnn,1); epsilon=1e-12; nb_it=100,x0=zeros(nnn,1);
end
  x=x0;  iter = 0;  alpha=1;  norm_b= norm( b );
  %Note norm(x) is the Euclidean length of a vector x. On the other hand,
  %MATLAB software uses "length" to denote the number of elements n in a vector. 
  %We used here to calculate the error diffrence (i.e. Norm(b-A*x)/Norm(b)) in each iteration
  if  ( norm_b== 0 ),              %if  b is all zeros
    x = x*0;                % then  the solution is all zeros
    error=0;
    disp('the result vector is all zeros');
    return;
  end
  r = b - A*x;
  %size(r)
   error = norm( r ) / norm_b;
   if ( error < epsilon ) 
       return;
   end
  omega  = 1.0;
  r_tld = r;
  for iter = 1:nb_it,                              % begin iteration
     rho   = ( r_tld'*r );                         
     if ( rho == 0 ) 
         break;
     end
     if ( iter > 1 ),
        beta  = ( rho/rho_1 )*( alpha/omega );
        p = r + beta*( p - omega*v );
     else
        p = r;
     end
     v = A*p;
     alpha = rho / ( r_tld'*v );
     s = r - alpha*v;
     t = A*s;
     omega = ( t'*s) / ( t'*t );
     x = x + alpha*p + omega*s;
     r = s - omega*t;
     error = norm( r ) / norm_b;  
     %convergence
     if ( error <= epsilon ), 
         disp('the algorithm converged');
         break;
     end
     %no solution
     if ( omega == 0 ), 
         disp('omega is equale to zero.');
         break; 
     end
     if ( rho == 0 ), 
         disp('rho is equale to zero.');
         break; 
     end
     %continue
     rho_1 = rho;
  end
% no convergence
  if (iter==nb_it ),                 
     disp('maximum number of iteration reached.');
  end
