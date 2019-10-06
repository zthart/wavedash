# Wavedash :ocean: :fast_forward:

Basic Wavefront Object file parsing in lua, made with :heart: with [LÖVE2D](https://love2d.org) in mind.

```lua
local wavedash = require "wavedash"

-- Parse your object!
teapot = wavedash.object.parse("teapot.obj")
```

## Supported Data & Attributes

The goal of this project is not to be a completely comprehensive .obj file loader/parser, but to provide accessor 
functions to facilitate loading of the vertex/polygon/line data within an .obj file. 

More explicitly, the following data will be prioritized:

| Data             | `.obj` file shorthand | Supported Format | Description |
|------------------|-----------------------|------------------|-------------|
| Geometric Vertex | `v`                   | `v x y z [w]`    | The `x`, `y`, and `z` components of the vertex, and an optional `w` component (the weight), assumed to be 1.0 if not provided|
| Vertex Texture   | `vt`                  | `vt u [v w]`     | A horizontal texture direction `u`, an optional vertical texture direction `v` (default of 0), and an optional depth `w` (default of 0)|
| Vertex Normal    | `vn`                  | `vn i j k`       | A normal vector with components `i`, `j`, and `k` |
| Face Elements    | `f`                   | `f v1[/[vt1]/vn1] v2[/[vt2]/vn2] v3[/[vt3]/vn3]`| A face constructed from vertices of index `v1`, `v2`, and `v3`, with optional texture indices `vt1`, `vt2`, and `vt3`, and optional normal indices `vn1`, `vn2`, and `vn3`|

Notably lacking (for now) are line elements (`l v1 v2 v3 v4 ...`), parameter space vertices (`vp u [w] [v]`), or any 
material support (`.mtl` files). While these may be in the scope for future work on this project, in beginning 
iterations, these data points will be ignored.

