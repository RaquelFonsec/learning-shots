module ApplicationHelper
  def flash_messages
    capture do
        flash.each do |key, value|
        concat tag.div(
            data: {
            controller: :hello, hello_key: key, hello_value: value
            }
        )
        end
    end
    end
  end
