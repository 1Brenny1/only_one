OnlyOne = OnlyOne or {}


hook.Add("PlayerAuthed", "OnlyOne.OnConnect", function(Plr, SteamId, UniqueId)
    local Steam64 = Plr:SteamID64()

    -- Insert Player Into Current Server
    OnlyOne.SQL.Query("INSERT INTO OnlyOne_"..OnlyOne.Config.Identifier.." (Steam64) VALUES (\""..Steam64.."\")")

    -- Get All Other Servers
    local query = OnlyOne.SQL.RawQuery("SELECT * FROM OnlyOne_Identifiers WHERE Identifier!=\""..OnlyOne.Config.Identifier.."\"")
    
    function query:onSuccess(data)
        for i, Server in ipairs(data) do
            local onlineQuery = OnlyOne.SQL.RawQuery("SELECT * FROM OnlyOne_" .. Server.Identifier .. " WHERE Steam64=\"" .. Steam64 .."\"")
            function onlineQuery:onSuccess(data)
                if #data > 0 then
                    if OnlyOne.Config.UseCommand then
                        game.ConsoleCommand(string.Replace(OnlyOne.Config.Command, "{}", Steam64))
                    else
                        Plr:Kick(OnlyOne.Config.KickReason)
                    end
                end
            end
            onlineQuery:start()
        end
    end
    query:start()
end)

hook.Add("PlayerDisconnected", "OnlyOne.OnDisconnect", function(Plr)
    local function removeSteam64()
        OnlyOne.SQL.Query("DELETE FROM OnlyOne_"..OnlyOne.Config.Identifier.." WHERE Steam64=\"".. Plr:SteamID64() .."\"")
    end
    timer.Simple(OnlyOne.Config.SteamIdRemoveDelay, removeSteam64)
end)

hook.Add("ShutDown", "OnlyOne.OnShutdown", function()
    OnlyOne.SQL.Query("DELETE FROM OnlyOne_Identifiers WHERE Identifier=\"" .. OnlyOne.Config.Identifier .."\"")
    OnlyOne.SQL.Query("DROP TABLE IF EXISTS OnlyOne_" .. OnlyOne.Config.Identifier)
end)