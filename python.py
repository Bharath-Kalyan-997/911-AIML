import pymysql
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression
import matplotlib.pyplot as plt

# Database connection
def connect_db():
    return pymysql.connect(
        host='localhost',
        user='root',
        password='your_password',
        database='EmergencyCallAnalysis'
    )

# Fetch data from database
def fetch_data(query):
    connection = connect_db()
    try:
        return pd.read_sql(query, connection)
    finally:
        connection.close()

# Data fetching
query = """
    SELECT Calls.CallType, CallAssignments.ResponseTime
    FROM CallAssignments
    JOIN Calls ON CallAssignments.CallID = Calls.CallID;
"""
data = fetch_data(query)

# Data preparation
data['CallType'] = data['CallType'].astype('category').cat.codes  # Encode categorical data
X = data[['CallType']]
y = data['ResponseTime']

# Split the data
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Train a model
model = LinearRegression()
model.fit(X_train, y_train)

# Predict and evaluate
predictions = model.predict(X_test)
print("Model Coefficients:", model.coef_)
print("Model Intercept:", model.intercept_)

# Visualization
plt.scatter(X_test, y_test, color='blue', label='Actual')
plt.scatter(X_test, predictions, color='red', label='Predicted')
plt.title('Response Time Prediction')
plt.xlabel('Call Type (Encoded)')
plt.ylabel('Response Time')
plt.legend()
plt.show()
