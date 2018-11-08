$(document).ready(function(){
  // JS to be executed when page loads
})

function makeIngredientClass(){
  let INGREDIENTS = []

  class Ingredient{
    constructor(id, name, serving_size_number, serving_size_unit){
      this.id = id
      this.name = name
      this.serving_size_number = serving_size_number
      this.serving_size_unit = serving_size_unit

      INGREDIENTS.push(this)
    }

    createIngredientDivs(name, serving_size_number, serving_size_unit){
      return `<div class="name">
        <a href="/ingredients/${id}">${name}</a>
      </div><!--name-->
      <div class="serving">
        Serving Size: ${serving_size_number} ${serving_size_unit}
      </div> <!--serving-->`
    }
  }
}

function getAllIngredients(){
  $.get('/ingredients', (ingredients) => {
    ingredients.forEach( (i) => {
      new Ingredient(i.id, i.name, i.serving_size_number, i.serving_size_unit)
    })
  });
}

