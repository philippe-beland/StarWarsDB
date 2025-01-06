from pydantic import BaseModel, Field, ConfigDict
from typing import Optional
from pydantic.types import UUID


class Artist(BaseModel):
    """
    Flexible model for processing Artist in database
    """

    id: UUID
    name: str
    comments: Optional[str] = None
    image: Optional[None] = None

    model_config = ConfigDict(
        populate_by_name=True,  # Allow populating by alias
        extra="allow",  # Allow extra fields not defined in the model
    )

    def __repr__(self):
        return f"{self.name}"
