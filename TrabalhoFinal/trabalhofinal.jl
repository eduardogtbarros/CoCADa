# using Pkg

# if !haskey(Pkg.installed(), "Images")
#     Pkg.add("Images")
# end
# if !haskey(Pkg.installed(), "Clustering")
#     Pkg.add("Clustering")
# end

using Images
using LinearAlgebra
using Statistics
using Clustering

function k_otimo(img, limiar)
    λ,V = eigen(img*img')
    λ = sort(λ, rev=true)

    variancia_total = sum(λ)

    k_otimo = 0

    for i in 1:length(λ)
        significancia = (λ[i] / variancia_total)
        
        if significancia < limiar
            k_otimo = i - 1
            break
        end        
        k_otimo = i
    end
    return k_otimo
end

function PCA1(M)
  C = M*M'
  λ,V = eigen(C)

  v = V[:,end]
  return v
end

function PCA_otimo(img, limiar)
    M = copy(img)                 # Matriz Resto
    V = zeros(size(M, 1),0) # Matriz de autovetores
    A = zeros(size(M))      # Matriz Aproximada
    comp = 0
    k = k_otimo(img, limiar)

    while comp < k
        v = PCA1(M)
        V = hcat(V, v)
        M = M - (v*v')*M
        A = V*(V'*img)
        comp += 1
    end
    return A
end

function k_means(nome_entrada, k, using_pca, limiar=0.005)
    # Cada elemento dessa matriz é pixel RGB
    img = load("entrada/$(nome_entrada)")
    img = float32.(img) # K-means trabalha com números reais

    alt, lar = size(img)
    channels = channelview(img)

    img_t_original = reshape(channels, 3, alt * lar)

    if using_pca
        img_t = copy(img_t_original)
        media = mean(img_t, dims=2)
        img_t .-= media # Centraliza os dados

        img_t  = PCA_otimo(img_t, limiar)
        
        img_t .+= media # Descentraliza os dados
    else
        img_t = img_t_original
    end

    @time R = kmeans(img_t, k; maxiter=200, display=:none)
    
    # Substitui cada pixel pela cor do centróide do cluster ao qual ele pertence
    img_clust = zeros(Float32, 3, alt * lar)
    for i in 1:(alt*lar)
        cluster_idx = R.assignments[i]
        img_clust[:, i] = R.centers[:, cluster_idx]
    end

    # Reconstrói a imagem
    img_k = colorview(RGB, reshape(img_clust, 3, alt, lar))
    return img_k, norm(img_clust)/norm(img_t_original)
end

k=100 # número de clusters
limiar = 0.005 # limiar para PCA
using_pca = true
nome_entrada = "ana.jpg" # substitua pelo nome da sua imagem
nome_saida = first(splitext(nome_entrada))

if using_pca
    img_pca_k, semelhanca = k_means(nome_entrada, k, using_pca, limiar)
    save("saida/$(nome_saida)_pca_k$(k).png", img_pca_k)
else
    img_k, semelhanca = k_means(nome_entrada, k, using_pca)
    save("saida/$(nome_saida)_k$(k).png", img_k)
end

println("Porcentagem de semelhança: $semelhanca")