--- Texture coordinate representation, and helpers
-- @module texcoord


local texcoord = {}
local texcoord_mt = {}

--- Private constructor
local function new(u, v, w)
	return setmetatable({
		u=u,
		v=v or 0,
		w=w or 0}, texcoord_mt)
end

--- Public constructor
-- @param u U must be one of the following: </br>
-- number U component representing the horizontal texture direction </br>
-- table U of {u, v, w} or {u=u, v=v, w=w}
-- @tparam number v V component representing vertical texture direction - optional (default 0)
-- @tparam number w W component representing depth of the texture - optional (default 0)
function texcoord.new(u, v, w)
	if type(u) == "number" then
		if v then
			assert(type(v) == "number", "new: Argument v must be of type <number>")
		end
		if w then
			assert(type(w) == "number", "new: Argument w must be of type <number>")
		end

		return new(u, v, w)
	else
		assert(type(u) == "table", "new: Invalid argument type (expected <number> or <table>)")

		local uu, vv, ww = u.u or u[1], u.v or u[2], u.w or u[3]

		assert(type(uu) == "number", "new: Argument u must be of type <number>")
		if vv ~= nil then
			assert(type(vv) == "number", "new: Argument v must be of type <number>")
		end

		if ww ~= nil then
			assert(type(ww) == "number", "new: Argument w must be of type <number>")
		end

		return new(uu, vv, ww)
	end
end

--- Unpack a texcoord into its component elements
-- @tparam texcoord vt Texture Coordinate to unpack
-- @treturn number u
-- @treturn number v
-- @treturn number w
function texcoord.unpack(vt)
	return vt.u, vt.v, vt.w
end

--- Return a formatted texture coordinate
-- @tparam texcoord vt Texture coordinate to be turned into a string
-- @treturn string formatted
function texcoord.to_string(vt)
	return string.format("vt: {%+0.3f, [%+0.3f, %+0.3f]}", vt.u, vt.v, vt.w)
end

texcoord_mt.__index = texcoord
texcoord_mt.__tostring = texcoord.to_string

function texcoord_mt.__call(_, u, v, w)
	return texcoord.new(u, v, w)
end

return setmetatable({}, texcoord_mt)
