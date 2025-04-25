module writer (   
    input string                file_name,
    input logic                 clk, dv,
    input logic signed [31 : 0] data_out
    );
    
    int    file_write;
    
    initial begin
        file_write = $fopen(file_name, "w");
        if (file_write == 0) begin
            $display("Error: Unable to open file %s", file_name);
            $finish;
        end
    end
    
    always_ff @(posedge clk) begin
        if (dv) 
        $fwrite(file_write, "%0d\n", data_out);
           
    end
    
    final begin        
        $fclose(file_write);
    end
    
endmodule
