
user/_wc:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <wc>:

char buf[512];

void
wc(int fd, char *name)
{
       0:	7139                	addi	sp,sp,-64
       2:	fc06                	sd	ra,56(sp)
       4:	f822                	sd	s0,48(sp)
       6:	0080                	addi	s0,sp,64
       8:	87aa                	mv	a5,a0
       a:	fcb43023          	sd	a1,-64(s0)
       e:	fcf42623          	sw	a5,-52(s0)
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
      12:	fe042023          	sw	zero,-32(s0)
      16:	fe042783          	lw	a5,-32(s0)
      1a:	fef42223          	sw	a5,-28(s0)
      1e:	fe442783          	lw	a5,-28(s0)
      22:	fef42423          	sw	a5,-24(s0)
  inword = 0;
      26:	fc042e23          	sw	zero,-36(s0)
  while((n = read(fd, buf, sizeof(buf))) > 0){
      2a:	a859                	j	c0 <wc+0xc0>
    for(i=0; i<n; i++){
      2c:	fe042623          	sw	zero,-20(s0)
      30:	a041                	j	b0 <wc+0xb0>
      c++;
      32:	fe042783          	lw	a5,-32(s0)
      36:	2785                	addiw	a5,a5,1
      38:	fef42023          	sw	a5,-32(s0)
      if(buf[i] == '\n')
      3c:	00001717          	auipc	a4,0x1
      40:	7bc70713          	addi	a4,a4,1980 # 17f8 <buf>
      44:	fec42783          	lw	a5,-20(s0)
      48:	97ba                	add	a5,a5,a4
      4a:	0007c783          	lbu	a5,0(a5)
      4e:	873e                	mv	a4,a5
      50:	47a9                	li	a5,10
      52:	00f71763          	bne	a4,a5,60 <wc+0x60>
        l++;
      56:	fe842783          	lw	a5,-24(s0)
      5a:	2785                	addiw	a5,a5,1
      5c:	fef42423          	sw	a5,-24(s0)
      if(strchr(" \r\t\n\v", buf[i]))
      60:	00001717          	auipc	a4,0x1
      64:	79870713          	addi	a4,a4,1944 # 17f8 <buf>
      68:	fec42783          	lw	a5,-20(s0)
      6c:	97ba                	add	a5,a5,a4
      6e:	0007c783          	lbu	a5,0(a5)
      72:	85be                	mv	a1,a5
      74:	00001517          	auipc	a0,0x1
      78:	71c50513          	addi	a0,a0,1820 # 1790 <schedule_rm+0x35e>
      7c:	00000097          	auipc	ra,0x0
      80:	2ec080e7          	jalr	748(ra) # 368 <strchr>
      84:	87aa                	mv	a5,a0
      86:	c781                	beqz	a5,8e <wc+0x8e>
        inword = 0;
      88:	fc042e23          	sw	zero,-36(s0)
      8c:	a829                	j	a6 <wc+0xa6>
      else if(!inword){
      8e:	fdc42783          	lw	a5,-36(s0)
      92:	2781                	sext.w	a5,a5
      94:	eb89                	bnez	a5,a6 <wc+0xa6>
        w++;
      96:	fe442783          	lw	a5,-28(s0)
      9a:	2785                	addiw	a5,a5,1
      9c:	fef42223          	sw	a5,-28(s0)
        inword = 1;
      a0:	4785                	li	a5,1
      a2:	fcf42e23          	sw	a5,-36(s0)
    for(i=0; i<n; i++){
      a6:	fec42783          	lw	a5,-20(s0)
      aa:	2785                	addiw	a5,a5,1
      ac:	fef42623          	sw	a5,-20(s0)
      b0:	fec42703          	lw	a4,-20(s0)
      b4:	fd842783          	lw	a5,-40(s0)
      b8:	2701                	sext.w	a4,a4
      ba:	2781                	sext.w	a5,a5
      bc:	f6f74be3          	blt	a4,a5,32 <wc+0x32>
  while((n = read(fd, buf, sizeof(buf))) > 0){
      c0:	fcc42783          	lw	a5,-52(s0)
      c4:	20000613          	li	a2,512
      c8:	00001597          	auipc	a1,0x1
      cc:	73058593          	addi	a1,a1,1840 # 17f8 <buf>
      d0:	853e                	mv	a0,a5
      d2:	00000097          	auipc	ra,0x0
      d6:	5f8080e7          	jalr	1528(ra) # 6ca <read>
      da:	87aa                	mv	a5,a0
      dc:	fcf42c23          	sw	a5,-40(s0)
      e0:	fd842783          	lw	a5,-40(s0)
      e4:	2781                	sext.w	a5,a5
      e6:	f4f043e3          	bgtz	a5,2c <wc+0x2c>
      }
    }
  }
  if(n < 0){
      ea:	fd842783          	lw	a5,-40(s0)
      ee:	2781                	sext.w	a5,a5
      f0:	0007df63          	bgez	a5,10e <wc+0x10e>
    printf("wc: read error\n");
      f4:	00001517          	auipc	a0,0x1
      f8:	6a450513          	addi	a0,a0,1700 # 1798 <schedule_rm+0x366>
      fc:	00001097          	auipc	ra,0x1
     100:	afc080e7          	jalr	-1284(ra) # bf8 <printf>
    exit(1);
     104:	4505                	li	a0,1
     106:	00000097          	auipc	ra,0x0
     10a:	5ac080e7          	jalr	1452(ra) # 6b2 <exit>
  }
  printf("%d %d %d %s\n", l, w, c, name);
     10e:	fe042683          	lw	a3,-32(s0)
     112:	fe442603          	lw	a2,-28(s0)
     116:	fe842783          	lw	a5,-24(s0)
     11a:	fc043703          	ld	a4,-64(s0)
     11e:	85be                	mv	a1,a5
     120:	00001517          	auipc	a0,0x1
     124:	68850513          	addi	a0,a0,1672 # 17a8 <schedule_rm+0x376>
     128:	00001097          	auipc	ra,0x1
     12c:	ad0080e7          	jalr	-1328(ra) # bf8 <printf>
}
     130:	0001                	nop
     132:	70e2                	ld	ra,56(sp)
     134:	7442                	ld	s0,48(sp)
     136:	6121                	addi	sp,sp,64
     138:	8082                	ret

000000000000013a <main>:

int
main(int argc, char *argv[])
{
     13a:	7179                	addi	sp,sp,-48
     13c:	f406                	sd	ra,40(sp)
     13e:	f022                	sd	s0,32(sp)
     140:	1800                	addi	s0,sp,48
     142:	87aa                	mv	a5,a0
     144:	fcb43823          	sd	a1,-48(s0)
     148:	fcf42e23          	sw	a5,-36(s0)
  int fd, i;

  if(argc <= 1){
     14c:	fdc42783          	lw	a5,-36(s0)
     150:	0007871b          	sext.w	a4,a5
     154:	4785                	li	a5,1
     156:	02e7c063          	blt	a5,a4,176 <main+0x3c>
    wc(0, "");
     15a:	00001597          	auipc	a1,0x1
     15e:	65e58593          	addi	a1,a1,1630 # 17b8 <schedule_rm+0x386>
     162:	4501                	li	a0,0
     164:	00000097          	auipc	ra,0x0
     168:	e9c080e7          	jalr	-356(ra) # 0 <wc>
    exit(0);
     16c:	4501                	li	a0,0
     16e:	00000097          	auipc	ra,0x0
     172:	544080e7          	jalr	1348(ra) # 6b2 <exit>
  }

  for(i = 1; i < argc; i++){
     176:	4785                	li	a5,1
     178:	fef42623          	sw	a5,-20(s0)
     17c:	a071                	j	208 <main+0xce>
    if((fd = open(argv[i], 0)) < 0){
     17e:	fec42783          	lw	a5,-20(s0)
     182:	078e                	slli	a5,a5,0x3
     184:	fd043703          	ld	a4,-48(s0)
     188:	97ba                	add	a5,a5,a4
     18a:	639c                	ld	a5,0(a5)
     18c:	4581                	li	a1,0
     18e:	853e                	mv	a0,a5
     190:	00000097          	auipc	ra,0x0
     194:	562080e7          	jalr	1378(ra) # 6f2 <open>
     198:	87aa                	mv	a5,a0
     19a:	fef42423          	sw	a5,-24(s0)
     19e:	fe842783          	lw	a5,-24(s0)
     1a2:	2781                	sext.w	a5,a5
     1a4:	0207d763          	bgez	a5,1d2 <main+0x98>
      printf("wc: cannot open %s\n", argv[i]);
     1a8:	fec42783          	lw	a5,-20(s0)
     1ac:	078e                	slli	a5,a5,0x3
     1ae:	fd043703          	ld	a4,-48(s0)
     1b2:	97ba                	add	a5,a5,a4
     1b4:	639c                	ld	a5,0(a5)
     1b6:	85be                	mv	a1,a5
     1b8:	00001517          	auipc	a0,0x1
     1bc:	60850513          	addi	a0,a0,1544 # 17c0 <schedule_rm+0x38e>
     1c0:	00001097          	auipc	ra,0x1
     1c4:	a38080e7          	jalr	-1480(ra) # bf8 <printf>
      exit(1);
     1c8:	4505                	li	a0,1
     1ca:	00000097          	auipc	ra,0x0
     1ce:	4e8080e7          	jalr	1256(ra) # 6b2 <exit>
    }
    wc(fd, argv[i]);
     1d2:	fec42783          	lw	a5,-20(s0)
     1d6:	078e                	slli	a5,a5,0x3
     1d8:	fd043703          	ld	a4,-48(s0)
     1dc:	97ba                	add	a5,a5,a4
     1de:	6398                	ld	a4,0(a5)
     1e0:	fe842783          	lw	a5,-24(s0)
     1e4:	85ba                	mv	a1,a4
     1e6:	853e                	mv	a0,a5
     1e8:	00000097          	auipc	ra,0x0
     1ec:	e18080e7          	jalr	-488(ra) # 0 <wc>
    close(fd);
     1f0:	fe842783          	lw	a5,-24(s0)
     1f4:	853e                	mv	a0,a5
     1f6:	00000097          	auipc	ra,0x0
     1fa:	4e4080e7          	jalr	1252(ra) # 6da <close>
  for(i = 1; i < argc; i++){
     1fe:	fec42783          	lw	a5,-20(s0)
     202:	2785                	addiw	a5,a5,1
     204:	fef42623          	sw	a5,-20(s0)
     208:	fec42703          	lw	a4,-20(s0)
     20c:	fdc42783          	lw	a5,-36(s0)
     210:	2701                	sext.w	a4,a4
     212:	2781                	sext.w	a5,a5
     214:	f6f745e3          	blt	a4,a5,17e <main+0x44>
  }
  exit(0);
     218:	4501                	li	a0,0
     21a:	00000097          	auipc	ra,0x0
     21e:	498080e7          	jalr	1176(ra) # 6b2 <exit>

0000000000000222 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
     222:	7179                	addi	sp,sp,-48
     224:	f422                	sd	s0,40(sp)
     226:	1800                	addi	s0,sp,48
     228:	fca43c23          	sd	a0,-40(s0)
     22c:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
     230:	fd843783          	ld	a5,-40(s0)
     234:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
     238:	0001                	nop
     23a:	fd043703          	ld	a4,-48(s0)
     23e:	00170793          	addi	a5,a4,1
     242:	fcf43823          	sd	a5,-48(s0)
     246:	fd843783          	ld	a5,-40(s0)
     24a:	00178693          	addi	a3,a5,1
     24e:	fcd43c23          	sd	a3,-40(s0)
     252:	00074703          	lbu	a4,0(a4)
     256:	00e78023          	sb	a4,0(a5)
     25a:	0007c783          	lbu	a5,0(a5)
     25e:	fff1                	bnez	a5,23a <strcpy+0x18>
    ;
  return os;
     260:	fe843783          	ld	a5,-24(s0)
}
     264:	853e                	mv	a0,a5
     266:	7422                	ld	s0,40(sp)
     268:	6145                	addi	sp,sp,48
     26a:	8082                	ret

000000000000026c <strcmp>:

int
strcmp(const char *p, const char *q)
{
     26c:	1101                	addi	sp,sp,-32
     26e:	ec22                	sd	s0,24(sp)
     270:	1000                	addi	s0,sp,32
     272:	fea43423          	sd	a0,-24(s0)
     276:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
     27a:	a819                	j	290 <strcmp+0x24>
    p++, q++;
     27c:	fe843783          	ld	a5,-24(s0)
     280:	0785                	addi	a5,a5,1
     282:	fef43423          	sd	a5,-24(s0)
     286:	fe043783          	ld	a5,-32(s0)
     28a:	0785                	addi	a5,a5,1
     28c:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
     290:	fe843783          	ld	a5,-24(s0)
     294:	0007c783          	lbu	a5,0(a5)
     298:	cb99                	beqz	a5,2ae <strcmp+0x42>
     29a:	fe843783          	ld	a5,-24(s0)
     29e:	0007c703          	lbu	a4,0(a5)
     2a2:	fe043783          	ld	a5,-32(s0)
     2a6:	0007c783          	lbu	a5,0(a5)
     2aa:	fcf709e3          	beq	a4,a5,27c <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
     2ae:	fe843783          	ld	a5,-24(s0)
     2b2:	0007c783          	lbu	a5,0(a5)
     2b6:	0007871b          	sext.w	a4,a5
     2ba:	fe043783          	ld	a5,-32(s0)
     2be:	0007c783          	lbu	a5,0(a5)
     2c2:	2781                	sext.w	a5,a5
     2c4:	40f707bb          	subw	a5,a4,a5
     2c8:	2781                	sext.w	a5,a5
}
     2ca:	853e                	mv	a0,a5
     2cc:	6462                	ld	s0,24(sp)
     2ce:	6105                	addi	sp,sp,32
     2d0:	8082                	ret

00000000000002d2 <strlen>:

uint
strlen(const char *s)
{
     2d2:	7179                	addi	sp,sp,-48
     2d4:	f422                	sd	s0,40(sp)
     2d6:	1800                	addi	s0,sp,48
     2d8:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
     2dc:	fe042623          	sw	zero,-20(s0)
     2e0:	a031                	j	2ec <strlen+0x1a>
     2e2:	fec42783          	lw	a5,-20(s0)
     2e6:	2785                	addiw	a5,a5,1
     2e8:	fef42623          	sw	a5,-20(s0)
     2ec:	fec42783          	lw	a5,-20(s0)
     2f0:	fd843703          	ld	a4,-40(s0)
     2f4:	97ba                	add	a5,a5,a4
     2f6:	0007c783          	lbu	a5,0(a5)
     2fa:	f7e5                	bnez	a5,2e2 <strlen+0x10>
    ;
  return n;
     2fc:	fec42783          	lw	a5,-20(s0)
}
     300:	853e                	mv	a0,a5
     302:	7422                	ld	s0,40(sp)
     304:	6145                	addi	sp,sp,48
     306:	8082                	ret

0000000000000308 <memset>:

void*
memset(void *dst, int c, uint n)
{
     308:	7179                	addi	sp,sp,-48
     30a:	f422                	sd	s0,40(sp)
     30c:	1800                	addi	s0,sp,48
     30e:	fca43c23          	sd	a0,-40(s0)
     312:	87ae                	mv	a5,a1
     314:	8732                	mv	a4,a2
     316:	fcf42a23          	sw	a5,-44(s0)
     31a:	87ba                	mv	a5,a4
     31c:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
     320:	fd843783          	ld	a5,-40(s0)
     324:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
     328:	fe042623          	sw	zero,-20(s0)
     32c:	a00d                	j	34e <memset+0x46>
    cdst[i] = c;
     32e:	fec42783          	lw	a5,-20(s0)
     332:	fe043703          	ld	a4,-32(s0)
     336:	97ba                	add	a5,a5,a4
     338:	fd442703          	lw	a4,-44(s0)
     33c:	0ff77713          	andi	a4,a4,255
     340:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
     344:	fec42783          	lw	a5,-20(s0)
     348:	2785                	addiw	a5,a5,1
     34a:	fef42623          	sw	a5,-20(s0)
     34e:	fec42703          	lw	a4,-20(s0)
     352:	fd042783          	lw	a5,-48(s0)
     356:	2781                	sext.w	a5,a5
     358:	fcf76be3          	bltu	a4,a5,32e <memset+0x26>
  }
  return dst;
     35c:	fd843783          	ld	a5,-40(s0)
}
     360:	853e                	mv	a0,a5
     362:	7422                	ld	s0,40(sp)
     364:	6145                	addi	sp,sp,48
     366:	8082                	ret

0000000000000368 <strchr>:

char*
strchr(const char *s, char c)
{
     368:	1101                	addi	sp,sp,-32
     36a:	ec22                	sd	s0,24(sp)
     36c:	1000                	addi	s0,sp,32
     36e:	fea43423          	sd	a0,-24(s0)
     372:	87ae                	mv	a5,a1
     374:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
     378:	a01d                	j	39e <strchr+0x36>
    if(*s == c)
     37a:	fe843783          	ld	a5,-24(s0)
     37e:	0007c703          	lbu	a4,0(a5)
     382:	fe744783          	lbu	a5,-25(s0)
     386:	0ff7f793          	andi	a5,a5,255
     38a:	00e79563          	bne	a5,a4,394 <strchr+0x2c>
      return (char*)s;
     38e:	fe843783          	ld	a5,-24(s0)
     392:	a821                	j	3aa <strchr+0x42>
  for(; *s; s++)
     394:	fe843783          	ld	a5,-24(s0)
     398:	0785                	addi	a5,a5,1
     39a:	fef43423          	sd	a5,-24(s0)
     39e:	fe843783          	ld	a5,-24(s0)
     3a2:	0007c783          	lbu	a5,0(a5)
     3a6:	fbf1                	bnez	a5,37a <strchr+0x12>
  return 0;
     3a8:	4781                	li	a5,0
}
     3aa:	853e                	mv	a0,a5
     3ac:	6462                	ld	s0,24(sp)
     3ae:	6105                	addi	sp,sp,32
     3b0:	8082                	ret

00000000000003b2 <gets>:

char*
gets(char *buf, int max)
{
     3b2:	7179                	addi	sp,sp,-48
     3b4:	f406                	sd	ra,40(sp)
     3b6:	f022                	sd	s0,32(sp)
     3b8:	1800                	addi	s0,sp,48
     3ba:	fca43c23          	sd	a0,-40(s0)
     3be:	87ae                	mv	a5,a1
     3c0:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     3c4:	fe042623          	sw	zero,-20(s0)
     3c8:	a8a1                	j	420 <gets+0x6e>
    cc = read(0, &c, 1);
     3ca:	fe740793          	addi	a5,s0,-25
     3ce:	4605                	li	a2,1
     3d0:	85be                	mv	a1,a5
     3d2:	4501                	li	a0,0
     3d4:	00000097          	auipc	ra,0x0
     3d8:	2f6080e7          	jalr	758(ra) # 6ca <read>
     3dc:	87aa                	mv	a5,a0
     3de:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
     3e2:	fe842783          	lw	a5,-24(s0)
     3e6:	2781                	sext.w	a5,a5
     3e8:	04f05763          	blez	a5,436 <gets+0x84>
      break;
    buf[i++] = c;
     3ec:	fec42783          	lw	a5,-20(s0)
     3f0:	0017871b          	addiw	a4,a5,1
     3f4:	fee42623          	sw	a4,-20(s0)
     3f8:	873e                	mv	a4,a5
     3fa:	fd843783          	ld	a5,-40(s0)
     3fe:	97ba                	add	a5,a5,a4
     400:	fe744703          	lbu	a4,-25(s0)
     404:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
     408:	fe744783          	lbu	a5,-25(s0)
     40c:	873e                	mv	a4,a5
     40e:	47a9                	li	a5,10
     410:	02f70463          	beq	a4,a5,438 <gets+0x86>
     414:	fe744783          	lbu	a5,-25(s0)
     418:	873e                	mv	a4,a5
     41a:	47b5                	li	a5,13
     41c:	00f70e63          	beq	a4,a5,438 <gets+0x86>
  for(i=0; i+1 < max; ){
     420:	fec42783          	lw	a5,-20(s0)
     424:	2785                	addiw	a5,a5,1
     426:	0007871b          	sext.w	a4,a5
     42a:	fd442783          	lw	a5,-44(s0)
     42e:	2781                	sext.w	a5,a5
     430:	f8f74de3          	blt	a4,a5,3ca <gets+0x18>
     434:	a011                	j	438 <gets+0x86>
      break;
     436:	0001                	nop
      break;
  }
  buf[i] = '\0';
     438:	fec42783          	lw	a5,-20(s0)
     43c:	fd843703          	ld	a4,-40(s0)
     440:	97ba                	add	a5,a5,a4
     442:	00078023          	sb	zero,0(a5)
  return buf;
     446:	fd843783          	ld	a5,-40(s0)
}
     44a:	853e                	mv	a0,a5
     44c:	70a2                	ld	ra,40(sp)
     44e:	7402                	ld	s0,32(sp)
     450:	6145                	addi	sp,sp,48
     452:	8082                	ret

0000000000000454 <stat>:

int
stat(const char *n, struct stat *st)
{
     454:	7179                	addi	sp,sp,-48
     456:	f406                	sd	ra,40(sp)
     458:	f022                	sd	s0,32(sp)
     45a:	1800                	addi	s0,sp,48
     45c:	fca43c23          	sd	a0,-40(s0)
     460:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     464:	4581                	li	a1,0
     466:	fd843503          	ld	a0,-40(s0)
     46a:	00000097          	auipc	ra,0x0
     46e:	288080e7          	jalr	648(ra) # 6f2 <open>
     472:	87aa                	mv	a5,a0
     474:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
     478:	fec42783          	lw	a5,-20(s0)
     47c:	2781                	sext.w	a5,a5
     47e:	0007d463          	bgez	a5,486 <stat+0x32>
    return -1;
     482:	57fd                	li	a5,-1
     484:	a035                	j	4b0 <stat+0x5c>
  r = fstat(fd, st);
     486:	fec42783          	lw	a5,-20(s0)
     48a:	fd043583          	ld	a1,-48(s0)
     48e:	853e                	mv	a0,a5
     490:	00000097          	auipc	ra,0x0
     494:	27a080e7          	jalr	634(ra) # 70a <fstat>
     498:	87aa                	mv	a5,a0
     49a:	fef42423          	sw	a5,-24(s0)
  close(fd);
     49e:	fec42783          	lw	a5,-20(s0)
     4a2:	853e                	mv	a0,a5
     4a4:	00000097          	auipc	ra,0x0
     4a8:	236080e7          	jalr	566(ra) # 6da <close>
  return r;
     4ac:	fe842783          	lw	a5,-24(s0)
}
     4b0:	853e                	mv	a0,a5
     4b2:	70a2                	ld	ra,40(sp)
     4b4:	7402                	ld	s0,32(sp)
     4b6:	6145                	addi	sp,sp,48
     4b8:	8082                	ret

00000000000004ba <atoi>:

int
atoi(const char *s)
{
     4ba:	7179                	addi	sp,sp,-48
     4bc:	f422                	sd	s0,40(sp)
     4be:	1800                	addi	s0,sp,48
     4c0:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
     4c4:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
     4c8:	a815                	j	4fc <atoi+0x42>
    n = n*10 + *s++ - '0';
     4ca:	fec42703          	lw	a4,-20(s0)
     4ce:	87ba                	mv	a5,a4
     4d0:	0027979b          	slliw	a5,a5,0x2
     4d4:	9fb9                	addw	a5,a5,a4
     4d6:	0017979b          	slliw	a5,a5,0x1
     4da:	0007871b          	sext.w	a4,a5
     4de:	fd843783          	ld	a5,-40(s0)
     4e2:	00178693          	addi	a3,a5,1
     4e6:	fcd43c23          	sd	a3,-40(s0)
     4ea:	0007c783          	lbu	a5,0(a5)
     4ee:	2781                	sext.w	a5,a5
     4f0:	9fb9                	addw	a5,a5,a4
     4f2:	2781                	sext.w	a5,a5
     4f4:	fd07879b          	addiw	a5,a5,-48
     4f8:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
     4fc:	fd843783          	ld	a5,-40(s0)
     500:	0007c783          	lbu	a5,0(a5)
     504:	873e                	mv	a4,a5
     506:	02f00793          	li	a5,47
     50a:	00e7fb63          	bgeu	a5,a4,520 <atoi+0x66>
     50e:	fd843783          	ld	a5,-40(s0)
     512:	0007c783          	lbu	a5,0(a5)
     516:	873e                	mv	a4,a5
     518:	03900793          	li	a5,57
     51c:	fae7f7e3          	bgeu	a5,a4,4ca <atoi+0x10>
  return n;
     520:	fec42783          	lw	a5,-20(s0)
}
     524:	853e                	mv	a0,a5
     526:	7422                	ld	s0,40(sp)
     528:	6145                	addi	sp,sp,48
     52a:	8082                	ret

000000000000052c <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     52c:	7139                	addi	sp,sp,-64
     52e:	fc22                	sd	s0,56(sp)
     530:	0080                	addi	s0,sp,64
     532:	fca43c23          	sd	a0,-40(s0)
     536:	fcb43823          	sd	a1,-48(s0)
     53a:	87b2                	mv	a5,a2
     53c:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
     540:	fd843783          	ld	a5,-40(s0)
     544:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
     548:	fd043783          	ld	a5,-48(s0)
     54c:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
     550:	fe043703          	ld	a4,-32(s0)
     554:	fe843783          	ld	a5,-24(s0)
     558:	02e7fc63          	bgeu	a5,a4,590 <memmove+0x64>
    while(n-- > 0)
     55c:	a00d                	j	57e <memmove+0x52>
      *dst++ = *src++;
     55e:	fe043703          	ld	a4,-32(s0)
     562:	00170793          	addi	a5,a4,1
     566:	fef43023          	sd	a5,-32(s0)
     56a:	fe843783          	ld	a5,-24(s0)
     56e:	00178693          	addi	a3,a5,1
     572:	fed43423          	sd	a3,-24(s0)
     576:	00074703          	lbu	a4,0(a4)
     57a:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     57e:	fcc42783          	lw	a5,-52(s0)
     582:	fff7871b          	addiw	a4,a5,-1
     586:	fce42623          	sw	a4,-52(s0)
     58a:	fcf04ae3          	bgtz	a5,55e <memmove+0x32>
     58e:	a891                	j	5e2 <memmove+0xb6>
  } else {
    dst += n;
     590:	fcc42783          	lw	a5,-52(s0)
     594:	fe843703          	ld	a4,-24(s0)
     598:	97ba                	add	a5,a5,a4
     59a:	fef43423          	sd	a5,-24(s0)
    src += n;
     59e:	fcc42783          	lw	a5,-52(s0)
     5a2:	fe043703          	ld	a4,-32(s0)
     5a6:	97ba                	add	a5,a5,a4
     5a8:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
     5ac:	a01d                	j	5d2 <memmove+0xa6>
      *--dst = *--src;
     5ae:	fe043783          	ld	a5,-32(s0)
     5b2:	17fd                	addi	a5,a5,-1
     5b4:	fef43023          	sd	a5,-32(s0)
     5b8:	fe843783          	ld	a5,-24(s0)
     5bc:	17fd                	addi	a5,a5,-1
     5be:	fef43423          	sd	a5,-24(s0)
     5c2:	fe043783          	ld	a5,-32(s0)
     5c6:	0007c703          	lbu	a4,0(a5)
     5ca:	fe843783          	ld	a5,-24(s0)
     5ce:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     5d2:	fcc42783          	lw	a5,-52(s0)
     5d6:	fff7871b          	addiw	a4,a5,-1
     5da:	fce42623          	sw	a4,-52(s0)
     5de:	fcf048e3          	bgtz	a5,5ae <memmove+0x82>
  }
  return vdst;
     5e2:	fd843783          	ld	a5,-40(s0)
}
     5e6:	853e                	mv	a0,a5
     5e8:	7462                	ld	s0,56(sp)
     5ea:	6121                	addi	sp,sp,64
     5ec:	8082                	ret

