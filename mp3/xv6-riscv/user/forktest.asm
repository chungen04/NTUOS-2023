
user/_forktest:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <print>:

#define N  1000

void
print(const char *s)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	1000                	addi	s0,sp,32
   8:	fea43423          	sd	a0,-24(s0)
  write(1, s, strlen(s));
   c:	fe843503          	ld	a0,-24(s0)
  10:	00000097          	auipc	ra,0x0
  14:	208080e7          	jalr	520(ra) # 218 <strlen>
  18:	87aa                	mv	a5,a0
  1a:	2781                	sext.w	a5,a5
  1c:	2781                	sext.w	a5,a5
  1e:	863e                	mv	a2,a5
  20:	fe843583          	ld	a1,-24(s0)
  24:	4505                	li	a0,1
  26:	00000097          	auipc	ra,0x0
  2a:	5f2080e7          	jalr	1522(ra) # 618 <write>
}
  2e:	0001                	nop
  30:	60e2                	ld	ra,24(sp)
  32:	6442                	ld	s0,16(sp)
  34:	6105                	addi	sp,sp,32
  36:	8082                	ret

0000000000000038 <forktest>:

void
forktest(void)
{
  38:	1101                	addi	sp,sp,-32
  3a:	ec06                	sd	ra,24(sp)
  3c:	e822                	sd	s0,16(sp)
  3e:	1000                	addi	s0,sp,32
  int n, pid;

  print("fork test\n");
  40:	00000517          	auipc	a0,0x0
  44:	67050513          	addi	a0,a0,1648 # 6b0 <cancelthrdstop+0x8>
  48:	00000097          	auipc	ra,0x0
  4c:	fb8080e7          	jalr	-72(ra) # 0 <print>

  for(n=0; n<N; n++){
  50:	fe042623          	sw	zero,-20(s0)
  54:	a81d                	j	8a <forktest+0x52>
    pid = fork();
  56:	00000097          	auipc	ra,0x0
  5a:	59a080e7          	jalr	1434(ra) # 5f0 <fork>
  5e:	87aa                	mv	a5,a0
  60:	fef42423          	sw	a5,-24(s0)
    if(pid < 0)
  64:	fe842783          	lw	a5,-24(s0)
  68:	2781                	sext.w	a5,a5
  6a:	0207c963          	bltz	a5,9c <forktest+0x64>
      break;
    if(pid == 0)
  6e:	fe842783          	lw	a5,-24(s0)
  72:	2781                	sext.w	a5,a5
  74:	e791                	bnez	a5,80 <forktest+0x48>
      exit(0);
  76:	4501                	li	a0,0
  78:	00000097          	auipc	ra,0x0
  7c:	580080e7          	jalr	1408(ra) # 5f8 <exit>
  for(n=0; n<N; n++){
  80:	fec42783          	lw	a5,-20(s0)
  84:	2785                	addiw	a5,a5,1
  86:	fef42623          	sw	a5,-20(s0)
  8a:	fec42783          	lw	a5,-20(s0)
  8e:	0007871b          	sext.w	a4,a5
  92:	3e700793          	li	a5,999
  96:	fce7d0e3          	bge	a5,a4,56 <forktest+0x1e>
  9a:	a011                	j	9e <forktest+0x66>
      break;
  9c:	0001                	nop
  }

  if(n == N){
  9e:	fec42783          	lw	a5,-20(s0)
  a2:	0007871b          	sext.w	a4,a5
  a6:	3e800793          	li	a5,1000
  aa:	04f71963          	bne	a4,a5,fc <forktest+0xc4>
    print("fork claimed to work N times!\n");
  ae:	00000517          	auipc	a0,0x0
  b2:	61250513          	addi	a0,a0,1554 # 6c0 <cancelthrdstop+0x18>
  b6:	00000097          	auipc	ra,0x0
  ba:	f4a080e7          	jalr	-182(ra) # 0 <print>
    exit(1);
  be:	4505                	li	a0,1
  c0:	00000097          	auipc	ra,0x0
  c4:	538080e7          	jalr	1336(ra) # 5f8 <exit>
  }

  for(; n > 0; n--){
    if(wait(0) < 0){
  c8:	4501                	li	a0,0
  ca:	00000097          	auipc	ra,0x0
  ce:	536080e7          	jalr	1334(ra) # 600 <wait>
  d2:	87aa                	mv	a5,a0
  d4:	0007df63          	bgez	a5,f2 <forktest+0xba>
      print("wait stopped early\n");
  d8:	00000517          	auipc	a0,0x0
  dc:	60850513          	addi	a0,a0,1544 # 6e0 <cancelthrdstop+0x38>
  e0:	00000097          	auipc	ra,0x0
  e4:	f20080e7          	jalr	-224(ra) # 0 <print>
      exit(1);
  e8:	4505                	li	a0,1
  ea:	00000097          	auipc	ra,0x0
  ee:	50e080e7          	jalr	1294(ra) # 5f8 <exit>
  for(; n > 0; n--){
  f2:	fec42783          	lw	a5,-20(s0)
  f6:	37fd                	addiw	a5,a5,-1
  f8:	fef42623          	sw	a5,-20(s0)
  fc:	fec42783          	lw	a5,-20(s0)
 100:	2781                	sext.w	a5,a5
 102:	fcf043e3          	bgtz	a5,c8 <forktest+0x90>
    }
  }

  if(wait(0) != -1){
 106:	4501                	li	a0,0
 108:	00000097          	auipc	ra,0x0
 10c:	4f8080e7          	jalr	1272(ra) # 600 <wait>
 110:	87aa                	mv	a5,a0
 112:	873e                	mv	a4,a5
 114:	57fd                	li	a5,-1
 116:	00f70f63          	beq	a4,a5,134 <forktest+0xfc>
    print("wait got too many\n");
 11a:	00000517          	auipc	a0,0x0
 11e:	5de50513          	addi	a0,a0,1502 # 6f8 <cancelthrdstop+0x50>
 122:	00000097          	auipc	ra,0x0
 126:	ede080e7          	jalr	-290(ra) # 0 <print>
    exit(1);
 12a:	4505                	li	a0,1
 12c:	00000097          	auipc	ra,0x0
 130:	4cc080e7          	jalr	1228(ra) # 5f8 <exit>
  }

  print("fork test OK\n");
 134:	00000517          	auipc	a0,0x0
 138:	5dc50513          	addi	a0,a0,1500 # 710 <cancelthrdstop+0x68>
 13c:	00000097          	auipc	ra,0x0
 140:	ec4080e7          	jalr	-316(ra) # 0 <print>
}
 144:	0001                	nop
 146:	60e2                	ld	ra,24(sp)
 148:	6442                	ld	s0,16(sp)
 14a:	6105                	addi	sp,sp,32
 14c:	8082                	ret

000000000000014e <main>:

int
main(void)
{
 14e:	1141                	addi	sp,sp,-16
 150:	e406                	sd	ra,8(sp)
 152:	e022                	sd	s0,0(sp)
 154:	0800                	addi	s0,sp,16
  forktest();
 156:	00000097          	auipc	ra,0x0
 15a:	ee2080e7          	jalr	-286(ra) # 38 <forktest>
  exit(0);
 15e:	4501                	li	a0,0
 160:	00000097          	auipc	ra,0x0
 164:	498080e7          	jalr	1176(ra) # 5f8 <exit>

0000000000000168 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 168:	7179                	addi	sp,sp,-48
 16a:	f422                	sd	s0,40(sp)
 16c:	1800                	addi	s0,sp,48
 16e:	fca43c23          	sd	a0,-40(s0)
 172:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
 176:	fd843783          	ld	a5,-40(s0)
 17a:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
 17e:	0001                	nop
 180:	fd043703          	ld	a4,-48(s0)
 184:	00170793          	addi	a5,a4,1
 188:	fcf43823          	sd	a5,-48(s0)
 18c:	fd843783          	ld	a5,-40(s0)
 190:	00178693          	addi	a3,a5,1
 194:	fcd43c23          	sd	a3,-40(s0)
 198:	00074703          	lbu	a4,0(a4)
 19c:	00e78023          	sb	a4,0(a5)
 1a0:	0007c783          	lbu	a5,0(a5)
 1a4:	fff1                	bnez	a5,180 <strcpy+0x18>
    ;
  return os;
 1a6:	fe843783          	ld	a5,-24(s0)
}
 1aa:	853e                	mv	a0,a5
 1ac:	7422                	ld	s0,40(sp)
 1ae:	6145                	addi	sp,sp,48
 1b0:	8082                	ret

00000000000001b2 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1b2:	1101                	addi	sp,sp,-32
 1b4:	ec22                	sd	s0,24(sp)
 1b6:	1000                	addi	s0,sp,32
 1b8:	fea43423          	sd	a0,-24(s0)
 1bc:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
 1c0:	a819                	j	1d6 <strcmp+0x24>
    p++, q++;
 1c2:	fe843783          	ld	a5,-24(s0)
 1c6:	0785                	addi	a5,a5,1
 1c8:	fef43423          	sd	a5,-24(s0)
 1cc:	fe043783          	ld	a5,-32(s0)
 1d0:	0785                	addi	a5,a5,1
 1d2:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
 1d6:	fe843783          	ld	a5,-24(s0)
 1da:	0007c783          	lbu	a5,0(a5)
 1de:	cb99                	beqz	a5,1f4 <strcmp+0x42>
 1e0:	fe843783          	ld	a5,-24(s0)
 1e4:	0007c703          	lbu	a4,0(a5)
 1e8:	fe043783          	ld	a5,-32(s0)
 1ec:	0007c783          	lbu	a5,0(a5)
 1f0:	fcf709e3          	beq	a4,a5,1c2 <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
 1f4:	fe843783          	ld	a5,-24(s0)
 1f8:	0007c783          	lbu	a5,0(a5)
 1fc:	0007871b          	sext.w	a4,a5
 200:	fe043783          	ld	a5,-32(s0)
 204:	0007c783          	lbu	a5,0(a5)
 208:	2781                	sext.w	a5,a5
 20a:	40f707bb          	subw	a5,a4,a5
 20e:	2781                	sext.w	a5,a5
}
 210:	853e                	mv	a0,a5
 212:	6462                	ld	s0,24(sp)
 214:	6105                	addi	sp,sp,32
 216:	8082                	ret

0000000000000218 <strlen>:

uint
strlen(const char *s)
{
 218:	7179                	addi	sp,sp,-48
 21a:	f422                	sd	s0,40(sp)
 21c:	1800                	addi	s0,sp,48
 21e:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
 222:	fe042623          	sw	zero,-20(s0)
 226:	a031                	j	232 <strlen+0x1a>
 228:	fec42783          	lw	a5,-20(s0)
 22c:	2785                	addiw	a5,a5,1
 22e:	fef42623          	sw	a5,-20(s0)
 232:	fec42783          	lw	a5,-20(s0)
 236:	fd843703          	ld	a4,-40(s0)
 23a:	97ba                	add	a5,a5,a4
 23c:	0007c783          	lbu	a5,0(a5)
 240:	f7e5                	bnez	a5,228 <strlen+0x10>
    ;
  return n;
 242:	fec42783          	lw	a5,-20(s0)
}
 246:	853e                	mv	a0,a5
 248:	7422                	ld	s0,40(sp)
 24a:	6145                	addi	sp,sp,48
 24c:	8082                	ret

000000000000024e <memset>:

void*
memset(void *dst, int c, uint n)
{
 24e:	7179                	addi	sp,sp,-48
 250:	f422                	sd	s0,40(sp)
 252:	1800                	addi	s0,sp,48
 254:	fca43c23          	sd	a0,-40(s0)
 258:	87ae                	mv	a5,a1
 25a:	8732                	mv	a4,a2
 25c:	fcf42a23          	sw	a5,-44(s0)
 260:	87ba                	mv	a5,a4
 262:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
 266:	fd843783          	ld	a5,-40(s0)
 26a:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
 26e:	fe042623          	sw	zero,-20(s0)
 272:	a00d                	j	294 <memset+0x46>
    cdst[i] = c;
 274:	fec42783          	lw	a5,-20(s0)
 278:	fe043703          	ld	a4,-32(s0)
 27c:	97ba                	add	a5,a5,a4
 27e:	fd442703          	lw	a4,-44(s0)
 282:	0ff77713          	andi	a4,a4,255
 286:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
 28a:	fec42783          	lw	a5,-20(s0)
 28e:	2785                	addiw	a5,a5,1
 290:	fef42623          	sw	a5,-20(s0)
 294:	fec42703          	lw	a4,-20(s0)
 298:	fd042783          	lw	a5,-48(s0)
 29c:	2781                	sext.w	a5,a5
 29e:	fcf76be3          	bltu	a4,a5,274 <memset+0x26>
  }
  return dst;
 2a2:	fd843783          	ld	a5,-40(s0)
}
 2a6:	853e                	mv	a0,a5
 2a8:	7422                	ld	s0,40(sp)
 2aa:	6145                	addi	sp,sp,48
 2ac:	8082                	ret

