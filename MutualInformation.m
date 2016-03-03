function I = MutualInformation(P)
%Implemented by Maja Scherman 2016-02-01
% The mutual information I(X;Y)
%
% P=P(X,Y) is the joint probability of X and Y.

%prepare X matrix for the P(X) probabilities.
[n,m] = size(P); %row column
X = zeros(1,m);
PX = transpose(X);

for column = 1:m,
    for row = 1:n,
        PX(row) = PX(row) + P(row,column);
    end
end
HX = Entropy(PX);

%prepare P(Y)
PY = zeros(1,m);

%calculate P(Y)
for column = 1:m,
    for row = 1:n,
        PY(column) = PY(column) + P(row,column);
    end
end

%prepare next matrix
PXcondY = zeros(size(P));

%Calculate P(X|Y)=P(X,Y)/P(Y)
for row = 1:n,
    for column = 1:m,
        PXcondY(row,column) = P(row,column)/PY(column);    
    end
end

HXcondYprim = Entropy(PXcondY);
%prepare matrix for calculating the entropy.

[n,m] = size(HXcondYprim);
HXcondYbis = zeros(n,m);

%calculate p(Y)*H(X|Y) in a vector. The probabilities sum up to 1.
for row = 1:n,
    for column = 1:m,
        HXcondYbis(column) = PY(column)*HXcondYprim(column);
    end
end

HXcondY = sum(HXcondYbis);
I = HX - HXcondY;



