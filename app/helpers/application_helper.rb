module ApplicationHelper


  def page_title(t, options = {})
    options.reverse_merge!({:show_host => true})
    @page_title = @page_title.nil? ? t : t + ' &mdash; ' + @page_title
    @full_page_title = @page_title unless options[:show_host]
  end


  def meta_description(description)
    @meta_tags ||= []
    @meta_tags << tag(:meta, :name => 'description', :content => description)
  end

  def meta_tags
    @meta_tags.try(:join).try(:html_safe)
  end


  def render_simple_flashes
    content_tag(:div, {:id => 'flash-container', :class => 'bottom'}) do
      content_tag(:ul, {:id => 'flash-list'}) do
        ActiveSupport::SafeBuffer.new.tap do |flash_list|
          [:notice, :error, :success].each do |category|
            flash.now[category] ||= []
            flash.now[category] = [flash.now[category]] if flash.now[category].is_a? String
            flash.now[category].each do |message|
              flash_list << content_tag(:li, {:class => "flash-#{category} alert"}) do
                [content_tag(:a, "&#215;".html_safe, :class => 'close', :'data-dismiss' => 'alert'),
                 message].join.html_safe
              end
            end
          end
        end
      end
    end
  end
end
