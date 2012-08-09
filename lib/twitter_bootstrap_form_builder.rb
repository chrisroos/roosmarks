# This is necessary so that we don't get the default 'field_with_errors'
# wrappers around the attributes that caused our object to fail validation
ActionView::Base.field_error_proc = Proc.new{ |html_tag, instance| html_tag.html_safe }

class TwitterBootstrapFormBuilder < ActionView::Helpers::FormBuilder
  def control_group(method, options={}, &block)
    control_group_class = ['control-group']
    control_group_class += ['required'] if options[:required]
    control_group_class += ['error'] if @object.errors[method].any?
    @template.content_tag(:div, class: control_group_class.join(' '), &block)
  end
end