module vedic_32bits (
	// Inputs
	input  wire [31:0] A,
	input  wire [31:0] B,
	// Outputs
    output wire [63:0] Q
);
	
	// Muls inst. outputs
	wire [31:0] q0;
	wire [31:0] q1;
	wire [31:0] q2;
	wire [31:0] q3;

	// Partial Products
	wire [31:0] pp0;
	wire [47:0] pp1;

	// Multiply Each Corresponding 4bits using 4bits insts.
	vedic_16bits v0 (
		.A(A[15:0]),
		.B(B[15:0]),
		.Q(q0)
	);	
	vedic_16bits v1 (
		.A(A[31:16]),
		.B(B[15:0]),
		.Q(q1)
	);
	vedic_16bits v2 (
		.A(A[15:0]),
		.B(B[31:16]),
		.Q(q2)
	);
	vedic_16bits v3 (
		.A(A[31:16]),
		.B(B[31:16]),
		.Q(q3)
	);

	// Generating Partial Products
	assign pp0      =  q1             + {{16{1'b0}},q0[31:16]};
	assign pp1      = {q3,{16{1'b0}}} + {{16{1'b0}},q2};
	// Generating Result
	assign Q[15:0]  = q0[15:0];
	assign Q[63:16] = pp0 + pp1;

endmodule