using LinearAlgebra
include("PCA1.jl")

#Aplica PCA recursivamente, com k=(posto da matriz) iterações
function PCADeterminado(A,posto)
  M = A
  V = zeros(size(A,1),0)

  for i in 1:posto
    v = PCA1(M)
    V = hcat(V,v)
    M = M - (v*v')*M
  end
  return V,(V'*A)
end