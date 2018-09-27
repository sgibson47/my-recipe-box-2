Rails Project Review Requirement Checklist

README file contains the following sections: 
[] Application description
[] Installation guide (e.g. fork and clone repo, migrate db, bundle install, etc)
[] Contributors guide (e.g. file an issue, file an issue with a pull request, etc)
[] Licensing statement (e.g. This project has been licensed under the MIT open source license.)

LICENSE file is included in your repo and linked at the bottom of your README file(e.g. MIT open source license, GNU public license, Creative Commons license) *
[X] True

Using Ruby on Rails for the project *
[X] True

No scaffolding was used to build your project. *
[X] True

Include at least one has_many relationship (please provide example including Model names and line numbers, e.g. User has_many Recipes, User model line 3) *
[X] 
User has_many Recipes, User model line 3
 
Include at least one belongs_to relationship (please provide example including Model names and line numbers, e.g. Recipe belongs_to User, Recipe model line 5) *
[X]
Recipe belongs_to User, Recipe model line 2

Include at least one has_many through relationship (please provide example including Model names and line numbers, e.g. User has_many Ingredients through Recipes, User model line 4) *
[X]
Recipe has_many Ingredients through Amounts, Recipe model line 5


The "through" part of the has_many through includes at least one user submittable attribute. This field lives in the join table and needs to be able to be submitted via a form. (please provide attribute_name e.g. ingredients.quantity). *
[X]
amounts.servings_per_recipe

Include reasonable validations for simple model objects (please provide list of model objects with validations e.g. User, Recipe, Ingredient, Item) *
[X]

Include a class level ActiveRecord scope method (please provide model object & class method name and URL to see the working feature e.g. User.most_recipes URL: /users/most_recipes) *
[] 
Min:
Recipe.by_ingredient(ingred_id) URL: 
Recipe.by_avg_rating URL: 
Recipe.by_times_made URL: 

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
[X]
OmniAuth w/ Facebook

Include nested route show or index (please provide URL e.g. users/2/recipes) *
[X]
/users/2/recipes -- index of user 2's recipes

Include nested route "new" form (please provide URL e.g. recipes/1/ingredients) *
[X]
/users/2/makings/new

Include form display of validation errors (please provide form URL e.g. /recipes/new) *
[X]
/users/new

The application is pretty DRY *
[]

Limited logic in controllers *
[]

Views use helper methods if appropriate *
[]

Views use partials if appropriate *
[]