#!/usr/bin/env python
# coding: utf-8

from pyexpat import model
from statistics import mode
from unittest import result
from xml.dom import ValidationErr
import h2o
h2o.init(nthreads=12)

import pandas as pd

## Display all dataframe columns in a Jupyter Python Notebook
# for column
#pd.set_option('display.max_columns', <number of columns>)

# for row
pd.set_option('display.max_rows', 100)
from h2o.estimators.deeplearning import H2OAutoEncoderEstimator, H2ODeepLearningEstimator
from h2o.grid.grid_search import H2OGridSearch


## read train file
train_data = h2o.import_file("../Output_extra/Train_combine_May22_Extra.csv", header=0)
#print(train_data.head())

## read test file
test_data = h2o.import_file("../Output_extra/Test_combine_May22_Extra.csv", header=0)
#print(test_data.head())

test_data_value = test_data[:,1:8155]
#test_data_value.head()

## get actual value from testing data
test_actual = test_data.as_data_frame(use_pandas=True)['C1']
test_actual.to_csv(r'../Output_extra_grid/Response_testing_actual.csv')

# For binary classification, response should be a factor
train_data['C1'] = train_data['C1'].asfactor()
test_data['C1'] = train_data['C1'].asfactor()

# # Construct validation and training datasets by sampling (30/70)
seed = 1234
iloc = train_data[0].runif()
train = train_data[iloc < 0.7]
valid = train_data[iloc >= 0.7]

## get the shape of each of the datasets
print ('train shape', train.shape)
print ('validation shape', valid.shape)

# get column name
response = train_data.col_names[0]
predictors = train_data.col_names[1:]
response = test_data.col_names[0]
predictors = test_data.col_names[1:]

## get actual value from training data
train_actual = valid.as_data_frame(use_pandas=True)['C1']
train_actual.to_csv(r'../Output_extra_grid/Response_training_actual.csv')


#####################################
# GRID SEARCH

hidden_opt = [[100, 100, 100], [200, 200, 200], [500, 500, 500]] #Specify the hidden layer sizes

hyper_params_dl = {
                'activation': ["Rectifier", "Maxout", "Tanh", "RectifierWithDropout", "MaxoutWithDropout", "TanhWithDropout"], #Specify the activation function
                'hidden': hidden_opt,
                'epochs': [50, 100, 200, 300, 500], #Specify the number of times to iterate (stream) the dataset
                'rho': [0.9, 0.95, 0.99, 0.999], #Applicable only if adaptive_rate is enabled. Specify the adaptive learning rate time decay factor.
                'epsilon': [1e-10, 1e-8, 1e-6, 1e-4], #Applicable only if adaptive_rate is enabled. Specify the adaptive learning rate time smoothing factor to avoid dividing by zero.
                'input_dropout_ratio': [0, 0.1, 0.2], #Specify the input layer dropout ratio to improve generalization. Suggested values are 0.1 or 0.2. This option defaults to 0.
                'l1': [0, 0.00001, 0.0001], #Specify the L1 regularization to add stability and improve generalization; sets the value of many weights to 0 (default).
                'l2': [0, 0.00001, 0.0001], #Specify the L2 regularization to add stability and improve generalization; sets the value of many weights to smaller values. Defaults to 0.
                'max_w2': [10, 100, 1000, 3.4028235e+38] #Specify the constraint for the squared sum of the incoming weights per unit (e.g., for Rectifier). Defaults to 3.4028235e+38.
#                'rate': [0, 0.1, 0.005, 0.001],
#                'rate_annealing': [1e-8, 1e-7, 1e-6],
#                'momentum_start': [0, 0.5],
#                'momentum_stable': [0.99, 0.5, 0],
                }


#####################################
# Early stopping criteria

search_criteria_dl =   {
                    'strategy': 'RandomDiscrete', #strategy to perform a random search of all the combinations of your hyperparameters
                    'max_models': 100000, #stop if reached max number of models; 100
                    'max_runtime_secs': 43200, #stop if reached max time; 2400
                    'stopping_tolerance': 0.001, #stop if MSE hasn’t improved by 0.001; 0.001
                    'stopping_rounds': 20, #over the 5 best models; 15
                    'seed': 1234 #42
                    }


