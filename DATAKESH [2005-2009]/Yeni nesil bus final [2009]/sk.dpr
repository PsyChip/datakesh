program sk;

uses
windows,
lh5unit,
sysutils,
classes;

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

begin
sikistir(paramstr(1),paramstr(1)+'.plh5');
end.