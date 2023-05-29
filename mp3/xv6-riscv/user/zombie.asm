
user/_zombie:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(void)
{
       0:	1141                	addi	sp,sp,-16
       2:	e406                	sd	ra,8(sp)
       4:	e022                	sd	s0,0(sp)
       6:	0800                	addi	s0,sp,16
  if(fork() > 0)
       8:	00000097          	auipc	ra,0x0
       c:	4aa080e7          	jalr	1194(ra) # 4b2 <fork>
      10:	87aa                	mv	a5,a0
      12:	00f05763          	blez	a5,20 <main+0x20>
    sleep(5);  // Let child exit before parent.
      16:	4515                	li	a0,5
      18:	00000097          	auipc	ra,0x0
      1c:	532080e7          	jalr	1330(ra) # 54a <sleep>
  exit(0);
      20:	4501                	li	a0,0
      22:	00000097          	auipc	ra,0x0
      26:	498080e7          	jalr	1176(ra) # 4ba <exit>

000000000000002a <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
      2a:	7179                	addi	sp,sp,-48
      2c:	f422                	sd	s0,40(sp)
      2e:	1800                	addi	s0,sp,48
      30:	fca43c23          	sd	a0,-40(s0)
      34:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
      38:	fd843783          	ld	a5,-40(s0)
      3c:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
      40:	0001                	nop
      42:	fd043703          	ld	a4,-48(s0)
      46:	00170793          	addi	a5,a4,1
      4a:	fcf43823          	sd	a5,-48(s0)
      4e:	fd843783          	ld	a5,-40(s0)
      52:	00178693          	addi	a3,a5,1
      56:	fcd43c23          	sd	a3,-40(s0)
      5a:	00074703          	lbu	a4,0(a4)
      5e:	00e78023          	sb	a4,0(a5)
      62:	0007c783          	lbu	a5,0(a5)
      66:	fff1                	bnez	a5,42 <strcpy+0x18>
    ;
  return os;
      68:	fe843783          	ld	a5,-24(s0)
}
      6c:	853e                	mv	a0,a5
      6e:	7422                	ld	s0,40(sp)
      70:	6145                	addi	sp,sp,48
      72:	8082                	ret

0000000000000074 <strcmp>:

int
strcmp(const char *p, const char *q)
{
      74:	1101                	addi	sp,sp,-32
      76:	ec22                	sd	s0,24(sp)
      78:	1000                	addi	s0,sp,32
      7a:	fea43423          	sd	a0,-24(s0)
      7e:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
      82:	a819                	j	98 <strcmp+0x24>
    p++, q++;
      84:	fe843783          	ld	a5,-24(s0)
      88:	0785                	addi	a5,a5,1
      8a:	fef43423          	sd	a5,-24(s0)
      8e:	fe043783          	ld	a5,-32(s0)
      92:	0785                	addi	a5,a5,1
      94:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
      98:	fe843783          	ld	a5,-24(s0)
      9c:	0007c783          	lbu	a5,0(a5)
      a0:	cb99                	beqz	a5,b6 <strcmp+0x42>
      a2:	fe843783          	ld	a5,-24(s0)
      a6:	0007c703          	lbu	a4,0(a5)
      aa:	fe043783          	ld	a5,-32(s0)
      ae:	0007c783          	lbu	a5,0(a5)
      b2:	fcf709e3          	beq	a4,a5,84 <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
      b6:	fe843783          	ld	a5,-24(s0)
      ba:	0007c783          	lbu	a5,0(a5)
      be:	0007871b          	sext.w	a4,a5
      c2:	fe043783          	ld	a5,-32(s0)
      c6:	0007c783          	lbu	a5,0(a5)
      ca:	2781                	sext.w	a5,a5
      cc:	40f707bb          	subw	a5,a4,a5
      d0:	2781                	sext.w	a5,a5
}
      d2:	853e                	mv	a0,a5
      d4:	6462                	ld	s0,24(sp)
      d6:	6105                	addi	sp,sp,32
      d8:	8082                	ret

00000000000000da <strlen>:

uint
strlen(const char *s)
{
      da:	7179                	addi	sp,sp,-48
      dc:	f422                	sd	s0,40(sp)
      de:	1800                	addi	s0,sp,48
      e0:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
      e4:	fe042623          	sw	zero,-20(s0)
      e8:	a031                	j	f4 <strlen+0x1a>
      ea:	fec42783          	lw	a5,-20(s0)
      ee:	2785                	addiw	a5,a5,1
      f0:	fef42623          	sw	a5,-20(s0)
      f4:	fec42783          	lw	a5,-20(s0)
      f8:	fd843703          	ld	a4,-40(s0)
      fc:	97ba                	add	a5,a5,a4
      fe:	0007c783          	lbu	a5,0(a5)
     102:	f7e5                	bnez	a5,ea <strlen+0x10>
    ;
  return n;
     104:	fec42783          	lw	a5,-20(s0)
}
     108:	853e                	mv	a0,a5
     10a:	7422                	ld	s0,40(sp)
     10c:	6145                	addi	sp,sp,48
     10e:	8082                	ret

0000000000000110 <memset>:

void*
memset(void *dst, int c, uint n)
{
     110:	7179                	addi	sp,sp,-48
     112:	f422                	sd	s0,40(sp)
     114:	1800                	addi	s0,sp,48
     116:	fca43c23          	sd	a0,-40(s0)
     11a:	87ae                	mv	a5,a1
     11c:	8732                	mv	a4,a2
     11e:	fcf42a23          	sw	a5,-44(s0)
     122:	87ba                	mv	a5,a4
     124:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
     128:	fd843783          	ld	a5,-40(s0)
     12c:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
     130:	fe042623          	sw	zero,-20(s0)
     134:	a00d                	j	156 <memset+0x46>
    cdst[i] = c;
     136:	fec42783          	lw	a5,-20(s0)
     13a:	fe043703          	ld	a4,-32(s0)
     13e:	97ba                	add	a5,a5,a4
     140:	fd442703          	lw	a4,-44(s0)
     144:	0ff77713          	andi	a4,a4,255
     148:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
     14c:	fec42783          	lw	a5,-20(s0)
     150:	2785                	addiw	a5,a5,1
     152:	fef42623          	sw	a5,-20(s0)
     156:	fec42703          	lw	a4,-20(s0)
     15a:	fd042783          	lw	a5,-48(s0)
     15e:	2781                	sext.w	a5,a5
     160:	fcf76be3          	bltu	a4,a5,136 <memset+0x26>
  }
  return dst;
     164:	fd843783          	ld	a5,-40(s0)
}
     168:	853e                	mv	a0,a5
     16a:	7422                	ld	s0,40(sp)
     16c:	6145                	addi	sp,sp,48
     16e:	8082                	ret

0000000000000170 <strchr>:

char*
strchr(const char *s, char c)
{
     170:	1101                	addi	sp,sp,-32
     172:	ec22                	sd	s0,24(sp)
     174:	1000                	addi	s0,sp,32
     176:	fea43423          	sd	a0,-24(s0)
     17a:	87ae                	mv	a5,a1
     17c:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
     180:	a01d                	j	1a6 <strchr+0x36>
    if(*s == c)
     182:	fe843783          	ld	a5,-24(s0)
     186:	0007c703          	lbu	a4,0(a5)
     18a:	fe744783          	lbu	a5,-25(s0)
     18e:	0ff7f793          	andi	a5,a5,255
     192:	00e79563          	bne	a5,a4,19c <strchr+0x2c>
      return (char*)s;
     196:	fe843783          	ld	a5,-24(s0)
     19a:	a821                	j	1b2 <strchr+0x42>
  for(; *s; s++)
     19c:	fe843783          	ld	a5,-24(s0)
     1a0:	0785                	addi	a5,a5,1
     1a2:	fef43423          	sd	a5,-24(s0)
     1a6:	fe843783          	ld	a5,-24(s0)
     1aa:	0007c783          	lbu	a5,0(a5)
     1ae:	fbf1                	bnez	a5,182 <strchr+0x12>
  return 0;
     1b0:	4781                	li	a5,0
}
     1b2:	853e                	mv	a0,a5
     1b4:	6462                	ld	s0,24(sp)
     1b6:	6105                	addi	sp,sp,32
     1b8:	8082                	ret

00000000000001ba <gets>:

char*
gets(char *buf, int max)
{
     1ba:	7179                	addi	sp,sp,-48
     1bc:	f406                	sd	ra,40(sp)
     1be:	f022                	sd	s0,32(sp)
     1c0:	1800                	addi	s0,sp,48
     1c2:	fca43c23          	sd	a0,-40(s0)
     1c6:	87ae                	mv	a5,a1
     1c8:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     1cc:	fe042623          	sw	zero,-20(s0)
     1d0:	a8a1                	j	228 <gets+0x6e>
    cc = read(0, &c, 1);
     1d2:	fe740793          	addi	a5,s0,-25
     1d6:	4605                	li	a2,1
     1d8:	85be                	mv	a1,a5
     1da:	4501                	li	a0,0
     1dc:	00000097          	auipc	ra,0x0
     1e0:	2f6080e7          	jalr	758(ra) # 4d2 <read>
     1e4:	87aa                	mv	a5,a0
     1e6:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
     1ea:	fe842783          	lw	a5,-24(s0)
     1ee:	2781                	sext.w	a5,a5
     1f0:	04f05763          	blez	a5,23e <gets+0x84>
      break;
    buf[i++] = c;
     1f4:	fec42783          	lw	a5,-20(s0)
     1f8:	0017871b          	addiw	a4,a5,1
     1fc:	fee42623          	sw	a4,-20(s0)
     200:	873e                	mv	a4,a5
     202:	fd843783          	ld	a5,-40(s0)
     206:	97ba                	add	a5,a5,a4
     208:	fe744703          	lbu	a4,-25(s0)
     20c:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
     210:	fe744783          	lbu	a5,-25(s0)
     214:	873e                	mv	a4,a5
     216:	47a9                	li	a5,10
     218:	02f70463          	beq	a4,a5,240 <gets+0x86>
     21c:	fe744783          	lbu	a5,-25(s0)
     220:	873e                	mv	a4,a5
     222:	47b5                	li	a5,13
     224:	00f70e63          	beq	a4,a5,240 <gets+0x86>
  for(i=0; i+1 < max; ){
     228:	fec42783          	lw	a5,-20(s0)
     22c:	2785                	addiw	a5,a5,1
     22e:	0007871b          	sext.w	a4,a5
     232:	fd442783          	lw	a5,-44(s0)
     236:	2781                	sext.w	a5,a5
     238:	f8f74de3          	blt	a4,a5,1d2 <gets+0x18>
     23c:	a011                	j	240 <gets+0x86>
      break;
     23e:	0001                	nop
      break;
  }
  buf[i] = '\0';
     240:	fec42783          	lw	a5,-20(s0)
     244:	fd843703          	ld	a4,-40(s0)
     248:	97ba                	add	a5,a5,a4
     24a:	00078023          	sb	zero,0(a5)
  return buf;
     24e:	fd843783          	ld	a5,-40(s0)
}
     252:	853e                	mv	a0,a5
     254:	70a2                	ld	ra,40(sp)
     256:	7402                	ld	s0,32(sp)
     258:	6145                	addi	sp,sp,48
     25a:	8082                	ret

000000000000025c <stat>:

int
stat(const char *n, struct stat *st)
{
     25c:	7179                	addi	sp,sp,-48
     25e:	f406                	sd	ra,40(sp)
     260:	f022                	sd	s0,32(sp)
     262:	1800                	addi	s0,sp,48
     264:	fca43c23          	sd	a0,-40(s0)
     268:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     26c:	4581                	li	a1,0
     26e:	fd843503          	ld	a0,-40(s0)
     272:	00000097          	auipc	ra,0x0
     276:	288080e7          	jalr	648(ra) # 4fa <open>
     27a:	87aa                	mv	a5,a0
     27c:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
     280:	fec42783          	lw	a5,-20(s0)
     284:	2781                	sext.w	a5,a5
     286:	0007d463          	bgez	a5,28e <stat+0x32>
    return -1;
     28a:	57fd                	li	a5,-1
     28c:	a035                	j	2b8 <stat+0x5c>
  r = fstat(fd, st);
     28e:	fec42783          	lw	a5,-20(s0)
     292:	fd043583          	ld	a1,-48(s0)
     296:	853e                	mv	a0,a5
     298:	00000097          	auipc	ra,0x0
     29c:	27a080e7          	jalr	634(ra) # 512 <fstat>
     2a0:	87aa                	mv	a5,a0
     2a2:	fef42423          	sw	a5,-24(s0)
  close(fd);
     2a6:	fec42783          	lw	a5,-20(s0)
     2aa:	853e                	mv	a0,a5
     2ac:	00000097          	auipc	ra,0x0
     2b0:	236080e7          	jalr	566(ra) # 4e2 <close>
  return r;
     2b4:	fe842783          	lw	a5,-24(s0)
}
     2b8:	853e                	mv	a0,a5
     2ba:	70a2                	ld	ra,40(sp)
     2bc:	7402                	ld	s0,32(sp)
     2be:	6145                	addi	sp,sp,48
     2c0:	8082                	ret

00000000000002c2 <atoi>:

