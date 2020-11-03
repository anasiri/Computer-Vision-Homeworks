img = imread('Homeworks\Images\5\Pepper.bmp');



L = 64;
R = uniform_quantizer(img(:,:,1),L);
G = uniform_quantizer(img(:,:,2),L);
B = uniform_quantizer(img(:,:,3),L);
x = img*0;
x(:,:,1) = R;
x(:,:,2) = G;
x(:,:,3) = B;
mse_error = immse(x,img);
psnr_error = psnr(x,img);

imshow(img);
figure
imshow(x);
imwrite(x,'x.png');


function output = uniform_quantizer(gray_img,L)
    
    %dynamic range
    fmax = max(max(gray_img));
    fmin = min(min(gray_img));
    B = fmax - fmin;
    
    %quantization interval
    q = B/L;
    
    [M,N] =size(gray_img);
    output=zeros(M,N,'uint8');
    for r=1:M
        for c=1:N
            f = gray_img(r,c);
            Qf = floor((f-fmin)/q)*q+q/2+fmin;
            output(r,c)=Qf;
        end
    end
    
end