
user/_echo:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
       0:	7139                	addi	sp,sp,-64
       2:	fc06                	sd	ra,56(sp)
       4:	f822                	sd	s0,48(sp)
       6:	f426                	sd	s1,40(sp)
       8:	0080                	addi	s0,sp,64
       a:	87aa                	mv	a5,a0
       c:	fcb43023          	sd	a1,-64(s0)
      10:	fcf42623          	sw	a5,-52(s0)
  int i;

  for(i = 1; i < argc; i++){
      14:	4785                	li	a5,1
      16:	fcf42e23          	sw	a5,-36(s0)
      1a:	a051                	j	9e <main+0x9e>
    write(1, argv[i], strlen(argv[i]));
      1c:	fdc42783          	lw	a5,-36(s0)
      20:	078e                	slli	a5,a5,0x3
      22:	fc043703          	ld	a4,-64(s0)
      26:	97ba                	add	a5,a5,a4
      28:	6384                	ld	s1,0(a5)
      2a:	fdc42783          	lw	a5,-36(s0)
      2e:	078e                	slli	a5,a5,0x3
      30:	fc043703          	ld	a4,-64(s0)
      34:	97ba                	add	a5,a5,a4
      36:	639c                	ld	a5,0(a5)
      38:	853e                	mv	a0,a5
      3a:	00000097          	auipc	ra,0x0
      3e:	12e080e7          	jalr	302(ra) # 168 <strlen>
      42:	87aa                	mv	a5,a0
      44:	2781                	sext.w	a5,a5
      46:	2781                	sext.w	a5,a5
      48:	863e                	mv	a2,a5
      4a:	85a6                	mv	a1,s1
      4c:	4505                	li	a0,1
      4e:	00000097          	auipc	ra,0x0
      52:	51a080e7          	jalr	1306(ra) # 568 <write>
    if(i + 1 < argc){
      56:	fdc42783          	lw	a5,-36(s0)
      5a:	2785                	addiw	a5,a5,1
      5c:	0007871b          	sext.w	a4,a5
      60:	fcc42783          	lw	a5,-52(s0)
      64:	2781                	sext.w	a5,a5
      66:	00f75d63          	bge	a4,a5,80 <main+0x80>
      write(1, " ", 1);
      6a:	4605                	li	a2,1
      6c:	00001597          	auipc	a1,0x1
      70:	5bc58593          	addi	a1,a1,1468 # 1628 <schedule_rm+0x360>
      74:	4505                	li	a0,1
      76:	00000097          	auipc	ra,0x0
      7a:	4f2080e7          	jalr	1266(ra) # 568 <write>
      7e:	a819                	j	94 <main+0x94>
    } else {
      write(1, "\n", 1);
      80:	4605                	li	a2,1
      82:	00001597          	auipc	a1,0x1
      86:	5ae58593          	addi	a1,a1,1454 # 1630 <schedule_rm+0x368>
      8a:	4505                	li	a0,1
      8c:	00000097          	auipc	ra,0x0
      90:	4dc080e7          	jalr	1244(ra) # 568 <write>
  for(i = 1; i < argc; i++){
      94:	fdc42783          	lw	a5,-36(s0)
      98:	2785                	addiw	a5,a5,1
      9a:	fcf42e23          	sw	a5,-36(s0)
      9e:	fdc42703          	lw	a4,-36(s0)
      a2:	fcc42783          	lw	a5,-52(s0)
      a6:	2701                	sext.w	a4,a4
      a8:	2781                	sext.w	a5,a5
      aa:	f6f749e3          	blt	a4,a5,1c <main+0x1c>
    }
  }
  exit(0);
      ae:	4501                	li	a0,0
      b0:	00000097          	auipc	ra,0x0
      b4:	498080e7          	jalr	1176(ra) # 548 <exit>

00000000000000b8 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
      b8:	7179                	addi	sp,sp,-48
      ba:	f422                	sd	s0,40(sp)
      bc:	1800                	addi	s0,sp,48
      be:	fca43c23          	sd	a0,-40(s0)
      c2:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
      c6:	fd843783          	ld	a5,-40(s0)
      ca:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
      ce:	0001                	nop
      d0:	fd043703          	ld	a4,-48(s0)
      d4:	00170793          	addi	a5,a4,1
      d8:	fcf43823          	sd	a5,-48(s0)
      dc:	fd843783          	ld	a5,-40(s0)
      e0:	00178693          	addi	a3,a5,1
      e4:	fcd43c23          	sd	a3,-40(s0)
      e8:	00074703          	lbu	a4,0(a4)
      ec:	00e78023          	sb	a4,0(a5)
      f0:	0007c783          	lbu	a5,0(a5)
      f4:	fff1                	bnez	a5,d0 <strcpy+0x18>
    ;
  return os;
      f6:	fe843783          	ld	a5,-24(s0)
}
      fa:	853e                	mv	a0,a5
      fc:	7422                	ld	s0,40(sp)
      fe:	6145                	addi	sp,sp,48
     100:	8082                	ret

0000000000000102 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     102:	1101                	addi	sp,sp,-32
     104:	ec22                	sd	s0,24(sp)
     106:	1000                	addi	s0,sp,32
     108:	fea43423          	sd	a0,-24(s0)
     10c:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
     110:	a819                	j	126 <strcmp+0x24>
    p++, q++;
     112:	fe843783          	ld	a5,-24(s0)
     116:	0785                	addi	a5,a5,1
     118:	fef43423          	sd	a5,-24(s0)
     11c:	fe043783          	ld	a5,-32(s0)
     120:	0785                	addi	a5,a5,1
     122:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
     126:	fe843783          	ld	a5,-24(s0)
     12a:	0007c783          	lbu	a5,0(a5)
     12e:	cb99                	beqz	a5,144 <strcmp+0x42>
     130:	fe843783          	ld	a5,-24(s0)
     134:	0007c703          	lbu	a4,0(a5)
     138:	fe043783          	ld	a5,-32(s0)
     13c:	0007c783          	lbu	a5,0(a5)
     140:	fcf709e3          	beq	a4,a5,112 <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
     144:	fe843783          	ld	a5,-24(s0)
     148:	0007c783          	lbu	a5,0(a5)
     14c:	0007871b          	sext.w	a4,a5
     150:	fe043783          	ld	a5,-32(s0)
     154:	0007c783          	lbu	a5,0(a5)
     158:	2781                	sext.w	a5,a5
     15a:	40f707bb          	subw	a5,a4,a5
     15e:	2781                	sext.w	a5,a5
}
     160:	853e                	mv	a0,a5
     162:	6462                	ld	s0,24(sp)
     164:	6105                	addi	sp,sp,32
     166:	8082                	ret

0000000000000168 <strlen>:

uint
strlen(const char *s)
{
     168:	7179                	addi	sp,sp,-48
     16a:	f422                	sd	s0,40(sp)
     16c:	1800                	addi	s0,sp,48
     16e:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
     172:	fe042623          	sw	zero,-20(s0)
     176:	a031                	j	182 <strlen+0x1a>
     178:	fec42783          	lw	a5,-20(s0)
     17c:	2785                	addiw	a5,a5,1
     17e:	fef42623          	sw	a5,-20(s0)
     182:	fec42783          	lw	a5,-20(s0)
     186:	fd843703          	ld	a4,-40(s0)
     18a:	97ba                	add	a5,a5,a4
     18c:	0007c783          	lbu	a5,0(a5)
     190:	f7e5                	bnez	a5,178 <strlen+0x10>
    ;
  return n;
     192:	fec42783          	lw	a5,-20(s0)
}
     196:	853e                	mv	a0,a5
     198:	7422                	ld	s0,40(sp)
     19a:	6145                	addi	sp,sp,48
     19c:	8082                	ret

000000000000019e <memset>:

void*
memset(void *dst, int c, uint n)
{
     19e:	7179                	addi	sp,sp,-48
     1a0:	f422                	sd	s0,40(sp)
     1a2:	1800                	addi	s0,sp,48
     1a4:	fca43c23          	sd	a0,-40(s0)
     1a8:	87ae                	mv	a5,a1
     1aa:	8732                	mv	a4,a2
     1ac:	fcf42a23          	sw	a5,-44(s0)
     1b0:	87ba                	mv	a5,a4
     1b2:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
     1b6:	fd843783          	ld	a5,-40(s0)
     1ba:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
     1be:	fe042623          	sw	zero,-20(s0)
     1c2:	a00d                	j	1e4 <memset+0x46>
    cdst[i] = c;
     1c4:	fec42783          	lw	a5,-20(s0)
     1c8:	fe043703          	ld	a4,-32(s0)
     1cc:	97ba                	add	a5,a5,a4
     1ce:	fd442703          	lw	a4,-44(s0)
     1d2:	0ff77713          	andi	a4,a4,255
     1d6:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
     1da:	fec42783          	lw	a5,-20(s0)
     1de:	2785                	addiw	a5,a5,1
     1e0:	fef42623          	sw	a5,-20(s0)
     1e4:	fec42703          	lw	a4,-20(s0)
     1e8:	fd042783          	lw	a5,-48(s0)
     1ec:	2781                	sext.w	a5,a5
     1ee:	fcf76be3          	bltu	a4,a5,1c4 <memset+0x26>
  }
  return dst;
     1f2:	fd843783          	ld	a5,-40(s0)
}
     1f6:	853e                	mv	a0,a5
     1f8:	7422                	ld	s0,40(sp)
     1fa:	6145                	addi	sp,sp,48
     1fc:	8082                	ret

00000000000001fe <strchr>:

char*
strchr(const char *s, char c)
{
     1fe:	1101                	addi	sp,sp,-32
     200:	ec22                	sd	s0,24(sp)
     202:	1000                	addi	s0,sp,32
     204:	fea43423          	sd	a0,-24(s0)
     208:	87ae                	mv	a5,a1
     20a:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
     20e:	a01d                	j	234 <strchr+0x36>
    if(*s == c)
     210:	fe843783          	ld	a5,-24(s0)
     214:	0007c703          	lbu	a4,0(a5)
     218:	fe744783          	lbu	a5,-25(s0)
     21c:	0ff7f793          	andi	a5,a5,255
     220:	00e79563          	bne	a5,a4,22a <strchr+0x2c>
      return (char*)s;
     224:	fe843783          	ld	a5,-24(s0)
     228:	a821                	j	240 <strchr+0x42>
  for(; *s; s++)
     22a:	fe843783          	ld	a5,-24(s0)
     22e:	0785                	addi	a5,a5,1
     230:	fef43423          	sd	a5,-24(s0)
     234:	fe843783          	ld	a5,-24(s0)
     238:	0007c783          	lbu	a5,0(a5)
     23c:	fbf1                	bnez	a5,210 <strchr+0x12>
  return 0;
     23e:	4781                	li	a5,0
}
     240:	853e                	mv	a0,a5
     242:	6462                	ld	s0,24(sp)
     244:	6105                	addi	sp,sp,32
     246:	8082                	ret

0000000000000248 <gets>:

char*
gets(char *buf, int max)
{
     248:	7179                	addi	sp,sp,-48
     24a:	f406                	sd	ra,40(sp)
     24c:	f022                	sd	s0,32(sp)
     24e:	1800                	addi	s0,sp,48
     250:	fca43c23          	sd	a0,-40(s0)
     254:	87ae                	mv	a5,a1
     256:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     25a:	fe042623          	sw	zero,-20(s0)
     25e:	a8a1                	j	2b6 <gets+0x6e>
    cc = read(0, &c, 1);
     260:	fe740793          	addi	a5,s0,-25
     264:	4605                	li	a2,1
     266:	85be                	mv	a1,a5
     268:	4501                	li	a0,0
     26a:	00000097          	auipc	ra,0x0
     26e:	2f6080e7          	jalr	758(ra) # 560 <read>
     272:	87aa                	mv	a5,a0
     274:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
     278:	fe842783          	lw	a5,-24(s0)
     27c:	2781                	sext.w	a5,a5
     27e:	04f05763          	blez	a5,2cc <gets+0x84>
      break;
    buf[i++] = c;
     282:	fec42783          	lw	a5,-20(s0)
     286:	0017871b          	addiw	a4,a5,1
     28a:	fee42623          	sw	a4,-20(s0)
     28e:	873e                	mv	a4,a5
     290:	fd843783          	ld	a5,-40(s0)
     294:	97ba                	add	a5,a5,a4
     296:	fe744703          	lbu	a4,-25(s0)
     29a:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
     29e:	fe744783          	lbu	a5,-25(s0)
     2a2:	873e                	mv	a4,a5
     2a4:	47a9                	li	a5,10
     2a6:	02f70463          	beq	a4,a5,2ce <gets+0x86>
     2aa:	fe744783          	lbu	a5,-25(s0)
     2ae:	873e                	mv	a4,a5
     2b0:	47b5                	li	a5,13
     2b2:	00f70e63          	beq	a4,a5,2ce <gets+0x86>
  for(i=0; i+1 < max; ){
     2b6:	fec42783          	lw	a5,-20(s0)
     2ba:	2785                	addiw	a5,a5,1
     2bc:	0007871b          	sext.w	a4,a5
     2c0:	fd442783          	lw	a5,-44(s0)
     2c4:	2781                	sext.w	a5,a5
     2c6:	f8f74de3          	blt	a4,a5,260 <gets+0x18>
     2ca:	a011                	j	2ce <gets+0x86>
      break;
     2cc:	0001                	nop
      break;
  }
  buf[i] = '\0';
     2ce:	fec42783          	lw	a5,-20(s0)
     2d2:	fd843703          	ld	a4,-40(s0)
     2d6:	97ba                	add	a5,a5,a4
     2d8:	00078023          	sb	zero,0(a5)
  return buf;
     2dc:	fd843783          	ld	a5,-40(s0)
}
     2e0:	853e                	mv	a0,a5
     2e2:	70a2                	ld	ra,40(sp)
     2e4:	7402                	ld	s0,32(sp)
     2e6:	6145                	addi	sp,sp,48
     2e8:	8082                	ret

00000000000002ea <stat>:

