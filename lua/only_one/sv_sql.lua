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

function OnlyOne.SQL.RawQuery(str)
    local query = OnlyOne.SQL.DB:query(str)
    function query:onError(err)
        OnlyOne.Error("SQL Query Failed!")
        OnlyOne.Error("Error: " .. err)
        OnlyOne.Debug("SQL: " .. str)
    end
    return query
end

function OnlyOne.SQL.Query(str)
    local query = OnlyOne.SQL.RawQuery(str)
    query:start()
    return query
end

function OnlyOne.SQL.DB:onConnected()
    OnlyOne.Log("Connected to database!")

    -- Identifiers Table Setup
    OnlyOne.SQL.Query("CREATE TABLE IF NOT EXISTS OnlyOne_Identifiers (Identifier VARCHAR(128) UNIQUE PRIMARY KEY)")
    local insertQuery = OnlyOne.SQL.RawQuery("INSERT INTO OnlyOne_Identifiers (Identifier) VALUES (\"" .. OnlyOne.Config.Identifier .."\")")
    insertQuery.onError = function(err) OnlyOne.Debug("Indentifier All Ready Exists!") end
    insertQuery:start()
    
    -- Server Identifier Online Table Setup
    OnlyOne.SQL.Query("DROP TABLE IF EXISTS OnlyOne_" .. OnlyOne.Config.Identifier)
    OnlyOne.SQL.Query("CREATE TABLE IF NOT EXISTS OnlyOne_" .. OnlyOne.Config.Identifier .. " (Steam64 VARCHAR(17) UNIQUE)")
end

function OnlyOne.SQL.DB:onConnectionFailed( err )
    OnlyOne.Error("Failed to connect to database!")
    OnlyOne.Error("Error: " .. err)
end

-- Initialize Database Connection
OnlyOne.SQL.DB:connect()

