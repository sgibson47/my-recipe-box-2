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

    createRecipeHeader(){
      return `<h1>${this.name}'s Page</h1>`
    }
    createInstructionsDiv(){
      return `<div class="block instructions">
        <h3>Instructions</h3>
        <p>${this.instructions}</p>
      </div><!--instructions-->`
    }

    createEditDeleteDiv(){
      return `<div class="edit_delete">
        <div class="edit block">
          <a href="/recipes/${this.id}/edit">"Edit Recipe"</a>
        </div><!--edit-->
        <div class="delete block">
          <a data-confirm="Are you sure?" data-method="delete" href="/recipes/${this.id}">"Delete Recipe"</a>
        </div><!--delete-->
      </div><!--edit_delete-->`
    }
  }

  $.getJSON('/recipes/'+id, (recipe) => {
    
    console.log(recipe)
    let newGuy = new Recipe(recipe.id, recipe.name, recipe.instructions, recipe.user_id, recipe.amounts, recipe.ingredients)
    console.log(newGuy)
  });

})


  
  <div class="block ingred-list">
    <h3>Ingredients:</h3>
    <%= render "display_ingredients_for_recipe_show", recipe: @recipe %>
  </div><!--ingred-ist-->


  