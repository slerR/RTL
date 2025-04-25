module test_bench;

    logic clk;                // Тактовый сигнал
    logic srst;               // Синхронный сброс
    logic btn;                // Кнопка для переключения состояний
    logic [2:0] x1;           // Первый вход для операций
    logic [2:0] x2;           // Второй вход для операций
    logic [7:0] y;            // Выход модуля lab82

    parameter CLK_PERIOD = 10; // Период тактового сигнала
    
    lab82 inst_lab82 (
        .clk(clk),
        .srst(srst),
        .btn(btn),
        .x1(x1),
        .x2(x2),
        .y(y)
    );
    
    always begin
        #(CLK_PERIOD / 2);
        clk = ~clk;
    end
    
    initial begin
        clk = 0;
        srst = 1;   
        btn = 0;
        x1 = 3'b000; 
        x2 = 3'b000;
        #CLK_PERIOD; 
        srst = 0;    
        #(CLK_PERIOD*20);
        btn = 1;
        x1 = 3'b101;  // Пример входных данных: 5
        x2 = 3'b010;  // Пример входных данных: 2
        #CLK_PERIOD;
        btn = 0; // Отпускаем кнопку
        #(CLK_PERIOD*5);
        btn = 1;
        #CLK_PERIOD;
        btn = 0;
        #(CLK_PERIOD*5);
        btn = 1;
        #CLK_PERIOD;
        btn = 0;
        #(CLK_PERIOD*15);
        btn = 1;
        #CLK_PERIOD;
        btn = 0;
        #(20 * CLK_PERIOD);
        $finish;
    end

endmodule

