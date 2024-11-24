
user/_helloq:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "kernel/fs.h"
#include "kernel/param.h"
#include "kernel/riscv.h"

int main() {
   0:	1141                	addi	sp,sp,-16
   2:	e406                	sd	ra,8(sp)
   4:	e022                	sd	s0,0(sp)
   6:	0800                	addi	s0,sp,16
// machine-mode cycle counter
static inline uint64
r_time()
{
  uint64 x;
  asm volatile("csrr %0, time" : "=r" (x) );
   8:	c01027f3          	rdtime	a5
   c:	c01025f3          	rdtime	a1
      // Wait for 1 second

    end_time = r_time();  // Get the end time
    uint64 overall = end_time - start_time;

    printf("# of ticks in 1 second = %lu\n", overall);  // Correct format specifier
  10:	8d9d                	sub	a1,a1,a5
  12:	00001517          	auipc	a0,0x1
  16:	83e50513          	addi	a0,a0,-1986 # 850 <malloc+0xe0>
  1a:	69c000ef          	jal	ra,6b6 <printf>
    return 0;
}
  1e:	4501                	li	a0,0
  20:	60a2                	ld	ra,8(sp)
  22:	6402                	ld	s0,0(sp)
  24:	0141                	addi	sp,sp,16
  26:	8082                	ret

0000000000000028 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
  28:	1141                	addi	sp,sp,-16
  2a:	e406                	sd	ra,8(sp)
  2c:	e022                	sd	s0,0(sp)
  2e:	0800                	addi	s0,sp,16
  extern int main();
  main();
  30:	fd1ff0ef          	jal	ra,0 <main>
  exit(0);
  34:	4501                	li	a0,0
  36:	25e000ef          	jal	ra,294 <exit>

000000000000003a <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  3a:	1141                	addi	sp,sp,-16
  3c:	e422                	sd	s0,8(sp)
  3e:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  40:	87aa                	mv	a5,a0
  42:	0585                	addi	a1,a1,1
  44:	0785                	addi	a5,a5,1
  46:	fff5c703          	lbu	a4,-1(a1)
  4a:	fee78fa3          	sb	a4,-1(a5)
  4e:	fb75                	bnez	a4,42 <strcpy+0x8>
    ;
  return os;
}
  50:	6422                	ld	s0,8(sp)
  52:	0141                	addi	sp,sp,16
  54:	8082                	ret

0000000000000056 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  56:	1141                	addi	sp,sp,-16
  58:	e422                	sd	s0,8(sp)
  5a:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  5c:	00054783          	lbu	a5,0(a0)
  60:	cb91                	beqz	a5,74 <strcmp+0x1e>
  62:	0005c703          	lbu	a4,0(a1)
  66:	00f71763          	bne	a4,a5,74 <strcmp+0x1e>
    p++, q++;
  6a:	0505                	addi	a0,a0,1
  6c:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  6e:	00054783          	lbu	a5,0(a0)
  72:	fbe5                	bnez	a5,62 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
  74:	0005c503          	lbu	a0,0(a1)
}
  78:	40a7853b          	subw	a0,a5,a0
  7c:	6422                	ld	s0,8(sp)
  7e:	0141                	addi	sp,sp,16
  80:	8082                	ret

0000000000000082 <strlen>:

uint
strlen(const char *s)
{
  82:	1141                	addi	sp,sp,-16
  84:	e422                	sd	s0,8(sp)
  86:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  88:	00054783          	lbu	a5,0(a0)
  8c:	cf91                	beqz	a5,a8 <strlen+0x26>
  8e:	0505                	addi	a0,a0,1
  90:	87aa                	mv	a5,a0
  92:	4685                	li	a3,1
  94:	9e89                	subw	a3,a3,a0
  96:	00f6853b          	addw	a0,a3,a5
  9a:	0785                	addi	a5,a5,1
  9c:	fff7c703          	lbu	a4,-1(a5)
  a0:	fb7d                	bnez	a4,96 <strlen+0x14>
    ;
  return n;
}
  a2:	6422                	ld	s0,8(sp)
  a4:	0141                	addi	sp,sp,16
  a6:	8082                	ret
  for(n = 0; s[n]; n++)
  a8:	4501                	li	a0,0
  aa:	bfe5                	j	a2 <strlen+0x20>

00000000000000ac <memset>:

void*
memset(void *dst, int c, uint n)
{
  ac:	1141                	addi	sp,sp,-16
  ae:	e422                	sd	s0,8(sp)
  b0:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  b2:	ca19                	beqz	a2,c8 <memset+0x1c>
  b4:	87aa                	mv	a5,a0
  b6:	1602                	slli	a2,a2,0x20
  b8:	9201                	srli	a2,a2,0x20
  ba:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
  be:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
  c2:	0785                	addi	a5,a5,1
  c4:	fee79de3          	bne	a5,a4,be <memset+0x12>
  }
  return dst;
}
  c8:	6422                	ld	s0,8(sp)
  ca:	0141                	addi	sp,sp,16
  cc:	8082                	ret

00000000000000ce <strchr>:

char*
strchr(const char *s, char c)
{
  ce:	1141                	addi	sp,sp,-16
  d0:	e422                	sd	s0,8(sp)
  d2:	0800                	addi	s0,sp,16
  for(; *s; s++)
  d4:	00054783          	lbu	a5,0(a0)
  d8:	cb99                	beqz	a5,ee <strchr+0x20>
    if(*s == c)
  da:	00f58763          	beq	a1,a5,e8 <strchr+0x1a>
  for(; *s; s++)
  de:	0505                	addi	a0,a0,1
  e0:	00054783          	lbu	a5,0(a0)
  e4:	fbfd                	bnez	a5,da <strchr+0xc>
      return (char*)s;
  return 0;
  e6:	4501                	li	a0,0
}
  e8:	6422                	ld	s0,8(sp)
  ea:	0141                	addi	sp,sp,16
  ec:	8082                	ret
  return 0;
  ee:	4501                	li	a0,0
  f0:	bfe5                	j	e8 <strchr+0x1a>

