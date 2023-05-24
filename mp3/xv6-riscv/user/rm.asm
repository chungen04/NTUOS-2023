
user/_rm:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
       0:	7179                	addi	sp,sp,-48
       2:	f406                	sd	ra,40(sp)
       4:	f022                	sd	s0,32(sp)
       6:	1800                	addi	s0,sp,48
       8:	87aa                	mv	a5,a0
       a:	fcb43823          	sd	a1,-48(s0)
       e:	fcf42e23          	sw	a5,-36(s0)
  int i;

  if(argc < 2){
      12:	fdc42783          	lw	a5,-36(s0)
      16:	0007871b          	sext.w	a4,a5
      1a:	4785                	li	a5,1
      1c:	02e7c063          	blt	a5,a4,3c <main+0x3c>
    fprintf(2, "Usage: rm files...\n");
      20:	00001597          	auipc	a1,0x1
      24:	5f858593          	addi	a1,a1,1528 # 1618 <schedule_rm+0x35e>
      28:	4509                	li	a0,2
      2a:	00001097          	auipc	ra,0x1
      2e:	9fe080e7          	jalr	-1538(ra) # a28 <fprintf>
    exit(1);
      32:	4505                	li	a0,1
      34:	00000097          	auipc	ra,0x0
      38:	506080e7          	jalr	1286(ra) # 53a <exit>
  }

  for(i = 1; i < argc; i++){
      3c:	4785                	li	a5,1
      3e:	fef42623          	sw	a5,-20(s0)
      42:	a0b9                	j	90 <main+0x90>
    if(unlink(argv[i]) < 0){
      44:	fec42783          	lw	a5,-20(s0)
      48:	078e                	slli	a5,a5,0x3
      4a:	fd043703          	ld	a4,-48(s0)
      4e:	97ba                	add	a5,a5,a4
      50:	639c                	ld	a5,0(a5)
      52:	853e                	mv	a0,a5
      54:	00000097          	auipc	ra,0x0
      58:	536080e7          	jalr	1334(ra) # 58a <unlink>
      5c:	87aa                	mv	a5,a0
      5e:	0207d463          	bgez	a5,86 <main+0x86>
      fprintf(2, "rm: %s failed to delete\n", argv[i]);
      62:	fec42783          	lw	a5,-20(s0)
      66:	078e                	slli	a5,a5,0x3
      68:	fd043703          	ld	a4,-48(s0)
      6c:	97ba                	add	a5,a5,a4
      6e:	639c                	ld	a5,0(a5)
      70:	863e                	mv	a2,a5
      72:	00001597          	auipc	a1,0x1
      76:	5be58593          	addi	a1,a1,1470 # 1630 <schedule_rm+0x376>
      7a:	4509                	li	a0,2
      7c:	00001097          	auipc	ra,0x1
      80:	9ac080e7          	jalr	-1620(ra) # a28 <fprintf>
      break;
      84:	a831                	j	a0 <main+0xa0>
  for(i = 1; i < argc; i++){
      86:	fec42783          	lw	a5,-20(s0)
      8a:	2785                	addiw	a5,a5,1
      8c:	fef42623          	sw	a5,-20(s0)
      90:	fec42703          	lw	a4,-20(s0)
      94:	fdc42783          	lw	a5,-36(s0)
      98:	2701                	sext.w	a4,a4
      9a:	2781                	sext.w	a5,a5
      9c:	faf744e3          	blt	a4,a5,44 <main+0x44>
    }
  }

  exit(0);
      a0:	4501                	li	a0,0
      a2:	00000097          	auipc	ra,0x0
      a6:	498080e7          	jalr	1176(ra) # 53a <exit>

00000000000000aa <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
      aa:	7179                	addi	sp,sp,-48
      ac:	f422                	sd	s0,40(sp)
      ae:	1800                	addi	s0,sp,48
      b0:	fca43c23          	sd	a0,-40(s0)
      b4:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
      b8:	fd843783          	ld	a5,-40(s0)
      bc:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
      c0:	0001                	nop
      c2:	fd043703          	ld	a4,-48(s0)
      c6:	00170793          	addi	a5,a4,1
      ca:	fcf43823          	sd	a5,-48(s0)
      ce:	fd843783          	ld	a5,-40(s0)
      d2:	00178693          	addi	a3,a5,1
      d6:	fcd43c23          	sd	a3,-40(s0)
      da:	00074703          	lbu	a4,0(a4)
      de:	00e78023          	sb	a4,0(a5)
      e2:	0007c783          	lbu	a5,0(a5)
      e6:	fff1                	bnez	a5,c2 <strcpy+0x18>
    ;
  return os;
      e8:	fe843783          	ld	a5,-24(s0)
}
      ec:	853e                	mv	a0,a5
      ee:	7422                	ld	s0,40(sp)
      f0:	6145                	addi	sp,sp,48
      f2:	8082                	ret

00000000000000f4 <strcmp>:

int
strcmp(const char *p, const char *q)
{
      f4:	1101                	addi	sp,sp,-32
      f6:	ec22                	sd	s0,24(sp)
      f8:	1000                	addi	s0,sp,32
      fa:	fea43423          	sd	a0,-24(s0)
      fe:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
     102:	a819                	j	118 <strcmp+0x24>
    p++, q++;
     104:	fe843783          	ld	a5,-24(s0)
     108:	0785                	addi	a5,a5,1
     10a:	fef43423          	sd	a5,-24(s0)
     10e:	fe043783          	ld	a5,-32(s0)
     112:	0785                	addi	a5,a5,1
     114:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
     118:	fe843783          	ld	a5,-24(s0)
     11c:	0007c783          	lbu	a5,0(a5)
     120:	cb99                	beqz	a5,136 <strcmp+0x42>
     122:	fe843783          	ld	a5,-24(s0)
     126:	0007c703          	lbu	a4,0(a5)
     12a:	fe043783          	ld	a5,-32(s0)
     12e:	0007c783          	lbu	a5,0(a5)
     132:	fcf709e3          	beq	a4,a5,104 <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
     136:	fe843783          	ld	a5,-24(s0)
     13a:	0007c783          	lbu	a5,0(a5)
     13e:	0007871b          	sext.w	a4,a5
     142:	fe043783          	ld	a5,-32(s0)
     146:	0007c783          	lbu	a5,0(a5)
     14a:	2781                	sext.w	a5,a5
     14c:	40f707bb          	subw	a5,a4,a5
     150:	2781                	sext.w	a5,a5
}
     152:	853e                	mv	a0,a5
     154:	6462                	ld	s0,24(sp)
     156:	6105                	addi	sp,sp,32
     158:	8082                	ret

000000000000015a <strlen>:

uint
strlen(const char *s)
{
     15a:	7179                	addi	sp,sp,-48
     15c:	f422                	sd	s0,40(sp)
     15e:	1800                	addi	s0,sp,48
     160:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
     164:	fe042623          	sw	zero,-20(s0)
     168:	a031                	j	174 <strlen+0x1a>
     16a:	fec42783          	lw	a5,-20(s0)
     16e:	2785                	addiw	a5,a5,1
     170:	fef42623          	sw	a5,-20(s0)
     174:	fec42783          	lw	a5,-20(s0)
     178:	fd843703          	ld	a4,-40(s0)
     17c:	97ba                	add	a5,a5,a4
     17e:	0007c783          	lbu	a5,0(a5)
     182:	f7e5                	bnez	a5,16a <strlen+0x10>
    ;
  return n;
     184:	fec42783          	lw	a5,-20(s0)
}
     188:	853e                	mv	a0,a5
     18a:	7422                	ld	s0,40(sp)
     18c:	6145                	addi	sp,sp,48
     18e:	8082                	ret

0000000000000190 <memset>:

void*
memset(void *dst, int c, uint n)
{
     190:	7179                	addi	sp,sp,-48
     192:	f422                	sd	s0,40(sp)
     194:	1800                	addi	s0,sp,48
     196:	fca43c23          	sd	a0,-40(s0)
     19a:	87ae                	mv	a5,a1
     19c:	8732                	mv	a4,a2
     19e:	fcf42a23          	sw	a5,-44(s0)
     1a2:	87ba                	mv	a5,a4
     1a4:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
     1a8:	fd843783          	ld	a5,-40(s0)
     1ac:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
     1b0:	fe042623          	sw	zero,-20(s0)
     1b4:	a00d                	j	1d6 <memset+0x46>
    cdst[i] = c;
     1b6:	fec42783          	lw	a5,-20(s0)
     1ba:	fe043703          	ld	a4,-32(s0)
     1be:	97ba                	add	a5,a5,a4
     1c0:	fd442703          	lw	a4,-44(s0)
     1c4:	0ff77713          	andi	a4,a4,255
     1c8:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
     1cc:	fec42783          	lw	a5,-20(s0)
     1d0:	2785                	addiw	a5,a5,1
     1d2:	fef42623          	sw	a5,-20(s0)
     1d6:	fec42703          	lw	a4,-20(s0)
     1da:	fd042783          	lw	a5,-48(s0)
     1de:	2781                	sext.w	a5,a5
     1e0:	fcf76be3          	bltu	a4,a5,1b6 <memset+0x26>
  }
  return dst;
     1e4:	fd843783          	ld	a5,-40(s0)
}
     1e8:	853e                	mv	a0,a5
     1ea:	7422                	ld	s0,40(sp)
     1ec:	6145                	addi	sp,sp,48
     1ee:	8082                	ret

00000000000001f0 <strchr>:

char*
strchr(const char *s, char c)
{
     1f0:	1101                	addi	sp,sp,-32
     1f2:	ec22                	sd	s0,24(sp)
     1f4:	1000                	addi	s0,sp,32
     1f6:	fea43423          	sd	a0,-24(s0)
     1fa:	87ae                	mv	a5,a1
     1fc:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
     200:	a01d                	j	226 <strchr+0x36>
    if(*s == c)
     202:	fe843783          	ld	a5,-24(s0)
     206:	0007c703          	lbu	a4,0(a5)
     20a:	fe744783          	lbu	a5,-25(s0)
     20e:	0ff7f793          	andi	a5,a5,255
     212:	00e79563          	bne	a5,a4,21c <strchr+0x2c>
      return (char*)s;
     216:	fe843783          	ld	a5,-24(s0)
     21a:	a821                	j	232 <strchr+0x42>
  for(; *s; s++)
     21c:	fe843783          	ld	a5,-24(s0)
     220:	0785                	addi	a5,a5,1
     222:	fef43423          	sd	a5,-24(s0)
     226:	fe843783          	ld	a5,-24(s0)
     22a:	0007c783          	lbu	a5,0(a5)
     22e:	fbf1                	bnez	a5,202 <strchr+0x12>
  return 0;
     230:	4781                	li	a5,0
}
     232:	853e                	mv	a0,a5
     234:	6462                	ld	s0,24(sp)
     236:	6105                	addi	sp,sp,32
     238:	8082                	ret

000000000000023a <gets>:

char*
gets(char *buf, int max)
{
     23a:	7179                	addi	sp,sp,-48
     23c:	f406                	sd	ra,40(sp)
     23e:	f022                	sd	s0,32(sp)
     240:	1800                	addi	s0,sp,48
     242:	fca43c23          	sd	a0,-40(s0)
     246:	87ae                	mv	a5,a1
     248:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     24c:	fe042623          	sw	zero,-20(s0)
     250:	a8a1                	j	2a8 <gets+0x6e>
    cc = read(0, &c, 1);
     252:	fe740793          	addi	a5,s0,-25
     256:	4605                	li	a2,1
     258:	85be                	mv	a1,a5
     25a:	4501                	li	a0,0
     25c:	00000097          	auipc	ra,0x0
     260:	2f6080e7          	jalr	758(ra) # 552 <read>
     264:	87aa                	mv	a5,a0
     266:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
     26a:	fe842783          	lw	a5,-24(s0)
     26e:	2781                	sext.w	a5,a5
     270:	04f05763          	blez	a5,2be <gets+0x84>
      break;
    buf[i++] = c;
     274:	fec42783          	lw	a5,-20(s0)
     278:	0017871b          	addiw	a4,a5,1
     27c:	fee42623          	sw	a4,-20(s0)
     280:	873e                	mv	a4,a5
     282:	fd843783          	ld	a5,-40(s0)
     286:	97ba                	add	a5,a5,a4
     288:	fe744703          	lbu	a4,-25(s0)
     28c:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
     290:	fe744783          	lbu	a5,-25(s0)
     294:	873e                	mv	a4,a5
     296:	47a9                	li	a5,10
     298:	02f70463          	beq	a4,a5,2c0 <gets+0x86>
     29c:	fe744783          	lbu	a5,-25(s0)
     2a0:	873e                	mv	a4,a5
     2a2:	47b5                	li	a5,13
     2a4:	00f70e63          	beq	a4,a5,2c0 <gets+0x86>
  for(i=0; i+1 < max; ){
     2a8:	fec42783          	lw	a5,-20(s0)
     2ac:	2785                	addiw	a5,a5,1
     2ae:	0007871b          	sext.w	a4,a5
     2b2:	fd442783          	lw	a5,-44(s0)
     2b6:	2781                	sext.w	a5,a5
     2b8:	f8f74de3          	blt	a4,a5,252 <gets+0x18>
     2bc:	a011                	j	2c0 <gets+0x86>
      break;
     2be:	0001                	nop
      break;
  }
  buf[i] = '\0';
     2c0:	fec42783          	lw	a5,-20(s0)
     2c4:	fd843703          	ld	a4,-40(s0)
     2c8:	97ba                	add	a5,a5,a4
     2ca:	00078023          	sb	zero,0(a5)
  return buf;
     2ce:	fd843783          	ld	a5,-40(s0)
}
     2d2:	853e                	mv	a0,a5
     2d4:	70a2                	ld	ra,40(sp)
     2d6:	7402                	ld	s0,32(sp)
     2d8:	6145                	addi	sp,sp,48
     2da:	8082                	ret

00000000000002dc <stat>:

