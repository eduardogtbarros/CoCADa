using LinearAlgebra
using Images
using Plots
include("PCADeterminado.jl")

F = [1 0  1  0 1
     1 0  1  0 1
     1 1 0.5 1 1
     0 1  1  1 0
     1 0  0  0 1]

display(Gray.(F))
println("O posto é $(rank(F)).")

B,C=PCADeterminado(F,rank(F))

display(B)
display(C)
display(Gray.(B*C))

M = F
V = zeros(size(F,1),0)
E = Float64[]

#Calcula o PCA recursivamente 5 vezes
for i in 1:5
    global M, V, E
    v = PCA1(M)
    V = hcat(V,v)
    M = M - (v*v')*M
    A = V* (V'*F)
    E = vcat(E, norm(F-A)) #Armazena o erro para cada aproximação
end

fig = scatter(1:5, E, color =:blue, markersize=6, label="erros", title="Erros X ",xlabel = "postos", ylabel = "erro")
plot!(1:5, E, color=:blue, linewidth=3, label="")
display(fig)