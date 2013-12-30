Name Bytecoin

RequestExecutionLevel highest
SetCompressor /SOLID lzma

# General Symbol Definitions
!define REGKEY "SOFTWARE\$(^Name)"
!define VERSION 1.0.0.$WCREV$
!define COMPANY "Bytecoin project"
!define URL http://www.byte-coin.org/

# MUI Symbol Definitions
!define MUI_ICON "../share/pixmaps/bytecoin.ico"
!define MUI_WELCOMEFINISHPAGE_BITMAP "..\share\pixmaps\nsis-wizard.bmp"
!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_RIGHT
!define MUI_HEADERIMAGE_BITMAP "..\share\pixmaps\nsis-header.bmp"
!define MUI_FINISHPAGE_NOAUTOCLOSE
!define MUI_STARTMENUPAGE_REGISTRY_ROOT HKLM
!define MUI_STARTMENUPAGE_REGISTRY_KEY ${REGKEY}
!define MUI_STARTMENUPAGE_REGISTRY_VALUENAME StartMenuGroup
!define MUI_STARTMENUPAGE_DEFAULTFOLDER Bytecoin
!define MUI_FINISHPAGE_RUN $INSTDIR\bytecoin-qt.exe
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\modern-uninstall.ico"
!define MUI_UNWELCOMEFINISHPAGE_BITMAP "..\share\pixmaps\nsis-wizard.bmp"
!define MUI_UNFINISHPAGE_NOAUTOCLOSE

# Included files
!include Sections.nsh
!include MUI2.nsh

# Variables
Var StartMenuGroup

# Installer pages
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_STARTMENU Application $StartMenuGroup
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES

# Installer languages
!insertmacro MUI_LANGUAGE Afrikaans
!insertmacro MUI_LANGUAGE Albanian
!insertmacro MUI_LANGUAGE Arabic
!insertmacro MUI_LANGUAGE Basque
!insertmacro MUI_LANGUAGE Belarusian
!insertmacro MUI_LANGUAGE Bosnian
!insertmacro MUI_LANGUAGE Breton
!insertmacro MUI_LANGUAGE Bulgarian
!insertmacro MUI_LANGUAGE Catalan
!insertmacro MUI_LANGUAGE Croatian
!insertmacro MUI_LANGUAGE Czech
!insertmacro MUI_LANGUAGE Danish
!insertmacro MUI_LANGUAGE Dutch
!insertmacro MUI_LANGUAGE English
!insertmacro MUI_LANGUAGE Esperanto
!insertmacro MUI_LANGUAGE Estonian
!insertmacro MUI_LANGUAGE Farsi
!insertmacro MUI_LANGUAGE Finnish
!insertmacro MUI_LANGUAGE French
!insertmacro MUI_LANGUAGE Galician
!insertmacro MUI_LANGUAGE German
!insertmacro MUI_LANGUAGE Greek
!insertmacro MUI_LANGUAGE Hebrew
!insertmacro MUI_LANGUAGE Hungarian
!insertmacro MUI_LANGUAGE Icelandic
!insertmacro MUI_LANGUAGE Indonesian
!insertmacro MUI_LANGUAGE Irish
!insertmacro MUI_LANGUAGE Italian
!insertmacro MUI_LANGUAGE Japanese
!insertmacro MUI_LANGUAGE Korean
!insertmacro MUI_LANGUAGE Kurdish
!insertmacro MUI_LANGUAGE Latvian
!insertmacro MUI_LANGUAGE Lithuanian
!insertmacro MUI_LANGUAGE Luxembourgish
!insertmacro MUI_LANGUAGE Macedonian
!insertmacro MUI_LANGUAGE Malay
!insertmacro MUI_LANGUAGE Mongolian
!insertmacro MUI_LANGUAGE Norwegian
!insertmacro MUI_LANGUAGE NorwegianNynorsk
!insertmacro MUI_LANGUAGE Polish
!insertmacro MUI_LANGUAGE Portuguese
!insertmacro MUI_LANGUAGE PortugueseBR
!insertmacro MUI_LANGUAGE Romanian
!insertmacro MUI_LANGUAGE Russian
!insertmacro MUI_LANGUAGE Serbian
!insertmacro MUI_LANGUAGE SerbianLatin
!insertmacro MUI_LANGUAGE SimpChinese
!insertmacro MUI_LANGUAGE Slovak
!insertmacro MUI_LANGUAGE Slovenian
!insertmacro MUI_LANGUAGE Spanish
!insertmacro MUI_LANGUAGE SpanishInternational
!insertmacro MUI_LANGUAGE Swedish
!insertmacro MUI_LANGUAGE Thai
!insertmacro MUI_LANGUAGE TradChinese
!insertmacro MUI_LANGUAGE Turkish
!insertmacro MUI_LANGUAGE Ukrainian
!insertmacro MUI_LANGUAGE Uzbek
!insertmacro MUI_LANGUAGE Welsh

