lena = imread('Homeworks\Images\4\Lena.bmp');
f16 = imread('Homeworks\Images\4\F16.bmp');
baboon = imread('Homeworks\Images\4\Baboon.bmp');

img = f16;
img = rgb2gray(img);
imshow(img);
imwrite(img,'out.png');
img = double(img);

[M,N] = size(img);

img = fft2(img,M,N);
img = fftshift(img);
img = abs(img);
img = log(img);
Max = max(max(img ));
img = (img )*(255/Max);
img = uint8(img);

