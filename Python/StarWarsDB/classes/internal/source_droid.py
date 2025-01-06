from pydantic import BaseModel, ConfigDict
from pydantic.types import UUID
from typing import Optional

from StarWarsDB.classes.droid import Droid
from StarWarsDB.classes.source import Source


class SourceDroid(BaseModel):
    """
    Flexible model for processing SourceDroid in database
    """

    id: UUID
    source_id: str
    droid_id: str
    appearance: str
    source: Optional[Source] = None
    droid: Optional[Droid] = None

    model_config = ConfigDict(
        populate_by_name=True,  # Allow populating by alias
        extra="allow",  # Allow extra fields not defined in the model
    )
