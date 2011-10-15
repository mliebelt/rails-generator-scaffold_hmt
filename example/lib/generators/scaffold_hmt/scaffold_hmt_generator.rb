class ScaffoldHmtGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  argument :first, :type => :string, :description => "Model name of the first part of the join model." 
  argument :second, :type => :string, :description => "Model name of the second part of the join model." 
  argument :join_model, :type => :string, :description => "Join model name.", :optional => true
  attr_reader :first_name, :second_name, :join_table_name, :join_model_name

  def initialize(args, *options)
    super
    @first_name, @second_name = self.first < self.second ? [self.first.underscore , self.second.underscore] : [self.second.underscore, self.first.underscore]
    if self.join_model
      @join_table_name = self.join_model.tableize
      @join_model_name = self.join_model
   else
      @join_table_name = "#{fnp}_#{snp}"
      @join_model_name = "#{fnpc}#{snc}" 
    end
  end

  def create_join_migration 
#    puts "Models are: #{fn} and #{sn}"
    template "migration.rb", "db/migrate/#{Time.now.strftime("%Y%m%d%H%M%S")}_create_#{join_table_name}.rb"
    template "model.rb", "app/models/#{join_model_name.tableize.singularize}.rb"
    insert_hmt(fn, sn, join_table_name)
    insert_hmt(sn, fn, join_table_name)
  end

protected
  def fn; self.first_name; end
  def sn; self.second_name; end
  def fnc; fn.camelize; end
  def snc; sn.camelize; end
  def fnp; fn.pluralize; end
  def snp; sn.pluralize; end
  def fnpc; fnp.camelize; end
  def snpc; snp.camelize; end

  def insert_hmt(model_name, other_model_name, join_table_name)
    filename = "app/models/#{model_name}.rb"
    str =  "has_many :#{join_table_name}\nhas_many :#{other_model_name.pluralize}, :through => :#{join_table_name}" 
    puts "Try to insert into file: #{filename} the following statements:\n\n"
    puts str
    puts "\n"
    insert_into_file filename, :after => "class #{model_name.camelize}.*\n" do
      str
    end
  end
end
