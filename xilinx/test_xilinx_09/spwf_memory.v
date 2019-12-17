`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/14/2019 07:07:26 PM
// Design Name: 
// Module Name: spwf_memory
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


module spwf_memory(
        clock,
        write_enable,
        enable,
        address,
        data_in,
        data_out
    );
    input clock;
    input write_enable;
    input enable;    
    input [9:0] address;
    input [15:0] data_in;
    output [15:0] data_out;
    reg [15:0] RAM [1023:0];
    reg [15:0] data_out;
    
    always@(posedge clock)
    begin
        if (enable)
        begin
            if (write_enable)
                begin
                    RAM[address] <= data_in;
                    data_out <= data_in;
                end            
            else
                data_out <= RAM[address];
        end
    end
endmodule
