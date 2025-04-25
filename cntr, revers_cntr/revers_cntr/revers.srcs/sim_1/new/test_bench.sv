module test_bench;

    logic clk;               // Тактовый сигнал
    logic srst;              // Синхронный сброс
    logic mode;              // Режим работы (0 - счёт вверх, 1 - счёт вниз)
    logic [7:0] dout;        // Выход для светодиодов

    parameter CLK_PERIOD = 10; // Период тактового сигнала

    // Экземпляр модуля lab63
    main inst_main (
        .clk(clk),
        .srst(srst),
        .mode(mode),
        .dout(dout)
    );

    // Генерация тактового сигнала
    always begin
        #(CLK_PERIOD / 2);
        clk = ~clk;
    end

    // Начальная процедура
    initial begin
        clk = 0;
        srst = 1;           // Активируем сброс
        mode = 0;           // Устанавливаем режим на счёт вверх
        #(CLK_PERIOD);
        srst = 0;           // Деактивируем сброс

        // Тестируем суммирующий счётчик
        repeat (10) begin
            #(CLK_PERIOD);
            $display("Суммирующий режим, dout = %b", dout);
        end

        // Переключаем на вычитающий счётчик
        mode = 1;           // Переключаем на режим счёта вниз
        repeat (10) begin
            #(CLK_PERIOD);
            $display("Вычитающий режим, dout = %b", dout);
        end
        
        mode = 0;
        repeat (10) begin
            #(CLK_PERIOD);
            $display("Суммирующий режим, dout = %b", dout);
        end


        $finish;            // Завершаем симуляцию
    end

endmodule

