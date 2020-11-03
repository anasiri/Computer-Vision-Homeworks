image = imread('Homeworks/Images/3/Lena.bmp');
image = rgb2gray(image);


box_filter = [1 1 1; 1 1 1; 1 1 1];
box_filter = uint8(box_filter);
imwrite(image,'im0.png');
output = filtering(image,box_filter);
for i=1:100
    imwrite(output,"im"+i+".png");
    output = filtering(output,box_filter);
end
imwrite(output,"im101.png");

function output=filtering(image,filter)
    [R,C] = size(image);
    image = padarray(image,[1,1]);
    output = zeros(R,C,'uint8');
    for i=1:R
        for j=1:C
            part = image(i:i+2,j:j+2);
            mult = part.*filter;
            out = sum(mult,'all')/9;
            output(i,j) = out;
        end
    end
end