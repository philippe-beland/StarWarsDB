from pydantic import BaseModel, ConfigDict
from pydantic.types import UUID
from typing import Optional

from StarWarsDB.classes.artist import Artist
from StarWarsDB.classes.source import Source


class SourceArtist(BaseModel):
    """
    Flexible model for processing SourceArtist in database
    """

    id: UUID
    source_id: str
    artist_id: str
    source: Optional[Source] = None
    artist: Optional[Artist] = None

    model_config = ConfigDict(
        populate_by_name=True,  # Allow populating by alias
        extra="allow",  # Allow extra fields not defined in the model
    )
