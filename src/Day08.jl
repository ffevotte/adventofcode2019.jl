module Day08
export part1, part2

parse_image(image) = [parse(Int, c) for c in image]

layer(image, n, i) = view(image, n*(i-1)+1:n*i)

layers(image, n) = let (nLayers, rem) = divrem(length(image), n)
    @assert rem == 0
    (layer(image, n, i) for i in 1:nLayers)
end

function checksum(image, n)
    image = parse_image(image)

    (cmin, imin) = findmin(count.(x->x==0, layers(image, n)))

    layerMin = layer(image, n, imin)
    @assert count(x->x==0, layerMin) == cmin

    count(x->x==1, layerMin) * count(x->x==2, layerMin)
end

function decode(image, a, b)
    image = parse_image(image)
    n = a*b

    im = fill(2, (a, b))
    for l in layers(image, n)
        for i in eachindex(im)
            im[i]==2 && (im[i]=l[i])
        end
    end

    im
end

part1() = checksum(readline("input08.dat"), 25*6)

function part2()
    image = decode(readline("input08.dat"), 25, 6)
    image = map(image) do x
        x==0 ? ' ' : 'O'
    end
    reduce(*, String(image[:,i])*"\n" for i in 1:size(image, 2))
end

end
