`timescale 1ns / 1ps
module alltwobitsequencedetector_tb;
reg clk,rst,x;
reg [1:0] s;
wire y;
wire [1:0] NS;
alltwobitsequencedetector a1(x,s,clk,rst,y,NS);
initial begin
clk=0;
end
always #5 clk=~clk;
initial begin
$dumpfile("dump.vcd");
$dumpvars(0, alltwobitsequencedetector_tb);
$monitor("at time %t: clk=%b rst=%b s=%b x=%b y=%b NS=%b",$time,clk,rst,s,x,y,NS);
                rst = 1'b1; s = 2'b00; x = 1'b1; #10;
                rst = 1'b0; s = 2'b00; x = 1'b1; #10;
                rst = 1'b0; s = 2'b00; x = 1'b1; #10;
                rst = 1'b0; s = 2'b00; x = 1'b0; #10;
                rst = 1'b0; s = 2'b00; x = 1'b0; #10;
                rst = 1'b0; s = 2'b00; x = 1'b0; #10;
                rst = 1'b0; s = 2'b00; x = 1'b1; #10;
                rst = 1'b0; s = 2'b00; x = 1'b0; #10;
                rst = 1'b0; s = 2'b00; x = 1'b1; #10;

                rst = 1'b1; s = 2'b01; x = 1'b1; #10;
                rst = 1'b0; s = 2'b01; x = 1'b1; #10;
                rst = 1'b0; s = 2'b01; x = 1'b1; #10;
                rst = 1'b0; s = 2'b01; x = 1'b0; #10;
                rst = 1'b0; s = 2'b01; x = 1'b0; #10;
                rst = 1'b0; s = 2'b01; x = 1'b0; #10;
                rst = 1'b0; s = 2'b01; x = 1'b1; #10;
                rst = 1'b0; s = 2'b01; x = 1'b0; #10;
                rst = 1'b0; s = 2'b01; x = 1'b1; #10;

                rst = 1'b1; s = 2'b10; x = 1'b1; #10;
                rst = 1'b0; s = 2'b10; x = 1'b1; #10;
                rst = 1'b0; s = 2'b10; x = 1'b1; #10;
                rst = 1'b0; s = 2'b10; x = 1'b0; #10;
                rst = 1'b0; s = 2'b10; x = 1'b0; #10;
                rst = 1'b0; s = 2'b10; x = 1'b0; #10;
                rst = 1'b0; s = 2'b10; x = 1'b1; #10;
                rst = 1'b0; s = 2'b10; x = 1'b0; #10;
                rst = 1'b0; s = 2'b10; x = 1'b1; #10;

                rst = 1'b1; s = 2'b11; x = 1'b1; #10;
                rst = 1'b0; s = 2'b11; x = 1'b1; #10;
                rst = 1'b0; s = 2'b11; x = 1'b1; #10;
                rst = 1'b0; s = 2'b11; x = 1'b0; #10;
                rst = 1'b0; s = 2'b11; x = 1'b0; #10;
                rst = 1'b0; s = 2'b11; x = 1'b0; #10;
                rst = 1'b0; s = 2'b11; x = 1'b1; #10;
                rst = 1'b0; s = 2'b11; x = 1'b0; #10;
                rst = 1'b0; s = 2'b11; x = 1'b1; #10;
                
        $finish;
end
endmodule