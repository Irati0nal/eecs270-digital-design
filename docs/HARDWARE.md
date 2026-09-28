# Hardware and timing notes

## Target

- Digilent Basys 3, Artix-7 `xc7a35tcpg236-1`.
- 100 MHz oscillator on W5 for Labs 4–7.
- 3.3 V LVCMOS board I/O.
- Four common-anode seven-segment positions; board digit selects are active-low.
- `seg[0]` is segment a (W7); `seg[6]` is segment g (U7).

The canonical pin reference is [Digilent's Basys 3 master XDC](https://github.com/Digilent/digilent-xdc/blob/master/Basys-3-Master.xdc). Each project includes only its own interface mapping. Lab 7 declares all 16 switches, so its constraints also assign the unused switch bits.

## Keypad wiring (Lab 6)

| RTL signal | Basys 3 Pmod contact | FPGA package pin |
| --- | --- | --- |
| row[0] | JA1 | J1 |
| row[1] | JA2 | L2 |
| row[2] | JA3 | J2 |
| row[3] | JA4 | G2 |
| col[0] | JA7 | H1 |
| col[1] | JA8 | K2 |
| col[2] | JA9 | H2 |
| col[3] | JA10 | G3 |

Use a passive 4 × 4 switch matrix with the shown row/column order. No pressed key should leave an input driven high; the XDC enables row pull-downs. The design drives one column high and the rest low. It supports one physical key at a time; multiple simultaneous closures can connect opposing output drivers. Use a protected/diode-isolated interface before experimenting with multi-key rollover. No 5 V keypad electronics should be connected to these 3.3 V I/O pins.

## Clocking and inputs

All sequential RTL updates on the rising edge of the board clock. Frequency reduction uses cycle counters and enables. Mechanical controls are asynchronous; synchronizers reduce metastability propagation, while debounce logic filters short level changes. A multi-bit switch synchronizer is not an atomic bus handshake: set switches, allow them to settle, then press the action button.

Reset conditioning asserts asynchronously and releases after two clock edges. Downstream state uses synchronous reset. Lab 7 uses the FPGA's configuration-time register initialization to produce a startup reset and clears the accumulator when entering calculator mode.

The XDC constrains the board clock. Human-driven asynchronous inputs and LED/display outputs have no specified external synchronous arrival/capture times; external input/output delays are intentionally not invented. Timing reports therefore do not constitute a complete board-level I/O timing signoff. Physical signal integrity, metastability MTBF, switch bounce under real conditions and display ghosting still require hardware evaluation.

## Board demonstration sequence

1. Build and program the desired project, then apply reset where available.
2. Lab 1: exercise all eight switch settings and compare sum/carry.
3. Lab 2: display 0–9 and verify that A–F inputs blank the digit.
4. Lab 3: try 12 + 14 (result A, carry 1) and 12 − 14 (result E, no-borrow 0).
5. Lab 4: press and hold BTNC; the count must change once. Check both wrap directions.
6. Lab 5: observe 59 → 00 and reset midway through a second.
7. Lab 6: press each key separately, hold it, release it and verify retained output.
8. Lab 7: switch between messages, enter calculator mode and run the −8 / repeated +3 sequence in its project guide.

These are reproducible demonstration steps, not a claim that a new physical-board demonstration has been completed.
