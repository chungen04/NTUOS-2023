
user/_cat:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <cat>:

char buf[512];

void
cat(int fd)
{
       0:	7179                	addi	sp,sp,-48
       2:	f406                	sd	ra,40(sp)
       4:	f022                	sd	s0,32(sp)
       6:	1800                	addi	s0,sp,48
       8:	87aa                	mv	a5,a0
       a:	fcf42e23          	sw	a5,-36(s0)
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0) {
       e:	a091                	j	52 <cat+0x52>
    if (write(1, buf, n) != n) {
      10:	fec42783          	lw	a5,-20(s0)
      14:	863e                	mv	a2,a5
      16:	00001597          	auipc	a1,0x1
      1a:	73a58593          	addi	a1,a1,1850 # 1750 <buf>
      1e:	4505                	li	a0,1
      20:	00000097          	auipc	ra,0x0
      24:	60e080e7          	jalr	1550(ra) # 62e <write>
      28:	87aa                	mv	a5,a0
      2a:	873e                	mv	a4,a5
      2c:	fec42783          	lw	a5,-20(s0)
      30:	2781                	sext.w	a5,a5
      32:	02e78063          	beq	a5,a4,52 <cat+0x52>
      fprintf(2, "cat: write error\n");
      36:	00001597          	auipc	a1,0x1
      3a:	6b258593          	addi	a1,a1,1714 # 16e8 <schedule_rm+0x35a>
      3e:	4509                	li	a0,2
      40:	00001097          	auipc	ra,0x1
      44:	abc080e7          	jalr	-1348(ra) # afc <fprintf>
      exit(1);
      48:	4505                	li	a0,1
      4a:	00000097          	auipc	ra,0x0
      4e:	5c4080e7          	jalr	1476(ra) # 60e <exit>
  while((n = read(fd, buf, sizeof(buf))) > 0) {
      52:	fdc42783          	lw	a5,-36(s0)
      56:	20000613          	li	a2,512
      5a:	00001597          	auipc	a1,0x1
      5e:	6f658593          	addi	a1,a1,1782 # 1750 <buf>
      62:	853e                	mv	a0,a5
      64:	00000097          	auipc	ra,0x0
      68:	5c2080e7          	jalr	1474(ra) # 626 <read>
      6c:	87aa                	mv	a5,a0
      6e:	fef42623          	sw	a5,-20(s0)
      72:	fec42783          	lw	a5,-20(s0)
      76:	2781                	sext.w	a5,a5
      78:	f8f04ce3          	bgtz	a5,10 <cat+0x10>
    }
  }
  if(n < 0){
      7c:	fec42783          	lw	a5,-20(s0)
      80:	2781                	sext.w	a5,a5
      82:	0207d063          	bgez	a5,a2 <cat+0xa2>
    fprintf(2, "cat: read error\n");
      86:	00001597          	auipc	a1,0x1
      8a:	67a58593          	addi	a1,a1,1658 # 1700 <schedule_rm+0x372>
      8e:	4509                	li	a0,2
      90:	00001097          	auipc	ra,0x1
      94:	a6c080e7          	jalr	-1428(ra) # afc <fprintf>
    exit(1);
      98:	4505                	li	a0,1
      9a:	00000097          	auipc	ra,0x0
      9e:	574080e7          	jalr	1396(ra) # 60e <exit>
  }
}
      a2:	0001                	nop
      a4:	70a2                	ld	ra,40(sp)
      a6:	7402                	ld	s0,32(sp)
      a8:	6145                	addi	sp,sp,48
      aa:	8082                	ret

00000000000000ac <main>:

int
main(int argc, char *argv[])
{
      ac:	7179                	addi	sp,sp,-48
      ae:	f406                	sd	ra,40(sp)
      b0:	f022                	sd	s0,32(sp)
      b2:	1800                	addi	s0,sp,48
      b4:	87aa                	mv	a5,a0
      b6:	fcb43823          	sd	a1,-48(s0)
      ba:	fcf42e23          	sw	a5,-36(s0)
  int fd, i;

  if(argc <= 1){
      be:	fdc42783          	lw	a5,-36(s0)
      c2:	0007871b          	sext.w	a4,a5
      c6:	4785                	li	a5,1
      c8:	00e7cc63          	blt	a5,a4,e0 <main+0x34>
    cat(0);
      cc:	4501                	li	a0,0
      ce:	00000097          	auipc	ra,0x0
      d2:	f32080e7          	jalr	-206(ra) # 0 <cat>
    exit(0);
      d6:	4501                	li	a0,0
      d8:	00000097          	auipc	ra,0x0
      dc:	536080e7          	jalr	1334(ra) # 60e <exit>
  }

  for(i = 1; i < argc; i++){
      e0:	4785                	li	a5,1
      e2:	fef42623          	sw	a5,-20(s0)
      e6:	a8bd                	j	164 <main+0xb8>
    if((fd = open(argv[i], 0)) < 0){
      e8:	fec42783          	lw	a5,-20(s0)
      ec:	078e                	slli	a5,a5,0x3
      ee:	fd043703          	ld	a4,-48(s0)
      f2:	97ba                	add	a5,a5,a4
      f4:	639c                	ld	a5,0(a5)
      f6:	4581                	li	a1,0
      f8:	853e                	mv	a0,a5
      fa:	00000097          	auipc	ra,0x0
      fe:	554080e7          	jalr	1364(ra) # 64e <open>
     102:	87aa                	mv	a5,a0
     104:	fef42423          	sw	a5,-24(s0)
     108:	fe842783          	lw	a5,-24(s0)
     10c:	2781                	sext.w	a5,a5
     10e:	0207d863          	bgez	a5,13e <main+0x92>
      fprintf(2, "cat: cannot open %s\n", argv[i]);
     112:	fec42783          	lw	a5,-20(s0)
     116:	078e                	slli	a5,a5,0x3
     118:	fd043703          	ld	a4,-48(s0)
     11c:	97ba                	add	a5,a5,a4
     11e:	639c                	ld	a5,0(a5)
     120:	863e                	mv	a2,a5
     122:	00001597          	auipc	a1,0x1
     126:	5f658593          	addi	a1,a1,1526 # 1718 <schedule_rm+0x38a>
     12a:	4509                	li	a0,2
     12c:	00001097          	auipc	ra,0x1
     130:	9d0080e7          	jalr	-1584(ra) # afc <fprintf>
      exit(1);
     134:	4505                	li	a0,1
     136:	00000097          	auipc	ra,0x0
     13a:	4d8080e7          	jalr	1240(ra) # 60e <exit>
    }
    cat(fd);
     13e:	fe842783          	lw	a5,-24(s0)
     142:	853e                	mv	a0,a5
     144:	00000097          	auipc	ra,0x0
     148:	ebc080e7          	jalr	-324(ra) # 0 <cat>
    close(fd);
     14c:	fe842783          	lw	a5,-24(s0)
     150:	853e                	mv	a0,a5
     152:	00000097          	auipc	ra,0x0
     156:	4e4080e7          	jalr	1252(ra) # 636 <close>
  for(i = 1; i < argc; i++){
     15a:	fec42783          	lw	a5,-20(s0)
     15e:	2785                	addiw	a5,a5,1
     160:	fef42623          	sw	a5,-20(s0)
     164:	fec42703          	lw	a4,-20(s0)
     168:	fdc42783          	lw	a5,-36(s0)
     16c:	2701                	sext.w	a4,a4
     16e:	2781                	sext.w	a5,a5
     170:	f6f74ce3          	blt	a4,a5,e8 <main+0x3c>
  }
  exit(0);
     174:	4501                	li	a0,0
     176:	00000097          	auipc	ra,0x0
     17a:	498080e7          	jalr	1176(ra) # 60e <exit>

000000000000017e <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
     17e:	7179                	addi	sp,sp,-48
     180:	f422                	sd	s0,40(sp)
     182:	1800                	addi	s0,sp,48
     184:	fca43c23          	sd	a0,-40(s0)
     188:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
     18c:	fd843783          	ld	a5,-40(s0)
     190:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
     194:	0001                	nop
     196:	fd043703          	ld	a4,-48(s0)
     19a:	00170793          	addi	a5,a4,1
     19e:	fcf43823          	sd	a5,-48(s0)
     1a2:	fd843783          	ld	a5,-40(s0)
     1a6:	00178693          	addi	a3,a5,1
     1aa:	fcd43c23          	sd	a3,-40(s0)
     1ae:	00074703          	lbu	a4,0(a4)
     1b2:	00e78023          	sb	a4,0(a5)
     1b6:	0007c783          	lbu	a5,0(a5)
     1ba:	fff1                	bnez	a5,196 <strcpy+0x18>
    ;
  return os;
     1bc:	fe843783          	ld	a5,-24(s0)
}
     1c0:	853e                	mv	a0,a5
     1c2:	7422                	ld	s0,40(sp)
     1c4:	6145                	addi	sp,sp,48
     1c6:	8082                	ret

00000000000001c8 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     1c8:	1101                	addi	sp,sp,-32
     1ca:	ec22                	sd	s0,24(sp)
     1cc:	1000                	addi	s0,sp,32
     1ce:	fea43423          	sd	a0,-24(s0)
     1d2:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
     1d6:	a819                	j	1ec <strcmp+0x24>
    p++, q++;
     1d8:	fe843783          	ld	a5,-24(s0)
     1dc:	0785                	addi	a5,a5,1
     1de:	fef43423          	sd	a5,-24(s0)
     1e2:	fe043783          	ld	a5,-32(s0)
     1e6:	0785                	addi	a5,a5,1
     1e8:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
     1ec:	fe843783          	ld	a5,-24(s0)
     1f0:	0007c783          	lbu	a5,0(a5)
     1f4:	cb99                	beqz	a5,20a <strcmp+0x42>
     1f6:	fe843783          	ld	a5,-24(s0)
     1fa:	0007c703          	lbu	a4,0(a5)
     1fe:	fe043783          	ld	a5,-32(s0)
     202:	0007c783          	lbu	a5,0(a5)
     206:	fcf709e3          	beq	a4,a5,1d8 <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
     20a:	fe843783          	ld	a5,-24(s0)
     20e:	0007c783          	lbu	a5,0(a5)
     212:	0007871b          	sext.w	a4,a5
     216:	fe043783          	ld	a5,-32(s0)
     21a:	0007c783          	lbu	a5,0(a5)
     21e:	2781                	sext.w	a5,a5
     220:	40f707bb          	subw	a5,a4,a5
     224:	2781                	sext.w	a5,a5
}
     226:	853e                	mv	a0,a5
     228:	6462                	ld	s0,24(sp)
     22a:	6105                	addi	sp,sp,32
     22c:	8082                	ret

000000000000022e <strlen>:

uint
strlen(const char *s)
{
     22e:	7179                	addi	sp,sp,-48
     230:	f422                	sd	s0,40(sp)
     232:	1800                	addi	s0,sp,48
     234:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
     238:	fe042623          	sw	zero,-20(s0)
     23c:	a031                	j	248 <strlen+0x1a>
     23e:	fec42783          	lw	a5,-20(s0)
     242:	2785                	addiw	a5,a5,1
     244:	fef42623          	sw	a5,-20(s0)
     248:	fec42783          	lw	a5,-20(s0)
     24c:	fd843703          	ld	a4,-40(s0)
     250:	97ba                	add	a5,a5,a4
     252:	0007c783          	lbu	a5,0(a5)
     256:	f7e5                	bnez	a5,23e <strlen+0x10>
    ;
  return n;
     258:	fec42783          	lw	a5,-20(s0)
}
     25c:	853e                	mv	a0,a5
     25e:	7422                	ld	s0,40(sp)
     260:	6145                	addi	sp,sp,48
     262:	8082                	ret

0000000000000264 <memset>:

void*
memset(void *dst, int c, uint n)
{
     264:	7179                	addi	sp,sp,-48
     266:	f422                	sd	s0,40(sp)
     268:	1800                	addi	s0,sp,48
     26a:	fca43c23          	sd	a0,-40(s0)
     26e:	87ae                	mv	a5,a1
     270:	8732                	mv	a4,a2
     272:	fcf42a23          	sw	a5,-44(s0)
     276:	87ba                	mv	a5,a4
     278:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
     27c:	fd843783          	ld	a5,-40(s0)
     280:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
     284:	fe042623          	sw	zero,-20(s0)
     288:	a00d                	j	2aa <memset+0x46>
    cdst[i] = c;
     28a:	fec42783          	lw	a5,-20(s0)
     28e:	fe043703          	ld	a4,-32(s0)
     292:	97ba                	add	a5,a5,a4
     294:	fd442703          	lw	a4,-44(s0)
     298:	0ff77713          	andi	a4,a4,255
     29c:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
     2a0:	fec42783          	lw	a5,-20(s0)
     2a4:	2785                	addiw	a5,a5,1
     2a6:	fef42623          	sw	a5,-20(s0)
     2aa:	fec42703          	lw	a4,-20(s0)
     2ae:	fd042783          	lw	a5,-48(s0)
     2b2:	2781                	sext.w	a5,a5
     2b4:	fcf76be3          	bltu	a4,a5,28a <memset+0x26>
  }
  return dst;
     2b8:	fd843783          	ld	a5,-40(s0)
}
     2bc:	853e                	mv	a0,a5
     2be:	7422                	ld	s0,40(sp)
     2c0:	6145                	addi	sp,sp,48
     2c2:	8082                	ret

00000000000002c4 <strchr>:

char*
strchr(const char *s, char c)
{
     2c4:	1101                	addi	sp,sp,-32
     2c6:	ec22                	sd	s0,24(sp)
     2c8:	1000                	addi	s0,sp,32
     2ca:	fea43423          	sd	a0,-24(s0)
     2ce:	87ae                	mv	a5,a1
     2d0:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
     2d4:	a01d                	j	2fa <strchr+0x36>
    if(*s == c)
     2d6:	fe843783          	ld	a5,-24(s0)
     2da:	0007c703          	lbu	a4,0(a5)
     2de:	fe744783          	lbu	a5,-25(s0)
     2e2:	0ff7f793          	andi	a5,a5,255
     2e6:	00e79563          	bne	a5,a4,2f0 <strchr+0x2c>
      return (char*)s;
     2ea:	fe843783          	ld	a5,-24(s0)
     2ee:	a821                	j	306 <strchr+0x42>
  for(; *s; s++)
     2f0:	fe843783          	ld	a5,-24(s0)
     2f4:	0785                	addi	a5,a5,1
     2f6:	fef43423          	sd	a5,-24(s0)
     2fa:	fe843783          	ld	a5,-24(s0)
     2fe:	0007c783          	lbu	a5,0(a5)
     302:	fbf1                	bnez	a5,2d6 <strchr+0x12>
  return 0;
     304:	4781                	li	a5,0
}
     306:	853e                	mv	a0,a5
     308:	6462                	ld	s0,24(sp)
     30a:	6105                	addi	sp,sp,32
     30c:	8082                	ret