00000000000005ee <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     5ee:	7139                	addi	sp,sp,-64
     5f0:	fc22                	sd	s0,56(sp)
     5f2:	0080                	addi	s0,sp,64
     5f4:	fca43c23          	sd	a0,-40(s0)
     5f8:	fcb43823          	sd	a1,-48(s0)
     5fc:	87b2                	mv	a5,a2
     5fe:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
     602:	fd843783          	ld	a5,-40(s0)
     606:	fef43423          	sd	a5,-24(s0)
     60a:	fd043783          	ld	a5,-48(s0)
     60e:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     612:	a0a1                	j	65a <memcmp+0x6c>
    if (*p1 != *p2) {
     614:	fe843783          	ld	a5,-24(s0)
     618:	0007c703          	lbu	a4,0(a5)
     61c:	fe043783          	ld	a5,-32(s0)
     620:	0007c783          	lbu	a5,0(a5)
     624:	02f70163          	beq	a4,a5,646 <memcmp+0x58>
      return *p1 - *p2;
     628:	fe843783          	ld	a5,-24(s0)
     62c:	0007c783          	lbu	a5,0(a5)
     630:	0007871b          	sext.w	a4,a5
     634:	fe043783          	ld	a5,-32(s0)
     638:	0007c783          	lbu	a5,0(a5)
     63c:	2781                	sext.w	a5,a5
     63e:	40f707bb          	subw	a5,a4,a5
     642:	2781                	sext.w	a5,a5
     644:	a01d                	j	66a <memcmp+0x7c>
    }
    p1++;
     646:	fe843783          	ld	a5,-24(s0)
     64a:	0785                	addi	a5,a5,1
     64c:	fef43423          	sd	a5,-24(s0)
    p2++;
     650:	fe043783          	ld	a5,-32(s0)
     654:	0785                	addi	a5,a5,1
     656:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     65a:	fcc42783          	lw	a5,-52(s0)
     65e:	fff7871b          	addiw	a4,a5,-1
     662:	fce42623          	sw	a4,-52(s0)
     666:	f7dd                	bnez	a5,614 <memcmp+0x26>
  }
  return 0;
     668:	4781                	li	a5,0
}
     66a:	853e                	mv	a0,a5
     66c:	7462                	ld	s0,56(sp)
     66e:	6121                	addi	sp,sp,64
     670:	8082                	ret

