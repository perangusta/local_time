module LocalTimeHelper
  def local_date(time_or_date, format: :default, **options)
    # we ensure to fallback to :default
    return options[:default] unless time_or_date

    # we ensure the format will be of correct type
    # we ensure we have an UTC formatted time
    # we ensure there is at least a formatted value (if javascript fails)
    # we ensure to fallback to :default
    value = ::I18n.l(time_or_date, format: format, default: options[:default])
    type  = time_or_date.is_a?(Date) ? :date : :time
    time  = utc_time(time_or_date)

    format = ::I18n.get_date_format(type: type, format: format)

    options[:data] ||= {}
    options[:data].merge! local: type, format: format

    time_tag time, value, options
  end

  alias_method :local_time, :local_date

  def utc_time(time_or_date)
    if time_or_date.respond_to?(:in_time_zone)
      time_or_date.in_time_zone.utc
    else
      time_or_date.to_time.utc
    end
  end
end