000000000000030e <gets>:

char*
gets(char *buf, int max)
{
     30e:	7179                	addi	sp,sp,-48
     310:	f406                	sd	ra,40(sp)
     312:	f022                	sd	s0,32(sp)
     314:	1800                	addi	s0,sp,48
     316:	fca43c23          	sd	a0,-40(s0)
     31a:	87ae                	mv	a5,a1
     31c:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     320:	fe042623          	sw	zero,-20(s0)
     324:	a8a1                	j	37c <gets+0x6e>
    cc = read(0, &c, 1);
     326:	fe740793          	addi	a5,s0,-25
     32a:	4605                	li	a2,1
     32c:	85be                	mv	a1,a5
     32e:	4501                	li	a0,0
     330:	00000097          	auipc	ra,0x0
     334:	2f6080e7          	jalr	758(ra) # 626 <read>
     338:	87aa                	mv	a5,a0
     33a:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
     33e:	fe842783          	lw	a5,-24(s0)
     342:	2781                	sext.w	a5,a5
     344:	04f05763          	blez	a5,392 <gets+0x84>
      break;
    buf[i++] = c;
     348:	fec42783          	lw	a5,-20(s0)
     34c:	0017871b          	addiw	a4,a5,1
     350:	fee42623          	sw	a4,-20(s0)
     354:	873e                	mv	a4,a5
     356:	fd843783          	ld	a5,-40(s0)
     35a:	97ba                	add	a5,a5,a4
     35c:	fe744703          	lbu	a4,-25(s0)
     360:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
     364:	fe744783          	lbu	a5,-25(s0)
     368:	873e                	mv	a4,a5
     36a:	47a9                	li	a5,10
     36c:	02f70463          	beq	a4,a5,394 <gets+0x86>
     370:	fe744783          	lbu	a5,-25(s0)
     374:	873e                	mv	a4,a5
     376:	47b5                	li	a5,13
     378:	00f70e63          	beq	a4,a5,394 <gets+0x86>
  for(i=0; i+1 < max; ){
     37c:	fec42783          	lw	a5,-20(s0)
     380:	2785                	addiw	a5,a5,1
     382:	0007871b          	sext.w	a4,a5
     386:	fd442783          	lw	a5,-44(s0)
     38a:	2781                	sext.w	a5,a5
     38c:	f8f74de3          	blt	a4,a5,326 <gets+0x18>
     390:	a011                	j	394 <gets+0x86>
      break;
     392:	0001                	nop
      break;
  }
  buf[i] = '\0';
     394:	fec42783          	lw	a5,-20(s0)
     398:	fd843703          	ld	a4,-40(s0)
     39c:	97ba                	add	a5,a5,a4
     39e:	00078023          	sb	zero,0(a5)
  return buf;
     3a2:	fd843783          	ld	a5,-40(s0)
}
     3a6:	853e                	mv	a0,a5
     3a8:	70a2                	ld	ra,40(sp)
     3aa:	7402                	ld	s0,32(sp)
     3ac:	6145                	addi	sp,sp,48
     3ae:	8082                	ret

00000000000003b0 <stat>:

int
stat(const char *n, struct stat *st)
{
     3b0:	7179                	addi	sp,sp,-48
     3b2:	f406                	sd	ra,40(sp)
     3b4:	f022                	sd	s0,32(sp)
     3b6:	1800                	addi	s0,sp,48
     3b8:	fca43c23          	sd	a0,-40(s0)
     3bc:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     3c0:	4581                	li	a1,0
     3c2:	fd843503          	ld	a0,-40(s0)
     3c6:	00000097          	auipc	ra,0x0
     3ca:	288080e7          	jalr	648(ra) # 64e <open>
     3ce:	87aa                	mv	a5,a0
     3d0:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
     3d4:	fec42783          	lw	a5,-20(s0)
     3d8:	2781                	sext.w	a5,a5
     3da:	0007d463          	bgez	a5,3e2 <stat+0x32>
    return -1;
     3de:	57fd                	li	a5,-1
     3e0:	a035                	j	40c <stat+0x5c>
  r = fstat(fd, st);
     3e2:	fec42783          	lw	a5,-20(s0)
     3e6:	fd043583          	ld	a1,-48(s0)
     3ea:	853e                	mv	a0,a5
     3ec:	00000097          	auipc	ra,0x0
     3f0:	27a080e7          	jalr	634(ra) # 666 <fstat>
     3f4:	87aa                	mv	a5,a0
     3f6:	fef42423          	sw	a5,-24(s0)
  close(fd);
     3fa:	fec42783          	lw	a5,-20(s0)
     3fe:	853e                	mv	a0,a5
     400:	00000097          	auipc	ra,0x0
     404:	236080e7          	jalr	566(ra) # 636 <close>
  return r;
     408:	fe842783          	lw	a5,-24(s0)
}
     40c:	853e                	mv	a0,a5
     40e:	70a2                	ld	ra,40(sp)
     410:	7402                	ld	s0,32(sp)
     412:	6145                	addi	sp,sp,48
     414:	8082                	ret

0000000000000416 <atoi>:

int
atoi(const char *s)
{
     416:	7179                	addi	sp,sp,-48
     418:	f422                	sd	s0,40(sp)
     41a:	1800                	addi	s0,sp,48
     41c:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
     420:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
     424:	a815                	j	458 <atoi+0x42>
    n = n*10 + *s++ - '0';
     426:	fec42703          	lw	a4,-20(s0)
     42a:	87ba                	mv	a5,a4
     42c:	0027979b          	slliw	a5,a5,0x2
     430:	9fb9                	addw	a5,a5,a4
     432:	0017979b          	slliw	a5,a5,0x1
     436:	0007871b          	sext.w	a4,a5
     43a:	fd843783          	ld	a5,-40(s0)
     43e:	00178693          	addi	a3,a5,1
     442:	fcd43c23          	sd	a3,-40(s0)
     446:	0007c783          	lbu	a5,0(a5)
     44a:	2781                	sext.w	a5,a5
     44c:	9fb9                	addw	a5,a5,a4
     44e:	2781                	sext.w	a5,a5
     450:	fd07879b          	addiw	a5,a5,-48
     454:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
     458:	fd843783          	ld	a5,-40(s0)
     45c:	0007c783          	lbu	a5,0(a5)
     460:	873e                	mv	a4,a5
     462:	02f00793          	li	a5,47
     466:	00e7fb63          	bgeu	a5,a4,47c <atoi+0x66>
     46a:	fd843783          	ld	a5,-40(s0)
     46e:	0007c783          	lbu	a5,0(a5)
     472:	873e                	mv	a4,a5
     474:	03900793          	li	a5,57
     478:	fae7f7e3          	bgeu	a5,a4,426 <atoi+0x10>
  return n;
     47c:	fec42783          	lw	a5,-20(s0)
}
     480:	853e                	mv	a0,a5
     482:	7422                	ld	s0,40(sp)
     484:	6145                	addi	sp,sp,48
     486:	8082                	ret

0000000000000488 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     488:	7139                	addi	sp,sp,-64
     48a:	fc22                	sd	s0,56(sp)
     48c:	0080                	addi	s0,sp,64
     48e:	fca43c23          	sd	a0,-40(s0)
     492:	fcb43823          	sd	a1,-48(s0)
     496:	87b2                	mv	a5,a2
     498:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
     49c:	fd843783          	ld	a5,-40(s0)
     4a0:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
     4a4:	fd043783          	ld	a5,-48(s0)
     4a8:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
     4ac:	fe043703          	ld	a4,-32(s0)
     4b0:	fe843783          	ld	a5,-24(s0)
     4b4:	02e7fc63          	bgeu	a5,a4,4ec <memmove+0x64>
    while(n-- > 0)
     4b8:	a00d                	j	4da <memmove+0x52>
      *dst++ = *src++;
     4ba:	fe043703          	ld	a4,-32(s0)
     4be:	00170793          	addi	a5,a4,1
     4c2:	fef43023          	sd	a5,-32(s0)
     4c6:	fe843783          	ld	a5,-24(s0)
     4ca:	00178693          	addi	a3,a5,1
     4ce:	fed43423          	sd	a3,-24(s0)
     4d2:	00074703          	lbu	a4,0(a4)
     4d6:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     4da:	fcc42783          	lw	a5,-52(s0)
     4de:	fff7871b          	addiw	a4,a5,-1
     4e2:	fce42623          	sw	a4,-52(s0)
     4e6:	fcf04ae3          	bgtz	a5,4ba <memmove+0x32>
     4ea:	a891                	j	53e <memmove+0xb6>
  } else {
    dst += n;
     4ec:	fcc42783          	lw	a5,-52(s0)
     4f0:	fe843703          	ld	a4,-24(s0)
     4f4:	97ba                	add	a5,a5,a4
     4f6:	fef43423          	sd	a5,-24(s0)
    src += n;
     4fa:	fcc42783          	lw	a5,-52(s0)
     4fe:	fe043703          	ld	a4,-32(s0)
     502:	97ba                	add	a5,a5,a4
     504:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
     508:	a01d                	j	52e <memmove+0xa6>
      *--dst = *--src;
     50a:	fe043783          	ld	a5,-32(s0)
     50e:	17fd                	addi	a5,a5,-1
     510:	fef43023          	sd	a5,-32(s0)
     514:	fe843783          	ld	a5,-24(s0)
     518:	17fd                	addi	a5,a5,-1
     51a:	fef43423          	sd	a5,-24(s0)
     51e:	fe043783          	ld	a5,-32(s0)
     522:	0007c703          	lbu	a4,0(a5)
     526:	fe843783          	ld	a5,-24(s0)
     52a:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     52e:	fcc42783          	lw	a5,-52(s0)
     532:	fff7871b          	addiw	a4,a5,-1
     536:	fce42623          	sw	a4,-52(s0)
     53a:	fcf048e3          	bgtz	a5,50a <memmove+0x82>
  }
  return vdst;
     53e:	fd843783          	ld	a5,-40(s0)
}
     542:	853e                	mv	a0,a5
     544:	7462                	ld	s0,56(sp)
     546:	6121                	addi	sp,sp,64
     548:	8082                	ret

000000000000054a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     54a:	7139                	addi	sp,sp,-64
     54c:	fc22                	sd	s0,56(sp)
     54e:	0080                	addi	s0,sp,64
     550:	fca43c23          	sd	a0,-40(s0)
     554:	fcb43823          	sd	a1,-48(s0)
     558:	87b2                	mv	a5,a2
     55a:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
     55e:	fd843783          	ld	a5,-40(s0)
     562:	fef43423          	sd	a5,-24(s0)
     566:	fd043783          	ld	a5,-48(s0)
     56a:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     56e:	a0a1                	j	5b6 <memcmp+0x6c>
    if (*p1 != *p2) {
     570:	fe843783          	ld	a5,-24(s0)
     574:	0007c703          	lbu	a4,0(a5)
     578:	fe043783          	ld	a5,-32(s0)
     57c:	0007c783          	lbu	a5,0(a5)
     580:	02f70163          	beq	a4,a5,5a2 <memcmp+0x58>
      return *p1 - *p2;
     584:	fe843783          	ld	a5,-24(s0)
     588:	0007c783          	lbu	a5,0(a5)
     58c:	0007871b          	sext.w	a4,a5
     590:	fe043783          	ld	a5,-32(s0)
     594:	0007c783          	lbu	a5,0(a5)
     598:	2781                	sext.w	a5,a5
     59a:	40f707bb          	subw	a5,a4,a5
     59e:	2781                	sext.w	a5,a5
     5a0:	a01d                	j	5c6 <memcmp+0x7c>
    }
    p1++;
     5a2:	fe843783          	ld	a5,-24(s0)
     5a6:	0785                	addi	a5,a5,1
     5a8:	fef43423          	sd	a5,-24(s0)
    p2++;
     5ac:	fe043783          	ld	a5,-32(s0)
     5b0:	0785                	addi	a5,a5,1
     5b2:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     5b6:	fcc42783          	lw	a5,-52(s0)
     5ba:	fff7871b          	addiw	a4,a5,-1
     5be:	fce42623          	sw	a4,-52(s0)
     5c2:	f7dd                	bnez	a5,570 <memcmp+0x26>
  }
  return 0;
     5c4:	4781                	li	a5,0
}
     5c6:	853e                	mv	a0,a5
     5c8:	7462                	ld	s0,56(sp)
     5ca:	6121                	addi	sp,sp,64
     5cc:	8082                	ret

00000000000005ce <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     5ce:	7179                	addi	sp,sp,-48
     5d0:	f406                	sd	ra,40(sp)
     5d2:	f022                	sd	s0,32(sp)
     5d4:	1800                	addi	s0,sp,48
     5d6:	fea43423          	sd	a0,-24(s0)
     5da:	feb43023          	sd	a1,-32(s0)
     5de:	87b2                	mv	a5,a2
     5e0:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
     5e4:	fdc42783          	lw	a5,-36(s0)
     5e8:	863e                	mv	a2,a5
     5ea:	fe043583          	ld	a1,-32(s0)
     5ee:	fe843503          	ld	a0,-24(s0)
     5f2:	00000097          	auipc	ra,0x0
     5f6:	e96080e7          	jalr	-362(ra) # 488 <memmove>
     5fa:	87aa                	mv	a5,a0
}
     5fc:	853e                	mv	a0,a5
     5fe:	70a2                	ld	ra,40(sp)
     600:	7402                	ld	s0,32(sp)
     602:	6145                	addi	sp,sp,48
     604:	8082                	ret

0000000000000606 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     606:	4885                	li	a7,1
 ecall
     608:	00000073          	ecall
 ret
     60c:	8082                	ret

000000000000060e <exit>:
.global exit
exit:
 li a7, SYS_exit
     60e:	4889                	li	a7,2
 ecall
     610:	00000073          	ecall
 ret
     614:	8082                	ret

0000000000000616 <wait>:
.global wait
wait:
 li a7, SYS_wait
     616:	488d                	li	a7,3
 ecall
     618:	00000073          	ecall
 ret
     61c:	8082                	ret

000000000000061e <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     61e:	4891                	li	a7,4
 ecall
     620:	00000073          	ecall
 ret
     624:	8082                	ret

0000000000000626 <read>:
.global read
read:
 li a7, SYS_read
     626:	4895                	li	a7,5
 ecall
     628:	00000073          	ecall
 ret
     62c:	8082                	ret

000000000000062e <write>:
.global write
write:
 li a7, SYS_write
     62e:	48c1                	li	a7,16
 ecall
     630:	00000073          	ecall
 ret
     634:	8082                	ret

