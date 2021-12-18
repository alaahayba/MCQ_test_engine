require 'test_helper'

class TopicsExamsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @topics_exam = topics_exams(:one)
  end

  test "should get index" do
    get topics_exams_url
    assert_response :success
  end

  test "should get new" do
    get new_topics_exam_url
    assert_response :success
  end

  test "should create topics_exam" do
    assert_difference('TopicsExam.count') do
      post topics_exams_url, params: { topics_exam: { answers: @topics_exam.answers, questions: @topics_exam.questions, topic_name: @topics_exam.topic_name } }
    end

    assert_redirected_to topics_exam_url(TopicsExam.last)
  end

  test "should show topics_exam" do
    get topics_exam_url(@topics_exam)
    assert_response :success
  end

  test "should get edit" do
    get edit_topics_exam_url(@topics_exam)
    assert_response :success
  end

  test "should update topics_exam" do
    patch topics_exam_url(@topics_exam), params: { topics_exam: { answers: @topics_exam.answers, questions: @topics_exam.questions, topic_name: @topics_exam.topic_name } }
    assert_redirected_to topics_exam_url(@topics_exam)
  end

  test "should destroy topics_exam" do
    assert_difference('TopicsExam.count', -1) do
      delete topics_exam_url(@topics_exam)
    end

    assert_redirected_to topics_exams_url
  end
end
