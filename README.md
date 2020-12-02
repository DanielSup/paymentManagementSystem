# Payment management system
It is a web application for managing payments. Payment contain description and amount and tags. This application needs PostgreSQL database.

## Instalation
First, you need to download the application and configure database connection. You need to configure ```database```, ```username``` and ```password``` in ```database.yml``` file in ```config``` directory. If you don't have local database and you have hosted database, you need to change ```host```.

First, you need to run ```bundle install``` command to install necessary gems. After ```bundle install``` you need to run ```rake commands``` for adding tables to the given database and initial data.

If the database with the given name in ```database.yml``` configuration file doesn't exist and user has enough permissions to create a new database, you need to run first ```rake db:create```. In every case you need to run ```rake db:migrate``` to add tables to the database and ```rake db:seeds``` to add initial data with admin user before starting of the application.

## Configuration
For correct working of the application you need to configure database connection for development if you want to run application locally, test, if you want to run tests and production if you want to run the application on production. You can configure database connection in ```database.yml``` file in ```config``` directory. In config directory you need to set ```database```, ```username``` and ```password``` keys for every environment which you want to use.

If you want to change the number of records in a page or other pagination settings, you need to change ```kaminari_config.rb``` file in ```config/initializers``` directory. The number of records in one page is set to 5 for testing purposes. When you comment this line ```config.default_per_page = 5``` in ```kaminari_config.rb```, then it will be 25 records in one page.