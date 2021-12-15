require 'test_helper'

class PaginationParamsParserTest < Minitest::Test
  include PaginationParamsParser

  def test_parse_page_should_works_like_to_i_for_positive_numbers_string_representation
    page = parse_page('777')

    assert_equal '777'.to_i, page
  end
  
  def test_parse_page_should_return_default_page_for_negative_number_string_representation
    page = parse_page('-1')

    assert_equal DEFAULT_PAGE, page
  end

  def test_parse_page_should_return_default_page_for_nil
    page = parse_page(nil)

    assert_equal DEFAULT_PAGE, page
  end

  def test_parse_page_should_return_default_page_for_empty_string
    page = parse_page('')

    assert_equal DEFAULT_PAGE, page
  end

  def test_parse_per_page_should_works_like_to_i_for_positive_number_string_representation_which_is_less_then_or_equal_to_max_per_page
    number = rand(DEFAULT_PAGE..MAX_PER_PAGE)
    number_string_representation = number.to_s

    page = parse_per_page(number_string_representation)

    assert_equal number_string_representation.to_i, page
  end

  def test_parse_per_page_should_return_max_per_page_for_positive_number_string_representation_which_is_greater_then_max_per_page
    number = rand(MAX_PER_PAGE+1..MAX_PER_PAGE*2)
    number_string_representation = number.to_s

    page = parse_per_page(number_string_representation)

    assert_equal MAX_PER_PAGE, page
  end

  def test_parse_per_page_should_return_max_per_page_for_negative_number_string_representation
    page = parse_per_page('-666')

    assert_equal MAX_PER_PAGE, page
  end
end
