img = imread('Homeworks\Images\7\Building.jpg');
img = double(rgb2gray(img));

dx = [-1 0 1;-1 0 1;-1 0 1]/6;
dy = [-1 -1 -1;0 0 0 ; 1 1 1]/6;
sigma = 0.5;
g = fspecial('gaussian',max(1,fix(6*sigma)), sigma);

Ix = filtering(img,dx);
Iy = filtering(img,dy);
Ix2 = conv2(Ix.^2, g);  
Iy2 = conv2(Iy.^2, g);
Ixy = conv2(Ix.*Iy, g);

k = 0.04;
R11 = (Ix2.*Iy2 - Ixy.^2) - k*(Ix2 + Iy2).^2;
thresh = 10;
cond = R11>thresh;
R = R11.*cond;
R = norm(R);
imshow(R);
[r,c] = nms(R,20,thresh);
figure, imagesc(img), axis image, colormap(gray), hold on
    plot(c,r,'ys'), title('corners detected');

function [r,c] = nms(cim,radius,thresh)
    sze = 2*radius+1;                   % Size of mask.
	mx = ordfilt2(cim,sze^2,ones(sze)); % Grey-scale dilate.
	cim = (cim==mx)&(cim>thresh);       % Find maxima.
	
	[r,c] = find(cim);                  % Find row,col coords.
	
end
function output = norm(img)
    output = mat2gray(img);
    Max = max(max(output));
    Min = min(min(output));
    output = (255/(Max-Min))*output;
    
end

function output=filtering(img,mask)
    [R,C] = size(img);
    [x,y] = size(mask);
    img = padarray(img,[1,1]);
    output = zeros(R,C,'double');
    for i=1:R
        for j=1:C
            part = img(i:i+x-1,j:j+y-1);
            mult = part.*mask;
            out = sum(mult,'all');
            output(i,j) = out;
        end
    end
end