# open-console-shortcut

Open `cmd`, `bash`, `wt` or anyhing else in current working dir using [autohotkey](https://www.autohotkey.com/)

Tested in Windows 10

### Basic script

This is a simple script for open cmd in current dir
```ahk

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
    Run,  cmd /K cd /D "%path%"
}
```

You can call this script with <kbd>ctrl</kbd> + <kbd>t</kbd> combination

What is really important in this script it is `Get_Path` method which gives a current working dir from Explorer path holder

So, you can modify Run command in the end of OpenCmdInCurrent function

### Use wt or bash

If you want to open in wt you can use following script

```ahk

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
```

If you want to open wt with Ubuntu or another specific distribution - specify with `-p` key:
```ahk
Run,  wt -p "Ubuntu" -d "%path%"
```

For bash we can use `cmd` + `cd` + `bash` commands like this:
```ahk
Run,  cmd /k cd "%path%" && bash
```

Here we run command `cd` and call `bash` in working dir.
