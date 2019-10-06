# Rails Engine

By Joshua Sherwood

Rails Engine is a sales engine database that returns information to a client based on a specific type of query. Ruby on Rails framework is used to build the application. ActiveRecord is used to make database inquiries. PostgreSQL is used to build the database.

## New/Notable Material in Project:

* All enpoints return information in JSON format
* Information returned includes a single resource, all instances of a resources, all instances of a resource with a shared attribute, the relationships that a resource has with other resources, and a random resource.
* Application includes a rake task which imports all information from the CSV files and creates corresponding records
* Use of single-responsibility controllers
