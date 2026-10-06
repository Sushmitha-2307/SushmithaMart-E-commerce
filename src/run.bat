@echo off
setlocal

set "PROJECT=C:\Users\saara\OneDrive\Desktop\SushmithaMart\sushmithamart"
set "TOMCAT=C:\Users\saara\Downloads\apache-tomcat-10.1.59-windows-x64\apache-tomcat-10.1.59"

echo ========================================
echo       SushmithaMart - RUN
echo ========================================
echo.

if "%~1"=="" (
    echo Usage:
    echo.
    echo run login
    echo run home
    echo run products
    echo run cart
    echo run orders
    echo run checkout
    echo run database
    echo.
    pause
    exit /b
)

set "PAGE=%~1"

echo [1] Going to project folder...
cd /d "%PROJECT%"

if errorlevel 1 (
    echo.
    echo PROJECT FOLDER NOT FOUND!
    echo.
    pause
    exit /b 1
)

echo.
echo [2] Building project...
call mvn clean package

if errorlevel 1 (
    echo.
    echo ========================================
    echo BUILD FAILED!
    echo ========================================
    echo.
    pause
    exit /b 1
)

echo.
echo [3] Checking WAR file...

if not exist "%PROJECT%\target\sushmithamart.war" (
    echo.
    echo WAR FILE NOT FOUND!
    echo.
    pause
    exit /b 1
)

echo WAR file found.

echo.
echo [4] Stopping Tomcat...

call "%TOMCAT%\bin\shutdown.bat" >nul 2>&1

timeout /t 5 /nobreak >nul

echo.
echo [5] Copying WAR to Tomcat...

copy /Y "%PROJECT%\target\sushmithamart.war" "%TOMCAT%\webapps\sushmithamart.war"

if errorlevel 1 (
    echo.
    echo ========================================
    echo WAR COPY FAILED!
    echo ========================================
    echo.
    pause
    exit /b 1
)

echo.
echo WAR COPY SUCCESSFUL.

echo.
echo [6] Starting Tomcat...

call "%TOMCAT%\bin\startup.bat"

echo.
echo [7] Waiting for Tomcat...

timeout /t 10 /nobreak >nul

echo.
echo [8] Opening requested page...

if /I "%PAGE%"=="login" (
    start "" "http://localhost:8080/sushmithamart/login.jsp"
    goto done
)

if /I "%PAGE%"=="home" (
    start "" "http://localhost:8080/sushmithamart/index.jsp"
    goto done
)

if /I "%PAGE%"=="products" (
    start "" "http://localhost:8080/sushmithamart/products.jsp"
    goto done
)

if /I "%PAGE%"=="cart" (
    start "" "http://localhost:8080/sushmithamart/cart"
    goto done
)

if /I "%PAGE%"=="orders" (
    start "" "http://localhost:8080/sushmithamart/orders.jsp"
    goto done
)

if /I "%PAGE%"=="checkout" (
    start "" "http://localhost:8080/sushmithamart/checkout.jsp"
    goto done
)

if /I "%PAGE%"=="database" (
    start "" "http://localhost:8080/sushmithamart/db-test"
    goto done
)

echo.
echo ========================================
echo Unknown page: %PAGE%
echo ========================================
echo.
echo Available commands:
echo.
echo run login
echo run home
echo run products
echo run cart
echo run orders
echo run checkout
echo run database
echo.
pause
exit /b 1


:done

echo.
echo ========================================
echo      %PAGE% PAGE OPENED
echo ========================================
echo.
echo SushmithaMart is running on Tomcat.
echo.

pause