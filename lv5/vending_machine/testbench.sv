`timescale 1ns/1ps
module vending_machine_tb;
  logic        tb_clk;
  logic        tb_reset;
  logic        tb_coin5;
  logic        tb_coin10;
  logic        tb_select_a;
  logic        tb_select_b;
  logic        tb_select_c;
  logic        tb_dispense;
  logic [1:0]  tb_product_out;
  logic        tb_change;

  vending_machine DUT (
    .clk        (tb_clk),
    .reset      (tb_reset),
    .coin5      (tb_coin5),
    .coin10     (tb_coin10),
    .select_a   (tb_select_a),
    .select_b   (tb_select_b),
    .select_c   (tb_select_c),
    .dispense   (tb_dispense),
    .product_out(tb_product_out),
    .change     (tb_change)
  );

  always begin
    tb_clk = 1'b0; #10;
    tb_clk = 1'b1; #10;
  end

  //drive inputs on negedge, sampled safely on next posedge
  task automatic insert_5;
    begin
      @(negedge tb_clk); tb_coin5 = 1'b1;
      @(negedge tb_clk); tb_coin5 = 1'b0;
    end
  endtask

  task automatic insert_10;
    begin
      @(negedge tb_clk); tb_coin10 = 1'b1;
      @(negedge tb_clk); tb_coin10 = 1'b0;
    end
  endtask

  task automatic select_product_a;
    begin
      @(negedge tb_clk); tb_select_a = 1'b1;
      @(negedge tb_clk); tb_select_a = 1'b0;
    end
  endtask

  task automatic select_product_b;
    begin
      @(negedge tb_clk); tb_select_b = 1'b1;
      @(negedge tb_clk); tb_select_b = 1'b0;
    end
  endtask

  task automatic select_product_c;
    begin
      @(negedge tb_clk); tb_select_c = 1'b1;
      @(negedge tb_clk); tb_select_c = 1'b0;
    end
  endtask

  //wait until DISPENSE state is active, then sample outputs
  task automatic check(
    input string test_name,
    input logic  exp_dispense,
    input logic  exp_change
  );
    begin
      fork //wrote this fork using AI lol, genuinely was not in the mood nor the mental state to fix the testbench myself anymore
        begin
          wait(DUT.state == DISPENSE);
        end
        begin
          #200; // Timeout safety net (10 clock cycles)
          if (DUT.state != DISPENSE) begin
            $error("[%0t] %s TIMEOUT: FSM never reached DISPENSE state. Current state: %0d", $time, test_name, DUT.state);
          end
        end
      join_any
      disable fork; // Clear the timeout if we hit DISPENSE

      @(posedge tb_clk); 
      #1; 
      
      $display("[%0t] %s | state=%0d credit=%0d product_out=%0d dispense=%b change=%b",
               $time, test_name, DUT.state, DUT.credit, tb_product_out, tb_dispense, tb_change);
               
      if (tb_dispense !== exp_dispense)
        $error("  FAIL: expected dispense=%b got %b", exp_dispense, tb_dispense);
      if (tb_change !== exp_change)
        $error("  FAIL: expected change=%b got %b", exp_change, tb_change);
        
      wait(DUT.state == IDLE);
      #1; 
    end
  endtask

  initial begin
    tb_reset = 1'b1;
    tb_coin5 = 1'b0;
    tb_coin10 = 1'b0;
    tb_select_a = 1'b0;
    tb_select_b = 1'b0;
    tb_select_c = 1'b0;
    @(negedge tb_clk); tb_reset = 1'b0;
    repeat (2) @(negedge tb_clk);
    tb_reset = 1'b1;
    repeat (2) @(posedge tb_clk);

    $display("\n--- Test 1: Buy Product A, exact credit (10c) ---");
    insert_10();
    select_product_a();
    check("T1", 1'b1, 1'b0);

    $display("\n--- Test 2: Buy Product B, exact credit (10c + 5c) ---");
    insert_10();
    insert_5();
    select_product_b();
    check("T2", 1'b1, 1'b0);

    $display("\n--- Test 3: Buy Product C, exact credit (10c + 10c) ---");
    insert_10();
    insert_10();
    select_product_c();
    check("T3", 1'b1, 1'b0);

    $display("\n--- Test 4: Insufficient funds (5c, select C=20c) ---");
    insert_5();
    select_product_c();
    check("T4", 1'b0, 1'b0);
    insert_5();
    select_product_a();
    repeat (4) @(posedge tb_clk);

    $display("\n--- Test 5: Overpay, expect change (20c for Product B=15c) ---");
    insert_10();
    insert_10();
    select_product_b();
    check("T5", 1'b1, 1'b1);

    $display("\n--- Test 6: Consecutive purchases from carry-over credit ---");
    insert_10();
    insert_10();
    select_product_a();
    repeat (4) @(posedge tb_clk); #1;
    $display("  credit after first purchase = %0d", DUT.credit);
    select_product_a();
    check("T6", 1'b1, 1'b0);

    $display("\n--- Test 7: Multiple coins then buy C (5c + 5c + 10c = 20c) ---");
    insert_5();
    insert_5();
    insert_10();
    $display("  credit = %0d", DUT.credit);
    select_product_c();
    check("T7", 1'b1, 1'b0);

    $display("\nSimulation complete.");
    $finish;
  end

  initial begin
    $dumpfile("vending_machine_tb.vcd");
    $dumpvars(0, vending_machine_tb);
  end

endmodule