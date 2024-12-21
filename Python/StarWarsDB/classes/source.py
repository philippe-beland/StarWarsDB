from pydantic import BaseModel, Field, ConfigDict
from typing import List, Optional
from pydantic.types import UUID

from StarWarsDB.classes.arc import Arc
from StarWarsDB.classes.serie import Serie
from StarWarsDB.classes.artist import Artist
from StarWarsDB.classes.character import Character
from StarWarsDB.classes.creature import Creature
from StarWarsDB.classes.droid import Droid
from StarWarsDB.classes.organization import Organization
from StarWarsDB.classes.planet import Planet
from StarWarsDB.classes.species import Species
from StarWarsDB.classes.starship import Starship
from StarWarsDB.classes.starship_model import StarshipModel
from StarWarsDB.classes.varia import Varia


class Source(BaseModel):
    """
    Flexible model for processing Source in database
    """

    id: UUID
    name: Optional[str] = None
    serie_id: Optional[str] = None
    serie: Optional[Serie] = None
    number: Optional[int] = None
    arc_id: Optional[str] = None
    arc: Optional[Arc] = None
    era: Optional[str] = None
    source_type: Optional[str] = None
    publication_date: Optional[int] = None
    universe_year: Optional[str] = None
    number_pages: Optional[int] = None
    is_done: bool
    comments: Optional[str] = None
    image: Optional[str] = None

    authors: List[Artist] = []
    artists: List[Artist] = []
    characters: List[dict] = []
    creatures: List[dict] = []
    droids: List[dict] = []
    organizations: List[dict] = []
    planets: List[dict] = []
    species: List[dict] = []
    starships: List[dict] = []
    starship_models: List[dict] = []
    varias: List[dict] = []

    model_config = ConfigDict(
        populate_by_name=True,  # Allow populating by alias
        extra="allow",  # Allow extra fields not defined in the model
    )

    def __repr__(self):
        return f"{self.name}"
