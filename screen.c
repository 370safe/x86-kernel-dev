#include "screen.h"

void print_char(char _chararcter, int * _pPoint, int _colour)
{
	if(_chararcter == '\n')
	{
		int n = *_pPoint % 160;
		*_pPoint  = (*_pPoint -n) + 160;
		return;
	}
	char * tmp = VIDEO_ADDRESS + *_pPoint;
	*(tmp) = _chararcter;
	
	tmp = VIDEO_ADDRESS + *_pPoint + 1;
	*(tmp) = _colour;
}
void print_string(char * _string, int * _pPoint, int _colour)
{
	//char * p_video_buffer = VIDEO_ADDRESS + * _pPoint;
	char * p_next_char = _string;
	while(*p_next_char != '\0')
	{
		print_char(*p_next_char,_pPoint, _colour);
		if(*p_next_char != '\n')
		{
			*_pPoint = *_pPoint +2;
		}
		p_next_char++;
		
	}
	
}
void clear_screen(int _numRows, int * _pPoint)
{
	for(int i =0;i<_numRows;i++)
	{
		print_char(' ', _pPoint, 0xff);
		*_pPoint = *_pPoint +2;
	}
	*_pPoint = 0;
	
}
void scroll_screen(int * _pPoint)
{
	int prevAd = *_pPoint;
	memory_copy(VIDEO_ADDRESS+160,VIDEO_ADDRESS,BUFFER_SIZE);
	*_pPoint = BUFFER_SIZE;
	for(int i = 0; i<160;i++)
	{
		print_char(' ', _pPoint, WHITE_ON_BLACK);
		*_pPoint = *_pPoint + 2;
	}
	
}
