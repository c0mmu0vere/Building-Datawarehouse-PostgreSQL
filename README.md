# Building-Datawarehouse-PostgreSQL
In this repository you will find the code and instructions to do the following:
- Set up a PostgreSQL database *"dvdrental"*.
- Create the DataWarehouse tables from the star model that we created.
- Insert data into the new DataWarehouse from the *dvdrental* database.

I also want to give a special thanks to [@DarshilParmar](https://www.youtube.com/@DarshilParmar) for helping me in developing these very important projects on the self-taught path to learning data engineering!

# Setting up the dvdrental database
For this project we use the **"dvdrental"** database.

You can find all the information that I will detail below, including the download link for the db *"dvdrental"* in the following `<link>` : <https://www.postgresqltutorial.com/postgresql-getting-started/postgresql-sample-database/>

## First step
The first thing we must do is download the dvdrental db found in the following link: `<Download dvdrental>`: https://www.postgresqltutorial.com/wp-content/uploads/2019/05/dvdrental.zip/ (the same link is found in the tutorial link that I attached previously)

⚠️ **Important consideration:** The file is in **.zip** format. It is necessary to extract it to obtain the db **dvdrental.tar** that we will mount in PostgreSQL

## Second step
Once the **dvdrental.tar** file has been downloaded and obtained, the next thing will be to mount it.
I will detail the instructions to set it up, but you can find them in the following `<link>`: <https://www.postgresqltutorial.com/postgresql-getting-started/load-postgresql-sample-database//>

### Load the sample database using the psql & pg_restore tool
`psql` is a terminal-based client tool to PostgreSQL. It allows you to enter queries, send them to PostgreSQL for execution, and display the results.

`pg_restore` is a utility for restoring a database from an archive.
To create a database and load data from an archive file, you follow these steps:
- First, connect to the PostgreSQL database server using psql or pgAdmin.
- Second, create a blank database called dvdrental.
- Third, load data from the sample database file into the dvdrental database using pg_restore.

⚠️ **Important consideration:** You need to have PostgreSQL installed on the computer to use the `pgAdmin` tool or the `psql` command interface. You can download it from the following link: `<Download PostgreSQL>`: <https://www.postgresqltutorial.com/postgresql-getting-started/postgresql-sample-database/>

1) **Create the dvdrental database**

    First, open the Command Prompt on Windows or Terminal on Unix-like systems and connect to the   PostgreSQL server using psql tool:
    `psql -U postgres`. It’ll prompt you to enter a password for the postgres user.
  
    ❗The password for the `postgres` user is the one you entered during the PostgreSQL   installation.
  
    After entering the password correctly, you will be connected to the PostgreSQL server.
    The command prompt will look like this: ***postgres=#***

   Second, create a new database called dvdrental using CREATE DATABASE statement: `CREATE DATABASE dvdrental;`.

   PostgreSQL will create a new database called dvdrental.

    ❗Third, verify the database creation using the `\l` command. The \l command will show all databases in the PostgreSQL server.
  
    Fourth, disconnect from the PostgreSQL server and exit the psql using the `exit` command.

2) **Restore the sample database from a tar file**

    Fifth, download the sample database (`dvdrental.zip`) and extract the `tar` file to the directory such as `D:\sampledb\postgres\dvdrental.tar` on Windows.
    
    Sixth, using Powershell (on windows) or Bash (on linux), load the `dvdrental` database using the `pg_restore` command:
   `pg_restore -U postgres -d dvdrental D:\sampledb\postgres\dvdrental.tar`

   It’ll prompt you to enter the password for the postgres user. Enter the password for the `postgres` user and press the Enter (or Return key).

   It’ll take about seconds to load data stored in the `dvdrental.tar` file into the `dvdrental` database.

3) **Verify the sample database**

   First, connect to the PostgreSQL server using the **psql** command: `psql -U postgres`

   Second, switch the current database to dvdrental: `\c dvdrental`

   The command prompt will change to the following: **dvdrental=#**

   Third, display all tables in the dvdrental database: `\dt`

## Third step
Now that we have our database set up, we can use the **DLL Querys.sq** files to build the data warehouse tables according to the star schema (you can find it in the **utilities** folder). And later use the **DML Querys.sql** file to insert the corresponding data into these tables.

# Requirements
You need to have installed or use the following tools to run the code:
- **PostgreSQL** with `pgAdmin4` or `psql` to interact with him.
