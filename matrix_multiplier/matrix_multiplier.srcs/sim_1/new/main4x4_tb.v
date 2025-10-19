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
    
    main4x4 main(
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
        a00 = 16'd1; a01 = 16'd2; a02 = 16'd3; a03 = 16'd4;
        a10 = 16'd5; a11 = 16'd6; a12 = 16'd7; a13 = 16'd8;
        a20 = 16'd9; a21 = 16'd10; a22 = 16'd11; a23 = 16'd12;
        a30 = 16'd13; a31 = 16'd14; a32 = 16'd15; a33 = 16'd16;
        
        #20;
        
        b00 = 16'd6;  b01 = 16'd7;  b02 = 16'd8;  b03 = 16'd9;
        b10 = 16'd10; b11 = 16'd11; b12 = 16'd12; b13 = 16'd13;
        b20 = 16'd14; b21 = 16'd15; b22 = 16'd16; b23 = 16'd17;
        b30 = 16'd18; b31 = 16'd19; b32 = 16'd20; b33 = 16'd21;

        #20;
        
        start = 1'b1;
        
        #40;
        
        start = 1'b0;
        reset = 1'b1;
        
        #30;
        
        start = 1'b1;
        
        #20;
        
        start = 1'b0;
   end
   
   initial begin
        #400;
        
        $finish;
   end 
endmodule
