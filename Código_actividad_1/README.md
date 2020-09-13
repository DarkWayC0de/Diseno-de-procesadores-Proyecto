##
# Compilacion con iverilog

~~~.sh
$ iverilog -o CPU alu.v cd.v componentes.v cpu_tb.v cpu.v memdataexter.v memoriaDatos.v memprog.v  pila.v syscon.v uc.v  wishbone_master.v wishbone_slave.v wishbone_master_arbitrator.v  
~~~
~~~.sh
$ vvp CPU 
~~~    
~~~.sh
$ gtkwave cpu_tb.vcd & 
~~~    
