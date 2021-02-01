# Classwork

import pandas as pd

df = pd.read_csv(r"C:\Users\adamk\Desktop\VCU School Work - Graduate\VCU DAPT Course info\Module2\DAPT 631 Data Mining\DAPT 622 Python\Data\winequality.csv")
df.shape

# view data
df.head()
df.info()

df.dtypes
df.columns

df.loc[0, 'Unnamed']

drop_col = df.columns[0]

drop_col

df = df.drop('Unnamed: 0', axis=1)

df.head

df.columns

df.columns.str


df.columns.str.replace('.','')

#rename columns
df.columns = df.columns.str.replace('.','')

corr_matrix = df.corr()

import matplotlib.pyplot as plt
import seaborn as sns

sns.heatmap(corr_matrix);

plt.figure(figsize=(10,9))
sns.heatmap(corr_matrix);

my_cmap = sns.diverging_palette(4000, 200, n=60)

plt.figure(figsize=(10,9))

sns.heatmap(corr_matrix, cmap=my_cmap)

df.describe()

df.describe().T

df.head

#naming mean_values to renamed-columns
fixedacidity = 7.215307
volatileacidity = 0.339666
citricacid = 0.318633
residualsugar = 5.443235
chlorides = 0.056034
freesulfurdioxide = 30.525319
totalsulfurdioxide = 56.521855
density = 0.994697
pH = 3.218501
sulphates = 0.531268
alcohol = 10.491801
quality = 5.818378

#question1

df.fixedacidity.hist();
fixedacidity = 7.215307
plt.axvline(fixedacidity, color='red');

df.volatileacidity.hist();
volatileacidity = 0.339666
plt.axvline(volatileacidity, color='red');

df.citricacid.hist();
citricacid = 0.318633
plt.axvline(citricacid, color='red');

df.residualsugar.hist();
residualsugar = 5.443235
plt.axvline(residualsugar, color='red');

df.chlorides.hist();
chlorides = 0.056034
plt.axvline(chlorides, color='red');

df.freesulfurdioxide.hist();
freesulfurdioxide = 30.525319
plt.axvline(freesulfurdioxide, color='red');

df.totalsulfurdioxide.hist();
totalsulfurdioxide = 56.521855
plt.axvline(totalsulfurdioxide, color='red');

df.density.hist();
density = 0.994697
plt.axvline(density, color='red');

df.pH.hist();
pH = 3.218501
plt.axvline(pH, color='red');

df.sulphates.hist();
sulphates = 0.531268
plt.axvline(sulphates, color='red');

df.alcohol.hist();
alcohol = 10.491801
plt.axvline(alcohol, color='red');

df.quality.hist();
quality = 5.818378
plt.axvline(quality, color='red');

------------------------------------

#all histograms:
df.hist();

------------------------------------
