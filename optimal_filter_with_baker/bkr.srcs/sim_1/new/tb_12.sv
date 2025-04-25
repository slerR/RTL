module tb_12;
    string input_file = "C:/WiFi/data2fpga.dat";
    string output_file = "C:/WiFi/data_from_fpga.dat";

    logic clk = 0;
    logic dv = 0;
    logic dv_out = 0;
    logic signed [15:0] data_in = 16'b0;
    logic signed [31:0] data_out;

    parameter logic [10:0] barker_code = 11'b11100010010; 

    always #5 clk = ~clk;

    reader reader_inst (
        .file_name(input_file),
        .clk(clk),
        .en(1),                
        .dv(dv),               
        .data(data_in)     
    );

    filter #(
        .barker_code(barker_code) // Коэффициенты Баркера передаются как параметр
    ) uut (
        .clk(clk),
        .dv(dv),                       
        .data_in(data_in),                
        .data_out(data_out), 
        .dv_out(dv_out)                
    );

    writer writer_inst (
        .file_name(output_file),
        .clk(clk),
        .dv(dv_out),                 
        .data_out(data_out)   
    );

    // Начало теста
    initial begin
        dv_out = 0;
        clk = 0;
        #5 dv = 1;
        repeat (1569394) @(posedge clk); 
        $finish; 
    end
endmodule
