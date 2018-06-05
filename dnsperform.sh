#!/bin/csh

if ( $#argv == 0 ) then 
	echo "Entre com o servidor DNS a ser usado" 
	exit
endif

set tempo = 0
set cont = 0
set soma = 0

foreach i ( `cat hosts.txt` )
	echo $tempo
	echo $cont
	echo $i
	set tempo = `dig $i @$1 | grep Query | cut -f4 -d" "`
		if ( `echo $?` != 0 ) then
			set soma = 1000 \+ $soma
		elseif
			set soma = `expr $tempo \+ $soma` 
		endif
	set cont = `expr $cont \+ 1`
end

echo "Servidor DNS: $1"
echo "Tempo total: $soma"
echo "Media de tempo: `expr $soma / $cont` "
echo "Total de consultas: $cont"
