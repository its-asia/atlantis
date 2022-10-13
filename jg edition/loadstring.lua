-- atlantis jg edition loadstring
-- very cool naruto!

local url = 'https://raw.githubusercontent.com/its-asia/atlantis/main/jg%20edition/source.lua'
local str = game:HttpGetAsync(url, true)

local exe = loadstring(str)
  
_G.AutoFocus = true --[[ whether or not pressing slash will autofocus custom chatbar ]]; exe()
