# InformationTheory

This is some matlab scripts related to Information Theory

### Entropy:
Calculating the entropy from the propability function. 
Input: The probabilities, either as a matrix, column vector, row vector or a scalar. 
Output: The entropy, in bits

### Mutal Information:
Calculation how much information the stochastic variables X and Y has in common.
Input: P=P(X,Y) which is the joint probability of X and Y.
Output: The mutal information, in bits

## Huffman
This is an implementation of huffman encoding. It compresses a text,
and tells how much smaller it is comparing to the uncoded case (ASCII - one symbol 8 bits)
Observe that the implemented Alphabet only has a-z space linebreak and apostrophy
as allowed symbols (can easily be extended).

Input: A text as a vector of characters. This can be done with these commandos in matlab.
 fid = fopen(’test.txt’);
 Txt = fscanf(fid,’%c’);
 fclose(fid);
 
Output: Some useful information such as compressionrate as printouts 
and a structure containg the binary encoded huffman tree.

## ReedMuller
This is an implementation of a Reed-Muller Code for error correction and detection
encoding and decoding.
It is hardcoded for simplicity in the meaning that all the matrices are already inserted, 
if you want to check another matrices just exchange them. 
Output: Printouts of the key parts of the algorithm, such as when errors is introduced, 
the syndrome table and such.

## LZW
This is an implementation of LZW(Lempel-Ziv-Welsh), lossless data compression algorithm. It is  in the widely usen Unix file compression utility compress, and is used in the GIF image format.

This script needs some fixes, it can not handle linebreaks yet. Fix as in huffman. 

