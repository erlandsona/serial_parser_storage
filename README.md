# serial_parser_storage
Backend for my first half capstone project...

## Project Vision

This will be a small command-line app with a SQLite back-end that serves up and stores parsed serial data from a midi-controller...

Users will be able to record input, store-it, and call upon it either live or from storage for visualization.

The purpose of this will be for education and analyzation of data.

## Features
### Connect to Serial Device
  In order to read data I want to connect to a device through USB...
- On startup the app should generate the initial model. (The first table)

####Requirements

- The app should output a friendly message to please connect one device. (Maybe handling many devices will be added down the road)
- The app should wait with some sort of listener until the device is connected
- It should verify the connection and wait for the user to initiation a "Session" (Instance of a recording of data)
- Once connection is verified output a confirmation message "Connected on (EG: /dev/tty.usbmodemfa141)"
    

### Record input from Serial Device
In order to store data I want to post serial input into the DB for some specified amount of time (either hard coded, or specified by the user).


#### Requirements
  - The user should be able to initiate a "Session" either by pressing a button or entering a command.
  - The command should start polling the data.
    - Meaning the code will need to find the start key from the stream and begin "recording"/storing each key:val pair from that point forward. (Sync up stream with listener)
  - As the data is streaming in a timestamp should be generated for each key:val pair and stored in the DB along with its K:V pair.
  - If either the Key or Val are nil, undefined, or non-existent, the app should log an error message but should continue running with out loosing sync. 
    - The premise is that we should be able to determine if values are being dropped, which values they are and when they're being dropped, etc...
  - The user should be able to stop a "recording" at any point during the duration of the recording using another button or command.

### Store Parsed data in SQLite DB
  In order to query data from the DB I'll need to store the Parsed data.
  - See Recording the data for more info...
  
  
### Repeat as many times as desired.
  In order to have a meaningful understanding of the data I want mulitple sets (multiple recordings)
  - 
  
  
### Read data from table in DB.
  In order to analyze the data in the first place I want to be able to query the DB for particular recordings.
  
  
  
