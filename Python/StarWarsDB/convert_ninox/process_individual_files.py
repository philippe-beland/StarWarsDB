import json
from pathlib import Path

data_dir = Path(Path(__file__).parent, "Processed Data")


def get_unique_keys(data):
    """
    Get the unique keys in the file.
    """
    unique_keys = set()
    for y in data:
        for key in y.keys():
            unique_keys.add(key)

    return unique_keys


def process_arcs():
    """
    Process the arcs files.
    """
    arcs = json.load(open(Path(data_dir, "Arc.json"), "r", encoding="utf-8"))
    print(f"Arcs: {get_unique_keys(arcs)}")


def process_artists():
    """
    Process the artists files.
    """
    artists = json.load(open(Path(data_dir, "Artists.json"), "r", encoding="utf-8"))
    print(f"Artists: {get_unique_keys(artists)}")


def process_characters():
    """
    Process the characters files.
    """
    characters = json.load(
        open(Path(data_dir, "Characters.json"), "r", encoding="utf-8")
    )
    print(f"Characters: {get_unique_keys(characters)}")

    sex_dict = {
        "1": "Male",
        "2": "Female",
        "3": "Other",
    }

    organizations = json.load(
        open(Path(data_dir, "Organizations.json"), "r", encoding="utf-8")
    )
    organizations_ancien = json.load(
        open(
            Path(Path(__file__).parent, "Raw Data", "Organizations_2.json"),
            "r",
            encoding="utf-8",
        )
    )

    orgs_dict = {}
    for x in organizations:
        name = x["name"]

        for y in organizations_ancien:
            if y["Name"] == name:
                orgs_dict[int(y["real_id"])] = x["id"]
                break

    for x in characters:
        # Remove the first_appearance_canon field
        if "first_appearance_canon" in x:
            del x["first_appearance_canon"]

        # Split Alias into list
        if "alias" in x:
            x["alias"] = x["alias"].split(", ")

        # Change Sex
        if "sex" in x:
            x["sex"] = sex_dict[x["sex"]]

        # Change affiliation into List and use UUID
        if "Affiliation" in x:
            x["affiliation"] = [orgs_dict[x["Affiliation"]]]
            del x["Affiliation"]

        # Rename first_appearance_legends to first_appearance
        if "first_appearance_legends" in x:
            x["first_appearance"] = x["first_appearance_legends"]
            del x["first_appearance_legends"]

    # Save
    with open(Path(data_dir, "Characters_2.json"), "w", encoding="utf-8") as f:
        json.dump(characters, f, indent=4, ensure_ascii=False)


def process_creatures():
    """
    Process the creatures files.
    """
    creatures = json.load(open(Path(data_dir, "Creatures.json"), "r", encoding="utf-8"))
    print(f"Creatures: {get_unique_keys(creatures)}")


def process_droids():
    """
    Process the droids files.
    """
    droids = json.load(open(Path(data_dir, "Droids.json"), "r", encoding="utf-8"))
    print(f"Droids: {get_unique_keys(droids)}")


def process_facts():
    """
    Process the facts files.
    """
    facts = json.load(open(Path(data_dir, "Facts.json"), "r", encoding="utf-8"))
    print(f"Facts: {get_unique_keys(facts)}")

    for x in facts:
        # Split keywords into list
        if "keywords" in x:
            x["keywords"] = x["keywords"].split(", ")

    # Save
    with open(Path(data_dir, "Facts_2.json"), "w", encoding="utf-8") as f:
        json.dump(facts, f, indent=4, ensure_ascii=False)


def process_organizations():
    """
    Process the organizations files.
    """
    organizations = json.load(
        open(Path(data_dir, "Organizations.json"), "r", encoding="utf-8")
    )
    print(f"Organizations: {get_unique_keys(organizations)}")


def process_planets():
    """
    Process the planets files.
    """
    planets = json.load(open(Path(data_dir, "Planets.json"), "r", encoding="utf-8"))
    print(f"Planets: {get_unique_keys(planets)}")

    regions = {
        "1": "Core Worlds",
        "2": "Colonies",
        "3": "Inner Rim",
        "4": "Expansion Region",
        "5": "Mid Rim",
        "6": "Outer Rim",
        "7": "Wild Space",
        "8": "Unknown Regions",
    }

    for x in planets:
        # Remove the first_appearance_canon field
        if "first_appearance_canon" in x:
            del x["first_appearance_canon"]

        # Rename first_appearance_legends to first_appearance
        if "first_appearance_legends" in x:
            x["first_appearance"] = x["first_appearance_legends"]
            del x["first_appearance_legends"]

        # Separate destinations into list
        if "destinations" in x:
            x["destinations"] = x["destinations"].split(", ")

        # remove "suns"
        if "suns" in x:
            del x["suns"]

        # remove "moons"
        if "moons" in x:
            del x["moons"]

        # remove "terrain"
        if "terrain" in x:
            del x["terrain"]

        # Convert Region
        if "region" in x:
            x["region"] = regions[x["region"]]

    # Save
    with open(Path(data_dir, "Planets_2.json"), "w", encoding="utf-8") as f:
        json.dump(planets, f, indent=4, ensure_ascii=False)


