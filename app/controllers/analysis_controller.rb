class AnalysisController < ApplicationController
  def index
    total_surveys = Survey.count
    average_stress = total_surveys.positive? ? Survey.average(:stress).to_f : 0

    render json: { count: total_surveys, average: average_stress }
  end
end
