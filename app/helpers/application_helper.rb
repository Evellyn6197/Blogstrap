module ApplicationHelper
    def format_date(value)
        l(value, format: "%B %e, %Y").capitalize
    end

    def format_year(value)
        l(value.to_datetime, format: "%B %Y").capitalize
    end

    def render_if(condition, template, record)
        render template, record if condition
    end
end
