; Установщик HHsim (русская версия) для Windows со встроенным GNU Octave.
; Собирается скриптом packaging/windows/build.sh (makensis работает и на Linux).

Unicode true
SetCompressor /SOLID lzma
SetCompressorDictSize 64
RequestExecutionLevel user
ManifestDPIAware true

!ifndef VERSION
  !define VERSION "3.7-ru"
!endif
!ifndef STAGE
  !define STAGE "stage"
!endif
!ifndef OUTFILE
  !define OUTFILE "HHsim-${VERSION}-Windows-Installer.exe"
!endif

!define APPNAME "HHsim"
!define UNINSTKEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\HHsim"

Name "HHsim ${VERSION}"
Caption "Установка HHsim ${VERSION}"
OutFile "${OUTFILE}"
; Путь без пробелов и кириллицы: GNU Octave надёжнее всего работает из такого каталога.
InstallDir "C:\HHsim"
InstallDirRegKey HKCU "Software\HHsim" "InstallDir"

!include "MUI2.nsh"
!define MUI_ICON "${STAGE}\hhsim\hhsim.ico"
!define MUI_UNICON "${STAGE}\hhsim\hhsim.ico"
!define MUI_WELCOMEPAGE_TEXT "Программа установит HHsim — графический симулятор Ходжкина–Хаксли (русская версия).$\r$\n$\r$\nВместе с HHsim устанавливается свободная среда GNU Octave, в которой работает программа. MATLAB не нужен.$\r$\n$\r$\nПрава администратора не требуются."
!define MUI_FINISHPAGE_RUN
!define MUI_FINISHPAGE_RUN_TEXT "Запустить HHsim"
!define MUI_FINISHPAGE_RUN_FUNCTION LaunchHHsim

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "${STAGE}\hhsim\LICENSE.txt"
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_LANGUAGE "Russian"

!macro HHsimShortcut path
  SetOutPath "$INSTDIR\hhsim"   ; рабочий каталог ярлыка: там лежит start_hhsim.m
  CreateShortcut "${path}" "$SYSDIR\wscript.exe" '"$INSTDIR\octave\octave.vbs" --no-gui --quiet --norc --eval start_hhsim' "$INSTDIR\hhsim\hhsim.ico" 0 SW_SHOWMINIMIZED "" "HHsim — симулятор Ходжкина–Хаксли"
!macroend

Section "HHsim и GNU Octave" SecMain
  SectionIn RO
  SetOutPath "$INSTDIR\octave"
  File /r "${STAGE}\octave\*"
  SetOutPath "$INSTDIR\hhsim"
  File /r "${STAGE}\hhsim\*"

  DetailPrint "Настройка GNU Octave..."
  nsExec::ExecToLog '"$INSTDIR\octave\post-install.bat"'
  DetailPrint "Обновление кэша шрифтов (может занять минуту)..."
  nsExec::ExecToLog '"$INSTDIR\octave\fc_update.bat"'

  CreateDirectory "$SMPROGRAMS\HHsim"
  !insertmacro HHsimShortcut "$SMPROGRAMS\HHsim\HHsim.lnk"
  CreateShortcut "$SMPROGRAMS\HHsim\Руководство HHsim.lnk" "$INSTDIR\hhsim\code\help\guide.html"
  CreateShortcut "$SMPROGRAMS\HHsim\Удалить HHsim.lnk" "$INSTDIR\uninstall.exe"

  WriteRegStr HKCU "Software\HHsim" "InstallDir" "$INSTDIR"
  WriteRegStr HKCU "${UNINSTKEY}" "DisplayName" "HHsim ${VERSION}"
  WriteRegStr HKCU "${UNINSTKEY}" "DisplayVersion" "${VERSION}"
  WriteRegStr HKCU "${UNINSTKEY}" "Publisher" "David S. Touretzky et al. (русская версия)"
  WriteRegStr HKCU "${UNINSTKEY}" "DisplayIcon" "$INSTDIR\hhsim\hhsim.ico"
  WriteRegStr HKCU "${UNINSTKEY}" "UninstallString" '"$INSTDIR\uninstall.exe"'
  WriteRegStr HKCU "${UNINSTKEY}" "QuietUninstallString" '"$INSTDIR\uninstall.exe" /S'
  WriteRegDWORD HKCU "${UNINSTKEY}" "NoModify" 1
  WriteRegDWORD HKCU "${UNINSTKEY}" "NoRepair" 1
  WriteUninstaller "$INSTDIR\uninstall.exe"
SectionEnd

Section "Ярлык на рабочем столе" SecDesktop
  !insertmacro HHsimShortcut "$DESKTOP\HHsim.lnk"
SectionEnd

Function LaunchHHsim
  ExecShell "" "$SMPROGRAMS\HHsim\HHsim.lnk"
FunctionEnd

Section "Uninstall"
  Delete "$DESKTOP\HHsim.lnk"
  RMDir /r "$SMPROGRAMS\HHsim"
  RMDir /r "$INSTDIR\octave"
  RMDir /r "$INSTDIR\hhsim"
  Delete "$INSTDIR\uninstall.exe"
  RMDir "$INSTDIR"
  DeleteRegKey HKCU "${UNINSTKEY}"
  DeleteRegKey HKCU "Software\HHsim"
SectionEnd
