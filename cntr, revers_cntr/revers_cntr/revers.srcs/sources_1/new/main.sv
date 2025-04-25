module main (
    input logic clk,          // �������� ������
    input logic srst,         // ���������� �����
    input logic mode,         // 0 - ����������� ����, 1 - ���������� ����
    output logic [7:0] dout   // 8-������ ����� ��� �����������
);

    logic [29:0] cntr;        // 30-������ �������

    // ����������� 8 ������� ��� �������� ��� �����������
    assign dout = cntr[29:22];

    // �������� ���� ��� ����������� �����
    always_ff @(posedge clk) begin
        if (srst) begin
            // ���� ������ ������ �������, ������������� ������� � 0
            cntr <= 30'b0;
        end else begin
            // �������� ����������� ����� �� ������ �������� `mode`
            if (mode == 1'b0) begin
                // ����������� ������� (������� �����)
                if (cntr == 30'd1073741823) begin  // 2^30 - 1
                    cntr <= 30'b0;  // ������������, ���������� � 0
                end else begin
                    cntr <= cntr + 1;  // ����������� �� 1
                end
            end else begin
                // ���������� ������� (������� ����)
                if (cntr == 30'b0) begin
                    cntr <= 30'd1073741823;  // ���� ������� � ����, �� ������������� ������������ ��������
                end else begin
                    cntr <= cntr - 1;  // ��������� �� 1
                end
            end
        end
    end

endmodule

