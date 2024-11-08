  section .bss
  arg resq 1

  section .text
  global _start

_start:
  mov rax, [rsp+16] ; argv[1]
  mov [arg], rax

; Calculate len of [arg]
  xor rcx, rcx ; rcx = 0
find_len:
  mov rax, [arg]
  cmp byte [rax + rcx], 0 ; check for \0
  je print_arg
  inc rcx ; rcx++
  jmp find_len

print_arg:
  mov rsi, [arg]
  mov rdi, 1
  mov rax, 1
  mov rdx, rcx
  syscall

  mov rdi, 0
  mov rax, 60
  syscall
