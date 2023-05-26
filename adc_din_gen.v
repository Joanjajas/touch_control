////////////////////////////////////////////////////////////////////////
// FICHERO:     adc_din_gen.v
//
// Autor:       Joan Beltán Peris, Jose Abad Martínez
// Fecha:       24/05/2023
// Descripción: Proyecto 4 SDP. Modulo generador de la señal ADC_DIN.
////////////////////////////////////////////////////////////////////////
module adc_din_gen (
  CLK,
  RST_n,
  ENABLE,
  COUNT,
  ADC_DIN
);

  // Inputs
  input CLK;
  input RST_n;
  input ENABLE;
  input [6:0] COUNT;

  // Outputs
  output reg ADC_DIN;

  // ADC_DIN signal generation
  always @(posedge CLK or negedge RST_n) begin

    if (!RST_n) begin
      ADC_DIN <= 1'b0;
    end

    else if (ENABLE) begin
      case(COUNT)
        0,1:     ADC_DIN <= 1'b1;
        2,3:     ADC_DIN <= 1'b0;
        4,5:     ADC_DIN <= 1'b0;
        6,7:     ADC_DIN <= 1'b1;
        8,9:     ADC_DIN <= 1'b0;
        10,11:   ADC_DIN <= 1'b0;
        12,13:   ADC_DIN <= 1'b1;
        14,15:   ADC_DIN <= 1'b0;
        32,33:   ADC_DIN <= 1'b1;
        34,35:   ADC_DIN <= 1'b1;
        36,37:   ADC_DIN <= 1'b0;
        38,39:   ADC_DIN <= 1'b1;
        40,41:   ADC_DIN <= 1'b0;
        42,43:   ADC_DIN <= 1'b0;
        44,45:   ADC_DIN <= 1'b1;
        46,47:   ADC_DIN <= 1'b0;
        default: ADC_DIN <= 1'b0;
      endcase
    end

  end

endmodule

