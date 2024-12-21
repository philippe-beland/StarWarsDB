from pydantic import BaseModel, Field, ConfigDict
from typing import Optional
from pydantic.types import UUID

from StarWarsDB.classes.planet import Planet


class Creature(BaseModel):
    """
    Flexible model for processing Creature in database
    """

    id: UUID
    name: str
    homeworld_id: Optional[str] = None
    homeworld: Optional[Planet] = None
    first_appearance: Optional[str] = None
    comments: Optional[str] = None
    image: Optional[str] = None

    model_config = ConfigDict(
        populate_by_name=True,  # Allow populating by alias
        extra="allow",  # Allow extra fields not defined in the model
    )

    def __repr__(self):
        return f"{self.name}"
