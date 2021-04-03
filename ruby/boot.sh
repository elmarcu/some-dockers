cd /app

# rm -rf /app/examples

DIR="/app/examples/"
if [ ! -d "$DIR" ]; then

  rails new examples
  cd /app/examples
  gem uninstall sqlite3 -v 1.4.0
  sed -i "s/gem 'sqlite3'/gem 'sqlite3', '~> 1.3.13'/g" Gemfile
  bundle update

  rails generate controller hello
  echo "<h2>Hello World</h2>" > app/views/hello/index.html.erb
  sed -i "s/end/\troot 'hello#index'\nend/g" config/routes.rb
fi

cd /app/examples
rails server -p 3000
