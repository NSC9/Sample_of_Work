/* 
  This code adapted from code by Jeremy Blum (jeremyblum.com),
  for his book: "Exploring Arduino" (exploringarduino.com)


  Blink
  Turns on an LED on for one second, then off for one second, repeatedly.

  Most Arduinos have an on-board LED you can control. On the UNO, MEGA and ZERO 
  it is attached to digital pin 13, on MKR1000 on pin 6. LED_BUILTIN is set to
  the correct LED pin independent of which board is used.
  If you want to know what pin the on-board LED is connected to on your Arduino model, check
  the Technical Specs of your board  at https://www.arduino.cc/en/Main/Products
  
  This example code is in the public domain.

  modified 8 May 2014
  by Scott Fitzgerald
  
  modified 2 Sep 2016
  by Arturo Guadalupi
  
  modified 8 Sep 2016
  by Colby Newman
  
  modified 8 Sep 2016
  by Nicholas S. Caudill nscaudill2020@manchester.edu
  
  
  An INO file is a software program created for use with Arduino, an open-source electronics prototyping platform.
  It contains source code written in the Arduino programming language. INO files are used to control Arduino circuit boards[0].
  [0] https://fileinfo.com/extension/ino
  
*/


// the setup function runs once when you press reset or power the board
void setup() {
  // initialize digital pin LED_BUILTIN as an output.
  pinMode(LED_BUILTIN, OUTPUT);
}

// the loop function runs over and over again forever
void loop() {
  digitalWrite(LED_BUILTIN, HIGH);   // turn the LED on (HIGH is the voltage level)
  delay(500);                       // wait for half a second -NSC9
  digitalWrite(LED_BUILTIN, LOW);    // turn the LED off by making the voltage LOW
  delay(3000);                       // wait for 3 seconds -NSC9
} 
