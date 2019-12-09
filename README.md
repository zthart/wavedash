# Wavedash :ocean: :fast_forward:

Basic Wavefront Object file parsing in lua, made with :heart: with [LÖVE2D](https://love2d.org) in mind.

```lua
local wavedash = require "wavedash"

-- Parse your object!
teapot = wavedash.object.parse("teapot.obj")
```

## Documentation

Documentation can be found online [here](https://zthart.me/docs/wavedash), or can be generated locally via 
[LDoc](https://stevedonovan.github.io/ldoc/index.html) by running `ldoc -c docs/config.ld -o index .`

## Supported Data & Attributes

The goal of this project is not to be a completely comprehensive .obj file loader/parser, but to provide accessor 
functions to facilitate loading of the vertex/polygon/line data within an .obj file. 

More explicitly, the following data will be prioritized:

| Data             | `.obj` file shorthand | Supported Format | Description |
|------------------|-----------------------|------------------|-------------|
| Geometric Vertex | `v`                   | `v x y z [w]`    | The `x`, `y`, and `z` components of the vertex, and an optional `w` component (the weight), assumed to be 1.0 if not provided|
| Vertex Texture   | `vt`                  | `vt u [v w]`     | A horizontal texture direction `u`, an optional vertical texture direction `v` (default of 0), and an optional depth `w` (default of 0)|
| Vertex Normal    | `vn`                  | `vn i j k`       | A normal vector with components `i`, `j`, and `k` |
| Face Elements    | `f`                   | `f v1[/[vt1][/vn1]] v2[/[vt2][/vn2]] v3[/[vt3][/vn3]] ...`| A face constructed from vertices of index `v1`, `v2`, `...`, with optional texture indices `vt1`, `vt2`, `...``, and optional normal indices `vn1`, `vn2`, `...`|

Notably lacking (for now) are line elements (`l v1 v2 v3 v4 ...`), parameter space vertices (`vp u [w] [v]`), or any 
material support (`.mtl` files). While these may be in the scope for future work on this project, in beginning 
iterations, these data points will be ignored.

## License

This project is Copyright (C) 2019 Zach Hart, and Licensed under the GPLv3. The full text of this license can be found
in LICENSE at the root of this project

