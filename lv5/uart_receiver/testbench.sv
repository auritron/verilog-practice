`timescale 1ns/1ps

module uart_rx_tb;

  localparam int CLK_FREQ = 50_000_000;
  localparam int BAUD_RATE = 9600;
  localparam real BIT_PERIOD = 1_000_000_000.0 / BAUD_RATE;

  logic       tb_clk;
  logic       tb_reset;
  logic       tb_rx;
  logic [7:0] tb_rx_data;
  logic       tb_rx_valid;

  uart_rx #(
    .CLK_FREQ(CLK_FREQ),
    .BAUD_RATE(BAUD_RATE),
    .SAMPLING_RATE(16)
  ) DUT (
    .clk(tb_clk),
    .reset(tb_reset),
    .rx(tb_rx),
    .rx_data(tb_rx_data),
    .rx_valid(tb_rx_valid)
  );

  // 50MHz Clock Generator (20ns period -> toggles every 10ns)
  always begin
    tb_clk = 1'b0;
    #10;
    tb_clk = 1'b1;
    #10;
  end

  initial begin
    $monitor("Time: %0tns | State: %s | tb_rx Line: %b | Tick Count: %0d | Data Count: %0d | Valid: %b | Data Reg: 8'h%h",
             $time, 
             DUT.cur_state.name(), 
             tb_rx, 
             DUT.tick_counter, 
             DUT.data_cntr, 
             tb_rx_valid, 
             tb_rx_data);
  end

  // task to transmit a single byte serially over the tb_rx line
  task automatic send_uart_byte(input logic [7:0] tx_byte);
    begin
      $display("\n--- Starting transmission of byte: 8'h%h (Binary LSB-first: %b) ---", tx_byte, tx_byte);
      
      // start bit
      tb_rx = 1'b0;
      #(BIT_PERIOD);
      
      // data bit
      for (int i = 0; i < 8; i++) begin
        tb_rx = tx_byte[i];
        #(BIT_PERIOD);
      end
      
      // stop bit
      tb_rx = 1'b1;
      #(BIT_PERIOD);
      
      $display("--- Finished transmission of byte ---\n");
    end
  endtask

  initial begin
    tb_rx = 1'b1; // idle high
    tb_reset = 1'b1;
    
    #40;
    tb_reset = 1'b0;
    #40;
    tb_reset = 1'b1;
    #100;
    
    // send first byte (0x55 / 0b01010101)
    send_uart_byte(8'h55);
    
    // delay for sometime before next transmission
    #(BIT_PERIOD * 2);

    // send second byte (0xA3 / 0b10100011)
    send_uart_byte(8'hA3);

    // wait and end sim
    #(BIT_PERIOD * 2);
    $display("Simulation complete.");
    $finish;
  end

endmodule
