/*------------------------------------------------------------------------
--                     Codificador Manchester                     	--
-- * 1.0                                                          	--
-- Descripcion:                                                   	--
--    	Codificador manchester 		                          	--
--Ingresa el frame a enviar y sale codificado (codificacion manchester) --
--	Test bench de este archivo en tb_manch_mod.v			--
------------------------------------------------------------------------*/

module man_mod #(parameter N = 3)(clk, in_enable, in_data, out_data);

input clk;		//Clock de fc/16 en RFID (847,5 KHz)
input in_data;		//Informacion - ETU de 106Kb/s (8 clocks dentro de cada ETU)
input in_enable;	//Bit de habilitacion del modulo
output reg out_data;	//Salida del codificador manchester

reg  [N-1:0] count;	//Cuento los cuatro clock para estar en la mitad del ETU
reg etu;		//0 si se está en la primer mitad del etu - 1 si se está en la segunda mitad

  always @ (negedge clk, negedge in_enable) begin
      if(~in_enable) begin	//Cuando esta desabilitado el modulo, pongo la salida y el contador en 0 (cero)
	out_data <= 1'b0;
	etu <= 1'b0;
	count <= {N{1'b0}};
      end else begin
      count <= count +1;
      if(count == 3'b100) begin	//Cuando cuento la mitad de los clocks que entran en un etu
	etu = ~ etu;		//invierto el etu
	count <= 3'b001;		//reseteo el contador
      end
      if(~etu) begin		//Si estoy en la primera mitad del ETU
	if(in_data) begin	//Si estoy en presencia de un 1 como dato
  	    out_data <= clk;	//Copio el clk
  	end else begin 		//Si estoy en presencia de un 0 como dato
	    out_data <= 1'b1;	//Pongo en 1 la salida
	    end
      end else begin		//Si estoy en la segunda mitad de ETU
	if(~in_data) begin	//Si estoy en presencia de un 0 como dato
  	    out_data <= clk;	//Copio el clk
  	end
	end	
	end
  end
	 	    
  always @ (posedge clk, negedge in_enable) begin
       if(~in_enable) begin	//Cuando esta desabilitado el modulo, pongo la salida y el contador en 0 (cero)
	out_data <= 1'b0;
	etu <= 1'b0;
	count <= {N{1'b0}};
      end else begin
      
      if(~etu) begin		//Si estoy en la primera mitad del ETU
	if(in_data) begin	//Si estoy en presencia de un 1 como dato
  	    out_data <= clk;	//Copio el clk
  	end else begin 		//Si estoy en presencia de un 0 como dato
	    out_data <= 1'b1;	//Pongo en 1 la salida
	    end
      end else begin		//Si estoy en la segunda mitad de ETU
	if(~in_data) begin	//Si estoy en presencia de un 0 como dato
  	    out_data <= clk;	//Copio el clk
  	end
	end
	end
  end  
endmodule