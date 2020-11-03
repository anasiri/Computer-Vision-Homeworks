I = imread("HW/Homeworks/Images/1/Goldhill.bmp");
imshow(I);

shape = size (I);
avg = [0.25 0.25;0.25 0.25];

out = average(I);
out = bilin(out);
imshow(out);
imwrite(out, 'mask_image.jpg');
d4 = immse(out,I)
function out = bilin(I)
    shape = size(I);
    out = zeros(2*shape(1),2*shape(2),'uint8');
    for i=1:shape(1)
        for j=1:shape(2)
            s = i*2-1;
            t = j*2-1;
            out(s,t)=I(i,j); 
        end
    end
    
    for i=1:shape(1)*2
        for j=1:shape(2)*2
            if(mod(i,2)==0 ||mod(j,2)==0)
                out(i,j) = bilin_inter(i,j,out);
            end
                
        end
    end
    
end
function val = bilin_inter(x,y,image)
    
    shape = size(image);
    max_x = shape(1);
    max_y = shape(2);
    if(mod(x,2)==0 && mod(y,2)==0)
        x1 = x-1;
        y1 = y-1;
        
        x2 = x-1;
        y2 = y+1;
        
        x3 = x+1;
        y3 = y-1;
        
        x4 = x+1;
        y4 = y+1;
        
    elseif(mod(x,2)==0)
        x1 = x-1;
        y1 = y;
        
        x2 = x-1;
        y2 = y+2;
        
        x3 = x+1;
        y3 = y;
        
        x4 = x+1;
        y4 = y+2;
    elseif(mod(y,2)==0)
        x1 = x;
        y1 = y-1;
        
        x2 = x;
        y2 = y+1;
        
        x3 = x+2;
        y3 = y-1;
        
        x4 = x+2;
        y4 = y+1;
    end
    X = [x1 x2 x3 x4];
    Y = [y1 y2 y3 y4];
    
    for i=1:4
        if(X(i)>max_x)
            X(i) = max_x;
        end
        if(X(i)<=0)
            X(i)=1;
        end
    end
    
    for i=1:4
        if(Y(i)>max_y)
            Y(i) = max_y;
        end
        if(Y(i)<=0)
            Y(i)=1;
        end
    end
    x1 = X(1);
    x2 = X(2);
    x3 = X(3);
    x4 = X(4);
    
    y1 = Y(1);
    y2 = Y(2);
    y3 = Y(3);
    y4 = Y(4);
    
    v = image(x1,y1,:)/4 ;
    v = v + image(x2,y2,:)/4;
    v = v + image(x3,y3,:)/4;
    v = v + image(x4,y4,:)/4;
    
    val = v;
end
function out = pixel_rep(I)
    shape = size(I);
    out = zeros(2*shape(1),2*shape(2),'uint8');
    for i=1:shape(1)
        for j=1:shape(2)
            s = i*2-1;
            t = j*2-1;
            out(s,t)=I(i,j);
            out(s+1,t)=I(i,j);
            out(s,t+1)=I(i,j);
            out(s+1,t+1)=I(i,j);
            
        end
    end 
end
function out = row_col(I)
    shape = size(I);
    out = zeros(shape(1)/2,shape(2)/2,'uint8');
    
    for i=1:shape(1)/2
        for j =1:shape(2)/2
            out(i,j) = I(2*i-1,2*j-1);
        end
    end
end
function out=average(I)
shape = size(I);
out = zeros(shape(1)/2,shape(2)/2,'uint8');
for i=1:shape(1)/2-1
    for j=1:shape(2)/2-1
        t = i*2-1;
        s = j*2-1;
        X = I(t:t+2,s:s+2);
        sum = X(1,1)/9;
        sum =sum + X(1,2)/9;
        sum =sum + X(1,3)/9;
        sum =sum + X(2,1)/9;
        sum =sum + X(2,2)/9;
        sum =sum + X(2,3)/9;
        sum =sum + X(3,1)/9;
        sum =sum + X(3,2)/9;
        sum =sum + X(3,3)/9;
        out(i,j) = sum;
    end
end

end