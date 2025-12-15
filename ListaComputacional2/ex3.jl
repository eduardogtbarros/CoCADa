using LinearAlgebra
using Images
include("PCA1.jl")

#Aplica recursivamente o PCA, até que a norma da aproximação seja >= 99% da original
function imgAprox(img)
  M = copy(img)
  V = zeros(size(img,1),0) #Matriz de componentes principais
  A = zeros(size(img))
  componentes=0

  while (norm(A)/norm(img)) < 0.99
    v = PCA1(M)
    V = hcat(V,v)
    M = M - (v*v')*M
    A = V* (V'*img)
    componentes+=1
  end
  return componentes, A
end

img = load("w.png")
display(Gray.(img))
img = Float64.(channelview(Gray.(img[:,:])))

componentes, A = imgAprox(img)
println("Com $(componentes) componente(s) - porcentagem da norma de Frobenius: $(norm(A)/norm(img))")
display(Gray.(A))

img = load("pinhalao.png")
display(Gray.(img))
img = Float64.(channelview(Gray.(img[:,:])))

componentes, A = imgAprox(img)
println("Com $(componentes) componente(s) - porcentagem da norma de Frobenius: $(norm(A)/norm(img))")
display(Gray.(A))