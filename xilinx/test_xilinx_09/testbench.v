`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Stewart Nash
// 
// Create Date: 12/31/2019 09:16:40 AM
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
    
    always #10 clock = ~clock; // Invert clock signal every 10 nanoseconds.
    initial
    begin
        #100 switch[15:0] = 488;
    end
endmodule
