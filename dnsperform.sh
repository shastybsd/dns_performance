#!/bin/csh

if ( $#argv == 0 ) then 
	echo "Entre com o servidor DNS a ser usado" 
	echo "Exemplo: ./dnsperfom.sh 127.0.0.1"
	exit
endif

set tempo = 0
set cont = 0
set soma = 0

foreach i ( `cat hosts.txt` )
	echo "Tempo da consulta do host ${i}: $tempo ms"
	echo "Numero da consulta: `expr $cont \+ 1`"
	set tempo = `drill $i @$1 | grep Query | cut -f4 -d" "`
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
