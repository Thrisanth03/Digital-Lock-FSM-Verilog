
# 🔐 Digital Lock with Failed-Attempt Counter

### FSM-Based Digital Security System using Verilog HDL

## 📌 Project Overview

This project implements a password-based digital security lock using a Finite State Machine (FSM) in Verilog HDL.

The system is designed for the Nexys A7 Artix-7 FPGA development board. It authenticates a 4-bit password and grants access only when the entered password matches the predefined password.

If the user enters an incorrect password three consecutive times, the system automatically enters the LOCKOUT state and denies further access until the reset button is pressed.

## ✨ Features

- FSM-based digital lock design
- 4-bit password authentication
- Three consecutive failed-attempt detection
- Automatic lockout after three incorrect attempts
- Access denial during lockout
- Reset functionality
- LED-based status indication
- Verilog testbench for functional verification
- Nexys A7 FPGA implementation

## 🛠️ Hardware Requirements

- Nexys A7 Artix-7 FPGA Development Board
- USB programming cable
- Computer

## 💻 Software Requirements

- Xilinx Vivado Design Suite
- Verilog HDL
- Vivado Simulator

## 🔑 Default Password

**1010**

The password can be modified by changing the `CORRECT_PASSWORD` parameter in the Verilog source code.

## 🔄 FSM State Description

| State | Binary Code | Description |
|---|---|---|
| IDLE | 00 | Waits for password entry |
| OPEN | 01 | Access granted |
| LOCKOUT | 10 | Access disabled |

### FSM Operation

1. The system starts in the IDLE state.
2. The user enters a 4-bit password using FPGA switches.
3. The Enter button is pressed to submit the password.
4. If the password is correct, the system moves to the OPEN state.
5. If the password is incorrect, the failed-attempt counter increments.
6. After three consecutive incorrect attempts, the system moves to the LOCKOUT state.
7. Further password entries are rejected during lockout.
8. Pressing the Reset button clears the counter and returns the system to IDLE.

## 🔌 Nexys A7 Pin Configuration

| FPGA Component | Function |
|---|---|
| SW0 | Password bit 0 |
| SW1 | Password bit 1 |
| SW2 | Password bit 2 |
| SW3 | Password bit 3 |
| BTNU | Enter password |
| BTNC | Reset system |
| LD0 | Unlock indicator |
| LD1 | Lockout indicator |
| LD2 | Attempt counter bit 0 |
| LD3 | Attempt counter bit 1 |
| CLK | 100 MHz clock |

## 📁 Project Structure

```text
Digital-Lock-FSM-Verilog/
│
├── src/
│   └── digital_lock.v
│
├── testbench/
│   └── digital_lock_tb.v
│
├── constraints/
│   └── digital_lock.xdc
│
└── README.md
```

## 🧪 Simulation Procedure

1. Open Xilinx Vivado.
2. Create a new RTL project.
3. Select the Nexys A7 Artix-7 FPGA device.
4. Add `digital_lock.v` as a design source.
5. Add `digital_lock_tb.v` as a simulation source.
6. Set `digital_lock_tb` as the simulation top module.
7. Run Behavioral Simulation.
8. Observe the simulation waveform and console output.

### Test Cases

| Test Case | Input | Expected Result |
|---|---|---|
| Test 1 | Incorrect password | Counter = 1 |
| Test 2 | Incorrect password | Counter = 2 |
| Test 3 | Incorrect password | Lockout activated |
| Test 4 | Correct password during lockout | Access denied |
| Test 5 | Reset button | Counter cleared |
| Test 6 | Correct password | Access granted |

## ⚙️ FPGA Implementation

1. Open the Vivado project.
2. Add the Verilog source file.
3. Add the Nexys A7 XDC constraints file.
4. Run Synthesis.
5. Run Implementation.
6. Generate the Bitstream.
7. Connect the Nexys A7 FPGA board.
8. Open Hardware Manager.
9. Program the FPGA.
10. Test the digital lock using switches and push buttons.

## 📊 Expected Hardware Results

| Operation | Output |
|---|---|
| Correct password (1010) | LD0 ON |
| First incorrect attempt | LD2 ON |
| Second incorrect attempt | LD2 and LD3 ON |
| Third incorrect attempt | LD1 ON |
| Correct password during lockout | Access denied |
| Reset | All status LEDs OFF |

## 🚀 Future Enhancements

- Seven-segment display for password and attempt count
- Buzzer alert during lockout
- Configurable password
- Push-button debouncing
- Automatic lockout timeout
- Enhanced password security

## 🎯 Applications

- Electronic door locking systems
- Password-based access control
- Digital security systems
- FPGA-based authentication
- Embedded security applications

## 👨‍💻 Author

**Thrisanth RN**

Electronics and Communication Engineering Data Science

## 📜 License

This project is licensed under the MIT License.
