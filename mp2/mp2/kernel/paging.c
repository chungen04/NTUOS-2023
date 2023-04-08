#include "param.h"
#include "types.h"
#include "memlayout.h"
#include "riscv.h"
#include "spinlock.h"
#include "defs.h"
#include "proc.h"

/* NTU OS 2022 */
/* Page fault handler */
int handle_pgfault() {
  /* Find the address that caused the fault */
  printf("page fault handler\n");
  uint64 va = r_stval();
  char *mem;

  uint64 sz = PGROUNDDOWN(va);
  mem = kalloc();
  memset(mem, 0, PGSIZE);
  mappages(myproc()->pagetable, sz, sz+PGSIZE, (uint64)mem, PTE_W|PTE_X|PTE_R|PTE_U);
  return PGSIZE;
}

// // Allocate PTEs and physical memory to grow process from oldsz to
// // newsz, which need not be page aligned.  Returns new size or 0 on error.
// uint64
// uvmalloc(pagetable_t pagetable, uint64 oldsz, uint64 newsz)
// {
//   char *mem;
//   uint64 a;

//   if(newsz < oldsz)
//     return oldsz;

//   oldsz = PGROUNDUP(oldsz);
//   for(a = oldsz; a < newsz; a += PGSIZE){
//     mem = kalloc();
//     if(mem == 0){
//       uvmdealloc(pagetable, a, oldsz);
//       return 0;
//     }
//     memset(mem, 0, PGSIZE);
//     if(mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_W|PTE_X|PTE_R|PTE_U) != 0){
//       kfree(mem);
//       uvmdealloc(pagetable, a, oldsz);
//       return 0;
//     }
//   }
//   return newsz;
// }