### my-blog-with-ruby-on-rails

Starting a Blog app to showcase my web development technical skills that I learned by joining the CodeCore Development Bootcamp.

#### Features
1. Display blog list.
2. Add a new blog.
3. Edit a blog.
4. Delete a blog.
5. Show a specific blog.
6. Post a comment for a specific blog post.
7. Display all comments posted for a specific blog post.
8. Add user and session management.


#### Progress
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
  - category - `validates :title, presence: true`
  - comment - `validates :body, presence: true, uniqueness: true`
  - contact
  - post - `validates :title, presence: true, uniqueness: true`

6. Add controller: home and posts

7. Add routes:
  ```
  root "home#home"
  get "/about" => "home#about"

  resources :posts
  ```

8. Add CRUD for posts controller and its equivalent view pages

9. Update comment model to associate it with post model
  - generate a new migration

  ```
  > bin/rails generate migration AddPostIdToComments post:references

  # [OUTPUT] /db/migrate/<new migration file>
  class AddPostIdToComments < ActiveRecord::Migration
    def change
      add_reference :comments, :post, index: true, foreign_key: true
    end
  end
  ```

  - update existing controllers

  ```
  > vim /app/models/comment.rb
  # belongs_to :<parent_model_name>
  belongs_to :post

  > vim /app/models/post.rb
  # has_many :<child_model>, dependent: :destroy
  has_many :comments, dependent: :destroy
  ```

  - update routes add comments inside the posts routes

  ```
  resources :posts do
    resources :comments
  end
  ```

  - execute migration

  ```
  > bin/rake db:migrate

  # [OUTPUT] /db/schema.rb this will add the following lines:
   - t.integer  "post_id"
   - add_index "comments", ["post_id"], name: "index_comments_on_post_id", using: :btree
   - add_foreign_key "comments", "posts"
  ```

  - confirm changes in db

  ```
  > @pgAdmin

  # [OUTPUT] /Tables/comments/Constraint added fk_rails_<num>
  /Tables/comments/Indexes added index_comments_on_post_id
  ```

10. Re-factor post controller by adding a post_params private method that will handle the following process:

  ```
  @post = Post.find params[:id]
  ```

11. Implement comments at specific blog post.

12. Add .gitignore so that /tmp files will not be added during git commit.


#### ERD
1. A user has many comments, and a comment belongs to a user
2. A user has many posts, and a post belongs to a user
3. A post has many comments, and a comment belongs to a post
4. [NY] A category has many post, and a post belongs to a category
5. Contact ?

#### Sign-Up
1. [Views] `root_path` /posts/index.html.erb
  - display existing blog posts
2. [Action] user clicks Sign-Up button
3. [Model] users
  - validates email
4. [Controller] `new_user_path` users#new
  - instantiate user object
4. [Views] `new_user_path` /user/new.html.erb
  - Sign-up page is displayed
5. [Action] user inputs neccessary information and click Create User
6. [Controller] `users_path` users#create
  - get user input from params
