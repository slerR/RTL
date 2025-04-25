module reader (   
    input string                file_name,
    input  logic                clk, en,
    output logic                dv,
    output logic signed[15 : 0]  data
);

    real   one_part;
    string line;
    int    file_read;
    
    initial begin
        file_read = $fopen(file_name, "r");
        if (file_read == 0) begin
            $display("error");
            $finish;
        end
    end
    
    always_ff @(posedge clk) begin
        if (en) begin
            if (!$feof(file_read)) begin
                $fgets(line, file_read);
                if ($sscanf(line, "%f", one_part)) begin
                    data <= one_part;
                    dv <= 1;
                end else
                    dv <= 0;
            end else begin
                dv <= 0;
                $fclose(file_read);
            end
        end else
            dv <= 0;  
    end
endmodule
