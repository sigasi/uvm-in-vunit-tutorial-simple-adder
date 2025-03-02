# Demo: UVM test in VUnit

This project demonstrates how to run a Universal Verification
Methodology (UVM) test in VUnit. An
[article](https://insights.sigasi.com/tech/vunit-uvm/) discusses this project on
[Sigasi Insights](https://insights.sigasi.com/tech/).

UVM: https://vunit.github.io/index.html

VUnit: https://www.accellera.org/downloads/standards/uvm

Note that VUnit 4.6.1rc0 or newer is required for this project. See
instructions in `run.py` in case your VUnit setup is older.

`run.py` assumes that you're using Aldec Riviera PRO as your
simulator. Other simulators require small changes to the script. We've
tried to simulate with Cadence Xcelium, unfortunately the simulation
hangs at/after the end of the UVM test (probably a limitation of the
current Cadence integration in VUnit).

This project is based on (and is a fork of) [this Github UVM
project](https://github.com/naragece/uvm-testbench-tutorial-simple-adder).

### How to run VUnit tests:

You need:
* [Python 3](https://www.python.org/)
* VUnit 4.6.1rc0 or newer. You can install VUnit in Python with `python -m pip install vunit-hdl`, but at the time of writing, the newest released version of VUnit was 4.6.0. Alternatively, you can download VUnit from [Github](https://github.com/VUnit/vunit) and enable it as documented in `run.py`.
* A simulator which is supported by VUnit and which supports VHDL and SystemVerilog. Aldec ActiveHDL and RivieraPRO, Mentor/Siemens Questa, and Cadence Incisive/Xcelium are supported (but not that we weren't successful with the latter). Make sure to set up your simulator license before running VUnit tests.

Run the tests:
* From the command line: `python run.py`
* In Sigasi Studio: [see documentation in the manual](https://insights.sigasi.com/manual/vunit/#run-vunit-tests)

### How to import the project in Sigasi Studio (XPRT license required):

* In Sigasi Studio, select **File > Import... > Sigasi > Import a VUnit project > Next**
* Browse for the `run.py` script and click **Finish**
* Open `simpleadder_top_tb.sv`. You'll notice missing include files on lines 3 and 4
* In the Common Libraries folder of your project, add a linked folder named `vunit_include` to `VUNIT/verilog/include`

![Add VUnit include folder to Common Libraries](img/uvmunit_linked1_plus.png?raw=true)
* In the editor, on line 3 of `simpleadder_top_tb.sv`, click the error-with-lightbulb icon and use the quick fix **Add `Common Libraries/vunit_include` to include paths**

![Quick fix for VUnit includes](img/uvmunit_qf1.png?raw=true)
* Add another linked folder to Common Libraries, linking to your copy of the UVM library. Most likely, your simulator comes with a copy, so you don't need to download it yourself. E.g., Riviera PRO has a copy in the `vlib` subfolder of the installation folder.

![Add UVM library to Common Libraries](img/uvmunit_linked2_plus.png?raw=true)
* In the editor, on line 4 of `simpleadder_top_tb.sv`, use the quick fix again to add the UVM includes.

![Quick fix for UVM includes](img/uvmunit_qf2.png?raw=true)
* And that's it, your project is now fully configured.
