import sys
## VUnit 4.6.1 (or release candidate e.g. 4.6.1rc0, or higher) required
## If your VUnit is older than that, download a new version from https://github.com/VUnit/vunit
## Then, enable the next line of this script and have the path point at your downloaded vunit
#sys.path.insert(0,"/path/to/downloaded/vunit/")
from vunit import VUnit
import os

# Select simulator
os.environ["VUNIT_SIMULATOR"] = "rivierapro"

## We've been unable to run the simulation with Cadence Xcelium, see README.md
# os.environ["VUNIT_SIMULATOR"] = "incisive"

# Create VUnit instance by parsing command line arguments
vu = VUnit.from_argv(compile_builtins=False)
vu.add_vhdl_builtins()
vu.add_verilog_builtins()

# Create library 'lib'
lib = vu.add_library("lib")

# Add design to library
lib.add_source_files([
   "simpleadder.v", "simpleadder_top_tb.sv",  # the SystemVerilog design and testbench
   "vhdl_adder.vhd", "vhdl_adder_tb.sv"       # the VHDL design and its testbench
   ])

# For Aldec Riviera PRO
lib.add_compile_option("rivierapro.vlog_flags", ["-uvm"])

# For Cadence Incisive/Xcelium (see remark above)
# lib.add_compile_option("incisive.irun_verilog_flags", ["-uvmhome CDNS-IEEE", "-uvmnocdnsextra", "+define+UVM_NO_DPI"])

# Run vunit function
vu.main()
