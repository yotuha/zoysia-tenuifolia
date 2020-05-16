#ifndef STRINGS_H
#define STRINGS_H
#include <types.h>

void addr_to_ascii(void *addr, char str[]);
void int_to_ascii(int n, char str[]);
void reverse(char s[]);
int strlen(char s[]);
void backspace(char s[]);
void append(char s[], char n);
int strcmp(char s1[], char s2[]);

#endif
