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

<img width="1402" height="266" alt="Screenshot 2026-03-07 213602" src="https://github.com/user-attachments/assets/37f8e305-ff6d-4ddf-b4b4-c98ab7a09eee" />

### Instruction Fetch (IF) Stage

<img width="1409" height="109" alt="Screenshot 2026-03-07 220914" src="https://github.com/user-attachments/assets/6663ad2d-d29f-440c-85ce-eb41f2e9f8b5" />

<img width="1414" height="103" alt="Screenshot 2026-03-07 220951" src="https://github.com/user-attachments/assets/d97349f4-1c10-453b-a24d-52bc4fe6ad36" />

### Instruction Decode (ID) Stage

<img width="1413" height="165" alt="Screenshot 2026-03-07 221233" src="https://github.com/user-attachments/assets/d8173f98-edab-484c-9641-01e817fa812d" />

<img width="1412" height="169" alt="Screenshot 2026-03-07 221256" src="https://github.com/user-attachments/assets/70780eb8-4ac2-4f44-9172-82835ae696fe" />

### Execute (EX) Stage

<img width="1410" height="211" alt="Screenshot 2026-03-07 221644" src="https://github.com/user-attachments/assets/2678fff7-aad1-440e-9265-f081f741d12d" />

<img width="1416" height="213" alt="Screenshot 2026-03-07 221729" src="https://github.com/user-attachments/assets/10ac150e-d88e-46c5-b429-57e13574bacc" />

### Memory (MEM) Stage

<img width="1411" height="148" alt="Screenshot 2026-03-07 222027" src="https://github.com/user-attachments/assets/6d75f82b-516b-4e73-a184-877c0595f416" />

<img width="1414" height="148" alt="Screenshot 2026-03-07 222052" src="https://github.com/user-attachments/assets/91b75a4f-b829-4b53-929a-90a14eab5b2f" />

### Writeback (WB) Stage

<img width="1409" height="126" alt="Screenshot 2026-03-07 222329" src="https://github.com/user-attachments/assets/d8ceb163-9ec5-41a3-bf25-b1b1b1375ff7" />

<img width="1410" height="128" alt="Screenshot 2026-03-07 222346" src="https://github.com/user-attachments/assets/9beb1577-6af9-4510-b7d4-74becc3a3266" />

### Hazard Unit

<img width="1411" height="214" alt="Screenshot 2026-03-07 222609" src="https://github.com/user-attachments/assets/9d9981eb-9481-4be4-ac12-cb4fc385d9f1" />

<img width="1414" height="213" alt="Screenshot 2026-03-07 222629" src="https://github.com/user-attachments/assets/b155c478-7531-4657-aff3-6d7a38a5504a" />
