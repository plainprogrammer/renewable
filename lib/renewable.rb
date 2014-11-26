require 'renewable/version'

module Renewable
  def initialize(attributes = {}, options = {})
    attributes, options = process_arguments(attributes.dup, options.dup)
    renewable_process_attributes(attributes)
    renewable_process_options(options)
    attributes, options = before_freeze(attributes, options)
    self.freeze
    after_freeze(attributes, options)
  end

  protected

  # def renewable_attributes
  #   @renwable_attributes
  # end

  # def renewable_options
  #   @renwable_options
  # end

  private

  def process_arguments(attributes, options)
    return attributes, options
  end

  def renewable_process_attributes(attributes)
    attributes.each do |name, value|
      self.instance_variable_set(:"@#{name}", value)
    end

    #@renwable_attributes = attributes
  end

  def renewable_process_options(options)
    #@renwable_options = options
  end

  def before_freeze(attributes, options)
    return attributes, options
  end

  def after_freeze(attributes, options)
    return attributes, options
  end
end

class Renewable::Object
  include ::Renewable
end
