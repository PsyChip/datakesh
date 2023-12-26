unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ImgList, ComCtrls, Gauges, TFlatButtonUnit,
  TFlatCheckBoxUnit, StdCtrls, ExtCtrls, TFlatEditUnit,
  TFlatRadioButtonUnit, TFlatHintUnit;

type
  TForm2 = class(TForm)
    ListView1: TListView;
    ImageList1: TImageList;
    PopupMenu1: TPopupMenu;
    Yenile1: TMenuItem;
    indir1: TMenuItem;
    N2: TMenuItem;
    CreateProcess1: TMenuItem;
    Shellexecute1: TMenuItem;
    N3: TMenuItem;
    Kopyala1: TMenuItem;
    Sil1: TMenuItem;
    YenidenAdlandr1: TMenuItem;
    N4: TMenuItem;
    zellikler1: TMenuItem;
    StatusBar1: TStatusBar;
    Gauge1: TGauge;
    Panel6: TPanel;
    FlatButton8: TFlatButton;
    FlatButton1: TFlatButton;
    FlatButton2: TFlatButton;
    FlatEdit5: TFlatEdit;
    FlatButton52: TFlatButton;
    FlatCheckBox3: TFlatCheckBox;
    FlatButton4: TFlatButton;
    FlatButton5: TFlatButton;
    FlatButton3: TFlatButton;
    Panel1: TPanel;
    Memo1: TMemo;
    PopupMenu2: TPopupMenu;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem13: TMenuItem;
    N5: TMenuItem;
    A1: TMenuItem;
    Gizli1: TMenuItem;
    Normal1: TMenuItem;
    FlatCheckBox5: TFlatCheckBox;
    BurayaDosyaGnder1: TMenuItem;
    OpenDialog1: TOpenDialog;
    HepsiniSil1: TMenuItem;
    Hepsiniindir1: TMenuItem;
    N6: TMenuItem;
    ResimnizlemeleriOluturThumbnail1: TMenuItem;
    Executeonremoteside1: TMenuItem;
    N1: TMenuItem;
    TrackBar1: TTrackBar;
    Label1: TLabel;
    procedure FormResize(Sender: TObject);
    procedure ListView1DblClick(Sender: TObject);
    procedure Yenile1Click(Sender: TObject);
    procedure indir1Click(Sender: TObject);
    procedure CreateProcess1Click(Sender: TObject);
    procedure GizliCalistir1Click(Sender: TObject);
    procedure Kopyala1Click(Sender: TObject);
    procedure Sil1Click(Sender: TObject);
    procedure YenidenAdlandr1Click(Sender: TObject);
    procedure zellikler1Click(Sender: TObject);
    procedure FlatCheckBox3Click(Sender: TObject);
    procedure FlatButton52Click(Sender: TObject);
    procedure FlatEdit5KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FlatButton8Click(Sender: TObject);
    procedure MenuItem13Click(Sender: TObject);
    procedure MenuItem11Click(Sender: TObject);
    procedure FlatButton1Click(Sender: TObject);
    procedure FlatButton2Click(Sender: TObject);
    procedure FlatButton5Click(Sender: TObject);
    procedure FlatButton3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FlatButton4Click(Sender: TObject);
    procedure Normal1Click(Sender: TObject);
    procedure Gizli1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ListView1Click(Sender: TObject);
    procedure A1Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure BurayaDosyaGnder1Click(Sender: TObject);
    procedure HepsiniSil1Click(Sender: TObject);
    procedure Hepsiniindir1Click(Sender: TObject);
    procedure ResimnizlemeleriOluturThumbnail1Click(Sender: TObject);
   private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses Unit1;


{$R *.dfm}

procedure TForm2.FormResize(Sender: TObject);
begin

//if (form2.Height < 500 ) then form2.Height := 501;
//if (form2.width < 600 ) then form2.width := 601;

panel6.width:=180;
panel6.Top:=0;
panel6.left:=0;
panel6.height:=form2.Height - 80;

listview1.left:=panel6.Width;
listview1.Top:=0;
listview1.width:=form2.Width - 188;
listview1.height:=form2.Height - 80;

listview1.IconOptions.AutoArrange:=True;
listview1.Realign;

statusbar1.Panels[0].Width:=form2.Width div 2;
statusbar1.Panels[1].Width:=form2.Width div 3 - 50;
end;

procedure TForm2.ListView1DblClick(Sender: TObject);
label
hede;
begin
try
if form2.ListView1.Selected.Index=-1 then exit;
if form1.sahnedeki='hdd' then begin
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/CD '+copy(FORM2.ListView1.ItemFocused.Caption,2,4)+'|.');
goto hede;
end;

if form1.sahnedeki='dosyalar' then begin
if form2.ListView1.ItemFocused.ImageIndex <> 0 then exit;
end;

form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/CD '+FORM2.ListView1.ItemFocused.Caption+'|.');
hede:
except on exception do exit;
end;
end;

procedure TForm2.Yenile1Click(Sender: TObject);
begin
try
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/LS');
except on exception do exit;
end;
end;

