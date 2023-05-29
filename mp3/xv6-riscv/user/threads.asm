
user/_threads:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <__list_add>:
 * the prev/next entries already!
 */
static inline void __list_add(struct list_head *new_entry,
                              struct list_head *prev,
                              struct list_head *next)
{
       0:	7179                	addi	sp,sp,-48
       2:	f422                	sd	s0,40(sp)
       4:	1800                	addi	s0,sp,48
       6:	fea43423          	sd	a0,-24(s0)
       a:	feb43023          	sd	a1,-32(s0)
       e:	fcc43c23          	sd	a2,-40(s0)
    next->prev = new_entry;
      12:	fd843783          	ld	a5,-40(s0)
      16:	fe843703          	ld	a4,-24(s0)
      1a:	e798                	sd	a4,8(a5)
    new_entry->next = next;
      1c:	fe843783          	ld	a5,-24(s0)
      20:	fd843703          	ld	a4,-40(s0)
      24:	e398                	sd	a4,0(a5)
    new_entry->prev = prev;
      26:	fe843783          	ld	a5,-24(s0)
      2a:	fe043703          	ld	a4,-32(s0)
      2e:	e798                	sd	a4,8(a5)
    prev->next = new_entry;
      30:	fe043783          	ld	a5,-32(s0)
      34:	fe843703          	ld	a4,-24(s0)
      38:	e398                	sd	a4,0(a5)
}
      3a:	0001                	nop
      3c:	7422                	ld	s0,40(sp)
      3e:	6145                	addi	sp,sp,48
      40:	8082                	ret

0000000000000042 <list_add_tail>:
 *
 * Insert a new entry before the specified head.
 * This is useful for implementing queues.
 */
static inline void list_add_tail(struct list_head *new_entry, struct list_head *head)
{
      42:	1101                	addi	sp,sp,-32
      44:	ec06                	sd	ra,24(sp)
      46:	e822                	sd	s0,16(sp)
      48:	1000                	addi	s0,sp,32
      4a:	fea43423          	sd	a0,-24(s0)
      4e:	feb43023          	sd	a1,-32(s0)
    __list_add(new_entry, head->prev, head);
      52:	fe043783          	ld	a5,-32(s0)
      56:	679c                	ld	a5,8(a5)
      58:	fe043603          	ld	a2,-32(s0)
      5c:	85be                	mv	a1,a5
      5e:	fe843503          	ld	a0,-24(s0)
      62:	00000097          	auipc	ra,0x0
      66:	f9e080e7          	jalr	-98(ra) # 0 <__list_add>
}
      6a:	0001                	nop
      6c:	60e2                	ld	ra,24(sp)
      6e:	6442                	ld	s0,16(sp)
      70:	6105                	addi	sp,sp,32
      72:	8082                	ret

0000000000000074 <__list_del>:
 *
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 */
static inline void __list_del(struct list_head *prev, struct list_head *next)
{
      74:	1101                	addi	sp,sp,-32
      76:	ec22                	sd	s0,24(sp)
      78:	1000                	addi	s0,sp,32
      7a:	fea43423          	sd	a0,-24(s0)
      7e:	feb43023          	sd	a1,-32(s0)
    next->prev = prev;
      82:	fe043783          	ld	a5,-32(s0)
      86:	fe843703          	ld	a4,-24(s0)
      8a:	e798                	sd	a4,8(a5)
    prev->next = next;
      8c:	fe843783          	ld	a5,-24(s0)
      90:	fe043703          	ld	a4,-32(s0)
      94:	e398                	sd	a4,0(a5)
}
      96:	0001                	nop
      98:	6462                	ld	s0,24(sp)
      9a:	6105                	addi	sp,sp,32
      9c:	8082                	ret

000000000000009e <list_del>:
 * @entry: the element to delete from the list.
 * Note: list_empty on entry does not return true after this, the entry is
 * in an undefined state.
 */
static inline void list_del(struct list_head *entry)
{
      9e:	1101                	addi	sp,sp,-32
      a0:	ec06                	sd	ra,24(sp)
      a2:	e822                	sd	s0,16(sp)
      a4:	1000                	addi	s0,sp,32
      a6:	fea43423          	sd	a0,-24(s0)
    __list_del(entry->prev, entry->next);
      aa:	fe843783          	ld	a5,-24(s0)
      ae:	6798                	ld	a4,8(a5)
      b0:	fe843783          	ld	a5,-24(s0)
      b4:	639c                	ld	a5,0(a5)
      b6:	85be                	mv	a1,a5
      b8:	853a                	mv	a0,a4
      ba:	00000097          	auipc	ra,0x0
      be:	fba080e7          	jalr	-70(ra) # 74 <__list_del>
    entry->next = LIST_POISON1;
      c2:	fe843783          	ld	a5,-24(s0)
      c6:	00100737          	lui	a4,0x100
      ca:	10070713          	addi	a4,a4,256 # 100100 <__global_pointer$+0xfd860>
      ce:	e398                	sd	a4,0(a5)
    entry->prev = LIST_POISON2;
      d0:	fe843783          	ld	a5,-24(s0)
      d4:	00200737          	lui	a4,0x200
      d8:	20070713          	addi	a4,a4,512 # 200200 <__global_pointer$+0x1fd960>
      dc:	e798                	sd	a4,8(a5)
}
      de:	0001                	nop
      e0:	60e2                	ld	ra,24(sp)
      e2:	6442                	ld	s0,16(sp)
      e4:	6105                	addi	sp,sp,32
      e6:	8082                	ret

00000000000000e8 <list_empty>:
/**
 * list_empty - tests whether a list is empty
 * @head: the list to test.
 */
static inline int list_empty(const struct list_head *head)
{
      e8:	1101                	addi	sp,sp,-32
      ea:	ec22                	sd	s0,24(sp)
      ec:	1000                	addi	s0,sp,32
      ee:	fea43423          	sd	a0,-24(s0)
    return head->next == head;
      f2:	fe843783          	ld	a5,-24(s0)
      f6:	639c                	ld	a5,0(a5)
      f8:	fe843703          	ld	a4,-24(s0)
      fc:	40f707b3          	sub	a5,a4,a5
     100:	0017b793          	seqz	a5,a5
     104:	0ff7f793          	andi	a5,a5,255
     108:	2781                	sext.w	a5,a5
}
     10a:	853e                	mv	a0,a5
     10c:	6462                	ld	s0,24(sp)
     10e:	6105                	addi	sp,sp,32
     110:	8082                	ret

0000000000000112 <thread_create>:

void __dispatch(void);
void __schedule(void);

struct thread *thread_create(void (*f)(void *), void *arg, int processing_time, int period, int n)
{
     112:	715d                	addi	sp,sp,-80
     114:	e486                	sd	ra,72(sp)
     116:	e0a2                	sd	s0,64(sp)
     118:	0880                	addi	s0,sp,80
     11a:	fca43423          	sd	a0,-56(s0)
     11e:	fcb43023          	sd	a1,-64(s0)
     122:	87b2                	mv	a5,a2
     124:	faf42e23          	sw	a5,-68(s0)
     128:	87b6                	mv	a5,a3
     12a:	faf42c23          	sw	a5,-72(s0)
     12e:	87ba                	mv	a5,a4
     130:	faf42a23          	sw	a5,-76(s0)
    static int _id = 1;
    struct thread *t = (struct thread *)malloc(sizeof(struct thread));
     134:	05800513          	li	a0,88
     138:	00001097          	auipc	ra,0x1
     13c:	490080e7          	jalr	1168(ra) # 15c8 <malloc>
     140:	fea43423          	sd	a0,-24(s0)
    unsigned long new_stack_p;
    unsigned long new_stack;
    new_stack = (unsigned long)malloc(sizeof(unsigned long) * 0x200);
     144:	6505                	lui	a0,0x1
     146:	00001097          	auipc	ra,0x1
     14a:	482080e7          	jalr	1154(ra) # 15c8 <malloc>
     14e:	87aa                	mv	a5,a0
     150:	fef43023          	sd	a5,-32(s0)
    new_stack_p = new_stack + 0x200 * 8 - 0x2 * 8;
     154:	fe043703          	ld	a4,-32(s0)
     158:	6785                	lui	a5,0x1
     15a:	17c1                	addi	a5,a5,-16
     15c:	97ba                	add	a5,a5,a4
     15e:	fcf43c23          	sd	a5,-40(s0)
    t->fp = f;
     162:	fe843783          	ld	a5,-24(s0)
     166:	fc843703          	ld	a4,-56(s0)
     16a:	e398                	sd	a4,0(a5)
    t->arg = arg;
     16c:	fe843783          	ld	a5,-24(s0)
     170:	fc043703          	ld	a4,-64(s0)
     174:	e798                	sd	a4,8(a5)
    t->ID = _id++;
     176:	00002797          	auipc	a5,0x2
     17a:	f6278793          	addi	a5,a5,-158 # 20d8 <_id.0>
     17e:	439c                	lw	a5,0(a5)
     180:	0017871b          	addiw	a4,a5,1
     184:	0007069b          	sext.w	a3,a4
     188:	00002717          	auipc	a4,0x2
     18c:	f5070713          	addi	a4,a4,-176 # 20d8 <_id.0>
     190:	c314                	sw	a3,0(a4)
     192:	fe843703          	ld	a4,-24(s0)
     196:	d31c                	sw	a5,32(a4)
    t->buf_set = 0;
     198:	fe843783          	ld	a5,-24(s0)
     19c:	0207ac23          	sw	zero,56(a5)
    t->stack = (void *)new_stack;
     1a0:	fe043703          	ld	a4,-32(s0)
     1a4:	fe843783          	ld	a5,-24(s0)
     1a8:	eb98                	sd	a4,16(a5)
    t->stack_p = (void *)new_stack_p;
     1aa:	fd843703          	ld	a4,-40(s0)
     1ae:	fe843783          	ld	a5,-24(s0)
     1b2:	ef98                	sd	a4,24(a5)

    t->processing_time = processing_time;
     1b4:	fe843783          	ld	a5,-24(s0)
     1b8:	fbc42703          	lw	a4,-68(s0)
     1bc:	c3b8                	sw	a4,64(a5)
    t->period = period;
     1be:	fe843783          	ld	a5,-24(s0)
     1c2:	fb842703          	lw	a4,-72(s0)
     1c6:	c3f8                	sw	a4,68(a5)
    t->n = n;
     1c8:	fe843783          	ld	a5,-24(s0)
     1cc:	fb442703          	lw	a4,-76(s0)
     1d0:	c7b8                	sw	a4,72(a5)
    t->remaining_time = 0;
     1d2:	fe843783          	ld	a5,-24(s0)
     1d6:	0407a623          	sw	zero,76(a5)
    t->current_deadline = 0;
     1da:	fe843783          	ld	a5,-24(s0)
     1de:	0407a823          	sw	zero,80(a5)
    return t;
     1e2:	fe843783          	ld	a5,-24(s0)
}
     1e6:	853e                	mv	a0,a5
     1e8:	60a6                	ld	ra,72(sp)
     1ea:	6406                	ld	s0,64(sp)
     1ec:	6161                	addi	sp,sp,80
     1ee:	8082                	ret

00000000000001f0 <thread_add_at>:

void thread_add_at(struct thread *t, int arrival_time)
{
     1f0:	7179                	addi	sp,sp,-48
     1f2:	f406                	sd	ra,40(sp)
     1f4:	f022                	sd	s0,32(sp)
     1f6:	1800                	addi	s0,sp,48
     1f8:	fca43c23          	sd	a0,-40(s0)
     1fc:	87ae                	mv	a5,a1
     1fe:	fcf42a23          	sw	a5,-44(s0)
    struct release_queue_entry *new_entry = (struct release_queue_entry *)malloc(sizeof(struct release_queue_entry));
     202:	02000513          	li	a0,32
     206:	00001097          	auipc	ra,0x1
     20a:	3c2080e7          	jalr	962(ra) # 15c8 <malloc>
     20e:	fea43423          	sd	a0,-24(s0)
    new_entry->thrd = t;
     212:	fe843783          	ld	a5,-24(s0)
     216:	fd843703          	ld	a4,-40(s0)
     21a:	e398                	sd	a4,0(a5)
    new_entry->release_time = arrival_time;
     21c:	fe843783          	ld	a5,-24(s0)
     220:	fd442703          	lw	a4,-44(s0)
     224:	cf98                	sw	a4,24(a5)
    t->current_deadline = arrival_time;
     226:	fd843783          	ld	a5,-40(s0)
     22a:	fd442703          	lw	a4,-44(s0)
     22e:	cbb8                	sw	a4,80(a5)
    list_add_tail(&new_entry->thread_list, &release_queue);
     230:	fe843783          	ld	a5,-24(s0)
     234:	07a1                	addi	a5,a5,8
     236:	00002597          	auipc	a1,0x2
     23a:	e7a58593          	addi	a1,a1,-390 # 20b0 <release_queue>
     23e:	853e                	mv	a0,a5
     240:	00000097          	auipc	ra,0x0
     244:	e02080e7          	jalr	-510(ra) # 42 <list_add_tail>
}
     248:	0001                	nop
     24a:	70a2                	ld	ra,40(sp)
     24c:	7402                	ld	s0,32(sp)
     24e:	6145                	addi	sp,sp,48
     250:	8082                	ret

0000000000000252 <__release>:

void __release()
{
     252:	7139                	addi	sp,sp,-64
     254:	fc06                	sd	ra,56(sp)
     256:	f822                	sd	s0,48(sp)
     258:	0080                	addi	s0,sp,64
    struct release_queue_entry *cur, *nxt;
    list_for_each_entry_safe(cur, nxt, &release_queue, thread_list) {
     25a:	00002797          	auipc	a5,0x2
     25e:	e5678793          	addi	a5,a5,-426 # 20b0 <release_queue>
     262:	639c                	ld	a5,0(a5)
     264:	fcf43c23          	sd	a5,-40(s0)
     268:	fd843783          	ld	a5,-40(s0)
     26c:	17e1                	addi	a5,a5,-8
     26e:	fef43423          	sd	a5,-24(s0)
     272:	fe843783          	ld	a5,-24(s0)
     276:	679c                	ld	a5,8(a5)
     278:	fcf43823          	sd	a5,-48(s0)
     27c:	fd043783          	ld	a5,-48(s0)
     280:	17e1                	addi	a5,a5,-8
     282:	fef43023          	sd	a5,-32(s0)
     286:	a851                	j	31a <__release+0xc8>
        if (threading_system_time >= cur->release_time) {
     288:	fe843783          	ld	a5,-24(s0)
     28c:	4f98                	lw	a4,24(a5)
     28e:	00002797          	auipc	a5,0x2
     292:	e5a78793          	addi	a5,a5,-422 # 20e8 <threading_system_time>
     296:	439c                	lw	a5,0(a5)
     298:	06e7c363          	blt	a5,a4,2fe <__release+0xac>
            cur->thrd->remaining_time = cur->thrd->processing_time;
     29c:	fe843783          	ld	a5,-24(s0)
     2a0:	6398                	ld	a4,0(a5)
     2a2:	fe843783          	ld	a5,-24(s0)
     2a6:	639c                	ld	a5,0(a5)
     2a8:	4338                	lw	a4,64(a4)
     2aa:	c7f8                	sw	a4,76(a5)
            cur->thrd->current_deadline = cur->release_time + cur->thrd->period;
     2ac:	fe843783          	ld	a5,-24(s0)
     2b0:	4f94                	lw	a3,24(a5)
     2b2:	fe843783          	ld	a5,-24(s0)
     2b6:	639c                	ld	a5,0(a5)
     2b8:	43f8                	lw	a4,68(a5)
     2ba:	fe843783          	ld	a5,-24(s0)
     2be:	639c                	ld	a5,0(a5)
     2c0:	9f35                	addw	a4,a4,a3
     2c2:	2701                	sext.w	a4,a4
     2c4:	cbb8                	sw	a4,80(a5)
            list_add_tail(&cur->thrd->thread_list, &run_queue);
     2c6:	fe843783          	ld	a5,-24(s0)
     2ca:	639c                	ld	a5,0(a5)
     2cc:	02878793          	addi	a5,a5,40
     2d0:	00002597          	auipc	a1,0x2
     2d4:	dd058593          	addi	a1,a1,-560 # 20a0 <run_queue>
     2d8:	853e                	mv	a0,a5
     2da:	00000097          	auipc	ra,0x0
     2de:	d68080e7          	jalr	-664(ra) # 42 <list_add_tail>
            list_del(&cur->thread_list);
     2e2:	fe843783          	ld	a5,-24(s0)
     2e6:	07a1                	addi	a5,a5,8
     2e8:	853e                	mv	a0,a5
     2ea:	00000097          	auipc	ra,0x0
     2ee:	db4080e7          	jalr	-588(ra) # 9e <list_del>
            free(cur);
     2f2:	fe843503          	ld	a0,-24(s0)
     2f6:	00001097          	auipc	ra,0x1
     2fa:	130080e7          	jalr	304(ra) # 1426 <free>
    list_for_each_entry_safe(cur, nxt, &release_queue, thread_list) {
     2fe:	fe043783          	ld	a5,-32(s0)
     302:	fef43423          	sd	a5,-24(s0)
     306:	fe043783          	ld	a5,-32(s0)
     30a:	679c                	ld	a5,8(a5)
     30c:	fcf43423          	sd	a5,-56(s0)
     310:	fc843783          	ld	a5,-56(s0)
     314:	17e1                	addi	a5,a5,-8
     316:	fef43023          	sd	a5,-32(s0)
     31a:	fe843783          	ld	a5,-24(s0)
     31e:	00878713          	addi	a4,a5,8
     322:	00002797          	auipc	a5,0x2
     326:	d8e78793          	addi	a5,a5,-626 # 20b0 <release_queue>
     32a:	f4f71fe3          	bne	a4,a5,288 <__release+0x36>
        }
    }
}
     32e:	0001                	nop
     330:	0001                	nop
     332:	70e2                	ld	ra,56(sp)
     334:	7442                	ld	s0,48(sp)
     336:	6121                	addi	sp,sp,64
     338:	8082                	ret

000000000000033a <__thread_exit>:

void __thread_exit(struct thread *to_remove)
{
     33a:	1101                	addi	sp,sp,-32
     33c:	ec06                	sd	ra,24(sp)
     33e:	e822                	sd	s0,16(sp)
     340:	1000                	addi	s0,sp,32
     342:	fea43423          	sd	a0,-24(s0)
    current = to_remove->thread_list.prev;
     346:	fe843783          	ld	a5,-24(s0)
     34a:	7b98                	ld	a4,48(a5)
     34c:	00002797          	auipc	a5,0x2
     350:	d9478793          	addi	a5,a5,-620 # 20e0 <current>
     354:	e398                	sd	a4,0(a5)
    list_del(&to_remove->thread_list);
     356:	fe843783          	ld	a5,-24(s0)
     35a:	02878793          	addi	a5,a5,40
     35e:	853e                	mv	a0,a5
     360:	00000097          	auipc	ra,0x0
     364:	d3e080e7          	jalr	-706(ra) # 9e <list_del>

    free(to_remove->stack);
     368:	fe843783          	ld	a5,-24(s0)
     36c:	6b9c                	ld	a5,16(a5)
     36e:	853e                	mv	a0,a5
     370:	00001097          	auipc	ra,0x1
     374:	0b6080e7          	jalr	182(ra) # 1426 <free>
    free(to_remove);
     378:	fe843503          	ld	a0,-24(s0)
     37c:	00001097          	auipc	ra,0x1
     380:	0aa080e7          	jalr	170(ra) # 1426 <free>

    __schedule();
     384:	00000097          	auipc	ra,0x0
     388:	446080e7          	jalr	1094(ra) # 7ca <__schedule>
    __dispatch();
     38c:	00000097          	auipc	ra,0x0
     390:	2b6080e7          	jalr	694(ra) # 642 <__dispatch>
    thrdresume(main_thrd_id);
     394:	00002797          	auipc	a5,0x2
     398:	d4078793          	addi	a5,a5,-704 # 20d4 <main_thrd_id>
     39c:	439c                	lw	a5,0(a5)
     39e:	853e                	mv	a0,a5
     3a0:	00001097          	auipc	ra,0x1
     3a4:	b98080e7          	jalr	-1128(ra) # f38 <thrdresume>
}
     3a8:	0001                	nop
     3aa:	60e2                	ld	ra,24(sp)
     3ac:	6442                	ld	s0,16(sp)
     3ae:	6105                	addi	sp,sp,32
     3b0:	8082                	ret

00000000000003b2 <thread_exit>:

void thread_exit(void)
{
     3b2:	7179                	addi	sp,sp,-48
     3b4:	f406                	sd	ra,40(sp)
     3b6:	f022                	sd	s0,32(sp)
     3b8:	1800                	addi	s0,sp,48
    if (current == &run_queue) {
     3ba:	00002797          	auipc	a5,0x2
     3be:	d2678793          	addi	a5,a5,-730 # 20e0 <current>
     3c2:	6398                	ld	a4,0(a5)
     3c4:	00002797          	auipc	a5,0x2
     3c8:	cdc78793          	addi	a5,a5,-804 # 20a0 <run_queue>
     3cc:	02f71063          	bne	a4,a5,3ec <thread_exit+0x3a>
        fprintf(2, "[FATAL] thread_exit is called on a nonexistent thread\n");
     3d0:	00002597          	auipc	a1,0x2
     3d4:	ba058593          	addi	a1,a1,-1120 # 1f70 <schedule_rm+0x360>
     3d8:	4509                	li	a0,2
     3da:	00001097          	auipc	ra,0x1
     3de:	fa4080e7          	jalr	-92(ra) # 137e <fprintf>
        exit(1);
     3e2:	4505                	li	a0,1
     3e4:	00001097          	auipc	ra,0x1
     3e8:	aac080e7          	jalr	-1364(ra) # e90 <exit>
    }

    struct thread *to_remove = list_entry(current, struct thread, thread_list);
     3ec:	00002797          	auipc	a5,0x2
     3f0:	cf478793          	addi	a5,a5,-780 # 20e0 <current>
     3f4:	639c                	ld	a5,0(a5)
     3f6:	fef43423          	sd	a5,-24(s0)
     3fa:	fe843783          	ld	a5,-24(s0)
     3fe:	fd878793          	addi	a5,a5,-40
     402:	fef43023          	sd	a5,-32(s0)
    int consume_ticks = cancelthrdstop(to_remove->thrdstop_context_id, 1);
     406:	fe043783          	ld	a5,-32(s0)
     40a:	5fdc                	lw	a5,60(a5)
     40c:	4585                	li	a1,1
     40e:	853e                	mv	a0,a5
     410:	00001097          	auipc	ra,0x1
     414:	b30080e7          	jalr	-1232(ra) # f40 <cancelthrdstop>
     418:	87aa                	mv	a5,a0
     41a:	fcf42e23          	sw	a5,-36(s0)
    threading_system_time += consume_ticks;
     41e:	00002797          	auipc	a5,0x2
     422:	cca78793          	addi	a5,a5,-822 # 20e8 <threading_system_time>
     426:	439c                	lw	a5,0(a5)
     428:	fdc42703          	lw	a4,-36(s0)
     42c:	9fb9                	addw	a5,a5,a4
     42e:	0007871b          	sext.w	a4,a5
     432:	00002797          	auipc	a5,0x2
     436:	cb678793          	addi	a5,a5,-842 # 20e8 <threading_system_time>
     43a:	c398                	sw	a4,0(a5)

    __release();
     43c:	00000097          	auipc	ra,0x0
     440:	e16080e7          	jalr	-490(ra) # 252 <__release>
    __thread_exit(to_remove);
     444:	fe043503          	ld	a0,-32(s0)
     448:	00000097          	auipc	ra,0x0
     44c:	ef2080e7          	jalr	-270(ra) # 33a <__thread_exit>
}
     450:	0001                	nop
     452:	70a2                	ld	ra,40(sp)
     454:	7402                	ld	s0,32(sp)
     456:	6145                	addi	sp,sp,48
     458:	8082                	ret

000000000000045a <__finish_current>:

void __finish_current()
{
     45a:	7179                	addi	sp,sp,-48
     45c:	f406                	sd	ra,40(sp)
     45e:	f022                	sd	s0,32(sp)
     460:	1800                	addi	s0,sp,48
    struct thread *current_thread = list_entry(current, struct thread, thread_list);
     462:	00002797          	auipc	a5,0x2
     466:	c7e78793          	addi	a5,a5,-898 # 20e0 <current>
     46a:	639c                	ld	a5,0(a5)
     46c:	fef43423          	sd	a5,-24(s0)
     470:	fe843783          	ld	a5,-24(s0)
     474:	fd878793          	addi	a5,a5,-40
     478:	fef43023          	sd	a5,-32(s0)
    --current_thread->n;
     47c:	fe043783          	ld	a5,-32(s0)
     480:	47bc                	lw	a5,72(a5)
     482:	37fd                	addiw	a5,a5,-1
     484:	0007871b          	sext.w	a4,a5
     488:	fe043783          	ld	a5,-32(s0)
     48c:	c7b8                	sw	a4,72(a5)

    printf("thread#%d finish one cycle at %d: %d cycles left\n",
     48e:	fe043783          	ld	a5,-32(s0)
     492:	5398                	lw	a4,32(a5)
     494:	00002797          	auipc	a5,0x2
     498:	c5478793          	addi	a5,a5,-940 # 20e8 <threading_system_time>
     49c:	4390                	lw	a2,0(a5)
     49e:	fe043783          	ld	a5,-32(s0)
     4a2:	47bc                	lw	a5,72(a5)
     4a4:	86be                	mv	a3,a5
     4a6:	85ba                	mv	a1,a4
     4a8:	00002517          	auipc	a0,0x2
     4ac:	b0050513          	addi	a0,a0,-1280 # 1fa8 <schedule_rm+0x398>
     4b0:	00001097          	auipc	ra,0x1
     4b4:	f26080e7          	jalr	-218(ra) # 13d6 <printf>
           current_thread->ID, threading_system_time, current_thread->n);

    if (current_thread->n > 0) {
     4b8:	fe043783          	ld	a5,-32(s0)
     4bc:	47bc                	lw	a5,72(a5)
     4be:	04f05563          	blez	a5,508 <__finish_current+0xae>
        struct list_head *to_remove = current;
     4c2:	00002797          	auipc	a5,0x2
     4c6:	c1e78793          	addi	a5,a5,-994 # 20e0 <current>
     4ca:	639c                	ld	a5,0(a5)
     4cc:	fcf43c23          	sd	a5,-40(s0)
        current = current->prev;
     4d0:	00002797          	auipc	a5,0x2
     4d4:	c1078793          	addi	a5,a5,-1008 # 20e0 <current>
     4d8:	639c                	ld	a5,0(a5)
     4da:	6798                	ld	a4,8(a5)
     4dc:	00002797          	auipc	a5,0x2
     4e0:	c0478793          	addi	a5,a5,-1020 # 20e0 <current>
     4e4:	e398                	sd	a4,0(a5)
        list_del(to_remove);
     4e6:	fd843503          	ld	a0,-40(s0)
     4ea:	00000097          	auipc	ra,0x0
     4ee:	bb4080e7          	jalr	-1100(ra) # 9e <list_del>
        thread_add_at(current_thread, current_thread->current_deadline);
     4f2:	fe043783          	ld	a5,-32(s0)
     4f6:	4bbc                	lw	a5,80(a5)
     4f8:	85be                	mv	a1,a5
     4fa:	fe043503          	ld	a0,-32(s0)
     4fe:	00000097          	auipc	ra,0x0
     502:	cf2080e7          	jalr	-782(ra) # 1f0 <thread_add_at>
    } else {
        __thread_exit(current_thread);
    }
}
     506:	a039                	j	514 <__finish_current+0xba>
        __thread_exit(current_thread);
     508:	fe043503          	ld	a0,-32(s0)
     50c:	00000097          	auipc	ra,0x0
     510:	e2e080e7          	jalr	-466(ra) # 33a <__thread_exit>
}
     514:	0001                	nop
     516:	70a2                	ld	ra,40(sp)
     518:	7402                	ld	s0,32(sp)
     51a:	6145                	addi	sp,sp,48
     51c:	8082                	ret

