module ApplicationHelper

  def result(analysis, analytical_item)
    @result = AnalysisResult.by_analysis(analysis).by_analytical_item(analytical_item).take
  end

  def items_by_group(analysis, group)
    @items_by_group = analysis.analytical_items.by_group(group)
  end


end
