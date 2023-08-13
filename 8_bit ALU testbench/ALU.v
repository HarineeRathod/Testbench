
module ALU(
    input [7:0] a,
    input [7:0] b,
    input [2:0] opcode,
    output reg [7:0] result,
    output reg zero,
    output reg carry,
    output reg overflow
);

// Declare internal signals
reg [8:0] temp;

// Compute result based on opcode
always @(*) begin

	
    case (opcode)
        3'b000: result = a & b; // AND operation
		  
        3'b001: result = a | b; // OR operation
		  
        3'b010: result = a + b; // ADD operation
		  
        3'b011: result = a - b; // SUB operation
		  
        3'b100: result = a << b; // Left shift operation
		  
        3'b101: result = a >> b; // Right shift operation
		  
        3'b110: result = ~a; // NOT operation
		  
        3'b111: result = a ^ b; // XOR operation
		  
        default: result = 8'b0;
    endcase
end

// Compute zero flag
always @(*) begin
    zero = (result == 8'b0);
end

// Compute carry flag
always @(*) begin
    temp = a + b;
    carry = (temp[8] == 1);
end

// Compute overflow flag
always @(*) begin
	if(a[7]==b[7])
	begin
    overflow = (temp[7] != a[7]);
	 end
end

endmodule

