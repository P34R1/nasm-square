  section .text
  global _start

  extern find_len

_start:
  mov rdi, [rsp+16] ; argv[1]
  call find_len

  mov rsi, rdi
  mov rdx, rax ; str len
  mov rdi, 1
  mov rax, 1
  syscall

  mov rdi, 0
  mov rax, 60
  syscall
