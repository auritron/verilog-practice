typedef enum logic [1:0] {
  IDLE,
  PAYMENT,
  DISPENSE
} State;

typedef enum logic [2:0] {
  CREDIT_0,
  CREDIT_5,
  CREDIT_10,
  CREDIT_15,
  CREDIT_20
} Credit;

typedef enum logic [1:0] {
  NONE,
  PRODUCT_A,
  PRODUCT_B,
  PRODUCT_C
} Product;

module vending_machine (
  input  logic         clk,
  input  logic         reset, //active low

  input  logic         coin5,
  input  logic         coin10,

  input  logic         select_a,
  input  logic         select_b,
  input  logic         select_c,
  
  output logic         dispense,
  output logic [1:0]   product_out,
  output logic         change
);
  
  logic valid_enc;
  Credit credit;
  Product product;
  Product sel_product;
  State state;
  State next_state;

  logic [4:0] purchase;
  
  encoder_4to2 u_enc_prod (
    .in({select_c, select_b, select_a, 1'b0}),
    .out(product),
    .valid(valid_enc)
  );
  
  purchase_result u_purchase (
    .p_credit(credit),
    .p_product(sel_product),
    .o_purchase_result(purchase)
  );
  
  function automatic Credit inc_sum(Credit p_credit, logic c10, logic c5);
    if (c10) begin
      case (p_credit)
        CREDIT_0: return CREDIT_10;
        CREDIT_5: return CREDIT_15;
        default: return CREDIT_20;
      endcase
    end else if (c5) begin
      case (p_credit)
        CREDIT_0: return CREDIT_5;
        CREDIT_5: return CREDIT_10;
        CREDIT_10: return CREDIT_15;
        default: return CREDIT_20;
      endcase
    end else begin
      if (p_credit <= CREDIT_20) return p_credit;
      else return CREDIT_20; //max value
    end
    return CREDIT_0;
  endfunction

  always_comb begin
    next_state = state;
    unique case (state)
      IDLE: begin
        if (coin10 || coin5) next_state = PAYMENT;
        else if (valid_enc && (credit > CREDIT_0)) next_state = DISPENSE;
      end
      PAYMENT: begin
        if (valid_enc) next_state = DISPENSE;
      end
      DISPENSE: begin 
        next_state = IDLE;
      end
    endcase
  end

  always_ff @(posedge clk or negedge reset) begin
    if (!reset) begin
      dispense <= 1'b0;
      change <= 1'b0;
      sel_product <= NONE;
      product_out <= NONE;
      credit <= CREDIT_0;
      state <= IDLE;
    end else begin
      state <= next_state;
      unique case (state)
        IDLE: begin
          dispense <= 1'b0;
          change <= 1'b0;
          product_out <= NONE;
          if (coin10 || coin5)
            credit <= inc_sum(credit, coin10, coin5);
        end
        PAYMENT: begin
          if (valid_enc)
            sel_product <= product;
          else if (coin10 || coin5)
            credit <= inc_sum(credit, coin10, coin5);
        end
        DISPENSE: begin
          dispense <= purchase[0];
          change <= purchase[1] & purchase[0];
          credit <= Credit'(purchase[4:2]);
          if (purchase[0]) product_out <= sel_product;
          else product_out <= NONE;
        end
      endcase
    end
  end
  
endmodule

module purchase_result (
  input  logic [2:0] p_credit,
  input  logic [1:0] p_product,
  output logic [4:0] o_purchase_result
);

  logic [2:0] price;

  always_comb begin
    /*
      0th bit is validity, 1st bit is change, 2nd-4th bit is updated credit
      4'bXXX00, 4'bXXX10 => Purchase is invalid
      4'bXXX01 => Purchase is valid and no change
      4'bXXX11 => Purchase is valid and there is change
    */
    case (p_product)
      PRODUCT_A: price = CREDIT_10;
      PRODUCT_B: price = CREDIT_15;
      PRODUCT_C: price = CREDIT_20;
      default:   price = 3'b000;
    endcase

    if (p_product == NONE) o_purchase_result = 5'b00010;
    else if (p_credit == price) o_purchase_result = 5'b00001;
    else if (p_credit > price) o_purchase_result = {(p_credit - price), 2'b11};
    else o_purchase_result = {p_credit, 2'b00};
  end

endmodule

module encoder_4to2 (
  input  logic [3:0]  in,
  output logic [1:0]  out,
  output logic        valid
);
  
  always_comb begin
    valid = 1'b1;
    if (in[3]) out = 2'b11;
    else if (in[2]) out = 2'b10;
    else if (in[1]) out = 2'b01;
    else if (in[0]) out = 2'b00;
    else begin
      out = 2'b00;
      valid = 1'b0;
    end
  end
  
endmodule