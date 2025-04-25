module tb_lab81;

    // ������� ��� ������������
    logic clk;
    logic srst;
    logic info = 1'b1;
    logic [1:0] coded;

    parameter CLK_PERIOD = 10; 

    lab81 inst_lab81 (
        .clk(clk),
        .srst(srst),
        .info(info),
        .coded(coded)
    );

    always begin
        #(CLK_PERIOD / 2);
        clk = ~clk;       
    end

    // �������� ����
    initial begin
        
        clk = 0;
        srst = 1;
       
        
        #(CLK_PERIOD/2); 
        srst = 0;
        
        // �������� ��������������� ���� ����������
         
         #(29*CLK_PERIOD) // ���� 1
        $finish;
    end

endmodule

