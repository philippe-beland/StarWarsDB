from pydantic import BaseModel, Field, ConfigDict
from typing import List
from pydantic.types import UUID


class Fact(BaseModel):
    """
    Flexible model for processing Fact in database
    """

    id: UUID
    fact: str
    source_id: str
    keywords: List[str] = []

    model_config = ConfigDict(
        populate_by_name=True,  # Allow populating by alias
        extra="allow",  # Allow extra fields not defined in the model
    )

    def __repr__(self):
        return f"{self.fact}"
