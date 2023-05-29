////////////////////////////////////////////////////////////////////////
// FICHERO:     adc_dout_capt.v
//
// Autor:       Joan Beltán Peris, Jose Abad Martínez
// Fecha:       24/05/2023
// Descripción: Proyecto 4 SDP. Modulo de captura de coordenadas X e Y
////////////////////////////////////////////////////////////////////////
module adc_dout_capt (
  CLK,
  RST_n,
  ENABLE,
  COUNT,
  ADC_DOUT,
  X_COORD,
  Y_COORD
);

  // Inputs
  input CLK;
  input RST_n;
  input ENABLE;
  input [6:0] COUNT;
  input ADC_DOUT;

  // Outputs
  output reg [11:0] X_COORD;
  output reg [11:0] Y_COORD;

  // X and Y coordinates capture
  always @(posedge CLK or negedge RST_n) begin

    if (!RST_n) begin
      X_COORD <= 12'h000;
      Y_COORD <= 12'h000;
    end

    else if (ENABLE) begin
      case(COUNT)
        18,19: X_COORD[11] <= ADC_DOUT;
        20,21: X_COORD[10] <= ADC_DOUT;
        22,23: X_COORD[9]  <= ADC_DOUT;
        24,25: X_COORD[8]  <= ADC_DOUT;
        26,27: X_COORD[7]  <= ADC_DOUT;
        28,29: X_COORD[6]  <= ADC_DOUT;
        30,31: X_COORD[5]  <= ADC_DOUT;
        32,33: X_COORD[4]  <= ADC_DOUT;
        34,35: X_COORD[3]  <= ADC_DOUT;
        36,37: X_COORD[2]  <= ADC_DOUT;
        38,39: X_COORD[1]  <= ADC_DOUT;
        40,41: X_COORD[0]  <= ADC_DOUT;
        50,51: Y_COORD[11] <= ADC_DOUT;
        52,53: Y_COORD[10] <= ADC_DOUT;
        54,55: Y_COORD[9]  <= ADC_DOUT;
        56,57: Y_COORD[8]  <= ADC_DOUT;
        58,59: Y_COORD[7]  <= ADC_DOUT;
        60,61: Y_COORD[6]  <= ADC_DOUT;
        62,63: Y_COORD[5]  <= ADC_DOUT;
        64,65: Y_COORD[4]  <= ADC_DOUT;
        66,67: Y_COORD[3]  <= ADC_DOUT;
        68,69: Y_COORD[2]  <= ADC_DOUT;
        70,71: Y_COORD[1]  <= ADC_DOUT;
        72,73: Y_COORD[0]  <= ADC_DOUT;
        default: begin
          X_COORD <= X_COORD;
          Y_COORD <= Y_COORD;
        end
      endcase
    end

  end

endmodule
