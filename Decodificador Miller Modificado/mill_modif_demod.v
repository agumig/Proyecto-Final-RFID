/*------------------------------------------------------------------------
--                     Decodificador Miller Modificado                 	--
-- * 1.0                                                          	--
-- Descripcion:                                                   	--
--    	Decodificador manchester	                          	--
--Ingresa el frame recibido en codificacion miller mod y sale en NRZ-L	--
--	Test bench de este archivo en tb_mill_modif_demod.v		--
------------------------------------------------------------------------*/

module mill_modif_demod #(parameter N = 5)(clk, in_enable, in_data, out_data, pause);

input clk;		//Clock de fc/16 en RFID (847,5 KHz)
input in_data;		//Informacion - ETU de 106Kb/s (8 clocks dentro de cada ETU)
input in_enable;	//Bit de habilitacion del modulo
output reg out_data;	//Salida del decodificador miller modificado
input pause;	//Registro que viene desde el detector de pause

reg  [N-1:0] count;	//Cuento los cuatro clock para estar en la mitad del ETU
reg etu;		//0 si se está en la primer mitad del etu / 1 si se está en la segunda mitad
reg pre_out;		//Usado para ir haciendole AND a cada bit que llega por in_data
reg reg_pause;

  always @ (negedge clk, negedge in_enable, posedge pause) begin
      if(pause) begin		//Tomo el valor de la entrada y lo pongo en un registro
	reg_pause <= pause;
      end
      
      if(~in_enable) begin	//Cuando esta desabilitado el modulo, pongo la salida, los registros y el contador en 0 (cero)
	out_data <= 1'b0;
	etu <= 1'b0;	
	count <= {N{1'b0}};
	pre_out <= 1'b1;
	reg_pause <= 1'b0;
      end else begin
      
      count <= count +1;
      
      if(count == 5'b00010) begin	//Dos pulsos siguientes a la pausa, en el caso del 1
      if(reg_pause && etu) begin
	out_data <= 1'b1;
	count <= 5'b00001;		//reseteo el contador
	reg_pause <= 1'b0;		//Reseteo el registro
	etu <= ~etu;			//Reseteo el registro
      end
      end else begin
      
      if(count == 5'b10000) begin	//Cuando cuento la mitad de los clocks que entran en un etu
      if(reg_pause) begin		//Hubo una pausa
      if(~etu) begin			//No se conto una primer mitad del ETU 
	out_data <= 1'b0;		//Cero a la salida
	reg_pause <= 1'b0;		//Reseteo el registro
	count <= 5'b00001;		//reseteo el contador  
      end
      end else begin
      if(~etu) begin			//Es el primer ETU que cuento
      etu <= ~etu;
      end else begin
      etu <= ~etu;			//Reseteo el registro
      out_data <= 1'b0;			//Cero a la salida
      end
      end
      end
      end
      end
  end

endmodule