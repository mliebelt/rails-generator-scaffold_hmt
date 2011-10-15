First try to provide a generator for Rails 3.x that scaffolds a has_many :through relation. See the [stackoverflow question](http://stackoverflow.com/questions/7708848/rails-has-and-belongs-to-many-has-many-through-scaffolding/7709118#7709118 "Rails has_many :through scaffolding") for some context.

To use the generator for "has_many :through", you have to do the following steps:

1. Install the generator by copying the directory "scaffold_hmt" to your rails application
    in the directory 'lib/generators'.
2. Start the generator by calling from your home directory of the application:
    `rails g scaffold_htm Model1 Model2`.
3. The generator will generate or change the following files:
    - Migration `<timestamp>_create_<model1>_<model2>.rb`
    - Model file `<model1>s_<model2>.rb`
    - Insert into <model1>.rb and <model2>.rb the `has_many :through` relations.
