module lab93 (
    input  logic         clk,
    input  logic [7:0]   x1,   // ������ ����� � ������� (1,8,4)
    input  logic [7:0]   x2,   // ������ ����� � ������� (1,8,4)
    output logic [7:0]   dout  // ��������� ��������� � ������� (1,8,4)
);

    logic signed [15:0] full_product;
    logic signed [15:0] dop_bit;   
    logic signed [7:0] rounded_result; 
    logic signed [7:0]x11;
    logic signed [7:0]x22;

    always_ff @(posedge clk) begin
        // ������ ��������� ���������
        x11 =  $signed(x1);
        x22 =  $signed(x2);
        full_product = $signed(x1) * $signed(x2);

        // ���������� � ������ �������� �������������� ���� (full_product[3])
        rounded_result = {full_product[15],full_product[10:4]}+ full_product[3];

        if (full_product > 8'sb0111_1111) begin
            dout = 8'b0111_1111;  // ������������� ���������
        end else if (full_product < 8'sb1000_0000) begin
            dout = 8'b1000_0000; // ������������� ���������
        end else begin
            dout = rounded_result; // ����������� �������� ��� ���������
        end
    end
endmodule
