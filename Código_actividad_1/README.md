##
# Compilacion con iverilog

~~~.sh
$ iverilog -o CPU iverilog cpu_tb.v alu.v cd.v componentes.v cpu.v entradaSalida.v memoriaDatos.v memprog.v  pila.v timer.v  uc.v 
~~~
~~~.sh
$ vvp CPU 
~~~    
~~~.sh
$ gtkwave cpu_tb.vcd & 
~~~    
