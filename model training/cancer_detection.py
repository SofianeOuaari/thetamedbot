'''
to download model .tflite

import requests

url = 'https://drive.google.com/file/d/1YDebPiCp1yIOAEfiGmGcQIU0FIK6_jJQ/view?usp=sharing'
r = requests.get(url, allow_redirects=True)

open('skin_cancer_vgg16.tflite.zip', 'wb').write(r.content)
'''



import os
import gc
from PIL import Image

import tqdm
import numpy as np
from keras.models import Sequential
from sklearn.model_selection import train_test_split
from keras.preprocessing.image import ImageDataGenerator
from keras.layers import Dense, Conv2D, MaxPooling2D, Flatten, Dropout, LeakyReLU
from keras.applications import VGG16
import tensorflow as tf
from sklearn.utils import check_random_state
from tensorflow.python.keras.models import load_model

np.random.seed(0);
tf.random.set_seed(0);
check_random_state(0);

train_images, test_images = [], []
train_labels, test_labels = [], []

for img_path in os.listdir('./dataset/data/train/benign'):
    train_images.append('./dataset/data/train/benign/' + img_path)
    train_labels.append(0)

for img_path in os.listdir('./dataset/data/train/malignant'):
    train_images.append('./dataset/data/train/malignant/' + img_path)
    train_labels.append(1)

for img_path in os.listdir('./dataset/data/test/benign'):
    test_images.append('./dataset/data/test/benign/' + img_path)
    test_labels.append(0)

for img_path in os.listdir('./dataset/data/test/malignant'):
    test_images.append('./dataset/data/test/malignant/' + img_path)
    test_labels.append(1)

train_images, test_images = np.array(train_images), np.array(test_images)
train_labels, test_labels = np.array(train_labels), np.array(test_labels)

distribution = np.bincount(np.concatenate([train_labels, test_labels]))
'''
print('TRAIN SET SIZE :', len(train_images))
print('TEST SET SIZE:', len(test_images))
print(distribution[0], 'BENIGN ', distribution[1], 'MALIGNANT')
'''

'''
# Load the images to memory
X_train, X_test = [], []
Y_train, Y_test = train_labels, test_labels

for file in tqdm.tqdm(train_images):
    X_train.append(np.array(Image.open(file)))

for file in tqdm.tqdm(test_images):
    X_test.append(np.array(Image.open(file)))

del train_images, test_images, train_labels, test_labels
X_train, X_test = np.array(X_train), np.array(X_test)

features = np.concatenate([X_train, X_test])
labels = np.concatenate([Y_train, Y_test])

# Spliting data to train, validation and test values
X_train, X_test, Y_train, Y_test = train_test_split(features, labels, test_size=.1, random_state=0)
X_train_new, X_val, Y_train_new, Y_val = train_test_split(X_train, Y_train, test_size=.05, random_state=0, shuffle=False)

gc.collect()
print('Shape of the new train set:', X_train_new.shape)
print('Shape of the new test set:', X_test.shape)
print('Shape of the validation set:', X_val.shape)

data_generator = ImageDataGenerator(rotation_range=90,
                                    width_shift_range=0.15,
                                    height_shift_range=0.15,
                                    horizontal_flip=True,
                                    vertical_flip=True,
                                    brightness_range=[0.8, 1.1],
                                    fill_mode='nearest')

new_samples, new_labels = next(data_generator.flow(X_train_new, Y_train_new, batch_size=len(X_train_new)))
X_train_new = np.concatenate([X_train_new, new_samples])
Y_train_new = np.concatenate([Y_train_new, new_labels])

del new_samples, new_labels
print('New number of training samples:', len(X_train_new))

# Normalizing values
X_train_new = X_train_new.astype('float32') / 255.
X_test = X_test.astype('float32') / 255.
X_val = X_val.astype('float32') / 255.

print('Training data shape:', X_train_new.shape)
print('Min value:', X_train_new.min())
print('Max value:', X_train_new.max())

import ssl

ssl._create_default_https_context = ssl._create_unverified_context

# model VGG16
model = Sequential()

model.add(VGG16(include_top=False, input_shape=(224, 224, 3,)))
model.add(Flatten())
model.add(Dense(32))
model.add(LeakyReLU(0.001))
model.add(Dense(16))
model.add(LeakyReLU(0.001))
model.add(Dense(1, activation='sigmoid'))
model.layers[0].trainable = False

model.compile(loss='binary_crossentropy', optimizer='adam', metrics=['acc'])
model.summary()

# Train the model
n_epochs = 20

#history = model.fit(X_train_new, Y_train_new, validation_data=(X_val, Y_val), epochs=n_epochs, batch_size=64)

#print('Accuracy on test set:', model.evaluate(X_test, Y_test)[1])
#model.save('skin_cancer_vgg16.h5')
'''
model = load_model('skin_cancer_vgg16.h5')
# summarize model.
model.summary()
#score = model.evaluate(X_test, Y_test, verbose=0)
#print("%s: %.2f%%" % (model.metrics_names[1], score[1]*100))

#convert to tflite

converter = tf.lite.TFLiteConverter.from_keras_model( model )
model = converter.convert()
file = open( 'skin_cancer_vgg16.tflite' , 'wb' )
file.write( model )