`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/14/2019 09:39:44 AM
// Design Name: 
// Module Name: bcd_cathode
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


module bcd_cathode(
    input [3:0] digit,
    output reg [7:0] cathode = 0
    );
    
    always@(digit)
    begin
        case(digit)
            4'd0:
                cathode = 8'b1100_0000;
            4'd1:
                cathode = 8'b1111_1001;
            4'd2:
                cathode = 8'b1010_0100;
            4'd3:
                cathode = 8'b1011_0000;
            4'd4:
                cathode = 8'b1001_1001;
            4'd5:
                cathode = 8'b1001_0010;
            4'd6:
                cathode = 8'b1000_0010;
            4'd7:
                cathode = 8'b1111_1000;
            4'd8:
                cathode = 8'b1000_0000;
            4'd9:
                cathode = 8'b1001_0000;
            default:
                cathode = 8'b1100_0000;                                                                
        endcase
    end
endmodule
