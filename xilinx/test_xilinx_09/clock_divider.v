`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/14/2019 02:11:10 AM
// Design Name: 
// Module Name: clock_divider
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


module clock_divider #(parameter DIVISION_VALUE = 1000) (
    input wire clock,
    output reg divided_clock = 0
    );
    //localparam division_value = 1000;
    integer counter_value = 0; // 32-bit wide register bus
    
    always@(posedge clock) // sensitivity list - rising edge
    begin
        if (counter_value == DIVISION_VALUE)
        begin
            counter_value <= 0;
            divided_clock <= ~divided_clock; // invert signal
        end
        else
        begin
            counter_value <= counter_value + 1;
            divided_clock <= divided_clock;
        end
    end
endmodule
