# 32-bit-5-stage-Pipelined-RISC--V-Processor-RV32I-with-Hazard-control
This project involves the design and verification of a **32 bit 5 staged pipelined RISC-V processor** written in Verilog. The architecture is optimized with a dedicated **Hazard Unit** to manage data and control dependencies.

## Dseign Specifications
### Highlights

<img width="1543" height="921" alt="Screenshot 2026-03-08 124330" src="https://github.com/user-attachments/assets/627cd262-c865-40f1-bcf4-ad3ff2b576c5" />


* **Data Path Width:** 32 bits
* **Register File:** 32 general-purpose registers (x0-x31)
* **Pipeline Depth:** 5 stages — IF (Fetch), ID (Decode), EX (Execute), MEM (Memory), WB (Write-back)
* **ISA Support:** RV32I Base Integer Instruction Set
* **Instruction Formats:** R, I, S, B, U, J types (32-bit fixed length)

### Supported Instruction Set (RV32I)

<img width="1544" height="545" alt="image" src="https://github.com/user-attachments/assets/a41e4849-2d50-493f-b1bf-cb5396d8d50a" />


| Type | Instruction | Description |
| :--- | :--- | :--- |
| **R** | `add`, `sub`, `and`, `or`, `slt` | Register-Register Arithmetic |
| **I** | `addi`, `lw`, `jalr` | Immediate & Load Operations |
| **S** | `sw` | Store to Memory |
| **B** | `beq`, `bne` | Conditional Branching |
| **U** | `lui` | Load Upper Immediate |
| **J** | `jal` | Unconditional Jump |


---

### Architecture