0000000000000672 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     672:	7179                	addi	sp,sp,-48
     674:	f406                	sd	ra,40(sp)
     676:	f022                	sd	s0,32(sp)
     678:	1800                	addi	s0,sp,48
     67a:	fea43423          	sd	a0,-24(s0)
     67e:	feb43023          	sd	a1,-32(s0)
     682:	87b2                	mv	a5,a2
     684:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
     688:	fdc42783          	lw	a5,-36(s0)
     68c:	863e                	mv	a2,a5
     68e:	fe043583          	ld	a1,-32(s0)
     692:	fe843503          	ld	a0,-24(s0)
     696:	00000097          	auipc	ra,0x0
     69a:	e96080e7          	jalr	-362(ra) # 52c <memmove>
     69e:	87aa                	mv	a5,a0
}
     6a0:	853e                	mv	a0,a5
     6a2:	70a2                	ld	ra,40(sp)
     6a4:	7402                	ld	s0,32(sp)
     6a6:	6145                	addi	sp,sp,48
     6a8:	8082                	ret

00000000000006aa <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     6aa:	4885                	li	a7,1
 ecall
     6ac:	00000073          	ecall
 ret
     6b0:	8082                	ret

00000000000006b2 <exit>:
.global exit
exit:
 li a7, SYS_exit
     6b2:	4889                	li	a7,2
 ecall
     6b4:	00000073          	ecall
 ret
     6b8:	8082                	ret

00000000000006ba <wait>:
.global wait
wait:
 li a7, SYS_wait
     6ba:	488d                	li	a7,3
 ecall
     6bc:	00000073          	ecall
 ret
     6c0:	8082                	ret

00000000000006c2 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     6c2:	4891                	li	a7,4
 ecall
     6c4:	00000073          	ecall
 ret
     6c8:	8082                	ret

00000000000006ca <read>:
.global read
read:
 li a7, SYS_read
     6ca:	4895                	li	a7,5
 ecall
     6cc:	00000073          	ecall
 ret
     6d0:	8082                	ret

00000000000006d2 <write>:
.global write
write:
 li a7, SYS_write
     6d2:	48c1                	li	a7,16
 ecall
     6d4:	00000073          	ecall
 ret
     6d8:	8082                	ret

00000000000006da <close>:
.global close
close:
 li a7, SYS_close
     6da:	48d5                	li	a7,21
 ecall
     6dc:	00000073          	ecall
 ret
     6e0:	8082                	ret

00000000000006e2 <kill>:
.global kill
kill:
 li a7, SYS_kill
     6e2:	4899                	li	a7,6
 ecall
     6e4:	00000073          	ecall
 ret
     6e8:	8082                	ret

00000000000006ea <exec>:
.global exec
exec:
 li a7, SYS_exec
     6ea:	489d                	li	a7,7
 ecall
     6ec:	00000073          	ecall
 ret
     6f0:	8082                	ret

00000000000006f2 <open>:
.global open
open:
 li a7, SYS_open
     6f2:	48bd                	li	a7,15
 ecall
     6f4:	00000073          	ecall
 ret
     6f8:	8082                	ret

00000000000006fa <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     6fa:	48c5                	li	a7,17
 ecall
     6fc:	00000073          	ecall
 ret
     700:	8082                	ret

0000000000000702 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     702:	48c9                	li	a7,18
 ecall
     704:	00000073          	ecall
 ret
     708:	8082                	ret

000000000000070a <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     70a:	48a1                	li	a7,8
 ecall
     70c:	00000073          	ecall
 ret
     710:	8082                	ret

0000000000000712 <link>:
.global link
link:
 li a7, SYS_link
     712:	48cd                	li	a7,19
 ecall
     714:	00000073          	ecall
 ret
     718:	8082                	ret

000000000000071a <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     71a:	48d1                	li	a7,20
 ecall
     71c:	00000073          	ecall
 ret
     720:	8082                	ret

0000000000000722 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     722:	48a5                	li	a7,9
 ecall
     724:	00000073          	ecall
 ret
     728:	8082                	ret

000000000000072a <dup>:
.global dup
dup:
 li a7, SYS_dup
     72a:	48a9                	li	a7,10
 ecall
     72c:	00000073          	ecall
 ret
     730:	8082                	ret

0000000000000732 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     732:	48ad                	li	a7,11
 ecall
     734:	00000073          	ecall
 ret
     738:	8082                	ret

000000000000073a <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     73a:	48b1                	li	a7,12
 ecall
     73c:	00000073          	ecall
 ret
     740:	8082                	ret

0000000000000742 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     742:	48b5                	li	a7,13
 ecall
     744:	00000073          	ecall
 ret
     748:	8082                	ret

000000000000074a <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     74a:	48b9                	li	a7,14
 ecall
     74c:	00000073          	ecall
 ret
     750:	8082                	ret

0000000000000752 <thrdstop>:
.global thrdstop
thrdstop:
 li a7, SYS_thrdstop
     752:	48d9                	li	a7,22
 ecall
     754:	00000073          	ecall
 ret
     758:	8082                	ret

000000000000075a <thrdresume>:
.global thrdresume
thrdresume:
 li a7, SYS_thrdresume
     75a:	48dd                	li	a7,23
 ecall
     75c:	00000073          	ecall
 ret
     760:	8082                	ret

0000000000000762 <cancelthrdstop>:
.global cancelthrdstop
cancelthrdstop:
 li a7, SYS_cancelthrdstop
     762:	48e1                	li	a7,24
 ecall
     764:	00000073          	ecall
 ret
     768:	8082                	ret

000000000000076a <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     76a:	1101                	addi	sp,sp,-32
     76c:	ec06                	sd	ra,24(sp)
     76e:	e822                	sd	s0,16(sp)
     770:	1000                	addi	s0,sp,32
     772:	87aa                	mv	a5,a0
     774:	872e                	mv	a4,a1
     776:	fef42623          	sw	a5,-20(s0)
     77a:	87ba                	mv	a5,a4
     77c:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
     780:	feb40713          	addi	a4,s0,-21
     784:	fec42783          	lw	a5,-20(s0)
     788:	4605                	li	a2,1
     78a:	85ba                	mv	a1,a4
     78c:	853e                	mv	a0,a5
     78e:	00000097          	auipc	ra,0x0
     792:	f44080e7          	jalr	-188(ra) # 6d2 <write>
}
     796:	0001                	nop
     798:	60e2                	ld	ra,24(sp)
     79a:	6442                	ld	s0,16(sp)
     79c:	6105                	addi	sp,sp,32
     79e:	8082                	ret

00000000000007a0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     7a0:	7139                	addi	sp,sp,-64
     7a2:	fc06                	sd	ra,56(sp)
     7a4:	f822                	sd	s0,48(sp)
     7a6:	0080                	addi	s0,sp,64
     7a8:	87aa                	mv	a5,a0
     7aa:	8736                	mv	a4,a3
     7ac:	fcf42623          	sw	a5,-52(s0)
     7b0:	87ae                	mv	a5,a1
     7b2:	fcf42423          	sw	a5,-56(s0)
     7b6:	87b2                	mv	a5,a2
     7b8:	fcf42223          	sw	a5,-60(s0)
     7bc:	87ba                	mv	a5,a4
     7be:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     7c2:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
     7c6:	fc042783          	lw	a5,-64(s0)
     7ca:	2781                	sext.w	a5,a5
     7cc:	c38d                	beqz	a5,7ee <printint+0x4e>
     7ce:	fc842783          	lw	a5,-56(s0)
     7d2:	2781                	sext.w	a5,a5
     7d4:	0007dd63          	bgez	a5,7ee <printint+0x4e>
    neg = 1;
     7d8:	4785                	li	a5,1
     7da:	fef42423          	sw	a5,-24(s0)
    x = -xx;
     7de:	fc842783          	lw	a5,-56(s0)
     7e2:	40f007bb          	negw	a5,a5
     7e6:	2781                	sext.w	a5,a5
     7e8:	fef42223          	sw	a5,-28(s0)
     7ec:	a029                	j	7f6 <printint+0x56>
  } else {
    x = xx;
     7ee:	fc842783          	lw	a5,-56(s0)
     7f2:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
     7f6:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
     7fa:	fc442783          	lw	a5,-60(s0)
     7fe:	fe442703          	lw	a4,-28(s0)
     802:	02f777bb          	remuw	a5,a4,a5
     806:	0007861b          	sext.w	a2,a5
     80a:	fec42783          	lw	a5,-20(s0)
     80e:	0017871b          	addiw	a4,a5,1
     812:	fee42623          	sw	a4,-20(s0)
     816:	00001697          	auipc	a3,0x1
     81a:	fca68693          	addi	a3,a3,-54 # 17e0 <digits>
     81e:	02061713          	slli	a4,a2,0x20
     822:	9301                	srli	a4,a4,0x20
     824:	9736                	add	a4,a4,a3
     826:	00074703          	lbu	a4,0(a4)
     82a:	ff040693          	addi	a3,s0,-16
     82e:	97b6                	add	a5,a5,a3
     830:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
     834:	fc442783          	lw	a5,-60(s0)
     838:	fe442703          	lw	a4,-28(s0)
     83c:	02f757bb          	divuw	a5,a4,a5
     840:	fef42223          	sw	a5,-28(s0)
     844:	fe442783          	lw	a5,-28(s0)
     848:	2781                	sext.w	a5,a5
     84a:	fbc5                	bnez	a5,7fa <printint+0x5a>
  if(neg)
     84c:	fe842783          	lw	a5,-24(s0)
     850:	2781                	sext.w	a5,a5
     852:	cf95                	beqz	a5,88e <printint+0xee>
    buf[i++] = '-';
     854:	fec42783          	lw	a5,-20(s0)
     858:	0017871b          	addiw	a4,a5,1
     85c:	fee42623          	sw	a4,-20(s0)
     860:	ff040713          	addi	a4,s0,-16
     864:	97ba                	add	a5,a5,a4
     866:	02d00713          	li	a4,45
     86a:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
     86e:	a005                	j	88e <printint+0xee>
    putc(fd, buf[i]);
     870:	fec42783          	lw	a5,-20(s0)
     874:	ff040713          	addi	a4,s0,-16
     878:	97ba                	add	a5,a5,a4
     87a:	fe07c703          	lbu	a4,-32(a5)
     87e:	fcc42783          	lw	a5,-52(s0)
     882:	85ba                	mv	a1,a4
     884:	853e                	mv	a0,a5
     886:	00000097          	auipc	ra,0x0
     88a:	ee4080e7          	jalr	-284(ra) # 76a <putc>
  while(--i >= 0)
     88e:	fec42783          	lw	a5,-20(s0)
     892:	37fd                	addiw	a5,a5,-1
     894:	fef42623          	sw	a5,-20(s0)
     898:	fec42783          	lw	a5,-20(s0)
     89c:	2781                	sext.w	a5,a5
     89e:	fc07d9e3          	bgez	a5,870 <printint+0xd0>
}
     8a2:	0001                	nop
     8a4:	0001                	nop
     8a6:	70e2                	ld	ra,56(sp)
     8a8:	7442                	ld	s0,48(sp)
     8aa:	6121                	addi	sp,sp,64
     8ac:	8082                	ret

00000000000008ae <printptr>:

static void
printptr(int fd, uint64 x) {
     8ae:	7179                	addi	sp,sp,-48
     8b0:	f406                	sd	ra,40(sp)
     8b2:	f022                	sd	s0,32(sp)
     8b4:	1800                	addi	s0,sp,48
     8b6:	87aa                	mv	a5,a0
     8b8:	fcb43823          	sd	a1,-48(s0)
     8bc:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
     8c0:	fdc42783          	lw	a5,-36(s0)
     8c4:	03000593          	li	a1,48
     8c8:	853e                	mv	a0,a5
     8ca:	00000097          	auipc	ra,0x0
     8ce:	ea0080e7          	jalr	-352(ra) # 76a <putc>
  putc(fd, 'x');
     8d2:	fdc42783          	lw	a5,-36(s0)
     8d6:	07800593          	li	a1,120
     8da:	853e                	mv	a0,a5
     8dc:	00000097          	auipc	ra,0x0
     8e0:	e8e080e7          	jalr	-370(ra) # 76a <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     8e4:	fe042623          	sw	zero,-20(s0)
     8e8:	a82d                	j	922 <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     8ea:	fd043783          	ld	a5,-48(s0)
     8ee:	93f1                	srli	a5,a5,0x3c
     8f0:	00001717          	auipc	a4,0x1
     8f4:	ef070713          	addi	a4,a4,-272 # 17e0 <digits>
     8f8:	97ba                	add	a5,a5,a4
     8fa:	0007c703          	lbu	a4,0(a5)
     8fe:	fdc42783          	lw	a5,-36(s0)
     902:	85ba                	mv	a1,a4
     904:	853e                	mv	a0,a5
     906:	00000097          	auipc	ra,0x0
     90a:	e64080e7          	jalr	-412(ra) # 76a <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     90e:	fec42783          	lw	a5,-20(s0)
     912:	2785                	addiw	a5,a5,1
     914:	fef42623          	sw	a5,-20(s0)
     918:	fd043783          	ld	a5,-48(s0)
     91c:	0792                	slli	a5,a5,0x4
     91e:	fcf43823          	sd	a5,-48(s0)
     922:	fec42783          	lw	a5,-20(s0)
     926:	873e                	mv	a4,a5
     928:	47bd                	li	a5,15
     92a:	fce7f0e3          	bgeu	a5,a4,8ea <printptr+0x3c>
}
     92e:	0001                	nop
     930:	0001                	nop
     932:	70a2                	ld	ra,40(sp)
     934:	7402                	ld	s0,32(sp)
     936:	6145                	addi	sp,sp,48
     938:	8082                	ret

