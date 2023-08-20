module vedic_2bits (
	// Inputs
	input  wire [1:0] A,
	input  wire [1:0] B,
	// Outputs
    output wire [3:0] Q
);
	
	wire pp[2:0];
	wire c;

	// Generating Partial Products
	assign pp[0] = A[1]  & B[0];
	assign pp[1] = A[0]  & B[1];
	assign pp[2] = A[1]  & B[1];
	assign c     = pp[0] & pp[1];
	// Generating Result
	assign Q[0] = A[0]  & B[0];
	assign Q[1] = pp[0] ^ pp[1];
	assign Q[2] = pp[2] ^ c;
	assign Q[3] = pp[2] & c;

endmodule