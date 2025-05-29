module instruction_memory (
    input wire [7:0] pc_address,    // Address from program counter (0-255)
    output reg [8:0] instruction    // 9-bit instruction output
);

    reg [8:0] memory [0:255]; //  memory array with 256 instructions each having 9 bits

    integer i;
    initial begin
        
// first 3 bits will indicate what operation to perform, next 3 bits will indicate location of Register 0, then next 3 bits will indicate location of Register 1.
        memory[0] = 9'b000_000_001; // ADD  R0, R1  
        memory[1] = 9'b001_010_011; // SUB  R2, R3
        memory[2] = 9'b010_001_100; // AND  R1, R4
        memory[3] = 9'b011_011_010; // OR   R3, R2
        memory[4] = 9'b100_000_001; // XOR  R0, R1
        memory[5] = 9'b101_001_000; // NOT  R1
        memory[6] = 9'b110_010_000; // SHL  R2
        memory[7] = 9'b111_011_000; // SHR  R3

        // Fill rest of memory with NOP (e.g., ADD R0, R0)
        for (i = 8; i < 256; i = i + 1) begin
            memory[i] = 9'b000_000_000;
        end
    end

    always @(*) begin
        instruction = memory[pc_address]; // fetching the instruction at pc_address
    end

endmodule


// here i have used hardcoded instructions ,, i can also create a program.hex file which can
// store these instructions ,,and then use $readmemh("program.hex", memory),, and all the 
// instructions that i saved in .hex will be loaded 