000000000000093a <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     93a:	715d                	addi	sp,sp,-80
     93c:	e486                	sd	ra,72(sp)
     93e:	e0a2                	sd	s0,64(sp)
     940:	0880                	addi	s0,sp,80
     942:	87aa                	mv	a5,a0
     944:	fcb43023          	sd	a1,-64(s0)
     948:	fac43c23          	sd	a2,-72(s0)
     94c:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
     950:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     954:	fe042223          	sw	zero,-28(s0)
     958:	a42d                	j	b82 <vprintf+0x248>
    c = fmt[i] & 0xff;
     95a:	fe442783          	lw	a5,-28(s0)
     95e:	fc043703          	ld	a4,-64(s0)
     962:	97ba                	add	a5,a5,a4
     964:	0007c783          	lbu	a5,0(a5)
     968:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
     96c:	fe042783          	lw	a5,-32(s0)
     970:	2781                	sext.w	a5,a5
     972:	eb9d                	bnez	a5,9a8 <vprintf+0x6e>
      if(c == '%'){
     974:	fdc42783          	lw	a5,-36(s0)
     978:	0007871b          	sext.w	a4,a5
     97c:	02500793          	li	a5,37
     980:	00f71763          	bne	a4,a5,98e <vprintf+0x54>
        state = '%';
     984:	02500793          	li	a5,37
     988:	fef42023          	sw	a5,-32(s0)
     98c:	a2f5                	j	b78 <vprintf+0x23e>
      } else {
        putc(fd, c);
     98e:	fdc42783          	lw	a5,-36(s0)
     992:	0ff7f713          	andi	a4,a5,255
     996:	fcc42783          	lw	a5,-52(s0)
     99a:	85ba                	mv	a1,a4
     99c:	853e                	mv	a0,a5
     99e:	00000097          	auipc	ra,0x0
     9a2:	dcc080e7          	jalr	-564(ra) # 76a <putc>
     9a6:	aac9                	j	b78 <vprintf+0x23e>
      }
    } else if(state == '%'){
     9a8:	fe042783          	lw	a5,-32(s0)
     9ac:	0007871b          	sext.w	a4,a5
     9b0:	02500793          	li	a5,37
     9b4:	1cf71263          	bne	a4,a5,b78 <vprintf+0x23e>
      if(c == 'd'){
     9b8:	fdc42783          	lw	a5,-36(s0)
     9bc:	0007871b          	sext.w	a4,a5
     9c0:	06400793          	li	a5,100
     9c4:	02f71463          	bne	a4,a5,9ec <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
     9c8:	fb843783          	ld	a5,-72(s0)
     9cc:	00878713          	addi	a4,a5,8
     9d0:	fae43c23          	sd	a4,-72(s0)
     9d4:	4398                	lw	a4,0(a5)
     9d6:	fcc42783          	lw	a5,-52(s0)
     9da:	4685                	li	a3,1
     9dc:	4629                	li	a2,10
     9de:	85ba                	mv	a1,a4
     9e0:	853e                	mv	a0,a5
     9e2:	00000097          	auipc	ra,0x0
     9e6:	dbe080e7          	jalr	-578(ra) # 7a0 <printint>
     9ea:	a269                	j	b74 <vprintf+0x23a>
      } else if(c == 'l') {
     9ec:	fdc42783          	lw	a5,-36(s0)
     9f0:	0007871b          	sext.w	a4,a5
     9f4:	06c00793          	li	a5,108
     9f8:	02f71663          	bne	a4,a5,a24 <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
     9fc:	fb843783          	ld	a5,-72(s0)
     a00:	00878713          	addi	a4,a5,8
     a04:	fae43c23          	sd	a4,-72(s0)
     a08:	639c                	ld	a5,0(a5)
     a0a:	0007871b          	sext.w	a4,a5
     a0e:	fcc42783          	lw	a5,-52(s0)
     a12:	4681                	li	a3,0
     a14:	4629                	li	a2,10
     a16:	85ba                	mv	a1,a4
     a18:	853e                	mv	a0,a5
     a1a:	00000097          	auipc	ra,0x0
     a1e:	d86080e7          	jalr	-634(ra) # 7a0 <printint>
     a22:	aa89                	j	b74 <vprintf+0x23a>
      } else if(c == 'x') {
     a24:	fdc42783          	lw	a5,-36(s0)
     a28:	0007871b          	sext.w	a4,a5
     a2c:	07800793          	li	a5,120
     a30:	02f71463          	bne	a4,a5,a58 <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
     a34:	fb843783          	ld	a5,-72(s0)
     a38:	00878713          	addi	a4,a5,8
     a3c:	fae43c23          	sd	a4,-72(s0)
     a40:	4398                	lw	a4,0(a5)
     a42:	fcc42783          	lw	a5,-52(s0)
     a46:	4681                	li	a3,0
     a48:	4641                	li	a2,16
     a4a:	85ba                	mv	a1,a4
     a4c:	853e                	mv	a0,a5
     a4e:	00000097          	auipc	ra,0x0
     a52:	d52080e7          	jalr	-686(ra) # 7a0 <printint>
     a56:	aa39                	j	b74 <vprintf+0x23a>
      } else if(c == 'p') {
     a58:	fdc42783          	lw	a5,-36(s0)
     a5c:	0007871b          	sext.w	a4,a5
     a60:	07000793          	li	a5,112
     a64:	02f71263          	bne	a4,a5,a88 <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
     a68:	fb843783          	ld	a5,-72(s0)
     a6c:	00878713          	addi	a4,a5,8
     a70:	fae43c23          	sd	a4,-72(s0)
     a74:	6398                	ld	a4,0(a5)
     a76:	fcc42783          	lw	a5,-52(s0)
     a7a:	85ba                	mv	a1,a4
     a7c:	853e                	mv	a0,a5
     a7e:	00000097          	auipc	ra,0x0
     a82:	e30080e7          	jalr	-464(ra) # 8ae <printptr>
     a86:	a0fd                	j	b74 <vprintf+0x23a>
      } else if(c == 's'){
     a88:	fdc42783          	lw	a5,-36(s0)
     a8c:	0007871b          	sext.w	a4,a5
     a90:	07300793          	li	a5,115
     a94:	04f71c63          	bne	a4,a5,aec <vprintf+0x1b2>
        s = va_arg(ap, char*);
     a98:	fb843783          	ld	a5,-72(s0)
     a9c:	00878713          	addi	a4,a5,8
     aa0:	fae43c23          	sd	a4,-72(s0)
     aa4:	639c                	ld	a5,0(a5)
     aa6:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
     aaa:	fe843783          	ld	a5,-24(s0)
     aae:	eb8d                	bnez	a5,ae0 <vprintf+0x1a6>
          s = "(null)";
     ab0:	00001797          	auipc	a5,0x1
     ab4:	d2878793          	addi	a5,a5,-728 # 17d8 <schedule_rm+0x3a6>
     ab8:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     abc:	a015                	j	ae0 <vprintf+0x1a6>
          putc(fd, *s);
     abe:	fe843783          	ld	a5,-24(s0)
     ac2:	0007c703          	lbu	a4,0(a5)
     ac6:	fcc42783          	lw	a5,-52(s0)
     aca:	85ba                	mv	a1,a4
     acc:	853e                	mv	a0,a5
     ace:	00000097          	auipc	ra,0x0
     ad2:	c9c080e7          	jalr	-868(ra) # 76a <putc>
          s++;
     ad6:	fe843783          	ld	a5,-24(s0)
     ada:	0785                	addi	a5,a5,1
     adc:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     ae0:	fe843783          	ld	a5,-24(s0)
     ae4:	0007c783          	lbu	a5,0(a5)
     ae8:	fbf9                	bnez	a5,abe <vprintf+0x184>
     aea:	a069                	j	b74 <vprintf+0x23a>
        }
      } else if(c == 'c'){
     aec:	fdc42783          	lw	a5,-36(s0)
     af0:	0007871b          	sext.w	a4,a5
     af4:	06300793          	li	a5,99
     af8:	02f71463          	bne	a4,a5,b20 <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
     afc:	fb843783          	ld	a5,-72(s0)
     b00:	00878713          	addi	a4,a5,8
     b04:	fae43c23          	sd	a4,-72(s0)
     b08:	439c                	lw	a5,0(a5)
     b0a:	0ff7f713          	andi	a4,a5,255
     b0e:	fcc42783          	lw	a5,-52(s0)
     b12:	85ba                	mv	a1,a4
     b14:	853e                	mv	a0,a5
     b16:	00000097          	auipc	ra,0x0
     b1a:	c54080e7          	jalr	-940(ra) # 76a <putc>
     b1e:	a899                	j	b74 <vprintf+0x23a>
      } else if(c == '%'){
     b20:	fdc42783          	lw	a5,-36(s0)
     b24:	0007871b          	sext.w	a4,a5
     b28:	02500793          	li	a5,37
     b2c:	00f71f63          	bne	a4,a5,b4a <vprintf+0x210>
        putc(fd, c);
     b30:	fdc42783          	lw	a5,-36(s0)
     b34:	0ff7f713          	andi	a4,a5,255
     b38:	fcc42783          	lw	a5,-52(s0)
     b3c:	85ba                	mv	a1,a4
     b3e:	853e                	mv	a0,a5
     b40:	00000097          	auipc	ra,0x0
     b44:	c2a080e7          	jalr	-982(ra) # 76a <putc>
     b48:	a035                	j	b74 <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     b4a:	fcc42783          	lw	a5,-52(s0)
     b4e:	02500593          	li	a1,37
     b52:	853e                	mv	a0,a5
     b54:	00000097          	auipc	ra,0x0
     b58:	c16080e7          	jalr	-1002(ra) # 76a <putc>
        putc(fd, c);
     b5c:	fdc42783          	lw	a5,-36(s0)
     b60:	0ff7f713          	andi	a4,a5,255
     b64:	fcc42783          	lw	a5,-52(s0)
     b68:	85ba                	mv	a1,a4
     b6a:	853e                	mv	a0,a5
     b6c:	00000097          	auipc	ra,0x0
     b70:	bfe080e7          	jalr	-1026(ra) # 76a <putc>
      }
      state = 0;
     b74:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     b78:	fe442783          	lw	a5,-28(s0)
     b7c:	2785                	addiw	a5,a5,1
     b7e:	fef42223          	sw	a5,-28(s0)
     b82:	fe442783          	lw	a5,-28(s0)
     b86:	fc043703          	ld	a4,-64(s0)
     b8a:	97ba                	add	a5,a5,a4
     b8c:	0007c783          	lbu	a5,0(a5)
     b90:	dc0795e3          	bnez	a5,95a <vprintf+0x20>
    }
  }
}
     b94:	0001                	nop
     b96:	0001                	nop
     b98:	60a6                	ld	ra,72(sp)
     b9a:	6406                	ld	s0,64(sp)
     b9c:	6161                	addi	sp,sp,80
     b9e:	8082                	ret

0000000000000ba0 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     ba0:	7159                	addi	sp,sp,-112
     ba2:	fc06                	sd	ra,56(sp)
     ba4:	f822                	sd	s0,48(sp)
     ba6:	0080                	addi	s0,sp,64
     ba8:	fcb43823          	sd	a1,-48(s0)
     bac:	e010                	sd	a2,0(s0)
     bae:	e414                	sd	a3,8(s0)
     bb0:	e818                	sd	a4,16(s0)
     bb2:	ec1c                	sd	a5,24(s0)
     bb4:	03043023          	sd	a6,32(s0)
     bb8:	03143423          	sd	a7,40(s0)
     bbc:	87aa                	mv	a5,a0
     bbe:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
     bc2:	03040793          	addi	a5,s0,48
     bc6:	fcf43423          	sd	a5,-56(s0)
     bca:	fc843783          	ld	a5,-56(s0)
     bce:	fd078793          	addi	a5,a5,-48
     bd2:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
     bd6:	fe843703          	ld	a4,-24(s0)
     bda:	fdc42783          	lw	a5,-36(s0)
     bde:	863a                	mv	a2,a4
     be0:	fd043583          	ld	a1,-48(s0)
     be4:	853e                	mv	a0,a5
     be6:	00000097          	auipc	ra,0x0
     bea:	d54080e7          	jalr	-684(ra) # 93a <vprintf>
}
     bee:	0001                	nop
     bf0:	70e2                	ld	ra,56(sp)
     bf2:	7442                	ld	s0,48(sp)
     bf4:	6165                	addi	sp,sp,112
     bf6:	8082                	ret

0000000000000bf8 <printf>:

void
printf(const char *fmt, ...)
{
     bf8:	7159                	addi	sp,sp,-112
     bfa:	f406                	sd	ra,40(sp)
     bfc:	f022                	sd	s0,32(sp)
     bfe:	1800                	addi	s0,sp,48
     c00:	fca43c23          	sd	a0,-40(s0)
     c04:	e40c                	sd	a1,8(s0)
     c06:	e810                	sd	a2,16(s0)
     c08:	ec14                	sd	a3,24(s0)
     c0a:	f018                	sd	a4,32(s0)
     c0c:	f41c                	sd	a5,40(s0)
     c0e:	03043823          	sd	a6,48(s0)
     c12:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
     c16:	04040793          	addi	a5,s0,64
     c1a:	fcf43823          	sd	a5,-48(s0)
     c1e:	fd043783          	ld	a5,-48(s0)
     c22:	fc878793          	addi	a5,a5,-56
     c26:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
     c2a:	fe843783          	ld	a5,-24(s0)
     c2e:	863e                	mv	a2,a5
     c30:	fd843583          	ld	a1,-40(s0)
     c34:	4505                	li	a0,1
     c36:	00000097          	auipc	ra,0x0
     c3a:	d04080e7          	jalr	-764(ra) # 93a <vprintf>
}
     c3e:	0001                	nop
     c40:	70a2                	ld	ra,40(sp)
     c42:	7402                	ld	s0,32(sp)
     c44:	6165                	addi	sp,sp,112
     c46:	8082                	ret