00000000000000f2 <gets>:

char*
gets(char *buf, int max)
{
  f2:	711d                	addi	sp,sp,-96
  f4:	ec86                	sd	ra,88(sp)
  f6:	e8a2                	sd	s0,80(sp)
  f8:	e4a6                	sd	s1,72(sp)
  fa:	e0ca                	sd	s2,64(sp)
  fc:	fc4e                	sd	s3,56(sp)
  fe:	f852                	sd	s4,48(sp)
 100:	f456                	sd	s5,40(sp)
 102:	f05a                	sd	s6,32(sp)
 104:	ec5e                	sd	s7,24(sp)
 106:	1080                	addi	s0,sp,96
 108:	8baa                	mv	s7,a0
 10a:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 10c:	892a                	mv	s2,a0
 10e:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 110:	4aa9                	li	s5,10
 112:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 114:	89a6                	mv	s3,s1
 116:	2485                	addiw	s1,s1,1
 118:	0344d663          	bge	s1,s4,144 <gets+0x52>
    cc = read(0, &c, 1);
 11c:	4605                	li	a2,1
 11e:	faf40593          	addi	a1,s0,-81
 122:	4501                	li	a0,0
 124:	188000ef          	jal	ra,2ac <read>
    if(cc < 1)
 128:	00a05e63          	blez	a0,144 <gets+0x52>
    buf[i++] = c;
 12c:	faf44783          	lbu	a5,-81(s0)
 130:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 134:	01578763          	beq	a5,s5,142 <gets+0x50>
 138:	0905                	addi	s2,s2,1
 13a:	fd679de3          	bne	a5,s6,114 <gets+0x22>
  for(i=0; i+1 < max; ){
 13e:	89a6                	mv	s3,s1
 140:	a011                	j	144 <gets+0x52>
 142:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 144:	99de                	add	s3,s3,s7
 146:	00098023          	sb	zero,0(s3)
  return buf;
}
 14a:	855e                	mv	a0,s7
 14c:	60e6                	ld	ra,88(sp)
 14e:	6446                	ld	s0,80(sp)
 150:	64a6                	ld	s1,72(sp)
 152:	6906                	ld	s2,64(sp)
 154:	79e2                	ld	s3,56(sp)
 156:	7a42                	ld	s4,48(sp)
 158:	7aa2                	ld	s5,40(sp)
 15a:	7b02                	ld	s6,32(sp)
 15c:	6be2                	ld	s7,24(sp)
 15e:	6125                	addi	sp,sp,96
 160:	8082                	ret

0000000000000162 <stat>:

int
stat(const char *n, struct stat *st)
{
 162:	1101                	addi	sp,sp,-32
 164:	ec06                	sd	ra,24(sp)
 166:	e822                	sd	s0,16(sp)
 168:	e426                	sd	s1,8(sp)
 16a:	e04a                	sd	s2,0(sp)
 16c:	1000                	addi	s0,sp,32
 16e:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 170:	4581                	li	a1,0
 172:	162000ef          	jal	ra,2d4 <open>
  if(fd < 0)
 176:	02054163          	bltz	a0,198 <stat+0x36>
 17a:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 17c:	85ca                	mv	a1,s2
 17e:	16e000ef          	jal	ra,2ec <fstat>
 182:	892a                	mv	s2,a0
  close(fd);
 184:	8526                	mv	a0,s1
 186:	136000ef          	jal	ra,2bc <close>
  return r;
}
 18a:	854a                	mv	a0,s2
 18c:	60e2                	ld	ra,24(sp)
 18e:	6442                	ld	s0,16(sp)
 190:	64a2                	ld	s1,8(sp)
 192:	6902                	ld	s2,0(sp)
 194:	6105                	addi	sp,sp,32
 196:	8082                	ret
    return -1;
 198:	597d                	li	s2,-1
 19a:	bfc5                	j	18a <stat+0x28>

000000000000019c <atoi>:

int
atoi(const char *s)
{
 19c:	1141                	addi	sp,sp,-16
 19e:	e422                	sd	s0,8(sp)
 1a0:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1a2:	00054603          	lbu	a2,0(a0)
 1a6:	fd06079b          	addiw	a5,a2,-48
 1aa:	0ff7f793          	andi	a5,a5,255
 1ae:	4725                	li	a4,9
 1b0:	02f76963          	bltu	a4,a5,1e2 <atoi+0x46>
 1b4:	86aa                	mv	a3,a0
  n = 0;
 1b6:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 1b8:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 1ba:	0685                	addi	a3,a3,1
 1bc:	0025179b          	slliw	a5,a0,0x2
 1c0:	9fa9                	addw	a5,a5,a0
 1c2:	0017979b          	slliw	a5,a5,0x1
 1c6:	9fb1                	addw	a5,a5,a2
 1c8:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 1cc:	0006c603          	lbu	a2,0(a3)
 1d0:	fd06071b          	addiw	a4,a2,-48
 1d4:	0ff77713          	andi	a4,a4,255
 1d8:	fee5f1e3          	bgeu	a1,a4,1ba <atoi+0x1e>
  return n;
}
 1dc:	6422                	ld	s0,8(sp)
 1de:	0141                	addi	sp,sp,16
 1e0:	8082                	ret
  n = 0;
 1e2:	4501                	li	a0,0
 1e4:	bfe5                	j	1dc <atoi+0x40>

00000000000001e6 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 1e6:	1141                	addi	sp,sp,-16
 1e8:	e422                	sd	s0,8(sp)
 1ea:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 1ec:	02b57463          	bgeu	a0,a1,214 <memmove+0x2e>
    while(n-- > 0)
 1f0:	00c05f63          	blez	a2,20e <memmove+0x28>
 1f4:	1602                	slli	a2,a2,0x20
 1f6:	9201                	srli	a2,a2,0x20
 1f8:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 1fc:	872a                	mv	a4,a0
      *dst++ = *src++;
 1fe:	0585                	addi	a1,a1,1
 200:	0705                	addi	a4,a4,1
 202:	fff5c683          	lbu	a3,-1(a1)
 206:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 20a:	fee79ae3          	bne	a5,a4,1fe <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 20e:	6422                	ld	s0,8(sp)
 210:	0141                	addi	sp,sp,16
 212:	8082                	ret
    dst += n;
 214:	00c50733          	add	a4,a0,a2
    src += n;
 218:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 21a:	fec05ae3          	blez	a2,20e <memmove+0x28>
 21e:	fff6079b          	addiw	a5,a2,-1
 222:	1782                	slli	a5,a5,0x20
 224:	9381                	srli	a5,a5,0x20
 226:	fff7c793          	not	a5,a5
 22a:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 22c:	15fd                	addi	a1,a1,-1
 22e:	177d                	addi	a4,a4,-1
 230:	0005c683          	lbu	a3,0(a1)
 234:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 238:	fee79ae3          	bne	a5,a4,22c <memmove+0x46>
 23c:	bfc9                	j	20e <memmove+0x28>

000000000000023e <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 23e:	1141                	addi	sp,sp,-16
 240:	e422                	sd	s0,8(sp)
 242:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 244:	ca05                	beqz	a2,274 <memcmp+0x36>
 246:	fff6069b          	addiw	a3,a2,-1
 24a:	1682                	slli	a3,a3,0x20
 24c:	9281                	srli	a3,a3,0x20
 24e:	0685                	addi	a3,a3,1
 250:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 252:	00054783          	lbu	a5,0(a0)
 256:	0005c703          	lbu	a4,0(a1)
 25a:	00e79863          	bne	a5,a4,26a <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 25e:	0505                	addi	a0,a0,1
    p2++;
 260:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 262:	fed518e3          	bne	a0,a3,252 <memcmp+0x14>
  }
  return 0;
 266:	4501                	li	a0,0
 268:	a019                	j	26e <memcmp+0x30>
      return *p1 - *p2;
 26a:	40e7853b          	subw	a0,a5,a4
}
 26e:	6422                	ld	s0,8(sp)
 270:	0141                	addi	sp,sp,16
 272:	8082                	ret
  return 0;
 274:	4501                	li	a0,0
 276:	bfe5                	j	26e <memcmp+0x30>