int
stat(const char *n, struct stat *st)
{
     2dc:	7179                	addi	sp,sp,-48
     2de:	f406                	sd	ra,40(sp)
     2e0:	f022                	sd	s0,32(sp)
     2e2:	1800                	addi	s0,sp,48
     2e4:	fca43c23          	sd	a0,-40(s0)
     2e8:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     2ec:	4581                	li	a1,0
     2ee:	fd843503          	ld	a0,-40(s0)
     2f2:	00000097          	auipc	ra,0x0
     2f6:	288080e7          	jalr	648(ra) # 57a <open>
     2fa:	87aa                	mv	a5,a0
     2fc:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
     300:	fec42783          	lw	a5,-20(s0)
     304:	2781                	sext.w	a5,a5
     306:	0007d463          	bgez	a5,30e <stat+0x32>
    return -1;
     30a:	57fd                	li	a5,-1
     30c:	a035                	j	338 <stat+0x5c>
  r = fstat(fd, st);
     30e:	fec42783          	lw	a5,-20(s0)
     312:	fd043583          	ld	a1,-48(s0)
     316:	853e                	mv	a0,a5
     318:	00000097          	auipc	ra,0x0
     31c:	27a080e7          	jalr	634(ra) # 592 <fstat>
     320:	87aa                	mv	a5,a0
     322:	fef42423          	sw	a5,-24(s0)
  close(fd);
     326:	fec42783          	lw	a5,-20(s0)
     32a:	853e                	mv	a0,a5
     32c:	00000097          	auipc	ra,0x0
     330:	236080e7          	jalr	566(ra) # 562 <close>
  return r;
     334:	fe842783          	lw	a5,-24(s0)
}
     338:	853e                	mv	a0,a5
     33a:	70a2                	ld	ra,40(sp)
     33c:	7402                	ld	s0,32(sp)
     33e:	6145                	addi	sp,sp,48
     340:	8082                	ret

0000000000000342 <atoi>:

int
atoi(const char *s)
{
     342:	7179                	addi	sp,sp,-48
     344:	f422                	sd	s0,40(sp)
     346:	1800                	addi	s0,sp,48
     348:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
     34c:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
     350:	a815                	j	384 <atoi+0x42>
    n = n*10 + *s++ - '0';
     352:	fec42703          	lw	a4,-20(s0)
     356:	87ba                	mv	a5,a4
     358:	0027979b          	slliw	a5,a5,0x2
     35c:	9fb9                	addw	a5,a5,a4
     35e:	0017979b          	slliw	a5,a5,0x1
     362:	0007871b          	sext.w	a4,a5
     366:	fd843783          	ld	a5,-40(s0)
     36a:	00178693          	addi	a3,a5,1
     36e:	fcd43c23          	sd	a3,-40(s0)
     372:	0007c783          	lbu	a5,0(a5)
     376:	2781                	sext.w	a5,a5
     378:	9fb9                	addw	a5,a5,a4
     37a:	2781                	sext.w	a5,a5
     37c:	fd07879b          	addiw	a5,a5,-48
     380:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
     384:	fd843783          	ld	a5,-40(s0)
     388:	0007c783          	lbu	a5,0(a5)
     38c:	873e                	mv	a4,a5
     38e:	02f00793          	li	a5,47
     392:	00e7fb63          	bgeu	a5,a4,3a8 <atoi+0x66>
     396:	fd843783          	ld	a5,-40(s0)
     39a:	0007c783          	lbu	a5,0(a5)
     39e:	873e                	mv	a4,a5
     3a0:	03900793          	li	a5,57
     3a4:	fae7f7e3          	bgeu	a5,a4,352 <atoi+0x10>
  return n;
     3a8:	fec42783          	lw	a5,-20(s0)
}
     3ac:	853e                	mv	a0,a5
     3ae:	7422                	ld	s0,40(sp)
     3b0:	6145                	addi	sp,sp,48
     3b2:	8082                	ret

00000000000003b4 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     3b4:	7139                	addi	sp,sp,-64
     3b6:	fc22                	sd	s0,56(sp)
     3b8:	0080                	addi	s0,sp,64
     3ba:	fca43c23          	sd	a0,-40(s0)
     3be:	fcb43823          	sd	a1,-48(s0)
     3c2:	87b2                	mv	a5,a2
     3c4:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
     3c8:	fd843783          	ld	a5,-40(s0)
     3cc:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
     3d0:	fd043783          	ld	a5,-48(s0)
     3d4:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
     3d8:	fe043703          	ld	a4,-32(s0)
     3dc:	fe843783          	ld	a5,-24(s0)
     3e0:	02e7fc63          	bgeu	a5,a4,418 <memmove+0x64>
    while(n-- > 0)
     3e4:	a00d                	j	406 <memmove+0x52>
      *dst++ = *src++;
     3e6:	fe043703          	ld	a4,-32(s0)
     3ea:	00170793          	addi	a5,a4,1
     3ee:	fef43023          	sd	a5,-32(s0)
     3f2:	fe843783          	ld	a5,-24(s0)
     3f6:	00178693          	addi	a3,a5,1
     3fa:	fed43423          	sd	a3,-24(s0)
     3fe:	00074703          	lbu	a4,0(a4)
     402:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     406:	fcc42783          	lw	a5,-52(s0)
     40a:	fff7871b          	addiw	a4,a5,-1
     40e:	fce42623          	sw	a4,-52(s0)
     412:	fcf04ae3          	bgtz	a5,3e6 <memmove+0x32>
     416:	a891                	j	46a <memmove+0xb6>
  } else {
    dst += n;
     418:	fcc42783          	lw	a5,-52(s0)
     41c:	fe843703          	ld	a4,-24(s0)
     420:	97ba                	add	a5,a5,a4
     422:	fef43423          	sd	a5,-24(s0)
    src += n;
     426:	fcc42783          	lw	a5,-52(s0)
     42a:	fe043703          	ld	a4,-32(s0)
     42e:	97ba                	add	a5,a5,a4
     430:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
     434:	a01d                	j	45a <memmove+0xa6>
      *--dst = *--src;
     436:	fe043783          	ld	a5,-32(s0)
     43a:	17fd                	addi	a5,a5,-1
     43c:	fef43023          	sd	a5,-32(s0)
     440:	fe843783          	ld	a5,-24(s0)
     444:	17fd                	addi	a5,a5,-1
     446:	fef43423          	sd	a5,-24(s0)
     44a:	fe043783          	ld	a5,-32(s0)
     44e:	0007c703          	lbu	a4,0(a5)
     452:	fe843783          	ld	a5,-24(s0)
     456:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     45a:	fcc42783          	lw	a5,-52(s0)
     45e:	fff7871b          	addiw	a4,a5,-1
     462:	fce42623          	sw	a4,-52(s0)
     466:	fcf048e3          	bgtz	a5,436 <memmove+0x82>
  }
  return vdst;
     46a:	fd843783          	ld	a5,-40(s0)
}
     46e:	853e                	mv	a0,a5
     470:	7462                	ld	s0,56(sp)
     472:	6121                	addi	sp,sp,64
     474:	8082                	ret

0000000000000476 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     476:	7139                	addi	sp,sp,-64
     478:	fc22                	sd	s0,56(sp)
     47a:	0080                	addi	s0,sp,64
     47c:	fca43c23          	sd	a0,-40(s0)
     480:	fcb43823          	sd	a1,-48(s0)
     484:	87b2                	mv	a5,a2
     486:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
     48a:	fd843783          	ld	a5,-40(s0)
     48e:	fef43423          	sd	a5,-24(s0)
     492:	fd043783          	ld	a5,-48(s0)
     496:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     49a:	a0a1                	j	4e2 <memcmp+0x6c>
    if (*p1 != *p2) {
     49c:	fe843783          	ld	a5,-24(s0)
     4a0:	0007c703          	lbu	a4,0(a5)
     4a4:	fe043783          	ld	a5,-32(s0)
     4a8:	0007c783          	lbu	a5,0(a5)
     4ac:	02f70163          	beq	a4,a5,4ce <memcmp+0x58>
      return *p1 - *p2;
     4b0:	fe843783          	ld	a5,-24(s0)
     4b4:	0007c783          	lbu	a5,0(a5)
     4b8:	0007871b          	sext.w	a4,a5
     4bc:	fe043783          	ld	a5,-32(s0)
     4c0:	0007c783          	lbu	a5,0(a5)
     4c4:	2781                	sext.w	a5,a5
     4c6:	40f707bb          	subw	a5,a4,a5
     4ca:	2781                	sext.w	a5,a5
     4cc:	a01d                	j	4f2 <memcmp+0x7c>
    }
    p1++;
     4ce:	fe843783          	ld	a5,-24(s0)
     4d2:	0785                	addi	a5,a5,1
     4d4:	fef43423          	sd	a5,-24(s0)
    p2++;
     4d8:	fe043783          	ld	a5,-32(s0)
     4dc:	0785                	addi	a5,a5,1
     4de:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     4e2:	fcc42783          	lw	a5,-52(s0)
     4e6:	fff7871b          	addiw	a4,a5,-1
     4ea:	fce42623          	sw	a4,-52(s0)
     4ee:	f7dd                	bnez	a5,49c <memcmp+0x26>
  }
  return 0;
     4f0:	4781                	li	a5,0
}
     4f2:	853e                	mv	a0,a5
     4f4:	7462                	ld	s0,56(sp)
     4f6:	6121                	addi	sp,sp,64
     4f8:	8082                	ret

00000000000004fa <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     4fa:	7179                	addi	sp,sp,-48
     4fc:	f406                	sd	ra,40(sp)
     4fe:	f022                	sd	s0,32(sp)
     500:	1800                	addi	s0,sp,48
     502:	fea43423          	sd	a0,-24(s0)
     506:	feb43023          	sd	a1,-32(s0)
     50a:	87b2                	mv	a5,a2
     50c:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
     510:	fdc42783          	lw	a5,-36(s0)
     514:	863e                	mv	a2,a5
     516:	fe043583          	ld	a1,-32(s0)
     51a:	fe843503          	ld	a0,-24(s0)
     51e:	00000097          	auipc	ra,0x0
     522:	e96080e7          	jalr	-362(ra) # 3b4 <memmove>
     526:	87aa                	mv	a5,a0
}
     528:	853e                	mv	a0,a5
     52a:	70a2                	ld	ra,40(sp)
     52c:	7402                	ld	s0,32(sp)
     52e:	6145                	addi	sp,sp,48
     530:	8082                	ret

0000000000000532 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     532:	4885                	li	a7,1
 ecall
     534:	00000073          	ecall
 ret
     538:	8082                	ret

000000000000053a <exit>:
.global exit
exit:
 li a7, SYS_exit
     53a:	4889                	li	a7,2
 ecall
     53c:	00000073          	ecall
 ret
     540:	8082                	ret

0000000000000542 <wait>:
.global wait
wait:
 li a7, SYS_wait
     542:	488d                	li	a7,3
 ecall
     544:	00000073          	ecall
 ret
     548:	8082                	ret

000000000000054a <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     54a:	4891                	li	a7,4
 ecall
     54c:	00000073          	ecall
 ret
     550:	8082                	ret

0000000000000552 <read>:
.global read
read:
 li a7, SYS_read
     552:	4895                	li	a7,5
 ecall
     554:	00000073          	ecall
 ret
     558:	8082                	ret

000000000000055a <write>:
.global write
write:
 li a7, SYS_write
     55a:	48c1                	li	a7,16
 ecall
     55c:	00000073          	ecall
 ret
     560:	8082                	ret

0000000000000562 <close>:
.global close
close:
 li a7, SYS_close
     562:	48d5                	li	a7,21
 ecall
     564:	00000073          	ecall
 ret
     568:	8082                	ret

000000000000056a <kill>:
.global kill
kill:
 li a7, SYS_kill
     56a:	4899                	li	a7,6
 ecall
     56c:	00000073          	ecall
 ret
     570:	8082                	ret

0000000000000572 <exec>:
.global exec
exec:
 li a7, SYS_exec
     572:	489d                	li	a7,7
 ecall
     574:	00000073          	ecall
 ret
     578:	8082                	ret

000000000000057a <open>:
.global open
open:
 li a7, SYS_open
     57a:	48bd                	li	a7,15
 ecall
     57c:	00000073          	ecall
 ret
     580:	8082                	ret

0000000000000582 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     582:	48c5                	li	a7,17
 ecall
     584:	00000073          	ecall
 ret
     588:	8082                	ret

000000000000058a <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     58a:	48c9                	li	a7,18
 ecall
     58c:	00000073          	ecall
 ret
     590:	8082                	ret

0000000000000592 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     592:	48a1                	li	a7,8
 ecall
     594:	00000073          	ecall
 ret
     598:	8082                	ret

000000000000059a <link>:
.global link
link:
 li a7, SYS_link
     59a:	48cd                	li	a7,19
 ecall
     59c:	00000073          	ecall
 ret
     5a0:	8082                	ret

00000000000005a2 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     5a2:	48d1                	li	a7,20
 ecall
     5a4:	00000073          	ecall
 ret
     5a8:	8082                	ret

00000000000005aa <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     5aa:	48a5                	li	a7,9
 ecall
     5ac:	00000073          	ecall
 ret
     5b0:	8082                	ret

00000000000005b2 <dup>:
.global dup
dup:
 li a7, SYS_dup
     5b2:	48a9                	li	a7,10
 ecall
     5b4:	00000073          	ecall
 ret
     5b8:	8082                	ret

00000000000005ba <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     5ba:	48ad                	li	a7,11
 ecall
     5bc:	00000073          	ecall
 ret
     5c0:	8082                	ret

00000000000005c2 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     5c2:	48b1                	li	a7,12
 ecall
     5c4:	00000073          	ecall
 ret
     5c8:	8082                	ret

00000000000005ca <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     5ca:	48b5                	li	a7,13
 ecall
     5cc:	00000073          	ecall
 ret
     5d0:	8082                	ret

00000000000005d2 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     5d2:	48b9                	li	a7,14
 ecall
     5d4:	00000073          	ecall
 ret
     5d8:	8082                	ret

00000000000005da <thrdstop>:
.global thrdstop
thrdstop:
 li a7, SYS_thrdstop
     5da:	48d9                	li	a7,22
 ecall
     5dc:	00000073          	ecall
 ret
     5e0:	8082                	ret

00000000000005e2 <thrdresume>:
.global thrdresume
thrdresume:
 li a7, SYS_thrdresume
     5e2:	48dd                	li	a7,23
 ecall
     5e4:	00000073          	ecall
 ret
     5e8:	8082                	ret

