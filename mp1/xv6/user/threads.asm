
user/_threads:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <thread_create>:
static struct thread* current_thread = NULL;
static int id = 1;
static jmp_buf env_st;
// static jmp_buf env_tmp;

struct thread *thread_create(void (*f)(void *), void *arg){
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	1800                	addi	s0,sp,48
   e:	89aa                	mv	s3,a0
  10:	892e                	mv	s2,a1
    struct thread *t = (struct thread*) malloc(sizeof(struct thread));
  12:	13800513          	li	a0,312
  16:	00001097          	auipc	ra,0x1
  1a:	9a2080e7          	jalr	-1630(ra) # 9b8 <malloc>
  1e:	84aa                	mv	s1,a0
    unsigned long new_stack_p;
    unsigned long new_stack;
    new_stack = (unsigned long) malloc(sizeof(unsigned long)*0x100);
  20:	6505                	lui	a0,0x1
  22:	80050513          	addi	a0,a0,-2048 # 800 <vprintf+0x112>
  26:	00001097          	auipc	ra,0x1
  2a:	992080e7          	jalr	-1646(ra) # 9b8 <malloc>
    new_stack_p = new_stack +0x100*8-0x2*8;
    t->fp = f;
  2e:	0134b023          	sd	s3,0(s1)
    t->arg = arg;
  32:	0124b423          	sd	s2,8(s1)
    t->ID  = id;
  36:	00001717          	auipc	a4,0x1
  3a:	afe70713          	addi	a4,a4,-1282 # b34 <id>
  3e:	431c                	lw	a5,0(a4)
  40:	08f4aa23          	sw	a5,148(s1)
    t->buf_set = 0;
  44:	0804a823          	sw	zero,144(s1)
    t->stack = (void*) new_stack;
  48:	e888                	sd	a0,16(s1)
    new_stack_p = new_stack +0x100*8-0x2*8;
  4a:	7f050513          	addi	a0,a0,2032
    t->stack_p = (void*) new_stack_p;
  4e:	ec88                	sd	a0,24(s1)
    id++;
  50:	2785                	addiw	a5,a5,1
  52:	c31c                	sw	a5,0(a4)

    // part 2
    t->sig_handler[0] = NULL_FUNC;
  54:	57fd                	li	a5,-1
  56:	f4dc                	sd	a5,168(s1)
    t->sig_handler[1] = NULL_FUNC;
  58:	f8dc                	sd	a5,176(s1)
    t->signo = -1;
  5a:	0af4ac23          	sw	a5,184(s1)
    t->handler_buf_set = 0;
  5e:	1204a823          	sw	zero,304(s1)
    return t;
}
  62:	8526                	mv	a0,s1
  64:	70a2                	ld	ra,40(sp)
  66:	7402                	ld	s0,32(sp)
  68:	64e2                	ld	s1,24(sp)
  6a:	6942                	ld	s2,16(sp)
  6c:	69a2                	ld	s3,8(sp)
  6e:	6145                	addi	sp,sp,48
  70:	8082                	ret

0000000000000072 <thread_add_runqueue>:

void thread_add_runqueue(struct thread *t){
  72:	1141                	addi	sp,sp,-16
  74:	e422                	sd	s0,8(sp)
  76:	0800                	addi	s0,sp,16
    if(current_thread == NULL){
  78:	00001797          	auipc	a5,0x1
  7c:	ac07b783          	ld	a5,-1344(a5) # b38 <current_thread>
  80:	cf91                	beqz	a5,9c <thread_add_runqueue+0x2a>
        t->previous = t;
        t->next = t;
    }
    else{
        // TODO
        t->sig_handler[0] = current_thread->sig_handler[0];
  82:	77d8                	ld	a4,168(a5)
  84:	f558                	sd	a4,168(a0)
        t->sig_handler[1] = current_thread->sig_handler[1];
  86:	7bd8                	ld	a4,176(a5)
  88:	f958                	sd	a4,176(a0)
        current_thread->previous->next = t;
  8a:	6fd8                	ld	a4,152(a5)
  8c:	f348                	sd	a0,160(a4)
        t->previous = current_thread->previous;
  8e:	6fd8                	ld	a4,152(a5)
  90:	ed58                	sd	a4,152(a0)
        current_thread->previous = t;
  92:	efc8                	sd	a0,152(a5)
        t->next = current_thread;
  94:	f15c                	sd	a5,160(a0)
    }
    return;
}
  96:	6422                	ld	s0,8(sp)
  98:	0141                	addi	sp,sp,16
  9a:	8082                	ret
        current_thread = t;
  9c:	00001797          	auipc	a5,0x1
  a0:	a8a7be23          	sd	a0,-1380(a5) # b38 <current_thread>
        t->previous = t;
  a4:	ed48                	sd	a0,152(a0)
        t->next = t;
  a6:	f148                	sd	a0,160(a0)
  a8:	b7fd                	j	96 <thread_add_runqueue+0x24>

00000000000000aa <schedule>:
    }
    return;

}

void schedule(void){
  aa:	1141                	addi	sp,sp,-16
  ac:	e422                	sd	s0,8(sp)
  ae:	0800                	addi	s0,sp,16

    // TODO
    current_thread = current_thread->next;
  b0:	00001797          	auipc	a5,0x1
  b4:	a8878793          	addi	a5,a5,-1400 # b38 <current_thread>
  b8:	6398                	ld	a4,0(a5)
  ba:	7358                	ld	a4,160(a4)
  bc:	e398                	sd	a4,0(a5)
    return;

}
  be:	6422                	ld	s0,8(sp)
  c0:	0141                	addi	sp,sp,16
  c2:	8082                	ret

00000000000000c4 <thread_exit>:

void thread_exit(void){
  c4:	1141                	addi	sp,sp,-16
  c6:	e406                	sd	ra,8(sp)
  c8:	e022                	sd	s0,0(sp)
  ca:	0800                	addi	s0,sp,16

    if(current_thread->next != current_thread){
  cc:	00001797          	auipc	a5,0x1
  d0:	a6c7b783          	ld	a5,-1428(a5) # b38 <current_thread>
  d4:	73d8                	ld	a4,160(a5)
  d6:	02e78e63          	beq	a5,a4,112 <thread_exit+0x4e>
        // TODO
        
        current_thread->previous->next = current_thread->next;
  da:	6fd4                	ld	a3,152(a5)
  dc:	f2d8                	sd	a4,160(a3)
        current_thread->next->previous = current_thread->previous;
  de:	6fd4                	ld	a3,152(a5)
  e0:	ef54                	sd	a3,152(a4)
        free(current_thread->stack);
  e2:	6b88                	ld	a0,16(a5)
  e4:	00001097          	auipc	ra,0x1
  e8:	84c080e7          	jalr	-1972(ra) # 930 <free>
        struct thread* t = current_thread;
  ec:	00001797          	auipc	a5,0x1
  f0:	a4c78793          	addi	a5,a5,-1460 # b38 <current_thread>
  f4:	6388                	ld	a0,0(a5)
        current_thread = current_thread->next;
  f6:	7158                	ld	a4,160(a0)
  f8:	e398                	sd	a4,0(a5)
        free(t);
  fa:	00001097          	auipc	ra,0x1
  fe:	836080e7          	jalr	-1994(ra) # 930 <free>
        dispatch();
 102:	00000097          	auipc	ra,0x0
 106:	03e080e7          	jalr	62(ra) # 140 <dispatch>
        free(current_thread);
        longjmp(env_st, 1);
    
    }
    return;
}
 10a:	60a2                	ld	ra,8(sp)
 10c:	6402                	ld	s0,0(sp)
 10e:	0141                	addi	sp,sp,16
 110:	8082                	ret
        free(current_thread->stack);
 112:	6b88                	ld	a0,16(a5)
 114:	00001097          	auipc	ra,0x1
 118:	81c080e7          	jalr	-2020(ra) # 930 <free>
        free(current_thread);
 11c:	00001517          	auipc	a0,0x1
 120:	a1c53503          	ld	a0,-1508(a0) # b38 <current_thread>
 124:	00001097          	auipc	ra,0x1
 128:	80c080e7          	jalr	-2036(ra) # 930 <free>
        longjmp(env_st, 1);
 12c:	4585                	li	a1,1
 12e:	00001517          	auipc	a0,0x1
 132:	a1a50513          	addi	a0,a0,-1510 # b48 <env_st>
 136:	00001097          	auipc	ra,0x1
 13a:	99e080e7          	jalr	-1634(ra) # ad4 <longjmp>
    return;
 13e:	b7f1                	j	10a <thread_exit+0x46>

