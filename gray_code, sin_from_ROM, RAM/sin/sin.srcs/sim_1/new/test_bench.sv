module test_bench;

    logic clk;                // Тактовый сигнал
    logic srst;               // Синхронный сброс
    logic [7:0] dout;         // Выход модуля lab7

    parameter CLK_PERIOD = 10; 
 
    main inst_lab7 (
        .clk(clk),
        .srst(srst),
        .dout(dout)
    );
    
    initial begin
        clk = 0;          
        srst = 1;         
        #CLK_PERIOD;      
        srst = 0;         
    end
    
    always begin
        #(CLK_PERIOD / 2);
        clk = ~clk;       
    end
    initial begin
        #(20000*CLK_PERIOD);
        $finish;
    end

endmodule