int
stat(const char *n, struct stat *st)
{
     2ea:	7179                	addi	sp,sp,-48
     2ec:	f406                	sd	ra,40(sp)
     2ee:	f022                	sd	s0,32(sp)
     2f0:	1800                	addi	s0,sp,48
     2f2:	fca43c23          	sd	a0,-40(s0)
     2f6:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     2fa:	4581                	li	a1,0
     2fc:	fd843503          	ld	a0,-40(s0)
     300:	00000097          	auipc	ra,0x0
     304:	288080e7          	jalr	648(ra) # 588 <open>
     308:	87aa                	mv	a5,a0
     30a:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
     30e:	fec42783          	lw	a5,-20(s0)
     312:	2781                	sext.w	a5,a5
     314:	0007d463          	bgez	a5,31c <stat+0x32>
    return -1;
     318:	57fd                	li	a5,-1
     31a:	a035                	j	346 <stat+0x5c>
  r = fstat(fd, st);
     31c:	fec42783          	lw	a5,-20(s0)
     320:	fd043583          	ld	a1,-48(s0)
     324:	853e                	mv	a0,a5
     326:	00000097          	auipc	ra,0x0
     32a:	27a080e7          	jalr	634(ra) # 5a0 <fstat>
     32e:	87aa                	mv	a5,a0
     330:	fef42423          	sw	a5,-24(s0)
  close(fd);
     334:	fec42783          	lw	a5,-20(s0)
     338:	853e                	mv	a0,a5
     33a:	00000097          	auipc	ra,0x0
     33e:	236080e7          	jalr	566(ra) # 570 <close>
  return r;
     342:	fe842783          	lw	a5,-24(s0)
}
     346:	853e                	mv	a0,a5
     348:	70a2                	ld	ra,40(sp)
     34a:	7402                	ld	s0,32(sp)
     34c:	6145                	addi	sp,sp,48
     34e:	8082                	ret

0000000000000350 <atoi>:

int
atoi(const char *s)
{
     350:	7179                	addi	sp,sp,-48
     352:	f422                	sd	s0,40(sp)
     354:	1800                	addi	s0,sp,48
     356:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
     35a:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
     35e:	a815                	j	392 <atoi+0x42>
    n = n*10 + *s++ - '0';
     360:	fec42703          	lw	a4,-20(s0)
     364:	87ba                	mv	a5,a4
     366:	0027979b          	slliw	a5,a5,0x2
     36a:	9fb9                	addw	a5,a5,a4
     36c:	0017979b          	slliw	a5,a5,0x1
     370:	0007871b          	sext.w	a4,a5
     374:	fd843783          	ld	a5,-40(s0)
     378:	00178693          	addi	a3,a5,1
     37c:	fcd43c23          	sd	a3,-40(s0)
     380:	0007c783          	lbu	a5,0(a5)
     384:	2781                	sext.w	a5,a5
     386:	9fb9                	addw	a5,a5,a4
     388:	2781                	sext.w	a5,a5
     38a:	fd07879b          	addiw	a5,a5,-48
     38e:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
     392:	fd843783          	ld	a5,-40(s0)
     396:	0007c783          	lbu	a5,0(a5)
     39a:	873e                	mv	a4,a5
     39c:	02f00793          	li	a5,47
     3a0:	00e7fb63          	bgeu	a5,a4,3b6 <atoi+0x66>
     3a4:	fd843783          	ld	a5,-40(s0)
     3a8:	0007c783          	lbu	a5,0(a5)
     3ac:	873e                	mv	a4,a5
     3ae:	03900793          	li	a5,57
     3b2:	fae7f7e3          	bgeu	a5,a4,360 <atoi+0x10>
  return n;
     3b6:	fec42783          	lw	a5,-20(s0)
}
     3ba:	853e                	mv	a0,a5
     3bc:	7422                	ld	s0,40(sp)
     3be:	6145                	addi	sp,sp,48
     3c0:	8082                	ret

00000000000003c2 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     3c2:	7139                	addi	sp,sp,-64
     3c4:	fc22                	sd	s0,56(sp)
     3c6:	0080                	addi	s0,sp,64
     3c8:	fca43c23          	sd	a0,-40(s0)
     3cc:	fcb43823          	sd	a1,-48(s0)
     3d0:	87b2                	mv	a5,a2
     3d2:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
     3d6:	fd843783          	ld	a5,-40(s0)
     3da:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
     3de:	fd043783          	ld	a5,-48(s0)
     3e2:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
     3e6:	fe043703          	ld	a4,-32(s0)
     3ea:	fe843783          	ld	a5,-24(s0)
     3ee:	02e7fc63          	bgeu	a5,a4,426 <memmove+0x64>
    while(n-- > 0)
     3f2:	a00d                	j	414 <memmove+0x52>
      *dst++ = *src++;
     3f4:	fe043703          	ld	a4,-32(s0)
     3f8:	00170793          	addi	a5,a4,1
     3fc:	fef43023          	sd	a5,-32(s0)
     400:	fe843783          	ld	a5,-24(s0)
     404:	00178693          	addi	a3,a5,1
     408:	fed43423          	sd	a3,-24(s0)
     40c:	00074703          	lbu	a4,0(a4)
     410:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     414:	fcc42783          	lw	a5,-52(s0)
     418:	fff7871b          	addiw	a4,a5,-1
     41c:	fce42623          	sw	a4,-52(s0)
     420:	fcf04ae3          	bgtz	a5,3f4 <memmove+0x32>
     424:	a891                	j	478 <memmove+0xb6>
  } else {
    dst += n;
     426:	fcc42783          	lw	a5,-52(s0)
     42a:	fe843703          	ld	a4,-24(s0)
     42e:	97ba                	add	a5,a5,a4
     430:	fef43423          	sd	a5,-24(s0)
    src += n;
     434:	fcc42783          	lw	a5,-52(s0)
     438:	fe043703          	ld	a4,-32(s0)
     43c:	97ba                	add	a5,a5,a4
     43e:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
     442:	a01d                	j	468 <memmove+0xa6>
      *--dst = *--src;
     444:	fe043783          	ld	a5,-32(s0)
     448:	17fd                	addi	a5,a5,-1
     44a:	fef43023          	sd	a5,-32(s0)
     44e:	fe843783          	ld	a5,-24(s0)
     452:	17fd                	addi	a5,a5,-1
     454:	fef43423          	sd	a5,-24(s0)
     458:	fe043783          	ld	a5,-32(s0)
     45c:	0007c703          	lbu	a4,0(a5)
     460:	fe843783          	ld	a5,-24(s0)
     464:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     468:	fcc42783          	lw	a5,-52(s0)
     46c:	fff7871b          	addiw	a4,a5,-1
     470:	fce42623          	sw	a4,-52(s0)
     474:	fcf048e3          	bgtz	a5,444 <memmove+0x82>
  }
  return vdst;
     478:	fd843783          	ld	a5,-40(s0)
}
     47c:	853e                	mv	a0,a5
     47e:	7462                	ld	s0,56(sp)
     480:	6121                	addi	sp,sp,64
     482:	8082                	ret

0000000000000484 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     484:	7139                	addi	sp,sp,-64
     486:	fc22                	sd	s0,56(sp)
     488:	0080                	addi	s0,sp,64
     48a:	fca43c23          	sd	a0,-40(s0)
     48e:	fcb43823          	sd	a1,-48(s0)
     492:	87b2                	mv	a5,a2
     494:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
     498:	fd843783          	ld	a5,-40(s0)
     49c:	fef43423          	sd	a5,-24(s0)
     4a0:	fd043783          	ld	a5,-48(s0)
     4a4:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     4a8:	a0a1                	j	4f0 <memcmp+0x6c>
    if (*p1 != *p2) {
     4aa:	fe843783          	ld	a5,-24(s0)
     4ae:	0007c703          	lbu	a4,0(a5)
     4b2:	fe043783          	ld	a5,-32(s0)
     4b6:	0007c783          	lbu	a5,0(a5)
     4ba:	02f70163          	beq	a4,a5,4dc <memcmp+0x58>
      return *p1 - *p2;
     4be:	fe843783          	ld	a5,-24(s0)
     4c2:	0007c783          	lbu	a5,0(a5)
     4c6:	0007871b          	sext.w	a4,a5
     4ca:	fe043783          	ld	a5,-32(s0)
     4ce:	0007c783          	lbu	a5,0(a5)
     4d2:	2781                	sext.w	a5,a5
     4d4:	40f707bb          	subw	a5,a4,a5
     4d8:	2781                	sext.w	a5,a5
     4da:	a01d                	j	500 <memcmp+0x7c>
    }
    p1++;
     4dc:	fe843783          	ld	a5,-24(s0)
     4e0:	0785                	addi	a5,a5,1
     4e2:	fef43423          	sd	a5,-24(s0)
    p2++;
     4e6:	fe043783          	ld	a5,-32(s0)
     4ea:	0785                	addi	a5,a5,1
     4ec:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     4f0:	fcc42783          	lw	a5,-52(s0)
     4f4:	fff7871b          	addiw	a4,a5,-1
     4f8:	fce42623          	sw	a4,-52(s0)
     4fc:	f7dd                	bnez	a5,4aa <memcmp+0x26>
  }
  return 0;
     4fe:	4781                	li	a5,0
}
     500:	853e                	mv	a0,a5
     502:	7462                	ld	s0,56(sp)
     504:	6121                	addi	sp,sp,64
     506:	8082                	ret

0000000000000508 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     508:	7179                	addi	sp,sp,-48
     50a:	f406                	sd	ra,40(sp)
     50c:	f022                	sd	s0,32(sp)
     50e:	1800                	addi	s0,sp,48
     510:	fea43423          	sd	a0,-24(s0)
     514:	feb43023          	sd	a1,-32(s0)
     518:	87b2                	mv	a5,a2
     51a:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
     51e:	fdc42783          	lw	a5,-36(s0)
     522:	863e                	mv	a2,a5
     524:	fe043583          	ld	a1,-32(s0)
     528:	fe843503          	ld	a0,-24(s0)
     52c:	00000097          	auipc	ra,0x0
     530:	e96080e7          	jalr	-362(ra) # 3c2 <memmove>
     534:	87aa                	mv	a5,a0
}
     536:	853e                	mv	a0,a5
     538:	70a2                	ld	ra,40(sp)
     53a:	7402                	ld	s0,32(sp)
     53c:	6145                	addi	sp,sp,48
     53e:	8082                	ret

0000000000000540 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     540:	4885                	li	a7,1
 ecall
     542:	00000073          	ecall
 ret
     546:	8082                	ret

0000000000000548 <exit>:
.global exit
exit:
 li a7, SYS_exit
     548:	4889                	li	a7,2
 ecall
     54a:	00000073          	ecall
 ret
     54e:	8082                	ret

0000000000000550 <wait>:
.global wait
wait:
 li a7, SYS_wait
     550:	488d                	li	a7,3
 ecall
     552:	00000073          	ecall
 ret
     556:	8082                	ret

0000000000000558 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     558:	4891                	li	a7,4
 ecall
     55a:	00000073          	ecall
 ret
     55e:	8082                	ret

0000000000000560 <read>:
.global read
read:
 li a7, SYS_read
     560:	4895                	li	a7,5
 ecall
     562:	00000073          	ecall
 ret
     566:	8082                	ret

0000000000000568 <write>:
.global write
write:
 li a7, SYS_write
     568:	48c1                	li	a7,16
 ecall
     56a:	00000073          	ecall
 ret
     56e:	8082                	ret

0000000000000570 <close>:
.global close
close:
 li a7, SYS_close
     570:	48d5                	li	a7,21
 ecall
     572:	00000073          	ecall
 ret
     576:	8082                	ret

0000000000000578 <kill>:
.global kill
kill:
 li a7, SYS_kill
     578:	4899                	li	a7,6
 ecall
     57a:	00000073          	ecall
 ret
     57e:	8082                	ret

0000000000000580 <exec>:
.global exec
exec:
 li a7, SYS_exec
     580:	489d                	li	a7,7
 ecall
     582:	00000073          	ecall
 ret
     586:	8082                	ret

0000000000000588 <open>:
.global open
open:
 li a7, SYS_open
     588:	48bd                	li	a7,15
 ecall
     58a:	00000073          	ecall
 ret
     58e:	8082                	ret

0000000000000590 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     590:	48c5                	li	a7,17
 ecall
     592:	00000073          	ecall
 ret
     596:	8082                	ret

0000000000000598 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     598:	48c9                	li	a7,18
 ecall
     59a:	00000073          	ecall
 ret
     59e:	8082                	ret

00000000000005a0 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     5a0:	48a1                	li	a7,8
 ecall
     5a2:	00000073          	ecall
 ret
     5a6:	8082                	ret

00000000000005a8 <link>:
.global link
link:
 li a7, SYS_link
     5a8:	48cd                	li	a7,19
 ecall
     5aa:	00000073          	ecall
 ret
     5ae:	8082                	ret

00000000000005b0 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     5b0:	48d1                	li	a7,20
 ecall
     5b2:	00000073          	ecall
 ret
     5b6:	8082                	ret

00000000000005b8 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     5b8:	48a5                	li	a7,9
 ecall
     5ba:	00000073          	ecall
 ret
     5be:	8082                	ret

00000000000005c0 <dup>:
.global dup
dup:
 li a7, SYS_dup
     5c0:	48a9                	li	a7,10
 ecall
     5c2:	00000073          	ecall
 ret
     5c6:	8082                	ret

00000000000005c8 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     5c8:	48ad                	li	a7,11
 ecall
     5ca:	00000073          	ecall
 ret
     5ce:	8082                	ret

00000000000005d0 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     5d0:	48b1                	li	a7,12
 ecall
     5d2:	00000073          	ecall
 ret
     5d6:	8082                	ret

00000000000005d8 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     5d8:	48b5                	li	a7,13
 ecall
     5da:	00000073          	ecall
 ret
     5de:	8082                	ret

00000000000005e0 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     5e0:	48b9                	li	a7,14
 ecall
     5e2:	00000073          	ecall
 ret
     5e6:	8082                	ret

00000000000005e8 <thrdstop>:
.global thrdstop
thrdstop:
 li a7, SYS_thrdstop
     5e8:	48d9                	li	a7,22
 ecall
     5ea:	00000073          	ecall
 ret
     5ee:	8082                	ret

00000000000005f0 <thrdresume>:
.global thrdresume
thrdresume:
 li a7, SYS_thrdresume
     5f0:	48dd                	li	a7,23
 ecall
     5f2:	00000073          	ecall
 ret
     5f6:	8082                	ret