000000000000051e <switch_handler>:

void switch_handler(void *arg)
{
     51e:	7139                	addi	sp,sp,-64
     520:	fc06                	sd	ra,56(sp)
     522:	f822                	sd	s0,48(sp)
     524:	0080                	addi	s0,sp,64
     526:	fca43423          	sd	a0,-56(s0)
    uint64 elapsed_time = (uint64)arg;
     52a:	fc843783          	ld	a5,-56(s0)
     52e:	fef43423          	sd	a5,-24(s0)
    struct thread *current_thread = list_entry(current, struct thread, thread_list);
     532:	00002797          	auipc	a5,0x2
     536:	bae78793          	addi	a5,a5,-1106 # 20e0 <current>
     53a:	639c                	ld	a5,0(a5)
     53c:	fef43023          	sd	a5,-32(s0)
     540:	fe043783          	ld	a5,-32(s0)
     544:	fd878793          	addi	a5,a5,-40
     548:	fcf43c23          	sd	a5,-40(s0)

    threading_system_time += elapsed_time;
     54c:	fe843783          	ld	a5,-24(s0)
     550:	0007871b          	sext.w	a4,a5
     554:	00002797          	auipc	a5,0x2
     558:	b9478793          	addi	a5,a5,-1132 # 20e8 <threading_system_time>
     55c:	439c                	lw	a5,0(a5)
     55e:	2781                	sext.w	a5,a5
     560:	9fb9                	addw	a5,a5,a4
     562:	2781                	sext.w	a5,a5
     564:	0007871b          	sext.w	a4,a5
     568:	00002797          	auipc	a5,0x2
     56c:	b8078793          	addi	a5,a5,-1152 # 20e8 <threading_system_time>
     570:	c398                	sw	a4,0(a5)
     __release();
     572:	00000097          	auipc	ra,0x0
     576:	ce0080e7          	jalr	-800(ra) # 252 <__release>
    current_thread->remaining_time -= elapsed_time;
     57a:	fd843783          	ld	a5,-40(s0)
     57e:	47fc                	lw	a5,76(a5)
     580:	0007871b          	sext.w	a4,a5
     584:	fe843783          	ld	a5,-24(s0)
     588:	2781                	sext.w	a5,a5
     58a:	40f707bb          	subw	a5,a4,a5
     58e:	2781                	sext.w	a5,a5
     590:	0007871b          	sext.w	a4,a5
     594:	fd843783          	ld	a5,-40(s0)
     598:	c7f8                	sw	a4,76(a5)

    if (threading_system_time > current_thread->current_deadline || 
     59a:	fd843783          	ld	a5,-40(s0)
     59e:	4bb8                	lw	a4,80(a5)
     5a0:	00002797          	auipc	a5,0x2
     5a4:	b4878793          	addi	a5,a5,-1208 # 20e8 <threading_system_time>
     5a8:	439c                	lw	a5,0(a5)
     5aa:	02f74163          	blt	a4,a5,5cc <switch_handler+0xae>
        (threading_system_time == current_thread->current_deadline && current_thread->remaining_time > 0)) {
     5ae:	fd843783          	ld	a5,-40(s0)
     5b2:	4bb8                	lw	a4,80(a5)
     5b4:	00002797          	auipc	a5,0x2
     5b8:	b3478793          	addi	a5,a5,-1228 # 20e8 <threading_system_time>
     5bc:	439c                	lw	a5,0(a5)
    if (threading_system_time > current_thread->current_deadline || 
     5be:	02f71e63          	bne	a4,a5,5fa <switch_handler+0xdc>
        (threading_system_time == current_thread->current_deadline && current_thread->remaining_time > 0)) {
     5c2:	fd843783          	ld	a5,-40(s0)
     5c6:	47fc                	lw	a5,76(a5)
     5c8:	02f05963          	blez	a5,5fa <switch_handler+0xdc>
        printf("thread#%d misses a deadline at %d\n", current_thread->ID, threading_system_time);
     5cc:	fd843783          	ld	a5,-40(s0)
     5d0:	5398                	lw	a4,32(a5)
     5d2:	00002797          	auipc	a5,0x2
     5d6:	b1678793          	addi	a5,a5,-1258 # 20e8 <threading_system_time>
     5da:	439c                	lw	a5,0(a5)
     5dc:	863e                	mv	a2,a5
     5de:	85ba                	mv	a1,a4
     5e0:	00002517          	auipc	a0,0x2
     5e4:	a0050513          	addi	a0,a0,-1536 # 1fe0 <schedule_rm+0x3d0>
     5e8:	00001097          	auipc	ra,0x1
     5ec:	dee080e7          	jalr	-530(ra) # 13d6 <printf>
        exit(0);
     5f0:	4501                	li	a0,0
     5f2:	00001097          	auipc	ra,0x1
     5f6:	89e080e7          	jalr	-1890(ra) # e90 <exit>
    }

    if (current_thread->remaining_time <= 0) {
     5fa:	fd843783          	ld	a5,-40(s0)
     5fe:	47fc                	lw	a5,76(a5)
     600:	00f04663          	bgtz	a5,60c <switch_handler+0xee>
        __finish_current();
     604:	00000097          	auipc	ra,0x0
     608:	e56080e7          	jalr	-426(ra) # 45a <__finish_current>
    }

    __release();
     60c:	00000097          	auipc	ra,0x0
     610:	c46080e7          	jalr	-954(ra) # 252 <__release>
    __schedule();
     614:	00000097          	auipc	ra,0x0
     618:	1b6080e7          	jalr	438(ra) # 7ca <__schedule>
    __dispatch();
     61c:	00000097          	auipc	ra,0x0
     620:	026080e7          	jalr	38(ra) # 642 <__dispatch>
    thrdresume(main_thrd_id);
     624:	00002797          	auipc	a5,0x2
     628:	ab078793          	addi	a5,a5,-1360 # 20d4 <main_thrd_id>
     62c:	439c                	lw	a5,0(a5)
     62e:	853e                	mv	a0,a5
     630:	00001097          	auipc	ra,0x1
     634:	908080e7          	jalr	-1784(ra) # f38 <thrdresume>
}
     638:	0001                	nop
     63a:	70e2                	ld	ra,56(sp)
     63c:	7442                	ld	s0,48(sp)
     63e:	6121                	addi	sp,sp,64
     640:	8082                	ret

0000000000000642 <__dispatch>:

void __dispatch()
{
     642:	7179                	addi	sp,sp,-48
     644:	f406                	sd	ra,40(sp)
     646:	f022                	sd	s0,32(sp)
     648:	1800                	addi	s0,sp,48
    if (current == &run_queue) {
     64a:	00002797          	auipc	a5,0x2
     64e:	a9678793          	addi	a5,a5,-1386 # 20e0 <current>
     652:	6398                	ld	a4,0(a5)
     654:	00002797          	auipc	a5,0x2
     658:	a4c78793          	addi	a5,a5,-1460 # 20a0 <run_queue>
     65c:	16f70263          	beq	a4,a5,7c0 <__dispatch+0x17e>
    if (allocated_time < 0) {
        fprintf(2, "[FATAL] allocated_time is negative\n");
        exit(1);
    }

    struct thread *current_thread = list_entry(current, struct thread, thread_list);
     660:	00002797          	auipc	a5,0x2
     664:	a8078793          	addi	a5,a5,-1408 # 20e0 <current>
     668:	639c                	ld	a5,0(a5)
     66a:	fef43423          	sd	a5,-24(s0)
     66e:	fe843783          	ld	a5,-24(s0)
     672:	fd878793          	addi	a5,a5,-40
     676:	fef43023          	sd	a5,-32(s0)
     if (allocated_time == 0) { // miss deadline, abort
     67a:	00002797          	auipc	a5,0x2
     67e:	a7678793          	addi	a5,a5,-1418 # 20f0 <allocated_time>
     682:	639c                	ld	a5,0(a5)
     684:	e795                	bnez	a5,6b0 <__dispatch+0x6e>
        printf("thread#%d misses a deadline at %d\n", current_thread->ID, current_thread->current_deadline);
     686:	fe043783          	ld	a5,-32(s0)
     68a:	5398                	lw	a4,32(a5)
     68c:	fe043783          	ld	a5,-32(s0)
     690:	4bbc                	lw	a5,80(a5)
     692:	863e                	mv	a2,a5
     694:	85ba                	mv	a1,a4
     696:	00002517          	auipc	a0,0x2
     69a:	94a50513          	addi	a0,a0,-1718 # 1fe0 <schedule_rm+0x3d0>
     69e:	00001097          	auipc	ra,0x1
     6a2:	d38080e7          	jalr	-712(ra) # 13d6 <printf>
        exit(0);
     6a6:	4501                	li	a0,0
     6a8:	00000097          	auipc	ra,0x0
     6ac:	7e8080e7          	jalr	2024(ra) # e90 <exit>
    }

    printf("dispatch thread#%d at %d: allocated_time=%d\n", current_thread->ID, threading_system_time, allocated_time);
     6b0:	fe043783          	ld	a5,-32(s0)
     6b4:	5398                	lw	a4,32(a5)
     6b6:	00002797          	auipc	a5,0x2
     6ba:	a3278793          	addi	a5,a5,-1486 # 20e8 <threading_system_time>
     6be:	4390                	lw	a2,0(a5)
     6c0:	00002797          	auipc	a5,0x2
     6c4:	a3078793          	addi	a5,a5,-1488 # 20f0 <allocated_time>
     6c8:	639c                	ld	a5,0(a5)
     6ca:	86be                	mv	a3,a5
     6cc:	85ba                	mv	a1,a4
     6ce:	00002517          	auipc	a0,0x2
     6d2:	93a50513          	addi	a0,a0,-1734 # 2008 <schedule_rm+0x3f8>
     6d6:	00001097          	auipc	ra,0x1
     6da:	d00080e7          	jalr	-768(ra) # 13d6 <printf>

    if (current_thread->buf_set) {
     6de:	fe043783          	ld	a5,-32(s0)
     6e2:	5f9c                	lw	a5,56(a5)
     6e4:	c7a1                	beqz	a5,72c <__dispatch+0xea>
        thrdstop(allocated_time, &(current_thread->thrdstop_context_id), switch_handler, (void *)allocated_time);
     6e6:	00002797          	auipc	a5,0x2
     6ea:	a0a78793          	addi	a5,a5,-1526 # 20f0 <allocated_time>
     6ee:	639c                	ld	a5,0(a5)
     6f0:	0007871b          	sext.w	a4,a5
     6f4:	fe043783          	ld	a5,-32(s0)
     6f8:	03c78593          	addi	a1,a5,60
     6fc:	00002797          	auipc	a5,0x2
     700:	9f478793          	addi	a5,a5,-1548 # 20f0 <allocated_time>
     704:	639c                	ld	a5,0(a5)
     706:	86be                	mv	a3,a5
     708:	00000617          	auipc	a2,0x0
     70c:	e1660613          	addi	a2,a2,-490 # 51e <switch_handler>
     710:	853a                	mv	a0,a4
     712:	00001097          	auipc	ra,0x1
     716:	81e080e7          	jalr	-2018(ra) # f30 <thrdstop>
        thrdresume(current_thread->thrdstop_context_id);
     71a:	fe043783          	ld	a5,-32(s0)
     71e:	5fdc                	lw	a5,60(a5)
     720:	853e                	mv	a0,a5
     722:	00001097          	auipc	ra,0x1
     726:	816080e7          	jalr	-2026(ra) # f38 <thrdresume>
     72a:	a071                	j	7b6 <__dispatch+0x174>
    } else {
        current_thread->buf_set = 1;
     72c:	fe043783          	ld	a5,-32(s0)
     730:	4705                	li	a4,1
     732:	df98                	sw	a4,56(a5)
        unsigned long new_stack_p = (unsigned long)current_thread->stack_p;
     734:	fe043783          	ld	a5,-32(s0)
     738:	6f9c                	ld	a5,24(a5)
     73a:	fcf43c23          	sd	a5,-40(s0)
        current_thread->thrdstop_context_id = -1;
     73e:	fe043783          	ld	a5,-32(s0)
     742:	577d                	li	a4,-1
     744:	dfd8                	sw	a4,60(a5)
        thrdstop(allocated_time, &(current_thread->thrdstop_context_id), switch_handler, (void *)allocated_time);
     746:	00002797          	auipc	a5,0x2
     74a:	9aa78793          	addi	a5,a5,-1622 # 20f0 <allocated_time>
     74e:	639c                	ld	a5,0(a5)
     750:	0007871b          	sext.w	a4,a5
     754:	fe043783          	ld	a5,-32(s0)
     758:	03c78593          	addi	a1,a5,60
     75c:	00002797          	auipc	a5,0x2
     760:	99478793          	addi	a5,a5,-1644 # 20f0 <allocated_time>
     764:	639c                	ld	a5,0(a5)
     766:	86be                	mv	a3,a5
     768:	00000617          	auipc	a2,0x0
     76c:	db660613          	addi	a2,a2,-586 # 51e <switch_handler>
     770:	853a                	mv	a0,a4
     772:	00000097          	auipc	ra,0x0
     776:	7be080e7          	jalr	1982(ra) # f30 <thrdstop>
        if (current_thread->thrdstop_context_id < 0) {
     77a:	fe043783          	ld	a5,-32(s0)
     77e:	5fdc                	lw	a5,60(a5)
     780:	0207d063          	bgez	a5,7a0 <__dispatch+0x15e>
            fprintf(2, "[ERROR] number of threads may exceed MAX_THRD_NUM\n");
     784:	00002597          	auipc	a1,0x2
     788:	8b458593          	addi	a1,a1,-1868 # 2038 <schedule_rm+0x428>
     78c:	4509                	li	a0,2
     78e:	00001097          	auipc	ra,0x1
     792:	bf0080e7          	jalr	-1040(ra) # 137e <fprintf>
            exit(1);
     796:	4505                	li	a0,1
     798:	00000097          	auipc	ra,0x0
     79c:	6f8080e7          	jalr	1784(ra) # e90 <exit>
        }

        // set sp to stack pointer of current thread.
        asm volatile("mv sp, %0"
     7a0:	fd843783          	ld	a5,-40(s0)
     7a4:	813e                	mv	sp,a5
                     :
                     : "r"(new_stack_p));
        current_thread->fp(current_thread->arg);
     7a6:	fe043783          	ld	a5,-32(s0)
     7aa:	6398                	ld	a4,0(a5)
     7ac:	fe043783          	ld	a5,-32(s0)
     7b0:	679c                	ld	a5,8(a5)
     7b2:	853e                	mv	a0,a5
     7b4:	9702                	jalr	a4
    }
    thread_exit();
     7b6:	00000097          	auipc	ra,0x0
     7ba:	bfc080e7          	jalr	-1028(ra) # 3b2 <thread_exit>
     7be:	a011                	j	7c2 <__dispatch+0x180>
        return;
     7c0:	0001                	nop
}
     7c2:	70a2                	ld	ra,40(sp)
     7c4:	7402                	ld	s0,32(sp)
     7c6:	6145                	addi	sp,sp,48
     7c8:	8082                	ret

00000000000007ca <__schedule>:

void __schedule(void)
{
     7ca:	711d                	addi	sp,sp,-96
     7cc:	ec86                	sd	ra,88(sp)
     7ce:	e8a2                	sd	s0,80(sp)
     7d0:	1080                	addi	s0,sp,96
    struct threads_sched_args args = {
     7d2:	00002797          	auipc	a5,0x2
     7d6:	91678793          	addi	a5,a5,-1770 # 20e8 <threading_system_time>
     7da:	439c                	lw	a5,0(a5)
     7dc:	fcf42c23          	sw	a5,-40(s0)
     7e0:	00002797          	auipc	a5,0x2
     7e4:	8c078793          	addi	a5,a5,-1856 # 20a0 <run_queue>
     7e8:	fef43023          	sd	a5,-32(s0)
     7ec:	00002797          	auipc	a5,0x2
     7f0:	8c478793          	addi	a5,a5,-1852 # 20b0 <release_queue>
     7f4:	fef43423          	sd	a5,-24(s0)
    };

    struct threads_sched_result r;

#ifdef THREAD_SCHEDULER_DEFAULT
    r = schedule_default(args);
     7f8:	fd843783          	ld	a5,-40(s0)
     7fc:	faf43023          	sd	a5,-96(s0)
     800:	fe043783          	ld	a5,-32(s0)
     804:	faf43423          	sd	a5,-88(s0)
     808:	fe843783          	ld	a5,-24(s0)
     80c:	faf43823          	sd	a5,-80(s0)
     810:	fa040793          	addi	a5,s0,-96
     814:	853e                	mv	a0,a5
     816:	00001097          	auipc	ra,0x1
     81a:	f90080e7          	jalr	-112(ra) # 17a6 <schedule_default>
     81e:	872a                	mv	a4,a0
     820:	87ae                	mv	a5,a1
     822:	fce43423          	sd	a4,-56(s0)
     826:	fcf43823          	sd	a5,-48(s0)

#ifdef THREAD_SCHEDULER_RM
    r = schedule_rm(args);
#endif

    current = r.scheduled_thread_list_member;
     82a:	fc843703          	ld	a4,-56(s0)
     82e:	00002797          	auipc	a5,0x2
     832:	8b278793          	addi	a5,a5,-1870 # 20e0 <current>
     836:	e398                	sd	a4,0(a5)
    allocated_time = r.allocated_time;
     838:	fd042783          	lw	a5,-48(s0)
     83c:	873e                	mv	a4,a5
     83e:	00002797          	auipc	a5,0x2
     842:	8b278793          	addi	a5,a5,-1870 # 20f0 <allocated_time>
     846:	e398                	sd	a4,0(a5)
}
     848:	0001                	nop
     84a:	60e6                	ld	ra,88(sp)
     84c:	6446                	ld	s0,80(sp)
     84e:	6125                	addi	sp,sp,96
     850:	8082                	ret

0000000000000852 <back_to_main_handler>:

void back_to_main_handler(void *arg)
{
     852:	1101                	addi	sp,sp,-32
     854:	ec06                	sd	ra,24(sp)
     856:	e822                	sd	s0,16(sp)
     858:	1000                	addi	s0,sp,32
     85a:	fea43423          	sd	a0,-24(s0)
    sleeping = 0;
     85e:	00002797          	auipc	a5,0x2
     862:	88e78793          	addi	a5,a5,-1906 # 20ec <sleeping>
     866:	0007a023          	sw	zero,0(a5)
    threading_system_time += (uint64)arg;
     86a:	fe843783          	ld	a5,-24(s0)
     86e:	0007871b          	sext.w	a4,a5
     872:	00002797          	auipc	a5,0x2
     876:	87678793          	addi	a5,a5,-1930 # 20e8 <threading_system_time>
     87a:	439c                	lw	a5,0(a5)
     87c:	2781                	sext.w	a5,a5
     87e:	9fb9                	addw	a5,a5,a4
     880:	2781                	sext.w	a5,a5
     882:	0007871b          	sext.w	a4,a5
     886:	00002797          	auipc	a5,0x2
     88a:	86278793          	addi	a5,a5,-1950 # 20e8 <threading_system_time>
     88e:	c398                	sw	a4,0(a5)
    thrdresume(main_thrd_id);
     890:	00002797          	auipc	a5,0x2
     894:	84478793          	addi	a5,a5,-1980 # 20d4 <main_thrd_id>
     898:	439c                	lw	a5,0(a5)
     89a:	853e                	mv	a0,a5
     89c:	00000097          	auipc	ra,0x0
     8a0:	69c080e7          	jalr	1692(ra) # f38 <thrdresume>
}
     8a4:	0001                	nop
     8a6:	60e2                	ld	ra,24(sp)
     8a8:	6442                	ld	s0,16(sp)
     8aa:	6105                	addi	sp,sp,32
     8ac:	8082                	ret

00000000000008ae <thread_start_threading>:

void thread_start_threading()
{
     8ae:	1141                	addi	sp,sp,-16
     8b0:	e406                	sd	ra,8(sp)
     8b2:	e022                	sd	s0,0(sp)
     8b4:	0800                	addi	s0,sp,16
    threading_system_time = 0;
     8b6:	00002797          	auipc	a5,0x2
     8ba:	83278793          	addi	a5,a5,-1998 # 20e8 <threading_system_time>
     8be:	0007a023          	sw	zero,0(a5)
    current = &run_queue;
     8c2:	00002797          	auipc	a5,0x2
     8c6:	81e78793          	addi	a5,a5,-2018 # 20e0 <current>
     8ca:	00001717          	auipc	a4,0x1
     8ce:	7d670713          	addi	a4,a4,2006 # 20a0 <run_queue>
     8d2:	e398                	sd	a4,0(a5)

    // call thrdstop just for obtain an ID
    thrdstop(1000, &main_thrd_id, back_to_main_handler, (void *)0);
     8d4:	4681                	li	a3,0
     8d6:	00000617          	auipc	a2,0x0
     8da:	f7c60613          	addi	a2,a2,-132 # 852 <back_to_main_handler>
     8de:	00001597          	auipc	a1,0x1
     8e2:	7f658593          	addi	a1,a1,2038 # 20d4 <main_thrd_id>
     8e6:	3e800513          	li	a0,1000
     8ea:	00000097          	auipc	ra,0x0
     8ee:	646080e7          	jalr	1606(ra) # f30 <thrdstop>
    cancelthrdstop(main_thrd_id, 0);
     8f2:	00001797          	auipc	a5,0x1
     8f6:	7e278793          	addi	a5,a5,2018 # 20d4 <main_thrd_id>
     8fa:	439c                	lw	a5,0(a5)
     8fc:	4581                	li	a1,0
     8fe:	853e                	mv	a0,a5
     900:	00000097          	auipc	ra,0x0
     904:	640080e7          	jalr	1600(ra) # f40 <cancelthrdstop>

    while (!list_empty(&run_queue) || !list_empty(&release_queue)) {
     908:	a0c9                	j	9ca <thread_start_threading+0x11c>
        __release();
     90a:	00000097          	auipc	ra,0x0
     90e:	948080e7          	jalr	-1720(ra) # 252 <__release>
        __schedule();
     912:	00000097          	auipc	ra,0x0
     916:	eb8080e7          	jalr	-328(ra) # 7ca <__schedule>
        cancelthrdstop(main_thrd_id, 0);
     91a:	00001797          	auipc	a5,0x1
     91e:	7ba78793          	addi	a5,a5,1978 # 20d4 <main_thrd_id>
     922:	439c                	lw	a5,0(a5)
     924:	4581                	li	a1,0
     926:	853e                	mv	a0,a5
     928:	00000097          	auipc	ra,0x0
     92c:	618080e7          	jalr	1560(ra) # f40 <cancelthrdstop>
        __dispatch();
     930:	00000097          	auipc	ra,0x0
     934:	d12080e7          	jalr	-750(ra) # 642 <__dispatch>

        if (list_empty(&run_queue) && list_empty(&release_queue)) {
     938:	00001517          	auipc	a0,0x1
     93c:	76850513          	addi	a0,a0,1896 # 20a0 <run_queue>
     940:	fffff097          	auipc	ra,0xfffff
     944:	7a8080e7          	jalr	1960(ra) # e8 <list_empty>
     948:	87aa                	mv	a5,a0
     94a:	cb99                	beqz	a5,960 <thread_start_threading+0xb2>
     94c:	00001517          	auipc	a0,0x1
     950:	76450513          	addi	a0,a0,1892 # 20b0 <release_queue>
     954:	fffff097          	auipc	ra,0xfffff
     958:	794080e7          	jalr	1940(ra) # e8 <list_empty>
     95c:	87aa                	mv	a5,a0
     95e:	ebd9                	bnez	a5,9f4 <thread_start_threading+0x146>
            break;
        }

        // no thread in run_queue, release_queue not empty
        printf("run_queue is empty, sleep for %d ticks\n", allocated_time);
     960:	00001797          	auipc	a5,0x1
     964:	79078793          	addi	a5,a5,1936 # 20f0 <allocated_time>
     968:	639c                	ld	a5,0(a5)
     96a:	85be                	mv	a1,a5
     96c:	00001517          	auipc	a0,0x1
     970:	70450513          	addi	a0,a0,1796 # 2070 <schedule_rm+0x460>
     974:	00001097          	auipc	ra,0x1
     978:	a62080e7          	jalr	-1438(ra) # 13d6 <printf>
        sleeping = 1;
     97c:	00001797          	auipc	a5,0x1
     980:	77078793          	addi	a5,a5,1904 # 20ec <sleeping>
     984:	4705                	li	a4,1
     986:	c398                	sw	a4,0(a5)
        thrdstop(allocated_time, &main_thrd_id, back_to_main_handler, (void *)allocated_time);
     988:	00001797          	auipc	a5,0x1
     98c:	76878793          	addi	a5,a5,1896 # 20f0 <allocated_time>
     990:	639c                	ld	a5,0(a5)
     992:	0007871b          	sext.w	a4,a5
     996:	00001797          	auipc	a5,0x1
     99a:	75a78793          	addi	a5,a5,1882 # 20f0 <allocated_time>
     99e:	639c                	ld	a5,0(a5)
     9a0:	86be                	mv	a3,a5
     9a2:	00000617          	auipc	a2,0x0
     9a6:	eb060613          	addi	a2,a2,-336 # 852 <back_to_main_handler>
     9aa:	00001597          	auipc	a1,0x1
     9ae:	72a58593          	addi	a1,a1,1834 # 20d4 <main_thrd_id>
     9b2:	853a                	mv	a0,a4
     9b4:	00000097          	auipc	ra,0x0
     9b8:	57c080e7          	jalr	1404(ra) # f30 <thrdstop>
        while (sleeping) {
     9bc:	0001                	nop
     9be:	00001797          	auipc	a5,0x1
     9c2:	72e78793          	addi	a5,a5,1838 # 20ec <sleeping>
     9c6:	439c                	lw	a5,0(a5)
     9c8:	fbfd                	bnez	a5,9be <thread_start_threading+0x110>
    while (!list_empty(&run_queue) || !list_empty(&release_queue)) {
     9ca:	00001517          	auipc	a0,0x1
     9ce:	6d650513          	addi	a0,a0,1750 # 20a0 <run_queue>
     9d2:	fffff097          	auipc	ra,0xfffff
     9d6:	716080e7          	jalr	1814(ra) # e8 <list_empty>
     9da:	87aa                	mv	a5,a0
     9dc:	d79d                	beqz	a5,90a <thread_start_threading+0x5c>
     9de:	00001517          	auipc	a0,0x1
     9e2:	6d250513          	addi	a0,a0,1746 # 20b0 <release_queue>
     9e6:	fffff097          	auipc	ra,0xfffff
     9ea:	702080e7          	jalr	1794(ra) # e8 <list_empty>
     9ee:	87aa                	mv	a5,a0
     9f0:	df89                	beqz	a5,90a <thread_start_threading+0x5c>
            // zzz...
        }
    }
}
     9f2:	a011                	j	9f6 <thread_start_threading+0x148>
            break;
     9f4:	0001                	nop
}
     9f6:	0001                	nop
     9f8:	60a2                	ld	ra,8(sp)
     9fa:	6402                	ld	s0,0(sp)
     9fc:	0141                	addi	sp,sp,16
     9fe:	8082                	ret

0000000000000a00 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
     a00:	7179                	addi	sp,sp,-48
     a02:	f422                	sd	s0,40(sp)
     a04:	1800                	addi	s0,sp,48
     a06:	fca43c23          	sd	a0,-40(s0)
     a0a:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
     a0e:	fd843783          	ld	a5,-40(s0)
     a12:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
     a16:	0001                	nop
     a18:	fd043703          	ld	a4,-48(s0)
     a1c:	00170793          	addi	a5,a4,1
     a20:	fcf43823          	sd	a5,-48(s0)
     a24:	fd843783          	ld	a5,-40(s0)
     a28:	00178693          	addi	a3,a5,1
     a2c:	fcd43c23          	sd	a3,-40(s0)
     a30:	00074703          	lbu	a4,0(a4)
     a34:	00e78023          	sb	a4,0(a5)
     a38:	0007c783          	lbu	a5,0(a5)
     a3c:	fff1                	bnez	a5,a18 <strcpy+0x18>
    ;
  return os;
     a3e:	fe843783          	ld	a5,-24(s0)
}
     a42:	853e                	mv	a0,a5
     a44:	7422                	ld	s0,40(sp)
     a46:	6145                	addi	sp,sp,48
     a48:	8082                	ret

0000000000000a4a <strcmp>:

int
strcmp(const char *p, const char *q)
{
     a4a:	1101                	addi	sp,sp,-32
     a4c:	ec22                	sd	s0,24(sp)
     a4e:	1000                	addi	s0,sp,32
     a50:	fea43423          	sd	a0,-24(s0)
     a54:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
     a58:	a819                	j	a6e <strcmp+0x24>
    p++, q++;
     a5a:	fe843783          	ld	a5,-24(s0)
     a5e:	0785                	addi	a5,a5,1
     a60:	fef43423          	sd	a5,-24(s0)
     a64:	fe043783          	ld	a5,-32(s0)
     a68:	0785                	addi	a5,a5,1
     a6a:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
     a6e:	fe843783          	ld	a5,-24(s0)
     a72:	0007c783          	lbu	a5,0(a5)
     a76:	cb99                	beqz	a5,a8c <strcmp+0x42>
     a78:	fe843783          	ld	a5,-24(s0)
     a7c:	0007c703          	lbu	a4,0(a5)
     a80:	fe043783          	ld	a5,-32(s0)
     a84:	0007c783          	lbu	a5,0(a5)
     a88:	fcf709e3          	beq	a4,a5,a5a <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
     a8c:	fe843783          	ld	a5,-24(s0)
     a90:	0007c783          	lbu	a5,0(a5)
     a94:	0007871b          	sext.w	a4,a5
     a98:	fe043783          	ld	a5,-32(s0)
     a9c:	0007c783          	lbu	a5,0(a5)
     aa0:	2781                	sext.w	a5,a5
     aa2:	40f707bb          	subw	a5,a4,a5
     aa6:	2781                	sext.w	a5,a5
}
     aa8:	853e                	mv	a0,a5
     aaa:	6462                	ld	s0,24(sp)
     aac:	6105                	addi	sp,sp,32
     aae:	8082                	ret

0000000000000ab0 <strlen>:

uint
strlen(const char *s)
{
     ab0:	7179                	addi	sp,sp,-48
     ab2:	f422                	sd	s0,40(sp)
     ab4:	1800                	addi	s0,sp,48
     ab6:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
     aba:	fe042623          	sw	zero,-20(s0)
     abe:	a031                	j	aca <strlen+0x1a>
     ac0:	fec42783          	lw	a5,-20(s0)
     ac4:	2785                	addiw	a5,a5,1
     ac6:	fef42623          	sw	a5,-20(s0)
     aca:	fec42783          	lw	a5,-20(s0)
     ace:	fd843703          	ld	a4,-40(s0)
     ad2:	97ba                	add	a5,a5,a4
     ad4:	0007c783          	lbu	a5,0(a5)
     ad8:	f7e5                	bnez	a5,ac0 <strlen+0x10>
    ;
  return n;
     ada:	fec42783          	lw	a5,-20(s0)
}
     ade:	853e                	mv	a0,a5
     ae0:	7422                	ld	s0,40(sp)
     ae2:	6145                	addi	sp,sp,48
     ae4:	8082                	ret

0000000000000ae6 <memset>:

void*
memset(void *dst, int c, uint n)
{
     ae6:	7179                	addi	sp,sp,-48
     ae8:	f422                	sd	s0,40(sp)
     aea:	1800                	addi	s0,sp,48
     aec:	fca43c23          	sd	a0,-40(s0)
     af0:	87ae                	mv	a5,a1
     af2:	8732                	mv	a4,a2
     af4:	fcf42a23          	sw	a5,-44(s0)
     af8:	87ba                	mv	a5,a4
     afa:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
     afe:	fd843783          	ld	a5,-40(s0)
     b02:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
     b06:	fe042623          	sw	zero,-20(s0)
     b0a:	a00d                	j	b2c <memset+0x46>
    cdst[i] = c;
     b0c:	fec42783          	lw	a5,-20(s0)
     b10:	fe043703          	ld	a4,-32(s0)
     b14:	97ba                	add	a5,a5,a4
     b16:	fd442703          	lw	a4,-44(s0)
     b1a:	0ff77713          	andi	a4,a4,255
     b1e:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
     b22:	fec42783          	lw	a5,-20(s0)
     b26:	2785                	addiw	a5,a5,1
     b28:	fef42623          	sw	a5,-20(s0)
     b2c:	fec42703          	lw	a4,-20(s0)
     b30:	fd042783          	lw	a5,-48(s0)
     b34:	2781                	sext.w	a5,a5
     b36:	fcf76be3          	bltu	a4,a5,b0c <memset+0x26>
  }
  return dst;
     b3a:	fd843783          	ld	a5,-40(s0)
}
     b3e:	853e                	mv	a0,a5
     b40:	7422                	ld	s0,40(sp)
     b42:	6145                	addi	sp,sp,48
     b44:	8082                	ret

