# database-local-workspace-tool

This tool was created to easily restore MySQL databases locally and run queries against them.

Use cases:

* Local restore of data and easy way of querying the data safely away from production.
* Comparing multiple databases or multiple "points in time" of the same database.

## Prerequisities
In order to use this project, you will need the following installed on your system.

* This project was designed to be run on a Linux system (tested on Ubuntu 24.04, but should work on any distro).
* [Docker](https://docs.docker.com/engine/install/) - Docker is an open-source platform that enables developers to build, deploy, run, update and manage containers.
* [Taskfile](https://taskfile.dev/installation/) - Task is a task runner / build tool that aims to be simpler and easier to use than, for example, GNU Make.


## Usage
Below are instructions for getting started and using the project's different modes.

There are some useful tips when working on this project.

```bash
# Get a list of tasks available for this project.
task --list

# Get more information about a specific task.
task --summary sometask

# Check your current setup (docker-compose.yml is only required for multi-database mode).
task check-setup
```

### Getting started
Here are some setup instructions and examples to help you get started.

#### Single-database mode

1. Start by putting your `*.sql` files into the `./dump` directory. Alternatively, use the `demo.sql` supplied for demo purposes.

2. Start a database with the below command:

   Example Command:
   ```bash
   task db:start SQL_FILE=dumps/demo.sql
   ```

   Expected Output:
   ```text
   ...
   
   Database has started successfully!
   ```

   >
   > 🧠 Tip - You can reload the database with different SQL files by re-running the command with a different SQL_FILE specified. There is no need to stop the database first.
   >

3. Query your database with the below command.

   Example Command:
   ```bash
   task db:query QUERY="USE demo; SELECT * FROM user_details;"
   ```

   Example Output:
   ```text
   ...
   
   +---------+----------+------------+-----------+--------+--------+
   | user_id | username | first_name | last_name | gender | status |
   +---------+----------+------------+-----------+--------+--------+
   |       1 | rogers63 | david      | john      | Female |      1 |
   |       2 | mike28   | rogers     | paul      | Male   |      1 |
   |       3 | rivera92 | david      | john      | Male   |      1 |
   |       4 | ross95   | maria      | sanders   | Male   |      1 |
   |       5 | paul85   | morris     | miller    | Female |      1 |
   |       6 | smith34  | daniel     | michael   | Female |      1 |
   |       7 | james84  | sanders    | paul      | Female |      1 |
   |       8 | daniel53 | mark       | mike      | Male   |      1 |
   |       9 | brooks80 | morgan     | maria     | Female |      1 |
   |      10 | morgan65 | paul       | miller    | Female |      1 |
   +---------+----------+------------+-----------+--------+--------+
   ```

4. Stop the database with the below command.

   Example Command:
   ```bash
   task db:stop
   ```

   Example Output:
   ```text
   ...
   
   Database has stopped.
   ```

5. Finished. You can now try this with your own SQL file if you haven't already, or check out the other commands for single-database mode using `task --list`.

#### Multi-database mode

1. Start by putting your `*.sql` files into the `./dump` directory. Alternatively, use the `demo.sql` supplied for demo purposes.

2. Create a file called `docker-compose.yml` in the root of this project by copying the example. 

   docker-compose.yml
   ```yaml
   services:
     database1:
       extends:
         file: docker-compose.common.yml
         service: database-common
       environment:
         SQL_FILE: ${WORKSPACE_MOUNT_PATH}/dumps/demo.sql
     database2:
       extends:
         file: docker-compose.common.yml
         service: database-common
       environment:
         SQL_FILE: ${WORKSPACE_MOUNT_PATH}/dumps/demo.sql
   ```

   >
   > 📄 Info - The last part of the "SQL_FILE" environment variable can be updated to use different SQL files from the "dumps" directory.
   >

   >
   > 🧠 Tip - You can add as many database containers as your system can handle by adding more entries to the Docker Compose file.
   >

3. Start your databases with the below command:

   Example Command:
   ```bash
   task multi-db:start
   ```

   Expected Output:
   ```text
   ...
   
   Databases have started successfully!
   ```

   >
   > 🧠 Tip - You can reload the databases with different SQL files by re-running the command with a different SQL_FILE specified. There is no need to stop the databases first.
   >

4. Query all of your databases with the below command.

   Example Command:
   ```bash
   task multi-db:query QUERY="use game; show tables;"
   ```

   Example Output:
   ```text
   ...
   
   database2
   +---------+----------+------------+-----------+--------+--------+
   | user_id | username | first_name | last_name | gender | status |
   +---------+----------+------------+-----------+--------+--------+
   |       1 | rogers63 | david      | john      | Female |      1 |
   |       2 | mike28   | rogers     | paul      | Male   |      1 |
   |       3 | rivera92 | david      | john      | Male   |      1 |
   |       4 | ross95   | maria      | sanders   | Male   |      1 |
   |       5 | paul85   | morris     | miller    | Female |      1 |
   |       6 | smith34  | daniel     | michael   | Female |      1 |
   |       7 | james84  | sanders    | paul      | Female |      1 |
   |       8 | daniel53 | mark       | mike      | Male   |      1 |
   |       9 | brooks80 | morgan     | maria     | Female |      1 |
   |      10 | morgan65 | paul       | miller    | Female |      1 |
   +---------+----------+------------+-----------+--------+--------+
   
   Done
   ```
   
5. Stop all the databases with the below command.
   
   Example Command:
   ```bash
   task mult-db:stop
   ```
   
   Example Output:
   ```text
   ...
   
   All databases have stopped.
   ```
   
6. Finished. You can now try this with your own SQL files if you haven't already, or check out the other commands for multi-db mode using `task --list`.

## Developer Guide
Guide for those who want to make changes to the project or those who just want to know more about where things are.

### Repository Overview
Here is a quick overview of the repository and where things live.

```bash
.
├── .env                        # Variables and configuration shared between containers and Taskfile
├── .gitignore
├── LICENSE
├── README.md
├── Taskfile.yaml               # Taskfile that organises the commands/tasks for the project
├── docker-compose.common.yml   # Common configuration for extending Docker Compose
├── dumps                       # A directory to store your SQL files which won't be tracked by git
│   ├── README.md
│   └── demo.sql
└── scripts                     # A directory to store scripts
    ├── check-setup.sh          # Checks setup of the user's machine for using the project
    └── load-sql-file.sh        # Load SQL file inside the container (called within container)
```

### Making a change

Submit a pull request. 

# Author Information

This project was created in 2024 by [Aaron Turner](https://github.com/aturnr).