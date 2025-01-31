:: really dumb anti-forkie script by furret :3
:: this is a big mess...
:: btw FHAAFS means Furret's Highly Aggressive Anti-Forkie Script. (i might change the name tbh)
:: and of course, everything is open source (there goes my secrets ;w;)

@echo off

net session >nul 2>&1
if %errorLevel% == 0 (
  echo FHAAFS v0.01
  echo Please wait!
  echo.
  goto start
) else (
  echo Error: Administrative permissions are required.
  pause
  exit
)

:start
  echo Applying Registry Patches...
  start /min cmd /c reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "ShutdownWithoutLogon" /t REG_DWORD /d 0 /f
  start /min cmd /c reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "HideFastUserSwitching" /t REG_DWORD /d 1 /f
  start /min cmd /c reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\Start\HideShutDown" /v "value" /t REG_DWORD /d 1 /f
  start /min cmd /c reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\Start\HideRestart" /v "value" /t REG_DWORD /d 1 /f
  start /min cmd /c reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\Start\HideSignOut" /v "value" /t REG_DWORD /d 1 /f
  start /min cmd /c reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "DontDisplayNetworkSelectionUI" /t REG_DWORD /d 1 /f
  start /min cmd /c reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoLogoff" /t REG_DWORD /d 1 /f
  start /min cmd /c reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "DisableChangePassword" /t REG_DWORD /d 1 /f
  echo Getting rid of EOA on lock...
  start /min cmd /c "takeown /f C:\Windows\system32\Utilman.exe && icacls C:\Windows\system32\Utilman.exe /grant "%username%":M && rename C:\Windows\system32\Utilman.exe ~Utilman.exe"
  echo Executing something secret...
  start /b powershell -nologo -WindowStyle Hidden -command "$wsh = New-Object -ComObject WScript.Shell;while($true){if([console]::NumberLock -eq 'True'){$wsh.Run("""rundll32.exe user32.dll,LockWorkStation""")};Start-Sleep -m 100}"
  echo Preventing guest82430 from executing that damn rat...
  start /b powershell -nologo -WindowStyle Hidden -command "while($true){$lol = Get-Process comedic -ErrorAction SilentlyContinue;if($lol){$lol | Stop-Process -Force;start mshta \"vbscript:Execute(`\"MsgBox(`\"`\"you won't be running this anymore, guest82430.`\"`\",48,`\"`\":3`\"`\")(window.close)`\")\"};Start-Sleep -m 500}"
  echo Preventing Hawk10074 from being a moron...
  start /b powershell -nologo -WindowStyle Hidden -command "while($true){$process = Get-Process regedit -ErrorAction SilentlyContinue;if($process){$process | Stop-Process -Force;start mshta \"vbscript:Execute(`\"MsgBox(`\"`\"nuh uh`\"`\",48,`\"`\":3`\"`\")(window.close)`\")\"};Start-Sleep -m 500}"
  echo Done! FHAAFS will now self-destruct!
  start /b cmd /c del "%~f0"
exit /b 0