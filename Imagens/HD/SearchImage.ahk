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
; [ LIBRARY ]
#Include U:\LibAHK\GDIP64.ahk
#Include U:\LibAHK\Gdip_ImageSearch.ahk ; (this is masterfocus' gdip_imagesearch.ahk)

Diretorio_Image = SSA.png


F1::
	ImageSearch, FoundX, FoundY, A_ScreenWidth - 388, 0, A_ScreenWidth, A_ScreenHeight + 460, %Diretorio_Image%
;	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, *45, %Diretorio_Image%
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



GdipImageSearch(ImagePNG, variation, X1=0,Y1=0,X2=0,Y2=0) {
GLOBAL

	Gdip_disposeImage( Bitmap_ObsStudio )	;limpa memoria
	Gdip_disposeImage( SearchImage )		;limpa memoria
	Gdip_disposeImage( ImageMacro )		;limpa memoria
	
	WinMaximize, %ObsWinExist%
	Bitmap_ObsStudio := Gdip_BitmapFromHWND( WinExist(ObsWinExist) )	;gera o bitmap do OBS Studio
	if (Bitmap_ObsStudio == 0 && WinExist(ObsWinExist) == 0) {
		ToolTip,[PT-BR] Nao foi possivel encontrar a tela projetada do OBS Studio. `n[EN] OBS Studio Windowed Projector NOT FOUND. `n [ERROR] 13
		Sleep 150
		RETURN -123
	}
	
	;Verifica se jÃ¡ escolheu a resolucao (HD / FULL HD / WideScreen)
	if (Resolution == 0) {
		ImageMacro := Gdip_createBitmapFromFile("Imagens\" . ImagePNG)	;Needle de acordo com ImagePNG - verificando resolution
	} else {
		ImageMacro := Gdip_createBitmapFromFile("Imagens\" . Resolution . "\" . ImagePNG)	;Needle de acordo com ImagePNG - resolution verificada
	}

	SearchImage := Gdip_imageSearch( Bitmap_ObsStudio,ImageMacro, xy, X1,Y1,X2,Y2, variation,,1,0 )	;pesquisa Bitmap ImageMacro no OBS Studio
	RETURN %SearchImage%
	;SearchImage RETURN 1 = ENCONTROU
	;SearchImage RETURN 0 = NAO ENCONTROU
}