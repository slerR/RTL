module test_bench;

    logic clk;
    logic din_v;
    logic [15:0] din;
    logic [15:0] dout;

    parameter CLK_PERIOD = 10;

    main inst_main (
        .clk(clk),
        .din_v(din_v),
        .din(din),
        .dout(dout)
    );

    always begin
       #(CLK_PERIOD / 2);
       clk = ~clk;       
    end
    
    always_ff @(posedge clk) begin
       if (din_v) begin
           din <= (din == 4'b1111) ? 0: din+1;
       end
       else begin
            din <= 0;
       end
    end

    initial begin
        clk = 0;
        din_v = 0;
        #(CLK_PERIOD); 
        din_v = 1;
        #(33*CLK_PERIOD);
        $finish;
    end
    endmodule