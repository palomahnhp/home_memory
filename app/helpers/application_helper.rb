module ApplicationHelper
  def result(analysis, analytical_item)
    result = AnalysisResult.by_analysis(analysis).by_analytical_item(analytical_item).take

    @result = { amount: result.amount }
    @result[:unit] = result.unit
    @result[:level] = result.level
    @result[:grade] = result.grade
    @result
  end
end
