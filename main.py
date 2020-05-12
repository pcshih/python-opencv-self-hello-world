# SIFT vs SURF https://codertw.com/%E7%A8%8B%E5%BC%8F%E8%AA%9E%E8%A8%80/508823/
# code ref from https://www.pyimagesearch.com/2015/07/16/where-did-sift-and-surf-go-in-opencv-3/
import cv2
import numpy as np
print(cv2.__version__)
print(np.__version__)
print(cv2.__file__)

image = cv2.imread('test_image.jpg')
gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

sift = cv2.xfeatures2d.SIFT_create()
(kps, descs) = sift.detectAndCompute(gray, None)
print("# kps: {}, descriptors: {}".format(len(kps), descs.shape))

surf = cv2.xfeatures2d.SURF_create()
(kps, descs) = surf.detectAndCompute(gray, None)
print("# kps: {}, descriptors: {}".format(len(kps), descs.shape))