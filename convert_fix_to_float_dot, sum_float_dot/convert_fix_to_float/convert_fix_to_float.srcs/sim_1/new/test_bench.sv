module test_bench;

    // Сигналы для тестирования
    logic clk;
    logic signed [15:0] din;  
    logic [31:0] dout;        

    parameter CLK_PERIOD = 10; 

    main inst_main (
        .clk(clk),
        .din(din),
        .dout(dout)
    );

    always begin       
        clk = ~clk; 
        #(CLK_PERIOD / 2);      
    end

    // Основной тест
    initial begin
        clk = 0;

       forever begin
            din = $random%(2**16);
            #(3*CLK_PERIOD);
        end
        $finish;
    end

endmodule
