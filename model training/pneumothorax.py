# mounting the drive cloud for loading the dataset and saving the resaults
from google.colab import drive
drive.mount('/content/drive')
!pip install -q keras
!pip install opencv-python

# importing the needed libraries
import glob
import cv2
import os
import numpy as np
from keras.utils import np_utils
from keras.models import Sequential
from keras.layers import Dense
from keras.optimizers import SGD
from keras.losses import categorical_crossentropy
success=True;

# loading the dataset from the drive
train_path="/content/drive/My Drive/colab/dataset/chestXRay/cleaned ches-X Ray/train"
test_path="/content/drive/My Drive/colab/dataset/chestXRay/cleaned ches-X Ray/test"
categories=["0","1"]
train_image=[]
train_label=[]
size=300
for category in categories:
  path=os.path.join(train_path,category) #path to the train folder
  for img in os.listdir(path):
    image_array=cv2.imread(os.path.join(path,img),cv2.IMREAD_GRAYSCALE)
    img = cv2.resize(image_array,(size,size))
    train_image.append(img)
    train_label.append(category)
	
	
test_image=[]
test_label=[]
for category in categories:
  path=os.path.join(test_path,category) #path to the train folder
  for img in os.listdir(path):
    image_array=cv2.imread(os.path.join(path,img),cv2.IMREAD_GRAYSCALE)
    img = cv2.resize(image_array,(size,size))
    test_image.append(img)
    test_label.append(category)