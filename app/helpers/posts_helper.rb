module PostsHelper
  def link_to_remove_post(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields_post(this)")
  end
  
  def link_to_add_fields_post(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, "add_fields_post(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
  end
  
  def post_type_for(post)
    if post.blank?
      return ' '
    else
      return post.post_type
    end
  end
end
