program Client;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  Unit2 in 'Unit2.pas' {Form2},
  Unit3 in 'Unit3.pas' {Form3};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Datakesh 4.2';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  application.HintPause:=10;
  application.HintHidePause:=999999;
  application.HintColor:=$00D7FFEB;
  Application.Run;
end.