# Installer attributes
OutFile bytecoin-${VERSION}-win32-setup.exe
InstallDir $PROGRAMFILES\Bytecoin
CRCCheck on
XPStyle on
BrandingText " "
ShowInstDetails show
VIProductVersion ${VERSION}
VIAddVersionKey ProductName Bytecoin
VIAddVersionKey ProductVersion "${VERSION}"
VIAddVersionKey CompanyName "${COMPANY}"
VIAddVersionKey CompanyWebsite "${URL}"
VIAddVersionKey FileVersion "${VERSION}"
VIAddVersionKey FileDescription ""
VIAddVersionKey LegalCopyright ""
InstallDirRegKey HKCU "${REGKEY}" Path
ShowUninstDetails show

# Installer sections
Section -Main SEC0000
    SetOutPath $INSTDIR
    SetOverwrite on
    File ..\release\bytecoin-qt.exe
    File /oname=COPYING.txt ..\COPYING
#    File /oname=readme.txt ..\doc\README_windows.txt
    SetOutPath $INSTDIR\daemon
    File ..\release\bytecoind.exe
    SetOutPath $INSTDIR\src
    File /r /x *.exe /x *.o /x *.qm /x *.a /x *.in /x *.bak ../src\*.*
    SetOutPath $DOCUMENTS\Bytecoin
    SetOverwrite off
    File bytecoin.conf
    SetOverwrite on
    SetOutPath $DOCUMENTS
    File /r BytecoinMiner
    SetOverwrite off
    SetOutPath $DOCUMENTS\BytecoinMiner
    File ����ڿ�.bat
    SetOverwrite on
    SetOutPath $INSTDIR
    WriteRegStr HKCU "${REGKEY}\Components" Main 1

    # Remove old wxwidgets-based-bytecoin executable and locales:
    Delete /REBOOTOK $INSTDIR\bytecoin.exe
    RMDir /r /REBOOTOK $INSTDIR\locale
SectionEnd

Section -post SEC0001
    WriteRegStr HKCU "${REGKEY}" Path $INSTDIR
    SetOutPath $INSTDIR
    WriteUninstaller $INSTDIR\uninstall.exe
    !insertmacro MUI_STARTMENU_WRITE_BEGIN Application
    CreateDirectory $SMPROGRAMS\$StartMenuGroup
    CreateShortcut "$SMPROGRAMS\$StartMenuGroup\Bytecoin.lnk" $INSTDIR\bytecoin-qt.exe
    CreateShortcut "$SMPROGRAMS\$StartMenuGroup\Uninstall Bytecoin.lnk" $INSTDIR\uninstall.exe
		CreateShortCut "$DESKTOP\$(^Name).lnk" $INSTDIR\bytecoin-qt.exe
