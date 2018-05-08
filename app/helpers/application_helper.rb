module ApplicationHelper

  def result(analysis, analytical_item)
    @result = AnalysisResult.by_analysis(analysis).by_analytical_item(analytical_item).take
  end

  def items_by_group(analysis, group)
    @items_by_group = analysis.analytical_items.by_group(group)
  end

  def appointments(user, resource)
    return user.send(resource.to_s.pluralize).appointments
  end

  def histories(user = '')
    return user.histories if user.present?
    History.all
  end

  def document_link_name(document)
    ' ' + document.title + ' (' + document.attachment_file_name + ')'
  end

end
