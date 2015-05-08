# serial\_parser\_storage
Backend for my first half capstone project...

## Project Vision

This will be a small command-line app that serves up and stores parsed serial data from a midi-controller...

Users will be able to record input, store-it, and call upon it either live or from storage for visualization.

The purpose of this will be for education and analyzation of data.


## Structure

- If the data is tabular Column Names could include: SessionID | SensorId | PressureValue | TimeStamp | TimeSinceStartOfCycle? | TimeSinceStartOfSession
- Otherwise if the data is PostGres then treat as such?
- Otherwise if the data is NoSQL then focus on posting just the key:val pairs with a timestamped UID?

## Features

### Connect to Serial Device

  In order to read data I want to connect to a device through USB...

####Requirements

- On startup the app should generate the initial model. (The first table)
- The app should output a friendly message to please connect one device. (Maybe handling many devices will be added down the road)
- The app should wait with some sort of listener until the device is connected
- It should verify the connection and wait for the user to initiation a "Session" (Instance of a recording of data)
- Once connection is verified output a confirmation message "Connected on (EG: /dev/tty.usbmodemfa141)"

### Instantiating a Session

  In order to instantiate a session I want to be connected to a device.

- The app should ask the user how long the recording will be.
- The app should make a Note: to the user that the recording can be stopped at any time before the specified length using the special key

### Record input from Serial Device

In order to store data I want to post serial input into the DB for some specified amount of time (either hard coded, or specified by the user on startup).


#### Requirements

  - The user should be able to initiate a "Session" either by pressing a button or entering a command.
  - The command should start polling the data.
    - Meaning the code will need to find the start key from the stream and begin "recording"/storing each key:val pair from that point forward. (Sync up stream with listener)
  - As the data is streaming in a timestamp should be generated for each key:val pair and stored in the DB along with its K:V pair.
  - If either the Key or Val are nil, undefined, or non-existent, the app should log an error message but should continue running with out loosing sync.
    - The premise is that we should be able to determine if values are being dropped, which values they are and when they're being dropped, etc...
  - The user should be able to stop a "recording" at any point during the duration of the recording using another button or command.
  - The user should see an indicator of the progress of the recording. EG. Some sort of Progress Bar

### Store Parsed data in DB

#### Requirements

  In order to query data from the DB I'll need to store the Parsed data.
  - The storage should happen either...
    1. on each iteration of a Key:Val pair or...
    2. on each "Cycle" (The iteration over all possible SensorId's.)
  - Given that the number of SensorId's is subject to change I think option 1: would be most fitting.

### Stop Recording

#### Requirements

  - The user should be able to at any point in time during the duration of a single session stop the recording
  - This entails stopping the posting of data to the DB and halting the serial parser without disconnecting.
  - Recording should halt with a message stating the Session was halted or finished on time.
  - User should be given the option to start another session or quit.

### Quit program

#### Requirements

  - The user should be able to ^c, ^z, ^/, or q to stop a recording and quit the program.
  - The recorded data should be stored in the DB so as to persist.
  - The user should be shown an option to close the program from any point in the program... Start, Record, Stop.

### Read data from table in DB.

  In order to analyze the data in the first place I want to be able to query the DB for particular recordings.

#### Requirements

  - The user should be able to query the DB for particular recordings for the purpose of visualizing the data in meaningful ways.
  - The user I suppose could theoretically ask the DB for which OK I'm confused again... To Be Continued...