0000000000000278 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 278:	1141                	addi	sp,sp,-16
 27a:	e406                	sd	ra,8(sp)
 27c:	e022                	sd	s0,0(sp)
 27e:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 280:	f67ff0ef          	jal	ra,1e6 <memmove>
}
 284:	60a2                	ld	ra,8(sp)
 286:	6402                	ld	s0,0(sp)
 288:	0141                	addi	sp,sp,16
 28a:	8082                	ret

000000000000028c <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 28c:	4885                	li	a7,1
 ecall
 28e:	00000073          	ecall
 ret
 292:	8082                	ret

0000000000000294 <exit>:
.global exit
exit:
 li a7, SYS_exit
 294:	4889                	li	a7,2
 ecall
 296:	00000073          	ecall
 ret
 29a:	8082                	ret

000000000000029c <wait>:
.global wait
wait:
 li a7, SYS_wait
 29c:	488d                	li	a7,3
 ecall
 29e:	00000073          	ecall
 ret
 2a2:	8082                	ret

00000000000002a4 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 2a4:	4891                	li	a7,4
 ecall
 2a6:	00000073          	ecall
 ret
 2aa:	8082                	ret

00000000000002ac <read>:
.global read
read:
 li a7, SYS_read
 2ac:	4895                	li	a7,5
 ecall
 2ae:	00000073          	ecall
 ret
 2b2:	8082                	ret

00000000000002b4 <write>:
.global write
write:
 li a7, SYS_write
 2b4:	48c1                	li	a7,16
 ecall
 2b6:	00000073          	ecall
 ret
 2ba:	8082                	ret

00000000000002bc <close>:
.global close
close:
 li a7, SYS_close
 2bc:	48d5                	li	a7,21
 ecall
 2be:	00000073          	ecall
 ret
 2c2:	8082                	ret

00000000000002c4 <kill>:
.global kill
kill:
 li a7, SYS_kill
 2c4:	4899                	li	a7,6
 ecall
 2c6:	00000073          	ecall
 ret
 2ca:	8082                	ret

00000000000002cc <exec>:
.global exec
exec:
 li a7, SYS_exec
 2cc:	489d                	li	a7,7
 ecall
 2ce:	00000073          	ecall
 ret
 2d2:	8082                	ret

00000000000002d4 <open>:
.global open
open:
 li a7, SYS_open
 2d4:	48bd                	li	a7,15
 ecall
 2d6:	00000073          	ecall
 ret
 2da:	8082                	ret

00000000000002dc <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 2dc:	48c5                	li	a7,17
 ecall
 2de:	00000073          	ecall
 ret
 2e2:	8082                	ret

00000000000002e4 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 2e4:	48c9                	li	a7,18
 ecall
 2e6:	00000073          	ecall
 ret
 2ea:	8082                	ret

00000000000002ec <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 2ec:	48a1                	li	a7,8
 ecall
 2ee:	00000073          	ecall
 ret
 2f2:	8082                	ret

