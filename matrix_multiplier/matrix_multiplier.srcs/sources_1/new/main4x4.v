`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: FEE, CTU in Prague
// Engineer: Daniel Franc

// Create Date: 19.10.2025 11:55:14
// Design Name: matrix_multiplier
// Module Name: main4x4
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


module main4x4(
    input wire clk, reset, start,
    input wire [15:0]
        a00, a01, a02, a03,
        a10, a11, a12, a13,
        a20, a21, a22, a23,
        a30, a31, a32, a33,
    input wire [15:0]
        b00, b01, b02, b03,
        b10, b11, b12, b13,
        b20, b21, b22, b23,
        b30, b31, b32, b33,
    output wire [33:0]
        sop00, sop01, sop02, sop03,
        sop10, sop11, sop12, sop13,
        sop20, sop21, sop22, sop23,
        sop30, sop31, sop32, sop33
    );
    
    wire done, clear;
    wire [15:0] a0, a1, a2, a3, b0, b1, b2, b3;
   
    controller4x4 controller(
        clk, reset, start,
        
        a00, a01, a02, a03,
        a10, a11, a12, a13,
        a20, a21, a22, a23,
        a30, a31, a32, a33,
        
        b00, b01, b02, b03,
        b10, b11, b12, b13,
        b20, b21, b22, b23,
        b30, b31, b32, b33,
        
        done, clear,
        a0, a1, a2, a3, b0, b1, b2, b3
    );
    matmult4x4 matmult(
        clk, reset, clear,
        a0, a1, a2, a3, b0, b1, b2, b3,
        
        sop00, sop01, sop02, sop03,
        sop10, sop11, sop12, sop13,
        sop20, sop21, sop22, sop23,
        sop30, sop31, sop32, sop33
    );
endmodule
