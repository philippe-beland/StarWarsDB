from pydantic import BaseModel, Field, ConfigDict
from typing import List, Optional
from pydantic.types import UUID


class Planet(BaseModel):
    """
    Flexible model for processing Planet in database
    """

    id: UUID
    name: str
    region: Optional[str] = None
    sector: Optional[str] = None
    fauna: Optional[str] = None
    system: Optional[str] = None
    capital_city: Optional[str] = None
    destinations: List[str] = []
    first_appearance: Optional[str] = None
    comments: Optional[str] = None
    image: Optional[str] = None

    model_config = ConfigDict(
        populate_by_name=True,  # Allow populating by alias
        extra="allow",  # Allow extra fields not defined in the model
    )

    def __repr__(self):
        return f"{self.name}"
