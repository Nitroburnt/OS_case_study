
user/_sleepsync:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/types.h"
#include "user/user.h"

int
main(void)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	1000                	addi	s0,sp,32
  int fd[2];
  int pid;
  char ch;
  int status;

  if (pipe(fd) < 0) {
   8:	fe840513          	addi	a0,s0,-24
   c:	36e000ef          	jal	ra,37a <pipe>
  10:	04054063          	bltz	a0,50 <main+0x50>
    printf("sleepsync: pipe failed\n");
    exit(1);
  }
  pid = fork();
  14:	34e000ef          	jal	ra,362 <fork>
  if (pid < 0) {
  18:	04054563          	bltz	a0,62 <main+0x62>
    printf("sleepsync: fork failed\n");
    exit(1);
  }
  if (pid == 0) {
  1c:	ed21                	bnez	a0,74 <main+0x74>
    close(fd[0]);
  1e:	fe842503          	lw	a0,-24(s0)
  22:	370000ef          	jal	ra,392 <close>
    pause(10);
  26:	4529                	li	a0,10
  28:	3d2000ef          	jal	ra,3fa <pause>
    ch = 'S';
  2c:	05300793          	li	a5,83
  30:	fef403a3          	sb	a5,-25(s0)
    write(fd[1], &ch, 1);
  34:	4605                	li	a2,1
  36:	fe740593          	addi	a1,s0,-25
  3a:	fec42503          	lw	a0,-20(s0)
  3e:	34c000ef          	jal	ra,38a <write>
    close(fd[1]);
  42:	fec42503          	lw	a0,-20(s0)
  46:	34c000ef          	jal	ra,392 <close>
    exit(0);
  4a:	4501                	li	a0,0
  4c:	31e000ef          	jal	ra,36a <exit>
    printf("sleepsync: pipe failed\n");
  50:	00001517          	auipc	a0,0x1
  54:	8d050513          	addi	a0,a0,-1840 # 920 <malloc+0xde>
  58:	736000ef          	jal	ra,78e <printf>
    exit(1);
  5c:	4505                	li	a0,1
  5e:	30c000ef          	jal	ra,36a <exit>
    printf("sleepsync: fork failed\n");
  62:	00001517          	auipc	a0,0x1
  66:	8d650513          	addi	a0,a0,-1834 # 938 <malloc+0xf6>
  6a:	724000ef          	jal	ra,78e <printf>
    exit(1);
  6e:	4505                	li	a0,1
  70:	2fa000ef          	jal	ra,36a <exit>
  }

  // Close unused write end in parent so EOF can be detected if child exits
  close(fd[1]);
  74:	fec42503          	lw	a0,-20(s0)
  78:	31a000ef          	jal	ra,392 <close>

  printf("sleepsync: reader blocks until pipe data arrives\n");
  7c:	00001517          	auipc	a0,0x1
  80:	8d450513          	addi	a0,a0,-1836 # 950 <malloc+0x10e>
  84:	70a000ef          	jal	ra,78e <printf>
  if (read(fd[0], &ch, 1) != 1 || ch != 'S')
  88:	4605                	li	a2,1
  8a:	fe740593          	addi	a1,s0,-25
  8e:	fe842503          	lw	a0,-24(s0)
  92:	2f0000ef          	jal	ra,382 <read>
  96:	4785                	li	a5,1
  98:	00f51863          	bne	a0,a5,a8 <main+0xa8>
  9c:	fe744703          	lbu	a4,-25(s0)
  a0:	05300793          	li	a5,83
  a4:	00f70863          	beq	a4,a5,b4 <main+0xb4>
    printf("sleepsync: unexpected pipe result\n");
  a8:	00001517          	auipc	a0,0x1
  ac:	8e050513          	addi	a0,a0,-1824 # 988 <malloc+0x146>
  b0:	6de000ef          	jal	ra,78e <printf>
  wait(&status);
  b4:	fe040513          	addi	a0,s0,-32
  b8:	2ba000ef          	jal	ra,372 <wait>
  close(fd[0]);
  bc:	fe842503          	lw	a0,-24(s0)
  c0:	2d2000ef          	jal	ra,392 <close>
  printf("sleepsync: sleep/wakeup pipe exchange completed\n");
  c4:	00001517          	auipc	a0,0x1
  c8:	8ec50513          	addi	a0,a0,-1812 # 9b0 <malloc+0x16e>
  cc:	6c2000ef          	jal	ra,78e <printf>
  exit(0);
  d0:	4501                	li	a0,0
  d2:	298000ef          	jal	ra,36a <exit>

00000000000000d6 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
  d6:	1141                	addi	sp,sp,-16
  d8:	e406                	sd	ra,8(sp)
  da:	e022                	sd	s0,0(sp)
  dc:	0800                	addi	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
  de:	f23ff0ef          	jal	ra,0 <main>
  exit(r);
  e2:	288000ef          	jal	ra,36a <exit>

00000000000000e6 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
  e6:	1141                	addi	sp,sp,-16
  e8:	e422                	sd	s0,8(sp)
  ea:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while ((*s++ = *t++) != 0)
  ec:	87aa                	mv	a5,a0
  ee:	0585                	addi	a1,a1,1
  f0:	0785                	addi	a5,a5,1
  f2:	fff5c703          	lbu	a4,-1(a1)
  f6:	fee78fa3          	sb	a4,-1(a5)
  fa:	fb75                	bnez	a4,ee <strcpy+0x8>
    ;
  return os;
}
  fc:	6422                	ld	s0,8(sp)
  fe:	0141                	addi	sp,sp,16
 100:	8082                	ret

0000000000000102 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 102:	1141                	addi	sp,sp,-16
 104:	e422                	sd	s0,8(sp)
 106:	0800                	addi	s0,sp,16
  while (*p && *p == *q)
 108:	00054783          	lbu	a5,0(a0)
 10c:	cb91                	beqz	a5,120 <strcmp+0x1e>
 10e:	0005c703          	lbu	a4,0(a1)
 112:	00f71763          	bne	a4,a5,120 <strcmp+0x1e>
    p++, q++;
 116:	0505                	addi	a0,a0,1
 118:	0585                	addi	a1,a1,1
  while (*p && *p == *q)
 11a:	00054783          	lbu	a5,0(a0)
 11e:	fbe5                	bnez	a5,10e <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 120:	0005c503          	lbu	a0,0(a1)
}
 124:	40a7853b          	subw	a0,a5,a0
 128:	6422                	ld	s0,8(sp)
 12a:	0141                	addi	sp,sp,16
 12c:	8082                	ret

000000000000012e <strlen>:

