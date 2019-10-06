class RevenueSerializer
  def initialize(revenue)
    @revenue = revenue
  end

  def json
    {
      data: {
        id: 0,
        attributes: {
          revenue: @revenue.to_s
        }
      }
    }
  end
end
