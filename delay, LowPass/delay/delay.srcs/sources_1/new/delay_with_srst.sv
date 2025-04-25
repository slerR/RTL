module delay_with_srst(
    input logic clk,
    input logic srst,       // Сигнал сброса
    input logic sample_in_v,
    input logic [15:0] sample_in,
    output logic [15:0] sample_out
);
    logic [15:0] delay_line [127:0]; // Массив для хранения 128 значений

    always_ff @(posedge clk) begin
        if (srst) begin
            delay_line <= '{default: 16'b0}; // Сброс всех значений в массиве
        end else if (sample_in_v) begin
             delay_line <= {delay_line[126:0],sample_in}; // Сдвиг
        end
    end

    assign sample_out = delay_line[127]; // Самое старое значение на выходе
endmodule

