@echo off

REM 1. Windows VSS backup 보호 활성화 (C:\, D:\)
powershell -command Enable-ComputerRestore "c:", "d:"

REM 2. VSS backup 횟수제한 해제 
c:\windows\system32\cmd /c c:\windows\system32\reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v SystemRestorePointCreationFrequency /t REG_DWORD /d 0 /f


REM 3. 드라이브 백업 용량 설정 (각각 10%)
c:\windows\system32\cmd /c vssadmin resize shadowstorage /on=c: /for=c: /maxsize=10%%
c:\windows\system32\cmd /c vssadmin resize shadowstorage /on=d: /for=d: /maxsize=10%%

REM 4. 백업스케쥴 생성
REM A. 두 파일을 저장할 경로는 C:\Domain 폴더로 설정되어 있다.
REM B. 스케줄러로 동작할 파일의 이름은 vss_backup_schedule.cmd로 설정되어 있다.
REM C. 백업 스케줄은 매일 12:10과 17:10으로 설정되어 있다.
schtasks /create /tn "OS복원지점 백업-1차" /tr C:\Domain\vss_backup_schedule.cmd /sc daily /st 12:10 /f
schtasks /create /tn "OS복원지점 백업-2차" /tr C:\Domain\vss_backup_schedule.cmd /sc daily /st 17:10 /f




