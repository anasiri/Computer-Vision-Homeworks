image = imread('Homeworks/Images/3/Lena.bmp');
image = rgb2gray(image);

image1 = imnoise(image,'salt & pepper',0.05);
image2 = imnoise(image,'salt & pepper',0.1);
image3 = imnoise(image,'salt & pepper',0.2);

imgs{1} = image1;
imgs{2} = image2;
imgs{3} = image3;
filters = [3,5,7,9];

immse(image,median_filter(image3,9))
%{
mses = zeros(3,4,'double');
for i=1:3
    for j=1:4
        img = imgs(i);
        img = img{1};
        f = filters(j);
        x = median_filter(img,f);
        name = "noise"+i+"_"+"filter"+j+".png";
        imwrite(x,name);
        mses(i,j) = immse(image,x);
    end
end
%}

function output=median_filter(image,length)
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