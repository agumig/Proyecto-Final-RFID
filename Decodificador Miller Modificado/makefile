#########################################################################################
# Comandos del MAKEFILE									#
#	"make compilar" - compila							#
#	"make simular" - compila el testbench y simula					#
#	"make mostrar" - compila, simula y muestra el resultado				#
#	"make limpiar" - elimina todos los archivos generados para compilar y simular.	#
#	"make all" - limpia, compila, simula y muestra					#
#########################################################################################
#Archivos

FUENTE = mill_modif_demod.v
TESTBENCH = tb_mill_modif_demod.v
SALIDA = mill_modif_demod.out
##########################################################################################
#Herramientas
COMPILADOR = iverilog
SIMULADOR = vvp
VISUALIZADOR = gtkwave
#TOOL OPTIONS
COMP_FLAGS = -o
COMP_OUT = compilador.out
SIM_OUT = mill_modif_demod_tb.vcd	#VER tb_mill_modif_demod.v ---> linea 9 'module mill_modif_demod_tb;'
##########################################################################################
#DIRECTIVAS

.PHONY: all
all: limpiar compilar simular mostrar

.PHONY: limpiar
limpiar: 
	clear
	@echo	'Arvhivos *.out y *.vcd eliminados.'
	-rm -f *.out *.vcd

.PHONY : ayuda
ayuda:	
	@echo	'Uso:'
	@echo	'  make all:      Limpia, compila, simula y muestra.'
	@echo	'  make compilar: Compila los archivos TB y verilog.'
	@echo	'  make simular:  Compila y simula con vvp.'
	@echo	'  make mostrar:  Compila, simula y muestra con GTKwave.'
	@echo	'  make limpiar:  Elimina todos los archivos generados para compilar y simular.'
	@echo	''

compilar : $(TESTBENCH) $(FUENTE)
	$(COMPILADOR) $(TESTBENCH) $(FUENTE) $(COMP_FLAGS) $(SALIDA)

simular: $(SALIDA)
	$(SIMULADOR) $(SALIDA)

mostrar: $(SALIDA)
	$(VISUALIZADOR) $(SIM_OUT) & 

$(SALIDA): $(COMP_OUT)
	$(SIMULADOR) $(SALIDA) 
$(COMP_OUT): $(TESTBENCH) $(FUENTE)
	$(COMPILADOR) $(TESTBENCH) $(FUENTE) $(COMP_FLAGS) $(SALIDA) 
