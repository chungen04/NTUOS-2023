
kernel/kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	0000d117          	auipc	sp,0xd
    80000004:	8a813103          	ld	sp,-1880(sp) # 8000c8a8 <_GLOBAL_OFFSET_TABLE_+0x8>
    80000008:	6505                	lui	a0,0x1
    8000000a:	f14025f3          	csrr	a1,mhartid
    8000000e:	0585                	addi	a1,a1,1
    80000010:	02b50533          	mul	a0,a0,a1
    80000014:	912a                	add	sp,sp,a0
    80000016:	170000ef          	jal	ra,80000186 <start>

000000008000001a <spin>:
    8000001a:	a001                	j	8000001a <spin>

000000008000001c <r_mhartid>:
// which hart (core) is this?
static inline uint64
r_mhartid()
{
    8000001c:	1101                	addi	sp,sp,-32
    8000001e:	ec22                	sd	s0,24(sp)
    80000020:	1000                	addi	s0,sp,32
  uint64 x;
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    80000022:	f14027f3          	csrr	a5,mhartid
    80000026:	fef43423          	sd	a5,-24(s0)
  return x;
    8000002a:	fe843783          	ld	a5,-24(s0)
}
    8000002e:	853e                	mv	a0,a5
    80000030:	6462                	ld	s0,24(sp)
    80000032:	6105                	addi	sp,sp,32
    80000034:	8082                	ret

0000000080000036 <r_mstatus>:
#define MSTATUS_MPP_U (0L << 11)
#define MSTATUS_MIE (1L << 3)    // machine-mode interrupt enable.

static inline uint64
r_mstatus()
{
    80000036:	1101                	addi	sp,sp,-32
    80000038:	ec22                	sd	s0,24(sp)
    8000003a:	1000                	addi	s0,sp,32
  uint64 x;
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    8000003c:	300027f3          	csrr	a5,mstatus
    80000040:	fef43423          	sd	a5,-24(s0)
  return x;
    80000044:	fe843783          	ld	a5,-24(s0)
}
    80000048:	853e                	mv	a0,a5
    8000004a:	6462                	ld	s0,24(sp)
    8000004c:	6105                	addi	sp,sp,32
    8000004e:	8082                	ret

0000000080000050 <w_mstatus>:

static inline void 
w_mstatus(uint64 x)
{
    80000050:	1101                	addi	sp,sp,-32
    80000052:	ec22                	sd	s0,24(sp)
    80000054:	1000                	addi	s0,sp,32
    80000056:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw mstatus, %0" : : "r" (x));
    8000005a:	fe843783          	ld	a5,-24(s0)
    8000005e:	30079073          	csrw	mstatus,a5
}
    80000062:	0001                	nop
    80000064:	6462                	ld	s0,24(sp)
    80000066:	6105                	addi	sp,sp,32
    80000068:	8082                	ret

000000008000006a <w_mepc>:
// machine exception program counter, holds the
// instruction address to which a return from
// exception will go.
static inline void 
w_mepc(uint64 x)
{
    8000006a:	1101                	addi	sp,sp,-32
    8000006c:	ec22                	sd	s0,24(sp)
    8000006e:	1000                	addi	s0,sp,32
    80000070:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw mepc, %0" : : "r" (x));
    80000074:	fe843783          	ld	a5,-24(s0)
    80000078:	34179073          	csrw	mepc,a5
}
    8000007c:	0001                	nop
    8000007e:	6462                	ld	s0,24(sp)
    80000080:	6105                	addi	sp,sp,32
    80000082:	8082                	ret

0000000080000084 <r_sie>:
#define SIE_SEIE (1L << 9) // external
#define SIE_STIE (1L << 5) // timer
#define SIE_SSIE (1L << 1) // software
static inline uint64
r_sie()
{
    80000084:	1101                	addi	sp,sp,-32
    80000086:	ec22                	sd	s0,24(sp)
    80000088:	1000                	addi	s0,sp,32
  uint64 x;
  asm volatile("csrr %0, sie" : "=r" (x) );
    8000008a:	104027f3          	csrr	a5,sie
    8000008e:	fef43423          	sd	a5,-24(s0)
  return x;
    80000092:	fe843783          	ld	a5,-24(s0)
}
    80000096:	853e                	mv	a0,a5
    80000098:	6462                	ld	s0,24(sp)
    8000009a:	6105                	addi	sp,sp,32
    8000009c:	8082                	ret

000000008000009e <w_sie>:

static inline void 
w_sie(uint64 x)
{
    8000009e:	1101                	addi	sp,sp,-32
    800000a0:	ec22                	sd	s0,24(sp)
    800000a2:	1000                	addi	s0,sp,32
    800000a4:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw sie, %0" : : "r" (x));
    800000a8:	fe843783          	ld	a5,-24(s0)
    800000ac:	10479073          	csrw	sie,a5
}
    800000b0:	0001                	nop
    800000b2:	6462                	ld	s0,24(sp)
    800000b4:	6105                	addi	sp,sp,32
    800000b6:	8082                	ret

00000000800000b8 <r_mie>:
#define MIE_MEIE (1L << 11) // external
#define MIE_MTIE (1L << 7)  // timer
#define MIE_MSIE (1L << 3)  // software
static inline uint64
r_mie()
{
    800000b8:	1101                	addi	sp,sp,-32
    800000ba:	ec22                	sd	s0,24(sp)
    800000bc:	1000                	addi	s0,sp,32
  uint64 x;
  asm volatile("csrr %0, mie" : "=r" (x) );
    800000be:	304027f3          	csrr	a5,mie
    800000c2:	fef43423          	sd	a5,-24(s0)
  return x;
    800000c6:	fe843783          	ld	a5,-24(s0)
}
    800000ca:	853e                	mv	a0,a5
    800000cc:	6462                	ld	s0,24(sp)
    800000ce:	6105                	addi	sp,sp,32
    800000d0:	8082                	ret

00000000800000d2 <w_mie>:

static inline void 
w_mie(uint64 x)
{
    800000d2:	1101                	addi	sp,sp,-32
    800000d4:	ec22                	sd	s0,24(sp)
    800000d6:	1000                	addi	s0,sp,32
    800000d8:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw mie, %0" : : "r" (x));
    800000dc:	fe843783          	ld	a5,-24(s0)
    800000e0:	30479073          	csrw	mie,a5
}
    800000e4:	0001                	nop
    800000e6:	6462                	ld	s0,24(sp)
    800000e8:	6105                	addi	sp,sp,32
    800000ea:	8082                	ret

00000000800000ec <w_medeleg>:
  return x;
}

static inline void 
w_medeleg(uint64 x)
{
    800000ec:	1101                	addi	sp,sp,-32
    800000ee:	ec22                	sd	s0,24(sp)
    800000f0:	1000                	addi	s0,sp,32
    800000f2:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw medeleg, %0" : : "r" (x));
    800000f6:	fe843783          	ld	a5,-24(s0)
    800000fa:	30279073          	csrw	medeleg,a5
}
    800000fe:	0001                	nop
    80000100:	6462                	ld	s0,24(sp)
    80000102:	6105                	addi	sp,sp,32
    80000104:	8082                	ret

0000000080000106 <w_mideleg>:
  return x;
}

static inline void 
w_mideleg(uint64 x)
{
    80000106:	1101                	addi	sp,sp,-32
    80000108:	ec22                	sd	s0,24(sp)
    8000010a:	1000                	addi	s0,sp,32
    8000010c:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw mideleg, %0" : : "r" (x));
    80000110:	fe843783          	ld	a5,-24(s0)
    80000114:	30379073          	csrw	mideleg,a5
}
    80000118:	0001                	nop
    8000011a:	6462                	ld	s0,24(sp)
    8000011c:	6105                	addi	sp,sp,32
    8000011e:	8082                	ret

0000000080000120 <w_mtvec>:
}

// Machine-mode interrupt vector
static inline void 
w_mtvec(uint64 x)
{
    80000120:	1101                	addi	sp,sp,-32
    80000122:	ec22                	sd	s0,24(sp)
    80000124:	1000                	addi	s0,sp,32
    80000126:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw mtvec, %0" : : "r" (x));
    8000012a:	fe843783          	ld	a5,-24(s0)
    8000012e:	30579073          	csrw	mtvec,a5
}
    80000132:	0001                	nop
    80000134:	6462                	ld	s0,24(sp)
    80000136:	6105                	addi	sp,sp,32
    80000138:	8082                	ret

000000008000013a <w_satp>:

// supervisor address translation and protection;
// holds the address of the page table.
static inline void 
w_satp(uint64 x)
{
    8000013a:	1101                	addi	sp,sp,-32
    8000013c:	ec22                	sd	s0,24(sp)
    8000013e:	1000                	addi	s0,sp,32
    80000140:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw satp, %0" : : "r" (x));
    80000144:	fe843783          	ld	a5,-24(s0)
    80000148:	18079073          	csrw	satp,a5
}
    8000014c:	0001                	nop
    8000014e:	6462                	ld	s0,24(sp)
    80000150:	6105                	addi	sp,sp,32
    80000152:	8082                	ret

0000000080000154 <w_mscratch>:
  asm volatile("csrw sscratch, %0" : : "r" (x));
}

static inline void 
w_mscratch(uint64 x)
{
    80000154:	1101                	addi	sp,sp,-32
    80000156:	ec22                	sd	s0,24(sp)
    80000158:	1000                	addi	s0,sp,32
    8000015a:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw mscratch, %0" : : "r" (x));
    8000015e:	fe843783          	ld	a5,-24(s0)
    80000162:	34079073          	csrw	mscratch,a5
}
    80000166:	0001                	nop
    80000168:	6462                	ld	s0,24(sp)
    8000016a:	6105                	addi	sp,sp,32
    8000016c:	8082                	ret

000000008000016e <w_tp>:
  return x;
}

static inline void 
w_tp(uint64 x)
{
    8000016e:	1101                	addi	sp,sp,-32
    80000170:	ec22                	sd	s0,24(sp)
    80000172:	1000                	addi	s0,sp,32
    80000174:	fea43423          	sd	a0,-24(s0)
  asm volatile("mv tp, %0" : : "r" (x));
    80000178:	fe843783          	ld	a5,-24(s0)
    8000017c:	823e                	mv	tp,a5
}
    8000017e:	0001                	nop
    80000180:	6462                	ld	s0,24(sp)
    80000182:	6105                	addi	sp,sp,32
    80000184:	8082                	ret

0000000080000186 <start>:
extern void timervec();

// entry.S jumps here in machine mode on stack0.
void
start()
{
    80000186:	1101                	addi	sp,sp,-32
    80000188:	ec06                	sd	ra,24(sp)
    8000018a:	e822                	sd	s0,16(sp)
    8000018c:	1000                	addi	s0,sp,32
  // set M Previous Privilege mode to Supervisor, for mret.
  unsigned long x = r_mstatus();
    8000018e:	00000097          	auipc	ra,0x0
    80000192:	ea8080e7          	jalr	-344(ra) # 80000036 <r_mstatus>
    80000196:	fea43423          	sd	a0,-24(s0)
  x &= ~MSTATUS_MPP_MASK;
    8000019a:	fe843703          	ld	a4,-24(s0)
    8000019e:	77f9                	lui	a5,0xffffe
    800001a0:	7ff78793          	addi	a5,a5,2047 # ffffffffffffe7ff <end+0xffffffff7ff8b7ff>
    800001a4:	8ff9                	and	a5,a5,a4
    800001a6:	fef43423          	sd	a5,-24(s0)
  x |= MSTATUS_MPP_S;
    800001aa:	fe843703          	ld	a4,-24(s0)
    800001ae:	6785                	lui	a5,0x1
    800001b0:	80078793          	addi	a5,a5,-2048 # 800 <_entry-0x7ffff800>
    800001b4:	8fd9                	or	a5,a5,a4
    800001b6:	fef43423          	sd	a5,-24(s0)
  w_mstatus(x);
    800001ba:	fe843503          	ld	a0,-24(s0)
    800001be:	00000097          	auipc	ra,0x0
    800001c2:	e92080e7          	jalr	-366(ra) # 80000050 <w_mstatus>

  // set M Exception Program Counter to main, for mret.
  // requires gcc -mcmodel=medany
  w_mepc((uint64)main);
    800001c6:	00001797          	auipc	a5,0x1
    800001ca:	63478793          	addi	a5,a5,1588 # 800017fa <main>
    800001ce:	853e                	mv	a0,a5
    800001d0:	00000097          	auipc	ra,0x0
    800001d4:	e9a080e7          	jalr	-358(ra) # 8000006a <w_mepc>

  // disable paging for now.
  w_satp(0);
    800001d8:	4501                	li	a0,0
    800001da:	00000097          	auipc	ra,0x0
    800001de:	f60080e7          	jalr	-160(ra) # 8000013a <w_satp>

  // delegate all interrupts and exceptions to supervisor mode.
  w_medeleg(0xffff);
    800001e2:	67c1                	lui	a5,0x10
    800001e4:	fff78513          	addi	a0,a5,-1 # ffff <_entry-0x7fff0001>
    800001e8:	00000097          	auipc	ra,0x0
    800001ec:	f04080e7          	jalr	-252(ra) # 800000ec <w_medeleg>
  w_mideleg(0xffff);
    800001f0:	67c1                	lui	a5,0x10
    800001f2:	fff78513          	addi	a0,a5,-1 # ffff <_entry-0x7fff0001>
    800001f6:	00000097          	auipc	ra,0x0
    800001fa:	f10080e7          	jalr	-240(ra) # 80000106 <w_mideleg>
  w_sie(r_sie() | SIE_SEIE | SIE_STIE | SIE_SSIE);
    800001fe:	00000097          	auipc	ra,0x0
    80000202:	e86080e7          	jalr	-378(ra) # 80000084 <r_sie>
    80000206:	87aa                	mv	a5,a0
    80000208:	2227e793          	ori	a5,a5,546
    8000020c:	853e                	mv	a0,a5
    8000020e:	00000097          	auipc	ra,0x0
    80000212:	e90080e7          	jalr	-368(ra) # 8000009e <w_sie>

  // ask for clock interrupts.
  timerinit();
    80000216:	00000097          	auipc	ra,0x0
    8000021a:	032080e7          	jalr	50(ra) # 80000248 <timerinit>

  // keep each CPU's hartid in its tp register, for cpuid().
  int id = r_mhartid();
    8000021e:	00000097          	auipc	ra,0x0
    80000222:	dfe080e7          	jalr	-514(ra) # 8000001c <r_mhartid>
    80000226:	87aa                	mv	a5,a0
    80000228:	fef42223          	sw	a5,-28(s0)
  w_tp(id);
    8000022c:	fe442783          	lw	a5,-28(s0)
    80000230:	853e                	mv	a0,a5
    80000232:	00000097          	auipc	ra,0x0
    80000236:	f3c080e7          	jalr	-196(ra) # 8000016e <w_tp>

  // switch to supervisor mode and jump to main().
  asm volatile("mret");
    8000023a:	30200073          	mret
}
    8000023e:	0001                	nop
    80000240:	60e2                	ld	ra,24(sp)
    80000242:	6442                	ld	s0,16(sp)
    80000244:	6105                	addi	sp,sp,32
    80000246:	8082                	ret

0000000080000248 <timerinit>:
// which arrive at timervec in kernelvec.S,
// which turns them into software interrupts for
// devintr() in trap.c.
void
timerinit()
{
    80000248:	1101                	addi	sp,sp,-32
    8000024a:	ec06                	sd	ra,24(sp)
    8000024c:	e822                	sd	s0,16(sp)
    8000024e:	1000                	addi	s0,sp,32
  // each CPU has a separate source of timer interrupts.
  int id = r_mhartid();
    80000250:	00000097          	auipc	ra,0x0
    80000254:	dcc080e7          	jalr	-564(ra) # 8000001c <r_mhartid>
    80000258:	87aa                	mv	a5,a0
    8000025a:	fef42623          	sw	a5,-20(s0)

  // ask the CLINT for a timer interrupt.
  int interval = 1000000; // cycles; about 1/10th second in qemu.
    8000025e:	000f47b7          	lui	a5,0xf4
    80000262:	24078793          	addi	a5,a5,576 # f4240 <_entry-0x7ff0bdc0>
    80000266:	fef42423          	sw	a5,-24(s0)
  *(uint64*)CLINT_MTIMECMP(id) = *(uint64*)CLINT_MTIME + interval;
    8000026a:	0200c7b7          	lui	a5,0x200c
    8000026e:	17e1                	addi	a5,a5,-8
    80000270:	6398                	ld	a4,0(a5)
    80000272:	fe842783          	lw	a5,-24(s0)
    80000276:	fec42683          	lw	a3,-20(s0)
    8000027a:	0036969b          	slliw	a3,a3,0x3
    8000027e:	2681                	sext.w	a3,a3
    80000280:	8636                	mv	a2,a3
    80000282:	020046b7          	lui	a3,0x2004
    80000286:	96b2                	add	a3,a3,a2
    80000288:	97ba                	add	a5,a5,a4
    8000028a:	e29c                	sd	a5,0(a3)

  // prepare information in scratch[] for timervec.
  // scratch[0..2] : space for timervec to save registers.
  // scratch[3] : address of CLINT MTIMECMP register.
  // scratch[4] : desired interval (in cycles) between timer interrupts.
  uint64 *scratch = &timer_scratch[id][0];
    8000028c:	fec42703          	lw	a4,-20(s0)
    80000290:	87ba                	mv	a5,a4
    80000292:	078a                	slli	a5,a5,0x2
    80000294:	97ba                	add	a5,a5,a4
    80000296:	078e                	slli	a5,a5,0x3
    80000298:	00015717          	auipc	a4,0x15
    8000029c:	d9870713          	addi	a4,a4,-616 # 80015030 <timer_scratch>
    800002a0:	97ba                	add	a5,a5,a4
    800002a2:	fef43023          	sd	a5,-32(s0)
  scratch[3] = CLINT_MTIMECMP(id);
    800002a6:	fec42783          	lw	a5,-20(s0)
    800002aa:	0037979b          	slliw	a5,a5,0x3
    800002ae:	2781                	sext.w	a5,a5
    800002b0:	873e                	mv	a4,a5
    800002b2:	020047b7          	lui	a5,0x2004
    800002b6:	973e                	add	a4,a4,a5
    800002b8:	fe043783          	ld	a5,-32(s0)
    800002bc:	07e1                	addi	a5,a5,24
    800002be:	e398                	sd	a4,0(a5)
  scratch[4] = interval;
    800002c0:	fe043783          	ld	a5,-32(s0)
    800002c4:	02078793          	addi	a5,a5,32 # 2004020 <_entry-0x7dffbfe0>
    800002c8:	fe842703          	lw	a4,-24(s0)
    800002cc:	e398                	sd	a4,0(a5)
  w_mscratch((uint64)scratch);
    800002ce:	fe043783          	ld	a5,-32(s0)
    800002d2:	853e                	mv	a0,a5
    800002d4:	00000097          	auipc	ra,0x0
    800002d8:	e80080e7          	jalr	-384(ra) # 80000154 <w_mscratch>

  // set the machine-mode trap handler.
  w_mtvec((uint64)timervec);
    800002dc:	00009797          	auipc	a5,0x9
    800002e0:	cf478793          	addi	a5,a5,-780 # 80008fd0 <timervec>
    800002e4:	853e                	mv	a0,a5
    800002e6:	00000097          	auipc	ra,0x0
    800002ea:	e3a080e7          	jalr	-454(ra) # 80000120 <w_mtvec>

  // enable machine-mode interrupts.
  w_mstatus(r_mstatus() | MSTATUS_MIE);
    800002ee:	00000097          	auipc	ra,0x0
    800002f2:	d48080e7          	jalr	-696(ra) # 80000036 <r_mstatus>
    800002f6:	87aa                	mv	a5,a0
    800002f8:	0087e793          	ori	a5,a5,8
    800002fc:	853e                	mv	a0,a5
    800002fe:	00000097          	auipc	ra,0x0
    80000302:	d52080e7          	jalr	-686(ra) # 80000050 <w_mstatus>

  // enable machine-mode timer interrupts.
  w_mie(r_mie() | MIE_MTIE);
    80000306:	00000097          	auipc	ra,0x0
    8000030a:	db2080e7          	jalr	-590(ra) # 800000b8 <r_mie>
    8000030e:	87aa                	mv	a5,a0
    80000310:	0807e793          	ori	a5,a5,128
    80000314:	853e                	mv	a0,a5
    80000316:	00000097          	auipc	ra,0x0
    8000031a:	dbc080e7          	jalr	-580(ra) # 800000d2 <w_mie>
}
    8000031e:	0001                	nop
    80000320:	60e2                	ld	ra,24(sp)
    80000322:	6442                	ld	s0,16(sp)
    80000324:	6105                	addi	sp,sp,32
    80000326:	8082                	ret

0000000080000328 <consputc>:
// called by printf, and to echo input characters,
// but not from write().
//
void
consputc(int c)
{
    80000328:	1101                	addi	sp,sp,-32
    8000032a:	ec06                	sd	ra,24(sp)
    8000032c:	e822                	sd	s0,16(sp)
    8000032e:	1000                	addi	s0,sp,32
    80000330:	87aa                	mv	a5,a0
    80000332:	fef42623          	sw	a5,-20(s0)
  if(c == BACKSPACE){
    80000336:	fec42783          	lw	a5,-20(s0)
    8000033a:	0007871b          	sext.w	a4,a5
    8000033e:	10000793          	li	a5,256
    80000342:	02f71363          	bne	a4,a5,80000368 <consputc+0x40>
    // if the user typed backspace, overwrite with a space.
    uartputc_sync('\b'); uartputc_sync(' '); uartputc_sync('\b');
    80000346:	4521                	li	a0,8
    80000348:	00001097          	auipc	ra,0x1
    8000034c:	af6080e7          	jalr	-1290(ra) # 80000e3e <uartputc_sync>
    80000350:	02000513          	li	a0,32
    80000354:	00001097          	auipc	ra,0x1
    80000358:	aea080e7          	jalr	-1302(ra) # 80000e3e <uartputc_sync>
    8000035c:	4521                	li	a0,8
    8000035e:	00001097          	auipc	ra,0x1
    80000362:	ae0080e7          	jalr	-1312(ra) # 80000e3e <uartputc_sync>
  } else {
    uartputc_sync(c);
  }
}
    80000366:	a801                	j	80000376 <consputc+0x4e>
    uartputc_sync(c);
    80000368:	fec42783          	lw	a5,-20(s0)
    8000036c:	853e                	mv	a0,a5
    8000036e:	00001097          	auipc	ra,0x1
    80000372:	ad0080e7          	jalr	-1328(ra) # 80000e3e <uartputc_sync>
}
    80000376:	0001                	nop
    80000378:	60e2                	ld	ra,24(sp)
    8000037a:	6442                	ld	s0,16(sp)
    8000037c:	6105                	addi	sp,sp,32
    8000037e:	8082                	ret

0000000080000380 <consolewrite>:
//
// user write()s to the console go here.
//
int
consolewrite(int user_src, uint64 src, int n)
{
    80000380:	7179                	addi	sp,sp,-48
    80000382:	f406                	sd	ra,40(sp)
    80000384:	f022                	sd	s0,32(sp)
    80000386:	1800                	addi	s0,sp,48
    80000388:	87aa                	mv	a5,a0
    8000038a:	fcb43823          	sd	a1,-48(s0)
    8000038e:	8732                	mv	a4,a2
    80000390:	fcf42e23          	sw	a5,-36(s0)
    80000394:	87ba                	mv	a5,a4
    80000396:	fcf42c23          	sw	a5,-40(s0)
  int i;

  acquire(&cons.lock);
    8000039a:	00015517          	auipc	a0,0x15
    8000039e:	dd650513          	addi	a0,a0,-554 # 80015170 <cons>
    800003a2:	00001097          	auipc	ra,0x1
    800003a6:	ede080e7          	jalr	-290(ra) # 80001280 <acquire>
  for(i = 0; i < n; i++){
    800003aa:	fe042623          	sw	zero,-20(s0)
    800003ae:	a0a1                	j	800003f6 <consolewrite+0x76>
    char c;
    if(either_copyin(&c, user_src, src+i, 1) == -1)
    800003b0:	fec42703          	lw	a4,-20(s0)
    800003b4:	fd043783          	ld	a5,-48(s0)
    800003b8:	00f70633          	add	a2,a4,a5
    800003bc:	fdc42703          	lw	a4,-36(s0)
    800003c0:	feb40793          	addi	a5,s0,-21
    800003c4:	4685                	li	a3,1
    800003c6:	85ba                	mv	a1,a4
    800003c8:	853e                	mv	a0,a5
    800003ca:	00003097          	auipc	ra,0x3
    800003ce:	3fe080e7          	jalr	1022(ra) # 800037c8 <either_copyin>
    800003d2:	87aa                	mv	a5,a0
    800003d4:	873e                	mv	a4,a5
    800003d6:	57fd                	li	a5,-1
    800003d8:	02f70863          	beq	a4,a5,80000408 <consolewrite+0x88>
      break;
    uartputc(c);
    800003dc:	feb44783          	lbu	a5,-21(s0)
    800003e0:	2781                	sext.w	a5,a5
    800003e2:	853e                	mv	a0,a5
    800003e4:	00001097          	auipc	ra,0x1
    800003e8:	970080e7          	jalr	-1680(ra) # 80000d54 <uartputc>
  for(i = 0; i < n; i++){
    800003ec:	fec42783          	lw	a5,-20(s0)
    800003f0:	2785                	addiw	a5,a5,1
    800003f2:	fef42623          	sw	a5,-20(s0)
    800003f6:	fec42703          	lw	a4,-20(s0)
    800003fa:	fd842783          	lw	a5,-40(s0)
    800003fe:	2701                	sext.w	a4,a4
    80000400:	2781                	sext.w	a5,a5
    80000402:	faf747e3          	blt	a4,a5,800003b0 <consolewrite+0x30>
    80000406:	a011                	j	8000040a <consolewrite+0x8a>
      break;
    80000408:	0001                	nop
  }
  release(&cons.lock);
    8000040a:	00015517          	auipc	a0,0x15
    8000040e:	d6650513          	addi	a0,a0,-666 # 80015170 <cons>
    80000412:	00001097          	auipc	ra,0x1
    80000416:	ed2080e7          	jalr	-302(ra) # 800012e4 <release>

  return i;
    8000041a:	fec42783          	lw	a5,-20(s0)
}
    8000041e:	853e                	mv	a0,a5
    80000420:	70a2                	ld	ra,40(sp)
    80000422:	7402                	ld	s0,32(sp)
    80000424:	6145                	addi	sp,sp,48
    80000426:	8082                	ret

0000000080000428 <consoleread>:
// user_dist indicates whether dst is a user
// or kernel address.
//
int
consoleread(int user_dst, uint64 dst, int n)
{
    80000428:	7179                	addi	sp,sp,-48
    8000042a:	f406                	sd	ra,40(sp)
    8000042c:	f022                	sd	s0,32(sp)
    8000042e:	1800                	addi	s0,sp,48
    80000430:	87aa                	mv	a5,a0
    80000432:	fcb43823          	sd	a1,-48(s0)
    80000436:	8732                	mv	a4,a2
    80000438:	fcf42e23          	sw	a5,-36(s0)
    8000043c:	87ba                	mv	a5,a4
    8000043e:	fcf42c23          	sw	a5,-40(s0)
  uint target;
  int c;
  char cbuf;

  target = n;
    80000442:	fd842783          	lw	a5,-40(s0)
    80000446:	fef42623          	sw	a5,-20(s0)
  acquire(&cons.lock);
    8000044a:	00015517          	auipc	a0,0x15
    8000044e:	d2650513          	addi	a0,a0,-730 # 80015170 <cons>
    80000452:	00001097          	auipc	ra,0x1
    80000456:	e2e080e7          	jalr	-466(ra) # 80001280 <acquire>
  while(n > 0){
    8000045a:	a215                	j	8000057e <consoleread+0x156>
    // wait until interrupt handler has put some
    // input into cons.buffer.
    while(cons.r == cons.w){
      if(myproc()->killed){
    8000045c:	00002097          	auipc	ra,0x2
    80000460:	39c080e7          	jalr	924(ra) # 800027f8 <myproc>
    80000464:	87aa                	mv	a5,a0
    80000466:	5b9c                	lw	a5,48(a5)
    80000468:	cb99                	beqz	a5,8000047e <consoleread+0x56>
        release(&cons.lock);
    8000046a:	00015517          	auipc	a0,0x15
    8000046e:	d0650513          	addi	a0,a0,-762 # 80015170 <cons>
    80000472:	00001097          	auipc	ra,0x1
    80000476:	e72080e7          	jalr	-398(ra) # 800012e4 <release>
        return -1;
    8000047a:	57fd                	li	a5,-1
    8000047c:	aa25                	j	800005b4 <consoleread+0x18c>
      }
      sleep(&cons.r, &cons.lock);
    8000047e:	00015597          	auipc	a1,0x15
    80000482:	cf258593          	addi	a1,a1,-782 # 80015170 <cons>
    80000486:	00015517          	auipc	a0,0x15
    8000048a:	d8250513          	addi	a0,a0,-638 # 80015208 <cons+0x98>
    8000048e:	00003097          	auipc	ra,0x3
    80000492:	0a6080e7          	jalr	166(ra) # 80003534 <sleep>
    while(cons.r == cons.w){
    80000496:	00015797          	auipc	a5,0x15
    8000049a:	cda78793          	addi	a5,a5,-806 # 80015170 <cons>
    8000049e:	0987a703          	lw	a4,152(a5)
    800004a2:	00015797          	auipc	a5,0x15
    800004a6:	cce78793          	addi	a5,a5,-818 # 80015170 <cons>
    800004aa:	09c7a783          	lw	a5,156(a5)
    800004ae:	faf707e3          	beq	a4,a5,8000045c <consoleread+0x34>
    }

    c = cons.buf[cons.r++ % INPUT_BUF];
    800004b2:	00015797          	auipc	a5,0x15
    800004b6:	cbe78793          	addi	a5,a5,-834 # 80015170 <cons>
    800004ba:	0987a783          	lw	a5,152(a5)
    800004be:	2781                	sext.w	a5,a5
    800004c0:	0017871b          	addiw	a4,a5,1
    800004c4:	0007069b          	sext.w	a3,a4
    800004c8:	00015717          	auipc	a4,0x15
    800004cc:	ca870713          	addi	a4,a4,-856 # 80015170 <cons>
    800004d0:	08d72c23          	sw	a3,152(a4)
    800004d4:	07f7f793          	andi	a5,a5,127
    800004d8:	2781                	sext.w	a5,a5
    800004da:	00015717          	auipc	a4,0x15
    800004de:	c9670713          	addi	a4,a4,-874 # 80015170 <cons>
    800004e2:	1782                	slli	a5,a5,0x20
    800004e4:	9381                	srli	a5,a5,0x20
    800004e6:	97ba                	add	a5,a5,a4
    800004e8:	0187c783          	lbu	a5,24(a5)
    800004ec:	fef42423          	sw	a5,-24(s0)

    if(c == C('D')){  // end-of-file
    800004f0:	fe842783          	lw	a5,-24(s0)
    800004f4:	0007871b          	sext.w	a4,a5
    800004f8:	4791                	li	a5,4
    800004fa:	02f71963          	bne	a4,a5,8000052c <consoleread+0x104>
      if(n < target){
    800004fe:	fd842703          	lw	a4,-40(s0)
    80000502:	fec42783          	lw	a5,-20(s0)
    80000506:	2781                	sext.w	a5,a5
    80000508:	08f77163          	bgeu	a4,a5,8000058a <consoleread+0x162>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        cons.r--;
    8000050c:	00015797          	auipc	a5,0x15
    80000510:	c6478793          	addi	a5,a5,-924 # 80015170 <cons>
    80000514:	0987a783          	lw	a5,152(a5)
    80000518:	37fd                	addiw	a5,a5,-1
    8000051a:	0007871b          	sext.w	a4,a5
    8000051e:	00015797          	auipc	a5,0x15
    80000522:	c5278793          	addi	a5,a5,-942 # 80015170 <cons>
    80000526:	08e7ac23          	sw	a4,152(a5)
      }
      break;
    8000052a:	a085                	j	8000058a <consoleread+0x162>
    }

    // copy the input byte to the user-space buffer.
    cbuf = c;
    8000052c:	fe842783          	lw	a5,-24(s0)
    80000530:	0ff7f793          	andi	a5,a5,255
    80000534:	fef403a3          	sb	a5,-25(s0)
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    80000538:	fe740713          	addi	a4,s0,-25
    8000053c:	fdc42783          	lw	a5,-36(s0)
    80000540:	4685                	li	a3,1
    80000542:	863a                	mv	a2,a4
    80000544:	fd043583          	ld	a1,-48(s0)
    80000548:	853e                	mv	a0,a5
    8000054a:	00003097          	auipc	ra,0x3
    8000054e:	204080e7          	jalr	516(ra) # 8000374e <either_copyout>
    80000552:	87aa                	mv	a5,a0
    80000554:	873e                	mv	a4,a5
    80000556:	57fd                	li	a5,-1
    80000558:	02f70b63          	beq	a4,a5,8000058e <consoleread+0x166>
      break;

    dst++;
    8000055c:	fd043783          	ld	a5,-48(s0)
    80000560:	0785                	addi	a5,a5,1
    80000562:	fcf43823          	sd	a5,-48(s0)
    --n;
    80000566:	fd842783          	lw	a5,-40(s0)
    8000056a:	37fd                	addiw	a5,a5,-1
    8000056c:	fcf42c23          	sw	a5,-40(s0)

    if(c == '\n'){
    80000570:	fe842783          	lw	a5,-24(s0)
    80000574:	0007871b          	sext.w	a4,a5
    80000578:	47a9                	li	a5,10
    8000057a:	00f70c63          	beq	a4,a5,80000592 <consoleread+0x16a>
  while(n > 0){
    8000057e:	fd842783          	lw	a5,-40(s0)
    80000582:	2781                	sext.w	a5,a5
    80000584:	f0f049e3          	bgtz	a5,80000496 <consoleread+0x6e>
    80000588:	a031                	j	80000594 <consoleread+0x16c>
      break;
    8000058a:	0001                	nop
    8000058c:	a021                	j	80000594 <consoleread+0x16c>
      break;
    8000058e:	0001                	nop
    80000590:	a011                	j	80000594 <consoleread+0x16c>
      // a whole line has arrived, return to
      // the user-level read().
      break;
    80000592:	0001                	nop
    }
  }
  release(&cons.lock);
    80000594:	00015517          	auipc	a0,0x15
    80000598:	bdc50513          	addi	a0,a0,-1060 # 80015170 <cons>
    8000059c:	00001097          	auipc	ra,0x1
    800005a0:	d48080e7          	jalr	-696(ra) # 800012e4 <release>

  return target - n;
    800005a4:	fd842783          	lw	a5,-40(s0)
    800005a8:	fec42703          	lw	a4,-20(s0)
    800005ac:	40f707bb          	subw	a5,a4,a5
    800005b0:	2781                	sext.w	a5,a5
    800005b2:	2781                	sext.w	a5,a5
}
    800005b4:	853e                	mv	a0,a5
    800005b6:	70a2                	ld	ra,40(sp)
    800005b8:	7402                	ld	s0,32(sp)
    800005ba:	6145                	addi	sp,sp,48
    800005bc:	8082                	ret

00000000800005be <consoleintr>:
// do erase/kill processing, append to cons.buf,
// wake up consoleread() if a whole line has arrived.
//
void
consoleintr(int c)
{
    800005be:	1101                	addi	sp,sp,-32
    800005c0:	ec06                	sd	ra,24(sp)
    800005c2:	e822                	sd	s0,16(sp)
    800005c4:	1000                	addi	s0,sp,32
    800005c6:	87aa                	mv	a5,a0
    800005c8:	fef42623          	sw	a5,-20(s0)
  acquire(&cons.lock);
    800005cc:	00015517          	auipc	a0,0x15
    800005d0:	ba450513          	addi	a0,a0,-1116 # 80015170 <cons>
    800005d4:	00001097          	auipc	ra,0x1
    800005d8:	cac080e7          	jalr	-852(ra) # 80001280 <acquire>

  switch(c){
    800005dc:	fec42783          	lw	a5,-20(s0)
    800005e0:	0007871b          	sext.w	a4,a5
    800005e4:	07f00793          	li	a5,127
    800005e8:	0cf70763          	beq	a4,a5,800006b6 <consoleintr+0xf8>
    800005ec:	fec42783          	lw	a5,-20(s0)
    800005f0:	0007871b          	sext.w	a4,a5
    800005f4:	07f00793          	li	a5,127
    800005f8:	10e7c363          	blt	a5,a4,800006fe <consoleintr+0x140>
    800005fc:	fec42783          	lw	a5,-20(s0)
    80000600:	0007871b          	sext.w	a4,a5
    80000604:	47d5                	li	a5,21
    80000606:	06f70163          	beq	a4,a5,80000668 <consoleintr+0xaa>
    8000060a:	fec42783          	lw	a5,-20(s0)
    8000060e:	0007871b          	sext.w	a4,a5
    80000612:	47d5                	li	a5,21
    80000614:	0ee7c563          	blt	a5,a4,800006fe <consoleintr+0x140>
    80000618:	fec42783          	lw	a5,-20(s0)
    8000061c:	0007871b          	sext.w	a4,a5
    80000620:	47a1                	li	a5,8
    80000622:	08f70a63          	beq	a4,a5,800006b6 <consoleintr+0xf8>
    80000626:	fec42783          	lw	a5,-20(s0)
    8000062a:	0007871b          	sext.w	a4,a5
    8000062e:	47c1                	li	a5,16
    80000630:	0cf71763          	bne	a4,a5,800006fe <consoleintr+0x140>
  case C('P'):  // Print process list.
    procdump();
    80000634:	00003097          	auipc	ra,0x3
    80000638:	20e080e7          	jalr	526(ra) # 80003842 <procdump>
    break;
    8000063c:	aac1                	j	8000080c <consoleintr+0x24e>
  case C('U'):  // Kill line.
    while(cons.e != cons.w &&
          cons.buf[(cons.e-1) % INPUT_BUF] != '\n'){
      cons.e--;
    8000063e:	00015797          	auipc	a5,0x15
    80000642:	b3278793          	addi	a5,a5,-1230 # 80015170 <cons>
    80000646:	0a07a783          	lw	a5,160(a5)
    8000064a:	37fd                	addiw	a5,a5,-1
    8000064c:	0007871b          	sext.w	a4,a5
    80000650:	00015797          	auipc	a5,0x15
    80000654:	b2078793          	addi	a5,a5,-1248 # 80015170 <cons>
    80000658:	0ae7a023          	sw	a4,160(a5)
      consputc(BACKSPACE);
    8000065c:	10000513          	li	a0,256
    80000660:	00000097          	auipc	ra,0x0
    80000664:	cc8080e7          	jalr	-824(ra) # 80000328 <consputc>
    while(cons.e != cons.w &&
    80000668:	00015797          	auipc	a5,0x15
    8000066c:	b0878793          	addi	a5,a5,-1272 # 80015170 <cons>
    80000670:	0a07a703          	lw	a4,160(a5)
    80000674:	00015797          	auipc	a5,0x15
    80000678:	afc78793          	addi	a5,a5,-1284 # 80015170 <cons>
    8000067c:	09c7a783          	lw	a5,156(a5)
    80000680:	18f70163          	beq	a4,a5,80000802 <consoleintr+0x244>
          cons.buf[(cons.e-1) % INPUT_BUF] != '\n'){
    80000684:	00015797          	auipc	a5,0x15
    80000688:	aec78793          	addi	a5,a5,-1300 # 80015170 <cons>
    8000068c:	0a07a783          	lw	a5,160(a5)
    80000690:	37fd                	addiw	a5,a5,-1
    80000692:	2781                	sext.w	a5,a5
    80000694:	07f7f793          	andi	a5,a5,127
    80000698:	2781                	sext.w	a5,a5
    8000069a:	00015717          	auipc	a4,0x15
    8000069e:	ad670713          	addi	a4,a4,-1322 # 80015170 <cons>
    800006a2:	1782                	slli	a5,a5,0x20
    800006a4:	9381                	srli	a5,a5,0x20
    800006a6:	97ba                	add	a5,a5,a4
    800006a8:	0187c783          	lbu	a5,24(a5)
    while(cons.e != cons.w &&
    800006ac:	873e                	mv	a4,a5
    800006ae:	47a9                	li	a5,10
    800006b0:	f8f717e3          	bne	a4,a5,8000063e <consoleintr+0x80>
    }
    break;
    800006b4:	a2b9                	j	80000802 <consoleintr+0x244>
  case C('H'): // Backspace
  case '\x7f':
    if(cons.e != cons.w){
    800006b6:	00015797          	auipc	a5,0x15
    800006ba:	aba78793          	addi	a5,a5,-1350 # 80015170 <cons>
    800006be:	0a07a703          	lw	a4,160(a5)
    800006c2:	00015797          	auipc	a5,0x15
    800006c6:	aae78793          	addi	a5,a5,-1362 # 80015170 <cons>
    800006ca:	09c7a783          	lw	a5,156(a5)
    800006ce:	12f70c63          	beq	a4,a5,80000806 <consoleintr+0x248>
      cons.e--;
    800006d2:	00015797          	auipc	a5,0x15
    800006d6:	a9e78793          	addi	a5,a5,-1378 # 80015170 <cons>
    800006da:	0a07a783          	lw	a5,160(a5)
    800006de:	37fd                	addiw	a5,a5,-1
    800006e0:	0007871b          	sext.w	a4,a5
    800006e4:	00015797          	auipc	a5,0x15
    800006e8:	a8c78793          	addi	a5,a5,-1396 # 80015170 <cons>
    800006ec:	0ae7a023          	sw	a4,160(a5)
      consputc(BACKSPACE);
    800006f0:	10000513          	li	a0,256
    800006f4:	00000097          	auipc	ra,0x0
    800006f8:	c34080e7          	jalr	-972(ra) # 80000328 <consputc>
    }
    break;
    800006fc:	a229                	j	80000806 <consoleintr+0x248>
  default:
    if(c != 0 && cons.e-cons.r < INPUT_BUF){
    800006fe:	fec42783          	lw	a5,-20(s0)
    80000702:	2781                	sext.w	a5,a5
    80000704:	10078363          	beqz	a5,8000080a <consoleintr+0x24c>
    80000708:	00015797          	auipc	a5,0x15
    8000070c:	a6878793          	addi	a5,a5,-1432 # 80015170 <cons>
    80000710:	0a07a703          	lw	a4,160(a5)
    80000714:	00015797          	auipc	a5,0x15
    80000718:	a5c78793          	addi	a5,a5,-1444 # 80015170 <cons>
    8000071c:	0987a783          	lw	a5,152(a5)
    80000720:	40f707bb          	subw	a5,a4,a5
    80000724:	2781                	sext.w	a5,a5
    80000726:	873e                	mv	a4,a5
    80000728:	07f00793          	li	a5,127
    8000072c:	0ce7ef63          	bltu	a5,a4,8000080a <consoleintr+0x24c>
      c = (c == '\r') ? '\n' : c;
    80000730:	fec42783          	lw	a5,-20(s0)
    80000734:	0007871b          	sext.w	a4,a5
    80000738:	47b5                	li	a5,13
    8000073a:	00f70563          	beq	a4,a5,80000744 <consoleintr+0x186>
    8000073e:	fec42783          	lw	a5,-20(s0)
    80000742:	a011                	j	80000746 <consoleintr+0x188>
    80000744:	47a9                	li	a5,10
    80000746:	fef42623          	sw	a5,-20(s0)

      // echo back to the user.
      consputc(c);
    8000074a:	fec42783          	lw	a5,-20(s0)
    8000074e:	853e                	mv	a0,a5
    80000750:	00000097          	auipc	ra,0x0
    80000754:	bd8080e7          	jalr	-1064(ra) # 80000328 <consputc>

      // store for consumption by consoleread().
      cons.buf[cons.e++ % INPUT_BUF] = c;
    80000758:	00015797          	auipc	a5,0x15
    8000075c:	a1878793          	addi	a5,a5,-1512 # 80015170 <cons>
    80000760:	0a07a783          	lw	a5,160(a5)
    80000764:	2781                	sext.w	a5,a5
    80000766:	0017871b          	addiw	a4,a5,1
    8000076a:	0007069b          	sext.w	a3,a4
    8000076e:	00015717          	auipc	a4,0x15
    80000772:	a0270713          	addi	a4,a4,-1534 # 80015170 <cons>
    80000776:	0ad72023          	sw	a3,160(a4)
    8000077a:	07f7f793          	andi	a5,a5,127
    8000077e:	2781                	sext.w	a5,a5
    80000780:	fec42703          	lw	a4,-20(s0)
    80000784:	0ff77713          	andi	a4,a4,255
    80000788:	00015697          	auipc	a3,0x15
    8000078c:	9e868693          	addi	a3,a3,-1560 # 80015170 <cons>
    80000790:	1782                	slli	a5,a5,0x20
    80000792:	9381                	srli	a5,a5,0x20
    80000794:	97b6                	add	a5,a5,a3
    80000796:	00e78c23          	sb	a4,24(a5)

      if(c == '\n' || c == C('D') || cons.e == cons.r+INPUT_BUF){
    8000079a:	fec42783          	lw	a5,-20(s0)
    8000079e:	0007871b          	sext.w	a4,a5
    800007a2:	47a9                	li	a5,10
    800007a4:	02f70a63          	beq	a4,a5,800007d8 <consoleintr+0x21a>
    800007a8:	fec42783          	lw	a5,-20(s0)
    800007ac:	0007871b          	sext.w	a4,a5
    800007b0:	4791                	li	a5,4
    800007b2:	02f70363          	beq	a4,a5,800007d8 <consoleintr+0x21a>
    800007b6:	00015797          	auipc	a5,0x15
    800007ba:	9ba78793          	addi	a5,a5,-1606 # 80015170 <cons>
    800007be:	0a07a703          	lw	a4,160(a5)
    800007c2:	00015797          	auipc	a5,0x15
    800007c6:	9ae78793          	addi	a5,a5,-1618 # 80015170 <cons>
    800007ca:	0987a783          	lw	a5,152(a5)
    800007ce:	0807879b          	addiw	a5,a5,128
    800007d2:	2781                	sext.w	a5,a5
    800007d4:	02f71b63          	bne	a4,a5,8000080a <consoleintr+0x24c>
        // wake up consoleread() if a whole line (or end-of-file)
        // has arrived.
        cons.w = cons.e;
    800007d8:	00015797          	auipc	a5,0x15
    800007dc:	99878793          	addi	a5,a5,-1640 # 80015170 <cons>
    800007e0:	0a07a703          	lw	a4,160(a5)
    800007e4:	00015797          	auipc	a5,0x15
    800007e8:	98c78793          	addi	a5,a5,-1652 # 80015170 <cons>
    800007ec:	08e7ae23          	sw	a4,156(a5)
        wakeup(&cons.r);
    800007f0:	00015517          	auipc	a0,0x15
    800007f4:	a1850513          	addi	a0,a0,-1512 # 80015208 <cons+0x98>
    800007f8:	00003097          	auipc	ra,0x3
    800007fc:	dd0080e7          	jalr	-560(ra) # 800035c8 <wakeup>
      }
    }
    break;
    80000800:	a029                	j	8000080a <consoleintr+0x24c>
    break;
    80000802:	0001                	nop
    80000804:	a021                	j	8000080c <consoleintr+0x24e>
    break;
    80000806:	0001                	nop
    80000808:	a011                	j	8000080c <consoleintr+0x24e>
    break;
    8000080a:	0001                	nop
  }
  
  release(&cons.lock);
    8000080c:	00015517          	auipc	a0,0x15
    80000810:	96450513          	addi	a0,a0,-1692 # 80015170 <cons>
    80000814:	00001097          	auipc	ra,0x1
    80000818:	ad0080e7          	jalr	-1328(ra) # 800012e4 <release>
}
    8000081c:	0001                	nop
    8000081e:	60e2                	ld	ra,24(sp)
    80000820:	6442                	ld	s0,16(sp)
    80000822:	6105                	addi	sp,sp,32
    80000824:	8082                	ret

0000000080000826 <consoleinit>:

void
consoleinit(void)
{
    80000826:	1141                	addi	sp,sp,-16
    80000828:	e406                	sd	ra,8(sp)
    8000082a:	e022                	sd	s0,0(sp)
    8000082c:	0800                	addi	s0,sp,16
  initlock(&cons.lock, "cons");
    8000082e:	0000b597          	auipc	a1,0xb
    80000832:	7d258593          	addi	a1,a1,2002 # 8000c000 <etext>
    80000836:	00015517          	auipc	a0,0x15
    8000083a:	93a50513          	addi	a0,a0,-1734 # 80015170 <cons>
    8000083e:	00001097          	auipc	ra,0x1
    80000842:	a12080e7          	jalr	-1518(ra) # 80001250 <initlock>

  uartinit();
    80000846:	00000097          	auipc	ra,0x0
    8000084a:	494080e7          	jalr	1172(ra) # 80000cda <uartinit>

  // connect read and write system calls
  // to consoleread and consolewrite.
  devsw[CONSOLE].read = consoleread;
    8000084e:	0006e797          	auipc	a5,0x6e
    80000852:	2aa78793          	addi	a5,a5,682 # 8006eaf8 <devsw>
    80000856:	00000717          	auipc	a4,0x0
    8000085a:	bd270713          	addi	a4,a4,-1070 # 80000428 <consoleread>
    8000085e:	eb98                	sd	a4,16(a5)
  devsw[CONSOLE].write = consolewrite;
    80000860:	0006e797          	auipc	a5,0x6e
    80000864:	29878793          	addi	a5,a5,664 # 8006eaf8 <devsw>
    80000868:	00000717          	auipc	a4,0x0
    8000086c:	b1870713          	addi	a4,a4,-1256 # 80000380 <consolewrite>
    80000870:	ef98                	sd	a4,24(a5)
}
    80000872:	0001                	nop
    80000874:	60a2                	ld	ra,8(sp)
    80000876:	6402                	ld	s0,0(sp)
    80000878:	0141                	addi	sp,sp,16
    8000087a:	8082                	ret

000000008000087c <printint>:

static char digits[] = "0123456789abcdef";

static void
printint(int xx, int base, int sign)
{
    8000087c:	7139                	addi	sp,sp,-64
    8000087e:	fc06                	sd	ra,56(sp)
    80000880:	f822                	sd	s0,48(sp)
    80000882:	0080                	addi	s0,sp,64
    80000884:	87aa                	mv	a5,a0
    80000886:	86ae                	mv	a3,a1
    80000888:	8732                	mv	a4,a2
    8000088a:	fcf42623          	sw	a5,-52(s0)
    8000088e:	87b6                	mv	a5,a3
    80000890:	fcf42423          	sw	a5,-56(s0)
    80000894:	87ba                	mv	a5,a4
    80000896:	fcf42223          	sw	a5,-60(s0)
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
    8000089a:	fc442783          	lw	a5,-60(s0)
    8000089e:	2781                	sext.w	a5,a5
    800008a0:	c78d                	beqz	a5,800008ca <printint+0x4e>
    800008a2:	fcc42783          	lw	a5,-52(s0)
    800008a6:	01f7d79b          	srliw	a5,a5,0x1f
    800008aa:	0ff7f793          	andi	a5,a5,255
    800008ae:	fcf42223          	sw	a5,-60(s0)
    800008b2:	fc442783          	lw	a5,-60(s0)
    800008b6:	2781                	sext.w	a5,a5
    800008b8:	cb89                	beqz	a5,800008ca <printint+0x4e>
    x = -xx;
    800008ba:	fcc42783          	lw	a5,-52(s0)
    800008be:	40f007bb          	negw	a5,a5
    800008c2:	2781                	sext.w	a5,a5
    800008c4:	fef42423          	sw	a5,-24(s0)
    800008c8:	a029                	j	800008d2 <printint+0x56>
  else
    x = xx;
    800008ca:	fcc42783          	lw	a5,-52(s0)
    800008ce:	fef42423          	sw	a5,-24(s0)

  i = 0;
    800008d2:	fe042623          	sw	zero,-20(s0)
  do {
    buf[i++] = digits[x % base];
    800008d6:	fc842783          	lw	a5,-56(s0)
    800008da:	fe842703          	lw	a4,-24(s0)
    800008de:	02f777bb          	remuw	a5,a4,a5
    800008e2:	0007861b          	sext.w	a2,a5
    800008e6:	fec42783          	lw	a5,-20(s0)
    800008ea:	0017871b          	addiw	a4,a5,1
    800008ee:	fee42623          	sw	a4,-20(s0)
    800008f2:	0000c697          	auipc	a3,0xc
    800008f6:	e6e68693          	addi	a3,a3,-402 # 8000c760 <digits>
    800008fa:	02061713          	slli	a4,a2,0x20
    800008fe:	9301                	srli	a4,a4,0x20
    80000900:	9736                	add	a4,a4,a3
    80000902:	00074703          	lbu	a4,0(a4)
    80000906:	ff040693          	addi	a3,s0,-16
    8000090a:	97b6                	add	a5,a5,a3
    8000090c:	fee78423          	sb	a4,-24(a5)
  } while((x /= base) != 0);
    80000910:	fc842783          	lw	a5,-56(s0)
    80000914:	fe842703          	lw	a4,-24(s0)
    80000918:	02f757bb          	divuw	a5,a4,a5
    8000091c:	fef42423          	sw	a5,-24(s0)
    80000920:	fe842783          	lw	a5,-24(s0)
    80000924:	2781                	sext.w	a5,a5
    80000926:	fbc5                	bnez	a5,800008d6 <printint+0x5a>

  if(sign)
    80000928:	fc442783          	lw	a5,-60(s0)
    8000092c:	2781                	sext.w	a5,a5
    8000092e:	cf85                	beqz	a5,80000966 <printint+0xea>
    buf[i++] = '-';
    80000930:	fec42783          	lw	a5,-20(s0)
    80000934:	0017871b          	addiw	a4,a5,1
    80000938:	fee42623          	sw	a4,-20(s0)
    8000093c:	ff040713          	addi	a4,s0,-16
    80000940:	97ba                	add	a5,a5,a4
    80000942:	02d00713          	li	a4,45
    80000946:	fee78423          	sb	a4,-24(a5)

  while(--i >= 0)
    8000094a:	a831                	j	80000966 <printint+0xea>
    consputc(buf[i]);
    8000094c:	fec42783          	lw	a5,-20(s0)
    80000950:	ff040713          	addi	a4,s0,-16
    80000954:	97ba                	add	a5,a5,a4
    80000956:	fe87c783          	lbu	a5,-24(a5)
    8000095a:	2781                	sext.w	a5,a5
    8000095c:	853e                	mv	a0,a5
    8000095e:	00000097          	auipc	ra,0x0
    80000962:	9ca080e7          	jalr	-1590(ra) # 80000328 <consputc>
  while(--i >= 0)
    80000966:	fec42783          	lw	a5,-20(s0)
    8000096a:	37fd                	addiw	a5,a5,-1
    8000096c:	fef42623          	sw	a5,-20(s0)
    80000970:	fec42783          	lw	a5,-20(s0)
    80000974:	2781                	sext.w	a5,a5
    80000976:	fc07dbe3          	bgez	a5,8000094c <printint+0xd0>
}
    8000097a:	0001                	nop
    8000097c:	0001                	nop
    8000097e:	70e2                	ld	ra,56(sp)
    80000980:	7442                	ld	s0,48(sp)
    80000982:	6121                	addi	sp,sp,64
    80000984:	8082                	ret

0000000080000986 <printptr>:

static void
printptr(uint64 x)
{
    80000986:	7179                	addi	sp,sp,-48
    80000988:	f406                	sd	ra,40(sp)
    8000098a:	f022                	sd	s0,32(sp)
    8000098c:	1800                	addi	s0,sp,48
    8000098e:	fca43c23          	sd	a0,-40(s0)
  int i;
  consputc('0');
    80000992:	03000513          	li	a0,48
    80000996:	00000097          	auipc	ra,0x0
    8000099a:	992080e7          	jalr	-1646(ra) # 80000328 <consputc>
  consputc('x');
    8000099e:	07800513          	li	a0,120
    800009a2:	00000097          	auipc	ra,0x0
    800009a6:	986080e7          	jalr	-1658(ra) # 80000328 <consputc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    800009aa:	fe042623          	sw	zero,-20(s0)
    800009ae:	a81d                	j	800009e4 <printptr+0x5e>
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    800009b0:	fd843783          	ld	a5,-40(s0)
    800009b4:	93f1                	srli	a5,a5,0x3c
    800009b6:	0000c717          	auipc	a4,0xc
    800009ba:	daa70713          	addi	a4,a4,-598 # 8000c760 <digits>
    800009be:	97ba                	add	a5,a5,a4
    800009c0:	0007c783          	lbu	a5,0(a5)
    800009c4:	2781                	sext.w	a5,a5
    800009c6:	853e                	mv	a0,a5
    800009c8:	00000097          	auipc	ra,0x0
    800009cc:	960080e7          	jalr	-1696(ra) # 80000328 <consputc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    800009d0:	fec42783          	lw	a5,-20(s0)
    800009d4:	2785                	addiw	a5,a5,1
    800009d6:	fef42623          	sw	a5,-20(s0)
    800009da:	fd843783          	ld	a5,-40(s0)
    800009de:	0792                	slli	a5,a5,0x4
    800009e0:	fcf43c23          	sd	a5,-40(s0)
    800009e4:	fec42783          	lw	a5,-20(s0)
    800009e8:	873e                	mv	a4,a5
    800009ea:	47bd                	li	a5,15
    800009ec:	fce7f2e3          	bgeu	a5,a4,800009b0 <printptr+0x2a>
}
    800009f0:	0001                	nop
    800009f2:	0001                	nop
    800009f4:	70a2                	ld	ra,40(sp)
    800009f6:	7402                	ld	s0,32(sp)
    800009f8:	6145                	addi	sp,sp,48
    800009fa:	8082                	ret

00000000800009fc <printf>:

// Print to the console. only understands %d, %x, %p, %s.
void
printf(char *fmt, ...)
{
    800009fc:	7119                	addi	sp,sp,-128
    800009fe:	fc06                	sd	ra,56(sp)
    80000a00:	f822                	sd	s0,48(sp)
    80000a02:	0080                	addi	s0,sp,64
    80000a04:	fca43423          	sd	a0,-56(s0)
    80000a08:	e40c                	sd	a1,8(s0)
    80000a0a:	e810                	sd	a2,16(s0)
    80000a0c:	ec14                	sd	a3,24(s0)
    80000a0e:	f018                	sd	a4,32(s0)
    80000a10:	f41c                	sd	a5,40(s0)
    80000a12:	03043823          	sd	a6,48(s0)
    80000a16:	03143c23          	sd	a7,56(s0)
  va_list ap;
  int i, c, locking;
  char *s;

  locking = pr.locking;
    80000a1a:	00014797          	auipc	a5,0x14
    80000a1e:	7fe78793          	addi	a5,a5,2046 # 80015218 <pr>
    80000a22:	4f9c                	lw	a5,24(a5)
    80000a24:	fcf42e23          	sw	a5,-36(s0)
  if(locking)
    80000a28:	fdc42783          	lw	a5,-36(s0)
    80000a2c:	2781                	sext.w	a5,a5
    80000a2e:	cb89                	beqz	a5,80000a40 <printf+0x44>
    acquire(&pr.lock);
    80000a30:	00014517          	auipc	a0,0x14
    80000a34:	7e850513          	addi	a0,a0,2024 # 80015218 <pr>
    80000a38:	00001097          	auipc	ra,0x1
    80000a3c:	848080e7          	jalr	-1976(ra) # 80001280 <acquire>

  if (fmt == 0)
    80000a40:	fc843783          	ld	a5,-56(s0)
    80000a44:	eb89                	bnez	a5,80000a56 <printf+0x5a>
    panic("null fmt");
    80000a46:	0000b517          	auipc	a0,0xb
    80000a4a:	5c250513          	addi	a0,a0,1474 # 8000c008 <etext+0x8>
    80000a4e:	00000097          	auipc	ra,0x0
    80000a52:	204080e7          	jalr	516(ra) # 80000c52 <panic>

  va_start(ap, fmt);
    80000a56:	04040793          	addi	a5,s0,64
    80000a5a:	fcf43023          	sd	a5,-64(s0)
    80000a5e:	fc043783          	ld	a5,-64(s0)
    80000a62:	fc878793          	addi	a5,a5,-56
    80000a66:	fcf43823          	sd	a5,-48(s0)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    80000a6a:	fe042623          	sw	zero,-20(s0)
    80000a6e:	a24d                	j	80000c10 <printf+0x214>
    if(c != '%'){
    80000a70:	fd842783          	lw	a5,-40(s0)
    80000a74:	0007871b          	sext.w	a4,a5
    80000a78:	02500793          	li	a5,37
    80000a7c:	00f70a63          	beq	a4,a5,80000a90 <printf+0x94>
      consputc(c);
    80000a80:	fd842783          	lw	a5,-40(s0)
    80000a84:	853e                	mv	a0,a5
    80000a86:	00000097          	auipc	ra,0x0
    80000a8a:	8a2080e7          	jalr	-1886(ra) # 80000328 <consputc>
      continue;
    80000a8e:	aaa5                	j	80000c06 <printf+0x20a>
    }
    c = fmt[++i] & 0xff;
    80000a90:	fec42783          	lw	a5,-20(s0)
    80000a94:	2785                	addiw	a5,a5,1
    80000a96:	fef42623          	sw	a5,-20(s0)
    80000a9a:	fec42783          	lw	a5,-20(s0)
    80000a9e:	fc843703          	ld	a4,-56(s0)
    80000aa2:	97ba                	add	a5,a5,a4
    80000aa4:	0007c783          	lbu	a5,0(a5)
    80000aa8:	fcf42c23          	sw	a5,-40(s0)
    if(c == 0)
    80000aac:	fd842783          	lw	a5,-40(s0)
    80000ab0:	2781                	sext.w	a5,a5
    80000ab2:	16078e63          	beqz	a5,80000c2e <printf+0x232>
      break;
    switch(c){
    80000ab6:	fd842783          	lw	a5,-40(s0)
    80000aba:	0007871b          	sext.w	a4,a5
    80000abe:	07800793          	li	a5,120
    80000ac2:	08f70963          	beq	a4,a5,80000b54 <printf+0x158>
    80000ac6:	fd842783          	lw	a5,-40(s0)
    80000aca:	0007871b          	sext.w	a4,a5
    80000ace:	07800793          	li	a5,120
    80000ad2:	10e7cc63          	blt	a5,a4,80000bea <printf+0x1ee>
    80000ad6:	fd842783          	lw	a5,-40(s0)
    80000ada:	0007871b          	sext.w	a4,a5
    80000ade:	07300793          	li	a5,115
    80000ae2:	0af70563          	beq	a4,a5,80000b8c <printf+0x190>
    80000ae6:	fd842783          	lw	a5,-40(s0)
    80000aea:	0007871b          	sext.w	a4,a5
    80000aee:	07300793          	li	a5,115
    80000af2:	0ee7cc63          	blt	a5,a4,80000bea <printf+0x1ee>
    80000af6:	fd842783          	lw	a5,-40(s0)
    80000afa:	0007871b          	sext.w	a4,a5
    80000afe:	07000793          	li	a5,112
    80000b02:	06f70863          	beq	a4,a5,80000b72 <printf+0x176>
    80000b06:	fd842783          	lw	a5,-40(s0)
    80000b0a:	0007871b          	sext.w	a4,a5
    80000b0e:	07000793          	li	a5,112
    80000b12:	0ce7cc63          	blt	a5,a4,80000bea <printf+0x1ee>
    80000b16:	fd842783          	lw	a5,-40(s0)
    80000b1a:	0007871b          	sext.w	a4,a5
    80000b1e:	02500793          	li	a5,37
    80000b22:	0af70d63          	beq	a4,a5,80000bdc <printf+0x1e0>
    80000b26:	fd842783          	lw	a5,-40(s0)
    80000b2a:	0007871b          	sext.w	a4,a5
    80000b2e:	06400793          	li	a5,100
    80000b32:	0af71c63          	bne	a4,a5,80000bea <printf+0x1ee>
    case 'd':
      printint(va_arg(ap, int), 10, 1);
    80000b36:	fd043783          	ld	a5,-48(s0)
    80000b3a:	00878713          	addi	a4,a5,8
    80000b3e:	fce43823          	sd	a4,-48(s0)
    80000b42:	439c                	lw	a5,0(a5)
    80000b44:	4605                	li	a2,1
    80000b46:	45a9                	li	a1,10
    80000b48:	853e                	mv	a0,a5
    80000b4a:	00000097          	auipc	ra,0x0
    80000b4e:	d32080e7          	jalr	-718(ra) # 8000087c <printint>
      break;
    80000b52:	a855                	j	80000c06 <printf+0x20a>
    case 'x':
      printint(va_arg(ap, int), 16, 1);
    80000b54:	fd043783          	ld	a5,-48(s0)
    80000b58:	00878713          	addi	a4,a5,8
    80000b5c:	fce43823          	sd	a4,-48(s0)
    80000b60:	439c                	lw	a5,0(a5)
    80000b62:	4605                	li	a2,1
    80000b64:	45c1                	li	a1,16
    80000b66:	853e                	mv	a0,a5
    80000b68:	00000097          	auipc	ra,0x0
    80000b6c:	d14080e7          	jalr	-748(ra) # 8000087c <printint>
      break;
    80000b70:	a859                	j	80000c06 <printf+0x20a>
    case 'p':
      printptr(va_arg(ap, uint64));
    80000b72:	fd043783          	ld	a5,-48(s0)
    80000b76:	00878713          	addi	a4,a5,8
    80000b7a:	fce43823          	sd	a4,-48(s0)
    80000b7e:	639c                	ld	a5,0(a5)
    80000b80:	853e                	mv	a0,a5
    80000b82:	00000097          	auipc	ra,0x0
    80000b86:	e04080e7          	jalr	-508(ra) # 80000986 <printptr>
      break;
    80000b8a:	a8b5                	j	80000c06 <printf+0x20a>
    case 's':
      if((s = va_arg(ap, char*)) == 0)
    80000b8c:	fd043783          	ld	a5,-48(s0)
    80000b90:	00878713          	addi	a4,a5,8
    80000b94:	fce43823          	sd	a4,-48(s0)
    80000b98:	639c                	ld	a5,0(a5)
    80000b9a:	fef43023          	sd	a5,-32(s0)
    80000b9e:	fe043783          	ld	a5,-32(s0)
    80000ba2:	e79d                	bnez	a5,80000bd0 <printf+0x1d4>
        s = "(null)";
    80000ba4:	0000b797          	auipc	a5,0xb
    80000ba8:	47478793          	addi	a5,a5,1140 # 8000c018 <etext+0x18>
    80000bac:	fef43023          	sd	a5,-32(s0)
      for(; *s; s++)
    80000bb0:	a005                	j	80000bd0 <printf+0x1d4>
        consputc(*s);
    80000bb2:	fe043783          	ld	a5,-32(s0)
    80000bb6:	0007c783          	lbu	a5,0(a5)
    80000bba:	2781                	sext.w	a5,a5
    80000bbc:	853e                	mv	a0,a5
    80000bbe:	fffff097          	auipc	ra,0xfffff
    80000bc2:	76a080e7          	jalr	1898(ra) # 80000328 <consputc>
      for(; *s; s++)
    80000bc6:	fe043783          	ld	a5,-32(s0)
    80000bca:	0785                	addi	a5,a5,1
    80000bcc:	fef43023          	sd	a5,-32(s0)
    80000bd0:	fe043783          	ld	a5,-32(s0)
    80000bd4:	0007c783          	lbu	a5,0(a5)
    80000bd8:	ffe9                	bnez	a5,80000bb2 <printf+0x1b6>
      break;
    80000bda:	a035                	j	80000c06 <printf+0x20a>
    case '%':
      consputc('%');
    80000bdc:	02500513          	li	a0,37
    80000be0:	fffff097          	auipc	ra,0xfffff
    80000be4:	748080e7          	jalr	1864(ra) # 80000328 <consputc>
      break;
    80000be8:	a839                	j	80000c06 <printf+0x20a>
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
    80000bea:	02500513          	li	a0,37
    80000bee:	fffff097          	auipc	ra,0xfffff
    80000bf2:	73a080e7          	jalr	1850(ra) # 80000328 <consputc>
      consputc(c);
    80000bf6:	fd842783          	lw	a5,-40(s0)
    80000bfa:	853e                	mv	a0,a5
    80000bfc:	fffff097          	auipc	ra,0xfffff
    80000c00:	72c080e7          	jalr	1836(ra) # 80000328 <consputc>
      break;
    80000c04:	0001                	nop
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    80000c06:	fec42783          	lw	a5,-20(s0)
    80000c0a:	2785                	addiw	a5,a5,1
    80000c0c:	fef42623          	sw	a5,-20(s0)
    80000c10:	fec42783          	lw	a5,-20(s0)
    80000c14:	fc843703          	ld	a4,-56(s0)
    80000c18:	97ba                	add	a5,a5,a4
    80000c1a:	0007c783          	lbu	a5,0(a5)
    80000c1e:	fcf42c23          	sw	a5,-40(s0)
    80000c22:	fd842783          	lw	a5,-40(s0)
    80000c26:	2781                	sext.w	a5,a5
    80000c28:	e40794e3          	bnez	a5,80000a70 <printf+0x74>
    80000c2c:	a011                	j	80000c30 <printf+0x234>
      break;
    80000c2e:	0001                	nop
    }
  }

  if(locking)
    80000c30:	fdc42783          	lw	a5,-36(s0)
    80000c34:	2781                	sext.w	a5,a5
    80000c36:	cb89                	beqz	a5,80000c48 <printf+0x24c>
    release(&pr.lock);
    80000c38:	00014517          	auipc	a0,0x14
    80000c3c:	5e050513          	addi	a0,a0,1504 # 80015218 <pr>
    80000c40:	00000097          	auipc	ra,0x0
    80000c44:	6a4080e7          	jalr	1700(ra) # 800012e4 <release>
}
    80000c48:	0001                	nop
    80000c4a:	70e2                	ld	ra,56(sp)
    80000c4c:	7442                	ld	s0,48(sp)
    80000c4e:	6109                	addi	sp,sp,128
    80000c50:	8082                	ret

0000000080000c52 <panic>:

void
panic(char *s)
{
    80000c52:	1101                	addi	sp,sp,-32
    80000c54:	ec06                	sd	ra,24(sp)
    80000c56:	e822                	sd	s0,16(sp)
    80000c58:	1000                	addi	s0,sp,32
    80000c5a:	fea43423          	sd	a0,-24(s0)
  pr.locking = 0;
    80000c5e:	00014797          	auipc	a5,0x14
    80000c62:	5ba78793          	addi	a5,a5,1466 # 80015218 <pr>
    80000c66:	0007ac23          	sw	zero,24(a5)
  printf("panic: ");
    80000c6a:	0000b517          	auipc	a0,0xb
    80000c6e:	3b650513          	addi	a0,a0,950 # 8000c020 <etext+0x20>
    80000c72:	00000097          	auipc	ra,0x0
    80000c76:	d8a080e7          	jalr	-630(ra) # 800009fc <printf>
  printf(s);
    80000c7a:	fe843503          	ld	a0,-24(s0)
    80000c7e:	00000097          	auipc	ra,0x0
    80000c82:	d7e080e7          	jalr	-642(ra) # 800009fc <printf>
  printf("\n");
    80000c86:	0000b517          	auipc	a0,0xb
    80000c8a:	3a250513          	addi	a0,a0,930 # 8000c028 <etext+0x28>
    80000c8e:	00000097          	auipc	ra,0x0
    80000c92:	d6e080e7          	jalr	-658(ra) # 800009fc <printf>
  panicked = 1; // freeze uart output from other CPUs
    80000c96:	0000c797          	auipc	a5,0xc
    80000c9a:	36a78793          	addi	a5,a5,874 # 8000d000 <panicked>
    80000c9e:	4705                	li	a4,1
    80000ca0:	c398                	sw	a4,0(a5)
  for(;;)
    80000ca2:	a001                	j	80000ca2 <panic+0x50>

0000000080000ca4 <printfinit>:
    ;
}

void
printfinit(void)
{
    80000ca4:	1141                	addi	sp,sp,-16
    80000ca6:	e406                	sd	ra,8(sp)
    80000ca8:	e022                	sd	s0,0(sp)
    80000caa:	0800                	addi	s0,sp,16
  initlock(&pr.lock, "pr");
    80000cac:	0000b597          	auipc	a1,0xb
    80000cb0:	38458593          	addi	a1,a1,900 # 8000c030 <etext+0x30>
    80000cb4:	00014517          	auipc	a0,0x14
    80000cb8:	56450513          	addi	a0,a0,1380 # 80015218 <pr>
    80000cbc:	00000097          	auipc	ra,0x0
    80000cc0:	594080e7          	jalr	1428(ra) # 80001250 <initlock>
  pr.locking = 1;
    80000cc4:	00014797          	auipc	a5,0x14
    80000cc8:	55478793          	addi	a5,a5,1364 # 80015218 <pr>
    80000ccc:	4705                	li	a4,1
    80000cce:	cf98                	sw	a4,24(a5)
}
    80000cd0:	0001                	nop
    80000cd2:	60a2                	ld	ra,8(sp)
    80000cd4:	6402                	ld	s0,0(sp)
    80000cd6:	0141                	addi	sp,sp,16
    80000cd8:	8082                	ret

0000000080000cda <uartinit>:

void uartstart();

void
uartinit(void)
{
    80000cda:	1141                	addi	sp,sp,-16
    80000cdc:	e406                	sd	ra,8(sp)
    80000cde:	e022                	sd	s0,0(sp)
    80000ce0:	0800                	addi	s0,sp,16
  // disable interrupts.
  WriteReg(IER, 0x00);
    80000ce2:	100007b7          	lui	a5,0x10000
    80000ce6:	0785                	addi	a5,a5,1
    80000ce8:	00078023          	sb	zero,0(a5) # 10000000 <_entry-0x70000000>

  // special mode to set baud rate.
  WriteReg(LCR, LCR_BAUD_LATCH);
    80000cec:	100007b7          	lui	a5,0x10000
    80000cf0:	078d                	addi	a5,a5,3
    80000cf2:	f8000713          	li	a4,-128
    80000cf6:	00e78023          	sb	a4,0(a5) # 10000000 <_entry-0x70000000>

  // LSB for baud rate of 38.4K.
  WriteReg(0, 0x03);
    80000cfa:	100007b7          	lui	a5,0x10000
    80000cfe:	470d                	li	a4,3
    80000d00:	00e78023          	sb	a4,0(a5) # 10000000 <_entry-0x70000000>

  // MSB for baud rate of 38.4K.
  WriteReg(1, 0x00);
    80000d04:	100007b7          	lui	a5,0x10000
    80000d08:	0785                	addi	a5,a5,1
    80000d0a:	00078023          	sb	zero,0(a5) # 10000000 <_entry-0x70000000>

  // leave set-baud mode,
  // and set word length to 8 bits, no parity.
  WriteReg(LCR, LCR_EIGHT_BITS);
    80000d0e:	100007b7          	lui	a5,0x10000
    80000d12:	078d                	addi	a5,a5,3
    80000d14:	470d                	li	a4,3
    80000d16:	00e78023          	sb	a4,0(a5) # 10000000 <_entry-0x70000000>

  // reset and enable FIFOs.
  WriteReg(FCR, FCR_FIFO_ENABLE | FCR_FIFO_CLEAR);
    80000d1a:	100007b7          	lui	a5,0x10000
    80000d1e:	0789                	addi	a5,a5,2
    80000d20:	471d                	li	a4,7
    80000d22:	00e78023          	sb	a4,0(a5) # 10000000 <_entry-0x70000000>

  // enable transmit and receive interrupts.
  WriteReg(IER, IER_TX_ENABLE | IER_RX_ENABLE);
    80000d26:	100007b7          	lui	a5,0x10000
    80000d2a:	0785                	addi	a5,a5,1
    80000d2c:	470d                	li	a4,3
    80000d2e:	00e78023          	sb	a4,0(a5) # 10000000 <_entry-0x70000000>

  initlock(&uart_tx_lock, "uart");
    80000d32:	0000b597          	auipc	a1,0xb
    80000d36:	30658593          	addi	a1,a1,774 # 8000c038 <etext+0x38>
    80000d3a:	00014517          	auipc	a0,0x14
    80000d3e:	4fe50513          	addi	a0,a0,1278 # 80015238 <uart_tx_lock>
    80000d42:	00000097          	auipc	ra,0x0
    80000d46:	50e080e7          	jalr	1294(ra) # 80001250 <initlock>
}
    80000d4a:	0001                	nop
    80000d4c:	60a2                	ld	ra,8(sp)
    80000d4e:	6402                	ld	s0,0(sp)
    80000d50:	0141                	addi	sp,sp,16
    80000d52:	8082                	ret

0000000080000d54 <uartputc>:
// because it may block, it can't be called
// from interrupts; it's only suitable for use
// by write().
void
uartputc(int c)
{
    80000d54:	1101                	addi	sp,sp,-32
    80000d56:	ec06                	sd	ra,24(sp)
    80000d58:	e822                	sd	s0,16(sp)
    80000d5a:	1000                	addi	s0,sp,32
    80000d5c:	87aa                	mv	a5,a0
    80000d5e:	fef42623          	sw	a5,-20(s0)
  acquire(&uart_tx_lock);
    80000d62:	00014517          	auipc	a0,0x14
    80000d66:	4d650513          	addi	a0,a0,1238 # 80015238 <uart_tx_lock>
    80000d6a:	00000097          	auipc	ra,0x0
    80000d6e:	516080e7          	jalr	1302(ra) # 80001280 <acquire>

  if(panicked){
    80000d72:	0000c797          	auipc	a5,0xc
    80000d76:	28e78793          	addi	a5,a5,654 # 8000d000 <panicked>
    80000d7a:	439c                	lw	a5,0(a5)
    80000d7c:	2781                	sext.w	a5,a5
    80000d7e:	c391                	beqz	a5,80000d82 <uartputc+0x2e>
    for(;;)
    80000d80:	a001                	j	80000d80 <uartputc+0x2c>
      ;
  }

  while(1){
    if(((uart_tx_w + 1) % UART_TX_BUF_SIZE) == uart_tx_r){
    80000d82:	0000c797          	auipc	a5,0xc
    80000d86:	28278793          	addi	a5,a5,642 # 8000d004 <uart_tx_w>
    80000d8a:	439c                	lw	a5,0(a5)
    80000d8c:	2785                	addiw	a5,a5,1
    80000d8e:	2781                	sext.w	a5,a5
    80000d90:	873e                	mv	a4,a5
    80000d92:	41f7579b          	sraiw	a5,a4,0x1f
    80000d96:	01b7d79b          	srliw	a5,a5,0x1b
    80000d9a:	9f3d                	addw	a4,a4,a5
    80000d9c:	8b7d                	andi	a4,a4,31
    80000d9e:	40f707bb          	subw	a5,a4,a5
    80000da2:	0007871b          	sext.w	a4,a5
    80000da6:	0000c797          	auipc	a5,0xc
    80000daa:	26278793          	addi	a5,a5,610 # 8000d008 <uart_tx_r>
    80000dae:	439c                	lw	a5,0(a5)
    80000db0:	00f71f63          	bne	a4,a5,80000dce <uartputc+0x7a>
      // buffer is full.
      // wait for uartstart() to open up space in the buffer.
      sleep(&uart_tx_r, &uart_tx_lock);
    80000db4:	00014597          	auipc	a1,0x14
    80000db8:	48458593          	addi	a1,a1,1156 # 80015238 <uart_tx_lock>
    80000dbc:	0000c517          	auipc	a0,0xc
    80000dc0:	24c50513          	addi	a0,a0,588 # 8000d008 <uart_tx_r>
    80000dc4:	00002097          	auipc	ra,0x2
    80000dc8:	770080e7          	jalr	1904(ra) # 80003534 <sleep>
    80000dcc:	bf5d                	j	80000d82 <uartputc+0x2e>
    } else {
      uart_tx_buf[uart_tx_w] = c;
    80000dce:	0000c797          	auipc	a5,0xc
    80000dd2:	23678793          	addi	a5,a5,566 # 8000d004 <uart_tx_w>
    80000dd6:	439c                	lw	a5,0(a5)
    80000dd8:	fec42703          	lw	a4,-20(s0)
    80000ddc:	0ff77713          	andi	a4,a4,255
    80000de0:	00014697          	auipc	a3,0x14
    80000de4:	47068693          	addi	a3,a3,1136 # 80015250 <uart_tx_buf>
    80000de8:	97b6                	add	a5,a5,a3
    80000dea:	00e78023          	sb	a4,0(a5)
      uart_tx_w = (uart_tx_w + 1) % UART_TX_BUF_SIZE;
    80000dee:	0000c797          	auipc	a5,0xc
    80000df2:	21678793          	addi	a5,a5,534 # 8000d004 <uart_tx_w>
    80000df6:	439c                	lw	a5,0(a5)
    80000df8:	2785                	addiw	a5,a5,1
    80000dfa:	2781                	sext.w	a5,a5
    80000dfc:	873e                	mv	a4,a5
    80000dfe:	41f7579b          	sraiw	a5,a4,0x1f
    80000e02:	01b7d79b          	srliw	a5,a5,0x1b
    80000e06:	9f3d                	addw	a4,a4,a5
    80000e08:	8b7d                	andi	a4,a4,31
    80000e0a:	40f707bb          	subw	a5,a4,a5
    80000e0e:	0007871b          	sext.w	a4,a5
    80000e12:	0000c797          	auipc	a5,0xc
    80000e16:	1f278793          	addi	a5,a5,498 # 8000d004 <uart_tx_w>
    80000e1a:	c398                	sw	a4,0(a5)
      uartstart();
    80000e1c:	00000097          	auipc	ra,0x0
    80000e20:	084080e7          	jalr	132(ra) # 80000ea0 <uartstart>
      release(&uart_tx_lock);
    80000e24:	00014517          	auipc	a0,0x14
    80000e28:	41450513          	addi	a0,a0,1044 # 80015238 <uart_tx_lock>
    80000e2c:	00000097          	auipc	ra,0x0
    80000e30:	4b8080e7          	jalr	1208(ra) # 800012e4 <release>
      return;
    80000e34:	0001                	nop
    }
  }
}
    80000e36:	60e2                	ld	ra,24(sp)
    80000e38:	6442                	ld	s0,16(sp)
    80000e3a:	6105                	addi	sp,sp,32
    80000e3c:	8082                	ret

0000000080000e3e <uartputc_sync>:
// use interrupts, for use by kernel printf() and
// to echo characters. it spins waiting for the uart's
// output register to be empty.
void
uartputc_sync(int c)
{
    80000e3e:	1101                	addi	sp,sp,-32
    80000e40:	ec06                	sd	ra,24(sp)
    80000e42:	e822                	sd	s0,16(sp)
    80000e44:	1000                	addi	s0,sp,32
    80000e46:	87aa                	mv	a5,a0
    80000e48:	fef42623          	sw	a5,-20(s0)
  push_off();
    80000e4c:	00000097          	auipc	ra,0x0
    80000e50:	532080e7          	jalr	1330(ra) # 8000137e <push_off>

  if(panicked){
    80000e54:	0000c797          	auipc	a5,0xc
    80000e58:	1ac78793          	addi	a5,a5,428 # 8000d000 <panicked>
    80000e5c:	439c                	lw	a5,0(a5)
    80000e5e:	2781                	sext.w	a5,a5
    80000e60:	c391                	beqz	a5,80000e64 <uartputc_sync+0x26>
    for(;;)
    80000e62:	a001                	j	80000e62 <uartputc_sync+0x24>
      ;
  }

  // wait for Transmit Holding Empty to be set in LSR.
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    80000e64:	0001                	nop
    80000e66:	100007b7          	lui	a5,0x10000
    80000e6a:	0795                	addi	a5,a5,5
    80000e6c:	0007c783          	lbu	a5,0(a5) # 10000000 <_entry-0x70000000>
    80000e70:	0ff7f793          	andi	a5,a5,255
    80000e74:	2781                	sext.w	a5,a5
    80000e76:	0207f793          	andi	a5,a5,32
    80000e7a:	2781                	sext.w	a5,a5
    80000e7c:	d7ed                	beqz	a5,80000e66 <uartputc_sync+0x28>
    ;
  WriteReg(THR, c);
    80000e7e:	100007b7          	lui	a5,0x10000
    80000e82:	fec42703          	lw	a4,-20(s0)
    80000e86:	0ff77713          	andi	a4,a4,255
    80000e8a:	00e78023          	sb	a4,0(a5) # 10000000 <_entry-0x70000000>

  pop_off();
    80000e8e:	00000097          	auipc	ra,0x0
    80000e92:	548080e7          	jalr	1352(ra) # 800013d6 <pop_off>
}
    80000e96:	0001                	nop
    80000e98:	60e2                	ld	ra,24(sp)
    80000e9a:	6442                	ld	s0,16(sp)
    80000e9c:	6105                	addi	sp,sp,32
    80000e9e:	8082                	ret

0000000080000ea0 <uartstart>:
// in the transmit buffer, send it.
// caller must hold uart_tx_lock.
// called from both the top- and bottom-half.
void
uartstart()
{
    80000ea0:	1101                	addi	sp,sp,-32
    80000ea2:	ec06                	sd	ra,24(sp)
    80000ea4:	e822                	sd	s0,16(sp)
    80000ea6:	1000                	addi	s0,sp,32
  while(1){
    if(uart_tx_w == uart_tx_r){
    80000ea8:	0000c797          	auipc	a5,0xc
    80000eac:	15c78793          	addi	a5,a5,348 # 8000d004 <uart_tx_w>
    80000eb0:	4398                	lw	a4,0(a5)
    80000eb2:	0000c797          	auipc	a5,0xc
    80000eb6:	15678793          	addi	a5,a5,342 # 8000d008 <uart_tx_r>
    80000eba:	439c                	lw	a5,0(a5)
    80000ebc:	08f70463          	beq	a4,a5,80000f44 <uartstart+0xa4>
      // transmit buffer is empty.
      return;
    }
    
    if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    80000ec0:	100007b7          	lui	a5,0x10000
    80000ec4:	0795                	addi	a5,a5,5
    80000ec6:	0007c783          	lbu	a5,0(a5) # 10000000 <_entry-0x70000000>
    80000eca:	0ff7f793          	andi	a5,a5,255
    80000ece:	2781                	sext.w	a5,a5
    80000ed0:	0207f793          	andi	a5,a5,32
    80000ed4:	2781                	sext.w	a5,a5
    80000ed6:	cbad                	beqz	a5,80000f48 <uartstart+0xa8>
      // so we cannot give it another byte.
      // it will interrupt when it's ready for a new byte.
      return;
    }
    
    int c = uart_tx_buf[uart_tx_r];
    80000ed8:	0000c797          	auipc	a5,0xc
    80000edc:	13078793          	addi	a5,a5,304 # 8000d008 <uart_tx_r>
    80000ee0:	439c                	lw	a5,0(a5)
    80000ee2:	00014717          	auipc	a4,0x14
    80000ee6:	36e70713          	addi	a4,a4,878 # 80015250 <uart_tx_buf>
    80000eea:	97ba                	add	a5,a5,a4
    80000eec:	0007c783          	lbu	a5,0(a5)
    80000ef0:	fef42623          	sw	a5,-20(s0)
    uart_tx_r = (uart_tx_r + 1) % UART_TX_BUF_SIZE;
    80000ef4:	0000c797          	auipc	a5,0xc
    80000ef8:	11478793          	addi	a5,a5,276 # 8000d008 <uart_tx_r>
    80000efc:	439c                	lw	a5,0(a5)
    80000efe:	2785                	addiw	a5,a5,1
    80000f00:	2781                	sext.w	a5,a5
    80000f02:	873e                	mv	a4,a5
    80000f04:	41f7579b          	sraiw	a5,a4,0x1f
    80000f08:	01b7d79b          	srliw	a5,a5,0x1b
    80000f0c:	9f3d                	addw	a4,a4,a5
    80000f0e:	8b7d                	andi	a4,a4,31
    80000f10:	40f707bb          	subw	a5,a4,a5
    80000f14:	0007871b          	sext.w	a4,a5
    80000f18:	0000c797          	auipc	a5,0xc
    80000f1c:	0f078793          	addi	a5,a5,240 # 8000d008 <uart_tx_r>
    80000f20:	c398                	sw	a4,0(a5)
    
    // maybe uartputc() is waiting for space in the buffer.
    wakeup(&uart_tx_r);
    80000f22:	0000c517          	auipc	a0,0xc
    80000f26:	0e650513          	addi	a0,a0,230 # 8000d008 <uart_tx_r>
    80000f2a:	00002097          	auipc	ra,0x2
    80000f2e:	69e080e7          	jalr	1694(ra) # 800035c8 <wakeup>
    
    WriteReg(THR, c);
    80000f32:	100007b7          	lui	a5,0x10000
    80000f36:	fec42703          	lw	a4,-20(s0)
    80000f3a:	0ff77713          	andi	a4,a4,255
    80000f3e:	00e78023          	sb	a4,0(a5) # 10000000 <_entry-0x70000000>
  while(1){
    80000f42:	b79d                	j	80000ea8 <uartstart+0x8>
      return;
    80000f44:	0001                	nop
    80000f46:	a011                	j	80000f4a <uartstart+0xaa>
      return;
    80000f48:	0001                	nop
  }
}
    80000f4a:	60e2                	ld	ra,24(sp)
    80000f4c:	6442                	ld	s0,16(sp)
    80000f4e:	6105                	addi	sp,sp,32
    80000f50:	8082                	ret

0000000080000f52 <uartgetc>:

// read one input character from the UART.
// return -1 if none is waiting.
int
uartgetc(void)
{
    80000f52:	1141                	addi	sp,sp,-16
    80000f54:	e422                	sd	s0,8(sp)
    80000f56:	0800                	addi	s0,sp,16
  if(ReadReg(LSR) & 0x01){
    80000f58:	100007b7          	lui	a5,0x10000
    80000f5c:	0795                	addi	a5,a5,5
    80000f5e:	0007c783          	lbu	a5,0(a5) # 10000000 <_entry-0x70000000>
    80000f62:	0ff7f793          	andi	a5,a5,255
    80000f66:	2781                	sext.w	a5,a5
    80000f68:	8b85                	andi	a5,a5,1
    80000f6a:	2781                	sext.w	a5,a5
    80000f6c:	cb89                	beqz	a5,80000f7e <uartgetc+0x2c>
    // input data is ready.
    return ReadReg(RHR);
    80000f6e:	100007b7          	lui	a5,0x10000
    80000f72:	0007c783          	lbu	a5,0(a5) # 10000000 <_entry-0x70000000>
    80000f76:	0ff7f793          	andi	a5,a5,255
    80000f7a:	2781                	sext.w	a5,a5
    80000f7c:	a011                	j	80000f80 <uartgetc+0x2e>
  } else {
    return -1;
    80000f7e:	57fd                	li	a5,-1
  }
}
    80000f80:	853e                	mv	a0,a5
    80000f82:	6422                	ld	s0,8(sp)
    80000f84:	0141                	addi	sp,sp,16
    80000f86:	8082                	ret

0000000080000f88 <uartintr>:
// handle a uart interrupt, raised because input has
// arrived, or the uart is ready for more output, or
// both. called from trap.c.
void
uartintr(void)
{
    80000f88:	1101                	addi	sp,sp,-32
    80000f8a:	ec06                	sd	ra,24(sp)
    80000f8c:	e822                	sd	s0,16(sp)
    80000f8e:	1000                	addi	s0,sp,32
  // read and process incoming characters.
  while(1){
    int c = uartgetc();
    80000f90:	00000097          	auipc	ra,0x0
    80000f94:	fc2080e7          	jalr	-62(ra) # 80000f52 <uartgetc>
    80000f98:	87aa                	mv	a5,a0
    80000f9a:	fef42623          	sw	a5,-20(s0)
    if(c == -1)
    80000f9e:	fec42783          	lw	a5,-20(s0)
    80000fa2:	0007871b          	sext.w	a4,a5
    80000fa6:	57fd                	li	a5,-1
    80000fa8:	00f70a63          	beq	a4,a5,80000fbc <uartintr+0x34>
      break;
    consoleintr(c);
    80000fac:	fec42783          	lw	a5,-20(s0)
    80000fb0:	853e                	mv	a0,a5
    80000fb2:	fffff097          	auipc	ra,0xfffff
    80000fb6:	60c080e7          	jalr	1548(ra) # 800005be <consoleintr>
  while(1){
    80000fba:	bfd9                	j	80000f90 <uartintr+0x8>
      break;
    80000fbc:	0001                	nop
  }

  // send buffered characters.
  acquire(&uart_tx_lock);
    80000fbe:	00014517          	auipc	a0,0x14
    80000fc2:	27a50513          	addi	a0,a0,634 # 80015238 <uart_tx_lock>
    80000fc6:	00000097          	auipc	ra,0x0
    80000fca:	2ba080e7          	jalr	698(ra) # 80001280 <acquire>
  uartstart();
    80000fce:	00000097          	auipc	ra,0x0
    80000fd2:	ed2080e7          	jalr	-302(ra) # 80000ea0 <uartstart>
  release(&uart_tx_lock);
    80000fd6:	00014517          	auipc	a0,0x14
    80000fda:	26250513          	addi	a0,a0,610 # 80015238 <uart_tx_lock>
    80000fde:	00000097          	auipc	ra,0x0
    80000fe2:	306080e7          	jalr	774(ra) # 800012e4 <release>
}
    80000fe6:	0001                	nop
    80000fe8:	60e2                	ld	ra,24(sp)
    80000fea:	6442                	ld	s0,16(sp)
    80000fec:	6105                	addi	sp,sp,32
    80000fee:	8082                	ret

0000000080000ff0 <kinit>:
  struct run *freelist;
} kmem;

void
kinit()
{
    80000ff0:	1141                	addi	sp,sp,-16
    80000ff2:	e406                	sd	ra,8(sp)
    80000ff4:	e022                	sd	s0,0(sp)
    80000ff6:	0800                	addi	s0,sp,16
  initlock(&kmem.lock, "kmem");
    80000ff8:	0000b597          	auipc	a1,0xb
    80000ffc:	04858593          	addi	a1,a1,72 # 8000c040 <etext+0x40>
    80001000:	00014517          	auipc	a0,0x14
    80001004:	27050513          	addi	a0,a0,624 # 80015270 <kmem>
    80001008:	00000097          	auipc	ra,0x0
    8000100c:	248080e7          	jalr	584(ra) # 80001250 <initlock>
  freerange(end, (void*)PHYSTOP);
    80001010:	47c5                	li	a5,17
    80001012:	01b79593          	slli	a1,a5,0x1b
    80001016:	00072517          	auipc	a0,0x72
    8000101a:	fea50513          	addi	a0,a0,-22 # 80073000 <end>
    8000101e:	00000097          	auipc	ra,0x0
    80001022:	012080e7          	jalr	18(ra) # 80001030 <freerange>
}
    80001026:	0001                	nop
    80001028:	60a2                	ld	ra,8(sp)
    8000102a:	6402                	ld	s0,0(sp)
    8000102c:	0141                	addi	sp,sp,16
    8000102e:	8082                	ret

0000000080001030 <freerange>:

void
freerange(void *pa_start, void *pa_end)
{
    80001030:	7179                	addi	sp,sp,-48
    80001032:	f406                	sd	ra,40(sp)
    80001034:	f022                	sd	s0,32(sp)
    80001036:	1800                	addi	s0,sp,48
    80001038:	fca43c23          	sd	a0,-40(s0)
    8000103c:	fcb43823          	sd	a1,-48(s0)
  char *p;
  p = (char*)PGROUNDUP((uint64)pa_start);
    80001040:	fd843703          	ld	a4,-40(s0)
    80001044:	6785                	lui	a5,0x1
    80001046:	17fd                	addi	a5,a5,-1
    80001048:	973e                	add	a4,a4,a5
    8000104a:	77fd                	lui	a5,0xfffff
    8000104c:	8ff9                	and	a5,a5,a4
    8000104e:	fef43423          	sd	a5,-24(s0)
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    80001052:	a829                	j	8000106c <freerange+0x3c>
    kfree(p);
    80001054:	fe843503          	ld	a0,-24(s0)
    80001058:	00000097          	auipc	ra,0x0
    8000105c:	030080e7          	jalr	48(ra) # 80001088 <kfree>
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    80001060:	fe843703          	ld	a4,-24(s0)
    80001064:	6785                	lui	a5,0x1
    80001066:	97ba                	add	a5,a5,a4
    80001068:	fef43423          	sd	a5,-24(s0)
    8000106c:	fe843703          	ld	a4,-24(s0)
    80001070:	6785                	lui	a5,0x1
    80001072:	97ba                	add	a5,a5,a4
    80001074:	fd043703          	ld	a4,-48(s0)
    80001078:	fcf77ee3          	bgeu	a4,a5,80001054 <freerange+0x24>
}
    8000107c:	0001                	nop
    8000107e:	0001                	nop
    80001080:	70a2                	ld	ra,40(sp)
    80001082:	7402                	ld	s0,32(sp)
    80001084:	6145                	addi	sp,sp,48
    80001086:	8082                	ret

0000000080001088 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(void *pa)
{
    80001088:	7179                	addi	sp,sp,-48
    8000108a:	f406                	sd	ra,40(sp)
    8000108c:	f022                	sd	s0,32(sp)
    8000108e:	1800                	addi	s0,sp,48
    80001090:	fca43c23          	sd	a0,-40(s0)
  struct run *r;

  if(((uint64)pa % PGSIZE) != 0 || (char*)pa < end || (uint64)pa >= PHYSTOP)
    80001094:	fd843703          	ld	a4,-40(s0)
    80001098:	6785                	lui	a5,0x1
    8000109a:	17fd                	addi	a5,a5,-1
    8000109c:	8ff9                	and	a5,a5,a4
    8000109e:	ef99                	bnez	a5,800010bc <kfree+0x34>
    800010a0:	fd843703          	ld	a4,-40(s0)
    800010a4:	00072797          	auipc	a5,0x72
    800010a8:	f5c78793          	addi	a5,a5,-164 # 80073000 <end>
    800010ac:	00f76863          	bltu	a4,a5,800010bc <kfree+0x34>
    800010b0:	fd843703          	ld	a4,-40(s0)
    800010b4:	47c5                	li	a5,17
    800010b6:	07ee                	slli	a5,a5,0x1b
    800010b8:	00f76a63          	bltu	a4,a5,800010cc <kfree+0x44>
    panic("kfree");
    800010bc:	0000b517          	auipc	a0,0xb
    800010c0:	f8c50513          	addi	a0,a0,-116 # 8000c048 <etext+0x48>
    800010c4:	00000097          	auipc	ra,0x0
    800010c8:	b8e080e7          	jalr	-1138(ra) # 80000c52 <panic>

  // Fill with junk to catch dangling refs.
  memset(pa, 1, PGSIZE);
    800010cc:	6605                	lui	a2,0x1
    800010ce:	4585                	li	a1,1
    800010d0:	fd843503          	ld	a0,-40(s0)
    800010d4:	00000097          	auipc	ra,0x0
    800010d8:	380080e7          	jalr	896(ra) # 80001454 <memset>

  r = (struct run*)pa;
    800010dc:	fd843783          	ld	a5,-40(s0)
    800010e0:	fef43423          	sd	a5,-24(s0)

  acquire(&kmem.lock);
    800010e4:	00014517          	auipc	a0,0x14
    800010e8:	18c50513          	addi	a0,a0,396 # 80015270 <kmem>
    800010ec:	00000097          	auipc	ra,0x0
    800010f0:	194080e7          	jalr	404(ra) # 80001280 <acquire>
  r->next = kmem.freelist;
    800010f4:	00014797          	auipc	a5,0x14
    800010f8:	17c78793          	addi	a5,a5,380 # 80015270 <kmem>
    800010fc:	6f98                	ld	a4,24(a5)
    800010fe:	fe843783          	ld	a5,-24(s0)
    80001102:	e398                	sd	a4,0(a5)
  kmem.freelist = r;
    80001104:	00014797          	auipc	a5,0x14
    80001108:	16c78793          	addi	a5,a5,364 # 80015270 <kmem>
    8000110c:	fe843703          	ld	a4,-24(s0)
    80001110:	ef98                	sd	a4,24(a5)
  release(&kmem.lock);
    80001112:	00014517          	auipc	a0,0x14
    80001116:	15e50513          	addi	a0,a0,350 # 80015270 <kmem>
    8000111a:	00000097          	auipc	ra,0x0
    8000111e:	1ca080e7          	jalr	458(ra) # 800012e4 <release>
}
    80001122:	0001                	nop
    80001124:	70a2                	ld	ra,40(sp)
    80001126:	7402                	ld	s0,32(sp)
    80001128:	6145                	addi	sp,sp,48
    8000112a:	8082                	ret

000000008000112c <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
void *
kalloc(void)
{
    8000112c:	1101                	addi	sp,sp,-32
    8000112e:	ec06                	sd	ra,24(sp)
    80001130:	e822                	sd	s0,16(sp)
    80001132:	1000                	addi	s0,sp,32
  struct run *r;

  acquire(&kmem.lock);
    80001134:	00014517          	auipc	a0,0x14
    80001138:	13c50513          	addi	a0,a0,316 # 80015270 <kmem>
    8000113c:	00000097          	auipc	ra,0x0
    80001140:	144080e7          	jalr	324(ra) # 80001280 <acquire>
  r = kmem.freelist;
    80001144:	00014797          	auipc	a5,0x14
    80001148:	12c78793          	addi	a5,a5,300 # 80015270 <kmem>
    8000114c:	6f9c                	ld	a5,24(a5)
    8000114e:	fef43423          	sd	a5,-24(s0)
  if(r)
    80001152:	fe843783          	ld	a5,-24(s0)
    80001156:	cb89                	beqz	a5,80001168 <kalloc+0x3c>
    kmem.freelist = r->next;
    80001158:	fe843783          	ld	a5,-24(s0)
    8000115c:	6398                	ld	a4,0(a5)
    8000115e:	00014797          	auipc	a5,0x14
    80001162:	11278793          	addi	a5,a5,274 # 80015270 <kmem>
    80001166:	ef98                	sd	a4,24(a5)
  release(&kmem.lock);
    80001168:	00014517          	auipc	a0,0x14
    8000116c:	10850513          	addi	a0,a0,264 # 80015270 <kmem>
    80001170:	00000097          	auipc	ra,0x0
    80001174:	174080e7          	jalr	372(ra) # 800012e4 <release>

  if(r)
    80001178:	fe843783          	ld	a5,-24(s0)
    8000117c:	cb89                	beqz	a5,8000118e <kalloc+0x62>
    memset((char*)r, 5, PGSIZE); // fill with junk
    8000117e:	6605                	lui	a2,0x1
    80001180:	4595                	li	a1,5
    80001182:	fe843503          	ld	a0,-24(s0)
    80001186:	00000097          	auipc	ra,0x0
    8000118a:	2ce080e7          	jalr	718(ra) # 80001454 <memset>
  return (void*)r;
    8000118e:	fe843783          	ld	a5,-24(s0)
}
    80001192:	853e                	mv	a0,a5
    80001194:	60e2                	ld	ra,24(sp)
    80001196:	6442                	ld	s0,16(sp)
    80001198:	6105                	addi	sp,sp,32
    8000119a:	8082                	ret

000000008000119c <r_sstatus>:
{
    8000119c:	1101                	addi	sp,sp,-32
    8000119e:	ec22                	sd	s0,24(sp)
    800011a0:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800011a2:	100027f3          	csrr	a5,sstatus
    800011a6:	fef43423          	sd	a5,-24(s0)
  return x;
    800011aa:	fe843783          	ld	a5,-24(s0)
}
    800011ae:	853e                	mv	a0,a5
    800011b0:	6462                	ld	s0,24(sp)
    800011b2:	6105                	addi	sp,sp,32
    800011b4:	8082                	ret

00000000800011b6 <w_sstatus>:
{
    800011b6:	1101                	addi	sp,sp,-32
    800011b8:	ec22                	sd	s0,24(sp)
    800011ba:	1000                	addi	s0,sp,32
    800011bc:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800011c0:	fe843783          	ld	a5,-24(s0)
    800011c4:	10079073          	csrw	sstatus,a5
}
    800011c8:	0001                	nop
    800011ca:	6462                	ld	s0,24(sp)
    800011cc:	6105                	addi	sp,sp,32
    800011ce:	8082                	ret

00000000800011d0 <intr_on>:
{
    800011d0:	1141                	addi	sp,sp,-16
    800011d2:	e406                	sd	ra,8(sp)
    800011d4:	e022                	sd	s0,0(sp)
    800011d6:	0800                	addi	s0,sp,16
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    800011d8:	00000097          	auipc	ra,0x0
    800011dc:	fc4080e7          	jalr	-60(ra) # 8000119c <r_sstatus>
    800011e0:	87aa                	mv	a5,a0
    800011e2:	0027e793          	ori	a5,a5,2
    800011e6:	853e                	mv	a0,a5
    800011e8:	00000097          	auipc	ra,0x0
    800011ec:	fce080e7          	jalr	-50(ra) # 800011b6 <w_sstatus>
}
    800011f0:	0001                	nop
    800011f2:	60a2                	ld	ra,8(sp)
    800011f4:	6402                	ld	s0,0(sp)
    800011f6:	0141                	addi	sp,sp,16
    800011f8:	8082                	ret

00000000800011fa <intr_off>:
{
    800011fa:	1141                	addi	sp,sp,-16
    800011fc:	e406                	sd	ra,8(sp)
    800011fe:	e022                	sd	s0,0(sp)
    80001200:	0800                	addi	s0,sp,16
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80001202:	00000097          	auipc	ra,0x0
    80001206:	f9a080e7          	jalr	-102(ra) # 8000119c <r_sstatus>
    8000120a:	87aa                	mv	a5,a0
    8000120c:	9bf5                	andi	a5,a5,-3
    8000120e:	853e                	mv	a0,a5
    80001210:	00000097          	auipc	ra,0x0
    80001214:	fa6080e7          	jalr	-90(ra) # 800011b6 <w_sstatus>
}
    80001218:	0001                	nop
    8000121a:	60a2                	ld	ra,8(sp)
    8000121c:	6402                	ld	s0,0(sp)
    8000121e:	0141                	addi	sp,sp,16
    80001220:	8082                	ret

0000000080001222 <intr_get>:
{
    80001222:	1101                	addi	sp,sp,-32
    80001224:	ec06                	sd	ra,24(sp)
    80001226:	e822                	sd	s0,16(sp)
    80001228:	1000                	addi	s0,sp,32
  uint64 x = r_sstatus();
    8000122a:	00000097          	auipc	ra,0x0
    8000122e:	f72080e7          	jalr	-142(ra) # 8000119c <r_sstatus>
    80001232:	fea43423          	sd	a0,-24(s0)
  return (x & SSTATUS_SIE) != 0;
    80001236:	fe843783          	ld	a5,-24(s0)
    8000123a:	8b89                	andi	a5,a5,2
    8000123c:	00f037b3          	snez	a5,a5
    80001240:	0ff7f793          	andi	a5,a5,255
    80001244:	2781                	sext.w	a5,a5
}
    80001246:	853e                	mv	a0,a5
    80001248:	60e2                	ld	ra,24(sp)
    8000124a:	6442                	ld	s0,16(sp)
    8000124c:	6105                	addi	sp,sp,32
    8000124e:	8082                	ret

0000000080001250 <initlock>:
#include "proc.h"
#include "defs.h"

void
initlock(struct spinlock *lk, char *name)
{
    80001250:	1101                	addi	sp,sp,-32
    80001252:	ec22                	sd	s0,24(sp)
    80001254:	1000                	addi	s0,sp,32
    80001256:	fea43423          	sd	a0,-24(s0)
    8000125a:	feb43023          	sd	a1,-32(s0)
  lk->name = name;
    8000125e:	fe843783          	ld	a5,-24(s0)
    80001262:	fe043703          	ld	a4,-32(s0)
    80001266:	e798                	sd	a4,8(a5)
  lk->locked = 0;
    80001268:	fe843783          	ld	a5,-24(s0)
    8000126c:	0007a023          	sw	zero,0(a5)
  lk->cpu = 0;
    80001270:	fe843783          	ld	a5,-24(s0)
    80001274:	0007b823          	sd	zero,16(a5)
}
    80001278:	0001                	nop
    8000127a:	6462                	ld	s0,24(sp)
    8000127c:	6105                	addi	sp,sp,32
    8000127e:	8082                	ret

0000000080001280 <acquire>:

// Acquire the lock.
// Loops (spins) until the lock is acquired.
void
acquire(struct spinlock *lk)
{
    80001280:	1101                	addi	sp,sp,-32
    80001282:	ec06                	sd	ra,24(sp)
    80001284:	e822                	sd	s0,16(sp)
    80001286:	1000                	addi	s0,sp,32
    80001288:	fea43423          	sd	a0,-24(s0)
  push_off(); // disable interrupts to avoid deadlock.
    8000128c:	00000097          	auipc	ra,0x0
    80001290:	0f2080e7          	jalr	242(ra) # 8000137e <push_off>
  if(holding(lk))
    80001294:	fe843503          	ld	a0,-24(s0)
    80001298:	00000097          	auipc	ra,0x0
    8000129c:	0a2080e7          	jalr	162(ra) # 8000133a <holding>
    800012a0:	87aa                	mv	a5,a0
    800012a2:	cb89                	beqz	a5,800012b4 <acquire+0x34>
    panic("acquire");
    800012a4:	0000b517          	auipc	a0,0xb
    800012a8:	dac50513          	addi	a0,a0,-596 # 8000c050 <etext+0x50>
    800012ac:	00000097          	auipc	ra,0x0
    800012b0:	9a6080e7          	jalr	-1626(ra) # 80000c52 <panic>

  // On RISC-V, sync_lock_test_and_set turns into an atomic swap:
  //   a5 = 1
  //   s1 = &lk->locked
  //   amoswap.w.aq a5, a5, (s1)
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    800012b4:	0001                	nop
    800012b6:	fe843783          	ld	a5,-24(s0)
    800012ba:	4705                	li	a4,1
    800012bc:	0ce7a72f          	amoswap.w.aq	a4,a4,(a5)
    800012c0:	0007079b          	sext.w	a5,a4
    800012c4:	fbed                	bnez	a5,800012b6 <acquire+0x36>

  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that the critical section's memory
  // references happen strictly after the lock is acquired.
  // On RISC-V, this emits a fence instruction.
  __sync_synchronize();
    800012c6:	0ff0000f          	fence

  // Record info about lock acquisition for holding() and debugging.
  lk->cpu = mycpu();
    800012ca:	00001097          	auipc	ra,0x1
    800012ce:	4f4080e7          	jalr	1268(ra) # 800027be <mycpu>
    800012d2:	872a                	mv	a4,a0
    800012d4:	fe843783          	ld	a5,-24(s0)
    800012d8:	eb98                	sd	a4,16(a5)
}
    800012da:	0001                	nop
    800012dc:	60e2                	ld	ra,24(sp)
    800012de:	6442                	ld	s0,16(sp)
    800012e0:	6105                	addi	sp,sp,32
    800012e2:	8082                	ret

00000000800012e4 <release>:

// Release the lock.
void
release(struct spinlock *lk)
{
    800012e4:	1101                	addi	sp,sp,-32
    800012e6:	ec06                	sd	ra,24(sp)
    800012e8:	e822                	sd	s0,16(sp)
    800012ea:	1000                	addi	s0,sp,32
    800012ec:	fea43423          	sd	a0,-24(s0)
  if(!holding(lk))
    800012f0:	fe843503          	ld	a0,-24(s0)
    800012f4:	00000097          	auipc	ra,0x0
    800012f8:	046080e7          	jalr	70(ra) # 8000133a <holding>
    800012fc:	87aa                	mv	a5,a0
    800012fe:	eb89                	bnez	a5,80001310 <release+0x2c>
    panic("release");
    80001300:	0000b517          	auipc	a0,0xb
    80001304:	d5850513          	addi	a0,a0,-680 # 8000c058 <etext+0x58>
    80001308:	00000097          	auipc	ra,0x0
    8000130c:	94a080e7          	jalr	-1718(ra) # 80000c52 <panic>

  lk->cpu = 0;
    80001310:	fe843783          	ld	a5,-24(s0)
    80001314:	0007b823          	sd	zero,16(a5)
  // past this point, to ensure that all the stores in the critical
  // section are visible to other CPUs before the lock is released,
  // and that loads in the critical section occur strictly before
  // the lock is released.
  // On RISC-V, this emits a fence instruction.
  __sync_synchronize();
    80001318:	0ff0000f          	fence
  // implies that an assignment might be implemented with
  // multiple store instructions.
  // On RISC-V, sync_lock_release turns into an atomic swap:
  //   s1 = &lk->locked
  //   amoswap.w zero, zero, (s1)
  __sync_lock_release(&lk->locked);
    8000131c:	fe843783          	ld	a5,-24(s0)
    80001320:	0f50000f          	fence	iorw,ow
    80001324:	0807a02f          	amoswap.w	zero,zero,(a5)

  pop_off();
    80001328:	00000097          	auipc	ra,0x0
    8000132c:	0ae080e7          	jalr	174(ra) # 800013d6 <pop_off>
}
    80001330:	0001                	nop
    80001332:	60e2                	ld	ra,24(sp)
    80001334:	6442                	ld	s0,16(sp)
    80001336:	6105                	addi	sp,sp,32
    80001338:	8082                	ret

000000008000133a <holding>:

// Check whether this cpu is holding the lock.
// Interrupts must be off.
int
holding(struct spinlock *lk)
{
    8000133a:	7139                	addi	sp,sp,-64
    8000133c:	fc06                	sd	ra,56(sp)
    8000133e:	f822                	sd	s0,48(sp)
    80001340:	f426                	sd	s1,40(sp)
    80001342:	0080                	addi	s0,sp,64
    80001344:	fca43423          	sd	a0,-56(s0)
  int r;
  r = (lk->locked && lk->cpu == mycpu());
    80001348:	fc843783          	ld	a5,-56(s0)
    8000134c:	439c                	lw	a5,0(a5)
    8000134e:	cf89                	beqz	a5,80001368 <holding+0x2e>
    80001350:	fc843783          	ld	a5,-56(s0)
    80001354:	6b84                	ld	s1,16(a5)
    80001356:	00001097          	auipc	ra,0x1
    8000135a:	468080e7          	jalr	1128(ra) # 800027be <mycpu>
    8000135e:	87aa                	mv	a5,a0
    80001360:	00f49463          	bne	s1,a5,80001368 <holding+0x2e>
    80001364:	4785                	li	a5,1
    80001366:	a011                	j	8000136a <holding+0x30>
    80001368:	4781                	li	a5,0
    8000136a:	fcf42e23          	sw	a5,-36(s0)
  return r;
    8000136e:	fdc42783          	lw	a5,-36(s0)
}
    80001372:	853e                	mv	a0,a5
    80001374:	70e2                	ld	ra,56(sp)
    80001376:	7442                	ld	s0,48(sp)
    80001378:	74a2                	ld	s1,40(sp)
    8000137a:	6121                	addi	sp,sp,64
    8000137c:	8082                	ret

000000008000137e <push_off>:
// it takes two pop_off()s to undo two push_off()s.  Also, if interrupts
// are initially off, then push_off, pop_off leaves them off.

void
push_off(void)
{
    8000137e:	1101                	addi	sp,sp,-32
    80001380:	ec06                	sd	ra,24(sp)
    80001382:	e822                	sd	s0,16(sp)
    80001384:	1000                	addi	s0,sp,32
  int old = intr_get();
    80001386:	00000097          	auipc	ra,0x0
    8000138a:	e9c080e7          	jalr	-356(ra) # 80001222 <intr_get>
    8000138e:	87aa                	mv	a5,a0
    80001390:	fef42623          	sw	a5,-20(s0)

  intr_off();
    80001394:	00000097          	auipc	ra,0x0
    80001398:	e66080e7          	jalr	-410(ra) # 800011fa <intr_off>
  if(mycpu()->noff == 0)
    8000139c:	00001097          	auipc	ra,0x1
    800013a0:	422080e7          	jalr	1058(ra) # 800027be <mycpu>
    800013a4:	87aa                	mv	a5,a0
    800013a6:	5fbc                	lw	a5,120(a5)
    800013a8:	eb89                	bnez	a5,800013ba <push_off+0x3c>
    mycpu()->intena = old;
    800013aa:	00001097          	auipc	ra,0x1
    800013ae:	414080e7          	jalr	1044(ra) # 800027be <mycpu>
    800013b2:	872a                	mv	a4,a0
    800013b4:	fec42783          	lw	a5,-20(s0)
    800013b8:	df7c                	sw	a5,124(a4)
  mycpu()->noff += 1;
    800013ba:	00001097          	auipc	ra,0x1
    800013be:	404080e7          	jalr	1028(ra) # 800027be <mycpu>
    800013c2:	87aa                	mv	a5,a0
    800013c4:	5fb8                	lw	a4,120(a5)
    800013c6:	2705                	addiw	a4,a4,1
    800013c8:	2701                	sext.w	a4,a4
    800013ca:	dfb8                	sw	a4,120(a5)
}
    800013cc:	0001                	nop
    800013ce:	60e2                	ld	ra,24(sp)
    800013d0:	6442                	ld	s0,16(sp)
    800013d2:	6105                	addi	sp,sp,32
    800013d4:	8082                	ret

00000000800013d6 <pop_off>:

void
pop_off(void)
{
    800013d6:	1101                	addi	sp,sp,-32
    800013d8:	ec06                	sd	ra,24(sp)
    800013da:	e822                	sd	s0,16(sp)
    800013dc:	1000                	addi	s0,sp,32
  struct cpu *c = mycpu();
    800013de:	00001097          	auipc	ra,0x1
    800013e2:	3e0080e7          	jalr	992(ra) # 800027be <mycpu>
    800013e6:	fea43423          	sd	a0,-24(s0)
  if(intr_get())
    800013ea:	00000097          	auipc	ra,0x0
    800013ee:	e38080e7          	jalr	-456(ra) # 80001222 <intr_get>
    800013f2:	87aa                	mv	a5,a0
    800013f4:	cb89                	beqz	a5,80001406 <pop_off+0x30>
    panic("pop_off - interruptible");
    800013f6:	0000b517          	auipc	a0,0xb
    800013fa:	c6a50513          	addi	a0,a0,-918 # 8000c060 <etext+0x60>
    800013fe:	00000097          	auipc	ra,0x0
    80001402:	854080e7          	jalr	-1964(ra) # 80000c52 <panic>
  if(c->noff < 1)
    80001406:	fe843783          	ld	a5,-24(s0)
    8000140a:	5fbc                	lw	a5,120(a5)
    8000140c:	00f04a63          	bgtz	a5,80001420 <pop_off+0x4a>
    panic("pop_off");
    80001410:	0000b517          	auipc	a0,0xb
    80001414:	c6850513          	addi	a0,a0,-920 # 8000c078 <etext+0x78>
    80001418:	00000097          	auipc	ra,0x0
    8000141c:	83a080e7          	jalr	-1990(ra) # 80000c52 <panic>
  c->noff -= 1;
    80001420:	fe843783          	ld	a5,-24(s0)
    80001424:	5fbc                	lw	a5,120(a5)
    80001426:	37fd                	addiw	a5,a5,-1
    80001428:	0007871b          	sext.w	a4,a5
    8000142c:	fe843783          	ld	a5,-24(s0)
    80001430:	dfb8                	sw	a4,120(a5)
  if(c->noff == 0 && c->intena)
    80001432:	fe843783          	ld	a5,-24(s0)
    80001436:	5fbc                	lw	a5,120(a5)
    80001438:	eb89                	bnez	a5,8000144a <pop_off+0x74>
    8000143a:	fe843783          	ld	a5,-24(s0)
    8000143e:	5ffc                	lw	a5,124(a5)
    80001440:	c789                	beqz	a5,8000144a <pop_off+0x74>
    intr_on();
    80001442:	00000097          	auipc	ra,0x0
    80001446:	d8e080e7          	jalr	-626(ra) # 800011d0 <intr_on>
}
    8000144a:	0001                	nop
    8000144c:	60e2                	ld	ra,24(sp)
    8000144e:	6442                	ld	s0,16(sp)
    80001450:	6105                	addi	sp,sp,32
    80001452:	8082                	ret

0000000080001454 <memset>:
#include "types.h"

void*
memset(void *dst, int c, uint n)
{
    80001454:	7179                	addi	sp,sp,-48
    80001456:	f422                	sd	s0,40(sp)
    80001458:	1800                	addi	s0,sp,48
    8000145a:	fca43c23          	sd	a0,-40(s0)
    8000145e:	87ae                	mv	a5,a1
    80001460:	8732                	mv	a4,a2
    80001462:	fcf42a23          	sw	a5,-44(s0)
    80001466:	87ba                	mv	a5,a4
    80001468:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
    8000146c:	fd843783          	ld	a5,-40(s0)
    80001470:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
    80001474:	fe042623          	sw	zero,-20(s0)
    80001478:	a00d                	j	8000149a <memset+0x46>
    cdst[i] = c;
    8000147a:	fec42783          	lw	a5,-20(s0)
    8000147e:	fe043703          	ld	a4,-32(s0)
    80001482:	97ba                	add	a5,a5,a4
    80001484:	fd442703          	lw	a4,-44(s0)
    80001488:	0ff77713          	andi	a4,a4,255
    8000148c:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
    80001490:	fec42783          	lw	a5,-20(s0)
    80001494:	2785                	addiw	a5,a5,1
    80001496:	fef42623          	sw	a5,-20(s0)
    8000149a:	fec42703          	lw	a4,-20(s0)
    8000149e:	fd042783          	lw	a5,-48(s0)
    800014a2:	2781                	sext.w	a5,a5
    800014a4:	fcf76be3          	bltu	a4,a5,8000147a <memset+0x26>
  }
  return dst;
    800014a8:	fd843783          	ld	a5,-40(s0)
}
    800014ac:	853e                	mv	a0,a5
    800014ae:	7422                	ld	s0,40(sp)
    800014b0:	6145                	addi	sp,sp,48
    800014b2:	8082                	ret

00000000800014b4 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
    800014b4:	7139                	addi	sp,sp,-64
    800014b6:	fc22                	sd	s0,56(sp)
    800014b8:	0080                	addi	s0,sp,64
    800014ba:	fca43c23          	sd	a0,-40(s0)
    800014be:	fcb43823          	sd	a1,-48(s0)
    800014c2:	87b2                	mv	a5,a2
    800014c4:	fcf42623          	sw	a5,-52(s0)
  const uchar *s1, *s2;

  s1 = v1;
    800014c8:	fd843783          	ld	a5,-40(s0)
    800014cc:	fef43423          	sd	a5,-24(s0)
  s2 = v2;
    800014d0:	fd043783          	ld	a5,-48(s0)
    800014d4:	fef43023          	sd	a5,-32(s0)
  while(n-- > 0){
    800014d8:	a0a1                	j	80001520 <memcmp+0x6c>
    if(*s1 != *s2)
    800014da:	fe843783          	ld	a5,-24(s0)
    800014de:	0007c703          	lbu	a4,0(a5)
    800014e2:	fe043783          	ld	a5,-32(s0)
    800014e6:	0007c783          	lbu	a5,0(a5)
    800014ea:	02f70163          	beq	a4,a5,8000150c <memcmp+0x58>
      return *s1 - *s2;
    800014ee:	fe843783          	ld	a5,-24(s0)
    800014f2:	0007c783          	lbu	a5,0(a5)
    800014f6:	0007871b          	sext.w	a4,a5
    800014fa:	fe043783          	ld	a5,-32(s0)
    800014fe:	0007c783          	lbu	a5,0(a5)
    80001502:	2781                	sext.w	a5,a5
    80001504:	40f707bb          	subw	a5,a4,a5
    80001508:	2781                	sext.w	a5,a5
    8000150a:	a01d                	j	80001530 <memcmp+0x7c>
    s1++, s2++;
    8000150c:	fe843783          	ld	a5,-24(s0)
    80001510:	0785                	addi	a5,a5,1
    80001512:	fef43423          	sd	a5,-24(s0)
    80001516:	fe043783          	ld	a5,-32(s0)
    8000151a:	0785                	addi	a5,a5,1
    8000151c:	fef43023          	sd	a5,-32(s0)
  while(n-- > 0){
    80001520:	fcc42783          	lw	a5,-52(s0)
    80001524:	fff7871b          	addiw	a4,a5,-1
    80001528:	fce42623          	sw	a4,-52(s0)
    8000152c:	f7dd                	bnez	a5,800014da <memcmp+0x26>
  }

  return 0;
    8000152e:	4781                	li	a5,0
}
    80001530:	853e                	mv	a0,a5
    80001532:	7462                	ld	s0,56(sp)
    80001534:	6121                	addi	sp,sp,64
    80001536:	8082                	ret

0000000080001538 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
    80001538:	7139                	addi	sp,sp,-64
    8000153a:	fc22                	sd	s0,56(sp)
    8000153c:	0080                	addi	s0,sp,64
    8000153e:	fca43c23          	sd	a0,-40(s0)
    80001542:	fcb43823          	sd	a1,-48(s0)
    80001546:	87b2                	mv	a5,a2
    80001548:	fcf42623          	sw	a5,-52(s0)
  const char *s;
  char *d;

  s = src;
    8000154c:	fd043783          	ld	a5,-48(s0)
    80001550:	fef43423          	sd	a5,-24(s0)
  d = dst;
    80001554:	fd843783          	ld	a5,-40(s0)
    80001558:	fef43023          	sd	a5,-32(s0)
  if(s < d && s + n > d){
    8000155c:	fe843703          	ld	a4,-24(s0)
    80001560:	fe043783          	ld	a5,-32(s0)
    80001564:	08f77463          	bgeu	a4,a5,800015ec <memmove+0xb4>
    80001568:	fcc46783          	lwu	a5,-52(s0)
    8000156c:	fe843703          	ld	a4,-24(s0)
    80001570:	97ba                	add	a5,a5,a4
    80001572:	fe043703          	ld	a4,-32(s0)
    80001576:	06f77b63          	bgeu	a4,a5,800015ec <memmove+0xb4>
    s += n;
    8000157a:	fcc46783          	lwu	a5,-52(s0)
    8000157e:	fe843703          	ld	a4,-24(s0)
    80001582:	97ba                	add	a5,a5,a4
    80001584:	fef43423          	sd	a5,-24(s0)
    d += n;
    80001588:	fcc46783          	lwu	a5,-52(s0)
    8000158c:	fe043703          	ld	a4,-32(s0)
    80001590:	97ba                	add	a5,a5,a4
    80001592:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
    80001596:	a01d                	j	800015bc <memmove+0x84>
      *--d = *--s;
    80001598:	fe843783          	ld	a5,-24(s0)
    8000159c:	17fd                	addi	a5,a5,-1
    8000159e:	fef43423          	sd	a5,-24(s0)
    800015a2:	fe043783          	ld	a5,-32(s0)
    800015a6:	17fd                	addi	a5,a5,-1
    800015a8:	fef43023          	sd	a5,-32(s0)
    800015ac:	fe843783          	ld	a5,-24(s0)
    800015b0:	0007c703          	lbu	a4,0(a5)
    800015b4:	fe043783          	ld	a5,-32(s0)
    800015b8:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
    800015bc:	fcc42783          	lw	a5,-52(s0)
    800015c0:	fff7871b          	addiw	a4,a5,-1
    800015c4:	fce42623          	sw	a4,-52(s0)
    800015c8:	fbe1                	bnez	a5,80001598 <memmove+0x60>
  if(s < d && s + n > d){
    800015ca:	a805                	j	800015fa <memmove+0xc2>
  } else
    while(n-- > 0)
      *d++ = *s++;
    800015cc:	fe843703          	ld	a4,-24(s0)
    800015d0:	00170793          	addi	a5,a4,1
    800015d4:	fef43423          	sd	a5,-24(s0)
    800015d8:	fe043783          	ld	a5,-32(s0)
    800015dc:	00178693          	addi	a3,a5,1
    800015e0:	fed43023          	sd	a3,-32(s0)
    800015e4:	00074703          	lbu	a4,0(a4)
    800015e8:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
    800015ec:	fcc42783          	lw	a5,-52(s0)
    800015f0:	fff7871b          	addiw	a4,a5,-1
    800015f4:	fce42623          	sw	a4,-52(s0)
    800015f8:	fbf1                	bnez	a5,800015cc <memmove+0x94>

  return dst;
    800015fa:	fd843783          	ld	a5,-40(s0)
}
    800015fe:	853e                	mv	a0,a5
    80001600:	7462                	ld	s0,56(sp)
    80001602:	6121                	addi	sp,sp,64
    80001604:	8082                	ret

0000000080001606 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
    80001606:	7179                	addi	sp,sp,-48
    80001608:	f406                	sd	ra,40(sp)
    8000160a:	f022                	sd	s0,32(sp)
    8000160c:	1800                	addi	s0,sp,48
    8000160e:	fea43423          	sd	a0,-24(s0)
    80001612:	feb43023          	sd	a1,-32(s0)
    80001616:	87b2                	mv	a5,a2
    80001618:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
    8000161c:	fdc42783          	lw	a5,-36(s0)
    80001620:	863e                	mv	a2,a5
    80001622:	fe043583          	ld	a1,-32(s0)
    80001626:	fe843503          	ld	a0,-24(s0)
    8000162a:	00000097          	auipc	ra,0x0
    8000162e:	f0e080e7          	jalr	-242(ra) # 80001538 <memmove>
    80001632:	87aa                	mv	a5,a0
}
    80001634:	853e                	mv	a0,a5
    80001636:	70a2                	ld	ra,40(sp)
    80001638:	7402                	ld	s0,32(sp)
    8000163a:	6145                	addi	sp,sp,48
    8000163c:	8082                	ret

000000008000163e <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
    8000163e:	7179                	addi	sp,sp,-48
    80001640:	f422                	sd	s0,40(sp)
    80001642:	1800                	addi	s0,sp,48
    80001644:	fea43423          	sd	a0,-24(s0)
    80001648:	feb43023          	sd	a1,-32(s0)
    8000164c:	87b2                	mv	a5,a2
    8000164e:	fcf42e23          	sw	a5,-36(s0)
  while(n > 0 && *p && *p == *q)
    80001652:	a005                	j	80001672 <strncmp+0x34>
    n--, p++, q++;
    80001654:	fdc42783          	lw	a5,-36(s0)
    80001658:	37fd                	addiw	a5,a5,-1
    8000165a:	fcf42e23          	sw	a5,-36(s0)
    8000165e:	fe843783          	ld	a5,-24(s0)
    80001662:	0785                	addi	a5,a5,1
    80001664:	fef43423          	sd	a5,-24(s0)
    80001668:	fe043783          	ld	a5,-32(s0)
    8000166c:	0785                	addi	a5,a5,1
    8000166e:	fef43023          	sd	a5,-32(s0)
  while(n > 0 && *p && *p == *q)
    80001672:	fdc42783          	lw	a5,-36(s0)
    80001676:	2781                	sext.w	a5,a5
    80001678:	c385                	beqz	a5,80001698 <strncmp+0x5a>
    8000167a:	fe843783          	ld	a5,-24(s0)
    8000167e:	0007c783          	lbu	a5,0(a5)
    80001682:	cb99                	beqz	a5,80001698 <strncmp+0x5a>
    80001684:	fe843783          	ld	a5,-24(s0)
    80001688:	0007c703          	lbu	a4,0(a5)
    8000168c:	fe043783          	ld	a5,-32(s0)
    80001690:	0007c783          	lbu	a5,0(a5)
    80001694:	fcf700e3          	beq	a4,a5,80001654 <strncmp+0x16>
  if(n == 0)
    80001698:	fdc42783          	lw	a5,-36(s0)
    8000169c:	2781                	sext.w	a5,a5
    8000169e:	e399                	bnez	a5,800016a4 <strncmp+0x66>
    return 0;
    800016a0:	4781                	li	a5,0
    800016a2:	a839                	j	800016c0 <strncmp+0x82>
  return (uchar)*p - (uchar)*q;
    800016a4:	fe843783          	ld	a5,-24(s0)
    800016a8:	0007c783          	lbu	a5,0(a5)
    800016ac:	0007871b          	sext.w	a4,a5
    800016b0:	fe043783          	ld	a5,-32(s0)
    800016b4:	0007c783          	lbu	a5,0(a5)
    800016b8:	2781                	sext.w	a5,a5
    800016ba:	40f707bb          	subw	a5,a4,a5
    800016be:	2781                	sext.w	a5,a5
}
    800016c0:	853e                	mv	a0,a5
    800016c2:	7422                	ld	s0,40(sp)
    800016c4:	6145                	addi	sp,sp,48
    800016c6:	8082                	ret

00000000800016c8 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
    800016c8:	7139                	addi	sp,sp,-64
    800016ca:	fc22                	sd	s0,56(sp)
    800016cc:	0080                	addi	s0,sp,64
    800016ce:	fca43c23          	sd	a0,-40(s0)
    800016d2:	fcb43823          	sd	a1,-48(s0)
    800016d6:	87b2                	mv	a5,a2
    800016d8:	fcf42623          	sw	a5,-52(s0)
  char *os;

  os = s;
    800016dc:	fd843783          	ld	a5,-40(s0)
    800016e0:	fef43423          	sd	a5,-24(s0)
  while(n-- > 0 && (*s++ = *t++) != 0)
    800016e4:	0001                	nop
    800016e6:	fcc42783          	lw	a5,-52(s0)
    800016ea:	fff7871b          	addiw	a4,a5,-1
    800016ee:	fce42623          	sw	a4,-52(s0)
    800016f2:	02f05e63          	blez	a5,8000172e <strncpy+0x66>
    800016f6:	fd043703          	ld	a4,-48(s0)
    800016fa:	00170793          	addi	a5,a4,1
    800016fe:	fcf43823          	sd	a5,-48(s0)
    80001702:	fd843783          	ld	a5,-40(s0)
    80001706:	00178693          	addi	a3,a5,1
    8000170a:	fcd43c23          	sd	a3,-40(s0)
    8000170e:	00074703          	lbu	a4,0(a4)
    80001712:	00e78023          	sb	a4,0(a5)
    80001716:	0007c783          	lbu	a5,0(a5)
    8000171a:	f7f1                	bnez	a5,800016e6 <strncpy+0x1e>
    ;
  while(n-- > 0)
    8000171c:	a809                	j	8000172e <strncpy+0x66>
    *s++ = 0;
    8000171e:	fd843783          	ld	a5,-40(s0)
    80001722:	00178713          	addi	a4,a5,1
    80001726:	fce43c23          	sd	a4,-40(s0)
    8000172a:	00078023          	sb	zero,0(a5)
  while(n-- > 0)
    8000172e:	fcc42783          	lw	a5,-52(s0)
    80001732:	fff7871b          	addiw	a4,a5,-1
    80001736:	fce42623          	sw	a4,-52(s0)
    8000173a:	fef042e3          	bgtz	a5,8000171e <strncpy+0x56>
  return os;
    8000173e:	fe843783          	ld	a5,-24(s0)
}
    80001742:	853e                	mv	a0,a5
    80001744:	7462                	ld	s0,56(sp)
    80001746:	6121                	addi	sp,sp,64
    80001748:	8082                	ret

000000008000174a <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
    8000174a:	7139                	addi	sp,sp,-64
    8000174c:	fc22                	sd	s0,56(sp)
    8000174e:	0080                	addi	s0,sp,64
    80001750:	fca43c23          	sd	a0,-40(s0)
    80001754:	fcb43823          	sd	a1,-48(s0)
    80001758:	87b2                	mv	a5,a2
    8000175a:	fcf42623          	sw	a5,-52(s0)
  char *os;

  os = s;
    8000175e:	fd843783          	ld	a5,-40(s0)
    80001762:	fef43423          	sd	a5,-24(s0)
  if(n <= 0)
    80001766:	fcc42783          	lw	a5,-52(s0)
    8000176a:	2781                	sext.w	a5,a5
    8000176c:	00f04563          	bgtz	a5,80001776 <safestrcpy+0x2c>
    return os;
    80001770:	fe843783          	ld	a5,-24(s0)
    80001774:	a0a1                	j	800017bc <safestrcpy+0x72>
  while(--n > 0 && (*s++ = *t++) != 0)
    80001776:	fcc42783          	lw	a5,-52(s0)
    8000177a:	37fd                	addiw	a5,a5,-1
    8000177c:	fcf42623          	sw	a5,-52(s0)
    80001780:	fcc42783          	lw	a5,-52(s0)
    80001784:	2781                	sext.w	a5,a5
    80001786:	02f05563          	blez	a5,800017b0 <safestrcpy+0x66>
    8000178a:	fd043703          	ld	a4,-48(s0)
    8000178e:	00170793          	addi	a5,a4,1
    80001792:	fcf43823          	sd	a5,-48(s0)
    80001796:	fd843783          	ld	a5,-40(s0)
    8000179a:	00178693          	addi	a3,a5,1
    8000179e:	fcd43c23          	sd	a3,-40(s0)
    800017a2:	00074703          	lbu	a4,0(a4)
    800017a6:	00e78023          	sb	a4,0(a5)
    800017aa:	0007c783          	lbu	a5,0(a5)
    800017ae:	f7e1                	bnez	a5,80001776 <safestrcpy+0x2c>
    ;
  *s = 0;
    800017b0:	fd843783          	ld	a5,-40(s0)
    800017b4:	00078023          	sb	zero,0(a5)
  return os;
    800017b8:	fe843783          	ld	a5,-24(s0)
}
    800017bc:	853e                	mv	a0,a5
    800017be:	7462                	ld	s0,56(sp)
    800017c0:	6121                	addi	sp,sp,64
    800017c2:	8082                	ret

00000000800017c4 <strlen>:

int
strlen(const char *s)
{
    800017c4:	7179                	addi	sp,sp,-48
    800017c6:	f422                	sd	s0,40(sp)
    800017c8:	1800                	addi	s0,sp,48
    800017ca:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
    800017ce:	fe042623          	sw	zero,-20(s0)
    800017d2:	a031                	j	800017de <strlen+0x1a>
    800017d4:	fec42783          	lw	a5,-20(s0)
    800017d8:	2785                	addiw	a5,a5,1
    800017da:	fef42623          	sw	a5,-20(s0)
    800017de:	fec42783          	lw	a5,-20(s0)
    800017e2:	fd843703          	ld	a4,-40(s0)
    800017e6:	97ba                	add	a5,a5,a4
    800017e8:	0007c783          	lbu	a5,0(a5)
    800017ec:	f7e5                	bnez	a5,800017d4 <strlen+0x10>
    ;
  return n;
    800017ee:	fec42783          	lw	a5,-20(s0)
}
    800017f2:	853e                	mv	a0,a5
    800017f4:	7422                	ld	s0,40(sp)
    800017f6:	6145                	addi	sp,sp,48
    800017f8:	8082                	ret

00000000800017fa <main>:
volatile static int started = 0;

// start() jumps here in supervisor mode on all CPUs.
void
main()
{
    800017fa:	1141                	addi	sp,sp,-16
    800017fc:	e406                	sd	ra,8(sp)
    800017fe:	e022                	sd	s0,0(sp)
    80001800:	0800                	addi	s0,sp,16
  if(cpuid() == 0){
    80001802:	00001097          	auipc	ra,0x1
    80001806:	f98080e7          	jalr	-104(ra) # 8000279a <cpuid>
    8000180a:	87aa                	mv	a5,a0
    8000180c:	efd5                	bnez	a5,800018c8 <main+0xce>
    consoleinit();
    8000180e:	fffff097          	auipc	ra,0xfffff
    80001812:	018080e7          	jalr	24(ra) # 80000826 <consoleinit>
    printfinit();
    80001816:	fffff097          	auipc	ra,0xfffff
    8000181a:	48e080e7          	jalr	1166(ra) # 80000ca4 <printfinit>
    printf("\n");
    8000181e:	0000b517          	auipc	a0,0xb
    80001822:	86250513          	addi	a0,a0,-1950 # 8000c080 <etext+0x80>
    80001826:	fffff097          	auipc	ra,0xfffff
    8000182a:	1d6080e7          	jalr	470(ra) # 800009fc <printf>
    printf("xv6 kernel is booting\n");
    8000182e:	0000b517          	auipc	a0,0xb
    80001832:	85a50513          	addi	a0,a0,-1958 # 8000c088 <etext+0x88>
    80001836:	fffff097          	auipc	ra,0xfffff
    8000183a:	1c6080e7          	jalr	454(ra) # 800009fc <printf>
    printf("\n");
    8000183e:	0000b517          	auipc	a0,0xb
    80001842:	84250513          	addi	a0,a0,-1982 # 8000c080 <etext+0x80>
    80001846:	fffff097          	auipc	ra,0xfffff
    8000184a:	1b6080e7          	jalr	438(ra) # 800009fc <printf>
    kinit();         // physical page allocator
    8000184e:	fffff097          	auipc	ra,0xfffff
    80001852:	7a2080e7          	jalr	1954(ra) # 80000ff0 <kinit>
    kvminit();       // create kernel page table
    80001856:	00000097          	auipc	ra,0x0
    8000185a:	1f4080e7          	jalr	500(ra) # 80001a4a <kvminit>
    kvminithart();   // turn on paging
    8000185e:	00000097          	auipc	ra,0x0
    80001862:	212080e7          	jalr	530(ra) # 80001a70 <kvminithart>
    procinit();      // process table
    80001866:	00001097          	auipc	ra,0x1
    8000186a:	e7c080e7          	jalr	-388(ra) # 800026e2 <procinit>
    trapinit();      // trap vectors
    8000186e:	00002097          	auipc	ra,0x2
    80001872:	2c2080e7          	jalr	706(ra) # 80003b30 <trapinit>
    trapinithart();  // install kernel trap vector
    80001876:	00002097          	auipc	ra,0x2
    8000187a:	2e4080e7          	jalr	740(ra) # 80003b5a <trapinithart>
    plicinit();      // set up interrupt controller
    8000187e:	00007097          	auipc	ra,0x7
    80001882:	77c080e7          	jalr	1916(ra) # 80008ffa <plicinit>
    plicinithart();  // ask PLIC for device interrupts
    80001886:	00007097          	auipc	ra,0x7
    8000188a:	798080e7          	jalr	1944(ra) # 8000901e <plicinithart>
    binit();         // buffer cache
    8000188e:	00003097          	auipc	ra,0x3
    80001892:	2f4080e7          	jalr	756(ra) # 80004b82 <binit>
    iinit();         // inode cache
    80001896:	00004097          	auipc	ra,0x4
    8000189a:	b40080e7          	jalr	-1216(ra) # 800053d6 <iinit>
    fileinit();      // file table
    8000189e:	00005097          	auipc	ra,0x5
    800018a2:	4f4080e7          	jalr	1268(ra) # 80006d92 <fileinit>
    virtio_disk_init(); // emulated hard disk
    800018a6:	00008097          	auipc	ra,0x8
    800018aa:	84c080e7          	jalr	-1972(ra) # 800090f2 <virtio_disk_init>
    userinit();      // first user process
    800018ae:	00001097          	auipc	ra,0x1
    800018b2:	376080e7          	jalr	886(ra) # 80002c24 <userinit>
    __sync_synchronize();
    800018b6:	0ff0000f          	fence
    started = 1;
    800018ba:	00014797          	auipc	a5,0x14
    800018be:	9d678793          	addi	a5,a5,-1578 # 80015290 <started>
    800018c2:	4705                	li	a4,1
    800018c4:	c398                	sw	a4,0(a5)
    800018c6:	a0a9                	j	80001910 <main+0x116>
  } else {
    while(started == 0)
    800018c8:	0001                	nop
    800018ca:	00014797          	auipc	a5,0x14
    800018ce:	9c678793          	addi	a5,a5,-1594 # 80015290 <started>
    800018d2:	439c                	lw	a5,0(a5)
    800018d4:	2781                	sext.w	a5,a5
    800018d6:	dbf5                	beqz	a5,800018ca <main+0xd0>
      ;
    __sync_synchronize();
    800018d8:	0ff0000f          	fence
    printf("hart %d starting\n", cpuid());
    800018dc:	00001097          	auipc	ra,0x1
    800018e0:	ebe080e7          	jalr	-322(ra) # 8000279a <cpuid>
    800018e4:	87aa                	mv	a5,a0
    800018e6:	85be                	mv	a1,a5
    800018e8:	0000a517          	auipc	a0,0xa
    800018ec:	7b850513          	addi	a0,a0,1976 # 8000c0a0 <etext+0xa0>
    800018f0:	fffff097          	auipc	ra,0xfffff
    800018f4:	10c080e7          	jalr	268(ra) # 800009fc <printf>
    kvminithart();    // turn on paging
    800018f8:	00000097          	auipc	ra,0x0
    800018fc:	178080e7          	jalr	376(ra) # 80001a70 <kvminithart>
    trapinithart();   // install kernel trap vector
    80001900:	00002097          	auipc	ra,0x2
    80001904:	25a080e7          	jalr	602(ra) # 80003b5a <trapinithart>
    plicinithart();   // ask PLIC for device interrupts
    80001908:	00007097          	auipc	ra,0x7
    8000190c:	716080e7          	jalr	1814(ra) # 8000901e <plicinithart>
  }

  scheduler();        
    80001910:	00002097          	auipc	ra,0x2
    80001914:	9ea080e7          	jalr	-1558(ra) # 800032fa <scheduler>

0000000080001918 <w_satp>:
{
    80001918:	1101                	addi	sp,sp,-32
    8000191a:	ec22                	sd	s0,24(sp)
    8000191c:	1000                	addi	s0,sp,32
    8000191e:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw satp, %0" : : "r" (x));
    80001922:	fe843783          	ld	a5,-24(s0)
    80001926:	18079073          	csrw	satp,a5
}
    8000192a:	0001                	nop
    8000192c:	6462                	ld	s0,24(sp)
    8000192e:	6105                	addi	sp,sp,32
    80001930:	8082                	ret

0000000080001932 <sfence_vma>:
}

// flush the TLB.
static inline void
sfence_vma()
{
    80001932:	1141                	addi	sp,sp,-16
    80001934:	e422                	sd	s0,8(sp)
    80001936:	0800                	addi	s0,sp,16
  // the zero, zero means flush all TLB entries.
  asm volatile("sfence.vma zero, zero");
    80001938:	12000073          	sfence.vma
}
    8000193c:	0001                	nop
    8000193e:	6422                	ld	s0,8(sp)
    80001940:	0141                	addi	sp,sp,16
    80001942:	8082                	ret

0000000080001944 <kvmmake>:
extern char trampoline[]; // trampoline.S

// Make a direct-map page table for the kernel.
pagetable_t
kvmmake(void)
{
    80001944:	1101                	addi	sp,sp,-32
    80001946:	ec06                	sd	ra,24(sp)
    80001948:	e822                	sd	s0,16(sp)
    8000194a:	1000                	addi	s0,sp,32
  pagetable_t kpgtbl;

  kpgtbl = (pagetable_t) kalloc();
    8000194c:	fffff097          	auipc	ra,0xfffff
    80001950:	7e0080e7          	jalr	2016(ra) # 8000112c <kalloc>
    80001954:	fea43423          	sd	a0,-24(s0)
  memset(kpgtbl, 0, PGSIZE);
    80001958:	6605                	lui	a2,0x1
    8000195a:	4581                	li	a1,0
    8000195c:	fe843503          	ld	a0,-24(s0)
    80001960:	00000097          	auipc	ra,0x0
    80001964:	af4080e7          	jalr	-1292(ra) # 80001454 <memset>

  // uart registers
  kvmmap(kpgtbl, UART0, UART0, PGSIZE, PTE_R | PTE_W);
    80001968:	4719                	li	a4,6
    8000196a:	6685                	lui	a3,0x1
    8000196c:	10000637          	lui	a2,0x10000
    80001970:	100005b7          	lui	a1,0x10000
    80001974:	fe843503          	ld	a0,-24(s0)
    80001978:	00000097          	auipc	ra,0x0
    8000197c:	298080e7          	jalr	664(ra) # 80001c10 <kvmmap>

  // virtio mmio disk interface
  kvmmap(kpgtbl, VIRTIO0, VIRTIO0, PGSIZE, PTE_R | PTE_W);
    80001980:	4719                	li	a4,6
    80001982:	6685                	lui	a3,0x1
    80001984:	10001637          	lui	a2,0x10001
    80001988:	100015b7          	lui	a1,0x10001
    8000198c:	fe843503          	ld	a0,-24(s0)
    80001990:	00000097          	auipc	ra,0x0
    80001994:	280080e7          	jalr	640(ra) # 80001c10 <kvmmap>

  // PLIC
  kvmmap(kpgtbl, PLIC, PLIC, 0x400000, PTE_R | PTE_W);
    80001998:	4719                	li	a4,6
    8000199a:	004006b7          	lui	a3,0x400
    8000199e:	0c000637          	lui	a2,0xc000
    800019a2:	0c0005b7          	lui	a1,0xc000
    800019a6:	fe843503          	ld	a0,-24(s0)
    800019aa:	00000097          	auipc	ra,0x0
    800019ae:	266080e7          	jalr	614(ra) # 80001c10 <kvmmap>

  // map kernel text executable and read-only.
  kvmmap(kpgtbl, KERNBASE, KERNBASE, (uint64)etext-KERNBASE, PTE_R | PTE_X);
    800019b2:	0000a717          	auipc	a4,0xa
    800019b6:	64e70713          	addi	a4,a4,1614 # 8000c000 <etext>
    800019ba:	800007b7          	lui	a5,0x80000
    800019be:	97ba                	add	a5,a5,a4
    800019c0:	4729                	li	a4,10
    800019c2:	86be                	mv	a3,a5
    800019c4:	4785                	li	a5,1
    800019c6:	01f79613          	slli	a2,a5,0x1f
    800019ca:	4785                	li	a5,1
    800019cc:	01f79593          	slli	a1,a5,0x1f
    800019d0:	fe843503          	ld	a0,-24(s0)
    800019d4:	00000097          	auipc	ra,0x0
    800019d8:	23c080e7          	jalr	572(ra) # 80001c10 <kvmmap>

  // map kernel data and the physical RAM we'll make use of.
  kvmmap(kpgtbl, (uint64)etext, (uint64)etext, PHYSTOP-(uint64)etext, PTE_R | PTE_W);
    800019dc:	0000a597          	auipc	a1,0xa
    800019e0:	62458593          	addi	a1,a1,1572 # 8000c000 <etext>
    800019e4:	0000a617          	auipc	a2,0xa
    800019e8:	61c60613          	addi	a2,a2,1564 # 8000c000 <etext>
    800019ec:	0000a797          	auipc	a5,0xa
    800019f0:	61478793          	addi	a5,a5,1556 # 8000c000 <etext>
    800019f4:	4745                	li	a4,17
    800019f6:	076e                	slli	a4,a4,0x1b
    800019f8:	40f707b3          	sub	a5,a4,a5
    800019fc:	4719                	li	a4,6
    800019fe:	86be                	mv	a3,a5
    80001a00:	fe843503          	ld	a0,-24(s0)
    80001a04:	00000097          	auipc	ra,0x0
    80001a08:	20c080e7          	jalr	524(ra) # 80001c10 <kvmmap>

  // map the trampoline for trap entry/exit to
  // the highest virtual address in the kernel.
  kvmmap(kpgtbl, TRAMPOLINE, (uint64)trampoline, PGSIZE, PTE_R | PTE_X);
    80001a0c:	00009797          	auipc	a5,0x9
    80001a10:	5f478793          	addi	a5,a5,1524 # 8000b000 <_trampoline>
    80001a14:	4729                	li	a4,10
    80001a16:	6685                	lui	a3,0x1
    80001a18:	863e                	mv	a2,a5
    80001a1a:	040007b7          	lui	a5,0x4000
    80001a1e:	17fd                	addi	a5,a5,-1
    80001a20:	00c79593          	slli	a1,a5,0xc
    80001a24:	fe843503          	ld	a0,-24(s0)
    80001a28:	00000097          	auipc	ra,0x0
    80001a2c:	1e8080e7          	jalr	488(ra) # 80001c10 <kvmmap>

  // map kernel stacks
  proc_mapstacks(kpgtbl);
    80001a30:	fe843503          	ld	a0,-24(s0)
    80001a34:	00001097          	auipc	ra,0x1
    80001a38:	bee080e7          	jalr	-1042(ra) # 80002622 <proc_mapstacks>
  
  return kpgtbl;
    80001a3c:	fe843783          	ld	a5,-24(s0)
}
    80001a40:	853e                	mv	a0,a5
    80001a42:	60e2                	ld	ra,24(sp)
    80001a44:	6442                	ld	s0,16(sp)
    80001a46:	6105                	addi	sp,sp,32
    80001a48:	8082                	ret

0000000080001a4a <kvminit>:

// Initialize the one kernel_pagetable
void
kvminit(void)
{
    80001a4a:	1141                	addi	sp,sp,-16
    80001a4c:	e406                	sd	ra,8(sp)
    80001a4e:	e022                	sd	s0,0(sp)
    80001a50:	0800                	addi	s0,sp,16
  kernel_pagetable = kvmmake();
    80001a52:	00000097          	auipc	ra,0x0
    80001a56:	ef2080e7          	jalr	-270(ra) # 80001944 <kvmmake>
    80001a5a:	872a                	mv	a4,a0
    80001a5c:	0000b797          	auipc	a5,0xb
    80001a60:	5b478793          	addi	a5,a5,1460 # 8000d010 <kernel_pagetable>
    80001a64:	e398                	sd	a4,0(a5)
}
    80001a66:	0001                	nop
    80001a68:	60a2                	ld	ra,8(sp)
    80001a6a:	6402                	ld	s0,0(sp)
    80001a6c:	0141                	addi	sp,sp,16
    80001a6e:	8082                	ret

0000000080001a70 <kvminithart>:

// Switch h/w page table register to the kernel's page table,
// and enable paging.
void
kvminithart()
{
    80001a70:	1141                	addi	sp,sp,-16
    80001a72:	e406                	sd	ra,8(sp)
    80001a74:	e022                	sd	s0,0(sp)
    80001a76:	0800                	addi	s0,sp,16
  w_satp(MAKE_SATP(kernel_pagetable));
    80001a78:	0000b797          	auipc	a5,0xb
    80001a7c:	59878793          	addi	a5,a5,1432 # 8000d010 <kernel_pagetable>
    80001a80:	639c                	ld	a5,0(a5)
    80001a82:	00c7d713          	srli	a4,a5,0xc
    80001a86:	57fd                	li	a5,-1
    80001a88:	17fe                	slli	a5,a5,0x3f
    80001a8a:	8fd9                	or	a5,a5,a4
    80001a8c:	853e                	mv	a0,a5
    80001a8e:	00000097          	auipc	ra,0x0
    80001a92:	e8a080e7          	jalr	-374(ra) # 80001918 <w_satp>
  sfence_vma();
    80001a96:	00000097          	auipc	ra,0x0
    80001a9a:	e9c080e7          	jalr	-356(ra) # 80001932 <sfence_vma>
}
    80001a9e:	0001                	nop
    80001aa0:	60a2                	ld	ra,8(sp)
    80001aa2:	6402                	ld	s0,0(sp)
    80001aa4:	0141                	addi	sp,sp,16
    80001aa6:	8082                	ret

0000000080001aa8 <walk>:
//   21..29 -- 9 bits of level-1 index.
//   12..20 -- 9 bits of level-0 index.
//    0..11 -- 12 bits of byte offset within the page.
pte_t *
walk(pagetable_t pagetable, uint64 va, int alloc)
{
    80001aa8:	7139                	addi	sp,sp,-64
    80001aaa:	fc06                	sd	ra,56(sp)
    80001aac:	f822                	sd	s0,48(sp)
    80001aae:	0080                	addi	s0,sp,64
    80001ab0:	fca43c23          	sd	a0,-40(s0)
    80001ab4:	fcb43823          	sd	a1,-48(s0)
    80001ab8:	87b2                	mv	a5,a2
    80001aba:	fcf42623          	sw	a5,-52(s0)
  if(va >= MAXVA)
    80001abe:	fd043703          	ld	a4,-48(s0)
    80001ac2:	57fd                	li	a5,-1
    80001ac4:	83e9                	srli	a5,a5,0x1a
    80001ac6:	00e7fa63          	bgeu	a5,a4,80001ada <walk+0x32>
    panic("walk");
    80001aca:	0000a517          	auipc	a0,0xa
    80001ace:	5ee50513          	addi	a0,a0,1518 # 8000c0b8 <etext+0xb8>
    80001ad2:	fffff097          	auipc	ra,0xfffff
    80001ad6:	180080e7          	jalr	384(ra) # 80000c52 <panic>

  for(int level = 2; level > 0; level--) {
    80001ada:	4789                	li	a5,2
    80001adc:	fef42623          	sw	a5,-20(s0)
    80001ae0:	a849                	j	80001b72 <walk+0xca>
    pte_t *pte = &pagetable[PX(level, va)];
    80001ae2:	fec42703          	lw	a4,-20(s0)
    80001ae6:	87ba                	mv	a5,a4
    80001ae8:	0037979b          	slliw	a5,a5,0x3
    80001aec:	9fb9                	addw	a5,a5,a4
    80001aee:	2781                	sext.w	a5,a5
    80001af0:	27b1                	addiw	a5,a5,12
    80001af2:	2781                	sext.w	a5,a5
    80001af4:	873e                	mv	a4,a5
    80001af6:	fd043783          	ld	a5,-48(s0)
    80001afa:	00e7d7b3          	srl	a5,a5,a4
    80001afe:	1ff7f793          	andi	a5,a5,511
    80001b02:	078e                	slli	a5,a5,0x3
    80001b04:	fd843703          	ld	a4,-40(s0)
    80001b08:	97ba                	add	a5,a5,a4
    80001b0a:	fef43023          	sd	a5,-32(s0)
    if(*pte & PTE_V) {
    80001b0e:	fe043783          	ld	a5,-32(s0)
    80001b12:	639c                	ld	a5,0(a5)
    80001b14:	8b85                	andi	a5,a5,1
    80001b16:	cb89                	beqz	a5,80001b28 <walk+0x80>
      pagetable = (pagetable_t)PTE2PA(*pte);
    80001b18:	fe043783          	ld	a5,-32(s0)
    80001b1c:	639c                	ld	a5,0(a5)
    80001b1e:	83a9                	srli	a5,a5,0xa
    80001b20:	07b2                	slli	a5,a5,0xc
    80001b22:	fcf43c23          	sd	a5,-40(s0)
    80001b26:	a089                	j	80001b68 <walk+0xc0>
    } else {
      if(!alloc || (pagetable = (pde_t*)kalloc()) == 0)
    80001b28:	fcc42783          	lw	a5,-52(s0)
    80001b2c:	2781                	sext.w	a5,a5
    80001b2e:	cb91                	beqz	a5,80001b42 <walk+0x9a>
    80001b30:	fffff097          	auipc	ra,0xfffff
    80001b34:	5fc080e7          	jalr	1532(ra) # 8000112c <kalloc>
    80001b38:	fca43c23          	sd	a0,-40(s0)
    80001b3c:	fd843783          	ld	a5,-40(s0)
    80001b40:	e399                	bnez	a5,80001b46 <walk+0x9e>
        return 0;
    80001b42:	4781                	li	a5,0
    80001b44:	a0a9                	j	80001b8e <walk+0xe6>
      memset(pagetable, 0, PGSIZE);
    80001b46:	6605                	lui	a2,0x1
    80001b48:	4581                	li	a1,0
    80001b4a:	fd843503          	ld	a0,-40(s0)
    80001b4e:	00000097          	auipc	ra,0x0
    80001b52:	906080e7          	jalr	-1786(ra) # 80001454 <memset>
      *pte = PA2PTE(pagetable) | PTE_V;
    80001b56:	fd843783          	ld	a5,-40(s0)
    80001b5a:	83b1                	srli	a5,a5,0xc
    80001b5c:	07aa                	slli	a5,a5,0xa
    80001b5e:	0017e713          	ori	a4,a5,1
    80001b62:	fe043783          	ld	a5,-32(s0)
    80001b66:	e398                	sd	a4,0(a5)
  for(int level = 2; level > 0; level--) {
    80001b68:	fec42783          	lw	a5,-20(s0)
    80001b6c:	37fd                	addiw	a5,a5,-1
    80001b6e:	fef42623          	sw	a5,-20(s0)
    80001b72:	fec42783          	lw	a5,-20(s0)
    80001b76:	2781                	sext.w	a5,a5
    80001b78:	f6f045e3          	bgtz	a5,80001ae2 <walk+0x3a>
    }
  }
  return &pagetable[PX(0, va)];
    80001b7c:	fd043783          	ld	a5,-48(s0)
    80001b80:	83b1                	srli	a5,a5,0xc
    80001b82:	1ff7f793          	andi	a5,a5,511
    80001b86:	078e                	slli	a5,a5,0x3
    80001b88:	fd843703          	ld	a4,-40(s0)
    80001b8c:	97ba                	add	a5,a5,a4
}
    80001b8e:	853e                	mv	a0,a5
    80001b90:	70e2                	ld	ra,56(sp)
    80001b92:	7442                	ld	s0,48(sp)
    80001b94:	6121                	addi	sp,sp,64
    80001b96:	8082                	ret

0000000080001b98 <walkaddr>:
// Look up a virtual address, return the physical address,
// or 0 if not mapped.
// Can only be used to look up user pages.
uint64
walkaddr(pagetable_t pagetable, uint64 va)
{
    80001b98:	7179                	addi	sp,sp,-48
    80001b9a:	f406                	sd	ra,40(sp)
    80001b9c:	f022                	sd	s0,32(sp)
    80001b9e:	1800                	addi	s0,sp,48
    80001ba0:	fca43c23          	sd	a0,-40(s0)
    80001ba4:	fcb43823          	sd	a1,-48(s0)
  pte_t *pte;
  uint64 pa;

  if(va >= MAXVA)
    80001ba8:	fd043703          	ld	a4,-48(s0)
    80001bac:	57fd                	li	a5,-1
    80001bae:	83e9                	srli	a5,a5,0x1a
    80001bb0:	00e7f463          	bgeu	a5,a4,80001bb8 <walkaddr+0x20>
    return 0;
    80001bb4:	4781                	li	a5,0
    80001bb6:	a881                	j	80001c06 <walkaddr+0x6e>

  pte = walk(pagetable, va, 0);
    80001bb8:	4601                	li	a2,0
    80001bba:	fd043583          	ld	a1,-48(s0)
    80001bbe:	fd843503          	ld	a0,-40(s0)
    80001bc2:	00000097          	auipc	ra,0x0
    80001bc6:	ee6080e7          	jalr	-282(ra) # 80001aa8 <walk>
    80001bca:	fea43423          	sd	a0,-24(s0)
  if(pte == 0)
    80001bce:	fe843783          	ld	a5,-24(s0)
    80001bd2:	e399                	bnez	a5,80001bd8 <walkaddr+0x40>
    return 0;
    80001bd4:	4781                	li	a5,0
    80001bd6:	a805                	j	80001c06 <walkaddr+0x6e>
  if((*pte & PTE_V) == 0)
    80001bd8:	fe843783          	ld	a5,-24(s0)
    80001bdc:	639c                	ld	a5,0(a5)
    80001bde:	8b85                	andi	a5,a5,1
    80001be0:	e399                	bnez	a5,80001be6 <walkaddr+0x4e>
    return 0;
    80001be2:	4781                	li	a5,0
    80001be4:	a00d                	j	80001c06 <walkaddr+0x6e>
  if((*pte & PTE_U) == 0)
    80001be6:	fe843783          	ld	a5,-24(s0)
    80001bea:	639c                	ld	a5,0(a5)
    80001bec:	8bc1                	andi	a5,a5,16
    80001bee:	e399                	bnez	a5,80001bf4 <walkaddr+0x5c>
    return 0;
    80001bf0:	4781                	li	a5,0
    80001bf2:	a811                	j	80001c06 <walkaddr+0x6e>
  pa = PTE2PA(*pte);
    80001bf4:	fe843783          	ld	a5,-24(s0)
    80001bf8:	639c                	ld	a5,0(a5)
    80001bfa:	83a9                	srli	a5,a5,0xa
    80001bfc:	07b2                	slli	a5,a5,0xc
    80001bfe:	fef43023          	sd	a5,-32(s0)
  return pa;
    80001c02:	fe043783          	ld	a5,-32(s0)
}
    80001c06:	853e                	mv	a0,a5
    80001c08:	70a2                	ld	ra,40(sp)
    80001c0a:	7402                	ld	s0,32(sp)
    80001c0c:	6145                	addi	sp,sp,48
    80001c0e:	8082                	ret

0000000080001c10 <kvmmap>:
// add a mapping to the kernel page table.
// only used when booting.
// does not flush TLB or enable paging.
void
kvmmap(pagetable_t kpgtbl, uint64 va, uint64 pa, uint64 sz, int perm)
{
    80001c10:	7139                	addi	sp,sp,-64
    80001c12:	fc06                	sd	ra,56(sp)
    80001c14:	f822                	sd	s0,48(sp)
    80001c16:	0080                	addi	s0,sp,64
    80001c18:	fea43423          	sd	a0,-24(s0)
    80001c1c:	feb43023          	sd	a1,-32(s0)
    80001c20:	fcc43c23          	sd	a2,-40(s0)
    80001c24:	fcd43823          	sd	a3,-48(s0)
    80001c28:	87ba                	mv	a5,a4
    80001c2a:	fcf42623          	sw	a5,-52(s0)
  if(mappages(kpgtbl, va, sz, pa, perm) != 0)
    80001c2e:	fcc42783          	lw	a5,-52(s0)
    80001c32:	873e                	mv	a4,a5
    80001c34:	fd843683          	ld	a3,-40(s0)
    80001c38:	fd043603          	ld	a2,-48(s0)
    80001c3c:	fe043583          	ld	a1,-32(s0)
    80001c40:	fe843503          	ld	a0,-24(s0)
    80001c44:	00000097          	auipc	ra,0x0
    80001c48:	026080e7          	jalr	38(ra) # 80001c6a <mappages>
    80001c4c:	87aa                	mv	a5,a0
    80001c4e:	cb89                	beqz	a5,80001c60 <kvmmap+0x50>
    panic("kvmmap");
    80001c50:	0000a517          	auipc	a0,0xa
    80001c54:	47050513          	addi	a0,a0,1136 # 8000c0c0 <etext+0xc0>
    80001c58:	fffff097          	auipc	ra,0xfffff
    80001c5c:	ffa080e7          	jalr	-6(ra) # 80000c52 <panic>
}
    80001c60:	0001                	nop
    80001c62:	70e2                	ld	ra,56(sp)
    80001c64:	7442                	ld	s0,48(sp)
    80001c66:	6121                	addi	sp,sp,64
    80001c68:	8082                	ret

0000000080001c6a <mappages>:
// physical addresses starting at pa. va and size might not
// be page-aligned. Returns 0 on success, -1 if walk() couldn't
// allocate a needed page-table page.
int
mappages(pagetable_t pagetable, uint64 va, uint64 size, uint64 pa, int perm)
{
    80001c6a:	711d                	addi	sp,sp,-96
    80001c6c:	ec86                	sd	ra,88(sp)
    80001c6e:	e8a2                	sd	s0,80(sp)
    80001c70:	1080                	addi	s0,sp,96
    80001c72:	fca43423          	sd	a0,-56(s0)
    80001c76:	fcb43023          	sd	a1,-64(s0)
    80001c7a:	fac43c23          	sd	a2,-72(s0)
    80001c7e:	fad43823          	sd	a3,-80(s0)
    80001c82:	87ba                	mv	a5,a4
    80001c84:	faf42623          	sw	a5,-84(s0)
  uint64 a, last;
  pte_t *pte;

  a = PGROUNDDOWN(va);
    80001c88:	fc043703          	ld	a4,-64(s0)
    80001c8c:	77fd                	lui	a5,0xfffff
    80001c8e:	8ff9                	and	a5,a5,a4
    80001c90:	fef43423          	sd	a5,-24(s0)
  last = PGROUNDDOWN(va + size - 1);
    80001c94:	fc043703          	ld	a4,-64(s0)
    80001c98:	fb843783          	ld	a5,-72(s0)
    80001c9c:	97ba                	add	a5,a5,a4
    80001c9e:	fff78713          	addi	a4,a5,-1 # ffffffffffffefff <end+0xffffffff7ff8bfff>
    80001ca2:	77fd                	lui	a5,0xfffff
    80001ca4:	8ff9                	and	a5,a5,a4
    80001ca6:	fef43023          	sd	a5,-32(s0)
  for(;;){
    if((pte = walk(pagetable, a, 1)) == 0)
    80001caa:	4605                	li	a2,1
    80001cac:	fe843583          	ld	a1,-24(s0)
    80001cb0:	fc843503          	ld	a0,-56(s0)
    80001cb4:	00000097          	auipc	ra,0x0
    80001cb8:	df4080e7          	jalr	-524(ra) # 80001aa8 <walk>
    80001cbc:	fca43c23          	sd	a0,-40(s0)
    80001cc0:	fd843783          	ld	a5,-40(s0)
    80001cc4:	e399                	bnez	a5,80001cca <mappages+0x60>
      return -1;
    80001cc6:	57fd                	li	a5,-1
    80001cc8:	a085                	j	80001d28 <mappages+0xbe>
    if(*pte & PTE_V)
    80001cca:	fd843783          	ld	a5,-40(s0)
    80001cce:	639c                	ld	a5,0(a5)
    80001cd0:	8b85                	andi	a5,a5,1
    80001cd2:	cb89                	beqz	a5,80001ce4 <mappages+0x7a>
      panic("remap");
    80001cd4:	0000a517          	auipc	a0,0xa
    80001cd8:	3f450513          	addi	a0,a0,1012 # 8000c0c8 <etext+0xc8>
    80001cdc:	fffff097          	auipc	ra,0xfffff
    80001ce0:	f76080e7          	jalr	-138(ra) # 80000c52 <panic>
    *pte = PA2PTE(pa) | perm | PTE_V;
    80001ce4:	fb043783          	ld	a5,-80(s0)
    80001ce8:	83b1                	srli	a5,a5,0xc
    80001cea:	00a79713          	slli	a4,a5,0xa
    80001cee:	fac42783          	lw	a5,-84(s0)
    80001cf2:	8fd9                	or	a5,a5,a4
    80001cf4:	0017e713          	ori	a4,a5,1
    80001cf8:	fd843783          	ld	a5,-40(s0)
    80001cfc:	e398                	sd	a4,0(a5)
    if(a == last)
    80001cfe:	fe843703          	ld	a4,-24(s0)
    80001d02:	fe043783          	ld	a5,-32(s0)
    80001d06:	00f70f63          	beq	a4,a5,80001d24 <mappages+0xba>
      break;
    a += PGSIZE;
    80001d0a:	fe843703          	ld	a4,-24(s0)
    80001d0e:	6785                	lui	a5,0x1
    80001d10:	97ba                	add	a5,a5,a4
    80001d12:	fef43423          	sd	a5,-24(s0)
    pa += PGSIZE;
    80001d16:	fb043703          	ld	a4,-80(s0)
    80001d1a:	6785                	lui	a5,0x1
    80001d1c:	97ba                	add	a5,a5,a4
    80001d1e:	faf43823          	sd	a5,-80(s0)
    if((pte = walk(pagetable, a, 1)) == 0)
    80001d22:	b761                	j	80001caa <mappages+0x40>
      break;
    80001d24:	0001                	nop
  }
  return 0;
    80001d26:	4781                	li	a5,0
}
    80001d28:	853e                	mv	a0,a5
    80001d2a:	60e6                	ld	ra,88(sp)
    80001d2c:	6446                	ld	s0,80(sp)
    80001d2e:	6125                	addi	sp,sp,96
    80001d30:	8082                	ret

0000000080001d32 <uvmunmap>:
// Remove npages of mappings starting from va. va must be
// page-aligned. The mappings must exist.
// Optionally free the physical memory.
void
uvmunmap(pagetable_t pagetable, uint64 va, uint64 npages, int do_free)
{
    80001d32:	715d                	addi	sp,sp,-80
    80001d34:	e486                	sd	ra,72(sp)
    80001d36:	e0a2                	sd	s0,64(sp)
    80001d38:	0880                	addi	s0,sp,80
    80001d3a:	fca43423          	sd	a0,-56(s0)
    80001d3e:	fcb43023          	sd	a1,-64(s0)
    80001d42:	fac43c23          	sd	a2,-72(s0)
    80001d46:	87b6                	mv	a5,a3
    80001d48:	faf42a23          	sw	a5,-76(s0)
  uint64 a;
  pte_t *pte;

  if((va % PGSIZE) != 0)
    80001d4c:	fc043703          	ld	a4,-64(s0)
    80001d50:	6785                	lui	a5,0x1
    80001d52:	17fd                	addi	a5,a5,-1
    80001d54:	8ff9                	and	a5,a5,a4
    80001d56:	cb89                	beqz	a5,80001d68 <uvmunmap+0x36>
    panic("uvmunmap: not aligned");
    80001d58:	0000a517          	auipc	a0,0xa
    80001d5c:	37850513          	addi	a0,a0,888 # 8000c0d0 <etext+0xd0>
    80001d60:	fffff097          	auipc	ra,0xfffff
    80001d64:	ef2080e7          	jalr	-270(ra) # 80000c52 <panic>

  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    80001d68:	fc043783          	ld	a5,-64(s0)
    80001d6c:	fef43423          	sd	a5,-24(s0)
    80001d70:	a045                	j	80001e10 <uvmunmap+0xde>
    if((pte = walk(pagetable, a, 0)) == 0)
    80001d72:	4601                	li	a2,0
    80001d74:	fe843583          	ld	a1,-24(s0)
    80001d78:	fc843503          	ld	a0,-56(s0)
    80001d7c:	00000097          	auipc	ra,0x0
    80001d80:	d2c080e7          	jalr	-724(ra) # 80001aa8 <walk>
    80001d84:	fea43023          	sd	a0,-32(s0)
    80001d88:	fe043783          	ld	a5,-32(s0)
    80001d8c:	eb89                	bnez	a5,80001d9e <uvmunmap+0x6c>
      panic("uvmunmap: walk");
    80001d8e:	0000a517          	auipc	a0,0xa
    80001d92:	35a50513          	addi	a0,a0,858 # 8000c0e8 <etext+0xe8>
    80001d96:	fffff097          	auipc	ra,0xfffff
    80001d9a:	ebc080e7          	jalr	-324(ra) # 80000c52 <panic>
    if((*pte & PTE_V) == 0)
    80001d9e:	fe043783          	ld	a5,-32(s0)
    80001da2:	639c                	ld	a5,0(a5)
    80001da4:	8b85                	andi	a5,a5,1
    80001da6:	eb89                	bnez	a5,80001db8 <uvmunmap+0x86>
      panic("uvmunmap: not mapped");
    80001da8:	0000a517          	auipc	a0,0xa
    80001dac:	35050513          	addi	a0,a0,848 # 8000c0f8 <etext+0xf8>
    80001db0:	fffff097          	auipc	ra,0xfffff
    80001db4:	ea2080e7          	jalr	-350(ra) # 80000c52 <panic>
    if(PTE_FLAGS(*pte) == PTE_V)
    80001db8:	fe043783          	ld	a5,-32(s0)
    80001dbc:	639c                	ld	a5,0(a5)
    80001dbe:	3ff7f713          	andi	a4,a5,1023
    80001dc2:	4785                	li	a5,1
    80001dc4:	00f71a63          	bne	a4,a5,80001dd8 <uvmunmap+0xa6>
      panic("uvmunmap: not a leaf");
    80001dc8:	0000a517          	auipc	a0,0xa
    80001dcc:	34850513          	addi	a0,a0,840 # 8000c110 <etext+0x110>
    80001dd0:	fffff097          	auipc	ra,0xfffff
    80001dd4:	e82080e7          	jalr	-382(ra) # 80000c52 <panic>
    if(do_free){
    80001dd8:	fb442783          	lw	a5,-76(s0)
    80001ddc:	2781                	sext.w	a5,a5
    80001dde:	cf99                	beqz	a5,80001dfc <uvmunmap+0xca>
      uint64 pa = PTE2PA(*pte);
    80001de0:	fe043783          	ld	a5,-32(s0)
    80001de4:	639c                	ld	a5,0(a5)
    80001de6:	83a9                	srli	a5,a5,0xa
    80001de8:	07b2                	slli	a5,a5,0xc
    80001dea:	fcf43c23          	sd	a5,-40(s0)
      kfree((void*)pa);
    80001dee:	fd843783          	ld	a5,-40(s0)
    80001df2:	853e                	mv	a0,a5
    80001df4:	fffff097          	auipc	ra,0xfffff
    80001df8:	294080e7          	jalr	660(ra) # 80001088 <kfree>
    }
    *pte = 0;
    80001dfc:	fe043783          	ld	a5,-32(s0)
    80001e00:	0007b023          	sd	zero,0(a5) # 1000 <_entry-0x7ffff000>
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    80001e04:	fe843703          	ld	a4,-24(s0)
    80001e08:	6785                	lui	a5,0x1
    80001e0a:	97ba                	add	a5,a5,a4
    80001e0c:	fef43423          	sd	a5,-24(s0)
    80001e10:	fb843783          	ld	a5,-72(s0)
    80001e14:	00c79713          	slli	a4,a5,0xc
    80001e18:	fc043783          	ld	a5,-64(s0)
    80001e1c:	97ba                	add	a5,a5,a4
    80001e1e:	fe843703          	ld	a4,-24(s0)
    80001e22:	f4f768e3          	bltu	a4,a5,80001d72 <uvmunmap+0x40>
  }
}
    80001e26:	0001                	nop
    80001e28:	0001                	nop
    80001e2a:	60a6                	ld	ra,72(sp)
    80001e2c:	6406                	ld	s0,64(sp)
    80001e2e:	6161                	addi	sp,sp,80
    80001e30:	8082                	ret

0000000080001e32 <uvmcreate>:

// create an empty user page table.
// returns 0 if out of memory.
pagetable_t
uvmcreate()
{
    80001e32:	1101                	addi	sp,sp,-32
    80001e34:	ec06                	sd	ra,24(sp)
    80001e36:	e822                	sd	s0,16(sp)
    80001e38:	1000                	addi	s0,sp,32
  pagetable_t pagetable;
  pagetable = (pagetable_t) kalloc();
    80001e3a:	fffff097          	auipc	ra,0xfffff
    80001e3e:	2f2080e7          	jalr	754(ra) # 8000112c <kalloc>
    80001e42:	fea43423          	sd	a0,-24(s0)
  if(pagetable == 0)
    80001e46:	fe843783          	ld	a5,-24(s0)
    80001e4a:	e399                	bnez	a5,80001e50 <uvmcreate+0x1e>
    return 0;
    80001e4c:	4781                	li	a5,0
    80001e4e:	a819                	j	80001e64 <uvmcreate+0x32>
  memset(pagetable, 0, PGSIZE);
    80001e50:	6605                	lui	a2,0x1
    80001e52:	4581                	li	a1,0
    80001e54:	fe843503          	ld	a0,-24(s0)
    80001e58:	fffff097          	auipc	ra,0xfffff
    80001e5c:	5fc080e7          	jalr	1532(ra) # 80001454 <memset>
  return pagetable;
    80001e60:	fe843783          	ld	a5,-24(s0)
}
    80001e64:	853e                	mv	a0,a5
    80001e66:	60e2                	ld	ra,24(sp)
    80001e68:	6442                	ld	s0,16(sp)
    80001e6a:	6105                	addi	sp,sp,32
    80001e6c:	8082                	ret

0000000080001e6e <uvminit>:
// Load the user initcode into address 0 of pagetable,
// for the very first process.
// sz must be less than a page.
void
uvminit(pagetable_t pagetable, uchar *src, uint sz)
{
    80001e6e:	7139                	addi	sp,sp,-64
    80001e70:	fc06                	sd	ra,56(sp)
    80001e72:	f822                	sd	s0,48(sp)
    80001e74:	0080                	addi	s0,sp,64
    80001e76:	fca43c23          	sd	a0,-40(s0)
    80001e7a:	fcb43823          	sd	a1,-48(s0)
    80001e7e:	87b2                	mv	a5,a2
    80001e80:	fcf42623          	sw	a5,-52(s0)
  char *mem;

  if(sz >= PGSIZE)
    80001e84:	fcc42783          	lw	a5,-52(s0)
    80001e88:	0007871b          	sext.w	a4,a5
    80001e8c:	6785                	lui	a5,0x1
    80001e8e:	00f76a63          	bltu	a4,a5,80001ea2 <uvminit+0x34>
    panic("inituvm: more than a page");
    80001e92:	0000a517          	auipc	a0,0xa
    80001e96:	29650513          	addi	a0,a0,662 # 8000c128 <etext+0x128>
    80001e9a:	fffff097          	auipc	ra,0xfffff
    80001e9e:	db8080e7          	jalr	-584(ra) # 80000c52 <panic>
  mem = kalloc();
    80001ea2:	fffff097          	auipc	ra,0xfffff
    80001ea6:	28a080e7          	jalr	650(ra) # 8000112c <kalloc>
    80001eaa:	fea43423          	sd	a0,-24(s0)
  memset(mem, 0, PGSIZE);
    80001eae:	6605                	lui	a2,0x1
    80001eb0:	4581                	li	a1,0
    80001eb2:	fe843503          	ld	a0,-24(s0)
    80001eb6:	fffff097          	auipc	ra,0xfffff
    80001eba:	59e080e7          	jalr	1438(ra) # 80001454 <memset>
  mappages(pagetable, 0, PGSIZE, (uint64)mem, PTE_W|PTE_R|PTE_X|PTE_U);
    80001ebe:	fe843783          	ld	a5,-24(s0)
    80001ec2:	4779                	li	a4,30
    80001ec4:	86be                	mv	a3,a5
    80001ec6:	6605                	lui	a2,0x1
    80001ec8:	4581                	li	a1,0
    80001eca:	fd843503          	ld	a0,-40(s0)
    80001ece:	00000097          	auipc	ra,0x0
    80001ed2:	d9c080e7          	jalr	-612(ra) # 80001c6a <mappages>
  memmove(mem, src, sz);
    80001ed6:	fcc42783          	lw	a5,-52(s0)
    80001eda:	863e                	mv	a2,a5
    80001edc:	fd043583          	ld	a1,-48(s0)
    80001ee0:	fe843503          	ld	a0,-24(s0)
    80001ee4:	fffff097          	auipc	ra,0xfffff
    80001ee8:	654080e7          	jalr	1620(ra) # 80001538 <memmove>
}
    80001eec:	0001                	nop
    80001eee:	70e2                	ld	ra,56(sp)
    80001ef0:	7442                	ld	s0,48(sp)
    80001ef2:	6121                	addi	sp,sp,64
    80001ef4:	8082                	ret

0000000080001ef6 <uvmalloc>:

// Allocate PTEs and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
uint64
uvmalloc(pagetable_t pagetable, uint64 oldsz, uint64 newsz)
{
    80001ef6:	7139                	addi	sp,sp,-64
    80001ef8:	fc06                	sd	ra,56(sp)
    80001efa:	f822                	sd	s0,48(sp)
    80001efc:	0080                	addi	s0,sp,64
    80001efe:	fca43c23          	sd	a0,-40(s0)
    80001f02:	fcb43823          	sd	a1,-48(s0)
    80001f06:	fcc43423          	sd	a2,-56(s0)
  char *mem;
  uint64 a;

  if(newsz < oldsz)
    80001f0a:	fc843703          	ld	a4,-56(s0)
    80001f0e:	fd043783          	ld	a5,-48(s0)
    80001f12:	00f77563          	bgeu	a4,a5,80001f1c <uvmalloc+0x26>
    return oldsz;
    80001f16:	fd043783          	ld	a5,-48(s0)
    80001f1a:	a85d                	j	80001fd0 <uvmalloc+0xda>

  oldsz = PGROUNDUP(oldsz);
    80001f1c:	fd043703          	ld	a4,-48(s0)
    80001f20:	6785                	lui	a5,0x1
    80001f22:	17fd                	addi	a5,a5,-1
    80001f24:	973e                	add	a4,a4,a5
    80001f26:	77fd                	lui	a5,0xfffff
    80001f28:	8ff9                	and	a5,a5,a4
    80001f2a:	fcf43823          	sd	a5,-48(s0)
  for(a = oldsz; a < newsz; a += PGSIZE){
    80001f2e:	fd043783          	ld	a5,-48(s0)
    80001f32:	fef43423          	sd	a5,-24(s0)
    80001f36:	a069                	j	80001fc0 <uvmalloc+0xca>
    mem = kalloc();
    80001f38:	fffff097          	auipc	ra,0xfffff
    80001f3c:	1f4080e7          	jalr	500(ra) # 8000112c <kalloc>
    80001f40:	fea43023          	sd	a0,-32(s0)
    if(mem == 0){
    80001f44:	fe043783          	ld	a5,-32(s0)
    80001f48:	ef89                	bnez	a5,80001f62 <uvmalloc+0x6c>
      uvmdealloc(pagetable, a, oldsz);
    80001f4a:	fd043603          	ld	a2,-48(s0)
    80001f4e:	fe843583          	ld	a1,-24(s0)
    80001f52:	fd843503          	ld	a0,-40(s0)
    80001f56:	00000097          	auipc	ra,0x0
    80001f5a:	084080e7          	jalr	132(ra) # 80001fda <uvmdealloc>
      return 0;
    80001f5e:	4781                	li	a5,0
    80001f60:	a885                	j	80001fd0 <uvmalloc+0xda>
    }
    memset(mem, 0, PGSIZE);
    80001f62:	6605                	lui	a2,0x1
    80001f64:	4581                	li	a1,0
    80001f66:	fe043503          	ld	a0,-32(s0)
    80001f6a:	fffff097          	auipc	ra,0xfffff
    80001f6e:	4ea080e7          	jalr	1258(ra) # 80001454 <memset>
    if(mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_W|PTE_X|PTE_R|PTE_U) != 0){
    80001f72:	fe043783          	ld	a5,-32(s0)
    80001f76:	4779                	li	a4,30
    80001f78:	86be                	mv	a3,a5
    80001f7a:	6605                	lui	a2,0x1
    80001f7c:	fe843583          	ld	a1,-24(s0)
    80001f80:	fd843503          	ld	a0,-40(s0)
    80001f84:	00000097          	auipc	ra,0x0
    80001f88:	ce6080e7          	jalr	-794(ra) # 80001c6a <mappages>
    80001f8c:	87aa                	mv	a5,a0
    80001f8e:	c39d                	beqz	a5,80001fb4 <uvmalloc+0xbe>
      kfree(mem);
    80001f90:	fe043503          	ld	a0,-32(s0)
    80001f94:	fffff097          	auipc	ra,0xfffff
    80001f98:	0f4080e7          	jalr	244(ra) # 80001088 <kfree>
      uvmdealloc(pagetable, a, oldsz);
    80001f9c:	fd043603          	ld	a2,-48(s0)
    80001fa0:	fe843583          	ld	a1,-24(s0)
    80001fa4:	fd843503          	ld	a0,-40(s0)
    80001fa8:	00000097          	auipc	ra,0x0
    80001fac:	032080e7          	jalr	50(ra) # 80001fda <uvmdealloc>
      return 0;
    80001fb0:	4781                	li	a5,0
    80001fb2:	a839                	j	80001fd0 <uvmalloc+0xda>
  for(a = oldsz; a < newsz; a += PGSIZE){
    80001fb4:	fe843703          	ld	a4,-24(s0)
    80001fb8:	6785                	lui	a5,0x1
    80001fba:	97ba                	add	a5,a5,a4
    80001fbc:	fef43423          	sd	a5,-24(s0)
    80001fc0:	fe843703          	ld	a4,-24(s0)
    80001fc4:	fc843783          	ld	a5,-56(s0)
    80001fc8:	f6f768e3          	bltu	a4,a5,80001f38 <uvmalloc+0x42>
    }
  }
  return newsz;
    80001fcc:	fc843783          	ld	a5,-56(s0)
}
    80001fd0:	853e                	mv	a0,a5
    80001fd2:	70e2                	ld	ra,56(sp)
    80001fd4:	7442                	ld	s0,48(sp)
    80001fd6:	6121                	addi	sp,sp,64
    80001fd8:	8082                	ret

0000000080001fda <uvmdealloc>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
uint64
uvmdealloc(pagetable_t pagetable, uint64 oldsz, uint64 newsz)
{
    80001fda:	7139                	addi	sp,sp,-64
    80001fdc:	fc06                	sd	ra,56(sp)
    80001fde:	f822                	sd	s0,48(sp)
    80001fe0:	0080                	addi	s0,sp,64
    80001fe2:	fca43c23          	sd	a0,-40(s0)
    80001fe6:	fcb43823          	sd	a1,-48(s0)
    80001fea:	fcc43423          	sd	a2,-56(s0)
  if(newsz >= oldsz)
    80001fee:	fc843703          	ld	a4,-56(s0)
    80001ff2:	fd043783          	ld	a5,-48(s0)
    80001ff6:	00f76563          	bltu	a4,a5,80002000 <uvmdealloc+0x26>
    return oldsz;
    80001ffa:	fd043783          	ld	a5,-48(s0)
    80001ffe:	a885                	j	8000206e <uvmdealloc+0x94>

  if(PGROUNDUP(newsz) < PGROUNDUP(oldsz)){
    80002000:	fc843703          	ld	a4,-56(s0)
    80002004:	6785                	lui	a5,0x1
    80002006:	17fd                	addi	a5,a5,-1
    80002008:	973e                	add	a4,a4,a5
    8000200a:	77fd                	lui	a5,0xfffff
    8000200c:	8f7d                	and	a4,a4,a5
    8000200e:	fd043683          	ld	a3,-48(s0)
    80002012:	6785                	lui	a5,0x1
    80002014:	17fd                	addi	a5,a5,-1
    80002016:	96be                	add	a3,a3,a5
    80002018:	77fd                	lui	a5,0xfffff
    8000201a:	8ff5                	and	a5,a5,a3
    8000201c:	04f77763          	bgeu	a4,a5,8000206a <uvmdealloc+0x90>
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    80002020:	fd043703          	ld	a4,-48(s0)
    80002024:	6785                	lui	a5,0x1
    80002026:	17fd                	addi	a5,a5,-1
    80002028:	973e                	add	a4,a4,a5
    8000202a:	77fd                	lui	a5,0xfffff
    8000202c:	8f7d                	and	a4,a4,a5
    8000202e:	fc843683          	ld	a3,-56(s0)
    80002032:	6785                	lui	a5,0x1
    80002034:	17fd                	addi	a5,a5,-1
    80002036:	96be                	add	a3,a3,a5
    80002038:	77fd                	lui	a5,0xfffff
    8000203a:	8ff5                	and	a5,a5,a3
    8000203c:	40f707b3          	sub	a5,a4,a5
    80002040:	83b1                	srli	a5,a5,0xc
    80002042:	fef42623          	sw	a5,-20(s0)
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
    80002046:	fc843703          	ld	a4,-56(s0)
    8000204a:	6785                	lui	a5,0x1
    8000204c:	17fd                	addi	a5,a5,-1
    8000204e:	973e                	add	a4,a4,a5
    80002050:	77fd                	lui	a5,0xfffff
    80002052:	8ff9                	and	a5,a5,a4
    80002054:	fec42703          	lw	a4,-20(s0)
    80002058:	4685                	li	a3,1
    8000205a:	863a                	mv	a2,a4
    8000205c:	85be                	mv	a1,a5
    8000205e:	fd843503          	ld	a0,-40(s0)
    80002062:	00000097          	auipc	ra,0x0
    80002066:	cd0080e7          	jalr	-816(ra) # 80001d32 <uvmunmap>
  }

  return newsz;
    8000206a:	fc843783          	ld	a5,-56(s0)
}
    8000206e:	853e                	mv	a0,a5
    80002070:	70e2                	ld	ra,56(sp)
    80002072:	7442                	ld	s0,48(sp)
    80002074:	6121                	addi	sp,sp,64
    80002076:	8082                	ret

0000000080002078 <freewalk>:

// Recursively free page-table pages.
// All leaf mappings must already have been removed.
void
freewalk(pagetable_t pagetable)
{
    80002078:	7139                	addi	sp,sp,-64
    8000207a:	fc06                	sd	ra,56(sp)
    8000207c:	f822                	sd	s0,48(sp)
    8000207e:	0080                	addi	s0,sp,64
    80002080:	fca43423          	sd	a0,-56(s0)
  // there are 2^9 = 512 PTEs in a page table.
  for(int i = 0; i < 512; i++){
    80002084:	fe042623          	sw	zero,-20(s0)
    80002088:	a88d                	j	800020fa <freewalk+0x82>
    pte_t pte = pagetable[i];
    8000208a:	fec42783          	lw	a5,-20(s0)
    8000208e:	078e                	slli	a5,a5,0x3
    80002090:	fc843703          	ld	a4,-56(s0)
    80002094:	97ba                	add	a5,a5,a4
    80002096:	639c                	ld	a5,0(a5)
    80002098:	fef43023          	sd	a5,-32(s0)
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    8000209c:	fe043783          	ld	a5,-32(s0)
    800020a0:	8b85                	andi	a5,a5,1
    800020a2:	cb9d                	beqz	a5,800020d8 <freewalk+0x60>
    800020a4:	fe043783          	ld	a5,-32(s0)
    800020a8:	8bb9                	andi	a5,a5,14
    800020aa:	e79d                	bnez	a5,800020d8 <freewalk+0x60>
      // this PTE points to a lower-level page table.
      uint64 child = PTE2PA(pte);
    800020ac:	fe043783          	ld	a5,-32(s0)
    800020b0:	83a9                	srli	a5,a5,0xa
    800020b2:	07b2                	slli	a5,a5,0xc
    800020b4:	fcf43c23          	sd	a5,-40(s0)
      freewalk((pagetable_t)child);
    800020b8:	fd843783          	ld	a5,-40(s0)
    800020bc:	853e                	mv	a0,a5
    800020be:	00000097          	auipc	ra,0x0
    800020c2:	fba080e7          	jalr	-70(ra) # 80002078 <freewalk>
      pagetable[i] = 0;
    800020c6:	fec42783          	lw	a5,-20(s0)
    800020ca:	078e                	slli	a5,a5,0x3
    800020cc:	fc843703          	ld	a4,-56(s0)
    800020d0:	97ba                	add	a5,a5,a4
    800020d2:	0007b023          	sd	zero,0(a5) # fffffffffffff000 <end+0xffffffff7ff8c000>
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    800020d6:	a829                	j	800020f0 <freewalk+0x78>
    } else if(pte & PTE_V){
    800020d8:	fe043783          	ld	a5,-32(s0)
    800020dc:	8b85                	andi	a5,a5,1
    800020de:	cb89                	beqz	a5,800020f0 <freewalk+0x78>
      panic("freewalk: leaf");
    800020e0:	0000a517          	auipc	a0,0xa
    800020e4:	06850513          	addi	a0,a0,104 # 8000c148 <etext+0x148>
    800020e8:	fffff097          	auipc	ra,0xfffff
    800020ec:	b6a080e7          	jalr	-1174(ra) # 80000c52 <panic>
  for(int i = 0; i < 512; i++){
    800020f0:	fec42783          	lw	a5,-20(s0)
    800020f4:	2785                	addiw	a5,a5,1
    800020f6:	fef42623          	sw	a5,-20(s0)
    800020fa:	fec42783          	lw	a5,-20(s0)
    800020fe:	0007871b          	sext.w	a4,a5
    80002102:	1ff00793          	li	a5,511
    80002106:	f8e7d2e3          	bge	a5,a4,8000208a <freewalk+0x12>
    }
  }
  kfree((void*)pagetable);
    8000210a:	fc843503          	ld	a0,-56(s0)
    8000210e:	fffff097          	auipc	ra,0xfffff
    80002112:	f7a080e7          	jalr	-134(ra) # 80001088 <kfree>
}
    80002116:	0001                	nop
    80002118:	70e2                	ld	ra,56(sp)
    8000211a:	7442                	ld	s0,48(sp)
    8000211c:	6121                	addi	sp,sp,64
    8000211e:	8082                	ret

0000000080002120 <uvmfree>:

// Free user memory pages,
// then free page-table pages.
void
uvmfree(pagetable_t pagetable, uint64 sz)
{
    80002120:	1101                	addi	sp,sp,-32
    80002122:	ec06                	sd	ra,24(sp)
    80002124:	e822                	sd	s0,16(sp)
    80002126:	1000                	addi	s0,sp,32
    80002128:	fea43423          	sd	a0,-24(s0)
    8000212c:	feb43023          	sd	a1,-32(s0)
  if(sz > 0)
    80002130:	fe043783          	ld	a5,-32(s0)
    80002134:	c385                	beqz	a5,80002154 <uvmfree+0x34>
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
    80002136:	fe043703          	ld	a4,-32(s0)
    8000213a:	6785                	lui	a5,0x1
    8000213c:	17fd                	addi	a5,a5,-1
    8000213e:	97ba                	add	a5,a5,a4
    80002140:	83b1                	srli	a5,a5,0xc
    80002142:	4685                	li	a3,1
    80002144:	863e                	mv	a2,a5
    80002146:	4581                	li	a1,0
    80002148:	fe843503          	ld	a0,-24(s0)
    8000214c:	00000097          	auipc	ra,0x0
    80002150:	be6080e7          	jalr	-1050(ra) # 80001d32 <uvmunmap>
  freewalk(pagetable);
    80002154:	fe843503          	ld	a0,-24(s0)
    80002158:	00000097          	auipc	ra,0x0
    8000215c:	f20080e7          	jalr	-224(ra) # 80002078 <freewalk>
}
    80002160:	0001                	nop
    80002162:	60e2                	ld	ra,24(sp)
    80002164:	6442                	ld	s0,16(sp)
    80002166:	6105                	addi	sp,sp,32
    80002168:	8082                	ret

000000008000216a <uvmcopy>:
// physical memory.
// returns 0 on success, -1 on failure.
// frees any allocated pages on failure.
int
uvmcopy(pagetable_t old, pagetable_t new, uint64 sz)
{
    8000216a:	711d                	addi	sp,sp,-96
    8000216c:	ec86                	sd	ra,88(sp)
    8000216e:	e8a2                	sd	s0,80(sp)
    80002170:	1080                	addi	s0,sp,96
    80002172:	faa43c23          	sd	a0,-72(s0)
    80002176:	fab43823          	sd	a1,-80(s0)
    8000217a:	fac43423          	sd	a2,-88(s0)
  pte_t *pte;
  uint64 pa, i;
  uint flags;
  char *mem;

  for(i = 0; i < sz; i += PGSIZE){
    8000217e:	fe043423          	sd	zero,-24(s0)
    80002182:	a0d9                	j	80002248 <uvmcopy+0xde>
    if((pte = walk(old, i, 0)) == 0)
    80002184:	4601                	li	a2,0
    80002186:	fe843583          	ld	a1,-24(s0)
    8000218a:	fb843503          	ld	a0,-72(s0)
    8000218e:	00000097          	auipc	ra,0x0
    80002192:	91a080e7          	jalr	-1766(ra) # 80001aa8 <walk>
    80002196:	fea43023          	sd	a0,-32(s0)
    8000219a:	fe043783          	ld	a5,-32(s0)
    8000219e:	eb89                	bnez	a5,800021b0 <uvmcopy+0x46>
      panic("uvmcopy: pte should exist");
    800021a0:	0000a517          	auipc	a0,0xa
    800021a4:	fb850513          	addi	a0,a0,-72 # 8000c158 <etext+0x158>
    800021a8:	fffff097          	auipc	ra,0xfffff
    800021ac:	aaa080e7          	jalr	-1366(ra) # 80000c52 <panic>
    if((*pte & PTE_V) == 0)
    800021b0:	fe043783          	ld	a5,-32(s0)
    800021b4:	639c                	ld	a5,0(a5)
    800021b6:	8b85                	andi	a5,a5,1
    800021b8:	eb89                	bnez	a5,800021ca <uvmcopy+0x60>
      panic("uvmcopy: page not present");
    800021ba:	0000a517          	auipc	a0,0xa
    800021be:	fbe50513          	addi	a0,a0,-66 # 8000c178 <etext+0x178>
    800021c2:	fffff097          	auipc	ra,0xfffff
    800021c6:	a90080e7          	jalr	-1392(ra) # 80000c52 <panic>
    pa = PTE2PA(*pte);
    800021ca:	fe043783          	ld	a5,-32(s0)
    800021ce:	639c                	ld	a5,0(a5)
    800021d0:	83a9                	srli	a5,a5,0xa
    800021d2:	07b2                	slli	a5,a5,0xc
    800021d4:	fcf43c23          	sd	a5,-40(s0)
    flags = PTE_FLAGS(*pte);
    800021d8:	fe043783          	ld	a5,-32(s0)
    800021dc:	639c                	ld	a5,0(a5)
    800021de:	2781                	sext.w	a5,a5
    800021e0:	3ff7f793          	andi	a5,a5,1023
    800021e4:	fcf42a23          	sw	a5,-44(s0)
    if((mem = kalloc()) == 0)
    800021e8:	fffff097          	auipc	ra,0xfffff
    800021ec:	f44080e7          	jalr	-188(ra) # 8000112c <kalloc>
    800021f0:	fca43423          	sd	a0,-56(s0)
    800021f4:	fc843783          	ld	a5,-56(s0)
    800021f8:	c3a5                	beqz	a5,80002258 <uvmcopy+0xee>
      goto err;
    memmove(mem, (char*)pa, PGSIZE);
    800021fa:	fd843783          	ld	a5,-40(s0)
    800021fe:	6605                	lui	a2,0x1
    80002200:	85be                	mv	a1,a5
    80002202:	fc843503          	ld	a0,-56(s0)
    80002206:	fffff097          	auipc	ra,0xfffff
    8000220a:	332080e7          	jalr	818(ra) # 80001538 <memmove>
    if(mappages(new, i, PGSIZE, (uint64)mem, flags) != 0){
    8000220e:	fc843783          	ld	a5,-56(s0)
    80002212:	fd442703          	lw	a4,-44(s0)
    80002216:	86be                	mv	a3,a5
    80002218:	6605                	lui	a2,0x1
    8000221a:	fe843583          	ld	a1,-24(s0)
    8000221e:	fb043503          	ld	a0,-80(s0)
    80002222:	00000097          	auipc	ra,0x0
    80002226:	a48080e7          	jalr	-1464(ra) # 80001c6a <mappages>
    8000222a:	87aa                	mv	a5,a0
    8000222c:	cb81                	beqz	a5,8000223c <uvmcopy+0xd2>
      kfree(mem);
    8000222e:	fc843503          	ld	a0,-56(s0)
    80002232:	fffff097          	auipc	ra,0xfffff
    80002236:	e56080e7          	jalr	-426(ra) # 80001088 <kfree>
      goto err;
    8000223a:	a005                	j	8000225a <uvmcopy+0xf0>
  for(i = 0; i < sz; i += PGSIZE){
    8000223c:	fe843703          	ld	a4,-24(s0)
    80002240:	6785                	lui	a5,0x1
    80002242:	97ba                	add	a5,a5,a4
    80002244:	fef43423          	sd	a5,-24(s0)
    80002248:	fe843703          	ld	a4,-24(s0)
    8000224c:	fa843783          	ld	a5,-88(s0)
    80002250:	f2f76ae3          	bltu	a4,a5,80002184 <uvmcopy+0x1a>
    }
  }
  return 0;
    80002254:	4781                	li	a5,0
    80002256:	a839                	j	80002274 <uvmcopy+0x10a>
      goto err;
    80002258:	0001                	nop

 err:
  uvmunmap(new, 0, i / PGSIZE, 1);
    8000225a:	fe843783          	ld	a5,-24(s0)
    8000225e:	83b1                	srli	a5,a5,0xc
    80002260:	4685                	li	a3,1
    80002262:	863e                	mv	a2,a5
    80002264:	4581                	li	a1,0
    80002266:	fb043503          	ld	a0,-80(s0)
    8000226a:	00000097          	auipc	ra,0x0
    8000226e:	ac8080e7          	jalr	-1336(ra) # 80001d32 <uvmunmap>
  return -1;
    80002272:	57fd                	li	a5,-1
}
    80002274:	853e                	mv	a0,a5
    80002276:	60e6                	ld	ra,88(sp)
    80002278:	6446                	ld	s0,80(sp)
    8000227a:	6125                	addi	sp,sp,96
    8000227c:	8082                	ret

000000008000227e <uvmclear>:

// mark a PTE invalid for user access.
// used by exec for the user stack guard page.
void
uvmclear(pagetable_t pagetable, uint64 va)
{
    8000227e:	7179                	addi	sp,sp,-48
    80002280:	f406                	sd	ra,40(sp)
    80002282:	f022                	sd	s0,32(sp)
    80002284:	1800                	addi	s0,sp,48
    80002286:	fca43c23          	sd	a0,-40(s0)
    8000228a:	fcb43823          	sd	a1,-48(s0)
  pte_t *pte;
  
  pte = walk(pagetable, va, 0);
    8000228e:	4601                	li	a2,0
    80002290:	fd043583          	ld	a1,-48(s0)
    80002294:	fd843503          	ld	a0,-40(s0)
    80002298:	00000097          	auipc	ra,0x0
    8000229c:	810080e7          	jalr	-2032(ra) # 80001aa8 <walk>
    800022a0:	fea43423          	sd	a0,-24(s0)
  if(pte == 0)
    800022a4:	fe843783          	ld	a5,-24(s0)
    800022a8:	eb89                	bnez	a5,800022ba <uvmclear+0x3c>
    panic("uvmclear");
    800022aa:	0000a517          	auipc	a0,0xa
    800022ae:	eee50513          	addi	a0,a0,-274 # 8000c198 <etext+0x198>
    800022b2:	fffff097          	auipc	ra,0xfffff
    800022b6:	9a0080e7          	jalr	-1632(ra) # 80000c52 <panic>
  *pte &= ~PTE_U;
    800022ba:	fe843783          	ld	a5,-24(s0)
    800022be:	639c                	ld	a5,0(a5)
    800022c0:	fef7f713          	andi	a4,a5,-17
    800022c4:	fe843783          	ld	a5,-24(s0)
    800022c8:	e398                	sd	a4,0(a5)
}
    800022ca:	0001                	nop
    800022cc:	70a2                	ld	ra,40(sp)
    800022ce:	7402                	ld	s0,32(sp)
    800022d0:	6145                	addi	sp,sp,48
    800022d2:	8082                	ret

00000000800022d4 <copyout>:
// Copy from kernel to user.
// Copy len bytes from src to virtual address dstva in a given page table.
// Return 0 on success, -1 on error.
int
copyout(pagetable_t pagetable, uint64 dstva, char *src, uint64 len)
{
    800022d4:	715d                	addi	sp,sp,-80
    800022d6:	e486                	sd	ra,72(sp)
    800022d8:	e0a2                	sd	s0,64(sp)
    800022da:	0880                	addi	s0,sp,80
    800022dc:	fca43423          	sd	a0,-56(s0)
    800022e0:	fcb43023          	sd	a1,-64(s0)
    800022e4:	fac43c23          	sd	a2,-72(s0)
    800022e8:	fad43823          	sd	a3,-80(s0)
  uint64 n, va0, pa0;

  while(len > 0){
    800022ec:	a055                	j	80002390 <copyout+0xbc>
    va0 = PGROUNDDOWN(dstva);
    800022ee:	fc043703          	ld	a4,-64(s0)
    800022f2:	77fd                	lui	a5,0xfffff
    800022f4:	8ff9                	and	a5,a5,a4
    800022f6:	fef43023          	sd	a5,-32(s0)
    pa0 = walkaddr(pagetable, va0);
    800022fa:	fe043583          	ld	a1,-32(s0)
    800022fe:	fc843503          	ld	a0,-56(s0)
    80002302:	00000097          	auipc	ra,0x0
    80002306:	896080e7          	jalr	-1898(ra) # 80001b98 <walkaddr>
    8000230a:	fca43c23          	sd	a0,-40(s0)
    if(pa0 == 0)
    8000230e:	fd843783          	ld	a5,-40(s0)
    80002312:	e399                	bnez	a5,80002318 <copyout+0x44>
      return -1;
    80002314:	57fd                	li	a5,-1
    80002316:	a049                	j	80002398 <copyout+0xc4>
    n = PGSIZE - (dstva - va0);
    80002318:	fe043703          	ld	a4,-32(s0)
    8000231c:	fc043783          	ld	a5,-64(s0)
    80002320:	8f1d                	sub	a4,a4,a5
    80002322:	6785                	lui	a5,0x1
    80002324:	97ba                	add	a5,a5,a4
    80002326:	fef43423          	sd	a5,-24(s0)
    if(n > len)
    8000232a:	fe843703          	ld	a4,-24(s0)
    8000232e:	fb043783          	ld	a5,-80(s0)
    80002332:	00e7f663          	bgeu	a5,a4,8000233e <copyout+0x6a>
      n = len;
    80002336:	fb043783          	ld	a5,-80(s0)
    8000233a:	fef43423          	sd	a5,-24(s0)
    memmove((void *)(pa0 + (dstva - va0)), src, n);
    8000233e:	fc043703          	ld	a4,-64(s0)
    80002342:	fe043783          	ld	a5,-32(s0)
    80002346:	8f1d                	sub	a4,a4,a5
    80002348:	fd843783          	ld	a5,-40(s0)
    8000234c:	97ba                	add	a5,a5,a4
    8000234e:	873e                	mv	a4,a5
    80002350:	fe843783          	ld	a5,-24(s0)
    80002354:	2781                	sext.w	a5,a5
    80002356:	863e                	mv	a2,a5
    80002358:	fb843583          	ld	a1,-72(s0)
    8000235c:	853a                	mv	a0,a4
    8000235e:	fffff097          	auipc	ra,0xfffff
    80002362:	1da080e7          	jalr	474(ra) # 80001538 <memmove>

    len -= n;
    80002366:	fb043703          	ld	a4,-80(s0)
    8000236a:	fe843783          	ld	a5,-24(s0)
    8000236e:	40f707b3          	sub	a5,a4,a5
    80002372:	faf43823          	sd	a5,-80(s0)
    src += n;
    80002376:	fb843703          	ld	a4,-72(s0)
    8000237a:	fe843783          	ld	a5,-24(s0)
    8000237e:	97ba                	add	a5,a5,a4
    80002380:	faf43c23          	sd	a5,-72(s0)
    dstva = va0 + PGSIZE;
    80002384:	fe043703          	ld	a4,-32(s0)
    80002388:	6785                	lui	a5,0x1
    8000238a:	97ba                	add	a5,a5,a4
    8000238c:	fcf43023          	sd	a5,-64(s0)
  while(len > 0){
    80002390:	fb043783          	ld	a5,-80(s0)
    80002394:	ffa9                	bnez	a5,800022ee <copyout+0x1a>
  }
  return 0;
    80002396:	4781                	li	a5,0
}
    80002398:	853e                	mv	a0,a5
    8000239a:	60a6                	ld	ra,72(sp)
    8000239c:	6406                	ld	s0,64(sp)
    8000239e:	6161                	addi	sp,sp,80
    800023a0:	8082                	ret

00000000800023a2 <copyin>:
// Copy from user to kernel.
// Copy len bytes to dst from virtual address srcva in a given page table.
// Return 0 on success, -1 on error.
int
copyin(pagetable_t pagetable, char *dst, uint64 srcva, uint64 len)
{
    800023a2:	715d                	addi	sp,sp,-80
    800023a4:	e486                	sd	ra,72(sp)
    800023a6:	e0a2                	sd	s0,64(sp)
    800023a8:	0880                	addi	s0,sp,80
    800023aa:	fca43423          	sd	a0,-56(s0)
    800023ae:	fcb43023          	sd	a1,-64(s0)
    800023b2:	fac43c23          	sd	a2,-72(s0)
    800023b6:	fad43823          	sd	a3,-80(s0)
  uint64 n, va0, pa0;

  while(len > 0){
    800023ba:	a055                	j	8000245e <copyin+0xbc>
    va0 = PGROUNDDOWN(srcva);
    800023bc:	fb843703          	ld	a4,-72(s0)
    800023c0:	77fd                	lui	a5,0xfffff
    800023c2:	8ff9                	and	a5,a5,a4
    800023c4:	fef43023          	sd	a5,-32(s0)
    pa0 = walkaddr(pagetable, va0);
    800023c8:	fe043583          	ld	a1,-32(s0)
    800023cc:	fc843503          	ld	a0,-56(s0)
    800023d0:	fffff097          	auipc	ra,0xfffff
    800023d4:	7c8080e7          	jalr	1992(ra) # 80001b98 <walkaddr>
    800023d8:	fca43c23          	sd	a0,-40(s0)
    if(pa0 == 0)
    800023dc:	fd843783          	ld	a5,-40(s0)
    800023e0:	e399                	bnez	a5,800023e6 <copyin+0x44>
      return -1;
    800023e2:	57fd                	li	a5,-1
    800023e4:	a049                	j	80002466 <copyin+0xc4>
    n = PGSIZE - (srcva - va0);
    800023e6:	fe043703          	ld	a4,-32(s0)
    800023ea:	fb843783          	ld	a5,-72(s0)
    800023ee:	8f1d                	sub	a4,a4,a5
    800023f0:	6785                	lui	a5,0x1
    800023f2:	97ba                	add	a5,a5,a4
    800023f4:	fef43423          	sd	a5,-24(s0)
    if(n > len)
    800023f8:	fe843703          	ld	a4,-24(s0)
    800023fc:	fb043783          	ld	a5,-80(s0)
    80002400:	00e7f663          	bgeu	a5,a4,8000240c <copyin+0x6a>
      n = len;
    80002404:	fb043783          	ld	a5,-80(s0)
    80002408:	fef43423          	sd	a5,-24(s0)
    memmove(dst, (void *)(pa0 + (srcva - va0)), n);
    8000240c:	fb843703          	ld	a4,-72(s0)
    80002410:	fe043783          	ld	a5,-32(s0)
    80002414:	8f1d                	sub	a4,a4,a5
    80002416:	fd843783          	ld	a5,-40(s0)
    8000241a:	97ba                	add	a5,a5,a4
    8000241c:	873e                	mv	a4,a5
    8000241e:	fe843783          	ld	a5,-24(s0)
    80002422:	2781                	sext.w	a5,a5
    80002424:	863e                	mv	a2,a5
    80002426:	85ba                	mv	a1,a4
    80002428:	fc043503          	ld	a0,-64(s0)
    8000242c:	fffff097          	auipc	ra,0xfffff
    80002430:	10c080e7          	jalr	268(ra) # 80001538 <memmove>

    len -= n;
    80002434:	fb043703          	ld	a4,-80(s0)
    80002438:	fe843783          	ld	a5,-24(s0)
    8000243c:	40f707b3          	sub	a5,a4,a5
    80002440:	faf43823          	sd	a5,-80(s0)
    dst += n;
    80002444:	fc043703          	ld	a4,-64(s0)
    80002448:	fe843783          	ld	a5,-24(s0)
    8000244c:	97ba                	add	a5,a5,a4
    8000244e:	fcf43023          	sd	a5,-64(s0)
    srcva = va0 + PGSIZE;
    80002452:	fe043703          	ld	a4,-32(s0)
    80002456:	6785                	lui	a5,0x1
    80002458:	97ba                	add	a5,a5,a4
    8000245a:	faf43c23          	sd	a5,-72(s0)
  while(len > 0){
    8000245e:	fb043783          	ld	a5,-80(s0)
    80002462:	ffa9                	bnez	a5,800023bc <copyin+0x1a>
  }
  return 0;
    80002464:	4781                	li	a5,0
}
    80002466:	853e                	mv	a0,a5
    80002468:	60a6                	ld	ra,72(sp)
    8000246a:	6406                	ld	s0,64(sp)
    8000246c:	6161                	addi	sp,sp,80
    8000246e:	8082                	ret

0000000080002470 <copyinstr>:
// Copy bytes to dst from virtual address srcva in a given page table,
// until a '\0', or max.
// Return 0 on success, -1 on error.
int
copyinstr(pagetable_t pagetable, char *dst, uint64 srcva, uint64 max)
{
    80002470:	711d                	addi	sp,sp,-96
    80002472:	ec86                	sd	ra,88(sp)
    80002474:	e8a2                	sd	s0,80(sp)
    80002476:	1080                	addi	s0,sp,96
    80002478:	faa43c23          	sd	a0,-72(s0)
    8000247c:	fab43823          	sd	a1,-80(s0)
    80002480:	fac43423          	sd	a2,-88(s0)
    80002484:	fad43023          	sd	a3,-96(s0)
  uint64 n, va0, pa0;
  int got_null = 0;
    80002488:	fe042223          	sw	zero,-28(s0)

  while(got_null == 0 && max > 0){
    8000248c:	a0f1                	j	80002558 <copyinstr+0xe8>
    va0 = PGROUNDDOWN(srcva);
    8000248e:	fa843703          	ld	a4,-88(s0)
    80002492:	77fd                	lui	a5,0xfffff
    80002494:	8ff9                	and	a5,a5,a4
    80002496:	fcf43823          	sd	a5,-48(s0)
    pa0 = walkaddr(pagetable, va0);
    8000249a:	fd043583          	ld	a1,-48(s0)
    8000249e:	fb843503          	ld	a0,-72(s0)
    800024a2:	fffff097          	auipc	ra,0xfffff
    800024a6:	6f6080e7          	jalr	1782(ra) # 80001b98 <walkaddr>
    800024aa:	fca43423          	sd	a0,-56(s0)
    if(pa0 == 0)
    800024ae:	fc843783          	ld	a5,-56(s0)
    800024b2:	e399                	bnez	a5,800024b8 <copyinstr+0x48>
      return -1;
    800024b4:	57fd                	li	a5,-1
    800024b6:	a87d                	j	80002574 <copyinstr+0x104>
    n = PGSIZE - (srcva - va0);
    800024b8:	fd043703          	ld	a4,-48(s0)
    800024bc:	fa843783          	ld	a5,-88(s0)
    800024c0:	8f1d                	sub	a4,a4,a5
    800024c2:	6785                	lui	a5,0x1
    800024c4:	97ba                	add	a5,a5,a4
    800024c6:	fef43423          	sd	a5,-24(s0)
    if(n > max)
    800024ca:	fe843703          	ld	a4,-24(s0)
    800024ce:	fa043783          	ld	a5,-96(s0)
    800024d2:	00e7f663          	bgeu	a5,a4,800024de <copyinstr+0x6e>
      n = max;
    800024d6:	fa043783          	ld	a5,-96(s0)
    800024da:	fef43423          	sd	a5,-24(s0)

    char *p = (char *) (pa0 + (srcva - va0));
    800024de:	fa843703          	ld	a4,-88(s0)
    800024e2:	fd043783          	ld	a5,-48(s0)
    800024e6:	8f1d                	sub	a4,a4,a5
    800024e8:	fc843783          	ld	a5,-56(s0)
    800024ec:	97ba                	add	a5,a5,a4
    800024ee:	fcf43c23          	sd	a5,-40(s0)
    while(n > 0){
    800024f2:	a891                	j	80002546 <copyinstr+0xd6>
      if(*p == '\0'){
    800024f4:	fd843783          	ld	a5,-40(s0)
    800024f8:	0007c783          	lbu	a5,0(a5) # 1000 <_entry-0x7ffff000>
    800024fc:	eb89                	bnez	a5,8000250e <copyinstr+0x9e>
        *dst = '\0';
    800024fe:	fb043783          	ld	a5,-80(s0)
    80002502:	00078023          	sb	zero,0(a5)
        got_null = 1;
    80002506:	4785                	li	a5,1
    80002508:	fef42223          	sw	a5,-28(s0)
        break;
    8000250c:	a081                	j	8000254c <copyinstr+0xdc>
      } else {
        *dst = *p;
    8000250e:	fd843783          	ld	a5,-40(s0)
    80002512:	0007c703          	lbu	a4,0(a5)
    80002516:	fb043783          	ld	a5,-80(s0)
    8000251a:	00e78023          	sb	a4,0(a5)
      }
      --n;
    8000251e:	fe843783          	ld	a5,-24(s0)
    80002522:	17fd                	addi	a5,a5,-1
    80002524:	fef43423          	sd	a5,-24(s0)
      --max;
    80002528:	fa043783          	ld	a5,-96(s0)
    8000252c:	17fd                	addi	a5,a5,-1
    8000252e:	faf43023          	sd	a5,-96(s0)
      p++;
    80002532:	fd843783          	ld	a5,-40(s0)
    80002536:	0785                	addi	a5,a5,1
    80002538:	fcf43c23          	sd	a5,-40(s0)
      dst++;
    8000253c:	fb043783          	ld	a5,-80(s0)
    80002540:	0785                	addi	a5,a5,1
    80002542:	faf43823          	sd	a5,-80(s0)
    while(n > 0){
    80002546:	fe843783          	ld	a5,-24(s0)
    8000254a:	f7cd                	bnez	a5,800024f4 <copyinstr+0x84>
    }

    srcva = va0 + PGSIZE;
    8000254c:	fd043703          	ld	a4,-48(s0)
    80002550:	6785                	lui	a5,0x1
    80002552:	97ba                	add	a5,a5,a4
    80002554:	faf43423          	sd	a5,-88(s0)
  while(got_null == 0 && max > 0){
    80002558:	fe442783          	lw	a5,-28(s0)
    8000255c:	2781                	sext.w	a5,a5
    8000255e:	e781                	bnez	a5,80002566 <copyinstr+0xf6>
    80002560:	fa043783          	ld	a5,-96(s0)
    80002564:	f78d                	bnez	a5,8000248e <copyinstr+0x1e>
  }
  if(got_null){
    80002566:	fe442783          	lw	a5,-28(s0)
    8000256a:	2781                	sext.w	a5,a5
    8000256c:	c399                	beqz	a5,80002572 <copyinstr+0x102>
    return 0;
    8000256e:	4781                	li	a5,0
    80002570:	a011                	j	80002574 <copyinstr+0x104>
  } else {
    return -1;
    80002572:	57fd                	li	a5,-1
  }
}
    80002574:	853e                	mv	a0,a5
    80002576:	60e6                	ld	ra,88(sp)
    80002578:	6446                	ld	s0,80(sp)
    8000257a:	6125                	addi	sp,sp,96
    8000257c:	8082                	ret

000000008000257e <r_sstatus>:
{
    8000257e:	1101                	addi	sp,sp,-32
    80002580:	ec22                	sd	s0,24(sp)
    80002582:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80002584:	100027f3          	csrr	a5,sstatus
    80002588:	fef43423          	sd	a5,-24(s0)
  return x;
    8000258c:	fe843783          	ld	a5,-24(s0)
}
    80002590:	853e                	mv	a0,a5
    80002592:	6462                	ld	s0,24(sp)
    80002594:	6105                	addi	sp,sp,32
    80002596:	8082                	ret

0000000080002598 <w_sstatus>:
{
    80002598:	1101                	addi	sp,sp,-32
    8000259a:	ec22                	sd	s0,24(sp)
    8000259c:	1000                	addi	s0,sp,32
    8000259e:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800025a2:	fe843783          	ld	a5,-24(s0)
    800025a6:	10079073          	csrw	sstatus,a5
}
    800025aa:	0001                	nop
    800025ac:	6462                	ld	s0,24(sp)
    800025ae:	6105                	addi	sp,sp,32
    800025b0:	8082                	ret

00000000800025b2 <intr_on>:
{
    800025b2:	1141                	addi	sp,sp,-16
    800025b4:	e406                	sd	ra,8(sp)
    800025b6:	e022                	sd	s0,0(sp)
    800025b8:	0800                	addi	s0,sp,16
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    800025ba:	00000097          	auipc	ra,0x0
    800025be:	fc4080e7          	jalr	-60(ra) # 8000257e <r_sstatus>
    800025c2:	87aa                	mv	a5,a0
    800025c4:	0027e793          	ori	a5,a5,2
    800025c8:	853e                	mv	a0,a5
    800025ca:	00000097          	auipc	ra,0x0
    800025ce:	fce080e7          	jalr	-50(ra) # 80002598 <w_sstatus>
}
    800025d2:	0001                	nop
    800025d4:	60a2                	ld	ra,8(sp)
    800025d6:	6402                	ld	s0,0(sp)
    800025d8:	0141                	addi	sp,sp,16
    800025da:	8082                	ret

00000000800025dc <intr_get>:
{
    800025dc:	1101                	addi	sp,sp,-32
    800025de:	ec06                	sd	ra,24(sp)
    800025e0:	e822                	sd	s0,16(sp)
    800025e2:	1000                	addi	s0,sp,32
  uint64 x = r_sstatus();
    800025e4:	00000097          	auipc	ra,0x0
    800025e8:	f9a080e7          	jalr	-102(ra) # 8000257e <r_sstatus>
    800025ec:	fea43423          	sd	a0,-24(s0)
  return (x & SSTATUS_SIE) != 0;
    800025f0:	fe843783          	ld	a5,-24(s0)
    800025f4:	8b89                	andi	a5,a5,2
    800025f6:	00f037b3          	snez	a5,a5
    800025fa:	0ff7f793          	andi	a5,a5,255
    800025fe:	2781                	sext.w	a5,a5
}
    80002600:	853e                	mv	a0,a5
    80002602:	60e2                	ld	ra,24(sp)
    80002604:	6442                	ld	s0,16(sp)
    80002606:	6105                	addi	sp,sp,32
    80002608:	8082                	ret

000000008000260a <r_tp>:
{
    8000260a:	1101                	addi	sp,sp,-32
    8000260c:	ec22                	sd	s0,24(sp)
    8000260e:	1000                	addi	s0,sp,32
  asm volatile("mv %0, tp" : "=r" (x) );
    80002610:	8792                	mv	a5,tp
    80002612:	fef43423          	sd	a5,-24(s0)
  return x;
    80002616:	fe843783          	ld	a5,-24(s0)
}
    8000261a:	853e                	mv	a0,a5
    8000261c:	6462                	ld	s0,24(sp)
    8000261e:	6105                	addi	sp,sp,32
    80002620:	8082                	ret

0000000080002622 <proc_mapstacks>:

// Allocate a page for each process's kernel stack.
// Map it high in memory, followed by an invalid
// guard page.
void
proc_mapstacks(pagetable_t kpgtbl) {
    80002622:	7139                	addi	sp,sp,-64
    80002624:	fc06                	sd	ra,56(sp)
    80002626:	f822                	sd	s0,48(sp)
    80002628:	0080                	addi	s0,sp,64
    8000262a:	fca43423          	sd	a0,-56(s0)
  struct proc *p;
  
  for(p = proc; p < &proc[NPROC]; p++) {
    8000262e:	00013797          	auipc	a5,0x13
    80002632:	06a78793          	addi	a5,a5,106 # 80015698 <proc>
    80002636:	fef43423          	sd	a5,-24(s0)
    8000263a:	a071                	j	800026c6 <proc_mapstacks+0xa4>
    char *pa = kalloc();
    8000263c:	fffff097          	auipc	ra,0xfffff
    80002640:	af0080e7          	jalr	-1296(ra) # 8000112c <kalloc>
    80002644:	fea43023          	sd	a0,-32(s0)
    if(pa == 0)
    80002648:	fe043783          	ld	a5,-32(s0)
    8000264c:	eb89                	bnez	a5,8000265e <proc_mapstacks+0x3c>
      panic("kalloc");
    8000264e:	0000a517          	auipc	a0,0xa
    80002652:	b5a50513          	addi	a0,a0,-1190 # 8000c1a8 <etext+0x1a8>
    80002656:	ffffe097          	auipc	ra,0xffffe
    8000265a:	5fc080e7          	jalr	1532(ra) # 80000c52 <panic>
    uint64 va = KSTACK((int) (p - proc));
    8000265e:	fe843703          	ld	a4,-24(s0)
    80002662:	00013797          	auipc	a5,0x13
    80002666:	03678793          	addi	a5,a5,54 # 80015698 <proc>
    8000266a:	40f707b3          	sub	a5,a4,a5
    8000266e:	4037d713          	srai	a4,a5,0x3
    80002672:	0000a797          	auipc	a5,0xa
    80002676:	c1e78793          	addi	a5,a5,-994 # 8000c290 <etext+0x290>
    8000267a:	639c                	ld	a5,0(a5)
    8000267c:	02f707b3          	mul	a5,a4,a5
    80002680:	2781                	sext.w	a5,a5
    80002682:	2785                	addiw	a5,a5,1
    80002684:	2781                	sext.w	a5,a5
    80002686:	00d7979b          	slliw	a5,a5,0xd
    8000268a:	2781                	sext.w	a5,a5
    8000268c:	873e                	mv	a4,a5
    8000268e:	040007b7          	lui	a5,0x4000
    80002692:	17fd                	addi	a5,a5,-1
    80002694:	07b2                	slli	a5,a5,0xc
    80002696:	8f99                	sub	a5,a5,a4
    80002698:	fcf43c23          	sd	a5,-40(s0)
    kvmmap(kpgtbl, va, (uint64)pa, PGSIZE, PTE_R | PTE_W);
    8000269c:	fe043783          	ld	a5,-32(s0)
    800026a0:	4719                	li	a4,6
    800026a2:	6685                	lui	a3,0x1
    800026a4:	863e                	mv	a2,a5
    800026a6:	fd843583          	ld	a1,-40(s0)
    800026aa:	fc843503          	ld	a0,-56(s0)
    800026ae:	fffff097          	auipc	ra,0xfffff
    800026b2:	562080e7          	jalr	1378(ra) # 80001c10 <kvmmap>
  for(p = proc; p < &proc[NPROC]; p++) {
    800026b6:	fe843703          	ld	a4,-24(s0)
    800026ba:	6785                	lui	a5,0x1
    800026bc:	3c878793          	addi	a5,a5,968 # 13c8 <_entry-0x7fffec38>
    800026c0:	97ba                	add	a5,a5,a4
    800026c2:	fef43423          	sd	a5,-24(s0)
    800026c6:	fe843703          	ld	a4,-24(s0)
    800026ca:	00062797          	auipc	a5,0x62
    800026ce:	1ce78793          	addi	a5,a5,462 # 80064898 <pid_lock>
    800026d2:	f6f765e3          	bltu	a4,a5,8000263c <proc_mapstacks+0x1a>
  }
}
    800026d6:	0001                	nop
    800026d8:	0001                	nop
    800026da:	70e2                	ld	ra,56(sp)
    800026dc:	7442                	ld	s0,48(sp)
    800026de:	6121                	addi	sp,sp,64
    800026e0:	8082                	ret

00000000800026e2 <procinit>:

// initialize the proc table at boot time.
void
procinit(void)
{
    800026e2:	1101                	addi	sp,sp,-32
    800026e4:	ec06                	sd	ra,24(sp)
    800026e6:	e822                	sd	s0,16(sp)
    800026e8:	1000                	addi	s0,sp,32
  struct proc *p;
  
  initlock(&pid_lock, "nextpid");
    800026ea:	0000a597          	auipc	a1,0xa
    800026ee:	ac658593          	addi	a1,a1,-1338 # 8000c1b0 <etext+0x1b0>
    800026f2:	00062517          	auipc	a0,0x62
    800026f6:	1a650513          	addi	a0,a0,422 # 80064898 <pid_lock>
    800026fa:	fffff097          	auipc	ra,0xfffff
    800026fe:	b56080e7          	jalr	-1194(ra) # 80001250 <initlock>
  for(p = proc; p < &proc[NPROC]; p++) {
    80002702:	00013797          	auipc	a5,0x13
    80002706:	f9678793          	addi	a5,a5,-106 # 80015698 <proc>
    8000270a:	fef43423          	sd	a5,-24(s0)
    8000270e:	a885                	j	8000277e <procinit+0x9c>
      initlock(&p->lock, "proc");
    80002710:	fe843783          	ld	a5,-24(s0)
    80002714:	0000a597          	auipc	a1,0xa
    80002718:	aa458593          	addi	a1,a1,-1372 # 8000c1b8 <etext+0x1b8>
    8000271c:	853e                	mv	a0,a5
    8000271e:	fffff097          	auipc	ra,0xfffff
    80002722:	b32080e7          	jalr	-1230(ra) # 80001250 <initlock>
      p->kstack = KSTACK((int) (p - proc));
    80002726:	fe843703          	ld	a4,-24(s0)
    8000272a:	00013797          	auipc	a5,0x13
    8000272e:	f6e78793          	addi	a5,a5,-146 # 80015698 <proc>
    80002732:	40f707b3          	sub	a5,a4,a5
    80002736:	4037d713          	srai	a4,a5,0x3
    8000273a:	0000a797          	auipc	a5,0xa
    8000273e:	b5678793          	addi	a5,a5,-1194 # 8000c290 <etext+0x290>
    80002742:	639c                	ld	a5,0(a5)
    80002744:	02f707b3          	mul	a5,a4,a5
    80002748:	2781                	sext.w	a5,a5
    8000274a:	2785                	addiw	a5,a5,1
    8000274c:	2781                	sext.w	a5,a5
    8000274e:	00d7979b          	slliw	a5,a5,0xd
    80002752:	2781                	sext.w	a5,a5
    80002754:	873e                	mv	a4,a5
    80002756:	040007b7          	lui	a5,0x4000
    8000275a:	17fd                	addi	a5,a5,-1
    8000275c:	07b2                	slli	a5,a5,0xc
    8000275e:	8f99                	sub	a5,a5,a4
    80002760:	86be                	mv	a3,a5
    80002762:	fe843703          	ld	a4,-24(s0)
    80002766:	6785                	lui	a5,0x1
    80002768:	97ba                	add	a5,a5,a4
    8000276a:	2ad7b023          	sd	a3,672(a5) # 12a0 <_entry-0x7fffed60>
  for(p = proc; p < &proc[NPROC]; p++) {
    8000276e:	fe843703          	ld	a4,-24(s0)
    80002772:	6785                	lui	a5,0x1
    80002774:	3c878793          	addi	a5,a5,968 # 13c8 <_entry-0x7fffec38>
    80002778:	97ba                	add	a5,a5,a4
    8000277a:	fef43423          	sd	a5,-24(s0)
    8000277e:	fe843703          	ld	a4,-24(s0)
    80002782:	00062797          	auipc	a5,0x62
    80002786:	11678793          	addi	a5,a5,278 # 80064898 <pid_lock>
    8000278a:	f8f763e3          	bltu	a4,a5,80002710 <procinit+0x2e>
  }
}
    8000278e:	0001                	nop
    80002790:	0001                	nop
    80002792:	60e2                	ld	ra,24(sp)
    80002794:	6442                	ld	s0,16(sp)
    80002796:	6105                	addi	sp,sp,32
    80002798:	8082                	ret

000000008000279a <cpuid>:
// Must be called with interrupts disabled,
// to prevent race with process being moved
// to a different CPU.
int
cpuid()
{
    8000279a:	1101                	addi	sp,sp,-32
    8000279c:	ec06                	sd	ra,24(sp)
    8000279e:	e822                	sd	s0,16(sp)
    800027a0:	1000                	addi	s0,sp,32
  int id = r_tp();
    800027a2:	00000097          	auipc	ra,0x0
    800027a6:	e68080e7          	jalr	-408(ra) # 8000260a <r_tp>
    800027aa:	87aa                	mv	a5,a0
    800027ac:	fef42623          	sw	a5,-20(s0)
  return id;
    800027b0:	fec42783          	lw	a5,-20(s0)
}
    800027b4:	853e                	mv	a0,a5
    800027b6:	60e2                	ld	ra,24(sp)
    800027b8:	6442                	ld	s0,16(sp)
    800027ba:	6105                	addi	sp,sp,32
    800027bc:	8082                	ret

00000000800027be <mycpu>:

// Return this CPU's cpu struct.
// Interrupts must be disabled.
struct cpu*
mycpu(void) {
    800027be:	1101                	addi	sp,sp,-32
    800027c0:	ec06                	sd	ra,24(sp)
    800027c2:	e822                	sd	s0,16(sp)
    800027c4:	1000                	addi	s0,sp,32
  int id = cpuid();
    800027c6:	00000097          	auipc	ra,0x0
    800027ca:	fd4080e7          	jalr	-44(ra) # 8000279a <cpuid>
    800027ce:	87aa                	mv	a5,a0
    800027d0:	fef42623          	sw	a5,-20(s0)
  struct cpu *c = &cpus[id];
    800027d4:	fec42783          	lw	a5,-20(s0)
    800027d8:	00779713          	slli	a4,a5,0x7
    800027dc:	00013797          	auipc	a5,0x13
    800027e0:	abc78793          	addi	a5,a5,-1348 # 80015298 <cpus>
    800027e4:	97ba                	add	a5,a5,a4
    800027e6:	fef43023          	sd	a5,-32(s0)
  return c;
    800027ea:	fe043783          	ld	a5,-32(s0)
}
    800027ee:	853e                	mv	a0,a5
    800027f0:	60e2                	ld	ra,24(sp)
    800027f2:	6442                	ld	s0,16(sp)
    800027f4:	6105                	addi	sp,sp,32
    800027f6:	8082                	ret

00000000800027f8 <myproc>:

// Return the current struct proc *, or zero if none.
struct proc*
myproc(void) {
    800027f8:	1101                	addi	sp,sp,-32
    800027fa:	ec06                	sd	ra,24(sp)
    800027fc:	e822                	sd	s0,16(sp)
    800027fe:	1000                	addi	s0,sp,32
  push_off();
    80002800:	fffff097          	auipc	ra,0xfffff
    80002804:	b7e080e7          	jalr	-1154(ra) # 8000137e <push_off>
  struct cpu *c = mycpu();
    80002808:	00000097          	auipc	ra,0x0
    8000280c:	fb6080e7          	jalr	-74(ra) # 800027be <mycpu>
    80002810:	fea43423          	sd	a0,-24(s0)
  struct proc *p = c->proc;
    80002814:	fe843783          	ld	a5,-24(s0)
    80002818:	639c                	ld	a5,0(a5)
    8000281a:	fef43023          	sd	a5,-32(s0)
  pop_off();
    8000281e:	fffff097          	auipc	ra,0xfffff
    80002822:	bb8080e7          	jalr	-1096(ra) # 800013d6 <pop_off>
  return p;
    80002826:	fe043783          	ld	a5,-32(s0)
}
    8000282a:	853e                	mv	a0,a5
    8000282c:	60e2                	ld	ra,24(sp)
    8000282e:	6442                	ld	s0,16(sp)
    80002830:	6105                	addi	sp,sp,32
    80002832:	8082                	ret

0000000080002834 <allocpid>:

int
allocpid() {
    80002834:	1101                	addi	sp,sp,-32
    80002836:	ec06                	sd	ra,24(sp)
    80002838:	e822                	sd	s0,16(sp)
    8000283a:	1000                	addi	s0,sp,32
  int pid;
  
  acquire(&pid_lock);
    8000283c:	00062517          	auipc	a0,0x62
    80002840:	05c50513          	addi	a0,a0,92 # 80064898 <pid_lock>
    80002844:	fffff097          	auipc	ra,0xfffff
    80002848:	a3c080e7          	jalr	-1476(ra) # 80001280 <acquire>
  pid = nextpid;
    8000284c:	0000a797          	auipc	a5,0xa
    80002850:	f0478793          	addi	a5,a5,-252 # 8000c750 <nextpid>
    80002854:	439c                	lw	a5,0(a5)
    80002856:	fef42623          	sw	a5,-20(s0)
  nextpid = nextpid + 1;
    8000285a:	0000a797          	auipc	a5,0xa
    8000285e:	ef678793          	addi	a5,a5,-266 # 8000c750 <nextpid>
    80002862:	439c                	lw	a5,0(a5)
    80002864:	2785                	addiw	a5,a5,1
    80002866:	0007871b          	sext.w	a4,a5
    8000286a:	0000a797          	auipc	a5,0xa
    8000286e:	ee678793          	addi	a5,a5,-282 # 8000c750 <nextpid>
    80002872:	c398                	sw	a4,0(a5)
  release(&pid_lock);
    80002874:	00062517          	auipc	a0,0x62
    80002878:	02450513          	addi	a0,a0,36 # 80064898 <pid_lock>
    8000287c:	fffff097          	auipc	ra,0xfffff
    80002880:	a68080e7          	jalr	-1432(ra) # 800012e4 <release>

  return pid;
    80002884:	fec42783          	lw	a5,-20(s0)
}
    80002888:	853e                	mv	a0,a5
    8000288a:	60e2                	ld	ra,24(sp)
    8000288c:	6442                	ld	s0,16(sp)
    8000288e:	6105                	addi	sp,sp,32
    80002890:	8082                	ret

0000000080002892 <allocproc>:
// If found, initialize state required to run in the kernel,
// and return with p->lock held.
// If there are no free procs, or a memory allocation fails, return 0.
static struct proc*
allocproc(void)
{
    80002892:	1101                	addi	sp,sp,-32
    80002894:	ec06                	sd	ra,24(sp)
    80002896:	e822                	sd	s0,16(sp)
    80002898:	1000                	addi	s0,sp,32
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++) {
    8000289a:	00013797          	auipc	a5,0x13
    8000289e:	dfe78793          	addi	a5,a5,-514 # 80015698 <proc>
    800028a2:	fef43423          	sd	a5,-24(s0)
    800028a6:	a81d                	j	800028dc <allocproc+0x4a>
    acquire(&p->lock);
    800028a8:	fe843783          	ld	a5,-24(s0)
    800028ac:	853e                	mv	a0,a5
    800028ae:	fffff097          	auipc	ra,0xfffff
    800028b2:	9d2080e7          	jalr	-1582(ra) # 80001280 <acquire>
    if(p->state == UNUSED) {
    800028b6:	fe843783          	ld	a5,-24(s0)
    800028ba:	4f9c                	lw	a5,24(a5)
    800028bc:	cb95                	beqz	a5,800028f0 <allocproc+0x5e>
      goto found;
    } else {
      release(&p->lock);
    800028be:	fe843783          	ld	a5,-24(s0)
    800028c2:	853e                	mv	a0,a5
    800028c4:	fffff097          	auipc	ra,0xfffff
    800028c8:	a20080e7          	jalr	-1504(ra) # 800012e4 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    800028cc:	fe843703          	ld	a4,-24(s0)
    800028d0:	6785                	lui	a5,0x1
    800028d2:	3c878793          	addi	a5,a5,968 # 13c8 <_entry-0x7fffec38>
    800028d6:	97ba                	add	a5,a5,a4
    800028d8:	fef43423          	sd	a5,-24(s0)
    800028dc:	fe843703          	ld	a4,-24(s0)
    800028e0:	00062797          	auipc	a5,0x62
    800028e4:	fb878793          	addi	a5,a5,-72 # 80064898 <pid_lock>
    800028e8:	fcf760e3          	bltu	a4,a5,800028a8 <allocproc+0x16>
    }
  }
  return 0;
    800028ec:	4781                	li	a5,0
    800028ee:	aa35                	j	80002a2a <allocproc+0x198>
      goto found;
    800028f0:	0001                	nop

found:
  p->pid = allocpid();
    800028f2:	00000097          	auipc	ra,0x0
    800028f6:	f42080e7          	jalr	-190(ra) # 80002834 <allocpid>
    800028fa:	87aa                	mv	a5,a0
    800028fc:	873e                	mv	a4,a5
    800028fe:	fe843783          	ld	a5,-24(s0)
    80002902:	df98                	sw	a4,56(a5)

  //TODO: mp3

  // Allocate a trapframe page.
  if((p->trapframe = (struct trapframe *)kalloc()) == 0){
    80002904:	fffff097          	auipc	ra,0xfffff
    80002908:	828080e7          	jalr	-2008(ra) # 8000112c <kalloc>
    8000290c:	86aa                	mv	a3,a0
    8000290e:	fe843703          	ld	a4,-24(s0)
    80002912:	6785                	lui	a5,0x1
    80002914:	97ba                	add	a5,a5,a4
    80002916:	2ad7bc23          	sd	a3,696(a5) # 12b8 <_entry-0x7fffed48>
    8000291a:	fe843703          	ld	a4,-24(s0)
    8000291e:	6785                	lui	a5,0x1
    80002920:	97ba                	add	a5,a5,a4
    80002922:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80002926:	eb91                	bnez	a5,8000293a <allocproc+0xa8>
    release(&p->lock);
    80002928:	fe843783          	ld	a5,-24(s0)
    8000292c:	853e                	mv	a0,a5
    8000292e:	fffff097          	auipc	ra,0xfffff
    80002932:	9b6080e7          	jalr	-1610(ra) # 800012e4 <release>
    return 0;
    80002936:	4781                	li	a5,0
    80002938:	a8cd                	j	80002a2a <allocproc+0x198>
  }

  // An empty user page table.
  p->pagetable = proc_pagetable(p);
    8000293a:	fe843503          	ld	a0,-24(s0)
    8000293e:	00000097          	auipc	ra,0x0
    80002942:	1c2080e7          	jalr	450(ra) # 80002b00 <proc_pagetable>
    80002946:	86aa                	mv	a3,a0
    80002948:	fe843703          	ld	a4,-24(s0)
    8000294c:	6785                	lui	a5,0x1
    8000294e:	97ba                	add	a5,a5,a4
    80002950:	2ad7b823          	sd	a3,688(a5) # 12b0 <_entry-0x7fffed50>
  if(p->pagetable == 0){
    80002954:	fe843703          	ld	a4,-24(s0)
    80002958:	6785                	lui	a5,0x1
    8000295a:	97ba                	add	a5,a5,a4
    8000295c:	2b07b783          	ld	a5,688(a5) # 12b0 <_entry-0x7fffed50>
    80002960:	e385                	bnez	a5,80002980 <allocproc+0xee>
    freeproc(p);
    80002962:	fe843503          	ld	a0,-24(s0)
    80002966:	00000097          	auipc	ra,0x0
    8000296a:	0ce080e7          	jalr	206(ra) # 80002a34 <freeproc>
    release(&p->lock);
    8000296e:	fe843783          	ld	a5,-24(s0)
    80002972:	853e                	mv	a0,a5
    80002974:	fffff097          	auipc	ra,0xfffff
    80002978:	970080e7          	jalr	-1680(ra) # 800012e4 <release>
    return 0;
    8000297c:	4781                	li	a5,0
    8000297e:	a075                	j	80002a2a <allocproc+0x198>
  }

  // Set up new context to start executing at forkret,
  // which returns to user space.
  memset(&p->context, 0, sizeof(p->context));
    80002980:	fe843703          	ld	a4,-24(s0)
    80002984:	6785                	lui	a5,0x1
    80002986:	2c078793          	addi	a5,a5,704 # 12c0 <_entry-0x7fffed40>
    8000298a:	97ba                	add	a5,a5,a4
    8000298c:	07000613          	li	a2,112
    80002990:	4581                	li	a1,0
    80002992:	853e                	mv	a0,a5
    80002994:	fffff097          	auipc	ra,0xfffff
    80002998:	ac0080e7          	jalr	-1344(ra) # 80001454 <memset>
  p->context.ra = (uint64)forkret;
    8000299c:	00001717          	auipc	a4,0x1
    800029a0:	b4870713          	addi	a4,a4,-1208 # 800034e4 <forkret>
    800029a4:	fe843683          	ld	a3,-24(s0)
    800029a8:	6785                	lui	a5,0x1
    800029aa:	97b6                	add	a5,a5,a3
    800029ac:	2ce7b023          	sd	a4,704(a5) # 12c0 <_entry-0x7fffed40>
  p->context.sp = p->kstack + PGSIZE;
    800029b0:	fe843703          	ld	a4,-24(s0)
    800029b4:	6785                	lui	a5,0x1
    800029b6:	97ba                	add	a5,a5,a4
    800029b8:	2a07b703          	ld	a4,672(a5) # 12a0 <_entry-0x7fffed60>
    800029bc:	6785                	lui	a5,0x1
    800029be:	973e                	add	a4,a4,a5
    800029c0:	fe843683          	ld	a3,-24(s0)
    800029c4:	6785                	lui	a5,0x1
    800029c6:	97b6                	add	a5,a5,a3
    800029c8:	2ce7b423          	sd	a4,712(a5) # 12c8 <_entry-0x7fffed38>
  
  // MP3
  
  p->timer_elapsed = 0; 
    800029cc:	fe843783          	ld	a5,-24(s0)
    800029d0:	0207ae23          	sw	zero,60(a5)
  /*
    when timer_elapsed is equal to delay,
    which is nonnegative, the interrupt handler is called.
  */
  p->delay = -1; // not set
    800029d4:	fe843783          	ld	a5,-24(s0)
    800029d8:	577d                	li	a4,-1
    800029da:	c3b8                	sw	a4,64(a5)
  p->thrd_context_id = 0; // set when allocated
    800029dc:	fe843783          	ld	a5,-24(s0)
    800029e0:	0407ac23          	sw	zero,88(a5)
  p->handler = 0;
    800029e4:	fe843783          	ld	a5,-24(s0)
    800029e8:	0407b423          	sd	zero,72(a5)
  p->handler_arg = 0; // null pointer
    800029ec:	fe843783          	ld	a5,-24(s0)
    800029f0:	0407b823          	sd	zero,80(a5)
  for(int i=0; i<MAX_THRD_NUM; i++){
    800029f4:	fe042223          	sw	zero,-28(s0)
    800029f8:	a005                	j	80002a18 <allocproc+0x186>
    p->thrd_context_used[i] = 0; // unused
    800029fa:	fe843703          	ld	a4,-24(s0)
    800029fe:	fe442783          	lw	a5,-28(s0)
    80002a02:	49878793          	addi	a5,a5,1176
    80002a06:	078a                	slli	a5,a5,0x2
    80002a08:	97ba                	add	a5,a5,a4
    80002a0a:	0007a023          	sw	zero,0(a5)
  for(int i=0; i<MAX_THRD_NUM; i++){
    80002a0e:	fe442783          	lw	a5,-28(s0)
    80002a12:	2785                	addiw	a5,a5,1
    80002a14:	fef42223          	sw	a5,-28(s0)
    80002a18:	fe442783          	lw	a5,-28(s0)
    80002a1c:	0007871b          	sext.w	a4,a5
    80002a20:	47bd                	li	a5,15
    80002a22:	fce7dce3          	bge	a5,a4,800029fa <allocproc+0x168>
  }

  return p;
    80002a26:	fe843783          	ld	a5,-24(s0)
}
    80002a2a:	853e                	mv	a0,a5
    80002a2c:	60e2                	ld	ra,24(sp)
    80002a2e:	6442                	ld	s0,16(sp)
    80002a30:	6105                	addi	sp,sp,32
    80002a32:	8082                	ret

0000000080002a34 <freeproc>:
// free a proc structure and the data hanging from it,
// including user pages.
// p->lock must be held.
static void
freeproc(struct proc *p)
{
    80002a34:	1101                	addi	sp,sp,-32
    80002a36:	ec06                	sd	ra,24(sp)
    80002a38:	e822                	sd	s0,16(sp)
    80002a3a:	1000                	addi	s0,sp,32
    80002a3c:	fea43423          	sd	a0,-24(s0)
  if(p->trapframe)
    80002a40:	fe843703          	ld	a4,-24(s0)
    80002a44:	6785                	lui	a5,0x1
    80002a46:	97ba                	add	a5,a5,a4
    80002a48:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80002a4c:	cf81                	beqz	a5,80002a64 <freeproc+0x30>
    kfree((void*)p->trapframe);
    80002a4e:	fe843703          	ld	a4,-24(s0)
    80002a52:	6785                	lui	a5,0x1
    80002a54:	97ba                	add	a5,a5,a4
    80002a56:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80002a5a:	853e                	mv	a0,a5
    80002a5c:	ffffe097          	auipc	ra,0xffffe
    80002a60:	62c080e7          	jalr	1580(ra) # 80001088 <kfree>
  p->trapframe = 0;
    80002a64:	fe843703          	ld	a4,-24(s0)
    80002a68:	6785                	lui	a5,0x1
    80002a6a:	97ba                	add	a5,a5,a4
    80002a6c:	2a07bc23          	sd	zero,696(a5) # 12b8 <_entry-0x7fffed48>
  if(p->pagetable)
    80002a70:	fe843703          	ld	a4,-24(s0)
    80002a74:	6785                	lui	a5,0x1
    80002a76:	97ba                	add	a5,a5,a4
    80002a78:	2b07b783          	ld	a5,688(a5) # 12b0 <_entry-0x7fffed50>
    80002a7c:	c39d                	beqz	a5,80002aa2 <freeproc+0x6e>
    proc_freepagetable(p->pagetable, p->sz);
    80002a7e:	fe843703          	ld	a4,-24(s0)
    80002a82:	6785                	lui	a5,0x1
    80002a84:	97ba                	add	a5,a5,a4
    80002a86:	2b07b683          	ld	a3,688(a5) # 12b0 <_entry-0x7fffed50>
    80002a8a:	fe843703          	ld	a4,-24(s0)
    80002a8e:	6785                	lui	a5,0x1
    80002a90:	97ba                	add	a5,a5,a4
    80002a92:	2a87b783          	ld	a5,680(a5) # 12a8 <_entry-0x7fffed58>
    80002a96:	85be                	mv	a1,a5
    80002a98:	8536                	mv	a0,a3
    80002a9a:	00000097          	auipc	ra,0x0
    80002a9e:	12c080e7          	jalr	300(ra) # 80002bc6 <proc_freepagetable>
  p->pagetable = 0;
    80002aa2:	fe843703          	ld	a4,-24(s0)
    80002aa6:	6785                	lui	a5,0x1
    80002aa8:	97ba                	add	a5,a5,a4
    80002aaa:	2a07b823          	sd	zero,688(a5) # 12b0 <_entry-0x7fffed50>
  p->sz = 0;
    80002aae:	fe843703          	ld	a4,-24(s0)
    80002ab2:	6785                	lui	a5,0x1
    80002ab4:	97ba                	add	a5,a5,a4
    80002ab6:	2a07b423          	sd	zero,680(a5) # 12a8 <_entry-0x7fffed58>
  p->pid = 0;
    80002aba:	fe843783          	ld	a5,-24(s0)
    80002abe:	0207ac23          	sw	zero,56(a5)
  p->parent = 0;
    80002ac2:	fe843783          	ld	a5,-24(s0)
    80002ac6:	0207b023          	sd	zero,32(a5)
  p->name[0] = 0;
    80002aca:	fe843703          	ld	a4,-24(s0)
    80002ace:	6785                	lui	a5,0x1
    80002ad0:	97ba                	add	a5,a5,a4
    80002ad2:	3a078c23          	sb	zero,952(a5) # 13b8 <_entry-0x7fffec48>
  p->chan = 0;
    80002ad6:	fe843783          	ld	a5,-24(s0)
    80002ada:	0207b423          	sd	zero,40(a5)
  p->killed = 0;
    80002ade:	fe843783          	ld	a5,-24(s0)
    80002ae2:	0207a823          	sw	zero,48(a5)
  p->xstate = 0;
    80002ae6:	fe843783          	ld	a5,-24(s0)
    80002aea:	0207aa23          	sw	zero,52(a5)
  p->state = UNUSED;
    80002aee:	fe843783          	ld	a5,-24(s0)
    80002af2:	0007ac23          	sw	zero,24(a5)
}
    80002af6:	0001                	nop
    80002af8:	60e2                	ld	ra,24(sp)
    80002afa:	6442                	ld	s0,16(sp)
    80002afc:	6105                	addi	sp,sp,32
    80002afe:	8082                	ret

0000000080002b00 <proc_pagetable>:

// Create a user page table for a given process,
// with no user memory, but with trampoline pages.
pagetable_t
proc_pagetable(struct proc *p)
{
    80002b00:	7179                	addi	sp,sp,-48
    80002b02:	f406                	sd	ra,40(sp)
    80002b04:	f022                	sd	s0,32(sp)
    80002b06:	1800                	addi	s0,sp,48
    80002b08:	fca43c23          	sd	a0,-40(s0)
  pagetable_t pagetable;

  // An empty page table.
  pagetable = uvmcreate();
    80002b0c:	fffff097          	auipc	ra,0xfffff
    80002b10:	326080e7          	jalr	806(ra) # 80001e32 <uvmcreate>
    80002b14:	fea43423          	sd	a0,-24(s0)
  if(pagetable == 0)
    80002b18:	fe843783          	ld	a5,-24(s0)
    80002b1c:	e399                	bnez	a5,80002b22 <proc_pagetable+0x22>
    return 0;
    80002b1e:	4781                	li	a5,0
    80002b20:	a871                	j	80002bbc <proc_pagetable+0xbc>

  // map the trampoline code (for system call return)
  // at the highest user virtual address.
  // only the supervisor uses it, on the way
  // to/from user space, so not PTE_U.
  if(mappages(pagetable, TRAMPOLINE, PGSIZE,
    80002b22:	00008797          	auipc	a5,0x8
    80002b26:	4de78793          	addi	a5,a5,1246 # 8000b000 <_trampoline>
    80002b2a:	4729                	li	a4,10
    80002b2c:	86be                	mv	a3,a5
    80002b2e:	6605                	lui	a2,0x1
    80002b30:	040007b7          	lui	a5,0x4000
    80002b34:	17fd                	addi	a5,a5,-1
    80002b36:	00c79593          	slli	a1,a5,0xc
    80002b3a:	fe843503          	ld	a0,-24(s0)
    80002b3e:	fffff097          	auipc	ra,0xfffff
    80002b42:	12c080e7          	jalr	300(ra) # 80001c6a <mappages>
    80002b46:	87aa                	mv	a5,a0
    80002b48:	0007db63          	bgez	a5,80002b5e <proc_pagetable+0x5e>
              (uint64)trampoline, PTE_R | PTE_X) < 0){
    uvmfree(pagetable, 0);
    80002b4c:	4581                	li	a1,0
    80002b4e:	fe843503          	ld	a0,-24(s0)
    80002b52:	fffff097          	auipc	ra,0xfffff
    80002b56:	5ce080e7          	jalr	1486(ra) # 80002120 <uvmfree>
    return 0;
    80002b5a:	4781                	li	a5,0
    80002b5c:	a085                	j	80002bbc <proc_pagetable+0xbc>
  }

  // map the trapframe just below TRAMPOLINE, for trampoline.S.
  if(mappages(pagetable, TRAPFRAME, PGSIZE,
              (uint64)(p->trapframe), PTE_R | PTE_W) < 0){
    80002b5e:	fd843703          	ld	a4,-40(s0)
    80002b62:	6785                	lui	a5,0x1
    80002b64:	97ba                	add	a5,a5,a4
    80002b66:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
  if(mappages(pagetable, TRAPFRAME, PGSIZE,
    80002b6a:	4719                	li	a4,6
    80002b6c:	86be                	mv	a3,a5
    80002b6e:	6605                	lui	a2,0x1
    80002b70:	020007b7          	lui	a5,0x2000
    80002b74:	17fd                	addi	a5,a5,-1
    80002b76:	00d79593          	slli	a1,a5,0xd
    80002b7a:	fe843503          	ld	a0,-24(s0)
    80002b7e:	fffff097          	auipc	ra,0xfffff
    80002b82:	0ec080e7          	jalr	236(ra) # 80001c6a <mappages>
    80002b86:	87aa                	mv	a5,a0
    80002b88:	0207d863          	bgez	a5,80002bb8 <proc_pagetable+0xb8>
    uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80002b8c:	4681                	li	a3,0
    80002b8e:	4605                	li	a2,1
    80002b90:	040007b7          	lui	a5,0x4000
    80002b94:	17fd                	addi	a5,a5,-1
    80002b96:	00c79593          	slli	a1,a5,0xc
    80002b9a:	fe843503          	ld	a0,-24(s0)
    80002b9e:	fffff097          	auipc	ra,0xfffff
    80002ba2:	194080e7          	jalr	404(ra) # 80001d32 <uvmunmap>
    uvmfree(pagetable, 0);
    80002ba6:	4581                	li	a1,0
    80002ba8:	fe843503          	ld	a0,-24(s0)
    80002bac:	fffff097          	auipc	ra,0xfffff
    80002bb0:	574080e7          	jalr	1396(ra) # 80002120 <uvmfree>
    return 0;
    80002bb4:	4781                	li	a5,0
    80002bb6:	a019                	j	80002bbc <proc_pagetable+0xbc>
  }

  return pagetable;
    80002bb8:	fe843783          	ld	a5,-24(s0)
}
    80002bbc:	853e                	mv	a0,a5
    80002bbe:	70a2                	ld	ra,40(sp)
    80002bc0:	7402                	ld	s0,32(sp)
    80002bc2:	6145                	addi	sp,sp,48
    80002bc4:	8082                	ret

0000000080002bc6 <proc_freepagetable>:

// Free a process's page table, and free the
// physical memory it refers to.
void
proc_freepagetable(pagetable_t pagetable, uint64 sz)
{
    80002bc6:	1101                	addi	sp,sp,-32
    80002bc8:	ec06                	sd	ra,24(sp)
    80002bca:	e822                	sd	s0,16(sp)
    80002bcc:	1000                	addi	s0,sp,32
    80002bce:	fea43423          	sd	a0,-24(s0)
    80002bd2:	feb43023          	sd	a1,-32(s0)
  uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80002bd6:	4681                	li	a3,0
    80002bd8:	4605                	li	a2,1
    80002bda:	040007b7          	lui	a5,0x4000
    80002bde:	17fd                	addi	a5,a5,-1
    80002be0:	00c79593          	slli	a1,a5,0xc
    80002be4:	fe843503          	ld	a0,-24(s0)
    80002be8:	fffff097          	auipc	ra,0xfffff
    80002bec:	14a080e7          	jalr	330(ra) # 80001d32 <uvmunmap>
  uvmunmap(pagetable, TRAPFRAME, 1, 0);
    80002bf0:	4681                	li	a3,0
    80002bf2:	4605                	li	a2,1
    80002bf4:	020007b7          	lui	a5,0x2000
    80002bf8:	17fd                	addi	a5,a5,-1
    80002bfa:	00d79593          	slli	a1,a5,0xd
    80002bfe:	fe843503          	ld	a0,-24(s0)
    80002c02:	fffff097          	auipc	ra,0xfffff
    80002c06:	130080e7          	jalr	304(ra) # 80001d32 <uvmunmap>
  uvmfree(pagetable, sz);
    80002c0a:	fe043583          	ld	a1,-32(s0)
    80002c0e:	fe843503          	ld	a0,-24(s0)
    80002c12:	fffff097          	auipc	ra,0xfffff
    80002c16:	50e080e7          	jalr	1294(ra) # 80002120 <uvmfree>
}
    80002c1a:	0001                	nop
    80002c1c:	60e2                	ld	ra,24(sp)
    80002c1e:	6442                	ld	s0,16(sp)
    80002c20:	6105                	addi	sp,sp,32
    80002c22:	8082                	ret

0000000080002c24 <userinit>:
};

// Set up first user process.
void
userinit(void)
{
    80002c24:	1101                	addi	sp,sp,-32
    80002c26:	ec06                	sd	ra,24(sp)
    80002c28:	e822                	sd	s0,16(sp)
    80002c2a:	1000                	addi	s0,sp,32
  struct proc *p;

  p = allocproc();
    80002c2c:	00000097          	auipc	ra,0x0
    80002c30:	c66080e7          	jalr	-922(ra) # 80002892 <allocproc>
    80002c34:	fea43423          	sd	a0,-24(s0)
  initproc = p;
    80002c38:	0000a797          	auipc	a5,0xa
    80002c3c:	3e078793          	addi	a5,a5,992 # 8000d018 <initproc>
    80002c40:	fe843703          	ld	a4,-24(s0)
    80002c44:	e398                	sd	a4,0(a5)
  
  // allocate one user page and copy init's instructions
  // and data into it.
  uvminit(p->pagetable, initcode, sizeof(initcode));
    80002c46:	fe843703          	ld	a4,-24(s0)
    80002c4a:	6785                	lui	a5,0x1
    80002c4c:	97ba                	add	a5,a5,a4
    80002c4e:	2b07b783          	ld	a5,688(a5) # 12b0 <_entry-0x7fffed50>
    80002c52:	03400613          	li	a2,52
    80002c56:	0000a597          	auipc	a1,0xa
    80002c5a:	b2258593          	addi	a1,a1,-1246 # 8000c778 <initcode>
    80002c5e:	853e                	mv	a0,a5
    80002c60:	fffff097          	auipc	ra,0xfffff
    80002c64:	20e080e7          	jalr	526(ra) # 80001e6e <uvminit>
  p->sz = PGSIZE;
    80002c68:	fe843703          	ld	a4,-24(s0)
    80002c6c:	6785                	lui	a5,0x1
    80002c6e:	97ba                	add	a5,a5,a4
    80002c70:	6705                	lui	a4,0x1
    80002c72:	2ae7b423          	sd	a4,680(a5) # 12a8 <_entry-0x7fffed58>

  // prepare for the very first "return" from kernel to user.
  p->trapframe->epc = 0;      // user program counter
    80002c76:	fe843703          	ld	a4,-24(s0)
    80002c7a:	6785                	lui	a5,0x1
    80002c7c:	97ba                	add	a5,a5,a4
    80002c7e:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80002c82:	0007bc23          	sd	zero,24(a5)
  p->trapframe->sp = PGSIZE;  // user stack pointer
    80002c86:	fe843703          	ld	a4,-24(s0)
    80002c8a:	6785                	lui	a5,0x1
    80002c8c:	97ba                	add	a5,a5,a4
    80002c8e:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80002c92:	6705                	lui	a4,0x1
    80002c94:	fb98                	sd	a4,48(a5)

  safestrcpy(p->name, "initcode", sizeof(p->name));
    80002c96:	fe843703          	ld	a4,-24(s0)
    80002c9a:	6785                	lui	a5,0x1
    80002c9c:	3b878793          	addi	a5,a5,952 # 13b8 <_entry-0x7fffec48>
    80002ca0:	97ba                	add	a5,a5,a4
    80002ca2:	4641                	li	a2,16
    80002ca4:	00009597          	auipc	a1,0x9
    80002ca8:	51c58593          	addi	a1,a1,1308 # 8000c1c0 <etext+0x1c0>
    80002cac:	853e                	mv	a0,a5
    80002cae:	fffff097          	auipc	ra,0xfffff
    80002cb2:	a9c080e7          	jalr	-1380(ra) # 8000174a <safestrcpy>
  p->cwd = namei("/");
    80002cb6:	00009517          	auipc	a0,0x9
    80002cba:	51a50513          	addi	a0,a0,1306 # 8000c1d0 <etext+0x1d0>
    80002cbe:	00003097          	auipc	ra,0x3
    80002cc2:	7ea080e7          	jalr	2026(ra) # 800064a8 <namei>
    80002cc6:	86aa                	mv	a3,a0
    80002cc8:	fe843703          	ld	a4,-24(s0)
    80002ccc:	6785                	lui	a5,0x1
    80002cce:	97ba                	add	a5,a5,a4
    80002cd0:	3ad7b823          	sd	a3,944(a5) # 13b0 <_entry-0x7fffec50>

  p->state = RUNNABLE;
    80002cd4:	fe843783          	ld	a5,-24(s0)
    80002cd8:	4709                	li	a4,2
    80002cda:	cf98                	sw	a4,24(a5)

  release(&p->lock);
    80002cdc:	fe843783          	ld	a5,-24(s0)
    80002ce0:	853e                	mv	a0,a5
    80002ce2:	ffffe097          	auipc	ra,0xffffe
    80002ce6:	602080e7          	jalr	1538(ra) # 800012e4 <release>
}
    80002cea:	0001                	nop
    80002cec:	60e2                	ld	ra,24(sp)
    80002cee:	6442                	ld	s0,16(sp)
    80002cf0:	6105                	addi	sp,sp,32
    80002cf2:	8082                	ret

0000000080002cf4 <growproc>:

// Grow or shrink user memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
    80002cf4:	7179                	addi	sp,sp,-48
    80002cf6:	f406                	sd	ra,40(sp)
    80002cf8:	f022                	sd	s0,32(sp)
    80002cfa:	1800                	addi	s0,sp,48
    80002cfc:	87aa                	mv	a5,a0
    80002cfe:	fcf42e23          	sw	a5,-36(s0)
  uint sz;
  struct proc *p = myproc();
    80002d02:	00000097          	auipc	ra,0x0
    80002d06:	af6080e7          	jalr	-1290(ra) # 800027f8 <myproc>
    80002d0a:	fea43023          	sd	a0,-32(s0)

  sz = p->sz;
    80002d0e:	fe043703          	ld	a4,-32(s0)
    80002d12:	6785                	lui	a5,0x1
    80002d14:	97ba                	add	a5,a5,a4
    80002d16:	2a87b783          	ld	a5,680(a5) # 12a8 <_entry-0x7fffed58>
    80002d1a:	fef42623          	sw	a5,-20(s0)
  if(n > 0){
    80002d1e:	fdc42783          	lw	a5,-36(s0)
    80002d22:	2781                	sext.w	a5,a5
    80002d24:	04f05163          	blez	a5,80002d66 <growproc+0x72>
    if((sz = uvmalloc(p->pagetable, sz, sz + n)) == 0) {
    80002d28:	fe043703          	ld	a4,-32(s0)
    80002d2c:	6785                	lui	a5,0x1
    80002d2e:	97ba                	add	a5,a5,a4
    80002d30:	2b07b683          	ld	a3,688(a5) # 12b0 <_entry-0x7fffed50>
    80002d34:	fec46583          	lwu	a1,-20(s0)
    80002d38:	fdc42783          	lw	a5,-36(s0)
    80002d3c:	fec42703          	lw	a4,-20(s0)
    80002d40:	9fb9                	addw	a5,a5,a4
    80002d42:	2781                	sext.w	a5,a5
    80002d44:	1782                	slli	a5,a5,0x20
    80002d46:	9381                	srli	a5,a5,0x20
    80002d48:	863e                	mv	a2,a5
    80002d4a:	8536                	mv	a0,a3
    80002d4c:	fffff097          	auipc	ra,0xfffff
    80002d50:	1aa080e7          	jalr	426(ra) # 80001ef6 <uvmalloc>
    80002d54:	87aa                	mv	a5,a0
    80002d56:	fef42623          	sw	a5,-20(s0)
    80002d5a:	fec42783          	lw	a5,-20(s0)
    80002d5e:	2781                	sext.w	a5,a5
    80002d60:	e3a9                	bnez	a5,80002da2 <growproc+0xae>
      return -1;
    80002d62:	57fd                	li	a5,-1
    80002d64:	a881                	j	80002db4 <growproc+0xc0>
    }
  } else if(n < 0){
    80002d66:	fdc42783          	lw	a5,-36(s0)
    80002d6a:	2781                	sext.w	a5,a5
    80002d6c:	0207db63          	bgez	a5,80002da2 <growproc+0xae>
    sz = uvmdealloc(p->pagetable, sz, sz + n);
    80002d70:	fe043703          	ld	a4,-32(s0)
    80002d74:	6785                	lui	a5,0x1
    80002d76:	97ba                	add	a5,a5,a4
    80002d78:	2b07b683          	ld	a3,688(a5) # 12b0 <_entry-0x7fffed50>
    80002d7c:	fec46583          	lwu	a1,-20(s0)
    80002d80:	fdc42783          	lw	a5,-36(s0)
    80002d84:	fec42703          	lw	a4,-20(s0)
    80002d88:	9fb9                	addw	a5,a5,a4
    80002d8a:	2781                	sext.w	a5,a5
    80002d8c:	1782                	slli	a5,a5,0x20
    80002d8e:	9381                	srli	a5,a5,0x20
    80002d90:	863e                	mv	a2,a5
    80002d92:	8536                	mv	a0,a3
    80002d94:	fffff097          	auipc	ra,0xfffff
    80002d98:	246080e7          	jalr	582(ra) # 80001fda <uvmdealloc>
    80002d9c:	87aa                	mv	a5,a0
    80002d9e:	fef42623          	sw	a5,-20(s0)
  }
  p->sz = sz;
    80002da2:	fec46703          	lwu	a4,-20(s0)
    80002da6:	fe043683          	ld	a3,-32(s0)
    80002daa:	6785                	lui	a5,0x1
    80002dac:	97b6                	add	a5,a5,a3
    80002dae:	2ae7b423          	sd	a4,680(a5) # 12a8 <_entry-0x7fffed58>
  return 0;
    80002db2:	4781                	li	a5,0
}
    80002db4:	853e                	mv	a0,a5
    80002db6:	70a2                	ld	ra,40(sp)
    80002db8:	7402                	ld	s0,32(sp)
    80002dba:	6145                	addi	sp,sp,48
    80002dbc:	8082                	ret

0000000080002dbe <fork>:

// Create a new process, copying the parent.
// Sets up child kernel stack to return as if from fork() system call.
int
fork(void)
{
    80002dbe:	7179                	addi	sp,sp,-48
    80002dc0:	f406                	sd	ra,40(sp)
    80002dc2:	f022                	sd	s0,32(sp)
    80002dc4:	1800                	addi	s0,sp,48
  int i, pid;
  struct proc *np;
  struct proc *p = myproc();
    80002dc6:	00000097          	auipc	ra,0x0
    80002dca:	a32080e7          	jalr	-1486(ra) # 800027f8 <myproc>
    80002dce:	fea43023          	sd	a0,-32(s0)

  // Allocate process.
  if((np = allocproc()) == 0){
    80002dd2:	00000097          	auipc	ra,0x0
    80002dd6:	ac0080e7          	jalr	-1344(ra) # 80002892 <allocproc>
    80002dda:	fca43c23          	sd	a0,-40(s0)
    80002dde:	fd843783          	ld	a5,-40(s0)
    80002de2:	e399                	bnez	a5,80002de8 <fork+0x2a>
    return -1;
    80002de4:	57fd                	li	a5,-1
    80002de6:	a259                	j	80002f6c <fork+0x1ae>
  }

  // Copy user memory from parent to child.
  if(uvmcopy(p->pagetable, np->pagetable, p->sz) < 0){
    80002de8:	fe043703          	ld	a4,-32(s0)
    80002dec:	6785                	lui	a5,0x1
    80002dee:	97ba                	add	a5,a5,a4
    80002df0:	2b07b683          	ld	a3,688(a5) # 12b0 <_entry-0x7fffed50>
    80002df4:	fd843703          	ld	a4,-40(s0)
    80002df8:	6785                	lui	a5,0x1
    80002dfa:	97ba                	add	a5,a5,a4
    80002dfc:	2b07b583          	ld	a1,688(a5) # 12b0 <_entry-0x7fffed50>
    80002e00:	fe043703          	ld	a4,-32(s0)
    80002e04:	6785                	lui	a5,0x1
    80002e06:	97ba                	add	a5,a5,a4
    80002e08:	2a87b783          	ld	a5,680(a5) # 12a8 <_entry-0x7fffed58>
    80002e0c:	863e                	mv	a2,a5
    80002e0e:	8536                	mv	a0,a3
    80002e10:	fffff097          	auipc	ra,0xfffff
    80002e14:	35a080e7          	jalr	858(ra) # 8000216a <uvmcopy>
    80002e18:	87aa                	mv	a5,a0
    80002e1a:	0207d163          	bgez	a5,80002e3c <fork+0x7e>
    freeproc(np);
    80002e1e:	fd843503          	ld	a0,-40(s0)
    80002e22:	00000097          	auipc	ra,0x0
    80002e26:	c12080e7          	jalr	-1006(ra) # 80002a34 <freeproc>
    release(&np->lock);
    80002e2a:	fd843783          	ld	a5,-40(s0)
    80002e2e:	853e                	mv	a0,a5
    80002e30:	ffffe097          	auipc	ra,0xffffe
    80002e34:	4b4080e7          	jalr	1204(ra) # 800012e4 <release>
    return -1;
    80002e38:	57fd                	li	a5,-1
    80002e3a:	aa0d                	j	80002f6c <fork+0x1ae>
  }
  np->sz = p->sz;
    80002e3c:	fe043703          	ld	a4,-32(s0)
    80002e40:	6785                	lui	a5,0x1
    80002e42:	97ba                	add	a5,a5,a4
    80002e44:	2a87b703          	ld	a4,680(a5) # 12a8 <_entry-0x7fffed58>
    80002e48:	fd843683          	ld	a3,-40(s0)
    80002e4c:	6785                	lui	a5,0x1
    80002e4e:	97b6                	add	a5,a5,a3
    80002e50:	2ae7b423          	sd	a4,680(a5) # 12a8 <_entry-0x7fffed58>

  np->parent = p;
    80002e54:	fd843783          	ld	a5,-40(s0)
    80002e58:	fe043703          	ld	a4,-32(s0)
    80002e5c:	f398                	sd	a4,32(a5)

  // copy saved user registers.
  *(np->trapframe) = *(p->trapframe);
    80002e5e:	fe043703          	ld	a4,-32(s0)
    80002e62:	6785                	lui	a5,0x1
    80002e64:	97ba                	add	a5,a5,a4
    80002e66:	2b87b683          	ld	a3,696(a5) # 12b8 <_entry-0x7fffed48>
    80002e6a:	fd843703          	ld	a4,-40(s0)
    80002e6e:	6785                	lui	a5,0x1
    80002e70:	97ba                	add	a5,a5,a4
    80002e72:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80002e76:	873e                	mv	a4,a5
    80002e78:	12000793          	li	a5,288
    80002e7c:	863e                	mv	a2,a5
    80002e7e:	85b6                	mv	a1,a3
    80002e80:	853a                	mv	a0,a4
    80002e82:	ffffe097          	auipc	ra,0xffffe
    80002e86:	784080e7          	jalr	1924(ra) # 80001606 <memcpy>

  // Cause fork to return 0 in the child.
  np->trapframe->a0 = 0;
    80002e8a:	fd843703          	ld	a4,-40(s0)
    80002e8e:	6785                	lui	a5,0x1
    80002e90:	97ba                	add	a5,a5,a4
    80002e92:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80002e96:	0607b823          	sd	zero,112(a5)

  // increment reference counts on open file descriptors.
  for(i = 0; i < NOFILE; i++)
    80002e9a:	fe042623          	sw	zero,-20(s0)
    80002e9e:	a881                	j	80002eee <fork+0x130>
    if(p->ofile[i])
    80002ea0:	fe043703          	ld	a4,-32(s0)
    80002ea4:	fec42783          	lw	a5,-20(s0)
    80002ea8:	26678793          	addi	a5,a5,614
    80002eac:	078e                	slli	a5,a5,0x3
    80002eae:	97ba                	add	a5,a5,a4
    80002eb0:	639c                	ld	a5,0(a5)
    80002eb2:	cb8d                	beqz	a5,80002ee4 <fork+0x126>
      np->ofile[i] = filedup(p->ofile[i]);
    80002eb4:	fe043703          	ld	a4,-32(s0)
    80002eb8:	fec42783          	lw	a5,-20(s0)
    80002ebc:	26678793          	addi	a5,a5,614
    80002ec0:	078e                	slli	a5,a5,0x3
    80002ec2:	97ba                	add	a5,a5,a4
    80002ec4:	639c                	ld	a5,0(a5)
    80002ec6:	853e                	mv	a0,a5
    80002ec8:	00004097          	auipc	ra,0x4
    80002ecc:	f78080e7          	jalr	-136(ra) # 80006e40 <filedup>
    80002ed0:	86aa                	mv	a3,a0
    80002ed2:	fd843703          	ld	a4,-40(s0)
    80002ed6:	fec42783          	lw	a5,-20(s0)
    80002eda:	26678793          	addi	a5,a5,614
    80002ede:	078e                	slli	a5,a5,0x3
    80002ee0:	97ba                	add	a5,a5,a4
    80002ee2:	e394                	sd	a3,0(a5)
  for(i = 0; i < NOFILE; i++)
    80002ee4:	fec42783          	lw	a5,-20(s0)
    80002ee8:	2785                	addiw	a5,a5,1
    80002eea:	fef42623          	sw	a5,-20(s0)
    80002eee:	fec42783          	lw	a5,-20(s0)
    80002ef2:	0007871b          	sext.w	a4,a5
    80002ef6:	47bd                	li	a5,15
    80002ef8:	fae7d4e3          	bge	a5,a4,80002ea0 <fork+0xe2>
  np->cwd = idup(p->cwd);
    80002efc:	fe043703          	ld	a4,-32(s0)
    80002f00:	6785                	lui	a5,0x1
    80002f02:	97ba                	add	a5,a5,a4
    80002f04:	3b07b783          	ld	a5,944(a5) # 13b0 <_entry-0x7fffec50>
    80002f08:	853e                	mv	a0,a5
    80002f0a:	00003097          	auipc	ra,0x3
    80002f0e:	84a080e7          	jalr	-1974(ra) # 80005754 <idup>
    80002f12:	86aa                	mv	a3,a0
    80002f14:	fd843703          	ld	a4,-40(s0)
    80002f18:	6785                	lui	a5,0x1
    80002f1a:	97ba                	add	a5,a5,a4
    80002f1c:	3ad7b823          	sd	a3,944(a5) # 13b0 <_entry-0x7fffec50>

  safestrcpy(np->name, p->name, sizeof(p->name));
    80002f20:	fd843703          	ld	a4,-40(s0)
    80002f24:	6785                	lui	a5,0x1
    80002f26:	3b878793          	addi	a5,a5,952 # 13b8 <_entry-0x7fffec48>
    80002f2a:	00f706b3          	add	a3,a4,a5
    80002f2e:	fe043703          	ld	a4,-32(s0)
    80002f32:	6785                	lui	a5,0x1
    80002f34:	3b878793          	addi	a5,a5,952 # 13b8 <_entry-0x7fffec48>
    80002f38:	97ba                	add	a5,a5,a4
    80002f3a:	4641                	li	a2,16
    80002f3c:	85be                	mv	a1,a5
    80002f3e:	8536                	mv	a0,a3
    80002f40:	fffff097          	auipc	ra,0xfffff
    80002f44:	80a080e7          	jalr	-2038(ra) # 8000174a <safestrcpy>

  pid = np->pid;
    80002f48:	fd843783          	ld	a5,-40(s0)
    80002f4c:	5f9c                	lw	a5,56(a5)
    80002f4e:	fcf42a23          	sw	a5,-44(s0)

  np->state = RUNNABLE;
    80002f52:	fd843783          	ld	a5,-40(s0)
    80002f56:	4709                	li	a4,2
    80002f58:	cf98                	sw	a4,24(a5)

  release(&np->lock);
    80002f5a:	fd843783          	ld	a5,-40(s0)
    80002f5e:	853e                	mv	a0,a5
    80002f60:	ffffe097          	auipc	ra,0xffffe
    80002f64:	384080e7          	jalr	900(ra) # 800012e4 <release>

  return pid;
    80002f68:	fd442783          	lw	a5,-44(s0)
}
    80002f6c:	853e                	mv	a0,a5
    80002f6e:	70a2                	ld	ra,40(sp)
    80002f70:	7402                	ld	s0,32(sp)
    80002f72:	6145                	addi	sp,sp,48
    80002f74:	8082                	ret

0000000080002f76 <reparent>:

// Pass p's abandoned children to init.
// Caller must hold p->lock.
void
reparent(struct proc *p)
{
    80002f76:	7179                	addi	sp,sp,-48
    80002f78:	f406                	sd	ra,40(sp)
    80002f7a:	f022                	sd	s0,32(sp)
    80002f7c:	1800                	addi	s0,sp,48
    80002f7e:	fca43c23          	sd	a0,-40(s0)
  struct proc *pp;

  for(pp = proc; pp < &proc[NPROC]; pp++){
    80002f82:	00012797          	auipc	a5,0x12
    80002f86:	71678793          	addi	a5,a5,1814 # 80015698 <proc>
    80002f8a:	fef43423          	sd	a5,-24(s0)
    80002f8e:	a0b1                	j	80002fda <reparent+0x64>
    // this code uses pp->parent without holding pp->lock.
    // acquiring the lock first could cause a deadlock
    // if pp or a child of pp were also in exit()
    // and about to try to lock p.
    if(pp->parent == p){
    80002f90:	fe843783          	ld	a5,-24(s0)
    80002f94:	739c                	ld	a5,32(a5)
    80002f96:	fd843703          	ld	a4,-40(s0)
    80002f9a:	02f71863          	bne	a4,a5,80002fca <reparent+0x54>
      // pp->parent can't change between the check and the acquire()
      // because only the parent changes it, and we're the parent.
      acquire(&pp->lock);
    80002f9e:	fe843783          	ld	a5,-24(s0)
    80002fa2:	853e                	mv	a0,a5
    80002fa4:	ffffe097          	auipc	ra,0xffffe
    80002fa8:	2dc080e7          	jalr	732(ra) # 80001280 <acquire>
      pp->parent = initproc;
    80002fac:	0000a797          	auipc	a5,0xa
    80002fb0:	06c78793          	addi	a5,a5,108 # 8000d018 <initproc>
    80002fb4:	6398                	ld	a4,0(a5)
    80002fb6:	fe843783          	ld	a5,-24(s0)
    80002fba:	f398                	sd	a4,32(a5)
      // we should wake up init here, but that would require
      // initproc->lock, which would be a deadlock, since we hold
      // the lock on one of init's children (pp). this is why
      // exit() always wakes init (before acquiring any locks).
      release(&pp->lock);
    80002fbc:	fe843783          	ld	a5,-24(s0)
    80002fc0:	853e                	mv	a0,a5
    80002fc2:	ffffe097          	auipc	ra,0xffffe
    80002fc6:	322080e7          	jalr	802(ra) # 800012e4 <release>
  for(pp = proc; pp < &proc[NPROC]; pp++){
    80002fca:	fe843703          	ld	a4,-24(s0)
    80002fce:	6785                	lui	a5,0x1
    80002fd0:	3c878793          	addi	a5,a5,968 # 13c8 <_entry-0x7fffec38>
    80002fd4:	97ba                	add	a5,a5,a4
    80002fd6:	fef43423          	sd	a5,-24(s0)
    80002fda:	fe843703          	ld	a4,-24(s0)
    80002fde:	00062797          	auipc	a5,0x62
    80002fe2:	8ba78793          	addi	a5,a5,-1862 # 80064898 <pid_lock>
    80002fe6:	faf765e3          	bltu	a4,a5,80002f90 <reparent+0x1a>
    }
  }
}
    80002fea:	0001                	nop
    80002fec:	0001                	nop
    80002fee:	70a2                	ld	ra,40(sp)
    80002ff0:	7402                	ld	s0,32(sp)
    80002ff2:	6145                	addi	sp,sp,48
    80002ff4:	8082                	ret

0000000080002ff6 <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait().
void
exit(int status)
{
    80002ff6:	7139                	addi	sp,sp,-64
    80002ff8:	fc06                	sd	ra,56(sp)
    80002ffa:	f822                	sd	s0,48(sp)
    80002ffc:	0080                	addi	s0,sp,64
    80002ffe:	87aa                	mv	a5,a0
    80003000:	fcf42623          	sw	a5,-52(s0)
  struct proc *p = myproc();
    80003004:	fffff097          	auipc	ra,0xfffff
    80003008:	7f4080e7          	jalr	2036(ra) # 800027f8 <myproc>
    8000300c:	fea43023          	sd	a0,-32(s0)

  if(p == initproc)
    80003010:	0000a797          	auipc	a5,0xa
    80003014:	00878793          	addi	a5,a5,8 # 8000d018 <initproc>
    80003018:	639c                	ld	a5,0(a5)
    8000301a:	fe043703          	ld	a4,-32(s0)
    8000301e:	00f71a63          	bne	a4,a5,80003032 <exit+0x3c>
    panic("init exiting");
    80003022:	00009517          	auipc	a0,0x9
    80003026:	1b650513          	addi	a0,a0,438 # 8000c1d8 <etext+0x1d8>
    8000302a:	ffffe097          	auipc	ra,0xffffe
    8000302e:	c28080e7          	jalr	-984(ra) # 80000c52 <panic>

  // Close all open files.
  for(int fd = 0; fd < NOFILE; fd++){
    80003032:	fe042623          	sw	zero,-20(s0)
    80003036:	a899                	j	8000308c <exit+0x96>
    if(p->ofile[fd]){
    80003038:	fe043703          	ld	a4,-32(s0)
    8000303c:	fec42783          	lw	a5,-20(s0)
    80003040:	26678793          	addi	a5,a5,614
    80003044:	078e                	slli	a5,a5,0x3
    80003046:	97ba                	add	a5,a5,a4
    80003048:	639c                	ld	a5,0(a5)
    8000304a:	cf85                	beqz	a5,80003082 <exit+0x8c>
      struct file *f = p->ofile[fd];
    8000304c:	fe043703          	ld	a4,-32(s0)
    80003050:	fec42783          	lw	a5,-20(s0)
    80003054:	26678793          	addi	a5,a5,614
    80003058:	078e                	slli	a5,a5,0x3
    8000305a:	97ba                	add	a5,a5,a4
    8000305c:	639c                	ld	a5,0(a5)
    8000305e:	fcf43823          	sd	a5,-48(s0)
      fileclose(f);
    80003062:	fd043503          	ld	a0,-48(s0)
    80003066:	00004097          	auipc	ra,0x4
    8000306a:	e40080e7          	jalr	-448(ra) # 80006ea6 <fileclose>
      p->ofile[fd] = 0;
    8000306e:	fe043703          	ld	a4,-32(s0)
    80003072:	fec42783          	lw	a5,-20(s0)
    80003076:	26678793          	addi	a5,a5,614
    8000307a:	078e                	slli	a5,a5,0x3
    8000307c:	97ba                	add	a5,a5,a4
    8000307e:	0007b023          	sd	zero,0(a5)
  for(int fd = 0; fd < NOFILE; fd++){
    80003082:	fec42783          	lw	a5,-20(s0)
    80003086:	2785                	addiw	a5,a5,1
    80003088:	fef42623          	sw	a5,-20(s0)
    8000308c:	fec42783          	lw	a5,-20(s0)
    80003090:	0007871b          	sext.w	a4,a5
    80003094:	47bd                	li	a5,15
    80003096:	fae7d1e3          	bge	a5,a4,80003038 <exit+0x42>
    }
  }

  begin_op();
    8000309a:	00003097          	auipc	ra,0x3
    8000309e:	772080e7          	jalr	1906(ra) # 8000680c <begin_op>
  iput(p->cwd);
    800030a2:	fe043703          	ld	a4,-32(s0)
    800030a6:	6785                	lui	a5,0x1
    800030a8:	97ba                	add	a5,a5,a4
    800030aa:	3b07b783          	ld	a5,944(a5) # 13b0 <_entry-0x7fffec50>
    800030ae:	853e                	mv	a0,a5
    800030b0:	00003097          	auipc	ra,0x3
    800030b4:	87e080e7          	jalr	-1922(ra) # 8000592e <iput>
  end_op();
    800030b8:	00004097          	auipc	ra,0x4
    800030bc:	816080e7          	jalr	-2026(ra) # 800068ce <end_op>
  p->cwd = 0;
    800030c0:	fe043703          	ld	a4,-32(s0)
    800030c4:	6785                	lui	a5,0x1
    800030c6:	97ba                	add	a5,a5,a4
    800030c8:	3a07b823          	sd	zero,944(a5) # 13b0 <_entry-0x7fffec50>
  // we might re-parent a child to init. we can't be precise about
  // waking up init, since we can't acquire its lock once we've
  // acquired any other proc lock. so wake up init whether that's
  // necessary or not. init may miss this wakeup, but that seems
  // harmless.
  acquire(&initproc->lock);
    800030cc:	0000a797          	auipc	a5,0xa
    800030d0:	f4c78793          	addi	a5,a5,-180 # 8000d018 <initproc>
    800030d4:	639c                	ld	a5,0(a5)
    800030d6:	853e                	mv	a0,a5
    800030d8:	ffffe097          	auipc	ra,0xffffe
    800030dc:	1a8080e7          	jalr	424(ra) # 80001280 <acquire>
  wakeup1(initproc);
    800030e0:	0000a797          	auipc	a5,0xa
    800030e4:	f3878793          	addi	a5,a5,-200 # 8000d018 <initproc>
    800030e8:	639c                	ld	a5,0(a5)
    800030ea:	853e                	mv	a0,a5
    800030ec:	00000097          	auipc	ra,0x0
    800030f0:	562080e7          	jalr	1378(ra) # 8000364e <wakeup1>
  release(&initproc->lock);
    800030f4:	0000a797          	auipc	a5,0xa
    800030f8:	f2478793          	addi	a5,a5,-220 # 8000d018 <initproc>
    800030fc:	639c                	ld	a5,0(a5)
    800030fe:	853e                	mv	a0,a5
    80003100:	ffffe097          	auipc	ra,0xffffe
    80003104:	1e4080e7          	jalr	484(ra) # 800012e4 <release>
  // parent we locked. in case our parent gives us away to init while
  // we're waiting for the parent lock. we may then race with an
  // exiting parent, but the result will be a harmless spurious wakeup
  // to a dead or wrong process; proc structs are never re-allocated
  // as anything else.
  acquire(&p->lock);
    80003108:	fe043783          	ld	a5,-32(s0)
    8000310c:	853e                	mv	a0,a5
    8000310e:	ffffe097          	auipc	ra,0xffffe
    80003112:	172080e7          	jalr	370(ra) # 80001280 <acquire>
  struct proc *original_parent = p->parent;
    80003116:	fe043783          	ld	a5,-32(s0)
    8000311a:	739c                	ld	a5,32(a5)
    8000311c:	fcf43c23          	sd	a5,-40(s0)
  release(&p->lock);
    80003120:	fe043783          	ld	a5,-32(s0)
    80003124:	853e                	mv	a0,a5
    80003126:	ffffe097          	auipc	ra,0xffffe
    8000312a:	1be080e7          	jalr	446(ra) # 800012e4 <release>
  
  // we need the parent's lock in order to wake it up from wait().
  // the parent-then-child rule says we have to lock it first.
  acquire(&original_parent->lock);
    8000312e:	fd843783          	ld	a5,-40(s0)
    80003132:	853e                	mv	a0,a5
    80003134:	ffffe097          	auipc	ra,0xffffe
    80003138:	14c080e7          	jalr	332(ra) # 80001280 <acquire>

  acquire(&p->lock);
    8000313c:	fe043783          	ld	a5,-32(s0)
    80003140:	853e                	mv	a0,a5
    80003142:	ffffe097          	auipc	ra,0xffffe
    80003146:	13e080e7          	jalr	318(ra) # 80001280 <acquire>

  // Give any children to init.
  reparent(p);
    8000314a:	fe043503          	ld	a0,-32(s0)
    8000314e:	00000097          	auipc	ra,0x0
    80003152:	e28080e7          	jalr	-472(ra) # 80002f76 <reparent>

  // Parent might be sleeping in wait().
  wakeup1(original_parent);
    80003156:	fd843503          	ld	a0,-40(s0)
    8000315a:	00000097          	auipc	ra,0x0
    8000315e:	4f4080e7          	jalr	1268(ra) # 8000364e <wakeup1>

  p->xstate = status;
    80003162:	fe043783          	ld	a5,-32(s0)
    80003166:	fcc42703          	lw	a4,-52(s0)
    8000316a:	dbd8                	sw	a4,52(a5)
  p->state = ZOMBIE;
    8000316c:	fe043783          	ld	a5,-32(s0)
    80003170:	4711                	li	a4,4
    80003172:	cf98                	sw	a4,24(a5)

  release(&original_parent->lock);
    80003174:	fd843783          	ld	a5,-40(s0)
    80003178:	853e                	mv	a0,a5
    8000317a:	ffffe097          	auipc	ra,0xffffe
    8000317e:	16a080e7          	jalr	362(ra) # 800012e4 <release>

  // Jump into the scheduler, never to return.
  sched();
    80003182:	00000097          	auipc	ra,0x0
    80003186:	230080e7          	jalr	560(ra) # 800033b2 <sched>
  panic("zombie exit");
    8000318a:	00009517          	auipc	a0,0x9
    8000318e:	05e50513          	addi	a0,a0,94 # 8000c1e8 <etext+0x1e8>
    80003192:	ffffe097          	auipc	ra,0xffffe
    80003196:	ac0080e7          	jalr	-1344(ra) # 80000c52 <panic>

000000008000319a <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(uint64 addr)
{
    8000319a:	7139                	addi	sp,sp,-64
    8000319c:	fc06                	sd	ra,56(sp)
    8000319e:	f822                	sd	s0,48(sp)
    800031a0:	0080                	addi	s0,sp,64
    800031a2:	fca43423          	sd	a0,-56(s0)
  struct proc *np;
  int havekids, pid;
  struct proc *p = myproc();
    800031a6:	fffff097          	auipc	ra,0xfffff
    800031aa:	652080e7          	jalr	1618(ra) # 800027f8 <myproc>
    800031ae:	fca43c23          	sd	a0,-40(s0)

  // hold p->lock for the whole time to avoid lost
  // wakeups from a child's exit().
  acquire(&p->lock);
    800031b2:	fd843783          	ld	a5,-40(s0)
    800031b6:	853e                	mv	a0,a5
    800031b8:	ffffe097          	auipc	ra,0xffffe
    800031bc:	0c8080e7          	jalr	200(ra) # 80001280 <acquire>

  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    800031c0:	fe042223          	sw	zero,-28(s0)
    for(np = proc; np < &proc[NPROC]; np++){
    800031c4:	00012797          	auipc	a5,0x12
    800031c8:	4d478793          	addi	a5,a5,1236 # 80015698 <proc>
    800031cc:	fef43423          	sd	a5,-24(s0)
    800031d0:	a8e9                	j	800032aa <wait+0x110>
      // this code uses np->parent without holding np->lock.
      // acquiring the lock first would cause a deadlock,
      // since np might be an ancestor, and we already hold p->lock.
      if(np->parent == p){
    800031d2:	fe843783          	ld	a5,-24(s0)
    800031d6:	739c                	ld	a5,32(a5)
    800031d8:	fd843703          	ld	a4,-40(s0)
    800031dc:	0af71f63          	bne	a4,a5,8000329a <wait+0x100>
        // np->parent can't change between the check and the acquire()
        // because only the parent changes it, and we're the parent.
        acquire(&np->lock);
    800031e0:	fe843783          	ld	a5,-24(s0)
    800031e4:	853e                	mv	a0,a5
    800031e6:	ffffe097          	auipc	ra,0xffffe
    800031ea:	09a080e7          	jalr	154(ra) # 80001280 <acquire>
        havekids = 1;
    800031ee:	4785                	li	a5,1
    800031f0:	fef42223          	sw	a5,-28(s0)
        if(np->state == ZOMBIE){
    800031f4:	fe843783          	ld	a5,-24(s0)
    800031f8:	4f9c                	lw	a5,24(a5)
    800031fa:	873e                	mv	a4,a5
    800031fc:	4791                	li	a5,4
    800031fe:	08f71763          	bne	a4,a5,8000328c <wait+0xf2>
          // Found one.
          pid = np->pid;
    80003202:	fe843783          	ld	a5,-24(s0)
    80003206:	5f9c                	lw	a5,56(a5)
    80003208:	fcf42a23          	sw	a5,-44(s0)
          if(addr != 0 && copyout(p->pagetable, addr, (char *)&np->xstate,
    8000320c:	fc843783          	ld	a5,-56(s0)
    80003210:	c7b9                	beqz	a5,8000325e <wait+0xc4>
    80003212:	fd843703          	ld	a4,-40(s0)
    80003216:	6785                	lui	a5,0x1
    80003218:	97ba                	add	a5,a5,a4
    8000321a:	2b07b703          	ld	a4,688(a5) # 12b0 <_entry-0x7fffed50>
    8000321e:	fe843783          	ld	a5,-24(s0)
    80003222:	03478793          	addi	a5,a5,52
    80003226:	4691                	li	a3,4
    80003228:	863e                	mv	a2,a5
    8000322a:	fc843583          	ld	a1,-56(s0)
    8000322e:	853a                	mv	a0,a4
    80003230:	fffff097          	auipc	ra,0xfffff
    80003234:	0a4080e7          	jalr	164(ra) # 800022d4 <copyout>
    80003238:	87aa                	mv	a5,a0
    8000323a:	0207d263          	bgez	a5,8000325e <wait+0xc4>
                                  sizeof(np->xstate)) < 0) {
            release(&np->lock);
    8000323e:	fe843783          	ld	a5,-24(s0)
    80003242:	853e                	mv	a0,a5
    80003244:	ffffe097          	auipc	ra,0xffffe
    80003248:	0a0080e7          	jalr	160(ra) # 800012e4 <release>
            release(&p->lock);
    8000324c:	fd843783          	ld	a5,-40(s0)
    80003250:	853e                	mv	a0,a5
    80003252:	ffffe097          	auipc	ra,0xffffe
    80003256:	092080e7          	jalr	146(ra) # 800012e4 <release>
            return -1;
    8000325a:	57fd                	li	a5,-1
    8000325c:	a851                	j	800032f0 <wait+0x156>
          }
          freeproc(np);
    8000325e:	fe843503          	ld	a0,-24(s0)
    80003262:	fffff097          	auipc	ra,0xfffff
    80003266:	7d2080e7          	jalr	2002(ra) # 80002a34 <freeproc>
          release(&np->lock);
    8000326a:	fe843783          	ld	a5,-24(s0)
    8000326e:	853e                	mv	a0,a5
    80003270:	ffffe097          	auipc	ra,0xffffe
    80003274:	074080e7          	jalr	116(ra) # 800012e4 <release>
          release(&p->lock);
    80003278:	fd843783          	ld	a5,-40(s0)
    8000327c:	853e                	mv	a0,a5
    8000327e:	ffffe097          	auipc	ra,0xffffe
    80003282:	066080e7          	jalr	102(ra) # 800012e4 <release>
          return pid;
    80003286:	fd442783          	lw	a5,-44(s0)
    8000328a:	a09d                	j	800032f0 <wait+0x156>
        }
        release(&np->lock);
    8000328c:	fe843783          	ld	a5,-24(s0)
    80003290:	853e                	mv	a0,a5
    80003292:	ffffe097          	auipc	ra,0xffffe
    80003296:	052080e7          	jalr	82(ra) # 800012e4 <release>
    for(np = proc; np < &proc[NPROC]; np++){
    8000329a:	fe843703          	ld	a4,-24(s0)
    8000329e:	6785                	lui	a5,0x1
    800032a0:	3c878793          	addi	a5,a5,968 # 13c8 <_entry-0x7fffec38>
    800032a4:	97ba                	add	a5,a5,a4
    800032a6:	fef43423          	sd	a5,-24(s0)
    800032aa:	fe843703          	ld	a4,-24(s0)
    800032ae:	00061797          	auipc	a5,0x61
    800032b2:	5ea78793          	addi	a5,a5,1514 # 80064898 <pid_lock>
    800032b6:	f0f76ee3          	bltu	a4,a5,800031d2 <wait+0x38>
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || p->killed){
    800032ba:	fe442783          	lw	a5,-28(s0)
    800032be:	2781                	sext.w	a5,a5
    800032c0:	c789                	beqz	a5,800032ca <wait+0x130>
    800032c2:	fd843783          	ld	a5,-40(s0)
    800032c6:	5b9c                	lw	a5,48(a5)
    800032c8:	cb91                	beqz	a5,800032dc <wait+0x142>
      release(&p->lock);
    800032ca:	fd843783          	ld	a5,-40(s0)
    800032ce:	853e                	mv	a0,a5
    800032d0:	ffffe097          	auipc	ra,0xffffe
    800032d4:	014080e7          	jalr	20(ra) # 800012e4 <release>
      return -1;
    800032d8:	57fd                	li	a5,-1
    800032da:	a819                	j	800032f0 <wait+0x156>
    }
    
    // Wait for a child to exit.
    sleep(p, &p->lock);  //DOC: wait-sleep
    800032dc:	fd843783          	ld	a5,-40(s0)
    800032e0:	85be                	mv	a1,a5
    800032e2:	fd843503          	ld	a0,-40(s0)
    800032e6:	00000097          	auipc	ra,0x0
    800032ea:	24e080e7          	jalr	590(ra) # 80003534 <sleep>
    havekids = 0;
    800032ee:	bdc9                	j	800031c0 <wait+0x26>
  }
}
    800032f0:	853e                	mv	a0,a5
    800032f2:	70e2                	ld	ra,56(sp)
    800032f4:	7442                	ld	s0,48(sp)
    800032f6:	6121                	addi	sp,sp,64
    800032f8:	8082                	ret

00000000800032fa <scheduler>:
//  - swtch to start running that process.
//  - eventually that process transfers control
//    via swtch back to the scheduler.
void
scheduler(void)
{
    800032fa:	1101                	addi	sp,sp,-32
    800032fc:	ec06                	sd	ra,24(sp)
    800032fe:	e822                	sd	s0,16(sp)
    80003300:	1000                	addi	s0,sp,32
  struct proc *p;
  struct cpu *c = mycpu();
    80003302:	fffff097          	auipc	ra,0xfffff
    80003306:	4bc080e7          	jalr	1212(ra) # 800027be <mycpu>
    8000330a:	fea43023          	sd	a0,-32(s0)
  
  c->proc = 0;
    8000330e:	fe043783          	ld	a5,-32(s0)
    80003312:	0007b023          	sd	zero,0(a5)
  for(;;){
    // Avoid deadlock by ensuring that devices can interrupt.
    intr_on();
    80003316:	fffff097          	auipc	ra,0xfffff
    8000331a:	29c080e7          	jalr	668(ra) # 800025b2 <intr_on>

    for(p = proc; p < &proc[NPROC]; p++) {
    8000331e:	00012797          	auipc	a5,0x12
    80003322:	37a78793          	addi	a5,a5,890 # 80015698 <proc>
    80003326:	fef43423          	sd	a5,-24(s0)
    8000332a:	a89d                	j	800033a0 <scheduler+0xa6>
      acquire(&p->lock);
    8000332c:	fe843783          	ld	a5,-24(s0)
    80003330:	853e                	mv	a0,a5
    80003332:	ffffe097          	auipc	ra,0xffffe
    80003336:	f4e080e7          	jalr	-178(ra) # 80001280 <acquire>
      if(p->state == RUNNABLE) {
    8000333a:	fe843783          	ld	a5,-24(s0)
    8000333e:	4f9c                	lw	a5,24(a5)
    80003340:	873e                	mv	a4,a5
    80003342:	4789                	li	a5,2
    80003344:	02f71f63          	bne	a4,a5,80003382 <scheduler+0x88>
        // Switch to chosen process.  It is the process's job
        // to release its lock and then reacquire it
        // before jumping back to us.
        p->state = RUNNING;
    80003348:	fe843783          	ld	a5,-24(s0)
    8000334c:	470d                	li	a4,3
    8000334e:	cf98                	sw	a4,24(a5)
        c->proc = p;
    80003350:	fe043783          	ld	a5,-32(s0)
    80003354:	fe843703          	ld	a4,-24(s0)
    80003358:	e398                	sd	a4,0(a5)
        swtch(&c->context, &p->context);
    8000335a:	fe043783          	ld	a5,-32(s0)
    8000335e:	00878693          	addi	a3,a5,8
    80003362:	fe843703          	ld	a4,-24(s0)
    80003366:	6785                	lui	a5,0x1
    80003368:	2c078793          	addi	a5,a5,704 # 12c0 <_entry-0x7fffed40>
    8000336c:	97ba                	add	a5,a5,a4
    8000336e:	85be                	mv	a1,a5
    80003370:	8536                	mv	a0,a3
    80003372:	00000097          	auipc	ra,0x0
    80003376:	5b8080e7          	jalr	1464(ra) # 8000392a <swtch>

        // Process is done running for now.
        // It should have changed its p->state before coming back.
        c->proc = 0;
    8000337a:	fe043783          	ld	a5,-32(s0)
    8000337e:	0007b023          	sd	zero,0(a5)
      }
      release(&p->lock);
    80003382:	fe843783          	ld	a5,-24(s0)
    80003386:	853e                	mv	a0,a5
    80003388:	ffffe097          	auipc	ra,0xffffe
    8000338c:	f5c080e7          	jalr	-164(ra) # 800012e4 <release>
    for(p = proc; p < &proc[NPROC]; p++) {
    80003390:	fe843703          	ld	a4,-24(s0)
    80003394:	6785                	lui	a5,0x1
    80003396:	3c878793          	addi	a5,a5,968 # 13c8 <_entry-0x7fffec38>
    8000339a:	97ba                	add	a5,a5,a4
    8000339c:	fef43423          	sd	a5,-24(s0)
    800033a0:	fe843703          	ld	a4,-24(s0)
    800033a4:	00061797          	auipc	a5,0x61
    800033a8:	4f478793          	addi	a5,a5,1268 # 80064898 <pid_lock>
    800033ac:	f8f760e3          	bltu	a4,a5,8000332c <scheduler+0x32>
    intr_on();
    800033b0:	b79d                	j	80003316 <scheduler+0x1c>

00000000800033b2 <sched>:
// be proc->intena and proc->noff, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
    800033b2:	7179                	addi	sp,sp,-48
    800033b4:	f406                	sd	ra,40(sp)
    800033b6:	f022                	sd	s0,32(sp)
    800033b8:	ec26                	sd	s1,24(sp)
    800033ba:	1800                	addi	s0,sp,48
  int intena;
  struct proc *p = myproc();
    800033bc:	fffff097          	auipc	ra,0xfffff
    800033c0:	43c080e7          	jalr	1084(ra) # 800027f8 <myproc>
    800033c4:	fca43c23          	sd	a0,-40(s0)

  if(!holding(&p->lock))
    800033c8:	fd843783          	ld	a5,-40(s0)
    800033cc:	853e                	mv	a0,a5
    800033ce:	ffffe097          	auipc	ra,0xffffe
    800033d2:	f6c080e7          	jalr	-148(ra) # 8000133a <holding>
    800033d6:	87aa                	mv	a5,a0
    800033d8:	eb89                	bnez	a5,800033ea <sched+0x38>
    panic("sched p->lock");
    800033da:	00009517          	auipc	a0,0x9
    800033de:	e1e50513          	addi	a0,a0,-482 # 8000c1f8 <etext+0x1f8>
    800033e2:	ffffe097          	auipc	ra,0xffffe
    800033e6:	870080e7          	jalr	-1936(ra) # 80000c52 <panic>
  if(mycpu()->noff != 1)
    800033ea:	fffff097          	auipc	ra,0xfffff
    800033ee:	3d4080e7          	jalr	980(ra) # 800027be <mycpu>
    800033f2:	87aa                	mv	a5,a0
    800033f4:	5fbc                	lw	a5,120(a5)
    800033f6:	873e                	mv	a4,a5
    800033f8:	4785                	li	a5,1
    800033fa:	00f70a63          	beq	a4,a5,8000340e <sched+0x5c>
    panic("sched locks");
    800033fe:	00009517          	auipc	a0,0x9
    80003402:	e0a50513          	addi	a0,a0,-502 # 8000c208 <etext+0x208>
    80003406:	ffffe097          	auipc	ra,0xffffe
    8000340a:	84c080e7          	jalr	-1972(ra) # 80000c52 <panic>
  if(p->state == RUNNING)
    8000340e:	fd843783          	ld	a5,-40(s0)
    80003412:	4f9c                	lw	a5,24(a5)
    80003414:	873e                	mv	a4,a5
    80003416:	478d                	li	a5,3
    80003418:	00f71a63          	bne	a4,a5,8000342c <sched+0x7a>
    panic("sched running");
    8000341c:	00009517          	auipc	a0,0x9
    80003420:	dfc50513          	addi	a0,a0,-516 # 8000c218 <etext+0x218>
    80003424:	ffffe097          	auipc	ra,0xffffe
    80003428:	82e080e7          	jalr	-2002(ra) # 80000c52 <panic>
  if(intr_get())
    8000342c:	fffff097          	auipc	ra,0xfffff
    80003430:	1b0080e7          	jalr	432(ra) # 800025dc <intr_get>
    80003434:	87aa                	mv	a5,a0
    80003436:	cb89                	beqz	a5,80003448 <sched+0x96>
    panic("sched interruptible");
    80003438:	00009517          	auipc	a0,0x9
    8000343c:	df050513          	addi	a0,a0,-528 # 8000c228 <etext+0x228>
    80003440:	ffffe097          	auipc	ra,0xffffe
    80003444:	812080e7          	jalr	-2030(ra) # 80000c52 <panic>

  intena = mycpu()->intena;
    80003448:	fffff097          	auipc	ra,0xfffff
    8000344c:	376080e7          	jalr	886(ra) # 800027be <mycpu>
    80003450:	87aa                	mv	a5,a0
    80003452:	5ffc                	lw	a5,124(a5)
    80003454:	fcf42a23          	sw	a5,-44(s0)
  swtch(&p->context, &mycpu()->context);
    80003458:	fd843703          	ld	a4,-40(s0)
    8000345c:	6785                	lui	a5,0x1
    8000345e:	2c078793          	addi	a5,a5,704 # 12c0 <_entry-0x7fffed40>
    80003462:	00f704b3          	add	s1,a4,a5
    80003466:	fffff097          	auipc	ra,0xfffff
    8000346a:	358080e7          	jalr	856(ra) # 800027be <mycpu>
    8000346e:	87aa                	mv	a5,a0
    80003470:	07a1                	addi	a5,a5,8
    80003472:	85be                	mv	a1,a5
    80003474:	8526                	mv	a0,s1
    80003476:	00000097          	auipc	ra,0x0
    8000347a:	4b4080e7          	jalr	1204(ra) # 8000392a <swtch>
  mycpu()->intena = intena;
    8000347e:	fffff097          	auipc	ra,0xfffff
    80003482:	340080e7          	jalr	832(ra) # 800027be <mycpu>
    80003486:	872a                	mv	a4,a0
    80003488:	fd442783          	lw	a5,-44(s0)
    8000348c:	df7c                	sw	a5,124(a4)
}
    8000348e:	0001                	nop
    80003490:	70a2                	ld	ra,40(sp)
    80003492:	7402                	ld	s0,32(sp)
    80003494:	64e2                	ld	s1,24(sp)
    80003496:	6145                	addi	sp,sp,48
    80003498:	8082                	ret

000000008000349a <yield>:

// Give up the CPU for one scheduling round.
void
yield(void)
{
    8000349a:	1101                	addi	sp,sp,-32
    8000349c:	ec06                	sd	ra,24(sp)
    8000349e:	e822                	sd	s0,16(sp)
    800034a0:	1000                	addi	s0,sp,32
  struct proc *p = myproc();
    800034a2:	fffff097          	auipc	ra,0xfffff
    800034a6:	356080e7          	jalr	854(ra) # 800027f8 <myproc>
    800034aa:	fea43423          	sd	a0,-24(s0)
  acquire(&p->lock);
    800034ae:	fe843783          	ld	a5,-24(s0)
    800034b2:	853e                	mv	a0,a5
    800034b4:	ffffe097          	auipc	ra,0xffffe
    800034b8:	dcc080e7          	jalr	-564(ra) # 80001280 <acquire>
  p->state = RUNNABLE;
    800034bc:	fe843783          	ld	a5,-24(s0)
    800034c0:	4709                	li	a4,2
    800034c2:	cf98                	sw	a4,24(a5)
  sched();
    800034c4:	00000097          	auipc	ra,0x0
    800034c8:	eee080e7          	jalr	-274(ra) # 800033b2 <sched>
  release(&p->lock);
    800034cc:	fe843783          	ld	a5,-24(s0)
    800034d0:	853e                	mv	a0,a5
    800034d2:	ffffe097          	auipc	ra,0xffffe
    800034d6:	e12080e7          	jalr	-494(ra) # 800012e4 <release>
}
    800034da:	0001                	nop
    800034dc:	60e2                	ld	ra,24(sp)
    800034de:	6442                	ld	s0,16(sp)
    800034e0:	6105                	addi	sp,sp,32
    800034e2:	8082                	ret

00000000800034e4 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch to forkret.
void
forkret(void)
{
    800034e4:	1141                	addi	sp,sp,-16
    800034e6:	e406                	sd	ra,8(sp)
    800034e8:	e022                	sd	s0,0(sp)
    800034ea:	0800                	addi	s0,sp,16
  static int first = 1;

  // Still holding p->lock from scheduler.
  release(&myproc()->lock);
    800034ec:	fffff097          	auipc	ra,0xfffff
    800034f0:	30c080e7          	jalr	780(ra) # 800027f8 <myproc>
    800034f4:	87aa                	mv	a5,a0
    800034f6:	853e                	mv	a0,a5
    800034f8:	ffffe097          	auipc	ra,0xffffe
    800034fc:	dec080e7          	jalr	-532(ra) # 800012e4 <release>

  if (first) {
    80003500:	00009797          	auipc	a5,0x9
    80003504:	25478793          	addi	a5,a5,596 # 8000c754 <first.1>
    80003508:	439c                	lw	a5,0(a5)
    8000350a:	cf81                	beqz	a5,80003522 <forkret+0x3e>
    // File system initialization must be run in the context of a
    // regular process (e.g., because it calls sleep), and thus cannot
    // be run from main().
    first = 0;
    8000350c:	00009797          	auipc	a5,0x9
    80003510:	24878793          	addi	a5,a5,584 # 8000c754 <first.1>
    80003514:	0007a023          	sw	zero,0(a5)
    fsinit(ROOTDEV);
    80003518:	4505                	li	a0,1
    8000351a:	00002097          	auipc	ra,0x2
    8000351e:	b14080e7          	jalr	-1260(ra) # 8000502e <fsinit>
  }

  usertrapret();
    80003522:	00001097          	auipc	ra,0x1
    80003526:	ce2080e7          	jalr	-798(ra) # 80004204 <usertrapret>
}
    8000352a:	0001                	nop
    8000352c:	60a2                	ld	ra,8(sp)
    8000352e:	6402                	ld	s0,0(sp)
    80003530:	0141                	addi	sp,sp,16
    80003532:	8082                	ret

0000000080003534 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
    80003534:	7179                	addi	sp,sp,-48
    80003536:	f406                	sd	ra,40(sp)
    80003538:	f022                	sd	s0,32(sp)
    8000353a:	1800                	addi	s0,sp,48
    8000353c:	fca43c23          	sd	a0,-40(s0)
    80003540:	fcb43823          	sd	a1,-48(s0)
  struct proc *p = myproc();
    80003544:	fffff097          	auipc	ra,0xfffff
    80003548:	2b4080e7          	jalr	692(ra) # 800027f8 <myproc>
    8000354c:	fea43423          	sd	a0,-24(s0)
  // change p->state and then call sched.
  // Once we hold p->lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup locks p->lock),
  // so it's okay to release lk.
  if(lk != &p->lock){  //DOC: sleeplock0
    80003550:	fe843783          	ld	a5,-24(s0)
    80003554:	fd043703          	ld	a4,-48(s0)
    80003558:	00f70f63          	beq	a4,a5,80003576 <sleep+0x42>
    acquire(&p->lock);  //DOC: sleeplock1
    8000355c:	fe843783          	ld	a5,-24(s0)
    80003560:	853e                	mv	a0,a5
    80003562:	ffffe097          	auipc	ra,0xffffe
    80003566:	d1e080e7          	jalr	-738(ra) # 80001280 <acquire>
    release(lk);
    8000356a:	fd043503          	ld	a0,-48(s0)
    8000356e:	ffffe097          	auipc	ra,0xffffe
    80003572:	d76080e7          	jalr	-650(ra) # 800012e4 <release>
  }

  // Go to sleep.
  p->chan = chan;
    80003576:	fe843783          	ld	a5,-24(s0)
    8000357a:	fd843703          	ld	a4,-40(s0)
    8000357e:	f798                	sd	a4,40(a5)
  p->state = SLEEPING;
    80003580:	fe843783          	ld	a5,-24(s0)
    80003584:	4705                	li	a4,1
    80003586:	cf98                	sw	a4,24(a5)

  sched();
    80003588:	00000097          	auipc	ra,0x0
    8000358c:	e2a080e7          	jalr	-470(ra) # 800033b2 <sched>

  // Tidy up.
  p->chan = 0;
    80003590:	fe843783          	ld	a5,-24(s0)
    80003594:	0207b423          	sd	zero,40(a5)

  // Reacquire original lock.
  if(lk != &p->lock){
    80003598:	fe843783          	ld	a5,-24(s0)
    8000359c:	fd043703          	ld	a4,-48(s0)
    800035a0:	00f70f63          	beq	a4,a5,800035be <sleep+0x8a>
    release(&p->lock);
    800035a4:	fe843783          	ld	a5,-24(s0)
    800035a8:	853e                	mv	a0,a5
    800035aa:	ffffe097          	auipc	ra,0xffffe
    800035ae:	d3a080e7          	jalr	-710(ra) # 800012e4 <release>
    acquire(lk);
    800035b2:	fd043503          	ld	a0,-48(s0)
    800035b6:	ffffe097          	auipc	ra,0xffffe
    800035ba:	cca080e7          	jalr	-822(ra) # 80001280 <acquire>
  }
}
    800035be:	0001                	nop
    800035c0:	70a2                	ld	ra,40(sp)
    800035c2:	7402                	ld	s0,32(sp)
    800035c4:	6145                	addi	sp,sp,48
    800035c6:	8082                	ret

00000000800035c8 <wakeup>:

// Wake up all processes sleeping on chan.
// Must be called without any p->lock.
void
wakeup(void *chan)
{
    800035c8:	7179                	addi	sp,sp,-48
    800035ca:	f406                	sd	ra,40(sp)
    800035cc:	f022                	sd	s0,32(sp)
    800035ce:	1800                	addi	s0,sp,48
    800035d0:	fca43c23          	sd	a0,-40(s0)
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++) {
    800035d4:	00012797          	auipc	a5,0x12
    800035d8:	0c478793          	addi	a5,a5,196 # 80015698 <proc>
    800035dc:	fef43423          	sd	a5,-24(s0)
    800035e0:	a889                	j	80003632 <wakeup+0x6a>
    acquire(&p->lock);
    800035e2:	fe843783          	ld	a5,-24(s0)
    800035e6:	853e                	mv	a0,a5
    800035e8:	ffffe097          	auipc	ra,0xffffe
    800035ec:	c98080e7          	jalr	-872(ra) # 80001280 <acquire>
    if(p->state == SLEEPING && p->chan == chan) {
    800035f0:	fe843783          	ld	a5,-24(s0)
    800035f4:	4f9c                	lw	a5,24(a5)
    800035f6:	873e                	mv	a4,a5
    800035f8:	4785                	li	a5,1
    800035fa:	00f71d63          	bne	a4,a5,80003614 <wakeup+0x4c>
    800035fe:	fe843783          	ld	a5,-24(s0)
    80003602:	779c                	ld	a5,40(a5)
    80003604:	fd843703          	ld	a4,-40(s0)
    80003608:	00f71663          	bne	a4,a5,80003614 <wakeup+0x4c>
      p->state = RUNNABLE;
    8000360c:	fe843783          	ld	a5,-24(s0)
    80003610:	4709                	li	a4,2
    80003612:	cf98                	sw	a4,24(a5)
    }
    release(&p->lock);
    80003614:	fe843783          	ld	a5,-24(s0)
    80003618:	853e                	mv	a0,a5
    8000361a:	ffffe097          	auipc	ra,0xffffe
    8000361e:	cca080e7          	jalr	-822(ra) # 800012e4 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    80003622:	fe843703          	ld	a4,-24(s0)
    80003626:	6785                	lui	a5,0x1
    80003628:	3c878793          	addi	a5,a5,968 # 13c8 <_entry-0x7fffec38>
    8000362c:	97ba                	add	a5,a5,a4
    8000362e:	fef43423          	sd	a5,-24(s0)
    80003632:	fe843703          	ld	a4,-24(s0)
    80003636:	00061797          	auipc	a5,0x61
    8000363a:	26278793          	addi	a5,a5,610 # 80064898 <pid_lock>
    8000363e:	faf762e3          	bltu	a4,a5,800035e2 <wakeup+0x1a>
  }
}
    80003642:	0001                	nop
    80003644:	0001                	nop
    80003646:	70a2                	ld	ra,40(sp)
    80003648:	7402                	ld	s0,32(sp)
    8000364a:	6145                	addi	sp,sp,48
    8000364c:	8082                	ret

000000008000364e <wakeup1>:

// Wake up p if it is sleeping in wait(); used by exit().
// Caller must hold p->lock.
static void
wakeup1(struct proc *p)
{
    8000364e:	1101                	addi	sp,sp,-32
    80003650:	ec06                	sd	ra,24(sp)
    80003652:	e822                	sd	s0,16(sp)
    80003654:	1000                	addi	s0,sp,32
    80003656:	fea43423          	sd	a0,-24(s0)
  if(!holding(&p->lock))
    8000365a:	fe843783          	ld	a5,-24(s0)
    8000365e:	853e                	mv	a0,a5
    80003660:	ffffe097          	auipc	ra,0xffffe
    80003664:	cda080e7          	jalr	-806(ra) # 8000133a <holding>
    80003668:	87aa                	mv	a5,a0
    8000366a:	eb89                	bnez	a5,8000367c <wakeup1+0x2e>
    panic("wakeup1");
    8000366c:	00009517          	auipc	a0,0x9
    80003670:	bd450513          	addi	a0,a0,-1068 # 8000c240 <etext+0x240>
    80003674:	ffffd097          	auipc	ra,0xffffd
    80003678:	5de080e7          	jalr	1502(ra) # 80000c52 <panic>
  if(p->chan == p && p->state == SLEEPING) {
    8000367c:	fe843783          	ld	a5,-24(s0)
    80003680:	779c                	ld	a5,40(a5)
    80003682:	fe843703          	ld	a4,-24(s0)
    80003686:	00f71d63          	bne	a4,a5,800036a0 <wakeup1+0x52>
    8000368a:	fe843783          	ld	a5,-24(s0)
    8000368e:	4f9c                	lw	a5,24(a5)
    80003690:	873e                	mv	a4,a5
    80003692:	4785                	li	a5,1
    80003694:	00f71663          	bne	a4,a5,800036a0 <wakeup1+0x52>
    p->state = RUNNABLE;
    80003698:	fe843783          	ld	a5,-24(s0)
    8000369c:	4709                	li	a4,2
    8000369e:	cf98                	sw	a4,24(a5)
  }
}
    800036a0:	0001                	nop
    800036a2:	60e2                	ld	ra,24(sp)
    800036a4:	6442                	ld	s0,16(sp)
    800036a6:	6105                	addi	sp,sp,32
    800036a8:	8082                	ret

00000000800036aa <kill>:
// Kill the process with the given pid.
// The victim won't exit until it tries to return
// to user space (see usertrap() in trap.c).
int
kill(int pid)
{
    800036aa:	7179                	addi	sp,sp,-48
    800036ac:	f406                	sd	ra,40(sp)
    800036ae:	f022                	sd	s0,32(sp)
    800036b0:	1800                	addi	s0,sp,48
    800036b2:	87aa                	mv	a5,a0
    800036b4:	fcf42e23          	sw	a5,-36(s0)
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++){
    800036b8:	00012797          	auipc	a5,0x12
    800036bc:	fe078793          	addi	a5,a5,-32 # 80015698 <proc>
    800036c0:	fef43423          	sd	a5,-24(s0)
    800036c4:	a0bd                	j	80003732 <kill+0x88>
    acquire(&p->lock);
    800036c6:	fe843783          	ld	a5,-24(s0)
    800036ca:	853e                	mv	a0,a5
    800036cc:	ffffe097          	auipc	ra,0xffffe
    800036d0:	bb4080e7          	jalr	-1100(ra) # 80001280 <acquire>
    if(p->pid == pid){
    800036d4:	fe843783          	ld	a5,-24(s0)
    800036d8:	5f98                	lw	a4,56(a5)
    800036da:	fdc42783          	lw	a5,-36(s0)
    800036de:	2781                	sext.w	a5,a5
    800036e0:	02e79a63          	bne	a5,a4,80003714 <kill+0x6a>
      p->killed = 1;
    800036e4:	fe843783          	ld	a5,-24(s0)
    800036e8:	4705                	li	a4,1
    800036ea:	db98                	sw	a4,48(a5)
      if(p->state == SLEEPING){
    800036ec:	fe843783          	ld	a5,-24(s0)
    800036f0:	4f9c                	lw	a5,24(a5)
    800036f2:	873e                	mv	a4,a5
    800036f4:	4785                	li	a5,1
    800036f6:	00f71663          	bne	a4,a5,80003702 <kill+0x58>
        // Wake process from sleep().
        p->state = RUNNABLE;
    800036fa:	fe843783          	ld	a5,-24(s0)
    800036fe:	4709                	li	a4,2
    80003700:	cf98                	sw	a4,24(a5)
      }
      release(&p->lock);
    80003702:	fe843783          	ld	a5,-24(s0)
    80003706:	853e                	mv	a0,a5
    80003708:	ffffe097          	auipc	ra,0xffffe
    8000370c:	bdc080e7          	jalr	-1060(ra) # 800012e4 <release>
      return 0;
    80003710:	4781                	li	a5,0
    80003712:	a80d                	j	80003744 <kill+0x9a>
    }
    release(&p->lock);
    80003714:	fe843783          	ld	a5,-24(s0)
    80003718:	853e                	mv	a0,a5
    8000371a:	ffffe097          	auipc	ra,0xffffe
    8000371e:	bca080e7          	jalr	-1078(ra) # 800012e4 <release>
  for(p = proc; p < &proc[NPROC]; p++){
    80003722:	fe843703          	ld	a4,-24(s0)
    80003726:	6785                	lui	a5,0x1
    80003728:	3c878793          	addi	a5,a5,968 # 13c8 <_entry-0x7fffec38>
    8000372c:	97ba                	add	a5,a5,a4
    8000372e:	fef43423          	sd	a5,-24(s0)
    80003732:	fe843703          	ld	a4,-24(s0)
    80003736:	00061797          	auipc	a5,0x61
    8000373a:	16278793          	addi	a5,a5,354 # 80064898 <pid_lock>
    8000373e:	f8f764e3          	bltu	a4,a5,800036c6 <kill+0x1c>
  }
  return -1;
    80003742:	57fd                	li	a5,-1
}
    80003744:	853e                	mv	a0,a5
    80003746:	70a2                	ld	ra,40(sp)
    80003748:	7402                	ld	s0,32(sp)
    8000374a:	6145                	addi	sp,sp,48
    8000374c:	8082                	ret

000000008000374e <either_copyout>:
// Copy to either a user address, or kernel address,
// depending on usr_dst.
// Returns 0 on success, -1 on error.
int
either_copyout(int user_dst, uint64 dst, void *src, uint64 len)
{
    8000374e:	7139                	addi	sp,sp,-64
    80003750:	fc06                	sd	ra,56(sp)
    80003752:	f822                	sd	s0,48(sp)
    80003754:	0080                	addi	s0,sp,64
    80003756:	87aa                	mv	a5,a0
    80003758:	fcb43823          	sd	a1,-48(s0)
    8000375c:	fcc43423          	sd	a2,-56(s0)
    80003760:	fcd43023          	sd	a3,-64(s0)
    80003764:	fcf42e23          	sw	a5,-36(s0)
  struct proc *p = myproc();
    80003768:	fffff097          	auipc	ra,0xfffff
    8000376c:	090080e7          	jalr	144(ra) # 800027f8 <myproc>
    80003770:	fea43423          	sd	a0,-24(s0)
  if(user_dst){
    80003774:	fdc42783          	lw	a5,-36(s0)
    80003778:	2781                	sext.w	a5,a5
    8000377a:	c785                	beqz	a5,800037a2 <either_copyout+0x54>
    return copyout(p->pagetable, dst, src, len);
    8000377c:	fe843703          	ld	a4,-24(s0)
    80003780:	6785                	lui	a5,0x1
    80003782:	97ba                	add	a5,a5,a4
    80003784:	2b07b783          	ld	a5,688(a5) # 12b0 <_entry-0x7fffed50>
    80003788:	fc043683          	ld	a3,-64(s0)
    8000378c:	fc843603          	ld	a2,-56(s0)
    80003790:	fd043583          	ld	a1,-48(s0)
    80003794:	853e                	mv	a0,a5
    80003796:	fffff097          	auipc	ra,0xfffff
    8000379a:	b3e080e7          	jalr	-1218(ra) # 800022d4 <copyout>
    8000379e:	87aa                	mv	a5,a0
    800037a0:	a839                	j	800037be <either_copyout+0x70>
  } else {
    memmove((char *)dst, src, len);
    800037a2:	fd043783          	ld	a5,-48(s0)
    800037a6:	fc043703          	ld	a4,-64(s0)
    800037aa:	2701                	sext.w	a4,a4
    800037ac:	863a                	mv	a2,a4
    800037ae:	fc843583          	ld	a1,-56(s0)
    800037b2:	853e                	mv	a0,a5
    800037b4:	ffffe097          	auipc	ra,0xffffe
    800037b8:	d84080e7          	jalr	-636(ra) # 80001538 <memmove>
    return 0;
    800037bc:	4781                	li	a5,0
  }
}
    800037be:	853e                	mv	a0,a5
    800037c0:	70e2                	ld	ra,56(sp)
    800037c2:	7442                	ld	s0,48(sp)
    800037c4:	6121                	addi	sp,sp,64
    800037c6:	8082                	ret

00000000800037c8 <either_copyin>:
// Copy from either a user address, or kernel address,
// depending on usr_src.
// Returns 0 on success, -1 on error.
int
either_copyin(void *dst, int user_src, uint64 src, uint64 len)
{
    800037c8:	7139                	addi	sp,sp,-64
    800037ca:	fc06                	sd	ra,56(sp)
    800037cc:	f822                	sd	s0,48(sp)
    800037ce:	0080                	addi	s0,sp,64
    800037d0:	fca43c23          	sd	a0,-40(s0)
    800037d4:	87ae                	mv	a5,a1
    800037d6:	fcc43423          	sd	a2,-56(s0)
    800037da:	fcd43023          	sd	a3,-64(s0)
    800037de:	fcf42a23          	sw	a5,-44(s0)
  struct proc *p = myproc();
    800037e2:	fffff097          	auipc	ra,0xfffff
    800037e6:	016080e7          	jalr	22(ra) # 800027f8 <myproc>
    800037ea:	fea43423          	sd	a0,-24(s0)
  if(user_src){
    800037ee:	fd442783          	lw	a5,-44(s0)
    800037f2:	2781                	sext.w	a5,a5
    800037f4:	c785                	beqz	a5,8000381c <either_copyin+0x54>
    return copyin(p->pagetable, dst, src, len);
    800037f6:	fe843703          	ld	a4,-24(s0)
    800037fa:	6785                	lui	a5,0x1
    800037fc:	97ba                	add	a5,a5,a4
    800037fe:	2b07b783          	ld	a5,688(a5) # 12b0 <_entry-0x7fffed50>
    80003802:	fc043683          	ld	a3,-64(s0)
    80003806:	fc843603          	ld	a2,-56(s0)
    8000380a:	fd843583          	ld	a1,-40(s0)
    8000380e:	853e                	mv	a0,a5
    80003810:	fffff097          	auipc	ra,0xfffff
    80003814:	b92080e7          	jalr	-1134(ra) # 800023a2 <copyin>
    80003818:	87aa                	mv	a5,a0
    8000381a:	a839                	j	80003838 <either_copyin+0x70>
  } else {
    memmove(dst, (char*)src, len);
    8000381c:	fc843783          	ld	a5,-56(s0)
    80003820:	fc043703          	ld	a4,-64(s0)
    80003824:	2701                	sext.w	a4,a4
    80003826:	863a                	mv	a2,a4
    80003828:	85be                	mv	a1,a5
    8000382a:	fd843503          	ld	a0,-40(s0)
    8000382e:	ffffe097          	auipc	ra,0xffffe
    80003832:	d0a080e7          	jalr	-758(ra) # 80001538 <memmove>
    return 0;
    80003836:	4781                	li	a5,0
  }
}
    80003838:	853e                	mv	a0,a5
    8000383a:	70e2                	ld	ra,56(sp)
    8000383c:	7442                	ld	s0,48(sp)
    8000383e:	6121                	addi	sp,sp,64
    80003840:	8082                	ret

0000000080003842 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
    80003842:	1101                	addi	sp,sp,-32
    80003844:	ec06                	sd	ra,24(sp)
    80003846:	e822                	sd	s0,16(sp)
    80003848:	1000                	addi	s0,sp,32
  [ZOMBIE]    "zombie"
  };
  struct proc *p;
  char *state;

  printf("\n");
    8000384a:	00009517          	auipc	a0,0x9
    8000384e:	9fe50513          	addi	a0,a0,-1538 # 8000c248 <etext+0x248>
    80003852:	ffffd097          	auipc	ra,0xffffd
    80003856:	1aa080e7          	jalr	426(ra) # 800009fc <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    8000385a:	00012797          	auipc	a5,0x12
    8000385e:	e3e78793          	addi	a5,a5,-450 # 80015698 <proc>
    80003862:	fef43423          	sd	a5,-24(s0)
    80003866:	a065                	j	8000390e <procdump+0xcc>
    if(p->state == UNUSED)
    80003868:	fe843783          	ld	a5,-24(s0)
    8000386c:	4f9c                	lw	a5,24(a5)
    8000386e:	c7d9                	beqz	a5,800038fc <procdump+0xba>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80003870:	fe843783          	ld	a5,-24(s0)
    80003874:	4f9c                	lw	a5,24(a5)
    80003876:	873e                	mv	a4,a5
    80003878:	4791                	li	a5,4
    8000387a:	02e7ee63          	bltu	a5,a4,800038b6 <procdump+0x74>
    8000387e:	fe843783          	ld	a5,-24(s0)
    80003882:	4f9c                	lw	a5,24(a5)
    80003884:	00009717          	auipc	a4,0x9
    80003888:	f2c70713          	addi	a4,a4,-212 # 8000c7b0 <states.0>
    8000388c:	1782                	slli	a5,a5,0x20
    8000388e:	9381                	srli	a5,a5,0x20
    80003890:	078e                	slli	a5,a5,0x3
    80003892:	97ba                	add	a5,a5,a4
    80003894:	639c                	ld	a5,0(a5)
    80003896:	c385                	beqz	a5,800038b6 <procdump+0x74>
      state = states[p->state];
    80003898:	fe843783          	ld	a5,-24(s0)
    8000389c:	4f9c                	lw	a5,24(a5)
    8000389e:	00009717          	auipc	a4,0x9
    800038a2:	f1270713          	addi	a4,a4,-238 # 8000c7b0 <states.0>
    800038a6:	1782                	slli	a5,a5,0x20
    800038a8:	9381                	srli	a5,a5,0x20
    800038aa:	078e                	slli	a5,a5,0x3
    800038ac:	97ba                	add	a5,a5,a4
    800038ae:	639c                	ld	a5,0(a5)
    800038b0:	fef43023          	sd	a5,-32(s0)
    800038b4:	a039                	j	800038c2 <procdump+0x80>
    else
      state = "???";
    800038b6:	00009797          	auipc	a5,0x9
    800038ba:	99a78793          	addi	a5,a5,-1638 # 8000c250 <etext+0x250>
    800038be:	fef43023          	sd	a5,-32(s0)
    printf("%d %s %s", p->pid, state, p->name);
    800038c2:	fe843783          	ld	a5,-24(s0)
    800038c6:	5f8c                	lw	a1,56(a5)
    800038c8:	fe843703          	ld	a4,-24(s0)
    800038cc:	6785                	lui	a5,0x1
    800038ce:	3b878793          	addi	a5,a5,952 # 13b8 <_entry-0x7fffec48>
    800038d2:	97ba                	add	a5,a5,a4
    800038d4:	86be                	mv	a3,a5
    800038d6:	fe043603          	ld	a2,-32(s0)
    800038da:	00009517          	auipc	a0,0x9
    800038de:	97e50513          	addi	a0,a0,-1666 # 8000c258 <etext+0x258>
    800038e2:	ffffd097          	auipc	ra,0xffffd
    800038e6:	11a080e7          	jalr	282(ra) # 800009fc <printf>
    printf("\n");
    800038ea:	00009517          	auipc	a0,0x9
    800038ee:	95e50513          	addi	a0,a0,-1698 # 8000c248 <etext+0x248>
    800038f2:	ffffd097          	auipc	ra,0xffffd
    800038f6:	10a080e7          	jalr	266(ra) # 800009fc <printf>
    800038fa:	a011                	j	800038fe <procdump+0xbc>
      continue;
    800038fc:	0001                	nop
  for(p = proc; p < &proc[NPROC]; p++){
    800038fe:	fe843703          	ld	a4,-24(s0)
    80003902:	6785                	lui	a5,0x1
    80003904:	3c878793          	addi	a5,a5,968 # 13c8 <_entry-0x7fffec38>
    80003908:	97ba                	add	a5,a5,a4
    8000390a:	fef43423          	sd	a5,-24(s0)
    8000390e:	fe843703          	ld	a4,-24(s0)
    80003912:	00061797          	auipc	a5,0x61
    80003916:	f8678793          	addi	a5,a5,-122 # 80064898 <pid_lock>
    8000391a:	f4f767e3          	bltu	a4,a5,80003868 <procdump+0x26>
  }
}
    8000391e:	0001                	nop
    80003920:	0001                	nop
    80003922:	60e2                	ld	ra,24(sp)
    80003924:	6442                	ld	s0,16(sp)
    80003926:	6105                	addi	sp,sp,32
    80003928:	8082                	ret

000000008000392a <swtch>:
    8000392a:	00153023          	sd	ra,0(a0)
    8000392e:	00253423          	sd	sp,8(a0)
    80003932:	e900                	sd	s0,16(a0)
    80003934:	ed04                	sd	s1,24(a0)
    80003936:	03253023          	sd	s2,32(a0)
    8000393a:	03353423          	sd	s3,40(a0)
    8000393e:	03453823          	sd	s4,48(a0)
    80003942:	03553c23          	sd	s5,56(a0)
    80003946:	05653023          	sd	s6,64(a0)
    8000394a:	05753423          	sd	s7,72(a0)
    8000394e:	05853823          	sd	s8,80(a0)
    80003952:	05953c23          	sd	s9,88(a0)
    80003956:	07a53023          	sd	s10,96(a0)
    8000395a:	07b53423          	sd	s11,104(a0)
    8000395e:	0005b083          	ld	ra,0(a1)
    80003962:	0085b103          	ld	sp,8(a1)
    80003966:	6980                	ld	s0,16(a1)
    80003968:	6d84                	ld	s1,24(a1)
    8000396a:	0205b903          	ld	s2,32(a1)
    8000396e:	0285b983          	ld	s3,40(a1)
    80003972:	0305ba03          	ld	s4,48(a1)
    80003976:	0385ba83          	ld	s5,56(a1)
    8000397a:	0405bb03          	ld	s6,64(a1)
    8000397e:	0485bb83          	ld	s7,72(a1)
    80003982:	0505bc03          	ld	s8,80(a1)
    80003986:	0585bc83          	ld	s9,88(a1)
    8000398a:	0605bd03          	ld	s10,96(a1)
    8000398e:	0685bd83          	ld	s11,104(a1)
    80003992:	8082                	ret

0000000080003994 <r_sstatus>:
{
    80003994:	1101                	addi	sp,sp,-32
    80003996:	ec22                	sd	s0,24(sp)
    80003998:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8000399a:	100027f3          	csrr	a5,sstatus
    8000399e:	fef43423          	sd	a5,-24(s0)
  return x;
    800039a2:	fe843783          	ld	a5,-24(s0)
}
    800039a6:	853e                	mv	a0,a5
    800039a8:	6462                	ld	s0,24(sp)
    800039aa:	6105                	addi	sp,sp,32
    800039ac:	8082                	ret

00000000800039ae <w_sstatus>:
{
    800039ae:	1101                	addi	sp,sp,-32
    800039b0:	ec22                	sd	s0,24(sp)
    800039b2:	1000                	addi	s0,sp,32
    800039b4:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800039b8:	fe843783          	ld	a5,-24(s0)
    800039bc:	10079073          	csrw	sstatus,a5
}
    800039c0:	0001                	nop
    800039c2:	6462                	ld	s0,24(sp)
    800039c4:	6105                	addi	sp,sp,32
    800039c6:	8082                	ret

00000000800039c8 <r_sip>:
{
    800039c8:	1101                	addi	sp,sp,-32
    800039ca:	ec22                	sd	s0,24(sp)
    800039cc:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sip" : "=r" (x) );
    800039ce:	144027f3          	csrr	a5,sip
    800039d2:	fef43423          	sd	a5,-24(s0)
  return x;
    800039d6:	fe843783          	ld	a5,-24(s0)
}
    800039da:	853e                	mv	a0,a5
    800039dc:	6462                	ld	s0,24(sp)
    800039de:	6105                	addi	sp,sp,32
    800039e0:	8082                	ret

00000000800039e2 <w_sip>:
{
    800039e2:	1101                	addi	sp,sp,-32
    800039e4:	ec22                	sd	s0,24(sp)
    800039e6:	1000                	addi	s0,sp,32
    800039e8:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw sip, %0" : : "r" (x));
    800039ec:	fe843783          	ld	a5,-24(s0)
    800039f0:	14479073          	csrw	sip,a5
}
    800039f4:	0001                	nop
    800039f6:	6462                	ld	s0,24(sp)
    800039f8:	6105                	addi	sp,sp,32
    800039fa:	8082                	ret

00000000800039fc <w_sepc>:
{
    800039fc:	1101                	addi	sp,sp,-32
    800039fe:	ec22                	sd	s0,24(sp)
    80003a00:	1000                	addi	s0,sp,32
    80003a02:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw sepc, %0" : : "r" (x));
    80003a06:	fe843783          	ld	a5,-24(s0)
    80003a0a:	14179073          	csrw	sepc,a5
}
    80003a0e:	0001                	nop
    80003a10:	6462                	ld	s0,24(sp)
    80003a12:	6105                	addi	sp,sp,32
    80003a14:	8082                	ret

0000000080003a16 <r_sepc>:
{
    80003a16:	1101                	addi	sp,sp,-32
    80003a18:	ec22                	sd	s0,24(sp)
    80003a1a:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80003a1c:	141027f3          	csrr	a5,sepc
    80003a20:	fef43423          	sd	a5,-24(s0)
  return x;
    80003a24:	fe843783          	ld	a5,-24(s0)
}
    80003a28:	853e                	mv	a0,a5
    80003a2a:	6462                	ld	s0,24(sp)
    80003a2c:	6105                	addi	sp,sp,32
    80003a2e:	8082                	ret

0000000080003a30 <w_stvec>:
{
    80003a30:	1101                	addi	sp,sp,-32
    80003a32:	ec22                	sd	s0,24(sp)
    80003a34:	1000                	addi	s0,sp,32
    80003a36:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw stvec, %0" : : "r" (x));
    80003a3a:	fe843783          	ld	a5,-24(s0)
    80003a3e:	10579073          	csrw	stvec,a5
}
    80003a42:	0001                	nop
    80003a44:	6462                	ld	s0,24(sp)
    80003a46:	6105                	addi	sp,sp,32
    80003a48:	8082                	ret

0000000080003a4a <r_satp>:
{
    80003a4a:	1101                	addi	sp,sp,-32
    80003a4c:	ec22                	sd	s0,24(sp)
    80003a4e:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, satp" : "=r" (x) );
    80003a50:	180027f3          	csrr	a5,satp
    80003a54:	fef43423          	sd	a5,-24(s0)
  return x;
    80003a58:	fe843783          	ld	a5,-24(s0)
}
    80003a5c:	853e                	mv	a0,a5
    80003a5e:	6462                	ld	s0,24(sp)
    80003a60:	6105                	addi	sp,sp,32
    80003a62:	8082                	ret

0000000080003a64 <r_scause>:
{
    80003a64:	1101                	addi	sp,sp,-32
    80003a66:	ec22                	sd	s0,24(sp)
    80003a68:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, scause" : "=r" (x) );
    80003a6a:	142027f3          	csrr	a5,scause
    80003a6e:	fef43423          	sd	a5,-24(s0)
  return x;
    80003a72:	fe843783          	ld	a5,-24(s0)
}
    80003a76:	853e                	mv	a0,a5
    80003a78:	6462                	ld	s0,24(sp)
    80003a7a:	6105                	addi	sp,sp,32
    80003a7c:	8082                	ret

0000000080003a7e <r_stval>:
{
    80003a7e:	1101                	addi	sp,sp,-32
    80003a80:	ec22                	sd	s0,24(sp)
    80003a82:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, stval" : "=r" (x) );
    80003a84:	143027f3          	csrr	a5,stval
    80003a88:	fef43423          	sd	a5,-24(s0)
  return x;
    80003a8c:	fe843783          	ld	a5,-24(s0)
}
    80003a90:	853e                	mv	a0,a5
    80003a92:	6462                	ld	s0,24(sp)
    80003a94:	6105                	addi	sp,sp,32
    80003a96:	8082                	ret

0000000080003a98 <intr_on>:
{
    80003a98:	1141                	addi	sp,sp,-16
    80003a9a:	e406                	sd	ra,8(sp)
    80003a9c:	e022                	sd	s0,0(sp)
    80003a9e:	0800                	addi	s0,sp,16
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80003aa0:	00000097          	auipc	ra,0x0
    80003aa4:	ef4080e7          	jalr	-268(ra) # 80003994 <r_sstatus>
    80003aa8:	87aa                	mv	a5,a0
    80003aaa:	0027e793          	ori	a5,a5,2
    80003aae:	853e                	mv	a0,a5
    80003ab0:	00000097          	auipc	ra,0x0
    80003ab4:	efe080e7          	jalr	-258(ra) # 800039ae <w_sstatus>
}
    80003ab8:	0001                	nop
    80003aba:	60a2                	ld	ra,8(sp)
    80003abc:	6402                	ld	s0,0(sp)
    80003abe:	0141                	addi	sp,sp,16
    80003ac0:	8082                	ret

0000000080003ac2 <intr_off>:
{
    80003ac2:	1141                	addi	sp,sp,-16
    80003ac4:	e406                	sd	ra,8(sp)
    80003ac6:	e022                	sd	s0,0(sp)
    80003ac8:	0800                	addi	s0,sp,16
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80003aca:	00000097          	auipc	ra,0x0
    80003ace:	eca080e7          	jalr	-310(ra) # 80003994 <r_sstatus>
    80003ad2:	87aa                	mv	a5,a0
    80003ad4:	9bf5                	andi	a5,a5,-3
    80003ad6:	853e                	mv	a0,a5
    80003ad8:	00000097          	auipc	ra,0x0
    80003adc:	ed6080e7          	jalr	-298(ra) # 800039ae <w_sstatus>
}
    80003ae0:	0001                	nop
    80003ae2:	60a2                	ld	ra,8(sp)
    80003ae4:	6402                	ld	s0,0(sp)
    80003ae6:	0141                	addi	sp,sp,16
    80003ae8:	8082                	ret

0000000080003aea <intr_get>:
{
    80003aea:	1101                	addi	sp,sp,-32
    80003aec:	ec06                	sd	ra,24(sp)
    80003aee:	e822                	sd	s0,16(sp)
    80003af0:	1000                	addi	s0,sp,32
  uint64 x = r_sstatus();
    80003af2:	00000097          	auipc	ra,0x0
    80003af6:	ea2080e7          	jalr	-350(ra) # 80003994 <r_sstatus>
    80003afa:	fea43423          	sd	a0,-24(s0)
  return (x & SSTATUS_SIE) != 0;
    80003afe:	fe843783          	ld	a5,-24(s0)
    80003b02:	8b89                	andi	a5,a5,2
    80003b04:	00f037b3          	snez	a5,a5
    80003b08:	0ff7f793          	andi	a5,a5,255
    80003b0c:	2781                	sext.w	a5,a5
}
    80003b0e:	853e                	mv	a0,a5
    80003b10:	60e2                	ld	ra,24(sp)
    80003b12:	6442                	ld	s0,16(sp)
    80003b14:	6105                	addi	sp,sp,32
    80003b16:	8082                	ret

0000000080003b18 <r_tp>:
{
    80003b18:	1101                	addi	sp,sp,-32
    80003b1a:	ec22                	sd	s0,24(sp)
    80003b1c:	1000                	addi	s0,sp,32
  asm volatile("mv %0, tp" : "=r" (x) );
    80003b1e:	8792                	mv	a5,tp
    80003b20:	fef43423          	sd	a5,-24(s0)
  return x;
    80003b24:	fe843783          	ld	a5,-24(s0)
}
    80003b28:	853e                	mv	a0,a5
    80003b2a:	6462                	ld	s0,24(sp)
    80003b2c:	6105                	addi	sp,sp,32
    80003b2e:	8082                	ret

0000000080003b30 <trapinit>:

extern int devintr();

void
trapinit(void)
{
    80003b30:	1141                	addi	sp,sp,-16
    80003b32:	e406                	sd	ra,8(sp)
    80003b34:	e022                	sd	s0,0(sp)
    80003b36:	0800                	addi	s0,sp,16
  initlock(&tickslock, "time");
    80003b38:	00008597          	auipc	a1,0x8
    80003b3c:	76058593          	addi	a1,a1,1888 # 8000c298 <etext+0x298>
    80003b40:	00061517          	auipc	a0,0x61
    80003b44:	d7050513          	addi	a0,a0,-656 # 800648b0 <tickslock>
    80003b48:	ffffd097          	auipc	ra,0xffffd
    80003b4c:	708080e7          	jalr	1800(ra) # 80001250 <initlock>
}
    80003b50:	0001                	nop
    80003b52:	60a2                	ld	ra,8(sp)
    80003b54:	6402                	ld	s0,0(sp)
    80003b56:	0141                	addi	sp,sp,16
    80003b58:	8082                	ret

0000000080003b5a <trapinithart>:

// set up to take exceptions and traps while in the kernel.
void
trapinithart(void)
{
    80003b5a:	1141                	addi	sp,sp,-16
    80003b5c:	e406                	sd	ra,8(sp)
    80003b5e:	e022                	sd	s0,0(sp)
    80003b60:	0800                	addi	s0,sp,16
  w_stvec((uint64)kernelvec);
    80003b62:	00005797          	auipc	a5,0x5
    80003b66:	3de78793          	addi	a5,a5,990 # 80008f40 <kernelvec>
    80003b6a:	853e                	mv	a0,a5
    80003b6c:	00000097          	auipc	ra,0x0
    80003b70:	ec4080e7          	jalr	-316(ra) # 80003a30 <w_stvec>
}
    80003b74:	0001                	nop
    80003b76:	60a2                	ld	ra,8(sp)
    80003b78:	6402                	ld	s0,0(sp)
    80003b7a:	0141                	addi	sp,sp,16
    80003b7c:	8082                	ret

0000000080003b7e <handle_timer_intr>:
//
// handle an interrupt, exception, or system call from user space.
// called from trampoline.S
//

void handle_timer_intr(){
    80003b7e:	1101                	addi	sp,sp,-32
    80003b80:	ec06                	sd	ra,24(sp)
    80003b82:	e822                	sd	s0,16(sp)
    80003b84:	1000                	addi	s0,sp,32
  struct proc* p = myproc();
    80003b86:	fffff097          	auipc	ra,0xfffff
    80003b8a:	c72080e7          	jalr	-910(ra) # 800027f8 <myproc>
    80003b8e:	fea43423          	sd	a0,-24(s0)
  if(p->delay < 0){
    80003b92:	fe843783          	ld	a5,-24(s0)
    80003b96:	43bc                	lw	a5,64(a5)
    80003b98:	4e07cd63          	bltz	a5,80004092 <handle_timer_intr+0x514>
    return;
  }
  p->timer_elapsed += 1;
    80003b9c:	fe843783          	ld	a5,-24(s0)
    80003ba0:	5fdc                	lw	a5,60(a5)
    80003ba2:	2785                	addiw	a5,a5,1
    80003ba4:	0007871b          	sext.w	a4,a5
    80003ba8:	fe843783          	ld	a5,-24(s0)
    80003bac:	dfd8                	sw	a4,60(a5)
  if(p->timer_elapsed == p->delay){
    80003bae:	fe843783          	ld	a5,-24(s0)
    80003bb2:	5fd8                	lw	a4,60(a5)
    80003bb4:	fe843783          	ld	a5,-24(s0)
    80003bb8:	43bc                	lw	a5,64(a5)
    80003bba:	4cf71e63          	bne	a4,a5,80004096 <handle_timer_intr+0x518>
    p->delay = -1;
    80003bbe:	fe843783          	ld	a5,-24(s0)
    80003bc2:	577d                	li	a4,-1
    80003bc4:	c3b8                	sw	a4,64(a5)
    p->timer_elapsed = 0;
    80003bc6:	fe843783          	ld	a5,-24(s0)
    80003bca:	0207ae23          	sw	zero,60(a5)
  }else{
    return;
  }
  // if timer_elapsed == p_delay... store the trapframe context
  // context is defined by execution trapframe (env before the timer interrupt)
  p->thrd_context[p->thrd_context_id].s0 = p->trapframe->s0;
    80003bce:	fe843703          	ld	a4,-24(s0)
    80003bd2:	6785                	lui	a5,0x1
    80003bd4:	97ba                	add	a5,a5,a4
    80003bd6:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80003bda:	fe843703          	ld	a4,-24(s0)
    80003bde:	4f38                	lw	a4,88(a4)
    80003be0:	73b4                	ld	a3,96(a5)
    80003be2:	fe843603          	ld	a2,-24(s0)
    80003be6:	87ba                	mv	a5,a4
    80003be8:	078e                	slli	a5,a5,0x3
    80003bea:	97ba                	add	a5,a5,a4
    80003bec:	0796                	slli	a5,a5,0x5
    80003bee:	97b2                	add	a5,a5,a2
    80003bf0:	e3f4                	sd	a3,192(a5)
  p->thrd_context[p->thrd_context_id].s1 = p->trapframe->s1;
    80003bf2:	fe843703          	ld	a4,-24(s0)
    80003bf6:	6785                	lui	a5,0x1
    80003bf8:	97ba                	add	a5,a5,a4
    80003bfa:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80003bfe:	fe843703          	ld	a4,-24(s0)
    80003c02:	4f38                	lw	a4,88(a4)
    80003c04:	77b4                	ld	a3,104(a5)
    80003c06:	fe843603          	ld	a2,-24(s0)
    80003c0a:	87ba                	mv	a5,a4
    80003c0c:	078e                	slli	a5,a5,0x3
    80003c0e:	97ba                	add	a5,a5,a4
    80003c10:	0796                	slli	a5,a5,0x5
    80003c12:	97b2                	add	a5,a5,a2
    80003c14:	e7f4                	sd	a3,200(a5)
  p->thrd_context[p->thrd_context_id].s2 = p->trapframe->s2;
    80003c16:	fe843703          	ld	a4,-24(s0)
    80003c1a:	6785                	lui	a5,0x1
    80003c1c:	97ba                	add	a5,a5,a4
    80003c1e:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80003c22:	fe843703          	ld	a4,-24(s0)
    80003c26:	4f38                	lw	a4,88(a4)
    80003c28:	7bd4                	ld	a3,176(a5)
    80003c2a:	fe843603          	ld	a2,-24(s0)
    80003c2e:	87ba                	mv	a5,a4
    80003c30:	078e                	slli	a5,a5,0x3
    80003c32:	97ba                	add	a5,a5,a4
    80003c34:	0796                	slli	a5,a5,0x5
    80003c36:	97b2                	add	a5,a5,a2
    80003c38:	10d7b823          	sd	a3,272(a5)
  p->thrd_context[p->thrd_context_id].s3 = p->trapframe->s3;
    80003c3c:	fe843703          	ld	a4,-24(s0)
    80003c40:	6785                	lui	a5,0x1
    80003c42:	97ba                	add	a5,a5,a4
    80003c44:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80003c48:	fe843703          	ld	a4,-24(s0)
    80003c4c:	4f38                	lw	a4,88(a4)
    80003c4e:	7fd4                	ld	a3,184(a5)
    80003c50:	fe843603          	ld	a2,-24(s0)
    80003c54:	87ba                	mv	a5,a4
    80003c56:	078e                	slli	a5,a5,0x3
    80003c58:	97ba                	add	a5,a5,a4
    80003c5a:	0796                	slli	a5,a5,0x5
    80003c5c:	97b2                	add	a5,a5,a2
    80003c5e:	10d7bc23          	sd	a3,280(a5)
  p->thrd_context[p->thrd_context_id].s4 = p->trapframe->s4;
    80003c62:	fe843703          	ld	a4,-24(s0)
    80003c66:	6785                	lui	a5,0x1
    80003c68:	97ba                	add	a5,a5,a4
    80003c6a:	2b87b703          	ld	a4,696(a5) # 12b8 <_entry-0x7fffed48>
    80003c6e:	fe843783          	ld	a5,-24(s0)
    80003c72:	4fbc                	lw	a5,88(a5)
    80003c74:	6374                	ld	a3,192(a4)
    80003c76:	fe843603          	ld	a2,-24(s0)
    80003c7a:	00178713          	addi	a4,a5,1
    80003c7e:	87ba                	mv	a5,a4
    80003c80:	078e                	slli	a5,a5,0x3
    80003c82:	97ba                	add	a5,a5,a4
    80003c84:	0796                	slli	a5,a5,0x5
    80003c86:	97b2                	add	a5,a5,a2
    80003c88:	e394                	sd	a3,0(a5)
  p->thrd_context[p->thrd_context_id].s5 = p->trapframe->s5;
    80003c8a:	fe843703          	ld	a4,-24(s0)
    80003c8e:	6785                	lui	a5,0x1
    80003c90:	97ba                	add	a5,a5,a4
    80003c92:	2b87b703          	ld	a4,696(a5) # 12b8 <_entry-0x7fffed48>
    80003c96:	fe843783          	ld	a5,-24(s0)
    80003c9a:	4fbc                	lw	a5,88(a5)
    80003c9c:	6774                	ld	a3,200(a4)
    80003c9e:	fe843603          	ld	a2,-24(s0)
    80003ca2:	00178713          	addi	a4,a5,1
    80003ca6:	87ba                	mv	a5,a4
    80003ca8:	078e                	slli	a5,a5,0x3
    80003caa:	97ba                	add	a5,a5,a4
    80003cac:	0796                	slli	a5,a5,0x5
    80003cae:	97b2                	add	a5,a5,a2
    80003cb0:	e794                	sd	a3,8(a5)
  p->thrd_context[p->thrd_context_id].s6 = p->trapframe->s6;
    80003cb2:	fe843703          	ld	a4,-24(s0)
    80003cb6:	6785                	lui	a5,0x1
    80003cb8:	97ba                	add	a5,a5,a4
    80003cba:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80003cbe:	fe843703          	ld	a4,-24(s0)
    80003cc2:	4f38                	lw	a4,88(a4)
    80003cc4:	6bf4                	ld	a3,208(a5)
    80003cc6:	fe843603          	ld	a2,-24(s0)
    80003cca:	87ba                	mv	a5,a4
    80003ccc:	078e                	slli	a5,a5,0x3
    80003cce:	97ba                	add	a5,a5,a4
    80003cd0:	0796                	slli	a5,a5,0x5
    80003cd2:	97b2                	add	a5,a5,a2
    80003cd4:	12d7b823          	sd	a3,304(a5)
  p->thrd_context[p->thrd_context_id].s7 = p->trapframe->s7;
    80003cd8:	fe843703          	ld	a4,-24(s0)
    80003cdc:	6785                	lui	a5,0x1
    80003cde:	97ba                	add	a5,a5,a4
    80003ce0:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80003ce4:	fe843703          	ld	a4,-24(s0)
    80003ce8:	4f38                	lw	a4,88(a4)
    80003cea:	6ff4                	ld	a3,216(a5)
    80003cec:	fe843603          	ld	a2,-24(s0)
    80003cf0:	87ba                	mv	a5,a4
    80003cf2:	078e                	slli	a5,a5,0x3
    80003cf4:	97ba                	add	a5,a5,a4
    80003cf6:	0796                	slli	a5,a5,0x5
    80003cf8:	97b2                	add	a5,a5,a2
    80003cfa:	12d7bc23          	sd	a3,312(a5)
  p->thrd_context[p->thrd_context_id].s8 = p->trapframe->s8;
    80003cfe:	fe843703          	ld	a4,-24(s0)
    80003d02:	6785                	lui	a5,0x1
    80003d04:	97ba                	add	a5,a5,a4
    80003d06:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80003d0a:	fe843703          	ld	a4,-24(s0)
    80003d0e:	4f38                	lw	a4,88(a4)
    80003d10:	73f4                	ld	a3,224(a5)
    80003d12:	fe843603          	ld	a2,-24(s0)
    80003d16:	87ba                	mv	a5,a4
    80003d18:	078e                	slli	a5,a5,0x3
    80003d1a:	97ba                	add	a5,a5,a4
    80003d1c:	0796                	slli	a5,a5,0x5
    80003d1e:	97b2                	add	a5,a5,a2
    80003d20:	14d7b023          	sd	a3,320(a5)
  p->thrd_context[p->thrd_context_id].s9 = p->trapframe->s9;
    80003d24:	fe843703          	ld	a4,-24(s0)
    80003d28:	6785                	lui	a5,0x1
    80003d2a:	97ba                	add	a5,a5,a4
    80003d2c:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80003d30:	fe843703          	ld	a4,-24(s0)
    80003d34:	4f38                	lw	a4,88(a4)
    80003d36:	77f4                	ld	a3,232(a5)
    80003d38:	fe843603          	ld	a2,-24(s0)
    80003d3c:	87ba                	mv	a5,a4
    80003d3e:	078e                	slli	a5,a5,0x3
    80003d40:	97ba                	add	a5,a5,a4
    80003d42:	0796                	slli	a5,a5,0x5
    80003d44:	97b2                	add	a5,a5,a2
    80003d46:	14d7b423          	sd	a3,328(a5)
  p->thrd_context[p->thrd_context_id].s10 = p->trapframe->s10;
    80003d4a:	fe843703          	ld	a4,-24(s0)
    80003d4e:	6785                	lui	a5,0x1
    80003d50:	97ba                	add	a5,a5,a4
    80003d52:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80003d56:	fe843703          	ld	a4,-24(s0)
    80003d5a:	4f38                	lw	a4,88(a4)
    80003d5c:	7bf4                	ld	a3,240(a5)
    80003d5e:	fe843603          	ld	a2,-24(s0)
    80003d62:	87ba                	mv	a5,a4
    80003d64:	078e                	slli	a5,a5,0x3
    80003d66:	97ba                	add	a5,a5,a4
    80003d68:	0796                	slli	a5,a5,0x5
    80003d6a:	97b2                	add	a5,a5,a2
    80003d6c:	14d7b823          	sd	a3,336(a5)
  p->thrd_context[p->thrd_context_id].s11 = p->trapframe->s11;
    80003d70:	fe843703          	ld	a4,-24(s0)
    80003d74:	6785                	lui	a5,0x1
    80003d76:	97ba                	add	a5,a5,a4
    80003d78:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80003d7c:	fe843703          	ld	a4,-24(s0)
    80003d80:	4f38                	lw	a4,88(a4)
    80003d82:	7ff4                	ld	a3,248(a5)
    80003d84:	fe843603          	ld	a2,-24(s0)
    80003d88:	87ba                	mv	a5,a4
    80003d8a:	078e                	slli	a5,a5,0x3
    80003d8c:	97ba                	add	a5,a5,a4
    80003d8e:	0796                	slli	a5,a5,0x5
    80003d90:	97b2                	add	a5,a5,a2
    80003d92:	14d7bc23          	sd	a3,344(a5)
  p->thrd_context[p->thrd_context_id].ra = p->trapframe->ra;
    80003d96:	fe843703          	ld	a4,-24(s0)
    80003d9a:	6785                	lui	a5,0x1
    80003d9c:	97ba                	add	a5,a5,a4
    80003d9e:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80003da2:	fe843703          	ld	a4,-24(s0)
    80003da6:	4f38                	lw	a4,88(a4)
    80003da8:	7794                	ld	a3,40(a5)
    80003daa:	fe843603          	ld	a2,-24(s0)
    80003dae:	87ba                	mv	a5,a4
    80003db0:	078e                	slli	a5,a5,0x3
    80003db2:	97ba                	add	a5,a5,a4
    80003db4:	0796                	slli	a5,a5,0x5
    80003db6:	97b2                	add	a5,a5,a2
    80003db8:	e7d4                	sd	a3,136(a5)
  p->thrd_context[p->thrd_context_id].sp = p->trapframe->sp;
    80003dba:	fe843703          	ld	a4,-24(s0)
    80003dbe:	6785                	lui	a5,0x1
    80003dc0:	97ba                	add	a5,a5,a4
    80003dc2:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80003dc6:	fe843703          	ld	a4,-24(s0)
    80003dca:	4f38                	lw	a4,88(a4)
    80003dcc:	7b94                	ld	a3,48(a5)
    80003dce:	fe843603          	ld	a2,-24(s0)
    80003dd2:	87ba                	mv	a5,a4
    80003dd4:	078e                	slli	a5,a5,0x3
    80003dd6:	97ba                	add	a5,a5,a4
    80003dd8:	0796                	slli	a5,a5,0x5
    80003dda:	97b2                	add	a5,a5,a2
    80003ddc:	ebd4                	sd	a3,144(a5)
  p->thrd_context[p->thrd_context_id].t0 = p->trapframe->t0;
    80003dde:	fe843703          	ld	a4,-24(s0)
    80003de2:	6785                	lui	a5,0x1
    80003de4:	97ba                	add	a5,a5,a4
    80003de6:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80003dea:	fe843703          	ld	a4,-24(s0)
    80003dee:	4f38                	lw	a4,88(a4)
    80003df0:	67b4                	ld	a3,72(a5)
    80003df2:	fe843603          	ld	a2,-24(s0)
    80003df6:	87ba                	mv	a5,a4
    80003df8:	078e                	slli	a5,a5,0x3
    80003dfa:	97ba                	add	a5,a5,a4
    80003dfc:	0796                	slli	a5,a5,0x5
    80003dfe:	97b2                	add	a5,a5,a2
    80003e00:	f7d4                	sd	a3,168(a5)
  p->thrd_context[p->thrd_context_id].t1 = p->trapframe->t1;
    80003e02:	fe843703          	ld	a4,-24(s0)
    80003e06:	6785                	lui	a5,0x1
    80003e08:	97ba                	add	a5,a5,a4
    80003e0a:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80003e0e:	fe843703          	ld	a4,-24(s0)
    80003e12:	4f38                	lw	a4,88(a4)
    80003e14:	6bb4                	ld	a3,80(a5)
    80003e16:	fe843603          	ld	a2,-24(s0)
    80003e1a:	87ba                	mv	a5,a4
    80003e1c:	078e                	slli	a5,a5,0x3
    80003e1e:	97ba                	add	a5,a5,a4
    80003e20:	0796                	slli	a5,a5,0x5
    80003e22:	97b2                	add	a5,a5,a2
    80003e24:	fbd4                	sd	a3,176(a5)
  p->thrd_context[p->thrd_context_id].t2 = p->trapframe->t2;
    80003e26:	fe843703          	ld	a4,-24(s0)
    80003e2a:	6785                	lui	a5,0x1
    80003e2c:	97ba                	add	a5,a5,a4
    80003e2e:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80003e32:	fe843703          	ld	a4,-24(s0)
    80003e36:	4f38                	lw	a4,88(a4)
    80003e38:	6fb4                	ld	a3,88(a5)
    80003e3a:	fe843603          	ld	a2,-24(s0)
    80003e3e:	87ba                	mv	a5,a4
    80003e40:	078e                	slli	a5,a5,0x3
    80003e42:	97ba                	add	a5,a5,a4
    80003e44:	0796                	slli	a5,a5,0x5
    80003e46:	97b2                	add	a5,a5,a2
    80003e48:	ffd4                	sd	a3,184(a5)
  p->thrd_context[p->thrd_context_id].t3 = p->trapframe->t3;
    80003e4a:	fe843703          	ld	a4,-24(s0)
    80003e4e:	6785                	lui	a5,0x1
    80003e50:	97ba                	add	a5,a5,a4
    80003e52:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80003e56:	fe843703          	ld	a4,-24(s0)
    80003e5a:	4f38                	lw	a4,88(a4)
    80003e5c:	1007b683          	ld	a3,256(a5)
    80003e60:	fe843603          	ld	a2,-24(s0)
    80003e64:	87ba                	mv	a5,a4
    80003e66:	078e                	slli	a5,a5,0x3
    80003e68:	97ba                	add	a5,a5,a4
    80003e6a:	0796                	slli	a5,a5,0x5
    80003e6c:	97b2                	add	a5,a5,a2
    80003e6e:	16d7b023          	sd	a3,352(a5)
  p->thrd_context[p->thrd_context_id].t4 = p->trapframe->t4;
    80003e72:	fe843703          	ld	a4,-24(s0)
    80003e76:	6785                	lui	a5,0x1
    80003e78:	97ba                	add	a5,a5,a4
    80003e7a:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80003e7e:	fe843703          	ld	a4,-24(s0)
    80003e82:	4f38                	lw	a4,88(a4)
    80003e84:	1087b683          	ld	a3,264(a5)
    80003e88:	fe843603          	ld	a2,-24(s0)
    80003e8c:	87ba                	mv	a5,a4
    80003e8e:	078e                	slli	a5,a5,0x3
    80003e90:	97ba                	add	a5,a5,a4
    80003e92:	0796                	slli	a5,a5,0x5
    80003e94:	97b2                	add	a5,a5,a2
    80003e96:	16d7b423          	sd	a3,360(a5)
  p->thrd_context[p->thrd_context_id].t5 = p->trapframe->t5;
    80003e9a:	fe843703          	ld	a4,-24(s0)
    80003e9e:	6785                	lui	a5,0x1
    80003ea0:	97ba                	add	a5,a5,a4
    80003ea2:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80003ea6:	fe843703          	ld	a4,-24(s0)
    80003eaa:	4f38                	lw	a4,88(a4)
    80003eac:	1107b683          	ld	a3,272(a5)
    80003eb0:	fe843603          	ld	a2,-24(s0)
    80003eb4:	87ba                	mv	a5,a4
    80003eb6:	078e                	slli	a5,a5,0x3
    80003eb8:	97ba                	add	a5,a5,a4
    80003eba:	0796                	slli	a5,a5,0x5
    80003ebc:	97b2                	add	a5,a5,a2
    80003ebe:	16d7b823          	sd	a3,368(a5)
  p->thrd_context[p->thrd_context_id].t6 = p->trapframe->t6;
    80003ec2:	fe843703          	ld	a4,-24(s0)
    80003ec6:	6785                	lui	a5,0x1
    80003ec8:	97ba                	add	a5,a5,a4
    80003eca:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80003ece:	fe843703          	ld	a4,-24(s0)
    80003ed2:	4f38                	lw	a4,88(a4)
    80003ed4:	1187b683          	ld	a3,280(a5)
    80003ed8:	fe843603          	ld	a2,-24(s0)
    80003edc:	87ba                	mv	a5,a4
    80003ede:	078e                	slli	a5,a5,0x3
    80003ee0:	97ba                	add	a5,a5,a4
    80003ee2:	0796                	slli	a5,a5,0x5
    80003ee4:	97b2                	add	a5,a5,a2
    80003ee6:	16d7bc23          	sd	a3,376(a5)
  p->thrd_context[p->thrd_context_id].a0 = p->trapframe->a0;
    80003eea:	fe843703          	ld	a4,-24(s0)
    80003eee:	6785                	lui	a5,0x1
    80003ef0:	97ba                	add	a5,a5,a4
    80003ef2:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80003ef6:	fe843703          	ld	a4,-24(s0)
    80003efa:	4f38                	lw	a4,88(a4)
    80003efc:	7bb4                	ld	a3,112(a5)
    80003efe:	fe843603          	ld	a2,-24(s0)
    80003f02:	87ba                	mv	a5,a4
    80003f04:	078e                	slli	a5,a5,0x3
    80003f06:	97ba                	add	a5,a5,a4
    80003f08:	0796                	slli	a5,a5,0x5
    80003f0a:	97b2                	add	a5,a5,a2
    80003f0c:	ebf4                	sd	a3,208(a5)
  p->thrd_context[p->thrd_context_id].a1 = p->trapframe->a1;
    80003f0e:	fe843703          	ld	a4,-24(s0)
    80003f12:	6785                	lui	a5,0x1
    80003f14:	97ba                	add	a5,a5,a4
    80003f16:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80003f1a:	fe843703          	ld	a4,-24(s0)
    80003f1e:	4f38                	lw	a4,88(a4)
    80003f20:	7fb4                	ld	a3,120(a5)
    80003f22:	fe843603          	ld	a2,-24(s0)
    80003f26:	87ba                	mv	a5,a4
    80003f28:	078e                	slli	a5,a5,0x3
    80003f2a:	97ba                	add	a5,a5,a4
    80003f2c:	0796                	slli	a5,a5,0x5
    80003f2e:	97b2                	add	a5,a5,a2
    80003f30:	eff4                	sd	a3,216(a5)
  p->thrd_context[p->thrd_context_id].a2 = p->trapframe->a2;
    80003f32:	fe843703          	ld	a4,-24(s0)
    80003f36:	6785                	lui	a5,0x1
    80003f38:	97ba                	add	a5,a5,a4
    80003f3a:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80003f3e:	fe843703          	ld	a4,-24(s0)
    80003f42:	4f38                	lw	a4,88(a4)
    80003f44:	63d4                	ld	a3,128(a5)
    80003f46:	fe843603          	ld	a2,-24(s0)
    80003f4a:	87ba                	mv	a5,a4
    80003f4c:	078e                	slli	a5,a5,0x3
    80003f4e:	97ba                	add	a5,a5,a4
    80003f50:	0796                	slli	a5,a5,0x5
    80003f52:	97b2                	add	a5,a5,a2
    80003f54:	f3f4                	sd	a3,224(a5)
  p->thrd_context[p->thrd_context_id].a3 = p->trapframe->a3;
    80003f56:	fe843703          	ld	a4,-24(s0)
    80003f5a:	6785                	lui	a5,0x1
    80003f5c:	97ba                	add	a5,a5,a4
    80003f5e:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80003f62:	fe843703          	ld	a4,-24(s0)
    80003f66:	4f38                	lw	a4,88(a4)
    80003f68:	67d4                	ld	a3,136(a5)
    80003f6a:	fe843603          	ld	a2,-24(s0)
    80003f6e:	87ba                	mv	a5,a4
    80003f70:	078e                	slli	a5,a5,0x3
    80003f72:	97ba                	add	a5,a5,a4
    80003f74:	0796                	slli	a5,a5,0x5
    80003f76:	97b2                	add	a5,a5,a2
    80003f78:	f7f4                	sd	a3,232(a5)
  p->thrd_context[p->thrd_context_id].a4 = p->trapframe->a4;
    80003f7a:	fe843703          	ld	a4,-24(s0)
    80003f7e:	6785                	lui	a5,0x1
    80003f80:	97ba                	add	a5,a5,a4
    80003f82:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80003f86:	fe843703          	ld	a4,-24(s0)
    80003f8a:	4f38                	lw	a4,88(a4)
    80003f8c:	6bd4                	ld	a3,144(a5)
    80003f8e:	fe843603          	ld	a2,-24(s0)
    80003f92:	87ba                	mv	a5,a4
    80003f94:	078e                	slli	a5,a5,0x3
    80003f96:	97ba                	add	a5,a5,a4
    80003f98:	0796                	slli	a5,a5,0x5
    80003f9a:	97b2                	add	a5,a5,a2
    80003f9c:	fbf4                	sd	a3,240(a5)
  p->thrd_context[p->thrd_context_id].a5 = p->trapframe->a5;
    80003f9e:	fe843703          	ld	a4,-24(s0)
    80003fa2:	6785                	lui	a5,0x1
    80003fa4:	97ba                	add	a5,a5,a4
    80003fa6:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80003faa:	fe843703          	ld	a4,-24(s0)
    80003fae:	4f38                	lw	a4,88(a4)
    80003fb0:	6fd4                	ld	a3,152(a5)
    80003fb2:	fe843603          	ld	a2,-24(s0)
    80003fb6:	87ba                	mv	a5,a4
    80003fb8:	078e                	slli	a5,a5,0x3
    80003fba:	97ba                	add	a5,a5,a4
    80003fbc:	0796                	slli	a5,a5,0x5
    80003fbe:	97b2                	add	a5,a5,a2
    80003fc0:	fff4                	sd	a3,248(a5)
  p->thrd_context[p->thrd_context_id].a6 = p->trapframe->a6;
    80003fc2:	fe843703          	ld	a4,-24(s0)
    80003fc6:	6785                	lui	a5,0x1
    80003fc8:	97ba                	add	a5,a5,a4
    80003fca:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80003fce:	fe843703          	ld	a4,-24(s0)
    80003fd2:	4f38                	lw	a4,88(a4)
    80003fd4:	73d4                	ld	a3,160(a5)
    80003fd6:	fe843603          	ld	a2,-24(s0)
    80003fda:	87ba                	mv	a5,a4
    80003fdc:	078e                	slli	a5,a5,0x3
    80003fde:	97ba                	add	a5,a5,a4
    80003fe0:	0796                	slli	a5,a5,0x5
    80003fe2:	97b2                	add	a5,a5,a2
    80003fe4:	10d7b023          	sd	a3,256(a5)
  p->thrd_context[p->thrd_context_id].a7 = p->trapframe->a7;
    80003fe8:	fe843703          	ld	a4,-24(s0)
    80003fec:	6785                	lui	a5,0x1
    80003fee:	97ba                	add	a5,a5,a4
    80003ff0:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80003ff4:	fe843703          	ld	a4,-24(s0)
    80003ff8:	4f38                	lw	a4,88(a4)
    80003ffa:	77d4                	ld	a3,168(a5)
    80003ffc:	fe843603          	ld	a2,-24(s0)
    80004000:	87ba                	mv	a5,a4
    80004002:	078e                	slli	a5,a5,0x3
    80004004:	97ba                	add	a5,a5,a4
    80004006:	0796                	slli	a5,a5,0x5
    80004008:	97b2                	add	a5,a5,a2
    8000400a:	10d7b423          	sd	a3,264(a5)
  p->thrd_context[p->thrd_context_id].gp = p->trapframe->gp;
    8000400e:	fe843703          	ld	a4,-24(s0)
    80004012:	6785                	lui	a5,0x1
    80004014:	97ba                	add	a5,a5,a4
    80004016:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    8000401a:	fe843703          	ld	a4,-24(s0)
    8000401e:	4f38                	lw	a4,88(a4)
    80004020:	7f94                	ld	a3,56(a5)
    80004022:	fe843603          	ld	a2,-24(s0)
    80004026:	87ba                	mv	a5,a4
    80004028:	078e                	slli	a5,a5,0x3
    8000402a:	97ba                	add	a5,a5,a4
    8000402c:	0796                	slli	a5,a5,0x5
    8000402e:	97b2                	add	a5,a5,a2
    80004030:	efd4                	sd	a3,152(a5)
  p->thrd_context[p->thrd_context_id].tp = p->trapframe->tp;
    80004032:	fe843703          	ld	a4,-24(s0)
    80004036:	6785                	lui	a5,0x1
    80004038:	97ba                	add	a5,a5,a4
    8000403a:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    8000403e:	fe843703          	ld	a4,-24(s0)
    80004042:	4f38                	lw	a4,88(a4)
    80004044:	63b4                	ld	a3,64(a5)
    80004046:	fe843603          	ld	a2,-24(s0)
    8000404a:	87ba                	mv	a5,a4
    8000404c:	078e                	slli	a5,a5,0x3
    8000404e:	97ba                	add	a5,a5,a4
    80004050:	0796                	slli	a5,a5,0x5
    80004052:	97b2                	add	a5,a5,a2
    80004054:	f3d4                	sd	a3,160(a5)
  p->thrd_context[p->thrd_context_id].epc = p->trapframe->epc;
    80004056:	fe843703          	ld	a4,-24(s0)
    8000405a:	6785                	lui	a5,0x1
    8000405c:	97ba                	add	a5,a5,a4
    8000405e:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80004062:	fe843703          	ld	a4,-24(s0)
    80004066:	4f38                	lw	a4,88(a4)
    80004068:	6f94                	ld	a3,24(a5)
    8000406a:	fe843603          	ld	a2,-24(s0)
    8000406e:	87ba                	mv	a5,a4
    80004070:	078e                	slli	a5,a5,0x3
    80004072:	97ba                	add	a5,a5,a4
    80004074:	0796                	slli	a5,a5,0x5
    80004076:	97b2                	add	a5,a5,a2
    80004078:	ffb4                	sd	a3,120(a5)
  // epc should be the handler to execute it after time interrupt
  p->trapframe->epc = (uint64)p->handler;
    8000407a:	fe843783          	ld	a5,-24(s0)
    8000407e:	67b4                	ld	a3,72(a5)
    80004080:	fe843703          	ld	a4,-24(s0)
    80004084:	6785                	lui	a5,0x1
    80004086:	97ba                	add	a5,a5,a4
    80004088:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    8000408c:	8736                	mv	a4,a3
    8000408e:	ef98                	sd	a4,24(a5)

  return;
    80004090:	a021                	j	80004098 <handle_timer_intr+0x51a>
    return;
    80004092:	0001                	nop
    80004094:	a011                	j	80004098 <handle_timer_intr+0x51a>
    return;
    80004096:	0001                	nop

}
    80004098:	60e2                	ld	ra,24(sp)
    8000409a:	6442                	ld	s0,16(sp)
    8000409c:	6105                	addi	sp,sp,32
    8000409e:	8082                	ret

00000000800040a0 <usertrap>:

void
usertrap(void)
{
    800040a0:	7179                	addi	sp,sp,-48
    800040a2:	f406                	sd	ra,40(sp)
    800040a4:	f022                	sd	s0,32(sp)
    800040a6:	ec26                	sd	s1,24(sp)
    800040a8:	1800                	addi	s0,sp,48
  int which_dev = 0;
    800040aa:	fc042e23          	sw	zero,-36(s0)

  if((r_sstatus() & SSTATUS_SPP) != 0)
    800040ae:	00000097          	auipc	ra,0x0
    800040b2:	8e6080e7          	jalr	-1818(ra) # 80003994 <r_sstatus>
    800040b6:	87aa                	mv	a5,a0
    800040b8:	1007f793          	andi	a5,a5,256
    800040bc:	cb89                	beqz	a5,800040ce <usertrap+0x2e>
    panic("usertrap: not from user mode");
    800040be:	00008517          	auipc	a0,0x8
    800040c2:	1e250513          	addi	a0,a0,482 # 8000c2a0 <etext+0x2a0>
    800040c6:	ffffd097          	auipc	ra,0xffffd
    800040ca:	b8c080e7          	jalr	-1140(ra) # 80000c52 <panic>

  // send interrupts and exceptions to kerneltrap(),
  // since we're now in the kernel.
  w_stvec((uint64)kernelvec);
    800040ce:	00005797          	auipc	a5,0x5
    800040d2:	e7278793          	addi	a5,a5,-398 # 80008f40 <kernelvec>
    800040d6:	853e                	mv	a0,a5
    800040d8:	00000097          	auipc	ra,0x0
    800040dc:	958080e7          	jalr	-1704(ra) # 80003a30 <w_stvec>

  struct proc *p = myproc();
    800040e0:	ffffe097          	auipc	ra,0xffffe
    800040e4:	718080e7          	jalr	1816(ra) # 800027f8 <myproc>
    800040e8:	fca43823          	sd	a0,-48(s0)
  
  // save user program counter.
  p->trapframe->epc = r_sepc();
    800040ec:	fd043703          	ld	a4,-48(s0)
    800040f0:	6785                	lui	a5,0x1
    800040f2:	97ba                	add	a5,a5,a4
    800040f4:	2b87b483          	ld	s1,696(a5) # 12b8 <_entry-0x7fffed48>
    800040f8:	00000097          	auipc	ra,0x0
    800040fc:	91e080e7          	jalr	-1762(ra) # 80003a16 <r_sepc>
    80004100:	87aa                	mv	a5,a0
    80004102:	ec9c                	sd	a5,24(s1)
  
  if(r_scause() == 8){
    80004104:	00000097          	auipc	ra,0x0
    80004108:	960080e7          	jalr	-1696(ra) # 80003a64 <r_scause>
    8000410c:	872a                	mv	a4,a0
    8000410e:	47a1                	li	a5,8
    80004110:	04f71363          	bne	a4,a5,80004156 <usertrap+0xb6>
    // system call

    if(p->killed)
    80004114:	fd043783          	ld	a5,-48(s0)
    80004118:	5b9c                	lw	a5,48(a5)
    8000411a:	c791                	beqz	a5,80004126 <usertrap+0x86>
      exit(-1);
    8000411c:	557d                	li	a0,-1
    8000411e:	fffff097          	auipc	ra,0xfffff
    80004122:	ed8080e7          	jalr	-296(ra) # 80002ff6 <exit>

    // sepc points to the ecall instruction,
    // but we want to return to the next instruction.
    p->trapframe->epc += 4;
    80004126:	fd043703          	ld	a4,-48(s0)
    8000412a:	6785                	lui	a5,0x1
    8000412c:	97ba                	add	a5,a5,a4
    8000412e:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80004132:	6f98                	ld	a4,24(a5)
    80004134:	fd043683          	ld	a3,-48(s0)
    80004138:	6785                	lui	a5,0x1
    8000413a:	97b6                	add	a5,a5,a3
    8000413c:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80004140:	0711                	addi	a4,a4,4
    80004142:	ef98                	sd	a4,24(a5)

    // an interrupt will change sstatus &c registers,
    // so don't enable until done with those registers.
    intr_on();
    80004144:	00000097          	auipc	ra,0x0
    80004148:	954080e7          	jalr	-1708(ra) # 80003a98 <intr_on>

    syscall();
    8000414c:	00000097          	auipc	ra,0x0
    80004150:	72e080e7          	jalr	1838(ra) # 8000487a <syscall>
    80004154:	a0b5                	j	800041c0 <usertrap+0x120>
  } else if((which_dev = devintr()) != 0){
    80004156:	00000097          	auipc	ra,0x0
    8000415a:	3ba080e7          	jalr	954(ra) # 80004510 <devintr>
    8000415e:	87aa                	mv	a5,a0
    80004160:	fcf42e23          	sw	a5,-36(s0)
    80004164:	fdc42783          	lw	a5,-36(s0)
    80004168:	2781                	sext.w	a5,a5
    8000416a:	ebb9                	bnez	a5,800041c0 <usertrap+0x120>
    // ok
  } else {
    printf("usertrap(): unexpected scause %p pid=%d\n", r_scause(), p->pid);
    8000416c:	00000097          	auipc	ra,0x0
    80004170:	8f8080e7          	jalr	-1800(ra) # 80003a64 <r_scause>
    80004174:	872a                	mv	a4,a0
    80004176:	fd043783          	ld	a5,-48(s0)
    8000417a:	5f9c                	lw	a5,56(a5)
    8000417c:	863e                	mv	a2,a5
    8000417e:	85ba                	mv	a1,a4
    80004180:	00008517          	auipc	a0,0x8
    80004184:	14050513          	addi	a0,a0,320 # 8000c2c0 <etext+0x2c0>
    80004188:	ffffd097          	auipc	ra,0xffffd
    8000418c:	874080e7          	jalr	-1932(ra) # 800009fc <printf>
    printf("            sepc=%p stval=%p\n", r_sepc(), r_stval());
    80004190:	00000097          	auipc	ra,0x0
    80004194:	886080e7          	jalr	-1914(ra) # 80003a16 <r_sepc>
    80004198:	84aa                	mv	s1,a0
    8000419a:	00000097          	auipc	ra,0x0
    8000419e:	8e4080e7          	jalr	-1820(ra) # 80003a7e <r_stval>
    800041a2:	87aa                	mv	a5,a0
    800041a4:	863e                	mv	a2,a5
    800041a6:	85a6                	mv	a1,s1
    800041a8:	00008517          	auipc	a0,0x8
    800041ac:	14850513          	addi	a0,a0,328 # 8000c2f0 <etext+0x2f0>
    800041b0:	ffffd097          	auipc	ra,0xffffd
    800041b4:	84c080e7          	jalr	-1972(ra) # 800009fc <printf>
    p->killed = 1;
    800041b8:	fd043783          	ld	a5,-48(s0)
    800041bc:	4705                	li	a4,1
    800041be:	db98                	sw	a4,48(a5)
  }

  if(p->killed)
    800041c0:	fd043783          	ld	a5,-48(s0)
    800041c4:	5b9c                	lw	a5,48(a5)
    800041c6:	c791                	beqz	a5,800041d2 <usertrap+0x132>
    exit(-1);
    800041c8:	557d                	li	a0,-1
    800041ca:	fffff097          	auipc	ra,0xfffff
    800041ce:	e2c080e7          	jalr	-468(ra) # 80002ff6 <exit>

  // give up the CPU if this is a timer interrupt.
  if(which_dev == 2){
    800041d2:	fdc42783          	lw	a5,-36(s0)
    800041d6:	0007871b          	sext.w	a4,a5
    800041da:	4789                	li	a5,2
    800041dc:	00f71a63          	bne	a4,a5,800041f0 <usertrap+0x150>
    //TODO: mp3
    handle_timer_intr();
    800041e0:	00000097          	auipc	ra,0x0
    800041e4:	99e080e7          	jalr	-1634(ra) # 80003b7e <handle_timer_intr>
    yield();
    800041e8:	fffff097          	auipc	ra,0xfffff
    800041ec:	2b2080e7          	jalr	690(ra) # 8000349a <yield>
  }
  usertrapret();
    800041f0:	00000097          	auipc	ra,0x0
    800041f4:	014080e7          	jalr	20(ra) # 80004204 <usertrapret>
}
    800041f8:	0001                	nop
    800041fa:	70a2                	ld	ra,40(sp)
    800041fc:	7402                	ld	s0,32(sp)
    800041fe:	64e2                	ld	s1,24(sp)
    80004200:	6145                	addi	sp,sp,48
    80004202:	8082                	ret

0000000080004204 <usertrapret>:
//
// return to user space
//
void
usertrapret(void)
{
    80004204:	715d                	addi	sp,sp,-80
    80004206:	e486                	sd	ra,72(sp)
    80004208:	e0a2                	sd	s0,64(sp)
    8000420a:	fc26                	sd	s1,56(sp)
    8000420c:	0880                	addi	s0,sp,80
  struct proc *p = myproc();
    8000420e:	ffffe097          	auipc	ra,0xffffe
    80004212:	5ea080e7          	jalr	1514(ra) # 800027f8 <myproc>
    80004216:	fca43c23          	sd	a0,-40(s0)

  // we're about to switch the destination of traps from
  // kerneltrap() to usertrap(), so turn off interrupts until
  // we're back in user space, where usertrap() is correct.
  intr_off();
    8000421a:	00000097          	auipc	ra,0x0
    8000421e:	8a8080e7          	jalr	-1880(ra) # 80003ac2 <intr_off>

  // send syscalls, interrupts, and exceptions to trampoline.S
  w_stvec(TRAMPOLINE + (uservec - trampoline));
    80004222:	00007717          	auipc	a4,0x7
    80004226:	dde70713          	addi	a4,a4,-546 # 8000b000 <_trampoline>
    8000422a:	00007797          	auipc	a5,0x7
    8000422e:	dd678793          	addi	a5,a5,-554 # 8000b000 <_trampoline>
    80004232:	8f1d                	sub	a4,a4,a5
    80004234:	040007b7          	lui	a5,0x4000
    80004238:	17fd                	addi	a5,a5,-1
    8000423a:	07b2                	slli	a5,a5,0xc
    8000423c:	97ba                	add	a5,a5,a4
    8000423e:	853e                	mv	a0,a5
    80004240:	fffff097          	auipc	ra,0xfffff
    80004244:	7f0080e7          	jalr	2032(ra) # 80003a30 <w_stvec>

  // set up trapframe values that uservec will need when
  // the process next re-enters the kernel.
  p->trapframe->kernel_satp = r_satp();         // kernel page table
    80004248:	fd843703          	ld	a4,-40(s0)
    8000424c:	6785                	lui	a5,0x1
    8000424e:	97ba                	add	a5,a5,a4
    80004250:	2b87b483          	ld	s1,696(a5) # 12b8 <_entry-0x7fffed48>
    80004254:	fffff097          	auipc	ra,0xfffff
    80004258:	7f6080e7          	jalr	2038(ra) # 80003a4a <r_satp>
    8000425c:	87aa                	mv	a5,a0
    8000425e:	e09c                	sd	a5,0(s1)
  p->trapframe->kernel_sp = p->kstack + PGSIZE; // process's kernel stack
    80004260:	fd843703          	ld	a4,-40(s0)
    80004264:	6785                	lui	a5,0x1
    80004266:	97ba                	add	a5,a5,a4
    80004268:	2a07b683          	ld	a3,672(a5) # 12a0 <_entry-0x7fffed60>
    8000426c:	fd843703          	ld	a4,-40(s0)
    80004270:	6785                	lui	a5,0x1
    80004272:	97ba                	add	a5,a5,a4
    80004274:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80004278:	6705                	lui	a4,0x1
    8000427a:	9736                	add	a4,a4,a3
    8000427c:	e798                	sd	a4,8(a5)
  p->trapframe->kernel_trap = (uint64)usertrap;
    8000427e:	fd843703          	ld	a4,-40(s0)
    80004282:	6785                	lui	a5,0x1
    80004284:	97ba                	add	a5,a5,a4
    80004286:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    8000428a:	00000717          	auipc	a4,0x0
    8000428e:	e1670713          	addi	a4,a4,-490 # 800040a0 <usertrap>
    80004292:	eb98                	sd	a4,16(a5)
  p->trapframe->kernel_hartid = r_tp();         // hartid for cpuid()
    80004294:	fd843703          	ld	a4,-40(s0)
    80004298:	6785                	lui	a5,0x1
    8000429a:	97ba                	add	a5,a5,a4
    8000429c:	2b87b483          	ld	s1,696(a5) # 12b8 <_entry-0x7fffed48>
    800042a0:	00000097          	auipc	ra,0x0
    800042a4:	878080e7          	jalr	-1928(ra) # 80003b18 <r_tp>
    800042a8:	87aa                	mv	a5,a0
    800042aa:	f09c                	sd	a5,32(s1)

  // mp3
  int which_dev;
  if(p->timer_elapsed == 0 && (which_dev = devintr()) == 2){
    800042ac:	fd843783          	ld	a5,-40(s0)
    800042b0:	5fdc                	lw	a5,60(a5)
    800042b2:	eb95                	bnez	a5,800042e6 <usertrapret+0xe2>
    800042b4:	00000097          	auipc	ra,0x0
    800042b8:	25c080e7          	jalr	604(ra) # 80004510 <devintr>
    800042bc:	87aa                	mv	a5,a0
    800042be:	fcf42a23          	sw	a5,-44(s0)
    800042c2:	fd442783          	lw	a5,-44(s0)
    800042c6:	0007871b          	sext.w	a4,a5
    800042ca:	4789                	li	a5,2
    800042cc:	00f71d63          	bne	a4,a5,800042e6 <usertrapret+0xe2>
    p->trapframe->a0 = (uint64)p->handler_arg;
    800042d0:	fd843783          	ld	a5,-40(s0)
    800042d4:	6bb4                	ld	a3,80(a5)
    800042d6:	fd843703          	ld	a4,-40(s0)
    800042da:	6785                	lui	a5,0x1
    800042dc:	97ba                	add	a5,a5,a4
    800042de:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    800042e2:	8736                	mv	a4,a3
    800042e4:	fbb8                	sd	a4,112(a5)

  // set up the registers that trampoline.S's sret will use
  // to get to user space.
  
  // set S Previous Privilege mode to User.
  unsigned long x = r_sstatus();
    800042e6:	fffff097          	auipc	ra,0xfffff
    800042ea:	6ae080e7          	jalr	1710(ra) # 80003994 <r_sstatus>
    800042ee:	fca43423          	sd	a0,-56(s0)
  x &= ~SSTATUS_SPP; // clear SPP to 0 for user mode
    800042f2:	fc843783          	ld	a5,-56(s0)
    800042f6:	eff7f793          	andi	a5,a5,-257
    800042fa:	fcf43423          	sd	a5,-56(s0)
  x |= SSTATUS_SPIE; // enable interrupts in user mode
    800042fe:	fc843783          	ld	a5,-56(s0)
    80004302:	0207e793          	ori	a5,a5,32
    80004306:	fcf43423          	sd	a5,-56(s0)
  w_sstatus(x);
    8000430a:	fc843503          	ld	a0,-56(s0)
    8000430e:	fffff097          	auipc	ra,0xfffff
    80004312:	6a0080e7          	jalr	1696(ra) # 800039ae <w_sstatus>

  // set S Exception Program Counter to the saved user pc.
  w_sepc(p->trapframe->epc);
    80004316:	fd843703          	ld	a4,-40(s0)
    8000431a:	6785                	lui	a5,0x1
    8000431c:	97ba                	add	a5,a5,a4
    8000431e:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80004322:	6f9c                	ld	a5,24(a5)
    80004324:	853e                	mv	a0,a5
    80004326:	fffff097          	auipc	ra,0xfffff
    8000432a:	6d6080e7          	jalr	1750(ra) # 800039fc <w_sepc>

  // tell trampoline.S the user page table to switch to.
  uint64 satp = MAKE_SATP(p->pagetable);
    8000432e:	fd843703          	ld	a4,-40(s0)
    80004332:	6785                	lui	a5,0x1
    80004334:	97ba                	add	a5,a5,a4
    80004336:	2b07b783          	ld	a5,688(a5) # 12b0 <_entry-0x7fffed50>
    8000433a:	00c7d713          	srli	a4,a5,0xc
    8000433e:	57fd                	li	a5,-1
    80004340:	17fe                	slli	a5,a5,0x3f
    80004342:	8fd9                	or	a5,a5,a4
    80004344:	fcf43023          	sd	a5,-64(s0)
  // jump to trampoline.S at the top of memory, which 
  // switches to the user page table, restores user registers,
  // and switches to user mode with sret.
  uint64 fn = TRAMPOLINE + (userret - trampoline);
    80004348:	00007717          	auipc	a4,0x7
    8000434c:	d4870713          	addi	a4,a4,-696 # 8000b090 <userret>
    80004350:	00007797          	auipc	a5,0x7
    80004354:	cb078793          	addi	a5,a5,-848 # 8000b000 <_trampoline>
    80004358:	8f1d                	sub	a4,a4,a5
    8000435a:	040007b7          	lui	a5,0x4000
    8000435e:	17fd                	addi	a5,a5,-1
    80004360:	07b2                	slli	a5,a5,0xc
    80004362:	97ba                	add	a5,a5,a4
    80004364:	faf43c23          	sd	a5,-72(s0)
  
  ((void (*)(uint64,uint64))fn)(TRAPFRAME, satp);
    80004368:	fb843703          	ld	a4,-72(s0)
    8000436c:	fc043583          	ld	a1,-64(s0)
    80004370:	020007b7          	lui	a5,0x2000
    80004374:	17fd                	addi	a5,a5,-1
    80004376:	00d79513          	slli	a0,a5,0xd
    8000437a:	9702                	jalr	a4
}
    8000437c:	0001                	nop
    8000437e:	60a6                	ld	ra,72(sp)
    80004380:	6406                	ld	s0,64(sp)
    80004382:	74e2                	ld	s1,56(sp)
    80004384:	6161                	addi	sp,sp,80
    80004386:	8082                	ret

0000000080004388 <kerneltrap>:

// interrupts and exceptions from kernel code go here via kernelvec,
// on whatever the current kernel stack is.
void 
kerneltrap()
{
    80004388:	7139                	addi	sp,sp,-64
    8000438a:	fc06                	sd	ra,56(sp)
    8000438c:	f822                	sd	s0,48(sp)
    8000438e:	f426                	sd	s1,40(sp)
    80004390:	0080                	addi	s0,sp,64
  int which_dev = 0;
    80004392:	fc042e23          	sw	zero,-36(s0)
  uint64 sepc = r_sepc();
    80004396:	fffff097          	auipc	ra,0xfffff
    8000439a:	680080e7          	jalr	1664(ra) # 80003a16 <r_sepc>
    8000439e:	fca43823          	sd	a0,-48(s0)
  uint64 sstatus = r_sstatus();
    800043a2:	fffff097          	auipc	ra,0xfffff
    800043a6:	5f2080e7          	jalr	1522(ra) # 80003994 <r_sstatus>
    800043aa:	fca43423          	sd	a0,-56(s0)
  uint64 scause = r_scause();
    800043ae:	fffff097          	auipc	ra,0xfffff
    800043b2:	6b6080e7          	jalr	1718(ra) # 80003a64 <r_scause>
    800043b6:	fca43023          	sd	a0,-64(s0)
  
  if((sstatus & SSTATUS_SPP) == 0)
    800043ba:	fc843783          	ld	a5,-56(s0)
    800043be:	1007f793          	andi	a5,a5,256
    800043c2:	eb89                	bnez	a5,800043d4 <kerneltrap+0x4c>
    panic("kerneltrap: not from supervisor mode");
    800043c4:	00008517          	auipc	a0,0x8
    800043c8:	f4c50513          	addi	a0,a0,-180 # 8000c310 <etext+0x310>
    800043cc:	ffffd097          	auipc	ra,0xffffd
    800043d0:	886080e7          	jalr	-1914(ra) # 80000c52 <panic>
  if(intr_get() != 0)
    800043d4:	fffff097          	auipc	ra,0xfffff
    800043d8:	716080e7          	jalr	1814(ra) # 80003aea <intr_get>
    800043dc:	87aa                	mv	a5,a0
    800043de:	cb89                	beqz	a5,800043f0 <kerneltrap+0x68>
    panic("kerneltrap: interrupts enabled");
    800043e0:	00008517          	auipc	a0,0x8
    800043e4:	f5850513          	addi	a0,a0,-168 # 8000c338 <etext+0x338>
    800043e8:	ffffd097          	auipc	ra,0xffffd
    800043ec:	86a080e7          	jalr	-1942(ra) # 80000c52 <panic>

  if((which_dev = devintr()) == 0){
    800043f0:	00000097          	auipc	ra,0x0
    800043f4:	120080e7          	jalr	288(ra) # 80004510 <devintr>
    800043f8:	87aa                	mv	a5,a0
    800043fa:	fcf42e23          	sw	a5,-36(s0)
    800043fe:	fdc42783          	lw	a5,-36(s0)
    80004402:	2781                	sext.w	a5,a5
    80004404:	e7b9                	bnez	a5,80004452 <kerneltrap+0xca>
    printf("scause %p\n", scause);
    80004406:	fc043583          	ld	a1,-64(s0)
    8000440a:	00008517          	auipc	a0,0x8
    8000440e:	f4e50513          	addi	a0,a0,-178 # 8000c358 <etext+0x358>
    80004412:	ffffc097          	auipc	ra,0xffffc
    80004416:	5ea080e7          	jalr	1514(ra) # 800009fc <printf>
    printf("sepc=%p stval=%p\n", r_sepc(), r_stval());
    8000441a:	fffff097          	auipc	ra,0xfffff
    8000441e:	5fc080e7          	jalr	1532(ra) # 80003a16 <r_sepc>
    80004422:	84aa                	mv	s1,a0
    80004424:	fffff097          	auipc	ra,0xfffff
    80004428:	65a080e7          	jalr	1626(ra) # 80003a7e <r_stval>
    8000442c:	87aa                	mv	a5,a0
    8000442e:	863e                	mv	a2,a5
    80004430:	85a6                	mv	a1,s1
    80004432:	00008517          	auipc	a0,0x8
    80004436:	f3650513          	addi	a0,a0,-202 # 8000c368 <etext+0x368>
    8000443a:	ffffc097          	auipc	ra,0xffffc
    8000443e:	5c2080e7          	jalr	1474(ra) # 800009fc <printf>
    panic("kerneltrap");
    80004442:	00008517          	auipc	a0,0x8
    80004446:	f3e50513          	addi	a0,a0,-194 # 8000c380 <etext+0x380>
    8000444a:	ffffd097          	auipc	ra,0xffffd
    8000444e:	808080e7          	jalr	-2040(ra) # 80000c52 <panic>
  }

  // give up the CPU if this is a timer interrupt.
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING){
    80004452:	fdc42783          	lw	a5,-36(s0)
    80004456:	0007871b          	sext.w	a4,a5
    8000445a:	4789                	li	a5,2
    8000445c:	02f71a63          	bne	a4,a5,80004490 <kerneltrap+0x108>
    80004460:	ffffe097          	auipc	ra,0xffffe
    80004464:	398080e7          	jalr	920(ra) # 800027f8 <myproc>
    80004468:	87aa                	mv	a5,a0
    8000446a:	c39d                	beqz	a5,80004490 <kerneltrap+0x108>
    8000446c:	ffffe097          	auipc	ra,0xffffe
    80004470:	38c080e7          	jalr	908(ra) # 800027f8 <myproc>
    80004474:	87aa                	mv	a5,a0
    80004476:	4f9c                	lw	a5,24(a5)
    80004478:	873e                	mv	a4,a5
    8000447a:	478d                	li	a5,3
    8000447c:	00f71a63          	bne	a4,a5,80004490 <kerneltrap+0x108>
    //TODO: mp3
    handle_timer_intr();
    80004480:	fffff097          	auipc	ra,0xfffff
    80004484:	6fe080e7          	jalr	1790(ra) # 80003b7e <handle_timer_intr>
    

    yield();
    80004488:	fffff097          	auipc	ra,0xfffff
    8000448c:	012080e7          	jalr	18(ra) # 8000349a <yield>
  }

  // the yield() may have caused some traps to occur,
  // so restore trap registers for use by kernelvec.S's sepc instruction.
  w_sepc(sepc);
    80004490:	fd043503          	ld	a0,-48(s0)
    80004494:	fffff097          	auipc	ra,0xfffff
    80004498:	568080e7          	jalr	1384(ra) # 800039fc <w_sepc>
  w_sstatus(sstatus);
    8000449c:	fc843503          	ld	a0,-56(s0)
    800044a0:	fffff097          	auipc	ra,0xfffff
    800044a4:	50e080e7          	jalr	1294(ra) # 800039ae <w_sstatus>

}
    800044a8:	0001                	nop
    800044aa:	70e2                	ld	ra,56(sp)
    800044ac:	7442                	ld	s0,48(sp)
    800044ae:	74a2                	ld	s1,40(sp)
    800044b0:	6121                	addi	sp,sp,64
    800044b2:	8082                	ret

00000000800044b4 <clockintr>:

void
clockintr()
{
    800044b4:	1141                	addi	sp,sp,-16
    800044b6:	e406                	sd	ra,8(sp)
    800044b8:	e022                	sd	s0,0(sp)
    800044ba:	0800                	addi	s0,sp,16
  acquire(&tickslock);
    800044bc:	00060517          	auipc	a0,0x60
    800044c0:	3f450513          	addi	a0,a0,1012 # 800648b0 <tickslock>
    800044c4:	ffffd097          	auipc	ra,0xffffd
    800044c8:	dbc080e7          	jalr	-580(ra) # 80001280 <acquire>
  ticks++;
    800044cc:	00009797          	auipc	a5,0x9
    800044d0:	b5478793          	addi	a5,a5,-1196 # 8000d020 <ticks>
    800044d4:	439c                	lw	a5,0(a5)
    800044d6:	2785                	addiw	a5,a5,1
    800044d8:	0007871b          	sext.w	a4,a5
    800044dc:	00009797          	auipc	a5,0x9
    800044e0:	b4478793          	addi	a5,a5,-1212 # 8000d020 <ticks>
    800044e4:	c398                	sw	a4,0(a5)
  wakeup(&ticks);
    800044e6:	00009517          	auipc	a0,0x9
    800044ea:	b3a50513          	addi	a0,a0,-1222 # 8000d020 <ticks>
    800044ee:	fffff097          	auipc	ra,0xfffff
    800044f2:	0da080e7          	jalr	218(ra) # 800035c8 <wakeup>
  release(&tickslock);
    800044f6:	00060517          	auipc	a0,0x60
    800044fa:	3ba50513          	addi	a0,a0,954 # 800648b0 <tickslock>
    800044fe:	ffffd097          	auipc	ra,0xffffd
    80004502:	de6080e7          	jalr	-538(ra) # 800012e4 <release>
}
    80004506:	0001                	nop
    80004508:	60a2                	ld	ra,8(sp)
    8000450a:	6402                	ld	s0,0(sp)
    8000450c:	0141                	addi	sp,sp,16
    8000450e:	8082                	ret

0000000080004510 <devintr>:
// returns 2 if timer interrupt,
// 1 if other device,
// 0 if not recognized.
int
devintr()
{
    80004510:	1101                	addi	sp,sp,-32
    80004512:	ec06                	sd	ra,24(sp)
    80004514:	e822                	sd	s0,16(sp)
    80004516:	1000                	addi	s0,sp,32
  uint64 scause = r_scause();
    80004518:	fffff097          	auipc	ra,0xfffff
    8000451c:	54c080e7          	jalr	1356(ra) # 80003a64 <r_scause>
    80004520:	fea43423          	sd	a0,-24(s0)

  if((scause & 0x8000000000000000L) &&
    80004524:	fe843783          	ld	a5,-24(s0)
    80004528:	0807d463          	bgez	a5,800045b0 <devintr+0xa0>
     (scause & 0xff) == 9){
    8000452c:	fe843783          	ld	a5,-24(s0)
    80004530:	0ff7f713          	andi	a4,a5,255
  if((scause & 0x8000000000000000L) &&
    80004534:	47a5                	li	a5,9
    80004536:	06f71d63          	bne	a4,a5,800045b0 <devintr+0xa0>
    // this is a supervisor external interrupt, via PLIC.

    // irq indicates which device interrupted.
    int irq = plic_claim();
    8000453a:	00005097          	auipc	ra,0x5
    8000453e:	b38080e7          	jalr	-1224(ra) # 80009072 <plic_claim>
    80004542:	87aa                	mv	a5,a0
    80004544:	fef42223          	sw	a5,-28(s0)

    if(irq == UART0_IRQ){
    80004548:	fe442783          	lw	a5,-28(s0)
    8000454c:	0007871b          	sext.w	a4,a5
    80004550:	47a9                	li	a5,10
    80004552:	00f71763          	bne	a4,a5,80004560 <devintr+0x50>
      uartintr();
    80004556:	ffffd097          	auipc	ra,0xffffd
    8000455a:	a32080e7          	jalr	-1486(ra) # 80000f88 <uartintr>
    8000455e:	a825                	j	80004596 <devintr+0x86>
    } else if(irq == VIRTIO0_IRQ){
    80004560:	fe442783          	lw	a5,-28(s0)
    80004564:	0007871b          	sext.w	a4,a5
    80004568:	4785                	li	a5,1
    8000456a:	00f71763          	bne	a4,a5,80004578 <devintr+0x68>
      virtio_disk_intr();
    8000456e:	00005097          	auipc	ra,0x5
    80004572:	418080e7          	jalr	1048(ra) # 80009986 <virtio_disk_intr>
    80004576:	a005                	j	80004596 <devintr+0x86>
    } else if(irq){
    80004578:	fe442783          	lw	a5,-28(s0)
    8000457c:	2781                	sext.w	a5,a5
    8000457e:	cf81                	beqz	a5,80004596 <devintr+0x86>
      printf("unexpected interrupt irq=%d\n", irq);
    80004580:	fe442783          	lw	a5,-28(s0)
    80004584:	85be                	mv	a1,a5
    80004586:	00008517          	auipc	a0,0x8
    8000458a:	e0a50513          	addi	a0,a0,-502 # 8000c390 <etext+0x390>
    8000458e:	ffffc097          	auipc	ra,0xffffc
    80004592:	46e080e7          	jalr	1134(ra) # 800009fc <printf>
    }

    // the PLIC allows each device to raise at most one
    // interrupt at a time; tell the PLIC the device is
    // now allowed to interrupt again.
    if(irq)
    80004596:	fe442783          	lw	a5,-28(s0)
    8000459a:	2781                	sext.w	a5,a5
    8000459c:	cb81                	beqz	a5,800045ac <devintr+0x9c>
      plic_complete(irq);
    8000459e:	fe442783          	lw	a5,-28(s0)
    800045a2:	853e                	mv	a0,a5
    800045a4:	00005097          	auipc	ra,0x5
    800045a8:	b0c080e7          	jalr	-1268(ra) # 800090b0 <plic_complete>

    return 1;
    800045ac:	4785                	li	a5,1
    800045ae:	a081                	j	800045ee <devintr+0xde>
  } else if(scause == 0x8000000000000001L){
    800045b0:	fe843703          	ld	a4,-24(s0)
    800045b4:	57fd                	li	a5,-1
    800045b6:	17fe                	slli	a5,a5,0x3f
    800045b8:	0785                	addi	a5,a5,1
    800045ba:	02f71963          	bne	a4,a5,800045ec <devintr+0xdc>
    // software interrupt from a machine-mode timer interrupt,
    // forwarded by timervec in kernelvec.S.

    if(cpuid() == 0){
    800045be:	ffffe097          	auipc	ra,0xffffe
    800045c2:	1dc080e7          	jalr	476(ra) # 8000279a <cpuid>
    800045c6:	87aa                	mv	a5,a0
    800045c8:	e789                	bnez	a5,800045d2 <devintr+0xc2>
      clockintr();
    800045ca:	00000097          	auipc	ra,0x0
    800045ce:	eea080e7          	jalr	-278(ra) # 800044b4 <clockintr>
    }
    
    // acknowledge the software interrupt by clearing
    // the SSIP bit in sip.
    w_sip(r_sip() & ~2);
    800045d2:	fffff097          	auipc	ra,0xfffff
    800045d6:	3f6080e7          	jalr	1014(ra) # 800039c8 <r_sip>
    800045da:	87aa                	mv	a5,a0
    800045dc:	9bf5                	andi	a5,a5,-3
    800045de:	853e                	mv	a0,a5
    800045e0:	fffff097          	auipc	ra,0xfffff
    800045e4:	402080e7          	jalr	1026(ra) # 800039e2 <w_sip>

    return 2;
    800045e8:	4789                	li	a5,2
    800045ea:	a011                	j	800045ee <devintr+0xde>
  } else {
    return 0;
    800045ec:	4781                	li	a5,0
  }
}
    800045ee:	853e                	mv	a0,a5
    800045f0:	60e2                	ld	ra,24(sp)
    800045f2:	6442                	ld	s0,16(sp)
    800045f4:	6105                	addi	sp,sp,32
    800045f6:	8082                	ret

00000000800045f8 <fetchaddr>:
#include "defs.h"

// Fetch the uint64 at addr from the current process.
int
fetchaddr(uint64 addr, uint64 *ip)
{
    800045f8:	7179                	addi	sp,sp,-48
    800045fa:	f406                	sd	ra,40(sp)
    800045fc:	f022                	sd	s0,32(sp)
    800045fe:	1800                	addi	s0,sp,48
    80004600:	fca43c23          	sd	a0,-40(s0)
    80004604:	fcb43823          	sd	a1,-48(s0)
  struct proc *p = myproc();
    80004608:	ffffe097          	auipc	ra,0xffffe
    8000460c:	1f0080e7          	jalr	496(ra) # 800027f8 <myproc>
    80004610:	fea43423          	sd	a0,-24(s0)
  if(addr >= p->sz || addr+sizeof(uint64) > p->sz)
    80004614:	fe843703          	ld	a4,-24(s0)
    80004618:	6785                	lui	a5,0x1
    8000461a:	97ba                	add	a5,a5,a4
    8000461c:	2a87b783          	ld	a5,680(a5) # 12a8 <_entry-0x7fffed58>
    80004620:	fd843703          	ld	a4,-40(s0)
    80004624:	00f77e63          	bgeu	a4,a5,80004640 <fetchaddr+0x48>
    80004628:	fd843783          	ld	a5,-40(s0)
    8000462c:	00878713          	addi	a4,a5,8
    80004630:	fe843683          	ld	a3,-24(s0)
    80004634:	6785                	lui	a5,0x1
    80004636:	97b6                	add	a5,a5,a3
    80004638:	2a87b783          	ld	a5,680(a5) # 12a8 <_entry-0x7fffed58>
    8000463c:	00e7f463          	bgeu	a5,a4,80004644 <fetchaddr+0x4c>
    return -1;
    80004640:	57fd                	li	a5,-1
    80004642:	a035                	j	8000466e <fetchaddr+0x76>
  if(copyin(p->pagetable, (char *)ip, addr, sizeof(*ip)) != 0)
    80004644:	fe843703          	ld	a4,-24(s0)
    80004648:	6785                	lui	a5,0x1
    8000464a:	97ba                	add	a5,a5,a4
    8000464c:	2b07b783          	ld	a5,688(a5) # 12b0 <_entry-0x7fffed50>
    80004650:	46a1                	li	a3,8
    80004652:	fd843603          	ld	a2,-40(s0)
    80004656:	fd043583          	ld	a1,-48(s0)
    8000465a:	853e                	mv	a0,a5
    8000465c:	ffffe097          	auipc	ra,0xffffe
    80004660:	d46080e7          	jalr	-698(ra) # 800023a2 <copyin>
    80004664:	87aa                	mv	a5,a0
    80004666:	c399                	beqz	a5,8000466c <fetchaddr+0x74>
    return -1;
    80004668:	57fd                	li	a5,-1
    8000466a:	a011                	j	8000466e <fetchaddr+0x76>
  return 0;
    8000466c:	4781                	li	a5,0
}
    8000466e:	853e                	mv	a0,a5
    80004670:	70a2                	ld	ra,40(sp)
    80004672:	7402                	ld	s0,32(sp)
    80004674:	6145                	addi	sp,sp,48
    80004676:	8082                	ret

0000000080004678 <fetchstr>:

// Fetch the nul-terminated string at addr from the current process.
// Returns length of string, not including nul, or -1 for error.
int
fetchstr(uint64 addr, char *buf, int max)
{
    80004678:	7139                	addi	sp,sp,-64
    8000467a:	fc06                	sd	ra,56(sp)
    8000467c:	f822                	sd	s0,48(sp)
    8000467e:	0080                	addi	s0,sp,64
    80004680:	fca43c23          	sd	a0,-40(s0)
    80004684:	fcb43823          	sd	a1,-48(s0)
    80004688:	87b2                	mv	a5,a2
    8000468a:	fcf42623          	sw	a5,-52(s0)
  struct proc *p = myproc();
    8000468e:	ffffe097          	auipc	ra,0xffffe
    80004692:	16a080e7          	jalr	362(ra) # 800027f8 <myproc>
    80004696:	fea43423          	sd	a0,-24(s0)
  int err = copyinstr(p->pagetable, buf, addr, max);
    8000469a:	fe843703          	ld	a4,-24(s0)
    8000469e:	6785                	lui	a5,0x1
    800046a0:	97ba                	add	a5,a5,a4
    800046a2:	2b07b783          	ld	a5,688(a5) # 12b0 <_entry-0x7fffed50>
    800046a6:	fcc42703          	lw	a4,-52(s0)
    800046aa:	86ba                	mv	a3,a4
    800046ac:	fd843603          	ld	a2,-40(s0)
    800046b0:	fd043583          	ld	a1,-48(s0)
    800046b4:	853e                	mv	a0,a5
    800046b6:	ffffe097          	auipc	ra,0xffffe
    800046ba:	dba080e7          	jalr	-582(ra) # 80002470 <copyinstr>
    800046be:	87aa                	mv	a5,a0
    800046c0:	fef42223          	sw	a5,-28(s0)
  if(err < 0)
    800046c4:	fe442783          	lw	a5,-28(s0)
    800046c8:	2781                	sext.w	a5,a5
    800046ca:	0007d563          	bgez	a5,800046d4 <fetchstr+0x5c>
    return err;
    800046ce:	fe442783          	lw	a5,-28(s0)
    800046d2:	a801                	j	800046e2 <fetchstr+0x6a>
  return strlen(buf);
    800046d4:	fd043503          	ld	a0,-48(s0)
    800046d8:	ffffd097          	auipc	ra,0xffffd
    800046dc:	0ec080e7          	jalr	236(ra) # 800017c4 <strlen>
    800046e0:	87aa                	mv	a5,a0
}
    800046e2:	853e                	mv	a0,a5
    800046e4:	70e2                	ld	ra,56(sp)
    800046e6:	7442                	ld	s0,48(sp)
    800046e8:	6121                	addi	sp,sp,64
    800046ea:	8082                	ret

00000000800046ec <argraw>:

static uint64
argraw(int n)
{
    800046ec:	7179                	addi	sp,sp,-48
    800046ee:	f406                	sd	ra,40(sp)
    800046f0:	f022                	sd	s0,32(sp)
    800046f2:	1800                	addi	s0,sp,48
    800046f4:	87aa                	mv	a5,a0
    800046f6:	fcf42e23          	sw	a5,-36(s0)
  struct proc *p = myproc();
    800046fa:	ffffe097          	auipc	ra,0xffffe
    800046fe:	0fe080e7          	jalr	254(ra) # 800027f8 <myproc>
    80004702:	fea43423          	sd	a0,-24(s0)
    80004706:	fdc42783          	lw	a5,-36(s0)
    8000470a:	0007871b          	sext.w	a4,a5
    8000470e:	4795                	li	a5,5
    80004710:	08e7e463          	bltu	a5,a4,80004798 <argraw+0xac>
    80004714:	fdc46783          	lwu	a5,-36(s0)
    80004718:	00279713          	slli	a4,a5,0x2
    8000471c:	00008797          	auipc	a5,0x8
    80004720:	c9c78793          	addi	a5,a5,-868 # 8000c3b8 <etext+0x3b8>
    80004724:	97ba                	add	a5,a5,a4
    80004726:	439c                	lw	a5,0(a5)
    80004728:	0007871b          	sext.w	a4,a5
    8000472c:	00008797          	auipc	a5,0x8
    80004730:	c8c78793          	addi	a5,a5,-884 # 8000c3b8 <etext+0x3b8>
    80004734:	97ba                	add	a5,a5,a4
    80004736:	8782                	jr	a5
  switch (n) {
  case 0:
    return p->trapframe->a0;
    80004738:	fe843703          	ld	a4,-24(s0)
    8000473c:	6785                	lui	a5,0x1
    8000473e:	97ba                	add	a5,a5,a4
    80004740:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80004744:	7bbc                	ld	a5,112(a5)
    80004746:	a08d                	j	800047a8 <argraw+0xbc>
  case 1:
    return p->trapframe->a1;
    80004748:	fe843703          	ld	a4,-24(s0)
    8000474c:	6785                	lui	a5,0x1
    8000474e:	97ba                	add	a5,a5,a4
    80004750:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80004754:	7fbc                	ld	a5,120(a5)
    80004756:	a889                	j	800047a8 <argraw+0xbc>
  case 2:
    return p->trapframe->a2;
    80004758:	fe843703          	ld	a4,-24(s0)
    8000475c:	6785                	lui	a5,0x1
    8000475e:	97ba                	add	a5,a5,a4
    80004760:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80004764:	63dc                	ld	a5,128(a5)
    80004766:	a089                	j	800047a8 <argraw+0xbc>
  case 3:
    return p->trapframe->a3;
    80004768:	fe843703          	ld	a4,-24(s0)
    8000476c:	6785                	lui	a5,0x1
    8000476e:	97ba                	add	a5,a5,a4
    80004770:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80004774:	67dc                	ld	a5,136(a5)
    80004776:	a80d                	j	800047a8 <argraw+0xbc>
  case 4:
    return p->trapframe->a4;
    80004778:	fe843703          	ld	a4,-24(s0)
    8000477c:	6785                	lui	a5,0x1
    8000477e:	97ba                	add	a5,a5,a4
    80004780:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80004784:	6bdc                	ld	a5,144(a5)
    80004786:	a00d                	j	800047a8 <argraw+0xbc>
  case 5:
    return p->trapframe->a5;
    80004788:	fe843703          	ld	a4,-24(s0)
    8000478c:	6785                	lui	a5,0x1
    8000478e:	97ba                	add	a5,a5,a4
    80004790:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80004794:	6fdc                	ld	a5,152(a5)
    80004796:	a809                	j	800047a8 <argraw+0xbc>
  }
  panic("argraw");
    80004798:	00008517          	auipc	a0,0x8
    8000479c:	c1850513          	addi	a0,a0,-1000 # 8000c3b0 <etext+0x3b0>
    800047a0:	ffffc097          	auipc	ra,0xffffc
    800047a4:	4b2080e7          	jalr	1202(ra) # 80000c52 <panic>
  return -1;
}
    800047a8:	853e                	mv	a0,a5
    800047aa:	70a2                	ld	ra,40(sp)
    800047ac:	7402                	ld	s0,32(sp)
    800047ae:	6145                	addi	sp,sp,48
    800047b0:	8082                	ret

00000000800047b2 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
    800047b2:	1101                	addi	sp,sp,-32
    800047b4:	ec06                	sd	ra,24(sp)
    800047b6:	e822                	sd	s0,16(sp)
    800047b8:	1000                	addi	s0,sp,32
    800047ba:	87aa                	mv	a5,a0
    800047bc:	feb43023          	sd	a1,-32(s0)
    800047c0:	fef42623          	sw	a5,-20(s0)
  *ip = argraw(n);
    800047c4:	fec42783          	lw	a5,-20(s0)
    800047c8:	853e                	mv	a0,a5
    800047ca:	00000097          	auipc	ra,0x0
    800047ce:	f22080e7          	jalr	-222(ra) # 800046ec <argraw>
    800047d2:	87aa                	mv	a5,a0
    800047d4:	0007871b          	sext.w	a4,a5
    800047d8:	fe043783          	ld	a5,-32(s0)
    800047dc:	c398                	sw	a4,0(a5)
  return 0;
    800047de:	4781                	li	a5,0
}
    800047e0:	853e                	mv	a0,a5
    800047e2:	60e2                	ld	ra,24(sp)
    800047e4:	6442                	ld	s0,16(sp)
    800047e6:	6105                	addi	sp,sp,32
    800047e8:	8082                	ret

00000000800047ea <argaddr>:
// Retrieve an argument as a pointer.
// Doesn't check for legality, since
// copyin/copyout will do that.
int
argaddr(int n, uint64 *ip)
{
    800047ea:	1101                	addi	sp,sp,-32
    800047ec:	ec06                	sd	ra,24(sp)
    800047ee:	e822                	sd	s0,16(sp)
    800047f0:	1000                	addi	s0,sp,32
    800047f2:	87aa                	mv	a5,a0
    800047f4:	feb43023          	sd	a1,-32(s0)
    800047f8:	fef42623          	sw	a5,-20(s0)
  *ip = argraw(n);
    800047fc:	fec42783          	lw	a5,-20(s0)
    80004800:	853e                	mv	a0,a5
    80004802:	00000097          	auipc	ra,0x0
    80004806:	eea080e7          	jalr	-278(ra) # 800046ec <argraw>
    8000480a:	872a                	mv	a4,a0
    8000480c:	fe043783          	ld	a5,-32(s0)
    80004810:	e398                	sd	a4,0(a5)
  return 0;
    80004812:	4781                	li	a5,0
}
    80004814:	853e                	mv	a0,a5
    80004816:	60e2                	ld	ra,24(sp)
    80004818:	6442                	ld	s0,16(sp)
    8000481a:	6105                	addi	sp,sp,32
    8000481c:	8082                	ret

000000008000481e <argstr>:
// Fetch the nth word-sized system call argument as a null-terminated string.
// Copies into buf, at most max.
// Returns string length if OK (including nul), -1 if error.
int
argstr(int n, char *buf, int max)
{
    8000481e:	7179                	addi	sp,sp,-48
    80004820:	f406                	sd	ra,40(sp)
    80004822:	f022                	sd	s0,32(sp)
    80004824:	1800                	addi	s0,sp,48
    80004826:	87aa                	mv	a5,a0
    80004828:	fcb43823          	sd	a1,-48(s0)
    8000482c:	8732                	mv	a4,a2
    8000482e:	fcf42e23          	sw	a5,-36(s0)
    80004832:	87ba                	mv	a5,a4
    80004834:	fcf42c23          	sw	a5,-40(s0)
  uint64 addr;
  if(argaddr(n, &addr) < 0)
    80004838:	fe840713          	addi	a4,s0,-24
    8000483c:	fdc42783          	lw	a5,-36(s0)
    80004840:	85ba                	mv	a1,a4
    80004842:	853e                	mv	a0,a5
    80004844:	00000097          	auipc	ra,0x0
    80004848:	fa6080e7          	jalr	-90(ra) # 800047ea <argaddr>
    8000484c:	87aa                	mv	a5,a0
    8000484e:	0007d463          	bgez	a5,80004856 <argstr+0x38>
    return -1;
    80004852:	57fd                	li	a5,-1
    80004854:	a831                	j	80004870 <argstr+0x52>
  return fetchstr(addr, buf, max);
    80004856:	fe843783          	ld	a5,-24(s0)
    8000485a:	fd842703          	lw	a4,-40(s0)
    8000485e:	863a                	mv	a2,a4
    80004860:	fd043583          	ld	a1,-48(s0)
    80004864:	853e                	mv	a0,a5
    80004866:	00000097          	auipc	ra,0x0
    8000486a:	e12080e7          	jalr	-494(ra) # 80004678 <fetchstr>
    8000486e:	87aa                	mv	a5,a0
}
    80004870:	853e                	mv	a0,a5
    80004872:	70a2                	ld	ra,40(sp)
    80004874:	7402                	ld	s0,32(sp)
    80004876:	6145                	addi	sp,sp,48
    80004878:	8082                	ret

000000008000487a <syscall>:
[SYS_cancelthrdstop]   sys_cancelthrdstop,
};

void
syscall(void)
{
    8000487a:	7179                	addi	sp,sp,-48
    8000487c:	f406                	sd	ra,40(sp)
    8000487e:	f022                	sd	s0,32(sp)
    80004880:	ec26                	sd	s1,24(sp)
    80004882:	1800                	addi	s0,sp,48
  int num;
  struct proc *p = myproc();
    80004884:	ffffe097          	auipc	ra,0xffffe
    80004888:	f74080e7          	jalr	-140(ra) # 800027f8 <myproc>
    8000488c:	fca43c23          	sd	a0,-40(s0)

  num = p->trapframe->a7;
    80004890:	fd843703          	ld	a4,-40(s0)
    80004894:	6785                	lui	a5,0x1
    80004896:	97ba                	add	a5,a5,a4
    80004898:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    8000489c:	77dc                	ld	a5,168(a5)
    8000489e:	fcf42a23          	sw	a5,-44(s0)
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    800048a2:	fd442783          	lw	a5,-44(s0)
    800048a6:	2781                	sext.w	a5,a5
    800048a8:	04f05563          	blez	a5,800048f2 <syscall+0x78>
    800048ac:	fd442783          	lw	a5,-44(s0)
    800048b0:	873e                	mv	a4,a5
    800048b2:	47e1                	li	a5,24
    800048b4:	02e7ef63          	bltu	a5,a4,800048f2 <syscall+0x78>
    800048b8:	00008717          	auipc	a4,0x8
    800048bc:	f2070713          	addi	a4,a4,-224 # 8000c7d8 <syscalls>
    800048c0:	fd442783          	lw	a5,-44(s0)
    800048c4:	078e                	slli	a5,a5,0x3
    800048c6:	97ba                	add	a5,a5,a4
    800048c8:	639c                	ld	a5,0(a5)
    800048ca:	c785                	beqz	a5,800048f2 <syscall+0x78>
    p->trapframe->a0 = syscalls[num]();
    800048cc:	00008717          	auipc	a4,0x8
    800048d0:	f0c70713          	addi	a4,a4,-244 # 8000c7d8 <syscalls>
    800048d4:	fd442783          	lw	a5,-44(s0)
    800048d8:	078e                	slli	a5,a5,0x3
    800048da:	97ba                	add	a5,a5,a4
    800048dc:	6394                	ld	a3,0(a5)
    800048de:	fd843703          	ld	a4,-40(s0)
    800048e2:	6785                	lui	a5,0x1
    800048e4:	97ba                	add	a5,a5,a4
    800048e6:	2b87b483          	ld	s1,696(a5) # 12b8 <_entry-0x7fffed48>
    800048ea:	9682                	jalr	a3
    800048ec:	87aa                	mv	a5,a0
    800048ee:	f8bc                	sd	a5,112(s1)
    800048f0:	a83d                	j	8000492e <syscall+0xb4>
  } else {
    printf("%d %s: unknown sys call %d\n",
    800048f2:	fd843783          	ld	a5,-40(s0)
    800048f6:	5f8c                	lw	a1,56(a5)
            p->pid, p->name, num);
    800048f8:	fd843703          	ld	a4,-40(s0)
    800048fc:	6785                	lui	a5,0x1
    800048fe:	3b878793          	addi	a5,a5,952 # 13b8 <_entry-0x7fffec48>
    80004902:	97ba                	add	a5,a5,a4
    printf("%d %s: unknown sys call %d\n",
    80004904:	fd442703          	lw	a4,-44(s0)
    80004908:	86ba                	mv	a3,a4
    8000490a:	863e                	mv	a2,a5
    8000490c:	00008517          	auipc	a0,0x8
    80004910:	ac450513          	addi	a0,a0,-1340 # 8000c3d0 <etext+0x3d0>
    80004914:	ffffc097          	auipc	ra,0xffffc
    80004918:	0e8080e7          	jalr	232(ra) # 800009fc <printf>
    p->trapframe->a0 = -1;
    8000491c:	fd843703          	ld	a4,-40(s0)
    80004920:	6785                	lui	a5,0x1
    80004922:	97ba                	add	a5,a5,a4
    80004924:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80004928:	577d                	li	a4,-1
    8000492a:	fbb8                	sd	a4,112(a5)
  }
}
    8000492c:	0001                	nop
    8000492e:	0001                	nop
    80004930:	70a2                	ld	ra,40(sp)
    80004932:	7402                	ld	s0,32(sp)
    80004934:	64e2                	ld	s1,24(sp)
    80004936:	6145                	addi	sp,sp,48
    80004938:	8082                	ret

000000008000493a <sys_exit>:
#include "spinlock.h"
#include "proc.h"

uint64
sys_exit(void)
{
    8000493a:	1101                	addi	sp,sp,-32
    8000493c:	ec06                	sd	ra,24(sp)
    8000493e:	e822                	sd	s0,16(sp)
    80004940:	1000                	addi	s0,sp,32
  int n;
  if(argint(0, &n) < 0)
    80004942:	fec40793          	addi	a5,s0,-20
    80004946:	85be                	mv	a1,a5
    80004948:	4501                	li	a0,0
    8000494a:	00000097          	auipc	ra,0x0
    8000494e:	e68080e7          	jalr	-408(ra) # 800047b2 <argint>
    80004952:	87aa                	mv	a5,a0
    80004954:	0007d463          	bgez	a5,8000495c <sys_exit+0x22>
    return -1;
    80004958:	57fd                	li	a5,-1
    8000495a:	a809                	j	8000496c <sys_exit+0x32>
  exit(n);
    8000495c:	fec42783          	lw	a5,-20(s0)
    80004960:	853e                	mv	a0,a5
    80004962:	ffffe097          	auipc	ra,0xffffe
    80004966:	694080e7          	jalr	1684(ra) # 80002ff6 <exit>
  return 0;  // not reached
    8000496a:	4781                	li	a5,0
}
    8000496c:	853e                	mv	a0,a5
    8000496e:	60e2                	ld	ra,24(sp)
    80004970:	6442                	ld	s0,16(sp)
    80004972:	6105                	addi	sp,sp,32
    80004974:	8082                	ret

0000000080004976 <sys_getpid>:

uint64
sys_getpid(void)
{
    80004976:	1141                	addi	sp,sp,-16
    80004978:	e406                	sd	ra,8(sp)
    8000497a:	e022                	sd	s0,0(sp)
    8000497c:	0800                	addi	s0,sp,16
  return myproc()->pid;
    8000497e:	ffffe097          	auipc	ra,0xffffe
    80004982:	e7a080e7          	jalr	-390(ra) # 800027f8 <myproc>
    80004986:	87aa                	mv	a5,a0
    80004988:	5f9c                	lw	a5,56(a5)
}
    8000498a:	853e                	mv	a0,a5
    8000498c:	60a2                	ld	ra,8(sp)
    8000498e:	6402                	ld	s0,0(sp)
    80004990:	0141                	addi	sp,sp,16
    80004992:	8082                	ret

0000000080004994 <sys_fork>:

uint64
sys_fork(void)
{
    80004994:	1141                	addi	sp,sp,-16
    80004996:	e406                	sd	ra,8(sp)
    80004998:	e022                	sd	s0,0(sp)
    8000499a:	0800                	addi	s0,sp,16
  return fork();
    8000499c:	ffffe097          	auipc	ra,0xffffe
    800049a0:	422080e7          	jalr	1058(ra) # 80002dbe <fork>
    800049a4:	87aa                	mv	a5,a0
}
    800049a6:	853e                	mv	a0,a5
    800049a8:	60a2                	ld	ra,8(sp)
    800049aa:	6402                	ld	s0,0(sp)
    800049ac:	0141                	addi	sp,sp,16
    800049ae:	8082                	ret

00000000800049b0 <sys_wait>:

uint64
sys_wait(void)
{
    800049b0:	1101                	addi	sp,sp,-32
    800049b2:	ec06                	sd	ra,24(sp)
    800049b4:	e822                	sd	s0,16(sp)
    800049b6:	1000                	addi	s0,sp,32
  uint64 p;
  if(argaddr(0, &p) < 0)
    800049b8:	fe840793          	addi	a5,s0,-24
    800049bc:	85be                	mv	a1,a5
    800049be:	4501                	li	a0,0
    800049c0:	00000097          	auipc	ra,0x0
    800049c4:	e2a080e7          	jalr	-470(ra) # 800047ea <argaddr>
    800049c8:	87aa                	mv	a5,a0
    800049ca:	0007d463          	bgez	a5,800049d2 <sys_wait+0x22>
    return -1;
    800049ce:	57fd                	li	a5,-1
    800049d0:	a809                	j	800049e2 <sys_wait+0x32>
  return wait(p);
    800049d2:	fe843783          	ld	a5,-24(s0)
    800049d6:	853e                	mv	a0,a5
    800049d8:	ffffe097          	auipc	ra,0xffffe
    800049dc:	7c2080e7          	jalr	1986(ra) # 8000319a <wait>
    800049e0:	87aa                	mv	a5,a0
}
    800049e2:	853e                	mv	a0,a5
    800049e4:	60e2                	ld	ra,24(sp)
    800049e6:	6442                	ld	s0,16(sp)
    800049e8:	6105                	addi	sp,sp,32
    800049ea:	8082                	ret

00000000800049ec <sys_sbrk>:

uint64
sys_sbrk(void)
{
    800049ec:	1101                	addi	sp,sp,-32
    800049ee:	ec06                	sd	ra,24(sp)
    800049f0:	e822                	sd	s0,16(sp)
    800049f2:	1000                	addi	s0,sp,32
  int addr;
  int n;

  if(argint(0, &n) < 0)
    800049f4:	fe840793          	addi	a5,s0,-24
    800049f8:	85be                	mv	a1,a5
    800049fa:	4501                	li	a0,0
    800049fc:	00000097          	auipc	ra,0x0
    80004a00:	db6080e7          	jalr	-586(ra) # 800047b2 <argint>
    80004a04:	87aa                	mv	a5,a0
    80004a06:	0007d463          	bgez	a5,80004a0e <sys_sbrk+0x22>
    return -1;
    80004a0a:	57fd                	li	a5,-1
    80004a0c:	a815                	j	80004a40 <sys_sbrk+0x54>
  addr = myproc()->sz;
    80004a0e:	ffffe097          	auipc	ra,0xffffe
    80004a12:	dea080e7          	jalr	-534(ra) # 800027f8 <myproc>
    80004a16:	872a                	mv	a4,a0
    80004a18:	6785                	lui	a5,0x1
    80004a1a:	97ba                	add	a5,a5,a4
    80004a1c:	2a87b783          	ld	a5,680(a5) # 12a8 <_entry-0x7fffed58>
    80004a20:	fef42623          	sw	a5,-20(s0)
  if(growproc(n) < 0)
    80004a24:	fe842783          	lw	a5,-24(s0)
    80004a28:	853e                	mv	a0,a5
    80004a2a:	ffffe097          	auipc	ra,0xffffe
    80004a2e:	2ca080e7          	jalr	714(ra) # 80002cf4 <growproc>
    80004a32:	87aa                	mv	a5,a0
    80004a34:	0007d463          	bgez	a5,80004a3c <sys_sbrk+0x50>
    return -1;
    80004a38:	57fd                	li	a5,-1
    80004a3a:	a019                	j	80004a40 <sys_sbrk+0x54>
  return addr;
    80004a3c:	fec42783          	lw	a5,-20(s0)
}
    80004a40:	853e                	mv	a0,a5
    80004a42:	60e2                	ld	ra,24(sp)
    80004a44:	6442                	ld	s0,16(sp)
    80004a46:	6105                	addi	sp,sp,32
    80004a48:	8082                	ret

0000000080004a4a <sys_sleep>:

uint64
sys_sleep(void)
{
    80004a4a:	1101                	addi	sp,sp,-32
    80004a4c:	ec06                	sd	ra,24(sp)
    80004a4e:	e822                	sd	s0,16(sp)
    80004a50:	1000                	addi	s0,sp,32
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    80004a52:	fe840793          	addi	a5,s0,-24
    80004a56:	85be                	mv	a1,a5
    80004a58:	4501                	li	a0,0
    80004a5a:	00000097          	auipc	ra,0x0
    80004a5e:	d58080e7          	jalr	-680(ra) # 800047b2 <argint>
    80004a62:	87aa                	mv	a5,a0
    80004a64:	0007d463          	bgez	a5,80004a6c <sys_sleep+0x22>
    return -1;
    80004a68:	57fd                	li	a5,-1
    80004a6a:	a079                	j	80004af8 <sys_sleep+0xae>
  acquire(&tickslock);
    80004a6c:	00060517          	auipc	a0,0x60
    80004a70:	e4450513          	addi	a0,a0,-444 # 800648b0 <tickslock>
    80004a74:	ffffd097          	auipc	ra,0xffffd
    80004a78:	80c080e7          	jalr	-2036(ra) # 80001280 <acquire>
  ticks0 = ticks;
    80004a7c:	00008797          	auipc	a5,0x8
    80004a80:	5a478793          	addi	a5,a5,1444 # 8000d020 <ticks>
    80004a84:	439c                	lw	a5,0(a5)
    80004a86:	fef42623          	sw	a5,-20(s0)
  while(ticks - ticks0 < n){
    80004a8a:	a835                	j	80004ac6 <sys_sleep+0x7c>
    if(myproc()->killed){
    80004a8c:	ffffe097          	auipc	ra,0xffffe
    80004a90:	d6c080e7          	jalr	-660(ra) # 800027f8 <myproc>
    80004a94:	87aa                	mv	a5,a0
    80004a96:	5b9c                	lw	a5,48(a5)
    80004a98:	cb99                	beqz	a5,80004aae <sys_sleep+0x64>
      release(&tickslock);
    80004a9a:	00060517          	auipc	a0,0x60
    80004a9e:	e1650513          	addi	a0,a0,-490 # 800648b0 <tickslock>
    80004aa2:	ffffd097          	auipc	ra,0xffffd
    80004aa6:	842080e7          	jalr	-1982(ra) # 800012e4 <release>
      return -1;
    80004aaa:	57fd                	li	a5,-1
    80004aac:	a0b1                	j	80004af8 <sys_sleep+0xae>
    }
    sleep(&ticks, &tickslock);
    80004aae:	00060597          	auipc	a1,0x60
    80004ab2:	e0258593          	addi	a1,a1,-510 # 800648b0 <tickslock>
    80004ab6:	00008517          	auipc	a0,0x8
    80004aba:	56a50513          	addi	a0,a0,1386 # 8000d020 <ticks>
    80004abe:	fffff097          	auipc	ra,0xfffff
    80004ac2:	a76080e7          	jalr	-1418(ra) # 80003534 <sleep>
  while(ticks - ticks0 < n){
    80004ac6:	00008797          	auipc	a5,0x8
    80004aca:	55a78793          	addi	a5,a5,1370 # 8000d020 <ticks>
    80004ace:	4398                	lw	a4,0(a5)
    80004ad0:	fec42783          	lw	a5,-20(s0)
    80004ad4:	40f707bb          	subw	a5,a4,a5
    80004ad8:	0007871b          	sext.w	a4,a5
    80004adc:	fe842783          	lw	a5,-24(s0)
    80004ae0:	2781                	sext.w	a5,a5
    80004ae2:	faf765e3          	bltu	a4,a5,80004a8c <sys_sleep+0x42>
  }
  release(&tickslock);
    80004ae6:	00060517          	auipc	a0,0x60
    80004aea:	dca50513          	addi	a0,a0,-566 # 800648b0 <tickslock>
    80004aee:	ffffc097          	auipc	ra,0xffffc
    80004af2:	7f6080e7          	jalr	2038(ra) # 800012e4 <release>
  return 0;
    80004af6:	4781                	li	a5,0
}
    80004af8:	853e                	mv	a0,a5
    80004afa:	60e2                	ld	ra,24(sp)
    80004afc:	6442                	ld	s0,16(sp)
    80004afe:	6105                	addi	sp,sp,32
    80004b00:	8082                	ret

0000000080004b02 <sys_kill>:

uint64
sys_kill(void)
{
    80004b02:	1101                	addi	sp,sp,-32
    80004b04:	ec06                	sd	ra,24(sp)
    80004b06:	e822                	sd	s0,16(sp)
    80004b08:	1000                	addi	s0,sp,32
  int pid;

  if(argint(0, &pid) < 0)
    80004b0a:	fec40793          	addi	a5,s0,-20
    80004b0e:	85be                	mv	a1,a5
    80004b10:	4501                	li	a0,0
    80004b12:	00000097          	auipc	ra,0x0
    80004b16:	ca0080e7          	jalr	-864(ra) # 800047b2 <argint>
    80004b1a:	87aa                	mv	a5,a0
    80004b1c:	0007d463          	bgez	a5,80004b24 <sys_kill+0x22>
    return -1;
    80004b20:	57fd                	li	a5,-1
    80004b22:	a809                	j	80004b34 <sys_kill+0x32>
  return kill(pid);
    80004b24:	fec42783          	lw	a5,-20(s0)
    80004b28:	853e                	mv	a0,a5
    80004b2a:	fffff097          	auipc	ra,0xfffff
    80004b2e:	b80080e7          	jalr	-1152(ra) # 800036aa <kill>
    80004b32:	87aa                	mv	a5,a0
}
    80004b34:	853e                	mv	a0,a5
    80004b36:	60e2                	ld	ra,24(sp)
    80004b38:	6442                	ld	s0,16(sp)
    80004b3a:	6105                	addi	sp,sp,32
    80004b3c:	8082                	ret

0000000080004b3e <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
    80004b3e:	1101                	addi	sp,sp,-32
    80004b40:	ec06                	sd	ra,24(sp)
    80004b42:	e822                	sd	s0,16(sp)
    80004b44:	1000                	addi	s0,sp,32
  uint xticks;

  acquire(&tickslock);
    80004b46:	00060517          	auipc	a0,0x60
    80004b4a:	d6a50513          	addi	a0,a0,-662 # 800648b0 <tickslock>
    80004b4e:	ffffc097          	auipc	ra,0xffffc
    80004b52:	732080e7          	jalr	1842(ra) # 80001280 <acquire>
  xticks = ticks;
    80004b56:	00008797          	auipc	a5,0x8
    80004b5a:	4ca78793          	addi	a5,a5,1226 # 8000d020 <ticks>
    80004b5e:	439c                	lw	a5,0(a5)
    80004b60:	fef42623          	sw	a5,-20(s0)
  release(&tickslock);
    80004b64:	00060517          	auipc	a0,0x60
    80004b68:	d4c50513          	addi	a0,a0,-692 # 800648b0 <tickslock>
    80004b6c:	ffffc097          	auipc	ra,0xffffc
    80004b70:	778080e7          	jalr	1912(ra) # 800012e4 <release>
  return xticks;
    80004b74:	fec46783          	lwu	a5,-20(s0)
}
    80004b78:	853e                	mv	a0,a5
    80004b7a:	60e2                	ld	ra,24(sp)
    80004b7c:	6442                	ld	s0,16(sp)
    80004b7e:	6105                	addi	sp,sp,32
    80004b80:	8082                	ret

0000000080004b82 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
    80004b82:	1101                	addi	sp,sp,-32
    80004b84:	ec06                	sd	ra,24(sp)
    80004b86:	e822                	sd	s0,16(sp)
    80004b88:	1000                	addi	s0,sp,32
  struct buf *b;

  initlock(&bcache.lock, "bcache");
    80004b8a:	00008597          	auipc	a1,0x8
    80004b8e:	86658593          	addi	a1,a1,-1946 # 8000c3f0 <etext+0x3f0>
    80004b92:	00060517          	auipc	a0,0x60
    80004b96:	d3650513          	addi	a0,a0,-714 # 800648c8 <bcache>
    80004b9a:	ffffc097          	auipc	ra,0xffffc
    80004b9e:	6b6080e7          	jalr	1718(ra) # 80001250 <initlock>

  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
    80004ba2:	00060717          	auipc	a4,0x60
    80004ba6:	d2670713          	addi	a4,a4,-730 # 800648c8 <bcache>
    80004baa:	67a1                	lui	a5,0x8
    80004bac:	97ba                	add	a5,a5,a4
    80004bae:	00068717          	auipc	a4,0x68
    80004bb2:	f8270713          	addi	a4,a4,-126 # 8006cb30 <bcache+0x8268>
    80004bb6:	2ae7b823          	sd	a4,688(a5) # 82b0 <_entry-0x7fff7d50>
  bcache.head.next = &bcache.head;
    80004bba:	00060717          	auipc	a4,0x60
    80004bbe:	d0e70713          	addi	a4,a4,-754 # 800648c8 <bcache>
    80004bc2:	67a1                	lui	a5,0x8
    80004bc4:	97ba                	add	a5,a5,a4
    80004bc6:	00068717          	auipc	a4,0x68
    80004bca:	f6a70713          	addi	a4,a4,-150 # 8006cb30 <bcache+0x8268>
    80004bce:	2ae7bc23          	sd	a4,696(a5) # 82b8 <_entry-0x7fff7d48>
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    80004bd2:	00060797          	auipc	a5,0x60
    80004bd6:	d0e78793          	addi	a5,a5,-754 # 800648e0 <bcache+0x18>
    80004bda:	fef43423          	sd	a5,-24(s0)
    80004bde:	a895                	j	80004c52 <binit+0xd0>
    b->next = bcache.head.next;
    80004be0:	00060717          	auipc	a4,0x60
    80004be4:	ce870713          	addi	a4,a4,-792 # 800648c8 <bcache>
    80004be8:	67a1                	lui	a5,0x8
    80004bea:	97ba                	add	a5,a5,a4
    80004bec:	2b87b703          	ld	a4,696(a5) # 82b8 <_entry-0x7fff7d48>
    80004bf0:	fe843783          	ld	a5,-24(s0)
    80004bf4:	ebb8                	sd	a4,80(a5)
    b->prev = &bcache.head;
    80004bf6:	fe843783          	ld	a5,-24(s0)
    80004bfa:	00068717          	auipc	a4,0x68
    80004bfe:	f3670713          	addi	a4,a4,-202 # 8006cb30 <bcache+0x8268>
    80004c02:	e7b8                	sd	a4,72(a5)
    initsleeplock(&b->lock, "buffer");
    80004c04:	fe843783          	ld	a5,-24(s0)
    80004c08:	07c1                	addi	a5,a5,16
    80004c0a:	00007597          	auipc	a1,0x7
    80004c0e:	7ee58593          	addi	a1,a1,2030 # 8000c3f8 <etext+0x3f8>
    80004c12:	853e                	mv	a0,a5
    80004c14:	00002097          	auipc	ra,0x2
    80004c18:	00a080e7          	jalr	10(ra) # 80006c1e <initsleeplock>
    bcache.head.next->prev = b;
    80004c1c:	00060717          	auipc	a4,0x60
    80004c20:	cac70713          	addi	a4,a4,-852 # 800648c8 <bcache>
    80004c24:	67a1                	lui	a5,0x8
    80004c26:	97ba                	add	a5,a5,a4
    80004c28:	2b87b783          	ld	a5,696(a5) # 82b8 <_entry-0x7fff7d48>
    80004c2c:	fe843703          	ld	a4,-24(s0)
    80004c30:	e7b8                	sd	a4,72(a5)
    bcache.head.next = b;
    80004c32:	00060717          	auipc	a4,0x60
    80004c36:	c9670713          	addi	a4,a4,-874 # 800648c8 <bcache>
    80004c3a:	67a1                	lui	a5,0x8
    80004c3c:	97ba                	add	a5,a5,a4
    80004c3e:	fe843703          	ld	a4,-24(s0)
    80004c42:	2ae7bc23          	sd	a4,696(a5) # 82b8 <_entry-0x7fff7d48>
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    80004c46:	fe843783          	ld	a5,-24(s0)
    80004c4a:	45878793          	addi	a5,a5,1112
    80004c4e:	fef43423          	sd	a5,-24(s0)
    80004c52:	00068797          	auipc	a5,0x68
    80004c56:	ede78793          	addi	a5,a5,-290 # 8006cb30 <bcache+0x8268>
    80004c5a:	fe843703          	ld	a4,-24(s0)
    80004c5e:	f8f761e3          	bltu	a4,a5,80004be0 <binit+0x5e>
  }
}
    80004c62:	0001                	nop
    80004c64:	0001                	nop
    80004c66:	60e2                	ld	ra,24(sp)
    80004c68:	6442                	ld	s0,16(sp)
    80004c6a:	6105                	addi	sp,sp,32
    80004c6c:	8082                	ret

0000000080004c6e <bget>:
// Look through buffer cache for block on device dev.
// If not found, allocate a buffer.
// In either case, return locked buffer.
static struct buf*
bget(uint dev, uint blockno)
{
    80004c6e:	7179                	addi	sp,sp,-48
    80004c70:	f406                	sd	ra,40(sp)
    80004c72:	f022                	sd	s0,32(sp)
    80004c74:	1800                	addi	s0,sp,48
    80004c76:	87aa                	mv	a5,a0
    80004c78:	872e                	mv	a4,a1
    80004c7a:	fcf42e23          	sw	a5,-36(s0)
    80004c7e:	87ba                	mv	a5,a4
    80004c80:	fcf42c23          	sw	a5,-40(s0)
  struct buf *b;

  acquire(&bcache.lock);
    80004c84:	00060517          	auipc	a0,0x60
    80004c88:	c4450513          	addi	a0,a0,-956 # 800648c8 <bcache>
    80004c8c:	ffffc097          	auipc	ra,0xffffc
    80004c90:	5f4080e7          	jalr	1524(ra) # 80001280 <acquire>

  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
    80004c94:	00060717          	auipc	a4,0x60
    80004c98:	c3470713          	addi	a4,a4,-972 # 800648c8 <bcache>
    80004c9c:	67a1                	lui	a5,0x8
    80004c9e:	97ba                	add	a5,a5,a4
    80004ca0:	2b87b783          	ld	a5,696(a5) # 82b8 <_entry-0x7fff7d48>
    80004ca4:	fef43423          	sd	a5,-24(s0)
    80004ca8:	a095                	j	80004d0c <bget+0x9e>
    if(b->dev == dev && b->blockno == blockno){
    80004caa:	fe843783          	ld	a5,-24(s0)
    80004cae:	4798                	lw	a4,8(a5)
    80004cb0:	fdc42783          	lw	a5,-36(s0)
    80004cb4:	2781                	sext.w	a5,a5
    80004cb6:	04e79663          	bne	a5,a4,80004d02 <bget+0x94>
    80004cba:	fe843783          	ld	a5,-24(s0)
    80004cbe:	47d8                	lw	a4,12(a5)
    80004cc0:	fd842783          	lw	a5,-40(s0)
    80004cc4:	2781                	sext.w	a5,a5
    80004cc6:	02e79e63          	bne	a5,a4,80004d02 <bget+0x94>
      b->refcnt++;
    80004cca:	fe843783          	ld	a5,-24(s0)
    80004cce:	43bc                	lw	a5,64(a5)
    80004cd0:	2785                	addiw	a5,a5,1
    80004cd2:	0007871b          	sext.w	a4,a5
    80004cd6:	fe843783          	ld	a5,-24(s0)
    80004cda:	c3b8                	sw	a4,64(a5)
      release(&bcache.lock);
    80004cdc:	00060517          	auipc	a0,0x60
    80004ce0:	bec50513          	addi	a0,a0,-1044 # 800648c8 <bcache>
    80004ce4:	ffffc097          	auipc	ra,0xffffc
    80004ce8:	600080e7          	jalr	1536(ra) # 800012e4 <release>
      acquiresleep(&b->lock);
    80004cec:	fe843783          	ld	a5,-24(s0)
    80004cf0:	07c1                	addi	a5,a5,16
    80004cf2:	853e                	mv	a0,a5
    80004cf4:	00002097          	auipc	ra,0x2
    80004cf8:	f76080e7          	jalr	-138(ra) # 80006c6a <acquiresleep>
      return b;
    80004cfc:	fe843783          	ld	a5,-24(s0)
    80004d00:	a07d                	j	80004dae <bget+0x140>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
    80004d02:	fe843783          	ld	a5,-24(s0)
    80004d06:	6bbc                	ld	a5,80(a5)
    80004d08:	fef43423          	sd	a5,-24(s0)
    80004d0c:	fe843703          	ld	a4,-24(s0)
    80004d10:	00068797          	auipc	a5,0x68
    80004d14:	e2078793          	addi	a5,a5,-480 # 8006cb30 <bcache+0x8268>
    80004d18:	f8f719e3          	bne	a4,a5,80004caa <bget+0x3c>
    }
  }

  // Not cached.
  // Recycle the least recently used (LRU) unused buffer.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    80004d1c:	00060717          	auipc	a4,0x60
    80004d20:	bac70713          	addi	a4,a4,-1108 # 800648c8 <bcache>
    80004d24:	67a1                	lui	a5,0x8
    80004d26:	97ba                	add	a5,a5,a4
    80004d28:	2b07b783          	ld	a5,688(a5) # 82b0 <_entry-0x7fff7d50>
    80004d2c:	fef43423          	sd	a5,-24(s0)
    80004d30:	a8b9                	j	80004d8e <bget+0x120>
    if(b->refcnt == 0) {
    80004d32:	fe843783          	ld	a5,-24(s0)
    80004d36:	43bc                	lw	a5,64(a5)
    80004d38:	e7b1                	bnez	a5,80004d84 <bget+0x116>
      b->dev = dev;
    80004d3a:	fe843783          	ld	a5,-24(s0)
    80004d3e:	fdc42703          	lw	a4,-36(s0)
    80004d42:	c798                	sw	a4,8(a5)
      b->blockno = blockno;
    80004d44:	fe843783          	ld	a5,-24(s0)
    80004d48:	fd842703          	lw	a4,-40(s0)
    80004d4c:	c7d8                	sw	a4,12(a5)
      b->valid = 0;
    80004d4e:	fe843783          	ld	a5,-24(s0)
    80004d52:	0007a023          	sw	zero,0(a5)
      b->refcnt = 1;
    80004d56:	fe843783          	ld	a5,-24(s0)
    80004d5a:	4705                	li	a4,1
    80004d5c:	c3b8                	sw	a4,64(a5)
      release(&bcache.lock);
    80004d5e:	00060517          	auipc	a0,0x60
    80004d62:	b6a50513          	addi	a0,a0,-1174 # 800648c8 <bcache>
    80004d66:	ffffc097          	auipc	ra,0xffffc
    80004d6a:	57e080e7          	jalr	1406(ra) # 800012e4 <release>
      acquiresleep(&b->lock);
    80004d6e:	fe843783          	ld	a5,-24(s0)
    80004d72:	07c1                	addi	a5,a5,16
    80004d74:	853e                	mv	a0,a5
    80004d76:	00002097          	auipc	ra,0x2
    80004d7a:	ef4080e7          	jalr	-268(ra) # 80006c6a <acquiresleep>
      return b;
    80004d7e:	fe843783          	ld	a5,-24(s0)
    80004d82:	a035                	j	80004dae <bget+0x140>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    80004d84:	fe843783          	ld	a5,-24(s0)
    80004d88:	67bc                	ld	a5,72(a5)
    80004d8a:	fef43423          	sd	a5,-24(s0)
    80004d8e:	fe843703          	ld	a4,-24(s0)
    80004d92:	00068797          	auipc	a5,0x68
    80004d96:	d9e78793          	addi	a5,a5,-610 # 8006cb30 <bcache+0x8268>
    80004d9a:	f8f71ce3          	bne	a4,a5,80004d32 <bget+0xc4>
    }
  }
  panic("bget: no buffers");
    80004d9e:	00007517          	auipc	a0,0x7
    80004da2:	66250513          	addi	a0,a0,1634 # 8000c400 <etext+0x400>
    80004da6:	ffffc097          	auipc	ra,0xffffc
    80004daa:	eac080e7          	jalr	-340(ra) # 80000c52 <panic>
}
    80004dae:	853e                	mv	a0,a5
    80004db0:	70a2                	ld	ra,40(sp)
    80004db2:	7402                	ld	s0,32(sp)
    80004db4:	6145                	addi	sp,sp,48
    80004db6:	8082                	ret

0000000080004db8 <bread>:

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
    80004db8:	7179                	addi	sp,sp,-48
    80004dba:	f406                	sd	ra,40(sp)
    80004dbc:	f022                	sd	s0,32(sp)
    80004dbe:	1800                	addi	s0,sp,48
    80004dc0:	87aa                	mv	a5,a0
    80004dc2:	872e                	mv	a4,a1
    80004dc4:	fcf42e23          	sw	a5,-36(s0)
    80004dc8:	87ba                	mv	a5,a4
    80004dca:	fcf42c23          	sw	a5,-40(s0)
  struct buf *b;

  b = bget(dev, blockno);
    80004dce:	fd842703          	lw	a4,-40(s0)
    80004dd2:	fdc42783          	lw	a5,-36(s0)
    80004dd6:	85ba                	mv	a1,a4
    80004dd8:	853e                	mv	a0,a5
    80004dda:	00000097          	auipc	ra,0x0
    80004dde:	e94080e7          	jalr	-364(ra) # 80004c6e <bget>
    80004de2:	fea43423          	sd	a0,-24(s0)
  if(!b->valid) {
    80004de6:	fe843783          	ld	a5,-24(s0)
    80004dea:	439c                	lw	a5,0(a5)
    80004dec:	ef81                	bnez	a5,80004e04 <bread+0x4c>
    virtio_disk_rw(b, 0);
    80004dee:	4581                	li	a1,0
    80004df0:	fe843503          	ld	a0,-24(s0)
    80004df4:	00004097          	auipc	ra,0x4
    80004df8:	7f6080e7          	jalr	2038(ra) # 800095ea <virtio_disk_rw>
    b->valid = 1;
    80004dfc:	fe843783          	ld	a5,-24(s0)
    80004e00:	4705                	li	a4,1
    80004e02:	c398                	sw	a4,0(a5)
  }
  return b;
    80004e04:	fe843783          	ld	a5,-24(s0)
}
    80004e08:	853e                	mv	a0,a5
    80004e0a:	70a2                	ld	ra,40(sp)
    80004e0c:	7402                	ld	s0,32(sp)
    80004e0e:	6145                	addi	sp,sp,48
    80004e10:	8082                	ret

0000000080004e12 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
    80004e12:	1101                	addi	sp,sp,-32
    80004e14:	ec06                	sd	ra,24(sp)
    80004e16:	e822                	sd	s0,16(sp)
    80004e18:	1000                	addi	s0,sp,32
    80004e1a:	fea43423          	sd	a0,-24(s0)
  if(!holdingsleep(&b->lock))
    80004e1e:	fe843783          	ld	a5,-24(s0)
    80004e22:	07c1                	addi	a5,a5,16
    80004e24:	853e                	mv	a0,a5
    80004e26:	00002097          	auipc	ra,0x2
    80004e2a:	f04080e7          	jalr	-252(ra) # 80006d2a <holdingsleep>
    80004e2e:	87aa                	mv	a5,a0
    80004e30:	eb89                	bnez	a5,80004e42 <bwrite+0x30>
    panic("bwrite");
    80004e32:	00007517          	auipc	a0,0x7
    80004e36:	5e650513          	addi	a0,a0,1510 # 8000c418 <etext+0x418>
    80004e3a:	ffffc097          	auipc	ra,0xffffc
    80004e3e:	e18080e7          	jalr	-488(ra) # 80000c52 <panic>
  virtio_disk_rw(b, 1);
    80004e42:	4585                	li	a1,1
    80004e44:	fe843503          	ld	a0,-24(s0)
    80004e48:	00004097          	auipc	ra,0x4
    80004e4c:	7a2080e7          	jalr	1954(ra) # 800095ea <virtio_disk_rw>
}
    80004e50:	0001                	nop
    80004e52:	60e2                	ld	ra,24(sp)
    80004e54:	6442                	ld	s0,16(sp)
    80004e56:	6105                	addi	sp,sp,32
    80004e58:	8082                	ret

0000000080004e5a <brelse>:

// Release a locked buffer.
// Move to the head of the most-recently-used list.
void
brelse(struct buf *b)
{
    80004e5a:	1101                	addi	sp,sp,-32
    80004e5c:	ec06                	sd	ra,24(sp)
    80004e5e:	e822                	sd	s0,16(sp)
    80004e60:	1000                	addi	s0,sp,32
    80004e62:	fea43423          	sd	a0,-24(s0)
  if(!holdingsleep(&b->lock))
    80004e66:	fe843783          	ld	a5,-24(s0)
    80004e6a:	07c1                	addi	a5,a5,16
    80004e6c:	853e                	mv	a0,a5
    80004e6e:	00002097          	auipc	ra,0x2
    80004e72:	ebc080e7          	jalr	-324(ra) # 80006d2a <holdingsleep>
    80004e76:	87aa                	mv	a5,a0
    80004e78:	eb89                	bnez	a5,80004e8a <brelse+0x30>
    panic("brelse");
    80004e7a:	00007517          	auipc	a0,0x7
    80004e7e:	5a650513          	addi	a0,a0,1446 # 8000c420 <etext+0x420>
    80004e82:	ffffc097          	auipc	ra,0xffffc
    80004e86:	dd0080e7          	jalr	-560(ra) # 80000c52 <panic>

  releasesleep(&b->lock);
    80004e8a:	fe843783          	ld	a5,-24(s0)
    80004e8e:	07c1                	addi	a5,a5,16
    80004e90:	853e                	mv	a0,a5
    80004e92:	00002097          	auipc	ra,0x2
    80004e96:	e46080e7          	jalr	-442(ra) # 80006cd8 <releasesleep>

  acquire(&bcache.lock);
    80004e9a:	00060517          	auipc	a0,0x60
    80004e9e:	a2e50513          	addi	a0,a0,-1490 # 800648c8 <bcache>
    80004ea2:	ffffc097          	auipc	ra,0xffffc
    80004ea6:	3de080e7          	jalr	990(ra) # 80001280 <acquire>
  b->refcnt--;
    80004eaa:	fe843783          	ld	a5,-24(s0)
    80004eae:	43bc                	lw	a5,64(a5)
    80004eb0:	37fd                	addiw	a5,a5,-1
    80004eb2:	0007871b          	sext.w	a4,a5
    80004eb6:	fe843783          	ld	a5,-24(s0)
    80004eba:	c3b8                	sw	a4,64(a5)
  if (b->refcnt == 0) {
    80004ebc:	fe843783          	ld	a5,-24(s0)
    80004ec0:	43bc                	lw	a5,64(a5)
    80004ec2:	e7b5                	bnez	a5,80004f2e <brelse+0xd4>
    // no one is waiting for it.
    b->next->prev = b->prev;
    80004ec4:	fe843783          	ld	a5,-24(s0)
    80004ec8:	6bbc                	ld	a5,80(a5)
    80004eca:	fe843703          	ld	a4,-24(s0)
    80004ece:	6738                	ld	a4,72(a4)
    80004ed0:	e7b8                	sd	a4,72(a5)
    b->prev->next = b->next;
    80004ed2:	fe843783          	ld	a5,-24(s0)
    80004ed6:	67bc                	ld	a5,72(a5)
    80004ed8:	fe843703          	ld	a4,-24(s0)
    80004edc:	6b38                	ld	a4,80(a4)
    80004ede:	ebb8                	sd	a4,80(a5)
    b->next = bcache.head.next;
    80004ee0:	00060717          	auipc	a4,0x60
    80004ee4:	9e870713          	addi	a4,a4,-1560 # 800648c8 <bcache>
    80004ee8:	67a1                	lui	a5,0x8
    80004eea:	97ba                	add	a5,a5,a4
    80004eec:	2b87b703          	ld	a4,696(a5) # 82b8 <_entry-0x7fff7d48>
    80004ef0:	fe843783          	ld	a5,-24(s0)
    80004ef4:	ebb8                	sd	a4,80(a5)
    b->prev = &bcache.head;
    80004ef6:	fe843783          	ld	a5,-24(s0)
    80004efa:	00068717          	auipc	a4,0x68
    80004efe:	c3670713          	addi	a4,a4,-970 # 8006cb30 <bcache+0x8268>
    80004f02:	e7b8                	sd	a4,72(a5)
    bcache.head.next->prev = b;
    80004f04:	00060717          	auipc	a4,0x60
    80004f08:	9c470713          	addi	a4,a4,-1596 # 800648c8 <bcache>
    80004f0c:	67a1                	lui	a5,0x8
    80004f0e:	97ba                	add	a5,a5,a4
    80004f10:	2b87b783          	ld	a5,696(a5) # 82b8 <_entry-0x7fff7d48>
    80004f14:	fe843703          	ld	a4,-24(s0)
    80004f18:	e7b8                	sd	a4,72(a5)
    bcache.head.next = b;
    80004f1a:	00060717          	auipc	a4,0x60
    80004f1e:	9ae70713          	addi	a4,a4,-1618 # 800648c8 <bcache>
    80004f22:	67a1                	lui	a5,0x8
    80004f24:	97ba                	add	a5,a5,a4
    80004f26:	fe843703          	ld	a4,-24(s0)
    80004f2a:	2ae7bc23          	sd	a4,696(a5) # 82b8 <_entry-0x7fff7d48>
  }
  
  release(&bcache.lock);
    80004f2e:	00060517          	auipc	a0,0x60
    80004f32:	99a50513          	addi	a0,a0,-1638 # 800648c8 <bcache>
    80004f36:	ffffc097          	auipc	ra,0xffffc
    80004f3a:	3ae080e7          	jalr	942(ra) # 800012e4 <release>
}
    80004f3e:	0001                	nop
    80004f40:	60e2                	ld	ra,24(sp)
    80004f42:	6442                	ld	s0,16(sp)
    80004f44:	6105                	addi	sp,sp,32
    80004f46:	8082                	ret

0000000080004f48 <bpin>:

void
bpin(struct buf *b) {
    80004f48:	1101                	addi	sp,sp,-32
    80004f4a:	ec06                	sd	ra,24(sp)
    80004f4c:	e822                	sd	s0,16(sp)
    80004f4e:	1000                	addi	s0,sp,32
    80004f50:	fea43423          	sd	a0,-24(s0)
  acquire(&bcache.lock);
    80004f54:	00060517          	auipc	a0,0x60
    80004f58:	97450513          	addi	a0,a0,-1676 # 800648c8 <bcache>
    80004f5c:	ffffc097          	auipc	ra,0xffffc
    80004f60:	324080e7          	jalr	804(ra) # 80001280 <acquire>
  b->refcnt++;
    80004f64:	fe843783          	ld	a5,-24(s0)
    80004f68:	43bc                	lw	a5,64(a5)
    80004f6a:	2785                	addiw	a5,a5,1
    80004f6c:	0007871b          	sext.w	a4,a5
    80004f70:	fe843783          	ld	a5,-24(s0)
    80004f74:	c3b8                	sw	a4,64(a5)
  release(&bcache.lock);
    80004f76:	00060517          	auipc	a0,0x60
    80004f7a:	95250513          	addi	a0,a0,-1710 # 800648c8 <bcache>
    80004f7e:	ffffc097          	auipc	ra,0xffffc
    80004f82:	366080e7          	jalr	870(ra) # 800012e4 <release>
}
    80004f86:	0001                	nop
    80004f88:	60e2                	ld	ra,24(sp)
    80004f8a:	6442                	ld	s0,16(sp)
    80004f8c:	6105                	addi	sp,sp,32
    80004f8e:	8082                	ret

0000000080004f90 <bunpin>:

void
bunpin(struct buf *b) {
    80004f90:	1101                	addi	sp,sp,-32
    80004f92:	ec06                	sd	ra,24(sp)
    80004f94:	e822                	sd	s0,16(sp)
    80004f96:	1000                	addi	s0,sp,32
    80004f98:	fea43423          	sd	a0,-24(s0)
  acquire(&bcache.lock);
    80004f9c:	00060517          	auipc	a0,0x60
    80004fa0:	92c50513          	addi	a0,a0,-1748 # 800648c8 <bcache>
    80004fa4:	ffffc097          	auipc	ra,0xffffc
    80004fa8:	2dc080e7          	jalr	732(ra) # 80001280 <acquire>
  b->refcnt--;
    80004fac:	fe843783          	ld	a5,-24(s0)
    80004fb0:	43bc                	lw	a5,64(a5)
    80004fb2:	37fd                	addiw	a5,a5,-1
    80004fb4:	0007871b          	sext.w	a4,a5
    80004fb8:	fe843783          	ld	a5,-24(s0)
    80004fbc:	c3b8                	sw	a4,64(a5)
  release(&bcache.lock);
    80004fbe:	00060517          	auipc	a0,0x60
    80004fc2:	90a50513          	addi	a0,a0,-1782 # 800648c8 <bcache>
    80004fc6:	ffffc097          	auipc	ra,0xffffc
    80004fca:	31e080e7          	jalr	798(ra) # 800012e4 <release>
}
    80004fce:	0001                	nop
    80004fd0:	60e2                	ld	ra,24(sp)
    80004fd2:	6442                	ld	s0,16(sp)
    80004fd4:	6105                	addi	sp,sp,32
    80004fd6:	8082                	ret

0000000080004fd8 <readsb>:
struct superblock sb; 

// Read the super block.
static void
readsb(int dev, struct superblock *sb)
{
    80004fd8:	7179                	addi	sp,sp,-48
    80004fda:	f406                	sd	ra,40(sp)
    80004fdc:	f022                	sd	s0,32(sp)
    80004fde:	1800                	addi	s0,sp,48
    80004fe0:	87aa                	mv	a5,a0
    80004fe2:	fcb43823          	sd	a1,-48(s0)
    80004fe6:	fcf42e23          	sw	a5,-36(s0)
  struct buf *bp;

  bp = bread(dev, 1);
    80004fea:	fdc42783          	lw	a5,-36(s0)
    80004fee:	4585                	li	a1,1
    80004ff0:	853e                	mv	a0,a5
    80004ff2:	00000097          	auipc	ra,0x0
    80004ff6:	dc6080e7          	jalr	-570(ra) # 80004db8 <bread>
    80004ffa:	fea43423          	sd	a0,-24(s0)
  memmove(sb, bp->data, sizeof(*sb));
    80004ffe:	fe843783          	ld	a5,-24(s0)
    80005002:	05878793          	addi	a5,a5,88
    80005006:	02000613          	li	a2,32
    8000500a:	85be                	mv	a1,a5
    8000500c:	fd043503          	ld	a0,-48(s0)
    80005010:	ffffc097          	auipc	ra,0xffffc
    80005014:	528080e7          	jalr	1320(ra) # 80001538 <memmove>
  brelse(bp);
    80005018:	fe843503          	ld	a0,-24(s0)
    8000501c:	00000097          	auipc	ra,0x0
    80005020:	e3e080e7          	jalr	-450(ra) # 80004e5a <brelse>
}
    80005024:	0001                	nop
    80005026:	70a2                	ld	ra,40(sp)
    80005028:	7402                	ld	s0,32(sp)
    8000502a:	6145                	addi	sp,sp,48
    8000502c:	8082                	ret

000000008000502e <fsinit>:

// Init fs
void
fsinit(int dev) {
    8000502e:	1101                	addi	sp,sp,-32
    80005030:	ec06                	sd	ra,24(sp)
    80005032:	e822                	sd	s0,16(sp)
    80005034:	1000                	addi	s0,sp,32
    80005036:	87aa                	mv	a5,a0
    80005038:	fef42623          	sw	a5,-20(s0)
  readsb(dev, &sb);
    8000503c:	fec42783          	lw	a5,-20(s0)
    80005040:	00068597          	auipc	a1,0x68
    80005044:	f4858593          	addi	a1,a1,-184 # 8006cf88 <sb>
    80005048:	853e                	mv	a0,a5
    8000504a:	00000097          	auipc	ra,0x0
    8000504e:	f8e080e7          	jalr	-114(ra) # 80004fd8 <readsb>
  if(sb.magic != FSMAGIC)
    80005052:	00068797          	auipc	a5,0x68
    80005056:	f3678793          	addi	a5,a5,-202 # 8006cf88 <sb>
    8000505a:	439c                	lw	a5,0(a5)
    8000505c:	873e                	mv	a4,a5
    8000505e:	102037b7          	lui	a5,0x10203
    80005062:	04078793          	addi	a5,a5,64 # 10203040 <_entry-0x6fdfcfc0>
    80005066:	00f70a63          	beq	a4,a5,8000507a <fsinit+0x4c>
    panic("invalid file system");
    8000506a:	00007517          	auipc	a0,0x7
    8000506e:	3be50513          	addi	a0,a0,958 # 8000c428 <etext+0x428>
    80005072:	ffffc097          	auipc	ra,0xffffc
    80005076:	be0080e7          	jalr	-1056(ra) # 80000c52 <panic>
  initlog(dev, &sb);
    8000507a:	fec42783          	lw	a5,-20(s0)
    8000507e:	00068597          	auipc	a1,0x68
    80005082:	f0a58593          	addi	a1,a1,-246 # 8006cf88 <sb>
    80005086:	853e                	mv	a0,a5
    80005088:	00001097          	auipc	ra,0x1
    8000508c:	47a080e7          	jalr	1146(ra) # 80006502 <initlog>
}
    80005090:	0001                	nop
    80005092:	60e2                	ld	ra,24(sp)
    80005094:	6442                	ld	s0,16(sp)
    80005096:	6105                	addi	sp,sp,32
    80005098:	8082                	ret

000000008000509a <bzero>:

// Zero a block.
static void
bzero(int dev, int bno)
{
    8000509a:	7179                	addi	sp,sp,-48
    8000509c:	f406                	sd	ra,40(sp)
    8000509e:	f022                	sd	s0,32(sp)
    800050a0:	1800                	addi	s0,sp,48
    800050a2:	87aa                	mv	a5,a0
    800050a4:	872e                	mv	a4,a1
    800050a6:	fcf42e23          	sw	a5,-36(s0)
    800050aa:	87ba                	mv	a5,a4
    800050ac:	fcf42c23          	sw	a5,-40(s0)
  struct buf *bp;

  bp = bread(dev, bno);
    800050b0:	fdc42783          	lw	a5,-36(s0)
    800050b4:	fd842703          	lw	a4,-40(s0)
    800050b8:	85ba                	mv	a1,a4
    800050ba:	853e                	mv	a0,a5
    800050bc:	00000097          	auipc	ra,0x0
    800050c0:	cfc080e7          	jalr	-772(ra) # 80004db8 <bread>
    800050c4:	fea43423          	sd	a0,-24(s0)
  memset(bp->data, 0, BSIZE);
    800050c8:	fe843783          	ld	a5,-24(s0)
    800050cc:	05878793          	addi	a5,a5,88
    800050d0:	40000613          	li	a2,1024
    800050d4:	4581                	li	a1,0
    800050d6:	853e                	mv	a0,a5
    800050d8:	ffffc097          	auipc	ra,0xffffc
    800050dc:	37c080e7          	jalr	892(ra) # 80001454 <memset>
  log_write(bp);
    800050e0:	fe843503          	ld	a0,-24(s0)
    800050e4:	00002097          	auipc	ra,0x2
    800050e8:	a06080e7          	jalr	-1530(ra) # 80006aea <log_write>
  brelse(bp);
    800050ec:	fe843503          	ld	a0,-24(s0)
    800050f0:	00000097          	auipc	ra,0x0
    800050f4:	d6a080e7          	jalr	-662(ra) # 80004e5a <brelse>
}
    800050f8:	0001                	nop
    800050fa:	70a2                	ld	ra,40(sp)
    800050fc:	7402                	ld	s0,32(sp)
    800050fe:	6145                	addi	sp,sp,48
    80005100:	8082                	ret

0000000080005102 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
    80005102:	7139                	addi	sp,sp,-64
    80005104:	fc06                	sd	ra,56(sp)
    80005106:	f822                	sd	s0,48(sp)
    80005108:	0080                	addi	s0,sp,64
    8000510a:	87aa                	mv	a5,a0
    8000510c:	fcf42623          	sw	a5,-52(s0)
  int b, bi, m;
  struct buf *bp;

  bp = 0;
    80005110:	fe043023          	sd	zero,-32(s0)
  for(b = 0; b < sb.size; b += BPB){
    80005114:	fe042623          	sw	zero,-20(s0)
    80005118:	a2b5                	j	80005284 <balloc+0x182>
    bp = bread(dev, BBLOCK(b, sb));
    8000511a:	fec42783          	lw	a5,-20(s0)
    8000511e:	41f7d71b          	sraiw	a4,a5,0x1f
    80005122:	0137571b          	srliw	a4,a4,0x13
    80005126:	9fb9                	addw	a5,a5,a4
    80005128:	40d7d79b          	sraiw	a5,a5,0xd
    8000512c:	2781                	sext.w	a5,a5
    8000512e:	0007871b          	sext.w	a4,a5
    80005132:	00068797          	auipc	a5,0x68
    80005136:	e5678793          	addi	a5,a5,-426 # 8006cf88 <sb>
    8000513a:	4fdc                	lw	a5,28(a5)
    8000513c:	9fb9                	addw	a5,a5,a4
    8000513e:	0007871b          	sext.w	a4,a5
    80005142:	fcc42783          	lw	a5,-52(s0)
    80005146:	85ba                	mv	a1,a4
    80005148:	853e                	mv	a0,a5
    8000514a:	00000097          	auipc	ra,0x0
    8000514e:	c6e080e7          	jalr	-914(ra) # 80004db8 <bread>
    80005152:	fea43023          	sd	a0,-32(s0)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80005156:	fe042423          	sw	zero,-24(s0)
    8000515a:	a0dd                	j	80005240 <balloc+0x13e>
      m = 1 << (bi % 8);
    8000515c:	fe842703          	lw	a4,-24(s0)
    80005160:	41f7579b          	sraiw	a5,a4,0x1f
    80005164:	01d7d79b          	srliw	a5,a5,0x1d
    80005168:	9f3d                	addw	a4,a4,a5
    8000516a:	8b1d                	andi	a4,a4,7
    8000516c:	40f707bb          	subw	a5,a4,a5
    80005170:	2781                	sext.w	a5,a5
    80005172:	4705                	li	a4,1
    80005174:	00f717bb          	sllw	a5,a4,a5
    80005178:	fcf42e23          	sw	a5,-36(s0)
      if((bp->data[bi/8] & m) == 0){  // Is block free?
    8000517c:	fe842783          	lw	a5,-24(s0)
    80005180:	41f7d71b          	sraiw	a4,a5,0x1f
    80005184:	01d7571b          	srliw	a4,a4,0x1d
    80005188:	9fb9                	addw	a5,a5,a4
    8000518a:	4037d79b          	sraiw	a5,a5,0x3
    8000518e:	2781                	sext.w	a5,a5
    80005190:	fe043703          	ld	a4,-32(s0)
    80005194:	97ba                	add	a5,a5,a4
    80005196:	0587c783          	lbu	a5,88(a5)
    8000519a:	0007871b          	sext.w	a4,a5
    8000519e:	fdc42783          	lw	a5,-36(s0)
    800051a2:	8ff9                	and	a5,a5,a4
    800051a4:	2781                	sext.w	a5,a5
    800051a6:	ebc1                	bnez	a5,80005236 <balloc+0x134>
        bp->data[bi/8] |= m;  // Mark block in use.
    800051a8:	fe842783          	lw	a5,-24(s0)
    800051ac:	41f7d71b          	sraiw	a4,a5,0x1f
    800051b0:	01d7571b          	srliw	a4,a4,0x1d
    800051b4:	9fb9                	addw	a5,a5,a4
    800051b6:	4037d79b          	sraiw	a5,a5,0x3
    800051ba:	2781                	sext.w	a5,a5
    800051bc:	fe043703          	ld	a4,-32(s0)
    800051c0:	973e                	add	a4,a4,a5
    800051c2:	05874703          	lbu	a4,88(a4)
    800051c6:	0187169b          	slliw	a3,a4,0x18
    800051ca:	4186d69b          	sraiw	a3,a3,0x18
    800051ce:	fdc42703          	lw	a4,-36(s0)
    800051d2:	0187171b          	slliw	a4,a4,0x18
    800051d6:	4187571b          	sraiw	a4,a4,0x18
    800051da:	8f55                	or	a4,a4,a3
    800051dc:	0187171b          	slliw	a4,a4,0x18
    800051e0:	4187571b          	sraiw	a4,a4,0x18
    800051e4:	0ff77713          	andi	a4,a4,255
    800051e8:	fe043683          	ld	a3,-32(s0)
    800051ec:	97b6                	add	a5,a5,a3
    800051ee:	04e78c23          	sb	a4,88(a5)
        log_write(bp);
    800051f2:	fe043503          	ld	a0,-32(s0)
    800051f6:	00002097          	auipc	ra,0x2
    800051fa:	8f4080e7          	jalr	-1804(ra) # 80006aea <log_write>
        brelse(bp);
    800051fe:	fe043503          	ld	a0,-32(s0)
    80005202:	00000097          	auipc	ra,0x0
    80005206:	c58080e7          	jalr	-936(ra) # 80004e5a <brelse>
        bzero(dev, b + bi);
    8000520a:	fcc42683          	lw	a3,-52(s0)
    8000520e:	fec42703          	lw	a4,-20(s0)
    80005212:	fe842783          	lw	a5,-24(s0)
    80005216:	9fb9                	addw	a5,a5,a4
    80005218:	2781                	sext.w	a5,a5
    8000521a:	85be                	mv	a1,a5
    8000521c:	8536                	mv	a0,a3
    8000521e:	00000097          	auipc	ra,0x0
    80005222:	e7c080e7          	jalr	-388(ra) # 8000509a <bzero>
        return b + bi;
    80005226:	fec42703          	lw	a4,-20(s0)
    8000522a:	fe842783          	lw	a5,-24(s0)
    8000522e:	9fb9                	addw	a5,a5,a4
    80005230:	2781                	sext.w	a5,a5
    80005232:	2781                	sext.w	a5,a5
    80005234:	a88d                	j	800052a6 <balloc+0x1a4>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80005236:	fe842783          	lw	a5,-24(s0)
    8000523a:	2785                	addiw	a5,a5,1
    8000523c:	fef42423          	sw	a5,-24(s0)
    80005240:	fe842783          	lw	a5,-24(s0)
    80005244:	0007871b          	sext.w	a4,a5
    80005248:	6789                	lui	a5,0x2
    8000524a:	02f75163          	bge	a4,a5,8000526c <balloc+0x16a>
    8000524e:	fec42703          	lw	a4,-20(s0)
    80005252:	fe842783          	lw	a5,-24(s0)
    80005256:	9fb9                	addw	a5,a5,a4
    80005258:	2781                	sext.w	a5,a5
    8000525a:	0007871b          	sext.w	a4,a5
    8000525e:	00068797          	auipc	a5,0x68
    80005262:	d2a78793          	addi	a5,a5,-726 # 8006cf88 <sb>
    80005266:	43dc                	lw	a5,4(a5)
    80005268:	eef76ae3          	bltu	a4,a5,8000515c <balloc+0x5a>
      }
    }
    brelse(bp);
    8000526c:	fe043503          	ld	a0,-32(s0)
    80005270:	00000097          	auipc	ra,0x0
    80005274:	bea080e7          	jalr	-1046(ra) # 80004e5a <brelse>
  for(b = 0; b < sb.size; b += BPB){
    80005278:	fec42703          	lw	a4,-20(s0)
    8000527c:	6789                	lui	a5,0x2
    8000527e:	9fb9                	addw	a5,a5,a4
    80005280:	fef42623          	sw	a5,-20(s0)
    80005284:	00068797          	auipc	a5,0x68
    80005288:	d0478793          	addi	a5,a5,-764 # 8006cf88 <sb>
    8000528c:	43d8                	lw	a4,4(a5)
    8000528e:	fec42783          	lw	a5,-20(s0)
    80005292:	e8e7e4e3          	bltu	a5,a4,8000511a <balloc+0x18>
  }
  panic("balloc: out of blocks");
    80005296:	00007517          	auipc	a0,0x7
    8000529a:	1aa50513          	addi	a0,a0,426 # 8000c440 <etext+0x440>
    8000529e:	ffffc097          	auipc	ra,0xffffc
    800052a2:	9b4080e7          	jalr	-1612(ra) # 80000c52 <panic>
}
    800052a6:	853e                	mv	a0,a5
    800052a8:	70e2                	ld	ra,56(sp)
    800052aa:	7442                	ld	s0,48(sp)
    800052ac:	6121                	addi	sp,sp,64
    800052ae:	8082                	ret

00000000800052b0 <bfree>:

// Free a disk block.
static void
bfree(int dev, uint b)
{
    800052b0:	7179                	addi	sp,sp,-48
    800052b2:	f406                	sd	ra,40(sp)
    800052b4:	f022                	sd	s0,32(sp)
    800052b6:	1800                	addi	s0,sp,48
    800052b8:	87aa                	mv	a5,a0
    800052ba:	872e                	mv	a4,a1
    800052bc:	fcf42e23          	sw	a5,-36(s0)
    800052c0:	87ba                	mv	a5,a4
    800052c2:	fcf42c23          	sw	a5,-40(s0)
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
    800052c6:	fdc42683          	lw	a3,-36(s0)
    800052ca:	fd842783          	lw	a5,-40(s0)
    800052ce:	00d7d79b          	srliw	a5,a5,0xd
    800052d2:	0007871b          	sext.w	a4,a5
    800052d6:	00068797          	auipc	a5,0x68
    800052da:	cb278793          	addi	a5,a5,-846 # 8006cf88 <sb>
    800052de:	4fdc                	lw	a5,28(a5)
    800052e0:	9fb9                	addw	a5,a5,a4
    800052e2:	2781                	sext.w	a5,a5
    800052e4:	85be                	mv	a1,a5
    800052e6:	8536                	mv	a0,a3
    800052e8:	00000097          	auipc	ra,0x0
    800052ec:	ad0080e7          	jalr	-1328(ra) # 80004db8 <bread>
    800052f0:	fea43423          	sd	a0,-24(s0)
  bi = b % BPB;
    800052f4:	fd842703          	lw	a4,-40(s0)
    800052f8:	6789                	lui	a5,0x2
    800052fa:	17fd                	addi	a5,a5,-1
    800052fc:	8ff9                	and	a5,a5,a4
    800052fe:	fef42223          	sw	a5,-28(s0)
  m = 1 << (bi % 8);
    80005302:	fe442703          	lw	a4,-28(s0)
    80005306:	41f7579b          	sraiw	a5,a4,0x1f
    8000530a:	01d7d79b          	srliw	a5,a5,0x1d
    8000530e:	9f3d                	addw	a4,a4,a5
    80005310:	8b1d                	andi	a4,a4,7
    80005312:	40f707bb          	subw	a5,a4,a5
    80005316:	2781                	sext.w	a5,a5
    80005318:	4705                	li	a4,1
    8000531a:	00f717bb          	sllw	a5,a4,a5
    8000531e:	fef42023          	sw	a5,-32(s0)
  if((bp->data[bi/8] & m) == 0)
    80005322:	fe442783          	lw	a5,-28(s0)
    80005326:	41f7d71b          	sraiw	a4,a5,0x1f
    8000532a:	01d7571b          	srliw	a4,a4,0x1d
    8000532e:	9fb9                	addw	a5,a5,a4
    80005330:	4037d79b          	sraiw	a5,a5,0x3
    80005334:	2781                	sext.w	a5,a5
    80005336:	fe843703          	ld	a4,-24(s0)
    8000533a:	97ba                	add	a5,a5,a4
    8000533c:	0587c783          	lbu	a5,88(a5) # 2058 <_entry-0x7fffdfa8>
    80005340:	0007871b          	sext.w	a4,a5
    80005344:	fe042783          	lw	a5,-32(s0)
    80005348:	8ff9                	and	a5,a5,a4
    8000534a:	2781                	sext.w	a5,a5
    8000534c:	eb89                	bnez	a5,8000535e <bfree+0xae>
    panic("freeing free block");
    8000534e:	00007517          	auipc	a0,0x7
    80005352:	10a50513          	addi	a0,a0,266 # 8000c458 <etext+0x458>
    80005356:	ffffc097          	auipc	ra,0xffffc
    8000535a:	8fc080e7          	jalr	-1796(ra) # 80000c52 <panic>
  bp->data[bi/8] &= ~m;
    8000535e:	fe442783          	lw	a5,-28(s0)
    80005362:	41f7d71b          	sraiw	a4,a5,0x1f
    80005366:	01d7571b          	srliw	a4,a4,0x1d
    8000536a:	9fb9                	addw	a5,a5,a4
    8000536c:	4037d79b          	sraiw	a5,a5,0x3
    80005370:	2781                	sext.w	a5,a5
    80005372:	fe843703          	ld	a4,-24(s0)
    80005376:	973e                	add	a4,a4,a5
    80005378:	05874703          	lbu	a4,88(a4)
    8000537c:	0187169b          	slliw	a3,a4,0x18
    80005380:	4186d69b          	sraiw	a3,a3,0x18
    80005384:	fe042703          	lw	a4,-32(s0)
    80005388:	0187171b          	slliw	a4,a4,0x18
    8000538c:	4187571b          	sraiw	a4,a4,0x18
    80005390:	fff74713          	not	a4,a4
    80005394:	0187171b          	slliw	a4,a4,0x18
    80005398:	4187571b          	sraiw	a4,a4,0x18
    8000539c:	8f75                	and	a4,a4,a3
    8000539e:	0187171b          	slliw	a4,a4,0x18
    800053a2:	4187571b          	sraiw	a4,a4,0x18
    800053a6:	0ff77713          	andi	a4,a4,255
    800053aa:	fe843683          	ld	a3,-24(s0)
    800053ae:	97b6                	add	a5,a5,a3
    800053b0:	04e78c23          	sb	a4,88(a5)
  log_write(bp);
    800053b4:	fe843503          	ld	a0,-24(s0)
    800053b8:	00001097          	auipc	ra,0x1
    800053bc:	732080e7          	jalr	1842(ra) # 80006aea <log_write>
  brelse(bp);
    800053c0:	fe843503          	ld	a0,-24(s0)
    800053c4:	00000097          	auipc	ra,0x0
    800053c8:	a96080e7          	jalr	-1386(ra) # 80004e5a <brelse>
}
    800053cc:	0001                	nop
    800053ce:	70a2                	ld	ra,40(sp)
    800053d0:	7402                	ld	s0,32(sp)
    800053d2:	6145                	addi	sp,sp,48
    800053d4:	8082                	ret

00000000800053d6 <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit()
{
    800053d6:	1101                	addi	sp,sp,-32
    800053d8:	ec06                	sd	ra,24(sp)
    800053da:	e822                	sd	s0,16(sp)
    800053dc:	1000                	addi	s0,sp,32
  int i = 0;
    800053de:	fe042623          	sw	zero,-20(s0)
  
  initlock(&icache.lock, "icache");
    800053e2:	00007597          	auipc	a1,0x7
    800053e6:	08e58593          	addi	a1,a1,142 # 8000c470 <etext+0x470>
    800053ea:	00068517          	auipc	a0,0x68
    800053ee:	bbe50513          	addi	a0,a0,-1090 # 8006cfa8 <icache>
    800053f2:	ffffc097          	auipc	ra,0xffffc
    800053f6:	e5e080e7          	jalr	-418(ra) # 80001250 <initlock>
  for(i = 0; i < NINODE; i++) {
    800053fa:	fe042623          	sw	zero,-20(s0)
    800053fe:	a82d                	j	80005438 <iinit+0x62>
    initsleeplock(&icache.inode[i].lock, "inode");
    80005400:	fec42703          	lw	a4,-20(s0)
    80005404:	87ba                	mv	a5,a4
    80005406:	0792                	slli	a5,a5,0x4
    80005408:	97ba                	add	a5,a5,a4
    8000540a:	078e                	slli	a5,a5,0x3
    8000540c:	02078713          	addi	a4,a5,32
    80005410:	00068797          	auipc	a5,0x68
    80005414:	b9878793          	addi	a5,a5,-1128 # 8006cfa8 <icache>
    80005418:	97ba                	add	a5,a5,a4
    8000541a:	07a1                	addi	a5,a5,8
    8000541c:	00007597          	auipc	a1,0x7
    80005420:	05c58593          	addi	a1,a1,92 # 8000c478 <etext+0x478>
    80005424:	853e                	mv	a0,a5
    80005426:	00001097          	auipc	ra,0x1
    8000542a:	7f8080e7          	jalr	2040(ra) # 80006c1e <initsleeplock>
  for(i = 0; i < NINODE; i++) {
    8000542e:	fec42783          	lw	a5,-20(s0)
    80005432:	2785                	addiw	a5,a5,1
    80005434:	fef42623          	sw	a5,-20(s0)
    80005438:	fec42783          	lw	a5,-20(s0)
    8000543c:	0007871b          	sext.w	a4,a5
    80005440:	03100793          	li	a5,49
    80005444:	fae7dee3          	bge	a5,a4,80005400 <iinit+0x2a>
  }
}
    80005448:	0001                	nop
    8000544a:	0001                	nop
    8000544c:	60e2                	ld	ra,24(sp)
    8000544e:	6442                	ld	s0,16(sp)
    80005450:	6105                	addi	sp,sp,32
    80005452:	8082                	ret

0000000080005454 <ialloc>:
// Allocate an inode on device dev.
// Mark it as allocated by  giving it type type.
// Returns an unlocked but allocated and referenced inode.
struct inode*
ialloc(uint dev, short type)
{
    80005454:	7139                	addi	sp,sp,-64
    80005456:	fc06                	sd	ra,56(sp)
    80005458:	f822                	sd	s0,48(sp)
    8000545a:	0080                	addi	s0,sp,64
    8000545c:	87aa                	mv	a5,a0
    8000545e:	872e                	mv	a4,a1
    80005460:	fcf42623          	sw	a5,-52(s0)
    80005464:	87ba                	mv	a5,a4
    80005466:	fcf41523          	sh	a5,-54(s0)
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
    8000546a:	4785                	li	a5,1
    8000546c:	fef42623          	sw	a5,-20(s0)
    80005470:	a855                	j	80005524 <ialloc+0xd0>
    bp = bread(dev, IBLOCK(inum, sb));
    80005472:	fec42783          	lw	a5,-20(s0)
    80005476:	8391                	srli	a5,a5,0x4
    80005478:	0007871b          	sext.w	a4,a5
    8000547c:	00068797          	auipc	a5,0x68
    80005480:	b0c78793          	addi	a5,a5,-1268 # 8006cf88 <sb>
    80005484:	4f9c                	lw	a5,24(a5)
    80005486:	9fb9                	addw	a5,a5,a4
    80005488:	0007871b          	sext.w	a4,a5
    8000548c:	fcc42783          	lw	a5,-52(s0)
    80005490:	85ba                	mv	a1,a4
    80005492:	853e                	mv	a0,a5
    80005494:	00000097          	auipc	ra,0x0
    80005498:	924080e7          	jalr	-1756(ra) # 80004db8 <bread>
    8000549c:	fea43023          	sd	a0,-32(s0)
    dip = (struct dinode*)bp->data + inum%IPB;
    800054a0:	fe043783          	ld	a5,-32(s0)
    800054a4:	05878713          	addi	a4,a5,88
    800054a8:	fec42783          	lw	a5,-20(s0)
    800054ac:	8bbd                	andi	a5,a5,15
    800054ae:	079a                	slli	a5,a5,0x6
    800054b0:	97ba                	add	a5,a5,a4
    800054b2:	fcf43c23          	sd	a5,-40(s0)
    if(dip->type == 0){  // a free inode
    800054b6:	fd843783          	ld	a5,-40(s0)
    800054ba:	00079783          	lh	a5,0(a5)
    800054be:	eba1                	bnez	a5,8000550e <ialloc+0xba>
      memset(dip, 0, sizeof(*dip));
    800054c0:	04000613          	li	a2,64
    800054c4:	4581                	li	a1,0
    800054c6:	fd843503          	ld	a0,-40(s0)
    800054ca:	ffffc097          	auipc	ra,0xffffc
    800054ce:	f8a080e7          	jalr	-118(ra) # 80001454 <memset>
      dip->type = type;
    800054d2:	fd843783          	ld	a5,-40(s0)
    800054d6:	fca45703          	lhu	a4,-54(s0)
    800054da:	00e79023          	sh	a4,0(a5)
      log_write(bp);   // mark it allocated on the disk
    800054de:	fe043503          	ld	a0,-32(s0)
    800054e2:	00001097          	auipc	ra,0x1
    800054e6:	608080e7          	jalr	1544(ra) # 80006aea <log_write>
      brelse(bp);
    800054ea:	fe043503          	ld	a0,-32(s0)
    800054ee:	00000097          	auipc	ra,0x0
    800054f2:	96c080e7          	jalr	-1684(ra) # 80004e5a <brelse>
      return iget(dev, inum);
    800054f6:	fec42703          	lw	a4,-20(s0)
    800054fa:	fcc42783          	lw	a5,-52(s0)
    800054fe:	85ba                	mv	a1,a4
    80005500:	853e                	mv	a0,a5
    80005502:	00000097          	auipc	ra,0x0
    80005506:	136080e7          	jalr	310(ra) # 80005638 <iget>
    8000550a:	87aa                	mv	a5,a0
    8000550c:	a82d                	j	80005546 <ialloc+0xf2>
    }
    brelse(bp);
    8000550e:	fe043503          	ld	a0,-32(s0)
    80005512:	00000097          	auipc	ra,0x0
    80005516:	948080e7          	jalr	-1720(ra) # 80004e5a <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
    8000551a:	fec42783          	lw	a5,-20(s0)
    8000551e:	2785                	addiw	a5,a5,1
    80005520:	fef42623          	sw	a5,-20(s0)
    80005524:	00068797          	auipc	a5,0x68
    80005528:	a6478793          	addi	a5,a5,-1436 # 8006cf88 <sb>
    8000552c:	47d8                	lw	a4,12(a5)
    8000552e:	fec42783          	lw	a5,-20(s0)
    80005532:	f4e7e0e3          	bltu	a5,a4,80005472 <ialloc+0x1e>
  }
  panic("ialloc: no inodes");
    80005536:	00007517          	auipc	a0,0x7
    8000553a:	f4a50513          	addi	a0,a0,-182 # 8000c480 <etext+0x480>
    8000553e:	ffffb097          	auipc	ra,0xffffb
    80005542:	714080e7          	jalr	1812(ra) # 80000c52 <panic>
}
    80005546:	853e                	mv	a0,a5
    80005548:	70e2                	ld	ra,56(sp)
    8000554a:	7442                	ld	s0,48(sp)
    8000554c:	6121                	addi	sp,sp,64
    8000554e:	8082                	ret

0000000080005550 <iupdate>:
// Must be called after every change to an ip->xxx field
// that lives on disk, since i-node cache is write-through.
// Caller must hold ip->lock.
void
iupdate(struct inode *ip)
{
    80005550:	7179                	addi	sp,sp,-48
    80005552:	f406                	sd	ra,40(sp)
    80005554:	f022                	sd	s0,32(sp)
    80005556:	1800                	addi	s0,sp,48
    80005558:	fca43c23          	sd	a0,-40(s0)
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    8000555c:	fd843783          	ld	a5,-40(s0)
    80005560:	4394                	lw	a3,0(a5)
    80005562:	fd843783          	ld	a5,-40(s0)
    80005566:	43dc                	lw	a5,4(a5)
    80005568:	0047d79b          	srliw	a5,a5,0x4
    8000556c:	0007871b          	sext.w	a4,a5
    80005570:	00068797          	auipc	a5,0x68
    80005574:	a1878793          	addi	a5,a5,-1512 # 8006cf88 <sb>
    80005578:	4f9c                	lw	a5,24(a5)
    8000557a:	9fb9                	addw	a5,a5,a4
    8000557c:	2781                	sext.w	a5,a5
    8000557e:	85be                	mv	a1,a5
    80005580:	8536                	mv	a0,a3
    80005582:	00000097          	auipc	ra,0x0
    80005586:	836080e7          	jalr	-1994(ra) # 80004db8 <bread>
    8000558a:	fea43423          	sd	a0,-24(s0)
  dip = (struct dinode*)bp->data + ip->inum%IPB;
    8000558e:	fe843783          	ld	a5,-24(s0)
    80005592:	05878713          	addi	a4,a5,88
    80005596:	fd843783          	ld	a5,-40(s0)
    8000559a:	43dc                	lw	a5,4(a5)
    8000559c:	1782                	slli	a5,a5,0x20
    8000559e:	9381                	srli	a5,a5,0x20
    800055a0:	8bbd                	andi	a5,a5,15
    800055a2:	079a                	slli	a5,a5,0x6
    800055a4:	97ba                	add	a5,a5,a4
    800055a6:	fef43023          	sd	a5,-32(s0)
  dip->type = ip->type;
    800055aa:	fd843783          	ld	a5,-40(s0)
    800055ae:	04479703          	lh	a4,68(a5)
    800055b2:	fe043783          	ld	a5,-32(s0)
    800055b6:	00e79023          	sh	a4,0(a5)
  dip->major = ip->major;
    800055ba:	fd843783          	ld	a5,-40(s0)
    800055be:	04679703          	lh	a4,70(a5)
    800055c2:	fe043783          	ld	a5,-32(s0)
    800055c6:	00e79123          	sh	a4,2(a5)
  dip->minor = ip->minor;
    800055ca:	fd843783          	ld	a5,-40(s0)
    800055ce:	04879703          	lh	a4,72(a5)
    800055d2:	fe043783          	ld	a5,-32(s0)
    800055d6:	00e79223          	sh	a4,4(a5)
  dip->nlink = ip->nlink;
    800055da:	fd843783          	ld	a5,-40(s0)
    800055de:	04a79703          	lh	a4,74(a5)
    800055e2:	fe043783          	ld	a5,-32(s0)
    800055e6:	00e79323          	sh	a4,6(a5)
  dip->size = ip->size;
    800055ea:	fd843783          	ld	a5,-40(s0)
    800055ee:	47f8                	lw	a4,76(a5)
    800055f0:	fe043783          	ld	a5,-32(s0)
    800055f4:	c798                	sw	a4,8(a5)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
    800055f6:	fe043783          	ld	a5,-32(s0)
    800055fa:	00c78713          	addi	a4,a5,12
    800055fe:	fd843783          	ld	a5,-40(s0)
    80005602:	05078793          	addi	a5,a5,80
    80005606:	03400613          	li	a2,52
    8000560a:	85be                	mv	a1,a5
    8000560c:	853a                	mv	a0,a4
    8000560e:	ffffc097          	auipc	ra,0xffffc
    80005612:	f2a080e7          	jalr	-214(ra) # 80001538 <memmove>
  log_write(bp);
    80005616:	fe843503          	ld	a0,-24(s0)
    8000561a:	00001097          	auipc	ra,0x1
    8000561e:	4d0080e7          	jalr	1232(ra) # 80006aea <log_write>
  brelse(bp);
    80005622:	fe843503          	ld	a0,-24(s0)
    80005626:	00000097          	auipc	ra,0x0
    8000562a:	834080e7          	jalr	-1996(ra) # 80004e5a <brelse>
}
    8000562e:	0001                	nop
    80005630:	70a2                	ld	ra,40(sp)
    80005632:	7402                	ld	s0,32(sp)
    80005634:	6145                	addi	sp,sp,48
    80005636:	8082                	ret

0000000080005638 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
    80005638:	7179                	addi	sp,sp,-48
    8000563a:	f406                	sd	ra,40(sp)
    8000563c:	f022                	sd	s0,32(sp)
    8000563e:	1800                	addi	s0,sp,48
    80005640:	87aa                	mv	a5,a0
    80005642:	872e                	mv	a4,a1
    80005644:	fcf42e23          	sw	a5,-36(s0)
    80005648:	87ba                	mv	a5,a4
    8000564a:	fcf42c23          	sw	a5,-40(s0)
  struct inode *ip, *empty;

  acquire(&icache.lock);
    8000564e:	00068517          	auipc	a0,0x68
    80005652:	95a50513          	addi	a0,a0,-1702 # 8006cfa8 <icache>
    80005656:	ffffc097          	auipc	ra,0xffffc
    8000565a:	c2a080e7          	jalr	-982(ra) # 80001280 <acquire>

  // Is the inode already cached?
  empty = 0;
    8000565e:	fe043023          	sd	zero,-32(s0)
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    80005662:	00068797          	auipc	a5,0x68
    80005666:	95e78793          	addi	a5,a5,-1698 # 8006cfc0 <icache+0x18>
    8000566a:	fef43423          	sd	a5,-24(s0)
    8000566e:	a89d                	j	800056e4 <iget+0xac>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
    80005670:	fe843783          	ld	a5,-24(s0)
    80005674:	479c                	lw	a5,8(a5)
    80005676:	04f05663          	blez	a5,800056c2 <iget+0x8a>
    8000567a:	fe843783          	ld	a5,-24(s0)
    8000567e:	4398                	lw	a4,0(a5)
    80005680:	fdc42783          	lw	a5,-36(s0)
    80005684:	2781                	sext.w	a5,a5
    80005686:	02e79e63          	bne	a5,a4,800056c2 <iget+0x8a>
    8000568a:	fe843783          	ld	a5,-24(s0)
    8000568e:	43d8                	lw	a4,4(a5)
    80005690:	fd842783          	lw	a5,-40(s0)
    80005694:	2781                	sext.w	a5,a5
    80005696:	02e79663          	bne	a5,a4,800056c2 <iget+0x8a>
      ip->ref++;
    8000569a:	fe843783          	ld	a5,-24(s0)
    8000569e:	479c                	lw	a5,8(a5)
    800056a0:	2785                	addiw	a5,a5,1
    800056a2:	0007871b          	sext.w	a4,a5
    800056a6:	fe843783          	ld	a5,-24(s0)
    800056aa:	c798                	sw	a4,8(a5)
      release(&icache.lock);
    800056ac:	00068517          	auipc	a0,0x68
    800056b0:	8fc50513          	addi	a0,a0,-1796 # 8006cfa8 <icache>
    800056b4:	ffffc097          	auipc	ra,0xffffc
    800056b8:	c30080e7          	jalr	-976(ra) # 800012e4 <release>
      return ip;
    800056bc:	fe843783          	ld	a5,-24(s0)
    800056c0:	a069                	j	8000574a <iget+0x112>
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    800056c2:	fe043783          	ld	a5,-32(s0)
    800056c6:	eb89                	bnez	a5,800056d8 <iget+0xa0>
    800056c8:	fe843783          	ld	a5,-24(s0)
    800056cc:	479c                	lw	a5,8(a5)
    800056ce:	e789                	bnez	a5,800056d8 <iget+0xa0>
      empty = ip;
    800056d0:	fe843783          	ld	a5,-24(s0)
    800056d4:	fef43023          	sd	a5,-32(s0)
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    800056d8:	fe843783          	ld	a5,-24(s0)
    800056dc:	08878793          	addi	a5,a5,136
    800056e0:	fef43423          	sd	a5,-24(s0)
    800056e4:	fe843703          	ld	a4,-24(s0)
    800056e8:	00069797          	auipc	a5,0x69
    800056ec:	36878793          	addi	a5,a5,872 # 8006ea50 <log>
    800056f0:	f8f760e3          	bltu	a4,a5,80005670 <iget+0x38>
  }

  // Recycle an inode cache entry.
  if(empty == 0)
    800056f4:	fe043783          	ld	a5,-32(s0)
    800056f8:	eb89                	bnez	a5,8000570a <iget+0xd2>
    panic("iget: no inodes");
    800056fa:	00007517          	auipc	a0,0x7
    800056fe:	d9e50513          	addi	a0,a0,-610 # 8000c498 <etext+0x498>
    80005702:	ffffb097          	auipc	ra,0xffffb
    80005706:	550080e7          	jalr	1360(ra) # 80000c52 <panic>

  ip = empty;
    8000570a:	fe043783          	ld	a5,-32(s0)
    8000570e:	fef43423          	sd	a5,-24(s0)
  ip->dev = dev;
    80005712:	fe843783          	ld	a5,-24(s0)
    80005716:	fdc42703          	lw	a4,-36(s0)
    8000571a:	c398                	sw	a4,0(a5)
  ip->inum = inum;
    8000571c:	fe843783          	ld	a5,-24(s0)
    80005720:	fd842703          	lw	a4,-40(s0)
    80005724:	c3d8                	sw	a4,4(a5)
  ip->ref = 1;
    80005726:	fe843783          	ld	a5,-24(s0)
    8000572a:	4705                	li	a4,1
    8000572c:	c798                	sw	a4,8(a5)
  ip->valid = 0;
    8000572e:	fe843783          	ld	a5,-24(s0)
    80005732:	0407a023          	sw	zero,64(a5)
  release(&icache.lock);
    80005736:	00068517          	auipc	a0,0x68
    8000573a:	87250513          	addi	a0,a0,-1934 # 8006cfa8 <icache>
    8000573e:	ffffc097          	auipc	ra,0xffffc
    80005742:	ba6080e7          	jalr	-1114(ra) # 800012e4 <release>

  return ip;
    80005746:	fe843783          	ld	a5,-24(s0)
}
    8000574a:	853e                	mv	a0,a5
    8000574c:	70a2                	ld	ra,40(sp)
    8000574e:	7402                	ld	s0,32(sp)
    80005750:	6145                	addi	sp,sp,48
    80005752:	8082                	ret

0000000080005754 <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
    80005754:	1101                	addi	sp,sp,-32
    80005756:	ec06                	sd	ra,24(sp)
    80005758:	e822                	sd	s0,16(sp)
    8000575a:	1000                	addi	s0,sp,32
    8000575c:	fea43423          	sd	a0,-24(s0)
  acquire(&icache.lock);
    80005760:	00068517          	auipc	a0,0x68
    80005764:	84850513          	addi	a0,a0,-1976 # 8006cfa8 <icache>
    80005768:	ffffc097          	auipc	ra,0xffffc
    8000576c:	b18080e7          	jalr	-1256(ra) # 80001280 <acquire>
  ip->ref++;
    80005770:	fe843783          	ld	a5,-24(s0)
    80005774:	479c                	lw	a5,8(a5)
    80005776:	2785                	addiw	a5,a5,1
    80005778:	0007871b          	sext.w	a4,a5
    8000577c:	fe843783          	ld	a5,-24(s0)
    80005780:	c798                	sw	a4,8(a5)
  release(&icache.lock);
    80005782:	00068517          	auipc	a0,0x68
    80005786:	82650513          	addi	a0,a0,-2010 # 8006cfa8 <icache>
    8000578a:	ffffc097          	auipc	ra,0xffffc
    8000578e:	b5a080e7          	jalr	-1190(ra) # 800012e4 <release>
  return ip;
    80005792:	fe843783          	ld	a5,-24(s0)
}
    80005796:	853e                	mv	a0,a5
    80005798:	60e2                	ld	ra,24(sp)
    8000579a:	6442                	ld	s0,16(sp)
    8000579c:	6105                	addi	sp,sp,32
    8000579e:	8082                	ret

00000000800057a0 <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
    800057a0:	7179                	addi	sp,sp,-48
    800057a2:	f406                	sd	ra,40(sp)
    800057a4:	f022                	sd	s0,32(sp)
    800057a6:	1800                	addi	s0,sp,48
    800057a8:	fca43c23          	sd	a0,-40(s0)
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
    800057ac:	fd843783          	ld	a5,-40(s0)
    800057b0:	c791                	beqz	a5,800057bc <ilock+0x1c>
    800057b2:	fd843783          	ld	a5,-40(s0)
    800057b6:	479c                	lw	a5,8(a5)
    800057b8:	00f04a63          	bgtz	a5,800057cc <ilock+0x2c>
    panic("ilock");
    800057bc:	00007517          	auipc	a0,0x7
    800057c0:	cec50513          	addi	a0,a0,-788 # 8000c4a8 <etext+0x4a8>
    800057c4:	ffffb097          	auipc	ra,0xffffb
    800057c8:	48e080e7          	jalr	1166(ra) # 80000c52 <panic>

  acquiresleep(&ip->lock);
    800057cc:	fd843783          	ld	a5,-40(s0)
    800057d0:	07c1                	addi	a5,a5,16
    800057d2:	853e                	mv	a0,a5
    800057d4:	00001097          	auipc	ra,0x1
    800057d8:	496080e7          	jalr	1174(ra) # 80006c6a <acquiresleep>

  if(ip->valid == 0){
    800057dc:	fd843783          	ld	a5,-40(s0)
    800057e0:	43bc                	lw	a5,64(a5)
    800057e2:	e7e5                	bnez	a5,800058ca <ilock+0x12a>
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    800057e4:	fd843783          	ld	a5,-40(s0)
    800057e8:	4394                	lw	a3,0(a5)
    800057ea:	fd843783          	ld	a5,-40(s0)
    800057ee:	43dc                	lw	a5,4(a5)
    800057f0:	0047d79b          	srliw	a5,a5,0x4
    800057f4:	0007871b          	sext.w	a4,a5
    800057f8:	00067797          	auipc	a5,0x67
    800057fc:	79078793          	addi	a5,a5,1936 # 8006cf88 <sb>
    80005800:	4f9c                	lw	a5,24(a5)
    80005802:	9fb9                	addw	a5,a5,a4
    80005804:	2781                	sext.w	a5,a5
    80005806:	85be                	mv	a1,a5
    80005808:	8536                	mv	a0,a3
    8000580a:	fffff097          	auipc	ra,0xfffff
    8000580e:	5ae080e7          	jalr	1454(ra) # 80004db8 <bread>
    80005812:	fea43423          	sd	a0,-24(s0)
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    80005816:	fe843783          	ld	a5,-24(s0)
    8000581a:	05878713          	addi	a4,a5,88
    8000581e:	fd843783          	ld	a5,-40(s0)
    80005822:	43dc                	lw	a5,4(a5)
    80005824:	1782                	slli	a5,a5,0x20
    80005826:	9381                	srli	a5,a5,0x20
    80005828:	8bbd                	andi	a5,a5,15
    8000582a:	079a                	slli	a5,a5,0x6
    8000582c:	97ba                	add	a5,a5,a4
    8000582e:	fef43023          	sd	a5,-32(s0)
    ip->type = dip->type;
    80005832:	fe043783          	ld	a5,-32(s0)
    80005836:	00079703          	lh	a4,0(a5)
    8000583a:	fd843783          	ld	a5,-40(s0)
    8000583e:	04e79223          	sh	a4,68(a5)
    ip->major = dip->major;
    80005842:	fe043783          	ld	a5,-32(s0)
    80005846:	00279703          	lh	a4,2(a5)
    8000584a:	fd843783          	ld	a5,-40(s0)
    8000584e:	04e79323          	sh	a4,70(a5)
    ip->minor = dip->minor;
    80005852:	fe043783          	ld	a5,-32(s0)
    80005856:	00479703          	lh	a4,4(a5)
    8000585a:	fd843783          	ld	a5,-40(s0)
    8000585e:	04e79423          	sh	a4,72(a5)
    ip->nlink = dip->nlink;
    80005862:	fe043783          	ld	a5,-32(s0)
    80005866:	00679703          	lh	a4,6(a5)
    8000586a:	fd843783          	ld	a5,-40(s0)
    8000586e:	04e79523          	sh	a4,74(a5)
    ip->size = dip->size;
    80005872:	fe043783          	ld	a5,-32(s0)
    80005876:	4798                	lw	a4,8(a5)
    80005878:	fd843783          	ld	a5,-40(s0)
    8000587c:	c7f8                	sw	a4,76(a5)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    8000587e:	fd843783          	ld	a5,-40(s0)
    80005882:	05078713          	addi	a4,a5,80
    80005886:	fe043783          	ld	a5,-32(s0)
    8000588a:	07b1                	addi	a5,a5,12
    8000588c:	03400613          	li	a2,52
    80005890:	85be                	mv	a1,a5
    80005892:	853a                	mv	a0,a4
    80005894:	ffffc097          	auipc	ra,0xffffc
    80005898:	ca4080e7          	jalr	-860(ra) # 80001538 <memmove>
    brelse(bp);
    8000589c:	fe843503          	ld	a0,-24(s0)
    800058a0:	fffff097          	auipc	ra,0xfffff
    800058a4:	5ba080e7          	jalr	1466(ra) # 80004e5a <brelse>
    ip->valid = 1;
    800058a8:	fd843783          	ld	a5,-40(s0)
    800058ac:	4705                	li	a4,1
    800058ae:	c3b8                	sw	a4,64(a5)
    if(ip->type == 0)
    800058b0:	fd843783          	ld	a5,-40(s0)
    800058b4:	04479783          	lh	a5,68(a5)
    800058b8:	eb89                	bnez	a5,800058ca <ilock+0x12a>
      panic("ilock: no type");
    800058ba:	00007517          	auipc	a0,0x7
    800058be:	bf650513          	addi	a0,a0,-1034 # 8000c4b0 <etext+0x4b0>
    800058c2:	ffffb097          	auipc	ra,0xffffb
    800058c6:	390080e7          	jalr	912(ra) # 80000c52 <panic>
  }
}
    800058ca:	0001                	nop
    800058cc:	70a2                	ld	ra,40(sp)
    800058ce:	7402                	ld	s0,32(sp)
    800058d0:	6145                	addi	sp,sp,48
    800058d2:	8082                	ret

00000000800058d4 <iunlock>:

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
    800058d4:	1101                	addi	sp,sp,-32
    800058d6:	ec06                	sd	ra,24(sp)
    800058d8:	e822                	sd	s0,16(sp)
    800058da:	1000                	addi	s0,sp,32
    800058dc:	fea43423          	sd	a0,-24(s0)
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    800058e0:	fe843783          	ld	a5,-24(s0)
    800058e4:	c385                	beqz	a5,80005904 <iunlock+0x30>
    800058e6:	fe843783          	ld	a5,-24(s0)
    800058ea:	07c1                	addi	a5,a5,16
    800058ec:	853e                	mv	a0,a5
    800058ee:	00001097          	auipc	ra,0x1
    800058f2:	43c080e7          	jalr	1084(ra) # 80006d2a <holdingsleep>
    800058f6:	87aa                	mv	a5,a0
    800058f8:	c791                	beqz	a5,80005904 <iunlock+0x30>
    800058fa:	fe843783          	ld	a5,-24(s0)
    800058fe:	479c                	lw	a5,8(a5)
    80005900:	00f04a63          	bgtz	a5,80005914 <iunlock+0x40>
    panic("iunlock");
    80005904:	00007517          	auipc	a0,0x7
    80005908:	bbc50513          	addi	a0,a0,-1092 # 8000c4c0 <etext+0x4c0>
    8000590c:	ffffb097          	auipc	ra,0xffffb
    80005910:	346080e7          	jalr	838(ra) # 80000c52 <panic>

  releasesleep(&ip->lock);
    80005914:	fe843783          	ld	a5,-24(s0)
    80005918:	07c1                	addi	a5,a5,16
    8000591a:	853e                	mv	a0,a5
    8000591c:	00001097          	auipc	ra,0x1
    80005920:	3bc080e7          	jalr	956(ra) # 80006cd8 <releasesleep>
}
    80005924:	0001                	nop
    80005926:	60e2                	ld	ra,24(sp)
    80005928:	6442                	ld	s0,16(sp)
    8000592a:	6105                	addi	sp,sp,32
    8000592c:	8082                	ret

000000008000592e <iput>:
// to it, free the inode (and its content) on disk.
// All calls to iput() must be inside a transaction in
// case it has to free the inode.
void
iput(struct inode *ip)
{
    8000592e:	1101                	addi	sp,sp,-32
    80005930:	ec06                	sd	ra,24(sp)
    80005932:	e822                	sd	s0,16(sp)
    80005934:	1000                	addi	s0,sp,32
    80005936:	fea43423          	sd	a0,-24(s0)
  acquire(&icache.lock);
    8000593a:	00067517          	auipc	a0,0x67
    8000593e:	66e50513          	addi	a0,a0,1646 # 8006cfa8 <icache>
    80005942:	ffffc097          	auipc	ra,0xffffc
    80005946:	93e080e7          	jalr	-1730(ra) # 80001280 <acquire>

  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    8000594a:	fe843783          	ld	a5,-24(s0)
    8000594e:	479c                	lw	a5,8(a5)
    80005950:	873e                	mv	a4,a5
    80005952:	4785                	li	a5,1
    80005954:	06f71f63          	bne	a4,a5,800059d2 <iput+0xa4>
    80005958:	fe843783          	ld	a5,-24(s0)
    8000595c:	43bc                	lw	a5,64(a5)
    8000595e:	cbb5                	beqz	a5,800059d2 <iput+0xa4>
    80005960:	fe843783          	ld	a5,-24(s0)
    80005964:	04a79783          	lh	a5,74(a5)
    80005968:	e7ad                	bnez	a5,800059d2 <iput+0xa4>
    // inode has no links and no other references: truncate and free.

    // ip->ref == 1 means no other process can have ip locked,
    // so this acquiresleep() won't block (or deadlock).
    acquiresleep(&ip->lock);
    8000596a:	fe843783          	ld	a5,-24(s0)
    8000596e:	07c1                	addi	a5,a5,16
    80005970:	853e                	mv	a0,a5
    80005972:	00001097          	auipc	ra,0x1
    80005976:	2f8080e7          	jalr	760(ra) # 80006c6a <acquiresleep>

    release(&icache.lock);
    8000597a:	00067517          	auipc	a0,0x67
    8000597e:	62e50513          	addi	a0,a0,1582 # 8006cfa8 <icache>
    80005982:	ffffc097          	auipc	ra,0xffffc
    80005986:	962080e7          	jalr	-1694(ra) # 800012e4 <release>

    itrunc(ip);
    8000598a:	fe843503          	ld	a0,-24(s0)
    8000598e:	00000097          	auipc	ra,0x0
    80005992:	1fa080e7          	jalr	506(ra) # 80005b88 <itrunc>
    ip->type = 0;
    80005996:	fe843783          	ld	a5,-24(s0)
    8000599a:	04079223          	sh	zero,68(a5)
    iupdate(ip);
    8000599e:	fe843503          	ld	a0,-24(s0)
    800059a2:	00000097          	auipc	ra,0x0
    800059a6:	bae080e7          	jalr	-1106(ra) # 80005550 <iupdate>
    ip->valid = 0;
    800059aa:	fe843783          	ld	a5,-24(s0)
    800059ae:	0407a023          	sw	zero,64(a5)

    releasesleep(&ip->lock);
    800059b2:	fe843783          	ld	a5,-24(s0)
    800059b6:	07c1                	addi	a5,a5,16
    800059b8:	853e                	mv	a0,a5
    800059ba:	00001097          	auipc	ra,0x1
    800059be:	31e080e7          	jalr	798(ra) # 80006cd8 <releasesleep>

    acquire(&icache.lock);
    800059c2:	00067517          	auipc	a0,0x67
    800059c6:	5e650513          	addi	a0,a0,1510 # 8006cfa8 <icache>
    800059ca:	ffffc097          	auipc	ra,0xffffc
    800059ce:	8b6080e7          	jalr	-1866(ra) # 80001280 <acquire>
  }

  ip->ref--;
    800059d2:	fe843783          	ld	a5,-24(s0)
    800059d6:	479c                	lw	a5,8(a5)
    800059d8:	37fd                	addiw	a5,a5,-1
    800059da:	0007871b          	sext.w	a4,a5
    800059de:	fe843783          	ld	a5,-24(s0)
    800059e2:	c798                	sw	a4,8(a5)
  release(&icache.lock);
    800059e4:	00067517          	auipc	a0,0x67
    800059e8:	5c450513          	addi	a0,a0,1476 # 8006cfa8 <icache>
    800059ec:	ffffc097          	auipc	ra,0xffffc
    800059f0:	8f8080e7          	jalr	-1800(ra) # 800012e4 <release>
}
    800059f4:	0001                	nop
    800059f6:	60e2                	ld	ra,24(sp)
    800059f8:	6442                	ld	s0,16(sp)
    800059fa:	6105                	addi	sp,sp,32
    800059fc:	8082                	ret

00000000800059fe <iunlockput>:

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
    800059fe:	1101                	addi	sp,sp,-32
    80005a00:	ec06                	sd	ra,24(sp)
    80005a02:	e822                	sd	s0,16(sp)
    80005a04:	1000                	addi	s0,sp,32
    80005a06:	fea43423          	sd	a0,-24(s0)
  iunlock(ip);
    80005a0a:	fe843503          	ld	a0,-24(s0)
    80005a0e:	00000097          	auipc	ra,0x0
    80005a12:	ec6080e7          	jalr	-314(ra) # 800058d4 <iunlock>
  iput(ip);
    80005a16:	fe843503          	ld	a0,-24(s0)
    80005a1a:	00000097          	auipc	ra,0x0
    80005a1e:	f14080e7          	jalr	-236(ra) # 8000592e <iput>
}
    80005a22:	0001                	nop
    80005a24:	60e2                	ld	ra,24(sp)
    80005a26:	6442                	ld	s0,16(sp)
    80005a28:	6105                	addi	sp,sp,32
    80005a2a:	8082                	ret

0000000080005a2c <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
    80005a2c:	7139                	addi	sp,sp,-64
    80005a2e:	fc06                	sd	ra,56(sp)
    80005a30:	f822                	sd	s0,48(sp)
    80005a32:	0080                	addi	s0,sp,64
    80005a34:	fca43423          	sd	a0,-56(s0)
    80005a38:	87ae                	mv	a5,a1
    80005a3a:	fcf42223          	sw	a5,-60(s0)
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    80005a3e:	fc442783          	lw	a5,-60(s0)
    80005a42:	0007871b          	sext.w	a4,a5
    80005a46:	47ad                	li	a5,11
    80005a48:	04e7e863          	bltu	a5,a4,80005a98 <bmap+0x6c>
    if((addr = ip->addrs[bn]) == 0)
    80005a4c:	fc843703          	ld	a4,-56(s0)
    80005a50:	fc446783          	lwu	a5,-60(s0)
    80005a54:	07d1                	addi	a5,a5,20
    80005a56:	078a                	slli	a5,a5,0x2
    80005a58:	97ba                	add	a5,a5,a4
    80005a5a:	439c                	lw	a5,0(a5)
    80005a5c:	fef42623          	sw	a5,-20(s0)
    80005a60:	fec42783          	lw	a5,-20(s0)
    80005a64:	2781                	sext.w	a5,a5
    80005a66:	e795                	bnez	a5,80005a92 <bmap+0x66>
      ip->addrs[bn] = addr = balloc(ip->dev);
    80005a68:	fc843783          	ld	a5,-56(s0)
    80005a6c:	439c                	lw	a5,0(a5)
    80005a6e:	853e                	mv	a0,a5
    80005a70:	fffff097          	auipc	ra,0xfffff
    80005a74:	692080e7          	jalr	1682(ra) # 80005102 <balloc>
    80005a78:	87aa                	mv	a5,a0
    80005a7a:	fef42623          	sw	a5,-20(s0)
    80005a7e:	fc843703          	ld	a4,-56(s0)
    80005a82:	fc446783          	lwu	a5,-60(s0)
    80005a86:	07d1                	addi	a5,a5,20
    80005a88:	078a                	slli	a5,a5,0x2
    80005a8a:	97ba                	add	a5,a5,a4
    80005a8c:	fec42703          	lw	a4,-20(s0)
    80005a90:	c398                	sw	a4,0(a5)
    return addr;
    80005a92:	fec42783          	lw	a5,-20(s0)
    80005a96:	a0e5                	j	80005b7e <bmap+0x152>
  }
  bn -= NDIRECT;
    80005a98:	fc442783          	lw	a5,-60(s0)
    80005a9c:	37d1                	addiw	a5,a5,-12
    80005a9e:	fcf42223          	sw	a5,-60(s0)

  if(bn < NINDIRECT){
    80005aa2:	fc442783          	lw	a5,-60(s0)
    80005aa6:	0007871b          	sext.w	a4,a5
    80005aaa:	0ff00793          	li	a5,255
    80005aae:	0ce7e063          	bltu	a5,a4,80005b6e <bmap+0x142>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
    80005ab2:	fc843783          	ld	a5,-56(s0)
    80005ab6:	0807a783          	lw	a5,128(a5)
    80005aba:	fef42623          	sw	a5,-20(s0)
    80005abe:	fec42783          	lw	a5,-20(s0)
    80005ac2:	2781                	sext.w	a5,a5
    80005ac4:	e395                	bnez	a5,80005ae8 <bmap+0xbc>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    80005ac6:	fc843783          	ld	a5,-56(s0)
    80005aca:	439c                	lw	a5,0(a5)
    80005acc:	853e                	mv	a0,a5
    80005ace:	fffff097          	auipc	ra,0xfffff
    80005ad2:	634080e7          	jalr	1588(ra) # 80005102 <balloc>
    80005ad6:	87aa                	mv	a5,a0
    80005ad8:	fef42623          	sw	a5,-20(s0)
    80005adc:	fc843783          	ld	a5,-56(s0)
    80005ae0:	fec42703          	lw	a4,-20(s0)
    80005ae4:	08e7a023          	sw	a4,128(a5)
    bp = bread(ip->dev, addr);
    80005ae8:	fc843783          	ld	a5,-56(s0)
    80005aec:	439c                	lw	a5,0(a5)
    80005aee:	fec42703          	lw	a4,-20(s0)
    80005af2:	85ba                	mv	a1,a4
    80005af4:	853e                	mv	a0,a5
    80005af6:	fffff097          	auipc	ra,0xfffff
    80005afa:	2c2080e7          	jalr	706(ra) # 80004db8 <bread>
    80005afe:	fea43023          	sd	a0,-32(s0)
    a = (uint*)bp->data;
    80005b02:	fe043783          	ld	a5,-32(s0)
    80005b06:	05878793          	addi	a5,a5,88
    80005b0a:	fcf43c23          	sd	a5,-40(s0)
    if((addr = a[bn]) == 0){
    80005b0e:	fc446783          	lwu	a5,-60(s0)
    80005b12:	078a                	slli	a5,a5,0x2
    80005b14:	fd843703          	ld	a4,-40(s0)
    80005b18:	97ba                	add	a5,a5,a4
    80005b1a:	439c                	lw	a5,0(a5)
    80005b1c:	fef42623          	sw	a5,-20(s0)
    80005b20:	fec42783          	lw	a5,-20(s0)
    80005b24:	2781                	sext.w	a5,a5
    80005b26:	eb9d                	bnez	a5,80005b5c <bmap+0x130>
      a[bn] = addr = balloc(ip->dev);
    80005b28:	fc843783          	ld	a5,-56(s0)
    80005b2c:	439c                	lw	a5,0(a5)
    80005b2e:	853e                	mv	a0,a5
    80005b30:	fffff097          	auipc	ra,0xfffff
    80005b34:	5d2080e7          	jalr	1490(ra) # 80005102 <balloc>
    80005b38:	87aa                	mv	a5,a0
    80005b3a:	fef42623          	sw	a5,-20(s0)
    80005b3e:	fc446783          	lwu	a5,-60(s0)
    80005b42:	078a                	slli	a5,a5,0x2
    80005b44:	fd843703          	ld	a4,-40(s0)
    80005b48:	97ba                	add	a5,a5,a4
    80005b4a:	fec42703          	lw	a4,-20(s0)
    80005b4e:	c398                	sw	a4,0(a5)
      log_write(bp);
    80005b50:	fe043503          	ld	a0,-32(s0)
    80005b54:	00001097          	auipc	ra,0x1
    80005b58:	f96080e7          	jalr	-106(ra) # 80006aea <log_write>
    }
    brelse(bp);
    80005b5c:	fe043503          	ld	a0,-32(s0)
    80005b60:	fffff097          	auipc	ra,0xfffff
    80005b64:	2fa080e7          	jalr	762(ra) # 80004e5a <brelse>
    return addr;
    80005b68:	fec42783          	lw	a5,-20(s0)
    80005b6c:	a809                	j	80005b7e <bmap+0x152>
  }

  panic("bmap: out of range");
    80005b6e:	00007517          	auipc	a0,0x7
    80005b72:	95a50513          	addi	a0,a0,-1702 # 8000c4c8 <etext+0x4c8>
    80005b76:	ffffb097          	auipc	ra,0xffffb
    80005b7a:	0dc080e7          	jalr	220(ra) # 80000c52 <panic>
}
    80005b7e:	853e                	mv	a0,a5
    80005b80:	70e2                	ld	ra,56(sp)
    80005b82:	7442                	ld	s0,48(sp)
    80005b84:	6121                	addi	sp,sp,64
    80005b86:	8082                	ret

0000000080005b88 <itrunc>:

// Truncate inode (discard contents).
// Caller must hold ip->lock.
void
itrunc(struct inode *ip)
{
    80005b88:	7139                	addi	sp,sp,-64
    80005b8a:	fc06                	sd	ra,56(sp)
    80005b8c:	f822                	sd	s0,48(sp)
    80005b8e:	0080                	addi	s0,sp,64
    80005b90:	fca43423          	sd	a0,-56(s0)
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
    80005b94:	fe042623          	sw	zero,-20(s0)
    80005b98:	a899                	j	80005bee <itrunc+0x66>
    if(ip->addrs[i]){
    80005b9a:	fc843703          	ld	a4,-56(s0)
    80005b9e:	fec42783          	lw	a5,-20(s0)
    80005ba2:	07d1                	addi	a5,a5,20
    80005ba4:	078a                	slli	a5,a5,0x2
    80005ba6:	97ba                	add	a5,a5,a4
    80005ba8:	439c                	lw	a5,0(a5)
    80005baa:	cf8d                	beqz	a5,80005be4 <itrunc+0x5c>
      bfree(ip->dev, ip->addrs[i]);
    80005bac:	fc843783          	ld	a5,-56(s0)
    80005bb0:	439c                	lw	a5,0(a5)
    80005bb2:	0007869b          	sext.w	a3,a5
    80005bb6:	fc843703          	ld	a4,-56(s0)
    80005bba:	fec42783          	lw	a5,-20(s0)
    80005bbe:	07d1                	addi	a5,a5,20
    80005bc0:	078a                	slli	a5,a5,0x2
    80005bc2:	97ba                	add	a5,a5,a4
    80005bc4:	439c                	lw	a5,0(a5)
    80005bc6:	85be                	mv	a1,a5
    80005bc8:	8536                	mv	a0,a3
    80005bca:	fffff097          	auipc	ra,0xfffff
    80005bce:	6e6080e7          	jalr	1766(ra) # 800052b0 <bfree>
      ip->addrs[i] = 0;
    80005bd2:	fc843703          	ld	a4,-56(s0)
    80005bd6:	fec42783          	lw	a5,-20(s0)
    80005bda:	07d1                	addi	a5,a5,20
    80005bdc:	078a                	slli	a5,a5,0x2
    80005bde:	97ba                	add	a5,a5,a4
    80005be0:	0007a023          	sw	zero,0(a5)
  for(i = 0; i < NDIRECT; i++){
    80005be4:	fec42783          	lw	a5,-20(s0)
    80005be8:	2785                	addiw	a5,a5,1
    80005bea:	fef42623          	sw	a5,-20(s0)
    80005bee:	fec42783          	lw	a5,-20(s0)
    80005bf2:	0007871b          	sext.w	a4,a5
    80005bf6:	47ad                	li	a5,11
    80005bf8:	fae7d1e3          	bge	a5,a4,80005b9a <itrunc+0x12>
    }
  }

  if(ip->addrs[NDIRECT]){
    80005bfc:	fc843783          	ld	a5,-56(s0)
    80005c00:	0807a783          	lw	a5,128(a5)
    80005c04:	cbc5                	beqz	a5,80005cb4 <itrunc+0x12c>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    80005c06:	fc843783          	ld	a5,-56(s0)
    80005c0a:	4398                	lw	a4,0(a5)
    80005c0c:	fc843783          	ld	a5,-56(s0)
    80005c10:	0807a783          	lw	a5,128(a5)
    80005c14:	85be                	mv	a1,a5
    80005c16:	853a                	mv	a0,a4
    80005c18:	fffff097          	auipc	ra,0xfffff
    80005c1c:	1a0080e7          	jalr	416(ra) # 80004db8 <bread>
    80005c20:	fea43023          	sd	a0,-32(s0)
    a = (uint*)bp->data;
    80005c24:	fe043783          	ld	a5,-32(s0)
    80005c28:	05878793          	addi	a5,a5,88
    80005c2c:	fcf43c23          	sd	a5,-40(s0)
    for(j = 0; j < NINDIRECT; j++){
    80005c30:	fe042423          	sw	zero,-24(s0)
    80005c34:	a081                	j	80005c74 <itrunc+0xec>
      if(a[j])
    80005c36:	fe842783          	lw	a5,-24(s0)
    80005c3a:	078a                	slli	a5,a5,0x2
    80005c3c:	fd843703          	ld	a4,-40(s0)
    80005c40:	97ba                	add	a5,a5,a4
    80005c42:	439c                	lw	a5,0(a5)
    80005c44:	c39d                	beqz	a5,80005c6a <itrunc+0xe2>
        bfree(ip->dev, a[j]);
    80005c46:	fc843783          	ld	a5,-56(s0)
    80005c4a:	439c                	lw	a5,0(a5)
    80005c4c:	0007869b          	sext.w	a3,a5
    80005c50:	fe842783          	lw	a5,-24(s0)
    80005c54:	078a                	slli	a5,a5,0x2
    80005c56:	fd843703          	ld	a4,-40(s0)
    80005c5a:	97ba                	add	a5,a5,a4
    80005c5c:	439c                	lw	a5,0(a5)
    80005c5e:	85be                	mv	a1,a5
    80005c60:	8536                	mv	a0,a3
    80005c62:	fffff097          	auipc	ra,0xfffff
    80005c66:	64e080e7          	jalr	1614(ra) # 800052b0 <bfree>
    for(j = 0; j < NINDIRECT; j++){
    80005c6a:	fe842783          	lw	a5,-24(s0)
    80005c6e:	2785                	addiw	a5,a5,1
    80005c70:	fef42423          	sw	a5,-24(s0)
    80005c74:	fe842783          	lw	a5,-24(s0)
    80005c78:	873e                	mv	a4,a5
    80005c7a:	0ff00793          	li	a5,255
    80005c7e:	fae7fce3          	bgeu	a5,a4,80005c36 <itrunc+0xae>
    }
    brelse(bp);
    80005c82:	fe043503          	ld	a0,-32(s0)
    80005c86:	fffff097          	auipc	ra,0xfffff
    80005c8a:	1d4080e7          	jalr	468(ra) # 80004e5a <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    80005c8e:	fc843783          	ld	a5,-56(s0)
    80005c92:	439c                	lw	a5,0(a5)
    80005c94:	0007871b          	sext.w	a4,a5
    80005c98:	fc843783          	ld	a5,-56(s0)
    80005c9c:	0807a783          	lw	a5,128(a5)
    80005ca0:	85be                	mv	a1,a5
    80005ca2:	853a                	mv	a0,a4
    80005ca4:	fffff097          	auipc	ra,0xfffff
    80005ca8:	60c080e7          	jalr	1548(ra) # 800052b0 <bfree>
    ip->addrs[NDIRECT] = 0;
    80005cac:	fc843783          	ld	a5,-56(s0)
    80005cb0:	0807a023          	sw	zero,128(a5)
  }

  ip->size = 0;
    80005cb4:	fc843783          	ld	a5,-56(s0)
    80005cb8:	0407a623          	sw	zero,76(a5)
  iupdate(ip);
    80005cbc:	fc843503          	ld	a0,-56(s0)
    80005cc0:	00000097          	auipc	ra,0x0
    80005cc4:	890080e7          	jalr	-1904(ra) # 80005550 <iupdate>
}
    80005cc8:	0001                	nop
    80005cca:	70e2                	ld	ra,56(sp)
    80005ccc:	7442                	ld	s0,48(sp)
    80005cce:	6121                	addi	sp,sp,64
    80005cd0:	8082                	ret

0000000080005cd2 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
    80005cd2:	1101                	addi	sp,sp,-32
    80005cd4:	ec22                	sd	s0,24(sp)
    80005cd6:	1000                	addi	s0,sp,32
    80005cd8:	fea43423          	sd	a0,-24(s0)
    80005cdc:	feb43023          	sd	a1,-32(s0)
  st->dev = ip->dev;
    80005ce0:	fe843783          	ld	a5,-24(s0)
    80005ce4:	439c                	lw	a5,0(a5)
    80005ce6:	0007871b          	sext.w	a4,a5
    80005cea:	fe043783          	ld	a5,-32(s0)
    80005cee:	c398                	sw	a4,0(a5)
  st->ino = ip->inum;
    80005cf0:	fe843783          	ld	a5,-24(s0)
    80005cf4:	43d8                	lw	a4,4(a5)
    80005cf6:	fe043783          	ld	a5,-32(s0)
    80005cfa:	c3d8                	sw	a4,4(a5)
  st->type = ip->type;
    80005cfc:	fe843783          	ld	a5,-24(s0)
    80005d00:	04479703          	lh	a4,68(a5)
    80005d04:	fe043783          	ld	a5,-32(s0)
    80005d08:	00e79423          	sh	a4,8(a5)
  st->nlink = ip->nlink;
    80005d0c:	fe843783          	ld	a5,-24(s0)
    80005d10:	04a79703          	lh	a4,74(a5)
    80005d14:	fe043783          	ld	a5,-32(s0)
    80005d18:	00e79523          	sh	a4,10(a5)
  st->size = ip->size;
    80005d1c:	fe843783          	ld	a5,-24(s0)
    80005d20:	47fc                	lw	a5,76(a5)
    80005d22:	02079713          	slli	a4,a5,0x20
    80005d26:	9301                	srli	a4,a4,0x20
    80005d28:	fe043783          	ld	a5,-32(s0)
    80005d2c:	eb98                	sd	a4,16(a5)
}
    80005d2e:	0001                	nop
    80005d30:	6462                	ld	s0,24(sp)
    80005d32:	6105                	addi	sp,sp,32
    80005d34:	8082                	ret

0000000080005d36 <readi>:
// Caller must hold ip->lock.
// If user_dst==1, then dst is a user virtual address;
// otherwise, dst is a kernel address.
int
readi(struct inode *ip, int user_dst, uint64 dst, uint off, uint n)
{
    80005d36:	711d                	addi	sp,sp,-96
    80005d38:	ec86                	sd	ra,88(sp)
    80005d3a:	e8a2                	sd	s0,80(sp)
    80005d3c:	e4a6                	sd	s1,72(sp)
    80005d3e:	1080                	addi	s0,sp,96
    80005d40:	faa43c23          	sd	a0,-72(s0)
    80005d44:	87ae                	mv	a5,a1
    80005d46:	fac43423          	sd	a2,-88(s0)
    80005d4a:	faf42a23          	sw	a5,-76(s0)
    80005d4e:	87b6                	mv	a5,a3
    80005d50:	faf42823          	sw	a5,-80(s0)
    80005d54:	87ba                	mv	a5,a4
    80005d56:	faf42223          	sw	a5,-92(s0)
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    80005d5a:	fb843783          	ld	a5,-72(s0)
    80005d5e:	47f8                	lw	a4,76(a5)
    80005d60:	fb042783          	lw	a5,-80(s0)
    80005d64:	2781                	sext.w	a5,a5
    80005d66:	00f76e63          	bltu	a4,a5,80005d82 <readi+0x4c>
    80005d6a:	fb042703          	lw	a4,-80(s0)
    80005d6e:	fa442783          	lw	a5,-92(s0)
    80005d72:	9fb9                	addw	a5,a5,a4
    80005d74:	0007871b          	sext.w	a4,a5
    80005d78:	fb042783          	lw	a5,-80(s0)
    80005d7c:	2781                	sext.w	a5,a5
    80005d7e:	00f77463          	bgeu	a4,a5,80005d86 <readi+0x50>
    return 0;
    80005d82:	4781                	li	a5,0
    80005d84:	aa05                	j	80005eb4 <readi+0x17e>
  if(off + n > ip->size)
    80005d86:	fb042703          	lw	a4,-80(s0)
    80005d8a:	fa442783          	lw	a5,-92(s0)
    80005d8e:	9fb9                	addw	a5,a5,a4
    80005d90:	0007871b          	sext.w	a4,a5
    80005d94:	fb843783          	ld	a5,-72(s0)
    80005d98:	47fc                	lw	a5,76(a5)
    80005d9a:	00e7fb63          	bgeu	a5,a4,80005db0 <readi+0x7a>
    n = ip->size - off;
    80005d9e:	fb843783          	ld	a5,-72(s0)
    80005da2:	47f8                	lw	a4,76(a5)
    80005da4:	fb042783          	lw	a5,-80(s0)
    80005da8:	40f707bb          	subw	a5,a4,a5
    80005dac:	faf42223          	sw	a5,-92(s0)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80005db0:	fc042e23          	sw	zero,-36(s0)
    80005db4:	a0f5                	j	80005ea0 <readi+0x16a>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    80005db6:	fb843783          	ld	a5,-72(s0)
    80005dba:	4384                	lw	s1,0(a5)
    80005dbc:	fb042783          	lw	a5,-80(s0)
    80005dc0:	00a7d79b          	srliw	a5,a5,0xa
    80005dc4:	2781                	sext.w	a5,a5
    80005dc6:	85be                	mv	a1,a5
    80005dc8:	fb843503          	ld	a0,-72(s0)
    80005dcc:	00000097          	auipc	ra,0x0
    80005dd0:	c60080e7          	jalr	-928(ra) # 80005a2c <bmap>
    80005dd4:	87aa                	mv	a5,a0
    80005dd6:	2781                	sext.w	a5,a5
    80005dd8:	85be                	mv	a1,a5
    80005dda:	8526                	mv	a0,s1
    80005ddc:	fffff097          	auipc	ra,0xfffff
    80005de0:	fdc080e7          	jalr	-36(ra) # 80004db8 <bread>
    80005de4:	fca43823          	sd	a0,-48(s0)
    m = min(n - tot, BSIZE - off%BSIZE);
    80005de8:	fb042783          	lw	a5,-80(s0)
    80005dec:	3ff7f793          	andi	a5,a5,1023
    80005df0:	2781                	sext.w	a5,a5
    80005df2:	40000713          	li	a4,1024
    80005df6:	40f707bb          	subw	a5,a4,a5
    80005dfa:	0007869b          	sext.w	a3,a5
    80005dfe:	fa442703          	lw	a4,-92(s0)
    80005e02:	fdc42783          	lw	a5,-36(s0)
    80005e06:	40f707bb          	subw	a5,a4,a5
    80005e0a:	2781                	sext.w	a5,a5
    80005e0c:	863e                	mv	a2,a5
    80005e0e:	87b6                	mv	a5,a3
    80005e10:	0007869b          	sext.w	a3,a5
    80005e14:	0006071b          	sext.w	a4,a2
    80005e18:	00d77363          	bgeu	a4,a3,80005e1e <readi+0xe8>
    80005e1c:	87b2                	mv	a5,a2
    80005e1e:	fcf42623          	sw	a5,-52(s0)
    if(either_copyout(user_dst, dst, bp->data + (off % BSIZE), m) == -1) {
    80005e22:	fd043783          	ld	a5,-48(s0)
    80005e26:	05878713          	addi	a4,a5,88
    80005e2a:	fb046783          	lwu	a5,-80(s0)
    80005e2e:	3ff7f793          	andi	a5,a5,1023
    80005e32:	973e                	add	a4,a4,a5
    80005e34:	fcc46683          	lwu	a3,-52(s0)
    80005e38:	fb442783          	lw	a5,-76(s0)
    80005e3c:	863a                	mv	a2,a4
    80005e3e:	fa843583          	ld	a1,-88(s0)
    80005e42:	853e                	mv	a0,a5
    80005e44:	ffffe097          	auipc	ra,0xffffe
    80005e48:	90a080e7          	jalr	-1782(ra) # 8000374e <either_copyout>
    80005e4c:	87aa                	mv	a5,a0
    80005e4e:	873e                	mv	a4,a5
    80005e50:	57fd                	li	a5,-1
    80005e52:	00f71c63          	bne	a4,a5,80005e6a <readi+0x134>
      brelse(bp);
    80005e56:	fd043503          	ld	a0,-48(s0)
    80005e5a:	fffff097          	auipc	ra,0xfffff
    80005e5e:	000080e7          	jalr	ra # 80004e5a <brelse>
      tot = -1;
    80005e62:	57fd                	li	a5,-1
    80005e64:	fcf42e23          	sw	a5,-36(s0)
      break;
    80005e68:	a0a1                	j	80005eb0 <readi+0x17a>
    }
    brelse(bp);
    80005e6a:	fd043503          	ld	a0,-48(s0)
    80005e6e:	fffff097          	auipc	ra,0xfffff
    80005e72:	fec080e7          	jalr	-20(ra) # 80004e5a <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80005e76:	fdc42703          	lw	a4,-36(s0)
    80005e7a:	fcc42783          	lw	a5,-52(s0)
    80005e7e:	9fb9                	addw	a5,a5,a4
    80005e80:	fcf42e23          	sw	a5,-36(s0)
    80005e84:	fb042703          	lw	a4,-80(s0)
    80005e88:	fcc42783          	lw	a5,-52(s0)
    80005e8c:	9fb9                	addw	a5,a5,a4
    80005e8e:	faf42823          	sw	a5,-80(s0)
    80005e92:	fcc46783          	lwu	a5,-52(s0)
    80005e96:	fa843703          	ld	a4,-88(s0)
    80005e9a:	97ba                	add	a5,a5,a4
    80005e9c:	faf43423          	sd	a5,-88(s0)
    80005ea0:	fdc42703          	lw	a4,-36(s0)
    80005ea4:	fa442783          	lw	a5,-92(s0)
    80005ea8:	2701                	sext.w	a4,a4
    80005eaa:	2781                	sext.w	a5,a5
    80005eac:	f0f765e3          	bltu	a4,a5,80005db6 <readi+0x80>
  }
  return tot;
    80005eb0:	fdc42783          	lw	a5,-36(s0)
}
    80005eb4:	853e                	mv	a0,a5
    80005eb6:	60e6                	ld	ra,88(sp)
    80005eb8:	6446                	ld	s0,80(sp)
    80005eba:	64a6                	ld	s1,72(sp)
    80005ebc:	6125                	addi	sp,sp,96
    80005ebe:	8082                	ret

0000000080005ec0 <writei>:
// Caller must hold ip->lock.
// If user_src==1, then src is a user virtual address;
// otherwise, src is a kernel address.
int
writei(struct inode *ip, int user_src, uint64 src, uint off, uint n)
{
    80005ec0:	711d                	addi	sp,sp,-96
    80005ec2:	ec86                	sd	ra,88(sp)
    80005ec4:	e8a2                	sd	s0,80(sp)
    80005ec6:	e4a6                	sd	s1,72(sp)
    80005ec8:	1080                	addi	s0,sp,96
    80005eca:	faa43c23          	sd	a0,-72(s0)
    80005ece:	87ae                	mv	a5,a1
    80005ed0:	fac43423          	sd	a2,-88(s0)
    80005ed4:	faf42a23          	sw	a5,-76(s0)
    80005ed8:	87b6                	mv	a5,a3
    80005eda:	faf42823          	sw	a5,-80(s0)
    80005ede:	87ba                	mv	a5,a4
    80005ee0:	faf42223          	sw	a5,-92(s0)
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    80005ee4:	fb843783          	ld	a5,-72(s0)
    80005ee8:	47f8                	lw	a4,76(a5)
    80005eea:	fb042783          	lw	a5,-80(s0)
    80005eee:	2781                	sext.w	a5,a5
    80005ef0:	00f76e63          	bltu	a4,a5,80005f0c <writei+0x4c>
    80005ef4:	fb042703          	lw	a4,-80(s0)
    80005ef8:	fa442783          	lw	a5,-92(s0)
    80005efc:	9fb9                	addw	a5,a5,a4
    80005efe:	0007871b          	sext.w	a4,a5
    80005f02:	fb042783          	lw	a5,-80(s0)
    80005f06:	2781                	sext.w	a5,a5
    80005f08:	00f77463          	bgeu	a4,a5,80005f10 <writei+0x50>
    return -1;
    80005f0c:	57fd                	li	a5,-1
    80005f0e:	aaa9                	j	80006068 <writei+0x1a8>
  if(off + n > MAXFILE*BSIZE)
    80005f10:	fb042703          	lw	a4,-80(s0)
    80005f14:	fa442783          	lw	a5,-92(s0)
    80005f18:	9fb9                	addw	a5,a5,a4
    80005f1a:	2781                	sext.w	a5,a5
    80005f1c:	873e                	mv	a4,a5
    80005f1e:	000437b7          	lui	a5,0x43
    80005f22:	00e7f463          	bgeu	a5,a4,80005f2a <writei+0x6a>
    return -1;
    80005f26:	57fd                	li	a5,-1
    80005f28:	a281                	j	80006068 <writei+0x1a8>

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80005f2a:	fc042e23          	sw	zero,-36(s0)
    80005f2e:	a8e5                	j	80006026 <writei+0x166>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    80005f30:	fb843783          	ld	a5,-72(s0)
    80005f34:	4384                	lw	s1,0(a5)
    80005f36:	fb042783          	lw	a5,-80(s0)
    80005f3a:	00a7d79b          	srliw	a5,a5,0xa
    80005f3e:	2781                	sext.w	a5,a5
    80005f40:	85be                	mv	a1,a5
    80005f42:	fb843503          	ld	a0,-72(s0)
    80005f46:	00000097          	auipc	ra,0x0
    80005f4a:	ae6080e7          	jalr	-1306(ra) # 80005a2c <bmap>
    80005f4e:	87aa                	mv	a5,a0
    80005f50:	2781                	sext.w	a5,a5
    80005f52:	85be                	mv	a1,a5
    80005f54:	8526                	mv	a0,s1
    80005f56:	fffff097          	auipc	ra,0xfffff
    80005f5a:	e62080e7          	jalr	-414(ra) # 80004db8 <bread>
    80005f5e:	fca43823          	sd	a0,-48(s0)
    m = min(n - tot, BSIZE - off%BSIZE);
    80005f62:	fb042783          	lw	a5,-80(s0)
    80005f66:	3ff7f793          	andi	a5,a5,1023
    80005f6a:	2781                	sext.w	a5,a5
    80005f6c:	40000713          	li	a4,1024
    80005f70:	40f707bb          	subw	a5,a4,a5
    80005f74:	0007869b          	sext.w	a3,a5
    80005f78:	fa442703          	lw	a4,-92(s0)
    80005f7c:	fdc42783          	lw	a5,-36(s0)
    80005f80:	40f707bb          	subw	a5,a4,a5
    80005f84:	2781                	sext.w	a5,a5
    80005f86:	863e                	mv	a2,a5
    80005f88:	87b6                	mv	a5,a3
    80005f8a:	0007869b          	sext.w	a3,a5
    80005f8e:	0006071b          	sext.w	a4,a2
    80005f92:	00d77363          	bgeu	a4,a3,80005f98 <writei+0xd8>
    80005f96:	87b2                	mv	a5,a2
    80005f98:	fcf42623          	sw	a5,-52(s0)
    if(either_copyin(bp->data + (off % BSIZE), user_src, src, m) == -1) {
    80005f9c:	fd043783          	ld	a5,-48(s0)
    80005fa0:	05878713          	addi	a4,a5,88 # 43058 <_entry-0x7ffbcfa8>
    80005fa4:	fb046783          	lwu	a5,-80(s0)
    80005fa8:	3ff7f793          	andi	a5,a5,1023
    80005fac:	97ba                	add	a5,a5,a4
    80005fae:	fcc46683          	lwu	a3,-52(s0)
    80005fb2:	fb442703          	lw	a4,-76(s0)
    80005fb6:	fa843603          	ld	a2,-88(s0)
    80005fba:	85ba                	mv	a1,a4
    80005fbc:	853e                	mv	a0,a5
    80005fbe:	ffffe097          	auipc	ra,0xffffe
    80005fc2:	80a080e7          	jalr	-2038(ra) # 800037c8 <either_copyin>
    80005fc6:	87aa                	mv	a5,a0
    80005fc8:	873e                	mv	a4,a5
    80005fca:	57fd                	li	a5,-1
    80005fcc:	00f71c63          	bne	a4,a5,80005fe4 <writei+0x124>
      brelse(bp);
    80005fd0:	fd043503          	ld	a0,-48(s0)
    80005fd4:	fffff097          	auipc	ra,0xfffff
    80005fd8:	e86080e7          	jalr	-378(ra) # 80004e5a <brelse>
      n = -1;
    80005fdc:	57fd                	li	a5,-1
    80005fde:	faf42223          	sw	a5,-92(s0)
      break;
    80005fe2:	a891                	j	80006036 <writei+0x176>
    }
    log_write(bp);
    80005fe4:	fd043503          	ld	a0,-48(s0)
    80005fe8:	00001097          	auipc	ra,0x1
    80005fec:	b02080e7          	jalr	-1278(ra) # 80006aea <log_write>
    brelse(bp);
    80005ff0:	fd043503          	ld	a0,-48(s0)
    80005ff4:	fffff097          	auipc	ra,0xfffff
    80005ff8:	e66080e7          	jalr	-410(ra) # 80004e5a <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80005ffc:	fdc42703          	lw	a4,-36(s0)
    80006000:	fcc42783          	lw	a5,-52(s0)
    80006004:	9fb9                	addw	a5,a5,a4
    80006006:	fcf42e23          	sw	a5,-36(s0)
    8000600a:	fb042703          	lw	a4,-80(s0)
    8000600e:	fcc42783          	lw	a5,-52(s0)
    80006012:	9fb9                	addw	a5,a5,a4
    80006014:	faf42823          	sw	a5,-80(s0)
    80006018:	fcc46783          	lwu	a5,-52(s0)
    8000601c:	fa843703          	ld	a4,-88(s0)
    80006020:	97ba                	add	a5,a5,a4
    80006022:	faf43423          	sd	a5,-88(s0)
    80006026:	fdc42703          	lw	a4,-36(s0)
    8000602a:	fa442783          	lw	a5,-92(s0)
    8000602e:	2701                	sext.w	a4,a4
    80006030:	2781                	sext.w	a5,a5
    80006032:	eef76fe3          	bltu	a4,a5,80005f30 <writei+0x70>
  }

  if(n > 0){
    80006036:	fa442783          	lw	a5,-92(s0)
    8000603a:	2781                	sext.w	a5,a5
    8000603c:	c785                	beqz	a5,80006064 <writei+0x1a4>
    if(off > ip->size)
    8000603e:	fb843783          	ld	a5,-72(s0)
    80006042:	47f8                	lw	a4,76(a5)
    80006044:	fb042783          	lw	a5,-80(s0)
    80006048:	2781                	sext.w	a5,a5
    8000604a:	00f77763          	bgeu	a4,a5,80006058 <writei+0x198>
      ip->size = off;
    8000604e:	fb843783          	ld	a5,-72(s0)
    80006052:	fb042703          	lw	a4,-80(s0)
    80006056:	c7f8                	sw	a4,76(a5)
    // write the i-node back to disk even if the size didn't change
    // because the loop above might have called bmap() and added a new
    // block to ip->addrs[].
    iupdate(ip);
    80006058:	fb843503          	ld	a0,-72(s0)
    8000605c:	fffff097          	auipc	ra,0xfffff
    80006060:	4f4080e7          	jalr	1268(ra) # 80005550 <iupdate>
  }

  return n;
    80006064:	fa442783          	lw	a5,-92(s0)
}
    80006068:	853e                	mv	a0,a5
    8000606a:	60e6                	ld	ra,88(sp)
    8000606c:	6446                	ld	s0,80(sp)
    8000606e:	64a6                	ld	s1,72(sp)
    80006070:	6125                	addi	sp,sp,96
    80006072:	8082                	ret

0000000080006074 <namecmp>:

// Directories

int
namecmp(const char *s, const char *t)
{
    80006074:	1101                	addi	sp,sp,-32
    80006076:	ec06                	sd	ra,24(sp)
    80006078:	e822                	sd	s0,16(sp)
    8000607a:	1000                	addi	s0,sp,32
    8000607c:	fea43423          	sd	a0,-24(s0)
    80006080:	feb43023          	sd	a1,-32(s0)
  return strncmp(s, t, DIRSIZ);
    80006084:	4639                	li	a2,14
    80006086:	fe043583          	ld	a1,-32(s0)
    8000608a:	fe843503          	ld	a0,-24(s0)
    8000608e:	ffffb097          	auipc	ra,0xffffb
    80006092:	5b0080e7          	jalr	1456(ra) # 8000163e <strncmp>
    80006096:	87aa                	mv	a5,a0
}
    80006098:	853e                	mv	a0,a5
    8000609a:	60e2                	ld	ra,24(sp)
    8000609c:	6442                	ld	s0,16(sp)
    8000609e:	6105                	addi	sp,sp,32
    800060a0:	8082                	ret

00000000800060a2 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
    800060a2:	715d                	addi	sp,sp,-80
    800060a4:	e486                	sd	ra,72(sp)
    800060a6:	e0a2                	sd	s0,64(sp)
    800060a8:	0880                	addi	s0,sp,80
    800060aa:	fca43423          	sd	a0,-56(s0)
    800060ae:	fcb43023          	sd	a1,-64(s0)
    800060b2:	fac43c23          	sd	a2,-72(s0)
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    800060b6:	fc843783          	ld	a5,-56(s0)
    800060ba:	04479783          	lh	a5,68(a5)
    800060be:	0007871b          	sext.w	a4,a5
    800060c2:	4785                	li	a5,1
    800060c4:	00f70a63          	beq	a4,a5,800060d8 <dirlookup+0x36>
    panic("dirlookup not DIR");
    800060c8:	00006517          	auipc	a0,0x6
    800060cc:	41850513          	addi	a0,a0,1048 # 8000c4e0 <etext+0x4e0>
    800060d0:	ffffb097          	auipc	ra,0xffffb
    800060d4:	b82080e7          	jalr	-1150(ra) # 80000c52 <panic>

  for(off = 0; off < dp->size; off += sizeof(de)){
    800060d8:	fe042623          	sw	zero,-20(s0)
    800060dc:	a849                	j	8000616e <dirlookup+0xcc>
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    800060de:	fd840793          	addi	a5,s0,-40
    800060e2:	fec42683          	lw	a3,-20(s0)
    800060e6:	4741                	li	a4,16
    800060e8:	863e                	mv	a2,a5
    800060ea:	4581                	li	a1,0
    800060ec:	fc843503          	ld	a0,-56(s0)
    800060f0:	00000097          	auipc	ra,0x0
    800060f4:	c46080e7          	jalr	-954(ra) # 80005d36 <readi>
    800060f8:	87aa                	mv	a5,a0
    800060fa:	873e                	mv	a4,a5
    800060fc:	47c1                	li	a5,16
    800060fe:	00f70a63          	beq	a4,a5,80006112 <dirlookup+0x70>
      panic("dirlookup read");
    80006102:	00006517          	auipc	a0,0x6
    80006106:	3f650513          	addi	a0,a0,1014 # 8000c4f8 <etext+0x4f8>
    8000610a:	ffffb097          	auipc	ra,0xffffb
    8000610e:	b48080e7          	jalr	-1208(ra) # 80000c52 <panic>
    if(de.inum == 0)
    80006112:	fd845783          	lhu	a5,-40(s0)
    80006116:	c7b1                	beqz	a5,80006162 <dirlookup+0xc0>
      continue;
    if(namecmp(name, de.name) == 0){
    80006118:	fd840793          	addi	a5,s0,-40
    8000611c:	0789                	addi	a5,a5,2
    8000611e:	85be                	mv	a1,a5
    80006120:	fc043503          	ld	a0,-64(s0)
    80006124:	00000097          	auipc	ra,0x0
    80006128:	f50080e7          	jalr	-176(ra) # 80006074 <namecmp>
    8000612c:	87aa                	mv	a5,a0
    8000612e:	eb9d                	bnez	a5,80006164 <dirlookup+0xc2>
      // entry matches path element
      if(poff)
    80006130:	fb843783          	ld	a5,-72(s0)
    80006134:	c791                	beqz	a5,80006140 <dirlookup+0x9e>
        *poff = off;
    80006136:	fb843783          	ld	a5,-72(s0)
    8000613a:	fec42703          	lw	a4,-20(s0)
    8000613e:	c398                	sw	a4,0(a5)
      inum = de.inum;
    80006140:	fd845783          	lhu	a5,-40(s0)
    80006144:	fef42423          	sw	a5,-24(s0)
      return iget(dp->dev, inum);
    80006148:	fc843783          	ld	a5,-56(s0)
    8000614c:	439c                	lw	a5,0(a5)
    8000614e:	fe842703          	lw	a4,-24(s0)
    80006152:	85ba                	mv	a1,a4
    80006154:	853e                	mv	a0,a5
    80006156:	fffff097          	auipc	ra,0xfffff
    8000615a:	4e2080e7          	jalr	1250(ra) # 80005638 <iget>
    8000615e:	87aa                	mv	a5,a0
    80006160:	a005                	j	80006180 <dirlookup+0xde>
      continue;
    80006162:	0001                	nop
  for(off = 0; off < dp->size; off += sizeof(de)){
    80006164:	fec42783          	lw	a5,-20(s0)
    80006168:	27c1                	addiw	a5,a5,16
    8000616a:	fef42623          	sw	a5,-20(s0)
    8000616e:	fc843783          	ld	a5,-56(s0)
    80006172:	47f8                	lw	a4,76(a5)
    80006174:	fec42783          	lw	a5,-20(s0)
    80006178:	2781                	sext.w	a5,a5
    8000617a:	f6e7e2e3          	bltu	a5,a4,800060de <dirlookup+0x3c>
    }
  }

  return 0;
    8000617e:	4781                	li	a5,0
}
    80006180:	853e                	mv	a0,a5
    80006182:	60a6                	ld	ra,72(sp)
    80006184:	6406                	ld	s0,64(sp)
    80006186:	6161                	addi	sp,sp,80
    80006188:	8082                	ret

000000008000618a <dirlink>:

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
    8000618a:	715d                	addi	sp,sp,-80
    8000618c:	e486                	sd	ra,72(sp)
    8000618e:	e0a2                	sd	s0,64(sp)
    80006190:	0880                	addi	s0,sp,80
    80006192:	fca43423          	sd	a0,-56(s0)
    80006196:	fcb43023          	sd	a1,-64(s0)
    8000619a:	87b2                	mv	a5,a2
    8000619c:	faf42e23          	sw	a5,-68(s0)
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
    800061a0:	4601                	li	a2,0
    800061a2:	fc043583          	ld	a1,-64(s0)
    800061a6:	fc843503          	ld	a0,-56(s0)
    800061aa:	00000097          	auipc	ra,0x0
    800061ae:	ef8080e7          	jalr	-264(ra) # 800060a2 <dirlookup>
    800061b2:	fea43023          	sd	a0,-32(s0)
    800061b6:	fe043783          	ld	a5,-32(s0)
    800061ba:	cb89                	beqz	a5,800061cc <dirlink+0x42>
    iput(ip);
    800061bc:	fe043503          	ld	a0,-32(s0)
    800061c0:	fffff097          	auipc	ra,0xfffff
    800061c4:	76e080e7          	jalr	1902(ra) # 8000592e <iput>
    return -1;
    800061c8:	57fd                	li	a5,-1
    800061ca:	a865                	j	80006282 <dirlink+0xf8>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
    800061cc:	fe042623          	sw	zero,-20(s0)
    800061d0:	a0a1                	j	80006218 <dirlink+0x8e>
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    800061d2:	fd040793          	addi	a5,s0,-48
    800061d6:	fec42683          	lw	a3,-20(s0)
    800061da:	4741                	li	a4,16
    800061dc:	863e                	mv	a2,a5
    800061de:	4581                	li	a1,0
    800061e0:	fc843503          	ld	a0,-56(s0)
    800061e4:	00000097          	auipc	ra,0x0
    800061e8:	b52080e7          	jalr	-1198(ra) # 80005d36 <readi>
    800061ec:	87aa                	mv	a5,a0
    800061ee:	873e                	mv	a4,a5
    800061f0:	47c1                	li	a5,16
    800061f2:	00f70a63          	beq	a4,a5,80006206 <dirlink+0x7c>
      panic("dirlink read");
    800061f6:	00006517          	auipc	a0,0x6
    800061fa:	31250513          	addi	a0,a0,786 # 8000c508 <etext+0x508>
    800061fe:	ffffb097          	auipc	ra,0xffffb
    80006202:	a54080e7          	jalr	-1452(ra) # 80000c52 <panic>
    if(de.inum == 0)
    80006206:	fd045783          	lhu	a5,-48(s0)
    8000620a:	cf99                	beqz	a5,80006228 <dirlink+0x9e>
  for(off = 0; off < dp->size; off += sizeof(de)){
    8000620c:	fec42783          	lw	a5,-20(s0)
    80006210:	27c1                	addiw	a5,a5,16
    80006212:	2781                	sext.w	a5,a5
    80006214:	fef42623          	sw	a5,-20(s0)
    80006218:	fc843783          	ld	a5,-56(s0)
    8000621c:	47f8                	lw	a4,76(a5)
    8000621e:	fec42783          	lw	a5,-20(s0)
    80006222:	fae7e8e3          	bltu	a5,a4,800061d2 <dirlink+0x48>
    80006226:	a011                	j	8000622a <dirlink+0xa0>
      break;
    80006228:	0001                	nop
  }

  strncpy(de.name, name, DIRSIZ);
    8000622a:	fd040793          	addi	a5,s0,-48
    8000622e:	0789                	addi	a5,a5,2
    80006230:	4639                	li	a2,14
    80006232:	fc043583          	ld	a1,-64(s0)
    80006236:	853e                	mv	a0,a5
    80006238:	ffffb097          	auipc	ra,0xffffb
    8000623c:	490080e7          	jalr	1168(ra) # 800016c8 <strncpy>
  de.inum = inum;
    80006240:	fbc42783          	lw	a5,-68(s0)
    80006244:	17c2                	slli	a5,a5,0x30
    80006246:	93c1                	srli	a5,a5,0x30
    80006248:	fcf41823          	sh	a5,-48(s0)
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    8000624c:	fd040793          	addi	a5,s0,-48
    80006250:	fec42683          	lw	a3,-20(s0)
    80006254:	4741                	li	a4,16
    80006256:	863e                	mv	a2,a5
    80006258:	4581                	li	a1,0
    8000625a:	fc843503          	ld	a0,-56(s0)
    8000625e:	00000097          	auipc	ra,0x0
    80006262:	c62080e7          	jalr	-926(ra) # 80005ec0 <writei>
    80006266:	87aa                	mv	a5,a0
    80006268:	873e                	mv	a4,a5
    8000626a:	47c1                	li	a5,16
    8000626c:	00f70a63          	beq	a4,a5,80006280 <dirlink+0xf6>
    panic("dirlink");
    80006270:	00006517          	auipc	a0,0x6
    80006274:	2a850513          	addi	a0,a0,680 # 8000c518 <etext+0x518>
    80006278:	ffffb097          	auipc	ra,0xffffb
    8000627c:	9da080e7          	jalr	-1574(ra) # 80000c52 <panic>

  return 0;
    80006280:	4781                	li	a5,0
}
    80006282:	853e                	mv	a0,a5
    80006284:	60a6                	ld	ra,72(sp)
    80006286:	6406                	ld	s0,64(sp)
    80006288:	6161                	addi	sp,sp,80
    8000628a:	8082                	ret

000000008000628c <skipelem>:
//   skipelem("a", name) = "", setting name = "a"
//   skipelem("", name) = skipelem("////", name) = 0
//
static char*
skipelem(char *path, char *name)
{
    8000628c:	7179                	addi	sp,sp,-48
    8000628e:	f406                	sd	ra,40(sp)
    80006290:	f022                	sd	s0,32(sp)
    80006292:	1800                	addi	s0,sp,48
    80006294:	fca43c23          	sd	a0,-40(s0)
    80006298:	fcb43823          	sd	a1,-48(s0)
  char *s;
  int len;

  while(*path == '/')
    8000629c:	a031                	j	800062a8 <skipelem+0x1c>
    path++;
    8000629e:	fd843783          	ld	a5,-40(s0)
    800062a2:	0785                	addi	a5,a5,1
    800062a4:	fcf43c23          	sd	a5,-40(s0)
  while(*path == '/')
    800062a8:	fd843783          	ld	a5,-40(s0)
    800062ac:	0007c783          	lbu	a5,0(a5)
    800062b0:	873e                	mv	a4,a5
    800062b2:	02f00793          	li	a5,47
    800062b6:	fef704e3          	beq	a4,a5,8000629e <skipelem+0x12>
  if(*path == 0)
    800062ba:	fd843783          	ld	a5,-40(s0)
    800062be:	0007c783          	lbu	a5,0(a5)
    800062c2:	e399                	bnez	a5,800062c8 <skipelem+0x3c>
    return 0;
    800062c4:	4781                	li	a5,0
    800062c6:	a06d                	j	80006370 <skipelem+0xe4>
  s = path;
    800062c8:	fd843783          	ld	a5,-40(s0)
    800062cc:	fef43423          	sd	a5,-24(s0)
  while(*path != '/' && *path != 0)
    800062d0:	a031                	j	800062dc <skipelem+0x50>
    path++;
    800062d2:	fd843783          	ld	a5,-40(s0)
    800062d6:	0785                	addi	a5,a5,1
    800062d8:	fcf43c23          	sd	a5,-40(s0)
  while(*path != '/' && *path != 0)
    800062dc:	fd843783          	ld	a5,-40(s0)
    800062e0:	0007c783          	lbu	a5,0(a5)
    800062e4:	873e                	mv	a4,a5
    800062e6:	02f00793          	li	a5,47
    800062ea:	00f70763          	beq	a4,a5,800062f8 <skipelem+0x6c>
    800062ee:	fd843783          	ld	a5,-40(s0)
    800062f2:	0007c783          	lbu	a5,0(a5)
    800062f6:	fff1                	bnez	a5,800062d2 <skipelem+0x46>
  len = path - s;
    800062f8:	fd843703          	ld	a4,-40(s0)
    800062fc:	fe843783          	ld	a5,-24(s0)
    80006300:	40f707b3          	sub	a5,a4,a5
    80006304:	fef42223          	sw	a5,-28(s0)
  if(len >= DIRSIZ)
    80006308:	fe442783          	lw	a5,-28(s0)
    8000630c:	0007871b          	sext.w	a4,a5
    80006310:	47b5                	li	a5,13
    80006312:	00e7dc63          	bge	a5,a4,8000632a <skipelem+0x9e>
    memmove(name, s, DIRSIZ);
    80006316:	4639                	li	a2,14
    80006318:	fe843583          	ld	a1,-24(s0)
    8000631c:	fd043503          	ld	a0,-48(s0)
    80006320:	ffffb097          	auipc	ra,0xffffb
    80006324:	218080e7          	jalr	536(ra) # 80001538 <memmove>
    80006328:	a80d                	j	8000635a <skipelem+0xce>
  else {
    memmove(name, s, len);
    8000632a:	fe442783          	lw	a5,-28(s0)
    8000632e:	863e                	mv	a2,a5
    80006330:	fe843583          	ld	a1,-24(s0)
    80006334:	fd043503          	ld	a0,-48(s0)
    80006338:	ffffb097          	auipc	ra,0xffffb
    8000633c:	200080e7          	jalr	512(ra) # 80001538 <memmove>
    name[len] = 0;
    80006340:	fe442783          	lw	a5,-28(s0)
    80006344:	fd043703          	ld	a4,-48(s0)
    80006348:	97ba                	add	a5,a5,a4
    8000634a:	00078023          	sb	zero,0(a5)
  }
  while(*path == '/')
    8000634e:	a031                	j	8000635a <skipelem+0xce>
    path++;
    80006350:	fd843783          	ld	a5,-40(s0)
    80006354:	0785                	addi	a5,a5,1
    80006356:	fcf43c23          	sd	a5,-40(s0)
  while(*path == '/')
    8000635a:	fd843783          	ld	a5,-40(s0)
    8000635e:	0007c783          	lbu	a5,0(a5)
    80006362:	873e                	mv	a4,a5
    80006364:	02f00793          	li	a5,47
    80006368:	fef704e3          	beq	a4,a5,80006350 <skipelem+0xc4>
  return path;
    8000636c:	fd843783          	ld	a5,-40(s0)
}
    80006370:	853e                	mv	a0,a5
    80006372:	70a2                	ld	ra,40(sp)
    80006374:	7402                	ld	s0,32(sp)
    80006376:	6145                	addi	sp,sp,48
    80006378:	8082                	ret

000000008000637a <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
    8000637a:	7139                	addi	sp,sp,-64
    8000637c:	fc06                	sd	ra,56(sp)
    8000637e:	f822                	sd	s0,48(sp)
    80006380:	0080                	addi	s0,sp,64
    80006382:	fca43c23          	sd	a0,-40(s0)
    80006386:	87ae                	mv	a5,a1
    80006388:	fcc43423          	sd	a2,-56(s0)
    8000638c:	fcf42a23          	sw	a5,-44(s0)
  struct inode *ip, *next;

  if(*path == '/')
    80006390:	fd843783          	ld	a5,-40(s0)
    80006394:	0007c783          	lbu	a5,0(a5)
    80006398:	873e                	mv	a4,a5
    8000639a:	02f00793          	li	a5,47
    8000639e:	00f71b63          	bne	a4,a5,800063b4 <namex+0x3a>
    ip = iget(ROOTDEV, ROOTINO);
    800063a2:	4585                	li	a1,1
    800063a4:	4505                	li	a0,1
    800063a6:	fffff097          	auipc	ra,0xfffff
    800063aa:	292080e7          	jalr	658(ra) # 80005638 <iget>
    800063ae:	fea43423          	sd	a0,-24(s0)
    800063b2:	a85d                	j	80006468 <namex+0xee>
  else
    ip = idup(myproc()->cwd);
    800063b4:	ffffc097          	auipc	ra,0xffffc
    800063b8:	444080e7          	jalr	1092(ra) # 800027f8 <myproc>
    800063bc:	872a                	mv	a4,a0
    800063be:	6785                	lui	a5,0x1
    800063c0:	97ba                	add	a5,a5,a4
    800063c2:	3b07b783          	ld	a5,944(a5) # 13b0 <_entry-0x7fffec50>
    800063c6:	853e                	mv	a0,a5
    800063c8:	fffff097          	auipc	ra,0xfffff
    800063cc:	38c080e7          	jalr	908(ra) # 80005754 <idup>
    800063d0:	fea43423          	sd	a0,-24(s0)

  while((path = skipelem(path, name)) != 0){
    800063d4:	a851                	j	80006468 <namex+0xee>
    ilock(ip);
    800063d6:	fe843503          	ld	a0,-24(s0)
    800063da:	fffff097          	auipc	ra,0xfffff
    800063de:	3c6080e7          	jalr	966(ra) # 800057a0 <ilock>
    if(ip->type != T_DIR){
    800063e2:	fe843783          	ld	a5,-24(s0)
    800063e6:	04479783          	lh	a5,68(a5)
    800063ea:	0007871b          	sext.w	a4,a5
    800063ee:	4785                	li	a5,1
    800063f0:	00f70a63          	beq	a4,a5,80006404 <namex+0x8a>
      iunlockput(ip);
    800063f4:	fe843503          	ld	a0,-24(s0)
    800063f8:	fffff097          	auipc	ra,0xfffff
    800063fc:	606080e7          	jalr	1542(ra) # 800059fe <iunlockput>
      return 0;
    80006400:	4781                	li	a5,0
    80006402:	a871                	j	8000649e <namex+0x124>
    }
    if(nameiparent && *path == '\0'){
    80006404:	fd442783          	lw	a5,-44(s0)
    80006408:	2781                	sext.w	a5,a5
    8000640a:	cf99                	beqz	a5,80006428 <namex+0xae>
    8000640c:	fd843783          	ld	a5,-40(s0)
    80006410:	0007c783          	lbu	a5,0(a5)
    80006414:	eb91                	bnez	a5,80006428 <namex+0xae>
      // Stop one level early.
      iunlock(ip);
    80006416:	fe843503          	ld	a0,-24(s0)
    8000641a:	fffff097          	auipc	ra,0xfffff
    8000641e:	4ba080e7          	jalr	1210(ra) # 800058d4 <iunlock>
      return ip;
    80006422:	fe843783          	ld	a5,-24(s0)
    80006426:	a8a5                	j	8000649e <namex+0x124>
    }
    if((next = dirlookup(ip, name, 0)) == 0){
    80006428:	4601                	li	a2,0
    8000642a:	fc843583          	ld	a1,-56(s0)
    8000642e:	fe843503          	ld	a0,-24(s0)
    80006432:	00000097          	auipc	ra,0x0
    80006436:	c70080e7          	jalr	-912(ra) # 800060a2 <dirlookup>
    8000643a:	fea43023          	sd	a0,-32(s0)
    8000643e:	fe043783          	ld	a5,-32(s0)
    80006442:	eb89                	bnez	a5,80006454 <namex+0xda>
      iunlockput(ip);
    80006444:	fe843503          	ld	a0,-24(s0)
    80006448:	fffff097          	auipc	ra,0xfffff
    8000644c:	5b6080e7          	jalr	1462(ra) # 800059fe <iunlockput>
      return 0;
    80006450:	4781                	li	a5,0
    80006452:	a0b1                	j	8000649e <namex+0x124>
    }
    iunlockput(ip);
    80006454:	fe843503          	ld	a0,-24(s0)
    80006458:	fffff097          	auipc	ra,0xfffff
    8000645c:	5a6080e7          	jalr	1446(ra) # 800059fe <iunlockput>
    ip = next;
    80006460:	fe043783          	ld	a5,-32(s0)
    80006464:	fef43423          	sd	a5,-24(s0)
  while((path = skipelem(path, name)) != 0){
    80006468:	fc843583          	ld	a1,-56(s0)
    8000646c:	fd843503          	ld	a0,-40(s0)
    80006470:	00000097          	auipc	ra,0x0
    80006474:	e1c080e7          	jalr	-484(ra) # 8000628c <skipelem>
    80006478:	fca43c23          	sd	a0,-40(s0)
    8000647c:	fd843783          	ld	a5,-40(s0)
    80006480:	fbb9                	bnez	a5,800063d6 <namex+0x5c>
  }
  if(nameiparent){
    80006482:	fd442783          	lw	a5,-44(s0)
    80006486:	2781                	sext.w	a5,a5
    80006488:	cb89                	beqz	a5,8000649a <namex+0x120>
    iput(ip);
    8000648a:	fe843503          	ld	a0,-24(s0)
    8000648e:	fffff097          	auipc	ra,0xfffff
    80006492:	4a0080e7          	jalr	1184(ra) # 8000592e <iput>
    return 0;
    80006496:	4781                	li	a5,0
    80006498:	a019                	j	8000649e <namex+0x124>
  }
  return ip;
    8000649a:	fe843783          	ld	a5,-24(s0)
}
    8000649e:	853e                	mv	a0,a5
    800064a0:	70e2                	ld	ra,56(sp)
    800064a2:	7442                	ld	s0,48(sp)
    800064a4:	6121                	addi	sp,sp,64
    800064a6:	8082                	ret

00000000800064a8 <namei>:

struct inode*
namei(char *path)
{
    800064a8:	7179                	addi	sp,sp,-48
    800064aa:	f406                	sd	ra,40(sp)
    800064ac:	f022                	sd	s0,32(sp)
    800064ae:	1800                	addi	s0,sp,48
    800064b0:	fca43c23          	sd	a0,-40(s0)
  char name[DIRSIZ];
  return namex(path, 0, name);
    800064b4:	fe040793          	addi	a5,s0,-32
    800064b8:	863e                	mv	a2,a5
    800064ba:	4581                	li	a1,0
    800064bc:	fd843503          	ld	a0,-40(s0)
    800064c0:	00000097          	auipc	ra,0x0
    800064c4:	eba080e7          	jalr	-326(ra) # 8000637a <namex>
    800064c8:	87aa                	mv	a5,a0
}
    800064ca:	853e                	mv	a0,a5
    800064cc:	70a2                	ld	ra,40(sp)
    800064ce:	7402                	ld	s0,32(sp)
    800064d0:	6145                	addi	sp,sp,48
    800064d2:	8082                	ret

00000000800064d4 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
    800064d4:	1101                	addi	sp,sp,-32
    800064d6:	ec06                	sd	ra,24(sp)
    800064d8:	e822                	sd	s0,16(sp)
    800064da:	1000                	addi	s0,sp,32
    800064dc:	fea43423          	sd	a0,-24(s0)
    800064e0:	feb43023          	sd	a1,-32(s0)
  return namex(path, 1, name);
    800064e4:	fe043603          	ld	a2,-32(s0)
    800064e8:	4585                	li	a1,1
    800064ea:	fe843503          	ld	a0,-24(s0)
    800064ee:	00000097          	auipc	ra,0x0
    800064f2:	e8c080e7          	jalr	-372(ra) # 8000637a <namex>
    800064f6:	87aa                	mv	a5,a0
}
    800064f8:	853e                	mv	a0,a5
    800064fa:	60e2                	ld	ra,24(sp)
    800064fc:	6442                	ld	s0,16(sp)
    800064fe:	6105                	addi	sp,sp,32
    80006500:	8082                	ret

0000000080006502 <initlog>:
static void recover_from_log(void);
static void commit();

void
initlog(int dev, struct superblock *sb)
{
    80006502:	1101                	addi	sp,sp,-32
    80006504:	ec06                	sd	ra,24(sp)
    80006506:	e822                	sd	s0,16(sp)
    80006508:	1000                	addi	s0,sp,32
    8000650a:	87aa                	mv	a5,a0
    8000650c:	feb43023          	sd	a1,-32(s0)
    80006510:	fef42623          	sw	a5,-20(s0)
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  initlock(&log.lock, "log");
    80006514:	00006597          	auipc	a1,0x6
    80006518:	00c58593          	addi	a1,a1,12 # 8000c520 <etext+0x520>
    8000651c:	00068517          	auipc	a0,0x68
    80006520:	53450513          	addi	a0,a0,1332 # 8006ea50 <log>
    80006524:	ffffb097          	auipc	ra,0xffffb
    80006528:	d2c080e7          	jalr	-724(ra) # 80001250 <initlock>
  log.start = sb->logstart;
    8000652c:	fe043783          	ld	a5,-32(s0)
    80006530:	4bdc                	lw	a5,20(a5)
    80006532:	0007871b          	sext.w	a4,a5
    80006536:	00068797          	auipc	a5,0x68
    8000653a:	51a78793          	addi	a5,a5,1306 # 8006ea50 <log>
    8000653e:	cf98                	sw	a4,24(a5)
  log.size = sb->nlog;
    80006540:	fe043783          	ld	a5,-32(s0)
    80006544:	4b9c                	lw	a5,16(a5)
    80006546:	0007871b          	sext.w	a4,a5
    8000654a:	00068797          	auipc	a5,0x68
    8000654e:	50678793          	addi	a5,a5,1286 # 8006ea50 <log>
    80006552:	cfd8                	sw	a4,28(a5)
  log.dev = dev;
    80006554:	00068797          	auipc	a5,0x68
    80006558:	4fc78793          	addi	a5,a5,1276 # 8006ea50 <log>
    8000655c:	fec42703          	lw	a4,-20(s0)
    80006560:	d798                	sw	a4,40(a5)
  recover_from_log();
    80006562:	00000097          	auipc	ra,0x0
    80006566:	272080e7          	jalr	626(ra) # 800067d4 <recover_from_log>
}
    8000656a:	0001                	nop
    8000656c:	60e2                	ld	ra,24(sp)
    8000656e:	6442                	ld	s0,16(sp)
    80006570:	6105                	addi	sp,sp,32
    80006572:	8082                	ret

0000000080006574 <install_trans>:

// Copy committed blocks from log to their home location
static void
install_trans(int recovering)
{
    80006574:	7139                	addi	sp,sp,-64
    80006576:	fc06                	sd	ra,56(sp)
    80006578:	f822                	sd	s0,48(sp)
    8000657a:	0080                	addi	s0,sp,64
    8000657c:	87aa                	mv	a5,a0
    8000657e:	fcf42623          	sw	a5,-52(s0)
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    80006582:	fe042623          	sw	zero,-20(s0)
    80006586:	a0f9                	j	80006654 <install_trans+0xe0>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    80006588:	00068797          	auipc	a5,0x68
    8000658c:	4c878793          	addi	a5,a5,1224 # 8006ea50 <log>
    80006590:	579c                	lw	a5,40(a5)
    80006592:	0007869b          	sext.w	a3,a5
    80006596:	00068797          	auipc	a5,0x68
    8000659a:	4ba78793          	addi	a5,a5,1210 # 8006ea50 <log>
    8000659e:	4f9c                	lw	a5,24(a5)
    800065a0:	fec42703          	lw	a4,-20(s0)
    800065a4:	9fb9                	addw	a5,a5,a4
    800065a6:	2781                	sext.w	a5,a5
    800065a8:	2785                	addiw	a5,a5,1
    800065aa:	2781                	sext.w	a5,a5
    800065ac:	2781                	sext.w	a5,a5
    800065ae:	85be                	mv	a1,a5
    800065b0:	8536                	mv	a0,a3
    800065b2:	fffff097          	auipc	ra,0xfffff
    800065b6:	806080e7          	jalr	-2042(ra) # 80004db8 <bread>
    800065ba:	fea43023          	sd	a0,-32(s0)
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
    800065be:	00068797          	auipc	a5,0x68
    800065c2:	49278793          	addi	a5,a5,1170 # 8006ea50 <log>
    800065c6:	579c                	lw	a5,40(a5)
    800065c8:	0007869b          	sext.w	a3,a5
    800065cc:	00068717          	auipc	a4,0x68
    800065d0:	48470713          	addi	a4,a4,1156 # 8006ea50 <log>
    800065d4:	fec42783          	lw	a5,-20(s0)
    800065d8:	07a1                	addi	a5,a5,8
    800065da:	078a                	slli	a5,a5,0x2
    800065dc:	97ba                	add	a5,a5,a4
    800065de:	4b9c                	lw	a5,16(a5)
    800065e0:	2781                	sext.w	a5,a5
    800065e2:	85be                	mv	a1,a5
    800065e4:	8536                	mv	a0,a3
    800065e6:	ffffe097          	auipc	ra,0xffffe
    800065ea:	7d2080e7          	jalr	2002(ra) # 80004db8 <bread>
    800065ee:	fca43c23          	sd	a0,-40(s0)
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    800065f2:	fd843783          	ld	a5,-40(s0)
    800065f6:	05878713          	addi	a4,a5,88
    800065fa:	fe043783          	ld	a5,-32(s0)
    800065fe:	05878793          	addi	a5,a5,88
    80006602:	40000613          	li	a2,1024
    80006606:	85be                	mv	a1,a5
    80006608:	853a                	mv	a0,a4
    8000660a:	ffffb097          	auipc	ra,0xffffb
    8000660e:	f2e080e7          	jalr	-210(ra) # 80001538 <memmove>
    bwrite(dbuf);  // write dst to disk
    80006612:	fd843503          	ld	a0,-40(s0)
    80006616:	ffffe097          	auipc	ra,0xffffe
    8000661a:	7fc080e7          	jalr	2044(ra) # 80004e12 <bwrite>
    if(recovering == 0)
    8000661e:	fcc42783          	lw	a5,-52(s0)
    80006622:	2781                	sext.w	a5,a5
    80006624:	e799                	bnez	a5,80006632 <install_trans+0xbe>
      bunpin(dbuf);
    80006626:	fd843503          	ld	a0,-40(s0)
    8000662a:	fffff097          	auipc	ra,0xfffff
    8000662e:	966080e7          	jalr	-1690(ra) # 80004f90 <bunpin>
    brelse(lbuf);
    80006632:	fe043503          	ld	a0,-32(s0)
    80006636:	fffff097          	auipc	ra,0xfffff
    8000663a:	824080e7          	jalr	-2012(ra) # 80004e5a <brelse>
    brelse(dbuf);
    8000663e:	fd843503          	ld	a0,-40(s0)
    80006642:	fffff097          	auipc	ra,0xfffff
    80006646:	818080e7          	jalr	-2024(ra) # 80004e5a <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    8000664a:	fec42783          	lw	a5,-20(s0)
    8000664e:	2785                	addiw	a5,a5,1
    80006650:	fef42623          	sw	a5,-20(s0)
    80006654:	00068797          	auipc	a5,0x68
    80006658:	3fc78793          	addi	a5,a5,1020 # 8006ea50 <log>
    8000665c:	57d8                	lw	a4,44(a5)
    8000665e:	fec42783          	lw	a5,-20(s0)
    80006662:	2781                	sext.w	a5,a5
    80006664:	f2e7c2e3          	blt	a5,a4,80006588 <install_trans+0x14>
  }
}
    80006668:	0001                	nop
    8000666a:	0001                	nop
    8000666c:	70e2                	ld	ra,56(sp)
    8000666e:	7442                	ld	s0,48(sp)
    80006670:	6121                	addi	sp,sp,64
    80006672:	8082                	ret

0000000080006674 <read_head>:

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
    80006674:	7179                	addi	sp,sp,-48
    80006676:	f406                	sd	ra,40(sp)
    80006678:	f022                	sd	s0,32(sp)
    8000667a:	1800                	addi	s0,sp,48
  struct buf *buf = bread(log.dev, log.start);
    8000667c:	00068797          	auipc	a5,0x68
    80006680:	3d478793          	addi	a5,a5,980 # 8006ea50 <log>
    80006684:	579c                	lw	a5,40(a5)
    80006686:	0007871b          	sext.w	a4,a5
    8000668a:	00068797          	auipc	a5,0x68
    8000668e:	3c678793          	addi	a5,a5,966 # 8006ea50 <log>
    80006692:	4f9c                	lw	a5,24(a5)
    80006694:	2781                	sext.w	a5,a5
    80006696:	85be                	mv	a1,a5
    80006698:	853a                	mv	a0,a4
    8000669a:	ffffe097          	auipc	ra,0xffffe
    8000669e:	71e080e7          	jalr	1822(ra) # 80004db8 <bread>
    800066a2:	fea43023          	sd	a0,-32(s0)
  struct logheader *lh = (struct logheader *) (buf->data);
    800066a6:	fe043783          	ld	a5,-32(s0)
    800066aa:	05878793          	addi	a5,a5,88
    800066ae:	fcf43c23          	sd	a5,-40(s0)
  int i;
  log.lh.n = lh->n;
    800066b2:	fd843783          	ld	a5,-40(s0)
    800066b6:	4398                	lw	a4,0(a5)
    800066b8:	00068797          	auipc	a5,0x68
    800066bc:	39878793          	addi	a5,a5,920 # 8006ea50 <log>
    800066c0:	d7d8                	sw	a4,44(a5)
  for (i = 0; i < log.lh.n; i++) {
    800066c2:	fe042623          	sw	zero,-20(s0)
    800066c6:	a03d                	j	800066f4 <read_head+0x80>
    log.lh.block[i] = lh->block[i];
    800066c8:	fd843703          	ld	a4,-40(s0)
    800066cc:	fec42783          	lw	a5,-20(s0)
    800066d0:	078a                	slli	a5,a5,0x2
    800066d2:	97ba                	add	a5,a5,a4
    800066d4:	43d8                	lw	a4,4(a5)
    800066d6:	00068697          	auipc	a3,0x68
    800066da:	37a68693          	addi	a3,a3,890 # 8006ea50 <log>
    800066de:	fec42783          	lw	a5,-20(s0)
    800066e2:	07a1                	addi	a5,a5,8
    800066e4:	078a                	slli	a5,a5,0x2
    800066e6:	97b6                	add	a5,a5,a3
    800066e8:	cb98                	sw	a4,16(a5)
  for (i = 0; i < log.lh.n; i++) {
    800066ea:	fec42783          	lw	a5,-20(s0)
    800066ee:	2785                	addiw	a5,a5,1
    800066f0:	fef42623          	sw	a5,-20(s0)
    800066f4:	00068797          	auipc	a5,0x68
    800066f8:	35c78793          	addi	a5,a5,860 # 8006ea50 <log>
    800066fc:	57d8                	lw	a4,44(a5)
    800066fe:	fec42783          	lw	a5,-20(s0)
    80006702:	2781                	sext.w	a5,a5
    80006704:	fce7c2e3          	blt	a5,a4,800066c8 <read_head+0x54>
  }
  brelse(buf);
    80006708:	fe043503          	ld	a0,-32(s0)
    8000670c:	ffffe097          	auipc	ra,0xffffe
    80006710:	74e080e7          	jalr	1870(ra) # 80004e5a <brelse>
}
    80006714:	0001                	nop
    80006716:	70a2                	ld	ra,40(sp)
    80006718:	7402                	ld	s0,32(sp)
    8000671a:	6145                	addi	sp,sp,48
    8000671c:	8082                	ret

000000008000671e <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
    8000671e:	7179                	addi	sp,sp,-48
    80006720:	f406                	sd	ra,40(sp)
    80006722:	f022                	sd	s0,32(sp)
    80006724:	1800                	addi	s0,sp,48
  struct buf *buf = bread(log.dev, log.start);
    80006726:	00068797          	auipc	a5,0x68
    8000672a:	32a78793          	addi	a5,a5,810 # 8006ea50 <log>
    8000672e:	579c                	lw	a5,40(a5)
    80006730:	0007871b          	sext.w	a4,a5
    80006734:	00068797          	auipc	a5,0x68
    80006738:	31c78793          	addi	a5,a5,796 # 8006ea50 <log>
    8000673c:	4f9c                	lw	a5,24(a5)
    8000673e:	2781                	sext.w	a5,a5
    80006740:	85be                	mv	a1,a5
    80006742:	853a                	mv	a0,a4
    80006744:	ffffe097          	auipc	ra,0xffffe
    80006748:	674080e7          	jalr	1652(ra) # 80004db8 <bread>
    8000674c:	fea43023          	sd	a0,-32(s0)
  struct logheader *hb = (struct logheader *) (buf->data);
    80006750:	fe043783          	ld	a5,-32(s0)
    80006754:	05878793          	addi	a5,a5,88
    80006758:	fcf43c23          	sd	a5,-40(s0)
  int i;
  hb->n = log.lh.n;
    8000675c:	00068797          	auipc	a5,0x68
    80006760:	2f478793          	addi	a5,a5,756 # 8006ea50 <log>
    80006764:	57d8                	lw	a4,44(a5)
    80006766:	fd843783          	ld	a5,-40(s0)
    8000676a:	c398                	sw	a4,0(a5)
  for (i = 0; i < log.lh.n; i++) {
    8000676c:	fe042623          	sw	zero,-20(s0)
    80006770:	a03d                	j	8000679e <write_head+0x80>
    hb->block[i] = log.lh.block[i];
    80006772:	00068717          	auipc	a4,0x68
    80006776:	2de70713          	addi	a4,a4,734 # 8006ea50 <log>
    8000677a:	fec42783          	lw	a5,-20(s0)
    8000677e:	07a1                	addi	a5,a5,8
    80006780:	078a                	slli	a5,a5,0x2
    80006782:	97ba                	add	a5,a5,a4
    80006784:	4b98                	lw	a4,16(a5)
    80006786:	fd843683          	ld	a3,-40(s0)
    8000678a:	fec42783          	lw	a5,-20(s0)
    8000678e:	078a                	slli	a5,a5,0x2
    80006790:	97b6                	add	a5,a5,a3
    80006792:	c3d8                	sw	a4,4(a5)
  for (i = 0; i < log.lh.n; i++) {
    80006794:	fec42783          	lw	a5,-20(s0)
    80006798:	2785                	addiw	a5,a5,1
    8000679a:	fef42623          	sw	a5,-20(s0)
    8000679e:	00068797          	auipc	a5,0x68
    800067a2:	2b278793          	addi	a5,a5,690 # 8006ea50 <log>
    800067a6:	57d8                	lw	a4,44(a5)
    800067a8:	fec42783          	lw	a5,-20(s0)
    800067ac:	2781                	sext.w	a5,a5
    800067ae:	fce7c2e3          	blt	a5,a4,80006772 <write_head+0x54>
  }
  bwrite(buf);
    800067b2:	fe043503          	ld	a0,-32(s0)
    800067b6:	ffffe097          	auipc	ra,0xffffe
    800067ba:	65c080e7          	jalr	1628(ra) # 80004e12 <bwrite>
  brelse(buf);
    800067be:	fe043503          	ld	a0,-32(s0)
    800067c2:	ffffe097          	auipc	ra,0xffffe
    800067c6:	698080e7          	jalr	1688(ra) # 80004e5a <brelse>
}
    800067ca:	0001                	nop
    800067cc:	70a2                	ld	ra,40(sp)
    800067ce:	7402                	ld	s0,32(sp)
    800067d0:	6145                	addi	sp,sp,48
    800067d2:	8082                	ret

00000000800067d4 <recover_from_log>:

static void
recover_from_log(void)
{
    800067d4:	1141                	addi	sp,sp,-16
    800067d6:	e406                	sd	ra,8(sp)
    800067d8:	e022                	sd	s0,0(sp)
    800067da:	0800                	addi	s0,sp,16
  read_head();
    800067dc:	00000097          	auipc	ra,0x0
    800067e0:	e98080e7          	jalr	-360(ra) # 80006674 <read_head>
  install_trans(1); // if committed, copy from log to disk
    800067e4:	4505                	li	a0,1
    800067e6:	00000097          	auipc	ra,0x0
    800067ea:	d8e080e7          	jalr	-626(ra) # 80006574 <install_trans>
  log.lh.n = 0;
    800067ee:	00068797          	auipc	a5,0x68
    800067f2:	26278793          	addi	a5,a5,610 # 8006ea50 <log>
    800067f6:	0207a623          	sw	zero,44(a5)
  write_head(); // clear the log
    800067fa:	00000097          	auipc	ra,0x0
    800067fe:	f24080e7          	jalr	-220(ra) # 8000671e <write_head>
}
    80006802:	0001                	nop
    80006804:	60a2                	ld	ra,8(sp)
    80006806:	6402                	ld	s0,0(sp)
    80006808:	0141                	addi	sp,sp,16
    8000680a:	8082                	ret

000000008000680c <begin_op>:

// called at the start of each FS system call.
void
begin_op(void)
{
    8000680c:	1141                	addi	sp,sp,-16
    8000680e:	e406                	sd	ra,8(sp)
    80006810:	e022                	sd	s0,0(sp)
    80006812:	0800                	addi	s0,sp,16
  acquire(&log.lock);
    80006814:	00068517          	auipc	a0,0x68
    80006818:	23c50513          	addi	a0,a0,572 # 8006ea50 <log>
    8000681c:	ffffb097          	auipc	ra,0xffffb
    80006820:	a64080e7          	jalr	-1436(ra) # 80001280 <acquire>
  while(1){
    if(log.committing){
    80006824:	00068797          	auipc	a5,0x68
    80006828:	22c78793          	addi	a5,a5,556 # 8006ea50 <log>
    8000682c:	53dc                	lw	a5,36(a5)
    8000682e:	cf91                	beqz	a5,8000684a <begin_op+0x3e>
      sleep(&log, &log.lock);
    80006830:	00068597          	auipc	a1,0x68
    80006834:	22058593          	addi	a1,a1,544 # 8006ea50 <log>
    80006838:	00068517          	auipc	a0,0x68
    8000683c:	21850513          	addi	a0,a0,536 # 8006ea50 <log>
    80006840:	ffffd097          	auipc	ra,0xffffd
    80006844:	cf4080e7          	jalr	-780(ra) # 80003534 <sleep>
    80006848:	bff1                	j	80006824 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    8000684a:	00068797          	auipc	a5,0x68
    8000684e:	20678793          	addi	a5,a5,518 # 8006ea50 <log>
    80006852:	57d8                	lw	a4,44(a5)
    80006854:	00068797          	auipc	a5,0x68
    80006858:	1fc78793          	addi	a5,a5,508 # 8006ea50 <log>
    8000685c:	539c                	lw	a5,32(a5)
    8000685e:	2785                	addiw	a5,a5,1
    80006860:	2781                	sext.w	a5,a5
    80006862:	86be                	mv	a3,a5
    80006864:	87b6                	mv	a5,a3
    80006866:	0027979b          	slliw	a5,a5,0x2
    8000686a:	9fb5                	addw	a5,a5,a3
    8000686c:	0017979b          	slliw	a5,a5,0x1
    80006870:	2781                	sext.w	a5,a5
    80006872:	9fb9                	addw	a5,a5,a4
    80006874:	2781                	sext.w	a5,a5
    80006876:	873e                	mv	a4,a5
    80006878:	47f9                	li	a5,30
    8000687a:	00e7df63          	bge	a5,a4,80006898 <begin_op+0x8c>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    8000687e:	00068597          	auipc	a1,0x68
    80006882:	1d258593          	addi	a1,a1,466 # 8006ea50 <log>
    80006886:	00068517          	auipc	a0,0x68
    8000688a:	1ca50513          	addi	a0,a0,458 # 8006ea50 <log>
    8000688e:	ffffd097          	auipc	ra,0xffffd
    80006892:	ca6080e7          	jalr	-858(ra) # 80003534 <sleep>
    80006896:	b779                	j	80006824 <begin_op+0x18>
    } else {
      log.outstanding += 1;
    80006898:	00068797          	auipc	a5,0x68
    8000689c:	1b878793          	addi	a5,a5,440 # 8006ea50 <log>
    800068a0:	539c                	lw	a5,32(a5)
    800068a2:	2785                	addiw	a5,a5,1
    800068a4:	0007871b          	sext.w	a4,a5
    800068a8:	00068797          	auipc	a5,0x68
    800068ac:	1a878793          	addi	a5,a5,424 # 8006ea50 <log>
    800068b0:	d398                	sw	a4,32(a5)
      release(&log.lock);
    800068b2:	00068517          	auipc	a0,0x68
    800068b6:	19e50513          	addi	a0,a0,414 # 8006ea50 <log>
    800068ba:	ffffb097          	auipc	ra,0xffffb
    800068be:	a2a080e7          	jalr	-1494(ra) # 800012e4 <release>
      break;
    800068c2:	0001                	nop
    }
  }
}
    800068c4:	0001                	nop
    800068c6:	60a2                	ld	ra,8(sp)
    800068c8:	6402                	ld	s0,0(sp)
    800068ca:	0141                	addi	sp,sp,16
    800068cc:	8082                	ret

00000000800068ce <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
    800068ce:	1101                	addi	sp,sp,-32
    800068d0:	ec06                	sd	ra,24(sp)
    800068d2:	e822                	sd	s0,16(sp)
    800068d4:	1000                	addi	s0,sp,32
  int do_commit = 0;
    800068d6:	fe042623          	sw	zero,-20(s0)

  acquire(&log.lock);
    800068da:	00068517          	auipc	a0,0x68
    800068de:	17650513          	addi	a0,a0,374 # 8006ea50 <log>
    800068e2:	ffffb097          	auipc	ra,0xffffb
    800068e6:	99e080e7          	jalr	-1634(ra) # 80001280 <acquire>
  log.outstanding -= 1;
    800068ea:	00068797          	auipc	a5,0x68
    800068ee:	16678793          	addi	a5,a5,358 # 8006ea50 <log>
    800068f2:	539c                	lw	a5,32(a5)
    800068f4:	37fd                	addiw	a5,a5,-1
    800068f6:	0007871b          	sext.w	a4,a5
    800068fa:	00068797          	auipc	a5,0x68
    800068fe:	15678793          	addi	a5,a5,342 # 8006ea50 <log>
    80006902:	d398                	sw	a4,32(a5)
  if(log.committing)
    80006904:	00068797          	auipc	a5,0x68
    80006908:	14c78793          	addi	a5,a5,332 # 8006ea50 <log>
    8000690c:	53dc                	lw	a5,36(a5)
    8000690e:	cb89                	beqz	a5,80006920 <end_op+0x52>
    panic("log.committing");
    80006910:	00006517          	auipc	a0,0x6
    80006914:	c1850513          	addi	a0,a0,-1000 # 8000c528 <etext+0x528>
    80006918:	ffffa097          	auipc	ra,0xffffa
    8000691c:	33a080e7          	jalr	826(ra) # 80000c52 <panic>
  if(log.outstanding == 0){
    80006920:	00068797          	auipc	a5,0x68
    80006924:	13078793          	addi	a5,a5,304 # 8006ea50 <log>
    80006928:	539c                	lw	a5,32(a5)
    8000692a:	eb99                	bnez	a5,80006940 <end_op+0x72>
    do_commit = 1;
    8000692c:	4785                	li	a5,1
    8000692e:	fef42623          	sw	a5,-20(s0)
    log.committing = 1;
    80006932:	00068797          	auipc	a5,0x68
    80006936:	11e78793          	addi	a5,a5,286 # 8006ea50 <log>
    8000693a:	4705                	li	a4,1
    8000693c:	d3d8                	sw	a4,36(a5)
    8000693e:	a809                	j	80006950 <end_op+0x82>
  } else {
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
    80006940:	00068517          	auipc	a0,0x68
    80006944:	11050513          	addi	a0,a0,272 # 8006ea50 <log>
    80006948:	ffffd097          	auipc	ra,0xffffd
    8000694c:	c80080e7          	jalr	-896(ra) # 800035c8 <wakeup>
  }
  release(&log.lock);
    80006950:	00068517          	auipc	a0,0x68
    80006954:	10050513          	addi	a0,a0,256 # 8006ea50 <log>
    80006958:	ffffb097          	auipc	ra,0xffffb
    8000695c:	98c080e7          	jalr	-1652(ra) # 800012e4 <release>

  if(do_commit){
    80006960:	fec42783          	lw	a5,-20(s0)
    80006964:	2781                	sext.w	a5,a5
    80006966:	c3b9                	beqz	a5,800069ac <end_op+0xde>
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
    80006968:	00000097          	auipc	ra,0x0
    8000696c:	134080e7          	jalr	308(ra) # 80006a9c <commit>
    acquire(&log.lock);
    80006970:	00068517          	auipc	a0,0x68
    80006974:	0e050513          	addi	a0,a0,224 # 8006ea50 <log>
    80006978:	ffffb097          	auipc	ra,0xffffb
    8000697c:	908080e7          	jalr	-1784(ra) # 80001280 <acquire>
    log.committing = 0;
    80006980:	00068797          	auipc	a5,0x68
    80006984:	0d078793          	addi	a5,a5,208 # 8006ea50 <log>
    80006988:	0207a223          	sw	zero,36(a5)
    wakeup(&log);
    8000698c:	00068517          	auipc	a0,0x68
    80006990:	0c450513          	addi	a0,a0,196 # 8006ea50 <log>
    80006994:	ffffd097          	auipc	ra,0xffffd
    80006998:	c34080e7          	jalr	-972(ra) # 800035c8 <wakeup>
    release(&log.lock);
    8000699c:	00068517          	auipc	a0,0x68
    800069a0:	0b450513          	addi	a0,a0,180 # 8006ea50 <log>
    800069a4:	ffffb097          	auipc	ra,0xffffb
    800069a8:	940080e7          	jalr	-1728(ra) # 800012e4 <release>
  }
}
    800069ac:	0001                	nop
    800069ae:	60e2                	ld	ra,24(sp)
    800069b0:	6442                	ld	s0,16(sp)
    800069b2:	6105                	addi	sp,sp,32
    800069b4:	8082                	ret

00000000800069b6 <write_log>:

// Copy modified blocks from cache to log.
static void
write_log(void)
{
    800069b6:	7179                	addi	sp,sp,-48
    800069b8:	f406                	sd	ra,40(sp)
    800069ba:	f022                	sd	s0,32(sp)
    800069bc:	1800                	addi	s0,sp,48
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    800069be:	fe042623          	sw	zero,-20(s0)
    800069c2:	a86d                	j	80006a7c <write_log+0xc6>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    800069c4:	00068797          	auipc	a5,0x68
    800069c8:	08c78793          	addi	a5,a5,140 # 8006ea50 <log>
    800069cc:	579c                	lw	a5,40(a5)
    800069ce:	0007869b          	sext.w	a3,a5
    800069d2:	00068797          	auipc	a5,0x68
    800069d6:	07e78793          	addi	a5,a5,126 # 8006ea50 <log>
    800069da:	4f9c                	lw	a5,24(a5)
    800069dc:	fec42703          	lw	a4,-20(s0)
    800069e0:	9fb9                	addw	a5,a5,a4
    800069e2:	2781                	sext.w	a5,a5
    800069e4:	2785                	addiw	a5,a5,1
    800069e6:	2781                	sext.w	a5,a5
    800069e8:	2781                	sext.w	a5,a5
    800069ea:	85be                	mv	a1,a5
    800069ec:	8536                	mv	a0,a3
    800069ee:	ffffe097          	auipc	ra,0xffffe
    800069f2:	3ca080e7          	jalr	970(ra) # 80004db8 <bread>
    800069f6:	fea43023          	sd	a0,-32(s0)
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
    800069fa:	00068797          	auipc	a5,0x68
    800069fe:	05678793          	addi	a5,a5,86 # 8006ea50 <log>
    80006a02:	579c                	lw	a5,40(a5)
    80006a04:	0007869b          	sext.w	a3,a5
    80006a08:	00068717          	auipc	a4,0x68
    80006a0c:	04870713          	addi	a4,a4,72 # 8006ea50 <log>
    80006a10:	fec42783          	lw	a5,-20(s0)
    80006a14:	07a1                	addi	a5,a5,8
    80006a16:	078a                	slli	a5,a5,0x2
    80006a18:	97ba                	add	a5,a5,a4
    80006a1a:	4b9c                	lw	a5,16(a5)
    80006a1c:	2781                	sext.w	a5,a5
    80006a1e:	85be                	mv	a1,a5
    80006a20:	8536                	mv	a0,a3
    80006a22:	ffffe097          	auipc	ra,0xffffe
    80006a26:	396080e7          	jalr	918(ra) # 80004db8 <bread>
    80006a2a:	fca43c23          	sd	a0,-40(s0)
    memmove(to->data, from->data, BSIZE);
    80006a2e:	fe043783          	ld	a5,-32(s0)
    80006a32:	05878713          	addi	a4,a5,88
    80006a36:	fd843783          	ld	a5,-40(s0)
    80006a3a:	05878793          	addi	a5,a5,88
    80006a3e:	40000613          	li	a2,1024
    80006a42:	85be                	mv	a1,a5
    80006a44:	853a                	mv	a0,a4
    80006a46:	ffffb097          	auipc	ra,0xffffb
    80006a4a:	af2080e7          	jalr	-1294(ra) # 80001538 <memmove>
    bwrite(to);  // write the log
    80006a4e:	fe043503          	ld	a0,-32(s0)
    80006a52:	ffffe097          	auipc	ra,0xffffe
    80006a56:	3c0080e7          	jalr	960(ra) # 80004e12 <bwrite>
    brelse(from);
    80006a5a:	fd843503          	ld	a0,-40(s0)
    80006a5e:	ffffe097          	auipc	ra,0xffffe
    80006a62:	3fc080e7          	jalr	1020(ra) # 80004e5a <brelse>
    brelse(to);
    80006a66:	fe043503          	ld	a0,-32(s0)
    80006a6a:	ffffe097          	auipc	ra,0xffffe
    80006a6e:	3f0080e7          	jalr	1008(ra) # 80004e5a <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    80006a72:	fec42783          	lw	a5,-20(s0)
    80006a76:	2785                	addiw	a5,a5,1
    80006a78:	fef42623          	sw	a5,-20(s0)
    80006a7c:	00068797          	auipc	a5,0x68
    80006a80:	fd478793          	addi	a5,a5,-44 # 8006ea50 <log>
    80006a84:	57d8                	lw	a4,44(a5)
    80006a86:	fec42783          	lw	a5,-20(s0)
    80006a8a:	2781                	sext.w	a5,a5
    80006a8c:	f2e7cce3          	blt	a5,a4,800069c4 <write_log+0xe>
  }
}
    80006a90:	0001                	nop
    80006a92:	0001                	nop
    80006a94:	70a2                	ld	ra,40(sp)
    80006a96:	7402                	ld	s0,32(sp)
    80006a98:	6145                	addi	sp,sp,48
    80006a9a:	8082                	ret

0000000080006a9c <commit>:

static void
commit()
{
    80006a9c:	1141                	addi	sp,sp,-16
    80006a9e:	e406                	sd	ra,8(sp)
    80006aa0:	e022                	sd	s0,0(sp)
    80006aa2:	0800                	addi	s0,sp,16
  if (log.lh.n > 0) {
    80006aa4:	00068797          	auipc	a5,0x68
    80006aa8:	fac78793          	addi	a5,a5,-84 # 8006ea50 <log>
    80006aac:	57dc                	lw	a5,44(a5)
    80006aae:	02f05963          	blez	a5,80006ae0 <commit+0x44>
    write_log();     // Write modified blocks from cache to log
    80006ab2:	00000097          	auipc	ra,0x0
    80006ab6:	f04080e7          	jalr	-252(ra) # 800069b6 <write_log>
    write_head();    // Write header to disk -- the real commit
    80006aba:	00000097          	auipc	ra,0x0
    80006abe:	c64080e7          	jalr	-924(ra) # 8000671e <write_head>
    install_trans(0); // Now install writes to home locations
    80006ac2:	4501                	li	a0,0
    80006ac4:	00000097          	auipc	ra,0x0
    80006ac8:	ab0080e7          	jalr	-1360(ra) # 80006574 <install_trans>
    log.lh.n = 0;
    80006acc:	00068797          	auipc	a5,0x68
    80006ad0:	f8478793          	addi	a5,a5,-124 # 8006ea50 <log>
    80006ad4:	0207a623          	sw	zero,44(a5)
    write_head();    // Erase the transaction from the log
    80006ad8:	00000097          	auipc	ra,0x0
    80006adc:	c46080e7          	jalr	-954(ra) # 8000671e <write_head>
  }
}
    80006ae0:	0001                	nop
    80006ae2:	60a2                	ld	ra,8(sp)
    80006ae4:	6402                	ld	s0,0(sp)
    80006ae6:	0141                	addi	sp,sp,16
    80006ae8:	8082                	ret

0000000080006aea <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
    80006aea:	7179                	addi	sp,sp,-48
    80006aec:	f406                	sd	ra,40(sp)
    80006aee:	f022                	sd	s0,32(sp)
    80006af0:	1800                	addi	s0,sp,48
    80006af2:	fca43c23          	sd	a0,-40(s0)
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    80006af6:	00068797          	auipc	a5,0x68
    80006afa:	f5a78793          	addi	a5,a5,-166 # 8006ea50 <log>
    80006afe:	57dc                	lw	a5,44(a5)
    80006b00:	873e                	mv	a4,a5
    80006b02:	47f5                	li	a5,29
    80006b04:	02e7c063          	blt	a5,a4,80006b24 <log_write+0x3a>
    80006b08:	00068797          	auipc	a5,0x68
    80006b0c:	f4878793          	addi	a5,a5,-184 # 8006ea50 <log>
    80006b10:	57d8                	lw	a4,44(a5)
    80006b12:	00068797          	auipc	a5,0x68
    80006b16:	f3e78793          	addi	a5,a5,-194 # 8006ea50 <log>
    80006b1a:	4fdc                	lw	a5,28(a5)
    80006b1c:	37fd                	addiw	a5,a5,-1
    80006b1e:	2781                	sext.w	a5,a5
    80006b20:	00f74a63          	blt	a4,a5,80006b34 <log_write+0x4a>
    panic("too big a transaction");
    80006b24:	00006517          	auipc	a0,0x6
    80006b28:	a1450513          	addi	a0,a0,-1516 # 8000c538 <etext+0x538>
    80006b2c:	ffffa097          	auipc	ra,0xffffa
    80006b30:	126080e7          	jalr	294(ra) # 80000c52 <panic>
  if (log.outstanding < 1)
    80006b34:	00068797          	auipc	a5,0x68
    80006b38:	f1c78793          	addi	a5,a5,-228 # 8006ea50 <log>
    80006b3c:	539c                	lw	a5,32(a5)
    80006b3e:	00f04a63          	bgtz	a5,80006b52 <log_write+0x68>
    panic("log_write outside of trans");
    80006b42:	00006517          	auipc	a0,0x6
    80006b46:	a0e50513          	addi	a0,a0,-1522 # 8000c550 <etext+0x550>
    80006b4a:	ffffa097          	auipc	ra,0xffffa
    80006b4e:	108080e7          	jalr	264(ra) # 80000c52 <panic>

  acquire(&log.lock);
    80006b52:	00068517          	auipc	a0,0x68
    80006b56:	efe50513          	addi	a0,a0,-258 # 8006ea50 <log>
    80006b5a:	ffffa097          	auipc	ra,0xffffa
    80006b5e:	726080e7          	jalr	1830(ra) # 80001280 <acquire>
  for (i = 0; i < log.lh.n; i++) {
    80006b62:	fe042623          	sw	zero,-20(s0)
    80006b66:	a03d                	j	80006b94 <log_write+0xaa>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
    80006b68:	00068717          	auipc	a4,0x68
    80006b6c:	ee870713          	addi	a4,a4,-280 # 8006ea50 <log>
    80006b70:	fec42783          	lw	a5,-20(s0)
    80006b74:	07a1                	addi	a5,a5,8
    80006b76:	078a                	slli	a5,a5,0x2
    80006b78:	97ba                	add	a5,a5,a4
    80006b7a:	4b9c                	lw	a5,16(a5)
    80006b7c:	0007871b          	sext.w	a4,a5
    80006b80:	fd843783          	ld	a5,-40(s0)
    80006b84:	47dc                	lw	a5,12(a5)
    80006b86:	02f70263          	beq	a4,a5,80006baa <log_write+0xc0>
  for (i = 0; i < log.lh.n; i++) {
    80006b8a:	fec42783          	lw	a5,-20(s0)
    80006b8e:	2785                	addiw	a5,a5,1
    80006b90:	fef42623          	sw	a5,-20(s0)
    80006b94:	00068797          	auipc	a5,0x68
    80006b98:	ebc78793          	addi	a5,a5,-324 # 8006ea50 <log>
    80006b9c:	57d8                	lw	a4,44(a5)
    80006b9e:	fec42783          	lw	a5,-20(s0)
    80006ba2:	2781                	sext.w	a5,a5
    80006ba4:	fce7c2e3          	blt	a5,a4,80006b68 <log_write+0x7e>
    80006ba8:	a011                	j	80006bac <log_write+0xc2>
      break;
    80006baa:	0001                	nop
  }
  log.lh.block[i] = b->blockno;
    80006bac:	fd843783          	ld	a5,-40(s0)
    80006bb0:	47dc                	lw	a5,12(a5)
    80006bb2:	0007871b          	sext.w	a4,a5
    80006bb6:	00068697          	auipc	a3,0x68
    80006bba:	e9a68693          	addi	a3,a3,-358 # 8006ea50 <log>
    80006bbe:	fec42783          	lw	a5,-20(s0)
    80006bc2:	07a1                	addi	a5,a5,8
    80006bc4:	078a                	slli	a5,a5,0x2
    80006bc6:	97b6                	add	a5,a5,a3
    80006bc8:	cb98                	sw	a4,16(a5)
  if (i == log.lh.n) {  // Add new block to log?
    80006bca:	00068797          	auipc	a5,0x68
    80006bce:	e8678793          	addi	a5,a5,-378 # 8006ea50 <log>
    80006bd2:	57d8                	lw	a4,44(a5)
    80006bd4:	fec42783          	lw	a5,-20(s0)
    80006bd8:	2781                	sext.w	a5,a5
    80006bda:	02e79563          	bne	a5,a4,80006c04 <log_write+0x11a>
    bpin(b);
    80006bde:	fd843503          	ld	a0,-40(s0)
    80006be2:	ffffe097          	auipc	ra,0xffffe
    80006be6:	366080e7          	jalr	870(ra) # 80004f48 <bpin>
    log.lh.n++;
    80006bea:	00068797          	auipc	a5,0x68
    80006bee:	e6678793          	addi	a5,a5,-410 # 8006ea50 <log>
    80006bf2:	57dc                	lw	a5,44(a5)
    80006bf4:	2785                	addiw	a5,a5,1
    80006bf6:	0007871b          	sext.w	a4,a5
    80006bfa:	00068797          	auipc	a5,0x68
    80006bfe:	e5678793          	addi	a5,a5,-426 # 8006ea50 <log>
    80006c02:	d7d8                	sw	a4,44(a5)
  }
  release(&log.lock);
    80006c04:	00068517          	auipc	a0,0x68
    80006c08:	e4c50513          	addi	a0,a0,-436 # 8006ea50 <log>
    80006c0c:	ffffa097          	auipc	ra,0xffffa
    80006c10:	6d8080e7          	jalr	1752(ra) # 800012e4 <release>
}
    80006c14:	0001                	nop
    80006c16:	70a2                	ld	ra,40(sp)
    80006c18:	7402                	ld	s0,32(sp)
    80006c1a:	6145                	addi	sp,sp,48
    80006c1c:	8082                	ret

0000000080006c1e <initsleeplock>:
#include "proc.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
    80006c1e:	1101                	addi	sp,sp,-32
    80006c20:	ec06                	sd	ra,24(sp)
    80006c22:	e822                	sd	s0,16(sp)
    80006c24:	1000                	addi	s0,sp,32
    80006c26:	fea43423          	sd	a0,-24(s0)
    80006c2a:	feb43023          	sd	a1,-32(s0)
  initlock(&lk->lk, "sleep lock");
    80006c2e:	fe843783          	ld	a5,-24(s0)
    80006c32:	07a1                	addi	a5,a5,8
    80006c34:	00006597          	auipc	a1,0x6
    80006c38:	93c58593          	addi	a1,a1,-1732 # 8000c570 <etext+0x570>
    80006c3c:	853e                	mv	a0,a5
    80006c3e:	ffffa097          	auipc	ra,0xffffa
    80006c42:	612080e7          	jalr	1554(ra) # 80001250 <initlock>
  lk->name = name;
    80006c46:	fe843783          	ld	a5,-24(s0)
    80006c4a:	fe043703          	ld	a4,-32(s0)
    80006c4e:	f398                	sd	a4,32(a5)
  lk->locked = 0;
    80006c50:	fe843783          	ld	a5,-24(s0)
    80006c54:	0007a023          	sw	zero,0(a5)
  lk->pid = 0;
    80006c58:	fe843783          	ld	a5,-24(s0)
    80006c5c:	0207a423          	sw	zero,40(a5)
}
    80006c60:	0001                	nop
    80006c62:	60e2                	ld	ra,24(sp)
    80006c64:	6442                	ld	s0,16(sp)
    80006c66:	6105                	addi	sp,sp,32
    80006c68:	8082                	ret

0000000080006c6a <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
    80006c6a:	1101                	addi	sp,sp,-32
    80006c6c:	ec06                	sd	ra,24(sp)
    80006c6e:	e822                	sd	s0,16(sp)
    80006c70:	1000                	addi	s0,sp,32
    80006c72:	fea43423          	sd	a0,-24(s0)
  acquire(&lk->lk);
    80006c76:	fe843783          	ld	a5,-24(s0)
    80006c7a:	07a1                	addi	a5,a5,8
    80006c7c:	853e                	mv	a0,a5
    80006c7e:	ffffa097          	auipc	ra,0xffffa
    80006c82:	602080e7          	jalr	1538(ra) # 80001280 <acquire>
  while (lk->locked) {
    80006c86:	a819                	j	80006c9c <acquiresleep+0x32>
    sleep(lk, &lk->lk);
    80006c88:	fe843783          	ld	a5,-24(s0)
    80006c8c:	07a1                	addi	a5,a5,8
    80006c8e:	85be                	mv	a1,a5
    80006c90:	fe843503          	ld	a0,-24(s0)
    80006c94:	ffffd097          	auipc	ra,0xffffd
    80006c98:	8a0080e7          	jalr	-1888(ra) # 80003534 <sleep>
  while (lk->locked) {
    80006c9c:	fe843783          	ld	a5,-24(s0)
    80006ca0:	439c                	lw	a5,0(a5)
    80006ca2:	f3fd                	bnez	a5,80006c88 <acquiresleep+0x1e>
  }
  lk->locked = 1;
    80006ca4:	fe843783          	ld	a5,-24(s0)
    80006ca8:	4705                	li	a4,1
    80006caa:	c398                	sw	a4,0(a5)
  lk->pid = myproc()->pid;
    80006cac:	ffffc097          	auipc	ra,0xffffc
    80006cb0:	b4c080e7          	jalr	-1204(ra) # 800027f8 <myproc>
    80006cb4:	87aa                	mv	a5,a0
    80006cb6:	5f98                	lw	a4,56(a5)
    80006cb8:	fe843783          	ld	a5,-24(s0)
    80006cbc:	d798                	sw	a4,40(a5)
  release(&lk->lk);
    80006cbe:	fe843783          	ld	a5,-24(s0)
    80006cc2:	07a1                	addi	a5,a5,8
    80006cc4:	853e                	mv	a0,a5
    80006cc6:	ffffa097          	auipc	ra,0xffffa
    80006cca:	61e080e7          	jalr	1566(ra) # 800012e4 <release>
}
    80006cce:	0001                	nop
    80006cd0:	60e2                	ld	ra,24(sp)
    80006cd2:	6442                	ld	s0,16(sp)
    80006cd4:	6105                	addi	sp,sp,32
    80006cd6:	8082                	ret

0000000080006cd8 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
    80006cd8:	1101                	addi	sp,sp,-32
    80006cda:	ec06                	sd	ra,24(sp)
    80006cdc:	e822                	sd	s0,16(sp)
    80006cde:	1000                	addi	s0,sp,32
    80006ce0:	fea43423          	sd	a0,-24(s0)
  acquire(&lk->lk);
    80006ce4:	fe843783          	ld	a5,-24(s0)
    80006ce8:	07a1                	addi	a5,a5,8
    80006cea:	853e                	mv	a0,a5
    80006cec:	ffffa097          	auipc	ra,0xffffa
    80006cf0:	594080e7          	jalr	1428(ra) # 80001280 <acquire>
  lk->locked = 0;
    80006cf4:	fe843783          	ld	a5,-24(s0)
    80006cf8:	0007a023          	sw	zero,0(a5)
  lk->pid = 0;
    80006cfc:	fe843783          	ld	a5,-24(s0)
    80006d00:	0207a423          	sw	zero,40(a5)
  wakeup(lk);
    80006d04:	fe843503          	ld	a0,-24(s0)
    80006d08:	ffffd097          	auipc	ra,0xffffd
    80006d0c:	8c0080e7          	jalr	-1856(ra) # 800035c8 <wakeup>
  release(&lk->lk);
    80006d10:	fe843783          	ld	a5,-24(s0)
    80006d14:	07a1                	addi	a5,a5,8
    80006d16:	853e                	mv	a0,a5
    80006d18:	ffffa097          	auipc	ra,0xffffa
    80006d1c:	5cc080e7          	jalr	1484(ra) # 800012e4 <release>
}
    80006d20:	0001                	nop
    80006d22:	60e2                	ld	ra,24(sp)
    80006d24:	6442                	ld	s0,16(sp)
    80006d26:	6105                	addi	sp,sp,32
    80006d28:	8082                	ret

0000000080006d2a <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
    80006d2a:	7139                	addi	sp,sp,-64
    80006d2c:	fc06                	sd	ra,56(sp)
    80006d2e:	f822                	sd	s0,48(sp)
    80006d30:	f426                	sd	s1,40(sp)
    80006d32:	0080                	addi	s0,sp,64
    80006d34:	fca43423          	sd	a0,-56(s0)
  int r;
  
  acquire(&lk->lk);
    80006d38:	fc843783          	ld	a5,-56(s0)
    80006d3c:	07a1                	addi	a5,a5,8
    80006d3e:	853e                	mv	a0,a5
    80006d40:	ffffa097          	auipc	ra,0xffffa
    80006d44:	540080e7          	jalr	1344(ra) # 80001280 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
    80006d48:	fc843783          	ld	a5,-56(s0)
    80006d4c:	439c                	lw	a5,0(a5)
    80006d4e:	cf99                	beqz	a5,80006d6c <holdingsleep+0x42>
    80006d50:	fc843783          	ld	a5,-56(s0)
    80006d54:	5784                	lw	s1,40(a5)
    80006d56:	ffffc097          	auipc	ra,0xffffc
    80006d5a:	aa2080e7          	jalr	-1374(ra) # 800027f8 <myproc>
    80006d5e:	87aa                	mv	a5,a0
    80006d60:	5f9c                	lw	a5,56(a5)
    80006d62:	8726                	mv	a4,s1
    80006d64:	00f71463          	bne	a4,a5,80006d6c <holdingsleep+0x42>
    80006d68:	4785                	li	a5,1
    80006d6a:	a011                	j	80006d6e <holdingsleep+0x44>
    80006d6c:	4781                	li	a5,0
    80006d6e:	fcf42e23          	sw	a5,-36(s0)
  release(&lk->lk);
    80006d72:	fc843783          	ld	a5,-56(s0)
    80006d76:	07a1                	addi	a5,a5,8
    80006d78:	853e                	mv	a0,a5
    80006d7a:	ffffa097          	auipc	ra,0xffffa
    80006d7e:	56a080e7          	jalr	1386(ra) # 800012e4 <release>
  return r;
    80006d82:	fdc42783          	lw	a5,-36(s0)
}
    80006d86:	853e                	mv	a0,a5
    80006d88:	70e2                	ld	ra,56(sp)
    80006d8a:	7442                	ld	s0,48(sp)
    80006d8c:	74a2                	ld	s1,40(sp)
    80006d8e:	6121                	addi	sp,sp,64
    80006d90:	8082                	ret

0000000080006d92 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
    80006d92:	1141                	addi	sp,sp,-16
    80006d94:	e406                	sd	ra,8(sp)
    80006d96:	e022                	sd	s0,0(sp)
    80006d98:	0800                	addi	s0,sp,16
  initlock(&ftable.lock, "ftable");
    80006d9a:	00005597          	auipc	a1,0x5
    80006d9e:	7e658593          	addi	a1,a1,2022 # 8000c580 <etext+0x580>
    80006da2:	00068517          	auipc	a0,0x68
    80006da6:	df650513          	addi	a0,a0,-522 # 8006eb98 <ftable>
    80006daa:	ffffa097          	auipc	ra,0xffffa
    80006dae:	4a6080e7          	jalr	1190(ra) # 80001250 <initlock>
}
    80006db2:	0001                	nop
    80006db4:	60a2                	ld	ra,8(sp)
    80006db6:	6402                	ld	s0,0(sp)
    80006db8:	0141                	addi	sp,sp,16
    80006dba:	8082                	ret

0000000080006dbc <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
    80006dbc:	1101                	addi	sp,sp,-32
    80006dbe:	ec06                	sd	ra,24(sp)
    80006dc0:	e822                	sd	s0,16(sp)
    80006dc2:	1000                	addi	s0,sp,32
  struct file *f;

  acquire(&ftable.lock);
    80006dc4:	00068517          	auipc	a0,0x68
    80006dc8:	dd450513          	addi	a0,a0,-556 # 8006eb98 <ftable>
    80006dcc:	ffffa097          	auipc	ra,0xffffa
    80006dd0:	4b4080e7          	jalr	1204(ra) # 80001280 <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80006dd4:	00068797          	auipc	a5,0x68
    80006dd8:	ddc78793          	addi	a5,a5,-548 # 8006ebb0 <ftable+0x18>
    80006ddc:	fef43423          	sd	a5,-24(s0)
    80006de0:	a815                	j	80006e14 <filealloc+0x58>
    if(f->ref == 0){
    80006de2:	fe843783          	ld	a5,-24(s0)
    80006de6:	43dc                	lw	a5,4(a5)
    80006de8:	e385                	bnez	a5,80006e08 <filealloc+0x4c>
      f->ref = 1;
    80006dea:	fe843783          	ld	a5,-24(s0)
    80006dee:	4705                	li	a4,1
    80006df0:	c3d8                	sw	a4,4(a5)
      release(&ftable.lock);
    80006df2:	00068517          	auipc	a0,0x68
    80006df6:	da650513          	addi	a0,a0,-602 # 8006eb98 <ftable>
    80006dfa:	ffffa097          	auipc	ra,0xffffa
    80006dfe:	4ea080e7          	jalr	1258(ra) # 800012e4 <release>
      return f;
    80006e02:	fe843783          	ld	a5,-24(s0)
    80006e06:	a805                	j	80006e36 <filealloc+0x7a>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80006e08:	fe843783          	ld	a5,-24(s0)
    80006e0c:	02878793          	addi	a5,a5,40
    80006e10:	fef43423          	sd	a5,-24(s0)
    80006e14:	00069797          	auipc	a5,0x69
    80006e18:	d3c78793          	addi	a5,a5,-708 # 8006fb50 <ftable+0xfb8>
    80006e1c:	fe843703          	ld	a4,-24(s0)
    80006e20:	fcf761e3          	bltu	a4,a5,80006de2 <filealloc+0x26>
    }
  }
  release(&ftable.lock);
    80006e24:	00068517          	auipc	a0,0x68
    80006e28:	d7450513          	addi	a0,a0,-652 # 8006eb98 <ftable>
    80006e2c:	ffffa097          	auipc	ra,0xffffa
    80006e30:	4b8080e7          	jalr	1208(ra) # 800012e4 <release>
  return 0;
    80006e34:	4781                	li	a5,0
}
    80006e36:	853e                	mv	a0,a5
    80006e38:	60e2                	ld	ra,24(sp)
    80006e3a:	6442                	ld	s0,16(sp)
    80006e3c:	6105                	addi	sp,sp,32
    80006e3e:	8082                	ret

0000000080006e40 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
    80006e40:	1101                	addi	sp,sp,-32
    80006e42:	ec06                	sd	ra,24(sp)
    80006e44:	e822                	sd	s0,16(sp)
    80006e46:	1000                	addi	s0,sp,32
    80006e48:	fea43423          	sd	a0,-24(s0)
  acquire(&ftable.lock);
    80006e4c:	00068517          	auipc	a0,0x68
    80006e50:	d4c50513          	addi	a0,a0,-692 # 8006eb98 <ftable>
    80006e54:	ffffa097          	auipc	ra,0xffffa
    80006e58:	42c080e7          	jalr	1068(ra) # 80001280 <acquire>
  if(f->ref < 1)
    80006e5c:	fe843783          	ld	a5,-24(s0)
    80006e60:	43dc                	lw	a5,4(a5)
    80006e62:	00f04a63          	bgtz	a5,80006e76 <filedup+0x36>
    panic("filedup");
    80006e66:	00005517          	auipc	a0,0x5
    80006e6a:	72250513          	addi	a0,a0,1826 # 8000c588 <etext+0x588>
    80006e6e:	ffffa097          	auipc	ra,0xffffa
    80006e72:	de4080e7          	jalr	-540(ra) # 80000c52 <panic>
  f->ref++;
    80006e76:	fe843783          	ld	a5,-24(s0)
    80006e7a:	43dc                	lw	a5,4(a5)
    80006e7c:	2785                	addiw	a5,a5,1
    80006e7e:	0007871b          	sext.w	a4,a5
    80006e82:	fe843783          	ld	a5,-24(s0)
    80006e86:	c3d8                	sw	a4,4(a5)
  release(&ftable.lock);
    80006e88:	00068517          	auipc	a0,0x68
    80006e8c:	d1050513          	addi	a0,a0,-752 # 8006eb98 <ftable>
    80006e90:	ffffa097          	auipc	ra,0xffffa
    80006e94:	454080e7          	jalr	1108(ra) # 800012e4 <release>
  return f;
    80006e98:	fe843783          	ld	a5,-24(s0)
}
    80006e9c:	853e                	mv	a0,a5
    80006e9e:	60e2                	ld	ra,24(sp)
    80006ea0:	6442                	ld	s0,16(sp)
    80006ea2:	6105                	addi	sp,sp,32
    80006ea4:	8082                	ret

0000000080006ea6 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
    80006ea6:	715d                	addi	sp,sp,-80
    80006ea8:	e486                	sd	ra,72(sp)
    80006eaa:	e0a2                	sd	s0,64(sp)
    80006eac:	0880                	addi	s0,sp,80
    80006eae:	faa43c23          	sd	a0,-72(s0)
  struct file ff;

  acquire(&ftable.lock);
    80006eb2:	00068517          	auipc	a0,0x68
    80006eb6:	ce650513          	addi	a0,a0,-794 # 8006eb98 <ftable>
    80006eba:	ffffa097          	auipc	ra,0xffffa
    80006ebe:	3c6080e7          	jalr	966(ra) # 80001280 <acquire>
  if(f->ref < 1)
    80006ec2:	fb843783          	ld	a5,-72(s0)
    80006ec6:	43dc                	lw	a5,4(a5)
    80006ec8:	00f04a63          	bgtz	a5,80006edc <fileclose+0x36>
    panic("fileclose");
    80006ecc:	00005517          	auipc	a0,0x5
    80006ed0:	6c450513          	addi	a0,a0,1732 # 8000c590 <etext+0x590>
    80006ed4:	ffffa097          	auipc	ra,0xffffa
    80006ed8:	d7e080e7          	jalr	-642(ra) # 80000c52 <panic>
  if(--f->ref > 0){
    80006edc:	fb843783          	ld	a5,-72(s0)
    80006ee0:	43dc                	lw	a5,4(a5)
    80006ee2:	37fd                	addiw	a5,a5,-1
    80006ee4:	0007871b          	sext.w	a4,a5
    80006ee8:	fb843783          	ld	a5,-72(s0)
    80006eec:	c3d8                	sw	a4,4(a5)
    80006eee:	fb843783          	ld	a5,-72(s0)
    80006ef2:	43dc                	lw	a5,4(a5)
    80006ef4:	00f05b63          	blez	a5,80006f0a <fileclose+0x64>
    release(&ftable.lock);
    80006ef8:	00068517          	auipc	a0,0x68
    80006efc:	ca050513          	addi	a0,a0,-864 # 8006eb98 <ftable>
    80006f00:	ffffa097          	auipc	ra,0xffffa
    80006f04:	3e4080e7          	jalr	996(ra) # 800012e4 <release>
    80006f08:	a879                	j	80006fa6 <fileclose+0x100>
    return;
  }
  ff = *f;
    80006f0a:	fb843783          	ld	a5,-72(s0)
    80006f0e:	638c                	ld	a1,0(a5)
    80006f10:	6790                	ld	a2,8(a5)
    80006f12:	6b94                	ld	a3,16(a5)
    80006f14:	6f98                	ld	a4,24(a5)
    80006f16:	739c                	ld	a5,32(a5)
    80006f18:	fcb43423          	sd	a1,-56(s0)
    80006f1c:	fcc43823          	sd	a2,-48(s0)
    80006f20:	fcd43c23          	sd	a3,-40(s0)
    80006f24:	fee43023          	sd	a4,-32(s0)
    80006f28:	fef43423          	sd	a5,-24(s0)
  f->ref = 0;
    80006f2c:	fb843783          	ld	a5,-72(s0)
    80006f30:	0007a223          	sw	zero,4(a5)
  f->type = FD_NONE;
    80006f34:	fb843783          	ld	a5,-72(s0)
    80006f38:	0007a023          	sw	zero,0(a5)
  release(&ftable.lock);
    80006f3c:	00068517          	auipc	a0,0x68
    80006f40:	c5c50513          	addi	a0,a0,-932 # 8006eb98 <ftable>
    80006f44:	ffffa097          	auipc	ra,0xffffa
    80006f48:	3a0080e7          	jalr	928(ra) # 800012e4 <release>

  if(ff.type == FD_PIPE){
    80006f4c:	fc842783          	lw	a5,-56(s0)
    80006f50:	873e                	mv	a4,a5
    80006f52:	4785                	li	a5,1
    80006f54:	00f71e63          	bne	a4,a5,80006f70 <fileclose+0xca>
    pipeclose(ff.pipe, ff.writable);
    80006f58:	fd843783          	ld	a5,-40(s0)
    80006f5c:	fd144703          	lbu	a4,-47(s0)
    80006f60:	2701                	sext.w	a4,a4
    80006f62:	85ba                	mv	a1,a4
    80006f64:	853e                	mv	a0,a5
    80006f66:	00000097          	auipc	ra,0x0
    80006f6a:	5ca080e7          	jalr	1482(ra) # 80007530 <pipeclose>
    80006f6e:	a825                	j	80006fa6 <fileclose+0x100>
  } else if(ff.type == FD_INODE || ff.type == FD_DEVICE){
    80006f70:	fc842783          	lw	a5,-56(s0)
    80006f74:	873e                	mv	a4,a5
    80006f76:	4789                	li	a5,2
    80006f78:	00f70863          	beq	a4,a5,80006f88 <fileclose+0xe2>
    80006f7c:	fc842783          	lw	a5,-56(s0)
    80006f80:	873e                	mv	a4,a5
    80006f82:	478d                	li	a5,3
    80006f84:	02f71163          	bne	a4,a5,80006fa6 <fileclose+0x100>
    begin_op();
    80006f88:	00000097          	auipc	ra,0x0
    80006f8c:	884080e7          	jalr	-1916(ra) # 8000680c <begin_op>
    iput(ff.ip);
    80006f90:	fe043783          	ld	a5,-32(s0)
    80006f94:	853e                	mv	a0,a5
    80006f96:	fffff097          	auipc	ra,0xfffff
    80006f9a:	998080e7          	jalr	-1640(ra) # 8000592e <iput>
    end_op();
    80006f9e:	00000097          	auipc	ra,0x0
    80006fa2:	930080e7          	jalr	-1744(ra) # 800068ce <end_op>
  }
}
    80006fa6:	60a6                	ld	ra,72(sp)
    80006fa8:	6406                	ld	s0,64(sp)
    80006faa:	6161                	addi	sp,sp,80
    80006fac:	8082                	ret

0000000080006fae <filestat>:

// Get metadata about file f.
// addr is a user virtual address, pointing to a struct stat.
int
filestat(struct file *f, uint64 addr)
{
    80006fae:	7139                	addi	sp,sp,-64
    80006fb0:	fc06                	sd	ra,56(sp)
    80006fb2:	f822                	sd	s0,48(sp)
    80006fb4:	0080                	addi	s0,sp,64
    80006fb6:	fca43423          	sd	a0,-56(s0)
    80006fba:	fcb43023          	sd	a1,-64(s0)
  struct proc *p = myproc();
    80006fbe:	ffffc097          	auipc	ra,0xffffc
    80006fc2:	83a080e7          	jalr	-1990(ra) # 800027f8 <myproc>
    80006fc6:	fea43423          	sd	a0,-24(s0)
  struct stat st;
  
  if(f->type == FD_INODE || f->type == FD_DEVICE){
    80006fca:	fc843783          	ld	a5,-56(s0)
    80006fce:	439c                	lw	a5,0(a5)
    80006fd0:	873e                	mv	a4,a5
    80006fd2:	4789                	li	a5,2
    80006fd4:	00f70963          	beq	a4,a5,80006fe6 <filestat+0x38>
    80006fd8:	fc843783          	ld	a5,-56(s0)
    80006fdc:	439c                	lw	a5,0(a5)
    80006fde:	873e                	mv	a4,a5
    80006fe0:	478d                	li	a5,3
    80006fe2:	06f71563          	bne	a4,a5,8000704c <filestat+0x9e>
    ilock(f->ip);
    80006fe6:	fc843783          	ld	a5,-56(s0)
    80006fea:	6f9c                	ld	a5,24(a5)
    80006fec:	853e                	mv	a0,a5
    80006fee:	ffffe097          	auipc	ra,0xffffe
    80006ff2:	7b2080e7          	jalr	1970(ra) # 800057a0 <ilock>
    stati(f->ip, &st);
    80006ff6:	fc843783          	ld	a5,-56(s0)
    80006ffa:	6f9c                	ld	a5,24(a5)
    80006ffc:	fd040713          	addi	a4,s0,-48
    80007000:	85ba                	mv	a1,a4
    80007002:	853e                	mv	a0,a5
    80007004:	fffff097          	auipc	ra,0xfffff
    80007008:	cce080e7          	jalr	-818(ra) # 80005cd2 <stati>
    iunlock(f->ip);
    8000700c:	fc843783          	ld	a5,-56(s0)
    80007010:	6f9c                	ld	a5,24(a5)
    80007012:	853e                	mv	a0,a5
    80007014:	fffff097          	auipc	ra,0xfffff
    80007018:	8c0080e7          	jalr	-1856(ra) # 800058d4 <iunlock>
    if(copyout(p->pagetable, addr, (char *)&st, sizeof(st)) < 0)
    8000701c:	fe843703          	ld	a4,-24(s0)
    80007020:	6785                	lui	a5,0x1
    80007022:	97ba                	add	a5,a5,a4
    80007024:	2b07b783          	ld	a5,688(a5) # 12b0 <_entry-0x7fffed50>
    80007028:	fd040713          	addi	a4,s0,-48
    8000702c:	46e1                	li	a3,24
    8000702e:	863a                	mv	a2,a4
    80007030:	fc043583          	ld	a1,-64(s0)
    80007034:	853e                	mv	a0,a5
    80007036:	ffffb097          	auipc	ra,0xffffb
    8000703a:	29e080e7          	jalr	670(ra) # 800022d4 <copyout>
    8000703e:	87aa                	mv	a5,a0
    80007040:	0007d463          	bgez	a5,80007048 <filestat+0x9a>
      return -1;
    80007044:	57fd                	li	a5,-1
    80007046:	a021                	j	8000704e <filestat+0xa0>
    return 0;
    80007048:	4781                	li	a5,0
    8000704a:	a011                	j	8000704e <filestat+0xa0>
  }
  return -1;
    8000704c:	57fd                	li	a5,-1
}
    8000704e:	853e                	mv	a0,a5
    80007050:	70e2                	ld	ra,56(sp)
    80007052:	7442                	ld	s0,48(sp)
    80007054:	6121                	addi	sp,sp,64
    80007056:	8082                	ret

0000000080007058 <fileread>:

// Read from file f.
// addr is a user virtual address.
int
fileread(struct file *f, uint64 addr, int n)
{
    80007058:	7139                	addi	sp,sp,-64
    8000705a:	fc06                	sd	ra,56(sp)
    8000705c:	f822                	sd	s0,48(sp)
    8000705e:	0080                	addi	s0,sp,64
    80007060:	fca43c23          	sd	a0,-40(s0)
    80007064:	fcb43823          	sd	a1,-48(s0)
    80007068:	87b2                	mv	a5,a2
    8000706a:	fcf42623          	sw	a5,-52(s0)
  int r = 0;
    8000706e:	fe042623          	sw	zero,-20(s0)

  if(f->readable == 0)
    80007072:	fd843783          	ld	a5,-40(s0)
    80007076:	0087c783          	lbu	a5,8(a5)
    8000707a:	e399                	bnez	a5,80007080 <fileread+0x28>
    return -1;
    8000707c:	57fd                	li	a5,-1
    8000707e:	aa1d                	j	800071b4 <fileread+0x15c>

  if(f->type == FD_PIPE){
    80007080:	fd843783          	ld	a5,-40(s0)
    80007084:	439c                	lw	a5,0(a5)
    80007086:	873e                	mv	a4,a5
    80007088:	4785                	li	a5,1
    8000708a:	02f71363          	bne	a4,a5,800070b0 <fileread+0x58>
    r = piperead(f->pipe, addr, n);
    8000708e:	fd843783          	ld	a5,-40(s0)
    80007092:	6b9c                	ld	a5,16(a5)
    80007094:	fcc42703          	lw	a4,-52(s0)
    80007098:	863a                	mv	a2,a4
    8000709a:	fd043583          	ld	a1,-48(s0)
    8000709e:	853e                	mv	a0,a5
    800070a0:	00000097          	auipc	ra,0x0
    800070a4:	686080e7          	jalr	1670(ra) # 80007726 <piperead>
    800070a8:	87aa                	mv	a5,a0
    800070aa:	fef42623          	sw	a5,-20(s0)
    800070ae:	a209                	j	800071b0 <fileread+0x158>
  } else if(f->type == FD_DEVICE){
    800070b0:	fd843783          	ld	a5,-40(s0)
    800070b4:	439c                	lw	a5,0(a5)
    800070b6:	873e                	mv	a4,a5
    800070b8:	478d                	li	a5,3
    800070ba:	06f71863          	bne	a4,a5,8000712a <fileread+0xd2>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
    800070be:	fd843783          	ld	a5,-40(s0)
    800070c2:	02479783          	lh	a5,36(a5)
    800070c6:	2781                	sext.w	a5,a5
    800070c8:	0207c863          	bltz	a5,800070f8 <fileread+0xa0>
    800070cc:	fd843783          	ld	a5,-40(s0)
    800070d0:	02479783          	lh	a5,36(a5)
    800070d4:	0007871b          	sext.w	a4,a5
    800070d8:	47a5                	li	a5,9
    800070da:	00e7cf63          	blt	a5,a4,800070f8 <fileread+0xa0>
    800070de:	fd843783          	ld	a5,-40(s0)
    800070e2:	02479783          	lh	a5,36(a5)
    800070e6:	2781                	sext.w	a5,a5
    800070e8:	00068717          	auipc	a4,0x68
    800070ec:	a1070713          	addi	a4,a4,-1520 # 8006eaf8 <devsw>
    800070f0:	0792                	slli	a5,a5,0x4
    800070f2:	97ba                	add	a5,a5,a4
    800070f4:	639c                	ld	a5,0(a5)
    800070f6:	e399                	bnez	a5,800070fc <fileread+0xa4>
      return -1;
    800070f8:	57fd                	li	a5,-1
    800070fa:	a86d                	j	800071b4 <fileread+0x15c>
    r = devsw[f->major].read(1, addr, n);
    800070fc:	fd843783          	ld	a5,-40(s0)
    80007100:	02479783          	lh	a5,36(a5)
    80007104:	2781                	sext.w	a5,a5
    80007106:	00068717          	auipc	a4,0x68
    8000710a:	9f270713          	addi	a4,a4,-1550 # 8006eaf8 <devsw>
    8000710e:	0792                	slli	a5,a5,0x4
    80007110:	97ba                	add	a5,a5,a4
    80007112:	6398                	ld	a4,0(a5)
    80007114:	fcc42783          	lw	a5,-52(s0)
    80007118:	863e                	mv	a2,a5
    8000711a:	fd043583          	ld	a1,-48(s0)
    8000711e:	4505                	li	a0,1
    80007120:	9702                	jalr	a4
    80007122:	87aa                	mv	a5,a0
    80007124:	fef42623          	sw	a5,-20(s0)
    80007128:	a061                	j	800071b0 <fileread+0x158>
  } else if(f->type == FD_INODE){
    8000712a:	fd843783          	ld	a5,-40(s0)
    8000712e:	439c                	lw	a5,0(a5)
    80007130:	873e                	mv	a4,a5
    80007132:	4789                	li	a5,2
    80007134:	06f71663          	bne	a4,a5,800071a0 <fileread+0x148>
    ilock(f->ip);
    80007138:	fd843783          	ld	a5,-40(s0)
    8000713c:	6f9c                	ld	a5,24(a5)
    8000713e:	853e                	mv	a0,a5
    80007140:	ffffe097          	auipc	ra,0xffffe
    80007144:	660080e7          	jalr	1632(ra) # 800057a0 <ilock>
    if((r = readi(f->ip, 1, addr, f->off, n)) > 0)
    80007148:	fd843783          	ld	a5,-40(s0)
    8000714c:	6f88                	ld	a0,24(a5)
    8000714e:	fd843783          	ld	a5,-40(s0)
    80007152:	539c                	lw	a5,32(a5)
    80007154:	fcc42703          	lw	a4,-52(s0)
    80007158:	86be                	mv	a3,a5
    8000715a:	fd043603          	ld	a2,-48(s0)
    8000715e:	4585                	li	a1,1
    80007160:	fffff097          	auipc	ra,0xfffff
    80007164:	bd6080e7          	jalr	-1066(ra) # 80005d36 <readi>
    80007168:	87aa                	mv	a5,a0
    8000716a:	fef42623          	sw	a5,-20(s0)
    8000716e:	fec42783          	lw	a5,-20(s0)
    80007172:	2781                	sext.w	a5,a5
    80007174:	00f05d63          	blez	a5,8000718e <fileread+0x136>
      f->off += r;
    80007178:	fd843783          	ld	a5,-40(s0)
    8000717c:	5398                	lw	a4,32(a5)
    8000717e:	fec42783          	lw	a5,-20(s0)
    80007182:	9fb9                	addw	a5,a5,a4
    80007184:	0007871b          	sext.w	a4,a5
    80007188:	fd843783          	ld	a5,-40(s0)
    8000718c:	d398                	sw	a4,32(a5)
    iunlock(f->ip);
    8000718e:	fd843783          	ld	a5,-40(s0)
    80007192:	6f9c                	ld	a5,24(a5)
    80007194:	853e                	mv	a0,a5
    80007196:	ffffe097          	auipc	ra,0xffffe
    8000719a:	73e080e7          	jalr	1854(ra) # 800058d4 <iunlock>
    8000719e:	a809                	j	800071b0 <fileread+0x158>
  } else {
    panic("fileread");
    800071a0:	00005517          	auipc	a0,0x5
    800071a4:	40050513          	addi	a0,a0,1024 # 8000c5a0 <etext+0x5a0>
    800071a8:	ffffa097          	auipc	ra,0xffffa
    800071ac:	aaa080e7          	jalr	-1366(ra) # 80000c52 <panic>
  }

  return r;
    800071b0:	fec42783          	lw	a5,-20(s0)
}
    800071b4:	853e                	mv	a0,a5
    800071b6:	70e2                	ld	ra,56(sp)
    800071b8:	7442                	ld	s0,48(sp)
    800071ba:	6121                	addi	sp,sp,64
    800071bc:	8082                	ret

00000000800071be <filewrite>:

// Write to file f.
// addr is a user virtual address.
int
filewrite(struct file *f, uint64 addr, int n)
{
    800071be:	715d                	addi	sp,sp,-80
    800071c0:	e486                	sd	ra,72(sp)
    800071c2:	e0a2                	sd	s0,64(sp)
    800071c4:	0880                	addi	s0,sp,80
    800071c6:	fca43423          	sd	a0,-56(s0)
    800071ca:	fcb43023          	sd	a1,-64(s0)
    800071ce:	87b2                	mv	a5,a2
    800071d0:	faf42e23          	sw	a5,-68(s0)
  int r, ret = 0;
    800071d4:	fe042623          	sw	zero,-20(s0)

  if(f->writable == 0)
    800071d8:	fc843783          	ld	a5,-56(s0)
    800071dc:	0097c783          	lbu	a5,9(a5)
    800071e0:	e399                	bnez	a5,800071e6 <filewrite+0x28>
    return -1;
    800071e2:	57fd                	li	a5,-1
    800071e4:	a2fd                	j	800073d2 <filewrite+0x214>

  if(f->type == FD_PIPE){
    800071e6:	fc843783          	ld	a5,-56(s0)
    800071ea:	439c                	lw	a5,0(a5)
    800071ec:	873e                	mv	a4,a5
    800071ee:	4785                	li	a5,1
    800071f0:	02f71363          	bne	a4,a5,80007216 <filewrite+0x58>
    ret = pipewrite(f->pipe, addr, n);
    800071f4:	fc843783          	ld	a5,-56(s0)
    800071f8:	6b9c                	ld	a5,16(a5)
    800071fa:	fbc42703          	lw	a4,-68(s0)
    800071fe:	863a                	mv	a2,a4
    80007200:	fc043583          	ld	a1,-64(s0)
    80007204:	853e                	mv	a0,a5
    80007206:	00000097          	auipc	ra,0x0
    8000720a:	3d2080e7          	jalr	978(ra) # 800075d8 <pipewrite>
    8000720e:	87aa                	mv	a5,a0
    80007210:	fef42623          	sw	a5,-20(s0)
    80007214:	aa6d                	j	800073ce <filewrite+0x210>
  } else if(f->type == FD_DEVICE){
    80007216:	fc843783          	ld	a5,-56(s0)
    8000721a:	439c                	lw	a5,0(a5)
    8000721c:	873e                	mv	a4,a5
    8000721e:	478d                	li	a5,3
    80007220:	06f71863          	bne	a4,a5,80007290 <filewrite+0xd2>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
    80007224:	fc843783          	ld	a5,-56(s0)
    80007228:	02479783          	lh	a5,36(a5)
    8000722c:	2781                	sext.w	a5,a5
    8000722e:	0207c863          	bltz	a5,8000725e <filewrite+0xa0>
    80007232:	fc843783          	ld	a5,-56(s0)
    80007236:	02479783          	lh	a5,36(a5)
    8000723a:	0007871b          	sext.w	a4,a5
    8000723e:	47a5                	li	a5,9
    80007240:	00e7cf63          	blt	a5,a4,8000725e <filewrite+0xa0>
    80007244:	fc843783          	ld	a5,-56(s0)
    80007248:	02479783          	lh	a5,36(a5)
    8000724c:	2781                	sext.w	a5,a5
    8000724e:	00068717          	auipc	a4,0x68
    80007252:	8aa70713          	addi	a4,a4,-1878 # 8006eaf8 <devsw>
    80007256:	0792                	slli	a5,a5,0x4
    80007258:	97ba                	add	a5,a5,a4
    8000725a:	679c                	ld	a5,8(a5)
    8000725c:	e399                	bnez	a5,80007262 <filewrite+0xa4>
      return -1;
    8000725e:	57fd                	li	a5,-1
    80007260:	aa8d                	j	800073d2 <filewrite+0x214>
    ret = devsw[f->major].write(1, addr, n);
    80007262:	fc843783          	ld	a5,-56(s0)
    80007266:	02479783          	lh	a5,36(a5)
    8000726a:	2781                	sext.w	a5,a5
    8000726c:	00068717          	auipc	a4,0x68
    80007270:	88c70713          	addi	a4,a4,-1908 # 8006eaf8 <devsw>
    80007274:	0792                	slli	a5,a5,0x4
    80007276:	97ba                	add	a5,a5,a4
    80007278:	6798                	ld	a4,8(a5)
    8000727a:	fbc42783          	lw	a5,-68(s0)
    8000727e:	863e                	mv	a2,a5
    80007280:	fc043583          	ld	a1,-64(s0)
    80007284:	4505                	li	a0,1
    80007286:	9702                	jalr	a4
    80007288:	87aa                	mv	a5,a0
    8000728a:	fef42623          	sw	a5,-20(s0)
    8000728e:	a281                	j	800073ce <filewrite+0x210>
  } else if(f->type == FD_INODE){
    80007290:	fc843783          	ld	a5,-56(s0)
    80007294:	439c                	lw	a5,0(a5)
    80007296:	873e                	mv	a4,a5
    80007298:	4789                	li	a5,2
    8000729a:	12f71263          	bne	a4,a5,800073be <filewrite+0x200>
    // the maximum log transaction size, including
    // i-node, indirect block, allocation blocks,
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * BSIZE;
    8000729e:	6785                	lui	a5,0x1
    800072a0:	c0078793          	addi	a5,a5,-1024 # c00 <_entry-0x7ffff400>
    800072a4:	fef42023          	sw	a5,-32(s0)
    int i = 0;
    800072a8:	fe042423          	sw	zero,-24(s0)
    while(i < n){
    800072ac:	a0c5                	j	8000738c <filewrite+0x1ce>
      int n1 = n - i;
    800072ae:	fbc42703          	lw	a4,-68(s0)
    800072b2:	fe842783          	lw	a5,-24(s0)
    800072b6:	40f707bb          	subw	a5,a4,a5
    800072ba:	fef42223          	sw	a5,-28(s0)
      if(n1 > max)
    800072be:	fe442703          	lw	a4,-28(s0)
    800072c2:	fe042783          	lw	a5,-32(s0)
    800072c6:	2701                	sext.w	a4,a4
    800072c8:	2781                	sext.w	a5,a5
    800072ca:	00e7d663          	bge	a5,a4,800072d6 <filewrite+0x118>
        n1 = max;
    800072ce:	fe042783          	lw	a5,-32(s0)
    800072d2:	fef42223          	sw	a5,-28(s0)

      begin_op();
    800072d6:	fffff097          	auipc	ra,0xfffff
    800072da:	536080e7          	jalr	1334(ra) # 8000680c <begin_op>
      ilock(f->ip);
    800072de:	fc843783          	ld	a5,-56(s0)
    800072e2:	6f9c                	ld	a5,24(a5)
    800072e4:	853e                	mv	a0,a5
    800072e6:	ffffe097          	auipc	ra,0xffffe
    800072ea:	4ba080e7          	jalr	1210(ra) # 800057a0 <ilock>
      if ((r = writei(f->ip, 1, addr + i, f->off, n1)) > 0)
    800072ee:	fc843783          	ld	a5,-56(s0)
    800072f2:	6f88                	ld	a0,24(a5)
    800072f4:	fe842703          	lw	a4,-24(s0)
    800072f8:	fc043783          	ld	a5,-64(s0)
    800072fc:	00f70633          	add	a2,a4,a5
    80007300:	fc843783          	ld	a5,-56(s0)
    80007304:	539c                	lw	a5,32(a5)
    80007306:	fe442703          	lw	a4,-28(s0)
    8000730a:	86be                	mv	a3,a5
    8000730c:	4585                	li	a1,1
    8000730e:	fffff097          	auipc	ra,0xfffff
    80007312:	bb2080e7          	jalr	-1102(ra) # 80005ec0 <writei>
    80007316:	87aa                	mv	a5,a0
    80007318:	fcf42e23          	sw	a5,-36(s0)
    8000731c:	fdc42783          	lw	a5,-36(s0)
    80007320:	2781                	sext.w	a5,a5
    80007322:	00f05d63          	blez	a5,8000733c <filewrite+0x17e>
        f->off += r;
    80007326:	fc843783          	ld	a5,-56(s0)
    8000732a:	5398                	lw	a4,32(a5)
    8000732c:	fdc42783          	lw	a5,-36(s0)
    80007330:	9fb9                	addw	a5,a5,a4
    80007332:	0007871b          	sext.w	a4,a5
    80007336:	fc843783          	ld	a5,-56(s0)
    8000733a:	d398                	sw	a4,32(a5)
      iunlock(f->ip);
    8000733c:	fc843783          	ld	a5,-56(s0)
    80007340:	6f9c                	ld	a5,24(a5)
    80007342:	853e                	mv	a0,a5
    80007344:	ffffe097          	auipc	ra,0xffffe
    80007348:	590080e7          	jalr	1424(ra) # 800058d4 <iunlock>
      end_op();
    8000734c:	fffff097          	auipc	ra,0xfffff
    80007350:	582080e7          	jalr	1410(ra) # 800068ce <end_op>

      if(r < 0)
    80007354:	fdc42783          	lw	a5,-36(s0)
    80007358:	2781                	sext.w	a5,a5
    8000735a:	0407c263          	bltz	a5,8000739e <filewrite+0x1e0>
        break;
      if(r != n1)
    8000735e:	fdc42703          	lw	a4,-36(s0)
    80007362:	fe442783          	lw	a5,-28(s0)
    80007366:	2701                	sext.w	a4,a4
    80007368:	2781                	sext.w	a5,a5
    8000736a:	00f70a63          	beq	a4,a5,8000737e <filewrite+0x1c0>
        panic("short filewrite");
    8000736e:	00005517          	auipc	a0,0x5
    80007372:	24250513          	addi	a0,a0,578 # 8000c5b0 <etext+0x5b0>
    80007376:	ffffa097          	auipc	ra,0xffffa
    8000737a:	8dc080e7          	jalr	-1828(ra) # 80000c52 <panic>
      i += r;
    8000737e:	fe842703          	lw	a4,-24(s0)
    80007382:	fdc42783          	lw	a5,-36(s0)
    80007386:	9fb9                	addw	a5,a5,a4
    80007388:	fef42423          	sw	a5,-24(s0)
    while(i < n){
    8000738c:	fe842703          	lw	a4,-24(s0)
    80007390:	fbc42783          	lw	a5,-68(s0)
    80007394:	2701                	sext.w	a4,a4
    80007396:	2781                	sext.w	a5,a5
    80007398:	f0f74be3          	blt	a4,a5,800072ae <filewrite+0xf0>
    8000739c:	a011                	j	800073a0 <filewrite+0x1e2>
        break;
    8000739e:	0001                	nop
    }
    ret = (i == n ? n : -1);
    800073a0:	fe842703          	lw	a4,-24(s0)
    800073a4:	fbc42783          	lw	a5,-68(s0)
    800073a8:	2701                	sext.w	a4,a4
    800073aa:	2781                	sext.w	a5,a5
    800073ac:	00f71563          	bne	a4,a5,800073b6 <filewrite+0x1f8>
    800073b0:	fbc42783          	lw	a5,-68(s0)
    800073b4:	a011                	j	800073b8 <filewrite+0x1fa>
    800073b6:	57fd                	li	a5,-1
    800073b8:	fef42623          	sw	a5,-20(s0)
    800073bc:	a809                	j	800073ce <filewrite+0x210>
  } else {
    panic("filewrite");
    800073be:	00005517          	auipc	a0,0x5
    800073c2:	20250513          	addi	a0,a0,514 # 8000c5c0 <etext+0x5c0>
    800073c6:	ffffa097          	auipc	ra,0xffffa
    800073ca:	88c080e7          	jalr	-1908(ra) # 80000c52 <panic>
  }

  return ret;
    800073ce:	fec42783          	lw	a5,-20(s0)
}
    800073d2:	853e                	mv	a0,a5
    800073d4:	60a6                	ld	ra,72(sp)
    800073d6:	6406                	ld	s0,64(sp)
    800073d8:	6161                	addi	sp,sp,80
    800073da:	8082                	ret

00000000800073dc <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
    800073dc:	7179                	addi	sp,sp,-48
    800073de:	f406                	sd	ra,40(sp)
    800073e0:	f022                	sd	s0,32(sp)
    800073e2:	1800                	addi	s0,sp,48
    800073e4:	fca43c23          	sd	a0,-40(s0)
    800073e8:	fcb43823          	sd	a1,-48(s0)
  struct pipe *pi;

  pi = 0;
    800073ec:	fe043423          	sd	zero,-24(s0)
  *f0 = *f1 = 0;
    800073f0:	fd043783          	ld	a5,-48(s0)
    800073f4:	0007b023          	sd	zero,0(a5)
    800073f8:	fd043783          	ld	a5,-48(s0)
    800073fc:	6398                	ld	a4,0(a5)
    800073fe:	fd843783          	ld	a5,-40(s0)
    80007402:	e398                	sd	a4,0(a5)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    80007404:	00000097          	auipc	ra,0x0
    80007408:	9b8080e7          	jalr	-1608(ra) # 80006dbc <filealloc>
    8000740c:	872a                	mv	a4,a0
    8000740e:	fd843783          	ld	a5,-40(s0)
    80007412:	e398                	sd	a4,0(a5)
    80007414:	fd843783          	ld	a5,-40(s0)
    80007418:	639c                	ld	a5,0(a5)
    8000741a:	c3e9                	beqz	a5,800074dc <pipealloc+0x100>
    8000741c:	00000097          	auipc	ra,0x0
    80007420:	9a0080e7          	jalr	-1632(ra) # 80006dbc <filealloc>
    80007424:	872a                	mv	a4,a0
    80007426:	fd043783          	ld	a5,-48(s0)
    8000742a:	e398                	sd	a4,0(a5)
    8000742c:	fd043783          	ld	a5,-48(s0)
    80007430:	639c                	ld	a5,0(a5)
    80007432:	c7cd                	beqz	a5,800074dc <pipealloc+0x100>
    goto bad;
  if((pi = (struct pipe*)kalloc()) == 0)
    80007434:	ffffa097          	auipc	ra,0xffffa
    80007438:	cf8080e7          	jalr	-776(ra) # 8000112c <kalloc>
    8000743c:	fea43423          	sd	a0,-24(s0)
    80007440:	fe843783          	ld	a5,-24(s0)
    80007444:	cfd1                	beqz	a5,800074e0 <pipealloc+0x104>
    goto bad;
  pi->readopen = 1;
    80007446:	fe843783          	ld	a5,-24(s0)
    8000744a:	4705                	li	a4,1
    8000744c:	22e7a023          	sw	a4,544(a5)
  pi->writeopen = 1;
    80007450:	fe843783          	ld	a5,-24(s0)
    80007454:	4705                	li	a4,1
    80007456:	22e7a223          	sw	a4,548(a5)
  pi->nwrite = 0;
    8000745a:	fe843783          	ld	a5,-24(s0)
    8000745e:	2007ae23          	sw	zero,540(a5)
  pi->nread = 0;
    80007462:	fe843783          	ld	a5,-24(s0)
    80007466:	2007ac23          	sw	zero,536(a5)
  initlock(&pi->lock, "pipe");
    8000746a:	fe843783          	ld	a5,-24(s0)
    8000746e:	00005597          	auipc	a1,0x5
    80007472:	16258593          	addi	a1,a1,354 # 8000c5d0 <etext+0x5d0>
    80007476:	853e                	mv	a0,a5
    80007478:	ffffa097          	auipc	ra,0xffffa
    8000747c:	dd8080e7          	jalr	-552(ra) # 80001250 <initlock>
  (*f0)->type = FD_PIPE;
    80007480:	fd843783          	ld	a5,-40(s0)
    80007484:	639c                	ld	a5,0(a5)
    80007486:	4705                	li	a4,1
    80007488:	c398                	sw	a4,0(a5)
  (*f0)->readable = 1;
    8000748a:	fd843783          	ld	a5,-40(s0)
    8000748e:	639c                	ld	a5,0(a5)
    80007490:	4705                	li	a4,1
    80007492:	00e78423          	sb	a4,8(a5)
  (*f0)->writable = 0;
    80007496:	fd843783          	ld	a5,-40(s0)
    8000749a:	639c                	ld	a5,0(a5)
    8000749c:	000784a3          	sb	zero,9(a5)
  (*f0)->pipe = pi;
    800074a0:	fd843783          	ld	a5,-40(s0)
    800074a4:	639c                	ld	a5,0(a5)
    800074a6:	fe843703          	ld	a4,-24(s0)
    800074aa:	eb98                	sd	a4,16(a5)
  (*f1)->type = FD_PIPE;
    800074ac:	fd043783          	ld	a5,-48(s0)
    800074b0:	639c                	ld	a5,0(a5)
    800074b2:	4705                	li	a4,1
    800074b4:	c398                	sw	a4,0(a5)
  (*f1)->readable = 0;
    800074b6:	fd043783          	ld	a5,-48(s0)
    800074ba:	639c                	ld	a5,0(a5)
    800074bc:	00078423          	sb	zero,8(a5)
  (*f1)->writable = 1;
    800074c0:	fd043783          	ld	a5,-48(s0)
    800074c4:	639c                	ld	a5,0(a5)
    800074c6:	4705                	li	a4,1
    800074c8:	00e784a3          	sb	a4,9(a5)
  (*f1)->pipe = pi;
    800074cc:	fd043783          	ld	a5,-48(s0)
    800074d0:	639c                	ld	a5,0(a5)
    800074d2:	fe843703          	ld	a4,-24(s0)
    800074d6:	eb98                	sd	a4,16(a5)
  return 0;
    800074d8:	4781                	li	a5,0
    800074da:	a0b1                	j	80007526 <pipealloc+0x14a>
    goto bad;
    800074dc:	0001                	nop
    800074de:	a011                	j	800074e2 <pipealloc+0x106>
    goto bad;
    800074e0:	0001                	nop

 bad:
  if(pi)
    800074e2:	fe843783          	ld	a5,-24(s0)
    800074e6:	c799                	beqz	a5,800074f4 <pipealloc+0x118>
    kfree((char*)pi);
    800074e8:	fe843503          	ld	a0,-24(s0)
    800074ec:	ffffa097          	auipc	ra,0xffffa
    800074f0:	b9c080e7          	jalr	-1124(ra) # 80001088 <kfree>
  if(*f0)
    800074f4:	fd843783          	ld	a5,-40(s0)
    800074f8:	639c                	ld	a5,0(a5)
    800074fa:	cb89                	beqz	a5,8000750c <pipealloc+0x130>
    fileclose(*f0);
    800074fc:	fd843783          	ld	a5,-40(s0)
    80007500:	639c                	ld	a5,0(a5)
    80007502:	853e                	mv	a0,a5
    80007504:	00000097          	auipc	ra,0x0
    80007508:	9a2080e7          	jalr	-1630(ra) # 80006ea6 <fileclose>
  if(*f1)
    8000750c:	fd043783          	ld	a5,-48(s0)
    80007510:	639c                	ld	a5,0(a5)
    80007512:	cb89                	beqz	a5,80007524 <pipealloc+0x148>
    fileclose(*f1);
    80007514:	fd043783          	ld	a5,-48(s0)
    80007518:	639c                	ld	a5,0(a5)
    8000751a:	853e                	mv	a0,a5
    8000751c:	00000097          	auipc	ra,0x0
    80007520:	98a080e7          	jalr	-1654(ra) # 80006ea6 <fileclose>
  return -1;
    80007524:	57fd                	li	a5,-1
}
    80007526:	853e                	mv	a0,a5
    80007528:	70a2                	ld	ra,40(sp)
    8000752a:	7402                	ld	s0,32(sp)
    8000752c:	6145                	addi	sp,sp,48
    8000752e:	8082                	ret

0000000080007530 <pipeclose>:

void
pipeclose(struct pipe *pi, int writable)
{
    80007530:	1101                	addi	sp,sp,-32
    80007532:	ec06                	sd	ra,24(sp)
    80007534:	e822                	sd	s0,16(sp)
    80007536:	1000                	addi	s0,sp,32
    80007538:	fea43423          	sd	a0,-24(s0)
    8000753c:	87ae                	mv	a5,a1
    8000753e:	fef42223          	sw	a5,-28(s0)
  acquire(&pi->lock);
    80007542:	fe843783          	ld	a5,-24(s0)
    80007546:	853e                	mv	a0,a5
    80007548:	ffffa097          	auipc	ra,0xffffa
    8000754c:	d38080e7          	jalr	-712(ra) # 80001280 <acquire>
  if(writable){
    80007550:	fe442783          	lw	a5,-28(s0)
    80007554:	2781                	sext.w	a5,a5
    80007556:	cf99                	beqz	a5,80007574 <pipeclose+0x44>
    pi->writeopen = 0;
    80007558:	fe843783          	ld	a5,-24(s0)
    8000755c:	2207a223          	sw	zero,548(a5)
    wakeup(&pi->nread);
    80007560:	fe843783          	ld	a5,-24(s0)
    80007564:	21878793          	addi	a5,a5,536
    80007568:	853e                	mv	a0,a5
    8000756a:	ffffc097          	auipc	ra,0xffffc
    8000756e:	05e080e7          	jalr	94(ra) # 800035c8 <wakeup>
    80007572:	a831                	j	8000758e <pipeclose+0x5e>
  } else {
    pi->readopen = 0;
    80007574:	fe843783          	ld	a5,-24(s0)
    80007578:	2207a023          	sw	zero,544(a5)
    wakeup(&pi->nwrite);
    8000757c:	fe843783          	ld	a5,-24(s0)
    80007580:	21c78793          	addi	a5,a5,540
    80007584:	853e                	mv	a0,a5
    80007586:	ffffc097          	auipc	ra,0xffffc
    8000758a:	042080e7          	jalr	66(ra) # 800035c8 <wakeup>
  }
  if(pi->readopen == 0 && pi->writeopen == 0){
    8000758e:	fe843783          	ld	a5,-24(s0)
    80007592:	2207a783          	lw	a5,544(a5)
    80007596:	e785                	bnez	a5,800075be <pipeclose+0x8e>
    80007598:	fe843783          	ld	a5,-24(s0)
    8000759c:	2247a783          	lw	a5,548(a5)
    800075a0:	ef99                	bnez	a5,800075be <pipeclose+0x8e>
    release(&pi->lock);
    800075a2:	fe843783          	ld	a5,-24(s0)
    800075a6:	853e                	mv	a0,a5
    800075a8:	ffffa097          	auipc	ra,0xffffa
    800075ac:	d3c080e7          	jalr	-708(ra) # 800012e4 <release>
    kfree((char*)pi);
    800075b0:	fe843503          	ld	a0,-24(s0)
    800075b4:	ffffa097          	auipc	ra,0xffffa
    800075b8:	ad4080e7          	jalr	-1324(ra) # 80001088 <kfree>
    800075bc:	a809                	j	800075ce <pipeclose+0x9e>
  } else
    release(&pi->lock);
    800075be:	fe843783          	ld	a5,-24(s0)
    800075c2:	853e                	mv	a0,a5
    800075c4:	ffffa097          	auipc	ra,0xffffa
    800075c8:	d20080e7          	jalr	-736(ra) # 800012e4 <release>
}
    800075cc:	0001                	nop
    800075ce:	0001                	nop
    800075d0:	60e2                	ld	ra,24(sp)
    800075d2:	6442                	ld	s0,16(sp)
    800075d4:	6105                	addi	sp,sp,32
    800075d6:	8082                	ret

00000000800075d8 <pipewrite>:

int
pipewrite(struct pipe *pi, uint64 addr, int n)
{
    800075d8:	715d                	addi	sp,sp,-80
    800075da:	e486                	sd	ra,72(sp)
    800075dc:	e0a2                	sd	s0,64(sp)
    800075de:	0880                	addi	s0,sp,80
    800075e0:	fca43423          	sd	a0,-56(s0)
    800075e4:	fcb43023          	sd	a1,-64(s0)
    800075e8:	87b2                	mv	a5,a2
    800075ea:	faf42e23          	sw	a5,-68(s0)
  int i;
  char ch;
  struct proc *pr = myproc();
    800075ee:	ffffb097          	auipc	ra,0xffffb
    800075f2:	20a080e7          	jalr	522(ra) # 800027f8 <myproc>
    800075f6:	fea43023          	sd	a0,-32(s0)

  acquire(&pi->lock);
    800075fa:	fc843783          	ld	a5,-56(s0)
    800075fe:	853e                	mv	a0,a5
    80007600:	ffffa097          	auipc	ra,0xffffa
    80007604:	c80080e7          	jalr	-896(ra) # 80001280 <acquire>
  for(i = 0; i < n; i++){
    80007608:	fe042623          	sw	zero,-20(s0)
    8000760c:	a8e1                	j	800076e4 <pipewrite+0x10c>
    while(pi->nwrite == pi->nread + PIPESIZE){  //DOC: pipewrite-full
      if(pi->readopen == 0 || pr->killed){
    8000760e:	fc843783          	ld	a5,-56(s0)
    80007612:	2207a783          	lw	a5,544(a5)
    80007616:	c789                	beqz	a5,80007620 <pipewrite+0x48>
    80007618:	fe043783          	ld	a5,-32(s0)
    8000761c:	5b9c                	lw	a5,48(a5)
    8000761e:	cb91                	beqz	a5,80007632 <pipewrite+0x5a>
        release(&pi->lock);
    80007620:	fc843783          	ld	a5,-56(s0)
    80007624:	853e                	mv	a0,a5
    80007626:	ffffa097          	auipc	ra,0xffffa
    8000762a:	cbe080e7          	jalr	-834(ra) # 800012e4 <release>
        return -1;
    8000762e:	57fd                	li	a5,-1
    80007630:	a0f5                	j	8000771c <pipewrite+0x144>
      }
      wakeup(&pi->nread);
    80007632:	fc843783          	ld	a5,-56(s0)
    80007636:	21878793          	addi	a5,a5,536
    8000763a:	853e                	mv	a0,a5
    8000763c:	ffffc097          	auipc	ra,0xffffc
    80007640:	f8c080e7          	jalr	-116(ra) # 800035c8 <wakeup>
      sleep(&pi->nwrite, &pi->lock);
    80007644:	fc843783          	ld	a5,-56(s0)
    80007648:	21c78793          	addi	a5,a5,540
    8000764c:	fc843703          	ld	a4,-56(s0)
    80007650:	85ba                	mv	a1,a4
    80007652:	853e                	mv	a0,a5
    80007654:	ffffc097          	auipc	ra,0xffffc
    80007658:	ee0080e7          	jalr	-288(ra) # 80003534 <sleep>
    while(pi->nwrite == pi->nread + PIPESIZE){  //DOC: pipewrite-full
    8000765c:	fc843783          	ld	a5,-56(s0)
    80007660:	21c7a703          	lw	a4,540(a5)
    80007664:	fc843783          	ld	a5,-56(s0)
    80007668:	2187a783          	lw	a5,536(a5)
    8000766c:	2007879b          	addiw	a5,a5,512
    80007670:	2781                	sext.w	a5,a5
    80007672:	f8f70ee3          	beq	a4,a5,8000760e <pipewrite+0x36>
    }
    if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    80007676:	fe043703          	ld	a4,-32(s0)
    8000767a:	6785                	lui	a5,0x1
    8000767c:	97ba                	add	a5,a5,a4
    8000767e:	2b07b503          	ld	a0,688(a5) # 12b0 <_entry-0x7fffed50>
    80007682:	fec42703          	lw	a4,-20(s0)
    80007686:	fc043783          	ld	a5,-64(s0)
    8000768a:	973e                	add	a4,a4,a5
    8000768c:	fdf40793          	addi	a5,s0,-33
    80007690:	4685                	li	a3,1
    80007692:	863a                	mv	a2,a4
    80007694:	85be                	mv	a1,a5
    80007696:	ffffb097          	auipc	ra,0xffffb
    8000769a:	d0c080e7          	jalr	-756(ra) # 800023a2 <copyin>
    8000769e:	87aa                	mv	a5,a0
    800076a0:	873e                	mv	a4,a5
    800076a2:	57fd                	li	a5,-1
    800076a4:	04f70963          	beq	a4,a5,800076f6 <pipewrite+0x11e>
      break;
    pi->data[pi->nwrite++ % PIPESIZE] = ch;
    800076a8:	fc843783          	ld	a5,-56(s0)
    800076ac:	21c7a783          	lw	a5,540(a5)
    800076b0:	2781                	sext.w	a5,a5
    800076b2:	0017871b          	addiw	a4,a5,1
    800076b6:	0007069b          	sext.w	a3,a4
    800076ba:	fc843703          	ld	a4,-56(s0)
    800076be:	20d72e23          	sw	a3,540(a4)
    800076c2:	1ff7f793          	andi	a5,a5,511
    800076c6:	2781                	sext.w	a5,a5
    800076c8:	fdf44703          	lbu	a4,-33(s0)
    800076cc:	fc843683          	ld	a3,-56(s0)
    800076d0:	1782                	slli	a5,a5,0x20
    800076d2:	9381                	srli	a5,a5,0x20
    800076d4:	97b6                	add	a5,a5,a3
    800076d6:	00e78c23          	sb	a4,24(a5)
  for(i = 0; i < n; i++){
    800076da:	fec42783          	lw	a5,-20(s0)
    800076de:	2785                	addiw	a5,a5,1
    800076e0:	fef42623          	sw	a5,-20(s0)
    800076e4:	fec42703          	lw	a4,-20(s0)
    800076e8:	fbc42783          	lw	a5,-68(s0)
    800076ec:	2701                	sext.w	a4,a4
    800076ee:	2781                	sext.w	a5,a5
    800076f0:	f6f746e3          	blt	a4,a5,8000765c <pipewrite+0x84>
    800076f4:	a011                	j	800076f8 <pipewrite+0x120>
      break;
    800076f6:	0001                	nop
  }
  wakeup(&pi->nread);
    800076f8:	fc843783          	ld	a5,-56(s0)
    800076fc:	21878793          	addi	a5,a5,536
    80007700:	853e                	mv	a0,a5
    80007702:	ffffc097          	auipc	ra,0xffffc
    80007706:	ec6080e7          	jalr	-314(ra) # 800035c8 <wakeup>
  release(&pi->lock);
    8000770a:	fc843783          	ld	a5,-56(s0)
    8000770e:	853e                	mv	a0,a5
    80007710:	ffffa097          	auipc	ra,0xffffa
    80007714:	bd4080e7          	jalr	-1068(ra) # 800012e4 <release>
  return i;
    80007718:	fec42783          	lw	a5,-20(s0)
}
    8000771c:	853e                	mv	a0,a5
    8000771e:	60a6                	ld	ra,72(sp)
    80007720:	6406                	ld	s0,64(sp)
    80007722:	6161                	addi	sp,sp,80
    80007724:	8082                	ret

0000000080007726 <piperead>:

int
piperead(struct pipe *pi, uint64 addr, int n)
{
    80007726:	715d                	addi	sp,sp,-80
    80007728:	e486                	sd	ra,72(sp)
    8000772a:	e0a2                	sd	s0,64(sp)
    8000772c:	0880                	addi	s0,sp,80
    8000772e:	fca43423          	sd	a0,-56(s0)
    80007732:	fcb43023          	sd	a1,-64(s0)
    80007736:	87b2                	mv	a5,a2
    80007738:	faf42e23          	sw	a5,-68(s0)
  int i;
  struct proc *pr = myproc();
    8000773c:	ffffb097          	auipc	ra,0xffffb
    80007740:	0bc080e7          	jalr	188(ra) # 800027f8 <myproc>
    80007744:	fea43023          	sd	a0,-32(s0)
  char ch;

  acquire(&pi->lock);
    80007748:	fc843783          	ld	a5,-56(s0)
    8000774c:	853e                	mv	a0,a5
    8000774e:	ffffa097          	auipc	ra,0xffffa
    80007752:	b32080e7          	jalr	-1230(ra) # 80001280 <acquire>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80007756:	a815                	j	8000778a <piperead+0x64>
    if(pr->killed){
    80007758:	fe043783          	ld	a5,-32(s0)
    8000775c:	5b9c                	lw	a5,48(a5)
    8000775e:	cb91                	beqz	a5,80007772 <piperead+0x4c>
      release(&pi->lock);
    80007760:	fc843783          	ld	a5,-56(s0)
    80007764:	853e                	mv	a0,a5
    80007766:	ffffa097          	auipc	ra,0xffffa
    8000776a:	b7e080e7          	jalr	-1154(ra) # 800012e4 <release>
      return -1;
    8000776e:	57fd                	li	a5,-1
    80007770:	a8f5                	j	8000786c <piperead+0x146>
    }
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    80007772:	fc843783          	ld	a5,-56(s0)
    80007776:	21878793          	addi	a5,a5,536
    8000777a:	fc843703          	ld	a4,-56(s0)
    8000777e:	85ba                	mv	a1,a4
    80007780:	853e                	mv	a0,a5
    80007782:	ffffc097          	auipc	ra,0xffffc
    80007786:	db2080e7          	jalr	-590(ra) # 80003534 <sleep>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    8000778a:	fc843783          	ld	a5,-56(s0)
    8000778e:	2187a703          	lw	a4,536(a5)
    80007792:	fc843783          	ld	a5,-56(s0)
    80007796:	21c7a783          	lw	a5,540(a5)
    8000779a:	00f71763          	bne	a4,a5,800077a8 <piperead+0x82>
    8000779e:	fc843783          	ld	a5,-56(s0)
    800077a2:	2247a783          	lw	a5,548(a5)
    800077a6:	fbcd                	bnez	a5,80007758 <piperead+0x32>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    800077a8:	fe042623          	sw	zero,-20(s0)
    800077ac:	a051                	j	80007830 <piperead+0x10a>
    if(pi->nread == pi->nwrite)
    800077ae:	fc843783          	ld	a5,-56(s0)
    800077b2:	2187a703          	lw	a4,536(a5)
    800077b6:	fc843783          	ld	a5,-56(s0)
    800077ba:	21c7a783          	lw	a5,540(a5)
    800077be:	08f70263          	beq	a4,a5,80007842 <piperead+0x11c>
      break;
    ch = pi->data[pi->nread++ % PIPESIZE];
    800077c2:	fc843783          	ld	a5,-56(s0)
    800077c6:	2187a783          	lw	a5,536(a5)
    800077ca:	2781                	sext.w	a5,a5
    800077cc:	0017871b          	addiw	a4,a5,1
    800077d0:	0007069b          	sext.w	a3,a4
    800077d4:	fc843703          	ld	a4,-56(s0)
    800077d8:	20d72c23          	sw	a3,536(a4)
    800077dc:	1ff7f793          	andi	a5,a5,511
    800077e0:	2781                	sext.w	a5,a5
    800077e2:	fc843703          	ld	a4,-56(s0)
    800077e6:	1782                	slli	a5,a5,0x20
    800077e8:	9381                	srli	a5,a5,0x20
    800077ea:	97ba                	add	a5,a5,a4
    800077ec:	0187c783          	lbu	a5,24(a5)
    800077f0:	fcf40fa3          	sb	a5,-33(s0)
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    800077f4:	fe043703          	ld	a4,-32(s0)
    800077f8:	6785                	lui	a5,0x1
    800077fa:	97ba                	add	a5,a5,a4
    800077fc:	2b07b503          	ld	a0,688(a5) # 12b0 <_entry-0x7fffed50>
    80007800:	fec42703          	lw	a4,-20(s0)
    80007804:	fc043783          	ld	a5,-64(s0)
    80007808:	97ba                	add	a5,a5,a4
    8000780a:	fdf40713          	addi	a4,s0,-33
    8000780e:	4685                	li	a3,1
    80007810:	863a                	mv	a2,a4
    80007812:	85be                	mv	a1,a5
    80007814:	ffffb097          	auipc	ra,0xffffb
    80007818:	ac0080e7          	jalr	-1344(ra) # 800022d4 <copyout>
    8000781c:	87aa                	mv	a5,a0
    8000781e:	873e                	mv	a4,a5
    80007820:	57fd                	li	a5,-1
    80007822:	02f70263          	beq	a4,a5,80007846 <piperead+0x120>
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80007826:	fec42783          	lw	a5,-20(s0)
    8000782a:	2785                	addiw	a5,a5,1
    8000782c:	fef42623          	sw	a5,-20(s0)
    80007830:	fec42703          	lw	a4,-20(s0)
    80007834:	fbc42783          	lw	a5,-68(s0)
    80007838:	2701                	sext.w	a4,a4
    8000783a:	2781                	sext.w	a5,a5
    8000783c:	f6f749e3          	blt	a4,a5,800077ae <piperead+0x88>
    80007840:	a021                	j	80007848 <piperead+0x122>
      break;
    80007842:	0001                	nop
    80007844:	a011                	j	80007848 <piperead+0x122>
      break;
    80007846:	0001                	nop
  }
  wakeup(&pi->nwrite);  //DOC: piperead-wakeup
    80007848:	fc843783          	ld	a5,-56(s0)
    8000784c:	21c78793          	addi	a5,a5,540
    80007850:	853e                	mv	a0,a5
    80007852:	ffffc097          	auipc	ra,0xffffc
    80007856:	d76080e7          	jalr	-650(ra) # 800035c8 <wakeup>
  release(&pi->lock);
    8000785a:	fc843783          	ld	a5,-56(s0)
    8000785e:	853e                	mv	a0,a5
    80007860:	ffffa097          	auipc	ra,0xffffa
    80007864:	a84080e7          	jalr	-1404(ra) # 800012e4 <release>
  return i;
    80007868:	fec42783          	lw	a5,-20(s0)
}
    8000786c:	853e                	mv	a0,a5
    8000786e:	60a6                	ld	ra,72(sp)
    80007870:	6406                	ld	s0,64(sp)
    80007872:	6161                	addi	sp,sp,80
    80007874:	8082                	ret

0000000080007876 <exec>:

static int loadseg(pde_t *pgdir, uint64 addr, struct inode *ip, uint offset, uint sz);

int
exec(char *path, char **argv)
{
    80007876:	de010113          	addi	sp,sp,-544
    8000787a:	20113c23          	sd	ra,536(sp)
    8000787e:	20813823          	sd	s0,528(sp)
    80007882:	20913423          	sd	s1,520(sp)
    80007886:	1400                	addi	s0,sp,544
    80007888:	dea43423          	sd	a0,-536(s0)
    8000788c:	deb43023          	sd	a1,-544(s0)
  char *s, *last;
  int i, off;
  uint64 argc, sz = 0, sp, ustack[MAXARG+1], stackbase;
    80007890:	fa043c23          	sd	zero,-72(s0)
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pagetable_t pagetable = 0, oldpagetable;
    80007894:	fa043023          	sd	zero,-96(s0)
  struct proc *p = myproc();
    80007898:	ffffb097          	auipc	ra,0xffffb
    8000789c:	f60080e7          	jalr	-160(ra) # 800027f8 <myproc>
    800078a0:	f8a43c23          	sd	a0,-104(s0)

  begin_op();
    800078a4:	fffff097          	auipc	ra,0xfffff
    800078a8:	f68080e7          	jalr	-152(ra) # 8000680c <begin_op>

  if((ip = namei(path)) == 0){
    800078ac:	de843503          	ld	a0,-536(s0)
    800078b0:	fffff097          	auipc	ra,0xfffff
    800078b4:	bf8080e7          	jalr	-1032(ra) # 800064a8 <namei>
    800078b8:	faa43423          	sd	a0,-88(s0)
    800078bc:	fa843783          	ld	a5,-88(s0)
    800078c0:	e799                	bnez	a5,800078ce <exec+0x58>
    end_op();
    800078c2:	fffff097          	auipc	ra,0xfffff
    800078c6:	00c080e7          	jalr	12(ra) # 800068ce <end_op>
    return -1;
    800078ca:	57fd                	li	a5,-1
    800078cc:	a185                	j	80007d2c <exec+0x4b6>
  }
  ilock(ip);
    800078ce:	fa843503          	ld	a0,-88(s0)
    800078d2:	ffffe097          	auipc	ra,0xffffe
    800078d6:	ece080e7          	jalr	-306(ra) # 800057a0 <ilock>

  // Check ELF header
  if(readi(ip, 0, (uint64)&elf, 0, sizeof(elf)) != sizeof(elf))
    800078da:	e2840793          	addi	a5,s0,-472
    800078de:	04000713          	li	a4,64
    800078e2:	4681                	li	a3,0
    800078e4:	863e                	mv	a2,a5
    800078e6:	4581                	li	a1,0
    800078e8:	fa843503          	ld	a0,-88(s0)
    800078ec:	ffffe097          	auipc	ra,0xffffe
    800078f0:	44a080e7          	jalr	1098(ra) # 80005d36 <readi>
    800078f4:	87aa                	mv	a5,a0
    800078f6:	873e                	mv	a4,a5
    800078f8:	04000793          	li	a5,64
    800078fc:	3cf71263          	bne	a4,a5,80007cc0 <exec+0x44a>
    goto bad;
  if(elf.magic != ELF_MAGIC)
    80007900:	e2842783          	lw	a5,-472(s0)
    80007904:	873e                	mv	a4,a5
    80007906:	464c47b7          	lui	a5,0x464c4
    8000790a:	57f78793          	addi	a5,a5,1407 # 464c457f <_entry-0x39b3ba81>
    8000790e:	3af71b63          	bne	a4,a5,80007cc4 <exec+0x44e>
    goto bad;

  if((pagetable = proc_pagetable(p)) == 0)
    80007912:	f9843503          	ld	a0,-104(s0)
    80007916:	ffffb097          	auipc	ra,0xffffb
    8000791a:	1ea080e7          	jalr	490(ra) # 80002b00 <proc_pagetable>
    8000791e:	faa43023          	sd	a0,-96(s0)
    80007922:	fa043783          	ld	a5,-96(s0)
    80007926:	3a078163          	beqz	a5,80007cc8 <exec+0x452>
    goto bad;

  // Load program into memory.
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    8000792a:	fc042623          	sw	zero,-52(s0)
    8000792e:	e4843783          	ld	a5,-440(s0)
    80007932:	fcf42423          	sw	a5,-56(s0)
    80007936:	a8e1                	j	80007a0e <exec+0x198>
    if(readi(ip, 0, (uint64)&ph, off, sizeof(ph)) != sizeof(ph))
    80007938:	df040793          	addi	a5,s0,-528
    8000793c:	fc842683          	lw	a3,-56(s0)
    80007940:	03800713          	li	a4,56
    80007944:	863e                	mv	a2,a5
    80007946:	4581                	li	a1,0
    80007948:	fa843503          	ld	a0,-88(s0)
    8000794c:	ffffe097          	auipc	ra,0xffffe
    80007950:	3ea080e7          	jalr	1002(ra) # 80005d36 <readi>
    80007954:	87aa                	mv	a5,a0
    80007956:	873e                	mv	a4,a5
    80007958:	03800793          	li	a5,56
    8000795c:	36f71863          	bne	a4,a5,80007ccc <exec+0x456>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
    80007960:	df042783          	lw	a5,-528(s0)
    80007964:	873e                	mv	a4,a5
    80007966:	4785                	li	a5,1
    80007968:	08f71663          	bne	a4,a5,800079f4 <exec+0x17e>
      continue;
    if(ph.memsz < ph.filesz)
    8000796c:	e1843703          	ld	a4,-488(s0)
    80007970:	e1043783          	ld	a5,-496(s0)
    80007974:	34f76e63          	bltu	a4,a5,80007cd0 <exec+0x45a>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
    80007978:	e0043703          	ld	a4,-512(s0)
    8000797c:	e1843783          	ld	a5,-488(s0)
    80007980:	973e                	add	a4,a4,a5
    80007982:	e0043783          	ld	a5,-512(s0)
    80007986:	34f76763          	bltu	a4,a5,80007cd4 <exec+0x45e>
      goto bad;
    uint64 sz1;
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz)) == 0)
    8000798a:	e0043703          	ld	a4,-512(s0)
    8000798e:	e1843783          	ld	a5,-488(s0)
    80007992:	97ba                	add	a5,a5,a4
    80007994:	863e                	mv	a2,a5
    80007996:	fb843583          	ld	a1,-72(s0)
    8000799a:	fa043503          	ld	a0,-96(s0)
    8000799e:	ffffa097          	auipc	ra,0xffffa
    800079a2:	558080e7          	jalr	1368(ra) # 80001ef6 <uvmalloc>
    800079a6:	f6a43823          	sd	a0,-144(s0)
    800079aa:	f7043783          	ld	a5,-144(s0)
    800079ae:	32078563          	beqz	a5,80007cd8 <exec+0x462>
      goto bad;
    sz = sz1;
    800079b2:	f7043783          	ld	a5,-144(s0)
    800079b6:	faf43c23          	sd	a5,-72(s0)
    if(ph.vaddr % PGSIZE != 0)
    800079ba:	e0043703          	ld	a4,-512(s0)
    800079be:	6785                	lui	a5,0x1
    800079c0:	17fd                	addi	a5,a5,-1
    800079c2:	8ff9                	and	a5,a5,a4
    800079c4:	30079c63          	bnez	a5,80007cdc <exec+0x466>
      goto bad;
    if(loadseg(pagetable, ph.vaddr, ip, ph.off, ph.filesz) < 0)
    800079c8:	e0043783          	ld	a5,-512(s0)
    800079cc:	df843703          	ld	a4,-520(s0)
    800079d0:	0007069b          	sext.w	a3,a4
    800079d4:	e1043703          	ld	a4,-496(s0)
    800079d8:	2701                	sext.w	a4,a4
    800079da:	fa843603          	ld	a2,-88(s0)
    800079de:	85be                	mv	a1,a5
    800079e0:	fa043503          	ld	a0,-96(s0)
    800079e4:	00000097          	auipc	ra,0x0
    800079e8:	35c080e7          	jalr	860(ra) # 80007d40 <loadseg>
    800079ec:	87aa                	mv	a5,a0
    800079ee:	2e07c963          	bltz	a5,80007ce0 <exec+0x46a>
    800079f2:	a011                	j	800079f6 <exec+0x180>
      continue;
    800079f4:	0001                	nop
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    800079f6:	fcc42783          	lw	a5,-52(s0)
    800079fa:	2785                	addiw	a5,a5,1
    800079fc:	fcf42623          	sw	a5,-52(s0)
    80007a00:	fc842783          	lw	a5,-56(s0)
    80007a04:	0387879b          	addiw	a5,a5,56
    80007a08:	2781                	sext.w	a5,a5
    80007a0a:	fcf42423          	sw	a5,-56(s0)
    80007a0e:	e6045783          	lhu	a5,-416(s0)
    80007a12:	0007871b          	sext.w	a4,a5
    80007a16:	fcc42783          	lw	a5,-52(s0)
    80007a1a:	2781                	sext.w	a5,a5
    80007a1c:	f0e7cee3          	blt	a5,a4,80007938 <exec+0xc2>
      goto bad;
  }
  iunlockput(ip);
    80007a20:	fa843503          	ld	a0,-88(s0)
    80007a24:	ffffe097          	auipc	ra,0xffffe
    80007a28:	fda080e7          	jalr	-38(ra) # 800059fe <iunlockput>
  end_op();
    80007a2c:	fffff097          	auipc	ra,0xfffff
    80007a30:	ea2080e7          	jalr	-350(ra) # 800068ce <end_op>
  ip = 0;
    80007a34:	fa043423          	sd	zero,-88(s0)

  p = myproc();
    80007a38:	ffffb097          	auipc	ra,0xffffb
    80007a3c:	dc0080e7          	jalr	-576(ra) # 800027f8 <myproc>
    80007a40:	f8a43c23          	sd	a0,-104(s0)
  uint64 oldsz = p->sz;
    80007a44:	f9843703          	ld	a4,-104(s0)
    80007a48:	6785                	lui	a5,0x1
    80007a4a:	97ba                	add	a5,a5,a4
    80007a4c:	2a87b783          	ld	a5,680(a5) # 12a8 <_entry-0x7fffed58>
    80007a50:	f8f43823          	sd	a5,-112(s0)

  // Allocate two pages at the next page boundary.
  // Use the second as the user stack.
  sz = PGROUNDUP(sz);
    80007a54:	fb843703          	ld	a4,-72(s0)
    80007a58:	6785                	lui	a5,0x1
    80007a5a:	17fd                	addi	a5,a5,-1
    80007a5c:	973e                	add	a4,a4,a5
    80007a5e:	77fd                	lui	a5,0xfffff
    80007a60:	8ff9                	and	a5,a5,a4
    80007a62:	faf43c23          	sd	a5,-72(s0)
  uint64 sz1;
  if((sz1 = uvmalloc(pagetable, sz, sz + 2*PGSIZE)) == 0)
    80007a66:	fb843703          	ld	a4,-72(s0)
    80007a6a:	6789                	lui	a5,0x2
    80007a6c:	97ba                	add	a5,a5,a4
    80007a6e:	863e                	mv	a2,a5
    80007a70:	fb843583          	ld	a1,-72(s0)
    80007a74:	fa043503          	ld	a0,-96(s0)
    80007a78:	ffffa097          	auipc	ra,0xffffa
    80007a7c:	47e080e7          	jalr	1150(ra) # 80001ef6 <uvmalloc>
    80007a80:	f8a43423          	sd	a0,-120(s0)
    80007a84:	f8843783          	ld	a5,-120(s0)
    80007a88:	24078e63          	beqz	a5,80007ce4 <exec+0x46e>
    goto bad;
  sz = sz1;
    80007a8c:	f8843783          	ld	a5,-120(s0)
    80007a90:	faf43c23          	sd	a5,-72(s0)
  uvmclear(pagetable, sz-2*PGSIZE);
    80007a94:	fb843703          	ld	a4,-72(s0)
    80007a98:	77f9                	lui	a5,0xffffe
    80007a9a:	97ba                	add	a5,a5,a4
    80007a9c:	85be                	mv	a1,a5
    80007a9e:	fa043503          	ld	a0,-96(s0)
    80007aa2:	ffffa097          	auipc	ra,0xffffa
    80007aa6:	7dc080e7          	jalr	2012(ra) # 8000227e <uvmclear>
  sp = sz;
    80007aaa:	fb843783          	ld	a5,-72(s0)
    80007aae:	faf43823          	sd	a5,-80(s0)
  stackbase = sp - PGSIZE;
    80007ab2:	fb043703          	ld	a4,-80(s0)
    80007ab6:	77fd                	lui	a5,0xfffff
    80007ab8:	97ba                	add	a5,a5,a4
    80007aba:	f8f43023          	sd	a5,-128(s0)

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
    80007abe:	fc043023          	sd	zero,-64(s0)
    80007ac2:	a845                	j	80007b72 <exec+0x2fc>
    if(argc >= MAXARG)
    80007ac4:	fc043703          	ld	a4,-64(s0)
    80007ac8:	47fd                	li	a5,31
    80007aca:	20e7ef63          	bltu	a5,a4,80007ce8 <exec+0x472>
      goto bad;
    sp -= strlen(argv[argc]) + 1;
    80007ace:	fc043783          	ld	a5,-64(s0)
    80007ad2:	078e                	slli	a5,a5,0x3
    80007ad4:	de043703          	ld	a4,-544(s0)
    80007ad8:	97ba                	add	a5,a5,a4
    80007ada:	639c                	ld	a5,0(a5)
    80007adc:	853e                	mv	a0,a5
    80007ade:	ffffa097          	auipc	ra,0xffffa
    80007ae2:	ce6080e7          	jalr	-794(ra) # 800017c4 <strlen>
    80007ae6:	87aa                	mv	a5,a0
    80007ae8:	2785                	addiw	a5,a5,1
    80007aea:	2781                	sext.w	a5,a5
    80007aec:	873e                	mv	a4,a5
    80007aee:	fb043783          	ld	a5,-80(s0)
    80007af2:	8f99                	sub	a5,a5,a4
    80007af4:	faf43823          	sd	a5,-80(s0)
    sp -= sp % 16; // riscv sp must be 16-byte aligned
    80007af8:	fb043783          	ld	a5,-80(s0)
    80007afc:	9bc1                	andi	a5,a5,-16
    80007afe:	faf43823          	sd	a5,-80(s0)
    if(sp < stackbase)
    80007b02:	fb043703          	ld	a4,-80(s0)
    80007b06:	f8043783          	ld	a5,-128(s0)
    80007b0a:	1ef76163          	bltu	a4,a5,80007cec <exec+0x476>
      goto bad;
    if(copyout(pagetable, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
    80007b0e:	fc043783          	ld	a5,-64(s0)
    80007b12:	078e                	slli	a5,a5,0x3
    80007b14:	de043703          	ld	a4,-544(s0)
    80007b18:	97ba                	add	a5,a5,a4
    80007b1a:	6384                	ld	s1,0(a5)
    80007b1c:	fc043783          	ld	a5,-64(s0)
    80007b20:	078e                	slli	a5,a5,0x3
    80007b22:	de043703          	ld	a4,-544(s0)
    80007b26:	97ba                	add	a5,a5,a4
    80007b28:	639c                	ld	a5,0(a5)
    80007b2a:	853e                	mv	a0,a5
    80007b2c:	ffffa097          	auipc	ra,0xffffa
    80007b30:	c98080e7          	jalr	-872(ra) # 800017c4 <strlen>
    80007b34:	87aa                	mv	a5,a0
    80007b36:	2785                	addiw	a5,a5,1
    80007b38:	2781                	sext.w	a5,a5
    80007b3a:	86be                	mv	a3,a5
    80007b3c:	8626                	mv	a2,s1
    80007b3e:	fb043583          	ld	a1,-80(s0)
    80007b42:	fa043503          	ld	a0,-96(s0)
    80007b46:	ffffa097          	auipc	ra,0xffffa
    80007b4a:	78e080e7          	jalr	1934(ra) # 800022d4 <copyout>
    80007b4e:	87aa                	mv	a5,a0
    80007b50:	1a07c063          	bltz	a5,80007cf0 <exec+0x47a>
      goto bad;
    ustack[argc] = sp;
    80007b54:	fc043783          	ld	a5,-64(s0)
    80007b58:	078e                	slli	a5,a5,0x3
    80007b5a:	fe040713          	addi	a4,s0,-32
    80007b5e:	97ba                	add	a5,a5,a4
    80007b60:	fb043703          	ld	a4,-80(s0)
    80007b64:	e8e7b423          	sd	a4,-376(a5) # ffffffffffffee88 <end+0xffffffff7ff8be88>
  for(argc = 0; argv[argc]; argc++) {
    80007b68:	fc043783          	ld	a5,-64(s0)
    80007b6c:	0785                	addi	a5,a5,1
    80007b6e:	fcf43023          	sd	a5,-64(s0)
    80007b72:	fc043783          	ld	a5,-64(s0)
    80007b76:	078e                	slli	a5,a5,0x3
    80007b78:	de043703          	ld	a4,-544(s0)
    80007b7c:	97ba                	add	a5,a5,a4
    80007b7e:	639c                	ld	a5,0(a5)
    80007b80:	f3b1                	bnez	a5,80007ac4 <exec+0x24e>
  }
  ustack[argc] = 0;
    80007b82:	fc043783          	ld	a5,-64(s0)
    80007b86:	078e                	slli	a5,a5,0x3
    80007b88:	fe040713          	addi	a4,s0,-32
    80007b8c:	97ba                	add	a5,a5,a4
    80007b8e:	e807b423          	sd	zero,-376(a5)

  // push the array of argv[] pointers.
  sp -= (argc+1) * sizeof(uint64);
    80007b92:	fc043783          	ld	a5,-64(s0)
    80007b96:	0785                	addi	a5,a5,1
    80007b98:	078e                	slli	a5,a5,0x3
    80007b9a:	fb043703          	ld	a4,-80(s0)
    80007b9e:	40f707b3          	sub	a5,a4,a5
    80007ba2:	faf43823          	sd	a5,-80(s0)
  sp -= sp % 16;
    80007ba6:	fb043783          	ld	a5,-80(s0)
    80007baa:	9bc1                	andi	a5,a5,-16
    80007bac:	faf43823          	sd	a5,-80(s0)
  if(sp < stackbase)
    80007bb0:	fb043703          	ld	a4,-80(s0)
    80007bb4:	f8043783          	ld	a5,-128(s0)
    80007bb8:	12f76e63          	bltu	a4,a5,80007cf4 <exec+0x47e>
    goto bad;
  if(copyout(pagetable, sp, (char *)ustack, (argc+1)*sizeof(uint64)) < 0)
    80007bbc:	fc043783          	ld	a5,-64(s0)
    80007bc0:	0785                	addi	a5,a5,1
    80007bc2:	00379713          	slli	a4,a5,0x3
    80007bc6:	e6840793          	addi	a5,s0,-408
    80007bca:	86ba                	mv	a3,a4
    80007bcc:	863e                	mv	a2,a5
    80007bce:	fb043583          	ld	a1,-80(s0)
    80007bd2:	fa043503          	ld	a0,-96(s0)
    80007bd6:	ffffa097          	auipc	ra,0xffffa
    80007bda:	6fe080e7          	jalr	1790(ra) # 800022d4 <copyout>
    80007bde:	87aa                	mv	a5,a0
    80007be0:	1007cc63          	bltz	a5,80007cf8 <exec+0x482>
    goto bad;

  // arguments to user main(argc, argv)
  // argc is returned via the system call return
  // value, which goes in a0.
  p->trapframe->a1 = sp;
    80007be4:	f9843703          	ld	a4,-104(s0)
    80007be8:	6785                	lui	a5,0x1
    80007bea:	97ba                	add	a5,a5,a4
    80007bec:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80007bf0:	fb043703          	ld	a4,-80(s0)
    80007bf4:	ffb8                	sd	a4,120(a5)

  // Save program name for debugging.
  for(last=s=path; *s; s++)
    80007bf6:	de843783          	ld	a5,-536(s0)
    80007bfa:	fcf43c23          	sd	a5,-40(s0)
    80007bfe:	fd843783          	ld	a5,-40(s0)
    80007c02:	fcf43823          	sd	a5,-48(s0)
    80007c06:	a025                	j	80007c2e <exec+0x3b8>
    if(*s == '/')
    80007c08:	fd843783          	ld	a5,-40(s0)
    80007c0c:	0007c783          	lbu	a5,0(a5)
    80007c10:	873e                	mv	a4,a5
    80007c12:	02f00793          	li	a5,47
    80007c16:	00f71763          	bne	a4,a5,80007c24 <exec+0x3ae>
      last = s+1;
    80007c1a:	fd843783          	ld	a5,-40(s0)
    80007c1e:	0785                	addi	a5,a5,1
    80007c20:	fcf43823          	sd	a5,-48(s0)
  for(last=s=path; *s; s++)
    80007c24:	fd843783          	ld	a5,-40(s0)
    80007c28:	0785                	addi	a5,a5,1
    80007c2a:	fcf43c23          	sd	a5,-40(s0)
    80007c2e:	fd843783          	ld	a5,-40(s0)
    80007c32:	0007c783          	lbu	a5,0(a5)
    80007c36:	fbe9                	bnez	a5,80007c08 <exec+0x392>
  safestrcpy(p->name, last, sizeof(p->name));
    80007c38:	f9843703          	ld	a4,-104(s0)
    80007c3c:	6785                	lui	a5,0x1
    80007c3e:	3b878793          	addi	a5,a5,952 # 13b8 <_entry-0x7fffec48>
    80007c42:	97ba                	add	a5,a5,a4
    80007c44:	4641                	li	a2,16
    80007c46:	fd043583          	ld	a1,-48(s0)
    80007c4a:	853e                	mv	a0,a5
    80007c4c:	ffffa097          	auipc	ra,0xffffa
    80007c50:	afe080e7          	jalr	-1282(ra) # 8000174a <safestrcpy>
    
  // Commit to the user image.
  oldpagetable = p->pagetable;
    80007c54:	f9843703          	ld	a4,-104(s0)
    80007c58:	6785                	lui	a5,0x1
    80007c5a:	97ba                	add	a5,a5,a4
    80007c5c:	2b07b783          	ld	a5,688(a5) # 12b0 <_entry-0x7fffed50>
    80007c60:	f6f43c23          	sd	a5,-136(s0)
  p->pagetable = pagetable;
    80007c64:	f9843703          	ld	a4,-104(s0)
    80007c68:	6785                	lui	a5,0x1
    80007c6a:	97ba                	add	a5,a5,a4
    80007c6c:	fa043703          	ld	a4,-96(s0)
    80007c70:	2ae7b823          	sd	a4,688(a5) # 12b0 <_entry-0x7fffed50>
  p->sz = sz;
    80007c74:	f9843703          	ld	a4,-104(s0)
    80007c78:	6785                	lui	a5,0x1
    80007c7a:	97ba                	add	a5,a5,a4
    80007c7c:	fb843703          	ld	a4,-72(s0)
    80007c80:	2ae7b423          	sd	a4,680(a5) # 12a8 <_entry-0x7fffed58>
  p->trapframe->epc = elf.entry;  // initial program counter = main
    80007c84:	f9843703          	ld	a4,-104(s0)
    80007c88:	6785                	lui	a5,0x1
    80007c8a:	97ba                	add	a5,a5,a4
    80007c8c:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80007c90:	e4043703          	ld	a4,-448(s0)
    80007c94:	ef98                	sd	a4,24(a5)
  p->trapframe->sp = sp; // initial stack pointer
    80007c96:	f9843703          	ld	a4,-104(s0)
    80007c9a:	6785                	lui	a5,0x1
    80007c9c:	97ba                	add	a5,a5,a4
    80007c9e:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80007ca2:	fb043703          	ld	a4,-80(s0)
    80007ca6:	fb98                	sd	a4,48(a5)
  proc_freepagetable(oldpagetable, oldsz);
    80007ca8:	f9043583          	ld	a1,-112(s0)
    80007cac:	f7843503          	ld	a0,-136(s0)
    80007cb0:	ffffb097          	auipc	ra,0xffffb
    80007cb4:	f16080e7          	jalr	-234(ra) # 80002bc6 <proc_freepagetable>

  return argc; // this ends up in a0, the first argument to main(argc, argv)
    80007cb8:	fc043783          	ld	a5,-64(s0)
    80007cbc:	2781                	sext.w	a5,a5
    80007cbe:	a0bd                	j	80007d2c <exec+0x4b6>
    goto bad;
    80007cc0:	0001                	nop
    80007cc2:	a825                	j	80007cfa <exec+0x484>
    goto bad;
    80007cc4:	0001                	nop
    80007cc6:	a815                	j	80007cfa <exec+0x484>
    goto bad;
    80007cc8:	0001                	nop
    80007cca:	a805                	j	80007cfa <exec+0x484>
      goto bad;
    80007ccc:	0001                	nop
    80007cce:	a035                	j	80007cfa <exec+0x484>
      goto bad;
    80007cd0:	0001                	nop
    80007cd2:	a025                	j	80007cfa <exec+0x484>
      goto bad;
    80007cd4:	0001                	nop
    80007cd6:	a015                	j	80007cfa <exec+0x484>
      goto bad;
    80007cd8:	0001                	nop
    80007cda:	a005                	j	80007cfa <exec+0x484>
      goto bad;
    80007cdc:	0001                	nop
    80007cde:	a831                	j	80007cfa <exec+0x484>
      goto bad;
    80007ce0:	0001                	nop
    80007ce2:	a821                	j	80007cfa <exec+0x484>
    goto bad;
    80007ce4:	0001                	nop
    80007ce6:	a811                	j	80007cfa <exec+0x484>
      goto bad;
    80007ce8:	0001                	nop
    80007cea:	a801                	j	80007cfa <exec+0x484>
      goto bad;
    80007cec:	0001                	nop
    80007cee:	a031                	j	80007cfa <exec+0x484>
      goto bad;
    80007cf0:	0001                	nop
    80007cf2:	a021                	j	80007cfa <exec+0x484>
    goto bad;
    80007cf4:	0001                	nop
    80007cf6:	a011                	j	80007cfa <exec+0x484>
    goto bad;
    80007cf8:	0001                	nop

 bad:
  if(pagetable)
    80007cfa:	fa043783          	ld	a5,-96(s0)
    80007cfe:	cb89                	beqz	a5,80007d10 <exec+0x49a>
    proc_freepagetable(pagetable, sz);
    80007d00:	fb843583          	ld	a1,-72(s0)
    80007d04:	fa043503          	ld	a0,-96(s0)
    80007d08:	ffffb097          	auipc	ra,0xffffb
    80007d0c:	ebe080e7          	jalr	-322(ra) # 80002bc6 <proc_freepagetable>
  if(ip){
    80007d10:	fa843783          	ld	a5,-88(s0)
    80007d14:	cb99                	beqz	a5,80007d2a <exec+0x4b4>
    iunlockput(ip);
    80007d16:	fa843503          	ld	a0,-88(s0)
    80007d1a:	ffffe097          	auipc	ra,0xffffe
    80007d1e:	ce4080e7          	jalr	-796(ra) # 800059fe <iunlockput>
    end_op();
    80007d22:	fffff097          	auipc	ra,0xfffff
    80007d26:	bac080e7          	jalr	-1108(ra) # 800068ce <end_op>
  }
  return -1;
    80007d2a:	57fd                	li	a5,-1
}
    80007d2c:	853e                	mv	a0,a5
    80007d2e:	21813083          	ld	ra,536(sp)
    80007d32:	21013403          	ld	s0,528(sp)
    80007d36:	20813483          	ld	s1,520(sp)
    80007d3a:	22010113          	addi	sp,sp,544
    80007d3e:	8082                	ret

0000000080007d40 <loadseg>:
// va must be page-aligned
// and the pages from va to va+sz must already be mapped.
// Returns 0 on success, -1 on failure.
static int
loadseg(pagetable_t pagetable, uint64 va, struct inode *ip, uint offset, uint sz)
{
    80007d40:	7139                	addi	sp,sp,-64
    80007d42:	fc06                	sd	ra,56(sp)
    80007d44:	f822                	sd	s0,48(sp)
    80007d46:	0080                	addi	s0,sp,64
    80007d48:	fca43c23          	sd	a0,-40(s0)
    80007d4c:	fcb43823          	sd	a1,-48(s0)
    80007d50:	fcc43423          	sd	a2,-56(s0)
    80007d54:	87b6                	mv	a5,a3
    80007d56:	fcf42223          	sw	a5,-60(s0)
    80007d5a:	87ba                	mv	a5,a4
    80007d5c:	fcf42023          	sw	a5,-64(s0)
  uint i, n;
  uint64 pa;

  if((va % PGSIZE) != 0)
    80007d60:	fd043703          	ld	a4,-48(s0)
    80007d64:	6785                	lui	a5,0x1
    80007d66:	17fd                	addi	a5,a5,-1
    80007d68:	8ff9                	and	a5,a5,a4
    80007d6a:	cb89                	beqz	a5,80007d7c <loadseg+0x3c>
    panic("loadseg: va must be page aligned");
    80007d6c:	00005517          	auipc	a0,0x5
    80007d70:	86c50513          	addi	a0,a0,-1940 # 8000c5d8 <etext+0x5d8>
    80007d74:	ffff9097          	auipc	ra,0xffff9
    80007d78:	ede080e7          	jalr	-290(ra) # 80000c52 <panic>

  for(i = 0; i < sz; i += PGSIZE){
    80007d7c:	fe042623          	sw	zero,-20(s0)
    80007d80:	a05d                	j	80007e26 <loadseg+0xe6>
    pa = walkaddr(pagetable, va + i);
    80007d82:	fec46703          	lwu	a4,-20(s0)
    80007d86:	fd043783          	ld	a5,-48(s0)
    80007d8a:	97ba                	add	a5,a5,a4
    80007d8c:	85be                	mv	a1,a5
    80007d8e:	fd843503          	ld	a0,-40(s0)
    80007d92:	ffffa097          	auipc	ra,0xffffa
    80007d96:	e06080e7          	jalr	-506(ra) # 80001b98 <walkaddr>
    80007d9a:	fea43023          	sd	a0,-32(s0)
    if(pa == 0)
    80007d9e:	fe043783          	ld	a5,-32(s0)
    80007da2:	eb89                	bnez	a5,80007db4 <loadseg+0x74>
      panic("loadseg: address should exist");
    80007da4:	00005517          	auipc	a0,0x5
    80007da8:	85c50513          	addi	a0,a0,-1956 # 8000c600 <etext+0x600>
    80007dac:	ffff9097          	auipc	ra,0xffff9
    80007db0:	ea6080e7          	jalr	-346(ra) # 80000c52 <panic>
    if(sz - i < PGSIZE)
    80007db4:	fc042703          	lw	a4,-64(s0)
    80007db8:	fec42783          	lw	a5,-20(s0)
    80007dbc:	40f707bb          	subw	a5,a4,a5
    80007dc0:	2781                	sext.w	a5,a5
    80007dc2:	873e                	mv	a4,a5
    80007dc4:	6785                	lui	a5,0x1
    80007dc6:	00f77b63          	bgeu	a4,a5,80007ddc <loadseg+0x9c>
      n = sz - i;
    80007dca:	fc042703          	lw	a4,-64(s0)
    80007dce:	fec42783          	lw	a5,-20(s0)
    80007dd2:	40f707bb          	subw	a5,a4,a5
    80007dd6:	fef42423          	sw	a5,-24(s0)
    80007dda:	a021                	j	80007de2 <loadseg+0xa2>
    else
      n = PGSIZE;
    80007ddc:	6785                	lui	a5,0x1
    80007dde:	fef42423          	sw	a5,-24(s0)
    if(readi(ip, 0, (uint64)pa, offset+i, n) != n)
    80007de2:	fc442703          	lw	a4,-60(s0)
    80007de6:	fec42783          	lw	a5,-20(s0)
    80007dea:	9fb9                	addw	a5,a5,a4
    80007dec:	2781                	sext.w	a5,a5
    80007dee:	fe842703          	lw	a4,-24(s0)
    80007df2:	86be                	mv	a3,a5
    80007df4:	fe043603          	ld	a2,-32(s0)
    80007df8:	4581                	li	a1,0
    80007dfa:	fc843503          	ld	a0,-56(s0)
    80007dfe:	ffffe097          	auipc	ra,0xffffe
    80007e02:	f38080e7          	jalr	-200(ra) # 80005d36 <readi>
    80007e06:	87aa                	mv	a5,a0
    80007e08:	0007871b          	sext.w	a4,a5
    80007e0c:	fe842783          	lw	a5,-24(s0)
    80007e10:	2781                	sext.w	a5,a5
    80007e12:	00e78463          	beq	a5,a4,80007e1a <loadseg+0xda>
      return -1;
    80007e16:	57fd                	li	a5,-1
    80007e18:	a005                	j	80007e38 <loadseg+0xf8>
  for(i = 0; i < sz; i += PGSIZE){
    80007e1a:	fec42703          	lw	a4,-20(s0)
    80007e1e:	6785                	lui	a5,0x1
    80007e20:	9fb9                	addw	a5,a5,a4
    80007e22:	fef42623          	sw	a5,-20(s0)
    80007e26:	fec42703          	lw	a4,-20(s0)
    80007e2a:	fc042783          	lw	a5,-64(s0)
    80007e2e:	2701                	sext.w	a4,a4
    80007e30:	2781                	sext.w	a5,a5
    80007e32:	f4f768e3          	bltu	a4,a5,80007d82 <loadseg+0x42>
  }
  
  return 0;
    80007e36:	4781                	li	a5,0
}
    80007e38:	853e                	mv	a0,a5
    80007e3a:	70e2                	ld	ra,56(sp)
    80007e3c:	7442                	ld	s0,48(sp)
    80007e3e:	6121                	addi	sp,sp,64
    80007e40:	8082                	ret

0000000080007e42 <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
    80007e42:	7139                	addi	sp,sp,-64
    80007e44:	fc06                	sd	ra,56(sp)
    80007e46:	f822                	sd	s0,48(sp)
    80007e48:	0080                	addi	s0,sp,64
    80007e4a:	87aa                	mv	a5,a0
    80007e4c:	fcb43823          	sd	a1,-48(s0)
    80007e50:	fcc43423          	sd	a2,-56(s0)
    80007e54:	fcf42e23          	sw	a5,-36(s0)
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    80007e58:	fe440713          	addi	a4,s0,-28
    80007e5c:	fdc42783          	lw	a5,-36(s0)
    80007e60:	85ba                	mv	a1,a4
    80007e62:	853e                	mv	a0,a5
    80007e64:	ffffd097          	auipc	ra,0xffffd
    80007e68:	94e080e7          	jalr	-1714(ra) # 800047b2 <argint>
    80007e6c:	87aa                	mv	a5,a0
    80007e6e:	0007d463          	bgez	a5,80007e76 <argfd+0x34>
    return -1;
    80007e72:	57fd                	li	a5,-1
    80007e74:	a8b9                	j	80007ed2 <argfd+0x90>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
    80007e76:	fe442783          	lw	a5,-28(s0)
    80007e7a:	0207c963          	bltz	a5,80007eac <argfd+0x6a>
    80007e7e:	fe442783          	lw	a5,-28(s0)
    80007e82:	873e                	mv	a4,a5
    80007e84:	47bd                	li	a5,15
    80007e86:	02e7c363          	blt	a5,a4,80007eac <argfd+0x6a>
    80007e8a:	ffffb097          	auipc	ra,0xffffb
    80007e8e:	96e080e7          	jalr	-1682(ra) # 800027f8 <myproc>
    80007e92:	872a                	mv	a4,a0
    80007e94:	fe442783          	lw	a5,-28(s0)
    80007e98:	26678793          	addi	a5,a5,614 # 1266 <_entry-0x7fffed9a>
    80007e9c:	078e                	slli	a5,a5,0x3
    80007e9e:	97ba                	add	a5,a5,a4
    80007ea0:	639c                	ld	a5,0(a5)
    80007ea2:	fef43423          	sd	a5,-24(s0)
    80007ea6:	fe843783          	ld	a5,-24(s0)
    80007eaa:	e399                	bnez	a5,80007eb0 <argfd+0x6e>
    return -1;
    80007eac:	57fd                	li	a5,-1
    80007eae:	a015                	j	80007ed2 <argfd+0x90>
  if(pfd)
    80007eb0:	fd043783          	ld	a5,-48(s0)
    80007eb4:	c791                	beqz	a5,80007ec0 <argfd+0x7e>
    *pfd = fd;
    80007eb6:	fe442703          	lw	a4,-28(s0)
    80007eba:	fd043783          	ld	a5,-48(s0)
    80007ebe:	c398                	sw	a4,0(a5)
  if(pf)
    80007ec0:	fc843783          	ld	a5,-56(s0)
    80007ec4:	c791                	beqz	a5,80007ed0 <argfd+0x8e>
    *pf = f;
    80007ec6:	fc843783          	ld	a5,-56(s0)
    80007eca:	fe843703          	ld	a4,-24(s0)
    80007ece:	e398                	sd	a4,0(a5)
  return 0;
    80007ed0:	4781                	li	a5,0
}
    80007ed2:	853e                	mv	a0,a5
    80007ed4:	70e2                	ld	ra,56(sp)
    80007ed6:	7442                	ld	s0,48(sp)
    80007ed8:	6121                	addi	sp,sp,64
    80007eda:	8082                	ret

0000000080007edc <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
    80007edc:	7179                	addi	sp,sp,-48
    80007ede:	f406                	sd	ra,40(sp)
    80007ee0:	f022                	sd	s0,32(sp)
    80007ee2:	1800                	addi	s0,sp,48
    80007ee4:	fca43c23          	sd	a0,-40(s0)
  int fd;
  struct proc *p = myproc();
    80007ee8:	ffffb097          	auipc	ra,0xffffb
    80007eec:	910080e7          	jalr	-1776(ra) # 800027f8 <myproc>
    80007ef0:	fea43023          	sd	a0,-32(s0)

  for(fd = 0; fd < NOFILE; fd++){
    80007ef4:	fe042623          	sw	zero,-20(s0)
    80007ef8:	a835                	j	80007f34 <fdalloc+0x58>
    if(p->ofile[fd] == 0){
    80007efa:	fe043703          	ld	a4,-32(s0)
    80007efe:	fec42783          	lw	a5,-20(s0)
    80007f02:	26678793          	addi	a5,a5,614
    80007f06:	078e                	slli	a5,a5,0x3
    80007f08:	97ba                	add	a5,a5,a4
    80007f0a:	639c                	ld	a5,0(a5)
    80007f0c:	ef99                	bnez	a5,80007f2a <fdalloc+0x4e>
      p->ofile[fd] = f;
    80007f0e:	fe043703          	ld	a4,-32(s0)
    80007f12:	fec42783          	lw	a5,-20(s0)
    80007f16:	26678793          	addi	a5,a5,614
    80007f1a:	078e                	slli	a5,a5,0x3
    80007f1c:	97ba                	add	a5,a5,a4
    80007f1e:	fd843703          	ld	a4,-40(s0)
    80007f22:	e398                	sd	a4,0(a5)
      return fd;
    80007f24:	fec42783          	lw	a5,-20(s0)
    80007f28:	a831                	j	80007f44 <fdalloc+0x68>
  for(fd = 0; fd < NOFILE; fd++){
    80007f2a:	fec42783          	lw	a5,-20(s0)
    80007f2e:	2785                	addiw	a5,a5,1
    80007f30:	fef42623          	sw	a5,-20(s0)
    80007f34:	fec42783          	lw	a5,-20(s0)
    80007f38:	0007871b          	sext.w	a4,a5
    80007f3c:	47bd                	li	a5,15
    80007f3e:	fae7dee3          	bge	a5,a4,80007efa <fdalloc+0x1e>
    }
  }
  return -1;
    80007f42:	57fd                	li	a5,-1
}
    80007f44:	853e                	mv	a0,a5
    80007f46:	70a2                	ld	ra,40(sp)
    80007f48:	7402                	ld	s0,32(sp)
    80007f4a:	6145                	addi	sp,sp,48
    80007f4c:	8082                	ret

0000000080007f4e <sys_dup>:

uint64
sys_dup(void)
{
    80007f4e:	1101                	addi	sp,sp,-32
    80007f50:	ec06                	sd	ra,24(sp)
    80007f52:	e822                	sd	s0,16(sp)
    80007f54:	1000                	addi	s0,sp,32
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
    80007f56:	fe040793          	addi	a5,s0,-32
    80007f5a:	863e                	mv	a2,a5
    80007f5c:	4581                	li	a1,0
    80007f5e:	4501                	li	a0,0
    80007f60:	00000097          	auipc	ra,0x0
    80007f64:	ee2080e7          	jalr	-286(ra) # 80007e42 <argfd>
    80007f68:	87aa                	mv	a5,a0
    80007f6a:	0007d463          	bgez	a5,80007f72 <sys_dup+0x24>
    return -1;
    80007f6e:	57fd                	li	a5,-1
    80007f70:	a81d                	j	80007fa6 <sys_dup+0x58>
  if((fd=fdalloc(f)) < 0)
    80007f72:	fe043783          	ld	a5,-32(s0)
    80007f76:	853e                	mv	a0,a5
    80007f78:	00000097          	auipc	ra,0x0
    80007f7c:	f64080e7          	jalr	-156(ra) # 80007edc <fdalloc>
    80007f80:	87aa                	mv	a5,a0
    80007f82:	fef42623          	sw	a5,-20(s0)
    80007f86:	fec42783          	lw	a5,-20(s0)
    80007f8a:	2781                	sext.w	a5,a5
    80007f8c:	0007d463          	bgez	a5,80007f94 <sys_dup+0x46>
    return -1;
    80007f90:	57fd                	li	a5,-1
    80007f92:	a811                	j	80007fa6 <sys_dup+0x58>
  filedup(f);
    80007f94:	fe043783          	ld	a5,-32(s0)
    80007f98:	853e                	mv	a0,a5
    80007f9a:	fffff097          	auipc	ra,0xfffff
    80007f9e:	ea6080e7          	jalr	-346(ra) # 80006e40 <filedup>
  return fd;
    80007fa2:	fec42783          	lw	a5,-20(s0)
}
    80007fa6:	853e                	mv	a0,a5
    80007fa8:	60e2                	ld	ra,24(sp)
    80007faa:	6442                	ld	s0,16(sp)
    80007fac:	6105                	addi	sp,sp,32
    80007fae:	8082                	ret

0000000080007fb0 <sys_read>:

uint64
sys_read(void)
{
    80007fb0:	7179                	addi	sp,sp,-48
    80007fb2:	f406                	sd	ra,40(sp)
    80007fb4:	f022                	sd	s0,32(sp)
    80007fb6:	1800                	addi	s0,sp,48
  struct file *f;
  int n;
  uint64 p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80007fb8:	fe840793          	addi	a5,s0,-24
    80007fbc:	863e                	mv	a2,a5
    80007fbe:	4581                	li	a1,0
    80007fc0:	4501                	li	a0,0
    80007fc2:	00000097          	auipc	ra,0x0
    80007fc6:	e80080e7          	jalr	-384(ra) # 80007e42 <argfd>
    80007fca:	87aa                	mv	a5,a0
    80007fcc:	0207c863          	bltz	a5,80007ffc <sys_read+0x4c>
    80007fd0:	fe440793          	addi	a5,s0,-28
    80007fd4:	85be                	mv	a1,a5
    80007fd6:	4509                	li	a0,2
    80007fd8:	ffffc097          	auipc	ra,0xffffc
    80007fdc:	7da080e7          	jalr	2010(ra) # 800047b2 <argint>
    80007fe0:	87aa                	mv	a5,a0
    80007fe2:	0007cd63          	bltz	a5,80007ffc <sys_read+0x4c>
    80007fe6:	fd840793          	addi	a5,s0,-40
    80007fea:	85be                	mv	a1,a5
    80007fec:	4505                	li	a0,1
    80007fee:	ffffc097          	auipc	ra,0xffffc
    80007ff2:	7fc080e7          	jalr	2044(ra) # 800047ea <argaddr>
    80007ff6:	87aa                	mv	a5,a0
    80007ff8:	0007d463          	bgez	a5,80008000 <sys_read+0x50>
    return -1;
    80007ffc:	57fd                	li	a5,-1
    80007ffe:	a839                	j	8000801c <sys_read+0x6c>
  return fileread(f, p, n);
    80008000:	fe843783          	ld	a5,-24(s0)
    80008004:	fd843703          	ld	a4,-40(s0)
    80008008:	fe442683          	lw	a3,-28(s0)
    8000800c:	8636                	mv	a2,a3
    8000800e:	85ba                	mv	a1,a4
    80008010:	853e                	mv	a0,a5
    80008012:	fffff097          	auipc	ra,0xfffff
    80008016:	046080e7          	jalr	70(ra) # 80007058 <fileread>
    8000801a:	87aa                	mv	a5,a0
}
    8000801c:	853e                	mv	a0,a5
    8000801e:	70a2                	ld	ra,40(sp)
    80008020:	7402                	ld	s0,32(sp)
    80008022:	6145                	addi	sp,sp,48
    80008024:	8082                	ret

0000000080008026 <sys_write>:

uint64
sys_write(void)
{
    80008026:	7179                	addi	sp,sp,-48
    80008028:	f406                	sd	ra,40(sp)
    8000802a:	f022                	sd	s0,32(sp)
    8000802c:	1800                	addi	s0,sp,48
  struct file *f;
  int n;
  uint64 p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    8000802e:	fe840793          	addi	a5,s0,-24
    80008032:	863e                	mv	a2,a5
    80008034:	4581                	li	a1,0
    80008036:	4501                	li	a0,0
    80008038:	00000097          	auipc	ra,0x0
    8000803c:	e0a080e7          	jalr	-502(ra) # 80007e42 <argfd>
    80008040:	87aa                	mv	a5,a0
    80008042:	0207c863          	bltz	a5,80008072 <sys_write+0x4c>
    80008046:	fe440793          	addi	a5,s0,-28
    8000804a:	85be                	mv	a1,a5
    8000804c:	4509                	li	a0,2
    8000804e:	ffffc097          	auipc	ra,0xffffc
    80008052:	764080e7          	jalr	1892(ra) # 800047b2 <argint>
    80008056:	87aa                	mv	a5,a0
    80008058:	0007cd63          	bltz	a5,80008072 <sys_write+0x4c>
    8000805c:	fd840793          	addi	a5,s0,-40
    80008060:	85be                	mv	a1,a5
    80008062:	4505                	li	a0,1
    80008064:	ffffc097          	auipc	ra,0xffffc
    80008068:	786080e7          	jalr	1926(ra) # 800047ea <argaddr>
    8000806c:	87aa                	mv	a5,a0
    8000806e:	0007d463          	bgez	a5,80008076 <sys_write+0x50>
    return -1;
    80008072:	57fd                	li	a5,-1
    80008074:	a839                	j	80008092 <sys_write+0x6c>

  return filewrite(f, p, n);
    80008076:	fe843783          	ld	a5,-24(s0)
    8000807a:	fd843703          	ld	a4,-40(s0)
    8000807e:	fe442683          	lw	a3,-28(s0)
    80008082:	8636                	mv	a2,a3
    80008084:	85ba                	mv	a1,a4
    80008086:	853e                	mv	a0,a5
    80008088:	fffff097          	auipc	ra,0xfffff
    8000808c:	136080e7          	jalr	310(ra) # 800071be <filewrite>
    80008090:	87aa                	mv	a5,a0
}
    80008092:	853e                	mv	a0,a5
    80008094:	70a2                	ld	ra,40(sp)
    80008096:	7402                	ld	s0,32(sp)
    80008098:	6145                	addi	sp,sp,48
    8000809a:	8082                	ret

000000008000809c <sys_close>:

uint64
sys_close(void)
{
    8000809c:	1101                	addi	sp,sp,-32
    8000809e:	ec06                	sd	ra,24(sp)
    800080a0:	e822                	sd	s0,16(sp)
    800080a2:	1000                	addi	s0,sp,32
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
    800080a4:	fe040713          	addi	a4,s0,-32
    800080a8:	fec40793          	addi	a5,s0,-20
    800080ac:	863a                	mv	a2,a4
    800080ae:	85be                	mv	a1,a5
    800080b0:	4501                	li	a0,0
    800080b2:	00000097          	auipc	ra,0x0
    800080b6:	d90080e7          	jalr	-624(ra) # 80007e42 <argfd>
    800080ba:	87aa                	mv	a5,a0
    800080bc:	0007d463          	bgez	a5,800080c4 <sys_close+0x28>
    return -1;
    800080c0:	57fd                	li	a5,-1
    800080c2:	a035                	j	800080ee <sys_close+0x52>
  myproc()->ofile[fd] = 0;
    800080c4:	ffffa097          	auipc	ra,0xffffa
    800080c8:	734080e7          	jalr	1844(ra) # 800027f8 <myproc>
    800080cc:	872a                	mv	a4,a0
    800080ce:	fec42783          	lw	a5,-20(s0)
    800080d2:	26678793          	addi	a5,a5,614
    800080d6:	078e                	slli	a5,a5,0x3
    800080d8:	97ba                	add	a5,a5,a4
    800080da:	0007b023          	sd	zero,0(a5)
  fileclose(f);
    800080de:	fe043783          	ld	a5,-32(s0)
    800080e2:	853e                	mv	a0,a5
    800080e4:	fffff097          	auipc	ra,0xfffff
    800080e8:	dc2080e7          	jalr	-574(ra) # 80006ea6 <fileclose>
  return 0;
    800080ec:	4781                	li	a5,0
}
    800080ee:	853e                	mv	a0,a5
    800080f0:	60e2                	ld	ra,24(sp)
    800080f2:	6442                	ld	s0,16(sp)
    800080f4:	6105                	addi	sp,sp,32
    800080f6:	8082                	ret

00000000800080f8 <sys_fstat>:

uint64
sys_fstat(void)
{
    800080f8:	1101                	addi	sp,sp,-32
    800080fa:	ec06                	sd	ra,24(sp)
    800080fc:	e822                	sd	s0,16(sp)
    800080fe:	1000                	addi	s0,sp,32
  struct file *f;
  uint64 st; // user pointer to struct stat

  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    80008100:	fe840793          	addi	a5,s0,-24
    80008104:	863e                	mv	a2,a5
    80008106:	4581                	li	a1,0
    80008108:	4501                	li	a0,0
    8000810a:	00000097          	auipc	ra,0x0
    8000810e:	d38080e7          	jalr	-712(ra) # 80007e42 <argfd>
    80008112:	87aa                	mv	a5,a0
    80008114:	0007cd63          	bltz	a5,8000812e <sys_fstat+0x36>
    80008118:	fe040793          	addi	a5,s0,-32
    8000811c:	85be                	mv	a1,a5
    8000811e:	4505                	li	a0,1
    80008120:	ffffc097          	auipc	ra,0xffffc
    80008124:	6ca080e7          	jalr	1738(ra) # 800047ea <argaddr>
    80008128:	87aa                	mv	a5,a0
    8000812a:	0007d463          	bgez	a5,80008132 <sys_fstat+0x3a>
    return -1;
    8000812e:	57fd                	li	a5,-1
    80008130:	a821                	j	80008148 <sys_fstat+0x50>
  return filestat(f, st);
    80008132:	fe843783          	ld	a5,-24(s0)
    80008136:	fe043703          	ld	a4,-32(s0)
    8000813a:	85ba                	mv	a1,a4
    8000813c:	853e                	mv	a0,a5
    8000813e:	fffff097          	auipc	ra,0xfffff
    80008142:	e70080e7          	jalr	-400(ra) # 80006fae <filestat>
    80008146:	87aa                	mv	a5,a0
}
    80008148:	853e                	mv	a0,a5
    8000814a:	60e2                	ld	ra,24(sp)
    8000814c:	6442                	ld	s0,16(sp)
    8000814e:	6105                	addi	sp,sp,32
    80008150:	8082                	ret

0000000080008152 <sys_link>:

// Create the path new as a link to the same inode as old.
uint64
sys_link(void)
{
    80008152:	7169                	addi	sp,sp,-304
    80008154:	f606                	sd	ra,296(sp)
    80008156:	f222                	sd	s0,288(sp)
    80008158:	1a00                	addi	s0,sp,304
  char name[DIRSIZ], new[MAXPATH], old[MAXPATH];
  struct inode *dp, *ip;

  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    8000815a:	ed040793          	addi	a5,s0,-304
    8000815e:	08000613          	li	a2,128
    80008162:	85be                	mv	a1,a5
    80008164:	4501                	li	a0,0
    80008166:	ffffc097          	auipc	ra,0xffffc
    8000816a:	6b8080e7          	jalr	1720(ra) # 8000481e <argstr>
    8000816e:	87aa                	mv	a5,a0
    80008170:	0007cf63          	bltz	a5,8000818e <sys_link+0x3c>
    80008174:	f5040793          	addi	a5,s0,-176
    80008178:	08000613          	li	a2,128
    8000817c:	85be                	mv	a1,a5
    8000817e:	4505                	li	a0,1
    80008180:	ffffc097          	auipc	ra,0xffffc
    80008184:	69e080e7          	jalr	1694(ra) # 8000481e <argstr>
    80008188:	87aa                	mv	a5,a0
    8000818a:	0007d463          	bgez	a5,80008192 <sys_link+0x40>
    return -1;
    8000818e:	57fd                	li	a5,-1
    80008190:	aab5                	j	8000830c <sys_link+0x1ba>

  begin_op();
    80008192:	ffffe097          	auipc	ra,0xffffe
    80008196:	67a080e7          	jalr	1658(ra) # 8000680c <begin_op>
  if((ip = namei(old)) == 0){
    8000819a:	ed040793          	addi	a5,s0,-304
    8000819e:	853e                	mv	a0,a5
    800081a0:	ffffe097          	auipc	ra,0xffffe
    800081a4:	308080e7          	jalr	776(ra) # 800064a8 <namei>
    800081a8:	fea43423          	sd	a0,-24(s0)
    800081ac:	fe843783          	ld	a5,-24(s0)
    800081b0:	e799                	bnez	a5,800081be <sys_link+0x6c>
    end_op();
    800081b2:	ffffe097          	auipc	ra,0xffffe
    800081b6:	71c080e7          	jalr	1820(ra) # 800068ce <end_op>
    return -1;
    800081ba:	57fd                	li	a5,-1
    800081bc:	aa81                	j	8000830c <sys_link+0x1ba>
  }

  ilock(ip);
    800081be:	fe843503          	ld	a0,-24(s0)
    800081c2:	ffffd097          	auipc	ra,0xffffd
    800081c6:	5de080e7          	jalr	1502(ra) # 800057a0 <ilock>
  if(ip->type == T_DIR){
    800081ca:	fe843783          	ld	a5,-24(s0)
    800081ce:	04479783          	lh	a5,68(a5)
    800081d2:	0007871b          	sext.w	a4,a5
    800081d6:	4785                	li	a5,1
    800081d8:	00f71e63          	bne	a4,a5,800081f4 <sys_link+0xa2>
    iunlockput(ip);
    800081dc:	fe843503          	ld	a0,-24(s0)
    800081e0:	ffffe097          	auipc	ra,0xffffe
    800081e4:	81e080e7          	jalr	-2018(ra) # 800059fe <iunlockput>
    end_op();
    800081e8:	ffffe097          	auipc	ra,0xffffe
    800081ec:	6e6080e7          	jalr	1766(ra) # 800068ce <end_op>
    return -1;
    800081f0:	57fd                	li	a5,-1
    800081f2:	aa29                	j	8000830c <sys_link+0x1ba>
  }

  ip->nlink++;
    800081f4:	fe843783          	ld	a5,-24(s0)
    800081f8:	04a79783          	lh	a5,74(a5)
    800081fc:	17c2                	slli	a5,a5,0x30
    800081fe:	93c1                	srli	a5,a5,0x30
    80008200:	2785                	addiw	a5,a5,1
    80008202:	17c2                	slli	a5,a5,0x30
    80008204:	93c1                	srli	a5,a5,0x30
    80008206:	0107971b          	slliw	a4,a5,0x10
    8000820a:	4107571b          	sraiw	a4,a4,0x10
    8000820e:	fe843783          	ld	a5,-24(s0)
    80008212:	04e79523          	sh	a4,74(a5)
  iupdate(ip);
    80008216:	fe843503          	ld	a0,-24(s0)
    8000821a:	ffffd097          	auipc	ra,0xffffd
    8000821e:	336080e7          	jalr	822(ra) # 80005550 <iupdate>
  iunlock(ip);
    80008222:	fe843503          	ld	a0,-24(s0)
    80008226:	ffffd097          	auipc	ra,0xffffd
    8000822a:	6ae080e7          	jalr	1710(ra) # 800058d4 <iunlock>

  if((dp = nameiparent(new, name)) == 0)
    8000822e:	fd040713          	addi	a4,s0,-48
    80008232:	f5040793          	addi	a5,s0,-176
    80008236:	85ba                	mv	a1,a4
    80008238:	853e                	mv	a0,a5
    8000823a:	ffffe097          	auipc	ra,0xffffe
    8000823e:	29a080e7          	jalr	666(ra) # 800064d4 <nameiparent>
    80008242:	fea43023          	sd	a0,-32(s0)
    80008246:	fe043783          	ld	a5,-32(s0)
    8000824a:	cba5                	beqz	a5,800082ba <sys_link+0x168>
    goto bad;
  ilock(dp);
    8000824c:	fe043503          	ld	a0,-32(s0)
    80008250:	ffffd097          	auipc	ra,0xffffd
    80008254:	550080e7          	jalr	1360(ra) # 800057a0 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    80008258:	fe043783          	ld	a5,-32(s0)
    8000825c:	4398                	lw	a4,0(a5)
    8000825e:	fe843783          	ld	a5,-24(s0)
    80008262:	439c                	lw	a5,0(a5)
    80008264:	02f71263          	bne	a4,a5,80008288 <sys_link+0x136>
    80008268:	fe843783          	ld	a5,-24(s0)
    8000826c:	43d8                	lw	a4,4(a5)
    8000826e:	fd040793          	addi	a5,s0,-48
    80008272:	863a                	mv	a2,a4
    80008274:	85be                	mv	a1,a5
    80008276:	fe043503          	ld	a0,-32(s0)
    8000827a:	ffffe097          	auipc	ra,0xffffe
    8000827e:	f10080e7          	jalr	-240(ra) # 8000618a <dirlink>
    80008282:	87aa                	mv	a5,a0
    80008284:	0007d963          	bgez	a5,80008296 <sys_link+0x144>
    iunlockput(dp);
    80008288:	fe043503          	ld	a0,-32(s0)
    8000828c:	ffffd097          	auipc	ra,0xffffd
    80008290:	772080e7          	jalr	1906(ra) # 800059fe <iunlockput>
    goto bad;
    80008294:	a025                	j	800082bc <sys_link+0x16a>
  }
  iunlockput(dp);
    80008296:	fe043503          	ld	a0,-32(s0)
    8000829a:	ffffd097          	auipc	ra,0xffffd
    8000829e:	764080e7          	jalr	1892(ra) # 800059fe <iunlockput>
  iput(ip);
    800082a2:	fe843503          	ld	a0,-24(s0)
    800082a6:	ffffd097          	auipc	ra,0xffffd
    800082aa:	688080e7          	jalr	1672(ra) # 8000592e <iput>

  end_op();
    800082ae:	ffffe097          	auipc	ra,0xffffe
    800082b2:	620080e7          	jalr	1568(ra) # 800068ce <end_op>

  return 0;
    800082b6:	4781                	li	a5,0
    800082b8:	a891                	j	8000830c <sys_link+0x1ba>
    goto bad;
    800082ba:	0001                	nop

bad:
  ilock(ip);
    800082bc:	fe843503          	ld	a0,-24(s0)
    800082c0:	ffffd097          	auipc	ra,0xffffd
    800082c4:	4e0080e7          	jalr	1248(ra) # 800057a0 <ilock>
  ip->nlink--;
    800082c8:	fe843783          	ld	a5,-24(s0)
    800082cc:	04a79783          	lh	a5,74(a5)
    800082d0:	17c2                	slli	a5,a5,0x30
    800082d2:	93c1                	srli	a5,a5,0x30
    800082d4:	37fd                	addiw	a5,a5,-1
    800082d6:	17c2                	slli	a5,a5,0x30
    800082d8:	93c1                	srli	a5,a5,0x30
    800082da:	0107971b          	slliw	a4,a5,0x10
    800082de:	4107571b          	sraiw	a4,a4,0x10
    800082e2:	fe843783          	ld	a5,-24(s0)
    800082e6:	04e79523          	sh	a4,74(a5)
  iupdate(ip);
    800082ea:	fe843503          	ld	a0,-24(s0)
    800082ee:	ffffd097          	auipc	ra,0xffffd
    800082f2:	262080e7          	jalr	610(ra) # 80005550 <iupdate>
  iunlockput(ip);
    800082f6:	fe843503          	ld	a0,-24(s0)
    800082fa:	ffffd097          	auipc	ra,0xffffd
    800082fe:	704080e7          	jalr	1796(ra) # 800059fe <iunlockput>
  end_op();
    80008302:	ffffe097          	auipc	ra,0xffffe
    80008306:	5cc080e7          	jalr	1484(ra) # 800068ce <end_op>
  return -1;
    8000830a:	57fd                	li	a5,-1
}
    8000830c:	853e                	mv	a0,a5
    8000830e:	70b2                	ld	ra,296(sp)
    80008310:	7412                	ld	s0,288(sp)
    80008312:	6155                	addi	sp,sp,304
    80008314:	8082                	ret

0000000080008316 <isdirempty>:

// Is the directory dp empty except for "." and ".." ?
static int
isdirempty(struct inode *dp)
{
    80008316:	7139                	addi	sp,sp,-64
    80008318:	fc06                	sd	ra,56(sp)
    8000831a:	f822                	sd	s0,48(sp)
    8000831c:	0080                	addi	s0,sp,64
    8000831e:	fca43423          	sd	a0,-56(s0)
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80008322:	02000793          	li	a5,32
    80008326:	fef42623          	sw	a5,-20(s0)
    8000832a:	a0b1                	j	80008376 <isdirempty+0x60>
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    8000832c:	fd840793          	addi	a5,s0,-40
    80008330:	fec42683          	lw	a3,-20(s0)
    80008334:	4741                	li	a4,16
    80008336:	863e                	mv	a2,a5
    80008338:	4581                	li	a1,0
    8000833a:	fc843503          	ld	a0,-56(s0)
    8000833e:	ffffe097          	auipc	ra,0xffffe
    80008342:	9f8080e7          	jalr	-1544(ra) # 80005d36 <readi>
    80008346:	87aa                	mv	a5,a0
    80008348:	873e                	mv	a4,a5
    8000834a:	47c1                	li	a5,16
    8000834c:	00f70a63          	beq	a4,a5,80008360 <isdirempty+0x4a>
      panic("isdirempty: readi");
    80008350:	00004517          	auipc	a0,0x4
    80008354:	2d050513          	addi	a0,a0,720 # 8000c620 <etext+0x620>
    80008358:	ffff9097          	auipc	ra,0xffff9
    8000835c:	8fa080e7          	jalr	-1798(ra) # 80000c52 <panic>
    if(de.inum != 0)
    80008360:	fd845783          	lhu	a5,-40(s0)
    80008364:	c399                	beqz	a5,8000836a <isdirempty+0x54>
      return 0;
    80008366:	4781                	li	a5,0
    80008368:	a839                	j	80008386 <isdirempty+0x70>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    8000836a:	fec42783          	lw	a5,-20(s0)
    8000836e:	27c1                	addiw	a5,a5,16
    80008370:	2781                	sext.w	a5,a5
    80008372:	fef42623          	sw	a5,-20(s0)
    80008376:	fc843783          	ld	a5,-56(s0)
    8000837a:	47f8                	lw	a4,76(a5)
    8000837c:	fec42783          	lw	a5,-20(s0)
    80008380:	fae7e6e3          	bltu	a5,a4,8000832c <isdirempty+0x16>
  }
  return 1;
    80008384:	4785                	li	a5,1
}
    80008386:	853e                	mv	a0,a5
    80008388:	70e2                	ld	ra,56(sp)
    8000838a:	7442                	ld	s0,48(sp)
    8000838c:	6121                	addi	sp,sp,64
    8000838e:	8082                	ret

0000000080008390 <sys_unlink>:

uint64
sys_unlink(void)
{
    80008390:	7155                	addi	sp,sp,-208
    80008392:	e586                	sd	ra,200(sp)
    80008394:	e1a2                	sd	s0,192(sp)
    80008396:	0980                	addi	s0,sp,208
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], path[MAXPATH];
  uint off;

  if(argstr(0, path, MAXPATH) < 0)
    80008398:	f4040793          	addi	a5,s0,-192
    8000839c:	08000613          	li	a2,128
    800083a0:	85be                	mv	a1,a5
    800083a2:	4501                	li	a0,0
    800083a4:	ffffc097          	auipc	ra,0xffffc
    800083a8:	47a080e7          	jalr	1146(ra) # 8000481e <argstr>
    800083ac:	87aa                	mv	a5,a0
    800083ae:	0007d463          	bgez	a5,800083b6 <sys_unlink+0x26>
    return -1;
    800083b2:	57fd                	li	a5,-1
    800083b4:	a2ed                	j	8000859e <sys_unlink+0x20e>

  begin_op();
    800083b6:	ffffe097          	auipc	ra,0xffffe
    800083ba:	456080e7          	jalr	1110(ra) # 8000680c <begin_op>
  if((dp = nameiparent(path, name)) == 0){
    800083be:	fc040713          	addi	a4,s0,-64
    800083c2:	f4040793          	addi	a5,s0,-192
    800083c6:	85ba                	mv	a1,a4
    800083c8:	853e                	mv	a0,a5
    800083ca:	ffffe097          	auipc	ra,0xffffe
    800083ce:	10a080e7          	jalr	266(ra) # 800064d4 <nameiparent>
    800083d2:	fea43423          	sd	a0,-24(s0)
    800083d6:	fe843783          	ld	a5,-24(s0)
    800083da:	e799                	bnez	a5,800083e8 <sys_unlink+0x58>
    end_op();
    800083dc:	ffffe097          	auipc	ra,0xffffe
    800083e0:	4f2080e7          	jalr	1266(ra) # 800068ce <end_op>
    return -1;
    800083e4:	57fd                	li	a5,-1
    800083e6:	aa65                	j	8000859e <sys_unlink+0x20e>
  }

  ilock(dp);
    800083e8:	fe843503          	ld	a0,-24(s0)
    800083ec:	ffffd097          	auipc	ra,0xffffd
    800083f0:	3b4080e7          	jalr	948(ra) # 800057a0 <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    800083f4:	fc040793          	addi	a5,s0,-64
    800083f8:	00004597          	auipc	a1,0x4
    800083fc:	24058593          	addi	a1,a1,576 # 8000c638 <etext+0x638>
    80008400:	853e                	mv	a0,a5
    80008402:	ffffe097          	auipc	ra,0xffffe
    80008406:	c72080e7          	jalr	-910(ra) # 80006074 <namecmp>
    8000840a:	87aa                	mv	a5,a0
    8000840c:	16078b63          	beqz	a5,80008582 <sys_unlink+0x1f2>
    80008410:	fc040793          	addi	a5,s0,-64
    80008414:	00004597          	auipc	a1,0x4
    80008418:	22c58593          	addi	a1,a1,556 # 8000c640 <etext+0x640>
    8000841c:	853e                	mv	a0,a5
    8000841e:	ffffe097          	auipc	ra,0xffffe
    80008422:	c56080e7          	jalr	-938(ra) # 80006074 <namecmp>
    80008426:	87aa                	mv	a5,a0
    80008428:	14078d63          	beqz	a5,80008582 <sys_unlink+0x1f2>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
    8000842c:	f3c40713          	addi	a4,s0,-196
    80008430:	fc040793          	addi	a5,s0,-64
    80008434:	863a                	mv	a2,a4
    80008436:	85be                	mv	a1,a5
    80008438:	fe843503          	ld	a0,-24(s0)
    8000843c:	ffffe097          	auipc	ra,0xffffe
    80008440:	c66080e7          	jalr	-922(ra) # 800060a2 <dirlookup>
    80008444:	fea43023          	sd	a0,-32(s0)
    80008448:	fe043783          	ld	a5,-32(s0)
    8000844c:	12078d63          	beqz	a5,80008586 <sys_unlink+0x1f6>
    goto bad;
  ilock(ip);
    80008450:	fe043503          	ld	a0,-32(s0)
    80008454:	ffffd097          	auipc	ra,0xffffd
    80008458:	34c080e7          	jalr	844(ra) # 800057a0 <ilock>

  if(ip->nlink < 1)
    8000845c:	fe043783          	ld	a5,-32(s0)
    80008460:	04a79783          	lh	a5,74(a5)
    80008464:	2781                	sext.w	a5,a5
    80008466:	00f04a63          	bgtz	a5,8000847a <sys_unlink+0xea>
    panic("unlink: nlink < 1");
    8000846a:	00004517          	auipc	a0,0x4
    8000846e:	1de50513          	addi	a0,a0,478 # 8000c648 <etext+0x648>
    80008472:	ffff8097          	auipc	ra,0xffff8
    80008476:	7e0080e7          	jalr	2016(ra) # 80000c52 <panic>
  if(ip->type == T_DIR && !isdirempty(ip)){
    8000847a:	fe043783          	ld	a5,-32(s0)
    8000847e:	04479783          	lh	a5,68(a5)
    80008482:	0007871b          	sext.w	a4,a5
    80008486:	4785                	li	a5,1
    80008488:	02f71163          	bne	a4,a5,800084aa <sys_unlink+0x11a>
    8000848c:	fe043503          	ld	a0,-32(s0)
    80008490:	00000097          	auipc	ra,0x0
    80008494:	e86080e7          	jalr	-378(ra) # 80008316 <isdirempty>
    80008498:	87aa                	mv	a5,a0
    8000849a:	eb81                	bnez	a5,800084aa <sys_unlink+0x11a>
    iunlockput(ip);
    8000849c:	fe043503          	ld	a0,-32(s0)
    800084a0:	ffffd097          	auipc	ra,0xffffd
    800084a4:	55e080e7          	jalr	1374(ra) # 800059fe <iunlockput>
    goto bad;
    800084a8:	a0c5                	j	80008588 <sys_unlink+0x1f8>
  }

  memset(&de, 0, sizeof(de));
    800084aa:	fd040793          	addi	a5,s0,-48
    800084ae:	4641                	li	a2,16
    800084b0:	4581                	li	a1,0
    800084b2:	853e                	mv	a0,a5
    800084b4:	ffff9097          	auipc	ra,0xffff9
    800084b8:	fa0080e7          	jalr	-96(ra) # 80001454 <memset>
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    800084bc:	fd040793          	addi	a5,s0,-48
    800084c0:	f3c42683          	lw	a3,-196(s0)
    800084c4:	4741                	li	a4,16
    800084c6:	863e                	mv	a2,a5
    800084c8:	4581                	li	a1,0
    800084ca:	fe843503          	ld	a0,-24(s0)
    800084ce:	ffffe097          	auipc	ra,0xffffe
    800084d2:	9f2080e7          	jalr	-1550(ra) # 80005ec0 <writei>
    800084d6:	87aa                	mv	a5,a0
    800084d8:	873e                	mv	a4,a5
    800084da:	47c1                	li	a5,16
    800084dc:	00f70a63          	beq	a4,a5,800084f0 <sys_unlink+0x160>
    panic("unlink: writei");
    800084e0:	00004517          	auipc	a0,0x4
    800084e4:	18050513          	addi	a0,a0,384 # 8000c660 <etext+0x660>
    800084e8:	ffff8097          	auipc	ra,0xffff8
    800084ec:	76a080e7          	jalr	1898(ra) # 80000c52 <panic>
  if(ip->type == T_DIR){
    800084f0:	fe043783          	ld	a5,-32(s0)
    800084f4:	04479783          	lh	a5,68(a5)
    800084f8:	0007871b          	sext.w	a4,a5
    800084fc:	4785                	li	a5,1
    800084fe:	02f71963          	bne	a4,a5,80008530 <sys_unlink+0x1a0>
    dp->nlink--;
    80008502:	fe843783          	ld	a5,-24(s0)
    80008506:	04a79783          	lh	a5,74(a5)
    8000850a:	17c2                	slli	a5,a5,0x30
    8000850c:	93c1                	srli	a5,a5,0x30
    8000850e:	37fd                	addiw	a5,a5,-1
    80008510:	17c2                	slli	a5,a5,0x30
    80008512:	93c1                	srli	a5,a5,0x30
    80008514:	0107971b          	slliw	a4,a5,0x10
    80008518:	4107571b          	sraiw	a4,a4,0x10
    8000851c:	fe843783          	ld	a5,-24(s0)
    80008520:	04e79523          	sh	a4,74(a5)
    iupdate(dp);
    80008524:	fe843503          	ld	a0,-24(s0)
    80008528:	ffffd097          	auipc	ra,0xffffd
    8000852c:	028080e7          	jalr	40(ra) # 80005550 <iupdate>
  }
  iunlockput(dp);
    80008530:	fe843503          	ld	a0,-24(s0)
    80008534:	ffffd097          	auipc	ra,0xffffd
    80008538:	4ca080e7          	jalr	1226(ra) # 800059fe <iunlockput>

  ip->nlink--;
    8000853c:	fe043783          	ld	a5,-32(s0)
    80008540:	04a79783          	lh	a5,74(a5)
    80008544:	17c2                	slli	a5,a5,0x30
    80008546:	93c1                	srli	a5,a5,0x30
    80008548:	37fd                	addiw	a5,a5,-1
    8000854a:	17c2                	slli	a5,a5,0x30
    8000854c:	93c1                	srli	a5,a5,0x30
    8000854e:	0107971b          	slliw	a4,a5,0x10
    80008552:	4107571b          	sraiw	a4,a4,0x10
    80008556:	fe043783          	ld	a5,-32(s0)
    8000855a:	04e79523          	sh	a4,74(a5)
  iupdate(ip);
    8000855e:	fe043503          	ld	a0,-32(s0)
    80008562:	ffffd097          	auipc	ra,0xffffd
    80008566:	fee080e7          	jalr	-18(ra) # 80005550 <iupdate>
  iunlockput(ip);
    8000856a:	fe043503          	ld	a0,-32(s0)
    8000856e:	ffffd097          	auipc	ra,0xffffd
    80008572:	490080e7          	jalr	1168(ra) # 800059fe <iunlockput>

  end_op();
    80008576:	ffffe097          	auipc	ra,0xffffe
    8000857a:	358080e7          	jalr	856(ra) # 800068ce <end_op>

  return 0;
    8000857e:	4781                	li	a5,0
    80008580:	a839                	j	8000859e <sys_unlink+0x20e>
    goto bad;
    80008582:	0001                	nop
    80008584:	a011                	j	80008588 <sys_unlink+0x1f8>
    goto bad;
    80008586:	0001                	nop

bad:
  iunlockput(dp);
    80008588:	fe843503          	ld	a0,-24(s0)
    8000858c:	ffffd097          	auipc	ra,0xffffd
    80008590:	472080e7          	jalr	1138(ra) # 800059fe <iunlockput>
  end_op();
    80008594:	ffffe097          	auipc	ra,0xffffe
    80008598:	33a080e7          	jalr	826(ra) # 800068ce <end_op>
  return -1;
    8000859c:	57fd                	li	a5,-1
}
    8000859e:	853e                	mv	a0,a5
    800085a0:	60ae                	ld	ra,200(sp)
    800085a2:	640e                	ld	s0,192(sp)
    800085a4:	6169                	addi	sp,sp,208
    800085a6:	8082                	ret

00000000800085a8 <create>:

static struct inode*
create(char *path, short type, short major, short minor)
{
    800085a8:	7139                	addi	sp,sp,-64
    800085aa:	fc06                	sd	ra,56(sp)
    800085ac:	f822                	sd	s0,48(sp)
    800085ae:	0080                	addi	s0,sp,64
    800085b0:	fca43423          	sd	a0,-56(s0)
    800085b4:	87ae                	mv	a5,a1
    800085b6:	8736                	mv	a4,a3
    800085b8:	fcf41323          	sh	a5,-58(s0)
    800085bc:	87b2                	mv	a5,a2
    800085be:	fcf41223          	sh	a5,-60(s0)
    800085c2:	87ba                	mv	a5,a4
    800085c4:	fcf41123          	sh	a5,-62(s0)
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    800085c8:	fd040793          	addi	a5,s0,-48
    800085cc:	85be                	mv	a1,a5
    800085ce:	fc843503          	ld	a0,-56(s0)
    800085d2:	ffffe097          	auipc	ra,0xffffe
    800085d6:	f02080e7          	jalr	-254(ra) # 800064d4 <nameiparent>
    800085da:	fea43423          	sd	a0,-24(s0)
    800085de:	fe843783          	ld	a5,-24(s0)
    800085e2:	e399                	bnez	a5,800085e8 <create+0x40>
    return 0;
    800085e4:	4781                	li	a5,0
    800085e6:	a2d9                	j	800087ac <create+0x204>

  ilock(dp);
    800085e8:	fe843503          	ld	a0,-24(s0)
    800085ec:	ffffd097          	auipc	ra,0xffffd
    800085f0:	1b4080e7          	jalr	436(ra) # 800057a0 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
    800085f4:	fd040793          	addi	a5,s0,-48
    800085f8:	4601                	li	a2,0
    800085fa:	85be                	mv	a1,a5
    800085fc:	fe843503          	ld	a0,-24(s0)
    80008600:	ffffe097          	auipc	ra,0xffffe
    80008604:	aa2080e7          	jalr	-1374(ra) # 800060a2 <dirlookup>
    80008608:	fea43023          	sd	a0,-32(s0)
    8000860c:	fe043783          	ld	a5,-32(s0)
    80008610:	c3ad                	beqz	a5,80008672 <create+0xca>
    iunlockput(dp);
    80008612:	fe843503          	ld	a0,-24(s0)
    80008616:	ffffd097          	auipc	ra,0xffffd
    8000861a:	3e8080e7          	jalr	1000(ra) # 800059fe <iunlockput>
    ilock(ip);
    8000861e:	fe043503          	ld	a0,-32(s0)
    80008622:	ffffd097          	auipc	ra,0xffffd
    80008626:	17e080e7          	jalr	382(ra) # 800057a0 <ilock>
    if(type == T_FILE && (ip->type == T_FILE || ip->type == T_DEVICE))
    8000862a:	fc641783          	lh	a5,-58(s0)
    8000862e:	0007871b          	sext.w	a4,a5
    80008632:	4789                	li	a5,2
    80008634:	02f71763          	bne	a4,a5,80008662 <create+0xba>
    80008638:	fe043783          	ld	a5,-32(s0)
    8000863c:	04479783          	lh	a5,68(a5)
    80008640:	0007871b          	sext.w	a4,a5
    80008644:	4789                	li	a5,2
    80008646:	00f70b63          	beq	a4,a5,8000865c <create+0xb4>
    8000864a:	fe043783          	ld	a5,-32(s0)
    8000864e:	04479783          	lh	a5,68(a5)
    80008652:	0007871b          	sext.w	a4,a5
    80008656:	478d                	li	a5,3
    80008658:	00f71563          	bne	a4,a5,80008662 <create+0xba>
      return ip;
    8000865c:	fe043783          	ld	a5,-32(s0)
    80008660:	a2b1                	j	800087ac <create+0x204>
    iunlockput(ip);
    80008662:	fe043503          	ld	a0,-32(s0)
    80008666:	ffffd097          	auipc	ra,0xffffd
    8000866a:	398080e7          	jalr	920(ra) # 800059fe <iunlockput>
    return 0;
    8000866e:	4781                	li	a5,0
    80008670:	aa35                	j	800087ac <create+0x204>
  }

  if((ip = ialloc(dp->dev, type)) == 0)
    80008672:	fe843783          	ld	a5,-24(s0)
    80008676:	439c                	lw	a5,0(a5)
    80008678:	fc641703          	lh	a4,-58(s0)
    8000867c:	85ba                	mv	a1,a4
    8000867e:	853e                	mv	a0,a5
    80008680:	ffffd097          	auipc	ra,0xffffd
    80008684:	dd4080e7          	jalr	-556(ra) # 80005454 <ialloc>
    80008688:	fea43023          	sd	a0,-32(s0)
    8000868c:	fe043783          	ld	a5,-32(s0)
    80008690:	eb89                	bnez	a5,800086a2 <create+0xfa>
    panic("create: ialloc");
    80008692:	00004517          	auipc	a0,0x4
    80008696:	fde50513          	addi	a0,a0,-34 # 8000c670 <etext+0x670>
    8000869a:	ffff8097          	auipc	ra,0xffff8
    8000869e:	5b8080e7          	jalr	1464(ra) # 80000c52 <panic>

  ilock(ip);
    800086a2:	fe043503          	ld	a0,-32(s0)
    800086a6:	ffffd097          	auipc	ra,0xffffd
    800086aa:	0fa080e7          	jalr	250(ra) # 800057a0 <ilock>
  ip->major = major;
    800086ae:	fe043783          	ld	a5,-32(s0)
    800086b2:	fc445703          	lhu	a4,-60(s0)
    800086b6:	04e79323          	sh	a4,70(a5)
  ip->minor = minor;
    800086ba:	fe043783          	ld	a5,-32(s0)
    800086be:	fc245703          	lhu	a4,-62(s0)
    800086c2:	04e79423          	sh	a4,72(a5)
  ip->nlink = 1;
    800086c6:	fe043783          	ld	a5,-32(s0)
    800086ca:	4705                	li	a4,1
    800086cc:	04e79523          	sh	a4,74(a5)
  iupdate(ip);
    800086d0:	fe043503          	ld	a0,-32(s0)
    800086d4:	ffffd097          	auipc	ra,0xffffd
    800086d8:	e7c080e7          	jalr	-388(ra) # 80005550 <iupdate>

  if(type == T_DIR){  // Create . and .. entries.
    800086dc:	fc641783          	lh	a5,-58(s0)
    800086e0:	0007871b          	sext.w	a4,a5
    800086e4:	4785                	li	a5,1
    800086e6:	08f71363          	bne	a4,a5,8000876c <create+0x1c4>
    dp->nlink++;  // for ".."
    800086ea:	fe843783          	ld	a5,-24(s0)
    800086ee:	04a79783          	lh	a5,74(a5)
    800086f2:	17c2                	slli	a5,a5,0x30
    800086f4:	93c1                	srli	a5,a5,0x30
    800086f6:	2785                	addiw	a5,a5,1
    800086f8:	17c2                	slli	a5,a5,0x30
    800086fa:	93c1                	srli	a5,a5,0x30
    800086fc:	0107971b          	slliw	a4,a5,0x10
    80008700:	4107571b          	sraiw	a4,a4,0x10
    80008704:	fe843783          	ld	a5,-24(s0)
    80008708:	04e79523          	sh	a4,74(a5)
    iupdate(dp);
    8000870c:	fe843503          	ld	a0,-24(s0)
    80008710:	ffffd097          	auipc	ra,0xffffd
    80008714:	e40080e7          	jalr	-448(ra) # 80005550 <iupdate>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
    80008718:	fe043783          	ld	a5,-32(s0)
    8000871c:	43dc                	lw	a5,4(a5)
    8000871e:	863e                	mv	a2,a5
    80008720:	00004597          	auipc	a1,0x4
    80008724:	f1858593          	addi	a1,a1,-232 # 8000c638 <etext+0x638>
    80008728:	fe043503          	ld	a0,-32(s0)
    8000872c:	ffffe097          	auipc	ra,0xffffe
    80008730:	a5e080e7          	jalr	-1442(ra) # 8000618a <dirlink>
    80008734:	87aa                	mv	a5,a0
    80008736:	0207c363          	bltz	a5,8000875c <create+0x1b4>
    8000873a:	fe843783          	ld	a5,-24(s0)
    8000873e:	43dc                	lw	a5,4(a5)
    80008740:	863e                	mv	a2,a5
    80008742:	00004597          	auipc	a1,0x4
    80008746:	efe58593          	addi	a1,a1,-258 # 8000c640 <etext+0x640>
    8000874a:	fe043503          	ld	a0,-32(s0)
    8000874e:	ffffe097          	auipc	ra,0xffffe
    80008752:	a3c080e7          	jalr	-1476(ra) # 8000618a <dirlink>
    80008756:	87aa                	mv	a5,a0
    80008758:	0007da63          	bgez	a5,8000876c <create+0x1c4>
      panic("create dots");
    8000875c:	00004517          	auipc	a0,0x4
    80008760:	f2450513          	addi	a0,a0,-220 # 8000c680 <etext+0x680>
    80008764:	ffff8097          	auipc	ra,0xffff8
    80008768:	4ee080e7          	jalr	1262(ra) # 80000c52 <panic>
  }

  if(dirlink(dp, name, ip->inum) < 0)
    8000876c:	fe043783          	ld	a5,-32(s0)
    80008770:	43d8                	lw	a4,4(a5)
    80008772:	fd040793          	addi	a5,s0,-48
    80008776:	863a                	mv	a2,a4
    80008778:	85be                	mv	a1,a5
    8000877a:	fe843503          	ld	a0,-24(s0)
    8000877e:	ffffe097          	auipc	ra,0xffffe
    80008782:	a0c080e7          	jalr	-1524(ra) # 8000618a <dirlink>
    80008786:	87aa                	mv	a5,a0
    80008788:	0007da63          	bgez	a5,8000879c <create+0x1f4>
    panic("create: dirlink");
    8000878c:	00004517          	auipc	a0,0x4
    80008790:	f0450513          	addi	a0,a0,-252 # 8000c690 <etext+0x690>
    80008794:	ffff8097          	auipc	ra,0xffff8
    80008798:	4be080e7          	jalr	1214(ra) # 80000c52 <panic>

  iunlockput(dp);
    8000879c:	fe843503          	ld	a0,-24(s0)
    800087a0:	ffffd097          	auipc	ra,0xffffd
    800087a4:	25e080e7          	jalr	606(ra) # 800059fe <iunlockput>

  return ip;
    800087a8:	fe043783          	ld	a5,-32(s0)
}
    800087ac:	853e                	mv	a0,a5
    800087ae:	70e2                	ld	ra,56(sp)
    800087b0:	7442                	ld	s0,48(sp)
    800087b2:	6121                	addi	sp,sp,64
    800087b4:	8082                	ret

00000000800087b6 <sys_open>:

uint64
sys_open(void)
{
    800087b6:	7131                	addi	sp,sp,-192
    800087b8:	fd06                	sd	ra,184(sp)
    800087ba:	f922                	sd	s0,176(sp)
    800087bc:	0180                	addi	s0,sp,192
  int fd, omode;
  struct file *f;
  struct inode *ip;
  int n;

  if((n = argstr(0, path, MAXPATH)) < 0 || argint(1, &omode) < 0)
    800087be:	f5040793          	addi	a5,s0,-176
    800087c2:	08000613          	li	a2,128
    800087c6:	85be                	mv	a1,a5
    800087c8:	4501                	li	a0,0
    800087ca:	ffffc097          	auipc	ra,0xffffc
    800087ce:	054080e7          	jalr	84(ra) # 8000481e <argstr>
    800087d2:	87aa                	mv	a5,a0
    800087d4:	fef42223          	sw	a5,-28(s0)
    800087d8:	fe442783          	lw	a5,-28(s0)
    800087dc:	2781                	sext.w	a5,a5
    800087de:	0007cd63          	bltz	a5,800087f8 <sys_open+0x42>
    800087e2:	f4c40793          	addi	a5,s0,-180
    800087e6:	85be                	mv	a1,a5
    800087e8:	4505                	li	a0,1
    800087ea:	ffffc097          	auipc	ra,0xffffc
    800087ee:	fc8080e7          	jalr	-56(ra) # 800047b2 <argint>
    800087f2:	87aa                	mv	a5,a0
    800087f4:	0007d463          	bgez	a5,800087fc <sys_open+0x46>
    return -1;
    800087f8:	57fd                	li	a5,-1
    800087fa:	a429                	j	80008a04 <sys_open+0x24e>

  begin_op();
    800087fc:	ffffe097          	auipc	ra,0xffffe
    80008800:	010080e7          	jalr	16(ra) # 8000680c <begin_op>

  if(omode & O_CREATE){
    80008804:	f4c42783          	lw	a5,-180(s0)
    80008808:	2007f793          	andi	a5,a5,512
    8000880c:	2781                	sext.w	a5,a5
    8000880e:	c795                	beqz	a5,8000883a <sys_open+0x84>
    ip = create(path, T_FILE, 0, 0);
    80008810:	f5040793          	addi	a5,s0,-176
    80008814:	4681                	li	a3,0
    80008816:	4601                	li	a2,0
    80008818:	4589                	li	a1,2
    8000881a:	853e                	mv	a0,a5
    8000881c:	00000097          	auipc	ra,0x0
    80008820:	d8c080e7          	jalr	-628(ra) # 800085a8 <create>
    80008824:	fea43423          	sd	a0,-24(s0)
    if(ip == 0){
    80008828:	fe843783          	ld	a5,-24(s0)
    8000882c:	e7bd                	bnez	a5,8000889a <sys_open+0xe4>
      end_op();
    8000882e:	ffffe097          	auipc	ra,0xffffe
    80008832:	0a0080e7          	jalr	160(ra) # 800068ce <end_op>
      return -1;
    80008836:	57fd                	li	a5,-1
    80008838:	a2f1                	j	80008a04 <sys_open+0x24e>
    }
  } else {
    if((ip = namei(path)) == 0){
    8000883a:	f5040793          	addi	a5,s0,-176
    8000883e:	853e                	mv	a0,a5
    80008840:	ffffe097          	auipc	ra,0xffffe
    80008844:	c68080e7          	jalr	-920(ra) # 800064a8 <namei>
    80008848:	fea43423          	sd	a0,-24(s0)
    8000884c:	fe843783          	ld	a5,-24(s0)
    80008850:	e799                	bnez	a5,8000885e <sys_open+0xa8>
      end_op();
    80008852:	ffffe097          	auipc	ra,0xffffe
    80008856:	07c080e7          	jalr	124(ra) # 800068ce <end_op>
      return -1;
    8000885a:	57fd                	li	a5,-1
    8000885c:	a265                	j	80008a04 <sys_open+0x24e>
    }
    ilock(ip);
    8000885e:	fe843503          	ld	a0,-24(s0)
    80008862:	ffffd097          	auipc	ra,0xffffd
    80008866:	f3e080e7          	jalr	-194(ra) # 800057a0 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
    8000886a:	fe843783          	ld	a5,-24(s0)
    8000886e:	04479783          	lh	a5,68(a5)
    80008872:	0007871b          	sext.w	a4,a5
    80008876:	4785                	li	a5,1
    80008878:	02f71163          	bne	a4,a5,8000889a <sys_open+0xe4>
    8000887c:	f4c42783          	lw	a5,-180(s0)
    80008880:	cf89                	beqz	a5,8000889a <sys_open+0xe4>
      iunlockput(ip);
    80008882:	fe843503          	ld	a0,-24(s0)
    80008886:	ffffd097          	auipc	ra,0xffffd
    8000888a:	178080e7          	jalr	376(ra) # 800059fe <iunlockput>
      end_op();
    8000888e:	ffffe097          	auipc	ra,0xffffe
    80008892:	040080e7          	jalr	64(ra) # 800068ce <end_op>
      return -1;
    80008896:	57fd                	li	a5,-1
    80008898:	a2b5                	j	80008a04 <sys_open+0x24e>
    }
  }

  if(ip->type == T_DEVICE && (ip->major < 0 || ip->major >= NDEV)){
    8000889a:	fe843783          	ld	a5,-24(s0)
    8000889e:	04479783          	lh	a5,68(a5)
    800088a2:	0007871b          	sext.w	a4,a5
    800088a6:	478d                	li	a5,3
    800088a8:	02f71e63          	bne	a4,a5,800088e4 <sys_open+0x12e>
    800088ac:	fe843783          	ld	a5,-24(s0)
    800088b0:	04679783          	lh	a5,70(a5)
    800088b4:	2781                	sext.w	a5,a5
    800088b6:	0007cb63          	bltz	a5,800088cc <sys_open+0x116>
    800088ba:	fe843783          	ld	a5,-24(s0)
    800088be:	04679783          	lh	a5,70(a5)
    800088c2:	0007871b          	sext.w	a4,a5
    800088c6:	47a5                	li	a5,9
    800088c8:	00e7de63          	bge	a5,a4,800088e4 <sys_open+0x12e>
    iunlockput(ip);
    800088cc:	fe843503          	ld	a0,-24(s0)
    800088d0:	ffffd097          	auipc	ra,0xffffd
    800088d4:	12e080e7          	jalr	302(ra) # 800059fe <iunlockput>
    end_op();
    800088d8:	ffffe097          	auipc	ra,0xffffe
    800088dc:	ff6080e7          	jalr	-10(ra) # 800068ce <end_op>
    return -1;
    800088e0:	57fd                	li	a5,-1
    800088e2:	a20d                	j	80008a04 <sys_open+0x24e>
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    800088e4:	ffffe097          	auipc	ra,0xffffe
    800088e8:	4d8080e7          	jalr	1240(ra) # 80006dbc <filealloc>
    800088ec:	fca43c23          	sd	a0,-40(s0)
    800088f0:	fd843783          	ld	a5,-40(s0)
    800088f4:	cf99                	beqz	a5,80008912 <sys_open+0x15c>
    800088f6:	fd843503          	ld	a0,-40(s0)
    800088fa:	fffff097          	auipc	ra,0xfffff
    800088fe:	5e2080e7          	jalr	1506(ra) # 80007edc <fdalloc>
    80008902:	87aa                	mv	a5,a0
    80008904:	fcf42a23          	sw	a5,-44(s0)
    80008908:	fd442783          	lw	a5,-44(s0)
    8000890c:	2781                	sext.w	a5,a5
    8000890e:	0207d763          	bgez	a5,8000893c <sys_open+0x186>
    if(f)
    80008912:	fd843783          	ld	a5,-40(s0)
    80008916:	c799                	beqz	a5,80008924 <sys_open+0x16e>
      fileclose(f);
    80008918:	fd843503          	ld	a0,-40(s0)
    8000891c:	ffffe097          	auipc	ra,0xffffe
    80008920:	58a080e7          	jalr	1418(ra) # 80006ea6 <fileclose>
    iunlockput(ip);
    80008924:	fe843503          	ld	a0,-24(s0)
    80008928:	ffffd097          	auipc	ra,0xffffd
    8000892c:	0d6080e7          	jalr	214(ra) # 800059fe <iunlockput>
    end_op();
    80008930:	ffffe097          	auipc	ra,0xffffe
    80008934:	f9e080e7          	jalr	-98(ra) # 800068ce <end_op>
    return -1;
    80008938:	57fd                	li	a5,-1
    8000893a:	a0e9                	j	80008a04 <sys_open+0x24e>
  }

  if(ip->type == T_DEVICE){
    8000893c:	fe843783          	ld	a5,-24(s0)
    80008940:	04479783          	lh	a5,68(a5)
    80008944:	0007871b          	sext.w	a4,a5
    80008948:	478d                	li	a5,3
    8000894a:	00f71f63          	bne	a4,a5,80008968 <sys_open+0x1b2>
    f->type = FD_DEVICE;
    8000894e:	fd843783          	ld	a5,-40(s0)
    80008952:	470d                	li	a4,3
    80008954:	c398                	sw	a4,0(a5)
    f->major = ip->major;
    80008956:	fe843783          	ld	a5,-24(s0)
    8000895a:	04679703          	lh	a4,70(a5)
    8000895e:	fd843783          	ld	a5,-40(s0)
    80008962:	02e79223          	sh	a4,36(a5)
    80008966:	a809                	j	80008978 <sys_open+0x1c2>
  } else {
    f->type = FD_INODE;
    80008968:	fd843783          	ld	a5,-40(s0)
    8000896c:	4709                	li	a4,2
    8000896e:	c398                	sw	a4,0(a5)
    f->off = 0;
    80008970:	fd843783          	ld	a5,-40(s0)
    80008974:	0207a023          	sw	zero,32(a5)
  }
  f->ip = ip;
    80008978:	fd843783          	ld	a5,-40(s0)
    8000897c:	fe843703          	ld	a4,-24(s0)
    80008980:	ef98                	sd	a4,24(a5)
  f->readable = !(omode & O_WRONLY);
    80008982:	f4c42783          	lw	a5,-180(s0)
    80008986:	8b85                	andi	a5,a5,1
    80008988:	2781                	sext.w	a5,a5
    8000898a:	0017b793          	seqz	a5,a5
    8000898e:	0ff7f793          	andi	a5,a5,255
    80008992:	873e                	mv	a4,a5
    80008994:	fd843783          	ld	a5,-40(s0)
    80008998:	00e78423          	sb	a4,8(a5)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    8000899c:	f4c42783          	lw	a5,-180(s0)
    800089a0:	8b85                	andi	a5,a5,1
    800089a2:	2781                	sext.w	a5,a5
    800089a4:	e791                	bnez	a5,800089b0 <sys_open+0x1fa>
    800089a6:	f4c42783          	lw	a5,-180(s0)
    800089aa:	8b89                	andi	a5,a5,2
    800089ac:	2781                	sext.w	a5,a5
    800089ae:	c399                	beqz	a5,800089b4 <sys_open+0x1fe>
    800089b0:	4785                	li	a5,1
    800089b2:	a011                	j	800089b6 <sys_open+0x200>
    800089b4:	4781                	li	a5,0
    800089b6:	0ff7f713          	andi	a4,a5,255
    800089ba:	fd843783          	ld	a5,-40(s0)
    800089be:	00e784a3          	sb	a4,9(a5)

  if((omode & O_TRUNC) && ip->type == T_FILE){
    800089c2:	f4c42783          	lw	a5,-180(s0)
    800089c6:	4007f793          	andi	a5,a5,1024
    800089ca:	2781                	sext.w	a5,a5
    800089cc:	c385                	beqz	a5,800089ec <sys_open+0x236>
    800089ce:	fe843783          	ld	a5,-24(s0)
    800089d2:	04479783          	lh	a5,68(a5)
    800089d6:	0007871b          	sext.w	a4,a5
    800089da:	4789                	li	a5,2
    800089dc:	00f71863          	bne	a4,a5,800089ec <sys_open+0x236>
    itrunc(ip);
    800089e0:	fe843503          	ld	a0,-24(s0)
    800089e4:	ffffd097          	auipc	ra,0xffffd
    800089e8:	1a4080e7          	jalr	420(ra) # 80005b88 <itrunc>
  }

  iunlock(ip);
    800089ec:	fe843503          	ld	a0,-24(s0)
    800089f0:	ffffd097          	auipc	ra,0xffffd
    800089f4:	ee4080e7          	jalr	-284(ra) # 800058d4 <iunlock>
  end_op();
    800089f8:	ffffe097          	auipc	ra,0xffffe
    800089fc:	ed6080e7          	jalr	-298(ra) # 800068ce <end_op>

  return fd;
    80008a00:	fd442783          	lw	a5,-44(s0)
}
    80008a04:	853e                	mv	a0,a5
    80008a06:	70ea                	ld	ra,184(sp)
    80008a08:	744a                	ld	s0,176(sp)
    80008a0a:	6129                	addi	sp,sp,192
    80008a0c:	8082                	ret

0000000080008a0e <sys_mkdir>:

uint64
sys_mkdir(void)
{
    80008a0e:	7135                	addi	sp,sp,-160
    80008a10:	ed06                	sd	ra,152(sp)
    80008a12:	e922                	sd	s0,144(sp)
    80008a14:	1100                	addi	s0,sp,160
  char path[MAXPATH];
  struct inode *ip;

  begin_op();
    80008a16:	ffffe097          	auipc	ra,0xffffe
    80008a1a:	df6080e7          	jalr	-522(ra) # 8000680c <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    80008a1e:	f6840793          	addi	a5,s0,-152
    80008a22:	08000613          	li	a2,128
    80008a26:	85be                	mv	a1,a5
    80008a28:	4501                	li	a0,0
    80008a2a:	ffffc097          	auipc	ra,0xffffc
    80008a2e:	df4080e7          	jalr	-524(ra) # 8000481e <argstr>
    80008a32:	87aa                	mv	a5,a0
    80008a34:	0207c163          	bltz	a5,80008a56 <sys_mkdir+0x48>
    80008a38:	f6840793          	addi	a5,s0,-152
    80008a3c:	4681                	li	a3,0
    80008a3e:	4601                	li	a2,0
    80008a40:	4585                	li	a1,1
    80008a42:	853e                	mv	a0,a5
    80008a44:	00000097          	auipc	ra,0x0
    80008a48:	b64080e7          	jalr	-1180(ra) # 800085a8 <create>
    80008a4c:	fea43423          	sd	a0,-24(s0)
    80008a50:	fe843783          	ld	a5,-24(s0)
    80008a54:	e799                	bnez	a5,80008a62 <sys_mkdir+0x54>
    end_op();
    80008a56:	ffffe097          	auipc	ra,0xffffe
    80008a5a:	e78080e7          	jalr	-392(ra) # 800068ce <end_op>
    return -1;
    80008a5e:	57fd                	li	a5,-1
    80008a60:	a821                	j	80008a78 <sys_mkdir+0x6a>
  }
  iunlockput(ip);
    80008a62:	fe843503          	ld	a0,-24(s0)
    80008a66:	ffffd097          	auipc	ra,0xffffd
    80008a6a:	f98080e7          	jalr	-104(ra) # 800059fe <iunlockput>
  end_op();
    80008a6e:	ffffe097          	auipc	ra,0xffffe
    80008a72:	e60080e7          	jalr	-416(ra) # 800068ce <end_op>
  return 0;
    80008a76:	4781                	li	a5,0
}
    80008a78:	853e                	mv	a0,a5
    80008a7a:	60ea                	ld	ra,152(sp)
    80008a7c:	644a                	ld	s0,144(sp)
    80008a7e:	610d                	addi	sp,sp,160
    80008a80:	8082                	ret

0000000080008a82 <sys_mknod>:

uint64
sys_mknod(void)
{
    80008a82:	7135                	addi	sp,sp,-160
    80008a84:	ed06                	sd	ra,152(sp)
    80008a86:	e922                	sd	s0,144(sp)
    80008a88:	1100                	addi	s0,sp,160
  struct inode *ip;
  char path[MAXPATH];
  int major, minor;

  begin_op();
    80008a8a:	ffffe097          	auipc	ra,0xffffe
    80008a8e:	d82080e7          	jalr	-638(ra) # 8000680c <begin_op>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80008a92:	f6840793          	addi	a5,s0,-152
    80008a96:	08000613          	li	a2,128
    80008a9a:	85be                	mv	a1,a5
    80008a9c:	4501                	li	a0,0
    80008a9e:	ffffc097          	auipc	ra,0xffffc
    80008aa2:	d80080e7          	jalr	-640(ra) # 8000481e <argstr>
    80008aa6:	87aa                	mv	a5,a0
    80008aa8:	0607c263          	bltz	a5,80008b0c <sys_mknod+0x8a>
     argint(1, &major) < 0 ||
    80008aac:	f6440793          	addi	a5,s0,-156
    80008ab0:	85be                	mv	a1,a5
    80008ab2:	4505                	li	a0,1
    80008ab4:	ffffc097          	auipc	ra,0xffffc
    80008ab8:	cfe080e7          	jalr	-770(ra) # 800047b2 <argint>
    80008abc:	87aa                	mv	a5,a0
  if((argstr(0, path, MAXPATH)) < 0 ||
    80008abe:	0407c763          	bltz	a5,80008b0c <sys_mknod+0x8a>
     argint(2, &minor) < 0 ||
    80008ac2:	f6040793          	addi	a5,s0,-160
    80008ac6:	85be                	mv	a1,a5
    80008ac8:	4509                	li	a0,2
    80008aca:	ffffc097          	auipc	ra,0xffffc
    80008ace:	ce8080e7          	jalr	-792(ra) # 800047b2 <argint>
    80008ad2:	87aa                	mv	a5,a0
     argint(1, &major) < 0 ||
    80008ad4:	0207cc63          	bltz	a5,80008b0c <sys_mknod+0x8a>
     (ip = create(path, T_DEVICE, major, minor)) == 0){
    80008ad8:	f6442783          	lw	a5,-156(s0)
    80008adc:	0107971b          	slliw	a4,a5,0x10
    80008ae0:	4107571b          	sraiw	a4,a4,0x10
    80008ae4:	f6042783          	lw	a5,-160(s0)
    80008ae8:	0107969b          	slliw	a3,a5,0x10
    80008aec:	4106d69b          	sraiw	a3,a3,0x10
    80008af0:	f6840793          	addi	a5,s0,-152
    80008af4:	863a                	mv	a2,a4
    80008af6:	458d                	li	a1,3
    80008af8:	853e                	mv	a0,a5
    80008afa:	00000097          	auipc	ra,0x0
    80008afe:	aae080e7          	jalr	-1362(ra) # 800085a8 <create>
    80008b02:	fea43423          	sd	a0,-24(s0)
     argint(2, &minor) < 0 ||
    80008b06:	fe843783          	ld	a5,-24(s0)
    80008b0a:	e799                	bnez	a5,80008b18 <sys_mknod+0x96>
    end_op();
    80008b0c:	ffffe097          	auipc	ra,0xffffe
    80008b10:	dc2080e7          	jalr	-574(ra) # 800068ce <end_op>
    return -1;
    80008b14:	57fd                	li	a5,-1
    80008b16:	a821                	j	80008b2e <sys_mknod+0xac>
  }
  iunlockput(ip);
    80008b18:	fe843503          	ld	a0,-24(s0)
    80008b1c:	ffffd097          	auipc	ra,0xffffd
    80008b20:	ee2080e7          	jalr	-286(ra) # 800059fe <iunlockput>
  end_op();
    80008b24:	ffffe097          	auipc	ra,0xffffe
    80008b28:	daa080e7          	jalr	-598(ra) # 800068ce <end_op>
  return 0;
    80008b2c:	4781                	li	a5,0
}
    80008b2e:	853e                	mv	a0,a5
    80008b30:	60ea                	ld	ra,152(sp)
    80008b32:	644a                	ld	s0,144(sp)
    80008b34:	610d                	addi	sp,sp,160
    80008b36:	8082                	ret

0000000080008b38 <sys_chdir>:

uint64
sys_chdir(void)
{
    80008b38:	7135                	addi	sp,sp,-160
    80008b3a:	ed06                	sd	ra,152(sp)
    80008b3c:	e922                	sd	s0,144(sp)
    80008b3e:	1100                	addi	s0,sp,160
  char path[MAXPATH];
  struct inode *ip;
  struct proc *p = myproc();
    80008b40:	ffffa097          	auipc	ra,0xffffa
    80008b44:	cb8080e7          	jalr	-840(ra) # 800027f8 <myproc>
    80008b48:	fea43423          	sd	a0,-24(s0)
  
  begin_op();
    80008b4c:	ffffe097          	auipc	ra,0xffffe
    80008b50:	cc0080e7          	jalr	-832(ra) # 8000680c <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = namei(path)) == 0){
    80008b54:	f6040793          	addi	a5,s0,-160
    80008b58:	08000613          	li	a2,128
    80008b5c:	85be                	mv	a1,a5
    80008b5e:	4501                	li	a0,0
    80008b60:	ffffc097          	auipc	ra,0xffffc
    80008b64:	cbe080e7          	jalr	-834(ra) # 8000481e <argstr>
    80008b68:	87aa                	mv	a5,a0
    80008b6a:	0007ce63          	bltz	a5,80008b86 <sys_chdir+0x4e>
    80008b6e:	f6040793          	addi	a5,s0,-160
    80008b72:	853e                	mv	a0,a5
    80008b74:	ffffe097          	auipc	ra,0xffffe
    80008b78:	934080e7          	jalr	-1740(ra) # 800064a8 <namei>
    80008b7c:	fea43023          	sd	a0,-32(s0)
    80008b80:	fe043783          	ld	a5,-32(s0)
    80008b84:	e799                	bnez	a5,80008b92 <sys_chdir+0x5a>
    end_op();
    80008b86:	ffffe097          	auipc	ra,0xffffe
    80008b8a:	d48080e7          	jalr	-696(ra) # 800068ce <end_op>
    return -1;
    80008b8e:	57fd                	li	a5,-1
    80008b90:	a895                	j	80008c04 <sys_chdir+0xcc>
  }
  ilock(ip);
    80008b92:	fe043503          	ld	a0,-32(s0)
    80008b96:	ffffd097          	auipc	ra,0xffffd
    80008b9a:	c0a080e7          	jalr	-1014(ra) # 800057a0 <ilock>
  if(ip->type != T_DIR){
    80008b9e:	fe043783          	ld	a5,-32(s0)
    80008ba2:	04479783          	lh	a5,68(a5)
    80008ba6:	0007871b          	sext.w	a4,a5
    80008baa:	4785                	li	a5,1
    80008bac:	00f70e63          	beq	a4,a5,80008bc8 <sys_chdir+0x90>
    iunlockput(ip);
    80008bb0:	fe043503          	ld	a0,-32(s0)
    80008bb4:	ffffd097          	auipc	ra,0xffffd
    80008bb8:	e4a080e7          	jalr	-438(ra) # 800059fe <iunlockput>
    end_op();
    80008bbc:	ffffe097          	auipc	ra,0xffffe
    80008bc0:	d12080e7          	jalr	-750(ra) # 800068ce <end_op>
    return -1;
    80008bc4:	57fd                	li	a5,-1
    80008bc6:	a83d                	j	80008c04 <sys_chdir+0xcc>
  }
  iunlock(ip);
    80008bc8:	fe043503          	ld	a0,-32(s0)
    80008bcc:	ffffd097          	auipc	ra,0xffffd
    80008bd0:	d08080e7          	jalr	-760(ra) # 800058d4 <iunlock>
  iput(p->cwd);
    80008bd4:	fe843703          	ld	a4,-24(s0)
    80008bd8:	6785                	lui	a5,0x1
    80008bda:	97ba                	add	a5,a5,a4
    80008bdc:	3b07b783          	ld	a5,944(a5) # 13b0 <_entry-0x7fffec50>
    80008be0:	853e                	mv	a0,a5
    80008be2:	ffffd097          	auipc	ra,0xffffd
    80008be6:	d4c080e7          	jalr	-692(ra) # 8000592e <iput>
  end_op();
    80008bea:	ffffe097          	auipc	ra,0xffffe
    80008bee:	ce4080e7          	jalr	-796(ra) # 800068ce <end_op>
  p->cwd = ip;
    80008bf2:	fe843703          	ld	a4,-24(s0)
    80008bf6:	6785                	lui	a5,0x1
    80008bf8:	97ba                	add	a5,a5,a4
    80008bfa:	fe043703          	ld	a4,-32(s0)
    80008bfe:	3ae7b823          	sd	a4,944(a5) # 13b0 <_entry-0x7fffec50>
  return 0;
    80008c02:	4781                	li	a5,0
}
    80008c04:	853e                	mv	a0,a5
    80008c06:	60ea                	ld	ra,152(sp)
    80008c08:	644a                	ld	s0,144(sp)
    80008c0a:	610d                	addi	sp,sp,160
    80008c0c:	8082                	ret

0000000080008c0e <sys_exec>:

uint64
sys_exec(void)
{
    80008c0e:	7161                	addi	sp,sp,-432
    80008c10:	f706                	sd	ra,424(sp)
    80008c12:	f322                	sd	s0,416(sp)
    80008c14:	1b00                	addi	s0,sp,432
  char path[MAXPATH], *argv[MAXARG];
  int i;
  uint64 uargv, uarg;

  if(argstr(0, path, MAXPATH) < 0 || argaddr(1, &uargv) < 0){
    80008c16:	f6840793          	addi	a5,s0,-152
    80008c1a:	08000613          	li	a2,128
    80008c1e:	85be                	mv	a1,a5
    80008c20:	4501                	li	a0,0
    80008c22:	ffffc097          	auipc	ra,0xffffc
    80008c26:	bfc080e7          	jalr	-1028(ra) # 8000481e <argstr>
    80008c2a:	87aa                	mv	a5,a0
    80008c2c:	0007cd63          	bltz	a5,80008c46 <sys_exec+0x38>
    80008c30:	e6040793          	addi	a5,s0,-416
    80008c34:	85be                	mv	a1,a5
    80008c36:	4505                	li	a0,1
    80008c38:	ffffc097          	auipc	ra,0xffffc
    80008c3c:	bb2080e7          	jalr	-1102(ra) # 800047ea <argaddr>
    80008c40:	87aa                	mv	a5,a0
    80008c42:	0007d463          	bgez	a5,80008c4a <sys_exec+0x3c>
    return -1;
    80008c46:	57fd                	li	a5,-1
    80008c48:	a249                	j	80008dca <sys_exec+0x1bc>
  }
  memset(argv, 0, sizeof(argv));
    80008c4a:	e6840793          	addi	a5,s0,-408
    80008c4e:	10000613          	li	a2,256
    80008c52:	4581                	li	a1,0
    80008c54:	853e                	mv	a0,a5
    80008c56:	ffff8097          	auipc	ra,0xffff8
    80008c5a:	7fe080e7          	jalr	2046(ra) # 80001454 <memset>
  for(i=0;; i++){
    80008c5e:	fe042623          	sw	zero,-20(s0)
    if(i >= NELEM(argv)){
    80008c62:	fec42783          	lw	a5,-20(s0)
    80008c66:	873e                	mv	a4,a5
    80008c68:	47fd                	li	a5,31
    80008c6a:	10e7e463          	bltu	a5,a4,80008d72 <sys_exec+0x164>
      goto bad;
    }
    if(fetchaddr(uargv+sizeof(uint64)*i, (uint64*)&uarg) < 0){
    80008c6e:	fec42783          	lw	a5,-20(s0)
    80008c72:	00379713          	slli	a4,a5,0x3
    80008c76:	e6043783          	ld	a5,-416(s0)
    80008c7a:	97ba                	add	a5,a5,a4
    80008c7c:	e5840713          	addi	a4,s0,-424
    80008c80:	85ba                	mv	a1,a4
    80008c82:	853e                	mv	a0,a5
    80008c84:	ffffc097          	auipc	ra,0xffffc
    80008c88:	974080e7          	jalr	-1676(ra) # 800045f8 <fetchaddr>
    80008c8c:	87aa                	mv	a5,a0
    80008c8e:	0e07c463          	bltz	a5,80008d76 <sys_exec+0x168>
      goto bad;
    }
    if(uarg == 0){
    80008c92:	e5843783          	ld	a5,-424(s0)
    80008c96:	eb95                	bnez	a5,80008cca <sys_exec+0xbc>
      argv[i] = 0;
    80008c98:	fec42783          	lw	a5,-20(s0)
    80008c9c:	078e                	slli	a5,a5,0x3
    80008c9e:	ff040713          	addi	a4,s0,-16
    80008ca2:	97ba                	add	a5,a5,a4
    80008ca4:	e607bc23          	sd	zero,-392(a5)
      break;
    80008ca8:	0001                	nop
      goto bad;
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
      goto bad;
  }

  int ret = exec(path, argv);
    80008caa:	e6840713          	addi	a4,s0,-408
    80008cae:	f6840793          	addi	a5,s0,-152
    80008cb2:	85ba                	mv	a1,a4
    80008cb4:	853e                	mv	a0,a5
    80008cb6:	fffff097          	auipc	ra,0xfffff
    80008cba:	bc0080e7          	jalr	-1088(ra) # 80007876 <exec>
    80008cbe:	87aa                	mv	a5,a0
    80008cc0:	fef42423          	sw	a5,-24(s0)

  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80008cc4:	fe042623          	sw	zero,-20(s0)
    80008cc8:	a059                	j	80008d4e <sys_exec+0x140>
    argv[i] = kalloc();
    80008cca:	ffff8097          	auipc	ra,0xffff8
    80008cce:	462080e7          	jalr	1122(ra) # 8000112c <kalloc>
    80008cd2:	872a                	mv	a4,a0
    80008cd4:	fec42783          	lw	a5,-20(s0)
    80008cd8:	078e                	slli	a5,a5,0x3
    80008cda:	ff040693          	addi	a3,s0,-16
    80008cde:	97b6                	add	a5,a5,a3
    80008ce0:	e6e7bc23          	sd	a4,-392(a5)
    if(argv[i] == 0)
    80008ce4:	fec42783          	lw	a5,-20(s0)
    80008ce8:	078e                	slli	a5,a5,0x3
    80008cea:	ff040713          	addi	a4,s0,-16
    80008cee:	97ba                	add	a5,a5,a4
    80008cf0:	e787b783          	ld	a5,-392(a5)
    80008cf4:	c3d9                	beqz	a5,80008d7a <sys_exec+0x16c>
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
    80008cf6:	e5843703          	ld	a4,-424(s0)
    80008cfa:	fec42783          	lw	a5,-20(s0)
    80008cfe:	078e                	slli	a5,a5,0x3
    80008d00:	ff040693          	addi	a3,s0,-16
    80008d04:	97b6                	add	a5,a5,a3
    80008d06:	e787b783          	ld	a5,-392(a5)
    80008d0a:	6605                	lui	a2,0x1
    80008d0c:	85be                	mv	a1,a5
    80008d0e:	853a                	mv	a0,a4
    80008d10:	ffffc097          	auipc	ra,0xffffc
    80008d14:	968080e7          	jalr	-1688(ra) # 80004678 <fetchstr>
    80008d18:	87aa                	mv	a5,a0
    80008d1a:	0607c263          	bltz	a5,80008d7e <sys_exec+0x170>
  for(i=0;; i++){
    80008d1e:	fec42783          	lw	a5,-20(s0)
    80008d22:	2785                	addiw	a5,a5,1
    80008d24:	fef42623          	sw	a5,-20(s0)
    if(i >= NELEM(argv)){
    80008d28:	bf2d                	j	80008c62 <sys_exec+0x54>
    kfree(argv[i]);
    80008d2a:	fec42783          	lw	a5,-20(s0)
    80008d2e:	078e                	slli	a5,a5,0x3
    80008d30:	ff040713          	addi	a4,s0,-16
    80008d34:	97ba                	add	a5,a5,a4
    80008d36:	e787b783          	ld	a5,-392(a5)
    80008d3a:	853e                	mv	a0,a5
    80008d3c:	ffff8097          	auipc	ra,0xffff8
    80008d40:	34c080e7          	jalr	844(ra) # 80001088 <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80008d44:	fec42783          	lw	a5,-20(s0)
    80008d48:	2785                	addiw	a5,a5,1
    80008d4a:	fef42623          	sw	a5,-20(s0)
    80008d4e:	fec42783          	lw	a5,-20(s0)
    80008d52:	873e                	mv	a4,a5
    80008d54:	47fd                	li	a5,31
    80008d56:	00e7eb63          	bltu	a5,a4,80008d6c <sys_exec+0x15e>
    80008d5a:	fec42783          	lw	a5,-20(s0)
    80008d5e:	078e                	slli	a5,a5,0x3
    80008d60:	ff040713          	addi	a4,s0,-16
    80008d64:	97ba                	add	a5,a5,a4
    80008d66:	e787b783          	ld	a5,-392(a5)
    80008d6a:	f3e1                	bnez	a5,80008d2a <sys_exec+0x11c>

  return ret;
    80008d6c:	fe842783          	lw	a5,-24(s0)
    80008d70:	a8a9                	j	80008dca <sys_exec+0x1bc>
      goto bad;
    80008d72:	0001                	nop
    80008d74:	a031                	j	80008d80 <sys_exec+0x172>
      goto bad;
    80008d76:	0001                	nop
    80008d78:	a021                	j	80008d80 <sys_exec+0x172>
      goto bad;
    80008d7a:	0001                	nop
    80008d7c:	a011                	j	80008d80 <sys_exec+0x172>
      goto bad;
    80008d7e:	0001                	nop

 bad:
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80008d80:	fe042623          	sw	zero,-20(s0)
    80008d84:	a01d                	j	80008daa <sys_exec+0x19c>
    kfree(argv[i]);
    80008d86:	fec42783          	lw	a5,-20(s0)
    80008d8a:	078e                	slli	a5,a5,0x3
    80008d8c:	ff040713          	addi	a4,s0,-16
    80008d90:	97ba                	add	a5,a5,a4
    80008d92:	e787b783          	ld	a5,-392(a5)
    80008d96:	853e                	mv	a0,a5
    80008d98:	ffff8097          	auipc	ra,0xffff8
    80008d9c:	2f0080e7          	jalr	752(ra) # 80001088 <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80008da0:	fec42783          	lw	a5,-20(s0)
    80008da4:	2785                	addiw	a5,a5,1
    80008da6:	fef42623          	sw	a5,-20(s0)
    80008daa:	fec42783          	lw	a5,-20(s0)
    80008dae:	873e                	mv	a4,a5
    80008db0:	47fd                	li	a5,31
    80008db2:	00e7eb63          	bltu	a5,a4,80008dc8 <sys_exec+0x1ba>
    80008db6:	fec42783          	lw	a5,-20(s0)
    80008dba:	078e                	slli	a5,a5,0x3
    80008dbc:	ff040713          	addi	a4,s0,-16
    80008dc0:	97ba                	add	a5,a5,a4
    80008dc2:	e787b783          	ld	a5,-392(a5)
    80008dc6:	f3e1                	bnez	a5,80008d86 <sys_exec+0x178>
  return -1;
    80008dc8:	57fd                	li	a5,-1
}
    80008dca:	853e                	mv	a0,a5
    80008dcc:	70ba                	ld	ra,424(sp)
    80008dce:	741a                	ld	s0,416(sp)
    80008dd0:	615d                	addi	sp,sp,432
    80008dd2:	8082                	ret

0000000080008dd4 <sys_pipe>:

uint64
sys_pipe(void)
{
    80008dd4:	7139                	addi	sp,sp,-64
    80008dd6:	fc06                	sd	ra,56(sp)
    80008dd8:	f822                	sd	s0,48(sp)
    80008dda:	0080                	addi	s0,sp,64
  uint64 fdarray; // user pointer to array of two integers
  struct file *rf, *wf;
  int fd0, fd1;
  struct proc *p = myproc();
    80008ddc:	ffffa097          	auipc	ra,0xffffa
    80008de0:	a1c080e7          	jalr	-1508(ra) # 800027f8 <myproc>
    80008de4:	fea43423          	sd	a0,-24(s0)

  if(argaddr(0, &fdarray) < 0)
    80008de8:	fe040793          	addi	a5,s0,-32
    80008dec:	85be                	mv	a1,a5
    80008dee:	4501                	li	a0,0
    80008df0:	ffffc097          	auipc	ra,0xffffc
    80008df4:	9fa080e7          	jalr	-1542(ra) # 800047ea <argaddr>
    80008df8:	87aa                	mv	a5,a0
    80008dfa:	0007d463          	bgez	a5,80008e02 <sys_pipe+0x2e>
    return -1;
    80008dfe:	57fd                	li	a5,-1
    80008e00:	aa1d                	j	80008f36 <sys_pipe+0x162>
  if(pipealloc(&rf, &wf) < 0)
    80008e02:	fd040713          	addi	a4,s0,-48
    80008e06:	fd840793          	addi	a5,s0,-40
    80008e0a:	85ba                	mv	a1,a4
    80008e0c:	853e                	mv	a0,a5
    80008e0e:	ffffe097          	auipc	ra,0xffffe
    80008e12:	5ce080e7          	jalr	1486(ra) # 800073dc <pipealloc>
    80008e16:	87aa                	mv	a5,a0
    80008e18:	0007d463          	bgez	a5,80008e20 <sys_pipe+0x4c>
    return -1;
    80008e1c:	57fd                	li	a5,-1
    80008e1e:	aa21                	j	80008f36 <sys_pipe+0x162>
  fd0 = -1;
    80008e20:	57fd                	li	a5,-1
    80008e22:	fcf42623          	sw	a5,-52(s0)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    80008e26:	fd843783          	ld	a5,-40(s0)
    80008e2a:	853e                	mv	a0,a5
    80008e2c:	fffff097          	auipc	ra,0xfffff
    80008e30:	0b0080e7          	jalr	176(ra) # 80007edc <fdalloc>
    80008e34:	87aa                	mv	a5,a0
    80008e36:	fcf42623          	sw	a5,-52(s0)
    80008e3a:	fcc42783          	lw	a5,-52(s0)
    80008e3e:	0207c063          	bltz	a5,80008e5e <sys_pipe+0x8a>
    80008e42:	fd043783          	ld	a5,-48(s0)
    80008e46:	853e                	mv	a0,a5
    80008e48:	fffff097          	auipc	ra,0xfffff
    80008e4c:	094080e7          	jalr	148(ra) # 80007edc <fdalloc>
    80008e50:	87aa                	mv	a5,a0
    80008e52:	fcf42423          	sw	a5,-56(s0)
    80008e56:	fc842783          	lw	a5,-56(s0)
    80008e5a:	0407d063          	bgez	a5,80008e9a <sys_pipe+0xc6>
    if(fd0 >= 0)
    80008e5e:	fcc42783          	lw	a5,-52(s0)
    80008e62:	0007cc63          	bltz	a5,80008e7a <sys_pipe+0xa6>
      p->ofile[fd0] = 0;
    80008e66:	fcc42783          	lw	a5,-52(s0)
    80008e6a:	fe843703          	ld	a4,-24(s0)
    80008e6e:	26678793          	addi	a5,a5,614
    80008e72:	078e                	slli	a5,a5,0x3
    80008e74:	97ba                	add	a5,a5,a4
    80008e76:	0007b023          	sd	zero,0(a5)
    fileclose(rf);
    80008e7a:	fd843783          	ld	a5,-40(s0)
    80008e7e:	853e                	mv	a0,a5
    80008e80:	ffffe097          	auipc	ra,0xffffe
    80008e84:	026080e7          	jalr	38(ra) # 80006ea6 <fileclose>
    fileclose(wf);
    80008e88:	fd043783          	ld	a5,-48(s0)
    80008e8c:	853e                	mv	a0,a5
    80008e8e:	ffffe097          	auipc	ra,0xffffe
    80008e92:	018080e7          	jalr	24(ra) # 80006ea6 <fileclose>
    return -1;
    80008e96:	57fd                	li	a5,-1
    80008e98:	a879                	j	80008f36 <sys_pipe+0x162>
  }
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    80008e9a:	fe843703          	ld	a4,-24(s0)
    80008e9e:	6785                	lui	a5,0x1
    80008ea0:	97ba                	add	a5,a5,a4
    80008ea2:	2b07b783          	ld	a5,688(a5) # 12b0 <_entry-0x7fffed50>
    80008ea6:	fe043703          	ld	a4,-32(s0)
    80008eaa:	fcc40613          	addi	a2,s0,-52
    80008eae:	4691                	li	a3,4
    80008eb0:	85ba                	mv	a1,a4
    80008eb2:	853e                	mv	a0,a5
    80008eb4:	ffff9097          	auipc	ra,0xffff9
    80008eb8:	420080e7          	jalr	1056(ra) # 800022d4 <copyout>
    80008ebc:	87aa                	mv	a5,a0
    80008ebe:	0207c763          	bltz	a5,80008eec <sys_pipe+0x118>
     copyout(p->pagetable, fdarray+sizeof(fd0), (char *)&fd1, sizeof(fd1)) < 0){
    80008ec2:	fe843703          	ld	a4,-24(s0)
    80008ec6:	6785                	lui	a5,0x1
    80008ec8:	97ba                	add	a5,a5,a4
    80008eca:	2b07b703          	ld	a4,688(a5) # 12b0 <_entry-0x7fffed50>
    80008ece:	fe043783          	ld	a5,-32(s0)
    80008ed2:	0791                	addi	a5,a5,4
    80008ed4:	fc840613          	addi	a2,s0,-56
    80008ed8:	4691                	li	a3,4
    80008eda:	85be                	mv	a1,a5
    80008edc:	853a                	mv	a0,a4
    80008ede:	ffff9097          	auipc	ra,0xffff9
    80008ee2:	3f6080e7          	jalr	1014(ra) # 800022d4 <copyout>
    80008ee6:	87aa                	mv	a5,a0
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    80008ee8:	0407d663          	bgez	a5,80008f34 <sys_pipe+0x160>
    p->ofile[fd0] = 0;
    80008eec:	fcc42783          	lw	a5,-52(s0)
    80008ef0:	fe843703          	ld	a4,-24(s0)
    80008ef4:	26678793          	addi	a5,a5,614
    80008ef8:	078e                	slli	a5,a5,0x3
    80008efa:	97ba                	add	a5,a5,a4
    80008efc:	0007b023          	sd	zero,0(a5)
    p->ofile[fd1] = 0;
    80008f00:	fc842783          	lw	a5,-56(s0)
    80008f04:	fe843703          	ld	a4,-24(s0)
    80008f08:	26678793          	addi	a5,a5,614
    80008f0c:	078e                	slli	a5,a5,0x3
    80008f0e:	97ba                	add	a5,a5,a4
    80008f10:	0007b023          	sd	zero,0(a5)
    fileclose(rf);
    80008f14:	fd843783          	ld	a5,-40(s0)
    80008f18:	853e                	mv	a0,a5
    80008f1a:	ffffe097          	auipc	ra,0xffffe
    80008f1e:	f8c080e7          	jalr	-116(ra) # 80006ea6 <fileclose>
    fileclose(wf);
    80008f22:	fd043783          	ld	a5,-48(s0)
    80008f26:	853e                	mv	a0,a5
    80008f28:	ffffe097          	auipc	ra,0xffffe
    80008f2c:	f7e080e7          	jalr	-130(ra) # 80006ea6 <fileclose>
    return -1;
    80008f30:	57fd                	li	a5,-1
    80008f32:	a011                	j	80008f36 <sys_pipe+0x162>
  }
  return 0;
    80008f34:	4781                	li	a5,0
}
    80008f36:	853e                	mv	a0,a5
    80008f38:	70e2                	ld	ra,56(sp)
    80008f3a:	7442                	ld	s0,48(sp)
    80008f3c:	6121                	addi	sp,sp,64
    80008f3e:	8082                	ret

0000000080008f40 <kernelvec>:
    80008f40:	7111                	addi	sp,sp,-256
    80008f42:	e006                	sd	ra,0(sp)
    80008f44:	e40a                	sd	sp,8(sp)
    80008f46:	e80e                	sd	gp,16(sp)
    80008f48:	ec12                	sd	tp,24(sp)
    80008f4a:	f016                	sd	t0,32(sp)
    80008f4c:	f41a                	sd	t1,40(sp)
    80008f4e:	f81e                	sd	t2,48(sp)
    80008f50:	fc22                	sd	s0,56(sp)
    80008f52:	e0a6                	sd	s1,64(sp)
    80008f54:	e4aa                	sd	a0,72(sp)
    80008f56:	e8ae                	sd	a1,80(sp)
    80008f58:	ecb2                	sd	a2,88(sp)
    80008f5a:	f0b6                	sd	a3,96(sp)
    80008f5c:	f4ba                	sd	a4,104(sp)
    80008f5e:	f8be                	sd	a5,112(sp)
    80008f60:	fcc2                	sd	a6,120(sp)
    80008f62:	e146                	sd	a7,128(sp)
    80008f64:	e54a                	sd	s2,136(sp)
    80008f66:	e94e                	sd	s3,144(sp)
    80008f68:	ed52                	sd	s4,152(sp)
    80008f6a:	f156                	sd	s5,160(sp)
    80008f6c:	f55a                	sd	s6,168(sp)
    80008f6e:	f95e                	sd	s7,176(sp)
    80008f70:	fd62                	sd	s8,184(sp)
    80008f72:	e1e6                	sd	s9,192(sp)
    80008f74:	e5ea                	sd	s10,200(sp)
    80008f76:	e9ee                	sd	s11,208(sp)
    80008f78:	edf2                	sd	t3,216(sp)
    80008f7a:	f1f6                	sd	t4,224(sp)
    80008f7c:	f5fa                	sd	t5,232(sp)
    80008f7e:	f9fe                	sd	t6,240(sp)
    80008f80:	c08fb0ef          	jal	ra,80004388 <kerneltrap>
    80008f84:	6082                	ld	ra,0(sp)
    80008f86:	6122                	ld	sp,8(sp)
    80008f88:	61c2                	ld	gp,16(sp)
    80008f8a:	7282                	ld	t0,32(sp)
    80008f8c:	7322                	ld	t1,40(sp)
    80008f8e:	73c2                	ld	t2,48(sp)
    80008f90:	7462                	ld	s0,56(sp)
    80008f92:	6486                	ld	s1,64(sp)
    80008f94:	6526                	ld	a0,72(sp)
    80008f96:	65c6                	ld	a1,80(sp)
    80008f98:	6666                	ld	a2,88(sp)
    80008f9a:	7686                	ld	a3,96(sp)
    80008f9c:	7726                	ld	a4,104(sp)
    80008f9e:	77c6                	ld	a5,112(sp)
    80008fa0:	7866                	ld	a6,120(sp)
    80008fa2:	688a                	ld	a7,128(sp)
    80008fa4:	692a                	ld	s2,136(sp)
    80008fa6:	69ca                	ld	s3,144(sp)
    80008fa8:	6a6a                	ld	s4,152(sp)
    80008faa:	7a8a                	ld	s5,160(sp)
    80008fac:	7b2a                	ld	s6,168(sp)
    80008fae:	7bca                	ld	s7,176(sp)
    80008fb0:	7c6a                	ld	s8,184(sp)
    80008fb2:	6c8e                	ld	s9,192(sp)
    80008fb4:	6d2e                	ld	s10,200(sp)
    80008fb6:	6dce                	ld	s11,208(sp)
    80008fb8:	6e6e                	ld	t3,216(sp)
    80008fba:	7e8e                	ld	t4,224(sp)
    80008fbc:	7f2e                	ld	t5,232(sp)
    80008fbe:	7fce                	ld	t6,240(sp)
    80008fc0:	6111                	addi	sp,sp,256
    80008fc2:	10200073          	sret
    80008fc6:	00000013          	nop
    80008fca:	00000013          	nop
    80008fce:	0001                	nop

0000000080008fd0 <timervec>:
    80008fd0:	34051573          	csrrw	a0,mscratch,a0
    80008fd4:	e10c                	sd	a1,0(a0)
    80008fd6:	e510                	sd	a2,8(a0)
    80008fd8:	e914                	sd	a3,16(a0)
    80008fda:	6d0c                	ld	a1,24(a0)
    80008fdc:	7110                	ld	a2,32(a0)
    80008fde:	6194                	ld	a3,0(a1)
    80008fe0:	96b2                	add	a3,a3,a2
    80008fe2:	e194                	sd	a3,0(a1)
    80008fe4:	4589                	li	a1,2
    80008fe6:	14459073          	csrw	sip,a1
    80008fea:	6914                	ld	a3,16(a0)
    80008fec:	6510                	ld	a2,8(a0)
    80008fee:	610c                	ld	a1,0(a0)
    80008ff0:	34051573          	csrrw	a0,mscratch,a0
    80008ff4:	30200073          	mret
	...

0000000080008ffa <plicinit>:
// the riscv Platform Level Interrupt Controller (PLIC).
//

void
plicinit(void)
{
    80008ffa:	1141                	addi	sp,sp,-16
    80008ffc:	e422                	sd	s0,8(sp)
    80008ffe:	0800                	addi	s0,sp,16
  // set desired IRQ priorities non-zero (otherwise disabled).
  *(uint32*)(PLIC + UART0_IRQ*4) = 1;
    80009000:	0c0007b7          	lui	a5,0xc000
    80009004:	02878793          	addi	a5,a5,40 # c000028 <_entry-0x73ffffd8>
    80009008:	4705                	li	a4,1
    8000900a:	c398                	sw	a4,0(a5)
  *(uint32*)(PLIC + VIRTIO0_IRQ*4) = 1;
    8000900c:	0c0007b7          	lui	a5,0xc000
    80009010:	0791                	addi	a5,a5,4
    80009012:	4705                	li	a4,1
    80009014:	c398                	sw	a4,0(a5)
}
    80009016:	0001                	nop
    80009018:	6422                	ld	s0,8(sp)
    8000901a:	0141                	addi	sp,sp,16
    8000901c:	8082                	ret

000000008000901e <plicinithart>:

void
plicinithart(void)
{
    8000901e:	1101                	addi	sp,sp,-32
    80009020:	ec06                	sd	ra,24(sp)
    80009022:	e822                	sd	s0,16(sp)
    80009024:	1000                	addi	s0,sp,32
  int hart = cpuid();
    80009026:	ffff9097          	auipc	ra,0xffff9
    8000902a:	774080e7          	jalr	1908(ra) # 8000279a <cpuid>
    8000902e:	87aa                	mv	a5,a0
    80009030:	fef42623          	sw	a5,-20(s0)
  
  // set uart's enable bit for this hart's S-mode. 
  *(uint32*)PLIC_SENABLE(hart)= (1 << UART0_IRQ) | (1 << VIRTIO0_IRQ);
    80009034:	fec42783          	lw	a5,-20(s0)
    80009038:	0087979b          	slliw	a5,a5,0x8
    8000903c:	2781                	sext.w	a5,a5
    8000903e:	873e                	mv	a4,a5
    80009040:	0c0027b7          	lui	a5,0xc002
    80009044:	08078793          	addi	a5,a5,128 # c002080 <_entry-0x73ffdf80>
    80009048:	97ba                	add	a5,a5,a4
    8000904a:	873e                	mv	a4,a5
    8000904c:	40200793          	li	a5,1026
    80009050:	c31c                	sw	a5,0(a4)

  // set this hart's S-mode priority threshold to 0.
  *(uint32*)PLIC_SPRIORITY(hart) = 0;
    80009052:	fec42783          	lw	a5,-20(s0)
    80009056:	00d7979b          	slliw	a5,a5,0xd
    8000905a:	2781                	sext.w	a5,a5
    8000905c:	873e                	mv	a4,a5
    8000905e:	0c2017b7          	lui	a5,0xc201
    80009062:	97ba                	add	a5,a5,a4
    80009064:	0007a023          	sw	zero,0(a5) # c201000 <_entry-0x73dff000>
}
    80009068:	0001                	nop
    8000906a:	60e2                	ld	ra,24(sp)
    8000906c:	6442                	ld	s0,16(sp)
    8000906e:	6105                	addi	sp,sp,32
    80009070:	8082                	ret

0000000080009072 <plic_claim>:

// ask the PLIC what interrupt we should serve.
int
plic_claim(void)
{
    80009072:	1101                	addi	sp,sp,-32
    80009074:	ec06                	sd	ra,24(sp)
    80009076:	e822                	sd	s0,16(sp)
    80009078:	1000                	addi	s0,sp,32
  int hart = cpuid();
    8000907a:	ffff9097          	auipc	ra,0xffff9
    8000907e:	720080e7          	jalr	1824(ra) # 8000279a <cpuid>
    80009082:	87aa                	mv	a5,a0
    80009084:	fef42623          	sw	a5,-20(s0)
  int irq = *(uint32*)PLIC_SCLAIM(hart);
    80009088:	fec42783          	lw	a5,-20(s0)
    8000908c:	00d7979b          	slliw	a5,a5,0xd
    80009090:	2781                	sext.w	a5,a5
    80009092:	873e                	mv	a4,a5
    80009094:	0c2017b7          	lui	a5,0xc201
    80009098:	0791                	addi	a5,a5,4
    8000909a:	97ba                	add	a5,a5,a4
    8000909c:	439c                	lw	a5,0(a5)
    8000909e:	fef42423          	sw	a5,-24(s0)
  return irq;
    800090a2:	fe842783          	lw	a5,-24(s0)
}
    800090a6:	853e                	mv	a0,a5
    800090a8:	60e2                	ld	ra,24(sp)
    800090aa:	6442                	ld	s0,16(sp)
    800090ac:	6105                	addi	sp,sp,32
    800090ae:	8082                	ret

00000000800090b0 <plic_complete>:

// tell the PLIC we've served this IRQ.
void
plic_complete(int irq)
{
    800090b0:	7179                	addi	sp,sp,-48
    800090b2:	f406                	sd	ra,40(sp)
    800090b4:	f022                	sd	s0,32(sp)
    800090b6:	1800                	addi	s0,sp,48
    800090b8:	87aa                	mv	a5,a0
    800090ba:	fcf42e23          	sw	a5,-36(s0)
  int hart = cpuid();
    800090be:	ffff9097          	auipc	ra,0xffff9
    800090c2:	6dc080e7          	jalr	1756(ra) # 8000279a <cpuid>
    800090c6:	87aa                	mv	a5,a0
    800090c8:	fef42623          	sw	a5,-20(s0)
  *(uint32*)PLIC_SCLAIM(hart) = irq;
    800090cc:	fec42783          	lw	a5,-20(s0)
    800090d0:	00d7979b          	slliw	a5,a5,0xd
    800090d4:	2781                	sext.w	a5,a5
    800090d6:	873e                	mv	a4,a5
    800090d8:	0c2017b7          	lui	a5,0xc201
    800090dc:	0791                	addi	a5,a5,4
    800090de:	97ba                	add	a5,a5,a4
    800090e0:	873e                	mv	a4,a5
    800090e2:	fdc42783          	lw	a5,-36(s0)
    800090e6:	c31c                	sw	a5,0(a4)
}
    800090e8:	0001                	nop
    800090ea:	70a2                	ld	ra,40(sp)
    800090ec:	7402                	ld	s0,32(sp)
    800090ee:	6145                	addi	sp,sp,48
    800090f0:	8082                	ret

00000000800090f2 <virtio_disk_init>:
  
} __attribute__ ((aligned (PGSIZE))) disk;

void
virtio_disk_init(void)
{
    800090f2:	7179                	addi	sp,sp,-48
    800090f4:	f406                	sd	ra,40(sp)
    800090f6:	f022                	sd	s0,32(sp)
    800090f8:	1800                	addi	s0,sp,48
  uint32 status = 0;
    800090fa:	fe042423          	sw	zero,-24(s0)

  initlock(&disk.vdisk_lock, "virtio_disk");
    800090fe:	00003597          	auipc	a1,0x3
    80009102:	5a258593          	addi	a1,a1,1442 # 8000c6a0 <etext+0x6a0>
    80009106:	00069517          	auipc	a0,0x69
    8000910a:	02250513          	addi	a0,a0,34 # 80072128 <disk+0x2128>
    8000910e:	ffff8097          	auipc	ra,0xffff8
    80009112:	142080e7          	jalr	322(ra) # 80001250 <initlock>

  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    80009116:	100017b7          	lui	a5,0x10001
    8000911a:	439c                	lw	a5,0(a5)
    8000911c:	2781                	sext.w	a5,a5
    8000911e:	873e                	mv	a4,a5
    80009120:	747277b7          	lui	a5,0x74727
    80009124:	97678793          	addi	a5,a5,-1674 # 74726976 <_entry-0xb8d968a>
    80009128:	04f71063          	bne	a4,a5,80009168 <virtio_disk_init+0x76>
     *R(VIRTIO_MMIO_VERSION) != 1 ||
    8000912c:	100017b7          	lui	a5,0x10001
    80009130:	0791                	addi	a5,a5,4
    80009132:	439c                	lw	a5,0(a5)
    80009134:	2781                	sext.w	a5,a5
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    80009136:	873e                	mv	a4,a5
    80009138:	4785                	li	a5,1
    8000913a:	02f71763          	bne	a4,a5,80009168 <virtio_disk_init+0x76>
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    8000913e:	100017b7          	lui	a5,0x10001
    80009142:	07a1                	addi	a5,a5,8
    80009144:	439c                	lw	a5,0(a5)
    80009146:	2781                	sext.w	a5,a5
     *R(VIRTIO_MMIO_VERSION) != 1 ||
    80009148:	873e                	mv	a4,a5
    8000914a:	4789                	li	a5,2
    8000914c:	00f71e63          	bne	a4,a5,80009168 <virtio_disk_init+0x76>
     *R(VIRTIO_MMIO_VENDOR_ID) != 0x554d4551){
    80009150:	100017b7          	lui	a5,0x10001
    80009154:	07b1                	addi	a5,a5,12
    80009156:	439c                	lw	a5,0(a5)
    80009158:	2781                	sext.w	a5,a5
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    8000915a:	873e                	mv	a4,a5
    8000915c:	554d47b7          	lui	a5,0x554d4
    80009160:	55178793          	addi	a5,a5,1361 # 554d4551 <_entry-0x2ab2baaf>
    80009164:	00f70a63          	beq	a4,a5,80009178 <virtio_disk_init+0x86>
    panic("could not find virtio disk");
    80009168:	00003517          	auipc	a0,0x3
    8000916c:	54850513          	addi	a0,a0,1352 # 8000c6b0 <etext+0x6b0>
    80009170:	ffff8097          	auipc	ra,0xffff8
    80009174:	ae2080e7          	jalr	-1310(ra) # 80000c52 <panic>
  }
  
  status |= VIRTIO_CONFIG_S_ACKNOWLEDGE;
    80009178:	fe842783          	lw	a5,-24(s0)
    8000917c:	0017e793          	ori	a5,a5,1
    80009180:	fef42423          	sw	a5,-24(s0)
  *R(VIRTIO_MMIO_STATUS) = status;
    80009184:	100017b7          	lui	a5,0x10001
    80009188:	07078793          	addi	a5,a5,112 # 10001070 <_entry-0x6fffef90>
    8000918c:	fe842703          	lw	a4,-24(s0)
    80009190:	c398                	sw	a4,0(a5)

  status |= VIRTIO_CONFIG_S_DRIVER;
    80009192:	fe842783          	lw	a5,-24(s0)
    80009196:	0027e793          	ori	a5,a5,2
    8000919a:	fef42423          	sw	a5,-24(s0)
  *R(VIRTIO_MMIO_STATUS) = status;
    8000919e:	100017b7          	lui	a5,0x10001
    800091a2:	07078793          	addi	a5,a5,112 # 10001070 <_entry-0x6fffef90>
    800091a6:	fe842703          	lw	a4,-24(s0)
    800091aa:	c398                	sw	a4,0(a5)

  // negotiate features
  uint64 features = *R(VIRTIO_MMIO_DEVICE_FEATURES);
    800091ac:	100017b7          	lui	a5,0x10001
    800091b0:	07c1                	addi	a5,a5,16
    800091b2:	439c                	lw	a5,0(a5)
    800091b4:	2781                	sext.w	a5,a5
    800091b6:	1782                	slli	a5,a5,0x20
    800091b8:	9381                	srli	a5,a5,0x20
    800091ba:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_BLK_F_RO);
    800091be:	fe043783          	ld	a5,-32(s0)
    800091c2:	fdf7f793          	andi	a5,a5,-33
    800091c6:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_BLK_F_SCSI);
    800091ca:	fe043783          	ld	a5,-32(s0)
    800091ce:	f7f7f793          	andi	a5,a5,-129
    800091d2:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_BLK_F_CONFIG_WCE);
    800091d6:	fe043703          	ld	a4,-32(s0)
    800091da:	77fd                	lui	a5,0xfffff
    800091dc:	7ff78793          	addi	a5,a5,2047 # fffffffffffff7ff <end+0xffffffff7ff8c7ff>
    800091e0:	8ff9                	and	a5,a5,a4
    800091e2:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_BLK_F_MQ);
    800091e6:	fe043703          	ld	a4,-32(s0)
    800091ea:	77fd                	lui	a5,0xfffff
    800091ec:	17fd                	addi	a5,a5,-1
    800091ee:	8ff9                	and	a5,a5,a4
    800091f0:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_F_ANY_LAYOUT);
    800091f4:	fe043703          	ld	a4,-32(s0)
    800091f8:	f80007b7          	lui	a5,0xf8000
    800091fc:	17fd                	addi	a5,a5,-1
    800091fe:	8ff9                	and	a5,a5,a4
    80009200:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_RING_F_EVENT_IDX);
    80009204:	fe043703          	ld	a4,-32(s0)
    80009208:	e00007b7          	lui	a5,0xe0000
    8000920c:	17fd                	addi	a5,a5,-1
    8000920e:	8ff9                	and	a5,a5,a4
    80009210:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_RING_F_INDIRECT_DESC);
    80009214:	fe043703          	ld	a4,-32(s0)
    80009218:	f00007b7          	lui	a5,0xf0000
    8000921c:	17fd                	addi	a5,a5,-1
    8000921e:	8ff9                	and	a5,a5,a4
    80009220:	fef43023          	sd	a5,-32(s0)
  *R(VIRTIO_MMIO_DRIVER_FEATURES) = features;
    80009224:	100017b7          	lui	a5,0x10001
    80009228:	02078793          	addi	a5,a5,32 # 10001020 <_entry-0x6fffefe0>
    8000922c:	fe043703          	ld	a4,-32(s0)
    80009230:	2701                	sext.w	a4,a4
    80009232:	c398                	sw	a4,0(a5)

  // tell device that feature negotiation is complete.
  status |= VIRTIO_CONFIG_S_FEATURES_OK;
    80009234:	fe842783          	lw	a5,-24(s0)
    80009238:	0087e793          	ori	a5,a5,8
    8000923c:	fef42423          	sw	a5,-24(s0)
  *R(VIRTIO_MMIO_STATUS) = status;
    80009240:	100017b7          	lui	a5,0x10001
    80009244:	07078793          	addi	a5,a5,112 # 10001070 <_entry-0x6fffef90>
    80009248:	fe842703          	lw	a4,-24(s0)
    8000924c:	c398                	sw	a4,0(a5)

  // tell device we're completely ready.
  status |= VIRTIO_CONFIG_S_DRIVER_OK;
    8000924e:	fe842783          	lw	a5,-24(s0)
    80009252:	0047e793          	ori	a5,a5,4
    80009256:	fef42423          	sw	a5,-24(s0)
  *R(VIRTIO_MMIO_STATUS) = status;
    8000925a:	100017b7          	lui	a5,0x10001
    8000925e:	07078793          	addi	a5,a5,112 # 10001070 <_entry-0x6fffef90>
    80009262:	fe842703          	lw	a4,-24(s0)
    80009266:	c398                	sw	a4,0(a5)

  *R(VIRTIO_MMIO_GUEST_PAGE_SIZE) = PGSIZE;
    80009268:	100017b7          	lui	a5,0x10001
    8000926c:	02878793          	addi	a5,a5,40 # 10001028 <_entry-0x6fffefd8>
    80009270:	6705                	lui	a4,0x1
    80009272:	c398                	sw	a4,0(a5)

  // initialize queue 0.
  *R(VIRTIO_MMIO_QUEUE_SEL) = 0;
    80009274:	100017b7          	lui	a5,0x10001
    80009278:	03078793          	addi	a5,a5,48 # 10001030 <_entry-0x6fffefd0>
    8000927c:	0007a023          	sw	zero,0(a5)
  uint32 max = *R(VIRTIO_MMIO_QUEUE_NUM_MAX);
    80009280:	100017b7          	lui	a5,0x10001
    80009284:	03478793          	addi	a5,a5,52 # 10001034 <_entry-0x6fffefcc>
    80009288:	439c                	lw	a5,0(a5)
    8000928a:	fcf42e23          	sw	a5,-36(s0)
  if(max == 0)
    8000928e:	fdc42783          	lw	a5,-36(s0)
    80009292:	2781                	sext.w	a5,a5
    80009294:	eb89                	bnez	a5,800092a6 <virtio_disk_init+0x1b4>
    panic("virtio disk has no queue 0");
    80009296:	00003517          	auipc	a0,0x3
    8000929a:	43a50513          	addi	a0,a0,1082 # 8000c6d0 <etext+0x6d0>
    8000929e:	ffff8097          	auipc	ra,0xffff8
    800092a2:	9b4080e7          	jalr	-1612(ra) # 80000c52 <panic>
  if(max < NUM)
    800092a6:	fdc42783          	lw	a5,-36(s0)
    800092aa:	0007871b          	sext.w	a4,a5
    800092ae:	479d                	li	a5,7
    800092b0:	00e7ea63          	bltu	a5,a4,800092c4 <virtio_disk_init+0x1d2>
    panic("virtio disk max queue too short");
    800092b4:	00003517          	auipc	a0,0x3
    800092b8:	43c50513          	addi	a0,a0,1084 # 8000c6f0 <etext+0x6f0>
    800092bc:	ffff8097          	auipc	ra,0xffff8
    800092c0:	996080e7          	jalr	-1642(ra) # 80000c52 <panic>
  *R(VIRTIO_MMIO_QUEUE_NUM) = NUM;
    800092c4:	100017b7          	lui	a5,0x10001
    800092c8:	03878793          	addi	a5,a5,56 # 10001038 <_entry-0x6fffefc8>
    800092cc:	4721                	li	a4,8
    800092ce:	c398                	sw	a4,0(a5)
  memset(disk.pages, 0, sizeof(disk.pages));
    800092d0:	6609                	lui	a2,0x2
    800092d2:	4581                	li	a1,0
    800092d4:	00067517          	auipc	a0,0x67
    800092d8:	d2c50513          	addi	a0,a0,-724 # 80070000 <disk>
    800092dc:	ffff8097          	auipc	ra,0xffff8
    800092e0:	178080e7          	jalr	376(ra) # 80001454 <memset>
  *R(VIRTIO_MMIO_QUEUE_PFN) = ((uint64)disk.pages) >> PGSHIFT;
    800092e4:	00067797          	auipc	a5,0x67
    800092e8:	d1c78793          	addi	a5,a5,-740 # 80070000 <disk>
    800092ec:	00c7d713          	srli	a4,a5,0xc
    800092f0:	100017b7          	lui	a5,0x10001
    800092f4:	04078793          	addi	a5,a5,64 # 10001040 <_entry-0x6fffefc0>
    800092f8:	2701                	sext.w	a4,a4
    800092fa:	c398                	sw	a4,0(a5)

  // desc = pages -- num * virtq_desc
  // avail = pages + 0x40 -- 2 * uint16, then num * uint16
  // used = pages + 4096 -- 2 * uint16, then num * vRingUsedElem

  disk.desc = (struct virtq_desc *) disk.pages;
    800092fc:	00067717          	auipc	a4,0x67
    80009300:	d0470713          	addi	a4,a4,-764 # 80070000 <disk>
    80009304:	6789                	lui	a5,0x2
    80009306:	97ba                	add	a5,a5,a4
    80009308:	00067717          	auipc	a4,0x67
    8000930c:	cf870713          	addi	a4,a4,-776 # 80070000 <disk>
    80009310:	e398                	sd	a4,0(a5)
  disk.avail = (struct virtq_avail *)(disk.pages + NUM*sizeof(struct virtq_desc));
    80009312:	00067717          	auipc	a4,0x67
    80009316:	d6e70713          	addi	a4,a4,-658 # 80070080 <disk+0x80>
    8000931a:	00067697          	auipc	a3,0x67
    8000931e:	ce668693          	addi	a3,a3,-794 # 80070000 <disk>
    80009322:	6789                	lui	a5,0x2
    80009324:	97b6                	add	a5,a5,a3
    80009326:	e798                	sd	a4,8(a5)
  disk.used = (struct virtq_used *) (disk.pages + PGSIZE);
    80009328:	00068717          	auipc	a4,0x68
    8000932c:	cd870713          	addi	a4,a4,-808 # 80071000 <disk+0x1000>
    80009330:	00067697          	auipc	a3,0x67
    80009334:	cd068693          	addi	a3,a3,-816 # 80070000 <disk>
    80009338:	6789                	lui	a5,0x2
    8000933a:	97b6                	add	a5,a5,a3
    8000933c:	eb98                	sd	a4,16(a5)

  // all NUM descriptors start out unused.
  for(int i = 0; i < NUM; i++)
    8000933e:	fe042623          	sw	zero,-20(s0)
    80009342:	a015                	j	80009366 <virtio_disk_init+0x274>
    disk.free[i] = 1;
    80009344:	00067717          	auipc	a4,0x67
    80009348:	cbc70713          	addi	a4,a4,-836 # 80070000 <disk>
    8000934c:	fec42783          	lw	a5,-20(s0)
    80009350:	97ba                	add	a5,a5,a4
    80009352:	6709                	lui	a4,0x2
    80009354:	97ba                	add	a5,a5,a4
    80009356:	4705                	li	a4,1
    80009358:	00e78c23          	sb	a4,24(a5) # 2018 <_entry-0x7fffdfe8>
  for(int i = 0; i < NUM; i++)
    8000935c:	fec42783          	lw	a5,-20(s0)
    80009360:	2785                	addiw	a5,a5,1
    80009362:	fef42623          	sw	a5,-20(s0)
    80009366:	fec42783          	lw	a5,-20(s0)
    8000936a:	0007871b          	sext.w	a4,a5
    8000936e:	479d                	li	a5,7
    80009370:	fce7dae3          	bge	a5,a4,80009344 <virtio_disk_init+0x252>

  // plic.c and trap.c arrange for interrupts from VIRTIO0_IRQ.
}
    80009374:	0001                	nop
    80009376:	0001                	nop
    80009378:	70a2                	ld	ra,40(sp)
    8000937a:	7402                	ld	s0,32(sp)
    8000937c:	6145                	addi	sp,sp,48
    8000937e:	8082                	ret

0000000080009380 <alloc_desc>:

// find a free descriptor, mark it non-free, return its index.
static int
alloc_desc()
{
    80009380:	1101                	addi	sp,sp,-32
    80009382:	ec22                	sd	s0,24(sp)
    80009384:	1000                	addi	s0,sp,32
  for(int i = 0; i < NUM; i++){
    80009386:	fe042623          	sw	zero,-20(s0)
    8000938a:	a081                	j	800093ca <alloc_desc+0x4a>
    if(disk.free[i]){
    8000938c:	00067717          	auipc	a4,0x67
    80009390:	c7470713          	addi	a4,a4,-908 # 80070000 <disk>
    80009394:	fec42783          	lw	a5,-20(s0)
    80009398:	97ba                	add	a5,a5,a4
    8000939a:	6709                	lui	a4,0x2
    8000939c:	97ba                	add	a5,a5,a4
    8000939e:	0187c783          	lbu	a5,24(a5)
    800093a2:	cf99                	beqz	a5,800093c0 <alloc_desc+0x40>
      disk.free[i] = 0;
    800093a4:	00067717          	auipc	a4,0x67
    800093a8:	c5c70713          	addi	a4,a4,-932 # 80070000 <disk>
    800093ac:	fec42783          	lw	a5,-20(s0)
    800093b0:	97ba                	add	a5,a5,a4
    800093b2:	6709                	lui	a4,0x2
    800093b4:	97ba                	add	a5,a5,a4
    800093b6:	00078c23          	sb	zero,24(a5)
      return i;
    800093ba:	fec42783          	lw	a5,-20(s0)
    800093be:	a831                	j	800093da <alloc_desc+0x5a>
  for(int i = 0; i < NUM; i++){
    800093c0:	fec42783          	lw	a5,-20(s0)
    800093c4:	2785                	addiw	a5,a5,1
    800093c6:	fef42623          	sw	a5,-20(s0)
    800093ca:	fec42783          	lw	a5,-20(s0)
    800093ce:	0007871b          	sext.w	a4,a5
    800093d2:	479d                	li	a5,7
    800093d4:	fae7dce3          	bge	a5,a4,8000938c <alloc_desc+0xc>
    }
  }
  return -1;
    800093d8:	57fd                	li	a5,-1
}
    800093da:	853e                	mv	a0,a5
    800093dc:	6462                	ld	s0,24(sp)
    800093de:	6105                	addi	sp,sp,32
    800093e0:	8082                	ret

00000000800093e2 <free_desc>:

// mark a descriptor as free.
static void
free_desc(int i)
{
    800093e2:	1101                	addi	sp,sp,-32
    800093e4:	ec06                	sd	ra,24(sp)
    800093e6:	e822                	sd	s0,16(sp)
    800093e8:	1000                	addi	s0,sp,32
    800093ea:	87aa                	mv	a5,a0
    800093ec:	fef42623          	sw	a5,-20(s0)
  if(i >= NUM)
    800093f0:	fec42783          	lw	a5,-20(s0)
    800093f4:	0007871b          	sext.w	a4,a5
    800093f8:	479d                	li	a5,7
    800093fa:	00e7da63          	bge	a5,a4,8000940e <free_desc+0x2c>
    panic("free_desc 1");
    800093fe:	00003517          	auipc	a0,0x3
    80009402:	31250513          	addi	a0,a0,786 # 8000c710 <etext+0x710>
    80009406:	ffff8097          	auipc	ra,0xffff8
    8000940a:	84c080e7          	jalr	-1972(ra) # 80000c52 <panic>
  if(disk.free[i])
    8000940e:	00067717          	auipc	a4,0x67
    80009412:	bf270713          	addi	a4,a4,-1038 # 80070000 <disk>
    80009416:	fec42783          	lw	a5,-20(s0)
    8000941a:	97ba                	add	a5,a5,a4
    8000941c:	6709                	lui	a4,0x2
    8000941e:	97ba                	add	a5,a5,a4
    80009420:	0187c783          	lbu	a5,24(a5)
    80009424:	cb89                	beqz	a5,80009436 <free_desc+0x54>
    panic("free_desc 2");
    80009426:	00003517          	auipc	a0,0x3
    8000942a:	2fa50513          	addi	a0,a0,762 # 8000c720 <etext+0x720>
    8000942e:	ffff8097          	auipc	ra,0xffff8
    80009432:	824080e7          	jalr	-2012(ra) # 80000c52 <panic>
  disk.desc[i].addr = 0;
    80009436:	00067717          	auipc	a4,0x67
    8000943a:	bca70713          	addi	a4,a4,-1078 # 80070000 <disk>
    8000943e:	6789                	lui	a5,0x2
    80009440:	97ba                	add	a5,a5,a4
    80009442:	6398                	ld	a4,0(a5)
    80009444:	fec42783          	lw	a5,-20(s0)
    80009448:	0792                	slli	a5,a5,0x4
    8000944a:	97ba                	add	a5,a5,a4
    8000944c:	0007b023          	sd	zero,0(a5) # 2000 <_entry-0x7fffe000>
  disk.desc[i].len = 0;
    80009450:	00067717          	auipc	a4,0x67
    80009454:	bb070713          	addi	a4,a4,-1104 # 80070000 <disk>
    80009458:	6789                	lui	a5,0x2
    8000945a:	97ba                	add	a5,a5,a4
    8000945c:	6398                	ld	a4,0(a5)
    8000945e:	fec42783          	lw	a5,-20(s0)
    80009462:	0792                	slli	a5,a5,0x4
    80009464:	97ba                	add	a5,a5,a4
    80009466:	0007a423          	sw	zero,8(a5) # 2008 <_entry-0x7fffdff8>
  disk.desc[i].flags = 0;
    8000946a:	00067717          	auipc	a4,0x67
    8000946e:	b9670713          	addi	a4,a4,-1130 # 80070000 <disk>
    80009472:	6789                	lui	a5,0x2
    80009474:	97ba                	add	a5,a5,a4
    80009476:	6398                	ld	a4,0(a5)
    80009478:	fec42783          	lw	a5,-20(s0)
    8000947c:	0792                	slli	a5,a5,0x4
    8000947e:	97ba                	add	a5,a5,a4
    80009480:	00079623          	sh	zero,12(a5) # 200c <_entry-0x7fffdff4>
  disk.desc[i].next = 0;
    80009484:	00067717          	auipc	a4,0x67
    80009488:	b7c70713          	addi	a4,a4,-1156 # 80070000 <disk>
    8000948c:	6789                	lui	a5,0x2
    8000948e:	97ba                	add	a5,a5,a4
    80009490:	6398                	ld	a4,0(a5)
    80009492:	fec42783          	lw	a5,-20(s0)
    80009496:	0792                	slli	a5,a5,0x4
    80009498:	97ba                	add	a5,a5,a4
    8000949a:	00079723          	sh	zero,14(a5) # 200e <_entry-0x7fffdff2>
  disk.free[i] = 1;
    8000949e:	00067717          	auipc	a4,0x67
    800094a2:	b6270713          	addi	a4,a4,-1182 # 80070000 <disk>
    800094a6:	fec42783          	lw	a5,-20(s0)
    800094aa:	97ba                	add	a5,a5,a4
    800094ac:	6709                	lui	a4,0x2
    800094ae:	97ba                	add	a5,a5,a4
    800094b0:	4705                	li	a4,1
    800094b2:	00e78c23          	sb	a4,24(a5)
  wakeup(&disk.free[0]);
    800094b6:	00069517          	auipc	a0,0x69
    800094ba:	b6250513          	addi	a0,a0,-1182 # 80072018 <disk+0x2018>
    800094be:	ffffa097          	auipc	ra,0xffffa
    800094c2:	10a080e7          	jalr	266(ra) # 800035c8 <wakeup>
}
    800094c6:	0001                	nop
    800094c8:	60e2                	ld	ra,24(sp)
    800094ca:	6442                	ld	s0,16(sp)
    800094cc:	6105                	addi	sp,sp,32
    800094ce:	8082                	ret

00000000800094d0 <free_chain>:

// free a chain of descriptors.
static void
free_chain(int i)
{
    800094d0:	7179                	addi	sp,sp,-48
    800094d2:	f406                	sd	ra,40(sp)
    800094d4:	f022                	sd	s0,32(sp)
    800094d6:	1800                	addi	s0,sp,48
    800094d8:	87aa                	mv	a5,a0
    800094da:	fcf42e23          	sw	a5,-36(s0)
  while(1){
    int flag = disk.desc[i].flags;
    800094de:	00067717          	auipc	a4,0x67
    800094e2:	b2270713          	addi	a4,a4,-1246 # 80070000 <disk>
    800094e6:	6789                	lui	a5,0x2
    800094e8:	97ba                	add	a5,a5,a4
    800094ea:	6398                	ld	a4,0(a5)
    800094ec:	fdc42783          	lw	a5,-36(s0)
    800094f0:	0792                	slli	a5,a5,0x4
    800094f2:	97ba                	add	a5,a5,a4
    800094f4:	00c7d783          	lhu	a5,12(a5) # 200c <_entry-0x7fffdff4>
    800094f8:	fef42623          	sw	a5,-20(s0)
    int nxt = disk.desc[i].next;
    800094fc:	00067717          	auipc	a4,0x67
    80009500:	b0470713          	addi	a4,a4,-1276 # 80070000 <disk>
    80009504:	6789                	lui	a5,0x2
    80009506:	97ba                	add	a5,a5,a4
    80009508:	6398                	ld	a4,0(a5)
    8000950a:	fdc42783          	lw	a5,-36(s0)
    8000950e:	0792                	slli	a5,a5,0x4
    80009510:	97ba                	add	a5,a5,a4
    80009512:	00e7d783          	lhu	a5,14(a5) # 200e <_entry-0x7fffdff2>
    80009516:	fef42423          	sw	a5,-24(s0)
    free_desc(i);
    8000951a:	fdc42783          	lw	a5,-36(s0)
    8000951e:	853e                	mv	a0,a5
    80009520:	00000097          	auipc	ra,0x0
    80009524:	ec2080e7          	jalr	-318(ra) # 800093e2 <free_desc>
    if(flag & VRING_DESC_F_NEXT)
    80009528:	fec42783          	lw	a5,-20(s0)
    8000952c:	8b85                	andi	a5,a5,1
    8000952e:	2781                	sext.w	a5,a5
    80009530:	c791                	beqz	a5,8000953c <free_chain+0x6c>
      i = nxt;
    80009532:	fe842783          	lw	a5,-24(s0)
    80009536:	fcf42e23          	sw	a5,-36(s0)
  while(1){
    8000953a:	b755                	j	800094de <free_chain+0xe>
    else
      break;
    8000953c:	0001                	nop
  }
}
    8000953e:	0001                	nop
    80009540:	70a2                	ld	ra,40(sp)
    80009542:	7402                	ld	s0,32(sp)
    80009544:	6145                	addi	sp,sp,48
    80009546:	8082                	ret

0000000080009548 <alloc3_desc>:

// allocate three descriptors (they need not be contiguous).
// disk transfers always use three descriptors.
static int
alloc3_desc(int *idx)
{
    80009548:	7139                	addi	sp,sp,-64
    8000954a:	fc06                	sd	ra,56(sp)
    8000954c:	f822                	sd	s0,48(sp)
    8000954e:	f426                	sd	s1,40(sp)
    80009550:	0080                	addi	s0,sp,64
    80009552:	fca43423          	sd	a0,-56(s0)
  for(int i = 0; i < 3; i++){
    80009556:	fc042e23          	sw	zero,-36(s0)
    8000955a:	a895                	j	800095ce <alloc3_desc+0x86>
    idx[i] = alloc_desc();
    8000955c:	fdc42783          	lw	a5,-36(s0)
    80009560:	078a                	slli	a5,a5,0x2
    80009562:	fc843703          	ld	a4,-56(s0)
    80009566:	00f704b3          	add	s1,a4,a5
    8000956a:	00000097          	auipc	ra,0x0
    8000956e:	e16080e7          	jalr	-490(ra) # 80009380 <alloc_desc>
    80009572:	87aa                	mv	a5,a0
    80009574:	c09c                	sw	a5,0(s1)
    if(idx[i] < 0){
    80009576:	fdc42783          	lw	a5,-36(s0)
    8000957a:	078a                	slli	a5,a5,0x2
    8000957c:	fc843703          	ld	a4,-56(s0)
    80009580:	97ba                	add	a5,a5,a4
    80009582:	439c                	lw	a5,0(a5)
    80009584:	0407d063          	bgez	a5,800095c4 <alloc3_desc+0x7c>
      for(int j = 0; j < i; j++)
    80009588:	fc042c23          	sw	zero,-40(s0)
    8000958c:	a015                	j	800095b0 <alloc3_desc+0x68>
        free_desc(idx[j]);
    8000958e:	fd842783          	lw	a5,-40(s0)
    80009592:	078a                	slli	a5,a5,0x2
    80009594:	fc843703          	ld	a4,-56(s0)
    80009598:	97ba                	add	a5,a5,a4
    8000959a:	439c                	lw	a5,0(a5)
    8000959c:	853e                	mv	a0,a5
    8000959e:	00000097          	auipc	ra,0x0
    800095a2:	e44080e7          	jalr	-444(ra) # 800093e2 <free_desc>
      for(int j = 0; j < i; j++)
    800095a6:	fd842783          	lw	a5,-40(s0)
    800095aa:	2785                	addiw	a5,a5,1
    800095ac:	fcf42c23          	sw	a5,-40(s0)
    800095b0:	fd842703          	lw	a4,-40(s0)
    800095b4:	fdc42783          	lw	a5,-36(s0)
    800095b8:	2701                	sext.w	a4,a4
    800095ba:	2781                	sext.w	a5,a5
    800095bc:	fcf749e3          	blt	a4,a5,8000958e <alloc3_desc+0x46>
      return -1;
    800095c0:	57fd                	li	a5,-1
    800095c2:	a831                	j	800095de <alloc3_desc+0x96>
  for(int i = 0; i < 3; i++){
    800095c4:	fdc42783          	lw	a5,-36(s0)
    800095c8:	2785                	addiw	a5,a5,1
    800095ca:	fcf42e23          	sw	a5,-36(s0)
    800095ce:	fdc42783          	lw	a5,-36(s0)
    800095d2:	0007871b          	sext.w	a4,a5
    800095d6:	4789                	li	a5,2
    800095d8:	f8e7d2e3          	bge	a5,a4,8000955c <alloc3_desc+0x14>
    }
  }
  return 0;
    800095dc:	4781                	li	a5,0
}
    800095de:	853e                	mv	a0,a5
    800095e0:	70e2                	ld	ra,56(sp)
    800095e2:	7442                	ld	s0,48(sp)
    800095e4:	74a2                	ld	s1,40(sp)
    800095e6:	6121                	addi	sp,sp,64
    800095e8:	8082                	ret

00000000800095ea <virtio_disk_rw>:

void
virtio_disk_rw(struct buf *b, int write)
{
    800095ea:	7139                	addi	sp,sp,-64
    800095ec:	fc06                	sd	ra,56(sp)
    800095ee:	f822                	sd	s0,48(sp)
    800095f0:	0080                	addi	s0,sp,64
    800095f2:	fca43423          	sd	a0,-56(s0)
    800095f6:	87ae                	mv	a5,a1
    800095f8:	fcf42223          	sw	a5,-60(s0)
  uint64 sector = b->blockno * (BSIZE / 512);
    800095fc:	fc843783          	ld	a5,-56(s0)
    80009600:	47dc                	lw	a5,12(a5)
    80009602:	0017979b          	slliw	a5,a5,0x1
    80009606:	2781                	sext.w	a5,a5
    80009608:	1782                	slli	a5,a5,0x20
    8000960a:	9381                	srli	a5,a5,0x20
    8000960c:	fef43423          	sd	a5,-24(s0)

  acquire(&disk.vdisk_lock);
    80009610:	00069517          	auipc	a0,0x69
    80009614:	b1850513          	addi	a0,a0,-1256 # 80072128 <disk+0x2128>
    80009618:	ffff8097          	auipc	ra,0xffff8
    8000961c:	c68080e7          	jalr	-920(ra) # 80001280 <acquire>
  // data, one for a 1-byte status result.

  // allocate the three descriptors.
  int idx[3];
  while(1){
    if(alloc3_desc(idx) == 0) {
    80009620:	fd040793          	addi	a5,s0,-48
    80009624:	853e                	mv	a0,a5
    80009626:	00000097          	auipc	ra,0x0
    8000962a:	f22080e7          	jalr	-222(ra) # 80009548 <alloc3_desc>
    8000962e:	87aa                	mv	a5,a0
    80009630:	cf91                	beqz	a5,8000964c <virtio_disk_rw+0x62>
      break;
    }
    sleep(&disk.free[0], &disk.vdisk_lock);
    80009632:	00069597          	auipc	a1,0x69
    80009636:	af658593          	addi	a1,a1,-1290 # 80072128 <disk+0x2128>
    8000963a:	00069517          	auipc	a0,0x69
    8000963e:	9de50513          	addi	a0,a0,-1570 # 80072018 <disk+0x2018>
    80009642:	ffffa097          	auipc	ra,0xffffa
    80009646:	ef2080e7          	jalr	-270(ra) # 80003534 <sleep>
    if(alloc3_desc(idx) == 0) {
    8000964a:	bfd9                	j	80009620 <virtio_disk_rw+0x36>
      break;
    8000964c:	0001                	nop
  }

  // format the three descriptors.
  // qemu's virtio-blk.c reads them.

  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    8000964e:	fd042783          	lw	a5,-48(s0)
    80009652:	20078793          	addi	a5,a5,512
    80009656:	00479713          	slli	a4,a5,0x4
    8000965a:	00067797          	auipc	a5,0x67
    8000965e:	9a678793          	addi	a5,a5,-1626 # 80070000 <disk>
    80009662:	97ba                	add	a5,a5,a4
    80009664:	0a878793          	addi	a5,a5,168
    80009668:	fef43023          	sd	a5,-32(s0)

  if(write)
    8000966c:	fc442783          	lw	a5,-60(s0)
    80009670:	2781                	sext.w	a5,a5
    80009672:	c791                	beqz	a5,8000967e <virtio_disk_rw+0x94>
    buf0->type = VIRTIO_BLK_T_OUT; // write the disk
    80009674:	fe043783          	ld	a5,-32(s0)
    80009678:	4705                	li	a4,1
    8000967a:	c398                	sw	a4,0(a5)
    8000967c:	a029                	j	80009686 <virtio_disk_rw+0x9c>
  else
    buf0->type = VIRTIO_BLK_T_IN; // read the disk
    8000967e:	fe043783          	ld	a5,-32(s0)
    80009682:	0007a023          	sw	zero,0(a5)
  buf0->reserved = 0;
    80009686:	fe043783          	ld	a5,-32(s0)
    8000968a:	0007a223          	sw	zero,4(a5)
  buf0->sector = sector;
    8000968e:	fe043783          	ld	a5,-32(s0)
    80009692:	fe843703          	ld	a4,-24(s0)
    80009696:	e798                	sd	a4,8(a5)

  disk.desc[idx[0]].addr = (uint64) buf0;
    80009698:	00067717          	auipc	a4,0x67
    8000969c:	96870713          	addi	a4,a4,-1688 # 80070000 <disk>
    800096a0:	6789                	lui	a5,0x2
    800096a2:	97ba                	add	a5,a5,a4
    800096a4:	6398                	ld	a4,0(a5)
    800096a6:	fd042783          	lw	a5,-48(s0)
    800096aa:	0792                	slli	a5,a5,0x4
    800096ac:	97ba                	add	a5,a5,a4
    800096ae:	fe043703          	ld	a4,-32(s0)
    800096b2:	e398                	sd	a4,0(a5)
  disk.desc[idx[0]].len = sizeof(struct virtio_blk_req);
    800096b4:	00067717          	auipc	a4,0x67
    800096b8:	94c70713          	addi	a4,a4,-1716 # 80070000 <disk>
    800096bc:	6789                	lui	a5,0x2
    800096be:	97ba                	add	a5,a5,a4
    800096c0:	6398                	ld	a4,0(a5)
    800096c2:	fd042783          	lw	a5,-48(s0)
    800096c6:	0792                	slli	a5,a5,0x4
    800096c8:	97ba                	add	a5,a5,a4
    800096ca:	4741                	li	a4,16
    800096cc:	c798                	sw	a4,8(a5)
  disk.desc[idx[0]].flags = VRING_DESC_F_NEXT;
    800096ce:	00067717          	auipc	a4,0x67
    800096d2:	93270713          	addi	a4,a4,-1742 # 80070000 <disk>
    800096d6:	6789                	lui	a5,0x2
    800096d8:	97ba                	add	a5,a5,a4
    800096da:	6398                	ld	a4,0(a5)
    800096dc:	fd042783          	lw	a5,-48(s0)
    800096e0:	0792                	slli	a5,a5,0x4
    800096e2:	97ba                	add	a5,a5,a4
    800096e4:	4705                	li	a4,1
    800096e6:	00e79623          	sh	a4,12(a5) # 200c <_entry-0x7fffdff4>
  disk.desc[idx[0]].next = idx[1];
    800096ea:	fd442683          	lw	a3,-44(s0)
    800096ee:	00067717          	auipc	a4,0x67
    800096f2:	91270713          	addi	a4,a4,-1774 # 80070000 <disk>
    800096f6:	6789                	lui	a5,0x2
    800096f8:	97ba                	add	a5,a5,a4
    800096fa:	6398                	ld	a4,0(a5)
    800096fc:	fd042783          	lw	a5,-48(s0)
    80009700:	0792                	slli	a5,a5,0x4
    80009702:	97ba                	add	a5,a5,a4
    80009704:	03069713          	slli	a4,a3,0x30
    80009708:	9341                	srli	a4,a4,0x30
    8000970a:	00e79723          	sh	a4,14(a5) # 200e <_entry-0x7fffdff2>

  disk.desc[idx[1]].addr = (uint64) b->data;
    8000970e:	fc843783          	ld	a5,-56(s0)
    80009712:	05878693          	addi	a3,a5,88
    80009716:	00067717          	auipc	a4,0x67
    8000971a:	8ea70713          	addi	a4,a4,-1814 # 80070000 <disk>
    8000971e:	6789                	lui	a5,0x2
    80009720:	97ba                	add	a5,a5,a4
    80009722:	6398                	ld	a4,0(a5)
    80009724:	fd442783          	lw	a5,-44(s0)
    80009728:	0792                	slli	a5,a5,0x4
    8000972a:	97ba                	add	a5,a5,a4
    8000972c:	8736                	mv	a4,a3
    8000972e:	e398                	sd	a4,0(a5)
  disk.desc[idx[1]].len = BSIZE;
    80009730:	00067717          	auipc	a4,0x67
    80009734:	8d070713          	addi	a4,a4,-1840 # 80070000 <disk>
    80009738:	6789                	lui	a5,0x2
    8000973a:	97ba                	add	a5,a5,a4
    8000973c:	6398                	ld	a4,0(a5)
    8000973e:	fd442783          	lw	a5,-44(s0)
    80009742:	0792                	slli	a5,a5,0x4
    80009744:	97ba                	add	a5,a5,a4
    80009746:	40000713          	li	a4,1024
    8000974a:	c798                	sw	a4,8(a5)
  if(write)
    8000974c:	fc442783          	lw	a5,-60(s0)
    80009750:	2781                	sext.w	a5,a5
    80009752:	cf99                	beqz	a5,80009770 <virtio_disk_rw+0x186>
    disk.desc[idx[1]].flags = 0; // device reads b->data
    80009754:	00067717          	auipc	a4,0x67
    80009758:	8ac70713          	addi	a4,a4,-1876 # 80070000 <disk>
    8000975c:	6789                	lui	a5,0x2
    8000975e:	97ba                	add	a5,a5,a4
    80009760:	6398                	ld	a4,0(a5)
    80009762:	fd442783          	lw	a5,-44(s0)
    80009766:	0792                	slli	a5,a5,0x4
    80009768:	97ba                	add	a5,a5,a4
    8000976a:	00079623          	sh	zero,12(a5) # 200c <_entry-0x7fffdff4>
    8000976e:	a839                	j	8000978c <virtio_disk_rw+0x1a2>
  else
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
    80009770:	00067717          	auipc	a4,0x67
    80009774:	89070713          	addi	a4,a4,-1904 # 80070000 <disk>
    80009778:	6789                	lui	a5,0x2
    8000977a:	97ba                	add	a5,a5,a4
    8000977c:	6398                	ld	a4,0(a5)
    8000977e:	fd442783          	lw	a5,-44(s0)
    80009782:	0792                	slli	a5,a5,0x4
    80009784:	97ba                	add	a5,a5,a4
    80009786:	4709                	li	a4,2
    80009788:	00e79623          	sh	a4,12(a5) # 200c <_entry-0x7fffdff4>
  disk.desc[idx[1]].flags |= VRING_DESC_F_NEXT;
    8000978c:	00067717          	auipc	a4,0x67
    80009790:	87470713          	addi	a4,a4,-1932 # 80070000 <disk>
    80009794:	6789                	lui	a5,0x2
    80009796:	97ba                	add	a5,a5,a4
    80009798:	6398                	ld	a4,0(a5)
    8000979a:	fd442783          	lw	a5,-44(s0)
    8000979e:	0792                	slli	a5,a5,0x4
    800097a0:	97ba                	add	a5,a5,a4
    800097a2:	00c7d703          	lhu	a4,12(a5) # 200c <_entry-0x7fffdff4>
    800097a6:	00067697          	auipc	a3,0x67
    800097aa:	85a68693          	addi	a3,a3,-1958 # 80070000 <disk>
    800097ae:	6789                	lui	a5,0x2
    800097b0:	97b6                	add	a5,a5,a3
    800097b2:	6394                	ld	a3,0(a5)
    800097b4:	fd442783          	lw	a5,-44(s0)
    800097b8:	0792                	slli	a5,a5,0x4
    800097ba:	97b6                	add	a5,a5,a3
    800097bc:	00176713          	ori	a4,a4,1
    800097c0:	1742                	slli	a4,a4,0x30
    800097c2:	9341                	srli	a4,a4,0x30
    800097c4:	00e79623          	sh	a4,12(a5) # 200c <_entry-0x7fffdff4>
  disk.desc[idx[1]].next = idx[2];
    800097c8:	fd842683          	lw	a3,-40(s0)
    800097cc:	00067717          	auipc	a4,0x67
    800097d0:	83470713          	addi	a4,a4,-1996 # 80070000 <disk>
    800097d4:	6789                	lui	a5,0x2
    800097d6:	97ba                	add	a5,a5,a4
    800097d8:	6398                	ld	a4,0(a5)
    800097da:	fd442783          	lw	a5,-44(s0)
    800097de:	0792                	slli	a5,a5,0x4
    800097e0:	97ba                	add	a5,a5,a4
    800097e2:	03069713          	slli	a4,a3,0x30
    800097e6:	9341                	srli	a4,a4,0x30
    800097e8:	00e79723          	sh	a4,14(a5) # 200e <_entry-0x7fffdff2>

  disk.info[idx[0]].status = 0xff; // device writes 0 on success
    800097ec:	fd042783          	lw	a5,-48(s0)
    800097f0:	00067717          	auipc	a4,0x67
    800097f4:	81070713          	addi	a4,a4,-2032 # 80070000 <disk>
    800097f8:	20078793          	addi	a5,a5,512
    800097fc:	0792                	slli	a5,a5,0x4
    800097fe:	97ba                	add	a5,a5,a4
    80009800:	577d                	li	a4,-1
    80009802:	02e78823          	sb	a4,48(a5)
  disk.desc[idx[2]].addr = (uint64) &disk.info[idx[0]].status;
    80009806:	fd042783          	lw	a5,-48(s0)
    8000980a:	20078793          	addi	a5,a5,512
    8000980e:	00479713          	slli	a4,a5,0x4
    80009812:	00066797          	auipc	a5,0x66
    80009816:	7ee78793          	addi	a5,a5,2030 # 80070000 <disk>
    8000981a:	97ba                	add	a5,a5,a4
    8000981c:	03078693          	addi	a3,a5,48
    80009820:	00066717          	auipc	a4,0x66
    80009824:	7e070713          	addi	a4,a4,2016 # 80070000 <disk>
    80009828:	6789                	lui	a5,0x2
    8000982a:	97ba                	add	a5,a5,a4
    8000982c:	6398                	ld	a4,0(a5)
    8000982e:	fd842783          	lw	a5,-40(s0)
    80009832:	0792                	slli	a5,a5,0x4
    80009834:	97ba                	add	a5,a5,a4
    80009836:	8736                	mv	a4,a3
    80009838:	e398                	sd	a4,0(a5)
  disk.desc[idx[2]].len = 1;
    8000983a:	00066717          	auipc	a4,0x66
    8000983e:	7c670713          	addi	a4,a4,1990 # 80070000 <disk>
    80009842:	6789                	lui	a5,0x2
    80009844:	97ba                	add	a5,a5,a4
    80009846:	6398                	ld	a4,0(a5)
    80009848:	fd842783          	lw	a5,-40(s0)
    8000984c:	0792                	slli	a5,a5,0x4
    8000984e:	97ba                	add	a5,a5,a4
    80009850:	4705                	li	a4,1
    80009852:	c798                	sw	a4,8(a5)
  disk.desc[idx[2]].flags = VRING_DESC_F_WRITE; // device writes the status
    80009854:	00066717          	auipc	a4,0x66
    80009858:	7ac70713          	addi	a4,a4,1964 # 80070000 <disk>
    8000985c:	6789                	lui	a5,0x2
    8000985e:	97ba                	add	a5,a5,a4
    80009860:	6398                	ld	a4,0(a5)
    80009862:	fd842783          	lw	a5,-40(s0)
    80009866:	0792                	slli	a5,a5,0x4
    80009868:	97ba                	add	a5,a5,a4
    8000986a:	4709                	li	a4,2
    8000986c:	00e79623          	sh	a4,12(a5) # 200c <_entry-0x7fffdff4>
  disk.desc[idx[2]].next = 0;
    80009870:	00066717          	auipc	a4,0x66
    80009874:	79070713          	addi	a4,a4,1936 # 80070000 <disk>
    80009878:	6789                	lui	a5,0x2
    8000987a:	97ba                	add	a5,a5,a4
    8000987c:	6398                	ld	a4,0(a5)
    8000987e:	fd842783          	lw	a5,-40(s0)
    80009882:	0792                	slli	a5,a5,0x4
    80009884:	97ba                	add	a5,a5,a4
    80009886:	00079723          	sh	zero,14(a5) # 200e <_entry-0x7fffdff2>

  // record struct buf for virtio_disk_intr().
  b->disk = 1;
    8000988a:	fc843783          	ld	a5,-56(s0)
    8000988e:	4705                	li	a4,1
    80009890:	c3d8                	sw	a4,4(a5)
  disk.info[idx[0]].b = b;
    80009892:	fd042783          	lw	a5,-48(s0)
    80009896:	00066717          	auipc	a4,0x66
    8000989a:	76a70713          	addi	a4,a4,1898 # 80070000 <disk>
    8000989e:	20078793          	addi	a5,a5,512
    800098a2:	0792                	slli	a5,a5,0x4
    800098a4:	97ba                	add	a5,a5,a4
    800098a6:	fc843703          	ld	a4,-56(s0)
    800098aa:	f798                	sd	a4,40(a5)

  // tell the device the first index in our chain of descriptors.
  disk.avail->ring[disk.avail->idx % NUM] = idx[0];
    800098ac:	fd042603          	lw	a2,-48(s0)
    800098b0:	00066717          	auipc	a4,0x66
    800098b4:	75070713          	addi	a4,a4,1872 # 80070000 <disk>
    800098b8:	6789                	lui	a5,0x2
    800098ba:	97ba                	add	a5,a5,a4
    800098bc:	6794                	ld	a3,8(a5)
    800098be:	00066717          	auipc	a4,0x66
    800098c2:	74270713          	addi	a4,a4,1858 # 80070000 <disk>
    800098c6:	6789                	lui	a5,0x2
    800098c8:	97ba                	add	a5,a5,a4
    800098ca:	679c                	ld	a5,8(a5)
    800098cc:	0027d783          	lhu	a5,2(a5) # 2002 <_entry-0x7fffdffe>
    800098d0:	2781                	sext.w	a5,a5
    800098d2:	8b9d                	andi	a5,a5,7
    800098d4:	2781                	sext.w	a5,a5
    800098d6:	03061713          	slli	a4,a2,0x30
    800098da:	9341                	srli	a4,a4,0x30
    800098dc:	0786                	slli	a5,a5,0x1
    800098de:	97b6                	add	a5,a5,a3
    800098e0:	00e79223          	sh	a4,4(a5)

  __sync_synchronize();
    800098e4:	0ff0000f          	fence

  // tell the device another avail ring entry is available.
  disk.avail->idx += 1; // not % NUM ...
    800098e8:	00066717          	auipc	a4,0x66
    800098ec:	71870713          	addi	a4,a4,1816 # 80070000 <disk>
    800098f0:	6789                	lui	a5,0x2
    800098f2:	97ba                	add	a5,a5,a4
    800098f4:	679c                	ld	a5,8(a5)
    800098f6:	0027d703          	lhu	a4,2(a5) # 2002 <_entry-0x7fffdffe>
    800098fa:	00066697          	auipc	a3,0x66
    800098fe:	70668693          	addi	a3,a3,1798 # 80070000 <disk>
    80009902:	6789                	lui	a5,0x2
    80009904:	97b6                	add	a5,a5,a3
    80009906:	679c                	ld	a5,8(a5)
    80009908:	2705                	addiw	a4,a4,1
    8000990a:	1742                	slli	a4,a4,0x30
    8000990c:	9341                	srli	a4,a4,0x30
    8000990e:	00e79123          	sh	a4,2(a5) # 2002 <_entry-0x7fffdffe>

  __sync_synchronize();
    80009912:	0ff0000f          	fence

  *R(VIRTIO_MMIO_QUEUE_NOTIFY) = 0; // value is queue number
    80009916:	100017b7          	lui	a5,0x10001
    8000991a:	05078793          	addi	a5,a5,80 # 10001050 <_entry-0x6fffefb0>
    8000991e:	0007a023          	sw	zero,0(a5)

  // Wait for virtio_disk_intr() to say request has finished.
  while(b->disk == 1) {
    80009922:	a819                	j	80009938 <virtio_disk_rw+0x34e>
    sleep(b, &disk.vdisk_lock);
    80009924:	00069597          	auipc	a1,0x69
    80009928:	80458593          	addi	a1,a1,-2044 # 80072128 <disk+0x2128>
    8000992c:	fc843503          	ld	a0,-56(s0)
    80009930:	ffffa097          	auipc	ra,0xffffa
    80009934:	c04080e7          	jalr	-1020(ra) # 80003534 <sleep>
  while(b->disk == 1) {
    80009938:	fc843783          	ld	a5,-56(s0)
    8000993c:	43dc                	lw	a5,4(a5)
    8000993e:	873e                	mv	a4,a5
    80009940:	4785                	li	a5,1
    80009942:	fef701e3          	beq	a4,a5,80009924 <virtio_disk_rw+0x33a>
  }

  disk.info[idx[0]].b = 0;
    80009946:	fd042783          	lw	a5,-48(s0)
    8000994a:	00066717          	auipc	a4,0x66
    8000994e:	6b670713          	addi	a4,a4,1718 # 80070000 <disk>
    80009952:	20078793          	addi	a5,a5,512
    80009956:	0792                	slli	a5,a5,0x4
    80009958:	97ba                	add	a5,a5,a4
    8000995a:	0207b423          	sd	zero,40(a5)
  free_chain(idx[0]);
    8000995e:	fd042783          	lw	a5,-48(s0)
    80009962:	853e                	mv	a0,a5
    80009964:	00000097          	auipc	ra,0x0
    80009968:	b6c080e7          	jalr	-1172(ra) # 800094d0 <free_chain>

  release(&disk.vdisk_lock);
    8000996c:	00068517          	auipc	a0,0x68
    80009970:	7bc50513          	addi	a0,a0,1980 # 80072128 <disk+0x2128>
    80009974:	ffff8097          	auipc	ra,0xffff8
    80009978:	970080e7          	jalr	-1680(ra) # 800012e4 <release>
}
    8000997c:	0001                	nop
    8000997e:	70e2                	ld	ra,56(sp)
    80009980:	7442                	ld	s0,48(sp)
    80009982:	6121                	addi	sp,sp,64
    80009984:	8082                	ret

0000000080009986 <virtio_disk_intr>:

void
virtio_disk_intr()
{
    80009986:	1101                	addi	sp,sp,-32
    80009988:	ec06                	sd	ra,24(sp)
    8000998a:	e822                	sd	s0,16(sp)
    8000998c:	1000                	addi	s0,sp,32
  acquire(&disk.vdisk_lock);
    8000998e:	00068517          	auipc	a0,0x68
    80009992:	79a50513          	addi	a0,a0,1946 # 80072128 <disk+0x2128>
    80009996:	ffff8097          	auipc	ra,0xffff8
    8000999a:	8ea080e7          	jalr	-1814(ra) # 80001280 <acquire>
  // we've seen this interrupt, which the following line does.
  // this may race with the device writing new entries to
  // the "used" ring, in which case we may process the new
  // completion entries in this interrupt, and have nothing to do
  // in the next interrupt, which is harmless.
  *R(VIRTIO_MMIO_INTERRUPT_ACK) = *R(VIRTIO_MMIO_INTERRUPT_STATUS) & 0x3;
    8000999e:	100017b7          	lui	a5,0x10001
    800099a2:	06078793          	addi	a5,a5,96 # 10001060 <_entry-0x6fffefa0>
    800099a6:	439c                	lw	a5,0(a5)
    800099a8:	0007871b          	sext.w	a4,a5
    800099ac:	100017b7          	lui	a5,0x10001
    800099b0:	06478793          	addi	a5,a5,100 # 10001064 <_entry-0x6fffef9c>
    800099b4:	8b0d                	andi	a4,a4,3
    800099b6:	2701                	sext.w	a4,a4
    800099b8:	c398                	sw	a4,0(a5)

  __sync_synchronize();
    800099ba:	0ff0000f          	fence

  // the device increments disk.used->idx when it
  // adds an entry to the used ring.

  while(disk.used_idx != disk.used->idx){
    800099be:	a855                	j	80009a72 <virtio_disk_intr+0xec>
    __sync_synchronize();
    800099c0:	0ff0000f          	fence
    int id = disk.used->ring[disk.used_idx % NUM].id;
    800099c4:	00066717          	auipc	a4,0x66
    800099c8:	63c70713          	addi	a4,a4,1596 # 80070000 <disk>
    800099cc:	6789                	lui	a5,0x2
    800099ce:	97ba                	add	a5,a5,a4
    800099d0:	6b98                	ld	a4,16(a5)
    800099d2:	00066697          	auipc	a3,0x66
    800099d6:	62e68693          	addi	a3,a3,1582 # 80070000 <disk>
    800099da:	6789                	lui	a5,0x2
    800099dc:	97b6                	add	a5,a5,a3
    800099de:	0207d783          	lhu	a5,32(a5) # 2020 <_entry-0x7fffdfe0>
    800099e2:	2781                	sext.w	a5,a5
    800099e4:	8b9d                	andi	a5,a5,7
    800099e6:	2781                	sext.w	a5,a5
    800099e8:	078e                	slli	a5,a5,0x3
    800099ea:	97ba                	add	a5,a5,a4
    800099ec:	43dc                	lw	a5,4(a5)
    800099ee:	fef42623          	sw	a5,-20(s0)

    if(disk.info[id].status != 0)
    800099f2:	00066717          	auipc	a4,0x66
    800099f6:	60e70713          	addi	a4,a4,1550 # 80070000 <disk>
    800099fa:	fec42783          	lw	a5,-20(s0)
    800099fe:	20078793          	addi	a5,a5,512
    80009a02:	0792                	slli	a5,a5,0x4
    80009a04:	97ba                	add	a5,a5,a4
    80009a06:	0307c783          	lbu	a5,48(a5)
    80009a0a:	cb89                	beqz	a5,80009a1c <virtio_disk_intr+0x96>
      panic("virtio_disk_intr status");
    80009a0c:	00003517          	auipc	a0,0x3
    80009a10:	d2450513          	addi	a0,a0,-732 # 8000c730 <etext+0x730>
    80009a14:	ffff7097          	auipc	ra,0xffff7
    80009a18:	23e080e7          	jalr	574(ra) # 80000c52 <panic>

    struct buf *b = disk.info[id].b;
    80009a1c:	00066717          	auipc	a4,0x66
    80009a20:	5e470713          	addi	a4,a4,1508 # 80070000 <disk>
    80009a24:	fec42783          	lw	a5,-20(s0)
    80009a28:	20078793          	addi	a5,a5,512
    80009a2c:	0792                	slli	a5,a5,0x4
    80009a2e:	97ba                	add	a5,a5,a4
    80009a30:	779c                	ld	a5,40(a5)
    80009a32:	fef43023          	sd	a5,-32(s0)
    b->disk = 0;   // disk is done with buf
    80009a36:	fe043783          	ld	a5,-32(s0)
    80009a3a:	0007a223          	sw	zero,4(a5)
    wakeup(b);
    80009a3e:	fe043503          	ld	a0,-32(s0)
    80009a42:	ffffa097          	auipc	ra,0xffffa
    80009a46:	b86080e7          	jalr	-1146(ra) # 800035c8 <wakeup>

    disk.used_idx += 1;
    80009a4a:	00066717          	auipc	a4,0x66
    80009a4e:	5b670713          	addi	a4,a4,1462 # 80070000 <disk>
    80009a52:	6789                	lui	a5,0x2
    80009a54:	97ba                	add	a5,a5,a4
    80009a56:	0207d783          	lhu	a5,32(a5) # 2020 <_entry-0x7fffdfe0>
    80009a5a:	2785                	addiw	a5,a5,1
    80009a5c:	03079713          	slli	a4,a5,0x30
    80009a60:	9341                	srli	a4,a4,0x30
    80009a62:	00066697          	auipc	a3,0x66
    80009a66:	59e68693          	addi	a3,a3,1438 # 80070000 <disk>
    80009a6a:	6789                	lui	a5,0x2
    80009a6c:	97b6                	add	a5,a5,a3
    80009a6e:	02e79023          	sh	a4,32(a5) # 2020 <_entry-0x7fffdfe0>
  while(disk.used_idx != disk.used->idx){
    80009a72:	00066717          	auipc	a4,0x66
    80009a76:	58e70713          	addi	a4,a4,1422 # 80070000 <disk>
    80009a7a:	6789                	lui	a5,0x2
    80009a7c:	97ba                	add	a5,a5,a4
    80009a7e:	0207d683          	lhu	a3,32(a5) # 2020 <_entry-0x7fffdfe0>
    80009a82:	00066717          	auipc	a4,0x66
    80009a86:	57e70713          	addi	a4,a4,1406 # 80070000 <disk>
    80009a8a:	6789                	lui	a5,0x2
    80009a8c:	97ba                	add	a5,a5,a4
    80009a8e:	6b9c                	ld	a5,16(a5)
    80009a90:	0027d783          	lhu	a5,2(a5) # 2002 <_entry-0x7fffdffe>
    80009a94:	0006871b          	sext.w	a4,a3
    80009a98:	2781                	sext.w	a5,a5
    80009a9a:	f2f713e3          	bne	a4,a5,800099c0 <virtio_disk_intr+0x3a>
  }

  release(&disk.vdisk_lock);
    80009a9e:	00068517          	auipc	a0,0x68
    80009aa2:	68a50513          	addi	a0,a0,1674 # 80072128 <disk+0x2128>
    80009aa6:	ffff8097          	auipc	ra,0xffff8
    80009aaa:	83e080e7          	jalr	-1986(ra) # 800012e4 <release>
}
    80009aae:	0001                	nop
    80009ab0:	60e2                	ld	ra,24(sp)
    80009ab2:	6442                	ld	s0,16(sp)
    80009ab4:	6105                	addi	sp,sp,32
    80009ab6:	8082                	ret

0000000080009ab8 <sys_thrdstop>:
#include "proc.h"

// for mp3
uint64
sys_thrdstop(void)
{
    80009ab8:	7139                	addi	sp,sp,-64
    80009aba:	fc06                	sd	ra,56(sp)
    80009abc:	f822                	sd	s0,48(sp)
    80009abe:	0080                	addi	s0,sp,64
  int delay;
  uint64 context_id_ptr;
  uint64 handler, handler_arg;
  if (argint(0, &delay) < 0)
    80009ac0:	fe440793          	addi	a5,s0,-28
    80009ac4:	85be                	mv	a1,a5
    80009ac6:	4501                	li	a0,0
    80009ac8:	ffffb097          	auipc	ra,0xffffb
    80009acc:	cea080e7          	jalr	-790(ra) # 800047b2 <argint>
    80009ad0:	87aa                	mv	a5,a0
    80009ad2:	0007d463          	bgez	a5,80009ada <sys_thrdstop+0x22>
    return -1;
    80009ad6:	57fd                	li	a5,-1
    80009ad8:	a241                	j	80009c58 <sys_thrdstop+0x1a0>
  if (argaddr(1, &context_id_ptr) < 0)
    80009ada:	fd840793          	addi	a5,s0,-40
    80009ade:	85be                	mv	a1,a5
    80009ae0:	4505                	li	a0,1
    80009ae2:	ffffb097          	auipc	ra,0xffffb
    80009ae6:	d08080e7          	jalr	-760(ra) # 800047ea <argaddr>
    80009aea:	87aa                	mv	a5,a0
    80009aec:	0007d463          	bgez	a5,80009af4 <sys_thrdstop+0x3c>
    return -1;
    80009af0:	57fd                	li	a5,-1
    80009af2:	a29d                	j	80009c58 <sys_thrdstop+0x1a0>
  if (argaddr(2, &handler) < 0)
    80009af4:	fd040793          	addi	a5,s0,-48
    80009af8:	85be                	mv	a1,a5
    80009afa:	4509                	li	a0,2
    80009afc:	ffffb097          	auipc	ra,0xffffb
    80009b00:	cee080e7          	jalr	-786(ra) # 800047ea <argaddr>
    80009b04:	87aa                	mv	a5,a0
    80009b06:	0007d463          	bgez	a5,80009b0e <sys_thrdstop+0x56>
    return -1;
    80009b0a:	57fd                	li	a5,-1
    80009b0c:	a2b1                	j	80009c58 <sys_thrdstop+0x1a0>
  if (argaddr(3, &handler_arg) < 0)
    80009b0e:	fc840793          	addi	a5,s0,-56
    80009b12:	85be                	mv	a1,a5
    80009b14:	450d                	li	a0,3
    80009b16:	ffffb097          	auipc	ra,0xffffb
    80009b1a:	cd4080e7          	jalr	-812(ra) # 800047ea <argaddr>
    80009b1e:	87aa                	mv	a5,a0
    80009b20:	0007d463          	bgez	a5,80009b28 <sys_thrdstop+0x70>
    return -1;
    80009b24:	57fd                	li	a5,-1
    80009b26:	aa0d                	j	80009c58 <sys_thrdstop+0x1a0>
  
  struct proc *proc = myproc();
    80009b28:	ffff9097          	auipc	ra,0xffff9
    80009b2c:	cd0080e7          	jalr	-816(ra) # 800027f8 <myproc>
    80009b30:	fea43423          	sd	a0,-24(s0)
  //TODO: mp3

  // handle context id
  int thrd_context_id = 0;
    80009b34:	fc042223          	sw	zero,-60(s0)
  copyin(proc->pagetable, (char*)&thrd_context_id, context_id_ptr, sizeof(int));
    80009b38:	fe843703          	ld	a4,-24(s0)
    80009b3c:	6785                	lui	a5,0x1
    80009b3e:	97ba                	add	a5,a5,a4
    80009b40:	2b07b783          	ld	a5,688(a5) # 12b0 <_entry-0x7fffed50>
    80009b44:	fd843603          	ld	a2,-40(s0)
    80009b48:	fc440713          	addi	a4,s0,-60
    80009b4c:	4691                	li	a3,4
    80009b4e:	85ba                	mv	a1,a4
    80009b50:	853e                	mv	a0,a5
    80009b52:	ffff9097          	auipc	ra,0xffff9
    80009b56:	850080e7          	jalr	-1968(ra) # 800023a2 <copyin>
  // now thrd_context_id is the value from user space

  if(thrd_context_id == -1){
    80009b5a:	fc442783          	lw	a5,-60(s0)
    80009b5e:	873e                	mv	a4,a5
    80009b60:	57fd                	li	a5,-1
    80009b62:	0af71463          	bne	a4,a5,80009c0a <sys_thrdstop+0x152>
    for(int i=0; i<MAX_THRD_NUM; i++){
    80009b66:	fc042023          	sw	zero,-64(s0)
    80009b6a:	a841                	j	80009bfa <sys_thrdstop+0x142>
      if(!(proc->thrd_context_used[i])){
    80009b6c:	fc042783          	lw	a5,-64(s0)
    80009b70:	fe843703          	ld	a4,-24(s0)
    80009b74:	49878793          	addi	a5,a5,1176
    80009b78:	078a                	slli	a5,a5,0x2
    80009b7a:	97ba                	add	a5,a5,a4
    80009b7c:	439c                	lw	a5,0(a5)
    80009b7e:	eba5                	bnez	a5,80009bee <sys_thrdstop+0x136>
        // use this as context id
        proc->thrd_context_used[i] = 1;
    80009b80:	fc042783          	lw	a5,-64(s0)
    80009b84:	fe843703          	ld	a4,-24(s0)
    80009b88:	49878793          	addi	a5,a5,1176
    80009b8c:	078a                	slli	a5,a5,0x2
    80009b8e:	97ba                	add	a5,a5,a4
    80009b90:	4705                	li	a4,1
    80009b92:	c398                	sw	a4,0(a5)
        proc->thrd_context_id = i;
    80009b94:	fc042703          	lw	a4,-64(s0)
    80009b98:	fe843783          	ld	a5,-24(s0)
    80009b9c:	cfb8                	sw	a4,88(a5)

        // use copyout to modify context_id_ptr
        copyout(proc->pagetable, context_id_ptr, (char*)&i, sizeof(int));
    80009b9e:	fe843703          	ld	a4,-24(s0)
    80009ba2:	6785                	lui	a5,0x1
    80009ba4:	97ba                	add	a5,a5,a4
    80009ba6:	2b07b783          	ld	a5,688(a5) # 12b0 <_entry-0x7fffed50>
    80009baa:	fd843703          	ld	a4,-40(s0)
    80009bae:	fc040613          	addi	a2,s0,-64
    80009bb2:	4691                	li	a3,4
    80009bb4:	85ba                	mv	a1,a4
    80009bb6:	853e                	mv	a0,a5
    80009bb8:	ffff8097          	auipc	ra,0xffff8
    80009bbc:	71c080e7          	jalr	1820(ra) # 800022d4 <copyout>

        // write in the argument
        proc->delay = delay;
    80009bc0:	fe442703          	lw	a4,-28(s0)
    80009bc4:	fe843783          	ld	a5,-24(s0)
    80009bc8:	c3b8                	sw	a4,64(a5)
        proc->timer_elapsed = 0;
    80009bca:	fe843783          	ld	a5,-24(s0)
    80009bce:	0207ae23          	sw	zero,60(a5)
        proc->handler = (void*)handler;
    80009bd2:	fd043783          	ld	a5,-48(s0)
    80009bd6:	873e                	mv	a4,a5
    80009bd8:	fe843783          	ld	a5,-24(s0)
    80009bdc:	e7b8                	sd	a4,72(a5)
        proc->handler_arg = (void*)handler_arg;
    80009bde:	fc843783          	ld	a5,-56(s0)
    80009be2:	873e                	mv	a4,a5
    80009be4:	fe843783          	ld	a5,-24(s0)
    80009be8:	ebb8                	sd	a4,80(a5)
        return 0;
    80009bea:	4781                	li	a5,0
    80009bec:	a0b5                	j	80009c58 <sys_thrdstop+0x1a0>
    for(int i=0; i<MAX_THRD_NUM; i++){
    80009bee:	fc042783          	lw	a5,-64(s0)
    80009bf2:	2785                	addiw	a5,a5,1
    80009bf4:	2781                	sext.w	a5,a5
    80009bf6:	fcf42023          	sw	a5,-64(s0)
    80009bfa:	fc042783          	lw	a5,-64(s0)
    80009bfe:	873e                	mv	a4,a5
    80009c00:	47bd                	li	a5,15
    80009c02:	f6e7d5e3          	bge	a5,a4,80009b6c <sys_thrdstop+0xb4>
      }
    }
    return -1; // all has been assigned
    80009c06:	57fd                	li	a5,-1
    80009c08:	a881                	j	80009c58 <sys_thrdstop+0x1a0>
  }else{
    // context id is available
    if(!(proc->thrd_context_used[thrd_context_id])){
    80009c0a:	fc442783          	lw	a5,-60(s0)
    80009c0e:	fe843703          	ld	a4,-24(s0)
    80009c12:	49878793          	addi	a5,a5,1176
    80009c16:	078a                	slli	a5,a5,0x2
    80009c18:	97ba                	add	a5,a5,a4
    80009c1a:	439c                	lw	a5,0(a5)
    80009c1c:	e399                	bnez	a5,80009c22 <sys_thrdstop+0x16a>
      return -1;
    80009c1e:	57fd                	li	a5,-1
    80009c20:	a825                	j	80009c58 <sys_thrdstop+0x1a0>
    }
    proc->thrd_context_id = thrd_context_id;
    80009c22:	fc442703          	lw	a4,-60(s0)
    80009c26:	fe843783          	ld	a5,-24(s0)
    80009c2a:	cfb8                	sw	a4,88(a5)
    proc->delay = delay;
    80009c2c:	fe442703          	lw	a4,-28(s0)
    80009c30:	fe843783          	ld	a5,-24(s0)
    80009c34:	c3b8                	sw	a4,64(a5)
    proc->timer_elapsed = 0;
    80009c36:	fe843783          	ld	a5,-24(s0)
    80009c3a:	0207ae23          	sw	zero,60(a5)
    proc->handler = (void*)handler;
    80009c3e:	fd043783          	ld	a5,-48(s0)
    80009c42:	873e                	mv	a4,a5
    80009c44:	fe843783          	ld	a5,-24(s0)
    80009c48:	e7b8                	sd	a4,72(a5)
    proc->handler_arg = (void*)handler_arg;
    80009c4a:	fc843783          	ld	a5,-56(s0)
    80009c4e:	873e                	mv	a4,a5
    80009c50:	fe843783          	ld	a5,-24(s0)
    80009c54:	ebb8                	sd	a4,80(a5)
    return 0;
    80009c56:	4781                	li	a5,0
  }
}
    80009c58:	853e                	mv	a0,a5
    80009c5a:	70e2                	ld	ra,56(sp)
    80009c5c:	7442                	ld	s0,48(sp)
    80009c5e:	6121                	addi	sp,sp,64
    80009c60:	8082                	ret

0000000080009c62 <sys_cancelthrdstop>:

// for mp3
uint64
sys_cancelthrdstop(void)
{
    80009c62:	7179                	addi	sp,sp,-48
    80009c64:	f406                	sd	ra,40(sp)
    80009c66:	f022                	sd	s0,32(sp)
    80009c68:	1800                	addi	s0,sp,48
  int context_id, is_exit;
  if (argint(0, &context_id) < 0)
    80009c6a:	fdc40793          	addi	a5,s0,-36
    80009c6e:	85be                	mv	a1,a5
    80009c70:	4501                	li	a0,0
    80009c72:	ffffb097          	auipc	ra,0xffffb
    80009c76:	b40080e7          	jalr	-1216(ra) # 800047b2 <argint>
    80009c7a:	87aa                	mv	a5,a0
    80009c7c:	0007d463          	bgez	a5,80009c84 <sys_cancelthrdstop+0x22>
    return -1;
    80009c80:	57fd                	li	a5,-1
    80009c82:	a7c1                	j	8000a442 <sys_cancelthrdstop+0x7e0>
  if (argint(1, &is_exit) < 0)
    80009c84:	fd840793          	addi	a5,s0,-40
    80009c88:	85be                	mv	a1,a5
    80009c8a:	4505                	li	a0,1
    80009c8c:	ffffb097          	auipc	ra,0xffffb
    80009c90:	b26080e7          	jalr	-1242(ra) # 800047b2 <argint>
    80009c94:	87aa                	mv	a5,a0
    80009c96:	0007d463          	bgez	a5,80009c9e <sys_cancelthrdstop+0x3c>
    return -1;
    80009c9a:	57fd                	li	a5,-1
    80009c9c:	a75d                	j	8000a442 <sys_cancelthrdstop+0x7e0>

  if (context_id < 0 || context_id >= MAX_THRD_NUM) {
    80009c9e:	fdc42783          	lw	a5,-36(s0)
    80009ca2:	0007c863          	bltz	a5,80009cb2 <sys_cancelthrdstop+0x50>
    80009ca6:	fdc42783          	lw	a5,-36(s0)
    80009caa:	873e                	mv	a4,a5
    80009cac:	47bd                	li	a5,15
    80009cae:	00e7d463          	bge	a5,a4,80009cb6 <sys_cancelthrdstop+0x54>
    return -1;
    80009cb2:	57fd                	li	a5,-1
    80009cb4:	a779                	j	8000a442 <sys_cancelthrdstop+0x7e0>
  }

  struct proc *proc = myproc();
    80009cb6:	ffff9097          	auipc	ra,0xffff9
    80009cba:	b42080e7          	jalr	-1214(ra) # 800027f8 <myproc>
    80009cbe:	fea43423          	sd	a0,-24(s0)

  //TODO: mp3

  //cancels the registered handler
  uint64 time_left;
  time_left = (uint64)proc->timer_elapsed;
    80009cc2:	fe843783          	ld	a5,-24(s0)
    80009cc6:	5fdc                	lw	a5,60(a5)
    80009cc8:	fef43023          	sd	a5,-32(s0)

  proc->delay = -1;
    80009ccc:	fe843783          	ld	a5,-24(s0)
    80009cd0:	577d                	li	a4,-1
    80009cd2:	c3b8                	sw	a4,64(a5)
  proc->timer_elapsed = 0;
    80009cd4:	fe843783          	ld	a5,-24(s0)
    80009cd8:	0207ae23          	sw	zero,60(a5)
  proc->handler = 0;
    80009cdc:	fe843783          	ld	a5,-24(s0)
    80009ce0:	0407b423          	sd	zero,72(a5)
  proc->handler_arg = 0;
    80009ce4:	fe843783          	ld	a5,-24(s0)
    80009ce8:	0407b823          	sd	zero,80(a5)

  if(is_exit == 0){
    80009cec:	fd842783          	lw	a5,-40(s0)
    80009cf0:	46079963          	bnez	a5,8000a162 <sys_cancelthrdstop+0x500>
    // store trapframe into context according to context id
      proc->thrd_context[context_id].s0 = proc->trapframe->s0;
    80009cf4:	fe843703          	ld	a4,-24(s0)
    80009cf8:	6785                	lui	a5,0x1
    80009cfa:	97ba                	add	a5,a5,a4
    80009cfc:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80009d00:	fdc42703          	lw	a4,-36(s0)
    80009d04:	73b4                	ld	a3,96(a5)
    80009d06:	fe843603          	ld	a2,-24(s0)
    80009d0a:	87ba                	mv	a5,a4
    80009d0c:	078e                	slli	a5,a5,0x3
    80009d0e:	97ba                	add	a5,a5,a4
    80009d10:	0796                	slli	a5,a5,0x5
    80009d12:	97b2                	add	a5,a5,a2
    80009d14:	e3f4                	sd	a3,192(a5)
      proc->thrd_context[context_id].s1 = proc->trapframe->s1;
    80009d16:	fe843703          	ld	a4,-24(s0)
    80009d1a:	6785                	lui	a5,0x1
    80009d1c:	97ba                	add	a5,a5,a4
    80009d1e:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80009d22:	fdc42703          	lw	a4,-36(s0)
    80009d26:	77b4                	ld	a3,104(a5)
    80009d28:	fe843603          	ld	a2,-24(s0)
    80009d2c:	87ba                	mv	a5,a4
    80009d2e:	078e                	slli	a5,a5,0x3
    80009d30:	97ba                	add	a5,a5,a4
    80009d32:	0796                	slli	a5,a5,0x5
    80009d34:	97b2                	add	a5,a5,a2
    80009d36:	e7f4                	sd	a3,200(a5)
      proc->thrd_context[context_id].s2 = proc->trapframe->s2;
    80009d38:	fe843703          	ld	a4,-24(s0)
    80009d3c:	6785                	lui	a5,0x1
    80009d3e:	97ba                	add	a5,a5,a4
    80009d40:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80009d44:	fdc42703          	lw	a4,-36(s0)
    80009d48:	7bd4                	ld	a3,176(a5)
    80009d4a:	fe843603          	ld	a2,-24(s0)
    80009d4e:	87ba                	mv	a5,a4
    80009d50:	078e                	slli	a5,a5,0x3
    80009d52:	97ba                	add	a5,a5,a4
    80009d54:	0796                	slli	a5,a5,0x5
    80009d56:	97b2                	add	a5,a5,a2
    80009d58:	10d7b823          	sd	a3,272(a5)
      proc->thrd_context[context_id].s3 = proc->trapframe->s3;
    80009d5c:	fe843703          	ld	a4,-24(s0)
    80009d60:	6785                	lui	a5,0x1
    80009d62:	97ba                	add	a5,a5,a4
    80009d64:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80009d68:	fdc42703          	lw	a4,-36(s0)
    80009d6c:	7fd4                	ld	a3,184(a5)
    80009d6e:	fe843603          	ld	a2,-24(s0)
    80009d72:	87ba                	mv	a5,a4
    80009d74:	078e                	slli	a5,a5,0x3
    80009d76:	97ba                	add	a5,a5,a4
    80009d78:	0796                	slli	a5,a5,0x5
    80009d7a:	97b2                	add	a5,a5,a2
    80009d7c:	10d7bc23          	sd	a3,280(a5)
      proc->thrd_context[context_id].s4 = proc->trapframe->s4;
    80009d80:	fe843703          	ld	a4,-24(s0)
    80009d84:	6785                	lui	a5,0x1
    80009d86:	97ba                	add	a5,a5,a4
    80009d88:	2b87b703          	ld	a4,696(a5) # 12b8 <_entry-0x7fffed48>
    80009d8c:	fdc42783          	lw	a5,-36(s0)
    80009d90:	6374                	ld	a3,192(a4)
    80009d92:	fe843603          	ld	a2,-24(s0)
    80009d96:	00178713          	addi	a4,a5,1
    80009d9a:	87ba                	mv	a5,a4
    80009d9c:	078e                	slli	a5,a5,0x3
    80009d9e:	97ba                	add	a5,a5,a4
    80009da0:	0796                	slli	a5,a5,0x5
    80009da2:	97b2                	add	a5,a5,a2
    80009da4:	e394                	sd	a3,0(a5)
      proc->thrd_context[context_id].s5 = proc->trapframe->s5;
    80009da6:	fe843703          	ld	a4,-24(s0)
    80009daa:	6785                	lui	a5,0x1
    80009dac:	97ba                	add	a5,a5,a4
    80009dae:	2b87b703          	ld	a4,696(a5) # 12b8 <_entry-0x7fffed48>
    80009db2:	fdc42783          	lw	a5,-36(s0)
    80009db6:	6774                	ld	a3,200(a4)
    80009db8:	fe843603          	ld	a2,-24(s0)
    80009dbc:	00178713          	addi	a4,a5,1
    80009dc0:	87ba                	mv	a5,a4
    80009dc2:	078e                	slli	a5,a5,0x3
    80009dc4:	97ba                	add	a5,a5,a4
    80009dc6:	0796                	slli	a5,a5,0x5
    80009dc8:	97b2                	add	a5,a5,a2
    80009dca:	e794                	sd	a3,8(a5)
      proc->thrd_context[context_id].s6 = proc->trapframe->s6;
    80009dcc:	fe843703          	ld	a4,-24(s0)
    80009dd0:	6785                	lui	a5,0x1
    80009dd2:	97ba                	add	a5,a5,a4
    80009dd4:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80009dd8:	fdc42703          	lw	a4,-36(s0)
    80009ddc:	6bf4                	ld	a3,208(a5)
    80009dde:	fe843603          	ld	a2,-24(s0)
    80009de2:	87ba                	mv	a5,a4
    80009de4:	078e                	slli	a5,a5,0x3
    80009de6:	97ba                	add	a5,a5,a4
    80009de8:	0796                	slli	a5,a5,0x5
    80009dea:	97b2                	add	a5,a5,a2
    80009dec:	12d7b823          	sd	a3,304(a5)
      proc->thrd_context[context_id].s7 = proc->trapframe->s7;
    80009df0:	fe843703          	ld	a4,-24(s0)
    80009df4:	6785                	lui	a5,0x1
    80009df6:	97ba                	add	a5,a5,a4
    80009df8:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80009dfc:	fdc42703          	lw	a4,-36(s0)
    80009e00:	6ff4                	ld	a3,216(a5)
    80009e02:	fe843603          	ld	a2,-24(s0)
    80009e06:	87ba                	mv	a5,a4
    80009e08:	078e                	slli	a5,a5,0x3
    80009e0a:	97ba                	add	a5,a5,a4
    80009e0c:	0796                	slli	a5,a5,0x5
    80009e0e:	97b2                	add	a5,a5,a2
    80009e10:	12d7bc23          	sd	a3,312(a5)
      proc->thrd_context[context_id].s8 = proc->trapframe->s8;
    80009e14:	fe843703          	ld	a4,-24(s0)
    80009e18:	6785                	lui	a5,0x1
    80009e1a:	97ba                	add	a5,a5,a4
    80009e1c:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80009e20:	fdc42703          	lw	a4,-36(s0)
    80009e24:	73f4                	ld	a3,224(a5)
    80009e26:	fe843603          	ld	a2,-24(s0)
    80009e2a:	87ba                	mv	a5,a4
    80009e2c:	078e                	slli	a5,a5,0x3
    80009e2e:	97ba                	add	a5,a5,a4
    80009e30:	0796                	slli	a5,a5,0x5
    80009e32:	97b2                	add	a5,a5,a2
    80009e34:	14d7b023          	sd	a3,320(a5)
      proc->thrd_context[context_id].s9 = proc->trapframe->s9;
    80009e38:	fe843703          	ld	a4,-24(s0)
    80009e3c:	6785                	lui	a5,0x1
    80009e3e:	97ba                	add	a5,a5,a4
    80009e40:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80009e44:	fdc42703          	lw	a4,-36(s0)
    80009e48:	77f4                	ld	a3,232(a5)
    80009e4a:	fe843603          	ld	a2,-24(s0)
    80009e4e:	87ba                	mv	a5,a4
    80009e50:	078e                	slli	a5,a5,0x3
    80009e52:	97ba                	add	a5,a5,a4
    80009e54:	0796                	slli	a5,a5,0x5
    80009e56:	97b2                	add	a5,a5,a2
    80009e58:	14d7b423          	sd	a3,328(a5)
      proc->thrd_context[context_id].s10 = proc->trapframe->s10;
    80009e5c:	fe843703          	ld	a4,-24(s0)
    80009e60:	6785                	lui	a5,0x1
    80009e62:	97ba                	add	a5,a5,a4
    80009e64:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80009e68:	fdc42703          	lw	a4,-36(s0)
    80009e6c:	7bf4                	ld	a3,240(a5)
    80009e6e:	fe843603          	ld	a2,-24(s0)
    80009e72:	87ba                	mv	a5,a4
    80009e74:	078e                	slli	a5,a5,0x3
    80009e76:	97ba                	add	a5,a5,a4
    80009e78:	0796                	slli	a5,a5,0x5
    80009e7a:	97b2                	add	a5,a5,a2
    80009e7c:	14d7b823          	sd	a3,336(a5)
      proc->thrd_context[context_id].s11 = proc->trapframe->s11;
    80009e80:	fe843703          	ld	a4,-24(s0)
    80009e84:	6785                	lui	a5,0x1
    80009e86:	97ba                	add	a5,a5,a4
    80009e88:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80009e8c:	fdc42703          	lw	a4,-36(s0)
    80009e90:	7ff4                	ld	a3,248(a5)
    80009e92:	fe843603          	ld	a2,-24(s0)
    80009e96:	87ba                	mv	a5,a4
    80009e98:	078e                	slli	a5,a5,0x3
    80009e9a:	97ba                	add	a5,a5,a4
    80009e9c:	0796                	slli	a5,a5,0x5
    80009e9e:	97b2                	add	a5,a5,a2
    80009ea0:	14d7bc23          	sd	a3,344(a5)
      proc->thrd_context[context_id].ra = proc->trapframe->ra;
    80009ea4:	fe843703          	ld	a4,-24(s0)
    80009ea8:	6785                	lui	a5,0x1
    80009eaa:	97ba                	add	a5,a5,a4
    80009eac:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80009eb0:	fdc42703          	lw	a4,-36(s0)
    80009eb4:	7794                	ld	a3,40(a5)
    80009eb6:	fe843603          	ld	a2,-24(s0)
    80009eba:	87ba                	mv	a5,a4
    80009ebc:	078e                	slli	a5,a5,0x3
    80009ebe:	97ba                	add	a5,a5,a4
    80009ec0:	0796                	slli	a5,a5,0x5
    80009ec2:	97b2                	add	a5,a5,a2
    80009ec4:	e7d4                	sd	a3,136(a5)
      proc->thrd_context[context_id].sp = proc->trapframe->sp;
    80009ec6:	fe843703          	ld	a4,-24(s0)
    80009eca:	6785                	lui	a5,0x1
    80009ecc:	97ba                	add	a5,a5,a4
    80009ece:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80009ed2:	fdc42703          	lw	a4,-36(s0)
    80009ed6:	7b94                	ld	a3,48(a5)
    80009ed8:	fe843603          	ld	a2,-24(s0)
    80009edc:	87ba                	mv	a5,a4
    80009ede:	078e                	slli	a5,a5,0x3
    80009ee0:	97ba                	add	a5,a5,a4
    80009ee2:	0796                	slli	a5,a5,0x5
    80009ee4:	97b2                	add	a5,a5,a2
    80009ee6:	ebd4                	sd	a3,144(a5)
      proc->thrd_context[context_id].t0 = proc->trapframe->t0;
    80009ee8:	fe843703          	ld	a4,-24(s0)
    80009eec:	6785                	lui	a5,0x1
    80009eee:	97ba                	add	a5,a5,a4
    80009ef0:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80009ef4:	fdc42703          	lw	a4,-36(s0)
    80009ef8:	67b4                	ld	a3,72(a5)
    80009efa:	fe843603          	ld	a2,-24(s0)
    80009efe:	87ba                	mv	a5,a4
    80009f00:	078e                	slli	a5,a5,0x3
    80009f02:	97ba                	add	a5,a5,a4
    80009f04:	0796                	slli	a5,a5,0x5
    80009f06:	97b2                	add	a5,a5,a2
    80009f08:	f7d4                	sd	a3,168(a5)
      proc->thrd_context[context_id].t1 = proc->trapframe->t1;
    80009f0a:	fe843703          	ld	a4,-24(s0)
    80009f0e:	6785                	lui	a5,0x1
    80009f10:	97ba                	add	a5,a5,a4
    80009f12:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80009f16:	fdc42703          	lw	a4,-36(s0)
    80009f1a:	6bb4                	ld	a3,80(a5)
    80009f1c:	fe843603          	ld	a2,-24(s0)
    80009f20:	87ba                	mv	a5,a4
    80009f22:	078e                	slli	a5,a5,0x3
    80009f24:	97ba                	add	a5,a5,a4
    80009f26:	0796                	slli	a5,a5,0x5
    80009f28:	97b2                	add	a5,a5,a2
    80009f2a:	fbd4                	sd	a3,176(a5)
      proc->thrd_context[context_id].t2 = proc->trapframe->t2;
    80009f2c:	fe843703          	ld	a4,-24(s0)
    80009f30:	6785                	lui	a5,0x1
    80009f32:	97ba                	add	a5,a5,a4
    80009f34:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80009f38:	fdc42703          	lw	a4,-36(s0)
    80009f3c:	6fb4                	ld	a3,88(a5)
    80009f3e:	fe843603          	ld	a2,-24(s0)
    80009f42:	87ba                	mv	a5,a4
    80009f44:	078e                	slli	a5,a5,0x3
    80009f46:	97ba                	add	a5,a5,a4
    80009f48:	0796                	slli	a5,a5,0x5
    80009f4a:	97b2                	add	a5,a5,a2
    80009f4c:	ffd4                	sd	a3,184(a5)
      proc->thrd_context[context_id].t3 = proc->trapframe->t3;
    80009f4e:	fe843703          	ld	a4,-24(s0)
    80009f52:	6785                	lui	a5,0x1
    80009f54:	97ba                	add	a5,a5,a4
    80009f56:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80009f5a:	fdc42703          	lw	a4,-36(s0)
    80009f5e:	1007b683          	ld	a3,256(a5)
    80009f62:	fe843603          	ld	a2,-24(s0)
    80009f66:	87ba                	mv	a5,a4
    80009f68:	078e                	slli	a5,a5,0x3
    80009f6a:	97ba                	add	a5,a5,a4
    80009f6c:	0796                	slli	a5,a5,0x5
    80009f6e:	97b2                	add	a5,a5,a2
    80009f70:	16d7b023          	sd	a3,352(a5)
      proc->thrd_context[context_id].t4 = proc->trapframe->t4;
    80009f74:	fe843703          	ld	a4,-24(s0)
    80009f78:	6785                	lui	a5,0x1
    80009f7a:	97ba                	add	a5,a5,a4
    80009f7c:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80009f80:	fdc42703          	lw	a4,-36(s0)
    80009f84:	1087b683          	ld	a3,264(a5)
    80009f88:	fe843603          	ld	a2,-24(s0)
    80009f8c:	87ba                	mv	a5,a4
    80009f8e:	078e                	slli	a5,a5,0x3
    80009f90:	97ba                	add	a5,a5,a4
    80009f92:	0796                	slli	a5,a5,0x5
    80009f94:	97b2                	add	a5,a5,a2
    80009f96:	16d7b423          	sd	a3,360(a5)
      proc->thrd_context[context_id].t5 = proc->trapframe->t5;
    80009f9a:	fe843703          	ld	a4,-24(s0)
    80009f9e:	6785                	lui	a5,0x1
    80009fa0:	97ba                	add	a5,a5,a4
    80009fa2:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80009fa6:	fdc42703          	lw	a4,-36(s0)
    80009faa:	1107b683          	ld	a3,272(a5)
    80009fae:	fe843603          	ld	a2,-24(s0)
    80009fb2:	87ba                	mv	a5,a4
    80009fb4:	078e                	slli	a5,a5,0x3
    80009fb6:	97ba                	add	a5,a5,a4
    80009fb8:	0796                	slli	a5,a5,0x5
    80009fba:	97b2                	add	a5,a5,a2
    80009fbc:	16d7b823          	sd	a3,368(a5)
      proc->thrd_context[context_id].t6 = proc->trapframe->t6;
    80009fc0:	fe843703          	ld	a4,-24(s0)
    80009fc4:	6785                	lui	a5,0x1
    80009fc6:	97ba                	add	a5,a5,a4
    80009fc8:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80009fcc:	fdc42703          	lw	a4,-36(s0)
    80009fd0:	1187b683          	ld	a3,280(a5)
    80009fd4:	fe843603          	ld	a2,-24(s0)
    80009fd8:	87ba                	mv	a5,a4
    80009fda:	078e                	slli	a5,a5,0x3
    80009fdc:	97ba                	add	a5,a5,a4
    80009fde:	0796                	slli	a5,a5,0x5
    80009fe0:	97b2                	add	a5,a5,a2
    80009fe2:	16d7bc23          	sd	a3,376(a5)
      proc->thrd_context[context_id].a0 = proc->trapframe->a0;
    80009fe6:	fe843703          	ld	a4,-24(s0)
    80009fea:	6785                	lui	a5,0x1
    80009fec:	97ba                	add	a5,a5,a4
    80009fee:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    80009ff2:	fdc42703          	lw	a4,-36(s0)
    80009ff6:	7bb4                	ld	a3,112(a5)
    80009ff8:	fe843603          	ld	a2,-24(s0)
    80009ffc:	87ba                	mv	a5,a4
    80009ffe:	078e                	slli	a5,a5,0x3
    8000a000:	97ba                	add	a5,a5,a4
    8000a002:	0796                	slli	a5,a5,0x5
    8000a004:	97b2                	add	a5,a5,a2
    8000a006:	ebf4                	sd	a3,208(a5)
      proc->thrd_context[context_id].a1 = proc->trapframe->a1;
    8000a008:	fe843703          	ld	a4,-24(s0)
    8000a00c:	6785                	lui	a5,0x1
    8000a00e:	97ba                	add	a5,a5,a4
    8000a010:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    8000a014:	fdc42703          	lw	a4,-36(s0)
    8000a018:	7fb4                	ld	a3,120(a5)
    8000a01a:	fe843603          	ld	a2,-24(s0)
    8000a01e:	87ba                	mv	a5,a4
    8000a020:	078e                	slli	a5,a5,0x3
    8000a022:	97ba                	add	a5,a5,a4
    8000a024:	0796                	slli	a5,a5,0x5
    8000a026:	97b2                	add	a5,a5,a2
    8000a028:	eff4                	sd	a3,216(a5)
      proc->thrd_context[context_id].a2 = proc->trapframe->a2;
    8000a02a:	fe843703          	ld	a4,-24(s0)
    8000a02e:	6785                	lui	a5,0x1
    8000a030:	97ba                	add	a5,a5,a4
    8000a032:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    8000a036:	fdc42703          	lw	a4,-36(s0)
    8000a03a:	63d4                	ld	a3,128(a5)
    8000a03c:	fe843603          	ld	a2,-24(s0)
    8000a040:	87ba                	mv	a5,a4
    8000a042:	078e                	slli	a5,a5,0x3
    8000a044:	97ba                	add	a5,a5,a4
    8000a046:	0796                	slli	a5,a5,0x5
    8000a048:	97b2                	add	a5,a5,a2
    8000a04a:	f3f4                	sd	a3,224(a5)
      proc->thrd_context[context_id].a3 = proc->trapframe->a3;
    8000a04c:	fe843703          	ld	a4,-24(s0)
    8000a050:	6785                	lui	a5,0x1
    8000a052:	97ba                	add	a5,a5,a4
    8000a054:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    8000a058:	fdc42703          	lw	a4,-36(s0)
    8000a05c:	67d4                	ld	a3,136(a5)
    8000a05e:	fe843603          	ld	a2,-24(s0)
    8000a062:	87ba                	mv	a5,a4
    8000a064:	078e                	slli	a5,a5,0x3
    8000a066:	97ba                	add	a5,a5,a4
    8000a068:	0796                	slli	a5,a5,0x5
    8000a06a:	97b2                	add	a5,a5,a2
    8000a06c:	f7f4                	sd	a3,232(a5)
      proc->thrd_context[context_id].a4 = proc->trapframe->a4;
    8000a06e:	fe843703          	ld	a4,-24(s0)
    8000a072:	6785                	lui	a5,0x1
    8000a074:	97ba                	add	a5,a5,a4
    8000a076:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    8000a07a:	fdc42703          	lw	a4,-36(s0)
    8000a07e:	6bd4                	ld	a3,144(a5)
    8000a080:	fe843603          	ld	a2,-24(s0)
    8000a084:	87ba                	mv	a5,a4
    8000a086:	078e                	slli	a5,a5,0x3
    8000a088:	97ba                	add	a5,a5,a4
    8000a08a:	0796                	slli	a5,a5,0x5
    8000a08c:	97b2                	add	a5,a5,a2
    8000a08e:	fbf4                	sd	a3,240(a5)
      proc->thrd_context[context_id].a5 = proc->trapframe->a5;
    8000a090:	fe843703          	ld	a4,-24(s0)
    8000a094:	6785                	lui	a5,0x1
    8000a096:	97ba                	add	a5,a5,a4
    8000a098:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    8000a09c:	fdc42703          	lw	a4,-36(s0)
    8000a0a0:	6fd4                	ld	a3,152(a5)
    8000a0a2:	fe843603          	ld	a2,-24(s0)
    8000a0a6:	87ba                	mv	a5,a4
    8000a0a8:	078e                	slli	a5,a5,0x3
    8000a0aa:	97ba                	add	a5,a5,a4
    8000a0ac:	0796                	slli	a5,a5,0x5
    8000a0ae:	97b2                	add	a5,a5,a2
    8000a0b0:	fff4                	sd	a3,248(a5)
      proc->thrd_context[context_id].a6 = proc->trapframe->a6;
    8000a0b2:	fe843703          	ld	a4,-24(s0)
    8000a0b6:	6785                	lui	a5,0x1
    8000a0b8:	97ba                	add	a5,a5,a4
    8000a0ba:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    8000a0be:	fdc42703          	lw	a4,-36(s0)
    8000a0c2:	73d4                	ld	a3,160(a5)
    8000a0c4:	fe843603          	ld	a2,-24(s0)
    8000a0c8:	87ba                	mv	a5,a4
    8000a0ca:	078e                	slli	a5,a5,0x3
    8000a0cc:	97ba                	add	a5,a5,a4
    8000a0ce:	0796                	slli	a5,a5,0x5
    8000a0d0:	97b2                	add	a5,a5,a2
    8000a0d2:	10d7b023          	sd	a3,256(a5)
      proc->thrd_context[context_id].a7 = proc->trapframe->a7;
    8000a0d6:	fe843703          	ld	a4,-24(s0)
    8000a0da:	6785                	lui	a5,0x1
    8000a0dc:	97ba                	add	a5,a5,a4
    8000a0de:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    8000a0e2:	fdc42703          	lw	a4,-36(s0)
    8000a0e6:	77d4                	ld	a3,168(a5)
    8000a0e8:	fe843603          	ld	a2,-24(s0)
    8000a0ec:	87ba                	mv	a5,a4
    8000a0ee:	078e                	slli	a5,a5,0x3
    8000a0f0:	97ba                	add	a5,a5,a4
    8000a0f2:	0796                	slli	a5,a5,0x5
    8000a0f4:	97b2                	add	a5,a5,a2
    8000a0f6:	10d7b423          	sd	a3,264(a5)
      proc->thrd_context[context_id].gp = proc->trapframe->gp;
    8000a0fa:	fe843703          	ld	a4,-24(s0)
    8000a0fe:	6785                	lui	a5,0x1
    8000a100:	97ba                	add	a5,a5,a4
    8000a102:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    8000a106:	fdc42703          	lw	a4,-36(s0)
    8000a10a:	7f94                	ld	a3,56(a5)
    8000a10c:	fe843603          	ld	a2,-24(s0)
    8000a110:	87ba                	mv	a5,a4
    8000a112:	078e                	slli	a5,a5,0x3
    8000a114:	97ba                	add	a5,a5,a4
    8000a116:	0796                	slli	a5,a5,0x5
    8000a118:	97b2                	add	a5,a5,a2
    8000a11a:	efd4                	sd	a3,152(a5)
      proc->thrd_context[context_id].tp = proc->trapframe->tp;
    8000a11c:	fe843703          	ld	a4,-24(s0)
    8000a120:	6785                	lui	a5,0x1
    8000a122:	97ba                	add	a5,a5,a4
    8000a124:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    8000a128:	fdc42703          	lw	a4,-36(s0)
    8000a12c:	63b4                	ld	a3,64(a5)
    8000a12e:	fe843603          	ld	a2,-24(s0)
    8000a132:	87ba                	mv	a5,a4
    8000a134:	078e                	slli	a5,a5,0x3
    8000a136:	97ba                	add	a5,a5,a4
    8000a138:	0796                	slli	a5,a5,0x5
    8000a13a:	97b2                	add	a5,a5,a2
    8000a13c:	f3d4                	sd	a3,160(a5)
      proc->thrd_context[context_id].epc = proc->trapframe->epc;
    8000a13e:	fe843703          	ld	a4,-24(s0)
    8000a142:	6785                	lui	a5,0x1
    8000a144:	97ba                	add	a5,a5,a4
    8000a146:	2b87b783          	ld	a5,696(a5) # 12b8 <_entry-0x7fffed48>
    8000a14a:	fdc42703          	lw	a4,-36(s0)
    8000a14e:	6f94                	ld	a3,24(a5)
    8000a150:	fe843603          	ld	a2,-24(s0)
    8000a154:	87ba                	mv	a5,a4
    8000a156:	078e                	slli	a5,a5,0x3
    8000a158:	97ba                	add	a5,a5,a4
    8000a15a:	0796                	slli	a5,a5,0x5
    8000a15c:	97b2                	add	a5,a5,a2
    8000a15e:	ffb4                	sd	a3,120(a5)
    8000a160:	acf9                	j	8000a43e <sys_cancelthrdstop+0x7dc>
  }else{
    proc->thrd_context_used[context_id] = 0; // recycled
    8000a162:	fdc42783          	lw	a5,-36(s0)
    8000a166:	fe843703          	ld	a4,-24(s0)
    8000a16a:	49878793          	addi	a5,a5,1176
    8000a16e:	078a                	slli	a5,a5,0x2
    8000a170:	97ba                	add	a5,a5,a4
    8000a172:	0007a023          	sw	zero,0(a5)
    proc->thrd_context[context_id].s0 = 0;
    8000a176:	fdc42703          	lw	a4,-36(s0)
    8000a17a:	fe843683          	ld	a3,-24(s0)
    8000a17e:	87ba                	mv	a5,a4
    8000a180:	078e                	slli	a5,a5,0x3
    8000a182:	97ba                	add	a5,a5,a4
    8000a184:	0796                	slli	a5,a5,0x5
    8000a186:	97b6                	add	a5,a5,a3
    8000a188:	0c07b023          	sd	zero,192(a5)
      proc->thrd_context[context_id].s1 = 0;
    8000a18c:	fdc42703          	lw	a4,-36(s0)
    8000a190:	fe843683          	ld	a3,-24(s0)
    8000a194:	87ba                	mv	a5,a4
    8000a196:	078e                	slli	a5,a5,0x3
    8000a198:	97ba                	add	a5,a5,a4
    8000a19a:	0796                	slli	a5,a5,0x5
    8000a19c:	97b6                	add	a5,a5,a3
    8000a19e:	0c07b423          	sd	zero,200(a5)
      proc->thrd_context[context_id].s2 = 0;
    8000a1a2:	fdc42703          	lw	a4,-36(s0)
    8000a1a6:	fe843683          	ld	a3,-24(s0)
    8000a1aa:	87ba                	mv	a5,a4
    8000a1ac:	078e                	slli	a5,a5,0x3
    8000a1ae:	97ba                	add	a5,a5,a4
    8000a1b0:	0796                	slli	a5,a5,0x5
    8000a1b2:	97b6                	add	a5,a5,a3
    8000a1b4:	1007b823          	sd	zero,272(a5)
      proc->thrd_context[context_id].s3 = 0;
    8000a1b8:	fdc42703          	lw	a4,-36(s0)
    8000a1bc:	fe843683          	ld	a3,-24(s0)
    8000a1c0:	87ba                	mv	a5,a4
    8000a1c2:	078e                	slli	a5,a5,0x3
    8000a1c4:	97ba                	add	a5,a5,a4
    8000a1c6:	0796                	slli	a5,a5,0x5
    8000a1c8:	97b6                	add	a5,a5,a3
    8000a1ca:	1007bc23          	sd	zero,280(a5)
      proc->thrd_context[context_id].s4 = 0;
    8000a1ce:	fdc42783          	lw	a5,-36(s0)
    8000a1d2:	fe843683          	ld	a3,-24(s0)
    8000a1d6:	00178713          	addi	a4,a5,1
    8000a1da:	87ba                	mv	a5,a4
    8000a1dc:	078e                	slli	a5,a5,0x3
    8000a1de:	97ba                	add	a5,a5,a4
    8000a1e0:	0796                	slli	a5,a5,0x5
    8000a1e2:	97b6                	add	a5,a5,a3
    8000a1e4:	0007b023          	sd	zero,0(a5)
      proc->thrd_context[context_id].s5 = 0;
    8000a1e8:	fdc42783          	lw	a5,-36(s0)
    8000a1ec:	fe843683          	ld	a3,-24(s0)
    8000a1f0:	00178713          	addi	a4,a5,1
    8000a1f4:	87ba                	mv	a5,a4
    8000a1f6:	078e                	slli	a5,a5,0x3
    8000a1f8:	97ba                	add	a5,a5,a4
    8000a1fa:	0796                	slli	a5,a5,0x5
    8000a1fc:	97b6                	add	a5,a5,a3
    8000a1fe:	0007b423          	sd	zero,8(a5)
      proc->thrd_context[context_id].s6 = 0;
    8000a202:	fdc42703          	lw	a4,-36(s0)
    8000a206:	fe843683          	ld	a3,-24(s0)
    8000a20a:	87ba                	mv	a5,a4
    8000a20c:	078e                	slli	a5,a5,0x3
    8000a20e:	97ba                	add	a5,a5,a4
    8000a210:	0796                	slli	a5,a5,0x5
    8000a212:	97b6                	add	a5,a5,a3
    8000a214:	1207b823          	sd	zero,304(a5)
      proc->thrd_context[context_id].s7 = 0;
    8000a218:	fdc42703          	lw	a4,-36(s0)
    8000a21c:	fe843683          	ld	a3,-24(s0)
    8000a220:	87ba                	mv	a5,a4
    8000a222:	078e                	slli	a5,a5,0x3
    8000a224:	97ba                	add	a5,a5,a4
    8000a226:	0796                	slli	a5,a5,0x5
    8000a228:	97b6                	add	a5,a5,a3
    8000a22a:	1207bc23          	sd	zero,312(a5)
      proc->thrd_context[context_id].s8 = 0;
    8000a22e:	fdc42703          	lw	a4,-36(s0)
    8000a232:	fe843683          	ld	a3,-24(s0)
    8000a236:	87ba                	mv	a5,a4
    8000a238:	078e                	slli	a5,a5,0x3
    8000a23a:	97ba                	add	a5,a5,a4
    8000a23c:	0796                	slli	a5,a5,0x5
    8000a23e:	97b6                	add	a5,a5,a3
    8000a240:	1407b023          	sd	zero,320(a5)
      proc->thrd_context[context_id].s9 = 0;
    8000a244:	fdc42703          	lw	a4,-36(s0)
    8000a248:	fe843683          	ld	a3,-24(s0)
    8000a24c:	87ba                	mv	a5,a4
    8000a24e:	078e                	slli	a5,a5,0x3
    8000a250:	97ba                	add	a5,a5,a4
    8000a252:	0796                	slli	a5,a5,0x5
    8000a254:	97b6                	add	a5,a5,a3
    8000a256:	1407b423          	sd	zero,328(a5)
      proc->thrd_context[context_id].s10 = 0;
    8000a25a:	fdc42703          	lw	a4,-36(s0)
    8000a25e:	fe843683          	ld	a3,-24(s0)
    8000a262:	87ba                	mv	a5,a4
    8000a264:	078e                	slli	a5,a5,0x3
    8000a266:	97ba                	add	a5,a5,a4
    8000a268:	0796                	slli	a5,a5,0x5
    8000a26a:	97b6                	add	a5,a5,a3
    8000a26c:	1407b823          	sd	zero,336(a5)
      proc->thrd_context[context_id].s11 = 0;
    8000a270:	fdc42703          	lw	a4,-36(s0)
    8000a274:	fe843683          	ld	a3,-24(s0)
    8000a278:	87ba                	mv	a5,a4
    8000a27a:	078e                	slli	a5,a5,0x3
    8000a27c:	97ba                	add	a5,a5,a4
    8000a27e:	0796                	slli	a5,a5,0x5
    8000a280:	97b6                	add	a5,a5,a3
    8000a282:	1407bc23          	sd	zero,344(a5)
      proc->thrd_context[context_id].ra = 0;
    8000a286:	fdc42703          	lw	a4,-36(s0)
    8000a28a:	fe843683          	ld	a3,-24(s0)
    8000a28e:	87ba                	mv	a5,a4
    8000a290:	078e                	slli	a5,a5,0x3
    8000a292:	97ba                	add	a5,a5,a4
    8000a294:	0796                	slli	a5,a5,0x5
    8000a296:	97b6                	add	a5,a5,a3
    8000a298:	0807b423          	sd	zero,136(a5)
      proc->thrd_context[context_id].sp = 0;
    8000a29c:	fdc42703          	lw	a4,-36(s0)
    8000a2a0:	fe843683          	ld	a3,-24(s0)
    8000a2a4:	87ba                	mv	a5,a4
    8000a2a6:	078e                	slli	a5,a5,0x3
    8000a2a8:	97ba                	add	a5,a5,a4
    8000a2aa:	0796                	slli	a5,a5,0x5
    8000a2ac:	97b6                	add	a5,a5,a3
    8000a2ae:	0807b823          	sd	zero,144(a5)
      proc->thrd_context[context_id].t0 = 0;
    8000a2b2:	fdc42703          	lw	a4,-36(s0)
    8000a2b6:	fe843683          	ld	a3,-24(s0)
    8000a2ba:	87ba                	mv	a5,a4
    8000a2bc:	078e                	slli	a5,a5,0x3
    8000a2be:	97ba                	add	a5,a5,a4
    8000a2c0:	0796                	slli	a5,a5,0x5
    8000a2c2:	97b6                	add	a5,a5,a3
    8000a2c4:	0a07b423          	sd	zero,168(a5)
      proc->thrd_context[context_id].t1 = 0;
    8000a2c8:	fdc42703          	lw	a4,-36(s0)
    8000a2cc:	fe843683          	ld	a3,-24(s0)
    8000a2d0:	87ba                	mv	a5,a4
    8000a2d2:	078e                	slli	a5,a5,0x3
    8000a2d4:	97ba                	add	a5,a5,a4
    8000a2d6:	0796                	slli	a5,a5,0x5
    8000a2d8:	97b6                	add	a5,a5,a3
    8000a2da:	0a07b823          	sd	zero,176(a5)
      proc->thrd_context[context_id].t2 = 0;
    8000a2de:	fdc42703          	lw	a4,-36(s0)
    8000a2e2:	fe843683          	ld	a3,-24(s0)
    8000a2e6:	87ba                	mv	a5,a4
    8000a2e8:	078e                	slli	a5,a5,0x3
    8000a2ea:	97ba                	add	a5,a5,a4
    8000a2ec:	0796                	slli	a5,a5,0x5
    8000a2ee:	97b6                	add	a5,a5,a3
    8000a2f0:	0a07bc23          	sd	zero,184(a5)
      proc->thrd_context[context_id].t3 = 0;
    8000a2f4:	fdc42703          	lw	a4,-36(s0)
    8000a2f8:	fe843683          	ld	a3,-24(s0)
    8000a2fc:	87ba                	mv	a5,a4
    8000a2fe:	078e                	slli	a5,a5,0x3
    8000a300:	97ba                	add	a5,a5,a4
    8000a302:	0796                	slli	a5,a5,0x5
    8000a304:	97b6                	add	a5,a5,a3
    8000a306:	1607b023          	sd	zero,352(a5)
      proc->thrd_context[context_id].t4 = 0;
    8000a30a:	fdc42703          	lw	a4,-36(s0)
    8000a30e:	fe843683          	ld	a3,-24(s0)
    8000a312:	87ba                	mv	a5,a4
    8000a314:	078e                	slli	a5,a5,0x3
    8000a316:	97ba                	add	a5,a5,a4
    8000a318:	0796                	slli	a5,a5,0x5
    8000a31a:	97b6                	add	a5,a5,a3
    8000a31c:	1607b423          	sd	zero,360(a5)
      proc->thrd_context[context_id].t5 = 0;
    8000a320:	fdc42703          	lw	a4,-36(s0)
    8000a324:	fe843683          	ld	a3,-24(s0)
    8000a328:	87ba                	mv	a5,a4
    8000a32a:	078e                	slli	a5,a5,0x3
    8000a32c:	97ba                	add	a5,a5,a4
    8000a32e:	0796                	slli	a5,a5,0x5
    8000a330:	97b6                	add	a5,a5,a3
    8000a332:	1607b823          	sd	zero,368(a5)
      proc->thrd_context[context_id].t6 = 0;
    8000a336:	fdc42703          	lw	a4,-36(s0)
    8000a33a:	fe843683          	ld	a3,-24(s0)
    8000a33e:	87ba                	mv	a5,a4
    8000a340:	078e                	slli	a5,a5,0x3
    8000a342:	97ba                	add	a5,a5,a4
    8000a344:	0796                	slli	a5,a5,0x5
    8000a346:	97b6                	add	a5,a5,a3
    8000a348:	1607bc23          	sd	zero,376(a5)
      proc->thrd_context[context_id].a0 = 0;
    8000a34c:	fdc42703          	lw	a4,-36(s0)
    8000a350:	fe843683          	ld	a3,-24(s0)
    8000a354:	87ba                	mv	a5,a4
    8000a356:	078e                	slli	a5,a5,0x3
    8000a358:	97ba                	add	a5,a5,a4
    8000a35a:	0796                	slli	a5,a5,0x5
    8000a35c:	97b6                	add	a5,a5,a3
    8000a35e:	0c07b823          	sd	zero,208(a5)
      proc->thrd_context[context_id].a1 = 0;
    8000a362:	fdc42703          	lw	a4,-36(s0)
    8000a366:	fe843683          	ld	a3,-24(s0)
    8000a36a:	87ba                	mv	a5,a4
    8000a36c:	078e                	slli	a5,a5,0x3
    8000a36e:	97ba                	add	a5,a5,a4
    8000a370:	0796                	slli	a5,a5,0x5
    8000a372:	97b6                	add	a5,a5,a3
    8000a374:	0c07bc23          	sd	zero,216(a5)
      proc->thrd_context[context_id].a2 = 0;
    8000a378:	fdc42703          	lw	a4,-36(s0)
    8000a37c:	fe843683          	ld	a3,-24(s0)
    8000a380:	87ba                	mv	a5,a4
    8000a382:	078e                	slli	a5,a5,0x3
    8000a384:	97ba                	add	a5,a5,a4
    8000a386:	0796                	slli	a5,a5,0x5
    8000a388:	97b6                	add	a5,a5,a3
    8000a38a:	0e07b023          	sd	zero,224(a5)
      proc->thrd_context[context_id].a3 = 0;
    8000a38e:	fdc42703          	lw	a4,-36(s0)
    8000a392:	fe843683          	ld	a3,-24(s0)
    8000a396:	87ba                	mv	a5,a4
    8000a398:	078e                	slli	a5,a5,0x3
    8000a39a:	97ba                	add	a5,a5,a4
    8000a39c:	0796                	slli	a5,a5,0x5
    8000a39e:	97b6                	add	a5,a5,a3
    8000a3a0:	0e07b423          	sd	zero,232(a5)
      proc->thrd_context[context_id].a4 = 0;
    8000a3a4:	fdc42703          	lw	a4,-36(s0)
    8000a3a8:	fe843683          	ld	a3,-24(s0)
    8000a3ac:	87ba                	mv	a5,a4
    8000a3ae:	078e                	slli	a5,a5,0x3
    8000a3b0:	97ba                	add	a5,a5,a4
    8000a3b2:	0796                	slli	a5,a5,0x5
    8000a3b4:	97b6                	add	a5,a5,a3
    8000a3b6:	0e07b823          	sd	zero,240(a5)
      proc->thrd_context[context_id].a5 = 0;
    8000a3ba:	fdc42703          	lw	a4,-36(s0)
    8000a3be:	fe843683          	ld	a3,-24(s0)
    8000a3c2:	87ba                	mv	a5,a4
    8000a3c4:	078e                	slli	a5,a5,0x3
    8000a3c6:	97ba                	add	a5,a5,a4
    8000a3c8:	0796                	slli	a5,a5,0x5
    8000a3ca:	97b6                	add	a5,a5,a3
    8000a3cc:	0e07bc23          	sd	zero,248(a5)
      proc->thrd_context[context_id].a6 = 0;
    8000a3d0:	fdc42703          	lw	a4,-36(s0)
    8000a3d4:	fe843683          	ld	a3,-24(s0)
    8000a3d8:	87ba                	mv	a5,a4
    8000a3da:	078e                	slli	a5,a5,0x3
    8000a3dc:	97ba                	add	a5,a5,a4
    8000a3de:	0796                	slli	a5,a5,0x5
    8000a3e0:	97b6                	add	a5,a5,a3
    8000a3e2:	1007b023          	sd	zero,256(a5)
      proc->thrd_context[context_id].a7 = 0;
    8000a3e6:	fdc42703          	lw	a4,-36(s0)
    8000a3ea:	fe843683          	ld	a3,-24(s0)
    8000a3ee:	87ba                	mv	a5,a4
    8000a3f0:	078e                	slli	a5,a5,0x3
    8000a3f2:	97ba                	add	a5,a5,a4
    8000a3f4:	0796                	slli	a5,a5,0x5
    8000a3f6:	97b6                	add	a5,a5,a3
    8000a3f8:	1007b423          	sd	zero,264(a5)
      proc->thrd_context[context_id].gp = 0;
    8000a3fc:	fdc42703          	lw	a4,-36(s0)
    8000a400:	fe843683          	ld	a3,-24(s0)
    8000a404:	87ba                	mv	a5,a4
    8000a406:	078e                	slli	a5,a5,0x3
    8000a408:	97ba                	add	a5,a5,a4
    8000a40a:	0796                	slli	a5,a5,0x5
    8000a40c:	97b6                	add	a5,a5,a3
    8000a40e:	0807bc23          	sd	zero,152(a5)
      proc->thrd_context[context_id].tp = 0;
    8000a412:	fdc42703          	lw	a4,-36(s0)
    8000a416:	fe843683          	ld	a3,-24(s0)
    8000a41a:	87ba                	mv	a5,a4
    8000a41c:	078e                	slli	a5,a5,0x3
    8000a41e:	97ba                	add	a5,a5,a4
    8000a420:	0796                	slli	a5,a5,0x5
    8000a422:	97b6                	add	a5,a5,a3
    8000a424:	0a07b023          	sd	zero,160(a5)
      proc->thrd_context[context_id].epc = 0;
    8000a428:	fdc42703          	lw	a4,-36(s0)
    8000a42c:	fe843683          	ld	a3,-24(s0)
    8000a430:	87ba                	mv	a5,a4
    8000a432:	078e                	slli	a5,a5,0x3
    8000a434:	97ba                	add	a5,a5,a4
    8000a436:	0796                	slli	a5,a5,0x5
    8000a438:	97b6                	add	a5,a5,a3
    8000a43a:	0607bc23          	sd	zero,120(a5)
  }

  return time_left;
    8000a43e:	fe043783          	ld	a5,-32(s0)
}
    8000a442:	853e                	mv	a0,a5
    8000a444:	70a2                	ld	ra,40(sp)
    8000a446:	7402                	ld	s0,32(sp)
    8000a448:	6145                	addi	sp,sp,48
    8000a44a:	8082                	ret

000000008000a44c <sys_thrdresume>:

// for mp3
uint64
sys_thrdresume(void)
{
    8000a44c:	1101                	addi	sp,sp,-32
    8000a44e:	ec06                	sd	ra,24(sp)
    8000a450:	e822                	sd	s0,16(sp)
    8000a452:	1000                	addi	s0,sp,32
  // handler uses thrdresume to query kernel restore the regs
  int context_id;
  if (argint(0, &context_id) < 0)
    8000a454:	fe440793          	addi	a5,s0,-28
    8000a458:	85be                	mv	a1,a5
    8000a45a:	4501                	li	a0,0
    8000a45c:	ffffa097          	auipc	ra,0xffffa
    8000a460:	356080e7          	jalr	854(ra) # 800047b2 <argint>
    8000a464:	87aa                	mv	a5,a0
    8000a466:	0007d463          	bgez	a5,8000a46e <sys_thrdresume+0x22>
    return -1;
    8000a46a:	57fd                	li	a5,-1
    8000a46c:	a175                	j	8000a918 <sys_thrdresume+0x4cc>

  struct proc *proc = myproc();
    8000a46e:	ffff8097          	auipc	ra,0xffff8
    8000a472:	38a080e7          	jalr	906(ra) # 800027f8 <myproc>
    8000a476:	fea43423          	sd	a0,-24(s0)


  //TODO: mp3
  if(context_id < 0 || context_id >= MAX_THRD_NUM) return -1;
    8000a47a:	fe442783          	lw	a5,-28(s0)
    8000a47e:	0007c863          	bltz	a5,8000a48e <sys_thrdresume+0x42>
    8000a482:	fe442783          	lw	a5,-28(s0)
    8000a486:	873e                	mv	a4,a5
    8000a488:	47bd                	li	a5,15
    8000a48a:	00e7d463          	bge	a5,a4,8000a492 <sys_thrdresume+0x46>
    8000a48e:	57fd                	li	a5,-1
    8000a490:	a161                	j	8000a918 <sys_thrdresume+0x4cc>
  if(!(proc->thrd_context_used[context_id])) return -1;
    8000a492:	fe442783          	lw	a5,-28(s0)
    8000a496:	fe843703          	ld	a4,-24(s0)
    8000a49a:	49878793          	addi	a5,a5,1176
    8000a49e:	078a                	slli	a5,a5,0x2
    8000a4a0:	97ba                	add	a5,a5,a4
    8000a4a2:	439c                	lw	a5,0(a5)
    8000a4a4:	e399                	bnez	a5,8000a4aa <sys_thrdresume+0x5e>
    8000a4a6:	57fd                	li	a5,-1
    8000a4a8:	a985                	j	8000a918 <sys_thrdresume+0x4cc>

  proc->trapframe->epc = proc->thrd_context[context_id].epc;
    8000a4aa:	fe442703          	lw	a4,-28(s0)
    8000a4ae:	fe843683          	ld	a3,-24(s0)
    8000a4b2:	6785                	lui	a5,0x1
    8000a4b4:	97b6                	add	a5,a5,a3
    8000a4b6:	2b87b683          	ld	a3,696(a5) # 12b8 <_entry-0x7fffed48>
    8000a4ba:	fe843603          	ld	a2,-24(s0)
    8000a4be:	87ba                	mv	a5,a4
    8000a4c0:	078e                	slli	a5,a5,0x3
    8000a4c2:	97ba                	add	a5,a5,a4
    8000a4c4:	0796                	slli	a5,a5,0x5
    8000a4c6:	97b2                	add	a5,a5,a2
    8000a4c8:	7fbc                	ld	a5,120(a5)
    8000a4ca:	ee9c                	sd	a5,24(a3)
  proc->trapframe->s0 = proc->thrd_context[context_id].s0;
    8000a4cc:	fe442703          	lw	a4,-28(s0)
    8000a4d0:	fe843683          	ld	a3,-24(s0)
    8000a4d4:	6785                	lui	a5,0x1
    8000a4d6:	97b6                	add	a5,a5,a3
    8000a4d8:	2b87b683          	ld	a3,696(a5) # 12b8 <_entry-0x7fffed48>
    8000a4dc:	fe843603          	ld	a2,-24(s0)
    8000a4e0:	87ba                	mv	a5,a4
    8000a4e2:	078e                	slli	a5,a5,0x3
    8000a4e4:	97ba                	add	a5,a5,a4
    8000a4e6:	0796                	slli	a5,a5,0x5
    8000a4e8:	97b2                	add	a5,a5,a2
    8000a4ea:	63fc                	ld	a5,192(a5)
    8000a4ec:	f2bc                	sd	a5,96(a3)
  proc->trapframe->s1 = proc->thrd_context[context_id].s1;
    8000a4ee:	fe442703          	lw	a4,-28(s0)
    8000a4f2:	fe843683          	ld	a3,-24(s0)
    8000a4f6:	6785                	lui	a5,0x1
    8000a4f8:	97b6                	add	a5,a5,a3
    8000a4fa:	2b87b683          	ld	a3,696(a5) # 12b8 <_entry-0x7fffed48>
    8000a4fe:	fe843603          	ld	a2,-24(s0)
    8000a502:	87ba                	mv	a5,a4
    8000a504:	078e                	slli	a5,a5,0x3
    8000a506:	97ba                	add	a5,a5,a4
    8000a508:	0796                	slli	a5,a5,0x5
    8000a50a:	97b2                	add	a5,a5,a2
    8000a50c:	67fc                	ld	a5,200(a5)
    8000a50e:	f6bc                	sd	a5,104(a3)
  proc->trapframe->s2 = proc->thrd_context[context_id].s2;
    8000a510:	fe442703          	lw	a4,-28(s0)
    8000a514:	fe843683          	ld	a3,-24(s0)
    8000a518:	6785                	lui	a5,0x1
    8000a51a:	97b6                	add	a5,a5,a3
    8000a51c:	2b87b683          	ld	a3,696(a5) # 12b8 <_entry-0x7fffed48>
    8000a520:	fe843603          	ld	a2,-24(s0)
    8000a524:	87ba                	mv	a5,a4
    8000a526:	078e                	slli	a5,a5,0x3
    8000a528:	97ba                	add	a5,a5,a4
    8000a52a:	0796                	slli	a5,a5,0x5
    8000a52c:	97b2                	add	a5,a5,a2
    8000a52e:	1107b783          	ld	a5,272(a5)
    8000a532:	fadc                	sd	a5,176(a3)
  proc->trapframe->s3 = proc->thrd_context[context_id].s3;
    8000a534:	fe442703          	lw	a4,-28(s0)
    8000a538:	fe843683          	ld	a3,-24(s0)
    8000a53c:	6785                	lui	a5,0x1
    8000a53e:	97b6                	add	a5,a5,a3
    8000a540:	2b87b683          	ld	a3,696(a5) # 12b8 <_entry-0x7fffed48>
    8000a544:	fe843603          	ld	a2,-24(s0)
    8000a548:	87ba                	mv	a5,a4
    8000a54a:	078e                	slli	a5,a5,0x3
    8000a54c:	97ba                	add	a5,a5,a4
    8000a54e:	0796                	slli	a5,a5,0x5
    8000a550:	97b2                	add	a5,a5,a2
    8000a552:	1187b783          	ld	a5,280(a5)
    8000a556:	fedc                	sd	a5,184(a3)
  proc->trapframe->s4 = proc->thrd_context[context_id].s4;
    8000a558:	fe442783          	lw	a5,-28(s0)
    8000a55c:	fe843683          	ld	a3,-24(s0)
    8000a560:	6705                	lui	a4,0x1
    8000a562:	9736                	add	a4,a4,a3
    8000a564:	2b873683          	ld	a3,696(a4) # 12b8 <_entry-0x7fffed48>
    8000a568:	fe843603          	ld	a2,-24(s0)
    8000a56c:	00178713          	addi	a4,a5,1
    8000a570:	87ba                	mv	a5,a4
    8000a572:	078e                	slli	a5,a5,0x3
    8000a574:	97ba                	add	a5,a5,a4
    8000a576:	0796                	slli	a5,a5,0x5
    8000a578:	97b2                	add	a5,a5,a2
    8000a57a:	639c                	ld	a5,0(a5)
    8000a57c:	e2fc                	sd	a5,192(a3)
  proc->trapframe->s5 = proc->thrd_context[context_id].s5;
    8000a57e:	fe442783          	lw	a5,-28(s0)
    8000a582:	fe843683          	ld	a3,-24(s0)
    8000a586:	6705                	lui	a4,0x1
    8000a588:	9736                	add	a4,a4,a3
    8000a58a:	2b873683          	ld	a3,696(a4) # 12b8 <_entry-0x7fffed48>
    8000a58e:	fe843603          	ld	a2,-24(s0)
    8000a592:	00178713          	addi	a4,a5,1
    8000a596:	87ba                	mv	a5,a4
    8000a598:	078e                	slli	a5,a5,0x3
    8000a59a:	97ba                	add	a5,a5,a4
    8000a59c:	0796                	slli	a5,a5,0x5
    8000a59e:	97b2                	add	a5,a5,a2
    8000a5a0:	679c                	ld	a5,8(a5)
    8000a5a2:	e6fc                	sd	a5,200(a3)
  proc->trapframe->s6 = proc->thrd_context[context_id].s6;
    8000a5a4:	fe442703          	lw	a4,-28(s0)
    8000a5a8:	fe843683          	ld	a3,-24(s0)
    8000a5ac:	6785                	lui	a5,0x1
    8000a5ae:	97b6                	add	a5,a5,a3
    8000a5b0:	2b87b683          	ld	a3,696(a5) # 12b8 <_entry-0x7fffed48>
    8000a5b4:	fe843603          	ld	a2,-24(s0)
    8000a5b8:	87ba                	mv	a5,a4
    8000a5ba:	078e                	slli	a5,a5,0x3
    8000a5bc:	97ba                	add	a5,a5,a4
    8000a5be:	0796                	slli	a5,a5,0x5
    8000a5c0:	97b2                	add	a5,a5,a2
    8000a5c2:	1307b783          	ld	a5,304(a5)
    8000a5c6:	eafc                	sd	a5,208(a3)
  proc->trapframe->s7 = proc->thrd_context[context_id].s7;
    8000a5c8:	fe442703          	lw	a4,-28(s0)
    8000a5cc:	fe843683          	ld	a3,-24(s0)
    8000a5d0:	6785                	lui	a5,0x1
    8000a5d2:	97b6                	add	a5,a5,a3
    8000a5d4:	2b87b683          	ld	a3,696(a5) # 12b8 <_entry-0x7fffed48>
    8000a5d8:	fe843603          	ld	a2,-24(s0)
    8000a5dc:	87ba                	mv	a5,a4
    8000a5de:	078e                	slli	a5,a5,0x3
    8000a5e0:	97ba                	add	a5,a5,a4
    8000a5e2:	0796                	slli	a5,a5,0x5
    8000a5e4:	97b2                	add	a5,a5,a2
    8000a5e6:	1387b783          	ld	a5,312(a5)
    8000a5ea:	eefc                	sd	a5,216(a3)
  proc->trapframe->s8 = proc->thrd_context[context_id].s8;
    8000a5ec:	fe442703          	lw	a4,-28(s0)
    8000a5f0:	fe843683          	ld	a3,-24(s0)
    8000a5f4:	6785                	lui	a5,0x1
    8000a5f6:	97b6                	add	a5,a5,a3
    8000a5f8:	2b87b683          	ld	a3,696(a5) # 12b8 <_entry-0x7fffed48>
    8000a5fc:	fe843603          	ld	a2,-24(s0)
    8000a600:	87ba                	mv	a5,a4
    8000a602:	078e                	slli	a5,a5,0x3
    8000a604:	97ba                	add	a5,a5,a4
    8000a606:	0796                	slli	a5,a5,0x5
    8000a608:	97b2                	add	a5,a5,a2
    8000a60a:	1407b783          	ld	a5,320(a5)
    8000a60e:	f2fc                	sd	a5,224(a3)
  proc->trapframe->s9 = proc->thrd_context[context_id].s9;
    8000a610:	fe442703          	lw	a4,-28(s0)
    8000a614:	fe843683          	ld	a3,-24(s0)
    8000a618:	6785                	lui	a5,0x1
    8000a61a:	97b6                	add	a5,a5,a3
    8000a61c:	2b87b683          	ld	a3,696(a5) # 12b8 <_entry-0x7fffed48>
    8000a620:	fe843603          	ld	a2,-24(s0)
    8000a624:	87ba                	mv	a5,a4
    8000a626:	078e                	slli	a5,a5,0x3
    8000a628:	97ba                	add	a5,a5,a4
    8000a62a:	0796                	slli	a5,a5,0x5
    8000a62c:	97b2                	add	a5,a5,a2
    8000a62e:	1487b783          	ld	a5,328(a5)
    8000a632:	f6fc                	sd	a5,232(a3)
  proc->trapframe->s10 = proc->thrd_context[context_id].s10;
    8000a634:	fe442703          	lw	a4,-28(s0)
    8000a638:	fe843683          	ld	a3,-24(s0)
    8000a63c:	6785                	lui	a5,0x1
    8000a63e:	97b6                	add	a5,a5,a3
    8000a640:	2b87b683          	ld	a3,696(a5) # 12b8 <_entry-0x7fffed48>
    8000a644:	fe843603          	ld	a2,-24(s0)
    8000a648:	87ba                	mv	a5,a4
    8000a64a:	078e                	slli	a5,a5,0x3
    8000a64c:	97ba                	add	a5,a5,a4
    8000a64e:	0796                	slli	a5,a5,0x5
    8000a650:	97b2                	add	a5,a5,a2
    8000a652:	1507b783          	ld	a5,336(a5)
    8000a656:	fafc                	sd	a5,240(a3)
  proc->trapframe->s11 = proc->thrd_context[context_id].s11;
    8000a658:	fe442703          	lw	a4,-28(s0)
    8000a65c:	fe843683          	ld	a3,-24(s0)
    8000a660:	6785                	lui	a5,0x1
    8000a662:	97b6                	add	a5,a5,a3
    8000a664:	2b87b683          	ld	a3,696(a5) # 12b8 <_entry-0x7fffed48>
    8000a668:	fe843603          	ld	a2,-24(s0)
    8000a66c:	87ba                	mv	a5,a4
    8000a66e:	078e                	slli	a5,a5,0x3
    8000a670:	97ba                	add	a5,a5,a4
    8000a672:	0796                	slli	a5,a5,0x5
    8000a674:	97b2                	add	a5,a5,a2
    8000a676:	1587b783          	ld	a5,344(a5)
    8000a67a:	fefc                	sd	a5,248(a3)
  proc->trapframe->ra = proc->thrd_context[context_id].ra;
    8000a67c:	fe442703          	lw	a4,-28(s0)
    8000a680:	fe843683          	ld	a3,-24(s0)
    8000a684:	6785                	lui	a5,0x1
    8000a686:	97b6                	add	a5,a5,a3
    8000a688:	2b87b683          	ld	a3,696(a5) # 12b8 <_entry-0x7fffed48>
    8000a68c:	fe843603          	ld	a2,-24(s0)
    8000a690:	87ba                	mv	a5,a4
    8000a692:	078e                	slli	a5,a5,0x3
    8000a694:	97ba                	add	a5,a5,a4
    8000a696:	0796                	slli	a5,a5,0x5
    8000a698:	97b2                	add	a5,a5,a2
    8000a69a:	67dc                	ld	a5,136(a5)
    8000a69c:	f69c                	sd	a5,40(a3)
  proc->trapframe->sp = proc->thrd_context[context_id].sp;
    8000a69e:	fe442703          	lw	a4,-28(s0)
    8000a6a2:	fe843683          	ld	a3,-24(s0)
    8000a6a6:	6785                	lui	a5,0x1
    8000a6a8:	97b6                	add	a5,a5,a3
    8000a6aa:	2b87b683          	ld	a3,696(a5) # 12b8 <_entry-0x7fffed48>
    8000a6ae:	fe843603          	ld	a2,-24(s0)
    8000a6b2:	87ba                	mv	a5,a4
    8000a6b4:	078e                	slli	a5,a5,0x3
    8000a6b6:	97ba                	add	a5,a5,a4
    8000a6b8:	0796                	slli	a5,a5,0x5
    8000a6ba:	97b2                	add	a5,a5,a2
    8000a6bc:	6bdc                	ld	a5,144(a5)
    8000a6be:	fa9c                	sd	a5,48(a3)
  proc->trapframe->t0 = proc->thrd_context[context_id].t0;
    8000a6c0:	fe442703          	lw	a4,-28(s0)
    8000a6c4:	fe843683          	ld	a3,-24(s0)
    8000a6c8:	6785                	lui	a5,0x1
    8000a6ca:	97b6                	add	a5,a5,a3
    8000a6cc:	2b87b683          	ld	a3,696(a5) # 12b8 <_entry-0x7fffed48>
    8000a6d0:	fe843603          	ld	a2,-24(s0)
    8000a6d4:	87ba                	mv	a5,a4
    8000a6d6:	078e                	slli	a5,a5,0x3
    8000a6d8:	97ba                	add	a5,a5,a4
    8000a6da:	0796                	slli	a5,a5,0x5
    8000a6dc:	97b2                	add	a5,a5,a2
    8000a6de:	77dc                	ld	a5,168(a5)
    8000a6e0:	e6bc                	sd	a5,72(a3)
  proc->trapframe->t1 = proc->thrd_context[context_id].t1;
    8000a6e2:	fe442703          	lw	a4,-28(s0)
    8000a6e6:	fe843683          	ld	a3,-24(s0)
    8000a6ea:	6785                	lui	a5,0x1
    8000a6ec:	97b6                	add	a5,a5,a3
    8000a6ee:	2b87b683          	ld	a3,696(a5) # 12b8 <_entry-0x7fffed48>
    8000a6f2:	fe843603          	ld	a2,-24(s0)
    8000a6f6:	87ba                	mv	a5,a4
    8000a6f8:	078e                	slli	a5,a5,0x3
    8000a6fa:	97ba                	add	a5,a5,a4
    8000a6fc:	0796                	slli	a5,a5,0x5
    8000a6fe:	97b2                	add	a5,a5,a2
    8000a700:	7bdc                	ld	a5,176(a5)
    8000a702:	eabc                	sd	a5,80(a3)
  proc->trapframe->t2 = proc->thrd_context[context_id].t2;
    8000a704:	fe442703          	lw	a4,-28(s0)
    8000a708:	fe843683          	ld	a3,-24(s0)
    8000a70c:	6785                	lui	a5,0x1
    8000a70e:	97b6                	add	a5,a5,a3
    8000a710:	2b87b683          	ld	a3,696(a5) # 12b8 <_entry-0x7fffed48>
    8000a714:	fe843603          	ld	a2,-24(s0)
    8000a718:	87ba                	mv	a5,a4
    8000a71a:	078e                	slli	a5,a5,0x3
    8000a71c:	97ba                	add	a5,a5,a4
    8000a71e:	0796                	slli	a5,a5,0x5
    8000a720:	97b2                	add	a5,a5,a2
    8000a722:	7fdc                	ld	a5,184(a5)
    8000a724:	eebc                	sd	a5,88(a3)
  proc->trapframe->t3 = proc->thrd_context[context_id].t3;
    8000a726:	fe442703          	lw	a4,-28(s0)
    8000a72a:	fe843683          	ld	a3,-24(s0)
    8000a72e:	6785                	lui	a5,0x1
    8000a730:	97b6                	add	a5,a5,a3
    8000a732:	2b87b683          	ld	a3,696(a5) # 12b8 <_entry-0x7fffed48>
    8000a736:	fe843603          	ld	a2,-24(s0)
    8000a73a:	87ba                	mv	a5,a4
    8000a73c:	078e                	slli	a5,a5,0x3
    8000a73e:	97ba                	add	a5,a5,a4
    8000a740:	0796                	slli	a5,a5,0x5
    8000a742:	97b2                	add	a5,a5,a2
    8000a744:	1607b783          	ld	a5,352(a5)
    8000a748:	10f6b023          	sd	a5,256(a3)
  proc->trapframe->t4 = proc->thrd_context[context_id].t4;
    8000a74c:	fe442703          	lw	a4,-28(s0)
    8000a750:	fe843683          	ld	a3,-24(s0)
    8000a754:	6785                	lui	a5,0x1
    8000a756:	97b6                	add	a5,a5,a3
    8000a758:	2b87b683          	ld	a3,696(a5) # 12b8 <_entry-0x7fffed48>
    8000a75c:	fe843603          	ld	a2,-24(s0)
    8000a760:	87ba                	mv	a5,a4
    8000a762:	078e                	slli	a5,a5,0x3
    8000a764:	97ba                	add	a5,a5,a4
    8000a766:	0796                	slli	a5,a5,0x5
    8000a768:	97b2                	add	a5,a5,a2
    8000a76a:	1687b783          	ld	a5,360(a5)
    8000a76e:	10f6b423          	sd	a5,264(a3)
  proc->trapframe->t5 = proc->thrd_context[context_id].t5;
    8000a772:	fe442703          	lw	a4,-28(s0)
    8000a776:	fe843683          	ld	a3,-24(s0)
    8000a77a:	6785                	lui	a5,0x1
    8000a77c:	97b6                	add	a5,a5,a3
    8000a77e:	2b87b683          	ld	a3,696(a5) # 12b8 <_entry-0x7fffed48>
    8000a782:	fe843603          	ld	a2,-24(s0)
    8000a786:	87ba                	mv	a5,a4
    8000a788:	078e                	slli	a5,a5,0x3
    8000a78a:	97ba                	add	a5,a5,a4
    8000a78c:	0796                	slli	a5,a5,0x5
    8000a78e:	97b2                	add	a5,a5,a2
    8000a790:	1707b783          	ld	a5,368(a5)
    8000a794:	10f6b823          	sd	a5,272(a3)
  proc->trapframe->t6 = proc->thrd_context[context_id].t6;
    8000a798:	fe442703          	lw	a4,-28(s0)
    8000a79c:	fe843683          	ld	a3,-24(s0)
    8000a7a0:	6785                	lui	a5,0x1
    8000a7a2:	97b6                	add	a5,a5,a3
    8000a7a4:	2b87b683          	ld	a3,696(a5) # 12b8 <_entry-0x7fffed48>
    8000a7a8:	fe843603          	ld	a2,-24(s0)
    8000a7ac:	87ba                	mv	a5,a4
    8000a7ae:	078e                	slli	a5,a5,0x3
    8000a7b0:	97ba                	add	a5,a5,a4
    8000a7b2:	0796                	slli	a5,a5,0x5
    8000a7b4:	97b2                	add	a5,a5,a2
    8000a7b6:	1787b783          	ld	a5,376(a5)
    8000a7ba:	10f6bc23          	sd	a5,280(a3)
  proc->trapframe->a0 = proc->thrd_context[context_id].a0;
    8000a7be:	fe442703          	lw	a4,-28(s0)
    8000a7c2:	fe843683          	ld	a3,-24(s0)
    8000a7c6:	6785                	lui	a5,0x1
    8000a7c8:	97b6                	add	a5,a5,a3
    8000a7ca:	2b87b683          	ld	a3,696(a5) # 12b8 <_entry-0x7fffed48>
    8000a7ce:	fe843603          	ld	a2,-24(s0)
    8000a7d2:	87ba                	mv	a5,a4
    8000a7d4:	078e                	slli	a5,a5,0x3
    8000a7d6:	97ba                	add	a5,a5,a4
    8000a7d8:	0796                	slli	a5,a5,0x5
    8000a7da:	97b2                	add	a5,a5,a2
    8000a7dc:	6bfc                	ld	a5,208(a5)
    8000a7de:	fabc                	sd	a5,112(a3)
  proc->trapframe->a1 = proc->thrd_context[context_id].a1;
    8000a7e0:	fe442703          	lw	a4,-28(s0)
    8000a7e4:	fe843683          	ld	a3,-24(s0)
    8000a7e8:	6785                	lui	a5,0x1
    8000a7ea:	97b6                	add	a5,a5,a3
    8000a7ec:	2b87b683          	ld	a3,696(a5) # 12b8 <_entry-0x7fffed48>
    8000a7f0:	fe843603          	ld	a2,-24(s0)
    8000a7f4:	87ba                	mv	a5,a4
    8000a7f6:	078e                	slli	a5,a5,0x3
    8000a7f8:	97ba                	add	a5,a5,a4
    8000a7fa:	0796                	slli	a5,a5,0x5
    8000a7fc:	97b2                	add	a5,a5,a2
    8000a7fe:	6ffc                	ld	a5,216(a5)
    8000a800:	febc                	sd	a5,120(a3)
  proc->trapframe->a2 = proc->thrd_context[context_id].a2;
    8000a802:	fe442703          	lw	a4,-28(s0)
    8000a806:	fe843683          	ld	a3,-24(s0)
    8000a80a:	6785                	lui	a5,0x1
    8000a80c:	97b6                	add	a5,a5,a3
    8000a80e:	2b87b683          	ld	a3,696(a5) # 12b8 <_entry-0x7fffed48>
    8000a812:	fe843603          	ld	a2,-24(s0)
    8000a816:	87ba                	mv	a5,a4
    8000a818:	078e                	slli	a5,a5,0x3
    8000a81a:	97ba                	add	a5,a5,a4
    8000a81c:	0796                	slli	a5,a5,0x5
    8000a81e:	97b2                	add	a5,a5,a2
    8000a820:	73fc                	ld	a5,224(a5)
    8000a822:	e2dc                	sd	a5,128(a3)
  proc->trapframe->a3 = proc->thrd_context[context_id].a3;
    8000a824:	fe442703          	lw	a4,-28(s0)
    8000a828:	fe843683          	ld	a3,-24(s0)
    8000a82c:	6785                	lui	a5,0x1
    8000a82e:	97b6                	add	a5,a5,a3
    8000a830:	2b87b683          	ld	a3,696(a5) # 12b8 <_entry-0x7fffed48>
    8000a834:	fe843603          	ld	a2,-24(s0)
    8000a838:	87ba                	mv	a5,a4
    8000a83a:	078e                	slli	a5,a5,0x3
    8000a83c:	97ba                	add	a5,a5,a4
    8000a83e:	0796                	slli	a5,a5,0x5
    8000a840:	97b2                	add	a5,a5,a2
    8000a842:	77fc                	ld	a5,232(a5)
    8000a844:	e6dc                	sd	a5,136(a3)
  proc->trapframe->a4 = proc->thrd_context[context_id].a4;
    8000a846:	fe442703          	lw	a4,-28(s0)
    8000a84a:	fe843683          	ld	a3,-24(s0)
    8000a84e:	6785                	lui	a5,0x1
    8000a850:	97b6                	add	a5,a5,a3
    8000a852:	2b87b683          	ld	a3,696(a5) # 12b8 <_entry-0x7fffed48>
    8000a856:	fe843603          	ld	a2,-24(s0)
    8000a85a:	87ba                	mv	a5,a4
    8000a85c:	078e                	slli	a5,a5,0x3
    8000a85e:	97ba                	add	a5,a5,a4
    8000a860:	0796                	slli	a5,a5,0x5
    8000a862:	97b2                	add	a5,a5,a2
    8000a864:	7bfc                	ld	a5,240(a5)
    8000a866:	eadc                	sd	a5,144(a3)
  proc->trapframe->a5 = proc->thrd_context[context_id].a5;
    8000a868:	fe442703          	lw	a4,-28(s0)
    8000a86c:	fe843683          	ld	a3,-24(s0)
    8000a870:	6785                	lui	a5,0x1
    8000a872:	97b6                	add	a5,a5,a3
    8000a874:	2b87b683          	ld	a3,696(a5) # 12b8 <_entry-0x7fffed48>
    8000a878:	fe843603          	ld	a2,-24(s0)
    8000a87c:	87ba                	mv	a5,a4
    8000a87e:	078e                	slli	a5,a5,0x3
    8000a880:	97ba                	add	a5,a5,a4
    8000a882:	0796                	slli	a5,a5,0x5
    8000a884:	97b2                	add	a5,a5,a2
    8000a886:	7ffc                	ld	a5,248(a5)
    8000a888:	eedc                	sd	a5,152(a3)
  proc->trapframe->a6 = proc->thrd_context[context_id].a6;
    8000a88a:	fe442703          	lw	a4,-28(s0)
    8000a88e:	fe843683          	ld	a3,-24(s0)
    8000a892:	6785                	lui	a5,0x1
    8000a894:	97b6                	add	a5,a5,a3
    8000a896:	2b87b683          	ld	a3,696(a5) # 12b8 <_entry-0x7fffed48>
    8000a89a:	fe843603          	ld	a2,-24(s0)
    8000a89e:	87ba                	mv	a5,a4
    8000a8a0:	078e                	slli	a5,a5,0x3
    8000a8a2:	97ba                	add	a5,a5,a4
    8000a8a4:	0796                	slli	a5,a5,0x5
    8000a8a6:	97b2                	add	a5,a5,a2
    8000a8a8:	1007b783          	ld	a5,256(a5)
    8000a8ac:	f2dc                	sd	a5,160(a3)
  proc->trapframe->a7 = proc->thrd_context[context_id].a7;
    8000a8ae:	fe442703          	lw	a4,-28(s0)
    8000a8b2:	fe843683          	ld	a3,-24(s0)
    8000a8b6:	6785                	lui	a5,0x1
    8000a8b8:	97b6                	add	a5,a5,a3
    8000a8ba:	2b87b683          	ld	a3,696(a5) # 12b8 <_entry-0x7fffed48>
    8000a8be:	fe843603          	ld	a2,-24(s0)
    8000a8c2:	87ba                	mv	a5,a4
    8000a8c4:	078e                	slli	a5,a5,0x3
    8000a8c6:	97ba                	add	a5,a5,a4
    8000a8c8:	0796                	slli	a5,a5,0x5
    8000a8ca:	97b2                	add	a5,a5,a2
    8000a8cc:	1087b783          	ld	a5,264(a5)
    8000a8d0:	f6dc                	sd	a5,168(a3)
  proc->trapframe->gp = proc->thrd_context[context_id].gp;
    8000a8d2:	fe442703          	lw	a4,-28(s0)
    8000a8d6:	fe843683          	ld	a3,-24(s0)
    8000a8da:	6785                	lui	a5,0x1
    8000a8dc:	97b6                	add	a5,a5,a3
    8000a8de:	2b87b683          	ld	a3,696(a5) # 12b8 <_entry-0x7fffed48>
    8000a8e2:	fe843603          	ld	a2,-24(s0)
    8000a8e6:	87ba                	mv	a5,a4
    8000a8e8:	078e                	slli	a5,a5,0x3
    8000a8ea:	97ba                	add	a5,a5,a4
    8000a8ec:	0796                	slli	a5,a5,0x5
    8000a8ee:	97b2                	add	a5,a5,a2
    8000a8f0:	6fdc                	ld	a5,152(a5)
    8000a8f2:	fe9c                	sd	a5,56(a3)
  proc->trapframe->tp = proc->thrd_context[context_id].tp;
    8000a8f4:	fe442703          	lw	a4,-28(s0)
    8000a8f8:	fe843683          	ld	a3,-24(s0)
    8000a8fc:	6785                	lui	a5,0x1
    8000a8fe:	97b6                	add	a5,a5,a3
    8000a900:	2b87b683          	ld	a3,696(a5) # 12b8 <_entry-0x7fffed48>
    8000a904:	fe843603          	ld	a2,-24(s0)
    8000a908:	87ba                	mv	a5,a4
    8000a90a:	078e                	slli	a5,a5,0x3
    8000a90c:	97ba                	add	a5,a5,a4
    8000a90e:	0796                	slli	a5,a5,0x5
    8000a910:	97b2                	add	a5,a5,a2
    8000a912:	73dc                	ld	a5,160(a5)
    8000a914:	e2bc                	sd	a5,64(a3)

  return 0;
    8000a916:	4781                	li	a5,0
}
    8000a918:	853e                	mv	a0,a5
    8000a91a:	60e2                	ld	ra,24(sp)
    8000a91c:	6442                	ld	s0,16(sp)
    8000a91e:	6105                	addi	sp,sp,32
    8000a920:	8082                	ret
	...

000000008000b000 <_trampoline>:
    8000b000:	14051573          	csrrw	a0,sscratch,a0
    8000b004:	02153423          	sd	ra,40(a0)
    8000b008:	02253823          	sd	sp,48(a0)
    8000b00c:	02353c23          	sd	gp,56(a0)
    8000b010:	04453023          	sd	tp,64(a0)
    8000b014:	04553423          	sd	t0,72(a0)
    8000b018:	04653823          	sd	t1,80(a0)
    8000b01c:	04753c23          	sd	t2,88(a0)
    8000b020:	f120                	sd	s0,96(a0)
    8000b022:	f524                	sd	s1,104(a0)
    8000b024:	fd2c                	sd	a1,120(a0)
    8000b026:	e150                	sd	a2,128(a0)
    8000b028:	e554                	sd	a3,136(a0)
    8000b02a:	e958                	sd	a4,144(a0)
    8000b02c:	ed5c                	sd	a5,152(a0)
    8000b02e:	0b053023          	sd	a6,160(a0)
    8000b032:	0b153423          	sd	a7,168(a0)
    8000b036:	0b253823          	sd	s2,176(a0)
    8000b03a:	0b353c23          	sd	s3,184(a0)
    8000b03e:	0d453023          	sd	s4,192(a0)
    8000b042:	0d553423          	sd	s5,200(a0)
    8000b046:	0d653823          	sd	s6,208(a0)
    8000b04a:	0d753c23          	sd	s7,216(a0)
    8000b04e:	0f853023          	sd	s8,224(a0)
    8000b052:	0f953423          	sd	s9,232(a0)
    8000b056:	0fa53823          	sd	s10,240(a0)
    8000b05a:	0fb53c23          	sd	s11,248(a0)
    8000b05e:	11c53023          	sd	t3,256(a0)
    8000b062:	11d53423          	sd	t4,264(a0)
    8000b066:	11e53823          	sd	t5,272(a0)
    8000b06a:	11f53c23          	sd	t6,280(a0)
    8000b06e:	140022f3          	csrr	t0,sscratch
    8000b072:	06553823          	sd	t0,112(a0)
    8000b076:	00853103          	ld	sp,8(a0)
    8000b07a:	02053203          	ld	tp,32(a0)
    8000b07e:	01053283          	ld	t0,16(a0)
    8000b082:	00053303          	ld	t1,0(a0)
    8000b086:	18031073          	csrw	satp,t1
    8000b08a:	12000073          	sfence.vma
    8000b08e:	8282                	jr	t0

000000008000b090 <userret>:
    8000b090:	18059073          	csrw	satp,a1
    8000b094:	12000073          	sfence.vma
    8000b098:	07053283          	ld	t0,112(a0)
    8000b09c:	14029073          	csrw	sscratch,t0
    8000b0a0:	02853083          	ld	ra,40(a0)
    8000b0a4:	03053103          	ld	sp,48(a0)
    8000b0a8:	03853183          	ld	gp,56(a0)
    8000b0ac:	04053203          	ld	tp,64(a0)
    8000b0b0:	04853283          	ld	t0,72(a0)
    8000b0b4:	05053303          	ld	t1,80(a0)
    8000b0b8:	05853383          	ld	t2,88(a0)
    8000b0bc:	7120                	ld	s0,96(a0)
    8000b0be:	7524                	ld	s1,104(a0)
    8000b0c0:	7d2c                	ld	a1,120(a0)
    8000b0c2:	6150                	ld	a2,128(a0)
    8000b0c4:	6554                	ld	a3,136(a0)
    8000b0c6:	6958                	ld	a4,144(a0)
    8000b0c8:	6d5c                	ld	a5,152(a0)
    8000b0ca:	0a053803          	ld	a6,160(a0)
    8000b0ce:	0a853883          	ld	a7,168(a0)
    8000b0d2:	0b053903          	ld	s2,176(a0)
    8000b0d6:	0b853983          	ld	s3,184(a0)
    8000b0da:	0c053a03          	ld	s4,192(a0)
    8000b0de:	0c853a83          	ld	s5,200(a0)
    8000b0e2:	0d053b03          	ld	s6,208(a0)
    8000b0e6:	0d853b83          	ld	s7,216(a0)
    8000b0ea:	0e053c03          	ld	s8,224(a0)
    8000b0ee:	0e853c83          	ld	s9,232(a0)
    8000b0f2:	0f053d03          	ld	s10,240(a0)
    8000b0f6:	0f853d83          	ld	s11,248(a0)
    8000b0fa:	10053e03          	ld	t3,256(a0)
    8000b0fe:	10853e83          	ld	t4,264(a0)
    8000b102:	11053f03          	ld	t5,272(a0)
    8000b106:	11853f83          	ld	t6,280(a0)
    8000b10a:	14051573          	csrrw	a0,sscratch,a0
    8000b10e:	10200073          	sret
	...