00000000000002ae <strchr>:

char*
strchr(const char *s, char c)
{
 2ae:	1101                	addi	sp,sp,-32
 2b0:	ec22                	sd	s0,24(sp)
 2b2:	1000                	addi	s0,sp,32
 2b4:	fea43423          	sd	a0,-24(s0)
 2b8:	87ae                	mv	a5,a1
 2ba:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
 2be:	a01d                	j	2e4 <strchr+0x36>
    if(*s == c)
 2c0:	fe843783          	ld	a5,-24(s0)
 2c4:	0007c703          	lbu	a4,0(a5)
 2c8:	fe744783          	lbu	a5,-25(s0)
 2cc:	0ff7f793          	andi	a5,a5,255
 2d0:	00e79563          	bne	a5,a4,2da <strchr+0x2c>
      return (char*)s;
 2d4:	fe843783          	ld	a5,-24(s0)
 2d8:	a821                	j	2f0 <strchr+0x42>
  for(; *s; s++)
 2da:	fe843783          	ld	a5,-24(s0)
 2de:	0785                	addi	a5,a5,1
 2e0:	fef43423          	sd	a5,-24(s0)
 2e4:	fe843783          	ld	a5,-24(s0)
 2e8:	0007c783          	lbu	a5,0(a5)
 2ec:	fbf1                	bnez	a5,2c0 <strchr+0x12>
  return 0;
 2ee:	4781                	li	a5,0
}
 2f0:	853e                	mv	a0,a5
 2f2:	6462                	ld	s0,24(sp)
 2f4:	6105                	addi	sp,sp,32
 2f6:	8082                	ret

