$(document).ready(function(){
  var INGREDIENTS = [] 

  class Ingredient{
    constructor(id, name, serving_size_number, serving_size_unit){
      this.id = id
      this.name = name
      this.serving_size_number = serving_size_number
      this.serving_size_unit = serving_size_unit

      INGREDIENTS.push(this)
    }

    createIngredientDivs(){
      return `<div class="name">
        <a href="/ingredients/${this.id}">${this.name}</a>
      </div><!--name-->
      <div class="serving">
        Serving Size: ${this.serving_size_number} ${this.serving_size_unit}
      </div> <!--serving-->`
    }
  }

  $.getJSON('/ingredients', (ingredients) => {
    console.log(ingredients)
    ingredients.forEach( (i) => {
      new Ingredient(i.id, i.name, i.serving_size_number, i.serving_size_unit)
    })
    for(let i of INGREDIENTS){
      $('#ingredients-index').append(i.createIngredientDivs())
    }
  });

    
})


//display # on load
//add Previous and Next buttons
// add event listeners to Previous and Next 
// that use createIngredientDivs() to build HTML
// and that inject new HTML into DOM


