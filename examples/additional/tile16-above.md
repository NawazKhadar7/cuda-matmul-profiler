# tile16-above

Cross a sixteen-wide tile boundary.

The second tile contains only one remaining row and column.

Family: tile16. Size: 17. Deterministic seed: 910205.

Run from the project directory:

~~~powershell
python -B examples/additional/run_cases.py --case tile16-above
~~~

Add --json to inspect returned metrics and output.

The adjacent expected file specifies the following metric conditions:

| Metric | Condition |
| --- | --- |
| size | equals 17 |
| batches | equals 1 |
| correct | equals true |
| gpu_executed | equals false |
| scalar_products | equals 4913 |
| max_absolute_error | min 0, max 1e-09 |

Scope: CPU matrix references; the CUDA kernels are not executed.

These inputs are synthetic. See [project limitations](../../docs/LIMITATIONS.md).
