@echo off
setlocal
pushd .

for /f "usebackq delims=" %%x in (`wsl echo ${DISPLAY}`)         do set DISPLAY=%%x
for /f "usebackq delims=" %%x in (`wsl echo ${WAYLAND_DISPLAY}`) do set WAYLAND_DISPLAY=%%x
for /f "usebackq delims=" %%x in (`wsl echo ${XDG_RUNTIME_DIR}`) do set XDG_RUNTIME_DIR=%%x
for /f "usebackq delims=" %%x in (`wsl echo ${PULSE_SERVER}`)    do set PULSE_SERVER=%%x
for /f "usebackq delims=" %%x in (`wsl echo ${WSL_DISTRO_NAME}`) do set WSL_DISTRO_NAME=%%x

> docker-compose.yml echo version: '3'
>>docker-compose.yml echo services:
>>docker-compose.yml echo   app:
>>docker-compose.yml echo     build: .
>>docker-compose.yml echo     environment:
>>docker-compose.yml echo       - DISPLAY=%DISPLAY%
>>docker-compose.yml echo       - WAYLAND_DISPLAY=%WAYLAND_DISPLAY%
>>docker-compose.yml echo       - XDG_RUNTIME_DIR=%XDG_RUNTIME_DIR%
>>docker-compose.yml echo       - PULSE_SERVER=%PULSE_SERVER%
>>docker-compose.yml echo     volumes:
>>docker-compose.yml echo       - type: bind
>>docker-compose.yml echo         source: \\wsl.localhost\%WSL_DISTRO_NAME%\tmp\.X11-unix
>>docker-compose.yml echo         target: /tmp/.X11-unix
>>docker-compose.yml echo       - type: bind
>>docker-compose.yml echo         source: \\wsl.localhost\%WSL_DISTRO_NAME%\mnt\wslg
>>docker-compose.yml echo         target: /mnt/wslg

popd
endlocal