0000000000000636 <close>:
.global close
close:
 li a7, SYS_close
     636:	48d5                	li	a7,21
 ecall
     638:	00000073          	ecall
 ret
     63c:	8082                	ret

000000000000063e <kill>:
.global kill
kill:
 li a7, SYS_kill
     63e:	4899                	li	a7,6
 ecall
     640:	00000073          	ecall
 ret
     644:	8082                	ret

0000000000000646 <exec>:
.global exec
exec:
 li a7, SYS_exec
     646:	489d                	li	a7,7
 ecall
     648:	00000073          	ecall
 ret
     64c:	8082                	ret

000000000000064e <open>:
.global open
open:
 li a7, SYS_open
     64e:	48bd                	li	a7,15
 ecall
     650:	00000073          	ecall
 ret
     654:	8082                	ret

0000000000000656 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     656:	48c5                	li	a7,17
 ecall
     658:	00000073          	ecall
 ret
     65c:	8082                	ret

000000000000065e <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     65e:	48c9                	li	a7,18
 ecall
     660:	00000073          	ecall
 ret
     664:	8082                	ret

0000000000000666 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     666:	48a1                	li	a7,8
 ecall
     668:	00000073          	ecall
 ret
     66c:	8082                	ret

000000000000066e <link>:
.global link
link:
 li a7, SYS_link
     66e:	48cd                	li	a7,19
 ecall
     670:	00000073          	ecall
 ret
     674:	8082                	ret

0000000000000676 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     676:	48d1                	li	a7,20
 ecall
     678:	00000073          	ecall
 ret
     67c:	8082                	ret

000000000000067e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     67e:	48a5                	li	a7,9
 ecall
     680:	00000073          	ecall
 ret
     684:	8082                	ret

0000000000000686 <dup>:
.global dup
dup:
 li a7, SYS_dup
     686:	48a9                	li	a7,10
 ecall
     688:	00000073          	ecall
 ret
     68c:	8082                	ret

000000000000068e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     68e:	48ad                	li	a7,11
 ecall
     690:	00000073          	ecall
 ret
     694:	8082                	ret

0000000000000696 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     696:	48b1                	li	a7,12
 ecall
     698:	00000073          	ecall
 ret
     69c:	8082                	ret

000000000000069e <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     69e:	48b5                	li	a7,13
 ecall
     6a0:	00000073          	ecall
 ret
     6a4:	8082                	ret

00000000000006a6 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     6a6:	48b9                	li	a7,14
 ecall
     6a8:	00000073          	ecall
 ret
     6ac:	8082                	ret

00000000000006ae <thrdstop>:
.global thrdstop
thrdstop:
 li a7, SYS_thrdstop
     6ae:	48d9                	li	a7,22
 ecall
     6b0:	00000073          	ecall
 ret
     6b4:	8082                	ret

00000000000006b6 <thrdresume>:
.global thrdresume
thrdresume:
 li a7, SYS_thrdresume
     6b6:	48dd                	li	a7,23
 ecall
     6b8:	00000073          	ecall
 ret
     6bc:	8082                	ret

00000000000006be <cancelthrdstop>:
.global cancelthrdstop
cancelthrdstop:
 li a7, SYS_cancelthrdstop
     6be:	48e1                	li	a7,24
 ecall
     6c0:	00000073          	ecall
 ret
     6c4:	8082                	ret

00000000000006c6 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     6c6:	1101                	addi	sp,sp,-32
     6c8:	ec06                	sd	ra,24(sp)
     6ca:	e822                	sd	s0,16(sp)
     6cc:	1000                	addi	s0,sp,32
     6ce:	87aa                	mv	a5,a0
     6d0:	872e                	mv	a4,a1
     6d2:	fef42623          	sw	a5,-20(s0)
     6d6:	87ba                	mv	a5,a4
     6d8:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
     6dc:	feb40713          	addi	a4,s0,-21
     6e0:	fec42783          	lw	a5,-20(s0)
     6e4:	4605                	li	a2,1
     6e6:	85ba                	mv	a1,a4
     6e8:	853e                	mv	a0,a5
     6ea:	00000097          	auipc	ra,0x0
     6ee:	f44080e7          	jalr	-188(ra) # 62e <write>
}
     6f2:	0001                	nop
     6f4:	60e2                	ld	ra,24(sp)
     6f6:	6442                	ld	s0,16(sp)
     6f8:	6105                	addi	sp,sp,32
     6fa:	8082                	ret

00000000000006fc <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     6fc:	7139                	addi	sp,sp,-64
     6fe:	fc06                	sd	ra,56(sp)
     700:	f822                	sd	s0,48(sp)
     702:	0080                	addi	s0,sp,64
     704:	87aa                	mv	a5,a0
     706:	8736                	mv	a4,a3
     708:	fcf42623          	sw	a5,-52(s0)
     70c:	87ae                	mv	a5,a1
     70e:	fcf42423          	sw	a5,-56(s0)
     712:	87b2                	mv	a5,a2
     714:	fcf42223          	sw	a5,-60(s0)
     718:	87ba                	mv	a5,a4
     71a:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     71e:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
     722:	fc042783          	lw	a5,-64(s0)
     726:	2781                	sext.w	a5,a5
     728:	c38d                	beqz	a5,74a <printint+0x4e>
     72a:	fc842783          	lw	a5,-56(s0)
     72e:	2781                	sext.w	a5,a5
     730:	0007dd63          	bgez	a5,74a <printint+0x4e>
    neg = 1;
     734:	4785                	li	a5,1
     736:	fef42423          	sw	a5,-24(s0)
    x = -xx;
     73a:	fc842783          	lw	a5,-56(s0)
     73e:	40f007bb          	negw	a5,a5
     742:	2781                	sext.w	a5,a5
     744:	fef42223          	sw	a5,-28(s0)
     748:	a029                	j	752 <printint+0x56>
  } else {
    x = xx;
     74a:	fc842783          	lw	a5,-56(s0)
     74e:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
     752:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
     756:	fc442783          	lw	a5,-60(s0)
     75a:	fe442703          	lw	a4,-28(s0)
     75e:	02f777bb          	remuw	a5,a4,a5
     762:	0007861b          	sext.w	a2,a5
     766:	fec42783          	lw	a5,-20(s0)
     76a:	0017871b          	addiw	a4,a5,1
     76e:	fee42623          	sw	a4,-20(s0)
     772:	00001697          	auipc	a3,0x1
     776:	fc668693          	addi	a3,a3,-58 # 1738 <digits>
     77a:	02061713          	slli	a4,a2,0x20
     77e:	9301                	srli	a4,a4,0x20
     780:	9736                	add	a4,a4,a3
     782:	00074703          	lbu	a4,0(a4)
     786:	ff040693          	addi	a3,s0,-16
     78a:	97b6                	add	a5,a5,a3
     78c:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
     790:	fc442783          	lw	a5,-60(s0)
     794:	fe442703          	lw	a4,-28(s0)
     798:	02f757bb          	divuw	a5,a4,a5
     79c:	fef42223          	sw	a5,-28(s0)
     7a0:	fe442783          	lw	a5,-28(s0)
     7a4:	2781                	sext.w	a5,a5
     7a6:	fbc5                	bnez	a5,756 <printint+0x5a>
  if(neg)
     7a8:	fe842783          	lw	a5,-24(s0)
     7ac:	2781                	sext.w	a5,a5
     7ae:	cf95                	beqz	a5,7ea <printint+0xee>
    buf[i++] = '-';
     7b0:	fec42783          	lw	a5,-20(s0)
     7b4:	0017871b          	addiw	a4,a5,1
     7b8:	fee42623          	sw	a4,-20(s0)
     7bc:	ff040713          	addi	a4,s0,-16
     7c0:	97ba                	add	a5,a5,a4
     7c2:	02d00713          	li	a4,45
     7c6:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
     7ca:	a005                	j	7ea <printint+0xee>
    putc(fd, buf[i]);
     7cc:	fec42783          	lw	a5,-20(s0)
     7d0:	ff040713          	addi	a4,s0,-16
     7d4:	97ba                	add	a5,a5,a4
     7d6:	fe07c703          	lbu	a4,-32(a5)
     7da:	fcc42783          	lw	a5,-52(s0)
     7de:	85ba                	mv	a1,a4
     7e0:	853e                	mv	a0,a5
     7e2:	00000097          	auipc	ra,0x0
     7e6:	ee4080e7          	jalr	-284(ra) # 6c6 <putc>
  while(--i >= 0)
     7ea:	fec42783          	lw	a5,-20(s0)
     7ee:	37fd                	addiw	a5,a5,-1
     7f0:	fef42623          	sw	a5,-20(s0)
     7f4:	fec42783          	lw	a5,-20(s0)
     7f8:	2781                	sext.w	a5,a5
     7fa:	fc07d9e3          	bgez	a5,7cc <printint+0xd0>
}
     7fe:	0001                	nop
     800:	0001                	nop
     802:	70e2                	ld	ra,56(sp)
     804:	7442                	ld	s0,48(sp)
     806:	6121                	addi	sp,sp,64
     808:	8082                	ret

000000000000080a <printptr>:

static void
printptr(int fd, uint64 x) {
     80a:	7179                	addi	sp,sp,-48
     80c:	f406                	sd	ra,40(sp)
     80e:	f022                	sd	s0,32(sp)
     810:	1800                	addi	s0,sp,48
     812:	87aa                	mv	a5,a0
     814:	fcb43823          	sd	a1,-48(s0)
     818:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
     81c:	fdc42783          	lw	a5,-36(s0)
     820:	03000593          	li	a1,48
     824:	853e                	mv	a0,a5
     826:	00000097          	auipc	ra,0x0
     82a:	ea0080e7          	jalr	-352(ra) # 6c6 <putc>
  putc(fd, 'x');
     82e:	fdc42783          	lw	a5,-36(s0)
     832:	07800593          	li	a1,120
     836:	853e                	mv	a0,a5
     838:	00000097          	auipc	ra,0x0
     83c:	e8e080e7          	jalr	-370(ra) # 6c6 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     840:	fe042623          	sw	zero,-20(s0)
     844:	a82d                	j	87e <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     846:	fd043783          	ld	a5,-48(s0)
     84a:	93f1                	srli	a5,a5,0x3c
     84c:	00001717          	auipc	a4,0x1
     850:	eec70713          	addi	a4,a4,-276 # 1738 <digits>
     854:	97ba                	add	a5,a5,a4
     856:	0007c703          	lbu	a4,0(a5)
     85a:	fdc42783          	lw	a5,-36(s0)
     85e:	85ba                	mv	a1,a4
     860:	853e                	mv	a0,a5
     862:	00000097          	auipc	ra,0x0
     866:	e64080e7          	jalr	-412(ra) # 6c6 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     86a:	fec42783          	lw	a5,-20(s0)
     86e:	2785                	addiw	a5,a5,1
     870:	fef42623          	sw	a5,-20(s0)
     874:	fd043783          	ld	a5,-48(s0)
     878:	0792                	slli	a5,a5,0x4
     87a:	fcf43823          	sd	a5,-48(s0)
     87e:	fec42783          	lw	a5,-20(s0)
     882:	873e                	mv	a4,a5
     884:	47bd                	li	a5,15
     886:	fce7f0e3          	bgeu	a5,a4,846 <printptr+0x3c>
}
     88a:	0001                	nop
     88c:	0001                	nop
     88e:	70a2                	ld	ra,40(sp)
     890:	7402                	ld	s0,32(sp)
     892:	6145                	addi	sp,sp,48
     894:	8082                	ret