0000000000000b46 <strchr>:

char*
strchr(const char *s, char c)
{
     b46:	1101                	addi	sp,sp,-32
     b48:	ec22                	sd	s0,24(sp)
     b4a:	1000                	addi	s0,sp,32
     b4c:	fea43423          	sd	a0,-24(s0)
     b50:	87ae                	mv	a5,a1
     b52:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
     b56:	a01d                	j	b7c <strchr+0x36>
    if(*s == c)
     b58:	fe843783          	ld	a5,-24(s0)
     b5c:	0007c703          	lbu	a4,0(a5)
     b60:	fe744783          	lbu	a5,-25(s0)
     b64:	0ff7f793          	andi	a5,a5,255
     b68:	00e79563          	bne	a5,a4,b72 <strchr+0x2c>
      return (char*)s;
     b6c:	fe843783          	ld	a5,-24(s0)
     b70:	a821                	j	b88 <strchr+0x42>
  for(; *s; s++)
     b72:	fe843783          	ld	a5,-24(s0)
     b76:	0785                	addi	a5,a5,1
     b78:	fef43423          	sd	a5,-24(s0)
     b7c:	fe843783          	ld	a5,-24(s0)
     b80:	0007c783          	lbu	a5,0(a5)
     b84:	fbf1                	bnez	a5,b58 <strchr+0x12>
  return 0;
     b86:	4781                	li	a5,0
}
     b88:	853e                	mv	a0,a5
     b8a:	6462                	ld	s0,24(sp)
     b8c:	6105                	addi	sp,sp,32
     b8e:	8082                	ret

