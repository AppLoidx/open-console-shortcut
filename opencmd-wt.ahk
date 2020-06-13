
SetTitleMatchMode RegEx
return

#IfWinActive ahk_class ExploreWClass|CabinetWClass
    ^t::
        OpenCmdInCurrent()
    return
#IfWinActive

Get_Path(hwnd="") {
    WinGet, process, processName, % "ahk_id" hwnd := hwnd? hwnd:WinExist("A")
    WinGetClass class, ahk_id %hwnd%
    if  (process = "explorer.exe") 
        if (class ~= "(Cabinet|Explore)WClass") {
            for window in ComObjCreate("Shell.Application").Windows
                if  (window.hwnd==hwnd)
                    path := window.Document.FocusedItem.path

            SplitPath, path,,dir
        }
        return dir
}

OpenCmdInCurrent()
{
    path := Get_Path()
    Run,  wt -d "%path%"
}
