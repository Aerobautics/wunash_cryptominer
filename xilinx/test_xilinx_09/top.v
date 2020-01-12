`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Stewart Nash
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
        switch,
        anode,
        cathode
    );
    input clock;
    input [15:0] switch;
    output [3:0] anode;
    output [7:0] cathode;
    
    wire clock;
    wire [15:0] switch;
    wire [3:0] anode;
    wire [7:0] cathode;
    
    wire refresh_clock;
    wire [1:0] refresh_count;
    wire [15:0] digits;
    wire [3:0] digit;    
    wire ready;
    
    reg lock = 0;
    reg [9:0] address_buffer = 10'b00_0000_0000;
    
    wire clock_output_1;
    wire clock_output_2;
    wire clock_output_3;
    
    always@(posedge clock_output_3)
    begin
        if (ready)
        begin
            if (lock)
                lock = 0; // Lock
            else
                begin
                    address_buffer = address_buffer + 10'b1;
                    lock = 1; // Unlock
                end        
        end        
    end
    
    clock_divider clock_division_1(
        .clock(clock),
        .divided_clock(clock_output_1)
    );
    
//    clock_divider clock_division_2(
//        .clock(clock_output_1),
//        .divided_clock(clock_output_2)
//    );
    
    clock_divider #(.DIVISION_VALUE(250)) clock_division_2(
        .clock(clock_output_1),
        .divided_clock(clock_output_2)
    );    
    
    clock_divider #(.DIVISION_VALUE(50)) clock_division_3(
        .clock(clock_output_2),
        .divided_clock(clock_output_3)
    );    
    
    clock_divider divide_clock(
        .clock(clock),
        .divided_clock(refresh_clock)
    );
    
    memory_control memory_controller(
        .clock(clock_output_1),
        .unlock(lock),
        .address(address_buffer),
        .data(switch[15:0]),
        .buffer(digits),
        .ready(ready)
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
    
    hex_cathode hex_cathode(
        .digit(digit),
        .cathode(cathode)
    );
        
endmodule