00000000000005f8 <cancelthrdstop>:
.global cancelthrdstop
cancelthrdstop:
 li a7, SYS_cancelthrdstop
     5f8:	48e1                	li	a7,24
 ecall
     5fa:	00000073          	ecall
 ret
     5fe:	8082                	ret

0000000000000600 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     600:	1101                	addi	sp,sp,-32
     602:	ec06                	sd	ra,24(sp)
     604:	e822                	sd	s0,16(sp)
     606:	1000                	addi	s0,sp,32
     608:	87aa                	mv	a5,a0
     60a:	872e                	mv	a4,a1
     60c:	fef42623          	sw	a5,-20(s0)
     610:	87ba                	mv	a5,a4
     612:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
     616:	feb40713          	addi	a4,s0,-21
     61a:	fec42783          	lw	a5,-20(s0)
     61e:	4605                	li	a2,1
     620:	85ba                	mv	a1,a4
     622:	853e                	mv	a0,a5
     624:	00000097          	auipc	ra,0x0
     628:	f44080e7          	jalr	-188(ra) # 568 <write>
}
     62c:	0001                	nop
     62e:	60e2                	ld	ra,24(sp)
     630:	6442                	ld	s0,16(sp)
     632:	6105                	addi	sp,sp,32
     634:	8082                	ret

0000000000000636 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     636:	7139                	addi	sp,sp,-64
     638:	fc06                	sd	ra,56(sp)
     63a:	f822                	sd	s0,48(sp)
     63c:	0080                	addi	s0,sp,64
     63e:	87aa                	mv	a5,a0
     640:	8736                	mv	a4,a3
     642:	fcf42623          	sw	a5,-52(s0)
     646:	87ae                	mv	a5,a1
     648:	fcf42423          	sw	a5,-56(s0)
     64c:	87b2                	mv	a5,a2
     64e:	fcf42223          	sw	a5,-60(s0)
     652:	87ba                	mv	a5,a4
     654:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     658:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
     65c:	fc042783          	lw	a5,-64(s0)
     660:	2781                	sext.w	a5,a5
     662:	c38d                	beqz	a5,684 <printint+0x4e>
     664:	fc842783          	lw	a5,-56(s0)
     668:	2781                	sext.w	a5,a5
     66a:	0007dd63          	bgez	a5,684 <printint+0x4e>
    neg = 1;
     66e:	4785                	li	a5,1
     670:	fef42423          	sw	a5,-24(s0)
    x = -xx;
     674:	fc842783          	lw	a5,-56(s0)
     678:	40f007bb          	negw	a5,a5
     67c:	2781                	sext.w	a5,a5
     67e:	fef42223          	sw	a5,-28(s0)
     682:	a029                	j	68c <printint+0x56>
  } else {
    x = xx;
     684:	fc842783          	lw	a5,-56(s0)
     688:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
     68c:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
     690:	fc442783          	lw	a5,-60(s0)
     694:	fe442703          	lw	a4,-28(s0)
     698:	02f777bb          	remuw	a5,a4,a5
     69c:	0007861b          	sext.w	a2,a5
     6a0:	fec42783          	lw	a5,-20(s0)
     6a4:	0017871b          	addiw	a4,a5,1
     6a8:	fee42623          	sw	a4,-20(s0)
     6ac:	00001697          	auipc	a3,0x1
     6b0:	f9468693          	addi	a3,a3,-108 # 1640 <digits>
     6b4:	02061713          	slli	a4,a2,0x20
     6b8:	9301                	srli	a4,a4,0x20
     6ba:	9736                	add	a4,a4,a3
     6bc:	00074703          	lbu	a4,0(a4)
     6c0:	ff040693          	addi	a3,s0,-16
     6c4:	97b6                	add	a5,a5,a3
     6c6:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
     6ca:	fc442783          	lw	a5,-60(s0)
     6ce:	fe442703          	lw	a4,-28(s0)
     6d2:	02f757bb          	divuw	a5,a4,a5
     6d6:	fef42223          	sw	a5,-28(s0)
     6da:	fe442783          	lw	a5,-28(s0)
     6de:	2781                	sext.w	a5,a5
     6e0:	fbc5                	bnez	a5,690 <printint+0x5a>
  if(neg)
     6e2:	fe842783          	lw	a5,-24(s0)
     6e6:	2781                	sext.w	a5,a5
     6e8:	cf95                	beqz	a5,724 <printint+0xee>
    buf[i++] = '-';
     6ea:	fec42783          	lw	a5,-20(s0)
     6ee:	0017871b          	addiw	a4,a5,1
     6f2:	fee42623          	sw	a4,-20(s0)
     6f6:	ff040713          	addi	a4,s0,-16
     6fa:	97ba                	add	a5,a5,a4
     6fc:	02d00713          	li	a4,45
     700:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
     704:	a005                	j	724 <printint+0xee>
    putc(fd, buf[i]);
     706:	fec42783          	lw	a5,-20(s0)
     70a:	ff040713          	addi	a4,s0,-16
     70e:	97ba                	add	a5,a5,a4
     710:	fe07c703          	lbu	a4,-32(a5)
     714:	fcc42783          	lw	a5,-52(s0)
     718:	85ba                	mv	a1,a4
     71a:	853e                	mv	a0,a5
     71c:	00000097          	auipc	ra,0x0
     720:	ee4080e7          	jalr	-284(ra) # 600 <putc>
  while(--i >= 0)
     724:	fec42783          	lw	a5,-20(s0)
     728:	37fd                	addiw	a5,a5,-1
     72a:	fef42623          	sw	a5,-20(s0)
     72e:	fec42783          	lw	a5,-20(s0)
     732:	2781                	sext.w	a5,a5
     734:	fc07d9e3          	bgez	a5,706 <printint+0xd0>
}
     738:	0001                	nop
     73a:	0001                	nop
     73c:	70e2                	ld	ra,56(sp)
     73e:	7442                	ld	s0,48(sp)
     740:	6121                	addi	sp,sp,64
     742:	8082                	ret

0000000000000744 <printptr>:

static void
printptr(int fd, uint64 x) {
     744:	7179                	addi	sp,sp,-48
     746:	f406                	sd	ra,40(sp)
     748:	f022                	sd	s0,32(sp)
     74a:	1800                	addi	s0,sp,48
     74c:	87aa                	mv	a5,a0
     74e:	fcb43823          	sd	a1,-48(s0)
     752:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
     756:	fdc42783          	lw	a5,-36(s0)
     75a:	03000593          	li	a1,48
     75e:	853e                	mv	a0,a5
     760:	00000097          	auipc	ra,0x0
     764:	ea0080e7          	jalr	-352(ra) # 600 <putc>
  putc(fd, 'x');
     768:	fdc42783          	lw	a5,-36(s0)
     76c:	07800593          	li	a1,120
     770:	853e                	mv	a0,a5
     772:	00000097          	auipc	ra,0x0
     776:	e8e080e7          	jalr	-370(ra) # 600 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     77a:	fe042623          	sw	zero,-20(s0)
     77e:	a82d                	j	7b8 <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     780:	fd043783          	ld	a5,-48(s0)
     784:	93f1                	srli	a5,a5,0x3c
     786:	00001717          	auipc	a4,0x1
     78a:	eba70713          	addi	a4,a4,-326 # 1640 <digits>
     78e:	97ba                	add	a5,a5,a4
     790:	0007c703          	lbu	a4,0(a5)
     794:	fdc42783          	lw	a5,-36(s0)
     798:	85ba                	mv	a1,a4
     79a:	853e                	mv	a0,a5
     79c:	00000097          	auipc	ra,0x0
     7a0:	e64080e7          	jalr	-412(ra) # 600 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     7a4:	fec42783          	lw	a5,-20(s0)
     7a8:	2785                	addiw	a5,a5,1
     7aa:	fef42623          	sw	a5,-20(s0)
     7ae:	fd043783          	ld	a5,-48(s0)
     7b2:	0792                	slli	a5,a5,0x4
     7b4:	fcf43823          	sd	a5,-48(s0)
     7b8:	fec42783          	lw	a5,-20(s0)
     7bc:	873e                	mv	a4,a5
     7be:	47bd                	li	a5,15
     7c0:	fce7f0e3          	bgeu	a5,a4,780 <printptr+0x3c>
}
     7c4:	0001                	nop
     7c6:	0001                	nop
     7c8:	70a2                	ld	ra,40(sp)
     7ca:	7402                	ld	s0,32(sp)
     7cc:	6145                	addi	sp,sp,48
     7ce:	8082                	ret

00000000000007d0 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     7d0:	715d                	addi	sp,sp,-80
     7d2:	e486                	sd	ra,72(sp)
     7d4:	e0a2                	sd	s0,64(sp)
     7d6:	0880                	addi	s0,sp,80
     7d8:	87aa                	mv	a5,a0
     7da:	fcb43023          	sd	a1,-64(s0)
     7de:	fac43c23          	sd	a2,-72(s0)
     7e2:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
     7e6:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     7ea:	fe042223          	sw	zero,-28(s0)
     7ee:	a42d                	j	a18 <vprintf+0x248>
    c = fmt[i] & 0xff;
     7f0:	fe442783          	lw	a5,-28(s0)
     7f4:	fc043703          	ld	a4,-64(s0)
     7f8:	97ba                	add	a5,a5,a4
     7fa:	0007c783          	lbu	a5,0(a5)
     7fe:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
     802:	fe042783          	lw	a5,-32(s0)
     806:	2781                	sext.w	a5,a5
     808:	eb9d                	bnez	a5,83e <vprintf+0x6e>
      if(c == '%'){
     80a:	fdc42783          	lw	a5,-36(s0)
     80e:	0007871b          	sext.w	a4,a5
     812:	02500793          	li	a5,37
     816:	00f71763          	bne	a4,a5,824 <vprintf+0x54>
        state = '%';
     81a:	02500793          	li	a5,37
     81e:	fef42023          	sw	a5,-32(s0)
     822:	a2f5                	j	a0e <vprintf+0x23e>
      } else {
        putc(fd, c);
     824:	fdc42783          	lw	a5,-36(s0)
     828:	0ff7f713          	andi	a4,a5,255
     82c:	fcc42783          	lw	a5,-52(s0)
     830:	85ba                	mv	a1,a4
     832:	853e                	mv	a0,a5
     834:	00000097          	auipc	ra,0x0
     838:	dcc080e7          	jalr	-564(ra) # 600 <putc>
     83c:	aac9                	j	a0e <vprintf+0x23e>
      }
    } else if(state == '%'){
     83e:	fe042783          	lw	a5,-32(s0)
     842:	0007871b          	sext.w	a4,a5
     846:	02500793          	li	a5,37
     84a:	1cf71263          	bne	a4,a5,a0e <vprintf+0x23e>
      if(c == 'd'){
     84e:	fdc42783          	lw	a5,-36(s0)
     852:	0007871b          	sext.w	a4,a5
     856:	06400793          	li	a5,100
     85a:	02f71463          	bne	a4,a5,882 <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
     85e:	fb843783          	ld	a5,-72(s0)
     862:	00878713          	addi	a4,a5,8
     866:	fae43c23          	sd	a4,-72(s0)
     86a:	4398                	lw	a4,0(a5)
     86c:	fcc42783          	lw	a5,-52(s0)
     870:	4685                	li	a3,1
     872:	4629                	li	a2,10
     874:	85ba                	mv	a1,a4
     876:	853e                	mv	a0,a5
     878:	00000097          	auipc	ra,0x0
     87c:	dbe080e7          	jalr	-578(ra) # 636 <printint>
     880:	a269                	j	a0a <vprintf+0x23a>
      } else if(c == 'l') {
     882:	fdc42783          	lw	a5,-36(s0)
     886:	0007871b          	sext.w	a4,a5
     88a:	06c00793          	li	a5,108
     88e:	02f71663          	bne	a4,a5,8ba <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
     892:	fb843783          	ld	a5,-72(s0)
     896:	00878713          	addi	a4,a5,8
     89a:	fae43c23          	sd	a4,-72(s0)
     89e:	639c                	ld	a5,0(a5)
     8a0:	0007871b          	sext.w	a4,a5
     8a4:	fcc42783          	lw	a5,-52(s0)
     8a8:	4681                	li	a3,0
     8aa:	4629                	li	a2,10
     8ac:	85ba                	mv	a1,a4
     8ae:	853e                	mv	a0,a5
     8b0:	00000097          	auipc	ra,0x0
     8b4:	d86080e7          	jalr	-634(ra) # 636 <printint>
     8b8:	aa89                	j	a0a <vprintf+0x23a>
      } else if(c == 'x') {
     8ba:	fdc42783          	lw	a5,-36(s0)
     8be:	0007871b          	sext.w	a4,a5
     8c2:	07800793          	li	a5,120
     8c6:	02f71463          	bne	a4,a5,8ee <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
     8ca:	fb843783          	ld	a5,-72(s0)
     8ce:	00878713          	addi	a4,a5,8
     8d2:	fae43c23          	sd	a4,-72(s0)
     8d6:	4398                	lw	a4,0(a5)
     8d8:	fcc42783          	lw	a5,-52(s0)
     8dc:	4681                	li	a3,0
     8de:	4641                	li	a2,16
     8e0:	85ba                	mv	a1,a4
     8e2:	853e                	mv	a0,a5
     8e4:	00000097          	auipc	ra,0x0
     8e8:	d52080e7          	jalr	-686(ra) # 636 <printint>
     8ec:	aa39                	j	a0a <vprintf+0x23a>
      } else if(c == 'p') {
     8ee:	fdc42783          	lw	a5,-36(s0)
     8f2:	0007871b          	sext.w	a4,a5
     8f6:	07000793          	li	a5,112
     8fa:	02f71263          	bne	a4,a5,91e <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
     8fe:	fb843783          	ld	a5,-72(s0)
     902:	00878713          	addi	a4,a5,8
     906:	fae43c23          	sd	a4,-72(s0)
     90a:	6398                	ld	a4,0(a5)
     90c:	fcc42783          	lw	a5,-52(s0)
     910:	85ba                	mv	a1,a4
     912:	853e                	mv	a0,a5
     914:	00000097          	auipc	ra,0x0
     918:	e30080e7          	jalr	-464(ra) # 744 <printptr>
     91c:	a0fd                	j	a0a <vprintf+0x23a>
      } else if(c == 's'){
     91e:	fdc42783          	lw	a5,-36(s0)
     922:	0007871b          	sext.w	a4,a5
     926:	07300793          	li	a5,115
     92a:	04f71c63          	bne	a4,a5,982 <vprintf+0x1b2>
        s = va_arg(ap, char*);
     92e:	fb843783          	ld	a5,-72(s0)
     932:	00878713          	addi	a4,a5,8
     936:	fae43c23          	sd	a4,-72(s0)
     93a:	639c                	ld	a5,0(a5)
     93c:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
     940:	fe843783          	ld	a5,-24(s0)
     944:	eb8d                	bnez	a5,976 <vprintf+0x1a6>
          s = "(null)";
     946:	00001797          	auipc	a5,0x1
     94a:	cf278793          	addi	a5,a5,-782 # 1638 <schedule_rm+0x370>
     94e:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     952:	a015                	j	976 <vprintf+0x1a6>
          putc(fd, *s);
     954:	fe843783          	ld	a5,-24(s0)
     958:	0007c703          	lbu	a4,0(a5)
     95c:	fcc42783          	lw	a5,-52(s0)
     960:	85ba                	mv	a1,a4
     962:	853e                	mv	a0,a5
     964:	00000097          	auipc	ra,0x0
     968:	c9c080e7          	jalr	-868(ra) # 600 <putc>
          s++;
     96c:	fe843783          	ld	a5,-24(s0)
     970:	0785                	addi	a5,a5,1
     972:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     976:	fe843783          	ld	a5,-24(s0)
     97a:	0007c783          	lbu	a5,0(a5)
     97e:	fbf9                	bnez	a5,954 <vprintf+0x184>
     980:	a069                	j	a0a <vprintf+0x23a>
        }
      } else if(c == 'c'){
     982:	fdc42783          	lw	a5,-36(s0)
     986:	0007871b          	sext.w	a4,a5
     98a:	06300793          	li	a5,99
     98e:	02f71463          	bne	a4,a5,9b6 <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
     992:	fb843783          	ld	a5,-72(s0)
     996:	00878713          	addi	a4,a5,8
     99a:	fae43c23          	sd	a4,-72(s0)
     99e:	439c                	lw	a5,0(a5)
     9a0:	0ff7f713          	andi	a4,a5,255
     9a4:	fcc42783          	lw	a5,-52(s0)
     9a8:	85ba                	mv	a1,a4
     9aa:	853e                	mv	a0,a5
     9ac:	00000097          	auipc	ra,0x0
     9b0:	c54080e7          	jalr	-940(ra) # 600 <putc>
     9b4:	a899                	j	a0a <vprintf+0x23a>
      } else if(c == '%'){
     9b6:	fdc42783          	lw	a5,-36(s0)
     9ba:	0007871b          	sext.w	a4,a5
     9be:	02500793          	li	a5,37
     9c2:	00f71f63          	bne	a4,a5,9e0 <vprintf+0x210>
        putc(fd, c);
     9c6:	fdc42783          	lw	a5,-36(s0)
     9ca:	0ff7f713          	andi	a4,a5,255
     9ce:	fcc42783          	lw	a5,-52(s0)
     9d2:	85ba                	mv	a1,a4
     9d4:	853e                	mv	a0,a5
     9d6:	00000097          	auipc	ra,0x0
     9da:	c2a080e7          	jalr	-982(ra) # 600 <putc>
     9de:	a035                	j	a0a <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     9e0:	fcc42783          	lw	a5,-52(s0)
     9e4:	02500593          	li	a1,37
     9e8:	853e                	mv	a0,a5
     9ea:	00000097          	auipc	ra,0x0
     9ee:	c16080e7          	jalr	-1002(ra) # 600 <putc>
        putc(fd, c);
     9f2:	fdc42783          	lw	a5,-36(s0)
     9f6:	0ff7f713          	andi	a4,a5,255
     9fa:	fcc42783          	lw	a5,-52(s0)
     9fe:	85ba                	mv	a1,a4
     a00:	853e                	mv	a0,a5
     a02:	00000097          	auipc	ra,0x0
     a06:	bfe080e7          	jalr	-1026(ra) # 600 <putc>
      }
      state = 0;
     a0a:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     a0e:	fe442783          	lw	a5,-28(s0)
     a12:	2785                	addiw	a5,a5,1
     a14:	fef42223          	sw	a5,-28(s0)
     a18:	fe442783          	lw	a5,-28(s0)
     a1c:	fc043703          	ld	a4,-64(s0)
     a20:	97ba                	add	a5,a5,a4
     a22:	0007c783          	lbu	a5,0(a5)
     a26:	dc0795e3          	bnez	a5,7f0 <vprintf+0x20>
    }
  }
}
     a2a:	0001                	nop
     a2c:	0001                	nop
     a2e:	60a6                	ld	ra,72(sp)
     a30:	6406                	ld	s0,64(sp)
     a32:	6161                	addi	sp,sp,80
     a34:	8082                	ret

