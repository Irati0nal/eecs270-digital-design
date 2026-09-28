# Verification evidence

Validation date: 2026-09-28. The automated suite uses Icarus Verilog 11.0 and Python 3. FPGA builds use AMD Vivado 2025.2 targeting `xc7a35tcpg236-1`.

## Simulation

`python3 scripts/test.py` elaborates each synthesis top independently, then compiles and executes its self-checking testbench. All seven simulations passed locally and in [GitHub Actions](https://github.com/Irati0nal/eecs270-digital-design/actions/runs/36477111673). A failed assertion or timeout returns a nonzero exit code.

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

All seven projects completed synthesis, placement, routing and bitstream generation with **zero implementation DRC findings**. The four clocked designs (Labs 4–7) meet the specified 100 MHz clock timing, with no failing setup, hold or pulse-width endpoints in their routed timing summaries.

| Project | Synthesis LUTs | Synthesis registers | Routed WNS (ns) | Routed WHS (ns) | Bitstream |
| --- | --- | --- | --- | --- | --- |
| 1 | 1 | 0 | NA | NA | Generated |
| 2 | 4 | 0 | NA | NA | Generated |
| 3 | 8 | 0 | NA | NA | Generated |
| 4 | 16 | 32 | 5.816 | 0.122 | Generated |
| 5 | 30 | 56 | 6.072 | 0.160 | Generated |
| 6 | 104 | 93 | 3.334 | 0.042 | Generated |
| 7 | 68 | 92 | 4.805 | 0.124 | Generated |

LUT/register counts are from the **post-synthesis** utilization report. WNS/WHS are routed worst setup/hold slack; positive slack meets the specified clock constraint. Labs 1–3 are combinational switch-to-output designs without a clock or an external synchronous I/O timing requirement, so Vivado reports NA for clock slack. This is not a measured maximum operating frequency.

The final device intentionally ignores SW4–SW13; Vivado reports those unused inputs during synthesis. The build does not suppress DRC errors. Board voltage properties are explicitly set. The scripts retain bitstreams and complete reports under the ignored `build/` directory; [machine-readable evidence](build-evidence.json) records report values, generated bitstream hashes and source hashes without publishing machine-specific log paths.

## Continuous integration

The [HDL verification workflow](../.github/workflows/simulation.yml) installs Icarus Verilog and runs all seven simulations on pushes and pull requests. See [workflow runs](https://github.com/Irati0nal/eecs270-digital-design/actions/workflows/simulation.yml) for the result associated with each published commit. Vivado is a local build dependency and is not included in the hosted CI job.

## Limits

- The published edition has not been re-tested on a physical Basys 3.
- Original Multisim binaries are preserved byte-for-byte, with SHA-256 hashes in the [manifest](multisim-manifest.json); they have not been re-simulated in Multisim.
- New Labs 1–3 RTL references have not been formally proven equivalent to those binaries.
- Human-input and display-output paths have no external synchronous delay specification. Clock timing results are not complete board-level I/O timing signoff.
- A multi-key digital test does not qualify the keypad wiring for simultaneous physical presses.
