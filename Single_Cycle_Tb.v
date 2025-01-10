 `include "Single_Cycle_Top.v"
module Single_Cycle_Tb();


reg clk,rst;
Single_Cycle_Top Single_Cycle_Top(
    .clk(clk),
    .rst(rst)
);

initial begin
    $dumpfile("Single_Cycle.vcd");
    $dumpvars(0,Single_Cycle_Top);

end

initial
begin
    clk = 0;
    forever #30 clk = ~clk;

end

initial begin
    rst = 1'b0;
    #1500
    rst =1'b1;
    #1000;
    $finish;
end



endmodule