0000000000000896 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     896:	715d                	addi	sp,sp,-80
     898:	e486                	sd	ra,72(sp)
     89a:	e0a2                	sd	s0,64(sp)
     89c:	0880                	addi	s0,sp,80
     89e:	87aa                	mv	a5,a0
     8a0:	fcb43023          	sd	a1,-64(s0)
     8a4:	fac43c23          	sd	a2,-72(s0)
     8a8:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
     8ac:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     8b0:	fe042223          	sw	zero,-28(s0)
     8b4:	a42d                	j	ade <vprintf+0x248>
    c = fmt[i] & 0xff;
     8b6:	fe442783          	lw	a5,-28(s0)
     8ba:	fc043703          	ld	a4,-64(s0)
     8be:	97ba                	add	a5,a5,a4
     8c0:	0007c783          	lbu	a5,0(a5)
     8c4:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
     8c8:	fe042783          	lw	a5,-32(s0)
     8cc:	2781                	sext.w	a5,a5
     8ce:	eb9d                	bnez	a5,904 <vprintf+0x6e>
      if(c == '%'){
     8d0:	fdc42783          	lw	a5,-36(s0)
     8d4:	0007871b          	sext.w	a4,a5
     8d8:	02500793          	li	a5,37
     8dc:	00f71763          	bne	a4,a5,8ea <vprintf+0x54>
        state = '%';
     8e0:	02500793          	li	a5,37
     8e4:	fef42023          	sw	a5,-32(s0)
     8e8:	a2f5                	j	ad4 <vprintf+0x23e>
      } else {
        putc(fd, c);
     8ea:	fdc42783          	lw	a5,-36(s0)
     8ee:	0ff7f713          	andi	a4,a5,255
     8f2:	fcc42783          	lw	a5,-52(s0)
     8f6:	85ba                	mv	a1,a4
     8f8:	853e                	mv	a0,a5
     8fa:	00000097          	auipc	ra,0x0
     8fe:	dcc080e7          	jalr	-564(ra) # 6c6 <putc>
     902:	aac9                	j	ad4 <vprintf+0x23e>
      }
    } else if(state == '%'){
     904:	fe042783          	lw	a5,-32(s0)
     908:	0007871b          	sext.w	a4,a5
     90c:	02500793          	li	a5,37
     910:	1cf71263          	bne	a4,a5,ad4 <vprintf+0x23e>
      if(c == 'd'){
     914:	fdc42783          	lw	a5,-36(s0)
     918:	0007871b          	sext.w	a4,a5
     91c:	06400793          	li	a5,100
     920:	02f71463          	bne	a4,a5,948 <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
     924:	fb843783          	ld	a5,-72(s0)
     928:	00878713          	addi	a4,a5,8
     92c:	fae43c23          	sd	a4,-72(s0)
     930:	4398                	lw	a4,0(a5)
     932:	fcc42783          	lw	a5,-52(s0)
     936:	4685                	li	a3,1
     938:	4629                	li	a2,10
     93a:	85ba                	mv	a1,a4
     93c:	853e                	mv	a0,a5
     93e:	00000097          	auipc	ra,0x0
     942:	dbe080e7          	jalr	-578(ra) # 6fc <printint>
     946:	a269                	j	ad0 <vprintf+0x23a>
      } else if(c == 'l') {
     948:	fdc42783          	lw	a5,-36(s0)
     94c:	0007871b          	sext.w	a4,a5
     950:	06c00793          	li	a5,108
     954:	02f71663          	bne	a4,a5,980 <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
     958:	fb843783          	ld	a5,-72(s0)
     95c:	00878713          	addi	a4,a5,8
     960:	fae43c23          	sd	a4,-72(s0)
     964:	639c                	ld	a5,0(a5)
     966:	0007871b          	sext.w	a4,a5
     96a:	fcc42783          	lw	a5,-52(s0)
     96e:	4681                	li	a3,0
     970:	4629                	li	a2,10
     972:	85ba                	mv	a1,a4
     974:	853e                	mv	a0,a5
     976:	00000097          	auipc	ra,0x0
     97a:	d86080e7          	jalr	-634(ra) # 6fc <printint>
     97e:	aa89                	j	ad0 <vprintf+0x23a>
      } else if(c == 'x') {
     980:	fdc42783          	lw	a5,-36(s0)
     984:	0007871b          	sext.w	a4,a5
     988:	07800793          	li	a5,120
     98c:	02f71463          	bne	a4,a5,9b4 <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
     990:	fb843783          	ld	a5,-72(s0)
     994:	00878713          	addi	a4,a5,8
     998:	fae43c23          	sd	a4,-72(s0)
     99c:	4398                	lw	a4,0(a5)
     99e:	fcc42783          	lw	a5,-52(s0)
     9a2:	4681                	li	a3,0
     9a4:	4641                	li	a2,16
     9a6:	85ba                	mv	a1,a4
     9a8:	853e                	mv	a0,a5
     9aa:	00000097          	auipc	ra,0x0
     9ae:	d52080e7          	jalr	-686(ra) # 6fc <printint>
     9b2:	aa39                	j	ad0 <vprintf+0x23a>
      } else if(c == 'p') {
     9b4:	fdc42783          	lw	a5,-36(s0)
     9b8:	0007871b          	sext.w	a4,a5
     9bc:	07000793          	li	a5,112
     9c0:	02f71263          	bne	a4,a5,9e4 <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
     9c4:	fb843783          	ld	a5,-72(s0)
     9c8:	00878713          	addi	a4,a5,8
     9cc:	fae43c23          	sd	a4,-72(s0)
     9d0:	6398                	ld	a4,0(a5)
     9d2:	fcc42783          	lw	a5,-52(s0)
     9d6:	85ba                	mv	a1,a4
     9d8:	853e                	mv	a0,a5
     9da:	00000097          	auipc	ra,0x0
     9de:	e30080e7          	jalr	-464(ra) # 80a <printptr>
     9e2:	a0fd                	j	ad0 <vprintf+0x23a>
      } else if(c == 's'){
     9e4:	fdc42783          	lw	a5,-36(s0)
     9e8:	0007871b          	sext.w	a4,a5
     9ec:	07300793          	li	a5,115
     9f0:	04f71c63          	bne	a4,a5,a48 <vprintf+0x1b2>
        s = va_arg(ap, char*);
     9f4:	fb843783          	ld	a5,-72(s0)
     9f8:	00878713          	addi	a4,a5,8
     9fc:	fae43c23          	sd	a4,-72(s0)
     a00:	639c                	ld	a5,0(a5)
     a02:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
     a06:	fe843783          	ld	a5,-24(s0)
     a0a:	eb8d                	bnez	a5,a3c <vprintf+0x1a6>
          s = "(null)";
     a0c:	00001797          	auipc	a5,0x1
     a10:	d2478793          	addi	a5,a5,-732 # 1730 <schedule_rm+0x3a2>
     a14:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     a18:	a015                	j	a3c <vprintf+0x1a6>
          putc(fd, *s);
     a1a:	fe843783          	ld	a5,-24(s0)
     a1e:	0007c703          	lbu	a4,0(a5)
     a22:	fcc42783          	lw	a5,-52(s0)
     a26:	85ba                	mv	a1,a4
     a28:	853e                	mv	a0,a5
     a2a:	00000097          	auipc	ra,0x0
     a2e:	c9c080e7          	jalr	-868(ra) # 6c6 <putc>
          s++;
     a32:	fe843783          	ld	a5,-24(s0)
     a36:	0785                	addi	a5,a5,1
     a38:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     a3c:	fe843783          	ld	a5,-24(s0)
     a40:	0007c783          	lbu	a5,0(a5)
     a44:	fbf9                	bnez	a5,a1a <vprintf+0x184>
     a46:	a069                	j	ad0 <vprintf+0x23a>
        }
      } else if(c == 'c'){
     a48:	fdc42783          	lw	a5,-36(s0)
     a4c:	0007871b          	sext.w	a4,a5
     a50:	06300793          	li	a5,99
     a54:	02f71463          	bne	a4,a5,a7c <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
     a58:	fb843783          	ld	a5,-72(s0)
     a5c:	00878713          	addi	a4,a5,8
     a60:	fae43c23          	sd	a4,-72(s0)
     a64:	439c                	lw	a5,0(a5)
     a66:	0ff7f713          	andi	a4,a5,255
     a6a:	fcc42783          	lw	a5,-52(s0)
     a6e:	85ba                	mv	a1,a4
     a70:	853e                	mv	a0,a5
     a72:	00000097          	auipc	ra,0x0
     a76:	c54080e7          	jalr	-940(ra) # 6c6 <putc>
     a7a:	a899                	j	ad0 <vprintf+0x23a>
      } else if(c == '%'){
     a7c:	fdc42783          	lw	a5,-36(s0)
     a80:	0007871b          	sext.w	a4,a5
     a84:	02500793          	li	a5,37
     a88:	00f71f63          	bne	a4,a5,aa6 <vprintf+0x210>
        putc(fd, c);
     a8c:	fdc42783          	lw	a5,-36(s0)
     a90:	0ff7f713          	andi	a4,a5,255
     a94:	fcc42783          	lw	a5,-52(s0)
     a98:	85ba                	mv	a1,a4
     a9a:	853e                	mv	a0,a5
     a9c:	00000097          	auipc	ra,0x0
     aa0:	c2a080e7          	jalr	-982(ra) # 6c6 <putc>
     aa4:	a035                	j	ad0 <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     aa6:	fcc42783          	lw	a5,-52(s0)
     aaa:	02500593          	li	a1,37
     aae:	853e                	mv	a0,a5
     ab0:	00000097          	auipc	ra,0x0
     ab4:	c16080e7          	jalr	-1002(ra) # 6c6 <putc>
        putc(fd, c);
     ab8:	fdc42783          	lw	a5,-36(s0)
     abc:	0ff7f713          	andi	a4,a5,255
     ac0:	fcc42783          	lw	a5,-52(s0)
     ac4:	85ba                	mv	a1,a4
     ac6:	853e                	mv	a0,a5
     ac8:	00000097          	auipc	ra,0x0
     acc:	bfe080e7          	jalr	-1026(ra) # 6c6 <putc>
      }
      state = 0;
     ad0:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     ad4:	fe442783          	lw	a5,-28(s0)
     ad8:	2785                	addiw	a5,a5,1
     ada:	fef42223          	sw	a5,-28(s0)
     ade:	fe442783          	lw	a5,-28(s0)
     ae2:	fc043703          	ld	a4,-64(s0)
     ae6:	97ba                	add	a5,a5,a4
     ae8:	0007c783          	lbu	a5,0(a5)
     aec:	dc0795e3          	bnez	a5,8b6 <vprintf+0x20>
    }
  }
}
     af0:	0001                	nop
     af2:	0001                	nop
     af4:	60a6                	ld	ra,72(sp)
     af6:	6406                	ld	s0,64(sp)
     af8:	6161                	addi	sp,sp,80
     afa:	8082                	ret

0000000000000afc <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     afc:	7159                	addi	sp,sp,-112
     afe:	fc06                	sd	ra,56(sp)
     b00:	f822                	sd	s0,48(sp)
     b02:	0080                	addi	s0,sp,64
     b04:	fcb43823          	sd	a1,-48(s0)
     b08:	e010                	sd	a2,0(s0)
     b0a:	e414                	sd	a3,8(s0)
     b0c:	e818                	sd	a4,16(s0)
     b0e:	ec1c                	sd	a5,24(s0)
     b10:	03043023          	sd	a6,32(s0)
     b14:	03143423          	sd	a7,40(s0)
     b18:	87aa                	mv	a5,a0
     b1a:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
     b1e:	03040793          	addi	a5,s0,48
     b22:	fcf43423          	sd	a5,-56(s0)
     b26:	fc843783          	ld	a5,-56(s0)
     b2a:	fd078793          	addi	a5,a5,-48
     b2e:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
     b32:	fe843703          	ld	a4,-24(s0)
     b36:	fdc42783          	lw	a5,-36(s0)
     b3a:	863a                	mv	a2,a4
     b3c:	fd043583          	ld	a1,-48(s0)
     b40:	853e                	mv	a0,a5
     b42:	00000097          	auipc	ra,0x0
     b46:	d54080e7          	jalr	-684(ra) # 896 <vprintf>
}
     b4a:	0001                	nop
     b4c:	70e2                	ld	ra,56(sp)
     b4e:	7442                	ld	s0,48(sp)
     b50:	6165                	addi	sp,sp,112
     b52:	8082                	ret

0000000000000b54 <printf>:

void
printf(const char *fmt, ...)
{
     b54:	7159                	addi	sp,sp,-112
     b56:	f406                	sd	ra,40(sp)
     b58:	f022                	sd	s0,32(sp)
     b5a:	1800                	addi	s0,sp,48
     b5c:	fca43c23          	sd	a0,-40(s0)
     b60:	e40c                	sd	a1,8(s0)
     b62:	e810                	sd	a2,16(s0)
     b64:	ec14                	sd	a3,24(s0)
     b66:	f018                	sd	a4,32(s0)
     b68:	f41c                	sd	a5,40(s0)
     b6a:	03043823          	sd	a6,48(s0)
     b6e:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
     b72:	04040793          	addi	a5,s0,64
     b76:	fcf43823          	sd	a5,-48(s0)
     b7a:	fd043783          	ld	a5,-48(s0)
     b7e:	fc878793          	addi	a5,a5,-56
     b82:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
     b86:	fe843783          	ld	a5,-24(s0)
     b8a:	863e                	mv	a2,a5
     b8c:	fd843583          	ld	a1,-40(s0)
     b90:	4505                	li	a0,1
     b92:	00000097          	auipc	ra,0x0
     b96:	d04080e7          	jalr	-764(ra) # 896 <vprintf>
}
     b9a:	0001                	nop
     b9c:	70a2                	ld	ra,40(sp)
     b9e:	7402                	ld	s0,32(sp)
     ba0:	6165                	addi	sp,sp,112
     ba2:	8082                	ret

0000000000000ba4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     ba4:	7179                	addi	sp,sp,-48
     ba6:	f422                	sd	s0,40(sp)
     ba8:	1800                	addi	s0,sp,48
     baa:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
     bae:	fd843783          	ld	a5,-40(s0)
     bb2:	17c1                	addi	a5,a5,-16
     bb4:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     bb8:	00001797          	auipc	a5,0x1
     bbc:	da878793          	addi	a5,a5,-600 # 1960 <freep>
     bc0:	639c                	ld	a5,0(a5)
     bc2:	fef43423          	sd	a5,-24(s0)
     bc6:	a815                	j	bfa <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     bc8:	fe843783          	ld	a5,-24(s0)
     bcc:	639c                	ld	a5,0(a5)
     bce:	fe843703          	ld	a4,-24(s0)
     bd2:	00f76f63          	bltu	a4,a5,bf0 <free+0x4c>
     bd6:	fe043703          	ld	a4,-32(s0)
     bda:	fe843783          	ld	a5,-24(s0)
     bde:	02e7eb63          	bltu	a5,a4,c14 <free+0x70>
     be2:	fe843783          	ld	a5,-24(s0)
     be6:	639c                	ld	a5,0(a5)
     be8:	fe043703          	ld	a4,-32(s0)
     bec:	02f76463          	bltu	a4,a5,c14 <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     bf0:	fe843783          	ld	a5,-24(s0)
     bf4:	639c                	ld	a5,0(a5)
     bf6:	fef43423          	sd	a5,-24(s0)
     bfa:	fe043703          	ld	a4,-32(s0)
     bfe:	fe843783          	ld	a5,-24(s0)
     c02:	fce7f3e3          	bgeu	a5,a4,bc8 <free+0x24>
     c06:	fe843783          	ld	a5,-24(s0)
     c0a:	639c                	ld	a5,0(a5)
     c0c:	fe043703          	ld	a4,-32(s0)
     c10:	faf77ce3          	bgeu	a4,a5,bc8 <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
     c14:	fe043783          	ld	a5,-32(s0)
     c18:	479c                	lw	a5,8(a5)
     c1a:	1782                	slli	a5,a5,0x20
     c1c:	9381                	srli	a5,a5,0x20
     c1e:	0792                	slli	a5,a5,0x4
     c20:	fe043703          	ld	a4,-32(s0)
     c24:	973e                	add	a4,a4,a5
     c26:	fe843783          	ld	a5,-24(s0)
     c2a:	639c                	ld	a5,0(a5)
     c2c:	02f71763          	bne	a4,a5,c5a <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
     c30:	fe043783          	ld	a5,-32(s0)
     c34:	4798                	lw	a4,8(a5)
     c36:	fe843783          	ld	a5,-24(s0)
     c3a:	639c                	ld	a5,0(a5)
     c3c:	479c                	lw	a5,8(a5)
     c3e:	9fb9                	addw	a5,a5,a4
     c40:	0007871b          	sext.w	a4,a5
     c44:	fe043783          	ld	a5,-32(s0)
     c48:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
     c4a:	fe843783          	ld	a5,-24(s0)
     c4e:	639c                	ld	a5,0(a5)
     c50:	6398                	ld	a4,0(a5)
     c52:	fe043783          	ld	a5,-32(s0)
     c56:	e398                	sd	a4,0(a5)
     c58:	a039                	j	c66 <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
     c5a:	fe843783          	ld	a5,-24(s0)
     c5e:	6398                	ld	a4,0(a5)
     c60:	fe043783          	ld	a5,-32(s0)
     c64:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
     c66:	fe843783          	ld	a5,-24(s0)
     c6a:	479c                	lw	a5,8(a5)
     c6c:	1782                	slli	a5,a5,0x20
     c6e:	9381                	srli	a5,a5,0x20
     c70:	0792                	slli	a5,a5,0x4
     c72:	fe843703          	ld	a4,-24(s0)
     c76:	97ba                	add	a5,a5,a4
     c78:	fe043703          	ld	a4,-32(s0)
     c7c:	02f71563          	bne	a4,a5,ca6 <free+0x102>
    p->s.size += bp->s.size;
     c80:	fe843783          	ld	a5,-24(s0)
     c84:	4798                	lw	a4,8(a5)
     c86:	fe043783          	ld	a5,-32(s0)
     c8a:	479c                	lw	a5,8(a5)
     c8c:	9fb9                	addw	a5,a5,a4
     c8e:	0007871b          	sext.w	a4,a5
     c92:	fe843783          	ld	a5,-24(s0)
     c96:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
     c98:	fe043783          	ld	a5,-32(s0)
     c9c:	6398                	ld	a4,0(a5)
     c9e:	fe843783          	ld	a5,-24(s0)
     ca2:	e398                	sd	a4,0(a5)
     ca4:	a031                	j	cb0 <free+0x10c>
  } else
    p->s.ptr = bp;
     ca6:	fe843783          	ld	a5,-24(s0)
     caa:	fe043703          	ld	a4,-32(s0)
     cae:	e398                	sd	a4,0(a5)
  freep = p;
     cb0:	00001797          	auipc	a5,0x1
     cb4:	cb078793          	addi	a5,a5,-848 # 1960 <freep>
     cb8:	fe843703          	ld	a4,-24(s0)
     cbc:	e398                	sd	a4,0(a5)
}
     cbe:	0001                	nop
     cc0:	7422                	ld	s0,40(sp)
     cc2:	6145                	addi	sp,sp,48
     cc4:	8082                	ret

