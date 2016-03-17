if not ulx then
	ulx = {}
	include( "ulx/sh_defines.lua" )
	include( "ulx/cl_lib.lua" )
	include( "ulx/sh_base.lua" )

	local sh_modules = file.Find( "ulx/modules/sh/*.lua", "LUA" )
	local cl_modules = file.Find( "ulx/modules/cl/*.lua", "LUA" )

	for _, file in ipairs( cl_modules ) do
		Msg( "[ULX] Loading CLIENT module: " .. file .. "\n" )
		include( "ulx/modules/cl/" .. file )
	end

	for _, file in ipairs( sh_modules ) do
		Msg( "[ULX] Loading SHARED module: " .. file .. "\n" )
		include( "ulx/modules/sh/" .. file )
	end
end

function ulx.clInit( v, r )
	-- Number conversion to ensure we're not getting an incredibly complex floating number
	ulx.version = tonumber( string.format( "%.2f", v ) ) -- Yah, I know, we should have the version from shared anyways.... but doesn't make sense to send one and not the other.
	ulx.revision = r

	Msg( "ULX version " .. ulx.getVersion() .. " loaded.\n" )
end
usermessage.Hook( "ulx_initplayer", init )

local function notifyAdminsForRepoChange( ply )
	if ply:IsSuperAdmin() then
		timer.Simple( 10, function()
			chat.AddText( "************************************************************")
			chat.AddText( "Hey ", ply, "! ULX has been moved to a different repository!")
			chat.AddText( "Please visit http://ulyssesmod.net/ for more details.")
			chat.AddText( "Update your server as soon as possible!")
			chat.AddText( "************************************************************")
		end)
	end
end
hook.Add( "ULibLocalPlayerReady", "ULXRepoChangeCheck", notifyAdminsForRepoChange, HOOK_MONITOR_HIGH )
ulx.notifyRepoChange = true
