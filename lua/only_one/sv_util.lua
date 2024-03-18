OnlyOne = OnlyOne or {}
OnlyOne.Log = function(msg)
    MsgC(Color(0,200,0,255), "[LOG] OnlyOne > " .. msg .. "\n")
end
OnlyOne.Warn = function(msg)
    MsgC(Color(255,125,0,255), "[WARN] OnlyOne > " .. msg .. "\n")
end
OnlyOne.Error = function(msg)
    MsgC(Color(255,0,0,255), "[ERROR] OnlyOne > " .. msg .. "\n")
end
OnlyOne.Debug = function(msg)
    if not OnlyOne.Config.DEBUG then return end
    MsgC(Color(100,100,255,255), "[DEBUG] OnlyOne > " .. msg .. "\n")
end