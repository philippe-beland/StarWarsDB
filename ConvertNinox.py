from pathlib import Path
import ast
import json


# Open file and read the contents
ninox_filepath = Path(
    "/Users/philippebeland/Library/Containers/de.ninoxdb.ninox-mac.Ninox/Data/Documents/data/DC2"
)

with open(Path(ninox_filepath, "data.db"), "r") as file:
    db_raw = file.read().replace("false", "False").replace("true", "True")

db = db_raw.split("\n")

db_infos = db.pop(0)[2:]
db_tables = ast.literal_eval(db_infos)["types"]

tables = {}

for table_id, table_info in db_tables.items():
    table_name = table_info["caption"]
    uuid = table_info["uuid"]
    fields = table_info["fields"]

    new_fields = {}

    for field_id, field_info in fields.items():
        field_name = field_info["caption"]
        field_type = field_info["base"]
        field_uuid = field_info["uuid"]
        field_required = field_info.get("required", "")
        field_values = field_info.get("values", None)

        new_fields[field_id] = {
            "name": field_name,
            "type": field_type,
            "uuid": field_uuid,
            "required": field_required,
            "values": field_values,
        }
    tables[table_id] = {"name": table_name, "uuid": uuid, "fields": new_fields}

records = {}
for i, record in enumerate(db):
    record_info = record.split(":", 1)
    if len(record_info) == 2:
        id = record_info[0]
        if id[0] == "U":
            table_id = id[1]
            if table_id in records.keys():
                records[table_id].append(ast.literal_eval(record_info[1]))
            else:
                records[table_id] = [ast.literal_eval(record_info[1])]

table_lists = []
for table, record_list in records.items():
    records = []
    for i, record in enumerate(record_list):
        record_names = {}
        for field_id, field in record.items():
            field_name = tables[table]["fields"][field_id]["name"]
            record_names[field_name] = field
        record_names["id"] = i + 1
        records.append(record_names)
    table_lists.append({tables[table]["name"]: records})

# Export each table to JSON
for table in table_lists:
    for table_name, records in table.items():
        with open(f"{table_name}.json", "w") as file:
            json.dump(records, file, indent=4)
