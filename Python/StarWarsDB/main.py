import json
import random
import time
from datetime import datetime
from pathlib import Path

import requests
from StarWarsDB.database import StarWarsDB
from StarWarsDB.scrapper.web_scraping import WookieepediaScraping

db = StarWarsDB()
scrapper = WookieepediaScraping()


def download_image(image_url: str, image_file_name: str):
    response = requests.get(image_url)
    if response.status_code == 200:
        with open(image_file_name, "wb") as file:
            file.write(response.content)


def update_character(character):
    try:
        character_info = scrapper.scrape_character(character.name)
        if character.species_id is None:
            character.species_id = db.find_species_id(character_info["species"])
        if character.homeworld_id is None:
            character.homeworld_id = db.find_planet_id(character_info["homeworld"])

        character.is_scrapped = True
        if character_info["image_url"] is not None:
            download_image(
                character_info["image_url"], f"Images/characters/{character.id}.jpg"
            )

        time.sleep(random.uniform(2, 5))
    except Exception as e:
        print(e)
        print(character.name)


def update_characters(min: int, max: int):
    for i, character_id in enumerate(db.characters.keys()):
        character = db.characters[character_id]
        if i < min:
            continue
        if i > max:
            break

        if character.is_scrapped:
            continue

        print(f"{i}: {character.name}")
        update_character(character)

    # Save to json file
    file = Path("Star Wars raw Data", "Final Records", "Characters.json")
    with open(file, "w", encoding="utf-8") as file:
        json.dump(
            [character.to_json() for character in db.characters.values()],
            file,
            indent=4,
            ensure_ascii=False,
        )


def update_creature(creature):
    try:
        creature_info = scrapper.scrape_creature(creature.name)
        if creature.homeworld_id is None:
            creature.homeworld_id = db.find_planet_id(creature_info["homeworld"])

        if creature.designation is None:
            creature.designation = creature_info["designation"]

        if creature_info["image_url"] is not None:
            download_image(creature_info["image_url"], f"Images/{creature.id}.jpg")

        time.sleep(random.uniform(2, 5))
    except Exception as e:
        print(e)
        print(creature.name)


def update_creatures(min: int, max: int):
    for i, creature_id in enumerate(db.creatures.keys()):
        creature = db.creatures[creature_id]
        if i < min:
            continue
        if i > max:
            break

        print(f"{i}: {creature.name}")
        update_creature(creature)

    # Save to json file
    file = Path("Star Wars raw Data", "Final Records", "Creatures.json")
    with open(file, "w", encoding="utf-8") as file:
        json.dump(
            [creature.to_json() for creature in db.creatures.values()],
            file,
            indent=4,
            ensure_ascii=False,
        )


def update_droid(droid):
    try:
        droid_info = scrapper.scrape_droid(droid.name)
        if droid.class_type is None:
            droid.class_type = droid_info["class_type"]

        if droid_info["image_url"] is not None:
            download_image(droid_info["image_url"], f"Images/droids/{droid.id}.jpg")

        time.sleep(random.uniform(2, 5))

    except Exception as e:
        print(e)
        print(droid.name)


def update_droids(min: int, max: int):
    for i, droid_id in enumerate(db.droids.keys()):
        droid = db.droids[droid_id]
        if i < min:
            continue
        if i > max:
            break

        print(f"{i}: {droid.name}")
        update_droid(droid)

    # Save to json file
    file = Path("Star Wars raw Data", "Final Records", "Droids.json")
    with open(file, "w", encoding="utf-8") as file:
        json.dump(
            [droid.to_json() for droid in db.droids.values()],
            file,
            indent=4,
            ensure_ascii=False,
        )


def update_species(min: int, max: int):
    for i, species_id in enumerate(db.species.keys()):
        species = db.species[species_id]
        if i < min:
            continue
        if i > max:
            break

        print(f"{i}: {species.name}")
        try:
            species_info = scrapper.scrape_species(species.name)
            if species.homeworld_id is None:
                species.homeworld_id = db.find_planet_id(species_info["homeworld"])

            if species_info["image_url"] is not None:
                download_image(
                    species_info["image_url"], f"Images/species/{species.id}.jpg"
                )

            time.sleep(random.uniform(2, 5))
        except Exception as e:
            print(e)
            print(species.name)

    # Save to json file
    file = Path("Star Wars raw Data", "Final Records", "Species.json")
    with open(file, "w", encoding="utf-8") as file:
        json.dump(
            [species.to_json() for species in db.species.values()],
            file,
            indent=4,
            ensure_ascii=False,
        )


def update_organizations(min: int, max: int):
    for i, organization_id in enumerate(db.organizations.keys()):
        organization = db.organizations[organization_id]
        if i < min:
            continue
        if i > max:
            break

        print(f"{i}: {organization.name}")
        try:
            organization_info = scrapper.scrape_organization(organization.name)
            if organization_info["image_url"] is not None:
                download_image(
                    organization_info["image_url"],
                    f"Images/organizations/{organization.id}.jpg",
                )

            time.sleep(random.uniform(2, 5))
        except Exception as e:
            print(e)
            print(organization.name)


