sbit LCD_RS at RD2_bit;
sbit LCD_EN at RD3_bit;
sbit LCD_D4 at RD4_bit;
sbit LCD_D5 at RD5_bit;
sbit LCD_D6 at RD6_bit;
sbit LCD_D7 at RD7_bit;

sbit LCD_RS_Direction at TRISD2_bit;
sbit LCD_EN_Direction at TRISD3_bit;
sbit LCD_D4_Direction at TRISD4_bit;
sbit LCD_D5_Direction at TRISD5_bit;
sbit LCD_D6_Direction at TRISD6_bit;
sbit LCD_D7_Direction at TRISD7_bit;



int hesap = 0,y=0,a=0;
float deger = 0;
char voltaj[8] , m[14] , watts[10];
float Voltage = 0;
float VRMS = 0;
float AmpsRMS = 0;
int mVperAmp = 185;
int sdeger=0;

float getVPP()
{
  float result;
  int readValue;             //value read from the sensor
  int maxValue = 0;          // store max value here
  int minValue = 1024;          // store min value here


   for(y=0;y<200;y++) //sample for 1 Sec
   {
       readValue = ADC_Read(3);
       // see if you have a new maxValue
       if (readValue > maxValue)
       {
           /record the maximum sensor value/
           maxValue = readValue;
       }
       if (readValue < minValue)
       {
           /record the minimum sensor value/
           minValue = readValue;
       }
   }

   // Subtract min from max
   result = ((maxValue - minValue) * 5.0)/1024.0;

   return result;
 }
void main() {


     TRISD = 0x00;
     PORTD = 0;
     TRISB = 0xff;
     TRISA = 0xFF;
     ADCON0 = 0x01;
     ADCON1 = 0x01;
     CMCON |= 0x07;


     Lcd_Init();
     Lcd_Cmd(_LCD_CLEAR);
     Lcd_Cmd(_LCD_CURSOR_OFF);
     Lcd_Out(1,1,"KTO KARATAY");
     Lcd_Out(2,1,"UNIVERSITESI");
     delay_ms(1500);
     Lcd_Cmd(_LCD_CLEAR);
     Lcd_Out(1,1,"WATTMETRE");
     Lcd_Out(2,1,"PROJESI");
     delay_ms(1500);
     Lcd_Cmd(_LCD_CLEAR);

     while (1) {
     unsigned int x=0;
     float AcsValue=0.0,Samples=0.0,AvgAcs=0.0,AcsValueF=0.0,watt=0.0,oldvalue=0.0,ebdeger=0.0;
     while(RB0_bit == 1){
     if(a==0){Lcd_Cmd(_LCD_CLEAR);Lcd_Out(1,1,"DC WATTMETER");delay_ms(1500);a=1;y=0;}
     x=0;
     AcsValue=0.0,Samples=0.0,AvgAcs=0.0,AcsValueF=0.0;
     for(x = 0; x < 150; x++){
     AcsValue = ADC_Read(0);
     Samples = Samples + AcsValue;
     delay_ms (3);
     }
     AvgAcs=Samples/150;
     AcsValueF = (2.48 - (AvgAcs * (5.0 / 1023.0)) )/0.066;
     delay_ms(10);
     hesap = ADC_Read(1);
     deger = (hesap / 1023.0) * 48;
     delay_ms(10);
     watt=deger*AcsValueF;
     delay_ms(100);
     if(AcsValueF<=0.0)  {AcsValueF=0.0000;}
     if(watt<=0.0)  {watt=0.0000;}
           Lcd_Cmd(_LCD_CLEAR);
           if(AcsValueF<1.0 && AcsValueF>0.0)  {sdeger=AcsValueF*1000;}
           Lcd_Out(1,1,"V:");
           Lcd_Out(1,8,"A:");
           Lcd_Out(2,1,"W:");
           FloatToStr_FixLen(deger, voltaj,4);
           delay_ms(5);
           Lcd_Out(1,3,voltaj);
           IntToStr(sdeger, m);
           delay_ms(5);
           Lcd_Out(1,10,m);
           FloatToStr_FixLen(watt, watts,4);
           delay_ms(5);
           Lcd_Out(2,3,watts);
           delay_ms(600);
           }
           
           
     while (RB0_bit == 0){
     if(y==0){Lcd_Cmd(_LCD_CLEAR);Lcd_Out(1,1,"AC WATTMETER");delay_ms(1500);y=1;a=0;}

      Voltage = getVPP();
      VRMS = ((Voltage/2.0) *0.707);  //root 2 is 0.707
      AmpsRMS = (VRMS * 1000)/mVperAmp;

     hesap = ADC_Read(2);
     delay_ms(30);
     if(hesap>256 && hesap<1024){deger=12.0;}
     if(hesap>0 && hesap<=256){deger=6.0;}

     watt=deger*AmpsRMS;
     delay_ms(30);
     if(AmpsRMS<=0.0)  {AmpsRMS=0.0000;}
     if(watt<=0.0)  {watt=0.0000;}

           Lcd_Cmd(_LCD_CLEAR);
           Lcd_Out(1,1,"V:");
           Lcd_Out(1,8,"A:");
           Lcd_Out(2,1,"W:");
           FloatToStr_FixLen(deger, voltaj,4);
           delay_ms(5);
           Lcd_Out(1,3,voltaj);
           FloatToStr_FixLen(AmpsRMS, m,4);
           delay_ms(5);
           Lcd_Out(1,10,m);
           FloatToStr_FixLen(watt, watts,4);
           delay_ms(5);
           Lcd_Out(2,3,watts);
           delay_ms(400);
           }
           
           
           
           
           
           }



     }
