
user/_contentiontest:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#define WORKERS 4
#define ROUNDS 40

int
main(void)
{
   0:	7139                	addi	sp,sp,-64
   2:	fc06                	sd	ra,56(sp)
   4:	f822                	sd	s0,48(sp)
   6:	f426                	sd	s1,40(sp)
   8:	f04a                	sd	s2,32(sp)
   a:	0080                	addi	s0,sp,64
   c:	4491                	li	s1,4
  int i;
  int status;

  for (i = 0; i < WORKERS; i++) {
    int pid = fork();
   e:	34c000ef          	jal	ra,35a <fork>
    if (pid < 0) {
  12:	04054163          	bltz	a0,54 <main+0x54>
      printf("contentiontest: fork failed\n");
      exit(1);
    }
    if (pid == 0) {
  16:	c921                	beqz	a0,66 <main+0x66>
  for (i = 0; i < WORKERS; i++) {
  18:	34fd                	addiw	s1,s1,-1
  1a:	f8f5                	bnez	s1,e <main+0xe>
      exit(0);
    }
  }

  for (i = 0; i < WORKERS; i++)
    wait(&status);
  1c:	fdc40513          	addi	a0,s0,-36
  20:	34a000ef          	jal	ra,36a <wait>
  24:	fdc40513          	addi	a0,s0,-36
  28:	342000ef          	jal	ra,36a <wait>
  2c:	fdc40513          	addi	a0,s0,-36
  30:	33a000ef          	jal	ra,36a <wait>
  34:	fdc40513          	addi	a0,s0,-36
  38:	332000ef          	jal	ra,36a <wait>
  printf("contentiontest: %d workers completed %d lock-heavy rounds\n", WORKERS, ROUNDS);
  3c:	02800613          	li	a2,40
  40:	4591                	li	a1,4
  42:	00001517          	auipc	a0,0x1
  46:	91e50513          	addi	a0,a0,-1762 # 960 <malloc+0x126>
  4a:	73c000ef          	jal	ra,786 <printf>
  exit(0);
  4e:	4501                	li	a0,0
  50:	312000ef          	jal	ra,362 <exit>
      printf("contentiontest: fork failed\n");
  54:	00001517          	auipc	a0,0x1
  58:	8cc50513          	addi	a0,a0,-1844 # 920 <malloc+0xe6>
  5c:	72a000ef          	jal	ra,786 <printf>
      exit(1);
  60:	4505                	li	a0,1
  62:	300000ef          	jal	ra,362 <exit>
  66:	02800493          	li	s1,40
        char ch = 'x';
  6a:	07800913          	li	s2,120
  6e:	fd2407a3          	sb	s2,-49(s0)
        if (pipe(fd) < 0) {
  72:	fd040513          	addi	a0,s0,-48
  76:	2fc000ef          	jal	ra,372 <pipe>
  7a:	04054163          	bltz	a0,bc <main+0xbc>
        write(fd[1], &ch, 1);
  7e:	4605                	li	a2,1
  80:	fcf40593          	addi	a1,s0,-49
  84:	fd442503          	lw	a0,-44(s0)
  88:	2fa000ef          	jal	ra,382 <write>
        read(fd[0], &ch, 1);
  8c:	4605                	li	a2,1
  8e:	fcf40593          	addi	a1,s0,-49
  92:	fd042503          	lw	a0,-48(s0)
  96:	2e4000ef          	jal	ra,37a <read>
        close(fd[0]);
  9a:	fd042503          	lw	a0,-48(s0)
  9e:	2ec000ef          	jal	ra,38a <close>
        close(fd[1]);
  a2:	fd442503          	lw	a0,-44(s0)
  a6:	2e4000ef          	jal	ra,38a <close>
        getpid();
  aa:	338000ef          	jal	ra,3e2 <getpid>
        uptime();
  ae:	34c000ef          	jal	ra,3fa <uptime>
      for (r = 0; r < ROUNDS; r++) {
  b2:	34fd                	addiw	s1,s1,-1
  b4:	fccd                	bnez	s1,6e <main+0x6e>
      exit(0);
  b6:	4501                	li	a0,0
  b8:	2aa000ef          	jal	ra,362 <exit>
          printf("contentiontest: pipe failed\n");
  bc:	00001517          	auipc	a0,0x1
  c0:	88450513          	addi	a0,a0,-1916 # 940 <malloc+0x106>
  c4:	6c2000ef          	jal	ra,786 <printf>
          exit(1);
  c8:	4505                	li	a0,1
  ca:	298000ef          	jal	ra,362 <exit>

00000000000000ce <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
  ce:	1141                	addi	sp,sp,-16
  d0:	e406                	sd	ra,8(sp)
  d2:	e022                	sd	s0,0(sp)
  d4:	0800                	addi	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
  d6:	f2bff0ef          	jal	ra,0 <main>
  exit(r);
  da:	288000ef          	jal	ra,362 <exit>

00000000000000de <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
  de:	1141                	addi	sp,sp,-16
  e0:	e422                	sd	s0,8(sp)
  e2:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while ((*s++ = *t++) != 0)
  e4:	87aa                	mv	a5,a0
  e6:	0585                	addi	a1,a1,1
  e8:	0785                	addi	a5,a5,1
  ea:	fff5c703          	lbu	a4,-1(a1)
  ee:	fee78fa3          	sb	a4,-1(a5)
  f2:	fb75                	bnez	a4,e6 <strcpy+0x8>
    ;
  return os;
}
  f4:	6422                	ld	s0,8(sp)
  f6:	0141                	addi	sp,sp,16
  f8:	8082                	ret

00000000000000fa <strcmp>:

int
strcmp(const char *p, const char *q)
{
  fa:	1141                	addi	sp,sp,-16
  fc:	e422                	sd	s0,8(sp)
  fe:	0800                	addi	s0,sp,16
  while (*p && *p == *q)
 100:	00054783          	lbu	a5,0(a0)
 104:	cb91                	beqz	a5,118 <strcmp+0x1e>
 106:	0005c703          	lbu	a4,0(a1)
 10a:	00f71763          	bne	a4,a5,118 <strcmp+0x1e>
    p++, q++;
 10e:	0505                	addi	a0,a0,1
 110:	0585                	addi	a1,a1,1
  while (*p && *p == *q)
 112:	00054783          	lbu	a5,0(a0)
 116:	fbe5                	bnez	a5,106 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 118:	0005c503          	lbu	a0,0(a1)
}
 11c:	40a7853b          	subw	a0,a5,a0
 120:	6422                	ld	s0,8(sp)
 122:	0141                	addi	sp,sp,16
 124:	8082                	ret

0000000000000126 <strlen>:

uint
strlen(const char *s)
{
 126:	1141                	addi	sp,sp,-16
 128:	e422                	sd	s0,8(sp)
 12a:	0800                	addi	s0,sp,16
  int n;

  for (n = 0; s[n]; n++)
 12c:	00054783          	lbu	a5,0(a0)
 130:	cf91                	beqz	a5,14c <strlen+0x26>
 132:	0505                	addi	a0,a0,1
 134:	87aa                	mv	a5,a0
 136:	4685                	li	a3,1
 138:	9e89                	subw	a3,a3,a0
 13a:	00f6853b          	addw	a0,a3,a5
 13e:	0785                	addi	a5,a5,1
 140:	fff7c703          	lbu	a4,-1(a5)
 144:	fb7d                	bnez	a4,13a <strlen+0x14>
    ;
  return n;
}
 146:	6422                	ld	s0,8(sp)
 148:	0141                	addi	sp,sp,16
 14a:	8082                	ret
  for (n = 0; s[n]; n++)
 14c:	4501                	li	a0,0
 14e:	bfe5                	j	146 <strlen+0x20>

0000000000000150 <memset>:

void *
memset(void *dst, int c, uint n)
{
 150:	1141                	addi	sp,sp,-16
 152:	e422                	sd	s0,8(sp)
 154:	0800                	addi	s0,sp,16
  char *cdst = (char *)dst;
  int i;
  for (i = 0; i < n; i++) {
 156:	ca19                	beqz	a2,16c <memset+0x1c>
 158:	87aa                	mv	a5,a0
 15a:	1602                	slli	a2,a2,0x20
 15c:	9201                	srli	a2,a2,0x20
 15e:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 162:	00b78023          	sb	a1,0(a5)
  for (i = 0; i < n; i++) {
 166:	0785                	addi	a5,a5,1
 168:	fee79de3          	bne	a5,a4,162 <memset+0x12>
  }
  return dst;
}
 16c:	6422                	ld	s0,8(sp)
 16e:	0141                	addi	sp,sp,16
 170:	8082                	ret

0000000000000172 <strchr>:

char *
strchr(const char *s, char c)
{
 172:	1141                	addi	sp,sp,-16
 174:	e422                	sd	s0,8(sp)
 176:	0800                	addi	s0,sp,16
  for (; *s; s++)
 178:	00054783          	lbu	a5,0(a0)
 17c:	cb99                	beqz	a5,192 <strchr+0x20>
    if (*s == c)
 17e:	00f58763          	beq	a1,a5,18c <strchr+0x1a>
  for (; *s; s++)
 182:	0505                	addi	a0,a0,1
 184:	00054783          	lbu	a5,0(a0)
 188:	fbfd                	bnez	a5,17e <strchr+0xc>
      return (char *)s;
  return 0;
 18a:	4501                	li	a0,0
}
 18c:	6422                	ld	s0,8(sp)
 18e:	0141                	addi	sp,sp,16
 190:	8082                	ret
  return 0;
 192:	4501                	li	a0,0
 194:	bfe5                	j	18c <strchr+0x1a>

0000000000000196 <gets>:

char *
gets(char *buf, int max)
{
 196:	711d                	addi	sp,sp,-96
 198:	ec86                	sd	ra,88(sp)
 19a:	e8a2                	sd	s0,80(sp)
 19c:	e4a6                	sd	s1,72(sp)
 19e:	e0ca                	sd	s2,64(sp)
 1a0:	fc4e                	sd	s3,56(sp)
 1a2:	f852                	sd	s4,48(sp)
 1a4:	f456                	sd	s5,40(sp)
 1a6:	f05a                	sd	s6,32(sp)
 1a8:	ec5e                	sd	s7,24(sp)
 1aa:	1080                	addi	s0,sp,96
 1ac:	8baa                	mv	s7,a0
 1ae:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for (i = 0; i + 1 < max;) {
 1b0:	892a                	mv	s2,a0
 1b2:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if (cc < 1)
      break;
    buf[i++] = c;
    if (c == '\n' || c == '\r')
 1b4:	4aa9                	li	s5,10
 1b6:	4b35                	li	s6,13
  for (i = 0; i + 1 < max;) {
 1b8:	89a6                	mv	s3,s1
 1ba:	2485                	addiw	s1,s1,1
 1bc:	0344d663          	bge	s1,s4,1e8 <gets+0x52>
    cc = read(0, &c, 1);
 1c0:	4605                	li	a2,1
 1c2:	faf40593          	addi	a1,s0,-81
 1c6:	4501                	li	a0,0
 1c8:	1b2000ef          	jal	ra,37a <read>
    if (cc < 1)
 1cc:	00a05e63          	blez	a0,1e8 <gets+0x52>
    buf[i++] = c;
 1d0:	faf44783          	lbu	a5,-81(s0)
 1d4:	00f90023          	sb	a5,0(s2)
    if (c == '\n' || c == '\r')
 1d8:	01578763          	beq	a5,s5,1e6 <gets+0x50>
 1dc:	0905                	addi	s2,s2,1
 1de:	fd679de3          	bne	a5,s6,1b8 <gets+0x22>
  for (i = 0; i + 1 < max;) {
 1e2:	89a6                	mv	s3,s1
 1e4:	a011                	j	1e8 <gets+0x52>
 1e6:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 1e8:	99de                	add	s3,s3,s7
 1ea:	00098023          	sb	zero,0(s3)
  return buf;
}
 1ee:	855e                	mv	a0,s7
 1f0:	60e6                	ld	ra,88(sp)
 1f2:	6446                	ld	s0,80(sp)
 1f4:	64a6                	ld	s1,72(sp)
 1f6:	6906                	ld	s2,64(sp)
 1f8:	79e2                	ld	s3,56(sp)
 1fa:	7a42                	ld	s4,48(sp)
 1fc:	7aa2                	ld	s5,40(sp)
 1fe:	7b02                	ld	s6,32(sp)
 200:	6be2                	ld	s7,24(sp)
 202:	6125                	addi	sp,sp,96
 204:	8082                	ret

0000000000000206 <stat>:

int
stat(const char *n, struct stat *st)
{
 206:	1101                	addi	sp,sp,-32
 208:	ec06                	sd	ra,24(sp)
 20a:	e822                	sd	s0,16(sp)
 20c:	e426                	sd	s1,8(sp)
 20e:	e04a                	sd	s2,0(sp)
 210:	1000                	addi	s0,sp,32
 212:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 214:	4581                	li	a1,0
 216:	18c000ef          	jal	ra,3a2 <open>
  if (fd < 0)
 21a:	02054163          	bltz	a0,23c <stat+0x36>
 21e:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 220:	85ca                	mv	a1,s2
 222:	198000ef          	jal	ra,3ba <fstat>
 226:	892a                	mv	s2,a0
  close(fd);
 228:	8526                	mv	a0,s1
 22a:	160000ef          	jal	ra,38a <close>
  return r;
}
 22e:	854a                	mv	a0,s2
 230:	60e2                	ld	ra,24(sp)
 232:	6442                	ld	s0,16(sp)
 234:	64a2                	ld	s1,8(sp)
 236:	6902                	ld	s2,0(sp)
 238:	6105                	addi	sp,sp,32
 23a:	8082                	ret
    return -1;
 23c:	597d                	li	s2,-1
 23e:	bfc5                	j	22e <stat+0x28>

0000000000000240 <atoi>:

int
atoi(const char *s)
{
 240:	1141                	addi	sp,sp,-16
 242:	e422                	sd	s0,8(sp)
 244:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while ('0' <= *s && *s <= '9')
 246:	00054683          	lbu	a3,0(a0)
 24a:	fd06879b          	addiw	a5,a3,-48
 24e:	0ff7f793          	zext.b	a5,a5
 252:	4625                	li	a2,9
 254:	02f66863          	bltu	a2,a5,284 <atoi+0x44>
 258:	872a                	mv	a4,a0
  n = 0;
 25a:	4501                	li	a0,0
    n = n * 10 + *s++ - '0';
 25c:	0705                	addi	a4,a4,1
 25e:	0025179b          	slliw	a5,a0,0x2
 262:	9fa9                	addw	a5,a5,a0
 264:	0017979b          	slliw	a5,a5,0x1
 268:	9fb5                	addw	a5,a5,a3
 26a:	fd07851b          	addiw	a0,a5,-48
  while ('0' <= *s && *s <= '9')
 26e:	00074683          	lbu	a3,0(a4)
 272:	fd06879b          	addiw	a5,a3,-48
 276:	0ff7f793          	zext.b	a5,a5
 27a:	fef671e3          	bgeu	a2,a5,25c <atoi+0x1c>
  return n;
}
 27e:	6422                	ld	s0,8(sp)
 280:	0141                	addi	sp,sp,16
 282:	8082                	ret
  n = 0;
 284:	4501                	li	a0,0
 286:	bfe5                	j	27e <atoi+0x3e>

0000000000000288 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 288:	1141                	addi	sp,sp,-16
 28a:	e422                	sd	s0,8(sp)
 28c:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 28e:	02b57463          	bgeu	a0,a1,2b6 <memmove+0x2e>
    while (n-- > 0)
 292:	00c05f63          	blez	a2,2b0 <memmove+0x28>
 296:	1602                	slli	a2,a2,0x20
 298:	9201                	srli	a2,a2,0x20
 29a:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 29e:	872a                	mv	a4,a0
      *dst++ = *src++;
 2a0:	0585                	addi	a1,a1,1
 2a2:	0705                	addi	a4,a4,1
 2a4:	fff5c683          	lbu	a3,-1(a1)
 2a8:	fed70fa3          	sb	a3,-1(a4)
    while (n-- > 0)
 2ac:	fee79ae3          	bne	a5,a4,2a0 <memmove+0x18>
    src += n;
    while (n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 2b0:	6422                	ld	s0,8(sp)
 2b2:	0141                	addi	sp,sp,16
 2b4:	8082                	ret
    dst += n;
 2b6:	00c50733          	add	a4,a0,a2
    src += n;
 2ba:	95b2                	add	a1,a1,a2
    while (n-- > 0)
 2bc:	fec05ae3          	blez	a2,2b0 <memmove+0x28>
 2c0:	fff6079b          	addiw	a5,a2,-1
 2c4:	1782                	slli	a5,a5,0x20
 2c6:	9381                	srli	a5,a5,0x20
 2c8:	fff7c793          	not	a5,a5
 2cc:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2ce:	15fd                	addi	a1,a1,-1
 2d0:	177d                	addi	a4,a4,-1
 2d2:	0005c683          	lbu	a3,0(a1)
 2d6:	00d70023          	sb	a3,0(a4)
    while (n-- > 0)
 2da:	fee79ae3          	bne	a5,a4,2ce <memmove+0x46>
 2de:	bfc9                	j	2b0 <memmove+0x28>

00000000000002e0 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2e0:	1141                	addi	sp,sp,-16
 2e2:	e422                	sd	s0,8(sp)
 2e4:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2e6:	ca05                	beqz	a2,316 <memcmp+0x36>
 2e8:	fff6069b          	addiw	a3,a2,-1
 2ec:	1682                	slli	a3,a3,0x20
 2ee:	9281                	srli	a3,a3,0x20
 2f0:	0685                	addi	a3,a3,1
 2f2:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 2f4:	00054783          	lbu	a5,0(a0)
 2f8:	0005c703          	lbu	a4,0(a1)
 2fc:	00e79863          	bne	a5,a4,30c <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 300:	0505                	addi	a0,a0,1
    p2++;
 302:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 304:	fed518e3          	bne	a0,a3,2f4 <memcmp+0x14>
  }
  return 0;
 308:	4501                	li	a0,0
 30a:	a019                	j	310 <memcmp+0x30>
      return *p1 - *p2;
 30c:	40e7853b          	subw	a0,a5,a4
}
 310:	6422                	ld	s0,8(sp)
 312:	0141                	addi	sp,sp,16
 314:	8082                	ret
  return 0;
 316:	4501                	li	a0,0
 318:	bfe5                	j	310 <memcmp+0x30>

000000000000031a <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 31a:	1141                	addi	sp,sp,-16
 31c:	e406                	sd	ra,8(sp)
 31e:	e022                	sd	s0,0(sp)
 320:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 322:	f67ff0ef          	jal	ra,288 <memmove>
}
 326:	60a2                	ld	ra,8(sp)
 328:	6402                	ld	s0,0(sp)
 32a:	0141                	addi	sp,sp,16
 32c:	8082                	ret

000000000000032e <sbrk>:

char *
sbrk(int n)
{
 32e:	1141                	addi	sp,sp,-16
 330:	e406                	sd	ra,8(sp)
 332:	e022                	sd	s0,0(sp)
 334:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 336:	4585                	li	a1,1
 338:	0b2000ef          	jal	ra,3ea <sys_sbrk>
}
 33c:	60a2                	ld	ra,8(sp)
 33e:	6402                	ld	s0,0(sp)
 340:	0141                	addi	sp,sp,16
 342:	8082                	ret

0000000000000344 <sbrklazy>:

char *
sbrklazy(int n)
{
 344:	1141                	addi	sp,sp,-16
 346:	e406                	sd	ra,8(sp)
 348:	e022                	sd	s0,0(sp)
 34a:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 34c:	4589                	li	a1,2
 34e:	09c000ef          	jal	ra,3ea <sys_sbrk>
}
 352:	60a2                	ld	ra,8(sp)
 354:	6402                	ld	s0,0(sp)
 356:	0141                	addi	sp,sp,16
 358:	8082                	ret

000000000000035a <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 35a:	4885                	li	a7,1
 ecall
 35c:	00000073          	ecall
 ret
 360:	8082                	ret

0000000000000362 <exit>:
.global exit
exit:
 li a7, SYS_exit
 362:	4889                	li	a7,2
 ecall
 364:	00000073          	ecall
 ret
 368:	8082                	ret

000000000000036a <wait>:
.global wait
wait:
 li a7, SYS_wait
 36a:	488d                	li	a7,3
 ecall
 36c:	00000073          	ecall
 ret
 370:	8082                	ret

0000000000000372 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 372:	4891                	li	a7,4
 ecall
 374:	00000073          	ecall
 ret
 378:	8082                	ret

000000000000037a <read>:
.global read
read:
 li a7, SYS_read
 37a:	4895                	li	a7,5
 ecall
 37c:	00000073          	ecall
 ret
 380:	8082                	ret

0000000000000382 <write>:
.global write
write:
 li a7, SYS_write
 382:	48c1                	li	a7,16
 ecall
 384:	00000073          	ecall
 ret
 388:	8082                	ret

000000000000038a <close>:
.global close
close:
 li a7, SYS_close
 38a:	48d5                	li	a7,21
 ecall
 38c:	00000073          	ecall
 ret
 390:	8082                	ret

0000000000000392 <kill>:
.global kill
kill:
 li a7, SYS_kill
 392:	4899                	li	a7,6
 ecall
 394:	00000073          	ecall
 ret
 398:	8082                	ret

000000000000039a <exec>:
.global exec
exec:
 li a7, SYS_exec
 39a:	489d                	li	a7,7
 ecall
 39c:	00000073          	ecall
 ret
 3a0:	8082                	ret

00000000000003a2 <open>:
.global open
open:
 li a7, SYS_open
 3a2:	48bd                	li	a7,15
 ecall
 3a4:	00000073          	ecall
 ret
 3a8:	8082                	ret

00000000000003aa <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3aa:	48c5                	li	a7,17
 ecall
 3ac:	00000073          	ecall
 ret
 3b0:	8082                	ret

00000000000003b2 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 3b2:	48c9                	li	a7,18
 ecall
 3b4:	00000073          	ecall
 ret
 3b8:	8082                	ret

00000000000003ba <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3ba:	48a1                	li	a7,8
 ecall
 3bc:	00000073          	ecall
 ret
 3c0:	8082                	ret

00000000000003c2 <link>:
.global link
link:
 li a7, SYS_link
 3c2:	48cd                	li	a7,19
 ecall
 3c4:	00000073          	ecall
 ret
 3c8:	8082                	ret

00000000000003ca <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3ca:	48d1                	li	a7,20
 ecall
 3cc:	00000073          	ecall
 ret
 3d0:	8082                	ret

00000000000003d2 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3d2:	48a5                	li	a7,9
 ecall
 3d4:	00000073          	ecall
 ret
 3d8:	8082                	ret

00000000000003da <dup>:
.global dup
dup:
 li a7, SYS_dup
 3da:	48a9                	li	a7,10
 ecall
 3dc:	00000073          	ecall
 ret
 3e0:	8082                	ret

00000000000003e2 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 3e2:	48ad                	li	a7,11
 ecall
 3e4:	00000073          	ecall
 ret
 3e8:	8082                	ret

00000000000003ea <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 3ea:	48b1                	li	a7,12
 ecall
 3ec:	00000073          	ecall
 ret
 3f0:	8082                	ret

00000000000003f2 <pause>:
.global pause
pause:
 li a7, SYS_pause
 3f2:	48b5                	li	a7,13
 ecall
 3f4:	00000073          	ecall
 ret
 3f8:	8082                	ret

00000000000003fa <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3fa:	48b9                	li	a7,14
 ecall
 3fc:	00000073          	ecall
 ret
 400:	8082                	ret

0000000000000402 <sync>:
.global sync
sync:
 li a7, SYS_sync
 402:	48d9                	li	a7,22
 ecall
 404:	00000073          	ecall
 ret
 408:	8082                	ret

000000000000040a <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 40a:	1101                	addi	sp,sp,-32
 40c:	ec06                	sd	ra,24(sp)
 40e:	e822                	sd	s0,16(sp)
 410:	1000                	addi	s0,sp,32
 412:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 416:	4605                	li	a2,1
 418:	fef40593          	addi	a1,s0,-17
 41c:	f67ff0ef          	jal	ra,382 <write>
}
 420:	60e2                	ld	ra,24(sp)
 422:	6442                	ld	s0,16(sp)
 424:	6105                	addi	sp,sp,32
 426:	8082                	ret

0000000000000428 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 428:	715d                	addi	sp,sp,-80
 42a:	e486                	sd	ra,72(sp)
 42c:	e0a2                	sd	s0,64(sp)
 42e:	fc26                	sd	s1,56(sp)
 430:	f84a                	sd	s2,48(sp)
 432:	f44e                	sd	s3,40(sp)
 434:	0880                	addi	s0,sp,80
 436:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if (sgn && xx < 0) {
 438:	c299                	beqz	a3,43e <printint+0x16>
 43a:	0805c163          	bltz	a1,4bc <printint+0x94>
  neg = 0;
 43e:	4881                	li	a7,0
 440:	fb840693          	addi	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 444:	4781                	li	a5,0
  do {
    buf[i++] = digits[x % base];
 446:	00000517          	auipc	a0,0x0
 44a:	56250513          	addi	a0,a0,1378 # 9a8 <digits>
 44e:	883e                	mv	a6,a5
 450:	2785                	addiw	a5,a5,1
 452:	02c5f733          	remu	a4,a1,a2
 456:	972a                	add	a4,a4,a0
 458:	00074703          	lbu	a4,0(a4)
 45c:	00e68023          	sb	a4,0(a3)
  } while ((x /= base) != 0);
 460:	872e                	mv	a4,a1
 462:	02c5d5b3          	divu	a1,a1,a2
 466:	0685                	addi	a3,a3,1
 468:	fec773e3          	bgeu	a4,a2,44e <printint+0x26>
  if (neg)
 46c:	00088b63          	beqz	a7,482 <printint+0x5a>
    buf[i++] = '-';
 470:	fd078793          	addi	a5,a5,-48
 474:	97a2                	add	a5,a5,s0
 476:	02d00713          	li	a4,45
 47a:	fee78423          	sb	a4,-24(a5)
 47e:	0028079b          	addiw	a5,a6,2

  while (--i >= 0)
 482:	02f05663          	blez	a5,4ae <printint+0x86>
 486:	fb840713          	addi	a4,s0,-72
 48a:	00f704b3          	add	s1,a4,a5
 48e:	fff70993          	addi	s3,a4,-1
 492:	99be                	add	s3,s3,a5
 494:	37fd                	addiw	a5,a5,-1
 496:	1782                	slli	a5,a5,0x20
 498:	9381                	srli	a5,a5,0x20
 49a:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
 49e:	fff4c583          	lbu	a1,-1(s1)
 4a2:	854a                	mv	a0,s2
 4a4:	f67ff0ef          	jal	ra,40a <putc>
  while (--i >= 0)
 4a8:	14fd                	addi	s1,s1,-1
 4aa:	ff349ae3          	bne	s1,s3,49e <printint+0x76>
}
 4ae:	60a6                	ld	ra,72(sp)
 4b0:	6406                	ld	s0,64(sp)
 4b2:	74e2                	ld	s1,56(sp)
 4b4:	7942                	ld	s2,48(sp)
 4b6:	79a2                	ld	s3,40(sp)
 4b8:	6161                	addi	sp,sp,80
 4ba:	8082                	ret
    x = -xx;
 4bc:	40b005b3          	neg	a1,a1
    neg = 1;
 4c0:	4885                	li	a7,1
    x = -xx;
 4c2:	bfbd                	j	440 <printint+0x18>

00000000000004c4 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 4c4:	7119                	addi	sp,sp,-128
 4c6:	fc86                	sd	ra,120(sp)
 4c8:	f8a2                	sd	s0,112(sp)
 4ca:	f4a6                	sd	s1,104(sp)
 4cc:	f0ca                	sd	s2,96(sp)
 4ce:	ecce                	sd	s3,88(sp)
 4d0:	e8d2                	sd	s4,80(sp)
 4d2:	e4d6                	sd	s5,72(sp)
 4d4:	e0da                	sd	s6,64(sp)
 4d6:	fc5e                	sd	s7,56(sp)
 4d8:	f862                	sd	s8,48(sp)
 4da:	f466                	sd	s9,40(sp)
 4dc:	f06a                	sd	s10,32(sp)
 4de:	ec6e                	sd	s11,24(sp)
 4e0:	0100                	addi	s0,sp,128
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for (i = 0; fmt[i]; i++) {
 4e2:	0005c903          	lbu	s2,0(a1)
 4e6:	24090c63          	beqz	s2,73e <vprintf+0x27a>
 4ea:	8b2a                	mv	s6,a0
 4ec:	8a2e                	mv	s4,a1
 4ee:	8bb2                	mv	s7,a2
  state = 0;
 4f0:	4981                	li	s3,0
  for (i = 0; fmt[i]; i++) {
 4f2:	4481                	li	s1,0
 4f4:	4701                	li	a4,0
      if (c0 == '%') {
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if (state == '%') {
 4f6:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if (c0)
        c1 = fmt[i + 1] & 0xff;
      if (c1)
        c2 = fmt[i + 2] & 0xff;
      if (c0 == 'd') {
 4fa:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if (c0 == 'l' && c1 == 'd') {
 4fe:	06c00d13          	li	s10,108
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'd') {
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if (c0 == 'u') {
 502:	07500d93          	li	s11,117
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 506:	00000c97          	auipc	s9,0x0
 50a:	4a2c8c93          	addi	s9,s9,1186 # 9a8 <digits>
 50e:	a005                	j	52e <vprintf+0x6a>
        putc(fd, c0);
 510:	85ca                	mv	a1,s2
 512:	855a                	mv	a0,s6
 514:	ef7ff0ef          	jal	ra,40a <putc>
 518:	a019                	j	51e <vprintf+0x5a>
    } else if (state == '%') {
 51a:	03598263          	beq	s3,s5,53e <vprintf+0x7a>
  for (i = 0; fmt[i]; i++) {
 51e:	2485                	addiw	s1,s1,1
 520:	8726                	mv	a4,s1
 522:	009a07b3          	add	a5,s4,s1
 526:	0007c903          	lbu	s2,0(a5)
 52a:	20090a63          	beqz	s2,73e <vprintf+0x27a>
    c0 = fmt[i] & 0xff;
 52e:	0009079b          	sext.w	a5,s2
    if (state == 0) {
 532:	fe0994e3          	bnez	s3,51a <vprintf+0x56>
      if (c0 == '%') {
 536:	fd579de3          	bne	a5,s5,510 <vprintf+0x4c>
        state = '%';
 53a:	89be                	mv	s3,a5
 53c:	b7cd                	j	51e <vprintf+0x5a>
      if (c0)
 53e:	c3c1                	beqz	a5,5be <vprintf+0xfa>
        c1 = fmt[i + 1] & 0xff;
 540:	00ea06b3          	add	a3,s4,a4
 544:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 548:	8636                	mv	a2,a3
      if (c1)
 54a:	c681                	beqz	a3,552 <vprintf+0x8e>
        c2 = fmt[i + 2] & 0xff;
 54c:	9752                	add	a4,a4,s4
 54e:	00274603          	lbu	a2,2(a4)
      if (c0 == 'd') {
 552:	03878e63          	beq	a5,s8,58e <vprintf+0xca>
      } else if (c0 == 'l' && c1 == 'd') {
 556:	05a78863          	beq	a5,s10,5a6 <vprintf+0xe2>
      } else if (c0 == 'u') {
 55a:	0db78b63          	beq	a5,s11,630 <vprintf+0x16c>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'u') {
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if (c0 == 'x') {
 55e:	07800713          	li	a4,120
 562:	10e78d63          	beq	a5,a4,67c <vprintf+0x1b8>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'x') {
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if (c0 == 'p') {
 566:	07000713          	li	a4,112
 56a:	14e78263          	beq	a5,a4,6ae <vprintf+0x1ea>
        printptr(fd, va_arg(ap, uint64));
      } else if (c0 == 'c') {
 56e:	06300713          	li	a4,99
 572:	16e78f63          	beq	a5,a4,6f0 <vprintf+0x22c>
        putc(fd, va_arg(ap, uint32));
      } else if (c0 == 's') {
 576:	07300713          	li	a4,115
 57a:	18e78563          	beq	a5,a4,704 <vprintf+0x240>
        if ((s = va_arg(ap, char *)) == 0)
          s = "(null)";
        for (; *s; s++)
          putc(fd, *s);
      } else if (c0 == '%') {
 57e:	05579063          	bne	a5,s5,5be <vprintf+0xfa>
        putc(fd, '%');
 582:	85d6                	mv	a1,s5
 584:	855a                	mv	a0,s6
 586:	e85ff0ef          	jal	ra,40a <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 58a:	4981                	li	s3,0
 58c:	bf49                	j	51e <vprintf+0x5a>
        printint(fd, va_arg(ap, int), 10, 1);
 58e:	008b8913          	addi	s2,s7,8
 592:	4685                	li	a3,1
 594:	4629                	li	a2,10
 596:	000ba583          	lw	a1,0(s7)
 59a:	855a                	mv	a0,s6
 59c:	e8dff0ef          	jal	ra,428 <printint>
 5a0:	8bca                	mv	s7,s2
      state = 0;
 5a2:	4981                	li	s3,0
 5a4:	bfad                	j	51e <vprintf+0x5a>
      } else if (c0 == 'l' && c1 == 'd') {
 5a6:	03868663          	beq	a3,s8,5d2 <vprintf+0x10e>
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'd') {
 5aa:	05a68163          	beq	a3,s10,5ec <vprintf+0x128>
      } else if (c0 == 'l' && c1 == 'u') {
 5ae:	09b68d63          	beq	a3,s11,648 <vprintf+0x184>
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'u') {
 5b2:	03a68f63          	beq	a3,s10,5f0 <vprintf+0x12c>
      } else if (c0 == 'l' && c1 == 'x') {
 5b6:	07800793          	li	a5,120
 5ba:	0cf68d63          	beq	a3,a5,694 <vprintf+0x1d0>
        putc(fd, '%');
 5be:	85d6                	mv	a1,s5
 5c0:	855a                	mv	a0,s6
 5c2:	e49ff0ef          	jal	ra,40a <putc>
        putc(fd, c0);
 5c6:	85ca                	mv	a1,s2
 5c8:	855a                	mv	a0,s6
 5ca:	e41ff0ef          	jal	ra,40a <putc>
      state = 0;
 5ce:	4981                	li	s3,0
 5d0:	b7b9                	j	51e <vprintf+0x5a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 5d2:	008b8913          	addi	s2,s7,8
 5d6:	4685                	li	a3,1
 5d8:	4629                	li	a2,10
 5da:	000bb583          	ld	a1,0(s7)
 5de:	855a                	mv	a0,s6
 5e0:	e49ff0ef          	jal	ra,428 <printint>
        i += 1;
 5e4:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 5e6:	8bca                	mv	s7,s2
      state = 0;
 5e8:	4981                	li	s3,0
        i += 1;
 5ea:	bf15                	j	51e <vprintf+0x5a>
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'd') {
 5ec:	03860563          	beq	a2,s8,616 <vprintf+0x152>
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'u') {
 5f0:	07b60963          	beq	a2,s11,662 <vprintf+0x19e>
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'x') {
 5f4:	07800793          	li	a5,120
 5f8:	fcf613e3          	bne	a2,a5,5be <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 5fc:	008b8913          	addi	s2,s7,8
 600:	4681                	li	a3,0
 602:	4641                	li	a2,16
 604:	000bb583          	ld	a1,0(s7)
 608:	855a                	mv	a0,s6
 60a:	e1fff0ef          	jal	ra,428 <printint>
        i += 2;
 60e:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 610:	8bca                	mv	s7,s2
      state = 0;
 612:	4981                	li	s3,0
        i += 2;
 614:	b729                	j	51e <vprintf+0x5a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 616:	008b8913          	addi	s2,s7,8
 61a:	4685                	li	a3,1
 61c:	4629                	li	a2,10
 61e:	000bb583          	ld	a1,0(s7)
 622:	855a                	mv	a0,s6
 624:	e05ff0ef          	jal	ra,428 <printint>
        i += 2;
 628:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 62a:	8bca                	mv	s7,s2
      state = 0;
 62c:	4981                	li	s3,0
        i += 2;
 62e:	bdc5                	j	51e <vprintf+0x5a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 630:	008b8913          	addi	s2,s7,8
 634:	4681                	li	a3,0
 636:	4629                	li	a2,10
 638:	000be583          	lwu	a1,0(s7)
 63c:	855a                	mv	a0,s6
 63e:	debff0ef          	jal	ra,428 <printint>
 642:	8bca                	mv	s7,s2
      state = 0;
 644:	4981                	li	s3,0
 646:	bde1                	j	51e <vprintf+0x5a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 648:	008b8913          	addi	s2,s7,8
 64c:	4681                	li	a3,0
 64e:	4629                	li	a2,10
 650:	000bb583          	ld	a1,0(s7)
 654:	855a                	mv	a0,s6
 656:	dd3ff0ef          	jal	ra,428 <printint>
        i += 1;
 65a:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 65c:	8bca                	mv	s7,s2
      state = 0;
 65e:	4981                	li	s3,0
        i += 1;
 660:	bd7d                	j	51e <vprintf+0x5a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 662:	008b8913          	addi	s2,s7,8
 666:	4681                	li	a3,0
 668:	4629                	li	a2,10
 66a:	000bb583          	ld	a1,0(s7)
 66e:	855a                	mv	a0,s6
 670:	db9ff0ef          	jal	ra,428 <printint>
        i += 2;
 674:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 676:	8bca                	mv	s7,s2
      state = 0;
 678:	4981                	li	s3,0
        i += 2;
 67a:	b555                	j	51e <vprintf+0x5a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 67c:	008b8913          	addi	s2,s7,8
 680:	4681                	li	a3,0
 682:	4641                	li	a2,16
 684:	000be583          	lwu	a1,0(s7)
 688:	855a                	mv	a0,s6
 68a:	d9fff0ef          	jal	ra,428 <printint>
 68e:	8bca                	mv	s7,s2
      state = 0;
 690:	4981                	li	s3,0
 692:	b571                	j	51e <vprintf+0x5a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 694:	008b8913          	addi	s2,s7,8
 698:	4681                	li	a3,0
 69a:	4641                	li	a2,16
 69c:	000bb583          	ld	a1,0(s7)
 6a0:	855a                	mv	a0,s6
 6a2:	d87ff0ef          	jal	ra,428 <printint>
        i += 1;
 6a6:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 6a8:	8bca                	mv	s7,s2
      state = 0;
 6aa:	4981                	li	s3,0
        i += 1;
 6ac:	bd8d                	j	51e <vprintf+0x5a>
        printptr(fd, va_arg(ap, uint64));
 6ae:	008b8793          	addi	a5,s7,8
 6b2:	f8f43423          	sd	a5,-120(s0)
 6b6:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 6ba:	03000593          	li	a1,48
 6be:	855a                	mv	a0,s6
 6c0:	d4bff0ef          	jal	ra,40a <putc>
  putc(fd, 'x');
 6c4:	07800593          	li	a1,120
 6c8:	855a                	mv	a0,s6
 6ca:	d41ff0ef          	jal	ra,40a <putc>
 6ce:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6d0:	03c9d793          	srli	a5,s3,0x3c
 6d4:	97e6                	add	a5,a5,s9
 6d6:	0007c583          	lbu	a1,0(a5)
 6da:	855a                	mv	a0,s6
 6dc:	d2fff0ef          	jal	ra,40a <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 6e0:	0992                	slli	s3,s3,0x4
 6e2:	397d                	addiw	s2,s2,-1
 6e4:	fe0916e3          	bnez	s2,6d0 <vprintf+0x20c>
        printptr(fd, va_arg(ap, uint64));
 6e8:	f8843b83          	ld	s7,-120(s0)
      state = 0;
 6ec:	4981                	li	s3,0
 6ee:	bd05                	j	51e <vprintf+0x5a>
        putc(fd, va_arg(ap, uint32));
 6f0:	008b8913          	addi	s2,s7,8
 6f4:	000bc583          	lbu	a1,0(s7)
 6f8:	855a                	mv	a0,s6
 6fa:	d11ff0ef          	jal	ra,40a <putc>
 6fe:	8bca                	mv	s7,s2
      state = 0;
 700:	4981                	li	s3,0
 702:	bd31                	j	51e <vprintf+0x5a>
        if ((s = va_arg(ap, char *)) == 0)
 704:	008b8993          	addi	s3,s7,8
 708:	000bb903          	ld	s2,0(s7)
 70c:	00090f63          	beqz	s2,72a <vprintf+0x266>
        for (; *s; s++)
 710:	00094583          	lbu	a1,0(s2)
 714:	c195                	beqz	a1,738 <vprintf+0x274>
          putc(fd, *s);
 716:	855a                	mv	a0,s6
 718:	cf3ff0ef          	jal	ra,40a <putc>
        for (; *s; s++)
 71c:	0905                	addi	s2,s2,1
 71e:	00094583          	lbu	a1,0(s2)
 722:	f9f5                	bnez	a1,716 <vprintf+0x252>
        if ((s = va_arg(ap, char *)) == 0)
 724:	8bce                	mv	s7,s3
      state = 0;
 726:	4981                	li	s3,0
 728:	bbdd                	j	51e <vprintf+0x5a>
          s = "(null)";
 72a:	00000917          	auipc	s2,0x0
 72e:	27690913          	addi	s2,s2,630 # 9a0 <malloc+0x166>
        for (; *s; s++)
 732:	02800593          	li	a1,40
 736:	b7c5                	j	716 <vprintf+0x252>
        if ((s = va_arg(ap, char *)) == 0)
 738:	8bce                	mv	s7,s3
      state = 0;
 73a:	4981                	li	s3,0
 73c:	b3cd                	j	51e <vprintf+0x5a>
    }
  }
}
 73e:	70e6                	ld	ra,120(sp)
 740:	7446                	ld	s0,112(sp)
 742:	74a6                	ld	s1,104(sp)
 744:	7906                	ld	s2,96(sp)
 746:	69e6                	ld	s3,88(sp)
 748:	6a46                	ld	s4,80(sp)
 74a:	6aa6                	ld	s5,72(sp)
 74c:	6b06                	ld	s6,64(sp)
 74e:	7be2                	ld	s7,56(sp)
 750:	7c42                	ld	s8,48(sp)
 752:	7ca2                	ld	s9,40(sp)
 754:	7d02                	ld	s10,32(sp)
 756:	6de2                	ld	s11,24(sp)
 758:	6109                	addi	sp,sp,128
 75a:	8082                	ret

000000000000075c <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 75c:	715d                	addi	sp,sp,-80
 75e:	ec06                	sd	ra,24(sp)
 760:	e822                	sd	s0,16(sp)
 762:	1000                	addi	s0,sp,32
 764:	e010                	sd	a2,0(s0)
 766:	e414                	sd	a3,8(s0)
 768:	e818                	sd	a4,16(s0)
 76a:	ec1c                	sd	a5,24(s0)
 76c:	03043023          	sd	a6,32(s0)
 770:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 774:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 778:	8622                	mv	a2,s0
 77a:	d4bff0ef          	jal	ra,4c4 <vprintf>
}
 77e:	60e2                	ld	ra,24(sp)
 780:	6442                	ld	s0,16(sp)
 782:	6161                	addi	sp,sp,80
 784:	8082                	ret

0000000000000786 <printf>:

void
printf(const char *fmt, ...)
{
 786:	711d                	addi	sp,sp,-96
 788:	ec06                	sd	ra,24(sp)
 78a:	e822                	sd	s0,16(sp)
 78c:	1000                	addi	s0,sp,32
 78e:	e40c                	sd	a1,8(s0)
 790:	e810                	sd	a2,16(s0)
 792:	ec14                	sd	a3,24(s0)
 794:	f018                	sd	a4,32(s0)
 796:	f41c                	sd	a5,40(s0)
 798:	03043823          	sd	a6,48(s0)
 79c:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 7a0:	00840613          	addi	a2,s0,8
 7a4:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 7a8:	85aa                	mv	a1,a0
 7aa:	4505                	li	a0,1
 7ac:	d19ff0ef          	jal	ra,4c4 <vprintf>
}
 7b0:	60e2                	ld	ra,24(sp)
 7b2:	6442                	ld	s0,16(sp)
 7b4:	6125                	addi	sp,sp,96
 7b6:	8082                	ret

00000000000007b8 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7b8:	1141                	addi	sp,sp,-16
 7ba:	e422                	sd	s0,8(sp)
 7bc:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header *)ap - 1;
 7be:	ff050693          	addi	a3,a0,-16
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7c2:	00001797          	auipc	a5,0x1
 7c6:	83e7b783          	ld	a5,-1986(a5) # 1000 <freep>
 7ca:	a02d                	j	7f4 <free+0x3c>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if (bp + bp->s.size == p->s.ptr) {
    bp->s.size += p->s.ptr->s.size;
 7cc:	4618                	lw	a4,8(a2)
 7ce:	9f2d                	addw	a4,a4,a1
 7d0:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 7d4:	6398                	ld	a4,0(a5)
 7d6:	6310                	ld	a2,0(a4)
 7d8:	a83d                	j	816 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if (p + p->s.size == bp) {
    p->s.size += bp->s.size;
 7da:	ff852703          	lw	a4,-8(a0)
 7de:	9f31                	addw	a4,a4,a2
 7e0:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 7e2:	ff053683          	ld	a3,-16(a0)
 7e6:	a091                	j	82a <free+0x72>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7e8:	6398                	ld	a4,0(a5)
 7ea:	00e7e463          	bltu	a5,a4,7f2 <free+0x3a>
 7ee:	00e6ea63          	bltu	a3,a4,802 <free+0x4a>
{
 7f2:	87ba                	mv	a5,a4
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7f4:	fed7fae3          	bgeu	a5,a3,7e8 <free+0x30>
 7f8:	6398                	ld	a4,0(a5)
 7fa:	00e6e463          	bltu	a3,a4,802 <free+0x4a>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7fe:	fee7eae3          	bltu	a5,a4,7f2 <free+0x3a>
  if (bp + bp->s.size == p->s.ptr) {
 802:	ff852583          	lw	a1,-8(a0)
 806:	6390                	ld	a2,0(a5)
 808:	02059813          	slli	a6,a1,0x20
 80c:	01c85713          	srli	a4,a6,0x1c
 810:	9736                	add	a4,a4,a3
 812:	fae60de3          	beq	a2,a4,7cc <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 816:	fec53823          	sd	a2,-16(a0)
  if (p + p->s.size == bp) {
 81a:	4790                	lw	a2,8(a5)
 81c:	02061593          	slli	a1,a2,0x20
 820:	01c5d713          	srli	a4,a1,0x1c
 824:	973e                	add	a4,a4,a5
 826:	fae68ae3          	beq	a3,a4,7da <free+0x22>
    p->s.ptr = bp->s.ptr;
 82a:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 82c:	00000717          	auipc	a4,0x0
 830:	7cf73a23          	sd	a5,2004(a4) # 1000 <freep>
}
 834:	6422                	ld	s0,8(sp)
 836:	0141                	addi	sp,sp,16
 838:	8082                	ret

000000000000083a <malloc>:
  return freep;
}

void *
malloc(uint nbytes)
{
 83a:	7139                	addi	sp,sp,-64
 83c:	fc06                	sd	ra,56(sp)
 83e:	f822                	sd	s0,48(sp)
 840:	f426                	sd	s1,40(sp)
 842:	f04a                	sd	s2,32(sp)
 844:	ec4e                	sd	s3,24(sp)
 846:	e852                	sd	s4,16(sp)
 848:	e456                	sd	s5,8(sp)
 84a:	e05a                	sd	s6,0(sp)
 84c:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 84e:	02051493          	slli	s1,a0,0x20
 852:	9081                	srli	s1,s1,0x20
 854:	04bd                	addi	s1,s1,15
 856:	8091                	srli	s1,s1,0x4
 858:	0014899b          	addiw	s3,s1,1
 85c:	0485                	addi	s1,s1,1
  if ((prevp = freep) == 0) {
 85e:	00000517          	auipc	a0,0x0
 862:	7a253503          	ld	a0,1954(a0) # 1000 <freep>
 866:	c515                	beqz	a0,892 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
 868:	611c                	ld	a5,0(a0)
    if (p->s.size >= nunits) {
 86a:	4798                	lw	a4,8(a5)
 86c:	02977f63          	bgeu	a4,s1,8aa <malloc+0x70>
 870:	8a4e                	mv	s4,s3
 872:	0009871b          	sext.w	a4,s3
 876:	6685                	lui	a3,0x1
 878:	00d77363          	bgeu	a4,a3,87e <malloc+0x44>
 87c:	6a05                	lui	s4,0x1
 87e:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 882:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void *)(p + 1);
    }
    if (p == freep)
 886:	00000917          	auipc	s2,0x0
 88a:	77a90913          	addi	s2,s2,1914 # 1000 <freep>
  if (p == SBRK_ERROR)
 88e:	5afd                	li	s5,-1
 890:	a885                	j	900 <malloc+0xc6>
    base.s.ptr = freep = prevp = &base;
 892:	00000797          	auipc	a5,0x0
 896:	77e78793          	addi	a5,a5,1918 # 1010 <base>
 89a:	00000717          	auipc	a4,0x0
 89e:	76f73323          	sd	a5,1894(a4) # 1000 <freep>
 8a2:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 8a4:	0007a423          	sw	zero,8(a5)
    if (p->s.size >= nunits) {
 8a8:	b7e1                	j	870 <malloc+0x36>
      if (p->s.size == nunits)
 8aa:	02e48c63          	beq	s1,a4,8e2 <malloc+0xa8>
        p->s.size -= nunits;
 8ae:	4137073b          	subw	a4,a4,s3
 8b2:	c798                	sw	a4,8(a5)
        p += p->s.size;
 8b4:	02071693          	slli	a3,a4,0x20
 8b8:	01c6d713          	srli	a4,a3,0x1c
 8bc:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 8be:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 8c2:	00000717          	auipc	a4,0x0
 8c6:	72a73f23          	sd	a0,1854(a4) # 1000 <freep>
      return (void *)(p + 1);
 8ca:	01078513          	addi	a0,a5,16
      if ((p = morecore(nunits)) == 0)
        return 0;
  }
}
 8ce:	70e2                	ld	ra,56(sp)
 8d0:	7442                	ld	s0,48(sp)
 8d2:	74a2                	ld	s1,40(sp)
 8d4:	7902                	ld	s2,32(sp)
 8d6:	69e2                	ld	s3,24(sp)
 8d8:	6a42                	ld	s4,16(sp)
 8da:	6aa2                	ld	s5,8(sp)
 8dc:	6b02                	ld	s6,0(sp)
 8de:	6121                	addi	sp,sp,64
 8e0:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 8e2:	6398                	ld	a4,0(a5)
 8e4:	e118                	sd	a4,0(a0)
 8e6:	bff1                	j	8c2 <malloc+0x88>
  hp->s.size = nu;
 8e8:	01652423          	sw	s6,8(a0)
  free((void *)(hp + 1));
 8ec:	0541                	addi	a0,a0,16
 8ee:	ecbff0ef          	jal	ra,7b8 <free>
  return freep;
 8f2:	00093503          	ld	a0,0(s2)
      if ((p = morecore(nunits)) == 0)
 8f6:	dd61                	beqz	a0,8ce <malloc+0x94>
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
 8f8:	611c                	ld	a5,0(a0)
    if (p->s.size >= nunits) {
 8fa:	4798                	lw	a4,8(a5)
 8fc:	fa9777e3          	bgeu	a4,s1,8aa <malloc+0x70>
    if (p == freep)
 900:	00093703          	ld	a4,0(s2)
 904:	853e                	mv	a0,a5
 906:	fef719e3          	bne	a4,a5,8f8 <malloc+0xbe>
  p = sbrk(nu * sizeof(Header));
 90a:	8552                	mv	a0,s4
 90c:	a23ff0ef          	jal	ra,32e <sbrk>
  if (p == SBRK_ERROR)
 910:	fd551ce3          	bne	a0,s5,8e8 <malloc+0xae>
        return 0;
 914:	4501                	li	a0,0
 916:	bf65                	j	8ce <malloc+0x94>
