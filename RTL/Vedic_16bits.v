module vedic_16bits (
	// Inputs
	input  wire [15:0] A,
	input  wire [15:0] B,
	// Outputs
    output wire [31:0] Q
);
	
	// Muls inst. outputs
	wire [15:0] q0;
	wire [15:0] q1;
	wire [15:0] q2;
	wire [15:0] q3;

	// Partial Products
	wire [15:0] pp0;
	wire [23:0] pp1;

	// Multiply Each Corresponding 4bits using 4bits insts.
	vedic_8bits v0 (
		.A(A[7:0]),
		.B(B[7:0]),
		.Q(q0)
	);	
	vedic_8bits v1 (
		.A(A[15:8]),
		.B(B[7:0]),
		.Q(q1)
	);
	vedic_8bits v2 (
		.A(A[7:0]),
		.B(B[15:8]),
		.Q(q2)
	);
	vedic_8bits v3 (
		.A(A[15:8]),
		.B(B[15:8]),
		.Q(q3)
	);

	// Generating Partial Products
	assign pp0     =  q1          + {{8{1'b0}},q0[15:8]};
	assign pp1     = {q3,{8{1'b0}}} + {{8{1'b0}},q2};
	// Generating Result
	assign Q[7:0]  = q0[7:0];
	assign Q[31:8] = pp0 + pp1;

endmodule