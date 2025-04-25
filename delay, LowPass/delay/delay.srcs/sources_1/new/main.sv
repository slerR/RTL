module delay_without_srst(
    input logic clk,
    input logic sample_in_v,
    input logic [15:0] sample_in,
    output logic [15:0] sample_out
);
    logic [15:0] delay_line [127:0] = '{default: 16'b0}; // Массив для хранения 128 значений

    always_ff @(posedge clk) begin
        if (sample_in_v) begin
             delay_line <= {delay_line[126:0],sample_in}; 
        end
    end

    assign sample_out = delay_line[127]; 
endmodule
