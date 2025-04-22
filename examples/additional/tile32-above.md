# tile32-above

Cross a thirty-two-wide tile boundary.

The final one-element tile must contribute correctly.

Family: tile32. Size: 33. Deterministic seed: 910207.

Run from the project directory:

~~~powershell
python -B examples/additional/run_cases.py --case tile32-above
~~~

Add --json to inspect returned metrics and output.

The adjacent expected file specifies the following metric conditions:

| Metric | Condition |
| --- | --- |
| size | equals 33 |
| batches | equals 1 |
| correct | equals true |
| gpu_executed | equals false |
| scalar_products | equals 35937 |
| max_absolute_error | min 0, max 1e-09 |

Scope: CPU matrix references; the CUDA kernels are not executed.

These inputs are synthetic. See [project limitations](../../docs/LIMITATIONS.md).
