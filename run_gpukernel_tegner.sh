sed -i 's/#define ARRAY_SIZE.*/#define ARRAY_SIZE 10/' exercise_2.cu
grep '#define ARRAY_SIZE' exercise_2.cu >> output
nvcc -arch=sm_30 exercise_2.cu -o exercise_2.out
srun -n 1 nvprof --log-file r10.txt ./exercise_2.out >> output
sed -i 's/#define ARRAY_SIZE.*/#define ARRAY_SIZE 100/' exercise_2.cu
grep '#define ARRAY_SIZE' exercise_2.cu >> output
nvcc -arch=sm_30 exercise_2.cu -o exercise_2.out
srun -n 1 nvprof --log-file r100.txt ./exercise_2.out >> output
sed -i 's/#define ARRAY_SIZE.*/#define ARRAY_SIZE 1000/' exercise_2.cu
grep '#define ARRAY_SIZE' exercise_2.cu >> output
nvcc -arch=sm_30 exercise_2.cu -o exercise_2.out
srun -n 1 nvprof  --log-file r1000.txt ./exercise_2.out >> output
sed -i 's/#define ARRAY_SIZE.*/#define ARRAY_SIZE 10000/' exercise_2.cu
grep '#define ARRA_YSIZE' exercise_2.cu >> output
nvcc -arch=sm_30 exercise_2.cu -o exercise_2.out
srun -n 1 nvprof  --log-file r10000.txt ./exercise_2.out >> output
sed -i 's/#define ARRAY_SIZE.*/#define ARRAY_SIZE 100000/' exercise_2.cu
grep '#define ARRAY_SIZE' exercise_2.cu >> output
nvcc -arch=sm_30 exercise_2.cu -o exercise_2.out
srun -n 1 nvprof  --log-file r100000.txt ./exercise_2.out >> output
