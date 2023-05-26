////////////////////////////////////////////////////////////////////////
// FICHERO:     adc_dclk_gen.v
//
// Autor:       Joan Beltán Peris, Jose Abad Martínez
// Fecha:       24/05/2023
// Descripción: Proyecto 4 SDP. Modulo generador de señal ADC_DCLK.
////////////////////////////////////////////////////////////////////////
module adc_dclk_gen (
  CLK,
  RST_n,
  ENABLE,
  ADC_DCLK
);

  // Inputs
  input CLK;
  input RST_n;
  input ENABLE;

  // Outputs
  output reg ADC_DCLK;

  // ADC_DCLK signal generation
  always @(posedge CLK or negedge RST_n) begin

    if (!RST_n) begin
      ADC_DCLK <= 1'b0;
    end

    else if (ENABLE) begin
      ADC_DCLK <= ~ADC_DCLK;
    end

  end

endmodule
