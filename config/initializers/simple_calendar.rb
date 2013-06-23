SimpleCalendar::ViewHelpers.class_eval do

  def month_header(selected_month, options)
    content_tag :h2 do
      previous_month = selected_month.advance :months => -1
      next_month = selected_month.advance :months => 1
      tags = []
      tags << '<div class="ourscal-nav">'
      tags << month_link(options[:prev_text], previous_month, options[:params], {:class => "previous-month"})
      tags << " #{I18n.t("date.month_names")[selected_month.month]} #{selected_month.year} "
      tags << month_link(options[:next_text], next_month, options[:params], {:class => "next-month"})
      tags << '</div>'

      tags.join.html_safe
    end
  end

end