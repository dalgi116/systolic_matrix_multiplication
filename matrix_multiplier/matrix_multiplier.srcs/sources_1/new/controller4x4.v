`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: FEE, CTU in Prague
// Engineer: Daniel Franc
//
// Create Date: 11.10.2025 17:12:50
// Design Name: matrix_multiplier
// Module Name: controller4x4
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


module controller4x4(
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
    output reg done, clear,
    output reg [15:0] a0, a1, a2, a3, b0, b1, b2, b3
    );
    
    reg [1:0] state;
    reg [2:0] load_cycle;
    parameter
        IDLE = 2'b00,
        START = 2'b01,
        LOAD = 2'b10,
        END = 2'b01;
    
    always @(posedge clk) begin
        if (reset) begin
            done <= 1'b0;
            clear <= 1'b0;
            {a0, a1, a2, a3, b0, b1, b2, b3} <= 128'd0;
            load_cycle <= 3'd0;
            state <= IDLE;
        end else begin
            case(state)
                IDLE:
                    begin
                        done <= 1'b0;
                        clear <= 1'b0;
                        {a0, a1, a2, a3, b0, b1, b2, b3} <= 128'd0;
                        load_cycle <= 3'd0;
                        state <= (start)? START : IDLE;
                    end
                START:
                    begin
                        done <= 1'b0;
                        clear <= 1'b1;
                        {a0, a1, a2, a3, b0, b1, b2, b3} <= 128'd0;
                        load_cycle <= 3'd0;
                        state <= LOAD;
                    end
                LOAD:
                    begin
                        done <= 1'b0;
                        clear <= 1'b0;
                        case(load_cycle)
                            3'd0: begin
                                a0<=a30; a1<=16'd0; a2<=16'd0; a3<=16'd0;
                                b0<=b03; b1<=16'd0; b2<=16'd0; b3<=16'd0;
                            end
                            3'd1: begin
                                a0<=a20; a1<=a31; a2<=16'd0; a3<=16'd0;
                                b0<=b02; b1<=b13; b2<=16'd0; b3<=16'd0;
                            end
                            3'd2: begin
                                a0<=a10; a1<=a21; a2<=a32; a3<=16'd0;
                                b0<=b01; b1<=b12; b2<=b23; b3<=16'd0;
                            end
                            3'd3: begin
                                a0<=a00; a1<=a11; a2<=a22; a3<=a33;
                                b0<=b00; b1<=b11; b2<=b22; b3<=b33;
                            end
                            3'd4: begin
                                a0<=16'd0; a1<=a01; a2<=a12; a3<=a23;
                                b0<=16'd0; b1<=b10; b2<=b21; b3<=b32;
                            end
                            3'd5: begin
                                a0<=16'd0; a1<=16'd0; a2<=a02; a3<=a13;
                                b0<=16'd0; b1<=16'd0; b2<=b20; b3<=b31;
                            end
                            3'd6: begin
                                a0<=16'd0; a1<=16'd0; a2<=16'd0; a3<=a03;
                                b0<=16'd0; b1<=16'd0; b2<=16'd0; b3<=b30;
                            end
                            3'd7:begin
                                    {a0, a1, a2, a3, b0, b1, b2, b3} <= 128'd0;
                                    state <= END;
                            end
                            default: begin
                                    {a0, a1, a2, a3, b0, b1, b2, b3} <= 128'd0;
                                    load_cycle <= 3'd0;
                            end
                        endcase
                        load_cycle <= (load_cycle == 3'd7)? 3'd0 : load_cycle + 3'd1;
                    end
                END:
                    begin
                        done <= 1'b1;
                        clear <= 1'b0;
                        {a0, a1, a2, a3, b0, b1, b2, b3} <= 128'd0;
                        load_cycle <= 3'd0;
                        state <= IDLE;
                    end
                default:
                    begin
                        done <= 1'b0;
                        clear <= 1'b0;
                        {a0, a1, a2, a3, b0, b1, b2, b3} <= 128'd0;
                        load_cycle <= 3'd0;
                        state <= IDLE;
                    end
            endcase
        end
    end
endmodule
