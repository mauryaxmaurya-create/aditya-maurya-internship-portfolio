# University Enrollment System

## Overview

A Python application for managing student registration, authentication and subject enrollment through both a command-line interface and a Tkinter graphical interface. The project uses separate model, controller and persistence components to keep application responsibilities clear.

## Features

- Student registration and login with regular-expression validation
- Subject enrollment and withdrawal
- Mark, grade and average calculations
- Administrative student-management functions
- File-based data persistence
- Coloured CLI feedback and a Tkinter GUI

## Project structure

```text
controllers/    Application controllers
models/         Student, subject, admin and database models
gui/            Tkinter windows and GUI support
cli_main.py     Command-line entry point
gui_main.py     Graphical entry point
constants.py    Shared application constants
utils.py        Validation and formatting helpers
```

## Running the project

Create a virtual environment and install the dependencies:

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

Run the CLI:

```bash
python cli_main.py
```

Run the GUI:

```bash
python gui_main.py
```

The application stores local data in `data/students.data`. Do not use real passwords or personal information in demonstration records.

## Group project

This application was completed as a four-person university project. My contribution was the implementation of the `Student` class and `StudentController`, including their integration with the rest of the application. Contributor names and student identifiers are omitted from this portfolio copy for privacy.

## Project context

Group university project completed for Fundamentals of Software Development.
