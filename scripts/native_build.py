import shutil,subprocess,tempfile,json
from pathlib import Path
root=Path(__file__).resolve().parents[1]
def check_native():
    compiler=shutil.which('g++')
    if not compiler:raise RuntimeError('g++ not installed')
    with tempfile.TemporaryDirectory() as tmp:
        binary=Path(tmp)/'cpu';subprocess.run([compiler,'-std=c++17','-O2','-Wall','-Wextra','-pedantic',str(root/'native/cpu_matmul.cpp'),'-o',str(binary)],check=True)
        return json.loads(subprocess.check_output([str(binary)],text=True))
if __name__=='__main__':print(json.dumps(check_native()))
