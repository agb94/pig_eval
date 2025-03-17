
import pytest

from config import settings

from pathlib import Path

assert settings.PROJECT_ROOT == Path("/root/repos/web")
assert settings.MEDIA_ROOT == Path("/root/repos/web/media")
assert settings.STATIC_ROOT == Path("/root/repos/web/static")