00000000000005ea <cancelthrdstop>:
.global cancelthrdstop
cancelthrdstop:
 li a7, SYS_cancelthrdstop
     5ea:	48e1                	li	a7,24
 ecall
     5ec:	00000073          	ecall
 ret
     5f0:	8082                	ret

00000000000005f2 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     5f2:	1101                	addi	sp,sp,-32
     5f4:	ec06                	sd	ra,24(sp)
     5f6:	e822                	sd	s0,16(sp)
     5f8:	1000                	addi	s0,sp,32
     5fa:	87aa                	mv	a5,a0
     5fc:	872e                	mv	a4,a1
     5fe:	fef42623          	sw	a5,-20(s0)
     602:	87ba                	mv	a5,a4
     604:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
     608:	feb40713          	addi	a4,s0,-21
     60c:	fec42783          	lw	a5,-20(s0)
     610:	4605                	li	a2,1
     612:	85ba                	mv	a1,a4
     614:	853e                	mv	a0,a5
     616:	00000097          	auipc	ra,0x0
     61a:	f44080e7          	jalr	-188(ra) # 55a <write>
}
     61e:	0001                	nop
     620:	60e2                	ld	ra,24(sp)
     622:	6442                	ld	s0,16(sp)
     624:	6105                	addi	sp,sp,32
     626:	8082                	ret

0000000000000628 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     628:	7139                	addi	sp,sp,-64
     62a:	fc06                	sd	ra,56(sp)
     62c:	f822                	sd	s0,48(sp)
     62e:	0080                	addi	s0,sp,64
     630:	87aa                	mv	a5,a0
     632:	8736                	mv	a4,a3
     634:	fcf42623          	sw	a5,-52(s0)
     638:	87ae                	mv	a5,a1
     63a:	fcf42423          	sw	a5,-56(s0)
     63e:	87b2                	mv	a5,a2
     640:	fcf42223          	sw	a5,-60(s0)
     644:	87ba                	mv	a5,a4
     646:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     64a:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
     64e:	fc042783          	lw	a5,-64(s0)
     652:	2781                	sext.w	a5,a5
     654:	c38d                	beqz	a5,676 <printint+0x4e>
     656:	fc842783          	lw	a5,-56(s0)
     65a:	2781                	sext.w	a5,a5
     65c:	0007dd63          	bgez	a5,676 <printint+0x4e>
    neg = 1;
     660:	4785                	li	a5,1
     662:	fef42423          	sw	a5,-24(s0)
    x = -xx;
     666:	fc842783          	lw	a5,-56(s0)
     66a:	40f007bb          	negw	a5,a5
     66e:	2781                	sext.w	a5,a5
     670:	fef42223          	sw	a5,-28(s0)
     674:	a029                	j	67e <printint+0x56>
  } else {
    x = xx;
     676:	fc842783          	lw	a5,-56(s0)
     67a:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
     67e:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
     682:	fc442783          	lw	a5,-60(s0)
     686:	fe442703          	lw	a4,-28(s0)
     68a:	02f777bb          	remuw	a5,a4,a5
     68e:	0007861b          	sext.w	a2,a5
     692:	fec42783          	lw	a5,-20(s0)
     696:	0017871b          	addiw	a4,a5,1
     69a:	fee42623          	sw	a4,-20(s0)
     69e:	00001697          	auipc	a3,0x1
     6a2:	fba68693          	addi	a3,a3,-70 # 1658 <digits>
     6a6:	02061713          	slli	a4,a2,0x20
     6aa:	9301                	srli	a4,a4,0x20
     6ac:	9736                	add	a4,a4,a3
     6ae:	00074703          	lbu	a4,0(a4)
     6b2:	ff040693          	addi	a3,s0,-16
     6b6:	97b6                	add	a5,a5,a3
     6b8:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
     6bc:	fc442783          	lw	a5,-60(s0)
     6c0:	fe442703          	lw	a4,-28(s0)
     6c4:	02f757bb          	divuw	a5,a4,a5
     6c8:	fef42223          	sw	a5,-28(s0)
     6cc:	fe442783          	lw	a5,-28(s0)
     6d0:	2781                	sext.w	a5,a5
     6d2:	fbc5                	bnez	a5,682 <printint+0x5a>
  if(neg)
     6d4:	fe842783          	lw	a5,-24(s0)
     6d8:	2781                	sext.w	a5,a5
     6da:	cf95                	beqz	a5,716 <printint+0xee>
    buf[i++] = '-';
     6dc:	fec42783          	lw	a5,-20(s0)
     6e0:	0017871b          	addiw	a4,a5,1
     6e4:	fee42623          	sw	a4,-20(s0)
     6e8:	ff040713          	addi	a4,s0,-16
     6ec:	97ba                	add	a5,a5,a4
     6ee:	02d00713          	li	a4,45
     6f2:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
     6f6:	a005                	j	716 <printint+0xee>
    putc(fd, buf[i]);
     6f8:	fec42783          	lw	a5,-20(s0)
     6fc:	ff040713          	addi	a4,s0,-16
     700:	97ba                	add	a5,a5,a4
     702:	fe07c703          	lbu	a4,-32(a5)
     706:	fcc42783          	lw	a5,-52(s0)
     70a:	85ba                	mv	a1,a4
     70c:	853e                	mv	a0,a5
     70e:	00000097          	auipc	ra,0x0
     712:	ee4080e7          	jalr	-284(ra) # 5f2 <putc>
  while(--i >= 0)
     716:	fec42783          	lw	a5,-20(s0)
     71a:	37fd                	addiw	a5,a5,-1
     71c:	fef42623          	sw	a5,-20(s0)
     720:	fec42783          	lw	a5,-20(s0)
     724:	2781                	sext.w	a5,a5
     726:	fc07d9e3          	bgez	a5,6f8 <printint+0xd0>
}
     72a:	0001                	nop
     72c:	0001                	nop
     72e:	70e2                	ld	ra,56(sp)
     730:	7442                	ld	s0,48(sp)
     732:	6121                	addi	sp,sp,64
     734:	8082                	ret

0000000000000736 <printptr>:

static void
printptr(int fd, uint64 x) {
     736:	7179                	addi	sp,sp,-48
     738:	f406                	sd	ra,40(sp)
     73a:	f022                	sd	s0,32(sp)
     73c:	1800                	addi	s0,sp,48
     73e:	87aa                	mv	a5,a0
     740:	fcb43823          	sd	a1,-48(s0)
     744:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
     748:	fdc42783          	lw	a5,-36(s0)
     74c:	03000593          	li	a1,48
     750:	853e                	mv	a0,a5
     752:	00000097          	auipc	ra,0x0
     756:	ea0080e7          	jalr	-352(ra) # 5f2 <putc>
  putc(fd, 'x');
     75a:	fdc42783          	lw	a5,-36(s0)
     75e:	07800593          	li	a1,120
     762:	853e                	mv	a0,a5
     764:	00000097          	auipc	ra,0x0
     768:	e8e080e7          	jalr	-370(ra) # 5f2 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     76c:	fe042623          	sw	zero,-20(s0)
     770:	a82d                	j	7aa <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     772:	fd043783          	ld	a5,-48(s0)
     776:	93f1                	srli	a5,a5,0x3c
     778:	00001717          	auipc	a4,0x1
     77c:	ee070713          	addi	a4,a4,-288 # 1658 <digits>
     780:	97ba                	add	a5,a5,a4
     782:	0007c703          	lbu	a4,0(a5)
     786:	fdc42783          	lw	a5,-36(s0)
     78a:	85ba                	mv	a1,a4
     78c:	853e                	mv	a0,a5
     78e:	00000097          	auipc	ra,0x0
     792:	e64080e7          	jalr	-412(ra) # 5f2 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     796:	fec42783          	lw	a5,-20(s0)
     79a:	2785                	addiw	a5,a5,1
     79c:	fef42623          	sw	a5,-20(s0)
     7a0:	fd043783          	ld	a5,-48(s0)
     7a4:	0792                	slli	a5,a5,0x4
     7a6:	fcf43823          	sd	a5,-48(s0)
     7aa:	fec42783          	lw	a5,-20(s0)
     7ae:	873e                	mv	a4,a5
     7b0:	47bd                	li	a5,15
     7b2:	fce7f0e3          	bgeu	a5,a4,772 <printptr+0x3c>
}
     7b6:	0001                	nop
     7b8:	0001                	nop
     7ba:	70a2                	ld	ra,40(sp)
     7bc:	7402                	ld	s0,32(sp)
     7be:	6145                	addi	sp,sp,48
     7c0:	8082                	ret

00000000000007c2 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     7c2:	715d                	addi	sp,sp,-80
     7c4:	e486                	sd	ra,72(sp)
     7c6:	e0a2                	sd	s0,64(sp)
     7c8:	0880                	addi	s0,sp,80
     7ca:	87aa                	mv	a5,a0
     7cc:	fcb43023          	sd	a1,-64(s0)
     7d0:	fac43c23          	sd	a2,-72(s0)
     7d4:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
     7d8:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     7dc:	fe042223          	sw	zero,-28(s0)
     7e0:	a42d                	j	a0a <vprintf+0x248>
    c = fmt[i] & 0xff;
     7e2:	fe442783          	lw	a5,-28(s0)
     7e6:	fc043703          	ld	a4,-64(s0)
     7ea:	97ba                	add	a5,a5,a4
     7ec:	0007c783          	lbu	a5,0(a5)
     7f0:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
     7f4:	fe042783          	lw	a5,-32(s0)
     7f8:	2781                	sext.w	a5,a5
     7fa:	eb9d                	bnez	a5,830 <vprintf+0x6e>
      if(c == '%'){
     7fc:	fdc42783          	lw	a5,-36(s0)
     800:	0007871b          	sext.w	a4,a5
     804:	02500793          	li	a5,37
     808:	00f71763          	bne	a4,a5,816 <vprintf+0x54>
        state = '%';
     80c:	02500793          	li	a5,37
     810:	fef42023          	sw	a5,-32(s0)
     814:	a2f5                	j	a00 <vprintf+0x23e>
      } else {
        putc(fd, c);
     816:	fdc42783          	lw	a5,-36(s0)
     81a:	0ff7f713          	andi	a4,a5,255
     81e:	fcc42783          	lw	a5,-52(s0)
     822:	85ba                	mv	a1,a4
     824:	853e                	mv	a0,a5
     826:	00000097          	auipc	ra,0x0
     82a:	dcc080e7          	jalr	-564(ra) # 5f2 <putc>
     82e:	aac9                	j	a00 <vprintf+0x23e>
      }
    } else if(state == '%'){
     830:	fe042783          	lw	a5,-32(s0)
     834:	0007871b          	sext.w	a4,a5
     838:	02500793          	li	a5,37
     83c:	1cf71263          	bne	a4,a5,a00 <vprintf+0x23e>
      if(c == 'd'){
     840:	fdc42783          	lw	a5,-36(s0)
     844:	0007871b          	sext.w	a4,a5
     848:	06400793          	li	a5,100
     84c:	02f71463          	bne	a4,a5,874 <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
     850:	fb843783          	ld	a5,-72(s0)
     854:	00878713          	addi	a4,a5,8
     858:	fae43c23          	sd	a4,-72(s0)
     85c:	4398                	lw	a4,0(a5)
     85e:	fcc42783          	lw	a5,-52(s0)
     862:	4685                	li	a3,1
     864:	4629                	li	a2,10
     866:	85ba                	mv	a1,a4
     868:	853e                	mv	a0,a5
     86a:	00000097          	auipc	ra,0x0
     86e:	dbe080e7          	jalr	-578(ra) # 628 <printint>
     872:	a269                	j	9fc <vprintf+0x23a>
      } else if(c == 'l') {
     874:	fdc42783          	lw	a5,-36(s0)
     878:	0007871b          	sext.w	a4,a5
     87c:	06c00793          	li	a5,108
     880:	02f71663          	bne	a4,a5,8ac <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
     884:	fb843783          	ld	a5,-72(s0)
     888:	00878713          	addi	a4,a5,8
     88c:	fae43c23          	sd	a4,-72(s0)
     890:	639c                	ld	a5,0(a5)
     892:	0007871b          	sext.w	a4,a5
     896:	fcc42783          	lw	a5,-52(s0)
     89a:	4681                	li	a3,0
     89c:	4629                	li	a2,10
     89e:	85ba                	mv	a1,a4
     8a0:	853e                	mv	a0,a5
     8a2:	00000097          	auipc	ra,0x0
     8a6:	d86080e7          	jalr	-634(ra) # 628 <printint>
     8aa:	aa89                	j	9fc <vprintf+0x23a>
      } else if(c == 'x') {
     8ac:	fdc42783          	lw	a5,-36(s0)
     8b0:	0007871b          	sext.w	a4,a5
     8b4:	07800793          	li	a5,120
     8b8:	02f71463          	bne	a4,a5,8e0 <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
     8bc:	fb843783          	ld	a5,-72(s0)
     8c0:	00878713          	addi	a4,a5,8
     8c4:	fae43c23          	sd	a4,-72(s0)
     8c8:	4398                	lw	a4,0(a5)
     8ca:	fcc42783          	lw	a5,-52(s0)
     8ce:	4681                	li	a3,0
     8d0:	4641                	li	a2,16
     8d2:	85ba                	mv	a1,a4
     8d4:	853e                	mv	a0,a5
     8d6:	00000097          	auipc	ra,0x0
     8da:	d52080e7          	jalr	-686(ra) # 628 <printint>
     8de:	aa39                	j	9fc <vprintf+0x23a>
      } else if(c == 'p') {
     8e0:	fdc42783          	lw	a5,-36(s0)
     8e4:	0007871b          	sext.w	a4,a5
     8e8:	07000793          	li	a5,112
     8ec:	02f71263          	bne	a4,a5,910 <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
     8f0:	fb843783          	ld	a5,-72(s0)
     8f4:	00878713          	addi	a4,a5,8
     8f8:	fae43c23          	sd	a4,-72(s0)
     8fc:	6398                	ld	a4,0(a5)
     8fe:	fcc42783          	lw	a5,-52(s0)
     902:	85ba                	mv	a1,a4
     904:	853e                	mv	a0,a5
     906:	00000097          	auipc	ra,0x0
     90a:	e30080e7          	jalr	-464(ra) # 736 <printptr>
     90e:	a0fd                	j	9fc <vprintf+0x23a>
      } else if(c == 's'){
     910:	fdc42783          	lw	a5,-36(s0)
     914:	0007871b          	sext.w	a4,a5
     918:	07300793          	li	a5,115
     91c:	04f71c63          	bne	a4,a5,974 <vprintf+0x1b2>
        s = va_arg(ap, char*);
     920:	fb843783          	ld	a5,-72(s0)
     924:	00878713          	addi	a4,a5,8
     928:	fae43c23          	sd	a4,-72(s0)
     92c:	639c                	ld	a5,0(a5)
     92e:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
     932:	fe843783          	ld	a5,-24(s0)
     936:	eb8d                	bnez	a5,968 <vprintf+0x1a6>
          s = "(null)";
     938:	00001797          	auipc	a5,0x1
     93c:	d1878793          	addi	a5,a5,-744 # 1650 <schedule_rm+0x396>
     940:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     944:	a015                	j	968 <vprintf+0x1a6>
          putc(fd, *s);
     946:	fe843783          	ld	a5,-24(s0)
     94a:	0007c703          	lbu	a4,0(a5)
     94e:	fcc42783          	lw	a5,-52(s0)
     952:	85ba                	mv	a1,a4
     954:	853e                	mv	a0,a5
     956:	00000097          	auipc	ra,0x0
     95a:	c9c080e7          	jalr	-868(ra) # 5f2 <putc>
          s++;
     95e:	fe843783          	ld	a5,-24(s0)
     962:	0785                	addi	a5,a5,1
     964:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     968:	fe843783          	ld	a5,-24(s0)
     96c:	0007c783          	lbu	a5,0(a5)
     970:	fbf9                	bnez	a5,946 <vprintf+0x184>
     972:	a069                	j	9fc <vprintf+0x23a>
        }
      } else if(c == 'c'){
     974:	fdc42783          	lw	a5,-36(s0)
     978:	0007871b          	sext.w	a4,a5
     97c:	06300793          	li	a5,99
     980:	02f71463          	bne	a4,a5,9a8 <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
     984:	fb843783          	ld	a5,-72(s0)
     988:	00878713          	addi	a4,a5,8
     98c:	fae43c23          	sd	a4,-72(s0)
     990:	439c                	lw	a5,0(a5)
     992:	0ff7f713          	andi	a4,a5,255
     996:	fcc42783          	lw	a5,-52(s0)
     99a:	85ba                	mv	a1,a4
     99c:	853e                	mv	a0,a5
     99e:	00000097          	auipc	ra,0x0
     9a2:	c54080e7          	jalr	-940(ra) # 5f2 <putc>
     9a6:	a899                	j	9fc <vprintf+0x23a>
      } else if(c == '%'){
     9a8:	fdc42783          	lw	a5,-36(s0)
     9ac:	0007871b          	sext.w	a4,a5
     9b0:	02500793          	li	a5,37
     9b4:	00f71f63          	bne	a4,a5,9d2 <vprintf+0x210>
        putc(fd, c);
     9b8:	fdc42783          	lw	a5,-36(s0)
     9bc:	0ff7f713          	andi	a4,a5,255
     9c0:	fcc42783          	lw	a5,-52(s0)
     9c4:	85ba                	mv	a1,a4
     9c6:	853e                	mv	a0,a5
     9c8:	00000097          	auipc	ra,0x0
     9cc:	c2a080e7          	jalr	-982(ra) # 5f2 <putc>
     9d0:	a035                	j	9fc <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     9d2:	fcc42783          	lw	a5,-52(s0)
     9d6:	02500593          	li	a1,37
     9da:	853e                	mv	a0,a5
     9dc:	00000097          	auipc	ra,0x0
     9e0:	c16080e7          	jalr	-1002(ra) # 5f2 <putc>
        putc(fd, c);
     9e4:	fdc42783          	lw	a5,-36(s0)
     9e8:	0ff7f713          	andi	a4,a5,255
     9ec:	fcc42783          	lw	a5,-52(s0)
     9f0:	85ba                	mv	a1,a4
     9f2:	853e                	mv	a0,a5
     9f4:	00000097          	auipc	ra,0x0
     9f8:	bfe080e7          	jalr	-1026(ra) # 5f2 <putc>
      }
      state = 0;
     9fc:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     a00:	fe442783          	lw	a5,-28(s0)
     a04:	2785                	addiw	a5,a5,1
     a06:	fef42223          	sw	a5,-28(s0)
     a0a:	fe442783          	lw	a5,-28(s0)
     a0e:	fc043703          	ld	a4,-64(s0)
     a12:	97ba                	add	a5,a5,a4
     a14:	0007c783          	lbu	a5,0(a5)
     a18:	dc0795e3          	bnez	a5,7e2 <vprintf+0x20>
    }
  }
}
     a1c:	0001                	nop
     a1e:	0001                	nop
     a20:	60a6                	ld	ra,72(sp)
     a22:	6406                	ld	s0,64(sp)
     a24:	6161                	addi	sp,sp,80
     a26:	8082                	ret

