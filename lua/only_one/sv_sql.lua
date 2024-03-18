OnlyOne = OnlyOne or {}
OnlyOne.SQL = {}

require( "mysqloo" )

OnlyOne.SQL.DB = mysqloo.connect(
    OnlyOne.Config.Database.Host, 
    OnlyOne.Config.Database.User, 
    OnlyOne.Config.Database.Password, 
    OnlyOne.Config.Database.Database, 
    OnlyOne.Config.Database.Port
)

function OnlyOne.SQL.Query(str)
    local query = OnlyOne.SQL.DB:query(str)
    function query:onError(err)
        OnlyOne.Error("SQL Query Failed!")
        OnlyOne.Error("Error: " .. err)
    end
    return query
end

function OnlyOne.SQL.DB:onConnected()
    OnlyOne.Log("Connected to database!")
end

function OnlyOne.SQL.DB:onConnectionFailed( err )
    OnlyOne.Error("Failed to connect to database!")
    OnlyOne.Error("Error: " .. err)
end

-- Initialize Database Connection
OnlyOne.SQL.DB:connect()

-- Identifiers Table Setup
OnlyOne.SQL.Query("CREATE TABLE IF NOT EXISTS OnlyOne_Identifiers (Identifier TEXT UNIQUE)")
OnlyOne.SQL.Query("INSERT INTO OnlyOne_Identifiers (Identifier) VALUES (\"" .. OnlyOne.Config.Identifier .."\")")

-- Server Identifier Online Table Setup
OnlyOne.SQL.Query("DROP TABLE IF EXISTS OnlyOne_" .. OnlyOne.Config.Identifier)
OnlyOne.SQL.Query("CREATE TABLE OnlyOne_" .. OnlyOne.Config.Identifier .. " (Steam64 TEXT UNIQUE)")