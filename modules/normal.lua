--- A parsed normal vector (not guaranteed to be normalized), plus helpers
-- @module normal

local normal = {}
local normal_mt = {}

--- Private constructor
local function new(i, j, k)
	return setmetatable({
		i=i,
		j=j,
		k=k}, normal_mt)
end

--- Public constructor
-- @param i I must be one of the following: </br>
-- number I component of the normal vector </br>
-- table I of the form {i, j, k} or {i=i, j=j, k=k}
-- @tparam number j J component of the normal vector
-- @tparam number k K component of the normal vector
--
-- This vector is not guaranteed to be normalized according to the .obj standard
function normal.new(i, j, k)
	if i and j and k then
		assert(type(i) == "number", "new: Argument i must be of type <number>")
		assert(type(j) == "number", "new: Argument j must be of type <number>")
		assert(type(k) == "number", "new: Argument k must be of type <number>")

		return new(i, j, k)
	else
		assert(type(i) == "table", "new: Invalid argument type (expected <number> or <table>)")

		local ii, jj, kk = i.i or i[1], i.j or i[2], i.k or i[3]

		assert(type(ii) == "number", "new: Argument i must be of type <number>")
		assert(type(jj) == "number", "new: Argument j must be of type <number>")
		assert(type(kk) == "number", "new: Argument k must be of type <number>")

		return new(ii, jj, kk)
	end
end

--- Unpack a normal into its component elements
-- @tparam normal vn Vertex normal to unpack
-- @treturn number i
-- @treturn number j
-- @treturn number k
function normal.unpack(vn)
	return vn.i, vn.j, vn.k
end

--- Return a formatted vertex normal
-- @tparam normal vn Vertex normal to format
-- @return string formatted
function normal.to_string(vn)
	return string.format("vn: {%+0.3f, %+0.3f, %+0.3f}", vn.i, vn.j, vn.k)
end

normal_mt.__index = normal
normal_mt.__tostring = normal.to_string

function normal_mt.__call(_, i, j, k)
	return normal.new(i, j, k)
end

return setmetatable({}, normal_mt)

