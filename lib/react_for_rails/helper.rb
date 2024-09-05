module ReactForRails
  module Helper
    def react_component(name, options = {})
      props = options[:props] || {}
      props_json = ERB::Util.json_escape(props.is_a?(String) ? props : props.to_json)
  
      id = "react-component-#{SecureRandom.hex(8)}"
  
      html_options = options[:html_options] || {}
      html_options[:id] = id
  
      content_tag(:div, "", html_options) +
        content_tag(
          :script,
          props_json.html_safe,
          type: "application/json",
          "data-dom-id" => id,
          "data-component-name" => name,
          class: "custom-react-component-render"
        )
    end
  end
end