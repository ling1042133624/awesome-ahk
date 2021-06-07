/**
 * @encode: gbk
 * @author: ceynri
 * @Project: https://github.com/ceynri/awesome-ahk
 * @document: https://wyagd001.github.io/zh-cn/docs/AutoHotkey.htm
 *
 * Notes:  # == win    ! == Alt    ^ == Ctrl    + == Shift
 */

#SingleInstance Force ; �ظ�������ʱ���Զ�����

; ������ԱȨ�ޣ�û�����Թ���ԱȨ�����������ű������ⲿ��������޷�ʹ��ahk
Loop, %0%  ; For each parameter:
{
    param := %A_Index%  ; Fetch the contents of the variable whose name is contained in A_Index.
    params .= A_Space . param
}
ShellExecute := A_IsUnicode ? "shell32\ShellExecute":"shell32\ShellExecuteA"
if not A_IsAdmin
{
    If A_IsCompiled
        DllCall(ShellExecute, uint, 0, str, "RunAs", str, A_ScriptFullPath, str, params , str, A_WorkingDir, int, 1)
    Else
        DllCall(ShellExecute, uint, 0, str, "RunAs", str, A_AhkPath, str, """" . A_ScriptFullPath . """" . A_Space . params, str, A_WorkingDir, int, 1)
    ExitApp
}

; ����
userDir := "C:\ceynri"
sysUserDir := "C:\Users\ceynri"
currentScript := "ceynri.ahk"

#IfWinActive, ahk_exe Explorer.EXE
; ---------------------------------------------------------
; Win + H ��ʾ/����ϵͳ�����ļ�
; ---------------------------------------------------------
toggleSysHiddenFileDisplay() {
    If value = 1
        value := 2
    Else
        value = 1
    RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\, Hidden, %Value%
    Send {Browser_Refresh}
}
#H::toggleSysHiddenFileDisplay()
; ---------------------------------------------------------


; ---------------------------------------------------------
; Win + Z ��ʾ/���������ļ�
; ---------------------------------------------------------
toggleDesktopFileDisplay() {
    ControlGet, class, Hwnd,, SysListView321, ahk_class Progman
    If class = 
        ControlGet, class, Hwnd,, SysListView321, ahk_class WorkerW
    If DllCall("IsWindowVisible", UInt,class)
        WinHide, ahk_id %class%
    Else
        WinShow, ahk_id %class%
}
#Z::toggleDesktopFileDisplay()
; ---------------------------------------------------------


; ---------------------------------------------------------
; Win + S ��õ�ǰѡ���ļ���·��������Դ������/��������Ч��
; ---------------------------------------------------------
getFilePath() {
    Send ^c
    clipboard = %clipboard%
    tooltip, %clipboard%
    sleep, 500
    tooltip
}
#S::getFilePath()
; ---------------------------------------------------------


; ---------------------------------------------------------
; Win + C �򿪵�ǰĿ¼�µĿ���������
; TODO: ��Ϊ���õķ���
; ---------------------------------------------------------
openPSOnCurrentDir() {
    WinGetText, path, A
    StringSplit, word_array, path, `n ; Split on newline (`n)
    path := word_array9
    ToolTip %word_array9%
    Sleep 500
    ToolTip
    path := RegExReplace(path, "^��ַ: ", "") ; strip to bare address
    StringReplace, path, path, `r, , all ; Just in case - remove all carriage returns (`r)

    Run cmd ; run powershell Start-Process powershell -Verb runAs 
    Sleep 500
    IfInString path, \
    {
        Send cd %path%
    }
    else
    {
        Send cd C:\
    }
    Send {Enter}
}
#C::openPSOnCurrentDir()
; ---------------------------------------------------------
#If ; End "#IfWinActive, ahk_exe Explorer.EXE"


