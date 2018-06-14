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

  def medical_comming(user) # first.model_name.name
    comming = []
    user.histories.pending.each do |history|
      path = "histories/#{history.id}"
      comming << ['history', path, history.id, history.reason, history.event_at,
                  history.professional&.full_name, history.medical_center&.name,
                  history.location]
    end
    user.histories.each do |history|
      history.medical_tests.pending.each do |test|
        path = "medical_tests/#{test.id}"
        comming <<  ['medical_test', path, test.id, test.name, test.performed_at,
        test.history.professional&.full_name, test.medical_center.name,
        test.performed_in]
      end
    end
    comming.sort_by{ |item| item[4] }
  end

  def amount_result(result)
    amount_result = result.result.present? ? result.result : result.amount.to_s
    amount_result + ' ' + @result.unit.to_s
  end
end
