from pathlib import Path
from typing import List, Tuple
import ast
import json


database_name = "Star Wars2"


# Open file and read the contents
def open_ninox_file(db_name: str) -> List[str]:
    """
    Read the contents of a Ninox database file and return a dictionary of tables.

    Args:
        db_name (str): The name of the Ninox database file.

    Returns:
        dict: A dictionary of tables
    """
    ninox_filepath = Path(
        "/Users/philippebeland/Library/Containers/de.ninoxdb.ninox-mac.Ninox/Data/Documents/data",
        db_name,
    )
    with open(Path(ninox_filepath, "data.db"), "r") as file:
        db = file.read().replace("false", "False").replace("true", "True").split("\n")

    # db_infos = db.pop(0)[2:]

    return db


def process_tables() -> dict:
    """
    Process the tables of a Ninox database and return a dictionary of tables.

    Returns:
        dict: A dictionary of tables
    """
    # Read JSON
    with open("db_infos.json", "r") as file:
        db_tables = json.load(file)

    tables = {}

    for table_id, table_info in db_tables["types"].items():
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

    return tables


def process_records(db: List[str], tables: dict) -> List[dict]:
    """
    Process the records of a Ninox database and return a list of records.

    Args:
        db (list): A list of records from a Ninox database.
        tables (dict): A dictionary of tables from a Ninox database.

    Returns:
        List[dict]: A list of records
    """
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

    return table_lists


def export_to_json(table_lists: List[dict]) -> None:
    """
    Export a list of tables to JSON files.

    Args:
        table_lists (List[dict]): A list of tables.
    """
    for table in table_lists:
        for table_name, records in table.items():
            with open(Path("Raw Data", f"{table_name}.json"), "w") as file:
                json.dump(records, file, indent=4)


db = open_ninox_file(database_name)
tables = process_tables()
table_lists = process_records(db, tables)
export_to_json(table_lists)
