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
  X 6. CRUD Ingredients
      X- routes
        C: get /ingredients/new, C: post /ingredients, 
        R: get /ingredients/:id, 
        U: get /ingredients/:id/[edit? update?], U: post /ingredients/:id, 
        D: delete /ingredients/:id
      X- Ingredients Controller
      X- controller actions 
        X#new, 
        X#create, 
        X#show, 
        X#destroy, 
        X#update,
        X#edit
      X- Views
        X - new
        X - form
        X- show
        X- edit
    X7. CRUD Basic Recipes
      X - routes
        C: get /recipes/new, C: post /recipes, 
        R: get /recipes/:id, U: get /recipes/:id/edit, 
        U: patch /recipes/:id, 
        D: delete /recipes/:id
      X- controller actions 
        #new, #create, 
        #show, 
        #destroy, 
        #update,
        #edit
        #index
      X - forms & controllers should accomodate selecting 5 ingredients from existing ingredients or 
       - create 1 new ingredient when creating a new recipe
       nope this is taking too much time, move it to the extras section and add a link to new ingredients to recipes/new in a side bar or below ingredients list 
    X8. Nested route show or index
        X users/2/recipes - index
    X9. nested route "new" form
      X - add makings model
      X- nested new form for a making
        /users/:id/makings/new
    X10. class level ActiveRecord scope methods
      - recipes by rating
      - recipes by ingredient
    X11. OmniAuth
    X 12. Connect eveything
      - add links to allow a user to navigate around site
    X 13. add protections
      - only the user who created a recipe or a making should be able to edit or delete that record
    X 14. edit controllers & views to give user access to scope methods (filter/limit recipes displayed in index)
    X 15. style all the remaining ugly away
      X-  refactor nav bar to enable access to all the things the site can do
        - Recipes '/recipes'
          - each recipe displayed is a link to that recipe's show page
          - show page will have links to access edit form and to delete a recipe
        - Your Recipes "/users/#{current_user.id}/recipes"
        - Save a Recipe "/recipes/new"
        - Ingredients '/recipes'
          - each ingredient displayed is a link to that ingredient's show page
          - show page will have links to access edit form and to delete an ingredient
        - Save an Ingredient "/ingredients/new"
        - What Everyone's Making '/makings'
        - What You've Made "/users/#{current_user.id}/makings"
          - each making displayed is a link to that making's show page
          - show page will have links to access edit form and to delete a making
        X8- Record What You Made
        Need to add 
        X9- Your Page 
        keep the column structure you have and move logout & greeting to footer if logged_in?
        "/users/#{current_user.id}/makings/new"
        - Log Out "/signout"
          -- keep or move to footer? 
          -- maybe move "you're logged in as: <>" to footer as well?
        - Walk through each template & style
          X- Users
            X- new
            X- show
          X- Sessions
            X- new
          X- Recipes
            X - index
            X - user index
            X - show
            X - new
            X- edit
          - Ingredients
            X - index
            X- show
            X - new
            X- edit
          - Makings
            X- index
            X- user index
            X- show
            X- new
            X- edit
    16. review views re appropriate use of helpers & partials
    17. draft README
    18. record walkthrough & upload to youtube
    19. daft blog post
    20. checklist & submit!
    -
    Extra
    21. review styling to simplify/remove duplicative code
    #. add message to failed login with email & password, if email is registered, but pw doesn't match asking if this is the first time they've tried to log in with their email. If so suggest log in via facebook and reset password 
    redirect if user who first logged in with facebook tries to with their email and a password
      - back to '/'
      - add user edit form that let's user change their password 
    #. improve ingredient model
        - change serving size number to a fixed list with common fractions [1 .. 10, 1/8, 1/4, 1/2, 3/4, 1/3, 2/3]?
        - change serving units to a fixed list  [ounce, gram, cup, tsp, tbsp, pinch]
        - add nutritional info 
        - displays the proper word for the unit, singular or plural-
          - cup/cups, ounce/ounces, pinch/pinches, gram/grams
    #. improve instructions
      - cleaner way to take in instructions? maybe multiple strings that each descripe a step and then printing them in an ordered list to create an instructions section of a recipe show page. Is that another model? Instructions belong to recipes and recipes have many instructions?
    #. add category model 
      - Breakfast, Lunch, Dinner etc.
      - Paleo, Keto, Gluten Free, Vegetarian, Vegan
    #. add pictures?
      - to recipes
      - to ingredients
      - to makings
    #.  re name makings to trys 
      - yeah, makes way more sense to ask someone if they've tried a recipe and then how it went?
      - ooo add difficulty rating to too each making/try


