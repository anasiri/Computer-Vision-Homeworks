he1 = imread('Homeworks/Images/2/HE1.jpg');
he2 = imread('Homeworks/Images/2/HE2.jpg');
he3 = imread('Homeworks/Images/2/HE3.jpg');
he4 = imread('Homeworks/Images/2/HE4.jpg');

%{
subplot(2,2,1);
imshow(local_hist(he1,64));
subplot(2,2,2);
imshow(he2);
subplot(2,2,3);
imshow(he3);
subplot(2,2,4);
imshow(he4);
%}
he1 = rgb2gray(he3);
k_size = 128;
kernel = zeros(k_size,k_size,'double');
centerx = floor(k_size/2);
centery = floor(k_size/2);
for i=1:k_size
    for j=1:k_size
        kernel(i,j) = f(i-centerx,j-centery,4,4,0,0);
    end
end
imshow(he1);
figure
imshow(adapthisteq(he1));
%bar(kernel)

function output=f(x,y,sigmax,sigmay,ux,uy)
    output = 1/(2*pi*sigmax*sigmay);
    output = output * exp(-0.5 *((x-ux)^2/sigmax^2 +(y-uy)^2/sigmay^2 - 0*(2*(x-ux)*(y-uy))/(sigmax*sigmay)));
    %output = output * exp(-(x^2+y^2)/(2*sigmax*sigmay));
end
function output=local_hist(img,kernel,window_size)
    [r,c] = size(img);
    output = img;
    step_size = floor(window_size/8);
    
    for i=1:step_size:r
        for j=1:step_size:c
            x = window_size;
            y = window_size;
            if(r-i <=window_size)
                x = r-i;
            end
            if(c-j <= window_size)
                y = c-j;
            end
            
            local = img(i:i+x-1,j:j+y-1,:);
            new_local = hist_eq(local,kernel);
            output(i:i+x-1,j:j+y-1,:) = new_local;
            
        end
    end
    
end
function new_image = hist_eq(img,kernel)
    [r,c,z] = size(img);
    n = sum(kernel,'all');
    
    new_image = zeros(r,c,z,'uint8');
    
    cdf = zeros(256,1,'double');
    %pdf = zeros(256,1,'double');
    count = zeros(256,1,'double');
    out = zeros(256,1,'double');
    for i=1:r
        for j=1:c
            value = img(i,j);
            k = kernel(i,j);
            count(value+1) = count(value+1)+k;
        end
    end
    %bar(count);
    pdf = count/n;
    sumx = 0; L =255;
    for i=1:256
        sumx = sumx +pdf(i);
        cdf(i) = sumx;
        
        out(i) = round(cdf(i)*L);
    end
    for i=1:r
        for j=1:c
            new_image(i,j,:) = out(img(i,j,:)+1);
        end
    end
end
