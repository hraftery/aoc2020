filename = "day3/input.txt"
#filename = "day3/input_example.txt"
treesProduct = 1_i64

[1, 3, 5, 7, 1].each_with_index do |xStep, i|
    x = 0
    trees = 0
    skipLine = true
    d = File.read(filename)
    d.each_line do |l|
        #puts l[x]
        if i == 4
            skipLine = !skipLine
            if skipLine
                next
            end
        end

        if l[x] == '#'
            trees += 1
        end
        x += xStep
        x %= l.size
    end
    puts trees
    treesProduct *= trees
end

puts treesProduct
