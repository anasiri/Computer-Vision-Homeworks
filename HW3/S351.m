image = imread('Homeworks/Images/3/Lena.bmp');
image = rgb2gray(image);

filters = [3,5,7,9];

image_smooth = imgaussfilt(image,filters(3));
alpha = [0.5 0.8 1];
for i=1:4
    f = filters(i);
    for j =1:3
        x = alpha(j);
        new_image = image + x*(image_smooth - image);
        imwrite(new_image,"alpha"+x+"filter"+f+".png");
    end
end
