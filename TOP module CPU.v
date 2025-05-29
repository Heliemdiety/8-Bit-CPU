module CPU (
    input wire clk,
    input wire reset,
    output wire [7:0] pc_out      
);

// initializing all the things that i used in my other modules 
wire [7:0] pc_current;
wire [7:0] pc_next;
wire pc_enable;
wire [8:0] instruction;

wire [2:0] opcode;
wire [2:0] dest_reg;             // address of register to write data
wire [2:0] src_reg;              // address of register to read data

wire [2:0] alu_op;      
wire write_enable;

wire [7:0] rf_data1;        // read_data1 (from dest_reg)
wire [7:0] rf_data2;        // read_data2 (from src_reg)
wire [7:0] alu_result; 

wire carry;
wire zero;
wire negative;
wire overflow;

// connecting the modules with toplevel module

assign pc_enable = 1'b1;      // always increment
assign pc_next = pc_out + 8'b00000001;   // next pc = current pc + 1

program_counter PC(
    .clk (clk),
    .reset(reset),
    .pc_enable(pc_enable),          // always enable increment
    .pc_next(pc_next),
    .pc(pc_out)            // i used pc variable in program counter module hence connected it with pc_current in this module 
);

instruction_memory IM(
    .pc_address (pc_out),
    .instruction (instruction)
);

control_unit CU (
    .instruction (instruction),
    .write_enable (write_enable),
    .alu_op (alu_op),
    .src_reg(),
    .dest_reg()
    // src_reg and dest_reg will be provided by decoder
);

register RF (
    .clk         (clk),
    .write_enable(write_enable),
    .read_reg1   (dest_reg),    // A input = RF[dest_reg]
    .read_reg2   (src_reg),     // B input = RF[src_reg]
    .write_reg   (dest_reg),    // write back into dest_reg
    .write_data  (alu_result),
    .read_data1  (rf_data1),
    .read_data2  (rf_data2)
);

ALU ALU(
    .a (rf_data1),
    .b (rf_data2),
    .opcode (alu_op),
    .result (alu_result),
    .carry(carry),
    .zero(zero),
    .negative(negative),
    .overflow(overflow)
);

instruction_decoder Decod (
        .instruction (instruction),
        .opcode      (opcode),
        .dest_reg    (dest_reg),
        .src_reg     (src_reg)
    );

endmodule