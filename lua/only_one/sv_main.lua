OnlyOne = OnlyOne or {}

hook.Add("PlayerAuthed", "OnlyOne.OnConnect", function(Plr, SteamId, UniqueId)
    OnlyOne.SQL.Query("INSERT INTO OnlyOne_"..OnlyOne.Config.Identifier.." (Steam64) VALUES (\""..UniqueId.."\")")

    local query = OnlyOne.SQL.Query("SELECT * FROM OnlyOne_Identifiers WHERE Identifier!=\""..OnlyOne.Config.Identifier.."\"")
    function query:OnSuccess(data)
        while query:hasMoreResults() do
            row = query:getData()[1]
            for k,v in pairs(row) do
                local checkQuery = OnlyOne.SQL.Query("SELECT * FROM OnlyOne_"..v.." WHERE Steam64=\"" .. UniqueId .."\"")
                function checkQuery:OnSuccess(data)
                    if checkQuery:hasMoreResults() then
                        -- User All Ready Online
                        if OnlyOne.Config.UseCommand then
                            game.ConsoleCommand(OnlyOne.Config.Command)
                        else
                            game.KickID(UniqueId, OnlyOne.Config.kickReason)
                        end
                    end
                end
            end
            query:getNextResults()
        end
    end
end)

hook.Add("PlayerDisconnected", "OnlyOne.OnDisconnect", function(Plr)
    OnlyOne.SQL.Query("DELETE FROM OnlyOne_"..OnlyOne.Config.Identifier.." WHERE Steam64=\"".. Plr:SteamID64() .."\"")
end)