#####################################
#DEEP LEARNING

#dl_grid = H2OGridSearch(H2ODeepLearningEstimator, 
#                    x = predictors,
#                    y = response,
#                    weights_column = weights,
#                    grid_id = "dl_grid",
#                    training_frame = train,
#                    validation_frame = valid,
#                    nfolds = 25,                           
#                    fold_assignment = "Stratified",
#                    hyper_params = hyper_params,
#                    search_criteria = search_criteria,
#                    seed = 42
#                    )

# Build and train the model
dl_grid = H2OGridSearch(
                        model=H2ODeepLearningEstimator, 
                        grid_id='dl_grid',
                        hyper_params = hyper_params_dl,
                        search_criteria = search_criteria_dl,
#                        keep_cross_validation_predictions = True,
#                        train_samples_per_iteration = -1,
                        )

dl_grid.train(x=predictors, y=response, distribution='multinomial', training_frame=train, validation_frame=valid)


#Trying to predict with an unstable model.
#Job was aborted due to observed numerical instability (exponential growth).
#Either the weights or the bias values are unreasonably large or lead to large activation values.
#Try a different initial distribution, a bounded activation function (Tanh), adding regularization
#(via max_w2, l1, l2, dropout) or learning rate (either enable adaptive_rate or use a smaller learning rate or faster annealing).


# Get the grid results, sorted by validation AUC
# performance metrics where bigger is better -> order with decreasing = TRUE
# decreasing=True --> "auc", "precision", "accuracy", "recall", "specificity"
# performance metrics where smaller is better -> order with decreasing = FALSE
# decreasing=False --> "mean_per_class_error", "mse", "err"

# sort_by specified. Must be one of: [r2, mean_per_class_accuracy, pr_auc, max_per_class_error, err, total_rows, 
# accuracy, logloss, auc, rmse, err_count, aucpr, mse, mean_per_class_error]

print(dl_grid.get_grid(sort_by='accuracy', decreasing=True))
dl_gridperf = dl_grid.get_grid(sort_by='accuracy', decreasing=True)
dl_gridperf
dl_gridperf.to_csv(r'../Output_extra_grid/dl_models.csv')

# Grab the top DL model, chosen by validation MSE
best_dl = dl_gridperf.models[0]
print('Training RMSE', best_dl.rmse())

# Save validation result
pred_dl_valid = best_dl.predict(valid).as_data_frame(use_pandas=True)
pred_dl_valid.to_csv(r'../Output_extra_grid/Pred_validation.csv')

# conmatrix validation
ConMat_best_dl_valid = best_dl.confusion_matrix(train)
ConMat_best_dl_valid_df = ConMat_best_dl_valid.as_data_frame()
ConMat_best_dl_valid_df.to_csv(r'../Output_extra_grid/ConMat_best_dl_valid.csv')


# Now let's evaluate the model performance on a test set
# so we get an honest estimate of top model performance
#best_dl_perf = best_dl.model_performance(test_data)
#print('Testing MSE', best_dl_perf.mse())
pred_dl_test = best_dl.predict(test_data_value).as_data_frame(use_pandas=True)
pred_dl_test.to_csv(r'../Output_extra_grid/Pred_testing.csv')
print('Testing Accuracy', (test_actual == pred_dl_test['predict']).mean())

# conmatrix testing
from sklearn.metrics import confusion_matrix

# Extract response value from prediction result
pred_test = pred_dl_test['predict']

ConMat_best_dl_test = confusion_matrix(test_actual, pred_test)
ConMat_best_dl_test_pd = pd.DataFrame(ConMat_best_dl_test)
ConMat_best_dl_test_pd.to_csv(r'../Output_extra_grid/ConMat_best_dl_test.csv')

# Save the best model
model_path = h2o.save_model(model = best_dl, path = "../Output_extra_grid", force = True)
print (model_path)