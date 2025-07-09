# batched-five

Multiply three independent five-by-five matrix pairs.

Each batch must agree with its own NumPy reference.

Family: batched. Size: 5. Deterministic seed: 910210.

Run from the project directory:

~~~powershell
python -B examples/additional/run_cases.py --case batched-five
~~~

Add --json to inspect returned metrics and output.

The adjacent expected file specifies the following metric conditions:

| Metric | Condition |
| --- | --- |
| size | equals 5 |
| batches | equals 3 |
| correct | equals true |
| gpu_executed | equals false |
| scalar_products | equals 375 |
| max_absolute_error | min 0, max 1e-09 |

Scope: CPU matrix references; the CUDA kernels are not executed.

These inputs are synthetic. See [project limitations](../../docs/LIMITATIONS.md).
