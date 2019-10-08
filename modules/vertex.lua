--- A parsed vertex, representing a point in object space, and helpers
-- @module vertex

local vertex = {}
local vertex_mt = {}

--- Private constructor
local function new(x, y, z, w)
	return setmetatable({
		x = x,
		y = y,
		z = z,
		w = w or 1.0}, vertex_mt)
end

--- Public constructor for vertex
-- @param x X can be one of three values: </br>
-- number X coordinate </br>
-- table {x, y, z} or {x=x, y=y, z=z} </br>
-- table with optional weight w {x, y, z, w} or {x=x, y=y, z=z, w=w}
-- @tparam number y Y coordinate - optional if x provided as a table
-- @tparam number z Z coordinate - optional if x provided as a table
-- @tparam number w Weight value - optional (default 1.0)
function vertex.new(x, y, z, w)
	if x and y and z then
		assert(type(x) == "number", "new: Argument x must be of type <number>")
		assert(type(y) == "number", "new: Arugment y must be of type <number>")
		assert(type(z) == "number", "new: Argument z must be of type <number>")
		
		if w then
			assert(type(w) == "number", "new: Argument w must be of type <number>")

			return new(x, y, z, w)
		end

		return new (x, y, z)
	
	else
		assert(type(x) == "table", "new: Invalid argument type (expected <number> or <table>)")

		local xx, yy, zz, ww = x.x or x[1], x.y or x[2], x.z or x[3], x.w or x[4]
		assert(type(xx) == "number", "new: Argument x must be of type <number>")
		assert(type(yy) == "number", "new: Argument y must be of type <number>")
		assert(type(zz) == "number", "new: Argument z must be of type <number>")

		if ww ~= nil then
			assert(type(ww) == "number", "new: Argument w must be of type <number>")

			return new(xx, yy, zz, ww)
		end

		return new(xx, yy, zz)
	end
end

--- Unpack a vertex into its component elements
-- @tparam vertex v Vertex to unpack
-- @treturn number x
-- @treturn number y
-- @treturn number z
-- @treturn number w
function vertex.unpack(v)
	return v.x, v.y, v.z, v.w
end

--- String representation of a vertex
-- @tparam vertex v Vertex to format
-- @treturn string formatted
function vertex.to_string(v)
	return string.format("v: {%+0.3f, %+0.3f, %+0.3f, [%+0.3f]}", v.x, v.y, v.z, v.w)
end

vertex_mt.__index = vertex
vertex_mt.__tostring = vertex.to_string

function vertex_mt.__call(_, x, y, z, w)
	return vertex.new(x, y, z, w)
end

return setmetatable({}, vertex_mt)