0000000000000a28 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     a28:	7159                	addi	sp,sp,-112
     a2a:	fc06                	sd	ra,56(sp)
     a2c:	f822                	sd	s0,48(sp)
     a2e:	0080                	addi	s0,sp,64
     a30:	fcb43823          	sd	a1,-48(s0)
     a34:	e010                	sd	a2,0(s0)
     a36:	e414                	sd	a3,8(s0)
     a38:	e818                	sd	a4,16(s0)
     a3a:	ec1c                	sd	a5,24(s0)
     a3c:	03043023          	sd	a6,32(s0)
     a40:	03143423          	sd	a7,40(s0)
     a44:	87aa                	mv	a5,a0
     a46:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
     a4a:	03040793          	addi	a5,s0,48
     a4e:	fcf43423          	sd	a5,-56(s0)
     a52:	fc843783          	ld	a5,-56(s0)
     a56:	fd078793          	addi	a5,a5,-48
     a5a:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
     a5e:	fe843703          	ld	a4,-24(s0)
     a62:	fdc42783          	lw	a5,-36(s0)
     a66:	863a                	mv	a2,a4
     a68:	fd043583          	ld	a1,-48(s0)
     a6c:	853e                	mv	a0,a5
     a6e:	00000097          	auipc	ra,0x0
     a72:	d54080e7          	jalr	-684(ra) # 7c2 <vprintf>
}
     a76:	0001                	nop
     a78:	70e2                	ld	ra,56(sp)
     a7a:	7442                	ld	s0,48(sp)
     a7c:	6165                	addi	sp,sp,112
     a7e:	8082                	ret

0000000000000a80 <printf>:

void
printf(const char *fmt, ...)
{
     a80:	7159                	addi	sp,sp,-112
     a82:	f406                	sd	ra,40(sp)
     a84:	f022                	sd	s0,32(sp)
     a86:	1800                	addi	s0,sp,48
     a88:	fca43c23          	sd	a0,-40(s0)
     a8c:	e40c                	sd	a1,8(s0)
     a8e:	e810                	sd	a2,16(s0)
     a90:	ec14                	sd	a3,24(s0)
     a92:	f018                	sd	a4,32(s0)
     a94:	f41c                	sd	a5,40(s0)
     a96:	03043823          	sd	a6,48(s0)
     a9a:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
     a9e:	04040793          	addi	a5,s0,64
     aa2:	fcf43823          	sd	a5,-48(s0)
     aa6:	fd043783          	ld	a5,-48(s0)
     aaa:	fc878793          	addi	a5,a5,-56
     aae:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
     ab2:	fe843783          	ld	a5,-24(s0)
     ab6:	863e                	mv	a2,a5
     ab8:	fd843583          	ld	a1,-40(s0)
     abc:	4505                	li	a0,1
     abe:	00000097          	auipc	ra,0x0
     ac2:	d04080e7          	jalr	-764(ra) # 7c2 <vprintf>
}
     ac6:	0001                	nop
     ac8:	70a2                	ld	ra,40(sp)
     aca:	7402                	ld	s0,32(sp)
     acc:	6165                	addi	sp,sp,112
     ace:	8082                	ret

0000000000000ad0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     ad0:	7179                	addi	sp,sp,-48
     ad2:	f422                	sd	s0,40(sp)
     ad4:	1800                	addi	s0,sp,48
     ad6:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
     ada:	fd843783          	ld	a5,-40(s0)
     ade:	17c1                	addi	a5,a5,-16
     ae0:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     ae4:	00001797          	auipc	a5,0x1
     ae8:	b9c78793          	addi	a5,a5,-1124 # 1680 <freep>
     aec:	639c                	ld	a5,0(a5)
     aee:	fef43423          	sd	a5,-24(s0)
     af2:	a815                	j	b26 <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     af4:	fe843783          	ld	a5,-24(s0)
     af8:	639c                	ld	a5,0(a5)
     afa:	fe843703          	ld	a4,-24(s0)
     afe:	00f76f63          	bltu	a4,a5,b1c <free+0x4c>
     b02:	fe043703          	ld	a4,-32(s0)
     b06:	fe843783          	ld	a5,-24(s0)
     b0a:	02e7eb63          	bltu	a5,a4,b40 <free+0x70>
     b0e:	fe843783          	ld	a5,-24(s0)
     b12:	639c                	ld	a5,0(a5)
     b14:	fe043703          	ld	a4,-32(s0)
     b18:	02f76463          	bltu	a4,a5,b40 <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     b1c:	fe843783          	ld	a5,-24(s0)
     b20:	639c                	ld	a5,0(a5)
     b22:	fef43423          	sd	a5,-24(s0)
     b26:	fe043703          	ld	a4,-32(s0)
     b2a:	fe843783          	ld	a5,-24(s0)
     b2e:	fce7f3e3          	bgeu	a5,a4,af4 <free+0x24>
     b32:	fe843783          	ld	a5,-24(s0)
     b36:	639c                	ld	a5,0(a5)
     b38:	fe043703          	ld	a4,-32(s0)
     b3c:	faf77ce3          	bgeu	a4,a5,af4 <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
     b40:	fe043783          	ld	a5,-32(s0)
     b44:	479c                	lw	a5,8(a5)
     b46:	1782                	slli	a5,a5,0x20
     b48:	9381                	srli	a5,a5,0x20
     b4a:	0792                	slli	a5,a5,0x4
     b4c:	fe043703          	ld	a4,-32(s0)
     b50:	973e                	add	a4,a4,a5
     b52:	fe843783          	ld	a5,-24(s0)
     b56:	639c                	ld	a5,0(a5)
     b58:	02f71763          	bne	a4,a5,b86 <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
     b5c:	fe043783          	ld	a5,-32(s0)
     b60:	4798                	lw	a4,8(a5)
     b62:	fe843783          	ld	a5,-24(s0)
     b66:	639c                	ld	a5,0(a5)
     b68:	479c                	lw	a5,8(a5)
     b6a:	9fb9                	addw	a5,a5,a4
     b6c:	0007871b          	sext.w	a4,a5
     b70:	fe043783          	ld	a5,-32(s0)
     b74:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
     b76:	fe843783          	ld	a5,-24(s0)
     b7a:	639c                	ld	a5,0(a5)
     b7c:	6398                	ld	a4,0(a5)
     b7e:	fe043783          	ld	a5,-32(s0)
     b82:	e398                	sd	a4,0(a5)
     b84:	a039                	j	b92 <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
     b86:	fe843783          	ld	a5,-24(s0)
     b8a:	6398                	ld	a4,0(a5)
     b8c:	fe043783          	ld	a5,-32(s0)
     b90:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
     b92:	fe843783          	ld	a5,-24(s0)
     b96:	479c                	lw	a5,8(a5)
     b98:	1782                	slli	a5,a5,0x20
     b9a:	9381                	srli	a5,a5,0x20
     b9c:	0792                	slli	a5,a5,0x4
     b9e:	fe843703          	ld	a4,-24(s0)
     ba2:	97ba                	add	a5,a5,a4
     ba4:	fe043703          	ld	a4,-32(s0)
     ba8:	02f71563          	bne	a4,a5,bd2 <free+0x102>
    p->s.size += bp->s.size;
     bac:	fe843783          	ld	a5,-24(s0)
     bb0:	4798                	lw	a4,8(a5)
     bb2:	fe043783          	ld	a5,-32(s0)
     bb6:	479c                	lw	a5,8(a5)
     bb8:	9fb9                	addw	a5,a5,a4
     bba:	0007871b          	sext.w	a4,a5
     bbe:	fe843783          	ld	a5,-24(s0)
     bc2:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
     bc4:	fe043783          	ld	a5,-32(s0)
     bc8:	6398                	ld	a4,0(a5)
     bca:	fe843783          	ld	a5,-24(s0)
     bce:	e398                	sd	a4,0(a5)
     bd0:	a031                	j	bdc <free+0x10c>
  } else
    p->s.ptr = bp;
     bd2:	fe843783          	ld	a5,-24(s0)
     bd6:	fe043703          	ld	a4,-32(s0)
     bda:	e398                	sd	a4,0(a5)
  freep = p;
     bdc:	00001797          	auipc	a5,0x1
     be0:	aa478793          	addi	a5,a5,-1372 # 1680 <freep>
     be4:	fe843703          	ld	a4,-24(s0)
     be8:	e398                	sd	a4,0(a5)
}
     bea:	0001                	nop
     bec:	7422                	ld	s0,40(sp)
     bee:	6145                	addi	sp,sp,48
     bf0:	8082                	ret

0000000000000bf2 <morecore>:

