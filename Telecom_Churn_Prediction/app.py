from flask import Flask, request, render_template
import joblib
import pandas as pd
import numpy as np

app = Flask(__name__)

# Load the trained model pipeline
try:
    pipeline = joblib.load('churn_pipeline.joblib')
    print("Model pipeline loaded successfully.")
except FileNotFoundError:
    print("Model pipeline file not found.")
    pipeline = None

# IMPORTANT: Define the column order your model EXPECTS BEFORE preprocessing
# Get this from your notebook right before the train-test split: X.columns.tolist()
# This list must contain the original, raw column names.
raw_columns = [
    'Age', 'Number_of_Referrals', 'Tenure_in_Months', 'Monthly_Charge',
    'Total_Charges', 'Total_Refunds', 'Total_Long_Distance_Charges', 'Gender',
    'Married', 'Phone_Service', 'Multiple_Lines', 'Internet_Service',
    'Online_Security', 'Online_Backup', 'Device_Protection_Plan', 'Premium_Support',
    'Streaming_TV', 'Streaming_Movies', 'Streaming_Music', 'Unlimited_Data',
    'Paperless_Billing', 'Contract_Fiber_Interaction', 'Service_Count', 'State_encoded',
    'Contract', 'Value_Deal', 'Payment_Method', 'Internet_Type'
]


@app.route('/')
def home():
    return render_template('index.html')


@app.route('/predict', methods=['POST'])
def predict():
    if pipeline is None:
        return render_template('result.html', prediction_text='Error: Model not loaded.')

    try:
        # Get the form data
        form_data = request.form.to_dict()

        # --- THIS IS THE KEY PART ---
        # Create a dictionary with the raw data from the form.
        # The keys MUST match the raw column names used for training.
        data_dict = {
            'Age': int(form_data.get('Age')),
            'Tenure_in_Months': int(form_data.get('Tenure_in_Months')),
            'Monthly_Charge': float(form_data.get('Monthly_Charge')),
            'Total_Charges': float(form_data.get('Total_Charges')),
            'Contract': form_data.get('Contract'),
            'Internet_Type': form_data.get('Internet_Type'),
            'Payment_Method': form_data.get('Payment_Method'),
            'Paperless_Billing': form_data.get('Paperless_Billing'),
        }

        # --- Create placeholder/default values for all other features ---
        # In a real app, you would have form fields for all of these.
        # For our example, we create defaults.
        # These features were engineered in the notebook, so we need to calculate them here too.

        # Calculate engineered features based on form input
        data_dict['Contract_Fiber_Interaction'] = 1 if (
                    data_dict['Contract'] == 'Month-to-Month' and data_dict['Internet_Type'] == 'Fiber Optic') else 0

        # Add other placeholders
        # A more robust app would calculate Service_Count based on more form inputs
        default_values = {
            'Number_of_Referrals': 0, 'Total_Refunds': 0, 'Total_Long_Distance_Charges': 0,
            'Gender': 'Male', 'Married': 'No', 'Phone_Service': 'Yes', 'Multiple_Lines': 'No',
            'Internet_Service': 'Yes', 'Online_Security': 'No', 'Online_Backup': 'No',
            'Device_Protection_Plan': 'No', 'Premium_Support': 'No', 'Streaming_TV': 'No',
            'Streaming_Movies': 'No', 'Streaming_Music': 'No', 'Unlimited_Data': 'Yes',
            'Service_Count': 1, 'State_encoded': 100, 'Value_Deal': 'No Deal'
        }

        # Merge the dictionaries - form data takes precedence
        for key, value in default_values.items():
            if key not in data_dict:
                data_dict[key] = value

        # Create the DataFrame using the dictionary
        data_df = pd.DataFrame([data_dict])

        # --- Crucially, reorder the DataFrame to match the training column order ---
        data_df = data_df[raw_columns]

        # Use the pipeline to make a prediction.
        # The pipeline will handle OneHotEncoding, Scaling, etc. automatically!
        prediction_proba = pipeline.predict_proba(data_df)[0][1]

        # Determine output based on our "High-Retention" threshold
        threshold = 0.35
        if prediction_proba >= threshold:
            prediction_text = f"High Risk of Churn (Probability: {prediction_proba:.2f})"
            recommendation = f"Recommendation: Engage with a retention offer. (Threshold set at {threshold})"
        else:
            prediction_text = f"Low Risk of Churn (Probability: {prediction_proba:.2f})"
            recommendation = "Recommendation: No immediate action needed."

    except Exception as e:
        prediction_text = f"An error occurred during prediction: {e}"
        recommendation = "Please ensure all input values are correct."

    return render_template('result.html', prediction_text=prediction_text, recommendation=recommendation)


if __name__ == '__main__':
    app.run(debug=True)