00000000000002f8 <gets>:

char*
gets(char *buf, int max)
{
 2f8:	7179                	addi	sp,sp,-48
 2fa:	f406                	sd	ra,40(sp)
 2fc:	f022                	sd	s0,32(sp)
 2fe:	1800                	addi	s0,sp,48
 300:	fca43c23          	sd	a0,-40(s0)
 304:	87ae                	mv	a5,a1
 306:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 30a:	fe042623          	sw	zero,-20(s0)
 30e:	a8a1                	j	366 <gets+0x6e>
    cc = read(0, &c, 1);
 310:	fe740793          	addi	a5,s0,-25
 314:	4605                	li	a2,1
 316:	85be                	mv	a1,a5
 318:	4501                	li	a0,0
 31a:	00000097          	auipc	ra,0x0
 31e:	2f6080e7          	jalr	758(ra) # 610 <read>
 322:	87aa                	mv	a5,a0
 324:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
 328:	fe842783          	lw	a5,-24(s0)
 32c:	2781                	sext.w	a5,a5
 32e:	04f05763          	blez	a5,37c <gets+0x84>
      break;
    buf[i++] = c;
 332:	fec42783          	lw	a5,-20(s0)
 336:	0017871b          	addiw	a4,a5,1
 33a:	fee42623          	sw	a4,-20(s0)
 33e:	873e                	mv	a4,a5
 340:	fd843783          	ld	a5,-40(s0)
 344:	97ba                	add	a5,a5,a4
 346:	fe744703          	lbu	a4,-25(s0)
 34a:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
 34e:	fe744783          	lbu	a5,-25(s0)
 352:	873e                	mv	a4,a5
 354:	47a9                	li	a5,10
 356:	02f70463          	beq	a4,a5,37e <gets+0x86>
 35a:	fe744783          	lbu	a5,-25(s0)
 35e:	873e                	mv	a4,a5
 360:	47b5                	li	a5,13
 362:	00f70e63          	beq	a4,a5,37e <gets+0x86>
  for(i=0; i+1 < max; ){
 366:	fec42783          	lw	a5,-20(s0)
 36a:	2785                	addiw	a5,a5,1
 36c:	0007871b          	sext.w	a4,a5
 370:	fd442783          	lw	a5,-44(s0)
 374:	2781                	sext.w	a5,a5
 376:	f8f74de3          	blt	a4,a5,310 <gets+0x18>
 37a:	a011                	j	37e <gets+0x86>
      break;
 37c:	0001                	nop
      break;
  }
  buf[i] = '\0';
 37e:	fec42783          	lw	a5,-20(s0)
 382:	fd843703          	ld	a4,-40(s0)
 386:	97ba                	add	a5,a5,a4
 388:	00078023          	sb	zero,0(a5)
  return buf;
 38c:	fd843783          	ld	a5,-40(s0)
}
 390:	853e                	mv	a0,a5
 392:	70a2                	ld	ra,40(sp)
 394:	7402                	ld	s0,32(sp)
 396:	6145                	addi	sp,sp,48
 398:	8082                	ret

