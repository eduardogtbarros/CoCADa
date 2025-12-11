using LinearAlgebra

b = [250 0 0]'
M = [ 0  0.5 0.2
     0.8  0   0
     0  0.5  0 ]
k = 5

for i in 1:k
    global b = M * b
end

display(b)

lambda, V = eigen(M)

v = V[:,argmax(lambda)]

display(v)