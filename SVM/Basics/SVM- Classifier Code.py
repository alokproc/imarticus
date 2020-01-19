#!/usr/bin/env python
# coding: utf-8

# # Importing Libraries

# In[1]:


#Importing EDA libraries
import numpy as np
import pandas as pd


# In[2]:


#the data set doesn't have any heading or column names hence, we are importing the dataset by taking 'header=None'
dataset = pd.read_csv('vehicle.csv', header=None)


# # Exploratory Data Analysis

# In[3]:


dataset.head()


# In[4]:


dataset.shape


# In[5]:


dataset.isnull().sum()


# In[6]:


#Adding column names to the data set
col = ['buying', 'maint', 'doors', 'persons', 'leg_boot', 'safty', 'outcome']


# In[7]:


dataset.columns = col


# In[8]:


dataset.head()


# In[9]:


#importing data visualization library
import seaborn as sb


# In[10]:


sb.countplot(x = 'outcome', data = dataset)


# In[11]:


sb.countplot(x = 'outcome', hue = 'safty', data = dataset)


# # Data Cleaning and Preprocessing

# In[12]:


# Most of the data we have is in categorical format, so we need to encode the data usiing data preprocessing technique, Lable-Encoding

from sklearn.preprocessing import LabelEncoder

enc = LabelEncoder()


# In[13]:


# Lable Encoding all the required columns

dataset.buying = enc.fit_transform(dataset.buying)
dataset.maint = enc.fit_transform(dataset.maint)
dataset.doors = enc.fit_transform(dataset.doors)
dataset.persons = enc.fit_transform(dataset.persons)
dataset.leg_boot = enc.fit_transform(dataset.leg_boot)
dataset.safty = enc.fit_transform(dataset.safty)


# In[14]:


#Data after lable Encoding
dataset.head()


# # Feature Extraction

# In[15]:


# feature selection of X and y values

X = dataset.iloc[:, :6]

y = dataset.outcome


# In[17]:


#Splitting the data  for  training and testing

from sklearn.model_selection import train_test_split

X_train, X_test, y_train, y_test = train_test_split(X, y, random_state=10)


# # Machine Learning Model

# In[18]:


# Importing the Support Vector Classifier

from sklearn.svm import SVC

# we can take different parameters for this SVC classifier for better accuracy score

model_svm = SVC(kernel='rbf', C=100, gamma=0.07)
model_svm.fit(X_train, y_train)


# In[19]:


y_predict_svm = model_svm.predict(X_test)


# # Model Evaluation

# In[20]:


#Importing the model evaluation metrics
from sklearn.metrics import accuracy_score, confusion_matrix


# In[21]:


accuracy_score(y_predict_svm, y_test)


# In[22]:


confusion_matrix(y_predict_svm, y_test)


# In[ ]:





# # Grid Search for best parameters

# In[23]:


#Finding best Parameters for SVC using Grid Search.


# In[24]:


# Grid Search - To find the value for Kernel, C and Gamma to get a good accuray score.
from sklearn.model_selection import train_test_split, GridSearchCV

parameters = [{'kernel':['linear'], 'C':[1, 10, 100, 1000, 10000]}, 
              {'kernel':['rbf'], 'gamma': [.05, 0.1, 0.06, .07, .08], 'C':[1, 10, 100, 1000, 10000]}]


# In[25]:


grid_model_svc = GridSearchCV(SVC(), parameters)
grid_model_svc.fit(X_train, y_train)


# In[26]:


print(grid_model_svc.best_score_)
print(grid_model_svc.best_params_)


# In[27]:


#Use the above parameters in the SVC for better accuracy


# In[ ]:




