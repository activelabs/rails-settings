class Settings 
  class SettingNotFound < RuntimeError; end
  
  @@config = YAML.load_file("#{RAILS_ROOT}/config/settings.yml")[RAILS_ENV].symbolize_keys
  
  
  
  #get a variable with the variable as the called method
  def self.method_missing(method, *args)
    if self.key?(method.to_sym)
      @@config[method.to_sym]
    else
      raise SettingNotFound, "Setting variable \"#{method.to_s}\" not found"
    end
  end
  
  #destroy the specified settings record
  # def self.destroy(var_name)
  #   var_name = var_name.to_s
  #   if self[var_name]
  #     object(var_name).destroy
  #     true
  #   else
  #     raise SettingNotFound, "Setting variable \"#{var_name}\" not found"
  #   end
  # end

  #retrieve all settings as a hash
  def self.all
    # vars = find(:all, :select => 'var, value')
    #     
    #     result = {}
    #     vars.each do |record|
    #       result[record.var] = record.value
    #     end
    #     result.with_indifferent_access
    @@config
  end
  
  #retrieve a setting value by [] notation
  def self.[](var_name)
    @@config[var_name.to_sym]
  end
  
  #set a setting value by [] notation
  # def self.[]=(var_name, value)
  #   var_name = var_name.to_s
  #   
  #   record = object(var_name) || Settings.new(:var => var_name)
  #   record.value = value
  #   record.save
  # end
  
  #retrieve the actual Setting record
  # def self.object(var_name)
  #   Settings.find_by_var(var_name.to_s)
  # end
  
  #get the value field, YAML decoded
  # def value
  #   YAML::load(self[:value])
  # end
  
  #set the value field, YAML encoded
  # def value=(new_value)
  #   self[:value] = new_value.to_yaml
  # end
  
  #Deprecated!
  def self.reload # :nodoc:
    self
  end
  
  private
  
  def self.key?(key)
    @@config.key?(key)
  end  
  
end
