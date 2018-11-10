document.addEventListener("turbolinks:load", function(){
  let id = document.getElementById("recipe-show").dataset.id

  class Recipe{
    constructor(id, name, instructions, user_id, amounts, ingredients, makings){
      this.id = id
      this.name = name
      this.instructions = instructions
      this.user_id = user_id
      this.amounts = amounts
      this.ingredients = ingredients
      this.makings = makings
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
          <a href="/recipes/${this.id}/edit">Edit Recipe</a>
        </div><!--edit-->
        <div class="delete block">
          <a data-confirm="Are you sure?" data-method="delete" href="/recipes/${this.id}">Delete Recipe</a>
        </div><!--delete-->
      </div><!--edit_delete-->`
    }

  }


  function createIngredientDiv(){
    return `<div class="block ingred-list">
      <h3>Ingredients:</h3>
      <ul>
      </ul>
    </div><!--ingred-ist-->`
  }

  function createIngredientListItems(amounts, ingredients){
    var amountsArray =[]
    for(let a of amounts){
      amountsArray.push(a.servings_per_recipe)
    }

    var listItems = []

    ingredients.forEach(function(ingredient, index, arr){
      var num = amountsArray[index] * ingredient.serving_size_number 
      listItems.push(`<li>${num} ${ingredient.serving_size_unit} ${ingredient.name}</li>`)
    })
    
    return listItems.join('')
  }

  function displayIngredients(amounts, ingredients){
    $('.ingred-list ul').append(createIngredientListItems(amounts, ingredients));
  }

  function createShowHtml(recipe){
    let header = recipe.createRecipeHeader();
    let ingredientsDiv = createIngredientDiv();
    let instructions = recipe.createInstructionsDiv();
    let editDelete = recipe.createEditDeleteDiv();

    return header + ingredientsDiv + instructions + editDelete
  }


  $.getJSON('/recipes/'+id, (recipe) => {
    $('#recipe-show').empty()

    let newGuy = new Recipe(recipe.id, recipe.name, recipe.instructions, recipe.user_id, recipe.amounts, recipe.ingredients)

    let html = createShowHtml(newGuy)

    $('#recipe-show').append(html);

    displayIngredients(newGuy.amounts, newGuy.ingredients);
  });

})




  