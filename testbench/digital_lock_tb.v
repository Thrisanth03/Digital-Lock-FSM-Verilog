

`timescale 1ns / 1ps

module digital_lock_tb;

    reg clk;
    reg reset_n;
    reg enter_n;
    reg [3:0] password;

    wire unlock;
    wire locked;
    wire [1:0] attempts;

    // DUT instantiation
    digital_lock uut (
        .clk(clk),
        .reset_n(reset_n),
        .enter_n(enter_n),
        .password(password),
        .unlock(unlock),
        .locked(locked),
        .attempts(attempts)
    );

    // 100 MHz equivalent simulation clock
    always #5 clk = ~clk;

    // Task for entering password
    task enter_password;
        input [3:0] pass;
        begin
            @(negedge clk);
            password = pass;

            // Press enter
            enter_n = 1'b0;

            // Hold button for multiple clock cycles
            repeat (3) @(negedge clk);

            // Release enter
            enter_n = 1'b1;

            repeat (2) @(negedge clk);
        end
    endtask

    initial begin

        // Initial values
        clk = 0;
        reset_n = 0;
        enter_n = 1;
        password = 4'b0000;

        $display("--------------------------------");
        $display(" DIGITAL LOCK FSM TESTBENCH");
        $display("--------------------------------");

        // Reset system
        repeat (3) @(negedge clk);
        reset_n = 1;

        // TEST 1: First incorrect password
        $display("\nTEST 1: First incorrect attempt");

        enter_password(4'b0001);

        if (attempts == 1 && !locked)
            $display("PASS: Attempt count = 1");
        else
            $display("FAIL: First attempt");

        // TEST 2: Second incorrect password
        $display("\nTEST 2: Second incorrect attempt");

        enter_password(4'b0011);

        if (attempts == 2 && !locked)
            $display("PASS: Attempt count = 2");
        else
            $display("FAIL: Second attempt");

        // TEST 3: Third incorrect password
        $display("\nTEST 3: Third incorrect attempt");

        enter_password(4'b0101);

        if (attempts == 3 && locked && !unlock)
            $display("PASS: LOCKOUT ACTIVATED");
        else
            $display("FAIL: LOCKOUT NOT ACTIVATED");

        // TEST 4: Correct password during lockout
        $display("\nTEST 4: Correct password during lockout");

        enter_password(4'b1010);

        if (locked && !unlock)
            $display("PASS: ACCESS DENIED");
        else
            $display("FAIL: LOCKOUT BYPASSED");

        // TEST 5: Reset system
        $display("\nTEST 5: Reset functionality");

        @(negedge clk);
        reset_n = 0;

        repeat (2) @(negedge clk);
        reset_n = 1;

        repeat (2) @(negedge clk);

        if (attempts == 0 && !locked && !unlock)
            $display("PASS: RESET SUCCESSFUL");
        else
            $display("FAIL: RESET FAILED");

        // TEST 6: Correct password
        $display("\nTEST 6: Correct password authentication");

        enter_password(4'b1010);

        if (unlock && !locked)
            $display("PASS: ACCESS GRANTED");
        else
            $display("FAIL: ACCESS DENIED");

        // Final result
        $display("\n--------------------------------");
        $display(" TESTBENCH COMPLETED");
        $display("--------------------------------");

        $finish;

    end

    // Monitor signal changes
    initial begin
        $monitor(
            "Time=%0t | Password=%b | Attempts=%d | Unlock=%b | Locked=%b",
            $time, password, attempts, unlock, locked
        );
    end

endmodule
