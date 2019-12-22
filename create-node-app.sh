#!/bin/bash

#Messages strings
node_or_npm_not_found="Node.js or npm not found. Please install them correctly."
usage="Usage: create-node-app [-an] [-vPackageName] app-name [packageName1 packageName2 packageNameN]"

views_packages=(handlebars express-handlebars)
defaults_packages=(bcryptjs cors express)
defaults_dev_packages=(dotenv nodemon)

#Verify if node and npm are installed
if ! [ -x /usr/bin/node ] || ! [ -x /usr/bin/npm ]; then
	echo $node_or_npm_not_found
fi

function show_usage_and_exit {
    echo $usage
    echo 
    exit 1
}

function set_n_a_options {
	case ${1:1} in
		an|na)
			api_only=1
			no_defaults=1
			return 0;;
		a)
			api_only=1
			return 0;;
		n)
			no_defaults=1
			return 0;;
	esac
}

function starts_with_dash {
	[[ ${1:0:1} == "-" ]]
}

function is_valid_option {
	if ! starts_with_dash $1; then
		return 1;

	else
		#tests first letter after dash
		case ${1:1:1} in
			a|n)
				[ ${#1} -gt 3 ] && show_usage_and_exit

				if [ ${#1} -le 3 ]; then
					set_n_a_options $1
					return $? #always return 0
				fi
				break;;
			v)
				if [ ${#1} -eq 2 ]; then
                    show_usage_and_exit

				else
                    views_packages=(`echo ${1:2} | tr '[:upper:]' '[:lower:]'`)
					return 0
				fi
				break ;;
			*)
			return 1;;
		esac
	fi
}

i=1
is_valid_option_args=1

while [ $1 ]; do
    [ $i -ge 3 ] && is_valid_option_args=0

    if is_valid_option $1; then
        [ $is_valid_option_args -ne 1 ] && show_usage_and_exit

    else
        if [ $is_valid_option_args -eq 1 ]; then
            is_valid_option_args=0
            application_name=$1
        else
            if [ $i -eq 3 ] && [ -z application_name ]; then
                application_name=$1
            else
                user_packages+=($1)
            fi
        fi
    fi

	i=$[ $i + 1 ]
	shift
done

! [ -z $api_only ] && unset views_packages
! [ -z $no_defaults ] && unset defaults_packages && unset defaults_dev_packages

[ -d $application_name ] && echo "$application_name already exists." && exit 1

############### DIRECTORIES AND FILES CREATION ###############

mkdir $application_name && cd "$_"
echo "$application_name directory has been created."

npm init -y 1> /dev/null
echo "package.json has been created."

echo "creating default directories and files..."

if [ -z $api_only ]; then
    mkdir public
    cd public && mkdir css js vendor
    cd css && touch index.css
    cd ../js && touch index.js
    cd ../..
    echo "public directory has been set up successfully..."
fi

touch .env .env.example .env.test .editorconfig .gitignore
echo ".env*, .editorconfig and .gitignore files have been created successfully"

echo "Working on src directory..."
mkdir src __tests__
cd src && mkdir config controllers middlewares models routes && touch app.js
cd config && touch database.js server.js && cd ..
if [ -z $no_defaults ]; then
    mkdir views
fi
cd ..
echo "Done."

############### PACKAGES INSTALLATION ###############

echo "Installing packages..."

if [ -z $no_defaults ]; then
    echo "Installing default dev dependencies packages -> [ ${defaults_dev_packages[@]} ]"
    npm i -D ${defaults_dev_packages[@]}
    echo "Done."
fi

echo "Installing default packages -> [ ${defaults_packages[@]} ]"
npm i ${defaults_packages[@]}

if [ -z $api_only ]; then
    npm i ${views_packages[@]}
fi

echo "Done."

if ! [ -z $user_packages ]; then
    echo "Installing $USER packages -> [ ${user_packages[@]} ]"
    npm i -D ${user_packages[@]}
    echo "Done."
fi