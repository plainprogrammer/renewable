require 'date'
require 'renewable'

class InheritedPerson < Renewable::Object
  attr_accessor :name, :birth_date

  def age
    Date.today.year - Date.parse(birth_date.to_s).year
  end

  private

  def process_arguments(attributes, options)
    if options[:raise_process_arguments]
      raise ArgumentError, 'entered process_arguments with raise option'
    end

    return attributes, options
  end

  def before_freeze(attributes, options)
    if options[:raise_before_freeze]
      raise ArgumentError, 'entered before_freeze with raise option'
    end

    return attributes, options
  end

  def after_freeze(attributes, options)
    if options[:raise_after_freeze]
      raise ArgumentError, 'entered after_freeze with raise option'
    end
  end
end