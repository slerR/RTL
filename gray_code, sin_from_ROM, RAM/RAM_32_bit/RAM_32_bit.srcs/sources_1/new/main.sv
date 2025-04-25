module lab7 #(
    parameter DATA_WIDTH = 32,   
    parameter ADDR_WIDTH = 13   
) (
    input logic clk,
    input logic srst,
    input logic we,
    input logic [0:DATA_WIDTH-1] din,
    input logic [0:ADDR_WIDTH-1] address_counter,
    output logic [0:DATA_WIDTH-1] dout
);
                        
    logic [0:DATA_WIDTH-1] ram [0:(1 << ADDR_WIDTH)-1];
    always_ff @(posedge clk)begin 
        if (we) begin
            ram[address_counter] <= din;  
        end
            dout <= ram[address_counter];   // Чтение данных из RAM
    end

endmodule