def process_serie():
    """
    Process the serie files.
    """
    serie = json.load(open(Path(data_dir, "Serie.json"), "r", encoding="utf-8"))
    print(f"Serie: {get_unique_keys(serie)}")


def process_sources():
    """
    Process the sources files.
    """
    sources = json.load(open(Path(data_dir, "Sources.json"), "r", encoding="utf-8"))
    print(f"Sources: {get_unique_keys(sources)}")

    era = {
        "1": "High Republic",
        "2": "Fall of the Jedi",
        "3": "Reign of the Empire",
        "4": "Age of Rebellion",
        "5": "New Republic",
        "6": "Rise of the First Order",
        "7": "Dawn of the Jedi",
        "8": "Old Republic",
        "9": "New Jedi Order",
    }

    source_type = {
        "1": "Movie",
        "2": "Comic Book",
        "3": "Novel",
        "4": "Short Story",
        "5": "TV Serie",
        "6": "Video Game",
        "7": "Reference Book",
    }

    arcs = json.load(open(Path(data_dir, "Arc.json"), "r", encoding="utf-8"))
    arcs_ancien = json.load(
        open(
            Path(Path(__file__).parent, "Raw Data", "Arc_2.json"), "r", encoding="utf-8"
        )
    )

    arcs_dict = {}
    for x in arcs:
        name = x["name"]

        for y in arcs_ancien:
            if y["Arc"] == name:
                arcs_dict[int(y["real_id"])] = x["id"]

    for x in sources:
        # Change Arc into UUID
        if "arc" in x:
            x["arc"] = arcs_dict[x["arc"]]

        # Change Era into field
        if "era" in x:
            x["era"] = era[x["era"]]

        # Rename type into source_type
        if "type" in x:
            x["source_type"] = source_type[x["type"]]
            del x["type"]

        # Rename number of pages into number_pages
        if "number of pages" in x:
            x["number_pages"] = x["number of pages"]
            del x["number of pages"]

        # Rename done into is_done
        if "done" in x:
            x["is_done"] = x["done"]
            del x["done"]

    # Save
    with open(Path(data_dir, "Sources_2.json"), "w", encoding="utf-8") as f:
        json.dump(sources, f, indent=4, ensure_ascii=False)


def process_species():
    """
    Process the species files.
    """
    species = json.load(open(Path(data_dir, "Species.json"), "r", encoding="utf-8"))
    print(f"Species: {get_unique_keys(species)}")

    for x in species:
        # Remove the first_appearance_canon field
        if "first_appearance_canon" in x:
            del x["first_appearance_canon"]

        # Rename first_appearance_legends to first_appearance
        if "first_appearance_legends" in x:
            x["first_appearance"] = x["first_appearance_legends"]
            del x["first_appearance_legends"]

    # Save
    with open(Path(data_dir, "Species_2.json"), "w", encoding="utf-8") as f:
        json.dump(species, f, indent=4, ensure_ascii=False)


def process_starships():
    """
    Process the starships files.
    """
    source_starships = json.load(
        open(Path(data_dir, "SourceStarships.json"), "r", encoding="utf-8")
    )
    starships = json.load(
        open(Path(data_dir, "Starships_2.json"), "r", encoding="utf-8")
    )
    starships_models = json.load(
        open(Path(data_dir, "StarshipModels.json"), "r", encoding="utf-8")
    )

    print(f"Starships: {get_unique_keys(starships)}")
    print(f"Starship Models: {get_unique_keys(starships_models)}")

    sourcestarships = []
    sourcestarshipmodels = []
    starship_dict = {}
    starshipmodel_dict = {}

    for x in starships:
        starship_dict[x["id"]] = x
    for x in starships_models:
        starshipmodel_dict[x["id"]] = x

    i = 0
    for x in source_starships:
        if x["starship"] in starship_dict:
            sourcestarships.append(x)
        elif x["starship"] in starshipmodel_dict:
            # Rename starship to starship_model
            x["starship_model"] = x["starship"]
            del x["starship"]
            sourcestarshipmodels.append(x)
        else:
            i += 1

    print(i)

    # Save to JSON
    with open(Path(data_dir, "SourceStarships_2.json"), "w", encoding="utf-8") as f:
        json.dump(sourcestarships, f, indent=4, ensure_ascii=False)

    with open(
        Path(data_dir, "SourceStarshipModels_2.json"), "w", encoding="utf-8"
    ) as f:
        json.dump(sourcestarshipmodels, f, indent=4, ensure_ascii=False)


def process_varias():
    """
    Process the varias files.
    """
    varias = json.load(open(Path(data_dir, "Varias.json"), "r", encoding="utf-8"))
    print(f"Varias: {get_unique_keys(varias)}")


process_arcs()
process_artists()
process_characters()
process_creatures()
process_droids()
process_facts()
process_organizations()
process_planets()
process_serie()
process_sources()
process_species()
process_starships()
process_varias()