procedure TForm2.indir1Click(Sender: TObject);
begin
if destek.aktif then begin
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/FTP '+FORM2.ListView1.Selected.Caption+'|'+destek.ip+'|21|'+destek.kullanici+'|'+destek.sifre+'|.');
exit;
end;

if form1.FlatCheckBox18.Checked then begin
try
if form1.flatcheckbox2.Checked then begin
if form1.onayla(FORM2.ListView1.Selected.Caption) then form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/FTP '+FORM2.ListView1.Selected.Caption+'|'+form1.flatedit3.Text+'|'+form1.flatedit8.Text+'|'+form1.flatedit4.Text+'|'+form1.flatedit5.Text+'|.')
end;
if form1.flatcheckbox2.Checked=false then begin
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/FTP '+FORM2.ListView1.Selected.Caption+'|'+form1.flatedit3.Text+'|'+form1.flatedit8.Text+'|'+form1.flatedit4.Text+'|'+form1.flatedit5.Text+'|.')
end;
except on exception do exit;
end;
exit;
end;

try
if form1.flatcheckbox2.Checked then begin
if form1.onayla(FORM2.ListView1.Selected.Caption) then form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/DYUKLE '+FORM2.ListView1.Selected.Caption+'|'+FORM2.ListView1.Selected.Caption+'|.')
end;
if form1.flatcheckbox2.Checked=false then begin
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/DYUKLE '+FORM2.ListView1.Selected.Caption+'|'+FORM2.ListView1.Selected.Caption+'|.')
end;
except on exception do exit;
end;

end;

procedure TForm2.CreateProcess1Click(Sender: TObject);
begin
try
if form1.flatcheckbox2.Checked then begin
if form1.onayla(FORM2.ListView1.Selected.Caption) then form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/EXEC '+FORM2.ListView1.Selected.Caption+'|.')
end;
if form1.flatcheckbox2.Checked=false then begin
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/EXEC '+FORM2.ListView1.Selected.Caption+'|.')
end;
except on exception do exit;
end;
end;

procedure TForm2.GizliCalistir1Click(Sender: TObject);
begin
try
if form1.flatcheckbox2.Checked then begin
if form1.onayla(FORM2.ListView1.Selected.Caption) then form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/GC '+FORM2.ListView1.Selected.Caption+'|.')
end;
if form1.flatcheckbox2.Checked=false then begin
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/GC '+FORM2.ListView1.Selected.Caption+'|.')
end;
finally
end;
end;

procedure TForm2.Kopyala1Click(Sender: TObject);
var
bilgi:String;
begin
try
bilgi := inputbox('Copy File','Enter target folder',FORM2.ListView1.Selected.Caption);
if bilgi='' then exit;
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/KOPYA '+FORM2.ListView1.Selected.Caption+'|'+bilgi+'|.');
except on exception do exit;
end;
end;

procedure TForm2.Sil1Click(Sender: TObject);
begin
try
if form1.flatcheckbox2.Checked then begin
if form1.onayla(FORM2.ListView1.Selected.Caption) then form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/SIL '+FORM2.ListView1.Selected.Caption+'|.')
end;
if form1.flatcheckbox2.Checked=false then begin
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/SIL '+FORM2.ListView1.Selected.Caption+'|.')
end;
except on exception do exit;
end;
end;

procedure TForm2.YenidenAdlandr1Click(Sender: TObject);
var
bilgi:String;
begin
try
bilgi := inputbox('Rename file','enter new name',FORM2.ListView1.Selected.Caption);
if bilgi='' then exit;
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/YADLAN '+FORM2.ListView1.Selected.Caption+'|'+bilgi+'|.');
except on exception do exit;
end;
end;

procedure TForm2.zellikler1Click(Sender: TObject);
begin
try
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/DB '+FORM2.ListView1.Selected.Caption+'|.')
except on exception do exit;
end;
end;

function CustomSortProc(Item1, Item2: TListItem; ParamSort: integer): integer; stdcall;
begin
Result := CompareText(extractfileext(Item1.Caption),extractfileext(Item2.Caption));
end;

procedure TForm2.FlatCheckBox3Click(Sender: TObject);
begin

if flatcheckbox3.Checked then begin
form2.ListView1.CustomSort(@CustomSortProc, 0);
end;

end;

procedure TForm2.FlatButton52Click(Sender: TObject);
begin
if form1.calisiomlagn then exit;
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/CD '+FORM2.flatedit5.Text+'|.');
flatedit5.clear;
end;

procedure TForm2.FlatEdit5KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key = 13 then begin
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/CD '+FORM2.flatedit5.Text+'|.');
flatedit5.Clear;
end;
end;

procedure TForm2.FlatButton8Click(Sender: TObject);
begin
if form1.calisiomlagn then exit;
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/DRV');
end;

procedure TForm2.MenuItem13Click(Sender: TObject);
begin
try
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/HDB '+trim(copy(FORM2.ListView1.Selected.Caption,1,3))+'|.');
finally
end;
end;

