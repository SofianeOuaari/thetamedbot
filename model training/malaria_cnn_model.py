import os 
import cv2
import tensorflow as tf 
from tensorflow.keras.models import Sequential 
from tensorflow.compat.v1.keras.layers import Dense,Conv2D,MaxPool2D,Conv3D,MaxPool3D,Flatten,Activation
import random 
import numpy as np
import matplotlib.pyplot as plt
from sklearn.model_selection import train_test_split


img_dir="cell_images"  
img_size=140
def create_training(path):
    training=[]
    for category in os.listdir(path):
        path_img=os.path.join(path,category) 
        num_class=os.listdir(path).index(category) 
        for img in os.listdir(path_img):
            try:
                
                img_arr=cv2.imread(os.path.join(path_img,img)) 
                img_arr=cv2.cvtColor(img_arr,cv2.COLOR_BGR2RGB)
                img_new=cv2.resize(img_arr,(img_size,img_size))
                plt.imshow(img_new)
                #plt.show()
                training.append([img_new,num_class])
                print(num_class)
                print(len(training))
            except Exception as e:
                print(e)
                pass
    return training  
data_training=create_training(img_dir)
random.shuffle(data_training)    
x=[]
y=[]
for i,j in data_training[:10000]:
    print(i)
    print(j)
    x.append(i)
    y.append(j)  
x=np.array(x).reshape(-1,img_size,img_size,3)    
x=x/255 


x_train,x_test,y_train,y_test=train_test_split(x,y,test_size=0.1,stratify=y)


model=Sequential() 
'''model.add(Conv3D(64,(2,2,2),input_shape=x_train.shape[1:])) 
model.add(Activation("relu")) 
model.add(MaxPool3D(pool_size=(1,1,1))) 

model.add(Conv3D(64,(2,2,2))) 
model.add(Activation("relu")) 
model.add(MaxPool3D(pool_size=(1,1,1)))'''

model.add(Conv2D(64,(3,3),input_shape=x_train.shape[1:])) 
model.add(Activation("relu")) 
model.add(MaxPool2D(pool_size=(2,2)))

model.add(Conv2D(64,(3,3))) 
model.add(Activation("relu")) 
model.add(MaxPool2D(pool_size=(2,2)))

model.add(Conv2D(64,(3,3))) 
model.add(Activation("relu")) 
model.add(MaxPool2D(pool_size=(2,2)))

'''model.add(Conv3D(64,(3,3,3))) 
model.add(Activation("relu")) 
model.add(MaxPool3D(pool_size=(2,2,2)))'''

model.add(Flatten()) 

model.add(Dense(64))
model.add(Activation("relu")) 

model.add(Dense(64))
model.add(Activation("relu")) 

model.add(Dense(2)) 
model.add(Activation("softmax")) 

model.compile(loss="sparse_categorical_crossentropy",optimizer="adam",metrics=["accuracy"]) 
model.fit(x_train,np.array(y_train),batch_size=64,epochs=3,validation_split=0.2)

model.save("malaria-cell-cnn-3-2.model")

loss,accuracy=model.evaluate(x_test,np.array(y_test))
print(f"Testing on {len(x_test)} images, the results are\n Accuracy: {accuracy} | Loss: {loss}")


converter = tf.lite.TFLiteConverter.from_keras_model(model)
tflite_model = converter.convert()

# Save the model.
with open('model_malaria_2.tflite', 'wb') as f:
  f.write(tflite_model)