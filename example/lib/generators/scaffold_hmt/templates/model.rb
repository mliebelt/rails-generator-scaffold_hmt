class <%= join_model_name %> < ActiveRecord::Base
  belongs_to :<%= fn %>
  belongs_to :<%= sn %>
end
