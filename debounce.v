`timescale 1ns / 1ps
module debounce(input [4:0] pb, clk, output [4:0] pb_out);
    wire slow_clk_en;
    wire [4:0] Q1, Q2, Q2_bar, Q0;
    clock_enable u1(clk, slow_clk_en);
    my_dff_en d0(clk, slow_clk_en, pb[0], Q0[0]);
    my_dff_en d1(clk, slow_clk_en, pb[1], Q0[1]);
    my_dff_en d2(clk, slow_clk_en, pb[2], Q0[2]);
    my_dff_en d3(clk, slow_clk_en, pb[3], Q0[3]);
    my_dff_en d12(clk, slow_clk_en, pb[4], Q0[4]);
    

    my_dff_en d4(clk, slow_clk_en, Q0[0], Q1[0]);
    my_dff_en d5(clk, slow_clk_en, Q0[1], Q1[1]);
    my_dff_en d6(clk, slow_clk_en, Q0[2], Q1[2]);
    my_dff_en d7(clk, slow_clk_en, Q0[3], Q1[3]);
    my_dff_en d13(clk, slow_clk_en, Q0[4], Q1[4]);

    my_dff_en d8(clk, slow_clk_en, Q1[0], Q2[0]);
    my_dff_en d9(clk, slow_clk_en, Q1[1], Q2[1]);
    my_dff_en d10(clk, slow_clk_en,Q1[2], Q2[2]);
    my_dff_en d11(clk, slow_clk_en,Q1[3], Q2[3]);
    my_dff_en d14(clk, slow_clk_en,Q1[4], Q2[4]);

    assign Q2_bar = ~Q2;
    assign pb_out = Q1 & Q2_bar;
endmodule

 
module clock_enable(input Clk_100M,output slow_clk_en);
    reg [26:0]counter=0;
    always @(posedge Clk_100M)
    begin
       counter <= (counter>=249999)?0:counter+1;
    end
    assign slow_clk_en = (counter == 249999)?1'b1:1'b0;
endmodule


module my_dff_en(input DFF_CLOCK,clock_enable,D,output reg Q=0);
    always @ (posedge DFF_CLOCK) begin
        if(clock_enable==1) 
           Q <= D;
    end
endmodule
