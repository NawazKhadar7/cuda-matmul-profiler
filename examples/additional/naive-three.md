# naive-three

Multiply three-by-three matrices with scalar loops.

All twenty-seven scalar products contribute to the result.

Family: naive. Size: 3. Deterministic seed: 910202.

Run from the project directory:

~~~powershell
python -B examples/additional/run_cases.py --case naive-three
~~~

Add --json to inspect returned metrics and output.

The adjacent expected file specifies the following metric conditions:

| Metric | Condition |
| --- | --- |
| size | equals 3 |
| batches | equals 1 |
| correct | equals true |
| gpu_executed | equals false |
| scalar_products | equals 27 |
| max_absolute_error | min 0, max 1e-09 |

Scope: CPU matrix references; the CUDA kernels are not executed.

These inputs are synthetic. See [project limitations](../../docs/LIMITATIONS.md).
