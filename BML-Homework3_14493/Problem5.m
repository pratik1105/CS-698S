%Majority of this code has been taken from demoRegression.m which was
%available on the gpml website. Appropriate changes have been made to
%change the input data to the required one.

disp('Hit any key to continue...'); pause

clear all, close all
write_fig = 0;
disp(' ')

disp('meanfunc = {@meanSum, {@meanLinear, @meanConst}}; hyp.mean = [0.5; 1];')
meanfunc = {@meanSum, {@meanLinear, @meanConst}}; hyp.mean = [0.5; 1];
disp('covfunc = {@covMaterniso, 3}; ell = 1/4; sf = 1; hyp.cov = log([ell; sf]);')
covfunc = {@covMaterniso, 3}; ell = 1/4; sf = 1; hyp.cov = log([ell; sf]);
disp('likfunc = @likGauss; sn = 0.1; hyp.lik = log(sn);')
likfunc = @likGauss; sn = 0.1; hyp.lik = log(sn);
disp(' ')

n = 10;
x =[-2.23;-1.30;-0.42;0.30;0.33;0.52;0.87;1.80;2.74;3.62];
y =[1.01;0.69;-0.66;-1.34;-1.75;-0.98;0.25;1.57;1.65;1.51];

 
figure(1)
set(gca, 'FontSize', 24)
disp(' '); disp('plot(x, y, ''+'')')
plot(x, y, '+', 'MarkerSize', 12)
axis([-3.9 3.9 -3.9 3.9])
grid on
xlabel('input, x')
ylabel('output, y')
if write_fig, print -depsc f1.eps; end
disp(' '); disp('Hit any key to continue...'); pause

disp(' ')
disp('nlml = gp(hyp, @infGaussLik, meanfunc, covfunc, likfunc, x, y)')
nlml = gp(hyp, @infGaussLik, meanfunc, covfunc, likfunc, x, y)
disp(' ')

disp('z = linspace(-1.9, 1.9, 101)'';')
z = linspace(-3.9, 3.9, 101)';
disp('[m s2] = gp(hyp, @infGaussLik, meanfunc, covfunc, likfunc, x, y, z);')
[m s2] = gp(hyp, @infGaussLik, meanfunc, covfunc, likfunc, x, y, z);

figure(2)
set(gca, 'FontSize', 24)
disp(' ')
disp('f = [m+2*sqrt(s2); flipdim(m-2*sqrt(s2),1)];') 
f = [m+2*sqrt(s2); flipdim(m-2*sqrt(s2),1)];
disp('fill([z; flipdim(z,1)], f, [7 7 7]/8);')
fill([z; flipdim(z,1)], f, [7 7 7]/8);

disp('hold on; plot(z, m); plot(x, y, ''+'')')
hold on; plot(z, m, 'LineWidth', 2); plot(x, y, '+', 'MarkerSize', 12)
axis([-3.9 3.9 -3.9 3.9])
grid on
xlabel('input, x')
ylabel('output, y')
if write_fig, print -depsc f2.eps; end
disp(' '); disp('Hit any key to continue...'); pause

disp(' ')
disp('covfunc = @covSEiso; hyp2.cov = [0; 0]; hyp2.lik = log(0.1);')
covfunc = @covSEiso; hyp2.cov = [0; 0]; hyp2.lik = log(0.1);
disp('hyp2 = minimize(hyp2, @gp, -100, @infGaussLik, [], covfunc, likfunc, x, y)')
hyp2 = minimize(hyp2, @gp, -100, @infGaussLik, [], covfunc, likfunc, x, y);
disp(' ')

disp('exp(hyp2.lik)')
exp(hyp2.lik)
disp('nlml2 = gp(hyp2, @infGaussLik, [], covfunc, likfunc, x, y)')
nlml2 = gp(hyp2, @infGaussLik, [], covfunc, likfunc, x, y)
disp('[m s2] = gp(hyp2, @infGaussLik, [], covfunc, likfunc, x, y, z);')
[m s2] = gp(hyp2, @infGaussLik, [], covfunc, likfunc, x, y, z);

