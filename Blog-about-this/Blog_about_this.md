<h1> Rails with JavaScript Portfolio Project</h1>

<h2>What were the requirements?</h2>

For this project I needed to refactor my Rails project to use JavaScript.  In particular, I needed to meet the following five requirements.

1. Must render at least one index page via JavaScript and an Active Model Serialization JSON Backend.

2. Must render at least one show page via JavaScript and an Active Model Serialization JSON Backend.

3. Your Rails application must dynamically render on the page at least one 'has-many' relationship through JSON using JavaScript.

4. Must use your Rails application and JavaScript to render a form for creating a resource that submits dynamically.

5. Must translate the JSON responses into JavaScript Model Objects using either ES6 class or constructor syntax. The Model Objects must have at least one method on the prototype. 


<h2>How did I meet the requirements?</h2>

My rails project was a recipe holder that let users save recipes, ingredients and record a rating and notes when they made a particular recipe by recording a "making." In order to meet the new requirements I refactored my ingredients index page and the recipes show page. 

<h3> Refactoring the Index Page </h3>

I began by refactoring my Ingredients index page. I had rendered a list of all the ingredients by passing an instance variable that represented a collection of all the ingredients to the ingredients index view and then iterating through the collection to display a link to and the serving size of each of the ingredients. 

My ingredients#index controller action looked like this:

def index
  @ingredients = Ingredient.all
end

And, my ingredients index view looked like this: 

<h1 class="body-title">Ingredients</h1>
<div class="ingredients">
  <% @ingredients.each do |i| %>
      <div class="name">
        <%=link_to i.name, ingredient_path(i)%>
      </div><!--name-->
      <div class="serving">
        Serving Size: <%="#{i.serving_size_number} #{i.serving_size_unit}"%>
      </div> --><!--serving-->
  <%end%>
</div> <!--ingredient-->

To meet the project requirements, I made changes to both of these items, generated a serializer to save me from having to create my own, and created a new file to hold the JavaScript that would retrieve and display the ingredients saved in my database. 

I emptied out the out the div holding each ingredient's details and added a div with a distinct id so that I could easily select and inject content into. I also added "Previous" and "Next" buttons so I could display a portion of the ingredients and let a user click on these buttons to scroll through the entire collection. 

<h1 class="body-title">Ingredients</h1>
<div id="ingredients-index-buttons">
  <button id="previous">Previous</button>
  <button id="next">Next</button>
</div>
<div class="ingredients">
  <div id="ingredients-index"></div>
</div>

I refactored my index action to respond to requests for HTML & JSON so that I didn't need to have a new route and action from which to request JSON representing all the ingredients. Now, my controller action would render the index view when I navigated to the '/ingredients' url and my browser sent a GET request for HTML. And when I requested JSON from the same url, the controller action would render JSON. 

def index
  @ingredients = Ingredient.all
  respond_to do |format|
    format.html { render :index }
    format.json { render json: @ingredients, status: 200}
  end
end

I generated a serializer and added to it all the attributes of an ingredient that I wanted the serializer to output when it serialized an ingredient. 

class IngredientSerializer < ActiveModel::Serializer
  attributes :id, :name, :serving_size_number, :serving_size_unit
end

Also, I wrote a bunch of JavaScript to do a number of different things for me. I needed JS to request data about all the ingredients from my server, organize the returned data, and to display the data. 

I set up a JavaScript Model Object to organize the returned data and gave the class a method that would create the HTML to display each ingredient. I also, set a variable equal to an empty collection that I pushed each new JS object into so I would be able to access the Ingredient objects to display later. 

let INGREDIENTS = [] 

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

I wrote a function that would call the createIngredientDivs() method on a portion of the ingredients and inject the resulting HMTL into the DOM. I also defined variables so I could grab and display different segements of the INGREDIENTS collection. 

let start = 0
let end = 5

function displayIngredients(){
  for(let i of INGREDIENTS.slice(start, end)){
    $('#ingredients-index').append(i.createIngredientDivs())
  }
}