0000000000000cc6 <morecore>:

static Header*
morecore(uint nu)
{
     cc6:	7179                	addi	sp,sp,-48
     cc8:	f406                	sd	ra,40(sp)
     cca:	f022                	sd	s0,32(sp)
     ccc:	1800                	addi	s0,sp,48
     cce:	87aa                	mv	a5,a0
     cd0:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
     cd4:	fdc42783          	lw	a5,-36(s0)
     cd8:	0007871b          	sext.w	a4,a5
     cdc:	6785                	lui	a5,0x1
     cde:	00f77563          	bgeu	a4,a5,ce8 <morecore+0x22>
    nu = 4096;
     ce2:	6785                	lui	a5,0x1
     ce4:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
     ce8:	fdc42783          	lw	a5,-36(s0)
     cec:	0047979b          	slliw	a5,a5,0x4
     cf0:	2781                	sext.w	a5,a5
     cf2:	2781                	sext.w	a5,a5
     cf4:	853e                	mv	a0,a5
     cf6:	00000097          	auipc	ra,0x0
     cfa:	9a0080e7          	jalr	-1632(ra) # 696 <sbrk>
     cfe:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
     d02:	fe843703          	ld	a4,-24(s0)
     d06:	57fd                	li	a5,-1
     d08:	00f71463          	bne	a4,a5,d10 <morecore+0x4a>
    return 0;
     d0c:	4781                	li	a5,0
     d0e:	a03d                	j	d3c <morecore+0x76>
  hp = (Header*)p;
     d10:	fe843783          	ld	a5,-24(s0)
     d14:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
     d18:	fe043783          	ld	a5,-32(s0)
     d1c:	fdc42703          	lw	a4,-36(s0)
     d20:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
     d22:	fe043783          	ld	a5,-32(s0)
     d26:	07c1                	addi	a5,a5,16
     d28:	853e                	mv	a0,a5
     d2a:	00000097          	auipc	ra,0x0
     d2e:	e7a080e7          	jalr	-390(ra) # ba4 <free>
  return freep;
     d32:	00001797          	auipc	a5,0x1
     d36:	c2e78793          	addi	a5,a5,-978 # 1960 <freep>
     d3a:	639c                	ld	a5,0(a5)
}
     d3c:	853e                	mv	a0,a5
     d3e:	70a2                	ld	ra,40(sp)
     d40:	7402                	ld	s0,32(sp)
     d42:	6145                	addi	sp,sp,48
     d44:	8082                	ret

0000000000000d46 <malloc>:

void*
malloc(uint nbytes)
{
     d46:	7139                	addi	sp,sp,-64
     d48:	fc06                	sd	ra,56(sp)
     d4a:	f822                	sd	s0,48(sp)
     d4c:	0080                	addi	s0,sp,64
     d4e:	87aa                	mv	a5,a0
     d50:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     d54:	fcc46783          	lwu	a5,-52(s0)
     d58:	07bd                	addi	a5,a5,15
     d5a:	8391                	srli	a5,a5,0x4
     d5c:	2781                	sext.w	a5,a5
     d5e:	2785                	addiw	a5,a5,1
     d60:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
     d64:	00001797          	auipc	a5,0x1
     d68:	bfc78793          	addi	a5,a5,-1028 # 1960 <freep>
     d6c:	639c                	ld	a5,0(a5)
     d6e:	fef43023          	sd	a5,-32(s0)
     d72:	fe043783          	ld	a5,-32(s0)
     d76:	ef95                	bnez	a5,db2 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
     d78:	00001797          	auipc	a5,0x1
     d7c:	bd878793          	addi	a5,a5,-1064 # 1950 <base>
     d80:	fef43023          	sd	a5,-32(s0)
     d84:	00001797          	auipc	a5,0x1
     d88:	bdc78793          	addi	a5,a5,-1060 # 1960 <freep>
     d8c:	fe043703          	ld	a4,-32(s0)
     d90:	e398                	sd	a4,0(a5)
     d92:	00001797          	auipc	a5,0x1
     d96:	bce78793          	addi	a5,a5,-1074 # 1960 <freep>
     d9a:	6398                	ld	a4,0(a5)
     d9c:	00001797          	auipc	a5,0x1
     da0:	bb478793          	addi	a5,a5,-1100 # 1950 <base>
     da4:	e398                	sd	a4,0(a5)
    base.s.size = 0;
     da6:	00001797          	auipc	a5,0x1
     daa:	baa78793          	addi	a5,a5,-1110 # 1950 <base>
     dae:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     db2:	fe043783          	ld	a5,-32(s0)
     db6:	639c                	ld	a5,0(a5)
     db8:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     dbc:	fe843783          	ld	a5,-24(s0)
     dc0:	4798                	lw	a4,8(a5)
     dc2:	fdc42783          	lw	a5,-36(s0)
     dc6:	2781                	sext.w	a5,a5
     dc8:	06f76863          	bltu	a4,a5,e38 <malloc+0xf2>
      if(p->s.size == nunits)
     dcc:	fe843783          	ld	a5,-24(s0)
     dd0:	4798                	lw	a4,8(a5)
     dd2:	fdc42783          	lw	a5,-36(s0)
     dd6:	2781                	sext.w	a5,a5
     dd8:	00e79963          	bne	a5,a4,dea <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
     ddc:	fe843783          	ld	a5,-24(s0)
     de0:	6398                	ld	a4,0(a5)
     de2:	fe043783          	ld	a5,-32(s0)
     de6:	e398                	sd	a4,0(a5)
     de8:	a82d                	j	e22 <malloc+0xdc>
      else {
        p->s.size -= nunits;
     dea:	fe843783          	ld	a5,-24(s0)
     dee:	4798                	lw	a4,8(a5)
     df0:	fdc42783          	lw	a5,-36(s0)
     df4:	40f707bb          	subw	a5,a4,a5
     df8:	0007871b          	sext.w	a4,a5
     dfc:	fe843783          	ld	a5,-24(s0)
     e00:	c798                	sw	a4,8(a5)
        p += p->s.size;
     e02:	fe843783          	ld	a5,-24(s0)
     e06:	479c                	lw	a5,8(a5)
     e08:	1782                	slli	a5,a5,0x20
     e0a:	9381                	srli	a5,a5,0x20
     e0c:	0792                	slli	a5,a5,0x4
     e0e:	fe843703          	ld	a4,-24(s0)
     e12:	97ba                	add	a5,a5,a4
     e14:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
     e18:	fe843783          	ld	a5,-24(s0)
     e1c:	fdc42703          	lw	a4,-36(s0)
     e20:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
     e22:	00001797          	auipc	a5,0x1
     e26:	b3e78793          	addi	a5,a5,-1218 # 1960 <freep>
     e2a:	fe043703          	ld	a4,-32(s0)
     e2e:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
     e30:	fe843783          	ld	a5,-24(s0)
     e34:	07c1                	addi	a5,a5,16
     e36:	a091                	j	e7a <malloc+0x134>
    }
    if(p == freep)
     e38:	00001797          	auipc	a5,0x1
     e3c:	b2878793          	addi	a5,a5,-1240 # 1960 <freep>
     e40:	639c                	ld	a5,0(a5)
     e42:	fe843703          	ld	a4,-24(s0)
     e46:	02f71063          	bne	a4,a5,e66 <malloc+0x120>
      if((p = morecore(nunits)) == 0)
     e4a:	fdc42783          	lw	a5,-36(s0)
     e4e:	853e                	mv	a0,a5
     e50:	00000097          	auipc	ra,0x0
     e54:	e76080e7          	jalr	-394(ra) # cc6 <morecore>
     e58:	fea43423          	sd	a0,-24(s0)
     e5c:	fe843783          	ld	a5,-24(s0)
     e60:	e399                	bnez	a5,e66 <malloc+0x120>
        return 0;
     e62:	4781                	li	a5,0
     e64:	a819                	j	e7a <malloc+0x134>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     e66:	fe843783          	ld	a5,-24(s0)
     e6a:	fef43023          	sd	a5,-32(s0)
     e6e:	fe843783          	ld	a5,-24(s0)
     e72:	639c                	ld	a5,0(a5)
     e74:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     e78:	b791                	j	dbc <malloc+0x76>
  }
}
     e7a:	853e                	mv	a0,a5
     e7c:	70e2                	ld	ra,56(sp)
     e7e:	7442                	ld	s0,48(sp)
     e80:	6121                	addi	sp,sp,64
     e82:	8082                	ret

0000000000000e84 <setjmp>:
     e84:	e100                	sd	s0,0(a0)
     e86:	e504                	sd	s1,8(a0)
     e88:	01253823          	sd	s2,16(a0)
     e8c:	01353c23          	sd	s3,24(a0)
     e90:	03453023          	sd	s4,32(a0)
     e94:	03553423          	sd	s5,40(a0)
     e98:	03653823          	sd	s6,48(a0)
     e9c:	03753c23          	sd	s7,56(a0)
     ea0:	05853023          	sd	s8,64(a0)
     ea4:	05953423          	sd	s9,72(a0)
     ea8:	05a53823          	sd	s10,80(a0)
     eac:	05b53c23          	sd	s11,88(a0)
     eb0:	06153023          	sd	ra,96(a0)
     eb4:	06253423          	sd	sp,104(a0)
     eb8:	4501                	li	a0,0
     eba:	8082                	ret

0000000000000ebc <longjmp>:
     ebc:	6100                	ld	s0,0(a0)
     ebe:	6504                	ld	s1,8(a0)
     ec0:	01053903          	ld	s2,16(a0)
     ec4:	01853983          	ld	s3,24(a0)
     ec8:	02053a03          	ld	s4,32(a0)
     ecc:	02853a83          	ld	s5,40(a0)
     ed0:	03053b03          	ld	s6,48(a0)
     ed4:	03853b83          	ld	s7,56(a0)
     ed8:	04053c03          	ld	s8,64(a0)
     edc:	04853c83          	ld	s9,72(a0)
     ee0:	05053d03          	ld	s10,80(a0)
     ee4:	05853d83          	ld	s11,88(a0)
     ee8:	06053083          	ld	ra,96(a0)
     eec:	06853103          	ld	sp,104(a0)
     ef0:	c199                	beqz	a1,ef6 <longjmp_1>
     ef2:	852e                	mv	a0,a1
     ef4:	8082                	ret

0000000000000ef6 <longjmp_1>:
     ef6:	4505                	li	a0,1
     ef8:	8082                	ret

0000000000000efa <list_empty>:
/**
 * list_empty - tests whether a list is empty
 * @head: the list to test.
 */
static inline int list_empty(const struct list_head *head)
{
     efa:	1101                	addi	sp,sp,-32
     efc:	ec22                	sd	s0,24(sp)
     efe:	1000                	addi	s0,sp,32
     f00:	fea43423          	sd	a0,-24(s0)
    return head->next == head;
     f04:	fe843783          	ld	a5,-24(s0)
     f08:	639c                	ld	a5,0(a5)
     f0a:	fe843703          	ld	a4,-24(s0)
     f0e:	40f707b3          	sub	a5,a4,a5
     f12:	0017b793          	seqz	a5,a5
     f16:	0ff7f793          	andi	a5,a5,255
     f1a:	2781                	sext.w	a5,a5
}
     f1c:	853e                	mv	a0,a5
     f1e:	6462                	ld	s0,24(sp)
     f20:	6105                	addi	sp,sp,32
     f22:	8082                	ret

0000000000000f24 <schedule_default>:

#define NULL 0

