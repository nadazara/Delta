from google.cloud import bigquery
from google.oauth2 import service_account

credentials_path = '$$$$0000000000000?' 
project_id = '$$$$$$$?'

credentials = service_account.Credentials.from_service_account_file(credentials_path)

client = bigquery.Client(credentials=credentials, project=project_id)

print(f"Connected to BigQuery project: {client.project}")

query_string = """
select Origin , Destention
from 


"""
query_Job = client.query(query_string)

import pandas as pd 
delta_data = query_Job.to_dataframe()

print(delta_data)