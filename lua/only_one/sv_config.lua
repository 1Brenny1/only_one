OnlyOne = OnlyOne or {}
OnlyOne.Config = {
    Identifier = "Server1",

    Command = "sam kickid {} All ready connected to network!",
    UseCommand = false, -- if false, the user will be kicked with the following reason
    KickReason = "All ready connected to network!",
    
    -- Time until they are marked offline (prevents them from reloging or swapping servers until timer is up)
    RelogDelay = 10, -- Delay is in seconds

    -- Whitelist to bypass the check
    -- supports user groups, steamids, and steam64s
    Whitelist = {
        "superadmin",
        "STEAM_0:1:000000000",
        "76561199153945255"
    }

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
