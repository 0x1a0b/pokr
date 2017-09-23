module RoomsHelper

  def state_class room
    if room.status == Room::DRAW
      "label-default"
    else
      "label-info"
    end
  end

  def render_point_values numbers, room_points, scheme_type
    numbers.inject(''.html_safe) do |html, value|
      html + content_tag(:li) do
        btn_class = if @room.pv.blank?
          "btn btn-info"
        else
         if scheme_type != @room.scheme_type || room_points.include?(value)
            "btn btn-info"
          else
            "btn btn-default"
          end
        end

        tag(:input, class: btn_class, type: 'button', value: value)
      end
    end
  end

end
