img = imread('Homeworks\Images\7\Attack 1\1.bmp');
img = rgb2gray(img);
ref = imread('Homeworks\Images\7\Reference.bmp');
ref = rgb2gray(ref);
new_img = imread('Homeworks\Images\7\Attack 2\1.bmp');
new_img = rgb2gray(new_img);
original = imread('Homeworks\Images\7\Original.bmp');
original = rgb2gray(original);


mt = 6500;
feature_img = detectSURFFeatures(img,'MetricThreshold',mt);
feature_ref = detectSURFFeatures(ref,'MetricThreshold',mt);


[f1,vpts1] = extractFeatures(img,feature_img);
[f2,vpts2] = extractFeatures(ref,feature_ref);

indexPairs = matchFeatures(f1,f2);
matchedPoints1 = vpts1(indexPairs(:,1));
matchedPoints2 = vpts2(indexPairs(:,2));


x1 = matchedPoints1.Location(:,1);
y1 = matchedPoints1.Location(:,2);
x2 = matchedPoints2.Location(:,1);
y2 = matchedPoints2.Location(:,2);
z1 = [x1 y1];
z2 = [x2 y2];

T = fitgeotrans(z1,z2,'nonreflectivesimilarity');

output = imwarp(new_img,T,'cubic','OutputView', imref2d(size(new_img)));
output = output(1:512,1:512);

imshow(output);

m = immse(original,output);
ss = ssim(original,output);

imwrite(output ,'x.png');

figure, imagesc(img), axis image, colormap(gray), hold on
    plot(x1,y1,'ys'), title('img');
    
figure, imagesc(ref), axis image, colormap(gray), hold on
    plot(x2,y2,'ys'), title('ref');

