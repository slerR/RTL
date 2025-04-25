module LOW_PASS;
    parameter NUM_BITS = 16;
    parameter CLK_PERIOD = 10;
    logic clk;
    logic rst;
    logic signed [NUM_BITS-1:0] din;
    logic din_v;
    logic signed [NUM_BITS-1:0] dout;
    logic dout_v;
    
    logic signed [NUM_BITS-1:0] data_from_file;
    logic data_valid_from_file;
    logic read_ready;
    logic write_enable;
    logic sign; // ”казатель знака дл€ записи

    main uut (
        .clk(clk),
        .din_v(din_v),
        .din(din),
        .dout(dout),
        .dout_v(dout_v)
    );

    ReadFile #(
        .numOfBits(NUM_BITS),
        .file_name("C:\\generic_sin\\data2fpga.dat")
    ) read_file_inst (
        .data(data_from_file),
        .dv(data_valid_from_file),
        .rst(rst),
        .rfd(read_ready),
        .clk(clk)
    );
 
    WriteFile_full #(
        .numOfBits(NUM_BITS),
        .file_name("C:\\generic_sin\\data_from_fpga.dat")
    ) write_file_inst (
        .clk(clk),
        .dv(write_enable),
        .sign(sign),
        .DataIn(dout)
    );

    always #(CLK_PERIOD / 2) clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        read_ready = 0;
        write_enable = 0;
        sign = 1;
        din = '0;
        #15;
        rst = 0;
        read_ready = 1; 
        
        forever begin
            @(posedge clk);

            // „тение данных из файла и установка din_v на каждом такте при наличии данных
            if (data_valid_from_file) begin
                din = data_from_file;
                din_v = 1; // din_v активен на каждом такте, если есть данные
            end else begin
                din_v = 0;
            end

            if (dout_v) begin
                write_enable = 1;
            end else begin
                write_enable = 0;
            end
        end
    end
    initial begin
        #1000;
        $stop;
    end
endmodule