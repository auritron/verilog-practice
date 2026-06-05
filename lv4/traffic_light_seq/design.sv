typedef enum logic [1:0] {
  RED = 2'b00,
  GREEN = 2'b01,
  YELLOW = 2'b10
} TrafficSignal;

module traffic_light_seq (
    input logic clk,
  	output TrafficSignal signal = RED
);
  
  TrafficSignal next_signal;
  
  always_comb begin
    case (signal)
      RED: next_signal = GREEN;
      GREEN: next_signal = YELLOW;
      YELLOW: next_signal = RED;
      default: next_signal = RED;
    endcase
  end
  
  always_ff @(posedge clk) signal <= next_signal;
  
endmodule