module ApplicationHelper


  def page_title(t, options = {})
    options.reverse_merge!({:show_host => true})
    @page_title = @page_title.nil? ? t : t + ' &mdash; ' + @page_title
    @full_page_title = @page_title unless options[:show_host]
  end


end
