function PCA1(M)
  C = M*M' #matriz de correlação
  λ,V = eigen(C)

  v = V[:,argmax(λ)]

  return v
end