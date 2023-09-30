#!/usr/bin/env python

import os
import subprocess
import re
import socket

my_env = os.environ.copy()
my_env["TMPDIR"] = "."
if os.environ["SLURM_PROCID"] == "0":
    print(f"!!! server on {socket.gethostname()}")
    subprocess.run(["perf", "stat", "singularity", "run", "iperf3_latest.sif", "--json", "-s"], env=my_env)
else:
    print(f'nodes: {os.environ["SLURM_JOB_NODELIST"]}')
    server_amp_id = re.match("amp\[?(\d{3})", os.environ["SLURM_JOB_NODELIST"]).groups()[0]
    print(f"!!! client on {socket.gethostname()} connecting to amp{server_amp_id}")
    subprocess.run(["perf", "stat", "singularity", "run", "iperf3_latest.sif", "--json", "-c", "amp" + server_amp_id ], env=my_env)
