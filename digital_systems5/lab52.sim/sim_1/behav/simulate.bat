@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.3\\bin
call %xv_path%/xsim tb_code_mgr_behav -key {Behavioral:sim_1:Functional:tb_code_mgr} -tclbatch tb_code_mgr.tcl -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
