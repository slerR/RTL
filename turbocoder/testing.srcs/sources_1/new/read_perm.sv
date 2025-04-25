module read_perm #(
    parameter N = 2048,
    WIDTH = 11
) (
    input logic clk,               
    input logic en,                
    output logic [WIDTH-1:0] perm_tab [N-1:0]                
);

   logic [WIDTH-1:0] rom [N-1:0];

     always_ff @(posedge clk) begin
        if (en)  
            perm_tab <= rom;  
    end

    initial begin
        $readmemb("C:/NIR/permutation_rom.dat", rom);  // Загрузка данных из файла
    end

endmodule
