local tbl = {}

function tbl.deepCopy(original)
	local function isSequence(tbl)
		local count = 0
		local maxIndex = 0

		for key in pairs(tbl) do
			if type(key) ~= "number" or key % 1 ~= 0 or key < 1 then
				return false, 0
			end

			count += 1
			if key > maxIndex then
				maxIndex = key
			end
		end

		return count == maxIndex, count
	end

	local function deepCopyInternal(value, seen)
		if type(value) ~= "table" then
			return value
		end

		local existing = seen[value]
		if existing then
			return existing
		end

		local isArray, length = isSequence(value)
		local copy = isArray and table.create(length) or {}
		seen[value] = copy

		if isArray then
			for i = 1, length do
				copy[i] = deepCopyInternal(value[i], seen)
			end
		else
			for key, item in pairs(value) do
				local newKey = type(key) == "table"
					and deepCopyInternal(key, seen)
					or key

				copy[newKey] = deepCopyInternal(item, seen)
			end
		end

		return copy
	end

	return deepCopyInternal(original, {})
end

function tbl.count(tbl)
	local count = 0
	for _ in pairs(tbl) do
		count += 1
	end
	return count
end

return tbl