; ---------------------------------------------------------
; Win + O �ر���ʾ��
; ---------------------------------------------------------
closeMonitor() {
    Sleep 2000 ; ���û��л����ͷŰ��� (�Է��ͷ�����ʱ�ٴλ���������).
    SendMessage, 0x112, 0xF170, 2,, Program Manager ; �ر���ʾ��: 0x112 Ϊ WM_SYSCOMMAND, 0xF170 Ϊ SC_MONITORPOWER. ; ��ʹ�� -1 ���� 2 ����ʾ����1 ���� 2 ������ʾ���Ľ���ģʽ
}
#O::closeMonitor()
; ---------------------------------------------------------


; ---------------------------------------------------------
; Win + T ��ǰ�����ö�
; ---------------------------------------------------------
toggleCurrentWindowOnTop() {
    WinSet, AlwaysOnTop, TOGGLE, A ; A��AutoHotkey���ʾ��ǰ����ڵı���
    WinGet, ExStyle, ExStyle, A
    if (ExStyle & 0x8) ; 0x8 Ϊ WS_EX_TOPMOST.��WinGet�İ�����
        tooltip �ö�
    else
        ToolTip ȡ���ö�
    Sleep 1000
    ToolTip
}
#T::toggleCurrentWindowOnTop()
; ---------------------------------------------------------


; ---------------------------------------------------------
; Win + J ������
; ---------------------------------------------------------
#J::Run calc
; ---------------------------------------------------------


; ---------------------------------------------------------
; Win [+ Shift ]+ F �� userDir �ļ���
; ---------------------------------------------------------
#F::Run % userDir
#+F::Run % userDir
; ---------------------------------------------------------
; Win + Shift + D �̰� �� Downloads
;                 ���� �� docs
; ---------------------------------------------------------
#+D::
    KeyWait, D
    If (A_TimeSinceThisHotkey < 300) {
        Run % sysUserDir . "\Downloads"
    } Else {
        Run % userDir . "\docs"
    }
    Return
; ---------------------------------------------------------
; Win + Shift + T ��Tools�ļ���
; ---------------------------------------------------------
#+T::Run % userDir . "\tools"
; ---------------------------------------------------------
; Win + Shift + P �� Pictures �ļ���
; ---------------------------------------------------------
#+P::Run % userDir . "\pictures"
; ---------------------------------------------------------
; Win + Shift + Z ��Desktop�ļ���
; ---------------------------------------------------------
#+Z::Run % sysUserDir . "\Desktop"
; ---------------------------------------------------------
; Win + Shift + W �� workspace �ļ���
; ---------------------------------------------------------
#+W::Run % userDir . "\workspace"
; ---------------------------------------------------------
; Win + Shift + N �� ceynri.cn �ļ���
; ---------------------------------------------------------
#+N::Run % userDir . "\workspace\ceynri.cn"
; ---------------------------------------------------------


; ---------------------------------------------------------
; Win + C �򿪿���������
; TODO: ��Ϊ window terminal ����Աģʽ
; ---------------------------------------------------------
; #C::
; ---------------------------------------------------------
; Win + K �򿪿������
; ---------------------------------------------------------
#K::Run control.exe
; ---------------------------------------------------------
; Win + Y �򿪳����빦��
; ---------------------------------------------------------
#Y::Run control.exe /name Microsoft.ProgramsAndFeatures
; ---------------------------------------------------------


; ---------------------------------------------------------
; Win + N �½� Edge ����
; ---------------------------------------------------------
#N::Run "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
; ---------------------------------------------------------


; ---------------------------------------------------------
; Win + M ������������
; ---------------------------------------------------------
#M::
    IfWinNotExist ahk_class OrpheusBrowserHost
    {
        Run "C:\Program Files (x86)\Netease\CloudMusic\cloudmusic.exe"
        winActivate
    }
    Else IfWinNotActive ahk_class OrpheusBrowserHost
        winActivate
    Else 
        winMinimize
    Return
; ---------------------------------------------------------


