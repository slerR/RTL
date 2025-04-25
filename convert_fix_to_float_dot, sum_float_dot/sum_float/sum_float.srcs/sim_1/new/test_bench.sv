module test_becnh;

    logic clk;
    logic [31:0] a, b; // Два входных числа в формате IEEE 754
    logic [31:0] result; // Результат сложения

    main inst_main (
        .clk(clk),
        .a(a),
        .b(b),
        .result_d2(result)
    );

    parameter CLK_PERIOD = 10;

    // Генерация тактового сигнала
    always begin
        #(CLK_PERIOD / 2);
        clk = ~clk;
    end

    // Основной тест
    
    initial begin
        clk = 0;
        #(CLK_PERIOD);
        a = 32'b0_10000000_00000000000000000000000;
        b = 32'b0_01111111_00000000000000000000000;
        #(CLK_PERIOD);
        
        a = 32'b0_10000001_11100000000000000000000; //7.5
        b = 32'b1_10000001_01000000000000000000000;
        #(CLK_PERIOD);
        
        a = 32'b0_10000001_11100000000000000000000;
        b = 32'b0;
        forever begin 
            #(CLK_PERIOD);
            a = $urandom%(2**31);
            b = $urandom%(2**31);
        end
    end
    

//    end

endmodule