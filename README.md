## ABOUT PROJECT
Below you will learn how to run the command correctly and its flags.

### NAME
* create-node-app - Easily create Node.js applications with a default directory structure and packages

### SYNOPSIS
> _Commands between square brackets are optional_
```
$ create-node-app [-an] [-vPackageName] app-name [packageName1 packageName2 packageNameN]
```

### DESCRIPTION
Creates Node.js applications with a default directory structure and packages if none of flags is specified. User can disable default packages installation and he can provide a list of packages to install with application creation. See [Options](#options) list section for details.

### OPTIONS
```
    -a
        api only: disables views directory creation and view engine setup in the server.js file.
    -n
        no default packages: disables default packages installation.
    -vPackageName
        view engine: installs "PackageName" view engine and set it up in the server.js file.
```

## DEFAULT INSTALLATION 
These packages will be installed by default:
* bcryptjs
* cors
* dotenv
* express
* handlebars (if -vPackageName is not specified)
* nodemon

## DEFAULT FILES SETUP
//TODO: server.js and package.json setup

## NOTES
1. Only following packages are setup when using -vPackageName option:
    * ejs
    * handlebars (default)
    * pug

2. If user doesn't provide -n option or -vPackageName, express-handlebars will be installed automatically.

3. If express-handlebars is installed, the following structure will be added to views directory:
```
views/
    |---- layouts
        |---- main.hbs
    |---- partials
        |---- header.hbs
        |---- footer.hbs
    |---- index.hbs
```
//TODO: sequelize setup


## PROJECT TREE
When running create-node-app directory-name, this script creates the following structure to your project:

```
application-name/
       |---- __tests__/
       |---- node_modules/
       |---- public/
               |---- css/
               |---- js/
               |---- vendor/
       |---- src/
               |---- config/
                       |---- database.js
                       |---- server.js
               |---- controllers/
               |---- middlewares/
               |---- models/
               |---- routes/
               |---- views/
               |---- app.js
       |---- .editorconfig
       |---- .env
       |---- .env.example
       |---- .env.test
       |---- .gitignore
       |---- package.json
```
## AUTHOR
> **Françoar Santiago** - _Full Stack developer_ - [@fransantiago](https://github.com/fransantiago) on GitHub