000000000000039a <stat>:

int
stat(const char *n, struct stat *st)
{
 39a:	7179                	addi	sp,sp,-48
 39c:	f406                	sd	ra,40(sp)
 39e:	f022                	sd	s0,32(sp)
 3a0:	1800                	addi	s0,sp,48
 3a2:	fca43c23          	sd	a0,-40(s0)
 3a6:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3aa:	4581                	li	a1,0
 3ac:	fd843503          	ld	a0,-40(s0)
 3b0:	00000097          	auipc	ra,0x0
 3b4:	288080e7          	jalr	648(ra) # 638 <open>
 3b8:	87aa                	mv	a5,a0
 3ba:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
 3be:	fec42783          	lw	a5,-20(s0)
 3c2:	2781                	sext.w	a5,a5
 3c4:	0007d463          	bgez	a5,3cc <stat+0x32>
    return -1;
 3c8:	57fd                	li	a5,-1
 3ca:	a035                	j	3f6 <stat+0x5c>
  r = fstat(fd, st);
 3cc:	fec42783          	lw	a5,-20(s0)
 3d0:	fd043583          	ld	a1,-48(s0)
 3d4:	853e                	mv	a0,a5
 3d6:	00000097          	auipc	ra,0x0
 3da:	27a080e7          	jalr	634(ra) # 650 <fstat>
 3de:	87aa                	mv	a5,a0
 3e0:	fef42423          	sw	a5,-24(s0)
  close(fd);
 3e4:	fec42783          	lw	a5,-20(s0)
 3e8:	853e                	mv	a0,a5
 3ea:	00000097          	auipc	ra,0x0
 3ee:	236080e7          	jalr	566(ra) # 620 <close>
  return r;
 3f2:	fe842783          	lw	a5,-24(s0)
}
 3f6:	853e                	mv	a0,a5
 3f8:	70a2                	ld	ra,40(sp)
 3fa:	7402                	ld	s0,32(sp)
 3fc:	6145                	addi	sp,sp,48
 3fe:	8082                	ret

