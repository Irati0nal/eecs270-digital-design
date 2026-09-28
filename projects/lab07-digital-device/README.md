# 07 · Scrolling Display & Signed Calculator

An integrated FPGA device with a message mode and a signed four-bit accumulator.

## Portfolio edition

The original rolling-display and signed-adder behavior is preserved, while fabric clocks are replaced with enables, controls are synchronized, startup state is made deterministic for the target FPGA, and the refresh rate is corrected. Personal student IDs are replaced with configurable demo messages.

## Behavior and controls

| Control | Function |
| --- | --- |
| SW15 = 0 | Scrolling message mode |
| SW14 | Select demo message 0 or 1 |
| SW15 = 1 | Calculator mode; entering this mode clears the accumulator |
| SW3..SW0 | Signed two's-complement operand (−8 through +7) |
| BTNC | Add the operand once per debounced press |
| LED0 | Overflow on the most recent addition |

The first press adds an operand to zero. Further presses add the current operand to the previous result. Results wrap to four bits; overflow is asserted when the mathematical signed sum falls outside −8..+7. A subsequent valid addition updates, rather than latches, the overflow flag.

Example: enter `1000` (−8), press once, switch to `0011` (+3), then repeatedly press. Displayed results are −8, −5, −2, 1, 4, 7, −6, −3. Only the 7 + 3 step in this sequence asserts overflow.

Negative values use a separate minus digit, including −8. The unused left display positions are blank. Hold the operand switches stable before pressing BTNC.

`MESSAGE0` and `MESSAGE1` are 48-bit packed values holding twelve hexadecimal nibbles. Defaults are demonstration sequences `012345678901` and `987654321098`. Four blank positions complete each 16-position scrolling cycle. The display window moves approximately three times per second (`ROLL_CYCLES=33333333`), while the four-digit scan advances at 1 kHz. Rolling restarts from the beginning when leaving calculator mode.

Startup reset relies on FPGA register initialization supported by the targeted Xilinx device. An ASIC or a platform without configuration-time register initialization would need an external reset.

## Run and build

From the repository root:

```sh
python3 scripts/test.py 7
vivado -mode batch -source scripts/build.tcl -tclargs 7 bitstream
```

Top module: [`top_lab7`](rtl/). Target: Basys 3 (`xc7a35tcpg236-1`). Pin assignments: [`constraints/basys3.xdc`](constraints/basys3.xdc).

## Verification

The core is checked against an integer signed-arithmetic reference for all 256 pairs. Top-level tests exercise switch/button synchronization, bounce, held buttons, the repeated +3 example, negative display, both message tables, rolling cadence and mode re-entry.

The published edition has not been physically re-tested on a board. See [verification evidence](../../docs/VERIFICATION.md).

[Back to portfolio](../../README.md)
