module lab6 (
    input logic clk,          // �������� ������
    input logic srst,         // ���������� �����
    output logic [7:0] dout   // 8-������ ����� ��� �����������
);

    logic [29:0] cntr;

    assign dout = cntr[29:22];

    always_ff @(posedge clk) begin
        if (srst) begin 
        cntr <= 30'b0;
        end else 
            if (cntr == 30'd1073741823) begin 
                cntr <= 30'b0;
            end else begin
                cntr <= cntr + 1;
            end
        end 
        
endmodule
