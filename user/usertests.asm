
user/_usertests:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <copyinstr1>:
}

// what if you pass ridiculous string pointers to system calls?
void
copyinstr1(char *s)
{
       0:	711d                	addi	sp,sp,-96
       2:	ec86                	sd	ra,88(sp)
       4:	e8a2                	sd	s0,80(sp)
       6:	e4a6                	sd	s1,72(sp)
       8:	e0ca                	sd	s2,64(sp)
       a:	fc4e                	sd	s3,56(sp)
       c:	1080                	addi	s0,sp,96
  uint64 addrs[] = {0x80000000LL, 0x3fffffe000, 0x3ffffff000, 0x4000000000,
       e:	00008797          	auipc	a5,0x8
      12:	34a78793          	addi	a5,a5,842 # 8358 <malloc+0x2a0e>
      16:	638c                	ld	a1,0(a5)
      18:	6790                	ld	a2,8(a5)
      1a:	6b94                	ld	a3,16(a5)
      1c:	6f98                	ld	a4,24(a5)
      1e:	739c                	ld	a5,32(a5)
      20:	fab43423          	sd	a1,-88(s0)
      24:	fac43823          	sd	a2,-80(s0)
      28:	fad43c23          	sd	a3,-72(s0)
      2c:	fce43023          	sd	a4,-64(s0)
      30:	fcf43423          	sd	a5,-56(s0)
                    0xffffffffffffffff};

  for (int ai = 0; ai < sizeof(addrs) / sizeof(addrs[0]); ai++) {
      34:	fa840493          	addi	s1,s0,-88
      38:	fd040993          	addi	s3,s0,-48
    uint64 addr = addrs[ai];

    int fd = open((char *)addr, O_CREATE | O_WRONLY);
      3c:	0004b903          	ld	s2,0(s1)
      40:	20100593          	li	a1,513
      44:	854a                	mv	a0,s2
      46:	46c050ef          	jal	ra,54b2 <open>
    if (fd >= 0) {
      4a:	00055c63          	bgez	a0,62 <copyinstr1+0x62>
  for (int ai = 0; ai < sizeof(addrs) / sizeof(addrs[0]); ai++) {
      4e:	04a1                	addi	s1,s1,8
      50:	ff3496e3          	bne	s1,s3,3c <copyinstr1+0x3c>
      printf("open(%p) returned %d, not -1\n", (void *)addr, fd);
      exit(1);
    }
  }
}
      54:	60e6                	ld	ra,88(sp)
      56:	6446                	ld	s0,80(sp)
      58:	64a6                	ld	s1,72(sp)
      5a:	6906                	ld	s2,64(sp)
      5c:	79e2                	ld	s3,56(sp)
      5e:	6125                	addi	sp,sp,96
      60:	8082                	ret
      printf("open(%p) returned %d, not -1\n", (void *)addr, fd);
      62:	862a                	mv	a2,a0
      64:	85ca                	mv	a1,s2
      66:	00006517          	auipc	a0,0x6
      6a:	9ca50513          	addi	a0,a0,-1590 # 5a30 <malloc+0xe6>
      6e:	029050ef          	jal	ra,5896 <printf>
      exit(1);
      72:	4505                	li	a0,1
      74:	3fe050ef          	jal	ra,5472 <exit>

0000000000000078 <bsstest>:
void
bsstest(char *s)
{
  int i;

  for (i = 0; i < sizeof(uninit); i++) {
      78:	0000a797          	auipc	a5,0xa
      7c:	57078793          	addi	a5,a5,1392 # a5e8 <uninit>
      80:	0000d697          	auipc	a3,0xd
      84:	c7868693          	addi	a3,a3,-904 # ccf8 <buf>
    if (uninit[i] != '\0') {
      88:	0007c703          	lbu	a4,0(a5)
      8c:	e709                	bnez	a4,96 <bsstest+0x1e>
  for (i = 0; i < sizeof(uninit); i++) {
      8e:	0785                	addi	a5,a5,1
      90:	fed79ce3          	bne	a5,a3,88 <bsstest+0x10>
      94:	8082                	ret
{
      96:	1141                	addi	sp,sp,-16
      98:	e406                	sd	ra,8(sp)
      9a:	e022                	sd	s0,0(sp)
      9c:	0800                	addi	s0,sp,16
      printf("%s: bss test failed\n", s);
      9e:	85aa                	mv	a1,a0
      a0:	00006517          	auipc	a0,0x6
      a4:	9b050513          	addi	a0,a0,-1616 # 5a50 <malloc+0x106>
      a8:	7ee050ef          	jal	ra,5896 <printf>
      exit(1);
      ac:	4505                	li	a0,1
      ae:	3c4050ef          	jal	ra,5472 <exit>

00000000000000b2 <opentest>:
{
      b2:	1101                	addi	sp,sp,-32
      b4:	ec06                	sd	ra,24(sp)
      b6:	e822                	sd	s0,16(sp)
      b8:	e426                	sd	s1,8(sp)
      ba:	1000                	addi	s0,sp,32
      bc:	84aa                	mv	s1,a0
  fd = open("echo", 0);
      be:	4581                	li	a1,0
      c0:	00006517          	auipc	a0,0x6
      c4:	9a850513          	addi	a0,a0,-1624 # 5a68 <malloc+0x11e>
      c8:	3ea050ef          	jal	ra,54b2 <open>
  if (fd < 0) {
      cc:	02054263          	bltz	a0,f0 <opentest+0x3e>
  close(fd);
      d0:	3ca050ef          	jal	ra,549a <close>
  fd = open("doesnotexist", 0);
      d4:	4581                	li	a1,0
      d6:	00006517          	auipc	a0,0x6
      da:	9b250513          	addi	a0,a0,-1614 # 5a88 <malloc+0x13e>
      de:	3d4050ef          	jal	ra,54b2 <open>
  if (fd >= 0) {
      e2:	02055163          	bgez	a0,104 <opentest+0x52>
}
      e6:	60e2                	ld	ra,24(sp)
      e8:	6442                	ld	s0,16(sp)
      ea:	64a2                	ld	s1,8(sp)
      ec:	6105                	addi	sp,sp,32
      ee:	8082                	ret
    printf("%s: open echo failed!\n", s);
      f0:	85a6                	mv	a1,s1
      f2:	00006517          	auipc	a0,0x6
      f6:	97e50513          	addi	a0,a0,-1666 # 5a70 <malloc+0x126>
      fa:	79c050ef          	jal	ra,5896 <printf>
    exit(1);
      fe:	4505                	li	a0,1
     100:	372050ef          	jal	ra,5472 <exit>
    printf("%s: open doesnotexist succeeded!\n", s);
     104:	85a6                	mv	a1,s1
     106:	00006517          	auipc	a0,0x6
     10a:	99250513          	addi	a0,a0,-1646 # 5a98 <malloc+0x14e>
     10e:	788050ef          	jal	ra,5896 <printf>
    exit(1);
     112:	4505                	li	a0,1
     114:	35e050ef          	jal	ra,5472 <exit>

0000000000000118 <truncate2>:
{
     118:	7179                	addi	sp,sp,-48
     11a:	f406                	sd	ra,40(sp)
     11c:	f022                	sd	s0,32(sp)
     11e:	ec26                	sd	s1,24(sp)
     120:	e84a                	sd	s2,16(sp)
     122:	e44e                	sd	s3,8(sp)
     124:	1800                	addi	s0,sp,48
     126:	89aa                	mv	s3,a0
  unlink("truncfile");
     128:	00006517          	auipc	a0,0x6
     12c:	99850513          	addi	a0,a0,-1640 # 5ac0 <malloc+0x176>
     130:	392050ef          	jal	ra,54c2 <unlink>
  int fd1 = open("truncfile", O_CREATE | O_TRUNC | O_WRONLY);
     134:	60100593          	li	a1,1537
     138:	00006517          	auipc	a0,0x6
     13c:	98850513          	addi	a0,a0,-1656 # 5ac0 <malloc+0x176>
     140:	372050ef          	jal	ra,54b2 <open>
     144:	84aa                	mv	s1,a0
  write(fd1, "abcd", 4);
     146:	4611                	li	a2,4
     148:	00006597          	auipc	a1,0x6
     14c:	98858593          	addi	a1,a1,-1656 # 5ad0 <malloc+0x186>
     150:	342050ef          	jal	ra,5492 <write>
  int fd2 = open("truncfile", O_TRUNC | O_WRONLY);
     154:	40100593          	li	a1,1025
     158:	00006517          	auipc	a0,0x6
     15c:	96850513          	addi	a0,a0,-1688 # 5ac0 <malloc+0x176>
     160:	352050ef          	jal	ra,54b2 <open>
     164:	892a                	mv	s2,a0
  int n = write(fd1, "x", 1);
     166:	4605                	li	a2,1
     168:	00006597          	auipc	a1,0x6
     16c:	97058593          	addi	a1,a1,-1680 # 5ad8 <malloc+0x18e>
     170:	8526                	mv	a0,s1
     172:	320050ef          	jal	ra,5492 <write>
  if (n != -1) {
     176:	57fd                	li	a5,-1
     178:	02f51563          	bne	a0,a5,1a2 <truncate2+0x8a>
  unlink("truncfile");
     17c:	00006517          	auipc	a0,0x6
     180:	94450513          	addi	a0,a0,-1724 # 5ac0 <malloc+0x176>
     184:	33e050ef          	jal	ra,54c2 <unlink>
  close(fd1);
     188:	8526                	mv	a0,s1
     18a:	310050ef          	jal	ra,549a <close>
  close(fd2);
     18e:	854a                	mv	a0,s2
     190:	30a050ef          	jal	ra,549a <close>
}
     194:	70a2                	ld	ra,40(sp)
     196:	7402                	ld	s0,32(sp)
     198:	64e2                	ld	s1,24(sp)
     19a:	6942                	ld	s2,16(sp)
     19c:	69a2                	ld	s3,8(sp)
     19e:	6145                	addi	sp,sp,48
     1a0:	8082                	ret
    printf("%s: write returned %d, expected -1\n", s, n);
     1a2:	862a                	mv	a2,a0
     1a4:	85ce                	mv	a1,s3
     1a6:	00006517          	auipc	a0,0x6
     1aa:	93a50513          	addi	a0,a0,-1734 # 5ae0 <malloc+0x196>
     1ae:	6e8050ef          	jal	ra,5896 <printf>
    exit(1);
     1b2:	4505                	li	a0,1
     1b4:	2be050ef          	jal	ra,5472 <exit>

00000000000001b8 <createtest>:
{
     1b8:	7179                	addi	sp,sp,-48
     1ba:	f406                	sd	ra,40(sp)
     1bc:	f022                	sd	s0,32(sp)
     1be:	ec26                	sd	s1,24(sp)
     1c0:	e84a                	sd	s2,16(sp)
     1c2:	1800                	addi	s0,sp,48
  name[0] = 'a';
     1c4:	06100793          	li	a5,97
     1c8:	fcf40c23          	sb	a5,-40(s0)
  name[2] = '\0';
     1cc:	fc040d23          	sb	zero,-38(s0)
     1d0:	03000493          	li	s1,48
  for (i = 0; i < N; i++) {
     1d4:	06400913          	li	s2,100
    name[1] = '0' + i;
     1d8:	fc940ca3          	sb	s1,-39(s0)
    fd = open(name, O_CREATE | O_RDWR);
     1dc:	20200593          	li	a1,514
     1e0:	fd840513          	addi	a0,s0,-40
     1e4:	2ce050ef          	jal	ra,54b2 <open>
    close(fd);
     1e8:	2b2050ef          	jal	ra,549a <close>
  for (i = 0; i < N; i++) {
     1ec:	2485                	addiw	s1,s1,1
     1ee:	0ff4f493          	zext.b	s1,s1
     1f2:	ff2493e3          	bne	s1,s2,1d8 <createtest+0x20>
  name[0] = 'a';
     1f6:	06100793          	li	a5,97
     1fa:	fcf40c23          	sb	a5,-40(s0)
  name[2] = '\0';
     1fe:	fc040d23          	sb	zero,-38(s0)
     202:	03000493          	li	s1,48
  for (i = 0; i < N; i++) {
     206:	06400913          	li	s2,100
    name[1] = '0' + i;
     20a:	fc940ca3          	sb	s1,-39(s0)
    unlink(name);
     20e:	fd840513          	addi	a0,s0,-40
     212:	2b0050ef          	jal	ra,54c2 <unlink>
  for (i = 0; i < N; i++) {
     216:	2485                	addiw	s1,s1,1
     218:	0ff4f493          	zext.b	s1,s1
     21c:	ff2497e3          	bne	s1,s2,20a <createtest+0x52>
}
     220:	70a2                	ld	ra,40(sp)
     222:	7402                	ld	s0,32(sp)
     224:	64e2                	ld	s1,24(sp)
     226:	6942                	ld	s2,16(sp)
     228:	6145                	addi	sp,sp,48
     22a:	8082                	ret

000000000000022c <bigwrite>:
{
     22c:	715d                	addi	sp,sp,-80
     22e:	e486                	sd	ra,72(sp)
     230:	e0a2                	sd	s0,64(sp)
     232:	fc26                	sd	s1,56(sp)
     234:	f84a                	sd	s2,48(sp)
     236:	f44e                	sd	s3,40(sp)
     238:	f052                	sd	s4,32(sp)
     23a:	ec56                	sd	s5,24(sp)
     23c:	e85a                	sd	s6,16(sp)
     23e:	e45e                	sd	s7,8(sp)
     240:	0880                	addi	s0,sp,80
     242:	8baa                	mv	s7,a0
  unlink("bigwrite");
     244:	00006517          	auipc	a0,0x6
     248:	8c450513          	addi	a0,a0,-1852 # 5b08 <malloc+0x1be>
     24c:	276050ef          	jal	ra,54c2 <unlink>
  for (sz = 499; sz < (MAXOPBLOCKS + 2) * BSIZE; sz += 471) {
     250:	1f300493          	li	s1,499
    fd = open("bigwrite", O_CREATE | O_RDWR);
     254:	00006a97          	auipc	s5,0x6
     258:	8b4a8a93          	addi	s5,s5,-1868 # 5b08 <malloc+0x1be>
      int cc = write(fd, buf, sz);
     25c:	0000da17          	auipc	s4,0xd
     260:	a9ca0a13          	addi	s4,s4,-1380 # ccf8 <buf>
  for (sz = 499; sz < (MAXOPBLOCKS + 2) * BSIZE; sz += 471) {
     264:	6b0d                	lui	s6,0x3
     266:	1c9b0b13          	addi	s6,s6,457 # 31c9 <dirfile+0xbb>
    fd = open("bigwrite", O_CREATE | O_RDWR);
     26a:	20200593          	li	a1,514
     26e:	8556                	mv	a0,s5
     270:	242050ef          	jal	ra,54b2 <open>
     274:	892a                	mv	s2,a0
    if (fd < 0) {
     276:	04054563          	bltz	a0,2c0 <bigwrite+0x94>
      int cc = write(fd, buf, sz);
     27a:	8626                	mv	a2,s1
     27c:	85d2                	mv	a1,s4
     27e:	214050ef          	jal	ra,5492 <write>
     282:	89aa                	mv	s3,a0
      if (cc != sz) {
     284:	04a49863          	bne	s1,a0,2d4 <bigwrite+0xa8>
      int cc = write(fd, buf, sz);
     288:	8626                	mv	a2,s1
     28a:	85d2                	mv	a1,s4
     28c:	854a                	mv	a0,s2
     28e:	204050ef          	jal	ra,5492 <write>
      if (cc != sz) {
     292:	04951263          	bne	a0,s1,2d6 <bigwrite+0xaa>
    close(fd);
     296:	854a                	mv	a0,s2
     298:	202050ef          	jal	ra,549a <close>
    unlink("bigwrite");
     29c:	8556                	mv	a0,s5
     29e:	224050ef          	jal	ra,54c2 <unlink>
  for (sz = 499; sz < (MAXOPBLOCKS + 2) * BSIZE; sz += 471) {
     2a2:	1d74849b          	addiw	s1,s1,471
     2a6:	fd6492e3          	bne	s1,s6,26a <bigwrite+0x3e>
}
     2aa:	60a6                	ld	ra,72(sp)
     2ac:	6406                	ld	s0,64(sp)
     2ae:	74e2                	ld	s1,56(sp)
     2b0:	7942                	ld	s2,48(sp)
     2b2:	79a2                	ld	s3,40(sp)
     2b4:	7a02                	ld	s4,32(sp)
     2b6:	6ae2                	ld	s5,24(sp)
     2b8:	6b42                	ld	s6,16(sp)
     2ba:	6ba2                	ld	s7,8(sp)
     2bc:	6161                	addi	sp,sp,80
     2be:	8082                	ret
      printf("%s: cannot create bigwrite\n", s);
     2c0:	85de                	mv	a1,s7
     2c2:	00006517          	auipc	a0,0x6
     2c6:	85650513          	addi	a0,a0,-1962 # 5b18 <malloc+0x1ce>
     2ca:	5cc050ef          	jal	ra,5896 <printf>
      exit(1);
     2ce:	4505                	li	a0,1
     2d0:	1a2050ef          	jal	ra,5472 <exit>
      if (cc != sz) {
     2d4:	89a6                	mv	s3,s1
        printf("%s: write(%d) ret %d\n", s, sz, cc);
     2d6:	86aa                	mv	a3,a0
     2d8:	864e                	mv	a2,s3
     2da:	85de                	mv	a1,s7
     2dc:	00006517          	auipc	a0,0x6
     2e0:	85c50513          	addi	a0,a0,-1956 # 5b38 <malloc+0x1ee>
     2e4:	5b2050ef          	jal	ra,5896 <printf>
        exit(1);
     2e8:	4505                	li	a0,1
     2ea:	188050ef          	jal	ra,5472 <exit>

00000000000002ee <badwrite>:
// file is deleted? if the kernel has this bug, it will panic: balloc:
// out of blocks. assumed_free may need to be raised to be more than
// the number of free blocks. this test takes a long time.
void
badwrite(char *s)
{
     2ee:	7179                	addi	sp,sp,-48
     2f0:	f406                	sd	ra,40(sp)
     2f2:	f022                	sd	s0,32(sp)
     2f4:	ec26                	sd	s1,24(sp)
     2f6:	e84a                	sd	s2,16(sp)
     2f8:	e44e                	sd	s3,8(sp)
     2fa:	e052                	sd	s4,0(sp)
     2fc:	1800                	addi	s0,sp,48
  int assumed_free = 600;

  unlink("junk");
     2fe:	00006517          	auipc	a0,0x6
     302:	85250513          	addi	a0,a0,-1966 # 5b50 <malloc+0x206>
     306:	1bc050ef          	jal	ra,54c2 <unlink>
     30a:	25800913          	li	s2,600
  for (int i = 0; i < assumed_free; i++) {
    int fd = open("junk", O_CREATE | O_WRONLY);
     30e:	00006997          	auipc	s3,0x6
     312:	84298993          	addi	s3,s3,-1982 # 5b50 <malloc+0x206>
    if (fd < 0) {
      printf("open junk failed\n");
      exit(1);
    }
    write(fd, (char *)0xffffffffffL, 1);
     316:	5a7d                	li	s4,-1
     318:	018a5a13          	srli	s4,s4,0x18
    int fd = open("junk", O_CREATE | O_WRONLY);
     31c:	20100593          	li	a1,513
     320:	854e                	mv	a0,s3
     322:	190050ef          	jal	ra,54b2 <open>
     326:	84aa                	mv	s1,a0
    if (fd < 0) {
     328:	04054d63          	bltz	a0,382 <badwrite+0x94>
    write(fd, (char *)0xffffffffffL, 1);
     32c:	4605                	li	a2,1
     32e:	85d2                	mv	a1,s4
     330:	162050ef          	jal	ra,5492 <write>
    close(fd);
     334:	8526                	mv	a0,s1
     336:	164050ef          	jal	ra,549a <close>
    unlink("junk");
     33a:	854e                	mv	a0,s3
     33c:	186050ef          	jal	ra,54c2 <unlink>
  for (int i = 0; i < assumed_free; i++) {
     340:	397d                	addiw	s2,s2,-1
     342:	fc091de3          	bnez	s2,31c <badwrite+0x2e>
  }

  int fd = open("junk", O_CREATE | O_WRONLY);
     346:	20100593          	li	a1,513
     34a:	00006517          	auipc	a0,0x6
     34e:	80650513          	addi	a0,a0,-2042 # 5b50 <malloc+0x206>
     352:	160050ef          	jal	ra,54b2 <open>
     356:	84aa                	mv	s1,a0
  if (fd < 0) {
     358:	02054e63          	bltz	a0,394 <badwrite+0xa6>
    printf("open junk failed\n");
    exit(1);
  }
  if (write(fd, "x", 1) != 1) {
     35c:	4605                	li	a2,1
     35e:	00005597          	auipc	a1,0x5
     362:	77a58593          	addi	a1,a1,1914 # 5ad8 <malloc+0x18e>
     366:	12c050ef          	jal	ra,5492 <write>
     36a:	4785                	li	a5,1
     36c:	02f50d63          	beq	a0,a5,3a6 <badwrite+0xb8>
    printf("write failed\n");
     370:	00006517          	auipc	a0,0x6
     374:	80050513          	addi	a0,a0,-2048 # 5b70 <malloc+0x226>
     378:	51e050ef          	jal	ra,5896 <printf>
    exit(1);
     37c:	4505                	li	a0,1
     37e:	0f4050ef          	jal	ra,5472 <exit>
      printf("open junk failed\n");
     382:	00005517          	auipc	a0,0x5
     386:	7d650513          	addi	a0,a0,2006 # 5b58 <malloc+0x20e>
     38a:	50c050ef          	jal	ra,5896 <printf>
      exit(1);
     38e:	4505                	li	a0,1
     390:	0e2050ef          	jal	ra,5472 <exit>
    printf("open junk failed\n");
     394:	00005517          	auipc	a0,0x5
     398:	7c450513          	addi	a0,a0,1988 # 5b58 <malloc+0x20e>
     39c:	4fa050ef          	jal	ra,5896 <printf>
    exit(1);
     3a0:	4505                	li	a0,1
     3a2:	0d0050ef          	jal	ra,5472 <exit>
  }
  close(fd);
     3a6:	8526                	mv	a0,s1
     3a8:	0f2050ef          	jal	ra,549a <close>
  unlink("junk");
     3ac:	00005517          	auipc	a0,0x5
     3b0:	7a450513          	addi	a0,a0,1956 # 5b50 <malloc+0x206>
     3b4:	10e050ef          	jal	ra,54c2 <unlink>

  exit(0);
     3b8:	4501                	li	a0,0
     3ba:	0b8050ef          	jal	ra,5472 <exit>

00000000000003be <outofinodes>:
  }
}

void
outofinodes(char *s)
{
     3be:	715d                	addi	sp,sp,-80
     3c0:	e486                	sd	ra,72(sp)
     3c2:	e0a2                	sd	s0,64(sp)
     3c4:	fc26                	sd	s1,56(sp)
     3c6:	f84a                	sd	s2,48(sp)
     3c8:	f44e                	sd	s3,40(sp)
     3ca:	0880                	addi	s0,sp,80
  int nzz = 32 * 32;
  for (int i = 0; i < nzz; i++) {
     3cc:	4481                	li	s1,0
    char name[32];
    name[0] = 'z';
     3ce:	07a00913          	li	s2,122
  for (int i = 0; i < nzz; i++) {
     3d2:	40000993          	li	s3,1024
    name[0] = 'z';
     3d6:	fb240823          	sb	s2,-80(s0)
    name[1] = 'z';
     3da:	fb2408a3          	sb	s2,-79(s0)
    name[2] = '0' + (i / 32);
     3de:	41f4d71b          	sraiw	a4,s1,0x1f
     3e2:	01b7571b          	srliw	a4,a4,0x1b
     3e6:	009707bb          	addw	a5,a4,s1
     3ea:	4057d69b          	sraiw	a3,a5,0x5
     3ee:	0306869b          	addiw	a3,a3,48
     3f2:	fad40923          	sb	a3,-78(s0)
    name[3] = '0' + (i % 32);
     3f6:	8bfd                	andi	a5,a5,31
     3f8:	9f99                	subw	a5,a5,a4
     3fa:	0307879b          	addiw	a5,a5,48
     3fe:	faf409a3          	sb	a5,-77(s0)
    name[4] = '\0';
     402:	fa040a23          	sb	zero,-76(s0)
    unlink(name);
     406:	fb040513          	addi	a0,s0,-80
     40a:	0b8050ef          	jal	ra,54c2 <unlink>
    int fd = open(name, O_CREATE | O_RDWR | O_TRUNC);
     40e:	60200593          	li	a1,1538
     412:	fb040513          	addi	a0,s0,-80
     416:	09c050ef          	jal	ra,54b2 <open>
    if (fd < 0) {
     41a:	00054763          	bltz	a0,428 <outofinodes+0x6a>
      // failure is eventually expected.
      break;
    }
    close(fd);
     41e:	07c050ef          	jal	ra,549a <close>
  for (int i = 0; i < nzz; i++) {
     422:	2485                	addiw	s1,s1,1
     424:	fb3499e3          	bne	s1,s3,3d6 <outofinodes+0x18>
     428:	4481                	li	s1,0
  }

  for (int i = 0; i < nzz; i++) {
    char name[32];
    name[0] = 'z';
     42a:	07a00913          	li	s2,122
  for (int i = 0; i < nzz; i++) {
     42e:	40000993          	li	s3,1024
    name[0] = 'z';
     432:	fb240823          	sb	s2,-80(s0)
    name[1] = 'z';
     436:	fb2408a3          	sb	s2,-79(s0)
    name[2] = '0' + (i / 32);
     43a:	41f4d71b          	sraiw	a4,s1,0x1f
     43e:	01b7571b          	srliw	a4,a4,0x1b
     442:	009707bb          	addw	a5,a4,s1
     446:	4057d69b          	sraiw	a3,a5,0x5
     44a:	0306869b          	addiw	a3,a3,48
     44e:	fad40923          	sb	a3,-78(s0)
    name[3] = '0' + (i % 32);
     452:	8bfd                	andi	a5,a5,31
     454:	9f99                	subw	a5,a5,a4
     456:	0307879b          	addiw	a5,a5,48
     45a:	faf409a3          	sb	a5,-77(s0)
    name[4] = '\0';
     45e:	fa040a23          	sb	zero,-76(s0)
    unlink(name);
     462:	fb040513          	addi	a0,s0,-80
     466:	05c050ef          	jal	ra,54c2 <unlink>
  for (int i = 0; i < nzz; i++) {
     46a:	2485                	addiw	s1,s1,1
     46c:	fd3493e3          	bne	s1,s3,432 <outofinodes+0x74>
  }
}
     470:	60a6                	ld	ra,72(sp)
     472:	6406                	ld	s0,64(sp)
     474:	74e2                	ld	s1,56(sp)
     476:	7942                	ld	s2,48(sp)
     478:	79a2                	ld	s3,40(sp)
     47a:	6161                	addi	sp,sp,80
     47c:	8082                	ret

000000000000047e <copyin>:
{
     47e:	7159                	addi	sp,sp,-112
     480:	f486                	sd	ra,104(sp)
     482:	f0a2                	sd	s0,96(sp)
     484:	eca6                	sd	s1,88(sp)
     486:	e8ca                	sd	s2,80(sp)
     488:	e4ce                	sd	s3,72(sp)
     48a:	e0d2                	sd	s4,64(sp)
     48c:	fc56                	sd	s5,56(sp)
     48e:	1880                	addi	s0,sp,112
  uint64 addrs[] = {0x80000000LL, 0x3fffffe000, 0x3ffffff000, 0x4000000000,
     490:	00008797          	auipc	a5,0x8
     494:	ec878793          	addi	a5,a5,-312 # 8358 <malloc+0x2a0e>
     498:	638c                	ld	a1,0(a5)
     49a:	6790                	ld	a2,8(a5)
     49c:	6b94                	ld	a3,16(a5)
     49e:	6f98                	ld	a4,24(a5)
     4a0:	739c                	ld	a5,32(a5)
     4a2:	f8b43c23          	sd	a1,-104(s0)
     4a6:	fac43023          	sd	a2,-96(s0)
     4aa:	fad43423          	sd	a3,-88(s0)
     4ae:	fae43823          	sd	a4,-80(s0)
     4b2:	faf43c23          	sd	a5,-72(s0)
  for (int ai = 0; ai < sizeof(addrs) / sizeof(addrs[0]); ai++) {
     4b6:	f9840913          	addi	s2,s0,-104
     4ba:	fc040a93          	addi	s5,s0,-64
    int fd = open("copyin1", O_CREATE | O_WRONLY);
     4be:	00005a17          	auipc	s4,0x5
     4c2:	6c2a0a13          	addi	s4,s4,1730 # 5b80 <malloc+0x236>
    uint64 addr = addrs[ai];
     4c6:	00093983          	ld	s3,0(s2)
    int fd = open("copyin1", O_CREATE | O_WRONLY);
     4ca:	20100593          	li	a1,513
     4ce:	8552                	mv	a0,s4
     4d0:	7e3040ef          	jal	ra,54b2 <open>
     4d4:	84aa                	mv	s1,a0
    if (fd < 0) {
     4d6:	06054763          	bltz	a0,544 <copyin+0xc6>
    int n = write(fd, (void *)addr, 8192);
     4da:	6609                	lui	a2,0x2
     4dc:	85ce                	mv	a1,s3
     4de:	7b5040ef          	jal	ra,5492 <write>
    if (n >= 0) {
     4e2:	06055a63          	bgez	a0,556 <copyin+0xd8>
    close(fd);
     4e6:	8526                	mv	a0,s1
     4e8:	7b3040ef          	jal	ra,549a <close>
    unlink("copyin1");
     4ec:	8552                	mv	a0,s4
     4ee:	7d5040ef          	jal	ra,54c2 <unlink>
    n = write(1, (char *)addr, 8192);
     4f2:	6609                	lui	a2,0x2
     4f4:	85ce                	mv	a1,s3
     4f6:	4505                	li	a0,1
     4f8:	79b040ef          	jal	ra,5492 <write>
    if (n > 0) {
     4fc:	06a04863          	bgtz	a0,56c <copyin+0xee>
    if (pipe(fds) < 0) {
     500:	f9040513          	addi	a0,s0,-112
     504:	77f040ef          	jal	ra,5482 <pipe>
     508:	06054d63          	bltz	a0,582 <copyin+0x104>
    n = write(fds[1], (char *)addr, 8192);
     50c:	6609                	lui	a2,0x2
     50e:	85ce                	mv	a1,s3
     510:	f9442503          	lw	a0,-108(s0)
     514:	77f040ef          	jal	ra,5492 <write>
    if (n > 0) {
     518:	06a04e63          	bgtz	a0,594 <copyin+0x116>
    close(fds[0]);
     51c:	f9042503          	lw	a0,-112(s0)
     520:	77b040ef          	jal	ra,549a <close>
    close(fds[1]);
     524:	f9442503          	lw	a0,-108(s0)
     528:	773040ef          	jal	ra,549a <close>
  for (int ai = 0; ai < sizeof(addrs) / sizeof(addrs[0]); ai++) {
     52c:	0921                	addi	s2,s2,8
     52e:	f9591ce3          	bne	s2,s5,4c6 <copyin+0x48>
}
     532:	70a6                	ld	ra,104(sp)
     534:	7406                	ld	s0,96(sp)
     536:	64e6                	ld	s1,88(sp)
     538:	6946                	ld	s2,80(sp)
     53a:	69a6                	ld	s3,72(sp)
     53c:	6a06                	ld	s4,64(sp)
     53e:	7ae2                	ld	s5,56(sp)
     540:	6165                	addi	sp,sp,112
     542:	8082                	ret
      printf("open(copyin1) failed\n");
     544:	00005517          	auipc	a0,0x5
     548:	64450513          	addi	a0,a0,1604 # 5b88 <malloc+0x23e>
     54c:	34a050ef          	jal	ra,5896 <printf>
      exit(1);
     550:	4505                	li	a0,1
     552:	721040ef          	jal	ra,5472 <exit>
      printf("write(fd, %p, 8192) returned %d, not -1\n", (void *)addr, n);
     556:	862a                	mv	a2,a0
     558:	85ce                	mv	a1,s3
     55a:	00005517          	auipc	a0,0x5
     55e:	64650513          	addi	a0,a0,1606 # 5ba0 <malloc+0x256>
     562:	334050ef          	jal	ra,5896 <printf>
      exit(1);
     566:	4505                	li	a0,1
     568:	70b040ef          	jal	ra,5472 <exit>
      printf("write(1, %p, 8192) returned %d, not -1 or 0\n", (void *)addr, n);
     56c:	862a                	mv	a2,a0
     56e:	85ce                	mv	a1,s3
     570:	00005517          	auipc	a0,0x5
     574:	66050513          	addi	a0,a0,1632 # 5bd0 <malloc+0x286>
     578:	31e050ef          	jal	ra,5896 <printf>
      exit(1);
     57c:	4505                	li	a0,1
     57e:	6f5040ef          	jal	ra,5472 <exit>
      printf("pipe() failed\n");
     582:	00005517          	auipc	a0,0x5
     586:	67e50513          	addi	a0,a0,1662 # 5c00 <malloc+0x2b6>
     58a:	30c050ef          	jal	ra,5896 <printf>
      exit(1);
     58e:	4505                	li	a0,1
     590:	6e3040ef          	jal	ra,5472 <exit>
      printf("write(pipe, %p, 8192) returned %d, not -1 or 0\n", (void *)addr,
     594:	862a                	mv	a2,a0
     596:	85ce                	mv	a1,s3
     598:	00005517          	auipc	a0,0x5
     59c:	67850513          	addi	a0,a0,1656 # 5c10 <malloc+0x2c6>
     5a0:	2f6050ef          	jal	ra,5896 <printf>
      exit(1);
     5a4:	4505                	li	a0,1
     5a6:	6cd040ef          	jal	ra,5472 <exit>

00000000000005aa <copyout>:
{
     5aa:	7119                	addi	sp,sp,-128
     5ac:	fc86                	sd	ra,120(sp)
     5ae:	f8a2                	sd	s0,112(sp)
     5b0:	f4a6                	sd	s1,104(sp)
     5b2:	f0ca                	sd	s2,96(sp)
     5b4:	ecce                	sd	s3,88(sp)
     5b6:	e8d2                	sd	s4,80(sp)
     5b8:	e4d6                	sd	s5,72(sp)
     5ba:	e0da                	sd	s6,64(sp)
     5bc:	0100                	addi	s0,sp,128
  uint64 addrs[] = {0LL,          0x80000000LL, 0x3fffffe000,
     5be:	00008797          	auipc	a5,0x8
     5c2:	d9a78793          	addi	a5,a5,-614 # 8358 <malloc+0x2a0e>
     5c6:	7788                	ld	a0,40(a5)
     5c8:	7b8c                	ld	a1,48(a5)
     5ca:	7f90                	ld	a2,56(a5)
     5cc:	63b4                	ld	a3,64(a5)
     5ce:	67b8                	ld	a4,72(a5)
     5d0:	6bbc                	ld	a5,80(a5)
     5d2:	f8a43823          	sd	a0,-112(s0)
     5d6:	f8b43c23          	sd	a1,-104(s0)
     5da:	fac43023          	sd	a2,-96(s0)
     5de:	fad43423          	sd	a3,-88(s0)
     5e2:	fae43823          	sd	a4,-80(s0)
     5e6:	faf43c23          	sd	a5,-72(s0)
  for (int ai = 0; ai < sizeof(addrs) / sizeof(addrs[0]); ai++) {
     5ea:	f9040913          	addi	s2,s0,-112
     5ee:	fc040b13          	addi	s6,s0,-64
    int fd = open("README", 0);
     5f2:	00005a17          	auipc	s4,0x5
     5f6:	64ea0a13          	addi	s4,s4,1614 # 5c40 <malloc+0x2f6>
    n = write(fds[1], "x", 1);
     5fa:	00005a97          	auipc	s5,0x5
     5fe:	4dea8a93          	addi	s5,s5,1246 # 5ad8 <malloc+0x18e>
    uint64 addr = addrs[ai];
     602:	00093983          	ld	s3,0(s2)
    int fd = open("README", 0);
     606:	4581                	li	a1,0
     608:	8552                	mv	a0,s4
     60a:	6a9040ef          	jal	ra,54b2 <open>
     60e:	84aa                	mv	s1,a0
    if (fd < 0) {
     610:	06054763          	bltz	a0,67e <copyout+0xd4>
    int n = read(fd, (void *)addr, 8192);
     614:	6609                	lui	a2,0x2
     616:	85ce                	mv	a1,s3
     618:	673040ef          	jal	ra,548a <read>
    if (n > 0) {
     61c:	06a04a63          	bgtz	a0,690 <copyout+0xe6>
    close(fd);
     620:	8526                	mv	a0,s1
     622:	679040ef          	jal	ra,549a <close>
    if (pipe(fds) < 0) {
     626:	f8840513          	addi	a0,s0,-120
     62a:	659040ef          	jal	ra,5482 <pipe>
     62e:	06054c63          	bltz	a0,6a6 <copyout+0xfc>
    n = write(fds[1], "x", 1);
     632:	4605                	li	a2,1
     634:	85d6                	mv	a1,s5
     636:	f8c42503          	lw	a0,-116(s0)
     63a:	659040ef          	jal	ra,5492 <write>
    if (n != 1) {
     63e:	4785                	li	a5,1
     640:	06f51c63          	bne	a0,a5,6b8 <copyout+0x10e>
    n = read(fds[0], (void *)addr, 8192);
     644:	6609                	lui	a2,0x2
     646:	85ce                	mv	a1,s3
     648:	f8842503          	lw	a0,-120(s0)
     64c:	63f040ef          	jal	ra,548a <read>
    if (n > 0) {
     650:	06a04d63          	bgtz	a0,6ca <copyout+0x120>
    close(fds[0]);
     654:	f8842503          	lw	a0,-120(s0)
     658:	643040ef          	jal	ra,549a <close>
    close(fds[1]);
     65c:	f8c42503          	lw	a0,-116(s0)
     660:	63b040ef          	jal	ra,549a <close>
  for (int ai = 0; ai < sizeof(addrs) / sizeof(addrs[0]); ai++) {
     664:	0921                	addi	s2,s2,8
     666:	f9691ee3          	bne	s2,s6,602 <copyout+0x58>
}
     66a:	70e6                	ld	ra,120(sp)
     66c:	7446                	ld	s0,112(sp)
     66e:	74a6                	ld	s1,104(sp)
     670:	7906                	ld	s2,96(sp)
     672:	69e6                	ld	s3,88(sp)
     674:	6a46                	ld	s4,80(sp)
     676:	6aa6                	ld	s5,72(sp)
     678:	6b06                	ld	s6,64(sp)
     67a:	6109                	addi	sp,sp,128
     67c:	8082                	ret
      printf("open(README) failed\n");
     67e:	00005517          	auipc	a0,0x5
     682:	5ca50513          	addi	a0,a0,1482 # 5c48 <malloc+0x2fe>
     686:	210050ef          	jal	ra,5896 <printf>
      exit(1);
     68a:	4505                	li	a0,1
     68c:	5e7040ef          	jal	ra,5472 <exit>
      printf("read(fd, %p, 8192) returned %d, not -1 or 0\n", (void *)addr, n);
     690:	862a                	mv	a2,a0
     692:	85ce                	mv	a1,s3
     694:	00005517          	auipc	a0,0x5
     698:	5cc50513          	addi	a0,a0,1484 # 5c60 <malloc+0x316>
     69c:	1fa050ef          	jal	ra,5896 <printf>
      exit(1);
     6a0:	4505                	li	a0,1
     6a2:	5d1040ef          	jal	ra,5472 <exit>
      printf("pipe() failed\n");
     6a6:	00005517          	auipc	a0,0x5
     6aa:	55a50513          	addi	a0,a0,1370 # 5c00 <malloc+0x2b6>
     6ae:	1e8050ef          	jal	ra,5896 <printf>
      exit(1);
     6b2:	4505                	li	a0,1
     6b4:	5bf040ef          	jal	ra,5472 <exit>
      printf("pipe write failed\n");
     6b8:	00005517          	auipc	a0,0x5
     6bc:	5d850513          	addi	a0,a0,1496 # 5c90 <malloc+0x346>
     6c0:	1d6050ef          	jal	ra,5896 <printf>
      exit(1);
     6c4:	4505                	li	a0,1
     6c6:	5ad040ef          	jal	ra,5472 <exit>
      printf("read(pipe, %p, 8192) returned %d, not -1 or 0\n", (void *)addr,
     6ca:	862a                	mv	a2,a0
     6cc:	85ce                	mv	a1,s3
     6ce:	00005517          	auipc	a0,0x5
     6d2:	5da50513          	addi	a0,a0,1498 # 5ca8 <malloc+0x35e>
     6d6:	1c0050ef          	jal	ra,5896 <printf>
      exit(1);
     6da:	4505                	li	a0,1
     6dc:	597040ef          	jal	ra,5472 <exit>

00000000000006e0 <truncate1>:
{
     6e0:	711d                	addi	sp,sp,-96
     6e2:	ec86                	sd	ra,88(sp)
     6e4:	e8a2                	sd	s0,80(sp)
     6e6:	e4a6                	sd	s1,72(sp)
     6e8:	e0ca                	sd	s2,64(sp)
     6ea:	fc4e                	sd	s3,56(sp)
     6ec:	f852                	sd	s4,48(sp)
     6ee:	f456                	sd	s5,40(sp)
     6f0:	1080                	addi	s0,sp,96
     6f2:	8aaa                	mv	s5,a0
  unlink("truncfile");
     6f4:	00005517          	auipc	a0,0x5
     6f8:	3cc50513          	addi	a0,a0,972 # 5ac0 <malloc+0x176>
     6fc:	5c7040ef          	jal	ra,54c2 <unlink>
  int fd1 = open("truncfile", O_CREATE | O_WRONLY | O_TRUNC);
     700:	60100593          	li	a1,1537
     704:	00005517          	auipc	a0,0x5
     708:	3bc50513          	addi	a0,a0,956 # 5ac0 <malloc+0x176>
     70c:	5a7040ef          	jal	ra,54b2 <open>
     710:	84aa                	mv	s1,a0
  write(fd1, "abcd", 4);
     712:	4611                	li	a2,4
     714:	00005597          	auipc	a1,0x5
     718:	3bc58593          	addi	a1,a1,956 # 5ad0 <malloc+0x186>
     71c:	577040ef          	jal	ra,5492 <write>
  close(fd1);
     720:	8526                	mv	a0,s1
     722:	579040ef          	jal	ra,549a <close>
  int fd2 = open("truncfile", O_RDONLY);
     726:	4581                	li	a1,0
     728:	00005517          	auipc	a0,0x5
     72c:	39850513          	addi	a0,a0,920 # 5ac0 <malloc+0x176>
     730:	583040ef          	jal	ra,54b2 <open>
     734:	84aa                	mv	s1,a0
  int n = read(fd2, buf, sizeof(buf));
     736:	02000613          	li	a2,32
     73a:	fa040593          	addi	a1,s0,-96
     73e:	54d040ef          	jal	ra,548a <read>
  if (n != 4) {
     742:	4791                	li	a5,4
     744:	0af51863          	bne	a0,a5,7f4 <truncate1+0x114>
  fd1 = open("truncfile", O_WRONLY | O_TRUNC);
     748:	40100593          	li	a1,1025
     74c:	00005517          	auipc	a0,0x5
     750:	37450513          	addi	a0,a0,884 # 5ac0 <malloc+0x176>
     754:	55f040ef          	jal	ra,54b2 <open>
     758:	89aa                	mv	s3,a0
  int fd3 = open("truncfile", O_RDONLY);
     75a:	4581                	li	a1,0
     75c:	00005517          	auipc	a0,0x5
     760:	36450513          	addi	a0,a0,868 # 5ac0 <malloc+0x176>
     764:	54f040ef          	jal	ra,54b2 <open>
     768:	892a                	mv	s2,a0
  n = read(fd3, buf, sizeof(buf));
     76a:	02000613          	li	a2,32
     76e:	fa040593          	addi	a1,s0,-96
     772:	519040ef          	jal	ra,548a <read>
     776:	8a2a                	mv	s4,a0
  if (n != 0) {
     778:	e949                	bnez	a0,80a <truncate1+0x12a>
  n = read(fd2, buf, sizeof(buf));
     77a:	02000613          	li	a2,32
     77e:	fa040593          	addi	a1,s0,-96
     782:	8526                	mv	a0,s1
     784:	507040ef          	jal	ra,548a <read>
     788:	8a2a                	mv	s4,a0
  if (n != 0) {
     78a:	e155                	bnez	a0,82e <truncate1+0x14e>
  write(fd1, "abcdef", 6);
     78c:	4619                	li	a2,6
     78e:	00005597          	auipc	a1,0x5
     792:	5aa58593          	addi	a1,a1,1450 # 5d38 <malloc+0x3ee>
     796:	854e                	mv	a0,s3
     798:	4fb040ef          	jal	ra,5492 <write>
  n = read(fd3, buf, sizeof(buf));
     79c:	02000613          	li	a2,32
     7a0:	fa040593          	addi	a1,s0,-96
     7a4:	854a                	mv	a0,s2
     7a6:	4e5040ef          	jal	ra,548a <read>
  if (n != 6) {
     7aa:	4799                	li	a5,6
     7ac:	0af51363          	bne	a0,a5,852 <truncate1+0x172>
  n = read(fd2, buf, sizeof(buf));
     7b0:	02000613          	li	a2,32
     7b4:	fa040593          	addi	a1,s0,-96
     7b8:	8526                	mv	a0,s1
     7ba:	4d1040ef          	jal	ra,548a <read>
  if (n != 2) {
     7be:	4789                	li	a5,2
     7c0:	0af51463          	bne	a0,a5,868 <truncate1+0x188>
  unlink("truncfile");
     7c4:	00005517          	auipc	a0,0x5
     7c8:	2fc50513          	addi	a0,a0,764 # 5ac0 <malloc+0x176>
     7cc:	4f7040ef          	jal	ra,54c2 <unlink>
  close(fd1);
     7d0:	854e                	mv	a0,s3
     7d2:	4c9040ef          	jal	ra,549a <close>
  close(fd2);
     7d6:	8526                	mv	a0,s1
     7d8:	4c3040ef          	jal	ra,549a <close>
  close(fd3);
     7dc:	854a                	mv	a0,s2
     7de:	4bd040ef          	jal	ra,549a <close>
}
     7e2:	60e6                	ld	ra,88(sp)
     7e4:	6446                	ld	s0,80(sp)
     7e6:	64a6                	ld	s1,72(sp)
     7e8:	6906                	ld	s2,64(sp)
     7ea:	79e2                	ld	s3,56(sp)
     7ec:	7a42                	ld	s4,48(sp)
     7ee:	7aa2                	ld	s5,40(sp)
     7f0:	6125                	addi	sp,sp,96
     7f2:	8082                	ret
    printf("%s: read %d bytes, wanted 4\n", s, n);
     7f4:	862a                	mv	a2,a0
     7f6:	85d6                	mv	a1,s5
     7f8:	00005517          	auipc	a0,0x5
     7fc:	4e050513          	addi	a0,a0,1248 # 5cd8 <malloc+0x38e>
     800:	096050ef          	jal	ra,5896 <printf>
    exit(1);
     804:	4505                	li	a0,1
     806:	46d040ef          	jal	ra,5472 <exit>
    printf("aaa fd3=%d\n", fd3);
     80a:	85ca                	mv	a1,s2
     80c:	00005517          	auipc	a0,0x5
     810:	4ec50513          	addi	a0,a0,1260 # 5cf8 <malloc+0x3ae>
     814:	082050ef          	jal	ra,5896 <printf>
    printf("%s: read %d bytes, wanted 0\n", s, n);
     818:	8652                	mv	a2,s4
     81a:	85d6                	mv	a1,s5
     81c:	00005517          	auipc	a0,0x5
     820:	4ec50513          	addi	a0,a0,1260 # 5d08 <malloc+0x3be>
     824:	072050ef          	jal	ra,5896 <printf>
    exit(1);
     828:	4505                	li	a0,1
     82a:	449040ef          	jal	ra,5472 <exit>
    printf("bbb fd2=%d\n", fd2);
     82e:	85a6                	mv	a1,s1
     830:	00005517          	auipc	a0,0x5
     834:	4f850513          	addi	a0,a0,1272 # 5d28 <malloc+0x3de>
     838:	05e050ef          	jal	ra,5896 <printf>
    printf("%s: read %d bytes, wanted 0\n", s, n);
     83c:	8652                	mv	a2,s4
     83e:	85d6                	mv	a1,s5
     840:	00005517          	auipc	a0,0x5
     844:	4c850513          	addi	a0,a0,1224 # 5d08 <malloc+0x3be>
     848:	04e050ef          	jal	ra,5896 <printf>
    exit(1);
     84c:	4505                	li	a0,1
     84e:	425040ef          	jal	ra,5472 <exit>
    printf("%s: read %d bytes, wanted 6\n", s, n);
     852:	862a                	mv	a2,a0
     854:	85d6                	mv	a1,s5
     856:	00005517          	auipc	a0,0x5
     85a:	4ea50513          	addi	a0,a0,1258 # 5d40 <malloc+0x3f6>
     85e:	038050ef          	jal	ra,5896 <printf>
    exit(1);
     862:	4505                	li	a0,1
     864:	40f040ef          	jal	ra,5472 <exit>
    printf("%s: read %d bytes, wanted 2\n", s, n);
     868:	862a                	mv	a2,a0
     86a:	85d6                	mv	a1,s5
     86c:	00005517          	auipc	a0,0x5
     870:	4f450513          	addi	a0,a0,1268 # 5d60 <malloc+0x416>
     874:	022050ef          	jal	ra,5896 <printf>
    exit(1);
     878:	4505                	li	a0,1
     87a:	3f9040ef          	jal	ra,5472 <exit>

000000000000087e <writetest>:
{
     87e:	7139                	addi	sp,sp,-64
     880:	fc06                	sd	ra,56(sp)
     882:	f822                	sd	s0,48(sp)
     884:	f426                	sd	s1,40(sp)
     886:	f04a                	sd	s2,32(sp)
     888:	ec4e                	sd	s3,24(sp)
     88a:	e852                	sd	s4,16(sp)
     88c:	e456                	sd	s5,8(sp)
     88e:	e05a                	sd	s6,0(sp)
     890:	0080                	addi	s0,sp,64
     892:	8b2a                	mv	s6,a0
  fd = open("small", O_CREATE | O_RDWR);
     894:	20200593          	li	a1,514
     898:	00005517          	auipc	a0,0x5
     89c:	4e850513          	addi	a0,a0,1256 # 5d80 <malloc+0x436>
     8a0:	413040ef          	jal	ra,54b2 <open>
  if (fd < 0) {
     8a4:	08054f63          	bltz	a0,942 <writetest+0xc4>
     8a8:	892a                	mv	s2,a0
     8aa:	4481                	li	s1,0
    if (write(fd, "aaaaaaaaaa", SZ) != SZ) {
     8ac:	00005997          	auipc	s3,0x5
     8b0:	4fc98993          	addi	s3,s3,1276 # 5da8 <malloc+0x45e>
    if (write(fd, "bbbbbbbbbb", SZ) != SZ) {
     8b4:	00005a97          	auipc	s5,0x5
     8b8:	52ca8a93          	addi	s5,s5,1324 # 5de0 <malloc+0x496>
  for (i = 0; i < N; i++) {
     8bc:	06400a13          	li	s4,100
    if (write(fd, "aaaaaaaaaa", SZ) != SZ) {
     8c0:	4629                	li	a2,10
     8c2:	85ce                	mv	a1,s3
     8c4:	854a                	mv	a0,s2
     8c6:	3cd040ef          	jal	ra,5492 <write>
     8ca:	47a9                	li	a5,10
     8cc:	08f51563          	bne	a0,a5,956 <writetest+0xd8>
    if (write(fd, "bbbbbbbbbb", SZ) != SZ) {
     8d0:	4629                	li	a2,10
     8d2:	85d6                	mv	a1,s5
     8d4:	854a                	mv	a0,s2
     8d6:	3bd040ef          	jal	ra,5492 <write>
     8da:	47a9                	li	a5,10
     8dc:	08f51863          	bne	a0,a5,96c <writetest+0xee>
  for (i = 0; i < N; i++) {
     8e0:	2485                	addiw	s1,s1,1
     8e2:	fd449fe3          	bne	s1,s4,8c0 <writetest+0x42>
  close(fd);
     8e6:	854a                	mv	a0,s2
     8e8:	3b3040ef          	jal	ra,549a <close>
  fd = open("small", O_RDONLY);
     8ec:	4581                	li	a1,0
     8ee:	00005517          	auipc	a0,0x5
     8f2:	49250513          	addi	a0,a0,1170 # 5d80 <malloc+0x436>
     8f6:	3bd040ef          	jal	ra,54b2 <open>
     8fa:	84aa                	mv	s1,a0
  if (fd < 0) {
     8fc:	08054363          	bltz	a0,982 <writetest+0x104>
  i = read(fd, buf, N * SZ * 2);
     900:	7d000613          	li	a2,2000
     904:	0000c597          	auipc	a1,0xc
     908:	3f458593          	addi	a1,a1,1012 # ccf8 <buf>
     90c:	37f040ef          	jal	ra,548a <read>
  if (i != N * SZ * 2) {
     910:	7d000793          	li	a5,2000
     914:	08f51163          	bne	a0,a5,996 <writetest+0x118>
  close(fd);
     918:	8526                	mv	a0,s1
     91a:	381040ef          	jal	ra,549a <close>
  if (unlink("small") < 0) {
     91e:	00005517          	auipc	a0,0x5
     922:	46250513          	addi	a0,a0,1122 # 5d80 <malloc+0x436>
     926:	39d040ef          	jal	ra,54c2 <unlink>
     92a:	08054063          	bltz	a0,9aa <writetest+0x12c>
}
     92e:	70e2                	ld	ra,56(sp)
     930:	7442                	ld	s0,48(sp)
     932:	74a2                	ld	s1,40(sp)
     934:	7902                	ld	s2,32(sp)
     936:	69e2                	ld	s3,24(sp)
     938:	6a42                	ld	s4,16(sp)
     93a:	6aa2                	ld	s5,8(sp)
     93c:	6b02                	ld	s6,0(sp)
     93e:	6121                	addi	sp,sp,64
     940:	8082                	ret
    printf("%s: error: creat small failed!\n", s);
     942:	85da                	mv	a1,s6
     944:	00005517          	auipc	a0,0x5
     948:	44450513          	addi	a0,a0,1092 # 5d88 <malloc+0x43e>
     94c:	74b040ef          	jal	ra,5896 <printf>
    exit(1);
     950:	4505                	li	a0,1
     952:	321040ef          	jal	ra,5472 <exit>
      printf("%s: error: write aa %d new file failed\n", s, i);
     956:	8626                	mv	a2,s1
     958:	85da                	mv	a1,s6
     95a:	00005517          	auipc	a0,0x5
     95e:	45e50513          	addi	a0,a0,1118 # 5db8 <malloc+0x46e>
     962:	735040ef          	jal	ra,5896 <printf>
      exit(1);
     966:	4505                	li	a0,1
     968:	30b040ef          	jal	ra,5472 <exit>
      printf("%s: error: write bb %d new file failed\n", s, i);
     96c:	8626                	mv	a2,s1
     96e:	85da                	mv	a1,s6
     970:	00005517          	auipc	a0,0x5
     974:	48050513          	addi	a0,a0,1152 # 5df0 <malloc+0x4a6>
     978:	71f040ef          	jal	ra,5896 <printf>
      exit(1);
     97c:	4505                	li	a0,1
     97e:	2f5040ef          	jal	ra,5472 <exit>
    printf("%s: error: open small failed!\n", s);
     982:	85da                	mv	a1,s6
     984:	00005517          	auipc	a0,0x5
     988:	49450513          	addi	a0,a0,1172 # 5e18 <malloc+0x4ce>
     98c:	70b040ef          	jal	ra,5896 <printf>
    exit(1);
     990:	4505                	li	a0,1
     992:	2e1040ef          	jal	ra,5472 <exit>
    printf("%s: read failed\n", s);
     996:	85da                	mv	a1,s6
     998:	00005517          	auipc	a0,0x5
     99c:	4a050513          	addi	a0,a0,1184 # 5e38 <malloc+0x4ee>
     9a0:	6f7040ef          	jal	ra,5896 <printf>
    exit(1);
     9a4:	4505                	li	a0,1
     9a6:	2cd040ef          	jal	ra,5472 <exit>
    printf("%s: unlink small failed\n", s);
     9aa:	85da                	mv	a1,s6
     9ac:	00005517          	auipc	a0,0x5
     9b0:	4a450513          	addi	a0,a0,1188 # 5e50 <malloc+0x506>
     9b4:	6e3040ef          	jal	ra,5896 <printf>
    exit(1);
     9b8:	4505                	li	a0,1
     9ba:	2b9040ef          	jal	ra,5472 <exit>

00000000000009be <writebig>:
{
     9be:	7139                	addi	sp,sp,-64
     9c0:	fc06                	sd	ra,56(sp)
     9c2:	f822                	sd	s0,48(sp)
     9c4:	f426                	sd	s1,40(sp)
     9c6:	f04a                	sd	s2,32(sp)
     9c8:	ec4e                	sd	s3,24(sp)
     9ca:	e852                	sd	s4,16(sp)
     9cc:	e456                	sd	s5,8(sp)
     9ce:	0080                	addi	s0,sp,64
     9d0:	8aaa                	mv	s5,a0
  fd = open("big", O_CREATE | O_RDWR);
     9d2:	20200593          	li	a1,514
     9d6:	00005517          	auipc	a0,0x5
     9da:	49a50513          	addi	a0,a0,1178 # 5e70 <malloc+0x526>
     9de:	2d5040ef          	jal	ra,54b2 <open>
     9e2:	89aa                	mv	s3,a0
  for (i = 0; i < MAXFILE; i++) {
     9e4:	4481                	li	s1,0
    ((int *)buf)[0] = i;
     9e6:	0000c917          	auipc	s2,0xc
     9ea:	31290913          	addi	s2,s2,786 # ccf8 <buf>
  for (i = 0; i < MAXFILE; i++) {
     9ee:	10c00a13          	li	s4,268
  if (fd < 0) {
     9f2:	06054463          	bltz	a0,a5a <writebig+0x9c>
    ((int *)buf)[0] = i;
     9f6:	00992023          	sw	s1,0(s2)
    if (write(fd, buf, BSIZE) != BSIZE) {
     9fa:	40000613          	li	a2,1024
     9fe:	85ca                	mv	a1,s2
     a00:	854e                	mv	a0,s3
     a02:	291040ef          	jal	ra,5492 <write>
     a06:	40000793          	li	a5,1024
     a0a:	06f51263          	bne	a0,a5,a6e <writebig+0xb0>
  for (i = 0; i < MAXFILE; i++) {
     a0e:	2485                	addiw	s1,s1,1
     a10:	ff4493e3          	bne	s1,s4,9f6 <writebig+0x38>
  close(fd);
     a14:	854e                	mv	a0,s3
     a16:	285040ef          	jal	ra,549a <close>
  fd = open("big", O_RDONLY);
     a1a:	4581                	li	a1,0
     a1c:	00005517          	auipc	a0,0x5
     a20:	45450513          	addi	a0,a0,1108 # 5e70 <malloc+0x526>
     a24:	28f040ef          	jal	ra,54b2 <open>
     a28:	89aa                	mv	s3,a0
  n = 0;
     a2a:	4481                	li	s1,0
    i = read(fd, buf, BSIZE);
     a2c:	0000c917          	auipc	s2,0xc
     a30:	2cc90913          	addi	s2,s2,716 # ccf8 <buf>
  if (fd < 0) {
     a34:	04054863          	bltz	a0,a84 <writebig+0xc6>
    i = read(fd, buf, BSIZE);
     a38:	40000613          	li	a2,1024
     a3c:	85ca                	mv	a1,s2
     a3e:	854e                	mv	a0,s3
     a40:	24b040ef          	jal	ra,548a <read>
    if (i == 0) {
     a44:	c931                	beqz	a0,a98 <writebig+0xda>
    } else if (i != BSIZE) {
     a46:	40000793          	li	a5,1024
     a4a:	08f51a63          	bne	a0,a5,ade <writebig+0x120>
    if (((int *)buf)[0] != n) {
     a4e:	00092683          	lw	a3,0(s2)
     a52:	0a969163          	bne	a3,s1,af4 <writebig+0x136>
    n++;
     a56:	2485                	addiw	s1,s1,1
    i = read(fd, buf, BSIZE);
     a58:	b7c5                	j	a38 <writebig+0x7a>
    printf("%s: error: creat big failed!\n", s);
     a5a:	85d6                	mv	a1,s5
     a5c:	00005517          	auipc	a0,0x5
     a60:	41c50513          	addi	a0,a0,1052 # 5e78 <malloc+0x52e>
     a64:	633040ef          	jal	ra,5896 <printf>
    exit(1);
     a68:	4505                	li	a0,1
     a6a:	209040ef          	jal	ra,5472 <exit>
      printf("%s: error: write big file failed i=%d\n", s, i);
     a6e:	8626                	mv	a2,s1
     a70:	85d6                	mv	a1,s5
     a72:	00005517          	auipc	a0,0x5
     a76:	42650513          	addi	a0,a0,1062 # 5e98 <malloc+0x54e>
     a7a:	61d040ef          	jal	ra,5896 <printf>
      exit(1);
     a7e:	4505                	li	a0,1
     a80:	1f3040ef          	jal	ra,5472 <exit>
    printf("%s: error: open big failed!\n", s);
     a84:	85d6                	mv	a1,s5
     a86:	00005517          	auipc	a0,0x5
     a8a:	43a50513          	addi	a0,a0,1082 # 5ec0 <malloc+0x576>
     a8e:	609040ef          	jal	ra,5896 <printf>
    exit(1);
     a92:	4505                	li	a0,1
     a94:	1df040ef          	jal	ra,5472 <exit>
      if (n != MAXFILE) {
     a98:	10c00793          	li	a5,268
     a9c:	02f49663          	bne	s1,a5,ac8 <writebig+0x10a>
  close(fd);
     aa0:	854e                	mv	a0,s3
     aa2:	1f9040ef          	jal	ra,549a <close>
  if (unlink("big") < 0) {
     aa6:	00005517          	auipc	a0,0x5
     aaa:	3ca50513          	addi	a0,a0,970 # 5e70 <malloc+0x526>
     aae:	215040ef          	jal	ra,54c2 <unlink>
     ab2:	04054c63          	bltz	a0,b0a <writebig+0x14c>
}
     ab6:	70e2                	ld	ra,56(sp)
     ab8:	7442                	ld	s0,48(sp)
     aba:	74a2                	ld	s1,40(sp)
     abc:	7902                	ld	s2,32(sp)
     abe:	69e2                	ld	s3,24(sp)
     ac0:	6a42                	ld	s4,16(sp)
     ac2:	6aa2                	ld	s5,8(sp)
     ac4:	6121                	addi	sp,sp,64
     ac6:	8082                	ret
        printf("%s: read only %d blocks from big", s, n);
     ac8:	8626                	mv	a2,s1
     aca:	85d6                	mv	a1,s5
     acc:	00005517          	auipc	a0,0x5
     ad0:	41450513          	addi	a0,a0,1044 # 5ee0 <malloc+0x596>
     ad4:	5c3040ef          	jal	ra,5896 <printf>
        exit(1);
     ad8:	4505                	li	a0,1
     ada:	199040ef          	jal	ra,5472 <exit>
      printf("%s: read failed %d\n", s, i);
     ade:	862a                	mv	a2,a0
     ae0:	85d6                	mv	a1,s5
     ae2:	00005517          	auipc	a0,0x5
     ae6:	42650513          	addi	a0,a0,1062 # 5f08 <malloc+0x5be>
     aea:	5ad040ef          	jal	ra,5896 <printf>
      exit(1);
     aee:	4505                	li	a0,1
     af0:	183040ef          	jal	ra,5472 <exit>
      printf("%s: read content of block %d is %d\n", s, n, ((int *)buf)[0]);
     af4:	8626                	mv	a2,s1
     af6:	85d6                	mv	a1,s5
     af8:	00005517          	auipc	a0,0x5
     afc:	42850513          	addi	a0,a0,1064 # 5f20 <malloc+0x5d6>
     b00:	597040ef          	jal	ra,5896 <printf>
      exit(1);
     b04:	4505                	li	a0,1
     b06:	16d040ef          	jal	ra,5472 <exit>
    printf("%s: unlink big failed\n", s);
     b0a:	85d6                	mv	a1,s5
     b0c:	00005517          	auipc	a0,0x5
     b10:	43c50513          	addi	a0,a0,1084 # 5f48 <malloc+0x5fe>
     b14:	583040ef          	jal	ra,5896 <printf>
    exit(1);
     b18:	4505                	li	a0,1
     b1a:	159040ef          	jal	ra,5472 <exit>

0000000000000b1e <unlinkread>:
{
     b1e:	7179                	addi	sp,sp,-48
     b20:	f406                	sd	ra,40(sp)
     b22:	f022                	sd	s0,32(sp)
     b24:	ec26                	sd	s1,24(sp)
     b26:	e84a                	sd	s2,16(sp)
     b28:	e44e                	sd	s3,8(sp)
     b2a:	1800                	addi	s0,sp,48
     b2c:	89aa                	mv	s3,a0
  fd = open("unlinkread", O_CREATE | O_RDWR);
     b2e:	20200593          	li	a1,514
     b32:	00005517          	auipc	a0,0x5
     b36:	42e50513          	addi	a0,a0,1070 # 5f60 <malloc+0x616>
     b3a:	179040ef          	jal	ra,54b2 <open>
  if (fd < 0) {
     b3e:	0a054f63          	bltz	a0,bfc <unlinkread+0xde>
     b42:	84aa                	mv	s1,a0
  write(fd, "hello", SZ);
     b44:	4615                	li	a2,5
     b46:	00005597          	auipc	a1,0x5
     b4a:	44a58593          	addi	a1,a1,1098 # 5f90 <malloc+0x646>
     b4e:	145040ef          	jal	ra,5492 <write>
  close(fd);
     b52:	8526                	mv	a0,s1
     b54:	147040ef          	jal	ra,549a <close>
  fd = open("unlinkread", O_RDWR);
     b58:	4589                	li	a1,2
     b5a:	00005517          	auipc	a0,0x5
     b5e:	40650513          	addi	a0,a0,1030 # 5f60 <malloc+0x616>
     b62:	151040ef          	jal	ra,54b2 <open>
     b66:	84aa                	mv	s1,a0
  if (fd < 0) {
     b68:	0a054463          	bltz	a0,c10 <unlinkread+0xf2>
  if (unlink("unlinkread") != 0) {
     b6c:	00005517          	auipc	a0,0x5
     b70:	3f450513          	addi	a0,a0,1012 # 5f60 <malloc+0x616>
     b74:	14f040ef          	jal	ra,54c2 <unlink>
     b78:	e555                	bnez	a0,c24 <unlinkread+0x106>
  fd1 = open("unlinkread", O_CREATE | O_RDWR);
     b7a:	20200593          	li	a1,514
     b7e:	00005517          	auipc	a0,0x5
     b82:	3e250513          	addi	a0,a0,994 # 5f60 <malloc+0x616>
     b86:	12d040ef          	jal	ra,54b2 <open>
     b8a:	892a                	mv	s2,a0
  write(fd1, "yyy", 3);
     b8c:	460d                	li	a2,3
     b8e:	00005597          	auipc	a1,0x5
     b92:	44a58593          	addi	a1,a1,1098 # 5fd8 <malloc+0x68e>
     b96:	0fd040ef          	jal	ra,5492 <write>
  close(fd1);
     b9a:	854a                	mv	a0,s2
     b9c:	0ff040ef          	jal	ra,549a <close>
  if (read(fd, buf, sizeof(buf)) != SZ) {
     ba0:	660d                	lui	a2,0x3
     ba2:	0000c597          	auipc	a1,0xc
     ba6:	15658593          	addi	a1,a1,342 # ccf8 <buf>
     baa:	8526                	mv	a0,s1
     bac:	0df040ef          	jal	ra,548a <read>
     bb0:	4795                	li	a5,5
     bb2:	08f51363          	bne	a0,a5,c38 <unlinkread+0x11a>
  if (buf[0] != 'h') {
     bb6:	0000c717          	auipc	a4,0xc
     bba:	14274703          	lbu	a4,322(a4) # ccf8 <buf>
     bbe:	06800793          	li	a5,104
     bc2:	08f71563          	bne	a4,a5,c4c <unlinkread+0x12e>
  if (write(fd, buf, 10) != 10) {
     bc6:	4629                	li	a2,10
     bc8:	0000c597          	auipc	a1,0xc
     bcc:	13058593          	addi	a1,a1,304 # ccf8 <buf>
     bd0:	8526                	mv	a0,s1
     bd2:	0c1040ef          	jal	ra,5492 <write>
     bd6:	47a9                	li	a5,10
     bd8:	08f51463          	bne	a0,a5,c60 <unlinkread+0x142>
  close(fd);
     bdc:	8526                	mv	a0,s1
     bde:	0bd040ef          	jal	ra,549a <close>
  unlink("unlinkread");
     be2:	00005517          	auipc	a0,0x5
     be6:	37e50513          	addi	a0,a0,894 # 5f60 <malloc+0x616>
     bea:	0d9040ef          	jal	ra,54c2 <unlink>
}
     bee:	70a2                	ld	ra,40(sp)
     bf0:	7402                	ld	s0,32(sp)
     bf2:	64e2                	ld	s1,24(sp)
     bf4:	6942                	ld	s2,16(sp)
     bf6:	69a2                	ld	s3,8(sp)
     bf8:	6145                	addi	sp,sp,48
     bfa:	8082                	ret
    printf("%s: create unlinkread failed\n", s);
     bfc:	85ce                	mv	a1,s3
     bfe:	00005517          	auipc	a0,0x5
     c02:	37250513          	addi	a0,a0,882 # 5f70 <malloc+0x626>
     c06:	491040ef          	jal	ra,5896 <printf>
    exit(1);
     c0a:	4505                	li	a0,1
     c0c:	067040ef          	jal	ra,5472 <exit>
    printf("%s: open unlinkread failed\n", s);
     c10:	85ce                	mv	a1,s3
     c12:	00005517          	auipc	a0,0x5
     c16:	38650513          	addi	a0,a0,902 # 5f98 <malloc+0x64e>
     c1a:	47d040ef          	jal	ra,5896 <printf>
    exit(1);
     c1e:	4505                	li	a0,1
     c20:	053040ef          	jal	ra,5472 <exit>
    printf("%s: unlink unlinkread failed\n", s);
     c24:	85ce                	mv	a1,s3
     c26:	00005517          	auipc	a0,0x5
     c2a:	39250513          	addi	a0,a0,914 # 5fb8 <malloc+0x66e>
     c2e:	469040ef          	jal	ra,5896 <printf>
    exit(1);
     c32:	4505                	li	a0,1
     c34:	03f040ef          	jal	ra,5472 <exit>
    printf("%s: unlinkread read failed", s);
     c38:	85ce                	mv	a1,s3
     c3a:	00005517          	auipc	a0,0x5
     c3e:	3a650513          	addi	a0,a0,934 # 5fe0 <malloc+0x696>
     c42:	455040ef          	jal	ra,5896 <printf>
    exit(1);
     c46:	4505                	li	a0,1
     c48:	02b040ef          	jal	ra,5472 <exit>
    printf("%s: unlinkread wrong data\n", s);
     c4c:	85ce                	mv	a1,s3
     c4e:	00005517          	auipc	a0,0x5
     c52:	3b250513          	addi	a0,a0,946 # 6000 <malloc+0x6b6>
     c56:	441040ef          	jal	ra,5896 <printf>
    exit(1);
     c5a:	4505                	li	a0,1
     c5c:	017040ef          	jal	ra,5472 <exit>
    printf("%s: unlinkread write failed\n", s);
     c60:	85ce                	mv	a1,s3
     c62:	00005517          	auipc	a0,0x5
     c66:	3be50513          	addi	a0,a0,958 # 6020 <malloc+0x6d6>
     c6a:	42d040ef          	jal	ra,5896 <printf>
    exit(1);
     c6e:	4505                	li	a0,1
     c70:	003040ef          	jal	ra,5472 <exit>

0000000000000c74 <linktest>:
{
     c74:	1101                	addi	sp,sp,-32
     c76:	ec06                	sd	ra,24(sp)
     c78:	e822                	sd	s0,16(sp)
     c7a:	e426                	sd	s1,8(sp)
     c7c:	e04a                	sd	s2,0(sp)
     c7e:	1000                	addi	s0,sp,32
     c80:	892a                	mv	s2,a0
  unlink("lf1");
     c82:	00005517          	auipc	a0,0x5
     c86:	3be50513          	addi	a0,a0,958 # 6040 <malloc+0x6f6>
     c8a:	039040ef          	jal	ra,54c2 <unlink>
  unlink("lf2");
     c8e:	00005517          	auipc	a0,0x5
     c92:	3ba50513          	addi	a0,a0,954 # 6048 <malloc+0x6fe>
     c96:	02d040ef          	jal	ra,54c2 <unlink>
  fd = open("lf1", O_CREATE | O_RDWR);
     c9a:	20200593          	li	a1,514
     c9e:	00005517          	auipc	a0,0x5
     ca2:	3a250513          	addi	a0,a0,930 # 6040 <malloc+0x6f6>
     ca6:	00d040ef          	jal	ra,54b2 <open>
  if (fd < 0) {
     caa:	0c054f63          	bltz	a0,d88 <linktest+0x114>
     cae:	84aa                	mv	s1,a0
  if (write(fd, "hello", SZ) != SZ) {
     cb0:	4615                	li	a2,5
     cb2:	00005597          	auipc	a1,0x5
     cb6:	2de58593          	addi	a1,a1,734 # 5f90 <malloc+0x646>
     cba:	7d8040ef          	jal	ra,5492 <write>
     cbe:	4795                	li	a5,5
     cc0:	0cf51e63          	bne	a0,a5,d9c <linktest+0x128>
  close(fd);
     cc4:	8526                	mv	a0,s1
     cc6:	7d4040ef          	jal	ra,549a <close>
  if (link("lf1", "lf2") < 0) {
     cca:	00005597          	auipc	a1,0x5
     cce:	37e58593          	addi	a1,a1,894 # 6048 <malloc+0x6fe>
     cd2:	00005517          	auipc	a0,0x5
     cd6:	36e50513          	addi	a0,a0,878 # 6040 <malloc+0x6f6>
     cda:	7f8040ef          	jal	ra,54d2 <link>
     cde:	0c054963          	bltz	a0,db0 <linktest+0x13c>
  unlink("lf1");
     ce2:	00005517          	auipc	a0,0x5
     ce6:	35e50513          	addi	a0,a0,862 # 6040 <malloc+0x6f6>
     cea:	7d8040ef          	jal	ra,54c2 <unlink>
  if (open("lf1", 0) >= 0) {
     cee:	4581                	li	a1,0
     cf0:	00005517          	auipc	a0,0x5
     cf4:	35050513          	addi	a0,a0,848 # 6040 <malloc+0x6f6>
     cf8:	7ba040ef          	jal	ra,54b2 <open>
     cfc:	0c055463          	bgez	a0,dc4 <linktest+0x150>
  fd = open("lf2", 0);
     d00:	4581                	li	a1,0
     d02:	00005517          	auipc	a0,0x5
     d06:	34650513          	addi	a0,a0,838 # 6048 <malloc+0x6fe>
     d0a:	7a8040ef          	jal	ra,54b2 <open>
     d0e:	84aa                	mv	s1,a0
  if (fd < 0) {
     d10:	0c054463          	bltz	a0,dd8 <linktest+0x164>
  if (read(fd, buf, sizeof(buf)) != SZ) {
     d14:	660d                	lui	a2,0x3
     d16:	0000c597          	auipc	a1,0xc
     d1a:	fe258593          	addi	a1,a1,-30 # ccf8 <buf>
     d1e:	76c040ef          	jal	ra,548a <read>
     d22:	4795                	li	a5,5
     d24:	0cf51463          	bne	a0,a5,dec <linktest+0x178>
  close(fd);
     d28:	8526                	mv	a0,s1
     d2a:	770040ef          	jal	ra,549a <close>
  if (link("lf2", "lf2") >= 0) {
     d2e:	00005597          	auipc	a1,0x5
     d32:	31a58593          	addi	a1,a1,794 # 6048 <malloc+0x6fe>
     d36:	852e                	mv	a0,a1
     d38:	79a040ef          	jal	ra,54d2 <link>
     d3c:	0c055263          	bgez	a0,e00 <linktest+0x18c>
  unlink("lf2");
     d40:	00005517          	auipc	a0,0x5
     d44:	30850513          	addi	a0,a0,776 # 6048 <malloc+0x6fe>
     d48:	77a040ef          	jal	ra,54c2 <unlink>
  if (link("lf2", "lf1") >= 0) {
     d4c:	00005597          	auipc	a1,0x5
     d50:	2f458593          	addi	a1,a1,756 # 6040 <malloc+0x6f6>
     d54:	00005517          	auipc	a0,0x5
     d58:	2f450513          	addi	a0,a0,756 # 6048 <malloc+0x6fe>
     d5c:	776040ef          	jal	ra,54d2 <link>
     d60:	0a055a63          	bgez	a0,e14 <linktest+0x1a0>
  if (link(".", "lf1") >= 0) {
     d64:	00005597          	auipc	a1,0x5
     d68:	2dc58593          	addi	a1,a1,732 # 6040 <malloc+0x6f6>
     d6c:	00005517          	auipc	a0,0x5
     d70:	3e450513          	addi	a0,a0,996 # 6150 <malloc+0x806>
     d74:	75e040ef          	jal	ra,54d2 <link>
     d78:	0a055863          	bgez	a0,e28 <linktest+0x1b4>
}
     d7c:	60e2                	ld	ra,24(sp)
     d7e:	6442                	ld	s0,16(sp)
     d80:	64a2                	ld	s1,8(sp)
     d82:	6902                	ld	s2,0(sp)
     d84:	6105                	addi	sp,sp,32
     d86:	8082                	ret
    printf("%s: create lf1 failed\n", s);
     d88:	85ca                	mv	a1,s2
     d8a:	00005517          	auipc	a0,0x5
     d8e:	2c650513          	addi	a0,a0,710 # 6050 <malloc+0x706>
     d92:	305040ef          	jal	ra,5896 <printf>
    exit(1);
     d96:	4505                	li	a0,1
     d98:	6da040ef          	jal	ra,5472 <exit>
    printf("%s: write lf1 failed\n", s);
     d9c:	85ca                	mv	a1,s2
     d9e:	00005517          	auipc	a0,0x5
     da2:	2ca50513          	addi	a0,a0,714 # 6068 <malloc+0x71e>
     da6:	2f1040ef          	jal	ra,5896 <printf>
    exit(1);
     daa:	4505                	li	a0,1
     dac:	6c6040ef          	jal	ra,5472 <exit>
    printf("%s: link lf1 lf2 failed\n", s);
     db0:	85ca                	mv	a1,s2
     db2:	00005517          	auipc	a0,0x5
     db6:	2ce50513          	addi	a0,a0,718 # 6080 <malloc+0x736>
     dba:	2dd040ef          	jal	ra,5896 <printf>
    exit(1);
     dbe:	4505                	li	a0,1
     dc0:	6b2040ef          	jal	ra,5472 <exit>
    printf("%s: unlinked lf1 but it is still there!\n", s);
     dc4:	85ca                	mv	a1,s2
     dc6:	00005517          	auipc	a0,0x5
     dca:	2da50513          	addi	a0,a0,730 # 60a0 <malloc+0x756>
     dce:	2c9040ef          	jal	ra,5896 <printf>
    exit(1);
     dd2:	4505                	li	a0,1
     dd4:	69e040ef          	jal	ra,5472 <exit>
    printf("%s: open lf2 failed\n", s);
     dd8:	85ca                	mv	a1,s2
     dda:	00005517          	auipc	a0,0x5
     dde:	2f650513          	addi	a0,a0,758 # 60d0 <malloc+0x786>
     de2:	2b5040ef          	jal	ra,5896 <printf>
    exit(1);
     de6:	4505                	li	a0,1
     de8:	68a040ef          	jal	ra,5472 <exit>
    printf("%s: read lf2 failed\n", s);
     dec:	85ca                	mv	a1,s2
     dee:	00005517          	auipc	a0,0x5
     df2:	2fa50513          	addi	a0,a0,762 # 60e8 <malloc+0x79e>
     df6:	2a1040ef          	jal	ra,5896 <printf>
    exit(1);
     dfa:	4505                	li	a0,1
     dfc:	676040ef          	jal	ra,5472 <exit>
    printf("%s: link lf2 lf2 succeeded! oops\n", s);
     e00:	85ca                	mv	a1,s2
     e02:	00005517          	auipc	a0,0x5
     e06:	2fe50513          	addi	a0,a0,766 # 6100 <malloc+0x7b6>
     e0a:	28d040ef          	jal	ra,5896 <printf>
    exit(1);
     e0e:	4505                	li	a0,1
     e10:	662040ef          	jal	ra,5472 <exit>
    printf("%s: link non-existent succeeded! oops\n", s);
     e14:	85ca                	mv	a1,s2
     e16:	00005517          	auipc	a0,0x5
     e1a:	31250513          	addi	a0,a0,786 # 6128 <malloc+0x7de>
     e1e:	279040ef          	jal	ra,5896 <printf>
    exit(1);
     e22:	4505                	li	a0,1
     e24:	64e040ef          	jal	ra,5472 <exit>
    printf("%s: link . lf1 succeeded! oops\n", s);
     e28:	85ca                	mv	a1,s2
     e2a:	00005517          	auipc	a0,0x5
     e2e:	32e50513          	addi	a0,a0,814 # 6158 <malloc+0x80e>
     e32:	265040ef          	jal	ra,5896 <printf>
    exit(1);
     e36:	4505                	li	a0,1
     e38:	63a040ef          	jal	ra,5472 <exit>

0000000000000e3c <validatetest>:
{
     e3c:	7139                	addi	sp,sp,-64
     e3e:	fc06                	sd	ra,56(sp)
     e40:	f822                	sd	s0,48(sp)
     e42:	f426                	sd	s1,40(sp)
     e44:	f04a                	sd	s2,32(sp)
     e46:	ec4e                	sd	s3,24(sp)
     e48:	e852                	sd	s4,16(sp)
     e4a:	e456                	sd	s5,8(sp)
     e4c:	e05a                	sd	s6,0(sp)
     e4e:	0080                	addi	s0,sp,64
     e50:	8b2a                	mv	s6,a0
  for (p = 0; p <= (uint)hi; p += PGSIZE) {
     e52:	4481                	li	s1,0
    if (link("nosuchfile", (char *)p) != -1) {
     e54:	00005997          	auipc	s3,0x5
     e58:	32498993          	addi	s3,s3,804 # 6178 <malloc+0x82e>
     e5c:	597d                	li	s2,-1
  for (p = 0; p <= (uint)hi; p += PGSIZE) {
     e5e:	6a85                	lui	s5,0x1
     e60:	00114a37          	lui	s4,0x114
    if (link("nosuchfile", (char *)p) != -1) {
     e64:	85a6                	mv	a1,s1
     e66:	854e                	mv	a0,s3
     e68:	66a040ef          	jal	ra,54d2 <link>
     e6c:	01251f63          	bne	a0,s2,e8a <validatetest+0x4e>
  for (p = 0; p <= (uint)hi; p += PGSIZE) {
     e70:	94d6                	add	s1,s1,s5
     e72:	ff4499e3          	bne	s1,s4,e64 <validatetest+0x28>
}
     e76:	70e2                	ld	ra,56(sp)
     e78:	7442                	ld	s0,48(sp)
     e7a:	74a2                	ld	s1,40(sp)
     e7c:	7902                	ld	s2,32(sp)
     e7e:	69e2                	ld	s3,24(sp)
     e80:	6a42                	ld	s4,16(sp)
     e82:	6aa2                	ld	s5,8(sp)
     e84:	6b02                	ld	s6,0(sp)
     e86:	6121                	addi	sp,sp,64
     e88:	8082                	ret
      printf("%s: link should not succeed\n", s);
     e8a:	85da                	mv	a1,s6
     e8c:	00005517          	auipc	a0,0x5
     e90:	2fc50513          	addi	a0,a0,764 # 6188 <malloc+0x83e>
     e94:	203040ef          	jal	ra,5896 <printf>
      exit(1);
     e98:	4505                	li	a0,1
     e9a:	5d8040ef          	jal	ra,5472 <exit>

0000000000000e9e <bigdir>:
{
     e9e:	715d                	addi	sp,sp,-80
     ea0:	e486                	sd	ra,72(sp)
     ea2:	e0a2                	sd	s0,64(sp)
     ea4:	fc26                	sd	s1,56(sp)
     ea6:	f84a                	sd	s2,48(sp)
     ea8:	f44e                	sd	s3,40(sp)
     eaa:	f052                	sd	s4,32(sp)
     eac:	ec56                	sd	s5,24(sp)
     eae:	e85a                	sd	s6,16(sp)
     eb0:	0880                	addi	s0,sp,80
     eb2:	89aa                	mv	s3,a0
  unlink("bd");
     eb4:	00005517          	auipc	a0,0x5
     eb8:	2f450513          	addi	a0,a0,756 # 61a8 <malloc+0x85e>
     ebc:	606040ef          	jal	ra,54c2 <unlink>
  fd = open("bd", O_CREATE);
     ec0:	20000593          	li	a1,512
     ec4:	00005517          	auipc	a0,0x5
     ec8:	2e450513          	addi	a0,a0,740 # 61a8 <malloc+0x85e>
     ecc:	5e6040ef          	jal	ra,54b2 <open>
  if (fd < 0) {
     ed0:	0c054163          	bltz	a0,f92 <bigdir+0xf4>
  close(fd);
     ed4:	5c6040ef          	jal	ra,549a <close>
  for (i = 0; i < N; i++) {
     ed8:	4901                	li	s2,0
    name[0] = 'x';
     eda:	07800a93          	li	s5,120
    if (link("bd", name) != 0) {
     ede:	00005a17          	auipc	s4,0x5
     ee2:	2caa0a13          	addi	s4,s4,714 # 61a8 <malloc+0x85e>
  for (i = 0; i < N; i++) {
     ee6:	1f400b13          	li	s6,500
    name[0] = 'x';
     eea:	fb540823          	sb	s5,-80(s0)
    name[1] = '0' + (i / 64);
     eee:	41f9571b          	sraiw	a4,s2,0x1f
     ef2:	01a7571b          	srliw	a4,a4,0x1a
     ef6:	012707bb          	addw	a5,a4,s2
     efa:	4067d69b          	sraiw	a3,a5,0x6
     efe:	0306869b          	addiw	a3,a3,48
     f02:	fad408a3          	sb	a3,-79(s0)
    name[2] = '0' + (i % 64);
     f06:	03f7f793          	andi	a5,a5,63
     f0a:	9f99                	subw	a5,a5,a4
     f0c:	0307879b          	addiw	a5,a5,48
     f10:	faf40923          	sb	a5,-78(s0)
    name[3] = '\0';
     f14:	fa0409a3          	sb	zero,-77(s0)
    if (link("bd", name) != 0) {
     f18:	fb040593          	addi	a1,s0,-80
     f1c:	8552                	mv	a0,s4
     f1e:	5b4040ef          	jal	ra,54d2 <link>
     f22:	84aa                	mv	s1,a0
     f24:	e149                	bnez	a0,fa6 <bigdir+0x108>
  for (i = 0; i < N; i++) {
     f26:	2905                	addiw	s2,s2,1
     f28:	fd6911e3          	bne	s2,s6,eea <bigdir+0x4c>
  unlink("bd");
     f2c:	00005517          	auipc	a0,0x5
     f30:	27c50513          	addi	a0,a0,636 # 61a8 <malloc+0x85e>
     f34:	58e040ef          	jal	ra,54c2 <unlink>
    name[0] = 'x';
     f38:	07800913          	li	s2,120
  for (i = 0; i < N; i++) {
     f3c:	1f400a13          	li	s4,500
    name[0] = 'x';
     f40:	fb240823          	sb	s2,-80(s0)
    name[1] = '0' + (i / 64);
     f44:	41f4d71b          	sraiw	a4,s1,0x1f
     f48:	01a7571b          	srliw	a4,a4,0x1a
     f4c:	009707bb          	addw	a5,a4,s1
     f50:	4067d69b          	sraiw	a3,a5,0x6
     f54:	0306869b          	addiw	a3,a3,48
     f58:	fad408a3          	sb	a3,-79(s0)
    name[2] = '0' + (i % 64);
     f5c:	03f7f793          	andi	a5,a5,63
     f60:	9f99                	subw	a5,a5,a4
     f62:	0307879b          	addiw	a5,a5,48
     f66:	faf40923          	sb	a5,-78(s0)
    name[3] = '\0';
     f6a:	fa0409a3          	sb	zero,-77(s0)
    if (unlink(name) != 0) {
     f6e:	fb040513          	addi	a0,s0,-80
     f72:	550040ef          	jal	ra,54c2 <unlink>
     f76:	e529                	bnez	a0,fc0 <bigdir+0x122>
  for (i = 0; i < N; i++) {
     f78:	2485                	addiw	s1,s1,1
     f7a:	fd4493e3          	bne	s1,s4,f40 <bigdir+0xa2>
}
     f7e:	60a6                	ld	ra,72(sp)
     f80:	6406                	ld	s0,64(sp)
     f82:	74e2                	ld	s1,56(sp)
     f84:	7942                	ld	s2,48(sp)
     f86:	79a2                	ld	s3,40(sp)
     f88:	7a02                	ld	s4,32(sp)
     f8a:	6ae2                	ld	s5,24(sp)
     f8c:	6b42                	ld	s6,16(sp)
     f8e:	6161                	addi	sp,sp,80
     f90:	8082                	ret
    printf("%s: bigdir create failed\n", s);
     f92:	85ce                	mv	a1,s3
     f94:	00005517          	auipc	a0,0x5
     f98:	21c50513          	addi	a0,a0,540 # 61b0 <malloc+0x866>
     f9c:	0fb040ef          	jal	ra,5896 <printf>
    exit(1);
     fa0:	4505                	li	a0,1
     fa2:	4d0040ef          	jal	ra,5472 <exit>
      printf("%s: bigdir i=%d link(bd, %s) failed\n", s, i, name);
     fa6:	fb040693          	addi	a3,s0,-80
     faa:	864a                	mv	a2,s2
     fac:	85ce                	mv	a1,s3
     fae:	00005517          	auipc	a0,0x5
     fb2:	22250513          	addi	a0,a0,546 # 61d0 <malloc+0x886>
     fb6:	0e1040ef          	jal	ra,5896 <printf>
      exit(1);
     fba:	4505                	li	a0,1
     fbc:	4b6040ef          	jal	ra,5472 <exit>
      printf("%s: bigdir unlink failed", s);
     fc0:	85ce                	mv	a1,s3
     fc2:	00005517          	auipc	a0,0x5
     fc6:	23650513          	addi	a0,a0,566 # 61f8 <malloc+0x8ae>
     fca:	0cd040ef          	jal	ra,5896 <printf>
      exit(1);
     fce:	4505                	li	a0,1
     fd0:	4a2040ef          	jal	ra,5472 <exit>

0000000000000fd4 <pgbug>:
{
     fd4:	7179                	addi	sp,sp,-48
     fd6:	f406                	sd	ra,40(sp)
     fd8:	f022                	sd	s0,32(sp)
     fda:	ec26                	sd	s1,24(sp)
     fdc:	1800                	addi	s0,sp,48
  argv[0] = 0;
     fde:	fc043c23          	sd	zero,-40(s0)
  exec(big, argv);
     fe2:	00008497          	auipc	s1,0x8
     fe6:	01e48493          	addi	s1,s1,30 # 9000 <big>
     fea:	fd840593          	addi	a1,s0,-40
     fee:	6088                	ld	a0,0(s1)
     ff0:	4ba040ef          	jal	ra,54aa <exec>
  pipe(big);
     ff4:	6088                	ld	a0,0(s1)
     ff6:	48c040ef          	jal	ra,5482 <pipe>
  exit(0);
     ffa:	4501                	li	a0,0
     ffc:	476040ef          	jal	ra,5472 <exit>

0000000000001000 <badarg>:
{
    1000:	7139                	addi	sp,sp,-64
    1002:	fc06                	sd	ra,56(sp)
    1004:	f822                	sd	s0,48(sp)
    1006:	f426                	sd	s1,40(sp)
    1008:	f04a                	sd	s2,32(sp)
    100a:	ec4e                	sd	s3,24(sp)
    100c:	0080                	addi	s0,sp,64
    100e:	64b1                	lui	s1,0xc
    1010:	35048493          	addi	s1,s1,848 # c350 <uninit+0x1d68>
    argv[0] = (char *)0xffffffff;
    1014:	597d                	li	s2,-1
    1016:	02095913          	srli	s2,s2,0x20
    exec("echo", argv);
    101a:	00005997          	auipc	s3,0x5
    101e:	a4e98993          	addi	s3,s3,-1458 # 5a68 <malloc+0x11e>
    argv[0] = (char *)0xffffffff;
    1022:	fd243023          	sd	s2,-64(s0)
    argv[1] = 0;
    1026:	fc043423          	sd	zero,-56(s0)
    exec("echo", argv);
    102a:	fc040593          	addi	a1,s0,-64
    102e:	854e                	mv	a0,s3
    1030:	47a040ef          	jal	ra,54aa <exec>
  for (int i = 0; i < 50000; i++) {
    1034:	34fd                	addiw	s1,s1,-1
    1036:	f4f5                	bnez	s1,1022 <badarg+0x22>
  exit(0);
    1038:	4501                	li	a0,0
    103a:	438040ef          	jal	ra,5472 <exit>

000000000000103e <copyinstr2>:
{
    103e:	7155                	addi	sp,sp,-208
    1040:	e586                	sd	ra,200(sp)
    1042:	e1a2                	sd	s0,192(sp)
    1044:	0980                	addi	s0,sp,208
  for (int i = 0; i < MAXPATH; i++)
    1046:	f6840793          	addi	a5,s0,-152
    104a:	fe840693          	addi	a3,s0,-24
    b[i] = 'x';
    104e:	07800713          	li	a4,120
    1052:	00e78023          	sb	a4,0(a5)
  for (int i = 0; i < MAXPATH; i++)
    1056:	0785                	addi	a5,a5,1
    1058:	fed79de3          	bne	a5,a3,1052 <copyinstr2+0x14>
  b[MAXPATH] = '\0';
    105c:	fe040423          	sb	zero,-24(s0)
  int ret = unlink(b);
    1060:	f6840513          	addi	a0,s0,-152
    1064:	45e040ef          	jal	ra,54c2 <unlink>
  if (ret != -1) {
    1068:	57fd                	li	a5,-1
    106a:	0cf51263          	bne	a0,a5,112e <copyinstr2+0xf0>
  int fd = open(b, O_CREATE | O_WRONLY);
    106e:	20100593          	li	a1,513
    1072:	f6840513          	addi	a0,s0,-152
    1076:	43c040ef          	jal	ra,54b2 <open>
  if (fd != -1) {
    107a:	57fd                	li	a5,-1
    107c:	0cf51563          	bne	a0,a5,1146 <copyinstr2+0x108>
  ret = link(b, b);
    1080:	f6840593          	addi	a1,s0,-152
    1084:	852e                	mv	a0,a1
    1086:	44c040ef          	jal	ra,54d2 <link>
  if (ret != -1) {
    108a:	57fd                	li	a5,-1
    108c:	0cf51963          	bne	a0,a5,115e <copyinstr2+0x120>
  char *args[] = {"xx", 0};
    1090:	00006797          	auipc	a5,0x6
    1094:	25078793          	addi	a5,a5,592 # 72e0 <malloc+0x1996>
    1098:	f4f43c23          	sd	a5,-168(s0)
    109c:	f6043023          	sd	zero,-160(s0)
  ret = exec(b, args);
    10a0:	f5840593          	addi	a1,s0,-168
    10a4:	f6840513          	addi	a0,s0,-152
    10a8:	402040ef          	jal	ra,54aa <exec>
  if (ret != -1) {
    10ac:	57fd                	li	a5,-1
    10ae:	0cf51563          	bne	a0,a5,1178 <copyinstr2+0x13a>
  int pid = fork();
    10b2:	3b8040ef          	jal	ra,546a <fork>
  if (pid < 0) {
    10b6:	0c054d63          	bltz	a0,1190 <copyinstr2+0x152>
  if (pid == 0) {
    10ba:	0e051863          	bnez	a0,11aa <copyinstr2+0x16c>
    10be:	00008797          	auipc	a5,0x8
    10c2:	52278793          	addi	a5,a5,1314 # 95e0 <big.0>
    10c6:	00009697          	auipc	a3,0x9
    10ca:	51a68693          	addi	a3,a3,1306 # a5e0 <big.0+0x1000>
      big[i] = 'x';
    10ce:	07800713          	li	a4,120
    10d2:	00e78023          	sb	a4,0(a5)
    for (int i = 0; i < PGSIZE; i++)
    10d6:	0785                	addi	a5,a5,1
    10d8:	fed79de3          	bne	a5,a3,10d2 <copyinstr2+0x94>
    big[PGSIZE] = '\0';
    10dc:	00009797          	auipc	a5,0x9
    10e0:	50078223          	sb	zero,1284(a5) # a5e0 <big.0+0x1000>
    char *args2[] = {big, big, big, 0};
    10e4:	00007797          	auipc	a5,0x7
    10e8:	27478793          	addi	a5,a5,628 # 8358 <malloc+0x2a0e>
    10ec:	6fb0                	ld	a2,88(a5)
    10ee:	73b4                	ld	a3,96(a5)
    10f0:	77b8                	ld	a4,104(a5)
    10f2:	7bbc                	ld	a5,112(a5)
    10f4:	f2c43823          	sd	a2,-208(s0)
    10f8:	f2d43c23          	sd	a3,-200(s0)
    10fc:	f4e43023          	sd	a4,-192(s0)
    1100:	f4f43423          	sd	a5,-184(s0)
    ret = exec("echo", args2);
    1104:	f3040593          	addi	a1,s0,-208
    1108:	00005517          	auipc	a0,0x5
    110c:	96050513          	addi	a0,a0,-1696 # 5a68 <malloc+0x11e>
    1110:	39a040ef          	jal	ra,54aa <exec>
    if (ret != -1) {
    1114:	57fd                	li	a5,-1
    1116:	08f50663          	beq	a0,a5,11a2 <copyinstr2+0x164>
      printf("exec(echo, BIG) returned %d, not -1\n", fd);
    111a:	55fd                	li	a1,-1
    111c:	00005517          	auipc	a0,0x5
    1120:	18450513          	addi	a0,a0,388 # 62a0 <malloc+0x956>
    1124:	772040ef          	jal	ra,5896 <printf>
      exit(1);
    1128:	4505                	li	a0,1
    112a:	348040ef          	jal	ra,5472 <exit>
    printf("unlink(%s) returned %d, not -1\n", b, ret);
    112e:	862a                	mv	a2,a0
    1130:	f6840593          	addi	a1,s0,-152
    1134:	00005517          	auipc	a0,0x5
    1138:	0e450513          	addi	a0,a0,228 # 6218 <malloc+0x8ce>
    113c:	75a040ef          	jal	ra,5896 <printf>
    exit(1);
    1140:	4505                	li	a0,1
    1142:	330040ef          	jal	ra,5472 <exit>
    printf("open(%s) returned %d, not -1\n", b, fd);
    1146:	862a                	mv	a2,a0
    1148:	f6840593          	addi	a1,s0,-152
    114c:	00005517          	auipc	a0,0x5
    1150:	0ec50513          	addi	a0,a0,236 # 6238 <malloc+0x8ee>
    1154:	742040ef          	jal	ra,5896 <printf>
    exit(1);
    1158:	4505                	li	a0,1
    115a:	318040ef          	jal	ra,5472 <exit>
    printf("link(%s, %s) returned %d, not -1\n", b, b, ret);
    115e:	86aa                	mv	a3,a0
    1160:	f6840613          	addi	a2,s0,-152
    1164:	85b2                	mv	a1,a2
    1166:	00005517          	auipc	a0,0x5
    116a:	0f250513          	addi	a0,a0,242 # 6258 <malloc+0x90e>
    116e:	728040ef          	jal	ra,5896 <printf>
    exit(1);
    1172:	4505                	li	a0,1
    1174:	2fe040ef          	jal	ra,5472 <exit>
    printf("exec(%s) returned %d, not -1\n", b, fd);
    1178:	567d                	li	a2,-1
    117a:	f6840593          	addi	a1,s0,-152
    117e:	00005517          	auipc	a0,0x5
    1182:	10250513          	addi	a0,a0,258 # 6280 <malloc+0x936>
    1186:	710040ef          	jal	ra,5896 <printf>
    exit(1);
    118a:	4505                	li	a0,1
    118c:	2e6040ef          	jal	ra,5472 <exit>
    printf("fork failed\n");
    1190:	00007517          	auipc	a0,0x7
    1194:	85850513          	addi	a0,a0,-1960 # 79e8 <malloc+0x209e>
    1198:	6fe040ef          	jal	ra,5896 <printf>
    exit(1);
    119c:	4505                	li	a0,1
    119e:	2d4040ef          	jal	ra,5472 <exit>
    exit(747); // OK
    11a2:	2eb00513          	li	a0,747
    11a6:	2cc040ef          	jal	ra,5472 <exit>
  int st = 0;
    11aa:	f4042a23          	sw	zero,-172(s0)
  wait(&st);
    11ae:	f5440513          	addi	a0,s0,-172
    11b2:	2c8040ef          	jal	ra,547a <wait>
  if (st != 747) {
    11b6:	f5442703          	lw	a4,-172(s0)
    11ba:	2eb00793          	li	a5,747
    11be:	00f71663          	bne	a4,a5,11ca <copyinstr2+0x18c>
}
    11c2:	60ae                	ld	ra,200(sp)
    11c4:	640e                	ld	s0,192(sp)
    11c6:	6169                	addi	sp,sp,208
    11c8:	8082                	ret
    printf("exec(echo, BIG) succeeded, should have failed\n");
    11ca:	00005517          	auipc	a0,0x5
    11ce:	0fe50513          	addi	a0,a0,254 # 62c8 <malloc+0x97e>
    11d2:	6c4040ef          	jal	ra,5896 <printf>
    exit(1);
    11d6:	4505                	li	a0,1
    11d8:	29a040ef          	jal	ra,5472 <exit>

00000000000011dc <truncate3>:
{
    11dc:	7159                	addi	sp,sp,-112
    11de:	f486                	sd	ra,104(sp)
    11e0:	f0a2                	sd	s0,96(sp)
    11e2:	eca6                	sd	s1,88(sp)
    11e4:	e8ca                	sd	s2,80(sp)
    11e6:	e4ce                	sd	s3,72(sp)
    11e8:	e0d2                	sd	s4,64(sp)
    11ea:	fc56                	sd	s5,56(sp)
    11ec:	1880                	addi	s0,sp,112
    11ee:	892a                	mv	s2,a0
  close(open("truncfile", O_CREATE | O_TRUNC | O_WRONLY));
    11f0:	60100593          	li	a1,1537
    11f4:	00005517          	auipc	a0,0x5
    11f8:	8cc50513          	addi	a0,a0,-1844 # 5ac0 <malloc+0x176>
    11fc:	2b6040ef          	jal	ra,54b2 <open>
    1200:	29a040ef          	jal	ra,549a <close>
  pid = fork();
    1204:	266040ef          	jal	ra,546a <fork>
  if (pid < 0) {
    1208:	06054263          	bltz	a0,126c <truncate3+0x90>
  if (pid == 0) {
    120c:	ed59                	bnez	a0,12aa <truncate3+0xce>
    120e:	06400993          	li	s3,100
      int fd = open("truncfile", O_WRONLY);
    1212:	00005a17          	auipc	s4,0x5
    1216:	8aea0a13          	addi	s4,s4,-1874 # 5ac0 <malloc+0x176>
      int n = write(fd, "1234567890", 10);
    121a:	00005a97          	auipc	s5,0x5
    121e:	10ea8a93          	addi	s5,s5,270 # 6328 <malloc+0x9de>
      int fd = open("truncfile", O_WRONLY);
    1222:	4585                	li	a1,1
    1224:	8552                	mv	a0,s4
    1226:	28c040ef          	jal	ra,54b2 <open>
    122a:	84aa                	mv	s1,a0
      if (fd < 0) {
    122c:	04054a63          	bltz	a0,1280 <truncate3+0xa4>
      int n = write(fd, "1234567890", 10);
    1230:	4629                	li	a2,10
    1232:	85d6                	mv	a1,s5
    1234:	25e040ef          	jal	ra,5492 <write>
      if (n != 10) {
    1238:	47a9                	li	a5,10
    123a:	04f51d63          	bne	a0,a5,1294 <truncate3+0xb8>
      close(fd);
    123e:	8526                	mv	a0,s1
    1240:	25a040ef          	jal	ra,549a <close>
      fd = open("truncfile", O_RDONLY);
    1244:	4581                	li	a1,0
    1246:	8552                	mv	a0,s4
    1248:	26a040ef          	jal	ra,54b2 <open>
    124c:	84aa                	mv	s1,a0
      read(fd, buf, sizeof(buf));
    124e:	02000613          	li	a2,32
    1252:	f9840593          	addi	a1,s0,-104
    1256:	234040ef          	jal	ra,548a <read>
      close(fd);
    125a:	8526                	mv	a0,s1
    125c:	23e040ef          	jal	ra,549a <close>
    for (int i = 0; i < 100; i++) {
    1260:	39fd                	addiw	s3,s3,-1
    1262:	fc0990e3          	bnez	s3,1222 <truncate3+0x46>
    exit(0);
    1266:	4501                	li	a0,0
    1268:	20a040ef          	jal	ra,5472 <exit>
    printf("%s: fork failed\n", s);
    126c:	85ca                	mv	a1,s2
    126e:	00005517          	auipc	a0,0x5
    1272:	08a50513          	addi	a0,a0,138 # 62f8 <malloc+0x9ae>
    1276:	620040ef          	jal	ra,5896 <printf>
    exit(1);
    127a:	4505                	li	a0,1
    127c:	1f6040ef          	jal	ra,5472 <exit>
        printf("%s: open failed\n", s);
    1280:	85ca                	mv	a1,s2
    1282:	00005517          	auipc	a0,0x5
    1286:	08e50513          	addi	a0,a0,142 # 6310 <malloc+0x9c6>
    128a:	60c040ef          	jal	ra,5896 <printf>
        exit(1);
    128e:	4505                	li	a0,1
    1290:	1e2040ef          	jal	ra,5472 <exit>
        printf("%s: write got %d, expected 10\n", s, n);
    1294:	862a                	mv	a2,a0
    1296:	85ca                	mv	a1,s2
    1298:	00005517          	auipc	a0,0x5
    129c:	0a050513          	addi	a0,a0,160 # 6338 <malloc+0x9ee>
    12a0:	5f6040ef          	jal	ra,5896 <printf>
        exit(1);
    12a4:	4505                	li	a0,1
    12a6:	1cc040ef          	jal	ra,5472 <exit>
    12aa:	09600993          	li	s3,150
    int fd = open("truncfile", O_CREATE | O_WRONLY | O_TRUNC);
    12ae:	00005a17          	auipc	s4,0x5
    12b2:	812a0a13          	addi	s4,s4,-2030 # 5ac0 <malloc+0x176>
    int n = write(fd, "xxx", 3);
    12b6:	00005a97          	auipc	s5,0x5
    12ba:	0a2a8a93          	addi	s5,s5,162 # 6358 <malloc+0xa0e>
    int fd = open("truncfile", O_CREATE | O_WRONLY | O_TRUNC);
    12be:	60100593          	li	a1,1537
    12c2:	8552                	mv	a0,s4
    12c4:	1ee040ef          	jal	ra,54b2 <open>
    12c8:	84aa                	mv	s1,a0
    if (fd < 0) {
    12ca:	02054d63          	bltz	a0,1304 <truncate3+0x128>
    int n = write(fd, "xxx", 3);
    12ce:	460d                	li	a2,3
    12d0:	85d6                	mv	a1,s5
    12d2:	1c0040ef          	jal	ra,5492 <write>
    if (n != 3) {
    12d6:	478d                	li	a5,3
    12d8:	04f51063          	bne	a0,a5,1318 <truncate3+0x13c>
    close(fd);
    12dc:	8526                	mv	a0,s1
    12de:	1bc040ef          	jal	ra,549a <close>
  for (int i = 0; i < 150; i++) {
    12e2:	39fd                	addiw	s3,s3,-1
    12e4:	fc099de3          	bnez	s3,12be <truncate3+0xe2>
  wait(&xstatus);
    12e8:	fbc40513          	addi	a0,s0,-68
    12ec:	18e040ef          	jal	ra,547a <wait>
  unlink("truncfile");
    12f0:	00004517          	auipc	a0,0x4
    12f4:	7d050513          	addi	a0,a0,2000 # 5ac0 <malloc+0x176>
    12f8:	1ca040ef          	jal	ra,54c2 <unlink>
  exit(xstatus);
    12fc:	fbc42503          	lw	a0,-68(s0)
    1300:	172040ef          	jal	ra,5472 <exit>
      printf("%s: open failed\n", s);
    1304:	85ca                	mv	a1,s2
    1306:	00005517          	auipc	a0,0x5
    130a:	00a50513          	addi	a0,a0,10 # 6310 <malloc+0x9c6>
    130e:	588040ef          	jal	ra,5896 <printf>
      exit(1);
    1312:	4505                	li	a0,1
    1314:	15e040ef          	jal	ra,5472 <exit>
      printf("%s: write got %d, expected 3\n", s, n);
    1318:	862a                	mv	a2,a0
    131a:	85ca                	mv	a1,s2
    131c:	00005517          	auipc	a0,0x5
    1320:	04450513          	addi	a0,a0,68 # 6360 <malloc+0xa16>
    1324:	572040ef          	jal	ra,5896 <printf>
      exit(1);
    1328:	4505                	li	a0,1
    132a:	148040ef          	jal	ra,5472 <exit>

000000000000132e <pipe1>:
{
    132e:	711d                	addi	sp,sp,-96
    1330:	ec86                	sd	ra,88(sp)
    1332:	e8a2                	sd	s0,80(sp)
    1334:	e4a6                	sd	s1,72(sp)
    1336:	e0ca                	sd	s2,64(sp)
    1338:	fc4e                	sd	s3,56(sp)
    133a:	f852                	sd	s4,48(sp)
    133c:	f456                	sd	s5,40(sp)
    133e:	f05a                	sd	s6,32(sp)
    1340:	ec5e                	sd	s7,24(sp)
    1342:	1080                	addi	s0,sp,96
    1344:	892a                	mv	s2,a0
  if (pipe(fds) != 0) {
    1346:	fa840513          	addi	a0,s0,-88
    134a:	138040ef          	jal	ra,5482 <pipe>
    134e:	e52d                	bnez	a0,13b8 <pipe1+0x8a>
    1350:	84aa                	mv	s1,a0
  pid = fork();
    1352:	118040ef          	jal	ra,546a <fork>
    1356:	8a2a                	mv	s4,a0
  if (pid == 0) {
    1358:	c935                	beqz	a0,13cc <pipe1+0x9e>
  } else if (pid > 0) {
    135a:	14a05063          	blez	a0,149a <pipe1+0x16c>
    close(fds[1]);
    135e:	fac42503          	lw	a0,-84(s0)
    1362:	138040ef          	jal	ra,549a <close>
    total = 0;
    1366:	8a26                	mv	s4,s1
    cc = 1;
    1368:	4985                	li	s3,1
    while ((n = read(fds[0], buf, cc)) > 0) {
    136a:	0000ca97          	auipc	s5,0xc
    136e:	98ea8a93          	addi	s5,s5,-1650 # ccf8 <buf>
      if (cc > sizeof(buf))
    1372:	6b0d                	lui	s6,0x3
    while ((n = read(fds[0], buf, cc)) > 0) {
    1374:	864e                	mv	a2,s3
    1376:	85d6                	mv	a1,s5
    1378:	fa842503          	lw	a0,-88(s0)
    137c:	10e040ef          	jal	ra,548a <read>
    1380:	0ea05163          	blez	a0,1462 <pipe1+0x134>
      for (i = 0; i < n; i++) {
    1384:	0000c717          	auipc	a4,0xc
    1388:	97470713          	addi	a4,a4,-1676 # ccf8 <buf>
    138c:	00a4863b          	addw	a2,s1,a0
        if ((buf[i] & 0xff) != (seq++ & 0xff)) {
    1390:	00074683          	lbu	a3,0(a4)
    1394:	0ff4f793          	zext.b	a5,s1
    1398:	2485                	addiw	s1,s1,1
    139a:	0af69263          	bne	a3,a5,143e <pipe1+0x110>
      for (i = 0; i < n; i++) {
    139e:	0705                	addi	a4,a4,1
    13a0:	fec498e3          	bne	s1,a2,1390 <pipe1+0x62>
      total += n;
    13a4:	00aa0a3b          	addw	s4,s4,a0
      cc = cc * 2;
    13a8:	0019979b          	slliw	a5,s3,0x1
    13ac:	0007899b          	sext.w	s3,a5
      if (cc > sizeof(buf))
    13b0:	fd3b72e3          	bgeu	s6,s3,1374 <pipe1+0x46>
        cc = sizeof(buf);
    13b4:	89da                	mv	s3,s6
    13b6:	bf7d                	j	1374 <pipe1+0x46>
    printf("%s: pipe() failed\n", s);
    13b8:	85ca                	mv	a1,s2
    13ba:	00005517          	auipc	a0,0x5
    13be:	fc650513          	addi	a0,a0,-58 # 6380 <malloc+0xa36>
    13c2:	4d4040ef          	jal	ra,5896 <printf>
    exit(1);
    13c6:	4505                	li	a0,1
    13c8:	0aa040ef          	jal	ra,5472 <exit>
    close(fds[0]);
    13cc:	fa842503          	lw	a0,-88(s0)
    13d0:	0ca040ef          	jal	ra,549a <close>
    for (n = 0; n < N; n++) {
    13d4:	0000cb17          	auipc	s6,0xc
    13d8:	924b0b13          	addi	s6,s6,-1756 # ccf8 <buf>
    13dc:	416004bb          	negw	s1,s6
    13e0:	0ff4f493          	zext.b	s1,s1
    13e4:	409b0993          	addi	s3,s6,1033
      if (write(fds[1], buf, SZ) != SZ) {
    13e8:	8bda                	mv	s7,s6
    for (n = 0; n < N; n++) {
    13ea:	6a85                	lui	s5,0x1
    13ec:	42da8a93          	addi	s5,s5,1069 # 142d <pipe1+0xff>
{
    13f0:	87da                	mv	a5,s6
        buf[i] = seq++;
    13f2:	0097873b          	addw	a4,a5,s1
    13f6:	00e78023          	sb	a4,0(a5)
      for (i = 0; i < SZ; i++)
    13fa:	0785                	addi	a5,a5,1
    13fc:	fef99be3          	bne	s3,a5,13f2 <pipe1+0xc4>
        buf[i] = seq++;
    1400:	409a0a1b          	addiw	s4,s4,1033
      if (write(fds[1], buf, SZ) != SZ) {
    1404:	40900613          	li	a2,1033
    1408:	85de                	mv	a1,s7
    140a:	fac42503          	lw	a0,-84(s0)
    140e:	084040ef          	jal	ra,5492 <write>
    1412:	40900793          	li	a5,1033
    1416:	00f51a63          	bne	a0,a5,142a <pipe1+0xfc>
    for (n = 0; n < N; n++) {
    141a:	24a5                	addiw	s1,s1,9
    141c:	0ff4f493          	zext.b	s1,s1
    1420:	fd5a18e3          	bne	s4,s5,13f0 <pipe1+0xc2>
    exit(0);
    1424:	4501                	li	a0,0
    1426:	04c040ef          	jal	ra,5472 <exit>
        printf("%s: pipe1 oops 1\n", s);
    142a:	85ca                	mv	a1,s2
    142c:	00005517          	auipc	a0,0x5
    1430:	f6c50513          	addi	a0,a0,-148 # 6398 <malloc+0xa4e>
    1434:	462040ef          	jal	ra,5896 <printf>
        exit(1);
    1438:	4505                	li	a0,1
    143a:	038040ef          	jal	ra,5472 <exit>
          printf("%s: pipe1 oops 2\n", s);
    143e:	85ca                	mv	a1,s2
    1440:	00005517          	auipc	a0,0x5
    1444:	f7050513          	addi	a0,a0,-144 # 63b0 <malloc+0xa66>
    1448:	44e040ef          	jal	ra,5896 <printf>
}
    144c:	60e6                	ld	ra,88(sp)
    144e:	6446                	ld	s0,80(sp)
    1450:	64a6                	ld	s1,72(sp)
    1452:	6906                	ld	s2,64(sp)
    1454:	79e2                	ld	s3,56(sp)
    1456:	7a42                	ld	s4,48(sp)
    1458:	7aa2                	ld	s5,40(sp)
    145a:	7b02                	ld	s6,32(sp)
    145c:	6be2                	ld	s7,24(sp)
    145e:	6125                	addi	sp,sp,96
    1460:	8082                	ret
    if (total != N * SZ) {
    1462:	6785                	lui	a5,0x1
    1464:	42d78793          	addi	a5,a5,1069 # 142d <pipe1+0xff>
    1468:	00fa0d63          	beq	s4,a5,1482 <pipe1+0x154>
      printf("%s: pipe1 oops 3 total %d\n", s, total);
    146c:	8652                	mv	a2,s4
    146e:	85ca                	mv	a1,s2
    1470:	00005517          	auipc	a0,0x5
    1474:	f5850513          	addi	a0,a0,-168 # 63c8 <malloc+0xa7e>
    1478:	41e040ef          	jal	ra,5896 <printf>
      exit(1);
    147c:	4505                	li	a0,1
    147e:	7f5030ef          	jal	ra,5472 <exit>
    close(fds[0]);
    1482:	fa842503          	lw	a0,-88(s0)
    1486:	014040ef          	jal	ra,549a <close>
    wait(&xstatus);
    148a:	fa440513          	addi	a0,s0,-92
    148e:	7ed030ef          	jal	ra,547a <wait>
    exit(xstatus);
    1492:	fa442503          	lw	a0,-92(s0)
    1496:	7dd030ef          	jal	ra,5472 <exit>
    printf("%s: fork() failed\n", s);
    149a:	85ca                	mv	a1,s2
    149c:	00005517          	auipc	a0,0x5
    14a0:	f4c50513          	addi	a0,a0,-180 # 63e8 <malloc+0xa9e>
    14a4:	3f2040ef          	jal	ra,5896 <printf>
    exit(1);
    14a8:	4505                	li	a0,1
    14aa:	7c9030ef          	jal	ra,5472 <exit>

00000000000014ae <exitwait>:
{
    14ae:	7139                	addi	sp,sp,-64
    14b0:	fc06                	sd	ra,56(sp)
    14b2:	f822                	sd	s0,48(sp)
    14b4:	f426                	sd	s1,40(sp)
    14b6:	f04a                	sd	s2,32(sp)
    14b8:	ec4e                	sd	s3,24(sp)
    14ba:	e852                	sd	s4,16(sp)
    14bc:	0080                	addi	s0,sp,64
    14be:	8a2a                	mv	s4,a0
  for (i = 0; i < 100; i++) {
    14c0:	4901                	li	s2,0
    14c2:	06400993          	li	s3,100
    pid = fork();
    14c6:	7a5030ef          	jal	ra,546a <fork>
    14ca:	84aa                	mv	s1,a0
    if (pid < 0) {
    14cc:	02054863          	bltz	a0,14fc <exitwait+0x4e>
    if (pid) {
    14d0:	c525                	beqz	a0,1538 <exitwait+0x8a>
      if (wait(&xstate) != pid) {
    14d2:	fcc40513          	addi	a0,s0,-52
    14d6:	7a5030ef          	jal	ra,547a <wait>
    14da:	02951b63          	bne	a0,s1,1510 <exitwait+0x62>
      if (i != xstate) {
    14de:	fcc42783          	lw	a5,-52(s0)
    14e2:	05279163          	bne	a5,s2,1524 <exitwait+0x76>
  for (i = 0; i < 100; i++) {
    14e6:	2905                	addiw	s2,s2,1
    14e8:	fd391fe3          	bne	s2,s3,14c6 <exitwait+0x18>
}
    14ec:	70e2                	ld	ra,56(sp)
    14ee:	7442                	ld	s0,48(sp)
    14f0:	74a2                	ld	s1,40(sp)
    14f2:	7902                	ld	s2,32(sp)
    14f4:	69e2                	ld	s3,24(sp)
    14f6:	6a42                	ld	s4,16(sp)
    14f8:	6121                	addi	sp,sp,64
    14fa:	8082                	ret
      printf("%s: fork failed\n", s);
    14fc:	85d2                	mv	a1,s4
    14fe:	00005517          	auipc	a0,0x5
    1502:	dfa50513          	addi	a0,a0,-518 # 62f8 <malloc+0x9ae>
    1506:	390040ef          	jal	ra,5896 <printf>
      exit(1);
    150a:	4505                	li	a0,1
    150c:	767030ef          	jal	ra,5472 <exit>
        printf("%s: wait wrong pid\n", s);
    1510:	85d2                	mv	a1,s4
    1512:	00005517          	auipc	a0,0x5
    1516:	eee50513          	addi	a0,a0,-274 # 6400 <malloc+0xab6>
    151a:	37c040ef          	jal	ra,5896 <printf>
        exit(1);
    151e:	4505                	li	a0,1
    1520:	753030ef          	jal	ra,5472 <exit>
        printf("%s: wait wrong exit status\n", s);
    1524:	85d2                	mv	a1,s4
    1526:	00005517          	auipc	a0,0x5
    152a:	ef250513          	addi	a0,a0,-270 # 6418 <malloc+0xace>
    152e:	368040ef          	jal	ra,5896 <printf>
        exit(1);
    1532:	4505                	li	a0,1
    1534:	73f030ef          	jal	ra,5472 <exit>
      exit(i);
    1538:	854a                	mv	a0,s2
    153a:	739030ef          	jal	ra,5472 <exit>

000000000000153e <twochildren>:
{
    153e:	1101                	addi	sp,sp,-32
    1540:	ec06                	sd	ra,24(sp)
    1542:	e822                	sd	s0,16(sp)
    1544:	e426                	sd	s1,8(sp)
    1546:	e04a                	sd	s2,0(sp)
    1548:	1000                	addi	s0,sp,32
    154a:	892a                	mv	s2,a0
    154c:	3e800493          	li	s1,1000
    int pid1 = fork();
    1550:	71b030ef          	jal	ra,546a <fork>
    if (pid1 < 0) {
    1554:	02054663          	bltz	a0,1580 <twochildren+0x42>
    if (pid1 == 0) {
    1558:	cd15                	beqz	a0,1594 <twochildren+0x56>
      int pid2 = fork();
    155a:	711030ef          	jal	ra,546a <fork>
      if (pid2 < 0) {
    155e:	02054d63          	bltz	a0,1598 <twochildren+0x5a>
      if (pid2 == 0) {
    1562:	c529                	beqz	a0,15ac <twochildren+0x6e>
        wait(0);
    1564:	4501                	li	a0,0
    1566:	715030ef          	jal	ra,547a <wait>
        wait(0);
    156a:	4501                	li	a0,0
    156c:	70f030ef          	jal	ra,547a <wait>
  for (int i = 0; i < 1000; i++) {
    1570:	34fd                	addiw	s1,s1,-1
    1572:	fcf9                	bnez	s1,1550 <twochildren+0x12>
}
    1574:	60e2                	ld	ra,24(sp)
    1576:	6442                	ld	s0,16(sp)
    1578:	64a2                	ld	s1,8(sp)
    157a:	6902                	ld	s2,0(sp)
    157c:	6105                	addi	sp,sp,32
    157e:	8082                	ret
      printf("%s: fork failed\n", s);
    1580:	85ca                	mv	a1,s2
    1582:	00005517          	auipc	a0,0x5
    1586:	d7650513          	addi	a0,a0,-650 # 62f8 <malloc+0x9ae>
    158a:	30c040ef          	jal	ra,5896 <printf>
      exit(1);
    158e:	4505                	li	a0,1
    1590:	6e3030ef          	jal	ra,5472 <exit>
      exit(0);
    1594:	6df030ef          	jal	ra,5472 <exit>
        printf("%s: fork failed\n", s);
    1598:	85ca                	mv	a1,s2
    159a:	00005517          	auipc	a0,0x5
    159e:	d5e50513          	addi	a0,a0,-674 # 62f8 <malloc+0x9ae>
    15a2:	2f4040ef          	jal	ra,5896 <printf>
        exit(1);
    15a6:	4505                	li	a0,1
    15a8:	6cb030ef          	jal	ra,5472 <exit>
        exit(0);
    15ac:	6c7030ef          	jal	ra,5472 <exit>

00000000000015b0 <forkfork>:
{
    15b0:	7179                	addi	sp,sp,-48
    15b2:	f406                	sd	ra,40(sp)
    15b4:	f022                	sd	s0,32(sp)
    15b6:	ec26                	sd	s1,24(sp)
    15b8:	1800                	addi	s0,sp,48
    15ba:	84aa                	mv	s1,a0
    int pid = fork();
    15bc:	6af030ef          	jal	ra,546a <fork>
    if (pid < 0) {
    15c0:	02054b63          	bltz	a0,15f6 <forkfork+0x46>
    if (pid == 0) {
    15c4:	c139                	beqz	a0,160a <forkfork+0x5a>
    int pid = fork();
    15c6:	6a5030ef          	jal	ra,546a <fork>
    if (pid < 0) {
    15ca:	02054663          	bltz	a0,15f6 <forkfork+0x46>
    if (pid == 0) {
    15ce:	cd15                	beqz	a0,160a <forkfork+0x5a>
    wait(&xstatus);
    15d0:	fdc40513          	addi	a0,s0,-36
    15d4:	6a7030ef          	jal	ra,547a <wait>
    if (xstatus != 0) {
    15d8:	fdc42783          	lw	a5,-36(s0)
    15dc:	ebb9                	bnez	a5,1632 <forkfork+0x82>
    wait(&xstatus);
    15de:	fdc40513          	addi	a0,s0,-36
    15e2:	699030ef          	jal	ra,547a <wait>
    if (xstatus != 0) {
    15e6:	fdc42783          	lw	a5,-36(s0)
    15ea:	e7a1                	bnez	a5,1632 <forkfork+0x82>
}
    15ec:	70a2                	ld	ra,40(sp)
    15ee:	7402                	ld	s0,32(sp)
    15f0:	64e2                	ld	s1,24(sp)
    15f2:	6145                	addi	sp,sp,48
    15f4:	8082                	ret
      printf("%s: fork failed", s);
    15f6:	85a6                	mv	a1,s1
    15f8:	00005517          	auipc	a0,0x5
    15fc:	e4050513          	addi	a0,a0,-448 # 6438 <malloc+0xaee>
    1600:	296040ef          	jal	ra,5896 <printf>
      exit(1);
    1604:	4505                	li	a0,1
    1606:	66d030ef          	jal	ra,5472 <exit>
{
    160a:	0c800493          	li	s1,200
        int pid1 = fork();
    160e:	65d030ef          	jal	ra,546a <fork>
        if (pid1 < 0) {
    1612:	00054b63          	bltz	a0,1628 <forkfork+0x78>
        if (pid1 == 0) {
    1616:	cd01                	beqz	a0,162e <forkfork+0x7e>
        wait(0);
    1618:	4501                	li	a0,0
    161a:	661030ef          	jal	ra,547a <wait>
      for (int j = 0; j < 200; j++) {
    161e:	34fd                	addiw	s1,s1,-1
    1620:	f4fd                	bnez	s1,160e <forkfork+0x5e>
      exit(0);
    1622:	4501                	li	a0,0
    1624:	64f030ef          	jal	ra,5472 <exit>
          exit(1);
    1628:	4505                	li	a0,1
    162a:	649030ef          	jal	ra,5472 <exit>
          exit(0);
    162e:	645030ef          	jal	ra,5472 <exit>
      printf("%s: fork in child failed", s);
    1632:	85a6                	mv	a1,s1
    1634:	00005517          	auipc	a0,0x5
    1638:	e1450513          	addi	a0,a0,-492 # 6448 <malloc+0xafe>
    163c:	25a040ef          	jal	ra,5896 <printf>
      exit(1);
    1640:	4505                	li	a0,1
    1642:	631030ef          	jal	ra,5472 <exit>

0000000000001646 <reparent2>:
{
    1646:	1101                	addi	sp,sp,-32
    1648:	ec06                	sd	ra,24(sp)
    164a:	e822                	sd	s0,16(sp)
    164c:	e426                	sd	s1,8(sp)
    164e:	1000                	addi	s0,sp,32
    1650:	32000493          	li	s1,800
    int pid1 = fork();
    1654:	617030ef          	jal	ra,546a <fork>
    if (pid1 < 0) {
    1658:	00054b63          	bltz	a0,166e <reparent2+0x28>
    if (pid1 == 0) {
    165c:	c115                	beqz	a0,1680 <reparent2+0x3a>
    wait(0);
    165e:	4501                	li	a0,0
    1660:	61b030ef          	jal	ra,547a <wait>
  for (int i = 0; i < 800; i++) {
    1664:	34fd                	addiw	s1,s1,-1
    1666:	f4fd                	bnez	s1,1654 <reparent2+0xe>
  exit(0);
    1668:	4501                	li	a0,0
    166a:	609030ef          	jal	ra,5472 <exit>
      printf("fork failed\n");
    166e:	00006517          	auipc	a0,0x6
    1672:	37a50513          	addi	a0,a0,890 # 79e8 <malloc+0x209e>
    1676:	220040ef          	jal	ra,5896 <printf>
      exit(1);
    167a:	4505                	li	a0,1
    167c:	5f7030ef          	jal	ra,5472 <exit>
      fork();
    1680:	5eb030ef          	jal	ra,546a <fork>
      fork();
    1684:	5e7030ef          	jal	ra,546a <fork>
      exit(0);
    1688:	4501                	li	a0,0
    168a:	5e9030ef          	jal	ra,5472 <exit>

000000000000168e <createdelete>:
{
    168e:	7175                	addi	sp,sp,-144
    1690:	e506                	sd	ra,136(sp)
    1692:	e122                	sd	s0,128(sp)
    1694:	fca6                	sd	s1,120(sp)
    1696:	f8ca                	sd	s2,112(sp)
    1698:	f4ce                	sd	s3,104(sp)
    169a:	f0d2                	sd	s4,96(sp)
    169c:	ecd6                	sd	s5,88(sp)
    169e:	e8da                	sd	s6,80(sp)
    16a0:	e4de                	sd	s7,72(sp)
    16a2:	e0e2                	sd	s8,64(sp)
    16a4:	fc66                	sd	s9,56(sp)
    16a6:	0900                	addi	s0,sp,144
    16a8:	8caa                	mv	s9,a0
  for (pi = 0; pi < NCHILD; pi++) {
    16aa:	4901                	li	s2,0
    16ac:	4991                	li	s3,4
    pid = fork();
    16ae:	5bd030ef          	jal	ra,546a <fork>
    16b2:	84aa                	mv	s1,a0
    if (pid < 0) {
    16b4:	02054d63          	bltz	a0,16ee <createdelete+0x60>
    if (pid == 0) {
    16b8:	c529                	beqz	a0,1702 <createdelete+0x74>
  for (pi = 0; pi < NCHILD; pi++) {
    16ba:	2905                	addiw	s2,s2,1
    16bc:	ff3919e3          	bne	s2,s3,16ae <createdelete+0x20>
    16c0:	4491                	li	s1,4
    wait(&xstatus);
    16c2:	f7c40513          	addi	a0,s0,-132
    16c6:	5b5030ef          	jal	ra,547a <wait>
    if (xstatus != 0)
    16ca:	f7c42903          	lw	s2,-132(s0)
    16ce:	0a091e63          	bnez	s2,178a <createdelete+0xfc>
  for (pi = 0; pi < NCHILD; pi++) {
    16d2:	34fd                	addiw	s1,s1,-1
    16d4:	f4fd                	bnez	s1,16c2 <createdelete+0x34>
  name[0] = name[1] = name[2] = 0;
    16d6:	f8040123          	sb	zero,-126(s0)
    16da:	03000993          	li	s3,48
    16de:	5a7d                	li	s4,-1
    16e0:	07000c13          	li	s8,112
      } else if ((i >= 1 && i < N / 2) && fd >= 0) {
    16e4:	4b21                	li	s6,8
      if ((i == 0 || i >= N / 2) && fd < 0) {
    16e6:	4ba5                	li	s7,9
    for (pi = 0; pi < NCHILD; pi++) {
    16e8:	07400a93          	li	s5,116
    16ec:	a20d                	j	180e <createdelete+0x180>
      printf("%s: fork failed\n", s);
    16ee:	85e6                	mv	a1,s9
    16f0:	00005517          	auipc	a0,0x5
    16f4:	c0850513          	addi	a0,a0,-1016 # 62f8 <malloc+0x9ae>
    16f8:	19e040ef          	jal	ra,5896 <printf>
      exit(1);
    16fc:	4505                	li	a0,1
    16fe:	575030ef          	jal	ra,5472 <exit>
      name[0] = 'p' + pi;
    1702:	0709091b          	addiw	s2,s2,112
    1706:	f9240023          	sb	s2,-128(s0)
      name[2] = '\0';
    170a:	f8040123          	sb	zero,-126(s0)
      for (i = 0; i < N; i++) {
    170e:	4951                	li	s2,20
    1710:	a831                	j	172c <createdelete+0x9e>
          printf("%s: create failed\n", s);
    1712:	85e6                	mv	a1,s9
    1714:	00005517          	auipc	a0,0x5
    1718:	d5450513          	addi	a0,a0,-684 # 6468 <malloc+0xb1e>
    171c:	17a040ef          	jal	ra,5896 <printf>
          exit(1);
    1720:	4505                	li	a0,1
    1722:	551030ef          	jal	ra,5472 <exit>
      for (i = 0; i < N; i++) {
    1726:	2485                	addiw	s1,s1,1
    1728:	05248e63          	beq	s1,s2,1784 <createdelete+0xf6>
        name[1] = '0' + i;
    172c:	0304879b          	addiw	a5,s1,48
    1730:	f8f400a3          	sb	a5,-127(s0)
        fd = open(name, O_CREATE | O_RDWR);
    1734:	20200593          	li	a1,514
    1738:	f8040513          	addi	a0,s0,-128
    173c:	577030ef          	jal	ra,54b2 <open>
        if (fd < 0) {
    1740:	fc0549e3          	bltz	a0,1712 <createdelete+0x84>
        close(fd);
    1744:	557030ef          	jal	ra,549a <close>
        if (i > 0 && (i % 2) == 0) {
    1748:	fc905fe3          	blez	s1,1726 <createdelete+0x98>
    174c:	0014f793          	andi	a5,s1,1
    1750:	fbf9                	bnez	a5,1726 <createdelete+0x98>
          name[1] = '0' + (i / 2);
    1752:	01f4d79b          	srliw	a5,s1,0x1f
    1756:	9fa5                	addw	a5,a5,s1
    1758:	4017d79b          	sraiw	a5,a5,0x1
    175c:	0307879b          	addiw	a5,a5,48
    1760:	f8f400a3          	sb	a5,-127(s0)
          if (unlink(name) < 0) {
    1764:	f8040513          	addi	a0,s0,-128
    1768:	55b030ef          	jal	ra,54c2 <unlink>
    176c:	fa055de3          	bgez	a0,1726 <createdelete+0x98>
            printf("%s: unlink failed\n", s);
    1770:	85e6                	mv	a1,s9
    1772:	00005517          	auipc	a0,0x5
    1776:	d0e50513          	addi	a0,a0,-754 # 6480 <malloc+0xb36>
    177a:	11c040ef          	jal	ra,5896 <printf>
            exit(1);
    177e:	4505                	li	a0,1
    1780:	4f3030ef          	jal	ra,5472 <exit>
      exit(0);
    1784:	4501                	li	a0,0
    1786:	4ed030ef          	jal	ra,5472 <exit>
      exit(1);
    178a:	4505                	li	a0,1
    178c:	4e7030ef          	jal	ra,5472 <exit>
        printf("%s: oops createdelete %s didn't exist\n", s, name);
    1790:	f8040613          	addi	a2,s0,-128
    1794:	85e6                	mv	a1,s9
    1796:	00005517          	auipc	a0,0x5
    179a:	d0250513          	addi	a0,a0,-766 # 6498 <malloc+0xb4e>
    179e:	0f8040ef          	jal	ra,5896 <printf>
        exit(1);
    17a2:	4505                	li	a0,1
    17a4:	4cf030ef          	jal	ra,5472 <exit>
      } else if ((i >= 1 && i < N / 2) && fd >= 0) {
    17a8:	034b7d63          	bgeu	s6,s4,17e2 <createdelete+0x154>
      if (fd >= 0)
    17ac:	02055863          	bgez	a0,17dc <createdelete+0x14e>
    for (pi = 0; pi < NCHILD; pi++) {
    17b0:	2485                	addiw	s1,s1,1
    17b2:	0ff4f493          	zext.b	s1,s1
    17b6:	05548463          	beq	s1,s5,17fe <createdelete+0x170>
      name[0] = 'p' + pi;
    17ba:	f8940023          	sb	s1,-128(s0)
      name[1] = '0' + i;
    17be:	f93400a3          	sb	s3,-127(s0)
      fd = open(name, 0);
    17c2:	4581                	li	a1,0
    17c4:	f8040513          	addi	a0,s0,-128
    17c8:	4eb030ef          	jal	ra,54b2 <open>
      if ((i == 0 || i >= N / 2) && fd < 0) {
    17cc:	00090463          	beqz	s2,17d4 <createdelete+0x146>
    17d0:	fd2bdce3          	bge	s7,s2,17a8 <createdelete+0x11a>
    17d4:	fa054ee3          	bltz	a0,1790 <createdelete+0x102>
      } else if ((i >= 1 && i < N / 2) && fd >= 0) {
    17d8:	014b7763          	bgeu	s6,s4,17e6 <createdelete+0x158>
        close(fd);
    17dc:	4bf030ef          	jal	ra,549a <close>
    17e0:	bfc1                	j	17b0 <createdelete+0x122>
      } else if ((i >= 1 && i < N / 2) && fd >= 0) {
    17e2:	fc0547e3          	bltz	a0,17b0 <createdelete+0x122>
        printf("%s: oops createdelete %s did exist\n", s, name);
    17e6:	f8040613          	addi	a2,s0,-128
    17ea:	85e6                	mv	a1,s9
    17ec:	00005517          	auipc	a0,0x5
    17f0:	cd450513          	addi	a0,a0,-812 # 64c0 <malloc+0xb76>
    17f4:	0a2040ef          	jal	ra,5896 <printf>
        exit(1);
    17f8:	4505                	li	a0,1
    17fa:	479030ef          	jal	ra,5472 <exit>
  for (i = 0; i < N; i++) {
    17fe:	2905                	addiw	s2,s2,1
    1800:	2a05                	addiw	s4,s4,1
    1802:	2985                	addiw	s3,s3,1
    1804:	0ff9f993          	zext.b	s3,s3
    1808:	47d1                	li	a5,20
    180a:	02f90863          	beq	s2,a5,183a <createdelete+0x1ac>
    for (pi = 0; pi < NCHILD; pi++) {
    180e:	84e2                	mv	s1,s8
    1810:	b76d                	j	17ba <createdelete+0x12c>
  for (i = 0; i < N; i++) {
    1812:	2905                	addiw	s2,s2,1
    1814:	0ff97913          	zext.b	s2,s2
    1818:	03490a63          	beq	s2,s4,184c <createdelete+0x1be>
  name[0] = name[1] = name[2] = 0;
    181c:	84d6                	mv	s1,s5
      name[0] = 'p' + pi;
    181e:	f8940023          	sb	s1,-128(s0)
      name[1] = '0' + i;
    1822:	f92400a3          	sb	s2,-127(s0)
      unlink(name);
    1826:	f8040513          	addi	a0,s0,-128
    182a:	499030ef          	jal	ra,54c2 <unlink>
    for (pi = 0; pi < NCHILD; pi++) {
    182e:	2485                	addiw	s1,s1,1
    1830:	0ff4f493          	zext.b	s1,s1
    1834:	ff3495e3          	bne	s1,s3,181e <createdelete+0x190>
    1838:	bfe9                	j	1812 <createdelete+0x184>
    183a:	03000913          	li	s2,48
  name[0] = name[1] = name[2] = 0;
    183e:	07000a93          	li	s5,112
    for (pi = 0; pi < NCHILD; pi++) {
    1842:	07400993          	li	s3,116
  for (i = 0; i < N; i++) {
    1846:	04400a13          	li	s4,68
    184a:	bfc9                	j	181c <createdelete+0x18e>
}
    184c:	60aa                	ld	ra,136(sp)
    184e:	640a                	ld	s0,128(sp)
    1850:	74e6                	ld	s1,120(sp)
    1852:	7946                	ld	s2,112(sp)
    1854:	79a6                	ld	s3,104(sp)
    1856:	7a06                	ld	s4,96(sp)
    1858:	6ae6                	ld	s5,88(sp)
    185a:	6b46                	ld	s6,80(sp)
    185c:	6ba6                	ld	s7,72(sp)
    185e:	6c06                	ld	s8,64(sp)
    1860:	7ce2                	ld	s9,56(sp)
    1862:	6149                	addi	sp,sp,144
    1864:	8082                	ret

0000000000001866 <linkunlink>:
{
    1866:	711d                	addi	sp,sp,-96
    1868:	ec86                	sd	ra,88(sp)
    186a:	e8a2                	sd	s0,80(sp)
    186c:	e4a6                	sd	s1,72(sp)
    186e:	e0ca                	sd	s2,64(sp)
    1870:	fc4e                	sd	s3,56(sp)
    1872:	f852                	sd	s4,48(sp)
    1874:	f456                	sd	s5,40(sp)
    1876:	f05a                	sd	s6,32(sp)
    1878:	ec5e                	sd	s7,24(sp)
    187a:	e862                	sd	s8,16(sp)
    187c:	e466                	sd	s9,8(sp)
    187e:	1080                	addi	s0,sp,96
    1880:	84aa                	mv	s1,a0
  unlink("x");
    1882:	00004517          	auipc	a0,0x4
    1886:	25650513          	addi	a0,a0,598 # 5ad8 <malloc+0x18e>
    188a:	439030ef          	jal	ra,54c2 <unlink>
  pid = fork();
    188e:	3dd030ef          	jal	ra,546a <fork>
  if (pid < 0) {
    1892:	02054b63          	bltz	a0,18c8 <linkunlink+0x62>
    1896:	8c2a                	mv	s8,a0
  unsigned int x = (pid ? 1 : 97);
    1898:	4c85                	li	s9,1
    189a:	e119                	bnez	a0,18a0 <linkunlink+0x3a>
    189c:	06100c93          	li	s9,97
    18a0:	06400493          	li	s1,100
    x = x * 1103515245 + 12345;
    18a4:	41c659b7          	lui	s3,0x41c65
    18a8:	e6d9899b          	addiw	s3,s3,-403 # 41c64e6d <base+0x41c55175>
    18ac:	690d                	lui	s2,0x3
    18ae:	0399091b          	addiw	s2,s2,57 # 3039 <rmdot+0x51>
    if ((x % 3) == 0) {
    18b2:	4a0d                	li	s4,3
    } else if ((x % 3) == 1) {
    18b4:	4b05                	li	s6,1
      unlink("x");
    18b6:	00004a97          	auipc	s5,0x4
    18ba:	222a8a93          	addi	s5,s5,546 # 5ad8 <malloc+0x18e>
      link("cat", "x");
    18be:	00005b97          	auipc	s7,0x5
    18c2:	c2ab8b93          	addi	s7,s7,-982 # 64e8 <malloc+0xb9e>
    18c6:	a025                	j	18ee <linkunlink+0x88>
    printf("%s: fork failed\n", s);
    18c8:	85a6                	mv	a1,s1
    18ca:	00005517          	auipc	a0,0x5
    18ce:	a2e50513          	addi	a0,a0,-1490 # 62f8 <malloc+0x9ae>
    18d2:	7c5030ef          	jal	ra,5896 <printf>
    exit(1);
    18d6:	4505                	li	a0,1
    18d8:	39b030ef          	jal	ra,5472 <exit>
      close(open("x", O_RDWR | O_CREATE));
    18dc:	20200593          	li	a1,514
    18e0:	8556                	mv	a0,s5
    18e2:	3d1030ef          	jal	ra,54b2 <open>
    18e6:	3b5030ef          	jal	ra,549a <close>
  for (i = 0; i < 100; i++) {
    18ea:	34fd                	addiw	s1,s1,-1
    18ec:	c48d                	beqz	s1,1916 <linkunlink+0xb0>
    x = x * 1103515245 + 12345;
    18ee:	033c87bb          	mulw	a5,s9,s3
    18f2:	012787bb          	addw	a5,a5,s2
    18f6:	00078c9b          	sext.w	s9,a5
    if ((x % 3) == 0) {
    18fa:	0347f7bb          	remuw	a5,a5,s4
    18fe:	dff9                	beqz	a5,18dc <linkunlink+0x76>
    } else if ((x % 3) == 1) {
    1900:	01678663          	beq	a5,s6,190c <linkunlink+0xa6>
      unlink("x");
    1904:	8556                	mv	a0,s5
    1906:	3bd030ef          	jal	ra,54c2 <unlink>
    190a:	b7c5                	j	18ea <linkunlink+0x84>
      link("cat", "x");
    190c:	85d6                	mv	a1,s5
    190e:	855e                	mv	a0,s7
    1910:	3c3030ef          	jal	ra,54d2 <link>
    1914:	bfd9                	j	18ea <linkunlink+0x84>
  if (pid)
    1916:	020c0263          	beqz	s8,193a <linkunlink+0xd4>
    wait(0);
    191a:	4501                	li	a0,0
    191c:	35f030ef          	jal	ra,547a <wait>
}
    1920:	60e6                	ld	ra,88(sp)
    1922:	6446                	ld	s0,80(sp)
    1924:	64a6                	ld	s1,72(sp)
    1926:	6906                	ld	s2,64(sp)
    1928:	79e2                	ld	s3,56(sp)
    192a:	7a42                	ld	s4,48(sp)
    192c:	7aa2                	ld	s5,40(sp)
    192e:	7b02                	ld	s6,32(sp)
    1930:	6be2                	ld	s7,24(sp)
    1932:	6c42                	ld	s8,16(sp)
    1934:	6ca2                	ld	s9,8(sp)
    1936:	6125                	addi	sp,sp,96
    1938:	8082                	ret
    exit(0);
    193a:	4501                	li	a0,0
    193c:	337030ef          	jal	ra,5472 <exit>

0000000000001940 <forktest>:
{
    1940:	7179                	addi	sp,sp,-48
    1942:	f406                	sd	ra,40(sp)
    1944:	f022                	sd	s0,32(sp)
    1946:	ec26                	sd	s1,24(sp)
    1948:	e84a                	sd	s2,16(sp)
    194a:	e44e                	sd	s3,8(sp)
    194c:	1800                	addi	s0,sp,48
    194e:	89aa                	mv	s3,a0
  for (n = 0; n < N; n++) {
    1950:	4481                	li	s1,0
    1952:	3e800913          	li	s2,1000
    pid = fork();
    1956:	315030ef          	jal	ra,546a <fork>
    if (pid < 0)
    195a:	02054263          	bltz	a0,197e <forktest+0x3e>
    if (pid == 0)
    195e:	cd11                	beqz	a0,197a <forktest+0x3a>
  for (n = 0; n < N; n++) {
    1960:	2485                	addiw	s1,s1,1
    1962:	ff249ae3          	bne	s1,s2,1956 <forktest+0x16>
    printf("%s: fork claimed to work 1000 times!\n", s);
    1966:	85ce                	mv	a1,s3
    1968:	00005517          	auipc	a0,0x5
    196c:	ba050513          	addi	a0,a0,-1120 # 6508 <malloc+0xbbe>
    1970:	727030ef          	jal	ra,5896 <printf>
    exit(1);
    1974:	4505                	li	a0,1
    1976:	2fd030ef          	jal	ra,5472 <exit>
      exit(0);
    197a:	2f9030ef          	jal	ra,5472 <exit>
  if (n == 0) {
    197e:	c89d                	beqz	s1,19b4 <forktest+0x74>
  if (n == N) {
    1980:	3e800793          	li	a5,1000
    1984:	fef481e3          	beq	s1,a5,1966 <forktest+0x26>
  for (; n > 0; n--) {
    1988:	00905963          	blez	s1,199a <forktest+0x5a>
    if (wait(0) < 0) {
    198c:	4501                	li	a0,0
    198e:	2ed030ef          	jal	ra,547a <wait>
    1992:	02054b63          	bltz	a0,19c8 <forktest+0x88>
  for (; n > 0; n--) {
    1996:	34fd                	addiw	s1,s1,-1
    1998:	f8f5                	bnez	s1,198c <forktest+0x4c>
  if (wait(0) != -1) {
    199a:	4501                	li	a0,0
    199c:	2df030ef          	jal	ra,547a <wait>
    19a0:	57fd                	li	a5,-1
    19a2:	02f51d63          	bne	a0,a5,19dc <forktest+0x9c>
}
    19a6:	70a2                	ld	ra,40(sp)
    19a8:	7402                	ld	s0,32(sp)
    19aa:	64e2                	ld	s1,24(sp)
    19ac:	6942                	ld	s2,16(sp)
    19ae:	69a2                	ld	s3,8(sp)
    19b0:	6145                	addi	sp,sp,48
    19b2:	8082                	ret
    printf("%s: no fork at all!\n", s);
    19b4:	85ce                	mv	a1,s3
    19b6:	00005517          	auipc	a0,0x5
    19ba:	b3a50513          	addi	a0,a0,-1222 # 64f0 <malloc+0xba6>
    19be:	6d9030ef          	jal	ra,5896 <printf>
    exit(1);
    19c2:	4505                	li	a0,1
    19c4:	2af030ef          	jal	ra,5472 <exit>
      printf("%s: wait stopped early\n", s);
    19c8:	85ce                	mv	a1,s3
    19ca:	00005517          	auipc	a0,0x5
    19ce:	b6650513          	addi	a0,a0,-1178 # 6530 <malloc+0xbe6>
    19d2:	6c5030ef          	jal	ra,5896 <printf>
      exit(1);
    19d6:	4505                	li	a0,1
    19d8:	29b030ef          	jal	ra,5472 <exit>
    printf("%s: wait got too many\n", s);
    19dc:	85ce                	mv	a1,s3
    19de:	00005517          	auipc	a0,0x5
    19e2:	b6a50513          	addi	a0,a0,-1174 # 6548 <malloc+0xbfe>
    19e6:	6b1030ef          	jal	ra,5896 <printf>
    exit(1);
    19ea:	4505                	li	a0,1
    19ec:	287030ef          	jal	ra,5472 <exit>

00000000000019f0 <kernmem>:
{
    19f0:	715d                	addi	sp,sp,-80
    19f2:	e486                	sd	ra,72(sp)
    19f4:	e0a2                	sd	s0,64(sp)
    19f6:	fc26                	sd	s1,56(sp)
    19f8:	f84a                	sd	s2,48(sp)
    19fa:	f44e                	sd	s3,40(sp)
    19fc:	f052                	sd	s4,32(sp)
    19fe:	ec56                	sd	s5,24(sp)
    1a00:	0880                	addi	s0,sp,80
    1a02:	8a2a                	mv	s4,a0
  for (a = (char *)(KERNBASE); a < (char *)(KERNBASE + 2000000); a += 50000) {
    1a04:	4485                	li	s1,1
    1a06:	04fe                	slli	s1,s1,0x1f
    if (xstatus != -1) // did kernel kill child?
    1a08:	5afd                	li	s5,-1
  for (a = (char *)(KERNBASE); a < (char *)(KERNBASE + 2000000); a += 50000) {
    1a0a:	69b1                	lui	s3,0xc
    1a0c:	35098993          	addi	s3,s3,848 # c350 <uninit+0x1d68>
    1a10:	1003d937          	lui	s2,0x1003d
    1a14:	090e                	slli	s2,s2,0x3
    1a16:	48090913          	addi	s2,s2,1152 # 1003d480 <base+0x1002d788>
    pid = fork();
    1a1a:	251030ef          	jal	ra,546a <fork>
    if (pid < 0) {
    1a1e:	02054763          	bltz	a0,1a4c <kernmem+0x5c>
    if (pid == 0) {
    1a22:	cd1d                	beqz	a0,1a60 <kernmem+0x70>
    wait(&xstatus);
    1a24:	fbc40513          	addi	a0,s0,-68
    1a28:	253030ef          	jal	ra,547a <wait>
    if (xstatus != -1) // did kernel kill child?
    1a2c:	fbc42783          	lw	a5,-68(s0)
    1a30:	05579563          	bne	a5,s5,1a7a <kernmem+0x8a>
  for (a = (char *)(KERNBASE); a < (char *)(KERNBASE + 2000000); a += 50000) {
    1a34:	94ce                	add	s1,s1,s3
    1a36:	ff2492e3          	bne	s1,s2,1a1a <kernmem+0x2a>
}
    1a3a:	60a6                	ld	ra,72(sp)
    1a3c:	6406                	ld	s0,64(sp)
    1a3e:	74e2                	ld	s1,56(sp)
    1a40:	7942                	ld	s2,48(sp)
    1a42:	79a2                	ld	s3,40(sp)
    1a44:	7a02                	ld	s4,32(sp)
    1a46:	6ae2                	ld	s5,24(sp)
    1a48:	6161                	addi	sp,sp,80
    1a4a:	8082                	ret
      printf("%s: fork failed\n", s);
    1a4c:	85d2                	mv	a1,s4
    1a4e:	00005517          	auipc	a0,0x5
    1a52:	8aa50513          	addi	a0,a0,-1878 # 62f8 <malloc+0x9ae>
    1a56:	641030ef          	jal	ra,5896 <printf>
      exit(1);
    1a5a:	4505                	li	a0,1
    1a5c:	217030ef          	jal	ra,5472 <exit>
      printf("%s: oops could read %p = %x\n", s, a, *a);
    1a60:	0004c683          	lbu	a3,0(s1)
    1a64:	8626                	mv	a2,s1
    1a66:	85d2                	mv	a1,s4
    1a68:	00005517          	auipc	a0,0x5
    1a6c:	af850513          	addi	a0,a0,-1288 # 6560 <malloc+0xc16>
    1a70:	627030ef          	jal	ra,5896 <printf>
      exit(1);
    1a74:	4505                	li	a0,1
    1a76:	1fd030ef          	jal	ra,5472 <exit>
      exit(1);
    1a7a:	4505                	li	a0,1
    1a7c:	1f7030ef          	jal	ra,5472 <exit>

0000000000001a80 <MAXVAplus>:
{
    1a80:	7179                	addi	sp,sp,-48
    1a82:	f406                	sd	ra,40(sp)
    1a84:	f022                	sd	s0,32(sp)
    1a86:	ec26                	sd	s1,24(sp)
    1a88:	e84a                	sd	s2,16(sp)
    1a8a:	1800                	addi	s0,sp,48
  volatile uint64 a = MAXVA;
    1a8c:	4785                	li	a5,1
    1a8e:	179a                	slli	a5,a5,0x26
    1a90:	fcf43c23          	sd	a5,-40(s0)
  for (; a != 0; a <<= 1) {
    1a94:	fd843783          	ld	a5,-40(s0)
    1a98:	cb85                	beqz	a5,1ac8 <MAXVAplus+0x48>
    1a9a:	892a                	mv	s2,a0
    if (xstatus != -1) // did kernel kill child?
    1a9c:	54fd                	li	s1,-1
    pid = fork();
    1a9e:	1cd030ef          	jal	ra,546a <fork>
    if (pid < 0) {
    1aa2:	02054963          	bltz	a0,1ad4 <MAXVAplus+0x54>
    if (pid == 0) {
    1aa6:	c129                	beqz	a0,1ae8 <MAXVAplus+0x68>
    wait(&xstatus);
    1aa8:	fd440513          	addi	a0,s0,-44
    1aac:	1cf030ef          	jal	ra,547a <wait>
    if (xstatus != -1) // did kernel kill child?
    1ab0:	fd442783          	lw	a5,-44(s0)
    1ab4:	04979c63          	bne	a5,s1,1b0c <MAXVAplus+0x8c>
  for (; a != 0; a <<= 1) {
    1ab8:	fd843783          	ld	a5,-40(s0)
    1abc:	0786                	slli	a5,a5,0x1
    1abe:	fcf43c23          	sd	a5,-40(s0)
    1ac2:	fd843783          	ld	a5,-40(s0)
    1ac6:	ffe1                	bnez	a5,1a9e <MAXVAplus+0x1e>
}
    1ac8:	70a2                	ld	ra,40(sp)
    1aca:	7402                	ld	s0,32(sp)
    1acc:	64e2                	ld	s1,24(sp)
    1ace:	6942                	ld	s2,16(sp)
    1ad0:	6145                	addi	sp,sp,48
    1ad2:	8082                	ret
      printf("%s: fork failed\n", s);
    1ad4:	85ca                	mv	a1,s2
    1ad6:	00005517          	auipc	a0,0x5
    1ada:	82250513          	addi	a0,a0,-2014 # 62f8 <malloc+0x9ae>
    1ade:	5b9030ef          	jal	ra,5896 <printf>
      exit(1);
    1ae2:	4505                	li	a0,1
    1ae4:	18f030ef          	jal	ra,5472 <exit>
      *(char *)a = 99;
    1ae8:	fd843783          	ld	a5,-40(s0)
    1aec:	06300713          	li	a4,99
    1af0:	00e78023          	sb	a4,0(a5)
      printf("%s: oops wrote %p\n", s, (void *)a);
    1af4:	fd843603          	ld	a2,-40(s0)
    1af8:	85ca                	mv	a1,s2
    1afa:	00005517          	auipc	a0,0x5
    1afe:	a8650513          	addi	a0,a0,-1402 # 6580 <malloc+0xc36>
    1b02:	595030ef          	jal	ra,5896 <printf>
      exit(1);
    1b06:	4505                	li	a0,1
    1b08:	16b030ef          	jal	ra,5472 <exit>
      exit(1);
    1b0c:	4505                	li	a0,1
    1b0e:	165030ef          	jal	ra,5472 <exit>

0000000000001b12 <stacktest>:
{
    1b12:	7179                	addi	sp,sp,-48
    1b14:	f406                	sd	ra,40(sp)
    1b16:	f022                	sd	s0,32(sp)
    1b18:	ec26                	sd	s1,24(sp)
    1b1a:	1800                	addi	s0,sp,48
    1b1c:	84aa                	mv	s1,a0
  pid = fork();
    1b1e:	14d030ef          	jal	ra,546a <fork>
  if (pid == 0) {
    1b22:	cd11                	beqz	a0,1b3e <stacktest+0x2c>
  } else if (pid < 0) {
    1b24:	02054c63          	bltz	a0,1b5c <stacktest+0x4a>
  wait(&xstatus);
    1b28:	fdc40513          	addi	a0,s0,-36
    1b2c:	14f030ef          	jal	ra,547a <wait>
  if (xstatus == -1) // kernel killed child?
    1b30:	fdc42503          	lw	a0,-36(s0)
    1b34:	57fd                	li	a5,-1
    1b36:	02f50d63          	beq	a0,a5,1b70 <stacktest+0x5e>
    exit(xstatus);
    1b3a:	139030ef          	jal	ra,5472 <exit>

static inline uint64
r_sp()
{
  uint64 x;
  asm volatile("mv %0, sp" : "=r"(x));
    1b3e:	870a                	mv	a4,sp
    printf("%s: stacktest: read below stack %d\n", s, *sp);
    1b40:	77fd                	lui	a5,0xfffff
    1b42:	97ba                	add	a5,a5,a4
    1b44:	0007c603          	lbu	a2,0(a5) # fffffffffffff000 <base+0xfffffffffffef308>
    1b48:	85a6                	mv	a1,s1
    1b4a:	00005517          	auipc	a0,0x5
    1b4e:	a4e50513          	addi	a0,a0,-1458 # 6598 <malloc+0xc4e>
    1b52:	545030ef          	jal	ra,5896 <printf>
    exit(1);
    1b56:	4505                	li	a0,1
    1b58:	11b030ef          	jal	ra,5472 <exit>
    printf("%s: fork failed\n", s);
    1b5c:	85a6                	mv	a1,s1
    1b5e:	00004517          	auipc	a0,0x4
    1b62:	79a50513          	addi	a0,a0,1946 # 62f8 <malloc+0x9ae>
    1b66:	531030ef          	jal	ra,5896 <printf>
    exit(1);
    1b6a:	4505                	li	a0,1
    1b6c:	107030ef          	jal	ra,5472 <exit>
    exit(0);
    1b70:	4501                	li	a0,0
    1b72:	101030ef          	jal	ra,5472 <exit>

0000000000001b76 <nowrite>:
{
    1b76:	7159                	addi	sp,sp,-112
    1b78:	f486                	sd	ra,104(sp)
    1b7a:	f0a2                	sd	s0,96(sp)
    1b7c:	eca6                	sd	s1,88(sp)
    1b7e:	e8ca                	sd	s2,80(sp)
    1b80:	e4ce                	sd	s3,72(sp)
    1b82:	1880                	addi	s0,sp,112
    1b84:	89aa                	mv	s3,a0
  uint64 addrs[] = {0,
    1b86:	00006797          	auipc	a5,0x6
    1b8a:	7d278793          	addi	a5,a5,2002 # 8358 <malloc+0x2a0e>
    1b8e:	7788                	ld	a0,40(a5)
    1b90:	7b8c                	ld	a1,48(a5)
    1b92:	7f90                	ld	a2,56(a5)
    1b94:	63b4                	ld	a3,64(a5)
    1b96:	67b8                	ld	a4,72(a5)
    1b98:	6bbc                	ld	a5,80(a5)
    1b9a:	f8a43c23          	sd	a0,-104(s0)
    1b9e:	fab43023          	sd	a1,-96(s0)
    1ba2:	fac43423          	sd	a2,-88(s0)
    1ba6:	fad43823          	sd	a3,-80(s0)
    1baa:	fae43c23          	sd	a4,-72(s0)
    1bae:	fcf43023          	sd	a5,-64(s0)
  for (int ai = 0; ai < sizeof(addrs) / sizeof(addrs[0]); ai++) {
    1bb2:	4481                	li	s1,0
    1bb4:	4919                	li	s2,6
    pid = fork();
    1bb6:	0b5030ef          	jal	ra,546a <fork>
    if (pid == 0) {
    1bba:	c105                	beqz	a0,1bda <nowrite+0x64>
    } else if (pid < 0) {
    1bbc:	04054263          	bltz	a0,1c00 <nowrite+0x8a>
    wait(&xstatus);
    1bc0:	fcc40513          	addi	a0,s0,-52
    1bc4:	0b7030ef          	jal	ra,547a <wait>
    if (xstatus == 0) {
    1bc8:	fcc42783          	lw	a5,-52(s0)
    1bcc:	c7a1                	beqz	a5,1c14 <nowrite+0x9e>
  for (int ai = 0; ai < sizeof(addrs) / sizeof(addrs[0]); ai++) {
    1bce:	2485                	addiw	s1,s1,1
    1bd0:	ff2493e3          	bne	s1,s2,1bb6 <nowrite+0x40>
  exit(0);
    1bd4:	4501                	li	a0,0
    1bd6:	09d030ef          	jal	ra,5472 <exit>
      volatile int *addr = (int *)addrs[ai];
    1bda:	048e                	slli	s1,s1,0x3
    1bdc:	fd048793          	addi	a5,s1,-48
    1be0:	008784b3          	add	s1,a5,s0
    1be4:	fc84b603          	ld	a2,-56(s1)
      *addr = 10;
    1be8:	47a9                	li	a5,10
    1bea:	c21c                	sw	a5,0(a2)
      printf("%s: write to %p did not fail!\n", s, addr);
    1bec:	85ce                	mv	a1,s3
    1bee:	00005517          	auipc	a0,0x5
    1bf2:	9d250513          	addi	a0,a0,-1582 # 65c0 <malloc+0xc76>
    1bf6:	4a1030ef          	jal	ra,5896 <printf>
      exit(0);
    1bfa:	4501                	li	a0,0
    1bfc:	077030ef          	jal	ra,5472 <exit>
      printf("%s: fork failed\n", s);
    1c00:	85ce                	mv	a1,s3
    1c02:	00004517          	auipc	a0,0x4
    1c06:	6f650513          	addi	a0,a0,1782 # 62f8 <malloc+0x9ae>
    1c0a:	48d030ef          	jal	ra,5896 <printf>
      exit(1);
    1c0e:	4505                	li	a0,1
    1c10:	063030ef          	jal	ra,5472 <exit>
      exit(1);
    1c14:	4505                	li	a0,1
    1c16:	05d030ef          	jal	ra,5472 <exit>

0000000000001c1a <manywrites>:
{
    1c1a:	711d                	addi	sp,sp,-96
    1c1c:	ec86                	sd	ra,88(sp)
    1c1e:	e8a2                	sd	s0,80(sp)
    1c20:	e4a6                	sd	s1,72(sp)
    1c22:	e0ca                	sd	s2,64(sp)
    1c24:	fc4e                	sd	s3,56(sp)
    1c26:	f852                	sd	s4,48(sp)
    1c28:	f456                	sd	s5,40(sp)
    1c2a:	f05a                	sd	s6,32(sp)
    1c2c:	ec5e                	sd	s7,24(sp)
    1c2e:	1080                	addi	s0,sp,96
    1c30:	8aaa                	mv	s5,a0
  for (int ci = 0; ci < nchildren; ci++) {
    1c32:	4981                	li	s3,0
    1c34:	4911                	li	s2,4
    int pid = fork();
    1c36:	035030ef          	jal	ra,546a <fork>
    1c3a:	84aa                	mv	s1,a0
    if (pid < 0) {
    1c3c:	02054563          	bltz	a0,1c66 <manywrites+0x4c>
    if (pid == 0) {
    1c40:	cd05                	beqz	a0,1c78 <manywrites+0x5e>
  for (int ci = 0; ci < nchildren; ci++) {
    1c42:	2985                	addiw	s3,s3,1
    1c44:	ff2999e3          	bne	s3,s2,1c36 <manywrites+0x1c>
    1c48:	4491                	li	s1,4
    int st = 0;
    1c4a:	fa042423          	sw	zero,-88(s0)
    wait(&st);
    1c4e:	fa840513          	addi	a0,s0,-88
    1c52:	029030ef          	jal	ra,547a <wait>
    if (st != 0)
    1c56:	fa842503          	lw	a0,-88(s0)
    1c5a:	e169                	bnez	a0,1d1c <manywrites+0x102>
  for (int ci = 0; ci < nchildren; ci++) {
    1c5c:	34fd                	addiw	s1,s1,-1
    1c5e:	f4f5                	bnez	s1,1c4a <manywrites+0x30>
  exit(0);
    1c60:	4501                	li	a0,0
    1c62:	011030ef          	jal	ra,5472 <exit>
      printf("fork failed\n");
    1c66:	00006517          	auipc	a0,0x6
    1c6a:	d8250513          	addi	a0,a0,-638 # 79e8 <malloc+0x209e>
    1c6e:	429030ef          	jal	ra,5896 <printf>
      exit(1);
    1c72:	4505                	li	a0,1
    1c74:	7fe030ef          	jal	ra,5472 <exit>
      name[0] = 'b';
    1c78:	06200793          	li	a5,98
    1c7c:	faf40423          	sb	a5,-88(s0)
      name[1] = 'a' + ci;
    1c80:	0619879b          	addiw	a5,s3,97
    1c84:	faf404a3          	sb	a5,-87(s0)
      name[2] = '\0';
    1c88:	fa040523          	sb	zero,-86(s0)
      unlink(name);
    1c8c:	fa840513          	addi	a0,s0,-88
    1c90:	033030ef          	jal	ra,54c2 <unlink>
    1c94:	4bf9                	li	s7,30
          int cc = write(fd, buf, sz);
    1c96:	0000bb17          	auipc	s6,0xb
    1c9a:	062b0b13          	addi	s6,s6,98 # ccf8 <buf>
        for (int i = 0; i < ci + 1; i++) {
    1c9e:	8a26                	mv	s4,s1
    1ca0:	0209c863          	bltz	s3,1cd0 <manywrites+0xb6>
          int fd = open(name, O_CREATE | O_RDWR);
    1ca4:	20200593          	li	a1,514
    1ca8:	fa840513          	addi	a0,s0,-88
    1cac:	007030ef          	jal	ra,54b2 <open>
    1cb0:	892a                	mv	s2,a0
          if (fd < 0) {
    1cb2:	02054d63          	bltz	a0,1cec <manywrites+0xd2>
          int cc = write(fd, buf, sz);
    1cb6:	660d                	lui	a2,0x3
    1cb8:	85da                	mv	a1,s6
    1cba:	7d8030ef          	jal	ra,5492 <write>
          if (cc != sz) {
    1cbe:	678d                	lui	a5,0x3
    1cc0:	04f51263          	bne	a0,a5,1d04 <manywrites+0xea>
          close(fd);
    1cc4:	854a                	mv	a0,s2
    1cc6:	7d4030ef          	jal	ra,549a <close>
        for (int i = 0; i < ci + 1; i++) {
    1cca:	2a05                	addiw	s4,s4,1
    1ccc:	fd49dce3          	bge	s3,s4,1ca4 <manywrites+0x8a>
        unlink(name);
    1cd0:	fa840513          	addi	a0,s0,-88
    1cd4:	7ee030ef          	jal	ra,54c2 <unlink>
      for (int iters = 0; iters < howmany; iters++) {
    1cd8:	3bfd                	addiw	s7,s7,-1
    1cda:	fc0b92e3          	bnez	s7,1c9e <manywrites+0x84>
      unlink(name);
    1cde:	fa840513          	addi	a0,s0,-88
    1ce2:	7e0030ef          	jal	ra,54c2 <unlink>
      exit(0);
    1ce6:	4501                	li	a0,0
    1ce8:	78a030ef          	jal	ra,5472 <exit>
            printf("%s: cannot create %s\n", s, name);
    1cec:	fa840613          	addi	a2,s0,-88
    1cf0:	85d6                	mv	a1,s5
    1cf2:	00005517          	auipc	a0,0x5
    1cf6:	8ee50513          	addi	a0,a0,-1810 # 65e0 <malloc+0xc96>
    1cfa:	39d030ef          	jal	ra,5896 <printf>
            exit(1);
    1cfe:	4505                	li	a0,1
    1d00:	772030ef          	jal	ra,5472 <exit>
            printf("%s: write(%d) ret %d\n", s, sz, cc);
    1d04:	86aa                	mv	a3,a0
    1d06:	660d                	lui	a2,0x3
    1d08:	85d6                	mv	a1,s5
    1d0a:	00004517          	auipc	a0,0x4
    1d0e:	e2e50513          	addi	a0,a0,-466 # 5b38 <malloc+0x1ee>
    1d12:	385030ef          	jal	ra,5896 <printf>
            exit(1);
    1d16:	4505                	li	a0,1
    1d18:	75a030ef          	jal	ra,5472 <exit>
      exit(st);
    1d1c:	756030ef          	jal	ra,5472 <exit>

0000000000001d20 <copyinstr3>:
{
    1d20:	7179                	addi	sp,sp,-48
    1d22:	f406                	sd	ra,40(sp)
    1d24:	f022                	sd	s0,32(sp)
    1d26:	ec26                	sd	s1,24(sp)
    1d28:	1800                	addi	s0,sp,48
  sbrk(8192);
    1d2a:	6509                	lui	a0,0x2
    1d2c:	712030ef          	jal	ra,543e <sbrk>
  uint64 top = (uint64)sbrk(0);
    1d30:	4501                	li	a0,0
    1d32:	70c030ef          	jal	ra,543e <sbrk>
  if ((top % PGSIZE) != 0) {
    1d36:	03451793          	slli	a5,a0,0x34
    1d3a:	e7bd                	bnez	a5,1da8 <copyinstr3+0x88>
  top = (uint64)sbrk(0);
    1d3c:	4501                	li	a0,0
    1d3e:	700030ef          	jal	ra,543e <sbrk>
  if (top % PGSIZE) {
    1d42:	03451793          	slli	a5,a0,0x34
    1d46:	ebad                	bnez	a5,1db8 <copyinstr3+0x98>
  char *b = (char *)(top - 1);
    1d48:	fff50493          	addi	s1,a0,-1 # 1fff <sbrkbasic+0xdb>
  *b = 'x';
    1d4c:	07800793          	li	a5,120
    1d50:	fef50fa3          	sb	a5,-1(a0)
  int ret = unlink(b);
    1d54:	8526                	mv	a0,s1
    1d56:	76c030ef          	jal	ra,54c2 <unlink>
  if (ret != -1) {
    1d5a:	57fd                	li	a5,-1
    1d5c:	06f51763          	bne	a0,a5,1dca <copyinstr3+0xaa>
  int fd = open(b, O_CREATE | O_WRONLY);
    1d60:	20100593          	li	a1,513
    1d64:	8526                	mv	a0,s1
    1d66:	74c030ef          	jal	ra,54b2 <open>
  if (fd != -1) {
    1d6a:	57fd                	li	a5,-1
    1d6c:	06f51a63          	bne	a0,a5,1de0 <copyinstr3+0xc0>
  ret = link(b, b);
    1d70:	85a6                	mv	a1,s1
    1d72:	8526                	mv	a0,s1
    1d74:	75e030ef          	jal	ra,54d2 <link>
  if (ret != -1) {
    1d78:	57fd                	li	a5,-1
    1d7a:	06f51e63          	bne	a0,a5,1df6 <copyinstr3+0xd6>
  char *args[] = {"xx", 0};
    1d7e:	00005797          	auipc	a5,0x5
    1d82:	56278793          	addi	a5,a5,1378 # 72e0 <malloc+0x1996>
    1d86:	fcf43823          	sd	a5,-48(s0)
    1d8a:	fc043c23          	sd	zero,-40(s0)
  ret = exec(b, args);
    1d8e:	fd040593          	addi	a1,s0,-48
    1d92:	8526                	mv	a0,s1
    1d94:	716030ef          	jal	ra,54aa <exec>
  if (ret != -1) {
    1d98:	57fd                	li	a5,-1
    1d9a:	06f51a63          	bne	a0,a5,1e0e <copyinstr3+0xee>
}
    1d9e:	70a2                	ld	ra,40(sp)
    1da0:	7402                	ld	s0,32(sp)
    1da2:	64e2                	ld	s1,24(sp)
    1da4:	6145                	addi	sp,sp,48
    1da6:	8082                	ret
    sbrk(PGSIZE - (top % PGSIZE));
    1da8:	0347d513          	srli	a0,a5,0x34
    1dac:	6785                	lui	a5,0x1
    1dae:	40a7853b          	subw	a0,a5,a0
    1db2:	68c030ef          	jal	ra,543e <sbrk>
    1db6:	b759                	j	1d3c <copyinstr3+0x1c>
    printf("oops\n");
    1db8:	00005517          	auipc	a0,0x5
    1dbc:	84050513          	addi	a0,a0,-1984 # 65f8 <malloc+0xcae>
    1dc0:	2d7030ef          	jal	ra,5896 <printf>
    exit(1);
    1dc4:	4505                	li	a0,1
    1dc6:	6ac030ef          	jal	ra,5472 <exit>
    printf("unlink(%s) returned %d, not -1\n", b, ret);
    1dca:	862a                	mv	a2,a0
    1dcc:	85a6                	mv	a1,s1
    1dce:	00004517          	auipc	a0,0x4
    1dd2:	44a50513          	addi	a0,a0,1098 # 6218 <malloc+0x8ce>
    1dd6:	2c1030ef          	jal	ra,5896 <printf>
    exit(1);
    1dda:	4505                	li	a0,1
    1ddc:	696030ef          	jal	ra,5472 <exit>
    printf("open(%s) returned %d, not -1\n", b, fd);
    1de0:	862a                	mv	a2,a0
    1de2:	85a6                	mv	a1,s1
    1de4:	00004517          	auipc	a0,0x4
    1de8:	45450513          	addi	a0,a0,1108 # 6238 <malloc+0x8ee>
    1dec:	2ab030ef          	jal	ra,5896 <printf>
    exit(1);
    1df0:	4505                	li	a0,1
    1df2:	680030ef          	jal	ra,5472 <exit>
    printf("link(%s, %s) returned %d, not -1\n", b, b, ret);
    1df6:	86aa                	mv	a3,a0
    1df8:	8626                	mv	a2,s1
    1dfa:	85a6                	mv	a1,s1
    1dfc:	00004517          	auipc	a0,0x4
    1e00:	45c50513          	addi	a0,a0,1116 # 6258 <malloc+0x90e>
    1e04:	293030ef          	jal	ra,5896 <printf>
    exit(1);
    1e08:	4505                	li	a0,1
    1e0a:	668030ef          	jal	ra,5472 <exit>
    printf("exec(%s) returned %d, not -1\n", b, fd);
    1e0e:	567d                	li	a2,-1
    1e10:	85a6                	mv	a1,s1
    1e12:	00004517          	auipc	a0,0x4
    1e16:	46e50513          	addi	a0,a0,1134 # 6280 <malloc+0x936>
    1e1a:	27d030ef          	jal	ra,5896 <printf>
    exit(1);
    1e1e:	4505                	li	a0,1
    1e20:	652030ef          	jal	ra,5472 <exit>

0000000000001e24 <rwsbrk>:
{
    1e24:	1101                	addi	sp,sp,-32
    1e26:	ec06                	sd	ra,24(sp)
    1e28:	e822                	sd	s0,16(sp)
    1e2a:	e426                	sd	s1,8(sp)
    1e2c:	e04a                	sd	s2,0(sp)
    1e2e:	1000                	addi	s0,sp,32
  uint64 a = (uint64)sbrk(8192);
    1e30:	6509                	lui	a0,0x2
    1e32:	60c030ef          	jal	ra,543e <sbrk>
  if (a == (uint64)SBRK_ERROR) {
    1e36:	57fd                	li	a5,-1
    1e38:	04f50863          	beq	a0,a5,1e88 <rwsbrk+0x64>
    1e3c:	84aa                	mv	s1,a0
  if (sbrk(-8192) == SBRK_ERROR) {
    1e3e:	7579                	lui	a0,0xffffe
    1e40:	5fe030ef          	jal	ra,543e <sbrk>
    1e44:	57fd                	li	a5,-1
    1e46:	04f50a63          	beq	a0,a5,1e9a <rwsbrk+0x76>
  fd = open("rwsbrk", O_CREATE | O_WRONLY);
    1e4a:	20100593          	li	a1,513
    1e4e:	00004517          	auipc	a0,0x4
    1e52:	7ea50513          	addi	a0,a0,2026 # 6638 <malloc+0xcee>
    1e56:	65c030ef          	jal	ra,54b2 <open>
    1e5a:	892a                	mv	s2,a0
  if (fd < 0) {
    1e5c:	04054863          	bltz	a0,1eac <rwsbrk+0x88>
  n = write(fd, (void *)(a + PGSIZE), 1024);
    1e60:	6785                	lui	a5,0x1
    1e62:	94be                	add	s1,s1,a5
    1e64:	40000613          	li	a2,1024
    1e68:	85a6                	mv	a1,s1
    1e6a:	628030ef          	jal	ra,5492 <write>
    1e6e:	862a                	mv	a2,a0
  if (n >= 0) {
    1e70:	04054763          	bltz	a0,1ebe <rwsbrk+0x9a>
    printf("write(fd, %p, 1024) returned %d, not -1\n", (void *)a + PGSIZE, n);
    1e74:	85a6                	mv	a1,s1
    1e76:	00004517          	auipc	a0,0x4
    1e7a:	7e250513          	addi	a0,a0,2018 # 6658 <malloc+0xd0e>
    1e7e:	219030ef          	jal	ra,5896 <printf>
    exit(1);
    1e82:	4505                	li	a0,1
    1e84:	5ee030ef          	jal	ra,5472 <exit>
    printf("sbrk(rwsbrk) failed\n");
    1e88:	00004517          	auipc	a0,0x4
    1e8c:	77850513          	addi	a0,a0,1912 # 6600 <malloc+0xcb6>
    1e90:	207030ef          	jal	ra,5896 <printf>
    exit(1);
    1e94:	4505                	li	a0,1
    1e96:	5dc030ef          	jal	ra,5472 <exit>
    printf("sbrk(rwsbrk) shrink failed\n");
    1e9a:	00004517          	auipc	a0,0x4
    1e9e:	77e50513          	addi	a0,a0,1918 # 6618 <malloc+0xcce>
    1ea2:	1f5030ef          	jal	ra,5896 <printf>
    exit(1);
    1ea6:	4505                	li	a0,1
    1ea8:	5ca030ef          	jal	ra,5472 <exit>
    printf("open(rwsbrk) failed\n");
    1eac:	00004517          	auipc	a0,0x4
    1eb0:	79450513          	addi	a0,a0,1940 # 6640 <malloc+0xcf6>
    1eb4:	1e3030ef          	jal	ra,5896 <printf>
    exit(1);
    1eb8:	4505                	li	a0,1
    1eba:	5b8030ef          	jal	ra,5472 <exit>
  close(fd);
    1ebe:	854a                	mv	a0,s2
    1ec0:	5da030ef          	jal	ra,549a <close>
  unlink("rwsbrk");
    1ec4:	00004517          	auipc	a0,0x4
    1ec8:	77450513          	addi	a0,a0,1908 # 6638 <malloc+0xcee>
    1ecc:	5f6030ef          	jal	ra,54c2 <unlink>
  fd = open("README", O_RDONLY);
    1ed0:	4581                	li	a1,0
    1ed2:	00004517          	auipc	a0,0x4
    1ed6:	d6e50513          	addi	a0,a0,-658 # 5c40 <malloc+0x2f6>
    1eda:	5d8030ef          	jal	ra,54b2 <open>
    1ede:	892a                	mv	s2,a0
  if (fd < 0) {
    1ee0:	02054363          	bltz	a0,1f06 <rwsbrk+0xe2>
  n = read(fd, (void *)(a + PGSIZE), 10);
    1ee4:	4629                	li	a2,10
    1ee6:	85a6                	mv	a1,s1
    1ee8:	5a2030ef          	jal	ra,548a <read>
    1eec:	862a                	mv	a2,a0
  if (n >= 0) {
    1eee:	02054563          	bltz	a0,1f18 <rwsbrk+0xf4>
    printf("read(fd, %p, 10) returned %d, not -1\n", (void *)a + PGSIZE, n);
    1ef2:	85a6                	mv	a1,s1
    1ef4:	00004517          	auipc	a0,0x4
    1ef8:	79450513          	addi	a0,a0,1940 # 6688 <malloc+0xd3e>
    1efc:	19b030ef          	jal	ra,5896 <printf>
    exit(1);
    1f00:	4505                	li	a0,1
    1f02:	570030ef          	jal	ra,5472 <exit>
    printf("open(README) failed\n");
    1f06:	00004517          	auipc	a0,0x4
    1f0a:	d4250513          	addi	a0,a0,-702 # 5c48 <malloc+0x2fe>
    1f0e:	189030ef          	jal	ra,5896 <printf>
    exit(1);
    1f12:	4505                	li	a0,1
    1f14:	55e030ef          	jal	ra,5472 <exit>
  close(fd);
    1f18:	854a                	mv	a0,s2
    1f1a:	580030ef          	jal	ra,549a <close>
  exit(0);
    1f1e:	4501                	li	a0,0
    1f20:	552030ef          	jal	ra,5472 <exit>

0000000000001f24 <sbrkbasic>:
{
    1f24:	7139                	addi	sp,sp,-64
    1f26:	fc06                	sd	ra,56(sp)
    1f28:	f822                	sd	s0,48(sp)
    1f2a:	f426                	sd	s1,40(sp)
    1f2c:	f04a                	sd	s2,32(sp)
    1f2e:	ec4e                	sd	s3,24(sp)
    1f30:	e852                	sd	s4,16(sp)
    1f32:	0080                	addi	s0,sp,64
    1f34:	8a2a                	mv	s4,a0
  pid = fork();
    1f36:	534030ef          	jal	ra,546a <fork>
  if (pid < 0) {
    1f3a:	02054863          	bltz	a0,1f6a <sbrkbasic+0x46>
  if (pid == 0) {
    1f3e:	e131                	bnez	a0,1f82 <sbrkbasic+0x5e>
    a = sbrk(TOOMUCH);
    1f40:	40000537          	lui	a0,0x40000
    1f44:	4fa030ef          	jal	ra,543e <sbrk>
    if (a == (char *)SBRK_ERROR) {
    1f48:	57fd                	li	a5,-1
    1f4a:	02f50963          	beq	a0,a5,1f7c <sbrkbasic+0x58>
    for (b = a; b < a + TOOMUCH; b += PGSIZE) {
    1f4e:	400007b7          	lui	a5,0x40000
    1f52:	97aa                	add	a5,a5,a0
      *b = 99;
    1f54:	06300693          	li	a3,99
    for (b = a; b < a + TOOMUCH; b += PGSIZE) {
    1f58:	6705                	lui	a4,0x1
      *b = 99;
    1f5a:	00d50023          	sb	a3,0(a0) # 40000000 <base+0x3fff0308>
    for (b = a; b < a + TOOMUCH; b += PGSIZE) {
    1f5e:	953a                	add	a0,a0,a4
    1f60:	fef51de3          	bne	a0,a5,1f5a <sbrkbasic+0x36>
    exit(1);
    1f64:	4505                	li	a0,1
    1f66:	50c030ef          	jal	ra,5472 <exit>
    printf("fork failed in sbrkbasic\n");
    1f6a:	00004517          	auipc	a0,0x4
    1f6e:	74650513          	addi	a0,a0,1862 # 66b0 <malloc+0xd66>
    1f72:	125030ef          	jal	ra,5896 <printf>
    exit(1);
    1f76:	4505                	li	a0,1
    1f78:	4fa030ef          	jal	ra,5472 <exit>
      exit(0);
    1f7c:	4501                	li	a0,0
    1f7e:	4f4030ef          	jal	ra,5472 <exit>
  wait(&xstatus);
    1f82:	fcc40513          	addi	a0,s0,-52
    1f86:	4f4030ef          	jal	ra,547a <wait>
  if (xstatus == 1) {
    1f8a:	fcc42703          	lw	a4,-52(s0)
    1f8e:	4785                	li	a5,1
    1f90:	00f70b63          	beq	a4,a5,1fa6 <sbrkbasic+0x82>
  a = sbrk(0);
    1f94:	4501                	li	a0,0
    1f96:	4a8030ef          	jal	ra,543e <sbrk>
    1f9a:	84aa                	mv	s1,a0
  for (i = 0; i < 5000; i++) {
    1f9c:	4901                	li	s2,0
    1f9e:	6985                	lui	s3,0x1
    1fa0:	38898993          	addi	s3,s3,904 # 1388 <pipe1+0x5a>
    1fa4:	a821                	j	1fbc <sbrkbasic+0x98>
    printf("%s: too much memory allocated!\n", s);
    1fa6:	85d2                	mv	a1,s4
    1fa8:	00004517          	auipc	a0,0x4
    1fac:	72850513          	addi	a0,a0,1832 # 66d0 <malloc+0xd86>
    1fb0:	0e7030ef          	jal	ra,5896 <printf>
    exit(1);
    1fb4:	4505                	li	a0,1
    1fb6:	4bc030ef          	jal	ra,5472 <exit>
    a = b + 1;
    1fba:	84be                	mv	s1,a5
    b = sbrk(1);
    1fbc:	4505                	li	a0,1
    1fbe:	480030ef          	jal	ra,543e <sbrk>
    if (b != a) {
    1fc2:	04951263          	bne	a0,s1,2006 <sbrkbasic+0xe2>
    *b = 1;
    1fc6:	4785                	li	a5,1
    1fc8:	00f48023          	sb	a5,0(s1)
    a = b + 1;
    1fcc:	00148793          	addi	a5,s1,1
  for (i = 0; i < 5000; i++) {
    1fd0:	2905                	addiw	s2,s2,1
    1fd2:	ff3914e3          	bne	s2,s3,1fba <sbrkbasic+0x96>
  pid = fork();
    1fd6:	494030ef          	jal	ra,546a <fork>
    1fda:	892a                	mv	s2,a0
  if (pid < 0) {
    1fdc:	04054263          	bltz	a0,2020 <sbrkbasic+0xfc>
  c = sbrk(1);
    1fe0:	4505                	li	a0,1
    1fe2:	45c030ef          	jal	ra,543e <sbrk>
  c = sbrk(1);
    1fe6:	4505                	li	a0,1
    1fe8:	456030ef          	jal	ra,543e <sbrk>
  if (c != a + 1) {
    1fec:	0489                	addi	s1,s1,2
    1fee:	04a48363          	beq	s1,a0,2034 <sbrkbasic+0x110>
    printf("%s: sbrk test failed post-fork\n", s);
    1ff2:	85d2                	mv	a1,s4
    1ff4:	00004517          	auipc	a0,0x4
    1ff8:	73c50513          	addi	a0,a0,1852 # 6730 <malloc+0xde6>
    1ffc:	09b030ef          	jal	ra,5896 <printf>
    exit(1);
    2000:	4505                	li	a0,1
    2002:	470030ef          	jal	ra,5472 <exit>
      printf("%s: sbrk test failed %d %p %p\n", s, i, a, b);
    2006:	872a                	mv	a4,a0
    2008:	86a6                	mv	a3,s1
    200a:	864a                	mv	a2,s2
    200c:	85d2                	mv	a1,s4
    200e:	00004517          	auipc	a0,0x4
    2012:	6e250513          	addi	a0,a0,1762 # 66f0 <malloc+0xda6>
    2016:	081030ef          	jal	ra,5896 <printf>
      exit(1);
    201a:	4505                	li	a0,1
    201c:	456030ef          	jal	ra,5472 <exit>
    printf("%s: sbrk test fork failed\n", s);
    2020:	85d2                	mv	a1,s4
    2022:	00004517          	auipc	a0,0x4
    2026:	6ee50513          	addi	a0,a0,1774 # 6710 <malloc+0xdc6>
    202a:	06d030ef          	jal	ra,5896 <printf>
    exit(1);
    202e:	4505                	li	a0,1
    2030:	442030ef          	jal	ra,5472 <exit>
  if (pid == 0)
    2034:	00091563          	bnez	s2,203e <sbrkbasic+0x11a>
    exit(0);
    2038:	4501                	li	a0,0
    203a:	438030ef          	jal	ra,5472 <exit>
  wait(&xstatus);
    203e:	fcc40513          	addi	a0,s0,-52
    2042:	438030ef          	jal	ra,547a <wait>
  exit(xstatus);
    2046:	fcc42503          	lw	a0,-52(s0)
    204a:	428030ef          	jal	ra,5472 <exit>

000000000000204e <sbrkmuch>:
{
    204e:	7179                	addi	sp,sp,-48
    2050:	f406                	sd	ra,40(sp)
    2052:	f022                	sd	s0,32(sp)
    2054:	ec26                	sd	s1,24(sp)
    2056:	e84a                	sd	s2,16(sp)
    2058:	e44e                	sd	s3,8(sp)
    205a:	e052                	sd	s4,0(sp)
    205c:	1800                	addi	s0,sp,48
    205e:	89aa                	mv	s3,a0
  oldbrk = sbrk(0);
    2060:	4501                	li	a0,0
    2062:	3dc030ef          	jal	ra,543e <sbrk>
    2066:	892a                	mv	s2,a0
  a = sbrk(0);
    2068:	4501                	li	a0,0
    206a:	3d4030ef          	jal	ra,543e <sbrk>
    206e:	84aa                	mv	s1,a0
  p = sbrk(amt);
    2070:	06400537          	lui	a0,0x6400
    2074:	9d05                	subw	a0,a0,s1
    2076:	3c8030ef          	jal	ra,543e <sbrk>
  if (p != a) {
    207a:	08a49763          	bne	s1,a0,2108 <sbrkmuch+0xba>
  *lastaddr = 99;
    207e:	064007b7          	lui	a5,0x6400
    2082:	06300713          	li	a4,99
    2086:	fee78fa3          	sb	a4,-1(a5) # 63fffff <base+0x63f0307>
  a = sbrk(0);
    208a:	4501                	li	a0,0
    208c:	3b2030ef          	jal	ra,543e <sbrk>
    2090:	84aa                	mv	s1,a0
  c = sbrk(-PGSIZE);
    2092:	757d                	lui	a0,0xfffff
    2094:	3aa030ef          	jal	ra,543e <sbrk>
  if (c == (char *)SBRK_ERROR) {
    2098:	57fd                	li	a5,-1
    209a:	08f50163          	beq	a0,a5,211c <sbrkmuch+0xce>
  c = sbrk(0);
    209e:	4501                	li	a0,0
    20a0:	39e030ef          	jal	ra,543e <sbrk>
  if (c != a - PGSIZE) {
    20a4:	77fd                	lui	a5,0xfffff
    20a6:	97a6                	add	a5,a5,s1
    20a8:	08f51463          	bne	a0,a5,2130 <sbrkmuch+0xe2>
  a = sbrk(0);
    20ac:	4501                	li	a0,0
    20ae:	390030ef          	jal	ra,543e <sbrk>
    20b2:	84aa                	mv	s1,a0
  c = sbrk(PGSIZE);
    20b4:	6505                	lui	a0,0x1
    20b6:	388030ef          	jal	ra,543e <sbrk>
    20ba:	8a2a                	mv	s4,a0
  if (c != a || sbrk(0) != a + PGSIZE) {
    20bc:	08a49663          	bne	s1,a0,2148 <sbrkmuch+0xfa>
    20c0:	4501                	li	a0,0
    20c2:	37c030ef          	jal	ra,543e <sbrk>
    20c6:	6785                	lui	a5,0x1
    20c8:	97a6                	add	a5,a5,s1
    20ca:	06f51f63          	bne	a0,a5,2148 <sbrkmuch+0xfa>
  if (*lastaddr == 99) {
    20ce:	064007b7          	lui	a5,0x6400
    20d2:	fff7c703          	lbu	a4,-1(a5) # 63fffff <base+0x63f0307>
    20d6:	06300793          	li	a5,99
    20da:	08f70363          	beq	a4,a5,2160 <sbrkmuch+0x112>
  a = sbrk(0);
    20de:	4501                	li	a0,0
    20e0:	35e030ef          	jal	ra,543e <sbrk>
    20e4:	84aa                	mv	s1,a0
  c = sbrk(-(sbrk(0) - oldbrk));
    20e6:	4501                	li	a0,0
    20e8:	356030ef          	jal	ra,543e <sbrk>
    20ec:	40a9053b          	subw	a0,s2,a0
    20f0:	34e030ef          	jal	ra,543e <sbrk>
  if (c != a) {
    20f4:	08a49063          	bne	s1,a0,2174 <sbrkmuch+0x126>
}
    20f8:	70a2                	ld	ra,40(sp)
    20fa:	7402                	ld	s0,32(sp)
    20fc:	64e2                	ld	s1,24(sp)
    20fe:	6942                	ld	s2,16(sp)
    2100:	69a2                	ld	s3,8(sp)
    2102:	6a02                	ld	s4,0(sp)
    2104:	6145                	addi	sp,sp,48
    2106:	8082                	ret
    printf("%s: sbrk test failed to grow big address space; enough phys mem?\n",
    2108:	85ce                	mv	a1,s3
    210a:	00004517          	auipc	a0,0x4
    210e:	64650513          	addi	a0,a0,1606 # 6750 <malloc+0xe06>
    2112:	784030ef          	jal	ra,5896 <printf>
    exit(1);
    2116:	4505                	li	a0,1
    2118:	35a030ef          	jal	ra,5472 <exit>
    printf("%s: sbrk could not deallocate\n", s);
    211c:	85ce                	mv	a1,s3
    211e:	00004517          	auipc	a0,0x4
    2122:	67a50513          	addi	a0,a0,1658 # 6798 <malloc+0xe4e>
    2126:	770030ef          	jal	ra,5896 <printf>
    exit(1);
    212a:	4505                	li	a0,1
    212c:	346030ef          	jal	ra,5472 <exit>
    printf("%s: sbrk deallocation produced wrong address, a %p c %p\n", s, a,
    2130:	86aa                	mv	a3,a0
    2132:	8626                	mv	a2,s1
    2134:	85ce                	mv	a1,s3
    2136:	00004517          	auipc	a0,0x4
    213a:	68250513          	addi	a0,a0,1666 # 67b8 <malloc+0xe6e>
    213e:	758030ef          	jal	ra,5896 <printf>
    exit(1);
    2142:	4505                	li	a0,1
    2144:	32e030ef          	jal	ra,5472 <exit>
    printf("%s: sbrk re-allocation failed, a %p c %p\n", s, a, c);
    2148:	86d2                	mv	a3,s4
    214a:	8626                	mv	a2,s1
    214c:	85ce                	mv	a1,s3
    214e:	00004517          	auipc	a0,0x4
    2152:	6aa50513          	addi	a0,a0,1706 # 67f8 <malloc+0xeae>
    2156:	740030ef          	jal	ra,5896 <printf>
    exit(1);
    215a:	4505                	li	a0,1
    215c:	316030ef          	jal	ra,5472 <exit>
    printf("%s: sbrk de-allocation didn't really deallocate\n", s);
    2160:	85ce                	mv	a1,s3
    2162:	00004517          	auipc	a0,0x4
    2166:	6c650513          	addi	a0,a0,1734 # 6828 <malloc+0xede>
    216a:	72c030ef          	jal	ra,5896 <printf>
    exit(1);
    216e:	4505                	li	a0,1
    2170:	302030ef          	jal	ra,5472 <exit>
    printf("%s: sbrk downsize failed, a %p c %p\n", s, a, c);
    2174:	86aa                	mv	a3,a0
    2176:	8626                	mv	a2,s1
    2178:	85ce                	mv	a1,s3
    217a:	00004517          	auipc	a0,0x4
    217e:	6e650513          	addi	a0,a0,1766 # 6860 <malloc+0xf16>
    2182:	714030ef          	jal	ra,5896 <printf>
    exit(1);
    2186:	4505                	li	a0,1
    2188:	2ea030ef          	jal	ra,5472 <exit>

000000000000218c <sbrkarg>:
{
    218c:	7179                	addi	sp,sp,-48
    218e:	f406                	sd	ra,40(sp)
    2190:	f022                	sd	s0,32(sp)
    2192:	ec26                	sd	s1,24(sp)
    2194:	e84a                	sd	s2,16(sp)
    2196:	e44e                	sd	s3,8(sp)
    2198:	1800                	addi	s0,sp,48
    219a:	89aa                	mv	s3,a0
  a = sbrk(PGSIZE);
    219c:	6505                	lui	a0,0x1
    219e:	2a0030ef          	jal	ra,543e <sbrk>
    21a2:	892a                	mv	s2,a0
  fd = open("sbrk", O_CREATE | O_WRONLY);
    21a4:	20100593          	li	a1,513
    21a8:	00004517          	auipc	a0,0x4
    21ac:	6e050513          	addi	a0,a0,1760 # 6888 <malloc+0xf3e>
    21b0:	302030ef          	jal	ra,54b2 <open>
    21b4:	84aa                	mv	s1,a0
  unlink("sbrk");
    21b6:	00004517          	auipc	a0,0x4
    21ba:	6d250513          	addi	a0,a0,1746 # 6888 <malloc+0xf3e>
    21be:	304030ef          	jal	ra,54c2 <unlink>
  if (fd < 0) {
    21c2:	0204c963          	bltz	s1,21f4 <sbrkarg+0x68>
  if ((n = write(fd, a, PGSIZE)) < 0) {
    21c6:	6605                	lui	a2,0x1
    21c8:	85ca                	mv	a1,s2
    21ca:	8526                	mv	a0,s1
    21cc:	2c6030ef          	jal	ra,5492 <write>
    21d0:	02054c63          	bltz	a0,2208 <sbrkarg+0x7c>
  close(fd);
    21d4:	8526                	mv	a0,s1
    21d6:	2c4030ef          	jal	ra,549a <close>
  a = sbrk(PGSIZE);
    21da:	6505                	lui	a0,0x1
    21dc:	262030ef          	jal	ra,543e <sbrk>
  if (pipe((int *)a) != 0) {
    21e0:	2a2030ef          	jal	ra,5482 <pipe>
    21e4:	ed05                	bnez	a0,221c <sbrkarg+0x90>
}
    21e6:	70a2                	ld	ra,40(sp)
    21e8:	7402                	ld	s0,32(sp)
    21ea:	64e2                	ld	s1,24(sp)
    21ec:	6942                	ld	s2,16(sp)
    21ee:	69a2                	ld	s3,8(sp)
    21f0:	6145                	addi	sp,sp,48
    21f2:	8082                	ret
    printf("%s: open sbrk failed\n", s);
    21f4:	85ce                	mv	a1,s3
    21f6:	00004517          	auipc	a0,0x4
    21fa:	69a50513          	addi	a0,a0,1690 # 6890 <malloc+0xf46>
    21fe:	698030ef          	jal	ra,5896 <printf>
    exit(1);
    2202:	4505                	li	a0,1
    2204:	26e030ef          	jal	ra,5472 <exit>
    printf("%s: write sbrk failed\n", s);
    2208:	85ce                	mv	a1,s3
    220a:	00004517          	auipc	a0,0x4
    220e:	69e50513          	addi	a0,a0,1694 # 68a8 <malloc+0xf5e>
    2212:	684030ef          	jal	ra,5896 <printf>
    exit(1);
    2216:	4505                	li	a0,1
    2218:	25a030ef          	jal	ra,5472 <exit>
    printf("%s: pipe() failed\n", s);
    221c:	85ce                	mv	a1,s3
    221e:	00004517          	auipc	a0,0x4
    2222:	16250513          	addi	a0,a0,354 # 6380 <malloc+0xa36>
    2226:	670030ef          	jal	ra,5896 <printf>
    exit(1);
    222a:	4505                	li	a0,1
    222c:	246030ef          	jal	ra,5472 <exit>

0000000000002230 <argptest>:
{
    2230:	1101                	addi	sp,sp,-32
    2232:	ec06                	sd	ra,24(sp)
    2234:	e822                	sd	s0,16(sp)
    2236:	e426                	sd	s1,8(sp)
    2238:	e04a                	sd	s2,0(sp)
    223a:	1000                	addi	s0,sp,32
    223c:	892a                	mv	s2,a0
  fd = open("init", O_RDONLY);
    223e:	4581                	li	a1,0
    2240:	00004517          	auipc	a0,0x4
    2244:	68050513          	addi	a0,a0,1664 # 68c0 <malloc+0xf76>
    2248:	26a030ef          	jal	ra,54b2 <open>
  if (fd < 0) {
    224c:	02054563          	bltz	a0,2276 <argptest+0x46>
    2250:	84aa                	mv	s1,a0
  read(fd, sbrk(0) - 1, -1);
    2252:	4501                	li	a0,0
    2254:	1ea030ef          	jal	ra,543e <sbrk>
    2258:	567d                	li	a2,-1
    225a:	fff50593          	addi	a1,a0,-1
    225e:	8526                	mv	a0,s1
    2260:	22a030ef          	jal	ra,548a <read>
  close(fd);
    2264:	8526                	mv	a0,s1
    2266:	234030ef          	jal	ra,549a <close>
}
    226a:	60e2                	ld	ra,24(sp)
    226c:	6442                	ld	s0,16(sp)
    226e:	64a2                	ld	s1,8(sp)
    2270:	6902                	ld	s2,0(sp)
    2272:	6105                	addi	sp,sp,32
    2274:	8082                	ret
    printf("%s: open failed\n", s);
    2276:	85ca                	mv	a1,s2
    2278:	00004517          	auipc	a0,0x4
    227c:	09850513          	addi	a0,a0,152 # 6310 <malloc+0x9c6>
    2280:	616030ef          	jal	ra,5896 <printf>
    exit(1);
    2284:	4505                	li	a0,1
    2286:	1ec030ef          	jal	ra,5472 <exit>

000000000000228a <sbrkbugs>:
{
    228a:	1141                	addi	sp,sp,-16
    228c:	e406                	sd	ra,8(sp)
    228e:	e022                	sd	s0,0(sp)
    2290:	0800                	addi	s0,sp,16
  int pid = fork();
    2292:	1d8030ef          	jal	ra,546a <fork>
  if (pid < 0) {
    2296:	00054c63          	bltz	a0,22ae <sbrkbugs+0x24>
  if (pid == 0) {
    229a:	e11d                	bnez	a0,22c0 <sbrkbugs+0x36>
    int sz = (uint64)sbrk(0);
    229c:	1a2030ef          	jal	ra,543e <sbrk>
    sbrk(-sz);
    22a0:	40a0053b          	negw	a0,a0
    22a4:	19a030ef          	jal	ra,543e <sbrk>
    exit(0);
    22a8:	4501                	li	a0,0
    22aa:	1c8030ef          	jal	ra,5472 <exit>
    printf("fork failed\n");
    22ae:	00005517          	auipc	a0,0x5
    22b2:	73a50513          	addi	a0,a0,1850 # 79e8 <malloc+0x209e>
    22b6:	5e0030ef          	jal	ra,5896 <printf>
    exit(1);
    22ba:	4505                	li	a0,1
    22bc:	1b6030ef          	jal	ra,5472 <exit>
  wait(0);
    22c0:	4501                	li	a0,0
    22c2:	1b8030ef          	jal	ra,547a <wait>
  pid = fork();
    22c6:	1a4030ef          	jal	ra,546a <fork>
  if (pid < 0) {
    22ca:	00054f63          	bltz	a0,22e8 <sbrkbugs+0x5e>
  if (pid == 0) {
    22ce:	e515                	bnez	a0,22fa <sbrkbugs+0x70>
    int sz = (uint64)sbrk(0);
    22d0:	16e030ef          	jal	ra,543e <sbrk>
    sbrk(-(sz - 3500));
    22d4:	6785                	lui	a5,0x1
    22d6:	dac7879b          	addiw	a5,a5,-596 # dac <linktest+0x138>
    22da:	40a7853b          	subw	a0,a5,a0
    22de:	160030ef          	jal	ra,543e <sbrk>
    exit(0);
    22e2:	4501                	li	a0,0
    22e4:	18e030ef          	jal	ra,5472 <exit>
    printf("fork failed\n");
    22e8:	00005517          	auipc	a0,0x5
    22ec:	70050513          	addi	a0,a0,1792 # 79e8 <malloc+0x209e>
    22f0:	5a6030ef          	jal	ra,5896 <printf>
    exit(1);
    22f4:	4505                	li	a0,1
    22f6:	17c030ef          	jal	ra,5472 <exit>
  wait(0);
    22fa:	4501                	li	a0,0
    22fc:	17e030ef          	jal	ra,547a <wait>
  pid = fork();
    2300:	16a030ef          	jal	ra,546a <fork>
  if (pid < 0) {
    2304:	02054263          	bltz	a0,2328 <sbrkbugs+0x9e>
  if (pid == 0) {
    2308:	e90d                	bnez	a0,233a <sbrkbugs+0xb0>
    sbrk((10 * PGSIZE + 2048) - (uint64)sbrk(0));
    230a:	134030ef          	jal	ra,543e <sbrk>
    230e:	67ad                	lui	a5,0xb
    2310:	8007879b          	addiw	a5,a5,-2048 # a800 <uninit+0x218>
    2314:	40a7853b          	subw	a0,a5,a0
    2318:	126030ef          	jal	ra,543e <sbrk>
    sbrk(-10);
    231c:	5559                	li	a0,-10
    231e:	120030ef          	jal	ra,543e <sbrk>
    exit(0);
    2322:	4501                	li	a0,0
    2324:	14e030ef          	jal	ra,5472 <exit>
    printf("fork failed\n");
    2328:	00005517          	auipc	a0,0x5
    232c:	6c050513          	addi	a0,a0,1728 # 79e8 <malloc+0x209e>
    2330:	566030ef          	jal	ra,5896 <printf>
    exit(1);
    2334:	4505                	li	a0,1
    2336:	13c030ef          	jal	ra,5472 <exit>
  wait(0);
    233a:	4501                	li	a0,0
    233c:	13e030ef          	jal	ra,547a <wait>
  exit(0);
    2340:	4501                	li	a0,0
    2342:	130030ef          	jal	ra,5472 <exit>

0000000000002346 <sbrklast>:
{
    2346:	7179                	addi	sp,sp,-48
    2348:	f406                	sd	ra,40(sp)
    234a:	f022                	sd	s0,32(sp)
    234c:	ec26                	sd	s1,24(sp)
    234e:	e84a                	sd	s2,16(sp)
    2350:	e44e                	sd	s3,8(sp)
    2352:	e052                	sd	s4,0(sp)
    2354:	1800                	addi	s0,sp,48
  uint64 top = (uint64)sbrk(0);
    2356:	4501                	li	a0,0
    2358:	0e6030ef          	jal	ra,543e <sbrk>
  if ((top % PGSIZE) != 0)
    235c:	03451793          	slli	a5,a0,0x34
    2360:	ebad                	bnez	a5,23d2 <sbrklast+0x8c>
  sbrk(PGSIZE);
    2362:	6505                	lui	a0,0x1
    2364:	0da030ef          	jal	ra,543e <sbrk>
  sbrk(10);
    2368:	4529                	li	a0,10
    236a:	0d4030ef          	jal	ra,543e <sbrk>
  sbrk(-20);
    236e:	5531                	li	a0,-20
    2370:	0ce030ef          	jal	ra,543e <sbrk>
  top = (uint64)sbrk(0);
    2374:	4501                	li	a0,0
    2376:	0c8030ef          	jal	ra,543e <sbrk>
    237a:	84aa                	mv	s1,a0
  char *p = (char *)(top - 64);
    237c:	fc050913          	addi	s2,a0,-64 # fc0 <bigdir+0x122>
  p[0] = 'x';
    2380:	07800a13          	li	s4,120
    2384:	fd450023          	sb	s4,-64(a0)
  p[1] = '\0';
    2388:	fc0500a3          	sb	zero,-63(a0)
  int fd = open(p, O_RDWR | O_CREATE);
    238c:	20200593          	li	a1,514
    2390:	854a                	mv	a0,s2
    2392:	120030ef          	jal	ra,54b2 <open>
    2396:	89aa                	mv	s3,a0
  write(fd, p, 1);
    2398:	4605                	li	a2,1
    239a:	85ca                	mv	a1,s2
    239c:	0f6030ef          	jal	ra,5492 <write>
  close(fd);
    23a0:	854e                	mv	a0,s3
    23a2:	0f8030ef          	jal	ra,549a <close>
  fd = open(p, O_RDWR);
    23a6:	4589                	li	a1,2
    23a8:	854a                	mv	a0,s2
    23aa:	108030ef          	jal	ra,54b2 <open>
  p[0] = '\0';
    23ae:	fc048023          	sb	zero,-64(s1)
  read(fd, p, 1);
    23b2:	4605                	li	a2,1
    23b4:	85ca                	mv	a1,s2
    23b6:	0d4030ef          	jal	ra,548a <read>
  if (p[0] != 'x')
    23ba:	fc04c783          	lbu	a5,-64(s1)
    23be:	03479263          	bne	a5,s4,23e2 <sbrklast+0x9c>
}
    23c2:	70a2                	ld	ra,40(sp)
    23c4:	7402                	ld	s0,32(sp)
    23c6:	64e2                	ld	s1,24(sp)
    23c8:	6942                	ld	s2,16(sp)
    23ca:	69a2                	ld	s3,8(sp)
    23cc:	6a02                	ld	s4,0(sp)
    23ce:	6145                	addi	sp,sp,48
    23d0:	8082                	ret
    sbrk(PGSIZE - (top % PGSIZE));
    23d2:	0347d513          	srli	a0,a5,0x34
    23d6:	6785                	lui	a5,0x1
    23d8:	40a7853b          	subw	a0,a5,a0
    23dc:	062030ef          	jal	ra,543e <sbrk>
    23e0:	b749                	j	2362 <sbrklast+0x1c>
    exit(1);
    23e2:	4505                	li	a0,1
    23e4:	08e030ef          	jal	ra,5472 <exit>

00000000000023e8 <sbrk8000>:
{
    23e8:	1141                	addi	sp,sp,-16
    23ea:	e406                	sd	ra,8(sp)
    23ec:	e022                	sd	s0,0(sp)
    23ee:	0800                	addi	s0,sp,16
  sbrk(0x80000004);
    23f0:	80000537          	lui	a0,0x80000
    23f4:	0511                	addi	a0,a0,4 # ffffffff80000004 <base+0xffffffff7fff030c>
    23f6:	048030ef          	jal	ra,543e <sbrk>
  volatile char *top = sbrk(0);
    23fa:	4501                	li	a0,0
    23fc:	042030ef          	jal	ra,543e <sbrk>
  *(top - 1) = *(top - 1) + 1;
    2400:	fff54783          	lbu	a5,-1(a0)
    2404:	2785                	addiw	a5,a5,1 # 1001 <badarg+0x1>
    2406:	0ff7f793          	zext.b	a5,a5
    240a:	fef50fa3          	sb	a5,-1(a0)
}
    240e:	60a2                	ld	ra,8(sp)
    2410:	6402                	ld	s0,0(sp)
    2412:	0141                	addi	sp,sp,16
    2414:	8082                	ret

0000000000002416 <execout>:
{
    2416:	715d                	addi	sp,sp,-80
    2418:	e486                	sd	ra,72(sp)
    241a:	e0a2                	sd	s0,64(sp)
    241c:	fc26                	sd	s1,56(sp)
    241e:	f84a                	sd	s2,48(sp)
    2420:	f44e                	sd	s3,40(sp)
    2422:	f052                	sd	s4,32(sp)
    2424:	0880                	addi	s0,sp,80
  for (int avail = 0; avail < 15; avail++) {
    2426:	4901                	li	s2,0
    2428:	49bd                	li	s3,15
    int pid = fork();
    242a:	040030ef          	jal	ra,546a <fork>
    242e:	84aa                	mv	s1,a0
    if (pid < 0) {
    2430:	00054c63          	bltz	a0,2448 <execout+0x32>
    } else if (pid == 0) {
    2434:	c11d                	beqz	a0,245a <execout+0x44>
      wait((int *)0);
    2436:	4501                	li	a0,0
    2438:	042030ef          	jal	ra,547a <wait>
  for (int avail = 0; avail < 15; avail++) {
    243c:	2905                	addiw	s2,s2,1
    243e:	ff3916e3          	bne	s2,s3,242a <execout+0x14>
  exit(0);
    2442:	4501                	li	a0,0
    2444:	02e030ef          	jal	ra,5472 <exit>
      printf("fork failed\n");
    2448:	00005517          	auipc	a0,0x5
    244c:	5a050513          	addi	a0,a0,1440 # 79e8 <malloc+0x209e>
    2450:	446030ef          	jal	ra,5896 <printf>
      exit(1);
    2454:	4505                	li	a0,1
    2456:	01c030ef          	jal	ra,5472 <exit>
        if (a == SBRK_ERROR)
    245a:	59fd                	li	s3,-1
        *(a + PGSIZE - 1) = 1;
    245c:	4a05                	li	s4,1
        char *a = sbrk(PGSIZE);
    245e:	6505                	lui	a0,0x1
    2460:	7df020ef          	jal	ra,543e <sbrk>
        if (a == SBRK_ERROR)
    2464:	01350763          	beq	a0,s3,2472 <execout+0x5c>
        *(a + PGSIZE - 1) = 1;
    2468:	6785                	lui	a5,0x1
    246a:	953e                	add	a0,a0,a5
    246c:	ff450fa3          	sb	s4,-1(a0) # fff <pgbug+0x2b>
      while (1) {
    2470:	b7fd                	j	245e <execout+0x48>
      for (int i = 0; i < avail; i++)
    2472:	01205863          	blez	s2,2482 <execout+0x6c>
        sbrk(-PGSIZE);
    2476:	757d                	lui	a0,0xfffff
    2478:	7c7020ef          	jal	ra,543e <sbrk>
      for (int i = 0; i < avail; i++)
    247c:	2485                	addiw	s1,s1,1
    247e:	ff249ce3          	bne	s1,s2,2476 <execout+0x60>
      close(1);
    2482:	4505                	li	a0,1
    2484:	016030ef          	jal	ra,549a <close>
      char *args[] = {"echo", "x", 0};
    2488:	00003517          	auipc	a0,0x3
    248c:	5e050513          	addi	a0,a0,1504 # 5a68 <malloc+0x11e>
    2490:	faa43c23          	sd	a0,-72(s0)
    2494:	00003797          	auipc	a5,0x3
    2498:	64478793          	addi	a5,a5,1604 # 5ad8 <malloc+0x18e>
    249c:	fcf43023          	sd	a5,-64(s0)
    24a0:	fc043423          	sd	zero,-56(s0)
      exec("echo", args);
    24a4:	fb840593          	addi	a1,s0,-72
    24a8:	002030ef          	jal	ra,54aa <exec>
      exit(0);
    24ac:	4501                	li	a0,0
    24ae:	7c5020ef          	jal	ra,5472 <exit>

00000000000024b2 <fourteen>:
{
    24b2:	1101                	addi	sp,sp,-32
    24b4:	ec06                	sd	ra,24(sp)
    24b6:	e822                	sd	s0,16(sp)
    24b8:	e426                	sd	s1,8(sp)
    24ba:	1000                	addi	s0,sp,32
    24bc:	84aa                	mv	s1,a0
  if (mkdir("12345678901234") != 0) {
    24be:	00004517          	auipc	a0,0x4
    24c2:	5da50513          	addi	a0,a0,1498 # 6a98 <malloc+0x114e>
    24c6:	014030ef          	jal	ra,54da <mkdir>
    24ca:	e555                	bnez	a0,2576 <fourteen+0xc4>
  if (mkdir("12345678901234/123456789012345") != 0) {
    24cc:	00004517          	auipc	a0,0x4
    24d0:	42450513          	addi	a0,a0,1060 # 68f0 <malloc+0xfa6>
    24d4:	006030ef          	jal	ra,54da <mkdir>
    24d8:	e94d                	bnez	a0,258a <fourteen+0xd8>
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    24da:	20000593          	li	a1,512
    24de:	00004517          	auipc	a0,0x4
    24e2:	46a50513          	addi	a0,a0,1130 # 6948 <malloc+0xffe>
    24e6:	7cd020ef          	jal	ra,54b2 <open>
  if (fd < 0) {
    24ea:	0a054a63          	bltz	a0,259e <fourteen+0xec>
  close(fd);
    24ee:	7ad020ef          	jal	ra,549a <close>
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    24f2:	4581                	li	a1,0
    24f4:	00004517          	auipc	a0,0x4
    24f8:	4cc50513          	addi	a0,a0,1228 # 69c0 <malloc+0x1076>
    24fc:	7b7020ef          	jal	ra,54b2 <open>
  if (fd < 0) {
    2500:	0a054963          	bltz	a0,25b2 <fourteen+0x100>
  close(fd);
    2504:	797020ef          	jal	ra,549a <close>
  if (mkdir("12345678901234/12345678901234") == 0) {
    2508:	00004517          	auipc	a0,0x4
    250c:	52850513          	addi	a0,a0,1320 # 6a30 <malloc+0x10e6>
    2510:	7cb020ef          	jal	ra,54da <mkdir>
    2514:	c94d                	beqz	a0,25c6 <fourteen+0x114>
  if (mkdir("123456789012345/12345678901234") == 0) {
    2516:	00004517          	auipc	a0,0x4
    251a:	57250513          	addi	a0,a0,1394 # 6a88 <malloc+0x113e>
    251e:	7bd020ef          	jal	ra,54da <mkdir>
    2522:	cd45                	beqz	a0,25da <fourteen+0x128>
  unlink("123456789012345/12345678901234");
    2524:	00004517          	auipc	a0,0x4
    2528:	56450513          	addi	a0,a0,1380 # 6a88 <malloc+0x113e>
    252c:	797020ef          	jal	ra,54c2 <unlink>
  unlink("12345678901234/12345678901234");
    2530:	00004517          	auipc	a0,0x4
    2534:	50050513          	addi	a0,a0,1280 # 6a30 <malloc+0x10e6>
    2538:	78b020ef          	jal	ra,54c2 <unlink>
  unlink("12345678901234/12345678901234/12345678901234");
    253c:	00004517          	auipc	a0,0x4
    2540:	48450513          	addi	a0,a0,1156 # 69c0 <malloc+0x1076>
    2544:	77f020ef          	jal	ra,54c2 <unlink>
  unlink("123456789012345/123456789012345/123456789012345");
    2548:	00004517          	auipc	a0,0x4
    254c:	40050513          	addi	a0,a0,1024 # 6948 <malloc+0xffe>
    2550:	773020ef          	jal	ra,54c2 <unlink>
  unlink("12345678901234/123456789012345");
    2554:	00004517          	auipc	a0,0x4
    2558:	39c50513          	addi	a0,a0,924 # 68f0 <malloc+0xfa6>
    255c:	767020ef          	jal	ra,54c2 <unlink>
  unlink("12345678901234");
    2560:	00004517          	auipc	a0,0x4
    2564:	53850513          	addi	a0,a0,1336 # 6a98 <malloc+0x114e>
    2568:	75b020ef          	jal	ra,54c2 <unlink>
}
    256c:	60e2                	ld	ra,24(sp)
    256e:	6442                	ld	s0,16(sp)
    2570:	64a2                	ld	s1,8(sp)
    2572:	6105                	addi	sp,sp,32
    2574:	8082                	ret
    printf("%s: mkdir 12345678901234 failed\n", s);
    2576:	85a6                	mv	a1,s1
    2578:	00004517          	auipc	a0,0x4
    257c:	35050513          	addi	a0,a0,848 # 68c8 <malloc+0xf7e>
    2580:	316030ef          	jal	ra,5896 <printf>
    exit(1);
    2584:	4505                	li	a0,1
    2586:	6ed020ef          	jal	ra,5472 <exit>
    printf("%s: mkdir 12345678901234/123456789012345 failed\n", s);
    258a:	85a6                	mv	a1,s1
    258c:	00004517          	auipc	a0,0x4
    2590:	38450513          	addi	a0,a0,900 # 6910 <malloc+0xfc6>
    2594:	302030ef          	jal	ra,5896 <printf>
    exit(1);
    2598:	4505                	li	a0,1
    259a:	6d9020ef          	jal	ra,5472 <exit>
    printf(
    259e:	85a6                	mv	a1,s1
    25a0:	00004517          	auipc	a0,0x4
    25a4:	3d850513          	addi	a0,a0,984 # 6978 <malloc+0x102e>
    25a8:	2ee030ef          	jal	ra,5896 <printf>
    exit(1);
    25ac:	4505                	li	a0,1
    25ae:	6c5020ef          	jal	ra,5472 <exit>
    printf("%s: open 12345678901234/12345678901234/12345678901234 failed\n", s);
    25b2:	85a6                	mv	a1,s1
    25b4:	00004517          	auipc	a0,0x4
    25b8:	43c50513          	addi	a0,a0,1084 # 69f0 <malloc+0x10a6>
    25bc:	2da030ef          	jal	ra,5896 <printf>
    exit(1);
    25c0:	4505                	li	a0,1
    25c2:	6b1020ef          	jal	ra,5472 <exit>
    printf("%s: mkdir 12345678901234/12345678901234 succeeded!\n", s);
    25c6:	85a6                	mv	a1,s1
    25c8:	00004517          	auipc	a0,0x4
    25cc:	48850513          	addi	a0,a0,1160 # 6a50 <malloc+0x1106>
    25d0:	2c6030ef          	jal	ra,5896 <printf>
    exit(1);
    25d4:	4505                	li	a0,1
    25d6:	69d020ef          	jal	ra,5472 <exit>
    printf("%s: mkdir 12345678901234/123456789012345 succeeded!\n", s);
    25da:	85a6                	mv	a1,s1
    25dc:	00004517          	auipc	a0,0x4
    25e0:	4cc50513          	addi	a0,a0,1228 # 6aa8 <malloc+0x115e>
    25e4:	2b2030ef          	jal	ra,5896 <printf>
    exit(1);
    25e8:	4505                	li	a0,1
    25ea:	689020ef          	jal	ra,5472 <exit>

00000000000025ee <diskfull>:
{
    25ee:	b8010113          	addi	sp,sp,-1152
    25f2:	46113c23          	sd	ra,1144(sp)
    25f6:	46813823          	sd	s0,1136(sp)
    25fa:	46913423          	sd	s1,1128(sp)
    25fe:	47213023          	sd	s2,1120(sp)
    2602:	45313c23          	sd	s3,1112(sp)
    2606:	45413823          	sd	s4,1104(sp)
    260a:	45513423          	sd	s5,1096(sp)
    260e:	45613023          	sd	s6,1088(sp)
    2612:	43713c23          	sd	s7,1080(sp)
    2616:	43813823          	sd	s8,1072(sp)
    261a:	43913423          	sd	s9,1064(sp)
    261e:	48010413          	addi	s0,sp,1152
    2622:	8caa                	mv	s9,a0
  unlink("diskfulldir");
    2624:	00004517          	auipc	a0,0x4
    2628:	4bc50513          	addi	a0,a0,1212 # 6ae0 <malloc+0x1196>
    262c:	697020ef          	jal	ra,54c2 <unlink>
    2630:	03000993          	li	s3,48
    name[0] = 'b';
    2634:	06200b13          	li	s6,98
    name[1] = 'i';
    2638:	06900a93          	li	s5,105
    name[2] = 'g';
    263c:	06700a13          	li	s4,103
    2640:	10c00b93          	li	s7,268
  for (fi = 0; done == 0 && '0' + fi < 0177; fi++) {
    2644:	07f00c13          	li	s8,127
    2648:	aab9                	j	27a6 <diskfull+0x1b8>
      printf("%s: could not create file %s\n", s, name);
    264a:	b8040613          	addi	a2,s0,-1152
    264e:	85e6                	mv	a1,s9
    2650:	00004517          	auipc	a0,0x4
    2654:	4a050513          	addi	a0,a0,1184 # 6af0 <malloc+0x11a6>
    2658:	23e030ef          	jal	ra,5896 <printf>
      break;
    265c:	a039                	j	266a <diskfull+0x7c>
        close(fd);
    265e:	854a                	mv	a0,s2
    2660:	63b020ef          	jal	ra,549a <close>
    close(fd);
    2664:	854a                	mv	a0,s2
    2666:	635020ef          	jal	ra,549a <close>
  for (int i = 0; i < nzz; i++) {
    266a:	4481                	li	s1,0
    name[0] = 'z';
    266c:	07a00913          	li	s2,122
  for (int i = 0; i < nzz; i++) {
    2670:	08000993          	li	s3,128
    name[0] = 'z';
    2674:	bb240023          	sb	s2,-1120(s0)
    name[1] = 'z';
    2678:	bb2400a3          	sb	s2,-1119(s0)
    name[2] = '0' + (i / 32);
    267c:	41f4d71b          	sraiw	a4,s1,0x1f
    2680:	01b7571b          	srliw	a4,a4,0x1b
    2684:	009707bb          	addw	a5,a4,s1
    2688:	4057d69b          	sraiw	a3,a5,0x5
    268c:	0306869b          	addiw	a3,a3,48
    2690:	bad40123          	sb	a3,-1118(s0)
    name[3] = '0' + (i % 32);
    2694:	8bfd                	andi	a5,a5,31
    2696:	9f99                	subw	a5,a5,a4
    2698:	0307879b          	addiw	a5,a5,48
    269c:	baf401a3          	sb	a5,-1117(s0)
    name[4] = '\0';
    26a0:	ba040223          	sb	zero,-1116(s0)
    unlink(name);
    26a4:	ba040513          	addi	a0,s0,-1120
    26a8:	61b020ef          	jal	ra,54c2 <unlink>
    int fd = open(name, O_CREATE | O_RDWR | O_TRUNC);
    26ac:	60200593          	li	a1,1538
    26b0:	ba040513          	addi	a0,s0,-1120
    26b4:	5ff020ef          	jal	ra,54b2 <open>
    if (fd < 0)
    26b8:	00054763          	bltz	a0,26c6 <diskfull+0xd8>
    close(fd);
    26bc:	5df020ef          	jal	ra,549a <close>
  for (int i = 0; i < nzz; i++) {
    26c0:	2485                	addiw	s1,s1,1
    26c2:	fb3499e3          	bne	s1,s3,2674 <diskfull+0x86>
  if (mkdir("diskfulldir") == 0)
    26c6:	00004517          	auipc	a0,0x4
    26ca:	41a50513          	addi	a0,a0,1050 # 6ae0 <malloc+0x1196>
    26ce:	60d020ef          	jal	ra,54da <mkdir>
    26d2:	12050063          	beqz	a0,27f2 <diskfull+0x204>
  unlink("diskfulldir");
    26d6:	00004517          	auipc	a0,0x4
    26da:	40a50513          	addi	a0,a0,1034 # 6ae0 <malloc+0x1196>
    26de:	5e5020ef          	jal	ra,54c2 <unlink>
  for (int i = 0; i < nzz; i++) {
    26e2:	4481                	li	s1,0
    name[0] = 'z';
    26e4:	07a00913          	li	s2,122
  for (int i = 0; i < nzz; i++) {
    26e8:	08000993          	li	s3,128
    name[0] = 'z';
    26ec:	bb240023          	sb	s2,-1120(s0)
    name[1] = 'z';
    26f0:	bb2400a3          	sb	s2,-1119(s0)
    name[2] = '0' + (i / 32);
    26f4:	41f4d71b          	sraiw	a4,s1,0x1f
    26f8:	01b7571b          	srliw	a4,a4,0x1b
    26fc:	009707bb          	addw	a5,a4,s1
    2700:	4057d69b          	sraiw	a3,a5,0x5
    2704:	0306869b          	addiw	a3,a3,48
    2708:	bad40123          	sb	a3,-1118(s0)
    name[3] = '0' + (i % 32);
    270c:	8bfd                	andi	a5,a5,31
    270e:	9f99                	subw	a5,a5,a4
    2710:	0307879b          	addiw	a5,a5,48
    2714:	baf401a3          	sb	a5,-1117(s0)
    name[4] = '\0';
    2718:	ba040223          	sb	zero,-1116(s0)
    unlink(name);
    271c:	ba040513          	addi	a0,s0,-1120
    2720:	5a3020ef          	jal	ra,54c2 <unlink>
  for (int i = 0; i < nzz; i++) {
    2724:	2485                	addiw	s1,s1,1
    2726:	fd3493e3          	bne	s1,s3,26ec <diskfull+0xfe>
    272a:	03000493          	li	s1,48
    name[0] = 'b';
    272e:	06200a93          	li	s5,98
    name[1] = 'i';
    2732:	06900a13          	li	s4,105
    name[2] = 'g';
    2736:	06700993          	li	s3,103
  for (int i = 0; '0' + i < 0177; i++) {
    273a:	07f00913          	li	s2,127
    name[0] = 'b';
    273e:	bb540023          	sb	s5,-1120(s0)
    name[1] = 'i';
    2742:	bb4400a3          	sb	s4,-1119(s0)
    name[2] = 'g';
    2746:	bb340123          	sb	s3,-1118(s0)
    name[3] = '0' + i;
    274a:	ba9401a3          	sb	s1,-1117(s0)
    name[4] = '\0';
    274e:	ba040223          	sb	zero,-1116(s0)
    unlink(name);
    2752:	ba040513          	addi	a0,s0,-1120
    2756:	56d020ef          	jal	ra,54c2 <unlink>
  for (int i = 0; '0' + i < 0177; i++) {
    275a:	2485                	addiw	s1,s1,1
    275c:	0ff4f493          	zext.b	s1,s1
    2760:	fd249fe3          	bne	s1,s2,273e <diskfull+0x150>
}
    2764:	47813083          	ld	ra,1144(sp)
    2768:	47013403          	ld	s0,1136(sp)
    276c:	46813483          	ld	s1,1128(sp)
    2770:	46013903          	ld	s2,1120(sp)
    2774:	45813983          	ld	s3,1112(sp)
    2778:	45013a03          	ld	s4,1104(sp)
    277c:	44813a83          	ld	s5,1096(sp)
    2780:	44013b03          	ld	s6,1088(sp)
    2784:	43813b83          	ld	s7,1080(sp)
    2788:	43013c03          	ld	s8,1072(sp)
    278c:	42813c83          	ld	s9,1064(sp)
    2790:	48010113          	addi	sp,sp,1152
    2794:	8082                	ret
    close(fd);
    2796:	854a                	mv	a0,s2
    2798:	503020ef          	jal	ra,549a <close>
  for (fi = 0; done == 0 && '0' + fi < 0177; fi++) {
    279c:	2985                	addiw	s3,s3,1
    279e:	0ff9f993          	zext.b	s3,s3
    27a2:	ed8984e3          	beq	s3,s8,266a <diskfull+0x7c>
    name[0] = 'b';
    27a6:	b9640023          	sb	s6,-1152(s0)
    name[1] = 'i';
    27aa:	b95400a3          	sb	s5,-1151(s0)
    name[2] = 'g';
    27ae:	b9440123          	sb	s4,-1150(s0)
    name[3] = '0' + fi;
    27b2:	b93401a3          	sb	s3,-1149(s0)
    name[4] = '\0';
    27b6:	b8040223          	sb	zero,-1148(s0)
    unlink(name);
    27ba:	b8040513          	addi	a0,s0,-1152
    27be:	505020ef          	jal	ra,54c2 <unlink>
    int fd = open(name, O_CREATE | O_RDWR | O_TRUNC);
    27c2:	60200593          	li	a1,1538
    27c6:	b8040513          	addi	a0,s0,-1152
    27ca:	4e9020ef          	jal	ra,54b2 <open>
    27ce:	892a                	mv	s2,a0
    if (fd < 0) {
    27d0:	e6054de3          	bltz	a0,264a <diskfull+0x5c>
    27d4:	84de                	mv	s1,s7
      if (write(fd, buf, BSIZE) != BSIZE) {
    27d6:	40000613          	li	a2,1024
    27da:	ba040593          	addi	a1,s0,-1120
    27de:	854a                	mv	a0,s2
    27e0:	4b3020ef          	jal	ra,5492 <write>
    27e4:	40000793          	li	a5,1024
    27e8:	e6f51be3          	bne	a0,a5,265e <diskfull+0x70>
    for (int i = 0; i < MAXFILE; i++) {
    27ec:	34fd                	addiw	s1,s1,-1
    27ee:	f4e5                	bnez	s1,27d6 <diskfull+0x1e8>
    27f0:	b75d                	j	2796 <diskfull+0x1a8>
    printf("%s: mkdir(diskfulldir) unexpectedly succeeded!\n", s);
    27f2:	85e6                	mv	a1,s9
    27f4:	00004517          	auipc	a0,0x4
    27f8:	31c50513          	addi	a0,a0,796 # 6b10 <malloc+0x11c6>
    27fc:	09a030ef          	jal	ra,5896 <printf>
    2800:	bdd9                	j	26d6 <diskfull+0xe8>

0000000000002802 <iputtest>:
{
    2802:	1101                	addi	sp,sp,-32
    2804:	ec06                	sd	ra,24(sp)
    2806:	e822                	sd	s0,16(sp)
    2808:	e426                	sd	s1,8(sp)
    280a:	1000                	addi	s0,sp,32
    280c:	84aa                	mv	s1,a0
  if (mkdir("iputdir") < 0) {
    280e:	00004517          	auipc	a0,0x4
    2812:	33250513          	addi	a0,a0,818 # 6b40 <malloc+0x11f6>
    2816:	4c5020ef          	jal	ra,54da <mkdir>
    281a:	02054f63          	bltz	a0,2858 <iputtest+0x56>
  if (chdir("iputdir") < 0) {
    281e:	00004517          	auipc	a0,0x4
    2822:	32250513          	addi	a0,a0,802 # 6b40 <malloc+0x11f6>
    2826:	4bd020ef          	jal	ra,54e2 <chdir>
    282a:	04054163          	bltz	a0,286c <iputtest+0x6a>
  if (unlink("../iputdir") < 0) {
    282e:	00004517          	auipc	a0,0x4
    2832:	35250513          	addi	a0,a0,850 # 6b80 <malloc+0x1236>
    2836:	48d020ef          	jal	ra,54c2 <unlink>
    283a:	04054363          	bltz	a0,2880 <iputtest+0x7e>
  if (chdir("/") < 0) {
    283e:	00004517          	auipc	a0,0x4
    2842:	37250513          	addi	a0,a0,882 # 6bb0 <malloc+0x1266>
    2846:	49d020ef          	jal	ra,54e2 <chdir>
    284a:	04054563          	bltz	a0,2894 <iputtest+0x92>
}
    284e:	60e2                	ld	ra,24(sp)
    2850:	6442                	ld	s0,16(sp)
    2852:	64a2                	ld	s1,8(sp)
    2854:	6105                	addi	sp,sp,32
    2856:	8082                	ret
    printf("%s: mkdir failed\n", s);
    2858:	85a6                	mv	a1,s1
    285a:	00004517          	auipc	a0,0x4
    285e:	2ee50513          	addi	a0,a0,750 # 6b48 <malloc+0x11fe>
    2862:	034030ef          	jal	ra,5896 <printf>
    exit(1);
    2866:	4505                	li	a0,1
    2868:	40b020ef          	jal	ra,5472 <exit>
    printf("%s: chdir iputdir failed\n", s);
    286c:	85a6                	mv	a1,s1
    286e:	00004517          	auipc	a0,0x4
    2872:	2f250513          	addi	a0,a0,754 # 6b60 <malloc+0x1216>
    2876:	020030ef          	jal	ra,5896 <printf>
    exit(1);
    287a:	4505                	li	a0,1
    287c:	3f7020ef          	jal	ra,5472 <exit>
    printf("%s: unlink ../iputdir failed\n", s);
    2880:	85a6                	mv	a1,s1
    2882:	00004517          	auipc	a0,0x4
    2886:	30e50513          	addi	a0,a0,782 # 6b90 <malloc+0x1246>
    288a:	00c030ef          	jal	ra,5896 <printf>
    exit(1);
    288e:	4505                	li	a0,1
    2890:	3e3020ef          	jal	ra,5472 <exit>
    printf("%s: chdir / failed\n", s);
    2894:	85a6                	mv	a1,s1
    2896:	00004517          	auipc	a0,0x4
    289a:	32250513          	addi	a0,a0,802 # 6bb8 <malloc+0x126e>
    289e:	7f9020ef          	jal	ra,5896 <printf>
    exit(1);
    28a2:	4505                	li	a0,1
    28a4:	3cf020ef          	jal	ra,5472 <exit>

00000000000028a8 <exitiputtest>:
{
    28a8:	7179                	addi	sp,sp,-48
    28aa:	f406                	sd	ra,40(sp)
    28ac:	f022                	sd	s0,32(sp)
    28ae:	ec26                	sd	s1,24(sp)
    28b0:	1800                	addi	s0,sp,48
    28b2:	84aa                	mv	s1,a0
  pid = fork();
    28b4:	3b7020ef          	jal	ra,546a <fork>
  if (pid < 0) {
    28b8:	02054e63          	bltz	a0,28f4 <exitiputtest+0x4c>
  if (pid == 0) {
    28bc:	e541                	bnez	a0,2944 <exitiputtest+0x9c>
    if (mkdir("iputdir") < 0) {
    28be:	00004517          	auipc	a0,0x4
    28c2:	28250513          	addi	a0,a0,642 # 6b40 <malloc+0x11f6>
    28c6:	415020ef          	jal	ra,54da <mkdir>
    28ca:	02054f63          	bltz	a0,2908 <exitiputtest+0x60>
    if (chdir("iputdir") < 0) {
    28ce:	00004517          	auipc	a0,0x4
    28d2:	27250513          	addi	a0,a0,626 # 6b40 <malloc+0x11f6>
    28d6:	40d020ef          	jal	ra,54e2 <chdir>
    28da:	04054163          	bltz	a0,291c <exitiputtest+0x74>
    if (unlink("../iputdir") < 0) {
    28de:	00004517          	auipc	a0,0x4
    28e2:	2a250513          	addi	a0,a0,674 # 6b80 <malloc+0x1236>
    28e6:	3dd020ef          	jal	ra,54c2 <unlink>
    28ea:	04054363          	bltz	a0,2930 <exitiputtest+0x88>
    exit(0);
    28ee:	4501                	li	a0,0
    28f0:	383020ef          	jal	ra,5472 <exit>
    printf("%s: fork failed\n", s);
    28f4:	85a6                	mv	a1,s1
    28f6:	00004517          	auipc	a0,0x4
    28fa:	a0250513          	addi	a0,a0,-1534 # 62f8 <malloc+0x9ae>
    28fe:	799020ef          	jal	ra,5896 <printf>
    exit(1);
    2902:	4505                	li	a0,1
    2904:	36f020ef          	jal	ra,5472 <exit>
      printf("%s: mkdir failed\n", s);
    2908:	85a6                	mv	a1,s1
    290a:	00004517          	auipc	a0,0x4
    290e:	23e50513          	addi	a0,a0,574 # 6b48 <malloc+0x11fe>
    2912:	785020ef          	jal	ra,5896 <printf>
      exit(1);
    2916:	4505                	li	a0,1
    2918:	35b020ef          	jal	ra,5472 <exit>
      printf("%s: child chdir failed\n", s);
    291c:	85a6                	mv	a1,s1
    291e:	00004517          	auipc	a0,0x4
    2922:	2b250513          	addi	a0,a0,690 # 6bd0 <malloc+0x1286>
    2926:	771020ef          	jal	ra,5896 <printf>
      exit(1);
    292a:	4505                	li	a0,1
    292c:	347020ef          	jal	ra,5472 <exit>
      printf("%s: unlink ../iputdir failed\n", s);
    2930:	85a6                	mv	a1,s1
    2932:	00004517          	auipc	a0,0x4
    2936:	25e50513          	addi	a0,a0,606 # 6b90 <malloc+0x1246>
    293a:	75d020ef          	jal	ra,5896 <printf>
      exit(1);
    293e:	4505                	li	a0,1
    2940:	333020ef          	jal	ra,5472 <exit>
  wait(&xstatus);
    2944:	fdc40513          	addi	a0,s0,-36
    2948:	333020ef          	jal	ra,547a <wait>
  exit(xstatus);
    294c:	fdc42503          	lw	a0,-36(s0)
    2950:	323020ef          	jal	ra,5472 <exit>

0000000000002954 <dirtest>:
{
    2954:	1101                	addi	sp,sp,-32
    2956:	ec06                	sd	ra,24(sp)
    2958:	e822                	sd	s0,16(sp)
    295a:	e426                	sd	s1,8(sp)
    295c:	1000                	addi	s0,sp,32
    295e:	84aa                	mv	s1,a0
  if (mkdir("dir0") < 0) {
    2960:	00004517          	auipc	a0,0x4
    2964:	28850513          	addi	a0,a0,648 # 6be8 <malloc+0x129e>
    2968:	373020ef          	jal	ra,54da <mkdir>
    296c:	02054f63          	bltz	a0,29aa <dirtest+0x56>
  if (chdir("dir0") < 0) {
    2970:	00004517          	auipc	a0,0x4
    2974:	27850513          	addi	a0,a0,632 # 6be8 <malloc+0x129e>
    2978:	36b020ef          	jal	ra,54e2 <chdir>
    297c:	04054163          	bltz	a0,29be <dirtest+0x6a>
  if (chdir("..") < 0) {
    2980:	00004517          	auipc	a0,0x4
    2984:	28850513          	addi	a0,a0,648 # 6c08 <malloc+0x12be>
    2988:	35b020ef          	jal	ra,54e2 <chdir>
    298c:	04054363          	bltz	a0,29d2 <dirtest+0x7e>
  if (unlink("dir0") < 0) {
    2990:	00004517          	auipc	a0,0x4
    2994:	25850513          	addi	a0,a0,600 # 6be8 <malloc+0x129e>
    2998:	32b020ef          	jal	ra,54c2 <unlink>
    299c:	04054563          	bltz	a0,29e6 <dirtest+0x92>
}
    29a0:	60e2                	ld	ra,24(sp)
    29a2:	6442                	ld	s0,16(sp)
    29a4:	64a2                	ld	s1,8(sp)
    29a6:	6105                	addi	sp,sp,32
    29a8:	8082                	ret
    printf("%s: mkdir failed\n", s);
    29aa:	85a6                	mv	a1,s1
    29ac:	00004517          	auipc	a0,0x4
    29b0:	19c50513          	addi	a0,a0,412 # 6b48 <malloc+0x11fe>
    29b4:	6e3020ef          	jal	ra,5896 <printf>
    exit(1);
    29b8:	4505                	li	a0,1
    29ba:	2b9020ef          	jal	ra,5472 <exit>
    printf("%s: chdir dir0 failed\n", s);
    29be:	85a6                	mv	a1,s1
    29c0:	00004517          	auipc	a0,0x4
    29c4:	23050513          	addi	a0,a0,560 # 6bf0 <malloc+0x12a6>
    29c8:	6cf020ef          	jal	ra,5896 <printf>
    exit(1);
    29cc:	4505                	li	a0,1
    29ce:	2a5020ef          	jal	ra,5472 <exit>
    printf("%s: chdir .. failed\n", s);
    29d2:	85a6                	mv	a1,s1
    29d4:	00004517          	auipc	a0,0x4
    29d8:	23c50513          	addi	a0,a0,572 # 6c10 <malloc+0x12c6>
    29dc:	6bb020ef          	jal	ra,5896 <printf>
    exit(1);
    29e0:	4505                	li	a0,1
    29e2:	291020ef          	jal	ra,5472 <exit>
    printf("%s: unlink dir0 failed\n", s);
    29e6:	85a6                	mv	a1,s1
    29e8:	00004517          	auipc	a0,0x4
    29ec:	24050513          	addi	a0,a0,576 # 6c28 <malloc+0x12de>
    29f0:	6a7020ef          	jal	ra,5896 <printf>
    exit(1);
    29f4:	4505                	li	a0,1
    29f6:	27d020ef          	jal	ra,5472 <exit>

00000000000029fa <subdir>:
{
    29fa:	1101                	addi	sp,sp,-32
    29fc:	ec06                	sd	ra,24(sp)
    29fe:	e822                	sd	s0,16(sp)
    2a00:	e426                	sd	s1,8(sp)
    2a02:	e04a                	sd	s2,0(sp)
    2a04:	1000                	addi	s0,sp,32
    2a06:	892a                	mv	s2,a0
  unlink("ff");
    2a08:	00004517          	auipc	a0,0x4
    2a0c:	36850513          	addi	a0,a0,872 # 6d70 <malloc+0x1426>
    2a10:	2b3020ef          	jal	ra,54c2 <unlink>
  if (mkdir("dd") != 0) {
    2a14:	00004517          	auipc	a0,0x4
    2a18:	22c50513          	addi	a0,a0,556 # 6c40 <malloc+0x12f6>
    2a1c:	2bf020ef          	jal	ra,54da <mkdir>
    2a20:	2e051263          	bnez	a0,2d04 <subdir+0x30a>
  fd = open("dd/ff", O_CREATE | O_RDWR);
    2a24:	20200593          	li	a1,514
    2a28:	00004517          	auipc	a0,0x4
    2a2c:	23850513          	addi	a0,a0,568 # 6c60 <malloc+0x1316>
    2a30:	283020ef          	jal	ra,54b2 <open>
    2a34:	84aa                	mv	s1,a0
  if (fd < 0) {
    2a36:	2e054163          	bltz	a0,2d18 <subdir+0x31e>
  write(fd, "ff", 2);
    2a3a:	4609                	li	a2,2
    2a3c:	00004597          	auipc	a1,0x4
    2a40:	33458593          	addi	a1,a1,820 # 6d70 <malloc+0x1426>
    2a44:	24f020ef          	jal	ra,5492 <write>
  close(fd);
    2a48:	8526                	mv	a0,s1
    2a4a:	251020ef          	jal	ra,549a <close>
  if (unlink("dd") >= 0) {
    2a4e:	00004517          	auipc	a0,0x4
    2a52:	1f250513          	addi	a0,a0,498 # 6c40 <malloc+0x12f6>
    2a56:	26d020ef          	jal	ra,54c2 <unlink>
    2a5a:	2c055963          	bgez	a0,2d2c <subdir+0x332>
  if (mkdir("/dd/dd") != 0) {
    2a5e:	00004517          	auipc	a0,0x4
    2a62:	25a50513          	addi	a0,a0,602 # 6cb8 <malloc+0x136e>
    2a66:	275020ef          	jal	ra,54da <mkdir>
    2a6a:	2c051b63          	bnez	a0,2d40 <subdir+0x346>
  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    2a6e:	20200593          	li	a1,514
    2a72:	00004517          	auipc	a0,0x4
    2a76:	26e50513          	addi	a0,a0,622 # 6ce0 <malloc+0x1396>
    2a7a:	239020ef          	jal	ra,54b2 <open>
    2a7e:	84aa                	mv	s1,a0
  if (fd < 0) {
    2a80:	2c054a63          	bltz	a0,2d54 <subdir+0x35a>
  write(fd, "FF", 2);
    2a84:	4609                	li	a2,2
    2a86:	00004597          	auipc	a1,0x4
    2a8a:	28a58593          	addi	a1,a1,650 # 6d10 <malloc+0x13c6>
    2a8e:	205020ef          	jal	ra,5492 <write>
  close(fd);
    2a92:	8526                	mv	a0,s1
    2a94:	207020ef          	jal	ra,549a <close>
  fd = open("dd/dd/../ff", 0);
    2a98:	4581                	li	a1,0
    2a9a:	00004517          	auipc	a0,0x4
    2a9e:	27e50513          	addi	a0,a0,638 # 6d18 <malloc+0x13ce>
    2aa2:	211020ef          	jal	ra,54b2 <open>
    2aa6:	84aa                	mv	s1,a0
  if (fd < 0) {
    2aa8:	2c054063          	bltz	a0,2d68 <subdir+0x36e>
  cc = read(fd, buf, sizeof(buf));
    2aac:	660d                	lui	a2,0x3
    2aae:	0000a597          	auipc	a1,0xa
    2ab2:	24a58593          	addi	a1,a1,586 # ccf8 <buf>
    2ab6:	1d5020ef          	jal	ra,548a <read>
  if (cc != 2 || buf[0] != 'f') {
    2aba:	4789                	li	a5,2
    2abc:	2cf51063          	bne	a0,a5,2d7c <subdir+0x382>
    2ac0:	0000a717          	auipc	a4,0xa
    2ac4:	23874703          	lbu	a4,568(a4) # ccf8 <buf>
    2ac8:	06600793          	li	a5,102
    2acc:	2af71863          	bne	a4,a5,2d7c <subdir+0x382>
  close(fd);
    2ad0:	8526                	mv	a0,s1
    2ad2:	1c9020ef          	jal	ra,549a <close>
  if (link("dd/dd/ff", "dd/dd/ffff") != 0) {
    2ad6:	00004597          	auipc	a1,0x4
    2ada:	29258593          	addi	a1,a1,658 # 6d68 <malloc+0x141e>
    2ade:	00004517          	auipc	a0,0x4
    2ae2:	20250513          	addi	a0,a0,514 # 6ce0 <malloc+0x1396>
    2ae6:	1ed020ef          	jal	ra,54d2 <link>
    2aea:	2a051363          	bnez	a0,2d90 <subdir+0x396>
  if (unlink("dd/dd/ff") != 0) {
    2aee:	00004517          	auipc	a0,0x4
    2af2:	1f250513          	addi	a0,a0,498 # 6ce0 <malloc+0x1396>
    2af6:	1cd020ef          	jal	ra,54c2 <unlink>
    2afa:	2a051563          	bnez	a0,2da4 <subdir+0x3aa>
  if (open("dd/dd/ff", O_RDONLY) >= 0) {
    2afe:	4581                	li	a1,0
    2b00:	00004517          	auipc	a0,0x4
    2b04:	1e050513          	addi	a0,a0,480 # 6ce0 <malloc+0x1396>
    2b08:	1ab020ef          	jal	ra,54b2 <open>
    2b0c:	2a055663          	bgez	a0,2db8 <subdir+0x3be>
  if (chdir("dd") != 0) {
    2b10:	00004517          	auipc	a0,0x4
    2b14:	13050513          	addi	a0,a0,304 # 6c40 <malloc+0x12f6>
    2b18:	1cb020ef          	jal	ra,54e2 <chdir>
    2b1c:	2a051863          	bnez	a0,2dcc <subdir+0x3d2>
  if (chdir("dd/../../dd") != 0) {
    2b20:	00004517          	auipc	a0,0x4
    2b24:	2e050513          	addi	a0,a0,736 # 6e00 <malloc+0x14b6>
    2b28:	1bb020ef          	jal	ra,54e2 <chdir>
    2b2c:	2a051a63          	bnez	a0,2de0 <subdir+0x3e6>
  if (chdir("dd/../../../dd") != 0) {
    2b30:	00004517          	auipc	a0,0x4
    2b34:	30050513          	addi	a0,a0,768 # 6e30 <malloc+0x14e6>
    2b38:	1ab020ef          	jal	ra,54e2 <chdir>
    2b3c:	2a051c63          	bnez	a0,2df4 <subdir+0x3fa>
  if (chdir("./..") != 0) {
    2b40:	00004517          	auipc	a0,0x4
    2b44:	32850513          	addi	a0,a0,808 # 6e68 <malloc+0x151e>
    2b48:	19b020ef          	jal	ra,54e2 <chdir>
    2b4c:	2a051e63          	bnez	a0,2e08 <subdir+0x40e>
  fd = open("dd/dd/ffff", 0);
    2b50:	4581                	li	a1,0
    2b52:	00004517          	auipc	a0,0x4
    2b56:	21650513          	addi	a0,a0,534 # 6d68 <malloc+0x141e>
    2b5a:	159020ef          	jal	ra,54b2 <open>
    2b5e:	84aa                	mv	s1,a0
  if (fd < 0) {
    2b60:	2a054e63          	bltz	a0,2e1c <subdir+0x422>
  if (read(fd, buf, sizeof(buf)) != 2) {
    2b64:	660d                	lui	a2,0x3
    2b66:	0000a597          	auipc	a1,0xa
    2b6a:	19258593          	addi	a1,a1,402 # ccf8 <buf>
    2b6e:	11d020ef          	jal	ra,548a <read>
    2b72:	4789                	li	a5,2
    2b74:	2af51e63          	bne	a0,a5,2e30 <subdir+0x436>
  close(fd);
    2b78:	8526                	mv	a0,s1
    2b7a:	121020ef          	jal	ra,549a <close>
  if (open("dd/dd/ff", O_RDONLY) >= 0) {
    2b7e:	4581                	li	a1,0
    2b80:	00004517          	auipc	a0,0x4
    2b84:	16050513          	addi	a0,a0,352 # 6ce0 <malloc+0x1396>
    2b88:	12b020ef          	jal	ra,54b2 <open>
    2b8c:	2a055c63          	bgez	a0,2e44 <subdir+0x44a>
  if (open("dd/ff/ff", O_CREATE | O_RDWR) >= 0) {
    2b90:	20200593          	li	a1,514
    2b94:	00004517          	auipc	a0,0x4
    2b98:	36450513          	addi	a0,a0,868 # 6ef8 <malloc+0x15ae>
    2b9c:	117020ef          	jal	ra,54b2 <open>
    2ba0:	2a055c63          	bgez	a0,2e58 <subdir+0x45e>
  if (open("dd/xx/ff", O_CREATE | O_RDWR) >= 0) {
    2ba4:	20200593          	li	a1,514
    2ba8:	00004517          	auipc	a0,0x4
    2bac:	38050513          	addi	a0,a0,896 # 6f28 <malloc+0x15de>
    2bb0:	103020ef          	jal	ra,54b2 <open>
    2bb4:	2a055c63          	bgez	a0,2e6c <subdir+0x472>
  if (open("dd", O_CREATE) >= 0) {
    2bb8:	20000593          	li	a1,512
    2bbc:	00004517          	auipc	a0,0x4
    2bc0:	08450513          	addi	a0,a0,132 # 6c40 <malloc+0x12f6>
    2bc4:	0ef020ef          	jal	ra,54b2 <open>
    2bc8:	2a055c63          	bgez	a0,2e80 <subdir+0x486>
  if (open("dd", O_RDWR) >= 0) {
    2bcc:	4589                	li	a1,2
    2bce:	00004517          	auipc	a0,0x4
    2bd2:	07250513          	addi	a0,a0,114 # 6c40 <malloc+0x12f6>
    2bd6:	0dd020ef          	jal	ra,54b2 <open>
    2bda:	2a055d63          	bgez	a0,2e94 <subdir+0x49a>
  if (open("dd", O_WRONLY) >= 0) {
    2bde:	4585                	li	a1,1
    2be0:	00004517          	auipc	a0,0x4
    2be4:	06050513          	addi	a0,a0,96 # 6c40 <malloc+0x12f6>
    2be8:	0cb020ef          	jal	ra,54b2 <open>
    2bec:	2a055e63          	bgez	a0,2ea8 <subdir+0x4ae>
  if (link("dd/ff/ff", "dd/dd/xx") == 0) {
    2bf0:	00004597          	auipc	a1,0x4
    2bf4:	3c858593          	addi	a1,a1,968 # 6fb8 <malloc+0x166e>
    2bf8:	00004517          	auipc	a0,0x4
    2bfc:	30050513          	addi	a0,a0,768 # 6ef8 <malloc+0x15ae>
    2c00:	0d3020ef          	jal	ra,54d2 <link>
    2c04:	2a050c63          	beqz	a0,2ebc <subdir+0x4c2>
  if (link("dd/xx/ff", "dd/dd/xx") == 0) {
    2c08:	00004597          	auipc	a1,0x4
    2c0c:	3b058593          	addi	a1,a1,944 # 6fb8 <malloc+0x166e>
    2c10:	00004517          	auipc	a0,0x4
    2c14:	31850513          	addi	a0,a0,792 # 6f28 <malloc+0x15de>
    2c18:	0bb020ef          	jal	ra,54d2 <link>
    2c1c:	2a050a63          	beqz	a0,2ed0 <subdir+0x4d6>
  if (link("dd/ff", "dd/dd/ffff") == 0) {
    2c20:	00004597          	auipc	a1,0x4
    2c24:	14858593          	addi	a1,a1,328 # 6d68 <malloc+0x141e>
    2c28:	00004517          	auipc	a0,0x4
    2c2c:	03850513          	addi	a0,a0,56 # 6c60 <malloc+0x1316>
    2c30:	0a3020ef          	jal	ra,54d2 <link>
    2c34:	2a050863          	beqz	a0,2ee4 <subdir+0x4ea>
  if (mkdir("dd/ff/ff") == 0) {
    2c38:	00004517          	auipc	a0,0x4
    2c3c:	2c050513          	addi	a0,a0,704 # 6ef8 <malloc+0x15ae>
    2c40:	09b020ef          	jal	ra,54da <mkdir>
    2c44:	2a050a63          	beqz	a0,2ef8 <subdir+0x4fe>
  if (mkdir("dd/xx/ff") == 0) {
    2c48:	00004517          	auipc	a0,0x4
    2c4c:	2e050513          	addi	a0,a0,736 # 6f28 <malloc+0x15de>
    2c50:	08b020ef          	jal	ra,54da <mkdir>
    2c54:	2a050c63          	beqz	a0,2f0c <subdir+0x512>
  if (mkdir("dd/dd/ffff") == 0) {
    2c58:	00004517          	auipc	a0,0x4
    2c5c:	11050513          	addi	a0,a0,272 # 6d68 <malloc+0x141e>
    2c60:	07b020ef          	jal	ra,54da <mkdir>
    2c64:	2a050e63          	beqz	a0,2f20 <subdir+0x526>
  if (unlink("dd/xx/ff") == 0) {
    2c68:	00004517          	auipc	a0,0x4
    2c6c:	2c050513          	addi	a0,a0,704 # 6f28 <malloc+0x15de>
    2c70:	053020ef          	jal	ra,54c2 <unlink>
    2c74:	2c050063          	beqz	a0,2f34 <subdir+0x53a>
  if (unlink("dd/ff/ff") == 0) {
    2c78:	00004517          	auipc	a0,0x4
    2c7c:	28050513          	addi	a0,a0,640 # 6ef8 <malloc+0x15ae>
    2c80:	043020ef          	jal	ra,54c2 <unlink>
    2c84:	2c050263          	beqz	a0,2f48 <subdir+0x54e>
  if (chdir("dd/ff") == 0) {
    2c88:	00004517          	auipc	a0,0x4
    2c8c:	fd850513          	addi	a0,a0,-40 # 6c60 <malloc+0x1316>
    2c90:	053020ef          	jal	ra,54e2 <chdir>
    2c94:	2c050463          	beqz	a0,2f5c <subdir+0x562>
  if (chdir("dd/xx") == 0) {
    2c98:	00004517          	auipc	a0,0x4
    2c9c:	47050513          	addi	a0,a0,1136 # 7108 <malloc+0x17be>
    2ca0:	043020ef          	jal	ra,54e2 <chdir>
    2ca4:	2c050663          	beqz	a0,2f70 <subdir+0x576>
  if (unlink("dd/dd/ffff") != 0) {
    2ca8:	00004517          	auipc	a0,0x4
    2cac:	0c050513          	addi	a0,a0,192 # 6d68 <malloc+0x141e>
    2cb0:	013020ef          	jal	ra,54c2 <unlink>
    2cb4:	2c051863          	bnez	a0,2f84 <subdir+0x58a>
  if (unlink("dd/ff") != 0) {
    2cb8:	00004517          	auipc	a0,0x4
    2cbc:	fa850513          	addi	a0,a0,-88 # 6c60 <malloc+0x1316>
    2cc0:	003020ef          	jal	ra,54c2 <unlink>
    2cc4:	2c051a63          	bnez	a0,2f98 <subdir+0x59e>
  if (unlink("dd") == 0) {
    2cc8:	00004517          	auipc	a0,0x4
    2ccc:	f7850513          	addi	a0,a0,-136 # 6c40 <malloc+0x12f6>
    2cd0:	7f2020ef          	jal	ra,54c2 <unlink>
    2cd4:	2c050c63          	beqz	a0,2fac <subdir+0x5b2>
  if (unlink("dd/dd") < 0) {
    2cd8:	00004517          	auipc	a0,0x4
    2cdc:	4a050513          	addi	a0,a0,1184 # 7178 <malloc+0x182e>
    2ce0:	7e2020ef          	jal	ra,54c2 <unlink>
    2ce4:	2c054e63          	bltz	a0,2fc0 <subdir+0x5c6>
  if (unlink("dd") < 0) {
    2ce8:	00004517          	auipc	a0,0x4
    2cec:	f5850513          	addi	a0,a0,-168 # 6c40 <malloc+0x12f6>
    2cf0:	7d2020ef          	jal	ra,54c2 <unlink>
    2cf4:	2e054063          	bltz	a0,2fd4 <subdir+0x5da>
}
    2cf8:	60e2                	ld	ra,24(sp)
    2cfa:	6442                	ld	s0,16(sp)
    2cfc:	64a2                	ld	s1,8(sp)
    2cfe:	6902                	ld	s2,0(sp)
    2d00:	6105                	addi	sp,sp,32
    2d02:	8082                	ret
    printf("%s: mkdir dd failed\n", s);
    2d04:	85ca                	mv	a1,s2
    2d06:	00004517          	auipc	a0,0x4
    2d0a:	f4250513          	addi	a0,a0,-190 # 6c48 <malloc+0x12fe>
    2d0e:	389020ef          	jal	ra,5896 <printf>
    exit(1);
    2d12:	4505                	li	a0,1
    2d14:	75e020ef          	jal	ra,5472 <exit>
    printf("%s: create dd/ff failed\n", s);
    2d18:	85ca                	mv	a1,s2
    2d1a:	00004517          	auipc	a0,0x4
    2d1e:	f4e50513          	addi	a0,a0,-178 # 6c68 <malloc+0x131e>
    2d22:	375020ef          	jal	ra,5896 <printf>
    exit(1);
    2d26:	4505                	li	a0,1
    2d28:	74a020ef          	jal	ra,5472 <exit>
    printf("%s: unlink dd (non-empty dir) succeeded!\n", s);
    2d2c:	85ca                	mv	a1,s2
    2d2e:	00004517          	auipc	a0,0x4
    2d32:	f5a50513          	addi	a0,a0,-166 # 6c88 <malloc+0x133e>
    2d36:	361020ef          	jal	ra,5896 <printf>
    exit(1);
    2d3a:	4505                	li	a0,1
    2d3c:	736020ef          	jal	ra,5472 <exit>
    printf("%s: subdir mkdir dd/dd failed\n", s);
    2d40:	85ca                	mv	a1,s2
    2d42:	00004517          	auipc	a0,0x4
    2d46:	f7e50513          	addi	a0,a0,-130 # 6cc0 <malloc+0x1376>
    2d4a:	34d020ef          	jal	ra,5896 <printf>
    exit(1);
    2d4e:	4505                	li	a0,1
    2d50:	722020ef          	jal	ra,5472 <exit>
    printf("%s: create dd/dd/ff failed\n", s);
    2d54:	85ca                	mv	a1,s2
    2d56:	00004517          	auipc	a0,0x4
    2d5a:	f9a50513          	addi	a0,a0,-102 # 6cf0 <malloc+0x13a6>
    2d5e:	339020ef          	jal	ra,5896 <printf>
    exit(1);
    2d62:	4505                	li	a0,1
    2d64:	70e020ef          	jal	ra,5472 <exit>
    printf("%s: open dd/dd/../ff failed\n", s);
    2d68:	85ca                	mv	a1,s2
    2d6a:	00004517          	auipc	a0,0x4
    2d6e:	fbe50513          	addi	a0,a0,-66 # 6d28 <malloc+0x13de>
    2d72:	325020ef          	jal	ra,5896 <printf>
    exit(1);
    2d76:	4505                	li	a0,1
    2d78:	6fa020ef          	jal	ra,5472 <exit>
    printf("%s: dd/dd/../ff wrong content\n", s);
    2d7c:	85ca                	mv	a1,s2
    2d7e:	00004517          	auipc	a0,0x4
    2d82:	fca50513          	addi	a0,a0,-54 # 6d48 <malloc+0x13fe>
    2d86:	311020ef          	jal	ra,5896 <printf>
    exit(1);
    2d8a:	4505                	li	a0,1
    2d8c:	6e6020ef          	jal	ra,5472 <exit>
    printf("%s: link dd/dd/ff dd/dd/ffff failed\n", s);
    2d90:	85ca                	mv	a1,s2
    2d92:	00004517          	auipc	a0,0x4
    2d96:	fe650513          	addi	a0,a0,-26 # 6d78 <malloc+0x142e>
    2d9a:	2fd020ef          	jal	ra,5896 <printf>
    exit(1);
    2d9e:	4505                	li	a0,1
    2da0:	6d2020ef          	jal	ra,5472 <exit>
    printf("%s: unlink dd/dd/ff failed\n", s);
    2da4:	85ca                	mv	a1,s2
    2da6:	00004517          	auipc	a0,0x4
    2daa:	ffa50513          	addi	a0,a0,-6 # 6da0 <malloc+0x1456>
    2dae:	2e9020ef          	jal	ra,5896 <printf>
    exit(1);
    2db2:	4505                	li	a0,1
    2db4:	6be020ef          	jal	ra,5472 <exit>
    printf("%s: open (unlinked) dd/dd/ff succeeded\n", s);
    2db8:	85ca                	mv	a1,s2
    2dba:	00004517          	auipc	a0,0x4
    2dbe:	00650513          	addi	a0,a0,6 # 6dc0 <malloc+0x1476>
    2dc2:	2d5020ef          	jal	ra,5896 <printf>
    exit(1);
    2dc6:	4505                	li	a0,1
    2dc8:	6aa020ef          	jal	ra,5472 <exit>
    printf("%s: chdir dd failed\n", s);
    2dcc:	85ca                	mv	a1,s2
    2dce:	00004517          	auipc	a0,0x4
    2dd2:	01a50513          	addi	a0,a0,26 # 6de8 <malloc+0x149e>
    2dd6:	2c1020ef          	jal	ra,5896 <printf>
    exit(1);
    2dda:	4505                	li	a0,1
    2ddc:	696020ef          	jal	ra,5472 <exit>
    printf("%s: chdir dd/../../dd failed\n", s);
    2de0:	85ca                	mv	a1,s2
    2de2:	00004517          	auipc	a0,0x4
    2de6:	02e50513          	addi	a0,a0,46 # 6e10 <malloc+0x14c6>
    2dea:	2ad020ef          	jal	ra,5896 <printf>
    exit(1);
    2dee:	4505                	li	a0,1
    2df0:	682020ef          	jal	ra,5472 <exit>
    printf("%s: chdir dd/../../../dd failed\n", s);
    2df4:	85ca                	mv	a1,s2
    2df6:	00004517          	auipc	a0,0x4
    2dfa:	04a50513          	addi	a0,a0,74 # 6e40 <malloc+0x14f6>
    2dfe:	299020ef          	jal	ra,5896 <printf>
    exit(1);
    2e02:	4505                	li	a0,1
    2e04:	66e020ef          	jal	ra,5472 <exit>
    printf("%s: chdir ./.. failed\n", s);
    2e08:	85ca                	mv	a1,s2
    2e0a:	00004517          	auipc	a0,0x4
    2e0e:	06650513          	addi	a0,a0,102 # 6e70 <malloc+0x1526>
    2e12:	285020ef          	jal	ra,5896 <printf>
    exit(1);
    2e16:	4505                	li	a0,1
    2e18:	65a020ef          	jal	ra,5472 <exit>
    printf("%s: open dd/dd/ffff failed\n", s);
    2e1c:	85ca                	mv	a1,s2
    2e1e:	00004517          	auipc	a0,0x4
    2e22:	06a50513          	addi	a0,a0,106 # 6e88 <malloc+0x153e>
    2e26:	271020ef          	jal	ra,5896 <printf>
    exit(1);
    2e2a:	4505                	li	a0,1
    2e2c:	646020ef          	jal	ra,5472 <exit>
    printf("%s: read dd/dd/ffff wrong len\n", s);
    2e30:	85ca                	mv	a1,s2
    2e32:	00004517          	auipc	a0,0x4
    2e36:	07650513          	addi	a0,a0,118 # 6ea8 <malloc+0x155e>
    2e3a:	25d020ef          	jal	ra,5896 <printf>
    exit(1);
    2e3e:	4505                	li	a0,1
    2e40:	632020ef          	jal	ra,5472 <exit>
    printf("%s: open (unlinked) dd/dd/ff succeeded!\n", s);
    2e44:	85ca                	mv	a1,s2
    2e46:	00004517          	auipc	a0,0x4
    2e4a:	08250513          	addi	a0,a0,130 # 6ec8 <malloc+0x157e>
    2e4e:	249020ef          	jal	ra,5896 <printf>
    exit(1);
    2e52:	4505                	li	a0,1
    2e54:	61e020ef          	jal	ra,5472 <exit>
    printf("%s: create dd/ff/ff succeeded!\n", s);
    2e58:	85ca                	mv	a1,s2
    2e5a:	00004517          	auipc	a0,0x4
    2e5e:	0ae50513          	addi	a0,a0,174 # 6f08 <malloc+0x15be>
    2e62:	235020ef          	jal	ra,5896 <printf>
    exit(1);
    2e66:	4505                	li	a0,1
    2e68:	60a020ef          	jal	ra,5472 <exit>
    printf("%s: create dd/xx/ff succeeded!\n", s);
    2e6c:	85ca                	mv	a1,s2
    2e6e:	00004517          	auipc	a0,0x4
    2e72:	0ca50513          	addi	a0,a0,202 # 6f38 <malloc+0x15ee>
    2e76:	221020ef          	jal	ra,5896 <printf>
    exit(1);
    2e7a:	4505                	li	a0,1
    2e7c:	5f6020ef          	jal	ra,5472 <exit>
    printf("%s: create dd succeeded!\n", s);
    2e80:	85ca                	mv	a1,s2
    2e82:	00004517          	auipc	a0,0x4
    2e86:	0d650513          	addi	a0,a0,214 # 6f58 <malloc+0x160e>
    2e8a:	20d020ef          	jal	ra,5896 <printf>
    exit(1);
    2e8e:	4505                	li	a0,1
    2e90:	5e2020ef          	jal	ra,5472 <exit>
    printf("%s: open dd rdwr succeeded!\n", s);
    2e94:	85ca                	mv	a1,s2
    2e96:	00004517          	auipc	a0,0x4
    2e9a:	0e250513          	addi	a0,a0,226 # 6f78 <malloc+0x162e>
    2e9e:	1f9020ef          	jal	ra,5896 <printf>
    exit(1);
    2ea2:	4505                	li	a0,1
    2ea4:	5ce020ef          	jal	ra,5472 <exit>
    printf("%s: open dd wronly succeeded!\n", s);
    2ea8:	85ca                	mv	a1,s2
    2eaa:	00004517          	auipc	a0,0x4
    2eae:	0ee50513          	addi	a0,a0,238 # 6f98 <malloc+0x164e>
    2eb2:	1e5020ef          	jal	ra,5896 <printf>
    exit(1);
    2eb6:	4505                	li	a0,1
    2eb8:	5ba020ef          	jal	ra,5472 <exit>
    printf("%s: link dd/ff/ff dd/dd/xx succeeded!\n", s);
    2ebc:	85ca                	mv	a1,s2
    2ebe:	00004517          	auipc	a0,0x4
    2ec2:	10a50513          	addi	a0,a0,266 # 6fc8 <malloc+0x167e>
    2ec6:	1d1020ef          	jal	ra,5896 <printf>
    exit(1);
    2eca:	4505                	li	a0,1
    2ecc:	5a6020ef          	jal	ra,5472 <exit>
    printf("%s: link dd/xx/ff dd/dd/xx succeeded!\n", s);
    2ed0:	85ca                	mv	a1,s2
    2ed2:	00004517          	auipc	a0,0x4
    2ed6:	11e50513          	addi	a0,a0,286 # 6ff0 <malloc+0x16a6>
    2eda:	1bd020ef          	jal	ra,5896 <printf>
    exit(1);
    2ede:	4505                	li	a0,1
    2ee0:	592020ef          	jal	ra,5472 <exit>
    printf("%s: link dd/ff dd/dd/ffff succeeded!\n", s);
    2ee4:	85ca                	mv	a1,s2
    2ee6:	00004517          	auipc	a0,0x4
    2eea:	13250513          	addi	a0,a0,306 # 7018 <malloc+0x16ce>
    2eee:	1a9020ef          	jal	ra,5896 <printf>
    exit(1);
    2ef2:	4505                	li	a0,1
    2ef4:	57e020ef          	jal	ra,5472 <exit>
    printf("%s: mkdir dd/ff/ff succeeded!\n", s);
    2ef8:	85ca                	mv	a1,s2
    2efa:	00004517          	auipc	a0,0x4
    2efe:	14650513          	addi	a0,a0,326 # 7040 <malloc+0x16f6>
    2f02:	195020ef          	jal	ra,5896 <printf>
    exit(1);
    2f06:	4505                	li	a0,1
    2f08:	56a020ef          	jal	ra,5472 <exit>
    printf("%s: mkdir dd/xx/ff succeeded!\n", s);
    2f0c:	85ca                	mv	a1,s2
    2f0e:	00004517          	auipc	a0,0x4
    2f12:	15250513          	addi	a0,a0,338 # 7060 <malloc+0x1716>
    2f16:	181020ef          	jal	ra,5896 <printf>
    exit(1);
    2f1a:	4505                	li	a0,1
    2f1c:	556020ef          	jal	ra,5472 <exit>
    printf("%s: mkdir dd/dd/ffff succeeded!\n", s);
    2f20:	85ca                	mv	a1,s2
    2f22:	00004517          	auipc	a0,0x4
    2f26:	15e50513          	addi	a0,a0,350 # 7080 <malloc+0x1736>
    2f2a:	16d020ef          	jal	ra,5896 <printf>
    exit(1);
    2f2e:	4505                	li	a0,1
    2f30:	542020ef          	jal	ra,5472 <exit>
    printf("%s: unlink dd/xx/ff succeeded!\n", s);
    2f34:	85ca                	mv	a1,s2
    2f36:	00004517          	auipc	a0,0x4
    2f3a:	17250513          	addi	a0,a0,370 # 70a8 <malloc+0x175e>
    2f3e:	159020ef          	jal	ra,5896 <printf>
    exit(1);
    2f42:	4505                	li	a0,1
    2f44:	52e020ef          	jal	ra,5472 <exit>
    printf("%s: unlink dd/ff/ff succeeded!\n", s);
    2f48:	85ca                	mv	a1,s2
    2f4a:	00004517          	auipc	a0,0x4
    2f4e:	17e50513          	addi	a0,a0,382 # 70c8 <malloc+0x177e>
    2f52:	145020ef          	jal	ra,5896 <printf>
    exit(1);
    2f56:	4505                	li	a0,1
    2f58:	51a020ef          	jal	ra,5472 <exit>
    printf("%s: chdir dd/ff succeeded!\n", s);
    2f5c:	85ca                	mv	a1,s2
    2f5e:	00004517          	auipc	a0,0x4
    2f62:	18a50513          	addi	a0,a0,394 # 70e8 <malloc+0x179e>
    2f66:	131020ef          	jal	ra,5896 <printf>
    exit(1);
    2f6a:	4505                	li	a0,1
    2f6c:	506020ef          	jal	ra,5472 <exit>
    printf("%s: chdir dd/xx succeeded!\n", s);
    2f70:	85ca                	mv	a1,s2
    2f72:	00004517          	auipc	a0,0x4
    2f76:	19e50513          	addi	a0,a0,414 # 7110 <malloc+0x17c6>
    2f7a:	11d020ef          	jal	ra,5896 <printf>
    exit(1);
    2f7e:	4505                	li	a0,1
    2f80:	4f2020ef          	jal	ra,5472 <exit>
    printf("%s: unlink dd/dd/ff failed\n", s);
    2f84:	85ca                	mv	a1,s2
    2f86:	00004517          	auipc	a0,0x4
    2f8a:	e1a50513          	addi	a0,a0,-486 # 6da0 <malloc+0x1456>
    2f8e:	109020ef          	jal	ra,5896 <printf>
    exit(1);
    2f92:	4505                	li	a0,1
    2f94:	4de020ef          	jal	ra,5472 <exit>
    printf("%s: unlink dd/ff failed\n", s);
    2f98:	85ca                	mv	a1,s2
    2f9a:	00004517          	auipc	a0,0x4
    2f9e:	19650513          	addi	a0,a0,406 # 7130 <malloc+0x17e6>
    2fa2:	0f5020ef          	jal	ra,5896 <printf>
    exit(1);
    2fa6:	4505                	li	a0,1
    2fa8:	4ca020ef          	jal	ra,5472 <exit>
    printf("%s: unlink non-empty dd succeeded!\n", s);
    2fac:	85ca                	mv	a1,s2
    2fae:	00004517          	auipc	a0,0x4
    2fb2:	1a250513          	addi	a0,a0,418 # 7150 <malloc+0x1806>
    2fb6:	0e1020ef          	jal	ra,5896 <printf>
    exit(1);
    2fba:	4505                	li	a0,1
    2fbc:	4b6020ef          	jal	ra,5472 <exit>
    printf("%s: unlink dd/dd failed\n", s);
    2fc0:	85ca                	mv	a1,s2
    2fc2:	00004517          	auipc	a0,0x4
    2fc6:	1be50513          	addi	a0,a0,446 # 7180 <malloc+0x1836>
    2fca:	0cd020ef          	jal	ra,5896 <printf>
    exit(1);
    2fce:	4505                	li	a0,1
    2fd0:	4a2020ef          	jal	ra,5472 <exit>
    printf("%s: unlink dd failed\n", s);
    2fd4:	85ca                	mv	a1,s2
    2fd6:	00004517          	auipc	a0,0x4
    2fda:	1ca50513          	addi	a0,a0,458 # 71a0 <malloc+0x1856>
    2fde:	0b9020ef          	jal	ra,5896 <printf>
    exit(1);
    2fe2:	4505                	li	a0,1
    2fe4:	48e020ef          	jal	ra,5472 <exit>

0000000000002fe8 <rmdot>:
{
    2fe8:	1101                	addi	sp,sp,-32
    2fea:	ec06                	sd	ra,24(sp)
    2fec:	e822                	sd	s0,16(sp)
    2fee:	e426                	sd	s1,8(sp)
    2ff0:	1000                	addi	s0,sp,32
    2ff2:	84aa                	mv	s1,a0
  if (mkdir("dots") != 0) {
    2ff4:	00004517          	auipc	a0,0x4
    2ff8:	1c450513          	addi	a0,a0,452 # 71b8 <malloc+0x186e>
    2ffc:	4de020ef          	jal	ra,54da <mkdir>
    3000:	e53d                	bnez	a0,306e <rmdot+0x86>
  if (chdir("dots") != 0) {
    3002:	00004517          	auipc	a0,0x4
    3006:	1b650513          	addi	a0,a0,438 # 71b8 <malloc+0x186e>
    300a:	4d8020ef          	jal	ra,54e2 <chdir>
    300e:	e935                	bnez	a0,3082 <rmdot+0x9a>
  if (unlink(".") == 0) {
    3010:	00003517          	auipc	a0,0x3
    3014:	14050513          	addi	a0,a0,320 # 6150 <malloc+0x806>
    3018:	4aa020ef          	jal	ra,54c2 <unlink>
    301c:	cd2d                	beqz	a0,3096 <rmdot+0xae>
  if (unlink("..") == 0) {
    301e:	00004517          	auipc	a0,0x4
    3022:	bea50513          	addi	a0,a0,-1046 # 6c08 <malloc+0x12be>
    3026:	49c020ef          	jal	ra,54c2 <unlink>
    302a:	c141                	beqz	a0,30aa <rmdot+0xc2>
  if (chdir("/") != 0) {
    302c:	00004517          	auipc	a0,0x4
    3030:	b8450513          	addi	a0,a0,-1148 # 6bb0 <malloc+0x1266>
    3034:	4ae020ef          	jal	ra,54e2 <chdir>
    3038:	e159                	bnez	a0,30be <rmdot+0xd6>
  if (unlink("dots/.") == 0) {
    303a:	00004517          	auipc	a0,0x4
    303e:	1e650513          	addi	a0,a0,486 # 7220 <malloc+0x18d6>
    3042:	480020ef          	jal	ra,54c2 <unlink>
    3046:	c551                	beqz	a0,30d2 <rmdot+0xea>
  if (unlink("dots/..") == 0) {
    3048:	00004517          	auipc	a0,0x4
    304c:	20050513          	addi	a0,a0,512 # 7248 <malloc+0x18fe>
    3050:	472020ef          	jal	ra,54c2 <unlink>
    3054:	c949                	beqz	a0,30e6 <rmdot+0xfe>
  if (unlink("dots") != 0) {
    3056:	00004517          	auipc	a0,0x4
    305a:	16250513          	addi	a0,a0,354 # 71b8 <malloc+0x186e>
    305e:	464020ef          	jal	ra,54c2 <unlink>
    3062:	ed41                	bnez	a0,30fa <rmdot+0x112>
}
    3064:	60e2                	ld	ra,24(sp)
    3066:	6442                	ld	s0,16(sp)
    3068:	64a2                	ld	s1,8(sp)
    306a:	6105                	addi	sp,sp,32
    306c:	8082                	ret
    printf("%s: mkdir dots failed\n", s);
    306e:	85a6                	mv	a1,s1
    3070:	00004517          	auipc	a0,0x4
    3074:	15050513          	addi	a0,a0,336 # 71c0 <malloc+0x1876>
    3078:	01f020ef          	jal	ra,5896 <printf>
    exit(1);
    307c:	4505                	li	a0,1
    307e:	3f4020ef          	jal	ra,5472 <exit>
    printf("%s: chdir dots failed\n", s);
    3082:	85a6                	mv	a1,s1
    3084:	00004517          	auipc	a0,0x4
    3088:	15450513          	addi	a0,a0,340 # 71d8 <malloc+0x188e>
    308c:	00b020ef          	jal	ra,5896 <printf>
    exit(1);
    3090:	4505                	li	a0,1
    3092:	3e0020ef          	jal	ra,5472 <exit>
    printf("%s: rm . worked!\n", s);
    3096:	85a6                	mv	a1,s1
    3098:	00004517          	auipc	a0,0x4
    309c:	15850513          	addi	a0,a0,344 # 71f0 <malloc+0x18a6>
    30a0:	7f6020ef          	jal	ra,5896 <printf>
    exit(1);
    30a4:	4505                	li	a0,1
    30a6:	3cc020ef          	jal	ra,5472 <exit>
    printf("%s: rm .. worked!\n", s);
    30aa:	85a6                	mv	a1,s1
    30ac:	00004517          	auipc	a0,0x4
    30b0:	15c50513          	addi	a0,a0,348 # 7208 <malloc+0x18be>
    30b4:	7e2020ef          	jal	ra,5896 <printf>
    exit(1);
    30b8:	4505                	li	a0,1
    30ba:	3b8020ef          	jal	ra,5472 <exit>
    printf("%s: chdir / failed\n", s);
    30be:	85a6                	mv	a1,s1
    30c0:	00004517          	auipc	a0,0x4
    30c4:	af850513          	addi	a0,a0,-1288 # 6bb8 <malloc+0x126e>
    30c8:	7ce020ef          	jal	ra,5896 <printf>
    exit(1);
    30cc:	4505                	li	a0,1
    30ce:	3a4020ef          	jal	ra,5472 <exit>
    printf("%s: unlink dots/. worked!\n", s);
    30d2:	85a6                	mv	a1,s1
    30d4:	00004517          	auipc	a0,0x4
    30d8:	15450513          	addi	a0,a0,340 # 7228 <malloc+0x18de>
    30dc:	7ba020ef          	jal	ra,5896 <printf>
    exit(1);
    30e0:	4505                	li	a0,1
    30e2:	390020ef          	jal	ra,5472 <exit>
    printf("%s: unlink dots/.. worked!\n", s);
    30e6:	85a6                	mv	a1,s1
    30e8:	00004517          	auipc	a0,0x4
    30ec:	16850513          	addi	a0,a0,360 # 7250 <malloc+0x1906>
    30f0:	7a6020ef          	jal	ra,5896 <printf>
    exit(1);
    30f4:	4505                	li	a0,1
    30f6:	37c020ef          	jal	ra,5472 <exit>
    printf("%s: unlink dots failed!\n", s);
    30fa:	85a6                	mv	a1,s1
    30fc:	00004517          	auipc	a0,0x4
    3100:	17450513          	addi	a0,a0,372 # 7270 <malloc+0x1926>
    3104:	792020ef          	jal	ra,5896 <printf>
    exit(1);
    3108:	4505                	li	a0,1
    310a:	368020ef          	jal	ra,5472 <exit>

000000000000310e <dirfile>:
{
    310e:	1101                	addi	sp,sp,-32
    3110:	ec06                	sd	ra,24(sp)
    3112:	e822                	sd	s0,16(sp)
    3114:	e426                	sd	s1,8(sp)
    3116:	e04a                	sd	s2,0(sp)
    3118:	1000                	addi	s0,sp,32
    311a:	892a                	mv	s2,a0
  fd = open("dirfile", O_CREATE);
    311c:	20000593          	li	a1,512
    3120:	00004517          	auipc	a0,0x4
    3124:	17050513          	addi	a0,a0,368 # 7290 <malloc+0x1946>
    3128:	38a020ef          	jal	ra,54b2 <open>
  if (fd < 0) {
    312c:	0c054563          	bltz	a0,31f6 <dirfile+0xe8>
  close(fd);
    3130:	36a020ef          	jal	ra,549a <close>
  if (chdir("dirfile") == 0) {
    3134:	00004517          	auipc	a0,0x4
    3138:	15c50513          	addi	a0,a0,348 # 7290 <malloc+0x1946>
    313c:	3a6020ef          	jal	ra,54e2 <chdir>
    3140:	c569                	beqz	a0,320a <dirfile+0xfc>
  fd = open("dirfile/xx", 0);
    3142:	4581                	li	a1,0
    3144:	00004517          	auipc	a0,0x4
    3148:	19450513          	addi	a0,a0,404 # 72d8 <malloc+0x198e>
    314c:	366020ef          	jal	ra,54b2 <open>
  if (fd >= 0) {
    3150:	0c055763          	bgez	a0,321e <dirfile+0x110>
  fd = open("dirfile/xx", O_CREATE);
    3154:	20000593          	li	a1,512
    3158:	00004517          	auipc	a0,0x4
    315c:	18050513          	addi	a0,a0,384 # 72d8 <malloc+0x198e>
    3160:	352020ef          	jal	ra,54b2 <open>
  if (fd >= 0) {
    3164:	0c055763          	bgez	a0,3232 <dirfile+0x124>
  if (mkdir("dirfile/xx") == 0) {
    3168:	00004517          	auipc	a0,0x4
    316c:	17050513          	addi	a0,a0,368 # 72d8 <malloc+0x198e>
    3170:	36a020ef          	jal	ra,54da <mkdir>
    3174:	0c050963          	beqz	a0,3246 <dirfile+0x138>
  if (unlink("dirfile/xx") == 0) {
    3178:	00004517          	auipc	a0,0x4
    317c:	16050513          	addi	a0,a0,352 # 72d8 <malloc+0x198e>
    3180:	342020ef          	jal	ra,54c2 <unlink>
    3184:	0c050b63          	beqz	a0,325a <dirfile+0x14c>
  if (link("README", "dirfile/xx") == 0) {
    3188:	00004597          	auipc	a1,0x4
    318c:	15058593          	addi	a1,a1,336 # 72d8 <malloc+0x198e>
    3190:	00003517          	auipc	a0,0x3
    3194:	ab050513          	addi	a0,a0,-1360 # 5c40 <malloc+0x2f6>
    3198:	33a020ef          	jal	ra,54d2 <link>
    319c:	0c050963          	beqz	a0,326e <dirfile+0x160>
  if (unlink("dirfile") != 0) {
    31a0:	00004517          	auipc	a0,0x4
    31a4:	0f050513          	addi	a0,a0,240 # 7290 <malloc+0x1946>
    31a8:	31a020ef          	jal	ra,54c2 <unlink>
    31ac:	0c051b63          	bnez	a0,3282 <dirfile+0x174>
  fd = open(".", O_RDWR);
    31b0:	4589                	li	a1,2
    31b2:	00003517          	auipc	a0,0x3
    31b6:	f9e50513          	addi	a0,a0,-98 # 6150 <malloc+0x806>
    31ba:	2f8020ef          	jal	ra,54b2 <open>
  if (fd >= 0) {
    31be:	0c055c63          	bgez	a0,3296 <dirfile+0x188>
  fd = open(".", 0);
    31c2:	4581                	li	a1,0
    31c4:	00003517          	auipc	a0,0x3
    31c8:	f8c50513          	addi	a0,a0,-116 # 6150 <malloc+0x806>
    31cc:	2e6020ef          	jal	ra,54b2 <open>
    31d0:	84aa                	mv	s1,a0
  if (write(fd, "x", 1) > 0) {
    31d2:	4605                	li	a2,1
    31d4:	00003597          	auipc	a1,0x3
    31d8:	90458593          	addi	a1,a1,-1788 # 5ad8 <malloc+0x18e>
    31dc:	2b6020ef          	jal	ra,5492 <write>
    31e0:	0ca04563          	bgtz	a0,32aa <dirfile+0x19c>
  close(fd);
    31e4:	8526                	mv	a0,s1
    31e6:	2b4020ef          	jal	ra,549a <close>
}
    31ea:	60e2                	ld	ra,24(sp)
    31ec:	6442                	ld	s0,16(sp)
    31ee:	64a2                	ld	s1,8(sp)
    31f0:	6902                	ld	s2,0(sp)
    31f2:	6105                	addi	sp,sp,32
    31f4:	8082                	ret
    printf("%s: create dirfile failed\n", s);
    31f6:	85ca                	mv	a1,s2
    31f8:	00004517          	auipc	a0,0x4
    31fc:	0a050513          	addi	a0,a0,160 # 7298 <malloc+0x194e>
    3200:	696020ef          	jal	ra,5896 <printf>
    exit(1);
    3204:	4505                	li	a0,1
    3206:	26c020ef          	jal	ra,5472 <exit>
    printf("%s: chdir dirfile succeeded!\n", s);
    320a:	85ca                	mv	a1,s2
    320c:	00004517          	auipc	a0,0x4
    3210:	0ac50513          	addi	a0,a0,172 # 72b8 <malloc+0x196e>
    3214:	682020ef          	jal	ra,5896 <printf>
    exit(1);
    3218:	4505                	li	a0,1
    321a:	258020ef          	jal	ra,5472 <exit>
    printf("%s: create dirfile/xx succeeded!\n", s);
    321e:	85ca                	mv	a1,s2
    3220:	00004517          	auipc	a0,0x4
    3224:	0c850513          	addi	a0,a0,200 # 72e8 <malloc+0x199e>
    3228:	66e020ef          	jal	ra,5896 <printf>
    exit(1);
    322c:	4505                	li	a0,1
    322e:	244020ef          	jal	ra,5472 <exit>
    printf("%s: create dirfile/xx succeeded!\n", s);
    3232:	85ca                	mv	a1,s2
    3234:	00004517          	auipc	a0,0x4
    3238:	0b450513          	addi	a0,a0,180 # 72e8 <malloc+0x199e>
    323c:	65a020ef          	jal	ra,5896 <printf>
    exit(1);
    3240:	4505                	li	a0,1
    3242:	230020ef          	jal	ra,5472 <exit>
    printf("%s: mkdir dirfile/xx succeeded!\n", s);
    3246:	85ca                	mv	a1,s2
    3248:	00004517          	auipc	a0,0x4
    324c:	0c850513          	addi	a0,a0,200 # 7310 <malloc+0x19c6>
    3250:	646020ef          	jal	ra,5896 <printf>
    exit(1);
    3254:	4505                	li	a0,1
    3256:	21c020ef          	jal	ra,5472 <exit>
    printf("%s: unlink dirfile/xx succeeded!\n", s);
    325a:	85ca                	mv	a1,s2
    325c:	00004517          	auipc	a0,0x4
    3260:	0dc50513          	addi	a0,a0,220 # 7338 <malloc+0x19ee>
    3264:	632020ef          	jal	ra,5896 <printf>
    exit(1);
    3268:	4505                	li	a0,1
    326a:	208020ef          	jal	ra,5472 <exit>
    printf("%s: link to dirfile/xx succeeded!\n", s);
    326e:	85ca                	mv	a1,s2
    3270:	00004517          	auipc	a0,0x4
    3274:	0f050513          	addi	a0,a0,240 # 7360 <malloc+0x1a16>
    3278:	61e020ef          	jal	ra,5896 <printf>
    exit(1);
    327c:	4505                	li	a0,1
    327e:	1f4020ef          	jal	ra,5472 <exit>
    printf("%s: unlink dirfile failed!\n", s);
    3282:	85ca                	mv	a1,s2
    3284:	00004517          	auipc	a0,0x4
    3288:	10450513          	addi	a0,a0,260 # 7388 <malloc+0x1a3e>
    328c:	60a020ef          	jal	ra,5896 <printf>
    exit(1);
    3290:	4505                	li	a0,1
    3292:	1e0020ef          	jal	ra,5472 <exit>
    printf("%s: open . for writing succeeded!\n", s);
    3296:	85ca                	mv	a1,s2
    3298:	00004517          	auipc	a0,0x4
    329c:	11050513          	addi	a0,a0,272 # 73a8 <malloc+0x1a5e>
    32a0:	5f6020ef          	jal	ra,5896 <printf>
    exit(1);
    32a4:	4505                	li	a0,1
    32a6:	1cc020ef          	jal	ra,5472 <exit>
    printf("%s: write . succeeded!\n", s);
    32aa:	85ca                	mv	a1,s2
    32ac:	00004517          	auipc	a0,0x4
    32b0:	12450513          	addi	a0,a0,292 # 73d0 <malloc+0x1a86>
    32b4:	5e2020ef          	jal	ra,5896 <printf>
    exit(1);
    32b8:	4505                	li	a0,1
    32ba:	1b8020ef          	jal	ra,5472 <exit>

00000000000032be <iref>:
{
    32be:	7139                	addi	sp,sp,-64
    32c0:	fc06                	sd	ra,56(sp)
    32c2:	f822                	sd	s0,48(sp)
    32c4:	f426                	sd	s1,40(sp)
    32c6:	f04a                	sd	s2,32(sp)
    32c8:	ec4e                	sd	s3,24(sp)
    32ca:	e852                	sd	s4,16(sp)
    32cc:	e456                	sd	s5,8(sp)
    32ce:	e05a                	sd	s6,0(sp)
    32d0:	0080                	addi	s0,sp,64
    32d2:	8b2a                	mv	s6,a0
    32d4:	03300913          	li	s2,51
    if (mkdir("irefd") != 0) {
    32d8:	00004a17          	auipc	s4,0x4
    32dc:	110a0a13          	addi	s4,s4,272 # 73e8 <malloc+0x1a9e>
    mkdir("");
    32e0:	00004497          	auipc	s1,0x4
    32e4:	c1048493          	addi	s1,s1,-1008 # 6ef0 <malloc+0x15a6>
    link("README", "");
    32e8:	00003a97          	auipc	s5,0x3
    32ec:	958a8a93          	addi	s5,s5,-1704 # 5c40 <malloc+0x2f6>
    fd = open("xx", O_CREATE);
    32f0:	00004997          	auipc	s3,0x4
    32f4:	ff098993          	addi	s3,s3,-16 # 72e0 <malloc+0x1996>
    32f8:	a835                	j	3334 <iref+0x76>
      printf("%s: mkdir irefd failed\n", s);
    32fa:	85da                	mv	a1,s6
    32fc:	00004517          	auipc	a0,0x4
    3300:	0f450513          	addi	a0,a0,244 # 73f0 <malloc+0x1aa6>
    3304:	592020ef          	jal	ra,5896 <printf>
      exit(1);
    3308:	4505                	li	a0,1
    330a:	168020ef          	jal	ra,5472 <exit>
      printf("%s: chdir irefd failed\n", s);
    330e:	85da                	mv	a1,s6
    3310:	00004517          	auipc	a0,0x4
    3314:	0f850513          	addi	a0,a0,248 # 7408 <malloc+0x1abe>
    3318:	57e020ef          	jal	ra,5896 <printf>
      exit(1);
    331c:	4505                	li	a0,1
    331e:	154020ef          	jal	ra,5472 <exit>
      close(fd);
    3322:	178020ef          	jal	ra,549a <close>
    3326:	a82d                	j	3360 <iref+0xa2>
    unlink("xx");
    3328:	854e                	mv	a0,s3
    332a:	198020ef          	jal	ra,54c2 <unlink>
  for (i = 0; i < NINODE + 1; i++) {
    332e:	397d                	addiw	s2,s2,-1
    3330:	04090263          	beqz	s2,3374 <iref+0xb6>
    if (mkdir("irefd") != 0) {
    3334:	8552                	mv	a0,s4
    3336:	1a4020ef          	jal	ra,54da <mkdir>
    333a:	f161                	bnez	a0,32fa <iref+0x3c>
    if (chdir("irefd") != 0) {
    333c:	8552                	mv	a0,s4
    333e:	1a4020ef          	jal	ra,54e2 <chdir>
    3342:	f571                	bnez	a0,330e <iref+0x50>
    mkdir("");
    3344:	8526                	mv	a0,s1
    3346:	194020ef          	jal	ra,54da <mkdir>
    link("README", "");
    334a:	85a6                	mv	a1,s1
    334c:	8556                	mv	a0,s5
    334e:	184020ef          	jal	ra,54d2 <link>
    fd = open("", O_CREATE);
    3352:	20000593          	li	a1,512
    3356:	8526                	mv	a0,s1
    3358:	15a020ef          	jal	ra,54b2 <open>
    if (fd >= 0)
    335c:	fc0553e3          	bgez	a0,3322 <iref+0x64>
    fd = open("xx", O_CREATE);
    3360:	20000593          	li	a1,512
    3364:	854e                	mv	a0,s3
    3366:	14c020ef          	jal	ra,54b2 <open>
    if (fd >= 0)
    336a:	fa054fe3          	bltz	a0,3328 <iref+0x6a>
      close(fd);
    336e:	12c020ef          	jal	ra,549a <close>
    3372:	bf5d                	j	3328 <iref+0x6a>
    3374:	03300493          	li	s1,51
    chdir("..");
    3378:	00004997          	auipc	s3,0x4
    337c:	89098993          	addi	s3,s3,-1904 # 6c08 <malloc+0x12be>
    unlink("irefd");
    3380:	00004917          	auipc	s2,0x4
    3384:	06890913          	addi	s2,s2,104 # 73e8 <malloc+0x1a9e>
    chdir("..");
    3388:	854e                	mv	a0,s3
    338a:	158020ef          	jal	ra,54e2 <chdir>
    unlink("irefd");
    338e:	854a                	mv	a0,s2
    3390:	132020ef          	jal	ra,54c2 <unlink>
  for (i = 0; i < NINODE + 1; i++) {
    3394:	34fd                	addiw	s1,s1,-1
    3396:	f8ed                	bnez	s1,3388 <iref+0xca>
  chdir("/");
    3398:	00004517          	auipc	a0,0x4
    339c:	81850513          	addi	a0,a0,-2024 # 6bb0 <malloc+0x1266>
    33a0:	142020ef          	jal	ra,54e2 <chdir>
}
    33a4:	70e2                	ld	ra,56(sp)
    33a6:	7442                	ld	s0,48(sp)
    33a8:	74a2                	ld	s1,40(sp)
    33aa:	7902                	ld	s2,32(sp)
    33ac:	69e2                	ld	s3,24(sp)
    33ae:	6a42                	ld	s4,16(sp)
    33b0:	6aa2                	ld	s5,8(sp)
    33b2:	6b02                	ld	s6,0(sp)
    33b4:	6121                	addi	sp,sp,64
    33b6:	8082                	ret

00000000000033b8 <unlinkcwd>:
{
    33b8:	1101                	addi	sp,sp,-32
    33ba:	ec06                	sd	ra,24(sp)
    33bc:	e822                	sd	s0,16(sp)
    33be:	e426                	sd	s1,8(sp)
    33c0:	1000                	addi	s0,sp,32
    33c2:	84aa                	mv	s1,a0
  if (mkdir("/a") < 0) {
    33c4:	00004517          	auipc	a0,0x4
    33c8:	05c50513          	addi	a0,a0,92 # 7420 <malloc+0x1ad6>
    33cc:	10e020ef          	jal	ra,54da <mkdir>
    33d0:	06054a63          	bltz	a0,3444 <unlinkcwd+0x8c>
  if (mkdir("/a/b") < 0) {
    33d4:	00004517          	auipc	a0,0x4
    33d8:	06c50513          	addi	a0,a0,108 # 7440 <malloc+0x1af6>
    33dc:	0fe020ef          	jal	ra,54da <mkdir>
    33e0:	06054c63          	bltz	a0,3458 <unlinkcwd+0xa0>
  if (chdir("/a/b") < 0) {
    33e4:	00004517          	auipc	a0,0x4
    33e8:	05c50513          	addi	a0,a0,92 # 7440 <malloc+0x1af6>
    33ec:	0f6020ef          	jal	ra,54e2 <chdir>
    33f0:	06054e63          	bltz	a0,346c <unlinkcwd+0xb4>
  if (unlink("/a/b") < 0) {
    33f4:	00004517          	auipc	a0,0x4
    33f8:	04c50513          	addi	a0,a0,76 # 7440 <malloc+0x1af6>
    33fc:	0c6020ef          	jal	ra,54c2 <unlink>
    3400:	08054063          	bltz	a0,3480 <unlinkcwd+0xc8>
  if (unlink("/a") < 0) {
    3404:	00004517          	auipc	a0,0x4
    3408:	01c50513          	addi	a0,a0,28 # 7420 <malloc+0x1ad6>
    340c:	0b6020ef          	jal	ra,54c2 <unlink>
    3410:	08054263          	bltz	a0,3494 <unlinkcwd+0xdc>
  if (open("../", O_RDONLY) > 0) {
    3414:	4581                	li	a1,0
    3416:	00004517          	auipc	a0,0x4
    341a:	09250513          	addi	a0,a0,146 # 74a8 <malloc+0x1b5e>
    341e:	094020ef          	jal	ra,54b2 <open>
    3422:	08a04363          	bgtz	a0,34a8 <unlinkcwd+0xf0>
  if (open("../c", O_CREATE) > 0) {
    3426:	20000593          	li	a1,512
    342a:	00004517          	auipc	a0,0x4
    342e:	0ae50513          	addi	a0,a0,174 # 74d8 <malloc+0x1b8e>
    3432:	080020ef          	jal	ra,54b2 <open>
    3436:	08a04163          	bgtz	a0,34b8 <unlinkcwd+0x100>
}
    343a:	60e2                	ld	ra,24(sp)
    343c:	6442                	ld	s0,16(sp)
    343e:	64a2                	ld	s1,8(sp)
    3440:	6105                	addi	sp,sp,32
    3442:	8082                	ret
    printf("%s: mkdir /a failed\n", s);
    3444:	85a6                	mv	a1,s1
    3446:	00004517          	auipc	a0,0x4
    344a:	fe250513          	addi	a0,a0,-30 # 7428 <malloc+0x1ade>
    344e:	448020ef          	jal	ra,5896 <printf>
    exit(1);
    3452:	4505                	li	a0,1
    3454:	01e020ef          	jal	ra,5472 <exit>
    printf("%s: mkdir /a/b failed\n", s);
    3458:	85a6                	mv	a1,s1
    345a:	00004517          	auipc	a0,0x4
    345e:	fee50513          	addi	a0,a0,-18 # 7448 <malloc+0x1afe>
    3462:	434020ef          	jal	ra,5896 <printf>
    exit(1);
    3466:	4505                	li	a0,1
    3468:	00a020ef          	jal	ra,5472 <exit>
    printf("%s: chdir failed\n", s);
    346c:	85a6                	mv	a1,s1
    346e:	00004517          	auipc	a0,0x4
    3472:	ff250513          	addi	a0,a0,-14 # 7460 <malloc+0x1b16>
    3476:	420020ef          	jal	ra,5896 <printf>
    exit(1);
    347a:	4505                	li	a0,1
    347c:	7f7010ef          	jal	ra,5472 <exit>
    printf("%s: unlink /a/b failed\n", s);
    3480:	85a6                	mv	a1,s1
    3482:	00004517          	auipc	a0,0x4
    3486:	ff650513          	addi	a0,a0,-10 # 7478 <malloc+0x1b2e>
    348a:	40c020ef          	jal	ra,5896 <printf>
    exit(1);
    348e:	4505                	li	a0,1
    3490:	7e3010ef          	jal	ra,5472 <exit>
    printf("%s: unlink /a failed\n", s);
    3494:	85a6                	mv	a1,s1
    3496:	00004517          	auipc	a0,0x4
    349a:	ffa50513          	addi	a0,a0,-6 # 7490 <malloc+0x1b46>
    349e:	3f8020ef          	jal	ra,5896 <printf>
    exit(1);
    34a2:	4505                	li	a0,1
    34a4:	7cf010ef          	jal	ra,5472 <exit>
    printf("%s: open ../ non-existing directory\n", s);
    34a8:	85a6                	mv	a1,s1
    34aa:	00004517          	auipc	a0,0x4
    34ae:	00650513          	addi	a0,a0,6 # 74b0 <malloc+0x1b66>
    34b2:	3e4020ef          	jal	ra,5896 <printf>
    34b6:	bf85                	j	3426 <unlinkcwd+0x6e>
    printf("%s: create ../c non-existing file\n", s);
    34b8:	85a6                	mv	a1,s1
    34ba:	00004517          	auipc	a0,0x4
    34be:	02650513          	addi	a0,a0,38 # 74e0 <malloc+0x1b96>
    34c2:	3d4020ef          	jal	ra,5896 <printf>
}
    34c6:	bf95                	j	343a <unlinkcwd+0x82>

00000000000034c8 <openiputtest>:
{
    34c8:	7179                	addi	sp,sp,-48
    34ca:	f406                	sd	ra,40(sp)
    34cc:	f022                	sd	s0,32(sp)
    34ce:	ec26                	sd	s1,24(sp)
    34d0:	1800                	addi	s0,sp,48
    34d2:	84aa                	mv	s1,a0
  if (mkdir("oidir") < 0) {
    34d4:	00004517          	auipc	a0,0x4
    34d8:	03450513          	addi	a0,a0,52 # 7508 <malloc+0x1bbe>
    34dc:	7ff010ef          	jal	ra,54da <mkdir>
    34e0:	02054a63          	bltz	a0,3514 <openiputtest+0x4c>
  pid = fork();
    34e4:	787010ef          	jal	ra,546a <fork>
  if (pid < 0) {
    34e8:	04054063          	bltz	a0,3528 <openiputtest+0x60>
  if (pid == 0) {
    34ec:	e939                	bnez	a0,3542 <openiputtest+0x7a>
    int fd = open("oidir", O_RDWR);
    34ee:	4589                	li	a1,2
    34f0:	00004517          	auipc	a0,0x4
    34f4:	01850513          	addi	a0,a0,24 # 7508 <malloc+0x1bbe>
    34f8:	7bb010ef          	jal	ra,54b2 <open>
    if (fd >= 0) {
    34fc:	04054063          	bltz	a0,353c <openiputtest+0x74>
      printf("%s: open directory for write succeeded\n", s);
    3500:	85a6                	mv	a1,s1
    3502:	00004517          	auipc	a0,0x4
    3506:	02650513          	addi	a0,a0,38 # 7528 <malloc+0x1bde>
    350a:	38c020ef          	jal	ra,5896 <printf>
      exit(1);
    350e:	4505                	li	a0,1
    3510:	763010ef          	jal	ra,5472 <exit>
    printf("%s: mkdir oidir failed\n", s);
    3514:	85a6                	mv	a1,s1
    3516:	00004517          	auipc	a0,0x4
    351a:	ffa50513          	addi	a0,a0,-6 # 7510 <malloc+0x1bc6>
    351e:	378020ef          	jal	ra,5896 <printf>
    exit(1);
    3522:	4505                	li	a0,1
    3524:	74f010ef          	jal	ra,5472 <exit>
    printf("%s: fork failed\n", s);
    3528:	85a6                	mv	a1,s1
    352a:	00003517          	auipc	a0,0x3
    352e:	dce50513          	addi	a0,a0,-562 # 62f8 <malloc+0x9ae>
    3532:	364020ef          	jal	ra,5896 <printf>
    exit(1);
    3536:	4505                	li	a0,1
    3538:	73b010ef          	jal	ra,5472 <exit>
    exit(0);
    353c:	4501                	li	a0,0
    353e:	735010ef          	jal	ra,5472 <exit>
  pause(1);
    3542:	4505                	li	a0,1
    3544:	7bf010ef          	jal	ra,5502 <pause>
  if (unlink("oidir") != 0) {
    3548:	00004517          	auipc	a0,0x4
    354c:	fc050513          	addi	a0,a0,-64 # 7508 <malloc+0x1bbe>
    3550:	773010ef          	jal	ra,54c2 <unlink>
    3554:	c919                	beqz	a0,356a <openiputtest+0xa2>
    printf("%s: unlink failed\n", s);
    3556:	85a6                	mv	a1,s1
    3558:	00003517          	auipc	a0,0x3
    355c:	f2850513          	addi	a0,a0,-216 # 6480 <malloc+0xb36>
    3560:	336020ef          	jal	ra,5896 <printf>
    exit(1);
    3564:	4505                	li	a0,1
    3566:	70d010ef          	jal	ra,5472 <exit>
  wait(&xstatus);
    356a:	fdc40513          	addi	a0,s0,-36
    356e:	70d010ef          	jal	ra,547a <wait>
  exit(xstatus);
    3572:	fdc42503          	lw	a0,-36(s0)
    3576:	6fd010ef          	jal	ra,5472 <exit>

000000000000357a <forkforkfork>:
{
    357a:	1101                	addi	sp,sp,-32
    357c:	ec06                	sd	ra,24(sp)
    357e:	e822                	sd	s0,16(sp)
    3580:	e426                	sd	s1,8(sp)
    3582:	1000                	addi	s0,sp,32
    3584:	84aa                	mv	s1,a0
  unlink("stopforking");
    3586:	00004517          	auipc	a0,0x4
    358a:	fca50513          	addi	a0,a0,-54 # 7550 <malloc+0x1c06>
    358e:	735010ef          	jal	ra,54c2 <unlink>
  int pid = fork();
    3592:	6d9010ef          	jal	ra,546a <fork>
  if (pid < 0) {
    3596:	02054b63          	bltz	a0,35cc <forkforkfork+0x52>
  if (pid == 0) {
    359a:	c139                	beqz	a0,35e0 <forkforkfork+0x66>
  pause(20); // two seconds
    359c:	4551                	li	a0,20
    359e:	765010ef          	jal	ra,5502 <pause>
  close(open("stopforking", O_CREATE | O_RDWR));
    35a2:	20200593          	li	a1,514
    35a6:	00004517          	auipc	a0,0x4
    35aa:	faa50513          	addi	a0,a0,-86 # 7550 <malloc+0x1c06>
    35ae:	705010ef          	jal	ra,54b2 <open>
    35b2:	6e9010ef          	jal	ra,549a <close>
  wait(0);
    35b6:	4501                	li	a0,0
    35b8:	6c3010ef          	jal	ra,547a <wait>
  pause(10); // one second
    35bc:	4529                	li	a0,10
    35be:	745010ef          	jal	ra,5502 <pause>
}
    35c2:	60e2                	ld	ra,24(sp)
    35c4:	6442                	ld	s0,16(sp)
    35c6:	64a2                	ld	s1,8(sp)
    35c8:	6105                	addi	sp,sp,32
    35ca:	8082                	ret
    printf("%s: fork failed", s);
    35cc:	85a6                	mv	a1,s1
    35ce:	00003517          	auipc	a0,0x3
    35d2:	e6a50513          	addi	a0,a0,-406 # 6438 <malloc+0xaee>
    35d6:	2c0020ef          	jal	ra,5896 <printf>
    exit(1);
    35da:	4505                	li	a0,1
    35dc:	697010ef          	jal	ra,5472 <exit>
      int fd = open("stopforking", 0);
    35e0:	00004497          	auipc	s1,0x4
    35e4:	f7048493          	addi	s1,s1,-144 # 7550 <malloc+0x1c06>
    35e8:	4581                	li	a1,0
    35ea:	8526                	mv	a0,s1
    35ec:	6c7010ef          	jal	ra,54b2 <open>
      if (fd >= 0) {
    35f0:	00055e63          	bgez	a0,360c <forkforkfork+0x92>
      if (fork() < 0) {
    35f4:	677010ef          	jal	ra,546a <fork>
    35f8:	fe0558e3          	bgez	a0,35e8 <forkforkfork+0x6e>
        close(open("stopforking", O_CREATE | O_RDWR));
    35fc:	20200593          	li	a1,514
    3600:	8526                	mv	a0,s1
    3602:	6b1010ef          	jal	ra,54b2 <open>
    3606:	695010ef          	jal	ra,549a <close>
    360a:	bff9                	j	35e8 <forkforkfork+0x6e>
        exit(0);
    360c:	4501                	li	a0,0
    360e:	665010ef          	jal	ra,5472 <exit>

0000000000003612 <exectest>:
{
    3612:	711d                	addi	sp,sp,-96
    3614:	ec86                	sd	ra,88(sp)
    3616:	e8a2                	sd	s0,80(sp)
    3618:	e4a6                	sd	s1,72(sp)
    361a:	e0ca                	sd	s2,64(sp)
    361c:	fc4e                	sd	s3,56(sp)
    361e:	1080                	addi	s0,sp,96
    3620:	892a                	mv	s2,a0
  char *echoargv[] = {"echo", "OK", 0};
    3622:	00002797          	auipc	a5,0x2
    3626:	44678793          	addi	a5,a5,1094 # 5a68 <malloc+0x11e>
    362a:	faf43823          	sd	a5,-80(s0)
    362e:	00004797          	auipc	a5,0x4
    3632:	f3278793          	addi	a5,a5,-206 # 7560 <malloc+0x1c16>
    3636:	faf43c23          	sd	a5,-72(s0)
    363a:	fc043023          	sd	zero,-64(s0)
  unlink("echo-ok");
    363e:	00004517          	auipc	a0,0x4
    3642:	f2a50513          	addi	a0,a0,-214 # 7568 <malloc+0x1c1e>
    3646:	67d010ef          	jal	ra,54c2 <unlink>
  pid = fork();
    364a:	621010ef          	jal	ra,546a <fork>
  if (pid < 0) {
    364e:	04054563          	bltz	a0,3698 <exectest+0x86>
    3652:	84aa                	mv	s1,a0
  if (pid == 0) {
    3654:	e959                	bnez	a0,36ea <exectest+0xd8>
    int errfd = dup(1);
    3656:	4505                	li	a0,1
    3658:	693010ef          	jal	ra,54ea <dup>
    365c:	89aa                	mv	s3,a0
    if (errfd < 0) {
    365e:	04054763          	bltz	a0,36ac <exectest+0x9a>
    close(1);
    3662:	4505                	li	a0,1
    3664:	637010ef          	jal	ra,549a <close>
    fd = open("echo-ok", O_CREATE | O_WRONLY);
    3668:	20100593          	li	a1,513
    366c:	00004517          	auipc	a0,0x4
    3670:	efc50513          	addi	a0,a0,-260 # 7568 <malloc+0x1c1e>
    3674:	63f010ef          	jal	ra,54b2 <open>
    if (fd < 0) {
    3678:	04054463          	bltz	a0,36c0 <exectest+0xae>
    if (fd != 1) {
    367c:	4785                	li	a5,1
    367e:	04f50c63          	beq	a0,a5,36d6 <exectest+0xc4>
      fprintf(errfd, "%s: wrong fd\n", s);
    3682:	864a                	mv	a2,s2
    3684:	00004597          	auipc	a1,0x4
    3688:	efc58593          	addi	a1,a1,-260 # 7580 <malloc+0x1c36>
    368c:	854e                	mv	a0,s3
    368e:	1de020ef          	jal	ra,586c <fprintf>
      exit(1);
    3692:	4505                	li	a0,1
    3694:	5df010ef          	jal	ra,5472 <exit>
    printf("%s: fork failed\n", s);
    3698:	85ca                	mv	a1,s2
    369a:	00003517          	auipc	a0,0x3
    369e:	c5e50513          	addi	a0,a0,-930 # 62f8 <malloc+0x9ae>
    36a2:	1f4020ef          	jal	ra,5896 <printf>
    exit(1);
    36a6:	4505                	li	a0,1
    36a8:	5cb010ef          	jal	ra,5472 <exit>
      printf("%s: dup failed\n", s);
    36ac:	85ca                	mv	a1,s2
    36ae:	00004517          	auipc	a0,0x4
    36b2:	ec250513          	addi	a0,a0,-318 # 7570 <malloc+0x1c26>
    36b6:	1e0020ef          	jal	ra,5896 <printf>
      exit(1);
    36ba:	4505                	li	a0,1
    36bc:	5b7010ef          	jal	ra,5472 <exit>
      fprintf(errfd, "%s: create failed\n", s);
    36c0:	864a                	mv	a2,s2
    36c2:	00003597          	auipc	a1,0x3
    36c6:	da658593          	addi	a1,a1,-602 # 6468 <malloc+0xb1e>
    36ca:	854e                	mv	a0,s3
    36cc:	1a0020ef          	jal	ra,586c <fprintf>
      exit(1);
    36d0:	4505                	li	a0,1
    36d2:	5a1010ef          	jal	ra,5472 <exit>
    if (exec("echo", echoargv) < 0) {
    36d6:	fb040593          	addi	a1,s0,-80
    36da:	00002517          	auipc	a0,0x2
    36de:	38e50513          	addi	a0,a0,910 # 5a68 <malloc+0x11e>
    36e2:	5c9010ef          	jal	ra,54aa <exec>
    36e6:	02054563          	bltz	a0,3710 <exectest+0xfe>
  if (wait(&xstatus) != pid) {
    36ea:	fcc40513          	addi	a0,s0,-52
    36ee:	58d010ef          	jal	ra,547a <wait>
    36f2:	02951a63          	bne	a0,s1,3726 <exectest+0x114>
  if (xstatus != 0) {
    36f6:	fcc42603          	lw	a2,-52(s0)
    36fa:	ce15                	beqz	a2,3736 <exectest+0x124>
    printf("%s: nonzero wait status %d\n", s, xstatus);
    36fc:	85ca                	mv	a1,s2
    36fe:	00004517          	auipc	a0,0x4
    3702:	ec250513          	addi	a0,a0,-318 # 75c0 <malloc+0x1c76>
    3706:	190020ef          	jal	ra,5896 <printf>
    exit(1);
    370a:	4505                	li	a0,1
    370c:	567010ef          	jal	ra,5472 <exit>
      fprintf(errfd, "%s: exec echo failed\n", s);
    3710:	864a                	mv	a2,s2
    3712:	00004597          	auipc	a1,0x4
    3716:	e7e58593          	addi	a1,a1,-386 # 7590 <malloc+0x1c46>
    371a:	854e                	mv	a0,s3
    371c:	150020ef          	jal	ra,586c <fprintf>
      exit(1);
    3720:	4505                	li	a0,1
    3722:	551010ef          	jal	ra,5472 <exit>
    printf("%s: wait failed!\n", s);
    3726:	85ca                	mv	a1,s2
    3728:	00004517          	auipc	a0,0x4
    372c:	e8050513          	addi	a0,a0,-384 # 75a8 <malloc+0x1c5e>
    3730:	166020ef          	jal	ra,5896 <printf>
    3734:	b7c9                	j	36f6 <exectest+0xe4>
  fd = open("echo-ok", O_RDONLY);
    3736:	4581                	li	a1,0
    3738:	00004517          	auipc	a0,0x4
    373c:	e3050513          	addi	a0,a0,-464 # 7568 <malloc+0x1c1e>
    3740:	573010ef          	jal	ra,54b2 <open>
  if (fd < 0) {
    3744:	02054463          	bltz	a0,376c <exectest+0x15a>
  if (read(fd, buf, 2) != 2) {
    3748:	4609                	li	a2,2
    374a:	fa840593          	addi	a1,s0,-88
    374e:	53d010ef          	jal	ra,548a <read>
    3752:	4789                	li	a5,2
    3754:	02f50663          	beq	a0,a5,3780 <exectest+0x16e>
    printf("%s: read failed\n", s);
    3758:	85ca                	mv	a1,s2
    375a:	00002517          	auipc	a0,0x2
    375e:	6de50513          	addi	a0,a0,1758 # 5e38 <malloc+0x4ee>
    3762:	134020ef          	jal	ra,5896 <printf>
    exit(1);
    3766:	4505                	li	a0,1
    3768:	50b010ef          	jal	ra,5472 <exit>
    printf("%s: open failed\n", s);
    376c:	85ca                	mv	a1,s2
    376e:	00003517          	auipc	a0,0x3
    3772:	ba250513          	addi	a0,a0,-1118 # 6310 <malloc+0x9c6>
    3776:	120020ef          	jal	ra,5896 <printf>
    exit(1);
    377a:	4505                	li	a0,1
    377c:	4f7010ef          	jal	ra,5472 <exit>
  unlink("echo-ok");
    3780:	00004517          	auipc	a0,0x4
    3784:	de850513          	addi	a0,a0,-536 # 7568 <malloc+0x1c1e>
    3788:	53b010ef          	jal	ra,54c2 <unlink>
  if (buf[0] == 'O' && buf[1] == 'K')
    378c:	fa844703          	lbu	a4,-88(s0)
    3790:	04f00793          	li	a5,79
    3794:	00f71863          	bne	a4,a5,37a4 <exectest+0x192>
    3798:	fa944703          	lbu	a4,-87(s0)
    379c:	04b00793          	li	a5,75
    37a0:	00f70c63          	beq	a4,a5,37b8 <exectest+0x1a6>
    printf("%s: wrong output\n", s);
    37a4:	85ca                	mv	a1,s2
    37a6:	00004517          	auipc	a0,0x4
    37aa:	e3a50513          	addi	a0,a0,-454 # 75e0 <malloc+0x1c96>
    37ae:	0e8020ef          	jal	ra,5896 <printf>
    exit(1);
    37b2:	4505                	li	a0,1
    37b4:	4bf010ef          	jal	ra,5472 <exit>
    exit(0);
    37b8:	4501                	li	a0,0
    37ba:	4b9010ef          	jal	ra,5472 <exit>

00000000000037be <killstatus>:
{
    37be:	7139                	addi	sp,sp,-64
    37c0:	fc06                	sd	ra,56(sp)
    37c2:	f822                	sd	s0,48(sp)
    37c4:	f426                	sd	s1,40(sp)
    37c6:	f04a                	sd	s2,32(sp)
    37c8:	ec4e                	sd	s3,24(sp)
    37ca:	e852                	sd	s4,16(sp)
    37cc:	0080                	addi	s0,sp,64
    37ce:	8a2a                	mv	s4,a0
    37d0:	06400913          	li	s2,100
    if (xst != -1) {
    37d4:	59fd                	li	s3,-1
    int pid1 = fork();
    37d6:	495010ef          	jal	ra,546a <fork>
    37da:	84aa                	mv	s1,a0
    if (pid1 < 0) {
    37dc:	02054763          	bltz	a0,380a <killstatus+0x4c>
    if (pid1 == 0) {
    37e0:	cd1d                	beqz	a0,381e <killstatus+0x60>
    pause(1);
    37e2:	4505                	li	a0,1
    37e4:	51f010ef          	jal	ra,5502 <pause>
    kill(pid1);
    37e8:	8526                	mv	a0,s1
    37ea:	4b9010ef          	jal	ra,54a2 <kill>
    wait(&xst);
    37ee:	fcc40513          	addi	a0,s0,-52
    37f2:	489010ef          	jal	ra,547a <wait>
    if (xst != -1) {
    37f6:	fcc42783          	lw	a5,-52(s0)
    37fa:	03379563          	bne	a5,s3,3824 <killstatus+0x66>
  for (int i = 0; i < 100; i++) {
    37fe:	397d                	addiw	s2,s2,-1
    3800:	fc091be3          	bnez	s2,37d6 <killstatus+0x18>
  exit(0);
    3804:	4501                	li	a0,0
    3806:	46d010ef          	jal	ra,5472 <exit>
      printf("%s: fork failed\n", s);
    380a:	85d2                	mv	a1,s4
    380c:	00003517          	auipc	a0,0x3
    3810:	aec50513          	addi	a0,a0,-1300 # 62f8 <malloc+0x9ae>
    3814:	082020ef          	jal	ra,5896 <printf>
      exit(1);
    3818:	4505                	li	a0,1
    381a:	459010ef          	jal	ra,5472 <exit>
        getpid();
    381e:	4d5010ef          	jal	ra,54f2 <getpid>
      while (1) {
    3822:	bff5                	j	381e <killstatus+0x60>
      printf("%s: status should be -1\n", s);
    3824:	85d2                	mv	a1,s4
    3826:	00004517          	auipc	a0,0x4
    382a:	dd250513          	addi	a0,a0,-558 # 75f8 <malloc+0x1cae>
    382e:	068020ef          	jal	ra,5896 <printf>
      exit(1);
    3832:	4505                	li	a0,1
    3834:	43f010ef          	jal	ra,5472 <exit>

0000000000003838 <killzero>:
{
    3838:	7179                	addi	sp,sp,-48
    383a:	f406                	sd	ra,40(sp)
    383c:	f022                	sd	s0,32(sp)
    383e:	ec26                	sd	s1,24(sp)
    3840:	e84a                	sd	s2,16(sp)
    3842:	1800                	addi	s0,sp,48
    3844:	892a                	mv	s2,a0
  kill(0);
    3846:	4501                	li	a0,0
    3848:	45b010ef          	jal	ra,54a2 <kill>
  pid = fork();
    384c:	41f010ef          	jal	ra,546a <fork>
  if (pid < 0) {
    3850:	00054763          	bltz	a0,385e <killzero+0x26>
    3854:	84aa                	mv	s1,a0
  if (pid == 0) {
    3856:	ed11                	bnez	a0,3872 <killzero+0x3a>
    exit(7);
    3858:	451d                	li	a0,7
    385a:	419010ef          	jal	ra,5472 <exit>
    printf("%s: fork failed\n", s);
    385e:	85ca                	mv	a1,s2
    3860:	00003517          	auipc	a0,0x3
    3864:	a9850513          	addi	a0,a0,-1384 # 62f8 <malloc+0x9ae>
    3868:	02e020ef          	jal	ra,5896 <printf>
    exit(1);
    386c:	4505                	li	a0,1
    386e:	405010ef          	jal	ra,5472 <exit>
  if (wait(&xst) != pid) {
    3872:	fdc40513          	addi	a0,s0,-36
    3876:	405010ef          	jal	ra,547a <wait>
    387a:	02951163          	bne	a0,s1,389c <killzero+0x64>
  if (xst != 7) {
    387e:	fdc42603          	lw	a2,-36(s0)
    3882:	479d                	li	a5,7
    3884:	02f60663          	beq	a2,a5,38b0 <killzero+0x78>
    printf("%s: child exited with status %d, expected 7\n", s, xst);
    3888:	85ca                	mv	a1,s2
    388a:	00004517          	auipc	a0,0x4
    388e:	d8e50513          	addi	a0,a0,-626 # 7618 <malloc+0x1cce>
    3892:	004020ef          	jal	ra,5896 <printf>
    exit(1);
    3896:	4505                	li	a0,1
    3898:	3db010ef          	jal	ra,5472 <exit>
    printf("%s: wait wrong pid\n", s);
    389c:	85ca                	mv	a1,s2
    389e:	00003517          	auipc	a0,0x3
    38a2:	b6250513          	addi	a0,a0,-1182 # 6400 <malloc+0xab6>
    38a6:	7f1010ef          	jal	ra,5896 <printf>
    exit(1);
    38aa:	4505                	li	a0,1
    38ac:	3c7010ef          	jal	ra,5472 <exit>
  exit(0);
    38b0:	4501                	li	a0,0
    38b2:	3c1010ef          	jal	ra,5472 <exit>

00000000000038b6 <preempt>:
{
    38b6:	7139                	addi	sp,sp,-64
    38b8:	fc06                	sd	ra,56(sp)
    38ba:	f822                	sd	s0,48(sp)
    38bc:	f426                	sd	s1,40(sp)
    38be:	f04a                	sd	s2,32(sp)
    38c0:	ec4e                	sd	s3,24(sp)
    38c2:	e852                	sd	s4,16(sp)
    38c4:	0080                	addi	s0,sp,64
    38c6:	892a                	mv	s2,a0
  pid1 = fork();
    38c8:	3a3010ef          	jal	ra,546a <fork>
  if (pid1 < 0) {
    38cc:	00054563          	bltz	a0,38d6 <preempt+0x20>
    38d0:	84aa                	mv	s1,a0
  if (pid1 == 0)
    38d2:	ed01                	bnez	a0,38ea <preempt+0x34>
    for (;;)
    38d4:	a001                	j	38d4 <preempt+0x1e>
    printf("%s: fork failed", s);
    38d6:	85ca                	mv	a1,s2
    38d8:	00003517          	auipc	a0,0x3
    38dc:	b6050513          	addi	a0,a0,-1184 # 6438 <malloc+0xaee>
    38e0:	7b7010ef          	jal	ra,5896 <printf>
    exit(1);
    38e4:	4505                	li	a0,1
    38e6:	38d010ef          	jal	ra,5472 <exit>
  pid2 = fork();
    38ea:	381010ef          	jal	ra,546a <fork>
    38ee:	89aa                	mv	s3,a0
  if (pid2 < 0) {
    38f0:	00054463          	bltz	a0,38f8 <preempt+0x42>
  if (pid2 == 0)
    38f4:	ed01                	bnez	a0,390c <preempt+0x56>
    for (;;)
    38f6:	a001                	j	38f6 <preempt+0x40>
    printf("%s: fork failed\n", s);
    38f8:	85ca                	mv	a1,s2
    38fa:	00003517          	auipc	a0,0x3
    38fe:	9fe50513          	addi	a0,a0,-1538 # 62f8 <malloc+0x9ae>
    3902:	795010ef          	jal	ra,5896 <printf>
    exit(1);
    3906:	4505                	li	a0,1
    3908:	36b010ef          	jal	ra,5472 <exit>
  pipe(pfds);
    390c:	fc840513          	addi	a0,s0,-56
    3910:	373010ef          	jal	ra,5482 <pipe>
  pid3 = fork();
    3914:	357010ef          	jal	ra,546a <fork>
    3918:	8a2a                	mv	s4,a0
  if (pid3 < 0) {
    391a:	02054863          	bltz	a0,394a <preempt+0x94>
  if (pid3 == 0) {
    391e:	e921                	bnez	a0,396e <preempt+0xb8>
    close(pfds[0]);
    3920:	fc842503          	lw	a0,-56(s0)
    3924:	377010ef          	jal	ra,549a <close>
    if (write(pfds[1], "x", 1) != 1)
    3928:	4605                	li	a2,1
    392a:	00002597          	auipc	a1,0x2
    392e:	1ae58593          	addi	a1,a1,430 # 5ad8 <malloc+0x18e>
    3932:	fcc42503          	lw	a0,-52(s0)
    3936:	35d010ef          	jal	ra,5492 <write>
    393a:	4785                	li	a5,1
    393c:	02f51163          	bne	a0,a5,395e <preempt+0xa8>
    close(pfds[1]);
    3940:	fcc42503          	lw	a0,-52(s0)
    3944:	357010ef          	jal	ra,549a <close>
    for (;;)
    3948:	a001                	j	3948 <preempt+0x92>
    printf("%s: fork failed\n", s);
    394a:	85ca                	mv	a1,s2
    394c:	00003517          	auipc	a0,0x3
    3950:	9ac50513          	addi	a0,a0,-1620 # 62f8 <malloc+0x9ae>
    3954:	743010ef          	jal	ra,5896 <printf>
    exit(1);
    3958:	4505                	li	a0,1
    395a:	319010ef          	jal	ra,5472 <exit>
      printf("%s: preempt write error", s);
    395e:	85ca                	mv	a1,s2
    3960:	00004517          	auipc	a0,0x4
    3964:	ce850513          	addi	a0,a0,-792 # 7648 <malloc+0x1cfe>
    3968:	72f010ef          	jal	ra,5896 <printf>
    396c:	bfd1                	j	3940 <preempt+0x8a>
  close(pfds[1]);
    396e:	fcc42503          	lw	a0,-52(s0)
    3972:	329010ef          	jal	ra,549a <close>
  if (read(pfds[0], buf, sizeof(buf)) != 1) {
    3976:	660d                	lui	a2,0x3
    3978:	00009597          	auipc	a1,0x9
    397c:	38058593          	addi	a1,a1,896 # ccf8 <buf>
    3980:	fc842503          	lw	a0,-56(s0)
    3984:	307010ef          	jal	ra,548a <read>
    3988:	4785                	li	a5,1
    398a:	02f50163          	beq	a0,a5,39ac <preempt+0xf6>
    printf("%s: preempt read error", s);
    398e:	85ca                	mv	a1,s2
    3990:	00004517          	auipc	a0,0x4
    3994:	cd050513          	addi	a0,a0,-816 # 7660 <malloc+0x1d16>
    3998:	6ff010ef          	jal	ra,5896 <printf>
}
    399c:	70e2                	ld	ra,56(sp)
    399e:	7442                	ld	s0,48(sp)
    39a0:	74a2                	ld	s1,40(sp)
    39a2:	7902                	ld	s2,32(sp)
    39a4:	69e2                	ld	s3,24(sp)
    39a6:	6a42                	ld	s4,16(sp)
    39a8:	6121                	addi	sp,sp,64
    39aa:	8082                	ret
  close(pfds[0]);
    39ac:	fc842503          	lw	a0,-56(s0)
    39b0:	2eb010ef          	jal	ra,549a <close>
  printf("kill... ");
    39b4:	00004517          	auipc	a0,0x4
    39b8:	cc450513          	addi	a0,a0,-828 # 7678 <malloc+0x1d2e>
    39bc:	6db010ef          	jal	ra,5896 <printf>
  kill(pid1);
    39c0:	8526                	mv	a0,s1
    39c2:	2e1010ef          	jal	ra,54a2 <kill>
  kill(pid2);
    39c6:	854e                	mv	a0,s3
    39c8:	2db010ef          	jal	ra,54a2 <kill>
  kill(pid3);
    39cc:	8552                	mv	a0,s4
    39ce:	2d5010ef          	jal	ra,54a2 <kill>
  printf("wait... ");
    39d2:	00004517          	auipc	a0,0x4
    39d6:	cb650513          	addi	a0,a0,-842 # 7688 <malloc+0x1d3e>
    39da:	6bd010ef          	jal	ra,5896 <printf>
  wait(0);
    39de:	4501                	li	a0,0
    39e0:	29b010ef          	jal	ra,547a <wait>
  wait(0);
    39e4:	4501                	li	a0,0
    39e6:	295010ef          	jal	ra,547a <wait>
  wait(0);
    39ea:	4501                	li	a0,0
    39ec:	28f010ef          	jal	ra,547a <wait>
    39f0:	b775                	j	399c <preempt+0xe6>

00000000000039f2 <reparent>:
{
    39f2:	7179                	addi	sp,sp,-48
    39f4:	f406                	sd	ra,40(sp)
    39f6:	f022                	sd	s0,32(sp)
    39f8:	ec26                	sd	s1,24(sp)
    39fa:	e84a                	sd	s2,16(sp)
    39fc:	e44e                	sd	s3,8(sp)
    39fe:	e052                	sd	s4,0(sp)
    3a00:	1800                	addi	s0,sp,48
    3a02:	89aa                	mv	s3,a0
  int master_pid = getpid();
    3a04:	2ef010ef          	jal	ra,54f2 <getpid>
    3a08:	8a2a                	mv	s4,a0
    3a0a:	0c800913          	li	s2,200
    int pid = fork();
    3a0e:	25d010ef          	jal	ra,546a <fork>
    3a12:	84aa                	mv	s1,a0
    if (pid < 0) {
    3a14:	00054e63          	bltz	a0,3a30 <reparent+0x3e>
    if (pid) {
    3a18:	c121                	beqz	a0,3a58 <reparent+0x66>
      if (wait(0) != pid) {
    3a1a:	4501                	li	a0,0
    3a1c:	25f010ef          	jal	ra,547a <wait>
    3a20:	02951263          	bne	a0,s1,3a44 <reparent+0x52>
  for (int i = 0; i < 200; i++) {
    3a24:	397d                	addiw	s2,s2,-1
    3a26:	fe0914e3          	bnez	s2,3a0e <reparent+0x1c>
  exit(0);
    3a2a:	4501                	li	a0,0
    3a2c:	247010ef          	jal	ra,5472 <exit>
      printf("%s: fork failed\n", s);
    3a30:	85ce                	mv	a1,s3
    3a32:	00003517          	auipc	a0,0x3
    3a36:	8c650513          	addi	a0,a0,-1850 # 62f8 <malloc+0x9ae>
    3a3a:	65d010ef          	jal	ra,5896 <printf>
      exit(1);
    3a3e:	4505                	li	a0,1
    3a40:	233010ef          	jal	ra,5472 <exit>
        printf("%s: wait wrong pid\n", s);
    3a44:	85ce                	mv	a1,s3
    3a46:	00003517          	auipc	a0,0x3
    3a4a:	9ba50513          	addi	a0,a0,-1606 # 6400 <malloc+0xab6>
    3a4e:	649010ef          	jal	ra,5896 <printf>
        exit(1);
    3a52:	4505                	li	a0,1
    3a54:	21f010ef          	jal	ra,5472 <exit>
      int pid2 = fork();
    3a58:	213010ef          	jal	ra,546a <fork>
      if (pid2 < 0) {
    3a5c:	00054563          	bltz	a0,3a66 <reparent+0x74>
      exit(0);
    3a60:	4501                	li	a0,0
    3a62:	211010ef          	jal	ra,5472 <exit>
        kill(master_pid);
    3a66:	8552                	mv	a0,s4
    3a68:	23b010ef          	jal	ra,54a2 <kill>
        exit(1);
    3a6c:	4505                	li	a0,1
    3a6e:	205010ef          	jal	ra,5472 <exit>

0000000000003a72 <sbrkfail>:
{
    3a72:	7175                	addi	sp,sp,-144
    3a74:	e506                	sd	ra,136(sp)
    3a76:	e122                	sd	s0,128(sp)
    3a78:	fca6                	sd	s1,120(sp)
    3a7a:	f8ca                	sd	s2,112(sp)
    3a7c:	f4ce                	sd	s3,104(sp)
    3a7e:	f0d2                	sd	s4,96(sp)
    3a80:	ecd6                	sd	s5,88(sp)
    3a82:	e8da                	sd	s6,80(sp)
    3a84:	e4de                	sd	s7,72(sp)
    3a86:	0900                	addi	s0,sp,144
    3a88:	8b2a                	mv	s6,a0
  if (pipe(fds) != 0) {
    3a8a:	fa040513          	addi	a0,s0,-96
    3a8e:	1f5010ef          	jal	ra,5482 <pipe>
    3a92:	e919                	bnez	a0,3aa8 <sbrkfail+0x36>
    3a94:	8aaa                	mv	s5,a0
    3a96:	f7040493          	addi	s1,s0,-144
    3a9a:	f9840993          	addi	s3,s0,-104
    3a9e:	8926                	mv	s2,s1
    if (pids[i] != -1) {
    3aa0:	5a7d                	li	s4,-1
      if (scratch == '0')
    3aa2:	03000b93          	li	s7,48
    3aa6:	a08d                	j	3b08 <sbrkfail+0x96>
    printf("%s: pipe() failed\n", s);
    3aa8:	85da                	mv	a1,s6
    3aaa:	00003517          	auipc	a0,0x3
    3aae:	8d650513          	addi	a0,a0,-1834 # 6380 <malloc+0xa36>
    3ab2:	5e5010ef          	jal	ra,5896 <printf>
    exit(1);
    3ab6:	4505                	li	a0,1
    3ab8:	1bb010ef          	jal	ra,5472 <exit>
      if (sbrk(BIG - (uint64)sbrk(0)) == (char *)SBRK_ERROR)
    3abc:	183010ef          	jal	ra,543e <sbrk>
    3ac0:	064007b7          	lui	a5,0x6400
    3ac4:	40a7853b          	subw	a0,a5,a0
    3ac8:	177010ef          	jal	ra,543e <sbrk>
    3acc:	57fd                	li	a5,-1
    3ace:	02f50063          	beq	a0,a5,3aee <sbrkfail+0x7c>
        write(fds[1], "1", 1);
    3ad2:	4605                	li	a2,1
    3ad4:	00004597          	auipc	a1,0x4
    3ad8:	56c58593          	addi	a1,a1,1388 # 8040 <malloc+0x26f6>
    3adc:	fa442503          	lw	a0,-92(s0)
    3ae0:	1b3010ef          	jal	ra,5492 <write>
        pause(1000);
    3ae4:	3e800513          	li	a0,1000
    3ae8:	21b010ef          	jal	ra,5502 <pause>
      for (;;)
    3aec:	bfe5                	j	3ae4 <sbrkfail+0x72>
        write(fds[1], "0", 1);
    3aee:	4605                	li	a2,1
    3af0:	00004597          	auipc	a1,0x4
    3af4:	ba858593          	addi	a1,a1,-1112 # 7698 <malloc+0x1d4e>
    3af8:	fa442503          	lw	a0,-92(s0)
    3afc:	197010ef          	jal	ra,5492 <write>
    3b00:	b7d5                	j	3ae4 <sbrkfail+0x72>
  for (i = 0; i < sizeof(pids) / sizeof(pids[0]); i++) {
    3b02:	0911                	addi	s2,s2,4
    3b04:	03390663          	beq	s2,s3,3b30 <sbrkfail+0xbe>
    if ((pids[i] = fork()) == 0) {
    3b08:	163010ef          	jal	ra,546a <fork>
    3b0c:	00a92023          	sw	a0,0(s2)
    3b10:	d555                	beqz	a0,3abc <sbrkfail+0x4a>
    if (pids[i] != -1) {
    3b12:	ff4508e3          	beq	a0,s4,3b02 <sbrkfail+0x90>
      read(fds[0], &scratch, 1);
    3b16:	4605                	li	a2,1
    3b18:	f9f40593          	addi	a1,s0,-97
    3b1c:	fa042503          	lw	a0,-96(s0)
    3b20:	16b010ef          	jal	ra,548a <read>
      if (scratch == '0')
    3b24:	f9f44783          	lbu	a5,-97(s0)
    3b28:	fd779de3          	bne	a5,s7,3b02 <sbrkfail+0x90>
        failed = 1;
    3b2c:	4a85                	li	s5,1
    3b2e:	bfd1                	j	3b02 <sbrkfail+0x90>
  if (!failed) {
    3b30:	000a8863          	beqz	s5,3b40 <sbrkfail+0xce>
  c = sbrk(PGSIZE);
    3b34:	6505                	lui	a0,0x1
    3b36:	109010ef          	jal	ra,543e <sbrk>
    3b3a:	8a2a                	mv	s4,a0
    if (pids[i] == -1)
    3b3c:	597d                	li	s2,-1
    3b3e:	a821                	j	3b56 <sbrkfail+0xe4>
    printf("%s: no allocation failed; allocate more?\n", s);
    3b40:	85da                	mv	a1,s6
    3b42:	00004517          	auipc	a0,0x4
    3b46:	b5e50513          	addi	a0,a0,-1186 # 76a0 <malloc+0x1d56>
    3b4a:	54d010ef          	jal	ra,5896 <printf>
    3b4e:	b7dd                	j	3b34 <sbrkfail+0xc2>
  for (i = 0; i < sizeof(pids) / sizeof(pids[0]); i++) {
    3b50:	0491                	addi	s1,s1,4
    3b52:	01348b63          	beq	s1,s3,3b68 <sbrkfail+0xf6>
    if (pids[i] == -1)
    3b56:	4088                	lw	a0,0(s1)
    3b58:	ff250ce3          	beq	a0,s2,3b50 <sbrkfail+0xde>
    kill(pids[i]);
    3b5c:	147010ef          	jal	ra,54a2 <kill>
    wait(0);
    3b60:	4501                	li	a0,0
    3b62:	119010ef          	jal	ra,547a <wait>
    3b66:	b7ed                	j	3b50 <sbrkfail+0xde>
  if (c == (char *)SBRK_ERROR) {
    3b68:	57fd                	li	a5,-1
    3b6a:	02fa0a63          	beq	s4,a5,3b9e <sbrkfail+0x12c>
  pid = fork();
    3b6e:	0fd010ef          	jal	ra,546a <fork>
  if (pid < 0) {
    3b72:	04054063          	bltz	a0,3bb2 <sbrkfail+0x140>
  if (pid == 0) {
    3b76:	e939                	bnez	a0,3bcc <sbrkfail+0x15a>
    a = sbrk(10 * BIG);
    3b78:	3e800537          	lui	a0,0x3e800
    3b7c:	0c3010ef          	jal	ra,543e <sbrk>
    if (a == (char *)SBRK_ERROR) {
    3b80:	57fd                	li	a5,-1
    3b82:	04f50263          	beq	a0,a5,3bc6 <sbrkfail+0x154>
    printf("%s: allocate a lot of memory succeeded %d\n", s, 10 * BIG);
    3b86:	3e800637          	lui	a2,0x3e800
    3b8a:	85da                	mv	a1,s6
    3b8c:	00004517          	auipc	a0,0x4
    3b90:	b6450513          	addi	a0,a0,-1180 # 76f0 <malloc+0x1da6>
    3b94:	503010ef          	jal	ra,5896 <printf>
    exit(1);
    3b98:	4505                	li	a0,1
    3b9a:	0d9010ef          	jal	ra,5472 <exit>
    printf("%s: failed sbrk leaked memory\n", s);
    3b9e:	85da                	mv	a1,s6
    3ba0:	00004517          	auipc	a0,0x4
    3ba4:	b3050513          	addi	a0,a0,-1232 # 76d0 <malloc+0x1d86>
    3ba8:	4ef010ef          	jal	ra,5896 <printf>
    exit(1);
    3bac:	4505                	li	a0,1
    3bae:	0c5010ef          	jal	ra,5472 <exit>
    printf("%s: fork failed\n", s);
    3bb2:	85da                	mv	a1,s6
    3bb4:	00002517          	auipc	a0,0x2
    3bb8:	74450513          	addi	a0,a0,1860 # 62f8 <malloc+0x9ae>
    3bbc:	4db010ef          	jal	ra,5896 <printf>
    exit(1);
    3bc0:	4505                	li	a0,1
    3bc2:	0b1010ef          	jal	ra,5472 <exit>
      exit(0);
    3bc6:	4501                	li	a0,0
    3bc8:	0ab010ef          	jal	ra,5472 <exit>
  wait(&xstatus);
    3bcc:	fac40513          	addi	a0,s0,-84
    3bd0:	0ab010ef          	jal	ra,547a <wait>
  if (xstatus != 0)
    3bd4:	fac42783          	lw	a5,-84(s0)
    3bd8:	ef81                	bnez	a5,3bf0 <sbrkfail+0x17e>
}
    3bda:	60aa                	ld	ra,136(sp)
    3bdc:	640a                	ld	s0,128(sp)
    3bde:	74e6                	ld	s1,120(sp)
    3be0:	7946                	ld	s2,112(sp)
    3be2:	79a6                	ld	s3,104(sp)
    3be4:	7a06                	ld	s4,96(sp)
    3be6:	6ae6                	ld	s5,88(sp)
    3be8:	6b46                	ld	s6,80(sp)
    3bea:	6ba6                	ld	s7,72(sp)
    3bec:	6149                	addi	sp,sp,144
    3bee:	8082                	ret
    exit(1);
    3bf0:	4505                	li	a0,1
    3bf2:	081010ef          	jal	ra,5472 <exit>

0000000000003bf6 <mem>:
{
    3bf6:	7139                	addi	sp,sp,-64
    3bf8:	fc06                	sd	ra,56(sp)
    3bfa:	f822                	sd	s0,48(sp)
    3bfc:	f426                	sd	s1,40(sp)
    3bfe:	f04a                	sd	s2,32(sp)
    3c00:	ec4e                	sd	s3,24(sp)
    3c02:	0080                	addi	s0,sp,64
    3c04:	89aa                	mv	s3,a0
  if ((pid = fork()) == 0) {
    3c06:	065010ef          	jal	ra,546a <fork>
    m1 = 0;
    3c0a:	4481                	li	s1,0
    while ((m2 = malloc(10001)) != 0) {
    3c0c:	6909                	lui	s2,0x2
    3c0e:	71190913          	addi	s2,s2,1809 # 2711 <diskfull+0x123>
  if ((pid = fork()) == 0) {
    3c12:	cd11                	beqz	a0,3c2e <mem+0x38>
    wait(&xstatus);
    3c14:	fcc40513          	addi	a0,s0,-52
    3c18:	063010ef          	jal	ra,547a <wait>
    if (xstatus == -1) {
    3c1c:	fcc42503          	lw	a0,-52(s0)
    3c20:	57fd                	li	a5,-1
    3c22:	04f50363          	beq	a0,a5,3c68 <mem+0x72>
    exit(xstatus);
    3c26:	04d010ef          	jal	ra,5472 <exit>
      *(char **)m2 = m1;
    3c2a:	e104                	sd	s1,0(a0)
      m1 = m2;
    3c2c:	84aa                	mv	s1,a0
    while ((m2 = malloc(10001)) != 0) {
    3c2e:	854a                	mv	a0,s2
    3c30:	51b010ef          	jal	ra,594a <malloc>
    3c34:	f97d                	bnez	a0,3c2a <mem+0x34>
    while (m1) {
    3c36:	c491                	beqz	s1,3c42 <mem+0x4c>
      m2 = *(char **)m1;
    3c38:	8526                	mv	a0,s1
    3c3a:	6084                	ld	s1,0(s1)
      free(m1);
    3c3c:	48d010ef          	jal	ra,58c8 <free>
    while (m1) {
    3c40:	fce5                	bnez	s1,3c38 <mem+0x42>
    m1 = malloc(1024 * 20);
    3c42:	6515                	lui	a0,0x5
    3c44:	507010ef          	jal	ra,594a <malloc>
    if (m1 == 0) {
    3c48:	c511                	beqz	a0,3c54 <mem+0x5e>
    free(m1);
    3c4a:	47f010ef          	jal	ra,58c8 <free>
    exit(0);
    3c4e:	4501                	li	a0,0
    3c50:	023010ef          	jal	ra,5472 <exit>
      printf("%s: couldn't allocate mem?!!\n", s);
    3c54:	85ce                	mv	a1,s3
    3c56:	00004517          	auipc	a0,0x4
    3c5a:	aca50513          	addi	a0,a0,-1334 # 7720 <malloc+0x1dd6>
    3c5e:	439010ef          	jal	ra,5896 <printf>
      exit(1);
    3c62:	4505                	li	a0,1
    3c64:	00f010ef          	jal	ra,5472 <exit>
      exit(0);
    3c68:	4501                	li	a0,0
    3c6a:	009010ef          	jal	ra,5472 <exit>

0000000000003c6e <sharedfd>:
{
    3c6e:	7159                	addi	sp,sp,-112
    3c70:	f486                	sd	ra,104(sp)
    3c72:	f0a2                	sd	s0,96(sp)
    3c74:	eca6                	sd	s1,88(sp)
    3c76:	e8ca                	sd	s2,80(sp)
    3c78:	e4ce                	sd	s3,72(sp)
    3c7a:	e0d2                	sd	s4,64(sp)
    3c7c:	fc56                	sd	s5,56(sp)
    3c7e:	f85a                	sd	s6,48(sp)
    3c80:	f45e                	sd	s7,40(sp)
    3c82:	1880                	addi	s0,sp,112
    3c84:	8a2a                	mv	s4,a0
  unlink("sharedfd");
    3c86:	00004517          	auipc	a0,0x4
    3c8a:	aba50513          	addi	a0,a0,-1350 # 7740 <malloc+0x1df6>
    3c8e:	035010ef          	jal	ra,54c2 <unlink>
  fd = open("sharedfd", O_CREATE | O_RDWR);
    3c92:	20200593          	li	a1,514
    3c96:	00004517          	auipc	a0,0x4
    3c9a:	aaa50513          	addi	a0,a0,-1366 # 7740 <malloc+0x1df6>
    3c9e:	015010ef          	jal	ra,54b2 <open>
  if (fd < 0) {
    3ca2:	04054263          	bltz	a0,3ce6 <sharedfd+0x78>
    3ca6:	892a                	mv	s2,a0
  pid = fork();
    3ca8:	7c2010ef          	jal	ra,546a <fork>
    3cac:	89aa                	mv	s3,a0
  memset(buf, pid == 0 ? 'c' : 'p', sizeof(buf));
    3cae:	06300593          	li	a1,99
    3cb2:	c119                	beqz	a0,3cb8 <sharedfd+0x4a>
    3cb4:	07000593          	li	a1,112
    3cb8:	4629                	li	a2,10
    3cba:	fa040513          	addi	a0,s0,-96
    3cbe:	5a2010ef          	jal	ra,5260 <memset>
    3cc2:	3e800493          	li	s1,1000
    if (write(fd, buf, sizeof(buf)) != sizeof(buf)) {
    3cc6:	4629                	li	a2,10
    3cc8:	fa040593          	addi	a1,s0,-96
    3ccc:	854a                	mv	a0,s2
    3cce:	7c4010ef          	jal	ra,5492 <write>
    3cd2:	47a9                	li	a5,10
    3cd4:	02f51363          	bne	a0,a5,3cfa <sharedfd+0x8c>
  for (i = 0; i < N; i++) {
    3cd8:	34fd                	addiw	s1,s1,-1
    3cda:	f4f5                	bnez	s1,3cc6 <sharedfd+0x58>
  if (pid == 0) {
    3cdc:	02099963          	bnez	s3,3d0e <sharedfd+0xa0>
    exit(0);
    3ce0:	4501                	li	a0,0
    3ce2:	790010ef          	jal	ra,5472 <exit>
    printf("%s: cannot open sharedfd for writing", s);
    3ce6:	85d2                	mv	a1,s4
    3ce8:	00004517          	auipc	a0,0x4
    3cec:	a6850513          	addi	a0,a0,-1432 # 7750 <malloc+0x1e06>
    3cf0:	3a7010ef          	jal	ra,5896 <printf>
    exit(1);
    3cf4:	4505                	li	a0,1
    3cf6:	77c010ef          	jal	ra,5472 <exit>
      printf("%s: write sharedfd failed\n", s);
    3cfa:	85d2                	mv	a1,s4
    3cfc:	00004517          	auipc	a0,0x4
    3d00:	a7c50513          	addi	a0,a0,-1412 # 7778 <malloc+0x1e2e>
    3d04:	393010ef          	jal	ra,5896 <printf>
      exit(1);
    3d08:	4505                	li	a0,1
    3d0a:	768010ef          	jal	ra,5472 <exit>
    wait(&xstatus);
    3d0e:	f9c40513          	addi	a0,s0,-100
    3d12:	768010ef          	jal	ra,547a <wait>
    if (xstatus != 0)
    3d16:	f9c42983          	lw	s3,-100(s0)
    3d1a:	00098563          	beqz	s3,3d24 <sharedfd+0xb6>
      exit(xstatus);
    3d1e:	854e                	mv	a0,s3
    3d20:	752010ef          	jal	ra,5472 <exit>
  close(fd);
    3d24:	854a                	mv	a0,s2
    3d26:	774010ef          	jal	ra,549a <close>
  fd = open("sharedfd", 0);
    3d2a:	4581                	li	a1,0
    3d2c:	00004517          	auipc	a0,0x4
    3d30:	a1450513          	addi	a0,a0,-1516 # 7740 <malloc+0x1df6>
    3d34:	77e010ef          	jal	ra,54b2 <open>
    3d38:	8baa                	mv	s7,a0
  nc = np = 0;
    3d3a:	8ace                	mv	s5,s3
  if (fd < 0) {
    3d3c:	02054363          	bltz	a0,3d62 <sharedfd+0xf4>
    3d40:	faa40913          	addi	s2,s0,-86
      if (buf[i] == 'c')
    3d44:	06300493          	li	s1,99
      if (buf[i] == 'p')
    3d48:	07000b13          	li	s6,112
  while ((n = read(fd, buf, sizeof(buf))) > 0) {
    3d4c:	4629                	li	a2,10
    3d4e:	fa040593          	addi	a1,s0,-96
    3d52:	855e                	mv	a0,s7
    3d54:	736010ef          	jal	ra,548a <read>
    3d58:	02a05b63          	blez	a0,3d8e <sharedfd+0x120>
    3d5c:	fa040793          	addi	a5,s0,-96
    3d60:	a839                	j	3d7e <sharedfd+0x110>
    printf("%s: cannot open sharedfd for reading\n", s);
    3d62:	85d2                	mv	a1,s4
    3d64:	00004517          	auipc	a0,0x4
    3d68:	a3450513          	addi	a0,a0,-1484 # 7798 <malloc+0x1e4e>
    3d6c:	32b010ef          	jal	ra,5896 <printf>
    exit(1);
    3d70:	4505                	li	a0,1
    3d72:	700010ef          	jal	ra,5472 <exit>
        nc++;
    3d76:	2985                	addiw	s3,s3,1
    for (i = 0; i < sizeof(buf); i++) {
    3d78:	0785                	addi	a5,a5,1 # 6400001 <base+0x63f0309>
    3d7a:	fd2789e3          	beq	a5,s2,3d4c <sharedfd+0xde>
      if (buf[i] == 'c')
    3d7e:	0007c703          	lbu	a4,0(a5)
    3d82:	fe970ae3          	beq	a4,s1,3d76 <sharedfd+0x108>
      if (buf[i] == 'p')
    3d86:	ff6719e3          	bne	a4,s6,3d78 <sharedfd+0x10a>
        np++;
    3d8a:	2a85                	addiw	s5,s5,1
    3d8c:	b7f5                	j	3d78 <sharedfd+0x10a>
  close(fd);
    3d8e:	855e                	mv	a0,s7
    3d90:	70a010ef          	jal	ra,549a <close>
  unlink("sharedfd");
    3d94:	00004517          	auipc	a0,0x4
    3d98:	9ac50513          	addi	a0,a0,-1620 # 7740 <malloc+0x1df6>
    3d9c:	726010ef          	jal	ra,54c2 <unlink>
  if (nc == N * SZ && np == N * SZ) {
    3da0:	6789                	lui	a5,0x2
    3da2:	71078793          	addi	a5,a5,1808 # 2710 <diskfull+0x122>
    3da6:	00f99763          	bne	s3,a5,3db4 <sharedfd+0x146>
    3daa:	6789                	lui	a5,0x2
    3dac:	71078793          	addi	a5,a5,1808 # 2710 <diskfull+0x122>
    3db0:	00fa8c63          	beq	s5,a5,3dc8 <sharedfd+0x15a>
    printf("%s: nc/np test fails\n", s);
    3db4:	85d2                	mv	a1,s4
    3db6:	00004517          	auipc	a0,0x4
    3dba:	a0a50513          	addi	a0,a0,-1526 # 77c0 <malloc+0x1e76>
    3dbe:	2d9010ef          	jal	ra,5896 <printf>
    exit(1);
    3dc2:	4505                	li	a0,1
    3dc4:	6ae010ef          	jal	ra,5472 <exit>
    exit(0);
    3dc8:	4501                	li	a0,0
    3dca:	6a8010ef          	jal	ra,5472 <exit>

0000000000003dce <fourfiles>:
{
    3dce:	7171                	addi	sp,sp,-176
    3dd0:	f506                	sd	ra,168(sp)
    3dd2:	f122                	sd	s0,160(sp)
    3dd4:	ed26                	sd	s1,152(sp)
    3dd6:	e94a                	sd	s2,144(sp)
    3dd8:	e54e                	sd	s3,136(sp)
    3dda:	e152                	sd	s4,128(sp)
    3ddc:	fcd6                	sd	s5,120(sp)
    3dde:	f8da                	sd	s6,112(sp)
    3de0:	f4de                	sd	s7,104(sp)
    3de2:	f0e2                	sd	s8,96(sp)
    3de4:	ece6                	sd	s9,88(sp)
    3de6:	e8ea                	sd	s10,80(sp)
    3de8:	e4ee                	sd	s11,72(sp)
    3dea:	1900                	addi	s0,sp,176
    3dec:	f4a43c23          	sd	a0,-168(s0)
  char *names[] = {"f0", "f1", "f2", "f3"};
    3df0:	00004797          	auipc	a5,0x4
    3df4:	9e878793          	addi	a5,a5,-1560 # 77d8 <malloc+0x1e8e>
    3df8:	f6f43823          	sd	a5,-144(s0)
    3dfc:	00004797          	auipc	a5,0x4
    3e00:	9e478793          	addi	a5,a5,-1564 # 77e0 <malloc+0x1e96>
    3e04:	f6f43c23          	sd	a5,-136(s0)
    3e08:	00004797          	auipc	a5,0x4
    3e0c:	9e078793          	addi	a5,a5,-1568 # 77e8 <malloc+0x1e9e>
    3e10:	f8f43023          	sd	a5,-128(s0)
    3e14:	00004797          	auipc	a5,0x4
    3e18:	9dc78793          	addi	a5,a5,-1572 # 77f0 <malloc+0x1ea6>
    3e1c:	f8f43423          	sd	a5,-120(s0)
  for (pi = 0; pi < NCHILD; pi++) {
    3e20:	f7040c13          	addi	s8,s0,-144
  char *names[] = {"f0", "f1", "f2", "f3"};
    3e24:	8962                	mv	s2,s8
  for (pi = 0; pi < NCHILD; pi++) {
    3e26:	4481                	li	s1,0
    3e28:	4a11                	li	s4,4
    fname = names[pi];
    3e2a:	00093983          	ld	s3,0(s2)
    unlink(fname);
    3e2e:	854e                	mv	a0,s3
    3e30:	692010ef          	jal	ra,54c2 <unlink>
    pid = fork();
    3e34:	636010ef          	jal	ra,546a <fork>
    if (pid < 0) {
    3e38:	04054263          	bltz	a0,3e7c <fourfiles+0xae>
    if (pid == 0) {
    3e3c:	c939                	beqz	a0,3e92 <fourfiles+0xc4>
  for (pi = 0; pi < NCHILD; pi++) {
    3e3e:	2485                	addiw	s1,s1,1
    3e40:	0921                	addi	s2,s2,8
    3e42:	ff4494e3          	bne	s1,s4,3e2a <fourfiles+0x5c>
    3e46:	4491                	li	s1,4
    wait(&xstatus);
    3e48:	f6c40513          	addi	a0,s0,-148
    3e4c:	62e010ef          	jal	ra,547a <wait>
    if (xstatus != 0)
    3e50:	f6c42b03          	lw	s6,-148(s0)
    3e54:	0a0b1a63          	bnez	s6,3f08 <fourfiles+0x13a>
  for (pi = 0; pi < NCHILD; pi++) {
    3e58:	34fd                	addiw	s1,s1,-1
    3e5a:	f4fd                	bnez	s1,3e48 <fourfiles+0x7a>
    3e5c:	03000b93          	li	s7,48
    while ((n = read(fd, buf, sizeof(buf))) > 0) {
    3e60:	00009a17          	auipc	s4,0x9
    3e64:	e98a0a13          	addi	s4,s4,-360 # ccf8 <buf>
    3e68:	00009a97          	auipc	s5,0x9
    3e6c:	e91a8a93          	addi	s5,s5,-367 # ccf9 <buf+0x1>
    if (total != N * SZ) {
    3e70:	6d85                	lui	s11,0x1
    3e72:	770d8d93          	addi	s11,s11,1904 # 1770 <createdelete+0xe2>
  for (i = 0; i < NCHILD; i++) {
    3e76:	03400d13          	li	s10,52
    3e7a:	a8dd                	j	3f70 <fourfiles+0x1a2>
      printf("%s: fork failed\n", s);
    3e7c:	f5843583          	ld	a1,-168(s0)
    3e80:	00002517          	auipc	a0,0x2
    3e84:	47850513          	addi	a0,a0,1144 # 62f8 <malloc+0x9ae>
    3e88:	20f010ef          	jal	ra,5896 <printf>
      exit(1);
    3e8c:	4505                	li	a0,1
    3e8e:	5e4010ef          	jal	ra,5472 <exit>
      fd = open(fname, O_CREATE | O_RDWR);
    3e92:	20200593          	li	a1,514
    3e96:	854e                	mv	a0,s3
    3e98:	61a010ef          	jal	ra,54b2 <open>
    3e9c:	892a                	mv	s2,a0
      if (fd < 0) {
    3e9e:	04054163          	bltz	a0,3ee0 <fourfiles+0x112>
      memset(buf, '0' + pi, SZ);
    3ea2:	1f400613          	li	a2,500
    3ea6:	0304859b          	addiw	a1,s1,48
    3eaa:	00009517          	auipc	a0,0x9
    3eae:	e4e50513          	addi	a0,a0,-434 # ccf8 <buf>
    3eb2:	3ae010ef          	jal	ra,5260 <memset>
    3eb6:	44b1                	li	s1,12
        if ((n = write(fd, buf, SZ)) != SZ) {
    3eb8:	00009997          	auipc	s3,0x9
    3ebc:	e4098993          	addi	s3,s3,-448 # ccf8 <buf>
    3ec0:	1f400613          	li	a2,500
    3ec4:	85ce                	mv	a1,s3
    3ec6:	854a                	mv	a0,s2
    3ec8:	5ca010ef          	jal	ra,5492 <write>
    3ecc:	85aa                	mv	a1,a0
    3ece:	1f400793          	li	a5,500
    3ed2:	02f51263          	bne	a0,a5,3ef6 <fourfiles+0x128>
      for (i = 0; i < N; i++) {
    3ed6:	34fd                	addiw	s1,s1,-1
    3ed8:	f4e5                	bnez	s1,3ec0 <fourfiles+0xf2>
      exit(0);
    3eda:	4501                	li	a0,0
    3edc:	596010ef          	jal	ra,5472 <exit>
        printf("%s: create failed\n", s);
    3ee0:	f5843583          	ld	a1,-168(s0)
    3ee4:	00002517          	auipc	a0,0x2
    3ee8:	58450513          	addi	a0,a0,1412 # 6468 <malloc+0xb1e>
    3eec:	1ab010ef          	jal	ra,5896 <printf>
        exit(1);
    3ef0:	4505                	li	a0,1
    3ef2:	580010ef          	jal	ra,5472 <exit>
          printf("write failed %d\n", n);
    3ef6:	00004517          	auipc	a0,0x4
    3efa:	90250513          	addi	a0,a0,-1790 # 77f8 <malloc+0x1eae>
    3efe:	199010ef          	jal	ra,5896 <printf>
          exit(1);
    3f02:	4505                	li	a0,1
    3f04:	56e010ef          	jal	ra,5472 <exit>
      exit(xstatus);
    3f08:	855a                	mv	a0,s6
    3f0a:	568010ef          	jal	ra,5472 <exit>
          printf("%s: wrong char\n", s);
    3f0e:	f5843583          	ld	a1,-168(s0)
    3f12:	00004517          	auipc	a0,0x4
    3f16:	8fe50513          	addi	a0,a0,-1794 # 7810 <malloc+0x1ec6>
    3f1a:	17d010ef          	jal	ra,5896 <printf>
          exit(1);
    3f1e:	4505                	li	a0,1
    3f20:	552010ef          	jal	ra,5472 <exit>
      total += n;
    3f24:	00a9093b          	addw	s2,s2,a0
    while ((n = read(fd, buf, sizeof(buf))) > 0) {
    3f28:	660d                	lui	a2,0x3
    3f2a:	85d2                	mv	a1,s4
    3f2c:	854e                	mv	a0,s3
    3f2e:	55c010ef          	jal	ra,548a <read>
    3f32:	02a05363          	blez	a0,3f58 <fourfiles+0x18a>
    3f36:	00009797          	auipc	a5,0x9
    3f3a:	dc278793          	addi	a5,a5,-574 # ccf8 <buf>
    3f3e:	fff5069b          	addiw	a3,a0,-1
    3f42:	1682                	slli	a3,a3,0x20
    3f44:	9281                	srli	a3,a3,0x20
    3f46:	96d6                	add	a3,a3,s5
        if (buf[j] != '0' + i) {
    3f48:	0007c703          	lbu	a4,0(a5)
    3f4c:	fc9711e3          	bne	a4,s1,3f0e <fourfiles+0x140>
      for (j = 0; j < n; j++) {
    3f50:	0785                	addi	a5,a5,1
    3f52:	fed79be3          	bne	a5,a3,3f48 <fourfiles+0x17a>
    3f56:	b7f9                	j	3f24 <fourfiles+0x156>
    close(fd);
    3f58:	854e                	mv	a0,s3
    3f5a:	540010ef          	jal	ra,549a <close>
    if (total != N * SZ) {
    3f5e:	03b91463          	bne	s2,s11,3f86 <fourfiles+0x1b8>
    unlink(fname);
    3f62:	8566                	mv	a0,s9
    3f64:	55e010ef          	jal	ra,54c2 <unlink>
  for (i = 0; i < NCHILD; i++) {
    3f68:	0c21                	addi	s8,s8,8
    3f6a:	2b85                	addiw	s7,s7,1
    3f6c:	03ab8763          	beq	s7,s10,3f9a <fourfiles+0x1cc>
    fname = names[i];
    3f70:	000c3c83          	ld	s9,0(s8)
    fd = open(fname, 0);
    3f74:	4581                	li	a1,0
    3f76:	8566                	mv	a0,s9
    3f78:	53a010ef          	jal	ra,54b2 <open>
    3f7c:	89aa                	mv	s3,a0
    total = 0;
    3f7e:	895a                	mv	s2,s6
        if (buf[j] != '0' + i) {
    3f80:	000b849b          	sext.w	s1,s7
    while ((n = read(fd, buf, sizeof(buf))) > 0) {
    3f84:	b755                	j	3f28 <fourfiles+0x15a>
      printf("wrong length %d\n", total);
    3f86:	85ca                	mv	a1,s2
    3f88:	00004517          	auipc	a0,0x4
    3f8c:	89850513          	addi	a0,a0,-1896 # 7820 <malloc+0x1ed6>
    3f90:	107010ef          	jal	ra,5896 <printf>
      exit(1);
    3f94:	4505                	li	a0,1
    3f96:	4dc010ef          	jal	ra,5472 <exit>
}
    3f9a:	70aa                	ld	ra,168(sp)
    3f9c:	740a                	ld	s0,160(sp)
    3f9e:	64ea                	ld	s1,152(sp)
    3fa0:	694a                	ld	s2,144(sp)
    3fa2:	69aa                	ld	s3,136(sp)
    3fa4:	6a0a                	ld	s4,128(sp)
    3fa6:	7ae6                	ld	s5,120(sp)
    3fa8:	7b46                	ld	s6,112(sp)
    3faa:	7ba6                	ld	s7,104(sp)
    3fac:	7c06                	ld	s8,96(sp)
    3fae:	6ce6                	ld	s9,88(sp)
    3fb0:	6d46                	ld	s10,80(sp)
    3fb2:	6da6                	ld	s11,72(sp)
    3fb4:	614d                	addi	sp,sp,176
    3fb6:	8082                	ret

0000000000003fb8 <concreate>:
{
    3fb8:	7135                	addi	sp,sp,-160
    3fba:	ed06                	sd	ra,152(sp)
    3fbc:	e922                	sd	s0,144(sp)
    3fbe:	e526                	sd	s1,136(sp)
    3fc0:	e14a                	sd	s2,128(sp)
    3fc2:	fcce                	sd	s3,120(sp)
    3fc4:	f8d2                	sd	s4,112(sp)
    3fc6:	f4d6                	sd	s5,104(sp)
    3fc8:	f0da                	sd	s6,96(sp)
    3fca:	ecde                	sd	s7,88(sp)
    3fcc:	1100                	addi	s0,sp,160
    3fce:	89aa                	mv	s3,a0
  file[0] = 'C';
    3fd0:	04300793          	li	a5,67
    3fd4:	faf40423          	sb	a5,-88(s0)
  file[2] = '\0';
    3fd8:	fa040523          	sb	zero,-86(s0)
  for (i = 0; i < N; i++) {
    3fdc:	4901                	li	s2,0
    if (pid && (i % 3) == 1) {
    3fde:	4b0d                	li	s6,3
    3fe0:	4a85                	li	s5,1
      link("C0", file);
    3fe2:	00004b97          	auipc	s7,0x4
    3fe6:	856b8b93          	addi	s7,s7,-1962 # 7838 <malloc+0x1eee>
  for (i = 0; i < N; i++) {
    3fea:	02800a13          	li	s4,40
    3fee:	a41d                	j	4214 <concreate+0x25c>
      link("C0", file);
    3ff0:	fa840593          	addi	a1,s0,-88
    3ff4:	855e                	mv	a0,s7
    3ff6:	4dc010ef          	jal	ra,54d2 <link>
    if (pid == 0) {
    3ffa:	a411                	j	41fe <concreate+0x246>
    } else if (pid == 0 && (i % 5) == 1) {
    3ffc:	4795                	li	a5,5
    3ffe:	02f9693b          	remw	s2,s2,a5
    4002:	4785                	li	a5,1
    4004:	02f90563          	beq	s2,a5,402e <concreate+0x76>
      fd = open(file, O_CREATE | O_RDWR);
    4008:	20200593          	li	a1,514
    400c:	fa840513          	addi	a0,s0,-88
    4010:	4a2010ef          	jal	ra,54b2 <open>
      if (fd < 0) {
    4014:	1e055063          	bgez	a0,41f4 <concreate+0x23c>
        printf("concreate create %s failed\n", file);
    4018:	fa840593          	addi	a1,s0,-88
    401c:	00004517          	auipc	a0,0x4
    4020:	82450513          	addi	a0,a0,-2012 # 7840 <malloc+0x1ef6>
    4024:	073010ef          	jal	ra,5896 <printf>
        exit(1);
    4028:	4505                	li	a0,1
    402a:	448010ef          	jal	ra,5472 <exit>
      link("C0", file);
    402e:	fa840593          	addi	a1,s0,-88
    4032:	00004517          	auipc	a0,0x4
    4036:	80650513          	addi	a0,a0,-2042 # 7838 <malloc+0x1eee>
    403a:	498010ef          	jal	ra,54d2 <link>
      exit(0);
    403e:	4501                	li	a0,0
    4040:	432010ef          	jal	ra,5472 <exit>
        exit(1);
    4044:	4505                	li	a0,1
    4046:	42c010ef          	jal	ra,5472 <exit>
  memset(fa, 0, sizeof(fa));
    404a:	02800613          	li	a2,40
    404e:	4581                	li	a1,0
    4050:	f8040513          	addi	a0,s0,-128
    4054:	20c010ef          	jal	ra,5260 <memset>
  fd = open(".", 0);
    4058:	4581                	li	a1,0
    405a:	00002517          	auipc	a0,0x2
    405e:	0f650513          	addi	a0,a0,246 # 6150 <malloc+0x806>
    4062:	450010ef          	jal	ra,54b2 <open>
    4066:	892a                	mv	s2,a0
  n = 0;
    4068:	8aa6                	mv	s5,s1
    if (de.name[0] == 'C' && de.name[2] == '\0') {
    406a:	04300a13          	li	s4,67
      if (i < 0 || i >= sizeof(fa)) {
    406e:	02700b13          	li	s6,39
      fa[i] = 1;
    4072:	4b85                	li	s7,1
  while (read(fd, &de, sizeof(de)) > 0) {
    4074:	4641                	li	a2,16
    4076:	f7040593          	addi	a1,s0,-144
    407a:	854a                	mv	a0,s2
    407c:	40e010ef          	jal	ra,548a <read>
    4080:	06a05a63          	blez	a0,40f4 <concreate+0x13c>
    if (de.inum == 0)
    4084:	f7045783          	lhu	a5,-144(s0)
    4088:	d7f5                	beqz	a5,4074 <concreate+0xbc>
    if (de.name[0] == 'C' && de.name[2] == '\0') {
    408a:	f7244783          	lbu	a5,-142(s0)
    408e:	ff4793e3          	bne	a5,s4,4074 <concreate+0xbc>
    4092:	f7444783          	lbu	a5,-140(s0)
    4096:	fff9                	bnez	a5,4074 <concreate+0xbc>
      i = de.name[1] - '0';
    4098:	f7344783          	lbu	a5,-141(s0)
    409c:	fd07879b          	addiw	a5,a5,-48
    40a0:	0007871b          	sext.w	a4,a5
      if (i < 0 || i >= sizeof(fa)) {
    40a4:	02eb6063          	bltu	s6,a4,40c4 <concreate+0x10c>
      if (fa[i]) {
    40a8:	fb070793          	addi	a5,a4,-80
    40ac:	97a2                	add	a5,a5,s0
    40ae:	fd07c783          	lbu	a5,-48(a5)
    40b2:	e78d                	bnez	a5,40dc <concreate+0x124>
      fa[i] = 1;
    40b4:	fb070793          	addi	a5,a4,-80
    40b8:	00878733          	add	a4,a5,s0
    40bc:	fd770823          	sb	s7,-48(a4)
      n++;
    40c0:	2a85                	addiw	s5,s5,1
    40c2:	bf4d                	j	4074 <concreate+0xbc>
        printf("%s: concreate weird file %s\n", s, de.name);
    40c4:	f7240613          	addi	a2,s0,-142
    40c8:	85ce                	mv	a1,s3
    40ca:	00003517          	auipc	a0,0x3
    40ce:	79650513          	addi	a0,a0,1942 # 7860 <malloc+0x1f16>
    40d2:	7c4010ef          	jal	ra,5896 <printf>
        exit(1);
    40d6:	4505                	li	a0,1
    40d8:	39a010ef          	jal	ra,5472 <exit>
        printf("%s: concreate duplicate file %s\n", s, de.name);
    40dc:	f7240613          	addi	a2,s0,-142
    40e0:	85ce                	mv	a1,s3
    40e2:	00003517          	auipc	a0,0x3
    40e6:	79e50513          	addi	a0,a0,1950 # 7880 <malloc+0x1f36>
    40ea:	7ac010ef          	jal	ra,5896 <printf>
        exit(1);
    40ee:	4505                	li	a0,1
    40f0:	382010ef          	jal	ra,5472 <exit>
  close(fd);
    40f4:	854a                	mv	a0,s2
    40f6:	3a4010ef          	jal	ra,549a <close>
  if (n != N) {
    40fa:	02800793          	li	a5,40
    40fe:	00fa9763          	bne	s5,a5,410c <concreate+0x154>
    if (((i % 3) == 0 && pid == 0) || ((i % 3) == 1 && pid != 0)) {
    4102:	4a8d                	li	s5,3
    4104:	4b05                	li	s6,1
  for (i = 0; i < N; i++) {
    4106:	02800a13          	li	s4,40
    410a:	a079                	j	4198 <concreate+0x1e0>
    printf("%s: concreate not enough files in directory listing\n", s);
    410c:	85ce                	mv	a1,s3
    410e:	00003517          	auipc	a0,0x3
    4112:	79a50513          	addi	a0,a0,1946 # 78a8 <malloc+0x1f5e>
    4116:	780010ef          	jal	ra,5896 <printf>
    exit(1);
    411a:	4505                	li	a0,1
    411c:	356010ef          	jal	ra,5472 <exit>
      printf("%s: fork failed\n", s);
    4120:	85ce                	mv	a1,s3
    4122:	00002517          	auipc	a0,0x2
    4126:	1d650513          	addi	a0,a0,470 # 62f8 <malloc+0x9ae>
    412a:	76c010ef          	jal	ra,5896 <printf>
      exit(1);
    412e:	4505                	li	a0,1
    4130:	342010ef          	jal	ra,5472 <exit>
      close(open(file, 0));
    4134:	4581                	li	a1,0
    4136:	fa840513          	addi	a0,s0,-88
    413a:	378010ef          	jal	ra,54b2 <open>
    413e:	35c010ef          	jal	ra,549a <close>
      close(open(file, 0));
    4142:	4581                	li	a1,0
    4144:	fa840513          	addi	a0,s0,-88
    4148:	36a010ef          	jal	ra,54b2 <open>
    414c:	34e010ef          	jal	ra,549a <close>
      close(open(file, 0));
    4150:	4581                	li	a1,0
    4152:	fa840513          	addi	a0,s0,-88
    4156:	35c010ef          	jal	ra,54b2 <open>
    415a:	340010ef          	jal	ra,549a <close>
      close(open(file, 0));
    415e:	4581                	li	a1,0
    4160:	fa840513          	addi	a0,s0,-88
    4164:	34e010ef          	jal	ra,54b2 <open>
    4168:	332010ef          	jal	ra,549a <close>
      close(open(file, 0));
    416c:	4581                	li	a1,0
    416e:	fa840513          	addi	a0,s0,-88
    4172:	340010ef          	jal	ra,54b2 <open>
    4176:	324010ef          	jal	ra,549a <close>
      close(open(file, 0));
    417a:	4581                	li	a1,0
    417c:	fa840513          	addi	a0,s0,-88
    4180:	332010ef          	jal	ra,54b2 <open>
    4184:	316010ef          	jal	ra,549a <close>
    if (pid == 0)
    4188:	06090363          	beqz	s2,41ee <concreate+0x236>
      wait(0);
    418c:	4501                	li	a0,0
    418e:	2ec010ef          	jal	ra,547a <wait>
  for (i = 0; i < N; i++) {
    4192:	2485                	addiw	s1,s1,1
    4194:	0b448963          	beq	s1,s4,4246 <concreate+0x28e>
    file[1] = '0' + i;
    4198:	0304879b          	addiw	a5,s1,48
    419c:	faf404a3          	sb	a5,-87(s0)
    pid = fork();
    41a0:	2ca010ef          	jal	ra,546a <fork>
    41a4:	892a                	mv	s2,a0
    if (pid < 0) {
    41a6:	f6054de3          	bltz	a0,4120 <concreate+0x168>
    if (((i % 3) == 0 && pid == 0) || ((i % 3) == 1 && pid != 0)) {
    41aa:	0354e73b          	remw	a4,s1,s5
    41ae:	00a767b3          	or	a5,a4,a0
    41b2:	2781                	sext.w	a5,a5
    41b4:	d3c1                	beqz	a5,4134 <concreate+0x17c>
    41b6:	01671363          	bne	a4,s6,41bc <concreate+0x204>
    41ba:	fd2d                	bnez	a0,4134 <concreate+0x17c>
      unlink(file);
    41bc:	fa840513          	addi	a0,s0,-88
    41c0:	302010ef          	jal	ra,54c2 <unlink>
      unlink(file);
    41c4:	fa840513          	addi	a0,s0,-88
    41c8:	2fa010ef          	jal	ra,54c2 <unlink>
      unlink(file);
    41cc:	fa840513          	addi	a0,s0,-88
    41d0:	2f2010ef          	jal	ra,54c2 <unlink>
      unlink(file);
    41d4:	fa840513          	addi	a0,s0,-88
    41d8:	2ea010ef          	jal	ra,54c2 <unlink>
      unlink(file);
    41dc:	fa840513          	addi	a0,s0,-88
    41e0:	2e2010ef          	jal	ra,54c2 <unlink>
      unlink(file);
    41e4:	fa840513          	addi	a0,s0,-88
    41e8:	2da010ef          	jal	ra,54c2 <unlink>
    41ec:	bf71                	j	4188 <concreate+0x1d0>
      exit(0);
    41ee:	4501                	li	a0,0
    41f0:	282010ef          	jal	ra,5472 <exit>
      close(fd);
    41f4:	2a6010ef          	jal	ra,549a <close>
    if (pid == 0) {
    41f8:	b599                	j	403e <concreate+0x86>
      close(fd);
    41fa:	2a0010ef          	jal	ra,549a <close>
      wait(&xstatus);
    41fe:	f6c40513          	addi	a0,s0,-148
    4202:	278010ef          	jal	ra,547a <wait>
      if (xstatus != 0)
    4206:	f6c42483          	lw	s1,-148(s0)
    420a:	e2049de3          	bnez	s1,4044 <concreate+0x8c>
  for (i = 0; i < N; i++) {
    420e:	2905                	addiw	s2,s2,1
    4210:	e3490de3          	beq	s2,s4,404a <concreate+0x92>
    file[1] = '0' + i;
    4214:	0309079b          	addiw	a5,s2,48
    4218:	faf404a3          	sb	a5,-87(s0)
    unlink(file);
    421c:	fa840513          	addi	a0,s0,-88
    4220:	2a2010ef          	jal	ra,54c2 <unlink>
    pid = fork();
    4224:	246010ef          	jal	ra,546a <fork>
    if (pid && (i % 3) == 1) {
    4228:	dc050ae3          	beqz	a0,3ffc <concreate+0x44>
    422c:	036967bb          	remw	a5,s2,s6
    4230:	dd5780e3          	beq	a5,s5,3ff0 <concreate+0x38>
      fd = open(file, O_CREATE | O_RDWR);
    4234:	20200593          	li	a1,514
    4238:	fa840513          	addi	a0,s0,-88
    423c:	276010ef          	jal	ra,54b2 <open>
      if (fd < 0) {
    4240:	fa055de3          	bgez	a0,41fa <concreate+0x242>
    4244:	bbd1                	j	4018 <concreate+0x60>
}
    4246:	60ea                	ld	ra,152(sp)
    4248:	644a                	ld	s0,144(sp)
    424a:	64aa                	ld	s1,136(sp)
    424c:	690a                	ld	s2,128(sp)
    424e:	79e6                	ld	s3,120(sp)
    4250:	7a46                	ld	s4,112(sp)
    4252:	7aa6                	ld	s5,104(sp)
    4254:	7b06                	ld	s6,96(sp)
    4256:	6be6                	ld	s7,88(sp)
    4258:	610d                	addi	sp,sp,160
    425a:	8082                	ret

000000000000425c <bigfile>:
{
    425c:	7139                	addi	sp,sp,-64
    425e:	fc06                	sd	ra,56(sp)
    4260:	f822                	sd	s0,48(sp)
    4262:	f426                	sd	s1,40(sp)
    4264:	f04a                	sd	s2,32(sp)
    4266:	ec4e                	sd	s3,24(sp)
    4268:	e852                	sd	s4,16(sp)
    426a:	e456                	sd	s5,8(sp)
    426c:	0080                	addi	s0,sp,64
    426e:	8aaa                	mv	s5,a0
  unlink("bigfile.dat");
    4270:	00003517          	auipc	a0,0x3
    4274:	67050513          	addi	a0,a0,1648 # 78e0 <malloc+0x1f96>
    4278:	24a010ef          	jal	ra,54c2 <unlink>
  fd = open("bigfile.dat", O_CREATE | O_RDWR);
    427c:	20200593          	li	a1,514
    4280:	00003517          	auipc	a0,0x3
    4284:	66050513          	addi	a0,a0,1632 # 78e0 <malloc+0x1f96>
    4288:	22a010ef          	jal	ra,54b2 <open>
    428c:	89aa                	mv	s3,a0
  for (i = 0; i < N; i++) {
    428e:	4481                	li	s1,0
    memset(buf, i, SZ);
    4290:	00009917          	auipc	s2,0x9
    4294:	a6890913          	addi	s2,s2,-1432 # ccf8 <buf>
  for (i = 0; i < N; i++) {
    4298:	4a51                	li	s4,20
  if (fd < 0) {
    429a:	08054663          	bltz	a0,4326 <bigfile+0xca>
    memset(buf, i, SZ);
    429e:	25800613          	li	a2,600
    42a2:	85a6                	mv	a1,s1
    42a4:	854a                	mv	a0,s2
    42a6:	7bb000ef          	jal	ra,5260 <memset>
    if (write(fd, buf, SZ) != SZ) {
    42aa:	25800613          	li	a2,600
    42ae:	85ca                	mv	a1,s2
    42b0:	854e                	mv	a0,s3
    42b2:	1e0010ef          	jal	ra,5492 <write>
    42b6:	25800793          	li	a5,600
    42ba:	08f51063          	bne	a0,a5,433a <bigfile+0xde>
  for (i = 0; i < N; i++) {
    42be:	2485                	addiw	s1,s1,1
    42c0:	fd449fe3          	bne	s1,s4,429e <bigfile+0x42>
  close(fd);
    42c4:	854e                	mv	a0,s3
    42c6:	1d4010ef          	jal	ra,549a <close>
  fd = open("bigfile.dat", 0);
    42ca:	4581                	li	a1,0
    42cc:	00003517          	auipc	a0,0x3
    42d0:	61450513          	addi	a0,a0,1556 # 78e0 <malloc+0x1f96>
    42d4:	1de010ef          	jal	ra,54b2 <open>
    42d8:	8a2a                	mv	s4,a0
  total = 0;
    42da:	4981                	li	s3,0
  for (i = 0;; i++) {
    42dc:	4481                	li	s1,0
    cc = read(fd, buf, SZ / 2);
    42de:	00009917          	auipc	s2,0x9
    42e2:	a1a90913          	addi	s2,s2,-1510 # ccf8 <buf>
  if (fd < 0) {
    42e6:	06054463          	bltz	a0,434e <bigfile+0xf2>
    cc = read(fd, buf, SZ / 2);
    42ea:	12c00613          	li	a2,300
    42ee:	85ca                	mv	a1,s2
    42f0:	8552                	mv	a0,s4
    42f2:	198010ef          	jal	ra,548a <read>
    if (cc < 0) {
    42f6:	06054663          	bltz	a0,4362 <bigfile+0x106>
    if (cc == 0)
    42fa:	c155                	beqz	a0,439e <bigfile+0x142>
    if (cc != SZ / 2) {
    42fc:	12c00793          	li	a5,300
    4300:	06f51b63          	bne	a0,a5,4376 <bigfile+0x11a>
    if (buf[0] != i / 2 || buf[SZ / 2 - 1] != i / 2) {
    4304:	01f4d79b          	srliw	a5,s1,0x1f
    4308:	9fa5                	addw	a5,a5,s1
    430a:	4017d79b          	sraiw	a5,a5,0x1
    430e:	00094703          	lbu	a4,0(s2)
    4312:	06f71c63          	bne	a4,a5,438a <bigfile+0x12e>
    4316:	12b94703          	lbu	a4,299(s2)
    431a:	06f71863          	bne	a4,a5,438a <bigfile+0x12e>
    total += cc;
    431e:	12c9899b          	addiw	s3,s3,300
  for (i = 0;; i++) {
    4322:	2485                	addiw	s1,s1,1
    cc = read(fd, buf, SZ / 2);
    4324:	b7d9                	j	42ea <bigfile+0x8e>
    printf("%s: cannot create bigfile", s);
    4326:	85d6                	mv	a1,s5
    4328:	00003517          	auipc	a0,0x3
    432c:	5c850513          	addi	a0,a0,1480 # 78f0 <malloc+0x1fa6>
    4330:	566010ef          	jal	ra,5896 <printf>
    exit(1);
    4334:	4505                	li	a0,1
    4336:	13c010ef          	jal	ra,5472 <exit>
      printf("%s: write bigfile failed\n", s);
    433a:	85d6                	mv	a1,s5
    433c:	00003517          	auipc	a0,0x3
    4340:	5d450513          	addi	a0,a0,1492 # 7910 <malloc+0x1fc6>
    4344:	552010ef          	jal	ra,5896 <printf>
      exit(1);
    4348:	4505                	li	a0,1
    434a:	128010ef          	jal	ra,5472 <exit>
    printf("%s: cannot open bigfile\n", s);
    434e:	85d6                	mv	a1,s5
    4350:	00003517          	auipc	a0,0x3
    4354:	5e050513          	addi	a0,a0,1504 # 7930 <malloc+0x1fe6>
    4358:	53e010ef          	jal	ra,5896 <printf>
    exit(1);
    435c:	4505                	li	a0,1
    435e:	114010ef          	jal	ra,5472 <exit>
      printf("%s: read bigfile failed\n", s);
    4362:	85d6                	mv	a1,s5
    4364:	00003517          	auipc	a0,0x3
    4368:	5ec50513          	addi	a0,a0,1516 # 7950 <malloc+0x2006>
    436c:	52a010ef          	jal	ra,5896 <printf>
      exit(1);
    4370:	4505                	li	a0,1
    4372:	100010ef          	jal	ra,5472 <exit>
      printf("%s: short read bigfile\n", s);
    4376:	85d6                	mv	a1,s5
    4378:	00003517          	auipc	a0,0x3
    437c:	5f850513          	addi	a0,a0,1528 # 7970 <malloc+0x2026>
    4380:	516010ef          	jal	ra,5896 <printf>
      exit(1);
    4384:	4505                	li	a0,1
    4386:	0ec010ef          	jal	ra,5472 <exit>
      printf("%s: read bigfile wrong data\n", s);
    438a:	85d6                	mv	a1,s5
    438c:	00003517          	auipc	a0,0x3
    4390:	5fc50513          	addi	a0,a0,1532 # 7988 <malloc+0x203e>
    4394:	502010ef          	jal	ra,5896 <printf>
      exit(1);
    4398:	4505                	li	a0,1
    439a:	0d8010ef          	jal	ra,5472 <exit>
  close(fd);
    439e:	8552                	mv	a0,s4
    43a0:	0fa010ef          	jal	ra,549a <close>
  if (total != N * SZ) {
    43a4:	678d                	lui	a5,0x3
    43a6:	ee078793          	addi	a5,a5,-288 # 2ee0 <subdir+0x4e6>
    43aa:	02f99163          	bne	s3,a5,43cc <bigfile+0x170>
  unlink("bigfile.dat");
    43ae:	00003517          	auipc	a0,0x3
    43b2:	53250513          	addi	a0,a0,1330 # 78e0 <malloc+0x1f96>
    43b6:	10c010ef          	jal	ra,54c2 <unlink>
}
    43ba:	70e2                	ld	ra,56(sp)
    43bc:	7442                	ld	s0,48(sp)
    43be:	74a2                	ld	s1,40(sp)
    43c0:	7902                	ld	s2,32(sp)
    43c2:	69e2                	ld	s3,24(sp)
    43c4:	6a42                	ld	s4,16(sp)
    43c6:	6aa2                	ld	s5,8(sp)
    43c8:	6121                	addi	sp,sp,64
    43ca:	8082                	ret
    printf("%s: read bigfile wrong total\n", s);
    43cc:	85d6                	mv	a1,s5
    43ce:	00003517          	auipc	a0,0x3
    43d2:	5da50513          	addi	a0,a0,1498 # 79a8 <malloc+0x205e>
    43d6:	4c0010ef          	jal	ra,5896 <printf>
    exit(1);
    43da:	4505                	li	a0,1
    43dc:	096010ef          	jal	ra,5472 <exit>

00000000000043e0 <bigargtest>:
{
    43e0:	7121                	addi	sp,sp,-448
    43e2:	ff06                	sd	ra,440(sp)
    43e4:	fb22                	sd	s0,432(sp)
    43e6:	f726                	sd	s1,424(sp)
    43e8:	0380                	addi	s0,sp,448
    43ea:	84aa                	mv	s1,a0
  unlink("bigarg-ok");
    43ec:	00003517          	auipc	a0,0x3
    43f0:	5dc50513          	addi	a0,a0,1500 # 79c8 <malloc+0x207e>
    43f4:	0ce010ef          	jal	ra,54c2 <unlink>
  pid = fork();
    43f8:	072010ef          	jal	ra,546a <fork>
  if (pid == 0) {
    43fc:	c915                	beqz	a0,4430 <bigargtest+0x50>
  } else if (pid < 0) {
    43fe:	08054a63          	bltz	a0,4492 <bigargtest+0xb2>
  wait(&xstatus);
    4402:	fdc40513          	addi	a0,s0,-36
    4406:	074010ef          	jal	ra,547a <wait>
  if (xstatus != 0)
    440a:	fdc42503          	lw	a0,-36(s0)
    440e:	ed41                	bnez	a0,44a6 <bigargtest+0xc6>
  fd = open("bigarg-ok", 0);
    4410:	4581                	li	a1,0
    4412:	00003517          	auipc	a0,0x3
    4416:	5b650513          	addi	a0,a0,1462 # 79c8 <malloc+0x207e>
    441a:	098010ef          	jal	ra,54b2 <open>
  if (fd < 0) {
    441e:	08054663          	bltz	a0,44aa <bigargtest+0xca>
  close(fd);
    4422:	078010ef          	jal	ra,549a <close>
}
    4426:	70fa                	ld	ra,440(sp)
    4428:	745a                	ld	s0,432(sp)
    442a:	74ba                	ld	s1,424(sp)
    442c:	6139                	addi	sp,sp,448
    442e:	8082                	ret
    memset(big, ' ', sizeof(big));
    4430:	19000613          	li	a2,400
    4434:	02000593          	li	a1,32
    4438:	e4840513          	addi	a0,s0,-440
    443c:	625000ef          	jal	ra,5260 <memset>
    big[sizeof(big) - 1] = '\0';
    4440:	fc040ba3          	sb	zero,-41(s0)
    for (i = 0; i < MAXARG - 1; i++)
    4444:	00005797          	auipc	a5,0x5
    4448:	09c78793          	addi	a5,a5,156 # 94e0 <args.1>
    444c:	00005697          	auipc	a3,0x5
    4450:	18c68693          	addi	a3,a3,396 # 95d8 <args.1+0xf8>
      args[i] = big;
    4454:	e4840713          	addi	a4,s0,-440
    4458:	e398                	sd	a4,0(a5)
    for (i = 0; i < MAXARG - 1; i++)
    445a:	07a1                	addi	a5,a5,8
    445c:	fed79ee3          	bne	a5,a3,4458 <bigargtest+0x78>
    args[MAXARG - 1] = 0;
    4460:	00005597          	auipc	a1,0x5
    4464:	08058593          	addi	a1,a1,128 # 94e0 <args.1>
    4468:	0e05bc23          	sd	zero,248(a1)
    exec("echo", args);
    446c:	00001517          	auipc	a0,0x1
    4470:	5fc50513          	addi	a0,a0,1532 # 5a68 <malloc+0x11e>
    4474:	036010ef          	jal	ra,54aa <exec>
    fd = open("bigarg-ok", O_CREATE);
    4478:	20000593          	li	a1,512
    447c:	00003517          	auipc	a0,0x3
    4480:	54c50513          	addi	a0,a0,1356 # 79c8 <malloc+0x207e>
    4484:	02e010ef          	jal	ra,54b2 <open>
    close(fd);
    4488:	012010ef          	jal	ra,549a <close>
    exit(0);
    448c:	4501                	li	a0,0
    448e:	7e5000ef          	jal	ra,5472 <exit>
    printf("%s: bigargtest: fork failed\n", s);
    4492:	85a6                	mv	a1,s1
    4494:	00003517          	auipc	a0,0x3
    4498:	54450513          	addi	a0,a0,1348 # 79d8 <malloc+0x208e>
    449c:	3fa010ef          	jal	ra,5896 <printf>
    exit(1);
    44a0:	4505                	li	a0,1
    44a2:	7d1000ef          	jal	ra,5472 <exit>
    exit(xstatus);
    44a6:	7cd000ef          	jal	ra,5472 <exit>
    printf("%s: bigarg test failed!\n", s);
    44aa:	85a6                	mv	a1,s1
    44ac:	00003517          	auipc	a0,0x3
    44b0:	54c50513          	addi	a0,a0,1356 # 79f8 <malloc+0x20ae>
    44b4:	3e2010ef          	jal	ra,5896 <printf>
    exit(1);
    44b8:	4505                	li	a0,1
    44ba:	7b9000ef          	jal	ra,5472 <exit>

00000000000044be <partial_write>:
{
    44be:	bc010113          	addi	sp,sp,-1088
    44c2:	42113c23          	sd	ra,1080(sp)
    44c6:	42813823          	sd	s0,1072(sp)
    44ca:	42913423          	sd	s1,1064(sp)
    44ce:	43213023          	sd	s2,1056(sp)
    44d2:	41313c23          	sd	s3,1048(sp)
    44d6:	44010413          	addi	s0,sp,1088
    44da:	89aa                	mv	s3,a0
  unlink("testfile");
    44dc:	00003517          	auipc	a0,0x3
    44e0:	53c50513          	addi	a0,a0,1340 # 7a18 <malloc+0x20ce>
    44e4:	7df000ef          	jal	ra,54c2 <unlink>
  int fd = open("testfile", O_CREATE | O_RDWR);
    44e8:	20200593          	li	a1,514
    44ec:	00003517          	auipc	a0,0x3
    44f0:	52c50513          	addi	a0,a0,1324 # 7a18 <malloc+0x20ce>
    44f4:	7bf000ef          	jal	ra,54b2 <open>
  if (fd < 0) {
    44f8:	14054c63          	bltz	a0,4650 <partial_write+0x192>
    44fc:	84aa                	mv	s1,a0
  int cc = write(fd, "A", 1);
    44fe:	4605                	li	a2,1
    4500:	00003597          	auipc	a1,0x3
    4504:	54858593          	addi	a1,a1,1352 # 7a48 <malloc+0x20fe>
    4508:	78b000ef          	jal	ra,5492 <write>
  if (cc != 1) {
    450c:	4785                	li	a5,1
    450e:	14f51b63          	bne	a0,a5,4664 <partial_write+0x1a6>
  close(fd);
    4512:	8526                	mv	a0,s1
    4514:	787000ef          	jal	ra,549a <close>
  fd = open("testfile", O_RDWR);
    4518:	4589                	li	a1,2
    451a:	00003517          	auipc	a0,0x3
    451e:	4fe50513          	addi	a0,a0,1278 # 7a18 <malloc+0x20ce>
    4522:	791000ef          	jal	ra,54b2 <open>
    4526:	892a                	mv	s2,a0
  if (fd < 0) {
    4528:	14054863          	bltz	a0,4678 <partial_write+0x1ba>
  char *p = sbrk(0);
    452c:	4501                	li	a0,0
    452e:	711000ef          	jal	ra,543e <sbrk>
  sbrk(PGSIZE - ((uint64)p % PGSIZE));
    4532:	6485                	lui	s1,0x1
    4534:	14fd                	addi	s1,s1,-1 # fff <pgbug+0x2b>
    4536:	009577b3          	and	a5,a0,s1
    453a:	6505                	lui	a0,0x1
    453c:	9d1d                	subw	a0,a0,a5
    453e:	701000ef          	jal	ra,543e <sbrk>
  p = sbrk(0);
    4542:	4501                	li	a0,0
    4544:	6fb000ef          	jal	ra,543e <sbrk>
  if ((uint64)p % PGSIZE != 0) {
    4548:	8ce9                	and	s1,s1,a0
    454a:	14049163          	bnez	s1,468c <partial_write+0x1ce>
  p[-1] = 'X';
    454e:	05800793          	li	a5,88
    4552:	fef50fa3          	sb	a5,-1(a0) # fff <pgbug+0x2b>
  cc = write(fd, p - 1, 2);
    4556:	4609                	li	a2,2
    4558:	fff50593          	addi	a1,a0,-1
    455c:	854a                	mv	a0,s2
    455e:	735000ef          	jal	ra,5492 <write>
  if (cc != -1) {
    4562:	57fd                	li	a5,-1
    4564:	12f51e63          	bne	a0,a5,46a0 <partial_write+0x1e2>
  close(fd);
    4568:	854a                	mv	a0,s2
    456a:	731000ef          	jal	ra,549a <close>
  fd = open("testfile", O_RDONLY);
    456e:	4581                	li	a1,0
    4570:	00003517          	auipc	a0,0x3
    4574:	4a850513          	addi	a0,a0,1192 # 7a18 <malloc+0x20ce>
    4578:	73b000ef          	jal	ra,54b2 <open>
    457c:	84aa                	mv	s1,a0
  if (fd < 0) {
    457e:	12054b63          	bltz	a0,46b4 <partial_write+0x1f6>
  cc = read(fd, &b, 1);
    4582:	4605                	li	a2,1
    4584:	fcf40593          	addi	a1,s0,-49
    4588:	703000ef          	jal	ra,548a <read>
  if (cc != 1) {
    458c:	4785                	li	a5,1
    458e:	12f51d63          	bne	a0,a5,46c8 <partial_write+0x20a>
  close(fd);
    4592:	8526                	mv	a0,s1
    4594:	707000ef          	jal	ra,549a <close>
  if (b != 'X') {
    4598:	fcf44603          	lbu	a2,-49(s0)
    459c:	05800793          	li	a5,88
    45a0:	12f61e63          	bne	a2,a5,46dc <partial_write+0x21e>
  fd = open("bigfile", O_CREATE | O_RDWR);
    45a4:	20200593          	li	a1,514
    45a8:	00003517          	auipc	a0,0x3
    45ac:	57050513          	addi	a0,a0,1392 # 7b18 <malloc+0x21ce>
    45b0:	703000ef          	jal	ra,54b2 <open>
    45b4:	892a                	mv	s2,a0
    45b6:	04000493          	li	s1,64
    memset(buf, 0, sizeof(buf));
    45ba:	40000613          	li	a2,1024
    45be:	4581                	li	a1,0
    45c0:	bc840513          	addi	a0,s0,-1080
    45c4:	49d000ef          	jal	ra,5260 <memset>
    cc = write(fd, buf, sizeof(buf));
    45c8:	40000613          	li	a2,1024
    45cc:	bc840593          	addi	a1,s0,-1080
    45d0:	854a                	mv	a0,s2
    45d2:	6c1000ef          	jal	ra,5492 <write>
    if (cc != sizeof(buf)) {
    45d6:	40000793          	li	a5,1024
    45da:	10f51b63          	bne	a0,a5,46f0 <partial_write+0x232>
  for (int i = 0; i < 64; i++) {
    45de:	34fd                	addiw	s1,s1,-1
    45e0:	fce9                	bnez	s1,45ba <partial_write+0xfc>
  close(fd);
    45e2:	854a                	mv	a0,s2
    45e4:	6b7000ef          	jal	ra,549a <close>
  unlink("bigfile");
    45e8:	00003517          	auipc	a0,0x3
    45ec:	53050513          	addi	a0,a0,1328 # 7b18 <malloc+0x21ce>
    45f0:	6d3000ef          	jal	ra,54c2 <unlink>
  fd = open("testfile", O_RDONLY);
    45f4:	4581                	li	a1,0
    45f6:	00003517          	auipc	a0,0x3
    45fa:	42250513          	addi	a0,a0,1058 # 7a18 <malloc+0x20ce>
    45fe:	6b5000ef          	jal	ra,54b2 <open>
    4602:	84aa                	mv	s1,a0
  if (fd < 0) {
    4604:	10054063          	bltz	a0,4704 <partial_write+0x246>
  cc = read(fd, &b, 1);
    4608:	4605                	li	a2,1
    460a:	fcf40593          	addi	a1,s0,-49
    460e:	67d000ef          	jal	ra,548a <read>
  if (cc != 1) {
    4612:	4785                	li	a5,1
    4614:	10f51263          	bne	a0,a5,4718 <partial_write+0x25a>
  close(fd);
    4618:	8526                	mv	a0,s1
    461a:	681000ef          	jal	ra,549a <close>
  if (b != 'X') {
    461e:	fcf44603          	lbu	a2,-49(s0)
    4622:	05800793          	li	a5,88
    4626:	10f61363          	bne	a2,a5,472c <partial_write+0x26e>
  unlink("testfile");
    462a:	00003517          	auipc	a0,0x3
    462e:	3ee50513          	addi	a0,a0,1006 # 7a18 <malloc+0x20ce>
    4632:	691000ef          	jal	ra,54c2 <unlink>
}
    4636:	43813083          	ld	ra,1080(sp)
    463a:	43013403          	ld	s0,1072(sp)
    463e:	42813483          	ld	s1,1064(sp)
    4642:	42013903          	ld	s2,1056(sp)
    4646:	41813983          	ld	s3,1048(sp)
    464a:	44010113          	addi	sp,sp,1088
    464e:	8082                	ret
    printf("%s: cannot create testfile\n", s);
    4650:	85ce                	mv	a1,s3
    4652:	00003517          	auipc	a0,0x3
    4656:	3d650513          	addi	a0,a0,982 # 7a28 <malloc+0x20de>
    465a:	23c010ef          	jal	ra,5896 <printf>
    exit(1);
    465e:	4505                	li	a0,1
    4660:	613000ef          	jal	ra,5472 <exit>
    printf("%s: could not write A\n", s);
    4664:	85ce                	mv	a1,s3
    4666:	00003517          	auipc	a0,0x3
    466a:	3ea50513          	addi	a0,a0,1002 # 7a50 <malloc+0x2106>
    466e:	228010ef          	jal	ra,5896 <printf>
    exit(1);
    4672:	4505                	li	a0,1
    4674:	5ff000ef          	jal	ra,5472 <exit>
    printf("%s: cannot re-open testfile\n", s);
    4678:	85ce                	mv	a1,s3
    467a:	00003517          	auipc	a0,0x3
    467e:	3ee50513          	addi	a0,a0,1006 # 7a68 <malloc+0x211e>
    4682:	214010ef          	jal	ra,5896 <printf>
    exit(1);
    4686:	4505                	li	a0,1
    4688:	5eb000ef          	jal	ra,5472 <exit>
    printf("%s: sbrk did not align\n", s);
    468c:	85ce                	mv	a1,s3
    468e:	00003517          	auipc	a0,0x3
    4692:	3fa50513          	addi	a0,a0,1018 # 7a88 <malloc+0x213e>
    4696:	200010ef          	jal	ra,5896 <printf>
    exit(1);
    469a:	4505                	li	a0,1
    469c:	5d7000ef          	jal	ra,5472 <exit>
    printf("%s: write succeeded, should have failed\n", s);
    46a0:	85ce                	mv	a1,s3
    46a2:	00003517          	auipc	a0,0x3
    46a6:	3fe50513          	addi	a0,a0,1022 # 7aa0 <malloc+0x2156>
    46aa:	1ec010ef          	jal	ra,5896 <printf>
    exit(1);
    46ae:	4505                	li	a0,1
    46b0:	5c3000ef          	jal	ra,5472 <exit>
    printf("%s: cannot re-open testfile\n", s);
    46b4:	85ce                	mv	a1,s3
    46b6:	00003517          	auipc	a0,0x3
    46ba:	3b250513          	addi	a0,a0,946 # 7a68 <malloc+0x211e>
    46be:	1d8010ef          	jal	ra,5896 <printf>
    exit(1);
    46c2:	4505                	li	a0,1
    46c4:	5af000ef          	jal	ra,5472 <exit>
    printf("%s: cannot read testfile\n", s);
    46c8:	85ce                	mv	a1,s3
    46ca:	00003517          	auipc	a0,0x3
    46ce:	40650513          	addi	a0,a0,1030 # 7ad0 <malloc+0x2186>
    46d2:	1c4010ef          	jal	ra,5896 <printf>
    exit(1);
    46d6:	4505                	li	a0,1
    46d8:	59b000ef          	jal	ra,5472 <exit>
    printf("%s: read returned %c, expected X\n", s, b);
    46dc:	85ce                	mv	a1,s3
    46de:	00003517          	auipc	a0,0x3
    46e2:	41250513          	addi	a0,a0,1042 # 7af0 <malloc+0x21a6>
    46e6:	1b0010ef          	jal	ra,5896 <printf>
    exit(1);
    46ea:	4505                	li	a0,1
    46ec:	587000ef          	jal	ra,5472 <exit>
      printf("%s: could not write to bigfile\n", s);
    46f0:	85ce                	mv	a1,s3
    46f2:	00003517          	auipc	a0,0x3
    46f6:	42e50513          	addi	a0,a0,1070 # 7b20 <malloc+0x21d6>
    46fa:	19c010ef          	jal	ra,5896 <printf>
      exit(-1);
    46fe:	557d                	li	a0,-1
    4700:	573000ef          	jal	ra,5472 <exit>
    printf("%s: cannot re-open testfile\n", s);
    4704:	85ce                	mv	a1,s3
    4706:	00003517          	auipc	a0,0x3
    470a:	36250513          	addi	a0,a0,866 # 7a68 <malloc+0x211e>
    470e:	188010ef          	jal	ra,5896 <printf>
    exit(1);
    4712:	4505                	li	a0,1
    4714:	55f000ef          	jal	ra,5472 <exit>
    printf("%s: cannot read testfile\n", s);
    4718:	85ce                	mv	a1,s3
    471a:	00003517          	auipc	a0,0x3
    471e:	3b650513          	addi	a0,a0,950 # 7ad0 <malloc+0x2186>
    4722:	174010ef          	jal	ra,5896 <printf>
    exit(1);
    4726:	4505                	li	a0,1
    4728:	54b000ef          	jal	ra,5472 <exit>
    printf("%s: read returned %c, expected X\n", s, b);
    472c:	85ce                	mv	a1,s3
    472e:	00003517          	auipc	a0,0x3
    4732:	3c250513          	addi	a0,a0,962 # 7af0 <malloc+0x21a6>
    4736:	160010ef          	jal	ra,5896 <printf>
    exit(1);
    473a:	4505                	li	a0,1
    473c:	537000ef          	jal	ra,5472 <exit>

0000000000004740 <lazy_alloc>:
{
    4740:	1141                	addi	sp,sp,-16
    4742:	e406                	sd	ra,8(sp)
    4744:	e022                	sd	s0,0(sp)
    4746:	0800                	addi	s0,sp,16
  prev_end = sbrklazy(REGION_SZ);
    4748:	40000537          	lui	a0,0x40000
    474c:	509000ef          	jal	ra,5454 <sbrklazy>
  if (prev_end == (char *)SBRK_ERROR) {
    4750:	57fd                	li	a5,-1
    4752:	02f50a63          	beq	a0,a5,4786 <lazy_alloc+0x46>
  for (i = prev_end + PGSIZE; i < new_end; i += 64 * PGSIZE)
    4756:	6605                	lui	a2,0x1
    4758:	962a                	add	a2,a2,a0
    475a:	400017b7          	lui	a5,0x40001
    475e:	00f50733          	add	a4,a0,a5
    4762:	87b2                	mv	a5,a2
    4764:	000406b7          	lui	a3,0x40
    *(char **)i = i;
    4768:	e39c                	sd	a5,0(a5)
  for (i = prev_end + PGSIZE; i < new_end; i += 64 * PGSIZE)
    476a:	97b6                	add	a5,a5,a3
    476c:	fee79ee3          	bne	a5,a4,4768 <lazy_alloc+0x28>
  for (i = prev_end + PGSIZE; i < new_end; i += 64 * PGSIZE) {
    4770:	000406b7          	lui	a3,0x40
    if (*(char **)i != i) {
    4774:	621c                	ld	a5,0(a2)
    4776:	02c79163          	bne	a5,a2,4798 <lazy_alloc+0x58>
  for (i = prev_end + PGSIZE; i < new_end; i += 64 * PGSIZE) {
    477a:	9636                	add	a2,a2,a3
    477c:	fee61ce3          	bne	a2,a4,4774 <lazy_alloc+0x34>
  exit(0);
    4780:	4501                	li	a0,0
    4782:	4f1000ef          	jal	ra,5472 <exit>
    printf("sbrklazy() failed\n");
    4786:	00003517          	auipc	a0,0x3
    478a:	3ba50513          	addi	a0,a0,954 # 7b40 <malloc+0x21f6>
    478e:	108010ef          	jal	ra,5896 <printf>
    exit(1);
    4792:	4505                	li	a0,1
    4794:	4df000ef          	jal	ra,5472 <exit>
      printf("failed to read value from memory\n");
    4798:	00003517          	auipc	a0,0x3
    479c:	3c050513          	addi	a0,a0,960 # 7b58 <malloc+0x220e>
    47a0:	0f6010ef          	jal	ra,5896 <printf>
      exit(1);
    47a4:	4505                	li	a0,1
    47a6:	4cd000ef          	jal	ra,5472 <exit>

00000000000047aa <lazy_unmap>:
{
    47aa:	7139                	addi	sp,sp,-64
    47ac:	fc06                	sd	ra,56(sp)
    47ae:	f822                	sd	s0,48(sp)
    47b0:	f426                	sd	s1,40(sp)
    47b2:	f04a                	sd	s2,32(sp)
    47b4:	ec4e                	sd	s3,24(sp)
    47b6:	0080                	addi	s0,sp,64
  prev_end = sbrklazy(REGION_SZ);
    47b8:	40000537          	lui	a0,0x40000
    47bc:	499000ef          	jal	ra,5454 <sbrklazy>
  if (prev_end == (char *)SBRK_ERROR) {
    47c0:	57fd                	li	a5,-1
    47c2:	04f50363          	beq	a0,a5,4808 <lazy_unmap+0x5e>
  for (i = prev_end + PGSIZE; i < new_end; i += PGSIZE * PGSIZE)
    47c6:	6905                	lui	s2,0x1
    47c8:	992a                	add	s2,s2,a0
    47ca:	400017b7          	lui	a5,0x40001
    47ce:	00f504b3          	add	s1,a0,a5
    47d2:	87ca                	mv	a5,s2
    47d4:	01000737          	lui	a4,0x1000
    *(char **)i = i;
    47d8:	e39c                	sd	a5,0(a5)
  for (i = prev_end + PGSIZE; i < new_end; i += PGSIZE * PGSIZE)
    47da:	97ba                	add	a5,a5,a4
    47dc:	fef49ee3          	bne	s1,a5,47d8 <lazy_unmap+0x2e>
  for (i = prev_end + PGSIZE; i < new_end; i += PGSIZE * PGSIZE) {
    47e0:	010009b7          	lui	s3,0x1000
    pid = fork();
    47e4:	487000ef          	jal	ra,546a <fork>
    if (pid < 0) {
    47e8:	02054963          	bltz	a0,481a <lazy_unmap+0x70>
    } else if (pid == 0) {
    47ec:	c121                	beqz	a0,482c <lazy_unmap+0x82>
      wait(&status);
    47ee:	fcc40513          	addi	a0,s0,-52
    47f2:	489000ef          	jal	ra,547a <wait>
      if (status == 0) {
    47f6:	fcc42783          	lw	a5,-52(s0)
    47fa:	c3b1                	beqz	a5,483e <lazy_unmap+0x94>
  for (i = prev_end + PGSIZE; i < new_end; i += PGSIZE * PGSIZE) {
    47fc:	994e                	add	s2,s2,s3
    47fe:	ff2493e3          	bne	s1,s2,47e4 <lazy_unmap+0x3a>
  exit(0);
    4802:	4501                	li	a0,0
    4804:	46f000ef          	jal	ra,5472 <exit>
    printf("sbrklazy() failed\n");
    4808:	00003517          	auipc	a0,0x3
    480c:	33850513          	addi	a0,a0,824 # 7b40 <malloc+0x21f6>
    4810:	086010ef          	jal	ra,5896 <printf>
    exit(1);
    4814:	4505                	li	a0,1
    4816:	45d000ef          	jal	ra,5472 <exit>
      printf("error forking\n");
    481a:	00003517          	auipc	a0,0x3
    481e:	36650513          	addi	a0,a0,870 # 7b80 <malloc+0x2236>
    4822:	074010ef          	jal	ra,5896 <printf>
      exit(1);
    4826:	4505                	li	a0,1
    4828:	44b000ef          	jal	ra,5472 <exit>
      sbrklazy(-1L * REGION_SZ);
    482c:	c0000537          	lui	a0,0xc0000
    4830:	425000ef          	jal	ra,5454 <sbrklazy>
      *(char **)i = i;
    4834:	01293023          	sd	s2,0(s2) # 1000 <badarg>
      exit(0);
    4838:	4501                	li	a0,0
    483a:	439000ef          	jal	ra,5472 <exit>
        printf("memory not unmapped\n");
    483e:	00003517          	auipc	a0,0x3
    4842:	35250513          	addi	a0,a0,850 # 7b90 <malloc+0x2246>
    4846:	050010ef          	jal	ra,5896 <printf>
        exit(1);
    484a:	4505                	li	a0,1
    484c:	427000ef          	jal	ra,5472 <exit>

0000000000004850 <lazy_copy>:
{
    4850:	7159                	addi	sp,sp,-112
    4852:	f486                	sd	ra,104(sp)
    4854:	f0a2                	sd	s0,96(sp)
    4856:	eca6                	sd	s1,88(sp)
    4858:	e8ca                	sd	s2,80(sp)
    485a:	e4ce                	sd	s3,72(sp)
    485c:	e0d2                	sd	s4,64(sp)
    485e:	fc56                	sd	s5,56(sp)
    4860:	f85a                	sd	s6,48(sp)
    4862:	1880                	addi	s0,sp,112
    char *p = sbrk(0);
    4864:	4501                	li	a0,0
    4866:	3d9000ef          	jal	ra,543e <sbrk>
    486a:	84aa                	mv	s1,a0
    sbrklazy(4 * PGSIZE);
    486c:	6511                	lui	a0,0x4
    486e:	3e7000ef          	jal	ra,5454 <sbrklazy>
    open(p + 8192, 0);
    4872:	4581                	li	a1,0
    4874:	6509                	lui	a0,0x2
    4876:	9526                	add	a0,a0,s1
    4878:	43b000ef          	jal	ra,54b2 <open>
    void *xx = sbrk(0);
    487c:	4501                	li	a0,0
    487e:	3c1000ef          	jal	ra,543e <sbrk>
    4882:	84aa                	mv	s1,a0
    void *ret = sbrk(-(((uint64)xx) + 1));
    4884:	fff54513          	not	a0,a0
    4888:	2501                	sext.w	a0,a0
    488a:	3b5000ef          	jal	ra,543e <sbrk>
    if (ret != xx) {
    488e:	00a48c63          	beq	s1,a0,48a6 <lazy_copy+0x56>
    4892:	85aa                	mv	a1,a0
      printf("sbrk(sbrk(0)+1) returned %p, not old sz\n", ret);
    4894:	00003517          	auipc	a0,0x3
    4898:	31450513          	addi	a0,a0,788 # 7ba8 <malloc+0x225e>
    489c:	7fb000ef          	jal	ra,5896 <printf>
      exit(1);
    48a0:	4505                	li	a0,1
    48a2:	3d1000ef          	jal	ra,5472 <exit>
  unsigned long bad[] = {
    48a6:	00004797          	auipc	a5,0x4
    48aa:	ab278793          	addi	a5,a5,-1358 # 8358 <malloc+0x2a0e>
    48ae:	7fa8                	ld	a0,120(a5)
    48b0:	63cc                	ld	a1,128(a5)
    48b2:	67d0                	ld	a2,136(a5)
    48b4:	6bd4                	ld	a3,144(a5)
    48b6:	6fd8                	ld	a4,152(a5)
    48b8:	73dc                	ld	a5,160(a5)
    48ba:	f8a43823          	sd	a0,-112(s0)
    48be:	f8b43c23          	sd	a1,-104(s0)
    48c2:	fac43023          	sd	a2,-96(s0)
    48c6:	fad43423          	sd	a3,-88(s0)
    48ca:	fae43823          	sd	a4,-80(s0)
    48ce:	faf43c23          	sd	a5,-72(s0)
  for (int i = 0; i < sizeof(bad) / sizeof(bad[0]); i++) {
    48d2:	f9040913          	addi	s2,s0,-112
    48d6:	fc040b13          	addi	s6,s0,-64
    int fd = open("README", 0);
    48da:	00001a17          	auipc	s4,0x1
    48de:	366a0a13          	addi	s4,s4,870 # 5c40 <malloc+0x2f6>
    fd = open("junk", O_CREATE | O_RDWR | O_TRUNC);
    48e2:	00001a97          	auipc	s5,0x1
    48e6:	26ea8a93          	addi	s5,s5,622 # 5b50 <malloc+0x206>
    int fd = open("README", 0);
    48ea:	4581                	li	a1,0
    48ec:	8552                	mv	a0,s4
    48ee:	3c5000ef          	jal	ra,54b2 <open>
    48f2:	84aa                	mv	s1,a0
    if (fd < 0) {
    48f4:	04054663          	bltz	a0,4940 <lazy_copy+0xf0>
    if (read(fd, (char *)bad[i], 512) >= 0) {
    48f8:	00093983          	ld	s3,0(s2)
    48fc:	20000613          	li	a2,512
    4900:	85ce                	mv	a1,s3
    4902:	389000ef          	jal	ra,548a <read>
    4906:	04055663          	bgez	a0,4952 <lazy_copy+0x102>
    close(fd);
    490a:	8526                	mv	a0,s1
    490c:	38f000ef          	jal	ra,549a <close>
    fd = open("junk", O_CREATE | O_RDWR | O_TRUNC);
    4910:	60200593          	li	a1,1538
    4914:	8556                	mv	a0,s5
    4916:	39d000ef          	jal	ra,54b2 <open>
    491a:	84aa                	mv	s1,a0
    if (fd < 0) {
    491c:	04054463          	bltz	a0,4964 <lazy_copy+0x114>
    if (write(fd, (char *)bad[i], 512) >= 0) {
    4920:	20000613          	li	a2,512
    4924:	85ce                	mv	a1,s3
    4926:	36d000ef          	jal	ra,5492 <write>
    492a:	04055663          	bgez	a0,4976 <lazy_copy+0x126>
    close(fd);
    492e:	8526                	mv	a0,s1
    4930:	36b000ef          	jal	ra,549a <close>
  for (int i = 0; i < sizeof(bad) / sizeof(bad[0]); i++) {
    4934:	0921                	addi	s2,s2,8
    4936:	fb691ae3          	bne	s2,s6,48ea <lazy_copy+0x9a>
  exit(0);
    493a:	4501                	li	a0,0
    493c:	337000ef          	jal	ra,5472 <exit>
      printf("cannot open README\n");
    4940:	00003517          	auipc	a0,0x3
    4944:	29850513          	addi	a0,a0,664 # 7bd8 <malloc+0x228e>
    4948:	74f000ef          	jal	ra,5896 <printf>
      exit(1);
    494c:	4505                	li	a0,1
    494e:	325000ef          	jal	ra,5472 <exit>
      printf("read succeeded\n");
    4952:	00003517          	auipc	a0,0x3
    4956:	29e50513          	addi	a0,a0,670 # 7bf0 <malloc+0x22a6>
    495a:	73d000ef          	jal	ra,5896 <printf>
      exit(1);
    495e:	4505                	li	a0,1
    4960:	313000ef          	jal	ra,5472 <exit>
      printf("cannot open junk\n");
    4964:	00003517          	auipc	a0,0x3
    4968:	29c50513          	addi	a0,a0,668 # 7c00 <malloc+0x22b6>
    496c:	72b000ef          	jal	ra,5896 <printf>
      exit(1);
    4970:	4505                	li	a0,1
    4972:	301000ef          	jal	ra,5472 <exit>
      printf("write succeeded\n");
    4976:	00003517          	auipc	a0,0x3
    497a:	2a250513          	addi	a0,a0,674 # 7c18 <malloc+0x22ce>
    497e:	719000ef          	jal	ra,5896 <printf>
      exit(1);
    4982:	4505                	li	a0,1
    4984:	2ef000ef          	jal	ra,5472 <exit>

0000000000004988 <lazy_sbrk>:
{
    4988:	1101                	addi	sp,sp,-32
    498a:	ec06                	sd	ra,24(sp)
    498c:	e822                	sd	s0,16(sp)
    498e:	e426                	sd	s1,8(sp)
    4990:	e04a                	sd	s2,0(sp)
    4992:	1000                	addi	s0,sp,32
  char *p = sbrk(0);
    4994:	4501                	li	a0,0
    4996:	2a9000ef          	jal	ra,543e <sbrk>
    499a:	84aa                	mv	s1,a0
  while ((uint64)p < MAXVA - (1 << 30)) {
    499c:	0ff00793          	li	a5,255
    49a0:	07fa                	slli	a5,a5,0x1e
    49a2:	00f57d63          	bgeu	a0,a5,49bc <lazy_sbrk+0x34>
    49a6:	893e                	mv	s2,a5
    p = sbrklazy(1 << 30);
    49a8:	40000537          	lui	a0,0x40000
    49ac:	2a9000ef          	jal	ra,5454 <sbrklazy>
    p = sbrklazy(0);
    49b0:	4501                	li	a0,0
    49b2:	2a3000ef          	jal	ra,5454 <sbrklazy>
    49b6:	84aa                	mv	s1,a0
  while ((uint64)p < MAXVA - (1 << 30)) {
    49b8:	ff2568e3          	bltu	a0,s2,49a8 <lazy_sbrk+0x20>
  int n = TRAPFRAME - PGSIZE - (uint64)p;
    49bc:	7975                	lui	s2,0xffffd
    49be:	4099093b          	subw	s2,s2,s1
  char *p1 = sbrklazy(n);
    49c2:	854a                	mv	a0,s2
    49c4:	291000ef          	jal	ra,5454 <sbrklazy>
    49c8:	862a                	mv	a2,a0
  if (p1 < 0 || p1 != p) {
    49ca:	00950d63          	beq	a0,s1,49e4 <lazy_sbrk+0x5c>
    printf("sbrklazy(%d) returned %p, not expected %p\n", n, p1, p);
    49ce:	86a6                	mv	a3,s1
    49d0:	85ca                	mv	a1,s2
    49d2:	00003517          	auipc	a0,0x3
    49d6:	25e50513          	addi	a0,a0,606 # 7c30 <malloc+0x22e6>
    49da:	6bd000ef          	jal	ra,5896 <printf>
    exit(1);
    49de:	4505                	li	a0,1
    49e0:	293000ef          	jal	ra,5472 <exit>
  p = sbrk(PGSIZE);
    49e4:	6505                	lui	a0,0x1
    49e6:	259000ef          	jal	ra,543e <sbrk>
    49ea:	862a                	mv	a2,a0
  if (p < 0 || (uint64)p != TRAPFRAME - PGSIZE) {
    49ec:	040007b7          	lui	a5,0x4000
    49f0:	17f5                	addi	a5,a5,-3 # 3fffffd <base+0x3ff0305>
    49f2:	07b2                	slli	a5,a5,0xc
    49f4:	00f50c63          	beq	a0,a5,4a0c <lazy_sbrk+0x84>
    printf("sbrk(%d) returned %p, not expected TRAPFRAME-PGSIZE\n", PGSIZE, p);
    49f8:	6585                	lui	a1,0x1
    49fa:	00003517          	auipc	a0,0x3
    49fe:	26650513          	addi	a0,a0,614 # 7c60 <malloc+0x2316>
    4a02:	695000ef          	jal	ra,5896 <printf>
    exit(1);
    4a06:	4505                	li	a0,1
    4a08:	26b000ef          	jal	ra,5472 <exit>
  p[0] = 1;
    4a0c:	040007b7          	lui	a5,0x4000
    4a10:	17f5                	addi	a5,a5,-3 # 3fffffd <base+0x3ff0305>
    4a12:	07b2                	slli	a5,a5,0xc
    4a14:	4705                	li	a4,1
    4a16:	00e78023          	sb	a4,0(a5)
  if (p[1] != 0) {
    4a1a:	0017c783          	lbu	a5,1(a5)
    4a1e:	cb91                	beqz	a5,4a32 <lazy_sbrk+0xaa>
    printf("sbrk() returned non-zero-filled memory\n");
    4a20:	00003517          	auipc	a0,0x3
    4a24:	27850513          	addi	a0,a0,632 # 7c98 <malloc+0x234e>
    4a28:	66f000ef          	jal	ra,5896 <printf>
    exit(1);
    4a2c:	4505                	li	a0,1
    4a2e:	245000ef          	jal	ra,5472 <exit>
  p = sbrk(1);
    4a32:	4505                	li	a0,1
    4a34:	20b000ef          	jal	ra,543e <sbrk>
    4a38:	85aa                	mv	a1,a0
  if ((uint64)p != -1) {
    4a3a:	57fd                	li	a5,-1
    4a3c:	00f50b63          	beq	a0,a5,4a52 <lazy_sbrk+0xca>
    printf("sbrk(1) returned %p, expected error\n", p);
    4a40:	00003517          	auipc	a0,0x3
    4a44:	28050513          	addi	a0,a0,640 # 7cc0 <malloc+0x2376>
    4a48:	64f000ef          	jal	ra,5896 <printf>
    exit(1);
    4a4c:	4505                	li	a0,1
    4a4e:	225000ef          	jal	ra,5472 <exit>
  p = sbrklazy(1);
    4a52:	4505                	li	a0,1
    4a54:	201000ef          	jal	ra,5454 <sbrklazy>
    4a58:	85aa                	mv	a1,a0
  if ((uint64)p != -1) {
    4a5a:	57fd                	li	a5,-1
    4a5c:	00f50b63          	beq	a0,a5,4a72 <lazy_sbrk+0xea>
    printf("sbrklazy(1) returned %p, expected error\n", p);
    4a60:	00003517          	auipc	a0,0x3
    4a64:	28850513          	addi	a0,a0,648 # 7ce8 <malloc+0x239e>
    4a68:	62f000ef          	jal	ra,5896 <printf>
    exit(1);
    4a6c:	4505                	li	a0,1
    4a6e:	205000ef          	jal	ra,5472 <exit>
  exit(0);
    4a72:	4501                	li	a0,0
    4a74:	1ff000ef          	jal	ra,5472 <exit>

0000000000004a78 <lazy_copyinstr>:
{
    4a78:	715d                	addi	sp,sp,-80
    4a7a:	e486                	sd	ra,72(sp)
    4a7c:	e0a2                	sd	s0,64(sp)
    4a7e:	fc26                	sd	s1,56(sp)
    4a80:	f84a                	sd	s2,48(sp)
    4a82:	f44e                	sd	s3,40(sp)
    4a84:	0880                	addi	s0,sp,80
    4a86:	89aa                	mv	s3,a0
  char *p = sbrk(0);
    4a88:	4501                	li	a0,0
    4a8a:	1b5000ef          	jal	ra,543e <sbrk>
  sbrk(PGSIZE - ((uint64)p % PGSIZE));
    4a8e:	6485                	lui	s1,0x1
    4a90:	14fd                	addi	s1,s1,-1 # fff <pgbug+0x2b>
    4a92:	009577b3          	and	a5,a0,s1
    4a96:	6505                	lui	a0,0x1
    4a98:	9d1d                	subw	a0,a0,a5
    4a9a:	1a5000ef          	jal	ra,543e <sbrk>
  p = sbrk(0);
    4a9e:	4501                	li	a0,0
    4aa0:	19f000ef          	jal	ra,543e <sbrk>
  if ((uint64)p % PGSIZE != 0) {
    4aa4:	8ce9                	and	s1,s1,a0
    4aa6:	e8a9                	bnez	s1,4af8 <lazy_copyinstr+0x80>
    4aa8:	892a                	mv	s2,a0
  sbrklazy(2 * PGSIZE);
    4aaa:	6509                	lui	a0,0x2
    4aac:	1a9000ef          	jal	ra,5454 <sbrklazy>
  p[4095] = '/';
    4ab0:	6505                	lui	a0,0x1
    4ab2:	00a907b3          	add	a5,s2,a0
    4ab6:	02f00713          	li	a4,47
    4aba:	fee78fa3          	sb	a4,-1(a5)
  int fd = open(&p[4095], O_RDONLY);
    4abe:	157d                	addi	a0,a0,-1 # fff <pgbug+0x2b>
    4ac0:	4581                	li	a1,0
    4ac2:	954a                	add	a0,a0,s2
    4ac4:	1ef000ef          	jal	ra,54b2 <open>
    4ac8:	84aa                	mv	s1,a0
  if (fd < 0) {
    4aca:	04054163          	bltz	a0,4b0c <lazy_copyinstr+0x94>
  int r = fstat(fd, &st);
    4ace:	fb840593          	addi	a1,s0,-72
    4ad2:	1f9000ef          	jal	ra,54ca <fstat>
  if (r < 0) {
    4ad6:	04054463          	bltz	a0,4b1e <lazy_copyinstr+0xa6>
  if (st.type != T_DIR) {
    4ada:	fc041703          	lh	a4,-64(s0)
    4ade:	4785                	li	a5,1
    4ae0:	04f71863          	bne	a4,a5,4b30 <lazy_copyinstr+0xb8>
  close(fd);
    4ae4:	8526                	mv	a0,s1
    4ae6:	1b5000ef          	jal	ra,549a <close>
}
    4aea:	60a6                	ld	ra,72(sp)
    4aec:	6406                	ld	s0,64(sp)
    4aee:	74e2                	ld	s1,56(sp)
    4af0:	7942                	ld	s2,48(sp)
    4af2:	79a2                	ld	s3,40(sp)
    4af4:	6161                	addi	sp,sp,80
    4af6:	8082                	ret
    printf("%s: sbrk did not align\n", s);
    4af8:	85ce                	mv	a1,s3
    4afa:	00003517          	auipc	a0,0x3
    4afe:	f8e50513          	addi	a0,a0,-114 # 7a88 <malloc+0x213e>
    4b02:	595000ef          	jal	ra,5896 <printf>
    exit(1);
    4b06:	4505                	li	a0,1
    4b08:	16b000ef          	jal	ra,5472 <exit>
    printf("could not open /");
    4b0c:	00003517          	auipc	a0,0x3
    4b10:	20c50513          	addi	a0,a0,524 # 7d18 <malloc+0x23ce>
    4b14:	583000ef          	jal	ra,5896 <printf>
    exit(1);
    4b18:	4505                	li	a0,1
    4b1a:	159000ef          	jal	ra,5472 <exit>
    printf("could not stat /");
    4b1e:	00003517          	auipc	a0,0x3
    4b22:	21250513          	addi	a0,a0,530 # 7d30 <malloc+0x23e6>
    4b26:	571000ef          	jal	ra,5896 <printf>
    exit(1);
    4b2a:	4505                	li	a0,1
    4b2c:	147000ef          	jal	ra,5472 <exit>
    printf("/ is not T_DIR");
    4b30:	00003517          	auipc	a0,0x3
    4b34:	21850513          	addi	a0,a0,536 # 7d48 <malloc+0x23fe>
    4b38:	55f000ef          	jal	ra,5896 <printf>
    exit(1);
    4b3c:	4505                	li	a0,1
    4b3e:	135000ef          	jal	ra,5472 <exit>

0000000000004b42 <fsfull>:
{
    4b42:	7171                	addi	sp,sp,-176
    4b44:	f506                	sd	ra,168(sp)
    4b46:	f122                	sd	s0,160(sp)
    4b48:	ed26                	sd	s1,152(sp)
    4b4a:	e94a                	sd	s2,144(sp)
    4b4c:	e54e                	sd	s3,136(sp)
    4b4e:	e152                	sd	s4,128(sp)
    4b50:	fcd6                	sd	s5,120(sp)
    4b52:	f8da                	sd	s6,112(sp)
    4b54:	f4de                	sd	s7,104(sp)
    4b56:	f0e2                	sd	s8,96(sp)
    4b58:	ece6                	sd	s9,88(sp)
    4b5a:	e8ea                	sd	s10,80(sp)
    4b5c:	e4ee                	sd	s11,72(sp)
    4b5e:	1900                	addi	s0,sp,176
  printf("fsfull test\n");
    4b60:	00003517          	auipc	a0,0x3
    4b64:	1f850513          	addi	a0,a0,504 # 7d58 <malloc+0x240e>
    4b68:	52f000ef          	jal	ra,5896 <printf>
  int fsblocks = 0;
    4b6c:	4981                	li	s3,0
  for (nfiles = 0;; nfiles++) {
    4b6e:	4481                	li	s1,0
    name[0] = 'f';
    4b70:	06600d93          	li	s11,102
    name[1] = '0' + nfiles / 1000;
    4b74:	3e800c93          	li	s9,1000
    name[2] = '0' + (nfiles % 1000) / 100;
    4b78:	06400c13          	li	s8,100
    name[3] = '0' + (nfiles % 100) / 10;
    4b7c:	4ba9                	li	s7,10
    printf("writing %s\n", name);
    4b7e:	00003d17          	auipc	s10,0x3
    4b82:	1ead0d13          	addi	s10,s10,490 # 7d68 <malloc+0x241e>
      int cc = write(fd, buf, BSIZE);
    4b86:	00008a97          	auipc	s5,0x8
    4b8a:	172a8a93          	addi	s5,s5,370 # ccf8 <buf>
    name[0] = 'f';
    4b8e:	f5b40823          	sb	s11,-176(s0)
    name[1] = '0' + nfiles / 1000;
    4b92:	0394c7bb          	divw	a5,s1,s9
    4b96:	0307879b          	addiw	a5,a5,48
    4b9a:	f4f408a3          	sb	a5,-175(s0)
    name[2] = '0' + (nfiles % 1000) / 100;
    4b9e:	0394e7bb          	remw	a5,s1,s9
    4ba2:	0387c7bb          	divw	a5,a5,s8
    4ba6:	0307879b          	addiw	a5,a5,48
    4baa:	f4f40923          	sb	a5,-174(s0)
    name[3] = '0' + (nfiles % 100) / 10;
    4bae:	0384e7bb          	remw	a5,s1,s8
    4bb2:	0377c7bb          	divw	a5,a5,s7
    4bb6:	0307879b          	addiw	a5,a5,48
    4bba:	f4f409a3          	sb	a5,-173(s0)
    name[4] = '0' + (nfiles % 10);
    4bbe:	0374e7bb          	remw	a5,s1,s7
    4bc2:	0307879b          	addiw	a5,a5,48
    4bc6:	f4f40a23          	sb	a5,-172(s0)
    name[5] = '\0';
    4bca:	f4040aa3          	sb	zero,-171(s0)
    printf("writing %s\n", name);
    4bce:	f5040593          	addi	a1,s0,-176
    4bd2:	856a                	mv	a0,s10
    4bd4:	4c3000ef          	jal	ra,5896 <printf>
    int fd = open(name, O_CREATE | O_RDWR);
    4bd8:	20200593          	li	a1,514
    4bdc:	f5040513          	addi	a0,s0,-176
    4be0:	0d3000ef          	jal	ra,54b2 <open>
    4be4:	892a                	mv	s2,a0
    if (fd < 0) {
    4be6:	0a055163          	bgez	a0,4c88 <fsfull+0x146>
      printf("open %s failed\n", name);
    4bea:	f5040593          	addi	a1,s0,-176
    4bee:	00003517          	auipc	a0,0x3
    4bf2:	18a50513          	addi	a0,a0,394 # 7d78 <malloc+0x242e>
    4bf6:	4a1000ef          	jal	ra,5896 <printf>
  while (nfiles >= 0) {
    4bfa:	0604c163          	bltz	s1,4c5c <fsfull+0x11a>
    name[0] = 'f';
    4bfe:	06600b93          	li	s7,102
    name[1] = '0' + nfiles / 1000;
    4c02:	3e800a93          	li	s5,1000
    name[2] = '0' + (nfiles % 1000) / 100;
    4c06:	06400a13          	li	s4,100
    name[3] = '0' + (nfiles % 100) / 10;
    4c0a:	4929                	li	s2,10
  while (nfiles >= 0) {
    4c0c:	5b7d                	li	s6,-1
    name[0] = 'f';
    4c0e:	f5740823          	sb	s7,-176(s0)
    name[1] = '0' + nfiles / 1000;
    4c12:	0354c7bb          	divw	a5,s1,s5
    4c16:	0307879b          	addiw	a5,a5,48
    4c1a:	f4f408a3          	sb	a5,-175(s0)
    name[2] = '0' + (nfiles % 1000) / 100;
    4c1e:	0354e7bb          	remw	a5,s1,s5
    4c22:	0347c7bb          	divw	a5,a5,s4
    4c26:	0307879b          	addiw	a5,a5,48
    4c2a:	f4f40923          	sb	a5,-174(s0)
    name[3] = '0' + (nfiles % 100) / 10;
    4c2e:	0344e7bb          	remw	a5,s1,s4
    4c32:	0327c7bb          	divw	a5,a5,s2
    4c36:	0307879b          	addiw	a5,a5,48
    4c3a:	f4f409a3          	sb	a5,-173(s0)
    name[4] = '0' + (nfiles % 10);
    4c3e:	0324e7bb          	remw	a5,s1,s2
    4c42:	0307879b          	addiw	a5,a5,48
    4c46:	f4f40a23          	sb	a5,-172(s0)
    name[5] = '\0';
    4c4a:	f4040aa3          	sb	zero,-171(s0)
    unlink(name);
    4c4e:	f5040513          	addi	a0,s0,-176
    4c52:	071000ef          	jal	ra,54c2 <unlink>
    nfiles--;
    4c56:	34fd                	addiw	s1,s1,-1
  while (nfiles >= 0) {
    4c58:	fb649be3          	bne	s1,s6,4c0e <fsfull+0xcc>
  printf("fsfull test finished, %d blocks\n", fsblocks);
    4c5c:	85ce                	mv	a1,s3
    4c5e:	00003517          	auipc	a0,0x3
    4c62:	13a50513          	addi	a0,a0,314 # 7d98 <malloc+0x244e>
    4c66:	431000ef          	jal	ra,5896 <printf>
}
    4c6a:	70aa                	ld	ra,168(sp)
    4c6c:	740a                	ld	s0,160(sp)
    4c6e:	64ea                	ld	s1,152(sp)
    4c70:	694a                	ld	s2,144(sp)
    4c72:	69aa                	ld	s3,136(sp)
    4c74:	6a0a                	ld	s4,128(sp)
    4c76:	7ae6                	ld	s5,120(sp)
    4c78:	7b46                	ld	s6,112(sp)
    4c7a:	7ba6                	ld	s7,104(sp)
    4c7c:	7c06                	ld	s8,96(sp)
    4c7e:	6ce6                	ld	s9,88(sp)
    4c80:	6d46                	ld	s10,80(sp)
    4c82:	6da6                	ld	s11,72(sp)
    4c84:	614d                	addi	sp,sp,176
    4c86:	8082                	ret
    int total = 0;
    4c88:	4a01                	li	s4,0
      if (cc < BSIZE)
    4c8a:	3ff00b13          	li	s6,1023
      int cc = write(fd, buf, BSIZE);
    4c8e:	40000613          	li	a2,1024
    4c92:	85d6                	mv	a1,s5
    4c94:	854a                	mv	a0,s2
    4c96:	7fc000ef          	jal	ra,5492 <write>
      if (cc < BSIZE)
    4c9a:	00ab5663          	bge	s6,a0,4ca6 <fsfull+0x164>
      total += cc;
    4c9e:	00aa0a3b          	addw	s4,s4,a0
      fsblocks++;
    4ca2:	2985                	addiw	s3,s3,1 # 1000001 <base+0xff0309>
    while (1) {
    4ca4:	b7ed                	j	4c8e <fsfull+0x14c>
    printf("wrote %d bytes\n", total);
    4ca6:	85d2                	mv	a1,s4
    4ca8:	00003517          	auipc	a0,0x3
    4cac:	0e050513          	addi	a0,a0,224 # 7d88 <malloc+0x243e>
    4cb0:	3e7000ef          	jal	ra,5896 <printf>
    close(fd);
    4cb4:	854a                	mv	a0,s2
    4cb6:	7e4000ef          	jal	ra,549a <close>
    if (total == 0)
    4cba:	f40a00e3          	beqz	s4,4bfa <fsfull+0xb8>
  for (nfiles = 0;; nfiles++) {
    4cbe:	2485                	addiw	s1,s1,1
    4cc0:	b5f9                	j	4b8e <fsfull+0x4c>

0000000000004cc2 <linkoverflow>:

void
linkoverflow(char *s)
{
    4cc2:	7175                	addi	sp,sp,-144
    4cc4:	e506                	sd	ra,136(sp)
    4cc6:	e122                	sd	s0,128(sp)
    4cc8:	fca6                	sd	s1,120(sp)
    4cca:	f8ca                	sd	s2,112(sp)
    4ccc:	f4ce                	sd	s3,104(sp)
    4cce:	f0d2                	sd	s4,96(sp)
    4cd0:	ecd6                	sd	s5,88(sp)
    4cd2:	e8da                	sd	s6,80(sp)
    4cd4:	e4de                	sd	s7,72(sp)
    4cd6:	e0e2                	sd	s8,64(sp)
    4cd8:	fc66                	sd	s9,56(sp)
    4cda:	f86a                	sd	s10,48(sp)
    4cdc:	0900                	addi	s0,sp,144
    4cde:	8caa                	mv	s9,a0
  enum { TARGET = 32768 };
  enum { DIRS = 64 };
  struct stat st;
  int i;

  unlink("/lof");
    4ce0:	00003517          	auipc	a0,0x3
    4ce4:	0e050513          	addi	a0,a0,224 # 7dc0 <malloc+0x2476>
    4ce8:	7da000ef          	jal	ra,54c2 <unlink>
  int fd = open("/lof", O_CREATE | O_RDWR);
    4cec:	20200593          	li	a1,514
    4cf0:	00003517          	auipc	a0,0x3
    4cf4:	0d050513          	addi	a0,a0,208 # 7dc0 <malloc+0x2476>
    4cf8:	7ba000ef          	jal	ra,54b2 <open>
  if (fd < 0) {
    4cfc:	02054863          	bltz	a0,4d2c <linkoverflow+0x6a>
    printf("%s: cannot create /lof\n", s);
    exit(1);
  }
  close(fd);
    4d00:	79a000ef          	jal	ra,549a <close>

  for (i = 0; i < TARGET; i++) {
    4d04:	4901                	li	s2,0
    int d = i % DIRS;
    int f = i / DIRS;

    char pn[16];
    pn[0] = '/';
    4d06:	02f00993          	li	s3,47
    pn[1] = 'd';
    4d0a:	06400a93          	li	s5,100
    pn[2] = '_';
    4d0e:	05f00a13          	li	s4,95
      printf("%s: mkdir(%s) failed\n", s, pn);
      exit(1);
    }

    pn[5] = '/';
    pn[6] = 'l';
    4d12:	06c00b93          	li	s7,108
    pn[7] = 'a' + (f / 256);
    pn[8] = 'a' + ((f / 16) % 16);
    pn[9] = 'a' + (f % 16);
    pn[10] = '\0';

    if (link("/lof", pn) < 0) {
    4d16:	00003b17          	auipc	s6,0x3
    4d1a:	0aab0b13          	addi	s6,s6,170 # 7dc0 <malloc+0x2476>
      }
      printf("%s: link failed after %d links (nlink=%d)\n", s, i, st.nlink);
      exit(1);
    }

    if (i % 100 == 0) {
    4d1e:	06400c13          	li	s8,100
      printf("%s: i=%d, pn=%s\n", s, i, pn);
    4d22:	00003d17          	auipc	s10,0x3
    4d26:	11ed0d13          	addi	s10,s10,286 # 7e40 <malloc+0x24f6>
    4d2a:	a061                	j	4db2 <linkoverflow+0xf0>
    printf("%s: cannot create /lof\n", s);
    4d2c:	85e6                	mv	a1,s9
    4d2e:	00003517          	auipc	a0,0x3
    4d32:	09a50513          	addi	a0,a0,154 # 7dc8 <malloc+0x247e>
    4d36:	361000ef          	jal	ra,5896 <printf>
    exit(1);
    4d3a:	4505                	li	a0,1
    4d3c:	736000ef          	jal	ra,5472 <exit>
    pn[5] = '/';
    4d40:	f7340ea3          	sb	s3,-131(s0)
    pn[6] = 'l';
    4d44:	f7740f23          	sb	s7,-130(s0)
    pn[7] = 'a' + (f / 256);
    4d48:	41f9579b          	sraiw	a5,s2,0x1f
    4d4c:	0127d79b          	srliw	a5,a5,0x12
    4d50:	012787bb          	addw	a5,a5,s2
    4d54:	40e7d79b          	sraiw	a5,a5,0xe
    4d58:	0617879b          	addiw	a5,a5,97
    4d5c:	f6f40fa3          	sb	a5,-129(s0)
    pn[8] = 'a' + ((f / 16) % 16);
    4d60:	41f4d71b          	sraiw	a4,s1,0x1f
    4d64:	01c7571b          	srliw	a4,a4,0x1c
    4d68:	9cb9                	addw	s1,s1,a4
    4d6a:	4044d79b          	sraiw	a5,s1,0x4
    4d6e:	41f4d69b          	sraiw	a3,s1,0x1f
    4d72:	01c6d69b          	srliw	a3,a3,0x1c
    4d76:	9fb5                	addw	a5,a5,a3
    4d78:	8bbd                	andi	a5,a5,15
    4d7a:	9f95                	subw	a5,a5,a3
    4d7c:	0617879b          	addiw	a5,a5,97
    4d80:	f8f40023          	sb	a5,-128(s0)
    pn[9] = 'a' + (f % 16);
    4d84:	88bd                	andi	s1,s1,15
    4d86:	9c99                	subw	s1,s1,a4
    4d88:	0614849b          	addiw	s1,s1,97
    4d8c:	f89400a3          	sb	s1,-127(s0)
    pn[10] = '\0';
    4d90:	f8040123          	sb	zero,-126(s0)
    if (link("/lof", pn) < 0) {
    4d94:	f7840593          	addi	a1,s0,-136
    4d98:	855a                	mv	a0,s6
    4d9a:	738000ef          	jal	ra,54d2 <link>
    4d9e:	08054363          	bltz	a0,4e24 <linkoverflow+0x162>
    if (i % 100 == 0) {
    4da2:	038967bb          	remw	a5,s2,s8
    4da6:	10078863          	beqz	a5,4eb6 <linkoverflow+0x1f4>
  for (i = 0; i < TARGET; i++) {
    4daa:	2905                	addiw	s2,s2,1 # ffffffffffffd001 <base+0xfffffffffffed309>
    4dac:	67a1                	lui	a5,0x8
    4dae:	08f90d63          	beq	s2,a5,4e48 <linkoverflow+0x186>
    int d = i % DIRS;
    4db2:	41f9571b          	sraiw	a4,s2,0x1f
    4db6:	01a7571b          	srliw	a4,a4,0x1a
    4dba:	012704bb          	addw	s1,a4,s2
    4dbe:	03f4f793          	andi	a5,s1,63
    4dc2:	9f99                	subw	a5,a5,a4
    int f = i / DIRS;
    4dc4:	4064d49b          	sraiw	s1,s1,0x6
    4dc8:	0004861b          	sext.w	a2,s1
    pn[0] = '/';
    4dcc:	f7340c23          	sb	s3,-136(s0)
    pn[1] = 'd';
    4dd0:	f7540ca3          	sb	s5,-135(s0)
    pn[2] = '_';
    4dd4:	f7440d23          	sb	s4,-134(s0)
    pn[3] = 'a' + (d / 16);
    4dd8:	41f7d71b          	sraiw	a4,a5,0x1f
    4ddc:	01c7571b          	srliw	a4,a4,0x1c
    4de0:	9fb9                	addw	a5,a5,a4
    4de2:	4047d69b          	sraiw	a3,a5,0x4
    4de6:	0616869b          	addiw	a3,a3,97 # 40061 <base+0x30369>
    4dea:	f6d40da3          	sb	a3,-133(s0)
    pn[4] = 'a' + (d % 16);
    4dee:	8bbd                	andi	a5,a5,15
    4df0:	9f99                	subw	a5,a5,a4
    4df2:	0617879b          	addiw	a5,a5,97 # 8061 <malloc+0x2717>
    4df6:	f6f40e23          	sb	a5,-132(s0)
    pn[5] = '\0';
    4dfa:	f6040ea3          	sb	zero,-131(s0)
    if (f == 0 && mkdir(pn) < 0) {
    4dfe:	f229                	bnez	a2,4d40 <linkoverflow+0x7e>
    4e00:	f7840513          	addi	a0,s0,-136
    4e04:	6d6000ef          	jal	ra,54da <mkdir>
    4e08:	f2055ce3          	bgez	a0,4d40 <linkoverflow+0x7e>
      printf("%s: mkdir(%s) failed\n", s, pn);
    4e0c:	f7840613          	addi	a2,s0,-136
    4e10:	85e6                	mv	a1,s9
    4e12:	00003517          	auipc	a0,0x3
    4e16:	fce50513          	addi	a0,a0,-50 # 7de0 <malloc+0x2496>
    4e1a:	27d000ef          	jal	ra,5896 <printf>
      exit(1);
    4e1e:	4505                	li	a0,1
    4e20:	652000ef          	jal	ra,5472 <exit>
      if (stat("/lof", &st) < 0) {
    4e24:	f8840593          	addi	a1,s0,-120
    4e28:	00003517          	auipc	a0,0x3
    4e2c:	f9850513          	addi	a0,a0,-104 # 7dc0 <malloc+0x2476>
    4e30:	4e6000ef          	jal	ra,5316 <stat>
    4e34:	04054c63          	bltz	a0,4e8c <linkoverflow+0x1ca>
      if (st.nlink >= 32767) {
    4e38:	f9241683          	lh	a3,-110(s0)
    4e3c:	0006871b          	sext.w	a4,a3
    4e40:	67a1                	lui	a5,0x8
    4e42:	17fd                	addi	a5,a5,-1 # 7fff <malloc+0x26b5>
    4e44:	04f71e63          	bne	a4,a5,4ea0 <linkoverflow+0x1de>
    }
  }

  if (stat("/lof", &st) < 0) {
    4e48:	f8840593          	addi	a1,s0,-120
    4e4c:	00003517          	auipc	a0,0x3
    4e50:	f7450513          	addi	a0,a0,-140 # 7dc0 <malloc+0x2476>
    4e54:	4c2000ef          	jal	ra,5316 <stat>
    4e58:	06054763          	bltz	a0,4ec6 <linkoverflow+0x204>
    printf("%s: stat(/lof) failed\n", s);
    exit(1);
  }

  unlink("/lof");
    4e5c:	00003517          	auipc	a0,0x3
    4e60:	f6450513          	addi	a0,a0,-156 # 7dc0 <malloc+0x2476>
    4e64:	65e000ef          	jal	ra,54c2 <unlink>

  if (st.nlink < 0) {
    4e68:	f9241603          	lh	a2,-110(s0)
    4e6c:	06064763          	bltz	a2,4eda <linkoverflow+0x218>
    printf("%s: negative link count: %d\n", s, st.nlink);
    exit(1);
  }
}
    4e70:	60aa                	ld	ra,136(sp)
    4e72:	640a                	ld	s0,128(sp)
    4e74:	74e6                	ld	s1,120(sp)
    4e76:	7946                	ld	s2,112(sp)
    4e78:	79a6                	ld	s3,104(sp)
    4e7a:	7a06                	ld	s4,96(sp)
    4e7c:	6ae6                	ld	s5,88(sp)
    4e7e:	6b46                	ld	s6,80(sp)
    4e80:	6ba6                	ld	s7,72(sp)
    4e82:	6c06                	ld	s8,64(sp)
    4e84:	7ce2                	ld	s9,56(sp)
    4e86:	7d42                	ld	s10,48(sp)
    4e88:	6149                	addi	sp,sp,144
    4e8a:	8082                	ret
        printf("%s: stat(/lof) failed\n", s);
    4e8c:	85e6                	mv	a1,s9
    4e8e:	00003517          	auipc	a0,0x3
    4e92:	f6a50513          	addi	a0,a0,-150 # 7df8 <malloc+0x24ae>
    4e96:	201000ef          	jal	ra,5896 <printf>
        exit(1);
    4e9a:	4505                	li	a0,1
    4e9c:	5d6000ef          	jal	ra,5472 <exit>
      printf("%s: link failed after %d links (nlink=%d)\n", s, i, st.nlink);
    4ea0:	864a                	mv	a2,s2
    4ea2:	85e6                	mv	a1,s9
    4ea4:	00003517          	auipc	a0,0x3
    4ea8:	f6c50513          	addi	a0,a0,-148 # 7e10 <malloc+0x24c6>
    4eac:	1eb000ef          	jal	ra,5896 <printf>
      exit(1);
    4eb0:	4505                	li	a0,1
    4eb2:	5c0000ef          	jal	ra,5472 <exit>
      printf("%s: i=%d, pn=%s\n", s, i, pn);
    4eb6:	f7840693          	addi	a3,s0,-136
    4eba:	864a                	mv	a2,s2
    4ebc:	85e6                	mv	a1,s9
    4ebe:	856a                	mv	a0,s10
    4ec0:	1d7000ef          	jal	ra,5896 <printf>
    4ec4:	b5dd                	j	4daa <linkoverflow+0xe8>
    printf("%s: stat(/lof) failed\n", s);
    4ec6:	85e6                	mv	a1,s9
    4ec8:	00003517          	auipc	a0,0x3
    4ecc:	f3050513          	addi	a0,a0,-208 # 7df8 <malloc+0x24ae>
    4ed0:	1c7000ef          	jal	ra,5896 <printf>
    exit(1);
    4ed4:	4505                	li	a0,1
    4ed6:	59c000ef          	jal	ra,5472 <exit>
    printf("%s: negative link count: %d\n", s, st.nlink);
    4eda:	85e6                	mv	a1,s9
    4edc:	00003517          	auipc	a0,0x3
    4ee0:	f7c50513          	addi	a0,a0,-132 # 7e58 <malloc+0x250e>
    4ee4:	1b3000ef          	jal	ra,5896 <printf>
    exit(1);
    4ee8:	4505                	li	a0,1
    4eea:	588000ef          	jal	ra,5472 <exit>

0000000000004eee <run>:

// run each test in its own process. run returns 1 if child's exit()
// indicates success.
int
run(void f(char *), char *s)
{
    4eee:	7179                	addi	sp,sp,-48
    4ef0:	f406                	sd	ra,40(sp)
    4ef2:	f022                	sd	s0,32(sp)
    4ef4:	ec26                	sd	s1,24(sp)
    4ef6:	e84a                	sd	s2,16(sp)
    4ef8:	1800                	addi	s0,sp,48
    4efa:	84aa                	mv	s1,a0
    4efc:	892e                	mv	s2,a1
  int pid;
  int xstatus;

  printf("test %s: ", s);
    4efe:	00003517          	auipc	a0,0x3
    4f02:	f7a50513          	addi	a0,a0,-134 # 7e78 <malloc+0x252e>
    4f06:	191000ef          	jal	ra,5896 <printf>
  if ((pid = fork()) < 0) {
    4f0a:	560000ef          	jal	ra,546a <fork>
    4f0e:	02054a63          	bltz	a0,4f42 <run+0x54>
    printf("runtest: fork error\n");
    exit(1);
  }
  if (pid == 0) {
    4f12:	c129                	beqz	a0,4f54 <run+0x66>
    f(s);
    exit(0);
  } else {
    wait(&xstatus);
    4f14:	fdc40513          	addi	a0,s0,-36
    4f18:	562000ef          	jal	ra,547a <wait>
    if (xstatus != 0)
    4f1c:	fdc42783          	lw	a5,-36(s0)
    4f20:	cf9d                	beqz	a5,4f5e <run+0x70>
      printf("FAILED\n");
    4f22:	00003517          	auipc	a0,0x3
    4f26:	f7e50513          	addi	a0,a0,-130 # 7ea0 <malloc+0x2556>
    4f2a:	16d000ef          	jal	ra,5896 <printf>
    else
      printf("OK\n");
    return xstatus == 0;
    4f2e:	fdc42503          	lw	a0,-36(s0)
  }
}
    4f32:	00153513          	seqz	a0,a0
    4f36:	70a2                	ld	ra,40(sp)
    4f38:	7402                	ld	s0,32(sp)
    4f3a:	64e2                	ld	s1,24(sp)
    4f3c:	6942                	ld	s2,16(sp)
    4f3e:	6145                	addi	sp,sp,48
    4f40:	8082                	ret
    printf("runtest: fork error\n");
    4f42:	00003517          	auipc	a0,0x3
    4f46:	f4650513          	addi	a0,a0,-186 # 7e88 <malloc+0x253e>
    4f4a:	14d000ef          	jal	ra,5896 <printf>
    exit(1);
    4f4e:	4505                	li	a0,1
    4f50:	522000ef          	jal	ra,5472 <exit>
    f(s);
    4f54:	854a                	mv	a0,s2
    4f56:	9482                	jalr	s1
    exit(0);
    4f58:	4501                	li	a0,0
    4f5a:	518000ef          	jal	ra,5472 <exit>
      printf("OK\n");
    4f5e:	00003517          	auipc	a0,0x3
    4f62:	f4a50513          	addi	a0,a0,-182 # 7ea8 <malloc+0x255e>
    4f66:	131000ef          	jal	ra,5896 <printf>
    4f6a:	b7d1                	j	4f2e <run+0x40>

0000000000004f6c <runtests>:

int
runtests(struct test *tests, char *justone, int continuous)
{
    4f6c:	7139                	addi	sp,sp,-64
    4f6e:	fc06                	sd	ra,56(sp)
    4f70:	f822                	sd	s0,48(sp)
    4f72:	f426                	sd	s1,40(sp)
    4f74:	f04a                	sd	s2,32(sp)
    4f76:	ec4e                	sd	s3,24(sp)
    4f78:	e852                	sd	s4,16(sp)
    4f7a:	e456                	sd	s5,8(sp)
    4f7c:	0080                	addi	s0,sp,64
    4f7e:	84aa                	mv	s1,a0
  int ntests = 0;
  for (struct test *t = tests; t->s != 0; t++) {
    4f80:	6508                	ld	a0,8(a0)
    4f82:	c921                	beqz	a0,4fd2 <runtests+0x66>
    4f84:	892e                	mv	s2,a1
    4f86:	8a32                	mv	s4,a2
  int ntests = 0;
    4f88:	4981                	li	s3,0
    if ((justone == 0) || strcmp(t->s, justone) == 0) {
      ntests++;
      if (!run(t->f, t->s)) {
        if (continuous != 2) {
    4f8a:	4a89                	li	s5,2
    4f8c:	a021                	j	4f94 <runtests+0x28>
  for (struct test *t = tests; t->s != 0; t++) {
    4f8e:	04c1                	addi	s1,s1,16
    4f90:	6488                	ld	a0,8(s1)
    4f92:	c515                	beqz	a0,4fbe <runtests+0x52>
    if ((justone == 0) || strcmp(t->s, justone) == 0) {
    4f94:	00090663          	beqz	s2,4fa0 <runtests+0x34>
    4f98:	85ca                	mv	a1,s2
    4f9a:	270000ef          	jal	ra,520a <strcmp>
    4f9e:	f965                	bnez	a0,4f8e <runtests+0x22>
      ntests++;
    4fa0:	2985                	addiw	s3,s3,1
      if (!run(t->f, t->s)) {
    4fa2:	648c                	ld	a1,8(s1)
    4fa4:	6088                	ld	a0,0(s1)
    4fa6:	f49ff0ef          	jal	ra,4eee <run>
    4faa:	f175                	bnez	a0,4f8e <runtests+0x22>
        if (continuous != 2) {
    4fac:	ff5a01e3          	beq	s4,s5,4f8e <runtests+0x22>
          printf("SOME TESTS FAILED\n");
    4fb0:	00003517          	auipc	a0,0x3
    4fb4:	f0050513          	addi	a0,a0,-256 # 7eb0 <malloc+0x2566>
    4fb8:	0df000ef          	jal	ra,5896 <printf>
          return -1;
    4fbc:	59fd                	li	s3,-1
        }
      }
    }
  }
  return ntests;
}
    4fbe:	854e                	mv	a0,s3
    4fc0:	70e2                	ld	ra,56(sp)
    4fc2:	7442                	ld	s0,48(sp)
    4fc4:	74a2                	ld	s1,40(sp)
    4fc6:	7902                	ld	s2,32(sp)
    4fc8:	69e2                	ld	s3,24(sp)
    4fca:	6a42                	ld	s4,16(sp)
    4fcc:	6aa2                	ld	s5,8(sp)
    4fce:	6121                	addi	sp,sp,64
    4fd0:	8082                	ret
  int ntests = 0;
    4fd2:	4981                	li	s3,0
    4fd4:	b7ed                	j	4fbe <runtests+0x52>

0000000000004fd6 <countfree>:

// use sbrk() to count how many free physical memory pages there are.
int
countfree()
{
    4fd6:	7179                	addi	sp,sp,-48
    4fd8:	f406                	sd	ra,40(sp)
    4fda:	f022                	sd	s0,32(sp)
    4fdc:	ec26                	sd	s1,24(sp)
    4fde:	e84a                	sd	s2,16(sp)
    4fe0:	e44e                	sd	s3,8(sp)
    4fe2:	1800                	addi	s0,sp,48
  int n = 0;
  uint64 sz0 = (uint64)sbrk(0);
    4fe4:	4501                	li	a0,0
    4fe6:	458000ef          	jal	ra,543e <sbrk>
    4fea:	89aa                	mv	s3,a0
  int n = 0;
    4fec:	4481                	li	s1,0
  while (1) {
    char *a = sbrk(PGSIZE);
    if (a == SBRK_ERROR) {
    4fee:	597d                	li	s2,-1
    4ff0:	a011                	j	4ff4 <countfree+0x1e>
      break;
    }
    n += 1;
    4ff2:	2485                	addiw	s1,s1,1
    char *a = sbrk(PGSIZE);
    4ff4:	6505                	lui	a0,0x1
    4ff6:	448000ef          	jal	ra,543e <sbrk>
    if (a == SBRK_ERROR) {
    4ffa:	ff251ce3          	bne	a0,s2,4ff2 <countfree+0x1c>
  }
  sbrk(-((uint64)sbrk(0) - sz0));
    4ffe:	4501                	li	a0,0
    5000:	43e000ef          	jal	ra,543e <sbrk>
    5004:	40a9853b          	subw	a0,s3,a0
    5008:	436000ef          	jal	ra,543e <sbrk>
  return n;
}
    500c:	8526                	mv	a0,s1
    500e:	70a2                	ld	ra,40(sp)
    5010:	7402                	ld	s0,32(sp)
    5012:	64e2                	ld	s1,24(sp)
    5014:	6942                	ld	s2,16(sp)
    5016:	69a2                	ld	s3,8(sp)
    5018:	6145                	addi	sp,sp,48
    501a:	8082                	ret

000000000000501c <drivetests>:

int
drivetests(int quick, int continuous, char *justone)
{
    501c:	7159                	addi	sp,sp,-112
    501e:	f486                	sd	ra,104(sp)
    5020:	f0a2                	sd	s0,96(sp)
    5022:	eca6                	sd	s1,88(sp)
    5024:	e8ca                	sd	s2,80(sp)
    5026:	e4ce                	sd	s3,72(sp)
    5028:	e0d2                	sd	s4,64(sp)
    502a:	fc56                	sd	s5,56(sp)
    502c:	f85a                	sd	s6,48(sp)
    502e:	f45e                	sd	s7,40(sp)
    5030:	f062                	sd	s8,32(sp)
    5032:	ec66                	sd	s9,24(sp)
    5034:	e86a                	sd	s10,16(sp)
    5036:	e46e                	sd	s11,8(sp)
    5038:	1880                	addi	s0,sp,112
    503a:	8aaa                	mv	s5,a0
    503c:	89ae                	mv	s3,a1
    503e:	8a32                	mv	s4,a2
  do {
    printf("usertests starting\n");
    5040:	00003b97          	auipc	s7,0x3
    5044:	e88b8b93          	addi	s7,s7,-376 # 7ec8 <malloc+0x257e>
    int free0 = countfree();
    int free1 = 0;
    int ntests = 0;
    int n;
    n = runtests(quicktests, justone, continuous);
    5048:	00004b17          	auipc	s6,0x4
    504c:	fc8b0b13          	addi	s6,s6,-56 # 9010 <quicktests>
    if (n < 0) {
      if (continuous != 2) {
    5050:	4c09                	li	s8,2
      } else {
        ntests += n;
      }
    }
    if ((free1 = countfree()) < free0) {
      printf("FAILED -- lost some free pages %d (out of %d)\n", free1, free0);
    5052:	00003d17          	auipc	s10,0x3
    5056:	eaed0d13          	addi	s10,s10,-338 # 7f00 <malloc+0x25b6>
      n = runtests(slowtests, justone, continuous);
    505a:	00004c97          	auipc	s9,0x4
    505e:	406c8c93          	addi	s9,s9,1030 # 9460 <slowtests>
        printf("usertests slow tests starting\n");
    5062:	00003d97          	auipc	s11,0x3
    5066:	e7ed8d93          	addi	s11,s11,-386 # 7ee0 <malloc+0x2596>
    506a:	a835                	j	50a6 <drivetests+0x8a>
      if (continuous != 2) {
    506c:	09899a63          	bne	s3,s8,5100 <drivetests+0xe4>
    int ntests = 0;
    5070:	4481                	li	s1,0
    5072:	a881                	j	50c2 <drivetests+0xa6>
        printf("usertests slow tests starting\n");
    5074:	856e                	mv	a0,s11
    5076:	021000ef          	jal	ra,5896 <printf>
    507a:	a881                	j	50ca <drivetests+0xae>
        if (continuous != 2) {
    507c:	09899463          	bne	s3,s8,5104 <drivetests+0xe8>
    if ((free1 = countfree()) < free0) {
    5080:	f57ff0ef          	jal	ra,4fd6 <countfree>
    5084:	01255c63          	bge	a0,s2,509c <drivetests+0x80>
      printf("FAILED -- lost some free pages %d (out of %d)\n", free1, free0);
    5088:	864a                	mv	a2,s2
    508a:	85aa                	mv	a1,a0
    508c:	856a                	mv	a0,s10
    508e:	009000ef          	jal	ra,5896 <printf>
      if (continuous != 2) {
    5092:	a8a1                	j	50ea <drivetests+0xce>
    if ((free1 = countfree()) < free0) {
    5094:	f43ff0ef          	jal	ra,4fd6 <countfree>
    5098:	05254263          	blt	a0,s2,50dc <drivetests+0xc0>
        return 1;
      }
    }
    if (justone != 0 && ntests == 0) {
    509c:	000a0363          	beqz	s4,50a2 <drivetests+0x86>
    50a0:	c8a1                	beqz	s1,50f0 <drivetests+0xd4>
      printf("NO TESTS EXECUTED\n");
      return 1;
    }
  } while (continuous);
    50a2:	06098563          	beqz	s3,510c <drivetests+0xf0>
    printf("usertests starting\n");
    50a6:	855e                	mv	a0,s7
    50a8:	7ee000ef          	jal	ra,5896 <printf>
    int free0 = countfree();
    50ac:	f2bff0ef          	jal	ra,4fd6 <countfree>
    50b0:	892a                	mv	s2,a0
    n = runtests(quicktests, justone, continuous);
    50b2:	864e                	mv	a2,s3
    50b4:	85d2                	mv	a1,s4
    50b6:	855a                	mv	a0,s6
    50b8:	eb5ff0ef          	jal	ra,4f6c <runtests>
    50bc:	84aa                	mv	s1,a0
    if (n < 0) {
    50be:	fa0547e3          	bltz	a0,506c <drivetests+0x50>
    if (!quick) {
    50c2:	fc0a99e3          	bnez	s5,5094 <drivetests+0x78>
      if (justone == 0)
    50c6:	fa0a07e3          	beqz	s4,5074 <drivetests+0x58>
      n = runtests(slowtests, justone, continuous);
    50ca:	864e                	mv	a2,s3
    50cc:	85d2                	mv	a1,s4
    50ce:	8566                	mv	a0,s9
    50d0:	e9dff0ef          	jal	ra,4f6c <runtests>
      if (n < 0) {
    50d4:	fa0544e3          	bltz	a0,507c <drivetests+0x60>
        ntests += n;
    50d8:	9ca9                	addw	s1,s1,a0
    50da:	bf6d                	j	5094 <drivetests+0x78>
      printf("FAILED -- lost some free pages %d (out of %d)\n", free1, free0);
    50dc:	864a                	mv	a2,s2
    50de:	85aa                	mv	a1,a0
    50e0:	856a                	mv	a0,s10
    50e2:	7b4000ef          	jal	ra,5896 <printf>
      if (continuous != 2) {
    50e6:	03899163          	bne	s3,s8,5108 <drivetests+0xec>
    if (justone != 0 && ntests == 0) {
    50ea:	fa0a0ee3          	beqz	s4,50a6 <drivetests+0x8a>
    50ee:	fcc5                	bnez	s1,50a6 <drivetests+0x8a>
      printf("NO TESTS EXECUTED\n");
    50f0:	00003517          	auipc	a0,0x3
    50f4:	e4050513          	addi	a0,a0,-448 # 7f30 <malloc+0x25e6>
    50f8:	79e000ef          	jal	ra,5896 <printf>
      return 1;
    50fc:	4505                	li	a0,1
    50fe:	a801                	j	510e <drivetests+0xf2>
        return 1;
    5100:	4505                	li	a0,1
    5102:	a031                	j	510e <drivetests+0xf2>
          return 1;
    5104:	4505                	li	a0,1
    5106:	a021                	j	510e <drivetests+0xf2>
        return 1;
    5108:	4505                	li	a0,1
    510a:	a011                	j	510e <drivetests+0xf2>
  return 0;
    510c:	854e                	mv	a0,s3
}
    510e:	70a6                	ld	ra,104(sp)
    5110:	7406                	ld	s0,96(sp)
    5112:	64e6                	ld	s1,88(sp)
    5114:	6946                	ld	s2,80(sp)
    5116:	69a6                	ld	s3,72(sp)
    5118:	6a06                	ld	s4,64(sp)
    511a:	7ae2                	ld	s5,56(sp)
    511c:	7b42                	ld	s6,48(sp)
    511e:	7ba2                	ld	s7,40(sp)
    5120:	7c02                	ld	s8,32(sp)
    5122:	6ce2                	ld	s9,24(sp)
    5124:	6d42                	ld	s10,16(sp)
    5126:	6da2                	ld	s11,8(sp)
    5128:	6165                	addi	sp,sp,112
    512a:	8082                	ret

000000000000512c <main>:

int
main(int argc, char *argv[])
{
    512c:	1101                	addi	sp,sp,-32
    512e:	ec06                	sd	ra,24(sp)
    5130:	e822                	sd	s0,16(sp)
    5132:	e426                	sd	s1,8(sp)
    5134:	e04a                	sd	s2,0(sp)
    5136:	1000                	addi	s0,sp,32
    5138:	84aa                	mv	s1,a0
  int continuous = 0;
  int quick = 0;
  char *justone = 0;

  if (argc == 2 && strcmp(argv[1], "-q") == 0) {
    513a:	4789                	li	a5,2
    513c:	00f50e63          	beq	a0,a5,5158 <main+0x2c>
    continuous = 1;
  } else if (argc == 2 && strcmp(argv[1], "-C") == 0) {
    continuous = 2;
  } else if (argc == 2 && argv[1][0] != '-') {
    justone = argv[1];
  } else if (argc > 1) {
    5140:	4785                	li	a5,1
    5142:	06a7c363          	blt	a5,a0,51a8 <main+0x7c>
  char *justone = 0;
    5146:	4601                	li	a2,0
  int quick = 0;
    5148:	4501                	li	a0,0
  int continuous = 0;
    514a:	4581                	li	a1,0
    printf("Usage: usertests [-c] [-C] [-q] [testname]\n");
    exit(1);
  }
  if (drivetests(quick, continuous, justone)) {
    514c:	ed1ff0ef          	jal	ra,501c <drivetests>
    5150:	cd35                	beqz	a0,51cc <main+0xa0>
    exit(1);
    5152:	4505                	li	a0,1
    5154:	31e000ef          	jal	ra,5472 <exit>
    5158:	892e                	mv	s2,a1
  if (argc == 2 && strcmp(argv[1], "-q") == 0) {
    515a:	00003597          	auipc	a1,0x3
    515e:	dee58593          	addi	a1,a1,-530 # 7f48 <malloc+0x25fe>
    5162:	00893503          	ld	a0,8(s2)
    5166:	0a4000ef          	jal	ra,520a <strcmp>
    516a:	85aa                	mv	a1,a0
    516c:	c539                	beqz	a0,51ba <main+0x8e>
  } else if (argc == 2 && strcmp(argv[1], "-c") == 0) {
    516e:	00003597          	auipc	a1,0x3
    5172:	e3258593          	addi	a1,a1,-462 # 7fa0 <malloc+0x2656>
    5176:	00893503          	ld	a0,8(s2)
    517a:	090000ef          	jal	ra,520a <strcmp>
    517e:	c521                	beqz	a0,51c6 <main+0x9a>
  } else if (argc == 2 && strcmp(argv[1], "-C") == 0) {
    5180:	00003597          	auipc	a1,0x3
    5184:	e1858593          	addi	a1,a1,-488 # 7f98 <malloc+0x264e>
    5188:	00893503          	ld	a0,8(s2)
    518c:	07e000ef          	jal	ra,520a <strcmp>
    5190:	c905                	beqz	a0,51c0 <main+0x94>
  } else if (argc == 2 && argv[1][0] != '-') {
    5192:	00893603          	ld	a2,8(s2)
    5196:	00064703          	lbu	a4,0(a2) # 1000 <badarg>
    519a:	02d00793          	li	a5,45
    519e:	00f70563          	beq	a4,a5,51a8 <main+0x7c>
  int quick = 0;
    51a2:	4501                	li	a0,0
  int continuous = 0;
    51a4:	4581                	li	a1,0
    51a6:	b75d                	j	514c <main+0x20>
    printf("Usage: usertests [-c] [-C] [-q] [testname]\n");
    51a8:	00003517          	auipc	a0,0x3
    51ac:	da850513          	addi	a0,a0,-600 # 7f50 <malloc+0x2606>
    51b0:	6e6000ef          	jal	ra,5896 <printf>
    exit(1);
    51b4:	4505                	li	a0,1
    51b6:	2bc000ef          	jal	ra,5472 <exit>
  char *justone = 0;
    51ba:	4601                	li	a2,0
    quick = 1;
    51bc:	4505                	li	a0,1
    51be:	b779                	j	514c <main+0x20>
    continuous = 2;
    51c0:	85a6                	mv	a1,s1
  char *justone = 0;
    51c2:	4601                	li	a2,0
    51c4:	b761                	j	514c <main+0x20>
    51c6:	4601                	li	a2,0
    continuous = 1;
    51c8:	4585                	li	a1,1
    51ca:	b749                	j	514c <main+0x20>
  }
  printf("ALL TESTS PASSED\n");
    51cc:	00003517          	auipc	a0,0x3
    51d0:	db450513          	addi	a0,a0,-588 # 7f80 <malloc+0x2636>
    51d4:	6c2000ef          	jal	ra,5896 <printf>
  exit(0);
    51d8:	4501                	li	a0,0
    51da:	298000ef          	jal	ra,5472 <exit>

00000000000051de <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
    51de:	1141                	addi	sp,sp,-16
    51e0:	e406                	sd	ra,8(sp)
    51e2:	e022                	sd	s0,0(sp)
    51e4:	0800                	addi	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
    51e6:	f47ff0ef          	jal	ra,512c <main>
  exit(r);
    51ea:	288000ef          	jal	ra,5472 <exit>

00000000000051ee <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
    51ee:	1141                	addi	sp,sp,-16
    51f0:	e422                	sd	s0,8(sp)
    51f2:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while ((*s++ = *t++) != 0)
    51f4:	87aa                	mv	a5,a0
    51f6:	0585                	addi	a1,a1,1
    51f8:	0785                	addi	a5,a5,1
    51fa:	fff5c703          	lbu	a4,-1(a1)
    51fe:	fee78fa3          	sb	a4,-1(a5)
    5202:	fb75                	bnez	a4,51f6 <strcpy+0x8>
    ;
  return os;
}
    5204:	6422                	ld	s0,8(sp)
    5206:	0141                	addi	sp,sp,16
    5208:	8082                	ret

000000000000520a <strcmp>:

int
strcmp(const char *p, const char *q)
{
    520a:	1141                	addi	sp,sp,-16
    520c:	e422                	sd	s0,8(sp)
    520e:	0800                	addi	s0,sp,16
  while (*p && *p == *q)
    5210:	00054783          	lbu	a5,0(a0)
    5214:	cb91                	beqz	a5,5228 <strcmp+0x1e>
    5216:	0005c703          	lbu	a4,0(a1)
    521a:	00f71763          	bne	a4,a5,5228 <strcmp+0x1e>
    p++, q++;
    521e:	0505                	addi	a0,a0,1
    5220:	0585                	addi	a1,a1,1
  while (*p && *p == *q)
    5222:	00054783          	lbu	a5,0(a0)
    5226:	fbe5                	bnez	a5,5216 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
    5228:	0005c503          	lbu	a0,0(a1)
}
    522c:	40a7853b          	subw	a0,a5,a0
    5230:	6422                	ld	s0,8(sp)
    5232:	0141                	addi	sp,sp,16
    5234:	8082                	ret

0000000000005236 <strlen>:

uint
strlen(const char *s)
{
    5236:	1141                	addi	sp,sp,-16
    5238:	e422                	sd	s0,8(sp)
    523a:	0800                	addi	s0,sp,16
  int n;

  for (n = 0; s[n]; n++)
    523c:	00054783          	lbu	a5,0(a0)
    5240:	cf91                	beqz	a5,525c <strlen+0x26>
    5242:	0505                	addi	a0,a0,1
    5244:	87aa                	mv	a5,a0
    5246:	4685                	li	a3,1
    5248:	9e89                	subw	a3,a3,a0
    524a:	00f6853b          	addw	a0,a3,a5
    524e:	0785                	addi	a5,a5,1
    5250:	fff7c703          	lbu	a4,-1(a5)
    5254:	fb7d                	bnez	a4,524a <strlen+0x14>
    ;
  return n;
}
    5256:	6422                	ld	s0,8(sp)
    5258:	0141                	addi	sp,sp,16
    525a:	8082                	ret
  for (n = 0; s[n]; n++)
    525c:	4501                	li	a0,0
    525e:	bfe5                	j	5256 <strlen+0x20>

0000000000005260 <memset>:

void *
memset(void *dst, int c, uint n)
{
    5260:	1141                	addi	sp,sp,-16
    5262:	e422                	sd	s0,8(sp)
    5264:	0800                	addi	s0,sp,16
  char *cdst = (char *)dst;
  int i;
  for (i = 0; i < n; i++) {
    5266:	ca19                	beqz	a2,527c <memset+0x1c>
    5268:	87aa                	mv	a5,a0
    526a:	1602                	slli	a2,a2,0x20
    526c:	9201                	srli	a2,a2,0x20
    526e:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    5272:	00b78023          	sb	a1,0(a5)
  for (i = 0; i < n; i++) {
    5276:	0785                	addi	a5,a5,1
    5278:	fee79de3          	bne	a5,a4,5272 <memset+0x12>
  }
  return dst;
}
    527c:	6422                	ld	s0,8(sp)
    527e:	0141                	addi	sp,sp,16
    5280:	8082                	ret

0000000000005282 <strchr>:

char *
strchr(const char *s, char c)
{
    5282:	1141                	addi	sp,sp,-16
    5284:	e422                	sd	s0,8(sp)
    5286:	0800                	addi	s0,sp,16
  for (; *s; s++)
    5288:	00054783          	lbu	a5,0(a0)
    528c:	cb99                	beqz	a5,52a2 <strchr+0x20>
    if (*s == c)
    528e:	00f58763          	beq	a1,a5,529c <strchr+0x1a>
  for (; *s; s++)
    5292:	0505                	addi	a0,a0,1
    5294:	00054783          	lbu	a5,0(a0)
    5298:	fbfd                	bnez	a5,528e <strchr+0xc>
      return (char *)s;
  return 0;
    529a:	4501                	li	a0,0
}
    529c:	6422                	ld	s0,8(sp)
    529e:	0141                	addi	sp,sp,16
    52a0:	8082                	ret
  return 0;
    52a2:	4501                	li	a0,0
    52a4:	bfe5                	j	529c <strchr+0x1a>

00000000000052a6 <gets>:

char *
gets(char *buf, int max)
{
    52a6:	711d                	addi	sp,sp,-96
    52a8:	ec86                	sd	ra,88(sp)
    52aa:	e8a2                	sd	s0,80(sp)
    52ac:	e4a6                	sd	s1,72(sp)
    52ae:	e0ca                	sd	s2,64(sp)
    52b0:	fc4e                	sd	s3,56(sp)
    52b2:	f852                	sd	s4,48(sp)
    52b4:	f456                	sd	s5,40(sp)
    52b6:	f05a                	sd	s6,32(sp)
    52b8:	ec5e                	sd	s7,24(sp)
    52ba:	1080                	addi	s0,sp,96
    52bc:	8baa                	mv	s7,a0
    52be:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for (i = 0; i + 1 < max;) {
    52c0:	892a                	mv	s2,a0
    52c2:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if (cc < 1)
      break;
    buf[i++] = c;
    if (c == '\n' || c == '\r')
    52c4:	4aa9                	li	s5,10
    52c6:	4b35                	li	s6,13
  for (i = 0; i + 1 < max;) {
    52c8:	89a6                	mv	s3,s1
    52ca:	2485                	addiw	s1,s1,1
    52cc:	0344d663          	bge	s1,s4,52f8 <gets+0x52>
    cc = read(0, &c, 1);
    52d0:	4605                	li	a2,1
    52d2:	faf40593          	addi	a1,s0,-81
    52d6:	4501                	li	a0,0
    52d8:	1b2000ef          	jal	ra,548a <read>
    if (cc < 1)
    52dc:	00a05e63          	blez	a0,52f8 <gets+0x52>
    buf[i++] = c;
    52e0:	faf44783          	lbu	a5,-81(s0)
    52e4:	00f90023          	sb	a5,0(s2)
    if (c == '\n' || c == '\r')
    52e8:	01578763          	beq	a5,s5,52f6 <gets+0x50>
    52ec:	0905                	addi	s2,s2,1
    52ee:	fd679de3          	bne	a5,s6,52c8 <gets+0x22>
  for (i = 0; i + 1 < max;) {
    52f2:	89a6                	mv	s3,s1
    52f4:	a011                	j	52f8 <gets+0x52>
    52f6:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
    52f8:	99de                	add	s3,s3,s7
    52fa:	00098023          	sb	zero,0(s3)
  return buf;
}
    52fe:	855e                	mv	a0,s7
    5300:	60e6                	ld	ra,88(sp)
    5302:	6446                	ld	s0,80(sp)
    5304:	64a6                	ld	s1,72(sp)
    5306:	6906                	ld	s2,64(sp)
    5308:	79e2                	ld	s3,56(sp)
    530a:	7a42                	ld	s4,48(sp)
    530c:	7aa2                	ld	s5,40(sp)
    530e:	7b02                	ld	s6,32(sp)
    5310:	6be2                	ld	s7,24(sp)
    5312:	6125                	addi	sp,sp,96
    5314:	8082                	ret

0000000000005316 <stat>:

int
stat(const char *n, struct stat *st)
{
    5316:	1101                	addi	sp,sp,-32
    5318:	ec06                	sd	ra,24(sp)
    531a:	e822                	sd	s0,16(sp)
    531c:	e426                	sd	s1,8(sp)
    531e:	e04a                	sd	s2,0(sp)
    5320:	1000                	addi	s0,sp,32
    5322:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    5324:	4581                	li	a1,0
    5326:	18c000ef          	jal	ra,54b2 <open>
  if (fd < 0)
    532a:	02054163          	bltz	a0,534c <stat+0x36>
    532e:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
    5330:	85ca                	mv	a1,s2
    5332:	198000ef          	jal	ra,54ca <fstat>
    5336:	892a                	mv	s2,a0
  close(fd);
    5338:	8526                	mv	a0,s1
    533a:	160000ef          	jal	ra,549a <close>
  return r;
}
    533e:	854a                	mv	a0,s2
    5340:	60e2                	ld	ra,24(sp)
    5342:	6442                	ld	s0,16(sp)
    5344:	64a2                	ld	s1,8(sp)
    5346:	6902                	ld	s2,0(sp)
    5348:	6105                	addi	sp,sp,32
    534a:	8082                	ret
    return -1;
    534c:	597d                	li	s2,-1
    534e:	bfc5                	j	533e <stat+0x28>

0000000000005350 <atoi>:

int
atoi(const char *s)
{
    5350:	1141                	addi	sp,sp,-16
    5352:	e422                	sd	s0,8(sp)
    5354:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while ('0' <= *s && *s <= '9')
    5356:	00054683          	lbu	a3,0(a0)
    535a:	fd06879b          	addiw	a5,a3,-48
    535e:	0ff7f793          	zext.b	a5,a5
    5362:	4625                	li	a2,9
    5364:	02f66863          	bltu	a2,a5,5394 <atoi+0x44>
    5368:	872a                	mv	a4,a0
  n = 0;
    536a:	4501                	li	a0,0
    n = n * 10 + *s++ - '0';
    536c:	0705                	addi	a4,a4,1 # 1000001 <base+0xff0309>
    536e:	0025179b          	slliw	a5,a0,0x2
    5372:	9fa9                	addw	a5,a5,a0
    5374:	0017979b          	slliw	a5,a5,0x1
    5378:	9fb5                	addw	a5,a5,a3
    537a:	fd07851b          	addiw	a0,a5,-48
  while ('0' <= *s && *s <= '9')
    537e:	00074683          	lbu	a3,0(a4)
    5382:	fd06879b          	addiw	a5,a3,-48
    5386:	0ff7f793          	zext.b	a5,a5
    538a:	fef671e3          	bgeu	a2,a5,536c <atoi+0x1c>
  return n;
}
    538e:	6422                	ld	s0,8(sp)
    5390:	0141                	addi	sp,sp,16
    5392:	8082                	ret
  n = 0;
    5394:	4501                	li	a0,0
    5396:	bfe5                	j	538e <atoi+0x3e>

0000000000005398 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
    5398:	1141                	addi	sp,sp,-16
    539a:	e422                	sd	s0,8(sp)
    539c:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
    539e:	02b57463          	bgeu	a0,a1,53c6 <memmove+0x2e>
    while (n-- > 0)
    53a2:	00c05f63          	blez	a2,53c0 <memmove+0x28>
    53a6:	1602                	slli	a2,a2,0x20
    53a8:	9201                	srli	a2,a2,0x20
    53aa:	00c507b3          	add	a5,a0,a2
  dst = vdst;
    53ae:	872a                	mv	a4,a0
      *dst++ = *src++;
    53b0:	0585                	addi	a1,a1,1
    53b2:	0705                	addi	a4,a4,1
    53b4:	fff5c683          	lbu	a3,-1(a1)
    53b8:	fed70fa3          	sb	a3,-1(a4)
    while (n-- > 0)
    53bc:	fee79ae3          	bne	a5,a4,53b0 <memmove+0x18>
    src += n;
    while (n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
    53c0:	6422                	ld	s0,8(sp)
    53c2:	0141                	addi	sp,sp,16
    53c4:	8082                	ret
    dst += n;
    53c6:	00c50733          	add	a4,a0,a2
    src += n;
    53ca:	95b2                	add	a1,a1,a2
    while (n-- > 0)
    53cc:	fec05ae3          	blez	a2,53c0 <memmove+0x28>
    53d0:	fff6079b          	addiw	a5,a2,-1
    53d4:	1782                	slli	a5,a5,0x20
    53d6:	9381                	srli	a5,a5,0x20
    53d8:	fff7c793          	not	a5,a5
    53dc:	97ba                	add	a5,a5,a4
      *--dst = *--src;
    53de:	15fd                	addi	a1,a1,-1
    53e0:	177d                	addi	a4,a4,-1
    53e2:	0005c683          	lbu	a3,0(a1)
    53e6:	00d70023          	sb	a3,0(a4)
    while (n-- > 0)
    53ea:	fee79ae3          	bne	a5,a4,53de <memmove+0x46>
    53ee:	bfc9                	j	53c0 <memmove+0x28>

00000000000053f0 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    53f0:	1141                	addi	sp,sp,-16
    53f2:	e422                	sd	s0,8(sp)
    53f4:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
    53f6:	ca05                	beqz	a2,5426 <memcmp+0x36>
    53f8:	fff6069b          	addiw	a3,a2,-1
    53fc:	1682                	slli	a3,a3,0x20
    53fe:	9281                	srli	a3,a3,0x20
    5400:	0685                	addi	a3,a3,1
    5402:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
    5404:	00054783          	lbu	a5,0(a0)
    5408:	0005c703          	lbu	a4,0(a1)
    540c:	00e79863          	bne	a5,a4,541c <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
    5410:	0505                	addi	a0,a0,1
    p2++;
    5412:	0585                	addi	a1,a1,1
  while (n-- > 0) {
    5414:	fed518e3          	bne	a0,a3,5404 <memcmp+0x14>
  }
  return 0;
    5418:	4501                	li	a0,0
    541a:	a019                	j	5420 <memcmp+0x30>
      return *p1 - *p2;
    541c:	40e7853b          	subw	a0,a5,a4
}
    5420:	6422                	ld	s0,8(sp)
    5422:	0141                	addi	sp,sp,16
    5424:	8082                	ret
  return 0;
    5426:	4501                	li	a0,0
    5428:	bfe5                	j	5420 <memcmp+0x30>

000000000000542a <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    542a:	1141                	addi	sp,sp,-16
    542c:	e406                	sd	ra,8(sp)
    542e:	e022                	sd	s0,0(sp)
    5430:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    5432:	f67ff0ef          	jal	ra,5398 <memmove>
}
    5436:	60a2                	ld	ra,8(sp)
    5438:	6402                	ld	s0,0(sp)
    543a:	0141                	addi	sp,sp,16
    543c:	8082                	ret

000000000000543e <sbrk>:

char *
sbrk(int n)
{
    543e:	1141                	addi	sp,sp,-16
    5440:	e406                	sd	ra,8(sp)
    5442:	e022                	sd	s0,0(sp)
    5444:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
    5446:	4585                	li	a1,1
    5448:	0b2000ef          	jal	ra,54fa <sys_sbrk>
}
    544c:	60a2                	ld	ra,8(sp)
    544e:	6402                	ld	s0,0(sp)
    5450:	0141                	addi	sp,sp,16
    5452:	8082                	ret

0000000000005454 <sbrklazy>:

char *
sbrklazy(int n)
{
    5454:	1141                	addi	sp,sp,-16
    5456:	e406                	sd	ra,8(sp)
    5458:	e022                	sd	s0,0(sp)
    545a:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
    545c:	4589                	li	a1,2
    545e:	09c000ef          	jal	ra,54fa <sys_sbrk>
}
    5462:	60a2                	ld	ra,8(sp)
    5464:	6402                	ld	s0,0(sp)
    5466:	0141                	addi	sp,sp,16
    5468:	8082                	ret

000000000000546a <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    546a:	4885                	li	a7,1
 ecall
    546c:	00000073          	ecall
 ret
    5470:	8082                	ret

0000000000005472 <exit>:
.global exit
exit:
 li a7, SYS_exit
    5472:	4889                	li	a7,2
 ecall
    5474:	00000073          	ecall
 ret
    5478:	8082                	ret

000000000000547a <wait>:
.global wait
wait:
 li a7, SYS_wait
    547a:	488d                	li	a7,3
 ecall
    547c:	00000073          	ecall
 ret
    5480:	8082                	ret

0000000000005482 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    5482:	4891                	li	a7,4
 ecall
    5484:	00000073          	ecall
 ret
    5488:	8082                	ret

000000000000548a <read>:
.global read
read:
 li a7, SYS_read
    548a:	4895                	li	a7,5
 ecall
    548c:	00000073          	ecall
 ret
    5490:	8082                	ret

0000000000005492 <write>:
.global write
write:
 li a7, SYS_write
    5492:	48c1                	li	a7,16
 ecall
    5494:	00000073          	ecall
 ret
    5498:	8082                	ret

000000000000549a <close>:
.global close
close:
 li a7, SYS_close
    549a:	48d5                	li	a7,21
 ecall
    549c:	00000073          	ecall
 ret
    54a0:	8082                	ret

00000000000054a2 <kill>:
.global kill
kill:
 li a7, SYS_kill
    54a2:	4899                	li	a7,6
 ecall
    54a4:	00000073          	ecall
 ret
    54a8:	8082                	ret

00000000000054aa <exec>:
.global exec
exec:
 li a7, SYS_exec
    54aa:	489d                	li	a7,7
 ecall
    54ac:	00000073          	ecall
 ret
    54b0:	8082                	ret

00000000000054b2 <open>:
.global open
open:
 li a7, SYS_open
    54b2:	48bd                	li	a7,15
 ecall
    54b4:	00000073          	ecall
 ret
    54b8:	8082                	ret

00000000000054ba <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    54ba:	48c5                	li	a7,17
 ecall
    54bc:	00000073          	ecall
 ret
    54c0:	8082                	ret

00000000000054c2 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    54c2:	48c9                	li	a7,18
 ecall
    54c4:	00000073          	ecall
 ret
    54c8:	8082                	ret

00000000000054ca <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    54ca:	48a1                	li	a7,8
 ecall
    54cc:	00000073          	ecall
 ret
    54d0:	8082                	ret

00000000000054d2 <link>:
.global link
link:
 li a7, SYS_link
    54d2:	48cd                	li	a7,19
 ecall
    54d4:	00000073          	ecall
 ret
    54d8:	8082                	ret

00000000000054da <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    54da:	48d1                	li	a7,20
 ecall
    54dc:	00000073          	ecall
 ret
    54e0:	8082                	ret

00000000000054e2 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    54e2:	48a5                	li	a7,9
 ecall
    54e4:	00000073          	ecall
 ret
    54e8:	8082                	ret

00000000000054ea <dup>:
.global dup
dup:
 li a7, SYS_dup
    54ea:	48a9                	li	a7,10
 ecall
    54ec:	00000073          	ecall
 ret
    54f0:	8082                	ret

00000000000054f2 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    54f2:	48ad                	li	a7,11
 ecall
    54f4:	00000073          	ecall
 ret
    54f8:	8082                	ret

00000000000054fa <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
    54fa:	48b1                	li	a7,12
 ecall
    54fc:	00000073          	ecall
 ret
    5500:	8082                	ret

0000000000005502 <pause>:
.global pause
pause:
 li a7, SYS_pause
    5502:	48b5                	li	a7,13
 ecall
    5504:	00000073          	ecall
 ret
    5508:	8082                	ret

000000000000550a <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    550a:	48b9                	li	a7,14
 ecall
    550c:	00000073          	ecall
 ret
    5510:	8082                	ret

0000000000005512 <sync>:
.global sync
sync:
 li a7, SYS_sync
    5512:	48d9                	li	a7,22
 ecall
    5514:	00000073          	ecall
 ret
    5518:	8082                	ret

000000000000551a <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    551a:	1101                	addi	sp,sp,-32
    551c:	ec06                	sd	ra,24(sp)
    551e:	e822                	sd	s0,16(sp)
    5520:	1000                	addi	s0,sp,32
    5522:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    5526:	4605                	li	a2,1
    5528:	fef40593          	addi	a1,s0,-17
    552c:	f67ff0ef          	jal	ra,5492 <write>
}
    5530:	60e2                	ld	ra,24(sp)
    5532:	6442                	ld	s0,16(sp)
    5534:	6105                	addi	sp,sp,32
    5536:	8082                	ret

0000000000005538 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
    5538:	715d                	addi	sp,sp,-80
    553a:	e486                	sd	ra,72(sp)
    553c:	e0a2                	sd	s0,64(sp)
    553e:	fc26                	sd	s1,56(sp)
    5540:	f84a                	sd	s2,48(sp)
    5542:	f44e                	sd	s3,40(sp)
    5544:	0880                	addi	s0,sp,80
    5546:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if (sgn && xx < 0) {
    5548:	c299                	beqz	a3,554e <printint+0x16>
    554a:	0805c163          	bltz	a1,55cc <printint+0x94>
  neg = 0;
    554e:	4881                	li	a7,0
    5550:	fb840693          	addi	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
    5554:	4781                	li	a5,0
  do {
    buf[i++] = digits[x % base];
    5556:	00003517          	auipc	a0,0x3
    555a:	eb250513          	addi	a0,a0,-334 # 8408 <digits>
    555e:	883e                	mv	a6,a5
    5560:	2785                	addiw	a5,a5,1
    5562:	02c5f733          	remu	a4,a1,a2
    5566:	972a                	add	a4,a4,a0
    5568:	00074703          	lbu	a4,0(a4)
    556c:	00e68023          	sb	a4,0(a3)
  } while ((x /= base) != 0);
    5570:	872e                	mv	a4,a1
    5572:	02c5d5b3          	divu	a1,a1,a2
    5576:	0685                	addi	a3,a3,1
    5578:	fec773e3          	bgeu	a4,a2,555e <printint+0x26>
  if (neg)
    557c:	00088b63          	beqz	a7,5592 <printint+0x5a>
    buf[i++] = '-';
    5580:	fd078793          	addi	a5,a5,-48
    5584:	97a2                	add	a5,a5,s0
    5586:	02d00713          	li	a4,45
    558a:	fee78423          	sb	a4,-24(a5)
    558e:	0028079b          	addiw	a5,a6,2

  while (--i >= 0)
    5592:	02f05663          	blez	a5,55be <printint+0x86>
    5596:	fb840713          	addi	a4,s0,-72
    559a:	00f704b3          	add	s1,a4,a5
    559e:	fff70993          	addi	s3,a4,-1
    55a2:	99be                	add	s3,s3,a5
    55a4:	37fd                	addiw	a5,a5,-1
    55a6:	1782                	slli	a5,a5,0x20
    55a8:	9381                	srli	a5,a5,0x20
    55aa:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
    55ae:	fff4c583          	lbu	a1,-1(s1)
    55b2:	854a                	mv	a0,s2
    55b4:	f67ff0ef          	jal	ra,551a <putc>
  while (--i >= 0)
    55b8:	14fd                	addi	s1,s1,-1
    55ba:	ff349ae3          	bne	s1,s3,55ae <printint+0x76>
}
    55be:	60a6                	ld	ra,72(sp)
    55c0:	6406                	ld	s0,64(sp)
    55c2:	74e2                	ld	s1,56(sp)
    55c4:	7942                	ld	s2,48(sp)
    55c6:	79a2                	ld	s3,40(sp)
    55c8:	6161                	addi	sp,sp,80
    55ca:	8082                	ret
    x = -xx;
    55cc:	40b005b3          	neg	a1,a1
    neg = 1;
    55d0:	4885                	li	a7,1
    x = -xx;
    55d2:	bfbd                	j	5550 <printint+0x18>

00000000000055d4 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    55d4:	7119                	addi	sp,sp,-128
    55d6:	fc86                	sd	ra,120(sp)
    55d8:	f8a2                	sd	s0,112(sp)
    55da:	f4a6                	sd	s1,104(sp)
    55dc:	f0ca                	sd	s2,96(sp)
    55de:	ecce                	sd	s3,88(sp)
    55e0:	e8d2                	sd	s4,80(sp)
    55e2:	e4d6                	sd	s5,72(sp)
    55e4:	e0da                	sd	s6,64(sp)
    55e6:	fc5e                	sd	s7,56(sp)
    55e8:	f862                	sd	s8,48(sp)
    55ea:	f466                	sd	s9,40(sp)
    55ec:	f06a                	sd	s10,32(sp)
    55ee:	ec6e                	sd	s11,24(sp)
    55f0:	0100                	addi	s0,sp,128
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for (i = 0; fmt[i]; i++) {
    55f2:	0005c903          	lbu	s2,0(a1)
    55f6:	24090c63          	beqz	s2,584e <vprintf+0x27a>
    55fa:	8b2a                	mv	s6,a0
    55fc:	8a2e                	mv	s4,a1
    55fe:	8bb2                	mv	s7,a2
  state = 0;
    5600:	4981                	li	s3,0
  for (i = 0; fmt[i]; i++) {
    5602:	4481                	li	s1,0
    5604:	4701                	li	a4,0
      if (c0 == '%') {
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if (state == '%') {
    5606:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if (c0)
        c1 = fmt[i + 1] & 0xff;
      if (c1)
        c2 = fmt[i + 2] & 0xff;
      if (c0 == 'd') {
    560a:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if (c0 == 'l' && c1 == 'd') {
    560e:	06c00d13          	li	s10,108
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'd') {
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if (c0 == 'u') {
    5612:	07500d93          	li	s11,117
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    5616:	00003c97          	auipc	s9,0x3
    561a:	df2c8c93          	addi	s9,s9,-526 # 8408 <digits>
    561e:	a005                	j	563e <vprintf+0x6a>
        putc(fd, c0);
    5620:	85ca                	mv	a1,s2
    5622:	855a                	mv	a0,s6
    5624:	ef7ff0ef          	jal	ra,551a <putc>
    5628:	a019                	j	562e <vprintf+0x5a>
    } else if (state == '%') {
    562a:	03598263          	beq	s3,s5,564e <vprintf+0x7a>
  for (i = 0; fmt[i]; i++) {
    562e:	2485                	addiw	s1,s1,1
    5630:	8726                	mv	a4,s1
    5632:	009a07b3          	add	a5,s4,s1
    5636:	0007c903          	lbu	s2,0(a5)
    563a:	20090a63          	beqz	s2,584e <vprintf+0x27a>
    c0 = fmt[i] & 0xff;
    563e:	0009079b          	sext.w	a5,s2
    if (state == 0) {
    5642:	fe0994e3          	bnez	s3,562a <vprintf+0x56>
      if (c0 == '%') {
    5646:	fd579de3          	bne	a5,s5,5620 <vprintf+0x4c>
        state = '%';
    564a:	89be                	mv	s3,a5
    564c:	b7cd                	j	562e <vprintf+0x5a>
      if (c0)
    564e:	c3c1                	beqz	a5,56ce <vprintf+0xfa>
        c1 = fmt[i + 1] & 0xff;
    5650:	00ea06b3          	add	a3,s4,a4
    5654:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
    5658:	8636                	mv	a2,a3
      if (c1)
    565a:	c681                	beqz	a3,5662 <vprintf+0x8e>
        c2 = fmt[i + 2] & 0xff;
    565c:	9752                	add	a4,a4,s4
    565e:	00274603          	lbu	a2,2(a4)
      if (c0 == 'd') {
    5662:	03878e63          	beq	a5,s8,569e <vprintf+0xca>
      } else if (c0 == 'l' && c1 == 'd') {
    5666:	05a78863          	beq	a5,s10,56b6 <vprintf+0xe2>
      } else if (c0 == 'u') {
    566a:	0db78b63          	beq	a5,s11,5740 <vprintf+0x16c>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'u') {
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if (c0 == 'x') {
    566e:	07800713          	li	a4,120
    5672:	10e78d63          	beq	a5,a4,578c <vprintf+0x1b8>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'x') {
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if (c0 == 'p') {
    5676:	07000713          	li	a4,112
    567a:	14e78263          	beq	a5,a4,57be <vprintf+0x1ea>
        printptr(fd, va_arg(ap, uint64));
      } else if (c0 == 'c') {
    567e:	06300713          	li	a4,99
    5682:	16e78f63          	beq	a5,a4,5800 <vprintf+0x22c>
        putc(fd, va_arg(ap, uint32));
      } else if (c0 == 's') {
    5686:	07300713          	li	a4,115
    568a:	18e78563          	beq	a5,a4,5814 <vprintf+0x240>
        if ((s = va_arg(ap, char *)) == 0)
          s = "(null)";
        for (; *s; s++)
          putc(fd, *s);
      } else if (c0 == '%') {
    568e:	05579063          	bne	a5,s5,56ce <vprintf+0xfa>
        putc(fd, '%');
    5692:	85d6                	mv	a1,s5
    5694:	855a                	mv	a0,s6
    5696:	e85ff0ef          	jal	ra,551a <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
    569a:	4981                	li	s3,0
    569c:	bf49                	j	562e <vprintf+0x5a>
        printint(fd, va_arg(ap, int), 10, 1);
    569e:	008b8913          	addi	s2,s7,8
    56a2:	4685                	li	a3,1
    56a4:	4629                	li	a2,10
    56a6:	000ba583          	lw	a1,0(s7)
    56aa:	855a                	mv	a0,s6
    56ac:	e8dff0ef          	jal	ra,5538 <printint>
    56b0:	8bca                	mv	s7,s2
      state = 0;
    56b2:	4981                	li	s3,0
    56b4:	bfad                	j	562e <vprintf+0x5a>
      } else if (c0 == 'l' && c1 == 'd') {
    56b6:	03868663          	beq	a3,s8,56e2 <vprintf+0x10e>
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'd') {
    56ba:	05a68163          	beq	a3,s10,56fc <vprintf+0x128>
      } else if (c0 == 'l' && c1 == 'u') {
    56be:	09b68d63          	beq	a3,s11,5758 <vprintf+0x184>
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'u') {
    56c2:	03a68f63          	beq	a3,s10,5700 <vprintf+0x12c>
      } else if (c0 == 'l' && c1 == 'x') {
    56c6:	07800793          	li	a5,120
    56ca:	0cf68d63          	beq	a3,a5,57a4 <vprintf+0x1d0>
        putc(fd, '%');
    56ce:	85d6                	mv	a1,s5
    56d0:	855a                	mv	a0,s6
    56d2:	e49ff0ef          	jal	ra,551a <putc>
        putc(fd, c0);
    56d6:	85ca                	mv	a1,s2
    56d8:	855a                	mv	a0,s6
    56da:	e41ff0ef          	jal	ra,551a <putc>
      state = 0;
    56de:	4981                	li	s3,0
    56e0:	b7b9                	j	562e <vprintf+0x5a>
        printint(fd, va_arg(ap, uint64), 10, 1);
    56e2:	008b8913          	addi	s2,s7,8
    56e6:	4685                	li	a3,1
    56e8:	4629                	li	a2,10
    56ea:	000bb583          	ld	a1,0(s7)
    56ee:	855a                	mv	a0,s6
    56f0:	e49ff0ef          	jal	ra,5538 <printint>
        i += 1;
    56f4:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
    56f6:	8bca                	mv	s7,s2
      state = 0;
    56f8:	4981                	li	s3,0
        i += 1;
    56fa:	bf15                	j	562e <vprintf+0x5a>
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'd') {
    56fc:	03860563          	beq	a2,s8,5726 <vprintf+0x152>
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'u') {
    5700:	07b60963          	beq	a2,s11,5772 <vprintf+0x19e>
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'x') {
    5704:	07800793          	li	a5,120
    5708:	fcf613e3          	bne	a2,a5,56ce <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
    570c:	008b8913          	addi	s2,s7,8
    5710:	4681                	li	a3,0
    5712:	4641                	li	a2,16
    5714:	000bb583          	ld	a1,0(s7)
    5718:	855a                	mv	a0,s6
    571a:	e1fff0ef          	jal	ra,5538 <printint>
        i += 2;
    571e:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
    5720:	8bca                	mv	s7,s2
      state = 0;
    5722:	4981                	li	s3,0
        i += 2;
    5724:	b729                	j	562e <vprintf+0x5a>
        printint(fd, va_arg(ap, uint64), 10, 1);
    5726:	008b8913          	addi	s2,s7,8
    572a:	4685                	li	a3,1
    572c:	4629                	li	a2,10
    572e:	000bb583          	ld	a1,0(s7)
    5732:	855a                	mv	a0,s6
    5734:	e05ff0ef          	jal	ra,5538 <printint>
        i += 2;
    5738:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
    573a:	8bca                	mv	s7,s2
      state = 0;
    573c:	4981                	li	s3,0
        i += 2;
    573e:	bdc5                	j	562e <vprintf+0x5a>
        printint(fd, va_arg(ap, uint32), 10, 0);
    5740:	008b8913          	addi	s2,s7,8
    5744:	4681                	li	a3,0
    5746:	4629                	li	a2,10
    5748:	000be583          	lwu	a1,0(s7)
    574c:	855a                	mv	a0,s6
    574e:	debff0ef          	jal	ra,5538 <printint>
    5752:	8bca                	mv	s7,s2
      state = 0;
    5754:	4981                	li	s3,0
    5756:	bde1                	j	562e <vprintf+0x5a>
        printint(fd, va_arg(ap, uint64), 10, 0);
    5758:	008b8913          	addi	s2,s7,8
    575c:	4681                	li	a3,0
    575e:	4629                	li	a2,10
    5760:	000bb583          	ld	a1,0(s7)
    5764:	855a                	mv	a0,s6
    5766:	dd3ff0ef          	jal	ra,5538 <printint>
        i += 1;
    576a:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
    576c:	8bca                	mv	s7,s2
      state = 0;
    576e:	4981                	li	s3,0
        i += 1;
    5770:	bd7d                	j	562e <vprintf+0x5a>
        printint(fd, va_arg(ap, uint64), 10, 0);
    5772:	008b8913          	addi	s2,s7,8
    5776:	4681                	li	a3,0
    5778:	4629                	li	a2,10
    577a:	000bb583          	ld	a1,0(s7)
    577e:	855a                	mv	a0,s6
    5780:	db9ff0ef          	jal	ra,5538 <printint>
        i += 2;
    5784:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
    5786:	8bca                	mv	s7,s2
      state = 0;
    5788:	4981                	li	s3,0
        i += 2;
    578a:	b555                	j	562e <vprintf+0x5a>
        printint(fd, va_arg(ap, uint32), 16, 0);
    578c:	008b8913          	addi	s2,s7,8
    5790:	4681                	li	a3,0
    5792:	4641                	li	a2,16
    5794:	000be583          	lwu	a1,0(s7)
    5798:	855a                	mv	a0,s6
    579a:	d9fff0ef          	jal	ra,5538 <printint>
    579e:	8bca                	mv	s7,s2
      state = 0;
    57a0:	4981                	li	s3,0
    57a2:	b571                	j	562e <vprintf+0x5a>
        printint(fd, va_arg(ap, uint64), 16, 0);
    57a4:	008b8913          	addi	s2,s7,8
    57a8:	4681                	li	a3,0
    57aa:	4641                	li	a2,16
    57ac:	000bb583          	ld	a1,0(s7)
    57b0:	855a                	mv	a0,s6
    57b2:	d87ff0ef          	jal	ra,5538 <printint>
        i += 1;
    57b6:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
    57b8:	8bca                	mv	s7,s2
      state = 0;
    57ba:	4981                	li	s3,0
        i += 1;
    57bc:	bd8d                	j	562e <vprintf+0x5a>
        printptr(fd, va_arg(ap, uint64));
    57be:	008b8793          	addi	a5,s7,8
    57c2:	f8f43423          	sd	a5,-120(s0)
    57c6:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
    57ca:	03000593          	li	a1,48
    57ce:	855a                	mv	a0,s6
    57d0:	d4bff0ef          	jal	ra,551a <putc>
  putc(fd, 'x');
    57d4:	07800593          	li	a1,120
    57d8:	855a                	mv	a0,s6
    57da:	d41ff0ef          	jal	ra,551a <putc>
    57de:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    57e0:	03c9d793          	srli	a5,s3,0x3c
    57e4:	97e6                	add	a5,a5,s9
    57e6:	0007c583          	lbu	a1,0(a5)
    57ea:	855a                	mv	a0,s6
    57ec:	d2fff0ef          	jal	ra,551a <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    57f0:	0992                	slli	s3,s3,0x4
    57f2:	397d                	addiw	s2,s2,-1
    57f4:	fe0916e3          	bnez	s2,57e0 <vprintf+0x20c>
        printptr(fd, va_arg(ap, uint64));
    57f8:	f8843b83          	ld	s7,-120(s0)
      state = 0;
    57fc:	4981                	li	s3,0
    57fe:	bd05                	j	562e <vprintf+0x5a>
        putc(fd, va_arg(ap, uint32));
    5800:	008b8913          	addi	s2,s7,8
    5804:	000bc583          	lbu	a1,0(s7)
    5808:	855a                	mv	a0,s6
    580a:	d11ff0ef          	jal	ra,551a <putc>
    580e:	8bca                	mv	s7,s2
      state = 0;
    5810:	4981                	li	s3,0
    5812:	bd31                	j	562e <vprintf+0x5a>
        if ((s = va_arg(ap, char *)) == 0)
    5814:	008b8993          	addi	s3,s7,8
    5818:	000bb903          	ld	s2,0(s7)
    581c:	00090f63          	beqz	s2,583a <vprintf+0x266>
        for (; *s; s++)
    5820:	00094583          	lbu	a1,0(s2)
    5824:	c195                	beqz	a1,5848 <vprintf+0x274>
          putc(fd, *s);
    5826:	855a                	mv	a0,s6
    5828:	cf3ff0ef          	jal	ra,551a <putc>
        for (; *s; s++)
    582c:	0905                	addi	s2,s2,1
    582e:	00094583          	lbu	a1,0(s2)
    5832:	f9f5                	bnez	a1,5826 <vprintf+0x252>
        if ((s = va_arg(ap, char *)) == 0)
    5834:	8bce                	mv	s7,s3
      state = 0;
    5836:	4981                	li	s3,0
    5838:	bbdd                	j	562e <vprintf+0x5a>
          s = "(null)";
    583a:	00003917          	auipc	s2,0x3
    583e:	bc690913          	addi	s2,s2,-1082 # 8400 <malloc+0x2ab6>
        for (; *s; s++)
    5842:	02800593          	li	a1,40
    5846:	b7c5                	j	5826 <vprintf+0x252>
        if ((s = va_arg(ap, char *)) == 0)
    5848:	8bce                	mv	s7,s3
      state = 0;
    584a:	4981                	li	s3,0
    584c:	b3cd                	j	562e <vprintf+0x5a>
    }
  }
}
    584e:	70e6                	ld	ra,120(sp)
    5850:	7446                	ld	s0,112(sp)
    5852:	74a6                	ld	s1,104(sp)
    5854:	7906                	ld	s2,96(sp)
    5856:	69e6                	ld	s3,88(sp)
    5858:	6a46                	ld	s4,80(sp)
    585a:	6aa6                	ld	s5,72(sp)
    585c:	6b06                	ld	s6,64(sp)
    585e:	7be2                	ld	s7,56(sp)
    5860:	7c42                	ld	s8,48(sp)
    5862:	7ca2                	ld	s9,40(sp)
    5864:	7d02                	ld	s10,32(sp)
    5866:	6de2                	ld	s11,24(sp)
    5868:	6109                	addi	sp,sp,128
    586a:	8082                	ret

000000000000586c <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    586c:	715d                	addi	sp,sp,-80
    586e:	ec06                	sd	ra,24(sp)
    5870:	e822                	sd	s0,16(sp)
    5872:	1000                	addi	s0,sp,32
    5874:	e010                	sd	a2,0(s0)
    5876:	e414                	sd	a3,8(s0)
    5878:	e818                	sd	a4,16(s0)
    587a:	ec1c                	sd	a5,24(s0)
    587c:	03043023          	sd	a6,32(s0)
    5880:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    5884:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    5888:	8622                	mv	a2,s0
    588a:	d4bff0ef          	jal	ra,55d4 <vprintf>
}
    588e:	60e2                	ld	ra,24(sp)
    5890:	6442                	ld	s0,16(sp)
    5892:	6161                	addi	sp,sp,80
    5894:	8082                	ret

0000000000005896 <printf>:

void
printf(const char *fmt, ...)
{
    5896:	711d                	addi	sp,sp,-96
    5898:	ec06                	sd	ra,24(sp)
    589a:	e822                	sd	s0,16(sp)
    589c:	1000                	addi	s0,sp,32
    589e:	e40c                	sd	a1,8(s0)
    58a0:	e810                	sd	a2,16(s0)
    58a2:	ec14                	sd	a3,24(s0)
    58a4:	f018                	sd	a4,32(s0)
    58a6:	f41c                	sd	a5,40(s0)
    58a8:	03043823          	sd	a6,48(s0)
    58ac:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    58b0:	00840613          	addi	a2,s0,8
    58b4:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    58b8:	85aa                	mv	a1,a0
    58ba:	4505                	li	a0,1
    58bc:	d19ff0ef          	jal	ra,55d4 <vprintf>
}
    58c0:	60e2                	ld	ra,24(sp)
    58c2:	6442                	ld	s0,16(sp)
    58c4:	6125                	addi	sp,sp,96
    58c6:	8082                	ret

00000000000058c8 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    58c8:	1141                	addi	sp,sp,-16
    58ca:	e422                	sd	s0,8(sp)
    58cc:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header *)ap - 1;
    58ce:	ff050693          	addi	a3,a0,-16
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    58d2:	00004797          	auipc	a5,0x4
    58d6:	bfe7b783          	ld	a5,-1026(a5) # 94d0 <freep>
    58da:	a02d                	j	5904 <free+0x3c>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if (bp + bp->s.size == p->s.ptr) {
    bp->s.size += p->s.ptr->s.size;
    58dc:	4618                	lw	a4,8(a2)
    58de:	9f2d                	addw	a4,a4,a1
    58e0:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    58e4:	6398                	ld	a4,0(a5)
    58e6:	6310                	ld	a2,0(a4)
    58e8:	a83d                	j	5926 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if (p + p->s.size == bp) {
    p->s.size += bp->s.size;
    58ea:	ff852703          	lw	a4,-8(a0)
    58ee:	9f31                	addw	a4,a4,a2
    58f0:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    58f2:	ff053683          	ld	a3,-16(a0)
    58f6:	a091                	j	593a <free+0x72>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    58f8:	6398                	ld	a4,0(a5)
    58fa:	00e7e463          	bltu	a5,a4,5902 <free+0x3a>
    58fe:	00e6ea63          	bltu	a3,a4,5912 <free+0x4a>
{
    5902:	87ba                	mv	a5,a4
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    5904:	fed7fae3          	bgeu	a5,a3,58f8 <free+0x30>
    5908:	6398                	ld	a4,0(a5)
    590a:	00e6e463          	bltu	a3,a4,5912 <free+0x4a>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    590e:	fee7eae3          	bltu	a5,a4,5902 <free+0x3a>
  if (bp + bp->s.size == p->s.ptr) {
    5912:	ff852583          	lw	a1,-8(a0)
    5916:	6390                	ld	a2,0(a5)
    5918:	02059813          	slli	a6,a1,0x20
    591c:	01c85713          	srli	a4,a6,0x1c
    5920:	9736                	add	a4,a4,a3
    5922:	fae60de3          	beq	a2,a4,58dc <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
    5926:	fec53823          	sd	a2,-16(a0)
  if (p + p->s.size == bp) {
    592a:	4790                	lw	a2,8(a5)
    592c:	02061593          	slli	a1,a2,0x20
    5930:	01c5d713          	srli	a4,a1,0x1c
    5934:	973e                	add	a4,a4,a5
    5936:	fae68ae3          	beq	a3,a4,58ea <free+0x22>
    p->s.ptr = bp->s.ptr;
    593a:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
    593c:	00004717          	auipc	a4,0x4
    5940:	b8f73a23          	sd	a5,-1132(a4) # 94d0 <freep>
}
    5944:	6422                	ld	s0,8(sp)
    5946:	0141                	addi	sp,sp,16
    5948:	8082                	ret

000000000000594a <malloc>:
  return freep;
}

void *
malloc(uint nbytes)
{
    594a:	7139                	addi	sp,sp,-64
    594c:	fc06                	sd	ra,56(sp)
    594e:	f822                	sd	s0,48(sp)
    5950:	f426                	sd	s1,40(sp)
    5952:	f04a                	sd	s2,32(sp)
    5954:	ec4e                	sd	s3,24(sp)
    5956:	e852                	sd	s4,16(sp)
    5958:	e456                	sd	s5,8(sp)
    595a:	e05a                	sd	s6,0(sp)
    595c:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
    595e:	02051493          	slli	s1,a0,0x20
    5962:	9081                	srli	s1,s1,0x20
    5964:	04bd                	addi	s1,s1,15
    5966:	8091                	srli	s1,s1,0x4
    5968:	0014899b          	addiw	s3,s1,1
    596c:	0485                	addi	s1,s1,1
  if ((prevp = freep) == 0) {
    596e:	00004517          	auipc	a0,0x4
    5972:	b6253503          	ld	a0,-1182(a0) # 94d0 <freep>
    5976:	c515                	beqz	a0,59a2 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
    5978:	611c                	ld	a5,0(a0)
    if (p->s.size >= nunits) {
    597a:	4798                	lw	a4,8(a5)
    597c:	02977f63          	bgeu	a4,s1,59ba <malloc+0x70>
    5980:	8a4e                	mv	s4,s3
    5982:	0009871b          	sext.w	a4,s3
    5986:	6685                	lui	a3,0x1
    5988:	00d77363          	bgeu	a4,a3,598e <malloc+0x44>
    598c:	6a05                	lui	s4,0x1
    598e:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    5992:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void *)(p + 1);
    }
    if (p == freep)
    5996:	00004917          	auipc	s2,0x4
    599a:	b3a90913          	addi	s2,s2,-1222 # 94d0 <freep>
  if (p == SBRK_ERROR)
    599e:	5afd                	li	s5,-1
    59a0:	a885                	j	5a10 <malloc+0xc6>
    base.s.ptr = freep = prevp = &base;
    59a2:	0000a797          	auipc	a5,0xa
    59a6:	35678793          	addi	a5,a5,854 # fcf8 <base>
    59aa:	00004717          	auipc	a4,0x4
    59ae:	b2f73323          	sd	a5,-1242(a4) # 94d0 <freep>
    59b2:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    59b4:	0007a423          	sw	zero,8(a5)
    if (p->s.size >= nunits) {
    59b8:	b7e1                	j	5980 <malloc+0x36>
      if (p->s.size == nunits)
    59ba:	02e48c63          	beq	s1,a4,59f2 <malloc+0xa8>
        p->s.size -= nunits;
    59be:	4137073b          	subw	a4,a4,s3
    59c2:	c798                	sw	a4,8(a5)
        p += p->s.size;
    59c4:	02071693          	slli	a3,a4,0x20
    59c8:	01c6d713          	srli	a4,a3,0x1c
    59cc:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    59ce:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    59d2:	00004717          	auipc	a4,0x4
    59d6:	aea73f23          	sd	a0,-1282(a4) # 94d0 <freep>
      return (void *)(p + 1);
    59da:	01078513          	addi	a0,a5,16
      if ((p = morecore(nunits)) == 0)
        return 0;
  }
}
    59de:	70e2                	ld	ra,56(sp)
    59e0:	7442                	ld	s0,48(sp)
    59e2:	74a2                	ld	s1,40(sp)
    59e4:	7902                	ld	s2,32(sp)
    59e6:	69e2                	ld	s3,24(sp)
    59e8:	6a42                	ld	s4,16(sp)
    59ea:	6aa2                	ld	s5,8(sp)
    59ec:	6b02                	ld	s6,0(sp)
    59ee:	6121                	addi	sp,sp,64
    59f0:	8082                	ret
        prevp->s.ptr = p->s.ptr;
    59f2:	6398                	ld	a4,0(a5)
    59f4:	e118                	sd	a4,0(a0)
    59f6:	bff1                	j	59d2 <malloc+0x88>
  hp->s.size = nu;
    59f8:	01652423          	sw	s6,8(a0)
  free((void *)(hp + 1));
    59fc:	0541                	addi	a0,a0,16
    59fe:	ecbff0ef          	jal	ra,58c8 <free>
  return freep;
    5a02:	00093503          	ld	a0,0(s2)
      if ((p = morecore(nunits)) == 0)
    5a06:	dd61                	beqz	a0,59de <malloc+0x94>
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
    5a08:	611c                	ld	a5,0(a0)
    if (p->s.size >= nunits) {
    5a0a:	4798                	lw	a4,8(a5)
    5a0c:	fa9777e3          	bgeu	a4,s1,59ba <malloc+0x70>
    if (p == freep)
    5a10:	00093703          	ld	a4,0(s2)
    5a14:	853e                	mv	a0,a5
    5a16:	fef719e3          	bne	a4,a5,5a08 <malloc+0xbe>
  p = sbrk(nu * sizeof(Header));
    5a1a:	8552                	mv	a0,s4
    5a1c:	a23ff0ef          	jal	ra,543e <sbrk>
  if (p == SBRK_ERROR)
    5a20:	fd551ce3          	bne	a0,s5,59f8 <malloc+0xae>
        return 0;
    5a24:	4501                	li	a0,0
    5a26:	bf65                	j	59de <malloc+0x94>
