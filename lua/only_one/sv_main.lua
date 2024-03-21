OnlyOne = OnlyOne or {}

gameevent.Listen("player_connect")
hook.Add("player_connect", "OnlyOne.OnConnect", function(data)
    if not OnlyOne.ENABLED then return end -- Don't run if disabled
    if data.bot == 1 then return end -- Don't run check if the user is a bot

    local Steam64 = util.SteamIDTo64(data.networkid)

    -- Get All Active Servers
    local query = OnlyOne.SQL.RawQuery("SELECT * FROM OnlyOne_Identifiers")
    
    -- Check if user is online on any of the active servers
    local detected = false
    function query:onSuccess(data)
        for i, Server in ipairs(data) do
            if detected then break end -- Don't Run checks if they are online

            -- Run Online Check
            local checkQuery = OnlyOne.SQL.RawQuery("SELECT * FROM OnlyOne_" .. Server.Identifier .. " WHERE Steam64=\"" .. Steam64 .."\"")
            function checkQuery:onSuccess(data)
                if #data > 0 then
                    detected = true
                end
            end
            checkQuery:start()
        end
    end
    query:start()
    
    if detected then -- If the player is online
        if OnlyOne.Config.UseCommand then
            OnlyOne.Debug("Running Command on "..data.name.."("..Steam64..")")
            game.ConsoleCommand(string.Replace(OnlyOne.Config.Command, "{}", Steam64))
        else
            OnlyOne.Debug("Kicking "..data.name.."("..Steam64..")")
            game.KickID(data.networkid, OnlyOne.Config.KickReason)
        end

        return
    end

    -- Mark the player as online in the current server
    OnlyOne.SQL.Query("INSERT INTO OnlyOne_"..OnlyOne.Config.Identifier.." (Steam64) VALUES (\""..Steam64.."\")")
end)

hook.Add("PlayerDisconnected", "OnlyOne.OnDisconnect", function(Plr)
    if not OnlyOne.ENABLED then return end -- Don't run if disabled
    
    local Steam64 = Plr:SteamID64()
    local function removeId()
        OnlyOne.Debug("Removing SteamId " .. Steam64 .. " From " .. OnlyOne.Config.Identifier)
        OnlyOne.SQL.Query("DELETE FROM OnlyOne_"..OnlyOne.Config.Identifier.." WHERE Steam64=\"".. Steam64 .."\"")
    end
    timer.Simple(OnlyOne.Config.RelogDelay, removeId)
end)

hook.Add("ShutDown", "OnlyOne.OnShutdown", function()
    OnlyOne.Debug("Shutting Down...")
    OnlyOne.SQL.Query("DELETE FROM OnlyOne_Identifiers WHERE Identifier=\"" .. OnlyOne.Config.Identifier .."\"")
    OnlyOne.SQL.Query("DROP TABLE IF EXISTS OnlyOne_" .. OnlyOne.Config.Identifier)
end)