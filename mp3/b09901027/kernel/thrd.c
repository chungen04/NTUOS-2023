#include "types.h"
#include "riscv.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "spinlock.h"
#include "proc.h"

// for mp3
uint64
sys_thrdstop(void)
{
  int delay;
  uint64 context_id_ptr;
  uint64 handler, handler_arg;
  if (argint(0, &delay) < 0)
    return -1;
  if (argaddr(1, &context_id_ptr) < 0)
    return -1;
  if (argaddr(2, &handler) < 0)
    return -1;
  if (argaddr(3, &handler_arg) < 0)
    return -1;
  
  struct proc *proc = myproc();
  //TODO: mp3

  // handle context id
  int thrd_context_id = 0;
  copyin(proc->pagetable, (char*)&thrd_context_id, context_id_ptr, sizeof(int));
  // now thrd_context_id is the value from user space

  if(thrd_context_id == -1){
    for(int i=0; i<MAX_THRD_NUM; i++){
      if(!(proc->thrd_context_used[i])){
        // use this as context id
        proc->thrd_context_used[i] = 1;
        proc->thrd_context_id = i;

        // use copyout to modify context_id_ptr
        copyout(proc->pagetable, context_id_ptr, (char*)&i, sizeof(int));

        // write in the argument
        proc->delay = delay;
        proc->timer_elapsed = 0;
        proc->handler = (void*)handler;
        proc->handler_arg = (void*)handler_arg;
        return 0;
      }
    }
    return -1; // all has been assigned
  }else{
    // context id is available
    if(!(proc->thrd_context_used[thrd_context_id])){
      return -1;
    }
    proc->thrd_context_id = thrd_context_id;
    proc->delay = delay;
    proc->timer_elapsed = 0;
    proc->handler = (void*)handler;
    proc->handler_arg = (void*)handler_arg;
    return 0;
  }
}

// for mp3
uint64
sys_cancelthrdstop(void)
{
  int context_id, is_exit;
  if (argint(0, &context_id) < 0)
    return -1;
  if (argint(1, &is_exit) < 0)
    return -1;

  if (context_id < 0 || context_id >= MAX_THRD_NUM) {
    return -1;
  }

  struct proc *proc = myproc();

  //TODO: mp3

  //cancels the registered handler
  uint64 time_left;
  time_left = (uint64)proc->timer_elapsed;

  proc->delay = -1;
  proc->timer_elapsed = 0;
  proc->handler = 0;
  proc->handler_arg = 0;

  if(is_exit == 0){
    // store trapframe into context according to context id
      proc->thrd_context[context_id].s0 = proc->trapframe->s0;
      proc->thrd_context[context_id].s1 = proc->trapframe->s1;
      proc->thrd_context[context_id].s2 = proc->trapframe->s2;
      proc->thrd_context[context_id].s3 = proc->trapframe->s3;
      proc->thrd_context[context_id].s4 = proc->trapframe->s4;
      proc->thrd_context[context_id].s5 = proc->trapframe->s5;
      proc->thrd_context[context_id].s6 = proc->trapframe->s6;
      proc->thrd_context[context_id].s7 = proc->trapframe->s7;
      proc->thrd_context[context_id].s8 = proc->trapframe->s8;
      proc->thrd_context[context_id].s9 = proc->trapframe->s9;
      proc->thrd_context[context_id].s10 = proc->trapframe->s10;
      proc->thrd_context[context_id].s11 = proc->trapframe->s11;
      proc->thrd_context[context_id].ra = proc->trapframe->ra;
      proc->thrd_context[context_id].sp = proc->trapframe->sp;
      proc->thrd_context[context_id].t0 = proc->trapframe->t0;
      proc->thrd_context[context_id].t1 = proc->trapframe->t1;
      proc->thrd_context[context_id].t2 = proc->trapframe->t2;
      proc->thrd_context[context_id].t3 = proc->trapframe->t3;
      proc->thrd_context[context_id].t4 = proc->trapframe->t4;
      proc->thrd_context[context_id].t5 = proc->trapframe->t5;
      proc->thrd_context[context_id].t6 = proc->trapframe->t6;
      proc->thrd_context[context_id].a0 = proc->trapframe->a0;
      proc->thrd_context[context_id].a1 = proc->trapframe->a1;
      proc->thrd_context[context_id].a2 = proc->trapframe->a2;
      proc->thrd_context[context_id].a3 = proc->trapframe->a3;
      proc->thrd_context[context_id].a4 = proc->trapframe->a4;
      proc->thrd_context[context_id].a5 = proc->trapframe->a5;
      proc->thrd_context[context_id].a6 = proc->trapframe->a6;
      proc->thrd_context[context_id].a7 = proc->trapframe->a7;
      proc->thrd_context[context_id].gp = proc->trapframe->gp;
      proc->thrd_context[context_id].tp = proc->trapframe->tp;
      proc->thrd_context[context_id].epc = proc->trapframe->epc;
  }else{
    proc->thrd_context_used[context_id] = 0; // recycled
    proc->thrd_context[context_id].s0 = 0;
      proc->thrd_context[context_id].s1 = 0;
      proc->thrd_context[context_id].s2 = 0;
      proc->thrd_context[context_id].s3 = 0;
      proc->thrd_context[context_id].s4 = 0;
      proc->thrd_context[context_id].s5 = 0;
      proc->thrd_context[context_id].s6 = 0;
      proc->thrd_context[context_id].s7 = 0;
      proc->thrd_context[context_id].s8 = 0;
      proc->thrd_context[context_id].s9 = 0;
      proc->thrd_context[context_id].s10 = 0;
      proc->thrd_context[context_id].s11 = 0;
      proc->thrd_context[context_id].ra = 0;
      proc->thrd_context[context_id].sp = 0;
      proc->thrd_context[context_id].t0 = 0;
      proc->thrd_context[context_id].t1 = 0;
      proc->thrd_context[context_id].t2 = 0;
      proc->thrd_context[context_id].t3 = 0;
      proc->thrd_context[context_id].t4 = 0;
      proc->thrd_context[context_id].t5 = 0;
      proc->thrd_context[context_id].t6 = 0;
      proc->thrd_context[context_id].a0 = 0;
      proc->thrd_context[context_id].a1 = 0;
      proc->thrd_context[context_id].a2 = 0;
      proc->thrd_context[context_id].a3 = 0;
      proc->thrd_context[context_id].a4 = 0;
      proc->thrd_context[context_id].a5 = 0;
      proc->thrd_context[context_id].a6 = 0;
      proc->thrd_context[context_id].a7 = 0;
      proc->thrd_context[context_id].gp = 0;
      proc->thrd_context[context_id].tp = 0;
      proc->thrd_context[context_id].epc = 0;
  }

  return time_left;
}

