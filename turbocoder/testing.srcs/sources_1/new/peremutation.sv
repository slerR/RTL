module permutation #(
    parameter N = 2048
) (
    input logic clk,
    input logic srst,                           
    input logic input_bit,                      
    output logic output_bit,                    
    output logic done                           
);

    logic [10:0] permutation_rom [N-1:0];  
    logic we;                              
    logic [$clog2(N):0] i;                     
    (* ram_style = "distributed" *) logic perm_data [N-1:0];                                                   
    
    
    read_perm read_perm (
        .clk(clk),
        .en(srst),
        .perm_tab(permutation_rom)
    );

    always_ff @(posedge clk) begin
        if (srst) begin
            we <= 1;
            i <= 0;
            done <= 0;
        end else begin
            if (we) begin
                if (i < N) begin
                    perm_data[permutation_rom[i]] <= input_bit; 
                    i <= i + 1;
                end else begin
                    i <= 0;
                    we <= 0;                          
                end               
            end else begin             
                if (i < N) begin
                    output_bit <= perm_data[i]; 
                    i <= i + 1;
                    done <= 1;
                end      
            end         
        end
    end
endmodule
