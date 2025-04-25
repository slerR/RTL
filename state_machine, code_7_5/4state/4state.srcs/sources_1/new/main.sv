module lab82(
    input logic clk,            
    input logic srst,           
    input logic btn,            
    input logic [2:0] x1,       
    input logic [2:0] x2,       
    output logic [7:0] y       
);

    // Определение состояний
    typedef enum logic [1:0] {
        S0,  // 0: Мигание светодиодом
        S1,  // 1: Суммирование
        S2,  // 2: Умножение
        S3   // 3: Счётчик Грея
    } state_t;

    state_t state = S0, nextstate;   

    logic [7:0] led_blink;      // Выход мигающего светодиода
    logic [7:0] sum_out;        // Результат суммирования
    logic [7:0] mult_out;       // Результат умножения
    logic [7:0] gray_count;     // Счётчик Грея
    logic [7:0] gray_counter;
    logic [25:0] cnt1 = 26'b0;
    logic p;
    logic p_1;  // Счётчик для перехода к инкременту Грея

    logic [26:0] cntr; 
    logic T_1;
    logic T_25;  
    logic en_blink;
    logic en_gray;
    
    // Сигналы активации на основе счётчика
    assign en_blink = cntr[26]&(~T_1);  // 26-й бит для мигания раз в 1 секунду         
    assign en_gray = cntr[24]&(~T_25);
    assign p1 = cnt1[25]&(~p);   // 24-й бит для обновления Грея раз в 0,25 секунды               
    
    // Основной процесс синхронного сброса и инкрементации
    always_ff @(posedge clk) begin
        if (srst) begin
            state <= S0;        
            cntr <= 27'b0;
            led_blink <= 8'b00000001;  
            gray_counter <= 0;
            gray_count <= 0;
        end else begin
            cntr <= cntr + 1;
            T_1 <= cntr[26];
            T_25 <= cntr[24];    
            if (en_blink) begin
                led_blink[0] <= ~led_blink[0];  
            end
            if (btn) begin
                cnt1 <= cnt1+1;
                  
            end
            p <= cnt1[25];
            if (p1) begin
                state <= nextstate;  
            end
            sum_out <= x1 + x2;  
            mult_out <= x1 * x2; 
            if (en_gray) begin
                gray_counter <= gray_counter + 1;  
                gray_count <= gray_counter ^ (gray_counter >> 1); 
            end           
        end
    end

    always_comb begin
        case (state)
            S0: nextstate = S1;
            S1: nextstate = S2;
            S2: nextstate = S3;
            S3: nextstate = S0;
            default: nextstate = S0;
        endcase
    end
    always_ff @(posedge clk) begin
    case (state)
            S0: y = led_blink;  
            S1: y = sum_out;    
            S2: y = mult_out;   
            S3: y = gray_count; 
            default: y = 8'b00000000; 
        endcase
    end
endmodule