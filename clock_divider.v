module clock_divider #(
    parameter COUNT_WIDTH = 27,
    parameter [COUNT_WIDTH:0] MAX_COUNT = 12000000 - 1
) (
    input clk2,
    input rst,

    output reg out
);
wire clk2;
    reg div_clk;
    reg [COUNT_WIDTH:0] count;

    always @(posedge clk2 or posedge rst) begin
        if (rst == 1'b1) begin
            count <= 0;
            out <= 0;
        end else if (count == MAX_COUNT) begin
            count <= 0;
            out <= ~out;
        end else begin
            count <= count + 1;
        end
    end
endmodule