disp(' ')
figure(3)
set(gca, 'FontSize', 24)
f = [m+2*sqrt(s2); flipdim(m-2*sqrt(s2),1)];
disp('fill([z; flipdim(z,1)], f, [7 7 7]/8)');
fill([z; flipdim(z,1)], f, [7 7 7]/8)
disp('hold on; plot(z, m); plot(x, y, ''+'')');
hold on; plot(z, m, 'LineWidth', 2); plot(x, y, '+', 'MarkerSize', 12)
grid on
xlabel('input, x')
ylabel('output, y')
axis([-3.9 3.9 -3.9 3.9])
if write_fig, print -depsc f3.eps; end
disp(' '); disp('Hit any key to continue...'); pause

disp(' ')
disp('hyp.cov = [0; 0]; hyp.mean = [0; 0]; hyp.lik = log(0.1);')
hyp.cov = [0; 0]; hyp.mean = [0; 0]; hyp.lik = log(0.1);
disp('hyp = minimize(hyp, @gp, -100, @infGaussLik, meanfunc, covfunc, likfunc, x, y);')
hyp = minimize(hyp, @gp, -100, @infGaussLik, meanfunc, covfunc, likfunc, x, y);
disp('[m s2] = gp(hyp, @infGaussLik, meanfunc, covfunc, likfunc, x, y, z);')
[m s2] = gp(hyp, @infGaussLik, meanfunc, covfunc, likfunc, x, y, z);

figure(4)
set(gca, 'FontSize', 24)
disp(' ')
disp('f = [m+2*sqrt(s2); flipdim(m-2*sqrt(s2),1)];')
f = [m+2*sqrt(s2); flipdim(m-2*sqrt(s2),1)];
disp('fill([z; flipdim(z,1)], f, [7 7 7]/8)')
fill([z; flipdim(z,1)], f, [7 7 7]/8)
disp('hold on; plot(z, m); plot(x, y, ''+'');')
hold on; plot(z, m, 'LineWidth', 2); plot(x, y, '+', 'MarkerSize', 12)
grid on
xlabel('input, x')
ylabel('output, y')
axis([-3.9 3.9 -3.9 3.9])
if write_fig, print -depsc f4.eps; end
disp(' '); disp('Hit any key to continue...'); pause

disp('large scale regression using the FITC approximation')
disp('nu = fix(n/2); u = linspace(-1.3,1.3,nu)'';')
nu = fix(n/2); u = linspace(-3.9,3.9,nu)';
disp('covfuncF = {@apxSparse, {covfunc}, u};')
covfuncF = {@apxSparse, {covfunc}, u};
disp('[mF s2F] = gp(hyp, @infGaussLik, meanfunc, covfuncF, likfunc, x, y, z);')
[mF s2F] = gp(hyp, @infGaussLik, meanfunc, covfuncF, likfunc, x, y, z);

figure(5)
set(gca, 'FontSize', 24)
disp(' ')
disp('f = [mF+2*sqrt(s2F); flipdim(mF-2*sqrt(s2F),1)];')
f = [mF+2*sqrt(s2F); flipdim(mF-2*sqrt(s2F),1)];
disp('fill([z; flipdim(z,1)], f, [7 7 7]/8)')
fill([z; flipdim(z,1)], f, [7 7 7]/8)
disp('hold on; plot(z, mF); plot(x, y, ''+'');')
hold on; plot(z, mF, 'LineWidth', 2); plot(x, y, '+', 'MarkerSize', 12)
disp('plot(u,1,''o'')')
plot(u,1,'ko', 'MarkerSize', 12)
grid on
xlabel('input, x')
ylabel('output, y')
axis([-3.9 3.9 -3.9 3.9])
if write_fig, print -depsc f5.eps; end
disp(' ')