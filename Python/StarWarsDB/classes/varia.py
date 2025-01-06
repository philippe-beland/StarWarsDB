from pydantic import BaseModel, Field, ConfigDict
from typing import Optional
from pydantic.types import UUID


class Varia(BaseModel):
    """
    Flexible model for processing Varia in database
    """

    id: UUID
    name: str
    comments: Optional[str] = None
    first_appearance: Optional[str] = None
    image: Optional[str] = None

    model_config = ConfigDict(
        populate_by_name=True,  # Allow populating by alias
        extra="allow",  # Allow extra fields not defined in the model
    )

    def __repr__(self):
        return f"{self.name}"