0000000000000400 <atoi>:

int
atoi(const char *s)
{
 400:	7179                	addi	sp,sp,-48
 402:	f422                	sd	s0,40(sp)
 404:	1800                	addi	s0,sp,48
 406:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
 40a:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
 40e:	a815                	j	442 <atoi+0x42>
    n = n*10 + *s++ - '0';
 410:	fec42703          	lw	a4,-20(s0)
 414:	87ba                	mv	a5,a4
 416:	0027979b          	slliw	a5,a5,0x2
 41a:	9fb9                	addw	a5,a5,a4
 41c:	0017979b          	slliw	a5,a5,0x1
 420:	0007871b          	sext.w	a4,a5
 424:	fd843783          	ld	a5,-40(s0)
 428:	00178693          	addi	a3,a5,1
 42c:	fcd43c23          	sd	a3,-40(s0)
 430:	0007c783          	lbu	a5,0(a5)
 434:	2781                	sext.w	a5,a5
 436:	9fb9                	addw	a5,a5,a4
 438:	2781                	sext.w	a5,a5
 43a:	fd07879b          	addiw	a5,a5,-48
 43e:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
 442:	fd843783          	ld	a5,-40(s0)
 446:	0007c783          	lbu	a5,0(a5)
 44a:	873e                	mv	a4,a5
 44c:	02f00793          	li	a5,47
 450:	00e7fb63          	bgeu	a5,a4,466 <atoi+0x66>
 454:	fd843783          	ld	a5,-40(s0)
 458:	0007c783          	lbu	a5,0(a5)
 45c:	873e                	mv	a4,a5
 45e:	03900793          	li	a5,57
 462:	fae7f7e3          	bgeu	a5,a4,410 <atoi+0x10>
  return n;
 466:	fec42783          	lw	a5,-20(s0)
}
 46a:	853e                	mv	a0,a5
 46c:	7422                	ld	s0,40(sp)
 46e:	6145                	addi	sp,sp,48
 470:	8082                	ret

