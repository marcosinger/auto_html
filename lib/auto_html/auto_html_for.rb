module AutoHtmlFor

  # default options that can be overridden on the global level
   @@auto_html_for_options = {
    :htmlized_attribute_suffix => '_html'
  }
  
  mattr_reader :auto_html_for_options

  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def auto_html_for(raw_attrs, &proc)
      include AutoHtmlFor::InstanceMethods
      before_save :auto_html_prepare

      define_method("auto_html_prepare") do
        auto_html_methods = self.methods.select { |m| m=~/^auto_html_prepare_/ }
        auto_html_methods.each do |method|
          self.send(method)
        end
      end

      raw_attrs = { raw_attrs => AutoHtmlFor.auto_html_for_options[:htmlized_attribute_suffix] } unless raw_attrs.is_a?(Hash)
      
      raw_attrs.each do |raw_attr, suffix|
        method_name = "#{raw_attr}#{suffix}"
        
        define_method("#{method_name}=") do |val|
          # att_ - hack for mongoid > 2.1
          write_attribute("attr_#{method_name}", val)
        end
        define_method("#{method_name}") do
          # att_ - hack for mongoid > 2.1
          read_attribute("attr_#{method_name}") || send("auto_html_prepare_#{method_name}")
        end
        define_method("auto_html_prepare_#{method_name}") do
          self.send(raw_attr.to_s + suffix + "=", auto_html(self.send(raw_attr), &proc))
        end
      end
    end
  end

  module InstanceMethods
    include AutoHtml
  end
end