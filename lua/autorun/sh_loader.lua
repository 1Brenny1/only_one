OnlyOne = OnlyOne or {}

OnlyOne.Load = function(File)
    include(File)
    MsgC(Color(255,125,0,255), "| Loaded " .. File .. ".lua\n")
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

OnlyOne.Load("only_one/sv_config")
OnlyOne.Load("only_one/sv_util")
OnlyOne.Load("only_one/sv_sql")
OnlyOne.Load("only_one/sv_main")

MsgC(Color(0,255,0,255), "|---------------|\n")
MsgC(Color(0,255,0,255), "| Load Complete |\n")
MsgC(Color(0,255,0,255), "|---------------|\n")