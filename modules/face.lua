--- A parsed face, constructed from 3 vertices, and helpers
-- @module face

local face = {}
local face_mt = {}

local function new(v, vt, vn)
	return setmetatable({
		vindices = v,
		vtindices = vt or {},
		vnindices = vn or {}
	}, face_mt)
end

--- Public constructor
-- @tparam {number,...} v Vertex indices of the form {v1, v2, v3}
-- @tparam {number,...} vt Vertex texture indices of the form {vt1, vt2, vt3}
-- @tparam {number,...} vn Vertex normal indices of the form {vn1, vn2, vn3}
function face.new(v, vt, vn)
	assert(type(v) == "table", "new: Argument v should be of type <table>")
	assert(#v == 3, "new: Wavedash does not support faces with greater than three vertices")

	assert(type(v[1]) == "number", "new: Argument v members must be of type <number>")
	assert(type(v[2]) == "number", "new: Argument v members must be of type <number>")
	assert(type(v[3]) == "number", "new: Argument v members must be of type <number>")

	if vt ~= nil then
		assert(type(vt) == "table", "new: Argument vt should be of type <table>")

		for i=1, #vt do
			assert(type(vt[i]) == "number", "new: Argument vt members must be of type <number>")
		end
	end

	if vn ~= nil then
		assert(type(vn) == "table", "new Argument vn should be of type <table>")
	
		for i=1, #vn do
			assert(type(vn[i]) == "number", "new: Argument vn members must be of type <number>")
		end
	end

	return new(v, vt, vn)
end

--- Return a table of vertex indices from a face
-- @tparam face f Face from which to return vertex indices
-- @treturn {number,...} a table of vertex indices
function face.vertices(f)
	return f.vindices
end

--- Return a table of texcoord indices from a face
-- @tparam face f Face from which to return texture coordinate indices
-- @treturn {number,...} a table of texture coordinate indices
function face.texcoords(f)
	return f.texcoords
end

--- Return a table of normal indices from a face
-- @tparam face f Face from which to return vertex normal indices
-- @treturn {number,...} a table of vertex normal indices
function face.normals(f)
	return f.normals
end

face_mt.__index = face

function face_mt.__call(_, v1, v2, v3)
	return face.new(v1, v2, v3)
end

return setmetatable({}, face_mt)

