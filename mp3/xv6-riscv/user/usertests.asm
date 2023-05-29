
user/_usertests:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <r_sp>:
  return (x & SSTATUS_SIE) != 0;
}

static inline uint64
r_sp()
{
       0:	1101                	addi	sp,sp,-32
       2:	ec22                	sd	s0,24(sp)
       4:	1000                	addi	s0,sp,32
  uint64 x;
  asm volatile("mv %0, sp" : "=r" (x) );
       6:	878a                	mv	a5,sp
       8:	fef43423          	sd	a5,-24(s0)
  return x;
       c:	fe843783          	ld	a5,-24(s0)
}
      10:	853e                	mv	a0,a5
      12:	6462                	ld	s0,24(sp)
      14:	6105                	addi	sp,sp,32
      16:	8082                	ret

0000000000000018 <copyin>:

// what if you pass ridiculous pointers to system calls
// that read user memory with copyin?
void
copyin(char *s)
{
      18:	715d                	addi	sp,sp,-80
      1a:	e486                	sd	ra,72(sp)
      1c:	e0a2                	sd	s0,64(sp)
      1e:	0880                	addi	s0,sp,80
      20:	faa43c23          	sd	a0,-72(s0)
  uint64 addrs[] = { 0x80000000LL, 0xffffffffffffffff };
      24:	4785                	li	a5,1
      26:	07fe                	slli	a5,a5,0x1f
      28:	fcf43423          	sd	a5,-56(s0)
      2c:	57fd                	li	a5,-1
      2e:	fcf43823          	sd	a5,-48(s0)

  for(int ai = 0; ai < 2; ai++){
      32:	fe042623          	sw	zero,-20(s0)
      36:	a245                	j	1d6 <copyin+0x1be>
    uint64 addr = addrs[ai];
      38:	fec42783          	lw	a5,-20(s0)
      3c:	078e                	slli	a5,a5,0x3
      3e:	ff040713          	addi	a4,s0,-16
      42:	97ba                	add	a5,a5,a4
      44:	fd87b783          	ld	a5,-40(a5)
      48:	fef43023          	sd	a5,-32(s0)
    
    int fd = open("copyin1", O_CREATE|O_WRONLY);
      4c:	20100593          	li	a1,513
      50:	00008517          	auipc	a0,0x8
      54:	42850513          	addi	a0,a0,1064 # 8478 <schedule_rm+0x67e>
      58:	00007097          	auipc	ra,0x7
      5c:	062080e7          	jalr	98(ra) # 70ba <open>
      60:	87aa                	mv	a5,a0
      62:	fcf42e23          	sw	a5,-36(s0)
    if(fd < 0){
      66:	fdc42783          	lw	a5,-36(s0)
      6a:	2781                	sext.w	a5,a5
      6c:	0007df63          	bgez	a5,8a <copyin+0x72>
      printf("open(copyin1) failed\n");
      70:	00008517          	auipc	a0,0x8
      74:	41050513          	addi	a0,a0,1040 # 8480 <schedule_rm+0x686>
      78:	00007097          	auipc	ra,0x7
      7c:	548080e7          	jalr	1352(ra) # 75c0 <printf>
      exit(1);
      80:	4505                	li	a0,1
      82:	00007097          	auipc	ra,0x7
      86:	ff8080e7          	jalr	-8(ra) # 707a <exit>
    }
    int n = write(fd, (void*)addr, 8192);
      8a:	fe043703          	ld	a4,-32(s0)
      8e:	fdc42783          	lw	a5,-36(s0)
      92:	6609                	lui	a2,0x2
      94:	85ba                	mv	a1,a4
      96:	853e                	mv	a0,a5
      98:	00007097          	auipc	ra,0x7
      9c:	002080e7          	jalr	2(ra) # 709a <write>
      a0:	87aa                	mv	a5,a0
      a2:	fcf42c23          	sw	a5,-40(s0)
    if(n >= 0){
      a6:	fd842783          	lw	a5,-40(s0)
      aa:	2781                	sext.w	a5,a5
      ac:	0207c463          	bltz	a5,d4 <copyin+0xbc>
      printf("write(fd, %p, 8192) returned %d, not -1\n", addr, n);
      b0:	fd842783          	lw	a5,-40(s0)
      b4:	863e                	mv	a2,a5
      b6:	fe043583          	ld	a1,-32(s0)
      ba:	00008517          	auipc	a0,0x8
      be:	3de50513          	addi	a0,a0,990 # 8498 <schedule_rm+0x69e>
      c2:	00007097          	auipc	ra,0x7
      c6:	4fe080e7          	jalr	1278(ra) # 75c0 <printf>
      exit(1);
      ca:	4505                	li	a0,1
      cc:	00007097          	auipc	ra,0x7
      d0:	fae080e7          	jalr	-82(ra) # 707a <exit>
    }
    close(fd);
      d4:	fdc42783          	lw	a5,-36(s0)
      d8:	853e                	mv	a0,a5
      da:	00007097          	auipc	ra,0x7
      de:	fc8080e7          	jalr	-56(ra) # 70a2 <close>
    unlink("copyin1");
      e2:	00008517          	auipc	a0,0x8
      e6:	39650513          	addi	a0,a0,918 # 8478 <schedule_rm+0x67e>
      ea:	00007097          	auipc	ra,0x7
      ee:	fe0080e7          	jalr	-32(ra) # 70ca <unlink>
    
    n = write(1, (char*)addr, 8192);
      f2:	fe043783          	ld	a5,-32(s0)
      f6:	6609                	lui	a2,0x2
      f8:	85be                	mv	a1,a5
      fa:	4505                	li	a0,1
      fc:	00007097          	auipc	ra,0x7
     100:	f9e080e7          	jalr	-98(ra) # 709a <write>
     104:	87aa                	mv	a5,a0
     106:	fcf42c23          	sw	a5,-40(s0)
    if(n > 0){
     10a:	fd842783          	lw	a5,-40(s0)
     10e:	2781                	sext.w	a5,a5
     110:	02f05463          	blez	a5,138 <copyin+0x120>
      printf("write(1, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     114:	fd842783          	lw	a5,-40(s0)
     118:	863e                	mv	a2,a5
     11a:	fe043583          	ld	a1,-32(s0)
     11e:	00008517          	auipc	a0,0x8
     122:	3aa50513          	addi	a0,a0,938 # 84c8 <schedule_rm+0x6ce>
     126:	00007097          	auipc	ra,0x7
     12a:	49a080e7          	jalr	1178(ra) # 75c0 <printf>
      exit(1);
     12e:	4505                	li	a0,1
     130:	00007097          	auipc	ra,0x7
     134:	f4a080e7          	jalr	-182(ra) # 707a <exit>
    }
    
    int fds[2];
    if(pipe(fds) < 0){
     138:	fc040793          	addi	a5,s0,-64
     13c:	853e                	mv	a0,a5
     13e:	00007097          	auipc	ra,0x7
     142:	f4c080e7          	jalr	-180(ra) # 708a <pipe>
     146:	87aa                	mv	a5,a0
     148:	0007df63          	bgez	a5,166 <copyin+0x14e>
      printf("pipe() failed\n");
     14c:	00008517          	auipc	a0,0x8
     150:	3ac50513          	addi	a0,a0,940 # 84f8 <schedule_rm+0x6fe>
     154:	00007097          	auipc	ra,0x7
     158:	46c080e7          	jalr	1132(ra) # 75c0 <printf>
      exit(1);
     15c:	4505                	li	a0,1
     15e:	00007097          	auipc	ra,0x7
     162:	f1c080e7          	jalr	-228(ra) # 707a <exit>
    }
    n = write(fds[1], (char*)addr, 8192);
     166:	fc442783          	lw	a5,-60(s0)
     16a:	fe043703          	ld	a4,-32(s0)
     16e:	6609                	lui	a2,0x2
     170:	85ba                	mv	a1,a4
     172:	853e                	mv	a0,a5
     174:	00007097          	auipc	ra,0x7
     178:	f26080e7          	jalr	-218(ra) # 709a <write>
     17c:	87aa                	mv	a5,a0
     17e:	fcf42c23          	sw	a5,-40(s0)
    if(n > 0){
     182:	fd842783          	lw	a5,-40(s0)
     186:	2781                	sext.w	a5,a5
     188:	02f05463          	blez	a5,1b0 <copyin+0x198>
      printf("write(pipe, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     18c:	fd842783          	lw	a5,-40(s0)
     190:	863e                	mv	a2,a5
     192:	fe043583          	ld	a1,-32(s0)
     196:	00008517          	auipc	a0,0x8
     19a:	37250513          	addi	a0,a0,882 # 8508 <schedule_rm+0x70e>
     19e:	00007097          	auipc	ra,0x7
     1a2:	422080e7          	jalr	1058(ra) # 75c0 <printf>
      exit(1);
     1a6:	4505                	li	a0,1
     1a8:	00007097          	auipc	ra,0x7
     1ac:	ed2080e7          	jalr	-302(ra) # 707a <exit>
    }
    close(fds[0]);
     1b0:	fc042783          	lw	a5,-64(s0)
     1b4:	853e                	mv	a0,a5
     1b6:	00007097          	auipc	ra,0x7
     1ba:	eec080e7          	jalr	-276(ra) # 70a2 <close>
    close(fds[1]);
     1be:	fc442783          	lw	a5,-60(s0)
     1c2:	853e                	mv	a0,a5
     1c4:	00007097          	auipc	ra,0x7
     1c8:	ede080e7          	jalr	-290(ra) # 70a2 <close>
  for(int ai = 0; ai < 2; ai++){
     1cc:	fec42783          	lw	a5,-20(s0)
     1d0:	2785                	addiw	a5,a5,1
     1d2:	fef42623          	sw	a5,-20(s0)
     1d6:	fec42783          	lw	a5,-20(s0)
     1da:	0007871b          	sext.w	a4,a5
     1de:	4785                	li	a5,1
     1e0:	e4e7dce3          	bge	a5,a4,38 <copyin+0x20>
  }
}
     1e4:	0001                	nop
     1e6:	0001                	nop
     1e8:	60a6                	ld	ra,72(sp)
     1ea:	6406                	ld	s0,64(sp)
     1ec:	6161                	addi	sp,sp,80
     1ee:	8082                	ret

00000000000001f0 <copyout>:

// what if you pass ridiculous pointers to system calls
// that write user memory with copyout?
void
copyout(char *s)
{
     1f0:	715d                	addi	sp,sp,-80
     1f2:	e486                	sd	ra,72(sp)
     1f4:	e0a2                	sd	s0,64(sp)
     1f6:	0880                	addi	s0,sp,80
     1f8:	faa43c23          	sd	a0,-72(s0)
  uint64 addrs[] = { 0x80000000LL, 0xffffffffffffffff };
     1fc:	4785                	li	a5,1
     1fe:	07fe                	slli	a5,a5,0x1f
     200:	fcf43423          	sd	a5,-56(s0)
     204:	57fd                	li	a5,-1
     206:	fcf43823          	sd	a5,-48(s0)

  for(int ai = 0; ai < 2; ai++){
     20a:	fe042623          	sw	zero,-20(s0)
     20e:	a279                	j	39c <copyout+0x1ac>
    uint64 addr = addrs[ai];
     210:	fec42783          	lw	a5,-20(s0)
     214:	078e                	slli	a5,a5,0x3
     216:	ff040713          	addi	a4,s0,-16
     21a:	97ba                	add	a5,a5,a4
     21c:	fd87b783          	ld	a5,-40(a5)
     220:	fef43023          	sd	a5,-32(s0)

    int fd = open("README", 0);
     224:	4581                	li	a1,0
     226:	00008517          	auipc	a0,0x8
     22a:	31250513          	addi	a0,a0,786 # 8538 <schedule_rm+0x73e>
     22e:	00007097          	auipc	ra,0x7
     232:	e8c080e7          	jalr	-372(ra) # 70ba <open>
     236:	87aa                	mv	a5,a0
     238:	fcf42e23          	sw	a5,-36(s0)
    if(fd < 0){
     23c:	fdc42783          	lw	a5,-36(s0)
     240:	2781                	sext.w	a5,a5
     242:	0007df63          	bgez	a5,260 <copyout+0x70>
      printf("open(README) failed\n");
     246:	00008517          	auipc	a0,0x8
     24a:	2fa50513          	addi	a0,a0,762 # 8540 <schedule_rm+0x746>
     24e:	00007097          	auipc	ra,0x7
     252:	372080e7          	jalr	882(ra) # 75c0 <printf>
      exit(1);
     256:	4505                	li	a0,1
     258:	00007097          	auipc	ra,0x7
     25c:	e22080e7          	jalr	-478(ra) # 707a <exit>
    }
    int n = read(fd, (void*)addr, 8192);
     260:	fe043703          	ld	a4,-32(s0)
     264:	fdc42783          	lw	a5,-36(s0)
     268:	6609                	lui	a2,0x2
     26a:	85ba                	mv	a1,a4
     26c:	853e                	mv	a0,a5
     26e:	00007097          	auipc	ra,0x7
     272:	e24080e7          	jalr	-476(ra) # 7092 <read>
     276:	87aa                	mv	a5,a0
     278:	fcf42c23          	sw	a5,-40(s0)
    if(n > 0){
     27c:	fd842783          	lw	a5,-40(s0)
     280:	2781                	sext.w	a5,a5
     282:	02f05463          	blez	a5,2aa <copyout+0xba>
      printf("read(fd, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     286:	fd842783          	lw	a5,-40(s0)
     28a:	863e                	mv	a2,a5
     28c:	fe043583          	ld	a1,-32(s0)
     290:	00008517          	auipc	a0,0x8
     294:	2c850513          	addi	a0,a0,712 # 8558 <schedule_rm+0x75e>
     298:	00007097          	auipc	ra,0x7
     29c:	328080e7          	jalr	808(ra) # 75c0 <printf>
      exit(1);
     2a0:	4505                	li	a0,1
     2a2:	00007097          	auipc	ra,0x7
     2a6:	dd8080e7          	jalr	-552(ra) # 707a <exit>
    }
    close(fd);
     2aa:	fdc42783          	lw	a5,-36(s0)
     2ae:	853e                	mv	a0,a5
     2b0:	00007097          	auipc	ra,0x7
     2b4:	df2080e7          	jalr	-526(ra) # 70a2 <close>

    int fds[2];
    if(pipe(fds) < 0){
     2b8:	fc040793          	addi	a5,s0,-64
     2bc:	853e                	mv	a0,a5
     2be:	00007097          	auipc	ra,0x7
     2c2:	dcc080e7          	jalr	-564(ra) # 708a <pipe>
     2c6:	87aa                	mv	a5,a0
     2c8:	0007df63          	bgez	a5,2e6 <copyout+0xf6>
      printf("pipe() failed\n");
     2cc:	00008517          	auipc	a0,0x8
     2d0:	22c50513          	addi	a0,a0,556 # 84f8 <schedule_rm+0x6fe>
     2d4:	00007097          	auipc	ra,0x7
     2d8:	2ec080e7          	jalr	748(ra) # 75c0 <printf>
      exit(1);
     2dc:	4505                	li	a0,1
     2de:	00007097          	auipc	ra,0x7
     2e2:	d9c080e7          	jalr	-612(ra) # 707a <exit>
    }
    n = write(fds[1], "x", 1);
     2e6:	fc442783          	lw	a5,-60(s0)
     2ea:	4605                	li	a2,1
     2ec:	00008597          	auipc	a1,0x8
     2f0:	29c58593          	addi	a1,a1,668 # 8588 <schedule_rm+0x78e>
     2f4:	853e                	mv	a0,a5
     2f6:	00007097          	auipc	ra,0x7
     2fa:	da4080e7          	jalr	-604(ra) # 709a <write>
     2fe:	87aa                	mv	a5,a0
     300:	fcf42c23          	sw	a5,-40(s0)
    if(n != 1){
     304:	fd842783          	lw	a5,-40(s0)
     308:	0007871b          	sext.w	a4,a5
     30c:	4785                	li	a5,1
     30e:	00f70f63          	beq	a4,a5,32c <copyout+0x13c>
      printf("pipe write failed\n");
     312:	00008517          	auipc	a0,0x8
     316:	27e50513          	addi	a0,a0,638 # 8590 <schedule_rm+0x796>
     31a:	00007097          	auipc	ra,0x7
     31e:	2a6080e7          	jalr	678(ra) # 75c0 <printf>
      exit(1);
     322:	4505                	li	a0,1
     324:	00007097          	auipc	ra,0x7
     328:	d56080e7          	jalr	-682(ra) # 707a <exit>
    }
    n = read(fds[0], (void*)addr, 8192);
     32c:	fc042783          	lw	a5,-64(s0)
     330:	fe043703          	ld	a4,-32(s0)
     334:	6609                	lui	a2,0x2
     336:	85ba                	mv	a1,a4
     338:	853e                	mv	a0,a5
     33a:	00007097          	auipc	ra,0x7
     33e:	d58080e7          	jalr	-680(ra) # 7092 <read>
     342:	87aa                	mv	a5,a0
     344:	fcf42c23          	sw	a5,-40(s0)
    if(n > 0){
     348:	fd842783          	lw	a5,-40(s0)
     34c:	2781                	sext.w	a5,a5
     34e:	02f05463          	blez	a5,376 <copyout+0x186>
      printf("read(pipe, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     352:	fd842783          	lw	a5,-40(s0)
     356:	863e                	mv	a2,a5
     358:	fe043583          	ld	a1,-32(s0)
     35c:	00008517          	auipc	a0,0x8
     360:	24c50513          	addi	a0,a0,588 # 85a8 <schedule_rm+0x7ae>
     364:	00007097          	auipc	ra,0x7
     368:	25c080e7          	jalr	604(ra) # 75c0 <printf>
      exit(1);
     36c:	4505                	li	a0,1
     36e:	00007097          	auipc	ra,0x7
     372:	d0c080e7          	jalr	-756(ra) # 707a <exit>
    }
    close(fds[0]);
     376:	fc042783          	lw	a5,-64(s0)
     37a:	853e                	mv	a0,a5
     37c:	00007097          	auipc	ra,0x7
     380:	d26080e7          	jalr	-730(ra) # 70a2 <close>
    close(fds[1]);
     384:	fc442783          	lw	a5,-60(s0)
     388:	853e                	mv	a0,a5
     38a:	00007097          	auipc	ra,0x7
     38e:	d18080e7          	jalr	-744(ra) # 70a2 <close>
  for(int ai = 0; ai < 2; ai++){
     392:	fec42783          	lw	a5,-20(s0)
     396:	2785                	addiw	a5,a5,1
     398:	fef42623          	sw	a5,-20(s0)
     39c:	fec42783          	lw	a5,-20(s0)
     3a0:	0007871b          	sext.w	a4,a5
     3a4:	4785                	li	a5,1
     3a6:	e6e7d5e3          	bge	a5,a4,210 <copyout+0x20>
  }
}
     3aa:	0001                	nop
     3ac:	0001                	nop
     3ae:	60a6                	ld	ra,72(sp)
     3b0:	6406                	ld	s0,64(sp)
     3b2:	6161                	addi	sp,sp,80
     3b4:	8082                	ret

00000000000003b6 <copyinstr1>:

// what if you pass ridiculous string pointers to system calls?
void
copyinstr1(char *s)
{
     3b6:	715d                	addi	sp,sp,-80
     3b8:	e486                	sd	ra,72(sp)
     3ba:	e0a2                	sd	s0,64(sp)
     3bc:	0880                	addi	s0,sp,80
     3be:	faa43c23          	sd	a0,-72(s0)
  uint64 addrs[] = { 0x80000000LL, 0xffffffffffffffff };
     3c2:	4785                	li	a5,1
     3c4:	07fe                	slli	a5,a5,0x1f
     3c6:	fcf43423          	sd	a5,-56(s0)
     3ca:	57fd                	li	a5,-1
     3cc:	fcf43823          	sd	a5,-48(s0)

  for(int ai = 0; ai < 2; ai++){
     3d0:	fe042623          	sw	zero,-20(s0)
     3d4:	a09d                	j	43a <copyinstr1+0x84>
    uint64 addr = addrs[ai];
     3d6:	fec42783          	lw	a5,-20(s0)
     3da:	078e                	slli	a5,a5,0x3
     3dc:	ff040713          	addi	a4,s0,-16
     3e0:	97ba                	add	a5,a5,a4
     3e2:	fd87b783          	ld	a5,-40(a5)
     3e6:	fef43023          	sd	a5,-32(s0)

    int fd = open((char *)addr, O_CREATE|O_WRONLY);
     3ea:	fe043783          	ld	a5,-32(s0)
     3ee:	20100593          	li	a1,513
     3f2:	853e                	mv	a0,a5
     3f4:	00007097          	auipc	ra,0x7
     3f8:	cc6080e7          	jalr	-826(ra) # 70ba <open>
     3fc:	87aa                	mv	a5,a0
     3fe:	fcf42e23          	sw	a5,-36(s0)
    if(fd >= 0){
     402:	fdc42783          	lw	a5,-36(s0)
     406:	2781                	sext.w	a5,a5
     408:	0207c463          	bltz	a5,430 <copyinstr1+0x7a>
      printf("open(%p) returned %d, not -1\n", addr, fd);
     40c:	fdc42783          	lw	a5,-36(s0)
     410:	863e                	mv	a2,a5
     412:	fe043583          	ld	a1,-32(s0)
     416:	00008517          	auipc	a0,0x8
     41a:	1c250513          	addi	a0,a0,450 # 85d8 <schedule_rm+0x7de>
     41e:	00007097          	auipc	ra,0x7
     422:	1a2080e7          	jalr	418(ra) # 75c0 <printf>
      exit(1);
     426:	4505                	li	a0,1
     428:	00007097          	auipc	ra,0x7
     42c:	c52080e7          	jalr	-942(ra) # 707a <exit>
  for(int ai = 0; ai < 2; ai++){
     430:	fec42783          	lw	a5,-20(s0)
     434:	2785                	addiw	a5,a5,1
     436:	fef42623          	sw	a5,-20(s0)
     43a:	fec42783          	lw	a5,-20(s0)
     43e:	0007871b          	sext.w	a4,a5
     442:	4785                	li	a5,1
     444:	f8e7d9e3          	bge	a5,a4,3d6 <copyinstr1+0x20>
    }
  }
}
     448:	0001                	nop
     44a:	0001                	nop
     44c:	60a6                	ld	ra,72(sp)
     44e:	6406                	ld	s0,64(sp)
     450:	6161                	addi	sp,sp,80
     452:	8082                	ret

0000000000000454 <copyinstr2>:
// what if a string system call argument is exactly the size
// of the kernel buffer it is copied into, so that the null
// would fall just beyond the end of the kernel buffer?
void
copyinstr2(char *s)
{
     454:	7151                	addi	sp,sp,-240
     456:	f586                	sd	ra,232(sp)
     458:	f1a2                	sd	s0,224(sp)
     45a:	1980                	addi	s0,sp,240
     45c:	f0a43c23          	sd	a0,-232(s0)
  char b[MAXPATH+1];

  for(int i = 0; i < MAXPATH; i++)
     460:	fe042623          	sw	zero,-20(s0)
     464:	a839                	j	482 <copyinstr2+0x2e>
    b[i] = 'x';
     466:	fec42783          	lw	a5,-20(s0)
     46a:	ff040713          	addi	a4,s0,-16
     46e:	97ba                	add	a5,a5,a4
     470:	07800713          	li	a4,120
     474:	f6e78423          	sb	a4,-152(a5)
  for(int i = 0; i < MAXPATH; i++)
     478:	fec42783          	lw	a5,-20(s0)
     47c:	2785                	addiw	a5,a5,1
     47e:	fef42623          	sw	a5,-20(s0)
     482:	fec42783          	lw	a5,-20(s0)
     486:	0007871b          	sext.w	a4,a5
     48a:	07f00793          	li	a5,127
     48e:	fce7dce3          	bge	a5,a4,466 <copyinstr2+0x12>
  b[MAXPATH] = '\0';
     492:	fc040c23          	sb	zero,-40(s0)
  
  int ret = unlink(b);
     496:	f5840793          	addi	a5,s0,-168
     49a:	853e                	mv	a0,a5
     49c:	00007097          	auipc	ra,0x7
     4a0:	c2e080e7          	jalr	-978(ra) # 70ca <unlink>
     4a4:	87aa                	mv	a5,a0
     4a6:	fef42223          	sw	a5,-28(s0)
  if(ret != -1){
     4aa:	fe442783          	lw	a5,-28(s0)
     4ae:	0007871b          	sext.w	a4,a5
     4b2:	57fd                	li	a5,-1
     4b4:	02f70563          	beq	a4,a5,4de <copyinstr2+0x8a>
    printf("unlink(%s) returned %d, not -1\n", b, ret);
     4b8:	fe442703          	lw	a4,-28(s0)
     4bc:	f5840793          	addi	a5,s0,-168
     4c0:	863a                	mv	a2,a4
     4c2:	85be                	mv	a1,a5
     4c4:	00008517          	auipc	a0,0x8
     4c8:	13450513          	addi	a0,a0,308 # 85f8 <schedule_rm+0x7fe>
     4cc:	00007097          	auipc	ra,0x7
     4d0:	0f4080e7          	jalr	244(ra) # 75c0 <printf>
    exit(1);
     4d4:	4505                	li	a0,1
     4d6:	00007097          	auipc	ra,0x7
     4da:	ba4080e7          	jalr	-1116(ra) # 707a <exit>
  }

  int fd = open(b, O_CREATE | O_WRONLY);
     4de:	f5840793          	addi	a5,s0,-168
     4e2:	20100593          	li	a1,513
     4e6:	853e                	mv	a0,a5
     4e8:	00007097          	auipc	ra,0x7
     4ec:	bd2080e7          	jalr	-1070(ra) # 70ba <open>
     4f0:	87aa                	mv	a5,a0
     4f2:	fef42023          	sw	a5,-32(s0)
  if(fd != -1){
     4f6:	fe042783          	lw	a5,-32(s0)
     4fa:	0007871b          	sext.w	a4,a5
     4fe:	57fd                	li	a5,-1
     500:	02f70563          	beq	a4,a5,52a <copyinstr2+0xd6>
    printf("open(%s) returned %d, not -1\n", b, fd);
     504:	fe042703          	lw	a4,-32(s0)
     508:	f5840793          	addi	a5,s0,-168
     50c:	863a                	mv	a2,a4
     50e:	85be                	mv	a1,a5
     510:	00008517          	auipc	a0,0x8
     514:	10850513          	addi	a0,a0,264 # 8618 <schedule_rm+0x81e>
     518:	00007097          	auipc	ra,0x7
     51c:	0a8080e7          	jalr	168(ra) # 75c0 <printf>
    exit(1);
     520:	4505                	li	a0,1
     522:	00007097          	auipc	ra,0x7
     526:	b58080e7          	jalr	-1192(ra) # 707a <exit>
  }

  ret = link(b, b);
     52a:	f5840713          	addi	a4,s0,-168
     52e:	f5840793          	addi	a5,s0,-168
     532:	85ba                	mv	a1,a4
     534:	853e                	mv	a0,a5
     536:	00007097          	auipc	ra,0x7
     53a:	ba4080e7          	jalr	-1116(ra) # 70da <link>
     53e:	87aa                	mv	a5,a0
     540:	fef42223          	sw	a5,-28(s0)
  if(ret != -1){
     544:	fe442783          	lw	a5,-28(s0)
     548:	0007871b          	sext.w	a4,a5
     54c:	57fd                	li	a5,-1
     54e:	02f70763          	beq	a4,a5,57c <copyinstr2+0x128>
    printf("link(%s, %s) returned %d, not -1\n", b, b, ret);
     552:	fe442683          	lw	a3,-28(s0)
     556:	f5840713          	addi	a4,s0,-168
     55a:	f5840793          	addi	a5,s0,-168
     55e:	863a                	mv	a2,a4
     560:	85be                	mv	a1,a5
     562:	00008517          	auipc	a0,0x8
     566:	0d650513          	addi	a0,a0,214 # 8638 <schedule_rm+0x83e>
     56a:	00007097          	auipc	ra,0x7
     56e:	056080e7          	jalr	86(ra) # 75c0 <printf>
    exit(1);
     572:	4505                	li	a0,1
     574:	00007097          	auipc	ra,0x7
     578:	b06080e7          	jalr	-1274(ra) # 707a <exit>
  }

  char *args[] = { "xx", 0 };
     57c:	00008797          	auipc	a5,0x8
     580:	0e478793          	addi	a5,a5,228 # 8660 <schedule_rm+0x866>
     584:	f4f43423          	sd	a5,-184(s0)
     588:	f4043823          	sd	zero,-176(s0)
  ret = exec(b, args);
     58c:	f4840713          	addi	a4,s0,-184
     590:	f5840793          	addi	a5,s0,-168
     594:	85ba                	mv	a1,a4
     596:	853e                	mv	a0,a5
     598:	00007097          	auipc	ra,0x7
     59c:	b1a080e7          	jalr	-1254(ra) # 70b2 <exec>
     5a0:	87aa                	mv	a5,a0
     5a2:	fef42223          	sw	a5,-28(s0)
  if(ret != -1){
     5a6:	fe442783          	lw	a5,-28(s0)
     5aa:	0007871b          	sext.w	a4,a5
     5ae:	57fd                	li	a5,-1
     5b0:	02f70563          	beq	a4,a5,5da <copyinstr2+0x186>
    printf("exec(%s) returned %d, not -1\n", b, fd);
     5b4:	fe042703          	lw	a4,-32(s0)
     5b8:	f5840793          	addi	a5,s0,-168
     5bc:	863a                	mv	a2,a4
     5be:	85be                	mv	a1,a5
     5c0:	00008517          	auipc	a0,0x8
     5c4:	0a850513          	addi	a0,a0,168 # 8668 <schedule_rm+0x86e>
     5c8:	00007097          	auipc	ra,0x7
     5cc:	ff8080e7          	jalr	-8(ra) # 75c0 <printf>
    exit(1);
     5d0:	4505                	li	a0,1
     5d2:	00007097          	auipc	ra,0x7
     5d6:	aa8080e7          	jalr	-1368(ra) # 707a <exit>
  }

  int pid = fork();
     5da:	00007097          	auipc	ra,0x7
     5de:	a98080e7          	jalr	-1384(ra) # 7072 <fork>
     5e2:	87aa                	mv	a5,a0
     5e4:	fcf42e23          	sw	a5,-36(s0)
  if(pid < 0){
     5e8:	fdc42783          	lw	a5,-36(s0)
     5ec:	2781                	sext.w	a5,a5
     5ee:	0007df63          	bgez	a5,60c <copyinstr2+0x1b8>
    printf("fork failed\n");
     5f2:	00008517          	auipc	a0,0x8
     5f6:	09650513          	addi	a0,a0,150 # 8688 <schedule_rm+0x88e>
     5fa:	00007097          	auipc	ra,0x7
     5fe:	fc6080e7          	jalr	-58(ra) # 75c0 <printf>
    exit(1);
     602:	4505                	li	a0,1
     604:	00007097          	auipc	ra,0x7
     608:	a76080e7          	jalr	-1418(ra) # 707a <exit>
  }
  if(pid == 0){
     60c:	fdc42783          	lw	a5,-36(s0)
     610:	2781                	sext.w	a5,a5
     612:	efd5                	bnez	a5,6ce <copyinstr2+0x27a>
    static char big[PGSIZE+1];
    for(int i = 0; i < PGSIZE; i++)
     614:	fe042423          	sw	zero,-24(s0)
     618:	a00d                	j	63a <copyinstr2+0x1e6>
      big[i] = 'x';
     61a:	00010717          	auipc	a4,0x10
     61e:	9f670713          	addi	a4,a4,-1546 # 10010 <big.0>
     622:	fe842783          	lw	a5,-24(s0)
     626:	97ba                	add	a5,a5,a4
     628:	07800713          	li	a4,120
     62c:	00e78023          	sb	a4,0(a5)
    for(int i = 0; i < PGSIZE; i++)
     630:	fe842783          	lw	a5,-24(s0)
     634:	2785                	addiw	a5,a5,1
     636:	fef42423          	sw	a5,-24(s0)
     63a:	fe842783          	lw	a5,-24(s0)
     63e:	0007871b          	sext.w	a4,a5
     642:	6785                	lui	a5,0x1
     644:	fcf74be3          	blt	a4,a5,61a <copyinstr2+0x1c6>
    big[PGSIZE] = '\0';
     648:	00010717          	auipc	a4,0x10
     64c:	9c870713          	addi	a4,a4,-1592 # 10010 <big.0>
     650:	6785                	lui	a5,0x1
     652:	97ba                	add	a5,a5,a4
     654:	00078023          	sb	zero,0(a5) # 1000 <truncate3+0x1aa>
    char *args2[] = { big, big, big, 0 };
     658:	00008797          	auipc	a5,0x8
     65c:	0a078793          	addi	a5,a5,160 # 86f8 <schedule_rm+0x8fe>
     660:	6390                	ld	a2,0(a5)
     662:	6794                	ld	a3,8(a5)
     664:	6b98                	ld	a4,16(a5)
     666:	6f9c                	ld	a5,24(a5)
     668:	f2c43023          	sd	a2,-224(s0)
     66c:	f2d43423          	sd	a3,-216(s0)
     670:	f2e43823          	sd	a4,-208(s0)
     674:	f2f43c23          	sd	a5,-200(s0)
    ret = exec("echo", args2);
     678:	f2040793          	addi	a5,s0,-224
     67c:	85be                	mv	a1,a5
     67e:	00008517          	auipc	a0,0x8
     682:	01a50513          	addi	a0,a0,26 # 8698 <schedule_rm+0x89e>
     686:	00007097          	auipc	ra,0x7
     68a:	a2c080e7          	jalr	-1492(ra) # 70b2 <exec>
     68e:	87aa                	mv	a5,a0
     690:	fef42223          	sw	a5,-28(s0)
    if(ret != -1){
     694:	fe442783          	lw	a5,-28(s0)
     698:	0007871b          	sext.w	a4,a5
     69c:	57fd                	li	a5,-1
     69e:	02f70263          	beq	a4,a5,6c2 <copyinstr2+0x26e>
      printf("exec(echo, BIG) returned %d, not -1\n", fd);
     6a2:	fe042783          	lw	a5,-32(s0)
     6a6:	85be                	mv	a1,a5
     6a8:	00008517          	auipc	a0,0x8
     6ac:	ff850513          	addi	a0,a0,-8 # 86a0 <schedule_rm+0x8a6>
     6b0:	00007097          	auipc	ra,0x7
     6b4:	f10080e7          	jalr	-240(ra) # 75c0 <printf>
      exit(1);
     6b8:	4505                	li	a0,1
     6ba:	00007097          	auipc	ra,0x7
     6be:	9c0080e7          	jalr	-1600(ra) # 707a <exit>
    }
    exit(747); // OK
     6c2:	2eb00513          	li	a0,747
     6c6:	00007097          	auipc	ra,0x7
     6ca:	9b4080e7          	jalr	-1612(ra) # 707a <exit>
  }

  int st = 0;
     6ce:	f4042223          	sw	zero,-188(s0)
  wait(&st);
     6d2:	f4440793          	addi	a5,s0,-188
     6d6:	853e                	mv	a0,a5
     6d8:	00007097          	auipc	ra,0x7
     6dc:	9aa080e7          	jalr	-1622(ra) # 7082 <wait>
  if(st != 747){
     6e0:	f4442783          	lw	a5,-188(s0)
     6e4:	873e                	mv	a4,a5
     6e6:	2eb00793          	li	a5,747
     6ea:	00f70f63          	beq	a4,a5,708 <copyinstr2+0x2b4>
    printf("exec(echo, BIG) succeeded, should have failed\n");
     6ee:	00008517          	auipc	a0,0x8
     6f2:	fda50513          	addi	a0,a0,-38 # 86c8 <schedule_rm+0x8ce>
     6f6:	00007097          	auipc	ra,0x7
     6fa:	eca080e7          	jalr	-310(ra) # 75c0 <printf>
    exit(1);
     6fe:	4505                	li	a0,1
     700:	00007097          	auipc	ra,0x7
     704:	97a080e7          	jalr	-1670(ra) # 707a <exit>
  }
}
     708:	0001                	nop
     70a:	70ae                	ld	ra,232(sp)
     70c:	740e                	ld	s0,224(sp)
     70e:	616d                	addi	sp,sp,240
     710:	8082                	ret

0000000000000712 <copyinstr3>:

// what if a string argument crosses over the end of last user page?
void
copyinstr3(char *s)
{
     712:	715d                	addi	sp,sp,-80
     714:	e486                	sd	ra,72(sp)
     716:	e0a2                	sd	s0,64(sp)
     718:	0880                	addi	s0,sp,80
     71a:	faa43c23          	sd	a0,-72(s0)
  sbrk(8192);
     71e:	6509                	lui	a0,0x2
     720:	00007097          	auipc	ra,0x7
     724:	9e2080e7          	jalr	-1566(ra) # 7102 <sbrk>
  uint64 top = (uint64) sbrk(0);
     728:	4501                	li	a0,0
     72a:	00007097          	auipc	ra,0x7
     72e:	9d8080e7          	jalr	-1576(ra) # 7102 <sbrk>
     732:	87aa                	mv	a5,a0
     734:	fef43423          	sd	a5,-24(s0)
  if((top % PGSIZE) != 0){
     738:	fe843703          	ld	a4,-24(s0)
     73c:	6785                	lui	a5,0x1
     73e:	17fd                	addi	a5,a5,-1
     740:	8ff9                	and	a5,a5,a4
     742:	c39d                	beqz	a5,768 <copyinstr3+0x56>
    sbrk(PGSIZE - (top % PGSIZE));
     744:	fe843783          	ld	a5,-24(s0)
     748:	2781                	sext.w	a5,a5
     74a:	873e                	mv	a4,a5
     74c:	6785                	lui	a5,0x1
     74e:	17fd                	addi	a5,a5,-1
     750:	8ff9                	and	a5,a5,a4
     752:	2781                	sext.w	a5,a5
     754:	6705                	lui	a4,0x1
     756:	40f707bb          	subw	a5,a4,a5
     75a:	2781                	sext.w	a5,a5
     75c:	2781                	sext.w	a5,a5
     75e:	853e                	mv	a0,a5
     760:	00007097          	auipc	ra,0x7
     764:	9a2080e7          	jalr	-1630(ra) # 7102 <sbrk>
  }
  top = (uint64) sbrk(0);
     768:	4501                	li	a0,0
     76a:	00007097          	auipc	ra,0x7
     76e:	998080e7          	jalr	-1640(ra) # 7102 <sbrk>
     772:	87aa                	mv	a5,a0
     774:	fef43423          	sd	a5,-24(s0)
  if(top % PGSIZE){
     778:	fe843703          	ld	a4,-24(s0)
     77c:	6785                	lui	a5,0x1
     77e:	17fd                	addi	a5,a5,-1
     780:	8ff9                	and	a5,a5,a4
     782:	cf91                	beqz	a5,79e <copyinstr3+0x8c>
    printf("oops\n");
     784:	00008517          	auipc	a0,0x8
     788:	f9450513          	addi	a0,a0,-108 # 8718 <schedule_rm+0x91e>
     78c:	00007097          	auipc	ra,0x7
     790:	e34080e7          	jalr	-460(ra) # 75c0 <printf>
    exit(1);
     794:	4505                	li	a0,1
     796:	00007097          	auipc	ra,0x7
     79a:	8e4080e7          	jalr	-1820(ra) # 707a <exit>
  }

  char *b = (char *) (top - 1);
     79e:	fe843783          	ld	a5,-24(s0)
     7a2:	17fd                	addi	a5,a5,-1
     7a4:	fef43023          	sd	a5,-32(s0)
  *b = 'x';
     7a8:	fe043783          	ld	a5,-32(s0)
     7ac:	07800713          	li	a4,120
     7b0:	00e78023          	sb	a4,0(a5) # 1000 <truncate3+0x1aa>

  int ret = unlink(b);
     7b4:	fe043503          	ld	a0,-32(s0)
     7b8:	00007097          	auipc	ra,0x7
     7bc:	912080e7          	jalr	-1774(ra) # 70ca <unlink>
     7c0:	87aa                	mv	a5,a0
     7c2:	fcf42e23          	sw	a5,-36(s0)
  if(ret != -1){
     7c6:	fdc42783          	lw	a5,-36(s0)
     7ca:	0007871b          	sext.w	a4,a5
     7ce:	57fd                	li	a5,-1
     7d0:	02f70463          	beq	a4,a5,7f8 <copyinstr3+0xe6>
    printf("unlink(%s) returned %d, not -1\n", b, ret);
     7d4:	fdc42783          	lw	a5,-36(s0)
     7d8:	863e                	mv	a2,a5
     7da:	fe043583          	ld	a1,-32(s0)
     7de:	00008517          	auipc	a0,0x8
     7e2:	e1a50513          	addi	a0,a0,-486 # 85f8 <schedule_rm+0x7fe>
     7e6:	00007097          	auipc	ra,0x7
     7ea:	dda080e7          	jalr	-550(ra) # 75c0 <printf>
    exit(1);
     7ee:	4505                	li	a0,1
     7f0:	00007097          	auipc	ra,0x7
     7f4:	88a080e7          	jalr	-1910(ra) # 707a <exit>
  }

  int fd = open(b, O_CREATE | O_WRONLY);
     7f8:	20100593          	li	a1,513
     7fc:	fe043503          	ld	a0,-32(s0)
     800:	00007097          	auipc	ra,0x7
     804:	8ba080e7          	jalr	-1862(ra) # 70ba <open>
     808:	87aa                	mv	a5,a0
     80a:	fcf42c23          	sw	a5,-40(s0)
  if(fd != -1){
     80e:	fd842783          	lw	a5,-40(s0)
     812:	0007871b          	sext.w	a4,a5
     816:	57fd                	li	a5,-1
     818:	02f70463          	beq	a4,a5,840 <copyinstr3+0x12e>
    printf("open(%s) returned %d, not -1\n", b, fd);
     81c:	fd842783          	lw	a5,-40(s0)
     820:	863e                	mv	a2,a5
     822:	fe043583          	ld	a1,-32(s0)
     826:	00008517          	auipc	a0,0x8
     82a:	df250513          	addi	a0,a0,-526 # 8618 <schedule_rm+0x81e>
     82e:	00007097          	auipc	ra,0x7
     832:	d92080e7          	jalr	-622(ra) # 75c0 <printf>
    exit(1);
     836:	4505                	li	a0,1
     838:	00007097          	auipc	ra,0x7
     83c:	842080e7          	jalr	-1982(ra) # 707a <exit>
  }

  ret = link(b, b);
     840:	fe043583          	ld	a1,-32(s0)
     844:	fe043503          	ld	a0,-32(s0)
     848:	00007097          	auipc	ra,0x7
     84c:	892080e7          	jalr	-1902(ra) # 70da <link>
     850:	87aa                	mv	a5,a0
     852:	fcf42e23          	sw	a5,-36(s0)
  if(ret != -1){
     856:	fdc42783          	lw	a5,-36(s0)
     85a:	0007871b          	sext.w	a4,a5
     85e:	57fd                	li	a5,-1
     860:	02f70663          	beq	a4,a5,88c <copyinstr3+0x17a>
    printf("link(%s, %s) returned %d, not -1\n", b, b, ret);
     864:	fdc42783          	lw	a5,-36(s0)
     868:	86be                	mv	a3,a5
     86a:	fe043603          	ld	a2,-32(s0)
     86e:	fe043583          	ld	a1,-32(s0)
     872:	00008517          	auipc	a0,0x8
     876:	dc650513          	addi	a0,a0,-570 # 8638 <schedule_rm+0x83e>
     87a:	00007097          	auipc	ra,0x7
     87e:	d46080e7          	jalr	-698(ra) # 75c0 <printf>
    exit(1);
     882:	4505                	li	a0,1
     884:	00006097          	auipc	ra,0x6
     888:	7f6080e7          	jalr	2038(ra) # 707a <exit>
  }

  char *args[] = { "xx", 0 };
     88c:	00008797          	auipc	a5,0x8
     890:	dd478793          	addi	a5,a5,-556 # 8660 <schedule_rm+0x866>
     894:	fcf43423          	sd	a5,-56(s0)
     898:	fc043823          	sd	zero,-48(s0)
  ret = exec(b, args);
     89c:	fc840793          	addi	a5,s0,-56
     8a0:	85be                	mv	a1,a5
     8a2:	fe043503          	ld	a0,-32(s0)
     8a6:	00007097          	auipc	ra,0x7
     8aa:	80c080e7          	jalr	-2036(ra) # 70b2 <exec>
     8ae:	87aa                	mv	a5,a0
     8b0:	fcf42e23          	sw	a5,-36(s0)
  if(ret != -1){
     8b4:	fdc42783          	lw	a5,-36(s0)
     8b8:	0007871b          	sext.w	a4,a5
     8bc:	57fd                	li	a5,-1
     8be:	02f70463          	beq	a4,a5,8e6 <copyinstr3+0x1d4>
    printf("exec(%s) returned %d, not -1\n", b, fd);
     8c2:	fd842783          	lw	a5,-40(s0)
     8c6:	863e                	mv	a2,a5
     8c8:	fe043583          	ld	a1,-32(s0)
     8cc:	00008517          	auipc	a0,0x8
     8d0:	d9c50513          	addi	a0,a0,-612 # 8668 <schedule_rm+0x86e>
     8d4:	00007097          	auipc	ra,0x7
     8d8:	cec080e7          	jalr	-788(ra) # 75c0 <printf>
    exit(1);
     8dc:	4505                	li	a0,1
     8de:	00006097          	auipc	ra,0x6
     8e2:	79c080e7          	jalr	1948(ra) # 707a <exit>
  }
}
     8e6:	0001                	nop
     8e8:	60a6                	ld	ra,72(sp)
     8ea:	6406                	ld	s0,64(sp)
     8ec:	6161                	addi	sp,sp,80
     8ee:	8082                	ret

00000000000008f0 <rwsbrk>:

// See if the kernel refuses to read/write user memory that the
// application doesn't have anymore, because it returned it.
void
rwsbrk()
{
     8f0:	1101                	addi	sp,sp,-32
     8f2:	ec06                	sd	ra,24(sp)
     8f4:	e822                	sd	s0,16(sp)
     8f6:	1000                	addi	s0,sp,32
  int fd, n;
  
  uint64 a = (uint64) sbrk(8192);
     8f8:	6509                	lui	a0,0x2
     8fa:	00007097          	auipc	ra,0x7
     8fe:	808080e7          	jalr	-2040(ra) # 7102 <sbrk>
     902:	87aa                	mv	a5,a0
     904:	fef43423          	sd	a5,-24(s0)

  if(a == 0xffffffffffffffffLL) {
     908:	fe843703          	ld	a4,-24(s0)
     90c:	57fd                	li	a5,-1
     90e:	00f71f63          	bne	a4,a5,92c <rwsbrk+0x3c>
    printf("sbrk(rwsbrk) failed\n");
     912:	00008517          	auipc	a0,0x8
     916:	e0e50513          	addi	a0,a0,-498 # 8720 <schedule_rm+0x926>
     91a:	00007097          	auipc	ra,0x7
     91e:	ca6080e7          	jalr	-858(ra) # 75c0 <printf>
    exit(1);
     922:	4505                	li	a0,1
     924:	00006097          	auipc	ra,0x6
     928:	756080e7          	jalr	1878(ra) # 707a <exit>
  }
  
  if ((uint64) sbrk(-8192) ==  0xffffffffffffffffLL) {
     92c:	7579                	lui	a0,0xffffe
     92e:	00006097          	auipc	ra,0x6
     932:	7d4080e7          	jalr	2004(ra) # 7102 <sbrk>
     936:	872a                	mv	a4,a0
     938:	57fd                	li	a5,-1
     93a:	00f71f63          	bne	a4,a5,958 <rwsbrk+0x68>
    printf("sbrk(rwsbrk) shrink failed\n");
     93e:	00008517          	auipc	a0,0x8
     942:	dfa50513          	addi	a0,a0,-518 # 8738 <schedule_rm+0x93e>
     946:	00007097          	auipc	ra,0x7
     94a:	c7a080e7          	jalr	-902(ra) # 75c0 <printf>
    exit(1);
     94e:	4505                	li	a0,1
     950:	00006097          	auipc	ra,0x6
     954:	72a080e7          	jalr	1834(ra) # 707a <exit>
  }

  fd = open("rwsbrk", O_CREATE|O_WRONLY);
     958:	20100593          	li	a1,513
     95c:	00008517          	auipc	a0,0x8
     960:	87450513          	addi	a0,a0,-1932 # 81d0 <schedule_rm+0x3d6>
     964:	00006097          	auipc	ra,0x6
     968:	756080e7          	jalr	1878(ra) # 70ba <open>
     96c:	87aa                	mv	a5,a0
     96e:	fef42223          	sw	a5,-28(s0)
  if(fd < 0){
     972:	fe442783          	lw	a5,-28(s0)
     976:	2781                	sext.w	a5,a5
     978:	0007df63          	bgez	a5,996 <rwsbrk+0xa6>
    printf("open(rwsbrk) failed\n");
     97c:	00008517          	auipc	a0,0x8
     980:	ddc50513          	addi	a0,a0,-548 # 8758 <schedule_rm+0x95e>
     984:	00007097          	auipc	ra,0x7
     988:	c3c080e7          	jalr	-964(ra) # 75c0 <printf>
    exit(1);
     98c:	4505                	li	a0,1
     98e:	00006097          	auipc	ra,0x6
     992:	6ec080e7          	jalr	1772(ra) # 707a <exit>
  }
  n = write(fd, (void*)(a+4096), 1024);
     996:	fe843703          	ld	a4,-24(s0)
     99a:	6785                	lui	a5,0x1
     99c:	97ba                	add	a5,a5,a4
     99e:	873e                	mv	a4,a5
     9a0:	fe442783          	lw	a5,-28(s0)
     9a4:	40000613          	li	a2,1024
     9a8:	85ba                	mv	a1,a4
     9aa:	853e                	mv	a0,a5
     9ac:	00006097          	auipc	ra,0x6
     9b0:	6ee080e7          	jalr	1774(ra) # 709a <write>
     9b4:	87aa                	mv	a5,a0
     9b6:	fef42023          	sw	a5,-32(s0)
  if(n >= 0){
     9ba:	fe042783          	lw	a5,-32(s0)
     9be:	2781                	sext.w	a5,a5
     9c0:	0207c763          	bltz	a5,9ee <rwsbrk+0xfe>
    printf("write(fd, %p, 1024) returned %d, not -1\n", a+4096, n);
     9c4:	fe843703          	ld	a4,-24(s0)
     9c8:	6785                	lui	a5,0x1
     9ca:	97ba                	add	a5,a5,a4
     9cc:	fe042703          	lw	a4,-32(s0)
     9d0:	863a                	mv	a2,a4
     9d2:	85be                	mv	a1,a5
     9d4:	00008517          	auipc	a0,0x8
     9d8:	d9c50513          	addi	a0,a0,-612 # 8770 <schedule_rm+0x976>
     9dc:	00007097          	auipc	ra,0x7
     9e0:	be4080e7          	jalr	-1052(ra) # 75c0 <printf>
    exit(1);
     9e4:	4505                	li	a0,1
     9e6:	00006097          	auipc	ra,0x6
     9ea:	694080e7          	jalr	1684(ra) # 707a <exit>
  }
  close(fd);
     9ee:	fe442783          	lw	a5,-28(s0)
     9f2:	853e                	mv	a0,a5
     9f4:	00006097          	auipc	ra,0x6
     9f8:	6ae080e7          	jalr	1710(ra) # 70a2 <close>
  unlink("rwsbrk");
     9fc:	00007517          	auipc	a0,0x7
     a00:	7d450513          	addi	a0,a0,2004 # 81d0 <schedule_rm+0x3d6>
     a04:	00006097          	auipc	ra,0x6
     a08:	6c6080e7          	jalr	1734(ra) # 70ca <unlink>

  fd = open("README", O_RDONLY);
     a0c:	4581                	li	a1,0
     a0e:	00008517          	auipc	a0,0x8
     a12:	b2a50513          	addi	a0,a0,-1238 # 8538 <schedule_rm+0x73e>
     a16:	00006097          	auipc	ra,0x6
     a1a:	6a4080e7          	jalr	1700(ra) # 70ba <open>
     a1e:	87aa                	mv	a5,a0
     a20:	fef42223          	sw	a5,-28(s0)
  if(fd < 0){
     a24:	fe442783          	lw	a5,-28(s0)
     a28:	2781                	sext.w	a5,a5
     a2a:	0007df63          	bgez	a5,a48 <rwsbrk+0x158>
    printf("open(rwsbrk) failed\n");
     a2e:	00008517          	auipc	a0,0x8
     a32:	d2a50513          	addi	a0,a0,-726 # 8758 <schedule_rm+0x95e>
     a36:	00007097          	auipc	ra,0x7
     a3a:	b8a080e7          	jalr	-1142(ra) # 75c0 <printf>
    exit(1);
     a3e:	4505                	li	a0,1
     a40:	00006097          	auipc	ra,0x6
     a44:	63a080e7          	jalr	1594(ra) # 707a <exit>
  }
  n = read(fd, (void*)(a+4096), 10);
     a48:	fe843703          	ld	a4,-24(s0)
     a4c:	6785                	lui	a5,0x1
     a4e:	97ba                	add	a5,a5,a4
     a50:	873e                	mv	a4,a5
     a52:	fe442783          	lw	a5,-28(s0)
     a56:	4629                	li	a2,10
     a58:	85ba                	mv	a1,a4
     a5a:	853e                	mv	a0,a5
     a5c:	00006097          	auipc	ra,0x6
     a60:	636080e7          	jalr	1590(ra) # 7092 <read>
     a64:	87aa                	mv	a5,a0
     a66:	fef42023          	sw	a5,-32(s0)
  if(n >= 0){
     a6a:	fe042783          	lw	a5,-32(s0)
     a6e:	2781                	sext.w	a5,a5
     a70:	0207c763          	bltz	a5,a9e <rwsbrk+0x1ae>
    printf("read(fd, %p, 10) returned %d, not -1\n", a+4096, n);
     a74:	fe843703          	ld	a4,-24(s0)
     a78:	6785                	lui	a5,0x1
     a7a:	97ba                	add	a5,a5,a4
     a7c:	fe042703          	lw	a4,-32(s0)
     a80:	863a                	mv	a2,a4
     a82:	85be                	mv	a1,a5
     a84:	00008517          	auipc	a0,0x8
     a88:	d1c50513          	addi	a0,a0,-740 # 87a0 <schedule_rm+0x9a6>
     a8c:	00007097          	auipc	ra,0x7
     a90:	b34080e7          	jalr	-1228(ra) # 75c0 <printf>
    exit(1);
     a94:	4505                	li	a0,1
     a96:	00006097          	auipc	ra,0x6
     a9a:	5e4080e7          	jalr	1508(ra) # 707a <exit>
  }
  close(fd);
     a9e:	fe442783          	lw	a5,-28(s0)
     aa2:	853e                	mv	a0,a5
     aa4:	00006097          	auipc	ra,0x6
     aa8:	5fe080e7          	jalr	1534(ra) # 70a2 <close>
  
  exit(0);
     aac:	4501                	li	a0,0
     aae:	00006097          	auipc	ra,0x6
     ab2:	5cc080e7          	jalr	1484(ra) # 707a <exit>

0000000000000ab6 <truncate1>:
}

// test O_TRUNC.
void
truncate1(char *s)
{
     ab6:	715d                	addi	sp,sp,-80
     ab8:	e486                	sd	ra,72(sp)
     aba:	e0a2                	sd	s0,64(sp)
     abc:	0880                	addi	s0,sp,80
     abe:	faa43c23          	sd	a0,-72(s0)
  char buf[32];
  
  unlink("truncfile");
     ac2:	00008517          	auipc	a0,0x8
     ac6:	d0650513          	addi	a0,a0,-762 # 87c8 <schedule_rm+0x9ce>
     aca:	00006097          	auipc	ra,0x6
     ace:	600080e7          	jalr	1536(ra) # 70ca <unlink>
  int fd1 = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
     ad2:	60100593          	li	a1,1537
     ad6:	00008517          	auipc	a0,0x8
     ada:	cf250513          	addi	a0,a0,-782 # 87c8 <schedule_rm+0x9ce>
     ade:	00006097          	auipc	ra,0x6
     ae2:	5dc080e7          	jalr	1500(ra) # 70ba <open>
     ae6:	87aa                	mv	a5,a0
     ae8:	fef42623          	sw	a5,-20(s0)
  write(fd1, "abcd", 4);
     aec:	fec42783          	lw	a5,-20(s0)
     af0:	4611                	li	a2,4
     af2:	00008597          	auipc	a1,0x8
     af6:	ce658593          	addi	a1,a1,-794 # 87d8 <schedule_rm+0x9de>
     afa:	853e                	mv	a0,a5
     afc:	00006097          	auipc	ra,0x6
     b00:	59e080e7          	jalr	1438(ra) # 709a <write>
  close(fd1);
     b04:	fec42783          	lw	a5,-20(s0)
     b08:	853e                	mv	a0,a5
     b0a:	00006097          	auipc	ra,0x6
     b0e:	598080e7          	jalr	1432(ra) # 70a2 <close>

  int fd2 = open("truncfile", O_RDONLY);
     b12:	4581                	li	a1,0
     b14:	00008517          	auipc	a0,0x8
     b18:	cb450513          	addi	a0,a0,-844 # 87c8 <schedule_rm+0x9ce>
     b1c:	00006097          	auipc	ra,0x6
     b20:	59e080e7          	jalr	1438(ra) # 70ba <open>
     b24:	87aa                	mv	a5,a0
     b26:	fef42423          	sw	a5,-24(s0)
  int n = read(fd2, buf, sizeof(buf));
     b2a:	fc040713          	addi	a4,s0,-64
     b2e:	fe842783          	lw	a5,-24(s0)
     b32:	02000613          	li	a2,32
     b36:	85ba                	mv	a1,a4
     b38:	853e                	mv	a0,a5
     b3a:	00006097          	auipc	ra,0x6
     b3e:	558080e7          	jalr	1368(ra) # 7092 <read>
     b42:	87aa                	mv	a5,a0
     b44:	fef42223          	sw	a5,-28(s0)
  if(n != 4){
     b48:	fe442783          	lw	a5,-28(s0)
     b4c:	0007871b          	sext.w	a4,a5
     b50:	4791                	li	a5,4
     b52:	02f70463          	beq	a4,a5,b7a <truncate1+0xc4>
    printf("%s: read %d bytes, wanted 4\n", s, n);
     b56:	fe442783          	lw	a5,-28(s0)
     b5a:	863e                	mv	a2,a5
     b5c:	fb843583          	ld	a1,-72(s0)
     b60:	00008517          	auipc	a0,0x8
     b64:	c8050513          	addi	a0,a0,-896 # 87e0 <schedule_rm+0x9e6>
     b68:	00007097          	auipc	ra,0x7
     b6c:	a58080e7          	jalr	-1448(ra) # 75c0 <printf>
    exit(1);
     b70:	4505                	li	a0,1
     b72:	00006097          	auipc	ra,0x6
     b76:	508080e7          	jalr	1288(ra) # 707a <exit>
  }

  fd1 = open("truncfile", O_WRONLY|O_TRUNC);
     b7a:	40100593          	li	a1,1025
     b7e:	00008517          	auipc	a0,0x8
     b82:	c4a50513          	addi	a0,a0,-950 # 87c8 <schedule_rm+0x9ce>
     b86:	00006097          	auipc	ra,0x6
     b8a:	534080e7          	jalr	1332(ra) # 70ba <open>
     b8e:	87aa                	mv	a5,a0
     b90:	fef42623          	sw	a5,-20(s0)

  int fd3 = open("truncfile", O_RDONLY);
     b94:	4581                	li	a1,0
     b96:	00008517          	auipc	a0,0x8
     b9a:	c3250513          	addi	a0,a0,-974 # 87c8 <schedule_rm+0x9ce>
     b9e:	00006097          	auipc	ra,0x6
     ba2:	51c080e7          	jalr	1308(ra) # 70ba <open>
     ba6:	87aa                	mv	a5,a0
     ba8:	fef42023          	sw	a5,-32(s0)
  n = read(fd3, buf, sizeof(buf));
     bac:	fc040713          	addi	a4,s0,-64
     bb0:	fe042783          	lw	a5,-32(s0)
     bb4:	02000613          	li	a2,32
     bb8:	85ba                	mv	a1,a4
     bba:	853e                	mv	a0,a5
     bbc:	00006097          	auipc	ra,0x6
     bc0:	4d6080e7          	jalr	1238(ra) # 7092 <read>
     bc4:	87aa                	mv	a5,a0
     bc6:	fef42223          	sw	a5,-28(s0)
  if(n != 0){
     bca:	fe442783          	lw	a5,-28(s0)
     bce:	2781                	sext.w	a5,a5
     bd0:	cf95                	beqz	a5,c0c <truncate1+0x156>
    printf("aaa fd3=%d\n", fd3);
     bd2:	fe042783          	lw	a5,-32(s0)
     bd6:	85be                	mv	a1,a5
     bd8:	00008517          	auipc	a0,0x8
     bdc:	c2850513          	addi	a0,a0,-984 # 8800 <schedule_rm+0xa06>
     be0:	00007097          	auipc	ra,0x7
     be4:	9e0080e7          	jalr	-1568(ra) # 75c0 <printf>
    printf("%s: read %d bytes, wanted 0\n", s, n);
     be8:	fe442783          	lw	a5,-28(s0)
     bec:	863e                	mv	a2,a5
     bee:	fb843583          	ld	a1,-72(s0)
     bf2:	00008517          	auipc	a0,0x8
     bf6:	c1e50513          	addi	a0,a0,-994 # 8810 <schedule_rm+0xa16>
     bfa:	00007097          	auipc	ra,0x7
     bfe:	9c6080e7          	jalr	-1594(ra) # 75c0 <printf>
    exit(1);
     c02:	4505                	li	a0,1
     c04:	00006097          	auipc	ra,0x6
     c08:	476080e7          	jalr	1142(ra) # 707a <exit>
  }

  n = read(fd2, buf, sizeof(buf));
     c0c:	fc040713          	addi	a4,s0,-64
     c10:	fe842783          	lw	a5,-24(s0)
     c14:	02000613          	li	a2,32
     c18:	85ba                	mv	a1,a4
     c1a:	853e                	mv	a0,a5
     c1c:	00006097          	auipc	ra,0x6
     c20:	476080e7          	jalr	1142(ra) # 7092 <read>
     c24:	87aa                	mv	a5,a0
     c26:	fef42223          	sw	a5,-28(s0)
  if(n != 0){
     c2a:	fe442783          	lw	a5,-28(s0)
     c2e:	2781                	sext.w	a5,a5
     c30:	cf95                	beqz	a5,c6c <truncate1+0x1b6>
    printf("bbb fd2=%d\n", fd2);
     c32:	fe842783          	lw	a5,-24(s0)
     c36:	85be                	mv	a1,a5
     c38:	00008517          	auipc	a0,0x8
     c3c:	bf850513          	addi	a0,a0,-1032 # 8830 <schedule_rm+0xa36>
     c40:	00007097          	auipc	ra,0x7
     c44:	980080e7          	jalr	-1664(ra) # 75c0 <printf>
    printf("%s: read %d bytes, wanted 0\n", s, n);
     c48:	fe442783          	lw	a5,-28(s0)
     c4c:	863e                	mv	a2,a5
     c4e:	fb843583          	ld	a1,-72(s0)
     c52:	00008517          	auipc	a0,0x8
     c56:	bbe50513          	addi	a0,a0,-1090 # 8810 <schedule_rm+0xa16>
     c5a:	00007097          	auipc	ra,0x7
     c5e:	966080e7          	jalr	-1690(ra) # 75c0 <printf>
    exit(1);
     c62:	4505                	li	a0,1
     c64:	00006097          	auipc	ra,0x6
     c68:	416080e7          	jalr	1046(ra) # 707a <exit>
  }
  
  write(fd1, "abcdef", 6);
     c6c:	fec42783          	lw	a5,-20(s0)
     c70:	4619                	li	a2,6
     c72:	00008597          	auipc	a1,0x8
     c76:	bce58593          	addi	a1,a1,-1074 # 8840 <schedule_rm+0xa46>
     c7a:	853e                	mv	a0,a5
     c7c:	00006097          	auipc	ra,0x6
     c80:	41e080e7          	jalr	1054(ra) # 709a <write>

  n = read(fd3, buf, sizeof(buf));
     c84:	fc040713          	addi	a4,s0,-64
     c88:	fe042783          	lw	a5,-32(s0)
     c8c:	02000613          	li	a2,32
     c90:	85ba                	mv	a1,a4
     c92:	853e                	mv	a0,a5
     c94:	00006097          	auipc	ra,0x6
     c98:	3fe080e7          	jalr	1022(ra) # 7092 <read>
     c9c:	87aa                	mv	a5,a0
     c9e:	fef42223          	sw	a5,-28(s0)
  if(n != 6){
     ca2:	fe442783          	lw	a5,-28(s0)
     ca6:	0007871b          	sext.w	a4,a5
     caa:	4799                	li	a5,6
     cac:	02f70463          	beq	a4,a5,cd4 <truncate1+0x21e>
    printf("%s: read %d bytes, wanted 6\n", s, n);
     cb0:	fe442783          	lw	a5,-28(s0)
     cb4:	863e                	mv	a2,a5
     cb6:	fb843583          	ld	a1,-72(s0)
     cba:	00008517          	auipc	a0,0x8
     cbe:	b8e50513          	addi	a0,a0,-1138 # 8848 <schedule_rm+0xa4e>
     cc2:	00007097          	auipc	ra,0x7
     cc6:	8fe080e7          	jalr	-1794(ra) # 75c0 <printf>
    exit(1);
     cca:	4505                	li	a0,1
     ccc:	00006097          	auipc	ra,0x6
     cd0:	3ae080e7          	jalr	942(ra) # 707a <exit>
  }

  n = read(fd2, buf, sizeof(buf));
     cd4:	fc040713          	addi	a4,s0,-64
     cd8:	fe842783          	lw	a5,-24(s0)
     cdc:	02000613          	li	a2,32
     ce0:	85ba                	mv	a1,a4
     ce2:	853e                	mv	a0,a5
     ce4:	00006097          	auipc	ra,0x6
     ce8:	3ae080e7          	jalr	942(ra) # 7092 <read>
     cec:	87aa                	mv	a5,a0
     cee:	fef42223          	sw	a5,-28(s0)
  if(n != 2){
     cf2:	fe442783          	lw	a5,-28(s0)
     cf6:	0007871b          	sext.w	a4,a5
     cfa:	4789                	li	a5,2
     cfc:	02f70463          	beq	a4,a5,d24 <truncate1+0x26e>
    printf("%s: read %d bytes, wanted 2\n", s, n);
     d00:	fe442783          	lw	a5,-28(s0)
     d04:	863e                	mv	a2,a5
     d06:	fb843583          	ld	a1,-72(s0)
     d0a:	00008517          	auipc	a0,0x8
     d0e:	b5e50513          	addi	a0,a0,-1186 # 8868 <schedule_rm+0xa6e>
     d12:	00007097          	auipc	ra,0x7
     d16:	8ae080e7          	jalr	-1874(ra) # 75c0 <printf>
    exit(1);
     d1a:	4505                	li	a0,1
     d1c:	00006097          	auipc	ra,0x6
     d20:	35e080e7          	jalr	862(ra) # 707a <exit>
  }

  unlink("truncfile");
     d24:	00008517          	auipc	a0,0x8
     d28:	aa450513          	addi	a0,a0,-1372 # 87c8 <schedule_rm+0x9ce>
     d2c:	00006097          	auipc	ra,0x6
     d30:	39e080e7          	jalr	926(ra) # 70ca <unlink>

  close(fd1);
     d34:	fec42783          	lw	a5,-20(s0)
     d38:	853e                	mv	a0,a5
     d3a:	00006097          	auipc	ra,0x6
     d3e:	368080e7          	jalr	872(ra) # 70a2 <close>
  close(fd2);
     d42:	fe842783          	lw	a5,-24(s0)
     d46:	853e                	mv	a0,a5
     d48:	00006097          	auipc	ra,0x6
     d4c:	35a080e7          	jalr	858(ra) # 70a2 <close>
  close(fd3);
     d50:	fe042783          	lw	a5,-32(s0)
     d54:	853e                	mv	a0,a5
     d56:	00006097          	auipc	ra,0x6
     d5a:	34c080e7          	jalr	844(ra) # 70a2 <close>
}
     d5e:	0001                	nop
     d60:	60a6                	ld	ra,72(sp)
     d62:	6406                	ld	s0,64(sp)
     d64:	6161                	addi	sp,sp,80
     d66:	8082                	ret

0000000000000d68 <truncate2>:
// this causes a write at an offset beyond the end of the file.
// such writes fail on xv6 (unlike POSIX) but at least
// they don't crash.
void
truncate2(char *s)
{
     d68:	7179                	addi	sp,sp,-48
     d6a:	f406                	sd	ra,40(sp)
     d6c:	f022                	sd	s0,32(sp)
     d6e:	1800                	addi	s0,sp,48
     d70:	fca43c23          	sd	a0,-40(s0)
  unlink("truncfile");
     d74:	00008517          	auipc	a0,0x8
     d78:	a5450513          	addi	a0,a0,-1452 # 87c8 <schedule_rm+0x9ce>
     d7c:	00006097          	auipc	ra,0x6
     d80:	34e080e7          	jalr	846(ra) # 70ca <unlink>

  int fd1 = open("truncfile", O_CREATE|O_TRUNC|O_WRONLY);
     d84:	60100593          	li	a1,1537
     d88:	00008517          	auipc	a0,0x8
     d8c:	a4050513          	addi	a0,a0,-1472 # 87c8 <schedule_rm+0x9ce>
     d90:	00006097          	auipc	ra,0x6
     d94:	32a080e7          	jalr	810(ra) # 70ba <open>
     d98:	87aa                	mv	a5,a0
     d9a:	fef42623          	sw	a5,-20(s0)
  write(fd1, "abcd", 4);
     d9e:	fec42783          	lw	a5,-20(s0)
     da2:	4611                	li	a2,4
     da4:	00008597          	auipc	a1,0x8
     da8:	a3458593          	addi	a1,a1,-1484 # 87d8 <schedule_rm+0x9de>
     dac:	853e                	mv	a0,a5
     dae:	00006097          	auipc	ra,0x6
     db2:	2ec080e7          	jalr	748(ra) # 709a <write>

  int fd2 = open("truncfile", O_TRUNC|O_WRONLY);
     db6:	40100593          	li	a1,1025
     dba:	00008517          	auipc	a0,0x8
     dbe:	a0e50513          	addi	a0,a0,-1522 # 87c8 <schedule_rm+0x9ce>
     dc2:	00006097          	auipc	ra,0x6
     dc6:	2f8080e7          	jalr	760(ra) # 70ba <open>
     dca:	87aa                	mv	a5,a0
     dcc:	fef42423          	sw	a5,-24(s0)

  int n = write(fd1, "x", 1);
     dd0:	fec42783          	lw	a5,-20(s0)
     dd4:	4605                	li	a2,1
     dd6:	00007597          	auipc	a1,0x7
     dda:	7b258593          	addi	a1,a1,1970 # 8588 <schedule_rm+0x78e>
     dde:	853e                	mv	a0,a5
     de0:	00006097          	auipc	ra,0x6
     de4:	2ba080e7          	jalr	698(ra) # 709a <write>
     de8:	87aa                	mv	a5,a0
     dea:	fef42223          	sw	a5,-28(s0)
  if(n != -1){
     dee:	fe442783          	lw	a5,-28(s0)
     df2:	0007871b          	sext.w	a4,a5
     df6:	57fd                	li	a5,-1
     df8:	02f70463          	beq	a4,a5,e20 <truncate2+0xb8>
    printf("%s: write returned %d, expected -1\n", s, n);
     dfc:	fe442783          	lw	a5,-28(s0)
     e00:	863e                	mv	a2,a5
     e02:	fd843583          	ld	a1,-40(s0)
     e06:	00008517          	auipc	a0,0x8
     e0a:	a8250513          	addi	a0,a0,-1406 # 8888 <schedule_rm+0xa8e>
     e0e:	00006097          	auipc	ra,0x6
     e12:	7b2080e7          	jalr	1970(ra) # 75c0 <printf>
    exit(1);
     e16:	4505                	li	a0,1
     e18:	00006097          	auipc	ra,0x6
     e1c:	262080e7          	jalr	610(ra) # 707a <exit>
  }

  unlink("truncfile");
     e20:	00008517          	auipc	a0,0x8
     e24:	9a850513          	addi	a0,a0,-1624 # 87c8 <schedule_rm+0x9ce>
     e28:	00006097          	auipc	ra,0x6
     e2c:	2a2080e7          	jalr	674(ra) # 70ca <unlink>
  close(fd1);
     e30:	fec42783          	lw	a5,-20(s0)
     e34:	853e                	mv	a0,a5
     e36:	00006097          	auipc	ra,0x6
     e3a:	26c080e7          	jalr	620(ra) # 70a2 <close>
  close(fd2);
     e3e:	fe842783          	lw	a5,-24(s0)
     e42:	853e                	mv	a0,a5
     e44:	00006097          	auipc	ra,0x6
     e48:	25e080e7          	jalr	606(ra) # 70a2 <close>
}
     e4c:	0001                	nop
     e4e:	70a2                	ld	ra,40(sp)
     e50:	7402                	ld	s0,32(sp)
     e52:	6145                	addi	sp,sp,48
     e54:	8082                	ret

0000000000000e56 <truncate3>:

void
truncate3(char *s)
{
     e56:	711d                	addi	sp,sp,-96
     e58:	ec86                	sd	ra,88(sp)
     e5a:	e8a2                	sd	s0,80(sp)
     e5c:	1080                	addi	s0,sp,96
     e5e:	faa43423          	sd	a0,-88(s0)
  int pid, xstatus;

  close(open("truncfile", O_CREATE|O_TRUNC|O_WRONLY));
     e62:	60100593          	li	a1,1537
     e66:	00008517          	auipc	a0,0x8
     e6a:	96250513          	addi	a0,a0,-1694 # 87c8 <schedule_rm+0x9ce>
     e6e:	00006097          	auipc	ra,0x6
     e72:	24c080e7          	jalr	588(ra) # 70ba <open>
     e76:	87aa                	mv	a5,a0
     e78:	853e                	mv	a0,a5
     e7a:	00006097          	auipc	ra,0x6
     e7e:	228080e7          	jalr	552(ra) # 70a2 <close>
  
  pid = fork();
     e82:	00006097          	auipc	ra,0x6
     e86:	1f0080e7          	jalr	496(ra) # 7072 <fork>
     e8a:	87aa                	mv	a5,a0
     e8c:	fef42223          	sw	a5,-28(s0)
  if(pid < 0){
     e90:	fe442783          	lw	a5,-28(s0)
     e94:	2781                	sext.w	a5,a5
     e96:	0207d163          	bgez	a5,eb8 <truncate3+0x62>
    printf("%s: fork failed\n", s);
     e9a:	fa843583          	ld	a1,-88(s0)
     e9e:	00008517          	auipc	a0,0x8
     ea2:	a1250513          	addi	a0,a0,-1518 # 88b0 <schedule_rm+0xab6>
     ea6:	00006097          	auipc	ra,0x6
     eaa:	71a080e7          	jalr	1818(ra) # 75c0 <printf>
    exit(1);
     eae:	4505                	li	a0,1
     eb0:	00006097          	auipc	ra,0x6
     eb4:	1ca080e7          	jalr	458(ra) # 707a <exit>
  }

  if(pid == 0){
     eb8:	fe442783          	lw	a5,-28(s0)
     ebc:	2781                	sext.w	a5,a5
     ebe:	10079563          	bnez	a5,fc8 <truncate3+0x172>
    for(int i = 0; i < 100; i++){
     ec2:	fe042623          	sw	zero,-20(s0)
     ec6:	a0e5                	j	fae <truncate3+0x158>
      char buf[32];
      int fd = open("truncfile", O_WRONLY);
     ec8:	4585                	li	a1,1
     eca:	00008517          	auipc	a0,0x8
     ece:	8fe50513          	addi	a0,a0,-1794 # 87c8 <schedule_rm+0x9ce>
     ed2:	00006097          	auipc	ra,0x6
     ed6:	1e8080e7          	jalr	488(ra) # 70ba <open>
     eda:	87aa                	mv	a5,a0
     edc:	fcf42c23          	sw	a5,-40(s0)
      if(fd < 0){
     ee0:	fd842783          	lw	a5,-40(s0)
     ee4:	2781                	sext.w	a5,a5
     ee6:	0207d163          	bgez	a5,f08 <truncate3+0xb2>
        printf("%s: open failed\n", s);
     eea:	fa843583          	ld	a1,-88(s0)
     eee:	00008517          	auipc	a0,0x8
     ef2:	9da50513          	addi	a0,a0,-1574 # 88c8 <schedule_rm+0xace>
     ef6:	00006097          	auipc	ra,0x6
     efa:	6ca080e7          	jalr	1738(ra) # 75c0 <printf>
        exit(1);
     efe:	4505                	li	a0,1
     f00:	00006097          	auipc	ra,0x6
     f04:	17a080e7          	jalr	378(ra) # 707a <exit>
      }
      int n = write(fd, "1234567890", 10);
     f08:	fd842783          	lw	a5,-40(s0)
     f0c:	4629                	li	a2,10
     f0e:	00008597          	auipc	a1,0x8
     f12:	9d258593          	addi	a1,a1,-1582 # 88e0 <schedule_rm+0xae6>
     f16:	853e                	mv	a0,a5
     f18:	00006097          	auipc	ra,0x6
     f1c:	182080e7          	jalr	386(ra) # 709a <write>
     f20:	87aa                	mv	a5,a0
     f22:	fcf42a23          	sw	a5,-44(s0)
      if(n != 10){
     f26:	fd442783          	lw	a5,-44(s0)
     f2a:	0007871b          	sext.w	a4,a5
     f2e:	47a9                	li	a5,10
     f30:	02f70463          	beq	a4,a5,f58 <truncate3+0x102>
        printf("%s: write got %d, expected 10\n", s, n);
     f34:	fd442783          	lw	a5,-44(s0)
     f38:	863e                	mv	a2,a5
     f3a:	fa843583          	ld	a1,-88(s0)
     f3e:	00008517          	auipc	a0,0x8
     f42:	9b250513          	addi	a0,a0,-1614 # 88f0 <schedule_rm+0xaf6>
     f46:	00006097          	auipc	ra,0x6
     f4a:	67a080e7          	jalr	1658(ra) # 75c0 <printf>
        exit(1);
     f4e:	4505                	li	a0,1
     f50:	00006097          	auipc	ra,0x6
     f54:	12a080e7          	jalr	298(ra) # 707a <exit>
      }
      close(fd);
     f58:	fd842783          	lw	a5,-40(s0)
     f5c:	853e                	mv	a0,a5
     f5e:	00006097          	auipc	ra,0x6
     f62:	144080e7          	jalr	324(ra) # 70a2 <close>
      fd = open("truncfile", O_RDONLY);
     f66:	4581                	li	a1,0
     f68:	00008517          	auipc	a0,0x8
     f6c:	86050513          	addi	a0,a0,-1952 # 87c8 <schedule_rm+0x9ce>
     f70:	00006097          	auipc	ra,0x6
     f74:	14a080e7          	jalr	330(ra) # 70ba <open>
     f78:	87aa                	mv	a5,a0
     f7a:	fcf42c23          	sw	a5,-40(s0)
      read(fd, buf, sizeof(buf));
     f7e:	fb040713          	addi	a4,s0,-80
     f82:	fd842783          	lw	a5,-40(s0)
     f86:	02000613          	li	a2,32
     f8a:	85ba                	mv	a1,a4
     f8c:	853e                	mv	a0,a5
     f8e:	00006097          	auipc	ra,0x6
     f92:	104080e7          	jalr	260(ra) # 7092 <read>
      close(fd);
     f96:	fd842783          	lw	a5,-40(s0)
     f9a:	853e                	mv	a0,a5
     f9c:	00006097          	auipc	ra,0x6
     fa0:	106080e7          	jalr	262(ra) # 70a2 <close>
    for(int i = 0; i < 100; i++){
     fa4:	fec42783          	lw	a5,-20(s0)
     fa8:	2785                	addiw	a5,a5,1
     faa:	fef42623          	sw	a5,-20(s0)
     fae:	fec42783          	lw	a5,-20(s0)
     fb2:	0007871b          	sext.w	a4,a5
     fb6:	06300793          	li	a5,99
     fba:	f0e7d7e3          	bge	a5,a4,ec8 <truncate3+0x72>
    }
    exit(0);
     fbe:	4501                	li	a0,0
     fc0:	00006097          	auipc	ra,0x6
     fc4:	0ba080e7          	jalr	186(ra) # 707a <exit>
  }

  for(int i = 0; i < 150; i++){
     fc8:	fe042423          	sw	zero,-24(s0)
     fcc:	a075                	j	1078 <truncate3+0x222>
    int fd = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
     fce:	60100593          	li	a1,1537
     fd2:	00007517          	auipc	a0,0x7
     fd6:	7f650513          	addi	a0,a0,2038 # 87c8 <schedule_rm+0x9ce>
     fda:	00006097          	auipc	ra,0x6
     fde:	0e0080e7          	jalr	224(ra) # 70ba <open>
     fe2:	87aa                	mv	a5,a0
     fe4:	fef42023          	sw	a5,-32(s0)
    if(fd < 0){
     fe8:	fe042783          	lw	a5,-32(s0)
     fec:	2781                	sext.w	a5,a5
     fee:	0207d163          	bgez	a5,1010 <truncate3+0x1ba>
      printf("%s: open failed\n", s);
     ff2:	fa843583          	ld	a1,-88(s0)
     ff6:	00008517          	auipc	a0,0x8
     ffa:	8d250513          	addi	a0,a0,-1838 # 88c8 <schedule_rm+0xace>
     ffe:	00006097          	auipc	ra,0x6
    1002:	5c2080e7          	jalr	1474(ra) # 75c0 <printf>
      exit(1);
    1006:	4505                	li	a0,1
    1008:	00006097          	auipc	ra,0x6
    100c:	072080e7          	jalr	114(ra) # 707a <exit>
    }
    int n = write(fd, "xxx", 3);
    1010:	fe042783          	lw	a5,-32(s0)
    1014:	460d                	li	a2,3
    1016:	00008597          	auipc	a1,0x8
    101a:	8fa58593          	addi	a1,a1,-1798 # 8910 <schedule_rm+0xb16>
    101e:	853e                	mv	a0,a5
    1020:	00006097          	auipc	ra,0x6
    1024:	07a080e7          	jalr	122(ra) # 709a <write>
    1028:	87aa                	mv	a5,a0
    102a:	fcf42e23          	sw	a5,-36(s0)
    if(n != 3){
    102e:	fdc42783          	lw	a5,-36(s0)
    1032:	0007871b          	sext.w	a4,a5
    1036:	478d                	li	a5,3
    1038:	02f70463          	beq	a4,a5,1060 <truncate3+0x20a>
      printf("%s: write got %d, expected 3\n", s, n);
    103c:	fdc42783          	lw	a5,-36(s0)
    1040:	863e                	mv	a2,a5
    1042:	fa843583          	ld	a1,-88(s0)
    1046:	00008517          	auipc	a0,0x8
    104a:	8d250513          	addi	a0,a0,-1838 # 8918 <schedule_rm+0xb1e>
    104e:	00006097          	auipc	ra,0x6
    1052:	572080e7          	jalr	1394(ra) # 75c0 <printf>
      exit(1);
    1056:	4505                	li	a0,1
    1058:	00006097          	auipc	ra,0x6
    105c:	022080e7          	jalr	34(ra) # 707a <exit>
    }
    close(fd);
    1060:	fe042783          	lw	a5,-32(s0)
    1064:	853e                	mv	a0,a5
    1066:	00006097          	auipc	ra,0x6
    106a:	03c080e7          	jalr	60(ra) # 70a2 <close>
  for(int i = 0; i < 150; i++){
    106e:	fe842783          	lw	a5,-24(s0)
    1072:	2785                	addiw	a5,a5,1
    1074:	fef42423          	sw	a5,-24(s0)
    1078:	fe842783          	lw	a5,-24(s0)
    107c:	0007871b          	sext.w	a4,a5
    1080:	09500793          	li	a5,149
    1084:	f4e7d5e3          	bge	a5,a4,fce <truncate3+0x178>
  }

  wait(&xstatus);
    1088:	fd040793          	addi	a5,s0,-48
    108c:	853e                	mv	a0,a5
    108e:	00006097          	auipc	ra,0x6
    1092:	ff4080e7          	jalr	-12(ra) # 7082 <wait>
  unlink("truncfile");
    1096:	00007517          	auipc	a0,0x7
    109a:	73250513          	addi	a0,a0,1842 # 87c8 <schedule_rm+0x9ce>
    109e:	00006097          	auipc	ra,0x6
    10a2:	02c080e7          	jalr	44(ra) # 70ca <unlink>
  exit(xstatus);
    10a6:	fd042783          	lw	a5,-48(s0)
    10aa:	853e                	mv	a0,a5
    10ac:	00006097          	auipc	ra,0x6
    10b0:	fce080e7          	jalr	-50(ra) # 707a <exit>

00000000000010b4 <iputtest>:
  

// does chdir() call iput(p->cwd) in a transaction?
void
iputtest(char *s)
{
    10b4:	1101                	addi	sp,sp,-32
    10b6:	ec06                	sd	ra,24(sp)
    10b8:	e822                	sd	s0,16(sp)
    10ba:	1000                	addi	s0,sp,32
    10bc:	fea43423          	sd	a0,-24(s0)
  if(mkdir("iputdir") < 0){
    10c0:	00008517          	auipc	a0,0x8
    10c4:	87850513          	addi	a0,a0,-1928 # 8938 <schedule_rm+0xb3e>
    10c8:	00006097          	auipc	ra,0x6
    10cc:	01a080e7          	jalr	26(ra) # 70e2 <mkdir>
    10d0:	87aa                	mv	a5,a0
    10d2:	0207d163          	bgez	a5,10f4 <iputtest+0x40>
    printf("%s: mkdir failed\n", s);
    10d6:	fe843583          	ld	a1,-24(s0)
    10da:	00008517          	auipc	a0,0x8
    10de:	86650513          	addi	a0,a0,-1946 # 8940 <schedule_rm+0xb46>
    10e2:	00006097          	auipc	ra,0x6
    10e6:	4de080e7          	jalr	1246(ra) # 75c0 <printf>
    exit(1);
    10ea:	4505                	li	a0,1
    10ec:	00006097          	auipc	ra,0x6
    10f0:	f8e080e7          	jalr	-114(ra) # 707a <exit>
  }
  if(chdir("iputdir") < 0){
    10f4:	00008517          	auipc	a0,0x8
    10f8:	84450513          	addi	a0,a0,-1980 # 8938 <schedule_rm+0xb3e>
    10fc:	00006097          	auipc	ra,0x6
    1100:	fee080e7          	jalr	-18(ra) # 70ea <chdir>
    1104:	87aa                	mv	a5,a0
    1106:	0207d163          	bgez	a5,1128 <iputtest+0x74>
    printf("%s: chdir iputdir failed\n", s);
    110a:	fe843583          	ld	a1,-24(s0)
    110e:	00008517          	auipc	a0,0x8
    1112:	84a50513          	addi	a0,a0,-1974 # 8958 <schedule_rm+0xb5e>
    1116:	00006097          	auipc	ra,0x6
    111a:	4aa080e7          	jalr	1194(ra) # 75c0 <printf>
    exit(1);
    111e:	4505                	li	a0,1
    1120:	00006097          	auipc	ra,0x6
    1124:	f5a080e7          	jalr	-166(ra) # 707a <exit>
  }
  if(unlink("../iputdir") < 0){
    1128:	00008517          	auipc	a0,0x8
    112c:	85050513          	addi	a0,a0,-1968 # 8978 <schedule_rm+0xb7e>
    1130:	00006097          	auipc	ra,0x6
    1134:	f9a080e7          	jalr	-102(ra) # 70ca <unlink>
    1138:	87aa                	mv	a5,a0
    113a:	0207d163          	bgez	a5,115c <iputtest+0xa8>
    printf("%s: unlink ../iputdir failed\n", s);
    113e:	fe843583          	ld	a1,-24(s0)
    1142:	00008517          	auipc	a0,0x8
    1146:	84650513          	addi	a0,a0,-1978 # 8988 <schedule_rm+0xb8e>
    114a:	00006097          	auipc	ra,0x6
    114e:	476080e7          	jalr	1142(ra) # 75c0 <printf>
    exit(1);
    1152:	4505                	li	a0,1
    1154:	00006097          	auipc	ra,0x6
    1158:	f26080e7          	jalr	-218(ra) # 707a <exit>
  }
  if(chdir("/") < 0){
    115c:	00008517          	auipc	a0,0x8
    1160:	84c50513          	addi	a0,a0,-1972 # 89a8 <schedule_rm+0xbae>
    1164:	00006097          	auipc	ra,0x6
    1168:	f86080e7          	jalr	-122(ra) # 70ea <chdir>
    116c:	87aa                	mv	a5,a0
    116e:	0207d163          	bgez	a5,1190 <iputtest+0xdc>
    printf("%s: chdir / failed\n", s);
    1172:	fe843583          	ld	a1,-24(s0)
    1176:	00008517          	auipc	a0,0x8
    117a:	83a50513          	addi	a0,a0,-1990 # 89b0 <schedule_rm+0xbb6>
    117e:	00006097          	auipc	ra,0x6
    1182:	442080e7          	jalr	1090(ra) # 75c0 <printf>
    exit(1);
    1186:	4505                	li	a0,1
    1188:	00006097          	auipc	ra,0x6
    118c:	ef2080e7          	jalr	-270(ra) # 707a <exit>
  }
}
    1190:	0001                	nop
    1192:	60e2                	ld	ra,24(sp)
    1194:	6442                	ld	s0,16(sp)
    1196:	6105                	addi	sp,sp,32
    1198:	8082                	ret

000000000000119a <exitiputtest>:

// does exit() call iput(p->cwd) in a transaction?
void
exitiputtest(char *s)
{
    119a:	7179                	addi	sp,sp,-48
    119c:	f406                	sd	ra,40(sp)
    119e:	f022                	sd	s0,32(sp)
    11a0:	1800                	addi	s0,sp,48
    11a2:	fca43c23          	sd	a0,-40(s0)
  int pid, xstatus;

  pid = fork();
    11a6:	00006097          	auipc	ra,0x6
    11aa:	ecc080e7          	jalr	-308(ra) # 7072 <fork>
    11ae:	87aa                	mv	a5,a0
    11b0:	fef42623          	sw	a5,-20(s0)
  if(pid < 0){
    11b4:	fec42783          	lw	a5,-20(s0)
    11b8:	2781                	sext.w	a5,a5
    11ba:	0207d163          	bgez	a5,11dc <exitiputtest+0x42>
    printf("%s: fork failed\n", s);
    11be:	fd843583          	ld	a1,-40(s0)
    11c2:	00007517          	auipc	a0,0x7
    11c6:	6ee50513          	addi	a0,a0,1774 # 88b0 <schedule_rm+0xab6>
    11ca:	00006097          	auipc	ra,0x6
    11ce:	3f6080e7          	jalr	1014(ra) # 75c0 <printf>
    exit(1);
    11d2:	4505                	li	a0,1
    11d4:	00006097          	auipc	ra,0x6
    11d8:	ea6080e7          	jalr	-346(ra) # 707a <exit>
  }
  if(pid == 0){
    11dc:	fec42783          	lw	a5,-20(s0)
    11e0:	2781                	sext.w	a5,a5
    11e2:	e7c5                	bnez	a5,128a <exitiputtest+0xf0>
    if(mkdir("iputdir") < 0){
    11e4:	00007517          	auipc	a0,0x7
    11e8:	75450513          	addi	a0,a0,1876 # 8938 <schedule_rm+0xb3e>
    11ec:	00006097          	auipc	ra,0x6
    11f0:	ef6080e7          	jalr	-266(ra) # 70e2 <mkdir>
    11f4:	87aa                	mv	a5,a0
    11f6:	0207d163          	bgez	a5,1218 <exitiputtest+0x7e>
      printf("%s: mkdir failed\n", s);
    11fa:	fd843583          	ld	a1,-40(s0)
    11fe:	00007517          	auipc	a0,0x7
    1202:	74250513          	addi	a0,a0,1858 # 8940 <schedule_rm+0xb46>
    1206:	00006097          	auipc	ra,0x6
    120a:	3ba080e7          	jalr	954(ra) # 75c0 <printf>
      exit(1);
    120e:	4505                	li	a0,1
    1210:	00006097          	auipc	ra,0x6
    1214:	e6a080e7          	jalr	-406(ra) # 707a <exit>
    }
    if(chdir("iputdir") < 0){
    1218:	00007517          	auipc	a0,0x7
    121c:	72050513          	addi	a0,a0,1824 # 8938 <schedule_rm+0xb3e>
    1220:	00006097          	auipc	ra,0x6
    1224:	eca080e7          	jalr	-310(ra) # 70ea <chdir>
    1228:	87aa                	mv	a5,a0
    122a:	0207d163          	bgez	a5,124c <exitiputtest+0xb2>
      printf("%s: child chdir failed\n", s);
    122e:	fd843583          	ld	a1,-40(s0)
    1232:	00007517          	auipc	a0,0x7
    1236:	79650513          	addi	a0,a0,1942 # 89c8 <schedule_rm+0xbce>
    123a:	00006097          	auipc	ra,0x6
    123e:	386080e7          	jalr	902(ra) # 75c0 <printf>
      exit(1);
    1242:	4505                	li	a0,1
    1244:	00006097          	auipc	ra,0x6
    1248:	e36080e7          	jalr	-458(ra) # 707a <exit>
    }
    if(unlink("../iputdir") < 0){
    124c:	00007517          	auipc	a0,0x7
    1250:	72c50513          	addi	a0,a0,1836 # 8978 <schedule_rm+0xb7e>
    1254:	00006097          	auipc	ra,0x6
    1258:	e76080e7          	jalr	-394(ra) # 70ca <unlink>
    125c:	87aa                	mv	a5,a0
    125e:	0207d163          	bgez	a5,1280 <exitiputtest+0xe6>
      printf("%s: unlink ../iputdir failed\n", s);
    1262:	fd843583          	ld	a1,-40(s0)
    1266:	00007517          	auipc	a0,0x7
    126a:	72250513          	addi	a0,a0,1826 # 8988 <schedule_rm+0xb8e>
    126e:	00006097          	auipc	ra,0x6
    1272:	352080e7          	jalr	850(ra) # 75c0 <printf>
      exit(1);
    1276:	4505                	li	a0,1
    1278:	00006097          	auipc	ra,0x6
    127c:	e02080e7          	jalr	-510(ra) # 707a <exit>
    }
    exit(0);
    1280:	4501                	li	a0,0
    1282:	00006097          	auipc	ra,0x6
    1286:	df8080e7          	jalr	-520(ra) # 707a <exit>
  }
  wait(&xstatus);
    128a:	fe840793          	addi	a5,s0,-24
    128e:	853e                	mv	a0,a5
    1290:	00006097          	auipc	ra,0x6
    1294:	df2080e7          	jalr	-526(ra) # 7082 <wait>
  exit(xstatus);
    1298:	fe842783          	lw	a5,-24(s0)
    129c:	853e                	mv	a0,a5
    129e:	00006097          	auipc	ra,0x6
    12a2:	ddc080e7          	jalr	-548(ra) # 707a <exit>

00000000000012a6 <openiputtest>:
//      for(i = 0; i < 10000; i++)
//        yield();
//    }
void
openiputtest(char *s)
{
    12a6:	7179                	addi	sp,sp,-48
    12a8:	f406                	sd	ra,40(sp)
    12aa:	f022                	sd	s0,32(sp)
    12ac:	1800                	addi	s0,sp,48
    12ae:	fca43c23          	sd	a0,-40(s0)
  int pid, xstatus;

  if(mkdir("oidir") < 0){
    12b2:	00007517          	auipc	a0,0x7
    12b6:	72e50513          	addi	a0,a0,1838 # 89e0 <schedule_rm+0xbe6>
    12ba:	00006097          	auipc	ra,0x6
    12be:	e28080e7          	jalr	-472(ra) # 70e2 <mkdir>
    12c2:	87aa                	mv	a5,a0
    12c4:	0207d163          	bgez	a5,12e6 <openiputtest+0x40>
    printf("%s: mkdir oidir failed\n", s);
    12c8:	fd843583          	ld	a1,-40(s0)
    12cc:	00007517          	auipc	a0,0x7
    12d0:	71c50513          	addi	a0,a0,1820 # 89e8 <schedule_rm+0xbee>
    12d4:	00006097          	auipc	ra,0x6
    12d8:	2ec080e7          	jalr	748(ra) # 75c0 <printf>
    exit(1);
    12dc:	4505                	li	a0,1
    12de:	00006097          	auipc	ra,0x6
    12e2:	d9c080e7          	jalr	-612(ra) # 707a <exit>
  }
  pid = fork();
    12e6:	00006097          	auipc	ra,0x6
    12ea:	d8c080e7          	jalr	-628(ra) # 7072 <fork>
    12ee:	87aa                	mv	a5,a0
    12f0:	fef42623          	sw	a5,-20(s0)
  if(pid < 0){
    12f4:	fec42783          	lw	a5,-20(s0)
    12f8:	2781                	sext.w	a5,a5
    12fa:	0207d163          	bgez	a5,131c <openiputtest+0x76>
    printf("%s: fork failed\n", s);
    12fe:	fd843583          	ld	a1,-40(s0)
    1302:	00007517          	auipc	a0,0x7
    1306:	5ae50513          	addi	a0,a0,1454 # 88b0 <schedule_rm+0xab6>
    130a:	00006097          	auipc	ra,0x6
    130e:	2b6080e7          	jalr	694(ra) # 75c0 <printf>
    exit(1);
    1312:	4505                	li	a0,1
    1314:	00006097          	auipc	ra,0x6
    1318:	d66080e7          	jalr	-666(ra) # 707a <exit>
  }
  if(pid == 0){
    131c:	fec42783          	lw	a5,-20(s0)
    1320:	2781                	sext.w	a5,a5
    1322:	e7b1                	bnez	a5,136e <openiputtest+0xc8>
    int fd = open("oidir", O_RDWR);
    1324:	4589                	li	a1,2
    1326:	00007517          	auipc	a0,0x7
    132a:	6ba50513          	addi	a0,a0,1722 # 89e0 <schedule_rm+0xbe6>
    132e:	00006097          	auipc	ra,0x6
    1332:	d8c080e7          	jalr	-628(ra) # 70ba <open>
    1336:	87aa                	mv	a5,a0
    1338:	fef42423          	sw	a5,-24(s0)
    if(fd >= 0){
    133c:	fe842783          	lw	a5,-24(s0)
    1340:	2781                	sext.w	a5,a5
    1342:	0207c163          	bltz	a5,1364 <openiputtest+0xbe>
      printf("%s: open directory for write succeeded\n", s);
    1346:	fd843583          	ld	a1,-40(s0)
    134a:	00007517          	auipc	a0,0x7
    134e:	6b650513          	addi	a0,a0,1718 # 8a00 <schedule_rm+0xc06>
    1352:	00006097          	auipc	ra,0x6
    1356:	26e080e7          	jalr	622(ra) # 75c0 <printf>
      exit(1);
    135a:	4505                	li	a0,1
    135c:	00006097          	auipc	ra,0x6
    1360:	d1e080e7          	jalr	-738(ra) # 707a <exit>
    }
    exit(0);
    1364:	4501                	li	a0,0
    1366:	00006097          	auipc	ra,0x6
    136a:	d14080e7          	jalr	-748(ra) # 707a <exit>
  }
  sleep(1);
    136e:	4505                	li	a0,1
    1370:	00006097          	auipc	ra,0x6
    1374:	d9a080e7          	jalr	-614(ra) # 710a <sleep>
  if(unlink("oidir") != 0){
    1378:	00007517          	auipc	a0,0x7
    137c:	66850513          	addi	a0,a0,1640 # 89e0 <schedule_rm+0xbe6>
    1380:	00006097          	auipc	ra,0x6
    1384:	d4a080e7          	jalr	-694(ra) # 70ca <unlink>
    1388:	87aa                	mv	a5,a0
    138a:	c385                	beqz	a5,13aa <openiputtest+0x104>
    printf("%s: unlink failed\n", s);
    138c:	fd843583          	ld	a1,-40(s0)
    1390:	00007517          	auipc	a0,0x7
    1394:	69850513          	addi	a0,a0,1688 # 8a28 <schedule_rm+0xc2e>
    1398:	00006097          	auipc	ra,0x6
    139c:	228080e7          	jalr	552(ra) # 75c0 <printf>
    exit(1);
    13a0:	4505                	li	a0,1
    13a2:	00006097          	auipc	ra,0x6
    13a6:	cd8080e7          	jalr	-808(ra) # 707a <exit>
  }
  wait(&xstatus);
    13aa:	fe440793          	addi	a5,s0,-28
    13ae:	853e                	mv	a0,a5
    13b0:	00006097          	auipc	ra,0x6
    13b4:	cd2080e7          	jalr	-814(ra) # 7082 <wait>
  exit(xstatus);
    13b8:	fe442783          	lw	a5,-28(s0)
    13bc:	853e                	mv	a0,a5
    13be:	00006097          	auipc	ra,0x6
    13c2:	cbc080e7          	jalr	-836(ra) # 707a <exit>

00000000000013c6 <opentest>:

// simple file system tests

void
opentest(char *s)
{
    13c6:	7179                	addi	sp,sp,-48
    13c8:	f406                	sd	ra,40(sp)
    13ca:	f022                	sd	s0,32(sp)
    13cc:	1800                	addi	s0,sp,48
    13ce:	fca43c23          	sd	a0,-40(s0)
  int fd;

  fd = open("echo", 0);
    13d2:	4581                	li	a1,0
    13d4:	00007517          	auipc	a0,0x7
    13d8:	2c450513          	addi	a0,a0,708 # 8698 <schedule_rm+0x89e>
    13dc:	00006097          	auipc	ra,0x6
    13e0:	cde080e7          	jalr	-802(ra) # 70ba <open>
    13e4:	87aa                	mv	a5,a0
    13e6:	fef42623          	sw	a5,-20(s0)
  if(fd < 0){
    13ea:	fec42783          	lw	a5,-20(s0)
    13ee:	2781                	sext.w	a5,a5
    13f0:	0207d163          	bgez	a5,1412 <opentest+0x4c>
    printf("%s: open echo failed!\n", s);
    13f4:	fd843583          	ld	a1,-40(s0)
    13f8:	00007517          	auipc	a0,0x7
    13fc:	64850513          	addi	a0,a0,1608 # 8a40 <schedule_rm+0xc46>
    1400:	00006097          	auipc	ra,0x6
    1404:	1c0080e7          	jalr	448(ra) # 75c0 <printf>
    exit(1);
    1408:	4505                	li	a0,1
    140a:	00006097          	auipc	ra,0x6
    140e:	c70080e7          	jalr	-912(ra) # 707a <exit>
  }
  close(fd);
    1412:	fec42783          	lw	a5,-20(s0)
    1416:	853e                	mv	a0,a5
    1418:	00006097          	auipc	ra,0x6
    141c:	c8a080e7          	jalr	-886(ra) # 70a2 <close>
  fd = open("doesnotexist", 0);
    1420:	4581                	li	a1,0
    1422:	00007517          	auipc	a0,0x7
    1426:	63650513          	addi	a0,a0,1590 # 8a58 <schedule_rm+0xc5e>
    142a:	00006097          	auipc	ra,0x6
    142e:	c90080e7          	jalr	-880(ra) # 70ba <open>
    1432:	87aa                	mv	a5,a0
    1434:	fef42623          	sw	a5,-20(s0)
  if(fd >= 0){
    1438:	fec42783          	lw	a5,-20(s0)
    143c:	2781                	sext.w	a5,a5
    143e:	0207c163          	bltz	a5,1460 <opentest+0x9a>
    printf("%s: open doesnotexist succeeded!\n", s);
    1442:	fd843583          	ld	a1,-40(s0)
    1446:	00007517          	auipc	a0,0x7
    144a:	62250513          	addi	a0,a0,1570 # 8a68 <schedule_rm+0xc6e>
    144e:	00006097          	auipc	ra,0x6
    1452:	172080e7          	jalr	370(ra) # 75c0 <printf>
    exit(1);
    1456:	4505                	li	a0,1
    1458:	00006097          	auipc	ra,0x6
    145c:	c22080e7          	jalr	-990(ra) # 707a <exit>
  }
}
    1460:	0001                	nop
    1462:	70a2                	ld	ra,40(sp)
    1464:	7402                	ld	s0,32(sp)
    1466:	6145                	addi	sp,sp,48
    1468:	8082                	ret

000000000000146a <writetest>:

void
writetest(char *s)
{
    146a:	7179                	addi	sp,sp,-48
    146c:	f406                	sd	ra,40(sp)
    146e:	f022                	sd	s0,32(sp)
    1470:	1800                	addi	s0,sp,48
    1472:	fca43c23          	sd	a0,-40(s0)
  int fd;
  int i;
  enum { N=100, SZ=10 };
  
  fd = open("small", O_CREATE|O_RDWR);
    1476:	20200593          	li	a1,514
    147a:	00007517          	auipc	a0,0x7
    147e:	61650513          	addi	a0,a0,1558 # 8a90 <schedule_rm+0xc96>
    1482:	00006097          	auipc	ra,0x6
    1486:	c38080e7          	jalr	-968(ra) # 70ba <open>
    148a:	87aa                	mv	a5,a0
    148c:	fef42423          	sw	a5,-24(s0)
  if(fd < 0){
    1490:	fe842783          	lw	a5,-24(s0)
    1494:	2781                	sext.w	a5,a5
    1496:	0207d163          	bgez	a5,14b8 <writetest+0x4e>
    printf("%s: error: creat small failed!\n", s);
    149a:	fd843583          	ld	a1,-40(s0)
    149e:	00007517          	auipc	a0,0x7
    14a2:	5fa50513          	addi	a0,a0,1530 # 8a98 <schedule_rm+0xc9e>
    14a6:	00006097          	auipc	ra,0x6
    14aa:	11a080e7          	jalr	282(ra) # 75c0 <printf>
    exit(1);
    14ae:	4505                	li	a0,1
    14b0:	00006097          	auipc	ra,0x6
    14b4:	bca080e7          	jalr	-1078(ra) # 707a <exit>
  }
  for(i = 0; i < N; i++){
    14b8:	fe042623          	sw	zero,-20(s0)
    14bc:	a861                	j	1554 <writetest+0xea>
    if(write(fd, "aaaaaaaaaa", SZ) != SZ){
    14be:	fe842783          	lw	a5,-24(s0)
    14c2:	4629                	li	a2,10
    14c4:	00007597          	auipc	a1,0x7
    14c8:	5f458593          	addi	a1,a1,1524 # 8ab8 <schedule_rm+0xcbe>
    14cc:	853e                	mv	a0,a5
    14ce:	00006097          	auipc	ra,0x6
    14d2:	bcc080e7          	jalr	-1076(ra) # 709a <write>
    14d6:	87aa                	mv	a5,a0
    14d8:	873e                	mv	a4,a5
    14da:	47a9                	li	a5,10
    14dc:	02f70463          	beq	a4,a5,1504 <writetest+0x9a>
      printf("%s: error: write aa %d new file failed\n", s, i);
    14e0:	fec42783          	lw	a5,-20(s0)
    14e4:	863e                	mv	a2,a5
    14e6:	fd843583          	ld	a1,-40(s0)
    14ea:	00007517          	auipc	a0,0x7
    14ee:	5de50513          	addi	a0,a0,1502 # 8ac8 <schedule_rm+0xcce>
    14f2:	00006097          	auipc	ra,0x6
    14f6:	0ce080e7          	jalr	206(ra) # 75c0 <printf>
      exit(1);
    14fa:	4505                	li	a0,1
    14fc:	00006097          	auipc	ra,0x6
    1500:	b7e080e7          	jalr	-1154(ra) # 707a <exit>
    }
    if(write(fd, "bbbbbbbbbb", SZ) != SZ){
    1504:	fe842783          	lw	a5,-24(s0)
    1508:	4629                	li	a2,10
    150a:	00007597          	auipc	a1,0x7
    150e:	5e658593          	addi	a1,a1,1510 # 8af0 <schedule_rm+0xcf6>
    1512:	853e                	mv	a0,a5
    1514:	00006097          	auipc	ra,0x6
    1518:	b86080e7          	jalr	-1146(ra) # 709a <write>
    151c:	87aa                	mv	a5,a0
    151e:	873e                	mv	a4,a5
    1520:	47a9                	li	a5,10
    1522:	02f70463          	beq	a4,a5,154a <writetest+0xe0>
      printf("%s: error: write bb %d new file failed\n", s, i);
    1526:	fec42783          	lw	a5,-20(s0)
    152a:	863e                	mv	a2,a5
    152c:	fd843583          	ld	a1,-40(s0)
    1530:	00007517          	auipc	a0,0x7
    1534:	5d050513          	addi	a0,a0,1488 # 8b00 <schedule_rm+0xd06>
    1538:	00006097          	auipc	ra,0x6
    153c:	088080e7          	jalr	136(ra) # 75c0 <printf>
      exit(1);
    1540:	4505                	li	a0,1
    1542:	00006097          	auipc	ra,0x6
    1546:	b38080e7          	jalr	-1224(ra) # 707a <exit>
  for(i = 0; i < N; i++){
    154a:	fec42783          	lw	a5,-20(s0)
    154e:	2785                	addiw	a5,a5,1
    1550:	fef42623          	sw	a5,-20(s0)
    1554:	fec42783          	lw	a5,-20(s0)
    1558:	0007871b          	sext.w	a4,a5
    155c:	06300793          	li	a5,99
    1560:	f4e7dfe3          	bge	a5,a4,14be <writetest+0x54>
    }
  }
  close(fd);
    1564:	fe842783          	lw	a5,-24(s0)
    1568:	853e                	mv	a0,a5
    156a:	00006097          	auipc	ra,0x6
    156e:	b38080e7          	jalr	-1224(ra) # 70a2 <close>
  fd = open("small", O_RDONLY);
    1572:	4581                	li	a1,0
    1574:	00007517          	auipc	a0,0x7
    1578:	51c50513          	addi	a0,a0,1308 # 8a90 <schedule_rm+0xc96>
    157c:	00006097          	auipc	ra,0x6
    1580:	b3e080e7          	jalr	-1218(ra) # 70ba <open>
    1584:	87aa                	mv	a5,a0
    1586:	fef42423          	sw	a5,-24(s0)
  if(fd < 0){
    158a:	fe842783          	lw	a5,-24(s0)
    158e:	2781                	sext.w	a5,a5
    1590:	0207d163          	bgez	a5,15b2 <writetest+0x148>
    printf("%s: error: open small failed!\n", s);
    1594:	fd843583          	ld	a1,-40(s0)
    1598:	00007517          	auipc	a0,0x7
    159c:	59050513          	addi	a0,a0,1424 # 8b28 <schedule_rm+0xd2e>
    15a0:	00006097          	auipc	ra,0x6
    15a4:	020080e7          	jalr	32(ra) # 75c0 <printf>
    exit(1);
    15a8:	4505                	li	a0,1
    15aa:	00006097          	auipc	ra,0x6
    15ae:	ad0080e7          	jalr	-1328(ra) # 707a <exit>
  }
  i = read(fd, buf, N*SZ*2);
    15b2:	fe842783          	lw	a5,-24(s0)
    15b6:	7d000613          	li	a2,2000
    15ba:	00009597          	auipc	a1,0x9
    15be:	34658593          	addi	a1,a1,838 # a900 <buf>
    15c2:	853e                	mv	a0,a5
    15c4:	00006097          	auipc	ra,0x6
    15c8:	ace080e7          	jalr	-1330(ra) # 7092 <read>
    15cc:	87aa                	mv	a5,a0
    15ce:	fef42623          	sw	a5,-20(s0)
  if(i != N*SZ*2){
    15d2:	fec42783          	lw	a5,-20(s0)
    15d6:	0007871b          	sext.w	a4,a5
    15da:	7d000793          	li	a5,2000
    15de:	02f70163          	beq	a4,a5,1600 <writetest+0x196>
    printf("%s: read failed\n", s);
    15e2:	fd843583          	ld	a1,-40(s0)
    15e6:	00007517          	auipc	a0,0x7
    15ea:	56250513          	addi	a0,a0,1378 # 8b48 <schedule_rm+0xd4e>
    15ee:	00006097          	auipc	ra,0x6
    15f2:	fd2080e7          	jalr	-46(ra) # 75c0 <printf>
    exit(1);
    15f6:	4505                	li	a0,1
    15f8:	00006097          	auipc	ra,0x6
    15fc:	a82080e7          	jalr	-1406(ra) # 707a <exit>
  }
  close(fd);
    1600:	fe842783          	lw	a5,-24(s0)
    1604:	853e                	mv	a0,a5
    1606:	00006097          	auipc	ra,0x6
    160a:	a9c080e7          	jalr	-1380(ra) # 70a2 <close>

  if(unlink("small") < 0){
    160e:	00007517          	auipc	a0,0x7
    1612:	48250513          	addi	a0,a0,1154 # 8a90 <schedule_rm+0xc96>
    1616:	00006097          	auipc	ra,0x6
    161a:	ab4080e7          	jalr	-1356(ra) # 70ca <unlink>
    161e:	87aa                	mv	a5,a0
    1620:	0207d163          	bgez	a5,1642 <writetest+0x1d8>
    printf("%s: unlink small failed\n", s);
    1624:	fd843583          	ld	a1,-40(s0)
    1628:	00007517          	auipc	a0,0x7
    162c:	53850513          	addi	a0,a0,1336 # 8b60 <schedule_rm+0xd66>
    1630:	00006097          	auipc	ra,0x6
    1634:	f90080e7          	jalr	-112(ra) # 75c0 <printf>
    exit(1);
    1638:	4505                	li	a0,1
    163a:	00006097          	auipc	ra,0x6
    163e:	a40080e7          	jalr	-1472(ra) # 707a <exit>
  }
}
    1642:	0001                	nop
    1644:	70a2                	ld	ra,40(sp)
    1646:	7402                	ld	s0,32(sp)
    1648:	6145                	addi	sp,sp,48
    164a:	8082                	ret

000000000000164c <writebig>:

void
writebig(char *s)
{
    164c:	7179                	addi	sp,sp,-48
    164e:	f406                	sd	ra,40(sp)
    1650:	f022                	sd	s0,32(sp)
    1652:	1800                	addi	s0,sp,48
    1654:	fca43c23          	sd	a0,-40(s0)
  int i, fd, n;

  fd = open("big", O_CREATE|O_RDWR);
    1658:	20200593          	li	a1,514
    165c:	00007517          	auipc	a0,0x7
    1660:	52450513          	addi	a0,a0,1316 # 8b80 <schedule_rm+0xd86>
    1664:	00006097          	auipc	ra,0x6
    1668:	a56080e7          	jalr	-1450(ra) # 70ba <open>
    166c:	87aa                	mv	a5,a0
    166e:	fef42223          	sw	a5,-28(s0)
  if(fd < 0){
    1672:	fe442783          	lw	a5,-28(s0)
    1676:	2781                	sext.w	a5,a5
    1678:	0207d163          	bgez	a5,169a <writebig+0x4e>
    printf("%s: error: creat big failed!\n", s);
    167c:	fd843583          	ld	a1,-40(s0)
    1680:	00007517          	auipc	a0,0x7
    1684:	50850513          	addi	a0,a0,1288 # 8b88 <schedule_rm+0xd8e>
    1688:	00006097          	auipc	ra,0x6
    168c:	f38080e7          	jalr	-200(ra) # 75c0 <printf>
    exit(1);
    1690:	4505                	li	a0,1
    1692:	00006097          	auipc	ra,0x6
    1696:	9e8080e7          	jalr	-1560(ra) # 707a <exit>
  }

  for(i = 0; i < 100; i++){
    169a:	fe042623          	sw	zero,-20(s0)
    169e:	a095                	j	1702 <writebig+0xb6>
    ((int*)buf)[0] = i;
    16a0:	00009797          	auipc	a5,0x9
    16a4:	26078793          	addi	a5,a5,608 # a900 <buf>
    16a8:	fec42703          	lw	a4,-20(s0)
    16ac:	c398                	sw	a4,0(a5)
    if(write(fd, buf, BSIZE) != BSIZE){
    16ae:	fe442783          	lw	a5,-28(s0)
    16b2:	40000613          	li	a2,1024
    16b6:	00009597          	auipc	a1,0x9
    16ba:	24a58593          	addi	a1,a1,586 # a900 <buf>
    16be:	853e                	mv	a0,a5
    16c0:	00006097          	auipc	ra,0x6
    16c4:	9da080e7          	jalr	-1574(ra) # 709a <write>
    16c8:	87aa                	mv	a5,a0
    16ca:	873e                	mv	a4,a5
    16cc:	40000793          	li	a5,1024
    16d0:	02f70463          	beq	a4,a5,16f8 <writebig+0xac>
      printf("%s: error: write big file failed\n", s, i);
    16d4:	fec42783          	lw	a5,-20(s0)
    16d8:	863e                	mv	a2,a5
    16da:	fd843583          	ld	a1,-40(s0)
    16de:	00007517          	auipc	a0,0x7
    16e2:	4ca50513          	addi	a0,a0,1226 # 8ba8 <schedule_rm+0xdae>
    16e6:	00006097          	auipc	ra,0x6
    16ea:	eda080e7          	jalr	-294(ra) # 75c0 <printf>
      exit(1);
    16ee:	4505                	li	a0,1
    16f0:	00006097          	auipc	ra,0x6
    16f4:	98a080e7          	jalr	-1654(ra) # 707a <exit>
  for(i = 0; i < 100; i++){
    16f8:	fec42783          	lw	a5,-20(s0)
    16fc:	2785                	addiw	a5,a5,1
    16fe:	fef42623          	sw	a5,-20(s0)
    1702:	fec42783          	lw	a5,-20(s0)
    1706:	0007871b          	sext.w	a4,a5
    170a:	06300793          	li	a5,99
    170e:	f8e7d9e3          	bge	a5,a4,16a0 <writebig+0x54>
    }
  }

  close(fd);
    1712:	fe442783          	lw	a5,-28(s0)
    1716:	853e                	mv	a0,a5
    1718:	00006097          	auipc	ra,0x6
    171c:	98a080e7          	jalr	-1654(ra) # 70a2 <close>

  fd = open("big", O_RDONLY);
    1720:	4581                	li	a1,0
    1722:	00007517          	auipc	a0,0x7
    1726:	45e50513          	addi	a0,a0,1118 # 8b80 <schedule_rm+0xd86>
    172a:	00006097          	auipc	ra,0x6
    172e:	990080e7          	jalr	-1648(ra) # 70ba <open>
    1732:	87aa                	mv	a5,a0
    1734:	fef42223          	sw	a5,-28(s0)
  if(fd < 0){
    1738:	fe442783          	lw	a5,-28(s0)
    173c:	2781                	sext.w	a5,a5
    173e:	0207d163          	bgez	a5,1760 <writebig+0x114>
    printf("%s: error: open big failed!\n", s);
    1742:	fd843583          	ld	a1,-40(s0)
    1746:	00007517          	auipc	a0,0x7
    174a:	48a50513          	addi	a0,a0,1162 # 8bd0 <schedule_rm+0xdd6>
    174e:	00006097          	auipc	ra,0x6
    1752:	e72080e7          	jalr	-398(ra) # 75c0 <printf>
    exit(1);
    1756:	4505                	li	a0,1
    1758:	00006097          	auipc	ra,0x6
    175c:	922080e7          	jalr	-1758(ra) # 707a <exit>
  }

  n = 0;
    1760:	fe042423          	sw	zero,-24(s0)
  for(;;){
    i = read(fd, buf, BSIZE);
    1764:	fe442783          	lw	a5,-28(s0)
    1768:	40000613          	li	a2,1024
    176c:	00009597          	auipc	a1,0x9
    1770:	19458593          	addi	a1,a1,404 # a900 <buf>
    1774:	853e                	mv	a0,a5
    1776:	00006097          	auipc	ra,0x6
    177a:	91c080e7          	jalr	-1764(ra) # 7092 <read>
    177e:	87aa                	mv	a5,a0
    1780:	fef42623          	sw	a5,-20(s0)
    if(i == 0){
    1784:	fec42783          	lw	a5,-20(s0)
    1788:	2781                	sext.w	a5,a5
    178a:	eb9d                	bnez	a5,17c0 <writebig+0x174>
      if(n == MAXFILE - 1){
    178c:	fe842783          	lw	a5,-24(s0)
    1790:	0007871b          	sext.w	a4,a5
    1794:	10b00793          	li	a5,267
    1798:	0af71663          	bne	a4,a5,1844 <writebig+0x1f8>
        printf("%s: read only %d blocks from big", s, n);
    179c:	fe842783          	lw	a5,-24(s0)
    17a0:	863e                	mv	a2,a5
    17a2:	fd843583          	ld	a1,-40(s0)
    17a6:	00007517          	auipc	a0,0x7
    17aa:	44a50513          	addi	a0,a0,1098 # 8bf0 <schedule_rm+0xdf6>
    17ae:	00006097          	auipc	ra,0x6
    17b2:	e12080e7          	jalr	-494(ra) # 75c0 <printf>
        exit(1);
    17b6:	4505                	li	a0,1
    17b8:	00006097          	auipc	ra,0x6
    17bc:	8c2080e7          	jalr	-1854(ra) # 707a <exit>
      }
      break;
    } else if(i != BSIZE){
    17c0:	fec42783          	lw	a5,-20(s0)
    17c4:	0007871b          	sext.w	a4,a5
    17c8:	40000793          	li	a5,1024
    17cc:	02f70463          	beq	a4,a5,17f4 <writebig+0x1a8>
      printf("%s: read failed %d\n", s, i);
    17d0:	fec42783          	lw	a5,-20(s0)
    17d4:	863e                	mv	a2,a5
    17d6:	fd843583          	ld	a1,-40(s0)
    17da:	00007517          	auipc	a0,0x7
    17de:	43e50513          	addi	a0,a0,1086 # 8c18 <schedule_rm+0xe1e>
    17e2:	00006097          	auipc	ra,0x6
    17e6:	dde080e7          	jalr	-546(ra) # 75c0 <printf>
      exit(1);
    17ea:	4505                	li	a0,1
    17ec:	00006097          	auipc	ra,0x6
    17f0:	88e080e7          	jalr	-1906(ra) # 707a <exit>
    }
    if(((int*)buf)[0] != n){
    17f4:	00009797          	auipc	a5,0x9
    17f8:	10c78793          	addi	a5,a5,268 # a900 <buf>
    17fc:	4398                	lw	a4,0(a5)
    17fe:	fe842783          	lw	a5,-24(s0)
    1802:	2781                	sext.w	a5,a5
    1804:	02e78a63          	beq	a5,a4,1838 <writebig+0x1ec>
      printf("%s: read content of block %d is %d\n", s,
             n, ((int*)buf)[0]);
    1808:	00009797          	auipc	a5,0x9
    180c:	0f878793          	addi	a5,a5,248 # a900 <buf>
      printf("%s: read content of block %d is %d\n", s,
    1810:	4398                	lw	a4,0(a5)
    1812:	fe842783          	lw	a5,-24(s0)
    1816:	86ba                	mv	a3,a4
    1818:	863e                	mv	a2,a5
    181a:	fd843583          	ld	a1,-40(s0)
    181e:	00007517          	auipc	a0,0x7
    1822:	41250513          	addi	a0,a0,1042 # 8c30 <schedule_rm+0xe36>
    1826:	00006097          	auipc	ra,0x6
    182a:	d9a080e7          	jalr	-614(ra) # 75c0 <printf>
      exit(1);
    182e:	4505                	li	a0,1
    1830:	00006097          	auipc	ra,0x6
    1834:	84a080e7          	jalr	-1974(ra) # 707a <exit>
    }
    n++;
    1838:	fe842783          	lw	a5,-24(s0)
    183c:	2785                	addiw	a5,a5,1
    183e:	fef42423          	sw	a5,-24(s0)
    i = read(fd, buf, BSIZE);
    1842:	b70d                	j	1764 <writebig+0x118>
      break;
    1844:	0001                	nop
  }
  close(fd);
    1846:	fe442783          	lw	a5,-28(s0)
    184a:	853e                	mv	a0,a5
    184c:	00006097          	auipc	ra,0x6
    1850:	856080e7          	jalr	-1962(ra) # 70a2 <close>
  if(unlink("big") < 0){
    1854:	00007517          	auipc	a0,0x7
    1858:	32c50513          	addi	a0,a0,812 # 8b80 <schedule_rm+0xd86>
    185c:	00006097          	auipc	ra,0x6
    1860:	86e080e7          	jalr	-1938(ra) # 70ca <unlink>
    1864:	87aa                	mv	a5,a0
    1866:	0207d163          	bgez	a5,1888 <writebig+0x23c>
    printf("%s: unlink big failed\n", s);
    186a:	fd843583          	ld	a1,-40(s0)
    186e:	00007517          	auipc	a0,0x7
    1872:	3ea50513          	addi	a0,a0,1002 # 8c58 <schedule_rm+0xe5e>
    1876:	00006097          	auipc	ra,0x6
    187a:	d4a080e7          	jalr	-694(ra) # 75c0 <printf>
    exit(1);
    187e:	4505                	li	a0,1
    1880:	00005097          	auipc	ra,0x5
    1884:	7fa080e7          	jalr	2042(ra) # 707a <exit>
  }
}
    1888:	0001                	nop
    188a:	70a2                	ld	ra,40(sp)
    188c:	7402                	ld	s0,32(sp)
    188e:	6145                	addi	sp,sp,48
    1890:	8082                	ret

0000000000001892 <createtest>:

// many creates, followed by unlink test
void
createtest(char *s)
{
    1892:	7179                	addi	sp,sp,-48
    1894:	f406                	sd	ra,40(sp)
    1896:	f022                	sd	s0,32(sp)
    1898:	1800                	addi	s0,sp,48
    189a:	fca43c23          	sd	a0,-40(s0)
  int i, fd;
  enum { N=52 };

  char name[3];
  name[0] = 'a';
    189e:	06100793          	li	a5,97
    18a2:	fef40023          	sb	a5,-32(s0)
  name[2] = '\0';
    18a6:	fe040123          	sb	zero,-30(s0)
  for(i = 0; i < N; i++){
    18aa:	fe042623          	sw	zero,-20(s0)
    18ae:	a099                	j	18f4 <createtest+0x62>
    name[1] = '0' + i;
    18b0:	fec42783          	lw	a5,-20(s0)
    18b4:	0ff7f793          	andi	a5,a5,255
    18b8:	0307879b          	addiw	a5,a5,48
    18bc:	0ff7f793          	andi	a5,a5,255
    18c0:	fef400a3          	sb	a5,-31(s0)
    fd = open(name, O_CREATE|O_RDWR);
    18c4:	fe040793          	addi	a5,s0,-32
    18c8:	20200593          	li	a1,514
    18cc:	853e                	mv	a0,a5
    18ce:	00005097          	auipc	ra,0x5
    18d2:	7ec080e7          	jalr	2028(ra) # 70ba <open>
    18d6:	87aa                	mv	a5,a0
    18d8:	fef42423          	sw	a5,-24(s0)
    close(fd);
    18dc:	fe842783          	lw	a5,-24(s0)
    18e0:	853e                	mv	a0,a5
    18e2:	00005097          	auipc	ra,0x5
    18e6:	7c0080e7          	jalr	1984(ra) # 70a2 <close>
  for(i = 0; i < N; i++){
    18ea:	fec42783          	lw	a5,-20(s0)
    18ee:	2785                	addiw	a5,a5,1
    18f0:	fef42623          	sw	a5,-20(s0)
    18f4:	fec42783          	lw	a5,-20(s0)
    18f8:	0007871b          	sext.w	a4,a5
    18fc:	03300793          	li	a5,51
    1900:	fae7d8e3          	bge	a5,a4,18b0 <createtest+0x1e>
  }
  name[0] = 'a';
    1904:	06100793          	li	a5,97
    1908:	fef40023          	sb	a5,-32(s0)
  name[2] = '\0';
    190c:	fe040123          	sb	zero,-30(s0)
  for(i = 0; i < N; i++){
    1910:	fe042623          	sw	zero,-20(s0)
    1914:	a03d                	j	1942 <createtest+0xb0>
    name[1] = '0' + i;
    1916:	fec42783          	lw	a5,-20(s0)
    191a:	0ff7f793          	andi	a5,a5,255
    191e:	0307879b          	addiw	a5,a5,48
    1922:	0ff7f793          	andi	a5,a5,255
    1926:	fef400a3          	sb	a5,-31(s0)
    unlink(name);
    192a:	fe040793          	addi	a5,s0,-32
    192e:	853e                	mv	a0,a5
    1930:	00005097          	auipc	ra,0x5
    1934:	79a080e7          	jalr	1946(ra) # 70ca <unlink>
  for(i = 0; i < N; i++){
    1938:	fec42783          	lw	a5,-20(s0)
    193c:	2785                	addiw	a5,a5,1
    193e:	fef42623          	sw	a5,-20(s0)
    1942:	fec42783          	lw	a5,-20(s0)
    1946:	0007871b          	sext.w	a4,a5
    194a:	03300793          	li	a5,51
    194e:	fce7d4e3          	bge	a5,a4,1916 <createtest+0x84>
  }
}
    1952:	0001                	nop
    1954:	0001                	nop
    1956:	70a2                	ld	ra,40(sp)
    1958:	7402                	ld	s0,32(sp)
    195a:	6145                	addi	sp,sp,48
    195c:	8082                	ret

000000000000195e <dirtest>:

void dirtest(char *s)
{
    195e:	1101                	addi	sp,sp,-32
    1960:	ec06                	sd	ra,24(sp)
    1962:	e822                	sd	s0,16(sp)
    1964:	1000                	addi	s0,sp,32
    1966:	fea43423          	sd	a0,-24(s0)
  if(mkdir("dir0") < 0){
    196a:	00007517          	auipc	a0,0x7
    196e:	30650513          	addi	a0,a0,774 # 8c70 <schedule_rm+0xe76>
    1972:	00005097          	auipc	ra,0x5
    1976:	770080e7          	jalr	1904(ra) # 70e2 <mkdir>
    197a:	87aa                	mv	a5,a0
    197c:	0207d163          	bgez	a5,199e <dirtest+0x40>
    printf("%s: mkdir failed\n", s);
    1980:	fe843583          	ld	a1,-24(s0)
    1984:	00007517          	auipc	a0,0x7
    1988:	fbc50513          	addi	a0,a0,-68 # 8940 <schedule_rm+0xb46>
    198c:	00006097          	auipc	ra,0x6
    1990:	c34080e7          	jalr	-972(ra) # 75c0 <printf>
    exit(1);
    1994:	4505                	li	a0,1
    1996:	00005097          	auipc	ra,0x5
    199a:	6e4080e7          	jalr	1764(ra) # 707a <exit>
  }

  if(chdir("dir0") < 0){
    199e:	00007517          	auipc	a0,0x7
    19a2:	2d250513          	addi	a0,a0,722 # 8c70 <schedule_rm+0xe76>
    19a6:	00005097          	auipc	ra,0x5
    19aa:	744080e7          	jalr	1860(ra) # 70ea <chdir>
    19ae:	87aa                	mv	a5,a0
    19b0:	0207d163          	bgez	a5,19d2 <dirtest+0x74>
    printf("%s: chdir dir0 failed\n", s);
    19b4:	fe843583          	ld	a1,-24(s0)
    19b8:	00007517          	auipc	a0,0x7
    19bc:	2c050513          	addi	a0,a0,704 # 8c78 <schedule_rm+0xe7e>
    19c0:	00006097          	auipc	ra,0x6
    19c4:	c00080e7          	jalr	-1024(ra) # 75c0 <printf>
    exit(1);
    19c8:	4505                	li	a0,1
    19ca:	00005097          	auipc	ra,0x5
    19ce:	6b0080e7          	jalr	1712(ra) # 707a <exit>
  }

  if(chdir("..") < 0){
    19d2:	00007517          	auipc	a0,0x7
    19d6:	2be50513          	addi	a0,a0,702 # 8c90 <schedule_rm+0xe96>
    19da:	00005097          	auipc	ra,0x5
    19de:	710080e7          	jalr	1808(ra) # 70ea <chdir>
    19e2:	87aa                	mv	a5,a0
    19e4:	0207d163          	bgez	a5,1a06 <dirtest+0xa8>
    printf("%s: chdir .. failed\n", s);
    19e8:	fe843583          	ld	a1,-24(s0)
    19ec:	00007517          	auipc	a0,0x7
    19f0:	2ac50513          	addi	a0,a0,684 # 8c98 <schedule_rm+0xe9e>
    19f4:	00006097          	auipc	ra,0x6
    19f8:	bcc080e7          	jalr	-1076(ra) # 75c0 <printf>
    exit(1);
    19fc:	4505                	li	a0,1
    19fe:	00005097          	auipc	ra,0x5
    1a02:	67c080e7          	jalr	1660(ra) # 707a <exit>
  }

  if(unlink("dir0") < 0){
    1a06:	00007517          	auipc	a0,0x7
    1a0a:	26a50513          	addi	a0,a0,618 # 8c70 <schedule_rm+0xe76>
    1a0e:	00005097          	auipc	ra,0x5
    1a12:	6bc080e7          	jalr	1724(ra) # 70ca <unlink>
    1a16:	87aa                	mv	a5,a0
    1a18:	0207d163          	bgez	a5,1a3a <dirtest+0xdc>
    printf("%s: unlink dir0 failed\n", s);
    1a1c:	fe843583          	ld	a1,-24(s0)
    1a20:	00007517          	auipc	a0,0x7
    1a24:	29050513          	addi	a0,a0,656 # 8cb0 <schedule_rm+0xeb6>
    1a28:	00006097          	auipc	ra,0x6
    1a2c:	b98080e7          	jalr	-1128(ra) # 75c0 <printf>
    exit(1);
    1a30:	4505                	li	a0,1
    1a32:	00005097          	auipc	ra,0x5
    1a36:	648080e7          	jalr	1608(ra) # 707a <exit>
  }
}
    1a3a:	0001                	nop
    1a3c:	60e2                	ld	ra,24(sp)
    1a3e:	6442                	ld	s0,16(sp)
    1a40:	6105                	addi	sp,sp,32
    1a42:	8082                	ret

0000000000001a44 <exectest>:

void
exectest(char *s)
{
    1a44:	715d                	addi	sp,sp,-80
    1a46:	e486                	sd	ra,72(sp)
    1a48:	e0a2                	sd	s0,64(sp)
    1a4a:	0880                	addi	s0,sp,80
    1a4c:	faa43c23          	sd	a0,-72(s0)
  int fd, xstatus, pid;
  char *echoargv[] = { "echo", "OK", 0 };
    1a50:	00007797          	auipc	a5,0x7
    1a54:	c4878793          	addi	a5,a5,-952 # 8698 <schedule_rm+0x89e>
    1a58:	fcf43423          	sd	a5,-56(s0)
    1a5c:	00007797          	auipc	a5,0x7
    1a60:	26c78793          	addi	a5,a5,620 # 8cc8 <schedule_rm+0xece>
    1a64:	fcf43823          	sd	a5,-48(s0)
    1a68:	fc043c23          	sd	zero,-40(s0)
  char buf[3];

  unlink("echo-ok");
    1a6c:	00007517          	auipc	a0,0x7
    1a70:	26450513          	addi	a0,a0,612 # 8cd0 <schedule_rm+0xed6>
    1a74:	00005097          	auipc	ra,0x5
    1a78:	656080e7          	jalr	1622(ra) # 70ca <unlink>
  pid = fork();
    1a7c:	00005097          	auipc	ra,0x5
    1a80:	5f6080e7          	jalr	1526(ra) # 7072 <fork>
    1a84:	87aa                	mv	a5,a0
    1a86:	fef42623          	sw	a5,-20(s0)
  if(pid < 0) {
    1a8a:	fec42783          	lw	a5,-20(s0)
    1a8e:	2781                	sext.w	a5,a5
    1a90:	0207d163          	bgez	a5,1ab2 <exectest+0x6e>
     printf("%s: fork failed\n", s);
    1a94:	fb843583          	ld	a1,-72(s0)
    1a98:	00007517          	auipc	a0,0x7
    1a9c:	e1850513          	addi	a0,a0,-488 # 88b0 <schedule_rm+0xab6>
    1aa0:	00006097          	auipc	ra,0x6
    1aa4:	b20080e7          	jalr	-1248(ra) # 75c0 <printf>
     exit(1);
    1aa8:	4505                	li	a0,1
    1aaa:	00005097          	auipc	ra,0x5
    1aae:	5d0080e7          	jalr	1488(ra) # 707a <exit>
  }
  if(pid == 0) {
    1ab2:	fec42783          	lw	a5,-20(s0)
    1ab6:	2781                	sext.w	a5,a5
    1ab8:	ebd5                	bnez	a5,1b6c <exectest+0x128>
    close(1);
    1aba:	4505                	li	a0,1
    1abc:	00005097          	auipc	ra,0x5
    1ac0:	5e6080e7          	jalr	1510(ra) # 70a2 <close>
    fd = open("echo-ok", O_CREATE|O_WRONLY);
    1ac4:	20100593          	li	a1,513
    1ac8:	00007517          	auipc	a0,0x7
    1acc:	20850513          	addi	a0,a0,520 # 8cd0 <schedule_rm+0xed6>
    1ad0:	00005097          	auipc	ra,0x5
    1ad4:	5ea080e7          	jalr	1514(ra) # 70ba <open>
    1ad8:	87aa                	mv	a5,a0
    1ada:	fef42423          	sw	a5,-24(s0)
    if(fd < 0) {
    1ade:	fe842783          	lw	a5,-24(s0)
    1ae2:	2781                	sext.w	a5,a5
    1ae4:	0207d163          	bgez	a5,1b06 <exectest+0xc2>
      printf("%s: create failed\n", s);
    1ae8:	fb843583          	ld	a1,-72(s0)
    1aec:	00007517          	auipc	a0,0x7
    1af0:	1ec50513          	addi	a0,a0,492 # 8cd8 <schedule_rm+0xede>
    1af4:	00006097          	auipc	ra,0x6
    1af8:	acc080e7          	jalr	-1332(ra) # 75c0 <printf>
      exit(1);
    1afc:	4505                	li	a0,1
    1afe:	00005097          	auipc	ra,0x5
    1b02:	57c080e7          	jalr	1404(ra) # 707a <exit>
    }
    if(fd != 1) {
    1b06:	fe842783          	lw	a5,-24(s0)
    1b0a:	0007871b          	sext.w	a4,a5
    1b0e:	4785                	li	a5,1
    1b10:	02f70163          	beq	a4,a5,1b32 <exectest+0xee>
      printf("%s: wrong fd\n", s);
    1b14:	fb843583          	ld	a1,-72(s0)
    1b18:	00007517          	auipc	a0,0x7
    1b1c:	1d850513          	addi	a0,a0,472 # 8cf0 <schedule_rm+0xef6>
    1b20:	00006097          	auipc	ra,0x6
    1b24:	aa0080e7          	jalr	-1376(ra) # 75c0 <printf>
      exit(1);
    1b28:	4505                	li	a0,1
    1b2a:	00005097          	auipc	ra,0x5
    1b2e:	550080e7          	jalr	1360(ra) # 707a <exit>
    }
    if(exec("echo", echoargv) < 0){
    1b32:	fc840793          	addi	a5,s0,-56
    1b36:	85be                	mv	a1,a5
    1b38:	00007517          	auipc	a0,0x7
    1b3c:	b6050513          	addi	a0,a0,-1184 # 8698 <schedule_rm+0x89e>
    1b40:	00005097          	auipc	ra,0x5
    1b44:	572080e7          	jalr	1394(ra) # 70b2 <exec>
    1b48:	87aa                	mv	a5,a0
    1b4a:	0207d163          	bgez	a5,1b6c <exectest+0x128>
      printf("%s: exec echo failed\n", s);
    1b4e:	fb843583          	ld	a1,-72(s0)
    1b52:	00007517          	auipc	a0,0x7
    1b56:	1ae50513          	addi	a0,a0,430 # 8d00 <schedule_rm+0xf06>
    1b5a:	00006097          	auipc	ra,0x6
    1b5e:	a66080e7          	jalr	-1434(ra) # 75c0 <printf>
      exit(1);
    1b62:	4505                	li	a0,1
    1b64:	00005097          	auipc	ra,0x5
    1b68:	516080e7          	jalr	1302(ra) # 707a <exit>
    }
    // won't get to here
  }
  if (wait(&xstatus) != pid) {
    1b6c:	fe440793          	addi	a5,s0,-28
    1b70:	853e                	mv	a0,a5
    1b72:	00005097          	auipc	ra,0x5
    1b76:	510080e7          	jalr	1296(ra) # 7082 <wait>
    1b7a:	87aa                	mv	a5,a0
    1b7c:	873e                	mv	a4,a5
    1b7e:	fec42783          	lw	a5,-20(s0)
    1b82:	2781                	sext.w	a5,a5
    1b84:	00e78c63          	beq	a5,a4,1b9c <exectest+0x158>
    printf("%s: wait failed!\n", s);
    1b88:	fb843583          	ld	a1,-72(s0)
    1b8c:	00007517          	auipc	a0,0x7
    1b90:	18c50513          	addi	a0,a0,396 # 8d18 <schedule_rm+0xf1e>
    1b94:	00006097          	auipc	ra,0x6
    1b98:	a2c080e7          	jalr	-1492(ra) # 75c0 <printf>
  }
  if(xstatus != 0)
    1b9c:	fe442783          	lw	a5,-28(s0)
    1ba0:	cb81                	beqz	a5,1bb0 <exectest+0x16c>
    exit(xstatus);
    1ba2:	fe442783          	lw	a5,-28(s0)
    1ba6:	853e                	mv	a0,a5
    1ba8:	00005097          	auipc	ra,0x5
    1bac:	4d2080e7          	jalr	1234(ra) # 707a <exit>

  fd = open("echo-ok", O_RDONLY);
    1bb0:	4581                	li	a1,0
    1bb2:	00007517          	auipc	a0,0x7
    1bb6:	11e50513          	addi	a0,a0,286 # 8cd0 <schedule_rm+0xed6>
    1bba:	00005097          	auipc	ra,0x5
    1bbe:	500080e7          	jalr	1280(ra) # 70ba <open>
    1bc2:	87aa                	mv	a5,a0
    1bc4:	fef42423          	sw	a5,-24(s0)
  if(fd < 0) {
    1bc8:	fe842783          	lw	a5,-24(s0)
    1bcc:	2781                	sext.w	a5,a5
    1bce:	0207d163          	bgez	a5,1bf0 <exectest+0x1ac>
    printf("%s: open failed\n", s);
    1bd2:	fb843583          	ld	a1,-72(s0)
    1bd6:	00007517          	auipc	a0,0x7
    1bda:	cf250513          	addi	a0,a0,-782 # 88c8 <schedule_rm+0xace>
    1bde:	00006097          	auipc	ra,0x6
    1be2:	9e2080e7          	jalr	-1566(ra) # 75c0 <printf>
    exit(1);
    1be6:	4505                	li	a0,1
    1be8:	00005097          	auipc	ra,0x5
    1bec:	492080e7          	jalr	1170(ra) # 707a <exit>
  }
  if (read(fd, buf, 2) != 2) {
    1bf0:	fc040713          	addi	a4,s0,-64
    1bf4:	fe842783          	lw	a5,-24(s0)
    1bf8:	4609                	li	a2,2
    1bfa:	85ba                	mv	a1,a4
    1bfc:	853e                	mv	a0,a5
    1bfe:	00005097          	auipc	ra,0x5
    1c02:	494080e7          	jalr	1172(ra) # 7092 <read>
    1c06:	87aa                	mv	a5,a0
    1c08:	873e                	mv	a4,a5
    1c0a:	4789                	li	a5,2
    1c0c:	02f70163          	beq	a4,a5,1c2e <exectest+0x1ea>
    printf("%s: read failed\n", s);
    1c10:	fb843583          	ld	a1,-72(s0)
    1c14:	00007517          	auipc	a0,0x7
    1c18:	f3450513          	addi	a0,a0,-204 # 8b48 <schedule_rm+0xd4e>
    1c1c:	00006097          	auipc	ra,0x6
    1c20:	9a4080e7          	jalr	-1628(ra) # 75c0 <printf>
    exit(1);
    1c24:	4505                	li	a0,1
    1c26:	00005097          	auipc	ra,0x5
    1c2a:	454080e7          	jalr	1108(ra) # 707a <exit>
  }
  unlink("echo-ok");
    1c2e:	00007517          	auipc	a0,0x7
    1c32:	0a250513          	addi	a0,a0,162 # 8cd0 <schedule_rm+0xed6>
    1c36:	00005097          	auipc	ra,0x5
    1c3a:	494080e7          	jalr	1172(ra) # 70ca <unlink>
  if(buf[0] == 'O' && buf[1] == 'K')
    1c3e:	fc044783          	lbu	a5,-64(s0)
    1c42:	873e                	mv	a4,a5
    1c44:	04f00793          	li	a5,79
    1c48:	00f71e63          	bne	a4,a5,1c64 <exectest+0x220>
    1c4c:	fc144783          	lbu	a5,-63(s0)
    1c50:	873e                	mv	a4,a5
    1c52:	04b00793          	li	a5,75
    1c56:	00f71763          	bne	a4,a5,1c64 <exectest+0x220>
    exit(0);
    1c5a:	4501                	li	a0,0
    1c5c:	00005097          	auipc	ra,0x5
    1c60:	41e080e7          	jalr	1054(ra) # 707a <exit>
  else {
    printf("%s: wrong output\n", s);
    1c64:	fb843583          	ld	a1,-72(s0)
    1c68:	00007517          	auipc	a0,0x7
    1c6c:	0c850513          	addi	a0,a0,200 # 8d30 <schedule_rm+0xf36>
    1c70:	00006097          	auipc	ra,0x6
    1c74:	950080e7          	jalr	-1712(ra) # 75c0 <printf>
    exit(1);
    1c78:	4505                	li	a0,1
    1c7a:	00005097          	auipc	ra,0x5
    1c7e:	400080e7          	jalr	1024(ra) # 707a <exit>

0000000000001c82 <pipe1>:

// simple fork and pipe read/write

void
pipe1(char *s)
{
    1c82:	715d                	addi	sp,sp,-80
    1c84:	e486                	sd	ra,72(sp)
    1c86:	e0a2                	sd	s0,64(sp)
    1c88:	0880                	addi	s0,sp,80
    1c8a:	faa43c23          	sd	a0,-72(s0)
  int fds[2], pid, xstatus;
  int seq, i, n, cc, total;
  enum { N=5, SZ=1033 };
  
  if(pipe(fds) != 0){
    1c8e:	fd040793          	addi	a5,s0,-48
    1c92:	853e                	mv	a0,a5
    1c94:	00005097          	auipc	ra,0x5
    1c98:	3f6080e7          	jalr	1014(ra) # 708a <pipe>
    1c9c:	87aa                	mv	a5,a0
    1c9e:	c385                	beqz	a5,1cbe <pipe1+0x3c>
    printf("%s: pipe() failed\n", s);
    1ca0:	fb843583          	ld	a1,-72(s0)
    1ca4:	00007517          	auipc	a0,0x7
    1ca8:	0a450513          	addi	a0,a0,164 # 8d48 <schedule_rm+0xf4e>
    1cac:	00006097          	auipc	ra,0x6
    1cb0:	914080e7          	jalr	-1772(ra) # 75c0 <printf>
    exit(1);
    1cb4:	4505                	li	a0,1
    1cb6:	00005097          	auipc	ra,0x5
    1cba:	3c4080e7          	jalr	964(ra) # 707a <exit>
  }
  pid = fork();
    1cbe:	00005097          	auipc	ra,0x5
    1cc2:	3b4080e7          	jalr	948(ra) # 7072 <fork>
    1cc6:	87aa                	mv	a5,a0
    1cc8:	fcf42c23          	sw	a5,-40(s0)
  seq = 0;
    1ccc:	fe042623          	sw	zero,-20(s0)
  if(pid == 0){
    1cd0:	fd842783          	lw	a5,-40(s0)
    1cd4:	2781                	sext.w	a5,a5
    1cd6:	efdd                	bnez	a5,1d94 <pipe1+0x112>
    close(fds[0]);
    1cd8:	fd042783          	lw	a5,-48(s0)
    1cdc:	853e                	mv	a0,a5
    1cde:	00005097          	auipc	ra,0x5
    1ce2:	3c4080e7          	jalr	964(ra) # 70a2 <close>
    for(n = 0; n < N; n++){
    1ce6:	fe042223          	sw	zero,-28(s0)
    1cea:	a849                	j	1d7c <pipe1+0xfa>
      for(i = 0; i < SZ; i++)
    1cec:	fe042423          	sw	zero,-24(s0)
    1cf0:	a03d                	j	1d1e <pipe1+0x9c>
        buf[i] = seq++;
    1cf2:	fec42783          	lw	a5,-20(s0)
    1cf6:	0017871b          	addiw	a4,a5,1
    1cfa:	fee42623          	sw	a4,-20(s0)
    1cfe:	0ff7f713          	andi	a4,a5,255
    1d02:	00009697          	auipc	a3,0x9
    1d06:	bfe68693          	addi	a3,a3,-1026 # a900 <buf>
    1d0a:	fe842783          	lw	a5,-24(s0)
    1d0e:	97b6                	add	a5,a5,a3
    1d10:	00e78023          	sb	a4,0(a5)
      for(i = 0; i < SZ; i++)
    1d14:	fe842783          	lw	a5,-24(s0)
    1d18:	2785                	addiw	a5,a5,1
    1d1a:	fef42423          	sw	a5,-24(s0)
    1d1e:	fe842783          	lw	a5,-24(s0)
    1d22:	0007871b          	sext.w	a4,a5
    1d26:	40800793          	li	a5,1032
    1d2a:	fce7d4e3          	bge	a5,a4,1cf2 <pipe1+0x70>
      if(write(fds[1], buf, SZ) != SZ){
    1d2e:	fd442783          	lw	a5,-44(s0)
    1d32:	40900613          	li	a2,1033
    1d36:	00009597          	auipc	a1,0x9
    1d3a:	bca58593          	addi	a1,a1,-1078 # a900 <buf>
    1d3e:	853e                	mv	a0,a5
    1d40:	00005097          	auipc	ra,0x5
    1d44:	35a080e7          	jalr	858(ra) # 709a <write>
    1d48:	87aa                	mv	a5,a0
    1d4a:	873e                	mv	a4,a5
    1d4c:	40900793          	li	a5,1033
    1d50:	02f70163          	beq	a4,a5,1d72 <pipe1+0xf0>
        printf("%s: pipe1 oops 1\n", s);
    1d54:	fb843583          	ld	a1,-72(s0)
    1d58:	00007517          	auipc	a0,0x7
    1d5c:	00850513          	addi	a0,a0,8 # 8d60 <schedule_rm+0xf66>
    1d60:	00006097          	auipc	ra,0x6
    1d64:	860080e7          	jalr	-1952(ra) # 75c0 <printf>
        exit(1);
    1d68:	4505                	li	a0,1
    1d6a:	00005097          	auipc	ra,0x5
    1d6e:	310080e7          	jalr	784(ra) # 707a <exit>
    for(n = 0; n < N; n++){
    1d72:	fe442783          	lw	a5,-28(s0)
    1d76:	2785                	addiw	a5,a5,1
    1d78:	fef42223          	sw	a5,-28(s0)
    1d7c:	fe442783          	lw	a5,-28(s0)
    1d80:	0007871b          	sext.w	a4,a5
    1d84:	4791                	li	a5,4
    1d86:	f6e7d3e3          	bge	a5,a4,1cec <pipe1+0x6a>
      }
    }
    exit(0);
    1d8a:	4501                	li	a0,0
    1d8c:	00005097          	auipc	ra,0x5
    1d90:	2ee080e7          	jalr	750(ra) # 707a <exit>
  } else if(pid > 0){
    1d94:	fd842783          	lw	a5,-40(s0)
    1d98:	2781                	sext.w	a5,a5
    1d9a:	12f05b63          	blez	a5,1ed0 <pipe1+0x24e>
    close(fds[1]);
    1d9e:	fd442783          	lw	a5,-44(s0)
    1da2:	853e                	mv	a0,a5
    1da4:	00005097          	auipc	ra,0x5
    1da8:	2fe080e7          	jalr	766(ra) # 70a2 <close>
    total = 0;
    1dac:	fc042e23          	sw	zero,-36(s0)
    cc = 1;
    1db0:	4785                	li	a5,1
    1db2:	fef42023          	sw	a5,-32(s0)
    while((n = read(fds[0], buf, cc)) > 0){
    1db6:	a849                	j	1e48 <pipe1+0x1c6>
      for(i = 0; i < n; i++){
    1db8:	fe042423          	sw	zero,-24(s0)
    1dbc:	a881                	j	1e0c <pipe1+0x18a>
        if((buf[i] & 0xff) != (seq++ & 0xff)){
    1dbe:	00009717          	auipc	a4,0x9
    1dc2:	b4270713          	addi	a4,a4,-1214 # a900 <buf>
    1dc6:	fe842783          	lw	a5,-24(s0)
    1dca:	97ba                	add	a5,a5,a4
    1dcc:	0007c783          	lbu	a5,0(a5)
    1dd0:	0007869b          	sext.w	a3,a5
    1dd4:	fec42783          	lw	a5,-20(s0)
    1dd8:	0017871b          	addiw	a4,a5,1
    1ddc:	fee42623          	sw	a4,-20(s0)
    1de0:	0ff7f793          	andi	a5,a5,255
    1de4:	2781                	sext.w	a5,a5
    1de6:	8736                	mv	a4,a3
    1de8:	00f70d63          	beq	a4,a5,1e02 <pipe1+0x180>
          printf("%s: pipe1 oops 2\n", s);
    1dec:	fb843583          	ld	a1,-72(s0)
    1df0:	00007517          	auipc	a0,0x7
    1df4:	f8850513          	addi	a0,a0,-120 # 8d78 <schedule_rm+0xf7e>
    1df8:	00005097          	auipc	ra,0x5
    1dfc:	7c8080e7          	jalr	1992(ra) # 75c0 <printf>
          return;
    1e00:	a0fd                	j	1eee <pipe1+0x26c>
      for(i = 0; i < n; i++){
    1e02:	fe842783          	lw	a5,-24(s0)
    1e06:	2785                	addiw	a5,a5,1
    1e08:	fef42423          	sw	a5,-24(s0)
    1e0c:	fe842703          	lw	a4,-24(s0)
    1e10:	fe442783          	lw	a5,-28(s0)
    1e14:	2701                	sext.w	a4,a4
    1e16:	2781                	sext.w	a5,a5
    1e18:	faf743e3          	blt	a4,a5,1dbe <pipe1+0x13c>
        }
      }
      total += n;
    1e1c:	fdc42703          	lw	a4,-36(s0)
    1e20:	fe442783          	lw	a5,-28(s0)
    1e24:	9fb9                	addw	a5,a5,a4
    1e26:	fcf42e23          	sw	a5,-36(s0)
      cc = cc * 2;
    1e2a:	fe042783          	lw	a5,-32(s0)
    1e2e:	0017979b          	slliw	a5,a5,0x1
    1e32:	fef42023          	sw	a5,-32(s0)
      if(cc > sizeof(buf))
    1e36:	fe042783          	lw	a5,-32(s0)
    1e3a:	873e                	mv	a4,a5
    1e3c:	678d                	lui	a5,0x3
    1e3e:	00e7f563          	bgeu	a5,a4,1e48 <pipe1+0x1c6>
        cc = sizeof(buf);
    1e42:	678d                	lui	a5,0x3
    1e44:	fef42023          	sw	a5,-32(s0)
    while((n = read(fds[0], buf, cc)) > 0){
    1e48:	fd042783          	lw	a5,-48(s0)
    1e4c:	fe042703          	lw	a4,-32(s0)
    1e50:	863a                	mv	a2,a4
    1e52:	00009597          	auipc	a1,0x9
    1e56:	aae58593          	addi	a1,a1,-1362 # a900 <buf>
    1e5a:	853e                	mv	a0,a5
    1e5c:	00005097          	auipc	ra,0x5
    1e60:	236080e7          	jalr	566(ra) # 7092 <read>
    1e64:	87aa                	mv	a5,a0
    1e66:	fef42223          	sw	a5,-28(s0)
    1e6a:	fe442783          	lw	a5,-28(s0)
    1e6e:	2781                	sext.w	a5,a5
    1e70:	f4f044e3          	bgtz	a5,1db8 <pipe1+0x136>
    }
    if(total != N * SZ){
    1e74:	fdc42783          	lw	a5,-36(s0)
    1e78:	0007871b          	sext.w	a4,a5
    1e7c:	6785                	lui	a5,0x1
    1e7e:	42d78793          	addi	a5,a5,1069 # 142d <opentest+0x67>
    1e82:	02f70263          	beq	a4,a5,1ea6 <pipe1+0x224>
      printf("%s: pipe1 oops 3 total %d\n", total);
    1e86:	fdc42783          	lw	a5,-36(s0)
    1e8a:	85be                	mv	a1,a5
    1e8c:	00007517          	auipc	a0,0x7
    1e90:	f0450513          	addi	a0,a0,-252 # 8d90 <schedule_rm+0xf96>
    1e94:	00005097          	auipc	ra,0x5
    1e98:	72c080e7          	jalr	1836(ra) # 75c0 <printf>
      exit(1);
    1e9c:	4505                	li	a0,1
    1e9e:	00005097          	auipc	ra,0x5
    1ea2:	1dc080e7          	jalr	476(ra) # 707a <exit>
    }
    close(fds[0]);
    1ea6:	fd042783          	lw	a5,-48(s0)
    1eaa:	853e                	mv	a0,a5
    1eac:	00005097          	auipc	ra,0x5
    1eb0:	1f6080e7          	jalr	502(ra) # 70a2 <close>
    wait(&xstatus);
    1eb4:	fcc40793          	addi	a5,s0,-52
    1eb8:	853e                	mv	a0,a5
    1eba:	00005097          	auipc	ra,0x5
    1ebe:	1c8080e7          	jalr	456(ra) # 7082 <wait>
    exit(xstatus);
    1ec2:	fcc42783          	lw	a5,-52(s0)
    1ec6:	853e                	mv	a0,a5
    1ec8:	00005097          	auipc	ra,0x5
    1ecc:	1b2080e7          	jalr	434(ra) # 707a <exit>
  } else {
    printf("%s: fork() failed\n", s);
    1ed0:	fb843583          	ld	a1,-72(s0)
    1ed4:	00007517          	auipc	a0,0x7
    1ed8:	edc50513          	addi	a0,a0,-292 # 8db0 <schedule_rm+0xfb6>
    1edc:	00005097          	auipc	ra,0x5
    1ee0:	6e4080e7          	jalr	1764(ra) # 75c0 <printf>
    exit(1);
    1ee4:	4505                	li	a0,1
    1ee6:	00005097          	auipc	ra,0x5
    1eea:	194080e7          	jalr	404(ra) # 707a <exit>
  }
}
    1eee:	60a6                	ld	ra,72(sp)
    1ef0:	6406                	ld	s0,64(sp)
    1ef2:	6161                	addi	sp,sp,80
    1ef4:	8082                	ret

0000000000001ef6 <preempt>:

// meant to be run w/ at most two CPUs
void
preempt(char *s)
{
    1ef6:	7139                	addi	sp,sp,-64
    1ef8:	fc06                	sd	ra,56(sp)
    1efa:	f822                	sd	s0,48(sp)
    1efc:	0080                	addi	s0,sp,64
    1efe:	fca43423          	sd	a0,-56(s0)
  int pid1, pid2, pid3;
  int pfds[2];

  pid1 = fork();
    1f02:	00005097          	auipc	ra,0x5
    1f06:	170080e7          	jalr	368(ra) # 7072 <fork>
    1f0a:	87aa                	mv	a5,a0
    1f0c:	fef42623          	sw	a5,-20(s0)
  if(pid1 < 0) {
    1f10:	fec42783          	lw	a5,-20(s0)
    1f14:	2781                	sext.w	a5,a5
    1f16:	0207d163          	bgez	a5,1f38 <preempt+0x42>
    printf("%s: fork failed", s);
    1f1a:	fc843583          	ld	a1,-56(s0)
    1f1e:	00007517          	auipc	a0,0x7
    1f22:	eaa50513          	addi	a0,a0,-342 # 8dc8 <schedule_rm+0xfce>
    1f26:	00005097          	auipc	ra,0x5
    1f2a:	69a080e7          	jalr	1690(ra) # 75c0 <printf>
    exit(1);
    1f2e:	4505                	li	a0,1
    1f30:	00005097          	auipc	ra,0x5
    1f34:	14a080e7          	jalr	330(ra) # 707a <exit>
  }
  if(pid1 == 0)
    1f38:	fec42783          	lw	a5,-20(s0)
    1f3c:	2781                	sext.w	a5,a5
    1f3e:	e391                	bnez	a5,1f42 <preempt+0x4c>
    for(;;)
    1f40:	a001                	j	1f40 <preempt+0x4a>
      ;

  pid2 = fork();
    1f42:	00005097          	auipc	ra,0x5
    1f46:	130080e7          	jalr	304(ra) # 7072 <fork>
    1f4a:	87aa                	mv	a5,a0
    1f4c:	fef42423          	sw	a5,-24(s0)
  if(pid2 < 0) {
    1f50:	fe842783          	lw	a5,-24(s0)
    1f54:	2781                	sext.w	a5,a5
    1f56:	0207d163          	bgez	a5,1f78 <preempt+0x82>
    printf("%s: fork failed\n", s);
    1f5a:	fc843583          	ld	a1,-56(s0)
    1f5e:	00007517          	auipc	a0,0x7
    1f62:	95250513          	addi	a0,a0,-1710 # 88b0 <schedule_rm+0xab6>
    1f66:	00005097          	auipc	ra,0x5
    1f6a:	65a080e7          	jalr	1626(ra) # 75c0 <printf>
    exit(1);
    1f6e:	4505                	li	a0,1
    1f70:	00005097          	auipc	ra,0x5
    1f74:	10a080e7          	jalr	266(ra) # 707a <exit>
  }
  if(pid2 == 0)
    1f78:	fe842783          	lw	a5,-24(s0)
    1f7c:	2781                	sext.w	a5,a5
    1f7e:	e391                	bnez	a5,1f82 <preempt+0x8c>
    for(;;)
    1f80:	a001                	j	1f80 <preempt+0x8a>
      ;

  pipe(pfds);
    1f82:	fd840793          	addi	a5,s0,-40
    1f86:	853e                	mv	a0,a5
    1f88:	00005097          	auipc	ra,0x5
    1f8c:	102080e7          	jalr	258(ra) # 708a <pipe>
  pid3 = fork();
    1f90:	00005097          	auipc	ra,0x5
    1f94:	0e2080e7          	jalr	226(ra) # 7072 <fork>
    1f98:	87aa                	mv	a5,a0
    1f9a:	fef42223          	sw	a5,-28(s0)
  if(pid3 < 0) {
    1f9e:	fe442783          	lw	a5,-28(s0)
    1fa2:	2781                	sext.w	a5,a5
    1fa4:	0207d163          	bgez	a5,1fc6 <preempt+0xd0>
     printf("%s: fork failed\n", s);
    1fa8:	fc843583          	ld	a1,-56(s0)
    1fac:	00007517          	auipc	a0,0x7
    1fb0:	90450513          	addi	a0,a0,-1788 # 88b0 <schedule_rm+0xab6>
    1fb4:	00005097          	auipc	ra,0x5
    1fb8:	60c080e7          	jalr	1548(ra) # 75c0 <printf>
     exit(1);
    1fbc:	4505                	li	a0,1
    1fbe:	00005097          	auipc	ra,0x5
    1fc2:	0bc080e7          	jalr	188(ra) # 707a <exit>
  }
  if(pid3 == 0){
    1fc6:	fe442783          	lw	a5,-28(s0)
    1fca:	2781                	sext.w	a5,a5
    1fcc:	ebb9                	bnez	a5,2022 <preempt+0x12c>
    close(pfds[0]);
    1fce:	fd842783          	lw	a5,-40(s0)
    1fd2:	853e                	mv	a0,a5
    1fd4:	00005097          	auipc	ra,0x5
    1fd8:	0ce080e7          	jalr	206(ra) # 70a2 <close>
    if(write(pfds[1], "x", 1) != 1)
    1fdc:	fdc42783          	lw	a5,-36(s0)
    1fe0:	4605                	li	a2,1
    1fe2:	00006597          	auipc	a1,0x6
    1fe6:	5a658593          	addi	a1,a1,1446 # 8588 <schedule_rm+0x78e>
    1fea:	853e                	mv	a0,a5
    1fec:	00005097          	auipc	ra,0x5
    1ff0:	0ae080e7          	jalr	174(ra) # 709a <write>
    1ff4:	87aa                	mv	a5,a0
    1ff6:	873e                	mv	a4,a5
    1ff8:	4785                	li	a5,1
    1ffa:	00f70c63          	beq	a4,a5,2012 <preempt+0x11c>
      printf("%s: preempt write error", s);
    1ffe:	fc843583          	ld	a1,-56(s0)
    2002:	00007517          	auipc	a0,0x7
    2006:	dd650513          	addi	a0,a0,-554 # 8dd8 <schedule_rm+0xfde>
    200a:	00005097          	auipc	ra,0x5
    200e:	5b6080e7          	jalr	1462(ra) # 75c0 <printf>
    close(pfds[1]);
    2012:	fdc42783          	lw	a5,-36(s0)
    2016:	853e                	mv	a0,a5
    2018:	00005097          	auipc	ra,0x5
    201c:	08a080e7          	jalr	138(ra) # 70a2 <close>
    for(;;)
    2020:	a001                	j	2020 <preempt+0x12a>
      ;
  }

  close(pfds[1]);
    2022:	fdc42783          	lw	a5,-36(s0)
    2026:	853e                	mv	a0,a5
    2028:	00005097          	auipc	ra,0x5
    202c:	07a080e7          	jalr	122(ra) # 70a2 <close>
  if(read(pfds[0], buf, sizeof(buf)) != 1){
    2030:	fd842783          	lw	a5,-40(s0)
    2034:	660d                	lui	a2,0x3
    2036:	00009597          	auipc	a1,0x9
    203a:	8ca58593          	addi	a1,a1,-1846 # a900 <buf>
    203e:	853e                	mv	a0,a5
    2040:	00005097          	auipc	ra,0x5
    2044:	052080e7          	jalr	82(ra) # 7092 <read>
    2048:	87aa                	mv	a5,a0
    204a:	873e                	mv	a4,a5
    204c:	4785                	li	a5,1
    204e:	00f70d63          	beq	a4,a5,2068 <preempt+0x172>
    printf("%s: preempt read error", s);
    2052:	fc843583          	ld	a1,-56(s0)
    2056:	00007517          	auipc	a0,0x7
    205a:	d9a50513          	addi	a0,a0,-614 # 8df0 <schedule_rm+0xff6>
    205e:	00005097          	auipc	ra,0x5
    2062:	562080e7          	jalr	1378(ra) # 75c0 <printf>
    2066:	a8a5                	j	20de <preempt+0x1e8>
    return;
  }
  close(pfds[0]);
    2068:	fd842783          	lw	a5,-40(s0)
    206c:	853e                	mv	a0,a5
    206e:	00005097          	auipc	ra,0x5
    2072:	034080e7          	jalr	52(ra) # 70a2 <close>
  printf("kill... ");
    2076:	00007517          	auipc	a0,0x7
    207a:	d9250513          	addi	a0,a0,-622 # 8e08 <schedule_rm+0x100e>
    207e:	00005097          	auipc	ra,0x5
    2082:	542080e7          	jalr	1346(ra) # 75c0 <printf>
  kill(pid1);
    2086:	fec42783          	lw	a5,-20(s0)
    208a:	853e                	mv	a0,a5
    208c:	00005097          	auipc	ra,0x5
    2090:	01e080e7          	jalr	30(ra) # 70aa <kill>
  kill(pid2);
    2094:	fe842783          	lw	a5,-24(s0)
    2098:	853e                	mv	a0,a5
    209a:	00005097          	auipc	ra,0x5
    209e:	010080e7          	jalr	16(ra) # 70aa <kill>
  kill(pid3);
    20a2:	fe442783          	lw	a5,-28(s0)
    20a6:	853e                	mv	a0,a5
    20a8:	00005097          	auipc	ra,0x5
    20ac:	002080e7          	jalr	2(ra) # 70aa <kill>
  printf("wait... ");
    20b0:	00007517          	auipc	a0,0x7
    20b4:	d6850513          	addi	a0,a0,-664 # 8e18 <schedule_rm+0x101e>
    20b8:	00005097          	auipc	ra,0x5
    20bc:	508080e7          	jalr	1288(ra) # 75c0 <printf>
  wait(0);
    20c0:	4501                	li	a0,0
    20c2:	00005097          	auipc	ra,0x5
    20c6:	fc0080e7          	jalr	-64(ra) # 7082 <wait>
  wait(0);
    20ca:	4501                	li	a0,0
    20cc:	00005097          	auipc	ra,0x5
    20d0:	fb6080e7          	jalr	-74(ra) # 7082 <wait>
  wait(0);
    20d4:	4501                	li	a0,0
    20d6:	00005097          	auipc	ra,0x5
    20da:	fac080e7          	jalr	-84(ra) # 7082 <wait>
}
    20de:	70e2                	ld	ra,56(sp)
    20e0:	7442                	ld	s0,48(sp)
    20e2:	6121                	addi	sp,sp,64
    20e4:	8082                	ret

00000000000020e6 <exitwait>:

// try to find any races between exit and wait
void
exitwait(char *s)
{
    20e6:	7179                	addi	sp,sp,-48
    20e8:	f406                	sd	ra,40(sp)
    20ea:	f022                	sd	s0,32(sp)
    20ec:	1800                	addi	s0,sp,48
    20ee:	fca43c23          	sd	a0,-40(s0)
  int i, pid;

  for(i = 0; i < 100; i++){
    20f2:	fe042623          	sw	zero,-20(s0)
    20f6:	a87d                	j	21b4 <exitwait+0xce>
    pid = fork();
    20f8:	00005097          	auipc	ra,0x5
    20fc:	f7a080e7          	jalr	-134(ra) # 7072 <fork>
    2100:	87aa                	mv	a5,a0
    2102:	fef42423          	sw	a5,-24(s0)
    if(pid < 0){
    2106:	fe842783          	lw	a5,-24(s0)
    210a:	2781                	sext.w	a5,a5
    210c:	0207d163          	bgez	a5,212e <exitwait+0x48>
      printf("%s: fork failed\n", s);
    2110:	fd843583          	ld	a1,-40(s0)
    2114:	00006517          	auipc	a0,0x6
    2118:	79c50513          	addi	a0,a0,1948 # 88b0 <schedule_rm+0xab6>
    211c:	00005097          	auipc	ra,0x5
    2120:	4a4080e7          	jalr	1188(ra) # 75c0 <printf>
      exit(1);
    2124:	4505                	li	a0,1
    2126:	00005097          	auipc	ra,0x5
    212a:	f54080e7          	jalr	-172(ra) # 707a <exit>
    }
    if(pid){
    212e:	fe842783          	lw	a5,-24(s0)
    2132:	2781                	sext.w	a5,a5
    2134:	c7a5                	beqz	a5,219c <exitwait+0xb6>
      int xstate;
      if(wait(&xstate) != pid){
    2136:	fe440793          	addi	a5,s0,-28
    213a:	853e                	mv	a0,a5
    213c:	00005097          	auipc	ra,0x5
    2140:	f46080e7          	jalr	-186(ra) # 7082 <wait>
    2144:	87aa                	mv	a5,a0
    2146:	873e                	mv	a4,a5
    2148:	fe842783          	lw	a5,-24(s0)
    214c:	2781                	sext.w	a5,a5
    214e:	02e78163          	beq	a5,a4,2170 <exitwait+0x8a>
        printf("%s: wait wrong pid\n", s);
    2152:	fd843583          	ld	a1,-40(s0)
    2156:	00007517          	auipc	a0,0x7
    215a:	cd250513          	addi	a0,a0,-814 # 8e28 <schedule_rm+0x102e>
    215e:	00005097          	auipc	ra,0x5
    2162:	462080e7          	jalr	1122(ra) # 75c0 <printf>
        exit(1);
    2166:	4505                	li	a0,1
    2168:	00005097          	auipc	ra,0x5
    216c:	f12080e7          	jalr	-238(ra) # 707a <exit>
      }
      if(i != xstate) {
    2170:	fe442703          	lw	a4,-28(s0)
    2174:	fec42783          	lw	a5,-20(s0)
    2178:	2781                	sext.w	a5,a5
    217a:	02e78863          	beq	a5,a4,21aa <exitwait+0xc4>
        printf("%s: wait wrong exit status\n", s);
    217e:	fd843583          	ld	a1,-40(s0)
    2182:	00007517          	auipc	a0,0x7
    2186:	cbe50513          	addi	a0,a0,-834 # 8e40 <schedule_rm+0x1046>
    218a:	00005097          	auipc	ra,0x5
    218e:	436080e7          	jalr	1078(ra) # 75c0 <printf>
        exit(1);
    2192:	4505                	li	a0,1
    2194:	00005097          	auipc	ra,0x5
    2198:	ee6080e7          	jalr	-282(ra) # 707a <exit>
      }
    } else {
      exit(i);
    219c:	fec42783          	lw	a5,-20(s0)
    21a0:	853e                	mv	a0,a5
    21a2:	00005097          	auipc	ra,0x5
    21a6:	ed8080e7          	jalr	-296(ra) # 707a <exit>
  for(i = 0; i < 100; i++){
    21aa:	fec42783          	lw	a5,-20(s0)
    21ae:	2785                	addiw	a5,a5,1
    21b0:	fef42623          	sw	a5,-20(s0)
    21b4:	fec42783          	lw	a5,-20(s0)
    21b8:	0007871b          	sext.w	a4,a5
    21bc:	06300793          	li	a5,99
    21c0:	f2e7dce3          	bge	a5,a4,20f8 <exitwait+0x12>
    }
  }
}
    21c4:	0001                	nop
    21c6:	0001                	nop
    21c8:	70a2                	ld	ra,40(sp)
    21ca:	7402                	ld	s0,32(sp)
    21cc:	6145                	addi	sp,sp,48
    21ce:	8082                	ret

00000000000021d0 <reparent>:
// try to find races in the reparenting
// code that handles a parent exiting
// when it still has live children.
void
reparent(char *s)
{
    21d0:	7179                	addi	sp,sp,-48
    21d2:	f406                	sd	ra,40(sp)
    21d4:	f022                	sd	s0,32(sp)
    21d6:	1800                	addi	s0,sp,48
    21d8:	fca43c23          	sd	a0,-40(s0)
  int master_pid = getpid();
    21dc:	00005097          	auipc	ra,0x5
    21e0:	f1e080e7          	jalr	-226(ra) # 70fa <getpid>
    21e4:	87aa                	mv	a5,a0
    21e6:	fef42423          	sw	a5,-24(s0)
  for(int i = 0; i < 200; i++){
    21ea:	fe042623          	sw	zero,-20(s0)
    21ee:	a86d                	j	22a8 <reparent+0xd8>
    int pid = fork();
    21f0:	00005097          	auipc	ra,0x5
    21f4:	e82080e7          	jalr	-382(ra) # 7072 <fork>
    21f8:	87aa                	mv	a5,a0
    21fa:	fef42223          	sw	a5,-28(s0)
    if(pid < 0){
    21fe:	fe442783          	lw	a5,-28(s0)
    2202:	2781                	sext.w	a5,a5
    2204:	0207d163          	bgez	a5,2226 <reparent+0x56>
      printf("%s: fork failed\n", s);
    2208:	fd843583          	ld	a1,-40(s0)
    220c:	00006517          	auipc	a0,0x6
    2210:	6a450513          	addi	a0,a0,1700 # 88b0 <schedule_rm+0xab6>
    2214:	00005097          	auipc	ra,0x5
    2218:	3ac080e7          	jalr	940(ra) # 75c0 <printf>
      exit(1);
    221c:	4505                	li	a0,1
    221e:	00005097          	auipc	ra,0x5
    2222:	e5c080e7          	jalr	-420(ra) # 707a <exit>
    }
    if(pid){
    2226:	fe442783          	lw	a5,-28(s0)
    222a:	2781                	sext.w	a5,a5
    222c:	cf85                	beqz	a5,2264 <reparent+0x94>
      if(wait(0) != pid){
    222e:	4501                	li	a0,0
    2230:	00005097          	auipc	ra,0x5
    2234:	e52080e7          	jalr	-430(ra) # 7082 <wait>
    2238:	87aa                	mv	a5,a0
    223a:	873e                	mv	a4,a5
    223c:	fe442783          	lw	a5,-28(s0)
    2240:	2781                	sext.w	a5,a5
    2242:	04e78e63          	beq	a5,a4,229e <reparent+0xce>
        printf("%s: wait wrong pid\n", s);
    2246:	fd843583          	ld	a1,-40(s0)
    224a:	00007517          	auipc	a0,0x7
    224e:	bde50513          	addi	a0,a0,-1058 # 8e28 <schedule_rm+0x102e>
    2252:	00005097          	auipc	ra,0x5
    2256:	36e080e7          	jalr	878(ra) # 75c0 <printf>
        exit(1);
    225a:	4505                	li	a0,1
    225c:	00005097          	auipc	ra,0x5
    2260:	e1e080e7          	jalr	-482(ra) # 707a <exit>
      }
    } else {
      int pid2 = fork();
    2264:	00005097          	auipc	ra,0x5
    2268:	e0e080e7          	jalr	-498(ra) # 7072 <fork>
    226c:	87aa                	mv	a5,a0
    226e:	fef42023          	sw	a5,-32(s0)
      if(pid2 < 0){
    2272:	fe042783          	lw	a5,-32(s0)
    2276:	2781                	sext.w	a5,a5
    2278:	0007de63          	bgez	a5,2294 <reparent+0xc4>
        kill(master_pid);
    227c:	fe842783          	lw	a5,-24(s0)
    2280:	853e                	mv	a0,a5
    2282:	00005097          	auipc	ra,0x5
    2286:	e28080e7          	jalr	-472(ra) # 70aa <kill>
        exit(1);
    228a:	4505                	li	a0,1
    228c:	00005097          	auipc	ra,0x5
    2290:	dee080e7          	jalr	-530(ra) # 707a <exit>
      }
      exit(0);
    2294:	4501                	li	a0,0
    2296:	00005097          	auipc	ra,0x5
    229a:	de4080e7          	jalr	-540(ra) # 707a <exit>
  for(int i = 0; i < 200; i++){
    229e:	fec42783          	lw	a5,-20(s0)
    22a2:	2785                	addiw	a5,a5,1
    22a4:	fef42623          	sw	a5,-20(s0)
    22a8:	fec42783          	lw	a5,-20(s0)
    22ac:	0007871b          	sext.w	a4,a5
    22b0:	0c700793          	li	a5,199
    22b4:	f2e7dee3          	bge	a5,a4,21f0 <reparent+0x20>
    }
  }
  exit(0);
    22b8:	4501                	li	a0,0
    22ba:	00005097          	auipc	ra,0x5
    22be:	dc0080e7          	jalr	-576(ra) # 707a <exit>

00000000000022c2 <twochildren>:
}

// what if two children exit() at the same time?
void
twochildren(char *s)
{
    22c2:	7179                	addi	sp,sp,-48
    22c4:	f406                	sd	ra,40(sp)
    22c6:	f022                	sd	s0,32(sp)
    22c8:	1800                	addi	s0,sp,48
    22ca:	fca43c23          	sd	a0,-40(s0)
  for(int i = 0; i < 1000; i++){
    22ce:	fe042623          	sw	zero,-20(s0)
    22d2:	a845                	j	2382 <twochildren+0xc0>
    int pid1 = fork();
    22d4:	00005097          	auipc	ra,0x5
    22d8:	d9e080e7          	jalr	-610(ra) # 7072 <fork>
    22dc:	87aa                	mv	a5,a0
    22de:	fef42423          	sw	a5,-24(s0)
    if(pid1 < 0){
    22e2:	fe842783          	lw	a5,-24(s0)
    22e6:	2781                	sext.w	a5,a5
    22e8:	0207d163          	bgez	a5,230a <twochildren+0x48>
      printf("%s: fork failed\n", s);
    22ec:	fd843583          	ld	a1,-40(s0)
    22f0:	00006517          	auipc	a0,0x6
    22f4:	5c050513          	addi	a0,a0,1472 # 88b0 <schedule_rm+0xab6>
    22f8:	00005097          	auipc	ra,0x5
    22fc:	2c8080e7          	jalr	712(ra) # 75c0 <printf>
      exit(1);
    2300:	4505                	li	a0,1
    2302:	00005097          	auipc	ra,0x5
    2306:	d78080e7          	jalr	-648(ra) # 707a <exit>
    }
    if(pid1 == 0){
    230a:	fe842783          	lw	a5,-24(s0)
    230e:	2781                	sext.w	a5,a5
    2310:	e791                	bnez	a5,231c <twochildren+0x5a>
      exit(0);
    2312:	4501                	li	a0,0
    2314:	00005097          	auipc	ra,0x5
    2318:	d66080e7          	jalr	-666(ra) # 707a <exit>
    } else {
      int pid2 = fork();
    231c:	00005097          	auipc	ra,0x5
    2320:	d56080e7          	jalr	-682(ra) # 7072 <fork>
    2324:	87aa                	mv	a5,a0
    2326:	fef42223          	sw	a5,-28(s0)
      if(pid2 < 0){
    232a:	fe442783          	lw	a5,-28(s0)
    232e:	2781                	sext.w	a5,a5
    2330:	0207d163          	bgez	a5,2352 <twochildren+0x90>
        printf("%s: fork failed\n", s);
    2334:	fd843583          	ld	a1,-40(s0)
    2338:	00006517          	auipc	a0,0x6
    233c:	57850513          	addi	a0,a0,1400 # 88b0 <schedule_rm+0xab6>
    2340:	00005097          	auipc	ra,0x5
    2344:	280080e7          	jalr	640(ra) # 75c0 <printf>
        exit(1);
    2348:	4505                	li	a0,1
    234a:	00005097          	auipc	ra,0x5
    234e:	d30080e7          	jalr	-720(ra) # 707a <exit>
      }
      if(pid2 == 0){
    2352:	fe442783          	lw	a5,-28(s0)
    2356:	2781                	sext.w	a5,a5
    2358:	e791                	bnez	a5,2364 <twochildren+0xa2>
        exit(0);
    235a:	4501                	li	a0,0
    235c:	00005097          	auipc	ra,0x5
    2360:	d1e080e7          	jalr	-738(ra) # 707a <exit>
      } else {
        wait(0);
    2364:	4501                	li	a0,0
    2366:	00005097          	auipc	ra,0x5
    236a:	d1c080e7          	jalr	-740(ra) # 7082 <wait>
        wait(0);
    236e:	4501                	li	a0,0
    2370:	00005097          	auipc	ra,0x5
    2374:	d12080e7          	jalr	-750(ra) # 7082 <wait>
  for(int i = 0; i < 1000; i++){
    2378:	fec42783          	lw	a5,-20(s0)
    237c:	2785                	addiw	a5,a5,1
    237e:	fef42623          	sw	a5,-20(s0)
    2382:	fec42783          	lw	a5,-20(s0)
    2386:	0007871b          	sext.w	a4,a5
    238a:	3e700793          	li	a5,999
    238e:	f4e7d3e3          	bge	a5,a4,22d4 <twochildren+0x12>
      }
    }
  }
}
    2392:	0001                	nop
    2394:	0001                	nop
    2396:	70a2                	ld	ra,40(sp)
    2398:	7402                	ld	s0,32(sp)
    239a:	6145                	addi	sp,sp,48
    239c:	8082                	ret

000000000000239e <forkfork>:

// concurrent forks to try to expose locking bugs.
void
forkfork(char *s)
{
    239e:	7139                	addi	sp,sp,-64
    23a0:	fc06                	sd	ra,56(sp)
    23a2:	f822                	sd	s0,48(sp)
    23a4:	0080                	addi	s0,sp,64
    23a6:	fca43423          	sd	a0,-56(s0)
  enum { N=2 };
  
  for(int i = 0; i < N; i++){
    23aa:	fe042623          	sw	zero,-20(s0)
    23ae:	a84d                	j	2460 <forkfork+0xc2>
    int pid = fork();
    23b0:	00005097          	auipc	ra,0x5
    23b4:	cc2080e7          	jalr	-830(ra) # 7072 <fork>
    23b8:	87aa                	mv	a5,a0
    23ba:	fef42023          	sw	a5,-32(s0)
    if(pid < 0){
    23be:	fe042783          	lw	a5,-32(s0)
    23c2:	2781                	sext.w	a5,a5
    23c4:	0207d163          	bgez	a5,23e6 <forkfork+0x48>
      printf("%s: fork failed", s);
    23c8:	fc843583          	ld	a1,-56(s0)
    23cc:	00007517          	auipc	a0,0x7
    23d0:	9fc50513          	addi	a0,a0,-1540 # 8dc8 <schedule_rm+0xfce>
    23d4:	00005097          	auipc	ra,0x5
    23d8:	1ec080e7          	jalr	492(ra) # 75c0 <printf>
      exit(1);
    23dc:	4505                	li	a0,1
    23de:	00005097          	auipc	ra,0x5
    23e2:	c9c080e7          	jalr	-868(ra) # 707a <exit>
    }
    if(pid == 0){
    23e6:	fe042783          	lw	a5,-32(s0)
    23ea:	2781                	sext.w	a5,a5
    23ec:	e7ad                	bnez	a5,2456 <forkfork+0xb8>
      for(int j = 0; j < 200; j++){
    23ee:	fe042423          	sw	zero,-24(s0)
    23f2:	a0a9                	j	243c <forkfork+0x9e>
        int pid1 = fork();
    23f4:	00005097          	auipc	ra,0x5
    23f8:	c7e080e7          	jalr	-898(ra) # 7072 <fork>
    23fc:	87aa                	mv	a5,a0
    23fe:	fcf42e23          	sw	a5,-36(s0)
        if(pid1 < 0){
    2402:	fdc42783          	lw	a5,-36(s0)
    2406:	2781                	sext.w	a5,a5
    2408:	0007d763          	bgez	a5,2416 <forkfork+0x78>
          exit(1);
    240c:	4505                	li	a0,1
    240e:	00005097          	auipc	ra,0x5
    2412:	c6c080e7          	jalr	-916(ra) # 707a <exit>
        }
        if(pid1 == 0){
    2416:	fdc42783          	lw	a5,-36(s0)
    241a:	2781                	sext.w	a5,a5
    241c:	e791                	bnez	a5,2428 <forkfork+0x8a>
          exit(0);
    241e:	4501                	li	a0,0
    2420:	00005097          	auipc	ra,0x5
    2424:	c5a080e7          	jalr	-934(ra) # 707a <exit>
        }
        wait(0);
    2428:	4501                	li	a0,0
    242a:	00005097          	auipc	ra,0x5
    242e:	c58080e7          	jalr	-936(ra) # 7082 <wait>
      for(int j = 0; j < 200; j++){
    2432:	fe842783          	lw	a5,-24(s0)
    2436:	2785                	addiw	a5,a5,1
    2438:	fef42423          	sw	a5,-24(s0)
    243c:	fe842783          	lw	a5,-24(s0)
    2440:	0007871b          	sext.w	a4,a5
    2444:	0c700793          	li	a5,199
    2448:	fae7d6e3          	bge	a5,a4,23f4 <forkfork+0x56>
      }
      exit(0);
    244c:	4501                	li	a0,0
    244e:	00005097          	auipc	ra,0x5
    2452:	c2c080e7          	jalr	-980(ra) # 707a <exit>
  for(int i = 0; i < N; i++){
    2456:	fec42783          	lw	a5,-20(s0)
    245a:	2785                	addiw	a5,a5,1
    245c:	fef42623          	sw	a5,-20(s0)
    2460:	fec42783          	lw	a5,-20(s0)
    2464:	0007871b          	sext.w	a4,a5
    2468:	4785                	li	a5,1
    246a:	f4e7d3e3          	bge	a5,a4,23b0 <forkfork+0x12>
    }
  }

  int xstatus;
  for(int i = 0; i < N; i++){
    246e:	fe042223          	sw	zero,-28(s0)
    2472:	a83d                	j	24b0 <forkfork+0x112>
    wait(&xstatus);
    2474:	fd840793          	addi	a5,s0,-40
    2478:	853e                	mv	a0,a5
    247a:	00005097          	auipc	ra,0x5
    247e:	c08080e7          	jalr	-1016(ra) # 7082 <wait>
    if(xstatus != 0) {
    2482:	fd842783          	lw	a5,-40(s0)
    2486:	c385                	beqz	a5,24a6 <forkfork+0x108>
      printf("%s: fork in child failed", s);
    2488:	fc843583          	ld	a1,-56(s0)
    248c:	00007517          	auipc	a0,0x7
    2490:	9d450513          	addi	a0,a0,-1580 # 8e60 <schedule_rm+0x1066>
    2494:	00005097          	auipc	ra,0x5
    2498:	12c080e7          	jalr	300(ra) # 75c0 <printf>
      exit(1);
    249c:	4505                	li	a0,1
    249e:	00005097          	auipc	ra,0x5
    24a2:	bdc080e7          	jalr	-1060(ra) # 707a <exit>
  for(int i = 0; i < N; i++){
    24a6:	fe442783          	lw	a5,-28(s0)
    24aa:	2785                	addiw	a5,a5,1
    24ac:	fef42223          	sw	a5,-28(s0)
    24b0:	fe442783          	lw	a5,-28(s0)
    24b4:	0007871b          	sext.w	a4,a5
    24b8:	4785                	li	a5,1
    24ba:	fae7dde3          	bge	a5,a4,2474 <forkfork+0xd6>
    }
  }
}
    24be:	0001                	nop
    24c0:	0001                	nop
    24c2:	70e2                	ld	ra,56(sp)
    24c4:	7442                	ld	s0,48(sp)
    24c6:	6121                	addi	sp,sp,64
    24c8:	8082                	ret

00000000000024ca <forkforkfork>:

void
forkforkfork(char *s)
{
    24ca:	7179                	addi	sp,sp,-48
    24cc:	f406                	sd	ra,40(sp)
    24ce:	f022                	sd	s0,32(sp)
    24d0:	1800                	addi	s0,sp,48
    24d2:	fca43c23          	sd	a0,-40(s0)
  unlink("stopforking");
    24d6:	00007517          	auipc	a0,0x7
    24da:	9aa50513          	addi	a0,a0,-1622 # 8e80 <schedule_rm+0x1086>
    24de:	00005097          	auipc	ra,0x5
    24e2:	bec080e7          	jalr	-1044(ra) # 70ca <unlink>

  int pid = fork();
    24e6:	00005097          	auipc	ra,0x5
    24ea:	b8c080e7          	jalr	-1140(ra) # 7072 <fork>
    24ee:	87aa                	mv	a5,a0
    24f0:	fef42623          	sw	a5,-20(s0)
  if(pid < 0){
    24f4:	fec42783          	lw	a5,-20(s0)
    24f8:	2781                	sext.w	a5,a5
    24fa:	0207d163          	bgez	a5,251c <forkforkfork+0x52>
    printf("%s: fork failed", s);
    24fe:	fd843583          	ld	a1,-40(s0)
    2502:	00007517          	auipc	a0,0x7
    2506:	8c650513          	addi	a0,a0,-1850 # 8dc8 <schedule_rm+0xfce>
    250a:	00005097          	auipc	ra,0x5
    250e:	0b6080e7          	jalr	182(ra) # 75c0 <printf>
    exit(1);
    2512:	4505                	li	a0,1
    2514:	00005097          	auipc	ra,0x5
    2518:	b66080e7          	jalr	-1178(ra) # 707a <exit>
  }
  if(pid == 0){
    251c:	fec42783          	lw	a5,-20(s0)
    2520:	2781                	sext.w	a5,a5
    2522:	efb9                	bnez	a5,2580 <forkforkfork+0xb6>
    while(1){
      int fd = open("stopforking", 0);
    2524:	4581                	li	a1,0
    2526:	00007517          	auipc	a0,0x7
    252a:	95a50513          	addi	a0,a0,-1702 # 8e80 <schedule_rm+0x1086>
    252e:	00005097          	auipc	ra,0x5
    2532:	b8c080e7          	jalr	-1140(ra) # 70ba <open>
    2536:	87aa                	mv	a5,a0
    2538:	fef42423          	sw	a5,-24(s0)
      if(fd >= 0){
    253c:	fe842783          	lw	a5,-24(s0)
    2540:	2781                	sext.w	a5,a5
    2542:	0007c763          	bltz	a5,2550 <forkforkfork+0x86>
        exit(0);
    2546:	4501                	li	a0,0
    2548:	00005097          	auipc	ra,0x5
    254c:	b32080e7          	jalr	-1230(ra) # 707a <exit>
      }
      if(fork() < 0){
    2550:	00005097          	auipc	ra,0x5
    2554:	b22080e7          	jalr	-1246(ra) # 7072 <fork>
    2558:	87aa                	mv	a5,a0
    255a:	fc07d5e3          	bgez	a5,2524 <forkforkfork+0x5a>
        close(open("stopforking", O_CREATE|O_RDWR));
    255e:	20200593          	li	a1,514
    2562:	00007517          	auipc	a0,0x7
    2566:	91e50513          	addi	a0,a0,-1762 # 8e80 <schedule_rm+0x1086>
    256a:	00005097          	auipc	ra,0x5
    256e:	b50080e7          	jalr	-1200(ra) # 70ba <open>
    2572:	87aa                	mv	a5,a0
    2574:	853e                	mv	a0,a5
    2576:	00005097          	auipc	ra,0x5
    257a:	b2c080e7          	jalr	-1236(ra) # 70a2 <close>
    while(1){
    257e:	b75d                	j	2524 <forkforkfork+0x5a>
    }

    exit(0);
  }

  sleep(20); // two seconds
    2580:	4551                	li	a0,20
    2582:	00005097          	auipc	ra,0x5
    2586:	b88080e7          	jalr	-1144(ra) # 710a <sleep>
  close(open("stopforking", O_CREATE|O_RDWR));
    258a:	20200593          	li	a1,514
    258e:	00007517          	auipc	a0,0x7
    2592:	8f250513          	addi	a0,a0,-1806 # 8e80 <schedule_rm+0x1086>
    2596:	00005097          	auipc	ra,0x5
    259a:	b24080e7          	jalr	-1244(ra) # 70ba <open>
    259e:	87aa                	mv	a5,a0
    25a0:	853e                	mv	a0,a5
    25a2:	00005097          	auipc	ra,0x5
    25a6:	b00080e7          	jalr	-1280(ra) # 70a2 <close>
  wait(0);
    25aa:	4501                	li	a0,0
    25ac:	00005097          	auipc	ra,0x5
    25b0:	ad6080e7          	jalr	-1322(ra) # 7082 <wait>
  sleep(10); // one second
    25b4:	4529                	li	a0,10
    25b6:	00005097          	auipc	ra,0x5
    25ba:	b54080e7          	jalr	-1196(ra) # 710a <sleep>
}
    25be:	0001                	nop
    25c0:	70a2                	ld	ra,40(sp)
    25c2:	7402                	ld	s0,32(sp)
    25c4:	6145                	addi	sp,sp,48
    25c6:	8082                	ret

00000000000025c8 <reparent2>:
// deadlocks against init's wait()? also used to trigger a "panic:
// release" due to exit() releasing a different p->parent->lock than
// it acquired.
void
reparent2(char *s)
{
    25c8:	7179                	addi	sp,sp,-48
    25ca:	f406                	sd	ra,40(sp)
    25cc:	f022                	sd	s0,32(sp)
    25ce:	1800                	addi	s0,sp,48
    25d0:	fca43c23          	sd	a0,-40(s0)
  for(int i = 0; i < 800; i++){
    25d4:	fe042623          	sw	zero,-20(s0)
    25d8:	a0ad                	j	2642 <reparent2+0x7a>
    int pid1 = fork();
    25da:	00005097          	auipc	ra,0x5
    25de:	a98080e7          	jalr	-1384(ra) # 7072 <fork>
    25e2:	87aa                	mv	a5,a0
    25e4:	fef42423          	sw	a5,-24(s0)
    if(pid1 < 0){
    25e8:	fe842783          	lw	a5,-24(s0)
    25ec:	2781                	sext.w	a5,a5
    25ee:	0007df63          	bgez	a5,260c <reparent2+0x44>
      printf("fork failed\n");
    25f2:	00006517          	auipc	a0,0x6
    25f6:	09650513          	addi	a0,a0,150 # 8688 <schedule_rm+0x88e>
    25fa:	00005097          	auipc	ra,0x5
    25fe:	fc6080e7          	jalr	-58(ra) # 75c0 <printf>
      exit(1);
    2602:	4505                	li	a0,1
    2604:	00005097          	auipc	ra,0x5
    2608:	a76080e7          	jalr	-1418(ra) # 707a <exit>
    }
    if(pid1 == 0){
    260c:	fe842783          	lw	a5,-24(s0)
    2610:	2781                	sext.w	a5,a5
    2612:	ef91                	bnez	a5,262e <reparent2+0x66>
      fork();
    2614:	00005097          	auipc	ra,0x5
    2618:	a5e080e7          	jalr	-1442(ra) # 7072 <fork>
      fork();
    261c:	00005097          	auipc	ra,0x5
    2620:	a56080e7          	jalr	-1450(ra) # 7072 <fork>
      exit(0);
    2624:	4501                	li	a0,0
    2626:	00005097          	auipc	ra,0x5
    262a:	a54080e7          	jalr	-1452(ra) # 707a <exit>
    }
    wait(0);
    262e:	4501                	li	a0,0
    2630:	00005097          	auipc	ra,0x5
    2634:	a52080e7          	jalr	-1454(ra) # 7082 <wait>
  for(int i = 0; i < 800; i++){
    2638:	fec42783          	lw	a5,-20(s0)
    263c:	2785                	addiw	a5,a5,1
    263e:	fef42623          	sw	a5,-20(s0)
    2642:	fec42783          	lw	a5,-20(s0)
    2646:	0007871b          	sext.w	a4,a5
    264a:	31f00793          	li	a5,799
    264e:	f8e7d6e3          	bge	a5,a4,25da <reparent2+0x12>
  }

  exit(0);
    2652:	4501                	li	a0,0
    2654:	00005097          	auipc	ra,0x5
    2658:	a26080e7          	jalr	-1498(ra) # 707a <exit>

000000000000265c <mem>:
}

// allocate all mem, free it, and allocate again
void
mem(char *s)
{
    265c:	7139                	addi	sp,sp,-64
    265e:	fc06                	sd	ra,56(sp)
    2660:	f822                	sd	s0,48(sp)
    2662:	0080                	addi	s0,sp,64
    2664:	fca43423          	sd	a0,-56(s0)
  void *m1, *m2;
  int pid;

  if((pid = fork()) == 0){
    2668:	00005097          	auipc	ra,0x5
    266c:	a0a080e7          	jalr	-1526(ra) # 7072 <fork>
    2670:	87aa                	mv	a5,a0
    2672:	fef42223          	sw	a5,-28(s0)
    2676:	fe442783          	lw	a5,-28(s0)
    267a:	2781                	sext.w	a5,a5
    267c:	e3c5                	bnez	a5,271c <mem+0xc0>
    m1 = 0;
    267e:	fe043423          	sd	zero,-24(s0)
    while((m2 = malloc(10001)) != 0){
    2682:	a811                	j	2696 <mem+0x3a>
      *(char**)m2 = m1;
    2684:	fd843783          	ld	a5,-40(s0)
    2688:	fe843703          	ld	a4,-24(s0)
    268c:	e398                	sd	a4,0(a5)
      m1 = m2;
    268e:	fd843783          	ld	a5,-40(s0)
    2692:	fef43423          	sd	a5,-24(s0)
    while((m2 = malloc(10001)) != 0){
    2696:	6789                	lui	a5,0x2
    2698:	71178513          	addi	a0,a5,1809 # 2711 <mem+0xb5>
    269c:	00005097          	auipc	ra,0x5
    26a0:	116080e7          	jalr	278(ra) # 77b2 <malloc>
    26a4:	fca43c23          	sd	a0,-40(s0)
    26a8:	fd843783          	ld	a5,-40(s0)
    26ac:	ffe1                	bnez	a5,2684 <mem+0x28>
    }
    while(m1){
    26ae:	a005                	j	26ce <mem+0x72>
      m2 = *(char**)m1;
    26b0:	fe843783          	ld	a5,-24(s0)
    26b4:	639c                	ld	a5,0(a5)
    26b6:	fcf43c23          	sd	a5,-40(s0)
      free(m1);
    26ba:	fe843503          	ld	a0,-24(s0)
    26be:	00005097          	auipc	ra,0x5
    26c2:	f52080e7          	jalr	-174(ra) # 7610 <free>
      m1 = m2;
    26c6:	fd843783          	ld	a5,-40(s0)
    26ca:	fef43423          	sd	a5,-24(s0)
    while(m1){
    26ce:	fe843783          	ld	a5,-24(s0)
    26d2:	fff9                	bnez	a5,26b0 <mem+0x54>
    }
    m1 = malloc(1024*20);
    26d4:	6515                	lui	a0,0x5
    26d6:	00005097          	auipc	ra,0x5
    26da:	0dc080e7          	jalr	220(ra) # 77b2 <malloc>
    26de:	fea43423          	sd	a0,-24(s0)
    if(m1 == 0){
    26e2:	fe843783          	ld	a5,-24(s0)
    26e6:	e385                	bnez	a5,2706 <mem+0xaa>
      printf("couldn't allocate mem?!!\n", s);
    26e8:	fc843583          	ld	a1,-56(s0)
    26ec:	00006517          	auipc	a0,0x6
    26f0:	7a450513          	addi	a0,a0,1956 # 8e90 <schedule_rm+0x1096>
    26f4:	00005097          	auipc	ra,0x5
    26f8:	ecc080e7          	jalr	-308(ra) # 75c0 <printf>
      exit(1);
    26fc:	4505                	li	a0,1
    26fe:	00005097          	auipc	ra,0x5
    2702:	97c080e7          	jalr	-1668(ra) # 707a <exit>
    }
    free(m1);
    2706:	fe843503          	ld	a0,-24(s0)
    270a:	00005097          	auipc	ra,0x5
    270e:	f06080e7          	jalr	-250(ra) # 7610 <free>
    exit(0);
    2712:	4501                	li	a0,0
    2714:	00005097          	auipc	ra,0x5
    2718:	966080e7          	jalr	-1690(ra) # 707a <exit>
  } else {
    int xstatus;
    wait(&xstatus);
    271c:	fd440793          	addi	a5,s0,-44
    2720:	853e                	mv	a0,a5
    2722:	00005097          	auipc	ra,0x5
    2726:	960080e7          	jalr	-1696(ra) # 7082 <wait>
    if(xstatus == -1){
    272a:	fd442783          	lw	a5,-44(s0)
    272e:	873e                	mv	a4,a5
    2730:	57fd                	li	a5,-1
    2732:	00f71763          	bne	a4,a5,2740 <mem+0xe4>
      // probably page fault, so might be lazy lab,
      // so OK.
      exit(0);
    2736:	4501                	li	a0,0
    2738:	00005097          	auipc	ra,0x5
    273c:	942080e7          	jalr	-1726(ra) # 707a <exit>
    }
    exit(xstatus);
    2740:	fd442783          	lw	a5,-44(s0)
    2744:	853e                	mv	a0,a5
    2746:	00005097          	auipc	ra,0x5
    274a:	934080e7          	jalr	-1740(ra) # 707a <exit>

000000000000274e <sharedfd>:

// two processes write to the same file descriptor
// is the offset shared? does inode locking work?
void
sharedfd(char *s)
{
    274e:	715d                	addi	sp,sp,-80
    2750:	e486                	sd	ra,72(sp)
    2752:	e0a2                	sd	s0,64(sp)
    2754:	0880                	addi	s0,sp,80
    2756:	faa43c23          	sd	a0,-72(s0)
  int fd, pid, i, n, nc, np;
  enum { N = 1000, SZ=10};
  char buf[SZ];

  unlink("sharedfd");
    275a:	00006517          	auipc	a0,0x6
    275e:	b9650513          	addi	a0,a0,-1130 # 82f0 <schedule_rm+0x4f6>
    2762:	00005097          	auipc	ra,0x5
    2766:	968080e7          	jalr	-1688(ra) # 70ca <unlink>
  fd = open("sharedfd", O_CREATE|O_RDWR);
    276a:	20200593          	li	a1,514
    276e:	00006517          	auipc	a0,0x6
    2772:	b8250513          	addi	a0,a0,-1150 # 82f0 <schedule_rm+0x4f6>
    2776:	00005097          	auipc	ra,0x5
    277a:	944080e7          	jalr	-1724(ra) # 70ba <open>
    277e:	87aa                	mv	a5,a0
    2780:	fef42023          	sw	a5,-32(s0)
  if(fd < 0){
    2784:	fe042783          	lw	a5,-32(s0)
    2788:	2781                	sext.w	a5,a5
    278a:	0207d163          	bgez	a5,27ac <sharedfd+0x5e>
    printf("%s: cannot open sharedfd for writing", s);
    278e:	fb843583          	ld	a1,-72(s0)
    2792:	00006517          	auipc	a0,0x6
    2796:	71e50513          	addi	a0,a0,1822 # 8eb0 <schedule_rm+0x10b6>
    279a:	00005097          	auipc	ra,0x5
    279e:	e26080e7          	jalr	-474(ra) # 75c0 <printf>
    exit(1);
    27a2:	4505                	li	a0,1
    27a4:	00005097          	auipc	ra,0x5
    27a8:	8d6080e7          	jalr	-1834(ra) # 707a <exit>
  }
  pid = fork();
    27ac:	00005097          	auipc	ra,0x5
    27b0:	8c6080e7          	jalr	-1850(ra) # 7072 <fork>
    27b4:	87aa                	mv	a5,a0
    27b6:	fcf42e23          	sw	a5,-36(s0)
  memset(buf, pid==0?'c':'p', sizeof(buf));
    27ba:	fdc42783          	lw	a5,-36(s0)
    27be:	2781                	sext.w	a5,a5
    27c0:	e781                	bnez	a5,27c8 <sharedfd+0x7a>
    27c2:	06300793          	li	a5,99
    27c6:	a019                	j	27cc <sharedfd+0x7e>
    27c8:	07000793          	li	a5,112
    27cc:	fc840713          	addi	a4,s0,-56
    27d0:	4629                	li	a2,10
    27d2:	85be                	mv	a1,a5
    27d4:	853a                	mv	a0,a4
    27d6:	00004097          	auipc	ra,0x4
    27da:	4fa080e7          	jalr	1274(ra) # 6cd0 <memset>
  for(i = 0; i < N; i++){
    27de:	fe042623          	sw	zero,-20(s0)
    27e2:	a0a9                	j	282c <sharedfd+0xde>
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
    27e4:	fc840713          	addi	a4,s0,-56
    27e8:	fe042783          	lw	a5,-32(s0)
    27ec:	4629                	li	a2,10
    27ee:	85ba                	mv	a1,a4
    27f0:	853e                	mv	a0,a5
    27f2:	00005097          	auipc	ra,0x5
    27f6:	8a8080e7          	jalr	-1880(ra) # 709a <write>
    27fa:	87aa                	mv	a5,a0
    27fc:	873e                	mv	a4,a5
    27fe:	47a9                	li	a5,10
    2800:	02f70163          	beq	a4,a5,2822 <sharedfd+0xd4>
      printf("%s: write sharedfd failed\n", s);
    2804:	fb843583          	ld	a1,-72(s0)
    2808:	00006517          	auipc	a0,0x6
    280c:	6d050513          	addi	a0,a0,1744 # 8ed8 <schedule_rm+0x10de>
    2810:	00005097          	auipc	ra,0x5
    2814:	db0080e7          	jalr	-592(ra) # 75c0 <printf>
      exit(1);
    2818:	4505                	li	a0,1
    281a:	00005097          	auipc	ra,0x5
    281e:	860080e7          	jalr	-1952(ra) # 707a <exit>
  for(i = 0; i < N; i++){
    2822:	fec42783          	lw	a5,-20(s0)
    2826:	2785                	addiw	a5,a5,1
    2828:	fef42623          	sw	a5,-20(s0)
    282c:	fec42783          	lw	a5,-20(s0)
    2830:	0007871b          	sext.w	a4,a5
    2834:	3e700793          	li	a5,999
    2838:	fae7d6e3          	bge	a5,a4,27e4 <sharedfd+0x96>
    }
  }
  if(pid == 0) {
    283c:	fdc42783          	lw	a5,-36(s0)
    2840:	2781                	sext.w	a5,a5
    2842:	e791                	bnez	a5,284e <sharedfd+0x100>
    exit(0);
    2844:	4501                	li	a0,0
    2846:	00005097          	auipc	ra,0x5
    284a:	834080e7          	jalr	-1996(ra) # 707a <exit>
  } else {
    int xstatus;
    wait(&xstatus);
    284e:	fc440793          	addi	a5,s0,-60
    2852:	853e                	mv	a0,a5
    2854:	00005097          	auipc	ra,0x5
    2858:	82e080e7          	jalr	-2002(ra) # 7082 <wait>
    if(xstatus != 0)
    285c:	fc442783          	lw	a5,-60(s0)
    2860:	cb81                	beqz	a5,2870 <sharedfd+0x122>
      exit(xstatus);
    2862:	fc442783          	lw	a5,-60(s0)
    2866:	853e                	mv	a0,a5
    2868:	00005097          	auipc	ra,0x5
    286c:	812080e7          	jalr	-2030(ra) # 707a <exit>
  }
  
  close(fd);
    2870:	fe042783          	lw	a5,-32(s0)
    2874:	853e                	mv	a0,a5
    2876:	00005097          	auipc	ra,0x5
    287a:	82c080e7          	jalr	-2004(ra) # 70a2 <close>
  fd = open("sharedfd", 0);
    287e:	4581                	li	a1,0
    2880:	00006517          	auipc	a0,0x6
    2884:	a7050513          	addi	a0,a0,-1424 # 82f0 <schedule_rm+0x4f6>
    2888:	00005097          	auipc	ra,0x5
    288c:	832080e7          	jalr	-1998(ra) # 70ba <open>
    2890:	87aa                	mv	a5,a0
    2892:	fef42023          	sw	a5,-32(s0)
  if(fd < 0){
    2896:	fe042783          	lw	a5,-32(s0)
    289a:	2781                	sext.w	a5,a5
    289c:	0207d163          	bgez	a5,28be <sharedfd+0x170>
    printf("%s: cannot open sharedfd for reading\n", s);
    28a0:	fb843583          	ld	a1,-72(s0)
    28a4:	00006517          	auipc	a0,0x6
    28a8:	65450513          	addi	a0,a0,1620 # 8ef8 <schedule_rm+0x10fe>
    28ac:	00005097          	auipc	ra,0x5
    28b0:	d14080e7          	jalr	-748(ra) # 75c0 <printf>
    exit(1);
    28b4:	4505                	li	a0,1
    28b6:	00004097          	auipc	ra,0x4
    28ba:	7c4080e7          	jalr	1988(ra) # 707a <exit>
  }
  nc = np = 0;
    28be:	fe042223          	sw	zero,-28(s0)
    28c2:	fe442783          	lw	a5,-28(s0)
    28c6:	fef42423          	sw	a5,-24(s0)
  while((n = read(fd, buf, sizeof(buf))) > 0){
    28ca:	a08d                	j	292c <sharedfd+0x1de>
    for(i = 0; i < sizeof(buf); i++){
    28cc:	fe042623          	sw	zero,-20(s0)
    28d0:	a881                	j	2920 <sharedfd+0x1d2>
      if(buf[i] == 'c')
    28d2:	fec42783          	lw	a5,-20(s0)
    28d6:	ff040713          	addi	a4,s0,-16
    28da:	97ba                	add	a5,a5,a4
    28dc:	fd87c783          	lbu	a5,-40(a5)
    28e0:	873e                	mv	a4,a5
    28e2:	06300793          	li	a5,99
    28e6:	00f71763          	bne	a4,a5,28f4 <sharedfd+0x1a6>
        nc++;
    28ea:	fe842783          	lw	a5,-24(s0)
    28ee:	2785                	addiw	a5,a5,1
    28f0:	fef42423          	sw	a5,-24(s0)
      if(buf[i] == 'p')
    28f4:	fec42783          	lw	a5,-20(s0)
    28f8:	ff040713          	addi	a4,s0,-16
    28fc:	97ba                	add	a5,a5,a4
    28fe:	fd87c783          	lbu	a5,-40(a5)
    2902:	873e                	mv	a4,a5
    2904:	07000793          	li	a5,112
    2908:	00f71763          	bne	a4,a5,2916 <sharedfd+0x1c8>
        np++;
    290c:	fe442783          	lw	a5,-28(s0)
    2910:	2785                	addiw	a5,a5,1
    2912:	fef42223          	sw	a5,-28(s0)
    for(i = 0; i < sizeof(buf); i++){
    2916:	fec42783          	lw	a5,-20(s0)
    291a:	2785                	addiw	a5,a5,1
    291c:	fef42623          	sw	a5,-20(s0)
    2920:	fec42783          	lw	a5,-20(s0)
    2924:	873e                	mv	a4,a5
    2926:	47a5                	li	a5,9
    2928:	fae7f5e3          	bgeu	a5,a4,28d2 <sharedfd+0x184>
  while((n = read(fd, buf, sizeof(buf))) > 0){
    292c:	fc840713          	addi	a4,s0,-56
    2930:	fe042783          	lw	a5,-32(s0)
    2934:	4629                	li	a2,10
    2936:	85ba                	mv	a1,a4
    2938:	853e                	mv	a0,a5
    293a:	00004097          	auipc	ra,0x4
    293e:	758080e7          	jalr	1880(ra) # 7092 <read>
    2942:	87aa                	mv	a5,a0
    2944:	fcf42c23          	sw	a5,-40(s0)
    2948:	fd842783          	lw	a5,-40(s0)
    294c:	2781                	sext.w	a5,a5
    294e:	f6f04fe3          	bgtz	a5,28cc <sharedfd+0x17e>
    }
  }
  close(fd);
    2952:	fe042783          	lw	a5,-32(s0)
    2956:	853e                	mv	a0,a5
    2958:	00004097          	auipc	ra,0x4
    295c:	74a080e7          	jalr	1866(ra) # 70a2 <close>
  unlink("sharedfd");
    2960:	00006517          	auipc	a0,0x6
    2964:	99050513          	addi	a0,a0,-1648 # 82f0 <schedule_rm+0x4f6>
    2968:	00004097          	auipc	ra,0x4
    296c:	762080e7          	jalr	1890(ra) # 70ca <unlink>
  if(nc == N*SZ && np == N*SZ){
    2970:	fe842783          	lw	a5,-24(s0)
    2974:	0007871b          	sext.w	a4,a5
    2978:	6789                	lui	a5,0x2
    297a:	71078793          	addi	a5,a5,1808 # 2710 <mem+0xb4>
    297e:	02f71063          	bne	a4,a5,299e <sharedfd+0x250>
    2982:	fe442783          	lw	a5,-28(s0)
    2986:	0007871b          	sext.w	a4,a5
    298a:	6789                	lui	a5,0x2
    298c:	71078793          	addi	a5,a5,1808 # 2710 <mem+0xb4>
    2990:	00f71763          	bne	a4,a5,299e <sharedfd+0x250>
    exit(0);
    2994:	4501                	li	a0,0
    2996:	00004097          	auipc	ra,0x4
    299a:	6e4080e7          	jalr	1764(ra) # 707a <exit>
  } else {
    printf("%s: nc/np test fails\n", s);
    299e:	fb843583          	ld	a1,-72(s0)
    29a2:	00006517          	auipc	a0,0x6
    29a6:	57e50513          	addi	a0,a0,1406 # 8f20 <schedule_rm+0x1126>
    29aa:	00005097          	auipc	ra,0x5
    29ae:	c16080e7          	jalr	-1002(ra) # 75c0 <printf>
    exit(1);
    29b2:	4505                	li	a0,1
    29b4:	00004097          	auipc	ra,0x4
    29b8:	6c6080e7          	jalr	1734(ra) # 707a <exit>

00000000000029bc <fourfiles>:

// four processes write different files at the same
// time, to test block allocation.
void
fourfiles(char *s)
{
    29bc:	7159                	addi	sp,sp,-112
    29be:	f486                	sd	ra,104(sp)
    29c0:	f0a2                	sd	s0,96(sp)
    29c2:	1880                	addi	s0,sp,112
    29c4:	f8a43c23          	sd	a0,-104(s0)
  int fd, pid, i, j, n, total, pi;
  char *names[] = { "f0", "f1", "f2", "f3" };
    29c8:	00006797          	auipc	a5,0x6
    29cc:	5c078793          	addi	a5,a5,1472 # 8f88 <schedule_rm+0x118e>
    29d0:	6390                	ld	a2,0(a5)
    29d2:	6794                	ld	a3,8(a5)
    29d4:	6b98                	ld	a4,16(a5)
    29d6:	6f9c                	ld	a5,24(a5)
    29d8:	fac43423          	sd	a2,-88(s0)
    29dc:	fad43823          	sd	a3,-80(s0)
    29e0:	fae43c23          	sd	a4,-72(s0)
    29e4:	fcf43023          	sd	a5,-64(s0)
  char *fname;
  enum { N=12, NCHILD=4, SZ=500 };
  
  for(pi = 0; pi < NCHILD; pi++){
    29e8:	fe042023          	sw	zero,-32(s0)
    29ec:	a281                	j	2b2c <fourfiles+0x170>
    fname = names[pi];
    29ee:	fe042783          	lw	a5,-32(s0)
    29f2:	078e                	slli	a5,a5,0x3
    29f4:	ff040713          	addi	a4,s0,-16
    29f8:	97ba                	add	a5,a5,a4
    29fa:	fb87b783          	ld	a5,-72(a5)
    29fe:	fcf43c23          	sd	a5,-40(s0)
    unlink(fname);
    2a02:	fd843503          	ld	a0,-40(s0)
    2a06:	00004097          	auipc	ra,0x4
    2a0a:	6c4080e7          	jalr	1732(ra) # 70ca <unlink>

    pid = fork();
    2a0e:	00004097          	auipc	ra,0x4
    2a12:	664080e7          	jalr	1636(ra) # 7072 <fork>
    2a16:	87aa                	mv	a5,a0
    2a18:	fcf42623          	sw	a5,-52(s0)
    if(pid < 0){
    2a1c:	fcc42783          	lw	a5,-52(s0)
    2a20:	2781                	sext.w	a5,a5
    2a22:	0207d163          	bgez	a5,2a44 <fourfiles+0x88>
      printf("fork failed\n", s);
    2a26:	f9843583          	ld	a1,-104(s0)
    2a2a:	00006517          	auipc	a0,0x6
    2a2e:	c5e50513          	addi	a0,a0,-930 # 8688 <schedule_rm+0x88e>
    2a32:	00005097          	auipc	ra,0x5
    2a36:	b8e080e7          	jalr	-1138(ra) # 75c0 <printf>
      exit(1);
    2a3a:	4505                	li	a0,1
    2a3c:	00004097          	auipc	ra,0x4
    2a40:	63e080e7          	jalr	1598(ra) # 707a <exit>
    }

    if(pid == 0){
    2a44:	fcc42783          	lw	a5,-52(s0)
    2a48:	2781                	sext.w	a5,a5
    2a4a:	efe1                	bnez	a5,2b22 <fourfiles+0x166>
      fd = open(fname, O_CREATE | O_RDWR);
    2a4c:	20200593          	li	a1,514
    2a50:	fd843503          	ld	a0,-40(s0)
    2a54:	00004097          	auipc	ra,0x4
    2a58:	666080e7          	jalr	1638(ra) # 70ba <open>
    2a5c:	87aa                	mv	a5,a0
    2a5e:	fcf42a23          	sw	a5,-44(s0)
      if(fd < 0){
    2a62:	fd442783          	lw	a5,-44(s0)
    2a66:	2781                	sext.w	a5,a5
    2a68:	0207d163          	bgez	a5,2a8a <fourfiles+0xce>
        printf("create failed\n", s);
    2a6c:	f9843583          	ld	a1,-104(s0)
    2a70:	00006517          	auipc	a0,0x6
    2a74:	4c850513          	addi	a0,a0,1224 # 8f38 <schedule_rm+0x113e>
    2a78:	00005097          	auipc	ra,0x5
    2a7c:	b48080e7          	jalr	-1208(ra) # 75c0 <printf>
        exit(1);
    2a80:	4505                	li	a0,1
    2a82:	00004097          	auipc	ra,0x4
    2a86:	5f8080e7          	jalr	1528(ra) # 707a <exit>
      }

      memset(buf, '0'+pi, SZ);
    2a8a:	fe042783          	lw	a5,-32(s0)
    2a8e:	0307879b          	addiw	a5,a5,48
    2a92:	2781                	sext.w	a5,a5
    2a94:	1f400613          	li	a2,500
    2a98:	85be                	mv	a1,a5
    2a9a:	00008517          	auipc	a0,0x8
    2a9e:	e6650513          	addi	a0,a0,-410 # a900 <buf>
    2aa2:	00004097          	auipc	ra,0x4
    2aa6:	22e080e7          	jalr	558(ra) # 6cd0 <memset>
      for(i = 0; i < N; i++){
    2aaa:	fe042623          	sw	zero,-20(s0)
    2aae:	a8b1                	j	2b0a <fourfiles+0x14e>
        if((n = write(fd, buf, SZ)) != SZ){
    2ab0:	fd442783          	lw	a5,-44(s0)
    2ab4:	1f400613          	li	a2,500
    2ab8:	00008597          	auipc	a1,0x8
    2abc:	e4858593          	addi	a1,a1,-440 # a900 <buf>
    2ac0:	853e                	mv	a0,a5
    2ac2:	00004097          	auipc	ra,0x4
    2ac6:	5d8080e7          	jalr	1496(ra) # 709a <write>
    2aca:	87aa                	mv	a5,a0
    2acc:	fcf42823          	sw	a5,-48(s0)
    2ad0:	fd042783          	lw	a5,-48(s0)
    2ad4:	0007871b          	sext.w	a4,a5
    2ad8:	1f400793          	li	a5,500
    2adc:	02f70263          	beq	a4,a5,2b00 <fourfiles+0x144>
          printf("write failed %d\n", n);
    2ae0:	fd042783          	lw	a5,-48(s0)
    2ae4:	85be                	mv	a1,a5
    2ae6:	00006517          	auipc	a0,0x6
    2aea:	46250513          	addi	a0,a0,1122 # 8f48 <schedule_rm+0x114e>
    2aee:	00005097          	auipc	ra,0x5
    2af2:	ad2080e7          	jalr	-1326(ra) # 75c0 <printf>
          exit(1);
    2af6:	4505                	li	a0,1
    2af8:	00004097          	auipc	ra,0x4
    2afc:	582080e7          	jalr	1410(ra) # 707a <exit>
      for(i = 0; i < N; i++){
    2b00:	fec42783          	lw	a5,-20(s0)
    2b04:	2785                	addiw	a5,a5,1
    2b06:	fef42623          	sw	a5,-20(s0)
    2b0a:	fec42783          	lw	a5,-20(s0)
    2b0e:	0007871b          	sext.w	a4,a5
    2b12:	47ad                	li	a5,11
    2b14:	f8e7dee3          	bge	a5,a4,2ab0 <fourfiles+0xf4>
        }
      }
      exit(0);
    2b18:	4501                	li	a0,0
    2b1a:	00004097          	auipc	ra,0x4
    2b1e:	560080e7          	jalr	1376(ra) # 707a <exit>
  for(pi = 0; pi < NCHILD; pi++){
    2b22:	fe042783          	lw	a5,-32(s0)
    2b26:	2785                	addiw	a5,a5,1
    2b28:	fef42023          	sw	a5,-32(s0)
    2b2c:	fe042783          	lw	a5,-32(s0)
    2b30:	0007871b          	sext.w	a4,a5
    2b34:	478d                	li	a5,3
    2b36:	eae7dce3          	bge	a5,a4,29ee <fourfiles+0x32>
    }
  }

  int xstatus;
  for(pi = 0; pi < NCHILD; pi++){
    2b3a:	fe042023          	sw	zero,-32(s0)
    2b3e:	a03d                	j	2b6c <fourfiles+0x1b0>
    wait(&xstatus);
    2b40:	fa440793          	addi	a5,s0,-92
    2b44:	853e                	mv	a0,a5
    2b46:	00004097          	auipc	ra,0x4
    2b4a:	53c080e7          	jalr	1340(ra) # 7082 <wait>
    if(xstatus != 0)
    2b4e:	fa442783          	lw	a5,-92(s0)
    2b52:	cb81                	beqz	a5,2b62 <fourfiles+0x1a6>
      exit(xstatus);
    2b54:	fa442783          	lw	a5,-92(s0)
    2b58:	853e                	mv	a0,a5
    2b5a:	00004097          	auipc	ra,0x4
    2b5e:	520080e7          	jalr	1312(ra) # 707a <exit>
  for(pi = 0; pi < NCHILD; pi++){
    2b62:	fe042783          	lw	a5,-32(s0)
    2b66:	2785                	addiw	a5,a5,1
    2b68:	fef42023          	sw	a5,-32(s0)
    2b6c:	fe042783          	lw	a5,-32(s0)
    2b70:	0007871b          	sext.w	a4,a5
    2b74:	478d                	li	a5,3
    2b76:	fce7d5e3          	bge	a5,a4,2b40 <fourfiles+0x184>
  }

  for(i = 0; i < NCHILD; i++){
    2b7a:	fe042623          	sw	zero,-20(s0)
    2b7e:	aa39                	j	2c9c <fourfiles+0x2e0>
    fname = names[i];
    2b80:	fec42783          	lw	a5,-20(s0)
    2b84:	078e                	slli	a5,a5,0x3
    2b86:	ff040713          	addi	a4,s0,-16
    2b8a:	97ba                	add	a5,a5,a4
    2b8c:	fb87b783          	ld	a5,-72(a5)
    2b90:	fcf43c23          	sd	a5,-40(s0)
    fd = open(fname, 0);
    2b94:	4581                	li	a1,0
    2b96:	fd843503          	ld	a0,-40(s0)
    2b9a:	00004097          	auipc	ra,0x4
    2b9e:	520080e7          	jalr	1312(ra) # 70ba <open>
    2ba2:	87aa                	mv	a5,a0
    2ba4:	fcf42a23          	sw	a5,-44(s0)
    total = 0;
    2ba8:	fe042223          	sw	zero,-28(s0)
    while((n = read(fd, buf, sizeof(buf))) > 0){
    2bac:	a88d                	j	2c1e <fourfiles+0x262>
      for(j = 0; j < n; j++){
    2bae:	fe042423          	sw	zero,-24(s0)
    2bb2:	a0b9                	j	2c00 <fourfiles+0x244>
        if(buf[j] != '0'+i){
    2bb4:	00008717          	auipc	a4,0x8
    2bb8:	d4c70713          	addi	a4,a4,-692 # a900 <buf>
    2bbc:	fe842783          	lw	a5,-24(s0)
    2bc0:	97ba                	add	a5,a5,a4
    2bc2:	0007c783          	lbu	a5,0(a5)
    2bc6:	0007871b          	sext.w	a4,a5
    2bca:	fec42783          	lw	a5,-20(s0)
    2bce:	0307879b          	addiw	a5,a5,48
    2bd2:	2781                	sext.w	a5,a5
    2bd4:	02f70163          	beq	a4,a5,2bf6 <fourfiles+0x23a>
          printf("wrong char\n", s);
    2bd8:	f9843583          	ld	a1,-104(s0)
    2bdc:	00006517          	auipc	a0,0x6
    2be0:	38450513          	addi	a0,a0,900 # 8f60 <schedule_rm+0x1166>
    2be4:	00005097          	auipc	ra,0x5
    2be8:	9dc080e7          	jalr	-1572(ra) # 75c0 <printf>
          exit(1);
    2bec:	4505                	li	a0,1
    2bee:	00004097          	auipc	ra,0x4
    2bf2:	48c080e7          	jalr	1164(ra) # 707a <exit>
      for(j = 0; j < n; j++){
    2bf6:	fe842783          	lw	a5,-24(s0)
    2bfa:	2785                	addiw	a5,a5,1
    2bfc:	fef42423          	sw	a5,-24(s0)
    2c00:	fe842703          	lw	a4,-24(s0)
    2c04:	fd042783          	lw	a5,-48(s0)
    2c08:	2701                	sext.w	a4,a4
    2c0a:	2781                	sext.w	a5,a5
    2c0c:	faf744e3          	blt	a4,a5,2bb4 <fourfiles+0x1f8>
        }
      }
      total += n;
    2c10:	fe442703          	lw	a4,-28(s0)
    2c14:	fd042783          	lw	a5,-48(s0)
    2c18:	9fb9                	addw	a5,a5,a4
    2c1a:	fef42223          	sw	a5,-28(s0)
    while((n = read(fd, buf, sizeof(buf))) > 0){
    2c1e:	fd442783          	lw	a5,-44(s0)
    2c22:	660d                	lui	a2,0x3
    2c24:	00008597          	auipc	a1,0x8
    2c28:	cdc58593          	addi	a1,a1,-804 # a900 <buf>
    2c2c:	853e                	mv	a0,a5
    2c2e:	00004097          	auipc	ra,0x4
    2c32:	464080e7          	jalr	1124(ra) # 7092 <read>
    2c36:	87aa                	mv	a5,a0
    2c38:	fcf42823          	sw	a5,-48(s0)
    2c3c:	fd042783          	lw	a5,-48(s0)
    2c40:	2781                	sext.w	a5,a5
    2c42:	f6f046e3          	bgtz	a5,2bae <fourfiles+0x1f2>
    }
    close(fd);
    2c46:	fd442783          	lw	a5,-44(s0)
    2c4a:	853e                	mv	a0,a5
    2c4c:	00004097          	auipc	ra,0x4
    2c50:	456080e7          	jalr	1110(ra) # 70a2 <close>
    if(total != N*SZ){
    2c54:	fe442783          	lw	a5,-28(s0)
    2c58:	0007871b          	sext.w	a4,a5
    2c5c:	6785                	lui	a5,0x1
    2c5e:	77078793          	addi	a5,a5,1904 # 1770 <writebig+0x124>
    2c62:	02f70263          	beq	a4,a5,2c86 <fourfiles+0x2ca>
      printf("wrong length %d\n", total);
    2c66:	fe442783          	lw	a5,-28(s0)
    2c6a:	85be                	mv	a1,a5
    2c6c:	00006517          	auipc	a0,0x6
    2c70:	30450513          	addi	a0,a0,772 # 8f70 <schedule_rm+0x1176>
    2c74:	00005097          	auipc	ra,0x5
    2c78:	94c080e7          	jalr	-1716(ra) # 75c0 <printf>
      exit(1);
    2c7c:	4505                	li	a0,1
    2c7e:	00004097          	auipc	ra,0x4
    2c82:	3fc080e7          	jalr	1020(ra) # 707a <exit>
    }
    unlink(fname);
    2c86:	fd843503          	ld	a0,-40(s0)
    2c8a:	00004097          	auipc	ra,0x4
    2c8e:	440080e7          	jalr	1088(ra) # 70ca <unlink>
  for(i = 0; i < NCHILD; i++){
    2c92:	fec42783          	lw	a5,-20(s0)
    2c96:	2785                	addiw	a5,a5,1
    2c98:	fef42623          	sw	a5,-20(s0)
    2c9c:	fec42783          	lw	a5,-20(s0)
    2ca0:	0007871b          	sext.w	a4,a5
    2ca4:	478d                	li	a5,3
    2ca6:	ece7dde3          	bge	a5,a4,2b80 <fourfiles+0x1c4>
  }
}
    2caa:	0001                	nop
    2cac:	0001                	nop
    2cae:	70a6                	ld	ra,104(sp)
    2cb0:	7406                	ld	s0,96(sp)
    2cb2:	6165                	addi	sp,sp,112
    2cb4:	8082                	ret

0000000000002cb6 <createdelete>:

// four processes create and delete different files in same directory
void
createdelete(char *s)
{
    2cb6:	711d                	addi	sp,sp,-96
    2cb8:	ec86                	sd	ra,88(sp)
    2cba:	e8a2                	sd	s0,80(sp)
    2cbc:	1080                	addi	s0,sp,96
    2cbe:	faa43423          	sd	a0,-88(s0)
  enum { N = 20, NCHILD=4 };
  int pid, i, fd, pi;
  char name[32];

  for(pi = 0; pi < NCHILD; pi++){
    2cc2:	fe042423          	sw	zero,-24(s0)
    2cc6:	aa91                	j	2e1a <createdelete+0x164>
    pid = fork();
    2cc8:	00004097          	auipc	ra,0x4
    2ccc:	3aa080e7          	jalr	938(ra) # 7072 <fork>
    2cd0:	87aa                	mv	a5,a0
    2cd2:	fef42023          	sw	a5,-32(s0)
    if(pid < 0){
    2cd6:	fe042783          	lw	a5,-32(s0)
    2cda:	2781                	sext.w	a5,a5
    2cdc:	0207d163          	bgez	a5,2cfe <createdelete+0x48>
      printf("fork failed\n", s);
    2ce0:	fa843583          	ld	a1,-88(s0)
    2ce4:	00006517          	auipc	a0,0x6
    2ce8:	9a450513          	addi	a0,a0,-1628 # 8688 <schedule_rm+0x88e>
    2cec:	00005097          	auipc	ra,0x5
    2cf0:	8d4080e7          	jalr	-1836(ra) # 75c0 <printf>
      exit(1);
    2cf4:	4505                	li	a0,1
    2cf6:	00004097          	auipc	ra,0x4
    2cfa:	384080e7          	jalr	900(ra) # 707a <exit>
    }

    if(pid == 0){
    2cfe:	fe042783          	lw	a5,-32(s0)
    2d02:	2781                	sext.w	a5,a5
    2d04:	10079663          	bnez	a5,2e10 <createdelete+0x15a>
      name[0] = 'p' + pi;
    2d08:	fe842783          	lw	a5,-24(s0)
    2d0c:	0ff7f793          	andi	a5,a5,255
    2d10:	0707879b          	addiw	a5,a5,112
    2d14:	0ff7f793          	andi	a5,a5,255
    2d18:	fcf40023          	sb	a5,-64(s0)
      name[2] = '\0';
    2d1c:	fc040123          	sb	zero,-62(s0)
      for(i = 0; i < N; i++){
    2d20:	fe042623          	sw	zero,-20(s0)
    2d24:	a8d1                	j	2df8 <createdelete+0x142>
        name[1] = '0' + i;
    2d26:	fec42783          	lw	a5,-20(s0)
    2d2a:	0ff7f793          	andi	a5,a5,255
    2d2e:	0307879b          	addiw	a5,a5,48
    2d32:	0ff7f793          	andi	a5,a5,255
    2d36:	fcf400a3          	sb	a5,-63(s0)
        fd = open(name, O_CREATE | O_RDWR);
    2d3a:	fc040793          	addi	a5,s0,-64
    2d3e:	20200593          	li	a1,514
    2d42:	853e                	mv	a0,a5
    2d44:	00004097          	auipc	ra,0x4
    2d48:	376080e7          	jalr	886(ra) # 70ba <open>
    2d4c:	87aa                	mv	a5,a0
    2d4e:	fef42223          	sw	a5,-28(s0)
        if(fd < 0){
    2d52:	fe442783          	lw	a5,-28(s0)
    2d56:	2781                	sext.w	a5,a5
    2d58:	0207d163          	bgez	a5,2d7a <createdelete+0xc4>
          printf("%s: create failed\n", s);
    2d5c:	fa843583          	ld	a1,-88(s0)
    2d60:	00006517          	auipc	a0,0x6
    2d64:	f7850513          	addi	a0,a0,-136 # 8cd8 <schedule_rm+0xede>
    2d68:	00005097          	auipc	ra,0x5
    2d6c:	858080e7          	jalr	-1960(ra) # 75c0 <printf>
          exit(1);
    2d70:	4505                	li	a0,1
    2d72:	00004097          	auipc	ra,0x4
    2d76:	308080e7          	jalr	776(ra) # 707a <exit>
        }
        close(fd);
    2d7a:	fe442783          	lw	a5,-28(s0)
    2d7e:	853e                	mv	a0,a5
    2d80:	00004097          	auipc	ra,0x4
    2d84:	322080e7          	jalr	802(ra) # 70a2 <close>
        if(i > 0 && (i % 2 ) == 0){
    2d88:	fec42783          	lw	a5,-20(s0)
    2d8c:	2781                	sext.w	a5,a5
    2d8e:	06f05063          	blez	a5,2dee <createdelete+0x138>
    2d92:	fec42783          	lw	a5,-20(s0)
    2d96:	8b85                	andi	a5,a5,1
    2d98:	2781                	sext.w	a5,a5
    2d9a:	ebb1                	bnez	a5,2dee <createdelete+0x138>
          name[1] = '0' + (i / 2);
    2d9c:	fec42783          	lw	a5,-20(s0)
    2da0:	01f7d71b          	srliw	a4,a5,0x1f
    2da4:	9fb9                	addw	a5,a5,a4
    2da6:	4017d79b          	sraiw	a5,a5,0x1
    2daa:	2781                	sext.w	a5,a5
    2dac:	0ff7f793          	andi	a5,a5,255
    2db0:	0307879b          	addiw	a5,a5,48
    2db4:	0ff7f793          	andi	a5,a5,255
    2db8:	fcf400a3          	sb	a5,-63(s0)
          if(unlink(name) < 0){
    2dbc:	fc040793          	addi	a5,s0,-64
    2dc0:	853e                	mv	a0,a5
    2dc2:	00004097          	auipc	ra,0x4
    2dc6:	308080e7          	jalr	776(ra) # 70ca <unlink>
    2dca:	87aa                	mv	a5,a0
    2dcc:	0207d163          	bgez	a5,2dee <createdelete+0x138>
            printf("%s: unlink failed\n", s);
    2dd0:	fa843583          	ld	a1,-88(s0)
    2dd4:	00006517          	auipc	a0,0x6
    2dd8:	c5450513          	addi	a0,a0,-940 # 8a28 <schedule_rm+0xc2e>
    2ddc:	00004097          	auipc	ra,0x4
    2de0:	7e4080e7          	jalr	2020(ra) # 75c0 <printf>
            exit(1);
    2de4:	4505                	li	a0,1
    2de6:	00004097          	auipc	ra,0x4
    2dea:	294080e7          	jalr	660(ra) # 707a <exit>
      for(i = 0; i < N; i++){
    2dee:	fec42783          	lw	a5,-20(s0)
    2df2:	2785                	addiw	a5,a5,1
    2df4:	fef42623          	sw	a5,-20(s0)
    2df8:	fec42783          	lw	a5,-20(s0)
    2dfc:	0007871b          	sext.w	a4,a5
    2e00:	47cd                	li	a5,19
    2e02:	f2e7d2e3          	bge	a5,a4,2d26 <createdelete+0x70>
          }
        }
      }
      exit(0);
    2e06:	4501                	li	a0,0
    2e08:	00004097          	auipc	ra,0x4
    2e0c:	272080e7          	jalr	626(ra) # 707a <exit>
  for(pi = 0; pi < NCHILD; pi++){
    2e10:	fe842783          	lw	a5,-24(s0)
    2e14:	2785                	addiw	a5,a5,1
    2e16:	fef42423          	sw	a5,-24(s0)
    2e1a:	fe842783          	lw	a5,-24(s0)
    2e1e:	0007871b          	sext.w	a4,a5
    2e22:	478d                	li	a5,3
    2e24:	eae7d2e3          	bge	a5,a4,2cc8 <createdelete+0x12>
    }
  }

  int xstatus;
  for(pi = 0; pi < NCHILD; pi++){
    2e28:	fe042423          	sw	zero,-24(s0)
    2e2c:	a02d                	j	2e56 <createdelete+0x1a0>
    wait(&xstatus);
    2e2e:	fbc40793          	addi	a5,s0,-68
    2e32:	853e                	mv	a0,a5
    2e34:	00004097          	auipc	ra,0x4
    2e38:	24e080e7          	jalr	590(ra) # 7082 <wait>
    if(xstatus != 0)
    2e3c:	fbc42783          	lw	a5,-68(s0)
    2e40:	c791                	beqz	a5,2e4c <createdelete+0x196>
      exit(1);
    2e42:	4505                	li	a0,1
    2e44:	00004097          	auipc	ra,0x4
    2e48:	236080e7          	jalr	566(ra) # 707a <exit>
  for(pi = 0; pi < NCHILD; pi++){
    2e4c:	fe842783          	lw	a5,-24(s0)
    2e50:	2785                	addiw	a5,a5,1
    2e52:	fef42423          	sw	a5,-24(s0)
    2e56:	fe842783          	lw	a5,-24(s0)
    2e5a:	0007871b          	sext.w	a4,a5
    2e5e:	478d                	li	a5,3
    2e60:	fce7d7e3          	bge	a5,a4,2e2e <createdelete+0x178>
  }

  name[0] = name[1] = name[2] = 0;
    2e64:	fc040123          	sb	zero,-62(s0)
    2e68:	fc244783          	lbu	a5,-62(s0)
    2e6c:	fcf400a3          	sb	a5,-63(s0)
    2e70:	fc144783          	lbu	a5,-63(s0)
    2e74:	fcf40023          	sb	a5,-64(s0)
  for(i = 0; i < N; i++){
    2e78:	fe042623          	sw	zero,-20(s0)
    2e7c:	a229                	j	2f86 <createdelete+0x2d0>
    for(pi = 0; pi < NCHILD; pi++){
    2e7e:	fe042423          	sw	zero,-24(s0)
    2e82:	a0f5                	j	2f6e <createdelete+0x2b8>
      name[0] = 'p' + pi;
    2e84:	fe842783          	lw	a5,-24(s0)
    2e88:	0ff7f793          	andi	a5,a5,255
    2e8c:	0707879b          	addiw	a5,a5,112
    2e90:	0ff7f793          	andi	a5,a5,255
    2e94:	fcf40023          	sb	a5,-64(s0)
      name[1] = '0' + i;
    2e98:	fec42783          	lw	a5,-20(s0)
    2e9c:	0ff7f793          	andi	a5,a5,255
    2ea0:	0307879b          	addiw	a5,a5,48
    2ea4:	0ff7f793          	andi	a5,a5,255
    2ea8:	fcf400a3          	sb	a5,-63(s0)
      fd = open(name, 0);
    2eac:	fc040793          	addi	a5,s0,-64
    2eb0:	4581                	li	a1,0
    2eb2:	853e                	mv	a0,a5
    2eb4:	00004097          	auipc	ra,0x4
    2eb8:	206080e7          	jalr	518(ra) # 70ba <open>
    2ebc:	87aa                	mv	a5,a0
    2ebe:	fef42223          	sw	a5,-28(s0)
      if((i == 0 || i >= N/2) && fd < 0){
    2ec2:	fec42783          	lw	a5,-20(s0)
    2ec6:	2781                	sext.w	a5,a5
    2ec8:	cb81                	beqz	a5,2ed8 <createdelete+0x222>
    2eca:	fec42783          	lw	a5,-20(s0)
    2ece:	0007871b          	sext.w	a4,a5
    2ed2:	47a5                	li	a5,9
    2ed4:	02e7d963          	bge	a5,a4,2f06 <createdelete+0x250>
    2ed8:	fe442783          	lw	a5,-28(s0)
    2edc:	2781                	sext.w	a5,a5
    2ede:	0207d463          	bgez	a5,2f06 <createdelete+0x250>
        printf("%s: oops createdelete %s didn't exist\n", s, name);
    2ee2:	fc040793          	addi	a5,s0,-64
    2ee6:	863e                	mv	a2,a5
    2ee8:	fa843583          	ld	a1,-88(s0)
    2eec:	00006517          	auipc	a0,0x6
    2ef0:	0bc50513          	addi	a0,a0,188 # 8fa8 <schedule_rm+0x11ae>
    2ef4:	00004097          	auipc	ra,0x4
    2ef8:	6cc080e7          	jalr	1740(ra) # 75c0 <printf>
        exit(1);
    2efc:	4505                	li	a0,1
    2efe:	00004097          	auipc	ra,0x4
    2f02:	17c080e7          	jalr	380(ra) # 707a <exit>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    2f06:	fec42783          	lw	a5,-20(s0)
    2f0a:	2781                	sext.w	a5,a5
    2f0c:	04f05063          	blez	a5,2f4c <createdelete+0x296>
    2f10:	fec42783          	lw	a5,-20(s0)
    2f14:	0007871b          	sext.w	a4,a5
    2f18:	47a5                	li	a5,9
    2f1a:	02e7c963          	blt	a5,a4,2f4c <createdelete+0x296>
    2f1e:	fe442783          	lw	a5,-28(s0)
    2f22:	2781                	sext.w	a5,a5
    2f24:	0207c463          	bltz	a5,2f4c <createdelete+0x296>
        printf("%s: oops createdelete %s did exist\n", s, name);
    2f28:	fc040793          	addi	a5,s0,-64
    2f2c:	863e                	mv	a2,a5
    2f2e:	fa843583          	ld	a1,-88(s0)
    2f32:	00006517          	auipc	a0,0x6
    2f36:	09e50513          	addi	a0,a0,158 # 8fd0 <schedule_rm+0x11d6>
    2f3a:	00004097          	auipc	ra,0x4
    2f3e:	686080e7          	jalr	1670(ra) # 75c0 <printf>
        exit(1);
    2f42:	4505                	li	a0,1
    2f44:	00004097          	auipc	ra,0x4
    2f48:	136080e7          	jalr	310(ra) # 707a <exit>
      }
      if(fd >= 0)
    2f4c:	fe442783          	lw	a5,-28(s0)
    2f50:	2781                	sext.w	a5,a5
    2f52:	0007c963          	bltz	a5,2f64 <createdelete+0x2ae>
        close(fd);
    2f56:	fe442783          	lw	a5,-28(s0)
    2f5a:	853e                	mv	a0,a5
    2f5c:	00004097          	auipc	ra,0x4
    2f60:	146080e7          	jalr	326(ra) # 70a2 <close>
    for(pi = 0; pi < NCHILD; pi++){
    2f64:	fe842783          	lw	a5,-24(s0)
    2f68:	2785                	addiw	a5,a5,1
    2f6a:	fef42423          	sw	a5,-24(s0)
    2f6e:	fe842783          	lw	a5,-24(s0)
    2f72:	0007871b          	sext.w	a4,a5
    2f76:	478d                	li	a5,3
    2f78:	f0e7d6e3          	bge	a5,a4,2e84 <createdelete+0x1ce>
  for(i = 0; i < N; i++){
    2f7c:	fec42783          	lw	a5,-20(s0)
    2f80:	2785                	addiw	a5,a5,1
    2f82:	fef42623          	sw	a5,-20(s0)
    2f86:	fec42783          	lw	a5,-20(s0)
    2f8a:	0007871b          	sext.w	a4,a5
    2f8e:	47cd                	li	a5,19
    2f90:	eee7d7e3          	bge	a5,a4,2e7e <createdelete+0x1c8>
    }
  }

  for(i = 0; i < N; i++){
    2f94:	fe042623          	sw	zero,-20(s0)
    2f98:	a085                	j	2ff8 <createdelete+0x342>
    for(pi = 0; pi < NCHILD; pi++){
    2f9a:	fe042423          	sw	zero,-24(s0)
    2f9e:	a089                	j	2fe0 <createdelete+0x32a>
      name[0] = 'p' + i;
    2fa0:	fec42783          	lw	a5,-20(s0)
    2fa4:	0ff7f793          	andi	a5,a5,255
    2fa8:	0707879b          	addiw	a5,a5,112
    2fac:	0ff7f793          	andi	a5,a5,255
    2fb0:	fcf40023          	sb	a5,-64(s0)
      name[1] = '0' + i;
    2fb4:	fec42783          	lw	a5,-20(s0)
    2fb8:	0ff7f793          	andi	a5,a5,255
    2fbc:	0307879b          	addiw	a5,a5,48
    2fc0:	0ff7f793          	andi	a5,a5,255
    2fc4:	fcf400a3          	sb	a5,-63(s0)
      unlink(name);
    2fc8:	fc040793          	addi	a5,s0,-64
    2fcc:	853e                	mv	a0,a5
    2fce:	00004097          	auipc	ra,0x4
    2fd2:	0fc080e7          	jalr	252(ra) # 70ca <unlink>
    for(pi = 0; pi < NCHILD; pi++){
    2fd6:	fe842783          	lw	a5,-24(s0)
    2fda:	2785                	addiw	a5,a5,1
    2fdc:	fef42423          	sw	a5,-24(s0)
    2fe0:	fe842783          	lw	a5,-24(s0)
    2fe4:	0007871b          	sext.w	a4,a5
    2fe8:	478d                	li	a5,3
    2fea:	fae7dbe3          	bge	a5,a4,2fa0 <createdelete+0x2ea>
  for(i = 0; i < N; i++){
    2fee:	fec42783          	lw	a5,-20(s0)
    2ff2:	2785                	addiw	a5,a5,1
    2ff4:	fef42623          	sw	a5,-20(s0)
    2ff8:	fec42783          	lw	a5,-20(s0)
    2ffc:	0007871b          	sext.w	a4,a5
    3000:	47cd                	li	a5,19
    3002:	f8e7dce3          	bge	a5,a4,2f9a <createdelete+0x2e4>
    }
  }
}
    3006:	0001                	nop
    3008:	0001                	nop
    300a:	60e6                	ld	ra,88(sp)
    300c:	6446                	ld	s0,80(sp)
    300e:	6125                	addi	sp,sp,96
    3010:	8082                	ret

0000000000003012 <unlinkread>:

// can I unlink a file and still read it?
void
unlinkread(char *s)
{
    3012:	7179                	addi	sp,sp,-48
    3014:	f406                	sd	ra,40(sp)
    3016:	f022                	sd	s0,32(sp)
    3018:	1800                	addi	s0,sp,48
    301a:	fca43c23          	sd	a0,-40(s0)
  enum { SZ = 5 };
  int fd, fd1;

  fd = open("unlinkread", O_CREATE | O_RDWR);
    301e:	20200593          	li	a1,514
    3022:	00005517          	auipc	a0,0x5
    3026:	29650513          	addi	a0,a0,662 # 82b8 <schedule_rm+0x4be>
    302a:	00004097          	auipc	ra,0x4
    302e:	090080e7          	jalr	144(ra) # 70ba <open>
    3032:	87aa                	mv	a5,a0
    3034:	fef42623          	sw	a5,-20(s0)
  if(fd < 0){
    3038:	fec42783          	lw	a5,-20(s0)
    303c:	2781                	sext.w	a5,a5
    303e:	0207d163          	bgez	a5,3060 <unlinkread+0x4e>
    printf("%s: create unlinkread failed\n", s);
    3042:	fd843583          	ld	a1,-40(s0)
    3046:	00006517          	auipc	a0,0x6
    304a:	fb250513          	addi	a0,a0,-78 # 8ff8 <schedule_rm+0x11fe>
    304e:	00004097          	auipc	ra,0x4
    3052:	572080e7          	jalr	1394(ra) # 75c0 <printf>
    exit(1);
    3056:	4505                	li	a0,1
    3058:	00004097          	auipc	ra,0x4
    305c:	022080e7          	jalr	34(ra) # 707a <exit>
  }
  write(fd, "hello", SZ);
    3060:	fec42783          	lw	a5,-20(s0)
    3064:	4615                	li	a2,5
    3066:	00006597          	auipc	a1,0x6
    306a:	fb258593          	addi	a1,a1,-78 # 9018 <schedule_rm+0x121e>
    306e:	853e                	mv	a0,a5
    3070:	00004097          	auipc	ra,0x4
    3074:	02a080e7          	jalr	42(ra) # 709a <write>
  close(fd);
    3078:	fec42783          	lw	a5,-20(s0)
    307c:	853e                	mv	a0,a5
    307e:	00004097          	auipc	ra,0x4
    3082:	024080e7          	jalr	36(ra) # 70a2 <close>

  fd = open("unlinkread", O_RDWR);
    3086:	4589                	li	a1,2
    3088:	00005517          	auipc	a0,0x5
    308c:	23050513          	addi	a0,a0,560 # 82b8 <schedule_rm+0x4be>
    3090:	00004097          	auipc	ra,0x4
    3094:	02a080e7          	jalr	42(ra) # 70ba <open>
    3098:	87aa                	mv	a5,a0
    309a:	fef42623          	sw	a5,-20(s0)
  if(fd < 0){
    309e:	fec42783          	lw	a5,-20(s0)
    30a2:	2781                	sext.w	a5,a5
    30a4:	0207d163          	bgez	a5,30c6 <unlinkread+0xb4>
    printf("%s: open unlinkread failed\n", s);
    30a8:	fd843583          	ld	a1,-40(s0)
    30ac:	00006517          	auipc	a0,0x6
    30b0:	f7450513          	addi	a0,a0,-140 # 9020 <schedule_rm+0x1226>
    30b4:	00004097          	auipc	ra,0x4
    30b8:	50c080e7          	jalr	1292(ra) # 75c0 <printf>
    exit(1);
    30bc:	4505                	li	a0,1
    30be:	00004097          	auipc	ra,0x4
    30c2:	fbc080e7          	jalr	-68(ra) # 707a <exit>
  }
  if(unlink("unlinkread") != 0){
    30c6:	00005517          	auipc	a0,0x5
    30ca:	1f250513          	addi	a0,a0,498 # 82b8 <schedule_rm+0x4be>
    30ce:	00004097          	auipc	ra,0x4
    30d2:	ffc080e7          	jalr	-4(ra) # 70ca <unlink>
    30d6:	87aa                	mv	a5,a0
    30d8:	c385                	beqz	a5,30f8 <unlinkread+0xe6>
    printf("%s: unlink unlinkread failed\n", s);
    30da:	fd843583          	ld	a1,-40(s0)
    30de:	00006517          	auipc	a0,0x6
    30e2:	f6250513          	addi	a0,a0,-158 # 9040 <schedule_rm+0x1246>
    30e6:	00004097          	auipc	ra,0x4
    30ea:	4da080e7          	jalr	1242(ra) # 75c0 <printf>
    exit(1);
    30ee:	4505                	li	a0,1
    30f0:	00004097          	auipc	ra,0x4
    30f4:	f8a080e7          	jalr	-118(ra) # 707a <exit>
  }

  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    30f8:	20200593          	li	a1,514
    30fc:	00005517          	auipc	a0,0x5
    3100:	1bc50513          	addi	a0,a0,444 # 82b8 <schedule_rm+0x4be>
    3104:	00004097          	auipc	ra,0x4
    3108:	fb6080e7          	jalr	-74(ra) # 70ba <open>
    310c:	87aa                	mv	a5,a0
    310e:	fef42423          	sw	a5,-24(s0)
  write(fd1, "yyy", 3);
    3112:	fe842783          	lw	a5,-24(s0)
    3116:	460d                	li	a2,3
    3118:	00006597          	auipc	a1,0x6
    311c:	f4858593          	addi	a1,a1,-184 # 9060 <schedule_rm+0x1266>
    3120:	853e                	mv	a0,a5
    3122:	00004097          	auipc	ra,0x4
    3126:	f78080e7          	jalr	-136(ra) # 709a <write>
  close(fd1);
    312a:	fe842783          	lw	a5,-24(s0)
    312e:	853e                	mv	a0,a5
    3130:	00004097          	auipc	ra,0x4
    3134:	f72080e7          	jalr	-142(ra) # 70a2 <close>

  if(read(fd, buf, sizeof(buf)) != SZ){
    3138:	fec42783          	lw	a5,-20(s0)
    313c:	660d                	lui	a2,0x3
    313e:	00007597          	auipc	a1,0x7
    3142:	7c258593          	addi	a1,a1,1986 # a900 <buf>
    3146:	853e                	mv	a0,a5
    3148:	00004097          	auipc	ra,0x4
    314c:	f4a080e7          	jalr	-182(ra) # 7092 <read>
    3150:	87aa                	mv	a5,a0
    3152:	873e                	mv	a4,a5
    3154:	4795                	li	a5,5
    3156:	02f70163          	beq	a4,a5,3178 <unlinkread+0x166>
    printf("%s: unlinkread read failed", s);
    315a:	fd843583          	ld	a1,-40(s0)
    315e:	00006517          	auipc	a0,0x6
    3162:	f0a50513          	addi	a0,a0,-246 # 9068 <schedule_rm+0x126e>
    3166:	00004097          	auipc	ra,0x4
    316a:	45a080e7          	jalr	1114(ra) # 75c0 <printf>
    exit(1);
    316e:	4505                	li	a0,1
    3170:	00004097          	auipc	ra,0x4
    3174:	f0a080e7          	jalr	-246(ra) # 707a <exit>
  }
  if(buf[0] != 'h'){
    3178:	00007797          	auipc	a5,0x7
    317c:	78878793          	addi	a5,a5,1928 # a900 <buf>
    3180:	0007c783          	lbu	a5,0(a5)
    3184:	873e                	mv	a4,a5
    3186:	06800793          	li	a5,104
    318a:	02f70163          	beq	a4,a5,31ac <unlinkread+0x19a>
    printf("%s: unlinkread wrong data\n", s);
    318e:	fd843583          	ld	a1,-40(s0)
    3192:	00006517          	auipc	a0,0x6
    3196:	ef650513          	addi	a0,a0,-266 # 9088 <schedule_rm+0x128e>
    319a:	00004097          	auipc	ra,0x4
    319e:	426080e7          	jalr	1062(ra) # 75c0 <printf>
    exit(1);
    31a2:	4505                	li	a0,1
    31a4:	00004097          	auipc	ra,0x4
    31a8:	ed6080e7          	jalr	-298(ra) # 707a <exit>
  }
  if(write(fd, buf, 10) != 10){
    31ac:	fec42783          	lw	a5,-20(s0)
    31b0:	4629                	li	a2,10
    31b2:	00007597          	auipc	a1,0x7
    31b6:	74e58593          	addi	a1,a1,1870 # a900 <buf>
    31ba:	853e                	mv	a0,a5
    31bc:	00004097          	auipc	ra,0x4
    31c0:	ede080e7          	jalr	-290(ra) # 709a <write>
    31c4:	87aa                	mv	a5,a0
    31c6:	873e                	mv	a4,a5
    31c8:	47a9                	li	a5,10
    31ca:	02f70163          	beq	a4,a5,31ec <unlinkread+0x1da>
    printf("%s: unlinkread write failed\n", s);
    31ce:	fd843583          	ld	a1,-40(s0)
    31d2:	00006517          	auipc	a0,0x6
    31d6:	ed650513          	addi	a0,a0,-298 # 90a8 <schedule_rm+0x12ae>
    31da:	00004097          	auipc	ra,0x4
    31de:	3e6080e7          	jalr	998(ra) # 75c0 <printf>
    exit(1);
    31e2:	4505                	li	a0,1
    31e4:	00004097          	auipc	ra,0x4
    31e8:	e96080e7          	jalr	-362(ra) # 707a <exit>
  }
  close(fd);
    31ec:	fec42783          	lw	a5,-20(s0)
    31f0:	853e                	mv	a0,a5
    31f2:	00004097          	auipc	ra,0x4
    31f6:	eb0080e7          	jalr	-336(ra) # 70a2 <close>
  unlink("unlinkread");
    31fa:	00005517          	auipc	a0,0x5
    31fe:	0be50513          	addi	a0,a0,190 # 82b8 <schedule_rm+0x4be>
    3202:	00004097          	auipc	ra,0x4
    3206:	ec8080e7          	jalr	-312(ra) # 70ca <unlink>
}
    320a:	0001                	nop
    320c:	70a2                	ld	ra,40(sp)
    320e:	7402                	ld	s0,32(sp)
    3210:	6145                	addi	sp,sp,48
    3212:	8082                	ret

0000000000003214 <linktest>:

void
linktest(char *s)
{
    3214:	7179                	addi	sp,sp,-48
    3216:	f406                	sd	ra,40(sp)
    3218:	f022                	sd	s0,32(sp)
    321a:	1800                	addi	s0,sp,48
    321c:	fca43c23          	sd	a0,-40(s0)
  enum { SZ = 5 };
  int fd;

  unlink("lf1");
    3220:	00006517          	auipc	a0,0x6
    3224:	ea850513          	addi	a0,a0,-344 # 90c8 <schedule_rm+0x12ce>
    3228:	00004097          	auipc	ra,0x4
    322c:	ea2080e7          	jalr	-350(ra) # 70ca <unlink>
  unlink("lf2");
    3230:	00006517          	auipc	a0,0x6
    3234:	ea050513          	addi	a0,a0,-352 # 90d0 <schedule_rm+0x12d6>
    3238:	00004097          	auipc	ra,0x4
    323c:	e92080e7          	jalr	-366(ra) # 70ca <unlink>

  fd = open("lf1", O_CREATE|O_RDWR);
    3240:	20200593          	li	a1,514
    3244:	00006517          	auipc	a0,0x6
    3248:	e8450513          	addi	a0,a0,-380 # 90c8 <schedule_rm+0x12ce>
    324c:	00004097          	auipc	ra,0x4
    3250:	e6e080e7          	jalr	-402(ra) # 70ba <open>
    3254:	87aa                	mv	a5,a0
    3256:	fef42623          	sw	a5,-20(s0)
  if(fd < 0){
    325a:	fec42783          	lw	a5,-20(s0)
    325e:	2781                	sext.w	a5,a5
    3260:	0207d163          	bgez	a5,3282 <linktest+0x6e>
    printf("%s: create lf1 failed\n", s);
    3264:	fd843583          	ld	a1,-40(s0)
    3268:	00006517          	auipc	a0,0x6
    326c:	e7050513          	addi	a0,a0,-400 # 90d8 <schedule_rm+0x12de>
    3270:	00004097          	auipc	ra,0x4
    3274:	350080e7          	jalr	848(ra) # 75c0 <printf>
    exit(1);
    3278:	4505                	li	a0,1
    327a:	00004097          	auipc	ra,0x4
    327e:	e00080e7          	jalr	-512(ra) # 707a <exit>
  }
  if(write(fd, "hello", SZ) != SZ){
    3282:	fec42783          	lw	a5,-20(s0)
    3286:	4615                	li	a2,5
    3288:	00006597          	auipc	a1,0x6
    328c:	d9058593          	addi	a1,a1,-624 # 9018 <schedule_rm+0x121e>
    3290:	853e                	mv	a0,a5
    3292:	00004097          	auipc	ra,0x4
    3296:	e08080e7          	jalr	-504(ra) # 709a <write>
    329a:	87aa                	mv	a5,a0
    329c:	873e                	mv	a4,a5
    329e:	4795                	li	a5,5
    32a0:	02f70163          	beq	a4,a5,32c2 <linktest+0xae>
    printf("%s: write lf1 failed\n", s);
    32a4:	fd843583          	ld	a1,-40(s0)
    32a8:	00006517          	auipc	a0,0x6
    32ac:	e4850513          	addi	a0,a0,-440 # 90f0 <schedule_rm+0x12f6>
    32b0:	00004097          	auipc	ra,0x4
    32b4:	310080e7          	jalr	784(ra) # 75c0 <printf>
    exit(1);
    32b8:	4505                	li	a0,1
    32ba:	00004097          	auipc	ra,0x4
    32be:	dc0080e7          	jalr	-576(ra) # 707a <exit>
  }
  close(fd);
    32c2:	fec42783          	lw	a5,-20(s0)
    32c6:	853e                	mv	a0,a5
    32c8:	00004097          	auipc	ra,0x4
    32cc:	dda080e7          	jalr	-550(ra) # 70a2 <close>

  if(link("lf1", "lf2") < 0){
    32d0:	00006597          	auipc	a1,0x6
    32d4:	e0058593          	addi	a1,a1,-512 # 90d0 <schedule_rm+0x12d6>
    32d8:	00006517          	auipc	a0,0x6
    32dc:	df050513          	addi	a0,a0,-528 # 90c8 <schedule_rm+0x12ce>
    32e0:	00004097          	auipc	ra,0x4
    32e4:	dfa080e7          	jalr	-518(ra) # 70da <link>
    32e8:	87aa                	mv	a5,a0
    32ea:	0207d163          	bgez	a5,330c <linktest+0xf8>
    printf("%s: link lf1 lf2 failed\n", s);
    32ee:	fd843583          	ld	a1,-40(s0)
    32f2:	00006517          	auipc	a0,0x6
    32f6:	e1650513          	addi	a0,a0,-490 # 9108 <schedule_rm+0x130e>
    32fa:	00004097          	auipc	ra,0x4
    32fe:	2c6080e7          	jalr	710(ra) # 75c0 <printf>
    exit(1);
    3302:	4505                	li	a0,1
    3304:	00004097          	auipc	ra,0x4
    3308:	d76080e7          	jalr	-650(ra) # 707a <exit>
  }
  unlink("lf1");
    330c:	00006517          	auipc	a0,0x6
    3310:	dbc50513          	addi	a0,a0,-580 # 90c8 <schedule_rm+0x12ce>
    3314:	00004097          	auipc	ra,0x4
    3318:	db6080e7          	jalr	-586(ra) # 70ca <unlink>

  if(open("lf1", 0) >= 0){
    331c:	4581                	li	a1,0
    331e:	00006517          	auipc	a0,0x6
    3322:	daa50513          	addi	a0,a0,-598 # 90c8 <schedule_rm+0x12ce>
    3326:	00004097          	auipc	ra,0x4
    332a:	d94080e7          	jalr	-620(ra) # 70ba <open>
    332e:	87aa                	mv	a5,a0
    3330:	0207c163          	bltz	a5,3352 <linktest+0x13e>
    printf("%s: unlinked lf1 but it is still there!\n", s);
    3334:	fd843583          	ld	a1,-40(s0)
    3338:	00006517          	auipc	a0,0x6
    333c:	df050513          	addi	a0,a0,-528 # 9128 <schedule_rm+0x132e>
    3340:	00004097          	auipc	ra,0x4
    3344:	280080e7          	jalr	640(ra) # 75c0 <printf>
    exit(1);
    3348:	4505                	li	a0,1
    334a:	00004097          	auipc	ra,0x4
    334e:	d30080e7          	jalr	-720(ra) # 707a <exit>
  }

  fd = open("lf2", 0);
    3352:	4581                	li	a1,0
    3354:	00006517          	auipc	a0,0x6
    3358:	d7c50513          	addi	a0,a0,-644 # 90d0 <schedule_rm+0x12d6>
    335c:	00004097          	auipc	ra,0x4
    3360:	d5e080e7          	jalr	-674(ra) # 70ba <open>
    3364:	87aa                	mv	a5,a0
    3366:	fef42623          	sw	a5,-20(s0)
  if(fd < 0){
    336a:	fec42783          	lw	a5,-20(s0)
    336e:	2781                	sext.w	a5,a5
    3370:	0207d163          	bgez	a5,3392 <linktest+0x17e>
    printf("%s: open lf2 failed\n", s);
    3374:	fd843583          	ld	a1,-40(s0)
    3378:	00006517          	auipc	a0,0x6
    337c:	de050513          	addi	a0,a0,-544 # 9158 <schedule_rm+0x135e>
    3380:	00004097          	auipc	ra,0x4
    3384:	240080e7          	jalr	576(ra) # 75c0 <printf>
    exit(1);
    3388:	4505                	li	a0,1
    338a:	00004097          	auipc	ra,0x4
    338e:	cf0080e7          	jalr	-784(ra) # 707a <exit>
  }
  if(read(fd, buf, sizeof(buf)) != SZ){
    3392:	fec42783          	lw	a5,-20(s0)
    3396:	660d                	lui	a2,0x3
    3398:	00007597          	auipc	a1,0x7
    339c:	56858593          	addi	a1,a1,1384 # a900 <buf>
    33a0:	853e                	mv	a0,a5
    33a2:	00004097          	auipc	ra,0x4
    33a6:	cf0080e7          	jalr	-784(ra) # 7092 <read>
    33aa:	87aa                	mv	a5,a0
    33ac:	873e                	mv	a4,a5
    33ae:	4795                	li	a5,5
    33b0:	02f70163          	beq	a4,a5,33d2 <linktest+0x1be>
    printf("%s: read lf2 failed\n", s);
    33b4:	fd843583          	ld	a1,-40(s0)
    33b8:	00006517          	auipc	a0,0x6
    33bc:	db850513          	addi	a0,a0,-584 # 9170 <schedule_rm+0x1376>
    33c0:	00004097          	auipc	ra,0x4
    33c4:	200080e7          	jalr	512(ra) # 75c0 <printf>
    exit(1);
    33c8:	4505                	li	a0,1
    33ca:	00004097          	auipc	ra,0x4
    33ce:	cb0080e7          	jalr	-848(ra) # 707a <exit>
  }
  close(fd);
    33d2:	fec42783          	lw	a5,-20(s0)
    33d6:	853e                	mv	a0,a5
    33d8:	00004097          	auipc	ra,0x4
    33dc:	cca080e7          	jalr	-822(ra) # 70a2 <close>

  if(link("lf2", "lf2") >= 0){
    33e0:	00006597          	auipc	a1,0x6
    33e4:	cf058593          	addi	a1,a1,-784 # 90d0 <schedule_rm+0x12d6>
    33e8:	00006517          	auipc	a0,0x6
    33ec:	ce850513          	addi	a0,a0,-792 # 90d0 <schedule_rm+0x12d6>
    33f0:	00004097          	auipc	ra,0x4
    33f4:	cea080e7          	jalr	-790(ra) # 70da <link>
    33f8:	87aa                	mv	a5,a0
    33fa:	0207c163          	bltz	a5,341c <linktest+0x208>
    printf("%s: link lf2 lf2 succeeded! oops\n", s);
    33fe:	fd843583          	ld	a1,-40(s0)
    3402:	00006517          	auipc	a0,0x6
    3406:	d8650513          	addi	a0,a0,-634 # 9188 <schedule_rm+0x138e>
    340a:	00004097          	auipc	ra,0x4
    340e:	1b6080e7          	jalr	438(ra) # 75c0 <printf>
    exit(1);
    3412:	4505                	li	a0,1
    3414:	00004097          	auipc	ra,0x4
    3418:	c66080e7          	jalr	-922(ra) # 707a <exit>
  }

  unlink("lf2");
    341c:	00006517          	auipc	a0,0x6
    3420:	cb450513          	addi	a0,a0,-844 # 90d0 <schedule_rm+0x12d6>
    3424:	00004097          	auipc	ra,0x4
    3428:	ca6080e7          	jalr	-858(ra) # 70ca <unlink>
  if(link("lf2", "lf1") >= 0){
    342c:	00006597          	auipc	a1,0x6
    3430:	c9c58593          	addi	a1,a1,-868 # 90c8 <schedule_rm+0x12ce>
    3434:	00006517          	auipc	a0,0x6
    3438:	c9c50513          	addi	a0,a0,-868 # 90d0 <schedule_rm+0x12d6>
    343c:	00004097          	auipc	ra,0x4
    3440:	c9e080e7          	jalr	-866(ra) # 70da <link>
    3444:	87aa                	mv	a5,a0
    3446:	0207c163          	bltz	a5,3468 <linktest+0x254>
    printf("%s: link non-existant succeeded! oops\n", s);
    344a:	fd843583          	ld	a1,-40(s0)
    344e:	00006517          	auipc	a0,0x6
    3452:	d6250513          	addi	a0,a0,-670 # 91b0 <schedule_rm+0x13b6>
    3456:	00004097          	auipc	ra,0x4
    345a:	16a080e7          	jalr	362(ra) # 75c0 <printf>
    exit(1);
    345e:	4505                	li	a0,1
    3460:	00004097          	auipc	ra,0x4
    3464:	c1a080e7          	jalr	-998(ra) # 707a <exit>
  }

  if(link(".", "lf1") >= 0){
    3468:	00006597          	auipc	a1,0x6
    346c:	c6058593          	addi	a1,a1,-928 # 90c8 <schedule_rm+0x12ce>
    3470:	00006517          	auipc	a0,0x6
    3474:	d6850513          	addi	a0,a0,-664 # 91d8 <schedule_rm+0x13de>
    3478:	00004097          	auipc	ra,0x4
    347c:	c62080e7          	jalr	-926(ra) # 70da <link>
    3480:	87aa                	mv	a5,a0
    3482:	0207c163          	bltz	a5,34a4 <linktest+0x290>
    printf("%s: link . lf1 succeeded! oops\n", s);
    3486:	fd843583          	ld	a1,-40(s0)
    348a:	00006517          	auipc	a0,0x6
    348e:	d5650513          	addi	a0,a0,-682 # 91e0 <schedule_rm+0x13e6>
    3492:	00004097          	auipc	ra,0x4
    3496:	12e080e7          	jalr	302(ra) # 75c0 <printf>
    exit(1);
    349a:	4505                	li	a0,1
    349c:	00004097          	auipc	ra,0x4
    34a0:	bde080e7          	jalr	-1058(ra) # 707a <exit>
  }
}
    34a4:	0001                	nop
    34a6:	70a2                	ld	ra,40(sp)
    34a8:	7402                	ld	s0,32(sp)
    34aa:	6145                	addi	sp,sp,48
    34ac:	8082                	ret

00000000000034ae <concreate>:

// test concurrent create/link/unlink of the same file
void
concreate(char *s)
{
    34ae:	7119                	addi	sp,sp,-128
    34b0:	fc86                	sd	ra,120(sp)
    34b2:	f8a2                	sd	s0,112(sp)
    34b4:	0100                	addi	s0,sp,128
    34b6:	f8a43423          	sd	a0,-120(s0)
  struct {
    ushort inum;
    char name[DIRSIZ];
  } de;

  file[0] = 'C';
    34ba:	04300793          	li	a5,67
    34be:	fcf40c23          	sb	a5,-40(s0)
  file[2] = '\0';
    34c2:	fc040d23          	sb	zero,-38(s0)
  for(i = 0; i < N; i++){
    34c6:	fe042623          	sw	zero,-20(s0)
    34ca:	a215                	j	35ee <concreate+0x140>
    file[1] = '0' + i;
    34cc:	fec42783          	lw	a5,-20(s0)
    34d0:	0ff7f793          	andi	a5,a5,255
    34d4:	0307879b          	addiw	a5,a5,48
    34d8:	0ff7f793          	andi	a5,a5,255
    34dc:	fcf40ca3          	sb	a5,-39(s0)
    unlink(file);
    34e0:	fd840793          	addi	a5,s0,-40
    34e4:	853e                	mv	a0,a5
    34e6:	00004097          	auipc	ra,0x4
    34ea:	be4080e7          	jalr	-1052(ra) # 70ca <unlink>
    pid = fork();
    34ee:	00004097          	auipc	ra,0x4
    34f2:	b84080e7          	jalr	-1148(ra) # 7072 <fork>
    34f6:	87aa                	mv	a5,a0
    34f8:	fef42023          	sw	a5,-32(s0)
    if(pid && (i % 3) == 1){
    34fc:	fe042783          	lw	a5,-32(s0)
    3500:	2781                	sext.w	a5,a5
    3502:	c79d                	beqz	a5,3530 <concreate+0x82>
    3504:	fec42703          	lw	a4,-20(s0)
    3508:	478d                	li	a5,3
    350a:	02f767bb          	remw	a5,a4,a5
    350e:	2781                	sext.w	a5,a5
    3510:	873e                	mv	a4,a5
    3512:	4785                	li	a5,1
    3514:	00f71e63          	bne	a4,a5,3530 <concreate+0x82>
      link("C0", file);
    3518:	fd840793          	addi	a5,s0,-40
    351c:	85be                	mv	a1,a5
    351e:	00006517          	auipc	a0,0x6
    3522:	ce250513          	addi	a0,a0,-798 # 9200 <schedule_rm+0x1406>
    3526:	00004097          	auipc	ra,0x4
    352a:	bb4080e7          	jalr	-1100(ra) # 70da <link>
    352e:	a059                	j	35b4 <concreate+0x106>
    } else if(pid == 0 && (i % 5) == 1){
    3530:	fe042783          	lw	a5,-32(s0)
    3534:	2781                	sext.w	a5,a5
    3536:	e79d                	bnez	a5,3564 <concreate+0xb6>
    3538:	fec42703          	lw	a4,-20(s0)
    353c:	4795                	li	a5,5
    353e:	02f767bb          	remw	a5,a4,a5
    3542:	2781                	sext.w	a5,a5
    3544:	873e                	mv	a4,a5
    3546:	4785                	li	a5,1
    3548:	00f71e63          	bne	a4,a5,3564 <concreate+0xb6>
      link("C0", file);
    354c:	fd840793          	addi	a5,s0,-40
    3550:	85be                	mv	a1,a5
    3552:	00006517          	auipc	a0,0x6
    3556:	cae50513          	addi	a0,a0,-850 # 9200 <schedule_rm+0x1406>
    355a:	00004097          	auipc	ra,0x4
    355e:	b80080e7          	jalr	-1152(ra) # 70da <link>
    3562:	a889                	j	35b4 <concreate+0x106>
    } else {
      fd = open(file, O_CREATE | O_RDWR);
    3564:	fd840793          	addi	a5,s0,-40
    3568:	20200593          	li	a1,514
    356c:	853e                	mv	a0,a5
    356e:	00004097          	auipc	ra,0x4
    3572:	b4c080e7          	jalr	-1204(ra) # 70ba <open>
    3576:	87aa                	mv	a5,a0
    3578:	fef42223          	sw	a5,-28(s0)
      if(fd < 0){
    357c:	fe442783          	lw	a5,-28(s0)
    3580:	2781                	sext.w	a5,a5
    3582:	0207d263          	bgez	a5,35a6 <concreate+0xf8>
        printf("concreate create %s failed\n", file);
    3586:	fd840793          	addi	a5,s0,-40
    358a:	85be                	mv	a1,a5
    358c:	00006517          	auipc	a0,0x6
    3590:	c7c50513          	addi	a0,a0,-900 # 9208 <schedule_rm+0x140e>
    3594:	00004097          	auipc	ra,0x4
    3598:	02c080e7          	jalr	44(ra) # 75c0 <printf>
        exit(1);
    359c:	4505                	li	a0,1
    359e:	00004097          	auipc	ra,0x4
    35a2:	adc080e7          	jalr	-1316(ra) # 707a <exit>
      }
      close(fd);
    35a6:	fe442783          	lw	a5,-28(s0)
    35aa:	853e                	mv	a0,a5
    35ac:	00004097          	auipc	ra,0x4
    35b0:	af6080e7          	jalr	-1290(ra) # 70a2 <close>
    }
    if(pid == 0) {
    35b4:	fe042783          	lw	a5,-32(s0)
    35b8:	2781                	sext.w	a5,a5
    35ba:	e791                	bnez	a5,35c6 <concreate+0x118>
      exit(0);
    35bc:	4501                	li	a0,0
    35be:	00004097          	auipc	ra,0x4
    35c2:	abc080e7          	jalr	-1348(ra) # 707a <exit>
    } else {
      int xstatus;
      wait(&xstatus);
    35c6:	f9c40793          	addi	a5,s0,-100
    35ca:	853e                	mv	a0,a5
    35cc:	00004097          	auipc	ra,0x4
    35d0:	ab6080e7          	jalr	-1354(ra) # 7082 <wait>
      if(xstatus != 0)
    35d4:	f9c42783          	lw	a5,-100(s0)
    35d8:	c791                	beqz	a5,35e4 <concreate+0x136>
        exit(1);
    35da:	4505                	li	a0,1
    35dc:	00004097          	auipc	ra,0x4
    35e0:	a9e080e7          	jalr	-1378(ra) # 707a <exit>
  for(i = 0; i < N; i++){
    35e4:	fec42783          	lw	a5,-20(s0)
    35e8:	2785                	addiw	a5,a5,1
    35ea:	fef42623          	sw	a5,-20(s0)
    35ee:	fec42783          	lw	a5,-20(s0)
    35f2:	0007871b          	sext.w	a4,a5
    35f6:	02700793          	li	a5,39
    35fa:	ece7d9e3          	bge	a5,a4,34cc <concreate+0x1e>
    }
  }

  memset(fa, 0, sizeof(fa));
    35fe:	fb040793          	addi	a5,s0,-80
    3602:	02800613          	li	a2,40
    3606:	4581                	li	a1,0
    3608:	853e                	mv	a0,a5
    360a:	00003097          	auipc	ra,0x3
    360e:	6c6080e7          	jalr	1734(ra) # 6cd0 <memset>
  fd = open(".", 0);
    3612:	4581                	li	a1,0
    3614:	00006517          	auipc	a0,0x6
    3618:	bc450513          	addi	a0,a0,-1084 # 91d8 <schedule_rm+0x13de>
    361c:	00004097          	auipc	ra,0x4
    3620:	a9e080e7          	jalr	-1378(ra) # 70ba <open>
    3624:	87aa                	mv	a5,a0
    3626:	fef42223          	sw	a5,-28(s0)
  n = 0;
    362a:	fe042423          	sw	zero,-24(s0)
  while(read(fd, &de, sizeof(de)) > 0){
    362e:	a86d                	j	36e8 <concreate+0x23a>
    if(de.inum == 0)
    3630:	fa045783          	lhu	a5,-96(s0)
    3634:	e391                	bnez	a5,3638 <concreate+0x18a>
      continue;
    3636:	a84d                	j	36e8 <concreate+0x23a>
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    3638:	fa244783          	lbu	a5,-94(s0)
    363c:	873e                	mv	a4,a5
    363e:	04300793          	li	a5,67
    3642:	0af71363          	bne	a4,a5,36e8 <concreate+0x23a>
    3646:	fa444783          	lbu	a5,-92(s0)
    364a:	efd9                	bnez	a5,36e8 <concreate+0x23a>
      i = de.name[1] - '0';
    364c:	fa344783          	lbu	a5,-93(s0)
    3650:	2781                	sext.w	a5,a5
    3652:	fd07879b          	addiw	a5,a5,-48
    3656:	fef42623          	sw	a5,-20(s0)
      if(i < 0 || i >= sizeof(fa)){
    365a:	fec42783          	lw	a5,-20(s0)
    365e:	2781                	sext.w	a5,a5
    3660:	0007c963          	bltz	a5,3672 <concreate+0x1c4>
    3664:	fec42783          	lw	a5,-20(s0)
    3668:	873e                	mv	a4,a5
    366a:	02700793          	li	a5,39
    366e:	02e7f563          	bgeu	a5,a4,3698 <concreate+0x1ea>
        printf("%s: concreate weird file %s\n", s, de.name);
    3672:	fa040793          	addi	a5,s0,-96
    3676:	0789                	addi	a5,a5,2
    3678:	863e                	mv	a2,a5
    367a:	f8843583          	ld	a1,-120(s0)
    367e:	00006517          	auipc	a0,0x6
    3682:	baa50513          	addi	a0,a0,-1110 # 9228 <schedule_rm+0x142e>
    3686:	00004097          	auipc	ra,0x4
    368a:	f3a080e7          	jalr	-198(ra) # 75c0 <printf>
        exit(1);
    368e:	4505                	li	a0,1
    3690:	00004097          	auipc	ra,0x4
    3694:	9ea080e7          	jalr	-1558(ra) # 707a <exit>
      }
      if(fa[i]){
    3698:	fec42783          	lw	a5,-20(s0)
    369c:	ff040713          	addi	a4,s0,-16
    36a0:	97ba                	add	a5,a5,a4
    36a2:	fc07c783          	lbu	a5,-64(a5)
    36a6:	c785                	beqz	a5,36ce <concreate+0x220>
        printf("%s: concreate duplicate file %s\n", s, de.name);
    36a8:	fa040793          	addi	a5,s0,-96
    36ac:	0789                	addi	a5,a5,2
    36ae:	863e                	mv	a2,a5
    36b0:	f8843583          	ld	a1,-120(s0)
    36b4:	00006517          	auipc	a0,0x6
    36b8:	b9450513          	addi	a0,a0,-1132 # 9248 <schedule_rm+0x144e>
    36bc:	00004097          	auipc	ra,0x4
    36c0:	f04080e7          	jalr	-252(ra) # 75c0 <printf>
        exit(1);
    36c4:	4505                	li	a0,1
    36c6:	00004097          	auipc	ra,0x4
    36ca:	9b4080e7          	jalr	-1612(ra) # 707a <exit>
      }
      fa[i] = 1;
    36ce:	fec42783          	lw	a5,-20(s0)
    36d2:	ff040713          	addi	a4,s0,-16
    36d6:	97ba                	add	a5,a5,a4
    36d8:	4705                	li	a4,1
    36da:	fce78023          	sb	a4,-64(a5)
      n++;
    36de:	fe842783          	lw	a5,-24(s0)
    36e2:	2785                	addiw	a5,a5,1
    36e4:	fef42423          	sw	a5,-24(s0)
  while(read(fd, &de, sizeof(de)) > 0){
    36e8:	fa040713          	addi	a4,s0,-96
    36ec:	fe442783          	lw	a5,-28(s0)
    36f0:	4641                	li	a2,16
    36f2:	85ba                	mv	a1,a4
    36f4:	853e                	mv	a0,a5
    36f6:	00004097          	auipc	ra,0x4
    36fa:	99c080e7          	jalr	-1636(ra) # 7092 <read>
    36fe:	87aa                	mv	a5,a0
    3700:	f2f048e3          	bgtz	a5,3630 <concreate+0x182>
    }
  }
  close(fd);
    3704:	fe442783          	lw	a5,-28(s0)
    3708:	853e                	mv	a0,a5
    370a:	00004097          	auipc	ra,0x4
    370e:	998080e7          	jalr	-1640(ra) # 70a2 <close>

  if(n != N){
    3712:	fe842783          	lw	a5,-24(s0)
    3716:	0007871b          	sext.w	a4,a5
    371a:	02800793          	li	a5,40
    371e:	02f70163          	beq	a4,a5,3740 <concreate+0x292>
    printf("%s: concreate not enough files in directory listing\n", s);
    3722:	f8843583          	ld	a1,-120(s0)
    3726:	00006517          	auipc	a0,0x6
    372a:	b4a50513          	addi	a0,a0,-1206 # 9270 <schedule_rm+0x1476>
    372e:	00004097          	auipc	ra,0x4
    3732:	e92080e7          	jalr	-366(ra) # 75c0 <printf>
    exit(1);
    3736:	4505                	li	a0,1
    3738:	00004097          	auipc	ra,0x4
    373c:	942080e7          	jalr	-1726(ra) # 707a <exit>
  }

  for(i = 0; i < N; i++){
    3740:	fe042623          	sw	zero,-20(s0)
    3744:	a24d                	j	38e6 <concreate+0x438>
    file[1] = '0' + i;
    3746:	fec42783          	lw	a5,-20(s0)
    374a:	0ff7f793          	andi	a5,a5,255
    374e:	0307879b          	addiw	a5,a5,48
    3752:	0ff7f793          	andi	a5,a5,255
    3756:	fcf40ca3          	sb	a5,-39(s0)
    pid = fork();
    375a:	00004097          	auipc	ra,0x4
    375e:	918080e7          	jalr	-1768(ra) # 7072 <fork>
    3762:	87aa                	mv	a5,a0
    3764:	fef42023          	sw	a5,-32(s0)
    if(pid < 0){
    3768:	fe042783          	lw	a5,-32(s0)
    376c:	2781                	sext.w	a5,a5
    376e:	0207d163          	bgez	a5,3790 <concreate+0x2e2>
      printf("%s: fork failed\n", s);
    3772:	f8843583          	ld	a1,-120(s0)
    3776:	00005517          	auipc	a0,0x5
    377a:	13a50513          	addi	a0,a0,314 # 88b0 <schedule_rm+0xab6>
    377e:	00004097          	auipc	ra,0x4
    3782:	e42080e7          	jalr	-446(ra) # 75c0 <printf>
      exit(1);
    3786:	4505                	li	a0,1
    3788:	00004097          	auipc	ra,0x4
    378c:	8f2080e7          	jalr	-1806(ra) # 707a <exit>
    }
    if(((i % 3) == 0 && pid == 0) ||
    3790:	fec42703          	lw	a4,-20(s0)
    3794:	478d                	li	a5,3
    3796:	02f767bb          	remw	a5,a4,a5
    379a:	2781                	sext.w	a5,a5
    379c:	e789                	bnez	a5,37a6 <concreate+0x2f8>
    379e:	fe042783          	lw	a5,-32(s0)
    37a2:	2781                	sext.w	a5,a5
    37a4:	cf99                	beqz	a5,37c2 <concreate+0x314>
       ((i % 3) == 1 && pid != 0)){
    37a6:	fec42703          	lw	a4,-20(s0)
    37aa:	478d                	li	a5,3
    37ac:	02f767bb          	remw	a5,a4,a5
    37b0:	2781                	sext.w	a5,a5
    if(((i % 3) == 0 && pid == 0) ||
    37b2:	873e                	mv	a4,a5
    37b4:	4785                	li	a5,1
    37b6:	0af71b63          	bne	a4,a5,386c <concreate+0x3be>
       ((i % 3) == 1 && pid != 0)){
    37ba:	fe042783          	lw	a5,-32(s0)
    37be:	2781                	sext.w	a5,a5
    37c0:	c7d5                	beqz	a5,386c <concreate+0x3be>
      close(open(file, 0));
    37c2:	fd840793          	addi	a5,s0,-40
    37c6:	4581                	li	a1,0
    37c8:	853e                	mv	a0,a5
    37ca:	00004097          	auipc	ra,0x4
    37ce:	8f0080e7          	jalr	-1808(ra) # 70ba <open>
    37d2:	87aa                	mv	a5,a0
    37d4:	853e                	mv	a0,a5
    37d6:	00004097          	auipc	ra,0x4
    37da:	8cc080e7          	jalr	-1844(ra) # 70a2 <close>
      close(open(file, 0));
    37de:	fd840793          	addi	a5,s0,-40
    37e2:	4581                	li	a1,0
    37e4:	853e                	mv	a0,a5
    37e6:	00004097          	auipc	ra,0x4
    37ea:	8d4080e7          	jalr	-1836(ra) # 70ba <open>
    37ee:	87aa                	mv	a5,a0
    37f0:	853e                	mv	a0,a5
    37f2:	00004097          	auipc	ra,0x4
    37f6:	8b0080e7          	jalr	-1872(ra) # 70a2 <close>
      close(open(file, 0));
    37fa:	fd840793          	addi	a5,s0,-40
    37fe:	4581                	li	a1,0
    3800:	853e                	mv	a0,a5
    3802:	00004097          	auipc	ra,0x4
    3806:	8b8080e7          	jalr	-1864(ra) # 70ba <open>
    380a:	87aa                	mv	a5,a0
    380c:	853e                	mv	a0,a5
    380e:	00004097          	auipc	ra,0x4
    3812:	894080e7          	jalr	-1900(ra) # 70a2 <close>
      close(open(file, 0));
    3816:	fd840793          	addi	a5,s0,-40
    381a:	4581                	li	a1,0
    381c:	853e                	mv	a0,a5
    381e:	00004097          	auipc	ra,0x4
    3822:	89c080e7          	jalr	-1892(ra) # 70ba <open>
    3826:	87aa                	mv	a5,a0
    3828:	853e                	mv	a0,a5
    382a:	00004097          	auipc	ra,0x4
    382e:	878080e7          	jalr	-1928(ra) # 70a2 <close>
      close(open(file, 0));
    3832:	fd840793          	addi	a5,s0,-40
    3836:	4581                	li	a1,0
    3838:	853e                	mv	a0,a5
    383a:	00004097          	auipc	ra,0x4
    383e:	880080e7          	jalr	-1920(ra) # 70ba <open>
    3842:	87aa                	mv	a5,a0
    3844:	853e                	mv	a0,a5
    3846:	00004097          	auipc	ra,0x4
    384a:	85c080e7          	jalr	-1956(ra) # 70a2 <close>
      close(open(file, 0));
    384e:	fd840793          	addi	a5,s0,-40
    3852:	4581                	li	a1,0
    3854:	853e                	mv	a0,a5
    3856:	00004097          	auipc	ra,0x4
    385a:	864080e7          	jalr	-1948(ra) # 70ba <open>
    385e:	87aa                	mv	a5,a0
    3860:	853e                	mv	a0,a5
    3862:	00004097          	auipc	ra,0x4
    3866:	840080e7          	jalr	-1984(ra) # 70a2 <close>
    386a:	a899                	j	38c0 <concreate+0x412>
    } else {
      unlink(file);
    386c:	fd840793          	addi	a5,s0,-40
    3870:	853e                	mv	a0,a5
    3872:	00004097          	auipc	ra,0x4
    3876:	858080e7          	jalr	-1960(ra) # 70ca <unlink>
      unlink(file);
    387a:	fd840793          	addi	a5,s0,-40
    387e:	853e                	mv	a0,a5
    3880:	00004097          	auipc	ra,0x4
    3884:	84a080e7          	jalr	-1974(ra) # 70ca <unlink>
      unlink(file);
    3888:	fd840793          	addi	a5,s0,-40
    388c:	853e                	mv	a0,a5
    388e:	00004097          	auipc	ra,0x4
    3892:	83c080e7          	jalr	-1988(ra) # 70ca <unlink>
      unlink(file);
    3896:	fd840793          	addi	a5,s0,-40
    389a:	853e                	mv	a0,a5
    389c:	00004097          	auipc	ra,0x4
    38a0:	82e080e7          	jalr	-2002(ra) # 70ca <unlink>
      unlink(file);
    38a4:	fd840793          	addi	a5,s0,-40
    38a8:	853e                	mv	a0,a5
    38aa:	00004097          	auipc	ra,0x4
    38ae:	820080e7          	jalr	-2016(ra) # 70ca <unlink>
      unlink(file);
    38b2:	fd840793          	addi	a5,s0,-40
    38b6:	853e                	mv	a0,a5
    38b8:	00004097          	auipc	ra,0x4
    38bc:	812080e7          	jalr	-2030(ra) # 70ca <unlink>
    }
    if(pid == 0)
    38c0:	fe042783          	lw	a5,-32(s0)
    38c4:	2781                	sext.w	a5,a5
    38c6:	e791                	bnez	a5,38d2 <concreate+0x424>
      exit(0);
    38c8:	4501                	li	a0,0
    38ca:	00003097          	auipc	ra,0x3
    38ce:	7b0080e7          	jalr	1968(ra) # 707a <exit>
    else
      wait(0);
    38d2:	4501                	li	a0,0
    38d4:	00003097          	auipc	ra,0x3
    38d8:	7ae080e7          	jalr	1966(ra) # 7082 <wait>
  for(i = 0; i < N; i++){
    38dc:	fec42783          	lw	a5,-20(s0)
    38e0:	2785                	addiw	a5,a5,1
    38e2:	fef42623          	sw	a5,-20(s0)
    38e6:	fec42783          	lw	a5,-20(s0)
    38ea:	0007871b          	sext.w	a4,a5
    38ee:	02700793          	li	a5,39
    38f2:	e4e7dae3          	bge	a5,a4,3746 <concreate+0x298>
  }
}
    38f6:	0001                	nop
    38f8:	0001                	nop
    38fa:	70e6                	ld	ra,120(sp)
    38fc:	7446                	ld	s0,112(sp)
    38fe:	6109                	addi	sp,sp,128
    3900:	8082                	ret

0000000000003902 <linkunlink>:

// another concurrent link/unlink/create test,
// to look for deadlocks.
void
linkunlink(char *s)
{
    3902:	7179                	addi	sp,sp,-48
    3904:	f406                	sd	ra,40(sp)
    3906:	f022                	sd	s0,32(sp)
    3908:	1800                	addi	s0,sp,48
    390a:	fca43c23          	sd	a0,-40(s0)
  int pid, i;

  unlink("x");
    390e:	00005517          	auipc	a0,0x5
    3912:	c7a50513          	addi	a0,a0,-902 # 8588 <schedule_rm+0x78e>
    3916:	00003097          	auipc	ra,0x3
    391a:	7b4080e7          	jalr	1972(ra) # 70ca <unlink>
  pid = fork();
    391e:	00003097          	auipc	ra,0x3
    3922:	754080e7          	jalr	1876(ra) # 7072 <fork>
    3926:	87aa                	mv	a5,a0
    3928:	fef42223          	sw	a5,-28(s0)
  if(pid < 0){
    392c:	fe442783          	lw	a5,-28(s0)
    3930:	2781                	sext.w	a5,a5
    3932:	0207d163          	bgez	a5,3954 <linkunlink+0x52>
    printf("%s: fork failed\n", s);
    3936:	fd843583          	ld	a1,-40(s0)
    393a:	00005517          	auipc	a0,0x5
    393e:	f7650513          	addi	a0,a0,-138 # 88b0 <schedule_rm+0xab6>
    3942:	00004097          	auipc	ra,0x4
    3946:	c7e080e7          	jalr	-898(ra) # 75c0 <printf>
    exit(1);
    394a:	4505                	li	a0,1
    394c:	00003097          	auipc	ra,0x3
    3950:	72e080e7          	jalr	1838(ra) # 707a <exit>
  }

  unsigned int x = (pid ? 1 : 97);
    3954:	fe442783          	lw	a5,-28(s0)
    3958:	2781                	sext.w	a5,a5
    395a:	c399                	beqz	a5,3960 <linkunlink+0x5e>
    395c:	4785                	li	a5,1
    395e:	a019                	j	3964 <linkunlink+0x62>
    3960:	06100793          	li	a5,97
    3964:	fef42423          	sw	a5,-24(s0)
  for(i = 0; i < 100; i++){
    3968:	fe042623          	sw	zero,-20(s0)
    396c:	a869                	j	3a06 <linkunlink+0x104>
    x = x * 1103515245 + 12345;
    396e:	fe842703          	lw	a4,-24(s0)
    3972:	41c657b7          	lui	a5,0x41c65
    3976:	e6d7879b          	addiw	a5,a5,-403
    397a:	02f707bb          	mulw	a5,a4,a5
    397e:	0007871b          	sext.w	a4,a5
    3982:	678d                	lui	a5,0x3
    3984:	0397879b          	addiw	a5,a5,57
    3988:	9fb9                	addw	a5,a5,a4
    398a:	fef42423          	sw	a5,-24(s0)
    if((x % 3) == 0){
    398e:	fe842703          	lw	a4,-24(s0)
    3992:	478d                	li	a5,3
    3994:	02f777bb          	remuw	a5,a4,a5
    3998:	2781                	sext.w	a5,a5
    399a:	e395                	bnez	a5,39be <linkunlink+0xbc>
      close(open("x", O_RDWR | O_CREATE));
    399c:	20200593          	li	a1,514
    39a0:	00005517          	auipc	a0,0x5
    39a4:	be850513          	addi	a0,a0,-1048 # 8588 <schedule_rm+0x78e>
    39a8:	00003097          	auipc	ra,0x3
    39ac:	712080e7          	jalr	1810(ra) # 70ba <open>
    39b0:	87aa                	mv	a5,a0
    39b2:	853e                	mv	a0,a5
    39b4:	00003097          	auipc	ra,0x3
    39b8:	6ee080e7          	jalr	1774(ra) # 70a2 <close>
    39bc:	a081                	j	39fc <linkunlink+0xfa>
    } else if((x % 3) == 1){
    39be:	fe842703          	lw	a4,-24(s0)
    39c2:	478d                	li	a5,3
    39c4:	02f777bb          	remuw	a5,a4,a5
    39c8:	2781                	sext.w	a5,a5
    39ca:	873e                	mv	a4,a5
    39cc:	4785                	li	a5,1
    39ce:	00f71f63          	bne	a4,a5,39ec <linkunlink+0xea>
      link("cat", "x");
    39d2:	00005597          	auipc	a1,0x5
    39d6:	bb658593          	addi	a1,a1,-1098 # 8588 <schedule_rm+0x78e>
    39da:	00006517          	auipc	a0,0x6
    39de:	8ce50513          	addi	a0,a0,-1842 # 92a8 <schedule_rm+0x14ae>
    39e2:	00003097          	auipc	ra,0x3
    39e6:	6f8080e7          	jalr	1784(ra) # 70da <link>
    39ea:	a809                	j	39fc <linkunlink+0xfa>
    } else {
      unlink("x");
    39ec:	00005517          	auipc	a0,0x5
    39f0:	b9c50513          	addi	a0,a0,-1124 # 8588 <schedule_rm+0x78e>
    39f4:	00003097          	auipc	ra,0x3
    39f8:	6d6080e7          	jalr	1750(ra) # 70ca <unlink>
  for(i = 0; i < 100; i++){
    39fc:	fec42783          	lw	a5,-20(s0)
    3a00:	2785                	addiw	a5,a5,1
    3a02:	fef42623          	sw	a5,-20(s0)
    3a06:	fec42783          	lw	a5,-20(s0)
    3a0a:	0007871b          	sext.w	a4,a5
    3a0e:	06300793          	li	a5,99
    3a12:	f4e7dee3          	bge	a5,a4,396e <linkunlink+0x6c>
    }
  }

  if(pid)
    3a16:	fe442783          	lw	a5,-28(s0)
    3a1a:	2781                	sext.w	a5,a5
    3a1c:	c799                	beqz	a5,3a2a <linkunlink+0x128>
    wait(0);
    3a1e:	4501                	li	a0,0
    3a20:	00003097          	auipc	ra,0x3
    3a24:	662080e7          	jalr	1634(ra) # 7082 <wait>
  else
    exit(0);
}
    3a28:	a031                	j	3a34 <linkunlink+0x132>
    exit(0);
    3a2a:	4501                	li	a0,0
    3a2c:	00003097          	auipc	ra,0x3
    3a30:	64e080e7          	jalr	1614(ra) # 707a <exit>
}
    3a34:	70a2                	ld	ra,40(sp)
    3a36:	7402                	ld	s0,32(sp)
    3a38:	6145                	addi	sp,sp,48
    3a3a:	8082                	ret

0000000000003a3c <bigdir>:

// directory that uses indirect blocks
void
bigdir(char *s)
{
    3a3c:	7139                	addi	sp,sp,-64
    3a3e:	fc06                	sd	ra,56(sp)
    3a40:	f822                	sd	s0,48(sp)
    3a42:	0080                	addi	s0,sp,64
    3a44:	fca43423          	sd	a0,-56(s0)
  enum { N = 500 };
  int i, fd;
  char name[10];

  unlink("bd");
    3a48:	00006517          	auipc	a0,0x6
    3a4c:	86850513          	addi	a0,a0,-1944 # 92b0 <schedule_rm+0x14b6>
    3a50:	00003097          	auipc	ra,0x3
    3a54:	67a080e7          	jalr	1658(ra) # 70ca <unlink>

  fd = open("bd", O_CREATE);
    3a58:	20000593          	li	a1,512
    3a5c:	00006517          	auipc	a0,0x6
    3a60:	85450513          	addi	a0,a0,-1964 # 92b0 <schedule_rm+0x14b6>
    3a64:	00003097          	auipc	ra,0x3
    3a68:	656080e7          	jalr	1622(ra) # 70ba <open>
    3a6c:	87aa                	mv	a5,a0
    3a6e:	fef42423          	sw	a5,-24(s0)
  if(fd < 0){
    3a72:	fe842783          	lw	a5,-24(s0)
    3a76:	2781                	sext.w	a5,a5
    3a78:	0207d163          	bgez	a5,3a9a <bigdir+0x5e>
    printf("%s: bigdir create failed\n", s);
    3a7c:	fc843583          	ld	a1,-56(s0)
    3a80:	00006517          	auipc	a0,0x6
    3a84:	83850513          	addi	a0,a0,-1992 # 92b8 <schedule_rm+0x14be>
    3a88:	00004097          	auipc	ra,0x4
    3a8c:	b38080e7          	jalr	-1224(ra) # 75c0 <printf>
    exit(1);
    3a90:	4505                	li	a0,1
    3a92:	00003097          	auipc	ra,0x3
    3a96:	5e8080e7          	jalr	1512(ra) # 707a <exit>
  }
  close(fd);
    3a9a:	fe842783          	lw	a5,-24(s0)
    3a9e:	853e                	mv	a0,a5
    3aa0:	00003097          	auipc	ra,0x3
    3aa4:	602080e7          	jalr	1538(ra) # 70a2 <close>

  for(i = 0; i < N; i++){
    3aa8:	fe042623          	sw	zero,-20(s0)
    3aac:	a04d                	j	3b4e <bigdir+0x112>
    name[0] = 'x';
    3aae:	07800793          	li	a5,120
    3ab2:	fcf40c23          	sb	a5,-40(s0)
    name[1] = '0' + (i / 64);
    3ab6:	fec42783          	lw	a5,-20(s0)
    3aba:	41f7d71b          	sraiw	a4,a5,0x1f
    3abe:	01a7571b          	srliw	a4,a4,0x1a
    3ac2:	9fb9                	addw	a5,a5,a4
    3ac4:	4067d79b          	sraiw	a5,a5,0x6
    3ac8:	2781                	sext.w	a5,a5
    3aca:	0ff7f793          	andi	a5,a5,255
    3ace:	0307879b          	addiw	a5,a5,48
    3ad2:	0ff7f793          	andi	a5,a5,255
    3ad6:	fcf40ca3          	sb	a5,-39(s0)
    name[2] = '0' + (i % 64);
    3ada:	fec42703          	lw	a4,-20(s0)
    3ade:	41f7579b          	sraiw	a5,a4,0x1f
    3ae2:	01a7d79b          	srliw	a5,a5,0x1a
    3ae6:	9f3d                	addw	a4,a4,a5
    3ae8:	03f77713          	andi	a4,a4,63
    3aec:	40f707bb          	subw	a5,a4,a5
    3af0:	2781                	sext.w	a5,a5
    3af2:	0ff7f793          	andi	a5,a5,255
    3af6:	0307879b          	addiw	a5,a5,48
    3afa:	0ff7f793          	andi	a5,a5,255
    3afe:	fcf40d23          	sb	a5,-38(s0)
    name[3] = '\0';
    3b02:	fc040da3          	sb	zero,-37(s0)
    if(link("bd", name) != 0){
    3b06:	fd840793          	addi	a5,s0,-40
    3b0a:	85be                	mv	a1,a5
    3b0c:	00005517          	auipc	a0,0x5
    3b10:	7a450513          	addi	a0,a0,1956 # 92b0 <schedule_rm+0x14b6>
    3b14:	00003097          	auipc	ra,0x3
    3b18:	5c6080e7          	jalr	1478(ra) # 70da <link>
    3b1c:	87aa                	mv	a5,a0
    3b1e:	c39d                	beqz	a5,3b44 <bigdir+0x108>
      printf("%s: bigdir link(bd, %s) failed\n", s, name);
    3b20:	fd840793          	addi	a5,s0,-40
    3b24:	863e                	mv	a2,a5
    3b26:	fc843583          	ld	a1,-56(s0)
    3b2a:	00005517          	auipc	a0,0x5
    3b2e:	7ae50513          	addi	a0,a0,1966 # 92d8 <schedule_rm+0x14de>
    3b32:	00004097          	auipc	ra,0x4
    3b36:	a8e080e7          	jalr	-1394(ra) # 75c0 <printf>
      exit(1);
    3b3a:	4505                	li	a0,1
    3b3c:	00003097          	auipc	ra,0x3
    3b40:	53e080e7          	jalr	1342(ra) # 707a <exit>
  for(i = 0; i < N; i++){
    3b44:	fec42783          	lw	a5,-20(s0)
    3b48:	2785                	addiw	a5,a5,1
    3b4a:	fef42623          	sw	a5,-20(s0)
    3b4e:	fec42783          	lw	a5,-20(s0)
    3b52:	0007871b          	sext.w	a4,a5
    3b56:	1f300793          	li	a5,499
    3b5a:	f4e7dae3          	bge	a5,a4,3aae <bigdir+0x72>
    }
  }

  unlink("bd");
    3b5e:	00005517          	auipc	a0,0x5
    3b62:	75250513          	addi	a0,a0,1874 # 92b0 <schedule_rm+0x14b6>
    3b66:	00003097          	auipc	ra,0x3
    3b6a:	564080e7          	jalr	1380(ra) # 70ca <unlink>
  for(i = 0; i < N; i++){
    3b6e:	fe042623          	sw	zero,-20(s0)
    3b72:	a851                	j	3c06 <bigdir+0x1ca>
    name[0] = 'x';
    3b74:	07800793          	li	a5,120
    3b78:	fcf40c23          	sb	a5,-40(s0)
    name[1] = '0' + (i / 64);
    3b7c:	fec42783          	lw	a5,-20(s0)
    3b80:	41f7d71b          	sraiw	a4,a5,0x1f
    3b84:	01a7571b          	srliw	a4,a4,0x1a
    3b88:	9fb9                	addw	a5,a5,a4
    3b8a:	4067d79b          	sraiw	a5,a5,0x6
    3b8e:	2781                	sext.w	a5,a5
    3b90:	0ff7f793          	andi	a5,a5,255
    3b94:	0307879b          	addiw	a5,a5,48
    3b98:	0ff7f793          	andi	a5,a5,255
    3b9c:	fcf40ca3          	sb	a5,-39(s0)
    name[2] = '0' + (i % 64);
    3ba0:	fec42703          	lw	a4,-20(s0)
    3ba4:	41f7579b          	sraiw	a5,a4,0x1f
    3ba8:	01a7d79b          	srliw	a5,a5,0x1a
    3bac:	9f3d                	addw	a4,a4,a5
    3bae:	03f77713          	andi	a4,a4,63
    3bb2:	40f707bb          	subw	a5,a4,a5
    3bb6:	2781                	sext.w	a5,a5
    3bb8:	0ff7f793          	andi	a5,a5,255
    3bbc:	0307879b          	addiw	a5,a5,48
    3bc0:	0ff7f793          	andi	a5,a5,255
    3bc4:	fcf40d23          	sb	a5,-38(s0)
    name[3] = '\0';
    3bc8:	fc040da3          	sb	zero,-37(s0)
    if(unlink(name) != 0){
    3bcc:	fd840793          	addi	a5,s0,-40
    3bd0:	853e                	mv	a0,a5
    3bd2:	00003097          	auipc	ra,0x3
    3bd6:	4f8080e7          	jalr	1272(ra) # 70ca <unlink>
    3bda:	87aa                	mv	a5,a0
    3bdc:	c385                	beqz	a5,3bfc <bigdir+0x1c0>
      printf("%s: bigdir unlink failed", s);
    3bde:	fc843583          	ld	a1,-56(s0)
    3be2:	00005517          	auipc	a0,0x5
    3be6:	71650513          	addi	a0,a0,1814 # 92f8 <schedule_rm+0x14fe>
    3bea:	00004097          	auipc	ra,0x4
    3bee:	9d6080e7          	jalr	-1578(ra) # 75c0 <printf>
      exit(1);
    3bf2:	4505                	li	a0,1
    3bf4:	00003097          	auipc	ra,0x3
    3bf8:	486080e7          	jalr	1158(ra) # 707a <exit>
  for(i = 0; i < N; i++){
    3bfc:	fec42783          	lw	a5,-20(s0)
    3c00:	2785                	addiw	a5,a5,1
    3c02:	fef42623          	sw	a5,-20(s0)
    3c06:	fec42783          	lw	a5,-20(s0)
    3c0a:	0007871b          	sext.w	a4,a5
    3c0e:	1f300793          	li	a5,499
    3c12:	f6e7d1e3          	bge	a5,a4,3b74 <bigdir+0x138>
    }
  }
}
    3c16:	0001                	nop
    3c18:	0001                	nop
    3c1a:	70e2                	ld	ra,56(sp)
    3c1c:	7442                	ld	s0,48(sp)
    3c1e:	6121                	addi	sp,sp,64
    3c20:	8082                	ret

0000000000003c22 <subdir>:

void
subdir(char *s)
{
    3c22:	7179                	addi	sp,sp,-48
    3c24:	f406                	sd	ra,40(sp)
    3c26:	f022                	sd	s0,32(sp)
    3c28:	1800                	addi	s0,sp,48
    3c2a:	fca43c23          	sd	a0,-40(s0)
  int fd, cc;

  unlink("ff");
    3c2e:	00005517          	auipc	a0,0x5
    3c32:	6ea50513          	addi	a0,a0,1770 # 9318 <schedule_rm+0x151e>
    3c36:	00003097          	auipc	ra,0x3
    3c3a:	494080e7          	jalr	1172(ra) # 70ca <unlink>
  if(mkdir("dd") != 0){
    3c3e:	00005517          	auipc	a0,0x5
    3c42:	6e250513          	addi	a0,a0,1762 # 9320 <schedule_rm+0x1526>
    3c46:	00003097          	auipc	ra,0x3
    3c4a:	49c080e7          	jalr	1180(ra) # 70e2 <mkdir>
    3c4e:	87aa                	mv	a5,a0
    3c50:	c385                	beqz	a5,3c70 <subdir+0x4e>
    printf("%s: mkdir dd failed\n", s);
    3c52:	fd843583          	ld	a1,-40(s0)
    3c56:	00005517          	auipc	a0,0x5
    3c5a:	6d250513          	addi	a0,a0,1746 # 9328 <schedule_rm+0x152e>
    3c5e:	00004097          	auipc	ra,0x4
    3c62:	962080e7          	jalr	-1694(ra) # 75c0 <printf>
    exit(1);
    3c66:	4505                	li	a0,1
    3c68:	00003097          	auipc	ra,0x3
    3c6c:	412080e7          	jalr	1042(ra) # 707a <exit>
  }

  fd = open("dd/ff", O_CREATE | O_RDWR);
    3c70:	20200593          	li	a1,514
    3c74:	00005517          	auipc	a0,0x5
    3c78:	6cc50513          	addi	a0,a0,1740 # 9340 <schedule_rm+0x1546>
    3c7c:	00003097          	auipc	ra,0x3
    3c80:	43e080e7          	jalr	1086(ra) # 70ba <open>
    3c84:	87aa                	mv	a5,a0
    3c86:	fef42623          	sw	a5,-20(s0)
  if(fd < 0){
    3c8a:	fec42783          	lw	a5,-20(s0)
    3c8e:	2781                	sext.w	a5,a5
    3c90:	0207d163          	bgez	a5,3cb2 <subdir+0x90>
    printf("%s: create dd/ff failed\n", s);
    3c94:	fd843583          	ld	a1,-40(s0)
    3c98:	00005517          	auipc	a0,0x5
    3c9c:	6b050513          	addi	a0,a0,1712 # 9348 <schedule_rm+0x154e>
    3ca0:	00004097          	auipc	ra,0x4
    3ca4:	920080e7          	jalr	-1760(ra) # 75c0 <printf>
    exit(1);
    3ca8:	4505                	li	a0,1
    3caa:	00003097          	auipc	ra,0x3
    3cae:	3d0080e7          	jalr	976(ra) # 707a <exit>
  }
  write(fd, "ff", 2);
    3cb2:	fec42783          	lw	a5,-20(s0)
    3cb6:	4609                	li	a2,2
    3cb8:	00005597          	auipc	a1,0x5
    3cbc:	66058593          	addi	a1,a1,1632 # 9318 <schedule_rm+0x151e>
    3cc0:	853e                	mv	a0,a5
    3cc2:	00003097          	auipc	ra,0x3
    3cc6:	3d8080e7          	jalr	984(ra) # 709a <write>
  close(fd);
    3cca:	fec42783          	lw	a5,-20(s0)
    3cce:	853e                	mv	a0,a5
    3cd0:	00003097          	auipc	ra,0x3
    3cd4:	3d2080e7          	jalr	978(ra) # 70a2 <close>

  if(unlink("dd") >= 0){
    3cd8:	00005517          	auipc	a0,0x5
    3cdc:	64850513          	addi	a0,a0,1608 # 9320 <schedule_rm+0x1526>
    3ce0:	00003097          	auipc	ra,0x3
    3ce4:	3ea080e7          	jalr	1002(ra) # 70ca <unlink>
    3ce8:	87aa                	mv	a5,a0
    3cea:	0207c163          	bltz	a5,3d0c <subdir+0xea>
    printf("%s: unlink dd (non-empty dir) succeeded!\n", s);
    3cee:	fd843583          	ld	a1,-40(s0)
    3cf2:	00005517          	auipc	a0,0x5
    3cf6:	67650513          	addi	a0,a0,1654 # 9368 <schedule_rm+0x156e>
    3cfa:	00004097          	auipc	ra,0x4
    3cfe:	8c6080e7          	jalr	-1850(ra) # 75c0 <printf>
    exit(1);
    3d02:	4505                	li	a0,1
    3d04:	00003097          	auipc	ra,0x3
    3d08:	376080e7          	jalr	886(ra) # 707a <exit>
  }

  if(mkdir("/dd/dd") != 0){
    3d0c:	00005517          	auipc	a0,0x5
    3d10:	68c50513          	addi	a0,a0,1676 # 9398 <schedule_rm+0x159e>
    3d14:	00003097          	auipc	ra,0x3
    3d18:	3ce080e7          	jalr	974(ra) # 70e2 <mkdir>
    3d1c:	87aa                	mv	a5,a0
    3d1e:	c385                	beqz	a5,3d3e <subdir+0x11c>
    printf("subdir mkdir dd/dd failed\n", s);
    3d20:	fd843583          	ld	a1,-40(s0)
    3d24:	00005517          	auipc	a0,0x5
    3d28:	67c50513          	addi	a0,a0,1660 # 93a0 <schedule_rm+0x15a6>
    3d2c:	00004097          	auipc	ra,0x4
    3d30:	894080e7          	jalr	-1900(ra) # 75c0 <printf>
    exit(1);
    3d34:	4505                	li	a0,1
    3d36:	00003097          	auipc	ra,0x3
    3d3a:	344080e7          	jalr	836(ra) # 707a <exit>
  }

  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    3d3e:	20200593          	li	a1,514
    3d42:	00005517          	auipc	a0,0x5
    3d46:	67e50513          	addi	a0,a0,1662 # 93c0 <schedule_rm+0x15c6>
    3d4a:	00003097          	auipc	ra,0x3
    3d4e:	370080e7          	jalr	880(ra) # 70ba <open>
    3d52:	87aa                	mv	a5,a0
    3d54:	fef42623          	sw	a5,-20(s0)
  if(fd < 0){
    3d58:	fec42783          	lw	a5,-20(s0)
    3d5c:	2781                	sext.w	a5,a5
    3d5e:	0207d163          	bgez	a5,3d80 <subdir+0x15e>
    printf("%s: create dd/dd/ff failed\n", s);
    3d62:	fd843583          	ld	a1,-40(s0)
    3d66:	00005517          	auipc	a0,0x5
    3d6a:	66a50513          	addi	a0,a0,1642 # 93d0 <schedule_rm+0x15d6>
    3d6e:	00004097          	auipc	ra,0x4
    3d72:	852080e7          	jalr	-1966(ra) # 75c0 <printf>
    exit(1);
    3d76:	4505                	li	a0,1
    3d78:	00003097          	auipc	ra,0x3
    3d7c:	302080e7          	jalr	770(ra) # 707a <exit>
  }
  write(fd, "FF", 2);
    3d80:	fec42783          	lw	a5,-20(s0)
    3d84:	4609                	li	a2,2
    3d86:	00005597          	auipc	a1,0x5
    3d8a:	66a58593          	addi	a1,a1,1642 # 93f0 <schedule_rm+0x15f6>
    3d8e:	853e                	mv	a0,a5
    3d90:	00003097          	auipc	ra,0x3
    3d94:	30a080e7          	jalr	778(ra) # 709a <write>
  close(fd);
    3d98:	fec42783          	lw	a5,-20(s0)
    3d9c:	853e                	mv	a0,a5
    3d9e:	00003097          	auipc	ra,0x3
    3da2:	304080e7          	jalr	772(ra) # 70a2 <close>

  fd = open("dd/dd/../ff", 0);
    3da6:	4581                	li	a1,0
    3da8:	00005517          	auipc	a0,0x5
    3dac:	65050513          	addi	a0,a0,1616 # 93f8 <schedule_rm+0x15fe>
    3db0:	00003097          	auipc	ra,0x3
    3db4:	30a080e7          	jalr	778(ra) # 70ba <open>
    3db8:	87aa                	mv	a5,a0
    3dba:	fef42623          	sw	a5,-20(s0)
  if(fd < 0){
    3dbe:	fec42783          	lw	a5,-20(s0)
    3dc2:	2781                	sext.w	a5,a5
    3dc4:	0207d163          	bgez	a5,3de6 <subdir+0x1c4>
    printf("%s: open dd/dd/../ff failed\n", s);
    3dc8:	fd843583          	ld	a1,-40(s0)
    3dcc:	00005517          	auipc	a0,0x5
    3dd0:	63c50513          	addi	a0,a0,1596 # 9408 <schedule_rm+0x160e>
    3dd4:	00003097          	auipc	ra,0x3
    3dd8:	7ec080e7          	jalr	2028(ra) # 75c0 <printf>
    exit(1);
    3ddc:	4505                	li	a0,1
    3dde:	00003097          	auipc	ra,0x3
    3de2:	29c080e7          	jalr	668(ra) # 707a <exit>
  }
  cc = read(fd, buf, sizeof(buf));
    3de6:	fec42783          	lw	a5,-20(s0)
    3dea:	660d                	lui	a2,0x3
    3dec:	00007597          	auipc	a1,0x7
    3df0:	b1458593          	addi	a1,a1,-1260 # a900 <buf>
    3df4:	853e                	mv	a0,a5
    3df6:	00003097          	auipc	ra,0x3
    3dfa:	29c080e7          	jalr	668(ra) # 7092 <read>
    3dfe:	87aa                	mv	a5,a0
    3e00:	fef42423          	sw	a5,-24(s0)
  if(cc != 2 || buf[0] != 'f'){
    3e04:	fe842783          	lw	a5,-24(s0)
    3e08:	0007871b          	sext.w	a4,a5
    3e0c:	4789                	li	a5,2
    3e0e:	00f71d63          	bne	a4,a5,3e28 <subdir+0x206>
    3e12:	00007797          	auipc	a5,0x7
    3e16:	aee78793          	addi	a5,a5,-1298 # a900 <buf>
    3e1a:	0007c783          	lbu	a5,0(a5)
    3e1e:	873e                	mv	a4,a5
    3e20:	06600793          	li	a5,102
    3e24:	02f70163          	beq	a4,a5,3e46 <subdir+0x224>
    printf("%s: dd/dd/../ff wrong content\n", s);
    3e28:	fd843583          	ld	a1,-40(s0)
    3e2c:	00005517          	auipc	a0,0x5
    3e30:	5fc50513          	addi	a0,a0,1532 # 9428 <schedule_rm+0x162e>
    3e34:	00003097          	auipc	ra,0x3
    3e38:	78c080e7          	jalr	1932(ra) # 75c0 <printf>
    exit(1);
    3e3c:	4505                	li	a0,1
    3e3e:	00003097          	auipc	ra,0x3
    3e42:	23c080e7          	jalr	572(ra) # 707a <exit>
  }
  close(fd);
    3e46:	fec42783          	lw	a5,-20(s0)
    3e4a:	853e                	mv	a0,a5
    3e4c:	00003097          	auipc	ra,0x3
    3e50:	256080e7          	jalr	598(ra) # 70a2 <close>

  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    3e54:	00005597          	auipc	a1,0x5
    3e58:	5f458593          	addi	a1,a1,1524 # 9448 <schedule_rm+0x164e>
    3e5c:	00005517          	auipc	a0,0x5
    3e60:	56450513          	addi	a0,a0,1380 # 93c0 <schedule_rm+0x15c6>
    3e64:	00003097          	auipc	ra,0x3
    3e68:	276080e7          	jalr	630(ra) # 70da <link>
    3e6c:	87aa                	mv	a5,a0
    3e6e:	c385                	beqz	a5,3e8e <subdir+0x26c>
    printf("link dd/dd/ff dd/dd/ffff failed\n", s);
    3e70:	fd843583          	ld	a1,-40(s0)
    3e74:	00005517          	auipc	a0,0x5
    3e78:	5e450513          	addi	a0,a0,1508 # 9458 <schedule_rm+0x165e>
    3e7c:	00003097          	auipc	ra,0x3
    3e80:	744080e7          	jalr	1860(ra) # 75c0 <printf>
    exit(1);
    3e84:	4505                	li	a0,1
    3e86:	00003097          	auipc	ra,0x3
    3e8a:	1f4080e7          	jalr	500(ra) # 707a <exit>
  }

  if(unlink("dd/dd/ff") != 0){
    3e8e:	00005517          	auipc	a0,0x5
    3e92:	53250513          	addi	a0,a0,1330 # 93c0 <schedule_rm+0x15c6>
    3e96:	00003097          	auipc	ra,0x3
    3e9a:	234080e7          	jalr	564(ra) # 70ca <unlink>
    3e9e:	87aa                	mv	a5,a0
    3ea0:	c385                	beqz	a5,3ec0 <subdir+0x29e>
    printf("%s: unlink dd/dd/ff failed\n", s);
    3ea2:	fd843583          	ld	a1,-40(s0)
    3ea6:	00005517          	auipc	a0,0x5
    3eaa:	5da50513          	addi	a0,a0,1498 # 9480 <schedule_rm+0x1686>
    3eae:	00003097          	auipc	ra,0x3
    3eb2:	712080e7          	jalr	1810(ra) # 75c0 <printf>
    exit(1);
    3eb6:	4505                	li	a0,1
    3eb8:	00003097          	auipc	ra,0x3
    3ebc:	1c2080e7          	jalr	450(ra) # 707a <exit>
  }
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    3ec0:	4581                	li	a1,0
    3ec2:	00005517          	auipc	a0,0x5
    3ec6:	4fe50513          	addi	a0,a0,1278 # 93c0 <schedule_rm+0x15c6>
    3eca:	00003097          	auipc	ra,0x3
    3ece:	1f0080e7          	jalr	496(ra) # 70ba <open>
    3ed2:	87aa                	mv	a5,a0
    3ed4:	0207c163          	bltz	a5,3ef6 <subdir+0x2d4>
    printf("%s: open (unlinked) dd/dd/ff succeeded\n", s);
    3ed8:	fd843583          	ld	a1,-40(s0)
    3edc:	00005517          	auipc	a0,0x5
    3ee0:	5c450513          	addi	a0,a0,1476 # 94a0 <schedule_rm+0x16a6>
    3ee4:	00003097          	auipc	ra,0x3
    3ee8:	6dc080e7          	jalr	1756(ra) # 75c0 <printf>
    exit(1);
    3eec:	4505                	li	a0,1
    3eee:	00003097          	auipc	ra,0x3
    3ef2:	18c080e7          	jalr	396(ra) # 707a <exit>
  }

  if(chdir("dd") != 0){
    3ef6:	00005517          	auipc	a0,0x5
    3efa:	42a50513          	addi	a0,a0,1066 # 9320 <schedule_rm+0x1526>
    3efe:	00003097          	auipc	ra,0x3
    3f02:	1ec080e7          	jalr	492(ra) # 70ea <chdir>
    3f06:	87aa                	mv	a5,a0
    3f08:	c385                	beqz	a5,3f28 <subdir+0x306>
    printf("%s: chdir dd failed\n", s);
    3f0a:	fd843583          	ld	a1,-40(s0)
    3f0e:	00005517          	auipc	a0,0x5
    3f12:	5ba50513          	addi	a0,a0,1466 # 94c8 <schedule_rm+0x16ce>
    3f16:	00003097          	auipc	ra,0x3
    3f1a:	6aa080e7          	jalr	1706(ra) # 75c0 <printf>
    exit(1);
    3f1e:	4505                	li	a0,1
    3f20:	00003097          	auipc	ra,0x3
    3f24:	15a080e7          	jalr	346(ra) # 707a <exit>
  }
  if(chdir("dd/../../dd") != 0){
    3f28:	00005517          	auipc	a0,0x5
    3f2c:	5b850513          	addi	a0,a0,1464 # 94e0 <schedule_rm+0x16e6>
    3f30:	00003097          	auipc	ra,0x3
    3f34:	1ba080e7          	jalr	442(ra) # 70ea <chdir>
    3f38:	87aa                	mv	a5,a0
    3f3a:	c385                	beqz	a5,3f5a <subdir+0x338>
    printf("%s: chdir dd/../../dd failed\n", s);
    3f3c:	fd843583          	ld	a1,-40(s0)
    3f40:	00005517          	auipc	a0,0x5
    3f44:	5b050513          	addi	a0,a0,1456 # 94f0 <schedule_rm+0x16f6>
    3f48:	00003097          	auipc	ra,0x3
    3f4c:	678080e7          	jalr	1656(ra) # 75c0 <printf>
    exit(1);
    3f50:	4505                	li	a0,1
    3f52:	00003097          	auipc	ra,0x3
    3f56:	128080e7          	jalr	296(ra) # 707a <exit>
  }
  if(chdir("dd/../../../dd") != 0){
    3f5a:	00005517          	auipc	a0,0x5
    3f5e:	5b650513          	addi	a0,a0,1462 # 9510 <schedule_rm+0x1716>
    3f62:	00003097          	auipc	ra,0x3
    3f66:	188080e7          	jalr	392(ra) # 70ea <chdir>
    3f6a:	87aa                	mv	a5,a0
    3f6c:	c385                	beqz	a5,3f8c <subdir+0x36a>
    printf("chdir dd/../../dd failed\n", s);
    3f6e:	fd843583          	ld	a1,-40(s0)
    3f72:	00005517          	auipc	a0,0x5
    3f76:	5ae50513          	addi	a0,a0,1454 # 9520 <schedule_rm+0x1726>
    3f7a:	00003097          	auipc	ra,0x3
    3f7e:	646080e7          	jalr	1606(ra) # 75c0 <printf>
    exit(1);
    3f82:	4505                	li	a0,1
    3f84:	00003097          	auipc	ra,0x3
    3f88:	0f6080e7          	jalr	246(ra) # 707a <exit>
  }
  if(chdir("./..") != 0){
    3f8c:	00005517          	auipc	a0,0x5
    3f90:	5b450513          	addi	a0,a0,1460 # 9540 <schedule_rm+0x1746>
    3f94:	00003097          	auipc	ra,0x3
    3f98:	156080e7          	jalr	342(ra) # 70ea <chdir>
    3f9c:	87aa                	mv	a5,a0
    3f9e:	c385                	beqz	a5,3fbe <subdir+0x39c>
    printf("%s: chdir ./.. failed\n", s);
    3fa0:	fd843583          	ld	a1,-40(s0)
    3fa4:	00005517          	auipc	a0,0x5
    3fa8:	5a450513          	addi	a0,a0,1444 # 9548 <schedule_rm+0x174e>
    3fac:	00003097          	auipc	ra,0x3
    3fb0:	614080e7          	jalr	1556(ra) # 75c0 <printf>
    exit(1);
    3fb4:	4505                	li	a0,1
    3fb6:	00003097          	auipc	ra,0x3
    3fba:	0c4080e7          	jalr	196(ra) # 707a <exit>
  }

  fd = open("dd/dd/ffff", 0);
    3fbe:	4581                	li	a1,0
    3fc0:	00005517          	auipc	a0,0x5
    3fc4:	48850513          	addi	a0,a0,1160 # 9448 <schedule_rm+0x164e>
    3fc8:	00003097          	auipc	ra,0x3
    3fcc:	0f2080e7          	jalr	242(ra) # 70ba <open>
    3fd0:	87aa                	mv	a5,a0
    3fd2:	fef42623          	sw	a5,-20(s0)
  if(fd < 0){
    3fd6:	fec42783          	lw	a5,-20(s0)
    3fda:	2781                	sext.w	a5,a5
    3fdc:	0207d163          	bgez	a5,3ffe <subdir+0x3dc>
    printf("%s: open dd/dd/ffff failed\n", s);
    3fe0:	fd843583          	ld	a1,-40(s0)
    3fe4:	00005517          	auipc	a0,0x5
    3fe8:	57c50513          	addi	a0,a0,1404 # 9560 <schedule_rm+0x1766>
    3fec:	00003097          	auipc	ra,0x3
    3ff0:	5d4080e7          	jalr	1492(ra) # 75c0 <printf>
    exit(1);
    3ff4:	4505                	li	a0,1
    3ff6:	00003097          	auipc	ra,0x3
    3ffa:	084080e7          	jalr	132(ra) # 707a <exit>
  }
  if(read(fd, buf, sizeof(buf)) != 2){
    3ffe:	fec42783          	lw	a5,-20(s0)
    4002:	660d                	lui	a2,0x3
    4004:	00007597          	auipc	a1,0x7
    4008:	8fc58593          	addi	a1,a1,-1796 # a900 <buf>
    400c:	853e                	mv	a0,a5
    400e:	00003097          	auipc	ra,0x3
    4012:	084080e7          	jalr	132(ra) # 7092 <read>
    4016:	87aa                	mv	a5,a0
    4018:	873e                	mv	a4,a5
    401a:	4789                	li	a5,2
    401c:	02f70163          	beq	a4,a5,403e <subdir+0x41c>
    printf("%s: read dd/dd/ffff wrong len\n", s);
    4020:	fd843583          	ld	a1,-40(s0)
    4024:	00005517          	auipc	a0,0x5
    4028:	55c50513          	addi	a0,a0,1372 # 9580 <schedule_rm+0x1786>
    402c:	00003097          	auipc	ra,0x3
    4030:	594080e7          	jalr	1428(ra) # 75c0 <printf>
    exit(1);
    4034:	4505                	li	a0,1
    4036:	00003097          	auipc	ra,0x3
    403a:	044080e7          	jalr	68(ra) # 707a <exit>
  }
  close(fd);
    403e:	fec42783          	lw	a5,-20(s0)
    4042:	853e                	mv	a0,a5
    4044:	00003097          	auipc	ra,0x3
    4048:	05e080e7          	jalr	94(ra) # 70a2 <close>

  if(open("dd/dd/ff", O_RDONLY) >= 0){
    404c:	4581                	li	a1,0
    404e:	00005517          	auipc	a0,0x5
    4052:	37250513          	addi	a0,a0,882 # 93c0 <schedule_rm+0x15c6>
    4056:	00003097          	auipc	ra,0x3
    405a:	064080e7          	jalr	100(ra) # 70ba <open>
    405e:	87aa                	mv	a5,a0
    4060:	0207c163          	bltz	a5,4082 <subdir+0x460>
    printf("%s: open (unlinked) dd/dd/ff succeeded!\n", s);
    4064:	fd843583          	ld	a1,-40(s0)
    4068:	00005517          	auipc	a0,0x5
    406c:	53850513          	addi	a0,a0,1336 # 95a0 <schedule_rm+0x17a6>
    4070:	00003097          	auipc	ra,0x3
    4074:	550080e7          	jalr	1360(ra) # 75c0 <printf>
    exit(1);
    4078:	4505                	li	a0,1
    407a:	00003097          	auipc	ra,0x3
    407e:	000080e7          	jalr	ra # 707a <exit>
  }

  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    4082:	20200593          	li	a1,514
    4086:	00005517          	auipc	a0,0x5
    408a:	54a50513          	addi	a0,a0,1354 # 95d0 <schedule_rm+0x17d6>
    408e:	00003097          	auipc	ra,0x3
    4092:	02c080e7          	jalr	44(ra) # 70ba <open>
    4096:	87aa                	mv	a5,a0
    4098:	0207c163          	bltz	a5,40ba <subdir+0x498>
    printf("%s: create dd/ff/ff succeeded!\n", s);
    409c:	fd843583          	ld	a1,-40(s0)
    40a0:	00005517          	auipc	a0,0x5
    40a4:	54050513          	addi	a0,a0,1344 # 95e0 <schedule_rm+0x17e6>
    40a8:	00003097          	auipc	ra,0x3
    40ac:	518080e7          	jalr	1304(ra) # 75c0 <printf>
    exit(1);
    40b0:	4505                	li	a0,1
    40b2:	00003097          	auipc	ra,0x3
    40b6:	fc8080e7          	jalr	-56(ra) # 707a <exit>
  }
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    40ba:	20200593          	li	a1,514
    40be:	00005517          	auipc	a0,0x5
    40c2:	54250513          	addi	a0,a0,1346 # 9600 <schedule_rm+0x1806>
    40c6:	00003097          	auipc	ra,0x3
    40ca:	ff4080e7          	jalr	-12(ra) # 70ba <open>
    40ce:	87aa                	mv	a5,a0
    40d0:	0207c163          	bltz	a5,40f2 <subdir+0x4d0>
    printf("%s: create dd/xx/ff succeeded!\n", s);
    40d4:	fd843583          	ld	a1,-40(s0)
    40d8:	00005517          	auipc	a0,0x5
    40dc:	53850513          	addi	a0,a0,1336 # 9610 <schedule_rm+0x1816>
    40e0:	00003097          	auipc	ra,0x3
    40e4:	4e0080e7          	jalr	1248(ra) # 75c0 <printf>
    exit(1);
    40e8:	4505                	li	a0,1
    40ea:	00003097          	auipc	ra,0x3
    40ee:	f90080e7          	jalr	-112(ra) # 707a <exit>
  }
  if(open("dd", O_CREATE) >= 0){
    40f2:	20000593          	li	a1,512
    40f6:	00005517          	auipc	a0,0x5
    40fa:	22a50513          	addi	a0,a0,554 # 9320 <schedule_rm+0x1526>
    40fe:	00003097          	auipc	ra,0x3
    4102:	fbc080e7          	jalr	-68(ra) # 70ba <open>
    4106:	87aa                	mv	a5,a0
    4108:	0207c163          	bltz	a5,412a <subdir+0x508>
    printf("%s: create dd succeeded!\n", s);
    410c:	fd843583          	ld	a1,-40(s0)
    4110:	00005517          	auipc	a0,0x5
    4114:	52050513          	addi	a0,a0,1312 # 9630 <schedule_rm+0x1836>
    4118:	00003097          	auipc	ra,0x3
    411c:	4a8080e7          	jalr	1192(ra) # 75c0 <printf>
    exit(1);
    4120:	4505                	li	a0,1
    4122:	00003097          	auipc	ra,0x3
    4126:	f58080e7          	jalr	-168(ra) # 707a <exit>
  }
  if(open("dd", O_RDWR) >= 0){
    412a:	4589                	li	a1,2
    412c:	00005517          	auipc	a0,0x5
    4130:	1f450513          	addi	a0,a0,500 # 9320 <schedule_rm+0x1526>
    4134:	00003097          	auipc	ra,0x3
    4138:	f86080e7          	jalr	-122(ra) # 70ba <open>
    413c:	87aa                	mv	a5,a0
    413e:	0207c163          	bltz	a5,4160 <subdir+0x53e>
    printf("%s: open dd rdwr succeeded!\n", s);
    4142:	fd843583          	ld	a1,-40(s0)
    4146:	00005517          	auipc	a0,0x5
    414a:	50a50513          	addi	a0,a0,1290 # 9650 <schedule_rm+0x1856>
    414e:	00003097          	auipc	ra,0x3
    4152:	472080e7          	jalr	1138(ra) # 75c0 <printf>
    exit(1);
    4156:	4505                	li	a0,1
    4158:	00003097          	auipc	ra,0x3
    415c:	f22080e7          	jalr	-222(ra) # 707a <exit>
  }
  if(open("dd", O_WRONLY) >= 0){
    4160:	4585                	li	a1,1
    4162:	00005517          	auipc	a0,0x5
    4166:	1be50513          	addi	a0,a0,446 # 9320 <schedule_rm+0x1526>
    416a:	00003097          	auipc	ra,0x3
    416e:	f50080e7          	jalr	-176(ra) # 70ba <open>
    4172:	87aa                	mv	a5,a0
    4174:	0207c163          	bltz	a5,4196 <subdir+0x574>
    printf("%s: open dd wronly succeeded!\n", s);
    4178:	fd843583          	ld	a1,-40(s0)
    417c:	00005517          	auipc	a0,0x5
    4180:	4f450513          	addi	a0,a0,1268 # 9670 <schedule_rm+0x1876>
    4184:	00003097          	auipc	ra,0x3
    4188:	43c080e7          	jalr	1084(ra) # 75c0 <printf>
    exit(1);
    418c:	4505                	li	a0,1
    418e:	00003097          	auipc	ra,0x3
    4192:	eec080e7          	jalr	-276(ra) # 707a <exit>
  }
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    4196:	00005597          	auipc	a1,0x5
    419a:	4fa58593          	addi	a1,a1,1274 # 9690 <schedule_rm+0x1896>
    419e:	00005517          	auipc	a0,0x5
    41a2:	43250513          	addi	a0,a0,1074 # 95d0 <schedule_rm+0x17d6>
    41a6:	00003097          	auipc	ra,0x3
    41aa:	f34080e7          	jalr	-204(ra) # 70da <link>
    41ae:	87aa                	mv	a5,a0
    41b0:	e385                	bnez	a5,41d0 <subdir+0x5ae>
    printf("%s: link dd/ff/ff dd/dd/xx succeeded!\n", s);
    41b2:	fd843583          	ld	a1,-40(s0)
    41b6:	00005517          	auipc	a0,0x5
    41ba:	4ea50513          	addi	a0,a0,1258 # 96a0 <schedule_rm+0x18a6>
    41be:	00003097          	auipc	ra,0x3
    41c2:	402080e7          	jalr	1026(ra) # 75c0 <printf>
    exit(1);
    41c6:	4505                	li	a0,1
    41c8:	00003097          	auipc	ra,0x3
    41cc:	eb2080e7          	jalr	-334(ra) # 707a <exit>
  }
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    41d0:	00005597          	auipc	a1,0x5
    41d4:	4c058593          	addi	a1,a1,1216 # 9690 <schedule_rm+0x1896>
    41d8:	00005517          	auipc	a0,0x5
    41dc:	42850513          	addi	a0,a0,1064 # 9600 <schedule_rm+0x1806>
    41e0:	00003097          	auipc	ra,0x3
    41e4:	efa080e7          	jalr	-262(ra) # 70da <link>
    41e8:	87aa                	mv	a5,a0
    41ea:	e385                	bnez	a5,420a <subdir+0x5e8>
    printf("%s: link dd/xx/ff dd/dd/xx succeeded!\n", s);
    41ec:	fd843583          	ld	a1,-40(s0)
    41f0:	00005517          	auipc	a0,0x5
    41f4:	4d850513          	addi	a0,a0,1240 # 96c8 <schedule_rm+0x18ce>
    41f8:	00003097          	auipc	ra,0x3
    41fc:	3c8080e7          	jalr	968(ra) # 75c0 <printf>
    exit(1);
    4200:	4505                	li	a0,1
    4202:	00003097          	auipc	ra,0x3
    4206:	e78080e7          	jalr	-392(ra) # 707a <exit>
  }
  if(link("dd/ff", "dd/dd/ffff") == 0){
    420a:	00005597          	auipc	a1,0x5
    420e:	23e58593          	addi	a1,a1,574 # 9448 <schedule_rm+0x164e>
    4212:	00005517          	auipc	a0,0x5
    4216:	12e50513          	addi	a0,a0,302 # 9340 <schedule_rm+0x1546>
    421a:	00003097          	auipc	ra,0x3
    421e:	ec0080e7          	jalr	-320(ra) # 70da <link>
    4222:	87aa                	mv	a5,a0
    4224:	e385                	bnez	a5,4244 <subdir+0x622>
    printf("%s: link dd/ff dd/dd/ffff succeeded!\n", s);
    4226:	fd843583          	ld	a1,-40(s0)
    422a:	00005517          	auipc	a0,0x5
    422e:	4c650513          	addi	a0,a0,1222 # 96f0 <schedule_rm+0x18f6>
    4232:	00003097          	auipc	ra,0x3
    4236:	38e080e7          	jalr	910(ra) # 75c0 <printf>
    exit(1);
    423a:	4505                	li	a0,1
    423c:	00003097          	auipc	ra,0x3
    4240:	e3e080e7          	jalr	-450(ra) # 707a <exit>
  }
  if(mkdir("dd/ff/ff") == 0){
    4244:	00005517          	auipc	a0,0x5
    4248:	38c50513          	addi	a0,a0,908 # 95d0 <schedule_rm+0x17d6>
    424c:	00003097          	auipc	ra,0x3
    4250:	e96080e7          	jalr	-362(ra) # 70e2 <mkdir>
    4254:	87aa                	mv	a5,a0
    4256:	e385                	bnez	a5,4276 <subdir+0x654>
    printf("%s: mkdir dd/ff/ff succeeded!\n", s);
    4258:	fd843583          	ld	a1,-40(s0)
    425c:	00005517          	auipc	a0,0x5
    4260:	4bc50513          	addi	a0,a0,1212 # 9718 <schedule_rm+0x191e>
    4264:	00003097          	auipc	ra,0x3
    4268:	35c080e7          	jalr	860(ra) # 75c0 <printf>
    exit(1);
    426c:	4505                	li	a0,1
    426e:	00003097          	auipc	ra,0x3
    4272:	e0c080e7          	jalr	-500(ra) # 707a <exit>
  }
  if(mkdir("dd/xx/ff") == 0){
    4276:	00005517          	auipc	a0,0x5
    427a:	38a50513          	addi	a0,a0,906 # 9600 <schedule_rm+0x1806>
    427e:	00003097          	auipc	ra,0x3
    4282:	e64080e7          	jalr	-412(ra) # 70e2 <mkdir>
    4286:	87aa                	mv	a5,a0
    4288:	e385                	bnez	a5,42a8 <subdir+0x686>
    printf("%s: mkdir dd/xx/ff succeeded!\n", s);
    428a:	fd843583          	ld	a1,-40(s0)
    428e:	00005517          	auipc	a0,0x5
    4292:	4aa50513          	addi	a0,a0,1194 # 9738 <schedule_rm+0x193e>
    4296:	00003097          	auipc	ra,0x3
    429a:	32a080e7          	jalr	810(ra) # 75c0 <printf>
    exit(1);
    429e:	4505                	li	a0,1
    42a0:	00003097          	auipc	ra,0x3
    42a4:	dda080e7          	jalr	-550(ra) # 707a <exit>
  }
  if(mkdir("dd/dd/ffff") == 0){
    42a8:	00005517          	auipc	a0,0x5
    42ac:	1a050513          	addi	a0,a0,416 # 9448 <schedule_rm+0x164e>
    42b0:	00003097          	auipc	ra,0x3
    42b4:	e32080e7          	jalr	-462(ra) # 70e2 <mkdir>
    42b8:	87aa                	mv	a5,a0
    42ba:	e385                	bnez	a5,42da <subdir+0x6b8>
    printf("%s: mkdir dd/dd/ffff succeeded!\n", s);
    42bc:	fd843583          	ld	a1,-40(s0)
    42c0:	00005517          	auipc	a0,0x5
    42c4:	49850513          	addi	a0,a0,1176 # 9758 <schedule_rm+0x195e>
    42c8:	00003097          	auipc	ra,0x3
    42cc:	2f8080e7          	jalr	760(ra) # 75c0 <printf>
    exit(1);
    42d0:	4505                	li	a0,1
    42d2:	00003097          	auipc	ra,0x3
    42d6:	da8080e7          	jalr	-600(ra) # 707a <exit>
  }
  if(unlink("dd/xx/ff") == 0){
    42da:	00005517          	auipc	a0,0x5
    42de:	32650513          	addi	a0,a0,806 # 9600 <schedule_rm+0x1806>
    42e2:	00003097          	auipc	ra,0x3
    42e6:	de8080e7          	jalr	-536(ra) # 70ca <unlink>
    42ea:	87aa                	mv	a5,a0
    42ec:	e385                	bnez	a5,430c <subdir+0x6ea>
    printf("%s: unlink dd/xx/ff succeeded!\n", s);
    42ee:	fd843583          	ld	a1,-40(s0)
    42f2:	00005517          	auipc	a0,0x5
    42f6:	48e50513          	addi	a0,a0,1166 # 9780 <schedule_rm+0x1986>
    42fa:	00003097          	auipc	ra,0x3
    42fe:	2c6080e7          	jalr	710(ra) # 75c0 <printf>
    exit(1);
    4302:	4505                	li	a0,1
    4304:	00003097          	auipc	ra,0x3
    4308:	d76080e7          	jalr	-650(ra) # 707a <exit>
  }
  if(unlink("dd/ff/ff") == 0){
    430c:	00005517          	auipc	a0,0x5
    4310:	2c450513          	addi	a0,a0,708 # 95d0 <schedule_rm+0x17d6>
    4314:	00003097          	auipc	ra,0x3
    4318:	db6080e7          	jalr	-586(ra) # 70ca <unlink>
    431c:	87aa                	mv	a5,a0
    431e:	e385                	bnez	a5,433e <subdir+0x71c>
    printf("%s: unlink dd/ff/ff succeeded!\n", s);
    4320:	fd843583          	ld	a1,-40(s0)
    4324:	00005517          	auipc	a0,0x5
    4328:	47c50513          	addi	a0,a0,1148 # 97a0 <schedule_rm+0x19a6>
    432c:	00003097          	auipc	ra,0x3
    4330:	294080e7          	jalr	660(ra) # 75c0 <printf>
    exit(1);
    4334:	4505                	li	a0,1
    4336:	00003097          	auipc	ra,0x3
    433a:	d44080e7          	jalr	-700(ra) # 707a <exit>
  }
  if(chdir("dd/ff") == 0){
    433e:	00005517          	auipc	a0,0x5
    4342:	00250513          	addi	a0,a0,2 # 9340 <schedule_rm+0x1546>
    4346:	00003097          	auipc	ra,0x3
    434a:	da4080e7          	jalr	-604(ra) # 70ea <chdir>
    434e:	87aa                	mv	a5,a0
    4350:	e385                	bnez	a5,4370 <subdir+0x74e>
    printf("%s: chdir dd/ff succeeded!\n", s);
    4352:	fd843583          	ld	a1,-40(s0)
    4356:	00005517          	auipc	a0,0x5
    435a:	46a50513          	addi	a0,a0,1130 # 97c0 <schedule_rm+0x19c6>
    435e:	00003097          	auipc	ra,0x3
    4362:	262080e7          	jalr	610(ra) # 75c0 <printf>
    exit(1);
    4366:	4505                	li	a0,1
    4368:	00003097          	auipc	ra,0x3
    436c:	d12080e7          	jalr	-750(ra) # 707a <exit>
  }
  if(chdir("dd/xx") == 0){
    4370:	00005517          	auipc	a0,0x5
    4374:	47050513          	addi	a0,a0,1136 # 97e0 <schedule_rm+0x19e6>
    4378:	00003097          	auipc	ra,0x3
    437c:	d72080e7          	jalr	-654(ra) # 70ea <chdir>
    4380:	87aa                	mv	a5,a0
    4382:	e385                	bnez	a5,43a2 <subdir+0x780>
    printf("%s: chdir dd/xx succeeded!\n", s);
    4384:	fd843583          	ld	a1,-40(s0)
    4388:	00005517          	auipc	a0,0x5
    438c:	46050513          	addi	a0,a0,1120 # 97e8 <schedule_rm+0x19ee>
    4390:	00003097          	auipc	ra,0x3
    4394:	230080e7          	jalr	560(ra) # 75c0 <printf>
    exit(1);
    4398:	4505                	li	a0,1
    439a:	00003097          	auipc	ra,0x3
    439e:	ce0080e7          	jalr	-800(ra) # 707a <exit>
  }

  if(unlink("dd/dd/ffff") != 0){
    43a2:	00005517          	auipc	a0,0x5
    43a6:	0a650513          	addi	a0,a0,166 # 9448 <schedule_rm+0x164e>
    43aa:	00003097          	auipc	ra,0x3
    43ae:	d20080e7          	jalr	-736(ra) # 70ca <unlink>
    43b2:	87aa                	mv	a5,a0
    43b4:	c385                	beqz	a5,43d4 <subdir+0x7b2>
    printf("%s: unlink dd/dd/ff failed\n", s);
    43b6:	fd843583          	ld	a1,-40(s0)
    43ba:	00005517          	auipc	a0,0x5
    43be:	0c650513          	addi	a0,a0,198 # 9480 <schedule_rm+0x1686>
    43c2:	00003097          	auipc	ra,0x3
    43c6:	1fe080e7          	jalr	510(ra) # 75c0 <printf>
    exit(1);
    43ca:	4505                	li	a0,1
    43cc:	00003097          	auipc	ra,0x3
    43d0:	cae080e7          	jalr	-850(ra) # 707a <exit>
  }
  if(unlink("dd/ff") != 0){
    43d4:	00005517          	auipc	a0,0x5
    43d8:	f6c50513          	addi	a0,a0,-148 # 9340 <schedule_rm+0x1546>
    43dc:	00003097          	auipc	ra,0x3
    43e0:	cee080e7          	jalr	-786(ra) # 70ca <unlink>
    43e4:	87aa                	mv	a5,a0
    43e6:	c385                	beqz	a5,4406 <subdir+0x7e4>
    printf("%s: unlink dd/ff failed\n", s);
    43e8:	fd843583          	ld	a1,-40(s0)
    43ec:	00005517          	auipc	a0,0x5
    43f0:	41c50513          	addi	a0,a0,1052 # 9808 <schedule_rm+0x1a0e>
    43f4:	00003097          	auipc	ra,0x3
    43f8:	1cc080e7          	jalr	460(ra) # 75c0 <printf>
    exit(1);
    43fc:	4505                	li	a0,1
    43fe:	00003097          	auipc	ra,0x3
    4402:	c7c080e7          	jalr	-900(ra) # 707a <exit>
  }
  if(unlink("dd") == 0){
    4406:	00005517          	auipc	a0,0x5
    440a:	f1a50513          	addi	a0,a0,-230 # 9320 <schedule_rm+0x1526>
    440e:	00003097          	auipc	ra,0x3
    4412:	cbc080e7          	jalr	-836(ra) # 70ca <unlink>
    4416:	87aa                	mv	a5,a0
    4418:	e385                	bnez	a5,4438 <subdir+0x816>
    printf("%s: unlink non-empty dd succeeded!\n", s);
    441a:	fd843583          	ld	a1,-40(s0)
    441e:	00005517          	auipc	a0,0x5
    4422:	40a50513          	addi	a0,a0,1034 # 9828 <schedule_rm+0x1a2e>
    4426:	00003097          	auipc	ra,0x3
    442a:	19a080e7          	jalr	410(ra) # 75c0 <printf>
    exit(1);
    442e:	4505                	li	a0,1
    4430:	00003097          	auipc	ra,0x3
    4434:	c4a080e7          	jalr	-950(ra) # 707a <exit>
  }
  if(unlink("dd/dd") < 0){
    4438:	00005517          	auipc	a0,0x5
    443c:	41850513          	addi	a0,a0,1048 # 9850 <schedule_rm+0x1a56>
    4440:	00003097          	auipc	ra,0x3
    4444:	c8a080e7          	jalr	-886(ra) # 70ca <unlink>
    4448:	87aa                	mv	a5,a0
    444a:	0207d163          	bgez	a5,446c <subdir+0x84a>
    printf("%s: unlink dd/dd failed\n", s);
    444e:	fd843583          	ld	a1,-40(s0)
    4452:	00005517          	auipc	a0,0x5
    4456:	40650513          	addi	a0,a0,1030 # 9858 <schedule_rm+0x1a5e>
    445a:	00003097          	auipc	ra,0x3
    445e:	166080e7          	jalr	358(ra) # 75c0 <printf>
    exit(1);
    4462:	4505                	li	a0,1
    4464:	00003097          	auipc	ra,0x3
    4468:	c16080e7          	jalr	-1002(ra) # 707a <exit>
  }
  if(unlink("dd") < 0){
    446c:	00005517          	auipc	a0,0x5
    4470:	eb450513          	addi	a0,a0,-332 # 9320 <schedule_rm+0x1526>
    4474:	00003097          	auipc	ra,0x3
    4478:	c56080e7          	jalr	-938(ra) # 70ca <unlink>
    447c:	87aa                	mv	a5,a0
    447e:	0207d163          	bgez	a5,44a0 <subdir+0x87e>
    printf("%s: unlink dd failed\n", s);
    4482:	fd843583          	ld	a1,-40(s0)
    4486:	00005517          	auipc	a0,0x5
    448a:	3f250513          	addi	a0,a0,1010 # 9878 <schedule_rm+0x1a7e>
    448e:	00003097          	auipc	ra,0x3
    4492:	132080e7          	jalr	306(ra) # 75c0 <printf>
    exit(1);
    4496:	4505                	li	a0,1
    4498:	00003097          	auipc	ra,0x3
    449c:	be2080e7          	jalr	-1054(ra) # 707a <exit>
  }
}
    44a0:	0001                	nop
    44a2:	70a2                	ld	ra,40(sp)
    44a4:	7402                	ld	s0,32(sp)
    44a6:	6145                	addi	sp,sp,48
    44a8:	8082                	ret

00000000000044aa <bigwrite>:

// test writes that are larger than the log.
void
bigwrite(char *s)
{
    44aa:	7179                	addi	sp,sp,-48
    44ac:	f406                	sd	ra,40(sp)
    44ae:	f022                	sd	s0,32(sp)
    44b0:	1800                	addi	s0,sp,48
    44b2:	fca43c23          	sd	a0,-40(s0)
  int fd, sz;

  unlink("bigwrite");
    44b6:	00004517          	auipc	a0,0x4
    44ba:	e7250513          	addi	a0,a0,-398 # 8328 <schedule_rm+0x52e>
    44be:	00003097          	auipc	ra,0x3
    44c2:	c0c080e7          	jalr	-1012(ra) # 70ca <unlink>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
    44c6:	1f300793          	li	a5,499
    44ca:	fef42623          	sw	a5,-20(s0)
    44ce:	a0e5                	j	45b6 <bigwrite+0x10c>
    fd = open("bigwrite", O_CREATE | O_RDWR);
    44d0:	20200593          	li	a1,514
    44d4:	00004517          	auipc	a0,0x4
    44d8:	e5450513          	addi	a0,a0,-428 # 8328 <schedule_rm+0x52e>
    44dc:	00003097          	auipc	ra,0x3
    44e0:	bde080e7          	jalr	-1058(ra) # 70ba <open>
    44e4:	87aa                	mv	a5,a0
    44e6:	fef42223          	sw	a5,-28(s0)
    if(fd < 0){
    44ea:	fe442783          	lw	a5,-28(s0)
    44ee:	2781                	sext.w	a5,a5
    44f0:	0207d163          	bgez	a5,4512 <bigwrite+0x68>
      printf("%s: cannot create bigwrite\n", s);
    44f4:	fd843583          	ld	a1,-40(s0)
    44f8:	00005517          	auipc	a0,0x5
    44fc:	39850513          	addi	a0,a0,920 # 9890 <schedule_rm+0x1a96>
    4500:	00003097          	auipc	ra,0x3
    4504:	0c0080e7          	jalr	192(ra) # 75c0 <printf>
      exit(1);
    4508:	4505                	li	a0,1
    450a:	00003097          	auipc	ra,0x3
    450e:	b70080e7          	jalr	-1168(ra) # 707a <exit>
    }
    int i;
    for(i = 0; i < 2; i++){
    4512:	fe042423          	sw	zero,-24(s0)
    4516:	a0a5                	j	457e <bigwrite+0xd4>
      int cc = write(fd, buf, sz);
    4518:	fec42703          	lw	a4,-20(s0)
    451c:	fe442783          	lw	a5,-28(s0)
    4520:	863a                	mv	a2,a4
    4522:	00006597          	auipc	a1,0x6
    4526:	3de58593          	addi	a1,a1,990 # a900 <buf>
    452a:	853e                	mv	a0,a5
    452c:	00003097          	auipc	ra,0x3
    4530:	b6e080e7          	jalr	-1170(ra) # 709a <write>
    4534:	87aa                	mv	a5,a0
    4536:	fef42023          	sw	a5,-32(s0)
      if(cc != sz){
    453a:	fe042703          	lw	a4,-32(s0)
    453e:	fec42783          	lw	a5,-20(s0)
    4542:	2701                	sext.w	a4,a4
    4544:	2781                	sext.w	a5,a5
    4546:	02f70763          	beq	a4,a5,4574 <bigwrite+0xca>
        printf("%s: write(%d) ret %d\n", s, sz, cc);
    454a:	fe042703          	lw	a4,-32(s0)
    454e:	fec42783          	lw	a5,-20(s0)
    4552:	86ba                	mv	a3,a4
    4554:	863e                	mv	a2,a5
    4556:	fd843583          	ld	a1,-40(s0)
    455a:	00005517          	auipc	a0,0x5
    455e:	35650513          	addi	a0,a0,854 # 98b0 <schedule_rm+0x1ab6>
    4562:	00003097          	auipc	ra,0x3
    4566:	05e080e7          	jalr	94(ra) # 75c0 <printf>
        exit(1);
    456a:	4505                	li	a0,1
    456c:	00003097          	auipc	ra,0x3
    4570:	b0e080e7          	jalr	-1266(ra) # 707a <exit>
    for(i = 0; i < 2; i++){
    4574:	fe842783          	lw	a5,-24(s0)
    4578:	2785                	addiw	a5,a5,1
    457a:	fef42423          	sw	a5,-24(s0)
    457e:	fe842783          	lw	a5,-24(s0)
    4582:	0007871b          	sext.w	a4,a5
    4586:	4785                	li	a5,1
    4588:	f8e7d8e3          	bge	a5,a4,4518 <bigwrite+0x6e>
      }
    }
    close(fd);
    458c:	fe442783          	lw	a5,-28(s0)
    4590:	853e                	mv	a0,a5
    4592:	00003097          	auipc	ra,0x3
    4596:	b10080e7          	jalr	-1264(ra) # 70a2 <close>
    unlink("bigwrite");
    459a:	00004517          	auipc	a0,0x4
    459e:	d8e50513          	addi	a0,a0,-626 # 8328 <schedule_rm+0x52e>
    45a2:	00003097          	auipc	ra,0x3
    45a6:	b28080e7          	jalr	-1240(ra) # 70ca <unlink>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
    45aa:	fec42783          	lw	a5,-20(s0)
    45ae:	1d77879b          	addiw	a5,a5,471
    45b2:	fef42623          	sw	a5,-20(s0)
    45b6:	fec42783          	lw	a5,-20(s0)
    45ba:	0007871b          	sext.w	a4,a5
    45be:	678d                	lui	a5,0x3
    45c0:	f0f748e3          	blt	a4,a5,44d0 <bigwrite+0x26>
  }
}
    45c4:	0001                	nop
    45c6:	0001                	nop
    45c8:	70a2                	ld	ra,40(sp)
    45ca:	7402                	ld	s0,32(sp)
    45cc:	6145                	addi	sp,sp,48
    45ce:	8082                	ret

00000000000045d0 <manywrites>:

// concurrent writes to try to provoke deadlock in the virtio disk
// driver.
void
manywrites(char *s)
{
    45d0:	711d                	addi	sp,sp,-96
    45d2:	ec86                	sd	ra,88(sp)
    45d4:	e8a2                	sd	s0,80(sp)
    45d6:	1080                	addi	s0,sp,96
    45d8:	faa43423          	sd	a0,-88(s0)
  int nchildren = 4;
    45dc:	4791                	li	a5,4
    45de:	fcf42e23          	sw	a5,-36(s0)
  int howmany = 30; // increase to look for deadlock
    45e2:	47f9                	li	a5,30
    45e4:	fcf42c23          	sw	a5,-40(s0)
  
  for(int ci = 0; ci < nchildren; ci++){
    45e8:	fe042623          	sw	zero,-20(s0)
    45ec:	aa49                	j	477e <manywrites+0x1ae>
    int pid = fork();
    45ee:	00003097          	auipc	ra,0x3
    45f2:	a84080e7          	jalr	-1404(ra) # 7072 <fork>
    45f6:	87aa                	mv	a5,a0
    45f8:	fcf42a23          	sw	a5,-44(s0)
    if(pid < 0){
    45fc:	fd442783          	lw	a5,-44(s0)
    4600:	2781                	sext.w	a5,a5
    4602:	0007df63          	bgez	a5,4620 <manywrites+0x50>
      printf("fork failed\n");
    4606:	00004517          	auipc	a0,0x4
    460a:	08250513          	addi	a0,a0,130 # 8688 <schedule_rm+0x88e>
    460e:	00003097          	auipc	ra,0x3
    4612:	fb2080e7          	jalr	-78(ra) # 75c0 <printf>
      exit(1);
    4616:	4505                	li	a0,1
    4618:	00003097          	auipc	ra,0x3
    461c:	a62080e7          	jalr	-1438(ra) # 707a <exit>
    }

    if(pid == 0){
    4620:	fd442783          	lw	a5,-44(s0)
    4624:	2781                	sext.w	a5,a5
    4626:	14079763          	bnez	a5,4774 <manywrites+0x1a4>
      char name[3];
      name[0] = 'b';
    462a:	06200793          	li	a5,98
    462e:	fcf40023          	sb	a5,-64(s0)
      name[1] = 'a' + ci;
    4632:	fec42783          	lw	a5,-20(s0)
    4636:	0ff7f793          	andi	a5,a5,255
    463a:	0617879b          	addiw	a5,a5,97
    463e:	0ff7f793          	andi	a5,a5,255
    4642:	fcf400a3          	sb	a5,-63(s0)
      name[2] = '\0';
    4646:	fc040123          	sb	zero,-62(s0)
      unlink(name);
    464a:	fc040793          	addi	a5,s0,-64
    464e:	853e                	mv	a0,a5
    4650:	00003097          	auipc	ra,0x3
    4654:	a7a080e7          	jalr	-1414(ra) # 70ca <unlink>
      
      for(int iters = 0; iters < howmany; iters++){
    4658:	fe042423          	sw	zero,-24(s0)
    465c:	a8c5                	j	474c <manywrites+0x17c>
        for(int i = 0; i < ci+1; i++){
    465e:	fe042223          	sw	zero,-28(s0)
    4662:	a0c9                	j	4724 <manywrites+0x154>
          int fd = open(name, O_CREATE | O_RDWR);
    4664:	fc040793          	addi	a5,s0,-64
    4668:	20200593          	li	a1,514
    466c:	853e                	mv	a0,a5
    466e:	00003097          	auipc	ra,0x3
    4672:	a4c080e7          	jalr	-1460(ra) # 70ba <open>
    4676:	87aa                	mv	a5,a0
    4678:	fcf42823          	sw	a5,-48(s0)
          if(fd < 0){
    467c:	fd042783          	lw	a5,-48(s0)
    4680:	2781                	sext.w	a5,a5
    4682:	0207d463          	bgez	a5,46aa <manywrites+0xda>
            printf("%s: cannot create %s\n", s, name);
    4686:	fc040793          	addi	a5,s0,-64
    468a:	863e                	mv	a2,a5
    468c:	fa843583          	ld	a1,-88(s0)
    4690:	00005517          	auipc	a0,0x5
    4694:	23850513          	addi	a0,a0,568 # 98c8 <schedule_rm+0x1ace>
    4698:	00003097          	auipc	ra,0x3
    469c:	f28080e7          	jalr	-216(ra) # 75c0 <printf>
            exit(1);
    46a0:	4505                	li	a0,1
    46a2:	00003097          	auipc	ra,0x3
    46a6:	9d8080e7          	jalr	-1576(ra) # 707a <exit>
          }
          int sz = sizeof(buf);
    46aa:	678d                	lui	a5,0x3
    46ac:	fcf42623          	sw	a5,-52(s0)
          int cc = write(fd, buf, sz);
    46b0:	fcc42703          	lw	a4,-52(s0)
    46b4:	fd042783          	lw	a5,-48(s0)
    46b8:	863a                	mv	a2,a4
    46ba:	00006597          	auipc	a1,0x6
    46be:	24658593          	addi	a1,a1,582 # a900 <buf>
    46c2:	853e                	mv	a0,a5
    46c4:	00003097          	auipc	ra,0x3
    46c8:	9d6080e7          	jalr	-1578(ra) # 709a <write>
    46cc:	87aa                	mv	a5,a0
    46ce:	fcf42423          	sw	a5,-56(s0)
          if(cc != sz){
    46d2:	fc842703          	lw	a4,-56(s0)
    46d6:	fcc42783          	lw	a5,-52(s0)
    46da:	2701                	sext.w	a4,a4
    46dc:	2781                	sext.w	a5,a5
    46de:	02f70763          	beq	a4,a5,470c <manywrites+0x13c>
            printf("%s: write(%d) ret %d\n", s, sz, cc);
    46e2:	fc842703          	lw	a4,-56(s0)
    46e6:	fcc42783          	lw	a5,-52(s0)
    46ea:	86ba                	mv	a3,a4
    46ec:	863e                	mv	a2,a5
    46ee:	fa843583          	ld	a1,-88(s0)
    46f2:	00005517          	auipc	a0,0x5
    46f6:	1be50513          	addi	a0,a0,446 # 98b0 <schedule_rm+0x1ab6>
    46fa:	00003097          	auipc	ra,0x3
    46fe:	ec6080e7          	jalr	-314(ra) # 75c0 <printf>
            exit(1);
    4702:	4505                	li	a0,1
    4704:	00003097          	auipc	ra,0x3
    4708:	976080e7          	jalr	-1674(ra) # 707a <exit>
          }
          close(fd);
    470c:	fd042783          	lw	a5,-48(s0)
    4710:	853e                	mv	a0,a5
    4712:	00003097          	auipc	ra,0x3
    4716:	990080e7          	jalr	-1648(ra) # 70a2 <close>
        for(int i = 0; i < ci+1; i++){
    471a:	fe442783          	lw	a5,-28(s0)
    471e:	2785                	addiw	a5,a5,1
    4720:	fef42223          	sw	a5,-28(s0)
    4724:	fec42703          	lw	a4,-20(s0)
    4728:	fe442783          	lw	a5,-28(s0)
    472c:	2701                	sext.w	a4,a4
    472e:	2781                	sext.w	a5,a5
    4730:	f2f75ae3          	bge	a4,a5,4664 <manywrites+0x94>
        }
        unlink(name);
    4734:	fc040793          	addi	a5,s0,-64
    4738:	853e                	mv	a0,a5
    473a:	00003097          	auipc	ra,0x3
    473e:	990080e7          	jalr	-1648(ra) # 70ca <unlink>
      for(int iters = 0; iters < howmany; iters++){
    4742:	fe842783          	lw	a5,-24(s0)
    4746:	2785                	addiw	a5,a5,1
    4748:	fef42423          	sw	a5,-24(s0)
    474c:	fe842703          	lw	a4,-24(s0)
    4750:	fd842783          	lw	a5,-40(s0)
    4754:	2701                	sext.w	a4,a4
    4756:	2781                	sext.w	a5,a5
    4758:	f0f743e3          	blt	a4,a5,465e <manywrites+0x8e>
      }

      unlink(name);
    475c:	fc040793          	addi	a5,s0,-64
    4760:	853e                	mv	a0,a5
    4762:	00003097          	auipc	ra,0x3
    4766:	968080e7          	jalr	-1688(ra) # 70ca <unlink>
      exit(0);
    476a:	4501                	li	a0,0
    476c:	00003097          	auipc	ra,0x3
    4770:	90e080e7          	jalr	-1778(ra) # 707a <exit>
  for(int ci = 0; ci < nchildren; ci++){
    4774:	fec42783          	lw	a5,-20(s0)
    4778:	2785                	addiw	a5,a5,1
    477a:	fef42623          	sw	a5,-20(s0)
    477e:	fec42703          	lw	a4,-20(s0)
    4782:	fdc42783          	lw	a5,-36(s0)
    4786:	2701                	sext.w	a4,a4
    4788:	2781                	sext.w	a5,a5
    478a:	e6f742e3          	blt	a4,a5,45ee <manywrites+0x1e>
    }
  }

  for(int ci = 0; ci < nchildren; ci++){
    478e:	fe042023          	sw	zero,-32(s0)
    4792:	a80d                	j	47c4 <manywrites+0x1f4>
    int st = 0;
    4794:	fa042e23          	sw	zero,-68(s0)
    wait(&st);
    4798:	fbc40793          	addi	a5,s0,-68
    479c:	853e                	mv	a0,a5
    479e:	00003097          	auipc	ra,0x3
    47a2:	8e4080e7          	jalr	-1820(ra) # 7082 <wait>
    if(st != 0)
    47a6:	fbc42783          	lw	a5,-68(s0)
    47aa:	cb81                	beqz	a5,47ba <manywrites+0x1ea>
      exit(st);
    47ac:	fbc42783          	lw	a5,-68(s0)
    47b0:	853e                	mv	a0,a5
    47b2:	00003097          	auipc	ra,0x3
    47b6:	8c8080e7          	jalr	-1848(ra) # 707a <exit>
  for(int ci = 0; ci < nchildren; ci++){
    47ba:	fe042783          	lw	a5,-32(s0)
    47be:	2785                	addiw	a5,a5,1
    47c0:	fef42023          	sw	a5,-32(s0)
    47c4:	fe042703          	lw	a4,-32(s0)
    47c8:	fdc42783          	lw	a5,-36(s0)
    47cc:	2701                	sext.w	a4,a4
    47ce:	2781                	sext.w	a5,a5
    47d0:	fcf742e3          	blt	a4,a5,4794 <manywrites+0x1c4>
  }
  exit(0);
    47d4:	4501                	li	a0,0
    47d6:	00003097          	auipc	ra,0x3
    47da:	8a4080e7          	jalr	-1884(ra) # 707a <exit>

00000000000047de <bigfile>:
}

void
bigfile(char *s)
{
    47de:	7179                	addi	sp,sp,-48
    47e0:	f406                	sd	ra,40(sp)
    47e2:	f022                	sd	s0,32(sp)
    47e4:	1800                	addi	s0,sp,48
    47e6:	fca43c23          	sd	a0,-40(s0)
  enum { N = 20, SZ=600 };
  int fd, i, total, cc;

  unlink("bigfile.dat");
    47ea:	00005517          	auipc	a0,0x5
    47ee:	0f650513          	addi	a0,a0,246 # 98e0 <schedule_rm+0x1ae6>
    47f2:	00003097          	auipc	ra,0x3
    47f6:	8d8080e7          	jalr	-1832(ra) # 70ca <unlink>
  fd = open("bigfile.dat", O_CREATE | O_RDWR);
    47fa:	20200593          	li	a1,514
    47fe:	00005517          	auipc	a0,0x5
    4802:	0e250513          	addi	a0,a0,226 # 98e0 <schedule_rm+0x1ae6>
    4806:	00003097          	auipc	ra,0x3
    480a:	8b4080e7          	jalr	-1868(ra) # 70ba <open>
    480e:	87aa                	mv	a5,a0
    4810:	fef42223          	sw	a5,-28(s0)
  if(fd < 0){
    4814:	fe442783          	lw	a5,-28(s0)
    4818:	2781                	sext.w	a5,a5
    481a:	0207d163          	bgez	a5,483c <bigfile+0x5e>
    printf("%s: cannot create bigfile", s);
    481e:	fd843583          	ld	a1,-40(s0)
    4822:	00005517          	auipc	a0,0x5
    4826:	0ce50513          	addi	a0,a0,206 # 98f0 <schedule_rm+0x1af6>
    482a:	00003097          	auipc	ra,0x3
    482e:	d96080e7          	jalr	-618(ra) # 75c0 <printf>
    exit(1);
    4832:	4505                	li	a0,1
    4834:	00003097          	auipc	ra,0x3
    4838:	846080e7          	jalr	-1978(ra) # 707a <exit>
  }
  for(i = 0; i < N; i++){
    483c:	fe042623          	sw	zero,-20(s0)
    4840:	a0ad                	j	48aa <bigfile+0xcc>
    memset(buf, i, SZ);
    4842:	fec42783          	lw	a5,-20(s0)
    4846:	25800613          	li	a2,600
    484a:	85be                	mv	a1,a5
    484c:	00006517          	auipc	a0,0x6
    4850:	0b450513          	addi	a0,a0,180 # a900 <buf>
    4854:	00002097          	auipc	ra,0x2
    4858:	47c080e7          	jalr	1148(ra) # 6cd0 <memset>
    if(write(fd, buf, SZ) != SZ){
    485c:	fe442783          	lw	a5,-28(s0)
    4860:	25800613          	li	a2,600
    4864:	00006597          	auipc	a1,0x6
    4868:	09c58593          	addi	a1,a1,156 # a900 <buf>
    486c:	853e                	mv	a0,a5
    486e:	00003097          	auipc	ra,0x3
    4872:	82c080e7          	jalr	-2004(ra) # 709a <write>
    4876:	87aa                	mv	a5,a0
    4878:	873e                	mv	a4,a5
    487a:	25800793          	li	a5,600
    487e:	02f70163          	beq	a4,a5,48a0 <bigfile+0xc2>
      printf("%s: write bigfile failed\n", s);
    4882:	fd843583          	ld	a1,-40(s0)
    4886:	00005517          	auipc	a0,0x5
    488a:	08a50513          	addi	a0,a0,138 # 9910 <schedule_rm+0x1b16>
    488e:	00003097          	auipc	ra,0x3
    4892:	d32080e7          	jalr	-718(ra) # 75c0 <printf>
      exit(1);
    4896:	4505                	li	a0,1
    4898:	00002097          	auipc	ra,0x2
    489c:	7e2080e7          	jalr	2018(ra) # 707a <exit>
  for(i = 0; i < N; i++){
    48a0:	fec42783          	lw	a5,-20(s0)
    48a4:	2785                	addiw	a5,a5,1
    48a6:	fef42623          	sw	a5,-20(s0)
    48aa:	fec42783          	lw	a5,-20(s0)
    48ae:	0007871b          	sext.w	a4,a5
    48b2:	47cd                	li	a5,19
    48b4:	f8e7d7e3          	bge	a5,a4,4842 <bigfile+0x64>
    }
  }
  close(fd);
    48b8:	fe442783          	lw	a5,-28(s0)
    48bc:	853e                	mv	a0,a5
    48be:	00002097          	auipc	ra,0x2
    48c2:	7e4080e7          	jalr	2020(ra) # 70a2 <close>

  fd = open("bigfile.dat", 0);
    48c6:	4581                	li	a1,0
    48c8:	00005517          	auipc	a0,0x5
    48cc:	01850513          	addi	a0,a0,24 # 98e0 <schedule_rm+0x1ae6>
    48d0:	00002097          	auipc	ra,0x2
    48d4:	7ea080e7          	jalr	2026(ra) # 70ba <open>
    48d8:	87aa                	mv	a5,a0
    48da:	fef42223          	sw	a5,-28(s0)
  if(fd < 0){
    48de:	fe442783          	lw	a5,-28(s0)
    48e2:	2781                	sext.w	a5,a5
    48e4:	0207d163          	bgez	a5,4906 <bigfile+0x128>
    printf("%s: cannot open bigfile\n", s);
    48e8:	fd843583          	ld	a1,-40(s0)
    48ec:	00005517          	auipc	a0,0x5
    48f0:	04450513          	addi	a0,a0,68 # 9930 <schedule_rm+0x1b36>
    48f4:	00003097          	auipc	ra,0x3
    48f8:	ccc080e7          	jalr	-820(ra) # 75c0 <printf>
    exit(1);
    48fc:	4505                	li	a0,1
    48fe:	00002097          	auipc	ra,0x2
    4902:	77c080e7          	jalr	1916(ra) # 707a <exit>
  }
  total = 0;
    4906:	fe042423          	sw	zero,-24(s0)
  for(i = 0; ; i++){
    490a:	fe042623          	sw	zero,-20(s0)
    cc = read(fd, buf, SZ/2);
    490e:	fe442783          	lw	a5,-28(s0)
    4912:	12c00613          	li	a2,300
    4916:	00006597          	auipc	a1,0x6
    491a:	fea58593          	addi	a1,a1,-22 # a900 <buf>
    491e:	853e                	mv	a0,a5
    4920:	00002097          	auipc	ra,0x2
    4924:	772080e7          	jalr	1906(ra) # 7092 <read>
    4928:	87aa                	mv	a5,a0
    492a:	fef42023          	sw	a5,-32(s0)
    if(cc < 0){
    492e:	fe042783          	lw	a5,-32(s0)
    4932:	2781                	sext.w	a5,a5
    4934:	0207d163          	bgez	a5,4956 <bigfile+0x178>
      printf("%s: read bigfile failed\n", s);
    4938:	fd843583          	ld	a1,-40(s0)
    493c:	00005517          	auipc	a0,0x5
    4940:	01450513          	addi	a0,a0,20 # 9950 <schedule_rm+0x1b56>
    4944:	00003097          	auipc	ra,0x3
    4948:	c7c080e7          	jalr	-900(ra) # 75c0 <printf>
      exit(1);
    494c:	4505                	li	a0,1
    494e:	00002097          	auipc	ra,0x2
    4952:	72c080e7          	jalr	1836(ra) # 707a <exit>
    }
    if(cc == 0)
    4956:	fe042783          	lw	a5,-32(s0)
    495a:	2781                	sext.w	a5,a5
    495c:	cbd5                	beqz	a5,4a10 <bigfile+0x232>
      break;
    if(cc != SZ/2){
    495e:	fe042783          	lw	a5,-32(s0)
    4962:	0007871b          	sext.w	a4,a5
    4966:	12c00793          	li	a5,300
    496a:	02f70163          	beq	a4,a5,498c <bigfile+0x1ae>
      printf("%s: short read bigfile\n", s);
    496e:	fd843583          	ld	a1,-40(s0)
    4972:	00005517          	auipc	a0,0x5
    4976:	ffe50513          	addi	a0,a0,-2 # 9970 <schedule_rm+0x1b76>
    497a:	00003097          	auipc	ra,0x3
    497e:	c46080e7          	jalr	-954(ra) # 75c0 <printf>
      exit(1);
    4982:	4505                	li	a0,1
    4984:	00002097          	auipc	ra,0x2
    4988:	6f6080e7          	jalr	1782(ra) # 707a <exit>
    }
    if(buf[0] != i/2 || buf[SZ/2-1] != i/2){
    498c:	00006797          	auipc	a5,0x6
    4990:	f7478793          	addi	a5,a5,-140 # a900 <buf>
    4994:	0007c783          	lbu	a5,0(a5)
    4998:	0007869b          	sext.w	a3,a5
    499c:	fec42783          	lw	a5,-20(s0)
    49a0:	01f7d71b          	srliw	a4,a5,0x1f
    49a4:	9fb9                	addw	a5,a5,a4
    49a6:	4017d79b          	sraiw	a5,a5,0x1
    49aa:	2781                	sext.w	a5,a5
    49ac:	8736                	mv	a4,a3
    49ae:	02f71563          	bne	a4,a5,49d8 <bigfile+0x1fa>
    49b2:	00006797          	auipc	a5,0x6
    49b6:	f4e78793          	addi	a5,a5,-178 # a900 <buf>
    49ba:	12b7c783          	lbu	a5,299(a5)
    49be:	0007869b          	sext.w	a3,a5
    49c2:	fec42783          	lw	a5,-20(s0)
    49c6:	01f7d71b          	srliw	a4,a5,0x1f
    49ca:	9fb9                	addw	a5,a5,a4
    49cc:	4017d79b          	sraiw	a5,a5,0x1
    49d0:	2781                	sext.w	a5,a5
    49d2:	8736                	mv	a4,a3
    49d4:	02f70163          	beq	a4,a5,49f6 <bigfile+0x218>
      printf("%s: read bigfile wrong data\n", s);
    49d8:	fd843583          	ld	a1,-40(s0)
    49dc:	00005517          	auipc	a0,0x5
    49e0:	fac50513          	addi	a0,a0,-84 # 9988 <schedule_rm+0x1b8e>
    49e4:	00003097          	auipc	ra,0x3
    49e8:	bdc080e7          	jalr	-1060(ra) # 75c0 <printf>
      exit(1);
    49ec:	4505                	li	a0,1
    49ee:	00002097          	auipc	ra,0x2
    49f2:	68c080e7          	jalr	1676(ra) # 707a <exit>
    }
    total += cc;
    49f6:	fe842703          	lw	a4,-24(s0)
    49fa:	fe042783          	lw	a5,-32(s0)
    49fe:	9fb9                	addw	a5,a5,a4
    4a00:	fef42423          	sw	a5,-24(s0)
  for(i = 0; ; i++){
    4a04:	fec42783          	lw	a5,-20(s0)
    4a08:	2785                	addiw	a5,a5,1
    4a0a:	fef42623          	sw	a5,-20(s0)
    cc = read(fd, buf, SZ/2);
    4a0e:	b701                	j	490e <bigfile+0x130>
      break;
    4a10:	0001                	nop
  }
  close(fd);
    4a12:	fe442783          	lw	a5,-28(s0)
    4a16:	853e                	mv	a0,a5
    4a18:	00002097          	auipc	ra,0x2
    4a1c:	68a080e7          	jalr	1674(ra) # 70a2 <close>
  if(total != N*SZ){
    4a20:	fe842783          	lw	a5,-24(s0)
    4a24:	0007871b          	sext.w	a4,a5
    4a28:	678d                	lui	a5,0x3
    4a2a:	ee078793          	addi	a5,a5,-288 # 2ee0 <createdelete+0x22a>
    4a2e:	02f70163          	beq	a4,a5,4a50 <bigfile+0x272>
    printf("%s: read bigfile wrong total\n", s);
    4a32:	fd843583          	ld	a1,-40(s0)
    4a36:	00005517          	auipc	a0,0x5
    4a3a:	f7250513          	addi	a0,a0,-142 # 99a8 <schedule_rm+0x1bae>
    4a3e:	00003097          	auipc	ra,0x3
    4a42:	b82080e7          	jalr	-1150(ra) # 75c0 <printf>
    exit(1);
    4a46:	4505                	li	a0,1
    4a48:	00002097          	auipc	ra,0x2
    4a4c:	632080e7          	jalr	1586(ra) # 707a <exit>
  }
  unlink("bigfile.dat");
    4a50:	00005517          	auipc	a0,0x5
    4a54:	e9050513          	addi	a0,a0,-368 # 98e0 <schedule_rm+0x1ae6>
    4a58:	00002097          	auipc	ra,0x2
    4a5c:	672080e7          	jalr	1650(ra) # 70ca <unlink>
}
    4a60:	0001                	nop
    4a62:	70a2                	ld	ra,40(sp)
    4a64:	7402                	ld	s0,32(sp)
    4a66:	6145                	addi	sp,sp,48
    4a68:	8082                	ret

0000000000004a6a <fourteen>:

void
fourteen(char *s)
{
    4a6a:	7179                	addi	sp,sp,-48
    4a6c:	f406                	sd	ra,40(sp)
    4a6e:	f022                	sd	s0,32(sp)
    4a70:	1800                	addi	s0,sp,48
    4a72:	fca43c23          	sd	a0,-40(s0)
  int fd;

  // DIRSIZ is 14.

  if(mkdir("12345678901234") != 0){
    4a76:	00005517          	auipc	a0,0x5
    4a7a:	f5250513          	addi	a0,a0,-174 # 99c8 <schedule_rm+0x1bce>
    4a7e:	00002097          	auipc	ra,0x2
    4a82:	664080e7          	jalr	1636(ra) # 70e2 <mkdir>
    4a86:	87aa                	mv	a5,a0
    4a88:	c385                	beqz	a5,4aa8 <fourteen+0x3e>
    printf("%s: mkdir 12345678901234 failed\n", s);
    4a8a:	fd843583          	ld	a1,-40(s0)
    4a8e:	00005517          	auipc	a0,0x5
    4a92:	f4a50513          	addi	a0,a0,-182 # 99d8 <schedule_rm+0x1bde>
    4a96:	00003097          	auipc	ra,0x3
    4a9a:	b2a080e7          	jalr	-1238(ra) # 75c0 <printf>
    exit(1);
    4a9e:	4505                	li	a0,1
    4aa0:	00002097          	auipc	ra,0x2
    4aa4:	5da080e7          	jalr	1498(ra) # 707a <exit>
  }
  if(mkdir("12345678901234/123456789012345") != 0){
    4aa8:	00005517          	auipc	a0,0x5
    4aac:	f5850513          	addi	a0,a0,-168 # 9a00 <schedule_rm+0x1c06>
    4ab0:	00002097          	auipc	ra,0x2
    4ab4:	632080e7          	jalr	1586(ra) # 70e2 <mkdir>
    4ab8:	87aa                	mv	a5,a0
    4aba:	c385                	beqz	a5,4ada <fourteen+0x70>
    printf("%s: mkdir 12345678901234/123456789012345 failed\n", s);
    4abc:	fd843583          	ld	a1,-40(s0)
    4ac0:	00005517          	auipc	a0,0x5
    4ac4:	f6050513          	addi	a0,a0,-160 # 9a20 <schedule_rm+0x1c26>
    4ac8:	00003097          	auipc	ra,0x3
    4acc:	af8080e7          	jalr	-1288(ra) # 75c0 <printf>
    exit(1);
    4ad0:	4505                	li	a0,1
    4ad2:	00002097          	auipc	ra,0x2
    4ad6:	5a8080e7          	jalr	1448(ra) # 707a <exit>
  }
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    4ada:	20000593          	li	a1,512
    4ade:	00005517          	auipc	a0,0x5
    4ae2:	f7a50513          	addi	a0,a0,-134 # 9a58 <schedule_rm+0x1c5e>
    4ae6:	00002097          	auipc	ra,0x2
    4aea:	5d4080e7          	jalr	1492(ra) # 70ba <open>
    4aee:	87aa                	mv	a5,a0
    4af0:	fef42623          	sw	a5,-20(s0)
  if(fd < 0){
    4af4:	fec42783          	lw	a5,-20(s0)
    4af8:	2781                	sext.w	a5,a5
    4afa:	0207d163          	bgez	a5,4b1c <fourteen+0xb2>
    printf("%s: create 123456789012345/123456789012345/123456789012345 failed\n", s);
    4afe:	fd843583          	ld	a1,-40(s0)
    4b02:	00005517          	auipc	a0,0x5
    4b06:	f8650513          	addi	a0,a0,-122 # 9a88 <schedule_rm+0x1c8e>
    4b0a:	00003097          	auipc	ra,0x3
    4b0e:	ab6080e7          	jalr	-1354(ra) # 75c0 <printf>
    exit(1);
    4b12:	4505                	li	a0,1
    4b14:	00002097          	auipc	ra,0x2
    4b18:	566080e7          	jalr	1382(ra) # 707a <exit>
  }
  close(fd);
    4b1c:	fec42783          	lw	a5,-20(s0)
    4b20:	853e                	mv	a0,a5
    4b22:	00002097          	auipc	ra,0x2
    4b26:	580080e7          	jalr	1408(ra) # 70a2 <close>
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    4b2a:	4581                	li	a1,0
    4b2c:	00005517          	auipc	a0,0x5
    4b30:	fa450513          	addi	a0,a0,-92 # 9ad0 <schedule_rm+0x1cd6>
    4b34:	00002097          	auipc	ra,0x2
    4b38:	586080e7          	jalr	1414(ra) # 70ba <open>
    4b3c:	87aa                	mv	a5,a0
    4b3e:	fef42623          	sw	a5,-20(s0)
  if(fd < 0){
    4b42:	fec42783          	lw	a5,-20(s0)
    4b46:	2781                	sext.w	a5,a5
    4b48:	0207d163          	bgez	a5,4b6a <fourteen+0x100>
    printf("%s: open 12345678901234/12345678901234/12345678901234 failed\n", s);
    4b4c:	fd843583          	ld	a1,-40(s0)
    4b50:	00005517          	auipc	a0,0x5
    4b54:	fb050513          	addi	a0,a0,-80 # 9b00 <schedule_rm+0x1d06>
    4b58:	00003097          	auipc	ra,0x3
    4b5c:	a68080e7          	jalr	-1432(ra) # 75c0 <printf>
    exit(1);
    4b60:	4505                	li	a0,1
    4b62:	00002097          	auipc	ra,0x2
    4b66:	518080e7          	jalr	1304(ra) # 707a <exit>
  }
  close(fd);
    4b6a:	fec42783          	lw	a5,-20(s0)
    4b6e:	853e                	mv	a0,a5
    4b70:	00002097          	auipc	ra,0x2
    4b74:	532080e7          	jalr	1330(ra) # 70a2 <close>

  if(mkdir("12345678901234/12345678901234") == 0){
    4b78:	00005517          	auipc	a0,0x5
    4b7c:	fc850513          	addi	a0,a0,-56 # 9b40 <schedule_rm+0x1d46>
    4b80:	00002097          	auipc	ra,0x2
    4b84:	562080e7          	jalr	1378(ra) # 70e2 <mkdir>
    4b88:	87aa                	mv	a5,a0
    4b8a:	e385                	bnez	a5,4baa <fourteen+0x140>
    printf("%s: mkdir 12345678901234/12345678901234 succeeded!\n", s);
    4b8c:	fd843583          	ld	a1,-40(s0)
    4b90:	00005517          	auipc	a0,0x5
    4b94:	fd050513          	addi	a0,a0,-48 # 9b60 <schedule_rm+0x1d66>
    4b98:	00003097          	auipc	ra,0x3
    4b9c:	a28080e7          	jalr	-1496(ra) # 75c0 <printf>
    exit(1);
    4ba0:	4505                	li	a0,1
    4ba2:	00002097          	auipc	ra,0x2
    4ba6:	4d8080e7          	jalr	1240(ra) # 707a <exit>
  }
  if(mkdir("123456789012345/12345678901234") == 0){
    4baa:	00005517          	auipc	a0,0x5
    4bae:	fee50513          	addi	a0,a0,-18 # 9b98 <schedule_rm+0x1d9e>
    4bb2:	00002097          	auipc	ra,0x2
    4bb6:	530080e7          	jalr	1328(ra) # 70e2 <mkdir>
    4bba:	87aa                	mv	a5,a0
    4bbc:	e385                	bnez	a5,4bdc <fourteen+0x172>
    printf("%s: mkdir 12345678901234/123456789012345 succeeded!\n", s);
    4bbe:	fd843583          	ld	a1,-40(s0)
    4bc2:	00005517          	auipc	a0,0x5
    4bc6:	ff650513          	addi	a0,a0,-10 # 9bb8 <schedule_rm+0x1dbe>
    4bca:	00003097          	auipc	ra,0x3
    4bce:	9f6080e7          	jalr	-1546(ra) # 75c0 <printf>
    exit(1);
    4bd2:	4505                	li	a0,1
    4bd4:	00002097          	auipc	ra,0x2
    4bd8:	4a6080e7          	jalr	1190(ra) # 707a <exit>
  }

  // clean up
  unlink("123456789012345/12345678901234");
    4bdc:	00005517          	auipc	a0,0x5
    4be0:	fbc50513          	addi	a0,a0,-68 # 9b98 <schedule_rm+0x1d9e>
    4be4:	00002097          	auipc	ra,0x2
    4be8:	4e6080e7          	jalr	1254(ra) # 70ca <unlink>
  unlink("12345678901234/12345678901234");
    4bec:	00005517          	auipc	a0,0x5
    4bf0:	f5450513          	addi	a0,a0,-172 # 9b40 <schedule_rm+0x1d46>
    4bf4:	00002097          	auipc	ra,0x2
    4bf8:	4d6080e7          	jalr	1238(ra) # 70ca <unlink>
  unlink("12345678901234/12345678901234/12345678901234");
    4bfc:	00005517          	auipc	a0,0x5
    4c00:	ed450513          	addi	a0,a0,-300 # 9ad0 <schedule_rm+0x1cd6>
    4c04:	00002097          	auipc	ra,0x2
    4c08:	4c6080e7          	jalr	1222(ra) # 70ca <unlink>
  unlink("123456789012345/123456789012345/123456789012345");
    4c0c:	00005517          	auipc	a0,0x5
    4c10:	e4c50513          	addi	a0,a0,-436 # 9a58 <schedule_rm+0x1c5e>
    4c14:	00002097          	auipc	ra,0x2
    4c18:	4b6080e7          	jalr	1206(ra) # 70ca <unlink>
  unlink("12345678901234/123456789012345");
    4c1c:	00005517          	auipc	a0,0x5
    4c20:	de450513          	addi	a0,a0,-540 # 9a00 <schedule_rm+0x1c06>
    4c24:	00002097          	auipc	ra,0x2
    4c28:	4a6080e7          	jalr	1190(ra) # 70ca <unlink>
  unlink("12345678901234");
    4c2c:	00005517          	auipc	a0,0x5
    4c30:	d9c50513          	addi	a0,a0,-612 # 99c8 <schedule_rm+0x1bce>
    4c34:	00002097          	auipc	ra,0x2
    4c38:	496080e7          	jalr	1174(ra) # 70ca <unlink>
}
    4c3c:	0001                	nop
    4c3e:	70a2                	ld	ra,40(sp)
    4c40:	7402                	ld	s0,32(sp)
    4c42:	6145                	addi	sp,sp,48
    4c44:	8082                	ret

0000000000004c46 <rmdot>:

void
rmdot(char *s)
{
    4c46:	1101                	addi	sp,sp,-32
    4c48:	ec06                	sd	ra,24(sp)
    4c4a:	e822                	sd	s0,16(sp)
    4c4c:	1000                	addi	s0,sp,32
    4c4e:	fea43423          	sd	a0,-24(s0)
  if(mkdir("dots") != 0){
    4c52:	00005517          	auipc	a0,0x5
    4c56:	f9e50513          	addi	a0,a0,-98 # 9bf0 <schedule_rm+0x1df6>
    4c5a:	00002097          	auipc	ra,0x2
    4c5e:	488080e7          	jalr	1160(ra) # 70e2 <mkdir>
    4c62:	87aa                	mv	a5,a0
    4c64:	c385                	beqz	a5,4c84 <rmdot+0x3e>
    printf("%s: mkdir dots failed\n", s);
    4c66:	fe843583          	ld	a1,-24(s0)
    4c6a:	00005517          	auipc	a0,0x5
    4c6e:	f8e50513          	addi	a0,a0,-114 # 9bf8 <schedule_rm+0x1dfe>
    4c72:	00003097          	auipc	ra,0x3
    4c76:	94e080e7          	jalr	-1714(ra) # 75c0 <printf>
    exit(1);
    4c7a:	4505                	li	a0,1
    4c7c:	00002097          	auipc	ra,0x2
    4c80:	3fe080e7          	jalr	1022(ra) # 707a <exit>
  }
  if(chdir("dots") != 0){
    4c84:	00005517          	auipc	a0,0x5
    4c88:	f6c50513          	addi	a0,a0,-148 # 9bf0 <schedule_rm+0x1df6>
    4c8c:	00002097          	auipc	ra,0x2
    4c90:	45e080e7          	jalr	1118(ra) # 70ea <chdir>
    4c94:	87aa                	mv	a5,a0
    4c96:	c385                	beqz	a5,4cb6 <rmdot+0x70>
    printf("%s: chdir dots failed\n", s);
    4c98:	fe843583          	ld	a1,-24(s0)
    4c9c:	00005517          	auipc	a0,0x5
    4ca0:	f7450513          	addi	a0,a0,-140 # 9c10 <schedule_rm+0x1e16>
    4ca4:	00003097          	auipc	ra,0x3
    4ca8:	91c080e7          	jalr	-1764(ra) # 75c0 <printf>
    exit(1);
    4cac:	4505                	li	a0,1
    4cae:	00002097          	auipc	ra,0x2
    4cb2:	3cc080e7          	jalr	972(ra) # 707a <exit>
  }
  if(unlink(".") == 0){
    4cb6:	00004517          	auipc	a0,0x4
    4cba:	52250513          	addi	a0,a0,1314 # 91d8 <schedule_rm+0x13de>
    4cbe:	00002097          	auipc	ra,0x2
    4cc2:	40c080e7          	jalr	1036(ra) # 70ca <unlink>
    4cc6:	87aa                	mv	a5,a0
    4cc8:	e385                	bnez	a5,4ce8 <rmdot+0xa2>
    printf("%s: rm . worked!\n", s);
    4cca:	fe843583          	ld	a1,-24(s0)
    4cce:	00005517          	auipc	a0,0x5
    4cd2:	f5a50513          	addi	a0,a0,-166 # 9c28 <schedule_rm+0x1e2e>
    4cd6:	00003097          	auipc	ra,0x3
    4cda:	8ea080e7          	jalr	-1814(ra) # 75c0 <printf>
    exit(1);
    4cde:	4505                	li	a0,1
    4ce0:	00002097          	auipc	ra,0x2
    4ce4:	39a080e7          	jalr	922(ra) # 707a <exit>
  }
  if(unlink("..") == 0){
    4ce8:	00004517          	auipc	a0,0x4
    4cec:	fa850513          	addi	a0,a0,-88 # 8c90 <schedule_rm+0xe96>
    4cf0:	00002097          	auipc	ra,0x2
    4cf4:	3da080e7          	jalr	986(ra) # 70ca <unlink>
    4cf8:	87aa                	mv	a5,a0
    4cfa:	e385                	bnez	a5,4d1a <rmdot+0xd4>
    printf("%s: rm .. worked!\n", s);
    4cfc:	fe843583          	ld	a1,-24(s0)
    4d00:	00005517          	auipc	a0,0x5
    4d04:	f4050513          	addi	a0,a0,-192 # 9c40 <schedule_rm+0x1e46>
    4d08:	00003097          	auipc	ra,0x3
    4d0c:	8b8080e7          	jalr	-1864(ra) # 75c0 <printf>
    exit(1);
    4d10:	4505                	li	a0,1
    4d12:	00002097          	auipc	ra,0x2
    4d16:	368080e7          	jalr	872(ra) # 707a <exit>
  }
  if(chdir("/") != 0){
    4d1a:	00004517          	auipc	a0,0x4
    4d1e:	c8e50513          	addi	a0,a0,-882 # 89a8 <schedule_rm+0xbae>
    4d22:	00002097          	auipc	ra,0x2
    4d26:	3c8080e7          	jalr	968(ra) # 70ea <chdir>
    4d2a:	87aa                	mv	a5,a0
    4d2c:	c385                	beqz	a5,4d4c <rmdot+0x106>
    printf("%s: chdir / failed\n", s);
    4d2e:	fe843583          	ld	a1,-24(s0)
    4d32:	00004517          	auipc	a0,0x4
    4d36:	c7e50513          	addi	a0,a0,-898 # 89b0 <schedule_rm+0xbb6>
    4d3a:	00003097          	auipc	ra,0x3
    4d3e:	886080e7          	jalr	-1914(ra) # 75c0 <printf>
    exit(1);
    4d42:	4505                	li	a0,1
    4d44:	00002097          	auipc	ra,0x2
    4d48:	336080e7          	jalr	822(ra) # 707a <exit>
  }
  if(unlink("dots/.") == 0){
    4d4c:	00005517          	auipc	a0,0x5
    4d50:	f0c50513          	addi	a0,a0,-244 # 9c58 <schedule_rm+0x1e5e>
    4d54:	00002097          	auipc	ra,0x2
    4d58:	376080e7          	jalr	886(ra) # 70ca <unlink>
    4d5c:	87aa                	mv	a5,a0
    4d5e:	e385                	bnez	a5,4d7e <rmdot+0x138>
    printf("%s: unlink dots/. worked!\n", s);
    4d60:	fe843583          	ld	a1,-24(s0)
    4d64:	00005517          	auipc	a0,0x5
    4d68:	efc50513          	addi	a0,a0,-260 # 9c60 <schedule_rm+0x1e66>
    4d6c:	00003097          	auipc	ra,0x3
    4d70:	854080e7          	jalr	-1964(ra) # 75c0 <printf>
    exit(1);
    4d74:	4505                	li	a0,1
    4d76:	00002097          	auipc	ra,0x2
    4d7a:	304080e7          	jalr	772(ra) # 707a <exit>
  }
  if(unlink("dots/..") == 0){
    4d7e:	00005517          	auipc	a0,0x5
    4d82:	f0250513          	addi	a0,a0,-254 # 9c80 <schedule_rm+0x1e86>
    4d86:	00002097          	auipc	ra,0x2
    4d8a:	344080e7          	jalr	836(ra) # 70ca <unlink>
    4d8e:	87aa                	mv	a5,a0
    4d90:	e385                	bnez	a5,4db0 <rmdot+0x16a>
    printf("%s: unlink dots/.. worked!\n", s);
    4d92:	fe843583          	ld	a1,-24(s0)
    4d96:	00005517          	auipc	a0,0x5
    4d9a:	ef250513          	addi	a0,a0,-270 # 9c88 <schedule_rm+0x1e8e>
    4d9e:	00003097          	auipc	ra,0x3
    4da2:	822080e7          	jalr	-2014(ra) # 75c0 <printf>
    exit(1);
    4da6:	4505                	li	a0,1
    4da8:	00002097          	auipc	ra,0x2
    4dac:	2d2080e7          	jalr	722(ra) # 707a <exit>
  }
  if(unlink("dots") != 0){
    4db0:	00005517          	auipc	a0,0x5
    4db4:	e4050513          	addi	a0,a0,-448 # 9bf0 <schedule_rm+0x1df6>
    4db8:	00002097          	auipc	ra,0x2
    4dbc:	312080e7          	jalr	786(ra) # 70ca <unlink>
    4dc0:	87aa                	mv	a5,a0
    4dc2:	c385                	beqz	a5,4de2 <rmdot+0x19c>
    printf("%s: unlink dots failed!\n", s);
    4dc4:	fe843583          	ld	a1,-24(s0)
    4dc8:	00005517          	auipc	a0,0x5
    4dcc:	ee050513          	addi	a0,a0,-288 # 9ca8 <schedule_rm+0x1eae>
    4dd0:	00002097          	auipc	ra,0x2
    4dd4:	7f0080e7          	jalr	2032(ra) # 75c0 <printf>
    exit(1);
    4dd8:	4505                	li	a0,1
    4dda:	00002097          	auipc	ra,0x2
    4dde:	2a0080e7          	jalr	672(ra) # 707a <exit>
  }
}
    4de2:	0001                	nop
    4de4:	60e2                	ld	ra,24(sp)
    4de6:	6442                	ld	s0,16(sp)
    4de8:	6105                	addi	sp,sp,32
    4dea:	8082                	ret

0000000000004dec <dirfile>:

void
dirfile(char *s)
{
    4dec:	7179                	addi	sp,sp,-48
    4dee:	f406                	sd	ra,40(sp)
    4df0:	f022                	sd	s0,32(sp)
    4df2:	1800                	addi	s0,sp,48
    4df4:	fca43c23          	sd	a0,-40(s0)
  int fd;

  fd = open("dirfile", O_CREATE);
    4df8:	20000593          	li	a1,512
    4dfc:	00003517          	auipc	a0,0x3
    4e00:	65450513          	addi	a0,a0,1620 # 8450 <schedule_rm+0x656>
    4e04:	00002097          	auipc	ra,0x2
    4e08:	2b6080e7          	jalr	694(ra) # 70ba <open>
    4e0c:	87aa                	mv	a5,a0
    4e0e:	fef42623          	sw	a5,-20(s0)
  if(fd < 0){
    4e12:	fec42783          	lw	a5,-20(s0)
    4e16:	2781                	sext.w	a5,a5
    4e18:	0207d163          	bgez	a5,4e3a <dirfile+0x4e>
    printf("%s: create dirfile failed\n", s);
    4e1c:	fd843583          	ld	a1,-40(s0)
    4e20:	00005517          	auipc	a0,0x5
    4e24:	ea850513          	addi	a0,a0,-344 # 9cc8 <schedule_rm+0x1ece>
    4e28:	00002097          	auipc	ra,0x2
    4e2c:	798080e7          	jalr	1944(ra) # 75c0 <printf>
    exit(1);
    4e30:	4505                	li	a0,1
    4e32:	00002097          	auipc	ra,0x2
    4e36:	248080e7          	jalr	584(ra) # 707a <exit>
  }
  close(fd);
    4e3a:	fec42783          	lw	a5,-20(s0)
    4e3e:	853e                	mv	a0,a5
    4e40:	00002097          	auipc	ra,0x2
    4e44:	262080e7          	jalr	610(ra) # 70a2 <close>
  if(chdir("dirfile") == 0){
    4e48:	00003517          	auipc	a0,0x3
    4e4c:	60850513          	addi	a0,a0,1544 # 8450 <schedule_rm+0x656>
    4e50:	00002097          	auipc	ra,0x2
    4e54:	29a080e7          	jalr	666(ra) # 70ea <chdir>
    4e58:	87aa                	mv	a5,a0
    4e5a:	e385                	bnez	a5,4e7a <dirfile+0x8e>
    printf("%s: chdir dirfile succeeded!\n", s);
    4e5c:	fd843583          	ld	a1,-40(s0)
    4e60:	00005517          	auipc	a0,0x5
    4e64:	e8850513          	addi	a0,a0,-376 # 9ce8 <schedule_rm+0x1eee>
    4e68:	00002097          	auipc	ra,0x2
    4e6c:	758080e7          	jalr	1880(ra) # 75c0 <printf>
    exit(1);
    4e70:	4505                	li	a0,1
    4e72:	00002097          	auipc	ra,0x2
    4e76:	208080e7          	jalr	520(ra) # 707a <exit>
  }
  fd = open("dirfile/xx", 0);
    4e7a:	4581                	li	a1,0
    4e7c:	00005517          	auipc	a0,0x5
    4e80:	e8c50513          	addi	a0,a0,-372 # 9d08 <schedule_rm+0x1f0e>
    4e84:	00002097          	auipc	ra,0x2
    4e88:	236080e7          	jalr	566(ra) # 70ba <open>
    4e8c:	87aa                	mv	a5,a0
    4e8e:	fef42623          	sw	a5,-20(s0)
  if(fd >= 0){
    4e92:	fec42783          	lw	a5,-20(s0)
    4e96:	2781                	sext.w	a5,a5
    4e98:	0207c163          	bltz	a5,4eba <dirfile+0xce>
    printf("%s: create dirfile/xx succeeded!\n", s);
    4e9c:	fd843583          	ld	a1,-40(s0)
    4ea0:	00005517          	auipc	a0,0x5
    4ea4:	e7850513          	addi	a0,a0,-392 # 9d18 <schedule_rm+0x1f1e>
    4ea8:	00002097          	auipc	ra,0x2
    4eac:	718080e7          	jalr	1816(ra) # 75c0 <printf>
    exit(1);
    4eb0:	4505                	li	a0,1
    4eb2:	00002097          	auipc	ra,0x2
    4eb6:	1c8080e7          	jalr	456(ra) # 707a <exit>
  }
  fd = open("dirfile/xx", O_CREATE);
    4eba:	20000593          	li	a1,512
    4ebe:	00005517          	auipc	a0,0x5
    4ec2:	e4a50513          	addi	a0,a0,-438 # 9d08 <schedule_rm+0x1f0e>
    4ec6:	00002097          	auipc	ra,0x2
    4eca:	1f4080e7          	jalr	500(ra) # 70ba <open>
    4ece:	87aa                	mv	a5,a0
    4ed0:	fef42623          	sw	a5,-20(s0)
  if(fd >= 0){
    4ed4:	fec42783          	lw	a5,-20(s0)
    4ed8:	2781                	sext.w	a5,a5
    4eda:	0207c163          	bltz	a5,4efc <dirfile+0x110>
    printf("%s: create dirfile/xx succeeded!\n", s);
    4ede:	fd843583          	ld	a1,-40(s0)
    4ee2:	00005517          	auipc	a0,0x5
    4ee6:	e3650513          	addi	a0,a0,-458 # 9d18 <schedule_rm+0x1f1e>
    4eea:	00002097          	auipc	ra,0x2
    4eee:	6d6080e7          	jalr	1750(ra) # 75c0 <printf>
    exit(1);
    4ef2:	4505                	li	a0,1
    4ef4:	00002097          	auipc	ra,0x2
    4ef8:	186080e7          	jalr	390(ra) # 707a <exit>
  }
  if(mkdir("dirfile/xx") == 0){
    4efc:	00005517          	auipc	a0,0x5
    4f00:	e0c50513          	addi	a0,a0,-500 # 9d08 <schedule_rm+0x1f0e>
    4f04:	00002097          	auipc	ra,0x2
    4f08:	1de080e7          	jalr	478(ra) # 70e2 <mkdir>
    4f0c:	87aa                	mv	a5,a0
    4f0e:	e385                	bnez	a5,4f2e <dirfile+0x142>
    printf("%s: mkdir dirfile/xx succeeded!\n", s);
    4f10:	fd843583          	ld	a1,-40(s0)
    4f14:	00005517          	auipc	a0,0x5
    4f18:	e2c50513          	addi	a0,a0,-468 # 9d40 <schedule_rm+0x1f46>
    4f1c:	00002097          	auipc	ra,0x2
    4f20:	6a4080e7          	jalr	1700(ra) # 75c0 <printf>
    exit(1);
    4f24:	4505                	li	a0,1
    4f26:	00002097          	auipc	ra,0x2
    4f2a:	154080e7          	jalr	340(ra) # 707a <exit>
  }
  if(unlink("dirfile/xx") == 0){
    4f2e:	00005517          	auipc	a0,0x5
    4f32:	dda50513          	addi	a0,a0,-550 # 9d08 <schedule_rm+0x1f0e>
    4f36:	00002097          	auipc	ra,0x2
    4f3a:	194080e7          	jalr	404(ra) # 70ca <unlink>
    4f3e:	87aa                	mv	a5,a0
    4f40:	e385                	bnez	a5,4f60 <dirfile+0x174>
    printf("%s: unlink dirfile/xx succeeded!\n", s);
    4f42:	fd843583          	ld	a1,-40(s0)
    4f46:	00005517          	auipc	a0,0x5
    4f4a:	e2250513          	addi	a0,a0,-478 # 9d68 <schedule_rm+0x1f6e>
    4f4e:	00002097          	auipc	ra,0x2
    4f52:	672080e7          	jalr	1650(ra) # 75c0 <printf>
    exit(1);
    4f56:	4505                	li	a0,1
    4f58:	00002097          	auipc	ra,0x2
    4f5c:	122080e7          	jalr	290(ra) # 707a <exit>
  }
  if(link("README", "dirfile/xx") == 0){
    4f60:	00005597          	auipc	a1,0x5
    4f64:	da858593          	addi	a1,a1,-600 # 9d08 <schedule_rm+0x1f0e>
    4f68:	00003517          	auipc	a0,0x3
    4f6c:	5d050513          	addi	a0,a0,1488 # 8538 <schedule_rm+0x73e>
    4f70:	00002097          	auipc	ra,0x2
    4f74:	16a080e7          	jalr	362(ra) # 70da <link>
    4f78:	87aa                	mv	a5,a0
    4f7a:	e385                	bnez	a5,4f9a <dirfile+0x1ae>
    printf("%s: link to dirfile/xx succeeded!\n", s);
    4f7c:	fd843583          	ld	a1,-40(s0)
    4f80:	00005517          	auipc	a0,0x5
    4f84:	e1050513          	addi	a0,a0,-496 # 9d90 <schedule_rm+0x1f96>
    4f88:	00002097          	auipc	ra,0x2
    4f8c:	638080e7          	jalr	1592(ra) # 75c0 <printf>
    exit(1);
    4f90:	4505                	li	a0,1
    4f92:	00002097          	auipc	ra,0x2
    4f96:	0e8080e7          	jalr	232(ra) # 707a <exit>
  }
  if(unlink("dirfile") != 0){
    4f9a:	00003517          	auipc	a0,0x3
    4f9e:	4b650513          	addi	a0,a0,1206 # 8450 <schedule_rm+0x656>
    4fa2:	00002097          	auipc	ra,0x2
    4fa6:	128080e7          	jalr	296(ra) # 70ca <unlink>
    4faa:	87aa                	mv	a5,a0
    4fac:	c385                	beqz	a5,4fcc <dirfile+0x1e0>
    printf("%s: unlink dirfile failed!\n", s);
    4fae:	fd843583          	ld	a1,-40(s0)
    4fb2:	00005517          	auipc	a0,0x5
    4fb6:	e0650513          	addi	a0,a0,-506 # 9db8 <schedule_rm+0x1fbe>
    4fba:	00002097          	auipc	ra,0x2
    4fbe:	606080e7          	jalr	1542(ra) # 75c0 <printf>
    exit(1);
    4fc2:	4505                	li	a0,1
    4fc4:	00002097          	auipc	ra,0x2
    4fc8:	0b6080e7          	jalr	182(ra) # 707a <exit>
  }

  fd = open(".", O_RDWR);
    4fcc:	4589                	li	a1,2
    4fce:	00004517          	auipc	a0,0x4
    4fd2:	20a50513          	addi	a0,a0,522 # 91d8 <schedule_rm+0x13de>
    4fd6:	00002097          	auipc	ra,0x2
    4fda:	0e4080e7          	jalr	228(ra) # 70ba <open>
    4fde:	87aa                	mv	a5,a0
    4fe0:	fef42623          	sw	a5,-20(s0)
  if(fd >= 0){
    4fe4:	fec42783          	lw	a5,-20(s0)
    4fe8:	2781                	sext.w	a5,a5
    4fea:	0207c163          	bltz	a5,500c <dirfile+0x220>
    printf("%s: open . for writing succeeded!\n", s);
    4fee:	fd843583          	ld	a1,-40(s0)
    4ff2:	00005517          	auipc	a0,0x5
    4ff6:	de650513          	addi	a0,a0,-538 # 9dd8 <schedule_rm+0x1fde>
    4ffa:	00002097          	auipc	ra,0x2
    4ffe:	5c6080e7          	jalr	1478(ra) # 75c0 <printf>
    exit(1);
    5002:	4505                	li	a0,1
    5004:	00002097          	auipc	ra,0x2
    5008:	076080e7          	jalr	118(ra) # 707a <exit>
  }
  fd = open(".", 0);
    500c:	4581                	li	a1,0
    500e:	00004517          	auipc	a0,0x4
    5012:	1ca50513          	addi	a0,a0,458 # 91d8 <schedule_rm+0x13de>
    5016:	00002097          	auipc	ra,0x2
    501a:	0a4080e7          	jalr	164(ra) # 70ba <open>
    501e:	87aa                	mv	a5,a0
    5020:	fef42623          	sw	a5,-20(s0)
  if(write(fd, "x", 1) > 0){
    5024:	fec42783          	lw	a5,-20(s0)
    5028:	4605                	li	a2,1
    502a:	00003597          	auipc	a1,0x3
    502e:	55e58593          	addi	a1,a1,1374 # 8588 <schedule_rm+0x78e>
    5032:	853e                	mv	a0,a5
    5034:	00002097          	auipc	ra,0x2
    5038:	066080e7          	jalr	102(ra) # 709a <write>
    503c:	87aa                	mv	a5,a0
    503e:	02f05163          	blez	a5,5060 <dirfile+0x274>
    printf("%s: write . succeeded!\n", s);
    5042:	fd843583          	ld	a1,-40(s0)
    5046:	00005517          	auipc	a0,0x5
    504a:	dba50513          	addi	a0,a0,-582 # 9e00 <schedule_rm+0x2006>
    504e:	00002097          	auipc	ra,0x2
    5052:	572080e7          	jalr	1394(ra) # 75c0 <printf>
    exit(1);
    5056:	4505                	li	a0,1
    5058:	00002097          	auipc	ra,0x2
    505c:	022080e7          	jalr	34(ra) # 707a <exit>
  }
  close(fd);
    5060:	fec42783          	lw	a5,-20(s0)
    5064:	853e                	mv	a0,a5
    5066:	00002097          	auipc	ra,0x2
    506a:	03c080e7          	jalr	60(ra) # 70a2 <close>
}
    506e:	0001                	nop
    5070:	70a2                	ld	ra,40(sp)
    5072:	7402                	ld	s0,32(sp)
    5074:	6145                	addi	sp,sp,48
    5076:	8082                	ret

0000000000005078 <iref>:

// test that iput() is called at the end of _namei().
// also tests empty file names.
void
iref(char *s)
{
    5078:	7179                	addi	sp,sp,-48
    507a:	f406                	sd	ra,40(sp)
    507c:	f022                	sd	s0,32(sp)
    507e:	1800                	addi	s0,sp,48
    5080:	fca43c23          	sd	a0,-40(s0)
  int i, fd;

  for(i = 0; i < NINODE + 1; i++){
    5084:	fe042623          	sw	zero,-20(s0)
    5088:	a231                	j	5194 <iref+0x11c>
    if(mkdir("irefd") != 0){
    508a:	00005517          	auipc	a0,0x5
    508e:	d8e50513          	addi	a0,a0,-626 # 9e18 <schedule_rm+0x201e>
    5092:	00002097          	auipc	ra,0x2
    5096:	050080e7          	jalr	80(ra) # 70e2 <mkdir>
    509a:	87aa                	mv	a5,a0
    509c:	c385                	beqz	a5,50bc <iref+0x44>
      printf("%s: mkdir irefd failed\n", s);
    509e:	fd843583          	ld	a1,-40(s0)
    50a2:	00005517          	auipc	a0,0x5
    50a6:	d7e50513          	addi	a0,a0,-642 # 9e20 <schedule_rm+0x2026>
    50aa:	00002097          	auipc	ra,0x2
    50ae:	516080e7          	jalr	1302(ra) # 75c0 <printf>
      exit(1);
    50b2:	4505                	li	a0,1
    50b4:	00002097          	auipc	ra,0x2
    50b8:	fc6080e7          	jalr	-58(ra) # 707a <exit>
    }
    if(chdir("irefd") != 0){
    50bc:	00005517          	auipc	a0,0x5
    50c0:	d5c50513          	addi	a0,a0,-676 # 9e18 <schedule_rm+0x201e>
    50c4:	00002097          	auipc	ra,0x2
    50c8:	026080e7          	jalr	38(ra) # 70ea <chdir>
    50cc:	87aa                	mv	a5,a0
    50ce:	c385                	beqz	a5,50ee <iref+0x76>
      printf("%s: chdir irefd failed\n", s);
    50d0:	fd843583          	ld	a1,-40(s0)
    50d4:	00005517          	auipc	a0,0x5
    50d8:	d6450513          	addi	a0,a0,-668 # 9e38 <schedule_rm+0x203e>
    50dc:	00002097          	auipc	ra,0x2
    50e0:	4e4080e7          	jalr	1252(ra) # 75c0 <printf>
      exit(1);
    50e4:	4505                	li	a0,1
    50e6:	00002097          	auipc	ra,0x2
    50ea:	f94080e7          	jalr	-108(ra) # 707a <exit>
    }

    mkdir("");
    50ee:	00005517          	auipc	a0,0x5
    50f2:	d6250513          	addi	a0,a0,-670 # 9e50 <schedule_rm+0x2056>
    50f6:	00002097          	auipc	ra,0x2
    50fa:	fec080e7          	jalr	-20(ra) # 70e2 <mkdir>
    link("README", "");
    50fe:	00005597          	auipc	a1,0x5
    5102:	d5258593          	addi	a1,a1,-686 # 9e50 <schedule_rm+0x2056>
    5106:	00003517          	auipc	a0,0x3
    510a:	43250513          	addi	a0,a0,1074 # 8538 <schedule_rm+0x73e>
    510e:	00002097          	auipc	ra,0x2
    5112:	fcc080e7          	jalr	-52(ra) # 70da <link>
    fd = open("", O_CREATE);
    5116:	20000593          	li	a1,512
    511a:	00005517          	auipc	a0,0x5
    511e:	d3650513          	addi	a0,a0,-714 # 9e50 <schedule_rm+0x2056>
    5122:	00002097          	auipc	ra,0x2
    5126:	f98080e7          	jalr	-104(ra) # 70ba <open>
    512a:	87aa                	mv	a5,a0
    512c:	fef42423          	sw	a5,-24(s0)
    if(fd >= 0)
    5130:	fe842783          	lw	a5,-24(s0)
    5134:	2781                	sext.w	a5,a5
    5136:	0007c963          	bltz	a5,5148 <iref+0xd0>
      close(fd);
    513a:	fe842783          	lw	a5,-24(s0)
    513e:	853e                	mv	a0,a5
    5140:	00002097          	auipc	ra,0x2
    5144:	f62080e7          	jalr	-158(ra) # 70a2 <close>
    fd = open("xx", O_CREATE);
    5148:	20000593          	li	a1,512
    514c:	00003517          	auipc	a0,0x3
    5150:	51450513          	addi	a0,a0,1300 # 8660 <schedule_rm+0x866>
    5154:	00002097          	auipc	ra,0x2
    5158:	f66080e7          	jalr	-154(ra) # 70ba <open>
    515c:	87aa                	mv	a5,a0
    515e:	fef42423          	sw	a5,-24(s0)
    if(fd >= 0)
    5162:	fe842783          	lw	a5,-24(s0)
    5166:	2781                	sext.w	a5,a5
    5168:	0007c963          	bltz	a5,517a <iref+0x102>
      close(fd);
    516c:	fe842783          	lw	a5,-24(s0)
    5170:	853e                	mv	a0,a5
    5172:	00002097          	auipc	ra,0x2
    5176:	f30080e7          	jalr	-208(ra) # 70a2 <close>
    unlink("xx");
    517a:	00003517          	auipc	a0,0x3
    517e:	4e650513          	addi	a0,a0,1254 # 8660 <schedule_rm+0x866>
    5182:	00002097          	auipc	ra,0x2
    5186:	f48080e7          	jalr	-184(ra) # 70ca <unlink>
  for(i = 0; i < NINODE + 1; i++){
    518a:	fec42783          	lw	a5,-20(s0)
    518e:	2785                	addiw	a5,a5,1
    5190:	fef42623          	sw	a5,-20(s0)
    5194:	fec42783          	lw	a5,-20(s0)
    5198:	0007871b          	sext.w	a4,a5
    519c:	03200793          	li	a5,50
    51a0:	eee7d5e3          	bge	a5,a4,508a <iref+0x12>
  }

  // clean up
  for(i = 0; i < NINODE + 1; i++){
    51a4:	fe042623          	sw	zero,-20(s0)
    51a8:	a035                	j	51d4 <iref+0x15c>
    chdir("..");
    51aa:	00004517          	auipc	a0,0x4
    51ae:	ae650513          	addi	a0,a0,-1306 # 8c90 <schedule_rm+0xe96>
    51b2:	00002097          	auipc	ra,0x2
    51b6:	f38080e7          	jalr	-200(ra) # 70ea <chdir>
    unlink("irefd");
    51ba:	00005517          	auipc	a0,0x5
    51be:	c5e50513          	addi	a0,a0,-930 # 9e18 <schedule_rm+0x201e>
    51c2:	00002097          	auipc	ra,0x2
    51c6:	f08080e7          	jalr	-248(ra) # 70ca <unlink>
  for(i = 0; i < NINODE + 1; i++){
    51ca:	fec42783          	lw	a5,-20(s0)
    51ce:	2785                	addiw	a5,a5,1
    51d0:	fef42623          	sw	a5,-20(s0)
    51d4:	fec42783          	lw	a5,-20(s0)
    51d8:	0007871b          	sext.w	a4,a5
    51dc:	03200793          	li	a5,50
    51e0:	fce7d5e3          	bge	a5,a4,51aa <iref+0x132>
  }

  chdir("/");
    51e4:	00003517          	auipc	a0,0x3
    51e8:	7c450513          	addi	a0,a0,1988 # 89a8 <schedule_rm+0xbae>
    51ec:	00002097          	auipc	ra,0x2
    51f0:	efe080e7          	jalr	-258(ra) # 70ea <chdir>
}
    51f4:	0001                	nop
    51f6:	70a2                	ld	ra,40(sp)
    51f8:	7402                	ld	s0,32(sp)
    51fa:	6145                	addi	sp,sp,48
    51fc:	8082                	ret

00000000000051fe <forktest>:
// test that fork fails gracefully
// the forktest binary also does this, but it runs out of proc entries first.
// inside the bigger usertests binary, we run out of memory first.
void
forktest(char *s)
{
    51fe:	7179                	addi	sp,sp,-48
    5200:	f406                	sd	ra,40(sp)
    5202:	f022                	sd	s0,32(sp)
    5204:	1800                	addi	s0,sp,48
    5206:	fca43c23          	sd	a0,-40(s0)
  enum{ N = 1000 };
  int n, pid;

  for(n=0; n<N; n++){
    520a:	fe042623          	sw	zero,-20(s0)
    520e:	a81d                	j	5244 <forktest+0x46>
    pid = fork();
    5210:	00002097          	auipc	ra,0x2
    5214:	e62080e7          	jalr	-414(ra) # 7072 <fork>
    5218:	87aa                	mv	a5,a0
    521a:	fef42423          	sw	a5,-24(s0)
    if(pid < 0)
    521e:	fe842783          	lw	a5,-24(s0)
    5222:	2781                	sext.w	a5,a5
    5224:	0207c963          	bltz	a5,5256 <forktest+0x58>
      break;
    if(pid == 0)
    5228:	fe842783          	lw	a5,-24(s0)
    522c:	2781                	sext.w	a5,a5
    522e:	e791                	bnez	a5,523a <forktest+0x3c>
      exit(0);
    5230:	4501                	li	a0,0
    5232:	00002097          	auipc	ra,0x2
    5236:	e48080e7          	jalr	-440(ra) # 707a <exit>
  for(n=0; n<N; n++){
    523a:	fec42783          	lw	a5,-20(s0)
    523e:	2785                	addiw	a5,a5,1
    5240:	fef42623          	sw	a5,-20(s0)
    5244:	fec42783          	lw	a5,-20(s0)
    5248:	0007871b          	sext.w	a4,a5
    524c:	3e700793          	li	a5,999
    5250:	fce7d0e3          	bge	a5,a4,5210 <forktest+0x12>
    5254:	a011                	j	5258 <forktest+0x5a>
      break;
    5256:	0001                	nop
  }

  if (n == 0) {
    5258:	fec42783          	lw	a5,-20(s0)
    525c:	2781                	sext.w	a5,a5
    525e:	e385                	bnez	a5,527e <forktest+0x80>
    printf("%s: no fork at all!\n", s);
    5260:	fd843583          	ld	a1,-40(s0)
    5264:	00005517          	auipc	a0,0x5
    5268:	bf450513          	addi	a0,a0,-1036 # 9e58 <schedule_rm+0x205e>
    526c:	00002097          	auipc	ra,0x2
    5270:	354080e7          	jalr	852(ra) # 75c0 <printf>
    exit(1);
    5274:	4505                	li	a0,1
    5276:	00002097          	auipc	ra,0x2
    527a:	e04080e7          	jalr	-508(ra) # 707a <exit>
  }

  if(n == N){
    527e:	fec42783          	lw	a5,-20(s0)
    5282:	0007871b          	sext.w	a4,a5
    5286:	3e800793          	li	a5,1000
    528a:	04f71d63          	bne	a4,a5,52e4 <forktest+0xe6>
    printf("%s: fork claimed to work 1000 times!\n", s);
    528e:	fd843583          	ld	a1,-40(s0)
    5292:	00005517          	auipc	a0,0x5
    5296:	bde50513          	addi	a0,a0,-1058 # 9e70 <schedule_rm+0x2076>
    529a:	00002097          	auipc	ra,0x2
    529e:	326080e7          	jalr	806(ra) # 75c0 <printf>
    exit(1);
    52a2:	4505                	li	a0,1
    52a4:	00002097          	auipc	ra,0x2
    52a8:	dd6080e7          	jalr	-554(ra) # 707a <exit>
  }

  for(; n > 0; n--){
    if(wait(0) < 0){
    52ac:	4501                	li	a0,0
    52ae:	00002097          	auipc	ra,0x2
    52b2:	dd4080e7          	jalr	-556(ra) # 7082 <wait>
    52b6:	87aa                	mv	a5,a0
    52b8:	0207d163          	bgez	a5,52da <forktest+0xdc>
      printf("%s: wait stopped early\n", s);
    52bc:	fd843583          	ld	a1,-40(s0)
    52c0:	00005517          	auipc	a0,0x5
    52c4:	bd850513          	addi	a0,a0,-1064 # 9e98 <schedule_rm+0x209e>
    52c8:	00002097          	auipc	ra,0x2
    52cc:	2f8080e7          	jalr	760(ra) # 75c0 <printf>
      exit(1);
    52d0:	4505                	li	a0,1
    52d2:	00002097          	auipc	ra,0x2
    52d6:	da8080e7          	jalr	-600(ra) # 707a <exit>
  for(; n > 0; n--){
    52da:	fec42783          	lw	a5,-20(s0)
    52de:	37fd                	addiw	a5,a5,-1
    52e0:	fef42623          	sw	a5,-20(s0)
    52e4:	fec42783          	lw	a5,-20(s0)
    52e8:	2781                	sext.w	a5,a5
    52ea:	fcf041e3          	bgtz	a5,52ac <forktest+0xae>
    }
  }

  if(wait(0) != -1){
    52ee:	4501                	li	a0,0
    52f0:	00002097          	auipc	ra,0x2
    52f4:	d92080e7          	jalr	-622(ra) # 7082 <wait>
    52f8:	87aa                	mv	a5,a0
    52fa:	873e                	mv	a4,a5
    52fc:	57fd                	li	a5,-1
    52fe:	02f70163          	beq	a4,a5,5320 <forktest+0x122>
    printf("%s: wait got too many\n", s);
    5302:	fd843583          	ld	a1,-40(s0)
    5306:	00005517          	auipc	a0,0x5
    530a:	baa50513          	addi	a0,a0,-1110 # 9eb0 <schedule_rm+0x20b6>
    530e:	00002097          	auipc	ra,0x2
    5312:	2b2080e7          	jalr	690(ra) # 75c0 <printf>
    exit(1);
    5316:	4505                	li	a0,1
    5318:	00002097          	auipc	ra,0x2
    531c:	d62080e7          	jalr	-670(ra) # 707a <exit>
  }
}
    5320:	0001                	nop
    5322:	70a2                	ld	ra,40(sp)
    5324:	7402                	ld	s0,32(sp)
    5326:	6145                	addi	sp,sp,48
    5328:	8082                	ret

000000000000532a <sbrkbasic>:

void
sbrkbasic(char *s)
{
    532a:	715d                	addi	sp,sp,-80
    532c:	e486                	sd	ra,72(sp)
    532e:	e0a2                	sd	s0,64(sp)
    5330:	0880                	addi	s0,sp,80
    5332:	faa43c23          	sd	a0,-72(s0)
  enum { TOOMUCH=1024*1024*1024};
  int i, pid, xstatus;
  char *c, *a, *b;

  // does sbrk() return the expected failure value?
  pid = fork();
    5336:	00002097          	auipc	ra,0x2
    533a:	d3c080e7          	jalr	-708(ra) # 7072 <fork>
    533e:	87aa                	mv	a5,a0
    5340:	fcf42a23          	sw	a5,-44(s0)
  if(pid < 0){
    5344:	fd442783          	lw	a5,-44(s0)
    5348:	2781                	sext.w	a5,a5
    534a:	0007df63          	bgez	a5,5368 <sbrkbasic+0x3e>
    printf("fork failed in sbrkbasic\n");
    534e:	00005517          	auipc	a0,0x5
    5352:	b7a50513          	addi	a0,a0,-1158 # 9ec8 <schedule_rm+0x20ce>
    5356:	00002097          	auipc	ra,0x2
    535a:	26a080e7          	jalr	618(ra) # 75c0 <printf>
    exit(1);
    535e:	4505                	li	a0,1
    5360:	00002097          	auipc	ra,0x2
    5364:	d1a080e7          	jalr	-742(ra) # 707a <exit>
  }
  if(pid == 0){
    5368:	fd442783          	lw	a5,-44(s0)
    536c:	2781                	sext.w	a5,a5
    536e:	e3b5                	bnez	a5,53d2 <sbrkbasic+0xa8>
    a = sbrk(TOOMUCH);
    5370:	40000537          	lui	a0,0x40000
    5374:	00002097          	auipc	ra,0x2
    5378:	d8e080e7          	jalr	-626(ra) # 7102 <sbrk>
    537c:	fea43023          	sd	a0,-32(s0)
    if(a == (char*)0xffffffffffffffffL){
    5380:	fe043703          	ld	a4,-32(s0)
    5384:	57fd                	li	a5,-1
    5386:	00f71763          	bne	a4,a5,5394 <sbrkbasic+0x6a>
      // it's OK if this fails.
      exit(0);
    538a:	4501                	li	a0,0
    538c:	00002097          	auipc	ra,0x2
    5390:	cee080e7          	jalr	-786(ra) # 707a <exit>
    }
    
    for(b = a; b < a+TOOMUCH; b += 4096){
    5394:	fe043783          	ld	a5,-32(s0)
    5398:	fcf43c23          	sd	a5,-40(s0)
    539c:	a829                	j	53b6 <sbrkbasic+0x8c>
      *b = 99;
    539e:	fd843783          	ld	a5,-40(s0)
    53a2:	06300713          	li	a4,99
    53a6:	00e78023          	sb	a4,0(a5)
    for(b = a; b < a+TOOMUCH; b += 4096){
    53aa:	fd843703          	ld	a4,-40(s0)
    53ae:	6785                	lui	a5,0x1
    53b0:	97ba                	add	a5,a5,a4
    53b2:	fcf43c23          	sd	a5,-40(s0)
    53b6:	fe043703          	ld	a4,-32(s0)
    53ba:	400007b7          	lui	a5,0x40000
    53be:	97ba                	add	a5,a5,a4
    53c0:	fd843703          	ld	a4,-40(s0)
    53c4:	fcf76de3          	bltu	a4,a5,539e <sbrkbasic+0x74>
    }
    
    // we should not get here! either sbrk(TOOMUCH)
    // should have failed, or (with lazy allocation)
    // a pagefault should have killed this process.
    exit(1);
    53c8:	4505                	li	a0,1
    53ca:	00002097          	auipc	ra,0x2
    53ce:	cb0080e7          	jalr	-848(ra) # 707a <exit>
  }

  wait(&xstatus);
    53d2:	fc440793          	addi	a5,s0,-60
    53d6:	853e                	mv	a0,a5
    53d8:	00002097          	auipc	ra,0x2
    53dc:	caa080e7          	jalr	-854(ra) # 7082 <wait>
  if(xstatus == 1){
    53e0:	fc442783          	lw	a5,-60(s0)
    53e4:	873e                	mv	a4,a5
    53e6:	4785                	li	a5,1
    53e8:	02f71163          	bne	a4,a5,540a <sbrkbasic+0xe0>
    printf("%s: too much memory allocated!\n", s);
    53ec:	fb843583          	ld	a1,-72(s0)
    53f0:	00005517          	auipc	a0,0x5
    53f4:	af850513          	addi	a0,a0,-1288 # 9ee8 <schedule_rm+0x20ee>
    53f8:	00002097          	auipc	ra,0x2
    53fc:	1c8080e7          	jalr	456(ra) # 75c0 <printf>
    exit(1);
    5400:	4505                	li	a0,1
    5402:	00002097          	auipc	ra,0x2
    5406:	c78080e7          	jalr	-904(ra) # 707a <exit>
  }

  // can one sbrk() less than a page?
  a = sbrk(0);
    540a:	4501                	li	a0,0
    540c:	00002097          	auipc	ra,0x2
    5410:	cf6080e7          	jalr	-778(ra) # 7102 <sbrk>
    5414:	fea43023          	sd	a0,-32(s0)
  for(i = 0; i < 5000; i++){
    5418:	fe042623          	sw	zero,-20(s0)
    541c:	a08d                	j	547e <sbrkbasic+0x154>
    b = sbrk(1);
    541e:	4505                	li	a0,1
    5420:	00002097          	auipc	ra,0x2
    5424:	ce2080e7          	jalr	-798(ra) # 7102 <sbrk>
    5428:	fca43c23          	sd	a0,-40(s0)
    if(b != a){
    542c:	fd843703          	ld	a4,-40(s0)
    5430:	fe043783          	ld	a5,-32(s0)
    5434:	02f70663          	beq	a4,a5,5460 <sbrkbasic+0x136>
      printf("%s: sbrk test failed %d %x %x\n", i, a, b);
    5438:	fec42783          	lw	a5,-20(s0)
    543c:	fd843683          	ld	a3,-40(s0)
    5440:	fe043603          	ld	a2,-32(s0)
    5444:	85be                	mv	a1,a5
    5446:	00005517          	auipc	a0,0x5
    544a:	ac250513          	addi	a0,a0,-1342 # 9f08 <schedule_rm+0x210e>
    544e:	00002097          	auipc	ra,0x2
    5452:	172080e7          	jalr	370(ra) # 75c0 <printf>
      exit(1);
    5456:	4505                	li	a0,1
    5458:	00002097          	auipc	ra,0x2
    545c:	c22080e7          	jalr	-990(ra) # 707a <exit>
    }
    *b = 1;
    5460:	fd843783          	ld	a5,-40(s0)
    5464:	4705                	li	a4,1
    5466:	00e78023          	sb	a4,0(a5) # 40000000 <__BSS_END__+0x3ffeeed0>
    a = b + 1;
    546a:	fd843783          	ld	a5,-40(s0)
    546e:	0785                	addi	a5,a5,1
    5470:	fef43023          	sd	a5,-32(s0)
  for(i = 0; i < 5000; i++){
    5474:	fec42783          	lw	a5,-20(s0)
    5478:	2785                	addiw	a5,a5,1
    547a:	fef42623          	sw	a5,-20(s0)
    547e:	fec42783          	lw	a5,-20(s0)
    5482:	0007871b          	sext.w	a4,a5
    5486:	6785                	lui	a5,0x1
    5488:	38778793          	addi	a5,a5,903 # 1387 <openiputtest+0xe1>
    548c:	f8e7d9e3          	bge	a5,a4,541e <sbrkbasic+0xf4>
  }
  pid = fork();
    5490:	00002097          	auipc	ra,0x2
    5494:	be2080e7          	jalr	-1054(ra) # 7072 <fork>
    5498:	87aa                	mv	a5,a0
    549a:	fcf42a23          	sw	a5,-44(s0)
  if(pid < 0){
    549e:	fd442783          	lw	a5,-44(s0)
    54a2:	2781                	sext.w	a5,a5
    54a4:	0207d163          	bgez	a5,54c6 <sbrkbasic+0x19c>
    printf("%s: sbrk test fork failed\n", s);
    54a8:	fb843583          	ld	a1,-72(s0)
    54ac:	00005517          	auipc	a0,0x5
    54b0:	a7c50513          	addi	a0,a0,-1412 # 9f28 <schedule_rm+0x212e>
    54b4:	00002097          	auipc	ra,0x2
    54b8:	10c080e7          	jalr	268(ra) # 75c0 <printf>
    exit(1);
    54bc:	4505                	li	a0,1
    54be:	00002097          	auipc	ra,0x2
    54c2:	bbc080e7          	jalr	-1092(ra) # 707a <exit>
  }
  c = sbrk(1);
    54c6:	4505                	li	a0,1
    54c8:	00002097          	auipc	ra,0x2
    54cc:	c3a080e7          	jalr	-966(ra) # 7102 <sbrk>
    54d0:	fca43423          	sd	a0,-56(s0)
  c = sbrk(1);
    54d4:	4505                	li	a0,1
    54d6:	00002097          	auipc	ra,0x2
    54da:	c2c080e7          	jalr	-980(ra) # 7102 <sbrk>
    54de:	fca43423          	sd	a0,-56(s0)
  if(c != a + 1){
    54e2:	fe043783          	ld	a5,-32(s0)
    54e6:	0785                	addi	a5,a5,1
    54e8:	fc843703          	ld	a4,-56(s0)
    54ec:	02f70163          	beq	a4,a5,550e <sbrkbasic+0x1e4>
    printf("%s: sbrk test failed post-fork\n", s);
    54f0:	fb843583          	ld	a1,-72(s0)
    54f4:	00005517          	auipc	a0,0x5
    54f8:	a5450513          	addi	a0,a0,-1452 # 9f48 <schedule_rm+0x214e>
    54fc:	00002097          	auipc	ra,0x2
    5500:	0c4080e7          	jalr	196(ra) # 75c0 <printf>
    exit(1);
    5504:	4505                	li	a0,1
    5506:	00002097          	auipc	ra,0x2
    550a:	b74080e7          	jalr	-1164(ra) # 707a <exit>
  }
  if(pid == 0)
    550e:	fd442783          	lw	a5,-44(s0)
    5512:	2781                	sext.w	a5,a5
    5514:	e791                	bnez	a5,5520 <sbrkbasic+0x1f6>
    exit(0);
    5516:	4501                	li	a0,0
    5518:	00002097          	auipc	ra,0x2
    551c:	b62080e7          	jalr	-1182(ra) # 707a <exit>
  wait(&xstatus);
    5520:	fc440793          	addi	a5,s0,-60
    5524:	853e                	mv	a0,a5
    5526:	00002097          	auipc	ra,0x2
    552a:	b5c080e7          	jalr	-1188(ra) # 7082 <wait>
  exit(xstatus);
    552e:	fc442783          	lw	a5,-60(s0)
    5532:	853e                	mv	a0,a5
    5534:	00002097          	auipc	ra,0x2
    5538:	b46080e7          	jalr	-1210(ra) # 707a <exit>

000000000000553c <sbrkmuch>:
}

void
sbrkmuch(char *s)
{
    553c:	711d                	addi	sp,sp,-96
    553e:	ec86                	sd	ra,88(sp)
    5540:	e8a2                	sd	s0,80(sp)
    5542:	1080                	addi	s0,sp,96
    5544:	faa43423          	sd	a0,-88(s0)
  enum { BIG=100*1024*1024 };
  char *c, *oldbrk, *a, *lastaddr, *p;
  uint64 amt;

  oldbrk = sbrk(0);
    5548:	4501                	li	a0,0
    554a:	00002097          	auipc	ra,0x2
    554e:	bb8080e7          	jalr	-1096(ra) # 7102 <sbrk>
    5552:	fea43023          	sd	a0,-32(s0)

  // can one grow address space to something big?
  a = sbrk(0);
    5556:	4501                	li	a0,0
    5558:	00002097          	auipc	ra,0x2
    555c:	baa080e7          	jalr	-1110(ra) # 7102 <sbrk>
    5560:	fca43c23          	sd	a0,-40(s0)
  amt = BIG - (uint64)a;
    5564:	fd843783          	ld	a5,-40(s0)
    5568:	06400737          	lui	a4,0x6400
    556c:	40f707b3          	sub	a5,a4,a5
    5570:	fcf43823          	sd	a5,-48(s0)
  p = sbrk(amt);
    5574:	fd043783          	ld	a5,-48(s0)
    5578:	2781                	sext.w	a5,a5
    557a:	853e                	mv	a0,a5
    557c:	00002097          	auipc	ra,0x2
    5580:	b86080e7          	jalr	-1146(ra) # 7102 <sbrk>
    5584:	fca43423          	sd	a0,-56(s0)
  if (p != a) {
    5588:	fc843703          	ld	a4,-56(s0)
    558c:	fd843783          	ld	a5,-40(s0)
    5590:	02f70163          	beq	a4,a5,55b2 <sbrkmuch+0x76>
    printf("%s: sbrk test failed to grow big address space; enough phys mem?\n", s);
    5594:	fa843583          	ld	a1,-88(s0)
    5598:	00005517          	auipc	a0,0x5
    559c:	9d050513          	addi	a0,a0,-1584 # 9f68 <schedule_rm+0x216e>
    55a0:	00002097          	auipc	ra,0x2
    55a4:	020080e7          	jalr	32(ra) # 75c0 <printf>
    exit(1);
    55a8:	4505                	li	a0,1
    55aa:	00002097          	auipc	ra,0x2
    55ae:	ad0080e7          	jalr	-1328(ra) # 707a <exit>
  }

  // touch each page to make sure it exists.
  char *eee = sbrk(0);
    55b2:	4501                	li	a0,0
    55b4:	00002097          	auipc	ra,0x2
    55b8:	b4e080e7          	jalr	-1202(ra) # 7102 <sbrk>
    55bc:	fca43023          	sd	a0,-64(s0)
  for(char *pp = a; pp < eee; pp += 4096)
    55c0:	fd843783          	ld	a5,-40(s0)
    55c4:	fef43423          	sd	a5,-24(s0)
    55c8:	a821                	j	55e0 <sbrkmuch+0xa4>
    *pp = 1;
    55ca:	fe843783          	ld	a5,-24(s0)
    55ce:	4705                	li	a4,1
    55d0:	00e78023          	sb	a4,0(a5)
  for(char *pp = a; pp < eee; pp += 4096)
    55d4:	fe843703          	ld	a4,-24(s0)
    55d8:	6785                	lui	a5,0x1
    55da:	97ba                	add	a5,a5,a4
    55dc:	fef43423          	sd	a5,-24(s0)
    55e0:	fe843703          	ld	a4,-24(s0)
    55e4:	fc043783          	ld	a5,-64(s0)
    55e8:	fef761e3          	bltu	a4,a5,55ca <sbrkmuch+0x8e>

  lastaddr = (char*) (BIG-1);
    55ec:	064007b7          	lui	a5,0x6400
    55f0:	17fd                	addi	a5,a5,-1
    55f2:	faf43c23          	sd	a5,-72(s0)
  *lastaddr = 99;
    55f6:	fb843783          	ld	a5,-72(s0)
    55fa:	06300713          	li	a4,99
    55fe:	00e78023          	sb	a4,0(a5) # 6400000 <__BSS_END__+0x63eeed0>

  // can one de-allocate?
  a = sbrk(0);
    5602:	4501                	li	a0,0
    5604:	00002097          	auipc	ra,0x2
    5608:	afe080e7          	jalr	-1282(ra) # 7102 <sbrk>
    560c:	fca43c23          	sd	a0,-40(s0)
  c = sbrk(-PGSIZE);
    5610:	757d                	lui	a0,0xfffff
    5612:	00002097          	auipc	ra,0x2
    5616:	af0080e7          	jalr	-1296(ra) # 7102 <sbrk>
    561a:	faa43823          	sd	a0,-80(s0)
  if(c == (char*)0xffffffffffffffffL){
    561e:	fb043703          	ld	a4,-80(s0)
    5622:	57fd                	li	a5,-1
    5624:	02f71163          	bne	a4,a5,5646 <sbrkmuch+0x10a>
    printf("%s: sbrk could not deallocate\n", s);
    5628:	fa843583          	ld	a1,-88(s0)
    562c:	00005517          	auipc	a0,0x5
    5630:	98450513          	addi	a0,a0,-1660 # 9fb0 <schedule_rm+0x21b6>
    5634:	00002097          	auipc	ra,0x2
    5638:	f8c080e7          	jalr	-116(ra) # 75c0 <printf>
    exit(1);
    563c:	4505                	li	a0,1
    563e:	00002097          	auipc	ra,0x2
    5642:	a3c080e7          	jalr	-1476(ra) # 707a <exit>
  }
  c = sbrk(0);
    5646:	4501                	li	a0,0
    5648:	00002097          	auipc	ra,0x2
    564c:	aba080e7          	jalr	-1350(ra) # 7102 <sbrk>
    5650:	faa43823          	sd	a0,-80(s0)
  if(c != a - PGSIZE){
    5654:	fd843703          	ld	a4,-40(s0)
    5658:	77fd                	lui	a5,0xfffff
    565a:	97ba                	add	a5,a5,a4
    565c:	fb043703          	ld	a4,-80(s0)
    5660:	02f70563          	beq	a4,a5,568a <sbrkmuch+0x14e>
    printf("%s: sbrk deallocation produced wrong address, a %x c %x\n", s, a, c);
    5664:	fb043683          	ld	a3,-80(s0)
    5668:	fd843603          	ld	a2,-40(s0)
    566c:	fa843583          	ld	a1,-88(s0)
    5670:	00005517          	auipc	a0,0x5
    5674:	96050513          	addi	a0,a0,-1696 # 9fd0 <schedule_rm+0x21d6>
    5678:	00002097          	auipc	ra,0x2
    567c:	f48080e7          	jalr	-184(ra) # 75c0 <printf>
    exit(1);
    5680:	4505                	li	a0,1
    5682:	00002097          	auipc	ra,0x2
    5686:	9f8080e7          	jalr	-1544(ra) # 707a <exit>
  }

  // can one re-allocate that page?
  a = sbrk(0);
    568a:	4501                	li	a0,0
    568c:	00002097          	auipc	ra,0x2
    5690:	a76080e7          	jalr	-1418(ra) # 7102 <sbrk>
    5694:	fca43c23          	sd	a0,-40(s0)
  c = sbrk(PGSIZE);
    5698:	6505                	lui	a0,0x1
    569a:	00002097          	auipc	ra,0x2
    569e:	a68080e7          	jalr	-1432(ra) # 7102 <sbrk>
    56a2:	faa43823          	sd	a0,-80(s0)
  if(c != a || sbrk(0) != a + PGSIZE){
    56a6:	fb043703          	ld	a4,-80(s0)
    56aa:	fd843783          	ld	a5,-40(s0)
    56ae:	00f71e63          	bne	a4,a5,56ca <sbrkmuch+0x18e>
    56b2:	4501                	li	a0,0
    56b4:	00002097          	auipc	ra,0x2
    56b8:	a4e080e7          	jalr	-1458(ra) # 7102 <sbrk>
    56bc:	86aa                	mv	a3,a0
    56be:	fd843703          	ld	a4,-40(s0)
    56c2:	6785                	lui	a5,0x1
    56c4:	97ba                	add	a5,a5,a4
    56c6:	02f68563          	beq	a3,a5,56f0 <sbrkmuch+0x1b4>
    printf("%s: sbrk re-allocation failed, a %x c %x\n", s, a, c);
    56ca:	fb043683          	ld	a3,-80(s0)
    56ce:	fd843603          	ld	a2,-40(s0)
    56d2:	fa843583          	ld	a1,-88(s0)
    56d6:	00005517          	auipc	a0,0x5
    56da:	93a50513          	addi	a0,a0,-1734 # a010 <schedule_rm+0x2216>
    56de:	00002097          	auipc	ra,0x2
    56e2:	ee2080e7          	jalr	-286(ra) # 75c0 <printf>
    exit(1);
    56e6:	4505                	li	a0,1
    56e8:	00002097          	auipc	ra,0x2
    56ec:	992080e7          	jalr	-1646(ra) # 707a <exit>
  }
  if(*lastaddr == 99){
    56f0:	fb843783          	ld	a5,-72(s0)
    56f4:	0007c783          	lbu	a5,0(a5) # 1000 <truncate3+0x1aa>
    56f8:	873e                	mv	a4,a5
    56fa:	06300793          	li	a5,99
    56fe:	02f71163          	bne	a4,a5,5720 <sbrkmuch+0x1e4>
    // should be zero
    printf("%s: sbrk de-allocation didn't really deallocate\n", s);
    5702:	fa843583          	ld	a1,-88(s0)
    5706:	00005517          	auipc	a0,0x5
    570a:	93a50513          	addi	a0,a0,-1734 # a040 <schedule_rm+0x2246>
    570e:	00002097          	auipc	ra,0x2
    5712:	eb2080e7          	jalr	-334(ra) # 75c0 <printf>
    exit(1);
    5716:	4505                	li	a0,1
    5718:	00002097          	auipc	ra,0x2
    571c:	962080e7          	jalr	-1694(ra) # 707a <exit>
  }

  a = sbrk(0);
    5720:	4501                	li	a0,0
    5722:	00002097          	auipc	ra,0x2
    5726:	9e0080e7          	jalr	-1568(ra) # 7102 <sbrk>
    572a:	fca43c23          	sd	a0,-40(s0)
  c = sbrk(-(sbrk(0) - oldbrk));
    572e:	4501                	li	a0,0
    5730:	00002097          	auipc	ra,0x2
    5734:	9d2080e7          	jalr	-1582(ra) # 7102 <sbrk>
    5738:	872a                	mv	a4,a0
    573a:	fe043783          	ld	a5,-32(s0)
    573e:	8f99                	sub	a5,a5,a4
    5740:	2781                	sext.w	a5,a5
    5742:	853e                	mv	a0,a5
    5744:	00002097          	auipc	ra,0x2
    5748:	9be080e7          	jalr	-1602(ra) # 7102 <sbrk>
    574c:	faa43823          	sd	a0,-80(s0)
  if(c != a){
    5750:	fb043703          	ld	a4,-80(s0)
    5754:	fd843783          	ld	a5,-40(s0)
    5758:	02f70563          	beq	a4,a5,5782 <sbrkmuch+0x246>
    printf("%s: sbrk downsize failed, a %x c %x\n", s, a, c);
    575c:	fb043683          	ld	a3,-80(s0)
    5760:	fd843603          	ld	a2,-40(s0)
    5764:	fa843583          	ld	a1,-88(s0)
    5768:	00005517          	auipc	a0,0x5
    576c:	91050513          	addi	a0,a0,-1776 # a078 <schedule_rm+0x227e>
    5770:	00002097          	auipc	ra,0x2
    5774:	e50080e7          	jalr	-432(ra) # 75c0 <printf>
    exit(1);
    5778:	4505                	li	a0,1
    577a:	00002097          	auipc	ra,0x2
    577e:	900080e7          	jalr	-1792(ra) # 707a <exit>
  }
}
    5782:	0001                	nop
    5784:	60e6                	ld	ra,88(sp)
    5786:	6446                	ld	s0,80(sp)
    5788:	6125                	addi	sp,sp,96
    578a:	8082                	ret

000000000000578c <kernmem>:

// can we read the kernel's memory?
void
kernmem(char *s)
{
    578c:	7179                	addi	sp,sp,-48
    578e:	f406                	sd	ra,40(sp)
    5790:	f022                	sd	s0,32(sp)
    5792:	1800                	addi	s0,sp,48
    5794:	fca43c23          	sd	a0,-40(s0)
  char *a;
  int pid;

  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    5798:	4785                	li	a5,1
    579a:	07fe                	slli	a5,a5,0x1f
    579c:	fef43423          	sd	a5,-24(s0)
    57a0:	a04d                	j	5842 <kernmem+0xb6>
    pid = fork();
    57a2:	00002097          	auipc	ra,0x2
    57a6:	8d0080e7          	jalr	-1840(ra) # 7072 <fork>
    57aa:	87aa                	mv	a5,a0
    57ac:	fef42223          	sw	a5,-28(s0)
    if(pid < 0){
    57b0:	fe442783          	lw	a5,-28(s0)
    57b4:	2781                	sext.w	a5,a5
    57b6:	0207d163          	bgez	a5,57d8 <kernmem+0x4c>
      printf("%s: fork failed\n", s);
    57ba:	fd843583          	ld	a1,-40(s0)
    57be:	00003517          	auipc	a0,0x3
    57c2:	0f250513          	addi	a0,a0,242 # 88b0 <schedule_rm+0xab6>
    57c6:	00002097          	auipc	ra,0x2
    57ca:	dfa080e7          	jalr	-518(ra) # 75c0 <printf>
      exit(1);
    57ce:	4505                	li	a0,1
    57d0:	00002097          	auipc	ra,0x2
    57d4:	8aa080e7          	jalr	-1878(ra) # 707a <exit>
    }
    if(pid == 0){
    57d8:	fe442783          	lw	a5,-28(s0)
    57dc:	2781                	sext.w	a5,a5
    57de:	eb85                	bnez	a5,580e <kernmem+0x82>
      printf("%s: oops could read %x = %x\n", s, a, *a);
    57e0:	fe843783          	ld	a5,-24(s0)
    57e4:	0007c783          	lbu	a5,0(a5)
    57e8:	2781                	sext.w	a5,a5
    57ea:	86be                	mv	a3,a5
    57ec:	fe843603          	ld	a2,-24(s0)
    57f0:	fd843583          	ld	a1,-40(s0)
    57f4:	00005517          	auipc	a0,0x5
    57f8:	8ac50513          	addi	a0,a0,-1876 # a0a0 <schedule_rm+0x22a6>
    57fc:	00002097          	auipc	ra,0x2
    5800:	dc4080e7          	jalr	-572(ra) # 75c0 <printf>
      exit(1);
    5804:	4505                	li	a0,1
    5806:	00002097          	auipc	ra,0x2
    580a:	874080e7          	jalr	-1932(ra) # 707a <exit>
    }
    int xstatus;
    wait(&xstatus);
    580e:	fe040793          	addi	a5,s0,-32
    5812:	853e                	mv	a0,a5
    5814:	00002097          	auipc	ra,0x2
    5818:	86e080e7          	jalr	-1938(ra) # 7082 <wait>
    if(xstatus != -1)  // did kernel kill child?
    581c:	fe042783          	lw	a5,-32(s0)
    5820:	873e                	mv	a4,a5
    5822:	57fd                	li	a5,-1
    5824:	00f70763          	beq	a4,a5,5832 <kernmem+0xa6>
      exit(1);
    5828:	4505                	li	a0,1
    582a:	00002097          	auipc	ra,0x2
    582e:	850080e7          	jalr	-1968(ra) # 707a <exit>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    5832:	fe843703          	ld	a4,-24(s0)
    5836:	67b1                	lui	a5,0xc
    5838:	35078793          	addi	a5,a5,848 # c350 <__global_pointer$+0x1258>
    583c:	97ba                	add	a5,a5,a4
    583e:	fef43423          	sd	a5,-24(s0)
    5842:	fe843703          	ld	a4,-24(s0)
    5846:	1003d7b7          	lui	a5,0x1003d
    584a:	078e                	slli	a5,a5,0x3
    584c:	47f78793          	addi	a5,a5,1151 # 1003d47f <__BSS_END__+0x1002c34f>
    5850:	f4e7f9e3          	bgeu	a5,a4,57a2 <kernmem+0x16>
  }
}
    5854:	0001                	nop
    5856:	0001                	nop
    5858:	70a2                	ld	ra,40(sp)
    585a:	7402                	ld	s0,32(sp)
    585c:	6145                	addi	sp,sp,48
    585e:	8082                	ret

0000000000005860 <sbrkfail>:

// if we run the system out of memory, does it clean up the last
// failed allocation?
void
sbrkfail(char *s)
{
    5860:	7119                	addi	sp,sp,-128
    5862:	fc86                	sd	ra,120(sp)
    5864:	f8a2                	sd	s0,112(sp)
    5866:	0100                	addi	s0,sp,128
    5868:	f8a43423          	sd	a0,-120(s0)
  char scratch;
  char *c, *a;
  int pids[10];
  int pid;
 
  if(pipe(fds) != 0){
    586c:	fc040793          	addi	a5,s0,-64
    5870:	853e                	mv	a0,a5
    5872:	00002097          	auipc	ra,0x2
    5876:	818080e7          	jalr	-2024(ra) # 708a <pipe>
    587a:	87aa                	mv	a5,a0
    587c:	c385                	beqz	a5,589c <sbrkfail+0x3c>
    printf("%s: pipe() failed\n", s);
    587e:	f8843583          	ld	a1,-120(s0)
    5882:	00003517          	auipc	a0,0x3
    5886:	4c650513          	addi	a0,a0,1222 # 8d48 <schedule_rm+0xf4e>
    588a:	00002097          	auipc	ra,0x2
    588e:	d36080e7          	jalr	-714(ra) # 75c0 <printf>
    exit(1);
    5892:	4505                	li	a0,1
    5894:	00001097          	auipc	ra,0x1
    5898:	7e6080e7          	jalr	2022(ra) # 707a <exit>
  }
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    589c:	fe042623          	sw	zero,-20(s0)
    58a0:	a84d                	j	5952 <sbrkfail+0xf2>
    if((pids[i] = fork()) == 0){
    58a2:	00001097          	auipc	ra,0x1
    58a6:	7d0080e7          	jalr	2000(ra) # 7072 <fork>
    58aa:	87aa                	mv	a5,a0
    58ac:	873e                	mv	a4,a5
    58ae:	fec42783          	lw	a5,-20(s0)
    58b2:	078a                	slli	a5,a5,0x2
    58b4:	ff040693          	addi	a3,s0,-16
    58b8:	97b6                	add	a5,a5,a3
    58ba:	fae7a023          	sw	a4,-96(a5)
    58be:	fec42783          	lw	a5,-20(s0)
    58c2:	078a                	slli	a5,a5,0x2
    58c4:	ff040713          	addi	a4,s0,-16
    58c8:	97ba                	add	a5,a5,a4
    58ca:	fa07a783          	lw	a5,-96(a5)
    58ce:	e7b1                	bnez	a5,591a <sbrkfail+0xba>
      // allocate a lot of memory
      sbrk(BIG - (uint64)sbrk(0));
    58d0:	4501                	li	a0,0
    58d2:	00002097          	auipc	ra,0x2
    58d6:	830080e7          	jalr	-2000(ra) # 7102 <sbrk>
    58da:	87aa                	mv	a5,a0
    58dc:	2781                	sext.w	a5,a5
    58de:	06400737          	lui	a4,0x6400
    58e2:	40f707bb          	subw	a5,a4,a5
    58e6:	2781                	sext.w	a5,a5
    58e8:	2781                	sext.w	a5,a5
    58ea:	853e                	mv	a0,a5
    58ec:	00002097          	auipc	ra,0x2
    58f0:	816080e7          	jalr	-2026(ra) # 7102 <sbrk>
      write(fds[1], "x", 1);
    58f4:	fc442783          	lw	a5,-60(s0)
    58f8:	4605                	li	a2,1
    58fa:	00003597          	auipc	a1,0x3
    58fe:	c8e58593          	addi	a1,a1,-882 # 8588 <schedule_rm+0x78e>
    5902:	853e                	mv	a0,a5
    5904:	00001097          	auipc	ra,0x1
    5908:	796080e7          	jalr	1942(ra) # 709a <write>
      // sit around until killed
      for(;;) sleep(1000);
    590c:	3e800513          	li	a0,1000
    5910:	00001097          	auipc	ra,0x1
    5914:	7fa080e7          	jalr	2042(ra) # 710a <sleep>
    5918:	bfd5                	j	590c <sbrkfail+0xac>
    }
    if(pids[i] != -1)
    591a:	fec42783          	lw	a5,-20(s0)
    591e:	078a                	slli	a5,a5,0x2
    5920:	ff040713          	addi	a4,s0,-16
    5924:	97ba                	add	a5,a5,a4
    5926:	fa07a783          	lw	a5,-96(a5)
    592a:	873e                	mv	a4,a5
    592c:	57fd                	li	a5,-1
    592e:	00f70d63          	beq	a4,a5,5948 <sbrkfail+0xe8>
      read(fds[0], &scratch, 1);
    5932:	fc042783          	lw	a5,-64(s0)
    5936:	fbf40713          	addi	a4,s0,-65
    593a:	4605                	li	a2,1
    593c:	85ba                	mv	a1,a4
    593e:	853e                	mv	a0,a5
    5940:	00001097          	auipc	ra,0x1
    5944:	752080e7          	jalr	1874(ra) # 7092 <read>
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    5948:	fec42783          	lw	a5,-20(s0)
    594c:	2785                	addiw	a5,a5,1
    594e:	fef42623          	sw	a5,-20(s0)
    5952:	fec42783          	lw	a5,-20(s0)
    5956:	873e                	mv	a4,a5
    5958:	47a5                	li	a5,9
    595a:	f4e7f4e3          	bgeu	a5,a4,58a2 <sbrkfail+0x42>
  }

  // if those failed allocations freed up the pages they did allocate,
  // we'll be able to allocate here
  c = sbrk(PGSIZE);
    595e:	6505                	lui	a0,0x1
    5960:	00001097          	auipc	ra,0x1
    5964:	7a2080e7          	jalr	1954(ra) # 7102 <sbrk>
    5968:	fea43023          	sd	a0,-32(s0)
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    596c:	fe042623          	sw	zero,-20(s0)
    5970:	a0b1                	j	59bc <sbrkfail+0x15c>
    if(pids[i] == -1)
    5972:	fec42783          	lw	a5,-20(s0)
    5976:	078a                	slli	a5,a5,0x2
    5978:	ff040713          	addi	a4,s0,-16
    597c:	97ba                	add	a5,a5,a4
    597e:	fa07a783          	lw	a5,-96(a5)
    5982:	873e                	mv	a4,a5
    5984:	57fd                	li	a5,-1
    5986:	02f70563          	beq	a4,a5,59b0 <sbrkfail+0x150>
      continue;
    kill(pids[i]);
    598a:	fec42783          	lw	a5,-20(s0)
    598e:	078a                	slli	a5,a5,0x2
    5990:	ff040713          	addi	a4,s0,-16
    5994:	97ba                	add	a5,a5,a4
    5996:	fa07a783          	lw	a5,-96(a5)
    599a:	853e                	mv	a0,a5
    599c:	00001097          	auipc	ra,0x1
    59a0:	70e080e7          	jalr	1806(ra) # 70aa <kill>
    wait(0);
    59a4:	4501                	li	a0,0
    59a6:	00001097          	auipc	ra,0x1
    59aa:	6dc080e7          	jalr	1756(ra) # 7082 <wait>
    59ae:	a011                	j	59b2 <sbrkfail+0x152>
      continue;
    59b0:	0001                	nop
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    59b2:	fec42783          	lw	a5,-20(s0)
    59b6:	2785                	addiw	a5,a5,1
    59b8:	fef42623          	sw	a5,-20(s0)
    59bc:	fec42783          	lw	a5,-20(s0)
    59c0:	873e                	mv	a4,a5
    59c2:	47a5                	li	a5,9
    59c4:	fae7f7e3          	bgeu	a5,a4,5972 <sbrkfail+0x112>
  }
  if(c == (char*)0xffffffffffffffffL){
    59c8:	fe043703          	ld	a4,-32(s0)
    59cc:	57fd                	li	a5,-1
    59ce:	02f71163          	bne	a4,a5,59f0 <sbrkfail+0x190>
    printf("%s: failed sbrk leaked memory\n", s);
    59d2:	f8843583          	ld	a1,-120(s0)
    59d6:	00004517          	auipc	a0,0x4
    59da:	6ea50513          	addi	a0,a0,1770 # a0c0 <schedule_rm+0x22c6>
    59de:	00002097          	auipc	ra,0x2
    59e2:	be2080e7          	jalr	-1054(ra) # 75c0 <printf>
    exit(1);
    59e6:	4505                	li	a0,1
    59e8:	00001097          	auipc	ra,0x1
    59ec:	692080e7          	jalr	1682(ra) # 707a <exit>
  }

  // test running fork with the above allocated page 
  pid = fork();
    59f0:	00001097          	auipc	ra,0x1
    59f4:	682080e7          	jalr	1666(ra) # 7072 <fork>
    59f8:	87aa                	mv	a5,a0
    59fa:	fcf42e23          	sw	a5,-36(s0)
  if(pid < 0){
    59fe:	fdc42783          	lw	a5,-36(s0)
    5a02:	2781                	sext.w	a5,a5
    5a04:	0207d163          	bgez	a5,5a26 <sbrkfail+0x1c6>
    printf("%s: fork failed\n", s);
    5a08:	f8843583          	ld	a1,-120(s0)
    5a0c:	00003517          	auipc	a0,0x3
    5a10:	ea450513          	addi	a0,a0,-348 # 88b0 <schedule_rm+0xab6>
    5a14:	00002097          	auipc	ra,0x2
    5a18:	bac080e7          	jalr	-1108(ra) # 75c0 <printf>
    exit(1);
    5a1c:	4505                	li	a0,1
    5a1e:	00001097          	auipc	ra,0x1
    5a22:	65c080e7          	jalr	1628(ra) # 707a <exit>
  }
  if(pid == 0){
    5a26:	fdc42783          	lw	a5,-36(s0)
    5a2a:	2781                	sext.w	a5,a5
    5a2c:	e3c1                	bnez	a5,5aac <sbrkfail+0x24c>
    // allocate a lot of memory.
    // this should produce a page fault,
    // and thus not complete.
    a = sbrk(0);
    5a2e:	4501                	li	a0,0
    5a30:	00001097          	auipc	ra,0x1
    5a34:	6d2080e7          	jalr	1746(ra) # 7102 <sbrk>
    5a38:	fca43823          	sd	a0,-48(s0)
    sbrk(10*BIG);
    5a3c:	3e800537          	lui	a0,0x3e800
    5a40:	00001097          	auipc	ra,0x1
    5a44:	6c2080e7          	jalr	1730(ra) # 7102 <sbrk>
    int n = 0;
    5a48:	fe042423          	sw	zero,-24(s0)
    for (i = 0; i < 10*BIG; i += PGSIZE) {
    5a4c:	fe042623          	sw	zero,-20(s0)
    5a50:	a025                	j	5a78 <sbrkfail+0x218>
      n += *(a+i);
    5a52:	fec42783          	lw	a5,-20(s0)
    5a56:	fd043703          	ld	a4,-48(s0)
    5a5a:	97ba                	add	a5,a5,a4
    5a5c:	0007c783          	lbu	a5,0(a5)
    5a60:	2781                	sext.w	a5,a5
    5a62:	fe842703          	lw	a4,-24(s0)
    5a66:	9fb9                	addw	a5,a5,a4
    5a68:	fef42423          	sw	a5,-24(s0)
    for (i = 0; i < 10*BIG; i += PGSIZE) {
    5a6c:	fec42703          	lw	a4,-20(s0)
    5a70:	6785                	lui	a5,0x1
    5a72:	9fb9                	addw	a5,a5,a4
    5a74:	fef42623          	sw	a5,-20(s0)
    5a78:	fec42783          	lw	a5,-20(s0)
    5a7c:	0007871b          	sext.w	a4,a5
    5a80:	3e8007b7          	lui	a5,0x3e800
    5a84:	fcf747e3          	blt	a4,a5,5a52 <sbrkfail+0x1f2>
    }
    // print n so the compiler doesn't optimize away
    // the for loop.
    printf("%s: allocate a lot of memory succeeded %d\n", s, n);
    5a88:	fe842783          	lw	a5,-24(s0)
    5a8c:	863e                	mv	a2,a5
    5a8e:	f8843583          	ld	a1,-120(s0)
    5a92:	00004517          	auipc	a0,0x4
    5a96:	64e50513          	addi	a0,a0,1614 # a0e0 <schedule_rm+0x22e6>
    5a9a:	00002097          	auipc	ra,0x2
    5a9e:	b26080e7          	jalr	-1242(ra) # 75c0 <printf>
    exit(1);
    5aa2:	4505                	li	a0,1
    5aa4:	00001097          	auipc	ra,0x1
    5aa8:	5d6080e7          	jalr	1494(ra) # 707a <exit>
  }
  wait(&xstatus);
    5aac:	fcc40793          	addi	a5,s0,-52
    5ab0:	853e                	mv	a0,a5
    5ab2:	00001097          	auipc	ra,0x1
    5ab6:	5d0080e7          	jalr	1488(ra) # 7082 <wait>
  if(xstatus != -1 && xstatus != 2)
    5aba:	fcc42783          	lw	a5,-52(s0)
    5abe:	873e                	mv	a4,a5
    5ac0:	57fd                	li	a5,-1
    5ac2:	00f70d63          	beq	a4,a5,5adc <sbrkfail+0x27c>
    5ac6:	fcc42783          	lw	a5,-52(s0)
    5aca:	873e                	mv	a4,a5
    5acc:	4789                	li	a5,2
    5ace:	00f70763          	beq	a4,a5,5adc <sbrkfail+0x27c>
    exit(1);
    5ad2:	4505                	li	a0,1
    5ad4:	00001097          	auipc	ra,0x1
    5ad8:	5a6080e7          	jalr	1446(ra) # 707a <exit>
}
    5adc:	0001                	nop
    5ade:	70e6                	ld	ra,120(sp)
    5ae0:	7446                	ld	s0,112(sp)
    5ae2:	6109                	addi	sp,sp,128
    5ae4:	8082                	ret

0000000000005ae6 <sbrkarg>:

  
// test reads/writes from/to allocated memory
void
sbrkarg(char *s)
{
    5ae6:	7179                	addi	sp,sp,-48
    5ae8:	f406                	sd	ra,40(sp)
    5aea:	f022                	sd	s0,32(sp)
    5aec:	1800                	addi	s0,sp,48
    5aee:	fca43c23          	sd	a0,-40(s0)
  char *a;
  int fd, n;

  a = sbrk(PGSIZE);
    5af2:	6505                	lui	a0,0x1
    5af4:	00001097          	auipc	ra,0x1
    5af8:	60e080e7          	jalr	1550(ra) # 7102 <sbrk>
    5afc:	fea43423          	sd	a0,-24(s0)
  fd = open("sbrk", O_CREATE|O_WRONLY);
    5b00:	20100593          	li	a1,513
    5b04:	00004517          	auipc	a0,0x4
    5b08:	60c50513          	addi	a0,a0,1548 # a110 <schedule_rm+0x2316>
    5b0c:	00001097          	auipc	ra,0x1
    5b10:	5ae080e7          	jalr	1454(ra) # 70ba <open>
    5b14:	87aa                	mv	a5,a0
    5b16:	fef42223          	sw	a5,-28(s0)
  unlink("sbrk");
    5b1a:	00004517          	auipc	a0,0x4
    5b1e:	5f650513          	addi	a0,a0,1526 # a110 <schedule_rm+0x2316>
    5b22:	00001097          	auipc	ra,0x1
    5b26:	5a8080e7          	jalr	1448(ra) # 70ca <unlink>
  if(fd < 0)  {
    5b2a:	fe442783          	lw	a5,-28(s0)
    5b2e:	2781                	sext.w	a5,a5
    5b30:	0207d163          	bgez	a5,5b52 <sbrkarg+0x6c>
    printf("%s: open sbrk failed\n", s);
    5b34:	fd843583          	ld	a1,-40(s0)
    5b38:	00004517          	auipc	a0,0x4
    5b3c:	5e050513          	addi	a0,a0,1504 # a118 <schedule_rm+0x231e>
    5b40:	00002097          	auipc	ra,0x2
    5b44:	a80080e7          	jalr	-1408(ra) # 75c0 <printf>
    exit(1);
    5b48:	4505                	li	a0,1
    5b4a:	00001097          	auipc	ra,0x1
    5b4e:	530080e7          	jalr	1328(ra) # 707a <exit>
  }
  if ((n = write(fd, a, PGSIZE)) < 0) {
    5b52:	fe442783          	lw	a5,-28(s0)
    5b56:	6605                	lui	a2,0x1
    5b58:	fe843583          	ld	a1,-24(s0)
    5b5c:	853e                	mv	a0,a5
    5b5e:	00001097          	auipc	ra,0x1
    5b62:	53c080e7          	jalr	1340(ra) # 709a <write>
    5b66:	87aa                	mv	a5,a0
    5b68:	fef42023          	sw	a5,-32(s0)
    5b6c:	fe042783          	lw	a5,-32(s0)
    5b70:	2781                	sext.w	a5,a5
    5b72:	0207d163          	bgez	a5,5b94 <sbrkarg+0xae>
    printf("%s: write sbrk failed\n", s);
    5b76:	fd843583          	ld	a1,-40(s0)
    5b7a:	00004517          	auipc	a0,0x4
    5b7e:	5b650513          	addi	a0,a0,1462 # a130 <schedule_rm+0x2336>
    5b82:	00002097          	auipc	ra,0x2
    5b86:	a3e080e7          	jalr	-1474(ra) # 75c0 <printf>
    exit(1);
    5b8a:	4505                	li	a0,1
    5b8c:	00001097          	auipc	ra,0x1
    5b90:	4ee080e7          	jalr	1262(ra) # 707a <exit>
  }
  close(fd);
    5b94:	fe442783          	lw	a5,-28(s0)
    5b98:	853e                	mv	a0,a5
    5b9a:	00001097          	auipc	ra,0x1
    5b9e:	508080e7          	jalr	1288(ra) # 70a2 <close>

  // test writes to allocated memory
  a = sbrk(PGSIZE);
    5ba2:	6505                	lui	a0,0x1
    5ba4:	00001097          	auipc	ra,0x1
    5ba8:	55e080e7          	jalr	1374(ra) # 7102 <sbrk>
    5bac:	fea43423          	sd	a0,-24(s0)
  if(pipe((int *) a) != 0){
    5bb0:	fe843503          	ld	a0,-24(s0)
    5bb4:	00001097          	auipc	ra,0x1
    5bb8:	4d6080e7          	jalr	1238(ra) # 708a <pipe>
    5bbc:	87aa                	mv	a5,a0
    5bbe:	c385                	beqz	a5,5bde <sbrkarg+0xf8>
    printf("%s: pipe() failed\n", s);
    5bc0:	fd843583          	ld	a1,-40(s0)
    5bc4:	00003517          	auipc	a0,0x3
    5bc8:	18450513          	addi	a0,a0,388 # 8d48 <schedule_rm+0xf4e>
    5bcc:	00002097          	auipc	ra,0x2
    5bd0:	9f4080e7          	jalr	-1548(ra) # 75c0 <printf>
    exit(1);
    5bd4:	4505                	li	a0,1
    5bd6:	00001097          	auipc	ra,0x1
    5bda:	4a4080e7          	jalr	1188(ra) # 707a <exit>
  } 
}
    5bde:	0001                	nop
    5be0:	70a2                	ld	ra,40(sp)
    5be2:	7402                	ld	s0,32(sp)
    5be4:	6145                	addi	sp,sp,48
    5be6:	8082                	ret

0000000000005be8 <validatetest>:

void
validatetest(char *s)
{
    5be8:	7179                	addi	sp,sp,-48
    5bea:	f406                	sd	ra,40(sp)
    5bec:	f022                	sd	s0,32(sp)
    5bee:	1800                	addi	s0,sp,48
    5bf0:	fca43c23          	sd	a0,-40(s0)
  int hi;
  uint64 p;

  hi = 1100*1024;
    5bf4:	001137b7          	lui	a5,0x113
    5bf8:	fef42223          	sw	a5,-28(s0)
  for(p = 0; p <= (uint)hi; p += PGSIZE){
    5bfc:	fe043423          	sd	zero,-24(s0)
    5c00:	a0b1                	j	5c4c <validatetest+0x64>
    // try to crash the kernel by passing in a bad string pointer
    if(link("nosuchfile", (char*)p) != -1){
    5c02:	fe843783          	ld	a5,-24(s0)
    5c06:	85be                	mv	a1,a5
    5c08:	00004517          	auipc	a0,0x4
    5c0c:	54050513          	addi	a0,a0,1344 # a148 <schedule_rm+0x234e>
    5c10:	00001097          	auipc	ra,0x1
    5c14:	4ca080e7          	jalr	1226(ra) # 70da <link>
    5c18:	87aa                	mv	a5,a0
    5c1a:	873e                	mv	a4,a5
    5c1c:	57fd                	li	a5,-1
    5c1e:	02f70163          	beq	a4,a5,5c40 <validatetest+0x58>
      printf("%s: link should not succeed\n", s);
    5c22:	fd843583          	ld	a1,-40(s0)
    5c26:	00004517          	auipc	a0,0x4
    5c2a:	53250513          	addi	a0,a0,1330 # a158 <schedule_rm+0x235e>
    5c2e:	00002097          	auipc	ra,0x2
    5c32:	992080e7          	jalr	-1646(ra) # 75c0 <printf>
      exit(1);
    5c36:	4505                	li	a0,1
    5c38:	00001097          	auipc	ra,0x1
    5c3c:	442080e7          	jalr	1090(ra) # 707a <exit>
  for(p = 0; p <= (uint)hi; p += PGSIZE){
    5c40:	fe843703          	ld	a4,-24(s0)
    5c44:	6785                	lui	a5,0x1
    5c46:	97ba                	add	a5,a5,a4
    5c48:	fef43423          	sd	a5,-24(s0)
    5c4c:	fe442783          	lw	a5,-28(s0)
    5c50:	1782                	slli	a5,a5,0x20
    5c52:	9381                	srli	a5,a5,0x20
    5c54:	fe843703          	ld	a4,-24(s0)
    5c58:	fae7f5e3          	bgeu	a5,a4,5c02 <validatetest+0x1a>
    }
  }
}
    5c5c:	0001                	nop
    5c5e:	0001                	nop
    5c60:	70a2                	ld	ra,40(sp)
    5c62:	7402                	ld	s0,32(sp)
    5c64:	6145                	addi	sp,sp,48
    5c66:	8082                	ret

0000000000005c68 <bsstest>:

// does unintialized data start out zero?
char uninit[10000];
void
bsstest(char *s)
{
    5c68:	7179                	addi	sp,sp,-48
    5c6a:	f406                	sd	ra,40(sp)
    5c6c:	f022                	sd	s0,32(sp)
    5c6e:	1800                	addi	s0,sp,48
    5c70:	fca43c23          	sd	a0,-40(s0)
  int i;

  for(i = 0; i < sizeof(uninit); i++){
    5c74:	fe042623          	sw	zero,-20(s0)
    5c78:	a83d                	j	5cb6 <bsstest+0x4e>
    if(uninit[i] != '\0'){
    5c7a:	00008717          	auipc	a4,0x8
    5c7e:	c8670713          	addi	a4,a4,-890 # d900 <uninit>
    5c82:	fec42783          	lw	a5,-20(s0)
    5c86:	97ba                	add	a5,a5,a4
    5c88:	0007c783          	lbu	a5,0(a5) # 1000 <truncate3+0x1aa>
    5c8c:	c385                	beqz	a5,5cac <bsstest+0x44>
      printf("%s: bss test failed\n", s);
    5c8e:	fd843583          	ld	a1,-40(s0)
    5c92:	00004517          	auipc	a0,0x4
    5c96:	4e650513          	addi	a0,a0,1254 # a178 <schedule_rm+0x237e>
    5c9a:	00002097          	auipc	ra,0x2
    5c9e:	926080e7          	jalr	-1754(ra) # 75c0 <printf>
      exit(1);
    5ca2:	4505                	li	a0,1
    5ca4:	00001097          	auipc	ra,0x1
    5ca8:	3d6080e7          	jalr	982(ra) # 707a <exit>
  for(i = 0; i < sizeof(uninit); i++){
    5cac:	fec42783          	lw	a5,-20(s0)
    5cb0:	2785                	addiw	a5,a5,1
    5cb2:	fef42623          	sw	a5,-20(s0)
    5cb6:	fec42783          	lw	a5,-20(s0)
    5cba:	873e                	mv	a4,a5
    5cbc:	6789                	lui	a5,0x2
    5cbe:	70f78793          	addi	a5,a5,1807 # 270f <mem+0xb3>
    5cc2:	fae7fce3          	bgeu	a5,a4,5c7a <bsstest+0x12>
    }
  }
}
    5cc6:	0001                	nop
    5cc8:	0001                	nop
    5cca:	70a2                	ld	ra,40(sp)
    5ccc:	7402                	ld	s0,32(sp)
    5cce:	6145                	addi	sp,sp,48
    5cd0:	8082                	ret

0000000000005cd2 <bigargtest>:
// does exec return an error if the arguments
// are larger than a page? or does it write
// below the stack and wreck the instructions/data?
void
bigargtest(char *s)
{
    5cd2:	7179                	addi	sp,sp,-48
    5cd4:	f406                	sd	ra,40(sp)
    5cd6:	f022                	sd	s0,32(sp)
    5cd8:	1800                	addi	s0,sp,48
    5cda:	fca43c23          	sd	a0,-40(s0)
  int pid, fd, xstatus;

  unlink("bigarg-ok");
    5cde:	00004517          	auipc	a0,0x4
    5ce2:	4b250513          	addi	a0,a0,1202 # a190 <schedule_rm+0x2396>
    5ce6:	00001097          	auipc	ra,0x1
    5cea:	3e4080e7          	jalr	996(ra) # 70ca <unlink>
  pid = fork();
    5cee:	00001097          	auipc	ra,0x1
    5cf2:	384080e7          	jalr	900(ra) # 7072 <fork>
    5cf6:	87aa                	mv	a5,a0
    5cf8:	fef42423          	sw	a5,-24(s0)
  if(pid == 0){
    5cfc:	fe842783          	lw	a5,-24(s0)
    5d00:	2781                	sext.w	a5,a5
    5d02:	ebc1                	bnez	a5,5d92 <bigargtest+0xc0>
    static char *args[MAXARG];
    int i;
    for(i = 0; i < MAXARG-1; i++)
    5d04:	fe042623          	sw	zero,-20(s0)
    5d08:	a01d                	j	5d2e <bigargtest+0x5c>
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    5d0a:	0000b717          	auipc	a4,0xb
    5d0e:	30e70713          	addi	a4,a4,782 # 11018 <args.1>
    5d12:	fec42783          	lw	a5,-20(s0)
    5d16:	078e                	slli	a5,a5,0x3
    5d18:	97ba                	add	a5,a5,a4
    5d1a:	00004717          	auipc	a4,0x4
    5d1e:	48670713          	addi	a4,a4,1158 # a1a0 <schedule_rm+0x23a6>
    5d22:	e398                	sd	a4,0(a5)
    for(i = 0; i < MAXARG-1; i++)
    5d24:	fec42783          	lw	a5,-20(s0)
    5d28:	2785                	addiw	a5,a5,1
    5d2a:	fef42623          	sw	a5,-20(s0)
    5d2e:	fec42783          	lw	a5,-20(s0)
    5d32:	0007871b          	sext.w	a4,a5
    5d36:	47f9                	li	a5,30
    5d38:	fce7d9e3          	bge	a5,a4,5d0a <bigargtest+0x38>
    args[MAXARG-1] = 0;
    5d3c:	0000b797          	auipc	a5,0xb
    5d40:	2dc78793          	addi	a5,a5,732 # 11018 <args.1>
    5d44:	0e07bc23          	sd	zero,248(a5)
    exec("echo", args);
    5d48:	0000b597          	auipc	a1,0xb
    5d4c:	2d058593          	addi	a1,a1,720 # 11018 <args.1>
    5d50:	00003517          	auipc	a0,0x3
    5d54:	94850513          	addi	a0,a0,-1720 # 8698 <schedule_rm+0x89e>
    5d58:	00001097          	auipc	ra,0x1
    5d5c:	35a080e7          	jalr	858(ra) # 70b2 <exec>
    fd = open("bigarg-ok", O_CREATE);
    5d60:	20000593          	li	a1,512
    5d64:	00004517          	auipc	a0,0x4
    5d68:	42c50513          	addi	a0,a0,1068 # a190 <schedule_rm+0x2396>
    5d6c:	00001097          	auipc	ra,0x1
    5d70:	34e080e7          	jalr	846(ra) # 70ba <open>
    5d74:	87aa                	mv	a5,a0
    5d76:	fef42223          	sw	a5,-28(s0)
    close(fd);
    5d7a:	fe442783          	lw	a5,-28(s0)
    5d7e:	853e                	mv	a0,a5
    5d80:	00001097          	auipc	ra,0x1
    5d84:	322080e7          	jalr	802(ra) # 70a2 <close>
    exit(0);
    5d88:	4501                	li	a0,0
    5d8a:	00001097          	auipc	ra,0x1
    5d8e:	2f0080e7          	jalr	752(ra) # 707a <exit>
  } else if(pid < 0){
    5d92:	fe842783          	lw	a5,-24(s0)
    5d96:	2781                	sext.w	a5,a5
    5d98:	0207d163          	bgez	a5,5dba <bigargtest+0xe8>
    printf("%s: bigargtest: fork failed\n", s);
    5d9c:	fd843583          	ld	a1,-40(s0)
    5da0:	00004517          	auipc	a0,0x4
    5da4:	4e050513          	addi	a0,a0,1248 # a280 <schedule_rm+0x2486>
    5da8:	00002097          	auipc	ra,0x2
    5dac:	818080e7          	jalr	-2024(ra) # 75c0 <printf>
    exit(1);
    5db0:	4505                	li	a0,1
    5db2:	00001097          	auipc	ra,0x1
    5db6:	2c8080e7          	jalr	712(ra) # 707a <exit>
  }
  
  wait(&xstatus);
    5dba:	fe040793          	addi	a5,s0,-32
    5dbe:	853e                	mv	a0,a5
    5dc0:	00001097          	auipc	ra,0x1
    5dc4:	2c2080e7          	jalr	706(ra) # 7082 <wait>
  if(xstatus != 0)
    5dc8:	fe042783          	lw	a5,-32(s0)
    5dcc:	cb81                	beqz	a5,5ddc <bigargtest+0x10a>
    exit(xstatus);
    5dce:	fe042783          	lw	a5,-32(s0)
    5dd2:	853e                	mv	a0,a5
    5dd4:	00001097          	auipc	ra,0x1
    5dd8:	2a6080e7          	jalr	678(ra) # 707a <exit>
  fd = open("bigarg-ok", 0);
    5ddc:	4581                	li	a1,0
    5dde:	00004517          	auipc	a0,0x4
    5de2:	3b250513          	addi	a0,a0,946 # a190 <schedule_rm+0x2396>
    5de6:	00001097          	auipc	ra,0x1
    5dea:	2d4080e7          	jalr	724(ra) # 70ba <open>
    5dee:	87aa                	mv	a5,a0
    5df0:	fef42223          	sw	a5,-28(s0)
  if(fd < 0){
    5df4:	fe442783          	lw	a5,-28(s0)
    5df8:	2781                	sext.w	a5,a5
    5dfa:	0207d163          	bgez	a5,5e1c <bigargtest+0x14a>
    printf("%s: bigarg test failed!\n", s);
    5dfe:	fd843583          	ld	a1,-40(s0)
    5e02:	00004517          	auipc	a0,0x4
    5e06:	49e50513          	addi	a0,a0,1182 # a2a0 <schedule_rm+0x24a6>
    5e0a:	00001097          	auipc	ra,0x1
    5e0e:	7b6080e7          	jalr	1974(ra) # 75c0 <printf>
    exit(1);
    5e12:	4505                	li	a0,1
    5e14:	00001097          	auipc	ra,0x1
    5e18:	266080e7          	jalr	614(ra) # 707a <exit>
  }
  close(fd);
    5e1c:	fe442783          	lw	a5,-28(s0)
    5e20:	853e                	mv	a0,a5
    5e22:	00001097          	auipc	ra,0x1
    5e26:	280080e7          	jalr	640(ra) # 70a2 <close>
}
    5e2a:	0001                	nop
    5e2c:	70a2                	ld	ra,40(sp)
    5e2e:	7402                	ld	s0,32(sp)
    5e30:	6145                	addi	sp,sp,48
    5e32:	8082                	ret

0000000000005e34 <fsfull>:

// what happens when the file system runs out of blocks?
// answer: balloc panics, so this test is not useful.
void
fsfull()
{
    5e34:	7159                	addi	sp,sp,-112
    5e36:	f486                	sd	ra,104(sp)
    5e38:	f0a2                	sd	s0,96(sp)
    5e3a:	1880                	addi	s0,sp,112
  int nfiles;
  int fsblocks = 0;
    5e3c:	fe042423          	sw	zero,-24(s0)

  printf("fsfull test\n");
    5e40:	00004517          	auipc	a0,0x4
    5e44:	48050513          	addi	a0,a0,1152 # a2c0 <schedule_rm+0x24c6>
    5e48:	00001097          	auipc	ra,0x1
    5e4c:	778080e7          	jalr	1912(ra) # 75c0 <printf>

  for(nfiles = 0; ; nfiles++){
    5e50:	fe042623          	sw	zero,-20(s0)
    char name[64];
    name[0] = 'f';
    5e54:	06600793          	li	a5,102
    5e58:	f8f40c23          	sb	a5,-104(s0)
    name[1] = '0' + nfiles / 1000;
    5e5c:	fec42703          	lw	a4,-20(s0)
    5e60:	3e800793          	li	a5,1000
    5e64:	02f747bb          	divw	a5,a4,a5
    5e68:	2781                	sext.w	a5,a5
    5e6a:	0ff7f793          	andi	a5,a5,255
    5e6e:	0307879b          	addiw	a5,a5,48
    5e72:	0ff7f793          	andi	a5,a5,255
    5e76:	f8f40ca3          	sb	a5,-103(s0)
    name[2] = '0' + (nfiles % 1000) / 100;
    5e7a:	fec42703          	lw	a4,-20(s0)
    5e7e:	3e800793          	li	a5,1000
    5e82:	02f767bb          	remw	a5,a4,a5
    5e86:	2781                	sext.w	a5,a5
    5e88:	873e                	mv	a4,a5
    5e8a:	06400793          	li	a5,100
    5e8e:	02f747bb          	divw	a5,a4,a5
    5e92:	2781                	sext.w	a5,a5
    5e94:	0ff7f793          	andi	a5,a5,255
    5e98:	0307879b          	addiw	a5,a5,48
    5e9c:	0ff7f793          	andi	a5,a5,255
    5ea0:	f8f40d23          	sb	a5,-102(s0)
    name[3] = '0' + (nfiles % 100) / 10;
    5ea4:	fec42703          	lw	a4,-20(s0)
    5ea8:	06400793          	li	a5,100
    5eac:	02f767bb          	remw	a5,a4,a5
    5eb0:	2781                	sext.w	a5,a5
    5eb2:	873e                	mv	a4,a5
    5eb4:	47a9                	li	a5,10
    5eb6:	02f747bb          	divw	a5,a4,a5
    5eba:	2781                	sext.w	a5,a5
    5ebc:	0ff7f793          	andi	a5,a5,255
    5ec0:	0307879b          	addiw	a5,a5,48
    5ec4:	0ff7f793          	andi	a5,a5,255
    5ec8:	f8f40da3          	sb	a5,-101(s0)
    name[4] = '0' + (nfiles % 10);
    5ecc:	fec42703          	lw	a4,-20(s0)
    5ed0:	47a9                	li	a5,10
    5ed2:	02f767bb          	remw	a5,a4,a5
    5ed6:	2781                	sext.w	a5,a5
    5ed8:	0ff7f793          	andi	a5,a5,255
    5edc:	0307879b          	addiw	a5,a5,48
    5ee0:	0ff7f793          	andi	a5,a5,255
    5ee4:	f8f40e23          	sb	a5,-100(s0)
    name[5] = '\0';
    5ee8:	f8040ea3          	sb	zero,-99(s0)
    printf("writing %s\n", name);
    5eec:	f9840793          	addi	a5,s0,-104
    5ef0:	85be                	mv	a1,a5
    5ef2:	00004517          	auipc	a0,0x4
    5ef6:	3de50513          	addi	a0,a0,990 # a2d0 <schedule_rm+0x24d6>
    5efa:	00001097          	auipc	ra,0x1
    5efe:	6c6080e7          	jalr	1734(ra) # 75c0 <printf>
    int fd = open(name, O_CREATE|O_RDWR);
    5f02:	f9840793          	addi	a5,s0,-104
    5f06:	20200593          	li	a1,514
    5f0a:	853e                	mv	a0,a5
    5f0c:	00001097          	auipc	ra,0x1
    5f10:	1ae080e7          	jalr	430(ra) # 70ba <open>
    5f14:	87aa                	mv	a5,a0
    5f16:	fef42023          	sw	a5,-32(s0)
    if(fd < 0){
    5f1a:	fe042783          	lw	a5,-32(s0)
    5f1e:	2781                	sext.w	a5,a5
    5f20:	0007de63          	bgez	a5,5f3c <fsfull+0x108>
      printf("open %s failed\n", name);
    5f24:	f9840793          	addi	a5,s0,-104
    5f28:	85be                	mv	a1,a5
    5f2a:	00004517          	auipc	a0,0x4
    5f2e:	3b650513          	addi	a0,a0,950 # a2e0 <schedule_rm+0x24e6>
    5f32:	00001097          	auipc	ra,0x1
    5f36:	68e080e7          	jalr	1678(ra) # 75c0 <printf>
      break;
    5f3a:	a071                	j	5fc6 <fsfull+0x192>
    }
    int total = 0;
    5f3c:	fe042223          	sw	zero,-28(s0)
    while(1){
      int cc = write(fd, buf, BSIZE);
    5f40:	fe042783          	lw	a5,-32(s0)
    5f44:	40000613          	li	a2,1024
    5f48:	00005597          	auipc	a1,0x5
    5f4c:	9b858593          	addi	a1,a1,-1608 # a900 <buf>
    5f50:	853e                	mv	a0,a5
    5f52:	00001097          	auipc	ra,0x1
    5f56:	148080e7          	jalr	328(ra) # 709a <write>
    5f5a:	87aa                	mv	a5,a0
    5f5c:	fcf42e23          	sw	a5,-36(s0)
      if(cc < BSIZE)
    5f60:	fdc42783          	lw	a5,-36(s0)
    5f64:	0007871b          	sext.w	a4,a5
    5f68:	3ff00793          	li	a5,1023
    5f6c:	00e7df63          	bge	a5,a4,5f8a <fsfull+0x156>
        break;
      total += cc;
    5f70:	fe442703          	lw	a4,-28(s0)
    5f74:	fdc42783          	lw	a5,-36(s0)
    5f78:	9fb9                	addw	a5,a5,a4
    5f7a:	fef42223          	sw	a5,-28(s0)
      fsblocks++;
    5f7e:	fe842783          	lw	a5,-24(s0)
    5f82:	2785                	addiw	a5,a5,1
    5f84:	fef42423          	sw	a5,-24(s0)
    while(1){
    5f88:	bf65                	j	5f40 <fsfull+0x10c>
        break;
    5f8a:	0001                	nop
    }
    printf("wrote %d bytes\n", total);
    5f8c:	fe442783          	lw	a5,-28(s0)
    5f90:	85be                	mv	a1,a5
    5f92:	00004517          	auipc	a0,0x4
    5f96:	35e50513          	addi	a0,a0,862 # a2f0 <schedule_rm+0x24f6>
    5f9a:	00001097          	auipc	ra,0x1
    5f9e:	626080e7          	jalr	1574(ra) # 75c0 <printf>
    close(fd);
    5fa2:	fe042783          	lw	a5,-32(s0)
    5fa6:	853e                	mv	a0,a5
    5fa8:	00001097          	auipc	ra,0x1
    5fac:	0fa080e7          	jalr	250(ra) # 70a2 <close>
    if(total == 0)
    5fb0:	fe442783          	lw	a5,-28(s0)
    5fb4:	2781                	sext.w	a5,a5
    5fb6:	c799                	beqz	a5,5fc4 <fsfull+0x190>
  for(nfiles = 0; ; nfiles++){
    5fb8:	fec42783          	lw	a5,-20(s0)
    5fbc:	2785                	addiw	a5,a5,1
    5fbe:	fef42623          	sw	a5,-20(s0)
    5fc2:	bd49                	j	5e54 <fsfull+0x20>
      break;
    5fc4:	0001                	nop
  }

  while(nfiles >= 0){
    5fc6:	a84d                	j	6078 <fsfull+0x244>
    char name[64];
    name[0] = 'f';
    5fc8:	06600793          	li	a5,102
    5fcc:	f8f40c23          	sb	a5,-104(s0)
    name[1] = '0' + nfiles / 1000;
    5fd0:	fec42703          	lw	a4,-20(s0)
    5fd4:	3e800793          	li	a5,1000
    5fd8:	02f747bb          	divw	a5,a4,a5
    5fdc:	2781                	sext.w	a5,a5
    5fde:	0ff7f793          	andi	a5,a5,255
    5fe2:	0307879b          	addiw	a5,a5,48
    5fe6:	0ff7f793          	andi	a5,a5,255
    5fea:	f8f40ca3          	sb	a5,-103(s0)
    name[2] = '0' + (nfiles % 1000) / 100;
    5fee:	fec42703          	lw	a4,-20(s0)
    5ff2:	3e800793          	li	a5,1000
    5ff6:	02f767bb          	remw	a5,a4,a5
    5ffa:	2781                	sext.w	a5,a5
    5ffc:	873e                	mv	a4,a5
    5ffe:	06400793          	li	a5,100
    6002:	02f747bb          	divw	a5,a4,a5
    6006:	2781                	sext.w	a5,a5
    6008:	0ff7f793          	andi	a5,a5,255
    600c:	0307879b          	addiw	a5,a5,48
    6010:	0ff7f793          	andi	a5,a5,255
    6014:	f8f40d23          	sb	a5,-102(s0)
    name[3] = '0' + (nfiles % 100) / 10;
    6018:	fec42703          	lw	a4,-20(s0)
    601c:	06400793          	li	a5,100
    6020:	02f767bb          	remw	a5,a4,a5
    6024:	2781                	sext.w	a5,a5
    6026:	873e                	mv	a4,a5
    6028:	47a9                	li	a5,10
    602a:	02f747bb          	divw	a5,a4,a5
    602e:	2781                	sext.w	a5,a5
    6030:	0ff7f793          	andi	a5,a5,255
    6034:	0307879b          	addiw	a5,a5,48
    6038:	0ff7f793          	andi	a5,a5,255
    603c:	f8f40da3          	sb	a5,-101(s0)
    name[4] = '0' + (nfiles % 10);
    6040:	fec42703          	lw	a4,-20(s0)
    6044:	47a9                	li	a5,10
    6046:	02f767bb          	remw	a5,a4,a5
    604a:	2781                	sext.w	a5,a5
    604c:	0ff7f793          	andi	a5,a5,255
    6050:	0307879b          	addiw	a5,a5,48
    6054:	0ff7f793          	andi	a5,a5,255
    6058:	f8f40e23          	sb	a5,-100(s0)
    name[5] = '\0';
    605c:	f8040ea3          	sb	zero,-99(s0)
    unlink(name);
    6060:	f9840793          	addi	a5,s0,-104
    6064:	853e                	mv	a0,a5
    6066:	00001097          	auipc	ra,0x1
    606a:	064080e7          	jalr	100(ra) # 70ca <unlink>
    nfiles--;
    606e:	fec42783          	lw	a5,-20(s0)
    6072:	37fd                	addiw	a5,a5,-1
    6074:	fef42623          	sw	a5,-20(s0)
  while(nfiles >= 0){
    6078:	fec42783          	lw	a5,-20(s0)
    607c:	2781                	sext.w	a5,a5
    607e:	f407d5e3          	bgez	a5,5fc8 <fsfull+0x194>
  }

  printf("fsfull test finished\n");
    6082:	00004517          	auipc	a0,0x4
    6086:	27e50513          	addi	a0,a0,638 # a300 <schedule_rm+0x2506>
    608a:	00001097          	auipc	ra,0x1
    608e:	536080e7          	jalr	1334(ra) # 75c0 <printf>
}
    6092:	0001                	nop
    6094:	70a6                	ld	ra,104(sp)
    6096:	7406                	ld	s0,96(sp)
    6098:	6165                	addi	sp,sp,112
    609a:	8082                	ret

000000000000609c <argptest>:

void argptest(char *s)
{
    609c:	7179                	addi	sp,sp,-48
    609e:	f406                	sd	ra,40(sp)
    60a0:	f022                	sd	s0,32(sp)
    60a2:	1800                	addi	s0,sp,48
    60a4:	fca43c23          	sd	a0,-40(s0)
  int fd;
  fd = open("init", O_RDONLY);
    60a8:	4581                	li	a1,0
    60aa:	00004517          	auipc	a0,0x4
    60ae:	26e50513          	addi	a0,a0,622 # a318 <schedule_rm+0x251e>
    60b2:	00001097          	auipc	ra,0x1
    60b6:	008080e7          	jalr	8(ra) # 70ba <open>
    60ba:	87aa                	mv	a5,a0
    60bc:	fef42623          	sw	a5,-20(s0)
  if (fd < 0) {
    60c0:	fec42783          	lw	a5,-20(s0)
    60c4:	2781                	sext.w	a5,a5
    60c6:	0207d163          	bgez	a5,60e8 <argptest+0x4c>
    printf("%s: open failed\n", s);
    60ca:	fd843583          	ld	a1,-40(s0)
    60ce:	00002517          	auipc	a0,0x2
    60d2:	7fa50513          	addi	a0,a0,2042 # 88c8 <schedule_rm+0xace>
    60d6:	00001097          	auipc	ra,0x1
    60da:	4ea080e7          	jalr	1258(ra) # 75c0 <printf>
    exit(1);
    60de:	4505                	li	a0,1
    60e0:	00001097          	auipc	ra,0x1
    60e4:	f9a080e7          	jalr	-102(ra) # 707a <exit>
  }
  read(fd, sbrk(0) - 1, -1);
    60e8:	4501                	li	a0,0
    60ea:	00001097          	auipc	ra,0x1
    60ee:	018080e7          	jalr	24(ra) # 7102 <sbrk>
    60f2:	87aa                	mv	a5,a0
    60f4:	fff78713          	addi	a4,a5,-1
    60f8:	fec42783          	lw	a5,-20(s0)
    60fc:	567d                	li	a2,-1
    60fe:	85ba                	mv	a1,a4
    6100:	853e                	mv	a0,a5
    6102:	00001097          	auipc	ra,0x1
    6106:	f90080e7          	jalr	-112(ra) # 7092 <read>
  close(fd);
    610a:	fec42783          	lw	a5,-20(s0)
    610e:	853e                	mv	a0,a5
    6110:	00001097          	auipc	ra,0x1
    6114:	f92080e7          	jalr	-110(ra) # 70a2 <close>
}
    6118:	0001                	nop
    611a:	70a2                	ld	ra,40(sp)
    611c:	7402                	ld	s0,32(sp)
    611e:	6145                	addi	sp,sp,48
    6120:	8082                	ret

0000000000006122 <rand>:

unsigned long randstate = 1;
unsigned int
rand()
{
    6122:	1141                	addi	sp,sp,-16
    6124:	e422                	sd	s0,8(sp)
    6126:	0800                	addi	s0,sp,16
  randstate = randstate * 1664525 + 1013904223;
    6128:	00004797          	auipc	a5,0x4
    612c:	7d078793          	addi	a5,a5,2000 # a8f8 <randstate>
    6130:	6398                	ld	a4,0(a5)
    6132:	001967b7          	lui	a5,0x196
    6136:	60d78793          	addi	a5,a5,1549 # 19660d <__BSS_END__+0x1854dd>
    613a:	02f70733          	mul	a4,a4,a5
    613e:	3c6ef7b7          	lui	a5,0x3c6ef
    6142:	35f78793          	addi	a5,a5,863 # 3c6ef35f <__BSS_END__+0x3c6de22f>
    6146:	973e                	add	a4,a4,a5
    6148:	00004797          	auipc	a5,0x4
    614c:	7b078793          	addi	a5,a5,1968 # a8f8 <randstate>
    6150:	e398                	sd	a4,0(a5)
  return randstate;
    6152:	00004797          	auipc	a5,0x4
    6156:	7a678793          	addi	a5,a5,1958 # a8f8 <randstate>
    615a:	639c                	ld	a5,0(a5)
    615c:	2781                	sext.w	a5,a5
}
    615e:	853e                	mv	a0,a5
    6160:	6422                	ld	s0,8(sp)
    6162:	0141                	addi	sp,sp,16
    6164:	8082                	ret

0000000000006166 <stacktest>:

// check that there's an invalid page beneath
// the user stack, to catch stack overflow.
void
stacktest(char *s)
{
    6166:	7139                	addi	sp,sp,-64
    6168:	fc06                	sd	ra,56(sp)
    616a:	f822                	sd	s0,48(sp)
    616c:	0080                	addi	s0,sp,64
    616e:	fca43423          	sd	a0,-56(s0)
  int pid;
  int xstatus;
  
  pid = fork();
    6172:	00001097          	auipc	ra,0x1
    6176:	f00080e7          	jalr	-256(ra) # 7072 <fork>
    617a:	87aa                	mv	a5,a0
    617c:	fef42623          	sw	a5,-20(s0)
  if(pid == 0) {
    6180:	fec42783          	lw	a5,-20(s0)
    6184:	2781                	sext.w	a5,a5
    6186:	e3b9                	bnez	a5,61cc <stacktest+0x66>
    char *sp = (char *) r_sp();
    6188:	ffffa097          	auipc	ra,0xffffa
    618c:	e78080e7          	jalr	-392(ra) # 0 <r_sp>
    6190:	87aa                	mv	a5,a0
    6192:	fef43023          	sd	a5,-32(s0)
    sp -= PGSIZE;
    6196:	fe043703          	ld	a4,-32(s0)
    619a:	77fd                	lui	a5,0xfffff
    619c:	97ba                	add	a5,a5,a4
    619e:	fef43023          	sd	a5,-32(s0)
    // the *sp should cause a trap.
    printf("%s: stacktest: read below stack %p\n", s, *sp);
    61a2:	fe043783          	ld	a5,-32(s0)
    61a6:	0007c783          	lbu	a5,0(a5) # fffffffffffff000 <__BSS_END__+0xfffffffffffeded0>
    61aa:	2781                	sext.w	a5,a5
    61ac:	863e                	mv	a2,a5
    61ae:	fc843583          	ld	a1,-56(s0)
    61b2:	00004517          	auipc	a0,0x4
    61b6:	16e50513          	addi	a0,a0,366 # a320 <schedule_rm+0x2526>
    61ba:	00001097          	auipc	ra,0x1
    61be:	406080e7          	jalr	1030(ra) # 75c0 <printf>
    exit(1);
    61c2:	4505                	li	a0,1
    61c4:	00001097          	auipc	ra,0x1
    61c8:	eb6080e7          	jalr	-330(ra) # 707a <exit>
  } else if(pid < 0){
    61cc:	fec42783          	lw	a5,-20(s0)
    61d0:	2781                	sext.w	a5,a5
    61d2:	0207d163          	bgez	a5,61f4 <stacktest+0x8e>
    printf("%s: fork failed\n", s);
    61d6:	fc843583          	ld	a1,-56(s0)
    61da:	00002517          	auipc	a0,0x2
    61de:	6d650513          	addi	a0,a0,1750 # 88b0 <schedule_rm+0xab6>
    61e2:	00001097          	auipc	ra,0x1
    61e6:	3de080e7          	jalr	990(ra) # 75c0 <printf>
    exit(1);
    61ea:	4505                	li	a0,1
    61ec:	00001097          	auipc	ra,0x1
    61f0:	e8e080e7          	jalr	-370(ra) # 707a <exit>
  }
  wait(&xstatus);
    61f4:	fdc40793          	addi	a5,s0,-36
    61f8:	853e                	mv	a0,a5
    61fa:	00001097          	auipc	ra,0x1
    61fe:	e88080e7          	jalr	-376(ra) # 7082 <wait>
  if(xstatus == -1)  // kernel killed child?
    6202:	fdc42783          	lw	a5,-36(s0)
    6206:	873e                	mv	a4,a5
    6208:	57fd                	li	a5,-1
    620a:	00f71763          	bne	a4,a5,6218 <stacktest+0xb2>
    exit(0);
    620e:	4501                	li	a0,0
    6210:	00001097          	auipc	ra,0x1
    6214:	e6a080e7          	jalr	-406(ra) # 707a <exit>
  else
    exit(xstatus);
    6218:	fdc42783          	lw	a5,-36(s0)
    621c:	853e                	mv	a0,a5
    621e:	00001097          	auipc	ra,0x1
    6222:	e5c080e7          	jalr	-420(ra) # 707a <exit>

0000000000006226 <pgbug>:
// regression test. copyin(), copyout(), and copyinstr() used to cast
// the virtual page address to uint, which (with certain wild system
// call arguments) resulted in a kernel page faults.
void
pgbug(char *s)
{
    6226:	7179                	addi	sp,sp,-48
    6228:	f406                	sd	ra,40(sp)
    622a:	f022                	sd	s0,32(sp)
    622c:	1800                	addi	s0,sp,48
    622e:	fca43c23          	sd	a0,-40(s0)
  char *argv[1];
  argv[0] = 0;
    6232:	fe043423          	sd	zero,-24(s0)
  exec((char*)0xeaeb0b5b00002f5e, argv);
    6236:	fe840713          	addi	a4,s0,-24
    623a:	00004797          	auipc	a5,0x4
    623e:	69678793          	addi	a5,a5,1686 # a8d0 <schedule_rm+0x2ad6>
    6242:	639c                	ld	a5,0(a5)
    6244:	85ba                	mv	a1,a4
    6246:	853e                	mv	a0,a5
    6248:	00001097          	auipc	ra,0x1
    624c:	e6a080e7          	jalr	-406(ra) # 70b2 <exec>

  pipe((int*)0xeaeb0b5b00002f5e);
    6250:	00004797          	auipc	a5,0x4
    6254:	68078793          	addi	a5,a5,1664 # a8d0 <schedule_rm+0x2ad6>
    6258:	639c                	ld	a5,0(a5)
    625a:	853e                	mv	a0,a5
    625c:	00001097          	auipc	ra,0x1
    6260:	e2e080e7          	jalr	-466(ra) # 708a <pipe>

  exit(0);
    6264:	4501                	li	a0,0
    6266:	00001097          	auipc	ra,0x1
    626a:	e14080e7          	jalr	-492(ra) # 707a <exit>

000000000000626e <sbrkbugs>:
// regression test. does the kernel panic if a process sbrk()s its
// size to be less than a page, or zero, or reduces the break by an
// amount too small to cause a page to be freed?
void
sbrkbugs(char *s)
{
    626e:	7179                	addi	sp,sp,-48
    6270:	f406                	sd	ra,40(sp)
    6272:	f022                	sd	s0,32(sp)
    6274:	1800                	addi	s0,sp,48
    6276:	fca43c23          	sd	a0,-40(s0)
  int pid = fork();
    627a:	00001097          	auipc	ra,0x1
    627e:	df8080e7          	jalr	-520(ra) # 7072 <fork>
    6282:	87aa                	mv	a5,a0
    6284:	fef42623          	sw	a5,-20(s0)
  if(pid < 0){
    6288:	fec42783          	lw	a5,-20(s0)
    628c:	2781                	sext.w	a5,a5
    628e:	0007df63          	bgez	a5,62ac <sbrkbugs+0x3e>
    printf("fork failed\n");
    6292:	00002517          	auipc	a0,0x2
    6296:	3f650513          	addi	a0,a0,1014 # 8688 <schedule_rm+0x88e>
    629a:	00001097          	auipc	ra,0x1
    629e:	326080e7          	jalr	806(ra) # 75c0 <printf>
    exit(1);
    62a2:	4505                	li	a0,1
    62a4:	00001097          	auipc	ra,0x1
    62a8:	dd6080e7          	jalr	-554(ra) # 707a <exit>
  }
  if(pid == 0){
    62ac:	fec42783          	lw	a5,-20(s0)
    62b0:	2781                	sext.w	a5,a5
    62b2:	eb85                	bnez	a5,62e2 <sbrkbugs+0x74>
    int sz = (uint64) sbrk(0);
    62b4:	4501                	li	a0,0
    62b6:	00001097          	auipc	ra,0x1
    62ba:	e4c080e7          	jalr	-436(ra) # 7102 <sbrk>
    62be:	87aa                	mv	a5,a0
    62c0:	fef42223          	sw	a5,-28(s0)
    // free all user memory; there used to be a bug that
    // would not adjust p->sz correctly in this case,
    // causing exit() to panic.
    sbrk(-sz);
    62c4:	fe442783          	lw	a5,-28(s0)
    62c8:	40f007bb          	negw	a5,a5
    62cc:	2781                	sext.w	a5,a5
    62ce:	853e                	mv	a0,a5
    62d0:	00001097          	auipc	ra,0x1
    62d4:	e32080e7          	jalr	-462(ra) # 7102 <sbrk>
    // user page fault here.
    exit(0);
    62d8:	4501                	li	a0,0
    62da:	00001097          	auipc	ra,0x1
    62de:	da0080e7          	jalr	-608(ra) # 707a <exit>
  }
  wait(0);
    62e2:	4501                	li	a0,0
    62e4:	00001097          	auipc	ra,0x1
    62e8:	d9e080e7          	jalr	-610(ra) # 7082 <wait>

  pid = fork();
    62ec:	00001097          	auipc	ra,0x1
    62f0:	d86080e7          	jalr	-634(ra) # 7072 <fork>
    62f4:	87aa                	mv	a5,a0
    62f6:	fef42623          	sw	a5,-20(s0)
  if(pid < 0){
    62fa:	fec42783          	lw	a5,-20(s0)
    62fe:	2781                	sext.w	a5,a5
    6300:	0007df63          	bgez	a5,631e <sbrkbugs+0xb0>
    printf("fork failed\n");
    6304:	00002517          	auipc	a0,0x2
    6308:	38450513          	addi	a0,a0,900 # 8688 <schedule_rm+0x88e>
    630c:	00001097          	auipc	ra,0x1
    6310:	2b4080e7          	jalr	692(ra) # 75c0 <printf>
    exit(1);
    6314:	4505                	li	a0,1
    6316:	00001097          	auipc	ra,0x1
    631a:	d64080e7          	jalr	-668(ra) # 707a <exit>
  }
  if(pid == 0){
    631e:	fec42783          	lw	a5,-20(s0)
    6322:	2781                	sext.w	a5,a5
    6324:	eb9d                	bnez	a5,635a <sbrkbugs+0xec>
    int sz = (uint64) sbrk(0);
    6326:	4501                	li	a0,0
    6328:	00001097          	auipc	ra,0x1
    632c:	dda080e7          	jalr	-550(ra) # 7102 <sbrk>
    6330:	87aa                	mv	a5,a0
    6332:	fef42423          	sw	a5,-24(s0)
    // set the break to somewhere in the very first
    // page; there used to be a bug that would incorrectly
    // free the first page.
    sbrk(-(sz - 3500));
    6336:	6785                	lui	a5,0x1
    6338:	dac7871b          	addiw	a4,a5,-596
    633c:	fe842783          	lw	a5,-24(s0)
    6340:	40f707bb          	subw	a5,a4,a5
    6344:	2781                	sext.w	a5,a5
    6346:	853e                	mv	a0,a5
    6348:	00001097          	auipc	ra,0x1
    634c:	dba080e7          	jalr	-582(ra) # 7102 <sbrk>
    exit(0);
    6350:	4501                	li	a0,0
    6352:	00001097          	auipc	ra,0x1
    6356:	d28080e7          	jalr	-728(ra) # 707a <exit>
  }
  wait(0);
    635a:	4501                	li	a0,0
    635c:	00001097          	auipc	ra,0x1
    6360:	d26080e7          	jalr	-730(ra) # 7082 <wait>

  pid = fork();
    6364:	00001097          	auipc	ra,0x1
    6368:	d0e080e7          	jalr	-754(ra) # 7072 <fork>
    636c:	87aa                	mv	a5,a0
    636e:	fef42623          	sw	a5,-20(s0)
  if(pid < 0){
    6372:	fec42783          	lw	a5,-20(s0)
    6376:	2781                	sext.w	a5,a5
    6378:	0007df63          	bgez	a5,6396 <sbrkbugs+0x128>
    printf("fork failed\n");
    637c:	00002517          	auipc	a0,0x2
    6380:	30c50513          	addi	a0,a0,780 # 8688 <schedule_rm+0x88e>
    6384:	00001097          	auipc	ra,0x1
    6388:	23c080e7          	jalr	572(ra) # 75c0 <printf>
    exit(1);
    638c:	4505                	li	a0,1
    638e:	00001097          	auipc	ra,0x1
    6392:	cec080e7          	jalr	-788(ra) # 707a <exit>
  }
  if(pid == 0){
    6396:	fec42783          	lw	a5,-20(s0)
    639a:	2781                	sext.w	a5,a5
    639c:	ef95                	bnez	a5,63d8 <sbrkbugs+0x16a>
    // set the break in the middle of a page.
    sbrk((10*4096 + 2048) - (uint64)sbrk(0));
    639e:	4501                	li	a0,0
    63a0:	00001097          	auipc	ra,0x1
    63a4:	d62080e7          	jalr	-670(ra) # 7102 <sbrk>
    63a8:	87aa                	mv	a5,a0
    63aa:	2781                	sext.w	a5,a5
    63ac:	672d                	lui	a4,0xb
    63ae:	8007071b          	addiw	a4,a4,-2048
    63b2:	40f707bb          	subw	a5,a4,a5
    63b6:	2781                	sext.w	a5,a5
    63b8:	2781                	sext.w	a5,a5
    63ba:	853e                	mv	a0,a5
    63bc:	00001097          	auipc	ra,0x1
    63c0:	d46080e7          	jalr	-698(ra) # 7102 <sbrk>

    // reduce the break a bit, but not enough to
    // cause a page to be freed. this used to cause
    // a panic.
    sbrk(-10);
    63c4:	5559                	li	a0,-10
    63c6:	00001097          	auipc	ra,0x1
    63ca:	d3c080e7          	jalr	-708(ra) # 7102 <sbrk>

    exit(0);
    63ce:	4501                	li	a0,0
    63d0:	00001097          	auipc	ra,0x1
    63d4:	caa080e7          	jalr	-854(ra) # 707a <exit>
  }
  wait(0);
    63d8:	4501                	li	a0,0
    63da:	00001097          	auipc	ra,0x1
    63de:	ca8080e7          	jalr	-856(ra) # 7082 <wait>

  exit(0);
    63e2:	4501                	li	a0,0
    63e4:	00001097          	auipc	ra,0x1
    63e8:	c96080e7          	jalr	-874(ra) # 707a <exit>

00000000000063ec <badwrite>:
// file is deleted? if the kernel has this bug, it will panic: balloc:
// out of blocks. assumed_free may need to be raised to be more than
// the number of free blocks. this test takes a long time.
void
badwrite(char *s)
{
    63ec:	7179                	addi	sp,sp,-48
    63ee:	f406                	sd	ra,40(sp)
    63f0:	f022                	sd	s0,32(sp)
    63f2:	1800                	addi	s0,sp,48
    63f4:	fca43c23          	sd	a0,-40(s0)
  int assumed_free = 600;
    63f8:	25800793          	li	a5,600
    63fc:	fef42423          	sw	a5,-24(s0)
  
  unlink("junk");
    6400:	00004517          	auipc	a0,0x4
    6404:	f4850513          	addi	a0,a0,-184 # a348 <schedule_rm+0x254e>
    6408:	00001097          	auipc	ra,0x1
    640c:	cc2080e7          	jalr	-830(ra) # 70ca <unlink>
  for(int i = 0; i < assumed_free; i++){
    6410:	fe042623          	sw	zero,-20(s0)
    6414:	a8bd                	j	6492 <badwrite+0xa6>
    int fd = open("junk", O_CREATE|O_WRONLY);
    6416:	20100593          	li	a1,513
    641a:	00004517          	auipc	a0,0x4
    641e:	f2e50513          	addi	a0,a0,-210 # a348 <schedule_rm+0x254e>
    6422:	00001097          	auipc	ra,0x1
    6426:	c98080e7          	jalr	-872(ra) # 70ba <open>
    642a:	87aa                	mv	a5,a0
    642c:	fef42023          	sw	a5,-32(s0)
    if(fd < 0){
    6430:	fe042783          	lw	a5,-32(s0)
    6434:	2781                	sext.w	a5,a5
    6436:	0007df63          	bgez	a5,6454 <badwrite+0x68>
      printf("open junk failed\n");
    643a:	00004517          	auipc	a0,0x4
    643e:	f1650513          	addi	a0,a0,-234 # a350 <schedule_rm+0x2556>
    6442:	00001097          	auipc	ra,0x1
    6446:	17e080e7          	jalr	382(ra) # 75c0 <printf>
      exit(1);
    644a:	4505                	li	a0,1
    644c:	00001097          	auipc	ra,0x1
    6450:	c2e080e7          	jalr	-978(ra) # 707a <exit>
    }
    write(fd, (char*)0xffffffffffL, 1);
    6454:	fe042703          	lw	a4,-32(s0)
    6458:	4605                	li	a2,1
    645a:	57fd                	li	a5,-1
    645c:	0187d593          	srli	a1,a5,0x18
    6460:	853a                	mv	a0,a4
    6462:	00001097          	auipc	ra,0x1
    6466:	c38080e7          	jalr	-968(ra) # 709a <write>
    close(fd);
    646a:	fe042783          	lw	a5,-32(s0)
    646e:	853e                	mv	a0,a5
    6470:	00001097          	auipc	ra,0x1
    6474:	c32080e7          	jalr	-974(ra) # 70a2 <close>
    unlink("junk");
    6478:	00004517          	auipc	a0,0x4
    647c:	ed050513          	addi	a0,a0,-304 # a348 <schedule_rm+0x254e>
    6480:	00001097          	auipc	ra,0x1
    6484:	c4a080e7          	jalr	-950(ra) # 70ca <unlink>
  for(int i = 0; i < assumed_free; i++){
    6488:	fec42783          	lw	a5,-20(s0)
    648c:	2785                	addiw	a5,a5,1
    648e:	fef42623          	sw	a5,-20(s0)
    6492:	fec42703          	lw	a4,-20(s0)
    6496:	fe842783          	lw	a5,-24(s0)
    649a:	2701                	sext.w	a4,a4
    649c:	2781                	sext.w	a5,a5
    649e:	f6f74ce3          	blt	a4,a5,6416 <badwrite+0x2a>
  }

  int fd = open("junk", O_CREATE|O_WRONLY);
    64a2:	20100593          	li	a1,513
    64a6:	00004517          	auipc	a0,0x4
    64aa:	ea250513          	addi	a0,a0,-350 # a348 <schedule_rm+0x254e>
    64ae:	00001097          	auipc	ra,0x1
    64b2:	c0c080e7          	jalr	-1012(ra) # 70ba <open>
    64b6:	87aa                	mv	a5,a0
    64b8:	fef42223          	sw	a5,-28(s0)
  if(fd < 0){
    64bc:	fe442783          	lw	a5,-28(s0)
    64c0:	2781                	sext.w	a5,a5
    64c2:	0007df63          	bgez	a5,64e0 <badwrite+0xf4>
    printf("open junk failed\n");
    64c6:	00004517          	auipc	a0,0x4
    64ca:	e8a50513          	addi	a0,a0,-374 # a350 <schedule_rm+0x2556>
    64ce:	00001097          	auipc	ra,0x1
    64d2:	0f2080e7          	jalr	242(ra) # 75c0 <printf>
    exit(1);
    64d6:	4505                	li	a0,1
    64d8:	00001097          	auipc	ra,0x1
    64dc:	ba2080e7          	jalr	-1118(ra) # 707a <exit>
  }
  if(write(fd, "x", 1) != 1){
    64e0:	fe442783          	lw	a5,-28(s0)
    64e4:	4605                	li	a2,1
    64e6:	00002597          	auipc	a1,0x2
    64ea:	0a258593          	addi	a1,a1,162 # 8588 <schedule_rm+0x78e>
    64ee:	853e                	mv	a0,a5
    64f0:	00001097          	auipc	ra,0x1
    64f4:	baa080e7          	jalr	-1110(ra) # 709a <write>
    64f8:	87aa                	mv	a5,a0
    64fa:	873e                	mv	a4,a5
    64fc:	4785                	li	a5,1
    64fe:	00f70f63          	beq	a4,a5,651c <badwrite+0x130>
    printf("write failed\n");
    6502:	00004517          	auipc	a0,0x4
    6506:	e6650513          	addi	a0,a0,-410 # a368 <schedule_rm+0x256e>
    650a:	00001097          	auipc	ra,0x1
    650e:	0b6080e7          	jalr	182(ra) # 75c0 <printf>
    exit(1);
    6512:	4505                	li	a0,1
    6514:	00001097          	auipc	ra,0x1
    6518:	b66080e7          	jalr	-1178(ra) # 707a <exit>
  }
  close(fd);
    651c:	fe442783          	lw	a5,-28(s0)
    6520:	853e                	mv	a0,a5
    6522:	00001097          	auipc	ra,0x1
    6526:	b80080e7          	jalr	-1152(ra) # 70a2 <close>
  unlink("junk");
    652a:	00004517          	auipc	a0,0x4
    652e:	e1e50513          	addi	a0,a0,-482 # a348 <schedule_rm+0x254e>
    6532:	00001097          	auipc	ra,0x1
    6536:	b98080e7          	jalr	-1128(ra) # 70ca <unlink>

  exit(0);
    653a:	4501                	li	a0,0
    653c:	00001097          	auipc	ra,0x1
    6540:	b3e080e7          	jalr	-1218(ra) # 707a <exit>

0000000000006544 <badarg>:

// regression test. test whether exec() leaks memory if one of the
// arguments is invalid. the test passes if the kernel doesn't panic.
void
badarg(char *s)
{
    6544:	7139                	addi	sp,sp,-64
    6546:	fc06                	sd	ra,56(sp)
    6548:	f822                	sd	s0,48(sp)
    654a:	0080                	addi	s0,sp,64
    654c:	fca43423          	sd	a0,-56(s0)
  for(int i = 0; i < 50000; i++){
    6550:	fe042623          	sw	zero,-20(s0)
    6554:	a03d                	j	6582 <badarg+0x3e>
    char *argv[2];
    argv[0] = (char*)0xffffffff;
    6556:	57fd                	li	a5,-1
    6558:	9381                	srli	a5,a5,0x20
    655a:	fcf43c23          	sd	a5,-40(s0)
    argv[1] = 0;
    655e:	fe043023          	sd	zero,-32(s0)
    exec("echo", argv);
    6562:	fd840793          	addi	a5,s0,-40
    6566:	85be                	mv	a1,a5
    6568:	00002517          	auipc	a0,0x2
    656c:	13050513          	addi	a0,a0,304 # 8698 <schedule_rm+0x89e>
    6570:	00001097          	auipc	ra,0x1
    6574:	b42080e7          	jalr	-1214(ra) # 70b2 <exec>
  for(int i = 0; i < 50000; i++){
    6578:	fec42783          	lw	a5,-20(s0)
    657c:	2785                	addiw	a5,a5,1
    657e:	fef42623          	sw	a5,-20(s0)
    6582:	fec42783          	lw	a5,-20(s0)
    6586:	0007871b          	sext.w	a4,a5
    658a:	67b1                	lui	a5,0xc
    658c:	34f78793          	addi	a5,a5,847 # c34f <__global_pointer$+0x1257>
    6590:	fce7d3e3          	bge	a5,a4,6556 <badarg+0x12>
  }
  
  exit(0);
    6594:	4501                	li	a0,0
    6596:	00001097          	auipc	ra,0x1
    659a:	ae4080e7          	jalr	-1308(ra) # 707a <exit>

000000000000659e <execout>:
// test the exec() code that cleans up if it runs out
// of memory. it's really a test that such a condition
// doesn't cause a panic.
void
execout(char *s)
{
    659e:	715d                	addi	sp,sp,-80
    65a0:	e486                	sd	ra,72(sp)
    65a2:	e0a2                	sd	s0,64(sp)
    65a4:	0880                	addi	s0,sp,80
    65a6:	faa43c23          	sd	a0,-72(s0)
  for(int avail = 0; avail < 15; avail++){
    65aa:	fe042623          	sw	zero,-20(s0)
    65ae:	a8c5                	j	669e <execout+0x100>
    int pid = fork();
    65b0:	00001097          	auipc	ra,0x1
    65b4:	ac2080e7          	jalr	-1342(ra) # 7072 <fork>
    65b8:	87aa                	mv	a5,a0
    65ba:	fef42223          	sw	a5,-28(s0)
    if(pid < 0){
    65be:	fe442783          	lw	a5,-28(s0)
    65c2:	2781                	sext.w	a5,a5
    65c4:	0007df63          	bgez	a5,65e2 <execout+0x44>
      printf("fork failed\n");
    65c8:	00002517          	auipc	a0,0x2
    65cc:	0c050513          	addi	a0,a0,192 # 8688 <schedule_rm+0x88e>
    65d0:	00001097          	auipc	ra,0x1
    65d4:	ff0080e7          	jalr	-16(ra) # 75c0 <printf>
      exit(1);
    65d8:	4505                	li	a0,1
    65da:	00001097          	auipc	ra,0x1
    65de:	aa0080e7          	jalr	-1376(ra) # 707a <exit>
    } else if(pid == 0){
    65e2:	fe442783          	lw	a5,-28(s0)
    65e6:	2781                	sext.w	a5,a5
    65e8:	e3cd                	bnez	a5,668a <execout+0xec>
      // allocate all of memory.
      while(1){
        uint64 a = (uint64) sbrk(4096);
    65ea:	6505                	lui	a0,0x1
    65ec:	00001097          	auipc	ra,0x1
    65f0:	b16080e7          	jalr	-1258(ra) # 7102 <sbrk>
    65f4:	87aa                	mv	a5,a0
    65f6:	fcf43c23          	sd	a5,-40(s0)
        if(a == 0xffffffffffffffffLL)
    65fa:	fd843703          	ld	a4,-40(s0)
    65fe:	57fd                	li	a5,-1
    6600:	00f70c63          	beq	a4,a5,6618 <execout+0x7a>
          break;
        *(char*)(a + 4096 - 1) = 1;
    6604:	fd843703          	ld	a4,-40(s0)
    6608:	6785                	lui	a5,0x1
    660a:	17fd                	addi	a5,a5,-1
    660c:	97ba                	add	a5,a5,a4
    660e:	873e                	mv	a4,a5
    6610:	4785                	li	a5,1
    6612:	00f70023          	sb	a5,0(a4) # b000 <buf+0x700>
      while(1){
    6616:	bfd1                	j	65ea <execout+0x4c>
          break;
    6618:	0001                	nop
      }

      // free a few pages, in order to let exec() make some
      // progress.
      for(int i = 0; i < avail; i++)
    661a:	fe042423          	sw	zero,-24(s0)
    661e:	a819                	j	6634 <execout+0x96>
        sbrk(-4096);
    6620:	757d                	lui	a0,0xfffff
    6622:	00001097          	auipc	ra,0x1
    6626:	ae0080e7          	jalr	-1312(ra) # 7102 <sbrk>
      for(int i = 0; i < avail; i++)
    662a:	fe842783          	lw	a5,-24(s0)
    662e:	2785                	addiw	a5,a5,1
    6630:	fef42423          	sw	a5,-24(s0)
    6634:	fe842703          	lw	a4,-24(s0)
    6638:	fec42783          	lw	a5,-20(s0)
    663c:	2701                	sext.w	a4,a4
    663e:	2781                	sext.w	a5,a5
    6640:	fef740e3          	blt	a4,a5,6620 <execout+0x82>
      
      close(1);
    6644:	4505                	li	a0,1
    6646:	00001097          	auipc	ra,0x1
    664a:	a5c080e7          	jalr	-1444(ra) # 70a2 <close>
      char *args[] = { "echo", "x", 0 };
    664e:	00002797          	auipc	a5,0x2
    6652:	04a78793          	addi	a5,a5,74 # 8698 <schedule_rm+0x89e>
    6656:	fcf43023          	sd	a5,-64(s0)
    665a:	00002797          	auipc	a5,0x2
    665e:	f2e78793          	addi	a5,a5,-210 # 8588 <schedule_rm+0x78e>
    6662:	fcf43423          	sd	a5,-56(s0)
    6666:	fc043823          	sd	zero,-48(s0)
      exec("echo", args);
    666a:	fc040793          	addi	a5,s0,-64
    666e:	85be                	mv	a1,a5
    6670:	00002517          	auipc	a0,0x2
    6674:	02850513          	addi	a0,a0,40 # 8698 <schedule_rm+0x89e>
    6678:	00001097          	auipc	ra,0x1
    667c:	a3a080e7          	jalr	-1478(ra) # 70b2 <exec>
      exit(0);
    6680:	4501                	li	a0,0
    6682:	00001097          	auipc	ra,0x1
    6686:	9f8080e7          	jalr	-1544(ra) # 707a <exit>
    } else {
      wait((int*)0);
    668a:	4501                	li	a0,0
    668c:	00001097          	auipc	ra,0x1
    6690:	9f6080e7          	jalr	-1546(ra) # 7082 <wait>
  for(int avail = 0; avail < 15; avail++){
    6694:	fec42783          	lw	a5,-20(s0)
    6698:	2785                	addiw	a5,a5,1
    669a:	fef42623          	sw	a5,-20(s0)
    669e:	fec42783          	lw	a5,-20(s0)
    66a2:	0007871b          	sext.w	a4,a5
    66a6:	47b9                	li	a5,14
    66a8:	f0e7d4e3          	bge	a5,a4,65b0 <execout+0x12>
    }
  }

  exit(0);
    66ac:	4501                	li	a0,0
    66ae:	00001097          	auipc	ra,0x1
    66b2:	9cc080e7          	jalr	-1588(ra) # 707a <exit>

00000000000066b6 <countfree>:
// because out of memory with lazy allocation results in the process
// taking a fault and being killed, fork and report back.
//
int
countfree()
{
    66b6:	7139                	addi	sp,sp,-64
    66b8:	fc06                	sd	ra,56(sp)
    66ba:	f822                	sd	s0,48(sp)
    66bc:	0080                	addi	s0,sp,64
  int fds[2];

  if(pipe(fds) < 0){
    66be:	fd040793          	addi	a5,s0,-48
    66c2:	853e                	mv	a0,a5
    66c4:	00001097          	auipc	ra,0x1
    66c8:	9c6080e7          	jalr	-1594(ra) # 708a <pipe>
    66cc:	87aa                	mv	a5,a0
    66ce:	0007df63          	bgez	a5,66ec <countfree+0x36>
    printf("pipe() failed in countfree()\n");
    66d2:	00004517          	auipc	a0,0x4
    66d6:	ca650513          	addi	a0,a0,-858 # a378 <schedule_rm+0x257e>
    66da:	00001097          	auipc	ra,0x1
    66de:	ee6080e7          	jalr	-282(ra) # 75c0 <printf>
    exit(1);
    66e2:	4505                	li	a0,1
    66e4:	00001097          	auipc	ra,0x1
    66e8:	996080e7          	jalr	-1642(ra) # 707a <exit>
  }
  
  int pid = fork();
    66ec:	00001097          	auipc	ra,0x1
    66f0:	986080e7          	jalr	-1658(ra) # 7072 <fork>
    66f4:	87aa                	mv	a5,a0
    66f6:	fef42423          	sw	a5,-24(s0)

  if(pid < 0){
    66fa:	fe842783          	lw	a5,-24(s0)
    66fe:	2781                	sext.w	a5,a5
    6700:	0007df63          	bgez	a5,671e <countfree+0x68>
    printf("fork failed in countfree()\n");
    6704:	00004517          	auipc	a0,0x4
    6708:	c9450513          	addi	a0,a0,-876 # a398 <schedule_rm+0x259e>
    670c:	00001097          	auipc	ra,0x1
    6710:	eb4080e7          	jalr	-332(ra) # 75c0 <printf>
    exit(1);
    6714:	4505                	li	a0,1
    6716:	00001097          	auipc	ra,0x1
    671a:	964080e7          	jalr	-1692(ra) # 707a <exit>
  }

  if(pid == 0){
    671e:	fe842783          	lw	a5,-24(s0)
    6722:	2781                	sext.w	a5,a5
    6724:	e3d1                	bnez	a5,67a8 <countfree+0xf2>
    close(fds[0]);
    6726:	fd042783          	lw	a5,-48(s0)
    672a:	853e                	mv	a0,a5
    672c:	00001097          	auipc	ra,0x1
    6730:	976080e7          	jalr	-1674(ra) # 70a2 <close>
    
    while(1){
      uint64 a = (uint64) sbrk(4096);
    6734:	6505                	lui	a0,0x1
    6736:	00001097          	auipc	ra,0x1
    673a:	9cc080e7          	jalr	-1588(ra) # 7102 <sbrk>
    673e:	87aa                	mv	a5,a0
    6740:	fcf43c23          	sd	a5,-40(s0)
      if(a == 0xffffffffffffffff){
    6744:	fd843703          	ld	a4,-40(s0)
    6748:	57fd                	li	a5,-1
    674a:	04f70963          	beq	a4,a5,679c <countfree+0xe6>
        break;
      }

      // modify the memory to make sure it's really allocated.
      *(char *)(a + 4096 - 1) = 1;
    674e:	fd843703          	ld	a4,-40(s0)
    6752:	6785                	lui	a5,0x1
    6754:	17fd                	addi	a5,a5,-1
    6756:	97ba                	add	a5,a5,a4
    6758:	873e                	mv	a4,a5
    675a:	4785                	li	a5,1
    675c:	00f70023          	sb	a5,0(a4)

      // report back one more page.
      if(write(fds[1], "x", 1) != 1){
    6760:	fd442783          	lw	a5,-44(s0)
    6764:	4605                	li	a2,1
    6766:	00002597          	auipc	a1,0x2
    676a:	e2258593          	addi	a1,a1,-478 # 8588 <schedule_rm+0x78e>
    676e:	853e                	mv	a0,a5
    6770:	00001097          	auipc	ra,0x1
    6774:	92a080e7          	jalr	-1750(ra) # 709a <write>
    6778:	87aa                	mv	a5,a0
    677a:	873e                	mv	a4,a5
    677c:	4785                	li	a5,1
    677e:	faf70be3          	beq	a4,a5,6734 <countfree+0x7e>
        printf("write() failed in countfree()\n");
    6782:	00004517          	auipc	a0,0x4
    6786:	c3650513          	addi	a0,a0,-970 # a3b8 <schedule_rm+0x25be>
    678a:	00001097          	auipc	ra,0x1
    678e:	e36080e7          	jalr	-458(ra) # 75c0 <printf>
        exit(1);
    6792:	4505                	li	a0,1
    6794:	00001097          	auipc	ra,0x1
    6798:	8e6080e7          	jalr	-1818(ra) # 707a <exit>
        break;
    679c:	0001                	nop
      }
    }

    exit(0);
    679e:	4501                	li	a0,0
    67a0:	00001097          	auipc	ra,0x1
    67a4:	8da080e7          	jalr	-1830(ra) # 707a <exit>
  }

  close(fds[1]);
    67a8:	fd442783          	lw	a5,-44(s0)
    67ac:	853e                	mv	a0,a5
    67ae:	00001097          	auipc	ra,0x1
    67b2:	8f4080e7          	jalr	-1804(ra) # 70a2 <close>

  int n = 0;
    67b6:	fe042623          	sw	zero,-20(s0)
  while(1){
    char c;
    int cc = read(fds[0], &c, 1);
    67ba:	fd042783          	lw	a5,-48(s0)
    67be:	fcf40713          	addi	a4,s0,-49
    67c2:	4605                	li	a2,1
    67c4:	85ba                	mv	a1,a4
    67c6:	853e                	mv	a0,a5
    67c8:	00001097          	auipc	ra,0x1
    67cc:	8ca080e7          	jalr	-1846(ra) # 7092 <read>
    67d0:	87aa                	mv	a5,a0
    67d2:	fef42223          	sw	a5,-28(s0)
    if(cc < 0){
    67d6:	fe442783          	lw	a5,-28(s0)
    67da:	2781                	sext.w	a5,a5
    67dc:	0007df63          	bgez	a5,67fa <countfree+0x144>
      printf("read() failed in countfree()\n");
    67e0:	00004517          	auipc	a0,0x4
    67e4:	bf850513          	addi	a0,a0,-1032 # a3d8 <schedule_rm+0x25de>
    67e8:	00001097          	auipc	ra,0x1
    67ec:	dd8080e7          	jalr	-552(ra) # 75c0 <printf>
      exit(1);
    67f0:	4505                	li	a0,1
    67f2:	00001097          	auipc	ra,0x1
    67f6:	888080e7          	jalr	-1912(ra) # 707a <exit>
    }
    if(cc == 0)
    67fa:	fe442783          	lw	a5,-28(s0)
    67fe:	2781                	sext.w	a5,a5
    6800:	e385                	bnez	a5,6820 <countfree+0x16a>
      break;
    n += 1;
  }

  close(fds[0]);
    6802:	fd042783          	lw	a5,-48(s0)
    6806:	853e                	mv	a0,a5
    6808:	00001097          	auipc	ra,0x1
    680c:	89a080e7          	jalr	-1894(ra) # 70a2 <close>
  wait((int*)0);
    6810:	4501                	li	a0,0
    6812:	00001097          	auipc	ra,0x1
    6816:	870080e7          	jalr	-1936(ra) # 7082 <wait>
  
  return n;
    681a:	fec42783          	lw	a5,-20(s0)
    681e:	a039                	j	682c <countfree+0x176>
    n += 1;
    6820:	fec42783          	lw	a5,-20(s0)
    6824:	2785                	addiw	a5,a5,1
    6826:	fef42623          	sw	a5,-20(s0)
  while(1){
    682a:	bf41                	j	67ba <countfree+0x104>
}
    682c:	853e                	mv	a0,a5
    682e:	70e2                	ld	ra,56(sp)
    6830:	7442                	ld	s0,48(sp)
    6832:	6121                	addi	sp,sp,64
    6834:	8082                	ret

0000000000006836 <run>:

// run each test in its own process. run returns 1 if child's exit()
// indicates success.
int
run(void f(char *), char *s) {
    6836:	7179                	addi	sp,sp,-48
    6838:	f406                	sd	ra,40(sp)
    683a:	f022                	sd	s0,32(sp)
    683c:	1800                	addi	s0,sp,48
    683e:	fca43c23          	sd	a0,-40(s0)
    6842:	fcb43823          	sd	a1,-48(s0)
  int pid;
  int xstatus;

  printf("test %s: ", s);
    6846:	fd043583          	ld	a1,-48(s0)
    684a:	00004517          	auipc	a0,0x4
    684e:	bae50513          	addi	a0,a0,-1106 # a3f8 <schedule_rm+0x25fe>
    6852:	00001097          	auipc	ra,0x1
    6856:	d6e080e7          	jalr	-658(ra) # 75c0 <printf>
  if((pid = fork()) < 0) {
    685a:	00001097          	auipc	ra,0x1
    685e:	818080e7          	jalr	-2024(ra) # 7072 <fork>
    6862:	87aa                	mv	a5,a0
    6864:	fef42623          	sw	a5,-20(s0)
    6868:	fec42783          	lw	a5,-20(s0)
    686c:	2781                	sext.w	a5,a5
    686e:	0007df63          	bgez	a5,688c <run+0x56>
    printf("runtest: fork error\n");
    6872:	00004517          	auipc	a0,0x4
    6876:	b9650513          	addi	a0,a0,-1130 # a408 <schedule_rm+0x260e>
    687a:	00001097          	auipc	ra,0x1
    687e:	d46080e7          	jalr	-698(ra) # 75c0 <printf>
    exit(1);
    6882:	4505                	li	a0,1
    6884:	00000097          	auipc	ra,0x0
    6888:	7f6080e7          	jalr	2038(ra) # 707a <exit>
  }
  if(pid == 0) {
    688c:	fec42783          	lw	a5,-20(s0)
    6890:	2781                	sext.w	a5,a5
    6892:	eb99                	bnez	a5,68a8 <run+0x72>
    f(s);
    6894:	fd843783          	ld	a5,-40(s0)
    6898:	fd043503          	ld	a0,-48(s0)
    689c:	9782                	jalr	a5
    exit(0);
    689e:	4501                	li	a0,0
    68a0:	00000097          	auipc	ra,0x0
    68a4:	7da080e7          	jalr	2010(ra) # 707a <exit>
  } else {
    wait(&xstatus);
    68a8:	fe840793          	addi	a5,s0,-24
    68ac:	853e                	mv	a0,a5
    68ae:	00000097          	auipc	ra,0x0
    68b2:	7d4080e7          	jalr	2004(ra) # 7082 <wait>
    if(xstatus != 0) 
    68b6:	fe842783          	lw	a5,-24(s0)
    68ba:	cb91                	beqz	a5,68ce <run+0x98>
      printf("FAILED\n");
    68bc:	00004517          	auipc	a0,0x4
    68c0:	b6450513          	addi	a0,a0,-1180 # a420 <schedule_rm+0x2626>
    68c4:	00001097          	auipc	ra,0x1
    68c8:	cfc080e7          	jalr	-772(ra) # 75c0 <printf>
    68cc:	a809                	j	68de <run+0xa8>
    else
      printf("OK\n");
    68ce:	00004517          	auipc	a0,0x4
    68d2:	b5a50513          	addi	a0,a0,-1190 # a428 <schedule_rm+0x262e>
    68d6:	00001097          	auipc	ra,0x1
    68da:	cea080e7          	jalr	-790(ra) # 75c0 <printf>
    return xstatus == 0;
    68de:	fe842783          	lw	a5,-24(s0)
    68e2:	0017b793          	seqz	a5,a5
    68e6:	0ff7f793          	andi	a5,a5,255
    68ea:	2781                	sext.w	a5,a5
  }
}
    68ec:	853e                	mv	a0,a5
    68ee:	70a2                	ld	ra,40(sp)
    68f0:	7402                	ld	s0,32(sp)
    68f2:	6145                	addi	sp,sp,48
    68f4:	8082                	ret

00000000000068f6 <main>:

int
main(int argc, char *argv[])
{
    68f6:	bf010113          	addi	sp,sp,-1040
    68fa:	40113423          	sd	ra,1032(sp)
    68fe:	40813023          	sd	s0,1024(sp)
    6902:	41010413          	addi	s0,sp,1040
    6906:	87aa                	mv	a5,a0
    6908:	beb43823          	sd	a1,-1040(s0)
    690c:	bef42e23          	sw	a5,-1028(s0)
  int continuous = 0;
    6910:	fe042623          	sw	zero,-20(s0)
  char *justone = 0;
    6914:	fe043023          	sd	zero,-32(s0)

  if(argc == 2 && strcmp(argv[1], "-c") == 0){
    6918:	bfc42783          	lw	a5,-1028(s0)
    691c:	0007871b          	sext.w	a4,a5
    6920:	4789                	li	a5,2
    6922:	02f71563          	bne	a4,a5,694c <main+0x56>
    6926:	bf043783          	ld	a5,-1040(s0)
    692a:	07a1                	addi	a5,a5,8
    692c:	639c                	ld	a5,0(a5)
    692e:	00004597          	auipc	a1,0x4
    6932:	b0258593          	addi	a1,a1,-1278 # a430 <schedule_rm+0x2636>
    6936:	853e                	mv	a0,a5
    6938:	00000097          	auipc	ra,0x0
    693c:	2fc080e7          	jalr	764(ra) # 6c34 <strcmp>
    6940:	87aa                	mv	a5,a0
    6942:	e789                	bnez	a5,694c <main+0x56>
    continuous = 1;
    6944:	4785                	li	a5,1
    6946:	fef42623          	sw	a5,-20(s0)
    694a:	a079                	j	69d8 <main+0xe2>
  } else if(argc == 2 && strcmp(argv[1], "-C") == 0){
    694c:	bfc42783          	lw	a5,-1028(s0)
    6950:	0007871b          	sext.w	a4,a5
    6954:	4789                	li	a5,2
    6956:	02f71563          	bne	a4,a5,6980 <main+0x8a>
    695a:	bf043783          	ld	a5,-1040(s0)
    695e:	07a1                	addi	a5,a5,8
    6960:	639c                	ld	a5,0(a5)
    6962:	00004597          	auipc	a1,0x4
    6966:	ad658593          	addi	a1,a1,-1322 # a438 <schedule_rm+0x263e>
    696a:	853e                	mv	a0,a5
    696c:	00000097          	auipc	ra,0x0
    6970:	2c8080e7          	jalr	712(ra) # 6c34 <strcmp>
    6974:	87aa                	mv	a5,a0
    6976:	e789                	bnez	a5,6980 <main+0x8a>
    continuous = 2;
    6978:	4789                	li	a5,2
    697a:	fef42623          	sw	a5,-20(s0)
    697e:	a8a9                	j	69d8 <main+0xe2>
  } else if(argc == 2 && argv[1][0] != '-'){
    6980:	bfc42783          	lw	a5,-1028(s0)
    6984:	0007871b          	sext.w	a4,a5
    6988:	4789                	li	a5,2
    698a:	02f71363          	bne	a4,a5,69b0 <main+0xba>
    698e:	bf043783          	ld	a5,-1040(s0)
    6992:	07a1                	addi	a5,a5,8
    6994:	639c                	ld	a5,0(a5)
    6996:	0007c783          	lbu	a5,0(a5) # 1000 <truncate3+0x1aa>
    699a:	873e                	mv	a4,a5
    699c:	02d00793          	li	a5,45
    69a0:	00f70863          	beq	a4,a5,69b0 <main+0xba>
    justone = argv[1];
    69a4:	bf043783          	ld	a5,-1040(s0)
    69a8:	679c                	ld	a5,8(a5)
    69aa:	fef43023          	sd	a5,-32(s0)
    69ae:	a02d                	j	69d8 <main+0xe2>
  } else if(argc > 1){
    69b0:	bfc42783          	lw	a5,-1028(s0)
    69b4:	0007871b          	sext.w	a4,a5
    69b8:	4785                	li	a5,1
    69ba:	00e7df63          	bge	a5,a4,69d8 <main+0xe2>
    printf("Usage: usertests [-c] [testname]\n");
    69be:	00004517          	auipc	a0,0x4
    69c2:	a8250513          	addi	a0,a0,-1406 # a440 <schedule_rm+0x2646>
    69c6:	00001097          	auipc	ra,0x1
    69ca:	bfa080e7          	jalr	-1030(ra) # 75c0 <printf>
    exit(1);
    69ce:	4505                	li	a0,1
    69d0:	00000097          	auipc	ra,0x0
    69d4:	6aa080e7          	jalr	1706(ra) # 707a <exit>
  }
  
  struct test {
    void (*f)(char *);
    char *s;
  } tests[] = {
    69d8:	00004717          	auipc	a4,0x4
    69dc:	b4870713          	addi	a4,a4,-1208 # a520 <schedule_rm+0x2726>
    69e0:	c0040793          	addi	a5,s0,-1024
    69e4:	86ba                	mv	a3,a4
    69e6:	3b000713          	li	a4,944
    69ea:	863a                	mv	a2,a4
    69ec:	85b6                	mv	a1,a3
    69ee:	853e                	mv	a0,a5
    69f0:	00000097          	auipc	ra,0x0
    69f4:	64a080e7          	jalr	1610(ra) # 703a <memcpy>
    {forktest, "forktest"},
    {bigdir, "bigdir"}, // slow
    { 0, 0},
  };

  if(continuous){
    69f8:	fec42783          	lw	a5,-20(s0)
    69fc:	2781                	sext.w	a5,a5
    69fe:	c7ed                	beqz	a5,6ae8 <main+0x1f2>
    printf("continuous usertests starting\n");
    6a00:	00004517          	auipc	a0,0x4
    6a04:	a6850513          	addi	a0,a0,-1432 # a468 <schedule_rm+0x266e>
    6a08:	00001097          	auipc	ra,0x1
    6a0c:	bb8080e7          	jalr	-1096(ra) # 75c0 <printf>
    while(1){
      int fail = 0;
    6a10:	fc042e23          	sw	zero,-36(s0)
      int free0 = countfree();
    6a14:	00000097          	auipc	ra,0x0
    6a18:	ca2080e7          	jalr	-862(ra) # 66b6 <countfree>
    6a1c:	87aa                	mv	a5,a0
    6a1e:	faf42a23          	sw	a5,-76(s0)
      for (struct test *t = tests; t->s != 0; t++) {
    6a22:	c0040793          	addi	a5,s0,-1024
    6a26:	fcf43823          	sd	a5,-48(s0)
    6a2a:	a805                	j	6a5a <main+0x164>
        if(!run(t->f, t->s)){
    6a2c:	fd043783          	ld	a5,-48(s0)
    6a30:	6398                	ld	a4,0(a5)
    6a32:	fd043783          	ld	a5,-48(s0)
    6a36:	679c                	ld	a5,8(a5)
    6a38:	85be                	mv	a1,a5
    6a3a:	853a                	mv	a0,a4
    6a3c:	00000097          	auipc	ra,0x0
    6a40:	dfa080e7          	jalr	-518(ra) # 6836 <run>
    6a44:	87aa                	mv	a5,a0
    6a46:	e789                	bnez	a5,6a50 <main+0x15a>
          fail = 1;
    6a48:	4785                	li	a5,1
    6a4a:	fcf42e23          	sw	a5,-36(s0)
          break;
    6a4e:	a811                	j	6a62 <main+0x16c>
      for (struct test *t = tests; t->s != 0; t++) {
    6a50:	fd043783          	ld	a5,-48(s0)
    6a54:	07c1                	addi	a5,a5,16
    6a56:	fcf43823          	sd	a5,-48(s0)
    6a5a:	fd043783          	ld	a5,-48(s0)
    6a5e:	679c                	ld	a5,8(a5)
    6a60:	f7f1                	bnez	a5,6a2c <main+0x136>
        }
      }
      if(fail){
    6a62:	fdc42783          	lw	a5,-36(s0)
    6a66:	2781                	sext.w	a5,a5
    6a68:	c78d                	beqz	a5,6a92 <main+0x19c>
        printf("SOME TESTS FAILED\n");
    6a6a:	00004517          	auipc	a0,0x4
    6a6e:	a1e50513          	addi	a0,a0,-1506 # a488 <schedule_rm+0x268e>
    6a72:	00001097          	auipc	ra,0x1
    6a76:	b4e080e7          	jalr	-1202(ra) # 75c0 <printf>
        if(continuous != 2)
    6a7a:	fec42783          	lw	a5,-20(s0)
    6a7e:	0007871b          	sext.w	a4,a5
    6a82:	4789                	li	a5,2
    6a84:	00f70763          	beq	a4,a5,6a92 <main+0x19c>
          exit(1);
    6a88:	4505                	li	a0,1
    6a8a:	00000097          	auipc	ra,0x0
    6a8e:	5f0080e7          	jalr	1520(ra) # 707a <exit>
      }
      int free1 = countfree();
    6a92:	00000097          	auipc	ra,0x0
    6a96:	c24080e7          	jalr	-988(ra) # 66b6 <countfree>
    6a9a:	87aa                	mv	a5,a0
    6a9c:	faf42823          	sw	a5,-80(s0)
      if(free1 < free0){
    6aa0:	fb042703          	lw	a4,-80(s0)
    6aa4:	fb442783          	lw	a5,-76(s0)
    6aa8:	2701                	sext.w	a4,a4
    6aaa:	2781                	sext.w	a5,a5
    6aac:	f6f752e3          	bge	a4,a5,6a10 <main+0x11a>
        printf("FAILED -- lost %d free pages\n", free0 - free1);
    6ab0:	fb442703          	lw	a4,-76(s0)
    6ab4:	fb042783          	lw	a5,-80(s0)
    6ab8:	40f707bb          	subw	a5,a4,a5
    6abc:	2781                	sext.w	a5,a5
    6abe:	85be                	mv	a1,a5
    6ac0:	00004517          	auipc	a0,0x4
    6ac4:	9e050513          	addi	a0,a0,-1568 # a4a0 <schedule_rm+0x26a6>
    6ac8:	00001097          	auipc	ra,0x1
    6acc:	af8080e7          	jalr	-1288(ra) # 75c0 <printf>
        if(continuous != 2)
    6ad0:	fec42783          	lw	a5,-20(s0)
    6ad4:	0007871b          	sext.w	a4,a5
    6ad8:	4789                	li	a5,2
    6ada:	f2f70be3          	beq	a4,a5,6a10 <main+0x11a>
          exit(1);
    6ade:	4505                	li	a0,1
    6ae0:	00000097          	auipc	ra,0x0
    6ae4:	59a080e7          	jalr	1434(ra) # 707a <exit>
      }
    }
  }

  printf("usertests starting\n");
    6ae8:	00004517          	auipc	a0,0x4
    6aec:	9d850513          	addi	a0,a0,-1576 # a4c0 <schedule_rm+0x26c6>
    6af0:	00001097          	auipc	ra,0x1
    6af4:	ad0080e7          	jalr	-1328(ra) # 75c0 <printf>
  int free0 = countfree();
    6af8:	00000097          	auipc	ra,0x0
    6afc:	bbe080e7          	jalr	-1090(ra) # 66b6 <countfree>
    6b00:	87aa                	mv	a5,a0
    6b02:	faf42e23          	sw	a5,-68(s0)
  int free1 = 0;
    6b06:	fa042c23          	sw	zero,-72(s0)
  int fail = 0;
    6b0a:	fc042623          	sw	zero,-52(s0)
  for (struct test *t = tests; t->s != 0; t++) {
    6b0e:	c0040793          	addi	a5,s0,-1024
    6b12:	fcf43023          	sd	a5,-64(s0)
    6b16:	a0b1                	j	6b62 <main+0x26c>
    if((justone == 0) || strcmp(t->s, justone) == 0) {
    6b18:	fe043783          	ld	a5,-32(s0)
    6b1c:	cf89                	beqz	a5,6b36 <main+0x240>
    6b1e:	fc043783          	ld	a5,-64(s0)
    6b22:	679c                	ld	a5,8(a5)
    6b24:	fe043583          	ld	a1,-32(s0)
    6b28:	853e                	mv	a0,a5
    6b2a:	00000097          	auipc	ra,0x0
    6b2e:	10a080e7          	jalr	266(ra) # 6c34 <strcmp>
    6b32:	87aa                	mv	a5,a0
    6b34:	e395                	bnez	a5,6b58 <main+0x262>
      if(!run(t->f, t->s))
    6b36:	fc043783          	ld	a5,-64(s0)
    6b3a:	6398                	ld	a4,0(a5)
    6b3c:	fc043783          	ld	a5,-64(s0)
    6b40:	679c                	ld	a5,8(a5)
    6b42:	85be                	mv	a1,a5
    6b44:	853a                	mv	a0,a4
    6b46:	00000097          	auipc	ra,0x0
    6b4a:	cf0080e7          	jalr	-784(ra) # 6836 <run>
    6b4e:	87aa                	mv	a5,a0
    6b50:	e781                	bnez	a5,6b58 <main+0x262>
        fail = 1;
    6b52:	4785                	li	a5,1
    6b54:	fcf42623          	sw	a5,-52(s0)
  for (struct test *t = tests; t->s != 0; t++) {
    6b58:	fc043783          	ld	a5,-64(s0)
    6b5c:	07c1                	addi	a5,a5,16
    6b5e:	fcf43023          	sd	a5,-64(s0)
    6b62:	fc043783          	ld	a5,-64(s0)
    6b66:	679c                	ld	a5,8(a5)
    6b68:	fbc5                	bnez	a5,6b18 <main+0x222>
    }
  }

  if(fail){
    6b6a:	fcc42783          	lw	a5,-52(s0)
    6b6e:	2781                	sext.w	a5,a5
    6b70:	cf91                	beqz	a5,6b8c <main+0x296>
    printf("SOME TESTS FAILED\n");
    6b72:	00004517          	auipc	a0,0x4
    6b76:	91650513          	addi	a0,a0,-1770 # a488 <schedule_rm+0x268e>
    6b7a:	00001097          	auipc	ra,0x1
    6b7e:	a46080e7          	jalr	-1466(ra) # 75c0 <printf>
    exit(1);
    6b82:	4505                	li	a0,1
    6b84:	00000097          	auipc	ra,0x0
    6b88:	4f6080e7          	jalr	1270(ra) # 707a <exit>
  } else if((free1 = countfree()) < free0){
    6b8c:	00000097          	auipc	ra,0x0
    6b90:	b2a080e7          	jalr	-1238(ra) # 66b6 <countfree>
    6b94:	87aa                	mv	a5,a0
    6b96:	faf42c23          	sw	a5,-72(s0)
    6b9a:	fb842703          	lw	a4,-72(s0)
    6b9e:	fbc42783          	lw	a5,-68(s0)
    6ba2:	2701                	sext.w	a4,a4
    6ba4:	2781                	sext.w	a5,a5
    6ba6:	02f75563          	bge	a4,a5,6bd0 <main+0x2da>
    printf("FAILED -- lost some free pages %d (out of %d)\n", free1, free0);
    6baa:	fbc42703          	lw	a4,-68(s0)
    6bae:	fb842783          	lw	a5,-72(s0)
    6bb2:	863a                	mv	a2,a4
    6bb4:	85be                	mv	a1,a5
    6bb6:	00004517          	auipc	a0,0x4
    6bba:	92250513          	addi	a0,a0,-1758 # a4d8 <schedule_rm+0x26de>
    6bbe:	00001097          	auipc	ra,0x1
    6bc2:	a02080e7          	jalr	-1534(ra) # 75c0 <printf>
    exit(1);
    6bc6:	4505                	li	a0,1
    6bc8:	00000097          	auipc	ra,0x0
    6bcc:	4b2080e7          	jalr	1202(ra) # 707a <exit>
  } else {
    printf("ALL TESTS PASSED\n");
    6bd0:	00004517          	auipc	a0,0x4
    6bd4:	93850513          	addi	a0,a0,-1736 # a508 <schedule_rm+0x270e>
    6bd8:	00001097          	auipc	ra,0x1
    6bdc:	9e8080e7          	jalr	-1560(ra) # 75c0 <printf>
    exit(0);
    6be0:	4501                	li	a0,0
    6be2:	00000097          	auipc	ra,0x0
    6be6:	498080e7          	jalr	1176(ra) # 707a <exit>

0000000000006bea <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
    6bea:	7179                	addi	sp,sp,-48
    6bec:	f422                	sd	s0,40(sp)
    6bee:	1800                	addi	s0,sp,48
    6bf0:	fca43c23          	sd	a0,-40(s0)
    6bf4:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
    6bf8:	fd843783          	ld	a5,-40(s0)
    6bfc:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
    6c00:	0001                	nop
    6c02:	fd043703          	ld	a4,-48(s0)
    6c06:	00170793          	addi	a5,a4,1
    6c0a:	fcf43823          	sd	a5,-48(s0)
    6c0e:	fd843783          	ld	a5,-40(s0)
    6c12:	00178693          	addi	a3,a5,1
    6c16:	fcd43c23          	sd	a3,-40(s0)
    6c1a:	00074703          	lbu	a4,0(a4)
    6c1e:	00e78023          	sb	a4,0(a5)
    6c22:	0007c783          	lbu	a5,0(a5)
    6c26:	fff1                	bnez	a5,6c02 <strcpy+0x18>
    ;
  return os;
    6c28:	fe843783          	ld	a5,-24(s0)
}
    6c2c:	853e                	mv	a0,a5
    6c2e:	7422                	ld	s0,40(sp)
    6c30:	6145                	addi	sp,sp,48
    6c32:	8082                	ret

0000000000006c34 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    6c34:	1101                	addi	sp,sp,-32
    6c36:	ec22                	sd	s0,24(sp)
    6c38:	1000                	addi	s0,sp,32
    6c3a:	fea43423          	sd	a0,-24(s0)
    6c3e:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
    6c42:	a819                	j	6c58 <strcmp+0x24>
    p++, q++;
    6c44:	fe843783          	ld	a5,-24(s0)
    6c48:	0785                	addi	a5,a5,1
    6c4a:	fef43423          	sd	a5,-24(s0)
    6c4e:	fe043783          	ld	a5,-32(s0)
    6c52:	0785                	addi	a5,a5,1
    6c54:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
    6c58:	fe843783          	ld	a5,-24(s0)
    6c5c:	0007c783          	lbu	a5,0(a5)
    6c60:	cb99                	beqz	a5,6c76 <strcmp+0x42>
    6c62:	fe843783          	ld	a5,-24(s0)
    6c66:	0007c703          	lbu	a4,0(a5)
    6c6a:	fe043783          	ld	a5,-32(s0)
    6c6e:	0007c783          	lbu	a5,0(a5)
    6c72:	fcf709e3          	beq	a4,a5,6c44 <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
    6c76:	fe843783          	ld	a5,-24(s0)
    6c7a:	0007c783          	lbu	a5,0(a5)
    6c7e:	0007871b          	sext.w	a4,a5
    6c82:	fe043783          	ld	a5,-32(s0)
    6c86:	0007c783          	lbu	a5,0(a5)
    6c8a:	2781                	sext.w	a5,a5
    6c8c:	40f707bb          	subw	a5,a4,a5
    6c90:	2781                	sext.w	a5,a5
}
    6c92:	853e                	mv	a0,a5
    6c94:	6462                	ld	s0,24(sp)
    6c96:	6105                	addi	sp,sp,32
    6c98:	8082                	ret

0000000000006c9a <strlen>:

uint
strlen(const char *s)
{
    6c9a:	7179                	addi	sp,sp,-48
    6c9c:	f422                	sd	s0,40(sp)
    6c9e:	1800                	addi	s0,sp,48
    6ca0:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
    6ca4:	fe042623          	sw	zero,-20(s0)
    6ca8:	a031                	j	6cb4 <strlen+0x1a>
    6caa:	fec42783          	lw	a5,-20(s0)
    6cae:	2785                	addiw	a5,a5,1
    6cb0:	fef42623          	sw	a5,-20(s0)
    6cb4:	fec42783          	lw	a5,-20(s0)
    6cb8:	fd843703          	ld	a4,-40(s0)
    6cbc:	97ba                	add	a5,a5,a4
    6cbe:	0007c783          	lbu	a5,0(a5)
    6cc2:	f7e5                	bnez	a5,6caa <strlen+0x10>
    ;
  return n;
    6cc4:	fec42783          	lw	a5,-20(s0)
}
    6cc8:	853e                	mv	a0,a5
    6cca:	7422                	ld	s0,40(sp)
    6ccc:	6145                	addi	sp,sp,48
    6cce:	8082                	ret

0000000000006cd0 <memset>:

void*
memset(void *dst, int c, uint n)
{
    6cd0:	7179                	addi	sp,sp,-48
    6cd2:	f422                	sd	s0,40(sp)
    6cd4:	1800                	addi	s0,sp,48
    6cd6:	fca43c23          	sd	a0,-40(s0)
    6cda:	87ae                	mv	a5,a1
    6cdc:	8732                	mv	a4,a2
    6cde:	fcf42a23          	sw	a5,-44(s0)
    6ce2:	87ba                	mv	a5,a4
    6ce4:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
    6ce8:	fd843783          	ld	a5,-40(s0)
    6cec:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
    6cf0:	fe042623          	sw	zero,-20(s0)
    6cf4:	a00d                	j	6d16 <memset+0x46>
    cdst[i] = c;
    6cf6:	fec42783          	lw	a5,-20(s0)
    6cfa:	fe043703          	ld	a4,-32(s0)
    6cfe:	97ba                	add	a5,a5,a4
    6d00:	fd442703          	lw	a4,-44(s0)
    6d04:	0ff77713          	andi	a4,a4,255
    6d08:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
    6d0c:	fec42783          	lw	a5,-20(s0)
    6d10:	2785                	addiw	a5,a5,1
    6d12:	fef42623          	sw	a5,-20(s0)
    6d16:	fec42703          	lw	a4,-20(s0)
    6d1a:	fd042783          	lw	a5,-48(s0)
    6d1e:	2781                	sext.w	a5,a5
    6d20:	fcf76be3          	bltu	a4,a5,6cf6 <memset+0x26>
  }
  return dst;
    6d24:	fd843783          	ld	a5,-40(s0)
}
    6d28:	853e                	mv	a0,a5
    6d2a:	7422                	ld	s0,40(sp)
    6d2c:	6145                	addi	sp,sp,48
    6d2e:	8082                	ret

0000000000006d30 <strchr>:

char*
strchr(const char *s, char c)
{
    6d30:	1101                	addi	sp,sp,-32
    6d32:	ec22                	sd	s0,24(sp)
    6d34:	1000                	addi	s0,sp,32
    6d36:	fea43423          	sd	a0,-24(s0)
    6d3a:	87ae                	mv	a5,a1
    6d3c:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
    6d40:	a01d                	j	6d66 <strchr+0x36>
    if(*s == c)
    6d42:	fe843783          	ld	a5,-24(s0)
    6d46:	0007c703          	lbu	a4,0(a5)
    6d4a:	fe744783          	lbu	a5,-25(s0)
    6d4e:	0ff7f793          	andi	a5,a5,255
    6d52:	00e79563          	bne	a5,a4,6d5c <strchr+0x2c>
      return (char*)s;
    6d56:	fe843783          	ld	a5,-24(s0)
    6d5a:	a821                	j	6d72 <strchr+0x42>
  for(; *s; s++)
    6d5c:	fe843783          	ld	a5,-24(s0)
    6d60:	0785                	addi	a5,a5,1
    6d62:	fef43423          	sd	a5,-24(s0)
    6d66:	fe843783          	ld	a5,-24(s0)
    6d6a:	0007c783          	lbu	a5,0(a5)
    6d6e:	fbf1                	bnez	a5,6d42 <strchr+0x12>
  return 0;
    6d70:	4781                	li	a5,0
}
    6d72:	853e                	mv	a0,a5
    6d74:	6462                	ld	s0,24(sp)
    6d76:	6105                	addi	sp,sp,32
    6d78:	8082                	ret

0000000000006d7a <gets>:

char*
gets(char *buf, int max)
{
    6d7a:	7179                	addi	sp,sp,-48
    6d7c:	f406                	sd	ra,40(sp)
    6d7e:	f022                	sd	s0,32(sp)
    6d80:	1800                	addi	s0,sp,48
    6d82:	fca43c23          	sd	a0,-40(s0)
    6d86:	87ae                	mv	a5,a1
    6d88:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    6d8c:	fe042623          	sw	zero,-20(s0)
    6d90:	a8a1                	j	6de8 <gets+0x6e>
    cc = read(0, &c, 1);
    6d92:	fe740793          	addi	a5,s0,-25
    6d96:	4605                	li	a2,1
    6d98:	85be                	mv	a1,a5
    6d9a:	4501                	li	a0,0
    6d9c:	00000097          	auipc	ra,0x0
    6da0:	2f6080e7          	jalr	758(ra) # 7092 <read>
    6da4:	87aa                	mv	a5,a0
    6da6:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
    6daa:	fe842783          	lw	a5,-24(s0)
    6dae:	2781                	sext.w	a5,a5
    6db0:	04f05763          	blez	a5,6dfe <gets+0x84>
      break;
    buf[i++] = c;
    6db4:	fec42783          	lw	a5,-20(s0)
    6db8:	0017871b          	addiw	a4,a5,1
    6dbc:	fee42623          	sw	a4,-20(s0)
    6dc0:	873e                	mv	a4,a5
    6dc2:	fd843783          	ld	a5,-40(s0)
    6dc6:	97ba                	add	a5,a5,a4
    6dc8:	fe744703          	lbu	a4,-25(s0)
    6dcc:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
    6dd0:	fe744783          	lbu	a5,-25(s0)
    6dd4:	873e                	mv	a4,a5
    6dd6:	47a9                	li	a5,10
    6dd8:	02f70463          	beq	a4,a5,6e00 <gets+0x86>
    6ddc:	fe744783          	lbu	a5,-25(s0)
    6de0:	873e                	mv	a4,a5
    6de2:	47b5                	li	a5,13
    6de4:	00f70e63          	beq	a4,a5,6e00 <gets+0x86>
  for(i=0; i+1 < max; ){
    6de8:	fec42783          	lw	a5,-20(s0)
    6dec:	2785                	addiw	a5,a5,1
    6dee:	0007871b          	sext.w	a4,a5
    6df2:	fd442783          	lw	a5,-44(s0)
    6df6:	2781                	sext.w	a5,a5
    6df8:	f8f74de3          	blt	a4,a5,6d92 <gets+0x18>
    6dfc:	a011                	j	6e00 <gets+0x86>
      break;
    6dfe:	0001                	nop
      break;
  }
  buf[i] = '\0';
    6e00:	fec42783          	lw	a5,-20(s0)
    6e04:	fd843703          	ld	a4,-40(s0)
    6e08:	97ba                	add	a5,a5,a4
    6e0a:	00078023          	sb	zero,0(a5)
  return buf;
    6e0e:	fd843783          	ld	a5,-40(s0)
}
    6e12:	853e                	mv	a0,a5
    6e14:	70a2                	ld	ra,40(sp)
    6e16:	7402                	ld	s0,32(sp)
    6e18:	6145                	addi	sp,sp,48
    6e1a:	8082                	ret

0000000000006e1c <stat>:

int
stat(const char *n, struct stat *st)
{
    6e1c:	7179                	addi	sp,sp,-48
    6e1e:	f406                	sd	ra,40(sp)
    6e20:	f022                	sd	s0,32(sp)
    6e22:	1800                	addi	s0,sp,48
    6e24:	fca43c23          	sd	a0,-40(s0)
    6e28:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    6e2c:	4581                	li	a1,0
    6e2e:	fd843503          	ld	a0,-40(s0)
    6e32:	00000097          	auipc	ra,0x0
    6e36:	288080e7          	jalr	648(ra) # 70ba <open>
    6e3a:	87aa                	mv	a5,a0
    6e3c:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
    6e40:	fec42783          	lw	a5,-20(s0)
    6e44:	2781                	sext.w	a5,a5
    6e46:	0007d463          	bgez	a5,6e4e <stat+0x32>
    return -1;
    6e4a:	57fd                	li	a5,-1
    6e4c:	a035                	j	6e78 <stat+0x5c>
  r = fstat(fd, st);
    6e4e:	fec42783          	lw	a5,-20(s0)
    6e52:	fd043583          	ld	a1,-48(s0)
    6e56:	853e                	mv	a0,a5
    6e58:	00000097          	auipc	ra,0x0
    6e5c:	27a080e7          	jalr	634(ra) # 70d2 <fstat>
    6e60:	87aa                	mv	a5,a0
    6e62:	fef42423          	sw	a5,-24(s0)
  close(fd);
    6e66:	fec42783          	lw	a5,-20(s0)
    6e6a:	853e                	mv	a0,a5
    6e6c:	00000097          	auipc	ra,0x0
    6e70:	236080e7          	jalr	566(ra) # 70a2 <close>
  return r;
    6e74:	fe842783          	lw	a5,-24(s0)
}
    6e78:	853e                	mv	a0,a5
    6e7a:	70a2                	ld	ra,40(sp)
    6e7c:	7402                	ld	s0,32(sp)
    6e7e:	6145                	addi	sp,sp,48
    6e80:	8082                	ret

0000000000006e82 <atoi>:

int
atoi(const char *s)
{
    6e82:	7179                	addi	sp,sp,-48
    6e84:	f422                	sd	s0,40(sp)
    6e86:	1800                	addi	s0,sp,48
    6e88:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
    6e8c:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
    6e90:	a815                	j	6ec4 <atoi+0x42>
    n = n*10 + *s++ - '0';
    6e92:	fec42703          	lw	a4,-20(s0)
    6e96:	87ba                	mv	a5,a4
    6e98:	0027979b          	slliw	a5,a5,0x2
    6e9c:	9fb9                	addw	a5,a5,a4
    6e9e:	0017979b          	slliw	a5,a5,0x1
    6ea2:	0007871b          	sext.w	a4,a5
    6ea6:	fd843783          	ld	a5,-40(s0)
    6eaa:	00178693          	addi	a3,a5,1
    6eae:	fcd43c23          	sd	a3,-40(s0)
    6eb2:	0007c783          	lbu	a5,0(a5)
    6eb6:	2781                	sext.w	a5,a5
    6eb8:	9fb9                	addw	a5,a5,a4
    6eba:	2781                	sext.w	a5,a5
    6ebc:	fd07879b          	addiw	a5,a5,-48
    6ec0:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
    6ec4:	fd843783          	ld	a5,-40(s0)
    6ec8:	0007c783          	lbu	a5,0(a5)
    6ecc:	873e                	mv	a4,a5
    6ece:	02f00793          	li	a5,47
    6ed2:	00e7fb63          	bgeu	a5,a4,6ee8 <atoi+0x66>
    6ed6:	fd843783          	ld	a5,-40(s0)
    6eda:	0007c783          	lbu	a5,0(a5)
    6ede:	873e                	mv	a4,a5
    6ee0:	03900793          	li	a5,57
    6ee4:	fae7f7e3          	bgeu	a5,a4,6e92 <atoi+0x10>
  return n;
    6ee8:	fec42783          	lw	a5,-20(s0)
}
    6eec:	853e                	mv	a0,a5
    6eee:	7422                	ld	s0,40(sp)
    6ef0:	6145                	addi	sp,sp,48
    6ef2:	8082                	ret

0000000000006ef4 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    6ef4:	7139                	addi	sp,sp,-64
    6ef6:	fc22                	sd	s0,56(sp)
    6ef8:	0080                	addi	s0,sp,64
    6efa:	fca43c23          	sd	a0,-40(s0)
    6efe:	fcb43823          	sd	a1,-48(s0)
    6f02:	87b2                	mv	a5,a2
    6f04:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
    6f08:	fd843783          	ld	a5,-40(s0)
    6f0c:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
    6f10:	fd043783          	ld	a5,-48(s0)
    6f14:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
    6f18:	fe043703          	ld	a4,-32(s0)
    6f1c:	fe843783          	ld	a5,-24(s0)
    6f20:	02e7fc63          	bgeu	a5,a4,6f58 <memmove+0x64>
    while(n-- > 0)
    6f24:	a00d                	j	6f46 <memmove+0x52>
      *dst++ = *src++;
    6f26:	fe043703          	ld	a4,-32(s0)
    6f2a:	00170793          	addi	a5,a4,1
    6f2e:	fef43023          	sd	a5,-32(s0)
    6f32:	fe843783          	ld	a5,-24(s0)
    6f36:	00178693          	addi	a3,a5,1
    6f3a:	fed43423          	sd	a3,-24(s0)
    6f3e:	00074703          	lbu	a4,0(a4)
    6f42:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
    6f46:	fcc42783          	lw	a5,-52(s0)
    6f4a:	fff7871b          	addiw	a4,a5,-1
    6f4e:	fce42623          	sw	a4,-52(s0)
    6f52:	fcf04ae3          	bgtz	a5,6f26 <memmove+0x32>
    6f56:	a891                	j	6faa <memmove+0xb6>
  } else {
    dst += n;
    6f58:	fcc42783          	lw	a5,-52(s0)
    6f5c:	fe843703          	ld	a4,-24(s0)
    6f60:	97ba                	add	a5,a5,a4
    6f62:	fef43423          	sd	a5,-24(s0)
    src += n;
    6f66:	fcc42783          	lw	a5,-52(s0)
    6f6a:	fe043703          	ld	a4,-32(s0)
    6f6e:	97ba                	add	a5,a5,a4
    6f70:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
    6f74:	a01d                	j	6f9a <memmove+0xa6>
      *--dst = *--src;
    6f76:	fe043783          	ld	a5,-32(s0)
    6f7a:	17fd                	addi	a5,a5,-1
    6f7c:	fef43023          	sd	a5,-32(s0)
    6f80:	fe843783          	ld	a5,-24(s0)
    6f84:	17fd                	addi	a5,a5,-1
    6f86:	fef43423          	sd	a5,-24(s0)
    6f8a:	fe043783          	ld	a5,-32(s0)
    6f8e:	0007c703          	lbu	a4,0(a5)
    6f92:	fe843783          	ld	a5,-24(s0)
    6f96:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
    6f9a:	fcc42783          	lw	a5,-52(s0)
    6f9e:	fff7871b          	addiw	a4,a5,-1
    6fa2:	fce42623          	sw	a4,-52(s0)
    6fa6:	fcf048e3          	bgtz	a5,6f76 <memmove+0x82>
  }
  return vdst;
    6faa:	fd843783          	ld	a5,-40(s0)
}
    6fae:	853e                	mv	a0,a5
    6fb0:	7462                	ld	s0,56(sp)
    6fb2:	6121                	addi	sp,sp,64
    6fb4:	8082                	ret

0000000000006fb6 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    6fb6:	7139                	addi	sp,sp,-64
    6fb8:	fc22                	sd	s0,56(sp)
    6fba:	0080                	addi	s0,sp,64
    6fbc:	fca43c23          	sd	a0,-40(s0)
    6fc0:	fcb43823          	sd	a1,-48(s0)
    6fc4:	87b2                	mv	a5,a2
    6fc6:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
    6fca:	fd843783          	ld	a5,-40(s0)
    6fce:	fef43423          	sd	a5,-24(s0)
    6fd2:	fd043783          	ld	a5,-48(s0)
    6fd6:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
    6fda:	a0a1                	j	7022 <memcmp+0x6c>
    if (*p1 != *p2) {
    6fdc:	fe843783          	ld	a5,-24(s0)
    6fe0:	0007c703          	lbu	a4,0(a5)
    6fe4:	fe043783          	ld	a5,-32(s0)
    6fe8:	0007c783          	lbu	a5,0(a5)
    6fec:	02f70163          	beq	a4,a5,700e <memcmp+0x58>
      return *p1 - *p2;
    6ff0:	fe843783          	ld	a5,-24(s0)
    6ff4:	0007c783          	lbu	a5,0(a5)
    6ff8:	0007871b          	sext.w	a4,a5
    6ffc:	fe043783          	ld	a5,-32(s0)
    7000:	0007c783          	lbu	a5,0(a5)
    7004:	2781                	sext.w	a5,a5
    7006:	40f707bb          	subw	a5,a4,a5
    700a:	2781                	sext.w	a5,a5
    700c:	a01d                	j	7032 <memcmp+0x7c>
    }
    p1++;
    700e:	fe843783          	ld	a5,-24(s0)
    7012:	0785                	addi	a5,a5,1
    7014:	fef43423          	sd	a5,-24(s0)
    p2++;
    7018:	fe043783          	ld	a5,-32(s0)
    701c:	0785                	addi	a5,a5,1
    701e:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
    7022:	fcc42783          	lw	a5,-52(s0)
    7026:	fff7871b          	addiw	a4,a5,-1
    702a:	fce42623          	sw	a4,-52(s0)
    702e:	f7dd                	bnez	a5,6fdc <memcmp+0x26>
  }
  return 0;
    7030:	4781                	li	a5,0
}
    7032:	853e                	mv	a0,a5
    7034:	7462                	ld	s0,56(sp)
    7036:	6121                	addi	sp,sp,64
    7038:	8082                	ret

000000000000703a <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    703a:	7179                	addi	sp,sp,-48
    703c:	f406                	sd	ra,40(sp)
    703e:	f022                	sd	s0,32(sp)
    7040:	1800                	addi	s0,sp,48
    7042:	fea43423          	sd	a0,-24(s0)
    7046:	feb43023          	sd	a1,-32(s0)
    704a:	87b2                	mv	a5,a2
    704c:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
    7050:	fdc42783          	lw	a5,-36(s0)
    7054:	863e                	mv	a2,a5
    7056:	fe043583          	ld	a1,-32(s0)
    705a:	fe843503          	ld	a0,-24(s0)
    705e:	00000097          	auipc	ra,0x0
    7062:	e96080e7          	jalr	-362(ra) # 6ef4 <memmove>
    7066:	87aa                	mv	a5,a0
}
    7068:	853e                	mv	a0,a5
    706a:	70a2                	ld	ra,40(sp)
    706c:	7402                	ld	s0,32(sp)
    706e:	6145                	addi	sp,sp,48
    7070:	8082                	ret

0000000000007072 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    7072:	4885                	li	a7,1
 ecall
    7074:	00000073          	ecall
 ret
    7078:	8082                	ret

000000000000707a <exit>:
.global exit
exit:
 li a7, SYS_exit
    707a:	4889                	li	a7,2
 ecall
    707c:	00000073          	ecall
 ret
    7080:	8082                	ret

0000000000007082 <wait>:
.global wait
wait:
 li a7, SYS_wait
    7082:	488d                	li	a7,3
 ecall
    7084:	00000073          	ecall
 ret
    7088:	8082                	ret

000000000000708a <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    708a:	4891                	li	a7,4
 ecall
    708c:	00000073          	ecall
 ret
    7090:	8082                	ret

0000000000007092 <read>:
.global read
read:
 li a7, SYS_read
    7092:	4895                	li	a7,5
 ecall
    7094:	00000073          	ecall
 ret
    7098:	8082                	ret

000000000000709a <write>:
.global write
write:
 li a7, SYS_write
    709a:	48c1                	li	a7,16
 ecall
    709c:	00000073          	ecall
 ret
    70a0:	8082                	ret

00000000000070a2 <close>:
.global close
close:
 li a7, SYS_close
    70a2:	48d5                	li	a7,21
 ecall
    70a4:	00000073          	ecall
 ret
    70a8:	8082                	ret

00000000000070aa <kill>:
.global kill
kill:
 li a7, SYS_kill
    70aa:	4899                	li	a7,6
 ecall
    70ac:	00000073          	ecall
 ret
    70b0:	8082                	ret

00000000000070b2 <exec>:
.global exec
exec:
 li a7, SYS_exec
    70b2:	489d                	li	a7,7
 ecall
    70b4:	00000073          	ecall
 ret
    70b8:	8082                	ret

00000000000070ba <open>:
.global open
open:
 li a7, SYS_open
    70ba:	48bd                	li	a7,15
 ecall
    70bc:	00000073          	ecall
 ret
    70c0:	8082                	ret

00000000000070c2 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    70c2:	48c5                	li	a7,17
 ecall
    70c4:	00000073          	ecall
 ret
    70c8:	8082                	ret

00000000000070ca <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    70ca:	48c9                	li	a7,18
 ecall
    70cc:	00000073          	ecall
 ret
    70d0:	8082                	ret

00000000000070d2 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    70d2:	48a1                	li	a7,8
 ecall
    70d4:	00000073          	ecall
 ret
    70d8:	8082                	ret

00000000000070da <link>:
.global link
link:
 li a7, SYS_link
    70da:	48cd                	li	a7,19
 ecall
    70dc:	00000073          	ecall
 ret
    70e0:	8082                	ret

00000000000070e2 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    70e2:	48d1                	li	a7,20
 ecall
    70e4:	00000073          	ecall
 ret
    70e8:	8082                	ret

00000000000070ea <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    70ea:	48a5                	li	a7,9
 ecall
    70ec:	00000073          	ecall
 ret
    70f0:	8082                	ret

00000000000070f2 <dup>:
.global dup
dup:
 li a7, SYS_dup
    70f2:	48a9                	li	a7,10
 ecall
    70f4:	00000073          	ecall
 ret
    70f8:	8082                	ret

00000000000070fa <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    70fa:	48ad                	li	a7,11
 ecall
    70fc:	00000073          	ecall
 ret
    7100:	8082                	ret

0000000000007102 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    7102:	48b1                	li	a7,12
 ecall
    7104:	00000073          	ecall
 ret
    7108:	8082                	ret

000000000000710a <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    710a:	48b5                	li	a7,13
 ecall
    710c:	00000073          	ecall
 ret
    7110:	8082                	ret

0000000000007112 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    7112:	48b9                	li	a7,14
 ecall
    7114:	00000073          	ecall
 ret
    7118:	8082                	ret

000000000000711a <thrdstop>:
.global thrdstop
thrdstop:
 li a7, SYS_thrdstop
    711a:	48d9                	li	a7,22
 ecall
    711c:	00000073          	ecall
 ret
    7120:	8082                	ret

0000000000007122 <thrdresume>:
.global thrdresume
thrdresume:
 li a7, SYS_thrdresume
    7122:	48dd                	li	a7,23
 ecall
    7124:	00000073          	ecall
 ret
    7128:	8082                	ret

000000000000712a <cancelthrdstop>:
.global cancelthrdstop
cancelthrdstop:
 li a7, SYS_cancelthrdstop
    712a:	48e1                	li	a7,24
 ecall
    712c:	00000073          	ecall
 ret
    7130:	8082                	ret

0000000000007132 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    7132:	1101                	addi	sp,sp,-32
    7134:	ec06                	sd	ra,24(sp)
    7136:	e822                	sd	s0,16(sp)
    7138:	1000                	addi	s0,sp,32
    713a:	87aa                	mv	a5,a0
    713c:	872e                	mv	a4,a1
    713e:	fef42623          	sw	a5,-20(s0)
    7142:	87ba                	mv	a5,a4
    7144:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
    7148:	feb40713          	addi	a4,s0,-21
    714c:	fec42783          	lw	a5,-20(s0)
    7150:	4605                	li	a2,1
    7152:	85ba                	mv	a1,a4
    7154:	853e                	mv	a0,a5
    7156:	00000097          	auipc	ra,0x0
    715a:	f44080e7          	jalr	-188(ra) # 709a <write>
}
    715e:	0001                	nop
    7160:	60e2                	ld	ra,24(sp)
    7162:	6442                	ld	s0,16(sp)
    7164:	6105                	addi	sp,sp,32
    7166:	8082                	ret

0000000000007168 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    7168:	7139                	addi	sp,sp,-64
    716a:	fc06                	sd	ra,56(sp)
    716c:	f822                	sd	s0,48(sp)
    716e:	0080                	addi	s0,sp,64
    7170:	87aa                	mv	a5,a0
    7172:	8736                	mv	a4,a3
    7174:	fcf42623          	sw	a5,-52(s0)
    7178:	87ae                	mv	a5,a1
    717a:	fcf42423          	sw	a5,-56(s0)
    717e:	87b2                	mv	a5,a2
    7180:	fcf42223          	sw	a5,-60(s0)
    7184:	87ba                	mv	a5,a4
    7186:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    718a:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
    718e:	fc042783          	lw	a5,-64(s0)
    7192:	2781                	sext.w	a5,a5
    7194:	c38d                	beqz	a5,71b6 <printint+0x4e>
    7196:	fc842783          	lw	a5,-56(s0)
    719a:	2781                	sext.w	a5,a5
    719c:	0007dd63          	bgez	a5,71b6 <printint+0x4e>
    neg = 1;
    71a0:	4785                	li	a5,1
    71a2:	fef42423          	sw	a5,-24(s0)
    x = -xx;
    71a6:	fc842783          	lw	a5,-56(s0)
    71aa:	40f007bb          	negw	a5,a5
    71ae:	2781                	sext.w	a5,a5
    71b0:	fef42223          	sw	a5,-28(s0)
    71b4:	a029                	j	71be <printint+0x56>
  } else {
    x = xx;
    71b6:	fc842783          	lw	a5,-56(s0)
    71ba:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
    71be:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
    71c2:	fc442783          	lw	a5,-60(s0)
    71c6:	fe442703          	lw	a4,-28(s0)
    71ca:	02f777bb          	remuw	a5,a4,a5
    71ce:	0007861b          	sext.w	a2,a5
    71d2:	fec42783          	lw	a5,-20(s0)
    71d6:	0017871b          	addiw	a4,a5,1
    71da:	fee42623          	sw	a4,-20(s0)
    71de:	00003697          	auipc	a3,0x3
    71e2:	70268693          	addi	a3,a3,1794 # a8e0 <digits>
    71e6:	02061713          	slli	a4,a2,0x20
    71ea:	9301                	srli	a4,a4,0x20
    71ec:	9736                	add	a4,a4,a3
    71ee:	00074703          	lbu	a4,0(a4)
    71f2:	ff040693          	addi	a3,s0,-16
    71f6:	97b6                	add	a5,a5,a3
    71f8:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
    71fc:	fc442783          	lw	a5,-60(s0)
    7200:	fe442703          	lw	a4,-28(s0)
    7204:	02f757bb          	divuw	a5,a4,a5
    7208:	fef42223          	sw	a5,-28(s0)
    720c:	fe442783          	lw	a5,-28(s0)
    7210:	2781                	sext.w	a5,a5
    7212:	fbc5                	bnez	a5,71c2 <printint+0x5a>
  if(neg)
    7214:	fe842783          	lw	a5,-24(s0)
    7218:	2781                	sext.w	a5,a5
    721a:	cf95                	beqz	a5,7256 <printint+0xee>
    buf[i++] = '-';
    721c:	fec42783          	lw	a5,-20(s0)
    7220:	0017871b          	addiw	a4,a5,1
    7224:	fee42623          	sw	a4,-20(s0)
    7228:	ff040713          	addi	a4,s0,-16
    722c:	97ba                	add	a5,a5,a4
    722e:	02d00713          	li	a4,45
    7232:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
    7236:	a005                	j	7256 <printint+0xee>
    putc(fd, buf[i]);
    7238:	fec42783          	lw	a5,-20(s0)
    723c:	ff040713          	addi	a4,s0,-16
    7240:	97ba                	add	a5,a5,a4
    7242:	fe07c703          	lbu	a4,-32(a5)
    7246:	fcc42783          	lw	a5,-52(s0)
    724a:	85ba                	mv	a1,a4
    724c:	853e                	mv	a0,a5
    724e:	00000097          	auipc	ra,0x0
    7252:	ee4080e7          	jalr	-284(ra) # 7132 <putc>
  while(--i >= 0)
    7256:	fec42783          	lw	a5,-20(s0)
    725a:	37fd                	addiw	a5,a5,-1
    725c:	fef42623          	sw	a5,-20(s0)
    7260:	fec42783          	lw	a5,-20(s0)
    7264:	2781                	sext.w	a5,a5
    7266:	fc07d9e3          	bgez	a5,7238 <printint+0xd0>
}
    726a:	0001                	nop
    726c:	0001                	nop
    726e:	70e2                	ld	ra,56(sp)
    7270:	7442                	ld	s0,48(sp)
    7272:	6121                	addi	sp,sp,64
    7274:	8082                	ret

0000000000007276 <printptr>:

static void
printptr(int fd, uint64 x) {
    7276:	7179                	addi	sp,sp,-48
    7278:	f406                	sd	ra,40(sp)
    727a:	f022                	sd	s0,32(sp)
    727c:	1800                	addi	s0,sp,48
    727e:	87aa                	mv	a5,a0
    7280:	fcb43823          	sd	a1,-48(s0)
    7284:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
    7288:	fdc42783          	lw	a5,-36(s0)
    728c:	03000593          	li	a1,48
    7290:	853e                	mv	a0,a5
    7292:	00000097          	auipc	ra,0x0
    7296:	ea0080e7          	jalr	-352(ra) # 7132 <putc>
  putc(fd, 'x');
    729a:	fdc42783          	lw	a5,-36(s0)
    729e:	07800593          	li	a1,120
    72a2:	853e                	mv	a0,a5
    72a4:	00000097          	auipc	ra,0x0
    72a8:	e8e080e7          	jalr	-370(ra) # 7132 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    72ac:	fe042623          	sw	zero,-20(s0)
    72b0:	a82d                	j	72ea <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    72b2:	fd043783          	ld	a5,-48(s0)
    72b6:	93f1                	srli	a5,a5,0x3c
    72b8:	00003717          	auipc	a4,0x3
    72bc:	62870713          	addi	a4,a4,1576 # a8e0 <digits>
    72c0:	97ba                	add	a5,a5,a4
    72c2:	0007c703          	lbu	a4,0(a5)
    72c6:	fdc42783          	lw	a5,-36(s0)
    72ca:	85ba                	mv	a1,a4
    72cc:	853e                	mv	a0,a5
    72ce:	00000097          	auipc	ra,0x0
    72d2:	e64080e7          	jalr	-412(ra) # 7132 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    72d6:	fec42783          	lw	a5,-20(s0)
    72da:	2785                	addiw	a5,a5,1
    72dc:	fef42623          	sw	a5,-20(s0)
    72e0:	fd043783          	ld	a5,-48(s0)
    72e4:	0792                	slli	a5,a5,0x4
    72e6:	fcf43823          	sd	a5,-48(s0)
    72ea:	fec42783          	lw	a5,-20(s0)
    72ee:	873e                	mv	a4,a5
    72f0:	47bd                	li	a5,15
    72f2:	fce7f0e3          	bgeu	a5,a4,72b2 <printptr+0x3c>
}
    72f6:	0001                	nop
    72f8:	0001                	nop
    72fa:	70a2                	ld	ra,40(sp)
    72fc:	7402                	ld	s0,32(sp)
    72fe:	6145                	addi	sp,sp,48
    7300:	8082                	ret

0000000000007302 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    7302:	715d                	addi	sp,sp,-80
    7304:	e486                	sd	ra,72(sp)
    7306:	e0a2                	sd	s0,64(sp)
    7308:	0880                	addi	s0,sp,80
    730a:	87aa                	mv	a5,a0
    730c:	fcb43023          	sd	a1,-64(s0)
    7310:	fac43c23          	sd	a2,-72(s0)
    7314:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
    7318:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
    731c:	fe042223          	sw	zero,-28(s0)
    7320:	a42d                	j	754a <vprintf+0x248>
    c = fmt[i] & 0xff;
    7322:	fe442783          	lw	a5,-28(s0)
    7326:	fc043703          	ld	a4,-64(s0)
    732a:	97ba                	add	a5,a5,a4
    732c:	0007c783          	lbu	a5,0(a5)
    7330:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
    7334:	fe042783          	lw	a5,-32(s0)
    7338:	2781                	sext.w	a5,a5
    733a:	eb9d                	bnez	a5,7370 <vprintf+0x6e>
      if(c == '%'){
    733c:	fdc42783          	lw	a5,-36(s0)
    7340:	0007871b          	sext.w	a4,a5
    7344:	02500793          	li	a5,37
    7348:	00f71763          	bne	a4,a5,7356 <vprintf+0x54>
        state = '%';
    734c:	02500793          	li	a5,37
    7350:	fef42023          	sw	a5,-32(s0)
    7354:	a2f5                	j	7540 <vprintf+0x23e>
      } else {
        putc(fd, c);
    7356:	fdc42783          	lw	a5,-36(s0)
    735a:	0ff7f713          	andi	a4,a5,255
    735e:	fcc42783          	lw	a5,-52(s0)
    7362:	85ba                	mv	a1,a4
    7364:	853e                	mv	a0,a5
    7366:	00000097          	auipc	ra,0x0
    736a:	dcc080e7          	jalr	-564(ra) # 7132 <putc>
    736e:	aac9                	j	7540 <vprintf+0x23e>
      }
    } else if(state == '%'){
    7370:	fe042783          	lw	a5,-32(s0)
    7374:	0007871b          	sext.w	a4,a5
    7378:	02500793          	li	a5,37
    737c:	1cf71263          	bne	a4,a5,7540 <vprintf+0x23e>
      if(c == 'd'){
    7380:	fdc42783          	lw	a5,-36(s0)
    7384:	0007871b          	sext.w	a4,a5
    7388:	06400793          	li	a5,100
    738c:	02f71463          	bne	a4,a5,73b4 <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
    7390:	fb843783          	ld	a5,-72(s0)
    7394:	00878713          	addi	a4,a5,8
    7398:	fae43c23          	sd	a4,-72(s0)
    739c:	4398                	lw	a4,0(a5)
    739e:	fcc42783          	lw	a5,-52(s0)
    73a2:	4685                	li	a3,1
    73a4:	4629                	li	a2,10
    73a6:	85ba                	mv	a1,a4
    73a8:	853e                	mv	a0,a5
    73aa:	00000097          	auipc	ra,0x0
    73ae:	dbe080e7          	jalr	-578(ra) # 7168 <printint>
    73b2:	a269                	j	753c <vprintf+0x23a>
      } else if(c == 'l') {
    73b4:	fdc42783          	lw	a5,-36(s0)
    73b8:	0007871b          	sext.w	a4,a5
    73bc:	06c00793          	li	a5,108
    73c0:	02f71663          	bne	a4,a5,73ec <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
    73c4:	fb843783          	ld	a5,-72(s0)
    73c8:	00878713          	addi	a4,a5,8
    73cc:	fae43c23          	sd	a4,-72(s0)
    73d0:	639c                	ld	a5,0(a5)
    73d2:	0007871b          	sext.w	a4,a5
    73d6:	fcc42783          	lw	a5,-52(s0)
    73da:	4681                	li	a3,0
    73dc:	4629                	li	a2,10
    73de:	85ba                	mv	a1,a4
    73e0:	853e                	mv	a0,a5
    73e2:	00000097          	auipc	ra,0x0
    73e6:	d86080e7          	jalr	-634(ra) # 7168 <printint>
    73ea:	aa89                	j	753c <vprintf+0x23a>
      } else if(c == 'x') {
    73ec:	fdc42783          	lw	a5,-36(s0)
    73f0:	0007871b          	sext.w	a4,a5
    73f4:	07800793          	li	a5,120
    73f8:	02f71463          	bne	a4,a5,7420 <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
    73fc:	fb843783          	ld	a5,-72(s0)
    7400:	00878713          	addi	a4,a5,8
    7404:	fae43c23          	sd	a4,-72(s0)
    7408:	4398                	lw	a4,0(a5)
    740a:	fcc42783          	lw	a5,-52(s0)
    740e:	4681                	li	a3,0
    7410:	4641                	li	a2,16
    7412:	85ba                	mv	a1,a4
    7414:	853e                	mv	a0,a5
    7416:	00000097          	auipc	ra,0x0
    741a:	d52080e7          	jalr	-686(ra) # 7168 <printint>
    741e:	aa39                	j	753c <vprintf+0x23a>
      } else if(c == 'p') {
    7420:	fdc42783          	lw	a5,-36(s0)
    7424:	0007871b          	sext.w	a4,a5
    7428:	07000793          	li	a5,112
    742c:	02f71263          	bne	a4,a5,7450 <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
    7430:	fb843783          	ld	a5,-72(s0)
    7434:	00878713          	addi	a4,a5,8
    7438:	fae43c23          	sd	a4,-72(s0)
    743c:	6398                	ld	a4,0(a5)
    743e:	fcc42783          	lw	a5,-52(s0)
    7442:	85ba                	mv	a1,a4
    7444:	853e                	mv	a0,a5
    7446:	00000097          	auipc	ra,0x0
    744a:	e30080e7          	jalr	-464(ra) # 7276 <printptr>
    744e:	a0fd                	j	753c <vprintf+0x23a>
      } else if(c == 's'){
    7450:	fdc42783          	lw	a5,-36(s0)
    7454:	0007871b          	sext.w	a4,a5
    7458:	07300793          	li	a5,115
    745c:	04f71c63          	bne	a4,a5,74b4 <vprintf+0x1b2>
        s = va_arg(ap, char*);
    7460:	fb843783          	ld	a5,-72(s0)
    7464:	00878713          	addi	a4,a5,8
    7468:	fae43c23          	sd	a4,-72(s0)
    746c:	639c                	ld	a5,0(a5)
    746e:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
    7472:	fe843783          	ld	a5,-24(s0)
    7476:	eb8d                	bnez	a5,74a8 <vprintf+0x1a6>
          s = "(null)";
    7478:	00003797          	auipc	a5,0x3
    747c:	46078793          	addi	a5,a5,1120 # a8d8 <schedule_rm+0x2ade>
    7480:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
    7484:	a015                	j	74a8 <vprintf+0x1a6>
          putc(fd, *s);
    7486:	fe843783          	ld	a5,-24(s0)
    748a:	0007c703          	lbu	a4,0(a5)
    748e:	fcc42783          	lw	a5,-52(s0)
    7492:	85ba                	mv	a1,a4
    7494:	853e                	mv	a0,a5
    7496:	00000097          	auipc	ra,0x0
    749a:	c9c080e7          	jalr	-868(ra) # 7132 <putc>
          s++;
    749e:	fe843783          	ld	a5,-24(s0)
    74a2:	0785                	addi	a5,a5,1
    74a4:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
    74a8:	fe843783          	ld	a5,-24(s0)
    74ac:	0007c783          	lbu	a5,0(a5)
    74b0:	fbf9                	bnez	a5,7486 <vprintf+0x184>
    74b2:	a069                	j	753c <vprintf+0x23a>
        }
      } else if(c == 'c'){
    74b4:	fdc42783          	lw	a5,-36(s0)
    74b8:	0007871b          	sext.w	a4,a5
    74bc:	06300793          	li	a5,99
    74c0:	02f71463          	bne	a4,a5,74e8 <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
    74c4:	fb843783          	ld	a5,-72(s0)
    74c8:	00878713          	addi	a4,a5,8
    74cc:	fae43c23          	sd	a4,-72(s0)
    74d0:	439c                	lw	a5,0(a5)
    74d2:	0ff7f713          	andi	a4,a5,255
    74d6:	fcc42783          	lw	a5,-52(s0)
    74da:	85ba                	mv	a1,a4
    74dc:	853e                	mv	a0,a5
    74de:	00000097          	auipc	ra,0x0
    74e2:	c54080e7          	jalr	-940(ra) # 7132 <putc>
    74e6:	a899                	j	753c <vprintf+0x23a>
      } else if(c == '%'){
    74e8:	fdc42783          	lw	a5,-36(s0)
    74ec:	0007871b          	sext.w	a4,a5
    74f0:	02500793          	li	a5,37
    74f4:	00f71f63          	bne	a4,a5,7512 <vprintf+0x210>
        putc(fd, c);
    74f8:	fdc42783          	lw	a5,-36(s0)
    74fc:	0ff7f713          	andi	a4,a5,255
    7500:	fcc42783          	lw	a5,-52(s0)
    7504:	85ba                	mv	a1,a4
    7506:	853e                	mv	a0,a5
    7508:	00000097          	auipc	ra,0x0
    750c:	c2a080e7          	jalr	-982(ra) # 7132 <putc>
    7510:	a035                	j	753c <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    7512:	fcc42783          	lw	a5,-52(s0)
    7516:	02500593          	li	a1,37
    751a:	853e                	mv	a0,a5
    751c:	00000097          	auipc	ra,0x0
    7520:	c16080e7          	jalr	-1002(ra) # 7132 <putc>
        putc(fd, c);
    7524:	fdc42783          	lw	a5,-36(s0)
    7528:	0ff7f713          	andi	a4,a5,255
    752c:	fcc42783          	lw	a5,-52(s0)
    7530:	85ba                	mv	a1,a4
    7532:	853e                	mv	a0,a5
    7534:	00000097          	auipc	ra,0x0
    7538:	bfe080e7          	jalr	-1026(ra) # 7132 <putc>
      }
      state = 0;
    753c:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
    7540:	fe442783          	lw	a5,-28(s0)
    7544:	2785                	addiw	a5,a5,1
    7546:	fef42223          	sw	a5,-28(s0)
    754a:	fe442783          	lw	a5,-28(s0)
    754e:	fc043703          	ld	a4,-64(s0)
    7552:	97ba                	add	a5,a5,a4
    7554:	0007c783          	lbu	a5,0(a5)
    7558:	dc0795e3          	bnez	a5,7322 <vprintf+0x20>
    }
  }
}
    755c:	0001                	nop
    755e:	0001                	nop
    7560:	60a6                	ld	ra,72(sp)
    7562:	6406                	ld	s0,64(sp)
    7564:	6161                	addi	sp,sp,80
    7566:	8082                	ret

0000000000007568 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    7568:	7159                	addi	sp,sp,-112
    756a:	fc06                	sd	ra,56(sp)
    756c:	f822                	sd	s0,48(sp)
    756e:	0080                	addi	s0,sp,64
    7570:	fcb43823          	sd	a1,-48(s0)
    7574:	e010                	sd	a2,0(s0)
    7576:	e414                	sd	a3,8(s0)
    7578:	e818                	sd	a4,16(s0)
    757a:	ec1c                	sd	a5,24(s0)
    757c:	03043023          	sd	a6,32(s0)
    7580:	03143423          	sd	a7,40(s0)
    7584:	87aa                	mv	a5,a0
    7586:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
    758a:	03040793          	addi	a5,s0,48
    758e:	fcf43423          	sd	a5,-56(s0)
    7592:	fc843783          	ld	a5,-56(s0)
    7596:	fd078793          	addi	a5,a5,-48
    759a:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
    759e:	fe843703          	ld	a4,-24(s0)
    75a2:	fdc42783          	lw	a5,-36(s0)
    75a6:	863a                	mv	a2,a4
    75a8:	fd043583          	ld	a1,-48(s0)
    75ac:	853e                	mv	a0,a5
    75ae:	00000097          	auipc	ra,0x0
    75b2:	d54080e7          	jalr	-684(ra) # 7302 <vprintf>
}
    75b6:	0001                	nop
    75b8:	70e2                	ld	ra,56(sp)
    75ba:	7442                	ld	s0,48(sp)
    75bc:	6165                	addi	sp,sp,112
    75be:	8082                	ret

00000000000075c0 <printf>:

void
printf(const char *fmt, ...)
{
    75c0:	7159                	addi	sp,sp,-112
    75c2:	f406                	sd	ra,40(sp)
    75c4:	f022                	sd	s0,32(sp)
    75c6:	1800                	addi	s0,sp,48
    75c8:	fca43c23          	sd	a0,-40(s0)
    75cc:	e40c                	sd	a1,8(s0)
    75ce:	e810                	sd	a2,16(s0)
    75d0:	ec14                	sd	a3,24(s0)
    75d2:	f018                	sd	a4,32(s0)
    75d4:	f41c                	sd	a5,40(s0)
    75d6:	03043823          	sd	a6,48(s0)
    75da:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    75de:	04040793          	addi	a5,s0,64
    75e2:	fcf43823          	sd	a5,-48(s0)
    75e6:	fd043783          	ld	a5,-48(s0)
    75ea:	fc878793          	addi	a5,a5,-56
    75ee:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
    75f2:	fe843783          	ld	a5,-24(s0)
    75f6:	863e                	mv	a2,a5
    75f8:	fd843583          	ld	a1,-40(s0)
    75fc:	4505                	li	a0,1
    75fe:	00000097          	auipc	ra,0x0
    7602:	d04080e7          	jalr	-764(ra) # 7302 <vprintf>
}
    7606:	0001                	nop
    7608:	70a2                	ld	ra,40(sp)
    760a:	7402                	ld	s0,32(sp)
    760c:	6165                	addi	sp,sp,112
    760e:	8082                	ret

0000000000007610 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    7610:	7179                	addi	sp,sp,-48
    7612:	f422                	sd	s0,40(sp)
    7614:	1800                	addi	s0,sp,48
    7616:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
    761a:	fd843783          	ld	a5,-40(s0)
    761e:	17c1                	addi	a5,a5,-16
    7620:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    7624:	0000a797          	auipc	a5,0xa
    7628:	b0478793          	addi	a5,a5,-1276 # 11128 <freep>
    762c:	639c                	ld	a5,0(a5)
    762e:	fef43423          	sd	a5,-24(s0)
    7632:	a815                	j	7666 <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    7634:	fe843783          	ld	a5,-24(s0)
    7638:	639c                	ld	a5,0(a5)
    763a:	fe843703          	ld	a4,-24(s0)
    763e:	00f76f63          	bltu	a4,a5,765c <free+0x4c>
    7642:	fe043703          	ld	a4,-32(s0)
    7646:	fe843783          	ld	a5,-24(s0)
    764a:	02e7eb63          	bltu	a5,a4,7680 <free+0x70>
    764e:	fe843783          	ld	a5,-24(s0)
    7652:	639c                	ld	a5,0(a5)
    7654:	fe043703          	ld	a4,-32(s0)
    7658:	02f76463          	bltu	a4,a5,7680 <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    765c:	fe843783          	ld	a5,-24(s0)
    7660:	639c                	ld	a5,0(a5)
    7662:	fef43423          	sd	a5,-24(s0)
    7666:	fe043703          	ld	a4,-32(s0)
    766a:	fe843783          	ld	a5,-24(s0)
    766e:	fce7f3e3          	bgeu	a5,a4,7634 <free+0x24>
    7672:	fe843783          	ld	a5,-24(s0)
    7676:	639c                	ld	a5,0(a5)
    7678:	fe043703          	ld	a4,-32(s0)
    767c:	faf77ce3          	bgeu	a4,a5,7634 <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
    7680:	fe043783          	ld	a5,-32(s0)
    7684:	479c                	lw	a5,8(a5)
    7686:	1782                	slli	a5,a5,0x20
    7688:	9381                	srli	a5,a5,0x20
    768a:	0792                	slli	a5,a5,0x4
    768c:	fe043703          	ld	a4,-32(s0)
    7690:	973e                	add	a4,a4,a5
    7692:	fe843783          	ld	a5,-24(s0)
    7696:	639c                	ld	a5,0(a5)
    7698:	02f71763          	bne	a4,a5,76c6 <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
    769c:	fe043783          	ld	a5,-32(s0)
    76a0:	4798                	lw	a4,8(a5)
    76a2:	fe843783          	ld	a5,-24(s0)
    76a6:	639c                	ld	a5,0(a5)
    76a8:	479c                	lw	a5,8(a5)
    76aa:	9fb9                	addw	a5,a5,a4
    76ac:	0007871b          	sext.w	a4,a5
    76b0:	fe043783          	ld	a5,-32(s0)
    76b4:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
    76b6:	fe843783          	ld	a5,-24(s0)
    76ba:	639c                	ld	a5,0(a5)
    76bc:	6398                	ld	a4,0(a5)
    76be:	fe043783          	ld	a5,-32(s0)
    76c2:	e398                	sd	a4,0(a5)
    76c4:	a039                	j	76d2 <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
    76c6:	fe843783          	ld	a5,-24(s0)
    76ca:	6398                	ld	a4,0(a5)
    76cc:	fe043783          	ld	a5,-32(s0)
    76d0:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
    76d2:	fe843783          	ld	a5,-24(s0)
    76d6:	479c                	lw	a5,8(a5)
    76d8:	1782                	slli	a5,a5,0x20
    76da:	9381                	srli	a5,a5,0x20
    76dc:	0792                	slli	a5,a5,0x4
    76de:	fe843703          	ld	a4,-24(s0)
    76e2:	97ba                	add	a5,a5,a4
    76e4:	fe043703          	ld	a4,-32(s0)
    76e8:	02f71563          	bne	a4,a5,7712 <free+0x102>
    p->s.size += bp->s.size;
    76ec:	fe843783          	ld	a5,-24(s0)
    76f0:	4798                	lw	a4,8(a5)
    76f2:	fe043783          	ld	a5,-32(s0)
    76f6:	479c                	lw	a5,8(a5)
    76f8:	9fb9                	addw	a5,a5,a4
    76fa:	0007871b          	sext.w	a4,a5
    76fe:	fe843783          	ld	a5,-24(s0)
    7702:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    7704:	fe043783          	ld	a5,-32(s0)
    7708:	6398                	ld	a4,0(a5)
    770a:	fe843783          	ld	a5,-24(s0)
    770e:	e398                	sd	a4,0(a5)
    7710:	a031                	j	771c <free+0x10c>
  } else
    p->s.ptr = bp;
    7712:	fe843783          	ld	a5,-24(s0)
    7716:	fe043703          	ld	a4,-32(s0)
    771a:	e398                	sd	a4,0(a5)
  freep = p;
    771c:	0000a797          	auipc	a5,0xa
    7720:	a0c78793          	addi	a5,a5,-1524 # 11128 <freep>
    7724:	fe843703          	ld	a4,-24(s0)
    7728:	e398                	sd	a4,0(a5)
}
    772a:	0001                	nop
    772c:	7422                	ld	s0,40(sp)
    772e:	6145                	addi	sp,sp,48
    7730:	8082                	ret

0000000000007732 <morecore>:

static Header*
morecore(uint nu)
{
    7732:	7179                	addi	sp,sp,-48
    7734:	f406                	sd	ra,40(sp)
    7736:	f022                	sd	s0,32(sp)
    7738:	1800                	addi	s0,sp,48
    773a:	87aa                	mv	a5,a0
    773c:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
    7740:	fdc42783          	lw	a5,-36(s0)
    7744:	0007871b          	sext.w	a4,a5
    7748:	6785                	lui	a5,0x1
    774a:	00f77563          	bgeu	a4,a5,7754 <morecore+0x22>
    nu = 4096;
    774e:	6785                	lui	a5,0x1
    7750:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
    7754:	fdc42783          	lw	a5,-36(s0)
    7758:	0047979b          	slliw	a5,a5,0x4
    775c:	2781                	sext.w	a5,a5
    775e:	2781                	sext.w	a5,a5
    7760:	853e                	mv	a0,a5
    7762:	00000097          	auipc	ra,0x0
    7766:	9a0080e7          	jalr	-1632(ra) # 7102 <sbrk>
    776a:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
    776e:	fe843703          	ld	a4,-24(s0)
    7772:	57fd                	li	a5,-1
    7774:	00f71463          	bne	a4,a5,777c <morecore+0x4a>
    return 0;
    7778:	4781                	li	a5,0
    777a:	a03d                	j	77a8 <morecore+0x76>
  hp = (Header*)p;
    777c:	fe843783          	ld	a5,-24(s0)
    7780:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
    7784:	fe043783          	ld	a5,-32(s0)
    7788:	fdc42703          	lw	a4,-36(s0)
    778c:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
    778e:	fe043783          	ld	a5,-32(s0)
    7792:	07c1                	addi	a5,a5,16
    7794:	853e                	mv	a0,a5
    7796:	00000097          	auipc	ra,0x0
    779a:	e7a080e7          	jalr	-390(ra) # 7610 <free>
  return freep;
    779e:	0000a797          	auipc	a5,0xa
    77a2:	98a78793          	addi	a5,a5,-1654 # 11128 <freep>
    77a6:	639c                	ld	a5,0(a5)
}
    77a8:	853e                	mv	a0,a5
    77aa:	70a2                	ld	ra,40(sp)
    77ac:	7402                	ld	s0,32(sp)
    77ae:	6145                	addi	sp,sp,48
    77b0:	8082                	ret

00000000000077b2 <malloc>:

void*
malloc(uint nbytes)
{
    77b2:	7139                	addi	sp,sp,-64
    77b4:	fc06                	sd	ra,56(sp)
    77b6:	f822                	sd	s0,48(sp)
    77b8:	0080                	addi	s0,sp,64
    77ba:	87aa                	mv	a5,a0
    77bc:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    77c0:	fcc46783          	lwu	a5,-52(s0)
    77c4:	07bd                	addi	a5,a5,15
    77c6:	8391                	srli	a5,a5,0x4
    77c8:	2781                	sext.w	a5,a5
    77ca:	2785                	addiw	a5,a5,1
    77cc:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
    77d0:	0000a797          	auipc	a5,0xa
    77d4:	95878793          	addi	a5,a5,-1704 # 11128 <freep>
    77d8:	639c                	ld	a5,0(a5)
    77da:	fef43023          	sd	a5,-32(s0)
    77de:	fe043783          	ld	a5,-32(s0)
    77e2:	ef95                	bnez	a5,781e <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
    77e4:	0000a797          	auipc	a5,0xa
    77e8:	93478793          	addi	a5,a5,-1740 # 11118 <base>
    77ec:	fef43023          	sd	a5,-32(s0)
    77f0:	0000a797          	auipc	a5,0xa
    77f4:	93878793          	addi	a5,a5,-1736 # 11128 <freep>
    77f8:	fe043703          	ld	a4,-32(s0)
    77fc:	e398                	sd	a4,0(a5)
    77fe:	0000a797          	auipc	a5,0xa
    7802:	92a78793          	addi	a5,a5,-1750 # 11128 <freep>
    7806:	6398                	ld	a4,0(a5)
    7808:	0000a797          	auipc	a5,0xa
    780c:	91078793          	addi	a5,a5,-1776 # 11118 <base>
    7810:	e398                	sd	a4,0(a5)
    base.s.size = 0;
    7812:	0000a797          	auipc	a5,0xa
    7816:	90678793          	addi	a5,a5,-1786 # 11118 <base>
    781a:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    781e:	fe043783          	ld	a5,-32(s0)
    7822:	639c                	ld	a5,0(a5)
    7824:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    7828:	fe843783          	ld	a5,-24(s0)
    782c:	4798                	lw	a4,8(a5)
    782e:	fdc42783          	lw	a5,-36(s0)
    7832:	2781                	sext.w	a5,a5
    7834:	06f76863          	bltu	a4,a5,78a4 <malloc+0xf2>
      if(p->s.size == nunits)
    7838:	fe843783          	ld	a5,-24(s0)
    783c:	4798                	lw	a4,8(a5)
    783e:	fdc42783          	lw	a5,-36(s0)
    7842:	2781                	sext.w	a5,a5
    7844:	00e79963          	bne	a5,a4,7856 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
    7848:	fe843783          	ld	a5,-24(s0)
    784c:	6398                	ld	a4,0(a5)
    784e:	fe043783          	ld	a5,-32(s0)
    7852:	e398                	sd	a4,0(a5)
    7854:	a82d                	j	788e <malloc+0xdc>
      else {
        p->s.size -= nunits;
    7856:	fe843783          	ld	a5,-24(s0)
    785a:	4798                	lw	a4,8(a5)
    785c:	fdc42783          	lw	a5,-36(s0)
    7860:	40f707bb          	subw	a5,a4,a5
    7864:	0007871b          	sext.w	a4,a5
    7868:	fe843783          	ld	a5,-24(s0)
    786c:	c798                	sw	a4,8(a5)
        p += p->s.size;
    786e:	fe843783          	ld	a5,-24(s0)
    7872:	479c                	lw	a5,8(a5)
    7874:	1782                	slli	a5,a5,0x20
    7876:	9381                	srli	a5,a5,0x20
    7878:	0792                	slli	a5,a5,0x4
    787a:	fe843703          	ld	a4,-24(s0)
    787e:	97ba                	add	a5,a5,a4
    7880:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
    7884:	fe843783          	ld	a5,-24(s0)
    7888:	fdc42703          	lw	a4,-36(s0)
    788c:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
    788e:	0000a797          	auipc	a5,0xa
    7892:	89a78793          	addi	a5,a5,-1894 # 11128 <freep>
    7896:	fe043703          	ld	a4,-32(s0)
    789a:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
    789c:	fe843783          	ld	a5,-24(s0)
    78a0:	07c1                	addi	a5,a5,16
    78a2:	a091                	j	78e6 <malloc+0x134>
    }
    if(p == freep)
    78a4:	0000a797          	auipc	a5,0xa
    78a8:	88478793          	addi	a5,a5,-1916 # 11128 <freep>
    78ac:	639c                	ld	a5,0(a5)
    78ae:	fe843703          	ld	a4,-24(s0)
    78b2:	02f71063          	bne	a4,a5,78d2 <malloc+0x120>
      if((p = morecore(nunits)) == 0)
    78b6:	fdc42783          	lw	a5,-36(s0)
    78ba:	853e                	mv	a0,a5
    78bc:	00000097          	auipc	ra,0x0
    78c0:	e76080e7          	jalr	-394(ra) # 7732 <morecore>
    78c4:	fea43423          	sd	a0,-24(s0)
    78c8:	fe843783          	ld	a5,-24(s0)
    78cc:	e399                	bnez	a5,78d2 <malloc+0x120>
        return 0;
    78ce:	4781                	li	a5,0
    78d0:	a819                	j	78e6 <malloc+0x134>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    78d2:	fe843783          	ld	a5,-24(s0)
    78d6:	fef43023          	sd	a5,-32(s0)
    78da:	fe843783          	ld	a5,-24(s0)
    78de:	639c                	ld	a5,0(a5)
    78e0:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    78e4:	b791                	j	7828 <malloc+0x76>
  }
}
    78e6:	853e                	mv	a0,a5
    78e8:	70e2                	ld	ra,56(sp)
    78ea:	7442                	ld	s0,48(sp)
    78ec:	6121                	addi	sp,sp,64
    78ee:	8082                	ret

00000000000078f0 <setjmp>:
    78f0:	e100                	sd	s0,0(a0)
    78f2:	e504                	sd	s1,8(a0)
    78f4:	01253823          	sd	s2,16(a0)
    78f8:	01353c23          	sd	s3,24(a0)
    78fc:	03453023          	sd	s4,32(a0)
    7900:	03553423          	sd	s5,40(a0)
    7904:	03653823          	sd	s6,48(a0)
    7908:	03753c23          	sd	s7,56(a0)
    790c:	05853023          	sd	s8,64(a0)
    7910:	05953423          	sd	s9,72(a0)
    7914:	05a53823          	sd	s10,80(a0)
    7918:	05b53c23          	sd	s11,88(a0)
    791c:	06153023          	sd	ra,96(a0)
    7920:	06253423          	sd	sp,104(a0)
    7924:	4501                	li	a0,0
    7926:	8082                	ret

0000000000007928 <longjmp>:
    7928:	6100                	ld	s0,0(a0)
    792a:	6504                	ld	s1,8(a0)
    792c:	01053903          	ld	s2,16(a0)
    7930:	01853983          	ld	s3,24(a0)
    7934:	02053a03          	ld	s4,32(a0)
    7938:	02853a83          	ld	s5,40(a0)
    793c:	03053b03          	ld	s6,48(a0)
    7940:	03853b83          	ld	s7,56(a0)
    7944:	04053c03          	ld	s8,64(a0)
    7948:	04853c83          	ld	s9,72(a0)
    794c:	05053d03          	ld	s10,80(a0)
    7950:	05853d83          	ld	s11,88(a0)
    7954:	06053083          	ld	ra,96(a0)
    7958:	06853103          	ld	sp,104(a0)
    795c:	c199                	beqz	a1,7962 <longjmp_1>
    795e:	852e                	mv	a0,a1
    7960:	8082                	ret

0000000000007962 <longjmp_1>:
    7962:	4505                	li	a0,1
    7964:	8082                	ret

0000000000007966 <list_empty>:
/**
 * list_empty - tests whether a list is empty
 * @head: the list to test.
 */
static inline int list_empty(const struct list_head *head)
{
    7966:	1101                	addi	sp,sp,-32
    7968:	ec22                	sd	s0,24(sp)
    796a:	1000                	addi	s0,sp,32
    796c:	fea43423          	sd	a0,-24(s0)
    return head->next == head;
    7970:	fe843783          	ld	a5,-24(s0)
    7974:	639c                	ld	a5,0(a5)
    7976:	fe843703          	ld	a4,-24(s0)
    797a:	40f707b3          	sub	a5,a4,a5
    797e:	0017b793          	seqz	a5,a5
    7982:	0ff7f793          	andi	a5,a5,255
    7986:	2781                	sext.w	a5,a5
}
    7988:	853e                	mv	a0,a5
    798a:	6462                	ld	s0,24(sp)
    798c:	6105                	addi	sp,sp,32
    798e:	8082                	ret

0000000000007990 <schedule_default>:

#define NULL 0

/* default scheduling algorithm */
struct threads_sched_result schedule_default(struct threads_sched_args args)
{
    7990:	715d                	addi	sp,sp,-80
    7992:	e4a2                	sd	s0,72(sp)
    7994:	e0a6                	sd	s1,64(sp)
    7996:	0880                	addi	s0,sp,80
    7998:	84aa                	mv	s1,a0
    struct thread *thread_with_smallest_id = NULL;
    799a:	fe043423          	sd	zero,-24(s0)
    struct thread *th = NULL;
    799e:	fe043023          	sd	zero,-32(s0)
    list_for_each_entry(th, args.run_queue, thread_list) {
    79a2:	649c                	ld	a5,8(s1)
    79a4:	639c                	ld	a5,0(a5)
    79a6:	fcf43c23          	sd	a5,-40(s0)
    79aa:	fd843783          	ld	a5,-40(s0)
    79ae:	fd878793          	addi	a5,a5,-40
    79b2:	fef43023          	sd	a5,-32(s0)
    79b6:	a81d                	j	79ec <schedule_default+0x5c>
        if (thread_with_smallest_id == NULL || th->ID < thread_with_smallest_id->ID) {
    79b8:	fe843783          	ld	a5,-24(s0)
    79bc:	cb89                	beqz	a5,79ce <schedule_default+0x3e>
    79be:	fe043783          	ld	a5,-32(s0)
    79c2:	5398                	lw	a4,32(a5)
    79c4:	fe843783          	ld	a5,-24(s0)
    79c8:	539c                	lw	a5,32(a5)
    79ca:	00f75663          	bge	a4,a5,79d6 <schedule_default+0x46>
            thread_with_smallest_id = th;
    79ce:	fe043783          	ld	a5,-32(s0)
    79d2:	fef43423          	sd	a5,-24(s0)
    list_for_each_entry(th, args.run_queue, thread_list) {
    79d6:	fe043783          	ld	a5,-32(s0)
    79da:	779c                	ld	a5,40(a5)
    79dc:	fcf43823          	sd	a5,-48(s0)
    79e0:	fd043783          	ld	a5,-48(s0)
    79e4:	fd878793          	addi	a5,a5,-40
    79e8:	fef43023          	sd	a5,-32(s0)
    79ec:	fe043783          	ld	a5,-32(s0)
    79f0:	02878713          	addi	a4,a5,40
    79f4:	649c                	ld	a5,8(s1)
    79f6:	fcf711e3          	bne	a4,a5,79b8 <schedule_default+0x28>
        }
    }

    struct threads_sched_result r;
    if (thread_with_smallest_id != NULL) {
    79fa:	fe843783          	ld	a5,-24(s0)
    79fe:	cf89                	beqz	a5,7a18 <schedule_default+0x88>
        r.scheduled_thread_list_member = &thread_with_smallest_id->thread_list;
    7a00:	fe843783          	ld	a5,-24(s0)
    7a04:	02878793          	addi	a5,a5,40
    7a08:	faf43823          	sd	a5,-80(s0)
        r.allocated_time = thread_with_smallest_id->remaining_time;
    7a0c:	fe843783          	ld	a5,-24(s0)
    7a10:	47fc                	lw	a5,76(a5)
    7a12:	faf42c23          	sw	a5,-72(s0)
    7a16:	a039                	j	7a24 <schedule_default+0x94>
    } else {
        r.scheduled_thread_list_member = args.run_queue;
    7a18:	649c                	ld	a5,8(s1)
    7a1a:	faf43823          	sd	a5,-80(s0)
        r.allocated_time = 1;
    7a1e:	4785                	li	a5,1
    7a20:	faf42c23          	sw	a5,-72(s0)
    }

    return r;
    7a24:	fb043783          	ld	a5,-80(s0)
    7a28:	fcf43023          	sd	a5,-64(s0)
    7a2c:	fb843783          	ld	a5,-72(s0)
    7a30:	fcf43423          	sd	a5,-56(s0)
    7a34:	fc043703          	ld	a4,-64(s0)
    7a38:	fc843783          	ld	a5,-56(s0)
    7a3c:	863a                	mv	a2,a4
    7a3e:	86be                	mv	a3,a5
    7a40:	8732                	mv	a4,a2
    7a42:	87b6                	mv	a5,a3
}
    7a44:	853a                	mv	a0,a4
    7a46:	85be                	mv	a1,a5
    7a48:	6426                	ld	s0,72(sp)
    7a4a:	6486                	ld	s1,64(sp)
    7a4c:	6161                	addi	sp,sp,80
    7a4e:	8082                	ret

0000000000007a50 <schedule_edf>:

/* Earliest-Deadline-First scheduling */
struct threads_sched_result schedule_edf(struct threads_sched_args args)
{
    7a50:	7115                	addi	sp,sp,-224
    7a52:	ed86                	sd	ra,216(sp)
    7a54:	e9a2                	sd	s0,208(sp)
    7a56:	e5a6                	sd	s1,200(sp)
    7a58:	e1ca                	sd	s2,192(sp)
    7a5a:	fd4e                	sd	s3,184(sp)
    7a5c:	1180                	addi	s0,sp,224
    7a5e:	84aa                	mv	s1,a0
    // the scheduling is called when a interrupt event happens (either a fn end or a new one is added)
    // need to determine the next thread to execute and the allocated time.

    struct threads_sched_result r;
    if(list_empty(args.run_queue)){
    7a60:	649c                	ld	a5,8(s1)
    7a62:	853e                	mv	a0,a5
    7a64:	00000097          	auipc	ra,0x0
    7a68:	f02080e7          	jalr	-254(ra) # 7966 <list_empty>
    7a6c:	87aa                	mv	a5,a0
    7a6e:	c3d1                	beqz	a5,7af2 <schedule_edf+0xa2>
        // SPEC 3
        r.scheduled_thread_list_member = args.run_queue;
    7a70:	649c                	ld	a5,8(s1)
    7a72:	f2f43423          	sd	a5,-216(s0)
        int least_release_time = 99999;
    7a76:	67e1                	lui	a5,0x18
    7a78:	69f78793          	addi	a5,a5,1695 # 1869f <__BSS_END__+0x756f>
    7a7c:	fcf42623          	sw	a5,-52(s0)
        struct release_queue_entry* cur;
        list_for_each_entry(cur, args.release_queue, thread_list) {
    7a80:	689c                	ld	a5,16(s1)
    7a82:	639c                	ld	a5,0(a5)
    7a84:	f4f43823          	sd	a5,-176(s0)
    7a88:	f5043783          	ld	a5,-176(s0)
    7a8c:	17e1                	addi	a5,a5,-8
    7a8e:	fcf43023          	sd	a5,-64(s0)
    7a92:	a805                	j	7ac2 <schedule_edf+0x72>
            if(cur->release_time<least_release_time){
    7a94:	fc043783          	ld	a5,-64(s0)
    7a98:	4f98                	lw	a4,24(a5)
    7a9a:	fcc42783          	lw	a5,-52(s0)
    7a9e:	2781                	sext.w	a5,a5
    7aa0:	00f75763          	bge	a4,a5,7aae <schedule_edf+0x5e>
                least_release_time = cur->release_time;
    7aa4:	fc043783          	ld	a5,-64(s0)
    7aa8:	4f9c                	lw	a5,24(a5)
    7aaa:	fcf42623          	sw	a5,-52(s0)
        list_for_each_entry(cur, args.release_queue, thread_list) {
    7aae:	fc043783          	ld	a5,-64(s0)
    7ab2:	679c                	ld	a5,8(a5)
    7ab4:	f4f43423          	sd	a5,-184(s0)
    7ab8:	f4843783          	ld	a5,-184(s0)
    7abc:	17e1                	addi	a5,a5,-8
    7abe:	fcf43023          	sd	a5,-64(s0)
    7ac2:	fc043783          	ld	a5,-64(s0)
    7ac6:	00878713          	addi	a4,a5,8
    7aca:	689c                	ld	a5,16(s1)
    7acc:	fcf714e3          	bne	a4,a5,7a94 <schedule_edf+0x44>
            }
        }
        r.allocated_time = least_release_time - args.current_time ;
    7ad0:	409c                	lw	a5,0(s1)
    7ad2:	fcc42703          	lw	a4,-52(s0)
    7ad6:	40f707bb          	subw	a5,a4,a5
    7ada:	2781                	sext.w	a5,a5
    7adc:	f2f42823          	sw	a5,-208(s0)
        return r;
    7ae0:	f2843783          	ld	a5,-216(s0)
    7ae4:	f2f43c23          	sd	a5,-200(s0)
    7ae8:	f3043783          	ld	a5,-208(s0)
    7aec:	f4f43023          	sd	a5,-192(s0)
    7af0:	a4e5                	j	7dd8 <schedule_edf+0x388>
    }else{
        // run queue is not empty.
        struct thread *th = NULL;
    7af2:	fa043c23          	sd	zero,-72(s0)
        struct thread *min_th = NULL;
    7af6:	fa043823          	sd	zero,-80(s0)
        struct thread *min_miss_deadline_th = NULL;
    7afa:	fa043423          	sd	zero,-88(s0)
        list_for_each_entry(th, args.run_queue, thread_list) {
    7afe:	649c                	ld	a5,8(s1)
    7b00:	639c                	ld	a5,0(a5)
    7b02:	f8f43423          	sd	a5,-120(s0)
    7b06:	f8843783          	ld	a5,-120(s0)
    7b0a:	fd878793          	addi	a5,a5,-40
    7b0e:	faf43c23          	sd	a5,-72(s0)
    7b12:	a849                	j	7ba4 <schedule_edf+0x154>
            // printf("in run queue: %d\n", th->ID);
            if(th->current_deadline <= args.current_time){
    7b14:	fb843783          	ld	a5,-72(s0)
    7b18:	4bb8                	lw	a4,80(a5)
    7b1a:	409c                	lw	a5,0(s1)
    7b1c:	02e7c163          	blt	a5,a4,7b3e <schedule_edf+0xee>
                if(min_miss_deadline_th == NULL || th->ID<min_miss_deadline_th->ID){
    7b20:	fa843783          	ld	a5,-88(s0)
    7b24:	cb89                	beqz	a5,7b36 <schedule_edf+0xe6>
    7b26:	fb843783          	ld	a5,-72(s0)
    7b2a:	5398                	lw	a4,32(a5)
    7b2c:	fa843783          	ld	a5,-88(s0)
    7b30:	539c                	lw	a5,32(a5)
    7b32:	00f75663          	bge	a4,a5,7b3e <schedule_edf+0xee>
                    min_miss_deadline_th = th;
    7b36:	fb843783          	ld	a5,-72(s0)
    7b3a:	faf43423          	sd	a5,-88(s0)
                }
            }
            if(min_th == NULL) min_th = th;
    7b3e:	fb043783          	ld	a5,-80(s0)
    7b42:	e789                	bnez	a5,7b4c <schedule_edf+0xfc>
    7b44:	fb843783          	ld	a5,-72(s0)
    7b48:	faf43823          	sd	a5,-80(s0)
            if(th->current_deadline<min_th->current_deadline){
    7b4c:	fb843783          	ld	a5,-72(s0)
    7b50:	4bb8                	lw	a4,80(a5)
    7b52:	fb043783          	ld	a5,-80(s0)
    7b56:	4bbc                	lw	a5,80(a5)
    7b58:	00f75763          	bge	a4,a5,7b66 <schedule_edf+0x116>
                min_th = th;
    7b5c:	fb843783          	ld	a5,-72(s0)
    7b60:	faf43823          	sd	a5,-80(s0)
    7b64:	a02d                	j	7b8e <schedule_edf+0x13e>
            }else if(th->current_deadline == min_th->current_deadline){
    7b66:	fb843783          	ld	a5,-72(s0)
    7b6a:	4bb8                	lw	a4,80(a5)
    7b6c:	fb043783          	ld	a5,-80(s0)
    7b70:	4bbc                	lw	a5,80(a5)
    7b72:	00f71e63          	bne	a4,a5,7b8e <schedule_edf+0x13e>
                if(th->ID<min_th->ID) min_th = th;
    7b76:	fb843783          	ld	a5,-72(s0)
    7b7a:	5398                	lw	a4,32(a5)
    7b7c:	fb043783          	ld	a5,-80(s0)
    7b80:	539c                	lw	a5,32(a5)
    7b82:	00f75663          	bge	a4,a5,7b8e <schedule_edf+0x13e>
    7b86:	fb843783          	ld	a5,-72(s0)
    7b8a:	faf43823          	sd	a5,-80(s0)
        list_for_each_entry(th, args.run_queue, thread_list) {
    7b8e:	fb843783          	ld	a5,-72(s0)
    7b92:	779c                	ld	a5,40(a5)
    7b94:	f4f43c23          	sd	a5,-168(s0)
    7b98:	f5843783          	ld	a5,-168(s0)
    7b9c:	fd878793          	addi	a5,a5,-40
    7ba0:	faf43c23          	sd	a5,-72(s0)
    7ba4:	fb843783          	ld	a5,-72(s0)
    7ba8:	02878713          	addi	a4,a5,40
    7bac:	649c                	ld	a5,8(s1)
    7bae:	f6f713e3          	bne	a4,a5,7b14 <schedule_edf+0xc4>
            }
        }

        if(min_miss_deadline_th != NULL) {
    7bb2:	fa843783          	ld	a5,-88(s0)
    7bb6:	c395                	beqz	a5,7bda <schedule_edf+0x18a>
            // SPEC 4: exist missed deadline
            // printf("exist missed deadline", th->ID);
            r.allocated_time = 0;
    7bb8:	f2042823          	sw	zero,-208(s0)
            r.scheduled_thread_list_member = &min_miss_deadline_th->thread_list;
    7bbc:	fa843783          	ld	a5,-88(s0)
    7bc0:	02878793          	addi	a5,a5,40
    7bc4:	f2f43423          	sd	a5,-216(s0)
            return r;
    7bc8:	f2843783          	ld	a5,-216(s0)
    7bcc:	f2f43c23          	sd	a5,-200(s0)
    7bd0:	f3043783          	ld	a5,-208(s0)
    7bd4:	f4f43023          	sd	a5,-192(s0)
    7bd8:	a401                	j	7dd8 <schedule_edf+0x388>
             // compute allocated time: 
            // 1. a preemption can happen in the future.(need to inspect the release queue)
            // 2. current deadline is met (preemption has not happened)
            // 3. current deadline is missed (current_time + remaining_time > current_deadline)
            // compute the first event that will happen.
            r.scheduled_thread_list_member = &min_th->thread_list;
    7bda:	fb043783          	ld	a5,-80(s0)
    7bde:	02878793          	addi	a5,a5,40
    7be2:	f2f43423          	sd	a5,-216(s0)

            struct release_queue_entry* cur;
            if(list_empty(args.release_queue)){
    7be6:	689c                	ld	a5,16(s1)
    7be8:	853e                	mv	a0,a5
    7bea:	00000097          	auipc	ra,0x0
    7bee:	d7c080e7          	jalr	-644(ra) # 7966 <list_empty>
    7bf2:	87aa                	mv	a5,a0
    7bf4:	c3b5                	beqz	a5,7c58 <schedule_edf+0x208>
                // printf("release queue is empty\n");
                // a preemption cannot happen, because we've already selected the highest priority thread.
                int remaining_time = 99999;
    7bf6:	67e1                	lui	a5,0x18
    7bf8:	69f78793          	addi	a5,a5,1695 # 1869f <__BSS_END__+0x756f>
    7bfc:	f6f42623          	sw	a5,-148(s0)

                int deadline_time = min_th->current_deadline - args.current_time;
    7c00:	fb043783          	ld	a5,-80(s0)
    7c04:	4bb8                	lw	a4,80(a5)
    7c06:	409c                	lw	a5,0(s1)
    7c08:	40f707bb          	subw	a5,a4,a5
    7c0c:	f6f42423          	sw	a5,-152(s0)
                remaining_time = deadline_time<remaining_time? deadline_time: remaining_time;
    7c10:	f6842603          	lw	a2,-152(s0)
    7c14:	f6c42783          	lw	a5,-148(s0)
    7c18:	0007869b          	sext.w	a3,a5
    7c1c:	0006071b          	sext.w	a4,a2
    7c20:	00d75363          	bge	a4,a3,7c26 <schedule_edf+0x1d6>
    7c24:	87b2                	mv	a5,a2
    7c26:	f6f42623          	sw	a5,-148(s0)
                int met_time = min_th->remaining_time;
    7c2a:	fb043783          	ld	a5,-80(s0)
    7c2e:	47fc                	lw	a5,76(a5)
    7c30:	f6f42223          	sw	a5,-156(s0)
                remaining_time = met_time<remaining_time? met_time: remaining_time;
    7c34:	f6442603          	lw	a2,-156(s0)
    7c38:	f6c42783          	lw	a5,-148(s0)
    7c3c:	0007869b          	sext.w	a3,a5
    7c40:	0006071b          	sext.w	a4,a2
    7c44:	00d75363          	bge	a4,a3,7c4a <schedule_edf+0x1fa>
    7c48:	87b2                	mv	a5,a2
    7c4a:	f6f42623          	sw	a5,-148(s0)
                r.allocated_time = remaining_time;
    7c4e:	f6c42783          	lw	a5,-148(s0)
    7c52:	f2f42823          	sw	a5,-208(s0)
    7c56:	aa8d                	j	7dc8 <schedule_edf+0x378>
            }else{
                // first check if a preemption can happen
                struct release_queue_entry* cur_min = NULL;
    7c58:	f8043c23          	sd	zero,-104(s0)
                int remaining_time = 99999;
    7c5c:	67e1                	lui	a5,0x18
    7c5e:	69f78793          	addi	a5,a5,1695 # 1869f <__BSS_END__+0x756f>
    7c62:	f8f42a23          	sw	a5,-108(s0)
                list_for_each_entry(cur, args.release_queue, thread_list) {
    7c66:	689c                	ld	a5,16(s1)
    7c68:	639c                	ld	a5,0(a5)
    7c6a:	f8f43023          	sd	a5,-128(s0)
    7c6e:	f8043783          	ld	a5,-128(s0)
    7c72:	17e1                	addi	a5,a5,-8
    7c74:	faf43023          	sd	a5,-96(s0)
    7c78:	a8d9                	j	7d4e <schedule_edf+0x2fe>
                    if((cur->thrd->period + cur->release_time < min_th->current_deadline) && cur->thrd->n != 0){
    7c7a:	fa043783          	ld	a5,-96(s0)
    7c7e:	639c                	ld	a5,0(a5)
    7c80:	43f8                	lw	a4,68(a5)
    7c82:	fa043783          	ld	a5,-96(s0)
    7c86:	4f9c                	lw	a5,24(a5)
    7c88:	9fb9                	addw	a5,a5,a4
    7c8a:	0007871b          	sext.w	a4,a5
    7c8e:	fb043783          	ld	a5,-80(s0)
    7c92:	4bbc                	lw	a5,80(a5)
    7c94:	0af75363          	bge	a4,a5,7d3a <schedule_edf+0x2ea>
    7c98:	fa043783          	ld	a5,-96(s0)
    7c9c:	639c                	ld	a5,0(a5)
    7c9e:	47bc                	lw	a5,72(a5)
    7ca0:	cfc9                	beqz	a5,7d3a <schedule_edf+0x2ea>
                        // printf("preemption can occur: %d %d %d\n", cur->thrd->period , cur->release_time , min_th->current_deadline);
                        // a preemption can occur
                        if(cur_min == NULL){
    7ca2:	f9843783          	ld	a5,-104(s0)
    7ca6:	e791                	bnez	a5,7cb2 <schedule_edf+0x262>
                            cur_min = cur;
    7ca8:	fa043783          	ld	a5,-96(s0)
    7cac:	f8f43c23          	sd	a5,-104(s0)
    7cb0:	a069                	j	7d3a <schedule_edf+0x2ea>
                        }else{
                            if((cur->thrd->period + cur->release_time < cur_min->thrd->period + cur_min->release_time)&& cur->thrd->n != 0){
    7cb2:	fa043783          	ld	a5,-96(s0)
    7cb6:	639c                	ld	a5,0(a5)
    7cb8:	43f8                	lw	a4,68(a5)
    7cba:	fa043783          	ld	a5,-96(s0)
    7cbe:	4f9c                	lw	a5,24(a5)
    7cc0:	9fb9                	addw	a5,a5,a4
    7cc2:	0007869b          	sext.w	a3,a5
    7cc6:	f9843783          	ld	a5,-104(s0)
    7cca:	639c                	ld	a5,0(a5)
    7ccc:	43f8                	lw	a4,68(a5)
    7cce:	f9843783          	ld	a5,-104(s0)
    7cd2:	4f9c                	lw	a5,24(a5)
    7cd4:	9fb9                	addw	a5,a5,a4
    7cd6:	2781                	sext.w	a5,a5
    7cd8:	8736                	mv	a4,a3
    7cda:	00f75c63          	bge	a4,a5,7cf2 <schedule_edf+0x2a2>
    7cde:	fa043783          	ld	a5,-96(s0)
    7ce2:	639c                	ld	a5,0(a5)
    7ce4:	47bc                	lw	a5,72(a5)
    7ce6:	c791                	beqz	a5,7cf2 <schedule_edf+0x2a2>
                                cur_min = cur;
    7ce8:	fa043783          	ld	a5,-96(s0)
    7cec:	f8f43c23          	sd	a5,-104(s0)
    7cf0:	a0a9                	j	7d3a <schedule_edf+0x2ea>
                            }else if(cur->thrd->period + cur->release_time == cur_min->thrd->period + cur_min->release_time){
    7cf2:	fa043783          	ld	a5,-96(s0)
    7cf6:	639c                	ld	a5,0(a5)
    7cf8:	43f8                	lw	a4,68(a5)
    7cfa:	fa043783          	ld	a5,-96(s0)
    7cfe:	4f9c                	lw	a5,24(a5)
    7d00:	9fb9                	addw	a5,a5,a4
    7d02:	0007869b          	sext.w	a3,a5
    7d06:	f9843783          	ld	a5,-104(s0)
    7d0a:	639c                	ld	a5,0(a5)
    7d0c:	43f8                	lw	a4,68(a5)
    7d0e:	f9843783          	ld	a5,-104(s0)
    7d12:	4f9c                	lw	a5,24(a5)
    7d14:	9fb9                	addw	a5,a5,a4
    7d16:	2781                	sext.w	a5,a5
    7d18:	8736                	mv	a4,a3
    7d1a:	02f71063          	bne	a4,a5,7d3a <schedule_edf+0x2ea>
                                if(cur_min->thrd->ID > cur->thrd->ID){
    7d1e:	f9843783          	ld	a5,-104(s0)
    7d22:	639c                	ld	a5,0(a5)
    7d24:	5398                	lw	a4,32(a5)
    7d26:	fa043783          	ld	a5,-96(s0)
    7d2a:	639c                	ld	a5,0(a5)
    7d2c:	539c                	lw	a5,32(a5)
    7d2e:	00e7d663          	bge	a5,a4,7d3a <schedule_edf+0x2ea>
                                    cur_min = cur;
    7d32:	fa043783          	ld	a5,-96(s0)
    7d36:	f8f43c23          	sd	a5,-104(s0)
                list_for_each_entry(cur, args.release_queue, thread_list) {
    7d3a:	fa043783          	ld	a5,-96(s0)
    7d3e:	679c                	ld	a5,8(a5)
    7d40:	f6f43823          	sd	a5,-144(s0)
    7d44:	f7043783          	ld	a5,-144(s0)
    7d48:	17e1                	addi	a5,a5,-8
    7d4a:	faf43023          	sd	a5,-96(s0)
    7d4e:	fa043783          	ld	a5,-96(s0)
    7d52:	00878713          	addi	a4,a5,8
    7d56:	689c                	ld	a5,16(s1)
    7d58:	f2f711e3          	bne	a4,a5,7c7a <schedule_edf+0x22a>
                                }
                            }
                        }
                    }
                }
                if(cur_min != NULL){
    7d5c:	f9843783          	ld	a5,-104(s0)
    7d60:	cb89                	beqz	a5,7d72 <schedule_edf+0x322>
                    // a preemption is possible
                    remaining_time = cur_min->release_time - args.current_time;
    7d62:	f9843783          	ld	a5,-104(s0)
    7d66:	4f98                	lw	a4,24(a5)
    7d68:	409c                	lw	a5,0(s1)
    7d6a:	40f707bb          	subw	a5,a4,a5
    7d6e:	f8f42a23          	sw	a5,-108(s0)
                }
                int deadline_time = min_th->current_deadline - args.current_time;
    7d72:	fb043783          	ld	a5,-80(s0)
    7d76:	4bb8                	lw	a4,80(a5)
    7d78:	409c                	lw	a5,0(s1)
    7d7a:	40f707bb          	subw	a5,a4,a5
    7d7e:	f6f42e23          	sw	a5,-132(s0)
                remaining_time = deadline_time<remaining_time? deadline_time: remaining_time;
    7d82:	f7c42603          	lw	a2,-132(s0)
    7d86:	f9442783          	lw	a5,-108(s0)
    7d8a:	0007869b          	sext.w	a3,a5
    7d8e:	0006071b          	sext.w	a4,a2
    7d92:	00d75363          	bge	a4,a3,7d98 <schedule_edf+0x348>
    7d96:	87b2                	mv	a5,a2
    7d98:	f8f42a23          	sw	a5,-108(s0)
                int met_time = min_th->remaining_time;
    7d9c:	fb043783          	ld	a5,-80(s0)
    7da0:	47fc                	lw	a5,76(a5)
    7da2:	f6f42c23          	sw	a5,-136(s0)
                remaining_time = met_time<remaining_time? met_time: remaining_time;
    7da6:	f7842603          	lw	a2,-136(s0)
    7daa:	f9442783          	lw	a5,-108(s0)
    7dae:	0007869b          	sext.w	a3,a5
    7db2:	0006071b          	sext.w	a4,a2
    7db6:	00d75363          	bge	a4,a3,7dbc <schedule_edf+0x36c>
    7dba:	87b2                	mv	a5,a2
    7dbc:	f8f42a23          	sw	a5,-108(s0)
                r.allocated_time = remaining_time;
    7dc0:	f9442783          	lw	a5,-108(s0)
    7dc4:	f2f42823          	sw	a5,-208(s0)
            }

            return r;
    7dc8:	f2843783          	ld	a5,-216(s0)
    7dcc:	f2f43c23          	sd	a5,-200(s0)
    7dd0:	f3043783          	ld	a5,-208(s0)
    7dd4:	f4f43023          	sd	a5,-192(s0)
        }
    }

    return schedule_default(args);
}
    7dd8:	f3843703          	ld	a4,-200(s0)
    7ddc:	f4043783          	ld	a5,-192(s0)
    7de0:	893a                	mv	s2,a4
    7de2:	89be                	mv	s3,a5
    7de4:	874a                	mv	a4,s2
    7de6:	87ce                	mv	a5,s3
    7de8:	853a                	mv	a0,a4
    7dea:	85be                	mv	a1,a5
    7dec:	60ee                	ld	ra,216(sp)
    7dee:	644e                	ld	s0,208(sp)
    7df0:	64ae                	ld	s1,200(sp)
    7df2:	690e                	ld	s2,192(sp)
    7df4:	79ea                	ld	s3,184(sp)
    7df6:	612d                	addi	sp,sp,224
    7df8:	8082                	ret

0000000000007dfa <schedule_rm>:

/* Rate-Monotonic Scheduling */
struct threads_sched_result schedule_rm(struct threads_sched_args args)
{
    7dfa:	7115                	addi	sp,sp,-224
    7dfc:	ed86                	sd	ra,216(sp)
    7dfe:	e9a2                	sd	s0,208(sp)
    7e00:	e5a6                	sd	s1,200(sp)
    7e02:	e1ca                	sd	s2,192(sp)
    7e04:	fd4e                	sd	s3,184(sp)
    7e06:	1180                	addi	s0,sp,224
    7e08:	84aa                	mv	s1,a0
    
    struct threads_sched_result r;
    if(list_empty(args.run_queue)){
    7e0a:	649c                	ld	a5,8(s1)
    7e0c:	853e                	mv	a0,a5
    7e0e:	00000097          	auipc	ra,0x0
    7e12:	b58080e7          	jalr	-1192(ra) # 7966 <list_empty>
    7e16:	87aa                	mv	a5,a0
    7e18:	c3d1                	beqz	a5,7e9c <schedule_rm+0xa2>
        // SPEC 3
        r.scheduled_thread_list_member = args.run_queue;
    7e1a:	649c                	ld	a5,8(s1)
    7e1c:	f2f43423          	sd	a5,-216(s0)
        int least_release_time = 99999;
    7e20:	67e1                	lui	a5,0x18
    7e22:	69f78793          	addi	a5,a5,1695 # 1869f <__BSS_END__+0x756f>
    7e26:	fcf42623          	sw	a5,-52(s0)
        struct release_queue_entry* cur;
        list_for_each_entry(cur, args.release_queue, thread_list) {
    7e2a:	689c                	ld	a5,16(s1)
    7e2c:	639c                	ld	a5,0(a5)
    7e2e:	f4f43823          	sd	a5,-176(s0)
    7e32:	f5043783          	ld	a5,-176(s0)
    7e36:	17e1                	addi	a5,a5,-8
    7e38:	fcf43023          	sd	a5,-64(s0)
    7e3c:	a805                	j	7e6c <schedule_rm+0x72>
            if(cur->release_time<least_release_time){
    7e3e:	fc043783          	ld	a5,-64(s0)
    7e42:	4f98                	lw	a4,24(a5)
    7e44:	fcc42783          	lw	a5,-52(s0)
    7e48:	2781                	sext.w	a5,a5
    7e4a:	00f75763          	bge	a4,a5,7e58 <schedule_rm+0x5e>
                least_release_time = cur->release_time;
    7e4e:	fc043783          	ld	a5,-64(s0)
    7e52:	4f9c                	lw	a5,24(a5)
    7e54:	fcf42623          	sw	a5,-52(s0)
        list_for_each_entry(cur, args.release_queue, thread_list) {
    7e58:	fc043783          	ld	a5,-64(s0)
    7e5c:	679c                	ld	a5,8(a5)
    7e5e:	f4f43423          	sd	a5,-184(s0)
    7e62:	f4843783          	ld	a5,-184(s0)
    7e66:	17e1                	addi	a5,a5,-8
    7e68:	fcf43023          	sd	a5,-64(s0)
    7e6c:	fc043783          	ld	a5,-64(s0)
    7e70:	00878713          	addi	a4,a5,8
    7e74:	689c                	ld	a5,16(s1)
    7e76:	fcf714e3          	bne	a4,a5,7e3e <schedule_rm+0x44>
            }
        }
        r.allocated_time = least_release_time - args.current_time ;
    7e7a:	409c                	lw	a5,0(s1)
    7e7c:	fcc42703          	lw	a4,-52(s0)
    7e80:	40f707bb          	subw	a5,a4,a5
    7e84:	2781                	sext.w	a5,a5
    7e86:	f2f42823          	sw	a5,-208(s0)
        return r;
    7e8a:	f2843783          	ld	a5,-216(s0)
    7e8e:	f2f43c23          	sd	a5,-200(s0)
    7e92:	f3043783          	ld	a5,-208(s0)
    7e96:	f4f43023          	sd	a5,-192(s0)
    7e9a:	ac61                	j	8132 <schedule_rm+0x338>
    }else{
        // run queue is not empty.
        struct thread *th = NULL;
    7e9c:	fa043c23          	sd	zero,-72(s0)
        struct thread *min_th = NULL;
    7ea0:	fa043823          	sd	zero,-80(s0)
        struct thread *min_miss_deadline_th = NULL;
    7ea4:	fa043423          	sd	zero,-88(s0)
        list_for_each_entry(th, args.run_queue, thread_list) {
    7ea8:	649c                	ld	a5,8(s1)
    7eaa:	639c                	ld	a5,0(a5)
    7eac:	f8f43423          	sd	a5,-120(s0)
    7eb0:	f8843783          	ld	a5,-120(s0)
    7eb4:	fd878793          	addi	a5,a5,-40
    7eb8:	faf43c23          	sd	a5,-72(s0)
    7ebc:	a849                	j	7f4e <schedule_rm+0x154>
            if(th->current_deadline <= args.current_time){
    7ebe:	fb843783          	ld	a5,-72(s0)
    7ec2:	4bb8                	lw	a4,80(a5)
    7ec4:	409c                	lw	a5,0(s1)
    7ec6:	02e7c163          	blt	a5,a4,7ee8 <schedule_rm+0xee>
                if(min_miss_deadline_th == NULL || th->ID<min_miss_deadline_th->ID){
    7eca:	fa843783          	ld	a5,-88(s0)
    7ece:	cb89                	beqz	a5,7ee0 <schedule_rm+0xe6>
    7ed0:	fb843783          	ld	a5,-72(s0)
    7ed4:	5398                	lw	a4,32(a5)
    7ed6:	fa843783          	ld	a5,-88(s0)
    7eda:	539c                	lw	a5,32(a5)
    7edc:	00f75663          	bge	a4,a5,7ee8 <schedule_rm+0xee>
                    min_miss_deadline_th = th;
    7ee0:	fb843783          	ld	a5,-72(s0)
    7ee4:	faf43423          	sd	a5,-88(s0)
                }
            }
            if(min_th == NULL) min_th = th;
    7ee8:	fb043783          	ld	a5,-80(s0)
    7eec:	e789                	bnez	a5,7ef6 <schedule_rm+0xfc>
    7eee:	fb843783          	ld	a5,-72(s0)
    7ef2:	faf43823          	sd	a5,-80(s0)
            if(th->period<min_th->period){
    7ef6:	fb843783          	ld	a5,-72(s0)
    7efa:	43f8                	lw	a4,68(a5)
    7efc:	fb043783          	ld	a5,-80(s0)
    7f00:	43fc                	lw	a5,68(a5)
    7f02:	00f75763          	bge	a4,a5,7f10 <schedule_rm+0x116>
                min_th = th;
    7f06:	fb843783          	ld	a5,-72(s0)
    7f0a:	faf43823          	sd	a5,-80(s0)
    7f0e:	a02d                	j	7f38 <schedule_rm+0x13e>
            }else if(th->period == min_th->period){
    7f10:	fb843783          	ld	a5,-72(s0)
    7f14:	43f8                	lw	a4,68(a5)
    7f16:	fb043783          	ld	a5,-80(s0)
    7f1a:	43fc                	lw	a5,68(a5)
    7f1c:	00f71e63          	bne	a4,a5,7f38 <schedule_rm+0x13e>
                if(th->ID<min_th->ID) min_th = th;
    7f20:	fb843783          	ld	a5,-72(s0)
    7f24:	5398                	lw	a4,32(a5)
    7f26:	fb043783          	ld	a5,-80(s0)
    7f2a:	539c                	lw	a5,32(a5)
    7f2c:	00f75663          	bge	a4,a5,7f38 <schedule_rm+0x13e>
    7f30:	fb843783          	ld	a5,-72(s0)
    7f34:	faf43823          	sd	a5,-80(s0)
        list_for_each_entry(th, args.run_queue, thread_list) {
    7f38:	fb843783          	ld	a5,-72(s0)
    7f3c:	779c                	ld	a5,40(a5)
    7f3e:	f4f43c23          	sd	a5,-168(s0)
    7f42:	f5843783          	ld	a5,-168(s0)
    7f46:	fd878793          	addi	a5,a5,-40
    7f4a:	faf43c23          	sd	a5,-72(s0)
    7f4e:	fb843783          	ld	a5,-72(s0)
    7f52:	02878713          	addi	a4,a5,40
    7f56:	649c                	ld	a5,8(s1)
    7f58:	f6f713e3          	bne	a4,a5,7ebe <schedule_rm+0xc4>
            }
        }

        if(min_miss_deadline_th != NULL) {
    7f5c:	fa843783          	ld	a5,-88(s0)
    7f60:	c395                	beqz	a5,7f84 <schedule_rm+0x18a>
            // SPEC 4: exist missed deadline
            r.allocated_time = 0;
    7f62:	f2042823          	sw	zero,-208(s0)
            r.scheduled_thread_list_member = &min_miss_deadline_th->thread_list;
    7f66:	fa843783          	ld	a5,-88(s0)
    7f6a:	02878793          	addi	a5,a5,40
    7f6e:	f2f43423          	sd	a5,-216(s0)
            return r;
    7f72:	f2843783          	ld	a5,-216(s0)
    7f76:	f2f43c23          	sd	a5,-200(s0)
    7f7a:	f3043783          	ld	a5,-208(s0)
    7f7e:	f4f43023          	sd	a5,-192(s0)
    7f82:	aa45                	j	8132 <schedule_rm+0x338>
             // compute allocated time: 
            // 1. a preemption can happen in the future.(need to inspect the release queue)
            // 2. current deadline is met (preemption has not happened)
            // 3. current deadline is missed (current_time + remaining_time > current_deadline)
            // compute the first event that will happen.
            r.scheduled_thread_list_member = &min_th->thread_list;
    7f84:	fb043783          	ld	a5,-80(s0)
    7f88:	02878793          	addi	a5,a5,40
    7f8c:	f2f43423          	sd	a5,-216(s0)

            struct release_queue_entry* cur;
            if(list_empty(args.release_queue)){
    7f90:	689c                	ld	a5,16(s1)
    7f92:	853e                	mv	a0,a5
    7f94:	00000097          	auipc	ra,0x0
    7f98:	9d2080e7          	jalr	-1582(ra) # 7966 <list_empty>
    7f9c:	87aa                	mv	a5,a0
    7f9e:	c3b5                	beqz	a5,8002 <schedule_rm+0x208>
                // a preemption cannot happen, because we've already selected the highest priority thread.
                int remaining_time = 99999;
    7fa0:	67e1                	lui	a5,0x18
    7fa2:	69f78793          	addi	a5,a5,1695 # 1869f <__BSS_END__+0x756f>
    7fa6:	f6f42623          	sw	a5,-148(s0)

                int deadline_time = min_th->current_deadline - args.current_time;
    7faa:	fb043783          	ld	a5,-80(s0)
    7fae:	4bb8                	lw	a4,80(a5)
    7fb0:	409c                	lw	a5,0(s1)
    7fb2:	40f707bb          	subw	a5,a4,a5
    7fb6:	f6f42423          	sw	a5,-152(s0)
                remaining_time = deadline_time<remaining_time? deadline_time: remaining_time;
    7fba:	f6842603          	lw	a2,-152(s0)
    7fbe:	f6c42783          	lw	a5,-148(s0)
    7fc2:	0007869b          	sext.w	a3,a5
    7fc6:	0006071b          	sext.w	a4,a2
    7fca:	00d75363          	bge	a4,a3,7fd0 <schedule_rm+0x1d6>
    7fce:	87b2                	mv	a5,a2
    7fd0:	f6f42623          	sw	a5,-148(s0)
                int met_time = min_th->remaining_time;
    7fd4:	fb043783          	ld	a5,-80(s0)
    7fd8:	47fc                	lw	a5,76(a5)
    7fda:	f6f42223          	sw	a5,-156(s0)
                remaining_time = met_time<remaining_time? met_time: remaining_time;
    7fde:	f6442603          	lw	a2,-156(s0)
    7fe2:	f6c42783          	lw	a5,-148(s0)
    7fe6:	0007869b          	sext.w	a3,a5
    7fea:	0006071b          	sext.w	a4,a2
    7fee:	00d75363          	bge	a4,a3,7ff4 <schedule_rm+0x1fa>
    7ff2:	87b2                	mv	a5,a2
    7ff4:	f6f42623          	sw	a5,-148(s0)
                
                r.allocated_time = remaining_time;
    7ff8:	f6c42783          	lw	a5,-148(s0)
    7ffc:	f2f42823          	sw	a5,-208(s0)
    8000:	a20d                	j	8122 <schedule_rm+0x328>
            }else{
                // first check if a preemption can happen
                struct release_queue_entry* cur_min = NULL;
    8002:	f8043c23          	sd	zero,-104(s0)
                int remaining_time = 99999;
    8006:	67e1                	lui	a5,0x18
    8008:	69f78793          	addi	a5,a5,1695 # 1869f <__BSS_END__+0x756f>
    800c:	f8f42a23          	sw	a5,-108(s0)
                list_for_each_entry(cur, args.release_queue, thread_list) {
    8010:	689c                	ld	a5,16(s1)
    8012:	639c                	ld	a5,0(a5)
    8014:	f8f43023          	sd	a5,-128(s0)
    8018:	f8043783          	ld	a5,-128(s0)
    801c:	17e1                	addi	a5,a5,-8
    801e:	faf43023          	sd	a5,-96(s0)
    8022:	a059                	j	80a8 <schedule_rm+0x2ae>
                    if(cur->thrd->period<min_th->period){
    8024:	fa043783          	ld	a5,-96(s0)
    8028:	639c                	ld	a5,0(a5)
    802a:	43f8                	lw	a4,68(a5)
    802c:	fb043783          	ld	a5,-80(s0)
    8030:	43fc                	lw	a5,68(a5)
    8032:	06f75163          	bge	a4,a5,8094 <schedule_rm+0x29a>
                        // a preemption can occur
                        if(cur_min == NULL){
    8036:	f9843783          	ld	a5,-104(s0)
    803a:	e791                	bnez	a5,8046 <schedule_rm+0x24c>
                            cur_min = cur;
    803c:	fa043783          	ld	a5,-96(s0)
    8040:	f8f43c23          	sd	a5,-104(s0)
    8044:	a881                	j	8094 <schedule_rm+0x29a>
                        }else{
                            if(cur_min->thrd->period>cur->thrd->period){
    8046:	f9843783          	ld	a5,-104(s0)
    804a:	639c                	ld	a5,0(a5)
    804c:	43f8                	lw	a4,68(a5)
    804e:	fa043783          	ld	a5,-96(s0)
    8052:	639c                	ld	a5,0(a5)
    8054:	43fc                	lw	a5,68(a5)
    8056:	00e7d763          	bge	a5,a4,8064 <schedule_rm+0x26a>
                                cur_min = cur;
    805a:	fa043783          	ld	a5,-96(s0)
    805e:	f8f43c23          	sd	a5,-104(s0)
    8062:	a80d                	j	8094 <schedule_rm+0x29a>
                            }else if(cur_min->thrd->period == cur->thrd->period){
    8064:	f9843783          	ld	a5,-104(s0)
    8068:	639c                	ld	a5,0(a5)
    806a:	43f8                	lw	a4,68(a5)
    806c:	fa043783          	ld	a5,-96(s0)
    8070:	639c                	ld	a5,0(a5)
    8072:	43fc                	lw	a5,68(a5)
    8074:	02f71063          	bne	a4,a5,8094 <schedule_rm+0x29a>
                                if(cur_min->thrd->ID > cur->thrd->ID){
    8078:	f9843783          	ld	a5,-104(s0)
    807c:	639c                	ld	a5,0(a5)
    807e:	5398                	lw	a4,32(a5)
    8080:	fa043783          	ld	a5,-96(s0)
    8084:	639c                	ld	a5,0(a5)
    8086:	539c                	lw	a5,32(a5)
    8088:	00e7d663          	bge	a5,a4,8094 <schedule_rm+0x29a>
                                    cur_min = cur;
    808c:	fa043783          	ld	a5,-96(s0)
    8090:	f8f43c23          	sd	a5,-104(s0)
                list_for_each_entry(cur, args.release_queue, thread_list) {
    8094:	fa043783          	ld	a5,-96(s0)
    8098:	679c                	ld	a5,8(a5)
    809a:	f6f43823          	sd	a5,-144(s0)
    809e:	f7043783          	ld	a5,-144(s0)
    80a2:	17e1                	addi	a5,a5,-8
    80a4:	faf43023          	sd	a5,-96(s0)
    80a8:	fa043783          	ld	a5,-96(s0)
    80ac:	00878713          	addi	a4,a5,8
    80b0:	689c                	ld	a5,16(s1)
    80b2:	f6f719e3          	bne	a4,a5,8024 <schedule_rm+0x22a>
                                }
                            }
                        }
                    }
                }
                if(cur_min != NULL){
    80b6:	f9843783          	ld	a5,-104(s0)
    80ba:	cb89                	beqz	a5,80cc <schedule_rm+0x2d2>
                    // a preemption is possible
                    remaining_time = cur_min->release_time - args.current_time;
    80bc:	f9843783          	ld	a5,-104(s0)
    80c0:	4f98                	lw	a4,24(a5)
    80c2:	409c                	lw	a5,0(s1)
    80c4:	40f707bb          	subw	a5,a4,a5
    80c8:	f8f42a23          	sw	a5,-108(s0)
                }
                int deadline_time = min_th->current_deadline - args.current_time;
    80cc:	fb043783          	ld	a5,-80(s0)
    80d0:	4bb8                	lw	a4,80(a5)
    80d2:	409c                	lw	a5,0(s1)
    80d4:	40f707bb          	subw	a5,a4,a5
    80d8:	f6f42e23          	sw	a5,-132(s0)
                remaining_time = deadline_time<remaining_time? deadline_time: remaining_time;
    80dc:	f7c42603          	lw	a2,-132(s0)
    80e0:	f9442783          	lw	a5,-108(s0)
    80e4:	0007869b          	sext.w	a3,a5
    80e8:	0006071b          	sext.w	a4,a2
    80ec:	00d75363          	bge	a4,a3,80f2 <schedule_rm+0x2f8>
    80f0:	87b2                	mv	a5,a2
    80f2:	f8f42a23          	sw	a5,-108(s0)
                int met_time = min_th->remaining_time;
    80f6:	fb043783          	ld	a5,-80(s0)
    80fa:	47fc                	lw	a5,76(a5)
    80fc:	f6f42c23          	sw	a5,-136(s0)
                remaining_time = met_time<remaining_time? met_time: remaining_time;
    8100:	f7842603          	lw	a2,-136(s0)
    8104:	f9442783          	lw	a5,-108(s0)
    8108:	0007869b          	sext.w	a3,a5
    810c:	0006071b          	sext.w	a4,a2
    8110:	00d75363          	bge	a4,a3,8116 <schedule_rm+0x31c>
    8114:	87b2                	mv	a5,a2
    8116:	f8f42a23          	sw	a5,-108(s0)
                
                r.allocated_time = remaining_time;
    811a:	f9442783          	lw	a5,-108(s0)
    811e:	f2f42823          	sw	a5,-208(s0)
            }

            return r;
    8122:	f2843783          	ld	a5,-216(s0)
    8126:	f2f43c23          	sd	a5,-200(s0)
    812a:	f3043783          	ld	a5,-208(s0)
    812e:	f4f43023          	sd	a5,-192(s0)
        }
    }
}
    8132:	f3843703          	ld	a4,-200(s0)
    8136:	f4043783          	ld	a5,-192(s0)
    813a:	893a                	mv	s2,a4
    813c:	89be                	mv	s3,a5
    813e:	874a                	mv	a4,s2
    8140:	87ce                	mv	a5,s3
    8142:	853a                	mv	a0,a4
    8144:	85be                	mv	a1,a5
    8146:	60ee                	ld	ra,216(sp)
    8148:	644e                	ld	s0,208(sp)
    814a:	64ae                	ld	s1,200(sp)
    814c:	690e                	ld	s2,192(sp)
    814e:	79ea                	ld	s3,184(sp)
    8150:	612d                	addi	sp,sp,224
    8152:	8082                	ret
