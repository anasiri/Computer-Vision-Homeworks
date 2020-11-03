import  cv2
import os
import numpy as np
from pathlib import Path

p = Path(__file__).parents[2]

img = cv2.imread(str(p)+'/Homeworks/Images/7/Attack 1/1.bmp')
img = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

ref = cv2.imread(str(p)+'/Homeworks/Images/7/Reference.bmp')
ref = cv2.cvtColor(ref, cv2.COLOR_BGR2GRAY)

surf = cv2.xfeatures2d.SURF_create(10000)
img_kp,img_des = surf.detectAndCompute(img,None)
ref_kp,ref_des = surf.detectAndCompute(ref,None)

# FLANN parameters
FLANN_INDEX_KDTREE = 0
index_params = dict(algorithm = FLANN_INDEX_KDTREE, trees = 5)
search_params = dict(checks=50)   # or pass empty dictionary

flann = cv2.FlannBasedMatcher(index_params,search_params)

matches = flann.knnMatch(img_des,ref_des,k=2)

# Need to draw only good matches, so create a mask
matchesMask = [[0,0] for i in range(len(matches))]
new_match =[]
new_mask =[]
# ratio test as per Lowe's paper
for i,(m,n) in enumerate(matches):
    if m.distance < 0.7*n.distance:
        matchesMask[i]=[1,0]
        new_match.append([m, n])
        new_mask.append([1, 0])

draw_params = dict(matchColor = (0,255,0),
                   singlePointColor = (255,0,0),
                   matchesMask = new_mask,
                   flags = 0)

X = []
Y = []
for m in new_match:
    x = m[0]
    img_idx = x.queryIdx
    ref_idx = x.trainIdx
    x1,x2 = img_kp[img_idx].pt
    X.append([x1,x2,1]);
    y1,y2 = ref_kp[ref_idx].pt
    Y.append([y1,y2,1]);

X = np.transpose(np.array(X))
Y = np.transpose(np.array(Y))

T = np.matmul(Y,np.linalg.pinv(X))
T=cv2.getAffineTransform(X[0:3],Y[0:3])
print(T)

out = cv2.warpAffine(img, T ,img.shape)
'''''
img3 = cv2.drawMatchesKnn(img, img_kp, ref, ref_kp, new_match, None, **draw_params)
img2 = cv2.drawKeypoints(img,img_kp,None,(255,0,0),4)
cv2.imshow('image',img2)
cv2.imshow('match',img3)
'''
cv2.imshow('img',img)
cv2.imshow('out',out)
cv2.waitKey(0)
