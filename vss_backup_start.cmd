@echo off

REM 1. Windows VSS backup ��ȣ Ȱ��ȭ (C:\, D:\)
powershell -command Enable-ComputerRestore "c:", "d:"

REM 2. VSS backup Ƚ������ ���� 
c:\windows\system32\cmd /c c:\windows\system32\reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v SystemRestorePointCreationFrequency /t REG_DWORD /d 0 /f


REM 3. ����̺� ��� �뷮 ���� (���� 10%)
c:\windows\system32\cmd /c vssadmin resize shadowstorage /on=c: /for=c: /maxsize=10%%
c:\windows\system32\cmd /c vssadmin resize shadowstorage /on=d: /for=d: /maxsize=10%%

REM 4. ��������� ����
REM A. �� ������ ������ ��δ� C:\Domain ������ �����Ǿ� �ִ�.
REM B. �����ٷ��� ������ ������ �̸��� vss_backup_schedule.cmd�� �����Ǿ� �ִ�.
REM C. ��� �������� ���� 12:10�� 17:10���� �����Ǿ� �ִ�.
schtasks /create /tn "OS�������� ���-1��" /tr C:\Domain\vss_backup_schedule.cmd /sc daily /st 12:10 /f
schtasks /create /tn "OS�������� ���-2��" /tr C:\Domain\vss_backup_schedule.cmd /sc daily /st 17:10 /f




