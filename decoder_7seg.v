////////////////////////////////////////////////////////////////////////
// FICHERO:     decoder_7seg.v
//
// Autor:       Joan Beltán Peris, Jose Abad Martínez
// Fecha:       24/05/2023
// Descripción: Proyecto 4 SDP. Decodificador de 7 segmentos.
////////////////////////////////////////////////////////////////////////
module decoder_7seg (
  X_COORD,
  Y_COORD,
  HEX0,
  HEX1,
  HEX2,
  HEX5,
  HEX6,
  HEX7
);

  // Inputs
  input [11:0] X_COORD;
  input [11:0] Y_COORD;

  // Outputs
  output reg [6:0] HEX0;
  output reg [6:0] HEX1;
  output reg [6:0] HEX2;
  output reg [6:0] HEX5;
  output reg [6:0] HEX6;
  output reg [6:0] HEX7;

  // Coordinates decoder
  always @(X_COORD, Y_COORD) begin

    // Least significant digit coordinate X
    case(X_COORD[3:0])
      4'h0: HEX5 = 7'b1000000;
      4'h1: HEX5 = 7'b1111001;
      4'h2: HEX5 = 7'b0100100;
      4'h3: HEX5 = 7'b0110000;
      4'h4: HEX5 = 7'b0011001;
      4'h5: HEX5 = 7'b0010010;
      4'h6: HEX5 = 7'b0000010;
      4'h7: HEX5 = 7'b1111000;
      4'h8: HEX5 = 7'b0000000;
      4'h9: HEX5 = 7'b0010000;
      4'hA: HEX5 = 7'b0001000;
      4'hB: HEX5 = 7'b0000011;
      4'hC: HEX5 = 7'b1000110;
      4'hD: HEX5 = 7'b0100001;
      4'hE: HEX5 = 7'b0000110;
      4'hF: HEX5 = 7'b0001110;
      default: HEX5 = 7'b1000000;
    endcase

    case(X_COORD[7:4])
      4'h0: HEX6 = 7'b1000000;
      4'h1: HEX6 = 7'b1111001;
      4'h2: HEX6 = 7'b0100100;
      4'h3: HEX6 = 7'b0110000;
      4'h4: HEX6 = 7'b0011001;
      4'h5: HEX6 = 7'b0010010;
      4'h6: HEX6 = 7'b0000010;
      4'h7: HEX6 = 7'b1111000;
      4'h8: HEX6 = 7'b0000000;
      4'h9: HEX6 = 7'b0010000;
      4'hA: HEX6 = 7'b0001000;
      4'hB: HEX6 = 7'b0000011;
      4'hC: HEX6 = 7'b1000110;
      4'hD: HEX6 = 7'b0100001;
      4'hE: HEX6 = 7'b0000110;
      4'hF: HEX6 = 7'b0001110;
      default: HEX6 = 7'b1000000;
    endcase

    // Most significant digit coordinate X
    case(X_COORD[11:8])
      4'h0: HEX7 = 7'b1000000;
      4'h1: HEX7 = 7'b1111001;
      4'h2: HEX7 = 7'b0100100;
      4'h3: HEX7 = 7'b0110000;
      4'h4: HEX7 = 7'b0011001;
      4'h5: HEX7 = 7'b0010010;
      4'h6: HEX7 = 7'b0000010;
      4'h7: HEX7 = 7'b1111000;
      4'h8: HEX7 = 7'b0000000;
      4'h9: HEX7 = 7'b0010000;
      4'hA: HEX7 = 7'b0001000;
      4'hB: HEX7 = 7'b0000011;
      4'hC: HEX7 = 7'b1000110;
      4'hD: HEX7 = 7'b0100001;
      4'hE: HEX7 = 7'b0000110;
      4'hF: HEX7 = 7'b0001110;
      default: HEX7 = 7'b1000000;
    endcase

    // Least significant digit coordinate Y
    case(Y_COORD[3:0])
      4'h0: HEX0 = 7'b1000000;
      4'h1: HEX0 = 7'b1111001;
      4'h2: HEX0 = 7'b0100100;
      4'h3: HEX0 = 7'b0110000;
      4'h4: HEX0 = 7'b0011001;
      4'h5: HEX0 = 7'b0010010;
      4'h6: HEX0 = 7'b0000010;
      4'h7: HEX0 = 7'b1111000;
      4'h8: HEX0 = 7'b0000000;
      4'h9: HEX0 = 7'b0010000;
      4'hA: HEX0 = 7'b0001000;
      4'hB: HEX0 = 7'b0000011;
      4'hC: HEX0 = 7'b1000110;
      4'hD: HEX0 = 7'b0100001;
      4'hE: HEX0 = 7'b0000110;
      4'hF: HEX0 = 7'b0001110;
      default: HEX0 = 7'b1000000;
    endcase

    case(Y_COORD[7:4])
      4'h0: HEX1 = 7'b1000000;
      4'h1: HEX1 = 7'b1111001;
      4'h2: HEX1 = 7'b0100100;
      4'h3: HEX1 = 7'b0110000;
      4'h4: HEX1 = 7'b0011001;
      4'h5: HEX1 = 7'b0010010;
      4'h6: HEX1 = 7'b0000010;
      4'h7: HEX1 = 7'b1111000;
      4'h8: HEX1 = 7'b0000000;
      4'h9: HEX1 = 7'b0010000;
      4'hA: HEX1 = 7'b0001000;
      4'hB: HEX1 = 7'b0000011;
      4'hC: HEX1 = 7'b1000110;
      4'hD: HEX1 = 7'b0100001;
      4'hE: HEX1 = 7'b0000110;
      4'hF: HEX1 = 7'b0001110;
      default: HEX1 = 7'b1000000;
    endcase

    // Most significant digit coordinate X
    case(Y_COORD[11:8])
      4'h0: HEX2 = 7'b1000000;
      4'h1: HEX2 = 7'b1111001;
      4'h2: HEX2 = 7'b0100100;
      4'h3: HEX2 = 7'b0110000;
      4'h4: HEX2 = 7'b0011001;
      4'h5: HEX2 = 7'b0010010;
      4'h6: HEX2 = 7'b0000010;
      4'h7: HEX2 = 7'b1111000;
      4'h8: HEX2 = 7'b0000000;
      4'h9: HEX2 = 7'b0010000;
      4'hA: HEX2 = 7'b0001000;
      4'hB: HEX2 = 7'b0000011;
      4'hC: HEX2 = 7'b1000110;
      4'hD: HEX2 = 7'b0100001;
      4'hE: HEX2 = 7'b0000110;
      4'hF: HEX2 = 7'b0001110;
      default: HEX2 = 7'b1000000;
    endcase

  end

endmodule
