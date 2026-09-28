# Verification evidence

Validation date: 2026-09-28. The automated suite uses Icarus Verilog 11.0 and Python 3. FPGA builds use AMD Vivado 2025.2 targeting `xc7a35tcpg236-1`.

## Simulation

`python3 scripts/test.py` elaborates each synthesis top independently, then compiles and executes its self-checking testbench. All seven simulations passed locally. A failed assertion or timeout returns a nonzero exit code.

| Project | Checks |
| --- | --- |
| 1 | All 8 full-adder inputs |
| 2 | All 16 BCD inputs; all 32 shared decoder symbol values |
| 3 | All 1,024 operation/operand combinations; unsigned carry and subtraction no-borrow |
| 4 | Bounce rejection, one count during hold, upward/downward wrap, reset and display |
| 5 | Every clock edge over 61 accelerated seconds; exact tick cadence, decimal carry, 59-to-00 rollover, display slots, reset |
| 6 | All 16 modeled matrix connections; bounce, hold, release, stored value, multi-key frame rejection, reset |
| 7 | All 256 signed addition pairs; both overflow directions, repeated addition, debounced public controls, signed display, both messages, full rolling cycle and mode re-entry |

Simulation parameters shorten human-scale intervals. These tests check logical behavior and cycle counts; they do not model analog metastability, physical switch waveforms, or LED electrical behavior. The full board-frequency parameter values are used for Vivado builds.

## FPGA tools

Lab 7 synthesis completed with no errors or critical warnings. The complete seven-project implementation run is being recorded separately; additional results will be included once that run completes. Build products remain in the ignored `build/` directory.

## Continuous integration

The [HDL verification workflow](../.github/workflows/simulation.yml) installs Icarus Verilog and runs all seven simulations on pushes and pull requests. See [workflow runs](https://github.com/Irati0nal/eecs270-digital-design/actions/workflows/simulation.yml) for the result associated with each published commit. Vivado is a local build dependency and is not included in the hosted CI job.

## Limits

- The published edition has not been re-tested on a physical Basys 3.
- Original Multisim binaries are preserved byte-for-byte, with SHA-256 hashes in the [manifest](multisim-manifest.json); they have not been re-simulated in Multisim.
- New Labs 1–3 RTL references have not been formally proven equivalent to those binaries.
- Human-input and display-output paths have no external synchronous delay specification. Clock timing results are not complete board-level I/O timing signoff.
- A multi-key digital test does not qualify the keypad wiring for simultaneous physical presses.
