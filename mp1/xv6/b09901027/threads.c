#include "kernel/types.h"
#include "user/setjmp.h"
#include "user/threads.h"
#include "user/user.h"
#define NULL 0


static struct thread* current_thread = NULL;
static int id = 1;
static jmp_buf env_st;

struct thread *thread_create(void (*f)(void *), void *arg){
    struct thread *t = (struct thread*) malloc(sizeof(struct thread));
    unsigned long new_stack_p;
    unsigned long new_stack;
    new_stack = (unsigned long) malloc(sizeof(unsigned long)*0x100);
    new_stack_p = new_stack +0x100*8-0x2*8;
    t->fp = f;
    t->arg = arg;
    t->ID  = id;
    t->buf_set = 0;
    t->stack = (void*) new_stack;
    t->stack_p = (void*) new_stack_p;
    id++;

    // part 2
    t->sig_handler[0] = NULL_FUNC;
    t->sig_handler[1] = NULL_FUNC;
    t->signo = -1;
    t->handler_buf_set = 0;
    return t;
}

void thread_add_runqueue(struct thread *t){
    if(current_thread == NULL){
        // TODO
        current_thread = t;
        t->previous = t;
        t->next = t;
    }
    else{
        // TODO
        t->sig_handler[0] = current_thread->sig_handler[0];
        t->sig_handler[1] = current_thread->sig_handler[1];
        current_thread->previous->next = t;
        t->previous = current_thread->previous;
        current_thread->previous = t;
        t->next = current_thread;
    }
    return;
}

void thread_yield(void){
    if(current_thread->signo >= 0){
        if(setjmp(current_thread->handler_env) == 0){
            schedule();
            dispatch();
        }
    }else{
        if(setjmp(current_thread->env) == 0){
            schedule();
            dispatch();
        } // long jump back here
    }
    
    return;

}

void dispatch(void){
    // TODO
    if(current_thread->signo>=0){
        // a signal handler is currently being handled
        if(current_thread->handler_buf_set){
            longjmp(current_thread->handler_env, 1);
        }else{
            if(current_thread->sig_handler[current_thread->signo] == NULL_FUNC){
                thread_exit();
            }
            current_thread->stack_handler = malloc(sizeof(unsigned long)*0x100);
            current_thread->stack_handler_p = current_thread->stack_handler +0x100*8-0x2*8;
            if(setjmp(current_thread->handler_env) == 0){
                current_thread->handler_env->sp = (unsigned long)current_thread->stack_handler_p;
                longjmp(current_thread->handler_env, 1);
            }
            current_thread->handler_buf_set = 1;
            current_thread->sig_handler[current_thread->signo](current_thread->signo);
            current_thread->signo = -1; // reset after done
        }
    }
    if(current_thread->buf_set){
        longjmp(current_thread->env, 1);
    }else{
        if(setjmp(current_thread->env) == 0){
            current_thread->env->sp = (unsigned long)current_thread->stack_p;
            current_thread->buf_set = 1;
            longjmp(current_thread->env, 1);
        }
        current_thread->buf_set = 1;
        current_thread->fp(current_thread->arg);
    
    }
    thread_exit();
    return;

}

void schedule(void){

    // TODO
    current_thread = current_thread->next;
    return;

}

void thread_exit(void){

    if(current_thread->next != current_thread){
        // TODO
        
        current_thread->previous->next = current_thread->next;
        current_thread->next->previous = current_thread->previous;
        free(current_thread->stack);
        if(current_thread->handler_buf_set){
            free(current_thread->stack_handler);
        }
        struct thread* t = current_thread;
        current_thread = current_thread->next;
        free(t);
        dispatch();
    
    }
    else{
        // TODO
        // Hint: No more thread to execute
        if(current_thread->handler_buf_set){
            free(current_thread->stack_handler);
        }    
        free(current_thread->stack);
        free(current_thread);
        longjmp(env_st, 1);
    
    }
    return;
}

void thread_start_threading(void){
    // TODO
    
    if(setjmp(env_st) == 0){
        dispatch();
    }
    return;

}

// part 2
void thread_register_handler(int signo, void (*handler)(int)){
    // TODO
    current_thread->sig_handler[signo] = handler;
    return;
}

void thread_kill(struct thread *t, int signo){
    // TODO
    t->signo = signo;
    return;
}