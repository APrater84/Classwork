#1 plot histograms for all variables in this dataset. 

import pandas as pd

df = pd.read_csv(r"C:\Users\adamk\Desktop\VCU School Work - Graduate\VCU DAPT Course info\Module2\DAPT 631 Data Mining\DAPT 622 Python\Data\winequality.csv", encoding='ISO-8859-2')

drop_col = df.columns[0]
drop_col
df = df.drop('Unnamed: 0', axis=1)

df.head

df.columns.str
df.columns = df.columns.str.replace(' ','')
df.head

df.rename(columns={"freesulfurdioxide": "FSDioxide", "totalsulfurdioxide": "TSDioxide"}, inplace = True)

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

df.FSDioxide.hist();
FSDioxide = 30.525319
plt.axvline(FSDioxide, color='red');

df.TSDioxide.hist();
TSDioxide = 115.744574
plt.axvline(TSDioxide, color='red');

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

-----------------------------------------------------------------------------------------

#2 Identify two features that are most correlated with each other

corr_matrix = df.corr()

import matplotlib.pyplot as plt
import seaborn as sns

df.corr()

---------

# define a color palette
my_cmap = sns.diverging_palette(220, 10, n=30)

# set figure size
plt.figure(figsize=(10,8))

# create a heat map
sns.heatmap(corr_matrix, cmap=my_cmap);

# if needed, adjust the truncated top and bottom rows
#ax.set_ylim(len(corr_matrix), 0)

-------
plt.figure(figsize=[10, 8])

ax = sns.scatterplot(x='density', y='residualsugar', data=df, color='purple')

plt.xlabel('density', fontsize=15, weight='bold')
plt.ylabel('residualsugar', fontsize=15, weight='bold');

---------------------------------------------------------------------------------------

#3 Identify the feature that is most correlated with the wine quality and plot their relationship using an appropriate chart type.

plt.figure(figsize=[12, 10])

ax = sns.scatterplot(x='alcohol', y='quality', data=df, color='red')

plt.xlabel('alcohol', fontsize=14, weight='bold')
plt.ylabel('quality', fontsize=14, weight='bold');

------------------------------------------------------------------------------------------

#4 Calculate average alcohol content for each wine quailty score

df.groupby(['quality'])[['alcohol']].mean()

avg_alcohol_for_best_wine = 12.18
print(f'The average alcohol content for the best wine is {avg_alcohol_for_best_wine}.')

-------------------------------------------------------------------------------------------

#5 Calculate correlation coefficients between wine quality and all other features separately for each wine type.  identify any one feature that has contradictory relationships across the wine type.

df.groupby(['winetype']).corr()

----

plt.figure(figsize=[12, 10])

ax = sns.scatterplot(x='sulphates', y='pH', data=df, hue='winetype')

plt.xlabel('sulphates', fontsize=14, weight='bold')
plt.ylabel('pH', fontsize=14, weight='bold');

------------------------------------------------------------------------------------------------------

#6 Create a DF that contains the overall average for each variable as well as its average value for red and white wines.  divide both averages by the overall average to create an index for each variable.  multiply the index columns by 100, which two variables have the highest index?

-----

df.groupby(['winetype']).mean()


