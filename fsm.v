////////////////////////////////////////////////////////////////////////
// FICHERO:     fsm.v
//
// Autor:       Joan Beltán Peris, Jose Abad Martínez
// Fecha:       24/05/2023
// Descripción: Proyecto 4 SDP. Maquina de estados para el control ADC.
////////////////////////////////////////////////////////////////////////
module fsm (
  CLK,
  RST_n,
  ENABLE_1,
  ENABLE_2,
  ADC_PENIRQ_n,
  ADC_CS,
  ENA_TRANS,
  FIN_TRANS
);

  // Inputs
  input CLK;
  input RST_n;
  input ENABLE_1;
  input ENABLE_2;
  input ADC_PENIRQ_n;

  // Outputs
  output reg ADC_CS;
  output reg ENA_TRANS;
  output reg FIN_TRANS;

  // Regs
  reg [1:0] CURRENT_STATE;
  reg [1:0] NEXT_STATE;

  // Parameters
  localparam S0 = 2'b00;
  localparam S1 = 2'b01;
  localparam S2 = 2'b10;
  localparam S3 = 2'b11;

  // Update the current state
  always @(posedge CLK or negedge RST_n) begin

    if (!RST_n) begin
      CURRENT_STATE <= 2'b00;
    end

    else begin
      CURRENT_STATE <= NEXT_STATE;
    end

  end

  // Update the next state
  always @(CURRENT_STATE, ADC_PENIRQ_n, ENABLE_1, ENABLE_2) begin

    case (CURRENT_STATE)
      S0: NEXT_STATE = S1;
      S1: NEXT_STATE = !ADC_PENIRQ_n ? S2 : CURRENT_STATE;
      S2: NEXT_STATE = (ENABLE_1 && ENABLE_2) ? S3 : CURRENT_STATE;
      S3: NEXT_STATE = S0;
      default: NEXT_STATE = S0;
    endcase

  end

  // Outputs
  always @(CURRENT_STATE) begin

    case (CURRENT_STATE)

      S0: begin
        ENA_TRANS <= 1'b0;
        FIN_TRANS <= 1'b0;
        ADC_CS <= 1'b0;
      end

      S1: begin
        ENA_TRANS <= 1'b0;
        FIN_TRANS <= 1'b0;
        ADC_CS <= 1'b0;
      end

      S2: begin
        ENA_TRANS <= 1'b1;
        FIN_TRANS <= 1'b0;
        ADC_CS <= 1'b1;
      end

      S3: begin
        ENA_TRANS <= 1'b0;
        FIN_TRANS <= 1'b1;
        ADC_CS <= 1'b0;
      end

      default: begin
        ENA_TRANS <= 1'b0;
        FIN_TRANS <= 1'b0;
        ADC_CS <= 1'b0;
      end

    endcase

  end

endmodule
