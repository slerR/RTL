module tb_2;

    logic clk;
    logic din_v;
    logic [15:0] din;
    logic [15:0] dout;
    parameter CLK_PERIOD = 10;
    parameter TABLE_SIZE = 16; // —ократим дл€ нагл€дности

    real amplitude = 5000.0;
    integer t;
    integer index_slow, index_fast;

    // “аблицы, моделирующие синусоиды дл€ медленной и быстрой частоты
    real slow_sine_table [TABLE_SIZE-1:0] = {0.0, 0.3827, 0.7071, 0.9239, 1.0, 0.9239, 0.7071, 0.3827,
                                             0.0, -0.3827, -0.7071, -0.9239, -1.0, -0.9239, -0.7071, -0.3827};
                                             
    real fast_sine_table [TABLE_SIZE-1:0] = {0.5, 0.7071, 0.866, 0.9659, 1.0, 0.9659, 0.866, 0.7071,
                                             0.5, 0.2929, 0.134, 0.034, 0.0, 0.034, 0.134, 0.2929};

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
        if (!din_v) begin
            din <= 0;
            t <= 0;
            index_slow <= 0;
            index_fast <= 0;
        end else begin
            din <= $rtoi(amplitude * slow_sine_table[index_slow] * fast_sine_table[index_fast]);
            index_slow <= (index_slow + 1) % TABLE_SIZE;
            index_fast <= (index_fast + 3) % TABLE_SIZE;  // ”величение дл€ быстрой частоты
            t <= t + 1;
        end
    end

    initial begin
        clk = 0;
        din_v = 0;
        #(CLK_PERIOD);
        din_v = 1;
        #(500 * CLK_PERIOD);
        $finish;
    end

endmodule