0000000000000c48 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     c48:	7179                	addi	sp,sp,-48
     c4a:	f422                	sd	s0,40(sp)
     c4c:	1800                	addi	s0,sp,48
     c4e:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
     c52:	fd843783          	ld	a5,-40(s0)
     c56:	17c1                	addi	a5,a5,-16
     c58:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     c5c:	00001797          	auipc	a5,0x1
     c60:	dac78793          	addi	a5,a5,-596 # 1a08 <freep>
     c64:	639c                	ld	a5,0(a5)
     c66:	fef43423          	sd	a5,-24(s0)
     c6a:	a815                	j	c9e <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     c6c:	fe843783          	ld	a5,-24(s0)
     c70:	639c                	ld	a5,0(a5)
     c72:	fe843703          	ld	a4,-24(s0)
     c76:	00f76f63          	bltu	a4,a5,c94 <free+0x4c>
     c7a:	fe043703          	ld	a4,-32(s0)
     c7e:	fe843783          	ld	a5,-24(s0)
     c82:	02e7eb63          	bltu	a5,a4,cb8 <free+0x70>
     c86:	fe843783          	ld	a5,-24(s0)
     c8a:	639c                	ld	a5,0(a5)
     c8c:	fe043703          	ld	a4,-32(s0)
     c90:	02f76463          	bltu	a4,a5,cb8 <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     c94:	fe843783          	ld	a5,-24(s0)
     c98:	639c                	ld	a5,0(a5)
     c9a:	fef43423          	sd	a5,-24(s0)
     c9e:	fe043703          	ld	a4,-32(s0)
     ca2:	fe843783          	ld	a5,-24(s0)
     ca6:	fce7f3e3          	bgeu	a5,a4,c6c <free+0x24>
     caa:	fe843783          	ld	a5,-24(s0)
     cae:	639c                	ld	a5,0(a5)
     cb0:	fe043703          	ld	a4,-32(s0)
     cb4:	faf77ce3          	bgeu	a4,a5,c6c <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
     cb8:	fe043783          	ld	a5,-32(s0)
     cbc:	479c                	lw	a5,8(a5)
     cbe:	1782                	slli	a5,a5,0x20
     cc0:	9381                	srli	a5,a5,0x20
     cc2:	0792                	slli	a5,a5,0x4
     cc4:	fe043703          	ld	a4,-32(s0)
     cc8:	973e                	add	a4,a4,a5
     cca:	fe843783          	ld	a5,-24(s0)
     cce:	639c                	ld	a5,0(a5)
     cd0:	02f71763          	bne	a4,a5,cfe <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
     cd4:	fe043783          	ld	a5,-32(s0)
     cd8:	4798                	lw	a4,8(a5)
     cda:	fe843783          	ld	a5,-24(s0)
     cde:	639c                	ld	a5,0(a5)
     ce0:	479c                	lw	a5,8(a5)
     ce2:	9fb9                	addw	a5,a5,a4
     ce4:	0007871b          	sext.w	a4,a5
     ce8:	fe043783          	ld	a5,-32(s0)
     cec:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
     cee:	fe843783          	ld	a5,-24(s0)
     cf2:	639c                	ld	a5,0(a5)
     cf4:	6398                	ld	a4,0(a5)
     cf6:	fe043783          	ld	a5,-32(s0)
     cfa:	e398                	sd	a4,0(a5)
     cfc:	a039                	j	d0a <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
     cfe:	fe843783          	ld	a5,-24(s0)
     d02:	6398                	ld	a4,0(a5)
     d04:	fe043783          	ld	a5,-32(s0)
     d08:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
     d0a:	fe843783          	ld	a5,-24(s0)
     d0e:	479c                	lw	a5,8(a5)
     d10:	1782                	slli	a5,a5,0x20
     d12:	9381                	srli	a5,a5,0x20
     d14:	0792                	slli	a5,a5,0x4
     d16:	fe843703          	ld	a4,-24(s0)
     d1a:	97ba                	add	a5,a5,a4
     d1c:	fe043703          	ld	a4,-32(s0)
     d20:	02f71563          	bne	a4,a5,d4a <free+0x102>
    p->s.size += bp->s.size;
     d24:	fe843783          	ld	a5,-24(s0)
     d28:	4798                	lw	a4,8(a5)
     d2a:	fe043783          	ld	a5,-32(s0)
     d2e:	479c                	lw	a5,8(a5)
     d30:	9fb9                	addw	a5,a5,a4
     d32:	0007871b          	sext.w	a4,a5
     d36:	fe843783          	ld	a5,-24(s0)
     d3a:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
     d3c:	fe043783          	ld	a5,-32(s0)
     d40:	6398                	ld	a4,0(a5)
     d42:	fe843783          	ld	a5,-24(s0)
     d46:	e398                	sd	a4,0(a5)
     d48:	a031                	j	d54 <free+0x10c>
  } else
    p->s.ptr = bp;
     d4a:	fe843783          	ld	a5,-24(s0)
     d4e:	fe043703          	ld	a4,-32(s0)
     d52:	e398                	sd	a4,0(a5)
  freep = p;
     d54:	00001797          	auipc	a5,0x1
     d58:	cb478793          	addi	a5,a5,-844 # 1a08 <freep>
     d5c:	fe843703          	ld	a4,-24(s0)
     d60:	e398                	sd	a4,0(a5)
}
     d62:	0001                	nop
     d64:	7422                	ld	s0,40(sp)
     d66:	6145                	addi	sp,sp,48
     d68:	8082                	ret

0000000000000d6a <morecore>:

static Header*
morecore(uint nu)
{
     d6a:	7179                	addi	sp,sp,-48
     d6c:	f406                	sd	ra,40(sp)
     d6e:	f022                	sd	s0,32(sp)
     d70:	1800                	addi	s0,sp,48
     d72:	87aa                	mv	a5,a0
     d74:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
     d78:	fdc42783          	lw	a5,-36(s0)
     d7c:	0007871b          	sext.w	a4,a5
     d80:	6785                	lui	a5,0x1
     d82:	00f77563          	bgeu	a4,a5,d8c <morecore+0x22>
    nu = 4096;
     d86:	6785                	lui	a5,0x1
     d88:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
     d8c:	fdc42783          	lw	a5,-36(s0)
     d90:	0047979b          	slliw	a5,a5,0x4
     d94:	2781                	sext.w	a5,a5
     d96:	2781                	sext.w	a5,a5
     d98:	853e                	mv	a0,a5
     d9a:	00000097          	auipc	ra,0x0
     d9e:	9a0080e7          	jalr	-1632(ra) # 73a <sbrk>
     da2:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
     da6:	fe843703          	ld	a4,-24(s0)
     daa:	57fd                	li	a5,-1
     dac:	00f71463          	bne	a4,a5,db4 <morecore+0x4a>
    return 0;
     db0:	4781                	li	a5,0
     db2:	a03d                	j	de0 <morecore+0x76>
  hp = (Header*)p;
     db4:	fe843783          	ld	a5,-24(s0)
     db8:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
     dbc:	fe043783          	ld	a5,-32(s0)
     dc0:	fdc42703          	lw	a4,-36(s0)
     dc4:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
     dc6:	fe043783          	ld	a5,-32(s0)
     dca:	07c1                	addi	a5,a5,16
     dcc:	853e                	mv	a0,a5
     dce:	00000097          	auipc	ra,0x0
     dd2:	e7a080e7          	jalr	-390(ra) # c48 <free>
  return freep;
     dd6:	00001797          	auipc	a5,0x1
     dda:	c3278793          	addi	a5,a5,-974 # 1a08 <freep>
     dde:	639c                	ld	a5,0(a5)
}
     de0:	853e                	mv	a0,a5
     de2:	70a2                	ld	ra,40(sp)
     de4:	7402                	ld	s0,32(sp)
     de6:	6145                	addi	sp,sp,48
     de8:	8082                	ret

0000000000000dea <malloc>:

void*
malloc(uint nbytes)
{
     dea:	7139                	addi	sp,sp,-64
     dec:	fc06                	sd	ra,56(sp)
     dee:	f822                	sd	s0,48(sp)
     df0:	0080                	addi	s0,sp,64
     df2:	87aa                	mv	a5,a0
     df4:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     df8:	fcc46783          	lwu	a5,-52(s0)
     dfc:	07bd                	addi	a5,a5,15
     dfe:	8391                	srli	a5,a5,0x4
     e00:	2781                	sext.w	a5,a5
     e02:	2785                	addiw	a5,a5,1
     e04:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
     e08:	00001797          	auipc	a5,0x1
     e0c:	c0078793          	addi	a5,a5,-1024 # 1a08 <freep>
     e10:	639c                	ld	a5,0(a5)
     e12:	fef43023          	sd	a5,-32(s0)
     e16:	fe043783          	ld	a5,-32(s0)
     e1a:	ef95                	bnez	a5,e56 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
     e1c:	00001797          	auipc	a5,0x1
     e20:	bdc78793          	addi	a5,a5,-1060 # 19f8 <base>
     e24:	fef43023          	sd	a5,-32(s0)
     e28:	00001797          	auipc	a5,0x1
     e2c:	be078793          	addi	a5,a5,-1056 # 1a08 <freep>
     e30:	fe043703          	ld	a4,-32(s0)
     e34:	e398                	sd	a4,0(a5)
     e36:	00001797          	auipc	a5,0x1
     e3a:	bd278793          	addi	a5,a5,-1070 # 1a08 <freep>
     e3e:	6398                	ld	a4,0(a5)
     e40:	00001797          	auipc	a5,0x1
     e44:	bb878793          	addi	a5,a5,-1096 # 19f8 <base>
     e48:	e398                	sd	a4,0(a5)
    base.s.size = 0;
     e4a:	00001797          	auipc	a5,0x1
     e4e:	bae78793          	addi	a5,a5,-1106 # 19f8 <base>
     e52:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     e56:	fe043783          	ld	a5,-32(s0)
     e5a:	639c                	ld	a5,0(a5)
     e5c:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     e60:	fe843783          	ld	a5,-24(s0)
     e64:	4798                	lw	a4,8(a5)
     e66:	fdc42783          	lw	a5,-36(s0)
     e6a:	2781                	sext.w	a5,a5
     e6c:	06f76863          	bltu	a4,a5,edc <malloc+0xf2>
      if(p->s.size == nunits)
     e70:	fe843783          	ld	a5,-24(s0)
     e74:	4798                	lw	a4,8(a5)
     e76:	fdc42783          	lw	a5,-36(s0)
     e7a:	2781                	sext.w	a5,a5
     e7c:	00e79963          	bne	a5,a4,e8e <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
     e80:	fe843783          	ld	a5,-24(s0)
     e84:	6398                	ld	a4,0(a5)
     e86:	fe043783          	ld	a5,-32(s0)
     e8a:	e398                	sd	a4,0(a5)
     e8c:	a82d                	j	ec6 <malloc+0xdc>
      else {
        p->s.size -= nunits;
     e8e:	fe843783          	ld	a5,-24(s0)
     e92:	4798                	lw	a4,8(a5)
     e94:	fdc42783          	lw	a5,-36(s0)
     e98:	40f707bb          	subw	a5,a4,a5
     e9c:	0007871b          	sext.w	a4,a5
     ea0:	fe843783          	ld	a5,-24(s0)
     ea4:	c798                	sw	a4,8(a5)
        p += p->s.size;
     ea6:	fe843783          	ld	a5,-24(s0)
     eaa:	479c                	lw	a5,8(a5)
     eac:	1782                	slli	a5,a5,0x20
     eae:	9381                	srli	a5,a5,0x20
     eb0:	0792                	slli	a5,a5,0x4
     eb2:	fe843703          	ld	a4,-24(s0)
     eb6:	97ba                	add	a5,a5,a4
     eb8:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
     ebc:	fe843783          	ld	a5,-24(s0)
     ec0:	fdc42703          	lw	a4,-36(s0)
     ec4:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
     ec6:	00001797          	auipc	a5,0x1
     eca:	b4278793          	addi	a5,a5,-1214 # 1a08 <freep>
     ece:	fe043703          	ld	a4,-32(s0)
     ed2:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
     ed4:	fe843783          	ld	a5,-24(s0)
     ed8:	07c1                	addi	a5,a5,16
     eda:	a091                	j	f1e <malloc+0x134>
    }
    if(p == freep)
     edc:	00001797          	auipc	a5,0x1
     ee0:	b2c78793          	addi	a5,a5,-1236 # 1a08 <freep>
     ee4:	639c                	ld	a5,0(a5)
     ee6:	fe843703          	ld	a4,-24(s0)
     eea:	02f71063          	bne	a4,a5,f0a <malloc+0x120>
      if((p = morecore(nunits)) == 0)
     eee:	fdc42783          	lw	a5,-36(s0)
     ef2:	853e                	mv	a0,a5
     ef4:	00000097          	auipc	ra,0x0
     ef8:	e76080e7          	jalr	-394(ra) # d6a <morecore>
     efc:	fea43423          	sd	a0,-24(s0)
     f00:	fe843783          	ld	a5,-24(s0)
     f04:	e399                	bnez	a5,f0a <malloc+0x120>
        return 0;
     f06:	4781                	li	a5,0
     f08:	a819                	j	f1e <malloc+0x134>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     f0a:	fe843783          	ld	a5,-24(s0)
     f0e:	fef43023          	sd	a5,-32(s0)
     f12:	fe843783          	ld	a5,-24(s0)
     f16:	639c                	ld	a5,0(a5)
     f18:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     f1c:	b791                	j	e60 <malloc+0x76>
  }
}
     f1e:	853e                	mv	a0,a5
     f20:	70e2                	ld	ra,56(sp)
     f22:	7442                	ld	s0,48(sp)
     f24:	6121                	addi	sp,sp,64
     f26:	8082                	ret

0000000000000f28 <setjmp>:
     f28:	e100                	sd	s0,0(a0)
     f2a:	e504                	sd	s1,8(a0)
     f2c:	01253823          	sd	s2,16(a0)
     f30:	01353c23          	sd	s3,24(a0)
     f34:	03453023          	sd	s4,32(a0)
     f38:	03553423          	sd	s5,40(a0)
     f3c:	03653823          	sd	s6,48(a0)
     f40:	03753c23          	sd	s7,56(a0)
     f44:	05853023          	sd	s8,64(a0)
     f48:	05953423          	sd	s9,72(a0)
     f4c:	05a53823          	sd	s10,80(a0)
     f50:	05b53c23          	sd	s11,88(a0)
     f54:	06153023          	sd	ra,96(a0)
     f58:	06253423          	sd	sp,104(a0)
     f5c:	4501                	li	a0,0
     f5e:	8082                	ret

0000000000000f60 <longjmp>:
     f60:	6100                	ld	s0,0(a0)
     f62:	6504                	ld	s1,8(a0)
     f64:	01053903          	ld	s2,16(a0)
     f68:	01853983          	ld	s3,24(a0)
     f6c:	02053a03          	ld	s4,32(a0)
     f70:	02853a83          	ld	s5,40(a0)
     f74:	03053b03          	ld	s6,48(a0)
     f78:	03853b83          	ld	s7,56(a0)
     f7c:	04053c03          	ld	s8,64(a0)
     f80:	04853c83          	ld	s9,72(a0)
     f84:	05053d03          	ld	s10,80(a0)
     f88:	05853d83          	ld	s11,88(a0)
     f8c:	06053083          	ld	ra,96(a0)
     f90:	06853103          	ld	sp,104(a0)
     f94:	c199                	beqz	a1,f9a <longjmp_1>
     f96:	852e                	mv	a0,a1
     f98:	8082                	ret

0000000000000f9a <longjmp_1>:
     f9a:	4505                	li	a0,1
     f9c:	8082                	ret

0000000000000f9e <list_empty>:
/**
 * list_empty - tests whether a list is empty
 * @head: the list to test.
 */
static inline int list_empty(const struct list_head *head)
{
     f9e:	1101                	addi	sp,sp,-32
     fa0:	ec22                	sd	s0,24(sp)
     fa2:	1000                	addi	s0,sp,32
     fa4:	fea43423          	sd	a0,-24(s0)
    return head->next == head;
     fa8:	fe843783          	ld	a5,-24(s0)
     fac:	639c                	ld	a5,0(a5)
     fae:	fe843703          	ld	a4,-24(s0)
     fb2:	40f707b3          	sub	a5,a4,a5
     fb6:	0017b793          	seqz	a5,a5
     fba:	0ff7f793          	andi	a5,a5,255
     fbe:	2781                	sext.w	a5,a5
}
     fc0:	853e                	mv	a0,a5
     fc2:	6462                	ld	s0,24(sp)
     fc4:	6105                	addi	sp,sp,32
     fc6:	8082                	ret

0000000000000fc8 <schedule_default>:

#define NULL 0