0000000000000a36 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     a36:	7159                	addi	sp,sp,-112
     a38:	fc06                	sd	ra,56(sp)
     a3a:	f822                	sd	s0,48(sp)
     a3c:	0080                	addi	s0,sp,64
     a3e:	fcb43823          	sd	a1,-48(s0)
     a42:	e010                	sd	a2,0(s0)
     a44:	e414                	sd	a3,8(s0)
     a46:	e818                	sd	a4,16(s0)
     a48:	ec1c                	sd	a5,24(s0)
     a4a:	03043023          	sd	a6,32(s0)
     a4e:	03143423          	sd	a7,40(s0)
     a52:	87aa                	mv	a5,a0
     a54:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
     a58:	03040793          	addi	a5,s0,48
     a5c:	fcf43423          	sd	a5,-56(s0)
     a60:	fc843783          	ld	a5,-56(s0)
     a64:	fd078793          	addi	a5,a5,-48
     a68:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
     a6c:	fe843703          	ld	a4,-24(s0)
     a70:	fdc42783          	lw	a5,-36(s0)
     a74:	863a                	mv	a2,a4
     a76:	fd043583          	ld	a1,-48(s0)
     a7a:	853e                	mv	a0,a5
     a7c:	00000097          	auipc	ra,0x0
     a80:	d54080e7          	jalr	-684(ra) # 7d0 <vprintf>
}
     a84:	0001                	nop
     a86:	70e2                	ld	ra,56(sp)
     a88:	7442                	ld	s0,48(sp)
     a8a:	6165                	addi	sp,sp,112
     a8c:	8082                	ret

0000000000000a8e <printf>:

void
printf(const char *fmt, ...)
{
     a8e:	7159                	addi	sp,sp,-112
     a90:	f406                	sd	ra,40(sp)
     a92:	f022                	sd	s0,32(sp)
     a94:	1800                	addi	s0,sp,48
     a96:	fca43c23          	sd	a0,-40(s0)
     a9a:	e40c                	sd	a1,8(s0)
     a9c:	e810                	sd	a2,16(s0)
     a9e:	ec14                	sd	a3,24(s0)
     aa0:	f018                	sd	a4,32(s0)
     aa2:	f41c                	sd	a5,40(s0)
     aa4:	03043823          	sd	a6,48(s0)
     aa8:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
     aac:	04040793          	addi	a5,s0,64
     ab0:	fcf43823          	sd	a5,-48(s0)
     ab4:	fd043783          	ld	a5,-48(s0)
     ab8:	fc878793          	addi	a5,a5,-56
     abc:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
     ac0:	fe843783          	ld	a5,-24(s0)
     ac4:	863e                	mv	a2,a5
     ac6:	fd843583          	ld	a1,-40(s0)
     aca:	4505                	li	a0,1
     acc:	00000097          	auipc	ra,0x0
     ad0:	d04080e7          	jalr	-764(ra) # 7d0 <vprintf>
}
     ad4:	0001                	nop
     ad6:	70a2                	ld	ra,40(sp)
     ad8:	7402                	ld	s0,32(sp)
     ada:	6165                	addi	sp,sp,112
     adc:	8082                	ret

0000000000000ade <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     ade:	7179                	addi	sp,sp,-48
     ae0:	f422                	sd	s0,40(sp)
     ae2:	1800                	addi	s0,sp,48
     ae4:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
     ae8:	fd843783          	ld	a5,-40(s0)
     aec:	17c1                	addi	a5,a5,-16
     aee:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     af2:	00001797          	auipc	a5,0x1
     af6:	b7678793          	addi	a5,a5,-1162 # 1668 <freep>
     afa:	639c                	ld	a5,0(a5)
     afc:	fef43423          	sd	a5,-24(s0)
     b00:	a815                	j	b34 <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     b02:	fe843783          	ld	a5,-24(s0)
     b06:	639c                	ld	a5,0(a5)
     b08:	fe843703          	ld	a4,-24(s0)
     b0c:	00f76f63          	bltu	a4,a5,b2a <free+0x4c>
     b10:	fe043703          	ld	a4,-32(s0)
     b14:	fe843783          	ld	a5,-24(s0)
     b18:	02e7eb63          	bltu	a5,a4,b4e <free+0x70>
     b1c:	fe843783          	ld	a5,-24(s0)
     b20:	639c                	ld	a5,0(a5)
     b22:	fe043703          	ld	a4,-32(s0)
     b26:	02f76463          	bltu	a4,a5,b4e <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     b2a:	fe843783          	ld	a5,-24(s0)
     b2e:	639c                	ld	a5,0(a5)
     b30:	fef43423          	sd	a5,-24(s0)
     b34:	fe043703          	ld	a4,-32(s0)
     b38:	fe843783          	ld	a5,-24(s0)
     b3c:	fce7f3e3          	bgeu	a5,a4,b02 <free+0x24>
     b40:	fe843783          	ld	a5,-24(s0)
     b44:	639c                	ld	a5,0(a5)
     b46:	fe043703          	ld	a4,-32(s0)
     b4a:	faf77ce3          	bgeu	a4,a5,b02 <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
     b4e:	fe043783          	ld	a5,-32(s0)
     b52:	479c                	lw	a5,8(a5)
     b54:	1782                	slli	a5,a5,0x20
     b56:	9381                	srli	a5,a5,0x20
     b58:	0792                	slli	a5,a5,0x4
     b5a:	fe043703          	ld	a4,-32(s0)
     b5e:	973e                	add	a4,a4,a5
     b60:	fe843783          	ld	a5,-24(s0)
     b64:	639c                	ld	a5,0(a5)
     b66:	02f71763          	bne	a4,a5,b94 <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
     b6a:	fe043783          	ld	a5,-32(s0)
     b6e:	4798                	lw	a4,8(a5)
     b70:	fe843783          	ld	a5,-24(s0)
     b74:	639c                	ld	a5,0(a5)
     b76:	479c                	lw	a5,8(a5)
     b78:	9fb9                	addw	a5,a5,a4
     b7a:	0007871b          	sext.w	a4,a5
     b7e:	fe043783          	ld	a5,-32(s0)
     b82:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
     b84:	fe843783          	ld	a5,-24(s0)
     b88:	639c                	ld	a5,0(a5)
     b8a:	6398                	ld	a4,0(a5)
     b8c:	fe043783          	ld	a5,-32(s0)
     b90:	e398                	sd	a4,0(a5)
     b92:	a039                	j	ba0 <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
     b94:	fe843783          	ld	a5,-24(s0)
     b98:	6398                	ld	a4,0(a5)
     b9a:	fe043783          	ld	a5,-32(s0)
     b9e:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
     ba0:	fe843783          	ld	a5,-24(s0)
     ba4:	479c                	lw	a5,8(a5)
     ba6:	1782                	slli	a5,a5,0x20
     ba8:	9381                	srli	a5,a5,0x20
     baa:	0792                	slli	a5,a5,0x4
     bac:	fe843703          	ld	a4,-24(s0)
     bb0:	97ba                	add	a5,a5,a4
     bb2:	fe043703          	ld	a4,-32(s0)
     bb6:	02f71563          	bne	a4,a5,be0 <free+0x102>
    p->s.size += bp->s.size;
     bba:	fe843783          	ld	a5,-24(s0)
     bbe:	4798                	lw	a4,8(a5)
     bc0:	fe043783          	ld	a5,-32(s0)
     bc4:	479c                	lw	a5,8(a5)
     bc6:	9fb9                	addw	a5,a5,a4
     bc8:	0007871b          	sext.w	a4,a5
     bcc:	fe843783          	ld	a5,-24(s0)
     bd0:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
     bd2:	fe043783          	ld	a5,-32(s0)
     bd6:	6398                	ld	a4,0(a5)
     bd8:	fe843783          	ld	a5,-24(s0)
     bdc:	e398                	sd	a4,0(a5)
     bde:	a031                	j	bea <free+0x10c>
  } else
    p->s.ptr = bp;
     be0:	fe843783          	ld	a5,-24(s0)
     be4:	fe043703          	ld	a4,-32(s0)
     be8:	e398                	sd	a4,0(a5)
  freep = p;
     bea:	00001797          	auipc	a5,0x1
     bee:	a7e78793          	addi	a5,a5,-1410 # 1668 <freep>
     bf2:	fe843703          	ld	a4,-24(s0)
     bf6:	e398                	sd	a4,0(a5)
}
     bf8:	0001                	nop
     bfa:	7422                	ld	s0,40(sp)
     bfc:	6145                	addi	sp,sp,48
     bfe:	8082                	ret

0000000000000c00 <morecore>:

