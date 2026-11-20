
`timescale 1ns / 1ps

module digital_lock_tb;

    reg clk;
    reg reset;
    reg enter;
    reg [3:0] password;

    wire unlock;
    wire locked;
    wire [1:0] attempts;

    digital_lock uut (
        .clk(clk),
        .reset(reset),
        .enter(enter),
        .password(password),
        .unlock(unlock),
        .locked(locked),
        .attempts(attempts)
    );

    // Clock generation: 10 ns period
    always #5 clk = ~clk;

    // Task to enter password
    task enter_password;
        input [3:0] pass;
        begin
            @(negedge clk);
            password = pass;
            enter = 1'b1;

            @(negedge clk);
            enter = 1'b0;

            repeat (2) @(negedge clk);
        end
    endtask

    initial begin

        clk = 0;
        reset = 1;
        enter = 0;
        password = 4'b0000;

        $display("DIGITAL LOCK FSM TEST STARTED");

        // Reset
        repeat (2) @(negedge clk);
        reset = 0;

        // Test 1: Incorrect password
        enter_password(4'b0001);
        $display("Attempt 1: %b", attempts);

        // Test 2: Incorrect password
        enter_password(4'b0011);
        $display("Attempt 2: %b", attempts);

        // Test 3: Incorrect password
        enter_password(4'b0101);
        $display("Attempt 3: %b", attempts);

        if (locked && !unlock)
            $display("PASS: LOCKOUT ACTIVATED");
        else
            $display("FAIL: LOCKOUT NOT ACTIVATED");

        // Test 4: Attempt correct password during lockout
        enter_password(4'b1010);

        if (locked && !unlock)
            $display("PASS: ACCESS DENIED DURING LOCKOUT");
        else
            $display("FAIL: LOCKOUT BYPASSED");

        // Test 5: Reset
        @(negedge clk);
        reset = 1;

        @(negedge clk);
        reset = 0;

        repeat (2) @(negedge clk);

        if (!locked && !unlock && attempts == 0)
            $display("PASS: RESET SUCCESSFUL");
        else
            $display("FAIL: RESET FAILED");

        // Test 6: Correct password
        enter_password(4'b1010);

        if (unlock && !locked)
            $display("PASS: CORRECT PASSWORD UNLOCKED");
        else
            $display("FAIL: CORRECT PASSWORD REJECTED");

        $display("DIGITAL LOCK FSM TEST COMPLETED");

        $finish;
    end

endmodule
