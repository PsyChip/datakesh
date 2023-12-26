unit gfxCore;

interface
Function SaveScr(Quality : Integer; SavAs : String) : Boolean;
function Camkaydet(kalite : integer; yer : string) : Boolean;
implementation

uses
Windows,
Classes,
untwebcam,
graphics,
Jpeg;

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
