unit gfxCore;

interface
Function SaveScr(Quality : Integer; SavAs : String) : Boolean;
function Camkaydet(kalite : integer; yer : string) : Boolean;
procedure PrintInCoordinate(Text:string; b1,b2,b3,X,Y:Integer);

implementation

uses
Windows,
Classes,
untwebcam,
graphics,
sysutils,
Jpeg;

procedure PrintInCoordinate(Text:string; b1,b2,b3,X,Y:Integer);
var
   CrLf,cLine:string;
   c,LineH,p:LongInt;
   Dc:HDC;
begin
try
   CrLf:=#13#10;
   c:=0;
   Dc:=GetWindowDc(GetDesktopWindow);
   with TCanvas.Create do
   begin
      Handle:=Dc;
      Font.Size:=b1;
      Font.Color:=b2;
      font.Name:='Verdana';
      Brush.Color:=b3;
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
      TextOut(X,Y + (c * LineH),Text);
      Free;
   end;
except
on Exception do exit
end;
end;

function GetBitmapFromFile(BitmapPath: string): HBitmap;
begin
  Result := LoadImage(GetModuleHandle(nil), pchar(BitmapPath), IMAGE_BITMAP, 0, 0, LR_LOADFROMFILE);
end;

Function ScrBmp : TBitmap;
Var
 Bit : TBitmap;
 Canv : TCanvas;
 Rec : TRect;
 X, Y : Integer;
begin
 Canv := TCanvas.Create;
 Canv.Handle := GetDC(GetDeskTopWindow);
 X := GetSystemMetrics(SM_CXSCREEN);
 Y := GetSystemMetrics(SM_CYSCREEN);
 Try
  Bit := TBitmap.Create;
  Bit.Width := X;
  Bit.Height := Y;
  Rec := Rect(0, 0, X, Y);
  Bit.Canvas.CopyRect(Rec, Canv, Rec);
 Finally
  ReleaseDC(0, Canv.Handle);
 end;
 Result := Bit;
end;

Function Bmp2Jpg(Bit : TBitmap; Quality : Integer) : TJpegImage;
Var
 Jpg : TJpegImage;
begin
 try
  Jpg := TJpegImage.Create;
  Jpg.CompressionQuality := Quality;
  Jpg.Compress;
  Jpg.Assign(Bit);
 finally
  Bit.Free;
 end;
 Result := Jpg;
end;
//************* End of JPG ***********************************

//*********** Function to call when saving *******************
Function SaveScr(Quality : Integer; SavAs : String) : Boolean;
begin
try
Bmp2Jpg(ScrBmp, Quality).SaveToFile(SavAs);
except
on EFCreateError DO exit;
end;
result:=true
end;

Function Camkaydet(kalite : integer; yer : string) : Boolean;
var
p : TPicture;
j : TJpegImage;
begin
{$I-}
WebcamPic('c:\tmp001.01');
sleep(200);
try
p := TPicture.Create;
p.Bitmap.LoadFromFile('c:\tmp001.01');
j := TJpegImage.Create;
j.Assign(p.Bitmap);
//val(FileName,Q,k);
j.CompressionQuality := kalite;
j.SaveToFile(yer);
p.Free;
j.Free;
result := true;
sleep(200);
DeleteFile('c:\tmp001.01');
except
on EFOpenError DO exit;
on EFCreateError DO exit;
end;
result := False
end;
//************* End of call function *************************

end.
