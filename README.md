# 32-bit-5-stage-Pipelined-RISC--V-Processor-RV32I-with-Hazard-control
This project involves the design and verification of a **32 bit 5 staged pipelined RISC-V processor** written in Verilog. The architecture is optimized with a dedicated **Hazard Unit** to manage data and control dependencies.

## Design Specifications
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

## Architecture

<img width="2550" height="1382" alt="datapath_pretty" src="https://github.com/user-attachments/assets/1e224f14-e888-4459-bf2e-9b5398fb8285" />

---

## Results

<img width="1409" height="265" alt="Screenshot 2026-03-07 213534" src="https://github.com/user-attachments/assets/ca3313b8-95b8-4561-8260-114ee4268235" />

### Instruction Fetch (IF) Stage

<img width="1409" height="109" alt="Screenshot 2026-03-07 220914" src="https://github.com/user-attachments/assets/6663ad2d-d29f-440c-85ce-eb41f2e9f8b5" />

### Instruction Decode (ID) Stage

<img width="1413" height="165" alt="Screenshot 2026-03-07 221233" src="https://github.com/user-attachments/assets/d8173f98-edab-484c-9641-01e817fa812d" />


### Execute (EX) Stage

<img width="1410" height="211" alt="Screenshot 2026-03-07 221644" src="https://github.com/user-attachments/assets/2678fff7-aad1-440e-9265-f081f741d12d" />


### Memory (MEM) Stage

<img width="1411" height="148" alt="Screenshot 2026-03-07 222027" src="https://github.com/user-attachments/assets/6d75f82b-516b-4e73-a184-877c0595f416" />

### Writeback (WB) Stage

<img width="1409" height="126" alt="Screenshot 2026-03-07 222329" src="https://github.com/user-attachments/assets/d8ceb163-9ec5-41a3-bf25-b1b1b1375ff7" />

### Hazard Unit

<img width="1411" height="214" alt="Screenshot 2026-03-07 222609" src="https://github.com/user-attachments/assets/9d9981eb-9481-4be4-ac12-cb4fc385d9f1" />

