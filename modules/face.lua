--- A parsed face, constructed from 3 vertices, and helpers
-- @module face

local face = {}
local face_mt = {}

local function new(v1, v2, v3)
	return setmetatable({
		v1=v1,
		v2=v2,
		v3=v3
	}, face_mt)
end

--- Public constructor
-- @param table v1 Vertex, texcoord (optional), and normal (optional) indices of the form {v1, vt1, vn1}
-- @param table v2 Vertex, texcoord (optional), and normal (optional) indices of the form {v2, vt2, vn2}
-- @param table v3 Vertex, texcoord (optional), and normal (optional) indices of the form {v3, vt3, vn3}
function face.new(v1, v2, v3)
	assert(type(v1) == "table", "new: Argument v1 must be a table of the form {v1, [vt1], [vn1]}")
	assert(type(v2) == "table", "new: Argument v2 must be a table of the form {v2, [vt2], [vn2]}")
	assert(type(v3) == "table", "new: Argument v3 must be a table of the form {v3, [vt3], [vn3]}")
	
	assert(v1[1], "new: v1 must contain a vertex index")
	assert(v2[1], "new: v2 must contain a vertex index")
	assert(v3[1], "new: v3 must contain a vertex index")

	local idx_types = {"vertex, texture, normal"}
	local vsets = {v1, v2, v3}

	for i=1, #vsets do
		for j=1, #vsets[i] do
			if vsets[i][j] ~= nil then
				assert(type(vsets[i][j]) == "number", "new: All index values must be of type <number>")
			end
		end
	end

	return new(v1, v2, v3)
end


face_mt.__index = face

function face_mt.__call(_, v1, v2, v3)
	return face.new(v1, v2, v3)
end

return setmetatable({}, face_mt)

