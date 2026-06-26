# Universal-2Bit-SequenceDetector
A programmable 2-bit sequence detector in Verilog HDL. Dynamically detects any pattern (00, 01, 10, 11) using a runtime selector input instead of hardwired logic circuits. Includes a multi-pattern testbench for Icarus Verilog (iverilog) simulations and GTKWave VCD dump files for waveform analysis.

# Runtime-Configurable 2-Bit Sequence Detector (Verilog HDL)

A highly flexible, hardware-optimized Finite State Machine (FSM) designed in Verilog HDL to dynamically detect any user-defined 2-bit binary sequence from a continuous, serial input stream.

---

## 📖 Overview

In digital design, traditional sequence detectors are hardwired to recognize a single, fixed pattern (e.g., only detecting `10`). If the target pattern changes, the hardware description code must be rewritten and re-synthesized. 

This project solves that limitation by implementing a **programmable sequence detector**. By utilizing a 2-bit runtime selection register (`s`), the hardware can switch its target detection pattern on-the-fly to **`00`**, **`01`**, **`10`**, or **`11`** during active clock cycles without altering the underlying gate-level architecture.

---

## 🛠️ Hardware Architecture & Pin Configuration

The module `anys` monitors a serial input bit stream `x` on every rising edge of the clock signal (`clk`). When a valid 2-bit match corresponding to the control signal `s` is identified, the output pin `y` is driven high (`1'b1`).

### Port Descriptions

| Port Name | Direction | Bit Width | Type | Description |
| :--- | :--- | :--- | :--- | :--- |
| `clk` | Input | 1-bit | wire | System Clock (Positive Edge Triggered) |
| `rst` | Input | 1-bit | wire | Synchronous Active-High Reset |
| `x` | Input | 1-bit | wire | Continuous Serial Input Data Stream |
| `s` | Input | 2-bit | wire | Target Sequence Control Selector (`s[1]`=Bit 1, `s[0]`=Bit 2) |
| `y` | Output | 1-bit | reg | Sequence Detected Flag (Asserts high for 1 clock cycle on match) |
| `NS` | Output | 2-bit | reg | Next State Tracking Output/Current State Register |

---

## 🧠 Finite State Machine (FSM) Logic

The underlying control paths are governed by three explicitly assigned state parameters tracking tracking milestones:

* **`s1` (`2'b00`)**: **Idle / Reset State.** The FSM searches for the first bit of the sequence (`s[1]`).
* **`s2` (`2'b01`)**: **Partial Match State.** The first bit has been successfully found; the machine searches for the second bit (`s[0]`).
* **`s3` (`2'b10`)**: **Sequence Verified State.** The full 2-bit sequence has been identified. The output `y` goes high, and the machine prepares for overlapping/subsequent evaluations.

### Deep Logic Breakdown

The code uses optimized nested conditionals inside a synchronous sequential block to efficiently manage state progression:
1. **First-Bit Matching (`s1` or `s3`)**: If the current state is `s1` or `s3`, and the incoming bit `x` matches the desired first bit `s[1]`, the machine advances to state `s2`. If it fails, it drops to or holds at `s1`.
2. **Second-Bit Matching (`s2`)**: If the machine resides in `s2` (implicitly handled by the `else if (x==s[0])` trap), and the incoming bit `x` matches the second target bit `s[0]`, it flags a valid detection by transitioning to `s3` and driving `y = 1'b1`. 
3. **Fallback Vector**: If an expected bit path breaks in state `s2`, the logic cleanly defaults back to `s1` to begin monitoring anew.

---

## 💻 Simulation & Compilation Guide

This project is completely open-source and structured to compile flawlessly using the lightweight **Icarus Verilog (`iverilog`)** compiler toolchain, with simulation execution handled by the **VVP runtime engine**.

### Technical Prerequisites

Ensure the compiler toolsets are installed on your machine terminal:
* **Arch Linux:** `sudo pacman -S icarus-verilog`
* **Ubuntu/Debian:** `sudo apt-get install iverilog`
* **macOS (via Homebrew):** `brew install icarus-verilog`

### Step-by-Step Execution Tutorial

Open your favorite command-line interface, navigate directly to your local project workspace directory, and execute the following commands sequentially:

```bash
# Step 1: Compile both the module and testbench into an executable output file
iverilog -o alltwobitsequencedetector_tb.out alltwobitsequencedetector_tb.v alltwobitsequencedetector.v

# Step 2: Run the compiled simulation engine through the VVP runtime environment
vvp alltwobitsequencedetector_tb.out

## Waveform Analysis
    gtkwave dump.vcd

## License

This project is open-source and free to use, modify, and distribute for educational, academic, and research applications.

