module ApplicationHelper
  
  def edit_and_destroy_buttons(item)
    if current_user.admin == true
      edit = link_to('Edit', url_for([:edit, item]), class:"btn btn-primary")
      del = link_to('Destroy', item, method: :delete,
                    data: {confirm: 'Are you sure?' }, class:"btn btn-danger")
      raw("#{edit} #{del}")
    else
      edit = link_to('Edit', url_for([:edit, item]), class:"btn btn-primary")
      raw("#{edit}")
    end
  end

  def round(param)
  	number_with_precision(param, precision: 2)  
  end

end