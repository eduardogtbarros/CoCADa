using Plots
using Statistics

gr(size=(600, 400)) #Define o tamanho da janela

n = 30
x = range(-200, 200, length=n) #x é vetor de 30 valores entre 0 e 1

a = rand(-10:10,6) #coeficientes aleatórios para grau 5
y = a[1] .+ a[2]*x .+ a[3]*x.^2 .+ a[4]*x.^3 .+ a[5]*x.^4 .+ a[6]*x.^5

scatter(x, y, leg=false, title="$(n) pontos de um polinômio de grau 5 qualquer")

E(regressao) = sum((regressao .- y).^2) #Erro quadrático

grau_max = 29

erros = Float64[] #vetor de erros por grau usado na letra d

for grau in 0:grau_max
  # Método da regressão polinomial
  M = hcat([x .^ i for i in 0:grau]...)
  βsol = M \ y
  regressao = M * βsol

  fig = scatter(x, y, title="Grau $(grau), E = $(E(regressao))", leg=false)
  plot!(fig, sort(x), M[sortperm(x),:] * βsol)
  display(fig)
  push!(erros, E(regressao))
end

plot(0:grau_max, erros, marker=:circle, xlabel="Grau", ylabel="E", title="Grau de y(x) X E(a,b)")