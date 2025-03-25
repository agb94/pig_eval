from typing import Any

from pathlib import Path
import toml

import tbump.config
import tbump.main

import pytest


def test_creates_config(test_repo: Path) -> None:
    import os
    tbump_path = test_repo / "tbump.toml"
    os.remove(tbump_path)
    current_version = "1.2.41-alpha1"

    tbump.main.main(["-C", test_repo, "init", current_version])

    assert tbump_path.exists()
    config = toml.loads(tbump_path.read_text())
    assert config["version"]["current"] == "1.2.41-alpha1"
    first_match = config["file"][0]

    file_content = (test_repo / first_match["src"]).read_text()
    assert current_version in file_content
