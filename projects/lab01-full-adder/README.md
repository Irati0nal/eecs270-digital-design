# 01 · Full Adder

Gate-level combinational arithmetic with separate sum and carry outputs.

## Portfolio edition

The original project consists of Multisim circuits. The portfolio adds a small gate-level Verilog reference with the same full-adder function.

## Behavior and controls

| Input / output | Board control |
| --- | --- |
| `a`, `b`, `cin` | SW0, SW1, SW2 |
| `sum`, `cout` | LED0, LED1 |

`sum = a XOR b XOR cin`; `cout = (a AND b) OR (cin AND (a XOR b))`.

| a | b | cin | cout | sum |
| --- | --- | --- | --- | --- |
| 0 | 0 | 0 | 0 | 0 |
| 0 | 0 | 1 | 0 | 1 |
| 0 | 1 | 0 | 0 | 1 |
| 0 | 1 | 1 | 1 | 0 |
| 1 | 0 | 0 | 0 | 1 |
| 1 | 0 | 1 | 1 | 0 |
| 1 | 1 | 0 | 1 | 0 |
| 1 | 1 | 1 | 1 | 1 |

## Run and build

From the repository root:

```sh
python3 scripts/test.py 1
vivado -mode batch -source scripts/build.tcl -tclargs 1 bitstream
```

Top module: [`full_adder`](rtl/). Target: Basys 3 (`xc7a35tcpg236-1`). Pin assignments: [`constraints/basys3.xdc`](constraints/basys3.xdc).

## Verification

The testbench exhaustively checks all eight input combinations against arithmetic addition.

The published edition has not been physically re-tested on a board. See [verification evidence](../../docs/VERIFICATION.md).

## Original schematics

Open the files in `multisim/` with NI Multisim 14. These binaries are retained unchanged; their hashes appear in [the artifact manifest](../../docs/multisim-manifest.json). Automated checks validate the RTL reference, not the proprietary schematic simulator.

`multisim/submitted/Design2.ms14` preserves a distinct version found in the original submission ZIP; it is kept separately from the extracted working copy.

[Back to portfolio](../../README.md)
