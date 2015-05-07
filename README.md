# serial_parser_storage
Backend for my first half capstone project...

## Project Vision

This will be a small command-line app with a SQLite back-end that serves up and stores parsed serial data from a midi-controller...

Users will be able to record input, store-it, and call upon it either live or from storage for visualization.

The purpose of this will be for education and analyzation of data.

## Features
### Connect to Serial Device
  In order to read data I want to connect to a device through USB...
### Record input from Serial Device
  ...for some specified amount of time (either hard coded, or specified by the user).
  In order to store data I want to Parse serial input into a meaningful data-structure (EG: Hash, Array, Etc...)
### Store Parsed data in SQLite DB
  In order to query data from the DB I'll need to store the Parsed data.
### Repeat as many times as desired.
  In order to have a meaningful understanding of the data I want mulitple sets (multiple recordings)
### Read data from table in DB.
  In order to analyze the data in the first place I want to be able to query the DB for particular recordings.
