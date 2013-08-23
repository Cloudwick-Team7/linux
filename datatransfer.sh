#!bin/env bash
total=$#;
pos=0;


name_format='*';
action='hadoop fs -cp';
src='/';
dest='/';

query='';

#checking for usage help
if [ $total -eq 1 ]; then
	case $1 in
		--help)
			echo "Help message";
			exit 1;
			;;
		*)
			echo "Type `basename $0` --help for listing the available options.";
			exit 1;
			;;
	esac
fi


#checking for options
while getopts ":n:m" opt; do
	case $opt in
		n)
			name_format="$OPTARG";
			pos=$(($OPTIND - 1));
                        ;;
		m)
			action='hadoop fs -mv';
			pos=$(($OPTIND - 1));
			;;
		\?)
			echo "Invalid option: -$OPTARG" >&2;
			exit 1;
			;;
		:)
			echo "Option -$OPTARG requires an argument.">&2;
			exit 1;
			;;
	esac	
done

#Checking for mass arguments
if [ $(($total - $pos)) -ne 2 ]; then
	echo "Insufficient arguments";
	exit 1;
else
	src=${*: -2:1};
	[[ $src != */ ]] && src="$src"/;
	dest=${*: -1:1};
fi


#Command execution
query="$action $src$name_format $dest";
`$query`;
exit 0;
