# Additional scenarios for cuda-matmul-profiler

Ten runnable scenarios cover small inputs, odd sizes, and behavior boundaries in the existing reference implementation.

This directory contains 10 input JSON files, 10 metric-oracle JSON files, 10 scenario notes, this guide, and the runner (32 files).

Run from the project directory with Python 3.10 or later and the dependencies already listed in requirements.txt.

~~~powershell
python -B examples/additional/run_cases.py --list
python -B examples/additional/run_cases.py
python -B examples/additional/run_cases.py --case naive-single --json
~~~

The runner exits with zero only when all selected scenarios pass. --json includes metrics and output or a failure reason for each scenario.

Each .case.json is paired with a .expected.json containing equality checks or numeric bounds for the existing syslab.common.check helper.
Scenario notes explain the selected boundaries. Fixed seeds make inputs repeatable; expected files contain assertions rather than recorded timings.

| Scenario | Family | Size | Purpose |
| --- | --- | --- | --- |
| naive-single | naive | 1 | Multiply one-by-one matrices. |
| naive-three | naive | 3 | Multiply three-by-three matrices with scalar loops. |
| tile16-below | tile16 | 15 | Use a matrix one element below a sixteen-wide tile. |
| tile16-exact | tile16 | 16 | Use one complete sixteen-wide tile. |
| tile16-above | tile16 | 17 | Cross a sixteen-wide tile boundary. |
| tile32-below | tile32 | 31 | Use a matrix one element below a thirty-two-wide tile. |
| tile32-above | tile32 | 33 | Cross a thirty-two-wide tile boundary. |
| edges-thirteen | edges | 13 | Multiply sixteen-by-thirteen and thirteen-by-thirteen matrices. |
| rectangular-seven | rectangular | 7 | Multiply seven-by-twelve and twelve-by-three matrices. |
| batched-five | batched | 5 | Multiply three independent five-by-five matrix pairs. |

Scope: CPU matrix references; the CUDA kernels are not executed.

Supplemental inputs have their own runner, so the existing workload discovery and its 36-case suite retain their current behavior.
Bytecode generation is disabled. Reports go to standard output; storage and model artifacts use the reference code's temporary directories.

See [limitations](../../docs/LIMITATIONS.md) and [running instructions](../../docs/RUNNING.md).
