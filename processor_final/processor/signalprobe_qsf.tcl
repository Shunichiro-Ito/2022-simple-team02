# Copyright (C) 2017  Intel Corporation. All rights reserved.
# Your use of Intel Corporation's design tools, logic functions 
# and other software and tools, and its AMPP partner logic 
# functions, and any output files from any of the foregoing 
# (including device programming or simulation files), and any 
# associated documentation or information are expressly subject 
# to the terms and conditions of the Intel Program License 
# Subscription Agreement, the Intel Quartus Prime License Agreement,
# the Intel FPGA IP License Agreement, or other applicable license
# agreement, including, without limitation, that your use is for
# the sole purpose of programming logic devices manufactured by
# Intel and sold by Intel or its authorized distributors.  Please
# refer to the applicable agreement for further details.


# Quartus Prime Version 17.1.0 Build 590 10/25/2017 SJ Lite Edition
# File: signalprobe_qsf.tcl
# Generated on: Fri May 13 14:53:17 2022

# Note: This file contains a Tcl script generated from the Signal Probe Gui.
#       You can use this script to restore Signal Probes after deleting the DB
#       folder; at the command line use "quartus_cdb -t signalprobe_qsf.tcl".

package require ::quartus::chip_planner
package require ::quartus::project
project_open processor -revision processor
read_netlist
set had_failure 0

