#NoEnv
#Warn
#SingleInstance Force
#MaxHotkeysPerInterval 99000000
#HotkeyInterval 99000000
#KeyHistory 0
CoordMode, Pixel, Screen
CoordMode, Mouse, Screen
ListLines Off
SendMode Input
SetKeyDelay, -1, -1
SetMouseDelay, -1
SetDefaultMouseSpeed, 0
SetWinDelay, -1
SetControlDelay, -1


Diretorio_Image = Hur.png


F1::
;	ImageSearch, FoundX, FoundY, A_ScreenWidth - 168, 0, A_ScreenWidth, A_ScreenHeight + 410, %Diretorio_Image%
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, *65, %Diretorio_Image%
	if (ErrorLevel = 2)
	{
		MsgBox Não foi possível realizar a pesquisa. (Errorlevel = 2)
	}
	if (ErrorLevel = 1)
	{
		MsgBox Não foi encontrada a imagem (ErrorLevel = 1)
	}
	if (ErrorLevel = 0)
	{
		MsgBox Imagem foi encontrada na posição %FoundX%, %FoundY%
		MouseMove, %FoundX%+2, %FoundY%+2
	}
return