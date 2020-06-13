transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/DarkWayC0de_pc/Desktop/Diseno-de-procesadores-Proyecto1/Código_actividad_1 {C:/Users/DarkWayC0de_pc/Desktop/Diseno-de-procesadores-Proyecto1/Código_actividad_1/uc.v}
vlog -vlog01compat -work work +incdir+C:/Users/DarkWayC0de_pc/Desktop/Diseno-de-procesadores-Proyecto1/Código_actividad_1 {C:/Users/DarkWayC0de_pc/Desktop/Diseno-de-procesadores-Proyecto1/Código_actividad_1/timer.v}
vlog -vlog01compat -work work +incdir+C:/Users/DarkWayC0de_pc/Desktop/Diseno-de-procesadores-Proyecto1/Código_actividad_1 {C:/Users/DarkWayC0de_pc/Desktop/Diseno-de-procesadores-Proyecto1/Código_actividad_1/pila.v}
vlog -vlog01compat -work work +incdir+C:/Users/DarkWayC0de_pc/Desktop/Diseno-de-procesadores-Proyecto1/Código_actividad_1 {C:/Users/DarkWayC0de_pc/Desktop/Diseno-de-procesadores-Proyecto1/Código_actividad_1/entradaSalida.v}
vlog -vlog01compat -work work +incdir+C:/Users/DarkWayC0de_pc/Desktop/Diseno-de-procesadores-Proyecto1/Código_actividad_1 {C:/Users/DarkWayC0de_pc/Desktop/Diseno-de-procesadores-Proyecto1/Código_actividad_1/ecosisstem_cpu_for_quartus.v}
vlog -vlog01compat -work work +incdir+C:/Users/DarkWayC0de_pc/Desktop/Diseno-de-procesadores-Proyecto1/Código_actividad_1 {C:/Users/DarkWayC0de_pc/Desktop/Diseno-de-procesadores-Proyecto1/Código_actividad_1/cpu.v}
vlog -vlog01compat -work work +incdir+C:/Users/DarkWayC0de_pc/Desktop/Diseno-de-procesadores-Proyecto1/Código_actividad_1 {C:/Users/DarkWayC0de_pc/Desktop/Diseno-de-procesadores-Proyecto1/Código_actividad_1/cd.v}
vlog -vlog01compat -work work +incdir+C:/Users/DarkWayC0de_pc/Desktop/Diseno-de-procesadores-Proyecto1/Código_actividad_1 {C:/Users/DarkWayC0de_pc/Desktop/Diseno-de-procesadores-Proyecto1/Código_actividad_1/alu.v}
vlog -vlog01compat -work work +incdir+C:/Users/DarkWayC0de_pc/Desktop/Diseno-de-procesadores-Proyecto1/Código_actividad_1 {C:/Users/DarkWayC0de_pc/Desktop/Diseno-de-procesadores-Proyecto1/Código_actividad_1/memprog.v}
vlog -vlog01compat -work work +incdir+C:/Users/DarkWayC0de_pc/Desktop/Diseno-de-procesadores-Proyecto1/Código_actividad_1 {C:/Users/DarkWayC0de_pc/Desktop/Diseno-de-procesadores-Proyecto1/Código_actividad_1/memoriaDatos.v}
vlog -vlog01compat -work work +incdir+C:/Users/DarkWayC0de_pc/Desktop/Diseno-de-procesadores-Proyecto1/Código_actividad_1 {C:/Users/DarkWayC0de_pc/Desktop/Diseno-de-procesadores-Proyecto1/Código_actividad_1/componentes.v}

