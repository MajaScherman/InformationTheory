function L = LZW(Txt)
L=1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Implementation of LZW
%Implemented by Maja Scherman 2016-02-08, 
%but the linebreak is not implemented correctly, use the method from Huffman.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%Initialize a dictionary.
dict = struct('n',0,'Codeword',[],'Ind',[],'Dictionary',[],'bits',[],'Binary',[]);


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
dict(27).Ind = 39;

dict(28).Dictionary = '''';
dict(28).Ind = 32;
%dict(29).Dictionary = '\r';
%dict(29).Ind = 13;
dict(29).Dictionary = '\n';
dict(29).Ind = 10;

%This cant handle linebreak! fix!

%*********************************************************************
%Here starts the algorithm
%*********************************************************************

Ind = 30;
[~,len] = size(Txt);
disp(len);
%initiazion of dictionary finished
%loop until n is at end of the text
%disp(isequal('ee','hee')); <- false :D

n=1;
while n < len
    % find xn in dict
    %a = Txt(n:n);
    %disp(a);
    %***********************************can I really remove thisP????
    %index = 0;
    %match = false(Ind,1);
    %for iii = 1:Ind-1
     %   match(iii) = isequal(dict(iii).Dictionary,a);
    %end
    
    %index = find(match);
    %disp(dict(index)); %*************************************xn
    
    %find longest match xn,..,x(n+l-1) in dict
    found = true;
    l = 0;
    longestindex = 0;
    while found == true,
    %for l = 1:len   
        l = l + 1;
        b = Txt(n:n+l-1);
        %disp(b);
        match = false(Ind,1);
        for ii = 1:Ind-1
            match(ii) = isequal(dict(ii).Dictionary, b);
        end
        sol = find(match);
        if sol > 0
            if longestindex == 0
                longestindex=sol;
            else
                str1 = dict(longestindex).Dictionary;  
                str2 = dict(sol).Dictionary;                
                if length(str2) > length(str1) % sol > longestindex
                    longestindex=sol;
                end
            end
            
            if (n+l) > len 
                found = false;
            end
            
        else
           % longestindex = sol;
            found = false;
            l = l - 1;
        end
        
        
    end
    %disp(dict(Ind-1));
    %***********************************************************
    %add the longest match + 1 to dict
    %dict(Ind).Dictionary = Txt(n:n+l); %this makes matrix out of bounds in
    %life on mars.
    if (n+l)<len +1%is this way correct? Test???
        
        dict(Ind).Dictionary = Txt(n:n+l);
        dict(Ind).Codeword = longestindex;
    else
        %How should I do with the last row???
        Ind = Ind -1;
       %dict(Ind).Dictionary = Txt(n:len);
    end
    %the codeword is set to the match.
    
    
    %disp(dict(Ind));
    
    %*************************************
    %increment indexes
    n = n + l;
    Ind = Ind + 1;
end
%loop end, end of the text

for iiii = 30:Ind-1,
    disp(dict(iiii));
end

disp(Ind-1);