// for mp3
uint64
sys_thrdresume(void)
{
  // handler uses thrdresume to query kernel restore the regs
  int context_id;
  if (argint(0, &context_id) < 0)
    return -1;

  struct proc *proc = myproc();


  //TODO: mp3
  if(context_id < 0 || context_id >= MAX_THRD_NUM) return -1;
  if(!(proc->thrd_context_used[context_id])) return -1;

  proc->trapframe->epc = proc->thrd_context[context_id].epc;
  proc->trapframe->s0 = proc->thrd_context[context_id].s0;
  proc->trapframe->s1 = proc->thrd_context[context_id].s1;
  proc->trapframe->s2 = proc->thrd_context[context_id].s2;
  proc->trapframe->s3 = proc->thrd_context[context_id].s3;
  proc->trapframe->s4 = proc->thrd_context[context_id].s4;
  proc->trapframe->s5 = proc->thrd_context[context_id].s5;
  proc->trapframe->s6 = proc->thrd_context[context_id].s6;
  proc->trapframe->s7 = proc->thrd_context[context_id].s7;
  proc->trapframe->s8 = proc->thrd_context[context_id].s8;
  proc->trapframe->s9 = proc->thrd_context[context_id].s9;
  proc->trapframe->s10 = proc->thrd_context[context_id].s10;
  proc->trapframe->s11 = proc->thrd_context[context_id].s11;
  proc->trapframe->ra = proc->thrd_context[context_id].ra;
  proc->trapframe->sp = proc->thrd_context[context_id].sp;
  proc->trapframe->t0 = proc->thrd_context[context_id].t0;
  proc->trapframe->t1 = proc->thrd_context[context_id].t1;
  proc->trapframe->t2 = proc->thrd_context[context_id].t2;
  proc->trapframe->t3 = proc->thrd_context[context_id].t3;
  proc->trapframe->t4 = proc->thrd_context[context_id].t4;
  proc->trapframe->t5 = proc->thrd_context[context_id].t5;
  proc->trapframe->t6 = proc->thrd_context[context_id].t6;
  proc->trapframe->a0 = proc->thrd_context[context_id].a0;
  proc->trapframe->a1 = proc->thrd_context[context_id].a1;
  proc->trapframe->a2 = proc->thrd_context[context_id].a2;
  proc->trapframe->a3 = proc->thrd_context[context_id].a3;
  proc->trapframe->a4 = proc->thrd_context[context_id].a4;
  proc->trapframe->a5 = proc->thrd_context[context_id].a5;
  proc->trapframe->a6 = proc->thrd_context[context_id].a6;
  proc->trapframe->a7 = proc->thrd_context[context_id].a7;
  proc->trapframe->gp = proc->thrd_context[context_id].gp;
  proc->trapframe->tp = proc->thrd_context[context_id].tp;

  return 0;
}
