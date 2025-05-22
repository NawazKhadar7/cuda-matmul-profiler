# tile16-exact

Use one complete sixteen-wide tile.

This aligned case complements the adjacent partial-tile scenarios.

Family: tile16. Size: 16. Deterministic seed: 910204.

Run from the project directory:

~~~powershell
python -B examples/additional/run_cases.py --case tile16-exact
~~~

Add --json to inspect returned metrics and output.

The adjacent expected file specifies the following metric conditions:

| Metric | Condition |
| --- | --- |
| size | equals 16 |
| batches | equals 1 |
| correct | equals true |
| gpu_executed | equals false |
| scalar_products | equals 4096 |
| max_absolute_error | min 0, max 1e-09 |

Scope: CPU matrix references; the CUDA kernels are not executed.

These inputs are synthetic. See [project limitations](../../docs/LIMITATIONS.md).
