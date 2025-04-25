# edges-thirteen

Multiply sixteen-by-thirteen and thirteen-by-thirteen matrices.

The edges family adds three rows to the requested size.

Family: edges. Size: 13. Deterministic seed: 910208.

Run from the project directory:

~~~powershell
python -B examples/additional/run_cases.py --case edges-thirteen
~~~

Add --json to inspect returned metrics and output.

The adjacent expected file specifies the following metric conditions:

| Metric | Condition |
| --- | --- |
| size | equals 13 |
| batches | equals 1 |
| correct | equals true |
| gpu_executed | equals false |
| scalar_products | equals 2704 |
| max_absolute_error | min 0, max 1e-09 |

Scope: CPU matrix references; the CUDA kernels are not executed.

These inputs are synthetic. See [project limitations](../../docs/LIMITATIONS.md).