/* default scheduling algorithm */
struct threads_sched_result schedule_default(struct threads_sched_args args)
{
     fc8:	715d                	addi	sp,sp,-80
     fca:	e4a2                	sd	s0,72(sp)
     fcc:	e0a6                	sd	s1,64(sp)
     fce:	0880                	addi	s0,sp,80
     fd0:	84aa                	mv	s1,a0
    struct thread *thread_with_smallest_id = NULL;
     fd2:	fe043423          	sd	zero,-24(s0)
    struct thread *th = NULL;
     fd6:	fe043023          	sd	zero,-32(s0)
    list_for_each_entry(th, args.run_queue, thread_list) {
     fda:	649c                	ld	a5,8(s1)
     fdc:	639c                	ld	a5,0(a5)
     fde:	fcf43c23          	sd	a5,-40(s0)
     fe2:	fd843783          	ld	a5,-40(s0)
     fe6:	fd878793          	addi	a5,a5,-40
     fea:	fef43023          	sd	a5,-32(s0)
     fee:	a81d                	j	1024 <schedule_default+0x5c>
        if (thread_with_smallest_id == NULL || th->ID < thread_with_smallest_id->ID) {
     ff0:	fe843783          	ld	a5,-24(s0)
     ff4:	cb89                	beqz	a5,1006 <schedule_default+0x3e>
     ff6:	fe043783          	ld	a5,-32(s0)
     ffa:	5398                	lw	a4,32(a5)
     ffc:	fe843783          	ld	a5,-24(s0)
    1000:	539c                	lw	a5,32(a5)
    1002:	00f75663          	bge	a4,a5,100e <schedule_default+0x46>
            thread_with_smallest_id = th;
    1006:	fe043783          	ld	a5,-32(s0)
    100a:	fef43423          	sd	a5,-24(s0)
    list_for_each_entry(th, args.run_queue, thread_list) {
    100e:	fe043783          	ld	a5,-32(s0)
    1012:	779c                	ld	a5,40(a5)
    1014:	fcf43823          	sd	a5,-48(s0)
    1018:	fd043783          	ld	a5,-48(s0)
    101c:	fd878793          	addi	a5,a5,-40
    1020:	fef43023          	sd	a5,-32(s0)
    1024:	fe043783          	ld	a5,-32(s0)
    1028:	02878713          	addi	a4,a5,40
    102c:	649c                	ld	a5,8(s1)
    102e:	fcf711e3          	bne	a4,a5,ff0 <schedule_default+0x28>
        }
    }

    struct threads_sched_result r;
    if (thread_with_smallest_id != NULL) {
    1032:	fe843783          	ld	a5,-24(s0)
    1036:	cf89                	beqz	a5,1050 <schedule_default+0x88>
        r.scheduled_thread_list_member = &thread_with_smallest_id->thread_list;
    1038:	fe843783          	ld	a5,-24(s0)
    103c:	02878793          	addi	a5,a5,40
    1040:	faf43823          	sd	a5,-80(s0)
        r.allocated_time = thread_with_smallest_id->remaining_time;
    1044:	fe843783          	ld	a5,-24(s0)
    1048:	47fc                	lw	a5,76(a5)
    104a:	faf42c23          	sw	a5,-72(s0)
    104e:	a039                	j	105c <schedule_default+0x94>
    } else {
        r.scheduled_thread_list_member = args.run_queue;
    1050:	649c                	ld	a5,8(s1)
    1052:	faf43823          	sd	a5,-80(s0)
        r.allocated_time = 1;
    1056:	4785                	li	a5,1
    1058:	faf42c23          	sw	a5,-72(s0)
    }

    return r;
    105c:	fb043783          	ld	a5,-80(s0)
    1060:	fcf43023          	sd	a5,-64(s0)
    1064:	fb843783          	ld	a5,-72(s0)
    1068:	fcf43423          	sd	a5,-56(s0)
    106c:	fc043703          	ld	a4,-64(s0)
    1070:	fc843783          	ld	a5,-56(s0)
    1074:	863a                	mv	a2,a4
    1076:	86be                	mv	a3,a5
    1078:	8732                	mv	a4,a2
    107a:	87b6                	mv	a5,a3
}
    107c:	853a                	mv	a0,a4
    107e:	85be                	mv	a1,a5
    1080:	6426                	ld	s0,72(sp)
    1082:	6486                	ld	s1,64(sp)
    1084:	6161                	addi	sp,sp,80
    1086:	8082                	ret

0000000000001088 <schedule_edf>:

/* Earliest-Deadline-First scheduling */
struct threads_sched_result schedule_edf(struct threads_sched_args args)
{
    1088:	7115                	addi	sp,sp,-224
    108a:	ed86                	sd	ra,216(sp)
    108c:	e9a2                	sd	s0,208(sp)
    108e:	e5a6                	sd	s1,200(sp)
    1090:	e1ca                	sd	s2,192(sp)
    1092:	fd4e                	sd	s3,184(sp)
    1094:	1180                	addi	s0,sp,224
    1096:	84aa                	mv	s1,a0
    // the scheduling is called when a interrupt event happens (either a fn end or a new one is added)
    // need to determine the next thread to execute and the allocated time.

