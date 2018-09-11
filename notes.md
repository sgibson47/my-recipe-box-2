ToDo:
  X 1. home page & root route
  X 2. signup page 
    X - /users/new route
    X - users controller
    X - users#new & users#create actions
    X - basic users#show page to redirect_to if signup is successful
        needs /users/:id route & users#show action
    X - enable sessions & log user in upon successfully creating a new account by setting session[:user_id] to newly created user's id
  X 3. login page
    X - sessions controller
    X - sessions#new & sessions#create actions
    X - log user in by setting session[:user_id] to newly created user's id if email and password provided match existing user -- otherwise render login page again with errors
    X- redirect to user's show page if successfully logged in
  X 4. log out 
    X - session#destroy action
    X - log user out by deleting :user_id from session hash
  X 5. helper methods & protected content
    X - #current_user
    X - #logged_in?
    X - #redirect_if_not_logged_in
       X you should only be able to see the signup, login, and home page without signing in
    6. CRUD Ingredients
      - routes
        C: get /ingredients/new, C: post /ingredients, 
        R: get /ingredients/:id, 
        U: get /ingredients/:id/[edit? update?], U: post /ingredients/:id, 
        D: delete /ingredients/:id
      - controller actions 
        #new, #create, 
        #show, 
        #destroy, 
        #update, [? #edit?]
    7. CRUD Basic Recipes
      X- routes
        C: get /recipes/new, C: post /recipes, 
        R: get /recipes/:id, U: get /recipes/:id/[edit? update?], 
        U: post /recipes/:id, 
        D: delete /recipes/:id
      - controller actions 
        #new, #create, 
        #show, 
        #destroy, 
        #update, [? #edit?]
      - forms & controllers should accomodate selecting [#?] from existing ingredients or create [#?] new ingredients

 Needs to Happen:
 - Create/Read/Update/Delete Ingredients
    - routes to C: get /ingredients/new, C: post /ingredients, R: get /ingredients/:id, U: get /ingredients/:id/[edit? update?], U: post /ingredients/:id, D: delete /ingredients/:id
    - controller actions #new, #create, #show, #destroy, #update, [? #edit?]

 - Create/Read/Update/Delete Recipes 
    - routes to C: get /recipes/new, C: post /recipes, R: get /recipes/:id, U: get /recipes/:id/[edit? update?], U: post /recipes/:id, D: delete /recipes/:id
    - controller actions #new, #create, #show, #destroy, #update, [? #edit?]
    - forms & controllers should accomodate selecting [#?] from existing ingredients or create [#?] new ingredients
  
  - Nested stuff
    - nested route show or index
        users/2/recipes
    - nested route "new" form
      - /users/2/recipes -- at bottom? in side bar? of index of user 2's recipes render recipe form?

  - OmniAuth
  - README 
    - Application description
    - Installation guide (e.g. fork and clone repo, migrate db, bundle install, etc)
    - Contributors guide (e.g. file an issue, file an issue with a pull request, etc)
    - Licensing statement (e.g. This project has been licensed under the MIT open source license.)

  - License





  - Make it Pretty
    - Add picture to recipes
    - Add picture to ingredients
    - cleaner way to take in instructions? maybe multiple strings that each descripe a step and then printing them in an ordered list to create an instructions section of a recipe show page. Is that another model? Instructions belong to recipes and recipes have many instructions?

  - Add Making model to track rating, notes, and photo re each attempt
  - Add class methods to sort recipes by avg ranking

  - Add model to hold recipe types? Breakfast, Lunch, Dinner etc.
  - Add model to hold recipe categories? Paleo, Keto, Gluten Free, Vegetarian, Vegan 




Rails Project Review Requirement Checklist

README file contains the following sections: 
[] Application description
[] Installation guide (e.g. fork and clone repo, migrate db, bundle install, etc)
[] Contributors guide (e.g. file an issue, file an issue with a pull request, etc)
[] Licensing statement (e.g. This project has been licensed under the MIT open source license.)

LICENSE file is included in your repo and linked at the bottom of your README file(e.g. MIT open source license, GNU public license, Creative Commons license) *
[] True

Using Ruby on Rails for the project *
[X] True

No scaffolding was used to build your project. *
[] True

Include at least one has_many relationship (please provide example including Model names and line numbers, e.g. User has_many Recipes, User model line 3) *
[X] 
User has_many Recipes, User model line 3
 
Include at least one belongs_to relationship (please provide example including Model names and line numbers, e.g. Recipe belongs_to User, Recipe model line 5) *
[X]
Recipe belongs_to User, Recipe model line 2

Include at least one has_many through relationship (please provide example including Model names and line numbers, e.g. User has_many Ingredients through Recipes, User model line 4) *
[]
Recipe has_many Ingredients through Amounts, Recipe model line ?


The "through" part of the has_many through includes at least one user submittable attribute. This field lives in the join table and needs to be able to be submitted via a form. (please provide attribute_name e.g. ingredients.quantity). *
[X]
amounts.servings_per_recipe

Include reasonable validations for simple model objects (please provide list of model objects with validations e.g. User, Recipe, Ingredient, Item) *
[X]
User, Ingredient, Amount

uniqueness - user.email, ingredient.name
presence - user.email, user.password, ingredient.serving_size_unit, ingredient.serving_size_number, amount.servings_per_recipe

Include a class level ActiveRecord scope method (please provide model object & class method name and URL to see the working feature e.g. User.most_recipes URL: /users/most_recipes) *
[] 
Min:
User.most_recipes -- returns the user who has created the most recipes
Recipe.by_ingredient(i) -- returns a collection of recipes that include ingredient i in their ingredients

Extra:
Recipe.highest_rating -- returns recipe with the highest average rating 
Recipe.highest_to_lowest_rating -- returns a collection of recipes sorted by avg. rating from highest to lowest
Recipe.lowest_to_highest_rating -- returns a collection of recipes sorted by avg. rating from lowest to highest
Recipe.by_meal_type(breakfast) -- returns a collection of recipes with matching meal type 


Include signup (how e.g. Devise) *
[X]
self drafted /users/new form & bcrypt

Include login (how e.g. Devise) *
[X]
set session[:user_id] after authenticating user & pw 

Include logout (how e.g. Devise) *
[X]
clear session[:user_id] 

Include third party signup/login (how e.g. Devise/OmniAuth, Google) *
[]
OmniAuth w/ Facebook

Include nested route show or index (please provide URL e.g. users/2/recipes) *
[]
/users/2/recipes -- index of user 2's recipes

Include nested route "new" form (please provide URL e.g. recipes/1/ingredients) *
[]
/users/2/recipes -- at bottom? in side bar? of index of user 2's recipes render recipe form?

Include form display of validation errors (please provide form URL e.g. /recipes/new) *
[X]
Min:
/users/new

Extra:
/recipes/new
/ingredients/new

The application is pretty DRY *
[]

Limited logic in controllers *
[]

Views use helper methods if appropriate *
[]

Views use partials if appropriate *
[]