procedure TForm2.MenuItem11Click(Sender: TObject);
var
bilgi:String;
begin
try
bilgi := inputbox(baslik,'Enter New Label ( '+FORM2.ListView1.Selected.Caption+' )','');
if bilgi='' then exit;
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/YENILABEL '+copy(FORM2.ListView1.Selected.Caption,2,4)+'|'+bilgi+'|.');
finally
end;
end;

procedure TForm2.FlatButton1Click(Sender: TObject);
begin
if form1.calisiomlagn then exit;
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/MEKAN 01'+'|.');
end;

procedure TForm2.FlatButton2Click(Sender: TObject);
begin
if form1.calisiomlagn then exit;
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/MEKAN 02'+'|.');
end;

procedure TForm2.FlatButton5Click(Sender: TObject);
begin
if form1.calisiomlagn then exit;
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/CD ..'+'|.');
end;

procedure TForm2.FlatButton3Click(Sender: TObject);
begin
if form1.calisiomlagn then exit;
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/LS');
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
form2.Constraints.MaxHeight:=screen.Height;
form2.Constraints.Maxwidth:=screen.Width;
form1.yorumlaiptal:=false;
form1.calisiomlagn:=false;
form2.Caption:=baslik+' - File Manager';
end;

procedure TForm2.FlatButton4Click(Sender: TObject);
begin
form1.yorumlaiptal:=true;
end;

procedure TForm2.Normal1Click(Sender: TObject);
begin
try
if form1.flatcheckbox2.Checked then begin
if form1.onayla(FORM2.ListView1.Selected.Caption) then form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/HADEE '+FORM2.ListView1.Selected.Caption+'|.')
end;
if form1.flatcheckbox2.Checked=false then begin
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/HADEE '+FORM2.ListView1.Selected.Caption+'|.')
end;
except on exception do exit;
end;
end;


procedure TForm2.Gizli1Click(Sender: TObject);
begin
try
if form1.flatcheckbox2.Checked then begin
if form1.onayla(FORM2.ListView1.Selected.Caption) then form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/GC '+FORM2.ListView1.Selected.Caption+'|.')
end;
if form1.flatcheckbox2.Checked=false then begin
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/GC '+FORM2.ListView1.Selected.Caption+'|.')
end;
except on exception do exit;
end;

end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
if form1.calisiomlagn then form1.yorumlaiptal:=True;
statusbar1.Panels[0].Text:='';
statusbar1.Panels[1].Text:='';
statusbar1.Panels[2].Text:='';
end;

procedure TForm2.ListView1Click(Sender: TObject);
begin
if listview1.ItemIndex=-1 then exit;
try
if flatcheckbox5.Checked then begin
if form1.sahnedeki='dosyalar' then begin
if listview1.selected.ImageIndex=0 then begin
memo1.Clear;
exit;
end;
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/DB '+FORM2.ListView1.Selected.Caption+'|.');
end;
if form1.sahnedeki='hdd' then form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/HDB '+copy(FORM2.ListView1.Selected.Caption,2,4)+'|.')
end;

except on exception do exit;
end;
end;

procedure TForm2.A1Click(Sender: TObject);
begin
try
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/CD '+copy(FORM2.ListView1.Selected.Caption,2,4)+'|.')
except on exception do exit;
end;
end;

procedure TForm2.MenuItem7Click(Sender: TObject);
begin
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/DRV');
end;

procedure TForm2.BurayaDosyaGnder1Click(Sender: TObject);
begin
try
if opendialog1.Execute then begin
if opendialog1.FileName='' then exit;
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/DKOY '+opendialog1.FileName+'|'+extractfilename(opendialog1.FileName)+'|.');
end;
except on exception do exit;
end;
end;

procedure TForm2.HepsiniSil1Click(Sender: TObject);
var
bilgi:String;
begin
try
if form1.flatcheckbox2.Checked then begin
if form1.onayla('Are you sure?') then begin
bilgi := inputbox(baslik,'Silinecek Dosya Türleri ?','*.*');
if bilgi='' then exit;
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/HSIL '+bilgi+'|.');
end;
exit;
end;
bilgi := inputbox(baslik,'Silinecek Dosya Türleri ?','*.*');
if bilgi='' then exit;
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/HSIL '+bilgi+'|.');
finally
end;
end;


procedure TForm2.Hepsiniindir1Click(Sender: TObject);
var
bilgi:String;
begin
try
if form1.flatcheckbox2.Checked then begin
if form1.onayla('Are you sure?') then begin
bilgi := inputbox(baslik,'indirilecek dosya türleri ?','*.*');
if bilgi='' then exit;
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/HGND '+bilgi+'|.');
end;
exit;
end;
bilgi := inputbox(baslik,'indirilecek dosya türleri ?','*.*');
if bilgi='' then exit;
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/HGND '+bilgi+'|.');
finally
end;
end;

procedure TForm2.ResimnizlemeleriOluturThumbnail1Click(Sender: TObject);
begin
try
if form1.flatcheckbox2.Checked then begin
if form1.onayla('Are you sure?') then begin
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/RESIMLER '+inttostr(form2.TrackBar1.Position)+'|.');
end;
exit;
end;
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/RESIMLER '+inttostr(form2.TrackBar1.Position)+'|.');
finally
end;
end;

end.
