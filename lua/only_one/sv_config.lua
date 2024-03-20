OnlyOne = OnlyOne or {}
OnlyOne.Config = {
    Identifier = "Server1",

    Command = "sam kickid {} All ready connected to network!",
    UseCommand = false, -- if false, the user will be kicked with the following reason
    KickReason = "All ready connected to network!",

    -- Time until the user's steam64 is removed on disconnect (in Seconds)
    SteamIdRemoveDelay = 10,
    
    --[[
        NOTE: This addon requires MySqloo to run
        https://github.com/FredyH/MySQLOO/releases
    ]]--
    Database = {
        Host     = "localhost",
        Port     = 3306,
        Database = "OnlyOne",
        User     = "root",
        Password = "pswd"
    },
    
    DEBUG = false 
}
