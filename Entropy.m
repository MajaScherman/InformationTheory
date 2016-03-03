function H=Entropy(P)
% The Entropy function H(X)
% Implemented by Maja Scherman 2016-02-01
%
% P column vector: the vector is the probability distribution.
% P matrix: Each column vector is interpreted as a probability distribution
% P scalar: The binary entropy function of [P; 1-P]
% P row vector: Each position gives binary entropy function

% Entropy is calculated like the formula below but since log2(0) is not 
% defined the calculation is done by looping and adding term by term.
%-sum(P .* log2(P));

%prepare loop
[n,m] = size(P);%row,column
%controll if input is scalar or not.
if n == 1
    scalar = true;
else
    scalar = false;
end
H = zeros(1,m);

%Executing H = -sum(P .* log2(P)); with 0*log2(0)=0;
for column = 1:m,
    for row = 1:n,  
        x=P(row,column);
        if x == 0
            continue;
        end
        %in case of scalar, use the binary entropy function
        if scalar == true
           y = -(x* log2(x)) - (1-x)*log2(1-x);
        else
            y = -(x*log2(x));
        end
        H(column) = H(column) + y;
    end
end