0000000000000b90 <gets>:

char*
gets(char *buf, int max)
{
     b90:	7179                	addi	sp,sp,-48
     b92:	f406                	sd	ra,40(sp)
     b94:	f022                	sd	s0,32(sp)
     b96:	1800                	addi	s0,sp,48
     b98:	fca43c23          	sd	a0,-40(s0)
     b9c:	87ae                	mv	a5,a1
     b9e:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     ba2:	fe042623          	sw	zero,-20(s0)
     ba6:	a8a1                	j	bfe <gets+0x6e>
    cc = read(0, &c, 1);
     ba8:	fe740793          	addi	a5,s0,-25
     bac:	4605                	li	a2,1
     bae:	85be                	mv	a1,a5
     bb0:	4501                	li	a0,0
     bb2:	00000097          	auipc	ra,0x0
     bb6:	2f6080e7          	jalr	758(ra) # ea8 <read>
     bba:	87aa                	mv	a5,a0
     bbc:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
     bc0:	fe842783          	lw	a5,-24(s0)
     bc4:	2781                	sext.w	a5,a5
     bc6:	04f05763          	blez	a5,c14 <gets+0x84>
      break;
    buf[i++] = c;
     bca:	fec42783          	lw	a5,-20(s0)
     bce:	0017871b          	addiw	a4,a5,1
     bd2:	fee42623          	sw	a4,-20(s0)
     bd6:	873e                	mv	a4,a5
     bd8:	fd843783          	ld	a5,-40(s0)
     bdc:	97ba                	add	a5,a5,a4
     bde:	fe744703          	lbu	a4,-25(s0)
     be2:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
     be6:	fe744783          	lbu	a5,-25(s0)
     bea:	873e                	mv	a4,a5
     bec:	47a9                	li	a5,10
     bee:	02f70463          	beq	a4,a5,c16 <gets+0x86>
     bf2:	fe744783          	lbu	a5,-25(s0)
     bf6:	873e                	mv	a4,a5
     bf8:	47b5                	li	a5,13
     bfa:	00f70e63          	beq	a4,a5,c16 <gets+0x86>
  for(i=0; i+1 < max; ){
     bfe:	fec42783          	lw	a5,-20(s0)
     c02:	2785                	addiw	a5,a5,1
     c04:	0007871b          	sext.w	a4,a5
     c08:	fd442783          	lw	a5,-44(s0)
     c0c:	2781                	sext.w	a5,a5
     c0e:	f8f74de3          	blt	a4,a5,ba8 <gets+0x18>
     c12:	a011                	j	c16 <gets+0x86>
      break;
     c14:	0001                	nop
      break;
  }
  buf[i] = '\0';
     c16:	fec42783          	lw	a5,-20(s0)
     c1a:	fd843703          	ld	a4,-40(s0)
     c1e:	97ba                	add	a5,a5,a4
     c20:	00078023          	sb	zero,0(a5)
  return buf;
     c24:	fd843783          	ld	a5,-40(s0)
}
     c28:	853e                	mv	a0,a5
     c2a:	70a2                	ld	ra,40(sp)
     c2c:	7402                	ld	s0,32(sp)
     c2e:	6145                	addi	sp,sp,48
     c30:	8082                	ret

0000000000000c32 <stat>:

int
stat(const char *n, struct stat *st)
{
     c32:	7179                	addi	sp,sp,-48
     c34:	f406                	sd	ra,40(sp)
     c36:	f022                	sd	s0,32(sp)
     c38:	1800                	addi	s0,sp,48
     c3a:	fca43c23          	sd	a0,-40(s0)
     c3e:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     c42:	4581                	li	a1,0
     c44:	fd843503          	ld	a0,-40(s0)
     c48:	00000097          	auipc	ra,0x0
     c4c:	288080e7          	jalr	648(ra) # ed0 <open>
     c50:	87aa                	mv	a5,a0
     c52:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
     c56:	fec42783          	lw	a5,-20(s0)
     c5a:	2781                	sext.w	a5,a5
     c5c:	0007d463          	bgez	a5,c64 <stat+0x32>
    return -1;
     c60:	57fd                	li	a5,-1
     c62:	a035                	j	c8e <stat+0x5c>
  r = fstat(fd, st);
     c64:	fec42783          	lw	a5,-20(s0)
     c68:	fd043583          	ld	a1,-48(s0)
     c6c:	853e                	mv	a0,a5
     c6e:	00000097          	auipc	ra,0x0
     c72:	27a080e7          	jalr	634(ra) # ee8 <fstat>
     c76:	87aa                	mv	a5,a0
     c78:	fef42423          	sw	a5,-24(s0)
  close(fd);
     c7c:	fec42783          	lw	a5,-20(s0)
     c80:	853e                	mv	a0,a5
     c82:	00000097          	auipc	ra,0x0
     c86:	236080e7          	jalr	566(ra) # eb8 <close>
  return r;
     c8a:	fe842783          	lw	a5,-24(s0)
}
     c8e:	853e                	mv	a0,a5
     c90:	70a2                	ld	ra,40(sp)
     c92:	7402                	ld	s0,32(sp)
     c94:	6145                	addi	sp,sp,48
     c96:	8082                	ret

0000000000000c98 <atoi>:

int
atoi(const char *s)
{
     c98:	7179                	addi	sp,sp,-48
     c9a:	f422                	sd	s0,40(sp)
     c9c:	1800                	addi	s0,sp,48
     c9e:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
     ca2:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
     ca6:	a815                	j	cda <atoi+0x42>
    n = n*10 + *s++ - '0';
     ca8:	fec42703          	lw	a4,-20(s0)
     cac:	87ba                	mv	a5,a4
     cae:	0027979b          	slliw	a5,a5,0x2
     cb2:	9fb9                	addw	a5,a5,a4
     cb4:	0017979b          	slliw	a5,a5,0x1
     cb8:	0007871b          	sext.w	a4,a5
     cbc:	fd843783          	ld	a5,-40(s0)
     cc0:	00178693          	addi	a3,a5,1
     cc4:	fcd43c23          	sd	a3,-40(s0)
     cc8:	0007c783          	lbu	a5,0(a5)
     ccc:	2781                	sext.w	a5,a5
     cce:	9fb9                	addw	a5,a5,a4
     cd0:	2781                	sext.w	a5,a5
     cd2:	fd07879b          	addiw	a5,a5,-48
     cd6:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
     cda:	fd843783          	ld	a5,-40(s0)
     cde:	0007c783          	lbu	a5,0(a5)
     ce2:	873e                	mv	a4,a5
     ce4:	02f00793          	li	a5,47
     ce8:	00e7fb63          	bgeu	a5,a4,cfe <atoi+0x66>
     cec:	fd843783          	ld	a5,-40(s0)
     cf0:	0007c783          	lbu	a5,0(a5)
     cf4:	873e                	mv	a4,a5
     cf6:	03900793          	li	a5,57
     cfa:	fae7f7e3          	bgeu	a5,a4,ca8 <atoi+0x10>
  return n;
     cfe:	fec42783          	lw	a5,-20(s0)
}
     d02:	853e                	mv	a0,a5
     d04:	7422                	ld	s0,40(sp)
     d06:	6145                	addi	sp,sp,48
     d08:	8082                	ret

0000000000000d0a <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     d0a:	7139                	addi	sp,sp,-64
     d0c:	fc22                	sd	s0,56(sp)
     d0e:	0080                	addi	s0,sp,64
     d10:	fca43c23          	sd	a0,-40(s0)
     d14:	fcb43823          	sd	a1,-48(s0)
     d18:	87b2                	mv	a5,a2
     d1a:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
     d1e:	fd843783          	ld	a5,-40(s0)
     d22:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
     d26:	fd043783          	ld	a5,-48(s0)
     d2a:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
     d2e:	fe043703          	ld	a4,-32(s0)
     d32:	fe843783          	ld	a5,-24(s0)
     d36:	02e7fc63          	bgeu	a5,a4,d6e <memmove+0x64>
    while(n-- > 0)
     d3a:	a00d                	j	d5c <memmove+0x52>
      *dst++ = *src++;
     d3c:	fe043703          	ld	a4,-32(s0)
     d40:	00170793          	addi	a5,a4,1
     d44:	fef43023          	sd	a5,-32(s0)
     d48:	fe843783          	ld	a5,-24(s0)
     d4c:	00178693          	addi	a3,a5,1
     d50:	fed43423          	sd	a3,-24(s0)
     d54:	00074703          	lbu	a4,0(a4)
     d58:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     d5c:	fcc42783          	lw	a5,-52(s0)
     d60:	fff7871b          	addiw	a4,a5,-1
     d64:	fce42623          	sw	a4,-52(s0)
     d68:	fcf04ae3          	bgtz	a5,d3c <memmove+0x32>
     d6c:	a891                	j	dc0 <memmove+0xb6>
  } else {
    dst += n;
     d6e:	fcc42783          	lw	a5,-52(s0)
     d72:	fe843703          	ld	a4,-24(s0)
     d76:	97ba                	add	a5,a5,a4
     d78:	fef43423          	sd	a5,-24(s0)
    src += n;
     d7c:	fcc42783          	lw	a5,-52(s0)
     d80:	fe043703          	ld	a4,-32(s0)
     d84:	97ba                	add	a5,a5,a4
     d86:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
     d8a:	a01d                	j	db0 <memmove+0xa6>
      *--dst = *--src;
     d8c:	fe043783          	ld	a5,-32(s0)
     d90:	17fd                	addi	a5,a5,-1
     d92:	fef43023          	sd	a5,-32(s0)
     d96:	fe843783          	ld	a5,-24(s0)
     d9a:	17fd                	addi	a5,a5,-1
     d9c:	fef43423          	sd	a5,-24(s0)
     da0:	fe043783          	ld	a5,-32(s0)
     da4:	0007c703          	lbu	a4,0(a5)
     da8:	fe843783          	ld	a5,-24(s0)
     dac:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     db0:	fcc42783          	lw	a5,-52(s0)
     db4:	fff7871b          	addiw	a4,a5,-1
     db8:	fce42623          	sw	a4,-52(s0)
     dbc:	fcf048e3          	bgtz	a5,d8c <memmove+0x82>
  }
  return vdst;
     dc0:	fd843783          	ld	a5,-40(s0)
}
     dc4:	853e                	mv	a0,a5
     dc6:	7462                	ld	s0,56(sp)
     dc8:	6121                	addi	sp,sp,64
     dca:	8082                	ret

0000000000000dcc <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     dcc:	7139                	addi	sp,sp,-64
     dce:	fc22                	sd	s0,56(sp)
     dd0:	0080                	addi	s0,sp,64
     dd2:	fca43c23          	sd	a0,-40(s0)
     dd6:	fcb43823          	sd	a1,-48(s0)
     dda:	87b2                	mv	a5,a2
     ddc:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
     de0:	fd843783          	ld	a5,-40(s0)
     de4:	fef43423          	sd	a5,-24(s0)
     de8:	fd043783          	ld	a5,-48(s0)
     dec:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     df0:	a0a1                	j	e38 <memcmp+0x6c>
    if (*p1 != *p2) {
     df2:	fe843783          	ld	a5,-24(s0)
     df6:	0007c703          	lbu	a4,0(a5)
     dfa:	fe043783          	ld	a5,-32(s0)
     dfe:	0007c783          	lbu	a5,0(a5)
     e02:	02f70163          	beq	a4,a5,e24 <memcmp+0x58>
      return *p1 - *p2;
     e06:	fe843783          	ld	a5,-24(s0)
     e0a:	0007c783          	lbu	a5,0(a5)
     e0e:	0007871b          	sext.w	a4,a5
     e12:	fe043783          	ld	a5,-32(s0)
     e16:	0007c783          	lbu	a5,0(a5)
     e1a:	2781                	sext.w	a5,a5
     e1c:	40f707bb          	subw	a5,a4,a5
     e20:	2781                	sext.w	a5,a5
     e22:	a01d                	j	e48 <memcmp+0x7c>
    }
    p1++;
     e24:	fe843783          	ld	a5,-24(s0)
     e28:	0785                	addi	a5,a5,1
     e2a:	fef43423          	sd	a5,-24(s0)
    p2++;
     e2e:	fe043783          	ld	a5,-32(s0)
     e32:	0785                	addi	a5,a5,1
     e34:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     e38:	fcc42783          	lw	a5,-52(s0)
     e3c:	fff7871b          	addiw	a4,a5,-1
     e40:	fce42623          	sw	a4,-52(s0)
     e44:	f7dd                	bnez	a5,df2 <memcmp+0x26>
  }
  return 0;
     e46:	4781                	li	a5,0
}
     e48:	853e                	mv	a0,a5
     e4a:	7462                	ld	s0,56(sp)
     e4c:	6121                	addi	sp,sp,64
     e4e:	8082                	ret

0000000000000e50 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     e50:	7179                	addi	sp,sp,-48
     e52:	f406                	sd	ra,40(sp)
     e54:	f022                	sd	s0,32(sp)
     e56:	1800                	addi	s0,sp,48
     e58:	fea43423          	sd	a0,-24(s0)
     e5c:	feb43023          	sd	a1,-32(s0)
     e60:	87b2                	mv	a5,a2
     e62:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
     e66:	fdc42783          	lw	a5,-36(s0)
     e6a:	863e                	mv	a2,a5
     e6c:	fe043583          	ld	a1,-32(s0)
     e70:	fe843503          	ld	a0,-24(s0)
     e74:	00000097          	auipc	ra,0x0
     e78:	e96080e7          	jalr	-362(ra) # d0a <memmove>
     e7c:	87aa                	mv	a5,a0
}
     e7e:	853e                	mv	a0,a5
     e80:	70a2                	ld	ra,40(sp)
     e82:	7402                	ld	s0,32(sp)
     e84:	6145                	addi	sp,sp,48
     e86:	8082                	ret

0000000000000e88 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     e88:	4885                	li	a7,1
 ecall
     e8a:	00000073          	ecall
 ret
     e8e:	8082                	ret

0000000000000e90 <exit>:
.global exit
exit:
 li a7, SYS_exit
     e90:	4889                	li	a7,2
 ecall
     e92:	00000073          	ecall
 ret
     e96:	8082                	ret

0000000000000e98 <wait>:
.global wait
wait:
 li a7, SYS_wait
     e98:	488d                	li	a7,3
 ecall
     e9a:	00000073          	ecall
 ret
     e9e:	8082                	ret

0000000000000ea0 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     ea0:	4891                	li	a7,4
 ecall
     ea2:	00000073          	ecall
 ret
     ea6:	8082                	ret

0000000000000ea8 <read>:
.global read
read:
 li a7, SYS_read
     ea8:	4895                	li	a7,5
 ecall
     eaa:	00000073          	ecall
 ret
     eae:	8082                	ret

0000000000000eb0 <write>:
.global write
write:
 li a7, SYS_write
     eb0:	48c1                	li	a7,16
 ecall
     eb2:	00000073          	ecall
 ret
     eb6:	8082                	ret

0000000000000eb8 <close>:
.global close
close:
 li a7, SYS_close
     eb8:	48d5                	li	a7,21
 ecall
     eba:	00000073          	ecall
 ret
     ebe:	8082                	ret

0000000000000ec0 <kill>:
.global kill
kill:
 li a7, SYS_kill
     ec0:	4899                	li	a7,6
 ecall
     ec2:	00000073          	ecall
 ret
     ec6:	8082                	ret

0000000000000ec8 <exec>:
.global exec
exec:
 li a7, SYS_exec
     ec8:	489d                	li	a7,7
 ecall
     eca:	00000073          	ecall
 ret
     ece:	8082                	ret

0000000000000ed0 <open>:
.global open
open:
 li a7, SYS_open
     ed0:	48bd                	li	a7,15
 ecall
     ed2:	00000073          	ecall
 ret
     ed6:	8082                	ret

0000000000000ed8 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     ed8:	48c5                	li	a7,17
 ecall
     eda:	00000073          	ecall
 ret
     ede:	8082                	ret

0000000000000ee0 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     ee0:	48c9                	li	a7,18
 ecall
     ee2:	00000073          	ecall
 ret
     ee6:	8082                	ret

0000000000000ee8 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     ee8:	48a1                	li	a7,8
 ecall
     eea:	00000073          	ecall
 ret
     eee:	8082                	ret

0000000000000ef0 <link>:
.global link
link:
 li a7, SYS_link
     ef0:	48cd                	li	a7,19
 ecall
     ef2:	00000073          	ecall
 ret
     ef6:	8082                	ret

0000000000000ef8 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     ef8:	48d1                	li	a7,20
 ecall
     efa:	00000073          	ecall
 ret
     efe:	8082                	ret

0000000000000f00 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     f00:	48a5                	li	a7,9
 ecall
     f02:	00000073          	ecall
 ret
     f06:	8082                	ret

0000000000000f08 <dup>:
.global dup
dup:
 li a7, SYS_dup
     f08:	48a9                	li	a7,10
 ecall
     f0a:	00000073          	ecall
 ret
     f0e:	8082                	ret

0000000000000f10 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     f10:	48ad                	li	a7,11
 ecall
     f12:	00000073          	ecall
 ret
     f16:	8082                	ret

0000000000000f18 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     f18:	48b1                	li	a7,12
 ecall
     f1a:	00000073          	ecall
 ret
     f1e:	8082                	ret

0000000000000f20 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     f20:	48b5                	li	a7,13
 ecall
     f22:	00000073          	ecall
 ret
     f26:	8082                	ret

0000000000000f28 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     f28:	48b9                	li	a7,14
 ecall
     f2a:	00000073          	ecall
 ret
     f2e:	8082                	ret

0000000000000f30 <thrdstop>:
.global thrdstop
thrdstop:
 li a7, SYS_thrdstop
     f30:	48d9                	li	a7,22
 ecall
     f32:	00000073          	ecall
 ret
     f36:	8082                	ret

0000000000000f38 <thrdresume>:
.global thrdresume
thrdresume:
 li a7, SYS_thrdresume
     f38:	48dd                	li	a7,23
 ecall
     f3a:	00000073          	ecall
 ret
     f3e:	8082                	ret

0000000000000f40 <cancelthrdstop>:
.global cancelthrdstop
cancelthrdstop:
 li a7, SYS_cancelthrdstop
     f40:	48e1                	li	a7,24
 ecall
     f42:	00000073          	ecall
 ret
     f46:	8082                	ret

0000000000000f48 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     f48:	1101                	addi	sp,sp,-32
     f4a:	ec06                	sd	ra,24(sp)
     f4c:	e822                	sd	s0,16(sp)
     f4e:	1000                	addi	s0,sp,32
     f50:	87aa                	mv	a5,a0
     f52:	872e                	mv	a4,a1
     f54:	fef42623          	sw	a5,-20(s0)
     f58:	87ba                	mv	a5,a4
     f5a:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
     f5e:	feb40713          	addi	a4,s0,-21
     f62:	fec42783          	lw	a5,-20(s0)
     f66:	4605                	li	a2,1
     f68:	85ba                	mv	a1,a4
     f6a:	853e                	mv	a0,a5
     f6c:	00000097          	auipc	ra,0x0
     f70:	f44080e7          	jalr	-188(ra) # eb0 <write>
}
     f74:	0001                	nop
     f76:	60e2                	ld	ra,24(sp)
     f78:	6442                	ld	s0,16(sp)
     f7a:	6105                	addi	sp,sp,32
     f7c:	8082                	ret

