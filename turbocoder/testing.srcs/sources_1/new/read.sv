module read (
    input logic clk,        
    input logic en,         
    output logic dv,        
    output logic data       
);

    int file_read;       

    initial begin
        file_read = $fopen("C:/NIR/input_data.dat", "r"); 
        if (file_read == 0) begin
            $display("Error: Unable to open file: %s", "C:/NIR/input_data.dat");
            $finish; 
        end  
    end

    always_ff @(posedge clk) begin
        if (en) begin
            if (!$feof(file_read)) begin
                if ($fscanf(file_read, "%b\n", data) == 1) begin
                    dv <= 1; 
                end else begin
                    dv <= 0; 
                    $fclose(file_read); 
                end
            end else begin
                dv <= 0; 
                $fclose(file_read); 
                $display("Info: Reached end of file.");
            end
        end else begin
            dv <= 0; 
        end
    end

endmodule
