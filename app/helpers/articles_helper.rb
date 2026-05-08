module ArticlesHelper
  def format_date(datetime)
		l(datetime, format: '%B %e, %Y').capitalize
  end
end
