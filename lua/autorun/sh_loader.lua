if CLIENT then 
    print("Perry Was Here!")
    return
end

OnlyOne = OnlyOne or {}
OnlyOne.VERSION = "0.1.2-1"

OnlyOne.Load = function(File)
    include(File)
    MsgC(Color(100,100,255,255), "||   ", Color(100,255,100,255), "Loaded ", Color(255,255,255,255), File, "\n")
end

MsgC(Color(100,100,255,255), "[]=====[ Only One ]=====[]\n")
MsgC(Color(100,100,255,255), "|| ", Color(100,255,100,255), "INFO:\n")
MsgC(Color(100,100,255,255), "||   ", Color(100,255,100,255), "Name: ", Color(255,255,255,255), "Only One\n")
MsgC(Color(100,100,255,255), "||   ", Color(100,255,100,255), "Version: ", Color(255,255,255,255), OnlyOne.VERSION, "\n")
MsgC(Color(100,100,255,255), "||   ", Color(100,255,100,255), "By: ", Color(255,255,255,255), "1perry_ @ brenny.zip\n")


if not util.IsBinaryModuleInstalled("mysqloo") then
    MsgC(Color(100,100,255,255), "|| ", Color(255,0,0,255), "LOAD FAILED:\n")
    MsgC(Color(100,100,255,255), "||   ", Color(255,0,0,255), "Missing MySQLOO\n")
    MsgC(Color(100,100,255,255), "[]=====[ Only One ]=====[]\n")
    return
end

MsgC(Color(100,100,255,255), "|| ", Color(100,255,100,255), "MODULES:\n")

OnlyOne.Load("only_one/sv_config.lua")
OnlyOne.Load("only_one/sv_util.lua")
OnlyOne.Load("only_one/sv_sql.lua")
OnlyOne.Load("only_one/sv_main.lua")

MsgC(Color(100,100,255,255), "[]=====[ Only One ]=====[]\n")

--RunConsoleCommand("sv_hibernate_think", 1)