0000000000000472 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 472:	7139                	addi	sp,sp,-64
 474:	fc22                	sd	s0,56(sp)
 476:	0080                	addi	s0,sp,64
 478:	fca43c23          	sd	a0,-40(s0)
 47c:	fcb43823          	sd	a1,-48(s0)
 480:	87b2                	mv	a5,a2
 482:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
 486:	fd843783          	ld	a5,-40(s0)
 48a:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
 48e:	fd043783          	ld	a5,-48(s0)
 492:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
 496:	fe043703          	ld	a4,-32(s0)
 49a:	fe843783          	ld	a5,-24(s0)
 49e:	02e7fc63          	bgeu	a5,a4,4d6 <memmove+0x64>
    while(n-- > 0)
 4a2:	a00d                	j	4c4 <memmove+0x52>
      *dst++ = *src++;
 4a4:	fe043703          	ld	a4,-32(s0)
 4a8:	00170793          	addi	a5,a4,1
 4ac:	fef43023          	sd	a5,-32(s0)
 4b0:	fe843783          	ld	a5,-24(s0)
 4b4:	00178693          	addi	a3,a5,1
 4b8:	fed43423          	sd	a3,-24(s0)
 4bc:	00074703          	lbu	a4,0(a4)
 4c0:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 4c4:	fcc42783          	lw	a5,-52(s0)
 4c8:	fff7871b          	addiw	a4,a5,-1
 4cc:	fce42623          	sw	a4,-52(s0)
 4d0:	fcf04ae3          	bgtz	a5,4a4 <memmove+0x32>
 4d4:	a891                	j	528 <memmove+0xb6>
  } else {
    dst += n;
 4d6:	fcc42783          	lw	a5,-52(s0)
 4da:	fe843703          	ld	a4,-24(s0)
 4de:	97ba                	add	a5,a5,a4
 4e0:	fef43423          	sd	a5,-24(s0)
    src += n;
 4e4:	fcc42783          	lw	a5,-52(s0)
 4e8:	fe043703          	ld	a4,-32(s0)
 4ec:	97ba                	add	a5,a5,a4
 4ee:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
 4f2:	a01d                	j	518 <memmove+0xa6>
      *--dst = *--src;
 4f4:	fe043783          	ld	a5,-32(s0)
 4f8:	17fd                	addi	a5,a5,-1
 4fa:	fef43023          	sd	a5,-32(s0)
 4fe:	fe843783          	ld	a5,-24(s0)
 502:	17fd                	addi	a5,a5,-1
 504:	fef43423          	sd	a5,-24(s0)
 508:	fe043783          	ld	a5,-32(s0)
 50c:	0007c703          	lbu	a4,0(a5)
 510:	fe843783          	ld	a5,-24(s0)
 514:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 518:	fcc42783          	lw	a5,-52(s0)
 51c:	fff7871b          	addiw	a4,a5,-1
 520:	fce42623          	sw	a4,-52(s0)
 524:	fcf048e3          	bgtz	a5,4f4 <memmove+0x82>
  }
  return vdst;
 528:	fd843783          	ld	a5,-40(s0)
}
 52c:	853e                	mv	a0,a5
 52e:	7462                	ld	s0,56(sp)
 530:	6121                	addi	sp,sp,64
 532:	8082                	ret

