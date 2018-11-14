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

I refactored my show action to respond to requests for HTML & JSON so that I didn't need to have a new route and action from which to request JSON representing the recipe.    

def show
  respond_to do |format|
    format.html { render :show }
    format.json { render json: @recipe, status: 200}
  end
end

I emptied out the out the div holding a recipe's details and added a div with a distinct id so that I could easily select and inject content into. I also added a data attribute to the #recipe-show div so that I could access the current recipe's id from my JavaScript.

<div id="recipe-show" data-id="<%=@recipe.id%>">
  <div id="recipe-details">
  </div><!--recipe-details-->
</div><!--recipe-show-->

I generated a serializer and added to it all the attributes of a recipe that I wanted the serializer to output when it serialized a recipe. I also added Active Record Associations to the serializer so that the serializer would serialize a recipe's amounts and ingredients. 

class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :name, :instructions, :user_id

  has_many :amounts
  has_many :ingredients
end

Also, I wrote a bunch of JavaScript to do a number of different things for me. I needed JS to request data about the recipe from my server, organize the returned data, and to display the data. 

I set up a JavaScript Model Object to organize the returned data and gave the class methods that would create the HTML to display the pieces of a recipe's show page. 

class Recipe{
    constructor(id, name, instructions, user_id, amounts, ingredients){
      this.id = id
      this.name = name
      this.instructions = instructions
      this.user_id = user_id
      this.amounts = amounts
      this.ingredients = ingredients
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
  }

Next, I wrote a JavaScript function to create the div to hold a list of ingredients. 

function createIngredientDiv(){
    return `<div class="block ingred-list">
      <h3>Ingredients:</h3>
      <ul>
      </ul>
    </div><!--ingred-ist-->`
  }

Next, I wrote a JavaScript function to create a list item for each of the recipe's ingredients. 

  function createIngredientListItems(amounts, ingredients){
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

Next, I wrote a function that would inject the newly created ingredient list items into the DOM. 
  function displayIngredients(amounts, ingredients){
    $('.ingred-list ul').append(createIngredientListItems(amounts, ingredients));
  }

I also wrote a function to create and organize the major pieces of a recipe's show page. 

  function createShowHtml(recipe){
    let header = recipe.createRecipeHeader();
    let ingredientsDiv = createIngredientDiv();
    let instructions = recipe.createInstructionsDiv();
    let editDelete = recipe.createEditDeleteDiv();

    return header + ingredientsDiv + instructions + editDelete
  }

Finally, I wrote some JavaScript to request JSON representing the recipe.  I grabbed the recipe's id from the data attribute I put on the #recipe-show div and used it to make a GET request to the correct url. Next, I created a new Recipe object with the response to the GET request.  After that, I generated the HTML to display the major pieces of a recipe's show page.  Next, I injected that HTML into the DOM.  Lastly, I called displayIngredients() passing in the recipe's amounts and ingredients to create the HTML to display the recipe's ingredients list and inject it into the DOM

  let id = document.getElementById("recipe-show").dataset.id
  $.getJSON('/recipes/'+id, (recipe) => {
    $('#recipe-details').empty()

    let newGuy = new Recipe(recipe.id, recipe.name, recipe.instructions, recipe.user_id, recipe.amounts, recipe.ingredients);

    let html = createShowHtml(newGuy);

    $('#recipe-details').append(html);

    displayIngredients(newGuy.amounts, newGuy.ingredients);
  });

Once again, I put all of this JavaScript into an event listener that was triggered when I navigated between pages in my Rails application. 

document.addEventListener("turbolinks:load", function(){
  . . . 
}

Awesome! At this point, I had satisfied the sedcond and third requirements. When I navigated to a recipe's show page the GET request would fire, the recipe and its associated ingredients and amoutns would be stored in the a new Recipe object, and details about the recipe would be displayed.

<h4> Adding a Form that Submits Dynamically </h4>

To meet the project requirement that I render a form for creating a resource that submits dynamically, I made changes to my recipes serializer, added a form to the recipes show page and added JavaScript to my recipes.js file that would display the recipe's makings and submit the form without navigating away from the page.

First, I displayed all the recipe's makings on the show page.

I added an Active Record Association to the serializer so that the serializer would serialize a recipe's makings. 

has_many :makings

I edited the JS Object Model to take in and store a recipe's makings. 

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
    ...
  }

In the recipes show file, I added a div with a distinct id that I could inject HTML representing the recipe's makings into. 
 
 <div class="block instructions">
    <h3>Times Users Made <%=@recipe.name%></h3>
    <div id="recipe-makings" >
      <ul>   
      </ul>
    </div>
  </div>

Then I refactored and added to recipes.js to collect, organize and display the recipe's makings. I set up a JavaScript Model Object to organize the recipe's makings and gave the class a method that would create the HTML to display a list item for each making. I also, set a variable equal to an empty collection that I pushed each new JS object into so I would be able to access the Making objects to display later.

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

    createListItem(){
      return `<li>Rating:  ${this.rating} stars <br>Notes: ${this.notes}</li>`
    }
  }

I wrote a function that would create a new Making object for each of the recipe's makings, call the createListItem() method on each making and return a string that holds a list itme for each making. 

