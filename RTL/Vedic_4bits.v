module vedic_4bits (
	// Inputs
	input  wire [3:0] A,
	input  wire [3:0] B,
	// Outputs
    output wire [7:0] Q
);
	
	// Muls inst. outputs
	wire [3:0] q0;
	wire [3:0] q1;
	wire [3:0] q2;
	wire [3:0] q3;

	// Partial Products
	wire [3:0] pp0;
	wire [5:0] pp1;

	// Multiply Each Corresponding 2bits using 2bits insts.
	// {a1,a0} * {b1,b0}
	vedic_2bits v0 (
		.A(A[1:0]),
		.B(B[1:0]),
		.Q(q0)
	);
	// {a3,a2} * {b1,b0}	
	vedic_2bits v1 (
		.A(A[3:2]),
		.B(B[1:0]),
		.Q(q1)
	);
	// {a1,a0} * {b3,b2}
	vedic_2bits v2 (
		.A(A[1:0]),
		.B(B[3:2]),
		.Q(q2)
	);
	// {a3,a2} * {b3,b2}
	vedic_2bits v3 (
		.A(A[3:2]),
		.B(B[3:2]),
		.Q(q3)
	);

	// Generating Partial Products
	assign pp0    =  q1        + {2'b00,q0[3:2]};
	assign pp1    = {q3,2'b00} + {2'b00,q2};
	// Generating Result
	assign Q[1:0] = q0[1:0];
	assign Q[7:2] = pp0 + pp1;

endmodule