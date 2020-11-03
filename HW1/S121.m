image = imread("HW/Homeworks/Images/1/Barbara.bmp");
I = rgb2gray(image);
x = I;
level8 =32*round(x/32);
level16 =16*round(x/16);
level32 =8*round(x/8);
level64 =4*round(x/4);
level128 =2*round(x/2);
figure
subplot(2,3,1)
imshow(level8);
title(immse(level8,x));
subplot(2,3,2)
imshow(level16);
title(immse(level16,x));
subplot(2,3,3)
imshow(level32);
title(immse(level32,x));
subplot(2,3,4)
imshow(level64);
title(immse(level64,x));
subplot(2,3,5)
imshow(level128);
title(immse(level128,x));
subplot(2,3,6)
imshow(x);
title(immse(x,I));


x = histeq(x);

level8 =32*round(x/32);
level16 =16*round(x/16);
level32 =8*round(x/8);
level64 =4*round(x/4);
level128 =2*round(x/2);

figure
subplot(2,3,1)
imshow(level8);
title(immse(level8,x));
subplot(2,3,2)
imshow(level16);
title(immse(level16,x));
subplot(2,3,3)
imshow(level32);
title(immse(level32,x));
subplot(2,3,4)
imshow(level64);
title(immse(level64,x));
subplot(2,3,5)
imshow(level128);
title(immse(level128,x));
subplot(2,3,6)
imshow(x);
title(immse(x,x));
