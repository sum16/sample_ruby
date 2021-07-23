require 'webrick'

config = {
    :port => 8099,
    :DocumentRoot => '.',
}

server = WEBrick::HTTPServer.new( config )

trap(:INT) do
    server.shutdown
end

server.start
