/*----------------------------------------------------------------
--          Test Bench						--
-- Archivo a testear: 	manch_mod.v				--
-- Descripcion:		DUT codificador manchester		--
----------------------------------------------------------------*/

 `timescale 1us/1us	//Dividir el eje de tiempo en unidades de 1us

module man_mod_tb;	//Modulo de test bench

// Entradas del DUT son reg
  reg clk;
  reg in_data;
  reg in_enable;
//   Las salidas del DUT son wire
  wire out_data;
  
  man_mod u1(clk, in_enable, in_data, out_data);	//DUT a testear
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
// Creo un clock de 500khz
    always
      #1 clk = ~clk;   // Cada 1 us invierto
	 
//-----------------------------------------------------------

    initial
      begin
//      forever #10 clk = ~clk; // generate a clock	
	#10 repeat(4) #8 in_data = ~in_data;		//10us del arranque, switcheo in_data cada 8us
	#36 in_enable=1'b1; 				//200us despues de la instruccion anterior habilito el dispositivo
	#16 repeat(4) #16 in_data = ~in_data;		//8us despues de la instruccion anterior switcheo in_data cada 24us
	in_data=1'b0;					//Pongo a 0 in_data
	#16	in_data = 1'b1;				//16us despues, lo pngo a 1

// 	#16 in_enable=1'b0; 	
// 	#32 in_enable=1'b1; 
//  	#560 repeat(10) #10 in_data = ~in_data;
	#32 in_enable=1'b0; 				//Deshabilito el dispositivo
	#16 $finish;					//Finalizo la simulación
      end
 
//     initial	
//       $monitor("clk=%b,in_data=%b,in_enable=%b",clk,in_data,in_enable);	//Imprimo en consola los datos
 
    initial
    begin
      $dumpfile("man_mod_tb.vcd");	//Creo el archivo para simular con GTKWave
      $dumpvars(0, man_mod_tb);
    end
endmodule