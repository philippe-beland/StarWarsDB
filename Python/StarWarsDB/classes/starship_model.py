from pydantic import BaseModel, Field, ConfigDict
from typing import Optional
from pydantic.types import UUID


class StarshipModel(BaseModel):
    """
    Flexible model for processing StarshipModel in database
    """

    id: UUID
    name: str
    class_type: Optional[str] = None
    line: Optional[str] = None
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
            "class_type": self.class_type,
            "line": self.line,
            "first_appearance": self.first_appearance,
            "comments": self.comments,
        }
