img = imread('Homeworks\Images\4\Lena.bmp');

img = rgb2gray(img);
img = double(img);

T = 1/4;


x = freq_filtering(img,0,T);
imwrite(uint8(x),'f1.png');

x = freq_filtering(img,1,T);
imwrite(uint8(x),'f2.png');

x = freq_filtering(img,2,T);
imwrite(uint8(x),'f3.png');

x = freq_filtering(img,3,T);
imwrite(uint8(x),'f4.png');

x = freq_filtering(img,4,T);
imwrite(uint8(x),'f5.png');

function new_img = freq_filtering (image,x,T)
    [M,N] = size(image);
    
    fourier_img = fft2(image,M,N);
    %show_im(fourier_img);
    %figure
    for k = 1:M
        for l=1:N
            
            switch x
                case 0
                    if((T*N<k && k<(1-T)*N) &&(T*N<l &&l<(1-T)*N))
                         fourier_img(k,l) = 0;
                    end
                case 1
                    if((0<k && k<T*N) && (0<l && l<T*N))
                        if(k~=0 || l~=0)
                            fourier_img(k,l) = 0;
                        end
                    end
                case 2
                    if((0<=k && k<=T*N)&&((1-T)*N<= l))
                        fourier_img(k,l) = 0;
                    end
                 case 3
                    if((0<=l && l<=T*N)&&((1-T)*N<= k))
                        fourier_img(k,l) = 0;
                    end
                 case 4
                    if((1-T)*N<=k && (1-T)*N<=l)
                        fourier_img(k,l) = 0;
                    end
            end
        end
    end
    
    x = dft_im(ifftshift(fourier_img));
    inverse_img = ifft2(fourier_img);
    y = abs(inverse_img);
    new_img = zeros(M,N);
    new_img(1:M,1:N) =x;
    %new_img(1:M,N+1:2*N)=y;
    
end

function img = dft_im(fourier_img)
    img = abs(fourier_img);
    img = log10(img+1);
    Max = max(max(img));
    img = img *(255/Max);
    img = uint8(img);
    
end