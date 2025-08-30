using LinearAlgebra

filmes = [
    "Toy Story",
    "Rocky",
    "De Volta pro Futuro",
    "Curtindo a Vida Adoidado",
    "Os Incríveis",
    "Duna",
    "Batman Begins",
    "Harry Potter 1",
    "Shrek"
]

index = Dict(filmes[i] => i for i in eachindex(filmes)) #Cria um dicionário para os filmes

#Cria uma matriz com vencedor, perdedor, diferença dos gols
dados = [
    ("Toy Story", "Rocky", 12-1),
    ("De Volta pro Futuro", "Curtindo a Vida Adoidado", 8-5),
    ("Os Incríveis", "Duna",   10-3),
    ("Batman Begins", "Harry Potter 1", 7-5),
    ("Shrek", "Duna", 11-2),
    ("Harry Potter 1", "Rocky", 10-3),
    ("Toy Story", "De Volta pro Futuro", 9-4),
    ("Os Incríveis", "Harry Potter 1", 9-4),
    ("Curtindo a Vida Adoidado", "Duna", 7-5),
    ("De Volta pro Futuro", "Duna", 7-5),
    ("Shrek", "Rocky", 12-1),
    ("Os Incríveis", "Batman Begins", 9-4),
    ("Toy Story", "Batman Begins", 8-5),
    ("Os Incríveis", "Curtindo a Vida Adoidado", 10-3)
]

n = length(filmes) #Número de variáveis do sistema
m = length(dados) #Número de equações do sistema

A = zeros(m+1,n)
b = zeros(m+1)

# Atribui valor 1 para o vencedor e -1 para o perdedor.
# Esses valores multiplicam o saldo do filme
for(i, (vencedor,perdedor,diferenca)) in enumerate(dados)
    A[i, index[vencedor]] = 1
    A[i, index[perdedor]] = -1
    b[i] = diferenca
end

# Restrição adcional para que A'A não seja singular
# a soma dos saldos é 0.
A[end, :] .= 1
b[end] = 0

x_ = (A' * A) \ (A' * b) #Vetor de saldos de cada time por mínimos quadrados

rank = [(filmes[i], x_[i]) for i in 1:n]
rank = sort(rank, by = x -> x[2], rev = true) #Ordena decrescentemente o rank pelo saldo

println("Ranking dos filmes preferidos dos 13 alunos:")
for i in 1:length(filmes)
    println("$(i)º- $(rank[i][1])")
end