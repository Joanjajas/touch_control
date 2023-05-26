////////////////////////////////////////////////////////////////////////
// FICHERO:     touch_control.v
//
// Autor:       Joan Beltán Peris, Jose Abad Martínez
// Fecha:       24/05/2023
// Descripción: Proyecto 4 SDP. Controlador de la pantalla táctil.
////////////////////////////////////////////////////////////////////////
module touch_control (
  CLK,
  RST_n,
  ADC_PENIRQ_n,
  ADC_BUSY,
  ADC_DOUT,
  ADC_DCLK,
  SCEN,
  ADC_DIN,
  HEX0,
  HEX1,
  HEX2,
  HEX5,
  HEX6,
  HEX7
);

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
  output [6:0] HEX0;
  output [6:0] HEX1;
  output [6:0] HEX2;
  output [6:0] HEX5;
  output [6:0] HEX6;
  output [6:0] HEX7;

  // Wires
  wire [11:0] X_COORD;
  wire [11:0] Y_COORD;

  // adc_control module instantiation
  adc_control ADC_CONTROL (
    .CLK(CLK),
    .RST_n(RST_n),
    .ADC_PENIRQ_n(ADC_PENIRQ_n),
    .ADC_BUSY(ADC_BUSY),
    .ADC_DOUT(ADC_DOUT),
    .ADC_DCLK(ADC_DCLK),
    .SCEN(SCEN),
    .ADC_DIN(ADC_DIN),
    .X_COORD(X_COORD),
    .Y_COORD(Y_COORD)
  );

  // decoder_7seg module instantiation
  decoder_7seg DECODER_7SEG (
    .X_COORD(X_COORD),
    .Y_COORD(Y_COORD),
    .HEX0(HEX0),
    .HEX1(HEX1),
    .HEX2(HEX2),
    .HEX5(HEX5),
    .HEX6(HEX6),
    .HEX7(HEX7)
  );

endmodule
