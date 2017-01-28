#include "utils.h"
#define VIDEO_ADDRESS 0xb8000
#define MAX_ROWS 25
#define MAX_COLS 80
#define BUFFER_SIZE 5*160
#define WHITE_ON_BLACK 0x0f
#define REG_SCREEN_CTRL 0x3D4
#define REG_SCREEN_DATA 0x3D5

struct PointerPos
{
	int x;
	int y;
	
};

void print_char(char _chararcter, int * _pPoint, int _colour);
void print_string(char * _string, int * _pPoint, int _colour);
void clear_screen(int _numRows, int * _pPoint);
void scroll_screen(int * _pPoint);