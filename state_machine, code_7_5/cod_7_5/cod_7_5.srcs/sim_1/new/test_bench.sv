module tb_lab81;

    // Сигналы для тестирования
    logic clk;
    logic srst;
    logic info = 1'b1;
    logic [1:0] coded;

    parameter CLK_PERIOD = 10; 

    lab81 inst_lab81 (
        .clk(clk),
        .srst(srst),
        .info(info),
        .coded(coded)
    );

    always begin
        #(CLK_PERIOD / 2);
        clk = ~clk;       
    end

    // Основной тест
    initial begin
        
        clk = 0;
        srst = 1;
       
        
        #(CLK_PERIOD/2); 
        srst = 0;
        
        // Подавать последовательно биты информации
         
         #(29*CLK_PERIOD) // Вход 1
        $finish;
    end

endmodule

