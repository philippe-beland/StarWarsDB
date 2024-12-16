import json
from pathlib import Path
import uuid

current_dir: Path = Path(__file__).parent
data_dir: Path = Path(current_dir, "Raw Data")


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
                self.sources = json.load(open(file, "r"))
            elif "Source" in file.stem:
                self.sources_files[file.stem.lower()] = json.load(open(file, "r"))
            else:  # Entities
                self.entities_files[file.stem.lower()] = json.load(open(file, "r"))

    def generate_uuid(self):
        """
        Generate a UUID for each source and entity.

        Returns:
            dict: A dictionary of sources and entities with UUID.
        """
        self.converting_id_to_uuid = {}
        for type, entity in self.entities_files.items():
            print(type)

    #         new_id = str(uuid.uuid4())
    #         self.converting_id_to_uuid[source["source_id"]] = new_id
    #         source["source_id"] = new_id

    #     new_source_file = Path(data_dir, "Sources_uuid.json")
    #     with open(new_source_file, "w") as f:
    #         json.dump(sources, f, indent=4)

    # def process_personnages(self):
    #     personnages = (
    #         self.arkham_perso + self.dcau_perso + self.films_perso + self.gotham_perso
    #     )
    #     for perso in personnages:
    #         perso["source_id"] = self.converting_id_to_uuid[perso["source_id"]]

    #     new_perso_file = Path(data_dir, "Personnages_uuid.json")
    #     with open(new_perso_file, "w") as f:
    #         json.dump(personnages, f, indent=4)


# x = process_UUID()
# x.load_files(data_dir)
# x.generate_uuid()

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
