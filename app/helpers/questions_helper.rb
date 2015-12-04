module QuestionsHelper

  def separate_tags(tag_names)
    tag_names.split(", ")
  end

  def create_new_tags(tag_names)
    separate_tags(tag_names).map do |tag_name|
      Tag.new(name: tag_name)
    end
  end

end
