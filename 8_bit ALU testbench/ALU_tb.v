module ALU_tb();

reg [7:0] a,b;
reg [2:0]opcode;
wire [7:0]result;
wire carry,zero,overflow;

integer i;

ALU tb(
.a(a),
.b(b),
.opcode(opcode),
.zero(zero),
.carry(carry),
.overflow(overflow),
.result(result));

integer golden_result;
integer golden_carry;
integer golden_zero;
integer golden_overflow;

initial begin





 for (i = 0; i < 10; i=i+1)
 begin
         // Generate random inputs
         a = $random;
         b = $random;
         opcode = $urandom_range(0, 8);
         #10;
			
 end

$monitor("Test %0d :a=%0d,b=%0d",i,a,b);

// initialising the golden output
case (opcode)
            3'b000: golden_result = a&b; 
            3'b001: golden_result = a|b;
            3'b010: golden_result = a+b;
            3'b011: golden_result = a-b;
            3'b100: golden_result = a<<b;
            3'b101: golden_result = a>>b;
            3'b110: golden_result = ~a;
            3'b111: golden_result =  a^b;
				default: golden_result=0; 
endcase


// initialising golden flag

golden_carry=((opcode==3'b010) && ((a+b) > 8'hFF));
golden_zero=(golden_result==0);
golden_overflow=((a[7]==b[7])&&(a[7]!=golden_result[7]));


// making sure that seed value is different every time




 // if the golden_result != result
 if(golden_result!=result||golden_carry!=carry||golden_zero!=zero||golden_overflow!=overflow)
  begin
	 $monitor("Test %0d failed: Expected result=%0d, carry=%0d, overflow=%0d, zero=%0d, Actual result=%0d, carry=%0d, overflow=%0d, zero=%0d", 
               i, golden_result, golden_carry, golden_overflow,golden_zero,result,carry, overflow, zero);
					
	end
	
   else 
	begin
				
          $monitor("Test %0d passed: Expected result=%0d, carry=%0d, overflow=%0d, zero=%0d, Actual result=%0d, carry=%0d, overflow=%0d, zero=%0d", 
               i, golden_result, golden_carry, golden_overflow,golden_zero,result,carry, overflow, zero);
			
   end
 
end
endmodule

