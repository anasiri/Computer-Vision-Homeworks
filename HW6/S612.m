img = imread('Homeworks/Images/6/Lena.bmp');
img = rgb2gray(img);

levels = 3;
[pyramid,laplacians] = laplace_pyramid(img,levels);    

[n,~] = size(laplacians);

last_img = laplacians{n};
for i=1:levels
    n = n-1;
    last_img = pixel_rep(last_img);
    last_img = last_img + laplacians{n};
end
last_img = uint8(last_img);

p = psnr(img,last_img);
imshow(last_img);
m = immse(last_img,img);
figure
imshow(pyramid);


imwrite(pyramid,'x.png');


function [final,laplacians_last_img] = laplace_pyramid(img,levels)
    
    avg_filter = [1 1;1 1]/4;
    [R,C]  = size(img);
    final = zeros(2*R,2*C,'uint8');
    old_img = double(img);
    
    N = levels;
    laplacians_last_img = cell(N,1);
    for i=1:levels
        
        r1 = R-(0.5)^(i-1)*R+1;
        r2 = R;
        
        c1 = ((2^(i-1)-1)/(2^(i-2)))*C+1;
        c2 = (2^(i)-1)/(2^(i-1))*C;
        
        final(r1:r2,c1:c2) = old_img;
        
        new_img = average_filter(old_img,avg_filter);
        
        
        laplace = old_img - pixel_rep(new_img);
    
        laplacians_last_img{i} = laplace;
        
        laplace = norm(laplace);
        laplace = uint8(laplace);
        
        r1 =R+1;
        r2 = R+(0.5)^(i-1)*R;
        
        final(r1:r2,c1:c2)=laplace ;
        old_img = new_img;
    end
    
    i = levels+1;
    r1 = R-(0.5)^(i-1)*R+1;
    r2 = R;
    c1 = ((2^(i-1)-1)/(2^(i-2)))*C+1;
    c2 = (2^(i)-1)/(2^(i-1))*C;
    final(r1:r2,c1:c2) = old_img;
    r1 =R+1;
    r2 = R+(0.5)^(i-1)*R;
    final(r1:r2,c1:c2) = old_img;
    
    laplacians_last_img{levels+1}=old_img;
end
function output = pixel_rep(img)
    [r,c] = size(img);
    output = zeros(2*r,2*c,class(img)); %// Change
    for x = 1:r %// Change
        for y = 1:c
            j = 2*(x-1) + 1; %// Change
            i = 2*(y-1) + 1; %// Change           
            output(j,i) = img(x,y); %// Top-left
            output(j+1,i) = img(x,y); %// Bottom-left
            output(j,i+1) = img(x,y); %// Top-right
            output(j+1,i+1) = img(x,y); %// Bottom-right
        end
    end
end
function output=average_filter(image,filter)
    [R,C] = size(image);
    output = zeros(R/2,C/2,'double');
    for i=1:2:R
        for j=1:2:C
            part = double(image(i:i+1,j:j+1));
            mult = part.*filter;
            out = sum(mult,'all');
            output(ceil(i/2),ceil(j/2)) = out;
        end
    end
end

function output = norm(img)
    output = mat2gray(img);
    Max = max(max(output));
    Min = min(min(output));
    output = (255/(Max-Min))*output;
    
end