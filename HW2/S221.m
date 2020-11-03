he1 = imread('Homeworks/Images/2/HE1.jpg');
he2 = imread('Homeworks/Images/2/HE2.jpg');
he3 = imread('Homeworks/Images/2/HE3.jpg');
he4 = imread('Homeworks/Images/2/HE4.jpg');


im = rgb2gray(he4);
x = local_hist(im,512);
imshow(x);
function output=local_hist(img,step_size)
    [r,c] = size(img);
    output = img;
    
    for i=1:step_size:r
        for j=1:step_size:c
            x = step_size;
            y = step_size;
            if(r-i <=step_size)
                x = r-i;
            end
            if(c-j <= step_size)
                y = c-j;
            end
            
            local = img(i:i+x-1,j:j+y-1,:);
            
            new_local = hist_eq(local);
            output(i:i+x-1,j:j+y-1,:) = new_local;
            
        end
    end
    
end
function new_image = hist_eq(img)
    [r,c,z] = size(img);
    n = r * c;
    
    new_image = zeros(r,c,z,'uint8');
    
    cdf = zeros(256,1,'double');
    pdf = zeros(256,1,'double');
    count = zeros(256,1,'double');
    out = zeros(256,1,'double');
    for i=1:r
        for j=1:c
            value = img(i,j,:);
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
            new_image(i,j,:) = out(img(i,j,:)+1);
        end
    end
end
