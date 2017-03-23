/*------------------------------------------------------------------
--                     Codificador Manchester                     --
-- * 1.0                                                          --

-- Descripcion:                                                   --
--    Codificador manchester 		                          --
------------------------------------------------------------------*/


module man_mod #(parameter N = 4)(clk, in_enable, in_data, out_data);

input clk,in_data,in_enable;
output out_data;

reg  [N-1:0] count;	//Cuento los cuatro clock para estar en la mitad del ETU
reg out_data;	//Salida del codificador

  always @ (negedge clk, negedge in_enable)
    begin
      if(~in_enable) begin
	out_data <= 1'b0;
	count <= 4'b0;
      end
	else if(in_data) begin
	    out_data <= clk;
	    count <= count + 4'b0001;
	    end else begin
	      out_data <= clk;
	    end
  end
	    
	    
  always @ (posedge clk, negedge in_enable)
    begin
       if(~in_enable) begin
       	count <= 4'b0;
	out_data <= 1'b0;
      end
        else if(in_data && count == {N{1'b1}}) begin
	  out_data <= 1'b1;
	  count <= {N{1'b0}};
	  end
  end
  endmodule
	  