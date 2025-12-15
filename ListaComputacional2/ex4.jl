using LinearAlgebra
using Images
include("PCA1.jl")
include("PCADeterminado.jl")

G = [1 1 0 1 1 1 1 1 1 1 1 1 1 1
     1 1 0 1 1 0 0 0 0 0 0 0 0 0
     0 0 0 0 0 1 1 1 1 1 1 1 1 1
     1 1 0 1 1 0 0 0 0 0 0 0 0 0
     1 1 0 1 1 1 1 1 1 1 1 1 1 1
     0 0 0 0 0 0 0 0 0 0 0 0 0 0
     1 1 1 1 1 1 1 1 1 1 1 1 1 1
     0 0 0 0 0 0 0 0 0 0 0 0 0 0
     1 1 1 1 1 1 1 1 1 1 1 1 1 1]

display(Gray.(G))

posto = rank(G)
B,C=PCADeterminado(G,posto)

println("O posto da bandeira é $(rank(G)), já que A / BC = $(norm(G)/norm(B*C))")