#include <unistd.h>
#include <string.h>

int putstr(char *s) {
	return (write(1, s, strlen(s)));
}

int main(void) {
	putstr("Hello World!\n");
}
