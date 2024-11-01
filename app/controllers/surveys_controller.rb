class SurveysController < ApplicationController
  # POST /surveys
  def create
    survey = Survey.new(survey_params)

    if survey.save
      render json: survey, status: :created
    else
      render json: { errors: survey.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def survey_params
    params.require(:survey).permit(:feeling, :stress, :comments)
  end
end
