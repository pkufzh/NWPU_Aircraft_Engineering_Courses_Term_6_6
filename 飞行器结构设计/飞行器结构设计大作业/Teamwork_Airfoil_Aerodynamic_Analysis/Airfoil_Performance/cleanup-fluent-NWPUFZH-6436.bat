echo off
set LOCALHOST=%COMPUTERNAME%
set KILL_CMD="D:\ANSYS\ANSYSI~1\v182\fluent/ntbin/win64/winkill.exe"

"D:\ANSYS\ANSYSI~1\v182\fluent\ntbin\win64\tell.exe" NWPUFZH 2151 CLEANUP_EXITING
if /i "%LOCALHOST%"=="NWPUFZH" (%KILL_CMD% 2204) 
if /i "%LOCALHOST%"=="NWPUFZH" (%KILL_CMD% 2664) 
if /i "%LOCALHOST%"=="NWPUFZH" (%KILL_CMD% 620) 
if /i "%LOCALHOST%"=="NWPUFZH" (%KILL_CMD% 13180) 
if /i "%LOCALHOST%"=="NWPUFZH" (%KILL_CMD% 6436) 
if /i "%LOCALHOST%"=="NWPUFZH" (%KILL_CMD% 16200)
del "C:\Users\Administrator\Desktop\Teamwork_Airfoil\Airfoil_Performance\cleanup-fluent-NWPUFZH-6436.bat"