int
atoi(const char *s)
{
     2c2:	7179                	addi	sp,sp,-48
     2c4:	f422                	sd	s0,40(sp)
     2c6:	1800                	addi	s0,sp,48
     2c8:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
     2cc:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
     2d0:	a815                	j	304 <atoi+0x42>
    n = n*10 + *s++ - '0';
     2d2:	fec42703          	lw	a4,-20(s0)
     2d6:	87ba                	mv	a5,a4
     2d8:	0027979b          	slliw	a5,a5,0x2
     2dc:	9fb9                	addw	a5,a5,a4
     2de:	0017979b          	slliw	a5,a5,0x1
     2e2:	0007871b          	sext.w	a4,a5
     2e6:	fd843783          	ld	a5,-40(s0)
     2ea:	00178693          	addi	a3,a5,1
     2ee:	fcd43c23          	sd	a3,-40(s0)
     2f2:	0007c783          	lbu	a5,0(a5)
     2f6:	2781                	sext.w	a5,a5
     2f8:	9fb9                	addw	a5,a5,a4
     2fa:	2781                	sext.w	a5,a5
     2fc:	fd07879b          	addiw	a5,a5,-48
     300:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
     304:	fd843783          	ld	a5,-40(s0)
     308:	0007c783          	lbu	a5,0(a5)
     30c:	873e                	mv	a4,a5
     30e:	02f00793          	li	a5,47
     312:	00e7fb63          	bgeu	a5,a4,328 <atoi+0x66>
     316:	fd843783          	ld	a5,-40(s0)
     31a:	0007c783          	lbu	a5,0(a5)
     31e:	873e                	mv	a4,a5
     320:	03900793          	li	a5,57
     324:	fae7f7e3          	bgeu	a5,a4,2d2 <atoi+0x10>
  return n;
     328:	fec42783          	lw	a5,-20(s0)
}
     32c:	853e                	mv	a0,a5
     32e:	7422                	ld	s0,40(sp)
     330:	6145                	addi	sp,sp,48
     332:	8082                	ret

0000000000000334 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     334:	7139                	addi	sp,sp,-64
     336:	fc22                	sd	s0,56(sp)
     338:	0080                	addi	s0,sp,64
     33a:	fca43c23          	sd	a0,-40(s0)
     33e:	fcb43823          	sd	a1,-48(s0)
     342:	87b2                	mv	a5,a2
     344:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
     348:	fd843783          	ld	a5,-40(s0)
     34c:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
     350:	fd043783          	ld	a5,-48(s0)
     354:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
     358:	fe043703          	ld	a4,-32(s0)
     35c:	fe843783          	ld	a5,-24(s0)
     360:	02e7fc63          	bgeu	a5,a4,398 <memmove+0x64>
    while(n-- > 0)
     364:	a00d                	j	386 <memmove+0x52>
      *dst++ = *src++;
     366:	fe043703          	ld	a4,-32(s0)
     36a:	00170793          	addi	a5,a4,1
     36e:	fef43023          	sd	a5,-32(s0)
     372:	fe843783          	ld	a5,-24(s0)
     376:	00178693          	addi	a3,a5,1
     37a:	fed43423          	sd	a3,-24(s0)
     37e:	00074703          	lbu	a4,0(a4)
     382:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     386:	fcc42783          	lw	a5,-52(s0)
     38a:	fff7871b          	addiw	a4,a5,-1
     38e:	fce42623          	sw	a4,-52(s0)
     392:	fcf04ae3          	bgtz	a5,366 <memmove+0x32>
     396:	a891                	j	3ea <memmove+0xb6>
  } else {
    dst += n;
     398:	fcc42783          	lw	a5,-52(s0)
     39c:	fe843703          	ld	a4,-24(s0)
     3a0:	97ba                	add	a5,a5,a4
     3a2:	fef43423          	sd	a5,-24(s0)
    src += n;
     3a6:	fcc42783          	lw	a5,-52(s0)
     3aa:	fe043703          	ld	a4,-32(s0)
     3ae:	97ba                	add	a5,a5,a4
     3b0:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
     3b4:	a01d                	j	3da <memmove+0xa6>
      *--dst = *--src;
     3b6:	fe043783          	ld	a5,-32(s0)
     3ba:	17fd                	addi	a5,a5,-1
     3bc:	fef43023          	sd	a5,-32(s0)
     3c0:	fe843783          	ld	a5,-24(s0)
     3c4:	17fd                	addi	a5,a5,-1
     3c6:	fef43423          	sd	a5,-24(s0)
     3ca:	fe043783          	ld	a5,-32(s0)
     3ce:	0007c703          	lbu	a4,0(a5)
     3d2:	fe843783          	ld	a5,-24(s0)
     3d6:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     3da:	fcc42783          	lw	a5,-52(s0)
     3de:	fff7871b          	addiw	a4,a5,-1
     3e2:	fce42623          	sw	a4,-52(s0)
     3e6:	fcf048e3          	bgtz	a5,3b6 <memmove+0x82>
  }
  return vdst;
     3ea:	fd843783          	ld	a5,-40(s0)
}
     3ee:	853e                	mv	a0,a5
     3f0:	7462                	ld	s0,56(sp)
     3f2:	6121                	addi	sp,sp,64
     3f4:	8082                	ret

00000000000003f6 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     3f6:	7139                	addi	sp,sp,-64
     3f8:	fc22                	sd	s0,56(sp)
     3fa:	0080                	addi	s0,sp,64
     3fc:	fca43c23          	sd	a0,-40(s0)
     400:	fcb43823          	sd	a1,-48(s0)
     404:	87b2                	mv	a5,a2
     406:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
     40a:	fd843783          	ld	a5,-40(s0)
     40e:	fef43423          	sd	a5,-24(s0)
     412:	fd043783          	ld	a5,-48(s0)
     416:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     41a:	a0a1                	j	462 <memcmp+0x6c>
    if (*p1 != *p2) {
     41c:	fe843783          	ld	a5,-24(s0)
     420:	0007c703          	lbu	a4,0(a5)
     424:	fe043783          	ld	a5,-32(s0)
     428:	0007c783          	lbu	a5,0(a5)
     42c:	02f70163          	beq	a4,a5,44e <memcmp+0x58>
      return *p1 - *p2;
     430:	fe843783          	ld	a5,-24(s0)
     434:	0007c783          	lbu	a5,0(a5)
     438:	0007871b          	sext.w	a4,a5
     43c:	fe043783          	ld	a5,-32(s0)
     440:	0007c783          	lbu	a5,0(a5)
     444:	2781                	sext.w	a5,a5
     446:	40f707bb          	subw	a5,a4,a5
     44a:	2781                	sext.w	a5,a5
     44c:	a01d                	j	472 <memcmp+0x7c>
    }
    p1++;
     44e:	fe843783          	ld	a5,-24(s0)
     452:	0785                	addi	a5,a5,1
     454:	fef43423          	sd	a5,-24(s0)
    p2++;
     458:	fe043783          	ld	a5,-32(s0)
     45c:	0785                	addi	a5,a5,1
     45e:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     462:	fcc42783          	lw	a5,-52(s0)
     466:	fff7871b          	addiw	a4,a5,-1
     46a:	fce42623          	sw	a4,-52(s0)
     46e:	f7dd                	bnez	a5,41c <memcmp+0x26>
  }
  return 0;
     470:	4781                	li	a5,0
}
     472:	853e                	mv	a0,a5
     474:	7462                	ld	s0,56(sp)
     476:	6121                	addi	sp,sp,64
     478:	8082                	ret

000000000000047a <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     47a:	7179                	addi	sp,sp,-48
     47c:	f406                	sd	ra,40(sp)
     47e:	f022                	sd	s0,32(sp)
     480:	1800                	addi	s0,sp,48
     482:	fea43423          	sd	a0,-24(s0)
     486:	feb43023          	sd	a1,-32(s0)
     48a:	87b2                	mv	a5,a2
     48c:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
     490:	fdc42783          	lw	a5,-36(s0)
     494:	863e                	mv	a2,a5
     496:	fe043583          	ld	a1,-32(s0)
     49a:	fe843503          	ld	a0,-24(s0)
     49e:	00000097          	auipc	ra,0x0
     4a2:	e96080e7          	jalr	-362(ra) # 334 <memmove>
     4a6:	87aa                	mv	a5,a0
}
     4a8:	853e                	mv	a0,a5
     4aa:	70a2                	ld	ra,40(sp)
     4ac:	7402                	ld	s0,32(sp)
     4ae:	6145                	addi	sp,sp,48
     4b0:	8082                	ret

00000000000004b2 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     4b2:	4885                	li	a7,1
 ecall
     4b4:	00000073          	ecall
 ret
     4b8:	8082                	ret

00000000000004ba <exit>:
.global exit
exit:
 li a7, SYS_exit
     4ba:	4889                	li	a7,2
 ecall
     4bc:	00000073          	ecall
 ret
     4c0:	8082                	ret

00000000000004c2 <wait>:
.global wait
wait:
 li a7, SYS_wait
     4c2:	488d                	li	a7,3
 ecall
     4c4:	00000073          	ecall
 ret
     4c8:	8082                	ret

00000000000004ca <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     4ca:	4891                	li	a7,4
 ecall
     4cc:	00000073          	ecall
 ret
     4d0:	8082                	ret

00000000000004d2 <read>:
.global read
read:
 li a7, SYS_read
     4d2:	4895                	li	a7,5
 ecall
     4d4:	00000073          	ecall
 ret
     4d8:	8082                	ret

00000000000004da <write>:
.global write
write:
 li a7, SYS_write
     4da:	48c1                	li	a7,16
 ecall
     4dc:	00000073          	ecall
 ret
     4e0:	8082                	ret

00000000000004e2 <close>:
.global close
close:
 li a7, SYS_close
     4e2:	48d5                	li	a7,21
 ecall
     4e4:	00000073          	ecall
 ret
     4e8:	8082                	ret

00000000000004ea <kill>:
.global kill
kill:
 li a7, SYS_kill
     4ea:	4899                	li	a7,6
 ecall
     4ec:	00000073          	ecall
 ret
     4f0:	8082                	ret

00000000000004f2 <exec>:
.global exec
exec:
 li a7, SYS_exec
     4f2:	489d                	li	a7,7
 ecall
     4f4:	00000073          	ecall
 ret
     4f8:	8082                	ret

00000000000004fa <open>:
.global open
open:
 li a7, SYS_open
     4fa:	48bd                	li	a7,15
 ecall
     4fc:	00000073          	ecall
 ret
     500:	8082                	ret

0000000000000502 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     502:	48c5                	li	a7,17
 ecall
     504:	00000073          	ecall
 ret
     508:	8082                	ret

000000000000050a <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     50a:	48c9                	li	a7,18
 ecall
     50c:	00000073          	ecall
 ret
     510:	8082                	ret

0000000000000512 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     512:	48a1                	li	a7,8
 ecall
     514:	00000073          	ecall
 ret
     518:	8082                	ret

000000000000051a <link>:
.global link
link:
 li a7, SYS_link
     51a:	48cd                	li	a7,19
 ecall
     51c:	00000073          	ecall
 ret
     520:	8082                	ret

0000000000000522 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     522:	48d1                	li	a7,20
 ecall
     524:	00000073          	ecall
 ret
     528:	8082                	ret

000000000000052a <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     52a:	48a5                	li	a7,9
 ecall
     52c:	00000073          	ecall
 ret
     530:	8082                	ret

0000000000000532 <dup>:
.global dup
dup:
 li a7, SYS_dup
     532:	48a9                	li	a7,10
 ecall
     534:	00000073          	ecall
 ret
     538:	8082                	ret

000000000000053a <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     53a:	48ad                	li	a7,11
 ecall
     53c:	00000073          	ecall
 ret
     540:	8082                	ret

0000000000000542 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     542:	48b1                	li	a7,12
 ecall
     544:	00000073          	ecall
 ret
     548:	8082                	ret

000000000000054a <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     54a:	48b5                	li	a7,13
 ecall
     54c:	00000073          	ecall
 ret
     550:	8082                	ret

0000000000000552 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     552:	48b9                	li	a7,14
 ecall
     554:	00000073          	ecall
 ret
     558:	8082                	ret

000000000000055a <thrdstop>:
.global thrdstop
thrdstop:
 li a7, SYS_thrdstop
     55a:	48d9                	li	a7,22
 ecall
     55c:	00000073          	ecall
 ret
     560:	8082                	ret

0000000000000562 <thrdresume>:
.global thrdresume
thrdresume:
 li a7, SYS_thrdresume
     562:	48dd                	li	a7,23
 ecall
     564:	00000073          	ecall
 ret
     568:	8082                	ret

000000000000056a <cancelthrdstop>:
.global cancelthrdstop
cancelthrdstop:
 li a7, SYS_cancelthrdstop
     56a:	48e1                	li	a7,24
 ecall
     56c:	00000073          	ecall
 ret
     570:	8082                	ret

0000000000000572 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     572:	1101                	addi	sp,sp,-32
     574:	ec06                	sd	ra,24(sp)
     576:	e822                	sd	s0,16(sp)
     578:	1000                	addi	s0,sp,32
     57a:	87aa                	mv	a5,a0
     57c:	872e                	mv	a4,a1
     57e:	fef42623          	sw	a5,-20(s0)
     582:	87ba                	mv	a5,a4
     584:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
     588:	feb40713          	addi	a4,s0,-21
     58c:	fec42783          	lw	a5,-20(s0)
     590:	4605                	li	a2,1
     592:	85ba                	mv	a1,a4
     594:	853e                	mv	a0,a5
     596:	00000097          	auipc	ra,0x0
     59a:	f44080e7          	jalr	-188(ra) # 4da <write>
}
     59e:	0001                	nop
     5a0:	60e2                	ld	ra,24(sp)
     5a2:	6442                	ld	s0,16(sp)
     5a4:	6105                	addi	sp,sp,32
     5a6:	8082                	ret