static Header*
morecore(uint nu)
{
     bf2:	7179                	addi	sp,sp,-48
     bf4:	f406                	sd	ra,40(sp)
     bf6:	f022                	sd	s0,32(sp)
     bf8:	1800                	addi	s0,sp,48
     bfa:	87aa                	mv	a5,a0
     bfc:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
     c00:	fdc42783          	lw	a5,-36(s0)
     c04:	0007871b          	sext.w	a4,a5
     c08:	6785                	lui	a5,0x1
     c0a:	00f77563          	bgeu	a4,a5,c14 <morecore+0x22>
    nu = 4096;
     c0e:	6785                	lui	a5,0x1
     c10:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
     c14:	fdc42783          	lw	a5,-36(s0)
     c18:	0047979b          	slliw	a5,a5,0x4
     c1c:	2781                	sext.w	a5,a5
     c1e:	2781                	sext.w	a5,a5
     c20:	853e                	mv	a0,a5
     c22:	00000097          	auipc	ra,0x0
     c26:	9a0080e7          	jalr	-1632(ra) # 5c2 <sbrk>
     c2a:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
     c2e:	fe843703          	ld	a4,-24(s0)
     c32:	57fd                	li	a5,-1
     c34:	00f71463          	bne	a4,a5,c3c <morecore+0x4a>
    return 0;
     c38:	4781                	li	a5,0
     c3a:	a03d                	j	c68 <morecore+0x76>
  hp = (Header*)p;
     c3c:	fe843783          	ld	a5,-24(s0)
     c40:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
     c44:	fe043783          	ld	a5,-32(s0)
     c48:	fdc42703          	lw	a4,-36(s0)
     c4c:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
     c4e:	fe043783          	ld	a5,-32(s0)
     c52:	07c1                	addi	a5,a5,16
     c54:	853e                	mv	a0,a5
     c56:	00000097          	auipc	ra,0x0
     c5a:	e7a080e7          	jalr	-390(ra) # ad0 <free>
  return freep;
     c5e:	00001797          	auipc	a5,0x1
     c62:	a2278793          	addi	a5,a5,-1502 # 1680 <freep>
     c66:	639c                	ld	a5,0(a5)
}
     c68:	853e                	mv	a0,a5
     c6a:	70a2                	ld	ra,40(sp)
     c6c:	7402                	ld	s0,32(sp)
     c6e:	6145                	addi	sp,sp,48
     c70:	8082                	ret

0000000000000c72 <malloc>:

void*
malloc(uint nbytes)
{
     c72:	7139                	addi	sp,sp,-64
     c74:	fc06                	sd	ra,56(sp)
     c76:	f822                	sd	s0,48(sp)
     c78:	0080                	addi	s0,sp,64
     c7a:	87aa                	mv	a5,a0
     c7c:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     c80:	fcc46783          	lwu	a5,-52(s0)
     c84:	07bd                	addi	a5,a5,15
     c86:	8391                	srli	a5,a5,0x4
     c88:	2781                	sext.w	a5,a5
     c8a:	2785                	addiw	a5,a5,1
     c8c:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
     c90:	00001797          	auipc	a5,0x1
     c94:	9f078793          	addi	a5,a5,-1552 # 1680 <freep>
     c98:	639c                	ld	a5,0(a5)
     c9a:	fef43023          	sd	a5,-32(s0)
     c9e:	fe043783          	ld	a5,-32(s0)
     ca2:	ef95                	bnez	a5,cde <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
     ca4:	00001797          	auipc	a5,0x1
     ca8:	9cc78793          	addi	a5,a5,-1588 # 1670 <base>
     cac:	fef43023          	sd	a5,-32(s0)
     cb0:	00001797          	auipc	a5,0x1
     cb4:	9d078793          	addi	a5,a5,-1584 # 1680 <freep>
     cb8:	fe043703          	ld	a4,-32(s0)
     cbc:	e398                	sd	a4,0(a5)
     cbe:	00001797          	auipc	a5,0x1
     cc2:	9c278793          	addi	a5,a5,-1598 # 1680 <freep>
     cc6:	6398                	ld	a4,0(a5)
     cc8:	00001797          	auipc	a5,0x1
     ccc:	9a878793          	addi	a5,a5,-1624 # 1670 <base>
     cd0:	e398                	sd	a4,0(a5)
    base.s.size = 0;
     cd2:	00001797          	auipc	a5,0x1
     cd6:	99e78793          	addi	a5,a5,-1634 # 1670 <base>
     cda:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     cde:	fe043783          	ld	a5,-32(s0)
     ce2:	639c                	ld	a5,0(a5)
     ce4:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     ce8:	fe843783          	ld	a5,-24(s0)
     cec:	4798                	lw	a4,8(a5)
     cee:	fdc42783          	lw	a5,-36(s0)
     cf2:	2781                	sext.w	a5,a5
     cf4:	06f76863          	bltu	a4,a5,d64 <malloc+0xf2>
      if(p->s.size == nunits)
     cf8:	fe843783          	ld	a5,-24(s0)
     cfc:	4798                	lw	a4,8(a5)
     cfe:	fdc42783          	lw	a5,-36(s0)
     d02:	2781                	sext.w	a5,a5
     d04:	00e79963          	bne	a5,a4,d16 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
     d08:	fe843783          	ld	a5,-24(s0)
     d0c:	6398                	ld	a4,0(a5)
     d0e:	fe043783          	ld	a5,-32(s0)
     d12:	e398                	sd	a4,0(a5)
     d14:	a82d                	j	d4e <malloc+0xdc>
      else {
        p->s.size -= nunits;
     d16:	fe843783          	ld	a5,-24(s0)
     d1a:	4798                	lw	a4,8(a5)
     d1c:	fdc42783          	lw	a5,-36(s0)
     d20:	40f707bb          	subw	a5,a4,a5
     d24:	0007871b          	sext.w	a4,a5
     d28:	fe843783          	ld	a5,-24(s0)
     d2c:	c798                	sw	a4,8(a5)
        p += p->s.size;
     d2e:	fe843783          	ld	a5,-24(s0)
     d32:	479c                	lw	a5,8(a5)
     d34:	1782                	slli	a5,a5,0x20
     d36:	9381                	srli	a5,a5,0x20
     d38:	0792                	slli	a5,a5,0x4
     d3a:	fe843703          	ld	a4,-24(s0)
     d3e:	97ba                	add	a5,a5,a4
     d40:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
     d44:	fe843783          	ld	a5,-24(s0)
     d48:	fdc42703          	lw	a4,-36(s0)
     d4c:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
     d4e:	00001797          	auipc	a5,0x1
     d52:	93278793          	addi	a5,a5,-1742 # 1680 <freep>
     d56:	fe043703          	ld	a4,-32(s0)
     d5a:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
     d5c:	fe843783          	ld	a5,-24(s0)
     d60:	07c1                	addi	a5,a5,16
     d62:	a091                	j	da6 <malloc+0x134>
    }
    if(p == freep)
     d64:	00001797          	auipc	a5,0x1
     d68:	91c78793          	addi	a5,a5,-1764 # 1680 <freep>
     d6c:	639c                	ld	a5,0(a5)
     d6e:	fe843703          	ld	a4,-24(s0)
     d72:	02f71063          	bne	a4,a5,d92 <malloc+0x120>
      if((p = morecore(nunits)) == 0)
     d76:	fdc42783          	lw	a5,-36(s0)
     d7a:	853e                	mv	a0,a5
     d7c:	00000097          	auipc	ra,0x0
     d80:	e76080e7          	jalr	-394(ra) # bf2 <morecore>
     d84:	fea43423          	sd	a0,-24(s0)
     d88:	fe843783          	ld	a5,-24(s0)
     d8c:	e399                	bnez	a5,d92 <malloc+0x120>
        return 0;
     d8e:	4781                	li	a5,0
     d90:	a819                	j	da6 <malloc+0x134>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     d92:	fe843783          	ld	a5,-24(s0)
     d96:	fef43023          	sd	a5,-32(s0)
     d9a:	fe843783          	ld	a5,-24(s0)
     d9e:	639c                	ld	a5,0(a5)
     da0:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     da4:	b791                	j	ce8 <malloc+0x76>
  }
}
     da6:	853e                	mv	a0,a5
     da8:	70e2                	ld	ra,56(sp)
     daa:	7442                	ld	s0,48(sp)
     dac:	6121                	addi	sp,sp,64
     dae:	8082                	ret

0000000000000db0 <setjmp>:
     db0:	e100                	sd	s0,0(a0)
     db2:	e504                	sd	s1,8(a0)
     db4:	01253823          	sd	s2,16(a0)
     db8:	01353c23          	sd	s3,24(a0)
     dbc:	03453023          	sd	s4,32(a0)
     dc0:	03553423          	sd	s5,40(a0)
     dc4:	03653823          	sd	s6,48(a0)
     dc8:	03753c23          	sd	s7,56(a0)
     dcc:	05853023          	sd	s8,64(a0)
     dd0:	05953423          	sd	s9,72(a0)
     dd4:	05a53823          	sd	s10,80(a0)
     dd8:	05b53c23          	sd	s11,88(a0)
     ddc:	06153023          	sd	ra,96(a0)
     de0:	06253423          	sd	sp,104(a0)
     de4:	4501                	li	a0,0
     de6:	8082                	ret

0000000000000de8 <longjmp>:
     de8:	6100                	ld	s0,0(a0)
     dea:	6504                	ld	s1,8(a0)
     dec:	01053903          	ld	s2,16(a0)
     df0:	01853983          	ld	s3,24(a0)
     df4:	02053a03          	ld	s4,32(a0)
     df8:	02853a83          	ld	s5,40(a0)
     dfc:	03053b03          	ld	s6,48(a0)
     e00:	03853b83          	ld	s7,56(a0)
     e04:	04053c03          	ld	s8,64(a0)
     e08:	04853c83          	ld	s9,72(a0)
     e0c:	05053d03          	ld	s10,80(a0)
     e10:	05853d83          	ld	s11,88(a0)
     e14:	06053083          	ld	ra,96(a0)
     e18:	06853103          	ld	sp,104(a0)
     e1c:	c199                	beqz	a1,e22 <longjmp_1>
     e1e:	852e                	mv	a0,a1
     e20:	8082                	ret

0000000000000e22 <longjmp_1>:
     e22:	4505                	li	a0,1
     e24:	8082                	ret

0000000000000e26 <list_empty>:
/**
 * list_empty - tests whether a list is empty
 * @head: the list to test.
 */
static inline int list_empty(const struct list_head *head)
{
     e26:	1101                	addi	sp,sp,-32
     e28:	ec22                	sd	s0,24(sp)
     e2a:	1000                	addi	s0,sp,32
     e2c:	fea43423          	sd	a0,-24(s0)
    return head->next == head;
     e30:	fe843783          	ld	a5,-24(s0)
     e34:	639c                	ld	a5,0(a5)
     e36:	fe843703          	ld	a4,-24(s0)
     e3a:	40f707b3          	sub	a5,a4,a5
     e3e:	0017b793          	seqz	a5,a5
     e42:	0ff7f793          	andi	a5,a5,255
     e46:	2781                	sext.w	a5,a5
}
     e48:	853e                	mv	a0,a5
     e4a:	6462                	ld	s0,24(sp)
     e4c:	6105                	addi	sp,sp,32
     e4e:	8082                	ret

0000000000000e50 <schedule_default>:

#define NULL 0

/* default scheduling algorithm */
struct threads_sched_result schedule_default(struct threads_sched_args args)
{
     e50:	715d                	addi	sp,sp,-80
     e52:	e4a2                	sd	s0,72(sp)
     e54:	e0a6                	sd	s1,64(sp)
     e56:	0880                	addi	s0,sp,80
     e58:	84aa                	mv	s1,a0
    struct thread *thread_with_smallest_id = NULL;
     e5a:	fe043423          	sd	zero,-24(s0)
    struct thread *th = NULL;
     e5e:	fe043023          	sd	zero,-32(s0)
    list_for_each_entry(th, args.run_queue, thread_list) {
     e62:	649c                	ld	a5,8(s1)
     e64:	639c                	ld	a5,0(a5)
     e66:	fcf43c23          	sd	a5,-40(s0)
     e6a:	fd843783          	ld	a5,-40(s0)
     e6e:	fd878793          	addi	a5,a5,-40
     e72:	fef43023          	sd	a5,-32(s0)
     e76:	a81d                	j	eac <schedule_default+0x5c>
        if (thread_with_smallest_id == NULL || th->ID < thread_with_smallest_id->ID) {
     e78:	fe843783          	ld	a5,-24(s0)
     e7c:	cb89                	beqz	a5,e8e <schedule_default+0x3e>
     e7e:	fe043783          	ld	a5,-32(s0)
     e82:	5398                	lw	a4,32(a5)
     e84:	fe843783          	ld	a5,-24(s0)
     e88:	539c                	lw	a5,32(a5)
     e8a:	00f75663          	bge	a4,a5,e96 <schedule_default+0x46>
            thread_with_smallest_id = th;
     e8e:	fe043783          	ld	a5,-32(s0)
     e92:	fef43423          	sd	a5,-24(s0)
    list_for_each_entry(th, args.run_queue, thread_list) {
     e96:	fe043783          	ld	a5,-32(s0)
     e9a:	779c                	ld	a5,40(a5)
     e9c:	fcf43823          	sd	a5,-48(s0)
     ea0:	fd043783          	ld	a5,-48(s0)
     ea4:	fd878793          	addi	a5,a5,-40
     ea8:	fef43023          	sd	a5,-32(s0)
     eac:	fe043783          	ld	a5,-32(s0)
     eb0:	02878713          	addi	a4,a5,40
     eb4:	649c                	ld	a5,8(s1)
     eb6:	fcf711e3          	bne	a4,a5,e78 <schedule_default+0x28>
        }
    }

    struct threads_sched_result r;
    if (thread_with_smallest_id != NULL) {
     eba:	fe843783          	ld	a5,-24(s0)
     ebe:	cf89                	beqz	a5,ed8 <schedule_default+0x88>
        r.scheduled_thread_list_member = &thread_with_smallest_id->thread_list;
     ec0:	fe843783          	ld	a5,-24(s0)
     ec4:	02878793          	addi	a5,a5,40
     ec8:	faf43823          	sd	a5,-80(s0)
        r.allocated_time = thread_with_smallest_id->remaining_time;
     ecc:	fe843783          	ld	a5,-24(s0)
     ed0:	47fc                	lw	a5,76(a5)
     ed2:	faf42c23          	sw	a5,-72(s0)
     ed6:	a039                	j	ee4 <schedule_default+0x94>
    } else {
        r.scheduled_thread_list_member = args.run_queue;
     ed8:	649c                	ld	a5,8(s1)
     eda:	faf43823          	sd	a5,-80(s0)
        r.allocated_time = 1;
     ede:	4785                	li	a5,1
     ee0:	faf42c23          	sw	a5,-72(s0)
    }

    return r;
     ee4:	fb043783          	ld	a5,-80(s0)
     ee8:	fcf43023          	sd	a5,-64(s0)
     eec:	fb843783          	ld	a5,-72(s0)
     ef0:	fcf43423          	sd	a5,-56(s0)
     ef4:	fc043703          	ld	a4,-64(s0)
     ef8:	fc843783          	ld	a5,-56(s0)
     efc:	863a                	mv	a2,a4
     efe:	86be                	mv	a3,a5
     f00:	8732                	mv	a4,a2
     f02:	87b6                	mv	a5,a3
}
     f04:	853a                	mv	a0,a4
     f06:	85be                	mv	a1,a5
     f08:	6426                	ld	s0,72(sp)
     f0a:	6486                	ld	s1,64(sp)
     f0c:	6161                	addi	sp,sp,80
     f0e:	8082                	ret

0000000000000f10 <schedule_edf>:

/* Earliest-Deadline-First scheduling */
struct threads_sched_result schedule_edf(struct threads_sched_args args)
{
     f10:	7115                	addi	sp,sp,-224
     f12:	ed86                	sd	ra,216(sp)
     f14:	e9a2                	sd	s0,208(sp)
     f16:	e5a6                	sd	s1,200(sp)
     f18:	e1ca                	sd	s2,192(sp)
     f1a:	fd4e                	sd	s3,184(sp)
     f1c:	1180                	addi	s0,sp,224
     f1e:	84aa                	mv	s1,a0
    // the scheduling is called when a interrupt event happens (either a fn end or a new one is added)
    // need to determine the next thread to execute and the allocated time.