0000000000000534 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 534:	7139                	addi	sp,sp,-64
 536:	fc22                	sd	s0,56(sp)
 538:	0080                	addi	s0,sp,64
 53a:	fca43c23          	sd	a0,-40(s0)
 53e:	fcb43823          	sd	a1,-48(s0)
 542:	87b2                	mv	a5,a2
 544:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
 548:	fd843783          	ld	a5,-40(s0)
 54c:	fef43423          	sd	a5,-24(s0)
 550:	fd043783          	ld	a5,-48(s0)
 554:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 558:	a0a1                	j	5a0 <memcmp+0x6c>
    if (*p1 != *p2) {
 55a:	fe843783          	ld	a5,-24(s0)
 55e:	0007c703          	lbu	a4,0(a5)
 562:	fe043783          	ld	a5,-32(s0)
 566:	0007c783          	lbu	a5,0(a5)
 56a:	02f70163          	beq	a4,a5,58c <memcmp+0x58>
      return *p1 - *p2;
 56e:	fe843783          	ld	a5,-24(s0)
 572:	0007c783          	lbu	a5,0(a5)
 576:	0007871b          	sext.w	a4,a5
 57a:	fe043783          	ld	a5,-32(s0)
 57e:	0007c783          	lbu	a5,0(a5)
 582:	2781                	sext.w	a5,a5
 584:	40f707bb          	subw	a5,a4,a5
 588:	2781                	sext.w	a5,a5
 58a:	a01d                	j	5b0 <memcmp+0x7c>
    }
    p1++;
 58c:	fe843783          	ld	a5,-24(s0)
 590:	0785                	addi	a5,a5,1
 592:	fef43423          	sd	a5,-24(s0)
    p2++;
 596:	fe043783          	ld	a5,-32(s0)
 59a:	0785                	addi	a5,a5,1
 59c:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 5a0:	fcc42783          	lw	a5,-52(s0)
 5a4:	fff7871b          	addiw	a4,a5,-1
 5a8:	fce42623          	sw	a4,-52(s0)
 5ac:	f7dd                	bnez	a5,55a <memcmp+0x26>
  }
  return 0;
 5ae:	4781                	li	a5,0
}
 5b0:	853e                	mv	a0,a5
 5b2:	7462                	ld	s0,56(sp)
 5b4:	6121                	addi	sp,sp,64
 5b6:	8082                	ret

00000000000005b8 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 5b8:	7179                	addi	sp,sp,-48
 5ba:	f406                	sd	ra,40(sp)
 5bc:	f022                	sd	s0,32(sp)
 5be:	1800                	addi	s0,sp,48
 5c0:	fea43423          	sd	a0,-24(s0)
 5c4:	feb43023          	sd	a1,-32(s0)
 5c8:	87b2                	mv	a5,a2
 5ca:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
 5ce:	fdc42783          	lw	a5,-36(s0)
 5d2:	863e                	mv	a2,a5
 5d4:	fe043583          	ld	a1,-32(s0)
 5d8:	fe843503          	ld	a0,-24(s0)
 5dc:	00000097          	auipc	ra,0x0
 5e0:	e96080e7          	jalr	-362(ra) # 472 <memmove>
 5e4:	87aa                	mv	a5,a0
}
 5e6:	853e                	mv	a0,a5
 5e8:	70a2                	ld	ra,40(sp)
 5ea:	7402                	ld	s0,32(sp)
 5ec:	6145                	addi	sp,sp,48
 5ee:	8082                	ret

00000000000005f0 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 5f0:	4885                	li	a7,1
 ecall
 5f2:	00000073          	ecall
 ret
 5f6:	8082                	ret

00000000000005f8 <exit>:
.global exit
exit:
 li a7, SYS_exit
 5f8:	4889                	li	a7,2
 ecall
 5fa:	00000073          	ecall
 ret
 5fe:	8082                	ret

