unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, TFlatListBoxUnit, ComCtrls;

type
  TForm3 = class(TForm)
    PopupMenu1: TPopupMenu;
    Gebert1: TMenuItem;
    ListBox1: TListBox;
    Yenile1: TMenuItem;
    N1: TMenuItem;
    Yeniilem1: TMenuItem;
    N2: TMenuItem;
    procedure Gebert1Click(Sender: TObject);
    procedure Yenile1Click(Sender: TObject);
    procedure Yeniilem1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

uses Unit1;

{$R *.dfm}

procedure TForm3.Gebert1Click(Sender: TObject);
begin
try
if form1.CheckBox5.Checked then begin
if Application.MessageBox(pchar('i$lem kapatýlýyor : '+FORM3.listbox1.Items.Strings[listbox1.ItemIndex]),pchar('hobarey :D'),MB_OKCANCEL + MB_DEFBUTTON1) = IDOK then form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/PGEBERT '+FORM3.listbox1.Items.Strings[listbox1.ItemIndex])
end;
if form1.CheckBox5.Checked=false then begin
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/PGEBERT '+FORM3.listbox1.Items.Strings[listbox1.ItemIndex])
end;
finally
end;
end;

procedure TForm3.Yenile1Click(Sender: TObject);
begin
try
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/PRG')
finally
end;
end;

procedure TForm3.Yeniilem1Click(Sender: TObject);
var
bilgi:String;
begin
try
bilgi := inputbox('i$lem ba$lat','Tam yolu gir','');
if bilgi='' then exit;
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/DC '+bilgi);
finally
end;
end;
end.
