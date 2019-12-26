module ApplicationHelper
  HTTP_CREATED = 201
  HTTP_OK = 200
  HTTP_BAD_REQUEST = 400
  HTTP_NOT_FOUND = 404
  HTTP_UNAUTHORIZED = 401

  def error_response_without_obj(code, message)
    render json: {
      status: {
        code: code,
        message: message
      }
    }
  end

  def success_response(code, msg)
    render json: {
      status: {
        code: code,
        message: msg
      }
    }
  end

  def success_response_with_object(obj, message)
    render json: {
      status: {
        code: HTTP_CREATED,
        message: message
      },
      data: obj.present? ? obj : {}
    }
  end

  def success_response_with_message(obj, message)
    render json: {
      status: {
        code: HTTP_CREATED,
        message: message + ' '+ "#{obj[:email]}"
      },
      data: obj.present? ? obj : {}
    }
  end
end