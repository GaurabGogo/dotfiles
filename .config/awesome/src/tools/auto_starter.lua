local awful = require("awful")
local rules = require("awful.rules")

return function(table)
  for _, t in ipairs(table) do
        awful.spawn(app)
  end
  
  	  -- Set a rule for Spotify to move it to workspace 9
	  rules.rules = {
	    {
	      rule = { class = "Spotify" },
	      properties = { tag = "9" }
	    },
	     {
	      rule = { class = "thunderbird-esr" },
	      properties = { tag = "8" }
	    },
	 
		
		    {
			rule = { class = "copyq" },
			properties = { floating = true }
		    },
		
	
	  }
	  
	awful.spawn.with_shell("~/.config/awesome/user/autostart.sh")
end
