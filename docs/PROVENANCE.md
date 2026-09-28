# Project provenance and scope

This repository presents Yanzhe Yang's digital logic coursework and a subsequent portfolio edition. The source collection was supplied as a local folder containing Multisim artifacts, Vivado sources, generated output, and course handouts. The original collection is preserved outside this repository.

## Mapping

| Original folder | Published project | Treatment |
| --- | --- | --- |
| `lab1` | `projects/lab01-full-adder` | Original Multisim binaries plus new gate-level RTL reference |
| `lab2` | `projects/lab02-seven-segment` | Original Multisim binaries plus new BCD display RTL reference |
| `lab3` | `projects/lab03-alu` | Original Multisim binaries plus new ALU RTL reference |
| `lab4/project_1` | `projects/lab04-counter` | Counter behavior retained; board-clock enable and button conditioning added |
| `Lab5` | `projects/lab05-digital-clock` | 00–59 behavior retained; clocking and display infrastructure refactored |
| `270lab6` | `projects/lab06-keypad` | Matrix mapping retained; full-frame qualification and one-event capture added |
| `270lab7` | `projects/lab07-digital-device` | Calculator and rolling modes retained; clocking, input handling and demo text revised |
| `project_1` | No additional project | Empty Vivado project with no source files; not an eighth completed design |

The new RTL references for Labs 1–3 were written for this portfolio; they are not exports recovered from the original Multisim files. No formal equivalence or new Multisim simulation is claimed. Original binary artifacts are traceable through [SHA-256 hashes](multisim-manifest.json).

Source-bearing entries in the supplied ZIP archives were compared with the extracted folders. One distinct Lab 1 `Design2.ms14` submission variant is retained under `projects/lab01-full-adder/multisim/submitted/`. All other compared source artifacts matched the extracted files. Archive entries use `archive.zip!entry` notation in the manifest.

## Changes in the portfolio edition

- Added English project guides, pin maps, architecture notes and reproducible build commands.
- Added independent self-checking testbenches and automated simulation in GitHub Actions.
- Replaced direct button clocking and fabric-divided clocks with system-clock enables.
- Added synchronized input paths and debounced button or keypad events.
- Standardized the segment bus to `{g,f,e,d,c,b,a}` and adjusted Lab 4 constraints accordingly.
- Removed an unused duplicate clock-divider stub from the published source set.
- Corrected the final project's display scan cadence and initialized its startup reset path.
- Replaced personally identifying scrolling text with configurable demonstration sequences.

Course handouts, quizzes, duplicate security copies, ZIP archives, bitstreams, generated simulators, tool logs and build caches are excluded. The repository does not redistribute the course's written instructions. No new license is asserted over original course or third-party materials. The absence of a license file does not grant unrestricted reuse rights.

Technical reference: [Digilent Basys 3 master constraints](https://github.com/Digilent/digilent-xdc/blob/master/Basys-3-Master.xdc). The published pin assignments were checked against this reference.
