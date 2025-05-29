module ALU (
    input wire [7:0] a,
    input wire [7:0] b,
    input wire [2:0] opcode,      // opcode (3 bits = 8 opcodes)
    output reg [7:0] result,
    output reg carry,
    output reg zero,         // zero flag.
    output reg negative,
    output reg overflow
);

always @(*) begin 

    // default
    carry = 1'b0;
    result = 8'h00;
    zero = 1'b0;
    negative = 1'b0; 
    overflow = 1'b0;
    
    case (opcode)
        3'b000 : begin 
            {carry,result} = a + b;                            // addition 
            overflow = (a[7] == b[7]) && (result[7] != a[7]);  // overflow management
        end       
        3'b001 : begin 
            {carry,result} = a - b;                            // subtraction
            carry = (a < b) ? 1'b1 : 1'b0;  // borrow flag
            overflow =  (a[7] != b[7]) && (result[7] != a[7]);      
        end      
        3'b010 : begin result = a & b; end       // AND
        3'b011 : begin result = a | b; end       // OR   
        3'b100 : begin result = a ^ b; end       // XOR
        3'b101 : begin result = ~a;    end       // NOT
        3'b110 : begin result = a <<< 1; carry = a[7]; end      // arithematic left shift (to preserve sign)
        3'b111 : begin result = a >>> 1; carry = a[0]; end      // arithematic right shift
        default: begin result = 8'h00; carry =1'b0; end       // default to 0 
    endcase

    zero = (result == 8'b00000000) ? 1 : 0;  // zero flag , if result is 0 then zero flag is 1 else zero = 0
    negative = result[7];     // negative flag (MSB represents the sign in 2's complement , if msb is 1, negative = 1,  if msb = 0 , negative = 0)
      
end
endmodule 
