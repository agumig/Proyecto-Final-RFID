//-------------------------------------------------
//          Test Bench
//-----------------------------------------------------------
 `timescale 1us/1us	//Dividir el eje de tiempo en unidades de 10us

module man_mod_tb;

// Entradas del DUT son reg
  reg clk;
  reg in_data;
  reg in_enable;
//   Las salidas del DUT son wire
  wire out_data;
  
  man_mod u1(clk, in_enable, in_data, out_data);
//----------------------------------------------------------
// Inicializo
// Inicializar todo para que no quede en estados "fantasmas"
    initial
    begin
      clk= 1'b0; 
      in_data= 1'b0;
      in_enable=1'b0; 

      end
//----------------------------------------------------------
// Creo un clock de 50Mhz
    always
      #1 clk = ~clk;   // Cada 10 ns invierto
	 
//-----------------------------------------------------------

    initial
      begin
//      forever #10 clk = ~clk; // generate a clock	
	#10 repeat(4) #8 in_data = ~in_data;
// 	#200 in_data=1'b1;	//200ns despues del inicio	
	#200 in_enable=1'b1; 	//200ns despues de la instruccion anterior
	#10 repeat(4) #8 in_data = ~in_data;
	in_data=1'b0;
	#16	in_data = 1'b1;
	#16 in_enable=1'b0; 	
	#32 in_enable=1'b1; 
//  	#560 repeat(10) #10 in_data = ~in_data;
	#32 $finish;
      end
 
    initial
      $monitor("clk=%b,in_data=%b,in_enable=%b",clk,in_data,in_enable);
 
    initial
    begin
      $dumpfile("man_mod_tb.vcd");
      $dumpvars(0,man_mod_tb);
    end
endmodule
    
    
    