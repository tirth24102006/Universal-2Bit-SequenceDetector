module alltwobitsequencedetector(x,s,clk,rst,y,NS);
input x,clk,rst;
input [1:0]s;
output reg y;
wire [1:0]s1,s2,s3;
output reg [1:0] NS;
assign s1 = 2'b00;
assign s2 = 2'b01;
assign s3 = 2'b10;
initial begin
        y = 1'b0;
end
always @(posedge clk)begin
        if(rst)begin
                NS = s1;
                y = 1'b0;
        end else begin
                if((x==s[1]) && (NS==s1)) begin
                        NS = s2;
                        y = 1'b0;
                end else if((x==(!s[1])) && (NS==s1))begin
                        NS = s1;
                        y = 1'b0;
                end else if((x==s[1]) && (NS==s3))begin
                        NS = s2;
                        y = 1'b0;
                end else if((x==(!s[1])) && (NS==s3))begin
                        NS = s1;
                        y = 1'b0;
                end else if(x==s[0]) begin
                        NS = s3;
                        y = 1'b1;
                end else begin
                        NS = s1;
                        y = 1'b0;
                end
        end
end
endmodule