# frozen_string_literal: true

require 'sinatra'
require 'sinatra/namespace'
require 'google/cloud/tasks'
require 'json'

set :bind, '0.0.0.0'
port = ENV['PORT'] || '8080'
set :port, port

helpers do
  def base_url
    @base_url ||= "#{request.env['rack.url_scheme']}://{request.env['HTTP_HOST']}"
  end

  def json_params
    JSON.parse(request.body.read)
  rescue StandardError
    halt 400, { message: 'Invalid JSON' }.to_json
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
    parent = client.queue_path project: ENV['CLOUD_PROJECT_NAME'],
                               location: ENV['QUEUE_LOCATION'], queue: ENV['QUEUE_ID']

    # Construct task.
    end_point = payload['endpoint']
    task = {
      http_request: {
        http_method: 'POST',
        url: "https://#{ENV['IRRI_API_ENDPOINT']}/#{end_point}"
      }
    }

    # Add payload to task body.
    task[:http_request][:body] = payload.to_json

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
    puts response

    puts "Created task #{response.name}" if response.name
    status 200
    body {'name' => "#{response.name}"}.to_json
  end
end
