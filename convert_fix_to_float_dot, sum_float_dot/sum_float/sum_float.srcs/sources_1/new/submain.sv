module submain (
    input logic clk,
    input logic [15:0] din,
    output logic [31:0] dout
);
    // �������� ��� �������� �������� �������� � �������������� ����������
    logic [31:0] float;
    logic [31:0] float_1;
    logic [31:0] float_11;
    logic sign;
    logic [7:0] exponent;
    logic [23:0] mantissa;
    logic [15:0] abs_val;
    

    // ������� �����������
    always_ff @(posedge clk) begin
        float_1 <= float;
        float_11 <= float_1;
        dout <= float_11;
    end
   
    // ������� ����������� �� ������������� ����� � ���������
   always_comb begin
        exponent = 0;
        // ���������� ����
        if (din[15]) begin
            sign = 1;
            abs_val = ~din + 1; // ������ ����� ������������� ��� ���������
        end else begin
            sign = 0;
            abs_val = din;
        end

        if (din == 0) begin
            // ���� ������� �������� 0, �� ���������� ������������� ����
            float = 32'b0;
            end
        else
        // ����������� �������� � ���������� ����������
        begin
        mantissa = {8'b00000000, abs_val[14:0]}; // ����� 15 ������� ���
        // ������������
        
       
        end
        for (int i = 0; i < 23; i++) begin
            if (mantissa[23] == 1'b0) begin
                mantissa = mantissa << 1; // ����� ����� ��� ������������
                exponent += 1; // ���������� ����������
            end else begin
                break; // ����� �� �����, ���� ������� �� �����������
            end
         end
         
         exponent = 127 + 23  - exponent;
        float = {sign, exponent, mantissa[22:0]};
        end
endmodule

