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

  def renew(attributes = {}, options = {})
    merged_attributes = self.renewable_attributes.merge(attributes)
    merged_options = self.renewable_options.merge(options)

    self.class.new(merged_attributes, merged_options)
  end

  protected

  def renewable_attributes
    @renewable_attributes
  end

  def renewable_options
    @renewable_options
  end

  private

  def process_arguments(attributes, options)
    return attributes, options
  end

  def renewable_process_attributes(attributes)
    attributes.each do |name, value|
      self.instance_variable_set(:"@#{name}", value)
    end

    @renewable_attributes = attributes
  end

  def renewable_process_options(options)
    @renewable_options = options
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