    struct threads_sched_result r;
    if(list_empty(args.run_queue)){
    1098:	649c                	ld	a5,8(s1)
    109a:	853e                	mv	a0,a5
    109c:	00000097          	auipc	ra,0x0
    10a0:	f02080e7          	jalr	-254(ra) # f9e <list_empty>
    10a4:	87aa                	mv	a5,a0
    10a6:	c3d1                	beqz	a5,112a <schedule_edf+0xa2>
        // SPEC 3
        r.scheduled_thread_list_member = args.run_queue;
    10a8:	649c                	ld	a5,8(s1)
    10aa:	f2f43423          	sd	a5,-216(s0)
        int least_release_time = 99999;
    10ae:	67e1                	lui	a5,0x18
    10b0:	69f78793          	addi	a5,a5,1695 # 1869f <__global_pointer$+0x166bf>
    10b4:	fcf42623          	sw	a5,-52(s0)
        struct release_queue_entry* cur;
        list_for_each_entry(cur, args.release_queue, thread_list) {
    10b8:	689c                	ld	a5,16(s1)
    10ba:	639c                	ld	a5,0(a5)
    10bc:	f4f43823          	sd	a5,-176(s0)
    10c0:	f5043783          	ld	a5,-176(s0)
    10c4:	17e1                	addi	a5,a5,-8
    10c6:	fcf43023          	sd	a5,-64(s0)
    10ca:	a805                	j	10fa <schedule_edf+0x72>
            if(cur->release_time<least_release_time){
    10cc:	fc043783          	ld	a5,-64(s0)
    10d0:	4f98                	lw	a4,24(a5)
    10d2:	fcc42783          	lw	a5,-52(s0)
    10d6:	2781                	sext.w	a5,a5
    10d8:	00f75763          	bge	a4,a5,10e6 <schedule_edf+0x5e>
                least_release_time = cur->release_time;
    10dc:	fc043783          	ld	a5,-64(s0)
    10e0:	4f9c                	lw	a5,24(a5)
    10e2:	fcf42623          	sw	a5,-52(s0)
        list_for_each_entry(cur, args.release_queue, thread_list) {
    10e6:	fc043783          	ld	a5,-64(s0)
    10ea:	679c                	ld	a5,8(a5)
    10ec:	f4f43423          	sd	a5,-184(s0)
    10f0:	f4843783          	ld	a5,-184(s0)
    10f4:	17e1                	addi	a5,a5,-8
    10f6:	fcf43023          	sd	a5,-64(s0)
    10fa:	fc043783          	ld	a5,-64(s0)
    10fe:	00878713          	addi	a4,a5,8
    1102:	689c                	ld	a5,16(s1)
    1104:	fcf714e3          	bne	a4,a5,10cc <schedule_edf+0x44>
            }
        }
        r.allocated_time = least_release_time - args.current_time ;
    1108:	409c                	lw	a5,0(s1)
    110a:	fcc42703          	lw	a4,-52(s0)
    110e:	40f707bb          	subw	a5,a4,a5
    1112:	2781                	sext.w	a5,a5
    1114:	f2f42823          	sw	a5,-208(s0)
        return r;
    1118:	f2843783          	ld	a5,-216(s0)
    111c:	f2f43c23          	sd	a5,-200(s0)
    1120:	f3043783          	ld	a5,-208(s0)
    1124:	f4f43023          	sd	a5,-192(s0)
    1128:	a4e5                	j	1410 <schedule_edf+0x388>
    }else{
        // run queue is not empty.
        struct thread *th = NULL;
    112a:	fa043c23          	sd	zero,-72(s0)
        struct thread *min_th = NULL;
    112e:	fa043823          	sd	zero,-80(s0)
        struct thread *min_miss_deadline_th = NULL;
    1132:	fa043423          	sd	zero,-88(s0)
        list_for_each_entry(th, args.run_queue, thread_list) {
    1136:	649c                	ld	a5,8(s1)
    1138:	639c                	ld	a5,0(a5)
    113a:	f8f43423          	sd	a5,-120(s0)
    113e:	f8843783          	ld	a5,-120(s0)
    1142:	fd878793          	addi	a5,a5,-40
    1146:	faf43c23          	sd	a5,-72(s0)
    114a:	a849                	j	11dc <schedule_edf+0x154>
            // printf("in run queue: %d\n", th->ID);
            if(th->current_deadline <= args.current_time){
    114c:	fb843783          	ld	a5,-72(s0)
    1150:	4bb8                	lw	a4,80(a5)
    1152:	409c                	lw	a5,0(s1)
    1154:	02e7c163          	blt	a5,a4,1176 <schedule_edf+0xee>
                if(min_miss_deadline_th == NULL || th->ID<min_miss_deadline_th->ID){
    1158:	fa843783          	ld	a5,-88(s0)
    115c:	cb89                	beqz	a5,116e <schedule_edf+0xe6>
    115e:	fb843783          	ld	a5,-72(s0)
    1162:	5398                	lw	a4,32(a5)
    1164:	fa843783          	ld	a5,-88(s0)
    1168:	539c                	lw	a5,32(a5)
    116a:	00f75663          	bge	a4,a5,1176 <schedule_edf+0xee>
                    min_miss_deadline_th = th;
    116e:	fb843783          	ld	a5,-72(s0)
    1172:	faf43423          	sd	a5,-88(s0)
                }
            }
            if(min_th == NULL) min_th = th;
    1176:	fb043783          	ld	a5,-80(s0)
    117a:	e789                	bnez	a5,1184 <schedule_edf+0xfc>
    117c:	fb843783          	ld	a5,-72(s0)
    1180:	faf43823          	sd	a5,-80(s0)
            if(th->current_deadline<min_th->current_deadline){
    1184:	fb843783          	ld	a5,-72(s0)
    1188:	4bb8                	lw	a4,80(a5)
    118a:	fb043783          	ld	a5,-80(s0)
    118e:	4bbc                	lw	a5,80(a5)
    1190:	00f75763          	bge	a4,a5,119e <schedule_edf+0x116>
                min_th = th;
    1194:	fb843783          	ld	a5,-72(s0)
    1198:	faf43823          	sd	a5,-80(s0)
    119c:	a02d                	j	11c6 <schedule_edf+0x13e>
            }else if(th->current_deadline == min_th->current_deadline){
    119e:	fb843783          	ld	a5,-72(s0)
    11a2:	4bb8                	lw	a4,80(a5)
    11a4:	fb043783          	ld	a5,-80(s0)
    11a8:	4bbc                	lw	a5,80(a5)
    11aa:	00f71e63          	bne	a4,a5,11c6 <schedule_edf+0x13e>
                if(th->ID<min_th->ID) min_th = th;
    11ae:	fb843783          	ld	a5,-72(s0)
    11b2:	5398                	lw	a4,32(a5)
    11b4:	fb043783          	ld	a5,-80(s0)
    11b8:	539c                	lw	a5,32(a5)
    11ba:	00f75663          	bge	a4,a5,11c6 <schedule_edf+0x13e>
    11be:	fb843783          	ld	a5,-72(s0)
    11c2:	faf43823          	sd	a5,-80(s0)
        list_for_each_entry(th, args.run_queue, thread_list) {
    11c6:	fb843783          	ld	a5,-72(s0)
    11ca:	779c                	ld	a5,40(a5)
    11cc:	f4f43c23          	sd	a5,-168(s0)
    11d0:	f5843783          	ld	a5,-168(s0)
    11d4:	fd878793          	addi	a5,a5,-40
    11d8:	faf43c23          	sd	a5,-72(s0)
    11dc:	fb843783          	ld	a5,-72(s0)
    11e0:	02878713          	addi	a4,a5,40
    11e4:	649c                	ld	a5,8(s1)
    11e6:	f6f713e3          	bne	a4,a5,114c <schedule_edf+0xc4>
            }
        }

        if(min_miss_deadline_th != NULL) {
    11ea:	fa843783          	ld	a5,-88(s0)
    11ee:	c395                	beqz	a5,1212 <schedule_edf+0x18a>
            // SPEC 4: exist missed deadline
            // printf("exist missed deadline", th->ID);
            r.allocated_time = 0;
    11f0:	f2042823          	sw	zero,-208(s0)
            r.scheduled_thread_list_member = &min_miss_deadline_th->thread_list;
    11f4:	fa843783          	ld	a5,-88(s0)
    11f8:	02878793          	addi	a5,a5,40
    11fc:	f2f43423          	sd	a5,-216(s0)
            return r;
    1200:	f2843783          	ld	a5,-216(s0)
    1204:	f2f43c23          	sd	a5,-200(s0)
    1208:	f3043783          	ld	a5,-208(s0)
    120c:	f4f43023          	sd	a5,-192(s0)
    1210:	a401                	j	1410 <schedule_edf+0x388>
             // compute allocated time: 
            // 1. a preemption can happen in the future.(need to inspect the release queue)
            // 2. current deadline is met (preemption has not happened)
            // 3. current deadline is missed (current_time + remaining_time > current_deadline)
            // compute the first event that will happen.
            r.scheduled_thread_list_member = &min_th->thread_list;
    1212:	fb043783          	ld	a5,-80(s0)
    1216:	02878793          	addi	a5,a5,40
    121a:	f2f43423          	sd	a5,-216(s0)

            struct release_queue_entry* cur;
            if(list_empty(args.release_queue)){
    121e:	689c                	ld	a5,16(s1)
    1220:	853e                	mv	a0,a5
    1222:	00000097          	auipc	ra,0x0
    1226:	d7c080e7          	jalr	-644(ra) # f9e <list_empty>
    122a:	87aa                	mv	a5,a0
    122c:	c3b5                	beqz	a5,1290 <schedule_edf+0x208>
                // printf("release queue is empty\n");
                // a preemption cannot happen, because we've already selected the highest priority thread.
                int remaining_time = 99999;
    122e:	67e1                	lui	a5,0x18
    1230:	69f78793          	addi	a5,a5,1695 # 1869f <__global_pointer$+0x166bf>
    1234:	f6f42623          	sw	a5,-148(s0)

                int deadline_time = min_th->current_deadline - args.current_time;
    1238:	fb043783          	ld	a5,-80(s0)
    123c:	4bb8                	lw	a4,80(a5)
    123e:	409c                	lw	a5,0(s1)
    1240:	40f707bb          	subw	a5,a4,a5
    1244:	f6f42423          	sw	a5,-152(s0)
                remaining_time = deadline_time<remaining_time? deadline_time: remaining_time;
    1248:	f6842603          	lw	a2,-152(s0)
    124c:	f6c42783          	lw	a5,-148(s0)
    1250:	0007869b          	sext.w	a3,a5
    1254:	0006071b          	sext.w	a4,a2
    1258:	00d75363          	bge	a4,a3,125e <schedule_edf+0x1d6>
    125c:	87b2                	mv	a5,a2
    125e:	f6f42623          	sw	a5,-148(s0)
                int met_time = min_th->remaining_time;
    1262:	fb043783          	ld	a5,-80(s0)
    1266:	47fc                	lw	a5,76(a5)
    1268:	f6f42223          	sw	a5,-156(s0)
                remaining_time = met_time<remaining_time? met_time: remaining_time;
    126c:	f6442603          	lw	a2,-156(s0)
    1270:	f6c42783          	lw	a5,-148(s0)
    1274:	0007869b          	sext.w	a3,a5
    1278:	0006071b          	sext.w	a4,a2
    127c:	00d75363          	bge	a4,a3,1282 <schedule_edf+0x1fa>
    1280:	87b2                	mv	a5,a2
    1282:	f6f42623          	sw	a5,-148(s0)
                r.allocated_time = remaining_time;
    1286:	f6c42783          	lw	a5,-148(s0)
    128a:	f2f42823          	sw	a5,-208(s0)
    128e:	aa8d                	j	1400 <schedule_edf+0x378>
            }else{
                // first check if a preemption can happen
                struct release_queue_entry* cur_min = NULL;
    1290:	f8043c23          	sd	zero,-104(s0)
                int remaining_time = 99999;
    1294:	67e1                	lui	a5,0x18
    1296:	69f78793          	addi	a5,a5,1695 # 1869f <__global_pointer$+0x166bf>
    129a:	f8f42a23          	sw	a5,-108(s0)
                list_for_each_entry(cur, args.release_queue, thread_list) {
    129e:	689c                	ld	a5,16(s1)
    12a0:	639c                	ld	a5,0(a5)
    12a2:	f8f43023          	sd	a5,-128(s0)
    12a6:	f8043783          	ld	a5,-128(s0)
    12aa:	17e1                	addi	a5,a5,-8
    12ac:	faf43023          	sd	a5,-96(s0)
    12b0:	a8d9                	j	1386 <schedule_edf+0x2fe>
                    if((cur->thrd->period + cur->release_time < min_th->current_deadline) && cur->thrd->n != 0){
    12b2:	fa043783          	ld	a5,-96(s0)
    12b6:	639c                	ld	a5,0(a5)
    12b8:	43f8                	lw	a4,68(a5)
    12ba:	fa043783          	ld	a5,-96(s0)
    12be:	4f9c                	lw	a5,24(a5)
    12c0:	9fb9                	addw	a5,a5,a4
    12c2:	0007871b          	sext.w	a4,a5
    12c6:	fb043783          	ld	a5,-80(s0)
    12ca:	4bbc                	lw	a5,80(a5)
    12cc:	0af75363          	bge	a4,a5,1372 <schedule_edf+0x2ea>
    12d0:	fa043783          	ld	a5,-96(s0)
    12d4:	639c                	ld	a5,0(a5)
    12d6:	47bc                	lw	a5,72(a5)
    12d8:	cfc9                	beqz	a5,1372 <schedule_edf+0x2ea>
                        // printf("preemption can occur: %d %d %d\n", cur->thrd->period , cur->release_time , min_th->current_deadline);
                        // a preemption can occur
                        if(cur_min == NULL){
    12da:	f9843783          	ld	a5,-104(s0)
    12de:	e791                	bnez	a5,12ea <schedule_edf+0x262>
                            cur_min = cur;
    12e0:	fa043783          	ld	a5,-96(s0)
    12e4:	f8f43c23          	sd	a5,-104(s0)
    12e8:	a069                	j	1372 <schedule_edf+0x2ea>
                        }else{
                            if((cur->thrd->period + cur->release_time < cur_min->thrd->period + cur_min->release_time)&& cur->thrd->n != 0){
    12ea:	fa043783          	ld	a5,-96(s0)
    12ee:	639c                	ld	a5,0(a5)
    12f0:	43f8                	lw	a4,68(a5)
    12f2:	fa043783          	ld	a5,-96(s0)
    12f6:	4f9c                	lw	a5,24(a5)
    12f8:	9fb9                	addw	a5,a5,a4
    12fa:	0007869b          	sext.w	a3,a5
    12fe:	f9843783          	ld	a5,-104(s0)
    1302:	639c                	ld	a5,0(a5)
    1304:	43f8                	lw	a4,68(a5)
    1306:	f9843783          	ld	a5,-104(s0)
    130a:	4f9c                	lw	a5,24(a5)
    130c:	9fb9                	addw	a5,a5,a4
    130e:	2781                	sext.w	a5,a5
    1310:	8736                	mv	a4,a3
    1312:	00f75c63          	bge	a4,a5,132a <schedule_edf+0x2a2>
    1316:	fa043783          	ld	a5,-96(s0)
    131a:	639c                	ld	a5,0(a5)
    131c:	47bc                	lw	a5,72(a5)
    131e:	c791                	beqz	a5,132a <schedule_edf+0x2a2>
                                cur_min = cur;
    1320:	fa043783          	ld	a5,-96(s0)
    1324:	f8f43c23          	sd	a5,-104(s0)
    1328:	a0a9                	j	1372 <schedule_edf+0x2ea>
                            }else if(cur->thrd->period + cur->release_time == cur_min->thrd->period + cur_min->release_time){
    132a:	fa043783          	ld	a5,-96(s0)
    132e:	639c                	ld	a5,0(a5)
    1330:	43f8                	lw	a4,68(a5)
    1332:	fa043783          	ld	a5,-96(s0)
    1336:	4f9c                	lw	a5,24(a5)
    1338:	9fb9                	addw	a5,a5,a4
    133a:	0007869b          	sext.w	a3,a5
    133e:	f9843783          	ld	a5,-104(s0)
    1342:	639c                	ld	a5,0(a5)
    1344:	43f8                	lw	a4,68(a5)
    1346:	f9843783          	ld	a5,-104(s0)
    134a:	4f9c                	lw	a5,24(a5)
    134c:	9fb9                	addw	a5,a5,a4
    134e:	2781                	sext.w	a5,a5
    1350:	8736                	mv	a4,a3
    1352:	02f71063          	bne	a4,a5,1372 <schedule_edf+0x2ea>
                                if(cur_min->thrd->ID > cur->thrd->ID){
    1356:	f9843783          	ld	a5,-104(s0)
    135a:	639c                	ld	a5,0(a5)
    135c:	5398                	lw	a4,32(a5)
    135e:	fa043783          	ld	a5,-96(s0)
    1362:	639c                	ld	a5,0(a5)
    1364:	539c                	lw	a5,32(a5)
    1366:	00e7d663          	bge	a5,a4,1372 <schedule_edf+0x2ea>
                                    cur_min = cur;
    136a:	fa043783          	ld	a5,-96(s0)
    136e:	f8f43c23          	sd	a5,-104(s0)
                list_for_each_entry(cur, args.release_queue, thread_list) {
    1372:	fa043783          	ld	a5,-96(s0)
    1376:	679c                	ld	a5,8(a5)
    1378:	f6f43823          	sd	a5,-144(s0)
    137c:	f7043783          	ld	a5,-144(s0)
    1380:	17e1                	addi	a5,a5,-8
    1382:	faf43023          	sd	a5,-96(s0)
    1386:	fa043783          	ld	a5,-96(s0)
    138a:	00878713          	addi	a4,a5,8
    138e:	689c                	ld	a5,16(s1)
    1390:	f2f711e3          	bne	a4,a5,12b2 <schedule_edf+0x22a>
                                }
                            }
                        }
                    }
                }
                if(cur_min != NULL){
    1394:	f9843783          	ld	a5,-104(s0)
    1398:	cb89                	beqz	a5,13aa <schedule_edf+0x322>
                    // a preemption is possible
                    remaining_time = cur_min->release_time - args.current_time;
    139a:	f9843783          	ld	a5,-104(s0)
    139e:	4f98                	lw	a4,24(a5)
    13a0:	409c                	lw	a5,0(s1)
    13a2:	40f707bb          	subw	a5,a4,a5
    13a6:	f8f42a23          	sw	a5,-108(s0)
                }
                int deadline_time = min_th->current_deadline - args.current_time;
    13aa:	fb043783          	ld	a5,-80(s0)
    13ae:	4bb8                	lw	a4,80(a5)
    13b0:	409c                	lw	a5,0(s1)
    13b2:	40f707bb          	subw	a5,a4,a5
    13b6:	f6f42e23          	sw	a5,-132(s0)
                remaining_time = deadline_time<remaining_time? deadline_time: remaining_time;
    13ba:	f7c42603          	lw	a2,-132(s0)
    13be:	f9442783          	lw	a5,-108(s0)
    13c2:	0007869b          	sext.w	a3,a5
    13c6:	0006071b          	sext.w	a4,a2
    13ca:	00d75363          	bge	a4,a3,13d0 <schedule_edf+0x348>
    13ce:	87b2                	mv	a5,a2
    13d0:	f8f42a23          	sw	a5,-108(s0)
                int met_time = min_th->remaining_time;
    13d4:	fb043783          	ld	a5,-80(s0)
    13d8:	47fc                	lw	a5,76(a5)
    13da:	f6f42c23          	sw	a5,-136(s0)
                remaining_time = met_time<remaining_time? met_time: remaining_time;
    13de:	f7842603          	lw	a2,-136(s0)
    13e2:	f9442783          	lw	a5,-108(s0)
    13e6:	0007869b          	sext.w	a3,a5
    13ea:	0006071b          	sext.w	a4,a2
    13ee:	00d75363          	bge	a4,a3,13f4 <schedule_edf+0x36c>
    13f2:	87b2                	mv	a5,a2
    13f4:	f8f42a23          	sw	a5,-108(s0)
                r.allocated_time = remaining_time;
    13f8:	f9442783          	lw	a5,-108(s0)
    13fc:	f2f42823          	sw	a5,-208(s0)
            }

            return r;
    1400:	f2843783          	ld	a5,-216(s0)
    1404:	f2f43c23          	sd	a5,-200(s0)
    1408:	f3043783          	ld	a5,-208(s0)
    140c:	f4f43023          	sd	a5,-192(s0)
        }
    }

    return schedule_default(args);
}
    1410:	f3843703          	ld	a4,-200(s0)
    1414:	f4043783          	ld	a5,-192(s0)
    1418:	893a                	mv	s2,a4
    141a:	89be                	mv	s3,a5
    141c:	874a                	mv	a4,s2
    141e:	87ce                	mv	a5,s3
    1420:	853a                	mv	a0,a4
    1422:	85be                	mv	a1,a5
    1424:	60ee                	ld	ra,216(sp)
    1426:	644e                	ld	s0,208(sp)
    1428:	64ae                	ld	s1,200(sp)
    142a:	690e                	ld	s2,192(sp)
    142c:	79ea                	ld	s3,184(sp)
    142e:	612d                	addi	sp,sp,224
    1430:	8082                	ret

0000000000001432 <schedule_rm>:

/* Rate-Monotonic Scheduling */
struct threads_sched_result schedule_rm(struct threads_sched_args args)
{
    1432:	7115                	addi	sp,sp,-224
    1434:	ed86                	sd	ra,216(sp)
    1436:	e9a2                	sd	s0,208(sp)
    1438:	e5a6                	sd	s1,200(sp)
    143a:	e1ca                	sd	s2,192(sp)
    143c:	fd4e                	sd	s3,184(sp)
    143e:	1180                	addi	s0,sp,224
    1440:	84aa                	mv	s1,a0
    
    struct threads_sched_result r;
    if(list_empty(args.run_queue)){
    1442:	649c                	ld	a5,8(s1)
    1444:	853e                	mv	a0,a5
    1446:	00000097          	auipc	ra,0x0
    144a:	b58080e7          	jalr	-1192(ra) # f9e <list_empty>
    144e:	87aa                	mv	a5,a0
    1450:	c3d1                	beqz	a5,14d4 <schedule_rm+0xa2>
        // SPEC 3
        r.scheduled_thread_list_member = args.run_queue;
    1452:	649c                	ld	a5,8(s1)
    1454:	f2f43423          	sd	a5,-216(s0)
        int least_release_time = 99999;
    1458:	67e1                	lui	a5,0x18
    145a:	69f78793          	addi	a5,a5,1695 # 1869f <__global_pointer$+0x166bf>
    145e:	fcf42623          	sw	a5,-52(s0)
        struct release_queue_entry* cur;
        list_for_each_entry(cur, args.release_queue, thread_list) {
    1462:	689c                	ld	a5,16(s1)
    1464:	639c                	ld	a5,0(a5)
    1466:	f4f43823          	sd	a5,-176(s0)
    146a:	f5043783          	ld	a5,-176(s0)
    146e:	17e1                	addi	a5,a5,-8
    1470:	fcf43023          	sd	a5,-64(s0)
    1474:	a805                	j	14a4 <schedule_rm+0x72>
            if(cur->release_time<least_release_time){
    1476:	fc043783          	ld	a5,-64(s0)
    147a:	4f98                	lw	a4,24(a5)
    147c:	fcc42783          	lw	a5,-52(s0)
    1480:	2781                	sext.w	a5,a5
    1482:	00f75763          	bge	a4,a5,1490 <schedule_rm+0x5e>
                least_release_time = cur->release_time;
    1486:	fc043783          	ld	a5,-64(s0)
    148a:	4f9c                	lw	a5,24(a5)
    148c:	fcf42623          	sw	a5,-52(s0)
        list_for_each_entry(cur, args.release_queue, thread_list) {
    1490:	fc043783          	ld	a5,-64(s0)
    1494:	679c                	ld	a5,8(a5)
    1496:	f4f43423          	sd	a5,-184(s0)
    149a:	f4843783          	ld	a5,-184(s0)
    149e:	17e1                	addi	a5,a5,-8
    14a0:	fcf43023          	sd	a5,-64(s0)
    14a4:	fc043783          	ld	a5,-64(s0)
    14a8:	00878713          	addi	a4,a5,8
    14ac:	689c                	ld	a5,16(s1)
    14ae:	fcf714e3          	bne	a4,a5,1476 <schedule_rm+0x44>
            }
        }
        r.allocated_time = least_release_time - args.current_time ;
    14b2:	409c                	lw	a5,0(s1)
    14b4:	fcc42703          	lw	a4,-52(s0)
    14b8:	40f707bb          	subw	a5,a4,a5
    14bc:	2781                	sext.w	a5,a5
    14be:	f2f42823          	sw	a5,-208(s0)
        return r;
    14c2:	f2843783          	ld	a5,-216(s0)
    14c6:	f2f43c23          	sd	a5,-200(s0)
    14ca:	f3043783          	ld	a5,-208(s0)
    14ce:	f4f43023          	sd	a5,-192(s0)
    14d2:	ac61                	j	176a <schedule_rm+0x338>
    }else{
        // run queue is not empty.
        struct thread *th = NULL;
    14d4:	fa043c23          	sd	zero,-72(s0)
        struct thread *min_th = NULL;
    14d8:	fa043823          	sd	zero,-80(s0)
        struct thread *min_miss_deadline_th = NULL;
    14dc:	fa043423          	sd	zero,-88(s0)
        list_for_each_entry(th, args.run_queue, thread_list) {
    14e0:	649c                	ld	a5,8(s1)
    14e2:	639c                	ld	a5,0(a5)
    14e4:	f8f43423          	sd	a5,-120(s0)
    14e8:	f8843783          	ld	a5,-120(s0)
    14ec:	fd878793          	addi	a5,a5,-40
    14f0:	faf43c23          	sd	a5,-72(s0)
    14f4:	a849                	j	1586 <schedule_rm+0x154>
            if(th->current_deadline <= args.current_time){
    14f6:	fb843783          	ld	a5,-72(s0)
    14fa:	4bb8                	lw	a4,80(a5)
    14fc:	409c                	lw	a5,0(s1)
    14fe:	02e7c163          	blt	a5,a4,1520 <schedule_rm+0xee>
                if(min_miss_deadline_th == NULL || th->ID<min_miss_deadline_th->ID){
    1502:	fa843783          	ld	a5,-88(s0)
    1506:	cb89                	beqz	a5,1518 <schedule_rm+0xe6>
    1508:	fb843783          	ld	a5,-72(s0)
    150c:	5398                	lw	a4,32(a5)
    150e:	fa843783          	ld	a5,-88(s0)
    1512:	539c                	lw	a5,32(a5)
    1514:	00f75663          	bge	a4,a5,1520 <schedule_rm+0xee>
                    min_miss_deadline_th = th;
    1518:	fb843783          	ld	a5,-72(s0)
    151c:	faf43423          	sd	a5,-88(s0)
                }
            }
            if(min_th == NULL) min_th = th;
    1520:	fb043783          	ld	a5,-80(s0)
    1524:	e789                	bnez	a5,152e <schedule_rm+0xfc>
    1526:	fb843783          	ld	a5,-72(s0)
    152a:	faf43823          	sd	a5,-80(s0)
            if(th->period<min_th->period){
    152e:	fb843783          	ld	a5,-72(s0)
    1532:	43f8                	lw	a4,68(a5)
    1534:	fb043783          	ld	a5,-80(s0)
    1538:	43fc                	lw	a5,68(a5)
    153a:	00f75763          	bge	a4,a5,1548 <schedule_rm+0x116>
                min_th = th;
    153e:	fb843783          	ld	a5,-72(s0)
    1542:	faf43823          	sd	a5,-80(s0)
    1546:	a02d                	j	1570 <schedule_rm+0x13e>
            }else if(th->period == min_th->period){
    1548:	fb843783          	ld	a5,-72(s0)
    154c:	43f8                	lw	a4,68(a5)
    154e:	fb043783          	ld	a5,-80(s0)
    1552:	43fc                	lw	a5,68(a5)
    1554:	00f71e63          	bne	a4,a5,1570 <schedule_rm+0x13e>
                if(th->ID<min_th->ID) min_th = th;
    1558:	fb843783          	ld	a5,-72(s0)
    155c:	5398                	lw	a4,32(a5)
    155e:	fb043783          	ld	a5,-80(s0)
    1562:	539c                	lw	a5,32(a5)
    1564:	00f75663          	bge	a4,a5,1570 <schedule_rm+0x13e>
    1568:	fb843783          	ld	a5,-72(s0)
    156c:	faf43823          	sd	a5,-80(s0)
        list_for_each_entry(th, args.run_queue, thread_list) {
    1570:	fb843783          	ld	a5,-72(s0)
    1574:	779c                	ld	a5,40(a5)
    1576:	f4f43c23          	sd	a5,-168(s0)
    157a:	f5843783          	ld	a5,-168(s0)
    157e:	fd878793          	addi	a5,a5,-40
    1582:	faf43c23          	sd	a5,-72(s0)
    1586:	fb843783          	ld	a5,-72(s0)
    158a:	02878713          	addi	a4,a5,40
    158e:	649c                	ld	a5,8(s1)
    1590:	f6f713e3          	bne	a4,a5,14f6 <schedule_rm+0xc4>
            }
        }

        if(min_miss_deadline_th != NULL) {
    1594:	fa843783          	ld	a5,-88(s0)
    1598:	c395                	beqz	a5,15bc <schedule_rm+0x18a>
            // SPEC 4: exist missed deadline
            r.allocated_time = 0;
    159a:	f2042823          	sw	zero,-208(s0)
            r.scheduled_thread_list_member = &min_miss_deadline_th->thread_list;
    159e:	fa843783          	ld	a5,-88(s0)
    15a2:	02878793          	addi	a5,a5,40
    15a6:	f2f43423          	sd	a5,-216(s0)
            return r;
    15aa:	f2843783          	ld	a5,-216(s0)
    15ae:	f2f43c23          	sd	a5,-200(s0)
    15b2:	f3043783          	ld	a5,-208(s0)
    15b6:	f4f43023          	sd	a5,-192(s0)
    15ba:	aa45                	j	176a <schedule_rm+0x338>
             // compute allocated time: 
            // 1. a preemption can happen in the future.(need to inspect the release queue)
            // 2. current deadline is met (preemption has not happened)
            // 3. current deadline is missed (current_time + remaining_time > current_deadline)
            // compute the first event that will happen.
            r.scheduled_thread_list_member = &min_th->thread_list;
    15bc:	fb043783          	ld	a5,-80(s0)
    15c0:	02878793          	addi	a5,a5,40
    15c4:	f2f43423          	sd	a5,-216(s0)

            struct release_queue_entry* cur;
            if(list_empty(args.release_queue)){
    15c8:	689c                	ld	a5,16(s1)
    15ca:	853e                	mv	a0,a5
    15cc:	00000097          	auipc	ra,0x0
    15d0:	9d2080e7          	jalr	-1582(ra) # f9e <list_empty>
    15d4:	87aa                	mv	a5,a0
    15d6:	c3b5                	beqz	a5,163a <schedule_rm+0x208>
                // a preemption cannot happen, because we've already selected the highest priority thread.
                int remaining_time = 99999;
    15d8:	67e1                	lui	a5,0x18
    15da:	69f78793          	addi	a5,a5,1695 # 1869f <__global_pointer$+0x166bf>
    15de:	f6f42623          	sw	a5,-148(s0)

                int deadline_time = min_th->current_deadline - args.current_time;
    15e2:	fb043783          	ld	a5,-80(s0)
    15e6:	4bb8                	lw	a4,80(a5)
    15e8:	409c                	lw	a5,0(s1)
    15ea:	40f707bb          	subw	a5,a4,a5
    15ee:	f6f42423          	sw	a5,-152(s0)
                remaining_time = deadline_time<remaining_time? deadline_time: remaining_time;
    15f2:	f6842603          	lw	a2,-152(s0)
    15f6:	f6c42783          	lw	a5,-148(s0)
    15fa:	0007869b          	sext.w	a3,a5
    15fe:	0006071b          	sext.w	a4,a2
    1602:	00d75363          	bge	a4,a3,1608 <schedule_rm+0x1d6>
    1606:	87b2                	mv	a5,a2
    1608:	f6f42623          	sw	a5,-148(s0)
                int met_time = min_th->remaining_time;
    160c:	fb043783          	ld	a5,-80(s0)
    1610:	47fc                	lw	a5,76(a5)
    1612:	f6f42223          	sw	a5,-156(s0)
                remaining_time = met_time<remaining_time? met_time: remaining_time;
    1616:	f6442603          	lw	a2,-156(s0)
    161a:	f6c42783          	lw	a5,-148(s0)
    161e:	0007869b          	sext.w	a3,a5
    1622:	0006071b          	sext.w	a4,a2
    1626:	00d75363          	bge	a4,a3,162c <schedule_rm+0x1fa>
    162a:	87b2                	mv	a5,a2
    162c:	f6f42623          	sw	a5,-148(s0)
                
                r.allocated_time = remaining_time;
    1630:	f6c42783          	lw	a5,-148(s0)
    1634:	f2f42823          	sw	a5,-208(s0)
    1638:	a20d                	j	175a <schedule_rm+0x328>
            }else{
                // first check if a preemption can happen
                struct release_queue_entry* cur_min = NULL;
    163a:	f8043c23          	sd	zero,-104(s0)
                int remaining_time = 99999;
    163e:	67e1                	lui	a5,0x18
    1640:	69f78793          	addi	a5,a5,1695 # 1869f <__global_pointer$+0x166bf>
    1644:	f8f42a23          	sw	a5,-108(s0)
                list_for_each_entry(cur, args.release_queue, thread_list) {
    1648:	689c                	ld	a5,16(s1)
    164a:	639c                	ld	a5,0(a5)
    164c:	f8f43023          	sd	a5,-128(s0)
    1650:	f8043783          	ld	a5,-128(s0)
    1654:	17e1                	addi	a5,a5,-8
    1656:	faf43023          	sd	a5,-96(s0)
    165a:	a059                	j	16e0 <schedule_rm+0x2ae>
                    if(cur->thrd->period<min_th->period){
    165c:	fa043783          	ld	a5,-96(s0)
    1660:	639c                	ld	a5,0(a5)
    1662:	43f8                	lw	a4,68(a5)
    1664:	fb043783          	ld	a5,-80(s0)
    1668:	43fc                	lw	a5,68(a5)
    166a:	06f75163          	bge	a4,a5,16cc <schedule_rm+0x29a>
                        // a preemption can occur
                        if(cur_min == NULL){
    166e:	f9843783          	ld	a5,-104(s0)
    1672:	e791                	bnez	a5,167e <schedule_rm+0x24c>
                            cur_min = cur;
    1674:	fa043783          	ld	a5,-96(s0)
    1678:	f8f43c23          	sd	a5,-104(s0)
    167c:	a881                	j	16cc <schedule_rm+0x29a>
                        }else{
                            if(cur_min->thrd->period>cur->thrd->period){
    167e:	f9843783          	ld	a5,-104(s0)
    1682:	639c                	ld	a5,0(a5)
    1684:	43f8                	lw	a4,68(a5)
    1686:	fa043783          	ld	a5,-96(s0)
    168a:	639c                	ld	a5,0(a5)
    168c:	43fc                	lw	a5,68(a5)
    168e:	00e7d763          	bge	a5,a4,169c <schedule_rm+0x26a>
                                cur_min = cur;
    1692:	fa043783          	ld	a5,-96(s0)
    1696:	f8f43c23          	sd	a5,-104(s0)
    169a:	a80d                	j	16cc <schedule_rm+0x29a>
                            }else if(cur_min->thrd->period == cur->thrd->period){
    169c:	f9843783          	ld	a5,-104(s0)
    16a0:	639c                	ld	a5,0(a5)
    16a2:	43f8                	lw	a4,68(a5)
    16a4:	fa043783          	ld	a5,-96(s0)
    16a8:	639c                	ld	a5,0(a5)
    16aa:	43fc                	lw	a5,68(a5)
    16ac:	02f71063          	bne	a4,a5,16cc <schedule_rm+0x29a>
                                if(cur_min->thrd->ID > cur->thrd->ID){
    16b0:	f9843783          	ld	a5,-104(s0)
    16b4:	639c                	ld	a5,0(a5)
    16b6:	5398                	lw	a4,32(a5)
    16b8:	fa043783          	ld	a5,-96(s0)
    16bc:	639c                	ld	a5,0(a5)
    16be:	539c                	lw	a5,32(a5)
    16c0:	00e7d663          	bge	a5,a4,16cc <schedule_rm+0x29a>
                                    cur_min = cur;
    16c4:	fa043783          	ld	a5,-96(s0)
    16c8:	f8f43c23          	sd	a5,-104(s0)
                list_for_each_entry(cur, args.release_queue, thread_list) {
    16cc:	fa043783          	ld	a5,-96(s0)
    16d0:	679c                	ld	a5,8(a5)
    16d2:	f6f43823          	sd	a5,-144(s0)
    16d6:	f7043783          	ld	a5,-144(s0)
    16da:	17e1                	addi	a5,a5,-8
    16dc:	faf43023          	sd	a5,-96(s0)
    16e0:	fa043783          	ld	a5,-96(s0)
    16e4:	00878713          	addi	a4,a5,8
    16e8:	689c                	ld	a5,16(s1)
    16ea:	f6f719e3          	bne	a4,a5,165c <schedule_rm+0x22a>
                                }
                            }
                        }
                    }
                }
                if(cur_min != NULL){
    16ee:	f9843783          	ld	a5,-104(s0)
    16f2:	cb89                	beqz	a5,1704 <schedule_rm+0x2d2>
                    // a preemption is possible
                    remaining_time = cur_min->release_time - args.current_time;
    16f4:	f9843783          	ld	a5,-104(s0)
    16f8:	4f98                	lw	a4,24(a5)
    16fa:	409c                	lw	a5,0(s1)
    16fc:	40f707bb          	subw	a5,a4,a5
    1700:	f8f42a23          	sw	a5,-108(s0)
                }
                int deadline_time = min_th->current_deadline - args.current_time;
    1704:	fb043783          	ld	a5,-80(s0)
    1708:	4bb8                	lw	a4,80(a5)
    170a:	409c                	lw	a5,0(s1)
    170c:	40f707bb          	subw	a5,a4,a5
    1710:	f6f42e23          	sw	a5,-132(s0)
                remaining_time = deadline_time<remaining_time? deadline_time: remaining_time;
    1714:	f7c42603          	lw	a2,-132(s0)
    1718:	f9442783          	lw	a5,-108(s0)
    171c:	0007869b          	sext.w	a3,a5
    1720:	0006071b          	sext.w	a4,a2
    1724:	00d75363          	bge	a4,a3,172a <schedule_rm+0x2f8>
    1728:	87b2                	mv	a5,a2
    172a:	f8f42a23          	sw	a5,-108(s0)
                int met_time = min_th->remaining_time;
    172e:	fb043783          	ld	a5,-80(s0)
    1732:	47fc                	lw	a5,76(a5)
    1734:	f6f42c23          	sw	a5,-136(s0)
                remaining_time = met_time<remaining_time? met_time: remaining_time;
    1738:	f7842603          	lw	a2,-136(s0)
    173c:	f9442783          	lw	a5,-108(s0)
    1740:	0007869b          	sext.w	a3,a5
    1744:	0006071b          	sext.w	a4,a2
    1748:	00d75363          	bge	a4,a3,174e <schedule_rm+0x31c>
    174c:	87b2                	mv	a5,a2
    174e:	f8f42a23          	sw	a5,-108(s0)
                
                r.allocated_time = remaining_time;
    1752:	f9442783          	lw	a5,-108(s0)
    1756:	f2f42823          	sw	a5,-208(s0)
            }

            return r;
    175a:	f2843783          	ld	a5,-216(s0)
    175e:	f2f43c23          	sd	a5,-200(s0)
    1762:	f3043783          	ld	a5,-208(s0)
    1766:	f4f43023          	sd	a5,-192(s0)
        }
    }
}
    176a:	f3843703          	ld	a4,-200(s0)
    176e:	f4043783          	ld	a5,-192(s0)
    1772:	893a                	mv	s2,a4
    1774:	89be                	mv	s3,a5
    1776:	874a                	mv	a4,s2
    1778:	87ce                	mv	a5,s3
    177a:	853a                	mv	a0,a4
    177c:	85be                	mv	a1,a5
    177e:	60ee                	ld	ra,216(sp)
    1780:	644e                	ld	s0,208(sp)
    1782:	64ae                	ld	s1,200(sp)
    1784:	690e                	ld	s2,192(sp)
    1786:	79ea                	ld	s3,184(sp)
    1788:	612d                	addi	sp,sp,224
    178a:	8082                	ret
