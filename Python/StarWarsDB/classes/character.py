from pydantic import BaseModel, Field, ConfigDict
from typing import List, Optional
from pydantic.types import UUID

from StarWarsDB.classes.organization import Organization
from StarWarsDB.classes.planet import Planet
from StarWarsDB.classes.species import Species


class Character(BaseModel):
    """
    Flexible model for processing Arc in database
    """

    id: UUID
    name: str
    aliases: List[str] = []
    species_id: Optional[str] = None
    species: Optional[Species] = None
    homeworld_id: Optional[str] = None
    homeworld: Optional[Planet] = None
    sex: Optional[str] = None
    affiliations_id: List[str] = []
    affiliations: List[Organization] = []
    first_appearance: Optional[str] = None
    is_scrapped: bool = False
    comments: Optional[str] = None
    image: Optional[str] = None

    model_config = ConfigDict(
        populate_by_name=True,  # Allow populating by alias
        extra="allow",  # Allow extra fields not defined in the model
    )

    def __repr__(self):
        return f"{self.name}"

    def to_json(self):
        return {
            "id": str(self.id),
            "name": self.name,
            "aliases": self.aliases,
            "species": self.species,
            "homeworld": self.homeworld,
            "sex": self.sex,
            "affiliations_id": self.affiliations_id,
            "first_appearance": self.first_appearance,
            "is_scrapped": self.is_scrapped,
            "comments": self.comments,
        }
