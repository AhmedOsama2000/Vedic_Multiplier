module vedic_32bits_tb;
	
	reg  [31:0] A_tb;
	reg  [31:0] B_tb;
    wire [63:0] Q_tb;

    vedic_32bits DUT (
    	.A(A_tb),
    	.B(B_tb),
    	.Q(Q_tb)
    );

    integer i;
    reg [63:0] mul_res;

    initial begin
    	
    	for (i = 0;i < 50;i = i + 1) begin
    		A_tb = $random;
    		B_tb = $random;
    		#1
    		chk_mul(A_tb,B_tb);
    	end
    	#5
    	$stop;

    end

    task chk_mul (input [31:0] i0, input [31:0] i1);
    	begin
    		mul_res = i0 * i1;
    		if (mul_res == Q_tb) begin
    			$display("Correct_Case");
    		end
    		else begin
    			$display("Incorrect_Case");
    		end
    	end
    endtask

endmodule