module Converter
    def to_hash
      hash = {}
      self.instance_variables.each { |instance_var| hash[instance_var.to_s.sub("@", "").to_sym] = self.instance_variable_get(instance_var) }
      return hash
    end
end