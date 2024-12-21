from pydantic import BaseModel, ConfigDict
from pydantic.types import UUID
from typing import Optional

from StarWarsDB.classes.varia import Varia
from StarWarsDB.classes.source import Source


class SourceVaria(BaseModel):
    """
    Flexible model for processing SourceVaria in database
    """

    id: UUID
    source_id: str
    varia_id: str
    appearance: str
    source: Optional[Source] = None
    varia: Optional[Varia] = None

    model_config = ConfigDict(
        populate_by_name=True,  # Allow populating by alias
        extra="allow",  # Allow extra fields not defined in the model
    )