#		CreateShortCut "$DESKTOP\$(^Name)-testnet.lnk" $INSTDIR\bytecoin-qt.exe "-testnet" $INSTDIR\bytecoin-qt.exe 1
    !insertmacro MUI_STARTMENU_WRITE_END
    WriteRegStr HKCU "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" DisplayName "$(^Name)"
    WriteRegStr HKCU "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" DisplayVersion "${VERSION}"
    WriteRegStr HKCU "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" Publisher "${COMPANY}"
    WriteRegStr HKCU "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" URLInfoAbout "${URL}"
    WriteRegStr HKCU "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" DisplayIcon $INSTDIR\uninstall.exe
    WriteRegStr HKCU "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" UninstallString $INSTDIR\uninstall.exe
    WriteRegDWORD HKCU "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" NoModify 1
    WriteRegDWORD HKCU "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" NoRepair 1
    WriteRegStr HKCR "bytecoin" "URL Protocol" ""
    WriteRegStr HKCR "bytecoin" "" "URL:Bytecoin"
    WriteRegStr HKCR "bytecoin\DefaultIcon" "" $INSTDIR\bytecoin-qt.exe
    WriteRegStr HKCR "bytecoin\shell\open\command" "" '"$INSTDIR\bytecoin-qt.exe" "%1"'
SectionEnd

# Macro for selecting uninstaller sections
!macro SELECT_UNSECTION SECTION_NAME UNSECTION_ID
    Push $R0
    ReadRegStr $R0 HKCU "${REGKEY}\Components" "${SECTION_NAME}"
    StrCmp $R0 1 0 next${UNSECTION_ID}
    !insertmacro SelectSection "${UNSECTION_ID}"
    GoTo done${UNSECTION_ID}
next${UNSECTION_ID}:
    !insertmacro UnselectSection "${UNSECTION_ID}"
done${UNSECTION_ID}:
    Pop $R0
!macroend

# Uninstaller sections
Section /o -un.Main UNSEC0000
    Delete /REBOOTOK $INSTDIR\bytecoin-qt.exe
    Delete /REBOOTOK $INSTDIR\COPYING.txt
    Delete /REBOOTOK $INSTDIR\readme.txt
    RMDir /r /REBOOTOK $INSTDIR\daemon
    RMDir /r /REBOOTOK $INSTDIR\src
    RMDir /r /REBOOTOK $DOCUMENTS\BytecoinMiner
    DeleteRegValue HKCU "${REGKEY}\Components" Main
SectionEnd

Section -un.post UNSEC0001
    DeleteRegKey HKCU "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)"
    Delete /REBOOTOK "$SMPROGRAMS\$StartMenuGroup\Uninstall Bytecoin.lnk"
    Delete /REBOOTOK "$SMPROGRAMS\$StartMenuGroup\Bytecoin.lnk"
    Delete /REBOOTOK "$DESKTOP\$(^Name).lnk"
    Delete /REBOOTOK "$DESKTOP\$(^Name)-testnet.lnk"
    Delete /REBOOTOK "$SMSTARTUP\Bytecoin.lnk"
    Delete /REBOOTOK $INSTDIR\uninstall.exe
    Delete /REBOOTOK $INSTDIR\debug.log
    Delete /REBOOTOK $INSTDIR\db.log
    DeleteRegValue HKCU "${REGKEY}" StartMenuGroup
    DeleteRegValue HKCU "${REGKEY}" Path
    DeleteRegKey /IfEmpty HKCU "${REGKEY}\Components"
    DeleteRegKey /IfEmpty HKCU "${REGKEY}"
    DeleteRegKey HKCR "bytecoin"
    RmDir /REBOOTOK $SMPROGRAMS\$StartMenuGroup
    RmDir /REBOOTOK $INSTDIR
    Push $R0
    StrCpy $R0 $StartMenuGroup 1
    StrCmp $R0 ">" no_smgroup
no_smgroup:
    Pop $R0
SectionEnd

# Installer functions
Function .onInit
    InitPluginsDir
FunctionEnd

# Uninstaller functions
Function un.onInit
    ReadRegStr $INSTDIR HKCU "${REGKEY}" Path
    !insertmacro MUI_STARTMENU_GETFOLDER Application $StartMenuGroup
    !insertmacro SELECT_UNSECTION Main ${UNSEC0000}
FunctionEnd
