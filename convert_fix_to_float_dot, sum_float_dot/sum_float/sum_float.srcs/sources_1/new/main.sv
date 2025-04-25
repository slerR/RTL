module main (
    input logic clk,
    input logic [31:0] a,
    input logic [31:0] b,
    output logic [31:0] result_d2
);

    logic sign_a, sign_b, sign_result;
    logic [7:0] exponent_a, exponent_b, exponent_result;
    logic [23:0] mantissa_a, mantissa_b, mantissa_result;
    logic [24:0] mantissa_q; 
    logic [31:0] result_d1, result_d, result;

    always_ff @(posedge clk) begin
        // ���������� �����, ���������� � ��������
        sign_a = a[31];
        exponent_a = a[30:23];
        mantissa_a = {1'b1, a[22:0]}; 
        
        sign_b = b[31];
        exponent_b = b[30:23];
        mantissa_b = {1'b1, b[22:0]}; 

        // ���������� ��������� � ������ ������ ����� ������ �������
        if (exponent_a > exponent_b) begin
            mantissa_b = mantissa_b >> (exponent_a - exponent_b);
            exponent_result = exponent_a;
        end else begin
            mantissa_a = mantissa_a >> (exponent_b - exponent_a);
            exponent_result = exponent_b;
        end

        // �������� ��� ��������� ������� � ����������� �� ������
        if (sign_a == sign_b) begin
            // ���� ����� ����������, ���������� ��������
            mantissa_q = mantissa_a + mantissa_b;
            sign_result = sign_a;

            // �������� ������������ � ������������� �������� � ����������
            if (mantissa_q[24]) begin
                mantissa_result = mantissa_q[24:1]; // ����� ������ ��� ������������
                exponent_result = exponent_result + 1;
            end else begin
                mantissa_result = mantissa_q[23:0];
            end
        end else begin
            // ���� ����� ������, �������� ��������
            logic [23:0] abs_mantissa_a, abs_mantissa_b;
            
            // ����� ���������� �������� �������
            abs_mantissa_a = mantissa_a[23:0]; 
            abs_mantissa_b = mantissa_b[23:0]; 
            
            // ��������� �������
            if (abs_mantissa_a > abs_mantissa_b) begin
                mantissa_q = abs_mantissa_a - abs_mantissa_b;
                sign_result = sign_a; // ��������� ����� ����� ���� ������� �����
            end else begin
                mantissa_q = abs_mantissa_b - abs_mantissa_a;
                sign_result = sign_b; // ��������� ����� ����� ���� ������� �����
            end

            mantissa_result = mantissa_q[23:0];
        end

        // ������������ �������� ����� �������� ��� ���������
        while (mantissa_result[23] == 0 && exponent_result > 0) begin
            mantissa_result = mantissa_result << 1;
            exponent_result = exponent_result - 1;
        end

        // �������� ���������� �� ������� ��������
        if (mantissa_result[23] == 0) begin
            result = 32'b0; // ���� �������� ����� ����, �� ��������� ����� ����
        end else begin
            // ������������ ��������� ����������
            result = {sign_result, exponent_result, mantissa_result[22:0]};
        end
        result_d <= result;
        result_d1 <= result_d;
        result_d2 <= result_d1;
    end
endmodule