    struct threads_sched_result r;
    if(list_empty(args.run_queue)){
     f20:	649c                	ld	a5,8(s1)
     f22:	853e                	mv	a0,a5
     f24:	00000097          	auipc	ra,0x0
     f28:	f02080e7          	jalr	-254(ra) # e26 <list_empty>
     f2c:	87aa                	mv	a5,a0
     f2e:	c3d1                	beqz	a5,fb2 <schedule_edf+0xa2>
        // SPEC 3
        r.scheduled_thread_list_member = args.run_queue;
     f30:	649c                	ld	a5,8(s1)
     f32:	f2f43423          	sd	a5,-216(s0)
        int least_release_time = 99999;
     f36:	67e1                	lui	a5,0x18
     f38:	69f78793          	addi	a5,a5,1695 # 1869f <__global_pointer$+0x16847>
     f3c:	fcf42623          	sw	a5,-52(s0)
        struct release_queue_entry* cur;
        list_for_each_entry(cur, args.release_queue, thread_list) {
     f40:	689c                	ld	a5,16(s1)
     f42:	639c                	ld	a5,0(a5)
     f44:	f4f43823          	sd	a5,-176(s0)
     f48:	f5043783          	ld	a5,-176(s0)
     f4c:	17e1                	addi	a5,a5,-8
     f4e:	fcf43023          	sd	a5,-64(s0)
     f52:	a805                	j	f82 <schedule_edf+0x72>
            if(cur->release_time<least_release_time){
     f54:	fc043783          	ld	a5,-64(s0)
     f58:	4f98                	lw	a4,24(a5)
     f5a:	fcc42783          	lw	a5,-52(s0)
     f5e:	2781                	sext.w	a5,a5
     f60:	00f75763          	bge	a4,a5,f6e <schedule_edf+0x5e>
                least_release_time = cur->release_time;
     f64:	fc043783          	ld	a5,-64(s0)
     f68:	4f9c                	lw	a5,24(a5)
     f6a:	fcf42623          	sw	a5,-52(s0)
        list_for_each_entry(cur, args.release_queue, thread_list) {
     f6e:	fc043783          	ld	a5,-64(s0)
     f72:	679c                	ld	a5,8(a5)
     f74:	f4f43423          	sd	a5,-184(s0)
     f78:	f4843783          	ld	a5,-184(s0)
     f7c:	17e1                	addi	a5,a5,-8
     f7e:	fcf43023          	sd	a5,-64(s0)
     f82:	fc043783          	ld	a5,-64(s0)
     f86:	00878713          	addi	a4,a5,8
     f8a:	689c                	ld	a5,16(s1)
     f8c:	fcf714e3          	bne	a4,a5,f54 <schedule_edf+0x44>
            }
        }
        r.allocated_time = least_release_time - args.current_time ;
     f90:	409c                	lw	a5,0(s1)
     f92:	fcc42703          	lw	a4,-52(s0)
     f96:	40f707bb          	subw	a5,a4,a5
     f9a:	2781                	sext.w	a5,a5
     f9c:	f2f42823          	sw	a5,-208(s0)
        return r;
     fa0:	f2843783          	ld	a5,-216(s0)
     fa4:	f2f43c23          	sd	a5,-200(s0)
     fa8:	f3043783          	ld	a5,-208(s0)
     fac:	f4f43023          	sd	a5,-192(s0)
     fb0:	a4e5                	j	1298 <schedule_edf+0x388>
    }else{
        // run queue is not empty.
        struct thread *th = NULL;
     fb2:	fa043c23          	sd	zero,-72(s0)
        struct thread *min_th = NULL;
     fb6:	fa043823          	sd	zero,-80(s0)
        struct thread *min_miss_deadline_th = NULL;
     fba:	fa043423          	sd	zero,-88(s0)
        list_for_each_entry(th, args.run_queue, thread_list) {
     fbe:	649c                	ld	a5,8(s1)
     fc0:	639c                	ld	a5,0(a5)
     fc2:	f8f43423          	sd	a5,-120(s0)
     fc6:	f8843783          	ld	a5,-120(s0)
     fca:	fd878793          	addi	a5,a5,-40
     fce:	faf43c23          	sd	a5,-72(s0)
     fd2:	a849                	j	1064 <schedule_edf+0x154>
            // printf("in run queue: %d\n", th->ID);
            if(th->current_deadline <= args.current_time){
     fd4:	fb843783          	ld	a5,-72(s0)
     fd8:	4bb8                	lw	a4,80(a5)
     fda:	409c                	lw	a5,0(s1)
     fdc:	02e7c163          	blt	a5,a4,ffe <schedule_edf+0xee>
                if(min_miss_deadline_th == NULL || th->ID<min_miss_deadline_th->ID){
     fe0:	fa843783          	ld	a5,-88(s0)
     fe4:	cb89                	beqz	a5,ff6 <schedule_edf+0xe6>
     fe6:	fb843783          	ld	a5,-72(s0)
     fea:	5398                	lw	a4,32(a5)
     fec:	fa843783          	ld	a5,-88(s0)
     ff0:	539c                	lw	a5,32(a5)
     ff2:	00f75663          	bge	a4,a5,ffe <schedule_edf+0xee>
                    min_miss_deadline_th = th;
     ff6:	fb843783          	ld	a5,-72(s0)
     ffa:	faf43423          	sd	a5,-88(s0)
                }
            }
            if(min_th == NULL) min_th = th;
     ffe:	fb043783          	ld	a5,-80(s0)
    1002:	e789                	bnez	a5,100c <schedule_edf+0xfc>
    1004:	fb843783          	ld	a5,-72(s0)
    1008:	faf43823          	sd	a5,-80(s0)
            if(th->current_deadline<min_th->current_deadline){
    100c:	fb843783          	ld	a5,-72(s0)
    1010:	4bb8                	lw	a4,80(a5)
    1012:	fb043783          	ld	a5,-80(s0)
    1016:	4bbc                	lw	a5,80(a5)
    1018:	00f75763          	bge	a4,a5,1026 <schedule_edf+0x116>
                min_th = th;
    101c:	fb843783          	ld	a5,-72(s0)
    1020:	faf43823          	sd	a5,-80(s0)
    1024:	a02d                	j	104e <schedule_edf+0x13e>
            }else if(th->current_deadline == min_th->current_deadline){
    1026:	fb843783          	ld	a5,-72(s0)
    102a:	4bb8                	lw	a4,80(a5)
    102c:	fb043783          	ld	a5,-80(s0)
    1030:	4bbc                	lw	a5,80(a5)
    1032:	00f71e63          	bne	a4,a5,104e <schedule_edf+0x13e>
                if(th->ID<min_th->ID) min_th = th;
    1036:	fb843783          	ld	a5,-72(s0)
    103a:	5398                	lw	a4,32(a5)
    103c:	fb043783          	ld	a5,-80(s0)
    1040:	539c                	lw	a5,32(a5)
    1042:	00f75663          	bge	a4,a5,104e <schedule_edf+0x13e>
    1046:	fb843783          	ld	a5,-72(s0)
    104a:	faf43823          	sd	a5,-80(s0)
        list_for_each_entry(th, args.run_queue, thread_list) {
    104e:	fb843783          	ld	a5,-72(s0)
    1052:	779c                	ld	a5,40(a5)
    1054:	f4f43c23          	sd	a5,-168(s0)
    1058:	f5843783          	ld	a5,-168(s0)
    105c:	fd878793          	addi	a5,a5,-40
    1060:	faf43c23          	sd	a5,-72(s0)
    1064:	fb843783          	ld	a5,-72(s0)
    1068:	02878713          	addi	a4,a5,40
    106c:	649c                	ld	a5,8(s1)
    106e:	f6f713e3          	bne	a4,a5,fd4 <schedule_edf+0xc4>
            }
        }

        if(min_miss_deadline_th != NULL) {
    1072:	fa843783          	ld	a5,-88(s0)
    1076:	c395                	beqz	a5,109a <schedule_edf+0x18a>
            // SPEC 4: exist missed deadline
            // printf("exist missed deadline", th->ID);
            r.allocated_time = 0;
    1078:	f2042823          	sw	zero,-208(s0)
            r.scheduled_thread_list_member = &min_miss_deadline_th->thread_list;
    107c:	fa843783          	ld	a5,-88(s0)
    1080:	02878793          	addi	a5,a5,40
    1084:	f2f43423          	sd	a5,-216(s0)
            return r;
    1088:	f2843783          	ld	a5,-216(s0)
    108c:	f2f43c23          	sd	a5,-200(s0)
    1090:	f3043783          	ld	a5,-208(s0)
    1094:	f4f43023          	sd	a5,-192(s0)
    1098:	a401                	j	1298 <schedule_edf+0x388>
             // compute allocated time: 
            // 1. a preemption can happen in the future.(need to inspect the release queue)
            // 2. current deadline is met (preemption has not happened)
            // 3. current deadline is missed (current_time + remaining_time > current_deadline)
            // compute the first event that will happen.
            r.scheduled_thread_list_member = &min_th->thread_list;
    109a:	fb043783          	ld	a5,-80(s0)
    109e:	02878793          	addi	a5,a5,40
    10a2:	f2f43423          	sd	a5,-216(s0)

            struct release_queue_entry* cur;
            if(list_empty(args.release_queue)){
    10a6:	689c                	ld	a5,16(s1)
    10a8:	853e                	mv	a0,a5
    10aa:	00000097          	auipc	ra,0x0
    10ae:	d7c080e7          	jalr	-644(ra) # e26 <list_empty>
    10b2:	87aa                	mv	a5,a0
    10b4:	c3b5                	beqz	a5,1118 <schedule_edf+0x208>
                // printf("release queue is empty\n");
                // a preemption cannot happen, because we've already selected the highest priority thread.
                int remaining_time = 99999;
    10b6:	67e1                	lui	a5,0x18
    10b8:	69f78793          	addi	a5,a5,1695 # 1869f <__global_pointer$+0x16847>
    10bc:	f6f42623          	sw	a5,-148(s0)

                int deadline_time = min_th->current_deadline - args.current_time;
    10c0:	fb043783          	ld	a5,-80(s0)
    10c4:	4bb8                	lw	a4,80(a5)
    10c6:	409c                	lw	a5,0(s1)
    10c8:	40f707bb          	subw	a5,a4,a5
    10cc:	f6f42423          	sw	a5,-152(s0)
                remaining_time = deadline_time<remaining_time? deadline_time: remaining_time;
    10d0:	f6842603          	lw	a2,-152(s0)
    10d4:	f6c42783          	lw	a5,-148(s0)
    10d8:	0007869b          	sext.w	a3,a5
    10dc:	0006071b          	sext.w	a4,a2
    10e0:	00d75363          	bge	a4,a3,10e6 <schedule_edf+0x1d6>
    10e4:	87b2                	mv	a5,a2
    10e6:	f6f42623          	sw	a5,-148(s0)
                int met_time = min_th->remaining_time;
    10ea:	fb043783          	ld	a5,-80(s0)
    10ee:	47fc                	lw	a5,76(a5)
    10f0:	f6f42223          	sw	a5,-156(s0)
                remaining_time = met_time<remaining_time? met_time: remaining_time;
    10f4:	f6442603          	lw	a2,-156(s0)
    10f8:	f6c42783          	lw	a5,-148(s0)
    10fc:	0007869b          	sext.w	a3,a5
    1100:	0006071b          	sext.w	a4,a2
    1104:	00d75363          	bge	a4,a3,110a <schedule_edf+0x1fa>
    1108:	87b2                	mv	a5,a2
    110a:	f6f42623          	sw	a5,-148(s0)
                r.allocated_time = remaining_time;
    110e:	f6c42783          	lw	a5,-148(s0)
    1112:	f2f42823          	sw	a5,-208(s0)
    1116:	aa8d                	j	1288 <schedule_edf+0x378>
            }else{
                // first check if a preemption can happen
                struct release_queue_entry* cur_min = NULL;
    1118:	f8043c23          	sd	zero,-104(s0)
                int remaining_time = 99999;
    111c:	67e1                	lui	a5,0x18
    111e:	69f78793          	addi	a5,a5,1695 # 1869f <__global_pointer$+0x16847>
    1122:	f8f42a23          	sw	a5,-108(s0)
                list_for_each_entry(cur, args.release_queue, thread_list) {
    1126:	689c                	ld	a5,16(s1)
    1128:	639c                	ld	a5,0(a5)
    112a:	f8f43023          	sd	a5,-128(s0)
    112e:	f8043783          	ld	a5,-128(s0)
    1132:	17e1                	addi	a5,a5,-8
    1134:	faf43023          	sd	a5,-96(s0)
    1138:	a8d9                	j	120e <schedule_edf+0x2fe>
                    if((cur->thrd->period + cur->release_time < min_th->current_deadline) && cur->thrd->n != 0){
    113a:	fa043783          	ld	a5,-96(s0)
    113e:	639c                	ld	a5,0(a5)
    1140:	43f8                	lw	a4,68(a5)
    1142:	fa043783          	ld	a5,-96(s0)
    1146:	4f9c                	lw	a5,24(a5)
    1148:	9fb9                	addw	a5,a5,a4
    114a:	0007871b          	sext.w	a4,a5
    114e:	fb043783          	ld	a5,-80(s0)
    1152:	4bbc                	lw	a5,80(a5)
    1154:	0af75363          	bge	a4,a5,11fa <schedule_edf+0x2ea>
    1158:	fa043783          	ld	a5,-96(s0)
    115c:	639c                	ld	a5,0(a5)
    115e:	47bc                	lw	a5,72(a5)
    1160:	cfc9                	beqz	a5,11fa <schedule_edf+0x2ea>
                        // printf("preemption can occur: %d %d %d\n", cur->thrd->period , cur->release_time , min_th->current_deadline);
                        // a preemption can occur
                        if(cur_min == NULL){
    1162:	f9843783          	ld	a5,-104(s0)
    1166:	e791                	bnez	a5,1172 <schedule_edf+0x262>
                            cur_min = cur;
    1168:	fa043783          	ld	a5,-96(s0)
    116c:	f8f43c23          	sd	a5,-104(s0)
    1170:	a069                	j	11fa <schedule_edf+0x2ea>
                        }else{
                            if((cur->thrd->period + cur->release_time < cur_min->thrd->period + cur_min->release_time)&& cur->thrd->n != 0){
    1172:	fa043783          	ld	a5,-96(s0)
    1176:	639c                	ld	a5,0(a5)
    1178:	43f8                	lw	a4,68(a5)
    117a:	fa043783          	ld	a5,-96(s0)
    117e:	4f9c                	lw	a5,24(a5)
    1180:	9fb9                	addw	a5,a5,a4
    1182:	0007869b          	sext.w	a3,a5
    1186:	f9843783          	ld	a5,-104(s0)
    118a:	639c                	ld	a5,0(a5)
    118c:	43f8                	lw	a4,68(a5)
    118e:	f9843783          	ld	a5,-104(s0)
    1192:	4f9c                	lw	a5,24(a5)
    1194:	9fb9                	addw	a5,a5,a4
    1196:	2781                	sext.w	a5,a5
    1198:	8736                	mv	a4,a3
    119a:	00f75c63          	bge	a4,a5,11b2 <schedule_edf+0x2a2>
    119e:	fa043783          	ld	a5,-96(s0)
    11a2:	639c                	ld	a5,0(a5)
    11a4:	47bc                	lw	a5,72(a5)
    11a6:	c791                	beqz	a5,11b2 <schedule_edf+0x2a2>
                                cur_min = cur;
    11a8:	fa043783          	ld	a5,-96(s0)
    11ac:	f8f43c23          	sd	a5,-104(s0)
    11b0:	a0a9                	j	11fa <schedule_edf+0x2ea>
                            }else if(cur->thrd->period + cur->release_time == cur_min->thrd->period + cur_min->release_time){
    11b2:	fa043783          	ld	a5,-96(s0)
    11b6:	639c                	ld	a5,0(a5)
    11b8:	43f8                	lw	a4,68(a5)
    11ba:	fa043783          	ld	a5,-96(s0)
    11be:	4f9c                	lw	a5,24(a5)
    11c0:	9fb9                	addw	a5,a5,a4
    11c2:	0007869b          	sext.w	a3,a5
    11c6:	f9843783          	ld	a5,-104(s0)
    11ca:	639c                	ld	a5,0(a5)
    11cc:	43f8                	lw	a4,68(a5)
    11ce:	f9843783          	ld	a5,-104(s0)
    11d2:	4f9c                	lw	a5,24(a5)
    11d4:	9fb9                	addw	a5,a5,a4
    11d6:	2781                	sext.w	a5,a5
    11d8:	8736                	mv	a4,a3
    11da:	02f71063          	bne	a4,a5,11fa <schedule_edf+0x2ea>
                                if(cur_min->thrd->ID > cur->thrd->ID){
    11de:	f9843783          	ld	a5,-104(s0)
    11e2:	639c                	ld	a5,0(a5)
    11e4:	5398                	lw	a4,32(a5)
    11e6:	fa043783          	ld	a5,-96(s0)
    11ea:	639c                	ld	a5,0(a5)
    11ec:	539c                	lw	a5,32(a5)
    11ee:	00e7d663          	bge	a5,a4,11fa <schedule_edf+0x2ea>
                                    cur_min = cur;
    11f2:	fa043783          	ld	a5,-96(s0)
    11f6:	f8f43c23          	sd	a5,-104(s0)
                list_for_each_entry(cur, args.release_queue, thread_list) {
    11fa:	fa043783          	ld	a5,-96(s0)
    11fe:	679c                	ld	a5,8(a5)
    1200:	f6f43823          	sd	a5,-144(s0)
    1204:	f7043783          	ld	a5,-144(s0)
    1208:	17e1                	addi	a5,a5,-8
    120a:	faf43023          	sd	a5,-96(s0)
    120e:	fa043783          	ld	a5,-96(s0)
    1212:	00878713          	addi	a4,a5,8
    1216:	689c                	ld	a5,16(s1)
    1218:	f2f711e3          	bne	a4,a5,113a <schedule_edf+0x22a>
                                }
                            }
                        }
                    }
                }
                if(cur_min != NULL){
    121c:	f9843783          	ld	a5,-104(s0)
    1220:	cb89                	beqz	a5,1232 <schedule_edf+0x322>
                    // a preemption is possible
                    remaining_time = cur_min->release_time - args.current_time;
    1222:	f9843783          	ld	a5,-104(s0)
    1226:	4f98                	lw	a4,24(a5)
    1228:	409c                	lw	a5,0(s1)
    122a:	40f707bb          	subw	a5,a4,a5
    122e:	f8f42a23          	sw	a5,-108(s0)
                }
                int deadline_time = min_th->current_deadline - args.current_time;
    1232:	fb043783          	ld	a5,-80(s0)
    1236:	4bb8                	lw	a4,80(a5)
    1238:	409c                	lw	a5,0(s1)
    123a:	40f707bb          	subw	a5,a4,a5
    123e:	f6f42e23          	sw	a5,-132(s0)
                remaining_time = deadline_time<remaining_time? deadline_time: remaining_time;
    1242:	f7c42603          	lw	a2,-132(s0)
    1246:	f9442783          	lw	a5,-108(s0)
    124a:	0007869b          	sext.w	a3,a5
    124e:	0006071b          	sext.w	a4,a2
    1252:	00d75363          	bge	a4,a3,1258 <schedule_edf+0x348>
    1256:	87b2                	mv	a5,a2
    1258:	f8f42a23          	sw	a5,-108(s0)
                int met_time = min_th->remaining_time;
    125c:	fb043783          	ld	a5,-80(s0)
    1260:	47fc                	lw	a5,76(a5)
    1262:	f6f42c23          	sw	a5,-136(s0)
                remaining_time = met_time<remaining_time? met_time: remaining_time;
    1266:	f7842603          	lw	a2,-136(s0)
    126a:	f9442783          	lw	a5,-108(s0)
    126e:	0007869b          	sext.w	a3,a5
    1272:	0006071b          	sext.w	a4,a2
    1276:	00d75363          	bge	a4,a3,127c <schedule_edf+0x36c>
    127a:	87b2                	mv	a5,a2
    127c:	f8f42a23          	sw	a5,-108(s0)
                r.allocated_time = remaining_time;
    1280:	f9442783          	lw	a5,-108(s0)
    1284:	f2f42823          	sw	a5,-208(s0)
            }

            return r;
    1288:	f2843783          	ld	a5,-216(s0)
    128c:	f2f43c23          	sd	a5,-200(s0)
    1290:	f3043783          	ld	a5,-208(s0)
    1294:	f4f43023          	sd	a5,-192(s0)
        }
    }

    return schedule_default(args);
}
    1298:	f3843703          	ld	a4,-200(s0)
    129c:	f4043783          	ld	a5,-192(s0)
    12a0:	893a                	mv	s2,a4
    12a2:	89be                	mv	s3,a5
    12a4:	874a                	mv	a4,s2
    12a6:	87ce                	mv	a5,s3
    12a8:	853a                	mv	a0,a4
    12aa:	85be                	mv	a1,a5
    12ac:	60ee                	ld	ra,216(sp)
    12ae:	644e                	ld	s0,208(sp)
    12b0:	64ae                	ld	s1,200(sp)
    12b2:	690e                	ld	s2,192(sp)
    12b4:	79ea                	ld	s3,184(sp)
    12b6:	612d                	addi	sp,sp,224
    12b8:	8082                	ret

00000000000012ba <schedule_rm>:

/* Rate-Monotonic Scheduling */
struct threads_sched_result schedule_rm(struct threads_sched_args args)
{
    12ba:	7115                	addi	sp,sp,-224
    12bc:	ed86                	sd	ra,216(sp)
    12be:	e9a2                	sd	s0,208(sp)
    12c0:	e5a6                	sd	s1,200(sp)
    12c2:	e1ca                	sd	s2,192(sp)
    12c4:	fd4e                	sd	s3,184(sp)
    12c6:	1180                	addi	s0,sp,224
    12c8:	84aa                	mv	s1,a0
    
    struct threads_sched_result r;
    if(list_empty(args.run_queue)){
    12ca:	649c                	ld	a5,8(s1)
    12cc:	853e                	mv	a0,a5
    12ce:	00000097          	auipc	ra,0x0
    12d2:	b58080e7          	jalr	-1192(ra) # e26 <list_empty>
    12d6:	87aa                	mv	a5,a0
    12d8:	c3d1                	beqz	a5,135c <schedule_rm+0xa2>
        // SPEC 3
        r.scheduled_thread_list_member = args.run_queue;
    12da:	649c                	ld	a5,8(s1)
    12dc:	f2f43423          	sd	a5,-216(s0)
        int least_release_time = 99999;
    12e0:	67e1                	lui	a5,0x18
    12e2:	69f78793          	addi	a5,a5,1695 # 1869f <__global_pointer$+0x16847>
    12e6:	fcf42623          	sw	a5,-52(s0)
        struct release_queue_entry* cur;
        list_for_each_entry(cur, args.release_queue, thread_list) {
    12ea:	689c                	ld	a5,16(s1)
    12ec:	639c                	ld	a5,0(a5)
    12ee:	f4f43823          	sd	a5,-176(s0)
    12f2:	f5043783          	ld	a5,-176(s0)
    12f6:	17e1                	addi	a5,a5,-8
    12f8:	fcf43023          	sd	a5,-64(s0)
    12fc:	a805                	j	132c <schedule_rm+0x72>
            if(cur->release_time<least_release_time){
    12fe:	fc043783          	ld	a5,-64(s0)
    1302:	4f98                	lw	a4,24(a5)
    1304:	fcc42783          	lw	a5,-52(s0)
    1308:	2781                	sext.w	a5,a5
    130a:	00f75763          	bge	a4,a5,1318 <schedule_rm+0x5e>
                least_release_time = cur->release_time;
    130e:	fc043783          	ld	a5,-64(s0)
    1312:	4f9c                	lw	a5,24(a5)
    1314:	fcf42623          	sw	a5,-52(s0)
        list_for_each_entry(cur, args.release_queue, thread_list) {
    1318:	fc043783          	ld	a5,-64(s0)
    131c:	679c                	ld	a5,8(a5)
    131e:	f4f43423          	sd	a5,-184(s0)
    1322:	f4843783          	ld	a5,-184(s0)
    1326:	17e1                	addi	a5,a5,-8
    1328:	fcf43023          	sd	a5,-64(s0)
    132c:	fc043783          	ld	a5,-64(s0)
    1330:	00878713          	addi	a4,a5,8
    1334:	689c                	ld	a5,16(s1)
    1336:	fcf714e3          	bne	a4,a5,12fe <schedule_rm+0x44>
            }
        }
        r.allocated_time = least_release_time - args.current_time ;
    133a:	409c                	lw	a5,0(s1)
    133c:	fcc42703          	lw	a4,-52(s0)
    1340:	40f707bb          	subw	a5,a4,a5
    1344:	2781                	sext.w	a5,a5
    1346:	f2f42823          	sw	a5,-208(s0)
        return r;
    134a:	f2843783          	ld	a5,-216(s0)
    134e:	f2f43c23          	sd	a5,-200(s0)
    1352:	f3043783          	ld	a5,-208(s0)
    1356:	f4f43023          	sd	a5,-192(s0)
    135a:	ac61                	j	15f2 <schedule_rm+0x338>
    }else{
        // run queue is not empty.
        struct thread *th = NULL;
    135c:	fa043c23          	sd	zero,-72(s0)
        struct thread *min_th = NULL;
    1360:	fa043823          	sd	zero,-80(s0)
        struct thread *min_miss_deadline_th = NULL;
    1364:	fa043423          	sd	zero,-88(s0)
        list_for_each_entry(th, args.run_queue, thread_list) {
    1368:	649c                	ld	a5,8(s1)
    136a:	639c                	ld	a5,0(a5)
    136c:	f8f43423          	sd	a5,-120(s0)
    1370:	f8843783          	ld	a5,-120(s0)
    1374:	fd878793          	addi	a5,a5,-40
    1378:	faf43c23          	sd	a5,-72(s0)
    137c:	a849                	j	140e <schedule_rm+0x154>
            if(th->current_deadline <= args.current_time){
    137e:	fb843783          	ld	a5,-72(s0)
    1382:	4bb8                	lw	a4,80(a5)
    1384:	409c                	lw	a5,0(s1)
    1386:	02e7c163          	blt	a5,a4,13a8 <schedule_rm+0xee>
                if(min_miss_deadline_th == NULL || th->ID<min_miss_deadline_th->ID){
    138a:	fa843783          	ld	a5,-88(s0)
    138e:	cb89                	beqz	a5,13a0 <schedule_rm+0xe6>
    1390:	fb843783          	ld	a5,-72(s0)
    1394:	5398                	lw	a4,32(a5)
    1396:	fa843783          	ld	a5,-88(s0)
    139a:	539c                	lw	a5,32(a5)
    139c:	00f75663          	bge	a4,a5,13a8 <schedule_rm+0xee>
                    min_miss_deadline_th = th;
    13a0:	fb843783          	ld	a5,-72(s0)
    13a4:	faf43423          	sd	a5,-88(s0)
                }
            }
            if(min_th == NULL) min_th = th;
    13a8:	fb043783          	ld	a5,-80(s0)
    13ac:	e789                	bnez	a5,13b6 <schedule_rm+0xfc>
    13ae:	fb843783          	ld	a5,-72(s0)
    13b2:	faf43823          	sd	a5,-80(s0)
            if(th->period<min_th->period){
    13b6:	fb843783          	ld	a5,-72(s0)
    13ba:	43f8                	lw	a4,68(a5)
    13bc:	fb043783          	ld	a5,-80(s0)
    13c0:	43fc                	lw	a5,68(a5)
    13c2:	00f75763          	bge	a4,a5,13d0 <schedule_rm+0x116>
                min_th = th;
    13c6:	fb843783          	ld	a5,-72(s0)
    13ca:	faf43823          	sd	a5,-80(s0)
    13ce:	a02d                	j	13f8 <schedule_rm+0x13e>
            }else if(th->period == min_th->period){
    13d0:	fb843783          	ld	a5,-72(s0)
    13d4:	43f8                	lw	a4,68(a5)
    13d6:	fb043783          	ld	a5,-80(s0)
    13da:	43fc                	lw	a5,68(a5)
    13dc:	00f71e63          	bne	a4,a5,13f8 <schedule_rm+0x13e>
                if(th->ID<min_th->ID) min_th = th;
    13e0:	fb843783          	ld	a5,-72(s0)
    13e4:	5398                	lw	a4,32(a5)
    13e6:	fb043783          	ld	a5,-80(s0)
    13ea:	539c                	lw	a5,32(a5)
    13ec:	00f75663          	bge	a4,a5,13f8 <schedule_rm+0x13e>
    13f0:	fb843783          	ld	a5,-72(s0)
    13f4:	faf43823          	sd	a5,-80(s0)
        list_for_each_entry(th, args.run_queue, thread_list) {
    13f8:	fb843783          	ld	a5,-72(s0)
    13fc:	779c                	ld	a5,40(a5)
    13fe:	f4f43c23          	sd	a5,-168(s0)
    1402:	f5843783          	ld	a5,-168(s0)
    1406:	fd878793          	addi	a5,a5,-40
    140a:	faf43c23          	sd	a5,-72(s0)
    140e:	fb843783          	ld	a5,-72(s0)
    1412:	02878713          	addi	a4,a5,40
    1416:	649c                	ld	a5,8(s1)
    1418:	f6f713e3          	bne	a4,a5,137e <schedule_rm+0xc4>
            }
        }

        if(min_miss_deadline_th != NULL) {
    141c:	fa843783          	ld	a5,-88(s0)
    1420:	c395                	beqz	a5,1444 <schedule_rm+0x18a>
            // SPEC 4: exist missed deadline
            r.allocated_time = 0;
    1422:	f2042823          	sw	zero,-208(s0)
            r.scheduled_thread_list_member = &min_miss_deadline_th->thread_list;
    1426:	fa843783          	ld	a5,-88(s0)
    142a:	02878793          	addi	a5,a5,40
    142e:	f2f43423          	sd	a5,-216(s0)
            return r;
    1432:	f2843783          	ld	a5,-216(s0)
    1436:	f2f43c23          	sd	a5,-200(s0)
    143a:	f3043783          	ld	a5,-208(s0)
    143e:	f4f43023          	sd	a5,-192(s0)
    1442:	aa45                	j	15f2 <schedule_rm+0x338>
             // compute allocated time: 
            // 1. a preemption can happen in the future.(need to inspect the release queue)
            // 2. current deadline is met (preemption has not happened)
            // 3. current deadline is missed (current_time + remaining_time > current_deadline)
            // compute the first event that will happen.
            r.scheduled_thread_list_member = &min_th->thread_list;
    1444:	fb043783          	ld	a5,-80(s0)
    1448:	02878793          	addi	a5,a5,40
    144c:	f2f43423          	sd	a5,-216(s0)

            struct release_queue_entry* cur;
            if(list_empty(args.release_queue)){
    1450:	689c                	ld	a5,16(s1)
    1452:	853e                	mv	a0,a5
    1454:	00000097          	auipc	ra,0x0
    1458:	9d2080e7          	jalr	-1582(ra) # e26 <list_empty>
    145c:	87aa                	mv	a5,a0
    145e:	c3b5                	beqz	a5,14c2 <schedule_rm+0x208>
                // a preemption cannot happen, because we've already selected the highest priority thread.
                int remaining_time = 99999;
    1460:	67e1                	lui	a5,0x18
    1462:	69f78793          	addi	a5,a5,1695 # 1869f <__global_pointer$+0x16847>
    1466:	f6f42623          	sw	a5,-148(s0)

                int deadline_time = min_th->current_deadline - args.current_time;
    146a:	fb043783          	ld	a5,-80(s0)
    146e:	4bb8                	lw	a4,80(a5)
    1470:	409c                	lw	a5,0(s1)
    1472:	40f707bb          	subw	a5,a4,a5
    1476:	f6f42423          	sw	a5,-152(s0)
                remaining_time = deadline_time<remaining_time? deadline_time: remaining_time;
    147a:	f6842603          	lw	a2,-152(s0)
    147e:	f6c42783          	lw	a5,-148(s0)
    1482:	0007869b          	sext.w	a3,a5
    1486:	0006071b          	sext.w	a4,a2
    148a:	00d75363          	bge	a4,a3,1490 <schedule_rm+0x1d6>
    148e:	87b2                	mv	a5,a2
    1490:	f6f42623          	sw	a5,-148(s0)
                int met_time = min_th->remaining_time;
    1494:	fb043783          	ld	a5,-80(s0)
    1498:	47fc                	lw	a5,76(a5)
    149a:	f6f42223          	sw	a5,-156(s0)
                remaining_time = met_time<remaining_time? met_time: remaining_time;
    149e:	f6442603          	lw	a2,-156(s0)
    14a2:	f6c42783          	lw	a5,-148(s0)
    14a6:	0007869b          	sext.w	a3,a5
    14aa:	0006071b          	sext.w	a4,a2
    14ae:	00d75363          	bge	a4,a3,14b4 <schedule_rm+0x1fa>
    14b2:	87b2                	mv	a5,a2
    14b4:	f6f42623          	sw	a5,-148(s0)
                
                r.allocated_time = remaining_time;
    14b8:	f6c42783          	lw	a5,-148(s0)
    14bc:	f2f42823          	sw	a5,-208(s0)
    14c0:	a20d                	j	15e2 <schedule_rm+0x328>
            }else{
                // first check if a preemption can happen
                struct release_queue_entry* cur_min = NULL;
    14c2:	f8043c23          	sd	zero,-104(s0)
                int remaining_time = 99999;
    14c6:	67e1                	lui	a5,0x18
    14c8:	69f78793          	addi	a5,a5,1695 # 1869f <__global_pointer$+0x16847>
    14cc:	f8f42a23          	sw	a5,-108(s0)
                list_for_each_entry(cur, args.release_queue, thread_list) {
    14d0:	689c                	ld	a5,16(s1)
    14d2:	639c                	ld	a5,0(a5)
    14d4:	f8f43023          	sd	a5,-128(s0)
    14d8:	f8043783          	ld	a5,-128(s0)
    14dc:	17e1                	addi	a5,a5,-8
    14de:	faf43023          	sd	a5,-96(s0)
    14e2:	a059                	j	1568 <schedule_rm+0x2ae>
                    if(cur->thrd->period<min_th->period){
    14e4:	fa043783          	ld	a5,-96(s0)
    14e8:	639c                	ld	a5,0(a5)
    14ea:	43f8                	lw	a4,68(a5)
    14ec:	fb043783          	ld	a5,-80(s0)
    14f0:	43fc                	lw	a5,68(a5)
    14f2:	06f75163          	bge	a4,a5,1554 <schedule_rm+0x29a>
                        // a preemption can occur
                        if(cur_min == NULL){
    14f6:	f9843783          	ld	a5,-104(s0)
    14fa:	e791                	bnez	a5,1506 <schedule_rm+0x24c>
                            cur_min = cur;
    14fc:	fa043783          	ld	a5,-96(s0)
    1500:	f8f43c23          	sd	a5,-104(s0)
    1504:	a881                	j	1554 <schedule_rm+0x29a>
                        }else{
                            if(cur_min->thrd->period>cur->thrd->period){
    1506:	f9843783          	ld	a5,-104(s0)
    150a:	639c                	ld	a5,0(a5)
    150c:	43f8                	lw	a4,68(a5)
    150e:	fa043783          	ld	a5,-96(s0)
    1512:	639c                	ld	a5,0(a5)
    1514:	43fc                	lw	a5,68(a5)
    1516:	00e7d763          	bge	a5,a4,1524 <schedule_rm+0x26a>
                                cur_min = cur;
    151a:	fa043783          	ld	a5,-96(s0)
    151e:	f8f43c23          	sd	a5,-104(s0)
    1522:	a80d                	j	1554 <schedule_rm+0x29a>
                            }else if(cur_min->thrd->period == cur->thrd->period){
    1524:	f9843783          	ld	a5,-104(s0)
    1528:	639c                	ld	a5,0(a5)
    152a:	43f8                	lw	a4,68(a5)
    152c:	fa043783          	ld	a5,-96(s0)
    1530:	639c                	ld	a5,0(a5)
    1532:	43fc                	lw	a5,68(a5)
    1534:	02f71063          	bne	a4,a5,1554 <schedule_rm+0x29a>
                                if(cur_min->thrd->ID > cur->thrd->ID){
    1538:	f9843783          	ld	a5,-104(s0)
    153c:	639c                	ld	a5,0(a5)
    153e:	5398                	lw	a4,32(a5)
    1540:	fa043783          	ld	a5,-96(s0)
    1544:	639c                	ld	a5,0(a5)
    1546:	539c                	lw	a5,32(a5)
    1548:	00e7d663          	bge	a5,a4,1554 <schedule_rm+0x29a>
                                    cur_min = cur;
    154c:	fa043783          	ld	a5,-96(s0)
    1550:	f8f43c23          	sd	a5,-104(s0)
                list_for_each_entry(cur, args.release_queue, thread_list) {
    1554:	fa043783          	ld	a5,-96(s0)
    1558:	679c                	ld	a5,8(a5)
    155a:	f6f43823          	sd	a5,-144(s0)
    155e:	f7043783          	ld	a5,-144(s0)
    1562:	17e1                	addi	a5,a5,-8
    1564:	faf43023          	sd	a5,-96(s0)
    1568:	fa043783          	ld	a5,-96(s0)
    156c:	00878713          	addi	a4,a5,8
    1570:	689c                	ld	a5,16(s1)
    1572:	f6f719e3          	bne	a4,a5,14e4 <schedule_rm+0x22a>
                                }
                            }
                        }
                    }
                }
                if(cur_min != NULL){
    1576:	f9843783          	ld	a5,-104(s0)
    157a:	cb89                	beqz	a5,158c <schedule_rm+0x2d2>
                    // a preemption is possible
                    remaining_time = cur_min->release_time - args.current_time;
    157c:	f9843783          	ld	a5,-104(s0)
    1580:	4f98                	lw	a4,24(a5)
    1582:	409c                	lw	a5,0(s1)
    1584:	40f707bb          	subw	a5,a4,a5
    1588:	f8f42a23          	sw	a5,-108(s0)
                }
                int deadline_time = min_th->current_deadline - args.current_time;
    158c:	fb043783          	ld	a5,-80(s0)
    1590:	4bb8                	lw	a4,80(a5)
    1592:	409c                	lw	a5,0(s1)
    1594:	40f707bb          	subw	a5,a4,a5
    1598:	f6f42e23          	sw	a5,-132(s0)
                remaining_time = deadline_time<remaining_time? deadline_time: remaining_time;
    159c:	f7c42603          	lw	a2,-132(s0)
    15a0:	f9442783          	lw	a5,-108(s0)
    15a4:	0007869b          	sext.w	a3,a5
    15a8:	0006071b          	sext.w	a4,a2
    15ac:	00d75363          	bge	a4,a3,15b2 <schedule_rm+0x2f8>
    15b0:	87b2                	mv	a5,a2
    15b2:	f8f42a23          	sw	a5,-108(s0)
                int met_time = min_th->remaining_time;
    15b6:	fb043783          	ld	a5,-80(s0)
    15ba:	47fc                	lw	a5,76(a5)
    15bc:	f6f42c23          	sw	a5,-136(s0)
                remaining_time = met_time<remaining_time? met_time: remaining_time;
    15c0:	f7842603          	lw	a2,-136(s0)
    15c4:	f9442783          	lw	a5,-108(s0)
    15c8:	0007869b          	sext.w	a3,a5
    15cc:	0006071b          	sext.w	a4,a2
    15d0:	00d75363          	bge	a4,a3,15d6 <schedule_rm+0x31c>
    15d4:	87b2                	mv	a5,a2
    15d6:	f8f42a23          	sw	a5,-108(s0)
                
                r.allocated_time = remaining_time;
    15da:	f9442783          	lw	a5,-108(s0)
    15de:	f2f42823          	sw	a5,-208(s0)
            }

            return r;
    15e2:	f2843783          	ld	a5,-216(s0)
    15e6:	f2f43c23          	sd	a5,-200(s0)
    15ea:	f3043783          	ld	a5,-208(s0)
    15ee:	f4f43023          	sd	a5,-192(s0)
        }
    }
}
    15f2:	f3843703          	ld	a4,-200(s0)
    15f6:	f4043783          	ld	a5,-192(s0)
    15fa:	893a                	mv	s2,a4
    15fc:	89be                	mv	s3,a5
    15fe:	874a                	mv	a4,s2
    1600:	87ce                	mv	a5,s3
    1602:	853a                	mv	a0,a4
    1604:	85be                	mv	a1,a5
    1606:	60ee                	ld	ra,216(sp)
    1608:	644e                	ld	s0,208(sp)
    160a:	64ae                	ld	s1,200(sp)
    160c:	690e                	ld	s2,192(sp)
    160e:	79ea                	ld	s3,184(sp)
    1610:	612d                	addi	sp,sp,224
    1612:	8082                	ret
