document.addEventListener("turbolinks:load", function(){
  let id = document.getElementById("recipe-show").dataset.id

  class Recipe{
    constructor(id, name, instructions, user_id, amounts, ingredients){
      this.id = id
      this.name = name
      this.instructions = instructions
      this.user_id = user_id
      this.amounts = amounts
      this.ingredients = ingredients
    }
  }

  $.getJSON('/recipes/'+id, (recipe) => {
    
    console.log(recipe)
    let newGuy = new Recipe(recipe.id, recipe.name, recipe.instructions, recipe.user_id, recipe.amounts, recipe.ingredients)
    console.log(newGuy)
  });

})

