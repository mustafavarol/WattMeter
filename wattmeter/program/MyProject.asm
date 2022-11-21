
_getVPP:

;MyProject.c,25 :: 		float getVPP()
;MyProject.c,29 :: 		int maxValue = 0;          // store max value here
	CLRF       getVPP_maxValue_L0+0
	CLRF       getVPP_maxValue_L0+1
	MOVLW      0
	MOVWF      getVPP_minValue_L0+0
	MOVLW      4
	MOVWF      getVPP_minValue_L0+1
;MyProject.c,33 :: 		for(y=0;y<200;y++) //sample for 1 Sec
	CLRF       _y+0
	CLRF       _y+1
L_getVPP0:
	MOVLW      128
	XORWF      _y+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__getVPP55
	MOVLW      200
	SUBWF      _y+0, 0
L__getVPP55:
	BTFSC      STATUS+0, 0
	GOTO       L_getVPP1
;MyProject.c,35 :: 		readValue = ADC_Read(3);
	MOVLW      3
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      getVPP_readValue_L0+0
	MOVF       R0+1, 0
	MOVWF      getVPP_readValue_L0+1
;MyProject.c,37 :: 		if (readValue > maxValue)
	MOVLW      128
	XORWF      getVPP_maxValue_L0+1, 0
	MOVWF      R2+0
	MOVLW      128
	XORWF      R0+1, 0
	SUBWF      R2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__getVPP56
	MOVF       R0+0, 0
	SUBWF      getVPP_maxValue_L0+0, 0
L__getVPP56:
	BTFSC      STATUS+0, 0
	GOTO       L_getVPP3
;MyProject.c,40 :: 		maxValue = readValue;
	MOVF       getVPP_readValue_L0+0, 0
	MOVWF      getVPP_maxValue_L0+0
	MOVF       getVPP_readValue_L0+1, 0
	MOVWF      getVPP_maxValue_L0+1
;MyProject.c,41 :: 		}
L_getVPP3:
;MyProject.c,42 :: 		if (readValue < minValue)
	MOVLW      128
	XORWF      getVPP_readValue_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      getVPP_minValue_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__getVPP57
	MOVF       getVPP_minValue_L0+0, 0
	SUBWF      getVPP_readValue_L0+0, 0
L__getVPP57:
	BTFSC      STATUS+0, 0
	GOTO       L_getVPP4
;MyProject.c,45 :: 		minValue = readValue;
	MOVF       getVPP_readValue_L0+0, 0
	MOVWF      getVPP_minValue_L0+0
	MOVF       getVPP_readValue_L0+1, 0
	MOVWF      getVPP_minValue_L0+1
;MyProject.c,46 :: 		}
L_getVPP4:
;MyProject.c,33 :: 		for(y=0;y<200;y++) //sample for 1 Sec
	INCF       _y+0, 1
	BTFSC      STATUS+0, 2
	INCF       _y+1, 1
;MyProject.c,47 :: 		}
	GOTO       L_getVPP0
L_getVPP1:
;MyProject.c,50 :: 		result = ((maxValue - minValue) * 5.0)/1024.0;
	MOVF       getVPP_minValue_L0+0, 0
	SUBWF      getVPP_maxValue_L0+0, 0
	MOVWF      R0+0
	MOVF       getVPP_minValue_L0+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      getVPP_maxValue_L0+1, 0
	MOVWF      R0+1
	CALL       _int2double+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      32
	MOVWF      R4+2
	MOVLW      129
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      0
	MOVWF      R4+2
	MOVLW      137
	MOVWF      R4+3
	CALL       _Div_32x32_FP+0
;MyProject.c,52 :: 		return result;
;MyProject.c,53 :: 		}
L_end_getVPP:
	RETURN
; end of _getVPP

_main:

