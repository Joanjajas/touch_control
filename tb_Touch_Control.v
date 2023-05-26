////////////////////////////////////////////////////////////////////////
// FICHERO:   tb_Touch_Control.v
// 
// Autor:   Ricardo J. Colom, Vicente Herrero, Ramón J. Aliaga
// Fecha:   12/12/2017
// Descripcion: Proyecto 4 SDP. 
//              Testbench. 
// 
////////////////////////////////////////////////////////////////////////




`timescale 1 ns/ 100 ps



module tb_Touch_Control (CLK,
            RST_n,
            ADC_DIN,
            ADC_DCLK,
            SCEN,
            ADC_DOUT,
            ADC_BUSY,
            ADC_PENIRQ_n,
            X_COORD_out,
            Y_COORD_out,
            X_COORD_in,
            Y_COORD_in,
            INIT_n);

localparam T = 20;


// Se han colocado todas las señales de interes como salidas del TB
// para que se coloquen en el Waveform Viewer automáticamente cuando
// se arranque la simulación desde Quartus

output CLK,RST_n,ADC_DIN,ADC_DCLK,SCEN,
     ADC_DOUT,ADC_BUSY,ADC_PENIRQ_n;
output [11:0] X_COORD_out;
output [11:0] X_COORD_in;
output [11:0] Y_COORD_out;
output [11:0] Y_COORD_in;
output INIT_n;

wire CLOCK_50;
wire iRST_n;
wire start_n;
wire [11:0] oX_COORD;
wire [11:0] oY_COORD;
wire [11:0] iX_COORD;
wire [11:0] iY_COORD;
wire adc_din, adc_dclk, adc_busy, adc_penirq_n, adc_dout, scen; 

assign X_COORD_out    = oX_COORD;
assign Y_COORD_out    = oY_COORD;
assign X_COORD_in     = iX_COORD;
assign Y_COORD_in     = iY_COORD;
assign CLK          = CLOCK_50;
assign RST_n        = iRST_n;
assign ADC_DIN      = adc_din;
assign ADC_DCLK     = adc_dclk;
assign SCEN       = scen;
assign ADC_DOUT     = adc_dout;
assign ADC_BUSY     = adc_busy;
assign ADC_PENIRQ_n   = adc_penirq_n;
assign INIT_n       = start_n;

reg [11:0] DATOX;
reg [11:0] DATOY;

// BLOQUE DISENYADO PARA EL CONTROL DEL ADC
adc_control  ADC_CONTROL  (
          .CLK(CLOCK_50),
          .RST_n(iRST_n),
          .ADC_DIN(adc_din),
          .ADC_DCLK(adc_dclk),
          .SCEN(scen),
          .ADC_DOUT(adc_dout),
          .ADC_BUSY(adc_busy),
          .ADC_PENIRQ_n(adc_penirq_n),
          .X_COORD(oX_COORD),
          .Y_COORD(oY_COORD)
          );

//MODELO DEL CONVERTIDOR          
EMULE_ADC EMULE_ADC (
          .iCLK(CLOCK_50),
          .iRST_n(iRST_n),
          .iADC_DIN(adc_din),
          .iADC_DCLK(adc_dclk),
          .iADC_CS(scen),
          .oADC_DOUT(adc_dout),
          .oADC_BUSY(adc_busy),
          .oADC_PENIRQ_n(adc_penirq_n),
          .iX_COORD(iX_COORD),
          .iY_COORD(iY_COORD),          
          .iNEW_COORD(start_n)
          );

        
// MODELO FUNCIONAL DE BUS PARA VERIFICACION
MFB   #(.periodo(20)) MFB  (    
        .CLK(CLOCK_50), 
        .RST(iRST_n), 
        .X_COORD_CONTROL(oX_COORD),
        .X_COORD_MODELO(iX_COORD),
        .Y_COORD_CONTROL(oY_COORD),
        .Y_COORD_MODELO(iY_COORD),
        .START_CONV_n(start_n),
        .ADC_DCLK(adc_dclk)
        );
          


initial          // CASOS DE TEST
  begin
  
  
  ///////////////////////////////////////////////////////////////
  // CASO 1. Una posición XY fija
  MFB.reset;
  DATOX = 12'h92E;
  DATOY = 12'hB16;
  fork
    MFB.gen_conversion(DATOX,DATOY);
    MFB.comprueba;
  join
  repeat (200) @(negedge CLOCK_50);
  
  /////////////////////////////////////////////////////////////// 
  // CASO 2. Envio de tres posiciones fijas seguidas
  repeat (3) begin
    MFB.reset;
    DATOX = 12'hA15;
    DATOY = 12'h1B9;
      fork
        MFB.gen_conversion(DATOX,DATOY);
        MFB.comprueba;
      join
      repeat (200) @(negedge CLOCK_50);
  end
  
  //////////////////////////////////////////////////////////////////
  // CASO 3. Envio de tres posiciones ALEATORIAS seguidas
  repeat (3) begin
    MFB.reset;
    DATOX = $random;
    DATOY = $random;
      fork
        MFB.gen_conversion(DATOX,DATOY);
        MFB.comprueba;
      join
      repeat (200) @(negedge CLOCK_50);
  end
  
  //////////////////////////////////////////////////////////////////
  
  $display("Verificacion del DUV correcta");
  $stop;
  
  end
  
endmodule


