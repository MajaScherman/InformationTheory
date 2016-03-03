function A = Huffman(Txt)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%An implementation of huffman encoding based on an arbitrary text
%Before running, observe the allowed symbols a-z space and apostrophy
%Implemented by Maja Scherman 2016-02-08
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Initialize a dictionary.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dict = struct('counter',[],'parent',[],'Ind',[],'Dictionary',[],'bits',[],'Binary',[],'children',[], 'sorted', []);


dict(1).Dictionary = 'a';
dict(1).Ind = 97;
dict(2).Dictionary = 'b';
dict(2).Ind = 98;
dict(3).Dictionary = 'c';
dict(3).Ind = 99;

dict(1).Dictionary = 'a';
dict(1).Ind = 97;
dict(2).Dictionary = 'b';
dict(2).Ind = 98;
dict(3).Dictionary = 'c';
dict(3).Ind = 99;

dict(4).Dictionary = 'd';
dict(4).Ind = 100;
dict(5).Dictionary = 'e';
dict(5).Ind = 101;
dict(6).Dictionary = 'f';
dict(6).Ind = 102;

dict(7).Dictionary = 'g';
dict(7).Ind = 103;
dict(8).Dictionary = 'h';
dict(8).Ind = 104;
dict(9).Dictionary = 'i';
dict(9).Ind = 105;

dict(10).Dictionary = 'j';
dict(10).Ind = 106;
dict(11).Dictionary = 'k';
dict(11).Ind = 107;
dict(12).Dictionary = 'l';
dict(12).Ind = 108;

dict(13).Dictionary = 'm';
dict(13).Ind = 109;
dict(14).Dictionary = 'n';
dict(14).Ind = 110;
dict(15).Dictionary = 'o';
dict(15).Ind = 111;

dict(16).Dictionary = 'p';
dict(16).Ind = 112;
dict(17).Dictionary = 'q';
dict(17).Ind = 113;
dict(18).Dictionary = 'r';
dict(18).Ind = 114;

dict(19).Dictionary = 's';
dict(19).Ind = 115;
dict(20).Dictionary = 't';
dict(20).Ind = 116;
dict(21).Dictionary = 'u';
dict(21).Ind = 117;

dict(22).Dictionary = 'v';
dict(22).Ind = 118;
dict(23).Dictionary = 'w';
dict(23).Ind = 119;
dict(24).Dictionary = 'x';
dict(24).Ind = 120;

dict(25).Dictionary = 'y';
dict(25).Ind = 121;
dict(26).Dictionary = 'z';
dict(26).Ind = 122;
dict(27).Dictionary = ' ';
dict(27).Ind = 32;

dict(28).Dictionary = '''';
dict(28).Ind = 39;
dict(29).Dictionary = '\r';
dict(29).Ind = 13;
dict(30).Dictionary = '\n';
dict(30).Ind = 10;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Initialization
[dict.counter] = deal(0);
[dict.sorted] = deal(0);
[dict.children] = deal(0);

[~,N] = size(Txt);
Ind = 30; %index
n = 0;%for identifing chars in the text
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Count instances in the text
for i = 1:N
    n = n + 1;
    % find xn in dict
    a = Txt(n:n);
    aa = cast(a,'uint8');
    match = false(Ind+1,1);
    for iii = 1:Ind
        match(iii) = isequal(dict(iii).Ind,aa);
    end
    index = find(match);
    dict(index).counter = dict(index).counter + 1;    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Sort based on frequency
X = zeros(1,Ind); %Vector for sorted indexes
for i = 1:Ind 
    highestindex = 0;
    highestcounter = 0;    
    for ii = 1:Ind     
        temp = dict(ii).counter;
        sorted = dict(ii).sorted;
        if temp >= highestcounter && sorted ~= 1
            highestcounter = temp;
            highestindex = ii;
        end
    end
    X(i) = highestindex;
    dict(highestindex).sorted = 1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%connect the two nodes with the least probability and remove them from the
%list. Add the connected node to the list. Repeat until every node is
%connected in a binary tree. This tree is saved in the dict structure.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
xindex = Ind;
while xindex > 1
    Ind = Ind + 1;
    dict(X(xindex)).parent = Ind;
    dict(X(xindex-1)).parent = Ind;
    dict(Ind).counter = dict(X(xindex)).counter + dict(X(xindex-1)).counter;
    dict(Ind).children = [X(xindex) X(xindex-1)];
    X(xindex) = 0;
    X(xindex - 1)= 0;
    xindex = xindex - 1;
    X(xindex) = Ind;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %resort the x vector
    [dict.sorted] = deal(0);
    for iii = 1:Ind
        highestindex = 0;
        highestcounter = 0;
        for ii = 1:Ind
            temp = dict(ii).counter;
            sorted = dict(ii).sorted;
            if temp >= highestcounter && sorted ~= 1
                highestcounter = temp;
                highestindex = ii;
            end
        end
        X(iii) = highestindex;
        dict(highestindex).sorted = 1;
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Calculate the optimal huffman encoding for each of the leaves.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[dict.Binary] = deal('');
for i = Ind:-1:1
   children = dict(i).children;
   if children ~= 0
       child1 = children(1);
       child2 = children(2);
       dict(child1).Binary = [dict(i).Binary '1'];
       dict(child2).Binary = [dict(i).Binary '0'];
   end
   [~,b] = size(dict(i).Binary);
   dict(i).bits = b;
   
   
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Output, the codetable
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:Ind%30
    disp(dict(i));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Some calculations on the data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Totalbits
meanbits = 0;
for i = 1:30
    meanbits = meanbits + dict(i).bits*(dict(i).counter/N);%bits*p
end

disp('Average Code Length of the bits for the encoding:');
disp(meanbits);

%Compressionrate
R=8/meanbits;
disp('Compressionrate:');
disp(R);


%Total length of the text encoded.
totallength = 0;
for i = 1:30
    totallength = totallength + dict(i).counter*dict(i).bits;
end
disp('Total length encoded in bits:');
disp(totallength);

%For comperation with 8 bits
totallength = 0;
for i = 1:30
    totallength = totallength + dict(i).counter*8;
end
disp('Total length encoded with 8 bits:');
disp(totallength);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%The returnvalue contains all the information about the encoding.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
A=dict;

















