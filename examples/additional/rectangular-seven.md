# rectangular-seven

Multiply seven-by-twelve and twelve-by-three matrices.

Different row, inner, and column dimensions require 252 scalar products.

Family: rectangular. Size: 7. Deterministic seed: 910209.

Run from the project directory:

~~~powershell
python -B examples/additional/run_cases.py --case rectangular-seven
~~~

Add --json to inspect returned metrics and output.

The adjacent expected file specifies the following metric conditions:

| Metric | Condition |
| --- | --- |
| size | equals 7 |
| batches | equals 1 |
| correct | equals true |
| gpu_executed | equals false |
| scalar_products | equals 252 |
| max_absolute_error | min 0, max 1e-09 |

Scope: CPU matrix references; the CUDA kernels are not executed.

These inputs are synthetic. See [project limitations](../../docs/LIMITATIONS.md).
