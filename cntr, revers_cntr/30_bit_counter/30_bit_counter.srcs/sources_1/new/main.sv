module lab6 (
    input logic clk,          // Тактовый сигнал
    input logic srst,         // Синхронный сброс
    output logic [7:0] dout   // 8-битный выход для светодиодов
);

    logic [29:0] cntr;

    assign dout = cntr[29:22];

    always_ff @(posedge clk) begin
        if (srst) begin 
        cntr <= 30'b0;
        end else 
            if (cntr == 30'd1073741823) begin 
                cntr <= 30'b0;
            end else begin
                cntr <= cntr + 1;
            end
        end 
        
endmodule
