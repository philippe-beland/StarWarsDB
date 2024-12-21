from pydantic import BaseModel, ConfigDict
from pydantic.types import UUID
from typing import Optional

from StarWarsDB.classes.creature import Creature
from StarWarsDB.classes.source import Source


class SourceCreature(BaseModel):
    """
    Flexible model for processing SourceCreature in database
    """

    id: UUID
    source_id: str
    creature_id: str
    appearance: str
    source: Optional[Source] = None
    creature: Optional[Creature] = None

    model_config = ConfigDict(
        populate_by_name=True,  # Allow populating by alias
        extra="allow",  # Allow extra fields not defined in the model
    )
