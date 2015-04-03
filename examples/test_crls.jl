using HarwellRutherfordBoeing
using Krylov
# using ProfileView

# M = HarwellBoeingMatrix("data/illc1033.rra");
M = HarwellBoeingMatrix("data/illc1850.rra");
A = M.matrix;
(m, n) = size(A);
@printf("System size: %d rows and %d columns\n", m, n);

λ = 1.0e-3;

for nrhs = 1 : size(M.rhs, 2)
  b = M.rhs[:,nrhs];
  (x, stats) = crls(A, b, λ=λ);
  #   @profile (x, stats) = crls(A, b, λ=λ);
  @time (x, stats) = crls(A, b, λ=λ);
  resid = norm(A' * (A * x - b) + λ * x) / norm(b);
  @printf("CRLS: Relative residual: %8.1e\n", resid);
  @printf("CRLS: ‖x‖: %8.1e\n", norm(x));
end

# ProfileView.view()
