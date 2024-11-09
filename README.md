# Square Number in x86_64 Assembly

This program seems simple.
It's only complex because it's made with x86_64 assembly.

Cpp equivalent:
```cpp
cout << argv[1] << "^2 = " << argv[1] * argv[1] << endl;
```

## Requirements

- An x86_64 compatible processor
- Linux operating system (i think idek)
- An assembler (e.g., `nasm`)
- A linker (e.g., `ld`)

## Building the Program

1. **Clone the repository or download the source file**.

2. **Assemble the code**:

   ```bash
   nasm -f elf64 -o main.o src/main.asm
   nasm -f elf64 -o syscalls.o src/syscalls.asm
   nasm -f elf64 -o len.o src/len.asm
   nasm -f elf64 -o numbers.o src/numbers.asm

   ```
3. **Link the object files**

```bash
ld -m elf_x86_64 -o square main.o syscalls.o len.o numbers.o
```

4. **Run the program**

```bash
./square 5
5^2 = 25
```