; ---------------------------------------------------------
; �� CapsLock �滻Ϊ Alt + CapsLock
; ---------------------------------------------------------
CapsLock::Return
; ��Alt��Ctrl���μ����� Capslock ��һͬʹ�ã������û�а������� Capslock ��ϵļ�����ƹ�����Ĺ��򴥷���д�������ʽ���
<!Capslock::Return
<^Capslock::Return
; Win/Right Alt + Capslock �����д��
#Capslock::
>!Capslock::
    isCaps = % GetKeyState("CapsLock", "T")
    If (isCaps) {
        SetCapsLockState, off
        ToolTip
    } Else {
        SetCapsLockState, on
        ToolTip Caps Locking
    }
Return
; ---------------------------------------------------------
; Ϊ60%��65%���̽���F��ӳ�䣨����Fn�����߼���
; ---------------------------------------------------------
Capslock & Esc::`
Capslock & 1::F1
Capslock & 2::F2
Capslock & 3::F3
Capslock & 4::F4
Capslock & 5::F5
Capslock & 6::F6
Capslock & 7::F7
Capslock & 8::F8
Capslock & 9::F9
Capslock & 0::F10
Capslock & -::F11
Capslock & +::F12
Capslock & ,::Home
Capslock & .::End
; ---------------------------------------------------------
; �� Capslock + W/A/S/D������������
; ---------------------------------------------------------
Capslock & W::Up
Capslock & A::Left
Capslock & S::Down
Capslock & D::Right
; ---------------------------------------------------------
; �� Capslock + Q/E/T/G����λ��
; ---------------------------------------------------------
Capslock & Q::Home
Capslock & E::End
Capslock & T::PgUp
Capslock & G::PgDn
; ---------------------------------------------------------
; ����Capslock + R/F��������
; ---------------------------------------------------------
Capslock & R::Send {Volume_Up 1}
Capslock & F::Send {Volume_Down 1}
; ---------------------------------------------------------
; ����Capslock + Z/X�л�����  Capslock + Space��ͣ����
; ---------------------------------------------------------
Capslock & Z::Media_Prev
Capslock & X::Media_Next
Capslock & Space::Media_Play_Pause
; ---------------------------------------------------------
; ����Capslock + C/V�������ȣ����ã�Win + Up/Down��
; ---------------------------------------------------------
Capslock & C::
LWin & Down::
    AdjustScreenBrightness(-5)
    Return

Capslock & V::
LWin & Up::
    AdjustScreenBrightness(5)
    Return

AdjustScreenBrightness(step) {
    service := "winmgmts:{impersonationLevel=impersonate}!\\.\root\WMI"
    monitors := ComObjGet(service).ExecQuery("SELECT * FROM WmiMonitorBrightness WHERE Active=TRUE")
    monMethods := ComObjGet(service).ExecQuery("SELECT * FROM wmiMonitorBrightNessMethods WHERE Active=TRUE")
    minBrightness := 0

    for i in monitors {
        curt := i.CurrentBrightness
        break
    }
    toSet := curt + step
    If (toSet > 100) {
        Return
    }
    If (toSet < minBrightness) {
        toSet := minBrightness
    }

    for i in monMethods {
        i.WmiSetBrightness(1, toSet)
        break
    }
}
; ---------------------------------------------------------


; ---------------------------------------------------------
; Win + R ���� �����ýű�
; ---------------------------------------------------------
#R::
    KeyWait, R
    If (A_TimeSinceThisHotkey > 300) {
        ToolTip Reload Script
        Sleep 300
        ToolTip
        Reload
    } Else {
        Run % sysUserDir . "\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\System Tools\Run.lnk"
    }
    Return
; ---------------------------------------------------------


; ---------------------------------------------------------
; Win + E ���� �޸ĸýű�
; ---------------------------------------------------------
#E::
    KeyWait, E ; �ȴ� E ��̧��
    If (A_TimeSinceThisHotkey > 300) {
        Run "C:\Users\ceynri\AppData\Local\Programs\Microsoft VS Code\code.exe" %userDir%\workspace\awesome-ahk\����\%currentScript% ; ʹ�� vs code �򿪽ű����滻����Ľ�"��λ�ã�
    } Else {
        Run explorer
    }
Return
; ---------------------------------------------------------


; ---------------------------------------------------------
; 
; ---------------------------------------------------------


; ---------------------------------------------------------