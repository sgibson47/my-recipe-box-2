let INGREDIENTS = [] 
let start = 0
let end = 5
  
class Ingredient{
  constructor(id, name, serving_size_number, serving_size_unit){
    this.id = id
    this.name = name
    this.serving_size_number = serving_size_number
    this.serving_size_unit = serving_size_unit
  }
}

Ingredient.prototype.createIngredientDivs = function(){
    return `<div class="name">
        <a href="/ingredients/${this.id}">${this.name}</a>
      </div><!--name-->
      <div class="serving">
        Serving Size: ${this.serving_size_number} ${this.serving_size_unit}
      </div> <!--serving-->`
  }

const displayIngredients = function(){
  for(let i of INGREDIENTS.slice(start, end)){
    $('#ingredients-index').append(i.createIngredientDivs())
  }
}
  

const getIngredients = function(){
  $.getJSON('/ingredients', (ingredients) => {
    INGREDIENTS.length = 0
    ingredients.forEach( (i) => {
      let newIngred = new Ingredient(i.id, i.name, i.serving_size_number, i.serving_size_unit)
      INGREDIENTS.push(newIngred)
    })
    $('#ingredients-index').empty(); 
    displayIngredients();
  });
}

document.addEventListener("turbolinks:load", function(){

  $('#next').on('click', () =>{
    //empty out current list
    $('#ingredients-index').empty();

    //increment start and end to grab next 5 itmes from collection
    if(end < INGREDIENTS.length){
      start += 5
      end += 5
    }

    //display ingredients
    displayIngredients();
  })


  $('#previous').on('click', () =>{
    //empty out current list
    $('#ingredients-index').empty();

    //decrement start and end to grab next 5 itmes from collection
    if(start > 0){
      start -= 5
      end -= 5
    }

    //display ingredients
    displayIngredients();
  })
})