0000000000000f7e <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     f7e:	7139                	addi	sp,sp,-64
     f80:	fc06                	sd	ra,56(sp)
     f82:	f822                	sd	s0,48(sp)
     f84:	0080                	addi	s0,sp,64
     f86:	87aa                	mv	a5,a0
     f88:	8736                	mv	a4,a3
     f8a:	fcf42623          	sw	a5,-52(s0)
     f8e:	87ae                	mv	a5,a1
     f90:	fcf42423          	sw	a5,-56(s0)
     f94:	87b2                	mv	a5,a2
     f96:	fcf42223          	sw	a5,-60(s0)
     f9a:	87ba                	mv	a5,a4
     f9c:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     fa0:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
     fa4:	fc042783          	lw	a5,-64(s0)
     fa8:	2781                	sext.w	a5,a5
     faa:	c38d                	beqz	a5,fcc <printint+0x4e>
     fac:	fc842783          	lw	a5,-56(s0)
     fb0:	2781                	sext.w	a5,a5
     fb2:	0007dd63          	bgez	a5,fcc <printint+0x4e>
    neg = 1;
     fb6:	4785                	li	a5,1
     fb8:	fef42423          	sw	a5,-24(s0)
    x = -xx;
     fbc:	fc842783          	lw	a5,-56(s0)
     fc0:	40f007bb          	negw	a5,a5
     fc4:	2781                	sext.w	a5,a5
     fc6:	fef42223          	sw	a5,-28(s0)
     fca:	a029                	j	fd4 <printint+0x56>
  } else {
    x = xx;
     fcc:	fc842783          	lw	a5,-56(s0)
     fd0:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
     fd4:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
     fd8:	fc442783          	lw	a5,-60(s0)
     fdc:	fe442703          	lw	a4,-28(s0)
     fe0:	02f777bb          	remuw	a5,a4,a5
     fe4:	0007861b          	sext.w	a2,a5
     fe8:	fec42783          	lw	a5,-20(s0)
     fec:	0017871b          	addiw	a4,a5,1
     ff0:	fee42623          	sw	a4,-20(s0)
     ff4:	00001697          	auipc	a3,0x1
     ff8:	0cc68693          	addi	a3,a3,204 # 20c0 <digits>
     ffc:	02061713          	slli	a4,a2,0x20
    1000:	9301                	srli	a4,a4,0x20
    1002:	9736                	add	a4,a4,a3
    1004:	00074703          	lbu	a4,0(a4)
    1008:	ff040693          	addi	a3,s0,-16
    100c:	97b6                	add	a5,a5,a3
    100e:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
    1012:	fc442783          	lw	a5,-60(s0)
    1016:	fe442703          	lw	a4,-28(s0)
    101a:	02f757bb          	divuw	a5,a4,a5
    101e:	fef42223          	sw	a5,-28(s0)
    1022:	fe442783          	lw	a5,-28(s0)
    1026:	2781                	sext.w	a5,a5
    1028:	fbc5                	bnez	a5,fd8 <printint+0x5a>
  if(neg)
    102a:	fe842783          	lw	a5,-24(s0)
    102e:	2781                	sext.w	a5,a5
    1030:	cf95                	beqz	a5,106c <printint+0xee>
    buf[i++] = '-';
    1032:	fec42783          	lw	a5,-20(s0)
    1036:	0017871b          	addiw	a4,a5,1
    103a:	fee42623          	sw	a4,-20(s0)
    103e:	ff040713          	addi	a4,s0,-16
    1042:	97ba                	add	a5,a5,a4
    1044:	02d00713          	li	a4,45
    1048:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
    104c:	a005                	j	106c <printint+0xee>
    putc(fd, buf[i]);
    104e:	fec42783          	lw	a5,-20(s0)
    1052:	ff040713          	addi	a4,s0,-16
    1056:	97ba                	add	a5,a5,a4
    1058:	fe07c703          	lbu	a4,-32(a5)
    105c:	fcc42783          	lw	a5,-52(s0)
    1060:	85ba                	mv	a1,a4
    1062:	853e                	mv	a0,a5
    1064:	00000097          	auipc	ra,0x0
    1068:	ee4080e7          	jalr	-284(ra) # f48 <putc>
  while(--i >= 0)
    106c:	fec42783          	lw	a5,-20(s0)
    1070:	37fd                	addiw	a5,a5,-1
    1072:	fef42623          	sw	a5,-20(s0)
    1076:	fec42783          	lw	a5,-20(s0)
    107a:	2781                	sext.w	a5,a5
    107c:	fc07d9e3          	bgez	a5,104e <printint+0xd0>
}
    1080:	0001                	nop
    1082:	0001                	nop
    1084:	70e2                	ld	ra,56(sp)
    1086:	7442                	ld	s0,48(sp)
    1088:	6121                	addi	sp,sp,64
    108a:	8082                	ret

000000000000108c <printptr>:

static void
printptr(int fd, uint64 x) {
    108c:	7179                	addi	sp,sp,-48
    108e:	f406                	sd	ra,40(sp)
    1090:	f022                	sd	s0,32(sp)
    1092:	1800                	addi	s0,sp,48
    1094:	87aa                	mv	a5,a0
    1096:	fcb43823          	sd	a1,-48(s0)
    109a:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
    109e:	fdc42783          	lw	a5,-36(s0)
    10a2:	03000593          	li	a1,48
    10a6:	853e                	mv	a0,a5
    10a8:	00000097          	auipc	ra,0x0
    10ac:	ea0080e7          	jalr	-352(ra) # f48 <putc>
  putc(fd, 'x');
    10b0:	fdc42783          	lw	a5,-36(s0)
    10b4:	07800593          	li	a1,120
    10b8:	853e                	mv	a0,a5
    10ba:	00000097          	auipc	ra,0x0
    10be:	e8e080e7          	jalr	-370(ra) # f48 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    10c2:	fe042623          	sw	zero,-20(s0)
    10c6:	a82d                	j	1100 <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    10c8:	fd043783          	ld	a5,-48(s0)
    10cc:	93f1                	srli	a5,a5,0x3c
    10ce:	00001717          	auipc	a4,0x1
    10d2:	ff270713          	addi	a4,a4,-14 # 20c0 <digits>
    10d6:	97ba                	add	a5,a5,a4
    10d8:	0007c703          	lbu	a4,0(a5)
    10dc:	fdc42783          	lw	a5,-36(s0)
    10e0:	85ba                	mv	a1,a4
    10e2:	853e                	mv	a0,a5
    10e4:	00000097          	auipc	ra,0x0
    10e8:	e64080e7          	jalr	-412(ra) # f48 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    10ec:	fec42783          	lw	a5,-20(s0)
    10f0:	2785                	addiw	a5,a5,1
    10f2:	fef42623          	sw	a5,-20(s0)
    10f6:	fd043783          	ld	a5,-48(s0)
    10fa:	0792                	slli	a5,a5,0x4
    10fc:	fcf43823          	sd	a5,-48(s0)
    1100:	fec42783          	lw	a5,-20(s0)
    1104:	873e                	mv	a4,a5
    1106:	47bd                	li	a5,15
    1108:	fce7f0e3          	bgeu	a5,a4,10c8 <printptr+0x3c>
}
    110c:	0001                	nop
    110e:	0001                	nop
    1110:	70a2                	ld	ra,40(sp)
    1112:	7402                	ld	s0,32(sp)
    1114:	6145                	addi	sp,sp,48
    1116:	8082                	ret

0000000000001118 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    1118:	715d                	addi	sp,sp,-80
    111a:	e486                	sd	ra,72(sp)
    111c:	e0a2                	sd	s0,64(sp)
    111e:	0880                	addi	s0,sp,80
    1120:	87aa                	mv	a5,a0
    1122:	fcb43023          	sd	a1,-64(s0)
    1126:	fac43c23          	sd	a2,-72(s0)
    112a:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
    112e:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
    1132:	fe042223          	sw	zero,-28(s0)
    1136:	a42d                	j	1360 <vprintf+0x248>
    c = fmt[i] & 0xff;
    1138:	fe442783          	lw	a5,-28(s0)
    113c:	fc043703          	ld	a4,-64(s0)
    1140:	97ba                	add	a5,a5,a4
    1142:	0007c783          	lbu	a5,0(a5)
    1146:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
    114a:	fe042783          	lw	a5,-32(s0)
    114e:	2781                	sext.w	a5,a5
    1150:	eb9d                	bnez	a5,1186 <vprintf+0x6e>
      if(c == '%'){
    1152:	fdc42783          	lw	a5,-36(s0)
    1156:	0007871b          	sext.w	a4,a5
    115a:	02500793          	li	a5,37
    115e:	00f71763          	bne	a4,a5,116c <vprintf+0x54>
        state = '%';
    1162:	02500793          	li	a5,37
    1166:	fef42023          	sw	a5,-32(s0)
    116a:	a2f5                	j	1356 <vprintf+0x23e>
      } else {
        putc(fd, c);
    116c:	fdc42783          	lw	a5,-36(s0)
    1170:	0ff7f713          	andi	a4,a5,255
    1174:	fcc42783          	lw	a5,-52(s0)
    1178:	85ba                	mv	a1,a4
    117a:	853e                	mv	a0,a5
    117c:	00000097          	auipc	ra,0x0
    1180:	dcc080e7          	jalr	-564(ra) # f48 <putc>
    1184:	aac9                	j	1356 <vprintf+0x23e>
      }
    } else if(state == '%'){
    1186:	fe042783          	lw	a5,-32(s0)
    118a:	0007871b          	sext.w	a4,a5
    118e:	02500793          	li	a5,37
    1192:	1cf71263          	bne	a4,a5,1356 <vprintf+0x23e>
      if(c == 'd'){
    1196:	fdc42783          	lw	a5,-36(s0)
    119a:	0007871b          	sext.w	a4,a5
    119e:	06400793          	li	a5,100
    11a2:	02f71463          	bne	a4,a5,11ca <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
    11a6:	fb843783          	ld	a5,-72(s0)
    11aa:	00878713          	addi	a4,a5,8
    11ae:	fae43c23          	sd	a4,-72(s0)
    11b2:	4398                	lw	a4,0(a5)
    11b4:	fcc42783          	lw	a5,-52(s0)
    11b8:	4685                	li	a3,1
    11ba:	4629                	li	a2,10
    11bc:	85ba                	mv	a1,a4
    11be:	853e                	mv	a0,a5
    11c0:	00000097          	auipc	ra,0x0
    11c4:	dbe080e7          	jalr	-578(ra) # f7e <printint>
    11c8:	a269                	j	1352 <vprintf+0x23a>
      } else if(c == 'l') {
    11ca:	fdc42783          	lw	a5,-36(s0)
    11ce:	0007871b          	sext.w	a4,a5
    11d2:	06c00793          	li	a5,108
    11d6:	02f71663          	bne	a4,a5,1202 <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
    11da:	fb843783          	ld	a5,-72(s0)
    11de:	00878713          	addi	a4,a5,8
    11e2:	fae43c23          	sd	a4,-72(s0)
    11e6:	639c                	ld	a5,0(a5)
    11e8:	0007871b          	sext.w	a4,a5
    11ec:	fcc42783          	lw	a5,-52(s0)
    11f0:	4681                	li	a3,0
    11f2:	4629                	li	a2,10
    11f4:	85ba                	mv	a1,a4
    11f6:	853e                	mv	a0,a5
    11f8:	00000097          	auipc	ra,0x0
    11fc:	d86080e7          	jalr	-634(ra) # f7e <printint>
    1200:	aa89                	j	1352 <vprintf+0x23a>
      } else if(c == 'x') {
    1202:	fdc42783          	lw	a5,-36(s0)
    1206:	0007871b          	sext.w	a4,a5
    120a:	07800793          	li	a5,120
    120e:	02f71463          	bne	a4,a5,1236 <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
    1212:	fb843783          	ld	a5,-72(s0)
    1216:	00878713          	addi	a4,a5,8
    121a:	fae43c23          	sd	a4,-72(s0)
    121e:	4398                	lw	a4,0(a5)
    1220:	fcc42783          	lw	a5,-52(s0)
    1224:	4681                	li	a3,0
    1226:	4641                	li	a2,16
    1228:	85ba                	mv	a1,a4
    122a:	853e                	mv	a0,a5
    122c:	00000097          	auipc	ra,0x0
    1230:	d52080e7          	jalr	-686(ra) # f7e <printint>
    1234:	aa39                	j	1352 <vprintf+0x23a>
      } else if(c == 'p') {
    1236:	fdc42783          	lw	a5,-36(s0)
    123a:	0007871b          	sext.w	a4,a5
    123e:	07000793          	li	a5,112
    1242:	02f71263          	bne	a4,a5,1266 <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
    1246:	fb843783          	ld	a5,-72(s0)
    124a:	00878713          	addi	a4,a5,8
    124e:	fae43c23          	sd	a4,-72(s0)
    1252:	6398                	ld	a4,0(a5)
    1254:	fcc42783          	lw	a5,-52(s0)
    1258:	85ba                	mv	a1,a4
    125a:	853e                	mv	a0,a5
    125c:	00000097          	auipc	ra,0x0
    1260:	e30080e7          	jalr	-464(ra) # 108c <printptr>
    1264:	a0fd                	j	1352 <vprintf+0x23a>
      } else if(c == 's'){
    1266:	fdc42783          	lw	a5,-36(s0)
    126a:	0007871b          	sext.w	a4,a5
    126e:	07300793          	li	a5,115
    1272:	04f71c63          	bne	a4,a5,12ca <vprintf+0x1b2>
        s = va_arg(ap, char*);
    1276:	fb843783          	ld	a5,-72(s0)
    127a:	00878713          	addi	a4,a5,8
    127e:	fae43c23          	sd	a4,-72(s0)
    1282:	639c                	ld	a5,0(a5)
    1284:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
    1288:	fe843783          	ld	a5,-24(s0)
    128c:	eb8d                	bnez	a5,12be <vprintf+0x1a6>
          s = "(null)";
    128e:	00001797          	auipc	a5,0x1
    1292:	e0a78793          	addi	a5,a5,-502 # 2098 <schedule_rm+0x488>
    1296:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
    129a:	a015                	j	12be <vprintf+0x1a6>
          putc(fd, *s);
    129c:	fe843783          	ld	a5,-24(s0)
    12a0:	0007c703          	lbu	a4,0(a5)
    12a4:	fcc42783          	lw	a5,-52(s0)
    12a8:	85ba                	mv	a1,a4
    12aa:	853e                	mv	a0,a5
    12ac:	00000097          	auipc	ra,0x0
    12b0:	c9c080e7          	jalr	-868(ra) # f48 <putc>
          s++;
    12b4:	fe843783          	ld	a5,-24(s0)
    12b8:	0785                	addi	a5,a5,1
    12ba:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
    12be:	fe843783          	ld	a5,-24(s0)
    12c2:	0007c783          	lbu	a5,0(a5)
    12c6:	fbf9                	bnez	a5,129c <vprintf+0x184>
    12c8:	a069                	j	1352 <vprintf+0x23a>
        }
      } else if(c == 'c'){
    12ca:	fdc42783          	lw	a5,-36(s0)
    12ce:	0007871b          	sext.w	a4,a5
    12d2:	06300793          	li	a5,99
    12d6:	02f71463          	bne	a4,a5,12fe <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
    12da:	fb843783          	ld	a5,-72(s0)
    12de:	00878713          	addi	a4,a5,8
    12e2:	fae43c23          	sd	a4,-72(s0)
    12e6:	439c                	lw	a5,0(a5)
    12e8:	0ff7f713          	andi	a4,a5,255
    12ec:	fcc42783          	lw	a5,-52(s0)
    12f0:	85ba                	mv	a1,a4
    12f2:	853e                	mv	a0,a5
    12f4:	00000097          	auipc	ra,0x0
    12f8:	c54080e7          	jalr	-940(ra) # f48 <putc>
    12fc:	a899                	j	1352 <vprintf+0x23a>
      } else if(c == '%'){
    12fe:	fdc42783          	lw	a5,-36(s0)
    1302:	0007871b          	sext.w	a4,a5
    1306:	02500793          	li	a5,37
    130a:	00f71f63          	bne	a4,a5,1328 <vprintf+0x210>
        putc(fd, c);
    130e:	fdc42783          	lw	a5,-36(s0)
    1312:	0ff7f713          	andi	a4,a5,255
    1316:	fcc42783          	lw	a5,-52(s0)
    131a:	85ba                	mv	a1,a4
    131c:	853e                	mv	a0,a5
    131e:	00000097          	auipc	ra,0x0
    1322:	c2a080e7          	jalr	-982(ra) # f48 <putc>
    1326:	a035                	j	1352 <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    1328:	fcc42783          	lw	a5,-52(s0)
    132c:	02500593          	li	a1,37
    1330:	853e                	mv	a0,a5
    1332:	00000097          	auipc	ra,0x0
    1336:	c16080e7          	jalr	-1002(ra) # f48 <putc>
        putc(fd, c);
    133a:	fdc42783          	lw	a5,-36(s0)
    133e:	0ff7f713          	andi	a4,a5,255
    1342:	fcc42783          	lw	a5,-52(s0)
    1346:	85ba                	mv	a1,a4
    1348:	853e                	mv	a0,a5
    134a:	00000097          	auipc	ra,0x0
    134e:	bfe080e7          	jalr	-1026(ra) # f48 <putc>
      }
      state = 0;
    1352:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
    1356:	fe442783          	lw	a5,-28(s0)
    135a:	2785                	addiw	a5,a5,1
    135c:	fef42223          	sw	a5,-28(s0)
    1360:	fe442783          	lw	a5,-28(s0)
    1364:	fc043703          	ld	a4,-64(s0)
    1368:	97ba                	add	a5,a5,a4
    136a:	0007c783          	lbu	a5,0(a5)
    136e:	dc0795e3          	bnez	a5,1138 <vprintf+0x20>
    }
  }
}
    1372:	0001                	nop
    1374:	0001                	nop
    1376:	60a6                	ld	ra,72(sp)
    1378:	6406                	ld	s0,64(sp)
    137a:	6161                	addi	sp,sp,80
    137c:	8082                	ret

000000000000137e <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    137e:	7159                	addi	sp,sp,-112
    1380:	fc06                	sd	ra,56(sp)
    1382:	f822                	sd	s0,48(sp)
    1384:	0080                	addi	s0,sp,64
    1386:	fcb43823          	sd	a1,-48(s0)
    138a:	e010                	sd	a2,0(s0)
    138c:	e414                	sd	a3,8(s0)
    138e:	e818                	sd	a4,16(s0)
    1390:	ec1c                	sd	a5,24(s0)
    1392:	03043023          	sd	a6,32(s0)
    1396:	03143423          	sd	a7,40(s0)
    139a:	87aa                	mv	a5,a0
    139c:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
    13a0:	03040793          	addi	a5,s0,48
    13a4:	fcf43423          	sd	a5,-56(s0)
    13a8:	fc843783          	ld	a5,-56(s0)
    13ac:	fd078793          	addi	a5,a5,-48
    13b0:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
    13b4:	fe843703          	ld	a4,-24(s0)
    13b8:	fdc42783          	lw	a5,-36(s0)
    13bc:	863a                	mv	a2,a4
    13be:	fd043583          	ld	a1,-48(s0)
    13c2:	853e                	mv	a0,a5
    13c4:	00000097          	auipc	ra,0x0
    13c8:	d54080e7          	jalr	-684(ra) # 1118 <vprintf>
}
    13cc:	0001                	nop
    13ce:	70e2                	ld	ra,56(sp)
    13d0:	7442                	ld	s0,48(sp)
    13d2:	6165                	addi	sp,sp,112
    13d4:	8082                	ret

00000000000013d6 <printf>:

void
printf(const char *fmt, ...)
{
    13d6:	7159                	addi	sp,sp,-112
    13d8:	f406                	sd	ra,40(sp)
    13da:	f022                	sd	s0,32(sp)
    13dc:	1800                	addi	s0,sp,48
    13de:	fca43c23          	sd	a0,-40(s0)
    13e2:	e40c                	sd	a1,8(s0)
    13e4:	e810                	sd	a2,16(s0)
    13e6:	ec14                	sd	a3,24(s0)
    13e8:	f018                	sd	a4,32(s0)
    13ea:	f41c                	sd	a5,40(s0)
    13ec:	03043823          	sd	a6,48(s0)
    13f0:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    13f4:	04040793          	addi	a5,s0,64
    13f8:	fcf43823          	sd	a5,-48(s0)
    13fc:	fd043783          	ld	a5,-48(s0)
    1400:	fc878793          	addi	a5,a5,-56
    1404:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
    1408:	fe843783          	ld	a5,-24(s0)
    140c:	863e                	mv	a2,a5
    140e:	fd843583          	ld	a1,-40(s0)
    1412:	4505                	li	a0,1
    1414:	00000097          	auipc	ra,0x0
    1418:	d04080e7          	jalr	-764(ra) # 1118 <vprintf>
}
    141c:	0001                	nop
    141e:	70a2                	ld	ra,40(sp)
    1420:	7402                	ld	s0,32(sp)
    1422:	6165                	addi	sp,sp,112
    1424:	8082                	ret

