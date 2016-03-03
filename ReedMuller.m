function G = ReedMuller()
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Implementation of a Reed-Muller Code for error correction and detection encoding and decoding.
%Implemented by Maja Scherman 2016-02-19
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Initialize the Generator and the input matrices
%G=[1 0 1 0 1 0 1 0; 0 1 1 0 0 1 1 0; 0 0 1 1 0 0 1 1; 0 0 0 0 1 1 1 1];
G = [1 0 1 0 1 0 1 0; 0 1 0 1 0 1 0 1; 0 0 1 1 0 0 1 1; 0 0 0 0 1 1 1 1];
disp(G);
U = [0 0 0 0; 0 0 0 1; 0 0 1 0; 0 0 1 1; 0 1 0 0; 0 1 0 1; 0 1 1 0; 0 1 1 1; 1 0 0 0; 1 0 0 1; 1 0 1 0; 1 0 1 1; 1 1 0 0; 1 1 0 1; 1 1 1 0; 1 1 1 1];
X = mod(U*G,2);
disp(num2str(X));
P=bin2dec(num2str(X));
%Calculate hamming distance between codewords
min = 8;
for ii = 1:16
    for i = 1:16,
        if ii ~= i
            D = sum(mod(dec2bin(P(ii),8)-dec2bin(P(i),8),2));
            if min > D
                min = D;
            end
        end
    end
end
disp('The hamming distance is');
disp(min);

test = mod(G*transpose(G),2);
disp('Check that G is H by checking that Gtranspose(G)=0');
disp(test);

disp('Check that H is a partity matrix by xtranspose(H)=0, theorem 7.3');
test2 = mod(X*transpose(G),2);
disp(test2);
%Error matrix
E = [0 0 0 0 0 0 0 0; 0 0 0 0 0 0 0 1; 0 0 0 0 0 0 1 0; 0 0 0 0 0 1 0 0; 0 0 0 0 1 0 0 0; 0 0 0 1 0 0 0 0; 0 0 1 0 0 0 0 0; 0 1 0 0 0 0 0 0; 1 0 0 0 0 0 0 0];
disp('Error matrix');
disp(E);

%Syndrome table matrix
S = mod(E * transpose(G),2);
disp('Syndrome table');
disp(S);

%Choose one codeword 00111100, introduce one error 00111101 decrypt with
%syndrom table
%Follow algorithm 7.1
y = [0 0 1 1 1 1 0 1];
s = mod(y*transpose(G),2);
%disp(s);
[~,indx]=ismember(s,S,'rows');
%disp(indx);
e = E(indx,:);
%disp(e);
x = mod(y + e,2);
%disp(x);
[~,indx2]=ismember(x,X,'rows');
%disp(indx2);
u = U(indx2,:);
disp('This is the decoded information:');
disp(u);


%Introduce double error to compare 00111111 e = 00000011
%Check some double errors
EE = [0 0 0 0 0 0 1 1; 0 0 0 0 0 1 1 0; 0 0 0 0 1 1 0 0; 0 0 0 0 0 1 0 1; 0 0 0 0 1 0 0 1; 0 0 0 1 0 0 0 1; 0 0 1 0 0 0 0 1; 0 1 0 0 0 0 0 1; 1 0 0 0 0 0 0 1];
SS =  mod(EE * transpose(G),2);
disp('Syndrome for double errors');
disp(SS);
[~,indx3]=ismember(SS,S,'rows');
disp('The zeros shows that the syndromes for the double errors can not be found in the syndromes for singel errors');
disp(indx3);

%Answer to f) yes the double errors gives syndromes different from singel
%errors, so they are detected but uncorrectable.



