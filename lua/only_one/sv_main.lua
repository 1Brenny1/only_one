OnlyOne = OnlyOne or {}


hook.Add("PlayerAuthed", "OnlyOne.OnConnect", function(Plr, SteamId, UniqueId)
    local Steam64 = Plr:SteamID64()

    -- Insert Player Into Current Server
    OnlyOne.SQL.Query("INSERT INTO OnlyOne_"..OnlyOne.Config.Identifier.." (Steam64) VALUES (\""..Steam64.."\")")

    -- Get All Other Servers
    local query = OnlyOne.SQL.RawQuery("SELECT * FROM OnlyOne_Identifiers WHERE Identifier!=\""..OnlyOne.Config.Identifier.."\"")
    
    local detected = false
    function query:onSuccess(data)
        for i, Server in ipairs(data) do
            if detected then break end
            local onlineQuery = OnlyOne.SQL.RawQuery("SELECT * FROM OnlyOne_" .. Server.Identifier .. " WHERE Steam64=\"" .. Steam64 .."\"")
            function onlineQuery:onSuccess(data)
                if #data > 0 then
                    if OnlyOne.Config.UseCommand then
                        OnlyOne.Debug("Running Command on "..Plr:Nick().."("..Steam64..")")
                        game.ConsoleCommand(string.Replace(OnlyOne.Config.Command, "{}", Steam64))
                    else
                        OnlyOne.Debug("Kicking "..Plr:Nick().."("..Steam64..")")
                        Plr:Kick(OnlyOne.Config.KickReason)
                    end
                    
                    detected = true
                end
            end
            onlineQuery:start()
        end
    end
    query:start()
end)

hook.Add("PlayerDisconnected", "OnlyOne.OnDisconnect", function(Plr)
    local Steam64 = Plr:SteamID64()
    OnlyOne.Debug("Removing SteamId " .. Steam64 .. " From " .. OnlyOne.Config.Identifier)
    OnlyOne.SQL.Query("DELETE FROM OnlyOne_"..OnlyOne.Config.Identifier.." WHERE Steam64=\"".. Steam64 .."\"")
end)

hook.Add("ShutDown", "OnlyOne.OnShutdown", function()
    OnlyOne.Debug("Shutting Down...")
    OnlyOne.SQL.Query("DELETE FROM OnlyOne_Identifiers WHERE Identifier=\"" .. OnlyOne.Config.Identifier .."\"")
    OnlyOne.SQL.Query("DROP TABLE IF EXISTS OnlyOne_" .. OnlyOne.Config.Identifier)
end)