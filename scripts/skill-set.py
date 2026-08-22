#!/usr/bin/env python3
"""Derive the repository's discovered, active, and published Skill sets.

The publication registry is the lifecycle authority, while the filesystem is
the discovery fact.  A published set is valid only when those two sets agree.
This small helper is intentionally shared by validation, deployment, and the
npx smoke test so they cannot silently drift into three different registries.
"""

from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path

import yaml


NAME_PATTERN = re.compile(r"^[a-z0-9]+(?:-[a-z0-9]+)*$")
VALID_STATUSES = {"active", "candidate", "deprecated", "archived"}


def load_sets(root: Path) -> tuple[list[str], list[str]]:
    skills_root = root / "skills"
    registry_path = skills_root / "registry.yaml"
    discovered = sorted(
        path.parent.name for path in skills_root.glob("*/SKILL.md")
    )
    if not registry_path.exists():
        raise ValueError(f"missing publication registry: {registry_path}")
    try:
        registry = yaml.safe_load(registry_path.read_text(encoding="utf-8")) or {}
    except yaml.YAMLError as exc:
        raise ValueError(f"invalid publication registry: {exc}") from exc
    if registry.get("schema_version") != "1":
        raise ValueError("skills/registry.yaml must declare schema_version 1")
    entries = registry.get("skills")
    if not isinstance(entries, list):
        raise ValueError("skills/registry.yaml: skills must be a list")

    names: set[str] = set()
    active: list[str] = []
    for entry in entries:
        if not isinstance(entry, dict):
            raise ValueError("skills/registry.yaml: every entry must be a mapping")
        name = entry.get("name")
        if not isinstance(name, str) or not NAME_PATTERN.fullmatch(name):
            raise ValueError(f"skills/registry.yaml: invalid Skill name {name!r}")
        if name in names:
            raise ValueError(f"skills/registry.yaml: duplicate Skill name {name}")
        names.add(name)
        status = entry.get("status")
        if status not in VALID_STATUSES:
            raise ValueError(f"skills/registry.yaml: invalid status for {name}: {status!r}")
        if status == "active":
            active.append(name)

    active.sort()
    if sorted(discovered) != active:
        raise ValueError(
            "discovered Skill set does not equal active registry Skill set: "
            f"discovered={sorted(discovered)!r}, active={active!r}"
        )
    return sorted(discovered), active


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--root",
        type=Path,
        default=Path(__file__).resolve().parents[1],
        help="repository root (defaults to the parent of scripts/)",
    )
    parser.add_argument(
        "--mode",
        choices=("discovered", "active", "published"),
        required=True,
    )
    args = parser.parse_args()
    try:
        discovered, active = load_sets(args.root.resolve())
    except (OSError, ValueError, yaml.YAMLError) as exc:
        print(f"ERROR: {exc}", file=sys.stderr)
        return 1
    values = {
        "discovered": discovered,
        "active": active,
        "published": active,
    }[args.mode]
    print("\n".join(values))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
