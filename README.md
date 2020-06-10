# iOS_MBot_Controller
iOS App to control MBot Manually

The File BotCode has the code of mblock, you'll need mBlock app to run this code. 
The app Starts at BluetoothDevicesViewController and is limited to show only makeblock devices in a table, on connecting a device the controller MbotViewController opens up. 
BluetoothConnectionHandler has a singleton bluetooth class to manage bluetooth events and controls, 
ArduinoController is a singleton class for controlling ardiuno.

Supports iphone and ipad. 
