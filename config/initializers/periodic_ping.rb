require 'rufus-scheduler'
require 'net/http'

fetch_interval = '10m'

Thread.new {
  s = Rufus::Scheduler.singleton
  s.every fetch_interval do
    http = Net::HTTP.new('www.faskyn.be',80)
    response = http.request_get('/')
    # puts response.code
  end
}