0000000000001426 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1426:	7179                	addi	sp,sp,-48
    1428:	f422                	sd	s0,40(sp)
    142a:	1800                	addi	s0,sp,48
    142c:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1430:	fd843783          	ld	a5,-40(s0)
    1434:	17c1                	addi	a5,a5,-16
    1436:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    143a:	00001797          	auipc	a5,0x1
    143e:	cce78793          	addi	a5,a5,-818 # 2108 <freep>
    1442:	639c                	ld	a5,0(a5)
    1444:	fef43423          	sd	a5,-24(s0)
    1448:	a815                	j	147c <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    144a:	fe843783          	ld	a5,-24(s0)
    144e:	639c                	ld	a5,0(a5)
    1450:	fe843703          	ld	a4,-24(s0)
    1454:	00f76f63          	bltu	a4,a5,1472 <free+0x4c>
    1458:	fe043703          	ld	a4,-32(s0)
    145c:	fe843783          	ld	a5,-24(s0)
    1460:	02e7eb63          	bltu	a5,a4,1496 <free+0x70>
    1464:	fe843783          	ld	a5,-24(s0)
    1468:	639c                	ld	a5,0(a5)
    146a:	fe043703          	ld	a4,-32(s0)
    146e:	02f76463          	bltu	a4,a5,1496 <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1472:	fe843783          	ld	a5,-24(s0)
    1476:	639c                	ld	a5,0(a5)
    1478:	fef43423          	sd	a5,-24(s0)
    147c:	fe043703          	ld	a4,-32(s0)
    1480:	fe843783          	ld	a5,-24(s0)
    1484:	fce7f3e3          	bgeu	a5,a4,144a <free+0x24>
    1488:	fe843783          	ld	a5,-24(s0)
    148c:	639c                	ld	a5,0(a5)
    148e:	fe043703          	ld	a4,-32(s0)
    1492:	faf77ce3          	bgeu	a4,a5,144a <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1496:	fe043783          	ld	a5,-32(s0)
    149a:	479c                	lw	a5,8(a5)
    149c:	1782                	slli	a5,a5,0x20
    149e:	9381                	srli	a5,a5,0x20
    14a0:	0792                	slli	a5,a5,0x4
    14a2:	fe043703          	ld	a4,-32(s0)
    14a6:	973e                	add	a4,a4,a5
    14a8:	fe843783          	ld	a5,-24(s0)
    14ac:	639c                	ld	a5,0(a5)
    14ae:	02f71763          	bne	a4,a5,14dc <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
    14b2:	fe043783          	ld	a5,-32(s0)
    14b6:	4798                	lw	a4,8(a5)
    14b8:	fe843783          	ld	a5,-24(s0)
    14bc:	639c                	ld	a5,0(a5)
    14be:	479c                	lw	a5,8(a5)
    14c0:	9fb9                	addw	a5,a5,a4
    14c2:	0007871b          	sext.w	a4,a5
    14c6:	fe043783          	ld	a5,-32(s0)
    14ca:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
    14cc:	fe843783          	ld	a5,-24(s0)
    14d0:	639c                	ld	a5,0(a5)
    14d2:	6398                	ld	a4,0(a5)
    14d4:	fe043783          	ld	a5,-32(s0)
    14d8:	e398                	sd	a4,0(a5)
    14da:	a039                	j	14e8 <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
    14dc:	fe843783          	ld	a5,-24(s0)
    14e0:	6398                	ld	a4,0(a5)
    14e2:	fe043783          	ld	a5,-32(s0)
    14e6:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
    14e8:	fe843783          	ld	a5,-24(s0)
    14ec:	479c                	lw	a5,8(a5)
    14ee:	1782                	slli	a5,a5,0x20
    14f0:	9381                	srli	a5,a5,0x20
    14f2:	0792                	slli	a5,a5,0x4
    14f4:	fe843703          	ld	a4,-24(s0)
    14f8:	97ba                	add	a5,a5,a4
    14fa:	fe043703          	ld	a4,-32(s0)
    14fe:	02f71563          	bne	a4,a5,1528 <free+0x102>
    p->s.size += bp->s.size;
    1502:	fe843783          	ld	a5,-24(s0)
    1506:	4798                	lw	a4,8(a5)
    1508:	fe043783          	ld	a5,-32(s0)
    150c:	479c                	lw	a5,8(a5)
    150e:	9fb9                	addw	a5,a5,a4
    1510:	0007871b          	sext.w	a4,a5
    1514:	fe843783          	ld	a5,-24(s0)
    1518:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    151a:	fe043783          	ld	a5,-32(s0)
    151e:	6398                	ld	a4,0(a5)
    1520:	fe843783          	ld	a5,-24(s0)
    1524:	e398                	sd	a4,0(a5)
    1526:	a031                	j	1532 <free+0x10c>
  } else
    p->s.ptr = bp;
    1528:	fe843783          	ld	a5,-24(s0)
    152c:	fe043703          	ld	a4,-32(s0)
    1530:	e398                	sd	a4,0(a5)
  freep = p;
    1532:	00001797          	auipc	a5,0x1
    1536:	bd678793          	addi	a5,a5,-1066 # 2108 <freep>
    153a:	fe843703          	ld	a4,-24(s0)
    153e:	e398                	sd	a4,0(a5)
}
    1540:	0001                	nop
    1542:	7422                	ld	s0,40(sp)
    1544:	6145                	addi	sp,sp,48
    1546:	8082                	ret

0000000000001548 <morecore>:

static Header*
morecore(uint nu)
{
    1548:	7179                	addi	sp,sp,-48
    154a:	f406                	sd	ra,40(sp)
    154c:	f022                	sd	s0,32(sp)
    154e:	1800                	addi	s0,sp,48
    1550:	87aa                	mv	a5,a0
    1552:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
    1556:	fdc42783          	lw	a5,-36(s0)
    155a:	0007871b          	sext.w	a4,a5
    155e:	6785                	lui	a5,0x1
    1560:	00f77563          	bgeu	a4,a5,156a <morecore+0x22>
    nu = 4096;
    1564:	6785                	lui	a5,0x1
    1566:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
    156a:	fdc42783          	lw	a5,-36(s0)
    156e:	0047979b          	slliw	a5,a5,0x4
    1572:	2781                	sext.w	a5,a5
    1574:	2781                	sext.w	a5,a5
    1576:	853e                	mv	a0,a5
    1578:	00000097          	auipc	ra,0x0
    157c:	9a0080e7          	jalr	-1632(ra) # f18 <sbrk>
    1580:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
    1584:	fe843703          	ld	a4,-24(s0)
    1588:	57fd                	li	a5,-1
    158a:	00f71463          	bne	a4,a5,1592 <morecore+0x4a>
    return 0;
    158e:	4781                	li	a5,0
    1590:	a03d                	j	15be <morecore+0x76>
  hp = (Header*)p;
    1592:	fe843783          	ld	a5,-24(s0)
    1596:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
    159a:	fe043783          	ld	a5,-32(s0)
    159e:	fdc42703          	lw	a4,-36(s0)
    15a2:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
    15a4:	fe043783          	ld	a5,-32(s0)
    15a8:	07c1                	addi	a5,a5,16
    15aa:	853e                	mv	a0,a5
    15ac:	00000097          	auipc	ra,0x0
    15b0:	e7a080e7          	jalr	-390(ra) # 1426 <free>
  return freep;
    15b4:	00001797          	auipc	a5,0x1
    15b8:	b5478793          	addi	a5,a5,-1196 # 2108 <freep>
    15bc:	639c                	ld	a5,0(a5)
}
    15be:	853e                	mv	a0,a5
    15c0:	70a2                	ld	ra,40(sp)
    15c2:	7402                	ld	s0,32(sp)
    15c4:	6145                	addi	sp,sp,48
    15c6:	8082                	ret

00000000000015c8 <malloc>:

void*
malloc(uint nbytes)
{
    15c8:	7139                	addi	sp,sp,-64
    15ca:	fc06                	sd	ra,56(sp)
    15cc:	f822                	sd	s0,48(sp)
    15ce:	0080                	addi	s0,sp,64
    15d0:	87aa                	mv	a5,a0
    15d2:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    15d6:	fcc46783          	lwu	a5,-52(s0)
    15da:	07bd                	addi	a5,a5,15
    15dc:	8391                	srli	a5,a5,0x4
    15de:	2781                	sext.w	a5,a5
    15e0:	2785                	addiw	a5,a5,1
    15e2:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
    15e6:	00001797          	auipc	a5,0x1
    15ea:	b2278793          	addi	a5,a5,-1246 # 2108 <freep>
    15ee:	639c                	ld	a5,0(a5)
    15f0:	fef43023          	sd	a5,-32(s0)
    15f4:	fe043783          	ld	a5,-32(s0)
    15f8:	ef95                	bnez	a5,1634 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
    15fa:	00001797          	auipc	a5,0x1
    15fe:	afe78793          	addi	a5,a5,-1282 # 20f8 <base>
    1602:	fef43023          	sd	a5,-32(s0)
    1606:	00001797          	auipc	a5,0x1
    160a:	b0278793          	addi	a5,a5,-1278 # 2108 <freep>
    160e:	fe043703          	ld	a4,-32(s0)
    1612:	e398                	sd	a4,0(a5)
    1614:	00001797          	auipc	a5,0x1
    1618:	af478793          	addi	a5,a5,-1292 # 2108 <freep>
    161c:	6398                	ld	a4,0(a5)
    161e:	00001797          	auipc	a5,0x1
    1622:	ada78793          	addi	a5,a5,-1318 # 20f8 <base>
    1626:	e398                	sd	a4,0(a5)
    base.s.size = 0;
    1628:	00001797          	auipc	a5,0x1
    162c:	ad078793          	addi	a5,a5,-1328 # 20f8 <base>
    1630:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1634:	fe043783          	ld	a5,-32(s0)
    1638:	639c                	ld	a5,0(a5)
    163a:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    163e:	fe843783          	ld	a5,-24(s0)
    1642:	4798                	lw	a4,8(a5)
    1644:	fdc42783          	lw	a5,-36(s0)
    1648:	2781                	sext.w	a5,a5
    164a:	06f76863          	bltu	a4,a5,16ba <malloc+0xf2>
      if(p->s.size == nunits)
    164e:	fe843783          	ld	a5,-24(s0)
    1652:	4798                	lw	a4,8(a5)
    1654:	fdc42783          	lw	a5,-36(s0)
    1658:	2781                	sext.w	a5,a5
    165a:	00e79963          	bne	a5,a4,166c <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
    165e:	fe843783          	ld	a5,-24(s0)
    1662:	6398                	ld	a4,0(a5)
    1664:	fe043783          	ld	a5,-32(s0)
    1668:	e398                	sd	a4,0(a5)
    166a:	a82d                	j	16a4 <malloc+0xdc>
      else {
        p->s.size -= nunits;
    166c:	fe843783          	ld	a5,-24(s0)
    1670:	4798                	lw	a4,8(a5)
    1672:	fdc42783          	lw	a5,-36(s0)
    1676:	40f707bb          	subw	a5,a4,a5
    167a:	0007871b          	sext.w	a4,a5
    167e:	fe843783          	ld	a5,-24(s0)
    1682:	c798                	sw	a4,8(a5)
        p += p->s.size;
    1684:	fe843783          	ld	a5,-24(s0)
    1688:	479c                	lw	a5,8(a5)
    168a:	1782                	slli	a5,a5,0x20
    168c:	9381                	srli	a5,a5,0x20
    168e:	0792                	slli	a5,a5,0x4
    1690:	fe843703          	ld	a4,-24(s0)
    1694:	97ba                	add	a5,a5,a4
    1696:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
    169a:	fe843783          	ld	a5,-24(s0)
    169e:	fdc42703          	lw	a4,-36(s0)
    16a2:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
    16a4:	00001797          	auipc	a5,0x1
    16a8:	a6478793          	addi	a5,a5,-1436 # 2108 <freep>
    16ac:	fe043703          	ld	a4,-32(s0)
    16b0:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
    16b2:	fe843783          	ld	a5,-24(s0)
    16b6:	07c1                	addi	a5,a5,16
    16b8:	a091                	j	16fc <malloc+0x134>
    }
    if(p == freep)
    16ba:	00001797          	auipc	a5,0x1
    16be:	a4e78793          	addi	a5,a5,-1458 # 2108 <freep>
    16c2:	639c                	ld	a5,0(a5)
    16c4:	fe843703          	ld	a4,-24(s0)
    16c8:	02f71063          	bne	a4,a5,16e8 <malloc+0x120>
      if((p = morecore(nunits)) == 0)
    16cc:	fdc42783          	lw	a5,-36(s0)
    16d0:	853e                	mv	a0,a5
    16d2:	00000097          	auipc	ra,0x0
    16d6:	e76080e7          	jalr	-394(ra) # 1548 <morecore>
    16da:	fea43423          	sd	a0,-24(s0)
    16de:	fe843783          	ld	a5,-24(s0)
    16e2:	e399                	bnez	a5,16e8 <malloc+0x120>
        return 0;
    16e4:	4781                	li	a5,0
    16e6:	a819                	j	16fc <malloc+0x134>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    16e8:	fe843783          	ld	a5,-24(s0)
    16ec:	fef43023          	sd	a5,-32(s0)
    16f0:	fe843783          	ld	a5,-24(s0)
    16f4:	639c                	ld	a5,0(a5)
    16f6:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    16fa:	b791                	j	163e <malloc+0x76>
  }
}
    16fc:	853e                	mv	a0,a5
    16fe:	70e2                	ld	ra,56(sp)
    1700:	7442                	ld	s0,48(sp)
    1702:	6121                	addi	sp,sp,64
    1704:	8082                	ret

0000000000001706 <setjmp>:
    1706:	e100                	sd	s0,0(a0)
    1708:	e504                	sd	s1,8(a0)
    170a:	01253823          	sd	s2,16(a0)
    170e:	01353c23          	sd	s3,24(a0)
    1712:	03453023          	sd	s4,32(a0)
    1716:	03553423          	sd	s5,40(a0)
    171a:	03653823          	sd	s6,48(a0)
    171e:	03753c23          	sd	s7,56(a0)
    1722:	05853023          	sd	s8,64(a0)
    1726:	05953423          	sd	s9,72(a0)
    172a:	05a53823          	sd	s10,80(a0)
    172e:	05b53c23          	sd	s11,88(a0)
    1732:	06153023          	sd	ra,96(a0)
    1736:	06253423          	sd	sp,104(a0)
    173a:	4501                	li	a0,0
    173c:	8082                	ret

000000000000173e <longjmp>:
    173e:	6100                	ld	s0,0(a0)
    1740:	6504                	ld	s1,8(a0)
    1742:	01053903          	ld	s2,16(a0)
    1746:	01853983          	ld	s3,24(a0)
    174a:	02053a03          	ld	s4,32(a0)
    174e:	02853a83          	ld	s5,40(a0)
    1752:	03053b03          	ld	s6,48(a0)
    1756:	03853b83          	ld	s7,56(a0)
    175a:	04053c03          	ld	s8,64(a0)
    175e:	04853c83          	ld	s9,72(a0)
    1762:	05053d03          	ld	s10,80(a0)
    1766:	05853d83          	ld	s11,88(a0)
    176a:	06053083          	ld	ra,96(a0)
    176e:	06853103          	ld	sp,104(a0)
    1772:	c199                	beqz	a1,1778 <longjmp_1>
    1774:	852e                	mv	a0,a1
    1776:	8082                	ret

0000000000001778 <longjmp_1>:
    1778:	4505                	li	a0,1
    177a:	8082                	ret

000000000000177c <list_empty>:
{
    177c:	1101                	addi	sp,sp,-32
    177e:	ec22                	sd	s0,24(sp)
    1780:	1000                	addi	s0,sp,32
    1782:	fea43423          	sd	a0,-24(s0)
    return head->next == head;
    1786:	fe843783          	ld	a5,-24(s0)
    178a:	639c                	ld	a5,0(a5)
    178c:	fe843703          	ld	a4,-24(s0)
    1790:	40f707b3          	sub	a5,a4,a5
    1794:	0017b793          	seqz	a5,a5
    1798:	0ff7f793          	andi	a5,a5,255
    179c:	2781                	sext.w	a5,a5
}
    179e:	853e                	mv	a0,a5
    17a0:	6462                	ld	s0,24(sp)
    17a2:	6105                	addi	sp,sp,32
    17a4:	8082                	ret

00000000000017a6 <schedule_default>:

#define NULL 0

/* default scheduling algorithm */
struct threads_sched_result schedule_default(struct threads_sched_args args)
{
    17a6:	715d                	addi	sp,sp,-80
    17a8:	e4a2                	sd	s0,72(sp)
    17aa:	e0a6                	sd	s1,64(sp)
    17ac:	0880                	addi	s0,sp,80
    17ae:	84aa                	mv	s1,a0
    struct thread *thread_with_smallest_id = NULL;
    17b0:	fe043423          	sd	zero,-24(s0)
    struct thread *th = NULL;
    17b4:	fe043023          	sd	zero,-32(s0)
    list_for_each_entry(th, args.run_queue, thread_list) {
    17b8:	649c                	ld	a5,8(s1)
    17ba:	639c                	ld	a5,0(a5)
    17bc:	fcf43c23          	sd	a5,-40(s0)
    17c0:	fd843783          	ld	a5,-40(s0)
    17c4:	fd878793          	addi	a5,a5,-40
    17c8:	fef43023          	sd	a5,-32(s0)
    17cc:	a81d                	j	1802 <schedule_default+0x5c>
        if (thread_with_smallest_id == NULL || th->ID < thread_with_smallest_id->ID) {
    17ce:	fe843783          	ld	a5,-24(s0)
    17d2:	cb89                	beqz	a5,17e4 <schedule_default+0x3e>
    17d4:	fe043783          	ld	a5,-32(s0)
    17d8:	5398                	lw	a4,32(a5)
    17da:	fe843783          	ld	a5,-24(s0)
    17de:	539c                	lw	a5,32(a5)
    17e0:	00f75663          	bge	a4,a5,17ec <schedule_default+0x46>
            thread_with_smallest_id = th;
    17e4:	fe043783          	ld	a5,-32(s0)
    17e8:	fef43423          	sd	a5,-24(s0)
    list_for_each_entry(th, args.run_queue, thread_list) {
    17ec:	fe043783          	ld	a5,-32(s0)
    17f0:	779c                	ld	a5,40(a5)
    17f2:	fcf43823          	sd	a5,-48(s0)
    17f6:	fd043783          	ld	a5,-48(s0)
    17fa:	fd878793          	addi	a5,a5,-40
    17fe:	fef43023          	sd	a5,-32(s0)
    1802:	fe043783          	ld	a5,-32(s0)
    1806:	02878713          	addi	a4,a5,40
    180a:	649c                	ld	a5,8(s1)
    180c:	fcf711e3          	bne	a4,a5,17ce <schedule_default+0x28>
        }
    }

    struct threads_sched_result r;
    if (thread_with_smallest_id != NULL) {
    1810:	fe843783          	ld	a5,-24(s0)
    1814:	cf89                	beqz	a5,182e <schedule_default+0x88>
        r.scheduled_thread_list_member = &thread_with_smallest_id->thread_list;
    1816:	fe843783          	ld	a5,-24(s0)
    181a:	02878793          	addi	a5,a5,40
    181e:	faf43823          	sd	a5,-80(s0)
        r.allocated_time = thread_with_smallest_id->remaining_time;
    1822:	fe843783          	ld	a5,-24(s0)
    1826:	47fc                	lw	a5,76(a5)
    1828:	faf42c23          	sw	a5,-72(s0)
    182c:	a039                	j	183a <schedule_default+0x94>
    } else {
        r.scheduled_thread_list_member = args.run_queue;
    182e:	649c                	ld	a5,8(s1)
    1830:	faf43823          	sd	a5,-80(s0)
        r.allocated_time = 1;
    1834:	4785                	li	a5,1
    1836:	faf42c23          	sw	a5,-72(s0)
    }

    return r;
    183a:	fb043783          	ld	a5,-80(s0)
    183e:	fcf43023          	sd	a5,-64(s0)
    1842:	fb843783          	ld	a5,-72(s0)
    1846:	fcf43423          	sd	a5,-56(s0)
    184a:	fc043703          	ld	a4,-64(s0)
    184e:	fc843783          	ld	a5,-56(s0)
    1852:	863a                	mv	a2,a4
    1854:	86be                	mv	a3,a5
    1856:	8732                	mv	a4,a2
    1858:	87b6                	mv	a5,a3
}
    185a:	853a                	mv	a0,a4
    185c:	85be                	mv	a1,a5
    185e:	6426                	ld	s0,72(sp)
    1860:	6486                	ld	s1,64(sp)
    1862:	6161                	addi	sp,sp,80
    1864:	8082                	ret

0000000000001866 <schedule_edf>:

/* Earliest-Deadline-First scheduling */
struct threads_sched_result schedule_edf(struct threads_sched_args args)
{
    1866:	7115                	addi	sp,sp,-224
    1868:	ed86                	sd	ra,216(sp)
    186a:	e9a2                	sd	s0,208(sp)
    186c:	e5a6                	sd	s1,200(sp)
    186e:	e1ca                	sd	s2,192(sp)
    1870:	fd4e                	sd	s3,184(sp)
    1872:	1180                	addi	s0,sp,224
    1874:	84aa                	mv	s1,a0
    // the scheduling is called when a interrupt event happens (either a fn end or a new one is added)
    // need to determine the next thread to execute and the allocated time.

