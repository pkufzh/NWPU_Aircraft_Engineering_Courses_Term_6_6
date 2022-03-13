echo off
set LOCALHOST=%COMPUTERNAME%
set KILL_CMD="D:\ANSYS\ANSYSI~1\v182\fluent/ntbin/win64/winkill.exe"

"D:\ANSYS\ANSYSI~1\v182\fluent\ntbin\win64\tell.exe" NWPUFZH 2436 CLEANUP_EXITING
if /i "%LOCALHOST%"=="NWPUFZH" (%KILL_CMD% 14964) 
if /i "%LOCALHOST%"=="NWPUFZH" (%KILL_CMD% 15740) 
if /i "%LOCALHOST%"=="NWPUFZH" (%KILL_CMD% 16060) 
if /i "%LOCALHOST%"=="NWPUFZH" (%KILL_CMD% 15888) 
if /i "%LOCALHOST%"=="NWPUFZH" (%KILL_CMD% 6020) 
if /i "%LOCALHOST%"=="NWPUFZH" (%KILL_CMD% 9396)
del "C:\Users\Administrator\Desktop\Teamwork_Airfoil\Airfoil_Performance\cleanup-fluent-NWPUFZH-6020.bat"
