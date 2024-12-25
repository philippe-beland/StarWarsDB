import os
import dotenv
import json
from pathlib import Path
from supabase import create_client, Client

dotenv.load_dotenv("keys.env")

# Supabase
url: str = os.getenv("SUPABASE_URL", "")
key: str = os.getenv("SUPABASE_KEY", "")
supabase: Client = create_client(url, key)

email = os.getenv("SUPABASE_EMAIL")
password = os.getenv("SUPABASE_PASSWORD")
response = supabase.auth.sign_in_with_password({"email": email, "password": password})

current_dir: Path = Path(__file__).parent.parent
data_dir: Path = Path(current_dir, "Star Wars raw Data", "Final Records")

try:
    file = Path(data_dir, "Sources.json")

    with open(file, "r") as f:
        records = json.load(f)

    def insert_data(records: dict, table_name: str):
        try:
            for x in records[0:1]:
                response = supabase.table(table_name).insert(x).execute()
                print(response)
        except Exception as e:
            print(e)
            print("Error while inserting data")

    insert_data(records, "sources")
except Exception as e:
    print(e)
    print("Error while reading data")

response = supabase.auth.sign_out()
