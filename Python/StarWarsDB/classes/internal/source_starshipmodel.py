from pydantic import BaseModel, ConfigDict
from pydantic.types import UUID
from typing import Optional

from StarWarsDB.classes.starship_model import StarshipModel
from StarWarsDB.classes.source import Source


class SourceStarshipModel(BaseModel):
    """
    Flexible model for processing SourceStarshipModel in database
    """

    id: UUID
    source_id: str
    starship_model_id: str
    appearance: str
    source: Optional[Source] = None
    starship_model: Optional[StarshipModel] = None

    model_config = ConfigDict(
        populate_by_name=True,  # Allow populating by alias
        extra="allow",  # Allow extra fields not defined in the model
    )

    def to_json(self):
        return {
            "id": str(self.id),
            "source_id": self.source_id,
            "starship_model_id": self.starship_model_id,
            "appearance": self.appearance,
        }
