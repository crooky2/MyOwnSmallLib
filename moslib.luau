local mosl = {}

for _, module in pairs(script.Parent["moclib-f"].src:GetChildren()) do
	if module.Name == "table" then
		mosl.tbl = require(module)
	else
		mosl[module.Name] = require(module)
	end
end

return mosl