# Portfolio description

## Short description

Digital logic portfolio spanning seven projects, from gate-level arithmetic and display decoding to a debounced FPGA keypad interface and signed calculator on the Basys 3. Includes Verilog RTL, original Multisim schematics, self-checking simulations, and reproducible Vivado builds.

## Resume-ready bullets

- Developed a seven-project digital design portfolio for the Basys 3 FPGA, covering combinational arithmetic, counters, multiplexed displays, matrix-key scanning and signed accumulation.
- Refactored sequential designs around a single 100 MHz clock domain, adding input synchronization, button debounce and one-event-per-press behavior.
- Built exhaustive RTL checks for 1,024 ALU cases and 256 signed addition pairs, plus integration tests for keypad scanning, timer rollover and display behavior; automated the suite with GitHub Actions.

## Discussion points

Explain why a mechanical button should generate an enable rather than serve as a clock; why subtraction carry and signed overflow mean different things; how four digits share one segment bus; and why a keypad must distinguish an accepted press from a held key. The per-project guides and testbenches provide concrete examples.

Describe the Multisim files as original schematic artifacts and Labs 1–3 RTL as later portable reference implementations. Distinguish simulation/synthesis evidence from physical-board validation when presenting this edition.
