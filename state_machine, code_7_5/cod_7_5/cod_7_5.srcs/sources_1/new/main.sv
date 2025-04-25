module lab81(
    input logic clk,           // ¬ход тактового сигнала
    input logic srst,          // ¬ход сигнала сброса
    input logic info,          // ¬ход информационного бита
    output logic [1:0] coded   // ƒвухразр€дный выход дл€ кодированной последовательности
);

    typedef enum logic [1:0] {
        s00, s01, s10, s11     
    } t_state;
    assign coded[1:0] = 2'b00;
    t_state state = s00, nextstate; 
    always_comb begin
     nextstate=state;
        case(state)
            s00: nextstate = (info == 1'b0) ? s00 : s10;
            s01: nextstate = (info == 1'b0) ? s00 : s10;
            s10: nextstate = (info == 1'b0) ? s01 : s11;
            s11: nextstate = (info == 1'b0) ? s01 : s11;
            default: nextstate = s00;
        endcase
    end

    always_ff @(posedge clk) begin
        if (srst) begin
            state <= s00;        
            //coded <= 2'b00;     
        end else begin
        state <= nextstate;
         case(state)
            s00: coded <= (info == 1'b0) ? 2'b00 : 2'b11;
            s01: coded <= (info == 1'b0) ? 2'b11 : 2'b00;
            s10: coded <= (info == 1'b0) ? 2'b10 : 2'b01;
            s11: coded <= (info == 1'b0) ? 2'b01 : 2'b10;
            default: coded = 2'b00;
        endcase 
        end
    end

endmodule
