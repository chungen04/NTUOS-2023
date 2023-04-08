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
  uint64 va = r_stval();
  pte_t* pte = walk(myproc()->pagetable, va, 0);
  if(*pte & PTE_S){
    uint blockno = PTE2BLOCKNO(*pte);
    uint64 flags = PTE_FLAGS(*pte);
    *pte = PA2PTE((uint64)kalloc()) | flags;
    memset((void*)PTE2PA(*pte), 0, PGSIZE);
    begin_op();
    read_page_from_disk(ROOTDEV, (char*)PTE2PA(*pte), blockno);
    bfree_page(ROOTDEV, blockno);
    end_op();
    *pte |= PTE_V;
    *pte &= ~PTE_S;
  }else{
    char *mem;

    uint64 sz = PGROUNDDOWN(va);
    mem = kalloc();
    memset(mem, 0, PGSIZE);
    mappages(myproc()->pagetable, sz, PGSIZE, (uint64)mem, PTE_W|PTE_X|PTE_R|PTE_U);
    // not sz+PGSIZE...
  }
  return PGSIZE;
}
