#!/bin/bash
#MENU DE AYUDA
function usage(){
	cat <<-EOF
usage: ${0} [-l f ]
-l es el limite de registros que se mostraran
-f aqui indicaras tu fichero para que sea leido
	EOF
}
limite=30;
contador_ips=0;
# Asegúrese de que se proporcionó un archivo como argumento.
if [ $# -eq 0 ];
		then
			echo "no has indicado los parametros"
			usage
		else
			while getopts ":l:f:" par;
			do
				case $par in
				l)
				limite=${OPTARG}
				;;
				f)
				archivo_log=${OPTARG}
				echo ${limite}
				if [[ ! -e "${archivo_log}" ]];
				then
					echo "El fichero ${archivo_log}  no pudo abrirse"
				else
					grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' $1 > las_ips.txt
					#ordenar las ips
					ips = $(sort -u las_ips.txt | wc -l)
# Mostrar el encabezado CSV.
					echo "Cuenta, IP, Localizacion"
# Recorrer la lista de intentos fallidos y la IP correspondiente direcciones.
					while [[ ${contador_ips} -gt ${limite} ]];
					do
						contar_las_ips = $(grep -o -c "${ips} del system-log")
						localizar = $(geoiplookup ${ips})
						echo ${Contar_las_ips}, ${ips}, ${localizar}
					done
				fi
				;;
				esac
			done
fi
# Si el número de intentos fallidos es mayor que el límite, visualice recuento, IP y ubicación.
