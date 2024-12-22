from StarWarsDB.database import StarWarsDB
from StarWarsDB.scrapper.web_scraping import WookieepediaScraping
import requests

db = StarWarsDB()
scrapper = WookieepediaScraping()

# Get character info
character = db.characters[list(db.characters.keys())[1]]
character_info = scrapper.scrape_character(character.name)
if character.species_id is None:
    character.species_id = db.find_species_id(character_info["species"])
if character.homeworld_id is None:
    character.homeworld_id = db.find_planet_id(character_info["homeworld"])

image_file_name = f"{character.name}.jpg"

response = requests.get(character_info["image_url"])
if response.status_code == 200:
    with open(image_file_name, "wb") as file:
        file.write(response.content)