  function createMakingListItems(makings){
    var makingsListItemsToDisplay = []
    makings.forEach(function(making, index, arr){
      newMaking = new Making(making.id, making.rating, making.notes, making.user_id, making.recipe_id)
      makingsListItemsToDisplay.push(newMaking.createListItem());
    })
    return makingsListItemsToDisplay.join('')
  }

I wrote a function that would call createMakingListItems to create the HTML to display a list item for each making and inject it into the DOM. 

  function displayMakings(makings){
    $('#recipe-makings ul').append(createMakingListItems(makings));
  }

Lastly, I called displayMakings() passing it the recipe's makings in the GET request that retrieves the recipe and display's its details. 

  $.getJSON('/recipes/'+id, (recipe) => {
    ... 

    displayMakings(newGuy.makings);
  });

Now, when the recipes show page loaded not only would the recipe's details be displayed, but also a the recipe's makings would be retrieved, the recipe's makings would be stored in the MAKINGS collection, and a list of the recipe's makings would be displayed as well. 

Next, I added a form to create a new making associated with the show page's recipe. 

In my recipes#show action, I added instance variables representing the current user and a making associated with the current recipe so that later in my view I could wrap an action view form helper around them when creating my form to create a new making.

@user = current_user
@making = @recipe.makings.build

Also, I added a form to create a new making associated with this recipe that has a distinct id to enable me to access it from my JavaScript. 

  <div class="block instructions">
    <h3>Did you make <%=@recipe.name%>? How did it go?</h3>
    <div id="recipe-making-form">
      <%=form_for([@user, @making], :html => { :id => "new_making_of_recipe" })do |f|%>       
        <%= f.hidden_field :recipe_id, :value => @recipe.id %>  
        <%= f.label :rating%> 
        <%= f.number_field :rating, class: "form_fields"%>  
        <%= f.label :notes%>  
        <%= f.text_field :notes, class: "form_fields"%> 
        <br>  
        <br>  
        <br>  
        <br>  
        <%=f.submit :class => "submit_class"%>  
      <%end%>
    </div>
  </div>

I sliced off the last making before displaying them, because the most recently created making was now the empty one that I built in the recipes#show action to wrap the form around. 

  function displayMakings(makings){
    var makingsToDisplay = makings.slice(0, (makings.length - 1))
    $('#recipe-makings ul').append(createMakingListItems(makingsToDisplay));
  }

Next, I drew a new route to which I would submit the form. 

  post '/makingsFromRecipe', to: 'makings#createFromRecipe'

Next, I created a makings#createFromRecipe controller action that mirrored my makings#create action, but returned JSON instead of redirecting to the new making's show page. 

  def createFromRecipe
    @making = Making.new(makings_params)
    @making.user = current_user
    if @making.save
      render json: @making, status: 200
    end
  end

Lastly, I wrote some JavaScript to control the outcome when the new form was submitted. I prevented its default behavior, serialized the form data, and submitted the data to the new '/makingsFromRecipe' route. Next, I used the response from the POST request to create a new Making object, create a list item for it, and to append that list item to the existing list of the recipe's makings. I also stored the form in a variable so that I could reset it after creating and displaying the new making. 

  $('#new_making_of_recipe').submit(function(e){
    e.preventDefault();

    let that = this

    var values = $(this).serialize();

    var making = $.post('/makingsFromRecipe', values);
 
    making.done(function(data) {
      newMaking = new Making(data.id, data.rating, data.notes, data.user_id, data.recipe_id)
      $('#recipe-makings ul').append(newMaking.createListItem());
      that.reset();
    });
  });

With all that in place, I had satisfied fourth requirement. When I navigated to my recipes show page a form to create a new making would be displayed. If a user submitted the form, a new making associated with this recipe would be created and displayed without reloading the page or navigating away. 

I hope my walking through how I refactored my Rails project to meet the Rails and JavaScript requirements was helpful.

Check out the code at: https://github.com/sgibson47/my-recipe-box-2




