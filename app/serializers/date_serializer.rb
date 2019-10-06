class DateSerializer
  def initialize(date)
    @date = date
  end

  def json
    {
      data: {
        id: 0,
        attributes: {
          best_day: @date.to_s
        }
      }
    }
  end
end
