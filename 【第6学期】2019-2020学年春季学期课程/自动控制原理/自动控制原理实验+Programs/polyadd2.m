function poly=polyadd2(a,b)
% polyadd2(a,b) adds two polynominals possibly of uneven length
    a=a(:).';
    b=b(:).';
    na=length(a);
    nb=length(b);
    poly=[zeros(1,nb-na) a]+[zeros(1,na-nb) b];
end