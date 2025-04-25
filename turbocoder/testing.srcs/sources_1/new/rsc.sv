module rsc #(
    parameter N = 2048
) (
    input  logic clk,
    input  logic srst,            
    input  logic en,               
    input  logic input_data,     
    output logic parity_bit        
);

    logic [2:0] shift_register;       // Сдвиговый регистр
    logic [3:0] generator1 = 4'b1011; // Полином 13
    logic [3:0] generator2 = 4'b1111; // Полином 15
    logic [$clog2(N):0] counter;      // Счетчик
    logic feedback_bit;               // Бит обратной связи

    always_ff @(posedge clk) begin
        if (srst) begin
            shift_register <= '0;
            feedback_bit <= '0;
            parity_bit <= '0;
            counter <= '0;
        end else if (en) begin
            if (counter < N) begin
                // Вычисление бита обратной связи
                feedback_bit <= (input_data & generator2[0]) ^ (shift_register[0] & generator2[1])
                              ^ (shift_register[1] & generator2[2]) ^ (shift_register[2] & generator2[3]);

                // Вычисление выходного бита
                parity_bit <= (feedback_bit & generator1[0]) ^ (shift_register[0] & generator1[1])
                            ^ (shift_register[1] & generator1[2]) ^ (shift_register[2] & generator1[3]);

                shift_register <= {feedback_bit, shift_register[1:0]};
                
                counter <= counter + 1;
            end
        end
    end
endmodule
