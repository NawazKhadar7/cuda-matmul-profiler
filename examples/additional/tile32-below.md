# tile32-below

Use a matrix one element below a thirty-two-wide tile.

The CPU tile32 path must handle a nearly complete tile.

Family: tile32. Size: 31. Deterministic seed: 910206.

Run from the project directory:

~~~powershell
python -B examples/additional/run_cases.py --case tile32-below
~~~

Add --json to inspect returned metrics and output.

The adjacent expected file specifies the following metric conditions:

| Metric | Condition |
| --- | --- |
| size | equals 31 |
| batches | equals 1 |
| correct | equals true |
| gpu_executed | equals false |
| scalar_products | equals 29791 |
| max_absolute_error | min 0, max 1e-09 |

Scope: CPU matrix references; the CUDA kernels are not executed.

These inputs are synthetic. See [project limitations](../../docs/LIMITATIONS.md).