/* default scheduling algorithm */
struct threads_sched_result schedule_default(struct threads_sched_args args)
{
     f24:	715d                	addi	sp,sp,-80
     f26:	e4a2                	sd	s0,72(sp)
     f28:	e0a6                	sd	s1,64(sp)
     f2a:	0880                	addi	s0,sp,80
     f2c:	84aa                	mv	s1,a0
    struct thread *thread_with_smallest_id = NULL;
     f2e:	fe043423          	sd	zero,-24(s0)
    struct thread *th = NULL;
     f32:	fe043023          	sd	zero,-32(s0)
    list_for_each_entry(th, args.run_queue, thread_list) {
     f36:	649c                	ld	a5,8(s1)
     f38:	639c                	ld	a5,0(a5)
     f3a:	fcf43c23          	sd	a5,-40(s0)
     f3e:	fd843783          	ld	a5,-40(s0)
     f42:	fd878793          	addi	a5,a5,-40
     f46:	fef43023          	sd	a5,-32(s0)
     f4a:	a81d                	j	f80 <schedule_default+0x5c>
        if (thread_with_smallest_id == NULL || th->ID < thread_with_smallest_id->ID) {
     f4c:	fe843783          	ld	a5,-24(s0)
     f50:	cb89                	beqz	a5,f62 <schedule_default+0x3e>
     f52:	fe043783          	ld	a5,-32(s0)
     f56:	5398                	lw	a4,32(a5)
     f58:	fe843783          	ld	a5,-24(s0)
     f5c:	539c                	lw	a5,32(a5)
     f5e:	00f75663          	bge	a4,a5,f6a <schedule_default+0x46>
            thread_with_smallest_id = th;
     f62:	fe043783          	ld	a5,-32(s0)
     f66:	fef43423          	sd	a5,-24(s0)
    list_for_each_entry(th, args.run_queue, thread_list) {
     f6a:	fe043783          	ld	a5,-32(s0)
     f6e:	779c                	ld	a5,40(a5)
     f70:	fcf43823          	sd	a5,-48(s0)
     f74:	fd043783          	ld	a5,-48(s0)
     f78:	fd878793          	addi	a5,a5,-40
     f7c:	fef43023          	sd	a5,-32(s0)
     f80:	fe043783          	ld	a5,-32(s0)
     f84:	02878713          	addi	a4,a5,40
     f88:	649c                	ld	a5,8(s1)
     f8a:	fcf711e3          	bne	a4,a5,f4c <schedule_default+0x28>
        }
    }

    struct threads_sched_result r;
    if (thread_with_smallest_id != NULL) {
     f8e:	fe843783          	ld	a5,-24(s0)
     f92:	cf89                	beqz	a5,fac <schedule_default+0x88>
        r.scheduled_thread_list_member = &thread_with_smallest_id->thread_list;
     f94:	fe843783          	ld	a5,-24(s0)
     f98:	02878793          	addi	a5,a5,40
     f9c:	faf43823          	sd	a5,-80(s0)
        r.allocated_time = thread_with_smallest_id->remaining_time;
     fa0:	fe843783          	ld	a5,-24(s0)
     fa4:	47fc                	lw	a5,76(a5)
     fa6:	faf42c23          	sw	a5,-72(s0)
     faa:	a039                	j	fb8 <schedule_default+0x94>
    } else {
        r.scheduled_thread_list_member = args.run_queue;
     fac:	649c                	ld	a5,8(s1)
     fae:	faf43823          	sd	a5,-80(s0)
        r.allocated_time = 1;
     fb2:	4785                	li	a5,1
     fb4:	faf42c23          	sw	a5,-72(s0)
    }

    return r;
     fb8:	fb043783          	ld	a5,-80(s0)
     fbc:	fcf43023          	sd	a5,-64(s0)
     fc0:	fb843783          	ld	a5,-72(s0)
     fc4:	fcf43423          	sd	a5,-56(s0)
     fc8:	fc043703          	ld	a4,-64(s0)
     fcc:	fc843783          	ld	a5,-56(s0)
     fd0:	863a                	mv	a2,a4
     fd2:	86be                	mv	a3,a5
     fd4:	8732                	mv	a4,a2
     fd6:	87b6                	mv	a5,a3
}
     fd8:	853a                	mv	a0,a4
     fda:	85be                	mv	a1,a5
     fdc:	6426                	ld	s0,72(sp)
     fde:	6486                	ld	s1,64(sp)
     fe0:	6161                	addi	sp,sp,80
     fe2:	8082                	ret

0000000000000fe4 <schedule_edf>:

/* Earliest-Deadline-First scheduling */
struct threads_sched_result schedule_edf(struct threads_sched_args args)
{
     fe4:	7115                	addi	sp,sp,-224
     fe6:	ed86                	sd	ra,216(sp)
     fe8:	e9a2                	sd	s0,208(sp)
     fea:	e5a6                	sd	s1,200(sp)
     fec:	e1ca                	sd	s2,192(sp)
     fee:	fd4e                	sd	s3,184(sp)
     ff0:	1180                	addi	s0,sp,224
     ff2:	84aa                	mv	s1,a0
    // the scheduling is called when a interrupt event happens (either a fn end or a new one is added)
    // need to determine the next thread to execute and the allocated time.

