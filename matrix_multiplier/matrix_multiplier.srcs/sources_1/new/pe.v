`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: FEE, CTU in Prague
// Engineer: Daniel Franc
// 
// Create Date: 11.10.2025 12:14:33
// Design Name: matrix_multiplier
// Module Name: pe
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


module pe(
    input wire clk, reset, clear,
    input wire [15:0] in_a, in_b,
    output reg [15:0] out_a, out_b,
    output reg [33:0] sop
    );
    
    always @(posedge clk) begin
        if (reset || clear) begin
            out_a <= 16'd0;
            out_b <= 16'd0;
            sop <= 34'd0;
        end else begin
            out_a <= in_a;
            out_b <= in_b;
            sop <= sop + in_a * in_b;
        end
    end
endmodule
