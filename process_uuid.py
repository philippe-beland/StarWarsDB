import json
from pathlib import Path
import uuid

data_dir: Path = Path(__file__).parent


class process_UUID:
    def __init__(self):
        self.sources_files = {}
        self.entities_files = {}

    def load_files(self, data_dir: Path):
        """
        Load the files from the data directory.

        Args:
            data_dir (Path): The path to the data directory.
        """
        # Loop through file in folder
        for file in data_dir.iterdir():
            if file.stem == "Sources":
                pass
                # self.sources = json.load(open(file, "r"))
            elif "Source" in file.stem:
                pass
                # self.sources_files[file.stem] = json.load(open(file, "r"))
            else:  # Entities
                self.entities_files[file.stem] = json.load(open(file, "r"))

        cleaned_path = Path(data_dir, "Cleaned Data")
        for file in cleaned_path.iterdir():
            if "Source" in file.stem:
                self.sources_files[file.stem] = json.load(open(file, "r"))

    def generate_uuid(self):
        """
        Generate a UUID for each source and entity.
        """
        for type, entity in self.entities_files.items():
            self.converting_id_to_uuid = {}
            print(type)

            for type_source, source in self.sources_files.items():
                if type_source == f"Source{type}":
                    for e in entity:
                        new_id = str(uuid.uuid4())
                        self.converting_id_to_uuid[e["id"]] = new_id
                        e["id"] = new_id

                        for s in source:
                            if s[type[:-1]] in self.converting_id_to_uuid.keys():
                                s[type[:-1]] = self.converting_id_to_uuid[s[type[:-1]]]

                        new_source_file = Path(
                            data_dir, "Processed Data", f"{type_source}_uuid.json"
                        )
                        with open(new_source_file, "w") as f:
                            json.dump(source, f, indent=4)

            new_entity_file = Path(data_dir, "Processed Data", f"{type}_uuid.json")
            with open(new_entity_file, "w") as f:
                json.dump(entity, f, indent=4)


x = process_UUID()
x.load_files(Path(data_dir, "Raw Data"))
x.generate_uuid()


def clean_json(data_dir: Path):
    """
    Clean the JSON files in the data directory.

    Args:
        data_dir (Path): The path to the data directory.
    """
    for file in data_dir.iterdir():
        if file.stem == "Sources":
            pass
        elif "Source" in file.stem:
            new_list = []
            x = json.load(open(file, "r"))
            for y in x:
                # if "Source" in y.keys():
                if len(y.keys()) > 1:
                    if "ID_Test" in y.keys():
                        y.pop("ID_Test")

                    if "ID_test" in y.keys():
                        y.pop("ID_test")

                    if "ID - Test" in y.keys():
                        y.pop("ID - Test")

                    if "Alignement" in y.keys():
                        y.pop("Alignement")

                    if len(y.keys()) < 3:
                        print(file, y)

                    new_list.append(y)

            with open(f"Cleaned Data/{file.stem}_cleaned.json", "w") as f:
                json.dump(new_list, f, indent=4)
