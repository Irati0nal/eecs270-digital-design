# 05 · 00–59 Digital Clock

A two-digit seconds counter with multiplexed display outputs.

## Portfolio edition

The original cascaded clock dividers are replaced by a single clock domain and a cycle counter. The empty duplicate `clk_divider_500hz` stub is omitted. The published timer waits a full second before its first increment.

## Behavior and controls

BTNC resets the timer to `00`. The rightmost two digits count `00 → 01 → … → 59 → 00`; the left two positions are blank.

| Parameter | Default | Meaning |
| --- | --- | --- |
| `CLOCK_HZ` | 100,000,000 | System clock edges per seconds increment |
| `SCAN_CYCLES` | 100,000 | Clock edges per display slot |

The display advances at 1 kHz, giving each of four slots a 250 Hz refresh rate. Both parameters must be positive integers. Tests shorten the periods without changing counter logic.

## Run and build

From the repository root:

```sh
python3 scripts/test.py 5
vivado -mode batch -source scripts/build.tcl -tclargs 5 bitstream
```

Top module: [`digital_clock`](rtl/). Target: Basys 3 (`xc7a35tcpg236-1`). Pin assignments: [`constraints/basys3.xdc`](constraints/basys3.xdc).

## Verification

The testbench checks every system-clock edge over 61 simulated seconds, including 09 → 10 and 59 → 00, digit glyphs, blank slots and a mid-run reset.

The published edition has not been physically re-tested on a board. See [verification evidence](../../docs/VERIFICATION.md).

[Back to portfolio](../../README.md)
