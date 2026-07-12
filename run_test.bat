@echo off
set "JMETER_HOME=C:\Tools\apache-jmeter-5.6.3"
set "TESTPLAN=E:\jmeter-perf-lab\test-plans\dummyjson-login.jmx"
set "RESULTDIR=E:\jmeter-perf-lab\results"
call "%JMETER_HOME%\bin\jmeter.bat" -n -t "%TESTPLAN%" -l "%RESULTDIR%\run1.jtl" -j "%RESULTDIR%\run1_engine.log" > "%RESULTDIR%\run1_console.txt" 2>&1
echo RUN_COMPLETE > "%RESULTDIR%\run1_status.txt"
