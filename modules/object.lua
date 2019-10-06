--- A parsed object file and helper functions
-- @module object

local modules = (...):gsub('%.[^%.]+$', '') .. "."
local vertex = require(modules .. "vertex")
local normal = require(modules .. "normal")
local texcoord = require(modules .. "texcoord")
local face = require(modules .. "face")
local open = io.open
local lines = io.lines
local object = {}
local object_mt = {}

--- Private constructor
local function new(vertices, normals, texcoords, faces, unsupported)
	assert(type(vertices) == "table", "new: Object must be created with vertices")
	return setmetatable({
		vertices = vertices, 
		normals = normals,
		texcoords = texcoords,
		faceset = faces,
		unsupported = unsupported
	}, object_mt)
end

--- Public constructor
-- @param string filepath The path to the object file on disk, must end with .obj
function object.parse(filepath)
	assert(filepath, "new: Required filepath argument not provided")
	assert(filepath:sub(-4):lower() == ".obj", "new: File povided was not of the correct type, must have .obj extension")
	local file = assert(open(filepath))


	local datasplit = function(toSplit, on)
		assert(on ~= "", "datasplit: Cannot split on an empty string")
		local out = {}

		local outField, start = 1, 1
		local first, last = toSplit:find(on, start)

		while first do
			out[outField] = toSplit:sub(start, first-1)
			outField = outField + 1
			start = last + 1
			first, last = toSplit:find(on, start)
		end

		out[outField] = toSplit:sub(start)

		return out
	end

	-- Create local tables for each of our supported datapoints
	local verts, texcoords, norms, faces = {}, {}, {}, {}
	local found_unsupported = false

	for line in lines(filepath) do
		if line:len() > 0 and line:sub(1, 1) ~= "#" then
			local data = datasplit(line, " ")

			if data[1] == "v" then
				local vert = vertex.new(tonumber(data[2]), tonumber(data[3]), tonumber(data[4]), tonumber(data[5]))
				verts[#verts+1] = vert
			elseif data[1] == "vn" then
				local norm = normal.new(tonumber(data[2]), tonumber(data[3]), tonumber(data[4]))
				norms[#norms+1] = norm
			elseif data[1] == "vt" then
				local tex = texcoord.new(tonumber(data[2]), tonumber(data[3]), tonumber(data[4]))
				texcoords[#texcoords+1] = tex
			elseif data[1] == "f" then
				local vsets = {}
				for i=2, #data do
					local sface = datasplit(data[i], "/")
					vsets[i-1] = {tonumber(sface[1]), tonumber(sface[2]), tonumber(sface[3])}
				end
				faces[#faces+1] = face.new(vsets[1], vsets[2], vsets[3])
			else
				found_unsupported = true
			end
		end
	end

	return new(verts, norms, texcoords, faces, found_unsupported)
end

--- Iterator for faces
-- @tparam object obj Object over which to iterate
-- @treturn verts Component vertices
-- @treturn texcoords Component texcoords
-- @treturn norms Component normals
function object.faces(obj)
	local face = 1
	return function()
		while face <= #obj.faceset do
			local verts = {}
			local texcoords = {}
			local norms = {}

			for _, vset in ipairs(obj.faceset[face]) do
				verts[#verts+1] = obj.vertices[vset[1]]
				if vset[2] ~= nil then
					texcoords[#texcoords+1] = obj.texcoords[vset[2]]
				end
				if vset[3] ~= nil then
					norms[#norms+1] = obj.normals[vset[3]]
				end
			end
			face = face + 1
			return verts, texcoords, norms
		end
		return nil
	end
end

object_mt.__index = object

function object_mt.__call(_, x, y, z, w)
	return object.parse(x, y, z, w)
end

return setmetatable({}, object_mt)

