`include "simpleadder_pkg.sv"
`include "simpleadder_if.sv"
`include "vunit_defines.svh"
`include "uvm_macros.svh"

module vhdl_adder_tb;
   import uvm_pkg::*;
   import simpleadder_pkg::*;

   //Interface declaration
   simpleadder_if vif();

   //Connects the Interface to the DUT
   vhdl_adder dut(.clk(vif.sig_clock),
      .en_i(vif.sig_en_i),
      .ina(vif.sig_ina),
      .inb(vif.sig_inb),
      .en_o(vif.sig_en_o),
      .outp(vif.sig_out)
   );

   // Clock generator 
   always
   #5 vif.sig_clock = ~vif.sig_clock;

   `TEST_SUITE begin
         `TEST_SUITE_SETUP begin
            // UVM can't control the end of the simulation, VUnit does that
            uvm_root root;
            root = uvm_root::get();
            root.set_finish_on_completion(0);

            //Registers the Interface in the configuration block so that other
            //blocks can use it
            uvm_resource_db#(virtual simpleadder_if)::set
            (.scope("ifs"), .name("simpleadder_if"), .val(vif));
         end

         `TEST_CASE_SETUP begin
            vif.sig_clock <= 1;
         end

         `TEST_CASE("Adder UVM test") begin
            run_test("simpleadder_test");
         end

         `TEST_CASE_CLEANUP begin
            uvm_report_server server;
            server = uvm_report_server::get_server();
            `CHECK_EQUAL(server.get_severity_count(UVM_ERROR), 0);
            `CHECK_EQUAL(server.get_severity_count(UVM_FATAL), 0);
         end
      end

endmodule