0000000000000600 <wait>:
.global wait
wait:
 li a7, SYS_wait
 600:	488d                	li	a7,3
 ecall
 602:	00000073          	ecall
 ret
 606:	8082                	ret

0000000000000608 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 608:	4891                	li	a7,4
 ecall
 60a:	00000073          	ecall
 ret
 60e:	8082                	ret

0000000000000610 <read>:
.global read
read:
 li a7, SYS_read
 610:	4895                	li	a7,5
 ecall
 612:	00000073          	ecall
 ret
 616:	8082                	ret

0000000000000618 <write>:
.global write
write:
 li a7, SYS_write
 618:	48c1                	li	a7,16
 ecall
 61a:	00000073          	ecall
 ret
 61e:	8082                	ret

0000000000000620 <close>:
.global close
close:
 li a7, SYS_close
 620:	48d5                	li	a7,21
 ecall
 622:	00000073          	ecall
 ret
 626:	8082                	ret

0000000000000628 <kill>:
.global kill
kill:
 li a7, SYS_kill
 628:	4899                	li	a7,6
 ecall
 62a:	00000073          	ecall
 ret
 62e:	8082                	ret

0000000000000630 <exec>:
.global exec
exec:
 li a7, SYS_exec
 630:	489d                	li	a7,7
 ecall
 632:	00000073          	ecall
 ret
 636:	8082                	ret

0000000000000638 <open>:
.global open
open:
 li a7, SYS_open
 638:	48bd                	li	a7,15
 ecall
 63a:	00000073          	ecall
 ret
 63e:	8082                	ret

0000000000000640 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 640:	48c5                	li	a7,17
 ecall
 642:	00000073          	ecall
 ret
 646:	8082                	ret

0000000000000648 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 648:	48c9                	li	a7,18
 ecall
 64a:	00000073          	ecall
 ret
 64e:	8082                	ret

0000000000000650 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 650:	48a1                	li	a7,8
 ecall
 652:	00000073          	ecall
 ret
 656:	8082                	ret

0000000000000658 <link>:
.global link
link:
 li a7, SYS_link
 658:	48cd                	li	a7,19
 ecall
 65a:	00000073          	ecall
 ret
 65e:	8082                	ret

0000000000000660 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 660:	48d1                	li	a7,20
 ecall
 662:	00000073          	ecall
 ret
 666:	8082                	ret

0000000000000668 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 668:	48a5                	li	a7,9
 ecall
 66a:	00000073          	ecall
 ret
 66e:	8082                	ret

0000000000000670 <dup>:
.global dup
dup:
 li a7, SYS_dup
 670:	48a9                	li	a7,10
 ecall
 672:	00000073          	ecall
 ret
 676:	8082                	ret

0000000000000678 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 678:	48ad                	li	a7,11
 ecall
 67a:	00000073          	ecall
 ret
 67e:	8082                	ret

0000000000000680 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 680:	48b1                	li	a7,12
 ecall
 682:	00000073          	ecall
 ret
 686:	8082                	ret

0000000000000688 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 688:	48b5                	li	a7,13
 ecall
 68a:	00000073          	ecall
 ret
 68e:	8082                	ret

0000000000000690 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 690:	48b9                	li	a7,14
 ecall
 692:	00000073          	ecall
 ret
 696:	8082                	ret

0000000000000698 <thrdstop>:
.global thrdstop
thrdstop:
 li a7, SYS_thrdstop
 698:	48d9                	li	a7,22
 ecall
 69a:	00000073          	ecall
 ret
 69e:	8082                	ret

00000000000006a0 <thrdresume>:
.global thrdresume
thrdresume:
 li a7, SYS_thrdresume
 6a0:	48dd                	li	a7,23
 ecall
 6a2:	00000073          	ecall
 ret
 6a6:	8082                	ret

00000000000006a8 <cancelthrdstop>:
.global cancelthrdstop
cancelthrdstop:
 li a7, SYS_cancelthrdstop
 6a8:	48e1                	li	a7,24
 ecall
 6aa:	00000073          	ecall
 ret
 6ae:	8082                	ret
