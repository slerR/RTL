`timescale 1ns/1ps

module main (
    input logic clk,
    input logic din_v,
    input logic signed [15:0] din,
    output logic signed [15:0] dout,
    output logic dout_v
);

    parameter int NUM_SAMPLES = 8;
    logic signed [20:0] history [NUM_SAMPLES-1:0] = '{default: 21'b0};
    logic signed [20:0] sum = 21'b0;
    logic [3:0] sample_count = 4'd0;

    always_ff @(posedge clk) begin
        if (din_v) begin
            sum <= sum - history[NUM_SAMPLES-1] + din;
            
            history[NUM_SAMPLES-1:1] <= history[NUM_SAMPLES-2:0];
            history[0] <= din;
            
            if (sample_count < NUM_SAMPLES) begin
                sample_count <= sample_count + 1;
                dout_v <= 0; 
            end else begin
                dout <= sum >> 3; 
                dout_v <= 1; 
            end
        end else begin
            dout_v <= 0; 
        end
    end

endmodule


