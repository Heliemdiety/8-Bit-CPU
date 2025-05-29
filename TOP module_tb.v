`timescale 1ns/1ps

module cpu_tb;
    reg        clk;
    reg        reset;
    wire [7:0] pc_out;
    wire [8:0] instruction;
    wire [7:0] alu_res;
    wire       carry, zero, negative, overflow;

    // Instantiate the CPU
    CPU DUT (
        .clk    (clk),
        .reset  (reset),
        .pc_out (pc_out)
    );

    // Expose some internal signals for easier monitoring
    assign instruction = DUT.IM.instruction;
    assign alu_res     = DUT.ALU.result;
    assign carry       = DUT.ALU.carry;
    assign zero        = DUT.ALU.zero;
    assign negative    = DUT.ALU.negative;
    assign overflow    = DUT.ALU.overflow;

    // Clock generator: 10 ns period
    always #5 clk = ~clk;

    integer i;
    initial begin
        $dumpfile("cpu_tb.vcd");
        $dumpvars(0, cpu_tb);

        clk   = 0;
        reset = 1;
        #12;             // holding reset for a little over one cycle

        reset = 0;       // release reset; PC = 0 now valid
        #15;            // let CPU run for 15 ns (1.5 cycle)

        // Display header
        $display("\nTime\tPC  Instr   ALU  C Z N V  R0 R1 R2 R3 R4 R5 R6 R7");
        $display("--------------------------------------------------------");

        // Display internal values over several clock cycles
        repeat (10) begin
            #10;  // sample every 10 ns
            $write("%0dns\t%0d\t%09b  %02h   %b %b %b %b  ",
                   $time, pc_out, instruction, alu_res,
                   carry, zero, negative, overflow);
            for (i = 0; i < 8; i = i + 1) begin
                $write("%02h ", DUT.RF.registers[i]);
            end
            $display("");
        end

        $finish;
    end
endmodule
