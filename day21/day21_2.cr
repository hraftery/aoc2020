filename = "day21/input.txt"
#filename = "day21/input_example.txt"

f = File.read(filename)

allIngredients = [] of String
allAllergens = [] of String
allFoods = [] of Tuple(Array(Bool), Array(Bool))


f.each_line do |l|
  ingredientsStr, allergensStr = l.split(" (contains ")
  ingredients = ingredientsStr.split(' ')
  allergens = allergensStr.chomp(')').split(", ")

  ingredients.each { |i| allIngredients << i unless allIngredients.includes?(i) }
  allergens.each   { |a| allAllergens   << a unless allAllergens.includes?(a)   }

  ingredientsBoolArr = Array(Bool).new(allIngredients.size, false)
  ingredients.each { |i| ingredientsBoolArr[allIngredients.index(i).not_nil!] = true }
  
  allergensBoolArr = Array(Bool).new(allAllergens.size, false)
  allergens.each   { |a| allergensBoolArr[allAllergens.index(a).not_nil!] = true }

  allFoods << { ingredientsBoolArr, allergensBoolArr }
end

ingredientsWithoutAllergens = [] of Array(Bool)
allIngredients.size.times do
  ingredientsWithoutAllergens << Array(Bool).new(allAllergens.size, false)
end

#puts allIngredients
#puts allAllergens
#puts allFoods

allFoods.each do |ingredients, allergens|
  ingredientsWithoutAllergens.each_with_index do |withoutAllergens, i|
    # if this ingredient is not set (false or non-existant), add all allergens from this food
    unless ingredients[i]?
      acc = [] of Bool
      # Oh Crystal
      withoutAllergens.zip?(allergens) { |a, b| acc << (b.nil? ? false : (a || b)) } # do |a, b|
      ingredientsWithoutAllergens[i] = acc
    end
  end
  #puts ingredientsWithoutAllergens
end

ingredientsNoAllergensIndices = [] of Int32

ingredientsWithoutAllergens.each_with_index do |allergens, i|
  ingredientsNoAllergensIndices << i if allergens.all?
end

# Now go through all foods, and for each allergen eliminate ingredients that can't be the source

# First, create the data structure
# Array of allergens, each element is an array of ingredient flags
allergenSources = [] of Array(Bool)

allAllergens.size.times do
  thisAllergenSources = Array(Bool).new(allIngredients.size, true) # start with any ingredient being the culprit
  ingredientsNoAllergensIndices.each { |i| thisAllergenSources[i] = false } # eliminate ingredients with no allergens
  allergenSources << thisAllergenSources # and add it to the array
end

#puts allergenSources

# Second, eliminate ingredients which are not in the food that has the allergen.

allFoods.each do |ingredients, allergens|
  allergens.each_with_index do |b, ai|
    next unless b # skip unless this food contains this allergen
    allIngredients.size.times do |ii|
      allergenSources[ai][ii] = false unless ingredients[ii]?
    end
  end
end

# Finally, look for single source allergens and eliminate that ingredient from other allergens.

# compile the definitive list
allergenSource = Array(Int32 | Nil).new(allAllergens.size, nil)

while allergenSource.any?(Nil)
  #puts allergenSource
  #puts allergenSources

  allergenSources.each_with_index do |sources, ai|
    next if allergenSource[ai] # this allergen's source is already assigned
    if sources.count(true) == 1 # found a single source
      allergenSource[ai] = sources.index(true).not_nil!
    else
      allergenSource.each_with_index do |source, i|
        sources[source] = false if source # eliminate source if we've found an allergen for it
      end
    end
  end
  
end

# allergenSource.each_with_index do |ii, ai|
#   puts "#{allIngredients[ii.not_nil!]} contains #{allAllergens[ai.not_nil!]}"
# end

# puts ""

i=0 # aren't iterators fun? Always having to create your own indices...
allergenSourceSortedByAllergen = allergenSource.sort_by { |x| i += 1; allAllergens[i-1] }

puts allergenSource
puts allergenSourceSortedByAllergen

puts ""

allergenSource.each_with_index do |ii, ai|
  puts "#{allIngredients[ii.not_nil!]} contains #{allAllergens[ai.not_nil!]}"
end

puts ""

allergenSourceSortedByAllergen.each_with_index do |ii, ai|
  puts "#{allIngredients[ii.not_nil!]} contains #{allAllergens.sort[ai.not_nil!]}"
end

canonicalDangerousIngredientList = allergenSourceSortedByAllergen.map { |ii| allIngredients[ii.not_nil!] }
                                                                 .join(',')

puts ""
puts canonicalDangerousIngredientList
