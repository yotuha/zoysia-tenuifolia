#include <types.h>
#include <kernel/screen.h>

void kmain(){
  clear_screen();
  kprint("Hello World!");
  while(1){
    /* loop */
  }
}
