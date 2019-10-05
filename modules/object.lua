--- A parsed object file and helper functions
-- @module object

local modules = (...):gsub('%.[^%.]+$', '') .. "."
local vertex = require(modules .. "vertex")
local face = require(modules .. "face")
local open = io.open
local lines = io.lines
local object = {}
local object_mt = {}

local function new(vertices, normals, texcoords, faces)
	assert(type(vertices) == "table", "new: Object must be created with vertices")
	return setmetatable({vertices = vertices, 
						 normals = normals or {},
						 texcoords = texcoords or {},
						 faces = faces or {}}, object_mt)
end

--- Public constructor
-- @param string filepath The path to the object file on disk, must end with .obj
function object.parse(filepath)
	assert(filepath, "new: Required filepath argument not provided")
	assert(filepath:sub(-4):lower() == ".obj", "new: File povided was not of the correct type, must have .obj extension")
	local file = assert(open(filepath))


	local datasplit = function(toSplit)
		local out = {}

		local outField, start = 1, 1
		local first, last = toSplit:find(" ", start)

		while first do
			out[outField] = toSplit:sub(start, first-1)
			outField = outField + 1
			start = last + 1
			first, last = toSplit:find(" ", start)
		end

		out[outField] = toSplit:sub(start)

		return out
	end

	-- Create local tables for each of our supported datapoints
	local verts, texcoords, norms, faces = {}, {}, {}, {}

	for line in lines(filepath) do
		if line:len() > 0 and line:sub(1, 1) ~= "#" then
			local data = datasplit(line)

			if data[1] == "v" then
				local vert = vertex.new(tonumber(data[2]), tonumber(data[3]), tonumber(data[4]), tonumber(data[5]))
				verts[#verts+1] = vert
			end
		end
	end

	return new(verts, norms, texcoords, faces)
end

object_mt.__index = object

function object_mt.__call(_, x, y, z, w)
	return object.parse(x, y, z, w)
end

return setmetatable({}, object_mt)

