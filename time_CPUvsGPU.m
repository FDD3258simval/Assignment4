data = load('data_cpu_gpu.txt');

array_size = data(:,1);
t_gpu = data(:,2);
t_cpu = data(:,3);

loglog(array_size, t_cpu, array_size, t_gpu, '-o','LineWidth',2)
set(gca,'TickLabelInterpreter','latex')
set(gca,'FontSize',24)
xlabel('Array size [B]','interpreter','latex')
ylabel('Execution time [s]','interpreter','latex')
legend('CPU', 'GPU','interpreter','latex')
