using CSV, DataFrames, LinearAlgebra, Dates

path = "Pesagem - Sheet1.csv"
tabela = CSV.read(path, DataFrame)

#Valores lidos da tabela
datas = tabela.Data
pesos = tabela."Peso (kg)"

dias = Int[]
meses = Int[]
anos = Int[]

for data in datas
    d,m = split(data, "/")
    push!(dias, parse(Int, d))
    push!(meses, parse(Int, m))
end

ano_base = 2024
ano_atual = ano_base
mes_ant = meses[1]

#Muda para o próximo ano se o mês seguinte for menor que o anterior
for m in meses
    if m < mes_ant
        ano_atual+=1
    end
    push!(anos, ano_atual)
    mes_ant = m
end

datas = Date.(anos, meses, dias) #Transforma datas num vetor do tipo Date
data0 = minimum(datas) #Separa o primeiro dia

datas = Dates.value.(datas .- data0) #Transforma as datas em números contados a partir de data0

# Método da Regressão Linear
X = [sum(datas .^2) sum(datas)
    sum(datas) length(datas)]
c = [sum(datas .* pesos)
    sum(pesos)]
β = X \ c

# Se y(x) = ax + b, x = (y(x) - b)/a
data_110 = (110-β[2])/β[1]
data_110 = data0 + Day(round(Int, data_110)) #Pega o valor de data_110, soma ao data0 e transforma em tipo Date

println("Ele antigirá 110 kg aprox. no dia $(Dates.format(data_110, "dd/mm")).")