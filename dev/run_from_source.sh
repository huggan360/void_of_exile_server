#!/bin/sh
# Runs the dedicated server straight from the game's source (development only:
# unlocked, so dev/tuning/*.json-style files and --test work).
#   GAME=~/Godot/Projects/VoxelRealms dev/run_from_source.sh [--config=<folder>] [--test] [--port=N]
# Config defaults to <game>/server_config (git-ignored there; written on first start).
GAME="${GAME:-$HOME/Godot/Projects/VoxelRealms}"
GODOT="${GODOT:-$HOME/Godot/godot_voxel_editor}"
exec "$GODOT" --headless --path "$GAME" res://scenes/server/dedicated.tscn -- "$@"
