`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: FEE, CTU in Prague
// Engineer: Daniel Franc
// 
// Create Date: 11.10.2025 14:25:04
// Design Name: matrix_multiplier
// Module Name: matmult4x4
// Project Name: systolic_matrix_multiplication
// Target Devices: FPGA Cora Z7 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module matmult4x4(
    input wire clk, reset, clear,
    input wire [15:0] a0, a1, a2, a3, b0, b1, b2, b3,
    output wire [33:0]
        sop00, sop01, sop02, sop03,
        sop10, sop11, sop12, sop13,
        sop20, sop21, sop22, sop23,
        sop30, sop31, sop32, sop33
    );
    
    wire [15:0]
        a00, a01, a02,
        a10, a11, a12,
        a20, a21, a22,
        a30, a31, a32;
    
    wire [15:0]
        b00, b01, b02, b03,
        b10, b11, b12, b13,
        b20, b21, b22, b23;
    
    wire [15:0] unused;
    
    pe pe00(clk, reset, clear, a0, b0, a00, b00, sop00);
    pe pe01(clk, reset, clear, a00, b1, a01, b01, sop01);
    pe pe02(clk, reset, clear, a01, b2, a02, b02, sop02);
    pe pe03(clk, reset, clear, a02, b3, unused, b03, sop03);
    pe pe10(clk, reset, clear, a1, b00, a10, b10, sop10);
    pe pe11(clk, reset, clear, a10, b01, a11, b11, sop11);
    pe pe12(clk, reset, clear, a11, b02, a12, b12, sop12);
    pe pe13(clk, reset, clear, a12, b03, unused, b13, sop13);
    pe pe20(clk, reset, clear, a2, b10, a20, b20, sop20);
    pe pe21(clk, reset, clear, a20, b11, a21, b21, sop21);
    pe pe22(clk, reset, clear, a21, b12, a22, b22, sop22);
    pe pe23(clk, reset, clear, a22, b13, unused, b23, sop23);
    pe pe30(clk, reset, clear, a3, b20, a30, unused, sop30);
    pe pe31(clk, reset, clear, a30, b21, a31, unused, sop31);
    pe pe32(clk, reset, clear, a31, b22, a32, unused, sop32);
    pe pe33(clk, reset, clear, a32, b23, unused, unused, sop33);
endmodule
