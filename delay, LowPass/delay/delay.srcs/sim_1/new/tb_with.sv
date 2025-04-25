module tb_with;

    logic clk;
    logic srst;
    logic sample_in_v;
    logic [15:0] sample_in;
    logic [15:0] sample_out;

    parameter CLK_PERIOD = 10;

     delay_with_srst inst_with (
        .clk(clk),
        .srst(srst),
        .sample_in_v(sample_in_v),
        .sample_in(sample_in),
        .sample_out(sample_out)
    );

    always begin
        #(CLK_PERIOD / 2);
        clk = ~clk;       
    end
    
    always_ff @(posedge clk) begin
        if (sample_in_v) begin
            sample_in <= (sample_in == 4'b1111) ? 0 : sample_in + 1;
        end
        else begin
        sample_in = 0;
        end
    end

    initial begin
        clk = 0;
        srst = 0;
        sample_in_v = 0;
        #(CLK_PERIOD); 
        srst = 1;  
        #(CLK_PERIOD); 
        srst = 0;  
        sample_in_v = 1;
        #(140*CLK_PERIOD);
        srst = 1;
        #(CLK_PERIOD);
        srst = 0; 
        #(150 * CLK_PERIOD);  
        $finish;
    end

endmodule
