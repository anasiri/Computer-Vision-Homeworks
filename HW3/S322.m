image = imread('Homeworks/Images/3/Lena.bmp');
image = rgb2gray(image);

image1 = imnoise(image,'gaussian',0.01);
image2 = imnoise(image,'gaussian',0.05);
image3 = imnoise(image,'gaussian',0.1);

imgs{1} = image1;
imgs{2} = image2;
imgs{3} = image3;
filters = [3,5,7,9];
immse(image,box_filter(image3,9))
for i=1:3
    for j=1:4
        img = imgs(i);
        img = img{1};
        f = filters(j);
        x = box_filter(img,f);
        name = "noise"+i+"_"+"box_filter"+j+".png";
        imwrite(x,name);
    end
end

for i=1:3
    for j=1:4
        img = imgs(i);
        img = img{1};
        f = filters(j);
        x = median_filter(img,f);
        name = "noise"+i+"_"+"median_filter"+j+".png";
        imwrite(x,name);
    end
end

function output=box_filter(image,filter)
    [R,C] = size(image);
    image = padarray(image,[1,1]);
    output = zeros(R,C,'uint8');
    for i=1:R
        for j=1:C
            part = image(i:i+2,j:j+2);
            mult = part.*filter;
            out = sum(mult,'all')/9;
            output(i,j) = out;
        end
    end
end

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