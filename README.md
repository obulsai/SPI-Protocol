# 🌀 SPI Master-Slave Communication Protocol (Verilog HDL)

This project implements the SPI (Serial Peripheral Interface) protocol using Verilog HDL. It demonstrates how a master and slave module can communicate over a synchronous serial bus.

---

## 📸 SPI Protocol Overview

![SPI Protocol Diagram](https://github.com/obulsai/SPI-Protocol/blob/bf636d72221ae24f1229c737f99738b9155fc0f3/Report%20%26%20PPT/Introduction-to-SPI-Multiple-Slave-Configuration-Separate-Slave-Select.png)

---

## 📦 Project Modules

### 🔹 `spi.v` (Top Module)

Integrates the SPI master and slave modules. Handles the data flow between them and exposes key signals like `mosi`, `miso`, `sclk`, `chip_select`, and output data.

### 🔹 `spi_master.v`

Implements an FSM-based SPI master:
- Transmits 8-bit data (`0xB5`)
- Generates `sclk`
- Controls `chip_select` (active low)
- Sends data over `mosi`
- Receives response from slave over `miso`

### 🔹 `spi_slave.v`

Implements an SPI slave device:
- Receives 8-bit data from master via `mosi`
- Sends fixed 8-bit response (`0xA5`) via `miso`
- Sets `done` signal when byte transfer completes

### 🔹 `main_tb.v` (Testbench)

Simulates the entire SPI transaction:
- Applies clock and reset
- Triggers transmission
- Monitors SPI signals and logs output

---

## 🔍 RTL Design

![RTL Diagram](https://github.com/obulsai/SPI-Protocol/blob/6fb5335c504de565c90812aa4f7433178470d456/RTL/RTL%20DESIGN.png)

---

## 🧪 Simulation Output

### ✅ Functional Simulation

After simulation, the following is observed:

- Master sends: `0xB5`  
- Slave replies with: `0xA5`  
- Both modules successfully complete data exchange  
- `done` signal goes HIGH after byte transfer  

![Simulation Waveform](https://github.com/obulsai/SPI-Protocol/blob/83a3094e9248f18ddf64744e3e4e303fdcd528fe/simulation/simulation.png)

---

## 📁 File Structure

```plaintext
SPI-Protocol/
├── spi.v              # Top module (master + slave)
├── spi_master.v       # Master logic
├── spi_slave.v        # Slave logic
├── main_tb.v          # Testbench for simulation
├── simulation/        # Waveform snapshots
│   └── simulation.png
├── RTL/               # Block diagrams
│   └── RTL DESIGN.png
├── Report & PPT/      # Documentation & illustrations
│   └── Introduction-to-SPI-Multiple-Slave-Configuration-Separate-Slave-Select.png
└── README.md          # Project summary

---

## 🛠️ Requirements

- Verilog simulator (ModelSim, Vivado, QuestaSim, etc.)
- GTKWave (for waveform viewing)
- Optional: FPGA board (for synthesis)

---

## 🚀 Features

- Full-duplex SPI communication
- MSB-first transmission
- FSM-based control logic
- 8-bit send/receive
- `done` indicator upon transfer completion

---

## 🔮 Future Enhancements

- Support for SPI modes (CPOL, CPHA)
- Parameterized data width
- Multiple slave select support
- AXI-stream wrapper for integration

---

## 👨‍💻 Author

**T. Obul Sai**  
B.Tech 3rd Year ECE, RGUKT RK Valley  
📧 Email: obulsai187@gmail.com  
🔗 [LinkedIn](https://www.linkedin.com/in/obul-sai-922643251)  
🔗 [GitHub](https://github.com/obulsai)
