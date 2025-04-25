module filter 
#(
localparam integer NUM_TAPS = 11,                      
parameter logic [NUM_TAPS-1:0] barker_code = 11'b11100010010 
)(
    input  logic               clk, dv,
    input  logic signed [15:0] data_in,
    output logic signed [32:0] data_out,
    output logic               dv_out
);

    logic signed [25:0] stage_out[10:0];
    logic [2:0] counter = 3'b0;
    
    generate
        for (genvar i = 0; i < 11; i++) begin : filter_stages
            if (i == 0) begin
                cell_filter 
                #(
                .coef(barker_code[i])
                )cei (
                    .clk(clk),
                    .data(data_in),
                    .sum_out(stage_out[i]),
                    .feedback(32'sd0)
                );
            end else begin
                cell_filter#(
                .coef(barker_code[i])
                ) cei (
                    .clk(clk),
                    .data(data_in),
                    .sum_out(stage_out[i]),
                    .feedback(stage_out[i - 1])
                );
            end
        end
    endgenerate 
    
    always_ff @(posedge clk) begin
    counter <= counter +1;
    if(dv & counter == 3'd4)
    dv_out<=1;
    end 
    assign data_out = stage_out[10];                          
endmodule
