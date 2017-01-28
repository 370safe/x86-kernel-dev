#include "low_level.h"
#include "screen.h"
#include "keyboard.h"
void main();

void entry()
{
	kmain();
}

void kmain()
{
	int pPoint = 0;
	//port_byte_out (0x03d4, 0x0f);
	//port_byte_out (0x03d5, 0);
	
	//port_byte_out (0x03d5, 0x0e);
	//port_byte_out (0x03d4, 0);
	
	clear_screen(15*160, &pPoint);
	print_string("A\n\0", &pPoint, WHITE_ON_BLACK);
	print_string("B\n\0", &pPoint, WHITE_ON_BLACK);
	print_string("C\n\0", &pPoint, WHITE_ON_BLACK);
	print_string("D\n\0", &pPoint, WHITE_ON_BLACK);
	print_string("E\n\0", &pPoint, WHITE_ON_BLACK);
	print_string("F\n\0", &pPoint, WHITE_ON_BLACK);
	print_string("G\n\0", &pPoint, WHITE_ON_BLACK);
	print_string("H\n\0", &pPoint, WHITE_ON_BLACK);
	int state = 0;
	while(1)
	{
		unsigned char sCode = get_scancode();
		unsigned char cChar = get_char(sCode);
		//if(someC == 'a')
		//{
			
		//}
		if(sCode == 0x1C)
		{
			break;
		}
		else if(sCode > 0x80 && state == 1)
		{
			state = 0;
		}
		else if(sCode < 0x80 && state == 0)
		{
			print_char(cChar,&pPoint,WHITE_ON_BLACK);
			pPoint += 2;
			state = 1;
		}
	}
	
	
	// for(int i =0;i<80*2;i=i+2)
	// {
		// *(letters+i) = ' ';
	// }
	while(1)
	{
		
	}
	
}