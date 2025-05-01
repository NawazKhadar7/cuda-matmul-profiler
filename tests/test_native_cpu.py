import sys, unittest, json, math, tempfile
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT/'src'))
from syslab.core import run_case
from syslab.common import validate_case,check,dumps,atomic_json,finite_numbers
from syslab.cli import evaluate,cases
import importlib.util,shutil
class NativeTests(unittest.TestCase):
    @unittest.skipUnless(shutil.which('g++'),'g++ unavailable')
    def test_compiled_cpp_known_product(self):
        spec=importlib.util.spec_from_file_location('native',ROOT/'scripts/native_build.py');mod=importlib.util.module_from_spec(spec);spec.loader.exec_module(mod)
        self.assertEqual(mod.check_native()['max_error'],0)
    def test_rectangular_cpu(self):
        import numpy as np
        from syslab.matrices import tiled
        np.testing.assert_allclose(tiled(np.ones((3,5)),np.ones((5,2)),2),np.full((3,2),5))
