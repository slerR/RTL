module test_bench;

    logic clk;               // �������� ������
    logic srst;              // ���������� �����
    logic mode;              // ����� ������ (0 - ���� �����, 1 - ���� ����)
    logic [7:0] dout;        // ����� ��� �����������

    parameter CLK_PERIOD = 10; // ������ ��������� �������

    // ��������� ������ lab63
    main inst_main (
        .clk(clk),
        .srst(srst),
        .mode(mode),
        .dout(dout)
    );

    // ��������� ��������� �������
    always begin
        #(CLK_PERIOD / 2);
        clk = ~clk;
    end

    // ��������� ���������
    initial begin
        clk = 0;
        srst = 1;           // ���������� �����
        mode = 0;           // ������������� ����� �� ���� �����
        #(CLK_PERIOD);
        srst = 0;           // ������������ �����

        // ��������� ����������� �������
        repeat (10) begin
            #(CLK_PERIOD);
            $display("����������� �����, dout = %b", dout);
        end

        // ����������� �� ���������� �������
        mode = 1;           // ����������� �� ����� ����� ����
        repeat (10) begin
            #(CLK_PERIOD);
            $display("���������� �����, dout = %b", dout);
        end
        
        mode = 0;
        repeat (10) begin
            #(CLK_PERIOD);
            $display("����������� �����, dout = %b", dout);
        end


        $finish;            // ��������� ���������
    end

endmodule

