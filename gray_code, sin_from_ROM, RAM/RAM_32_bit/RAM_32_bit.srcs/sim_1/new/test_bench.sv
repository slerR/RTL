module test_bench;

    // ѕараметры дл€ данных и адресов
    parameter DATA_WIDTH = 32;      
    parameter ADDR_WIDTH = 13;   // ƒл€ 8192 €чеек пам€ти
    parameter CLK_PERIOD = 10;

    // ¬ходные и выходные сигналы
    logic clk;
    logic srst;
    logic [0:DATA_WIDTH-1] dout;

    logic [0:DATA_WIDTH-1] data_counter = 0;     
    logic [0:ADDR_WIDTH-1] address_counter = 0;   // —четчик адресов
    logic we;                                 // —игнал разрешени€ записи

    // Ёкземпл€р тестируемого модул€
    lab7 #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) inst_lab7 (
        .clk(clk),
        .srst(srst),
        .dout(dout),
        .din(data_counter),
        .we(we),
        .address_counter(address_counter)
    );

    // √енераци€ тактового сигнала
    always begin
        #(CLK_PERIOD / 2);
        clk = ~clk;  // ѕериод 10 нс, частота 100 ћ√ц
    end

    // ќсновной блок теста
    initial begin
        clk = 0;
        srst = 1;
        we = 0; 
        #(CLK_PERIOD);
        srst = 0;  
        we = 1;  
        #(CLK_PERIOD*20);
        srst = 1;
        #(CLK_PERIOD);
        srst = 0;
       #(CLK_PERIOD * 16);
        we = 0;
       #(CLK_PERIOD * 2000);
        

        $finish;  // «авершение симул€ции
    end

    // —четчик данных (шаг 8, до 8191)
    always_ff @(posedge clk or posedge srst) begin
            data_counter <= (data_counter < 8191) ? data_counter + 8 : 0;
    end

    always_ff @(posedge clk or posedge srst) begin
        if (srst)
            address_counter <= 0;
        else
            address_counter <= address_counter + 1;
    end

endmodule
