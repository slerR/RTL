module submain (
    input logic clk,
    input logic [15:0] din,
    output logic [31:0] dout
);
    // Регистры для хранения входного значения и промежуточного результата
    logic [31:0] float;
    logic [31:0] float_1;
    logic [31:0] float_11;
    logic sign;
    logic [7:0] exponent;
    logic [23:0] mantissa;
    logic [15:0] abs_val;
    

    // Процесс конвертации
    always_ff @(posedge clk) begin
        float_1 <= float;
        float_11 <= float_1;
        dout <= float_11;
    end
   
    // Функция конвертации из фиксированной точки в плавающую
   always_comb begin
        exponent = 0;
        // Определяем знак
        if (din[15]) begin
            sign = 1;
            abs_val = ~din + 1; // Делаем число положительным для обработки
        end else begin
            sign = 0;
            abs_val = din;
        end

        if (din == 0) begin
            // Если входное значение 0, то возвращаем положительный ноль
            float = 32'b0;
            end
        else
        // Нормализуем мантиссу и определяем экспоненту
        begin
        mantissa = {8'b00000000, abs_val[14:0]}; // Берем 15 младших бит
        // Нормализация
        
       
        end
        for (int i = 0; i < 23; i++) begin
            if (mantissa[23] == 1'b0) begin
                mantissa = mantissa << 1; // Сдвиг влево для нормализации
                exponent += 1; // Увеличение экспоненты
            end else begin
                break; // Выход из цикла, если условие не выполняется
            end
         end
         
         exponent = 127 + 23  - exponent;
        float = {sign, exponent, mantissa[22:0]};
        end
endmodule

