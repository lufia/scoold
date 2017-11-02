#!/usr/bin/env bash

config=application.conf
words=(para.security.ldap para.mail para)
disabled_vars=(PARA_ACCESS_KEY PARA_SECRET_KEY)

function get_key()
{
	local v=${1,,} # tolower; this enables bash 4.0 or later
	local x

	for i in "${words[@]}"
	do
		x=${i//./_}_
		if [[ $v == $x* ]]
		then
			echo $i.${v#$x}
			return 0
		fi
	done
	return 1
}

: >$config
[[ -s $ACCESS_KEY_PATH && -s $SECRET_KEY_PATH ]] || exit 1
echo "para.access_key = \"$(cat $ACCESS_KEY_PATH)\"" >>$config
echo "para.secret_key = \"$(cat $SECRET_KEY_PATH)\"" >>$config

env | sed -n '/^PARA_/s/=.*//p' | sort | while read v
do
	if [[ " ${disabled_vars[@]} " =~ " $v " ]]
	then
		echo warning: ignoring $v >&2
		continue
	fi
	key=$(get_key $v)
	if [[ -z $key ]]
	then
		continue
	fi

	case "${!v}" in
	true|false)
		echo "$key = ${!v}" >>$config ;;
	[0-9]*)
		echo "$key = ${!v}" >>$config ;;
	*)
		echo "$key = \"${!v}\"" >>$config ;;
	esac
done
echo '---------------'
cat $config
echo '---------------'

exec java -jar -Dconfig.file=./application.conf scoold.jar
