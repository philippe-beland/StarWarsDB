import json
from pathlib import Path
import pandas as pd


data_dir: Path = Path(Path(__file__).parent, "Pre-scraping")

for file in data_dir.iterdir():
    if file.suffix == ".json":
        data = json.load(open(file, "r", encoding="utf-8"))

        # Saves the data in a CSV file
        df = pd.DataFrame(data)
        print(df.head())
        df.to_csv(Path(data_dir, file.stem + ".csv"), index=False)
