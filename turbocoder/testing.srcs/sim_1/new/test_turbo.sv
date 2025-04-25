module test_turbo();

    logic clk; 
    logic srst; 
    logic dv; 
    logic start;
    logic input_data; 
    logic output_data;
    
 
    read read(
        .clk(clk),
        .en(1),
        .dv(dv),
        .data(input_data)
    );
    
    turbocoder turbocoder(
        .clk(clk),
        .srst(srst),
        .start(start),
        .input_data(input_data),
        .output_data(output_data)
    );
    
     WriteFile write_instance (
         .clk(clk),
         .dv(start),
         .DataIn(output_data)
    );
    
    always #5 clk = ~clk;
    
    
    initial begin
        clk = 0;
        srst = 1;
        #10;
        srst = 0;
    end
 
endmodule
