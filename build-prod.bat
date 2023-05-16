echo off

echo .
echo ==========================================================================================
echo      Jeyzer Production build
echo ==========================================================================================
echo .

rem == DOCKER MAVEN PROFILE ==
rem Test Docker availability
set DOCKER_MODE=-PdockerMode
docker.exe 2> NUL
if %ERRORLEVEL% EQU 9009 (
  echo Docker not found : related Maven profile will not be loaded
  set DOCKER_MODE=
)

rem == JAVA BUILD VERSION  ==
rem JDK is taken from PATH. Javadoc requires JAVA_HOME to be set
rem Jeyzer and IzPack installer targets are JDK8+ 

set PATH=C:\Dev\programs\Java\Amazon-correto\jdk11.0.6_10\bin;%PATH%
set JAVA_HOME=C:\Dev\programs\Java\Amazon-correto\jdk11.0.6_10

rem For testing reference only. We do not need those. 

rem set PATH=C:\Dev\programs\Java\Amazon-correto\jdk1.8.0_242\bin;%PATH%
rem set JAVA_HOME=C:\Dev\programs\Java\Amazon-correto\jdk1.8.0_242

rem set PATH=C:\Dev\programs\Java\Oracle\jdk-11.0.6\bin;%PATH%
rem set JAVA_HOME=C:\Dev\programs\Java\Oracle\jdk-11.0.6

rem set PATH=C:\Dev\programs\Java\Oracle\jdk1.8.0_241\bin;%PATH%
rem set JAVA_HOME=C:\Dev\programs\Java\Oracle\jdk1.8.0_241


rem == MAVEN BUILD ==
rem display Maven and Java versions
call mvn -v

rem productionMode = Vaadin production profile 
mvn clean install -PproductionMode %DOCKER_MODE% -Dmaven.test.skip=true
