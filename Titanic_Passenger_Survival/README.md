Titanic Passenger Survival Analysis

Overview :-

This project analyzes passenger data from the Titanic disaster to predict survival outcomes using machine learning. The analysis includes data exploration, feature engineering, and model evaluation to understand which factors most influenced a passenger's chance of survival.

Key Findings :-

Demographics Matter: Women and children had significantly higher survival rates
Class Divide: 1st class passengers were more likely to survive than 3rd class
Family Size: Passengers with small families (2-4 members) had better survival odds than those traveling alone or in large groups
Model Performance: The Random Forest classifier achieved 82% accuracy in predicting survival

Data Description :-

The dataset contains information for 891 passengers with the following features:

Survived: Target variable (0 = No, 1 = Yes)
Pclass: Ticket class (1 = 1st, 2 = 2nd, 3 = 3rd)
Sex: Gender (male/female)
Age: Age in years
SibSp: Number of siblings/spouses aboard
Parch: Number of parents/children aboard
Ticket: Ticket number
Fare: Passenger fare
Cabin: Cabin number
Embarked: Port of embarkation (C = Cherbourg, Q = Queenstown, S = Southampton)

Methodology :-

Data Cleaning:

Handled missing values in Age, Cabin, and Embarked
Created new features (Title, Age Group, Family Size)
Encoded categorical variables

Feature Engineering :-

Extracted titles from names (Mr, Mrs, Miss, etc.)
Created age groups (Child, Young Adult, Adult, etc.)
Calculated family size and fare per person
Added "IsAlone" feature

Model Selection :-

Compared multiple classifiers (Random Forest, KNN, Decision Tree, etc.)
Selected Random Forest as the best performing model
Evaluated using accuracy, precision, recall, and confusion matrix

Results :-

The final Random Forest model achieved:

Overall Accuracy: 82%
Precision/Recall for Non-Survivors: 85%
Precision/Recall for Survivors: 76%

How to Use :-
Clone the repository

Install required packages (pandas, numpy, matplotlib, seaborn, scikit-learn)

Run the Jupyter notebook Titanic_Survival_Analysis.ipynb

Dependencies :-

Python 3.x
pandas
numpy
matplotlib
seaborn
scikit-learn
Jupyter Notebook

Future Improvements :-

Experiment with more advanced models (XGBoost, Neural Networks)
Perform hyperparameter tuning
Explore additional feature engineering possibilities
Apply ensemble methods

Acknowledgements :-
Dataset source: Kaggle Titanic Competition
