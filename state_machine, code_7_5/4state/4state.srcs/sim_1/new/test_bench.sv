module test_bench;

    logic clk;                // �������� ������
    logic srst;               // ���������� �����
    logic btn;                // ������ ��� ������������ ���������
    logic [2:0] x1;           // ������ ���� ��� ��������
    logic [2:0] x2;           // ������ ���� ��� ��������
    logic [7:0] y;            // ����� ������ lab82

    parameter CLK_PERIOD = 10; // ������ ��������� �������
    
    lab82 inst_lab82 (
        .clk(clk),
        .srst(srst),
        .btn(btn),
        .x1(x1),
        .x2(x2),
        .y(y)
    );
    
    always begin
        #(CLK_PERIOD / 2);
        clk = ~clk;
    end
    
    initial begin
        clk = 0;
        srst = 1;   
        btn = 0;
        x1 = 3'b000; 
        x2 = 3'b000;
        #CLK_PERIOD; 
        srst = 0;    
        #(CLK_PERIOD*20);
        btn = 1;
        x1 = 3'b101;  // ������ ������� ������: 5
        x2 = 3'b010;  // ������ ������� ������: 2
        #CLK_PERIOD;
        btn = 0; // ��������� ������
        #(CLK_PERIOD*5);
        btn = 1;
        #CLK_PERIOD;
        btn = 0;
        #(CLK_PERIOD*5);
        btn = 1;
        #CLK_PERIOD;
        btn = 0;
        #(CLK_PERIOD*15);
        btn = 1;
        #CLK_PERIOD;
        btn = 0;
        #(20 * CLK_PERIOD);
        $finish;
    end

endmodule

