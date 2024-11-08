  section .rodata
argc_err_msg:
  db "No Argument was Given!", 0xa
  argc_err_len equ $ - argc_err_msg

  section .text
  global _start

  extern find_len

_start:
; err check instead of segfault
  mov ecx, [rsp]                       ; load argc (assuming smaller then 2^32)
  cmp ecx, 1
  jbe argc_err                         ; jmp to argc_err if argc <= 1 (no arguments were given)

  mov rdi, [rsp+16]                    ; argv[1]
  call find_len

; print str
  mov rsi, rdi
  mov rdx, rax                         ; str len from find_len
  mov rdi, 1
  mov rax, 1
  syscall

  mov rdi, 0
  mov rax, 60
  syscall

argc_err:
  mov rsi, argc_err_msg
  mov rdx, argc_err_len
  mov rdi, 1
  mov rax, 1
  syscall

  mov rdi, 1
  mov rax, 60
  syscall
