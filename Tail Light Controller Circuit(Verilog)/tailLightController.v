 
module tailLightController (
    input clk, reset, left, right,
    output reg [7:0] LEDS
);

parameter [3:0] S0 = 0,
                S1 = 1,
                S2 = 2,
                S3 = 3,
                S4 = 4,
                S5 = 5,
                S6 = 6,
                S7 = 7,
		S8 = 8;

reg [3:0] state_reg, state_next;

// State Register
always @(posedge clk or posedge reset) begin
    if (reset)
        state_reg <= S0;
    else
        state_reg <= state_next;
end

// Next state and output logic
always @(*) begin
    // Default values
    state_next = state_reg;
    LEDS = 8'b00000000;

    case (state_reg)
        S0: begin
            if (left)
                state_next = S1;
            else if (right)
                state_next = S5;
        end

        S1: begin
            LEDS = 8'b00010000;
            state_next = S2;
        end

        S2: begin
            LEDS = 8'b00110000;
            state_next = S3;
        end

        S3: begin
            LEDS = 8'b01110000;
            state_next = S4;
        end

        S4: begin
            LEDS = 8'b11110000;
            state_next = S0;
        end

        S5: begin
            LEDS = 8'b00001000;
            state_next = S6;
        end

        S6: begin
            LEDS = 8'b00001100;
            state_next = S7;
        end

        S7: begin
            LEDS = 8'b0001110;
            state_next = S8;
        end
	
 	S8: begin
            LEDS = 8'b00001111;
            state_next = S0;
        end

        default: state_next = S0;
    endcase
end

endmodule