uint
strlen(const char *s)
{
 12e:	1141                	addi	sp,sp,-16
 130:	e422                	sd	s0,8(sp)
 132:	0800                	addi	s0,sp,16
  int n;

  for (n = 0; s[n]; n++)
 134:	00054783          	lbu	a5,0(a0)
 138:	cf91                	beqz	a5,154 <strlen+0x26>
 13a:	0505                	addi	a0,a0,1
 13c:	87aa                	mv	a5,a0
 13e:	4685                	li	a3,1
 140:	9e89                	subw	a3,a3,a0
 142:	00f6853b          	addw	a0,a3,a5
 146:	0785                	addi	a5,a5,1
 148:	fff7c703          	lbu	a4,-1(a5)
 14c:	fb7d                	bnez	a4,142 <strlen+0x14>
    ;
  return n;
}
 14e:	6422                	ld	s0,8(sp)
 150:	0141                	addi	sp,sp,16
 152:	8082                	ret
  for (n = 0; s[n]; n++)
 154:	4501                	li	a0,0
 156:	bfe5                	j	14e <strlen+0x20>

0000000000000158 <memset>:

void *
memset(void *dst, int c, uint n)
{
 158:	1141                	addi	sp,sp,-16
 15a:	e422                	sd	s0,8(sp)
 15c:	0800                	addi	s0,sp,16
  char *cdst = (char *)dst;
  int i;
  for (i = 0; i < n; i++) {
 15e:	ca19                	beqz	a2,174 <memset+0x1c>
 160:	87aa                	mv	a5,a0
 162:	1602                	slli	a2,a2,0x20
 164:	9201                	srli	a2,a2,0x20
 166:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 16a:	00b78023          	sb	a1,0(a5)
  for (i = 0; i < n; i++) {
 16e:	0785                	addi	a5,a5,1
 170:	fee79de3          	bne	a5,a4,16a <memset+0x12>
  }
  return dst;
}
 174:	6422                	ld	s0,8(sp)
 176:	0141                	addi	sp,sp,16
 178:	8082                	ret

000000000000017a <strchr>:

char *
strchr(const char *s, char c)
{
 17a:	1141                	addi	sp,sp,-16
 17c:	e422                	sd	s0,8(sp)
 17e:	0800                	addi	s0,sp,16
  for (; *s; s++)
 180:	00054783          	lbu	a5,0(a0)
 184:	cb99                	beqz	a5,19a <strchr+0x20>
    if (*s == c)
 186:	00f58763          	beq	a1,a5,194 <strchr+0x1a>
  for (; *s; s++)
 18a:	0505                	addi	a0,a0,1
 18c:	00054783          	lbu	a5,0(a0)
 190:	fbfd                	bnez	a5,186 <strchr+0xc>
      return (char *)s;
  return 0;
 192:	4501                	li	a0,0
}
 194:	6422                	ld	s0,8(sp)
 196:	0141                	addi	sp,sp,16
 198:	8082                	ret
  return 0;
 19a:	4501                	li	a0,0
 19c:	bfe5                	j	194 <strchr+0x1a>

000000000000019e <gets>:

char *
gets(char *buf, int max)
{
 19e:	711d                	addi	sp,sp,-96
 1a0:	ec86                	sd	ra,88(sp)
 1a2:	e8a2                	sd	s0,80(sp)
 1a4:	e4a6                	sd	s1,72(sp)
 1a6:	e0ca                	sd	s2,64(sp)
 1a8:	fc4e                	sd	s3,56(sp)
 1aa:	f852                	sd	s4,48(sp)
 1ac:	f456                	sd	s5,40(sp)
 1ae:	f05a                	sd	s6,32(sp)
 1b0:	ec5e                	sd	s7,24(sp)
 1b2:	1080                	addi	s0,sp,96
 1b4:	8baa                	mv	s7,a0
 1b6:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for (i = 0; i + 1 < max;) {
 1b8:	892a                	mv	s2,a0
 1ba:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if (cc < 1)
      break;
    buf[i++] = c;
    if (c == '\n' || c == '\r')
 1bc:	4aa9                	li	s5,10
 1be:	4b35                	li	s6,13
  for (i = 0; i + 1 < max;) {
 1c0:	89a6                	mv	s3,s1
 1c2:	2485                	addiw	s1,s1,1
 1c4:	0344d663          	bge	s1,s4,1f0 <gets+0x52>
    cc = read(0, &c, 1);
 1c8:	4605                	li	a2,1
 1ca:	faf40593          	addi	a1,s0,-81
 1ce:	4501                	li	a0,0
 1d0:	1b2000ef          	jal	ra,382 <read>
    if (cc < 1)
 1d4:	00a05e63          	blez	a0,1f0 <gets+0x52>
    buf[i++] = c;
 1d8:	faf44783          	lbu	a5,-81(s0)
 1dc:	00f90023          	sb	a5,0(s2)
    if (c == '\n' || c == '\r')
 1e0:	01578763          	beq	a5,s5,1ee <gets+0x50>
 1e4:	0905                	addi	s2,s2,1
 1e6:	fd679de3          	bne	a5,s6,1c0 <gets+0x22>
  for (i = 0; i + 1 < max;) {
 1ea:	89a6                	mv	s3,s1
 1ec:	a011                	j	1f0 <gets+0x52>
 1ee:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 1f0:	99de                	add	s3,s3,s7
 1f2:	00098023          	sb	zero,0(s3)
  return buf;
}
 1f6:	855e                	mv	a0,s7
 1f8:	60e6                	ld	ra,88(sp)
 1fa:	6446                	ld	s0,80(sp)
 1fc:	64a6                	ld	s1,72(sp)
 1fe:	6906                	ld	s2,64(sp)
 200:	79e2                	ld	s3,56(sp)
 202:	7a42                	ld	s4,48(sp)
 204:	7aa2                	ld	s5,40(sp)
 206:	7b02                	ld	s6,32(sp)
 208:	6be2                	ld	s7,24(sp)
 20a:	6125                	addi	sp,sp,96
 20c:	8082                	ret

000000000000020e <stat>:

int
stat(const char *n, struct stat *st)
{
 20e:	1101                	addi	sp,sp,-32
 210:	ec06                	sd	ra,24(sp)
 212:	e822                	sd	s0,16(sp)
 214:	e426                	sd	s1,8(sp)
 216:	e04a                	sd	s2,0(sp)
 218:	1000                	addi	s0,sp,32
 21a:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 21c:	4581                	li	a1,0
 21e:	18c000ef          	jal	ra,3aa <open>
  if (fd < 0)
 222:	02054163          	bltz	a0,244 <stat+0x36>
 226:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 228:	85ca                	mv	a1,s2
 22a:	198000ef          	jal	ra,3c2 <fstat>
 22e:	892a                	mv	s2,a0
  close(fd);
 230:	8526                	mv	a0,s1
 232:	160000ef          	jal	ra,392 <close>
  return r;
}
 236:	854a                	mv	a0,s2
 238:	60e2                	ld	ra,24(sp)
 23a:	6442                	ld	s0,16(sp)
 23c:	64a2                	ld	s1,8(sp)
 23e:	6902                	ld	s2,0(sp)
 240:	6105                	addi	sp,sp,32
 242:	8082                	ret
    return -1;
 244:	597d                	li	s2,-1
 246:	bfc5                	j	236 <stat+0x28>

0000000000000248 <atoi>:

int
atoi(const char *s)
{
 248:	1141                	addi	sp,sp,-16
 24a:	e422                	sd	s0,8(sp)
 24c:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while ('0' <= *s && *s <= '9')
 24e:	00054683          	lbu	a3,0(a0)
 252:	fd06879b          	addiw	a5,a3,-48
 256:	0ff7f793          	zext.b	a5,a5
 25a:	4625                	li	a2,9
 25c:	02f66863          	bltu	a2,a5,28c <atoi+0x44>
 260:	872a                	mv	a4,a0
  n = 0;
 262:	4501                	li	a0,0
    n = n * 10 + *s++ - '0';
 264:	0705                	addi	a4,a4,1
 266:	0025179b          	slliw	a5,a0,0x2
 26a:	9fa9                	addw	a5,a5,a0
 26c:	0017979b          	slliw	a5,a5,0x1
 270:	9fb5                	addw	a5,a5,a3
 272:	fd07851b          	addiw	a0,a5,-48
  while ('0' <= *s && *s <= '9')
 276:	00074683          	lbu	a3,0(a4)
 27a:	fd06879b          	addiw	a5,a3,-48
 27e:	0ff7f793          	zext.b	a5,a5
 282:	fef671e3          	bgeu	a2,a5,264 <atoi+0x1c>
  return n;
}
 286:	6422                	ld	s0,8(sp)
 288:	0141                	addi	sp,sp,16
 28a:	8082                	ret
  n = 0;
 28c:	4501                	li	a0,0
 28e:	bfe5                	j	286 <atoi+0x3e>

0000000000000290 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 290:	1141                	addi	sp,sp,-16
 292:	e422                	sd	s0,8(sp)
 294:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 296:	02b57463          	bgeu	a0,a1,2be <memmove+0x2e>
    while (n-- > 0)
 29a:	00c05f63          	blez	a2,2b8 <memmove+0x28>
 29e:	1602                	slli	a2,a2,0x20
 2a0:	9201                	srli	a2,a2,0x20
 2a2:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 2a6:	872a                	mv	a4,a0
      *dst++ = *src++;
 2a8:	0585                	addi	a1,a1,1
 2aa:	0705                	addi	a4,a4,1
 2ac:	fff5c683          	lbu	a3,-1(a1)
 2b0:	fed70fa3          	sb	a3,-1(a4)
    while (n-- > 0)
 2b4:	fee79ae3          	bne	a5,a4,2a8 <memmove+0x18>
    src += n;
    while (n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 2b8:	6422                	ld	s0,8(sp)
 2ba:	0141                	addi	sp,sp,16
 2bc:	8082                	ret
    dst += n;
 2be:	00c50733          	add	a4,a0,a2
    src += n;
 2c2:	95b2                	add	a1,a1,a2
    while (n-- > 0)
 2c4:	fec05ae3          	blez	a2,2b8 <memmove+0x28>
 2c8:	fff6079b          	addiw	a5,a2,-1
 2cc:	1782                	slli	a5,a5,0x20
 2ce:	9381                	srli	a5,a5,0x20
 2d0:	fff7c793          	not	a5,a5
 2d4:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2d6:	15fd                	addi	a1,a1,-1
 2d8:	177d                	addi	a4,a4,-1
 2da:	0005c683          	lbu	a3,0(a1)
 2de:	00d70023          	sb	a3,0(a4)
    while (n-- > 0)
 2e2:	fee79ae3          	bne	a5,a4,2d6 <memmove+0x46>
 2e6:	bfc9                	j	2b8 <memmove+0x28>

00000000000002e8 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2e8:	1141                	addi	sp,sp,-16
 2ea:	e422                	sd	s0,8(sp)
 2ec:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2ee:	ca05                	beqz	a2,31e <memcmp+0x36>
 2f0:	fff6069b          	addiw	a3,a2,-1
 2f4:	1682                	slli	a3,a3,0x20
 2f6:	9281                	srli	a3,a3,0x20
 2f8:	0685                	addi	a3,a3,1
 2fa:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 2fc:	00054783          	lbu	a5,0(a0)
 300:	0005c703          	lbu	a4,0(a1)
 304:	00e79863          	bne	a5,a4,314 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 308:	0505                	addi	a0,a0,1
    p2++;
 30a:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 30c:	fed518e3          	bne	a0,a3,2fc <memcmp+0x14>
  }
  return 0;
 310:	4501                	li	a0,0
 312:	a019                	j	318 <memcmp+0x30>
      return *p1 - *p2;
 314:	40e7853b          	subw	a0,a5,a4
}
 318:	6422                	ld	s0,8(sp)
 31a:	0141                	addi	sp,sp,16
 31c:	8082                	ret
  return 0;
 31e:	4501                	li	a0,0
 320:	bfe5                	j	318 <memcmp+0x30>

0000000000000322 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 322:	1141                	addi	sp,sp,-16
 324:	e406                	sd	ra,8(sp)
 326:	e022                	sd	s0,0(sp)
 328:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 32a:	f67ff0ef          	jal	ra,290 <memmove>
}
 32e:	60a2                	ld	ra,8(sp)
 330:	6402                	ld	s0,0(sp)
 332:	0141                	addi	sp,sp,16
 334:	8082                	ret

0000000000000336 <sbrk>:

char *
sbrk(int n)
{
 336:	1141                	addi	sp,sp,-16
 338:	e406                	sd	ra,8(sp)
 33a:	e022                	sd	s0,0(sp)
 33c:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 33e:	4585                	li	a1,1
 340:	0b2000ef          	jal	ra,3f2 <sys_sbrk>
}
 344:	60a2                	ld	ra,8(sp)
 346:	6402                	ld	s0,0(sp)
 348:	0141                	addi	sp,sp,16
 34a:	8082                	ret

000000000000034c <sbrklazy>:

char *
sbrklazy(int n)
{
 34c:	1141                	addi	sp,sp,-16
 34e:	e406                	sd	ra,8(sp)
 350:	e022                	sd	s0,0(sp)
 352:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 354:	4589                	li	a1,2
 356:	09c000ef          	jal	ra,3f2 <sys_sbrk>
}
 35a:	60a2                	ld	ra,8(sp)
 35c:	6402                	ld	s0,0(sp)
 35e:	0141                	addi	sp,sp,16
 360:	8082                	ret

0000000000000362 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 362:	4885                	li	a7,1
 ecall
 364:	00000073          	ecall
 ret
 368:	8082                	ret

000000000000036a <exit>:
.global exit
exit:
 li a7, SYS_exit
 36a:	4889                	li	a7,2
 ecall
 36c:	00000073          	ecall
 ret
 370:	8082                	ret

0000000000000372 <wait>:
.global wait
wait:
 li a7, SYS_wait
 372:	488d                	li	a7,3
 ecall
 374:	00000073          	ecall
 ret
 378:	8082                	ret

000000000000037a <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 37a:	4891                	li	a7,4
 ecall
 37c:	00000073          	ecall
 ret
 380:	8082                	ret

0000000000000382 <read>:
.global read
read:
 li a7, SYS_read
 382:	4895                	li	a7,5
 ecall
 384:	00000073          	ecall
 ret
 388:	8082                	ret

000000000000038a <write>:
.global write
write:
 li a7, SYS_write
 38a:	48c1                	li	a7,16
 ecall
 38c:	00000073          	ecall
 ret
 390:	8082                	ret

0000000000000392 <close>:
.global close
close:
 li a7, SYS_close
 392:	48d5                	li	a7,21
 ecall
 394:	00000073          	ecall
 ret
 398:	8082                	ret

000000000000039a <kill>:
.global kill
kill:
 li a7, SYS_kill
 39a:	4899                	li	a7,6
 ecall
 39c:	00000073          	ecall
 ret
 3a0:	8082                	ret

00000000000003a2 <exec>:
.global exec
exec:
 li a7, SYS_exec
 3a2:	489d                	li	a7,7
 ecall
 3a4:	00000073          	ecall
 ret
 3a8:	8082                	ret

00000000000003aa <open>:
.global open
open:
 li a7, SYS_open
 3aa:	48bd                	li	a7,15
 ecall
 3ac:	00000073          	ecall
 ret
 3b0:	8082                	ret

00000000000003b2 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3b2:	48c5                	li	a7,17
 ecall
 3b4:	00000073          	ecall
 ret
 3b8:	8082                	ret

00000000000003ba <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 3ba:	48c9                	li	a7,18
 ecall
 3bc:	00000073          	ecall
 ret
 3c0:	8082                	ret

00000000000003c2 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3c2:	48a1                	li	a7,8
 ecall
 3c4:	00000073          	ecall
 ret
 3c8:	8082                	ret

00000000000003ca <link>:
.global link
link:
 li a7, SYS_link
 3ca:	48cd                	li	a7,19
 ecall
 3cc:	00000073          	ecall
 ret
 3d0:	8082                	ret

00000000000003d2 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3d2:	48d1                	li	a7,20
 ecall
 3d4:	00000073          	ecall
 ret
 3d8:	8082                	ret

00000000000003da <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3da:	48a5                	li	a7,9
 ecall
 3dc:	00000073          	ecall
 ret
 3e0:	8082                	ret

00000000000003e2 <dup>:
.global dup
dup:
 li a7, SYS_dup
 3e2:	48a9                	li	a7,10
 ecall
 3e4:	00000073          	ecall
 ret
 3e8:	8082                	ret

00000000000003ea <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 3ea:	48ad                	li	a7,11
 ecall
 3ec:	00000073          	ecall
 ret
 3f0:	8082                	ret

00000000000003f2 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 3f2:	48b1                	li	a7,12
 ecall
 3f4:	00000073          	ecall
 ret
 3f8:	8082                	ret

00000000000003fa <pause>:
.global pause
pause:
 li a7, SYS_pause
 3fa:	48b5                	li	a7,13
 ecall
 3fc:	00000073          	ecall
 ret
 400:	8082                	ret

0000000000000402 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 402:	48b9                	li	a7,14
 ecall
 404:	00000073          	ecall
 ret
 408:	8082                	ret

000000000000040a <sync>:
.global sync
sync:
 li a7, SYS_sync
 40a:	48d9                	li	a7,22
 ecall
 40c:	00000073          	ecall
 ret
 410:	8082                	ret

0000000000000412 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 412:	1101                	addi	sp,sp,-32
 414:	ec06                	sd	ra,24(sp)
 416:	e822                	sd	s0,16(sp)
 418:	1000                	addi	s0,sp,32
 41a:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 41e:	4605                	li	a2,1
 420:	fef40593          	addi	a1,s0,-17
 424:	f67ff0ef          	jal	ra,38a <write>
}
 428:	60e2                	ld	ra,24(sp)
 42a:	6442                	ld	s0,16(sp)
 42c:	6105                	addi	sp,sp,32
 42e:	8082                	ret

0000000000000430 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 430:	715d                	addi	sp,sp,-80
 432:	e486                	sd	ra,72(sp)
 434:	e0a2                	sd	s0,64(sp)
 436:	fc26                	sd	s1,56(sp)
 438:	f84a                	sd	s2,48(sp)
 43a:	f44e                	sd	s3,40(sp)
 43c:	0880                	addi	s0,sp,80
 43e:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if (sgn && xx < 0) {
 440:	c299                	beqz	a3,446 <printint+0x16>
 442:	0805c163          	bltz	a1,4c4 <printint+0x94>
  neg = 0;
 446:	4881                	li	a7,0
 448:	fb840693          	addi	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 44c:	4781                	li	a5,0
  do {
    buf[i++] = digits[x % base];
 44e:	00000517          	auipc	a0,0x0
 452:	5a250513          	addi	a0,a0,1442 # 9f0 <digits>
 456:	883e                	mv	a6,a5
 458:	2785                	addiw	a5,a5,1
 45a:	02c5f733          	remu	a4,a1,a2
 45e:	972a                	add	a4,a4,a0
 460:	00074703          	lbu	a4,0(a4)
 464:	00e68023          	sb	a4,0(a3)
  } while ((x /= base) != 0);
 468:	872e                	mv	a4,a1
 46a:	02c5d5b3          	divu	a1,a1,a2
 46e:	0685                	addi	a3,a3,1
 470:	fec773e3          	bgeu	a4,a2,456 <printint+0x26>
  if (neg)
 474:	00088b63          	beqz	a7,48a <printint+0x5a>
    buf[i++] = '-';
 478:	fd078793          	addi	a5,a5,-48
 47c:	97a2                	add	a5,a5,s0
 47e:	02d00713          	li	a4,45
 482:	fee78423          	sb	a4,-24(a5)
 486:	0028079b          	addiw	a5,a6,2

  while (--i >= 0)
 48a:	02f05663          	blez	a5,4b6 <printint+0x86>
 48e:	fb840713          	addi	a4,s0,-72
 492:	00f704b3          	add	s1,a4,a5
 496:	fff70993          	addi	s3,a4,-1
 49a:	99be                	add	s3,s3,a5
 49c:	37fd                	addiw	a5,a5,-1
 49e:	1782                	slli	a5,a5,0x20
 4a0:	9381                	srli	a5,a5,0x20
 4a2:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
 4a6:	fff4c583          	lbu	a1,-1(s1)
 4aa:	854a                	mv	a0,s2
 4ac:	f67ff0ef          	jal	ra,412 <putc>
  while (--i >= 0)
 4b0:	14fd                	addi	s1,s1,-1
 4b2:	ff349ae3          	bne	s1,s3,4a6 <printint+0x76>
}
 4b6:	60a6                	ld	ra,72(sp)
 4b8:	6406                	ld	s0,64(sp)
 4ba:	74e2                	ld	s1,56(sp)
 4bc:	7942                	ld	s2,48(sp)
 4be:	79a2                	ld	s3,40(sp)
 4c0:	6161                	addi	sp,sp,80
 4c2:	8082                	ret
    x = -xx;
 4c4:	40b005b3          	neg	a1,a1
    neg = 1;
 4c8:	4885                	li	a7,1
    x = -xx;
 4ca:	bfbd                	j	448 <printint+0x18>

00000000000004cc <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 4cc:	7119                	addi	sp,sp,-128
 4ce:	fc86                	sd	ra,120(sp)
 4d0:	f8a2                	sd	s0,112(sp)
 4d2:	f4a6                	sd	s1,104(sp)
 4d4:	f0ca                	sd	s2,96(sp)
 4d6:	ecce                	sd	s3,88(sp)
 4d8:	e8d2                	sd	s4,80(sp)
 4da:	e4d6                	sd	s5,72(sp)
 4dc:	e0da                	sd	s6,64(sp)
 4de:	fc5e                	sd	s7,56(sp)
 4e0:	f862                	sd	s8,48(sp)
 4e2:	f466                	sd	s9,40(sp)
 4e4:	f06a                	sd	s10,32(sp)
 4e6:	ec6e                	sd	s11,24(sp)
 4e8:	0100                	addi	s0,sp,128
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for (i = 0; fmt[i]; i++) {
 4ea:	0005c903          	lbu	s2,0(a1)
 4ee:	24090c63          	beqz	s2,746 <vprintf+0x27a>
 4f2:	8b2a                	mv	s6,a0
 4f4:	8a2e                	mv	s4,a1
 4f6:	8bb2                	mv	s7,a2
  state = 0;
 4f8:	4981                	li	s3,0
  for (i = 0; fmt[i]; i++) {
 4fa:	4481                	li	s1,0
 4fc:	4701                	li	a4,0
      if (c0 == '%') {
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if (state == '%') {
 4fe:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if (c0)
        c1 = fmt[i + 1] & 0xff;
      if (c1)
        c2 = fmt[i + 2] & 0xff;
      if (c0 == 'd') {
 502:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if (c0 == 'l' && c1 == 'd') {
 506:	06c00d13          	li	s10,108
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'd') {
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if (c0 == 'u') {
 50a:	07500d93          	li	s11,117
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 50e:	00000c97          	auipc	s9,0x0
 512:	4e2c8c93          	addi	s9,s9,1250 # 9f0 <digits>
 516:	a005                	j	536 <vprintf+0x6a>
        putc(fd, c0);
 518:	85ca                	mv	a1,s2
 51a:	855a                	mv	a0,s6
 51c:	ef7ff0ef          	jal	ra,412 <putc>
 520:	a019                	j	526 <vprintf+0x5a>
    } else if (state == '%') {
 522:	03598263          	beq	s3,s5,546 <vprintf+0x7a>
  for (i = 0; fmt[i]; i++) {
 526:	2485                	addiw	s1,s1,1
 528:	8726                	mv	a4,s1
 52a:	009a07b3          	add	a5,s4,s1
 52e:	0007c903          	lbu	s2,0(a5)
 532:	20090a63          	beqz	s2,746 <vprintf+0x27a>
    c0 = fmt[i] & 0xff;
 536:	0009079b          	sext.w	a5,s2
    if (state == 0) {
 53a:	fe0994e3          	bnez	s3,522 <vprintf+0x56>
      if (c0 == '%') {
 53e:	fd579de3          	bne	a5,s5,518 <vprintf+0x4c>
        state = '%';
 542:	89be                	mv	s3,a5
 544:	b7cd                	j	526 <vprintf+0x5a>
      if (c0)
 546:	c3c1                	beqz	a5,5c6 <vprintf+0xfa>
        c1 = fmt[i + 1] & 0xff;
 548:	00ea06b3          	add	a3,s4,a4
 54c:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 550:	8636                	mv	a2,a3
      if (c1)
 552:	c681                	beqz	a3,55a <vprintf+0x8e>
        c2 = fmt[i + 2] & 0xff;
 554:	9752                	add	a4,a4,s4
 556:	00274603          	lbu	a2,2(a4)
      if (c0 == 'd') {
 55a:	03878e63          	beq	a5,s8,596 <vprintf+0xca>
      } else if (c0 == 'l' && c1 == 'd') {
 55e:	05a78863          	beq	a5,s10,5ae <vprintf+0xe2>
      } else if (c0 == 'u') {
 562:	0db78b63          	beq	a5,s11,638 <vprintf+0x16c>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'u') {
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if (c0 == 'x') {
 566:	07800713          	li	a4,120
 56a:	10e78d63          	beq	a5,a4,684 <vprintf+0x1b8>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'x') {
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if (c0 == 'p') {
 56e:	07000713          	li	a4,112
 572:	14e78263          	beq	a5,a4,6b6 <vprintf+0x1ea>
        printptr(fd, va_arg(ap, uint64));
      } else if (c0 == 'c') {
 576:	06300713          	li	a4,99
 57a:	16e78f63          	beq	a5,a4,6f8 <vprintf+0x22c>
        putc(fd, va_arg(ap, uint32));
      } else if (c0 == 's') {
 57e:	07300713          	li	a4,115
 582:	18e78563          	beq	a5,a4,70c <vprintf+0x240>
        if ((s = va_arg(ap, char *)) == 0)
          s = "(null)";
        for (; *s; s++)
          putc(fd, *s);
      } else if (c0 == '%') {
 586:	05579063          	bne	a5,s5,5c6 <vprintf+0xfa>
        putc(fd, '%');
 58a:	85d6                	mv	a1,s5
 58c:	855a                	mv	a0,s6
 58e:	e85ff0ef          	jal	ra,412 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 592:	4981                	li	s3,0
 594:	bf49                	j	526 <vprintf+0x5a>
        printint(fd, va_arg(ap, int), 10, 1);
 596:	008b8913          	addi	s2,s7,8
 59a:	4685                	li	a3,1
 59c:	4629                	li	a2,10
 59e:	000ba583          	lw	a1,0(s7)
 5a2:	855a                	mv	a0,s6
 5a4:	e8dff0ef          	jal	ra,430 <printint>
 5a8:	8bca                	mv	s7,s2
      state = 0;
 5aa:	4981                	li	s3,0
 5ac:	bfad                	j	526 <vprintf+0x5a>
      } else if (c0 == 'l' && c1 == 'd') {
 5ae:	03868663          	beq	a3,s8,5da <vprintf+0x10e>
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'd') {
 5b2:	05a68163          	beq	a3,s10,5f4 <vprintf+0x128>
      } else if (c0 == 'l' && c1 == 'u') {
 5b6:	09b68d63          	beq	a3,s11,650 <vprintf+0x184>
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'u') {
 5ba:	03a68f63          	beq	a3,s10,5f8 <vprintf+0x12c>
      } else if (c0 == 'l' && c1 == 'x') {
 5be:	07800793          	li	a5,120
 5c2:	0cf68d63          	beq	a3,a5,69c <vprintf+0x1d0>
        putc(fd, '%');
 5c6:	85d6                	mv	a1,s5
 5c8:	855a                	mv	a0,s6
 5ca:	e49ff0ef          	jal	ra,412 <putc>
        putc(fd, c0);
 5ce:	85ca                	mv	a1,s2
 5d0:	855a                	mv	a0,s6
 5d2:	e41ff0ef          	jal	ra,412 <putc>
      state = 0;
 5d6:	4981                	li	s3,0
 5d8:	b7b9                	j	526 <vprintf+0x5a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 5da:	008b8913          	addi	s2,s7,8
 5de:	4685                	li	a3,1
 5e0:	4629                	li	a2,10
 5e2:	000bb583          	ld	a1,0(s7)
 5e6:	855a                	mv	a0,s6
 5e8:	e49ff0ef          	jal	ra,430 <printint>
        i += 1;
 5ec:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 5ee:	8bca                	mv	s7,s2
      state = 0;
 5f0:	4981                	li	s3,0
        i += 1;
 5f2:	bf15                	j	526 <vprintf+0x5a>
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'd') {
 5f4:	03860563          	beq	a2,s8,61e <vprintf+0x152>
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'u') {
 5f8:	07b60963          	beq	a2,s11,66a <vprintf+0x19e>
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'x') {
 5fc:	07800793          	li	a5,120
 600:	fcf613e3          	bne	a2,a5,5c6 <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 604:	008b8913          	addi	s2,s7,8
 608:	4681                	li	a3,0
 60a:	4641                	li	a2,16
 60c:	000bb583          	ld	a1,0(s7)
 610:	855a                	mv	a0,s6
 612:	e1fff0ef          	jal	ra,430 <printint>
        i += 2;
 616:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 618:	8bca                	mv	s7,s2
      state = 0;
 61a:	4981                	li	s3,0
        i += 2;
 61c:	b729                	j	526 <vprintf+0x5a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 61e:	008b8913          	addi	s2,s7,8
 622:	4685                	li	a3,1
 624:	4629                	li	a2,10
 626:	000bb583          	ld	a1,0(s7)
 62a:	855a                	mv	a0,s6
 62c:	e05ff0ef          	jal	ra,430 <printint>
        i += 2;
 630:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 632:	8bca                	mv	s7,s2
      state = 0;
 634:	4981                	li	s3,0
        i += 2;
 636:	bdc5                	j	526 <vprintf+0x5a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 638:	008b8913          	addi	s2,s7,8
 63c:	4681                	li	a3,0
 63e:	4629                	li	a2,10
 640:	000be583          	lwu	a1,0(s7)
 644:	855a                	mv	a0,s6
 646:	debff0ef          	jal	ra,430 <printint>
 64a:	8bca                	mv	s7,s2
      state = 0;
 64c:	4981                	li	s3,0
 64e:	bde1                	j	526 <vprintf+0x5a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 650:	008b8913          	addi	s2,s7,8
 654:	4681                	li	a3,0
 656:	4629                	li	a2,10
 658:	000bb583          	ld	a1,0(s7)
 65c:	855a                	mv	a0,s6
 65e:	dd3ff0ef          	jal	ra,430 <printint>
        i += 1;
 662:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 664:	8bca                	mv	s7,s2
      state = 0;
 666:	4981                	li	s3,0
        i += 1;
 668:	bd7d                	j	526 <vprintf+0x5a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 66a:	008b8913          	addi	s2,s7,8
 66e:	4681                	li	a3,0
 670:	4629                	li	a2,10
 672:	000bb583          	ld	a1,0(s7)
 676:	855a                	mv	a0,s6
 678:	db9ff0ef          	jal	ra,430 <printint>
        i += 2;
 67c:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 67e:	8bca                	mv	s7,s2
      state = 0;
 680:	4981                	li	s3,0
        i += 2;
 682:	b555                	j	526 <vprintf+0x5a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 684:	008b8913          	addi	s2,s7,8
 688:	4681                	li	a3,0
 68a:	4641                	li	a2,16
 68c:	000be583          	lwu	a1,0(s7)
 690:	855a                	mv	a0,s6
 692:	d9fff0ef          	jal	ra,430 <printint>
 696:	8bca                	mv	s7,s2
      state = 0;
 698:	4981                	li	s3,0
 69a:	b571                	j	526 <vprintf+0x5a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 69c:	008b8913          	addi	s2,s7,8
 6a0:	4681                	li	a3,0
 6a2:	4641                	li	a2,16
 6a4:	000bb583          	ld	a1,0(s7)
 6a8:	855a                	mv	a0,s6
 6aa:	d87ff0ef          	jal	ra,430 <printint>
        i += 1;
 6ae:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 6b0:	8bca                	mv	s7,s2
      state = 0;
 6b2:	4981                	li	s3,0
        i += 1;
 6b4:	bd8d                	j	526 <vprintf+0x5a>
        printptr(fd, va_arg(ap, uint64));
 6b6:	008b8793          	addi	a5,s7,8
 6ba:	f8f43423          	sd	a5,-120(s0)
 6be:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 6c2:	03000593          	li	a1,48
 6c6:	855a                	mv	a0,s6
 6c8:	d4bff0ef          	jal	ra,412 <putc>
  putc(fd, 'x');
 6cc:	07800593          	li	a1,120
 6d0:	855a                	mv	a0,s6
 6d2:	d41ff0ef          	jal	ra,412 <putc>
 6d6:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6d8:	03c9d793          	srli	a5,s3,0x3c
 6dc:	97e6                	add	a5,a5,s9
 6de:	0007c583          	lbu	a1,0(a5)
 6e2:	855a                	mv	a0,s6
 6e4:	d2fff0ef          	jal	ra,412 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 6e8:	0992                	slli	s3,s3,0x4
 6ea:	397d                	addiw	s2,s2,-1
 6ec:	fe0916e3          	bnez	s2,6d8 <vprintf+0x20c>
        printptr(fd, va_arg(ap, uint64));
 6f0:	f8843b83          	ld	s7,-120(s0)
      state = 0;
 6f4:	4981                	li	s3,0
 6f6:	bd05                	j	526 <vprintf+0x5a>
        putc(fd, va_arg(ap, uint32));
 6f8:	008b8913          	addi	s2,s7,8
 6fc:	000bc583          	lbu	a1,0(s7)
 700:	855a                	mv	a0,s6
 702:	d11ff0ef          	jal	ra,412 <putc>
 706:	8bca                	mv	s7,s2
      state = 0;
 708:	4981                	li	s3,0
 70a:	bd31                	j	526 <vprintf+0x5a>
        if ((s = va_arg(ap, char *)) == 0)
 70c:	008b8993          	addi	s3,s7,8
 710:	000bb903          	ld	s2,0(s7)
 714:	00090f63          	beqz	s2,732 <vprintf+0x266>
        for (; *s; s++)
 718:	00094583          	lbu	a1,0(s2)
 71c:	c195                	beqz	a1,740 <vprintf+0x274>
          putc(fd, *s);
 71e:	855a                	mv	a0,s6
 720:	cf3ff0ef          	jal	ra,412 <putc>
        for (; *s; s++)
 724:	0905                	addi	s2,s2,1
 726:	00094583          	lbu	a1,0(s2)
 72a:	f9f5                	bnez	a1,71e <vprintf+0x252>
        if ((s = va_arg(ap, char *)) == 0)
 72c:	8bce                	mv	s7,s3
      state = 0;
 72e:	4981                	li	s3,0
 730:	bbdd                	j	526 <vprintf+0x5a>
          s = "(null)";
 732:	00000917          	auipc	s2,0x0
 736:	2b690913          	addi	s2,s2,694 # 9e8 <malloc+0x1a6>
        for (; *s; s++)
 73a:	02800593          	li	a1,40
 73e:	b7c5                	j	71e <vprintf+0x252>
        if ((s = va_arg(ap, char *)) == 0)
 740:	8bce                	mv	s7,s3
      state = 0;
 742:	4981                	li	s3,0
 744:	b3cd                	j	526 <vprintf+0x5a>
    }
  }
}
 746:	70e6                	ld	ra,120(sp)
 748:	7446                	ld	s0,112(sp)
 74a:	74a6                	ld	s1,104(sp)
 74c:	7906                	ld	s2,96(sp)
 74e:	69e6                	ld	s3,88(sp)
 750:	6a46                	ld	s4,80(sp)
 752:	6aa6                	ld	s5,72(sp)
 754:	6b06                	ld	s6,64(sp)
 756:	7be2                	ld	s7,56(sp)
 758:	7c42                	ld	s8,48(sp)
 75a:	7ca2                	ld	s9,40(sp)
 75c:	7d02                	ld	s10,32(sp)
 75e:	6de2                	ld	s11,24(sp)
 760:	6109                	addi	sp,sp,128
 762:	8082                	ret

0000000000000764 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 764:	715d                	addi	sp,sp,-80
 766:	ec06                	sd	ra,24(sp)
 768:	e822                	sd	s0,16(sp)
 76a:	1000                	addi	s0,sp,32
 76c:	e010                	sd	a2,0(s0)
 76e:	e414                	sd	a3,8(s0)
 770:	e818                	sd	a4,16(s0)
 772:	ec1c                	sd	a5,24(s0)
 774:	03043023          	sd	a6,32(s0)
 778:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 77c:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 780:	8622                	mv	a2,s0
 782:	d4bff0ef          	jal	ra,4cc <vprintf>
}
 786:	60e2                	ld	ra,24(sp)
 788:	6442                	ld	s0,16(sp)
 78a:	6161                	addi	sp,sp,80
 78c:	8082                	ret

000000000000078e <printf>:

void
printf(const char *fmt, ...)
{
 78e:	711d                	addi	sp,sp,-96
 790:	ec06                	sd	ra,24(sp)
 792:	e822                	sd	s0,16(sp)
 794:	1000                	addi	s0,sp,32
 796:	e40c                	sd	a1,8(s0)
 798:	e810                	sd	a2,16(s0)
 79a:	ec14                	sd	a3,24(s0)
 79c:	f018                	sd	a4,32(s0)
 79e:	f41c                	sd	a5,40(s0)
 7a0:	03043823          	sd	a6,48(s0)
 7a4:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 7a8:	00840613          	addi	a2,s0,8
 7ac:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 7b0:	85aa                	mv	a1,a0
 7b2:	4505                	li	a0,1
 7b4:	d19ff0ef          	jal	ra,4cc <vprintf>
}
 7b8:	60e2                	ld	ra,24(sp)
 7ba:	6442                	ld	s0,16(sp)
 7bc:	6125                	addi	sp,sp,96
 7be:	8082                	ret

00000000000007c0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7c0:	1141                	addi	sp,sp,-16
 7c2:	e422                	sd	s0,8(sp)
 7c4:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header *)ap - 1;
 7c6:	ff050693          	addi	a3,a0,-16
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7ca:	00001797          	auipc	a5,0x1
 7ce:	8367b783          	ld	a5,-1994(a5) # 1000 <freep>
 7d2:	a02d                	j	7fc <free+0x3c>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if (bp + bp->s.size == p->s.ptr) {
    bp->s.size += p->s.ptr->s.size;
 7d4:	4618                	lw	a4,8(a2)
 7d6:	9f2d                	addw	a4,a4,a1
 7d8:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 7dc:	6398                	ld	a4,0(a5)
 7de:	6310                	ld	a2,0(a4)
 7e0:	a83d                	j	81e <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if (p + p->s.size == bp) {
    p->s.size += bp->s.size;
 7e2:	ff852703          	lw	a4,-8(a0)
 7e6:	9f31                	addw	a4,a4,a2
 7e8:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 7ea:	ff053683          	ld	a3,-16(a0)
 7ee:	a091                	j	832 <free+0x72>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7f0:	6398                	ld	a4,0(a5)
 7f2:	00e7e463          	bltu	a5,a4,7fa <free+0x3a>
 7f6:	00e6ea63          	bltu	a3,a4,80a <free+0x4a>
{
 7fa:	87ba                	mv	a5,a4
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7fc:	fed7fae3          	bgeu	a5,a3,7f0 <free+0x30>
 800:	6398                	ld	a4,0(a5)
 802:	00e6e463          	bltu	a3,a4,80a <free+0x4a>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 806:	fee7eae3          	bltu	a5,a4,7fa <free+0x3a>
  if (bp + bp->s.size == p->s.ptr) {
 80a:	ff852583          	lw	a1,-8(a0)
 80e:	6390                	ld	a2,0(a5)
 810:	02059813          	slli	a6,a1,0x20
 814:	01c85713          	srli	a4,a6,0x1c
 818:	9736                	add	a4,a4,a3
 81a:	fae60de3          	beq	a2,a4,7d4 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 81e:	fec53823          	sd	a2,-16(a0)
  if (p + p->s.size == bp) {
 822:	4790                	lw	a2,8(a5)
 824:	02061593          	slli	a1,a2,0x20
 828:	01c5d713          	srli	a4,a1,0x1c
 82c:	973e                	add	a4,a4,a5
 82e:	fae68ae3          	beq	a3,a4,7e2 <free+0x22>
    p->s.ptr = bp->s.ptr;
 832:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 834:	00000717          	auipc	a4,0x0
 838:	7cf73623          	sd	a5,1996(a4) # 1000 <freep>
}
 83c:	6422                	ld	s0,8(sp)
 83e:	0141                	addi	sp,sp,16
 840:	8082                	ret

0000000000000842 <malloc>:
  return freep;
}

void *
malloc(uint nbytes)
{
 842:	7139                	addi	sp,sp,-64
 844:	fc06                	sd	ra,56(sp)
 846:	f822                	sd	s0,48(sp)
 848:	f426                	sd	s1,40(sp)
 84a:	f04a                	sd	s2,32(sp)
 84c:	ec4e                	sd	s3,24(sp)
 84e:	e852                	sd	s4,16(sp)
 850:	e456                	sd	s5,8(sp)
 852:	e05a                	sd	s6,0(sp)
 854:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 856:	02051493          	slli	s1,a0,0x20
 85a:	9081                	srli	s1,s1,0x20
 85c:	04bd                	addi	s1,s1,15
 85e:	8091                	srli	s1,s1,0x4
 860:	0014899b          	addiw	s3,s1,1
 864:	0485                	addi	s1,s1,1
  if ((prevp = freep) == 0) {
 866:	00000517          	auipc	a0,0x0
 86a:	79a53503          	ld	a0,1946(a0) # 1000 <freep>
 86e:	c515                	beqz	a0,89a <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
 870:	611c                	ld	a5,0(a0)
    if (p->s.size >= nunits) {
 872:	4798                	lw	a4,8(a5)
 874:	02977f63          	bgeu	a4,s1,8b2 <malloc+0x70>
 878:	8a4e                	mv	s4,s3
 87a:	0009871b          	sext.w	a4,s3
 87e:	6685                	lui	a3,0x1
 880:	00d77363          	bgeu	a4,a3,886 <malloc+0x44>
 884:	6a05                	lui	s4,0x1
 886:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 88a:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void *)(p + 1);
    }
    if (p == freep)
 88e:	00000917          	auipc	s2,0x0
 892:	77290913          	addi	s2,s2,1906 # 1000 <freep>
  if (p == SBRK_ERROR)
 896:	5afd                	li	s5,-1
 898:	a885                	j	908 <malloc+0xc6>
    base.s.ptr = freep = prevp = &base;
 89a:	00000797          	auipc	a5,0x0
 89e:	77678793          	addi	a5,a5,1910 # 1010 <base>
 8a2:	00000717          	auipc	a4,0x0
 8a6:	74f73f23          	sd	a5,1886(a4) # 1000 <freep>
 8aa:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 8ac:	0007a423          	sw	zero,8(a5)
    if (p->s.size >= nunits) {
 8b0:	b7e1                	j	878 <malloc+0x36>
      if (p->s.size == nunits)
 8b2:	02e48c63          	beq	s1,a4,8ea <malloc+0xa8>
        p->s.size -= nunits;
 8b6:	4137073b          	subw	a4,a4,s3
 8ba:	c798                	sw	a4,8(a5)
        p += p->s.size;
 8bc:	02071693          	slli	a3,a4,0x20
 8c0:	01c6d713          	srli	a4,a3,0x1c
 8c4:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 8c6:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 8ca:	00000717          	auipc	a4,0x0
 8ce:	72a73b23          	sd	a0,1846(a4) # 1000 <freep>
      return (void *)(p + 1);
 8d2:	01078513          	addi	a0,a5,16
      if ((p = morecore(nunits)) == 0)
        return 0;
  }
}
 8d6:	70e2                	ld	ra,56(sp)
 8d8:	7442                	ld	s0,48(sp)
 8da:	74a2                	ld	s1,40(sp)
 8dc:	7902                	ld	s2,32(sp)
 8de:	69e2                	ld	s3,24(sp)
 8e0:	6a42                	ld	s4,16(sp)
 8e2:	6aa2                	ld	s5,8(sp)
 8e4:	6b02                	ld	s6,0(sp)
 8e6:	6121                	addi	sp,sp,64
 8e8:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 8ea:	6398                	ld	a4,0(a5)
 8ec:	e118                	sd	a4,0(a0)
 8ee:	bff1                	j	8ca <malloc+0x88>
  hp->s.size = nu;
 8f0:	01652423          	sw	s6,8(a0)
  free((void *)(hp + 1));
 8f4:	0541                	addi	a0,a0,16
 8f6:	ecbff0ef          	jal	ra,7c0 <free>
  return freep;
 8fa:	00093503          	ld	a0,0(s2)
      if ((p = morecore(nunits)) == 0)
 8fe:	dd61                	beqz	a0,8d6 <malloc+0x94>
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
 900:	611c                	ld	a5,0(a0)
    if (p->s.size >= nunits) {
 902:	4798                	lw	a4,8(a5)
 904:	fa9777e3          	bgeu	a4,s1,8b2 <malloc+0x70>
    if (p == freep)
 908:	00093703          	ld	a4,0(s2)
 90c:	853e                	mv	a0,a5
 90e:	fef719e3          	bne	a4,a5,900 <malloc+0xbe>
  p = sbrk(nu * sizeof(Header));
 912:	8552                	mv	a0,s4
 914:	a23ff0ef          	jal	ra,336 <sbrk>
  if (p == SBRK_ERROR)
 918:	fd551ce3          	bne	a0,s5,8f0 <malloc+0xae>
        return 0;
 91c:	4501                	li	a0,0
 91e:	bf65                	j	8d6 <malloc+0x94>