00000000000005a8 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     5a8:	7139                	addi	sp,sp,-64
     5aa:	fc06                	sd	ra,56(sp)
     5ac:	f822                	sd	s0,48(sp)
     5ae:	0080                	addi	s0,sp,64
     5b0:	87aa                	mv	a5,a0
     5b2:	8736                	mv	a4,a3
     5b4:	fcf42623          	sw	a5,-52(s0)
     5b8:	87ae                	mv	a5,a1
     5ba:	fcf42423          	sw	a5,-56(s0)
     5be:	87b2                	mv	a5,a2
     5c0:	fcf42223          	sw	a5,-60(s0)
     5c4:	87ba                	mv	a5,a4
     5c6:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     5ca:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
     5ce:	fc042783          	lw	a5,-64(s0)
     5d2:	2781                	sext.w	a5,a5
     5d4:	c38d                	beqz	a5,5f6 <printint+0x4e>
     5d6:	fc842783          	lw	a5,-56(s0)
     5da:	2781                	sext.w	a5,a5
     5dc:	0007dd63          	bgez	a5,5f6 <printint+0x4e>
    neg = 1;
     5e0:	4785                	li	a5,1
     5e2:	fef42423          	sw	a5,-24(s0)
    x = -xx;
     5e6:	fc842783          	lw	a5,-56(s0)
     5ea:	40f007bb          	negw	a5,a5
     5ee:	2781                	sext.w	a5,a5
     5f0:	fef42223          	sw	a5,-28(s0)
     5f4:	a029                	j	5fe <printint+0x56>
  } else {
    x = xx;
     5f6:	fc842783          	lw	a5,-56(s0)
     5fa:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
     5fe:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
     602:	fc442783          	lw	a5,-60(s0)
     606:	fe442703          	lw	a4,-28(s0)
     60a:	02f777bb          	remuw	a5,a4,a5
     60e:	0007861b          	sext.w	a2,a5
     612:	fec42783          	lw	a5,-20(s0)
     616:	0017871b          	addiw	a4,a5,1
     61a:	fee42623          	sw	a4,-20(s0)
     61e:	00001697          	auipc	a3,0x1
     622:	f8268693          	addi	a3,a3,-126 # 15a0 <digits>
     626:	02061713          	slli	a4,a2,0x20
     62a:	9301                	srli	a4,a4,0x20
     62c:	9736                	add	a4,a4,a3
     62e:	00074703          	lbu	a4,0(a4)
     632:	ff040693          	addi	a3,s0,-16
     636:	97b6                	add	a5,a5,a3
     638:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
     63c:	fc442783          	lw	a5,-60(s0)
     640:	fe442703          	lw	a4,-28(s0)
     644:	02f757bb          	divuw	a5,a4,a5
     648:	fef42223          	sw	a5,-28(s0)
     64c:	fe442783          	lw	a5,-28(s0)
     650:	2781                	sext.w	a5,a5
     652:	fbc5                	bnez	a5,602 <printint+0x5a>
  if(neg)
     654:	fe842783          	lw	a5,-24(s0)
     658:	2781                	sext.w	a5,a5
     65a:	cf95                	beqz	a5,696 <printint+0xee>
    buf[i++] = '-';
     65c:	fec42783          	lw	a5,-20(s0)
     660:	0017871b          	addiw	a4,a5,1
     664:	fee42623          	sw	a4,-20(s0)
     668:	ff040713          	addi	a4,s0,-16
     66c:	97ba                	add	a5,a5,a4
     66e:	02d00713          	li	a4,45
     672:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
     676:	a005                	j	696 <printint+0xee>
    putc(fd, buf[i]);
     678:	fec42783          	lw	a5,-20(s0)
     67c:	ff040713          	addi	a4,s0,-16
     680:	97ba                	add	a5,a5,a4
     682:	fe07c703          	lbu	a4,-32(a5)
     686:	fcc42783          	lw	a5,-52(s0)
     68a:	85ba                	mv	a1,a4
     68c:	853e                	mv	a0,a5
     68e:	00000097          	auipc	ra,0x0
     692:	ee4080e7          	jalr	-284(ra) # 572 <putc>
  while(--i >= 0)
     696:	fec42783          	lw	a5,-20(s0)
     69a:	37fd                	addiw	a5,a5,-1
     69c:	fef42623          	sw	a5,-20(s0)
     6a0:	fec42783          	lw	a5,-20(s0)
     6a4:	2781                	sext.w	a5,a5
     6a6:	fc07d9e3          	bgez	a5,678 <printint+0xd0>
}
     6aa:	0001                	nop
     6ac:	0001                	nop
     6ae:	70e2                	ld	ra,56(sp)
     6b0:	7442                	ld	s0,48(sp)
     6b2:	6121                	addi	sp,sp,64
     6b4:	8082                	ret

00000000000006b6 <printptr>:

static void
printptr(int fd, uint64 x) {
     6b6:	7179                	addi	sp,sp,-48
     6b8:	f406                	sd	ra,40(sp)
     6ba:	f022                	sd	s0,32(sp)
     6bc:	1800                	addi	s0,sp,48
     6be:	87aa                	mv	a5,a0
     6c0:	fcb43823          	sd	a1,-48(s0)
     6c4:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
     6c8:	fdc42783          	lw	a5,-36(s0)
     6cc:	03000593          	li	a1,48
     6d0:	853e                	mv	a0,a5
     6d2:	00000097          	auipc	ra,0x0
     6d6:	ea0080e7          	jalr	-352(ra) # 572 <putc>
  putc(fd, 'x');
     6da:	fdc42783          	lw	a5,-36(s0)
     6de:	07800593          	li	a1,120
     6e2:	853e                	mv	a0,a5
     6e4:	00000097          	auipc	ra,0x0
     6e8:	e8e080e7          	jalr	-370(ra) # 572 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     6ec:	fe042623          	sw	zero,-20(s0)
     6f0:	a82d                	j	72a <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     6f2:	fd043783          	ld	a5,-48(s0)
     6f6:	93f1                	srli	a5,a5,0x3c
     6f8:	00001717          	auipc	a4,0x1
     6fc:	ea870713          	addi	a4,a4,-344 # 15a0 <digits>
     700:	97ba                	add	a5,a5,a4
     702:	0007c703          	lbu	a4,0(a5)
     706:	fdc42783          	lw	a5,-36(s0)
     70a:	85ba                	mv	a1,a4
     70c:	853e                	mv	a0,a5
     70e:	00000097          	auipc	ra,0x0
     712:	e64080e7          	jalr	-412(ra) # 572 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     716:	fec42783          	lw	a5,-20(s0)
     71a:	2785                	addiw	a5,a5,1
     71c:	fef42623          	sw	a5,-20(s0)
     720:	fd043783          	ld	a5,-48(s0)
     724:	0792                	slli	a5,a5,0x4
     726:	fcf43823          	sd	a5,-48(s0)
     72a:	fec42783          	lw	a5,-20(s0)
     72e:	873e                	mv	a4,a5
     730:	47bd                	li	a5,15
     732:	fce7f0e3          	bgeu	a5,a4,6f2 <printptr+0x3c>
}
     736:	0001                	nop
     738:	0001                	nop
     73a:	70a2                	ld	ra,40(sp)
     73c:	7402                	ld	s0,32(sp)
     73e:	6145                	addi	sp,sp,48
     740:	8082                	ret

0000000000000742 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     742:	715d                	addi	sp,sp,-80
     744:	e486                	sd	ra,72(sp)
     746:	e0a2                	sd	s0,64(sp)
     748:	0880                	addi	s0,sp,80
     74a:	87aa                	mv	a5,a0
     74c:	fcb43023          	sd	a1,-64(s0)
     750:	fac43c23          	sd	a2,-72(s0)
     754:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
     758:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     75c:	fe042223          	sw	zero,-28(s0)
     760:	a42d                	j	98a <vprintf+0x248>
    c = fmt[i] & 0xff;
     762:	fe442783          	lw	a5,-28(s0)
     766:	fc043703          	ld	a4,-64(s0)
     76a:	97ba                	add	a5,a5,a4
     76c:	0007c783          	lbu	a5,0(a5)
     770:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
     774:	fe042783          	lw	a5,-32(s0)
     778:	2781                	sext.w	a5,a5
     77a:	eb9d                	bnez	a5,7b0 <vprintf+0x6e>
      if(c == '%'){
     77c:	fdc42783          	lw	a5,-36(s0)
     780:	0007871b          	sext.w	a4,a5
     784:	02500793          	li	a5,37
     788:	00f71763          	bne	a4,a5,796 <vprintf+0x54>
        state = '%';
     78c:	02500793          	li	a5,37
     790:	fef42023          	sw	a5,-32(s0)
     794:	a2f5                	j	980 <vprintf+0x23e>
      } else {
        putc(fd, c);
     796:	fdc42783          	lw	a5,-36(s0)
     79a:	0ff7f713          	andi	a4,a5,255
     79e:	fcc42783          	lw	a5,-52(s0)
     7a2:	85ba                	mv	a1,a4
     7a4:	853e                	mv	a0,a5
     7a6:	00000097          	auipc	ra,0x0
     7aa:	dcc080e7          	jalr	-564(ra) # 572 <putc>
     7ae:	aac9                	j	980 <vprintf+0x23e>
      }
    } else if(state == '%'){
     7b0:	fe042783          	lw	a5,-32(s0)
     7b4:	0007871b          	sext.w	a4,a5
     7b8:	02500793          	li	a5,37
     7bc:	1cf71263          	bne	a4,a5,980 <vprintf+0x23e>
      if(c == 'd'){
     7c0:	fdc42783          	lw	a5,-36(s0)
     7c4:	0007871b          	sext.w	a4,a5
     7c8:	06400793          	li	a5,100
     7cc:	02f71463          	bne	a4,a5,7f4 <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
     7d0:	fb843783          	ld	a5,-72(s0)
     7d4:	00878713          	addi	a4,a5,8
     7d8:	fae43c23          	sd	a4,-72(s0)
     7dc:	4398                	lw	a4,0(a5)
     7de:	fcc42783          	lw	a5,-52(s0)
     7e2:	4685                	li	a3,1
     7e4:	4629                	li	a2,10
     7e6:	85ba                	mv	a1,a4
     7e8:	853e                	mv	a0,a5
     7ea:	00000097          	auipc	ra,0x0
     7ee:	dbe080e7          	jalr	-578(ra) # 5a8 <printint>
     7f2:	a269                	j	97c <vprintf+0x23a>
      } else if(c == 'l') {
     7f4:	fdc42783          	lw	a5,-36(s0)
     7f8:	0007871b          	sext.w	a4,a5
     7fc:	06c00793          	li	a5,108
     800:	02f71663          	bne	a4,a5,82c <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
     804:	fb843783          	ld	a5,-72(s0)
     808:	00878713          	addi	a4,a5,8
     80c:	fae43c23          	sd	a4,-72(s0)
     810:	639c                	ld	a5,0(a5)
     812:	0007871b          	sext.w	a4,a5
     816:	fcc42783          	lw	a5,-52(s0)
     81a:	4681                	li	a3,0
     81c:	4629                	li	a2,10
     81e:	85ba                	mv	a1,a4
     820:	853e                	mv	a0,a5
     822:	00000097          	auipc	ra,0x0
     826:	d86080e7          	jalr	-634(ra) # 5a8 <printint>
     82a:	aa89                	j	97c <vprintf+0x23a>
      } else if(c == 'x') {
     82c:	fdc42783          	lw	a5,-36(s0)
     830:	0007871b          	sext.w	a4,a5
     834:	07800793          	li	a5,120
     838:	02f71463          	bne	a4,a5,860 <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
     83c:	fb843783          	ld	a5,-72(s0)
     840:	00878713          	addi	a4,a5,8
     844:	fae43c23          	sd	a4,-72(s0)
     848:	4398                	lw	a4,0(a5)
     84a:	fcc42783          	lw	a5,-52(s0)
     84e:	4681                	li	a3,0
     850:	4641                	li	a2,16
     852:	85ba                	mv	a1,a4
     854:	853e                	mv	a0,a5
     856:	00000097          	auipc	ra,0x0
     85a:	d52080e7          	jalr	-686(ra) # 5a8 <printint>
     85e:	aa39                	j	97c <vprintf+0x23a>
      } else if(c == 'p') {
     860:	fdc42783          	lw	a5,-36(s0)
     864:	0007871b          	sext.w	a4,a5
     868:	07000793          	li	a5,112
     86c:	02f71263          	bne	a4,a5,890 <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
     870:	fb843783          	ld	a5,-72(s0)
     874:	00878713          	addi	a4,a5,8
     878:	fae43c23          	sd	a4,-72(s0)
     87c:	6398                	ld	a4,0(a5)
     87e:	fcc42783          	lw	a5,-52(s0)
     882:	85ba                	mv	a1,a4
     884:	853e                	mv	a0,a5
     886:	00000097          	auipc	ra,0x0
     88a:	e30080e7          	jalr	-464(ra) # 6b6 <printptr>
     88e:	a0fd                	j	97c <vprintf+0x23a>
      } else if(c == 's'){
     890:	fdc42783          	lw	a5,-36(s0)
     894:	0007871b          	sext.w	a4,a5
     898:	07300793          	li	a5,115
     89c:	04f71c63          	bne	a4,a5,8f4 <vprintf+0x1b2>
        s = va_arg(ap, char*);
     8a0:	fb843783          	ld	a5,-72(s0)
     8a4:	00878713          	addi	a4,a5,8
     8a8:	fae43c23          	sd	a4,-72(s0)
     8ac:	639c                	ld	a5,0(a5)
     8ae:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
     8b2:	fe843783          	ld	a5,-24(s0)
     8b6:	eb8d                	bnez	a5,8e8 <vprintf+0x1a6>
          s = "(null)";
     8b8:	00001797          	auipc	a5,0x1
     8bc:	ce078793          	addi	a5,a5,-800 # 1598 <schedule_rm+0x35e>
     8c0:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     8c4:	a015                	j	8e8 <vprintf+0x1a6>
          putc(fd, *s);
     8c6:	fe843783          	ld	a5,-24(s0)
     8ca:	0007c703          	lbu	a4,0(a5)
     8ce:	fcc42783          	lw	a5,-52(s0)
     8d2:	85ba                	mv	a1,a4
     8d4:	853e                	mv	a0,a5
     8d6:	00000097          	auipc	ra,0x0
     8da:	c9c080e7          	jalr	-868(ra) # 572 <putc>
          s++;
     8de:	fe843783          	ld	a5,-24(s0)
     8e2:	0785                	addi	a5,a5,1
     8e4:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     8e8:	fe843783          	ld	a5,-24(s0)
     8ec:	0007c783          	lbu	a5,0(a5)
     8f0:	fbf9                	bnez	a5,8c6 <vprintf+0x184>
     8f2:	a069                	j	97c <vprintf+0x23a>
        }
      } else if(c == 'c'){
     8f4:	fdc42783          	lw	a5,-36(s0)
     8f8:	0007871b          	sext.w	a4,a5
     8fc:	06300793          	li	a5,99
     900:	02f71463          	bne	a4,a5,928 <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
     904:	fb843783          	ld	a5,-72(s0)
     908:	00878713          	addi	a4,a5,8
     90c:	fae43c23          	sd	a4,-72(s0)
     910:	439c                	lw	a5,0(a5)
     912:	0ff7f713          	andi	a4,a5,255
     916:	fcc42783          	lw	a5,-52(s0)
     91a:	85ba                	mv	a1,a4
     91c:	853e                	mv	a0,a5
     91e:	00000097          	auipc	ra,0x0
     922:	c54080e7          	jalr	-940(ra) # 572 <putc>
     926:	a899                	j	97c <vprintf+0x23a>
      } else if(c == '%'){
     928:	fdc42783          	lw	a5,-36(s0)
     92c:	0007871b          	sext.w	a4,a5
     930:	02500793          	li	a5,37
     934:	00f71f63          	bne	a4,a5,952 <vprintf+0x210>
        putc(fd, c);
     938:	fdc42783          	lw	a5,-36(s0)
     93c:	0ff7f713          	andi	a4,a5,255
     940:	fcc42783          	lw	a5,-52(s0)
     944:	85ba                	mv	a1,a4
     946:	853e                	mv	a0,a5
     948:	00000097          	auipc	ra,0x0
     94c:	c2a080e7          	jalr	-982(ra) # 572 <putc>
     950:	a035                	j	97c <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     952:	fcc42783          	lw	a5,-52(s0)
     956:	02500593          	li	a1,37
     95a:	853e                	mv	a0,a5
     95c:	00000097          	auipc	ra,0x0
     960:	c16080e7          	jalr	-1002(ra) # 572 <putc>
        putc(fd, c);
     964:	fdc42783          	lw	a5,-36(s0)
     968:	0ff7f713          	andi	a4,a5,255
     96c:	fcc42783          	lw	a5,-52(s0)
     970:	85ba                	mv	a1,a4
     972:	853e                	mv	a0,a5
     974:	00000097          	auipc	ra,0x0
     978:	bfe080e7          	jalr	-1026(ra) # 572 <putc>
      }
      state = 0;
     97c:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     980:	fe442783          	lw	a5,-28(s0)
     984:	2785                	addiw	a5,a5,1
     986:	fef42223          	sw	a5,-28(s0)
     98a:	fe442783          	lw	a5,-28(s0)
     98e:	fc043703          	ld	a4,-64(s0)
     992:	97ba                	add	a5,a5,a4
     994:	0007c783          	lbu	a5,0(a5)
     998:	dc0795e3          	bnez	a5,762 <vprintf+0x20>
    }
  }
}
     99c:	0001                	nop
     99e:	0001                	nop
     9a0:	60a6                	ld	ra,72(sp)
     9a2:	6406                	ld	s0,64(sp)
     9a4:	6161                	addi	sp,sp,80
     9a6:	8082                	ret

