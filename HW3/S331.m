image = imread('HW3/own.jpg');
image = rgb2gray(image);

image_smooth = imgaussfilt(image,5);
x = image+ 2*image_smooth;
x = median_filter(x,3);

imwrite(image,"image.png");
imwrite(x,"out.png");

function output= median_filter(image,length)
    [R,C] = size(image);
    image = padarray(image,[floor(length/2),floor(length/2)]);
    output = zeros(R,C,'uint8');
    for i=1:R
        for j=1:C
            part = image(i:i+length-1,j:j+length-1);
           
            out = median(part,'all');
            output(i,j) = out;
        end
    end
end