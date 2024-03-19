if CLIENT then 
    print("Perry Was Here!")
    return
end

OnlyOne = OnlyOne or {}
OnlyOne.VERSION = "0.1.1"

OnlyOne.Load = function(File)
    include(File)
    MsgC(Color(255,125,0,255), "||   Loaded " .. File .. "\n")
end

MsgC(Color(0,255,0,255), "[]=====[ Only One ]=====[]\n")
MsgC(Color(0,255,0,255), "|| INFO:\n")
MsgC(Color(0,255,0,255), "||   Name: Only One\n")
MsgC(Color(0,255,0,255), "||   Version: " .. OnlyOne.VERSION .. "\n")
MsgC(Color(0,255,0,255), "||   By: 1perry_ @ brenny.zip\n")


if not util.IsBinaryModuleInstalled("mysqloo") then
    MsgC(Color(255,0,0,255), "|| LOAD FAILED:\n")
    MsgC(Color(255,0,0,255), "||   Missing MySQLOO\n")
    MsgC(Color(255,0,0,255), "[]=====[ Only One ]=====[]\n")
    return
end

MsgC(Color(0,255,0,255), "|| MODULES:\n")

OnlyOne.Load("only_one/sv_config.lua")
OnlyOne.Load("only_one/sv_util.lua")
OnlyOne.Load("only_one/sv_sql.lua")
OnlyOne.Load("only_one/sv_main.lua")

MsgC(Color(0,255,0,255), "[]=====[ Only One ]=====[]\n")