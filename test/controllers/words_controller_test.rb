require 'test_helper'

class WordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @word = words(:one)
  end

  test "should get index" do
    get words_url
    assert_response :success
  end

  test "should get new" do
    get new_word_url
    assert_response :success
  end

  test "should create word" do
    assert_difference('Word.count') do
      post words_url, params: { word: { answer: @word.answer, id: @word.id, option_1: @word.option_1, option_2: @word.option_2, option_3: @word.option_3, option_4: @word.option_4 } }
    end

    assert_redirected_to word_url(Word.last)
  end

  test "should show word" do
    get word_url(@word)
    assert_response :success
  end

  test "should get edit" do
    get edit_word_url(@word)
    assert_response :success
  end

  test "should update word" do
    patch word_url(@word), params: { word: { answer: @word.answer, id: @word.id, option_1: @word.option_1, option_2: @word.option_2, option_3: @word.option_3, option_4: @word.option_4 } }
    assert_redirected_to word_url(@word)
  end

  test "should destroy word" do
    assert_difference('Word.count', -1) do
      delete word_url(@word)
    end

    assert_redirected_to words_url
  end
end