static Header*
morecore(uint nu)
{
     c00:	7179                	addi	sp,sp,-48
     c02:	f406                	sd	ra,40(sp)
     c04:	f022                	sd	s0,32(sp)
     c06:	1800                	addi	s0,sp,48
     c08:	87aa                	mv	a5,a0
     c0a:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
     c0e:	fdc42783          	lw	a5,-36(s0)
     c12:	0007871b          	sext.w	a4,a5
     c16:	6785                	lui	a5,0x1
     c18:	00f77563          	bgeu	a4,a5,c22 <morecore+0x22>
    nu = 4096;
     c1c:	6785                	lui	a5,0x1
     c1e:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
     c22:	fdc42783          	lw	a5,-36(s0)
     c26:	0047979b          	slliw	a5,a5,0x4
     c2a:	2781                	sext.w	a5,a5
     c2c:	2781                	sext.w	a5,a5
     c2e:	853e                	mv	a0,a5
     c30:	00000097          	auipc	ra,0x0
     c34:	9a0080e7          	jalr	-1632(ra) # 5d0 <sbrk>
     c38:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
     c3c:	fe843703          	ld	a4,-24(s0)
     c40:	57fd                	li	a5,-1
     c42:	00f71463          	bne	a4,a5,c4a <morecore+0x4a>
    return 0;
     c46:	4781                	li	a5,0
     c48:	a03d                	j	c76 <morecore+0x76>
  hp = (Header*)p;
     c4a:	fe843783          	ld	a5,-24(s0)
     c4e:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
     c52:	fe043783          	ld	a5,-32(s0)
     c56:	fdc42703          	lw	a4,-36(s0)
     c5a:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
     c5c:	fe043783          	ld	a5,-32(s0)
     c60:	07c1                	addi	a5,a5,16
     c62:	853e                	mv	a0,a5
     c64:	00000097          	auipc	ra,0x0
     c68:	e7a080e7          	jalr	-390(ra) # ade <free>
  return freep;
     c6c:	00001797          	auipc	a5,0x1
     c70:	9fc78793          	addi	a5,a5,-1540 # 1668 <freep>
     c74:	639c                	ld	a5,0(a5)
}
     c76:	853e                	mv	a0,a5
     c78:	70a2                	ld	ra,40(sp)
     c7a:	7402                	ld	s0,32(sp)
     c7c:	6145                	addi	sp,sp,48
     c7e:	8082                	ret

0000000000000c80 <malloc>:

void*
malloc(uint nbytes)
{
     c80:	7139                	addi	sp,sp,-64
     c82:	fc06                	sd	ra,56(sp)
     c84:	f822                	sd	s0,48(sp)
     c86:	0080                	addi	s0,sp,64
     c88:	87aa                	mv	a5,a0
     c8a:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     c8e:	fcc46783          	lwu	a5,-52(s0)
     c92:	07bd                	addi	a5,a5,15
     c94:	8391                	srli	a5,a5,0x4
     c96:	2781                	sext.w	a5,a5
     c98:	2785                	addiw	a5,a5,1
     c9a:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
     c9e:	00001797          	auipc	a5,0x1
     ca2:	9ca78793          	addi	a5,a5,-1590 # 1668 <freep>
     ca6:	639c                	ld	a5,0(a5)
     ca8:	fef43023          	sd	a5,-32(s0)
     cac:	fe043783          	ld	a5,-32(s0)
     cb0:	ef95                	bnez	a5,cec <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
     cb2:	00001797          	auipc	a5,0x1
     cb6:	9a678793          	addi	a5,a5,-1626 # 1658 <base>
     cba:	fef43023          	sd	a5,-32(s0)
     cbe:	00001797          	auipc	a5,0x1
     cc2:	9aa78793          	addi	a5,a5,-1622 # 1668 <freep>
     cc6:	fe043703          	ld	a4,-32(s0)
     cca:	e398                	sd	a4,0(a5)
     ccc:	00001797          	auipc	a5,0x1
     cd0:	99c78793          	addi	a5,a5,-1636 # 1668 <freep>
     cd4:	6398                	ld	a4,0(a5)
     cd6:	00001797          	auipc	a5,0x1
     cda:	98278793          	addi	a5,a5,-1662 # 1658 <base>
     cde:	e398                	sd	a4,0(a5)
    base.s.size = 0;
     ce0:	00001797          	auipc	a5,0x1
     ce4:	97878793          	addi	a5,a5,-1672 # 1658 <base>
     ce8:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     cec:	fe043783          	ld	a5,-32(s0)
     cf0:	639c                	ld	a5,0(a5)
     cf2:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     cf6:	fe843783          	ld	a5,-24(s0)
     cfa:	4798                	lw	a4,8(a5)
     cfc:	fdc42783          	lw	a5,-36(s0)
     d00:	2781                	sext.w	a5,a5
     d02:	06f76863          	bltu	a4,a5,d72 <malloc+0xf2>
      if(p->s.size == nunits)
     d06:	fe843783          	ld	a5,-24(s0)
     d0a:	4798                	lw	a4,8(a5)
     d0c:	fdc42783          	lw	a5,-36(s0)
     d10:	2781                	sext.w	a5,a5
     d12:	00e79963          	bne	a5,a4,d24 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
     d16:	fe843783          	ld	a5,-24(s0)
     d1a:	6398                	ld	a4,0(a5)
     d1c:	fe043783          	ld	a5,-32(s0)
     d20:	e398                	sd	a4,0(a5)
     d22:	a82d                	j	d5c <malloc+0xdc>
      else {
        p->s.size -= nunits;
     d24:	fe843783          	ld	a5,-24(s0)
     d28:	4798                	lw	a4,8(a5)
     d2a:	fdc42783          	lw	a5,-36(s0)
     d2e:	40f707bb          	subw	a5,a4,a5
     d32:	0007871b          	sext.w	a4,a5
     d36:	fe843783          	ld	a5,-24(s0)
     d3a:	c798                	sw	a4,8(a5)
        p += p->s.size;
     d3c:	fe843783          	ld	a5,-24(s0)
     d40:	479c                	lw	a5,8(a5)
     d42:	1782                	slli	a5,a5,0x20
     d44:	9381                	srli	a5,a5,0x20
     d46:	0792                	slli	a5,a5,0x4
     d48:	fe843703          	ld	a4,-24(s0)
     d4c:	97ba                	add	a5,a5,a4
     d4e:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
     d52:	fe843783          	ld	a5,-24(s0)
     d56:	fdc42703          	lw	a4,-36(s0)
     d5a:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
     d5c:	00001797          	auipc	a5,0x1
     d60:	90c78793          	addi	a5,a5,-1780 # 1668 <freep>
     d64:	fe043703          	ld	a4,-32(s0)
     d68:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
     d6a:	fe843783          	ld	a5,-24(s0)
     d6e:	07c1                	addi	a5,a5,16
     d70:	a091                	j	db4 <malloc+0x134>
    }
    if(p == freep)
     d72:	00001797          	auipc	a5,0x1
     d76:	8f678793          	addi	a5,a5,-1802 # 1668 <freep>
     d7a:	639c                	ld	a5,0(a5)
     d7c:	fe843703          	ld	a4,-24(s0)
     d80:	02f71063          	bne	a4,a5,da0 <malloc+0x120>
      if((p = morecore(nunits)) == 0)
     d84:	fdc42783          	lw	a5,-36(s0)
     d88:	853e                	mv	a0,a5
     d8a:	00000097          	auipc	ra,0x0
     d8e:	e76080e7          	jalr	-394(ra) # c00 <morecore>
     d92:	fea43423          	sd	a0,-24(s0)
     d96:	fe843783          	ld	a5,-24(s0)
     d9a:	e399                	bnez	a5,da0 <malloc+0x120>
        return 0;
     d9c:	4781                	li	a5,0
     d9e:	a819                	j	db4 <malloc+0x134>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     da0:	fe843783          	ld	a5,-24(s0)
     da4:	fef43023          	sd	a5,-32(s0)
     da8:	fe843783          	ld	a5,-24(s0)
     dac:	639c                	ld	a5,0(a5)
     dae:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     db2:	b791                	j	cf6 <malloc+0x76>
  }
}
     db4:	853e                	mv	a0,a5
     db6:	70e2                	ld	ra,56(sp)
     db8:	7442                	ld	s0,48(sp)
     dba:	6121                	addi	sp,sp,64
     dbc:	8082                	ret

0000000000000dbe <setjmp>:
     dbe:	e100                	sd	s0,0(a0)
     dc0:	e504                	sd	s1,8(a0)
     dc2:	01253823          	sd	s2,16(a0)
     dc6:	01353c23          	sd	s3,24(a0)
     dca:	03453023          	sd	s4,32(a0)
     dce:	03553423          	sd	s5,40(a0)
     dd2:	03653823          	sd	s6,48(a0)
     dd6:	03753c23          	sd	s7,56(a0)
     dda:	05853023          	sd	s8,64(a0)
     dde:	05953423          	sd	s9,72(a0)
     de2:	05a53823          	sd	s10,80(a0)
     de6:	05b53c23          	sd	s11,88(a0)
     dea:	06153023          	sd	ra,96(a0)
     dee:	06253423          	sd	sp,104(a0)
     df2:	4501                	li	a0,0
     df4:	8082                	ret

0000000000000df6 <longjmp>:
     df6:	6100                	ld	s0,0(a0)
     df8:	6504                	ld	s1,8(a0)
     dfa:	01053903          	ld	s2,16(a0)
     dfe:	01853983          	ld	s3,24(a0)
     e02:	02053a03          	ld	s4,32(a0)
     e06:	02853a83          	ld	s5,40(a0)
     e0a:	03053b03          	ld	s6,48(a0)
     e0e:	03853b83          	ld	s7,56(a0)
     e12:	04053c03          	ld	s8,64(a0)
     e16:	04853c83          	ld	s9,72(a0)
     e1a:	05053d03          	ld	s10,80(a0)
     e1e:	05853d83          	ld	s11,88(a0)
     e22:	06053083          	ld	ra,96(a0)
     e26:	06853103          	ld	sp,104(a0)
     e2a:	c199                	beqz	a1,e30 <longjmp_1>
     e2c:	852e                	mv	a0,a1
     e2e:	8082                	ret

0000000000000e30 <longjmp_1>:
     e30:	4505                	li	a0,1
     e32:	8082                	ret

0000000000000e34 <list_empty>:
/**
 * list_empty - tests whether a list is empty
 * @head: the list to test.
 */
static inline int list_empty(const struct list_head *head)
{
     e34:	1101                	addi	sp,sp,-32
     e36:	ec22                	sd	s0,24(sp)
     e38:	1000                	addi	s0,sp,32
     e3a:	fea43423          	sd	a0,-24(s0)
    return head->next == head;
     e3e:	fe843783          	ld	a5,-24(s0)
     e42:	639c                	ld	a5,0(a5)
     e44:	fe843703          	ld	a4,-24(s0)
     e48:	40f707b3          	sub	a5,a4,a5
     e4c:	0017b793          	seqz	a5,a5
     e50:	0ff7f793          	andi	a5,a5,255
     e54:	2781                	sext.w	a5,a5
}
     e56:	853e                	mv	a0,a5
     e58:	6462                	ld	s0,24(sp)
     e5a:	6105                	addi	sp,sp,32
     e5c:	8082                	ret

0000000000000e5e <schedule_default>:

#define NULL 0

/* default scheduling algorithm */
struct threads_sched_result schedule_default(struct threads_sched_args args)
{
     e5e:	715d                	addi	sp,sp,-80
     e60:	e4a2                	sd	s0,72(sp)
     e62:	e0a6                	sd	s1,64(sp)
     e64:	0880                	addi	s0,sp,80
     e66:	84aa                	mv	s1,a0
    struct thread *thread_with_smallest_id = NULL;
     e68:	fe043423          	sd	zero,-24(s0)
    struct thread *th = NULL;
     e6c:	fe043023          	sd	zero,-32(s0)
    list_for_each_entry(th, args.run_queue, thread_list) {
     e70:	649c                	ld	a5,8(s1)
     e72:	639c                	ld	a5,0(a5)
     e74:	fcf43c23          	sd	a5,-40(s0)
     e78:	fd843783          	ld	a5,-40(s0)
     e7c:	fd878793          	addi	a5,a5,-40
     e80:	fef43023          	sd	a5,-32(s0)
     e84:	a81d                	j	eba <schedule_default+0x5c>
        if (thread_with_smallest_id == NULL || th->ID < thread_with_smallest_id->ID) {
     e86:	fe843783          	ld	a5,-24(s0)
     e8a:	cb89                	beqz	a5,e9c <schedule_default+0x3e>
     e8c:	fe043783          	ld	a5,-32(s0)
     e90:	5398                	lw	a4,32(a5)
     e92:	fe843783          	ld	a5,-24(s0)
     e96:	539c                	lw	a5,32(a5)
     e98:	00f75663          	bge	a4,a5,ea4 <schedule_default+0x46>
            thread_with_smallest_id = th;
     e9c:	fe043783          	ld	a5,-32(s0)
     ea0:	fef43423          	sd	a5,-24(s0)
    list_for_each_entry(th, args.run_queue, thread_list) {
     ea4:	fe043783          	ld	a5,-32(s0)
     ea8:	779c                	ld	a5,40(a5)
     eaa:	fcf43823          	sd	a5,-48(s0)
     eae:	fd043783          	ld	a5,-48(s0)
     eb2:	fd878793          	addi	a5,a5,-40
     eb6:	fef43023          	sd	a5,-32(s0)
     eba:	fe043783          	ld	a5,-32(s0)
     ebe:	02878713          	addi	a4,a5,40
     ec2:	649c                	ld	a5,8(s1)
     ec4:	fcf711e3          	bne	a4,a5,e86 <schedule_default+0x28>
        }
    }

    struct threads_sched_result r;
    if (thread_with_smallest_id != NULL) {
     ec8:	fe843783          	ld	a5,-24(s0)
     ecc:	cf89                	beqz	a5,ee6 <schedule_default+0x88>
        r.scheduled_thread_list_member = &thread_with_smallest_id->thread_list;
     ece:	fe843783          	ld	a5,-24(s0)
     ed2:	02878793          	addi	a5,a5,40
     ed6:	faf43823          	sd	a5,-80(s0)
        r.allocated_time = thread_with_smallest_id->remaining_time;
     eda:	fe843783          	ld	a5,-24(s0)
     ede:	47fc                	lw	a5,76(a5)
     ee0:	faf42c23          	sw	a5,-72(s0)
     ee4:	a039                	j	ef2 <schedule_default+0x94>
    } else {
        r.scheduled_thread_list_member = args.run_queue;
     ee6:	649c                	ld	a5,8(s1)
     ee8:	faf43823          	sd	a5,-80(s0)
        r.allocated_time = 1;
     eec:	4785                	li	a5,1
     eee:	faf42c23          	sw	a5,-72(s0)
    }

    return r;
     ef2:	fb043783          	ld	a5,-80(s0)
     ef6:	fcf43023          	sd	a5,-64(s0)
     efa:	fb843783          	ld	a5,-72(s0)
     efe:	fcf43423          	sd	a5,-56(s0)
     f02:	fc043703          	ld	a4,-64(s0)
     f06:	fc843783          	ld	a5,-56(s0)
     f0a:	863a                	mv	a2,a4
     f0c:	86be                	mv	a3,a5
     f0e:	8732                	mv	a4,a2
     f10:	87b6                	mv	a5,a3
}
     f12:	853a                	mv	a0,a4
     f14:	85be                	mv	a1,a5
     f16:	6426                	ld	s0,72(sp)
     f18:	6486                	ld	s1,64(sp)
     f1a:	6161                	addi	sp,sp,80
     f1c:	8082                	ret

0000000000000f1e <schedule_edf>:

/* Earliest-Deadline-First scheduling */
struct threads_sched_result schedule_edf(struct threads_sched_args args)
{
     f1e:	7115                	addi	sp,sp,-224
     f20:	ed86                	sd	ra,216(sp)
     f22:	e9a2                	sd	s0,208(sp)
     f24:	e5a6                	sd	s1,200(sp)
     f26:	e1ca                	sd	s2,192(sp)
     f28:	fd4e                	sd	s3,184(sp)
     f2a:	1180                	addi	s0,sp,224
     f2c:	84aa                	mv	s1,a0
    // the scheduling is called when a interrupt event happens (either a fn end or a new one is added)
    // need to determine the next thread to execute and the allocated time.

