module tailLightController_tb();

    // Declare signals
    reg clk, reset, left, right;
    wire [7:0] LEDS;

    // Instantiate the tailLightController module
    tailLightController uut (
        .clk(clk),
        .reset(reset),
        .left(left),
        .right(right),
        .LEDS(LEDS)
    );

    // Clock generation
    always begin
        #5 clk = ~clk;
    end

    // Testbench stimulus
    initial begin
        // Initialize signals
        clk = 0;
        reset = 0;
        left = 0;
        right = 0;

        // Reset the system
	#10 left = 1;
	#10 reset =1;
	#10 reset = 0;left = 0;

        // Test left signal
        #10 left = 1;
        #10 left = 0;

	// Test left signal(repeatiton)
        #60 left = 1;
	#70 left = 0;

        // Test right signal
        #50 right = 1;
        #10 right = 0;
	
	// Test Right signal(repeatiton)
        #60 right = 1;
	#70 right = 0;
        
    end

endmodule
