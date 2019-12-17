`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/14/2019 02:24:22 AM
// Design Name: 
// Module Name: testbench
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


module testbench;
reg clock = 0;
reg [15:0] switch = 0;
wire [3:0] anode;
wire [7:0] cathode;

top UUT(
    clock,
    switch,
    anode,
    cathode
    );
    
    always #5 clock = ~clock; // invert clock signal every 5 nanoseconds
    initial
    begin
        #100 switch[3:0] = 4;
        #1000 switch[7:4] = 8;
        #1900 switch[11:8] = 5;
    end
endmodule
