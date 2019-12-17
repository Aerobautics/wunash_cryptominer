`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/14/2019 09:53:35 AM
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
    input wire clock,
    input wire [15:0] switch,
    output wire [3:0] anode,
    output wire [7:0] cathode
    );
    
   wire refresh_clock;
   wire [1:0] refresh_count;
   wire [3:0] digit;
   
   //clock divider wrapper
   clock_divider divide_clock(
    .clock(clock),
    .divided_clock(refresh_clock)
   );
   
   // refresh counter wrapper
   refresh_counter count_refresh(
    .refresh_clock(refresh_clock),
    .refresh_count(refresh_count)
   );
   
   anode_control control_anode(
    .refresh_count(refresh_count),
    .anode(anode)
   );
   
   bcd_control control_bcd(
    .digit_1(switch[3:0]),
    .digit_2(switch[7:4]),
    .digit_3(switch[11:8]),
    .digit_4(switch[15:12]),
    .refresh_count(refresh_count),
    .digit(digit)
   );
   
   bcd_cathode bcd_cathode(
    .digit(digit),
    .cathode(cathode)
   );
    
endmodule
