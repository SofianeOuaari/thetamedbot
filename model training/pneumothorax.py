# mounting the drive cloud for loading the dataset and saving the resaults
from google.colab import drive
drive.mount('/content/drive')

# importing the needed libraries
import glob
import cv2
import numpy as np
from keras.utils import np_utils
from keras.models import Sequential
from keras.layers import Dense
from keras.optimizers import SGD
from keras.losses import categorical_crossentropy
success=True;

# loading the dataset from the drive
length=100;
data = []
print("loading training data for non-infected cases :\n")

path = "./dataset/chestXRay/cleaned ches-X Ray/train/0"
images_paths = glob.glob(path +"*.png") + glob.glob(path +"*.jpg")
for img in images_paths:
        image = cv2.imread(img)
        image = cv2.resize(image,(length,length));
        image = image / np.max(image)
        image = image.astype(np.float32)
        imageEntity = {"image" : image,"status" : 0}
        data.append(imageEntity)
print("loading training data for infected cases :\n")
path = "./dataset/chestXRay/cleaned ches-X Ray/train/1"
images_paths = glob.glob(path +"*.png") + glob.glob(path +"*.jpg")
for img in images_paths:
        image = cv2.imread(img)
        image = cv2.resize(image,(length,length));
        image = image / np.max(image)
        image = image.astype(np.float32)
        imageEntity = {"image" : image,"status" : 1}
        data.append(imageEntity)


x_train_image =[]
y_train = []

for i in data:
    x_train_image.append(i['image'])
    y_train.append(i['status'])


#y_train= np_utils.to_categorical(y_train)   
x_train_image =np.array(x_train_image)
if success:
  print("data loaded successfully!")
print(x_train_image.shape)



#   loading test data
test_data=[]
print("loading test data for non-infected cases :\n")
path = "/content/drive/My Drive/colab/dataset/chestXRay/cleaned ches-X Ray/test/0"
images_paths = glob.glob(path +"*.png") + glob.glob(path +"*.jpg")
for img in images_paths:
        image = cv2.imread(img)
        image = cv2.resize(image,(length,length));
        image = image / np.max(image)
        image = image.astype(np.float32)
        imageEntity = {"image" : image,"status" : 0}
        test_data.append(imageEntity)
print("loading test data for infected cases :\n")
path = "/content/drive/My Drive/colab/dataset/chestXRay/cleaned ches-X Ray/test/1"
images_paths = glob.glob(path +"*.png") + glob.glob(path +"*.jpg")
for img in images_paths:
        image = cv2.imread(img)
        image = cv2.resize(image,(length,length));
        image = image / np.max(image)
        image = image.astype(np.float32)
        imageEntity = {"image" : image,"status" : 1}
        test_data.append(imageEntity)


x_test_image =[]
y_test = []

for i in test_data:
    x_test_image.append(i['image'])
    y_test.append(i['status'])


#y_test = np_utils.to_categorical(y_test)   
x_test_image =np.array(x_test_image)
if success:
  print("test data loaded successfully!")
print(x_test_image.shape)
