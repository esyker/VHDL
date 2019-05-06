@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.3\\bin
call %xv_path%/xelab  -wto 6eaea4eb58c440f9863a129dfc282b1c -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot tb_code_mgr_behav xil_defaultlib.tb_code_mgr -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
