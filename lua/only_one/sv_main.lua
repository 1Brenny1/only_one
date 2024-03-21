OnlyOne = OnlyOne or {}

gameevent.Listen("player_connect")
hook.Add("player_connect", "OnlyOne.OnConnect", function(data)
    if data.bot == 1 then return end
    local Steam64 = util.SteamIDTo64(data.networkid)
    

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
                        OnlyOne.Debug("Running Command on "..data.name.."("..Steam64..")")
                        game.ConsoleCommand(string.Replace(OnlyOne.Config.Command, "{}", Steam64))
                    else
                        OnlyOne.Debug("Kicking "..data.name.."("..Steam64..")")
                        game.KickID(data.networkid, OnlyOne.Config.KickReason)
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