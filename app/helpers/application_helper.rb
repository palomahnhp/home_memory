module ApplicationHelper

  def result(analysis, analytical_item)
    @result = AnalysisResult.by_analysis(analysis).by_analytical_item(analytical_item).take
  end

  def items_by_group(analysis, group)
    @items_by_group = analysis.analytical_items.by_group(group)
  end

  def appointments(patient)
    return patient.histories.appointments
  end

  def histories(patient = '')
    return patient.histories if patient.present?
    History.all
  end


end