;MyProject.c,54 :: 		void main() {
;MyProject.c,57 :: 		TRISD = 0x00;
	CLRF       TRISD+0
;MyProject.c,58 :: 		PORTD = 0;
	CLRF       PORTD+0
;MyProject.c,59 :: 		TRISB = 0xff;
	MOVLW      255
	MOVWF      TRISB+0
;MyProject.c,60 :: 		TRISA = 0xFF;
	MOVLW      255
	MOVWF      TRISA+0
;MyProject.c,61 :: 		ADCON0 = 0x01;
	MOVLW      1
	MOVWF      ADCON0+0
;MyProject.c,62 :: 		ADCON1 = 0x01;
	MOVLW      1
	MOVWF      ADCON1+0
;MyProject.c,63 :: 		CMCON |= 0x07;
	MOVLW      7
	IORWF      CMCON+0, 1
;MyProject.c,66 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;MyProject.c,67 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,68 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,69 :: 		Lcd_Out(1,1,"KTO KARATAY");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,70 :: 		Lcd_Out(2,1,"UNIVERSITESI");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,71 :: 		delay_ms(1500);
	MOVLW      16
	MOVWF      R11+0
	MOVLW      57
	MOVWF      R12+0
	MOVLW      13
	MOVWF      R13+0
L_main5:
	DECFSZ     R13+0, 1
	GOTO       L_main5
	DECFSZ     R12+0, 1
	GOTO       L_main5
	DECFSZ     R11+0, 1
	GOTO       L_main5
	NOP
	NOP
;MyProject.c,72 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,73 :: 		Lcd_Out(1,1,"WATTMETRE");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,74 :: 		Lcd_Out(2,1,"PROJESI");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr4_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,75 :: 		delay_ms(1500);
	MOVLW      16
	MOVWF      R11+0
	MOVLW      57
	MOVWF      R12+0
	MOVLW      13
	MOVWF      R13+0
L_main6:
	DECFSZ     R13+0, 1
	GOTO       L_main6
	DECFSZ     R12+0, 1
	GOTO       L_main6
	DECFSZ     R11+0, 1
	GOTO       L_main6
	NOP
	NOP
;MyProject.c,76 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,78 :: 		while (1) {
L_main7:
;MyProject.c,79 :: 		unsigned int x=0;
	CLRF       main_x_L1+0
	CLRF       main_x_L1+1
	CLRF       main_Samples_L1+0
	CLRF       main_Samples_L1+1
	CLRF       main_Samples_L1+2
	CLRF       main_Samples_L1+3
	CLRF       main_AcsValueF_L1+0
	CLRF       main_AcsValueF_L1+1
	CLRF       main_AcsValueF_L1+2
	CLRF       main_AcsValueF_L1+3
	CLRF       main_watt_L1+0
	CLRF       main_watt_L1+1
	CLRF       main_watt_L1+2
	CLRF       main_watt_L1+3
;MyProject.c,82 :: 		while(RB0_bit == 1){
L_main9:
	BTFSS      RB0_bit+0, BitPos(RB0_bit+0)
	GOTO       L_main10
;MyProject.c,83 :: 		if(a==0){Lcd_Cmd(_LCD_CLEAR);Lcd_Out(1,1,"DC WATTMETER");delay_ms(1500);a=1;y=0;}
	MOVLW      0
	XORWF      _a+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main59
	MOVLW      0
	XORWF      _a+0, 0
L__main59:
	BTFSS      STATUS+0, 2
	GOTO       L_main11
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr5_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
	MOVLW      16
	MOVWF      R11+0
	MOVLW      57
	MOVWF      R12+0
	MOVLW      13
	MOVWF      R13+0
L_main12:
	DECFSZ     R13+0, 1
	GOTO       L_main12
	DECFSZ     R12+0, 1
	GOTO       L_main12
	DECFSZ     R11+0, 1
	GOTO       L_main12
	NOP
	NOP
	MOVLW      1
	MOVWF      _a+0
	MOVLW      0
	MOVWF      _a+1
	CLRF       _y+0
	CLRF       _y+1
L_main11:
;MyProject.c,84 :: 		x=0;
	CLRF       main_x_L1+0
	CLRF       main_x_L1+1
;MyProject.c,85 :: 		AcsValue=0.0,Samples=0.0,AvgAcs=0.0,AcsValueF=0.0;
	CLRF       main_Samples_L1+0
	CLRF       main_Samples_L1+1
	CLRF       main_Samples_L1+2
	CLRF       main_Samples_L1+3
	CLRF       main_AcsValueF_L1+0
	CLRF       main_AcsValueF_L1+1
	CLRF       main_AcsValueF_L1+2
	CLRF       main_AcsValueF_L1+3
;MyProject.c,87 :: 		for(x = 0; x < 200; x++){
	CLRF       main_x_L1+0
	CLRF       main_x_L1+1
L_main13:
	MOVLW      0
	SUBWF      main_x_L1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main60
	MOVLW      200
	SUBWF      main_x_L1+0, 0
L__main60:
	BTFSC      STATUS+0, 0
	GOTO       L_main14
;MyProject.c,88 :: 		AcsValue = ADC_Read(0);
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	CALL       _word2double+0
;MyProject.c,89 :: 		Samples = Samples + AcsValue;
	MOVF       main_Samples_L1+0, 0
	MOVWF      R4+0
	MOVF       main_Samples_L1+1, 0
	MOVWF      R4+1
	MOVF       main_Samples_L1+2, 0
	MOVWF      R4+2
	MOVF       main_Samples_L1+3, 0
	MOVWF      R4+3
	CALL       _Add_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      main_Samples_L1+0
	MOVF       R0+1, 0
	MOVWF      main_Samples_L1+1
	MOVF       R0+2, 0
	MOVWF      main_Samples_L1+2
	MOVF       R0+3, 0
	MOVWF      main_Samples_L1+3
;MyProject.c,90 :: 		delay_ms (3);
	MOVLW      8
	MOVWF      R12+0
	MOVLW      201
	MOVWF      R13+0
L_main16:
	DECFSZ     R13+0, 1
	GOTO       L_main16
	DECFSZ     R12+0, 1
	GOTO       L_main16
	NOP
	NOP
;MyProject.c,87 :: 		for(x = 0; x < 200; x++){
	INCF       main_x_L1+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_x_L1+1, 1
;MyProject.c,91 :: 		}
	GOTO       L_main13
L_main14:
;MyProject.c,92 :: 		AvgAcs=Samples/200;
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      72
	MOVWF      R4+2
	MOVLW      134
	MOVWF      R4+3
	MOVF       main_Samples_L1+0, 0
	MOVWF      R0+0
	MOVF       main_Samples_L1+1, 0
	MOVWF      R0+1
	MOVF       main_Samples_L1+2, 0
	MOVWF      R0+2
	MOVF       main_Samples_L1+3, 0
	MOVWF      R0+3
	CALL       _Div_32x32_FP+0
;MyProject.c,93 :: 		AcsValueF = (2.47 - (AvgAcs * (5.0 / 1023.0)) )/0.066;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      40
	MOVWF      R4+1
	MOVLW      32
	MOVWF      R4+2
	MOVLW      119
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      R4+0
	MOVF       R0+1, 0
	MOVWF      R4+1
	MOVF       R0+2, 0
	MOVWF      R4+2
	MOVF       R0+3, 0
	MOVWF      R4+3
	MOVLW      123
	MOVWF      R0+0
	MOVLW      20
	MOVWF      R0+1
	MOVLW      30
	MOVWF      R0+2
	MOVLW      128
	MOVWF      R0+3
	CALL       _Sub_32x32_FP+0
	MOVLW      2
	MOVWF      R4+0
	MOVLW      43
	MOVWF      R4+1
	MOVLW      7
	MOVWF      R4+2
	MOVLW      123
	MOVWF      R4+3
	CALL       _Div_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      main_AcsValueF_L1+0
	MOVF       R0+1, 0
	MOVWF      main_AcsValueF_L1+1
	MOVF       R0+2, 0
	MOVWF      main_AcsValueF_L1+2
	MOVF       R0+3, 0
	MOVWF      main_AcsValueF_L1+3
;MyProject.c,94 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_main17:
	DECFSZ     R13+0, 1
	GOTO       L_main17
	DECFSZ     R12+0, 1
	GOTO       L_main17
	NOP
;MyProject.c,95 :: 		hesap = ADC_Read(1);
	MOVLW      1
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _hesap+0
	MOVF       R0+1, 0
	MOVWF      _hesap+1
;MyProject.c,96 :: 		deger = (hesap / 1023.0) * 48;
	CALL       _int2double+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      192
	MOVWF      R4+1
	MOVLW      127
	MOVWF      R4+2
	MOVLW      136
	MOVWF      R4+3
	CALL       _Div_32x32_FP+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      64
	MOVWF      R4+2
	MOVLW      132
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      _deger+0
	MOVF       R0+1, 0
	MOVWF      _deger+1
	MOVF       R0+2, 0
	MOVWF      _deger+2
	MOVF       R0+3, 0
	MOVWF      _deger+3
;MyProject.c,97 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_main18:
	DECFSZ     R13+0, 1
	GOTO       L_main18
	DECFSZ     R12+0, 1
	GOTO       L_main18
	NOP
;MyProject.c,98 :: 		watt=deger*AcsValueF;
	MOVF       _deger+0, 0
	MOVWF      R0+0
	MOVF       _deger+1, 0
	MOVWF      R0+1
	MOVF       _deger+2, 0
	MOVWF      R0+2
	MOVF       _deger+3, 0
	MOVWF      R0+3
	MOVF       main_AcsValueF_L1+0, 0
	MOVWF      R4+0
	MOVF       main_AcsValueF_L1+1, 0
	MOVWF      R4+1
	MOVF       main_AcsValueF_L1+2, 0
	MOVWF      R4+2
	MOVF       main_AcsValueF_L1+3, 0
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      main_watt_L1+0
	MOVF       R0+1, 0
	MOVWF      main_watt_L1+1
	MOVF       R0+2, 0
	MOVWF      main_watt_L1+2
	MOVF       R0+3, 0
	MOVWF      main_watt_L1+3
;MyProject.c,99 :: 		delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main19:
	DECFSZ     R13+0, 1
	GOTO       L_main19
	DECFSZ     R12+0, 1
	GOTO       L_main19
	DECFSZ     R11+0, 1
	GOTO       L_main19
	NOP
;MyProject.c,100 :: 		if(AcsValueF<=0.0)  {AcsValueF=0.0000;}
	MOVF       main_AcsValueF_L1+0, 0
	MOVWF      R4+0
	MOVF       main_AcsValueF_L1+1, 0
	MOVWF      R4+1
	MOVF       main_AcsValueF_L1+2, 0
	MOVWF      R4+2
	MOVF       main_AcsValueF_L1+3, 0
	MOVWF      R4+3
	CLRF       R0+0
	CLRF       R0+1
	CLRF       R0+2
	CLRF       R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSS      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main20
	CLRF       main_AcsValueF_L1+0
	CLRF       main_AcsValueF_L1+1
	CLRF       main_AcsValueF_L1+2
	CLRF       main_AcsValueF_L1+3
L_main20:
;MyProject.c,101 :: 		if(watt<=0.0)  {watt=0.0000;}
	MOVF       main_watt_L1+0, 0
	MOVWF      R4+0
	MOVF       main_watt_L1+1, 0
	MOVWF      R4+1
	MOVF       main_watt_L1+2, 0
	MOVWF      R4+2
	MOVF       main_watt_L1+3, 0
	MOVWF      R4+3
	CLRF       R0+0
	CLRF       R0+1
	CLRF       R0+2
	CLRF       R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSS      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main21
	CLRF       main_watt_L1+0
	CLRF       main_watt_L1+1
	CLRF       main_watt_L1+2
	CLRF       main_watt_L1+3
L_main21:
;MyProject.c,102 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,103 :: 		if(AcsValueF<1.0 && AcsValueF>0.0)  {Lcd_Out(1,15,"m");}
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      0
	MOVWF      R4+2
	MOVLW      127
	MOVWF      R4+3
	MOVF       main_AcsValueF_L1+0, 0
	MOVWF      R0+0
	MOVF       main_AcsValueF_L1+1, 0
	MOVWF      R0+1
	MOVF       main_AcsValueF_L1+2, 0
	MOVWF      R0+2
	MOVF       main_AcsValueF_L1+3, 0
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main24
	MOVF       main_AcsValueF_L1+0, 0
	MOVWF      R4+0
	MOVF       main_AcsValueF_L1+1, 0
	MOVWF      R4+1
	MOVF       main_AcsValueF_L1+2, 0
	MOVWF      R4+2
	MOVF       main_AcsValueF_L1+3, 0
	MOVWF      R4+3
	CLRF       R0+0
	CLRF       R0+1
	CLRF       R0+2
	CLRF       R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main24
L__main53:
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      15
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr6_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
L_main24:
;MyProject.c,104 :: 		if(AcsValueF<0.1 && AcsValueF>0.0)  {Lcd_Out(1,15,"r");}
	MOVLW      205
	MOVWF      R4+0
	MOVLW      204
	MOVWF      R4+1
	MOVLW      76
	MOVWF      R4+2
	MOVLW      123
	MOVWF      R4+3
	MOVF       main_AcsValueF_L1+0, 0
	MOVWF      R0+0
	MOVF       main_AcsValueF_L1+1, 0
	MOVWF      R0+1
	MOVF       main_AcsValueF_L1+2, 0
	MOVWF      R0+2
	MOVF       main_AcsValueF_L1+3, 0
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main27
	MOVF       main_AcsValueF_L1+0, 0
	MOVWF      R4+0
	MOVF       main_AcsValueF_L1+1, 0
	MOVWF      R4+1
	MOVF       main_AcsValueF_L1+2, 0
	MOVWF      R4+2
	MOVF       main_AcsValueF_L1+3, 0
	MOVWF      R4+3
	CLRF       R0+0
	CLRF       R0+1
	CLRF       R0+2
	CLRF       R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main27
L__main52:
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      15
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr7_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
L_main27:
;MyProject.c,105 :: 		Lcd_Out(1,1,"V:");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr8_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,106 :: 		Lcd_Out(1,8,"A:");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      8
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr9_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,107 :: 		Lcd_Out(2,1,"W:");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr10_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,108 :: 		FloatToStr_FixLen(deger, voltaj,4);
	MOVF       _deger+0, 0
	MOVWF      FARG_FloatToStr_FixLen_fnum+0
	MOVF       _deger+1, 0
	MOVWF      FARG_FloatToStr_FixLen_fnum+1
	MOVF       _deger+2, 0
	MOVWF      FARG_FloatToStr_FixLen_fnum+2
	MOVF       _deger+3, 0
	MOVWF      FARG_FloatToStr_FixLen_fnum+3
	MOVLW      _voltaj+0
	MOVWF      FARG_FloatToStr_FixLen_str+0
	MOVLW      4
	MOVWF      FARG_FloatToStr_FixLen_len+0
	CALL       _FloatToStr_FixLen+0
;MyProject.c,109 :: 		delay_ms(5);
	MOVLW      13
	MOVWF      R12+0
	MOVLW      251
	MOVWF      R13+0
L_main28:
	DECFSZ     R13+0, 1
	GOTO       L_main28
	DECFSZ     R12+0, 1
	GOTO       L_main28
	NOP
	NOP
;MyProject.c,110 :: 		Lcd_Out(1,3,voltaj);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      3
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _voltaj+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,111 :: 		FloatToStr_FixLen(AcsValueF, m,4);
	MOVF       main_AcsValueF_L1+0, 0
	MOVWF      FARG_FloatToStr_FixLen_fnum+0
	MOVF       main_AcsValueF_L1+1, 0
	MOVWF      FARG_FloatToStr_FixLen_fnum+1
	MOVF       main_AcsValueF_L1+2, 0
	MOVWF      FARG_FloatToStr_FixLen_fnum+2
	MOVF       main_AcsValueF_L1+3, 0
	MOVWF      FARG_FloatToStr_FixLen_fnum+3
	MOVLW      _m+0
	MOVWF      FARG_FloatToStr_FixLen_str+0
	MOVLW      4
	MOVWF      FARG_FloatToStr_FixLen_len+0
	CALL       _FloatToStr_FixLen+0
;MyProject.c,112 :: 		delay_ms(5);
	MOVLW      13
	MOVWF      R12+0
	MOVLW      251
	MOVWF      R13+0
L_main29:
	DECFSZ     R13+0, 1
	GOTO       L_main29
	DECFSZ     R12+0, 1
	GOTO       L_main29
	NOP
	NOP
;MyProject.c,113 :: 		Lcd_Out(1,10,m);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      10
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _m+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,114 :: 		FloatToStr_FixLen(watt, watts,4);
	MOVF       main_watt_L1+0, 0
	MOVWF      FARG_FloatToStr_FixLen_fnum+0
	MOVF       main_watt_L1+1, 0
	MOVWF      FARG_FloatToStr_FixLen_fnum+1
	MOVF       main_watt_L1+2, 0
	MOVWF      FARG_FloatToStr_FixLen_fnum+2
	MOVF       main_watt_L1+3, 0
	MOVWF      FARG_FloatToStr_FixLen_fnum+3
	MOVLW      _watts+0
	MOVWF      FARG_FloatToStr_FixLen_str+0
	MOVLW      4
	MOVWF      FARG_FloatToStr_FixLen_len+0
	CALL       _FloatToStr_FixLen+0
;MyProject.c,115 :: 		delay_ms(5);
	MOVLW      13
	MOVWF      R12+0
	MOVLW      251
	MOVWF      R13+0
L_main30:
	DECFSZ     R13+0, 1
	GOTO       L_main30
	DECFSZ     R12+0, 1
	GOTO       L_main30
	NOP
	NOP
;MyProject.c,116 :: 		Lcd_Out(2,3,watts);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      3
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _watts+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,117 :: 		delay_ms(600);
	MOVLW      7
	MOVWF      R11+0
	MOVLW      23
	MOVWF      R12+0
	MOVLW      106
	MOVWF      R13+0
L_main31:
	DECFSZ     R13+0, 1
	GOTO       L_main31
	DECFSZ     R12+0, 1
	GOTO       L_main31
	DECFSZ     R11+0, 1
	GOTO       L_main31
	NOP
;MyProject.c,118 :: 		}
	GOTO       L_main9
L_main10:
;MyProject.c,121 :: 		while (RB0_bit == 0){
L_main32:
	BTFSC      RB0_bit+0, BitPos(RB0_bit+0)
	GOTO       L_main33
;MyProject.c,122 :: 		if(y==0){Lcd_Cmd(_LCD_CLEAR);Lcd_Out(1,1,"AC WATTMETER");delay_ms(1500);y=1;a=0;}
	MOVLW      0
	XORWF      _y+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main61
	MOVLW      0
	XORWF      _y+0, 0
L__main61:
	BTFSS      STATUS+0, 2
	GOTO       L_main34
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr11_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
	MOVLW      16
	MOVWF      R11+0
	MOVLW      57
	MOVWF      R12+0
	MOVLW      13
	MOVWF      R13+0
L_main35:
	DECFSZ     R13+0, 1
	GOTO       L_main35
	DECFSZ     R12+0, 1
	GOTO       L_main35
	DECFSZ     R11+0, 1
	GOTO       L_main35
	NOP
	NOP
	MOVLW      1
	MOVWF      _y+0
	MOVLW      0
	MOVWF      _y+1
	CLRF       _a+0
	CLRF       _a+1
L_main34:
;MyProject.c,124 :: 		Voltage = getVPP();
	CALL       _getVPP+0
	MOVF       R0+0, 0
	MOVWF      _Voltage+0
	MOVF       R0+1, 0
	MOVWF      _Voltage+1
	MOVF       R0+2, 0
	MOVWF      _Voltage+2
	MOVF       R0+3, 0
	MOVWF      _Voltage+3
;MyProject.c,125 :: 		VRMS = 2.50-((Voltage/2.0) *0.707);  //root 2 is 0.707
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      0
	MOVWF      R4+2
	MOVLW      128
	MOVWF      R4+3
	CALL       _Div_32x32_FP+0
	MOVLW      244
	MOVWF      R4+0
	MOVLW      253
	MOVWF      R4+1
	MOVLW      52
	MOVWF      R4+2
	MOVLW      126
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      R4+0
	MOVF       R0+1, 0
	MOVWF      R4+1
	MOVF       R0+2, 0
	MOVWF      R4+2
	MOVF       R0+3, 0
	MOVWF      R4+3
	MOVLW      0
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVLW      32
	MOVWF      R0+2
	MOVLW      128
	MOVWF      R0+3
	CALL       _Sub_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      _VRMS+0
	MOVF       R0+1, 0
	MOVWF      _VRMS+1
	MOVF       R0+2, 0
	MOVWF      _VRMS+2
	MOVF       R0+3, 0
	MOVWF      _VRMS+3
;MyProject.c,126 :: 		AmpsRMS = (VRMS * 1000)/mVperAmp;
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      122
	MOVWF      R4+2
	MOVLW      136
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      FLOC__main+0
	MOVF       R0+1, 0
	MOVWF      FLOC__main+1
	MOVF       R0+2, 0
	MOVWF      FLOC__main+2
	MOVF       R0+3, 0
	MOVWF      FLOC__main+3
	MOVF       _mVperAmp+0, 0
	MOVWF      R0+0
	MOVF       _mVperAmp+1, 0
	MOVWF      R0+1
	CALL       _int2double+0
	MOVF       R0+0, 0
	MOVWF      R4+0
	MOVF       R0+1, 0
	MOVWF      R4+1
	MOVF       R0+2, 0
	MOVWF      R4+2
	MOVF       R0+3, 0
	MOVWF      R4+3
	MOVF       FLOC__main+0, 0
	MOVWF      R0+0
	MOVF       FLOC__main+1, 0
	MOVWF      R0+1
	MOVF       FLOC__main+2, 0
	MOVWF      R0+2
	MOVF       FLOC__main+3, 0
	MOVWF      R0+3
	CALL       _Div_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      _AmpsRMS+0
	MOVF       R0+1, 0
	MOVWF      _AmpsRMS+1
	MOVF       R0+2, 0
	MOVWF      _AmpsRMS+2
	MOVF       R0+3, 0
	MOVWF      _AmpsRMS+3
;MyProject.c,128 :: 		hesap = ADC_Read(2);
	MOVLW      2
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _hesap+0
	MOVF       R0+1, 0
	MOVWF      _hesap+1
;MyProject.c,129 :: 		delay_ms(30);
	MOVLW      78
	MOVWF      R12+0
	MOVLW      235
	MOVWF      R13+0
L_main36:
	DECFSZ     R13+0, 1
	GOTO       L_main36
	DECFSZ     R12+0, 1
	GOTO       L_main36
;MyProject.c,130 :: 		if(hesap>256 && hesap<1024){deger=12.0;}
	MOVLW      128
	XORLW      1
	MOVWF      R0+0
	MOVLW      128
	XORWF      _hesap+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main62
	MOVF       _hesap+0, 0
	SUBLW      0
L__main62:
	BTFSC      STATUS+0, 0
	GOTO       L_main39
	MOVLW      128
	XORWF      _hesap+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      4
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main63
	MOVLW      0
	SUBWF      _hesap+0, 0
L__main63:
	BTFSC      STATUS+0, 0
	GOTO       L_main39
L__main51:
	MOVLW      0
	MOVWF      _deger+0
	MOVLW      0
	MOVWF      _deger+1
	MOVLW      64
	MOVWF      _deger+2
	MOVLW      130
	MOVWF      _deger+3
L_main39:
;MyProject.c,131 :: 		if(hesap>0 && hesap<=256){deger=6.0;}
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _hesap+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main64
	MOVF       _hesap+0, 0
	SUBLW      0
L__main64:
	BTFSC      STATUS+0, 0
	GOTO       L_main42
	MOVLW      128
	XORLW      1
	MOVWF      R0+0
	MOVLW      128
	XORWF      _hesap+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main65
	MOVF       _hesap+0, 0
	SUBLW      0
L__main65:
	BTFSS      STATUS+0, 0
	GOTO       L_main42
L__main50:
	MOVLW      0
	MOVWF      _deger+0
	MOVLW      0
	MOVWF      _deger+1
	MOVLW      64
	MOVWF      _deger+2
	MOVLW      129
	MOVWF      _deger+3
L_main42:
;MyProject.c,133 :: 		watt=deger*AmpsRMS;
	MOVF       _deger+0, 0
	MOVWF      R0+0
	MOVF       _deger+1, 0
	MOVWF      R0+1
	MOVF       _deger+2, 0
	MOVWF      R0+2
	MOVF       _deger+3, 0
	MOVWF      R0+3
	MOVF       _AmpsRMS+0, 0
	MOVWF      R4+0
	MOVF       _AmpsRMS+1, 0
	MOVWF      R4+1
	MOVF       _AmpsRMS+2, 0
	MOVWF      R4+2
	MOVF       _AmpsRMS+3, 0
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      main_watt_L1+0
	MOVF       R0+1, 0
	MOVWF      main_watt_L1+1
	MOVF       R0+2, 0
	MOVWF      main_watt_L1+2
	MOVF       R0+3, 0
	MOVWF      main_watt_L1+3
;MyProject.c,134 :: 		delay_ms(30);
	MOVLW      78
	MOVWF      R12+0
	MOVLW      235
	MOVWF      R13+0
L_main43:
	DECFSZ     R13+0, 1
	GOTO       L_main43
	DECFSZ     R12+0, 1
	GOTO       L_main43
;MyProject.c,135 :: 		if(AmpsRMS<=0.0)  {AmpsRMS=0.0000;}
	MOVF       _AmpsRMS+0, 0
	MOVWF      R4+0
	MOVF       _AmpsRMS+1, 0
	MOVWF      R4+1
	MOVF       _AmpsRMS+2, 0
	MOVWF      R4+2
	MOVF       _AmpsRMS+3, 0
	MOVWF      R4+3
	CLRF       R0+0
	CLRF       R0+1
	CLRF       R0+2
	CLRF       R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSS      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main44
	CLRF       _AmpsRMS+0
	CLRF       _AmpsRMS+1
	CLRF       _AmpsRMS+2
	CLRF       _AmpsRMS+3
L_main44:
;MyProject.c,136 :: 		if(watt<=0.0)  {watt=0.0000;}
	MOVF       main_watt_L1+0, 0
	MOVWF      R4+0
	MOVF       main_watt_L1+1, 0
	MOVWF      R4+1
	MOVF       main_watt_L1+2, 0
	MOVWF      R4+2
	MOVF       main_watt_L1+3, 0
	MOVWF      R4+3
	CLRF       R0+0
	CLRF       R0+1
	CLRF       R0+2
	CLRF       R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSS      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main45
	CLRF       main_watt_L1+0
	CLRF       main_watt_L1+1
	CLRF       main_watt_L1+2
	CLRF       main_watt_L1+3
L_main45:
;MyProject.c,138 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,139 :: 		Lcd_Out(1,1,"V:");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr12_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,140 :: 		Lcd_Out(1,8,"A:");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      8
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr13_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,141 :: 		Lcd_Out(2,1,"W:");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr14_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,142 :: 		FloatToStr_FixLen(deger, voltaj,4);
	MOVF       _deger+0, 0
	MOVWF      FARG_FloatToStr_FixLen_fnum+0
	MOVF       _deger+1, 0
	MOVWF      FARG_FloatToStr_FixLen_fnum+1
	MOVF       _deger+2, 0
	MOVWF      FARG_FloatToStr_FixLen_fnum+2
	MOVF       _deger+3, 0
	MOVWF      FARG_FloatToStr_FixLen_fnum+3
	MOVLW      _voltaj+0
	MOVWF      FARG_FloatToStr_FixLen_str+0
	MOVLW      4
	MOVWF      FARG_FloatToStr_FixLen_len+0
	CALL       _FloatToStr_FixLen+0
;MyProject.c,143 :: 		delay_ms(5);
	MOVLW      13
	MOVWF      R12+0
	MOVLW      251
	MOVWF      R13+0
L_main46:
	DECFSZ     R13+0, 1
	GOTO       L_main46
	DECFSZ     R12+0, 1
	GOTO       L_main46
	NOP
	NOP
;MyProject.c,144 :: 		Lcd_Out(1,3,voltaj);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      3
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _voltaj+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,145 :: 		FloatToStr_FixLen(AmpsRMS, m,4);
	MOVF       _AmpsRMS+0, 0
	MOVWF      FARG_FloatToStr_FixLen_fnum+0
	MOVF       _AmpsRMS+1, 0
	MOVWF      FARG_FloatToStr_FixLen_fnum+1
	MOVF       _AmpsRMS+2, 0
	MOVWF      FARG_FloatToStr_FixLen_fnum+2
	MOVF       _AmpsRMS+3, 0
	MOVWF      FARG_FloatToStr_FixLen_fnum+3
	MOVLW      _m+0
	MOVWF      FARG_FloatToStr_FixLen_str+0
	MOVLW      4
	MOVWF      FARG_FloatToStr_FixLen_len+0
	CALL       _FloatToStr_FixLen+0
;MyProject.c,146 :: 		delay_ms(5);
	MOVLW      13
	MOVWF      R12+0
	MOVLW      251
	MOVWF      R13+0
L_main47:
	DECFSZ     R13+0, 1
	GOTO       L_main47
	DECFSZ     R12+0, 1
	GOTO       L_main47
	NOP
	NOP
;MyProject.c,147 :: 		Lcd_Out(1,10,m);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      10
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _m+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,148 :: 		FloatToStr_FixLen(watt, watts,4);
	MOVF       main_watt_L1+0, 0
	MOVWF      FARG_FloatToStr_FixLen_fnum+0
	MOVF       main_watt_L1+1, 0
	MOVWF      FARG_FloatToStr_FixLen_fnum+1
	MOVF       main_watt_L1+2, 0
	MOVWF      FARG_FloatToStr_FixLen_fnum+2
	MOVF       main_watt_L1+3, 0
	MOVWF      FARG_FloatToStr_FixLen_fnum+3
	MOVLW      _watts+0
	MOVWF      FARG_FloatToStr_FixLen_str+0
	MOVLW      4
	MOVWF      FARG_FloatToStr_FixLen_len+0
	CALL       _FloatToStr_FixLen+0
;MyProject.c,149 :: 		delay_ms(5);
	MOVLW      13
	MOVWF      R12+0
	MOVLW      251
	MOVWF      R13+0
L_main48:
	DECFSZ     R13+0, 1
	GOTO       L_main48
	DECFSZ     R12+0, 1
	GOTO       L_main48
	NOP
	NOP
;MyProject.c,150 :: 		Lcd_Out(2,3,watts);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      3
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _watts+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,151 :: 		delay_ms(400);
	MOVLW      5
	MOVWF      R11+0
	MOVLW      15
	MOVWF      R12+0
	MOVLW      241
	MOVWF      R13+0
L_main49:
	DECFSZ     R13+0, 1
	GOTO       L_main49
	DECFSZ     R12+0, 1
	GOTO       L_main49
	DECFSZ     R11+0, 1
	GOTO       L_main49
;MyProject.c,152 :: 		}
	GOTO       L_main32
L_main33:
;MyProject.c,158 :: 		}
	GOTO       L_main7
;MyProject.c,162 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
