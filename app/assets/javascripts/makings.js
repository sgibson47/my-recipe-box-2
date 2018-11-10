document.addEventListener("turbolinks:load", function(){
  $('#new_making_of_recipe').on('submit', function(e){
    e.preventDefault();
    console.log(this)
  })

})




  