00000000000009a8 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     9a8:	7159                	addi	sp,sp,-112
     9aa:	fc06                	sd	ra,56(sp)
     9ac:	f822                	sd	s0,48(sp)
     9ae:	0080                	addi	s0,sp,64
     9b0:	fcb43823          	sd	a1,-48(s0)
     9b4:	e010                	sd	a2,0(s0)
     9b6:	e414                	sd	a3,8(s0)
     9b8:	e818                	sd	a4,16(s0)
     9ba:	ec1c                	sd	a5,24(s0)
     9bc:	03043023          	sd	a6,32(s0)
     9c0:	03143423          	sd	a7,40(s0)
     9c4:	87aa                	mv	a5,a0
     9c6:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
     9ca:	03040793          	addi	a5,s0,48
     9ce:	fcf43423          	sd	a5,-56(s0)
     9d2:	fc843783          	ld	a5,-56(s0)
     9d6:	fd078793          	addi	a5,a5,-48
     9da:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
     9de:	fe843703          	ld	a4,-24(s0)
     9e2:	fdc42783          	lw	a5,-36(s0)
     9e6:	863a                	mv	a2,a4
     9e8:	fd043583          	ld	a1,-48(s0)
     9ec:	853e                	mv	a0,a5
     9ee:	00000097          	auipc	ra,0x0
     9f2:	d54080e7          	jalr	-684(ra) # 742 <vprintf>
}
     9f6:	0001                	nop
     9f8:	70e2                	ld	ra,56(sp)
     9fa:	7442                	ld	s0,48(sp)
     9fc:	6165                	addi	sp,sp,112
     9fe:	8082                	ret

0000000000000a00 <printf>:

void
printf(const char *fmt, ...)
{
     a00:	7159                	addi	sp,sp,-112
     a02:	f406                	sd	ra,40(sp)
     a04:	f022                	sd	s0,32(sp)
     a06:	1800                	addi	s0,sp,48
     a08:	fca43c23          	sd	a0,-40(s0)
     a0c:	e40c                	sd	a1,8(s0)
     a0e:	e810                	sd	a2,16(s0)
     a10:	ec14                	sd	a3,24(s0)
     a12:	f018                	sd	a4,32(s0)
     a14:	f41c                	sd	a5,40(s0)
     a16:	03043823          	sd	a6,48(s0)
     a1a:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
     a1e:	04040793          	addi	a5,s0,64
     a22:	fcf43823          	sd	a5,-48(s0)
     a26:	fd043783          	ld	a5,-48(s0)
     a2a:	fc878793          	addi	a5,a5,-56
     a2e:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
     a32:	fe843783          	ld	a5,-24(s0)
     a36:	863e                	mv	a2,a5
     a38:	fd843583          	ld	a1,-40(s0)
     a3c:	4505                	li	a0,1
     a3e:	00000097          	auipc	ra,0x0
     a42:	d04080e7          	jalr	-764(ra) # 742 <vprintf>
}
     a46:	0001                	nop
     a48:	70a2                	ld	ra,40(sp)
     a4a:	7402                	ld	s0,32(sp)
     a4c:	6165                	addi	sp,sp,112
     a4e:	8082                	ret

0000000000000a50 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     a50:	7179                	addi	sp,sp,-48
     a52:	f422                	sd	s0,40(sp)
     a54:	1800                	addi	s0,sp,48
     a56:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
     a5a:	fd843783          	ld	a5,-40(s0)
     a5e:	17c1                	addi	a5,a5,-16
     a60:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     a64:	00001797          	auipc	a5,0x1
     a68:	b6478793          	addi	a5,a5,-1180 # 15c8 <freep>
     a6c:	639c                	ld	a5,0(a5)
     a6e:	fef43423          	sd	a5,-24(s0)
     a72:	a815                	j	aa6 <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     a74:	fe843783          	ld	a5,-24(s0)
     a78:	639c                	ld	a5,0(a5)
     a7a:	fe843703          	ld	a4,-24(s0)
     a7e:	00f76f63          	bltu	a4,a5,a9c <free+0x4c>
     a82:	fe043703          	ld	a4,-32(s0)
     a86:	fe843783          	ld	a5,-24(s0)
     a8a:	02e7eb63          	bltu	a5,a4,ac0 <free+0x70>
     a8e:	fe843783          	ld	a5,-24(s0)
     a92:	639c                	ld	a5,0(a5)
     a94:	fe043703          	ld	a4,-32(s0)
     a98:	02f76463          	bltu	a4,a5,ac0 <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     a9c:	fe843783          	ld	a5,-24(s0)
     aa0:	639c                	ld	a5,0(a5)
     aa2:	fef43423          	sd	a5,-24(s0)
     aa6:	fe043703          	ld	a4,-32(s0)
     aaa:	fe843783          	ld	a5,-24(s0)
     aae:	fce7f3e3          	bgeu	a5,a4,a74 <free+0x24>
     ab2:	fe843783          	ld	a5,-24(s0)
     ab6:	639c                	ld	a5,0(a5)
     ab8:	fe043703          	ld	a4,-32(s0)
     abc:	faf77ce3          	bgeu	a4,a5,a74 <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
     ac0:	fe043783          	ld	a5,-32(s0)
     ac4:	479c                	lw	a5,8(a5)
     ac6:	1782                	slli	a5,a5,0x20
     ac8:	9381                	srli	a5,a5,0x20
     aca:	0792                	slli	a5,a5,0x4
     acc:	fe043703          	ld	a4,-32(s0)
     ad0:	973e                	add	a4,a4,a5
     ad2:	fe843783          	ld	a5,-24(s0)
     ad6:	639c                	ld	a5,0(a5)
     ad8:	02f71763          	bne	a4,a5,b06 <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
     adc:	fe043783          	ld	a5,-32(s0)
     ae0:	4798                	lw	a4,8(a5)
     ae2:	fe843783          	ld	a5,-24(s0)
     ae6:	639c                	ld	a5,0(a5)
     ae8:	479c                	lw	a5,8(a5)
     aea:	9fb9                	addw	a5,a5,a4
     aec:	0007871b          	sext.w	a4,a5
     af0:	fe043783          	ld	a5,-32(s0)
     af4:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
     af6:	fe843783          	ld	a5,-24(s0)
     afa:	639c                	ld	a5,0(a5)
     afc:	6398                	ld	a4,0(a5)
     afe:	fe043783          	ld	a5,-32(s0)
     b02:	e398                	sd	a4,0(a5)
     b04:	a039                	j	b12 <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
     b06:	fe843783          	ld	a5,-24(s0)
     b0a:	6398                	ld	a4,0(a5)
     b0c:	fe043783          	ld	a5,-32(s0)
     b10:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
     b12:	fe843783          	ld	a5,-24(s0)
     b16:	479c                	lw	a5,8(a5)
     b18:	1782                	slli	a5,a5,0x20
     b1a:	9381                	srli	a5,a5,0x20
     b1c:	0792                	slli	a5,a5,0x4
     b1e:	fe843703          	ld	a4,-24(s0)
     b22:	97ba                	add	a5,a5,a4
     b24:	fe043703          	ld	a4,-32(s0)
     b28:	02f71563          	bne	a4,a5,b52 <free+0x102>
    p->s.size += bp->s.size;
     b2c:	fe843783          	ld	a5,-24(s0)
     b30:	4798                	lw	a4,8(a5)
     b32:	fe043783          	ld	a5,-32(s0)
     b36:	479c                	lw	a5,8(a5)
     b38:	9fb9                	addw	a5,a5,a4
     b3a:	0007871b          	sext.w	a4,a5
     b3e:	fe843783          	ld	a5,-24(s0)
     b42:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
     b44:	fe043783          	ld	a5,-32(s0)
     b48:	6398                	ld	a4,0(a5)
     b4a:	fe843783          	ld	a5,-24(s0)
     b4e:	e398                	sd	a4,0(a5)
     b50:	a031                	j	b5c <free+0x10c>
  } else
    p->s.ptr = bp;
     b52:	fe843783          	ld	a5,-24(s0)
     b56:	fe043703          	ld	a4,-32(s0)
     b5a:	e398                	sd	a4,0(a5)
  freep = p;
     b5c:	00001797          	auipc	a5,0x1
     b60:	a6c78793          	addi	a5,a5,-1428 # 15c8 <freep>
     b64:	fe843703          	ld	a4,-24(s0)
     b68:	e398                	sd	a4,0(a5)
}
     b6a:	0001                	nop
     b6c:	7422                	ld	s0,40(sp)
     b6e:	6145                	addi	sp,sp,48
     b70:	8082                	ret

0000000000000b72 <morecore>:

static Header*
morecore(uint nu)
{
     b72:	7179                	addi	sp,sp,-48
     b74:	f406                	sd	ra,40(sp)
     b76:	f022                	sd	s0,32(sp)
     b78:	1800                	addi	s0,sp,48
     b7a:	87aa                	mv	a5,a0
     b7c:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
     b80:	fdc42783          	lw	a5,-36(s0)
     b84:	0007871b          	sext.w	a4,a5
     b88:	6785                	lui	a5,0x1
     b8a:	00f77563          	bgeu	a4,a5,b94 <morecore+0x22>
    nu = 4096;
     b8e:	6785                	lui	a5,0x1
     b90:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
     b94:	fdc42783          	lw	a5,-36(s0)
     b98:	0047979b          	slliw	a5,a5,0x4
     b9c:	2781                	sext.w	a5,a5
     b9e:	2781                	sext.w	a5,a5
     ba0:	853e                	mv	a0,a5
     ba2:	00000097          	auipc	ra,0x0
     ba6:	9a0080e7          	jalr	-1632(ra) # 542 <sbrk>
     baa:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
     bae:	fe843703          	ld	a4,-24(s0)
     bb2:	57fd                	li	a5,-1
     bb4:	00f71463          	bne	a4,a5,bbc <morecore+0x4a>
    return 0;
     bb8:	4781                	li	a5,0
     bba:	a03d                	j	be8 <morecore+0x76>
  hp = (Header*)p;
     bbc:	fe843783          	ld	a5,-24(s0)
     bc0:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
     bc4:	fe043783          	ld	a5,-32(s0)
     bc8:	fdc42703          	lw	a4,-36(s0)
     bcc:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
     bce:	fe043783          	ld	a5,-32(s0)
     bd2:	07c1                	addi	a5,a5,16
     bd4:	853e                	mv	a0,a5
     bd6:	00000097          	auipc	ra,0x0
     bda:	e7a080e7          	jalr	-390(ra) # a50 <free>
  return freep;
     bde:	00001797          	auipc	a5,0x1
     be2:	9ea78793          	addi	a5,a5,-1558 # 15c8 <freep>
     be6:	639c                	ld	a5,0(a5)
}
     be8:	853e                	mv	a0,a5
     bea:	70a2                	ld	ra,40(sp)
     bec:	7402                	ld	s0,32(sp)
     bee:	6145                	addi	sp,sp,48
     bf0:	8082                	ret

