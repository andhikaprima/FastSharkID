# 3. deep learning model
import pandas as pd
import h2o
h2o.init(nthreads=2)

## read test file
df1 = h2o.import_file("../Output_extra/Test_combine_May22_Extra.csv", header=0)
#print(df1.head())

#Get actual response
test_actual = df1.as_data_frame(use_pandas=True)['C1']
test_actual
#test_actual.to_csv(r'../Output/IndependentTestActual.csv')

#Extract feature data
data_MIC_X_dl = df1[:,1:8155]
data_MIC_X_dl.head()


#recall model
dl_model = h2o.load_model("../Output_extra_grid/dl_grid_model_17_dl11")
dl_model
dl_model.to_txt(r'../Output_extra_grid/dl_grid_model_17_dl11.txt')
print(dl_model)


pred_dl = dl_model.predict(data_MIC_X_dl).as_data_frame(use_pandas=True)

pred_dl.to_csv(r'../Output/PredIndependentTest_dl2.csv')

y_pred = pred_dl['predict']

print('Accuracy', (test_actual == pred_dl['predict']).mean())

from sklearn.metrics import confusion_matrix


# In[ ]:


cm_dl2 = confusion_matrix(test_actual, y_pred)


# In[ ]:


cm_dl2_df_IndependentTest = pd.DataFrame(cm_dl2)
cm_dl2_df_IndependentTest.to_csv(r'../Output/ConMat_dl2_df_IndependentTest.csv')


# In[ ]:





# In[ ]:
