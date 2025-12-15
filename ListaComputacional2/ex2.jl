using LinearAlgebra
using Plots
include("PCA1.jl")

U_G = ["User A" 0.9 0.1
      "User B" 0.8 0.2
      "User C" 0.3 0.7
      "User D" 0.6 0.4
      "User E" 0.0 1.0]

F_G = ["Titanic" 0.9 0.1
      "Rocky" 0.1 0.9
      "The Hobbit" 0.5 0.5
      "Fight Club" 0.0 1.0
      "Jurassic Park" 0.2 0.8]

 #matrizes apenas com os números das matrizes acima
User_Gen = U_G[:,[2,3]]
Gen_Fil = F_G[:,[2,3]]' #Faz a transposta para ficar Gêneros X Filmes

User_Fil = User_Gen * Gen_Fil #Matriz de Usuários por Filmes

# Define e preenche a matriz com os títulos e os valores
m,n = size(User_Fil)
U_F = Matrix{Any}(undef,m+1,n+1)

U_F[1,1] = "X"
U_F[2:end,1] = U_G[:,1]
U_F[1, 2:end] = F_G[:,1]
U_F[2:end, 2:end] = User_Fil

show(stdout, "text/plain", U_F)

User_Fil = Float64.(User_Fil)
v = PCA1(User_Fil)
UF_1 = (v* v')User_Fil

println("Aproximação de posto 1 de Usuarios X Filmes")
display(UF_1)
println()
println("Norma da diferença entre a matriz e a aprox.: $(norm(User_Fil - UF_1))")

filmes=User_Fil' * v #Projetando a transposta da matriz na reta dada por v
fig = scatter(filmes, zeros(length(filmes)), color =:blue, markersize=6, label="Filmes", title="Filmes no R1")
display(fig)

usuarios=User_Fil * v #Projetando a matriz na reta dada por v
fig = scatter(usuarios, zeros(length(usuarios)), color =:blue, markersize=6, label="Usuários", title="Usuários no R1")
display(fig)