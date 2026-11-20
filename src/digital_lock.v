
module digital_lock (
    input wire clk,
    input wire reset,
    input wire enter,
    input wire [3:0] password,

    output reg unlock,
    output reg locked,
    output reg [1:0] attempts
);

    // FSM states
    parameter IDLE    = 2'b00;
    parameter OPEN    = 2'b01;
    parameter LOCKOUT = 2'b10;

    reg [1:0] state, next_state;
    reg enter_prev;

    wire enter_pulse;

    // Detect rising edge of enter button
    assign enter_pulse = enter & ~enter_prev;

    // Password
    parameter [3:0] CORRECT_PASSWORD = 4'b1010;

    // State and input history registers
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            attempts <= 2'b00;
            enter_prev <= 1'b0;
        end
        else begin
            enter_prev <= enter;
            state <= next_state;

            if (state == IDLE && enter_pulse) begin
                if (password == CORRECT_PASSWORD)
                    attempts <= 2'b00;
                else if (attempts < 3)
                    attempts <= attempts + 1'b1;
            end
        end
    end

    // Next-state logic
    always @(*) begin
        next_state = state;

        case (state)

            IDLE: begin
                if (enter_pulse) begin
                    if (password == CORRECT_PASSWORD)
                        next_state = OPEN;
                    else if (attempts == 2)
                        next_state = LOCKOUT;
                end
            end

            OPEN: begin
                next_state = OPEN;
            end

            LOCKOUT: begin
                next_state = LOCKOUT;
            end

            default: begin
                next_state = IDLE;
            end

        endcase
    end

    // Output logic
    always @(*) begin
        unlock = 1'b0;
        locked = 1'b0;

        case (state)

            IDLE: begin
                unlock = 1'b0;
                locked = 1'b0;
            end

            OPEN: begin
                unlock = 1'b1;
                locked = 1'b0;
            end

            LOCKOUT: begin
                unlock = 1'b0;
                locked = 1'b1;
            end

            default: begin
                unlock = 1'b0;
                locked = 1'b0;
            end

        endcase
    end

endmodule
