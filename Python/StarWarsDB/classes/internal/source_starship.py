from pydantic import BaseModel, ConfigDict
from pydantic.types import UUID
from typing import Optional

from StarWarsDB.classes.starship import Starship
from StarWarsDB.classes.source import Source


class SourceStarship(BaseModel):
    """
    Flexible model for processing SourceStarship in database
    """

    id: UUID
    source_id: str
    starship_id: str
    appearance: str
    source: Optional[Source] = None
    starship: Optional[Starship] = None

    model_config = ConfigDict(
        populate_by_name=True,  # Allow populating by alias
        extra="allow",  # Allow extra fields not defined in the model
    )
