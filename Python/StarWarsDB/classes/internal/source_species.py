from pydantic import BaseModel, ConfigDict
from pydantic.types import UUID
from typing import Optional

from StarWarsDB.classes.species import Species
from StarWarsDB.classes.source import Source


class SourceSpecies(BaseModel):
    """
    Flexible model for processing SourceSpecies in database
    """

    id: UUID
    source_id: str
    species_id: str
    appearance: str
    source: Optional[Source] = None
    species: Optional[Species] = None

    model_config = ConfigDict(
        populate_by_name=True,  # Allow populating by alias
        extra="allow",  # Allow extra fields not defined in the model
    )

    def to_json(self):
        return {
            "id": str(self.id),
            "source_id": self.source_id,
            "species_id": self.species_id,
            "appearance": self.appearance,
        }
