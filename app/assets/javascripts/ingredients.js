$(document).ready(function(){
  // JS to be executed when page loads
})

function makeIngredientClass(){
  let INGREDIENTS = []

  class Ingredient{
    constructor(name, serving_size_number, serving_size_unit){
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

