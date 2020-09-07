##
# Compilacion con iverilog

~~~.sh
$ iverilog -o CPU alu.v cd.v componentes.v  memdataexter.v syscon.v cpu_tb.v memoriaDatos.v memprog.v uc.v cpu.v pila.v wishbone_master.v wishbone_slave.v
~~~
~~~.sh
$ vvp CPU 
~~~    
~~~.sh
$ gtkwave cpu_tb.vcd & 
~~~    
