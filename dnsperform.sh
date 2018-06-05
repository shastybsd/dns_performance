#!/bin/csh

if ( $#argv == 0 ) then 
	echo "Entre com o servidor DNS a ser usado" 
	exit
endif

set tempo = 0
set cont = 0
set soma = 0

foreach i ( `cat hosts.txt` )
	echo "Tempo da consulta do host $i $tempo"
	echo "Numero da consulta: $cont"
	echo "Tempo total: $soma"
	set tempo = `dig $i @$1 | grep Query | cut -f4 -d" "`
#		if ( `echo $?` != 0 ) then
#			set soma = `expr 1000 \+ $soma`
#			echo "Com erro $soma"
#		elseif
			set soma = `expr $tempo \+ $soma` 
#			echo "Sem erro $soma"
#		endif
	set cont = `expr $cont \+ 1`
end

echo "=================================================="
echo "Servidor DNS: $1"
echo "Tempo total: $soma ms"
echo "Media de tempo: `expr $soma / $cont` ms"
echo "Total de consultas: $cont"
