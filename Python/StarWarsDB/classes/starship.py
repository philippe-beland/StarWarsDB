from pydantic import BaseModel, Field, ConfigDict
from typing import Optional
from pydantic.types import UUID
from StarWarsDB.classes.starship_model import StarshipModel


class Starship(BaseModel):
    """
    Flexible model for processing Starship in database
    """

    id: UUID
    name: str
    model_id: Optional[str] = None
    model: Optional[StarshipModel] = None
    first_appearance: Optional[str] = None
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
            "model_id": self.model_id,
            "first_appearance": self.first_appearance,
            "comments": self.comments,
            "image": self.image,
        }
