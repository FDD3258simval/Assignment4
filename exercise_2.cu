#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>

#define ARRAY_SIZE 100000
#define TPB 256

double mysecond(){
  struct timeval tp;
  struct timezone tzp;

  gettimeofday(&tp,&tzp);
  return ( (double) tp.tv_sec + (double) tp.tv_usec * 1.e-6 );
}

void saxpy(int n, float *x, float *y, float a){
	for (int i=0; i < n; i++){
		y[i] = a*x[i]+y[i];
	}
}

__global__ void saxpy_gpu(float *xg, float *yg, float a){
	const int i = blockIdx.x*blockDim.x + threadIdx.x;
	yg[i] = a*xg[i]+yg[i];
}


int main()
{
	float x[ARRAY_SIZE];
	float y[ARRAY_SIZE];
   float z[ARRAY_SIZE];
	float a = 3.0;

   float *xg = 0;
	float *yg = 0;

   double t_CPU, ts_CPU, t_GPU, ts_GPU;

   for (int i=0; i < ARRAY_SIZE; i++){
		x[i] = 4.0;
      y[i] = 2.0;
	}

// Execution on GPU
	cudaMalloc(&xg, ARRAY_SIZE*sizeof(float));
	cudaMalloc(&yg, ARRAY_SIZE*sizeof(float));

	cudaMemcpy(xg, x, ARRAY_SIZE*sizeof(float), cudaMemcpyHostToDevice);
	cudaMemcpy(yg, y, ARRAY_SIZE*sizeof(float), cudaMemcpyHostToDevice);

	printf("Computing SAXPY on the GPU... ");
   ts_GPU = mysecond(); 
   saxpy_gpu<<<(ARRAY_SIZE+TPB-1)/TPB, TPB>>>(xg, yg, a);
   cudaDeviceSynchronize();
   t_GPU = mysecond()-ts_GPU;
	printf("Done\n");
   cudaMemcpy(z, yg, ARRAY_SIZE*sizeof(float), cudaMemcpyDeviceToHost);
	cudaFree(yg);
   int bl = ceil(ARRAY_SIZE/TPB);
// Execution on CPU
	printf("Computing SAXPY on the CPU... ");
	ts_CPU = mysecond();
   saxpy(ARRAY_SIZE, x, y, a);
   t_CPU = mysecond()-ts_CPU;
	printf("Done\n");
	
// Compare CPU and GPU result 
	double errg = 1e-10;
   for (int i=0; i < ARRAY_SIZE; i++){
      double err = abs(y[i]-z[i]);
		if (err > errg) errg = err;
	}
   printf("GPU Execution time: %12.9f\n", t_GPU); 
   printf("CPU Execution time: %12.9f\n", t_CPU);
	printf("Maximum error is: %16.12f\n", errg);
   printf("Elements of z: %16.12f, %16.12f\n", z[0], z[ARRAY_SIZE/2]);
   printf("Elements of y: %16.12f, %16.12f\n", y[0], y[ARRAY_SIZE/2]);
	printf("number of blocks: %d\n", bl);
	return 0;
}
