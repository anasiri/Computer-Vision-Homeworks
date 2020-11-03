img = imread('Homeworks/Images/6/Lena.bmp');
img = rgb2gray(img);
%noisy = imnoise(img,'gaussian',0.01);

level =3;
output = wt(noisy,level);
x = iwt(output,level);


x = uint8(x);

imshow(noisy);
figure
imshow(x);
p1 = psnr(noisy,img);
m = immse(img,x);
p2 = psnr(img,x);

imwrite(x,'x.png');
function output= soft_tresh(img,beta,sigma)
    [R,C] = size(img);
    output = zeros(R,C);
    
    local_sigma = std(double(img));
    T = (beta*sigma)/local_sigma;
    for i=1:R
        for j=1:C
            x = img(i,j);
            
            if(abs(x)<T)
                x =0;
            else
                x = sign(x)*abs(x-T);
            end
            
            output(i,j)=x;
            
        end
    end
    
end

function output = wt(img,level)

    if(level==0)
        output = img;
        return
    end
    [R,C] = size(img);
    output= zeros(R,C,'double');
    [cA,cH,cV,cD] = dwt2(img,'haar');
    
    
    beta = sqrt(log2(R/3));
    sigma = median(abs(cD)./0.6745).^2;
    
    cH = soft_tresh(cH,beta,sigma);
    cD = soft_tresh(cD,beta,sigma);
    cV = soft_tresh(cV,beta,sigma);
    
    output(1:R/2,1:C/2) = wt(cA,level-1);
    output(R/2+1:R,1:C/2)=cV;
    output(1:R/2,C/2+1:C)=cH;
    output(R/2+1:R,C/2+1:C)=cD;

end

function output = iwt(wt_pyramid,level)
    if(level==0)
        output = wt_pyramid;
        return
    end
    output = wt_pyramid;
    [R,C] = size(output);
    dec_part = output(1:R/(2^(level-1)),1:C/(2^(level-1)));
    
    
    [r,c] = size(dec_part);
    cA = dec_part(1:r/2,1:c/2);
    cV = dec_part(r/2+1:r,1:c/2);
    cH = dec_part(1:r/2,c/2+1:c);
    cD = dec_part(r/2+1:r,c/2+1:c);
    
    
    output(1:R/(2^(level-1)),1:C/(2^(level-1))) = idwt2(cA,cH,cV,cD,'haar');
    
    output = iwt(output,level-1);
    
end
function output = norm(img)
    output = mat2gray(img);
    Max = max(max(output));
    Min = min(min(output));
    output = (255/(Max-Min))*output;
    
end