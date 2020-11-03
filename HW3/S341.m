image = imread('Homeworks/Images/3/Lena.bmp');
image = double(rgb2gray(image));

filter1 = [1 0 -1]/2;
filter2 = [1 0 -1;1 0 -1;1 0 -1]/6;
filter3 = [1 0 -1;2 0 -2;1 0 -1]/8;
filter4 = [1 0 0;0 -1 0;0 0 0 ];
filter5 = [0 1 0;-1 0 0;0 0 0];



im1 = filtering(image,filter1);
im2 = filtering(image,filter2);
im3 = filtering(image,filter3);

imwrite(im1,'f1.png');
imwrite(im2,'f2.png');
imwrite(im3,'f3.png');

function output=filtering(image,filter)
    [R,C] = size(image);
    [x,y] = size(filter);
    image = padarray(image,[1,1]);
    output = zeros(R,C,'double');
    for i=1:R
        for j=1:C
            part = image(i:i+x-1,j:j+y-1);
            mult = part.*filter;
            out = sum(mult,'all');
            output(i,j) = out;
        end
    end
end