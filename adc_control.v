////////////////////////////////////////////////////////////////////////
// FICHERO:     adc_control.v
//
// Autor:       Joan Beltán Peris, Jose Abad Martínez
// Fecha:       24/05/2023
// Descripción: Proyecto 4 SDP. Módulo de control del ADC.
////////////////////////////////////////////////////////////////////////
module adc_control (
  CLK,
  RST_n,
  ADC_PENIRQ_n,
  ADC_BUSY,
  ADC_DOUT,
  ADC_DCLK,
  SCEN,
  ADC_DIN,
  X_COORD,
  Y_COORD
);

  // Parameters
  parameter SYSCLK_FRQ = 50000000;
  parameter ADC_DCLK_FRQ = 70000;
  localparam ADC_DCLK_CNT = SYSCLK_FRQ / (ADC_DCLK_FRQ * 2);

  // Inputs
  input CLK;
  input RST_n;
  input ADC_PENIRQ_n;
  input ADC_BUSY;
  input ADC_DOUT;

  // Outputs
  output ADC_DCLK;
  output SCEN;
  output ADC_DIN;
  output [11:0] X_COORD;
  output [11:0] Y_COORD;

  // Wires
  wire trans_en;
  wire fin_80;
  wire dclk;
  wire trans_eof;
  wire wait_en;
  wire wait_irq;
  wire [6:0] count_80;

  // Counter module with modulus ADC_DCLK_CNT instantiation
  counter COUNTER1 (
    .CLK(CLK),
    .RST_n(RST_n),
    .ENABLE(trans_en),
    .COUNT(),
    .TC(dclk)
  );
  defparam COUNTER1.modulus = ADC_DCLK_CNT;

  // Counter module with modulus 80 instantiation
  counter COUNTER2 (
    .CLK(CLK),
    .RST_n(RST_n),
    .ENABLE(dclk),
    .COUNT(count_80),
    .TC(fin_80)
  );
  defparam COUNTER2.modulus = 80;

  // Counter module with modulus 25000000 instantiation
  counter COUNTER3 (
    .CLK(CLK),
    .RST_n(RST_n),
    .ENABLE(wait_en),
    .COUNT(),
    .TC(wait_irq)
  );
  defparam COUNTER3.modulus = 25000000;

  // FSM instantiation
  fsm FSM (
    .CLK(CLK),
    .RST_n(RST_n),
    .ENABLE_1(dclk),
    .ENABLE_2(fin_80),
    .WAIT_IRQ(wait_irq),
    .ADC_PENIRQ_n(ADC_PENIRQ_n),
    .WAIT_EN(wait_en),
    .ADC_CS(SCEN),
    .ENA_TRANS(trans_en),
    .FIN_TRANS(trans_eof)
  );

  // ADC_DCLK signal generation module instantiation
  adc_dclk_gen ADC_DCLK_GEN (
    .CLK(CLK),
    .RST_n(RST_n),
    .ENABLE(dclk),
    .ADC_DCLK(ADC_DCLK)
  );

  // ADC_DIN signal generation module instantiation
  adc_din_gen ADC_DIN_GEN (
    .CLK(CLK),
    .RST_n(RST_n),
    .ENABLE(trans_en),
    .COUNT(count_80),
    .ADC_DIN(ADC_DIN)
  );

  // ADC_DOUT signal capture module instantiation
  adc_dout_capt ADC_DOUT_CAPT (
    .CLK(CLK),
    .RST_n(RST_n),
    .ENABLE(trans_en),
    .COUNT(count_80),
    .ADC_DOUT(ADC_DOUT),
    .X_COORD(X_COORD),
    .Y_COORD(Y_COORD)
  );

endmodule

