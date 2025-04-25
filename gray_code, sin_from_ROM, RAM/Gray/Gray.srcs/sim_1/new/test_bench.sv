module test_bench;
    logic clk;
    logic srst;
    logic [3:0] dout;

  parameter CLK_PERIOD = 10; 
  
    lab7 inst_lab7 (
        .clk(clk),
        .srst(srst),
        .dout(dout)
    );
    
    always begin
        #(CLK_PERIOD / 2);
        clk = ~clk;
    end


    initial begin
        clk = 0;
        srst = 1;          
        #(CLK_PERIOD);  
        srst = 0;          

        #(10 * CLK_PERIOD); 
        srst = 1;           
        #(CLK_PERIOD);  
        srst = 0;
        #(10 * CLK_PERIOD);
        $finish;            
    end

endmodule

