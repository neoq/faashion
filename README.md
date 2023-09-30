
# faashion


## building
Be sure to install the dependencies stated in `CMakeLists.txt`.
Then, enter the following command in the repository root
```bash
mkdir build && cd build && cmake .. -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_CXX_COMPILER_LAUNCHER=ccache -G Ninja && cd ..
```
Now build the runtimes with
```bash
cmake --build build/ -j 40
```

## running
using slurm:
```bash
srun --time=6:00 --nodes=2 --ntasks-per-node=1 --cpus-per-task=12 build/bulk_http_hpx
```
test it by ssh'ing into the node and entering
```bash
curl -v --data hello -X POST -H "Expect:" -H "Content-Type: application/octet-stream" localhost:32425/echo -o output
```
