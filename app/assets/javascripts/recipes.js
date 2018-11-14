document.addEventListener("turbolinks:load", function(){
  let id = document.getElementById("recipe-show").dataset.id
  let MAKINGS = []

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

  class Making{
    constructor(id, rating, notes, user_id, recipe_id){
      this.id = id
      this.rating = rating
      this.notes = notes
      this.user_id = user_id
      this.recipe_id = recipe_id

      MAKINGS.push(this)
    }

    createListItem(){
      return `<li>Rating:  ${this.rating} stars <br>Notes: ${this.notes}</li>`
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

  function createMakingListItems(makings){
    var makingsListItemsToDisplay = []
    makings.forEach(function(making, index, arr){
      newMaking = new Making(making.id, making.rating, making.notes, making.user_id, making.recipe_id)
      makingsListItemsToDisplay.push(newMaking.createListItem());
    })
    return makingsListItemsToDisplay.join('')
  }

  function displayIngredients(amounts, ingredients){
    $('.ingred-list ul').append(createIngredientListItems(amounts, ingredients));
  }

  function displayMakings(makings){
    var makingsToDisplay = makings.slice(0, (makings.length - 1))
    $('#recipe-makings ul').append(createMakingListItems(makingsToDisplay));
  }


  function createShowHtml(recipe){
    let header = recipe.createRecipeHeader();
    let ingredientsDiv = createIngredientDiv();
    let instructions = recipe.createInstructionsDiv();
    let editDelete = recipe.createEditDeleteDiv();

    return header + ingredientsDiv + instructions + editDelete
  }

  $.getJSON('/recipes/'+id, (recipe) => {
    $('#recipe-details').empty()

    let newGuy = new Recipe(recipe.id, recipe.name, recipe.instructions, recipe.user_id, recipe.amounts, recipe.ingredients, recipe.makings);

    let html = createShowHtml(newGuy);

    $('#recipe-details').append(html);

    displayIngredients(newGuy.amounts, newGuy.ingredients);

    displayMakings(newGuy.makings);
  });

  $('body').on('submit','#new_making_of_recipe', function(e){
    e.preventDefault();

    let that = this

    let values = $(this).serialize();

    let making = $.post('/makingsFromRecipe', values);
 
    making.done(function(data) {
      newMaking = new Making(data.id, data.rating, data.notes, data.user_id, data.recipe_id)
      $('#recipe-makings ul').append(newMaking.createListItem());
      that.reset();
    });

    return false;
  });
})








  