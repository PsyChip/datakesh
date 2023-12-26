unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TFlatButtonUnit, ExtCtrls, StdCtrls;

type
  TForm3 = class(TForm)
    Label14: TLabel;
    FlatButton9: TFlatButton;
    Timer1: TTimer;
    procedure FlatButton9Click(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
   private
 procedure WMNCHitTest( var Msg : TWMNCHitTest ); message wm_NCHitTest;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

uses Unit1;

{$R *.dfm}

procedure TForm3.WMNCHitTest( var Msg : TWMNCHitTest );
begin
  inherited;
  { fool windows by telling it
    that it's in our caption area
    although it's in our client area }
  if( htClient = Msg.Result )then
    Msg.Result := htCaption;
end;

procedure TForm3.FlatButton9Click(Sender: TObject);
begin
form3.Close;
end;

procedure TForm3.FormPaint(Sender: TObject);
var
rect:trect;
begin
rect.Left:=0;
rect.Top:=0;
rect.Right:=form3.Width;
rect.Bottom:=form3.Height;
form3.Canvas.Brush.Color:=cllime;
form3.Canvas.FillRect(rect);
rect.Left:=2;
rect.Top:=2;
rect.Right:=form3.Width-2;
rect.Bottom:=form3.Height-2;
form3.Canvas.Brush.Color:=clblack;
form3.Canvas.FillRect(rect);
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
form3.Left:=screen.Width-form3.Width;
form3.Top:=screen.WorkAreaHeight-form3.Height;
end;

procedure TForm3.Timer1Timer(Sender: TObject);
begin
if form1.Active then exit;
BringWindowToTop(Form3.Handle)
end;

procedure TForm3.FormClose(Sender: TObject; var Action: TCloseAction);
begin
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/PUYARI KAPA'+'|.');
form3.timer1.enabled:=false;
end;

procedure TForm3.FormShow(Sender: TObject);
begin
form3.timer1.enabled:=true;
end;

end.
