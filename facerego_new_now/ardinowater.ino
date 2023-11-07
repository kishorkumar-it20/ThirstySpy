int IR = 4;
int MOT = 13;
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
    pinMode(MOT,OUTPUT);
//  digitalWrite(MOT, LOW);
//    digitalWrite(in2, LOW);
    pinMode(flowsensor, INPUT);
    digitalWrite(flowsensor, HIGH); 
    Serial.begin(9600);
    attachInterrupt(0, flow, RISING); 
    sei();
    currentTime = millis();
    cloopTime = currentTime;

}

void loop() {
  int statusSensor = digitalRead(IR);
//  Serial.println(statusSensor);
  if(statusSensor == 0)
  {
    digitalWrite(MOT,HIGH);
    currentTime = millis();
   if(currentTime >= (cloopTime + 1000))
   {
      cloopTime = currentTime; 
      l_hour = (flow_frequency * 60 / 7.5);
      flow_frequency = 0; // Reset Counter
//      l_hour = ((l_hour)*1000)/3600;// Print litres/hour
      Serial.println(l_hour);

      
      Serial.println("L/hr");
      
    
    }
  }
  else{
    digitalWrite(MOT,LOW);
  }



}
