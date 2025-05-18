# tile16-below

Use a matrix one element below a sixteen-wide tile.

Partial tiles must remain within the matrix boundaries.

Family: tile16. Size: 15. Deterministic seed: 910203.

Run from the project directory:

~~~powershell
python -B examples/additional/run_cases.py --case tile16-below
~~~

Add --json to inspect returned metrics and output.

The adjacent expected file specifies the following metric conditions:

| Metric | Condition |
| --- | --- |
| size | equals 15 |
| batches | equals 1 |
| correct | equals true |
| gpu_executed | equals false |
| scalar_products | equals 3375 |
| max_absolute_error | min 0, max 1e-09 |

Scope: CPU matrix references; the CUDA kernels are not executed.

These inputs are synthetic. See [project limitations](../../docs/LIMITATIONS.md).
