module vedic_8bits (
	// Inputs
	input  wire [7:0] A,
	input  wire [7:0] B,
	// Outputs
    output wire [15:0] Q
);
	
	// Muls inst. outputs
	wire [7:0] q0;
	wire [7:0] q1;
	wire [7:0] q2;
	wire [7:0] q3;

	// Partial Products
	wire [7:0] pp0;
	wire [11:0] pp1;

	// Multiply Each Corresponding 4bits using 4bits insts.
	vedic_4bits v0 (
		.A(A[3:0]),
		.B(B[3:0]),
		.Q(q0)
	);	
	vedic_4bits v1 (
		.A(A[7:4]),
		.B(B[3:0]),
		.Q(q1)
	);
	vedic_4bits v2 (
		.A(A[3:0]),
		.B(B[7:4]),
		.Q(q2)
	);
	vedic_4bits v3 (
		.A(A[7:4]),
		.B(B[7:4]),
		.Q(q3)
	);

	// Generating Partial Products
	assign pp0     =  q1          + {4'b0000,q0[7:4]};
	assign pp1     = {q3,4'b0000} + {4'b0000,q2};
	// Generating Result
	assign Q[3:0]  = q0[3:0];
	assign Q[15:4] = pp0 + pp1;

endmodule