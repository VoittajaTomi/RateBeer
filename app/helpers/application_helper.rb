

module ApplicationHelper
  def edit_and_destroy_buttons(item)
    if current_user_signed_in?
      edit = link_to('Edit', url_for([:edit, item]), :class => "btn btn-primary")
      del = link_to('Destroy', item, method: :delete, 
                                     data: {confirm: 'Are you sure?' }, :class => "btn btn-danger")
      raw("#{edit} #{del}")
    end
  end
end