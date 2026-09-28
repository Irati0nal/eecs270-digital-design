# 04 · Debounced Up/Down Counter

A modulo-16 counter with one count per deliberate button press.

## Portfolio edition

The original four-bit counter and hexadecimal display are retained conceptually. The button-as-clock connection is replaced by a synchronized, debounced enable on the board clock. This edition therefore adds a `clk` port and removes the dedicated-clock-route override.

## Behavior and controls

| Control | Action |
| --- | --- |
| BTNC | Step once after a stable press |
| BTNU | Reset to zero |
| SW0 = 1 / 0 | Count up / down |
| LED3..LED0 | Binary count |
| Rightmost digit | Hexadecimal count |

Default debounce interval: 1,000,000 cycles = 10 ms at 100 MHz. A stable release is required before another press. Set direction before pressing. Up-count wraps F → 0; down-count wraps 0 → F. Reset asserts asynchronously in the reset conditioner and releases synchronously; state updates on the system clock.

## Run and build

From the repository root:

```sh
python3 scripts/test.py 4
vivado -mode batch -source scripts/build.tcl -tclargs 4 bitstream
```

Top module: [`top`](rtl/). Target: Basys 3 (`xc7a35tcpg236-1`). Pin assignments: [`constraints/basys3.xdc`](constraints/basys3.xdc).

## Verification

Tests cover short bounce rejection, a long hold, complete upward wrap, downward wrap, reset while held, and the reset display.

The published edition has not been physically re-tested on a board. See [verification evidence](../../docs/VERIFICATION.md).

[Back to portfolio](../../README.md)
