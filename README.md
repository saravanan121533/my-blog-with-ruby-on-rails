### my-blog-with-ruby-on-rails

Starting a Blog app to showcase my web development technical skills that I learned by joining the CodeCore Development Bootcamp.

#### Features
1. Display blog list.
2. Add a new blog.
3. Edit a blog.
4. Delete a blog.
5. Show a specific blog.


### Progress
1. Create rails folder

2. Create db at (local) postgresql server: `blog_development`

3. Integrate bootstrap
   - @Gemfile : gem 'bootstrap-sass'
   - run bundle install
   - manual configuration: add a new file at
     /app/assets/stylesheets/bootstrap_and_overrides.scss
   ```
     @import "bootstrap-sprockets";
     @import "bootstrap";
   ```

4. Add development gems
   ```
     # we use the three gems below for a nicer Rails console display
     gem "awesome_print"
     gem "interactive_editor"
     gem "hirb"
   ```

5. Add models:
  - category - validates :title, presence: true
  - comment - validates :body, presence: true, uniqueness: true
  - contact
  - post - validates :title, presence: true, uniqueness: true

6. Add controller: home and posts

7. Add routes:
  ```
  root "home#home"
  get "/about" => "home#about"

  resources :posts
  ```

8. Add CRUD for posts controller and its equivalent view pages
