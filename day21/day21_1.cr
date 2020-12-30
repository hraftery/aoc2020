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
  if allergens.all?
    ingredientsNoAllergensIndices << i
    puts allIngredients[i]
  end
end

numTimesIngredientsAppear = 0
allFoods.each do |ingredients, allergens|
  numTimesIngredientsAppear += ingredientsNoAllergensIndices.count { |i| ingredients[i]? }
end

puts numTimesIngredientsAppear