def update_starships(min: int, max: int):
    for i, starship_id in enumerate(db.starships.keys()):
        starship = db.starships[starship_id]
        if i < min:
            continue
        if i > max:
            break

        print(f"{i}: {starship.name}")
        try:
            starship_info = scrapper.scrape_starship(starship.name)
            # if starship_info["image_url"] is not None:
            #     download_image(
            #         starship_info["image_url"],
            #         f"Images/starships/{starship.id}.jpg",
            #     )

            if starship_info["product_line"] is not None:
                starship.model_id = db.find_starship_model_id(
                    starship_info["product_line"]
                )

            time.sleep(random.uniform(2, 5))
        except Exception as e:
            print(e)
            print(starship.name)

    # Save to json file
    file = Path("Star Wars raw Data", "Final Records", "Starships.json")
    with open(file, "w", encoding="utf-8") as file:
        json.dump(
            [starship.to_json() for starship in db.starships.values()],
            file,
            indent=4,
            ensure_ascii=False,
        )


def update_starship_models(min: int, max: int):
    for i, starship_model_id in enumerate(db.starship_models.keys()):
        starship_model = db.starship_models[starship_model_id]
        if i < min:
            continue
        if i > max:
            break

        print(f"{i}: {starship_model.name}")
        try:
            starship_model_info = scrapper.scrape_starship_model(starship_model.name)
            if starship_model_info["image_url"] is not None:
                download_image(
                    starship_model_info["image_url"],
                    f"Images/starship_models/{starship_model.id}.jpg",
                )
            if starship_model_info["class_type"] is not None:
                starship_model.class_type = starship_model_info["class_type"]

            if starship_model_info["line"] is not None:
                starship_model.line = starship_model_info["line"]

            time.sleep(random.uniform(2, 5))
        except Exception as e:
            print(e)
            print(starship_model.name)

    # Save to json file
    file = Path("Star Wars raw Data", "Final Records", "StarshipModels.json")
    with open(file, "w", encoding="utf-8") as file:
        json.dump(
            [
                starship_model.to_json()
                for starship_model in db.starship_models.values()
            ],
            file,
            indent=4,
            ensure_ascii=False,
        )


def update_sources(min: int, max: int):
    for i, source_id in enumerate(db.sources.keys()):
        source = db.sources[source_id]
        if i < min:
            continue
        if i > max:
            break

        # print(f"{i}: {source.name}")
        # try:
        #     if source.name:
        #         source_info = scrapper.scrape_source(source.name)
        #         if source_info["image_url"] is not None:
        #             download_image(
        #                 source_info["image_url"],
        #                 f"Images/sources/{source.id}.jpg",
        #             )

        #         if source_info["timeline"] is not None:
        #             source.universe_year = source_info["timeline"]

        #         time.sleep(random.uniform(2, 5))

        # except Exception as e:
        #     print(e)
        #     print(source.name)

        # Process Date Format
        if source.publication_date:
            date_object = datetime.utcfromtimestamp(source.publication_date / 1000)
            source.publication_date = date_object.strftime("%Y-%m-%d")

        # Process Universe Year
        if source.universe_year:
            universe_year = source.universe_year.split(" ")
            if len(universe_year) == 3 and universe_year[0] == "c.":
                universe_year = universe_year[1:]
            elif len(universe_year) == 1:
                print(source.universe_year)

            try:
                year = universe_year[0]
                era = universe_year[1]

                if year.isdigit():
                    year = int(year)
                else:
                    year = int(year.split("-")[0])

                if year == 0:
                    source.universe_year = 0
                elif era == "BBY":
                    source.universe_year = -year
                elif era == "ABY":
                    source.universe_year = year

            except Exception as e:
                print(e)

    # Save to json file
    file = Path("Star Wars raw Data", "Final Records", "Sources2.json")
    with open(file, "w", encoding="utf-8") as file:
        json.dump(
            [source.to_json() for source in db.sources.values()],
            file,
            indent=4,
            ensure_ascii=False,
        )


def update_varias(min: int, max: int):
    for i, varia_id in enumerate(db.varia.keys()):
        varia = db.varia[varia_id]
        if i < min:
            continue
        if i > max:
            break

        print(f"{i}: {varia.name}")
        try:
            varia_info = scrapper.scrape_varias(varia.name)
            if varia_info["image_url"] is not None:
                download_image(
                    varia_info["image_url"],
                    f"Images/varias/{varia.id}.jpg",
                )

            time.sleep(random.uniform(2, 5))

        except Exception as e:
            print(e)
            print(varia.name)


def update_planets(min: int, max: int):
    for i, planet_id in enumerate(db.planets.keys()):
        planet = db.planets[planet_id]
        if i < min:
            continue
        if i > max:
            break

        print(f"{i}: {planet.name}")
        try:
            planet_info = scrapper.scrape_planet(planet.name)
            if planet_info["image_url"] is not None:
                download_image(
                    planet_info["image_url"],
                    f"Images/planets/{planet.id}.jpg",
                )

            if planet_info["region"] is not None:
                planet.region = planet_info["region"]

            if planet_info["sector"] is not None:
                planet.sector = planet_info["sector"]

            if planet_info["system"] is not None:
                planet.system = planet_info["system"]

            if planet_info["capital_city"] is not None:
                planet.capital_city = planet_info["capital_city"]

            time.sleep(random.uniform(2, 5))

        except Exception as e:
            print(e)
            print(planet.name)

    # Save to json file
    file = Path("Star Wars raw Data", "Final Records", "Planets.json")
    with open(file, "w", encoding="utf-8") as file:
        json.dump(
            [planet.to_json() for planet in db.planets.values()],
            file,
            indent=4,
            ensure_ascii=False,
        )


update_characters(0, 100000)
