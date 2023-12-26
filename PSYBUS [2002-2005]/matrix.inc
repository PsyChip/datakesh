'$Include "c:\matrix\desktop\StayOnTop.inc"

Declare Sub Sleep Lib "kernel32" alias "Sleep" (ByVal dwMilliseconds As Long)
Declare Function GetAsyncKeyState Lib "user32" alias "GetAsyncKeyState" (ByVal vKey As Long) As Integer

declare sub imleç
declare sub CloseMatrix
declare sub denetle
declare sub k0

dim matrix1 as qtimer
matrix1.enabled = false
matrix1.interval = 100
matrix1.ontimer = denetle

dim matrix2 as qtimer
matrix2.enabled = false
matrix2.interval = 1000
matrix2.ontimer = imleç

Sub k0
matrix2.enabled = false
end sub

dim font1 as qfont
font1.name = "Terminal"
Font1.color = rgb(0,255,0)
font1.size = 18

dim i as integer
dim satir as integer
satir = 20

CREATE matrix AS QFORM
'WindowState = AlwaysOnTop
Width = screen.width
Height = screen.height
color = 0
keypreview = 1
onkeypress = k0
borderstyle = bsnone
Center
CREATE Canvas1 AS QCANVAS
     color = 0
     font = font1
     cursor = crnone     
     Left = 0
     Top = 0
     Width = matrix.width
     Height = screen.height-50
 CREATE NOKTA AS QCANVAS
     HEIGHT = 25
     WIDTH = 15
     END CREATE
     END CREATE
 CREATE panel as qedit
     borderstyle = bsnone
     color = 0
     Text = ""
     font = font1
     top = canvas1.height
     left = 0     
     maxLength = 100
     height = 100
     width = screen.width
     end create
END CREATE

sub denetle
if GetAsyncKeyState(13) then
if panel.text = "" then
matrix2.enabled = true
exit sub
else
canvas1.Textout(30,satir,ucase$(panel.text),&H00FF00, 0)
NOKTA.top = str$(satir)
satir = satir+25
i = STR$(LEN(panel.text))
if i = 1 then i = i+1
if i = 2 then i = i+1
if i = 3 then i = i+1
if i = 4 then i = i+1
i = i * 20
NOKTA.left = i
end if
if nokta.top > canvas1.Height - 50 then
NOKTA.TOP = 20
satir = 20
CANVAS1.repaint
canvas1.Textout(30,satir,ucase$(panel.text),&H00FF00, 0)
satir = satir+25
end if
panel.text = ""
matrix2.enabled = true
END if
end sub

sub imleç
nokta.FillRect 0,0 ,matrix.ClientWidth,matrix.ClientHeight,rgb(0,255,0)
sleep 500
nokta.FillRect 0,0 ,matrix.ClientWidth,matrix.ClientHeight, rgb(0,0,0)
end sub

matrix.showmodal