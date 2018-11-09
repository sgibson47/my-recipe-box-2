document.addEventListener("turbolinks:load", function(){
  let id = document.getElementById("recipe-show").dataset.id

  class Ingredient{
    constructor(id, name, serving_size_number, serving_size_unit){
      this.id = id
      this.name = name
      this.serving_size_number = serving_size_number
      this.serving_size_unit = serving_size_unit
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

  function displayIngredients(){
    for(let i of INGREDIENTS.slice(start, end)){
      $('#ingredients-index').append(i.createIngredientDivs())
    }
  }

  $.getJSON('/recipes/'+id, (recipe) => {
    
    console.log(recipe)
    // ingredients.forEach( (i) => {
    //   new Ingredient(i.id, i.name, i.serving_size_number, i.serving_size_unit)
    // })
    // displayIngredients();
  });

})