    struct threads_sched_result r;
    if(list_empty(args.run_queue)){
     f2e:	649c                	ld	a5,8(s1)
     f30:	853e                	mv	a0,a5
     f32:	00000097          	auipc	ra,0x0
     f36:	f02080e7          	jalr	-254(ra) # e34 <list_empty>
     f3a:	87aa                	mv	a5,a0
     f3c:	c3d1                	beqz	a5,fc0 <schedule_edf+0xa2>
        // SPEC 3
        r.scheduled_thread_list_member = args.run_queue;
     f3e:	649c                	ld	a5,8(s1)
     f40:	f2f43423          	sd	a5,-216(s0)
        int least_release_time = 99999;
     f44:	67e1                	lui	a5,0x18
     f46:	69f78793          	addi	a5,a5,1695 # 1869f <__global_pointer$+0x1685f>
     f4a:	fcf42623          	sw	a5,-52(s0)
        struct release_queue_entry* cur;
        list_for_each_entry(cur, args.release_queue, thread_list) {
     f4e:	689c                	ld	a5,16(s1)
     f50:	639c                	ld	a5,0(a5)
     f52:	f4f43823          	sd	a5,-176(s0)
     f56:	f5043783          	ld	a5,-176(s0)
     f5a:	17e1                	addi	a5,a5,-8
     f5c:	fcf43023          	sd	a5,-64(s0)
     f60:	a805                	j	f90 <schedule_edf+0x72>
            if(cur->release_time<least_release_time){
     f62:	fc043783          	ld	a5,-64(s0)
     f66:	4f98                	lw	a4,24(a5)
     f68:	fcc42783          	lw	a5,-52(s0)
     f6c:	2781                	sext.w	a5,a5
     f6e:	00f75763          	bge	a4,a5,f7c <schedule_edf+0x5e>
                least_release_time = cur->release_time;
     f72:	fc043783          	ld	a5,-64(s0)
     f76:	4f9c                	lw	a5,24(a5)
     f78:	fcf42623          	sw	a5,-52(s0)
        list_for_each_entry(cur, args.release_queue, thread_list) {
     f7c:	fc043783          	ld	a5,-64(s0)
     f80:	679c                	ld	a5,8(a5)
     f82:	f4f43423          	sd	a5,-184(s0)
     f86:	f4843783          	ld	a5,-184(s0)
     f8a:	17e1                	addi	a5,a5,-8
     f8c:	fcf43023          	sd	a5,-64(s0)
     f90:	fc043783          	ld	a5,-64(s0)
     f94:	00878713          	addi	a4,a5,8
     f98:	689c                	ld	a5,16(s1)
     f9a:	fcf714e3          	bne	a4,a5,f62 <schedule_edf+0x44>
            }
        }
        r.allocated_time = least_release_time - args.current_time ;
     f9e:	409c                	lw	a5,0(s1)
     fa0:	fcc42703          	lw	a4,-52(s0)
     fa4:	40f707bb          	subw	a5,a4,a5
     fa8:	2781                	sext.w	a5,a5
     faa:	f2f42823          	sw	a5,-208(s0)
        return r;
     fae:	f2843783          	ld	a5,-216(s0)
     fb2:	f2f43c23          	sd	a5,-200(s0)
     fb6:	f3043783          	ld	a5,-208(s0)
     fba:	f4f43023          	sd	a5,-192(s0)
     fbe:	a4e5                	j	12a6 <schedule_edf+0x388>
    }else{
        // run queue is not empty.
        struct thread *th = NULL;
     fc0:	fa043c23          	sd	zero,-72(s0)
        struct thread *min_th = NULL;
     fc4:	fa043823          	sd	zero,-80(s0)
        struct thread *min_miss_deadline_th = NULL;
     fc8:	fa043423          	sd	zero,-88(s0)
        list_for_each_entry(th, args.run_queue, thread_list) {
     fcc:	649c                	ld	a5,8(s1)
     fce:	639c                	ld	a5,0(a5)
     fd0:	f8f43423          	sd	a5,-120(s0)
     fd4:	f8843783          	ld	a5,-120(s0)
     fd8:	fd878793          	addi	a5,a5,-40
     fdc:	faf43c23          	sd	a5,-72(s0)
     fe0:	a849                	j	1072 <schedule_edf+0x154>
            // printf("in run queue: %d\n", th->ID);
            if(th->current_deadline <= args.current_time){
     fe2:	fb843783          	ld	a5,-72(s0)
     fe6:	4bb8                	lw	a4,80(a5)
     fe8:	409c                	lw	a5,0(s1)
     fea:	02e7c163          	blt	a5,a4,100c <schedule_edf+0xee>
                if(min_miss_deadline_th == NULL || th->ID<min_miss_deadline_th->ID){
     fee:	fa843783          	ld	a5,-88(s0)
     ff2:	cb89                	beqz	a5,1004 <schedule_edf+0xe6>
     ff4:	fb843783          	ld	a5,-72(s0)
     ff8:	5398                	lw	a4,32(a5)
     ffa:	fa843783          	ld	a5,-88(s0)
     ffe:	539c                	lw	a5,32(a5)
    1000:	00f75663          	bge	a4,a5,100c <schedule_edf+0xee>
                    min_miss_deadline_th = th;
    1004:	fb843783          	ld	a5,-72(s0)
    1008:	faf43423          	sd	a5,-88(s0)
                }
            }
            if(min_th == NULL) min_th = th;
    100c:	fb043783          	ld	a5,-80(s0)
    1010:	e789                	bnez	a5,101a <schedule_edf+0xfc>
    1012:	fb843783          	ld	a5,-72(s0)
    1016:	faf43823          	sd	a5,-80(s0)
            if(th->current_deadline<min_th->current_deadline){
    101a:	fb843783          	ld	a5,-72(s0)
    101e:	4bb8                	lw	a4,80(a5)
    1020:	fb043783          	ld	a5,-80(s0)
    1024:	4bbc                	lw	a5,80(a5)
    1026:	00f75763          	bge	a4,a5,1034 <schedule_edf+0x116>
                min_th = th;
    102a:	fb843783          	ld	a5,-72(s0)
    102e:	faf43823          	sd	a5,-80(s0)
    1032:	a02d                	j	105c <schedule_edf+0x13e>
            }else if(th->current_deadline == min_th->current_deadline){
    1034:	fb843783          	ld	a5,-72(s0)
    1038:	4bb8                	lw	a4,80(a5)
    103a:	fb043783          	ld	a5,-80(s0)
    103e:	4bbc                	lw	a5,80(a5)
    1040:	00f71e63          	bne	a4,a5,105c <schedule_edf+0x13e>
                if(th->ID<min_th->ID) min_th = th;
    1044:	fb843783          	ld	a5,-72(s0)
    1048:	5398                	lw	a4,32(a5)
    104a:	fb043783          	ld	a5,-80(s0)
    104e:	539c                	lw	a5,32(a5)
    1050:	00f75663          	bge	a4,a5,105c <schedule_edf+0x13e>
    1054:	fb843783          	ld	a5,-72(s0)
    1058:	faf43823          	sd	a5,-80(s0)
        list_for_each_entry(th, args.run_queue, thread_list) {
    105c:	fb843783          	ld	a5,-72(s0)
    1060:	779c                	ld	a5,40(a5)
    1062:	f4f43c23          	sd	a5,-168(s0)
    1066:	f5843783          	ld	a5,-168(s0)
    106a:	fd878793          	addi	a5,a5,-40
    106e:	faf43c23          	sd	a5,-72(s0)
    1072:	fb843783          	ld	a5,-72(s0)
    1076:	02878713          	addi	a4,a5,40
    107a:	649c                	ld	a5,8(s1)
    107c:	f6f713e3          	bne	a4,a5,fe2 <schedule_edf+0xc4>
            }
        }

        if(min_miss_deadline_th != NULL) {
    1080:	fa843783          	ld	a5,-88(s0)
    1084:	c395                	beqz	a5,10a8 <schedule_edf+0x18a>
            // SPEC 4: exist missed deadline
            // printf("exist missed deadline", th->ID);
            r.allocated_time = 0;
    1086:	f2042823          	sw	zero,-208(s0)
            r.scheduled_thread_list_member = &min_miss_deadline_th->thread_list;
    108a:	fa843783          	ld	a5,-88(s0)
    108e:	02878793          	addi	a5,a5,40
    1092:	f2f43423          	sd	a5,-216(s0)
            return r;
    1096:	f2843783          	ld	a5,-216(s0)
    109a:	f2f43c23          	sd	a5,-200(s0)
    109e:	f3043783          	ld	a5,-208(s0)
    10a2:	f4f43023          	sd	a5,-192(s0)
    10a6:	a401                	j	12a6 <schedule_edf+0x388>
             // compute allocated time: 
            // 1. a preemption can happen in the future.(need to inspect the release queue)
            // 2. current deadline is met (preemption has not happened)
            // 3. current deadline is missed (current_time + remaining_time > current_deadline)
            // compute the first event that will happen.
            r.scheduled_thread_list_member = &min_th->thread_list;
    10a8:	fb043783          	ld	a5,-80(s0)
    10ac:	02878793          	addi	a5,a5,40
    10b0:	f2f43423          	sd	a5,-216(s0)

            struct release_queue_entry* cur;
            if(list_empty(args.release_queue)){
    10b4:	689c                	ld	a5,16(s1)
    10b6:	853e                	mv	a0,a5
    10b8:	00000097          	auipc	ra,0x0
    10bc:	d7c080e7          	jalr	-644(ra) # e34 <list_empty>
    10c0:	87aa                	mv	a5,a0
    10c2:	c3b5                	beqz	a5,1126 <schedule_edf+0x208>
                // printf("release queue is empty\n");
                // a preemption cannot happen, because we've already selected the highest priority thread.
                int remaining_time = 99999;
    10c4:	67e1                	lui	a5,0x18
    10c6:	69f78793          	addi	a5,a5,1695 # 1869f <__global_pointer$+0x1685f>
    10ca:	f6f42623          	sw	a5,-148(s0)

                int deadline_time = min_th->current_deadline - args.current_time;
    10ce:	fb043783          	ld	a5,-80(s0)
    10d2:	4bb8                	lw	a4,80(a5)
    10d4:	409c                	lw	a5,0(s1)
    10d6:	40f707bb          	subw	a5,a4,a5
    10da:	f6f42423          	sw	a5,-152(s0)
                remaining_time = deadline_time<remaining_time? deadline_time: remaining_time;
    10de:	f6842603          	lw	a2,-152(s0)
    10e2:	f6c42783          	lw	a5,-148(s0)
    10e6:	0007869b          	sext.w	a3,a5
    10ea:	0006071b          	sext.w	a4,a2
    10ee:	00d75363          	bge	a4,a3,10f4 <schedule_edf+0x1d6>
    10f2:	87b2                	mv	a5,a2
    10f4:	f6f42623          	sw	a5,-148(s0)
                int met_time = min_th->remaining_time;
    10f8:	fb043783          	ld	a5,-80(s0)
    10fc:	47fc                	lw	a5,76(a5)
    10fe:	f6f42223          	sw	a5,-156(s0)
                remaining_time = met_time<remaining_time? met_time: remaining_time;
    1102:	f6442603          	lw	a2,-156(s0)
    1106:	f6c42783          	lw	a5,-148(s0)
    110a:	0007869b          	sext.w	a3,a5
    110e:	0006071b          	sext.w	a4,a2
    1112:	00d75363          	bge	a4,a3,1118 <schedule_edf+0x1fa>
    1116:	87b2                	mv	a5,a2
    1118:	f6f42623          	sw	a5,-148(s0)
                r.allocated_time = remaining_time;
    111c:	f6c42783          	lw	a5,-148(s0)
    1120:	f2f42823          	sw	a5,-208(s0)
    1124:	aa8d                	j	1296 <schedule_edf+0x378>
            }else{
                // first check if a preemption can happen
                struct release_queue_entry* cur_min = NULL;
    1126:	f8043c23          	sd	zero,-104(s0)
                int remaining_time = 99999;
    112a:	67e1                	lui	a5,0x18
    112c:	69f78793          	addi	a5,a5,1695 # 1869f <__global_pointer$+0x1685f>
    1130:	f8f42a23          	sw	a5,-108(s0)
                list_for_each_entry(cur, args.release_queue, thread_list) {
    1134:	689c                	ld	a5,16(s1)
    1136:	639c                	ld	a5,0(a5)
    1138:	f8f43023          	sd	a5,-128(s0)
    113c:	f8043783          	ld	a5,-128(s0)
    1140:	17e1                	addi	a5,a5,-8
    1142:	faf43023          	sd	a5,-96(s0)
    1146:	a8d9                	j	121c <schedule_edf+0x2fe>
                    if((cur->thrd->period + cur->release_time < min_th->current_deadline) && cur->thrd->n != 0){
    1148:	fa043783          	ld	a5,-96(s0)
    114c:	639c                	ld	a5,0(a5)
    114e:	43f8                	lw	a4,68(a5)
    1150:	fa043783          	ld	a5,-96(s0)
    1154:	4f9c                	lw	a5,24(a5)
    1156:	9fb9                	addw	a5,a5,a4
    1158:	0007871b          	sext.w	a4,a5
    115c:	fb043783          	ld	a5,-80(s0)
    1160:	4bbc                	lw	a5,80(a5)
    1162:	0af75363          	bge	a4,a5,1208 <schedule_edf+0x2ea>
    1166:	fa043783          	ld	a5,-96(s0)
    116a:	639c                	ld	a5,0(a5)
    116c:	47bc                	lw	a5,72(a5)
    116e:	cfc9                	beqz	a5,1208 <schedule_edf+0x2ea>
                        // printf("preemption can occur: %d %d %d\n", cur->thrd->period , cur->release_time , min_th->current_deadline);
                        // a preemption can occur
                        if(cur_min == NULL){
    1170:	f9843783          	ld	a5,-104(s0)
    1174:	e791                	bnez	a5,1180 <schedule_edf+0x262>
                            cur_min = cur;
    1176:	fa043783          	ld	a5,-96(s0)
    117a:	f8f43c23          	sd	a5,-104(s0)
    117e:	a069                	j	1208 <schedule_edf+0x2ea>
                        }else{
                            if((cur->thrd->period + cur->release_time < cur_min->thrd->period + cur_min->release_time)&& cur->thrd->n != 0){
    1180:	fa043783          	ld	a5,-96(s0)
    1184:	639c                	ld	a5,0(a5)
    1186:	43f8                	lw	a4,68(a5)
    1188:	fa043783          	ld	a5,-96(s0)
    118c:	4f9c                	lw	a5,24(a5)
    118e:	9fb9                	addw	a5,a5,a4
    1190:	0007869b          	sext.w	a3,a5
    1194:	f9843783          	ld	a5,-104(s0)
    1198:	639c                	ld	a5,0(a5)
    119a:	43f8                	lw	a4,68(a5)
    119c:	f9843783          	ld	a5,-104(s0)
    11a0:	4f9c                	lw	a5,24(a5)
    11a2:	9fb9                	addw	a5,a5,a4
    11a4:	2781                	sext.w	a5,a5
    11a6:	8736                	mv	a4,a3
    11a8:	00f75c63          	bge	a4,a5,11c0 <schedule_edf+0x2a2>
    11ac:	fa043783          	ld	a5,-96(s0)
    11b0:	639c                	ld	a5,0(a5)
    11b2:	47bc                	lw	a5,72(a5)
    11b4:	c791                	beqz	a5,11c0 <schedule_edf+0x2a2>
                                cur_min = cur;
    11b6:	fa043783          	ld	a5,-96(s0)
    11ba:	f8f43c23          	sd	a5,-104(s0)
    11be:	a0a9                	j	1208 <schedule_edf+0x2ea>
                            }else if(cur->thrd->period + cur->release_time == cur_min->thrd->period + cur_min->release_time){
    11c0:	fa043783          	ld	a5,-96(s0)
    11c4:	639c                	ld	a5,0(a5)
    11c6:	43f8                	lw	a4,68(a5)
    11c8:	fa043783          	ld	a5,-96(s0)
    11cc:	4f9c                	lw	a5,24(a5)
    11ce:	9fb9                	addw	a5,a5,a4
    11d0:	0007869b          	sext.w	a3,a5
    11d4:	f9843783          	ld	a5,-104(s0)
    11d8:	639c                	ld	a5,0(a5)
    11da:	43f8                	lw	a4,68(a5)
    11dc:	f9843783          	ld	a5,-104(s0)
    11e0:	4f9c                	lw	a5,24(a5)
    11e2:	9fb9                	addw	a5,a5,a4
    11e4:	2781                	sext.w	a5,a5
    11e6:	8736                	mv	a4,a3
    11e8:	02f71063          	bne	a4,a5,1208 <schedule_edf+0x2ea>
                                if(cur_min->thrd->ID > cur->thrd->ID){
    11ec:	f9843783          	ld	a5,-104(s0)
    11f0:	639c                	ld	a5,0(a5)
    11f2:	5398                	lw	a4,32(a5)
    11f4:	fa043783          	ld	a5,-96(s0)
    11f8:	639c                	ld	a5,0(a5)
    11fa:	539c                	lw	a5,32(a5)
    11fc:	00e7d663          	bge	a5,a4,1208 <schedule_edf+0x2ea>
                                    cur_min = cur;
    1200:	fa043783          	ld	a5,-96(s0)
    1204:	f8f43c23          	sd	a5,-104(s0)
                list_for_each_entry(cur, args.release_queue, thread_list) {
    1208:	fa043783          	ld	a5,-96(s0)
    120c:	679c                	ld	a5,8(a5)
    120e:	f6f43823          	sd	a5,-144(s0)
    1212:	f7043783          	ld	a5,-144(s0)
    1216:	17e1                	addi	a5,a5,-8
    1218:	faf43023          	sd	a5,-96(s0)
    121c:	fa043783          	ld	a5,-96(s0)
    1220:	00878713          	addi	a4,a5,8
    1224:	689c                	ld	a5,16(s1)
    1226:	f2f711e3          	bne	a4,a5,1148 <schedule_edf+0x22a>
                                }
                            }
                        }
                    }
                }
                if(cur_min != NULL){
    122a:	f9843783          	ld	a5,-104(s0)
    122e:	cb89                	beqz	a5,1240 <schedule_edf+0x322>
                    // a preemption is possible
                    remaining_time = cur_min->release_time - args.current_time;
    1230:	f9843783          	ld	a5,-104(s0)
    1234:	4f98                	lw	a4,24(a5)
    1236:	409c                	lw	a5,0(s1)
    1238:	40f707bb          	subw	a5,a4,a5
    123c:	f8f42a23          	sw	a5,-108(s0)
                }
                int deadline_time = min_th->current_deadline - args.current_time;
    1240:	fb043783          	ld	a5,-80(s0)
    1244:	4bb8                	lw	a4,80(a5)
    1246:	409c                	lw	a5,0(s1)
    1248:	40f707bb          	subw	a5,a4,a5
    124c:	f6f42e23          	sw	a5,-132(s0)
                remaining_time = deadline_time<remaining_time? deadline_time: remaining_time;
    1250:	f7c42603          	lw	a2,-132(s0)
    1254:	f9442783          	lw	a5,-108(s0)
    1258:	0007869b          	sext.w	a3,a5
    125c:	0006071b          	sext.w	a4,a2
    1260:	00d75363          	bge	a4,a3,1266 <schedule_edf+0x348>
    1264:	87b2                	mv	a5,a2
    1266:	f8f42a23          	sw	a5,-108(s0)
                int met_time = min_th->remaining_time;
    126a:	fb043783          	ld	a5,-80(s0)
    126e:	47fc                	lw	a5,76(a5)
    1270:	f6f42c23          	sw	a5,-136(s0)
                remaining_time = met_time<remaining_time? met_time: remaining_time;
    1274:	f7842603          	lw	a2,-136(s0)
    1278:	f9442783          	lw	a5,-108(s0)
    127c:	0007869b          	sext.w	a3,a5
    1280:	0006071b          	sext.w	a4,a2
    1284:	00d75363          	bge	a4,a3,128a <schedule_edf+0x36c>
    1288:	87b2                	mv	a5,a2
    128a:	f8f42a23          	sw	a5,-108(s0)
                r.allocated_time = remaining_time;
    128e:	f9442783          	lw	a5,-108(s0)
    1292:	f2f42823          	sw	a5,-208(s0)
            }

            return r;
    1296:	f2843783          	ld	a5,-216(s0)
    129a:	f2f43c23          	sd	a5,-200(s0)
    129e:	f3043783          	ld	a5,-208(s0)
    12a2:	f4f43023          	sd	a5,-192(s0)
        }
    }

    return schedule_default(args);
}
    12a6:	f3843703          	ld	a4,-200(s0)
    12aa:	f4043783          	ld	a5,-192(s0)
    12ae:	893a                	mv	s2,a4
    12b0:	89be                	mv	s3,a5
    12b2:	874a                	mv	a4,s2
    12b4:	87ce                	mv	a5,s3
    12b6:	853a                	mv	a0,a4
    12b8:	85be                	mv	a1,a5
    12ba:	60ee                	ld	ra,216(sp)
    12bc:	644e                	ld	s0,208(sp)
    12be:	64ae                	ld	s1,200(sp)
    12c0:	690e                	ld	s2,192(sp)
    12c2:	79ea                	ld	s3,184(sp)
    12c4:	612d                	addi	sp,sp,224
    12c6:	8082                	ret

00000000000012c8 <schedule_rm>:

/* Rate-Monotonic Scheduling */
struct threads_sched_result schedule_rm(struct threads_sched_args args)
{
    12c8:	7115                	addi	sp,sp,-224
    12ca:	ed86                	sd	ra,216(sp)
    12cc:	e9a2                	sd	s0,208(sp)
    12ce:	e5a6                	sd	s1,200(sp)
    12d0:	e1ca                	sd	s2,192(sp)
    12d2:	fd4e                	sd	s3,184(sp)
    12d4:	1180                	addi	s0,sp,224
    12d6:	84aa                	mv	s1,a0
    
    struct threads_sched_result r;
    if(list_empty(args.run_queue)){
    12d8:	649c                	ld	a5,8(s1)
    12da:	853e                	mv	a0,a5
    12dc:	00000097          	auipc	ra,0x0
    12e0:	b58080e7          	jalr	-1192(ra) # e34 <list_empty>
    12e4:	87aa                	mv	a5,a0
    12e6:	c3d1                	beqz	a5,136a <schedule_rm+0xa2>
        // SPEC 3
        r.scheduled_thread_list_member = args.run_queue;
    12e8:	649c                	ld	a5,8(s1)
    12ea:	f2f43423          	sd	a5,-216(s0)
        int least_release_time = 99999;
    12ee:	67e1                	lui	a5,0x18
    12f0:	69f78793          	addi	a5,a5,1695 # 1869f <__global_pointer$+0x1685f>
    12f4:	fcf42623          	sw	a5,-52(s0)
        struct release_queue_entry* cur;
        list_for_each_entry(cur, args.release_queue, thread_list) {
    12f8:	689c                	ld	a5,16(s1)
    12fa:	639c                	ld	a5,0(a5)
    12fc:	f4f43823          	sd	a5,-176(s0)
    1300:	f5043783          	ld	a5,-176(s0)
    1304:	17e1                	addi	a5,a5,-8
    1306:	fcf43023          	sd	a5,-64(s0)
    130a:	a805                	j	133a <schedule_rm+0x72>
            if(cur->release_time<least_release_time){
    130c:	fc043783          	ld	a5,-64(s0)
    1310:	4f98                	lw	a4,24(a5)
    1312:	fcc42783          	lw	a5,-52(s0)
    1316:	2781                	sext.w	a5,a5
    1318:	00f75763          	bge	a4,a5,1326 <schedule_rm+0x5e>
                least_release_time = cur->release_time;
    131c:	fc043783          	ld	a5,-64(s0)
    1320:	4f9c                	lw	a5,24(a5)
    1322:	fcf42623          	sw	a5,-52(s0)
        list_for_each_entry(cur, args.release_queue, thread_list) {
    1326:	fc043783          	ld	a5,-64(s0)
    132a:	679c                	ld	a5,8(a5)
    132c:	f4f43423          	sd	a5,-184(s0)
    1330:	f4843783          	ld	a5,-184(s0)
    1334:	17e1                	addi	a5,a5,-8
    1336:	fcf43023          	sd	a5,-64(s0)
    133a:	fc043783          	ld	a5,-64(s0)
    133e:	00878713          	addi	a4,a5,8
    1342:	689c                	ld	a5,16(s1)
    1344:	fcf714e3          	bne	a4,a5,130c <schedule_rm+0x44>
            }
        }
        r.allocated_time = least_release_time - args.current_time ;
    1348:	409c                	lw	a5,0(s1)
    134a:	fcc42703          	lw	a4,-52(s0)
    134e:	40f707bb          	subw	a5,a4,a5
    1352:	2781                	sext.w	a5,a5
    1354:	f2f42823          	sw	a5,-208(s0)
        return r;
    1358:	f2843783          	ld	a5,-216(s0)
    135c:	f2f43c23          	sd	a5,-200(s0)
    1360:	f3043783          	ld	a5,-208(s0)
    1364:	f4f43023          	sd	a5,-192(s0)
    1368:	ac61                	j	1600 <schedule_rm+0x338>
    }else{
        // run queue is not empty.
        struct thread *th = NULL;
    136a:	fa043c23          	sd	zero,-72(s0)
        struct thread *min_th = NULL;
    136e:	fa043823          	sd	zero,-80(s0)
        struct thread *min_miss_deadline_th = NULL;
    1372:	fa043423          	sd	zero,-88(s0)
        list_for_each_entry(th, args.run_queue, thread_list) {
    1376:	649c                	ld	a5,8(s1)
    1378:	639c                	ld	a5,0(a5)
    137a:	f8f43423          	sd	a5,-120(s0)
    137e:	f8843783          	ld	a5,-120(s0)
    1382:	fd878793          	addi	a5,a5,-40
    1386:	faf43c23          	sd	a5,-72(s0)
    138a:	a849                	j	141c <schedule_rm+0x154>
            if(th->current_deadline <= args.current_time){
    138c:	fb843783          	ld	a5,-72(s0)
    1390:	4bb8                	lw	a4,80(a5)
    1392:	409c                	lw	a5,0(s1)
    1394:	02e7c163          	blt	a5,a4,13b6 <schedule_rm+0xee>
                if(min_miss_deadline_th == NULL || th->ID<min_miss_deadline_th->ID){
    1398:	fa843783          	ld	a5,-88(s0)
    139c:	cb89                	beqz	a5,13ae <schedule_rm+0xe6>
    139e:	fb843783          	ld	a5,-72(s0)
    13a2:	5398                	lw	a4,32(a5)
    13a4:	fa843783          	ld	a5,-88(s0)
    13a8:	539c                	lw	a5,32(a5)
    13aa:	00f75663          	bge	a4,a5,13b6 <schedule_rm+0xee>
                    min_miss_deadline_th = th;
    13ae:	fb843783          	ld	a5,-72(s0)
    13b2:	faf43423          	sd	a5,-88(s0)
                }
            }
            if(min_th == NULL) min_th = th;
    13b6:	fb043783          	ld	a5,-80(s0)
    13ba:	e789                	bnez	a5,13c4 <schedule_rm+0xfc>
    13bc:	fb843783          	ld	a5,-72(s0)
    13c0:	faf43823          	sd	a5,-80(s0)
            if(th->period<min_th->period){
    13c4:	fb843783          	ld	a5,-72(s0)
    13c8:	43f8                	lw	a4,68(a5)
    13ca:	fb043783          	ld	a5,-80(s0)
    13ce:	43fc                	lw	a5,68(a5)
    13d0:	00f75763          	bge	a4,a5,13de <schedule_rm+0x116>
                min_th = th;
    13d4:	fb843783          	ld	a5,-72(s0)
    13d8:	faf43823          	sd	a5,-80(s0)
    13dc:	a02d                	j	1406 <schedule_rm+0x13e>
            }else if(th->period == min_th->period){
    13de:	fb843783          	ld	a5,-72(s0)
    13e2:	43f8                	lw	a4,68(a5)
    13e4:	fb043783          	ld	a5,-80(s0)
    13e8:	43fc                	lw	a5,68(a5)
    13ea:	00f71e63          	bne	a4,a5,1406 <schedule_rm+0x13e>
                if(th->ID<min_th->ID) min_th = th;
    13ee:	fb843783          	ld	a5,-72(s0)
    13f2:	5398                	lw	a4,32(a5)
    13f4:	fb043783          	ld	a5,-80(s0)
    13f8:	539c                	lw	a5,32(a5)
    13fa:	00f75663          	bge	a4,a5,1406 <schedule_rm+0x13e>
    13fe:	fb843783          	ld	a5,-72(s0)
    1402:	faf43823          	sd	a5,-80(s0)
        list_for_each_entry(th, args.run_queue, thread_list) {
    1406:	fb843783          	ld	a5,-72(s0)
    140a:	779c                	ld	a5,40(a5)
    140c:	f4f43c23          	sd	a5,-168(s0)
    1410:	f5843783          	ld	a5,-168(s0)
    1414:	fd878793          	addi	a5,a5,-40
    1418:	faf43c23          	sd	a5,-72(s0)
    141c:	fb843783          	ld	a5,-72(s0)
    1420:	02878713          	addi	a4,a5,40
    1424:	649c                	ld	a5,8(s1)
    1426:	f6f713e3          	bne	a4,a5,138c <schedule_rm+0xc4>
            }
        }

        if(min_miss_deadline_th != NULL) {
    142a:	fa843783          	ld	a5,-88(s0)
    142e:	c395                	beqz	a5,1452 <schedule_rm+0x18a>
            // SPEC 4: exist missed deadline
            r.allocated_time = 0;
    1430:	f2042823          	sw	zero,-208(s0)
            r.scheduled_thread_list_member = &min_miss_deadline_th->thread_list;
    1434:	fa843783          	ld	a5,-88(s0)
    1438:	02878793          	addi	a5,a5,40
    143c:	f2f43423          	sd	a5,-216(s0)
            return r;
    1440:	f2843783          	ld	a5,-216(s0)
    1444:	f2f43c23          	sd	a5,-200(s0)
    1448:	f3043783          	ld	a5,-208(s0)
    144c:	f4f43023          	sd	a5,-192(s0)
    1450:	aa45                	j	1600 <schedule_rm+0x338>
             // compute allocated time: 
            // 1. a preemption can happen in the future.(need to inspect the release queue)
            // 2. current deadline is met (preemption has not happened)
            // 3. current deadline is missed (current_time + remaining_time > current_deadline)
            // compute the first event that will happen.
            r.scheduled_thread_list_member = &min_th->thread_list;
    1452:	fb043783          	ld	a5,-80(s0)
    1456:	02878793          	addi	a5,a5,40
    145a:	f2f43423          	sd	a5,-216(s0)

            struct release_queue_entry* cur;
            if(list_empty(args.release_queue)){
    145e:	689c                	ld	a5,16(s1)
    1460:	853e                	mv	a0,a5
    1462:	00000097          	auipc	ra,0x0
    1466:	9d2080e7          	jalr	-1582(ra) # e34 <list_empty>
    146a:	87aa                	mv	a5,a0
    146c:	c3b5                	beqz	a5,14d0 <schedule_rm+0x208>
                // a preemption cannot happen, because we've already selected the highest priority thread.
                int remaining_time = 99999;
    146e:	67e1                	lui	a5,0x18
    1470:	69f78793          	addi	a5,a5,1695 # 1869f <__global_pointer$+0x1685f>
    1474:	f6f42623          	sw	a5,-148(s0)

                int deadline_time = min_th->current_deadline - args.current_time;
    1478:	fb043783          	ld	a5,-80(s0)
    147c:	4bb8                	lw	a4,80(a5)
    147e:	409c                	lw	a5,0(s1)
    1480:	40f707bb          	subw	a5,a4,a5
    1484:	f6f42423          	sw	a5,-152(s0)
                remaining_time = deadline_time<remaining_time? deadline_time: remaining_time;
    1488:	f6842603          	lw	a2,-152(s0)
    148c:	f6c42783          	lw	a5,-148(s0)
    1490:	0007869b          	sext.w	a3,a5
    1494:	0006071b          	sext.w	a4,a2
    1498:	00d75363          	bge	a4,a3,149e <schedule_rm+0x1d6>
    149c:	87b2                	mv	a5,a2
    149e:	f6f42623          	sw	a5,-148(s0)
                int met_time = min_th->remaining_time;
    14a2:	fb043783          	ld	a5,-80(s0)
    14a6:	47fc                	lw	a5,76(a5)
    14a8:	f6f42223          	sw	a5,-156(s0)
                remaining_time = met_time<remaining_time? met_time: remaining_time;
    14ac:	f6442603          	lw	a2,-156(s0)
    14b0:	f6c42783          	lw	a5,-148(s0)
    14b4:	0007869b          	sext.w	a3,a5
    14b8:	0006071b          	sext.w	a4,a2
    14bc:	00d75363          	bge	a4,a3,14c2 <schedule_rm+0x1fa>
    14c0:	87b2                	mv	a5,a2
    14c2:	f6f42623          	sw	a5,-148(s0)
                
                r.allocated_time = remaining_time;
    14c6:	f6c42783          	lw	a5,-148(s0)
    14ca:	f2f42823          	sw	a5,-208(s0)
    14ce:	a20d                	j	15f0 <schedule_rm+0x328>
            }else{
                // first check if a preemption can happen
                struct release_queue_entry* cur_min = NULL;
    14d0:	f8043c23          	sd	zero,-104(s0)
                int remaining_time = 99999;
    14d4:	67e1                	lui	a5,0x18
    14d6:	69f78793          	addi	a5,a5,1695 # 1869f <__global_pointer$+0x1685f>
    14da:	f8f42a23          	sw	a5,-108(s0)
                list_for_each_entry(cur, args.release_queue, thread_list) {
    14de:	689c                	ld	a5,16(s1)
    14e0:	639c                	ld	a5,0(a5)
    14e2:	f8f43023          	sd	a5,-128(s0)
    14e6:	f8043783          	ld	a5,-128(s0)
    14ea:	17e1                	addi	a5,a5,-8
    14ec:	faf43023          	sd	a5,-96(s0)
    14f0:	a059                	j	1576 <schedule_rm+0x2ae>
                    if(cur->thrd->period<min_th->period){
    14f2:	fa043783          	ld	a5,-96(s0)
    14f6:	639c                	ld	a5,0(a5)
    14f8:	43f8                	lw	a4,68(a5)
    14fa:	fb043783          	ld	a5,-80(s0)
    14fe:	43fc                	lw	a5,68(a5)
    1500:	06f75163          	bge	a4,a5,1562 <schedule_rm+0x29a>
                        // a preemption can occur
                        if(cur_min == NULL){
    1504:	f9843783          	ld	a5,-104(s0)
    1508:	e791                	bnez	a5,1514 <schedule_rm+0x24c>
                            cur_min = cur;
    150a:	fa043783          	ld	a5,-96(s0)
    150e:	f8f43c23          	sd	a5,-104(s0)
    1512:	a881                	j	1562 <schedule_rm+0x29a>
                        }else{
                            if(cur_min->thrd->period>cur->thrd->period){
    1514:	f9843783          	ld	a5,-104(s0)
    1518:	639c                	ld	a5,0(a5)
    151a:	43f8                	lw	a4,68(a5)
    151c:	fa043783          	ld	a5,-96(s0)
    1520:	639c                	ld	a5,0(a5)
    1522:	43fc                	lw	a5,68(a5)
    1524:	00e7d763          	bge	a5,a4,1532 <schedule_rm+0x26a>
                                cur_min = cur;
    1528:	fa043783          	ld	a5,-96(s0)
    152c:	f8f43c23          	sd	a5,-104(s0)
    1530:	a80d                	j	1562 <schedule_rm+0x29a>
                            }else if(cur_min->thrd->period == cur->thrd->period){
    1532:	f9843783          	ld	a5,-104(s0)
    1536:	639c                	ld	a5,0(a5)
    1538:	43f8                	lw	a4,68(a5)
    153a:	fa043783          	ld	a5,-96(s0)
    153e:	639c                	ld	a5,0(a5)
    1540:	43fc                	lw	a5,68(a5)
    1542:	02f71063          	bne	a4,a5,1562 <schedule_rm+0x29a>
                                if(cur_min->thrd->ID > cur->thrd->ID){
    1546:	f9843783          	ld	a5,-104(s0)
    154a:	639c                	ld	a5,0(a5)
    154c:	5398                	lw	a4,32(a5)
    154e:	fa043783          	ld	a5,-96(s0)
    1552:	639c                	ld	a5,0(a5)
    1554:	539c                	lw	a5,32(a5)
    1556:	00e7d663          	bge	a5,a4,1562 <schedule_rm+0x29a>
                                    cur_min = cur;
    155a:	fa043783          	ld	a5,-96(s0)
    155e:	f8f43c23          	sd	a5,-104(s0)
                list_for_each_entry(cur, args.release_queue, thread_list) {
    1562:	fa043783          	ld	a5,-96(s0)
    1566:	679c                	ld	a5,8(a5)
    1568:	f6f43823          	sd	a5,-144(s0)
    156c:	f7043783          	ld	a5,-144(s0)
    1570:	17e1                	addi	a5,a5,-8
    1572:	faf43023          	sd	a5,-96(s0)
    1576:	fa043783          	ld	a5,-96(s0)
    157a:	00878713          	addi	a4,a5,8
    157e:	689c                	ld	a5,16(s1)
    1580:	f6f719e3          	bne	a4,a5,14f2 <schedule_rm+0x22a>
                                }
                            }
                        }
                    }
                }
                if(cur_min != NULL){
    1584:	f9843783          	ld	a5,-104(s0)
    1588:	cb89                	beqz	a5,159a <schedule_rm+0x2d2>
                    // a preemption is possible
                    remaining_time = cur_min->release_time - args.current_time;
    158a:	f9843783          	ld	a5,-104(s0)
    158e:	4f98                	lw	a4,24(a5)
    1590:	409c                	lw	a5,0(s1)
    1592:	40f707bb          	subw	a5,a4,a5
    1596:	f8f42a23          	sw	a5,-108(s0)
                }
                int deadline_time = min_th->current_deadline - args.current_time;
    159a:	fb043783          	ld	a5,-80(s0)
    159e:	4bb8                	lw	a4,80(a5)
    15a0:	409c                	lw	a5,0(s1)
    15a2:	40f707bb          	subw	a5,a4,a5
    15a6:	f6f42e23          	sw	a5,-132(s0)
                remaining_time = deadline_time<remaining_time? deadline_time: remaining_time;
    15aa:	f7c42603          	lw	a2,-132(s0)
    15ae:	f9442783          	lw	a5,-108(s0)
    15b2:	0007869b          	sext.w	a3,a5
    15b6:	0006071b          	sext.w	a4,a2
    15ba:	00d75363          	bge	a4,a3,15c0 <schedule_rm+0x2f8>
    15be:	87b2                	mv	a5,a2
    15c0:	f8f42a23          	sw	a5,-108(s0)
                int met_time = min_th->remaining_time;
    15c4:	fb043783          	ld	a5,-80(s0)
    15c8:	47fc                	lw	a5,76(a5)
    15ca:	f6f42c23          	sw	a5,-136(s0)
                remaining_time = met_time<remaining_time? met_time: remaining_time;
    15ce:	f7842603          	lw	a2,-136(s0)
    15d2:	f9442783          	lw	a5,-108(s0)
    15d6:	0007869b          	sext.w	a3,a5
    15da:	0006071b          	sext.w	a4,a2
    15de:	00d75363          	bge	a4,a3,15e4 <schedule_rm+0x31c>
    15e2:	87b2                	mv	a5,a2
    15e4:	f8f42a23          	sw	a5,-108(s0)
                
                r.allocated_time = remaining_time;
    15e8:	f9442783          	lw	a5,-108(s0)
    15ec:	f2f42823          	sw	a5,-208(s0)
            }

            return r;
    15f0:	f2843783          	ld	a5,-216(s0)
    15f4:	f2f43c23          	sd	a5,-200(s0)
    15f8:	f3043783          	ld	a5,-208(s0)
    15fc:	f4f43023          	sd	a5,-192(s0)
        }
    }
}
    1600:	f3843703          	ld	a4,-200(s0)
    1604:	f4043783          	ld	a5,-192(s0)
    1608:	893a                	mv	s2,a4
    160a:	89be                	mv	s3,a5
    160c:	874a                	mv	a4,s2
    160e:	87ce                	mv	a5,s3
    1610:	853a                	mv	a0,a4
    1612:	85be                	mv	a1,a5
    1614:	60ee                	ld	ra,216(sp)
    1616:	644e                	ld	s0,208(sp)
    1618:	64ae                	ld	s1,200(sp)
    161a:	690e                	ld	s2,192(sp)
    161c:	79ea                	ld	s3,184(sp)
    161e:	612d                	addi	sp,sp,224
    1620:	8082                	ret
