module lab91 (
    input  logic        clk,
    input  logic [15:0] x1,   // ������ ����� � ������� (1,16,8)
    input  logic [ 7:0] x2,   // ������ ����� � ������� (1,8,12)
    output logic [20:0] dout  // ��������� ��������
);

    logic signed [20:0] x1_ext; // ����������� x1 �� ������� (1,21,12)
    logic signed [20:0] x2_ext; // ����������� x2 �� ������� (1,21,12)
       // ����� � �������������� ����� ��� ��������� ������������

    always_ff @(posedge clk) begin
        x1_ext = {x1[15],x1, 4'b0000}; 
        x2_ext = {{13{x2[7]}}, x2};           
        dout = x1_ext + x2_ext;
        
    end
endmodule
