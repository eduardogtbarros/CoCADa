using LinearAlgebra

# Instantes t da medição
t = [15*60,16*60+30,17*60+30]

# T(t) para cada instante
T = [34,30,25]

T_inicial = 37
T_final = 20

# Linearização
# T(t) = t_final + (t_inicial - t_final)e^-kt
# T(t) - t_final = (t_inicial - t_final)e^-kt
# Y(t) = ln(T - t_final) = ln(t_inicial - t_final) - kt
Y = log.(T .- T_final)

# Método da Regressão Linear
X = [sum(t .^2) sum(t)
    sum(t) length(t)]
c = [sum(t .* Y)
    sum(Y)]
β = X \ c

# Se Y(t) = b - kt, t = (Y(t) - b)/-k = (ln(T(t)-T_inicial) - b)/-k
t_37 = (log.(T_inicial-T_final) - β[2])/β[1]

println("Hora aproximada da morte: $(floor(Int, t_37/60)):$(round(Int, t_37%60)).")