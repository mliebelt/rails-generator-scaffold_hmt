class ScaffoldHmtGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  argument :first, :type => :string, :description => "Model name of the first part of the join model." 
  argument :second, :type => :string, :description => "Model name of the second part of the join model." 
  attr_reader :first_name, :second_name

  def initialize(args, *options)
    super
    @first_name, @second_name = self.first < self.second ? [self.first.underscore , self.second.underscore] : [self.second.underscore, self.first.underscore]
  end

  def create_join_migration 
#    puts "Models are: #{fn} and #{sn}"
    template "migration.rb", "db/migrate/#{Time.now.strftime("%Y%m%d%H%M%S")}_create_#{fnp}_#{snp}.rb"
    template "model.rb", "app/models/#{fnp}_#{sn}.rb"
    insert_hmt(fn, sn, jtn)
    insert_hmt(sn, fn, jtn)
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
  def jtn; "#{fnp}_#{snp}"; end

  def insert_hmt(model_name, other_model_name, join_table_name)
    filename = "app/models/#{model_name}.rb"
    str =  "has_many :#{join_table_name}\nhas_many :#{other_model_name.pluralize}, :through => :#{join_table_name}" 
    puts "Try to insert into file: #{filename} the following statements:\n\n"
    puts str
    puts "\n\n"
    insert_into_file filename, :after => "class #{model_name.camelize}.*\n" do
      str
    end
  end
end
