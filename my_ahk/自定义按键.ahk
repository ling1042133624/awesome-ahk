^1::
send #^{left}
return 

^2::
send #^{right} 
return 

^3::Run "https://notebooklm.google.com/notebook/d13e8432-4db4-4acc-93c9-5de3e1893205"


; ---------------------------------------------------------
; Win + T 当前窗口置顶
; ---------------------------------------------------------
toggleCurrentWindowOnTop() {
    WinSet, AlwaysOnTop, TOGGLE, A ; A在AutoHotkey里表示当前活动窗口的标题
    WinGet, ExStyle, ExStyle, A
    if (ExStyle & 0x8) ; 0x8 为 WS_EX_TOPMOST.在WinGet的帮助中
        tooltip 置顶
    else
        ToolTip 取消置顶
    Sleep 1000
    ToolTip
}
#T::toggleCurrentWindowOnTop()
; ---------------------------------------------------------



