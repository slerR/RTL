module main (
    input logic clk,         // ¬ход дл€ тактового сигнала
    input logic srst,        // ¬ход дл€ сигнала сброса
    output logic [7:0] dout  // 8-разр€дный выход
);

  
    logic [7:0] rom [0:15] = {
    8'b00000000, 8'b00110000, 8'b01011001, 8'b01110101,
    8'b01111111, 8'b01110101, 8'b01011001, 8'b00110000,
    8'b00000000, 8'b11001111, 8'b10100110, 8'b10001010,
    8'b10000001, 8'b10001010, 8'b10100110, 8'b11001111
};

    logic [3:0] addr;
    logic [7:0] rom_data_reg;
    
    always_ff @(posedge clk or posedge srst) begin
        if (srst)
            addr <= 4'b0;    
        else
            addr <= addr + 1; 
    end

   
    always_ff @(posedge clk) begin
        rom_data_reg <= rom[addr];    
    end
    
    always_ff @(posedge clk) begin
        dout <= rom_data_reg; 
    end

endmodule
