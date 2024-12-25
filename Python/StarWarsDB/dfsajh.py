from pathlib import Path
import json

data_dir = Path(Path(__file__).parent, "Star Wars raw Data")

old_file = Path(data_dir, "Pre-scraping", "Characters.json")
new_file = Path(data_dir, "Final Records", "Characters.json")

with open(old_file, "r") as f:
    old_records = json.load(f)

with open(new_file, "r") as f:
    new_records = json.load(f)

old_db = {record["id"]: record for record in old_records}
new_db = {record["id"]: record for record in new_records}

for record_id in old_db:
    if "species" in old_db[record_id]:
        new_db[record_id]["species_id"] = old_db[record_id]["species"]

    if "homeworld" in old_db[record_id]:
        new_db[record_id]["homeworld_id"] = old_db[record_id]["homeworld"]

    new_db[record_id].pop("")
