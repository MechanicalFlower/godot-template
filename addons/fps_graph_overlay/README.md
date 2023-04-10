# godot-fps-graph-overlay

An FPS Graph Overlay for in-game debug purposes.

## Install

1. Copy the content of `addons` into your projects `addons` folder.
2. Enable the plugin in the Project settings.

This plugin will add the FPSGraphOverlay.tscn scene to your projects Autoloads.

## Usage

Press F12 while the game is running to show the overlay.

## Configure

Open res://addons/FPSGraphOverlay.tscn and use the export variables of the root node.

* *Point Interval Seconds*: The interval between FPS measurements. Going to less than 1 second doesn't make a difference because the engine only updates the FPS measurement every second.
* *Points On Screen*: The amount of measurement points that are displayed in the graph.
* *Max FPS*: The FPS value that is the top of the screen.
* *Enable F12 Shortcut*: Whether the F12 shortkey is enabled. To open the overlay yourself, just set it's `visible` property.
