#include <SPI.h>
#include <Wire.h>
#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>
#define OLED_RESET 4
Adafruit_SSD1306 display(OLED_RESET);

int IR = 5;
int MOT_DRIV = 8;
int Total= 0;
int mm_sec = 0;
int Finale=0;
//int in2 = 11;
int l_hour; // Calculated litres/hour
unsigned char flowsensor = 2; // Sensor Input
unsigned long currentTime;
unsigned long cloopTime;  
volatile int flow_frequency;


void flow () // Interrupt function

{
   flow_frequency++;
}


void setup() {
    pinMode(IR,INPUT);
    pinMode(MOT_DRIV,OUTPUT);
    
//  digitalWrite(MOT, LOW);
//    digitalWrite(in2, LOW);
    pinMode(flowsensor, INPUT);
    digitalWrite(flowsensor, HIGH); 
    Serial.begin(9600);
    attachInterrupt(0, flow, RISING); 
    sei();
    currentTime = millis();
    cloopTime = currentTime;
    display.begin(SSD1306_SWITCHCAPVCC, 0x3C);
    display.clearDisplay();


}

void loop() {
  int statusSensor = digitalRead(IR);
//  Serial.println(statusSensor);
  display.setTextSize(2);
  display.setTextColor(WHITE);
  display.setCursor(0,0);
  if(statusSensor == 0)
  {
    digitalWrite(MOT_DRIV,HIGH);
    currentTime = millis();
   if(currentTime >= (cloopTime + 1000))
   {
      display.clearDisplay();
      cloopTime = currentTime; 
      l_hour = (flow_frequency * 60 / 7.5);
      flow_frequency = 0; // Reset Counter
//      l_hour = ((l_hour)*1000)/3600;// Print litres/hour
      
      mm_sec = l_hour * 0.28;
      
      
      Total = Total + mm_sec;
      display.println("MlperSEC :");
      display.println(Total);
      display.display();
      
      display.clearDisplay();
    }
  }
  else{
    digitalWrite(MOT_DRIV,LOW);
    Finale = Total;
    Total = 0;
    if(Finale != 0){
      Serial.println(Finale);
      display.println("Finale_ml");
      display.println(Finale);
      display.display();
    }
    
    
    
    
    
    
    
  }
  



}
