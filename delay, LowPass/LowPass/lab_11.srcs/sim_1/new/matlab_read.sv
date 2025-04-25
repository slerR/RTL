module tb_matlab_read;

    logic clk;
    logic srst;
    logic rfd;
    logic dv;
    logic [15:0] data;
    logic [15:0] dout;  // ����� ������ �� ������ main
    parameter CLK_PERIOD = 10;

    integer file_rd, file_wr;  // ���������� integer ��� ������������ ������

    // �������� ��������� ��������� �������
    always begin
        #(CLK_PERIOD / 2);
        clk = ~clk;       
    end

    // ��������� ������ � ���������� ���������
    initial begin
        // ��������� ��������� ��������
        clk = 0;
        srst = 1;    // ���������� ����� �������
        rfd = 1;     // ���������� ������

        // ��������� ������
        #(2 * CLK_PERIOD);
        srst = 0;  // ������� �����

        // �������� ������ ����������
        #(CLK_PERIOD);

        // ���������� � ������ ������
        $display("Starting file operations...");

        // �������� ������
        file_rd = $fopen("C:\\generic_sin\\data2fpga.dat", "r"); // �������� ����� ��� ������
        if (file_rd == 0) begin
            $display("Error: File '%s' could not be opened for reading.", "C:\\generic_sin\\data2fpga.dat");
            $finish;
        end 

        file_wr = $fopen("C:\\generic_sin\\data_from_fpga.dat", "w"); // �������� ����� ��� ������
        if (file_wr == 0) begin
            $display("Error: File '%s' could not be opened for writing.", "C:\\generic_sin\\data_from_fpga.dat");
            $finish;
        end else begin
            $display("File '%s' opened for writing.", "C:\\generic_sin\\data_from_fpga.dat");
        end

        // ������ ��������� � ��������� ��������� ��� �������� ������
        #(1000 * CLK_PERIOD);

        // �������� ������
        $fclose(file_rd);
        $fclose(file_wr);

        // ��������� ���������
        $finish;
    end

    // ������������ ������ main
    main inst_main (
        .clk(clk),            // �������� ������
        .din_v(dv),           // ������ ���������� ������
        .din(data),           // ������ ��� ���������
        .dout(dout)           // �������� ������
    );

    // ��������� ������: �� ������ ����� ������ ������ � �������� � ������
    always_ff @(posedge clk) begin
        if (srst) begin
            data <= 16'b0;  // ��� ������ �������� ������
            dv <= 0;        // ������ ���������� ������ ��������
        end else if (rfd) begin
            // ������ ������ �� ����� �� ������ �����
            if (file_rd != 0 && !$feof(file_rd)) begin
                // ������ ������ �� �����, ���������� ������������ ��������
                $fscanf(file_rd, "%d\n", data); // ������ �� �����
                dv <= 1;  // ��������� ���������� ������
            end else begin
                dv <= 0;  // ���������� ����������, ���� ���� ����������
            end
            
            // ������ ������ dout � ����
            if (file_wr != 0) begin
                $fwrite(file_wr, "%d\n", dout);
            end
        end else begin
            dv <= 0;         // ������ ���������� ������ ��������, ����� rfd �� �������
        end
    end

endmodule
