# naive-single

Multiply one-by-one matrices.

The smallest CPU result must agree with NumPy.

Family: naive. Size: 1. Deterministic seed: 910201.

Run from the project directory:

~~~powershell
python -B examples/additional/run_cases.py --case naive-single
~~~

Add --json to inspect returned metrics and output.

The adjacent expected file specifies the following metric conditions:

| Metric | Condition |
| --- | --- |
| size | equals 1 |
| batches | equals 1 |
| correct | equals true |
| gpu_executed | equals false |
| scalar_products | equals 1 |
| max_absolute_error | min 0, max 1e-09 |

Scope: CPU matrix references; the CUDA kernels are not executed.

These inputs are synthetic. See [project limitations](../../docs/LIMITATIONS.md).
