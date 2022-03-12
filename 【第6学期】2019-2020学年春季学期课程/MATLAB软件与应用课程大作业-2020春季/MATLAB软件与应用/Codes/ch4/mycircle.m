function [s,p] = mycircle(r)
% MYCIRCLE calculate the area and perimeter of a circle
% r     圆半径
% s     圆面积
% p     圆周长
   s = pi.*r.*r;
   p = 2*pi.*r;
