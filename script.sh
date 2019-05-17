#!/bin/bash 
procesarDatos () {
	horas=`echo $1 | cut -d ":" -f1`
	if [ $horas != "0" ]
	then
		horas=${horas/#0/" "}
	fi
       	minutos=`echo $1 | cut -d ":" -f2`
	if [ $minutos != "0"  ]
	then
		minutos=${minutos/#0/" "}
	fi
	segundos=`echo $1 | cut -d ":" -f3`
	if [ $segundos != "0" ]
	then
		segundos=${segundos/#0/" "}
	fi

}

suma () {
	procesarDatos $1
	horasWrite=$horas
	minutosWrite=$minutos
	segundosWrite=$segundos
	procesarDatos $2
	horasRead=$horas
	minutosRead=$minutos
	segundosRead=$segundos

	segundosTotal=$(($segundosRead+$segundosWrite))
	minutosTotal=$(($minutosRead+$minutosWrite))
	horasTotal=$(($horasRead+$horasWrite))
       	while [ $segundosTotal -ge 60 ]
	do
		segundosTotal=$(($segundosTotal-60))
		minutosTotal=$(($minutosTotal+1))
	done
	while [ $minutosTotal -ge 60 ]
	do
		minutosTotal=$(($minutosTotal-60))
		horasTotal=$(($horasTotal+1))
	done
	total=$horasTotal:$minutosTotal:$segundosTotal

	echo $total	
}
ficheroEscritura.txt >ficheroEscritura.txt
ficheroCopia.txt >ficheroCopia.txt
while read nombreRead tiempoRead
do
	boolean=0
	

	while read nombreEscritura tiempoEscritura
	do
		if [ $nombreRead = $nombreEscritura ]
		then
			suma $tiempoEscritura $tiempoRead
		       	sed "s/$nombreEscritura $tiempoEscritura/$nombreEscritura $total/" ficheroEscritura.txt >ficheroCopia.txt
				
			boolean=1
		fi
	done < ficheroEscritura.txt
	
	if test $boolean -eq  0
	then
		echo $nombreRead $tiempoRead >> ficheroEscritura.txt
	else
                cat ficheroCopia.txt >ficheroEscritura.txt

	fi

done < ficheroLectura.txt

