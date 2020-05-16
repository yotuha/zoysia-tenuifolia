#include <types.h>
#include <util/string.h>
#include <kernel/screen.h>

void kmain(){
  char buf[256];
  int a = 1;
  int b = 2;
  clear_screen();

  addr_to_ascii(&a, buf);
  kprint(buf);
  kprint("\n");

  addr_to_ascii(&b, buf);
  kprint(buf);
  kprint("\n");

  addr_to_ascii((void*)0xabcdef0123456789, buf);
  kprint(buf);
  kprint("\n");

  if (&a == &b) kprint("Equal Address\n");

  while(1){
    /* loop */
  }
}
