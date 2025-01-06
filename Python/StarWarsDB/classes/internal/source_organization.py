from pydantic import BaseModel, ConfigDict
from pydantic.types import UUID
from typing import Optional

from StarWarsDB.classes.organization import Organization
from StarWarsDB.classes.source import Source


class SourceOrganization(BaseModel):
    """
    Flexible model for processing SourceOrganization in database
    """

    id: UUID
    source_id: str
    organization_id: str
    appearance: str
    source: Optional[Source] = None
    organization: Optional[Organization] = None

    model_config = ConfigDict(
        populate_by_name=True,  # Allow populating by alias
        extra="allow",  # Allow extra fields not defined in the model
    )
