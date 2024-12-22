from pathlib import Path
import json
import uuid
from typing import Dict, List, Optional

from StarWarsDB.classes.arc import Arc
from StarWarsDB.classes.artist import Artist
from StarWarsDB.classes.character import Character
from StarWarsDB.classes.creature import Creature
from StarWarsDB.classes.droid import Droid
from StarWarsDB.classes.fact import Fact
from StarWarsDB.classes.organization import Organization
from StarWarsDB.classes.planet import Planet
from StarWarsDB.classes.serie import Serie
from StarWarsDB.classes.species import Species
from StarWarsDB.classes.starship import Starship
from StarWarsDB.classes.source import Source
from StarWarsDB.classes.starship_model import StarshipModel
from StarWarsDB.classes.varia import Varia

from StarWarsDB.classes.internal.source_artist import SourceArtist
from StarWarsDB.classes.internal.source_author import SourceAuthor
from StarWarsDB.classes.internal.source_character import SourceCharacter
from StarWarsDB.classes.internal.source_creature import SourceCreature
from StarWarsDB.classes.internal.source_droid import SourceDroid
from StarWarsDB.classes.internal.source_organization import SourceOrganization
from StarWarsDB.classes.internal.source_planet import SourcePlanet
from StarWarsDB.classes.internal.source_species import SourceSpecies
from StarWarsDB.classes.internal.source_starship import SourceStarship
from StarWarsDB.classes.internal.source_starshipmodel import SourceStarshipModel
from StarWarsDB.classes.internal.source_varia import SourceVaria


