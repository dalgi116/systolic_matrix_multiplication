`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: FEE, CTU in Prague
// Engineer: Daniel Franc

// Create Date: 19.10.2025 12:13:26
// Design Name: matrix_multiplier
// Module Name: main4x4_tb
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


module main4x4_tb;
    reg clk, reset, start;
    reg [15:0]
        a00, a01, a02, a03,
        a10, a11, a12, a13,
        a20, a21, a22, a23,
        a30, a31, a32, a33;
    reg [15:0]
        b00, b01, b02, b03,
        b10, b11, b12, b13,
        b20, b21, b22, b23,
        b30, b31, b32, b33;
    wire [33:0]
        sop00, sop01, sop02, sop03,
        sop10, sop11, sop12, sop13,
        sop20, sop21, sop22, sop23,
        sop30, sop31, sop32, sop33;
    
    main4x4 uut(
        clk, reset, start,

        a00, a01, a02, a03,
        a10, a11, a12, a13,
        a20, a21, a22, a23,
        a30, a31, a32, a33,

        b00, b01, b02, b03,
        b10, b11, b12, b13,
        b20, b21, b22, b23,
        b30, b31, b32, b33,

        sop00, sop01, sop02, sop03,
        sop10, sop11, sop12, sop13,
        sop20, sop21, sop22, sop23,
        sop30, sop31, sop32, sop33
    );
    
    initial begin
        clk = 1'b0;
        reset = 1'b0;
        start = 1'b0;
        
        {a00, a01, a02, a03,
        a10, a11, a12, a13,
        a20, a21, a22, a23,
        a30, a31, a32, a33} = 256'd0;
        
        {b00, b01, b02, b03,
        b10, b11, b12, b13,
        b20, b21, b22, b23,
        b30, b31, b32, b33} = 256'd0; 
    end
    
    always #10 clk = ~clk;
    
    initial begin
        #20;
        a00 = 16'd0; a01 = 16'd1; a02 = 16'd2; a03 = 16'd3;
        a10 = 16'd4; a11 = 16'd5; a12 = 16'd6; a13 = 16'd7;
        a20 = 16'd0; a21 = 16'd1; a22 = 16'd2; a23 = 16'd3;
        a30 = 16'd4; a31 = 16'd5; a32 = 16'd6; a33 = 16'd7;
        #20;
        b00 = 16'd2;  b01 = 16'd3;  b02 = 16'd4;  b03 = 16'd5;
        b10 = 16'd6; b11 = 16'd7; b12 = 16'd8; b13 = 16'd9;
        b20 = 16'd2; b21 = 16'd3; b22 = 16'd4; b23 = 16'd5;
        b30 = 16'd6; b31 = 16'd7; b32 = 16'd8; b33 = 16'd9;

        #20 start = 1'b1;
        #40 reset = 1'b1;
        #30 reset = 1'b0;
        #20 start = 1'b0;
        
        #60;
        a00 = 16'd0; a01 = 16'd1; a02 = 16'd2; a03 = 16'd3;
        a10 = 16'd4; a11 = 16'd5; a12 = 16'd6; a13 = 16'd7;
        a20 = 16'd8; a21 = 16'd9; a22 = 16'd10; a23 = 16'd11;
        a30 = 16'd12; a31 = 16'd13; a32 = 16'd14; a33 = 16'd15;
        #20;
        b00 = 16'd2;  b01 = 16'd3;  b02 = 16'd4;  b03 = 16'd5;
        b10 = 16'd6; b11 = 16'd7; b12 = 16'd8; b13 = 16'd9;
        b20 = 16'd10; b21 = 16'd11; b22 = 16'd12; b23 = 16'd13;
        b30 = 16'd14; b31 = 16'd15; b32 = 16'd16; b33 = 16'd17;
        
        #200 start = 1'b1;
        #20 start = 1'b0;
   end
   
   initial begin
        #1000;
        
        $finish;
   end 
endmodule
