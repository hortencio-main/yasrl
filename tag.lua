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

--[[


	decimal to unary:

		/9/8./
		/8/7./
		/7/6./
		/6/5./
		/5/4./
		/4/3./
		/3/2./
		/2/1./
		/1/0./
		/.0/9./
		/0//
		
		
	passing through unary:

		/$ ./.$/
		/$./.$/ 
		/.$ /. $ /
		
		
	sum:
		/.. $ +/. $ +./ 
		/.. . $ +/. . $ +./
		/. . $ +/$ ../ 
		
	mul:

	/. . $ + /$ + ./
	|$ 2|2 $|
	|$ 3|3 $|
	|2 3 $ +|5 $|
	|||


	/111/0/ /110/1/ /101/1/ /100/0/ /011/1/ /010/1/ /001/1/ /000/0/

	logic gates:
	
	/A/1/
	/B/1/
	/C/1/
	/x00/0/
	/x01/1/
	/x10/1/
	/x11/0/
	/a00/0/
	/a01/0/
	/a10/0/
	/a11/1/
	/o00/0/
	/o01/1/
	/o10/1/
	/o11/1/
	
	decimal to unary converter:
	/9/8*/
	/8/7*/
	/7/6*/
	/6/5*/
	/5/4*/
	/4/3*/
	/3/2*/
	/2/1*/
	/1/0*/
	/*0/9*/
	/0//

	binary to unary converter:
	/1/0*/
	/*0/0**/
	/0// 
]]--