class StarWarsDB:
    """
    Big class that contains all the data from the Star Wars DB
    """

    def __init__(self):
        """
        Initialize the class
        """
        self.data_path = Path("Star Wars raw Data")

        self.load_all()
        self.resolve_ids()

    def load_all(self) -> None:
        """
        Load all the data from the json files
        """
        self.arcs = self._load_arcs()
        self.artists = self._load_artists()
        self.characters = self._load_characters()
        self.creatures = self._load_creatures()
        self.droids = self._load_droids()
        self.facts = self._load_facts()
        self.organizations = self._load_organizations()
        self.planets = self._load_planets()
        self.series = self._load_series()
        self.sources = self._load_sources()
        self.species = self._load_species()
        self.starships = self._load_starships()
        self.starship_models = self._load_starship_models()
        self.varia = self._load_varia()

        self.source_artists = self._load_source_artists()
        self.source_authors = self._load_source_authors()
        self.source_characters = self._load_source_characters()
        self.source_creatures = self._load_source_creatures()
        self.source_droids = self._load_source_droids()
        self.source_organizations = self._load_source_organizations()
        self.source_planets = self._load_source_planets()
        self.source_species = self._load_source_species()
        self.source_starships = self._load_source_starships()
        self.source_starship_models = self._load_source_starship_models()
        self.source_varia = self._load_source_varia()

    def resolve_ids(self) -> None:
        """
        Add objects references to the objects that have ids
        """
        self._resolve_arcs()
        self._resolve_artists()
        self._resolve_characters()
        self._resolve_creatures()
        self._resolve_droids()
        self._resolve_facts()
        self._resolve_organizations()
        self._resolve_planets()
        self._resolve_series()
        self._resolve_sources()
        self._resolve_species()
        self._resolve_starships()
        self._resolve_starship_models()
        self._resolve_varia()
        self._resolve_source_items()

    def _resolve_source_items(self) -> None:
        """
        Add objects references to the source items
        """
        self._resolve_source_artists()
        self._resolve_source_authors()
        self._resolve_source_characters()
        self._resolve_source_creatures()
        self._resolve_source_droids()
        self._resolve_source_organizations()
        self._resolve_source_planets()
        self._resolve_source_species()
        self._resolve_source_starships()
        self._resolve_source_starship_models()
        self._resolve_source_varia()

    def add_missing_species(self) -> None:
        """
        Add the missing species to the sources, based on characters
        """
        for source in self.sources.values():
            species = [species["species"] for species in source.species]
            for character in source.characters:
                if character["appearance"] == "1":
                    character = character["character"]
                    if character.species is not None:
                        if character.species.name != "Droid":
                            if character.species not in species:
                                self.source_species.append(
                                    SourceSpecies(
                                        id=uuid.uuid4(),
                                        source_id=str(source.id),
                                        species_id=str(character.species.id),
                                        appearance="1",
                                    )
                                )

        # Save to json file
        file = Path(self.data_path, "Final Records", "SourceSpecies.json")
        with open(
            file,
            "w",
            encoding="utf-8",
        ) as file:
            json.dump(
                [source_species.to_json() for source_species in self.source_species],
                file,
                indent=4,
                ensure_ascii=False,
            )

    def add_missing_starship_models(self) -> None:
        """
        Add the missing starship models to the starships, based on the models
        """
        # WE NEED TO ADD THE MODELS TO THE STARSHIPS
        j = 0
        i = 0
        k = 0
        l = 0
        m = 0
        n = 0

        for source in self.sources.values():
            starship_models = [
                starship_model["starship_model"]
                for starship_model in source.starship_models
            ]
            for starship in source.starships:
                j += 1
                if starship["appearance"] == "1":
                    i += 1
                    starship = starship["starship"]
                    if starship.model is not None:
                        k += 1
                        if starship.model not in starship_models:
                            l += 1
                            self.source_starship_models.append(
                                SourceStarshipModel(
                                    id=uuid.uuid4(),
                                    source_id=str(source.id),
                                    starship_model_id=str(starship.model.id),
                                    appearance="1",
                                )
                            )

        print(j)
        print(i)
        print(k)
        print(l)
        print(m)
        print(n)

        # # Save to json file
        # file = Path(self.data_path, "Final Records", "SourceStarshipModels.json")
        # with open(
        #     file,
        #     "w",
        #     encoding="utf-8",
        # ) as file:
        #     json.dump(
        #         [
        #             source_starship_model.to_json()
        #             for source_starship_model in self.source_starship_models
        #         ],
        #         file,
        #         indent=4,
        #         ensure_ascii=False,
        #     )

    def _resolve_source_artists(self) -> None:
        """
        Add objects references to the source artists
        """
        for source_artist in self.source_artists:
            source_artist.source = self.sources[source_artist.source_id]
            source_artist.artist = self.artists[source_artist.artist_id]

            source_artist.source.artists.append(source_artist.artist)

    def _resolve_source_authors(self) -> None:
        """
        Add objects references to the source authors
        """
        for source_author in self.source_authors:
            source_author.source = self.sources[source_author.source_id]
            source_author.author = self.artists[source_author.author_id]

            source_author.source.authors.append(source_author.author)

    def _resolve_source_characters(self) -> None:
        """
        Add objects references to the source characters
        """
        for source_character in self.source_characters:
            source_character.source = self.sources[source_character.source_id]
            source_character.character = self.characters[source_character.character_id]

            source_character.source.characters.append(
                {
                    "character": source_character.character,
                    "appearance": source_character.appearance,
                }
            )

    def _resolve_source_creatures(self) -> None:
        """
        Add objects references to the source creatures
        """
        for source_creature in self.source_creatures:
            source_creature.source = self.sources[source_creature.source_id]
            source_creature.creature = self.creatures[source_creature.creature_id]

            source_creature.source.creatures.append(
                {
                    "creature": source_creature.creature,
                    "appearance": source_creature.appearance,
                }
            )

    def _resolve_source_droids(self) -> None:
        """
        Add objects references to the source droids
        """
        for source_droid in self.source_droids:
            source_droid.source = self.sources[source_droid.source_id]
            source_droid.droid = self.droids[source_droid.droid_id]

            source_droid.source.droids.append(
                {"droid": source_droid.droid, "appearance": source_droid.appearance}
            )

    def _resolve_source_organizations(self) -> None:
        """
        Add objects references to the source organizations
        """
        for source_organization in self.source_organizations:
            source_organization.source = self.sources[source_organization.source_id]
            source_organization.organization = self.organizations[
                source_organization.organization_id
            ]

            source_organization.source.organizations.append(
                {
                    "organization": source_organization.organization,
                    "appearance": source_organization.appearance,
                }
            )

    def _resolve_source_planets(self) -> None:
        """
        Add objects references to the source planets
        """
        for source_planet in self.source_planets:
            source_planet.source = self.sources[source_planet.source_id]
            source_planet.planet = self.planets[source_planet.planet_id]

            source_planet.source.planets.append(
                {"planet": source_planet.planet, "appearance": source_planet.appearance}
            )

    def _resolve_source_species(self) -> None:
        """
        Add objects references to the source species
        """
        for source_species in self.source_species:
            source_species.source = self.sources[source_species.source_id]
            source_species.species = self.species[source_species.species_id]

            source_species.source.species.append(
                {
                    "species": source_species.species,
                    "appearance": source_species.appearance,
                }
            )

    def _resolve_source_starships(self) -> None:
        """
        Add objects references to the source starships
        """
        for source_starship in self.source_starships:
            source_starship.source = self.sources[source_starship.source_id]
            source_starship.starship = self.starships[source_starship.starship_id]

            source_starship.source.starships.append(
                {
                    "starship": source_starship.starship,
                    "appearance": source_starship.appearance,
                }
            )

    def _resolve_source_starship_models(self) -> None:
        """
        Add objects references to the source starship models
        """
        for source_starship_model in self.source_starship_models:
            source_starship_model.source = self.sources[source_starship_model.source_id]
            source_starship_model.starship_model = self.starship_models[
                source_starship_model.starship_model_id
            ]

            source_starship_model.source.starship_models.append(
                {
                    "starship_model": source_starship_model.starship_model,
                    "appearance": source_starship_model.appearance,
                }
            )

    def _resolve_source_varia(self) -> None:
        """
        Add objects references to the source varias
        """
        for source_varia in self.source_varia:
            source_varia.source = self.sources[source_varia.source_id]
            source_varia.varia = self.varia[source_varia.varia_id]

            source_varia.source.varias.append(
                {"varia": source_varia.varia, "appearance": source_varia.appearance}
            )

    def _resolve_arcs(self) -> None:
        """
        Add objects references to the arcs
        """
        for arc in self.arcs.values():
            if arc.serie_id is not None:
                arc.serie = self.series[arc.serie_id]

    def _resolve_artists(self):
        pass

    def _resolve_characters(self) -> None:
        """
        Add objects references to the characters
        """
        for character in self.characters.values():
            if character.species_id is not None:
                character.species = self.species[character.species_id]

            if character.homeworld_id is not None:
                character.homeworld = self.planets[character.homeworld_id]

            character.affiliations = [
                self.organizations[affiliation_id]
                for affiliation_id in character.affiliations_id
            ]

    def _resolve_creatures(self) -> None:
        """
        Add objects references to the creatures
        """
        for creature in self.creatures.values():
            if creature.homeworld_id is not None:
                creature.homeworld = self.planets[creature.homeworld_id]

    def _resolve_droids(self):
        pass

    def _resolve_facts(self) -> None:
        """
        Add objects references to the facts
        """
        for fact in self.facts.values():
            if fact.source_id is not None:
                fact.source = self.sources[fact.source_id]

    def _resolve_organizations(self):
        pass

    def _resolve_planets(self):
        pass

    def _resolve_series(self):
        pass

    def _resolve_sources(self):
        pass

    def _resolve_species(self) -> None:
        """
        Add objects references to the species
        """
        for species in self.species.values():
            if species.homeworld_id is not None:
                species.homeworld = self.planets[species.homeworld_id]

    def _resolve_starships(self) -> None:
        """
        Add objects references to the starships
        """
        for starship in self.starships.values():
            if starship.model_id is not None:
                starship.model = self.starship_models[starship.model_id]

    def _resolve_starship_models(self):
        pass

    def _resolve_varia(self):
        pass

    def _load_arcs(self) -> Dict[str, Arc]:
        """
        Load the arcs from the json file

        Returns:
            Dict[str, Arc]: List of arcs
        """
        file = Path(self.data_path, "Pre-scraping", "Arc.json")
        with open(file, "r", encoding="utf-8") as file:
            arc_raw = json.load(file)

        return {
            arc["id"]: Arc(
                id=arc["id"],
                name=arc["name"],
                serie_id=arc.get("serie", None),
                comments=arc.get("comments", ""),
            )
            for arc in arc_raw
        }

    def _load_artists(self) -> Dict[str, Artist]:
        """
        Load the artists from the json file

        Returns:
            Dict[str, Artist]: List of artists
        """
        file = Path(self.data_path, "Pre-scraping", "Artists.json")
        with open(file, "r", encoding="utf-8") as file:
            artist_raw = json.load(file)

        return {
            artist["id"]: Artist(
                id=artist["id"],
                name=artist["name"],
                comments=artist.get("comments", ""),
            )
            for artist in artist_raw
        }

    def _load_characters(self) -> Dict[str, Character]:
        """
        Load the characters from the json file

        Returns:
            Dict[str, Character]: List of characters
        """
        file = Path(self.data_path, "Pre-scraping", "Characters.json")
        with open(file, "r", encoding="utf-8") as file:
            character_raw = json.load(file)

        return {
            character["id"]: Character(
                id=character["id"],
                name=character["name"],
                aliases=character.get("aliases", []),
                species_id=character.get("species", None),
                homeworld_id=character.get("homeworld", None),
                sex=character.get("sex", None),
                affiliations_id=character.get("affiliations", []),
                first_appearance=character.get("first_appearance", None),
                comments=character.get("comments", ""),
            )
            for character in character_raw
        }

    def _load_creatures(self) -> Dict[str, Creature]:
        """
        Load the creatures from the json file

        Returns:
            Dict[str, Creature]: List of creatures
        """
        file = Path(self.data_path, "Pre-scraping", "Creatures.json")
        with open(file, "r", encoding="utf-8") as file:
            creature_raw = json.load(file)

        for creature in creature_raw:
            if "name" not in creature:
                print(creature)

        return {
            creature["id"]: Creature(
                id=creature["id"],
                name=creature["name"],
                homeworld_id=creature.get("homeworld", None),
                first_appearance=creature.get("first_appearance", None),
                comments=creature.get("comments", ""),
            )
            for creature in creature_raw
        }

    def _load_droids(self) -> Dict[str, Droid]:
        """
        Load the droids from the json file

        Returns:
            Dict[str, Droid]: List of droids
        """
        file = Path(self.data_path, "Pre-scraping", "Droids.json")
        with open(file, "r", encoding="utf-8") as file:
            droid_raw = json.load(file)

        return {
            droid["id"]: Droid(
                id=droid["id"],
                name=droid["name"],
                first_appearance=droid.get("first_appearance", None),
                comments=droid.get("comments", ""),
            )
            for droid in droid_raw
        }

    def _load_facts(self) -> Dict[str, Fact]:
        """
        Load the facts from the json file

        Returns:
            Dict[str, Fact]: List of facts
        """
        file = Path(self.data_path, "Pre-scraping", "Facts.json")
        with open(file, "r", encoding="utf-8") as file:
            fact_raw = json.load(file)

        return {
            fact["id"]: Fact(
                id=fact["id"],
                fact=fact["fact"],
                keywords=fact.get("keywords", []),
                source_id=fact.get("source", None),
            )
            for fact in fact_raw
        }

    def _load_organizations(self) -> Dict[str, Organization]:
        """
        Load the organizations from the json file

        Returns:
            Dict[str, Organization]: List of organizations
        """
        file = Path(self.data_path, "Pre-scraping", "Organizations.json")
        with open(file, "r", encoding="utf-8") as file:
            organization_raw = json.load(file)

        return {
            organization["id"]: Organization(
                id=organization["id"],
                name=organization["name"],
                first_appearance=organization.get("first_appearance", None),
                comments=organization.get("comments", ""),
            )
            for organization in organization_raw
        }

    def _load_planets(self) -> Dict[str, Planet]:
        """
        Load the planets from the json file

        Returns:
            Dict[str, Planet]: List of planets
        """
        file = Path(self.data_path, "Pre-scraping", "Planets.json")
        with open(file, "r", encoding="utf-8") as file:
            planet_raw = json.load(file)

        return {
            planet["id"]: Planet(
                id=planet["id"],
                name=planet["name"],
                region=planet.get("region", None),
                sector=planet.get("sector", None),
                fauna=planet.get("fauna", None),
                system=planet.get("system", None),
                capital_city=planet.get("capital_city", None),
                destinations=planet.get("destinations", []),
                first_appearance=planet.get("first_appearance", None),
                comments=planet.get("comments", ""),
            )
            for planet in planet_raw
        }

    def _load_series(self) -> Dict[str, Serie]:
        """
        Load the series from the json file

        Returns:
            Dict[str, Serie]: List of series
        """
        file = Path(self.data_path, "Pre-scraping", "Serie.json")
        with open(file, "r", encoding="utf-8") as file:
            series_raw = json.load(file)

        return {
            series["id"]: Serie(
                id=series["id"],
                name=series["name"],
                comments=series.get("comments", ""),
            )
            for series in series_raw
        }

    def _load_sources(self) -> Dict[str, Source]:
        """
        Load the sources from the json file

        Returns:
            Dict[str, Source]: List of sources
        """
        file = Path(self.data_path, "Pre-scraping", "Sources.json")
        with open(file, "r", encoding="utf-8") as file:
            source_raw = json.load(file)

        return {
            source["id"]: Source(
                id=source["id"],
                name=source.get("name", None),
                serie_id=source.get("serie", None),
                number=source.get("number", None),
                arc_id=source.get("arc", None),
                era=source.get("era", None),
                source_type=source.get("source_type", None),
                publication_date=source.get("publication_date", None),
                universe_year=source.get("universe_year", None),
                number_pages=source.get("number_pages", None),
                is_done=source.get("is_done", False),
                comments=source.get("comments", ""),
            )
            for source in source_raw
        }

    def _load_species(self) -> Dict[str, Species]:
        """
        Load the species from the json file

        Returns:
            Dict[str, Species]: List of species
        """
        file = Path(self.data_path, "Pre-scraping", "Species.json")
        with open(file, "r", encoding="utf-8") as file:
            species_raw = json.load(file)

        for species in species_raw:
            if "name" not in species:
                print(species)

        return {
            species["id"]: Species(
                id=species["id"],
                name=species["name"],
                homeworld_id=species.get("homeworld", None),
                first_appearance=species.get("first_appearance", None),
                comments=species.get("comments", ""),
            )
            for species in species_raw
        }

    def _load_starship_models(self) -> Dict[str, StarshipModel]:
        """
        Load the starship models from the json file

        Returns:
            Dict[str, StarshipModel]: List of starship models
        """
        file = Path(self.data_path, "Pre-scraping", "StarshipModels.json")
        with open(file, "r", encoding="utf-8") as file:
            starship_model_raw = json.load(file)

        return {
            starship_model["id"]: StarshipModel(
                id=starship_model["id"],
                name=starship_model["name"],
                first_appearance=starship_model.get("first_appearance", None),
                comments=starship_model.get("comments", ""),
            )
            for starship_model in starship_model_raw
        }

    def _load_starships(self) -> Dict[str, Starship]:
        """
        Load the starships from the json file

        Returns:
            Dict[str, Starship]: List of starships
        """
        file = Path(self.data_path, "Pre-scraping", "Starships.json")
        with open(file, "r", encoding="utf-8") as file:
            starship_raw = json.load(file)

        return {
            starship["id"]: Starship(
                id=starship["id"],
                name=starship["name"],
                model_id=starship.get("model", None),
                first_appearance=starship.get("first_appearance", None),
                comments=starship.get("comments", ""),
            )
            for starship in starship_raw
        }

    def _load_varia(self) -> Dict[str, Varia]:
        """
        Load the varias from the json file

        Returns:
            Dict[str, Varia]: List of varias
        """
        file = Path(self.data_path, "Pre-scraping", "Varias.json")
        with open(file, "r", encoding="utf-8") as file:
            varia_raw = json.load(file)

        return {
            varia["id"]: Varia(
                id=varia["id"],
                name=varia["name"],
                first_appearance=varia.get("first_appearance", None),
                comments=varia.get("comments", ""),
            )
            for varia in varia_raw
        }

    def _load_source_artists(self) -> List[SourceArtist]:
        """
        Load the source artists from the json file

        Returns:
            List[SourceArtist]: The list of source artists
        """
        file = Path(self.data_path, "Pre-scraping", "SourceArtists.json")
        with open(file, "r", encoding="utf-8") as file:
            source_artist_raw = json.load(file)

        return [
            SourceArtist(
                id=source_artist["id"],
                source_id=source_artist["source"],
                artist_id=source_artist["artist"],
            )
            for source_artist in source_artist_raw
        ]

    def _load_source_authors(self) -> List[SourceAuthor]:
        """
        Load the source authors from the json file

        Returns:
            List[SourceAuthor]: The list of source authors
        """
        file = Path(self.data_path, "Pre-scraping", "SourceAuthors.json")
        with open(file, "r", encoding="utf-8") as file:
            source_author_raw = json.load(file)

        return [
            SourceAuthor(
                id=source_author["id"],
                source_id=source_author["source"],
                author_id=source_author["artist"],
            )
            for source_author in source_author_raw
        ]

    def _load_source_characters(self) -> List[SourceCharacter]:
        """
        Load the source characters from the json file

        Returns:
            List[SourceCharacter]: The list of source characters
        """
        file = Path(self.data_path, "Pre-scraping", "SourceCharacters.json")
        with open(file, "r", encoding="utf-8") as file:
            source_character_raw = json.load(file)

        return [
            SourceCharacter(
                id=source_character["id"],
                source_id=source_character["source"],
                character_id=source_character["character"],
                appearance=source_character["appearance"],
            )
            for source_character in source_character_raw
        ]

    def _load_source_creatures(self) -> List[SourceCreature]:
        """
        Load the source creatures from the json file

        Returns:
            List[SourceCreature]: The list of source creatures
        """
        file = Path(self.data_path, "Pre-scraping", "SourceCreatures.json")
        with open(file, "r", encoding="utf-8") as file:
            source_creature_raw = json.load(file)

        return [
            SourceCreature(
                id=source_creature["id"],
                source_id=source_creature["source"],
                creature_id=source_creature["creature"],
                appearance=source_creature["appearance"],
            )
            for source_creature in source_creature_raw
        ]

    def _load_source_droids(self) -> List[SourceDroid]:
        """
        Load the source droids from the json file

        Returns:
            List[SourceDroid]: The list of source droids
        """
        file = Path(self.data_path, "Pre-scraping", "SourceDroids.json")
        with open(file, "r", encoding="utf-8") as file:
            source_droid_raw = json.load(file)

        return [
            SourceDroid(
                id=source_droid["id"],
                source_id=source_droid["source"],
                droid_id=source_droid["droid"],
                appearance=source_droid["appearance"],
            )
            for source_droid in source_droid_raw
        ]

    def _load_source_organizations(self) -> List[SourceOrganization]:
        """
        Load the source organizations from the json file

        Returns:
            List[SourceOrganization]: The list of source organizations
        """
        file = Path(self.data_path, "Pre-scraping", "SourceOrganizations.json")
        with open(file, "r", encoding="utf-8") as file:
            source_organization_raw = json.load(file)

        return [
            SourceOrganization(
                id=source_organization["id"],
                source_id=source_organization["source"],
                organization_id=source_organization["organization"],
                appearance=source_organization["appearance"],
            )
            for source_organization in source_organization_raw
        ]

    def _load_source_planets(self) -> List[SourcePlanet]:
        """
        Load the source planets from the json file

        Returns:
            List[SourcePlanet]: The list of source planets
        """
        file = Path(self.data_path, "Pre-scraping", "SourcePlanets.json")
        with open(file, "r", encoding="utf-8") as file:
            source_planet_raw = json.load(file)

        return [
            SourcePlanet(
                id=source_planet["id"],
                source_id=source_planet["source"],
                planet_id=source_planet["planet"],
                appearance=source_planet["appearance"],
            )
            for source_planet in source_planet_raw
        ]

    def _load_source_species(self) -> List[SourceSpecies]:
        """
        Load the source species from the json file

        Returns:
            List[SourceSpecies]: The list of source species
        """
        file = Path(self.data_path, "Pre-scraping", "SourceSpecies.json")
        with open(file, "r", encoding="utf-8") as file:
            source_species_raw = json.load(file)

        return [
            SourceSpecies(
                id=source_species["id"],
                source_id=source_species["source"],
                species_id=source_species["species"],
                appearance=source_species["appearance"],
            )
            for source_species in source_species_raw
        ]

    def _load_source_starships(self) -> List[SourceStarship]:
        """
        Load the source starships from the json file

        Returns:
            List[SourceStarship]: The list of source starships
        """
        file = Path(self.data_path, "Pre-scraping", "SourceStarships.json")
        with open(file, "r", encoding="utf-8") as file:
            source_starship_raw = json.load(file)

        return [
            SourceStarship(
                id=source_starship["id"],
                source_id=source_starship["source"],
                starship_id=source_starship["starship"],
                appearance=source_starship["appearance"],
            )
            for source_starship in source_starship_raw
        ]

    def _load_source_starship_models(self) -> List[SourceStarshipModel]:
        """
        Load the source starship models from the json file

        Returns:
            List[SourceStarshipModel]: The list of source starship models
        """
        file = Path(self.data_path, "Pre-scraping", "SourceStarshipModels.json")
        with open(file, "r", encoding="utf-8") as file:
            source_starship_model_raw = json.load(file)

        return [
            SourceStarshipModel(
                id=source_starship_model["id"],
                source_id=source_starship_model["source"],
                starship_model_id=source_starship_model["starship_model"],
                appearance=source_starship_model["appearance"],
            )
            for source_starship_model in source_starship_model_raw
        ]

    def _load_source_varia(self) -> List[SourceVaria]:
        """
        Load the source varias from the json file

        Returns:
            List[SourceVaria]: The list of source varias
        """
        file = Path(self.data_path, "Pre-scraping", "SourceVarias.json")
        with open(file, "r", encoding="utf-8") as file:
            source_varia_raw = json.load(file)

        return [
            SourceVaria(
                id=source_varia["id"],
                source_id=source_varia["source"],
                varia_id=source_varia["varia"],
                appearance=source_varia["appearance"],
            )
            for source_varia in source_varia_raw
        ]

    def find_planet_id(self, planet_name: str) -> Optional[str]:
        """
        Find the planet id from the planet name

        Args:
            planet_name (str): The planet name

        Returns:
            Optional[str]: The planet id
        """
        for id, value in self.planets.items():
            if value.name == planet_name:
                return id

        return None

    def find_species_id(self, species_name: str) -> Optional[str]:
        """
        Find the species id from the species name

        Args:
            species_name (str): The species name

        Returns:
            Optional[str]: The species id
        """
        for id, value in self.species.items():
            if value.name == species_name:
                return id

        return None

    def find_starship_model_id(self, starship_model_name: str) -> Optional[str]:
        """
        Find the starship model id from the starship model name

        Args:
            starship_model_name (str): The starship model name

        Returns:
            Optional[str]: The starship model id
        """
        for id, value in self.starship_models.items():
            if value.name == starship_model_name:
                return id

        return None
