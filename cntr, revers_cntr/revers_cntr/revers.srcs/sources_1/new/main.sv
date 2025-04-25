module main (
    input logic clk,          // Тактовый сигнал
    input logic srst,         // Синхронный сброс
    input logic mode,         // 0 - суммирующий счет, 1 - вычитающий счет
    output logic [7:0] dout   // 8-битный выход для светодиодов
);

    logic [29:0] cntr;        // 30-битный счетчик

    // Присваиваем 8 старших бит счетчика для светодиодов
    assign dout = cntr[29:22];

    // Основной блок для синхронного счёта
    always_ff @(posedge clk) begin
        if (srst) begin
            // Если сигнал сброса активен, устанавливаем счетчик в 0
            cntr <= 30'b0;
        end else begin
            // Выбираем направление счёта на основе значения `mode`
            if (mode == 1'b0) begin
                // Суммирующий счетчик (считаем вверх)
                if (cntr == 30'd1073741823) begin  // 2^30 - 1
                    cntr <= 30'b0;  // Переполнение, сбрасываем в 0
                end else begin
                    cntr <= cntr + 1;  // Увеличиваем на 1
                end
            end else begin
                // Вычитающий счетчик (считаем вниз)
                if (cntr == 30'b0) begin
                    cntr <= 30'd1073741823;  // Если счетчик в нуле, то устанавливаем максимальное значение
                end else begin
                    cntr <= cntr - 1;  // Уменьшаем на 1
                end
            end
        end
    end

endmodule

