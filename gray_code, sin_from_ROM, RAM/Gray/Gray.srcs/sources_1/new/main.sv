    module lab7 (
     input logic clk ,
     input logic srst,
     output logic [3 : 0] dout
    );
        logic [26:0] cntr;             
        logic cntr26d;           
        logic en;                
    
        assign en = cntr[26] & (~cntr26d);  
    
        always_ff @(posedge clk) begin
            cntr26d <= cntr[27];
        end
    
        always_ff @(posedge clk) begin
            if (srst) begin
                cntr <= 27'b0;   
            end else begin
                cntr <= cntr + 1; 
            end
        end
        
        logic [3:0] gray_rom [0:15];
        
        initial begin
            gray_rom[ 0] = 4'b0000;
            gray_rom[ 1] = 4'b0001;
            gray_rom[ 2] = 4'b0011;
            gray_rom[ 3] = 4'b0010;
            gray_rom[ 4] = 4'b0110;
            gray_rom[ 5] = 4'b0111;
            gray_rom[ 6] = 4'b0101;
            gray_rom[ 7] = 4'b0100;
            gray_rom[ 8] = 4'b1100;
            gray_rom[ 9] = 4'b1101;
            gray_rom[10] = 4'b1111;
            gray_rom[11] = 4'b1110;
            gray_rom[12] = 4'b1010;
            gray_rom[13] = 4'b1011;
            gray_rom[14] = 4'b1001;
            gray_rom[15] = 4'b1000;
        end
    
        logic [3:0] adress_counter = 4'b0;
        always_ff @(posedge clk or posedge srst) begin
            if (srst)
                adress_counter <= 4'b0;  
            else if (en) begin    
                adress_counter <= adress_counter + 1;  
            end
        end
    
        always_ff @(posedge clk) begin
            dout <= gray_rom[adress_counter];
        end
    endmodule
