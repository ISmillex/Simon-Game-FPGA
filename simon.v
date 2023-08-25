`timescale 1ns / 1ps
module simon(
   input clk,
    input reset,
    input [4:0] buttons,
    output reg[3:0] led,
    output reg[5:0] state_led,
    output reg [6:0] out, 
    output reg [3:0] anod
    );
    
    integer i=0;
    integer j=0;
    reg [31:0] row_control = 0;
    reg [31:0] counter;
    reg slow_clk;
    reg [3:0] matrix[31:0];
    reg [3:0] gamer_matrix[31:0];
    reg [31:0]user_index = 0;
    wire [4:0]r_buttons;
    reg [31:0] random_counter = 0;
    reg [1:0] rnd = 0;
    reg [13:0] whichRow = 0;
    reg isGameFinished = 0;
    integer inputControl = 0;
    reg isPressed = 0;       
    
    //////////////////////////////
    
    reg [19:0] refresh_counter;
    reg [3:0] led_bcd;
    
    reg [3:0] a;
    reg [3:0] b;
    reg [3:0] c;
    reg [3:0] d;
    
    reg [3:0] a_bcd;
    reg [3:0] b_bcd;
    reg [3:0] c_bcd;
    reg [3:0] d_bcd;
           
    
    localparam b_down = 5'b01000, b_up = 5'b00001, b_left = 5'b00010, b_right = 5'b00100, b_start = 5'b10000;
    localparam ld6_down = 4'b0001, ld9_up = 4'b1000, ld8_left = 4'b0100, ld7_right = 4'b0010, reset_led = 4'b0000;
    localparam ld12_down = 4'b0001, ld15_up = 4'b1000, ld14_left = 4'b0100, ld13_right = 4'b0010;
    
    localparam RANDOM_ON_STATE = 4'b0001;
    localparam RANDOM_OFF_STATE = 4'b0010;
    localparam INPUT_STATE = 4'b0011;
    localparam CHECK_STATE = 4'b0100;
    localparam LED_STATE = 4'b0110;
    localparam GAME_OVER_STATE = 4'b0101;
    localparam MATRIX_OFF_STATE = 4'b0111;
    localparam LED_OFF_STATE = 4'b1000;
    
    reg [3:0] STATE = 4'b0000;
    reg [3:0] STATE_NEXT = 4'b0000;
    
    initial begin
        for(i=0; i<32; i=i+1) begin
            matrix[i] = 0;
            gamer_matrix[i] = 0;
        end            
    end
   
    debounce db(buttons,clk,r_buttons);
    
    always@(posedge |buttons)begin
        rnd=random_counter%4;
    end

    always@(posedge clk) begin
        if(buttons == b_start)
            isPressed = 1;
        else
            isPressed = 0;
    end
   
    always@(posedge |r_buttons ) begin
            if(buttons == b_start && STATE == 0) begin
                STATE_NEXT = RANDOM_ON_STATE;
            end
           
           if(STATE == GAME_OVER_STATE && buttons == b_start) begin
                user_index = 0;
                    
                STATE_NEXT = RANDOM_ON_STATE;
                    
                for(j=0; j<32; j=j+1) begin
                     gamer_matrix[j] = 0;
                end        
            end
         
            if(STATE == INPUT_STATE)
                begin
                         
                    case(buttons)
                        b_down : 
                            begin
                                gamer_matrix[user_index] = ld6_down;
                            end
                        b_up : 
                            begin
                                gamer_matrix[user_index] = ld9_up;
                            end
                        b_left : 
                            begin 
                                 gamer_matrix[user_index] = ld8_left;
                            end
                        b_right : 
                            begin
                                gamer_matrix[user_index] = ld7_right;
                            end
                      
                    endcase
                                                        
                    user_index = user_index +1;
                    
                    if(user_index >= whichRow) begin
                        user_index = 0;
                    end                              
                end
        end
       
    always@(posedge slow_clk) begin
            
            if(STATE == 0)
                STATE = STATE_NEXT;        
            
            case(STATE)
                RANDOM_ON_STATE :
                begin
                        
                        state_led = 6'b000001;
                      
                        case(rnd)
                                0:  matrix[whichRow] = ld9_up;
                                1:  matrix[whichRow] = ld8_left;
                                2:  matrix[whichRow] = ld7_right;
                                3:  matrix[whichRow] = ld6_down;
                        endcase
                        
                        led = matrix[whichRow];                        
                        whichRow = whichRow +1;                        
                        STATE= RANDOM_OFF_STATE;                                         
                end
                    
                RANDOM_OFF_STATE :
                begin
                        
                        state_led = 6'b000010;
                        
                        led = reset_led;
                         
                        STATE = INPUT_STATE;
                                          
                end
                
                INPUT_STATE :
                begin                    
                        state_led = 6'b000100;
                        
                        inputControl = inputControl + 1;
                        
                        if(inputControl >= 2*whichRow) begin
                            STATE = CHECK_STATE;
                            inputControl = 0;
                        end                       
                end
                
                CHECK_STATE :
                begin
                        state_led = 6'b001000; 
                        
                        isGameFinished = 0;
                        
                        for(i=0; i<32 && isGameFinished == 0; i=i+1) begin
                            if(matrix[i] != gamer_matrix[i])
                            isGameFinished = 1;
                        end
                        
                        if(isGameFinished == 1) begin
                            STATE = GAME_OVER_STATE;
                            whichRow = 0;
                        end
                        else begin
                            STATE = LED_STATE; 
                        end
                                                  
                        a = whichRow % 10;
                        b = (whichRow/10)%10;
                        c = (whichRow/100) % 10;
                        d = (whichRow/1000)%10;
                        
                        case (a)
                            0: a_bcd = 4'b0000;
                            1: a_bcd = 4'b0001;
                            2: a_bcd = 4'b0010;
                            3: a_bcd = 4'b0011;
                            4: a_bcd = 4'b0100;
                            5: a_bcd = 4'b0101;
                            6: a_bcd = 4'b0110;
                            7: a_bcd = 4'b0111;
                            8: a_bcd = 4'b1000;
                            9: a_bcd = 4'b1001;
                        endcase
                        
                         case (b)
                            0: b_bcd = 4'b0000;
                            1: b_bcd = 4'b0001;
                            2: b_bcd = 4'b0010;
                            3: b_bcd = 4'b0011;
                            4: b_bcd = 4'b0100;
                            5: b_bcd = 4'b0101;
                            6: b_bcd = 4'b0110;
                            7: b_bcd = 4'b0111;
                            8: b_bcd = 4'b1000;
                            9: b_bcd = 4'b1001;
                        endcase
                         case (c)
                            0: c_bcd = 4'b0000;
                            1: c_bcd = 4'b0001;
                            2: c_bcd = 4'b0010;
                            3: c_bcd = 4'b0011;
                            4: c_bcd = 4'b0100;
                            5: c_bcd = 4'b0101;
                            6: c_bcd = 4'b0110;
                            7: c_bcd = 4'b0111;
                            8: c_bcd = 4'b1000;
                            9: c_bcd = 4'b1001;
                        endcase
                         case (d)
                            0: d_bcd = 4'b0000;
                            1: d_bcd = 4'b0001;
                            2: d_bcd = 4'b0010;
                            3: d_bcd = 4'b0011;
                            4: d_bcd = 4'b0100;
                            5: d_bcd = 4'b0101;
                            6: d_bcd = 4'b0110;
                            7: d_bcd = 4'b0111;
                            8: d_bcd = 4'b1000;
                            9: d_bcd = 4'b1001;
                        endcase
                end
                       
                GAME_OVER_STATE :
                begin
                        state_led = 6'b010000;
                                              
                        whichRow = 0;
                        for(i=0; i<32; i=i+1)
                            matrix[i] = 0;  
                        
                        if(isPressed)
                            STATE = 0;     
               end
               
               LED_STATE :
               begin                   
                        
                        led = matrix[row_control];
                        
                        if(row_control <30 && matrix[row_control+1] == led) begin
                            STATE = MATRIX_OFF_STATE;
                        end
                        else begin                            
                            row_control = row_control+1;                       
                            if(row_control >= whichRow) begin
                                row_control = 0;
                                STATE = LED_OFF_STATE;
                            end                           
                       end        
                end
                
                MATRIX_OFF_STATE :
                begin                        
                    led = reset_led;                        
                    row_control = row_control+1;                        
                    STATE = LED_STATE;                        
                end
                
                LED_OFF_STATE :
                begin                       
                    led = reset_led;                        
                    STATE = RANDOM_ON_STATE;                        
                end 
           endcase
        end    
   
    always @(posedge clk) begin       
            random_counter = random_counter + 1; 
            if(counter == 10**8/2) begin
                counter = 0;
                slow_clk= ~slow_clk;
            end
            counter = counter +1;   
    end
      
    always @(clk) begin
        case(refresh_counter[19:18])
        2'b00: begin
            anod = 4'b1110; 
            led_bcd = a_bcd;
        end
        2'b01: begin
            anod = 4'b1101; 
            led_bcd = b_bcd;
        end
        2'b10: begin
            anod = 4'b1011; 
            led_bcd = c_bcd;
        end
        2'b11: begin
            anod = 4'b0111; 
            led_bcd = d_bcd;
        end
        
        endcase
    end
    
    always @(clk) begin
        case(led_bcd)
            4'b0000: out = 7'b0000001; // "0"     
            4'b0001: out = 7'b1001111; // "1" 
            4'b0010: out = 7'b0010010; // "2" 
            4'b0011: out = 7'b0000110; // "3" 
            4'b0100: out = 7'b1001100; // "4" 
            4'b0101: out = 7'b0100100; // "5" 
            4'b0110: out = 7'b0100000; // "6" 
            4'b0111: out = 7'b0001111; // "7" 
            4'b1000: out = 7'b0000000; // "8"     
            4'b1001: out = 7'b0000100; // "9" 
            default: out = 7'b0000001; // "0"
        endcase
    end
   
    always @(posedge clk) begin 
        refresh_counter <= refresh_counter + 1;
    end 

endmodule
