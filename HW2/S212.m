image = imread('Homeworks\Images\2\Camera Man.bmp');


new_image = hist_eq(image);
hist_orig = hist(image);
hist_eqimg = hist(new_image);

subplot(2,2,1);
imshow(image);
title('original');
subplot(2,2,2);
bar(hist_orig);
title('original hist');
subplot(2,2,3);
imshow(new_image);
title('histeq');
subplot(2,2,4);
bar(hist_eqimg);
title('histeq hist');

function new_image = hist_eq(img)
    [r,c] = size(img);
    n = r * c;
    
    new_image = zeros(r,c,'uint8');
    
    cdf = zeros(256,1);
    count = zeros(256,1);
    out = zeros(256,1);
    for i=1:r
        for j=1:c
            value = img(i,j);
            count(value+1) = count(value+1)+1;
        end
    end
    pdf = count/n;
    sum = 0; L =255;
    for i=1:256
        sum = sum +pdf(i);
        cdf(i) = sum;
        
        out(i) = round(cdf(i)*L);
    end
    for i=1:r
        for j=1:c
            new_image(i,j) = out(img(i,j)+1);
        end
    end
end

function Hist = hist(img)
    [R,C]=size(img);
    Hist=zeros(256,1);
    for r = 1:R
        for c=1:C
            Hist(img(r,c)+1,1)=Hist(img(r,c)+1,1)+1;
        end
    end
end