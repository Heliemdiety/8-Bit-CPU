// This module takes a 9-bit instruction as input
// and decodes it into opcode, destination register, and source register.

module instruction_decoder (
    input wire [8:0] instruction,   // 9-bit instruction input
    output wire [2:0] opcode,       // bits [8:6] - ALU operation
    output wire [2:0] dest_reg,     // bits [5:3] - destination register
    output wire [2:0] src_reg       // bits [2:0] - source register
);

    // Extract the opcode (top 3 bits)
    assign opcode = instruction[8:6];

    // Extract the destination register (middle 3 bits)
    assign dest_reg = instruction[5:3];

    // Extract the source register (lowest 3 bits)
    assign src_reg = instruction[2:0];

endmodule
