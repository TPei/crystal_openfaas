require "json"

class Handler
  def run(req : String)
    return JSON::Any.new("Hello, Crystal. You said: #{req}")
  end
end
