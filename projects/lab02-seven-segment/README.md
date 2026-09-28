# 02 · BCD Seven-Segment Driver

Decode a decimal digit into common-anode seven-segment signals.

## Portfolio edition

The original segment equations and integrated display circuits are preserved in Multisim format. The new RTL reference defines blank output for invalid BCD values, which were unspecified in the lab.

## Behavior and controls

Set SW3..SW0 to a BCD value. The rightmost digit displays 0 through 9; values 10 through 15 blank the digit. The other three digits are disabled.

`seg[6:0] = {g,f,e,d,c,b,a}`. Segment outputs and board digit selects are active-low. For example, decimal 3 produces `7'b0110000` in this ordering.

The shared decoder supports hexadecimal symbols for later labs, while `bcd_display` deliberately restricts its input to decimal.

## Run and build

From the repository root:

```sh
python3 scripts/test.py 2
vivado -mode batch -source scripts/build.tcl -tclargs 2 bitstream
```

Top module: [`bcd_display`](rtl/). Target: Basys 3 (`xc7a35tcpg236-1`). Pin assignments: [`constraints/basys3.xdc`](constraints/basys3.xdc).

## Verification

All ten decimal glyphs, all six invalid BCD inputs, and the fixed anode selection are checked.

The published edition has not been physically re-tested on a board. See [verification evidence](../../docs/VERIFICATION.md).

## Original schematics

Open the files in `multisim/` with NI Multisim 14. These binaries are retained unchanged; their hashes appear in [the artifact manifest](../../docs/multisim-manifest.json). Automated checks validate the RTL reference, not the proprietary schematic simulator.

[Back to portfolio](../../README.md)