0000000000000140 <dispatch>:
void dispatch(void){
 140:	1101                	addi	sp,sp,-32
 142:	ec06                	sd	ra,24(sp)
 144:	e822                	sd	s0,16(sp)
 146:	e426                	sd	s1,8(sp)
 148:	1000                	addi	s0,sp,32
    if(current_thread->signo>=0){
 14a:	00001517          	auipc	a0,0x1
 14e:	9ee53503          	ld	a0,-1554(a0) # b38 <current_thread>
 152:	0b852783          	lw	a5,184(a0)
 156:	0407ce63          	bltz	a5,1b2 <dispatch+0x72>
        if(current_thread->handler_buf_set){
 15a:	13052703          	lw	a4,304(a0)
 15e:	eb51                	bnez	a4,1f2 <dispatch+0xb2>
            if(current_thread->sig_handler[current_thread->signo] == NULL_FUNC){
 160:	07d1                	addi	a5,a5,20
 162:	078e                	slli	a5,a5,0x3
 164:	97aa                	add	a5,a5,a0
 166:	6798                	ld	a4,8(a5)
 168:	57fd                	li	a5,-1
 16a:	08f70c63          	beq	a4,a5,202 <dispatch+0xc2>
            if(current_thread->buf_set == 0){ // not started yet, need to move stack pointer
 16e:	00001517          	auipc	a0,0x1
 172:	9ca53503          	ld	a0,-1590(a0) # b38 <current_thread>
 176:	09052783          	lw	a5,144(a0)
 17a:	eb81                	bnez	a5,18a <dispatch+0x4a>
                if(setjmp(current_thread->handler_env) == 0){
 17c:	0c050513          	addi	a0,a0,192
 180:	00001097          	auipc	ra,0x1
 184:	91c080e7          	jalr	-1764(ra) # a9c <setjmp>
 188:	c151                	beqz	a0,20c <dispatch+0xcc>
            current_thread->handler_buf_set = 1;
 18a:	00001497          	auipc	s1,0x1
 18e:	9ae48493          	addi	s1,s1,-1618 # b38 <current_thread>
 192:	609c                	ld	a5,0(s1)
 194:	4705                	li	a4,1
 196:	12e7a823          	sw	a4,304(a5)
            current_thread->sig_handler[current_thread->signo](current_thread->signo);
 19a:	0b87a503          	lw	a0,184(a5)
 19e:	01450713          	addi	a4,a0,20
 1a2:	070e                	slli	a4,a4,0x3
 1a4:	97ba                	add	a5,a5,a4
 1a6:	679c                	ld	a5,8(a5)
 1a8:	9782                	jalr	a5
            current_thread->signo = -1; // reset after done
 1aa:	609c                	ld	a5,0(s1)
 1ac:	577d                	li	a4,-1
 1ae:	0ae7ac23          	sw	a4,184(a5)
    if(current_thread->buf_set){
 1b2:	00001517          	auipc	a0,0x1
 1b6:	98653503          	ld	a0,-1658(a0) # b38 <current_thread>
 1ba:	09052783          	lw	a5,144(a0)
 1be:	e7b5                	bnez	a5,22a <dispatch+0xea>
        if(!current_thread->handler_buf_set){
 1c0:	13052783          	lw	a5,304(a0)
 1c4:	eb81                	bnez	a5,1d4 <dispatch+0x94>
            if(setjmp(current_thread->env) == 0){
 1c6:	02050513          	addi	a0,a0,32
 1ca:	00001097          	auipc	ra,0x1
 1ce:	8d2080e7          	jalr	-1838(ra) # a9c <setjmp>
 1d2:	c525                	beqz	a0,23a <dispatch+0xfa>
        current_thread->buf_set = 1;
 1d4:	00001797          	auipc	a5,0x1
 1d8:	9647b783          	ld	a5,-1692(a5) # b38 <current_thread>
 1dc:	4705                	li	a4,1
 1de:	08e7a823          	sw	a4,144(a5)
        current_thread->fp(current_thread->arg);
 1e2:	6398                	ld	a4,0(a5)
 1e4:	6788                	ld	a0,8(a5)
 1e6:	9702                	jalr	a4
}
 1e8:	60e2                	ld	ra,24(sp)
 1ea:	6442                	ld	s0,16(sp)
 1ec:	64a2                	ld	s1,8(sp)
 1ee:	6105                	addi	sp,sp,32
 1f0:	8082                	ret
            longjmp(current_thread->handler_env, 1);
 1f2:	4585                	li	a1,1
 1f4:	0c050513          	addi	a0,a0,192
 1f8:	00001097          	auipc	ra,0x1
 1fc:	8dc080e7          	jalr	-1828(ra) # ad4 <longjmp>
 200:	bf4d                	j	1b2 <dispatch+0x72>
                thread_exit();
 202:	00000097          	auipc	ra,0x0
 206:	ec2080e7          	jalr	-318(ra) # c4 <thread_exit>
 20a:	b795                	j	16e <dispatch+0x2e>
                    current_thread->handler_env->sp = (unsigned long)current_thread->stack_p;
 20c:	00001517          	auipc	a0,0x1
 210:	92c53503          	ld	a0,-1748(a0) # b38 <current_thread>
 214:	6d1c                	ld	a5,24(a0)
 216:	12f53423          	sd	a5,296(a0)
                    longjmp(current_thread->handler_env, 1);
 21a:	4585                	li	a1,1
 21c:	0c050513          	addi	a0,a0,192
 220:	00001097          	auipc	ra,0x1
 224:	8b4080e7          	jalr	-1868(ra) # ad4 <longjmp>
 228:	b78d                	j	18a <dispatch+0x4a>
        longjmp(current_thread->env, 1);
 22a:	4585                	li	a1,1
 22c:	02050513          	addi	a0,a0,32
 230:	00001097          	auipc	ra,0x1
 234:	8a4080e7          	jalr	-1884(ra) # ad4 <longjmp>
 238:	bf45                	j	1e8 <dispatch+0xa8>
                current_thread->env->sp = (unsigned long)current_thread->stack_p;
 23a:	00001517          	auipc	a0,0x1
 23e:	8fe53503          	ld	a0,-1794(a0) # b38 <current_thread>
 242:	6d1c                	ld	a5,24(a0)
 244:	e55c                	sd	a5,136(a0)
                current_thread->buf_set = 1;
 246:	4785                	li	a5,1
 248:	08f52823          	sw	a5,144(a0)
                longjmp(current_thread->env, 1);
 24c:	4585                	li	a1,1
 24e:	02050513          	addi	a0,a0,32
 252:	00001097          	auipc	ra,0x1
 256:	882080e7          	jalr	-1918(ra) # ad4 <longjmp>
 25a:	bfad                	j	1d4 <dispatch+0x94>

000000000000025c <thread_yield>:
void thread_yield(void){
 25c:	1141                	addi	sp,sp,-16
 25e:	e406                	sd	ra,8(sp)
 260:	e022                	sd	s0,0(sp)
 262:	0800                	addi	s0,sp,16
    if(current_thread->signo >= 0){
 264:	00001517          	auipc	a0,0x1
 268:	8d453503          	ld	a0,-1836(a0) # b38 <current_thread>
 26c:	0b852783          	lw	a5,184(a0)
 270:	0207c663          	bltz	a5,29c <thread_yield+0x40>
        if(setjmp(current_thread->handler_env) == 0){
 274:	0c050513          	addi	a0,a0,192
 278:	00001097          	auipc	ra,0x1
 27c:	824080e7          	jalr	-2012(ra) # a9c <setjmp>
 280:	c509                	beqz	a0,28a <thread_yield+0x2e>
}
 282:	60a2                	ld	ra,8(sp)
 284:	6402                	ld	s0,0(sp)
 286:	0141                	addi	sp,sp,16
 288:	8082                	ret
            schedule();
 28a:	00000097          	auipc	ra,0x0
 28e:	e20080e7          	jalr	-480(ra) # aa <schedule>
            dispatch();
 292:	00000097          	auipc	ra,0x0
 296:	eae080e7          	jalr	-338(ra) # 140 <dispatch>
 29a:	b7e5                	j	282 <thread_yield+0x26>
        if(setjmp(current_thread->env) == 0){
 29c:	02050513          	addi	a0,a0,32
 2a0:	00000097          	auipc	ra,0x0
 2a4:	7fc080e7          	jalr	2044(ra) # a9c <setjmp>
 2a8:	fd69                	bnez	a0,282 <thread_yield+0x26>
            schedule();
 2aa:	00000097          	auipc	ra,0x0
 2ae:	e00080e7          	jalr	-512(ra) # aa <schedule>
            dispatch();
 2b2:	00000097          	auipc	ra,0x0
 2b6:	e8e080e7          	jalr	-370(ra) # 140 <dispatch>
    return;
 2ba:	b7e1                	j	282 <thread_yield+0x26>

00000000000002bc <thread_start_threading>:

void thread_start_threading(void){
 2bc:	1141                	addi	sp,sp,-16
 2be:	e406                	sd	ra,8(sp)
 2c0:	e022                	sd	s0,0(sp)
 2c2:	0800                	addi	s0,sp,16
    // TODO
    
    if(setjmp(env_st) == 0){
 2c4:	00001517          	auipc	a0,0x1
 2c8:	88450513          	addi	a0,a0,-1916 # b48 <env_st>
 2cc:	00000097          	auipc	ra,0x0
 2d0:	7d0080e7          	jalr	2000(ra) # a9c <setjmp>
 2d4:	c509                	beqz	a0,2de <thread_start_threading+0x22>
        dispatch();
    }
    return;

}
 2d6:	60a2                	ld	ra,8(sp)
 2d8:	6402                	ld	s0,0(sp)
 2da:	0141                	addi	sp,sp,16
 2dc:	8082                	ret
        dispatch();
 2de:	00000097          	auipc	ra,0x0
 2e2:	e62080e7          	jalr	-414(ra) # 140 <dispatch>
    return;
 2e6:	bfc5                	j	2d6 <thread_start_threading+0x1a>

00000000000002e8 <thread_register_handler>:

// part 2
void thread_register_handler(int signo, void (*handler)(int)){
 2e8:	1141                	addi	sp,sp,-16
 2ea:	e422                	sd	s0,8(sp)
 2ec:	0800                	addi	s0,sp,16
    // TODO
    current_thread->sig_handler[signo] = handler;
 2ee:	0551                	addi	a0,a0,20
 2f0:	050e                	slli	a0,a0,0x3
 2f2:	00001797          	auipc	a5,0x1
 2f6:	8467b783          	ld	a5,-1978(a5) # b38 <current_thread>
 2fa:	953e                	add	a0,a0,a5
 2fc:	e50c                	sd	a1,8(a0)
    return;
}
 2fe:	6422                	ld	s0,8(sp)
 300:	0141                	addi	sp,sp,16
 302:	8082                	ret

0000000000000304 <thread_kill>:

void thread_kill(struct thread *t, int signo){
 304:	1141                	addi	sp,sp,-16
 306:	e422                	sd	s0,8(sp)
 308:	0800                	addi	s0,sp,16
    // TODO
    t->signo = signo;
 30a:	0ab52c23          	sw	a1,184(a0)
    return;
 30e:	6422                	ld	s0,8(sp)
 310:	0141                	addi	sp,sp,16
 312:	8082                	ret

0000000000000314 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 314:	1141                	addi	sp,sp,-16
 316:	e422                	sd	s0,8(sp)
 318:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 31a:	87aa                	mv	a5,a0
 31c:	0585                	addi	a1,a1,1
 31e:	0785                	addi	a5,a5,1
 320:	fff5c703          	lbu	a4,-1(a1)
 324:	fee78fa3          	sb	a4,-1(a5)
 328:	fb75                	bnez	a4,31c <strcpy+0x8>
    ;
  return os;
}
 32a:	6422                	ld	s0,8(sp)
 32c:	0141                	addi	sp,sp,16
 32e:	8082                	ret

0000000000000330 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 330:	1141                	addi	sp,sp,-16
 332:	e422                	sd	s0,8(sp)
 334:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 336:	00054783          	lbu	a5,0(a0)
 33a:	cb91                	beqz	a5,34e <strcmp+0x1e>
 33c:	0005c703          	lbu	a4,0(a1)
 340:	00f71763          	bne	a4,a5,34e <strcmp+0x1e>
    p++, q++;
 344:	0505                	addi	a0,a0,1
 346:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 348:	00054783          	lbu	a5,0(a0)
 34c:	fbe5                	bnez	a5,33c <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 34e:	0005c503          	lbu	a0,0(a1)
}
 352:	40a7853b          	subw	a0,a5,a0
 356:	6422                	ld	s0,8(sp)
 358:	0141                	addi	sp,sp,16
 35a:	8082                	ret

000000000000035c <strlen>:

uint
strlen(const char *s)
{
 35c:	1141                	addi	sp,sp,-16
 35e:	e422                	sd	s0,8(sp)
 360:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 362:	00054783          	lbu	a5,0(a0)
 366:	cf91                	beqz	a5,382 <strlen+0x26>
 368:	0505                	addi	a0,a0,1
 36a:	87aa                	mv	a5,a0
 36c:	4685                	li	a3,1
 36e:	9e89                	subw	a3,a3,a0
 370:	00f6853b          	addw	a0,a3,a5
 374:	0785                	addi	a5,a5,1
 376:	fff7c703          	lbu	a4,-1(a5)
 37a:	fb7d                	bnez	a4,370 <strlen+0x14>
    ;
  return n;
}
 37c:	6422                	ld	s0,8(sp)
 37e:	0141                	addi	sp,sp,16
 380:	8082                	ret
  for(n = 0; s[n]; n++)
 382:	4501                	li	a0,0
 384:	bfe5                	j	37c <strlen+0x20>

0000000000000386 <memset>:

void*
memset(void *dst, int c, uint n)
{
 386:	1141                	addi	sp,sp,-16
 388:	e422                	sd	s0,8(sp)
 38a:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 38c:	ca19                	beqz	a2,3a2 <memset+0x1c>
 38e:	87aa                	mv	a5,a0
 390:	1602                	slli	a2,a2,0x20
 392:	9201                	srli	a2,a2,0x20
 394:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 398:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 39c:	0785                	addi	a5,a5,1
 39e:	fee79de3          	bne	a5,a4,398 <memset+0x12>
  }
  return dst;
}
 3a2:	6422                	ld	s0,8(sp)
 3a4:	0141                	addi	sp,sp,16
 3a6:	8082                	ret

00000000000003a8 <strchr>:

char*
strchr(const char *s, char c)
{
 3a8:	1141                	addi	sp,sp,-16
 3aa:	e422                	sd	s0,8(sp)
 3ac:	0800                	addi	s0,sp,16
  for(; *s; s++)
 3ae:	00054783          	lbu	a5,0(a0)
 3b2:	cb99                	beqz	a5,3c8 <strchr+0x20>
    if(*s == c)
 3b4:	00f58763          	beq	a1,a5,3c2 <strchr+0x1a>
  for(; *s; s++)
 3b8:	0505                	addi	a0,a0,1
 3ba:	00054783          	lbu	a5,0(a0)
 3be:	fbfd                	bnez	a5,3b4 <strchr+0xc>
      return (char*)s;
  return 0;
 3c0:	4501                	li	a0,0
}
 3c2:	6422                	ld	s0,8(sp)
 3c4:	0141                	addi	sp,sp,16
 3c6:	8082                	ret
  return 0;
 3c8:	4501                	li	a0,0
 3ca:	bfe5                	j	3c2 <strchr+0x1a>

00000000000003cc <gets>:

char*
gets(char *buf, int max)
{
 3cc:	711d                	addi	sp,sp,-96
 3ce:	ec86                	sd	ra,88(sp)
 3d0:	e8a2                	sd	s0,80(sp)
 3d2:	e4a6                	sd	s1,72(sp)
 3d4:	e0ca                	sd	s2,64(sp)
 3d6:	fc4e                	sd	s3,56(sp)
 3d8:	f852                	sd	s4,48(sp)
 3da:	f456                	sd	s5,40(sp)
 3dc:	f05a                	sd	s6,32(sp)
 3de:	ec5e                	sd	s7,24(sp)
 3e0:	1080                	addi	s0,sp,96
 3e2:	8baa                	mv	s7,a0
 3e4:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3e6:	892a                	mv	s2,a0
 3e8:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 3ea:	4aa9                	li	s5,10
 3ec:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 3ee:	89a6                	mv	s3,s1
 3f0:	2485                	addiw	s1,s1,1
 3f2:	0344d863          	bge	s1,s4,422 <gets+0x56>
    cc = read(0, &c, 1);
 3f6:	4605                	li	a2,1
 3f8:	faf40593          	addi	a1,s0,-81
 3fc:	4501                	li	a0,0
 3fe:	00000097          	auipc	ra,0x0
 402:	19c080e7          	jalr	412(ra) # 59a <read>
    if(cc < 1)
 406:	00a05e63          	blez	a0,422 <gets+0x56>
    buf[i++] = c;
 40a:	faf44783          	lbu	a5,-81(s0)
 40e:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 412:	01578763          	beq	a5,s5,420 <gets+0x54>
 416:	0905                	addi	s2,s2,1
 418:	fd679be3          	bne	a5,s6,3ee <gets+0x22>
  for(i=0; i+1 < max; ){
 41c:	89a6                	mv	s3,s1
 41e:	a011                	j	422 <gets+0x56>
 420:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 422:	99de                	add	s3,s3,s7
 424:	00098023          	sb	zero,0(s3)
  return buf;
}
 428:	855e                	mv	a0,s7
 42a:	60e6                	ld	ra,88(sp)
 42c:	6446                	ld	s0,80(sp)
 42e:	64a6                	ld	s1,72(sp)
 430:	6906                	ld	s2,64(sp)
 432:	79e2                	ld	s3,56(sp)
 434:	7a42                	ld	s4,48(sp)
 436:	7aa2                	ld	s5,40(sp)
 438:	7b02                	ld	s6,32(sp)
 43a:	6be2                	ld	s7,24(sp)
 43c:	6125                	addi	sp,sp,96
 43e:	8082                	ret

0000000000000440 <stat>:

int
stat(const char *n, struct stat *st)
{
 440:	1101                	addi	sp,sp,-32
 442:	ec06                	sd	ra,24(sp)
 444:	e822                	sd	s0,16(sp)
 446:	e426                	sd	s1,8(sp)
 448:	e04a                	sd	s2,0(sp)
 44a:	1000                	addi	s0,sp,32
 44c:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 44e:	4581                	li	a1,0
 450:	00000097          	auipc	ra,0x0
 454:	172080e7          	jalr	370(ra) # 5c2 <open>
  if(fd < 0)
 458:	02054563          	bltz	a0,482 <stat+0x42>
 45c:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 45e:	85ca                	mv	a1,s2
 460:	00000097          	auipc	ra,0x0
 464:	17a080e7          	jalr	378(ra) # 5da <fstat>
 468:	892a                	mv	s2,a0
  close(fd);
 46a:	8526                	mv	a0,s1
 46c:	00000097          	auipc	ra,0x0
 470:	13e080e7          	jalr	318(ra) # 5aa <close>
  return r;
}
 474:	854a                	mv	a0,s2
 476:	60e2                	ld	ra,24(sp)
 478:	6442                	ld	s0,16(sp)
 47a:	64a2                	ld	s1,8(sp)
 47c:	6902                	ld	s2,0(sp)
 47e:	6105                	addi	sp,sp,32
 480:	8082                	ret
    return -1;
 482:	597d                	li	s2,-1
 484:	bfc5                	j	474 <stat+0x34>

0000000000000486 <atoi>:

int
atoi(const char *s)
{
 486:	1141                	addi	sp,sp,-16
 488:	e422                	sd	s0,8(sp)
 48a:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 48c:	00054603          	lbu	a2,0(a0)
 490:	fd06079b          	addiw	a5,a2,-48
 494:	0ff7f793          	andi	a5,a5,255
 498:	4725                	li	a4,9
 49a:	02f76963          	bltu	a4,a5,4cc <atoi+0x46>
 49e:	86aa                	mv	a3,a0
  n = 0;
 4a0:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 4a2:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 4a4:	0685                	addi	a3,a3,1
 4a6:	0025179b          	slliw	a5,a0,0x2
 4aa:	9fa9                	addw	a5,a5,a0
 4ac:	0017979b          	slliw	a5,a5,0x1
 4b0:	9fb1                	addw	a5,a5,a2
 4b2:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 4b6:	0006c603          	lbu	a2,0(a3)
 4ba:	fd06071b          	addiw	a4,a2,-48
 4be:	0ff77713          	andi	a4,a4,255
 4c2:	fee5f1e3          	bgeu	a1,a4,4a4 <atoi+0x1e>
  return n;
}
 4c6:	6422                	ld	s0,8(sp)
 4c8:	0141                	addi	sp,sp,16
 4ca:	8082                	ret
  n = 0;
 4cc:	4501                	li	a0,0
 4ce:	bfe5                	j	4c6 <atoi+0x40>

00000000000004d0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 4d0:	1141                	addi	sp,sp,-16
 4d2:	e422                	sd	s0,8(sp)
 4d4:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 4d6:	02b57463          	bgeu	a0,a1,4fe <memmove+0x2e>
    while(n-- > 0)
 4da:	00c05f63          	blez	a2,4f8 <memmove+0x28>
 4de:	1602                	slli	a2,a2,0x20
 4e0:	9201                	srli	a2,a2,0x20
 4e2:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 4e6:	872a                	mv	a4,a0
      *dst++ = *src++;
 4e8:	0585                	addi	a1,a1,1
 4ea:	0705                	addi	a4,a4,1
 4ec:	fff5c683          	lbu	a3,-1(a1)
 4f0:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 4f4:	fee79ae3          	bne	a5,a4,4e8 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 4f8:	6422                	ld	s0,8(sp)
 4fa:	0141                	addi	sp,sp,16
 4fc:	8082                	ret
    dst += n;
 4fe:	00c50733          	add	a4,a0,a2
    src += n;
 502:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 504:	fec05ae3          	blez	a2,4f8 <memmove+0x28>
 508:	fff6079b          	addiw	a5,a2,-1
 50c:	1782                	slli	a5,a5,0x20
 50e:	9381                	srli	a5,a5,0x20
 510:	fff7c793          	not	a5,a5
 514:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 516:	15fd                	addi	a1,a1,-1
 518:	177d                	addi	a4,a4,-1
 51a:	0005c683          	lbu	a3,0(a1)
 51e:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 522:	fee79ae3          	bne	a5,a4,516 <memmove+0x46>
 526:	bfc9                	j	4f8 <memmove+0x28>

0000000000000528 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 528:	1141                	addi	sp,sp,-16
 52a:	e422                	sd	s0,8(sp)
 52c:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 52e:	ca05                	beqz	a2,55e <memcmp+0x36>
 530:	fff6069b          	addiw	a3,a2,-1
 534:	1682                	slli	a3,a3,0x20
 536:	9281                	srli	a3,a3,0x20
 538:	0685                	addi	a3,a3,1
 53a:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 53c:	00054783          	lbu	a5,0(a0)
 540:	0005c703          	lbu	a4,0(a1)
 544:	00e79863          	bne	a5,a4,554 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 548:	0505                	addi	a0,a0,1
    p2++;
 54a:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 54c:	fed518e3          	bne	a0,a3,53c <memcmp+0x14>
  }
  return 0;
 550:	4501                	li	a0,0
 552:	a019                	j	558 <memcmp+0x30>
      return *p1 - *p2;
 554:	40e7853b          	subw	a0,a5,a4
}
 558:	6422                	ld	s0,8(sp)
 55a:	0141                	addi	sp,sp,16
 55c:	8082                	ret
  return 0;
 55e:	4501                	li	a0,0
 560:	bfe5                	j	558 <memcmp+0x30>

0000000000000562 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 562:	1141                	addi	sp,sp,-16
 564:	e406                	sd	ra,8(sp)
 566:	e022                	sd	s0,0(sp)
 568:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 56a:	00000097          	auipc	ra,0x0
 56e:	f66080e7          	jalr	-154(ra) # 4d0 <memmove>
}
 572:	60a2                	ld	ra,8(sp)
 574:	6402                	ld	s0,0(sp)
 576:	0141                	addi	sp,sp,16
 578:	8082                	ret

000000000000057a <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 57a:	4885                	li	a7,1
 ecall
 57c:	00000073          	ecall
 ret
 580:	8082                	ret

0000000000000582 <exit>:
.global exit
exit:
 li a7, SYS_exit
 582:	4889                	li	a7,2
 ecall
 584:	00000073          	ecall
 ret
 588:	8082                	ret

000000000000058a <wait>:
.global wait
wait:
 li a7, SYS_wait
 58a:	488d                	li	a7,3
 ecall
 58c:	00000073          	ecall
 ret
 590:	8082                	ret

0000000000000592 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 592:	4891                	li	a7,4
 ecall
 594:	00000073          	ecall
 ret
 598:	8082                	ret

000000000000059a <read>:
.global read
read:
 li a7, SYS_read
 59a:	4895                	li	a7,5
 ecall
 59c:	00000073          	ecall
 ret
 5a0:	8082                	ret

00000000000005a2 <write>:
.global write
write:
 li a7, SYS_write
 5a2:	48c1                	li	a7,16
 ecall
 5a4:	00000073          	ecall
 ret
 5a8:	8082                	ret

00000000000005aa <close>:
.global close
close:
 li a7, SYS_close
 5aa:	48d5                	li	a7,21
 ecall
 5ac:	00000073          	ecall
 ret
 5b0:	8082                	ret

00000000000005b2 <kill>:
.global kill
kill:
 li a7, SYS_kill
 5b2:	4899                	li	a7,6
 ecall
 5b4:	00000073          	ecall
 ret
 5b8:	8082                	ret

00000000000005ba <exec>:
.global exec
exec:
 li a7, SYS_exec
 5ba:	489d                	li	a7,7
 ecall
 5bc:	00000073          	ecall
 ret
 5c0:	8082                	ret

00000000000005c2 <open>:
.global open
open:
 li a7, SYS_open
 5c2:	48bd                	li	a7,15
 ecall
 5c4:	00000073          	ecall
 ret
 5c8:	8082                	ret

00000000000005ca <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 5ca:	48c5                	li	a7,17
 ecall
 5cc:	00000073          	ecall
 ret
 5d0:	8082                	ret

00000000000005d2 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 5d2:	48c9                	li	a7,18
 ecall
 5d4:	00000073          	ecall
 ret
 5d8:	8082                	ret

00000000000005da <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 5da:	48a1                	li	a7,8
 ecall
 5dc:	00000073          	ecall
 ret
 5e0:	8082                	ret

00000000000005e2 <link>:
.global link
link:
 li a7, SYS_link
 5e2:	48cd                	li	a7,19
 ecall
 5e4:	00000073          	ecall
 ret
 5e8:	8082                	ret

00000000000005ea <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 5ea:	48d1                	li	a7,20
 ecall
 5ec:	00000073          	ecall
 ret
 5f0:	8082                	ret

00000000000005f2 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 5f2:	48a5                	li	a7,9
 ecall
 5f4:	00000073          	ecall
 ret
 5f8:	8082                	ret

00000000000005fa <dup>:
.global dup
dup:
 li a7, SYS_dup
 5fa:	48a9                	li	a7,10
 ecall
 5fc:	00000073          	ecall
 ret
 600:	8082                	ret

0000000000000602 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 602:	48ad                	li	a7,11
 ecall
 604:	00000073          	ecall
 ret
 608:	8082                	ret

000000000000060a <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 60a:	48b1                	li	a7,12
 ecall
 60c:	00000073          	ecall
 ret
 610:	8082                	ret

0000000000000612 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 612:	48b5                	li	a7,13
 ecall
 614:	00000073          	ecall
 ret
 618:	8082                	ret

000000000000061a <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 61a:	48b9                	li	a7,14
 ecall
 61c:	00000073          	ecall
 ret
 620:	8082                	ret

0000000000000622 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 622:	1101                	addi	sp,sp,-32
 624:	ec06                	sd	ra,24(sp)
 626:	e822                	sd	s0,16(sp)
 628:	1000                	addi	s0,sp,32
 62a:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 62e:	4605                	li	a2,1
 630:	fef40593          	addi	a1,s0,-17
 634:	00000097          	auipc	ra,0x0
 638:	f6e080e7          	jalr	-146(ra) # 5a2 <write>
}
 63c:	60e2                	ld	ra,24(sp)
 63e:	6442                	ld	s0,16(sp)
 640:	6105                	addi	sp,sp,32
 642:	8082                	ret

0000000000000644 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 644:	7139                	addi	sp,sp,-64
 646:	fc06                	sd	ra,56(sp)
 648:	f822                	sd	s0,48(sp)
 64a:	f426                	sd	s1,40(sp)
 64c:	f04a                	sd	s2,32(sp)
 64e:	ec4e                	sd	s3,24(sp)
 650:	0080                	addi	s0,sp,64
 652:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 654:	c299                	beqz	a3,65a <printint+0x16>
 656:	0805c863          	bltz	a1,6e6 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 65a:	2581                	sext.w	a1,a1
  neg = 0;
 65c:	4881                	li	a7,0
 65e:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 662:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 664:	2601                	sext.w	a2,a2
 666:	00000517          	auipc	a0,0x0
 66a:	4ba50513          	addi	a0,a0,1210 # b20 <digits>
 66e:	883a                	mv	a6,a4
 670:	2705                	addiw	a4,a4,1
 672:	02c5f7bb          	remuw	a5,a1,a2
 676:	1782                	slli	a5,a5,0x20
 678:	9381                	srli	a5,a5,0x20
 67a:	97aa                	add	a5,a5,a0
 67c:	0007c783          	lbu	a5,0(a5)
 680:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 684:	0005879b          	sext.w	a5,a1
 688:	02c5d5bb          	divuw	a1,a1,a2
 68c:	0685                	addi	a3,a3,1
 68e:	fec7f0e3          	bgeu	a5,a2,66e <printint+0x2a>
  if(neg)
 692:	00088b63          	beqz	a7,6a8 <printint+0x64>
    buf[i++] = '-';
 696:	fd040793          	addi	a5,s0,-48
 69a:	973e                	add	a4,a4,a5
 69c:	02d00793          	li	a5,45
 6a0:	fef70823          	sb	a5,-16(a4)
 6a4:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 6a8:	02e05863          	blez	a4,6d8 <printint+0x94>
 6ac:	fc040793          	addi	a5,s0,-64
 6b0:	00e78933          	add	s2,a5,a4
 6b4:	fff78993          	addi	s3,a5,-1
 6b8:	99ba                	add	s3,s3,a4
 6ba:	377d                	addiw	a4,a4,-1
 6bc:	1702                	slli	a4,a4,0x20
 6be:	9301                	srli	a4,a4,0x20
 6c0:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 6c4:	fff94583          	lbu	a1,-1(s2)
 6c8:	8526                	mv	a0,s1
 6ca:	00000097          	auipc	ra,0x0
 6ce:	f58080e7          	jalr	-168(ra) # 622 <putc>
  while(--i >= 0)
 6d2:	197d                	addi	s2,s2,-1
 6d4:	ff3918e3          	bne	s2,s3,6c4 <printint+0x80>
}
 6d8:	70e2                	ld	ra,56(sp)
 6da:	7442                	ld	s0,48(sp)
 6dc:	74a2                	ld	s1,40(sp)
 6de:	7902                	ld	s2,32(sp)
 6e0:	69e2                	ld	s3,24(sp)
 6e2:	6121                	addi	sp,sp,64
 6e4:	8082                	ret
    x = -xx;
 6e6:	40b005bb          	negw	a1,a1
    neg = 1;
 6ea:	4885                	li	a7,1
    x = -xx;
 6ec:	bf8d                	j	65e <printint+0x1a>

00000000000006ee <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 6ee:	7119                	addi	sp,sp,-128
 6f0:	fc86                	sd	ra,120(sp)
 6f2:	f8a2                	sd	s0,112(sp)
 6f4:	f4a6                	sd	s1,104(sp)
 6f6:	f0ca                	sd	s2,96(sp)
 6f8:	ecce                	sd	s3,88(sp)
 6fa:	e8d2                	sd	s4,80(sp)
 6fc:	e4d6                	sd	s5,72(sp)
 6fe:	e0da                	sd	s6,64(sp)
 700:	fc5e                	sd	s7,56(sp)
 702:	f862                	sd	s8,48(sp)
 704:	f466                	sd	s9,40(sp)
 706:	f06a                	sd	s10,32(sp)
 708:	ec6e                	sd	s11,24(sp)
 70a:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 70c:	0005c903          	lbu	s2,0(a1)
 710:	18090f63          	beqz	s2,8ae <vprintf+0x1c0>
 714:	8aaa                	mv	s5,a0
 716:	8b32                	mv	s6,a2
 718:	00158493          	addi	s1,a1,1
  state = 0;
 71c:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 71e:	02500a13          	li	s4,37
      if(c == 'd'){
 722:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 726:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 72a:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 72e:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 732:	00000b97          	auipc	s7,0x0
 736:	3eeb8b93          	addi	s7,s7,1006 # b20 <digits>
 73a:	a839                	j	758 <vprintf+0x6a>
        putc(fd, c);
 73c:	85ca                	mv	a1,s2
 73e:	8556                	mv	a0,s5
 740:	00000097          	auipc	ra,0x0
 744:	ee2080e7          	jalr	-286(ra) # 622 <putc>
 748:	a019                	j	74e <vprintf+0x60>
    } else if(state == '%'){
 74a:	01498f63          	beq	s3,s4,768 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 74e:	0485                	addi	s1,s1,1
 750:	fff4c903          	lbu	s2,-1(s1)
 754:	14090d63          	beqz	s2,8ae <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 758:	0009079b          	sext.w	a5,s2
    if(state == 0){
 75c:	fe0997e3          	bnez	s3,74a <vprintf+0x5c>
      if(c == '%'){
 760:	fd479ee3          	bne	a5,s4,73c <vprintf+0x4e>
        state = '%';
 764:	89be                	mv	s3,a5
 766:	b7e5                	j	74e <vprintf+0x60>
      if(c == 'd'){
 768:	05878063          	beq	a5,s8,7a8 <vprintf+0xba>
      } else if(c == 'l') {
 76c:	05978c63          	beq	a5,s9,7c4 <vprintf+0xd6>
      } else if(c == 'x') {
 770:	07a78863          	beq	a5,s10,7e0 <vprintf+0xf2>
      } else if(c == 'p') {
 774:	09b78463          	beq	a5,s11,7fc <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 778:	07300713          	li	a4,115
 77c:	0ce78663          	beq	a5,a4,848 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 780:	06300713          	li	a4,99
 784:	0ee78e63          	beq	a5,a4,880 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 788:	11478863          	beq	a5,s4,898 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 78c:	85d2                	mv	a1,s4
 78e:	8556                	mv	a0,s5
 790:	00000097          	auipc	ra,0x0
 794:	e92080e7          	jalr	-366(ra) # 622 <putc>
        putc(fd, c);
 798:	85ca                	mv	a1,s2
 79a:	8556                	mv	a0,s5
 79c:	00000097          	auipc	ra,0x0
 7a0:	e86080e7          	jalr	-378(ra) # 622 <putc>
      }
      state = 0;
 7a4:	4981                	li	s3,0
 7a6:	b765                	j	74e <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 7a8:	008b0913          	addi	s2,s6,8
 7ac:	4685                	li	a3,1
 7ae:	4629                	li	a2,10
 7b0:	000b2583          	lw	a1,0(s6)
 7b4:	8556                	mv	a0,s5
 7b6:	00000097          	auipc	ra,0x0
 7ba:	e8e080e7          	jalr	-370(ra) # 644 <printint>
 7be:	8b4a                	mv	s6,s2
      state = 0;
 7c0:	4981                	li	s3,0
 7c2:	b771                	j	74e <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 7c4:	008b0913          	addi	s2,s6,8
 7c8:	4681                	li	a3,0
 7ca:	4629                	li	a2,10
 7cc:	000b2583          	lw	a1,0(s6)
 7d0:	8556                	mv	a0,s5
 7d2:	00000097          	auipc	ra,0x0
 7d6:	e72080e7          	jalr	-398(ra) # 644 <printint>
 7da:	8b4a                	mv	s6,s2
      state = 0;
 7dc:	4981                	li	s3,0
 7de:	bf85                	j	74e <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 7e0:	008b0913          	addi	s2,s6,8
 7e4:	4681                	li	a3,0
 7e6:	4641                	li	a2,16
 7e8:	000b2583          	lw	a1,0(s6)
 7ec:	8556                	mv	a0,s5
 7ee:	00000097          	auipc	ra,0x0
 7f2:	e56080e7          	jalr	-426(ra) # 644 <printint>
 7f6:	8b4a                	mv	s6,s2
      state = 0;
 7f8:	4981                	li	s3,0
 7fa:	bf91                	j	74e <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 7fc:	008b0793          	addi	a5,s6,8
 800:	f8f43423          	sd	a5,-120(s0)
 804:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 808:	03000593          	li	a1,48
 80c:	8556                	mv	a0,s5
 80e:	00000097          	auipc	ra,0x0
 812:	e14080e7          	jalr	-492(ra) # 622 <putc>
  putc(fd, 'x');
 816:	85ea                	mv	a1,s10
 818:	8556                	mv	a0,s5
 81a:	00000097          	auipc	ra,0x0
 81e:	e08080e7          	jalr	-504(ra) # 622 <putc>
 822:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 824:	03c9d793          	srli	a5,s3,0x3c
 828:	97de                	add	a5,a5,s7
 82a:	0007c583          	lbu	a1,0(a5)
 82e:	8556                	mv	a0,s5
 830:	00000097          	auipc	ra,0x0
 834:	df2080e7          	jalr	-526(ra) # 622 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 838:	0992                	slli	s3,s3,0x4
 83a:	397d                	addiw	s2,s2,-1
 83c:	fe0914e3          	bnez	s2,824 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 840:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 844:	4981                	li	s3,0
 846:	b721                	j	74e <vprintf+0x60>
        s = va_arg(ap, char*);
 848:	008b0993          	addi	s3,s6,8
 84c:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 850:	02090163          	beqz	s2,872 <vprintf+0x184>
        while(*s != 0){
 854:	00094583          	lbu	a1,0(s2)
 858:	c9a1                	beqz	a1,8a8 <vprintf+0x1ba>
          putc(fd, *s);
 85a:	8556                	mv	a0,s5
 85c:	00000097          	auipc	ra,0x0
 860:	dc6080e7          	jalr	-570(ra) # 622 <putc>
          s++;
 864:	0905                	addi	s2,s2,1
        while(*s != 0){
 866:	00094583          	lbu	a1,0(s2)
 86a:	f9e5                	bnez	a1,85a <vprintf+0x16c>
        s = va_arg(ap, char*);
 86c:	8b4e                	mv	s6,s3
      state = 0;
 86e:	4981                	li	s3,0
 870:	bdf9                	j	74e <vprintf+0x60>
          s = "(null)";
 872:	00000917          	auipc	s2,0x0
 876:	2a690913          	addi	s2,s2,678 # b18 <longjmp_1+0xa>
        while(*s != 0){
 87a:	02800593          	li	a1,40
 87e:	bff1                	j	85a <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 880:	008b0913          	addi	s2,s6,8
 884:	000b4583          	lbu	a1,0(s6)
 888:	8556                	mv	a0,s5
 88a:	00000097          	auipc	ra,0x0
 88e:	d98080e7          	jalr	-616(ra) # 622 <putc>
 892:	8b4a                	mv	s6,s2
      state = 0;
 894:	4981                	li	s3,0
 896:	bd65                	j	74e <vprintf+0x60>
        putc(fd, c);
 898:	85d2                	mv	a1,s4
 89a:	8556                	mv	a0,s5
 89c:	00000097          	auipc	ra,0x0
 8a0:	d86080e7          	jalr	-634(ra) # 622 <putc>
      state = 0;
 8a4:	4981                	li	s3,0
 8a6:	b565                	j	74e <vprintf+0x60>
        s = va_arg(ap, char*);
 8a8:	8b4e                	mv	s6,s3
      state = 0;
 8aa:	4981                	li	s3,0
 8ac:	b54d                	j	74e <vprintf+0x60>
    }
  }
}
 8ae:	70e6                	ld	ra,120(sp)
 8b0:	7446                	ld	s0,112(sp)
 8b2:	74a6                	ld	s1,104(sp)
 8b4:	7906                	ld	s2,96(sp)
 8b6:	69e6                	ld	s3,88(sp)
 8b8:	6a46                	ld	s4,80(sp)
 8ba:	6aa6                	ld	s5,72(sp)
 8bc:	6b06                	ld	s6,64(sp)
 8be:	7be2                	ld	s7,56(sp)
 8c0:	7c42                	ld	s8,48(sp)
 8c2:	7ca2                	ld	s9,40(sp)
 8c4:	7d02                	ld	s10,32(sp)
 8c6:	6de2                	ld	s11,24(sp)
 8c8:	6109                	addi	sp,sp,128
 8ca:	8082                	ret

00000000000008cc <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 8cc:	715d                	addi	sp,sp,-80
 8ce:	ec06                	sd	ra,24(sp)
 8d0:	e822                	sd	s0,16(sp)
 8d2:	1000                	addi	s0,sp,32
 8d4:	e010                	sd	a2,0(s0)
 8d6:	e414                	sd	a3,8(s0)
 8d8:	e818                	sd	a4,16(s0)
 8da:	ec1c                	sd	a5,24(s0)
 8dc:	03043023          	sd	a6,32(s0)
 8e0:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 8e4:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 8e8:	8622                	mv	a2,s0
 8ea:	00000097          	auipc	ra,0x0
 8ee:	e04080e7          	jalr	-508(ra) # 6ee <vprintf>
}
 8f2:	60e2                	ld	ra,24(sp)
 8f4:	6442                	ld	s0,16(sp)
 8f6:	6161                	addi	sp,sp,80
 8f8:	8082                	ret

00000000000008fa <printf>:

void
printf(const char *fmt, ...)
{
 8fa:	711d                	addi	sp,sp,-96
 8fc:	ec06                	sd	ra,24(sp)
 8fe:	e822                	sd	s0,16(sp)
 900:	1000                	addi	s0,sp,32
 902:	e40c                	sd	a1,8(s0)
 904:	e810                	sd	a2,16(s0)
 906:	ec14                	sd	a3,24(s0)
 908:	f018                	sd	a4,32(s0)
 90a:	f41c                	sd	a5,40(s0)
 90c:	03043823          	sd	a6,48(s0)
 910:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 914:	00840613          	addi	a2,s0,8
 918:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 91c:	85aa                	mv	a1,a0
 91e:	4505                	li	a0,1
 920:	00000097          	auipc	ra,0x0
 924:	dce080e7          	jalr	-562(ra) # 6ee <vprintf>
}
 928:	60e2                	ld	ra,24(sp)
 92a:	6442                	ld	s0,16(sp)
 92c:	6125                	addi	sp,sp,96
 92e:	8082                	ret

0000000000000930 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 930:	1141                	addi	sp,sp,-16
 932:	e422                	sd	s0,8(sp)
 934:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 936:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 93a:	00000797          	auipc	a5,0x0
 93e:	2067b783          	ld	a5,518(a5) # b40 <freep>
 942:	a805                	j	972 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 944:	4618                	lw	a4,8(a2)
 946:	9db9                	addw	a1,a1,a4
 948:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 94c:	6398                	ld	a4,0(a5)
 94e:	6318                	ld	a4,0(a4)
 950:	fee53823          	sd	a4,-16(a0)
 954:	a091                	j	998 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 956:	ff852703          	lw	a4,-8(a0)
 95a:	9e39                	addw	a2,a2,a4
 95c:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 95e:	ff053703          	ld	a4,-16(a0)
 962:	e398                	sd	a4,0(a5)
 964:	a099                	j	9aa <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 966:	6398                	ld	a4,0(a5)
 968:	00e7e463          	bltu	a5,a4,970 <free+0x40>
 96c:	00e6ea63          	bltu	a3,a4,980 <free+0x50>
{
 970:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 972:	fed7fae3          	bgeu	a5,a3,966 <free+0x36>
 976:	6398                	ld	a4,0(a5)
 978:	00e6e463          	bltu	a3,a4,980 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 97c:	fee7eae3          	bltu	a5,a4,970 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 980:	ff852583          	lw	a1,-8(a0)
 984:	6390                	ld	a2,0(a5)
 986:	02059713          	slli	a4,a1,0x20
 98a:	9301                	srli	a4,a4,0x20
 98c:	0712                	slli	a4,a4,0x4
 98e:	9736                	add	a4,a4,a3
 990:	fae60ae3          	beq	a2,a4,944 <free+0x14>
    bp->s.ptr = p->s.ptr;
 994:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 998:	4790                	lw	a2,8(a5)
 99a:	02061713          	slli	a4,a2,0x20
 99e:	9301                	srli	a4,a4,0x20
 9a0:	0712                	slli	a4,a4,0x4
 9a2:	973e                	add	a4,a4,a5
 9a4:	fae689e3          	beq	a3,a4,956 <free+0x26>
  } else
    p->s.ptr = bp;
 9a8:	e394                	sd	a3,0(a5)
  freep = p;
 9aa:	00000717          	auipc	a4,0x0
 9ae:	18f73b23          	sd	a5,406(a4) # b40 <freep>
}
 9b2:	6422                	ld	s0,8(sp)
 9b4:	0141                	addi	sp,sp,16
 9b6:	8082                	ret

00000000000009b8 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 9b8:	7139                	addi	sp,sp,-64
 9ba:	fc06                	sd	ra,56(sp)
 9bc:	f822                	sd	s0,48(sp)
 9be:	f426                	sd	s1,40(sp)
 9c0:	f04a                	sd	s2,32(sp)
 9c2:	ec4e                	sd	s3,24(sp)
 9c4:	e852                	sd	s4,16(sp)
 9c6:	e456                	sd	s5,8(sp)
 9c8:	e05a                	sd	s6,0(sp)
 9ca:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9cc:	02051493          	slli	s1,a0,0x20
 9d0:	9081                	srli	s1,s1,0x20
 9d2:	04bd                	addi	s1,s1,15
 9d4:	8091                	srli	s1,s1,0x4
 9d6:	0014899b          	addiw	s3,s1,1
 9da:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 9dc:	00000517          	auipc	a0,0x0
 9e0:	16453503          	ld	a0,356(a0) # b40 <freep>
 9e4:	c515                	beqz	a0,a10 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9e6:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9e8:	4798                	lw	a4,8(a5)
 9ea:	02977f63          	bgeu	a4,s1,a28 <malloc+0x70>
 9ee:	8a4e                	mv	s4,s3
 9f0:	0009871b          	sext.w	a4,s3
 9f4:	6685                	lui	a3,0x1
 9f6:	00d77363          	bgeu	a4,a3,9fc <malloc+0x44>
 9fa:	6a05                	lui	s4,0x1
 9fc:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 a00:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a04:	00000917          	auipc	s2,0x0
 a08:	13c90913          	addi	s2,s2,316 # b40 <freep>
  if(p == (char*)-1)
 a0c:	5afd                	li	s5,-1
 a0e:	a88d                	j	a80 <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
 a10:	00000797          	auipc	a5,0x0
 a14:	1a878793          	addi	a5,a5,424 # bb8 <base>
 a18:	00000717          	auipc	a4,0x0
 a1c:	12f73423          	sd	a5,296(a4) # b40 <freep>
 a20:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 a22:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 a26:	b7e1                	j	9ee <malloc+0x36>
      if(p->s.size == nunits)
 a28:	02e48b63          	beq	s1,a4,a5e <malloc+0xa6>
        p->s.size -= nunits;
 a2c:	4137073b          	subw	a4,a4,s3
 a30:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a32:	1702                	slli	a4,a4,0x20
 a34:	9301                	srli	a4,a4,0x20
 a36:	0712                	slli	a4,a4,0x4
 a38:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a3a:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 a3e:	00000717          	auipc	a4,0x0
 a42:	10a73123          	sd	a0,258(a4) # b40 <freep>
      return (void*)(p + 1);
 a46:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 a4a:	70e2                	ld	ra,56(sp)
 a4c:	7442                	ld	s0,48(sp)
 a4e:	74a2                	ld	s1,40(sp)
 a50:	7902                	ld	s2,32(sp)
 a52:	69e2                	ld	s3,24(sp)
 a54:	6a42                	ld	s4,16(sp)
 a56:	6aa2                	ld	s5,8(sp)
 a58:	6b02                	ld	s6,0(sp)
 a5a:	6121                	addi	sp,sp,64
 a5c:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 a5e:	6398                	ld	a4,0(a5)
 a60:	e118                	sd	a4,0(a0)
 a62:	bff1                	j	a3e <malloc+0x86>
  hp->s.size = nu;
 a64:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 a68:	0541                	addi	a0,a0,16
 a6a:	00000097          	auipc	ra,0x0
 a6e:	ec6080e7          	jalr	-314(ra) # 930 <free>
  return freep;
 a72:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 a76:	d971                	beqz	a0,a4a <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a78:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a7a:	4798                	lw	a4,8(a5)
 a7c:	fa9776e3          	bgeu	a4,s1,a28 <malloc+0x70>
    if(p == freep)
 a80:	00093703          	ld	a4,0(s2)
 a84:	853e                	mv	a0,a5
 a86:	fef719e3          	bne	a4,a5,a78 <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
 a8a:	8552                	mv	a0,s4
 a8c:	00000097          	auipc	ra,0x0
 a90:	b7e080e7          	jalr	-1154(ra) # 60a <sbrk>
  if(p == (char*)-1)
 a94:	fd5518e3          	bne	a0,s5,a64 <malloc+0xac>
        return 0;
 a98:	4501                	li	a0,0
 a9a:	bf45                	j	a4a <malloc+0x92>

0000000000000a9c <setjmp>:
 a9c:	e100                	sd	s0,0(a0)
 a9e:	e504                	sd	s1,8(a0)
 aa0:	01253823          	sd	s2,16(a0)
 aa4:	01353c23          	sd	s3,24(a0)
 aa8:	03453023          	sd	s4,32(a0)
 aac:	03553423          	sd	s5,40(a0)
 ab0:	03653823          	sd	s6,48(a0)
 ab4:	03753c23          	sd	s7,56(a0)
 ab8:	05853023          	sd	s8,64(a0)
 abc:	05953423          	sd	s9,72(a0)
 ac0:	05a53823          	sd	s10,80(a0)
 ac4:	05b53c23          	sd	s11,88(a0)
 ac8:	06153023          	sd	ra,96(a0)
 acc:	06253423          	sd	sp,104(a0)
 ad0:	4501                	li	a0,0
 ad2:	8082                	ret

0000000000000ad4 <longjmp>:
 ad4:	6100                	ld	s0,0(a0)
 ad6:	6504                	ld	s1,8(a0)
 ad8:	01053903          	ld	s2,16(a0)
 adc:	01853983          	ld	s3,24(a0)
 ae0:	02053a03          	ld	s4,32(a0)
 ae4:	02853a83          	ld	s5,40(a0)
 ae8:	03053b03          	ld	s6,48(a0)
 aec:	03853b83          	ld	s7,56(a0)
 af0:	04053c03          	ld	s8,64(a0)
 af4:	04853c83          	ld	s9,72(a0)
 af8:	05053d03          	ld	s10,80(a0)
 afc:	05853d83          	ld	s11,88(a0)
 b00:	06053083          	ld	ra,96(a0)
 b04:	06853103          	ld	sp,104(a0)
 b08:	c199                	beqz	a1,b0e <longjmp_1>
 b0a:	852e                	mv	a0,a1
 b0c:	8082                	ret

0000000000000b0e <longjmp_1>:
 b0e:	4505                	li	a0,1
 b10:	8082                	ret