00000000000002f4 <link>:
.global link
link:
 li a7, SYS_link
 2f4:	48cd                	li	a7,19
 ecall
 2f6:	00000073          	ecall
 ret
 2fa:	8082                	ret

00000000000002fc <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 2fc:	48d1                	li	a7,20
 ecall
 2fe:	00000073          	ecall
 ret
 302:	8082                	ret

0000000000000304 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 304:	48a5                	li	a7,9
 ecall
 306:	00000073          	ecall
 ret
 30a:	8082                	ret

000000000000030c <dup>:
.global dup
dup:
 li a7, SYS_dup
 30c:	48a9                	li	a7,10
 ecall
 30e:	00000073          	ecall
 ret
 312:	8082                	ret

0000000000000314 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 314:	48ad                	li	a7,11
 ecall
 316:	00000073          	ecall
 ret
 31a:	8082                	ret

000000000000031c <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 31c:	48b1                	li	a7,12
 ecall
 31e:	00000073          	ecall
 ret
 322:	8082                	ret

0000000000000324 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 324:	48b5                	li	a7,13
 ecall
 326:	00000073          	ecall
 ret
 32a:	8082                	ret

000000000000032c <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 32c:	48b9                	li	a7,14
 ecall
 32e:	00000073          	ecall
 ret
 332:	8082                	ret

0000000000000334 <time>:
.global time
time:
 li a7, SYS_time
 334:	48d9                	li	a7,22
 ecall
 336:	00000073          	ecall
 ret
 33a:	8082                	ret

000000000000033c <getmem>:
.global getmem
getmem:
 li a7, SYS_getmem
 33c:	48dd                	li	a7,23
 ecall
 33e:	00000073          	ecall
 ret
 342:	8082                	ret

0000000000000344 <get_sha256>:
.global get_sha256
get_sha256:
 li a7, SYS_get_sha256
 344:	48e1                	li	a7,24
 ecall
 346:	00000073          	ecall
 ret
 34a:	8082                	ret

000000000000034c <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 34c:	1101                	addi	sp,sp,-32
 34e:	ec06                	sd	ra,24(sp)
 350:	e822                	sd	s0,16(sp)
 352:	1000                	addi	s0,sp,32
 354:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 358:	4605                	li	a2,1
 35a:	fef40593          	addi	a1,s0,-17
 35e:	f57ff0ef          	jal	ra,2b4 <write>
}
 362:	60e2                	ld	ra,24(sp)
 364:	6442                	ld	s0,16(sp)
 366:	6105                	addi	sp,sp,32
 368:	8082                	ret

000000000000036a <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 36a:	7139                	addi	sp,sp,-64
 36c:	fc06                	sd	ra,56(sp)
 36e:	f822                	sd	s0,48(sp)
 370:	f426                	sd	s1,40(sp)
 372:	f04a                	sd	s2,32(sp)
 374:	ec4e                	sd	s3,24(sp)
 376:	0080                	addi	s0,sp,64
 378:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 37a:	c299                	beqz	a3,380 <printint+0x16>
 37c:	0805c663          	bltz	a1,408 <printint+0x9e>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 380:	2581                	sext.w	a1,a1
  neg = 0;
 382:	4881                	li	a7,0
 384:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 388:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 38a:	2601                	sext.w	a2,a2
 38c:	00000517          	auipc	a0,0x0
 390:	4ec50513          	addi	a0,a0,1260 # 878 <digits>
 394:	883a                	mv	a6,a4
 396:	2705                	addiw	a4,a4,1
 398:	02c5f7bb          	remuw	a5,a1,a2
 39c:	1782                	slli	a5,a5,0x20
 39e:	9381                	srli	a5,a5,0x20
 3a0:	97aa                	add	a5,a5,a0
 3a2:	0007c783          	lbu	a5,0(a5)
 3a6:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 3aa:	0005879b          	sext.w	a5,a1
 3ae:	02c5d5bb          	divuw	a1,a1,a2
 3b2:	0685                	addi	a3,a3,1
 3b4:	fec7f0e3          	bgeu	a5,a2,394 <printint+0x2a>
  if(neg)
 3b8:	00088b63          	beqz	a7,3ce <printint+0x64>
    buf[i++] = '-';
 3bc:	fd040793          	addi	a5,s0,-48
 3c0:	973e                	add	a4,a4,a5
 3c2:	02d00793          	li	a5,45
 3c6:	fef70823          	sb	a5,-16(a4)
 3ca:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 3ce:	02e05663          	blez	a4,3fa <printint+0x90>
 3d2:	fc040793          	addi	a5,s0,-64
 3d6:	00e78933          	add	s2,a5,a4
 3da:	fff78993          	addi	s3,a5,-1
 3de:	99ba                	add	s3,s3,a4
 3e0:	377d                	addiw	a4,a4,-1
 3e2:	1702                	slli	a4,a4,0x20
 3e4:	9301                	srli	a4,a4,0x20
 3e6:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 3ea:	fff94583          	lbu	a1,-1(s2)
 3ee:	8526                	mv	a0,s1
 3f0:	f5dff0ef          	jal	ra,34c <putc>
  while(--i >= 0)
 3f4:	197d                	addi	s2,s2,-1
 3f6:	ff391ae3          	bne	s2,s3,3ea <printint+0x80>
}
 3fa:	70e2                	ld	ra,56(sp)
 3fc:	7442                	ld	s0,48(sp)
 3fe:	74a2                	ld	s1,40(sp)
 400:	7902                	ld	s2,32(sp)
 402:	69e2                	ld	s3,24(sp)
 404:	6121                	addi	sp,sp,64
 406:	8082                	ret
    x = -xx;
 408:	40b005bb          	negw	a1,a1
    neg = 1;
 40c:	4885                	li	a7,1
    x = -xx;
 40e:	bf9d                	j	384 <printint+0x1a>

