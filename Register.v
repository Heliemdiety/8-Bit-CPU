module register (
    input wire clk,                // Clock signal (for synchronous writing)
    input wire write_enable,          // Write enable signal
    input wire [2:0] read_reg1,    // Address to read 1st register (3 bits = 0 to 7)
    input wire [2:0] read_reg2,    // Address to read 2nd register (3 bits = 0 to 7)
    input wire [2:0] write_reg,    // where to write data 
    input wire [7:0] write_data,   // the data that has to be written 
    output wire [7:0] read_data1,  // Data read from read_reg1
    output wire [7:0] read_data2   // Data read from read_reg2
);

    // 8 registers, each 8-bit wide (indexed from 0 to 7)
    reg [7:0] registers [7:0];

// zero initialize every register at time 0 ,, otherwise  i was getting xxxxxxxx values in all registers
    integer i;
    initial begin 
        for(i=0; i<8; i=i+1)
            registers[i] = 8'b0;
    end

    assign read_data1 = registers[read_reg1];  // Read data from register at read_reg1
    assign read_data2 = registers[read_reg2];  // Read data from register at read_reg2

    always @(posedge clk) begin
        if (write_enable) begin
            registers[write_reg] <= write_data; // write_data at location of write_reg
        end
    end

endmodule



