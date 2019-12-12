#! /bin/bash
#https://github.com/freewhiskys/practica19


function usage() {
cat <<EOF	
	Usage: $./showattackers.sh [-f] LOGFILE
    Usage: $./showattackers.sh [-l] NUMBER [-f] LOGFILE 
    List IP's wich pass the limit.
	-f Set file. 
	-l Set limit of connections.
EOF
exit 1
}

LIMIT=20

while getopts ":l:f:" OPT;
do
  case ${OPT} in
    l)
        LIMIT=${OPTARG}
        ;;
    f)  
        LOG_FILE=${OPTARG}
        echo $LIMIT
        if [ ! -e "${LOG_FILE}" ]; then
            echo "Cannot open log file: ${LOG_FILE}" >&2
            exit 1
        else
            
            echo 'Count,IP,Location'
            sed -n '/Failed/p' $LOG_FILE | awk '{print $(NF - 3)}' | sort | awk '{c[$0]++} END {for (line in c) print c[line], line}' | sort -nr | while read COUNT IP; do
            if [ "${COUNT}" -gt "${LIMIT}" ]; then
                LOCATION=$(geoiplookup "${IP}" | awk -F ', ' '{print $2}')
                echo "${COUNT},${IP},${LOCATION}"
            fi
            done
        fi
        
        ;;
  
    :)
		# If the user doesn't supply at least one argument, give them help. 
		echo "ERROR: -$OPTARG requires an argument."
        usage
		;;
    \?)
        echo "ERROR: Invalid option -$OPTARG"
        usage
        ;;
  esac
done
