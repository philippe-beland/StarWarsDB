from pydantic import BaseModel, ConfigDict
from pydantic.types import UUID
from typing import Optional

from StarWarsDB.classes.character import Character
from StarWarsDB.classes.source import Source


class SourceCharacter(BaseModel):
    """
    Flexible model for processing SourceCharacter in database
    """

    id: UUID
    source_id: str
    character_id: str
    appearance: str
    source: Optional[Source] = None
    character: Optional[Character] = None

    model_config = ConfigDict(
        populate_by_name=True,  # Allow populating by alias
        extra="allow",  # Allow extra fields not defined in the model
    )
