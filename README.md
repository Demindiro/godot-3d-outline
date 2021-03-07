# 3D outline shader(s) for Godot

This repository contains shaders for drawing outlines around objects.

There are currently 3 shaders available. Pick and modify as needed.

Currently all outlines are drawn regardless if they're behind an object or not. I may fix this later.


## How it works

The shaders don't all work exactly the same but the general gist is as follows:

- First, it draws a couple of meshes as plain white on a black background inside a viewport.
- Then, it discards any pixels that are green (in the case of the blur shader, the other two check for a difference in the value of the red channel instead).
- Finally, it blurs the red channel.


## How to use it

The fastest way to get started is to add `res://addons/3d_outline/outline.tscn´ to any scenes where you need an outline. Then, pass the `MeshInstance`s that need an outline to `outline_node`
