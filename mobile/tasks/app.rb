require 'sinatra'
require 'google/cloud/tasks'

set :bind, '0.0.0.0'
port = ENV['PORT'] || '8080'
set :port, port

get '/' do
  name = ENV['NAME'] || 'World'
  "Hello #{name}!"
end

post '/create' do
  # Instantiates a client.
  client = Google::Cloud::Tasks.cloud_tasks

  # Construct the fully qualified queue name.
  parent = client.queue_path project: ENV['CLOUD_PROJECT_NAME'], location: ENV['QUEUE_LOCATION'], queue: ENV['QUEUE_ID']

  # Construct task.
  task = {
    http_request: {
      http_method: 'GET',
      url: ENV['IRRI_API_ENDPOINT']
    }
  }

  # Add payload to task body.
  #   task[:app_engine_http_request][:body] = payload if payload

  # Add scheduled time to task.
  #   if seconds
  #     timestamp = Google::Protobuf::Timestamp.new
  #     timestamp.seconds = Time.now.to_i + seconds.to_i
  #     task[:schedule_time] = timestamp
  #   end

  # Send create task request.
  puts "Sending task #{task}"
  response = client.create_task parent: parent, task: task

  puts "Created task #{response.name}" if response.name
end
