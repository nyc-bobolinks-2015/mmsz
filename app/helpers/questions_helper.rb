module QuestionsHelper

  def separate_tags(tag_names)
    tag_names.split(", ")
  end

  def create_new_tags(tag_names, question)
    separate_tags(tag_names).map do |tag_name|
      tag_name = tag_name.downcase
      question.tags.find_or_create_by(name: tag_name)
    end
  end

end
