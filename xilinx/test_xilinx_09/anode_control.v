`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/14/2019 09:27:37 AM
// Design Name: 
// Module Name: anode_control
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


module anode_control(
    input [1:0] refresh_count,
    output reg [3:0] anode = 0
    );
    
    always@(refresh_count)
    begin
        case (refresh_count)
            2'b00:
                anode = 4'b1110; // digit 1 on (right-most)
            2'b01:
                anode = 4'b1101; // digit 2 on
            2'b10:
                anode = 4'b1011; // digit 3 on
            2'b11:
                anode = 4'b0111; // digit 4 on (left-most)
        endcase
    end
endmodule
