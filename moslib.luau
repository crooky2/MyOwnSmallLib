local moslib = {}

for _, module in pairs(script.Parent.src:GetChildren()) do
	if module.Name == "table" then
		moslib.tbl = require(module)
	else
		moslib[module.Name] = require(module)
	end
end

return moslib