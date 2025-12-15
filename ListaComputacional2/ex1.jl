using LinearAlgebra
using Plots
include("PCA1.jl")

A =[0 1 3
    3 1 0]
v = PCA1(A)
A_1 = (v* v')A

println("Aproximação de posto 1 de A")
display(A_1)
println()
println("Norma da diferença entre a matriz e a aprox.: $(norm(A-A_1))")

B =[0 1 3 2
    2 3 1 0]
v = PCA1(B)
B_1 = (v* v')B

println("Aproximação de posto 1 de B")
display(B_1)
println()
println("Norma da diferença entre a matriz e a aprox.: $(norm(B-B_1))")

function plotaColunas(M,v, titulo)
fig = scatter(M[1,:],M[2,:], title=titulo, label="Colunas da matriz", color=:blue, markersize=6)
t=range(-5,5, length=100)
plot!(t .* v[1], t .*v[2], label="Reta dada por v")
display(fig)

end

plotaColunas(A, PCA1(A), "Colunas da matriz A e o PCA1")
plotaColunas(B, PCA1(B), "Colunas da matriz B e o PCA1")