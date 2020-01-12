`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/14/2019 09:32:52 AM
// Design Name: 
// Module Name: bcd_control
// Project Name: 
// Target Devices: 
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


module hex_control(
    input [3:0] digit_1, // right digit
    input [3:0] digit_2,
    input [3:0] digit_3,
    input [3:0] digit_4, // left digit
    input [1:0] refresh_count,
    output reg [3:0] digit = 0
    );
    
    always@(refresh_count)
    begin
        case(refresh_count)
            2'd0:
                digit = digit_1; // right-most digit
            2'd1:
                digit = digit_2;
            2'd2:
                digit = digit_3;
            2'd3:
                digit = digit_4; // left-most digit
        endcase
    end    
endmodule