I set up a GET request to '/ingredients' that would request JSON representing all the ingredients, create JS objects of each, store them in the INGREDIENTS collection, and display the first five of them. 

$.getJSON('/ingredients', (ingredients) => {
  ingredients.forEach( (i) => {
    new Ingredient(i.id, i.name, i.serving_size_number, i.serving_size_unit)
  })
  displayIngredients();
});

Last, I set up event listeners on the buttons that would erase the ingredients currently on display, increment or decrement the start and end variables, and inject HTML representing the next of previous five ingredients. 

$('#next').on('click', () =>{
    $('#ingredients-index').empty();

    if(end < INGREDIENTS.length){
      start += 5
      end += 5
    }

    displayIngredients();
  })


  $('#previous').on('click', () =>{
    $('#ingredients-index').empty();

    if(start > 0){
      start -= 5
      end -= 5
    }

    displayIngredients();
  })

I put all of this code into an event listener that was triggered when I navigated between pages in my Rails application. 

document.addEventListener("turbolinks:load", function(){
  . . . 
}

With all that in place, I had satisfied the first and fifth requirements. When I navigated to my ingredients index page the GET request would fire, all of the ingredients would be stored in the INGREDIENTS collection, and the first five ingredients would be displayed. From there, a user could view five ingredients at a time by clicking on the "Next" and "Previous" buttons.  

<h3> Refactoring the Show Page </h3>

Next, I turned to refactoring the recipes show page. I had rendered the details of a particular recipe by passing an instance variable that represented a recipe to the recies show view and then displaying attributes of the passed in recipe with ERB and a partial that handled iterating through and formatting a recipe's ingredients for display.

My recipes#show controller action looked like this:

before_action :find_recipe_by_params_id, only: [:update, :destroy, :edit, :show]

def show
end

private

  def find_recipe_by_params_id
    @recipe = Recipe.find(params[:id])
  end

And, my recipes show view looked like this: 

<div id="recipe-show">
  <h1><%=@recipe.name%>'s Page</h1>
  <div class="block ingred-list"> 
    <h3>Ingredients:</h3> 
    <%= render "display_ingredients_for_recipe_show", recipe: @recipe %>  
  </div><!--ingred-ist--> 
    
  <div class="block instructions">  
    <h3>Instructions</h3> 
    <p><%=@recipe.instructions%></p>  
  </div><!--instructions--> 
   <div class="edit_delete">  
    <div class="edit block">  
      <%=link_to "Edit Recipe", edit_recipe_path(@recipe) %>  
    </div><!--edit--> 
    <div class="delete block">  
      <%=link_to "Delete Recipe", recipe_path(@recipe), method: :delete %>  
    </div><!--delete--> 
  </div><!--edit_delete-->  
</div><!--recipe-show-->  </div><!--recipe-show--> 

<h4> Rendering a Recipe's Details </h4>

To meet the project requirements that I render at least one show page via JavaScript and an Active Model Serialization JSON Backend and render at least one 'has-many' relationship through JSON using JavaScript, I made changes to both of these items, generated a serializer, and created a new file to hold the JavaScript that would retrieve and display the recipe saved in my database. 


<h4> Adding a Form that Submits Dynamically </h4>

To meet the project requirement that I render a form for creating a resource that submits dynamically, I made changes to my recipes serializer and added JS to my recipes.js file that would display the recipe's makings, render a form to create a new making, and submit the form without navigating away from the show page.


With all that in place, I had satisfied the second, third and fourth requirements. When I navigated to my recipes show page the GET request would fire, the recipe would retrieve, the recipe's makings would be stored in the MAKINGS collection, and the recipe's details, current list of makings, and a form to create a new making would be displayed. If a user submitted the form, a new making associated with this recipe would be created and displayed without reloading the page or navigating away. 

Check out the code at: https://github.com/sgibson47/my-recipe-box-2




