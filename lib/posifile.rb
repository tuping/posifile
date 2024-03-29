require 'errors'
class Posifile

  INVALID_CHARS = " !@#$\%*()-\&\'\"<>.,;:[]{}\'\`^+\\/"

  @@specifications = {}
  @@conditions = {}
  @@attr_names = {}
  @@pos_attr = {}

  attr_accessor :data_file, :raw_content

  def initialize(data_file_name_or_text)
    if data_file_name_or_text.class == String
      @data_file = data_file_name_or_text
    elsif data_file_name_or_text .class == Hash
      @file_content = [data_file_name_or_text[:text]]
    else
      raise InvalidPositionFileFormat, "Pass a file path or text."
    end

    check_specification_hash
    file_content.each do |line|
      if file_content.length == 1
        build_attributes_from_hash(@@specifications[class_name][0], line, nil)
      else
        specification_index(line) do |line_, index|
          build_attributes_from_hash(@@specifications[class_name][index], line_, @@attr_names[class_name][index])
        end
      end
    end
  end

  def self.set_specification(hash)
    if valid_names?(hash)
      @@specifications[class_name] ||= []
      @@specifications[class_name] << hash
    else
      raise InvalidFieldName, "Fields names contain invalid characteres for method names."
    end
  end

  def self.lines_where(range,value, &block)
    @@attr_names[class_name] ||= []
    length_before = @@attr_names[class_name].length
    @@conditions[class_name] ||= []
    @@conditions[class_name] << { range => value }
    yield
    length_after = @@attr_names[class_name].length
    if length_before == length_after
      @@attr_names[class_name] << nil
    end
    section_code_hash = { "section_code" => range }
    if @@specifications[class_name]
      @@specifications[class_name].last.merge!(section_code_hash)
    end
  end

  def self.set_attr_name(attr_name)
    @@attr_names[class_name] ||= []
    @@attr_names[class_name] << attr_name
  end

  def self.valid_names?(hash)
    check = true
    hash.each_key do |key|
      key.split('').each do |letter|
        unless letter.downcase == letter
          check = false
        end
        if INVALID_CHARS.split("").include?(letter)
          check = false
        end
      end
    end

    check
  end

  def self.valid_specification?
    not gap_in_specification?(@@specifications[class_name]) || overlap_in_specification?(@@specifications[class_name])
  end

  def self.overlap_in_specification?(spec_array)
    num_ar = []
    spec_array.each_with_index do |spec, index|
      spec.each_value do |range|
        range.each do |item|
          num_ar[index] ||= []
          num_ar[index][item] ||= 0
          num_ar[index][item] += 1
        end
      end
    end
    valid = false
    num_ar.each do |array|
      if array.include?(2)
        valid = true
      end
    end
    valid
  end

  def self.gap_in_specification?(spec_array)
    num_ar = []
    spec_array.each_with_index do |spec, index|
      spec.each_value do |range|
        range.each do |item|
          num_ar[index] ||= []
          num_ar[index][item] ||= 0
          num_ar[index][item] += 1
        end
      end
    end
    valid = false
    num_ar.each do |array|
      if array.include? nil
        valid = true
      end
    end
    valid
  end

  def self.higher
    higher_number = 0
    @@specifications[class_name][0].each_value do |range|
      if range.max > higher_number
          higher_number = range.max
      end
    end
    higher_number
  end

  def self.class_name
    name = self
    while name.superclass != Posifile
      name = name.superclass
    end
  
    name
  end

  def class_name
    name = self.class
    while name.superclass != Posifile
      name = name.superclass
    end
  
    name
  end

  def check_specification_hash
    if @@specifications[class_name].nil?
      raise FieldsNotSpecified, "You should call set_specifications in you model, so we can build the object with the corresponding attribuites. Check documentation on how to do so."
    end
  end

  def specification_index(line)
    i = 0
    if @@conditions[class_name]
      @@conditions[class_name].each_with_index do |hash, num|
        if check_condition(hash,line)
          yield line, num
        end
      end
    end
    i
  end

  # Checks if a given line matches the line_where condition declare in the class
  def check_condition(condition_hash, line)
    line[condition_hash.keys.first] == condition_hash.values.first
  end

  def file_content
    if @data_file
      if raw_content.nil?
        file = File.open(@data_file, "r")
        @raw_content = file.readlines
      end
      return @raw_content
    else
      @file_content
    end
  end

  # Get the value of a specifc position declared in the specification hash
  def field_value(field_name, specification_hash, line)
    field_name = field_name.to_s
    content_ar = line.split('')
    value_str = ''
    if !specification_hash.keys.include? field_name 
      raise InvalidAttrName, "The specified attr name was not found in the specification hash."
    else
      range = specification_hash[field_name]
      range.each do |n|
        value_str.concat content_ar[n]
      end
      value_str.strip
    end
  end

  def pos_attributes
    @@pos_attr[class_name]
  end

  def add_method_to_pos_attr(field)
    @@pos_attr[class_name] ||= []
    unless @@pos_attr[class_name].include? field
      @@pos_attr[class_name] << field
    end
  end

  # Once the name is gonna be used as method name, 
  # this changes the name when it contains invalid characters. 
  def change_name(original)
    original.gsub!(' ','_')
    INVALID_CHARS.split('').each do |char|
      original.gsub!(char,'')
    end
    original.downcase
  end

  def build_attributes_from_hash(specification_hash, line, attr_name)
    if attr_name
      values_hash = {}
      specification_hash.keys.map do |key|
        values_hash[key] = field_value(key, specification_hash, line )
      end

      method_name = change_name(field_value(attr_name, specification_hash, line))

      add_method_to_pos_attr(method_name)
      self.instance_eval "
        def #{method_name}\n
          #{values_hash.inspect}\n
        end
      "
    else
      specification_hash.each_key do |key|
        add_method_to_pos_attr(key)
        self.instance_eval "
          def #{key}
            \"#{field_value(key, specification_hash, line)}\"
          end
        "
      end
    end
  end

end