    struct threads_sched_result r;
    if(list_empty(args.run_queue)){
    1876:	649c                	ld	a5,8(s1)
    1878:	853e                	mv	a0,a5
    187a:	00000097          	auipc	ra,0x0
    187e:	f02080e7          	jalr	-254(ra) # 177c <list_empty>
    1882:	87aa                	mv	a5,a0
    1884:	c3d1                	beqz	a5,1908 <schedule_edf+0xa2>
        // SPEC 3
        r.scheduled_thread_list_member = args.run_queue;
    1886:	649c                	ld	a5,8(s1)
    1888:	f2f43423          	sd	a5,-216(s0)
        int least_release_time = 99999;
    188c:	67e1                	lui	a5,0x18
    188e:	69f78793          	addi	a5,a5,1695 # 1869f <__global_pointer$+0x15dff>
    1892:	fcf42623          	sw	a5,-52(s0)
        struct release_queue_entry* cur;
        list_for_each_entry(cur, args.release_queue, thread_list) {
    1896:	689c                	ld	a5,16(s1)
    1898:	639c                	ld	a5,0(a5)
    189a:	f4f43823          	sd	a5,-176(s0)
    189e:	f5043783          	ld	a5,-176(s0)
    18a2:	17e1                	addi	a5,a5,-8
    18a4:	fcf43023          	sd	a5,-64(s0)
    18a8:	a805                	j	18d8 <schedule_edf+0x72>
            if(cur->release_time<least_release_time){
    18aa:	fc043783          	ld	a5,-64(s0)
    18ae:	4f98                	lw	a4,24(a5)
    18b0:	fcc42783          	lw	a5,-52(s0)
    18b4:	2781                	sext.w	a5,a5
    18b6:	00f75763          	bge	a4,a5,18c4 <schedule_edf+0x5e>
                least_release_time = cur->release_time;
    18ba:	fc043783          	ld	a5,-64(s0)
    18be:	4f9c                	lw	a5,24(a5)
    18c0:	fcf42623          	sw	a5,-52(s0)
        list_for_each_entry(cur, args.release_queue, thread_list) {
    18c4:	fc043783          	ld	a5,-64(s0)
    18c8:	679c                	ld	a5,8(a5)
    18ca:	f4f43423          	sd	a5,-184(s0)
    18ce:	f4843783          	ld	a5,-184(s0)
    18d2:	17e1                	addi	a5,a5,-8
    18d4:	fcf43023          	sd	a5,-64(s0)
    18d8:	fc043783          	ld	a5,-64(s0)
    18dc:	00878713          	addi	a4,a5,8
    18e0:	689c                	ld	a5,16(s1)
    18e2:	fcf714e3          	bne	a4,a5,18aa <schedule_edf+0x44>
            }
        }
        r.allocated_time = least_release_time - args.current_time ;
    18e6:	409c                	lw	a5,0(s1)
    18e8:	fcc42703          	lw	a4,-52(s0)
    18ec:	40f707bb          	subw	a5,a4,a5
    18f0:	2781                	sext.w	a5,a5
    18f2:	f2f42823          	sw	a5,-208(s0)
        return r;
    18f6:	f2843783          	ld	a5,-216(s0)
    18fa:	f2f43c23          	sd	a5,-200(s0)
    18fe:	f3043783          	ld	a5,-208(s0)
    1902:	f4f43023          	sd	a5,-192(s0)
    1906:	a4e5                	j	1bee <schedule_edf+0x388>
    }else{
        // run queue is not empty.
        struct thread *th = NULL;
    1908:	fa043c23          	sd	zero,-72(s0)
        struct thread *min_th = NULL;
    190c:	fa043823          	sd	zero,-80(s0)
        struct thread *min_miss_deadline_th = NULL;
    1910:	fa043423          	sd	zero,-88(s0)
        list_for_each_entry(th, args.run_queue, thread_list) {
    1914:	649c                	ld	a5,8(s1)
    1916:	639c                	ld	a5,0(a5)
    1918:	f8f43423          	sd	a5,-120(s0)
    191c:	f8843783          	ld	a5,-120(s0)
    1920:	fd878793          	addi	a5,a5,-40
    1924:	faf43c23          	sd	a5,-72(s0)
    1928:	a849                	j	19ba <schedule_edf+0x154>
            // printf("in run queue: %d\n", th->ID);
            if(th->current_deadline <= args.current_time){
    192a:	fb843783          	ld	a5,-72(s0)
    192e:	4bb8                	lw	a4,80(a5)
    1930:	409c                	lw	a5,0(s1)
    1932:	02e7c163          	blt	a5,a4,1954 <schedule_edf+0xee>
                if(min_miss_deadline_th == NULL || th->ID<min_miss_deadline_th->ID){
    1936:	fa843783          	ld	a5,-88(s0)
    193a:	cb89                	beqz	a5,194c <schedule_edf+0xe6>
    193c:	fb843783          	ld	a5,-72(s0)
    1940:	5398                	lw	a4,32(a5)
    1942:	fa843783          	ld	a5,-88(s0)
    1946:	539c                	lw	a5,32(a5)
    1948:	00f75663          	bge	a4,a5,1954 <schedule_edf+0xee>
                    min_miss_deadline_th = th;
    194c:	fb843783          	ld	a5,-72(s0)
    1950:	faf43423          	sd	a5,-88(s0)
                }
            }
            if(min_th == NULL) min_th = th;
    1954:	fb043783          	ld	a5,-80(s0)
    1958:	e789                	bnez	a5,1962 <schedule_edf+0xfc>
    195a:	fb843783          	ld	a5,-72(s0)
    195e:	faf43823          	sd	a5,-80(s0)
            if(th->current_deadline<min_th->current_deadline){
    1962:	fb843783          	ld	a5,-72(s0)
    1966:	4bb8                	lw	a4,80(a5)
    1968:	fb043783          	ld	a5,-80(s0)
    196c:	4bbc                	lw	a5,80(a5)
    196e:	00f75763          	bge	a4,a5,197c <schedule_edf+0x116>
                min_th = th;
    1972:	fb843783          	ld	a5,-72(s0)
    1976:	faf43823          	sd	a5,-80(s0)
    197a:	a02d                	j	19a4 <schedule_edf+0x13e>
            }else if(th->current_deadline == min_th->current_deadline){
    197c:	fb843783          	ld	a5,-72(s0)
    1980:	4bb8                	lw	a4,80(a5)
    1982:	fb043783          	ld	a5,-80(s0)
    1986:	4bbc                	lw	a5,80(a5)
    1988:	00f71e63          	bne	a4,a5,19a4 <schedule_edf+0x13e>
                if(th->ID<min_th->ID) min_th = th;
    198c:	fb843783          	ld	a5,-72(s0)
    1990:	5398                	lw	a4,32(a5)
    1992:	fb043783          	ld	a5,-80(s0)
    1996:	539c                	lw	a5,32(a5)
    1998:	00f75663          	bge	a4,a5,19a4 <schedule_edf+0x13e>
    199c:	fb843783          	ld	a5,-72(s0)
    19a0:	faf43823          	sd	a5,-80(s0)
        list_for_each_entry(th, args.run_queue, thread_list) {
    19a4:	fb843783          	ld	a5,-72(s0)
    19a8:	779c                	ld	a5,40(a5)
    19aa:	f4f43c23          	sd	a5,-168(s0)
    19ae:	f5843783          	ld	a5,-168(s0)
    19b2:	fd878793          	addi	a5,a5,-40
    19b6:	faf43c23          	sd	a5,-72(s0)
    19ba:	fb843783          	ld	a5,-72(s0)
    19be:	02878713          	addi	a4,a5,40
    19c2:	649c                	ld	a5,8(s1)
    19c4:	f6f713e3          	bne	a4,a5,192a <schedule_edf+0xc4>
            }
        }

        if(min_miss_deadline_th != NULL) {
    19c8:	fa843783          	ld	a5,-88(s0)
    19cc:	c395                	beqz	a5,19f0 <schedule_edf+0x18a>
            // SPEC 4: exist missed deadline
            // printf("exist missed deadline", th->ID);
            r.allocated_time = 0;
    19ce:	f2042823          	sw	zero,-208(s0)
            r.scheduled_thread_list_member = &min_miss_deadline_th->thread_list;
    19d2:	fa843783          	ld	a5,-88(s0)
    19d6:	02878793          	addi	a5,a5,40
    19da:	f2f43423          	sd	a5,-216(s0)
            return r;
    19de:	f2843783          	ld	a5,-216(s0)
    19e2:	f2f43c23          	sd	a5,-200(s0)
    19e6:	f3043783          	ld	a5,-208(s0)
    19ea:	f4f43023          	sd	a5,-192(s0)
    19ee:	a401                	j	1bee <schedule_edf+0x388>
             // compute allocated time: 
            // 1. a preemption can happen in the future.(need to inspect the release queue)
            // 2. current deadline is met (preemption has not happened)
            // 3. current deadline is missed (current_time + remaining_time > current_deadline)
            // compute the first event that will happen.
            r.scheduled_thread_list_member = &min_th->thread_list;
    19f0:	fb043783          	ld	a5,-80(s0)
    19f4:	02878793          	addi	a5,a5,40
    19f8:	f2f43423          	sd	a5,-216(s0)

            struct release_queue_entry* cur;
            if(list_empty(args.release_queue)){
    19fc:	689c                	ld	a5,16(s1)
    19fe:	853e                	mv	a0,a5
    1a00:	00000097          	auipc	ra,0x0
    1a04:	d7c080e7          	jalr	-644(ra) # 177c <list_empty>
    1a08:	87aa                	mv	a5,a0
    1a0a:	c3b5                	beqz	a5,1a6e <schedule_edf+0x208>
                // printf("release queue is empty\n");
                // a preemption cannot happen, because we've already selected the highest priority thread.
                int remaining_time = 99999;
    1a0c:	67e1                	lui	a5,0x18
    1a0e:	69f78793          	addi	a5,a5,1695 # 1869f <__global_pointer$+0x15dff>
    1a12:	f6f42623          	sw	a5,-148(s0)

                int deadline_time = min_th->current_deadline - args.current_time;
    1a16:	fb043783          	ld	a5,-80(s0)
    1a1a:	4bb8                	lw	a4,80(a5)
    1a1c:	409c                	lw	a5,0(s1)
    1a1e:	40f707bb          	subw	a5,a4,a5
    1a22:	f6f42423          	sw	a5,-152(s0)
                remaining_time = deadline_time<remaining_time? deadline_time: remaining_time;
    1a26:	f6842603          	lw	a2,-152(s0)
    1a2a:	f6c42783          	lw	a5,-148(s0)
    1a2e:	0007869b          	sext.w	a3,a5
    1a32:	0006071b          	sext.w	a4,a2
    1a36:	00d75363          	bge	a4,a3,1a3c <schedule_edf+0x1d6>
    1a3a:	87b2                	mv	a5,a2
    1a3c:	f6f42623          	sw	a5,-148(s0)
                int met_time = min_th->remaining_time;
    1a40:	fb043783          	ld	a5,-80(s0)
    1a44:	47fc                	lw	a5,76(a5)
    1a46:	f6f42223          	sw	a5,-156(s0)
                remaining_time = met_time<remaining_time? met_time: remaining_time;
    1a4a:	f6442603          	lw	a2,-156(s0)
    1a4e:	f6c42783          	lw	a5,-148(s0)
    1a52:	0007869b          	sext.w	a3,a5
    1a56:	0006071b          	sext.w	a4,a2
    1a5a:	00d75363          	bge	a4,a3,1a60 <schedule_edf+0x1fa>
    1a5e:	87b2                	mv	a5,a2
    1a60:	f6f42623          	sw	a5,-148(s0)
                r.allocated_time = remaining_time;
    1a64:	f6c42783          	lw	a5,-148(s0)
    1a68:	f2f42823          	sw	a5,-208(s0)
    1a6c:	aa8d                	j	1bde <schedule_edf+0x378>
            }else{
                // first check if a preemption can happen
                struct release_queue_entry* cur_min = NULL;
    1a6e:	f8043c23          	sd	zero,-104(s0)
                int remaining_time = 99999;
    1a72:	67e1                	lui	a5,0x18
    1a74:	69f78793          	addi	a5,a5,1695 # 1869f <__global_pointer$+0x15dff>
    1a78:	f8f42a23          	sw	a5,-108(s0)
                list_for_each_entry(cur, args.release_queue, thread_list) {
    1a7c:	689c                	ld	a5,16(s1)
    1a7e:	639c                	ld	a5,0(a5)
    1a80:	f8f43023          	sd	a5,-128(s0)
    1a84:	f8043783          	ld	a5,-128(s0)
    1a88:	17e1                	addi	a5,a5,-8
    1a8a:	faf43023          	sd	a5,-96(s0)
    1a8e:	a8d9                	j	1b64 <schedule_edf+0x2fe>
                    if((cur->thrd->period + cur->release_time < min_th->current_deadline) && cur->thrd->n != 0){
    1a90:	fa043783          	ld	a5,-96(s0)
    1a94:	639c                	ld	a5,0(a5)
    1a96:	43f8                	lw	a4,68(a5)
    1a98:	fa043783          	ld	a5,-96(s0)
    1a9c:	4f9c                	lw	a5,24(a5)
    1a9e:	9fb9                	addw	a5,a5,a4
    1aa0:	0007871b          	sext.w	a4,a5
    1aa4:	fb043783          	ld	a5,-80(s0)
    1aa8:	4bbc                	lw	a5,80(a5)
    1aaa:	0af75363          	bge	a4,a5,1b50 <schedule_edf+0x2ea>
    1aae:	fa043783          	ld	a5,-96(s0)
    1ab2:	639c                	ld	a5,0(a5)
    1ab4:	47bc                	lw	a5,72(a5)
    1ab6:	cfc9                	beqz	a5,1b50 <schedule_edf+0x2ea>
                        // printf("preemption can occur: %d %d %d\n", cur->thrd->period , cur->release_time , min_th->current_deadline);
                        // a preemption can occur
                        if(cur_min == NULL){
    1ab8:	f9843783          	ld	a5,-104(s0)
    1abc:	e791                	bnez	a5,1ac8 <schedule_edf+0x262>
                            cur_min = cur;
    1abe:	fa043783          	ld	a5,-96(s0)
    1ac2:	f8f43c23          	sd	a5,-104(s0)
    1ac6:	a069                	j	1b50 <schedule_edf+0x2ea>
                        }else{
                            if((cur->thrd->period + cur->release_time < cur_min->thrd->period + cur_min->release_time)&& cur->thrd->n != 0){
    1ac8:	fa043783          	ld	a5,-96(s0)
    1acc:	639c                	ld	a5,0(a5)
    1ace:	43f8                	lw	a4,68(a5)
    1ad0:	fa043783          	ld	a5,-96(s0)
    1ad4:	4f9c                	lw	a5,24(a5)
    1ad6:	9fb9                	addw	a5,a5,a4
    1ad8:	0007869b          	sext.w	a3,a5
    1adc:	f9843783          	ld	a5,-104(s0)
    1ae0:	639c                	ld	a5,0(a5)
    1ae2:	43f8                	lw	a4,68(a5)
    1ae4:	f9843783          	ld	a5,-104(s0)
    1ae8:	4f9c                	lw	a5,24(a5)
    1aea:	9fb9                	addw	a5,a5,a4
    1aec:	2781                	sext.w	a5,a5
    1aee:	8736                	mv	a4,a3
    1af0:	00f75c63          	bge	a4,a5,1b08 <schedule_edf+0x2a2>
    1af4:	fa043783          	ld	a5,-96(s0)
    1af8:	639c                	ld	a5,0(a5)
    1afa:	47bc                	lw	a5,72(a5)
    1afc:	c791                	beqz	a5,1b08 <schedule_edf+0x2a2>
                                cur_min = cur;
    1afe:	fa043783          	ld	a5,-96(s0)
    1b02:	f8f43c23          	sd	a5,-104(s0)
    1b06:	a0a9                	j	1b50 <schedule_edf+0x2ea>
                            }else if(cur->thrd->period + cur->release_time == cur_min->thrd->period + cur_min->release_time){
    1b08:	fa043783          	ld	a5,-96(s0)
    1b0c:	639c                	ld	a5,0(a5)
    1b0e:	43f8                	lw	a4,68(a5)
    1b10:	fa043783          	ld	a5,-96(s0)
    1b14:	4f9c                	lw	a5,24(a5)
    1b16:	9fb9                	addw	a5,a5,a4
    1b18:	0007869b          	sext.w	a3,a5
    1b1c:	f9843783          	ld	a5,-104(s0)
    1b20:	639c                	ld	a5,0(a5)
    1b22:	43f8                	lw	a4,68(a5)
    1b24:	f9843783          	ld	a5,-104(s0)
    1b28:	4f9c                	lw	a5,24(a5)
    1b2a:	9fb9                	addw	a5,a5,a4
    1b2c:	2781                	sext.w	a5,a5
    1b2e:	8736                	mv	a4,a3
    1b30:	02f71063          	bne	a4,a5,1b50 <schedule_edf+0x2ea>
                                if(cur_min->thrd->ID > cur->thrd->ID){
    1b34:	f9843783          	ld	a5,-104(s0)
    1b38:	639c                	ld	a5,0(a5)
    1b3a:	5398                	lw	a4,32(a5)
    1b3c:	fa043783          	ld	a5,-96(s0)
    1b40:	639c                	ld	a5,0(a5)
    1b42:	539c                	lw	a5,32(a5)
    1b44:	00e7d663          	bge	a5,a4,1b50 <schedule_edf+0x2ea>
                                    cur_min = cur;
    1b48:	fa043783          	ld	a5,-96(s0)
    1b4c:	f8f43c23          	sd	a5,-104(s0)
                list_for_each_entry(cur, args.release_queue, thread_list) {
    1b50:	fa043783          	ld	a5,-96(s0)
    1b54:	679c                	ld	a5,8(a5)
    1b56:	f6f43823          	sd	a5,-144(s0)
    1b5a:	f7043783          	ld	a5,-144(s0)
    1b5e:	17e1                	addi	a5,a5,-8
    1b60:	faf43023          	sd	a5,-96(s0)
    1b64:	fa043783          	ld	a5,-96(s0)
    1b68:	00878713          	addi	a4,a5,8
    1b6c:	689c                	ld	a5,16(s1)
    1b6e:	f2f711e3          	bne	a4,a5,1a90 <schedule_edf+0x22a>
                                }
                            }
                        }
                    }
                }
                if(cur_min != NULL){
    1b72:	f9843783          	ld	a5,-104(s0)
    1b76:	cb89                	beqz	a5,1b88 <schedule_edf+0x322>
                    // a preemption is possible
                    remaining_time = cur_min->release_time - args.current_time;
    1b78:	f9843783          	ld	a5,-104(s0)
    1b7c:	4f98                	lw	a4,24(a5)
    1b7e:	409c                	lw	a5,0(s1)
    1b80:	40f707bb          	subw	a5,a4,a5
    1b84:	f8f42a23          	sw	a5,-108(s0)
                }
                int deadline_time = min_th->current_deadline - args.current_time;
    1b88:	fb043783          	ld	a5,-80(s0)
    1b8c:	4bb8                	lw	a4,80(a5)
    1b8e:	409c                	lw	a5,0(s1)
    1b90:	40f707bb          	subw	a5,a4,a5
    1b94:	f6f42e23          	sw	a5,-132(s0)
                remaining_time = deadline_time<remaining_time? deadline_time: remaining_time;
    1b98:	f7c42603          	lw	a2,-132(s0)
    1b9c:	f9442783          	lw	a5,-108(s0)
    1ba0:	0007869b          	sext.w	a3,a5
    1ba4:	0006071b          	sext.w	a4,a2
    1ba8:	00d75363          	bge	a4,a3,1bae <schedule_edf+0x348>
    1bac:	87b2                	mv	a5,a2
    1bae:	f8f42a23          	sw	a5,-108(s0)
                int met_time = min_th->remaining_time;
    1bb2:	fb043783          	ld	a5,-80(s0)
    1bb6:	47fc                	lw	a5,76(a5)
    1bb8:	f6f42c23          	sw	a5,-136(s0)
                remaining_time = met_time<remaining_time? met_time: remaining_time;
    1bbc:	f7842603          	lw	a2,-136(s0)
    1bc0:	f9442783          	lw	a5,-108(s0)
    1bc4:	0007869b          	sext.w	a3,a5
    1bc8:	0006071b          	sext.w	a4,a2
    1bcc:	00d75363          	bge	a4,a3,1bd2 <schedule_edf+0x36c>
    1bd0:	87b2                	mv	a5,a2
    1bd2:	f8f42a23          	sw	a5,-108(s0)
                r.allocated_time = remaining_time;
    1bd6:	f9442783          	lw	a5,-108(s0)
    1bda:	f2f42823          	sw	a5,-208(s0)
            }

            return r;
    1bde:	f2843783          	ld	a5,-216(s0)
    1be2:	f2f43c23          	sd	a5,-200(s0)
    1be6:	f3043783          	ld	a5,-208(s0)
    1bea:	f4f43023          	sd	a5,-192(s0)
        }
    }

    return schedule_default(args);
}
    1bee:	f3843703          	ld	a4,-200(s0)
    1bf2:	f4043783          	ld	a5,-192(s0)
    1bf6:	893a                	mv	s2,a4
    1bf8:	89be                	mv	s3,a5
    1bfa:	874a                	mv	a4,s2
    1bfc:	87ce                	mv	a5,s3
    1bfe:	853a                	mv	a0,a4
    1c00:	85be                	mv	a1,a5
    1c02:	60ee                	ld	ra,216(sp)
    1c04:	644e                	ld	s0,208(sp)
    1c06:	64ae                	ld	s1,200(sp)
    1c08:	690e                	ld	s2,192(sp)
    1c0a:	79ea                	ld	s3,184(sp)
    1c0c:	612d                	addi	sp,sp,224
    1c0e:	8082                	ret

0000000000001c10 <schedule_rm>:

/* Rate-Monotonic Scheduling */
struct threads_sched_result schedule_rm(struct threads_sched_args args)
{
    1c10:	7115                	addi	sp,sp,-224
    1c12:	ed86                	sd	ra,216(sp)
    1c14:	e9a2                	sd	s0,208(sp)
    1c16:	e5a6                	sd	s1,200(sp)
    1c18:	e1ca                	sd	s2,192(sp)
    1c1a:	fd4e                	sd	s3,184(sp)
    1c1c:	1180                	addi	s0,sp,224
    1c1e:	84aa                	mv	s1,a0
    
    struct threads_sched_result r;
    if(list_empty(args.run_queue)){
    1c20:	649c                	ld	a5,8(s1)
    1c22:	853e                	mv	a0,a5
    1c24:	00000097          	auipc	ra,0x0
    1c28:	b58080e7          	jalr	-1192(ra) # 177c <list_empty>
    1c2c:	87aa                	mv	a5,a0
    1c2e:	c3d1                	beqz	a5,1cb2 <schedule_rm+0xa2>
        // SPEC 3
        r.scheduled_thread_list_member = args.run_queue;
    1c30:	649c                	ld	a5,8(s1)
    1c32:	f2f43423          	sd	a5,-216(s0)
        int least_release_time = 99999;
    1c36:	67e1                	lui	a5,0x18
    1c38:	69f78793          	addi	a5,a5,1695 # 1869f <__global_pointer$+0x15dff>
    1c3c:	fcf42623          	sw	a5,-52(s0)
        struct release_queue_entry* cur;
        list_for_each_entry(cur, args.release_queue, thread_list) {
    1c40:	689c                	ld	a5,16(s1)
    1c42:	639c                	ld	a5,0(a5)
    1c44:	f4f43823          	sd	a5,-176(s0)
    1c48:	f5043783          	ld	a5,-176(s0)
    1c4c:	17e1                	addi	a5,a5,-8
    1c4e:	fcf43023          	sd	a5,-64(s0)
    1c52:	a805                	j	1c82 <schedule_rm+0x72>
            if(cur->release_time<least_release_time){
    1c54:	fc043783          	ld	a5,-64(s0)
    1c58:	4f98                	lw	a4,24(a5)
    1c5a:	fcc42783          	lw	a5,-52(s0)
    1c5e:	2781                	sext.w	a5,a5
    1c60:	00f75763          	bge	a4,a5,1c6e <schedule_rm+0x5e>
                least_release_time = cur->release_time;
    1c64:	fc043783          	ld	a5,-64(s0)
    1c68:	4f9c                	lw	a5,24(a5)
    1c6a:	fcf42623          	sw	a5,-52(s0)
        list_for_each_entry(cur, args.release_queue, thread_list) {
    1c6e:	fc043783          	ld	a5,-64(s0)
    1c72:	679c                	ld	a5,8(a5)
    1c74:	f4f43423          	sd	a5,-184(s0)
    1c78:	f4843783          	ld	a5,-184(s0)
    1c7c:	17e1                	addi	a5,a5,-8
    1c7e:	fcf43023          	sd	a5,-64(s0)
    1c82:	fc043783          	ld	a5,-64(s0)
    1c86:	00878713          	addi	a4,a5,8
    1c8a:	689c                	ld	a5,16(s1)
    1c8c:	fcf714e3          	bne	a4,a5,1c54 <schedule_rm+0x44>
            }
        }
        r.allocated_time = least_release_time - args.current_time ;
    1c90:	409c                	lw	a5,0(s1)
    1c92:	fcc42703          	lw	a4,-52(s0)
    1c96:	40f707bb          	subw	a5,a4,a5
    1c9a:	2781                	sext.w	a5,a5
    1c9c:	f2f42823          	sw	a5,-208(s0)
        return r;
    1ca0:	f2843783          	ld	a5,-216(s0)
    1ca4:	f2f43c23          	sd	a5,-200(s0)
    1ca8:	f3043783          	ld	a5,-208(s0)
    1cac:	f4f43023          	sd	a5,-192(s0)
    1cb0:	ac61                	j	1f48 <schedule_rm+0x338>
    }else{
        // run queue is not empty.
        struct thread *th = NULL;
    1cb2:	fa043c23          	sd	zero,-72(s0)
        struct thread *min_th = NULL;
    1cb6:	fa043823          	sd	zero,-80(s0)
        struct thread *min_miss_deadline_th = NULL;
    1cba:	fa043423          	sd	zero,-88(s0)
        list_for_each_entry(th, args.run_queue, thread_list) {
    1cbe:	649c                	ld	a5,8(s1)
    1cc0:	639c                	ld	a5,0(a5)
    1cc2:	f8f43423          	sd	a5,-120(s0)
    1cc6:	f8843783          	ld	a5,-120(s0)
    1cca:	fd878793          	addi	a5,a5,-40
    1cce:	faf43c23          	sd	a5,-72(s0)
    1cd2:	a849                	j	1d64 <schedule_rm+0x154>
            if(th->current_deadline <= args.current_time){
    1cd4:	fb843783          	ld	a5,-72(s0)
    1cd8:	4bb8                	lw	a4,80(a5)
    1cda:	409c                	lw	a5,0(s1)
    1cdc:	02e7c163          	blt	a5,a4,1cfe <schedule_rm+0xee>
                if(min_miss_deadline_th == NULL || th->ID<min_miss_deadline_th->ID){
    1ce0:	fa843783          	ld	a5,-88(s0)
    1ce4:	cb89                	beqz	a5,1cf6 <schedule_rm+0xe6>
    1ce6:	fb843783          	ld	a5,-72(s0)
    1cea:	5398                	lw	a4,32(a5)
    1cec:	fa843783          	ld	a5,-88(s0)
    1cf0:	539c                	lw	a5,32(a5)
    1cf2:	00f75663          	bge	a4,a5,1cfe <schedule_rm+0xee>
                    min_miss_deadline_th = th;
    1cf6:	fb843783          	ld	a5,-72(s0)
    1cfa:	faf43423          	sd	a5,-88(s0)
                }
            }
            if(min_th == NULL) min_th = th;
    1cfe:	fb043783          	ld	a5,-80(s0)
    1d02:	e789                	bnez	a5,1d0c <schedule_rm+0xfc>
    1d04:	fb843783          	ld	a5,-72(s0)
    1d08:	faf43823          	sd	a5,-80(s0)
            if(th->period<min_th->period){
    1d0c:	fb843783          	ld	a5,-72(s0)
    1d10:	43f8                	lw	a4,68(a5)
    1d12:	fb043783          	ld	a5,-80(s0)
    1d16:	43fc                	lw	a5,68(a5)
    1d18:	00f75763          	bge	a4,a5,1d26 <schedule_rm+0x116>
                min_th = th;
    1d1c:	fb843783          	ld	a5,-72(s0)
    1d20:	faf43823          	sd	a5,-80(s0)
    1d24:	a02d                	j	1d4e <schedule_rm+0x13e>
            }else if(th->period == min_th->period){
    1d26:	fb843783          	ld	a5,-72(s0)
    1d2a:	43f8                	lw	a4,68(a5)
    1d2c:	fb043783          	ld	a5,-80(s0)
    1d30:	43fc                	lw	a5,68(a5)
    1d32:	00f71e63          	bne	a4,a5,1d4e <schedule_rm+0x13e>
                if(th->ID<min_th->ID) min_th = th;
    1d36:	fb843783          	ld	a5,-72(s0)
    1d3a:	5398                	lw	a4,32(a5)
    1d3c:	fb043783          	ld	a5,-80(s0)
    1d40:	539c                	lw	a5,32(a5)
    1d42:	00f75663          	bge	a4,a5,1d4e <schedule_rm+0x13e>
    1d46:	fb843783          	ld	a5,-72(s0)
    1d4a:	faf43823          	sd	a5,-80(s0)
        list_for_each_entry(th, args.run_queue, thread_list) {
    1d4e:	fb843783          	ld	a5,-72(s0)
    1d52:	779c                	ld	a5,40(a5)
    1d54:	f4f43c23          	sd	a5,-168(s0)
    1d58:	f5843783          	ld	a5,-168(s0)
    1d5c:	fd878793          	addi	a5,a5,-40
    1d60:	faf43c23          	sd	a5,-72(s0)
    1d64:	fb843783          	ld	a5,-72(s0)
    1d68:	02878713          	addi	a4,a5,40
    1d6c:	649c                	ld	a5,8(s1)
    1d6e:	f6f713e3          	bne	a4,a5,1cd4 <schedule_rm+0xc4>
            }
        }

        if(min_miss_deadline_th != NULL) {
    1d72:	fa843783          	ld	a5,-88(s0)
    1d76:	c395                	beqz	a5,1d9a <schedule_rm+0x18a>
            // SPEC 4: exist missed deadline
            r.allocated_time = 0;
    1d78:	f2042823          	sw	zero,-208(s0)
            r.scheduled_thread_list_member = &min_miss_deadline_th->thread_list;
    1d7c:	fa843783          	ld	a5,-88(s0)
    1d80:	02878793          	addi	a5,a5,40
    1d84:	f2f43423          	sd	a5,-216(s0)
            return r;
    1d88:	f2843783          	ld	a5,-216(s0)
    1d8c:	f2f43c23          	sd	a5,-200(s0)
    1d90:	f3043783          	ld	a5,-208(s0)
    1d94:	f4f43023          	sd	a5,-192(s0)
    1d98:	aa45                	j	1f48 <schedule_rm+0x338>
             // compute allocated time: 
            // 1. a preemption can happen in the future.(need to inspect the release queue)
            // 2. current deadline is met (preemption has not happened)
            // 3. current deadline is missed (current_time + remaining_time > current_deadline)
            // compute the first event that will happen.
            r.scheduled_thread_list_member = &min_th->thread_list;
    1d9a:	fb043783          	ld	a5,-80(s0)
    1d9e:	02878793          	addi	a5,a5,40
    1da2:	f2f43423          	sd	a5,-216(s0)

            struct release_queue_entry* cur;
            if(list_empty(args.release_queue)){
    1da6:	689c                	ld	a5,16(s1)
    1da8:	853e                	mv	a0,a5
    1daa:	00000097          	auipc	ra,0x0
    1dae:	9d2080e7          	jalr	-1582(ra) # 177c <list_empty>
    1db2:	87aa                	mv	a5,a0
    1db4:	c3b5                	beqz	a5,1e18 <schedule_rm+0x208>
                // a preemption cannot happen, because we've already selected the highest priority thread.
                int remaining_time = 99999;
    1db6:	67e1                	lui	a5,0x18
    1db8:	69f78793          	addi	a5,a5,1695 # 1869f <__global_pointer$+0x15dff>
    1dbc:	f6f42623          	sw	a5,-148(s0)

                int deadline_time = min_th->current_deadline - args.current_time;
    1dc0:	fb043783          	ld	a5,-80(s0)
    1dc4:	4bb8                	lw	a4,80(a5)
    1dc6:	409c                	lw	a5,0(s1)
    1dc8:	40f707bb          	subw	a5,a4,a5
    1dcc:	f6f42423          	sw	a5,-152(s0)
                remaining_time = deadline_time<remaining_time? deadline_time: remaining_time;
    1dd0:	f6842603          	lw	a2,-152(s0)
    1dd4:	f6c42783          	lw	a5,-148(s0)
    1dd8:	0007869b          	sext.w	a3,a5
    1ddc:	0006071b          	sext.w	a4,a2
    1de0:	00d75363          	bge	a4,a3,1de6 <schedule_rm+0x1d6>
    1de4:	87b2                	mv	a5,a2
    1de6:	f6f42623          	sw	a5,-148(s0)
                int met_time = min_th->remaining_time;
    1dea:	fb043783          	ld	a5,-80(s0)
    1dee:	47fc                	lw	a5,76(a5)
    1df0:	f6f42223          	sw	a5,-156(s0)
                remaining_time = met_time<remaining_time? met_time: remaining_time;
    1df4:	f6442603          	lw	a2,-156(s0)
    1df8:	f6c42783          	lw	a5,-148(s0)
    1dfc:	0007869b          	sext.w	a3,a5
    1e00:	0006071b          	sext.w	a4,a2
    1e04:	00d75363          	bge	a4,a3,1e0a <schedule_rm+0x1fa>
    1e08:	87b2                	mv	a5,a2
    1e0a:	f6f42623          	sw	a5,-148(s0)
                
                r.allocated_time = remaining_time;
    1e0e:	f6c42783          	lw	a5,-148(s0)
    1e12:	f2f42823          	sw	a5,-208(s0)
    1e16:	a20d                	j	1f38 <schedule_rm+0x328>
            }else{
                // first check if a preemption can happen
                struct release_queue_entry* cur_min = NULL;
    1e18:	f8043c23          	sd	zero,-104(s0)
                int remaining_time = 99999;
    1e1c:	67e1                	lui	a5,0x18
    1e1e:	69f78793          	addi	a5,a5,1695 # 1869f <__global_pointer$+0x15dff>
    1e22:	f8f42a23          	sw	a5,-108(s0)
                list_for_each_entry(cur, args.release_queue, thread_list) {
    1e26:	689c                	ld	a5,16(s1)
    1e28:	639c                	ld	a5,0(a5)
    1e2a:	f8f43023          	sd	a5,-128(s0)
    1e2e:	f8043783          	ld	a5,-128(s0)
    1e32:	17e1                	addi	a5,a5,-8
    1e34:	faf43023          	sd	a5,-96(s0)
    1e38:	a059                	j	1ebe <schedule_rm+0x2ae>
                    if(cur->thrd->period<min_th->period){
    1e3a:	fa043783          	ld	a5,-96(s0)
    1e3e:	639c                	ld	a5,0(a5)
    1e40:	43f8                	lw	a4,68(a5)
    1e42:	fb043783          	ld	a5,-80(s0)
    1e46:	43fc                	lw	a5,68(a5)
    1e48:	06f75163          	bge	a4,a5,1eaa <schedule_rm+0x29a>
                        // a preemption can occur
                        if(cur_min == NULL){
    1e4c:	f9843783          	ld	a5,-104(s0)
    1e50:	e791                	bnez	a5,1e5c <schedule_rm+0x24c>
                            cur_min = cur;
    1e52:	fa043783          	ld	a5,-96(s0)
    1e56:	f8f43c23          	sd	a5,-104(s0)
    1e5a:	a881                	j	1eaa <schedule_rm+0x29a>
                        }else{
                            if(cur_min->thrd->period>cur->thrd->period){
    1e5c:	f9843783          	ld	a5,-104(s0)
    1e60:	639c                	ld	a5,0(a5)
    1e62:	43f8                	lw	a4,68(a5)
    1e64:	fa043783          	ld	a5,-96(s0)
    1e68:	639c                	ld	a5,0(a5)
    1e6a:	43fc                	lw	a5,68(a5)
    1e6c:	00e7d763          	bge	a5,a4,1e7a <schedule_rm+0x26a>
                                cur_min = cur;
    1e70:	fa043783          	ld	a5,-96(s0)
    1e74:	f8f43c23          	sd	a5,-104(s0)
    1e78:	a80d                	j	1eaa <schedule_rm+0x29a>
                            }else if(cur_min->thrd->period == cur->thrd->period){
    1e7a:	f9843783          	ld	a5,-104(s0)
    1e7e:	639c                	ld	a5,0(a5)
    1e80:	43f8                	lw	a4,68(a5)
    1e82:	fa043783          	ld	a5,-96(s0)
    1e86:	639c                	ld	a5,0(a5)
    1e88:	43fc                	lw	a5,68(a5)
    1e8a:	02f71063          	bne	a4,a5,1eaa <schedule_rm+0x29a>
                                if(cur_min->thrd->ID > cur->thrd->ID){
    1e8e:	f9843783          	ld	a5,-104(s0)
    1e92:	639c                	ld	a5,0(a5)
    1e94:	5398                	lw	a4,32(a5)
    1e96:	fa043783          	ld	a5,-96(s0)
    1e9a:	639c                	ld	a5,0(a5)
    1e9c:	539c                	lw	a5,32(a5)
    1e9e:	00e7d663          	bge	a5,a4,1eaa <schedule_rm+0x29a>
                                    cur_min = cur;
    1ea2:	fa043783          	ld	a5,-96(s0)
    1ea6:	f8f43c23          	sd	a5,-104(s0)
                list_for_each_entry(cur, args.release_queue, thread_list) {
    1eaa:	fa043783          	ld	a5,-96(s0)
    1eae:	679c                	ld	a5,8(a5)
    1eb0:	f6f43823          	sd	a5,-144(s0)
    1eb4:	f7043783          	ld	a5,-144(s0)
    1eb8:	17e1                	addi	a5,a5,-8
    1eba:	faf43023          	sd	a5,-96(s0)
    1ebe:	fa043783          	ld	a5,-96(s0)
    1ec2:	00878713          	addi	a4,a5,8
    1ec6:	689c                	ld	a5,16(s1)
    1ec8:	f6f719e3          	bne	a4,a5,1e3a <schedule_rm+0x22a>
                                }
                            }
                        }
                    }
                }
                if(cur_min != NULL){
    1ecc:	f9843783          	ld	a5,-104(s0)
    1ed0:	cb89                	beqz	a5,1ee2 <schedule_rm+0x2d2>
                    // a preemption is possible
                    remaining_time = cur_min->release_time - args.current_time;
    1ed2:	f9843783          	ld	a5,-104(s0)
    1ed6:	4f98                	lw	a4,24(a5)
    1ed8:	409c                	lw	a5,0(s1)
    1eda:	40f707bb          	subw	a5,a4,a5
    1ede:	f8f42a23          	sw	a5,-108(s0)
                }
                int deadline_time = min_th->current_deadline - args.current_time;
    1ee2:	fb043783          	ld	a5,-80(s0)
    1ee6:	4bb8                	lw	a4,80(a5)
    1ee8:	409c                	lw	a5,0(s1)
    1eea:	40f707bb          	subw	a5,a4,a5
    1eee:	f6f42e23          	sw	a5,-132(s0)
                remaining_time = deadline_time<remaining_time? deadline_time: remaining_time;
    1ef2:	f7c42603          	lw	a2,-132(s0)
    1ef6:	f9442783          	lw	a5,-108(s0)
    1efa:	0007869b          	sext.w	a3,a5
    1efe:	0006071b          	sext.w	a4,a2
    1f02:	00d75363          	bge	a4,a3,1f08 <schedule_rm+0x2f8>
    1f06:	87b2                	mv	a5,a2
    1f08:	f8f42a23          	sw	a5,-108(s0)
                int met_time = min_th->remaining_time;
    1f0c:	fb043783          	ld	a5,-80(s0)
    1f10:	47fc                	lw	a5,76(a5)
    1f12:	f6f42c23          	sw	a5,-136(s0)
                remaining_time = met_time<remaining_time? met_time: remaining_time;
    1f16:	f7842603          	lw	a2,-136(s0)
    1f1a:	f9442783          	lw	a5,-108(s0)
    1f1e:	0007869b          	sext.w	a3,a5
    1f22:	0006071b          	sext.w	a4,a2
    1f26:	00d75363          	bge	a4,a3,1f2c <schedule_rm+0x31c>
    1f2a:	87b2                	mv	a5,a2
    1f2c:	f8f42a23          	sw	a5,-108(s0)
                
                r.allocated_time = remaining_time;
    1f30:	f9442783          	lw	a5,-108(s0)
    1f34:	f2f42823          	sw	a5,-208(s0)
            }

            return r;
    1f38:	f2843783          	ld	a5,-216(s0)
    1f3c:	f2f43c23          	sd	a5,-200(s0)
    1f40:	f3043783          	ld	a5,-208(s0)
    1f44:	f4f43023          	sd	a5,-192(s0)
        }
    }
}
    1f48:	f3843703          	ld	a4,-200(s0)
    1f4c:	f4043783          	ld	a5,-192(s0)
    1f50:	893a                	mv	s2,a4
    1f52:	89be                	mv	s3,a5
    1f54:	874a                	mv	a4,s2
    1f56:	87ce                	mv	a5,s3
    1f58:	853a                	mv	a0,a4
    1f5a:	85be                	mv	a1,a5
    1f5c:	60ee                	ld	ra,216(sp)
    1f5e:	644e                	ld	s0,208(sp)
    1f60:	64ae                	ld	s1,200(sp)
    1f62:	690e                	ld	s2,192(sp)
    1f64:	79ea                	ld	s3,184(sp)
    1f66:	612d                	addi	sp,sp,224
    1f68:	8082                	ret
