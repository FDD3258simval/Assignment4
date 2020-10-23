load 'bandwidth.txt';
sep = 81;

array_size_HD = bandwidth(1:sep,1);
b_HD = bandwidth(1:sep,2);

array_size_DH = bandwidth(sep+1:2*sep,1);
b_DH = bandwidth(sep+1:2*sep,2);

array_size_DD = bandwidth(2*sep+1:3*sep,1);
b_DD = bandwidth(2*sep+1:3*sep,2);

plot(array_size_HD, b_HD, array_size_DH, b_DH, array_size_DD, b_DD, ...
     'LineWidth',2)
set(gca,'TickLabelInterpreter','latex')
set(gca,'FontSize',24)
xlabel('Array size [B]','interpreter','latex')
ylabel('Bandwidth [MB/s]','interpreter','latex')
legend('Host to Device', 'Device to Host', 'Device to Device','interpreter','latex')
