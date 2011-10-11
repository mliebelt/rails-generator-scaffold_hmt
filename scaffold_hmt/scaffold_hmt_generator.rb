class ScaffoldHmtGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  argument :first_name, :type => :string, :description => "Model name of the first part of the join model." 
  argument :second_name, :type => :string, :description => "Model name of the second part of the join model." 

  def initialize(args, *options)
    super
  end

  def create_join_migration 
##    generate("migration", "create_#{name.pluralize}_#{second_name.pluralize} #{name}_id:integer #{second_name}_id:integer")
    template "migration.rb", "db/migrate/#{Time.now.strftime("%Y%m%d%H%M%S")}_create_#{fnp}_#{snp}.rb"
    template "model.rb", "app/models/#{fn}_#{sn}.rb"
    insert_hmt(fn, jmn)
    insert_hmt(sn, jmn)
  end

protected
  def fn; self.first_name.underscore; end
  def sn; self.second_name.underscore; end
  def fnc; self.first_name.underscore.capitalize; end
  def snc; self.second_name.underscore.capitalize; end
  def fnp; self.first_name.underscore.pluralize; end
  def snp; self.second_name.underscore.pluralize; end
  def fnpc; self.first_name.underscore.pluralize.capitalize; end
  def snpc; self.second_name.underscore.pluralize.capitalize; end
  def jmn; "#{fn}_#{sn}"; end

  def insert_hmt(model_name, join_model_name)
    fn = "app/models/#{model_name}.rb"
    str =  "has_many :#{jmn}\nhas_many :#{model_name}, :through => :#{jmn}" 
    puts "Try to insert into file: #{fn} the following statements:\n\n"
    puts str
    insert_into_file fn, :after => "class #{model_name.capitalize}.*\n" do
      str
    end
  end
end
