function escape(s)
    return (s:gsub("([%^%$%(%)%%%.%[%]%*%+%-%?])", "%%%1"))
end

local file = io.open(arg[1], "r")
if not file then
    print("Usage: lua tag.lua <filename>")
    os.exit(1)
end
local s = file:read("*a")
file:close()

local ruleset = {}
for pattern, replacement in s:gmatch("/([^/]+)/([^/]*)/") do
	table.insert(ruleset, pattern)
	table.insert(ruleset, replacement)
end

exit_condition = s:match("\\%s*(.-)%s*\\")
s = s:gsub("\\%s*(.-)%s*\\", "")

s = s:gsub("/([^/]+)/([^/]*)/", ""):gsub("\n", ""):gsub("\t","")

local b = ""
repeat
	b = s
	for l1 = 1, #ruleset, 2 do
		repeat
			s = string.gsub(s, escape(ruleset[l1]), ruleset[l1+1])
		until string.find(s, ruleset[l1]) == nil
	end
	--~ if string.sub(s,2,2) == "$" then
		print(s)
	--~ end
until (string.find(s, exit_condition)) or (b == s)