0000000000000bf2 <malloc>:

void*
malloc(uint nbytes)
{
     bf2:	7139                	addi	sp,sp,-64
     bf4:	fc06                	sd	ra,56(sp)
     bf6:	f822                	sd	s0,48(sp)
     bf8:	0080                	addi	s0,sp,64
     bfa:	87aa                	mv	a5,a0
     bfc:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     c00:	fcc46783          	lwu	a5,-52(s0)
     c04:	07bd                	addi	a5,a5,15
     c06:	8391                	srli	a5,a5,0x4
     c08:	2781                	sext.w	a5,a5
     c0a:	2785                	addiw	a5,a5,1
     c0c:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
     c10:	00001797          	auipc	a5,0x1
     c14:	9b878793          	addi	a5,a5,-1608 # 15c8 <freep>
     c18:	639c                	ld	a5,0(a5)
     c1a:	fef43023          	sd	a5,-32(s0)
     c1e:	fe043783          	ld	a5,-32(s0)
     c22:	ef95                	bnez	a5,c5e <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
     c24:	00001797          	auipc	a5,0x1
     c28:	99478793          	addi	a5,a5,-1644 # 15b8 <base>
     c2c:	fef43023          	sd	a5,-32(s0)
     c30:	00001797          	auipc	a5,0x1
     c34:	99878793          	addi	a5,a5,-1640 # 15c8 <freep>
     c38:	fe043703          	ld	a4,-32(s0)
     c3c:	e398                	sd	a4,0(a5)
     c3e:	00001797          	auipc	a5,0x1
     c42:	98a78793          	addi	a5,a5,-1654 # 15c8 <freep>
     c46:	6398                	ld	a4,0(a5)
     c48:	00001797          	auipc	a5,0x1
     c4c:	97078793          	addi	a5,a5,-1680 # 15b8 <base>
     c50:	e398                	sd	a4,0(a5)
    base.s.size = 0;
     c52:	00001797          	auipc	a5,0x1
     c56:	96678793          	addi	a5,a5,-1690 # 15b8 <base>
     c5a:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     c5e:	fe043783          	ld	a5,-32(s0)
     c62:	639c                	ld	a5,0(a5)
     c64:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     c68:	fe843783          	ld	a5,-24(s0)
     c6c:	4798                	lw	a4,8(a5)
     c6e:	fdc42783          	lw	a5,-36(s0)
     c72:	2781                	sext.w	a5,a5
     c74:	06f76863          	bltu	a4,a5,ce4 <malloc+0xf2>
      if(p->s.size == nunits)
     c78:	fe843783          	ld	a5,-24(s0)
     c7c:	4798                	lw	a4,8(a5)
     c7e:	fdc42783          	lw	a5,-36(s0)
     c82:	2781                	sext.w	a5,a5
     c84:	00e79963          	bne	a5,a4,c96 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
     c88:	fe843783          	ld	a5,-24(s0)
     c8c:	6398                	ld	a4,0(a5)
     c8e:	fe043783          	ld	a5,-32(s0)
     c92:	e398                	sd	a4,0(a5)
     c94:	a82d                	j	cce <malloc+0xdc>
      else {
        p->s.size -= nunits;
     c96:	fe843783          	ld	a5,-24(s0)
     c9a:	4798                	lw	a4,8(a5)
     c9c:	fdc42783          	lw	a5,-36(s0)
     ca0:	40f707bb          	subw	a5,a4,a5
     ca4:	0007871b          	sext.w	a4,a5
     ca8:	fe843783          	ld	a5,-24(s0)
     cac:	c798                	sw	a4,8(a5)
        p += p->s.size;
     cae:	fe843783          	ld	a5,-24(s0)
     cb2:	479c                	lw	a5,8(a5)
     cb4:	1782                	slli	a5,a5,0x20
     cb6:	9381                	srli	a5,a5,0x20
     cb8:	0792                	slli	a5,a5,0x4
     cba:	fe843703          	ld	a4,-24(s0)
     cbe:	97ba                	add	a5,a5,a4
     cc0:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
     cc4:	fe843783          	ld	a5,-24(s0)
     cc8:	fdc42703          	lw	a4,-36(s0)
     ccc:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
     cce:	00001797          	auipc	a5,0x1
     cd2:	8fa78793          	addi	a5,a5,-1798 # 15c8 <freep>
     cd6:	fe043703          	ld	a4,-32(s0)
     cda:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
     cdc:	fe843783          	ld	a5,-24(s0)
     ce0:	07c1                	addi	a5,a5,16
     ce2:	a091                	j	d26 <malloc+0x134>
    }
    if(p == freep)
     ce4:	00001797          	auipc	a5,0x1
     ce8:	8e478793          	addi	a5,a5,-1820 # 15c8 <freep>
     cec:	639c                	ld	a5,0(a5)
     cee:	fe843703          	ld	a4,-24(s0)
     cf2:	02f71063          	bne	a4,a5,d12 <malloc+0x120>
      if((p = morecore(nunits)) == 0)
     cf6:	fdc42783          	lw	a5,-36(s0)
     cfa:	853e                	mv	a0,a5
     cfc:	00000097          	auipc	ra,0x0
     d00:	e76080e7          	jalr	-394(ra) # b72 <morecore>
     d04:	fea43423          	sd	a0,-24(s0)
     d08:	fe843783          	ld	a5,-24(s0)
     d0c:	e399                	bnez	a5,d12 <malloc+0x120>
        return 0;
     d0e:	4781                	li	a5,0
     d10:	a819                	j	d26 <malloc+0x134>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     d12:	fe843783          	ld	a5,-24(s0)
     d16:	fef43023          	sd	a5,-32(s0)
     d1a:	fe843783          	ld	a5,-24(s0)
     d1e:	639c                	ld	a5,0(a5)
     d20:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     d24:	b791                	j	c68 <malloc+0x76>
  }
}
     d26:	853e                	mv	a0,a5
     d28:	70e2                	ld	ra,56(sp)
     d2a:	7442                	ld	s0,48(sp)
     d2c:	6121                	addi	sp,sp,64
     d2e:	8082                	ret

0000000000000d30 <setjmp>:
     d30:	e100                	sd	s0,0(a0)
     d32:	e504                	sd	s1,8(a0)
     d34:	01253823          	sd	s2,16(a0)
     d38:	01353c23          	sd	s3,24(a0)
     d3c:	03453023          	sd	s4,32(a0)
     d40:	03553423          	sd	s5,40(a0)
     d44:	03653823          	sd	s6,48(a0)
     d48:	03753c23          	sd	s7,56(a0)
     d4c:	05853023          	sd	s8,64(a0)
     d50:	05953423          	sd	s9,72(a0)
     d54:	05a53823          	sd	s10,80(a0)
     d58:	05b53c23          	sd	s11,88(a0)
     d5c:	06153023          	sd	ra,96(a0)
     d60:	06253423          	sd	sp,104(a0)
     d64:	4501                	li	a0,0
     d66:	8082                	ret

0000000000000d68 <longjmp>:
     d68:	6100                	ld	s0,0(a0)
     d6a:	6504                	ld	s1,8(a0)
     d6c:	01053903          	ld	s2,16(a0)
     d70:	01853983          	ld	s3,24(a0)
     d74:	02053a03          	ld	s4,32(a0)
     d78:	02853a83          	ld	s5,40(a0)
     d7c:	03053b03          	ld	s6,48(a0)
     d80:	03853b83          	ld	s7,56(a0)
     d84:	04053c03          	ld	s8,64(a0)
     d88:	04853c83          	ld	s9,72(a0)
     d8c:	05053d03          	ld	s10,80(a0)
     d90:	05853d83          	ld	s11,88(a0)
     d94:	06053083          	ld	ra,96(a0)
     d98:	06853103          	ld	sp,104(a0)
     d9c:	c199                	beqz	a1,da2 <longjmp_1>
     d9e:	852e                	mv	a0,a1
     da0:	8082                	ret

0000000000000da2 <longjmp_1>:
     da2:	4505                	li	a0,1
     da4:	8082                	ret

0000000000000da6 <list_empty>:
/**
 * list_empty - tests whether a list is empty
 * @head: the list to test.
 */
static inline int list_empty(const struct list_head *head)
{
     da6:	1101                	addi	sp,sp,-32
     da8:	ec22                	sd	s0,24(sp)
     daa:	1000                	addi	s0,sp,32
     dac:	fea43423          	sd	a0,-24(s0)
    return head->next == head;
     db0:	fe843783          	ld	a5,-24(s0)
     db4:	639c                	ld	a5,0(a5)
     db6:	fe843703          	ld	a4,-24(s0)
     dba:	40f707b3          	sub	a5,a4,a5
     dbe:	0017b793          	seqz	a5,a5
     dc2:	0ff7f793          	andi	a5,a5,255
     dc6:	2781                	sext.w	a5,a5
}
     dc8:	853e                	mv	a0,a5
     dca:	6462                	ld	s0,24(sp)
     dcc:	6105                	addi	sp,sp,32
     dce:	8082                	ret

0000000000000dd0 <schedule_default>:

#define NULL 0

/* default scheduling algorithm */
struct threads_sched_result schedule_default(struct threads_sched_args args)
{
     dd0:	715d                	addi	sp,sp,-80
     dd2:	e4a2                	sd	s0,72(sp)
     dd4:	e0a6                	sd	s1,64(sp)
     dd6:	0880                	addi	s0,sp,80
     dd8:	84aa                	mv	s1,a0
    struct thread *thread_with_smallest_id = NULL;
     dda:	fe043423          	sd	zero,-24(s0)
    struct thread *th = NULL;
     dde:	fe043023          	sd	zero,-32(s0)
    list_for_each_entry(th, args.run_queue, thread_list) {
     de2:	649c                	ld	a5,8(s1)
     de4:	639c                	ld	a5,0(a5)
     de6:	fcf43c23          	sd	a5,-40(s0)
     dea:	fd843783          	ld	a5,-40(s0)
     dee:	fd878793          	addi	a5,a5,-40
     df2:	fef43023          	sd	a5,-32(s0)
     df6:	a81d                	j	e2c <schedule_default+0x5c>
        if (thread_with_smallest_id == NULL || th->ID < thread_with_smallest_id->ID) {
     df8:	fe843783          	ld	a5,-24(s0)
     dfc:	cb89                	beqz	a5,e0e <schedule_default+0x3e>
     dfe:	fe043783          	ld	a5,-32(s0)
     e02:	5398                	lw	a4,32(a5)
     e04:	fe843783          	ld	a5,-24(s0)
     e08:	539c                	lw	a5,32(a5)
     e0a:	00f75663          	bge	a4,a5,e16 <schedule_default+0x46>
            thread_with_smallest_id = th;
     e0e:	fe043783          	ld	a5,-32(s0)
     e12:	fef43423          	sd	a5,-24(s0)
    list_for_each_entry(th, args.run_queue, thread_list) {
     e16:	fe043783          	ld	a5,-32(s0)
     e1a:	779c                	ld	a5,40(a5)
     e1c:	fcf43823          	sd	a5,-48(s0)
     e20:	fd043783          	ld	a5,-48(s0)
     e24:	fd878793          	addi	a5,a5,-40
     e28:	fef43023          	sd	a5,-32(s0)
     e2c:	fe043783          	ld	a5,-32(s0)
     e30:	02878713          	addi	a4,a5,40
     e34:	649c                	ld	a5,8(s1)
     e36:	fcf711e3          	bne	a4,a5,df8 <schedule_default+0x28>
        }
    }

    struct threads_sched_result r;
    if (thread_with_smallest_id != NULL) {
     e3a:	fe843783          	ld	a5,-24(s0)
     e3e:	cf89                	beqz	a5,e58 <schedule_default+0x88>
        r.scheduled_thread_list_member = &thread_with_smallest_id->thread_list;
     e40:	fe843783          	ld	a5,-24(s0)
     e44:	02878793          	addi	a5,a5,40
     e48:	faf43823          	sd	a5,-80(s0)
        r.allocated_time = thread_with_smallest_id->remaining_time;
     e4c:	fe843783          	ld	a5,-24(s0)
     e50:	47fc                	lw	a5,76(a5)
     e52:	faf42c23          	sw	a5,-72(s0)
     e56:	a039                	j	e64 <schedule_default+0x94>
    } else {
        r.scheduled_thread_list_member = args.run_queue;
     e58:	649c                	ld	a5,8(s1)
     e5a:	faf43823          	sd	a5,-80(s0)
        r.allocated_time = 1;
     e5e:	4785                	li	a5,1
     e60:	faf42c23          	sw	a5,-72(s0)
    }

    return r;
     e64:	fb043783          	ld	a5,-80(s0)
     e68:	fcf43023          	sd	a5,-64(s0)
     e6c:	fb843783          	ld	a5,-72(s0)
     e70:	fcf43423          	sd	a5,-56(s0)
     e74:	fc043703          	ld	a4,-64(s0)
     e78:	fc843783          	ld	a5,-56(s0)
     e7c:	863a                	mv	a2,a4
     e7e:	86be                	mv	a3,a5
     e80:	8732                	mv	a4,a2
     e82:	87b6                	mv	a5,a3
}
     e84:	853a                	mv	a0,a4
     e86:	85be                	mv	a1,a5
     e88:	6426                	ld	s0,72(sp)
     e8a:	6486                	ld	s1,64(sp)
     e8c:	6161                	addi	sp,sp,80
     e8e:	8082                	ret

0000000000000e90 <schedule_edf>:

/* Earliest-Deadline-First scheduling */
struct threads_sched_result schedule_edf(struct threads_sched_args args)
{
     e90:	7115                	addi	sp,sp,-224
     e92:	ed86                	sd	ra,216(sp)
     e94:	e9a2                	sd	s0,208(sp)
     e96:	e5a6                	sd	s1,200(sp)
     e98:	e1ca                	sd	s2,192(sp)
     e9a:	fd4e                	sd	s3,184(sp)
     e9c:	1180                	addi	s0,sp,224
     e9e:	84aa                	mv	s1,a0
    // the scheduling is called when a interrupt event happens (either a fn end or a new one is added)
    // need to determine the next thread to execute and the allocated time.

