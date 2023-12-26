//----------------------------------------------------------------------------
//
// Author      : Jan Horn
// Email       : jhorn@global.co.za
// Website     : http://home.global.co.za/~jhorn
// Date        : 8 April 2001
// Description : A unit that used with OpenGL projects to load BMP files
// Usage       : LoadTexture(BMPFilename, TextureName);
//               eg : LoadTexture('logo.bmp', LogoTex);
//
//----------------------------------------------------------------------------
unit BMP;

interface

uses
Windows, OpenGL, classes;

function LoadTexture(Filename: String; var Texture: GLuint): Boolean;

implementation

CONST
kaynak='PSYCORE';

function gluBuild2DMipmaps(Target: GLenum; Components, Width, Height: GLint; Format, atype: GLenum; Data: Pointer): GLint; stdcall; external glu32;
procedure glGenTextures(n: GLsizei; var textures: GLuint); stdcall; external opengl32;
procedure glBindTexture(target: GLenum; texture: GLuint); stdcall; external opengl32;

{------------------------------------------------------------------}
{  Load BMP file                                                   }
{------------------------------------------------------------------}

procedure LoadBitmap(Filename: String; out Width: Cardinal; out Height: Cardinal; out pData: Pointer);
var
  res: TResourceStream;
  FileHeader: BITMAPFILEHEADER;
  InfoHeader: BITMAPINFOHEADER;
  Palette: array of RGBQUAD;
  BitmapLength: Cardinal;
  PaletteLength: Cardinal;
  Front: ^Byte;
  Back: ^Byte;
  Temp: Byte;
  I : Cardinal;
begin
  res:=TResourceStream.Create(hInstance, pchar(filename), kaynak);
  Res.ReadBuffer(FileHeader, SizeOf(FileHeader));  // FileHeader
  Res.ReadBuffer(InfoHeader, SizeOf(InfoHeader));  // InfoHeader
  PaletteLength := InfoHeader.biClrUsed;

  SetLength(Palette, PaletteLength);
  Res.ReadBuffer(Palette, PaletteLength);          // Palette

  Width := InfoHeader.biWidth;
  Height := InfoHeader.biHeight;

  BitmapLength := InfoHeader.biSizeImage;

  if BitmapLength = 0 then BitmapLength := Width * Height * InfoHeader.biBitCount Div 8;

  GetMem(pData, BitmapLength);
  Res.ReadBuffer(pData^, BitmapLength);            // Bitmap Data
  Res.Free;
  //*****

  for I :=0 to Width * Height - 1 do
  begin
    Front := Pointer(Cardinal(pData) + I*3);
    Back := Pointer(Cardinal(pData) + I*3 + 2);
    Temp := Front^;
    Front^ := Back^;
    Back^ := Temp;
  end;
end;


{------------------------------------------------------------------}
{  Load BMP textures                                               }
{------------------------------------------------------------------}
function LoadTexture(Filename: String; var Texture: GLuint): Boolean;
var
pData: Pointer;
Width: Cardinal;
Height: Cardinal;
begin
result:=false;
pData :=nil;

  LoadBitmap(Filename, Width, Height, pData);

  if (Assigned(pData)) then begin

  glGenTextures(1, Texture);
  glBindTexture(GL_TEXTURE_2D, Texture);
  glTexEnvi(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_MODULATE);  {Texture blends with object background}

  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR); { only first two can be used }
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR); { all of the above can be used }

  gluBuild2DMipmaps(GL_TEXTURE_2D, 3, Width, Height, GL_RGB, GL_UNSIGNED_BYTE, pData);
  //glTexImage2D(GL_TEXTURE_2D, 0, 3, Width, Height, 0, GL_RGB, GL_UNSIGNED_BYTE, pData);  // Use when not wanting mipmaps to be built by openGL
  freemem(pdata);
end;
end;


end.
