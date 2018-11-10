document.addEventListener("turbolinks:load", function(){
  let MAKINGS = []

  class Making{
    constructor(id, rating, notes, user_id, recipe_id){
      this.id = id
      this.rating = rating
      this.notes = notes
      this.user_id = user_id
      this.recipe_id = recipe_id

      MAKINGS.push(this)
    }

    createListItems(){
      return `<li>Rating:  ${this.rating} stars <br>Notes: ${this.notes}</li>`
    }
  }

  function makingsForDisplay(makings){
    makingsToDislay = []
    makings.forEach(function(making, index, arr){
      newMaking = new Making(making.id, making.rating, making.notes, making.user_id, making.recipe_id)
      makingsToDislay.push(newMaking.createListItems());
      return makingsToDislay.join('')
    })
  }

  function displayMakings(makings){
    $('.recipe-makings ul').append(makingsForDisplay(makings));
  }

  $('#new_making_of_recipe').on('submit', function(e){
    e.preventDefault();
    console.log(this)
  })

})




  