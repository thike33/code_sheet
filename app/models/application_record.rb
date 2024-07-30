class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  # 指定された属性名と値を人間が読みやすい形式の属性名を返す
  def self.human_attribute_enum_value(attr_name, value)
    return if value.blank?
    human_attribute_name("#{attr_name}.#{value}")
  end

  # 指定された列挙型の属性名に基づき、その選択肢をハッシュに変換
  def self.enum_options_for_select(attr_name)
    self.send(attr_name.to_s.pluralize).map { |k, _| [self.human_attribute_enum_value(attr_name, k), k] }.to_h
  end
end
