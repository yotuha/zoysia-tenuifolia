#include <types.h>

void kmain(){
  /* print enter kernel message */
  unsigned long *vga_ptr = (unsigned long*)0xb8000;
  *vga_ptr = 0x2f4e2f522f452f4b; /* KERN */
  while(1){
    /* loop */
  }
}
