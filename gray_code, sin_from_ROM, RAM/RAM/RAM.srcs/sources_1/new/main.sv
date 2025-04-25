module lab7 (
    input logic clk,              // Тактовый сигнал
    input logic we,               // Включение режима записи
    input logic [1:0] address,    // 2-разрядный адрес
    input logic [2:0] din,        // 3-разрядный входной информационный порт
    output logic [2:0] dout       // 3-разрядный выходной порт (светодиоды)
);

    
    logic [2:0] ram [0:3] = '{3'b000, 3'b000, 3'b000, 3'b000}; 

    always_ff @(posedge clk) begin // read first
        if (we) begin
            ram[address] <= din;
        end
        dout <= ram[address];
    end

endmodule