0000000000000410 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 410:	7119                	addi	sp,sp,-128
 412:	fc86                	sd	ra,120(sp)
 414:	f8a2                	sd	s0,112(sp)
 416:	f4a6                	sd	s1,104(sp)
 418:	f0ca                	sd	s2,96(sp)
 41a:	ecce                	sd	s3,88(sp)
 41c:	e8d2                	sd	s4,80(sp)
 41e:	e4d6                	sd	s5,72(sp)
 420:	e0da                	sd	s6,64(sp)
 422:	fc5e                	sd	s7,56(sp)
 424:	f862                	sd	s8,48(sp)
 426:	f466                	sd	s9,40(sp)
 428:	f06a                	sd	s10,32(sp)
 42a:	ec6e                	sd	s11,24(sp)
 42c:	0100                	addi	s0,sp,128
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 42e:	0005c903          	lbu	s2,0(a1)
 432:	22090e63          	beqz	s2,66e <vprintf+0x25e>
 436:	8b2a                	mv	s6,a0
 438:	8a2e                	mv	s4,a1
 43a:	8bb2                	mv	s7,a2
  state = 0;
 43c:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 43e:	4481                	li	s1,0
 440:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 442:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 446:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 44a:	06c00d13          	li	s10,108
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 44e:	07500d93          	li	s11,117
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 452:	00000c97          	auipc	s9,0x0
 456:	426c8c93          	addi	s9,s9,1062 # 878 <digits>
 45a:	a005                	j	47a <vprintf+0x6a>
        putc(fd, c0);
 45c:	85ca                	mv	a1,s2
 45e:	855a                	mv	a0,s6
 460:	eedff0ef          	jal	ra,34c <putc>
 464:	a019                	j	46a <vprintf+0x5a>
    } else if(state == '%'){
 466:	03598263          	beq	s3,s5,48a <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 46a:	2485                	addiw	s1,s1,1
 46c:	8726                	mv	a4,s1
 46e:	009a07b3          	add	a5,s4,s1
 472:	0007c903          	lbu	s2,0(a5)
 476:	1e090c63          	beqz	s2,66e <vprintf+0x25e>
    c0 = fmt[i] & 0xff;
 47a:	0009079b          	sext.w	a5,s2
    if(state == 0){
 47e:	fe0994e3          	bnez	s3,466 <vprintf+0x56>
      if(c0 == '%'){
 482:	fd579de3          	bne	a5,s5,45c <vprintf+0x4c>
        state = '%';
 486:	89be                	mv	s3,a5
 488:	b7cd                	j	46a <vprintf+0x5a>
      if(c0) c1 = fmt[i+1] & 0xff;
 48a:	cfa5                	beqz	a5,502 <vprintf+0xf2>
 48c:	00ea06b3          	add	a3,s4,a4
 490:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 494:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 496:	c681                	beqz	a3,49e <vprintf+0x8e>
 498:	9752                	add	a4,a4,s4
 49a:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 49e:	03878a63          	beq	a5,s8,4d2 <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
 4a2:	05a78463          	beq	a5,s10,4ea <vprintf+0xda>
      } else if(c0 == 'u'){
 4a6:	0db78763          	beq	a5,s11,574 <vprintf+0x164>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 4aa:	07800713          	li	a4,120
 4ae:	10e78963          	beq	a5,a4,5c0 <vprintf+0x1b0>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 4b2:	07000713          	li	a4,112
 4b6:	12e78e63          	beq	a5,a4,5f2 <vprintf+0x1e2>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
 4ba:	07300713          	li	a4,115
 4be:	16e78b63          	beq	a5,a4,634 <vprintf+0x224>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 4c2:	05579063          	bne	a5,s5,502 <vprintf+0xf2>
        putc(fd, '%');
 4c6:	85d6                	mv	a1,s5
 4c8:	855a                	mv	a0,s6
 4ca:	e83ff0ef          	jal	ra,34c <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 4ce:	4981                	li	s3,0
 4d0:	bf69                	j	46a <vprintf+0x5a>
        printint(fd, va_arg(ap, int), 10, 1);
 4d2:	008b8913          	addi	s2,s7,8
 4d6:	4685                	li	a3,1
 4d8:	4629                	li	a2,10
 4da:	000ba583          	lw	a1,0(s7)
 4de:	855a                	mv	a0,s6
 4e0:	e8bff0ef          	jal	ra,36a <printint>
 4e4:	8bca                	mv	s7,s2
      state = 0;
 4e6:	4981                	li	s3,0
 4e8:	b749                	j	46a <vprintf+0x5a>
      } else if(c0 == 'l' && c1 == 'd'){
 4ea:	03868663          	beq	a3,s8,516 <vprintf+0x106>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 4ee:	05a68163          	beq	a3,s10,530 <vprintf+0x120>
      } else if(c0 == 'l' && c1 == 'u'){
 4f2:	09b68d63          	beq	a3,s11,58c <vprintf+0x17c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 4f6:	03a68f63          	beq	a3,s10,534 <vprintf+0x124>
      } else if(c0 == 'l' && c1 == 'x'){
 4fa:	07800793          	li	a5,120
 4fe:	0cf68d63          	beq	a3,a5,5d8 <vprintf+0x1c8>
        putc(fd, '%');
 502:	85d6                	mv	a1,s5
 504:	855a                	mv	a0,s6
 506:	e47ff0ef          	jal	ra,34c <putc>
        putc(fd, c0);
 50a:	85ca                	mv	a1,s2
 50c:	855a                	mv	a0,s6
 50e:	e3fff0ef          	jal	ra,34c <putc>
      state = 0;
 512:	4981                	li	s3,0
 514:	bf99                	j	46a <vprintf+0x5a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 516:	008b8913          	addi	s2,s7,8
 51a:	4685                	li	a3,1
 51c:	4629                	li	a2,10
 51e:	000ba583          	lw	a1,0(s7)
 522:	855a                	mv	a0,s6
 524:	e47ff0ef          	jal	ra,36a <printint>
        i += 1;
 528:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 52a:	8bca                	mv	s7,s2
      state = 0;
 52c:	4981                	li	s3,0
        i += 1;
 52e:	bf35                	j	46a <vprintf+0x5a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 530:	03860563          	beq	a2,s8,55a <vprintf+0x14a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 534:	07b60963          	beq	a2,s11,5a6 <vprintf+0x196>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 538:	07800793          	li	a5,120
 53c:	fcf613e3          	bne	a2,a5,502 <vprintf+0xf2>
        printint(fd, va_arg(ap, uint64), 16, 0);
 540:	008b8913          	addi	s2,s7,8
 544:	4681                	li	a3,0
 546:	4641                	li	a2,16
 548:	000ba583          	lw	a1,0(s7)
 54c:	855a                	mv	a0,s6
 54e:	e1dff0ef          	jal	ra,36a <printint>
        i += 2;
 552:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 554:	8bca                	mv	s7,s2
      state = 0;
 556:	4981                	li	s3,0
        i += 2;
 558:	bf09                	j	46a <vprintf+0x5a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 55a:	008b8913          	addi	s2,s7,8
 55e:	4685                	li	a3,1
 560:	4629                	li	a2,10
 562:	000ba583          	lw	a1,0(s7)
 566:	855a                	mv	a0,s6
 568:	e03ff0ef          	jal	ra,36a <printint>
        i += 2;
 56c:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 56e:	8bca                	mv	s7,s2
      state = 0;
 570:	4981                	li	s3,0
        i += 2;
 572:	bde5                	j	46a <vprintf+0x5a>
        printint(fd, va_arg(ap, int), 10, 0);
 574:	008b8913          	addi	s2,s7,8
 578:	4681                	li	a3,0
 57a:	4629                	li	a2,10
 57c:	000ba583          	lw	a1,0(s7)
 580:	855a                	mv	a0,s6
 582:	de9ff0ef          	jal	ra,36a <printint>
 586:	8bca                	mv	s7,s2
      state = 0;
 588:	4981                	li	s3,0
 58a:	b5c5                	j	46a <vprintf+0x5a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 58c:	008b8913          	addi	s2,s7,8
 590:	4681                	li	a3,0
 592:	4629                	li	a2,10
 594:	000ba583          	lw	a1,0(s7)
 598:	855a                	mv	a0,s6
 59a:	dd1ff0ef          	jal	ra,36a <printint>
        i += 1;
 59e:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 5a0:	8bca                	mv	s7,s2
      state = 0;
 5a2:	4981                	li	s3,0
        i += 1;
 5a4:	b5d9                	j	46a <vprintf+0x5a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 5a6:	008b8913          	addi	s2,s7,8
 5aa:	4681                	li	a3,0
 5ac:	4629                	li	a2,10
 5ae:	000ba583          	lw	a1,0(s7)
 5b2:	855a                	mv	a0,s6
 5b4:	db7ff0ef          	jal	ra,36a <printint>
        i += 2;
 5b8:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 5ba:	8bca                	mv	s7,s2
      state = 0;
 5bc:	4981                	li	s3,0
        i += 2;
 5be:	b575                	j	46a <vprintf+0x5a>
        printint(fd, va_arg(ap, int), 16, 0);
 5c0:	008b8913          	addi	s2,s7,8
 5c4:	4681                	li	a3,0
 5c6:	4641                	li	a2,16
 5c8:	000ba583          	lw	a1,0(s7)
 5cc:	855a                	mv	a0,s6
 5ce:	d9dff0ef          	jal	ra,36a <printint>
 5d2:	8bca                	mv	s7,s2
      state = 0;
 5d4:	4981                	li	s3,0
 5d6:	bd51                	j	46a <vprintf+0x5a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 5d8:	008b8913          	addi	s2,s7,8
 5dc:	4681                	li	a3,0
 5de:	4641                	li	a2,16
 5e0:	000ba583          	lw	a1,0(s7)
 5e4:	855a                	mv	a0,s6
 5e6:	d85ff0ef          	jal	ra,36a <printint>
        i += 1;
 5ea:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 5ec:	8bca                	mv	s7,s2
      state = 0;
 5ee:	4981                	li	s3,0
        i += 1;
 5f0:	bdad                	j	46a <vprintf+0x5a>
        printptr(fd, va_arg(ap, uint64));
 5f2:	008b8793          	addi	a5,s7,8
 5f6:	f8f43423          	sd	a5,-120(s0)
 5fa:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 5fe:	03000593          	li	a1,48
 602:	855a                	mv	a0,s6
 604:	d49ff0ef          	jal	ra,34c <putc>
  putc(fd, 'x');
 608:	07800593          	li	a1,120
 60c:	855a                	mv	a0,s6
 60e:	d3fff0ef          	jal	ra,34c <putc>
 612:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 614:	03c9d793          	srli	a5,s3,0x3c
 618:	97e6                	add	a5,a5,s9
 61a:	0007c583          	lbu	a1,0(a5)
 61e:	855a                	mv	a0,s6
 620:	d2dff0ef          	jal	ra,34c <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 624:	0992                	slli	s3,s3,0x4
 626:	397d                	addiw	s2,s2,-1
 628:	fe0916e3          	bnez	s2,614 <vprintf+0x204>
        printptr(fd, va_arg(ap, uint64));
 62c:	f8843b83          	ld	s7,-120(s0)
      state = 0;
 630:	4981                	li	s3,0
 632:	bd25                	j	46a <vprintf+0x5a>
        if((s = va_arg(ap, char*)) == 0)
 634:	008b8993          	addi	s3,s7,8
 638:	000bb903          	ld	s2,0(s7)
 63c:	00090f63          	beqz	s2,65a <vprintf+0x24a>
        for(; *s; s++)
 640:	00094583          	lbu	a1,0(s2)
 644:	c195                	beqz	a1,668 <vprintf+0x258>
          putc(fd, *s);
 646:	855a                	mv	a0,s6
 648:	d05ff0ef          	jal	ra,34c <putc>
        for(; *s; s++)
 64c:	0905                	addi	s2,s2,1
 64e:	00094583          	lbu	a1,0(s2)
 652:	f9f5                	bnez	a1,646 <vprintf+0x236>
        if((s = va_arg(ap, char*)) == 0)
 654:	8bce                	mv	s7,s3
      state = 0;
 656:	4981                	li	s3,0
 658:	bd09                	j	46a <vprintf+0x5a>
          s = "(null)";
 65a:	00000917          	auipc	s2,0x0
 65e:	21690913          	addi	s2,s2,534 # 870 <malloc+0x100>
        for(; *s; s++)
 662:	02800593          	li	a1,40
 666:	b7c5                	j	646 <vprintf+0x236>
        if((s = va_arg(ap, char*)) == 0)
 668:	8bce                	mv	s7,s3
      state = 0;
 66a:	4981                	li	s3,0
 66c:	bbfd                	j	46a <vprintf+0x5a>
    }
  }
}
 66e:	70e6                	ld	ra,120(sp)
 670:	7446                	ld	s0,112(sp)
 672:	74a6                	ld	s1,104(sp)
 674:	7906                	ld	s2,96(sp)
 676:	69e6                	ld	s3,88(sp)
 678:	6a46                	ld	s4,80(sp)
 67a:	6aa6                	ld	s5,72(sp)
 67c:	6b06                	ld	s6,64(sp)
 67e:	7be2                	ld	s7,56(sp)
 680:	7c42                	ld	s8,48(sp)
 682:	7ca2                	ld	s9,40(sp)
 684:	7d02                	ld	s10,32(sp)
 686:	6de2                	ld	s11,24(sp)
 688:	6109                	addi	sp,sp,128
 68a:	8082                	ret

