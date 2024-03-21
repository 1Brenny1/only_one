OnlyOne = OnlyOne or {}
OnlyOne.Log = function(msg)
    MsgC(Color(0,200,0,255), "[LOG] ", Color(100,100,255,255), "OnlyOne > ", Color(255,255,255,255), msg, "\n")
end
OnlyOne.Warn = function(msg)
    MsgC(Color(255,125,0,255), "[WARN] ", Color(100,100,255,255), "OnlyOne > ", Color(255,255,255,255), msg, "\n")
end
OnlyOne.Error = function(msg)
    MsgC(Color(255,0,0,255), "[ERROR] ", Color(100,100,255,255), "OnlyOne > ", Color(255,255,255,255), msg, "\n")
end
OnlyOne.Debug = function(msg)
    if not OnlyOne.Config.DEBUG then return end
    MsgC(Color(100,100,255,255), "[DEBUG] ", Color(100,100,255,255), "OnlyOne > ", Color(255,255,255,255), msg, "\n")
end
OnlyOne.Disable = function(reason)
    OnlyOne.ENABLED = false
    MsgC(Color(100,100,255,255), "[]=====[ Only One ]=====[]\n")
    MsgC(Color(100,100,255,255), "[]", Color(255,0,0,255), "Disabled due to ", reason, "\n")
    MsgC(Color(100,100,255,255), "[]=====[ Only One ]=====[]\n")
end