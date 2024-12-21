from pydantic import BaseModel, ConfigDict
from pydantic.types import UUID
from typing import Optional

from StarWarsDB.classes.artist import Artist
from StarWarsDB.classes.source import Source


class SourceAuthor(BaseModel):
    """
    Flexible model for processing SourceAuthor in database
    """

    id: UUID
    source_id: str
    author_id: str
    source: Optional[Source] = None
    author: Optional[Artist] = None

    model_config = ConfigDict(
        populate_by_name=True,  # Allow populating by alias
        extra="allow",  # Allow extra fields not defined in the model
    )
