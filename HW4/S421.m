img = imread('Homeworks/Images/4/Lena.bmp');
img = rgb2gray(img);

sizex = 5;
filter = 1/(sizex^2) *ones(sizex,sizex);
filter1 = [0 -1 0;-1 5 -1;0 -1 0];

x1 = filtering(img,filter);
x2 = freq_filtering(img,filter);

imshow(x1);
figure
imshow(x2);

function new_img = freq_filtering (image,filter)
    [M,N] = size(image);
    
    P = 2*M;
    Q = 2*N;
    
    padded_img = zeros(P,Q,'uint8');
    padded_img(1:M,1:N)=image;
    
    
    fourier_img = fft2(padded_img,P,Q);
    fourier_img = fftshift(fourier_img);
    
    
    fourier_filter = fft2(filter,P,Q);
    fourier_filter = fftshift(fourier_filter);
    
    fourier_img = fourier_img.*fourier_filter;
    
    fourier_img = fftshift(fourier_img);
    inverse_img = ifft2(fourier_img);
    new_img = abs(inverse_img);
    
    new_img = new_img(1:M,1:N);
    new_img = uint8(new_img);
    
    
end

function output=filtering(image,filter)
    [R,C] = size(image);
    [x,y] = size(filter);
    
    image = padarray(image,[floor(x/2),floor(y/2)]);
    image = double(image);
    output = zeros(R,C,'double');
    for i=1:R
        for j=1:C
            part = image(i:i+x-1,j:j+y-1);
            mult = part.*filter;
            out = sum(mult,'all');
            output(i,j) = out;
        end
    end
    output = uint8(output);
end
