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
    
    reg [3:0] memory_period = 4'b0000;
    wire [15:0] memory_buffer;
    //reg [9:0] memory_address;    
    reg enable;
    reg write;
            
    /*
	localparam enable_delay = 1;
    localparam write_delay = 2;
    localparam ready_delay = 8;
    localparam data_out_delay = 6;
    
    localparam enable_time = 7;
    localparam write_time = 4;
    localparam data_out_time = 7;
    */
	 
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
        if (unlock == 1)   
            begin
                memory_period = memory_period + 4'b0001; 
                case(memory_period)
                    4'b0001 :
                        begin
                            ready <= 0;
                            enable <= 0;
                            write <= 0;
                            //memory_address <= address;                    
                        end
                    4'b0010 :
                        begin
                            //ready <= 0;
                            enable <= 1;
                            //write <= 0;
                        end
                    4'b0011 :
                        begin
                            //ready <= 0;
                            //enable <= 1;
                            write <= 1;
                        end
                    4'b0101 :
                        begin
                            //ready <= 0;
                            //enable <= 1;
                            write <= 0;
                        end
                    4'b0111:
                        begin
                            //ready <= 0;
                            //enable <= 1;
                            //write <= 0;
                            buffer <= memory_buffer[15:0];
                        end
                    4'b1000:
                        begin
                            //ready <= 0;
                            enable <= 0;
                            //write <= 0;
                        end
                    4'b1001:
                        begin
                            ready <= 1;
                            //enable <= 0;
                            //write <= 0;
                        end
                    4'b1111:
                        begin
                            memory_period = 4'b1110;
                        end
//                    default:
//                        begin
//                            memory_period = 4'b1010;
//                        end       
                endcase          
            end
        else
            begin
                enable <= 0;
                write <= 0;
                ready <= 1;
                memory_period = 4'b0000;
            end  
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
