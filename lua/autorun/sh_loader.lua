if CLIENT then return end
OnlyOne = OnlyOne or {}

OnlyOne.Load = function(File)
    include(File)
    MsgC(Color(255,125,0,255), "| Loaded " .. File .. "\n")
end

MsgC(Color(0,255,0,255), "|---------------|\n")
MsgC(Color(0,255,0,255), "|   Only  One   |\n")
MsgC(Color(0,255,0,255), "|---------------|\n")

if not util.IsBinaryModuleInstalled("mysqloo") then
    MsgC(Color(255,0,0,255), "| Missing MySqloo\n")

    MsgC(Color(255,0,0,255), "|---------------|\n")
    MsgC(Color(255,0,0,255), "|  Load Failed  |\n")
    MsgC(Color(255,0,0,255), "|---------------|\n")
    return
end

OnlyOne.Load("only_one/sv_config.lua")
OnlyOne.Load("only_one/sv_util.lua")
OnlyOne.Load("only_one/sv_sql.lua")
OnlyOne.Load("only_one/sv_main.lua")

MsgC(Color(0,255,0,255), "|---------------|\n")
MsgC(Color(0,255,0,255), "| Load Complete |\n")
MsgC(Color(0,255,0,255), "|---------------|\n")