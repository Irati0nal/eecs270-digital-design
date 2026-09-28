# 03 · 4-bit Arithmetic Logic Unit

A selectable combinational datapath with explicit carry behavior.

## Portfolio edition

Multisim addition, subtraction, AND, OR and integrated ALU circuits are preserved. The portable Verilog reference is a new portfolio addition, tested exhaustively.

## Behavior and controls

| Signal | Control |
| --- | --- |
| Operand `a[3:0]` | SW7..SW4 |
| Operand `b[3:0]` | SW3..SW0 |
| `op[1]`, `op[0]` | BTNU, BTND |
| Result and carry | LED3..LED0 and LED4 |

| op | Result | Carry |
| --- | --- | --- |
| 00 | A + B, modulo 16 | Unsigned carry |
| 01 | A - B, modulo 16 | 1 means no borrow (`A >= B`) |
| 10 | A AND B | 0 |
| 11 | A OR B | 0 |

Subtraction uses a five-bit `A + ~B + 1` expression. Its carry is distinct from signed overflow; this project does not expose a signed overflow flag.

## Run and build

From the repository root:

```sh
python3 scripts/test.py 3
vivado -mode batch -source scripts/build.tcl -tclargs 3 bitstream
```

Top module: [`alu4`](rtl/). Target: Basys 3 (`xc7a35tcpg236-1`). Pin assignments: [`constraints/basys3.xdc`](constraints/basys3.xdc).

## Verification

An integer reference checks all four operations for all 16 × 16 operand pairs: 1,024 cases.

The published edition has not been physically re-tested on a board. See [verification evidence](../../docs/VERIFICATION.md).

## Original schematics

Open the files in `multisim/` with NI Multisim 14. These binaries are retained unchanged; their hashes appear in [the artifact manifest](../../docs/multisim-manifest.json). Automated checks validate the RTL reference, not the proprietary schematic simulator.

[Back to portfolio](../../README.md)
