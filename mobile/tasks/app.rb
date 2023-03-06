require 'sinatra'
require "sinatra/namespace"
require 'google/cloud/tasks'

set :bind, 'localhost'
port = ENV['PORT'] || '8080'
set :port, port

helpers do
  def base_url
    @base_url ||= "#{request.env['rack.url_scheme']}://{request.env['HTTP_HOST']}"
  end

  def json_params
    begin
      JSON.parse(request.body.read)
    rescue
      halt 400, { message:'Invalid JSON' }.to_json
    end
  end
end

namespace '/api/v1' do

  before do
    content_type 'application/json'
  end

  get '/' do
    'Welcome to BookList!'
  end


  post '/create' do
    payload = json_params
    puts payload
  
    # Instantiates a client.
    client = Google::Cloud::Tasks.cloud_tasks
  
    # Construct the fully qualified queue name.
    parent = client.queue_path project: ENV['CLOUD_PROJECT_NAME'], location: ENV['QUEUE_LOCATION'], queue: ENV['QUEUE_ID']
  
    # Construct task.
    task = {
      http_request: {
        http_method: 'GET',
        url: 'https://apiwrapper-5rvb357uza-uc.a.run.app/run_group'
      }
    }
  
    # Add payload to task body.
    task[:http_request][:body] = payload if payload
  
    # Add scheduled time to task.
    delay = payload['delay']
    if delay
      timestamp = Google::Protobuf::Timestamp.new
      timestamp.seconds = Time.now.to_i + delay.to_i
      task[:schedule_time] = timestamp
    end
  
    # Send create task request.
    puts "Sending task #{task}"
    response = client.create_task parent: parent, task: task
  
    puts "Created task #{response.name}" if response.name
  end
end