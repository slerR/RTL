module test_bench;

    parameter CLK_PERIOD = 10;
    logic clk;
    logic we;
    logic [1:0] address;
    logic [2:0] din;
    logic [2:0] dout;

    
    lab7 inst_main (
        .clk(clk),
        .we(we),
        .address(address),
        .din(din),
        .dout(dout)
    );
    
    
    initial begin
        clk = 0;       
        #CLK_PERIOD;              
    end
    
    always begin
        #(CLK_PERIOD / 2);
        clk = ~clk;       
    end
    
    initial begin
        we = 0;
        address = 2'b00;
        din = 3'b000;
        #(CLK_PERIOD);

        we = 1;         
        address = 2'b00;
        din = 3'b101;
        #(CLK_PERIOD);

        address = 2'b01;
        din = 3'b011;
        #(CLK_PERIOD);

        we = 0;         
        address = 2'b00;
        #(CLK_PERIOD);

        address = 2'b01;
        #(CLK_PERIOD);

        we = 1;         
        address = 2'b10;
        din = 3'b111;
        #(CLK_PERIOD);
        
        $finish;
    end

endmodule