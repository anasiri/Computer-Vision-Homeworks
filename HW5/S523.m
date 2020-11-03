img = imread('Homeworks\Images\5\Girl.bmp');


imshow(img);
figure
L = 8;
out = kmeans_quantizer(img,L);
imshow(out);
imwrite(out,'x.png');

mse_error = immse(out,img);
psnr_error = psnr(out,img);
function output = kmeans_quantizer(img,clusters)
    
    [M,N,dim] = size(img);
    
    samples =    zeros([M*N,dim],'double');
    count = 1;
    for c=1:N
        for r=1:M
            samples(count,:)=reshape(img(r,c,:),[1,3]);
            count = count + 1;
        end
    end
    
    [idx,centers] = kmeans(samples,clusters,'MaxIter',1000);
    centers = uint8(centers);
    result = centers(idx,:);
    result = reshape(result,[M,N,dim]);
    output = result;
end