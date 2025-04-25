module delay_with_srst(
    input logic clk,
    input logic srst,       // ������ ������
    input logic sample_in_v,
    input logic [15:0] sample_in,
    output logic [15:0] sample_out
);
    logic [15:0] delay_line [127:0]; // ������ ��� �������� 128 ��������

    always_ff @(posedge clk) begin
        if (srst) begin
            delay_line <= '{default: 16'b0}; // ����� ���� �������� � �������
        end else if (sample_in_v) begin
             delay_line <= {delay_line[126:0],sample_in}; // �����
        end
    end

    assign sample_out = delay_line[127]; // ����� ������ �������� �� ������
endmodule

