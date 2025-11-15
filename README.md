# App-TodoList

> A simple command-line to-do list manager written in Perl.

## About the Project

`App::TodoList` is a CLI tool that allows users to add, list, complete, and delete tasks directly from the terminal. All tasks are saved in a JSON file located in the user's home directory for persistent storage.

Key features include:
*   **Add Task**: Add a new task to the to-do list.
*   **List Tasks**: Display the current to-do list with task status (completed or not).
*   **Complete Task**: Mark a specific task as completed.
*   **Delete Task**: Remove a task from the list.
*   **Persistent Storage**: Tasks are saved locally in a JSON file.

## Tech Stack

The main technologies and libraries used in this project are:

*   [Perl](https://www.perl.org/)
*   [JSON](https://metacpan.org/pod/JSON)
*   [File::HomeDir](https://metacpan.org/pod/File::HomeDir)

## Usage

Below are the instructions for you to set up and run the project.

### Prerequisites

You need to have the following software installed:

*   [Perl](https://www.perl.org/get.html)
*   [cpanm](https://metacpan.org/pod/App::cpanminus) (a common Perl module installer)

### Installation and Setup

You can install the application via MetaCPAN (recommended) or manually.

**1. Install from MetaCPAN**
```bash
cpanm install App::TodoList
```

**2. Manual Installation**
```bash
# Clone the repository
git clone https://github.com/luizvilasboas/App-TodoList.git
cd App-TodoList

# Install dependencies
cpanm --installdeps .

# Build and install the module
perl Makefile.PL
make
sudo make install
```

### Workflow

After installation, you can use the `todo_list` command-line tool:

*   **Add a new task:**
    ```bash
    todo_list --add "Buy groceries"
    ```
*   **List all tasks:**
    ```bash
    todo_list --list
    ```
*   **Mark a task as completed (e.g., task number 1):**
    ```bash
    todo_list --complete 1
    ```
*   **Delete a task (e.g., task number 1):**
    ```bash
    todo_list --delete 1
    ```

## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request.

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.
