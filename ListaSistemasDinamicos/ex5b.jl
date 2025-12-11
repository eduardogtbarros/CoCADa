x1 = 0
x2 = 0
x3 = 0
x4 = 1

for k in 1:100
    global x1, x2, x3, x4
    x1_k = x3+(1/2)*x4
    x2_k = (1/3)*x1
    x3_k = (1/3)*x1+(1/2)*x2+(1/2)*x4
    x4_k = (1/3)*x1+(1/2)*x2

    x1 = x1_k
    x2 = x2_k
    x3 = x3_k
    x4 = x4_k
end

display([x1, x2, x3, x4])