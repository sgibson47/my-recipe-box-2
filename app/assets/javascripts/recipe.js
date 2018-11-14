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

  createMakingsDiv(){
    return ` <div class="block instructions">
      <h3>Times Users Made ${this.name}</h3>
      <div id="recipe-makings" >
        <ul>
          ${createMakingListItems(this.makings)}
        </ul>
      </div>
    </div>`
  }
}


const createIngredientListItems = function (amounts, ingredients){
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

const createMakingListItems = function (makings){
    console.log(makings)
    console.log(makings.length)
    let makingsListItemsToDisplay = []
    let makingsForEach = makings.slice(0, (makings.length-1))
    makingsForEach.forEach(function(making, index, arr){
      makingsListItemsToDisplay.push(`<li>Rating:  ${making.rating} stars <br>Notes: ${making.notes}</li>`);
    })
    return makingsListItemsToDisplay.join('')
  }

const createIngredientDiv = function (amounts, ingredients){
    return `<div class="block ingred-list">
      <h3>Ingredients:</h3>
      <ul>
        ${createIngredientListItems(amounts, ingredients)}
      </ul>
    </div><!--ingred-list-->`

    createIngredientListItems(amounts, ingredients)
  }

// const displayMakings = function (makings){
//     console.log(makings)
//     console.log(makings[0])
//     let makingsToDisplayAfterSlice = makings.slice(0, (makings.length - 1))
//     console.log(makingsToDisplayAfterSlice)
//     let makingsHTML = createMakingListItems(makingsToDisplayAfterSlice);
//     $('#recipe-makings ul').append(makingsHTML);
//   }

const createShowHtml = function (recipe){
    let header = recipe.createRecipeHeader();
    let ingredientsDiv = createIngredientDiv(recipe.amounts, recipe.ingredients);
    let instructions = recipe.createInstructionsDiv();
    let editDelete = recipe.createEditDeleteDiv();
    let makings = recipe.createMakingsDiv();

    return header + ingredientsDiv + instructions + editDelete + makings
  }

const getRecipe = function(){
  let amountsToDisplay = [];
  let ingredientsToDisplay = [];
  let makingsToDisplay = [];
  let id = $("#recipe-show").data('id');

  $.getJSON('/recipes/'+id, (recipe) => {

    $('#recipe-details').empty()

    newGuy = new Recipe(recipe.id, recipe.name, recipe.instructions, recipe.user_id, recipe.amounts, recipe.ingredients, recipe.makings);

    let html = createShowHtml(newGuy);

    $('#recipe-details').append(html);
  });
}

document.addEventListener("turbolinks:load", function(){

  getRecipe();

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
  });
})






  