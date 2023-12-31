#!/usr/bin/bash
# shellcheck disable=SC1091

export LAUNCHER=1
shopt -s extglob # enable extglob shell option for
# extended pattern matching


#-------------------------------------------------------
#--------------------PAGE READING-----------------------
#-------------------------------------------------------

:<<-'READ_PAGE'
	Takes a page as an input and split it into sections
	Allows the user to go through the sections and go to
	next section or previous section
	READ_PAGE
read_page(){
	declare page
	declare -a sections
	declare -l section
	declare prompt
	declare -i i=0
	declare -I separator

	prompt="Please enter a section number.\n\
Press '${GRN}n${CRESET}' for next or '${GRN}p${CRESET}' for previous \n\
Press '${GRN}r${CRESET}' to rerender section or '${GRN}q${CRESET}' to quit\n\
Press '${GRN}k${CRESET}' to clear terminal or '${GRN}s${CRESET}' to print sections \n\
Example: '23' or 'q'\
"
	if ! find_page_section "$1" ; then return 0 ; fi
	if [ "$separator" = "" ] ; then separator="=" ; fi
	page="$ret_val"
	print_sections "$page"
	list_sections "$page"
	IFS="$separator" read -ra sections <<<"$ret_val"
	while true
	do
		user_input "$prompt" section
		case "$section" in ( [n] ) (( ++i )) ;;
					[p] ) (( --i )) ;;
					[r] ) ;;
					+([[:digit:]]) ) (( i="$((section))" )) ;;
					[q] ) break ;;
					[k] ) command clear
						echo -e "You are on section : ${GRN}$i${CRESET}" ; continue ;;
					[s] ) print_sections "$page"
						echo -e "You are on section : ${GRN}$i${CRESET}" ; continue ;;
					* ) echo "Unrecognized option, try again"
						continue ;;
		esac
		if [ "$i" -lt 1 ] || [ "$i" -gt "${#sections[@]}" ]
		then break ; fi
		echo -e "You entered : ${GRN}$section${CRESET}"
		echo -e "You are now on section : ${GRN}$i${CRESET}"
		if [ "$i" -lt "${#sections[@]}" ]
		then cut_man "$page" "${sections[$((i-1))]}" "${sections[$i]}"
		else cut_man "$page" "${sections[$((i-1))]}" "$"
		fi
	done
}

#----------------------------------------------------------
#---------------------PAGE SELECTION-----------------------
#----------------------------------------------------------

:<<-'MAIN_MENU'
	Main function that will be used to run the script
	MAIN_MENU
main_menu(){
	local ret_val
	declare prompt
	declare continue_prompt
	declare -l continue_value
	declare page

	continue_prompt="Would you like to read another page?[y/n]"
	prompt="Please provide a man page to read:\n\
You can provide an section to look in with an optionnal .\n\
Example: printf or printf.3"
	while true
	do
		echo -ne "$prompt\n$> "
		read -re page
		read_page "$page"
		if [ "$page" = "" ] ; then continue ; fi
		echo -e "$continue_prompt"
		read -r -n 1 continue_value
		echo
		if [ "$continue_value" != 'y' ] ; then break ; fi
	done
	if [ "$continue_value" = "n" ]
	then echo "Thanks for using"
	else echo "Unrecognized option"
	fi
}
