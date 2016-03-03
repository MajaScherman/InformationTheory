function F = PrintChars(Txt)

[~,n]=size(Txt);
disp(n);
for i = 1:n
   c=Txt(i:i);
   disp(cast(c,'uint8'));
   disp(c);
end