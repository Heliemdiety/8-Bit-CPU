module program_counter (
    input wire clk,           
    input wire reset,           
    input wire pc_enable,      
    input wire [7:0] pc_next,   // The value PC will update to (for normal increment or jump)
    output reg [7:0] pc         // The current program counter value
);

always @(posedge clk or posedge reset) begin
    if (reset)
        pc <= 8'b0;            // On reset, set PC to 0 (start of program)
    else if (pc_enable)
        pc <= pc_next;         // If enabled, update PC to next value
end

endmodule
