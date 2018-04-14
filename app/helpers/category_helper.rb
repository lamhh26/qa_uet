module CategoryHelper
  def category_link question
    if question.category
      link_to question.category.name.underscore.humanize, category_path(name: question.category.name), class: "qa-category-link"
    else
      link_to "Uncategory", category_path(name: :uncategory), class: "qa-category-link"
    end
  end

  def category_name category
    category ? category.name.underscore.humanize : "Uncategory"
  end
end
