unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls;

type
  TForm4 = class(TForm)
    ListBox1: TListBox;
    PopupMenu1: TPopupMenu;
    Kapat1: TMenuItem;
    Flash1: TMenuItem;
    Sakla1: TMenuItem;
    Gster1: TMenuItem;
    N1: TMenuItem;
    Yenile1: TMenuItem;
    N2: TMenuItem;
    Kapat2: TMenuItem;
    procedure Kapat1Click(Sender: TObject);
    procedure Flash1Click(Sender: TObject);
    procedure Sakla1Click(Sender: TObject);
    procedure Gster1Click(Sender: TObject);
    procedure Yenile1Click(Sender: TObject);
    procedure Kapat2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

uses Unit1, Unit3;

{$R *.dfm}

procedure TForm4.Kapat1Click(Sender: TObject);
begin
try
if form1.CheckBox5.Checked then begin
if Application.MessageBox(pchar('i$lemi onayla : '+FORM4.listbox1.Items.Strings[listbox1.ItemIndex]),pchar('hobarey :D'),MB_OKCANCEL + MB_DEFBUTTON1) = IDOK then form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/PGETIR '+FORM4.listbox1.Items.Strings[listbox1.ItemIndex])
end;
if form1.CheckBox5.Checked=false then begin
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/PGETIR '+FORM4.listbox1.Items.Strings[listbox1.ItemIndex])
end;
finally
end;
end;

procedure TForm4.Flash1Click(Sender: TObject);
begin
try
if form1.CheckBox5.Checked then begin
if Application.MessageBox(pchar('i$lemi onayla : '+FORM4.listbox1.Items.Strings[listbox1.ItemIndex]),pchar('hobarey :D'),MB_OKCANCEL + MB_DEFBUTTON1) = IDOK then form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/PFLASH '+FORM4.listbox1.Items.Strings[listbox1.ItemIndex])
end;
if form1.CheckBox5.Checked=false then begin
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/PFLASH '+FORM4.listbox1.Items.Strings[listbox1.ItemIndex])
end;
finally
end;
end;

procedure TForm4.Sakla1Click(Sender: TObject);
begin
try
if form1.CheckBox5.Checked then begin
if Application.MessageBox(pchar('i$lemi onayla : '+FORM4.listbox1.Items.Strings[listbox1.ItemIndex]),pchar('hobarey :D'),MB_OKCANCEL + MB_DEFBUTTON1) = IDOK then form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/PSAKLA '+FORM4.listbox1.Items.Strings[listbox1.ItemIndex])
end;
if form1.CheckBox5.Checked=false then begin
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/PFLASH '+FORM4.listbox1.Items.Strings[listbox1.ItemIndex])
end;
finally
end;
end;

procedure TForm4.Gster1Click(Sender: TObject);
begin
try
if form1.CheckBox5.Checked then begin
if Application.MessageBox(pchar('i$lemi onayla : '+FORM4.listbox1.Items.Strings[listbox1.ItemIndex]),pchar('hobarey :D'),MB_OKCANCEL + MB_DEFBUTTON1) = IDOK then form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/PGSTER '+FORM4.listbox1.Items.Strings[listbox1.ItemIndex])
end;
if form1.CheckBox5.Checked=false then begin
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/PGSTER '+FORM4.listbox1.Items.Strings[listbox1.ItemIndex])
end;
finally
end;
end;

procedure TForm4.Yenile1Click(Sender: TObject);
begin
try
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/TL')
finally
end;
end;

procedure TForm4.Kapat2Click(Sender: TObject);
begin
try
if form1.CheckBox5.Checked then begin
if Application.MessageBox(pchar('i$lemi onayla : '+FORM4.listbox1.Items.Strings[listbox1.ItemIndex]),pchar('hobarey :D'),MB_OKCANCEL + MB_DEFBUTTON1) = IDOK then form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/PKAPAT '+FORM4.listbox1.Items.Strings[listbox1.ItemIndex])
end;
if form1.CheckBox5.Checked=false then begin
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/PKAPAT '+FORM4.listbox1.Items.Strings[listbox1.ItemIndex])
end;
finally
end;
end;

end.
