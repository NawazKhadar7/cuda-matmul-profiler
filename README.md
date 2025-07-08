# GPU Matrix Multiplication Kernel & Profiler

Raw CUDA naive and shared-memory tiled kernels with a cuBLAS timing harness and independently validated CPU references.

## 1. Overview

Matrix-kernel comparisons need a correct oracle and a clearly defined timing boundary. This project pairs runnable CPU references with raw naive and shared-memory CUDA sources, allowing correctness work to proceed before GPU performance experiments.

**Project type:** educational reference implementation. **Repository contents:** 165 non-empty source, test, configuration, workload and documentation files, including 36 synthetic workload scenarios.

## 2. Core Features — Why They Matter

- **CPU correctness oracle:** Checks matrix results against NumPy with explicit error metrics.
- **Native CPU baseline:** Includes a C++17 matrix-product reference and a compiler-based check.
- **CUDA kernel sources:** Provides naive and 16x16 shared-memory tiled implementations.
- **GPU profiling harness:** Includes CUDA-event timing and cuBLAS comparison source for an appropriate NVIDIA environment.

## 3. Tech Stack & Architecture

| Layer | Technology | Implementation status |
| --- | --- | --- |
| Local validation | Python 3.10+, NumPy >=1.24,<3 | Runnable CPU workloads |
| Native baseline | C++17 and g++ | CPU source compiled and checked during generation |
| Optional GPU build | CMake >=3.18, CUDA Toolkit, cuBLAS, NVIDIA GPU | Sources included; GPU paths not executed in bundle validation |

### How the components fit together

The Python harness generates matrices and checks CPU methods against NumPy. The native build has a C++ CPU target and optional CUDA targets. The CUDA harness uses events for kernel-loop timing, excluding host/device transfers from that timing interval.

| Component | Responsibility |
| --- | --- |
| [src/syslab/matrices.py](src/syslab/matrices.py) | CPU methods and matrix data. |
| [native/cpu_matmul.cpp](native/cpu_matmul.cpp) | Compiled C++ CPU baseline. |
| [native/tiled.cu](native/tiled.cu) | 16x16 shared-memory CUDA kernel source. |
| [native/benchmark.cu](native/benchmark.cu) | CUDA-event and cuBLAS comparison source. |

See [Architecture](docs/ARCHITECTURE.md) and [Algorithms](docs/ALGORITHMS.md) for implementation notes.

### Scope and limitations

CUDA, cuBLAS, CMake and Nsight are not available in the generation environment. GPU sources are uncompiled and unexecuted here. Python tile32 is a CPU workload; only tile16 is provided in CUDA. No GPU speedup, memory-throughput or transformer-scale claim. cuBLAS may select hardware-specific math paths.

## 4. Getting Started / Installation

**Prerequisites:** Python 3.10+ and NumPy (`numpy>=1.24,<3`). No API keys or external services are needed for the default sample.

Download/extract this project or clone its repository, then open a terminal in the `cuda-matmul-profiler` folder. Create an isolated environment:

```sh
python -m venv .venv
```

Activate it on Linux/macOS:

```sh
source .venv/bin/activate
```

Or on Windows PowerShell:

```powershell
.venv\Scripts\Activate.ps1
```

Install the declared Python dependencies and run the demo:

```sh
python -m pip install -r requirements.txt
python scripts/demo.py
```

Check behavior and collect timings on your own machine:

```sh
python scripts/run_tests.py
python scripts/benchmark.py
```

The original bundle validation recorded **18 passing tests** for this project and **36 accepted workload scenarios**. These are local reference checks, not production or hardware benchmarks. See [Testing](docs/TESTING.md) and [Benchmark notes](docs/BENCHMARKS.md).

The optional C++ CPU check is `python scripts/native_build.py` and requires g++. GPU compilation additionally requires the CMake/CUDA toolchain in the stack table; the Python demo stays on the CPU.

## 5. Usage Examples

### Run a reproducible workload

The bundled [sample request](examples/request.json) contains:

```json
{
  "family": "naive",
  "id": "naive-008-01",
  "seed": 101,
  "size": 8
}
```

Run the corresponding workload and check its independent acceptance conditions:

```sh
python scripts/demo.py --case workloads/naive-008-01.case.json
```

Expected `metrics` excerpt from the verified local run; the complete JSON also includes `output`:

```json
{
  "metrics": {
    "batches": 1,
    "correct": true,
    "gpu_executed": false,
    "max_absolute_error": 1.7763568394002505e-15,
    "scalar_products": 512,
    "size": 8
  }
}
```

An 8x8 CPU reference product matches the oracle with maximum absolute error around 1.8e-15. The explicit gpu_executed=false flag means this example reports no GPU result or speedup.

The complete example is in [examples/response.json](examples/response.json). Floating-point last digits can vary across numeric environments.

### Explore through the local dashboard

```sh
python scripts/serve.py --port 8080
```

Open [http://127.0.0.1:8080](http://127.0.0.1:8080), select a workload and choose **Run and check**. The server listens on loopback and is intended for local inspection.

With the server running, a second terminal can call its workload inspection API:

```sh
curl "http://127.0.0.1:8080/api/run?id=naive-008-01"
```

This endpoint executes the bundled workload; it is not a production domain API.

## 6. Your Contributions / Research Alignment

### Implementation evidence

The following work areas are present in this reference and can be reviewed directly:

| Work area in this reference | Repository evidence |
| --- | --- |
| CPU correctness oracle | [src/syslab/matrices.py](src/syslab/matrices.py) |
| Correctness and edge cases | [tests/](tests/) and [acceptance workloads](workloads/) |
| Reproducible evaluation | [scripts/demo.py](scripts/demo.py), [scripts/benchmark.py](scripts/benchmark.py), [testing notes](docs/TESTING.md) |

### Research alignment

The project connects numerical computing, hardware-aware implementation and performance measurement. A useful MS research discussion would distinguish correctness, memory reuse and controlled kernel timing.

**A question to investigate:** On verified GPU hardware, how do matrix size and tile configuration affect error, occupancy and measured kernel time relative to cuBLAS?

This question is a proposed extension, not a completed research result. Evaluate it with controlled inputs, independent correctness checks and measurements tied to a reproducible configuration.

### Personal contribution record

This reference was generated from the supplied project concept. Personal authorship or research contributions have not been verified. For an MS application, document only the modules you actually changed, the design choices you can explain, and experiments you ran; link those claims to commits or reproducible reports. See [Provenance](docs/PROVENANCE.md).

All bundled inputs are synthetic. The repository does not establish historical development dates, prior deployment or published research.
