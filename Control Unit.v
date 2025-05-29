module control_unit (
    input  wire [8:0] instruction,     // 9-bit instruction input
    output reg  [2:0] src_reg,         // Source register address
    output reg  [2:0] dest_reg,        // Destination register address
    output reg  [2:0] alu_op,          // ALU operation code (3-bit now)
    output reg  write_enable           // Enable signal for register write
);

    // Define ALU operation codes
    localparam OP_ADD = 3'b000;
    localparam OP_SUB = 3'b001;
    localparam OP_AND = 3'b010;
    localparam OP_OR  = 3'b011;
    localparam OP_XOR = 3'b100;
    localparam OP_NOT = 3'b101;
    localparam OP_ASL = 3'b110;  // Arithmetic Shift Left
    localparam OP_ASR = 3'b111;  // Arithmetic Shift Right

    always @(*) begin
    
        dest_reg = instruction[5:3];
        src_reg  = instruction[2:0];


        case (instruction[8:6])
            OP_ADD: begin alu_op = OP_ADD; write_enable = 1'b1; end
            OP_SUB: begin alu_op = OP_SUB; write_enable = 1'b1; end
            OP_AND: begin alu_op = OP_AND; write_enable = 1'b1; end
            OP_OR:  begin alu_op = OP_OR;  write_enable = 1'b1; end
            OP_XOR: begin alu_op = OP_XOR; write_enable = 1'b1; end
            OP_NOT: begin alu_op = OP_NOT; write_enable = 1'b1; end
            OP_ASL: begin alu_op = OP_ASL; write_enable = 1'b1; end
            OP_ASR: begin alu_op = OP_ASR; write_enable = 1'b1; end
            default: begin alu_op = OP_ADD; write_enable = 1'b0; end
        endcase
    end

endmodule


// [8:6] → ALU operation (3 bits)
// [5:3] → Destination register (3 bits)
// [2:0] → Source register (3 bits)
// so for data, first 3 bits will tell you what operation to perform, next 3 bits will tell you the destination and the next 3 bits will tell you source register.