000000000000068c <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 68c:	715d                	addi	sp,sp,-80
 68e:	ec06                	sd	ra,24(sp)
 690:	e822                	sd	s0,16(sp)
 692:	1000                	addi	s0,sp,32
 694:	e010                	sd	a2,0(s0)
 696:	e414                	sd	a3,8(s0)
 698:	e818                	sd	a4,16(s0)
 69a:	ec1c                	sd	a5,24(s0)
 69c:	03043023          	sd	a6,32(s0)
 6a0:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 6a4:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 6a8:	8622                	mv	a2,s0
 6aa:	d67ff0ef          	jal	ra,410 <vprintf>
}
 6ae:	60e2                	ld	ra,24(sp)
 6b0:	6442                	ld	s0,16(sp)
 6b2:	6161                	addi	sp,sp,80
 6b4:	8082                	ret

00000000000006b6 <printf>:

void
printf(const char *fmt, ...)
{
 6b6:	711d                	addi	sp,sp,-96
 6b8:	ec06                	sd	ra,24(sp)
 6ba:	e822                	sd	s0,16(sp)
 6bc:	1000                	addi	s0,sp,32
 6be:	e40c                	sd	a1,8(s0)
 6c0:	e810                	sd	a2,16(s0)
 6c2:	ec14                	sd	a3,24(s0)
 6c4:	f018                	sd	a4,32(s0)
 6c6:	f41c                	sd	a5,40(s0)
 6c8:	03043823          	sd	a6,48(s0)
 6cc:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 6d0:	00840613          	addi	a2,s0,8
 6d4:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 6d8:	85aa                	mv	a1,a0
 6da:	4505                	li	a0,1
 6dc:	d35ff0ef          	jal	ra,410 <vprintf>
}
 6e0:	60e2                	ld	ra,24(sp)
 6e2:	6442                	ld	s0,16(sp)
 6e4:	6125                	addi	sp,sp,96
 6e6:	8082                	ret

