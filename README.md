#A trous algorithm implemented in Matlab

This is a wavelet transform algorithm.

This algorithm allows a shift-invariant discrete wavelet decomposition. All the approximation images obtained by applying this decomposition have the same number of columns and rows as the original image.

It allows us to extend our kernel by adding holes(trous). Kernel will grow per 2  -1. If we have a 3x3 kernel the next kernel will be 5x5 then 9x9 then 17x17 etc..
In new positions we will add 0 and use the original values so we can have a constant time of execution.

The algorithm works only on grayscale images and need two parameters:
1. The image 
2. The number of iterations we want to do

It will return you the layers W and the residue of the image

The sum of all the layers plus the residue will give you back the original image.
