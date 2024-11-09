  section .rodata
argc_err_msg:
  db "No Argument was Given!", 0xa
  argc_err_len equ $ - argc_err_msg
math_fmt:
  db "^2 = ", 0
  math_fmt_len equ $ - math_fmt

  section .text
  global _start

  extern find_len
  extern atoi
  extern itoa
  extern exit

_start:
; err check instead of segfault
  mov ecx, [rsp]                       ; load argc (assuming smaller then 2^32)
  cmp ecx, 1
  jbe argc_err                         ; jmp to argc_err if argc <= 1 (no args)

  mov rdi, [rsp+16]                    ; argv[1]
  call find_len

; print str
  mov rsi, rdi
  mov rdx, rax                         ; str len from find_len
  mov rdi, 1
  mov rax, 1
  syscall

  mov rsi, math_fmt
  mov rdx, math_fmt_len                ; str len from find_len
  mov rdi, 1
  mov rax, 1
  syscall

  mov rdi, [rsp+16]                    ; argv[1]
  call atoi
  mul rax                              ; square rax

  mov rsi, rax
  call itoa                            ; Call the itoa function

  mov rsi, rax                         ; make rsi the beginning of the string
  mov rdx, rdx                         ; make rdx the string size
  mov rdi, 1
  mov rax, 1
  syscall

  mov rdi, 0
  call exit

argc_err:
  mov rsi, argc_err_msg
  mov rdx, argc_err_len
  mov rdi, 1
  mov rax, 1
  syscall

  mov rdi, 1
  call exit
