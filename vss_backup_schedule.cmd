@echo off
:: vss_backup_start.cmd 파일에서 등록하는 스케줄러로 인해 동작되는 파일입니다.

echo.
echo 복원 지점을 설정합니다.
echo 작업 소요시간은 약 30초 입니다.
echo.
echo 사용 용도는 아래와 같습니다.
echo 1. 사용자 시스템 복원 (Shift + 시스템 종료 클릭)
echo 2. 복원 지점에서의 파일 복원 (Shadow Explorer 활용)

wmic.exe /Namespace:\\root\default Path SystemRestore Call CreateRestorePoint "RestorePointName", 100, 7 2>&1>nul
