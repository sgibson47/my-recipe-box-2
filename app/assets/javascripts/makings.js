document.addEventListener("turbolinks:load", function(){
  class Recipe{
    constructor(id, rating, notes, user_id, recipe_id){
      this.id = id
      this.rating = rating
      this.notes = notes
      this.user_id = user_id
      this.recipe_id = recipe_id
    }
  }

  $('#new_making_of_recipe').on('submit', function(e){
    e.preventDefault();
    console.log(this)
  })

})




  