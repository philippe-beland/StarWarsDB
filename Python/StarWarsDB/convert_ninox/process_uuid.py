import json
from pathlib import Path
import uuid

data_dir: Path = Path(__file__).parent


class process_UUID:
    def __init__(self):
        self.sources_files = {}
        self.entities_files = {}
        self.real_id_files = {}

    def load_files(self, data_dir: Path):
        """
        Load the files from the data directory.

        Args:
            data_dir (Path): The path to the data directory.
        """
        # Loop through file in folder
        for file in data_dir.iterdir():
            if "_2" in file.stem:
                data = json.load(open(file, "r", encoding="utf-8"))
                self.real_id_files[file.stem[0:-2]] = {}
                for x in data:
                    self.real_id_files[file.stem[0:-2]][x["id"]] = x["real_id"]
            elif file.stem == "Sources":
                self.entities_files[file.stem] = json.load(
                    open(file, "r", encoding="utf-8")
                )
            elif "Source" in file.stem:
                pass
            elif file.suffix == ".json":
                self.entities_files[file.stem] = json.load(
                    open(file, "r", encoding="utf-8")
                )

        cleaned_path = Path(data_dir, "Cleaned Data")
        for file in cleaned_path.iterdir():
            if "Source" in file.stem:
                self.sources_files[file.stem] = json.load(
                    open(file, "r", encoding="utf-8")
                )

    def generate_entity_uuid(self):
        """
        Generate a UUID for each source and entity.
        """
        for entity_type, entities in self.entities_files.items():

            if not hasattr(self, entity_type.lower()):
                self.__setattr__(entity_type.lower(), {})

            entity_dict = getattr(self, entity_type.lower())

            for e in entities:
                new_id = str(uuid.uuid4())
                real_id = int(self.real_id_files[entity_type][e["id"]])
                entity_dict[real_id] = new_id
                e["id"] = new_id

    def convert_sources_uuid(self):
        """
        Convert the sources UUID to the new UUID.
        """
        for type_source, source in self.sources_files.items():

            entity_type = type_source[6:-1]

            if entity_type == "Author":
                entity_type = "Artist"
            entity_type2 = f"{entity_type}s".lower()

            for s in source:
                if s["Source"] in self.sources:
                    s["Source"] = self.sources[s["Source"]]
                if s[entity_type] in getattr(self, entity_type2):
                    s[entity_type] = getattr(self, entity_type2)[s[entity_type]]

                new_id = str(uuid.uuid4())
                s["id"] = new_id

    def process_relationships(self):
        """
        Process the relationships between entities.
        """
        for x in self.entities_files.values():
            for entity in x:
                for key, value in entity.items():
                    if key == "First apparition (Canon)":
                        entity[key] = self.sources[value]
                    elif key == "Source":
                        entity[key] = self.sources[value]
                    elif key == "Species":
                        entity[key] = self.species[value]
                    elif key == "Serie":
                        entity[key] = self.serie[value]
                    elif key == "Homeworld":
                        entity[key] = self.planets[value]

    def save_files(self):
        """
        Save the files to the data directory.
        """
        for type, entities in self.entities_files.items():
            new_entity_file = Path(data_dir, "Processed Data", f"{type}_uuid.json")
            with open(new_entity_file, "w", encoding="utf-8") as f:
                json.dump(
                    entities,
                    f,
                    indent=4,
                    ensure_ascii=False,
                )

        for type, sources in self.sources_files.items():
            new_source_file = Path(data_dir, "Processed Data", f"{type}_uuid.json")
            with open(new_source_file, "w", encoding="utf-8") as f:
                json.dump(
                    sources,
                    f,
                    indent=4,
                    ensure_ascii=False,
                )


# x = process_UUID()
# x.load_files(Path(data_dir, "Raw Data"))
# x.generate_entity_uuid()
# x.convert_sources_uuid()
# x.process_relationships()
# x.save_files()


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


for file in Path(data_dir, "Processed Data").iterdir():
    if not file.is_dir():
        unique_keys = set()
        x = json.load(open(file, "r"))
        if file.stem == "Sources":
            for y in x:
                if "ID" in y.keys():
                    y.pop("ID")
                if "Link" in y.keys():
                    y.pop("Link")
        elif file.stem == "References":
            for y in x:
                if "ID_test" in y.keys():
                    y.pop("ID_test")
        elif file.stem == "Facts":
            for y in x:
                if "ID_Test" in y.keys():
                    y.pop("ID_Test")
        else:
            continue

        # Save back
        with open(Path(data_dir, "Processed Data", f"{file.stem}_2.json"), "w") as f:
            json.dump(
                x,
                f,
                indent=4,
                ensure_ascii=False,
            )
