////////////////////////////////////////////////////////////////////////
// FICHERO:     counter.v
//
// Autor:       Joan Beltán Peris, Jose Abad Martínez
// Fecha:       24/05/2023
// Descripción: Proyecto 4 SDP. Contador de modulo variable.
////////////////////////////////////////////////////////////////////////
module counter(
  CLK,
  RST_n,
  ENABLE,
  COUNT,
  TC
);

  // Parameters
  parameter modulus = 16;
  localparam N = $clog2(modulus);

  // Inputs
  input CLK;
  input RST_n;
  input ENABLE;

  // Outputs
  output reg [N-1:0] COUNT;
  output TC;

  // Update counter value
  always @(posedge CLK or negedge RST_n) begin

    if (!RST_n) begin
      COUNT <= 0;
    end

    else if (ENABLE) begin

      if (COUNT == modulus - 1) begin
        COUNT <= 1;
      end

      else begin
        COUNT <= COUNT + 1'b1;
      end

    end

  end

  // TC signal assig
  assign TC = ((COUNT == modulus - 1) && (ENABLE == 1)) ? 1'b1 : 1'b0;

endmodule
