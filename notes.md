
Rails Project Review Requirement Checklist

README file contains the following sections: 
[] Application description
[] Installation guide (e.g. fork and clone repo, migrate db, bundle install, etc)
[] Contributors guide (e.g. file an issue, file an issue with a pull request, etc)
[] Licensing statement (e.g. This project has been licensed under the MIT open source license.)

LICENSE file is included in your repo and linked at the bottom of your README file(e.g. MIT open source license, GNU public license, Creative Commons license) *
[] True

Using Ruby on Rails for the project *
[] True

No scaffolding was used to build your project. *
[] True

Include at least one has_many relationship (please provide example including Model names and line numbers, e.g. User has_many Recipes, User model line 3) *
[] 
User has_many Recipes, User model line ?
 
Include at least one belongs_to relationship (please provide example including Model names and line numbers, e.g. Recipe belongs_to User, Recipe model line 5) *
[]
Recipe belongs_to User, Recipe model line ?

Include at least one has_many through relationship (please provide example including Model names and line numbers, e.g. User has_many Ingredients through Recipes, User model line 4) *
[]
Recipe has_many Ingredients through Amounts, Recipe model line ?


The "through" part of the has_many through includes at least one user submittable attribute. This field lives in the join table and needs to be able to be submitted via a form. (please provide attribute_name e.g. ingredients.quantity). *
[]
amounts.servings_per_recipe

Include reasonable validations for simple model objects (please provide list of model objects with validations e.g. User, Recipe, Ingredient, Item) *
[]
uniqueness - recipe.name, user.email, ingredient.name
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
[]
self drafted /users/new form & bcrypt

Include login (how e.g. Devise) *
[]
set session[:user_id] after authenticating user & pw 

Include logout (how e.g. Devise) *
[]
clear session[:user_id] 

Include third party signup/login (how e.g. Devise/OmniAuth, Google) *
[]
OmniAuth w/ Facebook

Include nested route show or index (please provide URL e.g. users/2/recipes) *
[]
/users/2/recipes -- index of user 2's recipes

Include nested route "new" form (please provide URL e.g. recipes/1/ingredients) *
[]
/users/2/recipes -- at bottom of index of user 2's recipes render recipe form?

Include form display of validation errors (please provide form URL e.g. /recipes/new) *
[]
/recipes/new
/users/new
/ingredients/new

The application is pretty DRY *
[]

Limited logic in controllers *
[]

Views use helper methods if appropriate *
[]

Views use partials if appropriate *
[]
