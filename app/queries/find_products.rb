class FindProducts
  def initialize(params)
   @search_term = params[:search_term]
   @category = params[:category]
  end

  def call
    query = Product.all
    query = apply_search(query)
    query = by_category(query)

    query.order(updated_at: :desc).includes(:category, :stocks, image_attachment: :blob)
  end

  private

  def apply_search(query)
    return query unless @search_term

    query.where('name ILIKE :term OR sku ILIKE :term', term: "%#{@search_term}%")
  end

  def by_category(query)
    return query unless @category

    query.where(category: @category)
  end
end
