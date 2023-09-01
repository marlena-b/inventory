# frozen_string_literal: true

class FindProducts
  def initialize(params)
    @search_term = params[:search_term]
    @category_id = params[:category_id]
    @low_level = params[:low_level]
  end

  def call
    query = Product.all
    query = apply_search(query)
    query = by_category(query)
    query = by_low_level(query)

    query.order(updated_at: :desc).includes(:category, :stocks, image_attachment: :blob)
  end

  private

  def apply_search(query)
    return query if @search_term.blank?

    query.where('name ILIKE :term OR sku ILIKE :term', term: "%#{@search_term}%")
  end

  def by_category(query)
    return query if @category_id.blank?

    query.where(category: @category_id)
  end

  def by_low_level(query)
    return query unless @low_level == '1'

    query.joins(:stocks).where('stocks.quantity <= stocks.low_level')
  end
end