00000000000006e8 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6e8:	1141                	addi	sp,sp,-16
 6ea:	e422                	sd	s0,8(sp)
 6ec:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 6ee:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6f2:	00001797          	auipc	a5,0x1
 6f6:	90e7b783          	ld	a5,-1778(a5) # 1000 <freep>
 6fa:	a805                	j	72a <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 6fc:	4618                	lw	a4,8(a2)
 6fe:	9db9                	addw	a1,a1,a4
 700:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 704:	6398                	ld	a4,0(a5)
 706:	6318                	ld	a4,0(a4)
 708:	fee53823          	sd	a4,-16(a0)
 70c:	a091                	j	750 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 70e:	ff852703          	lw	a4,-8(a0)
 712:	9e39                	addw	a2,a2,a4
 714:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 716:	ff053703          	ld	a4,-16(a0)
 71a:	e398                	sd	a4,0(a5)
 71c:	a099                	j	762 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 71e:	6398                	ld	a4,0(a5)
 720:	00e7e463          	bltu	a5,a4,728 <free+0x40>
 724:	00e6ea63          	bltu	a3,a4,738 <free+0x50>
{
 728:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 72a:	fed7fae3          	bgeu	a5,a3,71e <free+0x36>
 72e:	6398                	ld	a4,0(a5)
 730:	00e6e463          	bltu	a3,a4,738 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 734:	fee7eae3          	bltu	a5,a4,728 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 738:	ff852583          	lw	a1,-8(a0)
 73c:	6390                	ld	a2,0(a5)
 73e:	02059713          	slli	a4,a1,0x20
 742:	9301                	srli	a4,a4,0x20
 744:	0712                	slli	a4,a4,0x4
 746:	9736                	add	a4,a4,a3
 748:	fae60ae3          	beq	a2,a4,6fc <free+0x14>
    bp->s.ptr = p->s.ptr;
 74c:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 750:	4790                	lw	a2,8(a5)
 752:	02061713          	slli	a4,a2,0x20
 756:	9301                	srli	a4,a4,0x20
 758:	0712                	slli	a4,a4,0x4
 75a:	973e                	add	a4,a4,a5
 75c:	fae689e3          	beq	a3,a4,70e <free+0x26>
  } else
    p->s.ptr = bp;
 760:	e394                	sd	a3,0(a5)
  freep = p;
 762:	00001717          	auipc	a4,0x1
 766:	88f73f23          	sd	a5,-1890(a4) # 1000 <freep>
}
 76a:	6422                	ld	s0,8(sp)
 76c:	0141                	addi	sp,sp,16
 76e:	8082                	ret

