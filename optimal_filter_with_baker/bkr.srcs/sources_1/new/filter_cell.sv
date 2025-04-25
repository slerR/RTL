module cell_filter 
#(
    parameter coef = 1
)
(
    input  logic               clk,            
    input  logic signed [15:0] data,           
    input  logic signed [24:0] feedback,       
    output logic signed [31:0] sum_out         
);

    logic signed [25:0] delay_line [0:2]  = '{default: '0};  // Массив для хранения 4 задержанных значений
    logic signed [25:0] sum = 25'b0;               

    // Вычисление суммы
    always_ff @(posedge clk) begin
        if (coef == 0) begin
            sum <= -data + feedback;
        end else begin
            sum <= data + feedback;
        end
    end

    // Линия задержки после вычисления суммы
    always_ff @(posedge clk) begin
        delay_line[0] <= sum;                 
        delay_line[1] <= delay_line[0];       
        delay_line[2] <= delay_line[1];            
    end
    
    assign sum_out = delay_line[2]; 
    
endmodule
