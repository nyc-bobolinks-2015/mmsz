module QuestionsHelper

  def separate_tags(tag_names)
    tag_names.split(", ")
  end

  #This looks like model logic for tag
  def create_new_tags(tag_names, question)
    separate_tags(tag_names).map do |tag_name|
      tag_name = tag_name.downcase
      tag = Tag.find_or_create_by(name: tag_name)
      tag.touch
      unless question.tags.include?(tag)
        question.tags << tag
      end
    end
  end

end