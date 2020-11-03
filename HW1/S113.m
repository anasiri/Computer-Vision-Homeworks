
I = imread("HW/Homeworks/Images/1/Elaine.bmp");
th=45*pi/180;   
rotate45 = [cos(th) sin(th) 0; -sin(th) cos(th) 0;0 0 1];

A = size(I);
pad_im = zeros(A(1)*1.5,A(2)*1.5,'uint8');
for i=1:A(1)
    for j=1:A(2)
        pad_im(A(1)/4+i,A(2)/4+j)=I(i,j);
    end
end
A = size(pad_im);
image_near_inter = pad_im;
for i = 1:A(1)
   for j = 1:A(1)
       [v,w] = nearest_neighbor_inter(i,j,pad_im,rotate45);
       image_near_inter(i,j)= pad_im(v,w);
   end
end
imshow(image_near_inter)

function [x,y] = nearest_neighbor_inter(i,j,image,transform_matrix)

    shape = size(image);
    X = transform_matrix\[i-shape(1)/2;j-shape(2)/2;1];
    x = X(1)+shape(1)/2;
    y = X(2)+shape(2)/2;
    floor_x = floor(x);
    ceil_x = ceil(x);
    floor_y = floor(y);
    ceil_y = ceil(y);
    
    
    if(abs(floor_x-x) < abs(ceil_x-x))
        x = floor(x);
    else
        x = ceil(x);
    end
    if(abs(floor_y-y) < abs(ceil_y-y))
        y = floor(y);
    else
        y = ceil(y);
    end
    if(x>shape(1))
        x= shape(1);
    end
    if(x<=0)
        x=1;
    end
    if(y>shape(2))
        y= shape(2);
    end
    if(y<=0)
        y=1;
    end
end