    struct threads_sched_result r;
    if(list_empty(args.run_queue)){
     ea0:	649c                	ld	a5,8(s1)
     ea2:	853e                	mv	a0,a5
     ea4:	00000097          	auipc	ra,0x0
     ea8:	f02080e7          	jalr	-254(ra) # da6 <list_empty>
     eac:	87aa                	mv	a5,a0
     eae:	c3d1                	beqz	a5,f32 <schedule_edf+0xa2>
        // SPEC 3
        r.scheduled_thread_list_member = args.run_queue;
     eb0:	649c                	ld	a5,8(s1)
     eb2:	f2f43423          	sd	a5,-216(s0)
        int least_release_time = 99999;
     eb6:	67e1                	lui	a5,0x18
     eb8:	69f78793          	addi	a5,a5,1695 # 1869f <__global_pointer$+0x168ff>
     ebc:	fcf42623          	sw	a5,-52(s0)
        struct release_queue_entry* cur;
        list_for_each_entry(cur, args.release_queue, thread_list) {
     ec0:	689c                	ld	a5,16(s1)
     ec2:	639c                	ld	a5,0(a5)
     ec4:	f4f43823          	sd	a5,-176(s0)
     ec8:	f5043783          	ld	a5,-176(s0)
     ecc:	17e1                	addi	a5,a5,-8
     ece:	fcf43023          	sd	a5,-64(s0)
     ed2:	a805                	j	f02 <schedule_edf+0x72>
            if(cur->release_time<least_release_time){
     ed4:	fc043783          	ld	a5,-64(s0)
     ed8:	4f98                	lw	a4,24(a5)
     eda:	fcc42783          	lw	a5,-52(s0)
     ede:	2781                	sext.w	a5,a5
     ee0:	00f75763          	bge	a4,a5,eee <schedule_edf+0x5e>
                least_release_time = cur->release_time;
     ee4:	fc043783          	ld	a5,-64(s0)
     ee8:	4f9c                	lw	a5,24(a5)
     eea:	fcf42623          	sw	a5,-52(s0)
        list_for_each_entry(cur, args.release_queue, thread_list) {
     eee:	fc043783          	ld	a5,-64(s0)
     ef2:	679c                	ld	a5,8(a5)
     ef4:	f4f43423          	sd	a5,-184(s0)
     ef8:	f4843783          	ld	a5,-184(s0)
     efc:	17e1                	addi	a5,a5,-8
     efe:	fcf43023          	sd	a5,-64(s0)
     f02:	fc043783          	ld	a5,-64(s0)
     f06:	00878713          	addi	a4,a5,8
     f0a:	689c                	ld	a5,16(s1)
     f0c:	fcf714e3          	bne	a4,a5,ed4 <schedule_edf+0x44>
            }
        }
        r.allocated_time = least_release_time - args.current_time ;
     f10:	409c                	lw	a5,0(s1)
     f12:	fcc42703          	lw	a4,-52(s0)
     f16:	40f707bb          	subw	a5,a4,a5
     f1a:	2781                	sext.w	a5,a5
     f1c:	f2f42823          	sw	a5,-208(s0)
        return r;
     f20:	f2843783          	ld	a5,-216(s0)
     f24:	f2f43c23          	sd	a5,-200(s0)
     f28:	f3043783          	ld	a5,-208(s0)
     f2c:	f4f43023          	sd	a5,-192(s0)
     f30:	a4e5                	j	1218 <schedule_edf+0x388>
    }else{
        // run queue is not empty.
        struct thread *th = NULL;
     f32:	fa043c23          	sd	zero,-72(s0)
        struct thread *min_th = NULL;
     f36:	fa043823          	sd	zero,-80(s0)
        struct thread *min_miss_deadline_th = NULL;
     f3a:	fa043423          	sd	zero,-88(s0)
        list_for_each_entry(th, args.run_queue, thread_list) {
     f3e:	649c                	ld	a5,8(s1)
     f40:	639c                	ld	a5,0(a5)
     f42:	f8f43423          	sd	a5,-120(s0)
     f46:	f8843783          	ld	a5,-120(s0)
     f4a:	fd878793          	addi	a5,a5,-40
     f4e:	faf43c23          	sd	a5,-72(s0)
     f52:	a849                	j	fe4 <schedule_edf+0x154>
            // printf("in run queue: %d\n", th->ID);
            if(th->current_deadline <= args.current_time){
     f54:	fb843783          	ld	a5,-72(s0)
     f58:	4bb8                	lw	a4,80(a5)
     f5a:	409c                	lw	a5,0(s1)
     f5c:	02e7c163          	blt	a5,a4,f7e <schedule_edf+0xee>
                if(min_miss_deadline_th == NULL || th->ID<min_miss_deadline_th->ID){
     f60:	fa843783          	ld	a5,-88(s0)
     f64:	cb89                	beqz	a5,f76 <schedule_edf+0xe6>
     f66:	fb843783          	ld	a5,-72(s0)
     f6a:	5398                	lw	a4,32(a5)
     f6c:	fa843783          	ld	a5,-88(s0)
     f70:	539c                	lw	a5,32(a5)
     f72:	00f75663          	bge	a4,a5,f7e <schedule_edf+0xee>
                    min_miss_deadline_th = th;
     f76:	fb843783          	ld	a5,-72(s0)
     f7a:	faf43423          	sd	a5,-88(s0)
                }
            }
            if(min_th == NULL) min_th = th;
     f7e:	fb043783          	ld	a5,-80(s0)
     f82:	e789                	bnez	a5,f8c <schedule_edf+0xfc>
     f84:	fb843783          	ld	a5,-72(s0)
     f88:	faf43823          	sd	a5,-80(s0)
            if(th->current_deadline<min_th->current_deadline){
     f8c:	fb843783          	ld	a5,-72(s0)
     f90:	4bb8                	lw	a4,80(a5)
     f92:	fb043783          	ld	a5,-80(s0)
     f96:	4bbc                	lw	a5,80(a5)
     f98:	00f75763          	bge	a4,a5,fa6 <schedule_edf+0x116>
                min_th = th;
     f9c:	fb843783          	ld	a5,-72(s0)
     fa0:	faf43823          	sd	a5,-80(s0)
     fa4:	a02d                	j	fce <schedule_edf+0x13e>
            }else if(th->current_deadline == min_th->current_deadline){
     fa6:	fb843783          	ld	a5,-72(s0)
     faa:	4bb8                	lw	a4,80(a5)
     fac:	fb043783          	ld	a5,-80(s0)
     fb0:	4bbc                	lw	a5,80(a5)
     fb2:	00f71e63          	bne	a4,a5,fce <schedule_edf+0x13e>
                if(th->ID<min_th->ID) min_th = th;
     fb6:	fb843783          	ld	a5,-72(s0)
     fba:	5398                	lw	a4,32(a5)
     fbc:	fb043783          	ld	a5,-80(s0)
     fc0:	539c                	lw	a5,32(a5)
     fc2:	00f75663          	bge	a4,a5,fce <schedule_edf+0x13e>
     fc6:	fb843783          	ld	a5,-72(s0)
     fca:	faf43823          	sd	a5,-80(s0)
        list_for_each_entry(th, args.run_queue, thread_list) {
     fce:	fb843783          	ld	a5,-72(s0)
     fd2:	779c                	ld	a5,40(a5)
     fd4:	f4f43c23          	sd	a5,-168(s0)
     fd8:	f5843783          	ld	a5,-168(s0)
     fdc:	fd878793          	addi	a5,a5,-40
     fe0:	faf43c23          	sd	a5,-72(s0)
     fe4:	fb843783          	ld	a5,-72(s0)
     fe8:	02878713          	addi	a4,a5,40
     fec:	649c                	ld	a5,8(s1)
     fee:	f6f713e3          	bne	a4,a5,f54 <schedule_edf+0xc4>
            }
        }

        if(min_miss_deadline_th != NULL) {
     ff2:	fa843783          	ld	a5,-88(s0)
     ff6:	c395                	beqz	a5,101a <schedule_edf+0x18a>
            // SPEC 4: exist missed deadline
            // printf("exist missed deadline", th->ID);
            r.allocated_time = 0;
     ff8:	f2042823          	sw	zero,-208(s0)
            r.scheduled_thread_list_member = &min_miss_deadline_th->thread_list;
     ffc:	fa843783          	ld	a5,-88(s0)
    1000:	02878793          	addi	a5,a5,40
    1004:	f2f43423          	sd	a5,-216(s0)
            return r;
    1008:	f2843783          	ld	a5,-216(s0)
    100c:	f2f43c23          	sd	a5,-200(s0)
    1010:	f3043783          	ld	a5,-208(s0)
    1014:	f4f43023          	sd	a5,-192(s0)
    1018:	a401                	j	1218 <schedule_edf+0x388>
             // compute allocated time: 
            // 1. a preemption can happen in the future.(need to inspect the release queue)
            // 2. current deadline is met (preemption has not happened)
            // 3. current deadline is missed (current_time + remaining_time > current_deadline)
            // compute the first event that will happen.
            r.scheduled_thread_list_member = &min_th->thread_list;
    101a:	fb043783          	ld	a5,-80(s0)
    101e:	02878793          	addi	a5,a5,40
    1022:	f2f43423          	sd	a5,-216(s0)

            struct release_queue_entry* cur;
            if(list_empty(args.release_queue)){
    1026:	689c                	ld	a5,16(s1)
    1028:	853e                	mv	a0,a5
    102a:	00000097          	auipc	ra,0x0
    102e:	d7c080e7          	jalr	-644(ra) # da6 <list_empty>
    1032:	87aa                	mv	a5,a0
    1034:	c3b5                	beqz	a5,1098 <schedule_edf+0x208>
                // printf("release queue is empty\n");
                // a preemption cannot happen, because we've already selected the highest priority thread.
                int remaining_time = 99999;
    1036:	67e1                	lui	a5,0x18
    1038:	69f78793          	addi	a5,a5,1695 # 1869f <__global_pointer$+0x168ff>
    103c:	f6f42623          	sw	a5,-148(s0)

                int deadline_time = min_th->current_deadline - args.current_time;
    1040:	fb043783          	ld	a5,-80(s0)
    1044:	4bb8                	lw	a4,80(a5)
    1046:	409c                	lw	a5,0(s1)
    1048:	40f707bb          	subw	a5,a4,a5
    104c:	f6f42423          	sw	a5,-152(s0)
                remaining_time = deadline_time<remaining_time? deadline_time: remaining_time;
    1050:	f6842603          	lw	a2,-152(s0)
    1054:	f6c42783          	lw	a5,-148(s0)
    1058:	0007869b          	sext.w	a3,a5
    105c:	0006071b          	sext.w	a4,a2
    1060:	00d75363          	bge	a4,a3,1066 <schedule_edf+0x1d6>
    1064:	87b2                	mv	a5,a2
    1066:	f6f42623          	sw	a5,-148(s0)
                int met_time = min_th->remaining_time;
    106a:	fb043783          	ld	a5,-80(s0)
    106e:	47fc                	lw	a5,76(a5)
    1070:	f6f42223          	sw	a5,-156(s0)
                remaining_time = met_time<remaining_time? met_time: remaining_time;
    1074:	f6442603          	lw	a2,-156(s0)
    1078:	f6c42783          	lw	a5,-148(s0)
    107c:	0007869b          	sext.w	a3,a5
    1080:	0006071b          	sext.w	a4,a2
    1084:	00d75363          	bge	a4,a3,108a <schedule_edf+0x1fa>
    1088:	87b2                	mv	a5,a2
    108a:	f6f42623          	sw	a5,-148(s0)
                r.allocated_time = remaining_time;
    108e:	f6c42783          	lw	a5,-148(s0)
    1092:	f2f42823          	sw	a5,-208(s0)
    1096:	aa8d                	j	1208 <schedule_edf+0x378>
            }else{
                // first check if a preemption can happen
                struct release_queue_entry* cur_min = NULL;
    1098:	f8043c23          	sd	zero,-104(s0)
                int remaining_time = 99999;
    109c:	67e1                	lui	a5,0x18
    109e:	69f78793          	addi	a5,a5,1695 # 1869f <__global_pointer$+0x168ff>
    10a2:	f8f42a23          	sw	a5,-108(s0)
                list_for_each_entry(cur, args.release_queue, thread_list) {
    10a6:	689c                	ld	a5,16(s1)
    10a8:	639c                	ld	a5,0(a5)
    10aa:	f8f43023          	sd	a5,-128(s0)
    10ae:	f8043783          	ld	a5,-128(s0)
    10b2:	17e1                	addi	a5,a5,-8
    10b4:	faf43023          	sd	a5,-96(s0)
    10b8:	a8d9                	j	118e <schedule_edf+0x2fe>
                    if((cur->thrd->period + cur->release_time < min_th->current_deadline) && cur->thrd->n != 0){
    10ba:	fa043783          	ld	a5,-96(s0)
    10be:	639c                	ld	a5,0(a5)
    10c0:	43f8                	lw	a4,68(a5)
    10c2:	fa043783          	ld	a5,-96(s0)
    10c6:	4f9c                	lw	a5,24(a5)
    10c8:	9fb9                	addw	a5,a5,a4
    10ca:	0007871b          	sext.w	a4,a5
    10ce:	fb043783          	ld	a5,-80(s0)
    10d2:	4bbc                	lw	a5,80(a5)
    10d4:	0af75363          	bge	a4,a5,117a <schedule_edf+0x2ea>
    10d8:	fa043783          	ld	a5,-96(s0)
    10dc:	639c                	ld	a5,0(a5)
    10de:	47bc                	lw	a5,72(a5)
    10e0:	cfc9                	beqz	a5,117a <schedule_edf+0x2ea>
                        // printf("preemption can occur: %d %d %d\n", cur->thrd->period , cur->release_time , min_th->current_deadline);
                        // a preemption can occur
                        if(cur_min == NULL){
    10e2:	f9843783          	ld	a5,-104(s0)
    10e6:	e791                	bnez	a5,10f2 <schedule_edf+0x262>
                            cur_min = cur;
    10e8:	fa043783          	ld	a5,-96(s0)
    10ec:	f8f43c23          	sd	a5,-104(s0)
    10f0:	a069                	j	117a <schedule_edf+0x2ea>
                        }else{
                            if((cur->thrd->period + cur->release_time < cur_min->thrd->period + cur_min->release_time)&& cur->thrd->n != 0){
    10f2:	fa043783          	ld	a5,-96(s0)
    10f6:	639c                	ld	a5,0(a5)
    10f8:	43f8                	lw	a4,68(a5)
    10fa:	fa043783          	ld	a5,-96(s0)
    10fe:	4f9c                	lw	a5,24(a5)
    1100:	9fb9                	addw	a5,a5,a4
    1102:	0007869b          	sext.w	a3,a5
    1106:	f9843783          	ld	a5,-104(s0)
    110a:	639c                	ld	a5,0(a5)
    110c:	43f8                	lw	a4,68(a5)
    110e:	f9843783          	ld	a5,-104(s0)
    1112:	4f9c                	lw	a5,24(a5)
    1114:	9fb9                	addw	a5,a5,a4
    1116:	2781                	sext.w	a5,a5
    1118:	8736                	mv	a4,a3
    111a:	00f75c63          	bge	a4,a5,1132 <schedule_edf+0x2a2>
    111e:	fa043783          	ld	a5,-96(s0)
    1122:	639c                	ld	a5,0(a5)
    1124:	47bc                	lw	a5,72(a5)
    1126:	c791                	beqz	a5,1132 <schedule_edf+0x2a2>
                                cur_min = cur;
    1128:	fa043783          	ld	a5,-96(s0)
    112c:	f8f43c23          	sd	a5,-104(s0)
    1130:	a0a9                	j	117a <schedule_edf+0x2ea>
                            }else if(cur->thrd->period + cur->release_time == cur_min->thrd->period + cur_min->release_time){
    1132:	fa043783          	ld	a5,-96(s0)
    1136:	639c                	ld	a5,0(a5)
    1138:	43f8                	lw	a4,68(a5)
    113a:	fa043783          	ld	a5,-96(s0)
    113e:	4f9c                	lw	a5,24(a5)
    1140:	9fb9                	addw	a5,a5,a4
    1142:	0007869b          	sext.w	a3,a5
    1146:	f9843783          	ld	a5,-104(s0)
    114a:	639c                	ld	a5,0(a5)
    114c:	43f8                	lw	a4,68(a5)
    114e:	f9843783          	ld	a5,-104(s0)
    1152:	4f9c                	lw	a5,24(a5)
    1154:	9fb9                	addw	a5,a5,a4
    1156:	2781                	sext.w	a5,a5
    1158:	8736                	mv	a4,a3
    115a:	02f71063          	bne	a4,a5,117a <schedule_edf+0x2ea>
                                if(cur_min->thrd->ID > cur->thrd->ID){
    115e:	f9843783          	ld	a5,-104(s0)
    1162:	639c                	ld	a5,0(a5)
    1164:	5398                	lw	a4,32(a5)
    1166:	fa043783          	ld	a5,-96(s0)
    116a:	639c                	ld	a5,0(a5)
    116c:	539c                	lw	a5,32(a5)
    116e:	00e7d663          	bge	a5,a4,117a <schedule_edf+0x2ea>
                                    cur_min = cur;
    1172:	fa043783          	ld	a5,-96(s0)
    1176:	f8f43c23          	sd	a5,-104(s0)
                list_for_each_entry(cur, args.release_queue, thread_list) {
    117a:	fa043783          	ld	a5,-96(s0)
    117e:	679c                	ld	a5,8(a5)
    1180:	f6f43823          	sd	a5,-144(s0)
    1184:	f7043783          	ld	a5,-144(s0)
    1188:	17e1                	addi	a5,a5,-8
    118a:	faf43023          	sd	a5,-96(s0)
    118e:	fa043783          	ld	a5,-96(s0)
    1192:	00878713          	addi	a4,a5,8
    1196:	689c                	ld	a5,16(s1)
    1198:	f2f711e3          	bne	a4,a5,10ba <schedule_edf+0x22a>
                                }
                            }
                        }
                    }
                }
                if(cur_min != NULL){
    119c:	f9843783          	ld	a5,-104(s0)
    11a0:	cb89                	beqz	a5,11b2 <schedule_edf+0x322>
                    // a preemption is possible
                    remaining_time = cur_min->release_time - args.current_time;
    11a2:	f9843783          	ld	a5,-104(s0)
    11a6:	4f98                	lw	a4,24(a5)
    11a8:	409c                	lw	a5,0(s1)
    11aa:	40f707bb          	subw	a5,a4,a5
    11ae:	f8f42a23          	sw	a5,-108(s0)
                }
                int deadline_time = min_th->current_deadline - args.current_time;
    11b2:	fb043783          	ld	a5,-80(s0)
    11b6:	4bb8                	lw	a4,80(a5)
    11b8:	409c                	lw	a5,0(s1)
    11ba:	40f707bb          	subw	a5,a4,a5
    11be:	f6f42e23          	sw	a5,-132(s0)
                remaining_time = deadline_time<remaining_time? deadline_time: remaining_time;
    11c2:	f7c42603          	lw	a2,-132(s0)
    11c6:	f9442783          	lw	a5,-108(s0)
    11ca:	0007869b          	sext.w	a3,a5
    11ce:	0006071b          	sext.w	a4,a2
    11d2:	00d75363          	bge	a4,a3,11d8 <schedule_edf+0x348>
    11d6:	87b2                	mv	a5,a2
    11d8:	f8f42a23          	sw	a5,-108(s0)
                int met_time = min_th->remaining_time;
    11dc:	fb043783          	ld	a5,-80(s0)
    11e0:	47fc                	lw	a5,76(a5)
    11e2:	f6f42c23          	sw	a5,-136(s0)
                remaining_time = met_time<remaining_time? met_time: remaining_time;
    11e6:	f7842603          	lw	a2,-136(s0)
    11ea:	f9442783          	lw	a5,-108(s0)
    11ee:	0007869b          	sext.w	a3,a5
    11f2:	0006071b          	sext.w	a4,a2
    11f6:	00d75363          	bge	a4,a3,11fc <schedule_edf+0x36c>
    11fa:	87b2                	mv	a5,a2
    11fc:	f8f42a23          	sw	a5,-108(s0)
                r.allocated_time = remaining_time;
    1200:	f9442783          	lw	a5,-108(s0)
    1204:	f2f42823          	sw	a5,-208(s0)
            }

            return r;
    1208:	f2843783          	ld	a5,-216(s0)
    120c:	f2f43c23          	sd	a5,-200(s0)
    1210:	f3043783          	ld	a5,-208(s0)
    1214:	f4f43023          	sd	a5,-192(s0)
        }
    }

    return schedule_default(args);
}
    1218:	f3843703          	ld	a4,-200(s0)
    121c:	f4043783          	ld	a5,-192(s0)
    1220:	893a                	mv	s2,a4
    1222:	89be                	mv	s3,a5
    1224:	874a                	mv	a4,s2
    1226:	87ce                	mv	a5,s3
    1228:	853a                	mv	a0,a4
    122a:	85be                	mv	a1,a5
    122c:	60ee                	ld	ra,216(sp)
    122e:	644e                	ld	s0,208(sp)
    1230:	64ae                	ld	s1,200(sp)
    1232:	690e                	ld	s2,192(sp)
    1234:	79ea                	ld	s3,184(sp)
    1236:	612d                	addi	sp,sp,224
    1238:	8082                	ret

000000000000123a <schedule_rm>:

/* Rate-Monotonic Scheduling */
struct threads_sched_result schedule_rm(struct threads_sched_args args)
{
    123a:	7115                	addi	sp,sp,-224
    123c:	ed86                	sd	ra,216(sp)
    123e:	e9a2                	sd	s0,208(sp)
    1240:	e5a6                	sd	s1,200(sp)
    1242:	e1ca                	sd	s2,192(sp)
    1244:	fd4e                	sd	s3,184(sp)
    1246:	1180                	addi	s0,sp,224
    1248:	84aa                	mv	s1,a0
    
    struct threads_sched_result r;
    if(list_empty(args.run_queue)){
    124a:	649c                	ld	a5,8(s1)
    124c:	853e                	mv	a0,a5
    124e:	00000097          	auipc	ra,0x0
    1252:	b58080e7          	jalr	-1192(ra) # da6 <list_empty>
    1256:	87aa                	mv	a5,a0
    1258:	c3d1                	beqz	a5,12dc <schedule_rm+0xa2>
        // SPEC 3
        r.scheduled_thread_list_member = args.run_queue;
    125a:	649c                	ld	a5,8(s1)
    125c:	f2f43423          	sd	a5,-216(s0)
        int least_release_time = 99999;
    1260:	67e1                	lui	a5,0x18
    1262:	69f78793          	addi	a5,a5,1695 # 1869f <__global_pointer$+0x168ff>
    1266:	fcf42623          	sw	a5,-52(s0)
        struct release_queue_entry* cur;
        list_for_each_entry(cur, args.release_queue, thread_list) {
    126a:	689c                	ld	a5,16(s1)
    126c:	639c                	ld	a5,0(a5)
    126e:	f4f43823          	sd	a5,-176(s0)
    1272:	f5043783          	ld	a5,-176(s0)
    1276:	17e1                	addi	a5,a5,-8
    1278:	fcf43023          	sd	a5,-64(s0)
    127c:	a805                	j	12ac <schedule_rm+0x72>
            if(cur->release_time<least_release_time){
    127e:	fc043783          	ld	a5,-64(s0)
    1282:	4f98                	lw	a4,24(a5)
    1284:	fcc42783          	lw	a5,-52(s0)
    1288:	2781                	sext.w	a5,a5
    128a:	00f75763          	bge	a4,a5,1298 <schedule_rm+0x5e>
                least_release_time = cur->release_time;
    128e:	fc043783          	ld	a5,-64(s0)
    1292:	4f9c                	lw	a5,24(a5)
    1294:	fcf42623          	sw	a5,-52(s0)
        list_for_each_entry(cur, args.release_queue, thread_list) {
    1298:	fc043783          	ld	a5,-64(s0)
    129c:	679c                	ld	a5,8(a5)
    129e:	f4f43423          	sd	a5,-184(s0)
    12a2:	f4843783          	ld	a5,-184(s0)
    12a6:	17e1                	addi	a5,a5,-8
    12a8:	fcf43023          	sd	a5,-64(s0)
    12ac:	fc043783          	ld	a5,-64(s0)
    12b0:	00878713          	addi	a4,a5,8
    12b4:	689c                	ld	a5,16(s1)
    12b6:	fcf714e3          	bne	a4,a5,127e <schedule_rm+0x44>
            }
        }
        r.allocated_time = least_release_time - args.current_time ;
    12ba:	409c                	lw	a5,0(s1)
    12bc:	fcc42703          	lw	a4,-52(s0)
    12c0:	40f707bb          	subw	a5,a4,a5
    12c4:	2781                	sext.w	a5,a5
    12c6:	f2f42823          	sw	a5,-208(s0)
        return r;
    12ca:	f2843783          	ld	a5,-216(s0)
    12ce:	f2f43c23          	sd	a5,-200(s0)
    12d2:	f3043783          	ld	a5,-208(s0)
    12d6:	f4f43023          	sd	a5,-192(s0)
    12da:	ac61                	j	1572 <schedule_rm+0x338>
    }else{
        // run queue is not empty.
        struct thread *th = NULL;
    12dc:	fa043c23          	sd	zero,-72(s0)
        struct thread *min_th = NULL;
    12e0:	fa043823          	sd	zero,-80(s0)
        struct thread *min_miss_deadline_th = NULL;
    12e4:	fa043423          	sd	zero,-88(s0)
        list_for_each_entry(th, args.run_queue, thread_list) {
    12e8:	649c                	ld	a5,8(s1)
    12ea:	639c                	ld	a5,0(a5)
    12ec:	f8f43423          	sd	a5,-120(s0)
    12f0:	f8843783          	ld	a5,-120(s0)
    12f4:	fd878793          	addi	a5,a5,-40
    12f8:	faf43c23          	sd	a5,-72(s0)
    12fc:	a849                	j	138e <schedule_rm+0x154>
            if(th->current_deadline <= args.current_time){
    12fe:	fb843783          	ld	a5,-72(s0)
    1302:	4bb8                	lw	a4,80(a5)
    1304:	409c                	lw	a5,0(s1)
    1306:	02e7c163          	blt	a5,a4,1328 <schedule_rm+0xee>
                if(min_miss_deadline_th == NULL || th->ID<min_miss_deadline_th->ID){
    130a:	fa843783          	ld	a5,-88(s0)
    130e:	cb89                	beqz	a5,1320 <schedule_rm+0xe6>
    1310:	fb843783          	ld	a5,-72(s0)
    1314:	5398                	lw	a4,32(a5)
    1316:	fa843783          	ld	a5,-88(s0)
    131a:	539c                	lw	a5,32(a5)
    131c:	00f75663          	bge	a4,a5,1328 <schedule_rm+0xee>
                    min_miss_deadline_th = th;
    1320:	fb843783          	ld	a5,-72(s0)
    1324:	faf43423          	sd	a5,-88(s0)
                }
            }
            if(min_th == NULL) min_th = th;
    1328:	fb043783          	ld	a5,-80(s0)
    132c:	e789                	bnez	a5,1336 <schedule_rm+0xfc>
    132e:	fb843783          	ld	a5,-72(s0)
    1332:	faf43823          	sd	a5,-80(s0)
            if(th->period<min_th->period){
    1336:	fb843783          	ld	a5,-72(s0)
    133a:	43f8                	lw	a4,68(a5)
    133c:	fb043783          	ld	a5,-80(s0)
    1340:	43fc                	lw	a5,68(a5)
    1342:	00f75763          	bge	a4,a5,1350 <schedule_rm+0x116>
                min_th = th;
    1346:	fb843783          	ld	a5,-72(s0)
    134a:	faf43823          	sd	a5,-80(s0)
    134e:	a02d                	j	1378 <schedule_rm+0x13e>
            }else if(th->period == min_th->period){
    1350:	fb843783          	ld	a5,-72(s0)
    1354:	43f8                	lw	a4,68(a5)
    1356:	fb043783          	ld	a5,-80(s0)
    135a:	43fc                	lw	a5,68(a5)
    135c:	00f71e63          	bne	a4,a5,1378 <schedule_rm+0x13e>
                if(th->ID<min_th->ID) min_th = th;
    1360:	fb843783          	ld	a5,-72(s0)
    1364:	5398                	lw	a4,32(a5)
    1366:	fb043783          	ld	a5,-80(s0)
    136a:	539c                	lw	a5,32(a5)
    136c:	00f75663          	bge	a4,a5,1378 <schedule_rm+0x13e>
    1370:	fb843783          	ld	a5,-72(s0)
    1374:	faf43823          	sd	a5,-80(s0)
        list_for_each_entry(th, args.run_queue, thread_list) {
    1378:	fb843783          	ld	a5,-72(s0)
    137c:	779c                	ld	a5,40(a5)
    137e:	f4f43c23          	sd	a5,-168(s0)
    1382:	f5843783          	ld	a5,-168(s0)
    1386:	fd878793          	addi	a5,a5,-40
    138a:	faf43c23          	sd	a5,-72(s0)
    138e:	fb843783          	ld	a5,-72(s0)
    1392:	02878713          	addi	a4,a5,40
    1396:	649c                	ld	a5,8(s1)
    1398:	f6f713e3          	bne	a4,a5,12fe <schedule_rm+0xc4>
            }
        }

        if(min_miss_deadline_th != NULL) {
    139c:	fa843783          	ld	a5,-88(s0)
    13a0:	c395                	beqz	a5,13c4 <schedule_rm+0x18a>
            // SPEC 4: exist missed deadline
            r.allocated_time = 0;
    13a2:	f2042823          	sw	zero,-208(s0)
            r.scheduled_thread_list_member = &min_miss_deadline_th->thread_list;
    13a6:	fa843783          	ld	a5,-88(s0)
    13aa:	02878793          	addi	a5,a5,40
    13ae:	f2f43423          	sd	a5,-216(s0)
            return r;
    13b2:	f2843783          	ld	a5,-216(s0)
    13b6:	f2f43c23          	sd	a5,-200(s0)
    13ba:	f3043783          	ld	a5,-208(s0)
    13be:	f4f43023          	sd	a5,-192(s0)
    13c2:	aa45                	j	1572 <schedule_rm+0x338>
             // compute allocated time: 
            // 1. a preemption can happen in the future.(need to inspect the release queue)
            // 2. current deadline is met (preemption has not happened)
            // 3. current deadline is missed (current_time + remaining_time > current_deadline)
            // compute the first event that will happen.
            r.scheduled_thread_list_member = &min_th->thread_list;
    13c4:	fb043783          	ld	a5,-80(s0)
    13c8:	02878793          	addi	a5,a5,40
    13cc:	f2f43423          	sd	a5,-216(s0)

            struct release_queue_entry* cur;
            if(list_empty(args.release_queue)){
    13d0:	689c                	ld	a5,16(s1)
    13d2:	853e                	mv	a0,a5
    13d4:	00000097          	auipc	ra,0x0
    13d8:	9d2080e7          	jalr	-1582(ra) # da6 <list_empty>
    13dc:	87aa                	mv	a5,a0
    13de:	c3b5                	beqz	a5,1442 <schedule_rm+0x208>
                // a preemption cannot happen, because we've already selected the highest priority thread.
                int remaining_time = 99999;
    13e0:	67e1                	lui	a5,0x18
    13e2:	69f78793          	addi	a5,a5,1695 # 1869f <__global_pointer$+0x168ff>
    13e6:	f6f42623          	sw	a5,-148(s0)

                int deadline_time = min_th->current_deadline - args.current_time;
    13ea:	fb043783          	ld	a5,-80(s0)
    13ee:	4bb8                	lw	a4,80(a5)
    13f0:	409c                	lw	a5,0(s1)
    13f2:	40f707bb          	subw	a5,a4,a5
    13f6:	f6f42423          	sw	a5,-152(s0)
                remaining_time = deadline_time<remaining_time? deadline_time: remaining_time;
    13fa:	f6842603          	lw	a2,-152(s0)
    13fe:	f6c42783          	lw	a5,-148(s0)
    1402:	0007869b          	sext.w	a3,a5
    1406:	0006071b          	sext.w	a4,a2
    140a:	00d75363          	bge	a4,a3,1410 <schedule_rm+0x1d6>
    140e:	87b2                	mv	a5,a2
    1410:	f6f42623          	sw	a5,-148(s0)
                int met_time = min_th->remaining_time;
    1414:	fb043783          	ld	a5,-80(s0)
    1418:	47fc                	lw	a5,76(a5)
    141a:	f6f42223          	sw	a5,-156(s0)
                remaining_time = met_time<remaining_time? met_time: remaining_time;
    141e:	f6442603          	lw	a2,-156(s0)
    1422:	f6c42783          	lw	a5,-148(s0)
    1426:	0007869b          	sext.w	a3,a5
    142a:	0006071b          	sext.w	a4,a2
    142e:	00d75363          	bge	a4,a3,1434 <schedule_rm+0x1fa>
    1432:	87b2                	mv	a5,a2
    1434:	f6f42623          	sw	a5,-148(s0)
                
                r.allocated_time = remaining_time;
    1438:	f6c42783          	lw	a5,-148(s0)
    143c:	f2f42823          	sw	a5,-208(s0)
    1440:	a20d                	j	1562 <schedule_rm+0x328>
            }else{
                // first check if a preemption can happen
                struct release_queue_entry* cur_min = NULL;
    1442:	f8043c23          	sd	zero,-104(s0)
                int remaining_time = 99999;
    1446:	67e1                	lui	a5,0x18
    1448:	69f78793          	addi	a5,a5,1695 # 1869f <__global_pointer$+0x168ff>
    144c:	f8f42a23          	sw	a5,-108(s0)
                list_for_each_entry(cur, args.release_queue, thread_list) {
    1450:	689c                	ld	a5,16(s1)
    1452:	639c                	ld	a5,0(a5)
    1454:	f8f43023          	sd	a5,-128(s0)
    1458:	f8043783          	ld	a5,-128(s0)
    145c:	17e1                	addi	a5,a5,-8
    145e:	faf43023          	sd	a5,-96(s0)
    1462:	a059                	j	14e8 <schedule_rm+0x2ae>
                    if(cur->thrd->period<min_th->period){
    1464:	fa043783          	ld	a5,-96(s0)
    1468:	639c                	ld	a5,0(a5)
    146a:	43f8                	lw	a4,68(a5)
    146c:	fb043783          	ld	a5,-80(s0)
    1470:	43fc                	lw	a5,68(a5)
    1472:	06f75163          	bge	a4,a5,14d4 <schedule_rm+0x29a>
                        // a preemption can occur
                        if(cur_min == NULL){
    1476:	f9843783          	ld	a5,-104(s0)
    147a:	e791                	bnez	a5,1486 <schedule_rm+0x24c>
                            cur_min = cur;
    147c:	fa043783          	ld	a5,-96(s0)
    1480:	f8f43c23          	sd	a5,-104(s0)
    1484:	a881                	j	14d4 <schedule_rm+0x29a>
                        }else{
                            if(cur_min->thrd->period>cur->thrd->period){
    1486:	f9843783          	ld	a5,-104(s0)
    148a:	639c                	ld	a5,0(a5)
    148c:	43f8                	lw	a4,68(a5)
    148e:	fa043783          	ld	a5,-96(s0)
    1492:	639c                	ld	a5,0(a5)
    1494:	43fc                	lw	a5,68(a5)
    1496:	00e7d763          	bge	a5,a4,14a4 <schedule_rm+0x26a>
                                cur_min = cur;
    149a:	fa043783          	ld	a5,-96(s0)
    149e:	f8f43c23          	sd	a5,-104(s0)
    14a2:	a80d                	j	14d4 <schedule_rm+0x29a>
                            }else if(cur_min->thrd->period == cur->thrd->period){
    14a4:	f9843783          	ld	a5,-104(s0)
    14a8:	639c                	ld	a5,0(a5)
    14aa:	43f8                	lw	a4,68(a5)
    14ac:	fa043783          	ld	a5,-96(s0)
    14b0:	639c                	ld	a5,0(a5)
    14b2:	43fc                	lw	a5,68(a5)
    14b4:	02f71063          	bne	a4,a5,14d4 <schedule_rm+0x29a>
                                if(cur_min->thrd->ID > cur->thrd->ID){
    14b8:	f9843783          	ld	a5,-104(s0)
    14bc:	639c                	ld	a5,0(a5)
    14be:	5398                	lw	a4,32(a5)
    14c0:	fa043783          	ld	a5,-96(s0)
    14c4:	639c                	ld	a5,0(a5)
    14c6:	539c                	lw	a5,32(a5)
    14c8:	00e7d663          	bge	a5,a4,14d4 <schedule_rm+0x29a>
                                    cur_min = cur;
    14cc:	fa043783          	ld	a5,-96(s0)
    14d0:	f8f43c23          	sd	a5,-104(s0)
                list_for_each_entry(cur, args.release_queue, thread_list) {
    14d4:	fa043783          	ld	a5,-96(s0)
    14d8:	679c                	ld	a5,8(a5)
    14da:	f6f43823          	sd	a5,-144(s0)
    14de:	f7043783          	ld	a5,-144(s0)
    14e2:	17e1                	addi	a5,a5,-8
    14e4:	faf43023          	sd	a5,-96(s0)
    14e8:	fa043783          	ld	a5,-96(s0)
    14ec:	00878713          	addi	a4,a5,8
    14f0:	689c                	ld	a5,16(s1)
    14f2:	f6f719e3          	bne	a4,a5,1464 <schedule_rm+0x22a>
                                }
                            }
                        }
                    }
                }
                if(cur_min != NULL){
    14f6:	f9843783          	ld	a5,-104(s0)
    14fa:	cb89                	beqz	a5,150c <schedule_rm+0x2d2>
                    // a preemption is possible
                    remaining_time = cur_min->release_time - args.current_time;
    14fc:	f9843783          	ld	a5,-104(s0)
    1500:	4f98                	lw	a4,24(a5)
    1502:	409c                	lw	a5,0(s1)
    1504:	40f707bb          	subw	a5,a4,a5
    1508:	f8f42a23          	sw	a5,-108(s0)
                }
                int deadline_time = min_th->current_deadline - args.current_time;
    150c:	fb043783          	ld	a5,-80(s0)
    1510:	4bb8                	lw	a4,80(a5)
    1512:	409c                	lw	a5,0(s1)
    1514:	40f707bb          	subw	a5,a4,a5
    1518:	f6f42e23          	sw	a5,-132(s0)
                remaining_time = deadline_time<remaining_time? deadline_time: remaining_time;
    151c:	f7c42603          	lw	a2,-132(s0)
    1520:	f9442783          	lw	a5,-108(s0)
    1524:	0007869b          	sext.w	a3,a5
    1528:	0006071b          	sext.w	a4,a2
    152c:	00d75363          	bge	a4,a3,1532 <schedule_rm+0x2f8>
    1530:	87b2                	mv	a5,a2
    1532:	f8f42a23          	sw	a5,-108(s0)
                int met_time = min_th->remaining_time;
    1536:	fb043783          	ld	a5,-80(s0)
    153a:	47fc                	lw	a5,76(a5)
    153c:	f6f42c23          	sw	a5,-136(s0)
                remaining_time = met_time<remaining_time? met_time: remaining_time;
    1540:	f7842603          	lw	a2,-136(s0)
    1544:	f9442783          	lw	a5,-108(s0)
    1548:	0007869b          	sext.w	a3,a5
    154c:	0006071b          	sext.w	a4,a2
    1550:	00d75363          	bge	a4,a3,1556 <schedule_rm+0x31c>
    1554:	87b2                	mv	a5,a2
    1556:	f8f42a23          	sw	a5,-108(s0)
                
                r.allocated_time = remaining_time;
    155a:	f9442783          	lw	a5,-108(s0)
    155e:	f2f42823          	sw	a5,-208(s0)
            }

            return r;
    1562:	f2843783          	ld	a5,-216(s0)
    1566:	f2f43c23          	sd	a5,-200(s0)
    156a:	f3043783          	ld	a5,-208(s0)
    156e:	f4f43023          	sd	a5,-192(s0)
        }
    }
}
    1572:	f3843703          	ld	a4,-200(s0)
    1576:	f4043783          	ld	a5,-192(s0)
    157a:	893a                	mv	s2,a4
    157c:	89be                	mv	s3,a5
    157e:	874a                	mv	a4,s2
    1580:	87ce                	mv	a5,s3
    1582:	853a                	mv	a0,a4
    1584:	85be                	mv	a1,a5
    1586:	60ee                	ld	ra,216(sp)
    1588:	644e                	ld	s0,208(sp)
    158a:	64ae                	ld	s1,200(sp)
    158c:	690e                	ld	s2,192(sp)
    158e:	79ea                	ld	s3,184(sp)
    1590:	612d                	addi	sp,sp,224
    1592:	8082                	ret
