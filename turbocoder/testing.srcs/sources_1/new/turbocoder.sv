module turbocoder #(
    parameter N = 2048
)(
    input logic clk,
    input logic srst,
    input logic input_data,
    output logic start,
    output logic output_data
);

    logic done, done1;
    
    (* ram_style = "distributed" *) logic bram_input[N-1:0];  
    (* ram_style = "distributed" *) logic bram_rsc1[N-1:0];  
    (* ram_style = "distributed" *) logic bram_rsc2[N-1:0];  

    logic [$clog2(2*N):0] write_counter;
    logic [$clog2(2*N):0] write_allow;
    logic [$clog2(N):0] read_counter;
    logic [1:0] addr;

    logic rsc_1, rsc_2, prm_data;

    rsc rsc1 (
        .clk(clk),
        .srst(srst),
        .en(1),
        .input_data(input_data),
        .parity_bit(rsc_1)
    );

    permutation permutation (
        .clk(clk),
        .srst(srst),
        .input_bit(input_data),
        .output_bit(prm_data),
        .done(done)
    );

    rsc rsc2 (
        .clk(clk),
        .srst(srst),
        .en(done),
        .input_data(prm_data),
        .parity_bit(rsc_2)
    );

    // Процесс для управления write_counter
    always_ff @(posedge clk) begin
        if (srst) begin
            write_counter <= '0;
            write_allow  <= '0;
        end else begin
            if (write_allow < N) begin
                write_counter <= write_counter + 1;
                write_allow <= write_allow + 1;
            end else if (done && write_allow < 2*N) begin
                write_counter <= write_counter + 1;
                write_allow <= write_allow + 1;
            end
        end
    end

    // Процесс для записи в bram_input
    always_ff @(posedge clk) begin
        if (write_allow < N) begin
            bram_input[write_counter] <= input_data;
        end
    end

    // Процесс для записи в bram_rsc1
    always_ff @(posedge clk) begin
        if (write_allow > 0 && write_allow <= N) begin
            bram_rsc1[write_counter-1] <= rsc_1;
        end
    end

    // Процесс для записи в bram_rsc2
    always_ff @(posedge clk) begin
        if (write_allow > N && write_allow <= 2*N) begin
            bram_rsc2[write_counter - (N+1)] <= rsc_2;
        end
    end

    // Процесс для чтения и вывода данных
    always_ff @(posedge clk) begin
        if (srst) begin
            read_counter <= '0;
            addr <= '0;
            start <= '0;
            output_data <= '0;
        end else if (write_allow > N+1 && read_counter < N) begin
            start <= 1;
            case (addr)
                2'b00: begin
                    output_data <= bram_input[read_counter]; 
                    addr <= addr + 1;
                end
                2'b01: begin
                    output_data <= bram_rsc1[read_counter];
                    addr <= addr + 1;
                end
                2'b10: begin
                    output_data <= bram_rsc2[read_counter];
                    addr <= 0;
                    read_counter <= read_counter + 1;
                end
            endcase
        end
    end
endmodule