    struct threads_sched_result r;
    if(list_empty(args.run_queue)){
     ff4:	649c                	ld	a5,8(s1)
     ff6:	853e                	mv	a0,a5
     ff8:	00000097          	auipc	ra,0x0
     ffc:	f02080e7          	jalr	-254(ra) # efa <list_empty>
    1000:	87aa                	mv	a5,a0
    1002:	c3d1                	beqz	a5,1086 <schedule_edf+0xa2>
        // SPEC 3
        r.scheduled_thread_list_member = args.run_queue;
    1004:	649c                	ld	a5,8(s1)
    1006:	f2f43423          	sd	a5,-216(s0)
        int least_release_time = 99999;
    100a:	67e1                	lui	a5,0x18
    100c:	69f78793          	addi	a5,a5,1695 # 1869f <__global_pointer$+0x16767>
    1010:	fcf42623          	sw	a5,-52(s0)
        struct release_queue_entry* cur;
        list_for_each_entry(cur, args.release_queue, thread_list) {
    1014:	689c                	ld	a5,16(s1)
    1016:	639c                	ld	a5,0(a5)
    1018:	f4f43823          	sd	a5,-176(s0)
    101c:	f5043783          	ld	a5,-176(s0)
    1020:	17e1                	addi	a5,a5,-8
    1022:	fcf43023          	sd	a5,-64(s0)
    1026:	a805                	j	1056 <schedule_edf+0x72>
            if(cur->release_time<least_release_time){
    1028:	fc043783          	ld	a5,-64(s0)
    102c:	4f98                	lw	a4,24(a5)
    102e:	fcc42783          	lw	a5,-52(s0)
    1032:	2781                	sext.w	a5,a5
    1034:	00f75763          	bge	a4,a5,1042 <schedule_edf+0x5e>
                least_release_time = cur->release_time;
    1038:	fc043783          	ld	a5,-64(s0)
    103c:	4f9c                	lw	a5,24(a5)
    103e:	fcf42623          	sw	a5,-52(s0)
        list_for_each_entry(cur, args.release_queue, thread_list) {
    1042:	fc043783          	ld	a5,-64(s0)
    1046:	679c                	ld	a5,8(a5)
    1048:	f4f43423          	sd	a5,-184(s0)
    104c:	f4843783          	ld	a5,-184(s0)
    1050:	17e1                	addi	a5,a5,-8
    1052:	fcf43023          	sd	a5,-64(s0)
    1056:	fc043783          	ld	a5,-64(s0)
    105a:	00878713          	addi	a4,a5,8
    105e:	689c                	ld	a5,16(s1)
    1060:	fcf714e3          	bne	a4,a5,1028 <schedule_edf+0x44>
            }
        }
        r.allocated_time = least_release_time - args.current_time ;
    1064:	409c                	lw	a5,0(s1)
    1066:	fcc42703          	lw	a4,-52(s0)
    106a:	40f707bb          	subw	a5,a4,a5
    106e:	2781                	sext.w	a5,a5
    1070:	f2f42823          	sw	a5,-208(s0)
        return r;
    1074:	f2843783          	ld	a5,-216(s0)
    1078:	f2f43c23          	sd	a5,-200(s0)
    107c:	f3043783          	ld	a5,-208(s0)
    1080:	f4f43023          	sd	a5,-192(s0)
    1084:	a4e5                	j	136c <schedule_edf+0x388>
    }else{
        // run queue is not empty.
        struct thread *th = NULL;
    1086:	fa043c23          	sd	zero,-72(s0)
        struct thread *min_th = NULL;
    108a:	fa043823          	sd	zero,-80(s0)
        struct thread *min_miss_deadline_th = NULL;
    108e:	fa043423          	sd	zero,-88(s0)
        list_for_each_entry(th, args.run_queue, thread_list) {
    1092:	649c                	ld	a5,8(s1)
    1094:	639c                	ld	a5,0(a5)
    1096:	f8f43423          	sd	a5,-120(s0)
    109a:	f8843783          	ld	a5,-120(s0)
    109e:	fd878793          	addi	a5,a5,-40
    10a2:	faf43c23          	sd	a5,-72(s0)
    10a6:	a849                	j	1138 <schedule_edf+0x154>
            // printf("in run queue: %d\n", th->ID);
            if(th->current_deadline <= args.current_time){
    10a8:	fb843783          	ld	a5,-72(s0)
    10ac:	4bb8                	lw	a4,80(a5)
    10ae:	409c                	lw	a5,0(s1)
    10b0:	02e7c163          	blt	a5,a4,10d2 <schedule_edf+0xee>
                if(min_miss_deadline_th == NULL || th->ID<min_miss_deadline_th->ID){
    10b4:	fa843783          	ld	a5,-88(s0)
    10b8:	cb89                	beqz	a5,10ca <schedule_edf+0xe6>
    10ba:	fb843783          	ld	a5,-72(s0)
    10be:	5398                	lw	a4,32(a5)
    10c0:	fa843783          	ld	a5,-88(s0)
    10c4:	539c                	lw	a5,32(a5)
    10c6:	00f75663          	bge	a4,a5,10d2 <schedule_edf+0xee>
                    min_miss_deadline_th = th;
    10ca:	fb843783          	ld	a5,-72(s0)
    10ce:	faf43423          	sd	a5,-88(s0)
                }
            }
            if(min_th == NULL) min_th = th;
    10d2:	fb043783          	ld	a5,-80(s0)
    10d6:	e789                	bnez	a5,10e0 <schedule_edf+0xfc>
    10d8:	fb843783          	ld	a5,-72(s0)
    10dc:	faf43823          	sd	a5,-80(s0)
            if(th->current_deadline<min_th->current_deadline){
    10e0:	fb843783          	ld	a5,-72(s0)
    10e4:	4bb8                	lw	a4,80(a5)
    10e6:	fb043783          	ld	a5,-80(s0)
    10ea:	4bbc                	lw	a5,80(a5)
    10ec:	00f75763          	bge	a4,a5,10fa <schedule_edf+0x116>
                min_th = th;
    10f0:	fb843783          	ld	a5,-72(s0)
    10f4:	faf43823          	sd	a5,-80(s0)
    10f8:	a02d                	j	1122 <schedule_edf+0x13e>
            }else if(th->current_deadline == min_th->current_deadline){
    10fa:	fb843783          	ld	a5,-72(s0)
    10fe:	4bb8                	lw	a4,80(a5)
    1100:	fb043783          	ld	a5,-80(s0)
    1104:	4bbc                	lw	a5,80(a5)
    1106:	00f71e63          	bne	a4,a5,1122 <schedule_edf+0x13e>
                if(th->ID<min_th->ID) min_th = th;
    110a:	fb843783          	ld	a5,-72(s0)
    110e:	5398                	lw	a4,32(a5)
    1110:	fb043783          	ld	a5,-80(s0)
    1114:	539c                	lw	a5,32(a5)
    1116:	00f75663          	bge	a4,a5,1122 <schedule_edf+0x13e>
    111a:	fb843783          	ld	a5,-72(s0)
    111e:	faf43823          	sd	a5,-80(s0)
        list_for_each_entry(th, args.run_queue, thread_list) {
    1122:	fb843783          	ld	a5,-72(s0)
    1126:	779c                	ld	a5,40(a5)
    1128:	f4f43c23          	sd	a5,-168(s0)
    112c:	f5843783          	ld	a5,-168(s0)
    1130:	fd878793          	addi	a5,a5,-40
    1134:	faf43c23          	sd	a5,-72(s0)
    1138:	fb843783          	ld	a5,-72(s0)
    113c:	02878713          	addi	a4,a5,40
    1140:	649c                	ld	a5,8(s1)
    1142:	f6f713e3          	bne	a4,a5,10a8 <schedule_edf+0xc4>
            }
        }

        if(min_miss_deadline_th != NULL) {
    1146:	fa843783          	ld	a5,-88(s0)
    114a:	c395                	beqz	a5,116e <schedule_edf+0x18a>
            // SPEC 4: exist missed deadline
            // printf("exist missed deadline", th->ID);
            r.allocated_time = 0;
    114c:	f2042823          	sw	zero,-208(s0)
            r.scheduled_thread_list_member = &min_miss_deadline_th->thread_list;
    1150:	fa843783          	ld	a5,-88(s0)
    1154:	02878793          	addi	a5,a5,40
    1158:	f2f43423          	sd	a5,-216(s0)
            return r;
    115c:	f2843783          	ld	a5,-216(s0)
    1160:	f2f43c23          	sd	a5,-200(s0)
    1164:	f3043783          	ld	a5,-208(s0)
    1168:	f4f43023          	sd	a5,-192(s0)
    116c:	a401                	j	136c <schedule_edf+0x388>
             // compute allocated time: 
            // 1. a preemption can happen in the future.(need to inspect the release queue)
            // 2. current deadline is met (preemption has not happened)
            // 3. current deadline is missed (current_time + remaining_time > current_deadline)
            // compute the first event that will happen.
            r.scheduled_thread_list_member = &min_th->thread_list;
    116e:	fb043783          	ld	a5,-80(s0)
    1172:	02878793          	addi	a5,a5,40
    1176:	f2f43423          	sd	a5,-216(s0)

            struct release_queue_entry* cur;
            if(list_empty(args.release_queue)){
    117a:	689c                	ld	a5,16(s1)
    117c:	853e                	mv	a0,a5
    117e:	00000097          	auipc	ra,0x0
    1182:	d7c080e7          	jalr	-644(ra) # efa <list_empty>
    1186:	87aa                	mv	a5,a0
    1188:	c3b5                	beqz	a5,11ec <schedule_edf+0x208>
                // printf("release queue is empty\n");
                // a preemption cannot happen, because we've already selected the highest priority thread.
                int remaining_time = 99999;
    118a:	67e1                	lui	a5,0x18
    118c:	69f78793          	addi	a5,a5,1695 # 1869f <__global_pointer$+0x16767>
    1190:	f6f42623          	sw	a5,-148(s0)

                int deadline_time = min_th->current_deadline - args.current_time;
    1194:	fb043783          	ld	a5,-80(s0)
    1198:	4bb8                	lw	a4,80(a5)
    119a:	409c                	lw	a5,0(s1)
    119c:	40f707bb          	subw	a5,a4,a5
    11a0:	f6f42423          	sw	a5,-152(s0)
                remaining_time = deadline_time<remaining_time? deadline_time: remaining_time;
    11a4:	f6842603          	lw	a2,-152(s0)
    11a8:	f6c42783          	lw	a5,-148(s0)
    11ac:	0007869b          	sext.w	a3,a5
    11b0:	0006071b          	sext.w	a4,a2
    11b4:	00d75363          	bge	a4,a3,11ba <schedule_edf+0x1d6>
    11b8:	87b2                	mv	a5,a2
    11ba:	f6f42623          	sw	a5,-148(s0)
                int met_time = min_th->remaining_time;
    11be:	fb043783          	ld	a5,-80(s0)
    11c2:	47fc                	lw	a5,76(a5)
    11c4:	f6f42223          	sw	a5,-156(s0)
                remaining_time = met_time<remaining_time? met_time: remaining_time;
    11c8:	f6442603          	lw	a2,-156(s0)
    11cc:	f6c42783          	lw	a5,-148(s0)
    11d0:	0007869b          	sext.w	a3,a5
    11d4:	0006071b          	sext.w	a4,a2
    11d8:	00d75363          	bge	a4,a3,11de <schedule_edf+0x1fa>
    11dc:	87b2                	mv	a5,a2
    11de:	f6f42623          	sw	a5,-148(s0)
                r.allocated_time = remaining_time;
    11e2:	f6c42783          	lw	a5,-148(s0)
    11e6:	f2f42823          	sw	a5,-208(s0)
    11ea:	aa8d                	j	135c <schedule_edf+0x378>
            }else{
                // first check if a preemption can happen
                struct release_queue_entry* cur_min = NULL;
    11ec:	f8043c23          	sd	zero,-104(s0)
                int remaining_time = 99999;
    11f0:	67e1                	lui	a5,0x18
    11f2:	69f78793          	addi	a5,a5,1695 # 1869f <__global_pointer$+0x16767>
    11f6:	f8f42a23          	sw	a5,-108(s0)
                list_for_each_entry(cur, args.release_queue, thread_list) {
    11fa:	689c                	ld	a5,16(s1)
    11fc:	639c                	ld	a5,0(a5)
    11fe:	f8f43023          	sd	a5,-128(s0)
    1202:	f8043783          	ld	a5,-128(s0)
    1206:	17e1                	addi	a5,a5,-8
    1208:	faf43023          	sd	a5,-96(s0)
    120c:	a8d9                	j	12e2 <schedule_edf+0x2fe>
                    if((cur->thrd->period + cur->release_time < min_th->current_deadline) && cur->thrd->n != 0){
    120e:	fa043783          	ld	a5,-96(s0)
    1212:	639c                	ld	a5,0(a5)
    1214:	43f8                	lw	a4,68(a5)
    1216:	fa043783          	ld	a5,-96(s0)
    121a:	4f9c                	lw	a5,24(a5)
    121c:	9fb9                	addw	a5,a5,a4
    121e:	0007871b          	sext.w	a4,a5
    1222:	fb043783          	ld	a5,-80(s0)
    1226:	4bbc                	lw	a5,80(a5)
    1228:	0af75363          	bge	a4,a5,12ce <schedule_edf+0x2ea>
    122c:	fa043783          	ld	a5,-96(s0)
    1230:	639c                	ld	a5,0(a5)
    1232:	47bc                	lw	a5,72(a5)
    1234:	cfc9                	beqz	a5,12ce <schedule_edf+0x2ea>
                        // printf("preemption can occur: %d %d %d\n", cur->thrd->period , cur->release_time , min_th->current_deadline);
                        // a preemption can occur
                        if(cur_min == NULL){
    1236:	f9843783          	ld	a5,-104(s0)
    123a:	e791                	bnez	a5,1246 <schedule_edf+0x262>
                            cur_min = cur;
    123c:	fa043783          	ld	a5,-96(s0)
    1240:	f8f43c23          	sd	a5,-104(s0)
    1244:	a069                	j	12ce <schedule_edf+0x2ea>
                        }else{
                            if((cur->thrd->period + cur->release_time < cur_min->thrd->period + cur_min->release_time)&& cur->thrd->n != 0){
    1246:	fa043783          	ld	a5,-96(s0)
    124a:	639c                	ld	a5,0(a5)
    124c:	43f8                	lw	a4,68(a5)
    124e:	fa043783          	ld	a5,-96(s0)
    1252:	4f9c                	lw	a5,24(a5)
    1254:	9fb9                	addw	a5,a5,a4
    1256:	0007869b          	sext.w	a3,a5
    125a:	f9843783          	ld	a5,-104(s0)
    125e:	639c                	ld	a5,0(a5)
    1260:	43f8                	lw	a4,68(a5)
    1262:	f9843783          	ld	a5,-104(s0)
    1266:	4f9c                	lw	a5,24(a5)
    1268:	9fb9                	addw	a5,a5,a4
    126a:	2781                	sext.w	a5,a5
    126c:	8736                	mv	a4,a3
    126e:	00f75c63          	bge	a4,a5,1286 <schedule_edf+0x2a2>
    1272:	fa043783          	ld	a5,-96(s0)
    1276:	639c                	ld	a5,0(a5)
    1278:	47bc                	lw	a5,72(a5)
    127a:	c791                	beqz	a5,1286 <schedule_edf+0x2a2>
                                cur_min = cur;
    127c:	fa043783          	ld	a5,-96(s0)
    1280:	f8f43c23          	sd	a5,-104(s0)
    1284:	a0a9                	j	12ce <schedule_edf+0x2ea>
                            }else if(cur->thrd->period + cur->release_time == cur_min->thrd->period + cur_min->release_time){
    1286:	fa043783          	ld	a5,-96(s0)
    128a:	639c                	ld	a5,0(a5)
    128c:	43f8                	lw	a4,68(a5)
    128e:	fa043783          	ld	a5,-96(s0)
    1292:	4f9c                	lw	a5,24(a5)
    1294:	9fb9                	addw	a5,a5,a4
    1296:	0007869b          	sext.w	a3,a5
    129a:	f9843783          	ld	a5,-104(s0)
    129e:	639c                	ld	a5,0(a5)
    12a0:	43f8                	lw	a4,68(a5)
    12a2:	f9843783          	ld	a5,-104(s0)
    12a6:	4f9c                	lw	a5,24(a5)
    12a8:	9fb9                	addw	a5,a5,a4
    12aa:	2781                	sext.w	a5,a5
    12ac:	8736                	mv	a4,a3
    12ae:	02f71063          	bne	a4,a5,12ce <schedule_edf+0x2ea>
                                if(cur_min->thrd->ID > cur->thrd->ID){
    12b2:	f9843783          	ld	a5,-104(s0)
    12b6:	639c                	ld	a5,0(a5)
    12b8:	5398                	lw	a4,32(a5)
    12ba:	fa043783          	ld	a5,-96(s0)
    12be:	639c                	ld	a5,0(a5)
    12c0:	539c                	lw	a5,32(a5)
    12c2:	00e7d663          	bge	a5,a4,12ce <schedule_edf+0x2ea>
                                    cur_min = cur;
    12c6:	fa043783          	ld	a5,-96(s0)
    12ca:	f8f43c23          	sd	a5,-104(s0)
                list_for_each_entry(cur, args.release_queue, thread_list) {
    12ce:	fa043783          	ld	a5,-96(s0)
    12d2:	679c                	ld	a5,8(a5)
    12d4:	f6f43823          	sd	a5,-144(s0)
    12d8:	f7043783          	ld	a5,-144(s0)
    12dc:	17e1                	addi	a5,a5,-8
    12de:	faf43023          	sd	a5,-96(s0)
    12e2:	fa043783          	ld	a5,-96(s0)
    12e6:	00878713          	addi	a4,a5,8
    12ea:	689c                	ld	a5,16(s1)
    12ec:	f2f711e3          	bne	a4,a5,120e <schedule_edf+0x22a>
                                }
                            }
                        }
                    }
                }
                if(cur_min != NULL){
    12f0:	f9843783          	ld	a5,-104(s0)
    12f4:	cb89                	beqz	a5,1306 <schedule_edf+0x322>
                    // a preemption is possible
                    remaining_time = cur_min->release_time - args.current_time;
    12f6:	f9843783          	ld	a5,-104(s0)
    12fa:	4f98                	lw	a4,24(a5)
    12fc:	409c                	lw	a5,0(s1)
    12fe:	40f707bb          	subw	a5,a4,a5
    1302:	f8f42a23          	sw	a5,-108(s0)
                }
                int deadline_time = min_th->current_deadline - args.current_time;
    1306:	fb043783          	ld	a5,-80(s0)
    130a:	4bb8                	lw	a4,80(a5)
    130c:	409c                	lw	a5,0(s1)
    130e:	40f707bb          	subw	a5,a4,a5
    1312:	f6f42e23          	sw	a5,-132(s0)
                remaining_time = deadline_time<remaining_time? deadline_time: remaining_time;
    1316:	f7c42603          	lw	a2,-132(s0)
    131a:	f9442783          	lw	a5,-108(s0)
    131e:	0007869b          	sext.w	a3,a5
    1322:	0006071b          	sext.w	a4,a2
    1326:	00d75363          	bge	a4,a3,132c <schedule_edf+0x348>
    132a:	87b2                	mv	a5,a2
    132c:	f8f42a23          	sw	a5,-108(s0)
                int met_time = min_th->remaining_time;
    1330:	fb043783          	ld	a5,-80(s0)
    1334:	47fc                	lw	a5,76(a5)
    1336:	f6f42c23          	sw	a5,-136(s0)
                remaining_time = met_time<remaining_time? met_time: remaining_time;
    133a:	f7842603          	lw	a2,-136(s0)
    133e:	f9442783          	lw	a5,-108(s0)
    1342:	0007869b          	sext.w	a3,a5
    1346:	0006071b          	sext.w	a4,a2
    134a:	00d75363          	bge	a4,a3,1350 <schedule_edf+0x36c>
    134e:	87b2                	mv	a5,a2
    1350:	f8f42a23          	sw	a5,-108(s0)
                r.allocated_time = remaining_time;
    1354:	f9442783          	lw	a5,-108(s0)
    1358:	f2f42823          	sw	a5,-208(s0)
            }

            return r;
    135c:	f2843783          	ld	a5,-216(s0)
    1360:	f2f43c23          	sd	a5,-200(s0)
    1364:	f3043783          	ld	a5,-208(s0)
    1368:	f4f43023          	sd	a5,-192(s0)
        }
    }

    return schedule_default(args);
}
    136c:	f3843703          	ld	a4,-200(s0)
    1370:	f4043783          	ld	a5,-192(s0)
    1374:	893a                	mv	s2,a4
    1376:	89be                	mv	s3,a5
    1378:	874a                	mv	a4,s2
    137a:	87ce                	mv	a5,s3
    137c:	853a                	mv	a0,a4
    137e:	85be                	mv	a1,a5
    1380:	60ee                	ld	ra,216(sp)
    1382:	644e                	ld	s0,208(sp)
    1384:	64ae                	ld	s1,200(sp)
    1386:	690e                	ld	s2,192(sp)
    1388:	79ea                	ld	s3,184(sp)
    138a:	612d                	addi	sp,sp,224
    138c:	8082                	ret

000000000000138e <schedule_rm>:

/* Rate-Monotonic Scheduling */
struct threads_sched_result schedule_rm(struct threads_sched_args args)
{
    138e:	7115                	addi	sp,sp,-224
    1390:	ed86                	sd	ra,216(sp)
    1392:	e9a2                	sd	s0,208(sp)
    1394:	e5a6                	sd	s1,200(sp)
    1396:	e1ca                	sd	s2,192(sp)
    1398:	fd4e                	sd	s3,184(sp)
    139a:	1180                	addi	s0,sp,224
    139c:	84aa                	mv	s1,a0
    
    struct threads_sched_result r;
    if(list_empty(args.run_queue)){
    139e:	649c                	ld	a5,8(s1)
    13a0:	853e                	mv	a0,a5
    13a2:	00000097          	auipc	ra,0x0
    13a6:	b58080e7          	jalr	-1192(ra) # efa <list_empty>
    13aa:	87aa                	mv	a5,a0
    13ac:	c3d1                	beqz	a5,1430 <schedule_rm+0xa2>
        // SPEC 3
        r.scheduled_thread_list_member = args.run_queue;
    13ae:	649c                	ld	a5,8(s1)
    13b0:	f2f43423          	sd	a5,-216(s0)
        int least_release_time = 99999;
    13b4:	67e1                	lui	a5,0x18
    13b6:	69f78793          	addi	a5,a5,1695 # 1869f <__global_pointer$+0x16767>
    13ba:	fcf42623          	sw	a5,-52(s0)
        struct release_queue_entry* cur;
        list_for_each_entry(cur, args.release_queue, thread_list) {
    13be:	689c                	ld	a5,16(s1)
    13c0:	639c                	ld	a5,0(a5)
    13c2:	f4f43823          	sd	a5,-176(s0)
    13c6:	f5043783          	ld	a5,-176(s0)
    13ca:	17e1                	addi	a5,a5,-8
    13cc:	fcf43023          	sd	a5,-64(s0)
    13d0:	a805                	j	1400 <schedule_rm+0x72>
            if(cur->release_time<least_release_time){
    13d2:	fc043783          	ld	a5,-64(s0)
    13d6:	4f98                	lw	a4,24(a5)
    13d8:	fcc42783          	lw	a5,-52(s0)
    13dc:	2781                	sext.w	a5,a5
    13de:	00f75763          	bge	a4,a5,13ec <schedule_rm+0x5e>
                least_release_time = cur->release_time;
    13e2:	fc043783          	ld	a5,-64(s0)
    13e6:	4f9c                	lw	a5,24(a5)
    13e8:	fcf42623          	sw	a5,-52(s0)
        list_for_each_entry(cur, args.release_queue, thread_list) {
    13ec:	fc043783          	ld	a5,-64(s0)
    13f0:	679c                	ld	a5,8(a5)
    13f2:	f4f43423          	sd	a5,-184(s0)
    13f6:	f4843783          	ld	a5,-184(s0)
    13fa:	17e1                	addi	a5,a5,-8
    13fc:	fcf43023          	sd	a5,-64(s0)
    1400:	fc043783          	ld	a5,-64(s0)
    1404:	00878713          	addi	a4,a5,8
    1408:	689c                	ld	a5,16(s1)
    140a:	fcf714e3          	bne	a4,a5,13d2 <schedule_rm+0x44>
            }
        }
        r.allocated_time = least_release_time - args.current_time ;
    140e:	409c                	lw	a5,0(s1)
    1410:	fcc42703          	lw	a4,-52(s0)
    1414:	40f707bb          	subw	a5,a4,a5
    1418:	2781                	sext.w	a5,a5
    141a:	f2f42823          	sw	a5,-208(s0)
        return r;
    141e:	f2843783          	ld	a5,-216(s0)
    1422:	f2f43c23          	sd	a5,-200(s0)
    1426:	f3043783          	ld	a5,-208(s0)
    142a:	f4f43023          	sd	a5,-192(s0)
    142e:	ac61                	j	16c6 <schedule_rm+0x338>
    }else{
        // run queue is not empty.
        struct thread *th = NULL;
    1430:	fa043c23          	sd	zero,-72(s0)
        struct thread *min_th = NULL;
    1434:	fa043823          	sd	zero,-80(s0)
        struct thread *min_miss_deadline_th = NULL;
    1438:	fa043423          	sd	zero,-88(s0)
        list_for_each_entry(th, args.run_queue, thread_list) {
    143c:	649c                	ld	a5,8(s1)
    143e:	639c                	ld	a5,0(a5)
    1440:	f8f43423          	sd	a5,-120(s0)
    1444:	f8843783          	ld	a5,-120(s0)
    1448:	fd878793          	addi	a5,a5,-40
    144c:	faf43c23          	sd	a5,-72(s0)
    1450:	a849                	j	14e2 <schedule_rm+0x154>
            if(th->current_deadline <= args.current_time){
    1452:	fb843783          	ld	a5,-72(s0)
    1456:	4bb8                	lw	a4,80(a5)
    1458:	409c                	lw	a5,0(s1)
    145a:	02e7c163          	blt	a5,a4,147c <schedule_rm+0xee>
                if(min_miss_deadline_th == NULL || th->ID<min_miss_deadline_th->ID){
    145e:	fa843783          	ld	a5,-88(s0)
    1462:	cb89                	beqz	a5,1474 <schedule_rm+0xe6>
    1464:	fb843783          	ld	a5,-72(s0)
    1468:	5398                	lw	a4,32(a5)
    146a:	fa843783          	ld	a5,-88(s0)
    146e:	539c                	lw	a5,32(a5)
    1470:	00f75663          	bge	a4,a5,147c <schedule_rm+0xee>
                    min_miss_deadline_th = th;
    1474:	fb843783          	ld	a5,-72(s0)
    1478:	faf43423          	sd	a5,-88(s0)
                }
            }
            if(min_th == NULL) min_th = th;
    147c:	fb043783          	ld	a5,-80(s0)
    1480:	e789                	bnez	a5,148a <schedule_rm+0xfc>
    1482:	fb843783          	ld	a5,-72(s0)
    1486:	faf43823          	sd	a5,-80(s0)
            if(th->period<min_th->period){
    148a:	fb843783          	ld	a5,-72(s0)
    148e:	43f8                	lw	a4,68(a5)
    1490:	fb043783          	ld	a5,-80(s0)
    1494:	43fc                	lw	a5,68(a5)
    1496:	00f75763          	bge	a4,a5,14a4 <schedule_rm+0x116>
                min_th = th;
    149a:	fb843783          	ld	a5,-72(s0)
    149e:	faf43823          	sd	a5,-80(s0)
    14a2:	a02d                	j	14cc <schedule_rm+0x13e>
            }else if(th->period == min_th->period){
    14a4:	fb843783          	ld	a5,-72(s0)
    14a8:	43f8                	lw	a4,68(a5)
    14aa:	fb043783          	ld	a5,-80(s0)
    14ae:	43fc                	lw	a5,68(a5)
    14b0:	00f71e63          	bne	a4,a5,14cc <schedule_rm+0x13e>
                if(th->ID<min_th->ID) min_th = th;
    14b4:	fb843783          	ld	a5,-72(s0)
    14b8:	5398                	lw	a4,32(a5)
    14ba:	fb043783          	ld	a5,-80(s0)
    14be:	539c                	lw	a5,32(a5)
    14c0:	00f75663          	bge	a4,a5,14cc <schedule_rm+0x13e>
    14c4:	fb843783          	ld	a5,-72(s0)
    14c8:	faf43823          	sd	a5,-80(s0)
        list_for_each_entry(th, args.run_queue, thread_list) {
    14cc:	fb843783          	ld	a5,-72(s0)
    14d0:	779c                	ld	a5,40(a5)
    14d2:	f4f43c23          	sd	a5,-168(s0)
    14d6:	f5843783          	ld	a5,-168(s0)
    14da:	fd878793          	addi	a5,a5,-40
    14de:	faf43c23          	sd	a5,-72(s0)
    14e2:	fb843783          	ld	a5,-72(s0)
    14e6:	02878713          	addi	a4,a5,40
    14ea:	649c                	ld	a5,8(s1)
    14ec:	f6f713e3          	bne	a4,a5,1452 <schedule_rm+0xc4>
            }
        }

        if(min_miss_deadline_th != NULL) {
    14f0:	fa843783          	ld	a5,-88(s0)
    14f4:	c395                	beqz	a5,1518 <schedule_rm+0x18a>
            // SPEC 4: exist missed deadline
            r.allocated_time = 0;
    14f6:	f2042823          	sw	zero,-208(s0)
            r.scheduled_thread_list_member = &min_miss_deadline_th->thread_list;
    14fa:	fa843783          	ld	a5,-88(s0)
    14fe:	02878793          	addi	a5,a5,40
    1502:	f2f43423          	sd	a5,-216(s0)
            return r;
    1506:	f2843783          	ld	a5,-216(s0)
    150a:	f2f43c23          	sd	a5,-200(s0)
    150e:	f3043783          	ld	a5,-208(s0)
    1512:	f4f43023          	sd	a5,-192(s0)
    1516:	aa45                	j	16c6 <schedule_rm+0x338>
             // compute allocated time: 
            // 1. a preemption can happen in the future.(need to inspect the release queue)
            // 2. current deadline is met (preemption has not happened)
            // 3. current deadline is missed (current_time + remaining_time > current_deadline)
            // compute the first event that will happen.
            r.scheduled_thread_list_member = &min_th->thread_list;
    1518:	fb043783          	ld	a5,-80(s0)
    151c:	02878793          	addi	a5,a5,40
    1520:	f2f43423          	sd	a5,-216(s0)

            struct release_queue_entry* cur;
            if(list_empty(args.release_queue)){
    1524:	689c                	ld	a5,16(s1)
    1526:	853e                	mv	a0,a5
    1528:	00000097          	auipc	ra,0x0
    152c:	9d2080e7          	jalr	-1582(ra) # efa <list_empty>
    1530:	87aa                	mv	a5,a0
    1532:	c3b5                	beqz	a5,1596 <schedule_rm+0x208>
                // a preemption cannot happen, because we've already selected the highest priority thread.
                int remaining_time = 99999;
    1534:	67e1                	lui	a5,0x18
    1536:	69f78793          	addi	a5,a5,1695 # 1869f <__global_pointer$+0x16767>
    153a:	f6f42623          	sw	a5,-148(s0)

                int deadline_time = min_th->current_deadline - args.current_time;
    153e:	fb043783          	ld	a5,-80(s0)
    1542:	4bb8                	lw	a4,80(a5)
    1544:	409c                	lw	a5,0(s1)
    1546:	40f707bb          	subw	a5,a4,a5
    154a:	f6f42423          	sw	a5,-152(s0)
                remaining_time = deadline_time<remaining_time? deadline_time: remaining_time;
    154e:	f6842603          	lw	a2,-152(s0)
    1552:	f6c42783          	lw	a5,-148(s0)
    1556:	0007869b          	sext.w	a3,a5
    155a:	0006071b          	sext.w	a4,a2
    155e:	00d75363          	bge	a4,a3,1564 <schedule_rm+0x1d6>
    1562:	87b2                	mv	a5,a2
    1564:	f6f42623          	sw	a5,-148(s0)
                int met_time = min_th->remaining_time;
    1568:	fb043783          	ld	a5,-80(s0)
    156c:	47fc                	lw	a5,76(a5)
    156e:	f6f42223          	sw	a5,-156(s0)
                remaining_time = met_time<remaining_time? met_time: remaining_time;
    1572:	f6442603          	lw	a2,-156(s0)
    1576:	f6c42783          	lw	a5,-148(s0)
    157a:	0007869b          	sext.w	a3,a5
    157e:	0006071b          	sext.w	a4,a2
    1582:	00d75363          	bge	a4,a3,1588 <schedule_rm+0x1fa>
    1586:	87b2                	mv	a5,a2
    1588:	f6f42623          	sw	a5,-148(s0)
                
                r.allocated_time = remaining_time;
    158c:	f6c42783          	lw	a5,-148(s0)
    1590:	f2f42823          	sw	a5,-208(s0)
    1594:	a20d                	j	16b6 <schedule_rm+0x328>
            }else{
                // first check if a preemption can happen
                struct release_queue_entry* cur_min = NULL;
    1596:	f8043c23          	sd	zero,-104(s0)
                int remaining_time = 99999;
    159a:	67e1                	lui	a5,0x18
    159c:	69f78793          	addi	a5,a5,1695 # 1869f <__global_pointer$+0x16767>
    15a0:	f8f42a23          	sw	a5,-108(s0)
                list_for_each_entry(cur, args.release_queue, thread_list) {
    15a4:	689c                	ld	a5,16(s1)
    15a6:	639c                	ld	a5,0(a5)
    15a8:	f8f43023          	sd	a5,-128(s0)
    15ac:	f8043783          	ld	a5,-128(s0)
    15b0:	17e1                	addi	a5,a5,-8
    15b2:	faf43023          	sd	a5,-96(s0)
    15b6:	a059                	j	163c <schedule_rm+0x2ae>
                    if(cur->thrd->period<min_th->period){
    15b8:	fa043783          	ld	a5,-96(s0)
    15bc:	639c                	ld	a5,0(a5)
    15be:	43f8                	lw	a4,68(a5)
    15c0:	fb043783          	ld	a5,-80(s0)
    15c4:	43fc                	lw	a5,68(a5)
    15c6:	06f75163          	bge	a4,a5,1628 <schedule_rm+0x29a>
                        // a preemption can occur
                        if(cur_min == NULL){
    15ca:	f9843783          	ld	a5,-104(s0)
    15ce:	e791                	bnez	a5,15da <schedule_rm+0x24c>
                            cur_min = cur;
    15d0:	fa043783          	ld	a5,-96(s0)
    15d4:	f8f43c23          	sd	a5,-104(s0)
    15d8:	a881                	j	1628 <schedule_rm+0x29a>
                        }else{
                            if(cur_min->thrd->period>cur->thrd->period){
    15da:	f9843783          	ld	a5,-104(s0)
    15de:	639c                	ld	a5,0(a5)
    15e0:	43f8                	lw	a4,68(a5)
    15e2:	fa043783          	ld	a5,-96(s0)
    15e6:	639c                	ld	a5,0(a5)
    15e8:	43fc                	lw	a5,68(a5)
    15ea:	00e7d763          	bge	a5,a4,15f8 <schedule_rm+0x26a>
                                cur_min = cur;
    15ee:	fa043783          	ld	a5,-96(s0)
    15f2:	f8f43c23          	sd	a5,-104(s0)
    15f6:	a80d                	j	1628 <schedule_rm+0x29a>
                            }else if(cur_min->thrd->period == cur->thrd->period){
    15f8:	f9843783          	ld	a5,-104(s0)
    15fc:	639c                	ld	a5,0(a5)
    15fe:	43f8                	lw	a4,68(a5)
    1600:	fa043783          	ld	a5,-96(s0)
    1604:	639c                	ld	a5,0(a5)
    1606:	43fc                	lw	a5,68(a5)
    1608:	02f71063          	bne	a4,a5,1628 <schedule_rm+0x29a>
                                if(cur_min->thrd->ID > cur->thrd->ID){
    160c:	f9843783          	ld	a5,-104(s0)
    1610:	639c                	ld	a5,0(a5)
    1612:	5398                	lw	a4,32(a5)
    1614:	fa043783          	ld	a5,-96(s0)
    1618:	639c                	ld	a5,0(a5)
    161a:	539c                	lw	a5,32(a5)
    161c:	00e7d663          	bge	a5,a4,1628 <schedule_rm+0x29a>
                                    cur_min = cur;
    1620:	fa043783          	ld	a5,-96(s0)
    1624:	f8f43c23          	sd	a5,-104(s0)
                list_for_each_entry(cur, args.release_queue, thread_list) {
    1628:	fa043783          	ld	a5,-96(s0)
    162c:	679c                	ld	a5,8(a5)
    162e:	f6f43823          	sd	a5,-144(s0)
    1632:	f7043783          	ld	a5,-144(s0)
    1636:	17e1                	addi	a5,a5,-8
    1638:	faf43023          	sd	a5,-96(s0)
    163c:	fa043783          	ld	a5,-96(s0)
    1640:	00878713          	addi	a4,a5,8
    1644:	689c                	ld	a5,16(s1)
    1646:	f6f719e3          	bne	a4,a5,15b8 <schedule_rm+0x22a>
                                }
                            }
                        }
                    }
                }
                if(cur_min != NULL){
    164a:	f9843783          	ld	a5,-104(s0)
    164e:	cb89                	beqz	a5,1660 <schedule_rm+0x2d2>
                    // a preemption is possible
                    remaining_time = cur_min->release_time - args.current_time;
    1650:	f9843783          	ld	a5,-104(s0)
    1654:	4f98                	lw	a4,24(a5)
    1656:	409c                	lw	a5,0(s1)
    1658:	40f707bb          	subw	a5,a4,a5
    165c:	f8f42a23          	sw	a5,-108(s0)
                }
                int deadline_time = min_th->current_deadline - args.current_time;
    1660:	fb043783          	ld	a5,-80(s0)
    1664:	4bb8                	lw	a4,80(a5)
    1666:	409c                	lw	a5,0(s1)
    1668:	40f707bb          	subw	a5,a4,a5
    166c:	f6f42e23          	sw	a5,-132(s0)
                remaining_time = deadline_time<remaining_time? deadline_time: remaining_time;
    1670:	f7c42603          	lw	a2,-132(s0)
    1674:	f9442783          	lw	a5,-108(s0)
    1678:	0007869b          	sext.w	a3,a5
    167c:	0006071b          	sext.w	a4,a2
    1680:	00d75363          	bge	a4,a3,1686 <schedule_rm+0x2f8>
    1684:	87b2                	mv	a5,a2
    1686:	f8f42a23          	sw	a5,-108(s0)
                int met_time = min_th->remaining_time;
    168a:	fb043783          	ld	a5,-80(s0)
    168e:	47fc                	lw	a5,76(a5)
    1690:	f6f42c23          	sw	a5,-136(s0)
                remaining_time = met_time<remaining_time? met_time: remaining_time;
    1694:	f7842603          	lw	a2,-136(s0)
    1698:	f9442783          	lw	a5,-108(s0)
    169c:	0007869b          	sext.w	a3,a5
    16a0:	0006071b          	sext.w	a4,a2
    16a4:	00d75363          	bge	a4,a3,16aa <schedule_rm+0x31c>
    16a8:	87b2                	mv	a5,a2
    16aa:	f8f42a23          	sw	a5,-108(s0)
                
                r.allocated_time = remaining_time;
    16ae:	f9442783          	lw	a5,-108(s0)
    16b2:	f2f42823          	sw	a5,-208(s0)
            }

            return r;
    16b6:	f2843783          	ld	a5,-216(s0)
    16ba:	f2f43c23          	sd	a5,-200(s0)
    16be:	f3043783          	ld	a5,-208(s0)
    16c2:	f4f43023          	sd	a5,-192(s0)
        }
    }
}
    16c6:	f3843703          	ld	a4,-200(s0)
    16ca:	f4043783          	ld	a5,-192(s0)
    16ce:	893a                	mv	s2,a4
    16d0:	89be                	mv	s3,a5
    16d2:	874a                	mv	a4,s2
    16d4:	87ce                	mv	a5,s3
    16d6:	853a                	mv	a0,a4
    16d8:	85be                	mv	a1,a5
    16da:	60ee                	ld	ra,216(sp)
    16dc:	644e                	ld	s0,208(sp)
    16de:	64ae                	ld	s1,200(sp)
    16e0:	690e                	ld	s2,192(sp)
    16e2:	79ea                	ld	s3,184(sp)
    16e4:	612d                	addi	sp,sp,224
    16e6:	8082                	ret
