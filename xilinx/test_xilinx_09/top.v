`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/17/2019 02:33:44 AM
// Design Name: 
// Module Name: top
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


module top(
        clock,
        switch
    );
    input clock;
    input [15:0] switch;
    wire clock;
    wire [15:0] switch;
    
    wire refresh_clock;
    wire [1:0] refresh_count;
    wire [15:0] digits;
    wire [3:0] digit;    
    wire ready;
    
    clock_divider divide_clock(
        .clock(clock),
        .divided_clock(refresh_clock)
    );
    
    refresh_counter count_refresh(
        .refresh_clock(refresh_clock),
        .refresh_count(refresh_count)
    );
    
    anode_control control_anode(
        .refresh_count(refresh_count),
        .anode(anode)
    );
    
    hex_control control_hex(
        .digit_1(digits[3:0]),
        .digit_2(digits[7:4]),
        .digit_3(digits[11:8]),
        .digit_4(digits[15:12]),
        .refresh_count(refresh_count),
        .digit(digit)
    );
    
    memory_control memory_controller(
        .clock(refresh_clock),
        .unlock(0),
        .address(9'b00_0000_0000),
        .data(switch[15:0]),
        .buffer(digits),
        .ready(ready)
    ); 
    
endmodule
