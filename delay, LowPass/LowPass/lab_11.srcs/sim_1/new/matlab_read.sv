module tb_matlab_read;

    logic clk;
    logic srst;
    logic rfd;
    logic dv;
    logic [15:0] data;
    logic [15:0] dout;  // Вывод данных из модуля main
    parameter CLK_PERIOD = 10;

    integer file_rd, file_wr;  // Используем integer для дескрипторов файлов

    // Включаем генерацию тактового сигнала
    always begin
        #(CLK_PERIOD / 2);
        clk = ~clk;       
    end

    // Генерация данных и управление сигналами
    initial begin
        // Начальная установка сигналов
        clk = 0;
        srst = 1;    // Изначально сброс активен
        rfd = 1;     // Готовность данных

        // Симуляция сброса
        #(2 * CLK_PERIOD);
        srst = 0;  // Снимаем сброс

        // Эмуляция работы устройства
        #(CLK_PERIOD);

        // Считывание и запись данных
        $display("Starting file operations...");

        // Открытие файлов
        file_rd = $fopen("C:\\generic_sin\\data2fpga.dat", "r"); // Открытие файла для чтения
        if (file_rd == 0) begin
            $display("Error: File '%s' could not be opened for reading.", "C:\\generic_sin\\data2fpga.dat");
            $finish;
        end 

        file_wr = $fopen("C:\\generic_sin\\data_from_fpga.dat", "w"); // Открытие файла для записи
        if (file_wr == 0) begin
            $display("Error: File '%s' could not be opened for writing.", "C:\\generic_sin\\data_from_fpga.dat");
            $finish;
        end else begin
            $display("File '%s' opened for writing.", "C:\\generic_sin\\data_from_fpga.dat");
        end

        // Запуск симуляции с временной задержкой для имитации работы
        #(1000 * CLK_PERIOD);

        // Закрытие файлов
        $fclose(file_rd);
        $fclose(file_wr);

        // Завершаем симуляцию
        $finish;
    end

    // Инстанцируем модуль main
    main inst_main (
        .clk(clk),            // Тактовый сигнал
        .din_v(dv),           // Сигнал готовности данных
        .din(data),           // Данные для обработки
        .dout(dout)           // Выходные данные
    );

    // Симуляция данных: на каждом такте читаем данные и передаем в модуль
    always_ff @(posedge clk) begin
        if (srst) begin
            data <= 16'b0;  // При сбросе обнуляем данные
            dv <= 0;        // Сигнал готовности данных отключен
        end else if (rfd) begin
            // Чтение данных из файла на каждом такте
            if (file_rd != 0 && !$feof(file_rd)) begin
                // Чтение данных из файла, игнорируем возвращаемое значение
                $fscanf(file_rd, "%d\n", data); // Чтение из файла
                dv <= 1;  // Установка готовности данных
            end else begin
                dv <= 0;  // Отключение готовности, если файл закончился
            end
            
            // Запись данных dout в файл
            if (file_wr != 0) begin
                $fwrite(file_wr, "%d\n", dout);
            end
        end else begin
            dv <= 0;         // Сигнал готовности данных выключен, когда rfd не активен
        end
    end

endmodule
