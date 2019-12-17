`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/14/2019 07:46:25 PM
// Design Name: 
// Module Name: memory_control
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


module memory_control(
        clock,
        unlock,
        address,
        data,
        buffer,
        ready
    );
    input clock;
    input unlock;
    input [9:0] address;
    input [15:0] data;
    output [15:0] buffer;
    //output [9:0] memory_address;
    output ready;
    
    wire memory_clock;
    assign memory_clock = clock;
    
    reg ready;
    reg [15:0] buffer;
    
    reg [2:0] memory_period = 3'b000;
    wire [15:0] memory_buffer;
    //reg [9:0] memory_address;    
    reg enable;
    reg write;
            
    localparam enable_delay = 1;
    localparam write_delay = 2;
    localparam ready_delay = 8;
    localparam data_out_delay = 6;
    
    localparam enable_time = 7;
    localparam write_time = 4;
    localparam data_out_time = 7;
        
    /*
    wire clock_1; //100 kHz
    wire clock_2; // 100 Hz
    wire clock_3; // 0.1 Hz    
    
    clock_divider divide_clock_1(
        .clock(clock),
        .divided_clock(clock_1)
    );
    
    clock_divider divide_clock_2(
        .clock(clock_1),
        .divided_clock(clock_2)
    );
    
    clock_divider divide_clock_3(
        .clock(clock_2),
        .divided_clock(clock_3)
    );
    */
    
    always@(posedge clock)
    begin
        case(memory_period)
            3'b000 :
                begin
                    ready <= 0;
                    enable <= 0;
                    write <= 0;
                    //memory_address <= address;                    
                end
            3'b001 :
                begin
                    ready <= 0;
                    enable <= 1;
                    write <= 0;
                end
            3'b010 :
                begin
                    ready <= 0;
                    enable <= 1;
                    write <= 1;
                end
            3'b100 :
                begin
                    ready <= 0;
                    enable <= 1;
                    write <= 0;
                end
            3'b110:
                begin
                    buffer <= memory_buffer[15:0];
                end
            3'b111:
                begin
                    enable <= 0;
                end        
        endcase    
    end
    
    spwf_memory memory(
        .clock(memory_clock),
        .write_enable(write),
        .enable(enable),
        .address(address),
        .data_in(data),
        .data_out(memory_buffer)
    );  
endmodule
