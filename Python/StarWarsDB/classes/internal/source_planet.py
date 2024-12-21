from pydantic import BaseModel, ConfigDict
from pydantic.types import UUID
from typing import Optional

from StarWarsDB.classes.planet import Planet
from StarWarsDB.classes.source import Source


class SourcePlanet(BaseModel):
    """
    Flexible model for processing SourcePlanet in database
    """

    id: UUID
    source_id: str
    planet_id: str
    appearance: str
    source: Optional[Source] = None
    planet: Optional[Planet] = None

    model_config = ConfigDict(
        populate_by_name=True,  # Allow populating by alias
        extra="allow",  # Allow extra fields not defined in the model
    )
