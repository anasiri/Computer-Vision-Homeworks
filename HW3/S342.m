image = imread('Homeworks/Images/3/Lena.bmp');
image = double(rgb2gray(image));

filter1 = [1 0;0 -1];
filter2 = [0 1;-1 0];

x1 = filtering(image,filter1);
x2 = filtering(image,filter2);


imwrite(x1,'x1.png');
imwrite(x2,'x2.png');

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