0000000000000770 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 770:	7139                	addi	sp,sp,-64
 772:	fc06                	sd	ra,56(sp)
 774:	f822                	sd	s0,48(sp)
 776:	f426                	sd	s1,40(sp)
 778:	f04a                	sd	s2,32(sp)
 77a:	ec4e                	sd	s3,24(sp)
 77c:	e852                	sd	s4,16(sp)
 77e:	e456                	sd	s5,8(sp)
 780:	e05a                	sd	s6,0(sp)
 782:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 784:	02051493          	slli	s1,a0,0x20
 788:	9081                	srli	s1,s1,0x20
 78a:	04bd                	addi	s1,s1,15
 78c:	8091                	srli	s1,s1,0x4
 78e:	0014899b          	addiw	s3,s1,1
 792:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 794:	00001517          	auipc	a0,0x1
 798:	86c53503          	ld	a0,-1940(a0) # 1000 <freep>
 79c:	c515                	beqz	a0,7c8 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 79e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 7a0:	4798                	lw	a4,8(a5)
 7a2:	02977f63          	bgeu	a4,s1,7e0 <malloc+0x70>
 7a6:	8a4e                	mv	s4,s3
 7a8:	0009871b          	sext.w	a4,s3
 7ac:	6685                	lui	a3,0x1
 7ae:	00d77363          	bgeu	a4,a3,7b4 <malloc+0x44>
 7b2:	6a05                	lui	s4,0x1
 7b4:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 7b8:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7bc:	00001917          	auipc	s2,0x1
 7c0:	84490913          	addi	s2,s2,-1980 # 1000 <freep>
  if(p == (char*)-1)
 7c4:	5afd                	li	s5,-1
 7c6:	a0bd                	j	834 <malloc+0xc4>
    base.s.ptr = freep = prevp = &base;
 7c8:	00001797          	auipc	a5,0x1
 7cc:	84878793          	addi	a5,a5,-1976 # 1010 <base>
 7d0:	00001717          	auipc	a4,0x1
 7d4:	82f73823          	sd	a5,-2000(a4) # 1000 <freep>
 7d8:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 7da:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 7de:	b7e1                	j	7a6 <malloc+0x36>
      if(p->s.size == nunits)
 7e0:	02e48b63          	beq	s1,a4,816 <malloc+0xa6>
        p->s.size -= nunits;
 7e4:	4137073b          	subw	a4,a4,s3
 7e8:	c798                	sw	a4,8(a5)
        p += p->s.size;
 7ea:	1702                	slli	a4,a4,0x20
 7ec:	9301                	srli	a4,a4,0x20
 7ee:	0712                	slli	a4,a4,0x4
 7f0:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 7f2:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 7f6:	00001717          	auipc	a4,0x1
 7fa:	80a73523          	sd	a0,-2038(a4) # 1000 <freep>
      return (void*)(p + 1);
 7fe:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 802:	70e2                	ld	ra,56(sp)
 804:	7442                	ld	s0,48(sp)
 806:	74a2                	ld	s1,40(sp)
 808:	7902                	ld	s2,32(sp)
 80a:	69e2                	ld	s3,24(sp)
 80c:	6a42                	ld	s4,16(sp)
 80e:	6aa2                	ld	s5,8(sp)
 810:	6b02                	ld	s6,0(sp)
 812:	6121                	addi	sp,sp,64
 814:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 816:	6398                	ld	a4,0(a5)
 818:	e118                	sd	a4,0(a0)
 81a:	bff1                	j	7f6 <malloc+0x86>
  hp->s.size = nu;
 81c:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 820:	0541                	addi	a0,a0,16
 822:	ec7ff0ef          	jal	ra,6e8 <free>
  return freep;
 826:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 82a:	dd61                	beqz	a0,802 <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 82c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 82e:	4798                	lw	a4,8(a5)
 830:	fa9778e3          	bgeu	a4,s1,7e0 <malloc+0x70>
    if(p == freep)
 834:	00093703          	ld	a4,0(s2)
 838:	853e                	mv	a0,a5
 83a:	fef719e3          	bne	a4,a5,82c <malloc+0xbc>
  p = sbrk(nu * sizeof(Header));
 83e:	8552                	mv	a0,s4
 840:	addff0ef          	jal	ra,31c <sbrk>
  if(p == (char*)-1)
 844:	fd551ce3          	bne	a0,s5,81c <malloc+0xac>
        return 0;
 848:	4501                	li	a0,0
 84a:	bf65                	j	802 <malloc+0x92>
