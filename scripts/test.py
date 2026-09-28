#!/usr/bin/env python3
"""Run self-checking Verilog simulations; failures return a nonzero exit code."""
import argparse
import json
import os
from pathlib import Path
import shlex
import subprocess

ROOT = Path(__file__).resolve().parents[1]
parser = argparse.ArgumentParser()
parser.add_argument("labs", nargs="*", help="Lab numbers 1..7 (default: all)")
args = parser.parse_args()
projects = json.loads((ROOT / "projects.json").read_text())
if any(lab not in projects for lab in args.labs):
    parser.error("Lab numbers must be in 1..7")
build = ROOT / "build" / "sim"
build.mkdir(parents=True, exist_ok=True)
compiler = shlex.split(os.environ.get("IVERILOG", "iverilog"))
runtime = shlex.split(os.environ.get("VVP", "vvp"))
for lab in args.labs or list(projects):
    project = projects[lab]
    directory = ROOT / project["directory"]
    sources = sorted((ROOT / "rtl/common").glob("*.v")) + sorted((directory / "rtl").glob("*.v"))
    testbench = directory / "sim" / (project["testbench"] + ".sv")
    binary = build / ("lab" + lab + ".vvp")
    # Also elaborate the synthesis top independently of the testbench.
    subprocess.run(compiler + ["-g2012", "-Wall", "-s", project["top"], "-t", "null"] +
                   [str(p) for p in sources], cwd=ROOT, check=True, timeout=60)
    subprocess.run(compiler + ["-g2012", "-Wall", "-s", project["testbench"], "-o", str(binary)] +
                   [str(p) for p in sources] + [str(testbench)], cwd=ROOT, check=True, timeout=60)
    subprocess.run(runtime + [str(binary)], cwd=ROOT, check=True, timeout=60)
print("All requested simulations passed.")
