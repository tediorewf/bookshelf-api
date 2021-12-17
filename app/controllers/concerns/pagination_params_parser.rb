module PaginationParamsParser
  extend ActiveSupport::Concern

  DEFAULT_PAGE = 1.freeze
  MAX_PER_PAGE = Rails.application.config.x.pagination.max_per_page.freeze

  ZERO = 0.freeze
  private_constant :ZERO

  def parse_page(page)
    page = page.to_i unless page.is_a?(Integer)
    return page if page > ZERO
    DEFAULT_PAGE
  end

  def parse_per_page(per_page)
    per_page = per_page.to_i unless per_page.is_a?(Integer)
    return per_page if ZERO < per_page && per_page <= MAX_PER_PAGE
    MAX_PER_PAGE
  end
end
