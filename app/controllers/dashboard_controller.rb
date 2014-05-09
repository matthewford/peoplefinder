class DashboardController < ApplicationController

  before_filter :load_questions_service

  def index
    @questions = @questions_service.questions()
  end

  protected

  def load_questions_service(service = QuestionsService.new)
    @questions_service ||= service
  end

end